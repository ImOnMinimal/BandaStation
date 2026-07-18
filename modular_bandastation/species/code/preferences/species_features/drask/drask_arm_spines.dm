/datum/preference/choiced/species_feature/drask_arm_spines
	savefile_key = "feature_drask_arm_spines"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Наросты на руках"
	should_generate_icons = TRUE
	relevant_organ = /obj/item/organ/thermal_spine/arm_l

/datum/preference/choiced/species_feature/drask_arm_spines/get_accessory_list()
	return SSaccessories.feature_list[FEATURE_DRASK_ARM_SPINES]

/datum/preference/choiced/species_feature/drask_arm_spines/icon_for(value)
	var/datum/sprite_accessory/A = get_accessory_for_value(value)
	if(!A)
		return
	var/datum/universal_icon/icon = uni_icon(A.icon, "m_drask_arm_spines_[A.icon_state]_FRONT")
	icon.scale(32, 32)
	return icon

/datum/preference/choiced/species_feature/drask_arm_spines/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[FEATURE_DRASK_ARM_SPINES] = value

/datum/preference/choiced/species_feature/drask_arm_spines/create_informed_default_value(datum/preferences/preferences)
	return /datum/sprite_accessory/drask_arm_spines/default::name
