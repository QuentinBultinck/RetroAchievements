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

// *****************************
// • Memory STRUCT DEFINITIONS •
// *****************************
memory_dataStructures = {
	"Struct_DateTime": {
		"sizeInBytes": 24,
		"offsets": {
			"32Bit_Years": 0x0,
			"32Bit_Months": 0x4,
			"32Bit_Days": 0x8,
			"32Bit_Hours": 0xc,
			"32Bit_Minutes": 0x10,
			"32Bit_Seconds": 0x14
		}},
	"Struct_CharacterPrintData": {
		"sizeInBytes": 16,
		"offsets": {
			"16Bit_ControlData": 0x0,
			"8Bit_Height": 0x2,
			"8Bit_Print_Xaxis": 0x6,
			"8Bit_ImageOffset_Xaxis": 0xa,
			"8Bit_ImageOffset_Yaxis": 0xb,
			"8Bit_ImageUnmask_Width": 0xc,
			"8Bit_Print_Yaxis": 0xd,
			"8Bit_CharacterSetId": 0xe
		}},
	}
function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_offsetKey) =>
	memory_dataStructures[string_structKey]["offsets"][string_offsetKey]
// **************************
// • Memory ADDRESS STORAGE •
// **************************
GAMEREGION_USA = "NTSC-U/C"
GAMEREGION_EUR = "PAL"
GAMEREGION_JPN = "NTSC-J"

DATATYPE_BitFlag 				= 700
DATATYPE_4Bit 					= 600
DATATYPE_8Bit 					= 500
DATATYPE_16Bit 					= 400
DATATYPE_25BitPointer 			= 300
DATATYPE_Float					= 201
DATATYPE_32Bit 					= 200
DATATYPE_Struct 				= 100
memory_addresses = { //WIP mem
	//	"DATATYPE_xxxxx": {
	//		"Template": {GAMEREGION_USA: sNULL, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: sNULL},
	//	}
	DATATYPE_BitFlag: {
		"CurrentPlaythrough_ExChapter": {GAMEREGION_USA: 0xa9ed98, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68e8},
		"CurrentPlaythrough_Chapter1": {GAMEREGION_USA: 0xa9ed9d, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68ed},
		"CurrentPlaythrough_Chapter2": {GAMEREGION_USA: 0xa9eda0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68f0},
		"CurrentPlaythrough_Chapter4": {GAMEREGION_USA: 0xa9eda5, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68f5},
		"CurrentPlaythrough_AncestorChoice_1": {GAMEREGION_USA: 0xa9edad, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68fd},
		"CurrentPlaythrough_AncestorChoice_2": {GAMEREGION_USA: 0xa9edae, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68fe},
		"CurrentPlaythrough_MovieChoice_1": {GAMEREGION_USA: 0xa9edb7, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6907},
		"CurrentPlaythrough_MovieChoice_2": {GAMEREGION_USA: 0xa9edb8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6908},
		"CurrentPlaythrough_MultiChapter_1": {GAMEREGION_USA: 0xa9ed76, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68c6},
		"CurrentPlaythrough_MultiChapter_2": {GAMEREGION_USA: 0xa9edca, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa691a},
		"CurrentPlaythrough_MultiChapter_3": {GAMEREGION_USA: 0xa9edcb, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa691b},
		"CurrentPlaythrough_MultiChapter_4": {GAMEREGION_USA: 0xa9edcc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa691c},
		"CurrentPlaythrough_InspiredKarlFranssenArt_1": {GAMEREGION_USA: 0xa9edb0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6900},
		"CurrentPlaythrough_InspiredKarlFranssenArt_2": {GAMEREGION_USA: 0xa9edb1, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6901},
		"CurrentPlaythrough_BrumEstateChoice": {GAMEREGION_USA: 0xa9edaa, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68fa},
		"CurrentPlaythrough_DanaChoice": {GAMEREGION_USA: 0xa9edc0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6910},
		"CurrentPlaythrough_SaveDanaFromPast": {GAMEREGION_USA: 0xa9edc4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6914},
		"IsInGamePauseMenuDisplayed": {GAMEREGION_USA: 0xb91514, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xb99094},
		"IsLoading_OR_IsChapterCompletionMenuDisplayed": {GAMEREGION_USA: 0xa82e2c, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa8a97c},
	},
	DATATYPE_4Bit: {
		"IsInGame": {GAMEREGION_USA: 0xa9eddc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa692c},
		"AlwaysNull_Or_ValueNeverChanges": {GAMEREGION_USA: 0x1fffff0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x1fffff0},
	},
	DATATYPE_8Bit: {
		"YoungCoupleState_Chapter2": {GAMEREGION_USA: 0xa9ef89, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6ad9},
		"YoungCoupleState_Chapter3": {GAMEREGION_USA: 0xa9ef8a, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6ada},
		"YoungCoupleState_Chapter4": {GAMEREGION_USA: 0xa9ef8b, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6adb},
		"YoungCouple_Chapter7": {GAMEREGION_USA: 0xa9ef8e, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6ade},
		"YoungCouple_Chapter8": {GAMEREGION_USA: 0xa9ef8f, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6adf},
		"AchievementPercentageNumber_Total": {GAMEREGION_USA: 0xaa1152, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa8ca2},
		"HighlightedButtonAtTitleScreen": {GAMEREGION_USA: 0x1fff604, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x1fff604},
		"HighLightedInventoryItem": {GAMEREGION_USA: 0xa9f111, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6c61},
		"EnergyUnits": {GAMEREGION_USA: 0xa9daa8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa55f8},
		"IsCutsceneActive": {GAMEREGION_USA: 0xa9ed26, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6876},
		"ChapterID": {GAMEREGION_USA: 0xb95704, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xb9d284},
	},
	DATATYPE_16Bit: {
		"Cutscene_SectionID_1": {GAMEREGION_USA: 0xa9ecc0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6810},
		"Cutscene_SectionID_2": {GAMEREGION_USA: 0xa9ecc2, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6812},
	},
	DATATYPE_25BitPointer: {
		"InteractionID": {GAMEREGION_USA: 0xa9efe4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6b34},
		"InteractionChapterID": {GAMEREGION_USA: 0xa9efe0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6b30},
		"NPCinteractionID": {GAMEREGION_USA: 0xa9efdc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6b2c},
		"ExtraMenuNavigation": {GAMEREGION_USA: 0xac3170, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xacacb0},
		"EndingFileData": {GAMEREGION_USA: 0xac3178, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xacacb8},
		"GameRegionIdentifier": {GAMEREGION_USA: 0xaa2998, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaaa4e8},
		"Cutscene_MasterData": {GAMEREGION_USA: 0xa9ecc8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6818},
		"Cutscene_SectionData": {GAMEREGION_USA: 0xa9eccc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa681c},
		"Cutscene_MinorIDs": {GAMEREGION_USA: 0xa9ecd4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6824},
		"VideoData": {GAMEREGION_USA: 0x8ffef0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x8fbef0},
		"EnergyOrbs_Present_City": {GAMEREGION_USA: 0xa442ec, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450bc},
		"EnergyOrbs_Late20thCentury_City": {GAMEREGION_USA: 0xa442f0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450c0},
		"EnergyOrbs_Early20thCentury_City": {GAMEREGION_USA: 0xa442f4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450c4},
		"EnergyOrbs_Early20thCentury_BrumMansion": {GAMEREGION_USA: 0xa44304, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450d4},
		"EnergyOrbs_MiddleAges_City": {GAMEREGION_USA: 0xa442f8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450c8},
		"EnergyOrbs_MiddleAges_AlchemyLab": {GAMEREGION_USA: 0xa44300, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450d0},
		"EnergyOrbs_MiddleAges_Church": {GAMEREGION_USA: 0xa4430c, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa450dc},
	},
	DATATYPE_Float: {
		"PlayerPosition_xAxis": {GAMEREGION_USA: 0xa8abd0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa92720},
		"PlayerPosition_yAxis": {GAMEREGION_USA: 0xa8abd8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa92728},
	},
	DATATYPE_32Bit: {
		"Timer_ChapterClearTime": {GAMEREGION_USA: 0xaa155c, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa90ac},
		"Timer_TotalClearTime": {GAMEREGION_USA: 0xaa1560, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa90b0},
		"BottomScreenTextID": {GAMEREGION_USA: 0xac31e4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xacad24},
		"VideoData": {GAMEREGION_USA: 0x8ffef0, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x8fbef0},
		"IsChapterCompletionScreenActive": {GAMEREGION_USA: 0x1fff5f4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x1fff5f4},
		"IsEventViewerActive": {GAMEREGION_USA: 0x1fff130, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x1fff130},
		"MenuIdentification": {GAMEREGION_USA: 0x1fff5f8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0x1fff5f8},
		"MenuID": {GAMEREGION_USA: 0xac49f4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xacc534},
		"Cutscene_Timer": {GAMEREGION_USA: 0xa9ecbc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6888},
		"Cutscene_MasterID": {GAMEREGION_USA: 0xa9ecbc, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa680c},
		"AreaID": {GAMEREGION_USA: 0xa82e48, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xa8a998},
		"TimePeriod": {GAMEREGION_USA: 0xAA1268, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa8db8},
	},
	DATATYPE_Struct: {
		"CharacterPrintData_base": {GAMEREGION_USA: 0xac31e8, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xacad28},
		"DateTime_Present": {GAMEREGION_USA: 0xAA12A4, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa8df4},
		"EndingData_base": {GAMEREGION_USA: 0xaa1154, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa8ca4},
		"AchievementPercentage_Prologue_base": {GAMEREGION_USA: 0xa9ed3c, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa688c},
		"AchievementPercentage_Chapter1_base": {GAMEREGION_USA: 0xa9ed43, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6893},
		"AchievementPercentage_Chapter2_base": {GAMEREGION_USA: 0xa9ed47, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa6897},
		"AchievementPercentage_Chapter3_base": {GAMEREGION_USA: 0xa9ed58, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68a8},
		"AchievementPercentage_Chapter4_base": {GAMEREGION_USA: 0xa9ed4d, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa689d},
		"AchievementPercentage_Chapter5_base": {GAMEREGION_USA: 0xa9ed52, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68a2},
		"AchievementPercentage_Chapter6_base": {GAMEREGION_USA: 0xa9ed5b, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68ab},
		"AchievementPercentage_Chapter7_base": {GAMEREGION_USA: 0xa9ed60, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68b0},
		"AchievementPercentage_Chapter8_base": {GAMEREGION_USA: 0xa9ed65, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68b5},
		"AchievementPercentage_Epilogue_base": {GAMEREGION_USA: 0xa9ed71, GAMEREGION_EUR: sNULL, GAMEREGION_JPN: 0xaa68c1},
	}}

function memory_getAddress(enum_dateType, string_addrKey, enum_gameRegion) {
	let_memAddr = memory_addresses[enum_dateType][string_addrKey][enum_gameRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_gameRegion))
	return let_memAddr}

function memory_initialize() { // memory_initialize: is called in initialization code
	function initialize_OtherRegions() {	// Use this function when ALL memory addresses for a game region are offset
		let_EUoffset = sNULL
		let_JPoffset = sNULL
		for memAddrKey in memory_addresses {
			let_USAaddr = memory_addresses[memAddrKey][GAMEREGION_USA]
			if(let_USAaddr == iNULL) util_throwError("Memory Address for {0} is NULL", memAddrKey)
			memory_addresses[memAddrKey][GAMEREGION_EUR] = let_USAaddr + let_EUoffset
			memory_addresses[memAddrKey][GAMEREGION_JPN] = let_USAaddr + let_JPoffset
		}
	}
	// initialize_OtherRegions()
	memory_initialize_NPCAppearances_gameRegionJPN() // offset 0x7b50
}
// ******************
// • Memory UTILITY •
// ******************
function is_GameRegion(enum_gameRegion) {
	let_memAddrPtrUSA = memory_getAddress(DATATYPE_25BitPointer, "GameRegionIdentifier", GAMEREGION_USA)
	let_memAddrPtrJPN = memory_getAddress(DATATYPE_25BitPointer, "GameRegionIdentifier", GAMEREGION_JPN)
	let_comparison_isUSA = bit0(memUtil_maskPointer(let_memAddrPtrUSA) + 0x4) == 1 	
	let_comparison_isJPN = bit0(memUtil_maskPointer(let_memAddrPtrJPN) + 0x4) == 1 
	if(enum_gameRegion == GAMEREGION_USA) { return 
		let_comparison_isUSA && !let_comparison_isJPN
	} else if (enum_gameRegion == GAMEREGION_JPN) { return
		!let_comparison_isUSA && let_comparison_isJPN
	} else {
		util_throwError(format("Game region '{0}' does not exist", enum_gameRegion))
	}}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	```0 + float(0xaa) + 0´´´	 -->	```float(0xa)´´´
	// 	- Workaround is the following => 	```byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)´´´
function memUtil_floatToInt(float_value) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", GAMEREGION_USA))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

function memUtil_maskPointer(memAddr_ptr) =>
	dword(memAddr_ptr) & 0x1FFFFFF	// <-- 0x1FFFFFF: masks 32-bit value to 25-bit (PSP uses 25-bit pointers)

function never_toAlt(comparison) =>
(
	(
		never(comparison)
	) || (
		always_false()
	)
)

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

function current_TimePeriod(enum_regionCode) =>
	dword(memory_getAddress(DATATYPE_32Bit, "TimePeriod", enum_regionCode))

function get_TimePeriodIDs(enum_timePeriod, int_idIndex = 0) =>
	const_TimePeriod_IDs[enum_timePeriod]["IDs"][int_idIndex]

// -------------------------------------
DATETIME_Present = 100
const_DateTime_memAddr = { 
	DATETIME_Present: {
		GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "DateTime_Present", GAMEREGION_USA),
		GAMEREGION_EUR: () => memory_getAddress(DATATYPE_Struct, "DateTime_Present", GAMEREGION_JPN),
	}}

