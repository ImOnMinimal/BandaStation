/obj/item/organ/brain/drask
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'

/obj/item/organ/eyes/drask
	name = "drask eyeballs"
	desc = "Глаза синеватого оттенка, но по своей структуре - глаза обычного гуманоида."
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	synchronized_blinking = FALSE
	eye_icon_state = "skrell_eyes"

/obj/item/organ/tongue/drask
	name = "drask tongue"
	desc = "Склизкий язык drask."
	languages_native = list(/datum/language/qurvolious)
	liked_foodtypes = VEGETABLES | FRUIT
	disliked_foodtypes = SEAFOOD
	toxic_foodtypes = ALCOHOL | SUGAR

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
