#define JOB_MODIFICATION_MAP_NAME "Old Sparrow"













/datum/job/captain/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 7200
	skillsets = list("Captain" = /datum/skillset/oldsparrow/captain)


/datum/job/officer/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 1800
	skillsets = list("Security Officer" = /datum/skillset/oldsparrow/officer)

/datum/job/cmo/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 3600
	skillsets = list("Chief Medical Officer" = /datum/skillset/oldsparrow/cmo)

/datum/job/doctor/New()
	..()
	MAP_JOB_CHECK
	access += list(access_external_airlocks, access_sec_doors, access_research, access_mailsorting, access_engineering_lobby)
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 900
	skillsets = list("Medical Doctor" = /datum/skillset/oldsparrow/doctor)

/datum/job/chief_engineer/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 3600
	skillsets = list("Chief Engineer" = /datum/skillset/oldsparrow/ce)

/datum/job/engineer/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 600
	skillsets = list("Station Engineer" = /datum/skillset/oldsparrow/engineer)

/datum/job/chef/New()
	..()
	MAP_JOB_CHECK
	access += list(access_engine, access_engine_equip, access_external_airlocks)
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 120
	skillsets = list("Chef" = /datum/skillset/oldsparrow/chef)

/datum/job/qm/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 900
	skillsets = list("Quartermaster" = /datum/skillset/oldsparrow/quartermaster)

/datum/job/mining/New()
	..()
	MAP_JOB_CHECK
	total_positions = 3
	spawn_positions = 1
	minimal_player_ingame_minutes = 600
	skillsets = list("Shaft Miner" = /datum/skillset/oldsparrow/miner)

MAP_REMOVE_JOB(barber)

MAP_REMOVE_JOB(cargo_tech)

MAP_REMOVE_JOB(hydro)

MAP_REMOVE_JOB(janitor)

MAP_REMOVE_JOB(librarian)

MAP_REMOVE_JOB(lawyer)

MAP_REMOVE_JOB(mime)

MAP_REMOVE_JOB(atmos)

MAP_REMOVE_JOB(paramedic)

MAP_REMOVE_JOB(chemist)

MAP_REMOVE_JOB(geneticist)

MAP_REMOVE_JOB(virologist)

MAP_REMOVE_JOB(psychiatrist)

MAP_REMOVE_JOB(xenoarchaeologist)

MAP_REMOVE_JOB(xenobiologist)

MAP_REMOVE_JOB(roboticist)

MAP_REMOVE_JOB(warden)

MAP_REMOVE_JOB(forensic)

MAP_REMOVE_JOB(blueshield)

MAP_REMOVE_JOB(assistant)

MAP_REMOVE_JOB(cyborg)

MAP_REMOVE_JOB(ai)

MAP_REMOVE_JOB(rd)

MAP_REMOVE_JOB(scientist)

MAP_REMOVE_JOB(research_assistant)

MAP_REMOVE_JOB(hop)

MAP_REMOVE_JOB(hos)

MAP_REMOVE_JOB(detective)

MAP_REMOVE_JOB(cadet)

MAP_REMOVE_JOB(intern)

MAP_REMOVE_JOB(technical_assistant)

MAP_REMOVE_JOB(chaplain)

MAP_REMOVE_JOB(recycler)

#undef JOB_MODIFICATION_MAP_NAME
