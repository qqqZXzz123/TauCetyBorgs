#define ARCHAEO_BOWL 1
#define ARCHAEO_URN 2
#define ARCHAEO_CUTLERY 3
#define ARCHAEO_STATUETTE 4
#define ARCHAEO_INSTRUMENT 5
#define ARCHAEO_KNIFE 6
#define ARCHAEO_COIN 7
#define ARCHAEO_HANDCUFFS 8
#define ARCHAEO_BEARTRAP 9
#define ARCHAEO_PIPBOY 10
#define ARCHAEO_BOX 11
#define ARCHAEO_GASTANK 12
#define ARCHAEO_TOOL 13
#define ARCHAEO_METAL 14
#define ARCHAEO_PEN 15
#define ARCHAEO_CRYSTAL 16
#define ARCHAEO_CULTBLADE 17
#define ARCHAEO_TELEBEACON 18
#define ARCHAEO_CLAYMORE 19
#define ARCHAEO_CULTROBES 20
#define ARCHAEO_SOULSTONE 21
#define ARCHAEO_MINER_HUD 22
#define ARCHAEO_RODS 23
#define ARCHAEO_STOCKPARTS 24
#define ARCHAEO_KATANA 25
#define ARCHAEO_LASER 26
#define ARCHAEO_GUN 27
#define ARCHAEO_UNKNOWN 28
#define ARCHAEO_FOSSIL 29
#define ARCHAEO_SHELL 30
#define ARCHAEO_PLANT 31
#define ARCHAEO_REMAINS_HUMANOID 32
#define ARCHAEO_REMAINS_ROBOT 33
#define ARCHAEO_REMAINS_XENO 34
#define ARCHAEO_GASMASK 35
#define ARCHAEO_STRANGETOOL 36
#define ARCHAEO_WATER 37

#define FINDS_MERCURY list(ARCHAEO_BOWL, ARCHAEO_URN, ARCHAEO_CUTLERY, ARCHAEO_STATUETTE, ARCHAEO_INSTRUMENT, ARCHAEO_HANDCUFFS,\
                           ARCHAEO_BEARTRAP, ARCHAEO_BOX, ARCHAEO_GASTANK, ARCHAEO_UNKNOWN, ARCHAEO_STRANGETOOL)

#define FINDS_CARBON list(ARCHAEO_FOSSIL, ARCHAEO_SHELL, ARCHAEO_PLANT, ARCHAEO_REMAINS_HUMANOID,ARCHAEO_REMAINS_ROBOT,\
                          ARCHAEO_REMAINS_XENO, ARCHAEO_GASMASK, ARCHAEO_WATER)

#define FINDS_IRON list(ARCHAEO_COIN, ARCHAEO_KNIFE, ARCHAEO_TOOL, ARCHAEO_METAL,ARCHAEO_CLAYMORE,ARCHAEO_RODS, ARCHAEO_KATANA,\
                         ARCHAEO_LASER, ARCHAEO_GUN)

#define FINDS_NITRO list(ARCHAEO_CRYSTAL, ARCHAEO_SOULSTONE, ARCHAEO_MINER_HUD)

#define FINDS_POTASSIUM list(ARCHAEO_CULTBLADE, ARCHAEO_TELEBEACON, ARCHAEO_CULTROBES, ARCHAEO_STOCKPARTS)

//eggs
//droppings
//footprints
//alien clothing

//DNA sampling from fossils, or a new archaeo type specifically for it?

//descending order of likeliness to spawn
#define DIGSITE_GARDEN 1
#define DIGSITE_ANIMAL 2
#define DIGSITE_HOUSE 3
#define DIGSITE_TECHNICAL 4
#define DIGSITE_TEMPLE 5
#define DIGSITE_WAR 6

/proc/get_responsive_reagent(find_type)
	if(find_type in FINDS_MERCURY)
		return "mercury"
	if(find_type in FINDS_IRON)
		return "iron"
	if(find_type in FINDS_NITRO)
		return "nitrogen"
	if(find_type in FINDS_POTASSIUM)
		return "potassium"
	return "phoron"

// see /turf/simulated/mineral/New() in code/modules/mining/mine_turfs.dm
/proc/get_random_digsite_type()
	return pick(100;DIGSITE_GARDEN,95;DIGSITE_ANIMAL,90;DIGSITE_HOUSE,85;DIGSITE_TECHNICAL,80;DIGSITE_TEMPLE,75;DIGSITE_WAR)

