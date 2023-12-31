/obj/item/weapon/fuel
	name = "Magnetic Storage Ring"
	desc = "A magnetic storage ring."
	icon = 'icons/obj/items.dmi'
	icon_state = "rcdammo"
	opacity = 0
	density = FALSE
	anchored = FALSE
	var/fuel = 0
	var/s_time = 1.0
	var/content = null

/obj/item/weapon/fuel/H
	name = "Hydrogen storage ring"
	content = "Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/antiH
	name = "Anti-Hydrogen storage ring"
	content = "Anti-Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/attackby(obj/item/weapon/fuel/F, mob/user)
	..()
	if(istype(src, /obj/item/weapon/fuel/antiH))
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			F.fuel = 0
			to_chat(user, "You have added the anti-Hydrogen to the storage ring, it now contains [src.fuel]kg")
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			qdel(F)
			src:annihilation(src.fuel)
	if(istype(src, /obj/item/weapon/fuel/H))
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			F.fuel = 0
			to_chat(user, "You have added the Hydrogen to the storage ring, it now contains [src.fuel]kg")
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			qdel(src)
			F:annihilation(F.fuel)

/obj/item/weapon/fuel/antiH/proc/annihilation(mass)

	var/strength = convert2energy(mass)

	if (strength < 773.0)
		var/turf/T = get_turf(src)

		if (strength > (450+T0C))
			explosion(T, 0, 1, 2, 4)
		else
			if (strength > (300+T0C))
				explosion(T, 0, 0, 2, 3)

		qdel(src)
		return

	var/turf/ground_zero = get_turf(loc)

	var/ground_zero_range = round(strength / 387)
	explosion(ground_zero, ground_zero_range, ground_zero_range*2, ground_zero_range*3, ground_zero_range*4)

	//SN src = null
	qdel(src)
	return


/obj/item/weapon/fuel/examine()
	set src in view(1)
	if(usr && usr.stat == CONSCIOUS)
		to_chat(usr, "A magnetic storage ring, it contains [fuel]kg of [content ? content : "nothing"].")

/obj/item/weapon/fuel/proc/injest(mob/M)
	switch(content)
		if("Anti-Hydrogen")
			M.gib()
		if("Hydrogen")
			to_chat(M, "<span class='notice'>You feel very light, as if you might just float away...</span>")
	qdel(src)
	return

/obj/item/weapon/fuel/attack(mob/M, mob/user)
	if (user == M)
		visible_message("<span class='red'>[M] ate the [content ? content : "empty canister"]!</span>")
		injest(M)
