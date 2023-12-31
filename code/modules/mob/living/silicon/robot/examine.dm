/mob/living/silicon/robot/examine(mob/user)
	var/msg = "<span class='info'>*---------*\nThis is [bicon(src)] \a <EM>[src]</EM>[custom_name ? ", [modtype] [braintype]" : ""]!\n"
	msg += "<span class='warning'>"
	if (getBruteLoss())
		if (getBruteLoss() < maxHealth * 0.375)
			msg += "It looks slightly dented.\n"
		else
			msg += "<B>It looks severely dented!</B>\n"
	if (getFireLoss())
		if (getFireLoss() < maxHealth * 0.375)
			msg += "It looks slightly charred.\n"
		else
			msg += "<B>It looks severely burnt and heat-warped!</B>\n"
	msg += "</span>"

	if(opened)
		msg += "<span class='warning'>Its cover is open and the power cell is [cell ? "installed" : "missing"].</span>\n"
	else
		msg += "Its cover is closed.\n"

	if(!has_power)
		msg += "<span class='warning'>It appears to be running on backup power.</span>\n"

	if(fire_stacks > 0)
		msg += "It is covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "It is looks a little soaked.\n"

	switch(src.stat)
		if(CONSCIOUS)
			if(!src.client)	msg += "It appears to be in stand-by mode.\n" //afk
		if(UNCONSCIOUS)		msg += "<span class='warning'>It doesn't seem to be responding.</span>\n"
		if(DEAD)			msg += "<span class='deadsay'>It looks completely unsalvageable.</span>\n"

	if(w_class)
		msg += "It is a [get_size_flavor()] sized creature.\n"

	msg += "*---------*</span>"

	if(print_flavor_text()) msg += "\n[print_flavor_text()]\n"

	if (pose)
		if( findtext(pose,".",-1) == 0 && findtext(pose,"!",-1) == 0 && findtext(pose,"?",-1) == 0 )
			pose = addtext(pose,".") //Makes sure all emotes end with a period.
		msg += "\nIt is [pose]"

	to_chat(user, msg)

	..()
