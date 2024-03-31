// ********************************************************************* \\
//    █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█    █▀█ █▀▀    █▀▄ █▀▀ █▀ ▀█▀ █ █▄░█ █▄█   \\
//    ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀    █▄█ █▀░    █▄▀ ██▄ ▄█ ░█░ █ █░▀█ ░█░   \\
// ********************************************************************* \\
// #ID = 3945
// md5: 2991ecdb4d9a22dc40511b241bfb59a4 - USA
// Platform: PlayStation Portable
// Achievement Guide: https://github.com/RetroAchievements/guides/wiki/Shadow-of-Destiny-(PlayStation-Portable)
// RA Game Page: https://retroachievements.org/game/3945

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //     DEVELOPER NOTES      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

// Info regarding usage/reading this RAScript
// ---------------------------------------------
//	- Set indent mode => Tabs			
//	- Set indent size => 4

//	- Use RATools to update achievement logic written here to RALibrertro
//	- Use RALibretro/RATools to publish/push the achievement logic to RetroAchievements servers
//	- Documentation for achievement development => https://docs.retroachievements.org/Developer-Docs/
//		-- Rich Presence documentation => https://docs.retroachievements.org/Rich-Presence/ AND https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions
//			--- Rich Presence Macro's => https://docs.retroachievements.org/Rich-Presence/#macros
//			--- To Test RP via RATools, same as updating achievement logic, but afteran  RP update => restart RALibretro OR keep the following file op in an editor: ..\RALibretro\RACache\Data\XXX-Rich.txt 
//	- Documentation for RALibretro => https://docs.retroachievements.org/Developer-Docs/
//	- Documentation for RATools => https://github.com/Jamiras/RATools/wiki

// Nomenclature / Naming Convention
// ---------------------------------------------
//	- current_ 	=> returns a memory accessor to the current value
//	- prior_ 	=> returns a memory accessor to the prior value
//	- prev_ 	=> returns a memory accessor to the previous/delta value
//
//	- is_		=> returns a comparison, which only uses current values					-> eg is_Area(id_area) => id_area == byte(0xAA)
//	- was_		=> returns a comparison, which only uses prior values					-> eg was_inArea(id_area) => id_area == prior(byte(0xAA))
//	- has_ 		=> returns a comparison, which uses current AND prior values			-> eg has_movedToArea(id_area) => id_area == prior(byte(0xAA)) && id_area-1 == byte(0xAA)
//	- on_		=> returns a comparison, which uses at least one delta/previous values	-> eg on_Area_change() => current_Area() != prev_Area()

//	Visual Studio Code: specific info
// ---------------------------------------------
//	- Enable: Colored code => select language mode (bottom right of vscode window) => Go (not "plain text")
//	- Enable: Todo Tree tags => install extension: 'Todo Tree' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
// 	- Markdown editing
//		-- Enable: Markdown Enhanced Preview => Install extension: 'Markdown Preview Enhanced' by 'Yiyi Wang'

// General info regarding PSP structures
// ---------------------------------------------
// 	- PSP pointers usually start with 08 or 09 + 25-bit => mask with 0x1ffffff
 
//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// TODO debug off
util_isDebugModeActive = false	// if true => extra information may be displayed on achievement titles & descriptions
util_language = "en"	// ISO 639-1 language codes 

iNULL = -1
sNULL = "-1"

function util_throwError(string_errMsg) {	// This function will throw an error in RATools because the key doesn't exist
	let_dict = {}
	return let_dict[format("ERROR: {0}", string_errMsg)]}

function util_addToDictionary(dict, key, value) {
	dict[key] = value}

function sysUtil_maskPointer(ptr) =>
	ptr & 0x1FFFFFF	// <-- 0x1FFFFFF: masks 32-bit value to 25-bit (PSP uses 25-bit pointers)

function never_toAlt(comparison) =>
	(
		(
			never(comparison)
		) || (
			always_false()
		)
	)

// ***************************************************************************************************************************************************************** \\
//																																									 \\
//   ███╗   ███╗███████╗███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║██████╔╝ ╚████╔╝     ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗    ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║██╔══██╗  ╚██╔╝      ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝██║  ██║   ██║       ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																									 \\
// ***************************************************************************************************************************************************************** \\

function memUtil_floatToInt(float_value) =>				// Function will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	high4(0x1FFFFF0) + float_value + high4(0x1FFFFF0)	// 	- RAtools will clean => 	```0 + float(0xaa) + 0´´´	 -->	```float(0xa)´´´
														// 	- Workaround is the following => 	```byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)´´´
														//	$1FFFFF0: [NTSC-U/C][Upper4] Always_Null || Value_Never_Changes

memory_dataStructures = {
	"Struct_DateTime": {
		"sizeInBytes": 24,
		"offsets": {
			"32bit_Years": 0x0,
			"32bit_Months": 0x4,
			"32bit_Days": 0x8,
			"32bit_Hours": 0xc,
			"32bit_Minutes": 0x10,
			"32bit_Seconds": 0x14
		}
	}
}

function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_offsetKey) =>
	memory_dataStructures[string_structKey]["offsets"][string_offsetKey]
// -------------------------------------
USA = "NTSC-U/C"
EU = "PAL"
JP = "NTSC-J"
memory_addresses = {
	"32bit_TimePeriod":	{USA: 0xAA1268, EU: iNULL, JP: iNULL},
	"Struct_DateTime_Present": {USA: 0xAA12A4, EU: iNULL, JP: iNULL},
}

function memory_initialize() {	// FUNCTION: Use this function, when all address are offset. Don't forget to uncomment this function call in initialization code
	let_EUoffset = 0x10
	let_JPoffset = 0x20
	for memAddrKey in memory_addresses {
		let_USAaddr = memory_addresses[memAddrKey][USA]
		if(let_USAaddr == iNULL) util_throwError("Memory Address for {0} is NULL", memAddrKey)
		memory_addresses[memAddrKey][EU] = let_USAaddr + let_EUoffset
		memory_addresses[memAddrKey][JP] = let_USAaddr + let_JPoffset
	}
}

function memory_getAddress(string_addrKey, string_regionCode) => 
	memory_addresses[string_addrKey][string_regionCode]

// *******************
// ◦ PLAYER POSITION ◦
// *******************
// Functions to check player position are deprecated
function is_PlayerPosition_Xaxis_Near(hex_value) =>		// $A8ABD0: [NTSC-U/C][Float] Player Position - x-Axis
	hex_value + 0x834 >= memUtil_floatToInt(float(0xA8ABD0)) &&	
	memUtil_floatToInt(float(0xA8ABD0)) >= hex_value - 0x834

function is_PlayerPosition_Yaxis_Near(int_value) =>		// $A8ABD8: [NTSC-U/C][Float] Player Position - y-Axis
	hex_value + 0x834 >= memUtil_floatToInt(float(0xA8ABD8)) &&
	memUtil_floatToInt(float(0xA8ABD8)) >= hex_value - 0x834

// *****************
// ◦ TIME AND DATE ◦
// *****************
TIMEPERIOD_MiddleAges = 104
TIMEPERIOD_Early20thCentury = 103
TIMEPERIOD_Late20thCentury = 102
TIMEPERIOD_Present = 101
const_TimePeriod_IDs = {
	TIMEPERIOD_Present: {"IDs": [0x83]},
	TIMEPERIOD_Late20thCentury: {"IDs": [0x82,0x88]},
	TIMEPERIOD_Early20thCentury: {"IDs": [0x81]},
	TIMEPERIOD_MiddleAges:{"IDs": [0x80]}}

function current_TimePeriod() =>	// $AA1268: [32-bit] Time Period
	dword(0xAA1268)					//		0x80 => Middle ages 1500s
									// 		0x81 => Early 20th Century 1900s
									// 		0x82 => Late 20th Century 1980
									// 		0x88 => Late 20th Century 1979
									// 		0x83 => Present 2000s

function get_TimePeriodIDs(enum_timePeriod, int_idIndex = 0) =>
	const_TimePeriod_IDs[enum_timePeriod]["IDs"][int_idIndex]

// -------------------------------------
DATETIME_Present = 100
const_DateTime_memAddr = {
	DATETIME_Present: {
		USA: () => memory_getAddress("Struct_DateTime_Present", USA),
		EU: () => memory_getAddress("Struct_DateTime_Present", EU),
	}
}

function get_DateTime_BaseAddr(enum_dateTime, enum_region) => 
	const_DateTime_memAddr[enum_dateTime][enum_region]

function get_DateTime_Seconds(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Seconds"))

function get_DateTime_Minutes(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Minutes"))

function get_DateTime_Hours(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Hours"))

function get_DateTime_Days(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Days"))

function get_DateTime_Months(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Months"))

function get_DateTime_Years(enum_dateTime, enum_region) =>
	dword(get_DateTime_BaseAddr(enum_dateTime, enum_region) + memory_getDataStructOffset("Struct_DateTime","32bit_Years"))

function current_PresentTime_Hours() =>		// $AA12B0: [32-bit] Time in present: hours
	get_DateTime_Hours()

function current_PresentTime_Minutes() =>	// $AA12B4: [32-bit] Time in present: minutes
	dword(0xAA12B4)

function current_PresentTime_Seconds() =>	// $AA12B8: [32-bit] Time in present: seconds
	dword(0xAA12B8)

function current_PresentTime_Days() =>		// $AA12AC: [32-bit] Time in present: days
	dword(0xAA12AC)

function current_PresentTime_Months() =>	// $AA12A8: [32-bit] Time in present: months
	dword(0xAA12A8)

function current_PresentTime_Years() =>		// $AA12A4: [32-bit] Time in present: years
	dword(0xAA12A4)
// **********************
// ◦ CLEAR TIME: TIMERS ◦
// **********************
function current_ChapterClearTime() =>	// $AA155C: [32-bit] Current Playthrough Timer - Chapter Clear Time
	dword(0xAA155C)
	
function prev_ChapterClearTime() =>
	prev(current_ChapterClearTime())

function get_Timer_ChapterClearTime_InSeconds() =>
	current_ChapterClearTime() / 60

function on_Timer_ChapterClearTime_start() => 
	prev_ChapterClearTime() == 0 &&
	current_ChapterClearTime() > 0

function on_Timer_ChapterClearTime_reset() =>
	current_ChapterClearTime() < prev_ChapterClearTime()
// -------------------------------------
function current_TotalClearTime() =>	// $AA1560: [32-bit] Current Playthrough Timer - Total Clear Time
	dword(0xAA1560)

function prev_TotalClearTime() =>
	prev(current_TotalClearTime())

function get_Timer_TotalClearTime_InMinutes() =>
	current_TotalClearTime() / 3600

function on_Timer_TotalClearTime_valueChange() => 
	current_TotalClearTime() != prev_TotalClearTime()

function on_Timer_TotalClearTime_start() => 
	prev_TotalClearTime() == 0 &&
	current_TotalClearTime() > 0

function on_Timer_TotalClearTime_reset() =>
	current_TotalClearTime() < prev_TotalClearTime()

// ****************
// ◦ INTERACTIONS ◦
// ****************
NPC_MiddleAges_AspiringApprentice 	= 504
NPC_MiddleAges_EccentricGirl 		= 503
NPC_MiddleAges_YoungCoupleMan 		= 502
NPC_MiddleAges_YoungCoupleWoman 	= 501
NPC_MiddleAges_StrawHatMan 			= 500
NPC_80s_OlderMan 	= 302
NPC_80s_Barman 		= 301
NPC_80s_JoggingMan 	= 300
NPC_Present_JoggingMan 					= 110
NPC_Present_CoatedMan 					= 109
NPC_Present_CoatedWoman 				= 108
NPC_Present_SlimDelinquent 				= 107
NPC_Present_BroadDelinquent 			= 106
NPC_Present_BlondeElderlyWoman 			= 105
NPC_Present_BrunetteAdultManGlasses 	= 104
NPC_Present_BlondeOldWomanOrangeSweater	= 103
NPC_Present_BrunetteYoungGirl 			= 102
NPC_Present_BrunetteMother 				= 101
NPC_Present_BlondeYoungBoy				= 100
const_NPCs_data = {	// TODO add ids to correspnoding code note
	// "xxxtemplatexxxx": { 
	// 	"ID": 0x00000, "Appearance": {
	// 		"xxxxxtemplatexxxxxxx": {"memAddr_TalkCount": 0x000000, "maxTalkCount": 0000}}},
	NPC_Present_BlondeYoungBoy: { 
		"ID": 0x187, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": 0xA9EEF8, "maxTalkCount": 2}}},
	NPC_Present_BrunetteMother: { 
		"ID": 0x46,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": 0xA9EE92, "maxTalkCount": 1}}},
	NPC_Present_BrunetteYoungGirl: { 
		"ID": 0x42,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": 0xA9EE7F, "maxTalkCount": 1}}},
	NPC_Present_BlondeOldWomanOrangeSweater: { 
		"ID": 0x44, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": 0xA9EE88, "maxTalkCount": 1}}},
	NPC_Present_BrunetteAdultManGlasses: { 
		"ID": 0x195, "Appearance": {
			"Chap4_WearingPerformerOutfit": always_false()}},	// Has no memory address for talk count
	NPC_Present_BlondeElderlyWoman: { 
		"ID": 0x183, "Appearance": {
			"Chap4_WearingPerformerOutfit": always_false()}},	// Has no memory address for talk count
	NPC_Present_BroadDelinquent: { 
		"ID": 0x10, "Appearance": {
			"Chap7_CarPark": {"memAddr_TalkCount": 0xA9EE4C, "maxTalkCount": 1}}},
	NPC_Present_SlimDelinquent: { 
		"ID": 0x13, "Appearance": {
			"Chap7_CarPark": {"memAddr_TalkCount": 0xA9EE51, "maxTalkCount": 1}}},
	NPC_Present_CoatedWoman: { 
		"ID": 0x57,	"Appearance": {
			"Chap1Prologue_TownSquare": {"memAddr_TalkCount": 0xA9EE28, "maxTalkCount": 2},
			"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar": {"memAddr_TalkCount": 0xA9EE2C, "maxTalkCount": 2}, // <-- Chap3-4 use same memAddr as they use same dialogue
			"Chap5_NearCafeSonne": {"memAddr_TalkCount": 0xA9EE31, "maxTalkCount": 1},
			"Chap7_SouthGate": {"memAddr_TalkCount": 0xA9EE2F, "maxTalkCount": 2}}},
	NPC_Present_CoatedMan: { 
		"ID": 0x56, "Appearance": {
			"Chap1Prologue_NearBar": {"memAddr_TalkCount": 0xA9EE1D, "maxTalkCount": 2},
			"Chap3_NearAntiqueShop": {"memAddr_TalkCount": 0xA9EE20, "maxTalkCount": 2},
			"Chap4_HaupStrUnderArch": {"memAddr_TalkCount": 0xA9EE21, "maxTalkCount": 2},
			"Chap5_NorthEastGate_BrumLibrary": {"memAddr_TalkCount": 0xA9EE25, "maxTalkCount": 1},
			"Chap5_NorthEastGate_BrumMuseum": {"memAddr_TalkCount": 0xA9EE26, "maxTalkCount": 2},
			"Chap7_NorthWestGate": {"memAddr_TalkCount": 0xA9EE24, "maxTalkCount": 1}}},
	NPC_Present_JoggingMan: {
		"ID": 0x58},
	NPC_80s_JoggingMan: {
		"ID": 0x59},
	NPC_80s_Barman: { 
		"ID": 0xc, "Appearance": {
			"InsideBar_UsePocketWatchOrEgg": {"memAddr_TalkCount": 0xA9EE49, "maxTalkCount": 1}}},	// Counts for chap 6-7-8
	NPC_80s_OlderMan: { 
		"ID": 0x18d, "Appearance": {
			"Chap6_CafeSonne": {"memAddr_TalkCount": 0xA9EF43, "maxTalkCount": 2}}},	
	NPC_MiddleAges_StrawHatMan: { 
		"ID": 0x5c, "Appearance": {
			"Chap2_Streets_Scare": {"memAddr_TalkCount": 0xA9EE36, "maxTalkCount": 1}}},
	NPC_MiddleAges_YoungCoupleWoman: { 
		"ID": 0x197, "Appearance": {
			"Chap2_WestGate_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF7C, "maxTalkCount": 1},
			"Chap2_WestGate_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF7D, "maxTalkCount": 1},
			"Chap2_EastNearHay_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF7E, "maxTalkCount": 1},
			"Chap3_NearNorthEastGate_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF7E, "maxTalkCount": 1},
			"Chap3_NearNorthEastGate_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF80, "maxTalkCount": 1},
			"Chap3_OutsideChurch_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF81, "maxTalkCount": 1},
			"Chap4_OutsideChurch_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF82, "maxTalkCount": 1},
			"Chap4_OutsideChurch_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF83, "maxTalkCount": 1},	
			"Chap4_NearBakery_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF84, "maxTalkCount": 1},	//	WARNING => uses same MemAddrTalkCount as Chap7_TownSquare
			"Chap7_TownSquare": {"memAddr_TalkCount": 0xA9EF84, "maxTalkCount": 1},						//	WARNING => uses same MemAddrTalkCount as Chap4_OutsideChurch_AfterTalkingToBoth
			"Chap7_TownSquare_Choice": {"memAddr_TalkCount": 0xA9EF85, "maxTalkCount": 2}}},
	NPC_MiddleAges_YoungCoupleMan: { 
		"ID": 0x198, "Appearance": {
			"Chap2_EastNearHay_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF69, "maxTalkCount": 1},
			"Chap2_EastNearHay_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF6A, "maxTalkCount": 1},
			"Chap2_WestGate_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF6B, "maxTalkCount": 1},
			"Chap3_NearWell_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF6C, "maxTalkCount": 1},
			"Chap3_NearWell_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF6D, "maxTalkCount": 1},
			"Chap3_TownSquare_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF6E, "maxTalkCount": 1},
			"Chap4_TownSquare_BeforeTalkingToBoth": {"memAddr_TalkCount": 0xA9EF6F, "maxTalkCount": 1},
			"Chap4_TownSquare_AfterTalkingToBoth": {"memAddr_TalkCount": 0xA9EF70, "maxTalkCount": 1},
			"Chap4_NearBakery_AfterLocationSwitch": {"memAddr_TalkCount": 0xA9EF71, "maxTalkCount": 1},
			"Chap5_NearSouthEastGate": {"memAddr_TalkCount": 0xA9EF72, "maxTalkCount": 2},
			"Chap7_OutsideChurch": {"memAddr_TalkCount": 0xA9EF74, "maxTalkCount": 2},
			"Chap8_OutsideChurch_AfterExperiment_WomanTruthful": {"memAddr_TalkCount": 0xA9EF78, "maxTalkCount": 1}}},
	NPC_MiddleAges_EccentricGirl: { 
		"ID": 0x2e, "Appearance": {
			"Chap2_TownSquare_Scare": {"memAddr_TalkCount": 0xA9EE70, "maxTalkCount": 1}}},
	NPC_MiddleAges_AspiringApprentice: {
		"ID": 0x5d, "Appearance": {
			"Chap2_SouthEastGate_Scare": {"memAddr_TalkCount": 0xA9EE3F, "maxTalkCount": 1}}}}

function get_NPC_Id(enum_npc) => 
	const_NPCs_data[enum_npc]["ID"]

function get_NPC_MaxTalkCount(enum_npc, string_appearance) => 
	const_NPCs_data[enum_npc]["Appearance"][string_appearance]["maxTalkCount"]

function current_NPCtalkCount(enum_npc, string_appearance) {
	let_memAddr = const_NPCs_data[enum_npc]["Appearance"][string_appearance]["memAddr_TalkCount"]
	return byte(let_memAddr)}

function prior_NPCtalkCount(enum_npc, string_appearance) =>
	prior(current_NPCtalkCount(enum_npc, string_appearance))

function prev_NPCtalkCount(enum_npc, string_appearance) =>
	prev(current_NPCtalkCount(enum_npc, string_appearance))

function is_NPCtalkCount_atMax(enum_npc, string_appearance) => 
	current_NPCtalkCount(enum_npc, string_appearance) == get_NPC_MaxTalkCount(enum_npc, string_appearance)

function is_TalkingToNPC_bis(enum_npc) => 		// $A9EFF4: Copy of [32-bit] NPC ID (refer to notes @ 0xa9efdc)
	dword(0xA9EFF4) == get_NPC_Id(enum_npc)		// - Resets to 0x0 when interaction is done

function is_TalkingToNPC(enum_npc) {							// $A9EFDC: [25-bit Pointer] Interactions
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9EFDC))	// 		+0x0 - [32-bit] NPC ID	
	return 														// 		| - This value is copied to 0xa9eff4 (refer to notes)
		get_NPC_Id(enum_npc) == dword(let_maskedPointer)}		// 		| - Unique per interactable NPC or environment item

function has_startedTalkingToNPC_forFirstTime(enum_npc, string_appearance) => 
	prior_NPCtalkCount(enum_npc, string_appearance) < 0x1 &&
	current_NPCtalkCount(enum_npc, string_appearance) == 0x1

function on_NPC_TalkCount_hitsMax(enum_npc, string_appearance) {
	let_maxTalkCount = get_NPC_MaxTalkCount(enum_npc, string_appearance)
	return 
		prev_NPCtalkCount(enum_npc, string_appearance) == let_maxTalkCount - 1 &&	
		current_NPCtalkCount(enum_npc, string_appearance)  == let_maxTalkCount}

function on_NPC_TalkCount_increase(enum_npc, string_appearance) {
	let_talkCount = current_NPCtalkCount(enum_npc, string_appearance)
	return 
		let_talkCount > prev(let_talkCount)}
// -------------------------------------
INTERACTABLE_Antique_Antidote 			= 203
INTERACTABLE_Antique_FranssenShopSign 	= 202
INTERACTABLE_Antique_Mask 				= 201
INTERACTABLE_Antique_Rope 				= 200
INTERACTABLE_Painting_Alchemist 			= 107
INTERACTABLE_Painting_AlchemyLab 			= 106
INTERACTABLE_Painting_CollapsedHouse 		= 105
INTERACTABLE_Painting_LandscapeTown  		= 104
INTERACTABLE_Painting_Performer 			= 103
INTERACTABLE_Painting_SquireCrest 			= 102
INTERACTABLE_Painting_TowerView 			= 101
INTERACTABLE_Painting_TownSquare 			= 100
const_InteractableItem_IDs = {
	INTERACTABLE_Antique_FranssenShopSign: 0x8e,
	INTERACTABLE_Antique_Rope: 0x98,
	INTERACTABLE_Antique_Antidote: 0x79,
	INTERACTABLE_Antique_Mask: 0xc6,
	INTERACTABLE_Painting_SquireCrest: 0x164,
	INTERACTABLE_Painting_TownSquare: 0x165,
	INTERACTABLE_Painting_AlchemyLab: 0x16a,
	INTERACTABLE_Painting_Performer: 0x166,
	INTERACTABLE_Painting_CollapsedHouse: 0x168,
	INTERACTABLE_Painting_TowerView: 0x163,
	INTERACTABLE_Painting_LandscapeTown: 0x169,
	INTERACTABLE_Painting_Alchemist: 0x167}		

function is_InteractingWith_bis(enum_interactableItem) => 
	dword(0xA9EFF4) == const_InteractableItem_IDs[enum_interactableItem]

function is_InteractingWith(enum_interactableItem) {
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9EFDC))
	return const_InteractableItem_IDs[enum_interactableItem] == dword(let_maskedPointer)}

function is_InteractionChapterId(int_Id) {						// $A9EFE0: [25-bit Pointer] Interaction Identification
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9EFE0))	// 		+0x0 - [32-bit] Interaction Chapter ID
	return dword(let_maskedPointer) == int_Id}					//		| - Each chapter has a different value

function is_InteractionId(int_Id) {
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9EFE4))	// $A9EFE4: [25-bit Pointer] Interaction Identification
	return dword(let_maskedPointer) == int_Id}					// 		- Pointer resets to 0x0 when interaction is done
																// 		+0x0 - [32-bit] Interaction ID
// -------------------------------------
function is_LostYoungCoupleProgress_Chapter2(int_flagValue) => 	//	$A9EF89: [8-bit Current Playthrough Flag]  Progress of Young Couple sidequest: Chapter 2
	byte(0xA9EF89) == int_flagValue								// 		0x1 => has talked with 0xa9ef69 AND 0xa9ef7c
																// 		0x2 => has talked with 0xa9ef6a AND 0xa9ef7d
																// 		0x3 => Young couple - Middle Ages - Chapter 2 - have switched positions

function is_LostYoungCoupleProgress_Chapter3(int_flagValue) => 	//	$A9EF8A: [8-bit Current Playthrough Flag]  Progress of Young Couple sidequest: Chapter 3
	byte(0xA9EF8A) == int_flagValue								// 		0x1 => has talked with 0xa9ef6c AND 0xa9ef7f
																// 		0x2 => has talked with 0xa9ef6d AND 0xa9ef80
																// 		0x3 => Young couple - Middle Ages - Chapter 3 - have changed positions

function is_LostYoungCoupleProgress_Chapter4(int_flagValue) => 	//	$A9EF8B: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 4
	byte(0xA9EF8B) == int_flagValue								//		0x1 => has talked with 0xa9ef82 AND 0xa9ef6f
																// 		0x2 => has talked with 0xa9ef83 AND 0xa9ef70
																// 		0x3 => Young couple - Middle Ages - Chapter 4 - have changed positions/respawned

function is_ManToldLoversNeverDestinedMeet() => 	// $A9EF8F: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 8
	bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) ==0  		// 		bit 0 => told the man about the lovers never destined to meet
													// 		bit 1 => told the man to get over it

function is_WomanAdvisedBeTruthful() => //	$A9EF8E: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 7
	byte(0xA9EF8E) >= 0x1				// 		>= 0x1 => advised woman to be truthful
										// 		- Increases by 0x1 after telling woman to be truthful, to a max of 0x1
										//	$SAME-MEMORY-ADDRESS-AS-ABOVE: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - Before Experiment - Only available when this memory address was already >= 0x1
										// 		- Dual purpose memory address
										//		- Talk Counts add on top of above explained count
										// 		- If count was 0 from start, refer to 0xa9ef77
										// 		- Increases by 0x1 with each interaction with the man starts at 0x1 and to a max of 0x3


// ***************************
// ◦ CUTSCENE IDENTIFICATION ◦
// ***************************
function is_LargeCutscene_active() => 	// $A9ED26: Flag: Is cutscene active (preferred)
	byte(0xA9ED26) == 0x5				// 		- 0x00 => no cutscene active
										// 		- 0x01 => black bars (small) cutscene active/transitional value between active-inactive
function is_SmallCutscene_active() => 	//		- ... => transitional values
	byte(0xA9ED26) == 0x1				// 		- 0x05 => cutscene active	

function is_NoCutscene_active() => 
	byte(0xA9ED26) == 0

function on_Cutscene_end() => 						
	prev(byte(0xA9ED26)) > 0x0 &&
	byte(0xA9ED26) == 0x0

function on_CutsceneSection_end() => 
	prev(byte(0xA9ED26)) > 0x3 && 
	0x3 >= byte(0xA9ED26) && byte(0xA9ED26) > 0x0

// -------------------------------------
function is_Cutscene_MasterId(int_Id) => 	// $A9ECBC: [32-bit] Cutscene MASTER ID (preferred)
	dword(0xA9ECBC) == int_Id				// 		- Identifies a cutscene sequence

function was_Cutscene_MasterId(int_Id) => 
	prior(dword(0xA9ECBC)) == int_Id

function on_Cutscene_MasterId_change() => 
	prev(dword(0xA9ECBC)) != dword(0xA9ECBC)

function is_Cutscene_SectionId_1(int_Id) => // $A9ECC0: [16-bit] Cutscene Section ID_1
	word(0xA9ECC0) == int_Id				// 		- Identifies a section from the current cutscene

function is_Cutscene_SectionId_2(int_Id) => // $A9ECC2: [16-bit] Cutscene Section ID_2
	word(0xA9ECC2) == int_Id

function is_Cutscene_MasterDataId(int_Id) {						// $A9ECC8: [25-bit Pointer] Cutscene Identification - Master Data
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9ECC8))	// 		+0x0 - Refers to start of dynamic cutscene memory data block - Data higher than this hex address changes on new cutscene loaded in
	return dword(let_maskedPointer + 0x8) == int_Id}			// 		+0x8 - [32-bit] Cutscene Master Data ID

