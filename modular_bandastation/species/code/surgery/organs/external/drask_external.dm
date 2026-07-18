// drask_external.dm
// Термонаросты драска: центральный регулятор и наросты на руках

/obj/item/organ/thermal_spine
	name = "термонарост"
	desc = "Орган, участвующий в терморегуляции драска."
	icon = 'icons/bandastation/mob/species/drask/sprite_accessories/arm_spines.dmi'
	icon_state = "m_drask_arm_spines_FRONT"
	organ_flags = ORGAN_EXTERNAL
	var/integrity = 1.0

/obj/item/organ/thermal_spine/Initialize(mapload)
	. = ..()
	refresh_integrity()

/obj/item/organ/thermal_spine/proc/refresh_integrity()
	integrity = (maxHealth - damage) / maxHealth

// Центральный терморегулятор
/obj/item/organ/thermal_spine/central
	name = "центральный терморегулятор"
	slot = ORGAN_SLOT_THERMAL_REGULATOR
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_PROMINENT
	healing_factor = 0.002

// Нарост левой руки
/obj/item/organ/thermal_spine/arm_l
	name = "нарост левой руки"
	slot = ORGAN_SLOT_ARM_SPINES_L
	zone = BODY_ZONE_L_ARM
	bodypart_overlay = /datum/bodypart_overlay/mutant/arm_spine
	organ_flags = ORGAN_ORGANIC | ORGAN_PROMINENT
	healing_factor = 0.002

// Нарост правой руки
/obj/item/organ/thermal_spine/arm_r
	name = "нарост правой руки"
	slot = ORGAN_SLOT_ARM_SPINES_R
	zone = BODY_ZONE_R_ARM
	bodypart_overlay = /datum/bodypart_overlay/mutant/arm_spine
	organ_flags = ORGAN_ORGANIC | ORGAN_PROMINENT
	healing_factor = 0.002

// Внешний вид нароста на руке (одинаков для левой и правой)
/datum/bodypart_overlay/mutant/arm_spine
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER
	)
	feature_key = FEATURE_DRASK_ARM_SPINES
	color_source = ORGAN_COLOR_FEATURE
	dna_color_feature_key = FEATURE_DRASK_ARM_SPINES_COLOR
	var/drask_arm_spines_color = "#66FFAA"

/datum/bodypart_overlay/mutant/arm_spine/get_global_feature_list()
	return SSaccessories.feature_list[FEATURE_DRASK_ARM_SPINES]

/datum/bodypart_overlay/mutant/arm_spine/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/bodypart_overlay/mutant/arm_spine/get_overlay(obj/item/bodypart/limb, layer_index, layer_real)
	var/image/main_image = get_image(limb, layer_index, layer_real)
	color_image(main_image, limb, layer_index)

	var/list/overlays = list(main_image)

	var/mutable_appearance/emissive = emissive_appearance(
		main_image.icon,
		main_image.icon_state,
		limb,
		layer = main_image.layer,
		alpha = main_image.alpha,
		effect_type = EMISSIVE_BLOOM
	)
	overlays += emissive

	return overlays


