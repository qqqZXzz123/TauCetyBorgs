#define JOB_MODIFICATION_MAP_NAME "Old Sparrow"

/datum/job/assistant/New()
	..()
	MAP_JOB_CHECK
	skillsets = list(
		"Test Subject" = /datum/skillset/oldsparrow/test_subject,
		"Mecha Operator" = /datum/skillset/oldsparrow/test_subject/mecha
		)

/datum/job/cyborg/New()
	..()
	MAP_JOB_CHECK
	total_positions = 0
	spawn_positions = 1
	minimal_player_ingame_minutes = 2400

/datum/job/ai/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 3600

/datum/job/rd/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 3600
	skillsets = list("Research Director" = /datum/skillset/oldsparrow/rd)

/datum/job/scientist/New()
	..()
	MAP_JOB_CHECK
	access += list(access_robotics)
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 1200
	skillsets = list("Scientist" = /datum/skillset/oldsparrow/scientist)

/datum/job/research_assistant/New()
	..()
	MAP_JOB_CHECK
	access += list(access_tox, access_xenoarch)
	total_positions = 1
	spawn_positions = 1
	skillsets = list("Research Assistant" = /datum/skillset/oldsparrow/scientist)

/datum/job/captain/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 7200
	skillsets = list("Captain" = /datum/skillset/oldsparrow/captain)

/datum/job/hop/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 3600
	skillsets = list("Head of Personnel" = /datum/skillset/oldsparrow/hop)

/datum/job/hos/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 6000
	skillsets = list("Head of Security" = /datum/skillset/oldsparrow/hos)

/datum/job/detective/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 1800
	skillsets = list("Detective" = /datum/skillset/oldsparrow/detective)

/datum/job/officer/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 1800
	skillsets = list("Security Officer" = /datum/skillset/oldsparrow/officer)

/datum/job/cadet/New()
	..()
	MAP_JOB_CHECK
	access += list(access_security)
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 600
	skillsets = list("Security Cadet" = /datum/skillset/oldsparrow/officer)

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

/datum/job/intern/New()
	..()
	MAP_JOB_CHECK
	access += list(access_morgue, access_surgery, access_maint_tunnels, access_medbay_storage)
	total_positions = 1
	spawn_positions = 1
	skillsets = list("Medical Intern" = /datum/skillset/oldsparrow/doctor)

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

/datum/job/technical_assistant/New()
	..()
	MAP_JOB_CHECK
	access += list(access_engine, access_engine_equip, access_external_airlocks)
	total_positions = 1
	spawn_positions = 1
	skillsets = list("Technical Assistant" = /datum/skillset/oldsparrow/engineer)

/datum/job/chef/New()
	..()
	MAP_JOB_CHECK
	access += list(access_engine, access_engine_equip, access_external_airlocks)
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 120
	skillsets = list("Chef" = /datum/skillset/oldsparrow/chef)

/datum/job/chaplain/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 240
	skillsets = list("Chaplain" = /datum/skillset/oldsparrow/chaplain)

/datum/job/qm/New()
	..()
	MAP_JOB_CHECK
	minimal_player_ingame_minutes = 900
	skillsets = list("Quartermaster" = /datum/skillset/oldsparrow/quartermaster)

/datum/job/mining/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 600
	skillsets = list("Shaft Miner" = /datum/skillset/oldsparrow/miner)

/datum/job/recycler/New()
	..()
	MAP_JOB_CHECK
	total_positions = 1
	spawn_positions = 1
	minimal_player_ingame_minutes = 300
	skillsets = list("Recycler" = /datum/skillset/oldsparrow/recycler)

//MAP_REMOVE_JOB(barber)

//MAP_REMOVE_JOB(cargo_tech)

//MAP_REMOVE_JOB(hydro)

//MAP_REMOVE_JOB(janitor)

//MAP_REMOVE_JOB(librarian)

//MAP_REMOVE_JOB(lawyer)

//MAP_REMOVE_JOB(mime)

//MAP_REMOVE_JOB(atmos)

//MAP_REMOVE_JOB(paramedic)

//MAP_REMOVE_JOB(chemist)

//MAP_REMOVE_JOB(geneticist)

//MAP_REMOVE_JOB(virologist)

//MAP_REMOVE_JOB(psychiatrist)

//MAP_REMOVE_JOB(xenoarchaeologist)

//MAP_REMOVE_JOB(xenobiologist)

//MAP_REMOVE_JOB(roboticist)

//MAP_REMOVE_JOB(warden)

//MAP_REMOVE_JOB(forensic)

//MAP_REMOVE_JOB(blueshield)

#undef JOB_MODIFICATION_MAP_NAME