function is_Cutscene_SectionDataId(int_Id) {					// $A9ECCC: [25-bit Pointer] Cutscene Identification - Section Data
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9ECCC))	// 		+0x0 - Data lower than this hex address changes when the next section in the cutscene starts
	return dword(let_maskedPointer + 0x8) == int_Id}			// 		+0x8 - [32-bit] Cutscene Section Data ID

function is_Cutscene_MinorId(int_Id, int_offset) {				// $A9ECD4: [25-bit Pointer] Cutscene Identification - Minor IDs
	let_maskedPointer = sysUtil_maskPointer(dword(0xA9ECD4))	//	- Pointer active when a cutscene is active
	return dword(let_maskedPointer + int_offset) == int_Id}		// 		+0x0 - Data lower than this point can be used as Minor Cutscene IDs
																// 		+0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID

// ***********************
// ◦ AREA IDENTIFICATION ◦
// ***********************
AREA_MiddleAges_City_Day							= 503
AREA_MiddleAges_City_Night							= 502
AREA_MiddleAges_AlchemistHouse_Exploded_Basement	= 501
AREA_MiddleAges_Church								= 500
AREA_1900s_City				= 401
AREA_1900s_BrumMansion		= 400
AREA_70s_City_Night 	= 300
AREA_80s_Bar					= 203
AREA_80s_AntiquesEule			= 202
AREA_80s_CafeSonne				= 201
AREA_80s_City_Snow				= 200
AREA_Present_BrumMuseum_Upstairs_Room1_Night	= 157
AREA_Present_BrumMuseum_Upstairs_Room1_Day		= 156
AREA_Present_BrumMuseum_Upstairs_Room2_Night	= 155
AREA_Present_BrumMuseum_Upstairs_Room2_Day		= 154
AREA_Present_BrumMuseum_Upstairs_Room3_Night	= 153
AREA_Present_BrumMuseum_Upstairs_Room3_Day		= 152
AREA_Present_BrumMuseum_Downstairs_Room_Night	= 151
AREA_Present_BrumMuseum_Downstairs_Room_Day		= 150
AREA_Present_AntiquesEule		= 105
AREA_Present_TownHall			= 104
AREA_Present_CafeSonne			= 103
AREA_Present_City_NightAM		= 102
AREA_Present_City_NightPM		= 101
AREA_Present_City_Day			= 100
const_Area_IDs= {	// list not complete, add as is necessary
	AREA_MiddleAges_City_Day: 0x3f3,
	AREA_MiddleAges_City_Night: 0x33c,
	AREA_MiddleAges_AlchemistHouse_Exploded_Basement: 0x217,
	AREA_MiddleAges_Church: 0x8e,

	AREA_1900s_City: 0x239,
	AREA_1900s_BrumMansion: 0x603,	

	AREA_70s_City_Night: 0x31d,
	AREA_80s_Bar: 0xf,
	AREA_80s_CafeSonne: 0x15,
	AREA_80s_AntiquesEule: 0x7a,
	AREA_80s_City_Snow: 0x465,

	AREA_Present_AntiquesEule: 0x6f,
	AREA_Present_City_Day: 0x375,
	AREA_Present_City_NightPM: 0x44,
	AREA_Present_City_NightAM: 0x3,
	AREA_Present_CafeSonne: 0x10,
	AREA_Present_TownHall: 0x16,
	AREA_Present_BrumMuseum_Upstairs_Room1_Night: 0x159,
	AREA_Present_BrumMuseum_Upstairs_Room1_Day: 0x38,
	AREA_Present_BrumMuseum_Upstairs_Room2_Night: 0x224,
	AREA_Present_BrumMuseum_Upstairs_Room2_Day: 0x1bd,
	AREA_Present_BrumMuseum_Upstairs_Room3_Night: 0x140,
	AREA_Present_BrumMuseum_Upstairs_Room3_Day: 0xcd,
	AREA_Present_BrumMuseum_Downstairs_Room_Night: 0x32,
	AREA_Present_BrumMuseum_Downstairs_Room_Day: 0x2ed}
function is_Area(enum_area) => 	// $A82E48: [32-bit] Current loaded area
	dword(0xA82E48) == const_Area_IDs[enum_area]	

// *****************
// ◦ CHAPTER LOGIC ◦
// *****************
CHAPTER_Epilogue_NoAncestress 		= 122
CHAPTER_Epilogue_Ancestress 		= 121
CHAPTER_Epilogue 					= 120
CHAPTER_Chapter8_NoAncestress 	= 112 	// <-- If in chapter 5, player told Margarette she is NOT an ancestress
CHAPTER_Chapter8_Ancestress 	= 111		// <-- If in chapter 5, player told Margarette she is an ancestress
CHAPTER_Chapter8 				= 110
CHAPTER_Chapter7 	= 107
CHAPTER_Chapter6 	= 106
CHAPTER_Chapter5 	= 105
CHAPTER_Chapter4 	= 104
CHAPTER_Chapter3 	= 103
CHAPTER_Chapter2 	= 102
CHAPTER_Chapter1 	= 101
CHAPTER_Prologue 	= 100
const_chapter_IDs = {
	CHAPTER_Prologue: 0x1,	// Also counts for EX chapter
	CHAPTER_Chapter1: 0x2,
	CHAPTER_Chapter2: 0x3,
	CHAPTER_Chapter3: 0x4,
	CHAPTER_Chapter4: 0x5,
	CHAPTER_Chapter5: 0x6,
	CHAPTER_Chapter6: 0x7,
	CHAPTER_Chapter7: 0x8,
	CHAPTER_Chapter8_Ancestress: 0x9,
	CHAPTER_Epilogue_Ancestress: 0xa,
	CHAPTER_Chapter8_NoAncestress: 0xb,
	CHAPTER_Epilogue_NoAncestress: 0xc}

function get_ChapterID(enum_chapter) => 
	const_chapter_IDs[enum_chapter]	

function current_ChapterID() => 	// $B95704: [8-bit] Chapter ID
	byte(0xB95704)

function prev_ChapterID() =>
	prev(current_ChapterID())

function is_Chapter(enum_chapter) {	
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			is_Chapter(CHAPTER_Chapter8_NoAncestress) 	|| 
			is_Chapter(CHAPTER_Chapter8_Ancestress)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) {	return
		(
			is_Chapter(CHAPTER_Epilogue_NoAncestress) 	|| 
			is_Chapter(CHAPTER_Epilogue_Ancestress)
		)
	} else { return
		current_ChapterID() == get_ChapterID(enum_chapter)
	}}

function on_Chapter_finish(enum_chapter) {
	if (enum_chapter == CHAPTER_Chapter7) { return 
		prev_ChapterID() == get_ChapterID(CHAPTER_Chapter7) &&
		is_Chapter(CHAPTER_Chapter8)
	} else if (enum_chapter == CHAPTER_Chapter8_Ancestress){ return
		prev_ChapterID() == get_ChapterID(CHAPTER_Chapter8_Ancestress) &&		
		is_Chapter(CHAPTER_Epilogue_Ancestress)
	} else if (enum_chapter == CHAPTER_Chapter8_NoAncestress){ return
		prev_ChapterID() == get_ChapterID(CHAPTER_Chapter8_NoAncestress) &&		
		is_Chapter(CHAPTER_Epilogue_NoAncestress)
	} else { return
		prev_ChapterID() == get_ChapterID(enum_chapter) &&
		current_ChapterID() == get_ChapterID(enum_chapter) + 0x1
	}}

function on_Chapter_change() => 
	current_ChapterID() != prev_ChapterID()

function on_Chapter_changeTo(enum_chapter) {
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			(
				prev_ChapterID() != get_ChapterID(CHAPTER_Chapter8_Ancestress) && 
				current_ChapterID() == get_ChapterID(CHAPTER_Chapter8_Ancestress)
			) || (
				prev_ChapterID() != get_ChapterID(CHAPTER_Chapter8_NoAncestress) && 
				current_ChapterID() == get_ChapterID(CHAPTER_Chapter8_NoAncestress)
			)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) { return
		(
			(
				prev_ChapterID() != get_ChapterID(CHAPTER_Epilogue_Ancestress) && 
				current_ChapterID() == get_ChapterID(CHAPTER_Epilogue_Ancestress)
			) || (
				prev_ChapterID() != get_ChapterID(CHAPTER_Epilogue_NoAncestress) && 
				current_ChapterID() == get_ChapterID(CHAPTER_Epilogue_NoAncestress)
			)
		)
	} else { return 
		prev_ChapterID() != get_ChapterID(enum_chapter) &&
		current_ChapterID() == get_ChapterID(enum_chapter)
	}}

// *******************
// ◦ INVENTORY LOGIC ◦
// *******************
//	- itemScrollBarId => Id of the item in the inventory scrollbar menu
//	- inventoryMemoryAddress => Memory address [bit 0] = 1 => this item is in players inventory
//	- isDefaultItem => true, when player gets this item at start of game
ITEM_AlchemyBook 					= 100
ITEM_Antidote 						= 101
ITEM_BlackWhitePhoto_NoPerformer 	= 102
ITEM_BlackWhitePhoto_WithPerformer	= 103
ITEM_Cake 							= 104
ITEM_Cellphone 						= 105
ITEM_Comb 							= 106
ITEM_Dpad 							= 107
ITEM_EggPocketWatch 				= 108
ITEM_FryingPan 						= 109
ITEM_Jugglery 						= 110
ITEM_Kitten 						= 111
ITEM_LabKey 						= 112
ITEM_Ladder 						= 113
ITEM_LetterToDana 					= 114
ITEM_Lighter 						= 115
ITEM_Map 							= 116
ITEM_Meat 							= 117
ITEM_NewRope 						= 118
ITEM_Notebook 						= 119
ITEM_OldMap 						= 120
ITEM_OldRope 						= 121
ITEM_OrnamentalEgg 					= 122
ITEM_PhilosopherStone 				= 123
ITEM_Postcard 						= 124
ITEM_Sign 							= 125
ITEM_SquireCrest 					= 126
ITEM_TowerKey 						= 127
const_Items_data = { 
	ITEM_Dpad: {	// In PSP version this is called Z-Pad
		"memAddress_Flag_isInInventory": 0xA9F034,	// $A9F034: [Bit 0] Z-pad/D-pad
		"itemScrollBarId": 0x0,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Cellphone: {
		"memAddress_Flag_isInInventory": 0xA9F035,	// $A9F035: [Bit 0] Cellphone
		"itemScrollBarId": 0x1,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Map: {
		"memAddress_Flag_isInInventory": 0xA9F04C,	// $A9F04C: [Bit 0] City map
		"itemScrollBarId": 0x18,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Notebook: {
		"memAddress_Flag_isInInventory": 0xA9F04F,	// $A9F04F: [Bit 0] Notebook
		"itemScrollBarId": 0x1b,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Postcard: {
		"memAddress_Flag_isInInventory": 0xA9F04A,	// $A9F04A: [Bit 0] Letter to dana
		"is_starterItem": true, "is_missableItem": false},
	ITEM_OldMap: {
		"memAddress_Flag_isInInventory": 0xA9F04E,	// $A9F04E: [Bit 0] Old City Map
		"is_starterItem": false, "is_missableItem": true},
	ITEM_OrnamentalEgg: {
		"itemScrollBarId": 0x2,
		"memAddress_Flag_isInInventory": 0xA9F036,	// $A9F036: [Bit 0] Cake
		"is_starterItem": false, "is_missableItem": true},
	ITEM_FryingPan: {
		"itemScrollBarId": 0x4,
		"memAddress_Flag_isInInventory": 0xA9F038,	// $A9F038: [Bit 0] Frying pan
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Sign: {
		"itemScrollBarId": 0x5,
		"memAddress_Flag_isInInventory": 0xA9F039,	// $A9F039: [Bit 0] Photo shop sign
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Lighter: {
		"itemScrollBarId": 0x6,
		"memAddress_Flag_isInInventory": 0xA9F03A,	// $A9F03A: [Bit 0] Lighter
		"is_starterItem": false, "is_missableItem": false},
	ITEM_SquireCrest: {
		"itemScrollBarId": 0xf,
		"memAddress_Flag_isInInventory": 0xA9F043,	// $A9F043: [Bit 0] Squire's crest
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Antidote: {
		"itemScrollBarId": 0x11,
		"memAddress_Flag_isInInventory": 0xA9F045,	// $A9F045: [Bit 0] Antidote
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Jugglery: {
		"itemScrollBarId": 0xc,
		"memAddress_Flag_isInInventory": 0xA9F040,	// $A9F040: [Bit 0] Jugglery
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Cake: {
		"itemScrollBarId": 0x13,
		"memAddress_Flag_isInInventory": 0xA9F047,	// $A9F047: [Bit 0] Cake
		"is_starterItem": false, "is_missableItem": true},
	ITEM_PhilosopherStone: {
		"memAddress_Flag_isInInventory": 0xA9F03D,	// $A9F03D: [Bit 0] Philosopher's stone
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_NoPerformer: {	// This one switches with the other photo once the picture is taken
		"memAddress_Flag_isInInventory": 0xA9F03B,	// $A9F03B: [Bit 0] Black and white photo without performer
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_WithPerformer: {	
		"memAddress_Flag_isInInventory": 0xA9F03C,	// $A9F03C: [Bit 0] Black and white photo with performer
		"is_starterItem": false, "is_missableItem": true},
	ITEM_OldRope: {
		"memAddress_Flag_isInInventory": 0xA9F03F,	// $A9F03F: [Bit 0] Old Rope
		"is_starterItem": false, "is_missableItem": false},
	ITEM_NewRope: {
		"memAddress_Flag_isInInventory": 0xA9F03E,	// $A9F03E: [Bit 0] New Rope
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Comb: {
		"memAddress_Flag_isInInventory": 0xA9F041,	// $A9F041: [Bit 0] Comb
		"is_starterItem": false, "is_missableItem": false},
	ITEM_AlchemyBook: {
		"memAddress_Flag_isInInventory": 0xA9F042,	// $A9F042: [Bit 0] Old alchemist book
		"is_starterItem": false, "is_missableItem": false},
	ITEM_EggPocketWatch: {
		"memAddress_Flag_isInInventory": 0xA9F044,	// $A9F044: [Bit 0] Egg shaped pocket watch
		"itemScrollBarId": 0x10,
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Meat: {
		"memAddress_Flag_isInInventory": 0xA9F046,	// $A9F046: [Bit 0] Scrap of meat
		"is_starterItem": false, "is_missableItem": false},
	ITEM_LabKey: {
		"memAddress_Flag_isInInventory": 0xA9F048,	// $A9F048: [Bit 0] Lab key
		"is_starterItem": false, "is_missableItem": false},
	ITEM_TowerKey: {
		"memAddress_Flag_isInInventory": 0xA9F049,	// $A9F049: [Bit 0] Tower key
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Ladder: {
		"memAddress_Flag_isInInventory": 0xA9F04D,	// $A9F04D: [Bit 0] Ladder
		"is_starterItem": false, "is_missableItem": false},
	ITEM_LetterToDana: {
		"memAddress_Flag_isInInventory": 0xA9F050,	// $A9F050: [Bit 0] Postcard
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Kitten: {
		"memAddress_Flag_isInInventory": 0xA9F04B,	// $A9F04B: [Bit 0] Kitten
		"is_starterItem": false, "is_missableItem": true}}


function is_SelectedItemInScrollBar(enum_item) => 	// $A9F111: [8-bit] Currently selected item in inventory
	byte(0xA9F111) == const_Items_data[enum_item]["itemScrollBarId"] 

function is_ItemPresentInInventory(enum_item) => 
	bit0(const_Items_data[enum_item]["memAddress_Flag_isInInventory"]) == 1

// **********************
// ◦ BOTTOM SCREEN TEXT ◦
// **********************
// - The text at the bottom of the screen (subtitles & info in menu's) is printed on the screen via a transparent character set image, 
// 		which is masked to show only 1 character at a time. 
//		Functional with offset and different character sets (ex. latin, chinese) (more info refer to code notes @ 0xac31e8)
function is_BottomScreenTextId(int_id) =>	// $AC31E4:  Bottom screen text ID
	dword(0xAC31E4) == int_id				//		- Identifies a series of text lines at the bottom of the screen (during cutscenes or in a menu)
											//		- This ID does not change on each new text change, but it does change often between text changes
// -------------------------------------
// $AC31E8: [NTSC-U/C][Variable Length Array] List of Character_Print_Data_Objects
	// - Size is dependent on the amount of characters on the bottom screen (1 character == 1 object)
	// - A space doesn't count as an object; Special characters (eg .?!') do
	// - 1st character corresponds to the first letter on the first line; the last char corresponds to the last letter in the last line
	// >>>{ [Struct Definition][8-byte] Character_Print_Data_Object
	// >>>| '''''''''''''''''''''''''''''''''''''''''''''''''
	// >>>| +0x0 - [16-bit] Some control data (unknown usage)
	// >>>| +0x2 - [8-bit] Height of character
	// >>>| ¨¨¨¨¨¨¨¨ [Lower4] Sub height (in-between lines)
	// >>>| ¨¨¨¨¨¨¨¨ [Upper4] Main height
	// >>>| ¨¨¨¨¨¨¨¨¨¨¨¨ 4 => prints to first line
	// >>>| ¨¨¨¨¨¨¨¨¨¨¨¨ 5 => prints to second line
	// >>>| +0x6 - [8-bit] Print location x-axis
	// >>>| +0xa - [8-bit] Image offset x-axis
	// >>>| +0xb - [8-bit] Image offset y-axis
	// >>>| +0xc - [8-bit] Unmask width
	// >>>| ¨¨¨¨¨¨¨¨ Higher value => more of the image is visible
	// >>>| +0xd - [8-bit] Print location y-axis
	// >>>| +0xf - [8-bit] Character set ID
	// >>>| ¨¨¨¨¨¨¨¨ Default for USA version is 0x8 = latin characters
	// >>>| ¨¨¨¨¨¨¨¨ There seems to be 15 characters sets; starting from 0x0 up to 0x14; higher than this value defaults to latin characters
	// >>>| ¨¨¨¨¨¨¨¨ All characters sets are presumably on one big character set image, so this value here might just be another offset
const_CharacterPrinter_data = {
	"memAddr": 0xAC31E8,
	"sizeInBytes_CharacterPrintData_Obj": 16,
	"offsets_CharacterPrintData_Obj": {
		"controlData": 0x0,
		"height": 0x2,
		"print_Xaxis": 0x6,
		"imageOffset_Xaxis": 0xa,
		"imageOffset_Yaxis": 0xb,
		"imageUnmask_Width": 0xc,
		"print_Yaxis": 0xd,
		"characterSetId": 0xe}}

function get_CharPrint_offset(int_charIndex) =>
	int_charIndex * const_CharacterPrinter_data["sizeInBytes_CharacterPrintData_Obj"]

function current_CharPrint_controlData(int_charIndex) =>
	word(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["controlData"])

function current_CharPrint_height(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["height"])
	
function current_CharPrint_printXaxis(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["print_Xaxis"])
	
function current_CharPrint_printYaxis(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["print_Yaxis"])

function current_CharPrint_imageOffsetXaxis(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["imageOffset_Xaxis"])
	
function current_CharPrint_imageOffsetYaxis(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["imageOffset_Yaxis"])
	
function current_CharPrint_imageUnmaskWidth(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["imageUnmask_Width"])
	
function current_CharPrint_characterSetId(int_charIndex) =>
	byte(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["characterSetId"])

function memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) {
	let_dwordBE = dict_characterPrintData["imageOffset_Xaxis"] * 0x1000000
	let_dwordBE = let_dwordBE + dict_characterPrintData["imageOffset_Yaxis"] * 0x10000
	let_dwordBE = let_dwordBE + dict_characterPrintData["imageUnmask_Width"] * 0x100
	let_dwordBE = let_dwordBE + dict_characterPrintData["print_Yaxis"]
	return let_dwordBE}

// Use below dictionary as an object definition to pass params to function is_CharacterOnBottomScreen()
// 	dict_characterPrintData = {
	//	"height": 0x0,
	// 	"print_Xaxis": 0x0,
	// 	"imageOffset_Xaxis": 0x0,
	// 	"imageOffset_Yaxis": 0x0,
	// 	"imageUnmask_Width": 0x0,
	// 	"print_Yaxis": 0x0,
	//	"characterSetId": 0x0}
function is_CharacterOnBottomScreen_bis(int_charIndex, dict_characterPrintData) => // index starts at 0
	current_CharPrint_height(int_charIndex) == dict_characterPrintData["height"] &&
	current_CharPrint_printXaxis(int_charIndex) == dict_characterPrintData["print_Xaxis"] &&
	current_CharPrint_printYaxis(int_charIndex) == dict_characterPrintData["print_Yaxis"] &&
	current_CharPrint_imageOffsetXaxis(int_charIndex) == dict_characterPrintData["imageOffset_Xaxis"] &&
	current_CharPrint_imageOffsetYaxis(int_charIndex) == dict_characterPrintData["imageOffset_Yaxis"] &&
	current_CharPrint_imageUnmaskWidth(int_charIndex) == dict_characterPrintData["imageUnmask_Width"] &&
	current_CharPrint_characterSetId(int_charIndex) == dict_characterPrintData["characterSetId"]

function is_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData) => // index starts at 0
	current_CharPrint_height(int_charIndex) == dict_characterPrintData["height"] &&
	current_CharPrint_printXaxis(int_charIndex) == dict_characterPrintData["print_Xaxis"] &&
	dword_be(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["imageOffset_Xaxis"]) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
	current_CharPrint_characterSetId(int_charIndex) == dict_characterPrintData["characterSetId"]	

function was_CharacterOnBottomScreen_bis(int_charIndex, dict_characterPrintData) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex)) == dict_characterPrintData["print_Xaxis"] &&
	prior(current_CharPrint_printYaxis(int_charIndex)) == dict_characterPrintData["print_Yaxis"] &&
	prior(current_CharPrint_imageOffsetXaxis(int_charIndex)) == dict_characterPrintData["imageOffset_Xaxis"] &&
	prior(current_CharPrint_imageOffsetYaxis(int_charIndex)) == dict_characterPrintData["imageOffset_Yaxis"] &&
	prior(current_CharPrint_imageUnmaskWidth(int_charIndex)) == dict_characterPrintData["imageUnmask_Width"] &&
	prior(current_CharPrint_characterSetId(int_charIndex)) == dict_characterPrintData["characterSetId"]

function was_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex)) == dict_characterPrintData["print_Xaxis"] &&
	prior(dword_be(const_CharacterPrinter_data["memAddr"] + get_CharPrint_offset(int_charIndex) + 
		const_CharacterPrinter_data["offsets_CharacterPrintData_Obj"]["imageOffset_Xaxis"])) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
	prior(current_CharPrint_characterSetId(int_charIndex)) == dict_characterPrintData["characterSetId"]

function is_TotalCharacterCountOnBottomScreen(int_charCount) { // Count starts at 1
	let_lastCharIndex = int_charCount - 1
	return 
		current_CharPrint_controlData(let_lastCharIndex) != 0 		&& // <-- this block checks if there is an Nth character printed on screen; where N = int_charCount
		current_CharPrint_height(let_lastCharIndex) != 0			&&

		current_CharPrint_controlData(let_lastCharIndex + 1) == 0 	&& // <-- this block checks if there's no more characters printed after Nth one
		current_CharPrint_height(let_lastCharIndex + 1) == 0}

function was_MinimumAmountOfCharactersOnBottomScreen(int_charCount) => // Count starts at 1
	prior(current_CharPrint_controlData(int_charCount - 1)) != 0x0

function is_BottomScreenText_empty() => 
	current_CharPrint_controlData(0) == 0x0 &&	// Checks first character
	current_CharPrint_controlData(7) == 0x0		// Checks 7th character

function was_BottomScreenText_empty() => 
	prior(current_CharPrint_controlData(0)) == 0x0 &&	// Checks first character
	prior(current_CharPrint_controlData(7)) == 0x0		// Checks 7th character

function on_BottomScreenText_render() => 
	current_CharPrint_controlData(0) > 0 && 
	prev(current_CharPrint_controlData(0)) == 0

function on_BottomScreenText_remove() => 
	current_CharPrint_controlData(0) == 0 && 
	prev(current_CharPrint_controlData(0)) > 0
// ***************
// ◦ ENERGY ORBS ◦
// ***************
// - Some positional axes are set to NULL, because they're too close to the mid-line => value's change too fast close to it, so just check location based on other info
// - positional value's are based on the player's position close to the orb (refer to notes @ 0xa8abd0)
const_EnergyOrbs_data = {
	TIMEPERIOD_Late20thCentury: {
		"amountToCollect": 5,
		"sharedArea": [AREA_80s_City_Snow, AREA_70s_City_Night],
		"locations": {
			"NorthGateNearBar": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F0)) + 0x4},
			"WellCafeSonne": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F0)) + 0x5},
			"Haupstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F0)) + 0x6},
			"StairsRudolfstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F0)) + 0x7},
			"AlleyWayBakery": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F0)) + 0x8},
			},
		},
	TIMEPERIOD_Early20thCentury: {
		"amountToCollect": 6, // TODO update guideREADME + descr with 6th
		"sharedArea": iNULL, // <-- 1 are not in area_city, so check each location seperate
		"locations": { 
			"InsideBrumMansion": {
				"area": [AREA_1900s_BrumMansion],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA44304)) + 0x4},
			"TreeNearBar": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F4)) + 0x4},
			"StairsOppositeCafeSonne": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F4)) + 0x5},
			"NearNewsPost": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F4)) + 0x6},
			"ParkRudolfStr": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F4)) + 0x7},
			"NorthEastgate": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F4)) + 0x8},
			},
		},
	TIMEPERIOD_MiddleAges: {
		"amountToCollect": 6,
		"sharedArea": iNULL, // <-- 2 orbs are not in area_city, so check each location seperate
		"locations": {
			"AlchemistBasement": {
				"area": [AREA_MiddleAges_AlchemistHouse_Exploded_Basement],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA44300)) + 0x4},
			"InsideChurch": {
				"area": [AREA_MiddleAges_Church],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA4430C)) + 0x4},
			"onBench": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F8)) + 0x4},
			"EastWell": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F8)) + 0x5},
			"AlleyWayCart": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F8)) + 0x6},
			"EastNearHay": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F8)) + 0x7},
			"ChurchEntrance": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442F8)) + 0x8},
			}
		},
	TIMEPERIOD_Present: {
		"amountToCollect": 5,
		"sharedArea": [AREA_Present_City_Day, AREA_Present_City_NightAM, AREA_Present_City_NightPM], // <-- all orbs are in the area_city
		"locations": { 
			"OutsideFortuneTeller": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442EC)) + 0x4},
			"AlleyWay": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442EC)) + 0x5},
			"SouthGate": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442EC)) + 0x6},
			"UnderArchRuckagrastr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442EC)) + 0x7},
			"CarPark": {
				"area": iNULL,
				"memAddr_Flag_isCollected": () => sysUtil_maskPointer(dword(0xA442EC)) + 0x8},
			}
		}}
