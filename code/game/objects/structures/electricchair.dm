/obj/structure/stool/bed/chair/e_chair
	name = "electric chair"
	desc = "Looks absolutely SHOCKING!"
	icon_state = "echair0"
	var/on = 0
	var/obj/item/assembly/shock_kit/part = null
	var/last_time = 1.0

/obj/structure/stool/bed/chair/e_chair/atom_init()
	. = ..()
	add_overlay(image('icons/obj/objects.dmi', src, "echair_over", MOB_LAYER + 1, dir))

/obj/structure/stool/bed/chair/e_chair/attackby(obj/item/weapon/W, mob/user)
	if(iswrenching(W))
		var/obj/structure/stool/bed/chair/C = new /obj/structure/stool/bed/chair(loc)
		playsound(src, 'sound/items/Ratchet.ogg', VOL_EFFECTS_MASTER)
		C.set_dir(dir)
		part.loc = loc
		part.master = null
		part = null
		qdel(src)
		return
	return

/obj/structure/stool/bed/chair/e_chair/verb/toggle()
	set name = "Toggle Electric Chair"
	set category = "Object"
	set src in oview(1)

	if(on)
		on = 0
		icon_state = "echair0"
	else
		on = 1
		icon_state = "echair1"
	to_chat(usr, "<span class='notice'>You switch [on ? "on" : "off"] [src].</span>")
	return

/obj/structure/stool/bed/chair/e_chair/rotate()
	..()
	cut_overlays()
	add_overlay(image('icons/obj/objects.dmi', src, "echair_over", MOB_LAYER + 1, dir))	//there's probably a better way of handling this, but eh. -Pete
	return

/obj/structure/stool/bed/chair/e_chair/proc/shock()
	if(!on)
		return
	if(last_time + 50 > world.time)
		return
	last_time = world.time

	// special power handling
	var/area/A = get_area(src)
	if(!isarea(A))
		return
	if(!A.powered(STATIC_EQUIP))
		return
	A.use_power(STATIC_EQUIP, 5000)
	var/light = A.power_light
	A.updateicon()

	flick("echair1", src)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(12, 1, src)
	s.start()
	if(buckled_mob)
		buckled_mob.burn_skin(85)
		to_chat(buckled_mob, "<span class='danger'>You feel a deep shock course through your body!</span>")
		sleep(1)
		buckled_mob.burn_skin(85)
		buckled_mob.Stun(600)
	visible_message("<span class='danger'>The electric chair went off!</span>", "<span class='danger'>You hear a deep sharp shock!</span>")

	A.power_light = light
	A.updateicon()
	return