function current_DateTime_Seconds(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Seconds"))

function current_DateTime_Minutes(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Minutes"))

function current_DateTime_Hours(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Hours"))

function current_DateTime_Days(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Days"))

function current_DateTime_Months(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Months"))

function current_DateTime_Years(enum_dateTime, enum_region) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_region] + memory_getDataStructOffset("Struct_DateTime","32Bit_Years"))
// **********************
// ◦ CLEAR TIME: TIMERS ◦
// **********************
function current_ChapterClearTime(enum_gameRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "Timer_ChapterClearTime", enum_gameRegion))
	
function prev_ChapterClearTime(enum_gameRegion) =>
	prev(current_ChapterClearTime(enum_gameRegion))

function get_Timer_ChapterClearTime_InSeconds(enum_gameRegion) =>
	current_ChapterClearTime(enum_gameRegion) / 60

function on_Timer_ChapterClearTime_start(enum_gameRegion) => 
	prev_ChapterClearTime(enum_gameRegion) == 0 &&
	current_ChapterClearTime(enum_gameRegion) > 0

function on_Timer_ChapterClearTime_reset(enum_gameRegion) =>
	current_ChapterClearTime(enum_gameRegion) < prev_ChapterClearTime(enum_gameRegion)
// -------------------------------------
function current_TotalClearTime(enum_gameRegion) =>	// $AA1560: [32-bit] Current Playthrough Timer - Total Clear Time
	dword(memory_getAddress(DATATYPE_32Bit, "Timer_TotalClearTime", enum_gameRegion))

function prev_TotalClearTime(enum_gameRegion) =>
	prev(current_TotalClearTime(enum_gameRegion))

function get_Timer_TotalClearTime_InMinutes(enum_gameRegion) =>
	current_TotalClearTime(enum_gameRegion) / 3600

function on_Timer_TotalClearTime_valueChange(enum_gameRegion) => 
	current_TotalClearTime(enum_gameRegion) != prev_TotalClearTime(enum_gameRegion)

function on_Timer_TotalClearTime_start(enum_gameRegion) => 
	prev_TotalClearTime(enum_gameRegion) == 0 &&
	current_TotalClearTime(enum_gameRegion) > 0

function on_Timer_TotalClearTime_reset(enum_gameRegion) =>
	current_TotalClearTime(enum_gameRegion) < prev_TotalClearTime(enum_gameRegion)

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
const_NPCs_data = { // GameRegion_JPN is initialized with memory_initialize_NPCAppearances_gameRegionJPN()
	// "xxxtemplatexxxx": { 
	// 	"ID": 0x00000, "Appearance": {
	// 		"xxxxxtemplatexxxxxxx": {"memAddr_TalkCount": {GAMEREGION_USA: 0x000000, GAMEREGION_JPN: iNULL}, "maxTalkCount": 0000}}},
	NPC_Present_BlondeYoungBoy: { 
		"ID": 0x187, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EEF8, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2}}},
	NPC_Present_BrunetteMother: { 
		"ID": 0x46,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE92, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_BrunetteYoungGirl: { 
		"ID": 0x42,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE7F, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_BlondeOldWomanOrangeSweater: { 
		"ID": 0x44, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE88, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_BrunetteAdultManGlasses: { 
		"ID": 0x195, "Appearance": iNULL},
	NPC_Present_BlondeElderlyWoman: { 
		"ID": 0x183, "Appearance": iNULL},
	NPC_Present_BroadDelinquent: { 
		"ID": 0x10, "Appearance": {
			"Chap7_CarPark": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE4C, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_SlimDelinquent: { 
		"ID": 0x13, "Appearance": {
			"Chap7_CarPark": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE51, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_CoatedWoman: { 
		"ID": 0x57,	"Appearance": {
			"Chap1Prologue_TownSquare": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE28, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE2C, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2}, // <-- Chap3-4 use same memAddr as they use same dialogue
			"Chap5_NearCafeSonne": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE31, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap7_SouthGate": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE2F, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2}}},
	NPC_Present_CoatedMan: { 
		"ID": 0x56, "Appearance": {
			"Chap1Prologue_NearBar": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE1D, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap3_NearAntiqueShop": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE20, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap4_HaupStrUnderArch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE21, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap5_NorthEastGate_BrumLibrary": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE25, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap5_NorthEastGate_BrumMuseum": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE26, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap7_NorthWestGate": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE24, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_Present_JoggingMan: {
		"ID": 0x58, "Appearance": iNULL},
	NPC_80s_JoggingMan: {
		"ID": 0x59, "Appearance": iNULL},
	NPC_80s_Barman: { 
		"ID": 0xc, "Appearance": {
			"InsideBar_UsePocketWatchOrEgg": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE49, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},	// Counts for chap 6-7-8
	NPC_80s_OlderMan: { 
		"ID": 0x18d, "Appearance": {
			"Chap6_CafeSonne": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF43, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2}}},	
	NPC_MiddleAges_StrawHatMan: { 
		"ID": 0x5c, "Appearance": {
			"Chap2_Streets_Scare": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE36, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_MiddleAges_YoungCoupleWoman: { 
		"ID": 0x197, "Appearance": {
			"Chap2_WestGate_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF7C, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap2_WestGate_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF7D, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap2_EastNearHay_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF7E, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_NearNorthEastGate_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF7E, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_NearNorthEastGate_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF80, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_OutsideChurch_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF81, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap4_OutsideChurch_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF82, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap4_OutsideChurch_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF83, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},	
			"Chap4_NearBakery_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF84, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},	//	WARNING => uses same MemAddrTalkCount as Chap7_TownSquare
			"Chap7_TownSquare": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF84, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},						//	WARNING => uses same MemAddrTalkCount as Chap4_OutsideChurch_AfterTalkingToBoth
			"Chap7_TownSquare_Choice": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF85, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2}}},
	NPC_MiddleAges_YoungCoupleMan: { 
		"ID": 0x198, "Appearance": {
			"Chap2_EastNearHay_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF69, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap2_EastNearHay_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6A, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap2_WestGate_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6B, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_NearWell_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6C, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_NearWell_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6D, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap3_TownSquare_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6E, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap4_TownSquare_BeforeTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF6F, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap4_TownSquare_AfterTalkingToBoth": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF70, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap4_NearBakery_AfterLocationSwitch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF71, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1},
			"Chap5_NearSouthEastGate": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF72, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap7_OutsideChurch": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF74, GAMEREGION_JPN: iNULL}, "maxTalkCount": 2},
			"Chap8_OutsideChurch_AfterExperiment_WomanTruthful": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EF78, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_MiddleAges_EccentricGirl: { 
		"ID": 0x2e, "Appearance": {
			"Chap2_TownSquare_Scare": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE70, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}},
	NPC_MiddleAges_AspiringApprentice: {
		"ID": 0x5d, "Appearance": {
			"Chap2_SouthEastGate_Scare": {"memAddr_TalkCount": {GAMEREGION_USA: 0xA9EE3F, GAMEREGION_JPN: iNULL}, "maxTalkCount": 1}}}}

function memory_initialize_NPCAppearances_gameRegionJPN() { // This function should be called in memory_initialize()
	let_offsetToJPN = 0x7b50
	for NPCkey in const_NPCs_data {
		if (const_NPCs_data[NPCkey]["Appearance"] != iNULL) {
			for appearanceKey in const_NPCs_data[NPCkey]["Appearance"] {
				let_memAddr_USA = const_NPCs_data[NPCkey]["Appearance"][appearanceKey]["memAddr_TalkCount"][GAMEREGION_USA]
				const_NPCs_data[NPCkey]["Appearance"][appearanceKey]["memAddr_TalkCount"][GAMEREGION_JPN] = let_memAddr_USA + let_offsetToJPN
			}
		}
	}}

function get_NPC_Id(enum_npc) => 
	const_NPCs_data[enum_npc]["ID"]

function get_NPC_MaxTalkCount(enum_npc, string_appearance) => 
	const_NPCs_data[enum_npc]["Appearance"][string_appearance]["maxTalkCount"]

function current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) {
	let_memAddr = const_NPCs_data[enum_npc]["Appearance"][string_appearance]["memAddr_TalkCount"][enum_gameRegion]
	return byte(let_memAddr)}

function prior_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) =>
	prior(current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion))

function prev_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) =>
	prev(current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion))

function is_NPCtalkCount_atMax(enum_npc, string_appearance, enum_gameRegion) => 
	current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) == get_NPC_MaxTalkCount(enum_npc, string_appearance)

function is_TalkingToNPC(enum_npc, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_gameRegion))
	return 
		get_NPC_Id(enum_npc) == dword(let_maskedPointer)}

function has_startedTalkingToNPC_forFirstTime(enum_npc, string_appearance, enum_gameRegion) => 
	prior_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) < 0x1 &&
	current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) == 0x1

function on_NPC_TalkCount_hitsMax(enum_npc, string_appearance, enum_gameRegion) {
	let_maxTalkCount = get_NPC_MaxTalkCount(enum_npc, string_appearance)
	return 
		prev_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) == let_maxTalkCount - 1 &&	
		current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion)  == let_maxTalkCount}

function on_NPC_TalkCount_increase(enum_npc, string_appearance, enum_gameRegion) => 
	current_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion) > prev_NPCtalkCount(enum_npc, string_appearance, enum_gameRegion)
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

function is_InteractingWith(enum_interactableItem, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_gameRegion))
	return const_InteractableItem_IDs[enum_interactableItem] == dword(let_maskedPointer)}

function is_InteractionChapterId(int_Id, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "InteractionChapterID", enum_gameRegion))
	return dword(let_maskedPointer) == int_Id}

function is_InteractionId(int_Id, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "InteractionID", enum_gameRegion))	
	return dword(let_maskedPointer) == int_Id}
// -------------------------------------
STATE_YOUNGCOUPLE_talkedToNone = 0x0
STATE_YOUNGCOUPLE_talkedToBothOnce = 0x1
STATE_YOUNGCOUPLE_talkedToBothTwice = 0x2
STATE_YOUNGCOUPLE_bothHaveRespawned = 0x3
function is_LostYoungCoupleState_Chapter2(enum_stateYoungCouple, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter2", enum_gameRegion)) == enum_stateYoungCouple	

function is_LostYoungCoupleState_Chapter3(enum_stateYoungCouple, enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter3", enum_gameRegion)) == enum_stateYoungCouple	

function is_LostYoungCoupleState_Chapter4(enum_stateYoungCouple, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter4", enum_gameRegion)) == enum_stateYoungCouple	

function is_WomanAdvisedBeTruthful(enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCouple_Chapter7", enum_gameRegion)) >= 0x1

function is_ManToldLoversNeverDestinedMeet(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_8Bit, "YoungCouple_Chapter8", enum_gameRegion)
	return bit0(let_memAddr) == 1 && bit1(let_memAddr) ==0}

// ***************************
// ◦ CUTSCENE IDENTIFICATION ◦
// ***************************
function is_LargeCutscene_active(enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_gameRegion)) == 0x5

function is_SmallCutscene_active(enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_gameRegion)) == 0x1	

function is_NoCutscene_active(enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_gameRegion)) == 0

function on_Cutscene_end(enum_gameRegion){
	let_memAccessor_isCutsceneActive =  byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_gameRegion))
	return 
		prev(let_memAccessor_isCutsceneActive) > 0x0 &&
		let_memAccessor_isCutsceneActive == 0x0}

function on_CutsceneSection_end(enum_gameRegion) {
	let_memAccessor_isCutsceneActive =  byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_gameRegion))
	return 
		prev(let_memAccessor_isCutsceneActive) > 0x3 && 
		0x3 >= let_memAccessor_isCutsceneActive && let_memAccessor_isCutsceneActive > 0x0}

// -------------------------------------
function current_Cutsene_MasterId(enum_gameRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "Cutscene_MasterID", enum_gameRegion))

function is_Cutscene_MasterId(int_Id, enum_gameRegion) => 
	current_Cutsene_MasterId(enum_gameRegion) == int_Id

function was_Cutscene_MasterId(int_Id, enum_gameRegion) => 
	prior(current_Cutsene_MasterId(enum_gameRegion)) == int_Id

function on_Cutscene_MasterId_change(enum_gameRegion) => 
	prev(current_Cutsene_MasterId(enum_gameRegion)) != current_Cutsene_MasterId(enum_gameRegion)

function is_Cutscene_SectionId_1(int_Id, enum_gameRegion) => 
	word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_1", enum_gameRegion)) == int_Id

function is_Cutscene_SectionId_2(int_Id, enum_gameRegion) => 
	word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_2", enum_gameRegion)) == int_Id

function is_Cutscene_MasterDataId(int_Id, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_MasterData", enum_gameRegion))
	return dword(let_maskedPointer + 0x8) == int_Id}

function is_Cutscene_SectionDataId(int_Id, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_SectionData", enum_gameRegion))	
	return dword(let_maskedPointer + 0x8) == int_Id}

function is_Cutscene_MinorId(int_Id, int_offset, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_MinorIDs", enum_gameRegion))	
	return dword(let_maskedPointer + int_offset) == int_Id}

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
function is_Area(enum_area, enum_gameRegion) => 
	dword(memory_getAddress(DATATYPE_32Bit, "AreaID", enum_gameRegion)) == const_Area_IDs[enum_area]	

// *****************
// ◦ CHAPTER LOGIC ◦
// *****************
CHAPTER_Epilogue_NoAncestress 		= 122
CHAPTER_Epilogue_Ancestress 		= 121
CHAPTER_Epilogue 					= 120
CHAPTER_Chapter8_NoAncestress 	= 112 	// <-- If in chapter 5, player told Margarette she is NOT an ancestress
CHAPTER_Chapter8_Ancestress 	= 111	// <-- If in chapter 5, player told Margarette she is an ancestress
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

function current_ChapterID(enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "ChapterID", enum_gameRegion))

function prev_ChapterID(enum_gameRegion) =>
	prev(current_ChapterID(enum_gameRegion))

function is_Chapter(enum_chapter, enum_gameRegion) {
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_gameRegion) 	|| 
			is_Chapter(CHAPTER_Chapter8_Ancestress, enum_gameRegion)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) {	return
		(
			is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_gameRegion) 	|| 
			is_Chapter(CHAPTER_Epilogue_Ancestress, enum_gameRegion)
		)
	} else { return
		current_ChapterID(enum_gameRegion) == get_ChapterID(enum_chapter)
	}}

function on_Chapter_finish(enum_chapter, enum_gameRegion) {
	if (enum_chapter == CHAPTER_Chapter7) { return 
		prev_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Chapter7) &&
		is_Chapter(CHAPTER_Chapter8, enum_gameRegion)
	} else if (enum_chapter == CHAPTER_Chapter8_Ancestress){ return
		prev_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Chapter8_Ancestress) &&		
		is_Chapter(CHAPTER_Epilogue_Ancestress, enum_gameRegion)
	} else if (enum_chapter == CHAPTER_Chapter8_NoAncestress){ return
		prev_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Chapter8_NoAncestress) &&		
		is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_gameRegion)
	} else { return
		prev_ChapterID(enum_gameRegion) == get_ChapterID(enum_chapter) &&
		current_ChapterID(enum_gameRegion) == get_ChapterID(enum_chapter) + 0x1
	}}

function on_Chapter_change(enum_gameRegion) => 
	current_ChapterID(enum_gameRegion) != prev_ChapterID(enum_gameRegion)

function on_Chapter_changeTo(enum_chapter, enum_gameRegion) {
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			(
				prev_ChapterID(enum_gameRegion) != get_ChapterID(CHAPTER_Chapter8_Ancestress) && 
				current_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Chapter8_Ancestress)
			) || (
				prev_ChapterID(enum_gameRegion) != get_ChapterID(CHAPTER_Chapter8_NoAncestress) && 
				current_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Chapter8_NoAncestress)
			)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) { return
		(
			(
				prev_ChapterID(enum_gameRegion) != get_ChapterID(CHAPTER_Epilogue_Ancestress) && 
				current_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Epilogue_Ancestress)
			) || (
				prev_ChapterID(enum_gameRegion) != get_ChapterID(CHAPTER_Epilogue_NoAncestress) && 
				current_ChapterID(enum_gameRegion) == get_ChapterID(CHAPTER_Epilogue_NoAncestress)
			)
		)
	} else { return 
		prev_ChapterID(enum_gameRegion) != get_ChapterID(enum_chapter) &&
		current_ChapterID(enum_gameRegion) == get_ChapterID(enum_chapter)
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
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F034, GAMEREGION_JPN: 0xaa6b84},
		"itemScrollBarId": 0x0,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Cellphone: {
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F035, GAMEREGION_JPN: 0xaa6b85},
		"itemScrollBarId": 0x1,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_OrnamentalEgg: {
		"itemScrollBarId": 0x2,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F036, GAMEREGION_JPN: 0xaa6b86},
		"is_starterItem": false, "is_missableItem": true},
	// 0x3 --> empty entry (cut content??)
	ITEM_FryingPan: {
		"itemScrollBarId": 0x4,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F038, GAMEREGION_JPN: 0xaa6b88},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Sign: {
		"itemScrollBarId": 0x5,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F039, GAMEREGION_JPN: 0xaa6b89},
		"is_starterItem": false, "is_missableItem": true},	
	ITEM_Lighter: {
		"itemScrollBarId": 0x6,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03A, GAMEREGION_JPN: 0xaa6b8a},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_NoPerformer: {
		"itemScrollBarId": 0x7,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03B, GAMEREGION_JPN: 0xaa6b8b},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_WithPerformer: {	
		"itemScrollBarId": 0x8,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03C, GAMEREGION_JPN: 0xaa6b8c},	
		"is_starterItem": false, "is_missableItem": true},
	ITEM_PhilosopherStone: {
		"itemScrollBarId": 0x9,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03D, GAMEREGION_JPN: 0xaa6b8d},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_NewRope: {
		"itemScrollBarId": 0xa,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03E, GAMEREGION_JPN: 0xaa6b8e},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_OldRope: {
		"itemScrollBarId": 0xb,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F03F, GAMEREGION_JPN: 0xaa6b8f},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Jugglery: {
		"itemScrollBarId": 0xc,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F040, GAMEREGION_JPN: 0xaa6b90},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Comb: {
		"itemScrollBarId": 0xd,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F041, GAMEREGION_JPN: 0xaa6b91},
		"is_starterItem": false, "is_missableItem": false},	
	ITEM_AlchemyBook: {
		"itemScrollBarId": 0xe,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F042, GAMEREGION_JPN: 0xaa6b92},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_SquireCrest: {
		"itemScrollBarId": 0xf,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F043, GAMEREGION_JPN: 0xaa6b93},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_EggPocketWatch: {
		"itemScrollBarId": 0x10,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F044, GAMEREGION_JPN: 0xaa6b94},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Antidote: {
		"itemScrollBarId": 0x11,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F045, GAMEREGION_JPN: 0xaa6b95},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Meat: {
		"itemScrollBarId": 0x12,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F046, GAMEREGION_JPN: 0xaa6b96},
		"is_starterItem": false, "is_missableItem": false},	
	ITEM_Cake: {
		"itemScrollBarId": 0x13,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F047, GAMEREGION_JPN: 0xaa6b97},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_LabKey: {
		"itemScrollBarId": 0x14,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F048, GAMEREGION_JPN: 0xaa6b98},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_TowerKey: {
		"itemScrollBarId": 0x15,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F049, GAMEREGION_JPN: 0xaa6b99},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_LetterToDana: {
		"itemScrollBarId": 0x16,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F050, GAMEREGION_JPN: 0xaa6b9a},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Kitten: {
		"itemScrollBarId": 0x17,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04B, GAMEREGION_JPN: 0xaa6b9b},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Map: {
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04C, GAMEREGION_JPN: 0xaa6b9c},
		"itemScrollBarId": 0x18,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Ladder: {
		"itemScrollBarId": 0x19,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04D, GAMEREGION_JPN: 0xaa6b9d},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_OldMap: {
		"itemScrollBarId": 0x1a,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04E, GAMEREGION_JPN: 0xaa6b9e},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Notebook: {
		"itemScrollBarId": 0x1b,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04F, GAMEREGION_JPN: 0xaa6b9f},
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Postcard: {
		"itemScrollBarId": 0x1c,
		"memAddress_Flag_isInInventory": {GAMEREGION_USA: 0xA9F04A, GAMEREGION_JPN: 0xaa6ba0},
		"is_starterItem": true, "is_missableItem": false}}


function is_SelectedItemInScrollBar(enum_item, enum_gameRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "HighLightedInventoryItem", enum_gameRegion)) == const_Items_data[enum_item]["itemScrollBarId"] 

function is_ItemPresentInInventory(enum_item, enum_gameRegion) => 
	bit0(const_Items_data[enum_item]["memAddress_Flag_isInInventory"][enum_gameRegion]) == 1