const_EnergyOrbs_data_old = {
	TIMEPERIOD_Late20thCentury: {
		"amountToCollect": 5,
		"sharedArea": [AREA_80s_City_Snow, AREA_70s_City_Night],
		"locations": {
			"StairsRudolfstr": {
				"area": iNULL,
				"pos": {"xAxis": 0x46a5a000, "yAxis": 0xc6915000}}, // <---ToFloat--- [21200,-18600]
			"AlleyWayBakery": {
				"area": iNULL,
				"pos": {"xAxis": 0x46a73000, "yAxis": 0x468bd800}}, // <---ToFloat--- [21400,17900]
			"NorthGateNearBar": {
				"area": iNULL,
				"pos": {"xAxis": 0xc6241000, "yAxis": 0x4701b000}}, // <---ToFloat--- [-10500,33200]
			"WellCafeSonne": {
				"area": iNULL,
				"pos": {"xAxis": 0xc6bf6800, "yAxis": 0x44834000}}, // <---ToFloat--- [-24500,1050]
			"TreeHaupstr": {
				"area": iNULL,
				"pos": {"xAxis": 0xc5ed8000, "yAxis": 0xc70ef800}}, // <---ToFloat--- [-7600,-36600]
			},
		},
	TIMEPERIOD_Early20thCentury: {
		"amountToCollect": 5,
		"sharedArea": iNULL,
		"locations": { 
			"InsideBrumMansion": {
				"area": [AREA_1900s_BrumMansion],
				"pos": iNULL},
			"NearNewsPost": {
				"area": [AREA_1900s_City],
				"pos": {"xAxis": 0x45abe000, "yAxis": 0xc7435000}}, // <---ToFloat--- [5500,-50000]
			"TreeBar": {
				"area": [AREA_1900s_City],
				"pos": {"xAxis": 0xc68e3000, "yAxis": 0x46ae3800}}, // <---ToFloat--- [-18200,22300]
			"NorthEastgate": {
				"area": [AREA_1900s_City],
				"pos": {"xAxis": 0x46a7f800, "yAxis": 0x46e67800}}, // <---ToFloat--- [21500,29500]
			"OppositeCafeSonne": {
				"area": [AREA_1900s_City],
				"pos": {"xAxis": 0xc6ee4800, "yAxis": 0xc5960000}}, // <---ToFloat--- [-30500,-4800]
			},
		},
	TIMEPERIOD_MiddleAges: {
		"amountToCollect": 6,
		"sharedArea": iNULL, // <-- 2 orbs are not in area_city, so check each location seperate
		"locations": {
			"AlchemistBasement": {
				"area": [AREA_MiddleAges_AlchemistHouse_Exploded_Basement],
				"pos": iNULL},
			"InsideChurch": {
				"area": [AREA_MiddleAges_Church],
				"pos": iNULL},
			"EastNearHay": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"pos": {"xAxis": 0x46f61800, "yAxis": 0xc57a0000}}, // <---ToFloat--- [31500,-4000]
			"AlleyWayCart": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"pos": {"xAxis": 0x46985800, "yAxis": 0x44960000}}, // <---ToFloat--- [19500,1200]
			"EastWell": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"pos": {"xAxis": 0xc6c73800, "yAxis": 0x4b371ee8}}, // <---ToFloat--- [-25500,1000]
			"ChurchEntrance": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"pos": {"xAxis": 0x460ca000, "yAxis": 0x46ea6000}}, // <---ToFloat--- [9000,30000]
			"onBench": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"pos": {"xAxis": 0xc6985800, "yAxis": 0x46abe000}}, // <---ToFloat--- [-19500,22000]
			}
		},
	TIMEPERIOD_Present: {
		"amountToCollect": 5,		
		"sharedArea": [AREA_Present_City_Day, AREA_Present_City_NightAM, AREA_Present_City_NightPM], // <-- all orbs are in the area_city
		"locations": { 
			"CarPark": {
				"area": iNULL,
				"pos": {"xAxis": 33500, "yAxis": 5600}}, // <---ToFloat--- [33500,5600]
			"SouthGate": {
				"area": iNULL,
				"pos": {"xAxis": 0x0, "yAxis": -53400}}, // <---ToFloat--- [0,-53400]
			"AlleyWay": {
				"area": iNULL,
				"pos": {"xAxis": -18500, "yAxis": -25300}}, // <---ToFloat--- [-18500,-25300]
			"UnderArchRuckagrastr": {
				"area": iNULL,
				"pos": {"xAxis": 9600, "yAxis": -18500}}, // <---ToFloat--- [9600,-18500]
			"OutsideFortuneTeller": {
				"area": iNULL,
				"pos": {"xAxis": -20000, "yAxis": 6600}}, // <---ToFloat--- [-20000,6600]
			},
		}}
function get_EnergyOrb_amountToCollect(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["amountToCollect"]

function get_EnergyOrb_Locations(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["locations"]

function get_EnergyOrb_sharedAreas(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["sharedArea"]

function get_EnergyOrb_Location_area(enum_timePeriod, string_locationKey) =>
	const_EnergyOrbs_data[enum_timePeriod]["locations"][string_locationKey]["area"]

function current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey) =>
	bit0(const_EnergyOrbs_data[enum_timePeriod]["locations"][string_locationKey]["memAddr_Flag_isCollected"])

function prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey) =>
	prev(current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey))

function on_EnergyOrb_Collect(enum_timePeriod, string_locationKey) => 
	current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey) > prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey)
// -------------------------------------
function current_EnergyUnits() =>		// $A9DAA8: Number of energy units in possession 
	byte(0xA9DAA8)						//		- If this is 0x0, player can't time travel
										//		- Values range [0x0-0xa]

function prev_EnergyUnits() =>
	prev(current_EnergyUnits())

function on_EnergyUnits_increment() => 
	current_EnergyUnits() > prev_EnergyUnits()

function on_EnergyUnits_decrement() => 
	current_EnergyUnits() < prev_EnergyUnits()

function on_EnergyUnits_valueChange() => 
	current_EnergyUnits() != prev_EnergyUnits()

// ***********************
// ◦ MENU IDENTIFICATION ◦
// ***********************
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function is_ExtraMenu_active() {								// $AC3170: [25-bit] Pointer - When in Extra menu
	let_maskedPointer = sysUtil_maskPointer(dword(0xAC3170))	// 		- Extra menu is only visible once at least one is ending is finished
	return														// 		+0x4 - [32-bit] Extra Menu: Highlighted item
		dword(let_maskedPointer + 0x4) <= 0x4 &&				// 		| - 0x0 => Event viewer (replay unlocked cutscenes)
		dword(let_maskedPointer + 0x14) <= 0x5 &&				// 		| - 0x1 => Ending files (replay ending cutscenes)
		dword(let_maskedPointer + 0x48) <= 0xb}					// 		| - 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
																// 		| - 0x3 => Sound Mode (Play sound effects & music)
																// 		| - 0x4 => Exit (back to Title Screen)
																// 		+0x14 - [32-bit] Extra Menu: Highlighted ending file
																// 		| - 0x0 => ending A			| - 0x3 => ending D
																// 		| - 0x1 => ending B			| - 0x4 => ending E	
																// 		| - 0x2 => ending C			| - 0x5 => ending EX
																// 		+0x48 - [32-bit] Results Menu/Event Viewer: Highlighted chapter
																// 		| - 0x0 => Prologue			| - 0x9 => Epilogue
																// 		| - 0x1 => Chapter 1		| - 0xa => Total
																// 		| - ...						| - 0xb => Exit
																// 		| - 0x8 => Chapter 8
function is_EventViewer_active() =>	// $1FFF130: [32-bit] Flag -> Event viewer (preferred)
	dword(0x1FFF130) == 0x21 && 	// 		- 32-bit value = 0x21 -> event viewer menu is on screen OR a cutscene is being watched via this menu
	is_ExtraMenu_active()			// 		- other values -> not in event viewer													
									//		- Do not use this as a solo condition to check if event viewer is active.
									//		- Use with 0xac3170
function is_ResultsMenu_active() => 	// $AC49F4: [32-bit] Menu ID
	dword(0xAC49F4) == 0x16	&& 			// 		0xe => at title screen				0x16 => at results menu
	is_ExtraMenu_active()				// 		0x4 => at extra menu				0x1a => In sound mode menu
										// 		0x12 => at event viewer menu		0xb => viewing ending file

function is_ResultsMenu_HighlightedChapter(enum_chapter) {
	let_maskedPointer = sysUtil_maskPointer(dword(0xAC3170))
	let_resultsMenuHighlightedChapterId = 0 
	if (enum_chapter == CHAPTER_Chapter8) {
		let_resultsMenuHighlightedChapterId = 0x8
	} else if (enum_chapter == CHAPTER_Epilogue) {
		let_resultsMenuHighlightedChapterId = 0x9
	} else if (enum_chapter == "Total") {
		let_resultsMenuHighlightedChapterId = 0xa
	} else {
		let_resultsMenuHighlightedChapterId = get_ChapterID(enum_chapter) - 1
	}
	return			
		is_ResultsMenu_active() &&
		dword(let_maskedPointer + 0x48) == let_resultsMenuHighlightedChapterId}													
// -------------------------------------
function is_InGamePauseMenu_active() =>	// $B91514 + $B91518: [Bit Flag] bit 0 => in-game pause menu
	bit0(0xB91514) == 1 && 
	bit0(0xB91518) == 1

function is_TitleMenu_active() { return	// $1FFF5F8: [32-bit] UI/Menu ID
	dword(0x1FFF5F8) == 0x11 	&&		// 	0x11 => title screen			any other value => something else on screen
	0x0 < byte(0x1FFF604) 		&& 		//	0x1 => chapter complete screen
	dword(0x1FFF604) < 0x5}				// $1FFF604: [8-bit] Selected submenu at title screen
										// 	0x1 => Start		0x3 => Option
										// 	0x2 => Continue		0x4 => Extra

function is_ChapterCompletionMenu_active() =>	// $1FFF5F4: [32-bit Flag] Is chapter complete screen active
	dword(0x1FFF5F8) == 0x1 	&&				//		- 0x21 => chapter completion screen is active (UI asks to save data)
	dword(0x1FFF5F4) == 0x21 	&&				// $A82E2C: [Bit Flag] bit 0 => Is Chapter Completion Menu Displayed -OR- Is Loading
	bit0(0xA82E2C) == 1							// 	- bit 0 = 1 => when chapter complete screen is displayed, when the ending video credits + ending file are played, when loading (+during time travel)
												// 	- bit 0 = 0 => when in-game AND nothing is loading

function is_Loading() =>
	bit0(0xA82E2C) == 1

function on_ChapterCompletionMenu_render() =>
	dword(0x1FFF5F8) == 0x1  	&& prev(dword(0x1FFF5F8)) != 0x1 &&
	dword(0x1FFF5F4) == 0x21 	&& prev(dword(0x1FFF5F4)) != 0x21 &&
	bit0(0xA82E2C) > prior(bit0(0xA82E2C))

function on_ChapterCompletionMenu_exit() =>
	dword(0x1FFF5F8) != 0x1  	&& prev(dword(0x1FFF5F8)) == 0x1 &&
	dword(0x1FFF5F4) != 0x21 	&& prev(dword(0x1FFF5F4)) == 0x21 &&
	bit0(0xA82E2C) < prior(bit0(0xA82E2C))
									
function is_InGame() => // $A9EDDC: [Lower4] Flag -> is in-game
	low4(0xA9EDDC) != 0	// 		Lower4 = 0 => at title screen
						// 		Lower4 > 0 => in-game

function on_TitleMenu_render() { return
	low4(0xA9EDDC) == 0 && 
	prev(low4(0xA9EDDC)) > 0}

// ***************
// ◦ OTHER LOGIC ◦
// ***************
function is_MainSave_loaded() {									// $AA2998: [25-bit Pointer] is main save file loaded (at first startup of game)
	let_maskedPointer = sysUtil_maskPointer(dword(0xAA2998))	//		+0x4 - [Bit 0] => main save is loaded
	return 														//		| - Data around this memory address is set on startup or reset
		bit0(let_maskedPointer + 0x4) == 1}

function is_Video_active() {									// $8FFEF0: [25-bit Pointer]  Video data (intro and credits)
	let_maskedPointer = sysUtil_maskPointer(dword(0x8FFEF0))	// 		+0x18 - [32-bit Flag] 0x101 => video is active
	return 														// 		+0x2c - [32-bit Flag] 0x41 => video is active
		dword(let_maskedPointer + 0x18) == 0x101 &&				// 		+0x40 - [32-bit] Video timer
		dword(let_maskedPointer + 0x2c) == 0x41}

function on_Video_end() {
	let_maskedPointer = sysUtil_maskPointer(dword(0x8FFEF0))
	return
		prev(dword(let_maskedPointer + 0x18)) == 0x101 	&&
		dword(let_maskedPointer + 0x18)	!= 0x101		&&
		prev(dword(let_maskedPointer + 0x2c)) == 0x41 	&&
		dword(let_maskedPointer + 0x2c)	!= 0x41}

function on_Video_start() {
	let_maskedPointer = sysUtil_maskPointer(dword(0x8FFEF0))
	return
		prev(dword(let_maskedPointer + 0x18)) != 0x101 	&&
		dword(let_maskedPointer + 0x18)	== 0x101		&&
		prev(dword(let_maskedPointer + 0x2c)) != 0x41 	&&
		dword(let_maskedPointer + 0x2c)	== 0x41}

// ****************
// ◦ ENDING LOGIC ◦
// ****************
ENDING_A	= 106
ENDING_B	= 105
ENDING_C	= 104
ENDING_D	= 103
ENDING_E	= 102
ENDING_EX	= 101
const_Endings_data = {
	ENDING_A : {
		"EndingFile_ID": 0x0,
		"memAddr_Flag_EndingAchieved": 0xAA1154}, // $AA1154: [Bit Flag] bit 0 => Ending A achieved
	ENDING_B : {
		"EndingFile_ID": 0x1,
		"memAddr_Flag_EndingAchieved": 0xAA1155}, // $AA1155: [Bit Flag] bit 0 => Ending B achieved
	ENDING_C : {
		"EndingFile_ID": 0x2,
		"memAddr_Flag_EndingAchieved": 0xAA1156}, // $AA1156: [Bit Flag] bit 0 => Ending C achieved
	ENDING_D : {
		"EndingFile_ID": 0x3,
		"memAddr_Flag_EndingAchieved": 0xAA1157}, // $AA1157: [Bit Flag] bit 0 => Ending D achieved
	ENDING_E : {
		"EndingFile_ID": 0x4,
		"memAddr_Flag_EndingAchieved": 0xAA1158}, // $AA1158: [Bit Flag] bit 0 => Ending E achieved
	ENDING_EX : {
		"EndingFile_ID": 0x5,
		"memAddr_Flag_EndingAchieved": 0xAA1159}} // $AA1159: [Bit Flag] bit 0 => Ending EX achieved

function get_EndingFileId(enum_ending) =>
	const_Endings_data[enum_ending]["EndingFile_ID"]

function is_Ending_achieved(enum_ending) =>
	bit0(const_Endings_data[enum_ending]["memAddr_Flag_EndingAchieved"]) == 1

function is_ExChapter_unlocked() => // If endings ABCDE are achieved
	all_of(const_Endings_data, (enum_ending) {
		if (enum_ending != ENDING_EX) return is_Ending_achieved(enum_ending)
		else return always_true()
	})

function is_ViewingEndingFile_viaExtraMenu(enum_ending) {		// $AC3178: [25-bit Pointer] Ending File
	let_maskedPointer = sysUtil_maskPointer(dword(0xAC3178))	//		- Resets to 0x0, when no ending file is on screen					
	let_endingFileId = get_EndingFileId(enum_ending)			// 		+0x10 - [8-bit] Ending File ID	
	return														// 		| - 0x0 => ending file A  	| - 0x4 => ending file E
		is_ExtraMenu_active() &&								// 		| - 0x1 => ending file B	| - 0x5 => ending file EX
		byte(let_maskedPointer + 0x10) == let_endingFileId}		// 		| - ...	
																// 		+0x8 - [32-bit] Ending file timer
																// 		+0xc - [16-bit] Ending file text ID		
// ******************************
// ◦ CUTSCENE/CHOICES BIT FLAGS ◦
// ******************************
function is_PrologueExMode_active() => 	// $A9ED98: [Current Playthrough Bit Flags]: EX Chapter
	bit7(0xA9ED98) == 1 				//		bit 7 => EX Chapter is active // 2nd dialogue option "Oh, Homunculus" => activates EX chapter
// -------------- SquareTree ---------------
function is_TreeReplacedBy_Statue() => 	// $A9EDA0: [Current Playthrough Bit Flags]: Chapter 2
	bit2(0xA9EDA0)	== 0				// 		bit 0 => acquired ladder
										// 		bit 1 = 0 => LIGHTER used to scare crowd
function is_TreeReplacedBy_Flowers() => // 		bit 1 = 1 => TELEPHONE used 
	bit2(0xA9EDA0) == 1					// 		bit 2 = 0 => Chosen to plant STATUE instead of flowers	
										// 		bit 2 = 1 => Chosen to plant FLOWERS instead of statue
function is_CrowdScaredWith_Cellphone() => 	
	bit1(0xA9EDA0) == 1	
	
function is_CrowdScaredWith_Lighter() => 
	bit1(0xA9EDA0) == 0	
// ------------ Movie --------------
function is_MovieWorldConquest_chosen() => 
	bit7(0xA9EDB7) == 1 && bit0(0xA9EDB8) == 1	// $A9EDB7: [Current Playthrough Bit Flags]: Chapter 6
												// 		bit 5 => Movie choice 1: Meditating Man
function is_MovieTimeTravel_chosen() => 		// 		bit 6 => Movie choice 1: Time Travel
	bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0	// 		bit 7 => Movie choice 2: Take over the world
																						
function is_MovieFindCauseDeath_chosen() => 	// $A9EDB8: [Current Playthrough Bit Flags]: Chapter 6
	bit0(0xA9EDB8) == 1 && bit7(0xA9EDB7) == 0	// 		bit 0 => Movie Choice 2: Find cause of own death
												// 		bit 1 => Movie Choice 3: Thriller story	
function is_MovieThriller_chosen() => 			// 		bit 2 => Movie Choice 3: Love story
	bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0		

function is_MovieLove_chosen() => 
	bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0	
// ---------- Paintings ------------
function is_Painting_Antidote_inspired() => 	// $A9EDB0: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
	bit7(0xA9EDB0) == 1							//  - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen	
												// 		bit 7 => Antidote painting
function is_Painting_Marktplatz_inspired() => 	// 		bit 6 => Marktplatz painting (insinuating removing the tree)
	bit6(0xA9EDB0) == 1							// 		bit 5 => Squire's crest painting
												// 		bit 4 => Tower view painting (downstairs)
function is_Painting_SquireCrest_inspired() => 
	bit5(0xA9EDB0) == 1	
					
function is_Painting_TowerView_inspired() => 
	bit4(0xA9EDB0) == 1

function is_Painting_Performer_inspired() => 	// $A9EDB1: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
	bit0(0xA9EDB1) == 1							// 		bit 0 => Performer painting (only possible when player became performer in chapter 4)
												// 		bit 1 => Achemist house collapse painting
function is_Painting_HouseCollapse_inspired() => 
	bit1(0xA9EDB1) == 1	
// ----------- BrumEstate ----------------
function is_BrumEstate_Museum() => 	//	$A9EDAA: [Current Playthrough Bit Flags]: Brum Estate Choice
	bit5(0xA9EDAA) == 0				//		bit 5 = 0 => Brum Estate is museum
									//		bit 5 = 1 => Brum Estate is library
function is_BrumEstate_Library() => 
	bit5(0xA9EDAA) == 1
// -----------AncestorChoice--------------
function is_MargaretteTold_Ancestor() => 			// $A9EDAE: [Current Playthrough Bit Flags]: Margarette Ancestor choice
	bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0	// 		bit 6 => Margarette is ancestor, sets after leaving alchemist house
												// 		bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house
function is_MargaretteTold_NoAncestor() => 
	bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1		
// ------------FireChapter1---------------
function is_FirePutOutBy_Barman() => 	// $A9ED9D: [Current Playthrough Bit Flags]: Chapter 1
	bit5(0xA9ED9D) == 0 &&				//		bit 5 => put out fire yourself
	bit7(0xA9ED9D) == 1					//		bit 7 => Saved bar from fire by warning barman

function is_FirePutOutBy_Eike() => 
	bit5(0xA9ED9D) == 1 &&
	bit7(0xA9ED9D) == 0	
// -----------DanaChoice----------------
function is_Dana_Saved_FromPast(){ return	// $A9EDC4: [Current Playthrough Bit Flags]: Saved Dana from Past
	bit1(0xA9EDC4) == 1 && 					// 		bit 1 => Gave letter to Dana
	bit3(0xA9EDC4) == 1 && 					// 		bit 3-4 => Took Dana back to present
	bit4(0xA9EDC4) == 1}

function is_Dana_Left_InPast(){ return
	bit1(0xA9EDC4) == 0 &&
	bit3(0xA9EDC4) == 0 &&
	bit4(0xA9EDC4) == 0}
// ----------Misc--------------
function is_CoffeePayed() => 	// $A9EDCC: [Current Playthrough Bit Flags]: Multi-chapter
	bit3(0xA9EDCC) == 1			// 		bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch

function is_KittenGivenToSibylla() =>	// $A9EDCB: [Current Playthrough Bit Flags]: Multi-chapter
	bit6(0xA9EDCB) == 1					// 		bit 2 => talked with Oleg 1st time in Chapter 3
										// 		bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
										// 		bit 6 => gave kitten to Sibylla

function is_WearingPerformerOutfit() => // $A9EDA5: [Current Playthrough Bit Flags]: Chapter 4
	bit2(0xA9EDA5) == 1					//		 bit 2 => is wearing performer outfit


// ***********************************
// ◦ ACHIEVEMENT PERCENTAGE BITFLAGS ◦
// ***********************************
// - Each flag corresponds to 1 cutscene and counts toward the achievement percentage
// - At end of a cutscene one of these flags will become true
// - Flags are grouped per chapter
// - These flags are loaded when loading a save OR when starting a new game whilst having played the game before
const_percentageBitflags_new = {
	"Prologue": {
		0xA9ED3C: [1,7],
		0xA9ED3D: [0,7],
		0xA9ED3E: [0,7],
		0xA9ED3F: [0,7],
		0xA9ED40: [0,7],
		0xA9ED41: [0,7],
		0xA9ED42: [0,5]},
	"Chapter1": {
		0xA9ED43: [6,7],
		0xA9ED44: [0,7],
		0xA9ED45: [0,7],
		0xA9ED46: [0,5]},
	"Chapter2": {
		0xA9ED47: [3,7],
		0xA9ED48: [0,7],
		0xA9ED49: [0,7],
		0xA9ED4A: [0,7],
		0xA9ED4B: [0,6]},
	"Chapter3": {
		0xA9ED58: [2,7],
		0xA9ED59: [0,7],
		0xA9ED5A: [0,7]},
	"Chapter4": {
		0xA9ED4D: [1,7],
		0xA9ED4E: [0,7],
		0xA9ED4F: [0,7],
		0xA9ED50: [0,7],
		0xA9ED51: [0,4]},
	"Chapter5": {
		0xA9ED52: [1,7],
		0xA9ED53: [0,7],
		0xA9ED54: [0,7],
		0xA9ED55: [0,7],
		0xA9ED56: [0,7],
		0xA9ED57: [0,6]},
	"Chapter6": {
		0xA9ED5B: [2,7],
		0xA9ED5C: [0,7],
		0xA9ED5D: [0,7],
		0xA9ED5E: [0,7],
		0xA9ED5F: [0,4]},
	"Chapter7": {
		0xA9ED60: [2,7],
		0xA9ED61: [0,7],
		0xA9ED62: [0,7],
		0xA9ED63: [0,7],
		0xA9ED64: [0,3]},
	"Chapter8": {
		0xA9ED65: [5,7],
		0xA9ED66: [0,7],
		0xA9ED67: [0,7],
		0xA9ED68: [0,7],
		0xA9ED69: [0,7],
		0xA9ED6A: [0,7],
		0xA9ED6B: [0,7],
		0xA9ED6C: [0,7],
		0xA9ED6D: [0,7],
		0xA9ED6E: [0,3]},
	"Epilogue": {
		0xA9ED71: [2,7],
		0xA9ED72: [0,7],
		0xA9ED73: [0,7],
		0xA9ED74: [0]}}
		
function memUtil_allPercentageBitFlagsToOneDict() { // This will create a new dict without the chapters as keys;	new dict => memAddress (key): [bits] (value)
	let_PercentageBitFlags = {} 
	for chapter in const_percentageBitflags_new {
		for memAddr in const_percentageBitflags_new[chapter] {
			util_addToDictionary(let_PercentageBitFlags, memAddr, const_percentageBitflags_new[chapter][memAddr])
		}
	}
	return let_PercentageBitFlags}

function memUtil_percentageBitflagsDictToMemoryAccessorArray(dict_BitFlags) { // Return an array [bit0(0x00), bit1(0x00), bitcount(0x01)] from dict with percentagebitflags
	let_bitFlagMemoryAccessors = []	
	for memAddr in dict_BitFlags {
		let_arrayOfBitFlagsToCheck = dict_BitFlags[memAddr]
		if (length(let_arrayOfBitFlagsToCheck) == 1) {	// If only one bitflag on this memAddr => add only one memory accessor
			let_bitIndex = let_arrayOfBitFlagsToCheck[0]
			array_push(let_bitFlagMemoryAccessors, bit(let_bitIndex, memAddr))
		} else if ( // If all bits => add "bitcount" memory accessor
			(let_arrayOfBitFlagsToCheck[0] == 0 && let_arrayOfBitFlagsToCheck[1] == 7) || 
			(let_arrayOfBitFlagsToCheck[0] == 7 && let_arrayOfBitFlagsToCheck[1] == 0)) { 
				array_push(let_bitFlagMemoryAccessors, bitcount(memAddr))
		} else { // If not all bits, but more than 1 => memory accessor per bit flag
			let_step = 1
			if (let_arrayOfBitFlagsToCheck[0] > let_arrayOfBitFlagsToCheck[1]) let_step = -1
			for let_bitIndex in range(let_arrayOfBitFlagsToCheck[0], let_arrayOfBitFlagsToCheck[1], let_step) {	// Example let_arrayOfBitFlagsToCheck = [5,7]; this line [5,6,7]; let_bitIndex 1st loop = 5; let_bitIndex 2nd loop = 6; let_bitIndex 3rd loop = 7;
				array_push(let_bitFlagMemoryAccessors, bit(let_bitIndex, memAddr))
			}
		}
	}
	return let_bitFlagMemoryAccessors}
function memUtil_countTotalAmountOfBitFlags(dict_BitFlags) { // Counts how many bitflags are in the dict with percentagebitflags
	let_bitFlagCount = 0
	for memAddrWithBitFlags in dict_BitFlags {
		let_arrayOfBitFlagsToCheck = dict_BitFlags[memAddrWithBitFlags]
		if (length(let_arrayOfBitFlagsToCheck) == 1) {
			let_bitFlagCount = let_bitFlagCount + 1	
		} else if (let_arrayOfBitFlagsToCheck[0] > let_arrayOfBitFlagsToCheck[1]) {
			let_bitFlagCount = let_bitFlagCount + 1 + (let_arrayOfBitFlagsToCheck[0] - let_arrayOfBitFlagsToCheck[1])
		} else {
			let_bitFlagCount = let_bitFlagCount + 1 + (let_arrayOfBitFlagsToCheck[1] - let_arrayOfBitFlagsToCheck[0])
		}
	}
	return let_bitFlagCount}

function getTotalAchievementRate() =>	// $AA1152: [8-bit] Achievement Percentage: Total
	byte(0xAA1152)

// ****************************************************************************************************************************************** \\
//																																			  \\
//    █████╗  ██████╗██╗  ██╗██╗███████╗██╗   ██╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗       ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ██╔══██╗██╔════╝██║  ██║██║██╔════╝██║   ██║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝       ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ███████║██║     ███████║██║█████╗  ██║   ██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║          ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██╔══██║██║     ██╔══██║██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║          ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║  ██║╚██████╗██║  ██║██║███████╗ ╚████╔╝ ███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║          ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝          ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																			  \\
// ****************************************************************************************************************************************** \\

