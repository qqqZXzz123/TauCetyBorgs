/obj/item/weapon/melee/emp_baton
	name = "emp baton"
	desc = "A emp baton for incapacitating robots with."
	icon_state = "stunbaton"
	item_state = "baton"
	slot_flags = SLOT_FLAGS_BELT
	force = 10
	throwforce = 7
	w_class = SIZE_SMALL
	var/charges = 10
	var/status = 0
	var/mob/foundmob = "" //Used in throwing proc.
	var/agony = 1
	var/discharge_rate_per_minute = 2 //stunbaton loses it charges if not powered off
	sweep_step = 2

	origin_tech = "combat=2"

/obj/item/weapon/melee/emp_baton/atom_init()
	. = ..()
	var/datum/swipe_component_builder/SCB = new
	SCB.interupt_on_sweep_hit_types = list(/turf, /obj/effect/effect/weapon_sweep)

	SCB.can_sweep = TRUE
	SCB.can_spin = TRUE
	AddComponent(/datum/component/swiping, SCB)


/obj/item/weapon/melee/emp_baton/update_icon()
	if(status)
		icon_state = "[initial(icon_state)]_active"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/weapon/melee/emp_baton/attack_self(mob/living/user)
	if(status && user.ClumsyProbabilityCheck(50))
		to_chat(user, "<span class='warning'>You grab the [src] on the wrong side.</span>")
		user.apply_effect(agony * 2, AGONY, 0)

		var/mob/living/carbon/human/H = user
		if(H.species.flags[IS_SYNTHETIC])
			user.flash_eyes(affect_silicon = TRUE, type = /atom/movable/screen/fullscreen/flash/noise)
			user.apply_effect(10, STUN, 0)
			user.apply_effect(10, WEAKEN, 0)
			user.apply_effect(10, STUTTER, 0)
			//to_chat(user, "<span class='danger'>1</span>")
		discharge()
		return
	if(!handle_fumbling(user, src, SKILL_TASK_VERY_EASY, list(/datum/skill/police = SKILL_LEVEL_TRAINED), "<span class='notice'>You fumble around figuring out how to toggle [status ? "on" : "off"] [src]...</span>", can_move = TRUE))
		return
	if(charges > 0)
		set_status(!status)
		to_chat(user, "<span class='notice'>\The [src] is now [status ? "on" : "off"].</span>")
		playsound(src, pick(SOUNDIN_SPARKS), VOL_EFFECTS_MASTER)
		update_icon()
	else
		set_status(0)
		to_chat(user, "<span class='warning'>\The [src] is out of charge.</span>")
	add_fingerprint(user)

/obj/item/weapon/melee/emp_baton/attack(mob/M, mob/living/user)
	if(status && user.ClumsyProbabilityCheck(50))
		to_chat(user, "<span class='danger'>You accidentally hit yourself with the [src]!</span>")
		user.apply_effect(agony * 2, AGONY, 0)

		var/mob/living/carbon/human/H = user
		if(H.species.flags[IS_SYNTHETIC])
			user.flash_eyes(affect_silicon = TRUE, type = /atom/movable/screen/fullscreen/flash/noise)
			//user.apply_effect(10, STUN, 0)
			user.apply_effect(10, WEAKEN, 0)
			user.apply_effect(10, STUTTER, 0)
			to_chat(user, "<span class='danger'>2</span>")
		discharge()
		return

	if(isrobot(M))
		return ..()

	var/mob/living/carbon/human/H = M

	if(user.a_intent == INTENT_HARM)
		. = ..()
		// A mob can be deleted after the attack, so we gotta be wary of that.
		if(!. || QDELETED(H))
			return
		//H.apply_effect(5, WEAKEN, 0)
		H.visible_message("<span class='danger'>[M] has been beaten with the [src] by [user]!</span>")

		playsound(src, pick(SOUNDIN_GENHIT), VOL_EFFECTS_MASTER)

	if(!status)
		H.visible_message("<span class='warning'>[M] has been prodded with the [src] by [user]. Luckily it was off.</span>")
		return
	else
		user.do_attack_animation(M)
		//H.apply_effect(10, STUN, 0)
		//H.apply_effect(10, WEAKEN, 0)
		//H.apply_effect(10, STUTTER, 0)
		H.apply_effect(agony,AGONY,0)

		if(H.species.flags[IS_SYNTHETIC])
			H.flash_eyes(affect_silicon = TRUE, type = /atom/movable/screen/fullscreen/flash/noise)
			//H.apply_effect(10, STUN, 0)
			H.apply_effect(2, WEAKEN, 0)
			H.apply_effect(2, STUTTER, 0)
			if(H.lying)
				H.apply_effect(10, STUN, 0)


			to_chat(H, "<span class='danger'>3</span>")

		H.set_lastattacker_info(user)
		if(isrobot(src.loc))
			var/mob/living/silicon/robot/R = src.loc
			if(R && R.cell)
				R.cell.use(50)
		else
			discharge()
		H.visible_message("<span class='danger'>[M] has been attacked with the [src] by [user]!</span>")

		if(!(user.a_intent == INTENT_HARM))
			H.log_combat(user, "stunned (attempt) with [name]")

		playsound(src, 'sound/weapons/Egloves.ogg', VOL_EFFECTS_MASTER)


	add_fingerprint(user)
/obj/item/weapon/melee/emp_baton/proc/set_status(value)
	if(value)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)
	status = value

/obj/item/weapon/melee/emp_baton/proc/discharge(amount = 1)
	charges = max(0, charges - amount)
	if(charges <= 0)
		charges = 0
		set_status(0)
		playsound(src, pick(SOUNDIN_SPARKS), VOL_EFFECTS_MASTER)
		update_icon()

/obj/item/weapon/melee/emp_baton/process()
	discharge(2 * discharge_rate_per_minute / 60)

/obj/item/weapon/melee/emp_baton/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if (prob(50))
		if(isliving(hit_atom))
			var/mob/living/carbon/human/H = hit_atom
			if(status)
				//H.apply_effect(10, STUN, 0)
				//H.apply_effect(10, WEAKEN, 0)
				//H.apply_effect(10, STUTTER, 0)
				H.apply_effect(agony,AGONY,0)

				if(H.species.flags[IS_SYNTHETIC])
					H.flash_eyes(affect_silicon = TRUE, type = /atom/movable/screen/fullscreen/flash/noise)
					H.apply_effect(10, STUN, 0)
					H.apply_effect(10, WEAKEN, 0)
					H.apply_effect(10, STUTTER, 0)
					//to_chat(H, "<span class='danger'>4</span>")

				discharge()
				for(var/mob/M in player_list) if(M.key == src.fingerprintslast)
					foundmob = M
					break

				H.visible_message("<span class='danger'>[src], thrown by [foundmob.name], strikes [H]!</span>")

				H.attack_log += "\[[time_stamp()]\]<font color='orange'> Hit by thrown [src.name] last touched by ([src.fingerprintslast])</font>"
				msg_admin_attack("Flying [src.name], last touched by ([src.fingerprintslast]) hit [key_name(H)]", H)

/obj/item/weapon/melee/emp_baton/emp_act(severity)
	discharge(severity * 5)