// **********************
// ◦ BOTTOM SCREEN TEXT ◦
// **********************
// - The text at the bottom of the screen (subtitles & info in menu's) is printed on the screen via a transparent character set image, 
// 		which is masked to show only 1 character at a time. 
//		Functional with offset and different character sets (ex. latin, chinese) (more info refer to code notes @ 0xac31e8)
function is_BottomScreenTextId(int_id, enum_gameRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "BottomScreenTextID", enum_gameRegion)) == int_id
// -------------------------------------
function get_CharPrint_offset(int_charIndex) =>
	int_charIndex * memory_getDataStructSizeInBytes("Struct_CharacterPrintData")

function current_CharPrint_controlData(int_charIndex, enum_gameRegion) =>
	word(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "16Bit_ControlData"))

function current_CharPrint_height(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Height"))

function current_CharPrint_printXaxis(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Print_Xaxis"))
	
function current_CharPrint_printYaxis(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Print_Yaxis"))

function current_CharPrint_imageOffsetXaxis(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis"))
	
function current_CharPrint_imageOffsetYaxis(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Yaxis"))
	
function current_CharPrint_imageUnmaskWidth(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageUnmask_Width"))
	
function current_CharPrint_characterSetId(int_charIndex, enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_CharacterSetId"))

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

function is_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData, enum_gameRegion) => // index starts at 0
	current_CharPrint_height(int_charIndex) == dict_characterPrintData["height"] &&
	current_CharPrint_printXaxis(int_charIndex) == dict_characterPrintData["print_Xaxis"] &&
	dword_be(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis")) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
	current_CharPrint_characterSetId(int_charIndex) == dict_characterPrintData["characterSetId"]	

function was_CharacterOnBottomScreen_bis(int_charIndex, dict_characterPrintData) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex)) == dict_characterPrintData["print_Xaxis"] &&
	prior(current_CharPrint_printYaxis(int_charIndex)) == dict_characterPrintData["print_Yaxis"] &&
	prior(current_CharPrint_imageOffsetXaxis(int_charIndex)) == dict_characterPrintData["imageOffset_Xaxis"] &&
	prior(current_CharPrint_imageOffsetYaxis(int_charIndex)) == dict_characterPrintData["imageOffset_Yaxis"] &&
	prior(current_CharPrint_imageUnmaskWidth(int_charIndex)) == dict_characterPrintData["imageUnmask_Width"] &&
	prior(current_CharPrint_characterSetId(int_charIndex)) == dict_characterPrintData["characterSetId"]

function was_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData, enum_gameRegion) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex)) == dict_characterPrintData["print_Xaxis"] &&
	prior(dword_be(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_gameRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis"))) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
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
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_JPN)) +0x4,
				}},
			"WellCafeSonne": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_USA)) +0x5,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_JPN)) +0x5
				}},
			"Haupstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_USA)) +0x6,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_JPN)) +0x6
				}},
			"StairsRudolfstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_USA)) +0x7,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_JPN)) +0x7
				}},
			"AlleyWayBakery": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_USA)) +0x8,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", GAMEREGION_JPN)) +0x8
				}},
			},
		},
	TIMEPERIOD_Early20thCentury: {
		"amountToCollect": 6,
		"sharedArea": iNULL, // <-- 1 are not in area_city, so check each location seperate
		"locations": { 
			"InsideBrumMansion": {
				"area": [AREA_1900s_BrumMansion],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_BrumMansion", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_BrumMansion", GAMEREGION_JPN)) +0x4
				}},
			"TreeNearBar": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_JPN)) +0x4
				}},
			"StairsOppositeCafeSonne": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_USA)) +0x5,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_JPN)) +0x5
				}},
			"NearNewsPost": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_USA)) +0x6,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_JPN)) +0x6
				}},
			"ParkRudolfStr": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_USA)) +0x7,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_JPN)) +0x7
				}},
			"NorthEastgate": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_USA)) +0x8,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", GAMEREGION_JPN)) +0x8
				}},
			},
		},
	TIMEPERIOD_MiddleAges: {
		"amountToCollect": 6,
		"sharedArea": iNULL, // <-- 2 orbs are not in area_city, so check each location seperate
		"locations": {
			"AlchemistBasement": {
				"area": [AREA_MiddleAges_AlchemistHouse_Exploded_Basement],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_AlchemyLab", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_AlchemyLab", GAMEREGION_JPN)) +0x4
				}},
			"InsideChurch": {
				"area": [AREA_MiddleAges_Church],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_Church", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_Church", GAMEREGION_JPN)) +0x4
				}},
			"onBench": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_JPN)) +0x4
				}},
			"EastWell": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_USA)) +0x5,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_JPN)) +0x5
				}},
			"AlleyWayCart": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_USA)) +0x6,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_JPN)) +0x6
				}},
			"EastNearHay": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_USA)) +0x7,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_JPN)) +0x7
				}},
			"ChurchEntrance": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_USA)) +0x8,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", GAMEREGION_JPN)) +0x8
				}},
			},
		},
	TIMEPERIOD_Present: {
		"amountToCollect": 5,
		"sharedArea": [AREA_Present_City_Day, AREA_Present_City_NightAM, AREA_Present_City_NightPM], // <-- all orbs are in the area_city
		"locations": { 
			"OutsideFortuneTeller": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_USA)) +0x4,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_JPN)) +0x4
				}},
			"AlleyWay": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_USA)) +0x5,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_JPN)) +0x5
				}},
			"SouthGate": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_USA)) +0x6,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_JPN)) +0x6
				}},
			"UnderArchRuckagrastr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_USA)) +0x7,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_JPN)) +0x7
				}},
			"CarPark": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					GAMEREGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_USA)) +0x8,
					GAMEREGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", GAMEREGION_JPN)) +0x8
				}},
			}
		}
	}

function get_EnergyOrb_amountToCollect(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["amountToCollect"]

function get_EnergyOrb_Locations(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["locations"]

function get_EnergyOrb_sharedAreas(enum_timePeriod) =>
	const_EnergyOrbs_data[enum_timePeriod]["sharedArea"]

function get_EnergyOrb_Location_area(enum_timePeriod, string_locationKey) =>
	const_EnergyOrbs_data[enum_timePeriod]["locations"][string_locationKey]["area"]

function current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_gameRegion) =>
	bit0(const_EnergyOrbs_data[enum_timePeriod]["locations"][string_locationKey]["memAddr_Flag_isCollected"][enum_gameRegion])

function prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_gameRegion) =>
	prev(current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_gameRegion))

function on_EnergyOrb_Collect(enum_timePeriod, string_locationKey, enum_gameRegion) => 
	current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_gameRegion) > prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_gameRegion)
// -------------------------------------
function current_EnergyUnits(enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "EnergyUnits", enum_gameRegion))

function prev_EnergyUnits(enum_gameRegion) =>
	prev(current_EnergyUnits(enum_gameRegion))

function on_EnergyUnits_increment(enum_gameRegion) => 
	current_EnergyUnits(enum_gameRegion) > prev_EnergyUnits(enum_gameRegion)

function on_EnergyUnits_decrement(enum_gameRegion) => 
	current_EnergyUnits(enum_gameRegion) < prev_EnergyUnits(enum_gameRegion)

function on_EnergyUnits_valueChange(enum_gameRegion) => 
	current_EnergyUnits(enum_gameRegion) != prev_EnergyUnits(enum_gameRegion)

// ***********************
// ◦ MENU IDENTIFICATION ◦
// ***********************
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function is_ExtraMenu_active(enum_gameRegion) {	
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "ExtraMenuNavigation", enum_gameRegion))
	return
		dword(let_maskedPointer + 0x4) <= 0x4 &&
		dword(let_maskedPointer + 0x14) <= 0x5 &&
		dword(let_maskedPointer + 0x48) <= 0xb}

function is_EventViewer_active(enum_gameRegion) =>	
	dword(memory_getAddress(DATATYPE_32Bit, "IsEventViewerActive", enum_gameRegion)) == 0x21 && 
	is_ExtraMenu_active(enum_gameRegion)

function is_ResultsMenu_active(enum_gameRegion) => 	
	dword(memory_getAddress(DATATYPE_32Bit, "MenuID", enum_gameRegion)) == 0x16	&&
	is_ExtraMenu_active(enum_gameRegion)

function is_ResultsMenu_HighlightedChapter(enum_chapter) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "ExtraMenuNavigation", enum_gameRegion))
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
		is_ResultsMenu_active(enum_gameRegion) &&
		dword(let_maskedPointer + 0x48) == let_resultsMenuHighlightedChapterId}													
// -------------------------------------
function is_InGamePauseMenu_active(enum_gameRegion) {
	let_memAddr_IsInGamePauseMenuDisplayed = memory_getAddress(DATATYPE_BitFlag, "IsInGamePauseMenuDisplayed", enum_gameRegion)
	return 
		let_memAddr_IsInGamePauseMenuDisplayed == 1 &&
		let_memAddr_IsInGamePauseMenuDisplayed + 0x4 == 1}

function is_TitleMenu_active(enum_gameRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "MenuIdentification", enum_gameRegion)) == 0x11 &&	
	0x0 < byte(memory_getAddress(DATATYPE_8Bit, "HighlightedButtonAtTitleScreen", enum_gameRegion)) && 
	byte(memory_getAddress(DATATYPE_8Bit, "HighlightedButtonAtTitleScreen", enum_gameRegion)) < 0x5

function is_ChapterCompletionMenu_active(enum_gameRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "MenuIdentification", enum_gameRegion)) == 0x1 	&&
	dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_gameRegion)) == 0x21 &&	
	bit0(memory_getAddress(DATATYPE_32Bit, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_gameRegion)) == 1	

function is_Loading(enum_gameRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_gameRegion)) == 1

function on_ChapterCompletionMenu_render(enum_gameRegion) {	
	let_memAccessor_MenuIdentification = dword(memory_getAddress(DATATYPE_32Bit, "MenuIdentification", enum_gameRegion))
	let_memAccessor_IsChapterCompletionScreenActive = dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_gameRegion))
	let_memAccessor_IsChapterCompletionMenuDisplayed = bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_gameRegion))
	return 		
		let_memAccessor_MenuIdentification == 0x1  				&& prev(let_memAccessor_MenuIdentification) != 0x1 					&&
		let_memAccessor_IsChapterCompletionScreenActive == 0x21 && prev(let_memAccessor_IsChapterCompletionScreenActive) != 0x21 	&&
		let_memAccessor_IsChapterCompletionMenuDisplayed > prior(let_memAccessor_IsChapterCompletionMenuDisplayed)}

function on_ChapterCompletionMenu_exit(enum_gameRegion) {
	let_memAccessor_MenuIdentification = dword(memory_getAddress(DATATYPE_32Bit, "MenuIdentification", enum_gameRegion))
	let_memAccessor_IsChapterCompletionScreenActive = dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_gameRegion))
	let_memAccessor_IsChapterCompletionMenuDisplayed = bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_gameRegion))
	return
		let_memAccessor_MenuIdentification != 0x1 				&& prev(let_memAccessor_MenuIdentification) == 0x1 					&&
		let_memAccessor_IsChapterCompletionScreenActive != 0x21 && prev(let_memAccessor_IsChapterCompletionScreenActive) == 0x21 	&&
		let_memAccessor_IsChapterCompletionMenuDisplayed < prior(let_memAccessor_IsChapterCompletionMenuDisplayed)}
									
function is_InGame(enum_gameRegion) =>
	low4(memory_getAddress(DATATYPE_4Bit, "IsInGame", enum_gameRegion)) != 0

function on_TitleMenu_render(enum_gameRegion) { 
	let_memAccessor_IsInGame = low4(memory_getAddress(DATATYPE_4Bit, "IsInGame", enum_gameRegion))
	return
		let_memAccessor_IsInGame == 0 && 
		prev(let_memAccessor_IsInGame) > 0}

// ***************
// ◦ OTHER LOGIC ◦
// ***************
function is_GameBootedUp(enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "GameRegionIdentifier", enum_gameRegion))
	return 
		bit0(let_maskedPointer + 0x4) == 1}

function is_Video_active(enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_gameRegion))
	return 
		dword(let_maskedPointer + 0x18) == 0x101 &&	
		dword(let_maskedPointer + 0x2c) == 0x41}

function on_Video_end(enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_gameRegion))
	return
		prev(dword(let_maskedPointer + 0x18)) == 0x101 	&&
		dword(let_maskedPointer + 0x18)	!= 0x101		&&
		prev(dword(let_maskedPointer + 0x2c)) == 0x41 	&&
		dword(let_maskedPointer + 0x2c)	!= 0x41}

function on_Video_start(enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_gameRegion))
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
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x0,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x0, 
		}},
	ENDING_B : {
		"EndingFile_ID": 0x1,
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x1,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x1, 
		}},
	ENDING_C : {
		"EndingFile_ID": 0x2,
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x2,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x2, 
		}},
	ENDING_D : {
		"EndingFile_ID": 0x3,
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x3,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x3, 
		}},
	ENDING_E : {
		"EndingFile_ID": 0x4,
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x4,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x4, 
		}},
	ENDING_EX : {
		"EndingFile_ID": 0x5,
		"memAddr_Flag_EndingAchieved": {
			GAMEREGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_USA) + 0x5,
			GAMEREGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", GAMEREGION_JPN) + 0x5, 
		}}
	}

function get_EndingFileId(enum_ending) =>
	const_Endings_data[enum_ending]["EndingFile_ID"]

function is_Ending_achieved(enum_ending, enum_gameRegion) =>
	bit0(const_Endings_data[enum_ending]["memAddr_Flag_EndingAchieved"][enum_gameRegion]) == 1

function is_ExChapter_unlocked(enum_gameRegion) => // If endings ABCDE are achieved
	all_of(const_Endings_data, (enum_ending) {
		if (enum_ending != ENDING_EX) return is_Ending_achieved(enum_ending, enum_gameRegion)
		else return always_true()
	})

function is_ViewingEndingFile_viaExtraMenu(enum_ending, enum_gameRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EndingFileData", enum_gameRegion))					
	let_endingFileId = get_EndingFileId(enum_ending)
	return
		is_ExtraMenu_active(enum_gameRegion) &&
		byte(let_maskedPointer + 0x10) == let_endingFileId}

// ******************************
// ◦ CUTSCENE/CHOICES BIT FLAGS ◦
// ******************************
function is_PrologueExMode_active(enum_gameRegion) => 
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_ExChapter", enum_gameRegion)) == 1

// -------------- SquareTree ---------------
function is_TreeReplacedBy_Statue(enum_gameRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_gameRegion)) == 0

function is_TreeReplacedBy_Flowers(enum_gameRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_gameRegion)) == 1

function is_CrowdScaredWith_Cellphone(enum_gameRegion) => 	
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_gameRegion)) == 1	
	
function is_CrowdScaredWith_Lighter(enum_gameRegion) => 
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_gameRegion)) == 0	
// ------------ Movie --------------
function is_MovieWorldConquest_chosen(enum_gameRegion) => 
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_gameRegion)) == 1 &&
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_gameRegion)) == 0

function is_MovieTimeTravel_chosen(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_gameRegion)
	return bit6(let_memAddr) == 1 && bit5(let_memAddr) == 0}

function is_MovieFindCauseDeath_chosen(enum_gameRegion) =>
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_gameRegion)) == 0 &&
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_gameRegion)) == 1 

function is_MovieThriller_chosen(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_gameRegion)
	return bit1(let_memAddr) == 1 && bit2(let_memAddr) == 0}

function is_MovieLove_chosen(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_gameRegion) 
	return bit2(let_memAddr) == 1 && bit1(let_memAddr) == 0}

// ---------- Paintings ------------
function is_Painting_Antidote_inspired(enum_gameRegion) =>
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_gameRegion)) == 1	

function is_Painting_Marktplatz_inspired(enum_gameRegion) => 
	bit6(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_gameRegion)) == 1

function is_Painting_SquireCrest_inspired(enum_gameRegion) => 
	bit5(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_gameRegion)) == 1	
					
function is_Painting_TowerView_inspired(enum_gameRegion) => 
	bit4(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_gameRegion)) == 1

