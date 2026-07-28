// Sprite author:
// Telegram: @cluwnya
// https://t.me/Lolo42T_CH
// Discord: t_ch42

/datum/species/drask
	name = "\improper Драск"
	plural_form = "Драски"
	id = SPECIES_DRASK
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_FIXED_MUTANT_COLORS,
		TRAIT_LUMINESCENT_EYES
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	species_language_holder = /datum/language_holder/skrell
	mutantbrain = /obj/item/organ/brain/drask
	mutantheart = /obj/item/organ/heart/drask
	mutantlungs = /obj/item/organ/lungs/drask
	mutanteyes = /obj/item/organ/eyes/drask
	mutanttongue = /obj/item/organ/tongue/drask
	mutantliver = /obj/item/organ/liver/drask
	mutantstomach = /obj/item/organ/stomach/drask
	mutant_organs = list(
		/obj/item/organ/thermal_spine/central = "Центральный регулятор",
		/obj/item/organ/thermal_spine/arm_l = "Нарост левой руки",
		/obj/item/organ/thermal_spine/arm_r = "Нарост правой руки",
	)
	exotic_bloodtype = BLOOD_TYPE_DRASK
	heatmod = 2
	bodytemp_normal = BODYTEMP_NORMAL - 57
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT - 47
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT - 120

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/drask,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/drask,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/drask,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/drask,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/drask,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/drask,
	)
	payday_modifier = 1

/datum/species/drask/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features[FEATURE_DRASK_ARM_SPINES_COLOR] = "#66FFAA"
	human.dna.features[FEATURE_DRASK_ARM_SPINES] = /datum/sprite_accessory/drask_arm_spines/default::name
	human.dna.features[FEATURE_DRASK_SKIN_TONE] = "drask_mid"
	human.dna.features[FEATURE_MUTANT_COLOR] = get_drask_tone_color("drask_mid")
	human.update_body(is_creating = TRUE)

/datum/species/drask/randomize_features()
	var/list/features = ..()
	features[FEATURE_DRASK_ARM_SPINES] = pick(
		/datum/sprite_accessory/drask_arm_spines/default::name,
		/datum/sprite_accessory/drask_arm_spines/default1::name,
	)
	return features

/datum/species/drask/get_features()
	. = ..()
	. |= FEATURE_DRASK_SKIN_TONE
	// . -= "skin_tone"
	// . -= "mutant_color"

/datum/species/drask/on_species_gain(mob/living/carbon/human/human, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	if(!human.dna.features[FEATURE_DRASK_SKIN_TONE])
		human.dna.features[FEATURE_DRASK_SKIN_TONE] = "drask_mid"
	human.dna.features[FEATURE_MUTANT_COLOR] = get_drask_tone_color(human.dna.features[FEATURE_DRASK_SKIN_TONE])
	human.update_body()

/datum/species/drask/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "box-open",
			SPECIES_PERK_NAME = "Головной карман",
			SPECIES_PERK_DESC = "Имеют орган головного кармана, вмещающий маленький предмет",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "fish-fins",
			SPECIES_PERK_NAME = "Подводное дыхание",
			SPECIES_PERK_DESC = "Скреллы являются амфибиями и могут дышать под водой",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "person-swimming",
			SPECIES_PERK_NAME = "Прекрасные пловцы",
			SPECIES_PERK_DESC = "Миры скреллов почти полностью покрыты водой, что не могло не повлиять на их адаптацию",
		),
	)
	return to_add

/datum/species/drask/get_physical_attributes()
	return "Скреллы представляют собой двуногих гуманоидов, \
		отличительной которых есть наличе мешочка в их головных щупальцах а так же полная непереносимость алкоголя"

/datum/species/drask/get_species_description()
	return "Скреллы - вид амфибий, родом с Кверрбалака, влажной тропической планеты, полной болот и архипелагов. \
	Скреллы это высокоразвитая и разумная раса, живущая под властью Кверр-Кэтиш, главного правительственного органа.<br/><br/> \
	Скреллы травоядны и изобильны по своей природе благодаря главным постулатам скреллской культуры. \
	Хотя Скреллы предпочитают дипломатию, они участвуют в крупнейшем военном союзе в галактике - Человеко-Скреллаинском Альянсе."

