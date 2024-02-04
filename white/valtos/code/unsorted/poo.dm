////////////////////////////////////////////
// POO POO PEE PEE
// what the fuck now are you retarded?
/////////////////////////////////////

#define CLEAN_TYPE_BLOOD		(1 << 0)
#define ABOVE_OBJ_LAYER 3.2

#define COMSIG_ATOM_UPDATE_OVERLAYS "atom_update_overlays"
#define COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZE "atom_init_success"
#define COMPONENT_CLEANED	(1<<0)
#define INITIALIZED_1				(1<<14)
#define COMSIG_ATOM_DIR_CHANGE "atom_dir_change"
#define COMSIG_COMPONENT_CLEAN_ACT "clean_act"

/datum/element/decal
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH
	id_arg_index = 2
	var/cleanable
	var/description
	/// If true this was initialized with no set direction - will follow the parent dir.
	var/directional
	var/mutable_appearance/pic

/// Remove old decals and apply new decals after rotation as necessary
/datum/controller/subsystem/processing/dcs/proc/rotate_decals(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER

	if(old_dir == new_dir)
		return
	var/list/resulting_decals_params = list() // param lists
	var/list/old_decals = list() //instances

	if(!source.comp_lookup || !source.comp_lookup[COMSIG_ATOM_UPDATE_OVERLAYS])
		//should probably also unregister itself
		return

	if(length(source.comp_lookup[COMSIG_ATOM_UPDATE_OVERLAYS]))
		for(var/datum/element/decal/decal in source.comp_lookup[COMSIG_ATOM_UPDATE_OVERLAYS])
			old_decals += decal
			resulting_decals_params += list(decal.get_rotated_parameters(old_dir,new_dir))
	else
		var/datum/element/decal/decal = source.comp_lookup[COMSIG_ATOM_UPDATE_OVERLAYS]
		if(!istype(decal))
			return
		old_decals += decal
		resulting_decals_params += list(decal.get_rotated_parameters(old_dir,new_dir))

	//Instead we could generate ids and only remove duplicates to save on churn on four-corners symmetry ?
	for(var/datum/element/decal/decal in old_decals)
		decal.Detach(source)

	for(var/result in resulting_decals_params)
		source.AddElement(/datum/element/decal, result["icon"], result["icon_state"], result["dir"], result["cleanable"], result["color"], result["layer"], result["desc"], result["alpha"])


/datum/element/decal/proc/get_rotated_parameters(old_dir,new_dir)
	var/rotation = 0
	if(directional) //Even when the dirs are the same rotation is coming out as not 0 for some reason
		rotation = SIMPLIFY_DEGREES(dir2angle(new_dir)-dir2angle(old_dir))
		new_dir = turn(pic.dir,-rotation)
	return list(
		"icon" = pic.icon,
		"icon_state" = pic.icon_state,
		"dir" = new_dir,
		"cleanable" = cleanable,
		"color" = pic.color,
		"layer" = pic.layer,
		"desc" = description,
		"alpha" = pic.alpha
	)





/datum/element/decal/proc/generate_appearance(_icon, _icon_state, _dir, _layer, _color, _alpha, source)
	if(!_icon || !_icon_state)
		return FALSE
	var/temp_image = image(_icon, null, _icon_state, _layer, _dir)
	pic = new(temp_image)
	pic.color = _color
	pic.alpha = _alpha
	return TRUE



/datum/element/decal/proc/late_update_icon(atom/source)
	SIGNAL_HANDLER

	if(source && istype(source))
		source.update_icon()
		UnregisterSignal(source,COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZE)


/datum/element/decal/proc/apply_overlay(atom/source, list/overlay_list)
	SIGNAL_HANDLER

	overlay_list += pic

/datum/element/decal/proc/clean_react(datum/source, clean_types)
	SIGNAL_HANDLER

	if(clean_types & cleanable)
		Detach(source)
		return COMPONENT_CLEANED
	return NONE

/datum/element/decal/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += description


/obj/item/weapon/reagent_containers/food/snacks/poo
	name = "говно"
	desc = "Продукт человеческой единицы."
	icon = 'white/valtos/icons/poo.dmi'
	icon_state = "truepoo"
//	tastes = list("shit" = 1, "poo" = 1)
	var/random_icon_states = list("poo1", "poo2", "poo3", "poo4", "poo5", "poo6")
//	food_reagents = list(/datum/reagent/toxin/poo = 5)
//	microwaved_type = /obj/item/weapon/reagent_containers/food/snacks/poo/cooked
//	foodtypes = MEAT | RAW | TOXIC
//	grind_results = list()

//obj/item/weapon/reagent_containers/food/snacks/poo/Initialize()
/obj/item/weapon/reagent_containers/food/snacks/poo/atom_init()
	. = ..()
	if (random_icon_states && (icon_state == initial(icon_state)) && length(random_icon_states) > 0)
		icon_state = pick(random_icon_states)
	create_reagents(25)
	reagents.add_reagent("shit", 10)

/obj/item/weapon/reagent_containers/food/snacks/poo/cooked
	name = "жареное говно"
	icon_state = "ppoo1"
	random_icon_states = list("ppoo1", "ppoo2", "ppoo3", "ppoo4", "ppoo5", "ppoo6")
	list_reagents = list("lube" = 10)

/datum/recipe/microwave/poo/cooked
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/poo
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/poo/cooked

/datum/reagent/toxin/poo
	name = "Говно"
	id = "shit"
	description = "Говно?"
	color = "#4b3320"
	toxpwr = 1.5
	taste_message = "говно"

/datum/reagent/toxin/poo/on_mob_life(mob/living/carbon/C)
	//SSblackbox.record_feedback("tally", "poo", 1, "Poo Eaten")
	return ..()

//datum/reagent/toxin/poo/expose_turf(turf/open/T, reac_volume)//splash the poo all over the place
/datum/reagent/toxin/poo/reaction_turf(turf/simulated/T, reac_volume)
	. = ..()
	if(!istype(T))
		return
	if(reac_volume >= 1)
		//T.MakeSlippery(TURF_WET_WATER, 15 SECONDS, min(reac_volume * 2 SECONDS, 120))
		T.make_shit_floor()

	var/obj/effect/decal/cleanable/poo/B = locate() in T //find some poo here
	if(!B)
		B = new(T)


/turf/simulated/proc/make_shit_floor()
	wet_timer_id = addtimer(CALLBACK(src, .proc/make_dry_floor), rand(15 SECONDS, 18 SECONDS), TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	AddComponent(/datum/component/slippery, 2, NO_SLIP_WHEN_WALKING)
	wet = LUBE_FLOOR


/datum/element/decal/poo
	//dupe_mode = COMPONENT_DUPE_UNIQUE

/datum/element/decal/poo/Attach(datum/target, _icon, _icon_state, _dir, _cleanable=CLEAN_TYPE_BLOOD, _color, _layer=ABOVE_OBJ_LAYER)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	. = ..()


/datum/element/decal/poo/generate_appearance(_icon, _icon_state, _dir, _layer, _color, _alpha, source)
	var/obj/item/I = source
	if(!_icon)
		_icon = 'white/valtos/icons/poo.dmi'
	if(!_icon_state)
		_icon_state = "itempoo"
	var/icon = initial(I.icon)
	var/icon_state = initial(I.icon_state)
	if(!icon || !icon_state)
		icon = I.icon
		icon_state = I.icon_state
	var/static/list/poo_splatter_appearances = list()
	var/index = "[REF(icon)]-[icon_state]"
	pic = poo_splatter_appearances[index]

	if(!pic)
		var/icon/poo_splatter_icon = icon(initial(I.icon), initial(I.icon_state), , 1)
		poo_splatter_icon.Blend("#fff", ICON_ADD)
		poo_splatter_icon.Blend(icon(_icon, _icon_state), ICON_MULTIPLY)
		pic = mutable_appearance(poo_splatter_icon, initial(I.icon_state))
		poo_splatter_appearances[index] = pic
	return TRUE

/obj/effect/decal/cleanable/poo
	name = "шоколадный каток"
	desc = "И кто это тут размазал?"
	icon = 'white/valtos/icons/poo.dmi'
	icon_state = "splat1"
	random_icon_states = list("splat1", "splat2", "splat3", "splat4", "splat5", "splat6", "splat7", "splat8")

/obj/item/weapon/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/weapon/reagent_containers/food/snacks/poo/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/poo(T)
	if(reagents && reagents.total_volume)
		reagents.standard_splash(hit_atom, TOUCH)
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/H = hit_atom
		var/mutable_appearance/pooverlay = mutable_appearance('white/valtos/icons/poo.dmi')
		//H.Paralyze(5) //splat!
		H.Stun(1)
		H.Weaken(1)
		H.adjustBlurriness(1)
		H.visible_message("<span class='warning'><b>[H]</b> ловит <b>[src]</b> своим телом!</span>", "<span class='userdanger'>Ловлю <b>[src]</b> своим телом!</span>")
		playsound(H, "desceration", 50, TRUE)
		if(!H.pooed) // one layer at a time
			pooverlay.icon_state = "facepoo"
			H.add_overlay(pooverlay)
			pooverlay.icon_state = "uniformpoo"
			H.add_overlay(pooverlay)
			pooverlay.icon_state = "suitpoo"
			H.add_overlay(pooverlay)
			H.pooed = TRUE
			//SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "pooed", /datum/mood_event/pooed)
			//SSblackbox.record_feedback("tally", "poo", 1, "Poo Splats")
	qdel(src)

/datum/emote/human/poo
	key = "poo"
//	ru_name = "наложить"
	message_3p = "shits on the floor"
	message_type = SHOWMSG_AUDIO

/datum/emote/human/poo/do_emote(mob/living/carbon/human/user, emote_key, intentional)
	. = ..()
	user.try_poo()

/mob/living/proc/try_poo()
	var/list/random_poo = list("покакунькивает", "срёт", "какает", "производит акт дефекации", "обсирается", "выдавливает какулину")
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		var/turf/T = get_turf(src)
		if(H.pooition >= 25)
			if(HAS_TRAIT(H, TRAIT_LIGHT_POOER))
				H.visible_message("<span class='notice'><b>[H]</b> [prob(75) ? pick(random_poo) : uppertext(pick(random_poo))] себе прямо в руку!</span>", \
					"<span class='notice'>Выдавливаю какаху из своего тела.</span>")
				playsound(H, 'white/valtos/sounds/poo2.ogg', VOL_EFFECTS_MASTER, 25, TRUE) //silence hunter
				var/obj/item/weapon/reagent_containers/food/snacks/poo/P = new(T)
				H.put_in_hands(P)
				H.throw_mode_on()
				H.pooition -= 25
				//SSblackbox.record_feedback("tally", "poo", 1, "Poo Created")
				return
			else
				if(H.w_uniform)
					H.visible_message("<span class='notice'><b>[H]</b> [prob(75) ? pick(random_poo) : uppertext(pick(random_poo))] себе в штаны!</span>", \
						"<span class='notice'>Сру себе в штаны.</span>")
					playsound(H, 'white/valtos/sounds/poo2.ogg', VOL_EFFECTS_MASTER, 50, TRUE)
					H.pooition -= 25
					if(!H.pooed)
						var/mutable_appearance/pooverlay = mutable_appearance('white/valtos/icons/poo.dmi')
						pooverlay.icon_state = "uniformpoo"
						H.add_overlay(pooverlay)
						pooverlay.icon_state = "suitpoo"
						H.add_overlay(pooverlay)
						H.pooed = TRUE
						//SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "pooed", /datum/mood_event/pooed)
					//SSblackbox.record_feedback("tally", "poo", 1, "Poo Self")
					return
				else if(locate(/obj/structure/toilet) in T)
					H.visible_message("<span class='notice'><b>[H]</b> [prob(75) ? pick(random_poo) : uppertext(pick(random_poo))] в туалет!</span>", \
						"<span class='notice'>Выдавливаю какаху прямиком в туалет.</span>")
					playsound(H, 'white/valtos/sounds/poo2.ogg', VOL_EFFECTS_MASTER, 50, TRUE)
					H.pooition -= 25
					//SSblackbox.record_feedback("tally", "poo", 1, "Poo Created")
					return
				else
					H.visible_message("<span class='notice'><b>[H]</b> [prob(75) ? pick(random_poo) : uppertext(pick(random_poo))] на пол!</span>", \
						"<span class='notice'>Выдавливаю какаху из своего тела.</span>")
					playsound(H, 'white/valtos/sounds/poo2.ogg', VOL_EFFECTS_MASTER, 50, TRUE)
					new /obj/item/weapon/reagent_containers/food/snacks/poo(T)
					H.pooition -= 25
					//SSblackbox.record_feedback("tally", "poo", 1, "Poo Created")
					return
		else if(H.stat == CONSCIOUS)
			H.visible_message("<span class='notice'><b>[H]</b> тужится!</span>", \
					"<span class='notice'>Вам нечем какать.</span>")
			H.adjustBlurriness(1)
			//SSblackbox.record_feedback("tally", "poo", 1, "Poo Creation Failed")
			return

/atom/proc/wash_poo()
	return TRUE

/mob/living/carbon/human/wash_poo()
	if(pooed)
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "facepoo"))
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "uniformpoo"))
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "suitpoo"))
		pooed = FALSE

/datum/quirk/legkoserya
	name = QUIRK_LIGHT_POOER
	desc = "Древнее умение какать прямо себе в руку и не только."
	value = 2
	mob_trait = TRAIT_LIGHT_POOER
	gain_text = "<span class='notice'>Теперь я знаю древние техники покакунек.</span>"
	lose_text = "<span class='danger'>Забываю как правильно какать.</span>"
	//medical_record_text = "Дефекационные навыки пациента стоят за гранью понимания." //prikol
	
	
	
/mob/proc/adjust_pooition(change)
	pooition = max(0, pooition + change)

/mob/proc/set_pooition(change)
	pooition = max(0, change)
	