/proc/get_random_find_type(digsite)

	var/find_type = 0
	switch(digsite)
		if(DIGSITE_GARDEN)
			find_type = pick(
			100;ARCHAEO_PLANT,
			25;ARCHAEO_SHELL,
			25;ARCHAEO_FOSSIL
			)
		if(DIGSITE_ANIMAL)
			find_type = pick(
			100;ARCHAEO_FOSSIL,
			50;ARCHAEO_SHELL,
			50;ARCHAEO_PLANT,
			25;ARCHAEO_BEARTRAP
			)
		if(DIGSITE_HOUSE)
			find_type = pick(
			100;ARCHAEO_BOWL,
			100;ARCHAEO_URN,
			100;ARCHAEO_CUTLERY,
			100;ARCHAEO_STATUETTE,
			100;ARCHAEO_INSTRUMENT,
			100;ARCHAEO_PEN,
			100;ARCHAEO_PIPBOY,
			100;ARCHAEO_BOX,
			75;ARCHAEO_GASMASK,
			75;ARCHAEO_COIN,
			75;ARCHAEO_UNKNOWN,
			50;ARCHAEO_MINER_HUD,
			50;ARCHAEO_RODS,
			25;ARCHAEO_METAL,
			10;ARCHAEO_WATER
			)
		if(DIGSITE_TECHNICAL)
			find_type = pick(
			125;ARCHAEO_GASMASK,
			100;ARCHAEO_METAL,
			100;ARCHAEO_GASTANK,
			100;ARCHAEO_TELEBEACON,
			100;ARCHAEO_TOOL,
			100;ARCHAEO_STOCKPARTS,
			75;ARCHAEO_MINER_HUD,
			75;ARCHAEO_STRANGETOOL,
			75;ARCHAEO_RODS,
			75;ARCHAEO_UNKNOWN,
			50;ARCHAEO_HANDCUFFS
			)
		if(DIGSITE_TEMPLE)
			find_type = pick(
			200;ARCHAEO_CULTROBES,
			200;ARCHAEO_STATUETTE,
			100;ARCHAEO_URN,
			100;ARCHAEO_BOWL,
			100;ARCHAEO_KNIFE,
			100;ARCHAEO_CRYSTAL,
			75;ARCHAEO_CULTBLADE,
			50;ARCHAEO_SOULSTONE,
			50;ARCHAEO_UNKNOWN,
			25;ARCHAEO_HANDCUFFS,
			25;ARCHAEO_BEARTRAP,
			10;ARCHAEO_KATANA,
			10;ARCHAEO_CLAYMORE,
			10;ARCHAEO_MINER_HUD,
			10;ARCHAEO_RODS,
			10;ARCHAEO_METAL,
			10;ARCHAEO_GASMASK
			)
		if(DIGSITE_WAR)
			find_type = pick(
			100;ARCHAEO_GUN,
			100;ARCHAEO_KNIFE,
			75;ARCHAEO_LASER,
			75;ARCHAEO_KATANA,
			75;ARCHAEO_CLAYMORE,
			50;ARCHAEO_UNKNOWN,
			50;ARCHAEO_CULTROBES,
			50;ARCHAEO_CULTBLADE,
			50;ARCHAEO_GASMASK,
			25;ARCHAEO_HANDCUFFS,
			25;ARCHAEO_BEARTRAP,
			25;ARCHAEO_TOOL
			)
	return find_type

var/global/list/responsive_carriers = list(
	"carbon",
	"potassium",
	"hydrogen",
	"nitrogen",
	"mercury",
	"iron",
	"chlorine",
	"phosphorus",
	"phoron")

var/global/list/finds_as_strings = list(
	"Trace organic cells",
	"Long exposure particles",
	"Trace water particles",
	"Crystalline structures",
	"Metallic derivative",
	"Metallic composite",
	"Metamorphic/igneous rock composite",
	"Metamorphic/sedimentary rock composite",
	"Anomalous material")

#undef ARCHAEO_BOWL
#undef ARCHAEO_URN
#undef ARCHAEO_CUTLERY
#undef ARCHAEO_STATUETTE
#undef ARCHAEO_INSTRUMENT
#undef ARCHAEO_KNIFE
#undef ARCHAEO_COIN
#undef ARCHAEO_HANDCUFFS
#undef ARCHAEO_BEARTRAP
#undef ARCHAEO_PIPBOY
#undef ARCHAEO_BOX
#undef ARCHAEO_GASTANK
#undef ARCHAEO_TOOL
#undef ARCHAEO_METAL
#undef ARCHAEO_PEN
#undef ARCHAEO_CRYSTAL
#undef ARCHAEO_CULTBLADE
#undef ARCHAEO_TELEBEACON
#undef ARCHAEO_CLAYMORE
#undef ARCHAEO_CULTROBES
#undef ARCHAEO_SOULSTONE
#undef ARCHAEO_MINER_HUD
#undef ARCHAEO_RODS
#undef ARCHAEO_STOCKPARTS
#undef ARCHAEO_KATANA
#undef ARCHAEO_LASER
#undef ARCHAEO_GUN
#undef ARCHAEO_UNKNOWN
#undef ARCHAEO_FOSSIL
#undef ARCHAEO_SHELL
#undef ARCHAEO_PLANT
#undef ARCHAEO_REMAINS_HUMANOID
#undef ARCHAEO_REMAINS_ROBOT
#undef ARCHAEO_REMAINS_XENO
#undef ARCHAEO_GASMASK
#undef ARCHAEO_STRANGETOOL
#undef FINDS_MERCURY
#undef FINDS_CARBON
#undef FINDS_IRON
#undef FINDS_NITRO
#undef FINDS_POTASSIUM
#undef DIGSITE_GARDEN
#undef DIGSITE_ANIMAL
#undef DIGSITE_HOUSE
#undef DIGSITE_TECHNICAL
#undef DIGSITE_TEMPLE
#undef DIGSITE_WAR
