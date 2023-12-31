/obj/machinery/camera

	var/list/motionTargets = list()
	var/detectTime = 0
	var/area/station/ai_monitored/area_motion = null
	var/alarm_delay = 100 // Don't forget, there's another 10 seconds in queueAlarm()
	var/datum/proximity_monitor/proximity_monitor

/obj/machinery/camera/Destroy()
	QDEL_NULL(proximity_monitor)
	return ..()

/obj/machinery/camera/process()
	// motion camera event loop
	if(!isMotion())
		return PROCESS_KILL
	if (detectTime > 0)
		var/elapsed = world.time - detectTime
		if (elapsed > alarm_delay)
			triggerAlarm()
	else if (detectTime == -1)
		for (var/mob/target as anything in motionTargets)
			if(QDELETED(target) || target.stat == DEAD)
				lostTarget(target)
				continue
			// If not detecting with motion camera...
			if (!area_motion)
				// See if the camera is still in range
				if(!in_range(src, target))
					// If they aren't in range, lose the target.
					lostTarget(target)

/obj/machinery/camera/proc/newTarget(mob/target)
	if (!target.mouse_opacity || target.alpha < 50)
		return
	if (isAI(target)) return 0
	if (detectTime == 0)
		detectTime = world.time // start the clock
	if (!(target in motionTargets))
		motionTargets += target
	return 1

/obj/machinery/camera/proc/lostTarget(mob/target)
	motionTargets -= target
	if (motionTargets.len == 0)
		cancelAlarm()

/obj/machinery/camera/proc/cancelAlarm()
	if (detectTime == -1)
		for (var/mob/living/silicon/aiPlayer in player_list)
			if (status) aiPlayer.cancelAlarm("Motion", get_area(src), src)
	detectTime = 0
	return 1

/obj/machinery/camera/proc/triggerAlarm()
	if (!detectTime) return 0
	for (var/mob/living/silicon/aiPlayer in player_list)
		if (status) aiPlayer.triggerAlarm("Motion", get_area(src), list(src), src)
	detectTime = -1
	return 1

/obj/machinery/camera/HasProximity(atom/movable/AM)
	// Motion cameras outside of an "ai monitored" area will use this to detect stuff.
	if(isliving(AM))
		newTarget(AM)