// **************************
// • Achievements CORE DATA •
// **************************
// - Divided by category => when in debug mode, category tags are added to achievement titles
achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
	//	"id": 000000, "points": 0000000,
	//	"devInfo": "xxxxxxx"},

	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // VERIFIED 
			"id": 306884, "points": 5,
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // VERIFIED
			"id": 306886, "points": 5,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // VERIFIED
			"id": 306922, "points": 5,
			"devInfo": "Complete chapter 2"},
		"a_Chapter3Complete": { // VERIFIED
			"id": 306921, "points": 5,
			"devInfo": "Complete chapter 3"},
		"a_Chapter4CompletePan": { // VERIFIED
			"id": 308964, "points": 3,
			"devInfo": "Complete chapter 4, using a frying pan"},
		"a_Chapter4CompleteSign": { // VERIFIED
			"id": 310149, "points": 3,
			"devInfo": "Complete chapter 4, using a sign"},
		"a_Chapter5Complete": { // VERIFIED
			"id": 311616, "points": 5,
			"devInfo": "Complete chapter 5"},
		"a_Chapter6CompleteThriller": { // VERIFIED
			"id": 313211, "points": 3,
			"devInfo": "Complete chapter 6, by co-directing a thriller movie"},
		"a_Chapter6CompleteLove": { // VERIFIED
			"id": 313210, "points": 3,
			"devInfo": "Complete chapter 6, by co-directing a love movie"},
		"a_Chapter7Complete": { // VERIFIED
			"id": 315565, "points": 5,
			"devInfo": "Complete chapter 7"},
		"a_Chapter8Complete": { // VERIFIED 
			"id": 315571, "points": 5,
			"devInfo": "Complete chapter 8"}},
	"c_AchievementPercentage": {
		"a_MaxAchievementPrologue": { // VERIFIED
			"id": 405087, "points": 10,
			"devInfo": "Seen all the important cutscenes in prologue + EX Chapter"},
		"a_MaxAchievementChapter1": { // VERIFIED
			"id": 405088, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 1"},
		"a_MaxAchievementChapter2": { // VERIFIED
			"id": 405089, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 2"},
		"a_MaxAchievementChapter3": { // VERIFIED
			"id": 405090, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 3"},
		"a_MaxAchievementChapter4": { // VERIFIED
			"id": 405091, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 4"},
		"a_MaxAchievementChapter5": { // VERIFIED
			"id": 405092, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 5"},
		"a_MaxAchievementChapter6": { // VERIFIED
			"id": 405093, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 6"},
		"a_MaxAchievementChapter7": { // VERIFIED
			"id": 405094, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 7"},
		"a_MaxAchievementChapter8": { // VERIFIED
			"id": 405095, "points": 10,
			"devInfo": "Seen all the important cutscenes in chapter 8"},
		"a_MaxAchievementEpilogue": { // VERIFIED	
			"id": 405096, "points": 10,
			"devInfo": "Seen all the important cutscenes in epilogue"},
		"a_MaxAchievementTotal": { // VERIFIED
			"id": 405097, "points": 50,
			"devInfo": "Seen ALL important the cutscenes"}},
	"c_Branch": { // Category - Branching path
		"a_AlertBarmanOfFire": { // VERIFIED
			"id": 306976, "points": 3,
			"devInfo": "Alert the barman of fire in chapter 1"},
		"a_BecomeThePerformer": { // VERIFIED
			"id": 402284, "points": 3,
			"devInfo": "In chapter4, use the costume to give yourself a message. Only possible when you haven't acquired the egg in chapter 1??"},
		"a_EggCollection": { // VERIFIED
			"id": 306977, "points": 3,
			"devInfo": "Give the ornamental egg to the barman during chapter 1. Or in chapter 3 or 4"},
		"a_EikeThePyromancer": { // VERIFIED
			"id": 306911, "points": 1,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // VERIFIED
			"id": 306906, "points": 1,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_EikeTheFlorist": { // VERIFIED
			"id": 306920, "points": 1,
			"devInfo": "Choose to plant flowers, when talking to the town planter in 1580 in chapter 2"},
		"a_GetOrnamentalEgg": { // VERIFIED
			"id": 306885, "points": 2,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."}},
	"c_Endings": { // Category - Achieving different endings
		"a_EndingA": { // VERIFIED
			"id": 315566, "points": 5,
			"devInfo": "Ending A: Margarette (Ancestress) => Fortuneteller AND Homunculus => Town Square"},
		"a_EndingB1":{ // VERIFIED
			"id": 315573, "points": 5,
			"devInfo": "Ending B1: Margarette (Ancestress) => Fortuneteller => Town Square"},
		"a_EndingB2":{ // VERIFIED
			"id": 315572, "points": 5,
			"devInfo": "Ending B2: Margarette (Ancestress) => Homunculus => Town Square"},
		"a_EndingC": { // VERIFIED
			"id": 317118, "points": 5,
			"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		"a_EndingD": { // VERIFIED
			"id": 322230, "points": 5,
			"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		"a_EndingE": { // VERIFIED
			"id": 322231, "points": 5,
			"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => after talk with dana, go to present and get dana's letter => give letter to dana in middle ages => Destroyed Lab"},
		"a_EndingEXCureHelena": { // VERIFIED
			"id": 405114, "points": 4,
			"devInfo": "In EX Chapter: give the stone to Dr. Wagner in the past"},		
		"a_EndingEXKillHomunculus": { // VERIFIED
			"id": 405113, "points": 4,
			"devInfo": "In EX Chapter: after heading to past, return back to present to die, so you can kill Homunulus in Limbo with the red stone"}},
	"c_Extra": { // Category - Extra side content & cutscenes
		"a_AntiquesEule": { // VERIFIED
			"id": 310132, "points": 2,
			"devInfo": "Take a glance at timeless antiquity at Antique Shop Eule. Shop is open in chapter 3, 4 (present) and 6, 7 (1980)"},
		"a_ArtAppreciator": { // VERIFIED
			"id": 307499, "points": 1,
			"devInfo": "Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor"}, 
		"a_ArtInspiration1": { // VERIFIED
			"id": 403824, "points": 3,
			"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him at least once => view art in present, when Brum Estate is in Museum from"},
		"a_ArtInspirationAll": { // VERIFIED
			"id": 403825, "points": 5,
			"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him with different idea's => view art in present, when Brum Estate is in Museum from"},
		"a_BarmansChildren": { // VERIFIED
			"id": 315567, "points": 3,
			"devInfo": "Uncover the truth about the barman's children and the mystery child during chapter 5"},
		"a_DoctorateTimeTraveling": { // VERIFIED
			"id": 310163, "points": 3,
			"devInfo": "Complete chapter 4 whilst also taking the a picture yourself in this chapter AND having acquired the ornamental egg from the performer in chapter 1 but did NOT use it to give your past self a message"},
		"a_DrunkenGuys": { // VERIFIED
			"id": 404048, "points": 2,
			"devInfo": "In chapter 7, once you have the tower key => find them in the present in the car park (not night before)"},
		"a_EggPocketWatchForCoffee": { // VERIFIED
			"id": 313213, "points": 3,
			"devInfo": "Show off the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward"},
		"a_FreeMeal": { // VERIFIED 
			"id": 405461, "points": 3,
			"devInfo": "Save bar in chap 1 by talking to barman => start chap 5 using free meal"},
		"a_GetExChapterOrnamentalEgg": { // VERIFIED
			"id": 405112, "points": 1,
			"devInfo": "In the EX Chapter: go to the performer after not saving grandpa in the fire, thus getting the egg"},
		"a_GiveMargaretteCake": { // VERIFIED
			"id": 402296, "points": 3,
			"devInfo": "Acquire cake from bakery => give to margarette"}, 		
		"a_HugoMotherChild": { // VERIFIED
			"id": 311466, "points": 2,
			"devInfo": "Secret cutscene in chapter 5 => when going to 1580 (not 1584) => head to marktplatz of Hugo getting bullied"}, 
		"a_MaxInventory": { // VERIFIED
			"id": 402404, "points": 10,
			"devInfo": "Only achievable when going for Ending E: Z-pad, notebook, present city map, old map, cellphone, lighter, egg ornament OR Frying pan, medallion, old book, monochrome picture, cake, franssen shop sign, kitten, egg pocket watch, scrap meat, tower key, lab key, red jewel, Dana's letter, comb"}, 
		"a_MeetFamousOleg": { // VERIFIED
			"id": 404045, "points": 3,
			"devInfo": "After acquiring the egg pocket watch in chapter 6 => Go to bar in 1900s and pay for coffee => Oleg now spawns in chapter 7 near movie post, after you have the tower key (not night before)"},
		"a_MeetOldMiriam": { // VERIFIED
			"id": 315570, "points": 3,
			"devInfo": "Complete chapter 7, whilst having saved Miriam in chapter 6"},
		"a_NewCakeInvented": { // VERIFIED
			"id": 402297, "points": 3,
			"devInfo": "Take the cake => give it to margarete => talk to bakery girl again (name of cake is now margarete)"}, 		
		"a_PerformerGoingExtraMile": { // VERIFIED
			"id": 403575, "points": 3,
			"devInfo": "Make sure the performer goes the extra mile, by surprising as many people as possible"},
		"a_PocketWatchCollection": { // VERIFIED
			"id": 315561, "points": 3,
			"devInfo": "Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7, not night before"},
		"a_PocketWatchReminiscing": { // VERIFIED
			"id": 315562, "points": 3,
			"devInfo": "Talk to Eckart with the pocket watch in your inventory during chapter 8"},
		"a_PocketWatchTo80sBarman": { // VERIFIED
			"id": 407681, "points": 2,
			"devInfo": "Use the pocket watch next to the barman in 1980, the cold days. He's inside the bar."},
		"a_RunningAcrossThe90s": { // VERIFIED
			"id": 405086, "points": 2,
			"devInfo": "Talk to jogging man in present and past (70s)"},
		"a_SaveMiriamBrum": { // VERIFIED
			"id": 315569, "points": 3,
			"devInfo": "Save Miriam Brum in chapter 6"},			
		"a_ScareEveryone": { // VERIFIED
			"id": 404046, "points": 3,
			"devInfo": "Startle the spaghetti man in the present + the crowd (counts for 4) + the wannabe apprentice + the eccentric girl with a lighter or cellphone"},
		"a_SeenOlegAsWell": { // VERIFIED
			"id": 405098, "points": 2,
			"devInfo": "Talk with the adult inside cafe Sonne during chapter 6, he talks about the movie director staring at the sky"},
		"a_ShowEggTownPlanter": { // VERIFIED
			"id": 307023, "points": 3,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_ShowPocketWatchToPhotographer": { // VERIFIED 
			"id": 405460, "points": 2,
			"devInfo": "In chapter 6 or 7, show the pocket watch to Oleg, movie director's ancestor in 1902"},
		"a_ShortestChapter": { // VERIFIED
			"id": 403823, "points": 3,
			"devInfo": "Have frying pan before chapter 4 and use is to skip chapter 4, by using it at the start"},
		"a_SnowyCrimeScene": { // VERIFIED
			"id": 313209, "points": 2,
			"devInfo": "Discover a crime scene during the winter, in chapter 6"},
		"a_TimeTravellingCat": { // VERIFIED
			"id": 310426, "points": 4,
			"devInfo": "Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart in present => give kitten before chapter 7"}},
	"c_ExtraCouple": { // Category - Related to the mysterious couple 
		"a_EnigmaticCouple1": { // VERIFIED
			"id": 307495, "points": 3,
			"devInfo": "Find the coated couple in the present during the prologue or chapter 1"},
		"a_EnigmaticCouple2": { // VERIFIED
			"id": 310131, "points": 3,
			"devInfo": "Find the coated couple in the present during chapter 3"},
		"a_EnigmaticCouple3": { // VERIFIED
			"id": 310134, "points": 3,
			"devInfo": "Find the coated couple in the present during chapter 4"},	
		"a_EnigmaticCouple4": { // VERIFIED
			"id": 310135, "points": 3,
			"devInfo": "Find the coated couple in the present during chapter 5"},	
		"a_EnigmaticCouple5": { // VERIFIED
			"id": 315564, "points": 3,
			"devInfo": "Find the coated couple in the present during chapter 7"},	
		"a_LostYoungCouple1": { // VERIFIED
			"id": 306984, "points": 3,
			"devInfo": "Interact with the lost couple in the Middle Ages during chapter 2"},
		"a_LostYoungCouple2": { // VERIFIED
			"id": 310133, "points": 3,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 3"},
		"a_LostYoungCouple3": { // VERIFIED
			"id": 309393, "points": 3,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 4"},
		"a_LostYoungCouple4": { // VERIFIED
			"id": 310162, "points": 1,
			"devInfo": "Interact with the lost man in Middle Ages during chapter 5"},
		"a_LostYoungCouple5": { // VERIFIED
			"id": 314753, "points": 3,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 7"},
		"a_LostYoungCouple6": { // VERIFIED
			"id": 315568, "points": 5,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 8"}},
	"c_ExtraEnergy": { // Category - Related to energy orb gathering
		"a_EnergyOrbLocatorPresentDay": { // VERIFIED
			"id": 399816, "points": 5,
			"devInfo": "Find all 5 energy orbs in present day"},
		"a_EnergyOrbLocator70s80s": { // VERIFIED
			"id": 399817, "points": 5,
			"devInfo": "Find all 5 energy orbs in 70s/80s"}, 
		"a_EnergyOrbLocator1900Days": { // VERIFIED
			"id": 399818, "points": 5,
			"devInfo": "Find all 5 energy orbs in 1900s"}, 
		"a_EnergyOrbLocatorMiddleAges": { // VERIFIED
			"id": 399819, "points": 5,
			"devInfo": "Find all 6 energy orbs in Middle Ages"}
		},
	"c_ExtraGameOver": { // Category - Secret cutscenes that lead to player dying or game over screen
		"a_ErasingEike": { // VERIFIED
			"id": 306883, "points": 2,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
		"a_ErasingEike2": { // VERIFIED
			"id": 314763, "points": 1,
			"devInfo": "Meet yourself at the Brum's mansion during chapter 7"},
		"a_ExcuseMeMyMy": { // VERIFIED
			"id": 306919, "points": 1,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
		"a_MetYouBefore": { // VERIFIED
			"id": 306888, "points": 2,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_RottenRope": { // VERIFIED
			"id": 315563, "points": 1,
			"devInfo": "Try to save yourself with an old rope during chapter 7"},
		"a_TimeEgoFlop": { // VERIFIED
			"id": 313212, "points": 1,
			"devInfo": "During chapter 6, co-direct Time Ego"}}}
// -------------------------------------
achievements_typeByCategory = {
	// DEV_NOTE: Achievement type property
	//		- Possible type keys: "missable" - "progression" - "win_condition"
	//		- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_template": "xxxxxx",
	"c_Completion": 						"progression",
	"c_Endings": 							"win_condition",
	"c_AchievementPercentage": 				"missable",
	"c_Branch": 							"missable",
	"c_Extra":				 				"missable",
	"c_ExtraCouple":						"missable",
	"c_ExtraEnergy":						"missable",
	"c_ExtraGameOver": 						"missable",}

// ***********************************
// • Achievements TRIGGER GENERATORS •
// ***********************************
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_FullTrigger_MaxAchievementRate(enum_chapter, dict_BitFlags) {
	// DEV_NOTE: Measure flag with "sum_of() == value" instead of a tally()
	// ----------------------------------
	// 	- This function generates a measure with no hit target. But uses Add Source flags generated with sum_of()
	//	- Example output of this function: measured((bit0(0xAA1178) + bit1(0xAA1178) + bit2(0xAA1178) + bit3(0xAA1178) + bit4(0xAA1178)) == 5
	//		-- In this case each bit would count for 20% or 1/5th

	let_bitFlagMemoryAccessors = memUtil_percentageBitflagsDictToMemoryAccessorArray(dict_BitFlags)

	let_totalAmountOfBitFlags = memUtil_countTotalAmountOfBitFlags(dict_BitFlags)
	let_arithmeticSumOfExpression = sum_of(let_bitFlagMemoryAccessors, (memoryAccessor) => memoryAccessor)	// output example of sum_of(): [bit0(0x00), bit1(0x00), bitcount(0x01)] => bit0(0x00) + bit1(0x00) + bitcount(0x01)
	let_measuredComparison = let_arithmeticSumOfExpression == let_totalAmountOfBitFlags // Example comparison stored in this variable: bit0(0x00) + bit1(0x00) + bitcount(0x01) == 4

	let_arithmeticSumOfExpression = sum_of(let_bitFlagMemoryAccessors, (memoryAccessor) => prev(memoryAccessor))
	let_deltaComparison = let_arithmeticSumOfExpression < let_totalAmountOfBitFlags 	// Example comparison stored in this variable: prev(bit0(0x00)) + prev(bit1(0x00)) + prev(bitcount(0x01)) < 4

	if (enum_chapter == "Total") {
		return 
			let_deltaComparison && 
			measured(let_measuredComparison, when = is_InGame(), format = "percent")
	} else {
		return 
			let_deltaComparison && 
			measured(let_measuredComparison, when = is_Chapter(enum_chapter) && is_InGame(), format = "percent")
	}}
function achievements_generate_FullTrigger_EnergyCollector(enum_timePeriod) {
	function create_TallyComparisonArray(enum_timePeriod) {
		let_tallyComparisonArray = []
		let_sharedArea = get_EnergyOrb_sharedAreas(enum_timePeriod)
		for let_OrbLocationKey in get_EnergyOrb_Locations(enum_timePeriod) {
			let_arrayAreaEnums = get_EnergyOrb_Location_area(enum_timePeriod, let_OrbLocationKey)
			if(let_sharedArea == iNULL && let_arrayAreaEnums == iNULL)
				util_throwError("At least one area must be given for energy orb: {0}", let_OrbLocationKey)			
			let_areaComparisonArray = [always_true()]
			if (let_arrayAreaEnums != iNULL && length(let_arrayAreaEnums) > 0) {
				for enum_area in let_arrayAreaEnums {
					array_push(let_areaComparisonArray, is_Area(enum_area))
				}
			}
			let_areaComparison = any_of(let_areaComparisonArray, (comparison) => comparison)
			array_push(let_tallyComparisonArray, once(let_areaComparison && on_EnergyOrb_Collect(enum_timePeriod, let_OrbLocationKey)))
		}
		return let_tallyComparisonArray}
	function create_Pause_WhenNotInSharedAreas(enum_timePeriod) {		
		let_sharedAreas = get_EnergyOrb_sharedAreas(enum_timePeriod)
		let_pauseComparisonArray = iNULL
		if(let_sharedAreas != iNULL){
			if (length(let_sharedAreas) < 1) util_throwError(format("const_EnergyOrbs_data sharedArea for enum_TimePeriod: {0}, must contain one enum_area Or be iNULL", enum_timePeriod))
			let_pauseComparisonArray = achievements_generate_ComparisonArray_CheckAllAreas(let_sharedAreas)
		}
		if (let_pauseComparisonArray == iNULL) { return 
			always_true()
		} else { return 
			unless(
				none_of(let_pauseComparisonArray, (comparison) => comparison)
			)
		}}
	return 
		unless(is_Loading()) &&
		create_Pause_WhenNotInSharedAreas(enum_timePeriod) &&
		measured(
			tally(get_EnergyOrb_amountToCollect(enum_timePeriod), 
				create_TallyComparisonArray(enum_timePeriod))
		) &&
		trigger_when(on_Cutscene_end()) &&
		never_toAlt(
			!is_InGame() ||
			on_Chapter_change() ||
			on_EnergyUnits_decrement()
		)
	}	
// -------- Below trigger generators are deprecated -------- 
function achievements_generate_TextComparison_GotEnergyUnit() {
	let_charactersToCheck = {	// (G)ot (E)nerg(Y) un(I)t.
		"G": {
			"height": 0x48,
			"print_Xaxis": 0x0,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x0,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"E": {
			"height": 0x48,
			"print_Xaxis": 0x1f,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x38,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"Y": {
			"height": 0x49,
			"print_Xaxis": 0x4b,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x54,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x1,
			"characterSetId": 0x8},	
		"I": {
			"height": 0x48,
			"print_Xaxis": 0x6c,
			"imageOffset_Xaxis": 0x0,
			"imageOffset_Yaxis": 0x46,
			"imageUnmask_Width": 0x4,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8}}
	return 
		is_TotalCharacterCountOnBottomScreen(14) &&
		is_CharacterOnBottomScreen(0, let_charactersToCheck["G"]) &&	// Check prior values, since on_EnergyUnits_increment() hits when the text is already gone
		is_CharacterOnBottomScreen(3, let_charactersToCheck["E"]) &&
		// is_CharacterOnBottomScreen(8, let_charactersToCheck["Y"]) &&
		is_CharacterOnBottomScreen(11, let_charactersToCheck["I"])}


function achievements_generate_TextComparison_CannotCarryMore() {
	let_charactersToCheck = {	// I c(A)nnot ca(R)ry an(Y) mor(E).
		"A": {
			"height": 0x48,
			"print_Xaxis": 0x12,
			"imageOffset_Xaxis": 0x18,
			"imageOffset_Yaxis": 0x38,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"R": {
			"height": 0x48,
			"print_Xaxis": 0x56,
			"imageOffset_Xaxis": 0x6c,
			"imageOffset_Yaxis": 0x46,
			"imageUnmask_Width": 0x7,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"Y": {
			"height": 0x49,
			"print_Xaxis": 0x86,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x54,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x1,
			"characterSetId": 0x8},	
		"E": {
			"height": 0x48,
			"print_Xaxis": 0xb0,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x38,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8}}
	return 
		is_TotalCharacterCountOnBottomScreen(20) &&
		is_CharacterOnBottomScreen(2, let_charactersToCheck["A"]) &&	// Check prior values, since on_EnergyUnits_increment() hits when the text is already gone
		is_CharacterOnBottomScreen(9, let_charactersToCheck["R"]) &&
		// is_CharacterOnBottomScreen(14, let_charactersToCheck["Y"]) &&
		is_CharacterOnBottomScreen(18, let_charactersToCheck["E"])}

function achievements_generate_ComparisonArray_CheckAllAreas(array_areaEnums) {
	let_comparisonArray = []
	if (array_areaEnums != iNULL) {
		if (length(array_areaEnums) < 1) 
			array_push(let_comparisonArray, always_true())
		else {
			for enum_area in array_areaEnums {
				array_push(let_comparisonArray, is_Area(enum_area))
			}
		}
	}
	return let_comparisonArray}


function achievements_generate_FullTrigger_EnergyCollector_old(enum_timePeriod) {
	function create_TallyComparisonArray(enum_timePeriod) {
		let_tallyComparisonArray = []
		for let_OrbLocationKey in get_EnergyOrb_Locations(enum_timePeriod) {
			let_comparison1 = [achievements_generate_TextComparison_CannotCarryMore()]
			let_comparison2 = [achievements_generate_TextComparison_GotEnergyUnit()]
			let_position = get_EnergyOrb_Location_position(enum_timePeriod, let_OrbLocationKey)
			let_orbLocationArea = get_EnergyOrb_Location_area(enum_timePeriod, let_OrbLocationKey)

			if(let_position == iNULL && let_orbLocationArea == iNULL)
				util_throwError(format("EnergyOrb '{0}': pos or area must by given", let_OrbLocationKey))
			if(let_orbLocationArea == iNULL && let_position != iNULL) {
				let_xLocation = let_position["xAxis"]
				let_yLocation = let_position["yAxis"]
				if(let_yLocation == iNULL || let_xLocation == iNULL)
					util_throwError(format("EnergyOrb '{0}': if area is NULL then both axes must be given", let_OrbLocationKey))
				array_push(let_comparison1, is_PlayerPosition_Xaxis_Near(let_xLocation))
				array_push(let_comparison2, is_PlayerPosition_Xaxis_Near(let_xLocation))
				array_push(let_comparison1, is_PlayerPosition_Yaxis_Near(let_yLocation))
				array_push(let_comparison2, is_PlayerPosition_Yaxis_Near(let_yLocation))
			}
			if(get_EnergyOrb_sharedAreas(enum_timePeriod) == iNULL) {
				if(let_orbLocationArea == iNULL) util_throwError("If sharedArea == NULL, then each energyOrb_area must be an array with at least one enum_Area")
				if(length(let_orbLocationArea) < 1) util_throwError("If sharedArea == NULL, then each energyOrb_area must be an array with at least one enum_Area")
				let_areaComparisonArray = achievements_generate_ComparisonArray_CheckAllAreas(let_orbLocationArea)
				let_areaComparison = any_of(let_areaComparisonArray, (comparison) => comparison)
				array_push(let_comparison1, let_areaComparison)
				array_push(let_comparison2, let_areaComparison)
			}
			array_push(let_tallyComparisonArray, once(all_of(let_comparison1, (comparison) => comparison)))			
			array_push(let_tallyComparisonArray, once(all_of(let_comparison2, (comparison) => comparison)))
		}
		return let_tallyComparisonArray}
	function create_Pause_WhenNotInSharedAreas(enum_timePeriod) {		
		let_sharedAreas = get_EnergyOrb_sharedAreas(enum_timePeriod)
		let_pauseComparisonArray = []
		if(let_sharedAreas != iNULL){
			if (length(let_sharedAreas) < 1) util_throwError(format("const_EnergyOrbs_data sharedArea for enum_TimePeriod: {0}, must contain one enum_area Or be iNULL", enum_timePeriod))
			let_pauseComparisonArray = achievements_generate_ComparisonArray_CheckAllAreas(let_sharedAreas)
		}
		if (length(let_pauseComparisonArray) < 1) {	return 
			always_true()
		} else { return 
			unless(
				none_of(let_pauseComparisonArray, (comparison) => comparison)
			)
		}}
	return 
		disable_when(
			repeated(70 ,	// <-- delay, so trigger has to time to hit
				is_BottomScreenText_empty()),
			until = on_BottomScreenText_render()
		) &&
		unless(!is_InGame() && is_Loading()) &&
		create_Pause_WhenNotInSharedAreas(enum_timePeriod) &&
		measured(
			tally(get_EnergyOrb_amountToCollect(enum_timePeriod), 
				create_TallyComparisonArray(enum_timePeriod))
		) &&
		trigger_when(on_Cutscene_end())
	}

function achievements_generate_Tally_PickUpEnergyOrbs(int_tallyCount) {
	let_charactersToCheck = {	// (G)ot (E)nerg(Y) un(I)t.
		"G": {
			"height": 0x48,
			"print_Xaxis": 0x0,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x0,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"E": {
			"height": 0x48,
			"print_Xaxis": 0x1f,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x38,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8},
		"Y": {
			"height": 0x49,
			"print_Xaxis": 0x4b,
			"imageOffset_Xaxis": 0x48,
			"imageOffset_Yaxis": 0x54,
			"imageUnmask_Width": 0x9,
			"print_Yaxis": 0x1,
			"characterSetId": 0x8},	
		"I": {
			"height": 0x48,
			"print_Xaxis": 0x6c,
			"imageOffset_Xaxis": 0x0,
			"imageOffset_Yaxis": 0x46,
			"imageUnmask_Width": 0x4,
			"print_Yaxis": 0x0,
			"characterSetId": 0x8}}
	return
		tally(int_tallyCount, 
			on_EnergyUnits_increment() &&
			was_MinimumAmountOfCharactersOnBottomScreen(14) &&		
			was_CharacterOnBottomScreen(0, let_charactersToCheck["G"]) &&	// Check prior values, since on_EnergyUnits_increment() hits when the text is already gone
			was_CharacterOnBottomScreen(3, let_charactersToCheck["E"]) &&
			was_CharacterOnBottomScreen(8, let_charactersToCheck["Y"]) &&
			was_CharacterOnBottomScreen(11, let_charactersToCheck["I"]) &&
			!is_LargeCutscene_active()	// Don't switch with is_NoCutscene_active() --> FIXfor: picking up energy orb in chapter 3, when energy drained by Homunculus. The cutscene flag here doesn't turn to 0x0 , but turns to a small cutscene
		)}

// *************************
// • Achievements TRIGGERS •
// *************************
achievements_triggers = {
	// "a_Template": function Template() {	// WIP_template
	// 	return always_false()
	// },
	"a_PrologueComplete": () { return
		never (	// Core group
			!is_InGame() ||
			is_EventViewer_active()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_Chapter(CHAPTER_Prologue)) &&
				once(	// Identifies Cutscene => watching performer
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x22480)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x1bcd0)	&&
					is_Cutscene_SectionDataId(0xe10)
				) &&
				once(	// Identifies cutscene => shadow/killer walking behind Eike
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x90bc0)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x1ae70)	&&
					is_Cutscene_SectionDataId(0x75d10)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Prologue)
			)
		)},
	"a_Chapter1Complete": function Chapter1Complete() { return
		never (	// Core group
			!is_InGame() ||
			is_EventViewer_active()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => burning bar changes into non-burning
					is_LargeCutscene_active() && is_Chapter(CHAPTER_Chapter1) &&
					is_Cutscene_MasterId(0x11a40)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0xbea0)	&&
					is_Cutscene_SectionDataId(0x5b80)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter1)
			)
		)},
	"a_Chapter2Complete": function Chapter2Complete() { return
		never (	// Core group
			!is_InGame() ||
			is_EventViewer_active()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes
				unless(!is_Chapter(CHAPTER_Chapter2)) &&
				once(	// Identifies Cutscene => reminiscing about Dana: left in the past					
					is_SelectedItemInScrollBar(ITEM_Dpad) &&
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x3b240)		&&
					is_Cutscene_MasterDataId(0x340e0)	&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x340e0)	&&
					is_Cutscene_SectionDataId(0x7130)
				) &&
				once(	// Identifies Cutscene => stopping to smoke + turning around to see flowers/statue
					is_SelectedItemInScrollBar(ITEM_Dpad) &&
					is_LargeCutscene_active() 			&& 
					is_Cutscene_SectionId_1(0x3)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x11240)	&&
					is_Cutscene_SectionDataId(0x2b0)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter2)
			)
		)},
	"a_Chapter3Complete": function Chapter3Complete() { return
		never (	// Core group
			!is_InGame() ||
			is_EventViewer_active()	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_Chapter(CHAPTER_Chapter3)) &&			
				once(	// Identifies Cutscene => Time travel back to Brum Museum  
					is_SelectedItemInScrollBar(ITEM_Dpad) &&
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x19d80)		&&	
					is_Cutscene_SectionId_1(0x1) 		&&
					is_Cutscene_SectionId_2(0x0) 		&&
					is_Cutscene_MasterDataId(0x82a0)	&&
					is_Cutscene_SectionDataId(0x11ac0)
				) &&
				once(	// Identifies Cutscene => Back to Eckart and breaking vase
					is_SelectedItemInScrollBar(ITEM_Dpad) &&
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0xcfb40)		&& was_Cutscene_MasterId(0x19d80) &&	
					is_Cutscene_SectionId_1(0x1) 		&&
					is_Cutscene_SectionId_2(0x0) 		&&
					is_Cutscene_MasterDataId(0x39f0)	&&
					is_Cutscene_SectionDataId(0x387a0)
				) &&
				once(	// Identifies Cutscene => Back downstairs and talk to Homunculus
					is_SelectedItemInScrollBar(ITEM_Dpad) &&
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x39680)		&& was_Cutscene_MasterId(0xcfb40) &&	
					is_Cutscene_SectionId_1(0x1) 		&&
					is_Cutscene_SectionId_2(0x0) 		&&
					is_Cutscene_MasterDataId(0x7e10)	&&
					is_Cutscene_SectionDataId(0x7ca0)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter3)
			)
		)},
	"a_Chapter4CompletePan": function Chapter4CompletePan() { return
		never(	// Core group
			!is_InGame() 					||
			is_EventViewer_active()			||
			on_Cutscene_MasterId_change()	||
			!is_SelectedItemInScrollBar(ITEM_FryingPan)
		) &&
		(
			( // Alt 1 
				unless(!is_Chapter(CHAPTER_Chapter4)) && 
				once(	// Identifies cutscene => protecting yourself with pan 
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x4f200)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x11cd0)	&&
					is_Cutscene_SectionDataId(0x3d500)
				) &&
				on_Cutscene_end()
			) || ( // Alt 2 
				once(	// Identifies cutscene => protecting yourself with pan AND having taken the picture in the performer outfit
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x54580)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x17060)	&&
					is_Cutscene_SectionDataId(0x1390)
				) &&
				on_Cutscene_end()
			) || (	// Alt 3; Failsafe
				on_Chapter_finish(CHAPTER_Chapter4)
			)
		)},
	"a_Chapter4CompleteSign": function Chapter4CompletePan() { return
		never(	// Core group
			!is_InGame() 					||
			is_EventViewer_active()			||
			on_Cutscene_MasterId_change()	||
			!is_SelectedItemInScrollBar(ITEM_Sign)
		) &&
		(
			( // Alt 1 
				once(	// Identifies cutscene => protecting yourself with sign + info about photo from Homnunculus
					is_LargeCutscene_active() && is_Chapter(CHAPTER_Chapter4) &&
					is_Cutscene_MasterId(0x54580)		&&
					is_Cutscene_SectionId_1(0xd)		&&
					is_Cutscene_SectionId_2(0xe)		&&
					is_Cutscene_MasterDataId(0xb6e0)	&&
					is_Cutscene_SectionDataId(0xae50)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2
				on_Chapter_finish(CHAPTER_Chapter4)
			)
		)},
	"a_Chapter5Complete": function Chapter5Complete() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				once(	// Identifies Cutscene => drinking antidote
					is_LargeCutscene_active() && is_Chapter(CHAPTER_Chapter5) &&
					is_SelectedItemInScrollBar(ITEM_Antidote)	&&
					is_Cutscene_MasterId(0x3f980)			&&
					is_Cutscene_SectionId_1(0xffff)		&&
					is_Cutscene_SectionId_2(0x0)			&&
					is_Cutscene_MasterDataId(0x3f980)		&&
					is_Cutscene_SectionDataId(0x3f980)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter5)
			)
		)},
	"a_Chapter6CompleteThriller": function Chapter6CompleteThriller() {	return
		// Core group
		never(
			!is_InGame() ||
			is_EventViewer_active() 
		) &&
		is_MovieTimeTravel_chosen() &&
		is_MovieThriller_chosen() 	&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					is_LargeCutscene_active() && 
					is_Cutscene_MasterId(0x9db40)		&&
					is_Cutscene_SectionId_1(0x7)		&&
					is_Cutscene_SectionId_2(0x8)		&&
					is_Cutscene_MasterDataId(0x66600)	&&
					is_Cutscene_SectionDataId(0x20cd0)
				) && 
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe
				on_Chapter_finish(CHAPTER_Chapter6)
			)
		)},
	"a_Chapter6CompleteLove": function Chapter6CompleteLove() {	return
		// Core group
		never(
			!is_InGame() ||
			is_EventViewer_active() 
		) &&
		is_MovieTimeTravel_chosen() &&
		is_MovieLove_chosen() 		&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					is_LargeCutscene_active() && 				
					is_Cutscene_MasterId(0x9db40)		&&
					is_Cutscene_SectionId_1(0x7)		&&
					is_Cutscene_SectionId_2(0x8)		&&
					is_Cutscene_MasterDataId(0x66600)	&&
					is_Cutscene_SectionDataId(0x20cd0)
				) && 
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe
				on_Chapter_finish(CHAPTER_Chapter6)
			)
		)},
	"a_Chapter7Complete": function Chapter7Complete() { return
		never (	// Core group
			!is_InGame() ||
			is_EventViewer_active()	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	 (Also works when saving Miriam => Miriam is a counts as an extra in-between cutscene)			
				unless(!is_Chapter(CHAPTER_Chapter7)) &&
				once(	// Identifies Cutscene => Holding onto rope 
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x43040)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x7ce0)	&&
					is_Cutscene_SectionDataId(0xd940)
				) &&
				tally(1,[	// One of these is true, depending on ancestress or no ancestress choice
					once(	// Identifies Cutscene => Talking to Eckart, Ancestress path 
						is_LargeCutscene_active()			&&
						is_MargaretteTold_Ancestor() 		&&
						is_Cutscene_MasterId(0xc6800)		&&
						is_Cutscene_SectionId_1(0x5)		&&
						is_Cutscene_SectionId_2(0x4)		&&
						is_Cutscene_MasterDataId(0x45720)	&&
						is_Cutscene_SectionDataId(0x6ccd0)),
					once(	// Identifies Cutscene => Talking to Eckart, No Ancestress path 
						is_LargeCutscene_active()			&&
						is_MargaretteTold_NoAncestor() 		&&
						is_Cutscene_MasterId(0xd1bc0)		&&
						is_Cutscene_SectionId_1(0x3)		&&
						is_Cutscene_SectionId_2(0x4)		&&
						is_Cutscene_MasterDataId(0x48000)	&&
						is_Cutscene_SectionDataId(0x5b190))]
				) &&
				once(	// Identifies Cutscene => Looking at painting of Dana
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x12040)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0xce0)	&&
					is_Cutscene_SectionDataId(0x11330)
				) &&
				on_Cutscene_end()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter7)
			)
		)},
	"a_Chapter8Complete": function Chapter8Complete() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) && 
		(	
			(	// Alt 1 => Ending A (Talk to Fortune Teller AND Homunculus => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress)) &&
				once(	// Identifies Cutscene => Talk to Homunculus
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x8b640)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x2d440)	&&
					is_Cutscene_SectionDataId(0x42750)
				) &&
				once(	// Identifies Cutscene => Summon Dr. Wagner with Homunculus
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x10ef00)		&&
					is_Cutscene_SectionId_1(0x9)		&&
					is_Cutscene_SectionId_2(0x8)		&&
					is_Cutscene_MasterDataId(0xb620)	&&
					is_Cutscene_SectionDataId(0xf4d0)
				) &&
				once(	// Identifies Cutscene => Dr. Wagner confronts Hugo
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0xe4800)		&&
					is_Cutscene_SectionId_1(0x9)		&&
					is_Cutscene_SectionId_2(0xa)		&&
					is_Cutscene_MasterDataId(0x66aa0)	&&
					is_Cutscene_SectionDataId(0x5d060)
				) &&
				is_MargaretteTold_Ancestor() &&
				on_Cutscene_end()
			) || 
			(	// Alt 2 => Ending B1 (Talk to Fortune Teller => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress)) &&
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0xd5440)		&&
					is_Cutscene_SectionId_1(0x7)		&&
					is_Cutscene_SectionId_2(0x6)		&&
					is_Cutscene_MasterDataId(0x41550)	&&
					is_Cutscene_SectionDataId(0x2b420)
				) &&
				once(	// Identifies Cutscene => Hugo inside old Alchemist house collapsing
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x716c0)		&&
					is_Cutscene_SectionId_1(0x9)		&&
					is_Cutscene_SectionId_2(0xa)		&&
					is_Cutscene_MasterDataId(0x239f0)	&&
					is_Cutscene_SectionDataId(0x19ef0)
				) &&
				once(	// Identifies Cutscene => Eike consoling Margarette
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0xf3c80)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x91c30)	&&
					is_Cutscene_SectionDataId(0x62030)
				) &&
				is_MargaretteTold_Ancestor() &&
				on_Cutscene_end()
			) || (	// Alt 3 => Ending B2 (Talk to Homunculus => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress)) &&
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0xfbd00)		&&
					is_Cutscene_SectionId_1(0x5)		&&
					is_Cutscene_SectionId_2(0x4)		&&
					is_Cutscene_MasterDataId(0x5ff00)	&&
					is_Cutscene_SectionDataId(0x26f30)
				) &&
				once(	// Identifies Cutscene => Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0xc4e40)		&& was_Cutscene_MasterId(0xfbd00) &&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x62650)	&&
					is_Cutscene_SectionDataId(0x6be0)
				) &&
				is_MargaretteTold_Ancestor() &&
				on_Cutscene_end()
			) || (	// Alt 4 => Ending C (Visit destroyed lab => return to Hugo)
				once(	// Identifies Cutscene => Talk to Homunculus at square after seeing young Hugo erase old Hugo
					is_LargeCutscene_active() && is_Chapter(CHAPTER_Chapter8_Ancestress) &&
					is_Cutscene_MasterId(0x1cbc0)		&&
					is_Cutscene_SectionId_1(0x5)		&&
					is_Cutscene_SectionId_2(0x4)		&&
					is_Cutscene_MasterDataId(0xc8e0)	&&
					is_Cutscene_SectionDataId(0x98f0)
				) &&
				is_MargaretteTold_Ancestor() &&
				on_Cutscene_end()
			) || (	// Alt 5 => Ending D (Did not save Dana => Destroyed Lab)
				unless(!is_Chapter(CHAPTER_Chapter8_NoAncestress)) &&
				once(	// Identifies Cutscene => Flashback to Hugo trying to read burnt documents
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x77a40)		&& was_Cutscene_MasterId(0x29700) &&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x31fd0)	&&
					is_Cutscene_SectionDataId(0x45a10)
				) &&
				once(	// Identifies Cutscene => Eike confronts Hugo at square
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0x4b140)		&& was_Cutscene_MasterId(0x77a40) &&
					is_Cutscene_SectionId_1(0x5)		&&
					is_Cutscene_SectionId_2(0x4)		&&
					is_Cutscene_MasterDataId(0x122b0)	&&
					is_Cutscene_SectionDataId(0x189f0)
				) &&
				once(	// Identifies Cutscene => Margarette dissapears after Hugo dissappeared
					is_LargeCutscene_active()			&&
					is_Cutscene_MasterId(0xc9440)		&& was_Cutscene_MasterId(0xa00c0) &&
					is_Cutscene_SectionId_1(0x3)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x46b50)	&&
					is_Cutscene_SectionDataId(0x828a0)
				) &&
				is_Dana_Left_InPast() && is_MargaretteTold_NoAncestor() &&
				on_Cutscene_end()				
			) || (	// Alt 6 => Ending E (Save Dana => Destroyed Lab)
				unless(!is_Chapter(CHAPTER_Chapter8_NoAncestress)) &&
				once(	// Identifies Cutscene => Brought Margarette to present
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x101bc0)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x77920)	&&
					is_Cutscene_SectionDataId(0x725d0)
				) &&
				once(	// Identifies Cutscene => Margarette confronts Hugo in square
					is_LargeCutscene_active() 			&& 
					is_Cutscene_MasterId(0x137500)		&& was_Cutscene_MasterId(0x101bc0) &&
					is_Cutscene_SectionId_1(0xc)		&&
					is_Cutscene_SectionId_2(0xd)		&&
					is_Cutscene_MasterDataId(0x7bdf0)	&&
					is_Cutscene_SectionDataId(0x55290)
				) &&
				is_Dana_Saved_FromPast() && is_MargaretteTold_NoAncestor() &&
				on_Cutscene_end()
			) || // Alt 7+8 => Failsafe; triggers on chapter change
			on_Chapter_finish(CHAPTER_Chapter8_Ancestress) ||
			on_Chapter_finish(CHAPTER_Chapter8_NoAncestress)
		)},
	"a_MaxAchievementPrologue": function MaxAchievementPrologue() {
		let_PercentageBitFlags = const_percentageBitflags_new["Prologue"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Prologue, let_PercentageBitFlags)},
	"a_MaxAchievementChapter1": function MaxAchievementChapter1() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter1"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter1, let_PercentageBitFlags)},
	"a_MaxAchievementChapter2": function MaxAchievementChapter2() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter2"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter2, let_PercentageBitFlags)},
	"a_MaxAchievementChapter3": function MaxAchievementChapter3() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter3"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter3, let_PercentageBitFlags)},
	"a_MaxAchievementChapter4": function MaxAchievementChapter4() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter4"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter4, let_PercentageBitFlags)},
	"a_MaxAchievementChapter5": function MaxAchievementChapter5() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter5"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter5, let_PercentageBitFlags)},
	"a_MaxAchievementChapter6": function MaxAchievementChapter6() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter6"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter6, let_PercentageBitFlags)},
	"a_MaxAchievementChapter7": function MaxAchievementChapter7() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter7"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter7, let_PercentageBitFlags)},
	"a_MaxAchievementChapter8": function MaxAchievementChapter8() {
		let_PercentageBitFlags = const_percentageBitflags_new["Chapter8"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Chapter8, let_PercentageBitFlags)},
	"a_MaxAchievementEpilogue": function MaxAchievementEpilogue() {
		let_PercentageBitFlags = const_percentageBitflags_new["Epilogue"]
		return achievements_generate_FullTrigger_MaxAchievementRate(CHAPTER_Epilogue, let_PercentageBitFlags)},
	"a_MaxAchievementTotal": function MaxAchievementTotal() {
		return achievements_generate_FullTrigger_MaxAchievementRate("Total", memUtil_allPercentageBitFlagsToOneDict())},
	"a_EndingA": function EndingA() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_A)
		) &&
		once(	// Identifies Cutscene => Chosen to have Margarette stay in present + Z-pad breaks
			is_LargeCutscene_active() && !is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0xdb780)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x1bb0)	&&
			is_Cutscene_SectionDataId(0x32ce0)
		) &&
		once(	// Identifies Cutscene => Finding red jewel in tree at square
			is_LargeCutscene_active() && !is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x77f80)		&& was_Cutscene_MasterId(0xdb780) &&
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x25c50)	&&
			is_Cutscene_SectionDataId(0x1ac90)
		) &&		
		is_MargaretteTold_Ancestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_A))},
	"a_EndingB1": function EndingB1() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_B)
		) &&

		// Below 2 cutscenes, are commented => player can quit and reload game between these cutscenes 
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus
		// 	is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
		// 	is_Cutscene_MasterId(0x3dd40)		&&
		// 	is_Cutscene_SectionId_1(0x3)		&&
		// 	is_Cutscene_SectionId_2(0x2)		&&
		// 	is_Cutscene_MasterDataId(0x9d20)	&&
		// 	is_Cutscene_SectionDataId(0x1ed10)
		// ) &&
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus part2
		// 	is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
		// 	is_Cutscene_MasterId(0x81b00)		&& was_Cutscene_MasterId(0x3dd40) &&
		// 	is_Cutscene_SectionId_1(0x1)		&&
		// 	is_Cutscene_SectionId_2(0x2)		&&
		// 	is_Cutscene_MasterDataId(0x250f0)	&&
		// 	is_Cutscene_SectionDataId(0x13ff0)
		// ) &&

		// Below 2 cutscenes run up to ending credits
		once(	// Identifies Cutscene => Eike returns from sending Margarette back to past
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x613c0)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x43db0)	&&
			is_Cutscene_SectionDataId(0x1d5d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x56240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x400d0)	&&
			is_Cutscene_SectionDataId(0x16130)
		) &&
		is_MargaretteTold_Ancestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_B))},
	"a_EndingB2": function EndingB2() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_B)
		) &&
		once(	// Identifies Cutscene => Eike talks with Homunculus
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x91240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x44340)	&&
			is_Cutscene_SectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Eike gives z-pad back to Homunculus
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x5d2c0)		&& was_Cutscene_MasterId(0x91240) &&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x1efd0)	&&
			is_Cutscene_SectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x56240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x400d0)	&&
			is_Cutscene_SectionDataId(0x16130)
		) &&
		is_MargaretteTold_Ancestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_B))},
	"a_EndingC": function EndingC() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_C)
		) &&
		once(	// Identifies Cutscene => Giving z-pad back to Homunculus
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x8cf00)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x44340)	&&
			is_Cutscene_SectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Homunculus has bad feeling
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0x7b140)		&& was_Cutscene_MasterId(0x8cf00) &&
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x1d530)	&&
			is_Cutscene_SectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike getting roadkilled
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_Ancestress) &&
			is_Cutscene_MasterId(0xcb700)		&& was_Cutscene_MasterId(0x7b140) &&
			is_Cutscene_SectionId_1(0x5)		&&
			is_Cutscene_SectionId_2(0x6)		&&
			is_Cutscene_MasterDataId(0x1980)	&&
			is_Cutscene_SectionDataId(0x1e8d0)
		) &&
		is_MargaretteTold_Ancestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_C))},
	"a_EndingD": function EndingD() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_D)
		) &&
		once(	// Identifies Cutscene => Talk to Homunculus at square
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_NoAncestress) &&
			is_Cutscene_MasterId(0x709c0)		&&
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x4)		&&
			is_Cutscene_MasterDataId(0x24770)	&&
			is_Cutscene_SectionDataId(0x11790)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and becomes youthfull
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_NoAncestress) &&
			is_Cutscene_MasterId(0xc5b40)		&&
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x4)		&&
			is_Cutscene_MasterDataId(0x69b40)	&&
			is_Cutscene_SectionDataId(0x21b40)
		) &&
		is_Dana_Left_InPast() && is_MargaretteTold_NoAncestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_D))},
	"a_EndingE": function EndingE() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_E)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_NoAncestress) &&
			is_Cutscene_MasterId(0x88dc0)		&&
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x2c3a0)	&&
			is_Cutscene_SectionDataId(0x5ca00)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and Dr. Wagner is killed
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_NoAncestress) &&
			is_Cutscene_MasterId(0xbef80)		&&
			is_Cutscene_SectionId_1(0x9)		&&
			is_Cutscene_SectionId_2(0x8)		&&
			is_Cutscene_MasterDataId(0x59f60)	&&
			is_Cutscene_SectionDataId(0x155e0)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus some more
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Epilogue_NoAncestress) &&
			is_Cutscene_MasterId(0xcdcc0)		&& was_Cutscene_MasterId(0xbef80) &&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x33230)	&&
			is_Cutscene_SectionDataId(0x21780)
		) &&
		is_Dana_Saved_FromPast() && is_MargaretteTold_NoAncestor() &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_E))},
	"a_EndingEXKillHomunculus": function KillHomunculus() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_EX)
		) &&
		once(	// Identifies Cutscene => waking up in limbo with Philosopher Stone and destroy Homunculus
			is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_PhilosopherStone) &&
			is_PrologueExMode_active() &&	is_Chapter(CHAPTER_Prologue) &&
			is_ExChapter_unlocked() &&
			is_Cutscene_MasterId(0xa7a80)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x394f0)	&&
			is_Cutscene_SectionDataId(0x41b0)	&&
			is_Cutscene_MinorId(0x1413a0,0x8)	&&			
			is_Cutscene_MinorId(0x41b0,0x28)
		) && 
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			is_Chapter(CHAPTER_Prologue) 			&&
			is_Cutscene_MasterId(0x67940)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xd220)	&&
			is_Cutscene_SectionDataId(0x5a6f0)
		) &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_EX))},
	"a_EndingEXCureHelena": function CureHelena() { return
		never(
			!is_InGame() 			||
			is_EventViewer_active()	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_EX)
		) &&
		once(	// Identifies Cutscene => Helena Wagner is cured
			is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_PhilosopherStone) &&
			is_PrologueExMode_active() &&	is_Chapter(CHAPTER_Prologue) &&
			is_ExChapter_unlocked() &&
			is_Cutscene_MasterId(0x58c00)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x268f0)	&&
			is_Cutscene_SectionDataId(0x11bc0)	&&
			is_Cutscene_MinorId(0x721f0,0x8)	&&			
			is_Cutscene_MinorId(0x11bc0,0x28)
		) &&
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			is_Chapter(CHAPTER_Prologue) 			&&
			is_Cutscene_MasterId(0x67940)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xd220)	&&
			is_Cutscene_SectionDataId(0x5a6f0)
		) &&
		once(is_Video_active()) &&	// Credits video
		trigger_when(
			on_Video_end() &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_EX))},
	"a_EnergyOrbLocatorPresentDay": () =>
		// DEV_NOTE: Measure Flag with Pause If - Measure If - Reset If
		// -----------------------------------------
		// 	- When Pause if = true => measurement hit count is frozen, the progress is still viewable on RA overlay
		// 	- When Measure if = false => measurement hit count is set to 0, thus the progress is not viewable on RA overlay, but once Measure if = true => hit count will be set to previous value and start counting from this value
		//		-- Example: current hit count = 21 -> Measure if = false -> Previous hit count is stored and current hit count = 0 -> Measure if = true -> current hit count = 21
		//	- When Reset if = true => measurement will be reset to 0, measurement has to restart counting/hit counts from 0		
				
		//	 Code Below => will only count when effectivly picking up orbs, the other code will count whenever interacting with an orb even if energyUnits is maxed
		//	'''''''''''
		//	(	// Core group	
		//		unless(
		//			is_WearingPerformerOutfit()	||
		//			(
		//				!is_Area(AREA_Present_City_Day) 	 && 
		//				!is_Area(AREA_Present_City_NightPM) &&
		//				!is_Area(AREA_Present_City_NightAM)
		//			) 
		//		) &&
		//		measured(achievements_generate_Tally_PickUpEnergyOrbs(5))
		//	) && (
		//		(	// Alt 1: otherwise pause can lock the reset
		//			never(	// Reset measure when chapter changes or when using digipad
		//				on_EnergyUnits_decrement()	||
		//				on_Chapter_change()			||
		//				!is_InGame()) 
		//		) || ( // Alt 2: always_false to create 1 functional alt group
		//			always_false()
		//		)
		//	),
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Present),
	"a_EnergyOrbLocator70s80s": () =>
		//	 Code Below => will only count when effectivly picking up orbs, the other code will count whenever interacting with an orb even if energyUnits is maxed
		//	'''''''''''
		//	(	// Core group	
		//		unless(
		//			!is_Area(AREA_80s_City_Snow) && 
		//			!is_Area(AREA_70s_City_Night)
		//		) &&
		//		measured(achievements_generate_Tally_PickUpEnergyOrbs(5))
		//	) && (
		//		(	// Alt 1: otherwise pause can lock the reset
		//			never(	// Reset measure when chapter changes or when using digipad
		//				on_EnergyUnits_decrement()	||
		//				on_Chapter_change()			||
		//				!is_InGame()) 
		//		) || ( // Alt 2: always_false to create 1 functional alt group
		//			always_false()
		//		)
		//	),
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Late20thCentury),
	"a_EnergyOrbLocatorMiddleAges": () => 
		//	 Code Below => will only count when effectivly picking up orbs, the other code will count whenever interacting with an orb even if energyUnits is maxed
		//	'''''''''''
		//	(	// Core group	
		//		unless(
		//			!is_Area(AREA_MiddleAges_City_Day) 				&& 
		//			!is_Area(AREA_MiddleAges_City_Night)			&&
		//			!is_Area(AREA_MiddleAges_AlchemistHouse_Exploded_Basement)	&&
		//			!is_Area(AREA_MiddleAges_Church)
		//		) &&
		//		measured(achievements_generate_Tally_PickUpEnergyOrbs(6))
		//	) && (
		//		(	// Alt 1: otherwise pause can lock the reset
		//			never(	// Reset measure when chapter changes or when using digipad
		//				on_EnergyUnits_decrement()	||
		//				on_Chapter_change()			||
		//				!is_InGame()) 
		//		) || ( // Alt 2: always_false to create 1 functional alt group
		//			always_false()
		//		)
		//	),
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_MiddleAges),
	"a_EnergyOrbLocator1900Days": () =>
		//  Code Below => will only count when effectivly picking up orbs, the other code will count whenever interacting with an orb even if energyUnits is maxed
		// '''''''''''
		//	Core group
		//	never(	// Reset when chapter changes or when using digipad
		//		on_EnergyUnits_decrement() 	||
		//		on_Chapter_change()			||
		//		!is_InGame()					||
		//		(is_WearingPerformerOutfit() && is_Area(AREA_Present_City_Day))	// --> Fix for bug, where player could pick up the energy orb in the 
		//	) && (																	// 		Brum Estate twice (once before being performer to get frying pan and once after)
		//		(	// Alt 1: otherwise pause will lock reset 						//		Now it will reset this count, when going back to get frying pan as performer
		//			unless(	
		//				!is_Area(AREA_1900s_City) && !is_Area(AREA_1900s_BrumMansion)
		//			) &&
		//			measured(achievements_generate_Tally_PickUpEnergyOrbs(5))
		//		) || ( // Alt 2: always_false to create 1 functional alt group
		//			always_false()
		//		)
		//	)
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Early20thCentury),
	"a_ShowPocketWatchToPhotographer": function ShowPocketWatchFranssenAncestor() { return
		never (
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		never (
			!is_Chapter(CHAPTER_Chapter6) && 
			!is_Chapter(CHAPTER_Chapter7) &&
			!is_Chapter(CHAPTER_Chapter8_Ancestress) &&
			!is_Chapter(CHAPTER_Chapter8_NoAncestress)
		) &&
		once(	// Identifies Cutscene => Showing Franssen in 1902 the pocket watch
			is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_EggPocketWatch) &&
			is_Cutscene_MasterId(0x114c0)		&& 
			is_Cutscene_SectionId_1(0xffff)	&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x114a0)	&&
			is_Cutscene_SectionDataId(0x114a0)	&&
			is_Cutscene_MinorId(0xad50, 0x8)	&&
			is_Cutscene_MinorId(0x114a0, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		never(
			!is_InGame() 				||
			!is_Chapter(CHAPTER_Chapter4)	||
			is_EventViewer_active()
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using frying pan
				is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_FryingPan) &&
				is_Cutscene_MasterId(0xb0100)		&&
				is_Cutscene_SectionId_1(0xd)		&&
				is_Cutscene_SectionId_2(0xe)		&&
				is_Cutscene_MasterDataId(0x1efb0)	&&
				is_Cutscene_SectionDataId(0xae70)),
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using photo shop sign
				is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Sign) &&
				is_Cutscene_MasterId(0xb0100)		&& 
				is_Cutscene_SectionId_1(0xd)		&&
				is_Cutscene_SectionId_2(0xe)		&&
				is_Cutscene_MasterDataId(0x1eaa0)	&&
				is_Cutscene_SectionDataId(0xae70))
		]) &&
		trigger_when(on_Cutscene_end())},
	"a_MeetOldMiriam": function MeetOldMiriam() { return 
		never(
			!is_InGame() 				||
			!is_Chapter(CHAPTER_Chapter7)	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Holding onto rope 
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0x43040)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x7ce0)	&&
			is_Cutscene_SectionDataId(0xd940)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active() && is_MargaretteTold_Ancestor() && 
				is_Cutscene_MasterId(0xc7940)		&&
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x95c0)	&&
				is_Cutscene_SectionDataId(0x7410)),
			once(	// Identifies Cutscene => No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active() && is_MargaretteTold_NoAncestor() && 
				is_Cutscene_MasterId(0xb2540)		&&
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x95c0)	&&
				is_Cutscene_SectionDataId(0x6cf0))
		]) &&
		trigger_when(on_Cutscene_end())},
	"a_GetOrnamentalEgg": function AcquireOrnamentalEgg() { return
		never (
			!is_InGame() 					||
			!is_Chapter(CHAPTER_Chapter1) 	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Acquiring ornamental egg from performer
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0x19380)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xd5f0)	&&
			is_Cutscene_SectionDataId(0xe10)
		) &&
		trigger_when(is_ItemPresentInInventory(ITEM_OrnamentalEgg) && on_Cutscene_end())},
	"a_GetExChapterOrnamentalEgg": function GetExChapterOrnamentalEgg() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => EX Chapter, performer throws egg
			is_LargeCutscene_active() &&
			is_PrologueExMode_active() &&	is_Chapter(CHAPTER_Prologue) &&
			is_ExChapter_unlocked() &&
			is_Cutscene_MasterId(0x30780)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xd5f0)	&&
			is_Cutscene_SectionDataId(0xe10)	&&
			is_Cutscene_MinorId(0x7fd10,0x8)	&&			
			is_Cutscene_MinorId(0xe10,0x28)
		) &&
		trigger_when(
			is_ItemPresentInInventory(ITEM_OrnamentalEgg) && 
			is_NoCutscene_active())},
	"a_AlertBarmanOfFire": function EggCollection() { return
		never (
			!is_InGame() 					||
			!is_Chapter(CHAPTER_Chapter1) 	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Warning barman of fire 
			is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_OrnamentalEgg) &&
			is_Cutscene_MasterId(0x32200)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x70e0)	&&
			is_Cutscene_SectionDataId(0x24cb0)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_EggCollection": function AlertBarmanOfFire() { return
		never (
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		never (
			!is_Chapter(CHAPTER_Chapter1) && 
			!is_Chapter(CHAPTER_Chapter3) && 
			!is_Chapter(CHAPTER_Chapter4) 
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 1 OR 4
				is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_OrnamentalEgg)	&&
				(is_Chapter(CHAPTER_Chapter1) || is_Chapter(CHAPTER_Chapter4))	&&
				is_Cutscene_MasterId(0x2f9c0)		&& 
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x59c0)	&&
				is_Cutscene_SectionDataId(0x5c20)),
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 3
				is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_OrnamentalEgg) &&
				is_Chapter(CHAPTER_Chapter3)			&&
				is_Cutscene_MasterId(0x32200)		&& 
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x59c0)	&&
				is_Cutscene_SectionDataId(0x5c20))
		])
		 &&
		trigger_when(on_Cutscene_end())},
	"a_RunningAcrossThe90s": function RunningAcrossThe90s() {
		function measuredComparison() { return
			tally(2, [
				once( // Talk to JoggingMan_Present
					is_SmallCutscene_active() &&
					(
						is_Area(AREA_Present_City_Day) 	|| 
						is_Area(AREA_Present_City_NightPM) ||
						is_Area(AREA_Present_City_NightAM)
					) &&
					is_TalkingToNPC(NPC_Present_JoggingMan)),
				once( // Talk to JoggingMan_80s
					is_SmallCutscene_active() &&
					is_Area(AREA_70s_City_Night) &&
					is_TalkingToNPC(NPC_80s_JoggingMan)),
			])}
		return 
			never(	
				!is_InGame() 		||
				!is_Chapter(CHAPTER_Chapter3) && !is_Chapter(CHAPTER_Chapter4) && !is_Chapter(CHAPTER_Chapter5)
			) &&
			measured(measuredComparison()) &&
			trigger_when(on_Cutscene_end())},
	"a_ShowEggTownPlanter": function ShowEggTownPlanter() { return 
		never (
			!is_InGame() 				||
			!is_Chapter(CHAPTER_Chapter2) 	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Show off egg to town planter
			is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_OrnamentalEgg) &&
			is_Cutscene_MasterId(0xde00)		&& 
			is_Cutscene_SectionId_1(0x3)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x29d0)	&&
			is_Cutscene_SectionDataId(0xb400)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_EggPocketWatchForCoffee": function IntroduceEggCollecting2() { return 
		never (
			!is_InGame() 			||
			is_EventViewer_active()	||
			!is_ItemPresentInInventory(ITEM_EggPocketWatch) ||
			!is_Chapter(CHAPTER_Chapter6) && !is_Chapter(CHAPTER_Chapter7) && 
			!is_Chapter(CHAPTER_Chapter8_Ancestress) && !is_Chapter(CHAPTER_Chapter8_NoAncestress)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Instantly pay for the coffee with egg shaped pocket watch
				is_LargeCutscene_active() && is_Area(AREA_1900s_City) && 
				is_Cutscene_MasterId(0x8b440) 		&&
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x3b3a0)	&&
				is_Cutscene_SectionDataId(0x50080)	&&
				is_Cutscene_MinorId(0xdefe0, 0x8)	&&
				is_Cutscene_MinorId(0x50080, 0x28)),
			once(	// Identifies Cutscene => Drank coffee before acquiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
				is_LargeCutscene_active() && is_Area(AREA_1900s_City) && 
				is_Cutscene_MasterId(0xac4c0) 		&&
				is_Cutscene_SectionId_1(0x1)		&&
				is_Cutscene_SectionId_2(0x0)		&&
				is_Cutscene_MasterDataId(0x5ac20)	&&
				is_Cutscene_SectionDataId(0x51870)	&&
				is_Cutscene_MinorId(0x7ec30, 0x8)	&&
				is_Cutscene_MinorId(0x2f730, 0x2c))
		]) &&
		trigger_when(on_Cutscene_end())},
	"a_PocketWatchCollection": function PocketWatch() { return 
		never (
			!is_InGame() 			||
			is_EventViewer_active()	||
			!is_Chapter(CHAPTER_Chapter7)
		) &&
		once(	// Identifies Cutscene => Show off egg pocket watch to barman in present
			is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_EggPocketWatch) &&
			is_Cutscene_MasterId(0x8ce80) 		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x4c600)	&&
			is_Cutscene_SectionDataId(0x236a0)	&&
			is_Cutscene_MinorId(0x70640, 0x8)	&&
			is_Cutscene_MinorId(0x236a0, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_PocketWatchReminiscing": function PocketWatchReminiscing() { return
		never (
			!is_InGame() 					||
			is_EventViewer_active()	||
			!is_Chapter(CHAPTER_Chapter8_Ancestress) && !is_Chapter(CHAPTER_Chapter8_NoAncestress)
		) &&
		once(	// Identifies Cutscene => Eike and Eckart talk about film director and his pocket watches
			is_LargeCutscene_active() && is_ItemPresentInInventory(ITEM_EggPocketWatch) &&
			is_Cutscene_MasterId(0x8dcc0) 		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x31a90)	&&
			is_Cutscene_SectionDataId(0xa420)	&&
			is_Cutscene_MinorId(0xdfbc0, 0x8)	&&
			is_Cutscene_MinorId(0xa420, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_EikeThePyromancer": function EikeThePyromancer() { return
		never (
			!is_InGame() 						||
			!is_Chapter(CHAPTER_Chapter2)	||
			is_EventViewer_active() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into pyromancer statue
			is_TreeReplacedBy_Statue() && is_CrowdScaredWith_Lighter() &&			
			is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Dpad) &&
			is_Cutscene_MasterId(0x3b240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x340e0)	&&
			is_Cutscene_SectionDataId(0x7130)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_EikeTheMagician": function EikeTheMagician() { return
		never (
			!is_InGame() 						||
			!is_Chapter(CHAPTER_Chapter2)	||
			is_EventViewer_active() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into magician statue
			is_TreeReplacedBy_Statue() && is_CrowdScaredWith_Cellphone() &&			
			is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Dpad) &&
			is_Cutscene_MasterId(0x3b240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x340e0)	&&
			is_Cutscene_SectionDataId(0x7130)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_EikeTheFlorist": function EikeTheFlorist() { return 
		never (
			!is_InGame() 						||
			!is_Chapter(CHAPTER_Chapter2)	||
			is_EventViewer_active() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into flowers
			is_TreeReplacedBy_Flowers() &&
			is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Dpad) &&
			is_Cutscene_MasterId(0x3b240)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x340e0)	&&
			is_Cutscene_SectionDataId(0x7130)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_BarmansChildren": function BarmansChildren() { return
		never (
			!is_InGame() 						||
			!is_Chapter(CHAPTER_Chapter5)	||
			is_EventViewer_active() 
		) &&
		once(	// Identifies Cutscene => Talk to barman about grandchildren
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0xd0200)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x3d290)	&&
			is_Cutscene_SectionDataId(0x92f30)
		) &&
		on_CutsceneSection_end()},
	"a_LostYoungCouple1": function LostYoungCouple1() {
		function measuredComparison() { return
			tally(6, [
				once(	// 1st talk with woman
					is_SmallCutscene_active() && // Below line --> When having talked to other half of couple already, this isLostYoungCoupleProgressChap2 would become 0x1 at same time on_NPC_TalkCount_hitsMax() counts
					(is_LostYoungCoupleProgress_Chapter2(0x0) || is_LostYoungCoupleProgress_Chapter2(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) && 
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth") &&	
					is_InteractionChapterId(0x163) && is_InteractionId(0x420)),
				once(	// 1st talk with man
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter2(0x0) || is_LostYoungCoupleProgress_Chapter2(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x40d)),
				once( 	// 2nd talk with woman; is only available when having talked to both at least once
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter2(0x1) || is_LostYoungCoupleProgress_Chapter2(0x2)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x421)),
				once(	// 2nd talk with man; is only available when having talked to both at least once
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter2(0x1) || is_LostYoungCoupleProgress_Chapter2(0x2)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x40e)),
				once(	// 3rd talk with woman
					is_SmallCutscene_active() &&
					is_LostYoungCoupleProgress_Chapter2(0x3) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x422)),
				once(	// 3rd talk with man
					is_SmallCutscene_active() &&
					is_LostYoungCoupleProgress_Chapter2(0x3) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x40f))
			])}
		return 
			never(
				!is_InGame() || 
				!is_Chapter(CHAPTER_Chapter2)
			) &&
			measured(measuredComparison(), is_Area(AREA_MiddleAges_City_Night)) &&
			trigger_when(on_Cutscene_end())},
	"a_LostYoungCouple2": function LostYoungCouple2() {
		function measuredComparison() { return
			tally(6, [
				once(	// 1st talk with woman
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter3(0x0) || is_LostYoungCoupleProgress_Chapter3(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x423)),
				once(	// 1st talk with man
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter3(0x0) || is_LostYoungCoupleProgress_Chapter3(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x410)),
				once(	// 2nd talk with woman; only available when talking to both at least once
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter3(0x1) || is_LostYoungCoupleProgress_Chapter3(0x2)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x424)),
				once(	// 2nd talk with man; only available when talking to both at least once
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter3(0x1) || is_LostYoungCoupleProgress_Chapter3(0x2)) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x411)),
				once(	// 3rd talk with woman
					is_SmallCutscene_active() &&
					is_LostYoungCoupleProgress_Chapter3(0x3) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x425)),
				once(	// 3rd talk with man
					is_SmallCutscene_active() &&
					is_LostYoungCoupleProgress_Chapter3(0x3) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x412))
			])}
		return 
			never(
				!is_InGame() || 
				!is_Chapter(CHAPTER_Chapter3)
			) &&
			measured(measuredComparison(), is_Area(AREA_MiddleAges_City_Night)) &&
			trigger_when(on_Cutscene_end())},
	"a_LostYoungCouple3" : function LostYoungCouple3() {
		function measuredComparison() { return
			tally(6, [
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x0) || is_LostYoungCoupleProgress_Chapter4(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x426)),
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x0) || is_LostYoungCoupleProgress_Chapter4(0x1)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x413)),
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x1) || is_LostYoungCoupleProgress_Chapter4(0x2)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x427)),
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x1) || is_LostYoungCoupleProgress_Chapter4(0x2)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x414)),
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x2) || is_LostYoungCoupleProgress_Chapter4(0x3)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x428)),
				once(
					is_SmallCutscene_active() &&
					(is_LostYoungCoupleProgress_Chapter4(0x2) || is_LostYoungCoupleProgress_Chapter4(0x3)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x415))				
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter4)
			) &&
			measured(measuredComparison(), is_Area(AREA_MiddleAges_City_Night)) &&
			trigger_when(on_Cutscene_end())},
	"a_LostYoungCouple4": function LostYoungCouple4() {
		function measuredComparison() { return
			tally(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap5_NearSouthEastGate"), 
				repeated(1,
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap5_NearSouthEastGate") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x416))
			)}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter5)
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(on_Cutscene_end())},
	"a_LostYoungCouple5": function LostYoungCouple5() {
		function measuredComparison_NoAncestor() { return
			tally(4, [
				repeated(2,	// NoAncestor path has less dialogue => count up 2, when at max talkCount => both measures are using same count (4)
					is_SmallCutscene_active() && 
					is_MargaretteTold_NoAncestor() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare") &&
					is_InteractionChapterId(0x3b) && is_InteractionId(0x429)),
				repeated(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan,"Chap7_OutsideChurch"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap7_OutsideChurch") &&
					is_InteractionChapterId(0x3b) && is_InteractionId(0x418))
			])}
		function measuredComparison_Ancestor() { return
			tally(4, [
				// once(	// 1st talk with woman		// Commented block FIXfor --> NPC_MiddleAges_YoungCoupleWoman-"Chap7_TownSquare" and NPC_MiddleAges_YoungCoupleWoman-"Chap4_OutsideChurch_AfterTalkingToBoth" use same MemAddrTalkCount
				// 	is_SmallCutscene_active() &&
				// 	is_MargaretteTold_Ancestor() &&
				// 	is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
				// 	on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare") &&
				// 	is_InteractionChapterId(0x3b) && is_InteractionId(0x428)),
				repeated(2,	// 2nd talk with woman, with dialogue option		// repeated Fixfor --> mentioned above
					is_SmallCutscene_active() &&
					is_MargaretteTold_Ancestor() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare_Choice") &&
					is_InteractionChapterId(0x3b) && is_InteractionId(0x429)),
				repeated(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan,"Chap7_OutsideChurch"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap7_OutsideChurch") &&
					is_InteractionChapterId(0x3b) && is_InteractionId(0x418))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter7)
			) &&
			(
				measured(measuredComparison_NoAncestor(), is_MargaretteTold_NoAncestor()) || 
				measured(measuredComparison_Ancestor(), is_MargaretteTold_Ancestor())
			) &&
			trigger_when(on_Cutscene_end())},
	"a_LostYoungCouple6": function LostYoungCouple6() {
		function measuredComparison() { return
			tally(2, [
				once(	// 1st talk with man, having a dialogue option
					is_SmallCutscene_active() &&
					is_WomanAdvisedBeTruthful() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap8_OutsideChurch_AfterExperiment_WomanTruthful") &&
					is_InteractionChapterId(0x13) && is_InteractionId(0x41c)),
				once(	// 2nd talk with man after telling him about 'lovers never destines to meet'
						// There's no TalkCount for the dialogue that comes after the dialogue choice => count this one differently
					is_SmallCutscene_active() &&		
					is_WomanAdvisedBeTruthful() &&
					is_ManToldLoversNeverDestinedMeet() &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan) &&					
					is_InteractionChapterId(0x13) && is_InteractionId(0x433))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter8)
			) &&
			measured(measuredComparison(), is_Area(AREA_MiddleAges_City_Day)) &&
			trigger_when(on_Cutscene_end())},
	"a_EnigmaticCouple1": function EnigmaticCouple1() {
		function measuredComparison() { return
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap1Prologue_TownSquare"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare") &&
					is_InteractionId(0x2cc)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap1Prologue_NearBar"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap1Prologue_NearBar") &&
					is_InteractionId(0x2c1))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Prologue) && !is_Chapter(CHAPTER_Chapter1)
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(on_Cutscene_end())},
	"a_EnigmaticCouple2": function EnigmaticCouple2() {
		function measuredComparison_onIncrease() { return	// Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					is_InteractionId(0x2d0)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop") &&
					is_InteractionId(0x2c4))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					is_InteractionId(0x2d0)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop") &&
					is_InteractionId(0x2c4))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter3)
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(on_Cutscene_end())},
	"a_EnigmaticCouple3": function EnigmaticCouple3() {
		function measuredComparison_onIncrease() { return // Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					is_InteractionId(0x2d0)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch") &&
					is_InteractionId(0x2c5))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					is_InteractionId(0x2d0)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch") &&
					is_InteractionId(0x2c5))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter4)
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(on_Cutscene_end())},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		function measuredComparison_BrumLibrary_onIncrease() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2d5)),
				repeated(2, // --> overwrite of '''get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumLibrary")''', both measures must have same count
					is_SmallCutscene_active() && is_BrumEstate_Library() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumLibrary") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2c9))
			])}
		function measuredComparison_BrumLibrary_onMax() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2d5)),
				repeated(2, // --> overwrite of 'get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumLibrary")', all measures must have same count
					is_SmallCutscene_active() && is_BrumEstate_Library() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumLibrary") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2c9))
			])}
		function measuredComparison_BrumMuseum_onIncrease() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2d5)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumMuseum"), 
					is_SmallCutscene_active() && is_BrumEstate_Museum() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumMuseum") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2ca))
			])}
		function measuredComparison_BrumMuseum_onMax() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2d5)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumMuseum"), 
					is_SmallCutscene_active() && is_BrumEstate_Museum() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumMuseum") &&
					is_InteractionChapterId(0x4b) && is_InteractionId(0x2ca))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter5)
			) &&
			trigger_when(on_Cutscene_end()) &&
			(measured(measuredComparison_BrumMuseum_onIncrease()) || measured(measuredComparison_BrumMuseum_onMax()) ||
			measured(measuredComparison_BrumLibrary_onIncrease()) || measured(measuredComparison_BrumLibrary_onMax()))},
	"a_EnigmaticCouple5": function EnigmaticCouple5() {
		function measuredComparison_onIncrease() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap7_SouthGate") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2d3)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap7_NorthWestGate") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2c8))
			])}
		function measuredComparison_onMax() { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedWoman) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap7_SouthGate") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2d3)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_CoatedMan) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap7_NorthWestGate") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2c8))
			])}
		return 
			never(	
				!is_InGame() ||
				!is_Chapter(CHAPTER_Chapter7)
			) &&
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(on_Cutscene_end())},
	"a_BecomeThePerformer": function BecomeThePerformer() {	return
		never(
			!is_InGame()				||
			is_EventViewer_active() 	||
			on_Cutscene_MasterId_change()
		) &&
		once(	// Identifies Cutscene => Eike gives himself a message as performer
			is_LargeCutscene_active() && is_Chapter(CHAPTER_Chapter4) &&
			is_SelectedItemInScrollBar(ITEM_Jugglery) &&
			is_WearingPerformerOutfit()			&&
			is_Cutscene_MasterId(0x1a300)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xd440)	&&
			is_Cutscene_SectionDataId(0x3a00)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_GiveMargaretteCake": function GiveMargaretteCake() { return 
		never(
			!is_InGame()				||
			is_EventViewer_active() 	||
			!is_SelectedItemInScrollBar(ITEM_Cake)	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 1st time
			is_LargeCutscene_active() 			&& 
			is_Cutscene_MasterId(0x10b000)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0xadb40)	&&
			is_Cutscene_SectionDataId(0x5d4a0)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_PerformerGoingExtraMile": function PerformerGoingExtraMile(){
		function measuredComparison() { return
			tally(7, [
				once(
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BlondeYoungBoy) &&
					is_Area(AREA_Present_City_Day) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeYoungBoy, "Chap4_WearingPerformerOutfit") &&
					is_InteractionChapterId(0x44) && is_InteractionId(0x39c)),	// IDs last dialogue sequence on this NPC's appearance
				once(
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BrunetteMother) &&
					is_Area(AREA_Present_City_Day) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteMother, "Chap4_WearingPerformerOutfit") &&
					is_InteractionChapterId(0x44) && is_InteractionId(0x336)),
				once(
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BrunetteYoungGirl) &&
					is_Area(AREA_Present_City_Day) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteYoungGirl, "Chap4_WearingPerformerOutfit") &&
					is_InteractionChapterId(0x44) && is_InteractionId(0x323)),
				once(
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BlondeOldWomanOrangeSweater) &&
					is_Area(AREA_Present_City_Day) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeOldWomanOrangeSweater, "Chap4_WearingPerformerOutfit") &&
					is_InteractionChapterId(0x44) && is_InteractionId(0x32c)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BrunetteAdultManGlasses) &&
					is_Area(AREA_Present_TownHall) &&
					is_InteractionChapterId(0x29) && is_InteractionId(0x3c6)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active() &&
					is_TalkingToNPC(NPC_Present_BlondeElderlyWoman) &&
					is_Area(AREA_Present_TownHall) &&
					is_InteractionChapterId(0x29) && is_InteractionId(0x3cc)),
				once(	// This counts Eike, giving egg to Eike/yourself
					is_LargeCutscene_active() &&
					is_SelectedItemInScrollBar(ITEM_Jugglery) &&
					is_Cutscene_MasterId(0x1a300)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0xd440)	&&
					is_Cutscene_SectionDataId(0x3a00))
			])}
		return 
			never(	
				!is_InGame() 					||
				!is_Chapter(CHAPTER_Chapter4)	||
				repeated(300, !is_WearingPerformerOutfit())		// ---> Repeat is necessary, because bit flag for is_WearingPerformerOutfit() 
			) &&												// 		changes to 0 for a few frames when loading into townhall/city 
			measured(measuredComparison(), always_true()) &&	// 		=> we don't want to reset measure count here 
			trigger_when(on_Cutscene_end() || on_CutsceneSection_end())}, // Can only trigger after the cutscene when giving egg to past Eike
	"a_ScareEveryone": function ScareEveryone() {
		function measuredComparison() { return
			tally(9, [
				once(	// Identifies cutscene => scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
					is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Cellphone) &&
					is_Cutscene_MasterId(0x9000)		&&
					is_Cutscene_SectionId_1(0xffff)	&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x9000)	&&
					is_Cutscene_SectionDataId(0x9000)	&&
					is_Cutscene_MinorId(0x5f80, 0x8)	&&
					is_Cutscene_MinorId(0x9000, 0x28)),
				repeated(4,	// Identifies cutscene => scaring crowd with cellphone; Add counts +4, instead of below cutscene
					is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Cellphone) &&
					is_Cutscene_MasterId(0xc6e00)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x5ad0)	&&
					is_Cutscene_SectionDataId(0x55b0)	&&
					is_Cutscene_MinorId(0x2451a0, 0x8)	&&
					is_Cutscene_MinorId(0x55b0, 0x28)),
				repeated(4,	// Identifies cutscene => scaring crowd with lighter; Add counts +4, instead of above cutscene
					is_LargeCutscene_active() && is_SelectedItemInScrollBar(ITEM_Lighter) &&
					is_Cutscene_MasterId(0xa84c0)		&&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x2e40)	&&
					is_Cutscene_SectionDataId(0xb220)	&&
					is_Cutscene_MinorId(0x2354f0, 0x8)	&&
					is_Cutscene_MinorId(0xb220, 0x28)),
				once(	// Identifies cutscene => scaring town planter
					is_LargeCutscene_active() && 
					(is_SelectedItemInScrollBar(ITEM_Lighter) || is_SelectedItemInScrollBar(ITEM_Cellphone)) &&
					is_Cutscene_MasterId(0x98c0)		&&
					is_Cutscene_SectionId_1(0xffff)	&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x9890)	&&
					is_Cutscene_SectionDataId(0x9890)	&&
					is_Cutscene_MinorId(0xcd30, 0x8)	&&
					is_Cutscene_MinorId(0x9890, 0x28)),
				once(	// Identifies cutscene => scaring eccentric girl
					is_SmallCutscene_active() &&
					(is_SelectedItemInScrollBar(ITEM_Lighter) || is_SelectedItemInScrollBar(ITEM_Cellphone)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_EccentricGirl, "Chap2_TownSquare_Scare") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x314)),				
				once(	// Identifies cutscene => scaring straw hat man
					is_SmallCutscene_active() &&
					(is_SelectedItemInScrollBar(ITEM_Lighter) || is_SelectedItemInScrollBar(ITEM_Cellphone)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_StrawHatMan, "Chap2_Streets_Scare") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x2da)),
				once(	// Identifies cutscene => scaring aspiring apprentice
					is_SmallCutscene_active() &&
					(is_SelectedItemInScrollBar(ITEM_Lighter) || is_SelectedItemInScrollBar(ITEM_Cellphone)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_AspiringApprentice, "Chap2_SouthEastGate_Scare") &&
					is_InteractionChapterId(0x163) && is_InteractionId(0x2e3))
			])}
		return 
			never(	
				!is_InGame() 	||
				!is_Chapter(CHAPTER_Chapter2)
			) &&
			(
				(	// Alt => vs. pause lock
					unless(
						!is_Area(AREA_MiddleAges_City_Night) && !is_Area(AREA_Present_CafeSonne)			
					) &&
					measured(measuredComparison(), is_InGame() && is_Chapter(CHAPTER_Chapter2)) &&
					trigger_when(on_Cutscene_end())
				) || (
					always_false()
				)
			)},
	"a_FreeMeal": function FreeMeal() { return
		never(
			!is_InGame()						||
			is_EventViewer_active() 			||
			!is_Chapter(CHAPTER_Chapter5)	||
			is_FirePutOutBy_Eike()
		) &&
		once(	// Identifies Cutscene => Barman gives us free meal
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0x62840)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x261a0)	&&
			is_Cutscene_SectionDataId(0x6cc0)	&&
			is_Cutscene_MinorId(0x9bd60, 0x8)	&&
			is_Cutscene_MinorId(0x6cc0, 0x28)
		) &&
		once(	// Identifies Cutscene => Reading book whilst barman get Eike his meal + poison
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0xf9cc0)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x5eb0)	&&
			is_Cutscene_SectionDataId(0xf3df0)	&&
			is_Cutscene_MinorId(0x2aea60, 0x8)	&&
			is_Cutscene_MinorId(0xf3df0, 0x28)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_NewCakeInvented": function NewCakeInvented() { return
		never(
			!is_InGame()					||
			is_EventViewer_active() 	||
			!is_SelectedItemInScrollBar(ITEM_Cake)	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 2nd time
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0x1fd80)		&&
			is_Cutscene_SectionId_1(0xffff)	&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x1fd50)	&&
			is_Cutscene_SectionDataId(0x1fd50)	&&
			is_Cutscene_MinorId(0x153d0, 0x8)	&&
			is_Cutscene_MinorId(0x122b0, 0x2c)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_MaxInventory": function MaxInventory(){
		let_biggestPossibleInventoryCount = 20
		function previousItemCount() =>
			sum_of(const_Items_data, (item) {	// sum_of(prevItemCount) == 19
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"]
				return prev(bit0(let_memAddress))
			})
		function currentItemCount() => 
			sum_of(const_Items_data, (item) {	// sum_of(currentItemCount) == 20
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"]
				return bit0(let_memAddress)
			})
		function measuredComparison(int_tallyCount) =>
			// Checks all item_in_inventory_flags => if in inventory => +1 Add hit
			tally_of(const_Items_data, int_tallyCount, (item) {
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"]
				return once(bit0(let_memAddress) == 1)
			})
		return 
			never(	
				is_TitleMenu_active()	||
				is_EventViewer_active()	||

				// Reset hit counts if any item is removed
				any_of(const_Items_data, (item) {
					let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"]
					return bit0(let_memAddress) < prev(bit0(let_memAddress))
				})
			) &&
			measured(measuredComparison(let_biggestPossibleInventoryCount), always_true()) &&			
			once(
				previousItemCount() < let_biggestPossibleInventoryCount &&
				currentItemCount() == let_biggestPossibleInventoryCount
			) &&
			trigger_when(on_Cutscene_end())
		},		
	"a_DrunkenGuys": function DrunkenGuys(){
		function measuredComparison() { return
			tally(2, [
				once(	// Identifies Cutscene => talking to slim delinquent
					is_SmallCutscene_active() && 
					is_TalkingToNPC(NPC_Present_SlimDelinquent) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_SlimDelinquent, "Chap7_CarPark") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2f5)),
				once(	// Identifies Cutscene => talking to broad delinquent
					is_SmallCutscene_active() && 
					is_TalkingToNPC(NPC_Present_BroadDelinquent) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_BroadDelinquent, "Chap7_CarPark") &&
					is_InteractionChapterId(0xb2) && is_InteractionId(0x2f0))
			])}
		return 
			never(
				!is_Area(AREA_Present_City_NightPM)
			) &&
			measured(measuredComparison(), is_InGame()) &&
			trigger_when(on_Cutscene_end())},
	"a_ShortestChapter": function ShortestChapter(){ return
		never(
			!is_InGame()						||
			!is_Chapter(CHAPTER_Chapter4)	||
			is_EventViewer_active()				||
			!is_SelectedItemInScrollBar(ITEM_FryingPan) ||
			
			// If preventing 1st death in chapter 4 by using the frying pan 
			//	=> black and white picture is not found inside book during this chapter
			//	=> Thus can be used as a flag for this achievement
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_NoPerformer) 	|| 
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_WithPerformer)			 
		) &&
		once(	// Identifies Cutscene => Using frying pan for defence
			is_LargeCutscene_active() && 
			is_Cutscene_MasterId(0x4f200)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x11cd0)	&&
			is_Cutscene_SectionDataId(0x3d500)	
		) &&
		trigger_when(on_Cutscene_end())},
	"a_MeetFamousOleg": function MeetFamousOleg(){ return
		never(
			!is_InGame()				||
			is_EventViewer_active() 	||
			!is_Chapter(CHAPTER_Chapter7)
		) &&
		once(	// Identifies Cutscene => Talking to Oleg near movie poster
			is_LargeCutscene_active() && is_CoffeePayed() &&
			is_Cutscene_MasterId(0xa0f40)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x45370)	&&
			is_Cutscene_SectionDataId(0x5bb90)	&&
			is_Cutscene_MinorId(0x8f8e0, 0x8)	&&
			is_Cutscene_MinorId(0x5bb90, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_ArtInspiration1": function ArtInspiration1() { return
		never(
			!is_InGame() 		||
			on_Chapter_change() ||
			is_BrumEstate_Library()
		) && 
		tally(1, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
			once(
				is_SmallCutscene_active() && 
				is_Painting_TowerView_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_TowerView) && 
				(is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night) || is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day)) &&
				is_InteractionId(0x124)),			
			once(
				is_SmallCutscene_active() && 	
				is_Painting_SquireCrest_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_SquireCrest) && 
				(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
				is_InteractionId(0x125)),
			once(
				is_SmallCutscene_active() &&
				is_Painting_Marktplatz_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_TownSquare) && 
				(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
				is_InteractionId(0x126)),
			once(
				is_SmallCutscene_active() &&
				is_Painting_Antidote_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_AlchemyLab) && 
				(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
				is_InteractionId(0x127)),
			once(
				is_SmallCutscene_active() &&
				is_Painting_Performer_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_Performer) && 
				(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
				is_InteractionId(0x128)),
			once(
				is_SmallCutscene_active() &&
				is_Painting_HouseCollapse_inspired() &&
				is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse) && 
				(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
				is_InteractionId(0x129))
		]) &&
		trigger_when(on_Cutscene_end())},	// Trigger when cutscene is over
	"a_ArtInspirationAll": function ArtInspirationAll() {
		function measuredComparison() {
			tally(6, [
				once(
					is_SmallCutscene_active() && 
					is_Painting_TowerView_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_TowerView) && 
					(is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night) || is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day)) &&
					is_InteractionId(0x124)),
				once(
					is_SmallCutscene_active() && 	
					is_Painting_SquireCrest_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
					is_InteractionId(0x125)),
				once(
					is_SmallCutscene_active() &&
					is_Painting_Marktplatz_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
					is_InteractionId(0x126)),
				once(
					is_SmallCutscene_active() &&
					is_Painting_Antidote_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x127)),
				once(
					is_SmallCutscene_active() &&
					is_Painting_Performer_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_Performer) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x128)),
				once(
					is_SmallCutscene_active() &&
					is_Painting_HouseCollapse_inspired() &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x129))
			])}
		return
			never(
				!is_InGame() ||
				on_Chapter_change()
			) &&
			trigger_when(on_Cutscene_end()) &&
			measured(measuredComparison(), always_true())},
	"a_ArtAppreciator": function ArtAppreciator() {
		function measuredComparison() {
			tally(8, [
				once(
					is_SmallCutscene_active() && 	
					is_InteractingWith(INTERACTABLE_Painting_TowerView) && 
					(is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night) || is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day)) &&
					is_InteractionId(0x124)),
				once(
					is_SmallCutscene_active() && 	
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
					is_InteractionId(0x125)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day)) &&
					is_InteractionId(0x126)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x127)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_Performer) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x128)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day)) &&	
					is_InteractionId(0x129)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_LandscapeTown) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day)) &&	
					is_InteractionId(0xffffffff)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Painting_Alchemist) && 
					(is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night) || is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day)) &&	
					is_InteractionId(0xffffffff))
			])}
		return
			never(
				!is_InGame() ||
				on_Chapter_change()
			) &&
			trigger_when(on_Cutscene_end()) &&
			measured(measuredComparison(), always_true())},
	"a_AntiquesEule": function AntiquesEule() {
		function measuredComparison() {
			tally(4, [
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Antique_FranssenShopSign) && 
					is_InteractionId(0xffffffff)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Antique_Rope) &&
					is_InteractionId(0xffffffff)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Antique_Antidote) &&
					is_InteractionId(0xffffffff)),
				once(
					is_SmallCutscene_active() &&
					is_InteractingWith(INTERACTABLE_Antique_Mask) &&
					is_InteractionId(0xffffffff))
			])}
		function measuredIfComparison() { return
			is_Area(AREA_80s_AntiquesEule) ||
			is_Area(AREA_Present_AntiquesEule)}
		return
			never(
				!is_InGame() ||
				on_Chapter_change()
			) &&
			trigger_when(on_Cutscene_end()) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_SeenOlegAsWell": function SeenOlegAsWell() { return 
		never(
			!is_InGame()				||
			is_EventViewer_active() 	||
			!is_Chapter(CHAPTER_Chapter6) 
		) &&
		once(	// Identifies Cutscene => Talking with man inside Cafe Sonne for 1st time, only in chapter 6
			is_SmallCutscene_active() && is_Area(AREA_80s_CafeSonne) &&
			is_TalkingToNPC(NPC_80s_OlderMan) && 
			is_InteractionChapterId(0xb2) && is_InteractionId(0x3e7) && 
			has_startedTalkingToNPC_forFirstTime(NPC_80s_OlderMan, "Chap6_CafeSonne")
		) &&
		trigger_when(on_Cutscene_end())},
	"a_PocketWatchTo80sBarman": function PocketWatchTo80sBarman() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Using pocket watch or ornamental egg near barman in 1980s
			is_SmallCutscene_active() && is_Area(AREA_80s_Bar) &&
			(
				is_SelectedItemInScrollBar(ITEM_EggPocketWatch) ||
				is_SelectedItemInScrollBar(ITEM_OrnamentalEgg)
			) &&
			is_TalkingToNPC(NPC_80s_Barman) && is_InteractionId(0x2ed) &&
			is_NPCtalkCount_atMax(NPC_80s_Barman, "InsideBar_UsePocketWatchOrEgg")
		) &&
		trigger_when(on_Cutscene_end())},
	"a_SnowyCrimeScene": function SnowyCrimeScene() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Miriam shot and dying 
			is_LargeCutscene_active() && is_Area(AREA_80s_City_Snow) &&
			is_Chapter(CHAPTER_Chapter6) 	&&
			is_Cutscene_MasterId(0x756c0)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x4660)	&&
			is_Cutscene_SectionDataId(0x4f210) 	&&
			is_Cutscene_MinorId(0xb8b90, 0x8)	&&
			is_Cutscene_MinorId(0x4f210, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
	"a_SaveMiriamBrum": function SaveMiriamBrum() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()			 
		) &&
		once(	// Identifies Cutscene => Eike save Miriam, after running after her
			is_LargeCutscene_active() && is_Area(AREA_80s_City_Snow) &&
			is_Chapter(CHAPTER_Chapter6)	&&
			is_Cutscene_MasterId(0xebac0)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x546f0)	&&
			is_Cutscene_SectionDataId(0x50b0)	
		) &&
		trigger_when(on_Cutscene_end())},
	"a_HugoMotherChild": function HugoMotherChild() { return
		never(
			!is_InGame()						||
			!is_Chapter(CHAPTER_Chapter5)	||
			is_EventViewer_active() 
		) &&
		once(	// Identifies Cutscene => Hugo gets bullied
			is_LargeCutscene_active() &&
			is_Cutscene_MasterId(0x3ed00)		&&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x3110)	&&
			is_Cutscene_SectionDataId(0x3bbc0)	&&
			is_Cutscene_MinorId(0x282ae0, 0x8)	&&
			is_Cutscene_MinorId(0x3bbc0, 0x28)
		) &&
		trigger_when(on_Cutscene_end())},
 	"a_TimeTravellingCat": function TimeTravellingCat() { return
		never(
			!is_InGame() ||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Giving kitten to Sibylla
			is_LargeCutscene_active() && is_Area(AREA_1900s_BrumMansion) &&
			is_ItemPresentInInventory(ITEM_Kitten) &&
			is_Cutscene_MasterId(0x25200)		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x2c00)	&&
			is_Cutscene_SectionDataId(0x10930)
		) &&
		is_KittenGivenToSibylla() &&
		trigger_when(on_Cutscene_end())},
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!is_InGame()						||
			!is_Chapter(CHAPTER_Prologue)	||
			is_EventViewer_active()  
		) &&
		(
			(
				unless(
					!is_LargeCutscene_active()
				) &&
				once(	// Identifies Cutscene => Eike wakes himself up					
					is_Cutscene_MasterId(0x9c00)		&&
					is_Cutscene_MasterDataId(0x9bf0)	&&
					is_Cutscene_SectionDataId(0x9bf0)	&&
					is_Cutscene_MinorId(0x9bf0, 0x28) 	&&
					is_Cutscene_MinorId(0xea70, 0x8) 	
				) && 
				once(	// Identifies Cutscene => Eike wakes himself up
					is_Cutscene_MasterId(0x237c0)		&& was_Cutscene_MasterId(0x9c00) &&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0x18930)	&&
					is_Cutscene_SectionDataId(0xae60)
				) && 
				trigger_when(on_CutsceneSection_end())
			) || (
				always_false()
			)
		)},
	"a_ErasingEike2": function ErasingEike2() { return
		never(
			!is_InGame()				||
			!is_Chapter(CHAPTER_Chapter7)	||
			is_EventViewer_active()  
		) &&
		once(	// Identifies Cutscene => Eike bumps into himself
			is_Cutscene_MinorId(0x23ee0, 0x8) 	&&
			is_Cutscene_MinorId(0x377e0, 0x28) 	&&
			is_Cutscene_MinorId(0x23eb0, 0x2c)
		) && 
		trigger_when(on_Cutscene_end())},
	"a_RottenRope": function RottenRope() { return
		never (
			!is_InGame() 				||
			!is_Chapter(CHAPTER_Chapter7) 	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Holding on to rotten rope
			is_LargeCutscene_active()	&&
			is_Cutscene_MasterId(0x15640) 		&&
			is_Cutscene_SectionId_1(0x5)		&&
			is_Cutscene_SectionId_2(0x6)		&&
			is_Cutscene_MasterDataId(0x7830)	&&
			is_Cutscene_SectionDataId(0x2220)
		) &&
		once(	// Identifies Cutscene => Waking up in Limbo after death
			is_LargeCutscene_active()	&&
			is_Cutscene_MasterId(0x237c0) 		&& was_Cutscene_MasterId(0x15640) &&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x18930)	&&
			is_Cutscene_SectionDataId(0xae60)
		) &&
		trigger_when(on_CutsceneSection_end())},
	"a_TimeEgoFlop": function TimeEgoFlop() { return
		never(
			!is_InGame() 				||
			is_EventViewer_active() 	|| 
			!is_Chapter(CHAPTER_Chapter6)
		) &&
		once( // Identifies Cutscene => Roadkilled by Time Ego movie
				is_LargeCutscene_active() 			&& 
				is_MovieTimeTravel_chosen()			&&
				is_MovieWorldConquest_chosen() 		&&				
				is_Cutscene_MasterId(0x77980)		&&
				is_Cutscene_SectionId_1(0xa)		&&
				is_Cutscene_SectionId_2(0xb)		&&
				is_Cutscene_MasterDataId(0x2090)	&&
				is_Cutscene_SectionDataId(0x15d50)
			) && 
			trigger_when(on_CutsceneSection_end())},
	"a_MetYouBefore": function MetYouBefore() { return
		never(
			!is_InGame()						||
			!is_Chapter(CHAPTER_Chapter2) 	||
			is_EventViewer_active()
		) &&
		once(	// Identifies Cutscene => Talk Dana, seeing through clothing hunch
			is_LargeCutscene_active()			&&	
			is_Cutscene_MasterId(0x6e480) 		&& 
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x2)		&&
			is_Cutscene_MasterDataId(0x45250)	&&
			is_Cutscene_SectionDataId(0x143f0)	
		) && 
		once(	// Identifies Cutscene => Getting stabbed from behind
			is_LargeCutscene_active()			&&	
			is_Cutscene_MasterId(0x1b740) 		&& was_Cutscene_MasterId(0x6e480) &&
			is_Cutscene_SectionId_1(0x1)		&&
			is_Cutscene_SectionId_2(0x0)		&&
			is_Cutscene_MasterDataId(0x1d00)	&&
			is_Cutscene_SectionDataId(0x19a20)	
		) && 
		trigger_when(on_CutsceneSection_end())},
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return
		never(
			!is_InGame()			||
			is_EventViewer_active()	||
			!is_Chapter(CHAPTER_Chapter3)
		) &&
		(
			(
				unless(
					!is_LargeCutscene_active()
				) &&
				once(	// Identifies Cutscene => Picking dialogue option with Homunculus: 'excuse me'					
					is_Cutscene_MasterId(0xb140) && was_Cutscene_MasterId(0x5aa80) &&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x2)		&&
					is_Cutscene_MasterDataId(0x5ac0)	&&
					is_Cutscene_SectionDataId(0x38b0)	
				) && 
				once(	// Identifies Cutscene => Waking up in limbo after dying to vase
					is_Cutscene_MasterId(0x1a440) && was_Cutscene_MasterId(0xb140) &&
					is_Cutscene_SectionId_1(0x1)		&&
					is_Cutscene_SectionId_2(0x0)		&&
					is_Cutscene_MasterDataId(0xd9a0)	&&
					is_Cutscene_SectionDataId(0xca50)	
				) &&
				trigger_when(on_CutsceneSection_end())
			) || (
				always_false()
			)
		)}
	}

