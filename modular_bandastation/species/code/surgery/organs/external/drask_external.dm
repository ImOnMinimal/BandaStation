/obj/item/organ/arm_spines
	name = "drask arm spines"
	desc = "Is it really tentacle?"

	icon = 'icons/bandastation/mob/species/drask/sprite_accessories/arm_spines.dmi'
	icon_state = "m_drask_arm_spines_FRONT"

	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_EXTERNAL_ARM_SPINES

	dna_block = /datum/dna_block/feature/accessory/drask_arm_spines
	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/arm_spines

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL | ORGAN_UNREMOVABLE

/obj/item/organ/arm_spines/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	var/color = receiver.dna.features[FEATURE_DRASK_ARM_SPINES_COLOR] || "#66FFAA"
	set_light(1.5, 0.5, color)
	// if(ishuman(receiver))
	// 	var/mob/living/carbon/human/H = receiver
	// 	H.update_body()

/obj/item/organ/arm_spines/proc/update_color(new_color)
	if(!new_color)
		return
	if(owner)
		set_light(1.5, 0.5, new_color)

/datum/bodypart_overlay/mutant/arm_spines
	layers = EXTERNAL_FRONT
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