/datum/species/drask/get_species_lore()
	return list(
		"Скреллианская Империя – надгосударственный союз скреллианских городов-государств, \
			княжеств и небольших королевств. Империя всю свою историю является децентрализованным образованием \
			со сложной феодальной иерархической структурой, \
			объединяющей несколько тысяч территориально-государственных образований, \
			но, несмотря на это, Империи удается проводить более-менее схожую политику во всех своих уголках. \
			Официальной политической идеологией Империи и опорой её общественного строя является Вечный мир.",

		"Вечный мир – скреллианская реакционная неофеодальная политическая идеология и \
			консервативное общественно-политическое движение, целью которого является \
			сохранение традиционной общественно-экономической структуры, основанной на структуре древнего общества скреллов, \
			а также устанавливаемый на их основе автократический режим.",

		"Вечный мир характеризуется жесткой социальной иерархией - кастовой системой, отсутствием социальной мобильности, \
			подавлением оппозиции и индивидуальных свобод, коллективизмом, диктатурой правящей касты Кверр-Кэтиш \
			и её сплоченностью – против управляемых каст, высокой степенью административной децентрализации.",

		"Теоретики Вечного мира утверждают необходимость в данном политическом строе с позиции философии \
			материалистического рационализма, общественной стабильности и технологического прогресса. \
			С их точки зрения, административная и политическая децентрализация, наличие специально выделенной \
			сосуществующей друг с другом касты управленцев и скреллианская экономическая структура минимизируют \
			необходимость в межгосударственных конфликтах, а классовое сотрудничество между кастами скреллианского \
			общества позволяет максимизировать экономическое и научно-прогрессивное развитие всего общества \
			и цивилизации скреллов в целом.",

		"Критики Вечного мира считают, что целью этого строя является не качество жизни и развитие скреллианской цивилизации, \
			а политический контроль и власть сама по себе.",

		"Исполнительную власть в Империи номинально осуществляет учрежденное в 2331 г. н.э. Имперское Представительство, \
			однако законодательно его полномочия ограничены внешней политикой. \
			Представитель избирается Имперским Собранием – центральным форумом Империи. \
			Исполнение внутренней политики Империи возложено на правительства имперских субъектов. \
			Концепция Вечного мира предполагает коллективное участие всей касты Кверров вне зависимости \
			от государственной принадлежности в поддержании стабильности Империи и сплоченности Кверр-Кэтиш, \
			а законы Империи выражают коллективную волю всей правящей касты.",

		"Правителями государств скреллов являются короли, называемые Кверр-Скриа. \
			Как правило, они управляют одной городской агломерацией. \
			Спорные вопросы между государствами обычно решаются через дипломатические меры, \
			в крайних случаях - через силы специальных операций, но открытые конфронтации \
			и войны избегаются для поддержания стабильности и экономической взаимосвязанности.",

		"Однако некоторые расширяют подконтрольные территории до нескольких, \
			порою доходя до размеров человеческих государств, – таких именуют Крри-Кверриа, \
			что чаще всего (хотя и неверно) переводят как «император». \
			Такие случаи чаще всего происходят на пограничных или слабозаселенных территориях, \
			где центральное управление и оборона необходимы для выживания всей колонии.  \
			В других мирах экспансии Крри-Кверриа единым образом противостоят другие Кверры, \
			стремящиеся к исполнению постулатов Вечного мира, к сохранению баланса сил и статуса-кво. \
			Как правило, самопровозглашенные императоры встречают отпор от своего Ксаку Моглар (двора) \
			в виде неповиновения и от других Кверр-Скриа в форме дипломатических союзов и скрытых операций, \
			но в истории были и случаи открытых карательных экспедиций, собранных с ОСС по всей Империи для \
			недопущения образования центров объединения и, как следствие, общественного прогресса."
	)