function is_Painting_Performer_inspired(enum_gameRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_2", enum_gameRegion)) == 1	

function is_Painting_HouseCollapse_inspired(enum_gameRegion) => 
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_2", enum_gameRegion)) == 1	
// ----------- BrumEstate ----------------
function is_BrumEstate_Museum(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_BrumEstateChoice", enum_gameRegion)
	return bit5(let_memAddr) == 0}

function is_BrumEstate_Library(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_BrumEstateChoice", enum_gameRegion)
	return bit5(let_memAddr) == 1} 

// -----------AncestorChoice--------------
function is_MargaretteTold_Ancestor(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_AncestorChoice_2", enum_gameRegion)
	return 	bit6(let_memAddr) == 1 && bit7(let_memAddr) == 0}

function is_MargaretteTold_NoAncestor(enum_gameRegion) {	
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_AncestorChoice_2", enum_gameRegion)
	return bit6(let_memAddr) == 0 && bit7(let_memAddr) == 1}

// ------------FireChapter1---------------
function is_FirePutOutBy_Barman(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter1", enum_gameRegion)
	return
		bit5(let_memAddr) == 0 &&
		bit7(let_memAddr) == 1	}

function is_FirePutOutBy_Eike(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter1", enum_gameRegion)
	return 
		bit5(let_memAddr) == 1 &&
		bit7(let_memAddr) == 0}	

// -----------DanaChoice----------------
function is_Dana_Saved_FromPast(enum_gameRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_SaveDanaFromPast", enum_gameRegion)
	return
		bit1(let_memAddr) == 1 && 
		bit3(let_memAddr) == 1 && 
		bit4(let_memAddr) == 1}

function is_Dana_Left_InPast(enum_gameRegion){
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_SaveDanaFromPast", enum_gameRegion)
	return
		bit1(let_memAddr) == 0 &&
		bit3(let_memAddr) == 0 &&
		bit4(let_memAddr) == 0}
	
// ----------Misc--------------
function is_CoffeePayed(enum_gameRegion) => 
	bit3(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MultiChapter_4", enum_gameRegion)) == 1

function is_KittenGivenToSibylla(enum_gameRegion) =>
	bit6(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MultiChapter_3", enum_gameRegion)) == 1

function is_WearingPerformerOutfit(enum_gameRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter4", enum_gameRegion)) == 1


// ***********************************
// ◦ ACHIEVEMENT PERCENTAGE BITFLAGS ◦
// ***********************************
// - Each flag corresponds to 1 cutscene and counts toward the achievement percentage
// - At end of a cutscene one of these flags will become true
// - Flags are grouped per chapter
// - These flags are loaded when loading a save OR when starting a new game whilst having played the game before
const_percentageBitsets = {
	CHAPTER_Prologue: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_USA) + 0x6, "bits": [0,5]},		
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", GAMEREGION_JPN) + 0x6, "bits": [0,5]},		
		]
	},
	CHAPTER_Chapter1: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_USA) + 0x0, "bits": [6,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_USA) + 0x3, "bits": [0,5]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_JPN) + 0x0, "bits": [6,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", GAMEREGION_JPN) + 0x3, "bits": [0,5]},
		]
	},
	CHAPTER_Chapter2: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_USA) + 0x0, "bits": [3,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_USA) + 0x4, "bits": [0,6]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_JPN) + 0x0, "bits": [3,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", GAMEREGION_JPN) + 0x4, "bits": [0,6]},
		]
	},
	CHAPTER_Chapter3: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
		]
	},
	CHAPTER_Chapter4: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_USA) + 0x4, "bits": [0,4]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", GAMEREGION_JPN) + 0x4, "bits": [0,4]},
		]
	},
	CHAPTER_Chapter5: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_USA) + 0x5, "bits": [0,6]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", GAMEREGION_JPN) + 0x5, "bits": [0,6]},
		]
	},
	CHAPTER_Chapter6: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_USA) + 0x4, "bits": [0,4]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", GAMEREGION_JPN) + 0x4, "bits": [0,4]},
		]
	},
	CHAPTER_Chapter7: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_USA) + 0x4, "bits": [0,3]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", GAMEREGION_JPN) + 0x4, "bits": [0,3]},
		]
	}, 
	CHAPTER_Chapter8: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x0, "bits": [5,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x6, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x7, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x8, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_USA) + 0x9, "bits": [0,3]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x0, "bits": [5,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x6, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x7, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x8, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", GAMEREGION_JPN) + 0x9, "bits": [0,3]},
		]
	}, 
	CHAPTER_Epilogue: {
		GAMEREGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_USA) + 0x3, "bits": [0]},
		],
		GAMEREGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", GAMEREGION_JPN) + 0x3, "bits": [0]},
		]
	}}
const_percentageBitflags_old = {
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
		
function memUtil_allPercentageBitsetsToOneArray(enum_gameRegion) {
	let_array_bitsets = []
	for chapterKey in const_percentageBitsets {
		for bitset in const_percentageBitsets[chapterKey][enum_gameRegion] {
			array_push(let_array_bitsets, bitset)
		}
	}
	return let_array_bitsets}

function memUtil_bitsetArrayToMemoryAccessorArray(array_bitsets) { // Return an array [bit0(0x00), bit1(0x00), bitcount(0x01)] from dict with percentagebitflags
	let_bitFlagMemoryAccessors = []	
	for bitset in array_bitsets {
		let_memAddr_bitset = bitset["memAddr"]
		let_array_BitsToCheck = bitset["bits"]
		if (length(let_array_BitsToCheck) == 1) {	// If only one bitflag on this memAddr => add only one memory accessor
			let_bitIndex = let_array_BitsToCheck[0]
			array_push(let_bitFlagMemoryAccessors, bit(let_bitIndex, let_memAddr_bitset))
		} else if ( // If all bits => add "bitcount" memory accessor
			(let_array_BitsToCheck[0] == 0 && let_array_BitsToCheck[1] == 7) || 
			(let_array_BitsToCheck[0] == 7 && let_array_BitsToCheck[1] == 0)) { 
				array_push(let_bitFlagMemoryAccessors, bitcount(let_memAddr_bitset))
		} else { // If not all bits, but more than 1 => memory accessor per bit flag
			let_step = 1
			if (let_array_BitsToCheck[0] > let_array_BitsToCheck[1]) let_step = -1
			for let_bitIndex in range(let_array_BitsToCheck[0], let_array_BitsToCheck[1], let_step) {	// Example let_array_BitsToCheck = [5,7]; this line [5,6,7]; let_bitIndex 1st loop = 5; let_bitIndex 2nd loop = 6; let_bitIndex 3rd loop = 7;
				array_push(let_bitFlagMemoryAccessors, bit(let_bitIndex, let_memAddr_bitset))
			}
		}
	}
	return let_bitFlagMemoryAccessors}
function memUtil_countTotalBitFlagsInBitsetArray(array_bitsets) { // Counts how many bitflags are in the dict with percentagebitflags
	let_bitFlagCount = 0
	for bitset in array_bitsets {
		let_array_BitsToCheck = bitset["bits"]
		if (length(let_array_BitsToCheck) == 1) {
			let_bitFlagCount = let_bitFlagCount + 1	
		} else if (let_array_BitsToCheck[0] > let_array_BitsToCheck[1]) {
			let_bitFlagCount = let_bitFlagCount + 1 + (let_array_BitsToCheck[0] - let_array_BitsToCheck[1])
		} else {
			let_bitFlagCount = let_bitFlagCount + 1 + (let_array_BitsToCheck[1] - let_array_BitsToCheck[0])
		}
	}
	return let_bitFlagCount}

function getTotalAchievementRate(enum_gameRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "AchievementPercentageNumber_Total", enum_gameRegion))

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
		"a_TimeEgoFlop": { // QA
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
function achievements_generate_FullTrigger_ChapterMaxAchievementRate(enum_chapter, enum_gameRegion) {
	// DEV_NOTE: Measure flag with "sum_of() == value" instead of a tally()
	// ----------------------------------
	// 	- This function generates a measure with no hit target. But uses Add Source flags generated with sum_of()
	//	- Example output of this function: measured((bit0(0xAA1178) + bit1(0xAA1178) + bit2(0xAA1178) + bit3(0xAA1178) + bit4(0xAA1178)) == 5
	//		-- In this case each bit would count for 20% or 1/5th
	let_array_bitsets = const_percentageBitsets[enum_chapter][enum_gameRegion]
	let_array_bitFlagMemoryAccessors = memUtil_bitsetArrayToMemoryAccessorArray(let_array_bitsets)
	let_int_bitFlagCount = memUtil_countTotalBitFlagsInBitsetArray(let_array_bitsets)

	let_expression_arithmeticSumOf = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => memoryAccessor)	// output example of sum_of(): [bit0(0x00), bit1(0x00), bitcount(0x01)] => bit0(0x00) + bit1(0x00) + bitcount(0x01)
	let_comparison_CurrentValues = let_expression_arithmeticSumOf == let_int_bitFlagCount // Example comparison stored in this variable: bit0(0x00) + bit1(0x00) + bitcount(0x01) == 4

	let_expression_arithmeticSumOf = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => prev(memoryAccessor))
	let_comparison_DeltaValues = let_expression_arithmeticSumOf < let_int_bitFlagCount 	// Example comparison stored in this variable: prev(bit0(0x00)) + prev(bit1(0x00)) + prev(bitcount(0x01)) < 4

	return 
		is_GameRegion(enum_gameRegion) &&
		let_comparison_DeltaValues && 
		measured(let_comparison_CurrentValues, when = is_Chapter(enum_chapter, enum_gameRegion) && is_InGame(enum_gameRegion), format = "percent")
	}

function achievements_generate_FullTrigger_TotalMaxAchievementRate(enum_gameRegion) {
	let_array_bitsets = memUtil_allPercentageBitsetsToOneArray(enum_gameRegion)
	let_array_bitFlagMemoryAccessors = memUtil_bitsetArrayToMemoryAccessorArray(let_array_bitsets)
	let_int_bitFlagCount = memUtil_countTotalBitFlagsInBitsetArray(let_array_bitsets)

	let_expression_arithmeticSumOf = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => memoryAccessor)	// output example of sum_of(): [bit0(0x00), bit1(0x00), bitcount(0x01)] => bit0(0x00) + bit1(0x00) + bitcount(0x01)
	let_comparison_CurrentValues = let_expression_arithmeticSumOf == let_int_bitFlagCount // Example comparison stored in this variable: bit0(0x00) + bit1(0x00) + bitcount(0x01) == 4

	let_expression_arithmeticSumOf = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => prev(memoryAccessor))
	let_comparison_DeltaValues = let_expression_arithmeticSumOf < let_int_bitFlagCount 	// Example comparison stored in this variable: prev(bit0(0x00)) + prev(bit1(0x00)) + prev(bitcount(0x01)) < 4

	return 
		is_GameRegion(enum_gameRegion) &&
		let_comparison_DeltaValues && 
		measured(let_comparison_CurrentValues, when = is_InGame(enum_gameRegion), format = "percent")}
