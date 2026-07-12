/obj/item/organ/brain/drask
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'

/obj/item/organ/eyes/drask
	name = "drask eyeballs"
	desc = "Глаза синеватого оттенка, но по своей структуре - глаза обычного гуманоида."
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	synchronized_blinking = FALSE
	eye_icon = 'icons/bandastation/mob/species/drask/drask_eyes.dmi'
	eye_icon_state = "drask_eyes"
	lighting_cutoff = LIGHTING_CUTOFF_REAL_LOW
	flash_protect = FLASH_PROTECTION_SENSITIVE
	// Задаём позиции дополнительных глаз – для драска это один центральный глаз
	extra_eye_positions = list("c")
	// Список объектов век для дополнительных глаз
	var/list/obj/effect/abstract/eyelid_effect/eyelid_extras = list()

/obj/item/organ/eyes/drask/on_mob_insert(mob/living/carbon/eyes_owner)
	. = ..()
	ADD_TRAIT(eyes_owner, TRAIT_LUMINESCENT_EYES, ORGAN_TRAIT)
	// Запускаем первый цикл моргания сразу после вставки
	if(ishuman(eyes_owner))
		animate_eyelids(eyes_owner)

/obj/item/organ/eyes/drask/on_mob_remove(mob/living/carbon/eyes_owner)
	. = ..()
	REMOVE_TRAIT(eyes_owner, TRAIT_LUMINESCENT_EYES, ORGAN_TRAIT)
	if(ishuman(eyes_owner))
		var/mob/living/carbon/human/human_owner = eyes_owner
		// Удаляем все веки из vis_contents
		if(eyelid_left)
			human_owner.vis_contents -= eyelid_left
		if(eyelid_right)
			human_owner.vis_contents -= eyelid_right
		for(var/obj/effect/abstract/eyelid_effect/eyelid in eyelid_extras)
			human_owner.vis_contents -= eyelid

/obj/item/organ/eyes/drask/Initialize(mapload)
	. = ..()
	if(blink_animation)
		// Удаляем старые веки (если есть)
		QDEL_NULL(eyelid_left)
		QDEL_NULL(eyelid_right)
		QDEL_LIST(eyelid_extras) // очищаем список и удаляем объекты

		// Создаём левое и правое веко (как обычно)
		eyelid_left = new(src, "[eye_icon_state]_l", eye_icon)
		eyelid_right = new(src, "[eye_icon_state]_r", eye_icon)

		// Создаём веки для всех дополнительных глаз
		for(var/suffix in extra_eye_positions)
			var/obj/effect/abstract/eyelid_effect/new_eyelid = new(src, "[eye_icon_state]_[suffix]", eye_icon)
			eyelid_extras += new_eyelid

/obj/item/organ/eyes/drask/Destroy()
	QDEL_LIST(eyelid_extras) // удаляем все дополнительные веки
	return ..()

// ---- Хуки для дополнительных глаз ----

/obj/item/organ/eyes/drask/get_extra_eye_overlays(obj/item/bodypart/head/my_head)
	var/list/overlays = list()
	for(var/suffix in extra_eye_positions)
		var/mutable_appearance/eye = mutable_appearance(eye_icon, "[eye_icon_state]_[suffix]", -EYES_LAYER)
		eye.dir = my_head.owner ? null : SOUTH
		if(my_head.head_flags & HEAD_EYECOLOR)
			// Используем цвет левого глаза для всех дополнительных (можно заменить на логику по желанию)
			eye.color = my_head.owner?.get_left_eye_color() || eye_color_left
		overlays += eye
	return overlays

/obj/item/organ/eyes/drask/get_extra_emissive_overlays(atom/spokesman)
	var/list/overlays = list()
	var/emissive_effect
	if((owner && HAS_TRAIT(owner, TRAIT_LUMINESCENT_EYES)) || (TRAIT_LUMINESCENT_EYES in organ_traits))
		emissive_effect = EMISSIVE_BLOOM
	else if((owner && HAS_TRAIT(owner, TRAIT_REFLECTIVE_EYES)) || (TRAIT_REFLECTIVE_EYES in organ_traits))
		emissive_effect = EMISSIVE_SPECULAR

	for(var/suffix in extra_eye_positions)
		if(emissive_effect)
			overlays += emissive_appearance(eye_icon, "[eye_icon_state]_[suffix]", spokesman, -EYES_LAYER, effect_type = emissive_effect)
		else
			overlays += emissive_blocker(eye_icon, "[eye_icon_state]_[suffix]", spokesman, -EYES_LAYER)
	return overlays