/datum/species/drask/on_species_gain(mob/living/carbon/human/human, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	// Устанавливаем рост сразу, но он может быть сброшен позже
	human.mob_height = HUMAN_HEIGHT_TALLER
	// Откладываем финальную установку на следующий тик
	addtimer(CALLBACK(src, PROC_REF(apply_drask_height), human), 0)

/// Принудительно применяем рост и обновляем все спрайты
/datum/species/drask/proc/apply_drask_height(mob/living/carbon/human/human)
	if(!istype(human) || QDELETED(human))
		return
	human.mob_height = HUMAN_HEIGHT_TALLER
	// Полное перестроение всех оверлеев – гарантирует применение фильтров высоты ко всему
	human.regenerate_icons()

// /datum/species/drask/on_species_gain(mob/living/carbon/human/human, datum/species/old_species, pref_load, regenerate_icons = TRUE)
// 	. = ..()
// 	RegisterSignal(human, SIGNAL_ADDTRAIT(TRAIT_TOO_TALL), PROC_REF(on_too_tall_change))
// 	RegisterSignal(human, SIGNAL_REMOVETRAIT(TRAIT_TOO_TALL), PROC_REF(on_too_tall_change))
// 	RegisterSignal(human, COMSIG_ATOM_UPDATE_ICON, PROC_REF(on_update_icon))
// 	apply_drask_scale(human)

// /datum/species/drask/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
// 	UnregisterSignal(human, SIGNAL_ADDTRAIT(TRAIT_TOO_TALL))
// 	UnregisterSignal(human, SIGNAL_REMOVETRAIT(TRAIT_TOO_TALL))
// 	UnregisterSignal(human, COMSIG_ATOM_UPDATE_ICON)
// 	human.transform = matrix() // сброс
// 	human.pixel_y = 0
// 	. = ..()

// /datum/species/drask/proc/on_too_tall_change(mob/living/carbon/human/source)
// 	SIGNAL_HANDLER
// 	apply_drask_scale(source)

// /datum/species/drask/proc/on_update_icon(mob/living/carbon/human/source)
// 	SIGNAL_HANDLER
// 	apply_drask_scale(source) // восстановить масштаб после обновления иконок

// /datum/species/drask/proc/apply_drask_scale(mob/living/carbon/human/human)
// 	var/matrix/M = matrix()
// 	var/scale_x = 1.05
// 	var/scale_y = 1.05
// 	if(HAS_TRAIT(human, TRAIT_TOO_TALL))
// 		scale_y *= 1.1
// 	var/offset_y = -round((scale_y - 1) * 16) // автоматический расчёт смещения
// 	M.Scale(scale_x, scale_y)
// 	M.Translate(0, offset_y)
// 	human.transform = M
// 	human.pixel_y = 0 // не используем, чтобы не конфликтовать

// /datum/species/drask/update_species_heights(mob/living/carbon/human/holder)
// 	if(HAS_TRAIT(holder, TRAIT_TOO_TALL))
// 		return HUMAN_HEIGHT_TALL   // при трейте – TALL
// 	return HUMAN_HEIGHT_MEDIUM    // без трейта – MEDIUM






// /datum/species/drask/body_temperature_damage(mob/living/carbon/human/humi, seconds_per_tick)
// 	// Родительский метод наносит урон от жары (heatmod=2) и
// 	// урон от холода при coretemperature < bodytemp_cold_damage_limit (150 K)
// 	..()

// 	if(humi.stat == DEAD || HAS_TRAIT(humi, TRAIT_STASIS))
// 		return

// 	var/current_core = humi.coretemperature
// 	var/a = bodytemp_cold_damage_limit   // 150 K
// 	var/b = bodytemp_normal              // 263 K
// 	var/opt = 193.15                     // -80°C – пик лечения
// 	var/max_heal = 7                     // максимальное лечение за тик

// 	// Лечение только в интервале (a, b)
// 	if(current_core <= a || current_core >= b)
// 		return

// 	var/heal = 0
// 	if(current_core <= opt)
// 		// Восходящая парабола: от 0 при a до max_heal при opt
// 		var/t = (current_core - a) / (opt - a)   // t ∈ [0, 1]
// 		heal = max_heal * t * t
// 	else
// 		// Нисходящая парабола: от max_heal при opt до 0 при b
// 		var/t = (b - current_core) / (b - opt)   // t ∈ [1, 0]
// 		heal = max_heal * t * t

// 	var/heal_amount = heal * seconds_per_tick
// 	if(heal_amount > 0)
// 		humi.adjust_brute_loss(-heal_amount, updating_health = FALSE)
// 		humi.adjust_fire_loss(-heal_amount, updating_health = FALSE)
// 		humi.updatehealth()

/datum/species/drask/body_temperature_skin(mob/living/carbon/human/humi, seconds_per_tick)
	var/datum/gas_mixture/environment = humi.loc?.return_air()
	if(!environment)
		return
	var/area_temp = humi.get_temperature(environment)
	var/thermal_protection = humi.get_insulation_protection(area_temp)

	// 1. Влияние среды на кожу (как у людей)
	var/area_skin_diff = area_temp - humi.bodytemperature
	if(!humi.on_fire || area_skin_diff > 0)
		var/area_skin_change = get_temp_change_amount(area_skin_diff, 0.05 * seconds_per_tick)
		// Изменяем условие: потоотделение включается, только если ядро > -20°C + 30°C = 10°C (283K)
		if(bodytemp_normal + 30 < humi.coretemperature) // bodytemp_normal = 253K, порог 283K (10°C)
			area_skin_change = (1 - (thermal_protection * 0.7)) * area_skin_change
		else
			area_skin_change = (1 - thermal_protection) * area_skin_change
		humi.adjust_bodytemperature(area_skin_change)

	// 2. Расчёт эффективности E
	var/obj/item/organ/thermal_spine/central = humi.get_organ_slot(ORGAN_SLOT_THERMAL_REGULATOR)
	var/obj/item/organ/thermal_spine/arm_l = humi.get_organ_slot(ORGAN_SLOT_ARM_SPINES_L)
	var/obj/item/organ/thermal_spine/arm_r = humi.get_organ_slot(ORGAN_SLOT_ARM_SPINES_R)
	var/central_int = central?.integrity || 0
	var/left_int = arm_l?.integrity || 0
	var/right_int = arm_r?.integrity || 0
	var/raw_avg = (central_int + left_int + right_int) / 3
	var/E = raw_avg ** 1.356

	// 3. Смещение кожи в сторону среды (для ранних алертов)
	var/delta = (area_temp - humi.coretemperature) * (1 - E) * 0.4
	delta = clamp(delta, -40, 40)
	var/target_skin = humi.coretemperature + delta

	// 4. Плавное приближение кожи к target_skin
	var/skin_diff = target_skin - humi.bodytemperature
	var/skin_change = get_temp_change_amount(skin_diff, 0.08 * seconds_per_tick)
	if(skin_diff > 0)
		skin_change = min(skin_change, skin_diff)
	else
		skin_change = max(skin_change, skin_diff)
	humi.adjust_bodytemperature(skin_change)

	// 5. Очень слабый теплообмен кожа->ядро
	var/core_skin_diff = humi.bodytemperature - humi.coretemperature
	if(!humi.on_fire)
		var/core_skin_change = get_temp_change_amount(core_skin_diff, 0.015 * seconds_per_tick)
		if(core_skin_diff > 0)
			core_skin_change = min(core_skin_change, core_skin_diff)
		else
			core_skin_change = max(core_skin_change, core_skin_diff)
		humi.adjust_coretemperature(core_skin_change)

/datum/species/drask/body_temperature_core(mob/living/carbon/human/humi, seconds_per_tick)
	var/datum/gas_mixture/environment = humi.loc?.return_air()
	var/areatemp = humi.get_temperature(environment) || T20C

	var/obj/item/organ/thermal_spine/central = humi.get_organ_slot(ORGAN_SLOT_THERMAL_REGULATOR)
	var/obj/item/organ/thermal_spine/arm_l = humi.get_organ_slot(ORGAN_SLOT_ARM_SPINES_L)
	var/obj/item/organ/thermal_spine/arm_r = humi.get_organ_slot(ORGAN_SLOT_ARM_SPINES_R)

	var/central_int = central?.integrity || 0
	var/left_int = arm_l?.integrity || 0
	var/right_int = arm_r?.integrity || 0

	var/raw_avg = (central_int + left_int + right_int) / 3
	var/E = raw_avg ** 1.356

	if (E < 0.01)
		var/diff = bodytemp_normal - humi.coretemperature
		var/natural_change = diff * 0.06 * seconds_per_tick
		humi.adjust_coretemperature(humi.metabolism_efficiency * natural_change)
		return

	var/warm_target = bodytemp_normal + 93 * (1 - E) - 26 * (1 - E) ** 2
	warm_target = clamp(warm_target, 50, 400)

	var/target_temp
	if (warm_target >= areatemp)
		var/heating_delta = 134 * E * E - 121 * E + 27
		heating_delta = max(heating_delta, 0)
		target_temp = min(warm_target, areatemp + heating_delta)
	else
		var/cooling_delta = 80 * E - 40
		cooling_delta = max(cooling_delta, 0)
		target_temp = max(warm_target, areatemp - cooling_delta)

	var/diff = target_temp - humi.coretemperature
	var/natural_change = diff * 0.06 * seconds_per_tick
	humi.adjust_coretemperature(humi.metabolism_efficiency * natural_change)