function achievements_generate_FullTrigger_EnergyCollector(enum_timePeriod, enum_gameRegion) {
	function create_TallyComparisonArray(enum_timePeriod, enum_gameRegion) {
		let_tallyComparisonArray = []
		let_sharedArea = get_EnergyOrb_sharedAreas(enum_timePeriod)
		for let_OrbLocationKey in get_EnergyOrb_Locations(enum_timePeriod) {
			let_arrayAreaEnums = get_EnergyOrb_Location_area(enum_timePeriod, let_OrbLocationKey)
			if(let_sharedArea == iNULL && let_arrayAreaEnums == iNULL)
				util_throwError("At least one area must be given for energy orb: {0}", let_OrbLocationKey)			
			let_areaComparisonArray = [always_true()]
			if (let_arrayAreaEnums != iNULL && length(let_arrayAreaEnums) > 0) {
				for enum_area in let_arrayAreaEnums {
					array_push(let_areaComparisonArray, is_Area(enum_area, enum_gameRegion))
				}
			}
			let_areaComparison = any_of(let_areaComparisonArray, (comparison) => comparison)
			array_push(let_tallyComparisonArray, once(let_areaComparison && on_EnergyOrb_Collect(enum_timePeriod, let_OrbLocationKey, enum_gameRegion)))
		}
		return let_tallyComparisonArray}
	function create_Pause_WhenNotInSharedAreas(enum_timePeriod, enum_gameRegion) {		
		let_sharedAreas = get_EnergyOrb_sharedAreas(enum_timePeriod)
		let_pauseComparisonArray = []
		if(let_sharedAreas != iNULL && length(let_sharedAreas) > 0){
			for enum_area in let_sharedAreas {
				array_push(let_pauseComparisonArray, is_Area(enum_area, enum_gameRegion))
			}
		}
		if (length(let_pauseComparisonArray) == 0) { return 
			always_true()
		} else { return 
			unless(
				none_of(let_pauseComparisonArray, (comparison) => comparison)
			)
		}}
	return // WIP
		unless(is_Loading(enum_gameRegion)) &&
		create_Pause_WhenNotInSharedAreas(enum_timePeriod, enum_gameRegion) &&
		measured(
			tally(get_EnergyOrb_amountToCollect(enum_timePeriod), 
				create_TallyComparisonArray(enum_timePeriod, enum_gameRegion))
		) &&
		trigger_when(on_Cutscene_end(enum_gameRegion)) &&
		never_toAlt(
			!is_InGame(enum_gameRegion) ||
			on_Chapter_change(enum_gameRegion) ||
			on_EnergyUnits_decrement(enum_gameRegion)
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
		unless(!is_InGame(GAMEREGION_USA) && is_Loading()) &&
		create_Pause_WhenNotInSharedAreas(enum_timePeriod) &&
		measured(
			tally(get_EnergyOrb_amountToCollect(enum_timePeriod), 
				create_TallyComparisonArray(enum_timePeriod))
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))
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
			!is_LargeCutscene_active(GAMEREGION_USA)	// Don't switch with is_NoCutscene_active() --> FIXfor: picking up energy orb in chapter 3, when energy drained by Homunculus. The cutscene flag here doesn't turn to 0x0 , but turns to a small cutscene
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
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_Chapter(CHAPTER_Prologue, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => watching performer
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x22480, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x1bcd0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xe10, GAMEREGION_USA)
				) &&
				once(	// Identifies cutscene => shadow/killer walking behind Eike
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x90bc0, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x1ae70, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x75d10, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Prologue, GAMEREGION_USA)
			)
		)},
	"a_Chapter1Complete": function Chapter1Complete() { return
		never (	// Core group
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => burning bar changes into non-burning
					is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA) &&
					is_Cutscene_MasterId(0x11a40, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0xbea0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x5b80, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter1, GAMEREGION_USA)
			)
		)},
	"a_Chapter2Complete": function Chapter2Complete() { return
		never (	// Core group
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes
				unless(!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => reminiscing about Dana: left in the past					
					is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x3b240, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x340e0, GAMEREGION_USA)	&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x340e0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x7130, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => stopping to smoke + turning around to see flowers/statue
					is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x11240, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x2b0, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter2, GAMEREGION_USA)
			)
		)},
	"a_Chapter3Complete": function Chapter3Complete() { return
		never (	// Core group
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA)) &&			
				once(	// Identifies Cutscene => Time travel back to Brum Museum  
					is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x19d80, GAMEREGION_USA)		&&	
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA) 		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA) 		&&
					is_Cutscene_MasterDataId(0x82a0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x11ac0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Back to Eckart and breaking vase
					is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0xcfb40, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x19d80, GAMEREGION_USA) &&	
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA) 		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA) 		&&
					is_Cutscene_MasterDataId(0x39f0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x387a0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Back downstairs and talk to Homunculus
					is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x39680, GAMEREGION_USA)		&& was_Cutscene_MasterId(0xcfb40, GAMEREGION_USA) &&	
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA) 		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA) 		&&
					is_Cutscene_MasterDataId(0x7e10, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x7ca0, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter3, GAMEREGION_USA)
			)
		)},
	"a_Chapter4CompletePan": function Chapter4CompletePan() { return
		never(	// Core group
			!is_InGame(GAMEREGION_USA) 					||
			is_EventViewer_active(GAMEREGION_USA)			||
			on_Cutscene_MasterId_change(GAMEREGION_USA)	||
			!is_SelectedItemInScrollBar(ITEM_FryingPan, GAMEREGION_USA)
		) &&
		(
			( // Alt 1 
				unless(!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)) && 
				once(	// Identifies cutscene => protecting yourself with pan 
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x4f200, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x11cd0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x3d500, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || ( // Alt 2 
				once(	// Identifies cutscene => protecting yourself with pan AND having taken the picture in the performer outfit
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x54580, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x17060, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x1390, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 3; Failsafe
				on_Chapter_finish(CHAPTER_Chapter4, GAMEREGION_USA)
			)
		)},
	"a_Chapter4CompleteSign": function Chapter4CompletePan() { return
		never(	// Core group
			!is_InGame(GAMEREGION_USA) 					||
			is_EventViewer_active(GAMEREGION_USA)			||
			on_Cutscene_MasterId_change(GAMEREGION_USA)	||
			!is_SelectedItemInScrollBar(ITEM_Sign, GAMEREGION_USA)
		) &&
		(
			( // Alt 1 
				once(	// Identifies cutscene => protecting yourself with sign + info about photo from Homnunculus
					is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA) &&
					is_Cutscene_MasterId(0x54580, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0xd, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0xe, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0xb6e0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xae50, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2
				on_Chapter_finish(CHAPTER_Chapter4, GAMEREGION_USA)
			)
		)},
	"a_Chapter5Complete": function Chapter5Complete() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				once(	// Identifies Cutscene => drinking antidote
					is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA) &&
					is_SelectedItemInScrollBar(ITEM_Antidote, GAMEREGION_USA)	&&
					is_Cutscene_MasterId(0x3f980, GAMEREGION_USA)			&&
					is_Cutscene_SectionId_1(0xffff, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)			&&
					is_Cutscene_MasterDataId(0x3f980, GAMEREGION_USA)		&&
					is_Cutscene_SectionDataId(0x3f980, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter5, GAMEREGION_USA)
			)
		)},
	"a_Chapter6CompleteThriller": function Chapter6CompleteThriller() {	return
		// Core group
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		is_MovieTimeTravel_chosen(GAMEREGION_USA) &&
		is_MovieThriller_chosen(GAMEREGION_USA) 	&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					is_LargeCutscene_active(GAMEREGION_USA) && 
					is_Cutscene_MasterId(0x9db40, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x7, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x8, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x66600, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x20cd0, GAMEREGION_USA)
				) && 
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe
				on_Chapter_finish(CHAPTER_Chapter6, GAMEREGION_USA)
			)
		)},
	"a_Chapter6CompleteLove": function Chapter6CompleteLove() {	return
		// Core group
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		is_MovieTimeTravel_chosen(GAMEREGION_USA) &&
		is_MovieLove_chosen(GAMEREGION_USA) 		&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					is_LargeCutscene_active(GAMEREGION_USA) && 				
					is_Cutscene_MasterId(0x9db40, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x7, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x8, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x66600, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x20cd0, GAMEREGION_USA)
				) && 
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe
				on_Chapter_finish(CHAPTER_Chapter6, GAMEREGION_USA)
			)
		)},
	"a_Chapter7Complete": function Chapter7Complete() { return
		never (	// Core group
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	 (Also works when saving Miriam => Miriam is a counts as an extra in-between cutscene)			
				unless(!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Holding onto rope 
					is_LargeCutscene_active(GAMEREGION_USA)			&&
					is_Cutscene_MasterId(0x43040, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x7ce0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xd940, GAMEREGION_USA)
				) &&
				tally(1,[	// One of these is true, depending on ancestress or no ancestress choice
					once(	// Identifies Cutscene => Talking to Eckart, Ancestress path 
						is_LargeCutscene_active(GAMEREGION_USA)			&&
						is_MargaretteTold_Ancestor(GAMEREGION_USA) 		&&
						is_Cutscene_MasterId(0xc6800, GAMEREGION_USA)		&&
						is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
						is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
						is_Cutscene_MasterDataId(0x45720, GAMEREGION_USA)	&&
						is_Cutscene_SectionDataId(0x6ccd0, GAMEREGION_USA)),
					once(	// Identifies Cutscene => Talking to Eckart, No Ancestress path 
						is_LargeCutscene_active(GAMEREGION_USA)			&&
						is_MargaretteTold_NoAncestor(GAMEREGION_USA) 		&&
						is_Cutscene_MasterId(0xd1bc0, GAMEREGION_USA)		&&
						is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
						is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
						is_Cutscene_MasterDataId(0x48000, GAMEREGION_USA)	&&
						is_Cutscene_SectionDataId(0x5b190, GAMEREGION_USA))]
				) &&
				once(	// Identifies Cutscene => Looking at painting of Dana
					is_LargeCutscene_active(GAMEREGION_USA)			&&
					is_Cutscene_MasterId(0x12040, GAMEREGION_USA)	&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)	&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)	&&
					is_Cutscene_MasterDataId(0xce0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x11330, GAMEREGION_USA)
				) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				on_Chapter_finish(CHAPTER_Chapter7, GAMEREGION_USA)
			)
		)},
	"a_Chapter8Complete": function Chapter8Complete() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) && 
		(	
			(	// Alt 1 => Ending A (Talk to Fortune Teller AND Homunculus => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Talk to Homunculus
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0x8b640, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x2d440, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x42750, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Summon Dr. Wagner with Homunculus
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0x10ef00, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x9, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x8, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0xb620, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xf4d0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Dr. Wagner confronts Hugo
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0xe4800, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x9, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0xa, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x66aa0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x5d060, GAMEREGION_USA)
				) &&
				is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || 
			(	// Alt 2 => Ending B1 (Talk to Fortune Teller => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0xd5440, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x7, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x6, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x41550, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x2b420, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Hugo inside old Alchemist house collapsing
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0x716c0, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x9, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0xa, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x239f0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x19ef0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Eike consoling Margarette
					is_LargeCutscene_active(GAMEREGION_USA)				&&
					is_Cutscene_MasterId(0xf3c80, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x91c30, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x62030, GAMEREGION_USA)
				) &&
				is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 3 => Ending B2 (Talk to Homunculus => return to Hugo)
				unless(!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0xfbd00, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x5ff00, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x26f30, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0xc4e40, GAMEREGION_USA)		&& was_Cutscene_MasterId(0xfbd00, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x62650, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x6be0, GAMEREGION_USA)
				) &&
				is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 4 => Ending C (Visit destroyed lab => return to Hugo)
				once(	// Identifies Cutscene => Talk to Homunculus at square after seeing young Hugo erase old Hugo
					is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA) &&
					is_Cutscene_MasterId(0x1cbc0, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0xc8e0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x98f0, GAMEREGION_USA)
				) &&
				is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || (	// Alt 5 => Ending D (Did not save Dana => Destroyed Lab)
				unless(!is_Chapter(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Flashback to Hugo trying to read burnt documents
					is_LargeCutscene_active(GAMEREGION_USA)			&&
					is_Cutscene_MasterId(0x77a40, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x29700, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x31fd0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x45a10, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Eike confronts Hugo at square
					is_LargeCutscene_active(GAMEREGION_USA)			&&
					is_Cutscene_MasterId(0x4b140, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x77a40, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x122b0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x189f0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Margarette dissapears after Hugo dissappeared
					is_LargeCutscene_active(GAMEREGION_USA)			&&
					is_Cutscene_MasterId(0xc9440, GAMEREGION_USA)		&& was_Cutscene_MasterId(0xa00c0, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x46b50, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x828a0, GAMEREGION_USA)
				) &&
				is_Dana_Left_InPast(GAMEREGION_USA) && is_MargaretteTold_NoAncestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)				
			) || (	// Alt 6 => Ending E (Save Dana => Destroyed Lab)
				unless(!is_Chapter(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)) &&
				once(	// Identifies Cutscene => Brought Margarette to present
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x101bc0, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x77920, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x725d0, GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Margarette confronts Hugo in square
					is_LargeCutscene_active(GAMEREGION_USA) 			&& 
					is_Cutscene_MasterId(0x137500, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x101bc0, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0xc, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0xd, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x7bdf0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x55290, GAMEREGION_USA)
				) &&
				is_Dana_Saved_FromPast(GAMEREGION_USA) && is_MargaretteTold_NoAncestor(GAMEREGION_USA) &&
				on_Cutscene_end(GAMEREGION_USA)
			) || // Alt 7+8 => Failsafe; triggers on chapter change
			on_Chapter_finish(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA) ||
			on_Chapter_finish(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)
		)},
	"a_MaxAchievementPrologue": function MaxAchievementPrologue() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Prologue, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Prologue, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter1": function MaxAchievementChapter1() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter1, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter1, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter2": function MaxAchievementChapter2() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter2, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter2, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter3": function MaxAchievementChapter3() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter3, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter3, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter4": function MaxAchievementChapter4() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter4, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter4, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter5": function MaxAchievementChapter5() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter5, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter5, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter6": function MaxAchievementChapter6() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter6, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter6, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter7": function MaxAchievementChapter7() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter7, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter7, GAMEREGION_JPN)
		)},
	"a_MaxAchievementChapter8": function MaxAchievementChapter8() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter8, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter8, GAMEREGION_JPN)
		)},
	"a_MaxAchievementEpilogue": function MaxAchievementEpilogue() {	return 
		(
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Epilogue, GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Epilogue, GAMEREGION_JPN)
		)},
	"a_MaxAchievementTotal": function MaxAchievementTotal() { return 
		(
			achievements_generate_FullTrigger_TotalMaxAchievementRate(GAMEREGION_USA)
		) || (
			achievements_generate_FullTrigger_TotalMaxAchievementRate(GAMEREGION_JPN)
		)},
	"a_EndingA": function EndingA() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_A, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Chosen to have Margarette stay in present + Z-pad breaks
			is_LargeCutscene_active(GAMEREGION_USA) && !is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xdb780, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1bb0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x32ce0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Finding red jewel in tree at square
			is_LargeCutscene_active(GAMEREGION_USA) && !is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x77f80, GAMEREGION_USA)		&& was_Cutscene_MasterId(0xdb780, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x25c50, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x1ac90, GAMEREGION_USA)
		) &&		
		is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_A, GAMEREGION_USA))},
	"a_EndingB1": function EndingB1() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_B, GAMEREGION_USA)
		) &&

		// Below 2 cutscenes, are commented => player can quit and reload game between these cutscenes 
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus
		// 	is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
		// 	is_Cutscene_MasterId(0x3dd40, GAMEREGION_USA)		&&
		// 	is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
		// 	is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
		// 	is_Cutscene_MasterDataId(0x9d20, GAMEREGION_USA)	&&
		// 	is_Cutscene_SectionDataId(0x1ed10, GAMEREGION_USA)
		// ) &&
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus part2
		// 	is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
		// 	is_Cutscene_MasterId(0x81b00, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x3dd40, GAMEREGION_USA) &&
		// 	is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
		// 	is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
		// 	is_Cutscene_MasterDataId(0x250f0, GAMEREGION_USA)	&&
		// 	is_Cutscene_SectionDataId(0x13ff0, GAMEREGION_USA)
		// ) &&

		// Below 2 cutscenes run up to ending credits
		once(	// Identifies Cutscene => Eike returns from sending Margarette back to past
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x613c0, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x43db0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x1d5d0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x56240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x400d0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x16130, GAMEREGION_USA)
		) &&
		is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_B, GAMEREGION_USA))},
	"a_EndingB2": function EndingB2() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_B, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike talks with Homunculus
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x91240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x44340, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x41cd0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike gives z-pad back to Homunculus
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x5d2c0, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x91240, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1efd0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x2f6d0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x56240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x400d0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x16130, GAMEREGION_USA)
		) &&
		is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_B, GAMEREGION_USA))},
	"a_EndingC": function EndingC() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_C, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Giving z-pad back to Homunculus
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x8cf00, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x44340, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x41cd0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Homunculus has bad feeling
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x7b140, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x8cf00, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1d530, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x2f6d0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike getting roadkilled
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_Ancestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xcb700, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x7b140, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x6, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1980, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x1e8d0, GAMEREGION_USA)
		) &&
		is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_C, GAMEREGION_USA))},
	"a_EndingD": function EndingD() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_D, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Talk to Homunculus at square
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_NoAncestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x709c0, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x24770, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x11790, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and becomes youthfull
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_NoAncestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xc5b40, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x4, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x69b40, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x21b40, GAMEREGION_USA)
		) &&
		is_Dana_Left_InPast(GAMEREGION_USA) && is_MargaretteTold_NoAncestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_D, GAMEREGION_USA))},
	"a_EndingE": function EndingE() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_E, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_NoAncestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x88dc0, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x2c3a0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x5ca00, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and Dr. Wagner is killed
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_NoAncestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xbef80, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x9, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x8, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x59f60, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x155e0, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus some more
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue_NoAncestress, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xcdcc0, GAMEREGION_USA)		&& was_Cutscene_MasterId(0xbef80, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x33230, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x21780, GAMEREGION_USA)
		) &&
		is_Dana_Saved_FromPast(GAMEREGION_USA) && is_MargaretteTold_NoAncestor(GAMEREGION_USA) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_E, GAMEREGION_USA))},
	"a_EndingEXKillHomunculus": function KillHomunculus() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_EX, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => waking up in limbo with Philosopher Stone and destroy Homunculus
			is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_PhilosopherStone, GAMEREGION_USA) &&
			is_PrologueExMode_active(GAMEREGION_USA) &&	is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) &&
			is_ExChapter_unlocked(GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xa7a80, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x394f0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x41b0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x1413a0,0x8, GAMEREGION_USA)	&&			
			is_Cutscene_MinorId(0x41b0,0x28, GAMEREGION_USA)
		) && 
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) 			&&
			is_Cutscene_MasterId(0x67940, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xd220, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x5a6f0, GAMEREGION_USA)
		) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_EX, GAMEREGION_USA))},
	"a_EndingEXCureHelena": function CureHelena() { return
		never(
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			is_ViewingEndingFile_viaExtraMenu(ENDING_EX, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Helena Wagner is cured
			is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_PhilosopherStone, GAMEREGION_USA) &&
			is_PrologueExMode_active(GAMEREGION_USA) &&	is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) &&
			is_ExChapter_unlocked(GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x58c00, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x268f0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x11bc0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x721f0,0x8, GAMEREGION_USA)	&&			
			is_Cutscene_MinorId(0x11bc0,0x28, GAMEREGION_USA)
		) &&
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) 			&&
			is_Cutscene_MasterId(0x67940, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xd220, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x5a6f0, GAMEREGION_USA)
		) &&
		once(is_Video_active(GAMEREGION_USA)) &&	// Credits video
		trigger_when(
			on_Video_end(GAMEREGION_USA) &&		// Trigger when Credits video is over/skipped
			is_Ending_achieved(ENDING_EX, GAMEREGION_USA))},
	"a_EnergyOrbLocatorPresentDay": () =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Present, GAMEREGION_USA),
	"a_EnergyOrbLocator70s80s": () =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Late20thCentury, GAMEREGION_USA),
	"a_EnergyOrbLocatorMiddleAges": () =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_MiddleAges, GAMEREGION_USA),
	"a_EnergyOrbLocator1900Days": () =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Early20thCentury, GAMEREGION_USA),
	"a_ShowPocketWatchToPhotographer": function ShowPocketWatchFranssenAncestor() { return
		never (
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		never (
			!is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA) 				&& 
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA) 				&&
			!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA) 	&&
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Showing Franssen in 1902 the pocket watch
			is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_EggPocketWatch, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x114c0, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0xffff, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x114a0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x114a0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0xad50, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x114a0, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		never(
			!is_InGame(GAMEREGION_USA) 				||
			!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using frying pan
				is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_FryingPan, GAMEREGION_USA) &&
				is_Cutscene_MasterId(0xb0100, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_1(0xd, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0xe, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x1efb0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0xae70, GAMEREGION_USA)),
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using photo shop sign
				is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_Sign, GAMEREGION_USA) &&
				is_Cutscene_MasterId(0xb0100, GAMEREGION_USA)		&& 
				is_Cutscene_SectionId_1(0xd, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0xe, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x1eaa0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0xae70, GAMEREGION_USA))
		]) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_MeetOldMiriam": function MeetOldMiriam() { return 
		never(
			!is_InGame(GAMEREGION_USA) 				||
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Holding onto rope 
			is_LargeCutscene_active(GAMEREGION_USA) 			&& 
			is_Cutscene_MasterId(0x43040, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x7ce0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xd940, GAMEREGION_USA)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active(GAMEREGION_USA) && is_MargaretteTold_Ancestor(GAMEREGION_USA) && 
				is_Cutscene_MasterId(0xc7940, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x95c0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x7410, GAMEREGION_USA)),
			once(	// Identifies Cutscene => No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active(GAMEREGION_USA) && is_MargaretteTold_NoAncestor(GAMEREGION_USA) && 
				is_Cutscene_MasterId(0xb2540, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x95c0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x6cf0, GAMEREGION_USA))
		]) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_GetOrnamentalEgg": function AcquireOrnamentalEgg() { return
		never (
			!is_InGame(GAMEREGION_USA) 					||
			!is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA) 	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Acquiring ornamental egg from performer
			is_LargeCutscene_active(GAMEREGION_USA) 			&& 
			is_Cutscene_MasterId(0x19380, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xd5f0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xe10, GAMEREGION_USA)
		) &&
		trigger_when(is_ItemPresentInInventory(ITEM_OrnamentalEgg, GAMEREGION_USA) && on_Cutscene_end(GAMEREGION_USA))},
	"a_GetExChapterOrnamentalEgg": function GetExChapterOrnamentalEgg() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => EX Chapter, performer throws egg
			is_LargeCutscene_active(GAMEREGION_USA) &&
			is_PrologueExMode_active(GAMEREGION_USA) &&	is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) &&
			is_ExChapter_unlocked(GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x30780, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xd5f0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xe10, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x7fd10,0x8, GAMEREGION_USA)	&&			
			is_Cutscene_MinorId(0xe10,0x28, GAMEREGION_USA)
		) &&
		trigger_when(
			is_ItemPresentInInventory(ITEM_OrnamentalEgg, GAMEREGION_USA) && 
			is_NoCutscene_active(GAMEREGION_USA))},
	"a_AlertBarmanOfFire": function EggCollection() { return
		never (
			!is_InGame(GAMEREGION_USA) 					||
			!is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA) 	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Warning barman of fire 
			is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_OrnamentalEgg, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x32200, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x70e0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x24cb0, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EggCollection": function AlertBarmanOfFire() { return
		never (
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		never (
			!is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA) && 
			!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA) && 
			!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA) 
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 1 OR 4
				is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_OrnamentalEgg, GAMEREGION_USA) &&
				(is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA) || is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA))	&&
				is_Cutscene_MasterId(0x2f9c0, GAMEREGION_USA)		&& 
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x59c0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x5c20, GAMEREGION_USA)),
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 3
				is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_OrnamentalEgg, GAMEREGION_USA) &&
				is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA)		&&
				is_Cutscene_MasterId(0x32200, GAMEREGION_USA)		&& 
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x59c0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x5c20, GAMEREGION_USA))
		])
		 &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_RunningAcrossThe90s": function RunningAcrossThe90s() {
		function measuredComparison(enum_gameRegion) { return
			tally(2, [
				once( // Talk to JoggingMan_Present
					is_SmallCutscene_active(enum_gameRegion) &&
					(
						is_Area(AREA_Present_City_Day, enum_gameRegion) 	|| 
						is_Area(AREA_Present_City_NightPM, enum_gameRegion) ||
						is_Area(AREA_Present_City_NightAM, enum_gameRegion)
					) &&
					is_TalkingToNPC(NPC_Present_JoggingMan, enum_gameRegion)),
				once( // Talk to JoggingMan_80s
					is_SmallCutscene_active(enum_gameRegion) &&
					is_Area(AREA_70s_City_Night, enum_gameRegion) &&
					is_TalkingToNPC(NPC_80s_JoggingMan, enum_gameRegion)),
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) 		||
				!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA) && 
				!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA) && 
				!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_ShowEggTownPlanter": function ShowEggTownPlanter() { return 
		never (
			!is_InGame(GAMEREGION_USA) 				||
			!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA) 	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Show off egg to town planter
			is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_OrnamentalEgg, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xde00, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x3, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x29d0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xb400, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EggPocketWatchForCoffee": function IntroduceEggCollecting2() { return 
		never (
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			!is_ItemPresentInInventory(ITEM_EggPocketWatch, GAMEREGION_USA) ||
			!is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA) 				&& 
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA) 				&& 
			!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA) 	&& 
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Instantly pay for the coffee with egg shaped pocket watch
				is_LargeCutscene_active(GAMEREGION_USA) && is_Area(AREA_1900s_City, GAMEREGION_USA) && 
				is_Cutscene_MasterId(0x8b440, GAMEREGION_USA) 		&&
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x3b3a0, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x50080, GAMEREGION_USA)	&&
				is_Cutscene_MinorId(0xdefe0, 0x8, GAMEREGION_USA)	&&
				is_Cutscene_MinorId(0x50080, 0x28, GAMEREGION_USA)),
			once(	// Identifies Cutscene => Drank coffee before acquiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
				is_LargeCutscene_active(GAMEREGION_USA) && is_Area(AREA_1900s_City, GAMEREGION_USA) && 
				is_Cutscene_MasterId(0xac4c0, GAMEREGION_USA) 		&&
				is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x5ac20, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x51870, GAMEREGION_USA)	&&
				is_Cutscene_MinorId(0x7ec30, 0x8, GAMEREGION_USA)	&&
				is_Cutscene_MinorId(0x2f730, 0x2c, GAMEREGION_USA))
		]) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_PocketWatchCollection": function PocketWatch() { return 
		never (
			!is_InGame(GAMEREGION_USA) 			||
			is_EventViewer_active(GAMEREGION_USA)	||
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Show off egg pocket watch to barman in present
			is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_EggPocketWatch, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x8ce80, GAMEREGION_USA) 		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x4c600, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x236a0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x70640, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x236a0, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_PocketWatchReminiscing": function PocketWatchReminiscing() { return
		never (
			!is_InGame(GAMEREGION_USA) 					||
			is_EventViewer_active(GAMEREGION_USA)	||
			!is_Chapter(CHAPTER_Chapter8_Ancestress, GAMEREGION_USA) && 
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike and Eckart talk about film director and his pocket watches
			is_LargeCutscene_active(GAMEREGION_USA) && is_ItemPresentInInventory(ITEM_EggPocketWatch, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x8dcc0, GAMEREGION_USA) 		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x31a90, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xa420, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0xdfbc0, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0xa420, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EikeThePyromancer": function EikeThePyromancer() { return
		never (
			!is_InGame(GAMEREGION_USA) 						||
			!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into pyromancer statue
			is_TreeReplacedBy_Statue(GAMEREGION_USA) && is_CrowdScaredWith_Lighter(GAMEREGION_USA) &&			
			is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x3b240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x340e0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x7130, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_EikeTheMagician": function EikeTheMagician() { return
		never (
			!is_InGame(GAMEREGION_USA) 						||
			!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into magician statue
			is_TreeReplacedBy_Statue(GAMEREGION_USA) && is_CrowdScaredWith_Cellphone(GAMEREGION_USA) &&			
			is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x3b240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x340e0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x7130, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_EikeTheFlorist": function EikeTheFlorist() { return 
		never (
			!is_InGame(GAMEREGION_USA) 						||
			!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into flowers
			is_TreeReplacedBy_Flowers(GAMEREGION_USA) &&
			is_LargeCutscene_active(GAMEREGION_USA) && is_SelectedItemInScrollBar(ITEM_Dpad, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x3b240, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x340e0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x7130, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_BarmansChildren": function BarmansChildren() { return
		never (
			!is_InGame(GAMEREGION_USA) 						||
			!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Talk to barman about grandchildren
			is_LargeCutscene_active(GAMEREGION_USA) && 
			is_Cutscene_MasterId(0xd0200, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x3d290, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x92f30, GAMEREGION_USA)
		) &&
		on_CutsceneSection_end(GAMEREGION_USA)},
	"a_LostYoungCouple1": function LostYoungCouple1() {
		function measuredComparison(enum_gameRegion) { return
			tally(6, [
				once(	// 1st talk with woman
					is_SmallCutscene_active(enum_gameRegion) && // Below line --> When having talked to other half of couple already, this isLostYoungCoupleProgressChap2 would become 0x1 at same time on_NPC_TalkCount_hitsMax() counts
					(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) && 
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth", enum_gameRegion) &&	
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x420, enum_gameRegion)),
				once(	// 1st talk with man
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x40d, enum_gameRegion)),
				once( 	// 2nd talk with woman; is only available when having talked to both at least once
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x421, enum_gameRegion)),
				once(	// 2nd talk with man; is only available when having talked to both at least once
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x40e, enum_gameRegion)),
				once(	// 3rd talk with woman
					is_SmallCutscene_active(enum_gameRegion) &&
					is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x422, enum_gameRegion)),
				once(	// 3rd talk with man
					is_SmallCutscene_active(enum_gameRegion) &&
					is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x40f, enum_gameRegion))
			])}
		return 
			never(
				!is_InGame(GAMEREGION_USA) || 
				!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), is_Area(AREA_MiddleAges_City_Night, GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_LostYoungCouple2": function LostYoungCouple2() {
		function measuredComparison(enum_gameRegion) { return
			tally(6, [
				once(	// 1st talk with woman
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x423, enum_gameRegion)),
				once(	// 1st talk with man
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, GAMEREGION_USA) && is_InteractionId(0x410, GAMEREGION_USA)),
				once(	// 2nd talk with woman; only available when talking to both at least once
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, GAMEREGION_USA) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothTwice, GAMEREGION_USA)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x424, enum_gameRegion)),
				once(	// 2nd talk with man; only available when talking to both at least once
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion)) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x411, enum_gameRegion)),
				once(	// 3rd talk with woman
					is_SmallCutscene_active(enum_gameRegion) &&
					is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x425, enum_gameRegion)),
				once(	// 3rd talk with man
					is_SmallCutscene_active(enum_gameRegion) &&
					is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x412, enum_gameRegion))
			])}
		return 
			never(
				!is_InGame(GAMEREGION_USA) || 
				!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), is_Area(AREA_MiddleAges_City_Night, GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_LostYoungCouple3" : function LostYoungCouple3() {
		function measuredComparison(enum_gameRegion) { return
			tally(6, [
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x426, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToNone, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x413, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x427, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x414, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x428, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_gameRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_gameRegion)) &&	
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x415, enum_gameRegion))				
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), is_Area(AREA_MiddleAges_City_Night, GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_LostYoungCouple4": function LostYoungCouple4() {
		function measuredComparison(enum_gameRegion) { return
			tally(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap5_NearSouthEastGate"), 
				repeated(1,
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap5_NearSouthEastGate", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x416, enum_gameRegion))
			)}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), always_true()) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_LostYoungCouple5": function LostYoungCouple5() {
		function measuredComparison_NoAncestor(enum_gameRegion) { return
			tally(4, [
				repeated(2,	// NoAncestor path has less dialogue => count up 2, when at max talkCount => both measures are using same count (4)
					is_SmallCutscene_active(enum_gameRegion) && 
					is_MargaretteTold_NoAncestor(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare", enum_gameRegion) &&
					is_InteractionChapterId(0x3b, enum_gameRegion) && is_InteractionId(0x429, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan,"Chap7_OutsideChurch"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap7_OutsideChurch", enum_gameRegion) &&
					is_InteractionChapterId(0x3b, enum_gameRegion) && is_InteractionId(0x418, enum_gameRegion))
			])}
		function measuredComparison_Ancestor(enum_gameRegion) { return
			tally(4, [
				// once(	// 1st talk with woman		// Commented block FIXfor --> NPC_MiddleAges_YoungCoupleWoman-"Chap7_TownSquare" and NPC_MiddleAges_YoungCoupleWoman-"Chap4_OutsideChurch_AfterTalkingToBoth" use same MemAddrTalkCount
				// 	is_SmallCutscene_active(GAMEREGION_USA) &&
				// 	is_MargaretteTold_Ancestor(GAMEREGION_USA) &&
				// 	is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, GAMEREGION_USA) &&
				// 	on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare", GAMEREGION_USA) &&
				// 	is_InteractionChapterId(0x3b, GAMEREGION_USA) && is_InteractionId(0x428, GAMEREGION_USA)),
				repeated(2,	// 2nd talk with woman, with dialogue option		// repeated Fixfor --> mentioned above
					is_SmallCutscene_active(enum_gameRegion) &&
					is_MargaretteTold_Ancestor(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap7_TownSquare_Choice", enum_gameRegion) &&
					is_InteractionChapterId(0x3b, enum_gameRegion) && is_InteractionId(0x429, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan,"Chap7_OutsideChurch"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap7_OutsideChurch", enum_gameRegion) &&
					is_InteractionChapterId(0x3b, enum_gameRegion) && is_InteractionId(0x418, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)
			) &&
			(
				measured(measuredComparison_NoAncestor(GAMEREGION_USA), is_MargaretteTold_NoAncestor(GAMEREGION_USA)) || 
				measured(measuredComparison_Ancestor(GAMEREGION_USA), is_MargaretteTold_Ancestor(GAMEREGION_USA))
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_LostYoungCouple6": function LostYoungCouple6() {
		function measuredComparison(enum_gameRegion) { return
			tally(2, [
				once(	// 1st talk with man, having a dialogue option
					is_SmallCutscene_active(enum_gameRegion) &&
					is_WomanAdvisedBeTruthful(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap8_OutsideChurch_AfterExperiment_WomanTruthful", enum_gameRegion) &&
					is_InteractionChapterId(0x13, enum_gameRegion) && is_InteractionId(0x41c, enum_gameRegion)),
				once(	// 2nd talk with man after telling him about 'lovers never destines to meet'
						// There's no TalkCount for the dialogue that comes after the dialogue choice => count this one differently
					is_SmallCutscene_active(enum_gameRegion) &&		
					is_WomanAdvisedBeTruthful(enum_gameRegion) &&
					is_ManToldLoversNeverDestinedMeet(enum_gameRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_gameRegion) &&					
					is_InteractionChapterId(0x13, enum_gameRegion) && is_InteractionId(0x433, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter8, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), is_Area(AREA_MiddleAges_City_Day, GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EnigmaticCouple1": function EnigmaticCouple1() {
		function measuredComparison(enum_gameRegion) { return
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap1Prologue_TownSquare"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare", enum_gameRegion) &&
					is_InteractionId(0x2cc, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap1Prologue_NearBar"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap1Prologue_NearBar", enum_gameRegion) &&
					is_InteractionId(0x2c1, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Prologue, GAMEREGION_USA) && !is_Chapter(CHAPTER_Chapter1, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), always_true()) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EnigmaticCouple2": function EnigmaticCouple2() {
		function measuredComparison_onIncrease(enum_gameRegion) { return	// Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_gameRegion) &&
					is_InteractionId(0x2d0, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop", enum_gameRegion) &&
					is_InteractionId(0x2c4, enum_gameRegion))
			])}
		function measuredComparison_onMax(enum_gameRegion) { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_gameRegion) &&
					is_InteractionId(0x2d0, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop", enum_gameRegion) &&
					is_InteractionId(0x2c4, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA)
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(GAMEREGION_USA), always_true()) || measured(measuredComparison_onMax(GAMEREGION_USA), always_true())) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EnigmaticCouple3": function EnigmaticCouple3() {
		function measuredComparison_onIncrease(enum_gameRegion) { return // Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_gameRegion) &&
					is_InteractionId(0x2d0, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch", enum_gameRegion) &&
					is_InteractionId(0x2c5, enum_gameRegion))
			])}
		function measuredComparison_onMax(enum_gameRegion) { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_gameRegion) &&
					is_InteractionId(0x2d0, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch", enum_gameRegion) &&
					is_InteractionId(0x2c5, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(GAMEREGION_USA), always_true()) || measured(measuredComparison_onMax(GAMEREGION_USA), always_true())) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		function measuredComparison_BrumLibrary_onIncrease(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2d5, enum_gameRegion)),
				repeated(2, // --> overwrite of '''get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumLibrary")''', both measures must have same count
					is_SmallCutscene_active(enum_gameRegion) && is_BrumEstate_Library(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumLibrary", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2c9, enum_gameRegion))
			])}
		function measuredComparison_BrumLibrary_onMax(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2d5, enum_gameRegion)),
				repeated(2, // --> overwrite of 'get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumLibrary")', all measures must have same count
					is_SmallCutscene_active(enum_gameRegion) && is_BrumEstate_Library(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumLibrary", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2c9, enum_gameRegion))
			])}
		function measuredComparison_BrumMuseum_onIncrease(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2d5, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumMuseum"), 
					is_SmallCutscene_active(enum_gameRegion) && is_BrumEstate_Museum(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumMuseum", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2ca, enum_gameRegion))
			])}
		function measuredComparison_BrumMuseum_onMax(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap5_NearCafeSonne"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap5_NearCafeSonne", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2d5, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap5_NorthEastGate_BrumMuseum"), 
					is_SmallCutscene_active(enum_gameRegion) && is_BrumEstate_Museum(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap5_NorthEastGate_BrumMuseum", enum_gameRegion) &&
					is_InteractionChapterId(0x4b, enum_gameRegion) && is_InteractionId(0x2ca, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA)) &&
			(measured(measuredComparison_BrumMuseum_onIncrease(GAMEREGION_USA)) || measured(measuredComparison_BrumMuseum_onMax(GAMEREGION_USA)) ||
			measured(measuredComparison_BrumLibrary_onIncrease(GAMEREGION_USA)) || measured(measuredComparison_BrumLibrary_onMax(GAMEREGION_USA)))},
	"a_EnigmaticCouple5": function EnigmaticCouple5() {
		function measuredComparison_onIncrease(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && is_InteractionId(0x2d3, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && is_InteractionId(0x2c8, enum_gameRegion))
			])}
		function measuredComparison_onMax(enum_gameRegion) { return
			tally(3, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && is_InteractionId(0x2d3, enum_gameRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_gameRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && is_InteractionId(0x2c8, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) ||
				!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)
			) &&
			(measured(measuredComparison_onIncrease(GAMEREGION_USA), always_true()) || measured(measuredComparison_onMax(GAMEREGION_USA), always_true())) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_BecomeThePerformer": function BecomeThePerformer() {	return
		never(
			!is_InGame(GAMEREGION_USA)				||
			is_EventViewer_active(GAMEREGION_USA) 	||
			on_Cutscene_MasterId_change(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Eike gives himself a message as performer
			is_LargeCutscene_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA) &&
			is_SelectedItemInScrollBar(ITEM_Jugglery, GAMEREGION_USA) &&
			is_WearingPerformerOutfit(GAMEREGION_USA)			&&
			is_Cutscene_MasterId(0x1a300, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xd440, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x3a00, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_GiveMargaretteCake": function GiveMargaretteCake() { return 
		never(
			!is_InGame(GAMEREGION_USA)				||
			is_EventViewer_active(GAMEREGION_USA) 	||
			!is_SelectedItemInScrollBar(ITEM_Cake, GAMEREGION_USA)	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 1st time
			is_LargeCutscene_active(GAMEREGION_USA) 			&& 
			is_Cutscene_MasterId(0x10b000, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0xadb40, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x5d4a0, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_PerformerGoingExtraMile": function PerformerGoingExtraMile(){
		function measuredComparison(enum_gameRegion) { return
			tally(7, [
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeYoungBoy, enum_gameRegion) &&
					is_Area(AREA_Present_City_Day, enum_gameRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeYoungBoy, "Chap4_WearingPerformerOutfit", enum_gameRegion) &&
					is_InteractionChapterId(0x44, enum_gameRegion) && is_InteractionId(0x39c, enum_gameRegion)),	// IDs last dialogue sequence on this NPC's appearance
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteMother, enum_gameRegion) &&
					is_Area(AREA_Present_City_Day, enum_gameRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteMother, "Chap4_WearingPerformerOutfit", enum_gameRegion) &&
					is_InteractionChapterId(0x44, enum_gameRegion) && is_InteractionId(0x336, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteYoungGirl, enum_gameRegion) &&
					is_Area(AREA_Present_City_Day, enum_gameRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteYoungGirl, "Chap4_WearingPerformerOutfit", enum_gameRegion) &&
					is_InteractionChapterId(0x44, enum_gameRegion) && is_InteractionId(0x323, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeOldWomanOrangeSweater, enum_gameRegion) &&
					is_Area(AREA_Present_City_Day, enum_gameRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeOldWomanOrangeSweater, "Chap4_WearingPerformerOutfit", enum_gameRegion) &&
					is_InteractionChapterId(0x44, enum_gameRegion) && is_InteractionId(0x32c, enum_gameRegion)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteAdultManGlasses, enum_gameRegion) &&
					is_Area(AREA_Present_TownHall, enum_gameRegion) &&
					is_InteractionChapterId(0x29, enum_gameRegion) && is_InteractionId(0x3c6, enum_gameRegion)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active(enum_gameRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeElderlyWoman, enum_gameRegion) &&
					is_Area(AREA_Present_TownHall, enum_gameRegion) &&
					is_InteractionChapterId(0x29, enum_gameRegion) && is_InteractionId(0x3cc, enum_gameRegion)),
				once(	// This counts Eike, giving egg to Eike/yourself
					is_LargeCutscene_active(enum_gameRegion) &&
					is_SelectedItemInScrollBar(ITEM_Jugglery, enum_gameRegion) &&
					is_Cutscene_MasterId(0x1a300, enum_gameRegion)		&&
					is_Cutscene_SectionId_1(0x1, enum_gameRegion)		&&
					is_Cutscene_SectionId_2(0x0, enum_gameRegion)		&&
					is_Cutscene_MasterDataId(0xd440, enum_gameRegion)	&&
					is_Cutscene_SectionDataId(0x3a00, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) 					||
				!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)	||
				repeated(300, !is_WearingPerformerOutfit(GAMEREGION_USA))		// ---> Repeat is necessary, because bit flag for is_WearingPerformerOutfit() 
			) &&												// 		changes to 0 for a few frames when loading into townhall/city 
			measured(measuredComparison(GAMEREGION_USA), always_true()) &&	// 		=> we don't want to reset measure count here 
			trigger_when(on_Cutscene_end(GAMEREGION_USA) || on_CutsceneSection_end(GAMEREGION_USA))}, // Can only trigger after the cutscene when giving egg to past Eike
	"a_ScareEveryone": function ScareEveryone() {
		function measuredComparison(enum_gameRegion) { return
			tally(9, [
				once(	// Identifies cutscene => scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
					is_LargeCutscene_active(enum_gameRegion) && is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion) &&
					is_Cutscene_MasterId(0x9000, enum_gameRegion)		&&
					is_Cutscene_SectionId_1(0xffff, enum_gameRegion)	&&
					is_Cutscene_SectionId_2(0x0, enum_gameRegion)		&&
					is_Cutscene_MasterDataId(0x9000, enum_gameRegion)	&&
					is_Cutscene_SectionDataId(0x9000, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x5f80, 0x8, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x9000, 0x28, enum_gameRegion)),
				repeated(4,	// Identifies cutscene => scaring crowd with cellphone; Add counts +4, instead of below cutscene
					is_LargeCutscene_active(enum_gameRegion) && is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion) &&
					is_Cutscene_MasterId(0xc6e00, enum_gameRegion)		&&
					is_Cutscene_SectionId_1(0x1, enum_gameRegion)		&&
					is_Cutscene_SectionId_2(0x0, enum_gameRegion)		&&
					is_Cutscene_MasterDataId(0x5ad0, enum_gameRegion)	&&
					is_Cutscene_SectionDataId(0x55b0, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x2451a0, 0x8, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x55b0, 0x28, enum_gameRegion)),
				repeated(4,	// Identifies cutscene => scaring crowd with lighter; Add counts +4, instead of above cutscene
					is_LargeCutscene_active(enum_gameRegion) && is_SelectedItemInScrollBar(ITEM_Lighter, enum_gameRegion) &&
					is_Cutscene_MasterId(0xa84c0, enum_gameRegion)		&&
					is_Cutscene_SectionId_1(0x1, enum_gameRegion)		&&
					is_Cutscene_SectionId_2(0x0, enum_gameRegion)		&&
					is_Cutscene_MasterDataId(0x2e40, enum_gameRegion)	&&
					is_Cutscene_SectionDataId(0xb220, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x2354f0, 0x8, enum_gameRegion)	&&
					is_Cutscene_MinorId(0xb220, 0x28, enum_gameRegion)),
				once(	// Identifies cutscene => scaring town planter
					is_LargeCutscene_active(enum_gameRegion) && 
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_gameRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion)) &&
					is_Cutscene_MasterId(0x98c0, enum_gameRegion)		&&
					is_Cutscene_SectionId_1(0xffff, enum_gameRegion)	&&
					is_Cutscene_SectionId_2(0x0, enum_gameRegion)		&&
					is_Cutscene_MasterDataId(0x9890, enum_gameRegion)	&&
					is_Cutscene_SectionDataId(0x9890, enum_gameRegion)	&&
					is_Cutscene_MinorId(0xcd30, 0x8, enum_gameRegion)	&&
					is_Cutscene_MinorId(0x9890, 0x28, enum_gameRegion)),
				once(	// Identifies cutscene => scaring eccentric girl
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_gameRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_EccentricGirl, "Chap2_TownSquare_Scare", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x314, enum_gameRegion)),				
				once(	// Identifies cutscene => scaring straw hat man
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_gameRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_StrawHatMan, "Chap2_Streets_Scare", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x2da, enum_gameRegion)),
				once(	// Identifies cutscene => scaring aspiring apprentice
					is_SmallCutscene_active(enum_gameRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_gameRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_gameRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_AspiringApprentice, "Chap2_SouthEastGate_Scare", enum_gameRegion) &&
					is_InteractionChapterId(0x163, enum_gameRegion) && is_InteractionId(0x2e3, enum_gameRegion))
			])}
		return 
			never(	
				!is_InGame(GAMEREGION_USA) 	||
				!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)
			) &&
			(
				(	// Alt => vs. pause lock
					unless(
						!is_Area(AREA_MiddleAges_City_Night, GAMEREGION_USA) && !is_Area(AREA_Present_CafeSonne, GAMEREGION_USA)			
					) &&
					measured(measuredComparison(GAMEREGION_USA), is_InGame(GAMEREGION_USA) && is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA)) &&
					trigger_when(on_Cutscene_end(GAMEREGION_USA))
				) || (
					always_false()
				)
			)},
	"a_FreeMeal": function FreeMeal() { return
		never(
			!is_InGame(GAMEREGION_USA)						||
			is_EventViewer_active(GAMEREGION_USA) 			||
			!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)	||
			is_FirePutOutBy_Eike(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Barman gives us free meal
			is_LargeCutscene_active(GAMEREGION_USA) 			&& 
			is_Cutscene_MasterId(0x62840, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x261a0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x6cc0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x9bd60, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x6cc0, 0x28, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Reading book whilst barman get Eike his meal + poison
			is_LargeCutscene_active(GAMEREGION_USA) 			&& 
			is_Cutscene_MasterId(0xf9cc0, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x5eb0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xf3df0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x2aea60, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0xf3df0, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_NewCakeInvented": function NewCakeInvented() { return
		never(
			!is_InGame(GAMEREGION_USA)					||
			is_EventViewer_active(GAMEREGION_USA) 	||
			!is_SelectedItemInScrollBar(ITEM_Cake, GAMEREGION_USA)	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 2nd time
			is_LargeCutscene_active(GAMEREGION_USA) && 
			is_Cutscene_MasterId(0x1fd80, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0xffff, GAMEREGION_USA)	&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1fd50, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x1fd50, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x153d0, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x122b0, 0x2c, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_MaxInventory": function MaxInventory(){
		let_biggestPossibleInventoryCount = 20
		function previousItemCount(enum_gameRegion) =>
			sum_of(const_Items_data, (item) {	// sum_of(prevItemCount) == 19
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][enum_gameRegion]
				return prev(bit0(let_memAddress))
			})
		function currentItemCount(enum_gameRegion) => 
			sum_of(const_Items_data, (item) {	// sum_of(currentItemCount) == 20
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][enum_gameRegion]
				return bit0(let_memAddress)
			})
		function measuredComparison(int_tallyCount, enum_gameRegion) =>
			// Checks all item_in_inventory_flags => if in inventory => +1 Add hit
			tally_of(const_Items_data, int_tallyCount, (item) {
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][enum_gameRegion]
				return once(bit0(let_memAddress) == 1)
			})
		return 
			never(	
				is_TitleMenu_active(GAMEREGION_USA)	||
				is_EventViewer_active(GAMEREGION_USA)	||

				// Reset hit counts if any item is removed
				any_of(const_Items_data, (item) {
					let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][GAMEREGION_USA]
					return bit0(let_memAddress) < prev(bit0(let_memAddress))
				})
			) &&
			measured(measuredComparison(let_biggestPossibleInventoryCount, GAMEREGION_USA), always_true()) &&			
			once(
				previousItemCount(GAMEREGION_USA) < let_biggestPossibleInventoryCount &&
				currentItemCount(GAMEREGION_USA) == let_biggestPossibleInventoryCount
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))
		},		
	"a_DrunkenGuys": function DrunkenGuys(){
		function measuredComparison(enum_gameRegion) { return
			tally(2, [
				once(	// Identifies Cutscene => talking to slim delinquent
					is_SmallCutscene_active(enum_gameRegion) && 
					is_TalkingToNPC(NPC_Present_SlimDelinquent, enum_gameRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_SlimDelinquent, "Chap7_CarPark", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && 
					is_InteractionId(0x2f5, enum_gameRegion)),
				once(	// Identifies Cutscene => talking to broad delinquent
					is_SmallCutscene_active(enum_gameRegion) && 
					is_TalkingToNPC(NPC_Present_BroadDelinquent, enum_gameRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_BroadDelinquent, "Chap7_CarPark", enum_gameRegion) &&
					is_InteractionChapterId(0xb2, enum_gameRegion) && 
					is_InteractionId(0x2f0, enum_gameRegion))
			])}
		return 
			never(
				!is_Area(AREA_Present_City_NightPM, GAMEREGION_USA)
			) &&
			measured(measuredComparison(GAMEREGION_USA), when = is_InGame(GAMEREGION_USA)) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_ShortestChapter": function ShortestChapter(){ return
		never(
			!is_InGame(GAMEREGION_USA)						||
			!is_Chapter(CHAPTER_Chapter4, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA)				||
			!is_SelectedItemInScrollBar(ITEM_FryingPan, GAMEREGION_USA) ||
			
			// If preventing 1st death in chapter 4 by using the frying pan 
			//	=> black and white picture is not found inside book during this chapter
			//	=> Thus can be used as a flag for this achievement
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_NoPerformer, GAMEREGION_USA) 	|| 
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_WithPerformer, GAMEREGION_USA)			 
		) &&
		once(	// Identifies Cutscene => Using frying pan for defence
			is_LargeCutscene_active(GAMEREGION_USA) && 
			is_Cutscene_MasterId(0x4f200, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x11cd0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x3d500, GAMEREGION_USA)	
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_MeetFamousOleg": function MeetFamousOleg(){ return
		never(
			!is_InGame(GAMEREGION_USA)				||
			is_EventViewer_active(GAMEREGION_USA) 	||
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Talking to Oleg near movie poster
			is_LargeCutscene_active(GAMEREGION_USA) && is_CoffeePayed(GAMEREGION_USA) &&
			is_Cutscene_MasterId(0xa0f40, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x45370, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x5bb90, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x8f8e0, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x5bb90, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_ArtInspiration1": function ArtInspiration1() { return
		never(
			!is_InGame(GAMEREGION_USA) 		||
			on_Chapter_change(GAMEREGION_USA) ||
			is_BrumEstate_Library(GAMEREGION_USA)
		) && 
		tally(1, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
			once(
				is_SmallCutscene_active(GAMEREGION_USA) && 
				is_Painting_TowerView_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_TowerView, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, GAMEREGION_USA) || 
					is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, GAMEREGION_USA)
				) &&
				is_InteractionId(0x124, GAMEREGION_USA)),			
			once(
				is_SmallCutscene_active(GAMEREGION_USA) && 	
				is_Painting_SquireCrest_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_SquireCrest, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, GAMEREGION_USA) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, GAMEREGION_USA)
				) &&
				is_InteractionId(0x125, GAMEREGION_USA)),
			once(
				is_SmallCutscene_active(GAMEREGION_USA) &&
				is_Painting_Marktplatz_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_TownSquare, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, GAMEREGION_USA) ||
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, GAMEREGION_USA)
				) &&
				is_InteractionId(0x126, GAMEREGION_USA)),
			once(
				is_SmallCutscene_active(GAMEREGION_USA) &&
				is_Painting_Antidote_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, GAMEREGION_USA) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, GAMEREGION_USA)
				) &&	
				is_InteractionId(0x127, GAMEREGION_USA)),
			once(
				is_SmallCutscene_active(GAMEREGION_USA) &&
				is_Painting_Performer_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_Performer, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, GAMEREGION_USA) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, GAMEREGION_USA)
				) &&	
				is_InteractionId(0x128, GAMEREGION_USA)),
			once(
				is_SmallCutscene_active(GAMEREGION_USA) &&
				is_Painting_HouseCollapse_inspired(GAMEREGION_USA) &&
				is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, GAMEREGION_USA) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, GAMEREGION_USA) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, GAMEREGION_USA)
				) &&	
				is_InteractionId(0x129, GAMEREGION_USA))
		]) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},	// Trigger when cutscene is over
	"a_ArtInspirationAll": function ArtInspirationAll() {
		function measuredComparison(enum_gameRegion) {
			tally(6, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
				once(
					is_SmallCutscene_active(enum_gameRegion) && 
					is_Painting_TowerView_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TowerView, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x124, enum_gameRegion)),			
				once(
					is_SmallCutscene_active(enum_gameRegion) && 	
					is_Painting_SquireCrest_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x125, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_Painting_Marktplatz_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_gameRegion) ||
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x126, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_Painting_Antidote_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x127, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_Painting_Performer_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Performer, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x128, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_Painting_HouseCollapse_inspired(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x129, enum_gameRegion))
			])}
		return
			never(
				!is_InGame(GAMEREGION_USA) ||
				on_Chapter_change(GAMEREGION_USA)
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA)) &&
			measured(measuredComparison(GAMEREGION_USA), always_true())},
	"a_ArtAppreciator": function ArtAppreciator() {
		function measuredComparison(enum_gameRegion) {
			tally(8, [
				once(
					is_SmallCutscene_active(enum_gameRegion) && 	
					is_InteractingWith(INTERACTABLE_Painting_TowerView, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x124, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) && 	
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x125, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_gameRegion)
					) &&
					is_InteractionId(0x126, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x127, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Performer, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x128, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0x129, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_LandscapeTown, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0xffffffff, enum_gameRegion)),
				once(
					is_SmallCutscene_active(enum_gameRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Alchemist, enum_gameRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night, enum_gameRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day, enum_gameRegion)
					) &&	
					is_InteractionId(0xffffffff, enum_gameRegion))
			])}
		return
			never(
				!is_InGame(GAMEREGION_USA) ||
				on_Chapter_change(GAMEREGION_USA)
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA)) &&
			measured(measuredComparison(GAMEREGION_USA), always_true())},
	"a_AntiquesEule": function AntiquesEule() {
		function measuredComparison(enum_gameRegion) {
			tally(4, [
				once(
					is_SmallCutscene_active(GAMEREGION_USA) &&
					is_InteractingWith(INTERACTABLE_Antique_FranssenShopSign, enum_gameRegion) && 
					is_InteractionId(0xffffffff, enum_gameRegion)),
				once(
					is_SmallCutscene_active(GAMEREGION_USA) &&
					is_InteractingWith(INTERACTABLE_Antique_Rope, enum_gameRegion) &&
					is_InteractionId(0xffffffff, enum_gameRegion)),
				once(
					is_SmallCutscene_active(GAMEREGION_USA) &&
					is_InteractingWith(INTERACTABLE_Antique_Antidote, enum_gameRegion) &&
					is_InteractionId(0xffffffff, enum_gameRegion)),
				once(
					is_SmallCutscene_active(GAMEREGION_USA) &&
					is_InteractingWith(INTERACTABLE_Antique_Mask, enum_gameRegion) &&
					is_InteractionId(0xffffffff, enum_gameRegion))
			])}
		function measuredIfComparison(enum_gameRegion) { return
			is_Area(AREA_80s_AntiquesEule, enum_gameRegion) ||
			is_Area(AREA_Present_AntiquesEule, enum_gameRegion)}
		return
			never(
				!is_InGame(GAMEREGION_USA) ||
				on_Chapter_change(GAMEREGION_USA)
			) &&
			trigger_when(on_Cutscene_end(GAMEREGION_USA)) &&
			measured(measuredComparison(GAMEREGION_USA), measuredIfComparison(GAMEREGION_USA))},
	"a_SeenOlegAsWell": function SeenOlegAsWell() { return 
		never(
			!is_InGame(GAMEREGION_USA)				||
			is_EventViewer_active(GAMEREGION_USA) 	||
			!is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Talking with man inside Cafe Sonne for 1st time, only in chapter 6
			is_SmallCutscene_active(GAMEREGION_USA) && is_Area(AREA_80s_CafeSonne, GAMEREGION_USA) &&
			is_TalkingToNPC(NPC_80s_OlderMan, GAMEREGION_USA) && 
			is_InteractionChapterId(0xb2, GAMEREGION_USA) && is_InteractionId(0x3e7, GAMEREGION_USA) && 
			has_startedTalkingToNPC_forFirstTime(NPC_80s_OlderMan, "Chap6_CafeSonne", GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_PocketWatchTo80sBarman": function PocketWatchTo80sBarman() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Using pocket watch or ornamental egg near barman in 1980s
			is_SmallCutscene_active(GAMEREGION_USA) && is_Area(AREA_80s_Bar, GAMEREGION_USA) &&
			(
				is_SelectedItemInScrollBar(ITEM_EggPocketWatch, GAMEREGION_USA) ||
				is_SelectedItemInScrollBar(ITEM_OrnamentalEgg, GAMEREGION_USA)
			) &&
			is_TalkingToNPC(NPC_80s_Barman, GAMEREGION_USA) && is_InteractionId(0x2ed, GAMEREGION_USA) &&
			is_NPCtalkCount_atMax(NPC_80s_Barman, "InsideBar_UsePocketWatchOrEgg", GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_SnowyCrimeScene": function SnowyCrimeScene() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Miriam shot and dying 
			is_LargeCutscene_active(GAMEREGION_USA) && is_Area(AREA_80s_City_Snow, GAMEREGION_USA) &&
			is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA) 	&&
			is_Cutscene_MasterId(0x756c0, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x4660, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x4f210, GAMEREGION_USA) 	&&
			is_Cutscene_MinorId(0xb8b90, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x4f210, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_SaveMiriamBrum": function SaveMiriamBrum() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)			 
		) &&
		once(	// Identifies Cutscene => Eike save Miriam, after running after her
			is_LargeCutscene_active(GAMEREGION_USA) && is_Area(AREA_80s_City_Snow, GAMEREGION_USA) &&
			is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA)	&&
			is_Cutscene_MasterId(0xebac0, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x546f0, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x50b0, GAMEREGION_USA)	
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_HugoMotherChild": function HugoMotherChild() { return
		never(
			!is_InGame(GAMEREGION_USA)						||
			!is_Chapter(CHAPTER_Chapter5, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA) 
		) &&
		once(	// Identifies Cutscene => Hugo gets bullied
			is_LargeCutscene_active(GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x3ed00, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x3110, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x3bbc0, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x282ae0, 0x8, GAMEREGION_USA)	&&
			is_Cutscene_MinorId(0x3bbc0, 0x28, GAMEREGION_USA)
		) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
 	"a_TimeTravellingCat": function TimeTravellingCat() { return
		never(
			!is_InGame(GAMEREGION_USA) ||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Giving kitten to Sibylla
			is_LargeCutscene_active(GAMEREGION_USA) && is_Area(AREA_1900s_BrumMansion, GAMEREGION_USA) &&
			is_ItemPresentInInventory(ITEM_Kitten, GAMEREGION_USA) &&
			is_Cutscene_MasterId(0x25200, GAMEREGION_USA)		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x2c00, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x10930, GAMEREGION_USA)
		) &&
		is_KittenGivenToSibylla(GAMEREGION_USA) &&
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!is_InGame(GAMEREGION_USA)						||
			!is_Chapter(CHAPTER_Prologue, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA)  
		) &&
		(
			(
				unless(
					!is_LargeCutscene_active(GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Eike wakes himself up					
					is_Cutscene_MasterId(0x9c00, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x9bf0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x9bf0, GAMEREGION_USA)	&&
					is_Cutscene_MinorId(0x9bf0, 0x28, GAMEREGION_USA) 	&&
					is_Cutscene_MinorId(0xea70, 0x8, GAMEREGION_USA) 	
				) && 
				once(	// Identifies Cutscene => Eike wakes himself up
					is_Cutscene_MasterId(0x237c0, GAMEREGION_USA)		&& was_Cutscene_MasterId(0x9c00, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x18930, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xae60, GAMEREGION_USA)
				) && 
				trigger_when(on_CutsceneSection_end(GAMEREGION_USA))
			) || (
				always_false()
			)
		)},
	"a_ErasingEike2": function ErasingEike2() { return
		never(
			!is_InGame(GAMEREGION_USA)				||
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA)	||
			is_EventViewer_active(GAMEREGION_USA)  
		) &&
		once(	// Identifies Cutscene => Eike bumps into himself
			is_Cutscene_MinorId(0x23ee0, 0x8, GAMEREGION_USA) 	&&
			is_Cutscene_MinorId(0x377e0, 0x28, GAMEREGION_USA) 	&&
			is_Cutscene_MinorId(0x23eb0, 0x2c, GAMEREGION_USA)
		) && 
		trigger_when(on_Cutscene_end(GAMEREGION_USA))},
	"a_RottenRope": function RottenRope() { return
		never (
			!is_InGame(GAMEREGION_USA) 				||
			!is_Chapter(CHAPTER_Chapter7, GAMEREGION_USA) 	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Holding on to rotten rope
			is_LargeCutscene_active(GAMEREGION_USA)	&&
			is_Cutscene_MasterId(0x15640, GAMEREGION_USA) 		&&
			is_Cutscene_SectionId_1(0x5, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x6, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x7830, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x2220, GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Waking up in Limbo after death
			is_LargeCutscene_active(GAMEREGION_USA)	&&
			is_Cutscene_MasterId(0x237c0, GAMEREGION_USA) 		&& was_Cutscene_MasterId(0x15640, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x18930, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0xae60, GAMEREGION_USA)
		) &&
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_TimeEgoFlop": function TimeEgoFlop() { return
		never(
			!is_InGame(GAMEREGION_USA) 				||
			is_EventViewer_active(GAMEREGION_USA) 	|| 
			!is_Chapter(CHAPTER_Chapter6, GAMEREGION_USA)
		) &&
		once( // Identifies Cutscene => Roadkilled by Time Ego movie
				is_LargeCutscene_active(GAMEREGION_USA) 			&& 
				is_MovieTimeTravel_chosen(GAMEREGION_USA)			&&
				is_MovieWorldConquest_chosen(GAMEREGION_USA) 		&&				
				is_Cutscene_MasterId(0x77980, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_1(0xa, GAMEREGION_USA)		&&
				is_Cutscene_SectionId_2(0xb, GAMEREGION_USA)		&&
				is_Cutscene_MasterDataId(0x2090, GAMEREGION_USA)	&&
				is_Cutscene_SectionDataId(0x15d50, GAMEREGION_USA)
			) && 
			trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_MetYouBefore": function MetYouBefore() { return
		never(
			!is_InGame(GAMEREGION_USA)						||
			!is_Chapter(CHAPTER_Chapter2, GAMEREGION_USA) 	||
			is_EventViewer_active(GAMEREGION_USA)
		) &&
		once(	// Identifies Cutscene => Talk Dana, seeing through clothing hunch
			is_LargeCutscene_active(GAMEREGION_USA)			&&	
			is_Cutscene_MasterId(0x6e480, GAMEREGION_USA) 		&& 
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x45250, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x143f0, GAMEREGION_USA)	
		) && 
		once(	// Identifies Cutscene => Getting stabbed from behind
			is_LargeCutscene_active(GAMEREGION_USA)			&&	
			is_Cutscene_MasterId(0x1b740, GAMEREGION_USA) 		&& was_Cutscene_MasterId(0x6e480, GAMEREGION_USA) &&
			is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
			is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
			is_Cutscene_MasterDataId(0x1d00, GAMEREGION_USA)	&&
			is_Cutscene_SectionDataId(0x19a20, GAMEREGION_USA)	
		) && 
		trigger_when(on_CutsceneSection_end(GAMEREGION_USA))},
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return
		never(
			!is_InGame(GAMEREGION_USA)			||
			is_EventViewer_active(GAMEREGION_USA)	||
			!is_Chapter(CHAPTER_Chapter3, GAMEREGION_USA)
		) &&
		(
			(
				unless(
					!is_LargeCutscene_active(GAMEREGION_USA)
				) &&
				once(	// Identifies Cutscene => Picking dialogue option with Homunculus: 'excuse me'					
					is_Cutscene_MasterId(0xb140, GAMEREGION_USA) && was_Cutscene_MasterId(0x5aa80, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x2, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0x5ac0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0x38b0, GAMEREGION_USA)	
				) && 
				once(	// Identifies Cutscene => Waking up in limbo after dying to vase
					is_Cutscene_MasterId(0x1a440, GAMEREGION_USA) && was_Cutscene_MasterId(0xb140, GAMEREGION_USA) &&
					is_Cutscene_SectionId_1(0x1, GAMEREGION_USA)		&&
					is_Cutscene_SectionId_2(0x0, GAMEREGION_USA)		&&
					is_Cutscene_MasterDataId(0xd9a0, GAMEREGION_USA)	&&
					is_Cutscene_SectionDataId(0xca50, GAMEREGION_USA)	
				) &&
				trigger_when(on_CutsceneSection_end(GAMEREGION_USA))
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
function is_ChapterIdInRangeOfRecordedIds(enum_gameRegion) {
	return
		0 < current_ChapterID(enum_gameRegion) && 	// Prologue starts at 0x1
		current_ChapterID(enum_gameRegion) <= 0xb} 	// Epilogue ends at 0xb
function is_ChapterOneOf(array_chapterIds, enum_gameRegion) {
	any_of(array_chapterIds, (chapterId) => is_Chapter(chapterId, enum_gameRegion))}
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
// ************************** // TODO implement rich presence + leaderboards for JPN
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
		is_InGame(GAMEREGION_USA) && is_InGamePauseMenu_active(GAMEREGION_USA),
	"rp_InGameEXChapterOnly": () =>
		is_InGame(GAMEREGION_USA) && is_ChapterIdInRangeOfRecordedIds(GAMEREGION_USA) && 
		is_PrologueExMode_active(GAMEREGION_USA) && is_ExChapter_unlocked(GAMEREGION_USA) && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		is_Chapter(CHAPTER_Prologue, GAMEREGION_USA),
	"rp_InGameChapterOnly": () =>
		is_InGame(GAMEREGION_USA) && is_ChapterIdInRangeOfRecordedIds(GAMEREGION_USA) && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		!is_PrologueExMode_active(GAMEREGION_USA) && 
		is_ChapterOneOf([CHAPTER_Prologue, CHAPTER_Chapter1, CHAPTER_Epilogue], GAMEREGION_USA),
	"rp_InGameChapterWithTimePeriod": () { return
		is_InGame(GAMEREGION_USA) && is_ChapterIdInRangeOfRecordedIds(GAMEREGION_USA) && 
		// !is_InGamePauseMenu_active() &&	// <-- commented as long as rp_isPaused is disabled
		is_ChapterOneOf([
				CHAPTER_Chapter2, CHAPTER_Chapter3, 
				CHAPTER_Chapter4, CHAPTER_Chapter5, 
				CHAPTER_Chapter6, CHAPTER_Chapter7, CHAPTER_Chapter8
			], GAMEREGION_USA)},
	"rp_AtTitleScreen": () =>
		is_GameBootedUp(GAMEREGION_USA) && 
		(is_TitleMenu_active(GAMEREGION_USA) || !is_InGame(GAMEREGION_USA)),
	}
function richPresence_getCondition(string_displayKey) =>
	richPresence_conditions[string_displayKey]

function richPresence_condition_rp_AtTitleScreen(enum_gameRegion) { return
	is_GameBootedUp(enum_gameRegion) && 
	(is_TitleMenu_active(GAMEREGION_USA) || !is_InGame(GAMEREGION_USA))
}

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
		"Expression": current_ChapterID(GAMEREGION_USA),
		"LookupFallback": richPresence_getLookupTableText("rpp_Chapter", "LookupFallback")},
	"rpp_TimePeriod": {	
		"RPtype": richPresence_LOOKUP,
		"Expression": current_TimePeriod(GAMEREGION_USA),
		"LookupFallback": richPresence_getLookupTableText("rpp_TimePeriod", "LookupFallback")},
	"rpp_TotalCompletionRate": {
		"RPtype": richPresence_MACRO,
		"Expression": getTotalAchievementRate(GAMEREGION_USA),
		"MacroFormat": "Number"},
	"rpp_PresentTimeSeconds": {
		"RPtype": richPresence_MACRO,
		"Expression": current_DateTime_Seconds(DATETIME_Present, GAMEREGION_USA),
		"MacroFormat": "Number"},
	"rpp_PresentTimeMinutes": {	
		"RPtype": richPresence_MACRO,
		"Expression": current_DateTime_Minutes(DATETIME_Present, GAMEREGION_USA),
		"MacroFormat": "Number"},	
	"rpp_PresentTimeHourMinutes": {	
		"RPtype": richPresence_MACRO,
		"Expression": (current_DateTime_Minutes(DATETIME_Present, GAMEREGION_USA) + current_DateTime_Hours(DATETIME_Present, GAMEREGION_USA) * 60),
		"MacroFormat": "Minutes"},
	"rpp_PresentTimeHours": {	
		"RPtype": richPresence_MACRO,
		"Expression": current_DateTime_Hours(DATETIME_Present, GAMEREGION_USA),
		"MacroFormat": "Number"},
	"rpp_PresentTimeYears": {	
		"RPtype": richPresence_MACRO,
		"Expression": current_DateTime_Years(DATETIME_Present, GAMEREGION_USA),
		"MacroFormat": "Number"},
	"rpp_PresentTimeDays": {
		"RPtype": richPresence_MACRO,
		"Expression": current_DateTime_Days(DATETIME_Present, GAMEREGION_USA),
		"MacroFormat": "Number"},
	"rpp_FatedHour": {
		"RPtype": richPresence_LOOKUP,
		"Expression": current_ChapterID(GAMEREGION_USA),
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
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter7": { // VERIFIED 
		"id": 92202, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter6": { // VERIFIED 
		"id": 92201, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter5": { // VERIFIED 
		"id": 92200, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter4": { // VERIFIED 
		"id": 92199, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter3": { // VERIFIED 
		"id": 92198, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter2": { // VERIFIED 
		"id": 92197, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter1": { // VERIFIED 
		"id": 92196, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimePrologue": { // VERIFIED 
		"id": 92195, "isLowerBetter": true,
		"leaderboardValue": get_Timer_ChapterClearTime_InSeconds(GAMEREGION_USA),
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in prologue, excluding EX chapter"},
	"lb_TotalClearTime": { // VERIFIED 
		"id": 92194, "isLowerBetter": true,
		"leaderboardValue": get_Timer_TotalClearTime_InMinutes(GAMEREGION_USA),
		"leaderboardFormat": "MINUTES",
		"devInfo": "Best Total Clear Time, excluding EX chapter"}}

// ************************************
// ▴ Leaderboards TRIGGER GENERATORS ▴
// ************************************
//	- For leaderboard logic that's reoccuring across multiple triggers
function leaderboards_generate_ClearTimeChapter_StartTrigger(enum_chapter) {
	let_chapterSpecificComparison = always_true()
	if (enum_chapter == CHAPTER_Prologue) 
		let_chapterSpecificComparison = !is_PrologueExMode_active(GAMEREGION_USA)
	return 
		never(!is_InGame(GAMEREGION_USA)) &&
		once(on_Timer_ChapterClearTime_start(GAMEREGION_USA)) &&
		is_Chapter(enum_chapter, GAMEREGION_USA) &&
		repeated(700, is_InGame(GAMEREGION_USA)) &&	// <-- Delay FIX for bug when loading a save from chapter start, would start and cancel immediately
		let_chapterSpecificComparison}	//		+ better visual feedback to indicate minutes timer is for chapter clear time, 
										//			both Total and chapter clear time pop and same time otherwise
function leaderboards_generate_ClearTimeChapter_CancelTrigger(enum_chapter) {
	let_chapterSpecificComparison = always_false()
	if (enum_chapter == CHAPTER_Prologue)
		let_chapterSpecificComparison = is_PrologueExMode_active(GAMEREGION_USA)
	return 	
		!is_InGame(GAMEREGION_USA) 						|| 
		let_chapterSpecificComparison 		|| 
		on_Timer_ChapterClearTime_reset(GAMEREGION_USA) 	||
		!is_Chapter(enum_chapter, GAMEREGION_USA)}
function leaderboards_generate_ClearTimeChapter_SubmitTrigger(enum_chapter) =>
	on_ChapterCompletionMenu_render(GAMEREGION_USA) &&
	is_Chapter(enum_chapter, GAMEREGION_USA)

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
		never(!is_InGame(GAMEREGION_USA)) &&
		once(on_Timer_TotalClearTime_start(GAMEREGION_USA)) 	&&
		repeated(300, is_InGame(GAMEREGION_USA)) &&	// <-- delay popup 
		!is_PrologueExMode_active(GAMEREGION_USA)}
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
		!is_InGame(GAMEREGION_USA) || is_PrologueExMode_active(GAMEREGION_USA) || on_Timer_TotalClearTime_reset(GAMEREGION_USA)}
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
		is_InGame(GAMEREGION_USA) &&
		(
			(		// Alt 1 => Trigger when credits video starts
				on_Video_start(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue, GAMEREGION_USA)
			) || ( 	// Alt 2 => Trigger when timer has stopped for 20 frames during the credits video
				never(!on_Timer_TotalClearTime_valueChange(GAMEREGION_USA) && !is_Video_active(GAMEREGION_USA)) &&
				tally(20, 
					is_Video_active(GAMEREGION_USA) && is_Chapter(CHAPTER_Epilogue, GAMEREGION_USA) &&
					!on_Timer_TotalClearTime_valueChange(GAMEREGION_USA))
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
	memory_initialize()
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()