/obj/item/organ/eyes/drask/get_extra_eyelid_overlays(obj/item/bodypart/head/my_head)
	var/mob/living/carbon/human/parent = my_head.owner
	if(isnull(parent) || IS_ROBOTIC_ORGAN(src) || !my_head.draw_color || HAS_TRAIT(parent, TRAIT_NO_EYELIDS))
		return list()
	if(!parent.appears_alive() || HAS_TRAIT(parent, TRAIT_KNOCKEDOUT) || !blink_animation || HAS_TRAIT(parent, TRAIT_PREVENT_BLINKING))
		return list()

	var/list/base_color = rgb2num(my_head.draw_color, COLORSPACE_HSL)
	base_color[2] *= 0.85
	base_color[3] *= 0.85
	var/eyelid_color = rgb(base_color[1], base_color[2], base_color[3], (length(base_color) >= 4 ? base_color[4] : null), COLORSPACE_HSL)

	var/list/overlays = list()
	for(var/i in 1 to length(eyelid_extras))
		var/obj/effect/abstract/eyelid_effect/eyelid = eyelid_extras[i]
		eyelid.color = eyelid_color
		eyelid.render_target = "*[REF(parent)]_eyelid_extra_[i]"
		parent.vis_contents += eyelid

		var/mutable_appearance/eyelid_overlay = mutable_appearance(layer = -EYES_LAYER, offset_spokesman = parent)
		eyelid_overlay.render_source = "*[REF(parent)]_eyelid_extra_[i]"
		overlays += eyelid_overlay

	return overlays

/obj/item/organ/eyes/drask/animate_extra_eyelids(mob/living/carbon/human/parent, sync_blinking)
	for(var/obj/effect/abstract/eyelid_effect/eyelid in eyelid_extras)
		// Анимируем каждое веко, синхронизируя с основными (или нет)
		animate_eyelid(eyelid, parent, sync_blinking)

/obj/item/organ/eyes/drask/blink_extra_eyelids(duration, restart_animation)
	if(!length(eyelid_extras))
		return
	// Принудительное моргание для всех дополнительных век
	for(var/obj/effect/abstract/eyelid_effect/eyelid in eyelid_extras)
		animate(eyelid, alpha = 0, time = 0)
		animate(alpha = 255, time = 0)
		animate(time = duration)
		animate(alpha = 0, time = 0)
	if(restart_animation)
		addtimer(CALLBACK(src, PROC_REF(animate_extra_eyelids), owner, synchronized_blinking), duration)

// Остальные органы (мозг, язык, сердце, лёгкие и т.д.) остаются без изменений

/obj/item/organ/tongue/drask
	name = "drask tongue"
	desc = "Склизкий язык drask."
	say_mod = "гудит"
	modifies_speech = TRUE
	languages_native = list(/datum/language/qurvolious)
	liked_foodtypes = DAIRY
	toxic_foodtypes = ALCOHOL | SUGAR
	var/static/list/speech_replacements = list(
		new /regex("o+", "g") = "oo",
		new /regex("O+", "g") = "OO",
		new /regex("u+", "g") = "uu",
		new /regex("U+", "g") = "UU",
		new /regex("m+", "g") = "mm",
		new /regex("M+", "g") = "MM",
		new /regex("о+", "g") = "оо",
		new /regex("О+", "g") = "ОО",
		new /regex("у+", "g") = "уу",
		new /regex("У+", "g") = "УУ",
		new /regex("м+", "g") = "мм",
		new /regex("М+", "g") = "ММ",
	)

/obj/item/organ/tongue/drask/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/speechmod,\
		replacements = speech_replacements,\
		should_modify_speech = CALLBACK(src, PROC_REF(should_modify_speech))\
	)

/obj/item/organ/tongue/get_possible_languages()
	return ..() + /datum/language/qurvolious

/obj/item/organ/heart/drask
	name = "drask heart"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	zone = BODY_ZONE_HEAD

/obj/item/organ/lungs/drask
	name = "drask lungs"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'

/obj/item/organ/stomach/drask
	name = "drask stomach"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'

/obj/item/organ/liver/drask
	name = "drask liver"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	alcohol_tolerance = ALCOHOL_RATE * 4
