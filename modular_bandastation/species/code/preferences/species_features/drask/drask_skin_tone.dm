GLOBAL_LIST_INIT(drask_skin_tones, list(
	"drask_lightest",
	"drask_lighter",
	"drask_light",
	"drask_mid",
	"drask_dark",
	"drask_darker",
	"drask_darkest",
))

/datum/preference/choiced/drask_skin_tone
	savefile_key = "drask_skin_tone"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	main_feature_name = "Тон кожи (Драск)"

/datum/preference/choiced/drask_skin_tone/init_possible_values()
	return GLOB.drask_skin_tones

/datum/preference/choiced/drask_skin_tone/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list(
		"drask_lightest" = "Светлейший",
		"drask_lighter" = "Светлее",
		"drask_light" = "Светлый",
		"drask_mid" = "Средний",
		"drask_dark" = "Тёмный",
		"drask_darker" = "Темнее",
		"drask_darkest" = "Темнейший",
	)
	var/list/to_hex = list()
	for (var/choice in get_choices())
		var/hex_value = get_drask_hex(choice)
		var/list/hsl = rgb2num(hex_value, COLORSPACE_HSL)
		to_hex[choice] = list(
			"lightness" = hsl[3],
			"value" = hex_value,
		)
	data["to_hex"] = to_hex
	return data

// Ограничиваем показ только для Drask
/datum/preference/choiced/drask_skin_tone/has_relevant_feature(datum/preferences/preferences)
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	return species_type == /datum/species/drask

/datum/preference/choiced/drask_skin_tone/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[FEATURE_DRASK_SKIN_TONE] = value
	target.dna.features[FEATURE_MUTANT_COLOR] = get_drask_hex(value)
	target.update_body()

/proc/get_drask_hex(choice)
	switch(choice)
		if("drask_lightest") return "#ededed"
		if("drask_lighter")  return "#dcdcdc"
		if("drask_light")    return "#c2c2c2"
		if("drask_mid")      return "#949494"
		if("drask_dark")     return "#7a7a7a"
		if("drask_darker")   return "#4f4f4f"
		if("drask_darkest")  return "#313131"
		else                 return "#949494"