// ********************
// • Achievement TEXT •
// ********************
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_PrologueComplete": 							{"en": "Defied Fate",															
													"nl": "Lot getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1Complete": 							{"en": "Defied Fate... Again",
													"nl": "Lot getrotseerd... nogmaals",
													"fr": "Défié le destin... encore"},
	"a_Chapter2Complete": 							{"en": "Left In The Past"},
	"a_Chapter3Complete": 							{"en": "An Alchemist, A Jewel And A Homunculus"},
	"a_Chapter4CompletePan": 						{"en": "Pan-tastic Resilience"},
	"a_Chapter4CompleteSign": 						{"en": "Through The Lens Of Survival"},	
	"a_Chapter5Complete": 							{"en": "Ancient Elixir"}, 
	"a_Chapter6CompleteThriller":					{"en": "Director's Cut: The Time Of Reckoning"},
	"a_Chapter6CompleteLove":						{"en": "Director's Cut: Trip For Two"},
	"a_Chapter7Complete":							{"en": "A Friend's Repentance"},
	"a_Chapter8Complete":							{"en": "The Whole Picture... Or Is It?"},
	"a_EndingEXKillHomunculus":						{"en": "The Philosopher's Destiny"},
	"a_EndingEXCureHelena":							{"en": "The Philosopher's Legacy"},
	"a_MaxAchievementPrologue":						{"en": "Homing Instinct"},	
	"a_MaxAchievementChapter1":						{"en": "In The Heat Of Time"},	
	"a_MaxAchievementChapter2":						{"en": "Dana Kusch"},		
	"a_MaxAchievementChapter3":						{"en": "The Root Of The Problem"},	
	"a_MaxAchievementChapter4":						{"en": "The Monochrome Era"},	
	"a_MaxAchievementChapter5":						{"en": "Meddling With Destiny"},
	"a_MaxAchievementChapter6":						{"en": "The Good Samaritan"},
	"a_MaxAchievementChapter7":						{"en": "Vintage Knots"},
	"a_MaxAchievementChapter8":						{"en": "The Power Of Fate"},
	"a_MaxAchievementEpilogue":						{"en": "Eternal Youth"},
	"a_MaxAchievementTotal":						{"en": "The Day Of Walpurgis"},
	"a_EndingA":									{"en": "An End To A Strange Experience"},
	"a_EndingB1":									{"en": "No Sense Of Finality I"},
	"a_EndingB2":									{"en": "No Sense Of Finality II"},
	"a_EndingC": 									{"en": "If Only... I Had One More Attempt"},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "The Future Is What We Make It"},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "The Philosopher's Wisdom"},
	"a_DoctorateTimeTraveling": 					{"en": "Complexities Of The Fourth Dimension"}, 
	"a_GetOrnamentalEgg": 							{"en": "A Performer's Clue"}, 
	"a_EggCollection": 								{"en": "A Jovial Exchange"},
	"a_AlertBarmanOfFire": 							{"en": "There's A Fire!"}, 
	"a_BarmansChildren":							{"en": "The Barman's Mystery Child"},
	"a_ShowEggTownPlanter": 						{"en": "Cracking Open The Past: Middle Ages"},
	"a_EggPocketWatchForCoffee": 					{"en": "Cracking Open The Past: The Old Century"},
	"a_PocketWatchCollection": 						{"en": "A Hatchless Replica"},
	"a_PocketWatchReminiscing": 					{"en": "The Eggcellent Director's Tale"},
	"a_EikeThePyromancer":							{"en": "The Pyromancer's Legacy"},
	"a_EikeTheMagician": 							{"en": "The Magician's Legacy"},
	"a_EikeTheFlorist": 							{"en": "A Blossoming Plan"},
	"a_LostYoungCouple1": 							{"en": "Yesteryears Couple I: Destined To Miss"},
	"a_LostYoungCouple2": 							{"en": "Yesteryears Couple II: The Place Where We Nigh Met"},
	"a_LostYoungCouple3": 							{"en": "Yesteryears Couple III: Destiny's Promise Fulfilled"},
	"a_LostYoungCouple4": 							{"en": "Yesteryears Couple IV: Man-in-waiting"},
	"a_LostYoungCouple5": 							{"en": "Yesteryears Couple V: Parting"},
	"a_LostYoungCouple6": 							{"en": "Yesteryears Couple VI: Never Destined To Meet"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic Couple I: Prelude"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic Couple II: Tailing"},
	"a_EnigmaticCouple3": 							{"en": "Enigmatic Couple III: Wandering Once More"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic Couple IV: Origins"},
	"a_EnigmaticCouple5": 							{"en": "Enigmatic Couple V: Epilogue"},
	"a_ErasingEike": 								{"en": "That's A Big No No"}, 
	"a_ErasingEike2": 								{"en": "Bump... Erased"},
	"a_RottenRope": 								{"en": "Fated To Plunge"},
	"a_MetYouBefore": 								{"en": "Met You Before"},
	"a_DrunkenGuys":								{"en": "A Pair Of Delinquents"},
	"a_ShowPocketWatchToPhotographer":				{"en": "Horologic Heritage"},
	"a_TimeTravellingCat":							{"en": "Nine Lives Across Generations"},
	"a_SnowyCrimeScene":							{"en": "Picked Up A Baby The Other Day"},
	"a_SaveMiriamBrum":								{"en": "Illusive Guardian Of The Brums"},
	"a_HugoMotherChild":							{"en": "A Mother's Child"}, 
	"a_SeenOlegAsWell": 							{"en": "The Meditating Man"}, 
	"a_PocketWatchTo80sBarman": 					{"en": "That's Nice!"},
	"a_FreeMeal":									{"en": "A Complimentary Dinner"}, 
	"a_TimeEgoFlop":								{"en": "Time Ego Flop"},
	"a_ArtAppreciator": 							{"en": "Strokes Of Destiny"}, 
	"a_AntiquesEule": 								{"en": "Timeless Antiques"},
	"a_RunningAcrossThe90s":						{"en": "Running Beyond The 90's... And 80's"},
	"a_ExcuseMeMyMy":								{"en": "My My, So Eager To Die"},
	"a_BecomeThePerformer":							{"en": "Even I Can Do That"}, 
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Energy Locator: Present Day"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Energy Locator: Middle Ages"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Energy Locator: The Late 20th Century"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Locator: The Early 20th Century"},
	"a_GiveMargaretteCake": 						{"en": "Time-Spun Sweets"}, 
	"a_ShortestChapter": 							{"en": "Pan In Advance"}, 
	"a_NewCakeInvented": 							{"en": "Legacy Of Sweetness"},
	"a_MaxInventory": 								{"en": "Stockpiling Across Eras"},
	"a_PerformerGoingExtraMile": 					{"en": "A Performance Gone The Extra Mile"}, 
	"a_ArtInspiration1": 							{"en": "Art Muse"}, 
	"a_ArtInspirationAll": 							{"en": "Eike Franssen"},
	"a_MeetFamousOleg":								{"en": "The Next Big Thing"},
	"a_ScareEveryone": 								{"en": "Terror Of Destinies"}}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_PrologueComplete": {							"en": "Complete the Prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Complete Chapter 1",
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},													
	"a_Chapter2Complete": 							{"en": "Complete Chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete Chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete Chapter 4, using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete Chapter 4, using a sign"},	
	"a_Chapter5Complete": 							{"en": "Complete Chapter 5"}, 
	"a_Chapter6CompleteThriller":					{"en": "Complete Chapter 6, by co-directing a thriller picture"},
	"a_Chapter6CompleteLove":						{"en": "Complete Chapter 6, by co-directing a love picture"},
	"a_Chapter7Complete":							{"en": "Complete Chapter 7"},
	"a_Chapter8Complete":							{"en": "Complete Chapter 8"},
	"a_MaxAchievementPrologue":						{"en": "Reach 100% achievement rate for the Prologue, including the EX Chapter"},
	"a_MaxAchievementChapter1":						{"en": "Reach 100% achievement rate for Chapter 1"},
	"a_MaxAchievementChapter2":						{"en": "Reach 100% achievement rate for Chapter 2"},
	"a_MaxAchievementChapter3":						{"en": "Reach 100% achievement rate for Chapter 3"},
	"a_MaxAchievementChapter4":						{"en": "Reach 100% achievement rate for Chapter 4"},
	"a_MaxAchievementChapter5":						{"en": "Reach 100% achievement rate for Chapter 5"},
	"a_MaxAchievementChapter6":						{"en": "Reach 100% achievement rate for Chapter 6"},
	"a_MaxAchievementChapter7":						{"en": "Reach 100% achievement rate for Chapter 7"},
	"a_MaxAchievementChapter8":						{"en": "Reach 100% achievement rate for Chapter 8"},
	"a_MaxAchievementEpilogue":						{"en": "Reach 100% achievement rate for the Epilogue"},
	"a_MaxAchievementTotal":						{"en": "Reach 100% total achievement rate"},
	"a_EndingA":									{"en": "Achieve ending A"},
	"a_EndingB1":									{"en": "Achieve ending B1"},
	"a_EndingB2":									{"en": "Achieve ending B2"},
	"a_EndingC": 									{"en": "Achieve ending C"},
	"a_EndingD": 									{"en": "Achieve ending D"},
	"a_EndingE": 									{"en": "Achieve ending E"},
	"a_EndingEXKillHomunculus":						{"en": "Achieve ending EX, by destroying the jewel"},
	"a_EndingEXCureHelena":							{"en": "Achieve ending EX, by creating a miracle cure"},
	"a_DoctorateTimeTraveling": 					{"en": "Receive a lecture on time-travel physics within Chapter 4"}, 
	"a_RunningAcrossThe90s":						{"en": "Encounter an athletic man from a bygone era, as well as his present self during Chapter 3, 4 or 5"},
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from an entertainer in Chapter 1"},
	"a_ShowEggTownPlanter": 						{"en": "Present the barman's ancestor with your egg collection in Chapter 2"},
	"a_EggPocketWatchForCoffee": 					{"en": "Pay for some coffee with an oval shaped object from Chapter 6 onward"},
	"a_BarmansChildren":							{"en": "Uncover the truth about the barman's grandchildren in Chapter 5"},
	"a_PocketWatchCollection": 						{"en": "Share your egg collection with a younger barman during Chapter 7"},
	"a_PocketWatchReminiscing": 					{"en": "Share stories about your newly acquired pocket watch with Eckart in Chapter 8"},
	"a_EggCollection": 								{"en": "Exchange an egg for a pan during Chapter 1, 3 or 4"},
	"a_AlertBarmanOfFire": 							{"en": "Notify the young boy's grandpa of an approaching threat during Chapter 1"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "Obtain one final message during the EX Chapter"},	
	"a_ShowPocketWatchToPhotographer":				{"en": "Kindle the joy of watchmaking to an ancestor of the Franssen's"},
	"a_EikeThePyromancer": 							{"en": "Ascend to reverence as a pyrokinetic in Chapter 2"},
	"a_EikeTheMagician": 							{"en": "Ascend to renown as a magician in Chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Set up a floral display in Chapter 2"},
	"a_MeetOldMiriam":								{"en": "Meet Eckart's wife in Chapter 7, after your valiant act"},
	"a_LostYoungCouple1": 							{"en": "Aid a bewildered young couple in their reunion amidst the medieval era within Chapter 2"}, 
	"a_LostYoungCouple2": 							{"en": "Weave the threads of fate into another chance at reunion for a lost young couple in Chapter 3"},
	"a_LostYoungCouple3": 							{"en": "Successfully orchestrate the reunion of the lost young couple in the Middle Ages during Chapter 4"},
	"a_LostYoungCouple4": 							{"en": "Assess the developments surrounding the young man amidst the Medieval period in Chapter 5"},
	"a_LostYoungCouple5": 							{"en": "Offer guidance to the young couple in the Middle Ages during Chapter 7"},
	"a_LostYoungCouple6": 							{"en": "Share a piece of wisdom with the young man in the Middle Ages and assess his interpretation within Chapter 8"},
	"a_EnigmaticCouple1": 							{"en": "Identify the coated man and woman in the modern-day setting during the Prologue or Chapter 1"}, 
	"a_EnigmaticCouple2": 							{"en": "Discover the coated man and woman in the contemporary setting within Chapter 3"}, 
	"a_EnigmaticCouple3": 							{"en": "Seek out the coated man and woman in the present during Chapter 4"}, 
	"a_EnigmaticCouple4": 							{"en": "Encounter the coated man and woman in the current timeline during Chapter 5"},	
	"a_EnigmaticCouple5": 							{"en": "Find the coated man and woman in the present during Chapter 7"},
	"a_ErasingEike": 								{"en": "Warn yourself of your impending demise during the Prologue"},
	"a_ErasingEike2": 								{"en": "Stumble upon yourself in Chapter 7"}, 
	"a_RottenRope": 								{"en": "Employ a worn-out cable to save yourself during Chapter 7"},
	"a_MetYouBefore": 								{"en": "Keep chatting with Dana under the Marktplatz tree during Chapter 2, even as whispers of fate gently caress the periphery of your dialogue"},
	"a_FreeMeal":									{"en": "Enjoy a free dinner  at Bar Zum Ei during Chapter 5"}, 
	"a_DrunkenGuys":								{"en": "Encounter some mischievous rascals in Chapter 7"},
	"a_ScareEveryone": 								{"en": "Attempt to sow fear among numerous individuals within Chapter 2"}, 
	"a_TimeTravellingCat":							{"en": "Offer a charming kitty to a lonely girl either during or after Chapter 4"},
	"a_MeetFamousOleg":								{"en": "Inspire the movie director for a second time during Chapter 7"},
	"a_SeenOlegAsWell": 							{"en": "Find someone who shares a similar experience of meeting the meditating man in Chapter 6"},
	"a_PocketWatchTo80sBarman": 					{"en": "Pique someone's interest with an oval shape of your own in the 1980's"},
	"a_HugoMotherChild":							{"en": "Chance upon Hugo in the vicinity of his home during the events of Chapter 5"}, 
	"a_ArtAppreciator": 							{"en": "Marvel at the beauty of each unique painting on display at the Brum Museum"},
	"a_AntiquesEule": 								{"en": "Spare a moment to glance at the timeless relics within the esteemed Antique Shop Eule"},
	"a_ExcuseMeMyMy":								{"en": "Firmly excuse yourself from the apparition's company in Chapter 3"}, 
	"a_BecomeThePerformer":							{"en": "Step into the shoes of a performer and clandestinely transmit a message to yourself during Chapter 4"}, 
	"a_SnowyCrimeScene":							{"en": "Witness a chilling crime scene revealed amidst the snowy terrain during Chapter 6"},
	"a_SaveMiriamBrum":								{"en": "Navigate the labyrinths of fate to shield a member of the Brum family from their destined demise during the events of Chapter 6"}, 
	"a_TimeEgoFlop":								{"en": "Weave the fabric of time and space as co-directors in the creation of 'Time Ego Trip World Conquest' during the narrative of Chapter 6"},
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Locate five unique energy orbs scattered across present-day Lebensbaum"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Locate six unique energy orbs scattered across Medieval Lebensbaum"},
	"a_EnergyOrbLocator70s80s": 					{"en": "Locate five unique energy orbs scattered across Lebensbaum during the late 20th century"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Locate six unique energy orbs scattered across Lebensbaum during the early 20th century"},
	"a_GiveMargaretteCake": 						{"en": "Gift a delectable sweet to a cherished individual in your life"},
	"a_NewCakeInvented": 							{"en": "Establish a new line of pastries"},
	"a_ShortestChapter": 							{"en": "Secure an iron plate prior to Chapter 4, deploying it judiciously when its utility becomes necessary"}, 
	"a_MaxInventory": 								{"en": "Accrue the largest arsenal of items during a singular playthrough"},
	"a_PerformerGoingExtraMile": 					{"en": "Highlight the significance of going above and beyond, especially for those, including yourself, who would truly value the performer's effort"}, 	
	"a_ArtInspiration1": 							{"en": "Inspire a renowned artist and appraise his work"}, 
	"a_ArtInspirationAll": 							{"en": "Become a beacon of inspiration for a prominent artist and assess all his works"}}


