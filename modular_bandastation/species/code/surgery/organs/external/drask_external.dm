/obj/item/organ/arm_spines
	name = "drask arm spines"
	desc = "Is it really tentacle?"

	icon = 'icons/bandastation/mob/species/drask/sprite_accessories/arm_spines.dmi'
	icon_state = "m_drask_arm_spines_FRONT"

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_ARM_SPINES

	dna_block = /datum/dna_block/feature/accessory/drask_arm_spines
	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/arm_spines

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL | ORGAN_UNREMOVABLE
	var/mutable_appearance/cached_glow

/datum/bodypart_overlay/mutant/arm_spines
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER
	)
	feature_key = FEATURE_DRASK_ARM_SPINES
	color_source = ORGAN_COLOR_FEATURE
	dna_color_feature_key = FEATURE_DRASK_ARM_SPINES_COLOR
	var/drask_arm_spines_color = "#66FFAA"

/datum/bodypart_overlay/mutant/arm_spines/get_global_feature_list()
	return SSaccessories.feature_list[FEATURE_DRASK_ARM_SPINES]

/datum/bodypart_overlay/mutant/arm_spines/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/bodypart_overlay/mutant/arm_spines/get_overlay(obj/item/bodypart/limb, layer_index, layer_real)
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
