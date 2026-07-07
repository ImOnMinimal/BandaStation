/obj/item/organ/brain/drask
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'

/obj/item/organ/eyes/drask
	name = "drask eyeballs"
	desc = "Глаза синеватого оттенка, но по своей структуре - глаза обычного гуманоида."
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	synchronized_blinking = FALSE
	eye_icon_state = "skrell_eyes"
	lighting_cutoff = LIGHTING_CUTOFF_REAL_LOW
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/eyes/drask/on_mob_insert(mob/living/carbon/eyes_owner)
	. = ..()
	ADD_TRAIT(eyes_owner, TRAIT_LUMINESCENT_EYES, ORGAN_TRAIT)

/obj/item/organ/eyes/drask/on_mob_remove(mob/living/carbon/eyes_owner)
	. = ..()
	REMOVE_TRAIT(eyes_owner, TRAIT_LUMINESCENT_EYES, ORGAN_TRAIT)

// /obj/item/organ/eyes/drask/generate_body_overlay(obj/item/bodypart/head/my_head)
// 	// 1. Получаем стандартные два глаза от родителя
// 	var/list/overlays = ..()

// 	if(!eye_icon_state || isnull(my_head))
// 		return overlays

// 	// 2. Добавляем третий глаз (центр)
// 	var/eye_dir = my_head.owner ? null : SOUTH
// 	var/mutable_appearance/eye_center = mutable_appearance(eye_icon, "[eye_icon_state]_c", -EYES_LAYER)
// 	eye_center.dir = eye_dir

// 	// 3. Цвет (если есть)
// 	if(my_head.head_flags & HEAD_EYECOLOR)
// 		var/eye_color = my_head.owner?.get_left_eye_color() || eye_color_left
// 		eye_center.color = eye_color

// 	// 4. Оффсет (если есть)
// 	if(my_head.worn_face_offset)
// 		my_head.worn_face_offset.apply_offset(eye_center)

// 	// 5. Добавляем третий глаз в список
// 	overlays += eye_center

// 	return overlays

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