// ****************************
// • Achievements INITIALIZER •
// ****************************
//	- Creates achievement objects (accepted by RATools) based on the achievement dictionary (const_achievements_coreData)
function achievements_initialize() {

	function achievements_generateTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function achievements_createCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (util_isDebugModeActive) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
			}
			return let_string}
		function achievements_getTitle(string_achievementDevName, string_languageCode) => 
			achievements_titles[string_achievementDevName][string_languageCode]
		return format("{0}{1}",
			achievements_createCategoryName(string_achievementCategory, string_achievementDevName),
			achievements_getTitle(string_achievementDevName, string_languageCode))}
	
	function achievements_generateDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function achievements_getDescription(string_achievementDevName, string_languageCode) => 
			achievements_descriptions[string_achievementDevName][string_languageCode]	
		function achievements_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util_isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		return format("{0}{1}",
			achievements_getDescription(string_achievementDevName, string_languageCode),
			achievements_formatDevInfo(string_devInfo))}

	function achievements_getTrigger(string_achievementDevName) => 
		achievements_triggers[string_achievementDevName]

	// This loop generates the achievements
	for categoryName in achievements_coreData {
		for cheevmentName in achievements_coreData[categoryName] {
			let_achievementData = achievements_coreData[categoryName][cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = achievements_generateTitle(cheevmentName, categoryName, util_language),
				type = achievements_typeByCategory[categoryName],
				description = achievements_generateDescription(cheevmentName, let_achievementData["devInfo"], util_language),
				points = let_achievementData["points"],
				trigger = achievements_getTrigger(cheevmentName)
			)
		}}
	}

