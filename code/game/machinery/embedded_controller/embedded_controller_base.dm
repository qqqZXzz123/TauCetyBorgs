/obj/machinery/embedded_controller
	var/datum/computer/file/embedded_program/program

	name = "Embedded Controller"
	anchored = TRUE
	allowed_checks = ALLOWED_CHECK_TOPIC

	var/on = 1

/obj/machinery/embedded_controller/radio/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src,frequency)
	if(program)
		qdel(program)
	return ..()


/obj/machinery/embedded_controller/proc/post_signal(datum/signal/signal, comm_line)
	return 0

/obj/machinery/embedded_controller/receive_signal(datum/signal/signal, receive_method, receive_param)
	if(!signal || signal.encryption) return

	if(program)
		program.receive_signal(signal, receive_method, receive_param)
			//spawn(5) program.process() //no, program.process sends some signals and machines respond and we here again and we lag -rastaf0

/obj/machinery/embedded_controller/process()
	if(program)
		program.process()

	update_icon()
	updateUsrDialog()

/obj/machinery/embedded_controller/attack_paw(mob/user)
	to_chat(user, "You do not have the dexterity to use this.")
	return

/obj/machinery/embedded_controller/radio
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_standby"
	power_channel = STATIC_ENVIRON
	density = FALSE

	// Setup parameters only
	var/id_tag
	var/tag_exterior_door
	var/tag_interior_door
	var/tag_airpump
	var/tag_chamber_sensor
	var/tag_exterior_sensor
	var/tag_interior_sensor
	var/tag_secure = 0

	frequency = 1379

	unacidable = 1

/obj/machinery/embedded_controller/radio/atom_init()
	. = ..()
	set_frequency(frequency)
	var/datum/computer/file/embedded_program/new_prog = new

	new_prog.id_tag = id_tag
	new_prog.tag_exterior_door = tag_exterior_door
	new_prog.tag_interior_door = tag_interior_door
	new_prog.tag_airpump = tag_airpump
	new_prog.tag_chamber_sensor = tag_chamber_sensor
	new_prog.tag_exterior_sensor = tag_exterior_sensor
	new_prog.tag_interior_sensor = tag_interior_sensor
	new_prog.memory["secure"] = tag_secure

	new_prog.memory["external_sensor_pressure"] = SSenvironment.air_pressure[z]

	new_prog.master = src
	program = new_prog

	spawn(10)
		program.signalDoor(tag_exterior_door, "update")		//signals connected doors to update their status
		program.signalDoor(tag_interior_door, "update")

/obj/machinery/embedded_controller/radio/update_icon()
	if(on && program)
		if(program.memory["processing"])
			icon_state = "airlock_control_process"
		else
			icon_state = "airlock_control_standby"
	else
		icon_state = "airlock_control_off"

/obj/machinery/embedded_controller/radio/post_signal(datum/signal/signal)
	signal.transmission_method = TRANSMISSION_RADIO
	if(radio_connection)
		return radio_connection.post_signal(src, signal)
	else
		qdel(signal)

/obj/machinery/embedded_controller/radio/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	if(frequency)
		radio_connection = radio_controller.add_object(src, frequency)