// ***************************************************************************************************** \\
//																										 \\
//   ██████╗ ██╗ ██████╗██╗  ██╗    ██████╗ ██████╗ ███████╗███████╗███████╗███╗   ██╗ ██████╗███████╗   \\
//   ██╔══██╗██║██╔════╝██║  ██║    ██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝   \\
//   ██████╔╝██║██║     ███████║    ██████╔╝██████╔╝█████╗  ███████╗█████╗  ██╔██╗ ██║██║     █████╗     \\
//   ██╔══██╗██║██║     ██╔══██║    ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║██╔══╝  ██║╚██╗██║██║     ██╔══╝     \\
//   ██║  ██║██║╚██████╗██║  ██║    ██║     ██║  ██║███████╗███████║███████╗██║ ╚████║╚██████╗███████╗   \\
//   ╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝   \\
//																										 \\
// ***************************************************************************************************** \\

// **************************
// • RichPresence FUNCTIONS •
// **************************
//	- Functions that should only be used by the rich presence script
function is_ChapterIdInRangeOfRecordedIds() {
	return
		0 < current_ChapterID() && 	// Prologue starts at 0x1
		current_ChapterID() <= 0xb} // Epilogue ends at 0xb
function is_ChapterOneOf(array_chapterIds) {
	any_of(array_chapterIds, (chapterId) => is_Chapter(chapterId))}
// *********************
// • RichPresence TEXT •
// *********************
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	

	"rp_isPaused":										{"en": "Paused ⏸️ time  | The Fated 🕑 {0} | Current 📆 {1} April {2} 🕑 {3} | Completion: {4}%"},
	"rp_InGameEXChapterOnly":							{"en": "Ending the cycle | The Fated 🕑 {0} | Current 📆 {1} April {2} 🕑 {3} | Completion: {4}%"},
	"rp_InGameChapterOnly":								{"en": "{0} | The Fated 🕑 {1} | Current 📆 {2} April {3} 🕑 {4} | Completion: {5}%"},
	"rp_InGameChapterWithTimePeriod": 					{"en": "{0} {1} | The Fated 🕑 {2} | Current 📆 {3} April {4} 🕑 {5} | Completion: {6}%"},
	"rp_AtTitleScreen":									{"en": "Title Screen | Completion {0}%"},

	"rp_Default":										{"en": "Wandering Lebensbaum"}}
richPresence_LookupTablesText = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	
	// "rp_Template_LookupFallback": 					{"en": "xxxxxxxx"},	

	"rpp_FatedHour_Prologue": 							{"en": "14h30"},
	"rpp_FatedHour_Chapter1": 							{"en": "15h00"},
	"rpp_FatedHour_Chapter2": 							{"en": "15h30"},
	"rpp_FatedHour_Chapter3": 							{"en": "17h50"},
	"rpp_FatedHour_Chapter4": 							{"en": "20h30"},
	"rpp_FatedHour_Chapter5": 							{"en": "22h30"},
	"rpp_FatedHour_Chapter6": 							{"en": "23h55"},
	"rpp_FatedHour_Chapter7": 							{"en": "01h30"},
	"rpp_FatedHour_Chapter8": 							{"en": "04h30"},
	"rpp_FatedHour_LookupFallback":						{"en": "a mystery"},

	"rpp_Chapter_Prologue":								{"en": "Defying destiny"},
	"rpp_Chapter_Chapter1":								{"en": "Extinguishing the heat"},
	"rpp_Chapter_Chapter2":								{"en": "Exploring Lebensbaum"},
	"rpp_Chapter_Chapter3":								{"en": "Visiting the art museum"},
	"rpp_Chapter_Chapter4":								{"en": "Searching for an iron plate"},
	"rpp_Chapter_Chapter5":								{"en": "Amalgamating an antidote"},
	"rpp_Chapter_Chapter6":								{"en": "Producing a film"},
	"rpp_Chapter_Chapter7":								{"en": "Examining a tower"},
	"rpp_Chapter_Chapter8":								{"en": "Seeking the red stone"},
	"rpp_Chapter_Epilogue":								{"en": "Cheating death"},
	"rpp_Chapter_LookupFallback":						{"en": "Roaming Lebensbaum"},

	"rpp_TimePeriod_MiddleAges":						{"en": "in the Middle Ages"},
	"rpp_TimePeriod_Late20Century":						{"en": "in the late 20th century"},
	"rpp_TimePeriod_Early20Century":					{"en": "in the early 20th century"},
	"rpp_TimePeriod_Present":							{"en": "in the present"},
	"rpp_TimePeriod_LookupFallback":					{"en": ""}}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]
function richPresence_getLookupTableText(string_parameterKey, string_lookupValue) {
	let_lookupTableTextKey = format("{0}_{1}", string_parameterKey, string_lookupValue)
	return richPresence_LookupTablesText[let_lookupTableTextKey][util_language]}
// -------------------------------------
richPresence_lookupTables = {
	"rpp_FatedHour": { // Each chapter has a fated hour
		get_ChapterID(CHAPTER_Prologue): "Prologue", 
		get_ChapterID(CHAPTER_Chapter1): "Chapter1",
		get_ChapterID(CHAPTER_Chapter2): "Chapter2",
		get_ChapterID(CHAPTER_Chapter3): "Chapter3",
		get_ChapterID(CHAPTER_Chapter4): "Chapter4",
		get_ChapterID(CHAPTER_Chapter5): "Chapter5",
		get_ChapterID(CHAPTER_Chapter6): "Chapter6",
		get_ChapterID(CHAPTER_Chapter7): "Chapter7",
		get_ChapterID(CHAPTER_Chapter8_NoAncestress): "Chapter8",
		get_ChapterID(CHAPTER_Chapter8_Ancestress): "Chapter8",
		get_ChapterID(CHAPTER_Epilogue_NoAncestress): "Chapter8",
		get_ChapterID(CHAPTER_Epilogue_Ancestress): "Chapter8"},
	"rpp_TimePeriod": {	// Refer to 0xAA1268
		get_TimePeriodIDs(TIMEPERIOD_MiddleAges): "MiddleAges",
		get_TimePeriodIDs(TIMEPERIOD_Early20thCentury): "Early20Century",
		get_TimePeriodIDs(TIMEPERIOD_Late20thCentury, 0): "Late20Century",
		get_TimePeriodIDs(TIMEPERIOD_Late20thCentury, 1): "Late20Century",
		get_TimePeriodIDs(TIMEPERIOD_Present): "Present"},
	"rpp_Chapter": { // Refer to const_chapter_IDs
		get_ChapterID(CHAPTER_Prologue): "Prologue",
		get_ChapterID(CHAPTER_Chapter1): "Chapter1",
		get_ChapterID(CHAPTER_Chapter2): "Chapter2",
		get_ChapterID(CHAPTER_Chapter3): "Chapter3",
		get_ChapterID(CHAPTER_Chapter4): "Chapter4",
		get_ChapterID(CHAPTER_Chapter5): "Chapter5",
		get_ChapterID(CHAPTER_Chapter6): "Chapter6",
		get_ChapterID(CHAPTER_Chapter7): "Chapter7",
		get_ChapterID(CHAPTER_Chapter8_NoAncestress): "Chapter8",
		get_ChapterID(CHAPTER_Chapter8_Ancestress): "Chapter8",
		get_ChapterID(CHAPTER_Epilogue_NoAncestress): "Epilogue",
		get_ChapterID(CHAPTER_Epilogue_Ancestress): "Epilogue"}}
function richPresence_getLookupTable(string_lookupParameterKey) =>
	richPresence_lookupTables[string_lookupParameterKey]
// **************************
// • RichPresence CORE DATA •
// **************************
//	- Contains logic data for the rich presence script
function richPresence_callDisplayFunctions(){
	
	// rich_presence_conditional_display(	// rp_isPaused // DISABLED // VERIFIED not as elegant inside rich presence; !! IF !! turning back on re-check richPresence_conditions, some other conditions need changing
	// 	richPresence_getCondition("rp_isPaused"),
	// 	richPresence_getText("rp_isPaused"),
	// 	richPresence_callParameterFunction("rpp_FatedHour"),
	// 	richPresence_callParameterFunction("rpp_PresentTimeDays"),
	// 	richPresence_callParameterFunction("rpp_PresentTimeYears"),
	// 	richPresence_callParameterFunction("rpp_PresentTimeHourMinutes"),
	// 	richPresence_callParameterFunction("rpp_TotalCompletionRate"))

	rich_presence_conditional_display(	// rp_InGameEXChapterOnly // VERIFIED
		richPresence_getCondition("rp_InGameEXChapterOnly"),
		richPresence_getText("rp_InGameEXChapterOnly"),
		richPresence_callParameterFunction("rpp_FatedHour"),
		richPresence_callParameterFunction("rpp_PresentTimeDays"),
		richPresence_callParameterFunction("rpp_PresentTimeYears"),
		richPresence_callParameterFunction("rpp_PresentTimeHourMinutes"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate"))

	rich_presence_conditional_display(	// rp_InGameChapterOnly // VERIFIED
		richPresence_getCondition("rp_InGameChapterOnly"),
		richPresence_getText("rp_InGameChapterOnly"),
		richPresence_callParameterFunction("rpp_Chapter"),
		richPresence_callParameterFunction("rpp_FatedHour"),
		richPresence_callParameterFunction("rpp_PresentTimeDays"),
		richPresence_callParameterFunction("rpp_PresentTimeYears"),
		richPresence_callParameterFunction("rpp_PresentTimeHourMinutes"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate"))

	rich_presence_conditional_display(	// rp_InGameChapterWithTimePeriod // VERIFIED
		richPresence_getCondition("rp_InGameChapterWithTimePeriod"),
		richPresence_getText("rp_InGameChapterWithTimePeriod"),
		richPresence_callParameterFunction("rpp_Chapter"),
		richPresence_callParameterFunction("rpp_TimePeriod"),
		richPresence_callParameterFunction("rpp_FatedHour"),
		richPresence_callParameterFunction("rpp_PresentTimeDays"),
		richPresence_callParameterFunction("rpp_PresentTimeYears"),
		richPresence_callParameterFunction("rpp_PresentTimeHourMinutes"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate"))

	rich_presence_conditional_display(	// rp_AtTitleScreen // VERIFIED
		richPresence_getCondition("rp_AtTitleScreen"),
		richPresence_getText("rp_AtTitleScreen"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate"))

	rich_presence_display(	// rp_Default // VERIFIED
		richPresence_getText("rp_Default"))}
// -------------------------------------
richPresence_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_LOOKUP = 2	// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_MACRO = 3		// rich_presence_macro(macro, expression)
// -------------------------------------
richPresence_conditions = {
	"rp_isPaused": () => 
		is_InGame() && is_InGamePauseMenu_active(),
	"rp_InGameEXChapterOnly": () =>
		is_InGame() && is_ChapterIdInRangeOfRecordedIds() && 
		is_PrologueExMode_active() && is_ExChapter_unlocked() && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		is_Chapter(CHAPTER_Prologue),
	"rp_InGameChapterOnly": () =>
		is_InGame() && is_ChapterIdInRangeOfRecordedIds() && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		!is_PrologueExMode_active() && is_ChapterOneOf(
			[CHAPTER_Prologue, CHAPTER_Chapter1, CHAPTER_Epilogue]),
	"rp_InGameChapterWithTimePeriod": () { return
		is_InGame() && is_ChapterIdInRangeOfRecordedIds() && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		is_ChapterOneOf([
			CHAPTER_Chapter2, CHAPTER_Chapter3, 
			CHAPTER_Chapter4, CHAPTER_Chapter5, 
			CHAPTER_Chapter6, CHAPTER_Chapter7, CHAPTER_Chapter8])},
	"rp_AtTitleScreen": () =>
		is_MainSave_loaded() && 
		(is_TitleMenu_active() || !is_InGame())
	}
function richPresence_getCondition(string_displayKey) =>
	richPresence_conditions[string_displayKey]
// -------------------------------------
richPresence_parameterData = {
	// DEV_NOTE: rich presence
	// 		- Expression examples:
	//			-- Memory Accessor => byte(0x000)
	//			-- Arithmetic Expression => getCurrentLevel() + 1
	// 		- Available macro formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_macromacro-expression
	// 		- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// ------------------------------------------------------

	"rpp_Chapter": {
		"RPtype": richPresence_LOOKUP,
		"Expression": current_ChapterID(),
		"LookupFallback": richPresence_getLookupTableText("rpp_Chapter", "LookupFallback")},
	"rpp_TimePeriod": {	
		"RPtype": richPresence_LOOKUP,
		"Expression": current_TimePeriod(),
		"LookupFallback": richPresence_getLookupTableText("rpp_TimePeriod", "LookupFallback")},
	"rpp_TotalCompletionRate": {
		"RPtype": richPresence_MACRO,
		"Expression": getTotalAchievementRate(),
		"MacroFormat": "Number"},
	"rpp_PresentTimeSeconds": {
		"RPtype": richPresence_MACRO,
		"Expression": current_PresentTime_Seconds(),
		"MacroFormat": "Number"},
	"rpp_PresentTimeMinutes": {	
		"RPtype": richPresence_MACRO,
		"Expression": get_DateTime_Minutes(DATETIME_Present, USA),
		"MacroFormat": "Number"},	
	"rpp_PresentTimeHourMinutes": {	
		"RPtype": richPresence_MACRO,
		"Expression": (get_DateTime_Minutes(DATETIME_Present, USA) + get_DateTime_Hours(DATETIME_Present, USA) * 60),
		"MacroFormat": "Minutes"},
	"rpp_PresentTimeHours": {	
		"RPtype": richPresence_MACRO,
		"Expression": get_DateTime_Hours(DATETIME_Present, USA),
		"MacroFormat": "Number"},
	"rpp_PresentTimeYears": {	
		"RPtype": richPresence_MACRO,
		"Expression": current_PresentTime_Years(),
		"MacroFormat": "Number"},
	"rpp_PresentTimeDays": {
		"RPtype": richPresence_MACRO,
		"Expression": current_PresentTime_Days(),
		"MacroFormat": "Number"},
	"rpp_FatedHour": {
		"RPtype": richPresence_LOOKUP,
		"Expression": current_ChapterID(),
		"LookupFallback": richPresence_getLookupTableText("rpp_FatedHour", "LookupFallback")}
	}	
// *****************************
// • RichPresence INITIALIZER •
// *****************************
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_parameterKey in richPresence_lookupTables {
		let_lookupTable = richPresence_lookupTables[let_parameterKey]
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_parameterKey][let_lookupKey]
			richPresence_lookupTables[let_parameterKey][let_lookupKey] = richPresence_getLookupTableText(let_parameterKey, let_lookupValue)
		}
	}}
function richPresence_createParameterName(string_parameterKey) => substring(string_parameterKey, 4)	// Removes rpp_ 
function richPresence_callParameterFunction(string_parameterKey) {	// Checks which rich_presence function to execute/call and gives it the correct parameters with the data stored in richPresence_parameterData
	function richPresence_callValueFunction(string_parameterKey, dict_paramValueData) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramValueData["Expression"]
		let_format = dict_paramValueData["ValueFormat"] 
		return rich_presence_value(let_name, let_expression, let_format)}
	
	function richPresence_callLookupFunction(string_parameterKey, dict_paramLookupData) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramLookupData["Expression"]
		let_lookUpTable = richPresence_getLookupTable(string_parameterKey)
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) richPresence_callValueFunction(string_parameterKey, let_parameterData)
	else if (let_RPtype == richPresence_LOOKUP) richPresence_callLookupFunction(string_parameterKey, let_parameterData)
	else if (let_RPtype == richPresence_MACRO) richPresence_callMacroFunction(let_parameterData)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))
	}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_callDisplayFunctions()}

// ***************************************************************************************************** \\
//																										 \\
//   ██╗     ███████╗ █████╗ ██████╗ ███████╗██████╗ ██████╗  ██████╗  █████╗ ██████╗ ██████╗ ███████╗   \\
//   ██║     ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝   \\
//   ██║     █████╗  ███████║██║  ██║█████╗  ██████╔╝██████╔╝██║   ██║███████║██████╔╝██║  ██║███████╗   \\
//   ██║     ██╔══╝  ██╔══██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║╚════██║   \\
//   ███████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝███████║   \\
//   ╚══════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝   \\                                                                                                 
//																										 \\
// ***************************************************************************************************** \\

// **************************
// • Leaderboards FUNCTIONS •
// **************************
//	- Functions that should only be used by the leaderboards logic

// **************************
// • Leaderboards CORE DATA •
// **************************
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- WARNING: Make sure leaderboards are thoroughly tested, because there's no staging phase for these
	//		-- Change title and description via Dev menu on RA game page => Manage Leaderboards
	//	- Be wary of timers or values that reset to 0x0 when the bytes overflow => refer to score wrapping to fix https://docs.retroachievements.org/Leaderboards/#score-wrapping
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardValue": always_false(),
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "xxxxxxx"},

	"lb_ClearTimeChapter8": { // VERIFIED 
		"id": 92203, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter7": { // VERIFIED 
		"id": 92202, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter6": { // VERIFIED 
		"id": 92201, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter5": { // VERIFIED 
		"id": 92200, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter4": { // VERIFIED 
		"id": 92199, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter3": { // VERIFIED 
		"id": 92198, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter2": { // VERIFIED 
		"id": 92197, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter1": { // VERIFIED 
		"id": 92196, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimePrologue": { // VERIFIED 
		"id": 92195, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in prologue, excluding EX chapter"},
	"lb_TotalClearTime": { // VERIFIED 
		"id": 92194, "isLowerBetter": true,
		"leaderboardValue": get_Timer_TotalClearTime_InMinutes(),
		"leaderboardFormat": "MINUTES",
		"devInfo": "Best Total Clear Time, excluding EX chapter"}}

// ************************************
// ▴ Leaderboards TRIGGER GENERATORS ▴
// ************************************
//	- For leaderboard logic that's reoccuring across multiple triggers
function leaderboards_generate_ClearTimeChapter_StartTrigger(enum_chapter) {
	let_chapterSpecificComparison = always_true()
	if (enum_chapter == CHAPTER_Prologue) 
		let_chapterSpecificComparison = !is_PrologueExMode_active()
	return 
		never(!is_InGame()) &&
		once(on_Timer_ChapterClearTime_start()) &&
		is_Chapter(enum_chapter) &&
		repeated(700, is_InGame()) &&	// <-- Delay FIX for bug when loading a save from chapter start, would start and cancel immediately
		let_chapterSpecificComparison}	//		+ better visual feedback to indicate minutes timer is for chapter clear time, 
										//			both Total and chapter clear time pop and same time otherwise
function leaderboards_generate_ClearTimeChapter_CancelTrigger(enum_chapter) {
	let_chapterSpecificComparison = always_false()
	if (enum_chapter == CHAPTER_Prologue)
		let_chapterSpecificComparison = is_PrologueExMode_active()
	return 	
		!is_InGame() 						|| 
		let_chapterSpecificComparison 		|| 
		on_Timer_ChapterClearTime_reset() 	||
		!is_Chapter(enum_chapter)}
function leaderboards_generate_ClearTimeChapter_SubmitTrigger(enum_chapter) =>
	on_ChapterCompletionMenu_render() &&
	is_Chapter(enum_chapter)

// *************************
// • Leaderboards TRIGGERS •
// *************************
leaderboards_startTriggers = {
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter8),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter7),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter6),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter5),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter4),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter3),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter2),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Chapter1),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger(CHAPTER_Prologue),
	"lb_TotalClearTime": () =>
		never(!is_InGame()) &&
		once(on_Timer_TotalClearTime_start()) 	&&
		repeated(300, is_InGame()) &&	// <-- delay popup 
		!is_PrologueExMode_active()}
leaderboards_cancelTriggers = {
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter8),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter7),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter6),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter5),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter4),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter3),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter2),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Chapter1),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger(CHAPTER_Prologue),
	"lb_TotalClearTime": () =>
		!is_InGame() || is_PrologueExMode_active() || on_Timer_TotalClearTime_reset()}
leaderboards_submitTriggers = {
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter8),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter7),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter6),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter5),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter4),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter3),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter2),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Chapter1),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger(CHAPTER_Prologue),
	"lb_TotalClearTime": () =>
		is_InGame() &&
		(
			(		// Alt 1 => Trigger when credits video starts
				on_Video_start() && is_Chapter(CHAPTER_Epilogue)
			) || ( 	// Alt 2 => Trigger when timer has stopped for 20 frames during the credits video
				never(!on_Timer_TotalClearTime_valueChange() && !is_Video_active()) &&
				tally(20, 
					is_Video_active() && is_Chapter(CHAPTER_Epilogue) &&
					!on_Timer_TotalClearTime_valueChange())
			)
		)}

// *********************
// • Leaderboards TEXT •
// *********************
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_ClearTimeChapter8":					{"en": "Chapter 8 Clear Time"},
	"lb_ClearTimeChapter7":					{"en": "Chapter 7 Clear Time"},
	"lb_ClearTimeChapter6":					{"en": "Chapter 6 Clear Time"},
	"lb_ClearTimeChapter5":					{"en": "Chapter 5 Clear Time"},
	"lb_ClearTimeChapter4":					{"en": "Chapter 4 Clear Time"},
	"lb_ClearTimeChapter3":					{"en": "Chapter 3 Clear Time"},
	"lb_ClearTimeChapter2":					{"en": "Chapter 2 Clear Time"},
	"lb_ClearTimeChapter1":					{"en": "Chapter 1 Clear Time"},
	"lb_ClearTimePrologue":					{"en": "Prologue Clear Time"},
	"lb_TotalClearTime":					{"en": "Total Clear Time"}}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_ClearTimeChapter8":					{"en": "Prove your mastery over time by conquering Chapter 8 in record time"},
	"lb_ClearTimeChapter7":					{"en": "Prove your mastery over time by conquering Chapter 7 in record time"},
	"lb_ClearTimeChapter6":					{"en": "Prove your mastery over time by conquering Chapter 6 in record time"},
	"lb_ClearTimeChapter5":					{"en": "Prove your mastery over time by conquering Chapter 5 in record time"},
	"lb_ClearTimeChapter4":					{"en": "Prove your mastery over time by conquering Chapter 4 in record time"},
	"lb_ClearTimeChapter3":					{"en": "Prove your mastery over time by conquering Chapter 3 in record time"},
	"lb_ClearTimeChapter2":					{"en": "Prove your mastery over time by conquering Chapter 2 in record time"},
	"lb_ClearTimeChapter1":					{"en": "Prove your mastery over time by conquering Chapter 1 in record time"},
	"lb_ClearTimePrologue":					{"en": "Race through time to achieve the fastest clear time for the prologue (EX chapter excluded)"},
	"lb_TotalClearTime": 					{"en": "Race through time to achieve the fastest total clear time (EX chapter excluded)"}}

// ****************************
// • Leaderboards INITIALIZER •
// ****************************
function leaderboards_initialize() {
	function leaderboards_generateTitle(string_leaderboardDevName, string_languageCode) {
		function leaderboards_createDevName(string_leaderboardDevName) => 	// Removes lb_ and puts it between []
			format("[{0}] ", substring(string_leaderboardDevName, 3))
		function leaderboards_getTitle(string_leaderboardDevName, string_languageCode) => 
			leaderboards_titles[string_leaderboardDevName][string_languageCode]

		if (util_isDebugModeActive) {
			return format("{0}{1}", 
				leaderboards_createDevName(string_leaderboardDevName),
				leaderboards_getTitle(string_leaderboardDevName, string_languageCode))
		} else {
			return leaderboards_getTitle(string_leaderboardDevName, string_languageCode)
		}}
	
	function leaderboards_generateDescription(string_leaderboardDevName, string_devInfo, string_languageCode) {	
		function leaderboards_getDescription(string_leaderboardDevName, string_languageCode) {
			return leaderboards_descriptions[string_leaderboardDevName][string_languageCode]}
		function leaderboards_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util_isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}
		return format("{0}{1}",
			leaderboards_getDescription(string_leaderboardDevName, string_languageCode),
			leaderboards_formatDevInfo(string_devInfo))}

	for let_leaderboardKey in leaderboards_coreData {
		let_leaderboardData = leaderboards_coreData[let_leaderboardKey]
		leaderboard(
			id = let_leaderboardData["id"],
			title = leaderboards_generateTitle(let_leaderboardKey, util_language), 
			description = leaderboards_generateDescription(let_leaderboardKey, let_leaderboardData["devInfo"], util_language),
			start = leaderboards_startTriggers[let_leaderboardKey], 
			cancel = leaderboards_cancelTriggers[let_leaderboardKey], 
			submit = leaderboards_submitTriggers[let_leaderboardKey], 
			value = let_leaderboardData["leaderboardValue"], 
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}


// ********************************************************************** \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ********************************************************************** \\
function initializeRAscript() {
	// memory_initialize()
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()