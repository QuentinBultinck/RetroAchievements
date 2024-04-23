// ********************************************************************* \\
//    █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█    █▀█ █▀▀    █▀▄ █▀▀ █▀ ▀█▀ █ █▄░█ █▄█   \\
//    ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀    █▄█ █▀░    █▄▀ ██▄ ▄█ ░█░ █ █░▀█ ░█░   \\
// ********************************************************************* \\
// #ID = 3945
// md5: 2991ecdb4d9a22dc40511b241bfb59a4 - USA
// md5: 6108f4877ff2755f9404e1aa79ca3ebb - JPN
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

// TODO if measured popups show at weird moments when it's not supposed to => try using measureIf or PauseIf the hide the popup => recheck where pause if vs measured if needed

util_isDebugModeActive = false	// if true => extra information may be displayed on achievement titles & descriptions
util_language = "en"	// ISO 639-1 language codes 

iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
sNULL = "-1"

RELEASE_REGION_USA = "NTSC-U/C"	// ULUS-10459 => PSP game identification code for USA release region
RELEASE_REGION_JPN = "NTSC-J"	// ULJM-05512 => PSP game identification code for JPN release region
RELEASE_REGION_EUR = "PAL"		// --> there's no EUR release for this game
RELEASE_REGIONS_SUPPORTED = [RELEASE_REGION_USA, RELEASE_REGION_JPN]

function util_throwError(string_errMsg) { // This function will throw an error in RATools because the key doesn't exist
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

// =============================
// • Memory STRUCT DEFINITIONS •
// =============================
memory_regionOffsets = {
	"Struct_NPCInteractionData": {
		"offset_USA_to_JPN": 0x7b50
	}}
function memory_getRegionOffset(string_structKey, string_offsetKey) =>
	memory_regionOffsets[string_structKey][string_offsetKey]
// -------------------------------------
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
	"Struct_NPCModelData": {
		"offsets": {
			"Float_xPos": 0x40,
			"Float_yPos": 0x48,
			"BitFlag_IsRunningAnimationActive": 0xAC
		}},
	}
function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_offsetKey) =>
	memory_dataStructures[string_structKey]["offsets"][string_offsetKey]
// ==========================
// • Memory ADDRESS STORAGE •
// ==========================
DATATYPE_BitFlag 				= 700
DATATYPE_4Bit 					= 600
DATATYPE_8Bit 					= 500
DATATYPE_16Bit 					= 400
DATATYPE_25BitPointer 			= 300
DATATYPE_Float					= 201
DATATYPE_32Bit 					= 200
DATATYPE_ASCII					= 150
DATATYPE_Struct 				= 100
memory_addresses = {
	//	"DATATYPE_xxxxx": {
	//		"Template": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	//	}
	DATATYPE_BitFlag: {
		"CurrentPlaythrough_ExChapter": {RELEASE_REGION_USA: 0xa9ed98, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68e8},
		"CurrentPlaythrough_Chapter1": {RELEASE_REGION_USA: 0xa9ed9d, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68ed},
		"CurrentPlaythrough_Chapter2": {RELEASE_REGION_USA: 0xa9eda0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68f0},
		"CurrentPlaythrough_Chapter4": {RELEASE_REGION_USA: 0xa9eda5, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68f5},
		"CurrentPlaythrough_AncestorChoice_1": {RELEASE_REGION_USA: 0xa9edad, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68fd},
		"CurrentPlaythrough_AncestorChoice_2": {RELEASE_REGION_USA: 0xa9edae, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68fe},
		"CurrentPlaythrough_MovieChoice_1": {RELEASE_REGION_USA: 0xa9edb7, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6907},
		"CurrentPlaythrough_MovieChoice_2": {RELEASE_REGION_USA: 0xa9edb8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6908},
		"CurrentPlaythrough_MultiChapter_1": {RELEASE_REGION_USA: 0xa9ed76, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68c6},
		"CurrentPlaythrough_MultiChapter_2": {RELEASE_REGION_USA: 0xa9edca, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa691a},
		"CurrentPlaythrough_MultiChapter_3": {RELEASE_REGION_USA: 0xa9edcb, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa691b},
		"CurrentPlaythrough_MultiChapter_4": {RELEASE_REGION_USA: 0xa9edcc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa691c},
		"CurrentPlaythrough_InspiredKarlFranssenArt_1": {RELEASE_REGION_USA: 0xa9edb0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6900},
		"CurrentPlaythrough_InspiredKarlFranssenArt_2": {RELEASE_REGION_USA: 0xa9edb1, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6901},
		"CurrentPlaythrough_BrumEstateChoice": {RELEASE_REGION_USA: 0xa9edaa, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68fa},
		"CurrentPlaythrough_DanaChoice": {RELEASE_REGION_USA: 0xa9edc0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6910},
		"CurrentPlaythrough_SaveDanaFromPast": {RELEASE_REGION_USA: 0xa9edc4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6914},
		"IsInGamePauseMenuDisplayed": {RELEASE_REGION_USA: 0xb91514, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xb99094},
		"IsLoading_OR_IsChapterCompletionMenuDisplayed": {RELEASE_REGION_USA: 0xa82e2c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa8a97c},
	},
	DATATYPE_4Bit: {
		"IsInGame": {RELEASE_REGION_USA: 0xa9eddc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa692c},
		"AlwaysNull_Or_ValueNeverChanges": {RELEASE_REGION_USA: 0x1fffff0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x1fffff0},
	},
	DATATYPE_8Bit: {
		"IsPlayerCharacterMoveable": {RELEASE_REGION_USA: 0x00a9eb2e, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x00aa667e},
		"YoungCoupleState_Chapter2": {RELEASE_REGION_USA: 0xa9ef89, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6ad9},
		"YoungCoupleState_Chapter3": {RELEASE_REGION_USA: 0xa9ef8a, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6ada},
		"YoungCoupleState_Chapter4": {RELEASE_REGION_USA: 0xa9ef8b, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6adb},
		"YoungCouple_Chapter7": {RELEASE_REGION_USA: 0xa9ef8e, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6ade},
		"YoungCouple_Chapter8": {RELEASE_REGION_USA: 0xa9ef8f, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6adf},
		"AchievementPercentageNumber_Total": {RELEASE_REGION_USA: 0xaa1152, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa8ca2},
		"HighlightedButtonAtTitleScreen": {RELEASE_REGION_USA: 0x1fff604, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x1fff604},
		"HighLightedInventoryItem": {RELEASE_REGION_USA: 0xa9f111, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6c61},
		"EnergyUnits": {RELEASE_REGION_USA: 0xa9daa8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa55f8},
		"IsCutsceneActive": {RELEASE_REGION_USA: 0xa9ed26, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6876},
		"ChapterID": {RELEASE_REGION_USA: 0xb95704, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xb9d284},
	},
	DATATYPE_16Bit: {
		"Cutscene_SectionID_1": {RELEASE_REGION_USA: 0xa9ecc0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6810},
		"Cutscene_SectionID_2": {RELEASE_REGION_USA: 0xa9ecc2, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6812},
	},
	DATATYPE_25BitPointer: {
		"LoadedNPCModel_JoggingMan1980": {RELEASE_REGION_USA: 0xa9dc24, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
		"InteractionID": {RELEASE_REGION_USA: 0xa9efe4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6b34},
		"InteractionChapterID": {RELEASE_REGION_USA: 0xa9efe0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6b30},
		"NPCinteractionID": {RELEASE_REGION_USA: 0xa9efdc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6b2c},
		"ExtraMenuNavigation": {RELEASE_REGION_USA: 0xac3170, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xacacb0},
		"EndingFileData": {RELEASE_REGION_USA: 0xac3178, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xacacb8},
		"Cutscene_MasterData": {RELEASE_REGION_USA: 0xa9ecc8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6818},
		"Cutscene_SectionData": {RELEASE_REGION_USA: 0xa9eccc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa681c},
		"Cutscene_MinorIDs": {RELEASE_REGION_USA: 0xa9ecd4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6824},
		"VideoData": {RELEASE_REGION_USA: 0x8ffef0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x8fbef0},
		"EnergyOrbs_Present_City": {RELEASE_REGION_USA: 0xa442ec, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450bc},
		"EnergyOrbs_Late20thCentury_City": {RELEASE_REGION_USA: 0xa442f0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450c0},
		"EnergyOrbs_Early20thCentury_City": {RELEASE_REGION_USA: 0xa442f4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450c4},
		"EnergyOrbs_Early20thCentury_BrumMansion": {RELEASE_REGION_USA: 0xa44304, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450d4},
		"EnergyOrbs_MiddleAges_City": {RELEASE_REGION_USA: 0xa442f8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450c8},
		"EnergyOrbs_MiddleAges_AlchemyLab": {RELEASE_REGION_USA: 0xa44300, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450d0},
		"EnergyOrbs_MiddleAges_Church": {RELEASE_REGION_USA: 0xa4430c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa450dc},
	},
	DATATYPE_Float: {
		"PlayerPosition_xAxis": {RELEASE_REGION_USA: 0xa8abd0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa92720},
		"PlayerPosition_yAxis": {RELEASE_REGION_USA: 0xa8abd8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa92728},
	},
	DATATYPE_32Bit: {
		"NPC_ID_copy": {RELEASE_REGION_USA: 0xa9eff4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6b44},
		"FrameCounter": {RELEASE_REGION_USA: 0xb88ab0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xb905f0},
		"Timer_ChapterClearTime": {RELEASE_REGION_USA: 0xaa155c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa90ac},
		"Timer_TotalClearTime": {RELEASE_REGION_USA: 0xaa1560, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa90b0},
		"BottomScreenTextID": {RELEASE_REGION_USA: 0xac31e4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xacad24},
		"VideoData": {RELEASE_REGION_USA: 0x8ffef0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x8fbef0},
		"IsChapterCompletionScreenActive": {RELEASE_REGION_USA: 0x1fff5f4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x1fff5f4}, // USA,JPN use same address
		"IsEventViewerActive": {RELEASE_REGION_USA: 0x1fff130, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x1fff130},
		"MenuID": {RELEASE_REGION_USA: 0x1fff5f8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0x1fff5f8}, // USA,JPN use same address
		"ExtraMenuState": {RELEASE_REGION_USA: 0xac49f4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xacc534},
		"Cutscene_Timer": {RELEASE_REGION_USA: 0xa9ecbc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6888},
		"Cutscene_MasterID": {RELEASE_REGION_USA: 0xa9ecbc, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa680c},
		"AreaID": {RELEASE_REGION_USA: 0xa82e48, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa8a998},
		"TimePeriod": {RELEASE_REGION_USA: 0xAA1268, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa8db8},
	},
	DATATYPE_ASCII: {
		"PSPgameID": {RELEASE_REGION_USA: 0xa5ab44, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xa64c74},
	},
	DATATYPE_Struct: {
		"CharacterPrintData_base": {RELEASE_REGION_USA: 0xac31e8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xacad28},
		"DateTime_Present": {RELEASE_REGION_USA: 0xAA12A4, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa8df4},
		"EndingData_base": {RELEASE_REGION_USA: 0xaa1154, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa8ca4},
		"AchievementPercentage_Prologue_base": {RELEASE_REGION_USA: 0xa9ed3c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa688c},
		"AchievementPercentage_Chapter1_base": {RELEASE_REGION_USA: 0xa9ed43, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6893},
		"AchievementPercentage_Chapter2_base": {RELEASE_REGION_USA: 0xa9ed47, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa6897},
		"AchievementPercentage_Chapter3_base": {RELEASE_REGION_USA: 0xa9ed58, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68a8},
		"AchievementPercentage_Chapter4_base": {RELEASE_REGION_USA: 0xa9ed4d, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa689d},
		"AchievementPercentage_Chapter5_base": {RELEASE_REGION_USA: 0xa9ed52, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68a2},
		"AchievementPercentage_Chapter6_base": {RELEASE_REGION_USA: 0xa9ed5b, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68ab},
		"AchievementPercentage_Chapter7_base": {RELEASE_REGION_USA: 0xa9ed60, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68b0},
		"AchievementPercentage_Chapter8_base": {RELEASE_REGION_USA: 0xa9ed65, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68b5},
		"AchievementPercentage_Epilogue_base": {RELEASE_REGION_USA: 0xa9ed71, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: 0xaa68c1},
	}}

function memory_getAddress(enum_dateType, string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[enum_dateType][string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}

// ==================
// • Memory UTILITY •
// ==================
function is_ReleaseRegion(enum_releaseRegion) {
	if(enum_releaseRegion == RELEASE_REGION_USA) {
		let_string_PSPgameId_USA = "ULUS10459"
		let_memAddr = memory_getAddress(DATATYPE_ASCII, "PSPgameID", RELEASE_REGION_USA)
		return ascii_string_equals(let_memAddr, let_string_PSPgameId_USA, length(let_string_PSPgameId_USA))
	} else if(enum_releaseRegion == RELEASE_REGION_JPN) {
		let_string_PSPgameId_JPN = "ULJM05512"
		let_memAddr = memory_getAddress(DATATYPE_ASCII, "PSPgameID", RELEASE_REGION_JPN)
		return ascii_string_equals(let_memAddr, let_string_PSPgameId_JPN, length(let_string_PSPgameId_JPN))
	} else {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	}}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
	// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
function memUtil_floatToInt(float_value, enum_releaseRegion) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", enum_releaseRegion))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

function memUtil_maskPointer(memAddr_ptr) =>
	dword(memAddr_ptr) & 0x1FFFFFF	// <-- 0x1FFFFFF: masks 32-bit value to 25-bit (PSP uses 25-bit pointers)

function never_toAlt(comparison) => // never_toAlt() => creates a single alt group for a 'Reset If' comparison
	(
		(
			never(comparison) &&
			always_false()	// <-- This line needs to be here so the other groups can still evaluate, else without this line, the other groups are infinitely on hold
							//		This signifies that this alt group only functions as a reset group, it can't trigger the achievement
		) || (
			always_false()
		)
	)

// ..............
// ◦ MODEL DATA ◦
// ''''''''''''''
PLAYERPOSITION_NEAR_THRESHOLD = 4000.0 // <-- 1.0, using a dot tells RAtools that this should be a datatype 'float'
function is_PlayerPosition_Xaxis_Near(float_value, enum_releaseRegion) {
	let_memAccessor_playerXpos = float(memory_getAddress(DATATYPE_Float, "PlayerPosition_xAxis", enum_releaseRegion))
	return
		float_value + PLAYERPOSITION_NEAR_THRESHOLD >= let_memAccessor_playerXpos &&	
		let_memAccessor_playerXpos >= float_value - PLAYERPOSITION_NEAR_THRESHOLD}

function is_PlayerPosition_Yaxis_Near(float_value, enum_releaseRegion) {
	let_memAccessor_playerYpos = float(memory_getAddress(DATATYPE_Float, "PlayerPosition_yAxis", enum_releaseRegion))
	return
		float_value + PLAYERPOSITION_NEAR_THRESHOLD >= let_memAccessor_playerYpos &&	
		let_memAccessor_playerYpos >= float_value - PLAYERPOSITION_NEAR_THRESHOLD}

// -------JoggingMan1980---------
function current_JoggingMan_Xpos(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "LoadedNPCModel_JoggingMan1980", enum_releaseRegion))
	return float(let_maskedPointer + memory_getDataStructOffset("Struct_NPCModelData", "Float_xPos"))}
	
function current_JoggingMan_Ypos(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "LoadedNPCModel_JoggingMan1980", enum_releaseRegion))
	return float(let_maskedPointer + memory_getDataStructOffset("Struct_NPCModelData", "Float_yPos"))}

function prev_JoggingMan_Xpos(enum_releaseRegion) =>
	prev(current_JoggingMan_Xpos(enum_releaseRegion))

function prev_JoggingMan_Ypos(enum_releaseRegion) =>
	prev(current_JoggingMan_Ypos(enum_releaseRegion))

function on_JoggingMan_Position_change(enum_releaseRegion) =>
	current_JoggingMan_Xpos(enum_releaseRegion) != prev_JoggingMan_Xpos(enum_releaseRegion) &&
	current_JoggingMan_Ypos(enum_releaseRegion) != prev_JoggingMan_Ypos(enum_releaseRegion)

function current_JoggingMan1980_RunningState(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "LoadedNPCModel_JoggingMan1980", enum_releaseRegion))
	return bit5(let_maskedPointer + memory_getDataStructOffset("Struct_NPCModelData", "BitFlag_IsRunningAnimationActive"))}

function prev_JoggingMan1980_RunningState(enum_releaseRegion) =>
	prev(current_JoggingMan1980_RunningState(enum_releaseRegion))

function is_JoggingMan_Running(enum_releaseRegion) =>
	current_JoggingMan1980_RunningState(enum_releaseRegion) == 1

function on_JoggingMan_startsRunning(enum_releaseRegion) =>
	current_JoggingMan1980_RunningState(enum_releaseRegion) == 1 &&
	prev_JoggingMan1980_RunningState(enum_releaseRegion) == 0


// .................
// ◦ TIME AND DATE ◦
// '''''''''''''''''
TIMEPERIOD_MiddleAges = 104
TIMEPERIOD_Early20thCentury = 103
TIMEPERIOD_Late20thCentury = 102
TIMEPERIOD_Present = 101
const_TimePeriod_IDs = {
	TIMEPERIOD_Present: {"IDs": [0x83]},
	TIMEPERIOD_Late20thCentury: {"IDs": [0x82,0x88]},
	TIMEPERIOD_Early20thCentury: {"IDs": [0x81]},
	TIMEPERIOD_MiddleAges:{"IDs": [0x80]}}

function current_TimePeriod(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "TimePeriod", enum_releaseRegion))

function get_TimePeriodIDs(enum_timePeriod, int_idIndex = 0) =>
	const_TimePeriod_IDs[enum_timePeriod]["IDs"][int_idIndex]

// -------------------------------------
DATETIME_Present = 100
const_DateTime_memAddr = { 
	DATETIME_Present: {
		RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "DateTime_Present", RELEASE_REGION_USA),
		RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "DateTime_Present", RELEASE_REGION_JPN),
	}}

function current_DateTime_Seconds(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Seconds"))

function current_DateTime_Minutes(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Minutes"))

function current_DateTime_Hours(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Hours"))

function current_DateTime_Days(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Days"))

function current_DateTime_Months(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Months"))

function current_DateTime_Years(enum_dateTime, enum_releaseRegion) =>
	dword(const_DateTime_memAddr[enum_dateTime][enum_releaseRegion] + memory_getDataStructOffset("Struct_DateTime","32Bit_Years"))
// .....................
// ◦ CLEAR TIME TIMERS ◦
// '''''''''''''''''''''
function current_ChapterClearTime(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "Timer_ChapterClearTime", enum_releaseRegion))
	
function prev_ChapterClearTime(enum_releaseRegion) =>
	prev(current_ChapterClearTime(enum_releaseRegion))

function get_Timer_ChapterClearTime_InSeconds(enum_releaseRegion) =>
	current_ChapterClearTime(enum_releaseRegion) / 60

function on_Timer_ChapterClearTime_start(enum_releaseRegion) => 
	prev_ChapterClearTime(enum_releaseRegion) == 0 &&
	current_ChapterClearTime(enum_releaseRegion) > 0

function on_Timer_ChapterClearTime_reset(enum_releaseRegion) =>
	current_ChapterClearTime(enum_releaseRegion) < prev_ChapterClearTime(enum_releaseRegion)
// -------------------------------------
function current_TotalClearTime(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "Timer_TotalClearTime", enum_releaseRegion))

function prev_TotalClearTime(enum_releaseRegion) =>
	prev(current_TotalClearTime(enum_releaseRegion))

function get_Timer_TotalClearTime_InMinutes(enum_releaseRegion) =>
	current_TotalClearTime(enum_releaseRegion) / 3600

function on_Timer_TotalClearTime_valueChange(enum_releaseRegion) => 
	current_TotalClearTime(enum_releaseRegion) != prev_TotalClearTime(enum_releaseRegion)

function on_Timer_TotalClearTime_start(enum_releaseRegion) => 
	prev_TotalClearTime(enum_releaseRegion) == 0 &&
	current_TotalClearTime(enum_releaseRegion) > 0

function on_Timer_TotalClearTime_reset(enum_releaseRegion) =>
	current_TotalClearTime(enum_releaseRegion) < prev_TotalClearTime(enum_releaseRegion)

// ................
// ◦ INTERACTIONS ◦
// ''''''''''''''''
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
const_NPCs_data = {
	// "xxxtemplatexxxx": { 
	// 	"ID": 0x00000, "Appearance": {
	// 		"xxxxxtemplatexxxxxxx": {"memAddr_TalkCount": {RELEASE_REGION_USA: 0x000000, RELEASE_REGION_JPN: xxx + 0x7b50}, "maxTalkCount": 0000}}},
	NPC_Present_BlondeYoungBoy: { 
		"ID": 0x187, "Appearance": {
			"Chap4_WearingPerformerOutfit": {
				"memAddr_TalkCount": {
						RELEASE_REGION_USA: 0xA9EEF8,
						RELEASE_REGION_JPN: () => 0xA9EEF8 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")},
				"maxTalkCount": 2}}},
	NPC_Present_BrunetteMother: { 
		"ID": 0x46,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE92,
					RELEASE_REGION_JPN: () => 0xA9EE92 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")},
				"maxTalkCount": 1}}},
	NPC_Present_BrunetteYoungGirl: { 
		"ID": 0x42,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE7F, 
					RELEASE_REGION_JPN: () => 0xA9EE7F + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_Present_BlondeOldWomanOrangeSweater: { 
		"ID": 0x44, "Appearance": {
			"Chap4_WearingPerformerOutfit": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE88, 
					RELEASE_REGION_JPN: () => 0xA9EE88 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_Present_BrunetteAdultManGlasses: { 
		"ID": 0x195, "Appearance": iNULL},
	NPC_Present_BlondeElderlyWoman: { 
		"ID": 0x183, "Appearance": iNULL},
	NPC_Present_BroadDelinquent: { 
		"ID": 0x10, "Appearance": {
			"Chap7_CarPark": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE4C, 
					RELEASE_REGION_JPN: () => 0xA9EE4C + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
		NPC_Present_SlimDelinquent: { 
		"ID": 0x13, "Appearance": {
			"Chap7_CarPark": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE51, 
					RELEASE_REGION_JPN: () => 0xA9EE51 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_Present_CoatedWoman: { 
		"ID": 0x57,	"Appearance": {
			"Chap1Prologue_TownSquare": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE28,
					RELEASE_REGION_JPN: () => 0xA9EE28 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar": { // <-- Chap3-4 use same memAddr as they use same dialogue
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE2C, 
					RELEASE_REGION_JPN: () => 0xA9EE2C + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2}, 
			"Chap5_NearCafeSonne_BeforeEatingAtBar": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xa9ee30, 
					RELEASE_REGION_JPN: () => 0xa9ee30 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap5_NearCafeSonne_AfterEatingAtBar": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE31, 
					RELEASE_REGION_JPN: () => 0xA9EE31 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap7_SouthGate": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE2F, 
					RELEASE_REGION_JPN: () => 0xA9EE2F + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2}}},
	NPC_Present_CoatedMan: { 
		"ID": 0x56, "Appearance": {
			"Chap1Prologue_NearBar": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE1D, 
					RELEASE_REGION_JPN: () => 0xA9EE1D + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap3_NearAntiqueShop": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE20, 
					RELEASE_REGION_JPN: () => 0xA9EE20 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap4_HaupStrUnderArch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE21, 
					RELEASE_REGION_JPN: () => 0xA9EE21 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap5_NorthEastGate_BeforeEatingAtBar": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xa9ee22, 
					RELEASE_REGION_JPN: () => 0xa9ee22 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap5_NorthEastGate_AfterEatingAtBar_BrumLibrary": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE25, 
					RELEASE_REGION_JPN: () => 0xA9EE25 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap5_NorthEastGate_AfterEatingAtBar_BrumMuseum": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE26, 
					RELEASE_REGION_JPN: () => 0xA9EE26 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap7_NorthWestGate": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE24, 
					RELEASE_REGION_JPN: () => 0xA9EE24 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_Present_JoggingMan: {
		"ID": 0x58, "Appearance": iNULL},
	NPC_80s_JoggingMan: {
		"ID": 0x59, "Appearance": iNULL},
	NPC_80s_Barman: { 
		"ID": 0xc, "Appearance": {
			"InsideBar_UsePocketWatchOrEgg": { // Counts for chap 6-7-8
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE49, 
					RELEASE_REGION_JPN: () => 0xA9EE49 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")},
				"maxTalkCount": 1}}},	
	NPC_80s_OlderMan: { 
		"ID": 0x18d, "Appearance": {
			"Chap6_CafeSonne": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF43, 
					RELEASE_REGION_JPN: () => 0xA9EF43 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2}}},	
	NPC_MiddleAges_StrawHatMan: { 
		"ID": 0x5c, "Appearance": {
			"Chap2_Streets_Scare": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE36, 
					RELEASE_REGION_JPN: () => 0xA9EE36 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_MiddleAges_YoungCoupleWoman: { 
		"ID": 0x197, "Appearance": {
			"Chap2_WestGate_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF7C,
					RELEASE_REGION_JPN: () => 0xA9EF7C + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap2_WestGate_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF7D,
					RELEASE_REGION_JPN: () => 0xA9EF7D + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap2_EastNearHay_AfterLocationSwitch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF7E, 
					RELEASE_REGION_JPN: () => 0xA9EF7E + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_NearNorthEastGate_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF7F, 
					RELEASE_REGION_JPN: () => 0xA9EF7F + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_NearNorthEastGate_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF80, 
					RELEASE_REGION_JPN: () => 0xA9EF80 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_OutsideChurch_AfterLocationSwitch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF81, 
					RELEASE_REGION_JPN: () => 0xA9EF81 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")},
				"maxTalkCount": 1},
			"Chap4_OutsideChurch_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF82, 
					RELEASE_REGION_JPN: () => 0xA9EF82 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap4_OutsideChurch_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF83, 
					RELEASE_REGION_JPN: () => 0xA9EF83 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},	
			"Chap4_NearBakery_AfterLocationSwitch": { //	WARNING => uses same MemAddrTalkCount as Chap7_TownSquare
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF84, 
					RELEASE_REGION_JPN: () => 0xA9EF84 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},	
			"Chap7_TownSquare": { //	WARNING => uses same MemAddrTalkCount as Chap4_OutsideChurch_AfterTalkingToBoth
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF84, 
					RELEASE_REGION_JPN: () => 0xA9EF84 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")},
				"maxTalkCount": 1},
			"Chap7_TownSquare_Choice": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF85, 
					RELEASE_REGION_JPN: () => 0xA9EF85 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2}}},
	NPC_MiddleAges_YoungCoupleMan: { 
		"ID": 0x198, "Appearance": {
			"Chap2_EastNearHay_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF69, 
					RELEASE_REGION_JPN: () => 0xA9EF69 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap2_EastNearHay_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6A, 
					RELEASE_REGION_JPN: () => 0xA9EF6A + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap2_WestGate_AfterLocationSwitch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6B, 
					RELEASE_REGION_JPN: () => 0xA9EF6B + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_NearWell_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6C, 
					RELEASE_REGION_JPN: () => 0xA9EF6C + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_NearWell_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6D, 
					RELEASE_REGION_JPN: () => 0xA9EF6D + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap3_TownSquare_AfterLocationSwitch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6E, 
					RELEASE_REGION_JPN: () => 0xA9EF6E + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap4_TownSquare_BeforeTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF6F,
					 RELEASE_REGION_JPN: () => 0xA9EF6F + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap4_TownSquare_AfterTalkingToBoth": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF70, 
					RELEASE_REGION_JPN: () => 0xA9EF70 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap4_NearBakery_AfterLocationSwitch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF71, 
					RELEASE_REGION_JPN: () => 0xA9EF71 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1},
			"Chap5_NearSouthEastGate": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF72, 
					RELEASE_REGION_JPN: () => 0xA9EF72 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap7_OutsideChurch": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF74, 
					RELEASE_REGION_JPN: () => 0xA9EF74 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 2},
			"Chap8_OutsideChurch_AfterExperiment_WomanTruthful": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EF78, 
					RELEASE_REGION_JPN: () => 0xA9EF78 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_MiddleAges_EccentricGirl: { 
		"ID": 0x2e, "Appearance": {
			"Chap2_TownSquare_Scare": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE70, 
					RELEASE_REGION_JPN: () => 0xA9EE70 + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}},
	NPC_MiddleAges_AspiringApprentice: {
		"ID": 0x5d, "Appearance": {
			"Chap2_SouthEastGate_Scare": {
				"memAddr_TalkCount": {
					RELEASE_REGION_USA: 0xA9EE3F, 
					RELEASE_REGION_JPN: () => 0xA9EE3F + memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")}, 
				"maxTalkCount": 1}}}
	}
function memory_initialize_NPCAppearances_releaseRegionJPN() { // This function is called in memory_initialize()
	let_offsetToJPN = memory_getRegionOffset("Struct_NPCInteractionData", "offset_USA_to_JPN")
	for NPCkey in const_NPCs_data {
		if (const_NPCs_data[NPCkey]["Appearance"] != iNULL) {
			for appearanceKey in const_NPCs_data[NPCkey]["Appearance"] {
				let_memAddr_USA = const_NPCs_data[NPCkey]["Appearance"][appearanceKey]["memAddr_TalkCount"][RELEASE_REGION_USA]
				const_NPCs_data[NPCkey]["Appearance"][appearanceKey]["memAddr_TalkCount"][RELEASE_REGION_JPN] = let_memAddr_USA + let_offsetToJPN
			}
		}
	}}

function get_NPC_Id(enum_npc) => 
	const_NPCs_data[enum_npc]["ID"]

function get_NPC_MaxTalkCount(enum_npc, string_appearance) => 
	const_NPCs_data[enum_npc]["Appearance"][string_appearance]["maxTalkCount"]

function current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) {
	let_memAddr = const_NPCs_data[enum_npc]["Appearance"][string_appearance]["memAddr_TalkCount"][enum_releaseRegion]
	if(let_memAddr == iNULL) util_throwError(format("NPC {0} for appearance {1} has no memAddr_TalkCount for region {2}", enum_npc, string_appearance, enum_releaseRegion))
	return byte(let_memAddr)}

function prior_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) =>
	prior(current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion))

function prev_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) =>
	prev(current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion))

function is_NPCtalkCount_atMax(enum_npc, string_appearance, enum_releaseRegion) => 
	current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) == get_NPC_MaxTalkCount(enum_npc, string_appearance)

function is_TalkingToNPC(enum_npc, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_releaseRegion))
	return 
		get_NPC_Id(enum_npc) == dword(let_maskedPointer)}

function is_TalkingToNPC_bis(enum_npc, enum_releaseRegion) { // This has an extra check when using is_TalkingToNPC() without is_InteractionId()
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_releaseRegion))
	let_npcID = get_NPC_Id(enum_npc)
	return 
		dword(let_maskedPointer) == let_npcID && 
		dword(memory_getAddress(DATATYPE_32Bit, "NPC_ID_copy", enum_releaseRegion)) == let_npcID}

function on_TalkingToNPC_bis(enum_npc, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_releaseRegion))
	let_npcID = get_NPC_Id(enum_npc)
	return 
		dword(let_maskedPointer) == let_npcID && 
		prev(dword(memory_getAddress(DATATYPE_32Bit, "NPC_ID_copy", enum_releaseRegion))) != let_npcID &&
		dword(memory_getAddress(DATATYPE_32Bit, "NPC_ID_copy", enum_releaseRegion)) == let_npcID}

function has_startedTalkingToNPC_forFirstTime(enum_npc, string_appearance, enum_releaseRegion) => 
	prior_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) < 0x1 &&
	current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) == 0x1

function on_NPC_TalkCount_hitsMax(enum_npc, string_appearance, enum_releaseRegion) {
	let_maxTalkCount = get_NPC_MaxTalkCount(enum_npc, string_appearance)
	return 
		prev_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) == let_maxTalkCount - 1 &&	
		current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion)  == let_maxTalkCount}

function on_NPC_TalkCount_increase(enum_npc, string_appearance, enum_releaseRegion) => 
	current_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion) > prev_NPCtalkCount(enum_npc, string_appearance, enum_releaseRegion)
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

function is_InteractingWith(enum_interactableItem, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "NPCinteractionID", enum_releaseRegion))
	return const_InteractableItem_IDs[enum_interactableItem] == dword(let_maskedPointer)}

function is_InteractionChapterId(int_id, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "InteractionChapterID", enum_releaseRegion))
	return dword(let_maskedPointer) == int_id}

function is_InteractionId(int_id, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "InteractionID", enum_releaseRegion))	
	return dword(let_maskedPointer) == int_id}
// -------------------------------------
STATE_YOUNGCOUPLE_talkedToNone = 0x0
STATE_YOUNGCOUPLE_talkedToBothOnce = 0x1
STATE_YOUNGCOUPLE_talkedToBothTwice = 0x2
STATE_YOUNGCOUPLE_bothHaveRespawned = 0x3
function is_LostYoungCoupleState_Chapter2(enum_stateYoungCouple, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter2", enum_releaseRegion)) == enum_stateYoungCouple	

function is_LostYoungCoupleState_Chapter3(enum_stateYoungCouple, enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter3", enum_releaseRegion)) == enum_stateYoungCouple	

function is_LostYoungCoupleState_Chapter4(enum_stateYoungCouple, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCoupleState_Chapter4", enum_releaseRegion)) == enum_stateYoungCouple	

function is_WomanAdvisedBeTruthful(enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "YoungCouple_Chapter7", enum_releaseRegion)) >= 0x1

function is_ManToldLoversNeverDestinedMeet(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_8Bit, "YoungCouple_Chapter8", enum_releaseRegion)
	return bit0(let_memAddr) == 1 && bit1(let_memAddr) ==0}

// ...........................
// ◦ CUTSCENE IDENTIFICATION ◦
// '''''''''''''''''''''''''''
function is_LargeCutscene_active(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_releaseRegion)) == 0x5

function is_SmallCutscene_active(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_releaseRegion)) == 0x1	

function is_NoCutscene_active(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_releaseRegion)) == 0

function on_Cutscene_end(enum_releaseRegion){
	let_memAccessor_isCutsceneActive =  byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_releaseRegion))
	return 
		prev(let_memAccessor_isCutsceneActive) > 0x0 &&
		let_memAccessor_isCutsceneActive == 0x0}

function on_CutsceneSection_end(enum_releaseRegion) {
	let_memAccessor_isCutsceneActive =  byte(memory_getAddress(DATATYPE_8Bit, "IsCutsceneActive", enum_releaseRegion))
	return 
		prev(let_memAccessor_isCutsceneActive) > 0x3 && 
		0x3 >= let_memAccessor_isCutsceneActive && let_memAccessor_isCutsceneActive > 0x0}

// -------------------------------------
function current_Cutsene_MasterId(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "Cutscene_MasterID", enum_releaseRegion))

function is_Cutscene_MasterId(int_id, enum_releaseRegion) => 
	current_Cutsene_MasterId(enum_releaseRegion) == int_id

function was_Cutscene_MasterId(int_id, enum_releaseRegion) => 
	prior(current_Cutsene_MasterId(enum_releaseRegion)) == int_id

function on_Cutscene_MasterId_change(enum_releaseRegion) => 
	prev(current_Cutsene_MasterId(enum_releaseRegion)) != current_Cutsene_MasterId(enum_releaseRegion)

function is_Cutscene_SectionId_1(int_id, enum_releaseRegion) => 
	word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_1", enum_releaseRegion)) == int_id

function is_Cutscene_SectionId_2(int_id, enum_releaseRegion) => 
	word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_2", enum_releaseRegion)) == int_id

function has_Cutscene_SectionId_started(enum_releaseRegion) {
	let_memAccessor_SectionID1 = word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_1", enum_releaseRegion))
	let_memAccessor_SectionID2 = word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_2", enum_releaseRegion))
	return 
		prior(let_memAccessor_SectionID1) == 0xffff && 
		let_memAccessor_SectionID1 == 0x1 &&
		let_memAccessor_SectionID2 == 0x0}

function on_Cutscene_SectionId_start(enum_releaseRegion) {
	let_memAccessor_SectionID1 = word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_1", enum_releaseRegion))
	let_memAccessor_SectionID2 = word(memory_getAddress(DATATYPE_16Bit, "Cutscene_SectionID_2", enum_releaseRegion))
	return 
		prev(let_memAccessor_SectionID1) != 0x1 && 
		let_memAccessor_SectionID1 == 0x1 &&
		let_memAccessor_SectionID2 == 0x0}

function is_Cutscene_MasterDataId(int_id, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_MasterData", enum_releaseRegion))
	return dword(let_maskedPointer + 0x8) == int_id}

function is_Cutscene_SectionDataId(int_id, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_SectionData", enum_releaseRegion))	
	return dword(let_maskedPointer + 0x8) == int_id}

function is_Cutscene_MinorId(int_id, int_offset, enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "Cutscene_MinorIDs", enum_releaseRegion))	
	return dword(let_maskedPointer + int_offset) == int_id}





// .......................
// ◦ AREA IDENTIFICATION ◦
// '''''''''''''''''''''''
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
	AREA_Present_City_NightPM: 0x3,
	AREA_Present_City_NightAM: 0x44,
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
function is_Area(enum_area, enum_releaseRegion) => 
	dword(memory_getAddress(DATATYPE_32Bit, "AreaID", enum_releaseRegion)) == const_Area_IDs[enum_area]	

function on_Area_change(enum_releaseRegion) {
	let_memAccessor = dword(memory_getAddress(DATATYPE_32Bit, "AreaID", enum_releaseRegion))
	return let_memAccessor != prev(let_memAccessor)}

// .................
// ◦ CHAPTER LOGIC ◦
// '''''''''''''''''
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

function current_ChapterID(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "ChapterID", enum_releaseRegion))

function prev_ChapterID(enum_releaseRegion) =>
	prev(current_ChapterID(enum_releaseRegion))

function is_Chapter(enum_chapter, enum_releaseRegion) {
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion) 	|| 
			is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) {	return
		(
			is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_releaseRegion) 	|| 
			is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
		)
	} else { return
		current_ChapterID(enum_releaseRegion) == get_ChapterID(enum_chapter)
	}}

function is_ChapterIdValid(enum_releaseRegion) => 
	0 < current_ChapterID(enum_releaseRegion) && 	// Prologue starts at 0x1
	current_ChapterID(enum_releaseRegion) <= 0xb 	// Epilogue ends at 0xb

function is_ChapterAnyOf(array_chapterEnums, enum_releaseRegion) =>
	any_of(array_chapterEnums, (enum_chapter) => is_Chapter(enum_chapter, enum_releaseRegion))

function is_ChapterNoneOf(array_chapterEnums, enum_releaseRegion) =>
	any_of(array_chapterEnums, (enum_chapter) => is_Chapter(enum_chapter, enum_releaseRegion))

function on_Chapter_finish(enum_chapter, enum_releaseRegion) {
	if (enum_chapter == CHAPTER_Chapter7) { return 
		prev_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Chapter7) &&
		is_Chapter(CHAPTER_Chapter8, enum_releaseRegion)
	} else if (enum_chapter == CHAPTER_Chapter8_Ancestress){ return
		prev_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Chapter8_Ancestress) &&		
		is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
	} else if (enum_chapter == CHAPTER_Chapter8_NoAncestress){ return
		prev_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Chapter8_NoAncestress) &&		
		is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_releaseRegion)
	} else { return
		prev_ChapterID(enum_releaseRegion) == get_ChapterID(enum_chapter) &&
		current_ChapterID(enum_releaseRegion) == get_ChapterID(enum_chapter) + 0x1
	}}

function on_Chapter_change(enum_releaseRegion) => 
	current_ChapterID(enum_releaseRegion) != prev_ChapterID(enum_releaseRegion)

function on_Chapter_changeTo(enum_chapter, enum_releaseRegion) {
	if (enum_chapter == CHAPTER_Chapter8) { return
		(
			(
				prev_ChapterID(enum_releaseRegion) != get_ChapterID(CHAPTER_Chapter8_Ancestress) && 
				current_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Chapter8_Ancestress)
			) || (
				prev_ChapterID(enum_releaseRegion) != get_ChapterID(CHAPTER_Chapter8_NoAncestress) && 
				current_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Chapter8_NoAncestress)
			)
		)
	} else if (enum_chapter == CHAPTER_Epilogue) { return
		(
			(
				prev_ChapterID(enum_releaseRegion) != get_ChapterID(CHAPTER_Epilogue_Ancestress) && 
				current_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Epilogue_Ancestress)
			) || (
				prev_ChapterID(enum_releaseRegion) != get_ChapterID(CHAPTER_Epilogue_NoAncestress) && 
				current_ChapterID(enum_releaseRegion) == get_ChapterID(CHAPTER_Epilogue_NoAncestress)
			)
		)
	} else { return 
		prev_ChapterID(enum_releaseRegion) != get_ChapterID(enum_chapter) &&
		current_ChapterID(enum_releaseRegion) == get_ChapterID(enum_chapter)
	}}

// ...................
// ◦ INVENTORY LOGIC ◦
// '''''''''''''''''''
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
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F034, RELEASE_REGION_JPN: 0xaa6b84},
		"itemScrollBarId": 0x0,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Cellphone: {
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F035, RELEASE_REGION_JPN: 0xaa6b85},
		"itemScrollBarId": 0x1,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_OrnamentalEgg: {
		"itemScrollBarId": 0x2,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F036, RELEASE_REGION_JPN: 0xaa6b86},
		"is_starterItem": false, "is_missableItem": true},
	// 0x3 --> empty entry (cut content??)
	ITEM_FryingPan: {
		"itemScrollBarId": 0x4,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F038, RELEASE_REGION_JPN: 0xaa6b88},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Sign: {
		"itemScrollBarId": 0x5,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F039, RELEASE_REGION_JPN: 0xaa6b89},
		"is_starterItem": false, "is_missableItem": true},	
	ITEM_Lighter: {
		"itemScrollBarId": 0x6,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03A, RELEASE_REGION_JPN: 0xaa6b8a},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_NoPerformer: {
		"itemScrollBarId": 0x7,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03B, RELEASE_REGION_JPN: 0xaa6b8b},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_BlackWhitePhoto_WithPerformer: {	
		"itemScrollBarId": 0x8,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03C, RELEASE_REGION_JPN: 0xaa6b8c},	
		"is_starterItem": false, "is_missableItem": true},
	ITEM_PhilosopherStone: {
		"itemScrollBarId": 0x9,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03D, RELEASE_REGION_JPN: 0xaa6b8d},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_NewRope: {
		"itemScrollBarId": 0xa,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03E, RELEASE_REGION_JPN: 0xaa6b8e},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_OldRope: {
		"itemScrollBarId": 0xb,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F03F, RELEASE_REGION_JPN: 0xaa6b8f},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Jugglery: {
		"itemScrollBarId": 0xc,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F040, RELEASE_REGION_JPN: 0xaa6b90},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Comb: {
		"itemScrollBarId": 0xd,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F041, RELEASE_REGION_JPN: 0xaa6b91},
		"is_starterItem": false, "is_missableItem": false},	
	ITEM_AlchemyBook: {
		"itemScrollBarId": 0xe,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F042, RELEASE_REGION_JPN: 0xaa6b92},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_SquireCrest: {
		"itemScrollBarId": 0xf,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F043, RELEASE_REGION_JPN: 0xaa6b93},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_EggPocketWatch: {
		"itemScrollBarId": 0x10,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F044, RELEASE_REGION_JPN: 0xaa6b94},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Antidote: {
		"itemScrollBarId": 0x11,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F045, RELEASE_REGION_JPN: 0xaa6b95},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Meat: {
		"itemScrollBarId": 0x12,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F046, RELEASE_REGION_JPN: 0xaa6b96},
		"is_starterItem": false, "is_missableItem": false},	
	ITEM_Cake: {
		"itemScrollBarId": 0x13,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F047, RELEASE_REGION_JPN: 0xaa6b97},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_LabKey: {
		"itemScrollBarId": 0x14,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F048, RELEASE_REGION_JPN: 0xaa6b98},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_TowerKey: {
		"itemScrollBarId": 0x15,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F049, RELEASE_REGION_JPN: 0xaa6b99},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_LetterToDana: {
		"itemScrollBarId": 0x16,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F050, RELEASE_REGION_JPN: 0xaa6b9a},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_Kitten: {
		"itemScrollBarId": 0x17,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04B, RELEASE_REGION_JPN: 0xaa6b9b},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Map: {
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04C, RELEASE_REGION_JPN: 0xaa6b9c},
		"itemScrollBarId": 0x18,
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Ladder: {
		"itemScrollBarId": 0x19,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04D, RELEASE_REGION_JPN: 0xaa6b9d},
		"is_starterItem": false, "is_missableItem": false},
	ITEM_OldMap: {
		"itemScrollBarId": 0x1a,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04E, RELEASE_REGION_JPN: 0xaa6b9e},
		"is_starterItem": false, "is_missableItem": true},
	ITEM_Notebook: {
		"itemScrollBarId": 0x1b,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04F, RELEASE_REGION_JPN: 0xaa6b9f},
		"is_starterItem": true, "is_missableItem": false},
	ITEM_Postcard: {
		"itemScrollBarId": 0x1c,
		"memAddress_Flag_isInInventory": {RELEASE_REGION_USA: 0xA9F04A, RELEASE_REGION_JPN: 0xaa6ba0},
		"is_starterItem": true, "is_missableItem": false}}


function is_SelectedItemInScrollBar(enum_item, enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "HighLightedInventoryItem", enum_releaseRegion)) == const_Items_data[enum_item]["itemScrollBarId"] 

function is_ItemPresentInInventory(enum_item, enum_releaseRegion) => 
	bit0(const_Items_data[enum_item]["memAddress_Flag_isInInventory"][enum_releaseRegion]) == 1

// ......................
// ◦ BOTTOM SCREEN TEXT ◦
// ''''''''''''''''''''''
// - The text at the bottom of the screen (subtitles & info in menu's) is printed on the screen via a transparent character set image, 
// 		which is masked to show only 1 character at a time. 
//		Functional with offset and different character sets (ex. latin, chinese) (more info refer to code notes @ 0xac31e8)
function is_BottomScreenTextId(int_id, enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "BottomScreenTextID", enum_releaseRegion)) == int_id
// -------------------------------------
function get_CharPrint_offset(int_charIndex) =>
	int_charIndex * memory_getDataStructSizeInBytes("Struct_CharacterPrintData")

function current_CharPrint_controlData(int_charIndex, enum_releaseRegion) =>
	word(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "16Bit_ControlData"))

function current_CharPrint_height(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Height"))

function current_CharPrint_printXaxis(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Print_Xaxis"))
	
function current_CharPrint_printYaxis(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_Print_Yaxis"))

function current_CharPrint_imageOffsetXaxis(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis"))
	
function current_CharPrint_imageOffsetYaxis(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Yaxis"))
	
function current_CharPrint_imageUnmaskWidth(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
	memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageUnmask_Width"))
	
function current_CharPrint_characterSetId(int_charIndex, enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
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
function is_CharacterOnBottomScreen_bis(int_charIndex, dict_characterPrintData, enum_releaseRegion) => // index starts at 0
	current_CharPrint_height(int_charIndex, enum_releaseRegion) == dict_characterPrintData["height"] &&
	current_CharPrint_printXaxis(int_charIndex, enum_releaseRegion) == dict_characterPrintData["print_Xaxis"] &&
	current_CharPrint_printYaxis(int_charIndex, enum_releaseRegion) == dict_characterPrintData["print_Yaxis"] &&
	current_CharPrint_imageOffsetXaxis(int_charIndex, enum_releaseRegion) == dict_characterPrintData["imageOffset_Xaxis"] &&
	current_CharPrint_imageOffsetYaxis(int_charIndex, enum_releaseRegion) == dict_characterPrintData["imageOffset_Yaxis"] &&
	current_CharPrint_imageUnmaskWidth(int_charIndex, enum_releaseRegion) == dict_characterPrintData["imageUnmask_Width"] &&
	current_CharPrint_characterSetId(int_charIndex, enum_releaseRegion) == dict_characterPrintData["characterSetId"]

function is_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData, enum_releaseRegion) => // index starts at 0
	current_CharPrint_height(int_charIndex, enum_releaseRegion) == dict_characterPrintData["height"] &&
	current_CharPrint_printXaxis(int_charIndex, enum_releaseRegion) == dict_characterPrintData["print_Xaxis"] &&
	dword_be(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis")) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
	current_CharPrint_characterSetId(int_charIndex, enum_releaseRegion) == dict_characterPrintData["characterSetId"]	

function was_CharacterOnBottomScreen_bis(int_charIndex, dict_characterPrintData, enum_releaseRegion) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["print_Xaxis"] &&
	prior(current_CharPrint_printYaxis(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["print_Yaxis"] &&
	prior(current_CharPrint_imageOffsetXaxis(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["imageOffset_Xaxis"] &&
	prior(current_CharPrint_imageOffsetYaxis(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["imageOffset_Yaxis"] &&
	prior(current_CharPrint_imageUnmaskWidth(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["imageUnmask_Width"] &&
	prior(current_CharPrint_characterSetId(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["characterSetId"]

function was_CharacterOnBottomScreen(int_charIndex, dict_characterPrintData, enum_releaseRegion) => // index starts at 0
	prior(current_CharPrint_height(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["height"] &&
	prior(current_CharPrint_printXaxis(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["print_Xaxis"] &&
	prior(dword_be(memory_getAddress(DATATYPE_Struct, "CharacterPrintData_base", enum_releaseRegion) + get_CharPrint_offset(int_charIndex) + 
		memory_getDataStructOffset("Struct_CharacterPrintData", "8Bit_ImageOffset_Xaxis"))) == memUtil_CharacterPrintDataTo_dwordBe(dict_characterPrintData) &&
	prior(current_CharPrint_characterSetId(int_charIndex, enum_releaseRegion)) == dict_characterPrintData["characterSetId"]

function is_TotalCharacterCountOnBottomScreen(int_charCount, enum_releaseRegion) { // Count starts at 1
	let_lastCharIndex = int_charCount - 1
	return 
		current_CharPrint_controlData(let_lastCharIndex, enum_releaseRegion) != 0 		&& // <-- this block checks if there is an Nth character printed on screen; where N = int_charCount
		current_CharPrint_height(let_lastCharIndex, enum_releaseRegion) != 0			&&

		current_CharPrint_controlData(let_lastCharIndex + 1, enum_releaseRegion) == 0 	&& // <-- this block checks if there's no more characters printed after Nth one
		current_CharPrint_height(let_lastCharIndex + 1, enum_releaseRegion) == 0}

function was_MinimumAmountOfCharactersOnBottomScreen(int_charCount, enum_releaseRegion) => // Count starts at 1
	prior(current_CharPrint_controlData(int_charCount - 1, enum_releaseRegion)) != 0x0

function is_BottomScreenText_empty(enum_releaseRegion) => 
	current_CharPrint_controlData(0, enum_releaseRegion) == 0x0 &&	// Checks first character
	current_CharPrint_controlData(7, enum_releaseRegion) == 0x0	// Checks 7th character

function was_BottomScreenText_empty(enum_releaseRegion) => 
	prior(current_CharPrint_controlData(0, enum_releaseRegion)) == 0x0 &&	// Checks first character
	prior(current_CharPrint_controlData(7, enum_releaseRegion)) == 0x0		// Checks 7th character

function on_BottomScreenText_render(enum_releaseRegion) => 
	current_CharPrint_controlData(0, enum_releaseRegion) > 0 && 
	prev(current_CharPrint_controlData(0, enum_releaseRegion)) == 0

function on_BottomScreenText_remove(enum_releaseRegion) => 
	current_CharPrint_controlData(0, enum_releaseRegion) == 0 && 
	prev(current_CharPrint_controlData(0, enum_releaseRegion)) > 0

// ...............
// ◦ ENERGY ORBS ◦
// '''''''''''''''
// - positional value's are based on the player's position close to the orb (refer to notes @ 0xa8abd0)
const_EnergyOrbs_data = {
	TIMEPERIOD_Late20thCentury: {
		"amountToCollect": 5,
		"sharedArea": [AREA_80s_City_Snow, AREA_70s_City_Night],
		"locations": {
			"NorthGateNearBar": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_JPN)) +0x4,
				}},
			"WellCafeSonne": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_USA)) +0x5,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_JPN)) +0x5
				}},
			"Haupstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_USA)) +0x6,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_JPN)) +0x6
				}},
			"StairsRudolfstr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_USA)) +0x7,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_JPN)) +0x7
				}},
			"AlleyWayBakery": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_USA)) +0x8,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Late20thCentury_City", RELEASE_REGION_JPN)) +0x8
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
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_BrumMansion", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_BrumMansion", RELEASE_REGION_JPN)) +0x4
				}},
			"TreeNearBar": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_JPN)) +0x4
				}},
			"StairsOppositeCafeSonne": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_USA)) +0x5,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_JPN)) +0x5
				}},
			"NearNewsPost": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_USA)) +0x6,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_JPN)) +0x6
				}},
			"ParkRudolfStr": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_USA)) +0x7,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_JPN)) +0x7
				}},
			"NorthEastgate": {
				"area": [AREA_1900s_City],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_USA)) +0x8,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Early20thCentury_City", RELEASE_REGION_JPN)) +0x8
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
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_AlchemyLab", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_AlchemyLab", RELEASE_REGION_JPN)) +0x4
				}},
			"InsideChurch": {
				"area": [AREA_MiddleAges_Church],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_Church", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_Church", RELEASE_REGION_JPN)) +0x4
				}},
			"onBench": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_JPN)) +0x4
				}},
			"EastWell": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_USA)) +0x5,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_JPN)) +0x5
				}},
			"AlleyWayCart": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_USA)) +0x6,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_JPN)) +0x6
				}},
			"EastNearHay": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_USA)) +0x7,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_JPN)) +0x7
				}},
			"ChurchEntrance": {
				"area": [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night],
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_USA)) +0x8,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_MiddleAges_City", RELEASE_REGION_JPN)) +0x8
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
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_USA)) +0x4,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_JPN)) +0x4
				}},
			"AlleyWay": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_USA)) +0x5,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_JPN)) +0x5
				}},
			"SouthGate": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_USA)) +0x6,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_JPN)) +0x6
				}},
			"UnderArchRuckagrastr": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_USA)) +0x7,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_JPN)) +0x7
				}},
			"CarPark": {
				"area": iNULL,
				"memAddr_Flag_isCollected": {
					RELEASE_REGION_USA: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_USA)) +0x8,
					RELEASE_REGION_JPN: () => memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "EnergyOrbs_Present_City", RELEASE_REGION_JPN)) +0x8
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

function current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion) =>
	bit0(const_EnergyOrbs_data[enum_timePeriod]["locations"][string_locationKey]["memAddr_Flag_isCollected"][enum_releaseRegion])

function prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion) =>
	prev(current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion))

function is_EnergyOrb_collected(enum_timePeriod, string_locationKey, enum_releaseRegion) =>
	current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion) == 0

function on_EnergyOrb_collect(enum_timePeriod, string_locationKey, enum_releaseRegion) => 
	current_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion) > prev_EnergyOrb_CollectionState(enum_timePeriod, string_locationKey, enum_releaseRegion)
// -------------------------------------
function current_EnergyUnits(enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "EnergyUnits", enum_releaseRegion))

function prev_EnergyUnits(enum_releaseRegion) =>
	prev(current_EnergyUnits(enum_releaseRegion))

function on_EnergyUnits_increment(enum_releaseRegion) => 
	current_EnergyUnits(enum_releaseRegion) > prev_EnergyUnits(enum_releaseRegion)

function on_EnergyUnits_decrement(enum_releaseRegion) => 
	current_EnergyUnits(enum_releaseRegion) < prev_EnergyUnits(enum_releaseRegion)

function on_EnergyUnits_valueChange(enum_releaseRegion) => 
	current_EnergyUnits(enum_releaseRegion) != prev_EnergyUnits(enum_releaseRegion)

// .......................
// ◦ MENU IDENTIFICATION ◦
// '''''''''''''''''''''''
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function is_ExtraMenu_active(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_32Bit, "ExtraMenuState", enum_releaseRegion)
	return dword(let_memAddr) > 0}	
// -------------------------------------
function is_InGamePauseMenu_active(enum_releaseRegion) {
	let_memAddr_IsInGamePauseMenuDisplayed = memory_getAddress(DATATYPE_BitFlag, "IsInGamePauseMenuDisplayed", enum_releaseRegion)
	return 
		bit0(let_memAddr_IsInGamePauseMenuDisplayed) == 1 &&
		bit0(let_memAddr_IsInGamePauseMenuDisplayed + 0x4) == 1}

function is_ChapterCompletionMenu_active(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "MenuID", enum_releaseRegion)) == 0x1 	&&
	dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_releaseRegion)) == 0x21 &&	
	bit0(memory_getAddress(DATATYPE_32Bit, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_releaseRegion)) == 1	

function is_Loading(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_releaseRegion)) == 1

function on_ChapterCompletionMenu_render(enum_releaseRegion) {	
	let_memAccessor_MenuID = dword(memory_getAddress(DATATYPE_32Bit, "MenuID", enum_releaseRegion))
	let_memAccessor_IsChapterCompletionScreenActive = dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_releaseRegion))
	let_memAccessor_IsChapterCompletionMenuDisplayed = bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_releaseRegion))
	return 		
		let_memAccessor_MenuID == 0x1 && prev(let_memAccessor_MenuID) != 0x1 &&
		let_memAccessor_IsChapterCompletionScreenActive == 0x21 && prev(let_memAccessor_IsChapterCompletionScreenActive) != 0x21 &&
		let_memAccessor_IsChapterCompletionMenuDisplayed > prior(let_memAccessor_IsChapterCompletionMenuDisplayed)} // <-- prior check here, because this value changes before the other comparisons

function on_ChapterCompletionMenu_exit(enum_releaseRegion) {
	let_memAccessor_MenuID = dword(memory_getAddress(DATATYPE_32Bit, "MenuID", enum_releaseRegion))
	let_memAccessor_IsChapterCompletionScreenActive = dword(memory_getAddress(DATATYPE_32Bit, "IsChapterCompletionScreenActive", enum_releaseRegion))
	let_memAccessor_IsChapterCompletionMenuDisplayed = bit0(memory_getAddress(DATATYPE_BitFlag, "IsLoading_OR_IsChapterCompletionMenuDisplayed", enum_releaseRegion))
	return
		let_memAccessor_MenuID != 0x1 && prev(let_memAccessor_MenuID) == 0x1 &&
		let_memAccessor_IsChapterCompletionScreenActive != 0x21 && prev(let_memAccessor_IsChapterCompletionScreenActive) == 0x21 &&
		let_memAccessor_IsChapterCompletionMenuDisplayed < prior(let_memAccessor_IsChapterCompletionMenuDisplayed)} // <-- prior check here, because this value changes before the other comparisons
									
function is_InGame(enum_releaseRegion) =>
	low4(memory_getAddress(DATATYPE_4Bit, "IsInGame", enum_releaseRegion)) != 0

function on_TitleMenu_render(enum_releaseRegion) { 
	let_memAccessor_IsInGame = low4(memory_getAddress(DATATYPE_4Bit, "IsInGame", enum_releaseRegion))
	return
		let_memAccessor_IsInGame == 0 && 
		prev(let_memAccessor_IsInGame) > 0}

// ..............
// ◦ VIDEO DATA ◦
// ''''''''''''''
function is_Video_active(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_releaseRegion))
	return 
		dword(let_maskedPointer + 0x18) == 0x101 &&	
		dword(let_maskedPointer + 0x2c) == 0x41}

function on_Video_end(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_releaseRegion))
	return
		prev(dword(let_maskedPointer + 0x18)) == 0x101 	&&
		dword(let_maskedPointer + 0x18)	!= 0x101		&&
		prev(dword(let_maskedPointer + 0x2c)) == 0x41 	&&
		dword(let_maskedPointer + 0x2c)	!= 0x41}

function on_Video_start(enum_releaseRegion) {
	let_maskedPointer = memUtil_maskPointer(memory_getAddress(DATATYPE_25BitPointer, "VideoData", enum_releaseRegion))
	return
		prev(dword(let_maskedPointer + 0x18)) != 0x101 	&&
		dword(let_maskedPointer + 0x18)	== 0x101		&&
		prev(dword(let_maskedPointer + 0x2c)) != 0x41 	&&
		dword(let_maskedPointer + 0x2c)	== 0x41}

// ................
// ◦ ENDING LOGIC ◦
// ''''''''''''''''
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
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x0,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x0, 
		}},
	ENDING_B : {
		"EndingFile_ID": 0x1,
		"memAddr_Flag_EndingAchieved": {
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x1,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x1, 
		}},
	ENDING_C : {
		"EndingFile_ID": 0x2,
		"memAddr_Flag_EndingAchieved": {
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x2,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x2, 
		}},
	ENDING_D : {
		"EndingFile_ID": 0x3,
		"memAddr_Flag_EndingAchieved": {
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x3,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x3, 
		}},
	ENDING_E : {
		"EndingFile_ID": 0x4,
		"memAddr_Flag_EndingAchieved": {
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x4,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x4, 
		}},
	ENDING_EX : {
		"EndingFile_ID": 0x5,
		"memAddr_Flag_EndingAchieved": {
			RELEASE_REGION_USA: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_USA) + 0x5,
			RELEASE_REGION_JPN: () => memory_getAddress(DATATYPE_Struct, "EndingData_base", RELEASE_REGION_JPN) + 0x5, 
		}}
	}

function get_EndingFileId(enum_ending) =>
	const_Endings_data[enum_ending]["EndingFile_ID"]

function is_Ending_achieved(enum_ending, enum_releaseRegion) =>
	bit0(const_Endings_data[enum_ending]["memAddr_Flag_EndingAchieved"][enum_releaseRegion]) == 1

function is_ExChapter_unlocked(enum_releaseRegion) => // If endings ABCDE are achieved
	all_of(const_Endings_data, (enum_ending) {
		if (enum_ending != ENDING_EX) return is_Ending_achieved(enum_ending, enum_releaseRegion)
		else return always_true()
	})

// ..............................
// ◦ CUTSCENE/CHOICES BIT FLAGS ◦
// ''''''''''''''''''''''''''''''
function is_PrologueExMode_active(enum_releaseRegion) => 
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_ExChapter", enum_releaseRegion)) == 1

// -------------- SquareTree ---------------
function is_TreeReplacedBy_Statue(enum_releaseRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_releaseRegion)) == 0

function is_TreeReplacedBy_Flowers(enum_releaseRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_releaseRegion)) == 1

function is_CrowdScaredWith_Cellphone(enum_releaseRegion) => 	
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_releaseRegion)) == 1	
	
function is_CrowdScaredWith_Lighter(enum_releaseRegion) => 
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter2", enum_releaseRegion)) == 0	
// ------------ Movie --------------
function is_MovieWorldConquest_chosen(enum_releaseRegion) => 
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_releaseRegion)) == 1 &&
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_releaseRegion)) == 0

function is_MovieTimeTravel_chosen(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_releaseRegion)
	return bit6(let_memAddr) == 1 && bit5(let_memAddr) == 0}

function is_MovieFindCauseDeath_chosen(enum_releaseRegion) =>
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_1", enum_releaseRegion)) == 0 &&
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_releaseRegion)) == 1 

function is_MovieThriller_chosen(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_releaseRegion)
	return bit1(let_memAddr) == 1 && bit2(let_memAddr) == 0}

function is_MovieLove_chosen(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MovieChoice_2", enum_releaseRegion) 
	return bit2(let_memAddr) == 1 && bit1(let_memAddr) == 0}

// ---------- Paintings ------------
function is_Painting_Antidote_inspired(enum_releaseRegion) =>
	bit7(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_releaseRegion)) == 1	

function is_Painting_Marktplatz_inspired(enum_releaseRegion) => 
	bit6(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_releaseRegion)) == 1

function is_Painting_SquireCrest_inspired(enum_releaseRegion) => 
	bit5(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_releaseRegion)) == 1	
					
function is_Painting_TowerView_inspired(enum_releaseRegion) => 
	bit4(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_1", enum_releaseRegion)) == 1

function is_Painting_Performer_inspired(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_2", enum_releaseRegion)) == 1	

function is_Painting_HouseCollapse_inspired(enum_releaseRegion) => 
	bit1(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_InspiredKarlFranssenArt_2", enum_releaseRegion)) == 1	
// ----------- BrumEstate ----------------
function is_BrumEstate_Museum(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_BrumEstateChoice", enum_releaseRegion)
	return bit5(let_memAddr) == 0}

function is_BrumEstate_Library(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_BrumEstateChoice", enum_releaseRegion)
	return bit5(let_memAddr) == 1} 

// -----------AncestorChoice--------------
function is_MargaretteTold_Ancestor(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_AncestorChoice_2", enum_releaseRegion)
	return 	bit6(let_memAddr) == 1 && bit7(let_memAddr) == 0}

function is_MargaretteTold_NoAncestor(enum_releaseRegion) {	
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_AncestorChoice_2", enum_releaseRegion)
	return bit6(let_memAddr) == 0 && bit7(let_memAddr) == 1}

// ------------FireChapter1---------------
function is_FirePutOutBy_Barman(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter1", enum_releaseRegion)
	return
		bit5(let_memAddr) == 0 &&
		bit7(let_memAddr) == 1	}

function is_FirePutOutBy_Eike(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter1", enum_releaseRegion)
	return 
		bit5(let_memAddr) == 1 &&
		bit7(let_memAddr) == 0}	

// -----------DanaChoice----------------
function is_Dana_Saved_FromPast(enum_releaseRegion) {
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_SaveDanaFromPast", enum_releaseRegion)
	return
		bit1(let_memAddr) == 1 && 
		bit3(let_memAddr) == 1 && 
		bit4(let_memAddr) == 1}

function is_Dana_Left_InPast(enum_releaseRegion){
	let_memAddr = memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_SaveDanaFromPast", enum_releaseRegion)
	return
		bit1(let_memAddr) == 0 &&
		bit3(let_memAddr) == 0 &&
		bit4(let_memAddr) == 0}
	
// ----------Misc--------------
function is_CoffeePayed(enum_releaseRegion) => 
	bit3(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MultiChapter_4", enum_releaseRegion)) == 1

function is_KittenGivenToSibylla(enum_releaseRegion) =>
	bit6(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_MultiChapter_3", enum_releaseRegion)) == 1

function is_WearingPerformerOutfit(enum_releaseRegion) =>
	bit2(memory_getAddress(DATATYPE_BitFlag, "CurrentPlaythrough_Chapter4", enum_releaseRegion)) == 1

// ...................................
// ◦ ACHIEVEMENT PERCENTAGE BITFLAGS ◦
// '''''''''''''''''''''''''''''''''''
// - Each flag corresponds to 1 cutscene and counts toward the achievement percentage
// - At end of a cutscene one of these flags will become true
// - Flags are grouped per chapter
// - These flags are loaded when loading a save OR when starting a new game whilst having played the game before
const_percentageBitsets = {
	CHAPTER_Prologue: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_USA) + 0x6, "bits": [0,5]},		
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Prologue_base", RELEASE_REGION_JPN) + 0x6, "bits": [0,5]},
		]
	},
	CHAPTER_Chapter1: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_USA) + 0x0, "bits": [6,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_USA) + 0x3, "bits": [0,5]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_JPN) + 0x0, "bits": [6,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter1_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,5]},
		]
	},
	CHAPTER_Chapter2: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_USA) + 0x0, "bits": [3,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_USA) + 0x4, "bits": [0,6]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_JPN) + 0x0, "bits": [3,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter2_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,6]},
		]
	},
	CHAPTER_Chapter3: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter3_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
		]
	},
	CHAPTER_Chapter4: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_USA) + 0x4, "bits": [0,4]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter4_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,4]},
		]
	},
	CHAPTER_Chapter5: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_USA) + 0x5, "bits": [0,6]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x0, "bits": [1,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter5_base", RELEASE_REGION_JPN) + 0x5, "bits": [0,6]},
		]
	},
	CHAPTER_Chapter6: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_USA) + 0x4, "bits": [0,4]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter6_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,4]},
		]
	},
	CHAPTER_Chapter7: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_USA) + 0x4, "bits": [0,3]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter7_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,3]},
		]
	}, 
	CHAPTER_Chapter8: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x0, "bits": [5,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x6, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x7, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x8, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_USA) + 0x9, "bits": [0,3]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x0, "bits": [5,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x3, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x4, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x5, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x6, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x7, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x8, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Chapter8_base", RELEASE_REGION_JPN) + 0x9, "bits": [0,3]},
		]
	}, 
	CHAPTER_Epilogue: {
		RELEASE_REGION_USA: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_USA) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_USA) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_USA) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_USA) + 0x3, "bits": [0]},
		],
		RELEASE_REGION_JPN: [
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_JPN) + 0x0, "bits": [2,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_JPN) + 0x1, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_JPN) + 0x2, "bits": [0,7]},
			{"memAddr": () => memory_getAddress(DATATYPE_Struct, "AchievementPercentage_Epilogue_base", RELEASE_REGION_JPN) + 0x3, "bits": [0]},
		]
	}}
		
function memUtil_allPercentageBitsetsToOneArray(enum_releaseRegion) {
	let_array_bitsets = []
	for chapterKey in const_percentageBitsets {
		for bitset in const_percentageBitsets[chapterKey][enum_releaseRegion] {
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

function current_TotalAchievementRate(enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "AchievementPercentageNumber_Total", enum_releaseRegion))

// ...............
// ◦ OTHER LOGIC ◦
// '''''''''''''''
function on_FrameCount_change(enum_releaseRegion) {
	let_memAccessor_FrameCounter = dword(memory_getAddress(DATATYPE_32Bit, "FrameCounter", enum_releaseRegion))
	return let_memAccessor_FrameCounter != prev(let_memAccessor_FrameCounter)}

function is_PlayerCharacter_moveable(enum_releaseRegion) {
	let_memAccessor_flag = byte(memory_getAddress(DATATYPE_8Bit, "IsPlayerCharacterMoveable", enum_releaseRegion))
	return let_memAccessor_flag == 0x8
}


// =========================
// • Memory INITIALIZATION •
// =========================
//	- This code is for initializing memory addresses which have an offset to another regions memory addresses => lowers amount of hardcoding and chances on mistyping addresses
//	- memory_initialize() => should be called before RATools compiles dictionary achievements_triggers, because those triggers access memory_addresses which might need to be initialized before usage.
//		- Function calls/anonymous functions calls in a dictionary are run at compile time => therefor we need to memory_initialize() before they compile
function memory_initialize() { 
	function initialize_OtherRegions() { // initialize_OtherRegions() => use this when ALL memory addresses for a game region are offset by the same value
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
	memory_initialize_NPCAppearances_releaseRegionJPN()}
memory_initialize()

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

// ==========================
// • Achievements CORE DATA •
// ==========================
// - Divided by category => when in debug mode, category tags are added to achievement titles
achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
	//	"id": 000000, "points": 0000000,
	//	"devInfo": "xxxxxxx"},

	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // VERIFIED  
			"id": 306884, "points": 5,
			"devInfo": "Complete the prologue"},
		"a_Chapter1CompleteByEike": { // VERIFIED 
			"id": 306886, "points": 3,
			"devInfo": "Complete chapter 1"},
		"a_Chapter1CompleteByBarman": { // VERIFIED
			"id": 306976, "points": 3,
			"devInfo": "Alert the barman of fire in chapter 1"},
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
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_template": "xxxxxx",
	"c_Completion": 						"progression",
	"c_Endings": 							"win_condition",
	"c_AchievementPercentage": 				sNULL,
	"c_Branch": 							"missable",
	"c_Extra":				 				"missable",
	"c_ExtraCouple":						"missable",
	"c_ExtraEnergy":						sNULL,
	"c_ExtraGameOver": 						"missable",}

// ===================================
// • Achievements TRIGGER GENERATORS •
// ===================================
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_FullTrigger_ChapterMaxAchievementRate(enum_chapter, enum_releaseRegion) {
	// DEV_NOTE: Measure flag with "sum_of() == value" instead of a tally()
	// ----------------------------------
	// 	- This function generates a measure with no hit target. But uses 'Add Source' flags generated with sum_of()
	//	- Example output of this function: measured((bit0(0xAA1178) + bit1(0xAA1178) + bit2(0xAA1178) + bit3(0xAA1178) + bit4(0xAA1178)) == 5
	//		-- In this case each bit would count for 20% or 1/5th

	let_array_bitsets = const_percentageBitsets[enum_chapter][enum_releaseRegion]
	let_array_bitFlagMemoryAccessors = memUtil_bitsetArrayToMemoryAccessorArray(let_array_bitsets)
	let_int_bitFlagCount = memUtil_countTotalBitFlagsInBitsetArray(let_array_bitsets)

	let_sumOf_currentInventoryCount = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => memoryAccessor)	// output example of sum_of(): [bit0(0x00), bit1(0x00), bitcount(0x01)] => bit0(0x00) + bit1(0x00) + bitcount(0x01)
	let_comparison_currentInventoryCount = let_sumOf_currentInventoryCount == let_int_bitFlagCount // Example comparison stored in this variable: bit0(0x00) + bit1(0x00) + bitcount(0x01) == 4

	let_sumOf_prevInventoryCount = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => prev(memoryAccessor)) // Example expression stored in this variable: prev(bit0(0x00)) + prev(bit1(0x00)) + prev(bitcount(0x01))
	let_comparison_deltaInventoryCount = let_sumOf_prevInventoryCount < let_int_bitFlagCount 	

	return
		let_sumOf_prevInventoryCount > (let_int_bitFlagCount/4)*3 	&& // <-- 2 lines: save protection => loading a savefile which already has all bitflags set to 1, must not unlock the achievement
		let_sumOf_prevInventoryCount < let_int_bitFlagCount 		&& 		// Two delta comparisons needed in case more than 1 bitflag turns on in one frame
		measured(let_comparison_currentInventoryCount, 
			when = 
				is_ReleaseRegion(enum_releaseRegion) &&
				is_InGame(enum_releaseRegion) && 
				!is_ExtraMenu_active(enum_releaseRegion) &&
				is_Chapter(enum_chapter, enum_releaseRegion), 
			format = "percent")
	}

function achievements_generate_FullTrigger_TotalMaxAchievementRate(enum_releaseRegion) {
	let_array_bitsets = memUtil_allPercentageBitsetsToOneArray(enum_releaseRegion)
	let_array_bitFlagMemoryAccessors = memUtil_bitsetArrayToMemoryAccessorArray(let_array_bitsets)
	let_int_bitFlagCount = memUtil_countTotalBitFlagsInBitsetArray(let_array_bitsets)

	let_sumOf_currentInventoryCount = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => memoryAccessor)	// output example of sum_of(): [bit0(0x00), bit1(0x00), bitcount(0x01)] => bit0(0x00) + bit1(0x00) + bitcount(0x01)
	let_comparison_currentInventoryCount = let_sumOf_currentInventoryCount == let_int_bitFlagCount // Example comparison stored in this variable: bit0(0x00) + bit1(0x00) + bitcount(0x01) == 4

	let_sumOf_prevInventoryCount = sum_of(let_array_bitFlagMemoryAccessors, (memoryAccessor) => prev(memoryAccessor)) // Example expression stored in this variable: prev(bit0(0x00)) + prev(bit1(0x00)) + prev(bitcount(0x01))
	let_comparison_deltaInventoryCount = let_sumOf_prevInventoryCount < let_int_bitFlagCount 

	return 
		let_sumOf_prevInventoryCount > (let_int_bitFlagCount/10)*9 	&& // <-- 2 lines: save protection => loading a savefile which already has all bitflags set to 1, must not unlock the achievement
		let_sumOf_prevInventoryCount < let_int_bitFlagCount 		&& 		// Two delta comparisons needed in case more than 1 bitflag turns on in one frame
		measured(let_comparison_currentInventoryCount,
			when = 
				is_ReleaseRegion(enum_releaseRegion) &&
				is_InGame(enum_releaseRegion) &&
				!is_ExtraMenu_active(enum_releaseRegion),
			format = "percent")
	}

function achievements_generate_FullTrigger_EnergyCollector(enum_timePeriod, enum_releaseRegion) {
	function create_Tally_EnergyOrbs(enum_timePeriod, enum_releaseRegion) {
		let_tallyComparisonArray = []
		let_sharedArea = get_EnergyOrb_sharedAreas(enum_timePeriod)
		for let_OrbLocationKey in get_EnergyOrb_Locations(enum_timePeriod) {
			let_arrayAreaEnums = get_EnergyOrb_Location_area(enum_timePeriod, let_OrbLocationKey)
			if(let_sharedArea == iNULL && let_arrayAreaEnums == iNULL)
				util_throwError("At least one area must be given for energy orb: {0}", let_OrbLocationKey)			
			let_areaComparisonArray = []
			if (let_arrayAreaEnums != iNULL && length(let_arrayAreaEnums) > 0) {
				for enum_area in let_arrayAreaEnums {
					array_push(let_areaComparisonArray, is_Area(enum_area, enum_releaseRegion))
				}
			}
			if(length(let_areaComparisonArray) == 0) {
				array_push(let_tallyComparisonArray, once(on_EnergyOrb_collect(enum_timePeriod, let_OrbLocationKey, enum_releaseRegion)))
			} else {
				let_areaComparison = any_of(let_areaComparisonArray, (comparison) => comparison)
				array_push(let_tallyComparisonArray, once(let_areaComparison && on_EnergyOrb_collect(enum_timePeriod, let_OrbLocationKey, enum_releaseRegion)))
			}			
		}
		return tally(get_EnergyOrb_amountToCollect(enum_timePeriod), let_tallyComparisonArray)}
	function create_array_EnergyOrbCollectionStateMemAccessors(enum_timePeriod, enum_releaseRegion) {
		let_array_memoryAccessors = []
		for let_OrbLocationKey in get_EnergyOrb_Locations(enum_timePeriod) {
			array_push(let_array_memoryAccessors, current_EnergyOrb_CollectionState(enum_timePeriod, let_OrbLocationKey, enum_releaseRegion))
		}
		return let_array_memoryAccessors}
	function create_Pause_WhenNotInSharedAreas(enum_timePeriod, enum_releaseRegion) {		
		let_sharedAreas = get_EnergyOrb_sharedAreas(enum_timePeriod)
		let_pauseComparisonArray = []
		if(let_sharedAreas != iNULL && length(let_sharedAreas) > 0){
			for enum_area in let_sharedAreas {
				array_push(let_pauseComparisonArray, is_Area(enum_area, enum_releaseRegion))
			}
		}
		if (length(let_pauseComparisonArray) == 0) { return 
			always_true()
		} else { return 
			unless(
				none_of(let_pauseComparisonArray, (comparison) => comparison)
			)
		}}

	let_amountOfEnergyOrbsToCollect = get_EnergyOrb_amountToCollect(enum_timePeriod)
	let_array_energyOrbCollectionStateMemAccessors = create_array_EnergyOrbCollectionStateMemAccessors(enum_timePeriod, enum_releaseRegion)
	let_sumOf_currentEnergyOrbCollectionStates = sum_of(let_array_energyOrbCollectionStateMemAccessors, (memAccessor) => memAccessor)
	let_sumOf_deltaEnergyOrbCollectionStates = sum_of(let_array_energyOrbCollectionStateMemAccessors, (memAccessor) => prev(memAccessor))

	return 
		// alt_core => contains measurement for energy orbs
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		create_Pause_WhenNotInSharedAreas(enum_timePeriod, enum_releaseRegion) &&
		once(
			let_sumOf_deltaEnergyOrbCollectionStates == let_amountOfEnergyOrbsToCollect-1 && // <-- 2 lines: save protection  => loading a savefile which has already picked up enough energy orbs must not unlock the achievement
			let_sumOf_currentEnergyOrbCollectionStates == let_amountOfEnergyOrbsToCollect		// Only 1 delta sumOfCount necessary because you can only pick up one orb at a time
		) &&
		measured(create_Tally_EnergyOrbs(enum_timePeriod, enum_releaseRegion)) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))
		|| // alt_reset => place reset in alt, so count can reset outside of pause in alt_core
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) &&
			(
				!is_InGame(enum_releaseRegion) ||
				on_Chapter_change(enum_releaseRegion) ||
				on_EnergyUnits_decrement(enum_releaseRegion)
			)
		)}	
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
// =========================
// • Achievements TRIGGERS •
// =========================
achievements_triggers = {
	// "a_Template": function Template() {	// WIP_template
	// 	return always_false()
	// },
	"a_PrologueComplete": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// DEV_NOTE: Reset + Pause
		// --------------------------
		//	- Pauses will be evaluated first => thus when pause if true, all resets in the same group are on hold. If you want to reset => place reset inside another group
		//	- You can also use ResetNextIf

		(	// Alt 1 => Normal way of identifying cutscenes
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||					
				!is_Chapter(CHAPTER_Prologue, enum_releaseRegion) // <-- Don't put this in reset, otherwise alt 2 can't trigger
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => watching performer
				// Active code => shorter comparison + delta check
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x22480, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)

				// OG Cutscene ID code => without delta checks becuase the different memAddresses change on differing timings, can only use prior
					// is_LargeCutscene_active(enum_releaseRegion) 				&& 
					// is_Cutscene_MasterId(0x22480, enum_releaseRegion)		&&
					// has_Cutscene_SectionId_started(enum_releaseRegion)		&& 
					// is_Cutscene_MasterDataId(0x1bcd0, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0xe10, enum_releaseRegion)
			) &&
			once(	// Identifies cutscene => shadow/killer walking behind Eike
				// Active code => shorter comparison + delta check
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x90bc0, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// OG Cutscene ID code => without delta checks becuase the different memAddresses change on differing timings, can only use prior
					// is_LargeCutscene_active(enum_releaseRegion) 				&& 
					// is_Cutscene_MasterId(0x90bc0, enum_releaseRegion)		&&
					// has_Cutscene_SectionId_started(enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x1ae70, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x75d10, enum_releaseRegion)
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		) || (	// Alt 2 => Failsafe; trigger on chapter change
			is_ReleaseRegion(enum_releaseRegion) &&	
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Prologue, enum_releaseRegion)
		)),
	"a_Chapter1CompleteByEike": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { return
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				never(
					!is_InGame(enum_releaseRegion) ||
					is_ExtraMenu_active(enum_releaseRegion)
				) &&
				is_FirePutOutBy_Eike(enum_releaseRegion) &&
				once(	// Identifies Cutscene => burning bar changes into non-burning
					is_LargeCutscene_active(enum_releaseRegion) 		&& 
					is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) 	&&
					is_Cutscene_MasterId(0x11a40, enum_releaseRegion) 	&&
					on_Cutscene_SectionId_start(enum_releaseRegion)	

					// OG Cutscene ID code
						// is_LargeCutscene_active(enum_releaseRegion) && is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) &&
						// is_Cutscene_MasterId(0x11a40, enum_releaseRegion)		&&
						// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
						// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
						// is_Cutscene_MasterDataId(0xbea0, enum_releaseRegion)	&&
						// is_Cutscene_SectionDataId(0x5b80, enum_releaseRegion)
				) &&
				trigger_when(on_Cutscene_end(enum_releaseRegion))
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				is_ReleaseRegion(enum_releaseRegion) &&				
				repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
					never(!is_InGame(enum_releaseRegion)) &&
					is_InGame(enum_releaseRegion)
				) && 
				!is_ExtraMenu_active(enum_releaseRegion) &&
				is_FirePutOutBy_Eike(enum_releaseRegion) &&
				on_Chapter_finish(CHAPTER_Chapter1, enum_releaseRegion)
			)
		)}),
	"a_Chapter1CompleteByBarman": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>		
		(	// Alt 1 => Normal way of identifying cutscenes	
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) &&
			is_FirePutOutBy_Barman(enum_releaseRegion) &&
			once(	// Identifies Cutscene => burning bar changes into non-burning
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) 	&&
				is_Cutscene_MasterId(0x11a40, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// OG Cutscene ID code
					// is_LargeCutscene_active(enum_releaseRegion) && is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) &&
					// is_Cutscene_MasterId(0x11a40, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0xbea0, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x5b80, enum_releaseRegion)
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		) || (	// Alt 2 => Failsafe; trigger on chapter change
			is_ReleaseRegion(enum_releaseRegion) &&			
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_FirePutOutBy_Barman(enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Chapter1, enum_releaseRegion)
		)),
	"a_Chapter2Complete": function a_Chapter2Complete() { return
		any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
			(	// Alt 1 => Normal way of identifying cutscenes
				unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				never(
					!is_InGame(enum_releaseRegion) ||
					is_ExtraMenu_active(enum_releaseRegion)
				) &&
				once(	// Identifies Cutscene => Eike reminiscing about Dana + tree dissappearing
					is_LargeCutscene_active(enum_releaseRegion) 				&& 
					is_Chapter(CHAPTER_Chapter2, enum_releaseRegion) 			&&
					is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) 	&&
					is_Cutscene_MasterId(0x3b240, enum_releaseRegion) 			&&
					on_Cutscene_SectionId_start(enum_releaseRegion)	

					// is_LargeCutscene_active(enum_releaseRegion) 			&&
					// is_Cutscene_MasterId(0x3b240, enum_releaseRegion) 		&&
					// is_Cutscene_MasterDataId(0x340e0, enum_releaseRegion)	&&
					// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x340e0, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x7130, enum_releaseRegion)
				) &&
				trigger_when(on_Cutscene_end(enum_releaseRegion))
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				is_ReleaseRegion(enum_releaseRegion) &&				
				repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
					never(!is_InGame(enum_releaseRegion)) &&
					is_InGame(enum_releaseRegion)
				) && 
				!is_ExtraMenu_active(enum_releaseRegion) &&
				on_Chapter_finish(CHAPTER_Chapter2, enum_releaseRegion)
			)
		)},
	"a_Chapter3Complete": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		alt1 = // Alt 1 => Normal way of identifying cutscenes
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||

				!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion) || // <-- Don't put this in reset, otherwise alt 2 can't trigger
				!is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Time travel back to Brum Museum  
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x19d80, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0x19d80, enum_releaseRegion)		&&	
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion) 		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion) 		&&
				// is_Cutscene_MasterDataId(0x82a0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x11ac0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Back to Eckart and breaking vase
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xcfb40, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x19d80, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0xcfb40, enum_releaseRegion)		&& was_Cutscene_MasterId(0x19d80, enum_releaseRegion) &&	
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion) 		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion) 		&&
				// is_Cutscene_MasterDataId(0x39f0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x387a0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Back downstairs and talk to Homunculus
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x39680, enum_releaseRegion)	&& was_Cutscene_MasterId(0xcfb40, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0x39680, enum_releaseRegion)		&& was_Cutscene_MasterId(0xcfb40, enum_releaseRegion) &&	
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion) 		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion) 		&&
				// is_Cutscene_MasterDataId(0x7e10, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x7ca0, enum_releaseRegion)
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alt2 = // Alt 2 => Failsafe; trigger on chapter change
			is_ReleaseRegion(enum_releaseRegion) &&
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Chapter3, enum_releaseRegion)
		return alt1 || alt2}),
	"a_Chapter4CompletePan": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function alt1(enum_releaseRegion) => // Alt 1 
			is_ReleaseRegion(enum_releaseRegion) &&
			is_InGame(enum_releaseRegion) &&
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) &&
			is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) &&
			on_ChapterCompletionMenu_render(enum_releaseRegion)

			// Way too many variations of this cutscene => just use above code
				// unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				// never(
				// 	!is_InGame(enum_releaseRegion) ||
				// 	is_ExtraMenu_active(enum_releaseRegion) ||
				// 	on_Cutscene_MasterId_change(enum_releaseRegion)	||
				// 	!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) ||
				// 	!is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) 
				// ) &&
				// tally(1, [
				// 	once(	// Identifies cutscene => protecting yourself with pan WITHOUT having taken the picture in the performer outfit
				// 		is_LargeCutscene_active(enum_releaseRegion) 		&& 					
				// 		is_Cutscene_MasterId(0x4f200, enum_releaseRegion) 	&&
				// 		on_Cutscene_SectionId_start(enum_releaseRegion)),

				// 		// is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) &&
				// 		// is_LargeCutscene_active(enum_releaseRegion) 			&& is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) &&
				// 		// is_Cutscene_MasterId(0x4f200, enum_releaseRegion)		&&
				// 		// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// 		// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// 		// is_Cutscene_MasterDataId(0x11cd0, enum_releaseRegion)	&&
				// 		// is_Cutscene_SectionDataId(0x3d500, enum_releaseRegion)),
				// 	once(	// Identifies cutscene => protecting yourself with pan AND having taken the picture in the performer outfit
				// 		is_LargeCutscene_active(enum_releaseRegion) 		&& 
				// 		is_Cutscene_MasterId(0x54580, enum_releaseRegion) 	&&
				// 		on_Cutscene_SectionId_start(enum_releaseRegion))

				// 		// is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) &&
				// 		// is_LargeCutscene_active(enum_releaseRegion) 			&& is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) &&
				// 		// is_Cutscene_MasterId(0x54580, enum_releaseRegion)		&&
				// 		// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// 		// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// 		// is_Cutscene_MasterDataId(0x17060, enum_releaseRegion)	&&
				// 		// is_Cutscene_SectionDataId(0x1390, enum_releaseRegion))
				// ]) &&			
				// trigger_when(on_Cutscene_end(enum_releaseRegion))		
		function alt2(enum_releaseRegion) => // Alt 2 => Failsafe; trigger on chapter change
			is_ReleaseRegion(enum_releaseRegion) &&
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Chapter4, enum_releaseRegion)
		return alt1(enum_releaseRegion) || alt2(enum_releaseRegion)
		}),
	"a_Chapter4CompleteSign": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function alt1(enum_releaseRegion) { return
			is_ReleaseRegion(enum_releaseRegion) &&
			is_InGame(enum_releaseRegion) &&
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) &&
			is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion) &&
			on_ChapterCompletionMenu_render(enum_releaseRegion)}

			// Way too many variations of this cutscene => just use above code
				// unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				// never(
				// 	!is_InGame(enum_releaseRegion) ||
				// 	is_ExtraMenu_active(enum_releaseRegion) ||
				// 	on_Cutscene_MasterId_change(enum_releaseRegion)	||
				// 	!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) ||
				// 	!is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion)
				// ) &&
				// tally(1, [
				// 	once(	// Identifies cutscene => protecting yourself with sign WITHOUT having taken the picture in the performer outfit
				// 		is_LargeCutscene_active(enum_releaseRegion) 				&& 
				// 		is_Cutscene_MasterId(0x4f800, enum_releaseRegion) 			&&
				// 		on_Cutscene_SectionId_start(enum_releaseRegion)),
				// 	once(	// Identifies cutscene => protecting yourself with sign AND having taken picture in the performer outfit
				// 		is_LargeCutscene_active(enum_releaseRegion) 				&& 
				// 		is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) 			&&
				// 		is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion) 	&&
				// 		is_Cutscene_MasterId(0x547c0, enum_releaseRegion) 			&&
				// 		on_Cutscene_SectionId_start(enum_releaseRegion))
				// ]) &&			
				// trigger_when(on_Cutscene_end(enum_releaseRegion))}
		function alt2(enum_releaseRegion) { return
			is_ReleaseRegion(enum_releaseRegion) &&			
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Chapter4, enum_releaseRegion)}
		return alt1(enum_releaseRegion) || alt2(enum_releaseRegion)}),
	"a_Chapter5Complete": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				never(
					!is_InGame(enum_releaseRegion) ||
					is_ExtraMenu_active(enum_releaseRegion)
				) &&
				once(	// Identifies Cutscene => drinking antidote
					// ID cutscene via old method/without delta check, because is_Cutscene_SectionId_1() stays at 0xffff
					is_LargeCutscene_active(enum_releaseRegion) && is_Chapter(CHAPTER_Chapter5, enum_releaseRegion) &&
					is_SelectedItemInScrollBar(ITEM_Antidote, enum_releaseRegion) &&
					is_Cutscene_MasterId(0x3f980, enum_releaseRegion)			&&
					is_Cutscene_SectionId_1(0xffff, enum_releaseRegion)			&&
					is_Cutscene_SectionId_2(0x0, enum_releaseRegion)			&&
					is_Cutscene_MasterDataId(0x3f980, enum_releaseRegion)		&&
					is_Cutscene_SectionDataId(0x3f980, enum_releaseRegion)
				) &&
				trigger_when(on_Cutscene_end(enum_releaseRegion))
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				is_ReleaseRegion(enum_releaseRegion) &&
				repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
					never(!is_InGame(enum_releaseRegion)) &&
					is_InGame(enum_releaseRegion)
				) && 
				!is_ExtraMenu_active(enum_releaseRegion) &&
				on_Chapter_finish(CHAPTER_Chapter5, enum_releaseRegion)
			)
		)),
	"a_Chapter6CompleteThriller": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				unless(!is_ReleaseRegion(enum_releaseRegion)) &&
				never(
					!is_InGame(enum_releaseRegion) ||
					is_ExtraMenu_active(enum_releaseRegion) 
				) &&
				is_MovieTimeTravel_chosen(enum_releaseRegion) 	&&
				is_MovieThriller_chosen(enum_releaseRegion) 	&&
				once( // Identifies Cutscene => Saved by love story movie
					is_LargeCutscene_active(enum_releaseRegion) 		&& 
					is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 	&&
					is_Cutscene_MasterId(0x9db40, enum_releaseRegion) 	&&
					on_Cutscene_SectionId_start(enum_releaseRegion)	

					// is_LargeCutscene_active(enum_releaseRegion) && 
					// is_Cutscene_MasterId(0x9db40, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x7, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x8, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x66600, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x20cd0, enum_releaseRegion)
				) && 
				trigger_when(on_Cutscene_end(enum_releaseRegion))
			) || (	// Alt 2 => Failsafe
				is_ReleaseRegion(enum_releaseRegion) &&				
				repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
					never(!is_InGame(enum_releaseRegion)) &&
					is_InGame(enum_releaseRegion)
				) && 
				!is_ExtraMenu_active(enum_releaseRegion) &&
				is_MovieTimeTravel_chosen(enum_releaseRegion) 	&&
				is_MovieThriller_chosen(enum_releaseRegion) 	&&
				on_Chapter_finish(CHAPTER_Chapter6, enum_releaseRegion)
			)
		)),
	"a_Chapter6CompleteLove": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		(	// Alt 1 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion) 
			) &&
			is_MovieTimeTravel_chosen(enum_releaseRegion) 	&&
			is_MovieLove_chosen(enum_releaseRegion) 		&&
			once( // Identifies Cutscene => Saved by love story movie
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 	&&
				is_Cutscene_MasterId(0x9db40, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) && 				
				// is_Cutscene_MasterId(0x9db40, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x7, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x8, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x66600, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x20cd0, enum_releaseRegion)
			) && 
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		) || (	// Alt 2 => Failsafe
			is_ReleaseRegion(enum_releaseRegion) &&			
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			is_MovieTimeTravel_chosen(enum_releaseRegion) 	&&
			is_MovieLove_chosen(enum_releaseRegion) 		&&
			on_Chapter_finish(CHAPTER_Chapter6, enum_releaseRegion)
		)),
	"a_Chapter7Complete": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		alt1 = // Alt 1 => Normal way of identifying cutscenes	(Also works when saving Miriam => Miriam is a counts as an extra in-between cutscene)	
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)	
			) &&
			once(	// Identifies Cutscene => Holding onto rope 
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x43040, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0x43040, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&& 
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x7ce0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0xd940, enum_releaseRegion)
			) &&
			tally(1,[	// One of these is true, depending on ancestress or no ancestress choice
				once(	// Identifies Cutscene => Talking to Eckart, Ancestress path 
					is_LargeCutscene_active(enum_releaseRegion) 		&& 
					is_MargaretteTold_Ancestor(enum_releaseRegion) 		&&
					is_Cutscene_MasterId(0xc6800, enum_releaseRegion) 	&&
					on_Cutscene_SectionId_start(enum_releaseRegion)),

					// is_LargeCutscene_active(enum_releaseRegion)				&&
					// is_MargaretteTold_Ancestor(enum_releaseRegion) 			&&
					// is_Cutscene_MasterId(0xc6800, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x45720, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x6ccd0, enum_releaseRegion)),
				once(	// Identifies Cutscene => Talking to Eckart, No Ancestress path 
					is_LargeCutscene_active(enum_releaseRegion) 		&& 
					is_MargaretteTold_NoAncestor(enum_releaseRegion) 	&&
					is_Cutscene_MasterId(0xd1bc0, enum_releaseRegion) 	&&
					on_Cutscene_SectionId_start(enum_releaseRegion))]

					// is_LargeCutscene_active(enum_releaseRegion)				&&
					// is_MargaretteTold_NoAncestor(enum_releaseRegion) 		&&
					// is_Cutscene_MasterId(0xd1bc0, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x48000, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x5b190, enum_releaseRegion))]
			) &&
			once(	// Identifies Cutscene => Looking at painting of Dana
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x12040, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)			&&
				// is_Cutscene_MasterId(0x12040, enum_releaseRegion)	&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)	&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)	&&
				// is_Cutscene_MasterDataId(0xce0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x11330, enum_releaseRegion)
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alt2 = // Alt 2 => Failsafe
			is_ReleaseRegion(enum_releaseRegion) &&			
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			on_Chapter_finish(CHAPTER_Chapter7, enum_releaseRegion)
		return alt1 || alt2}),
	"a_Chapter8Complete": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		alts = {}
		alts[0] = // Alt 1 => Ending A (Talk to Fortune Teller AND Homunculus => return to Hugo)
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Talk to Homunculus
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x8b640, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0x8b640, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x2d440, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x42750, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Summon Dr. Wagner with Homunculus
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x10ef00, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0x10ef00, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x9, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x8, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0xb620, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0xf4d0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Dr. Wagner confronts Hugo
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xe4800, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0xe4800, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x9, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0xa, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x66aa0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x5d060, enum_releaseRegion)
			) &&
			is_MargaretteTold_Ancestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[2] = // Alt 2 => Ending B1 (Talk to Fortune Teller => return to Hugo)
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Talk to Hugo and Margarette
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xd5440, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0xd5440, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x7, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x6, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x41550, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x2b420, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Hugo inside old Alchemist house collapsing
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x716c0, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0x716c0, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x9, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0xa, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x239f0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x19ef0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Eike consoling Margarette
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xf3c80, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)				&&
				// is_Cutscene_MasterId(0xf3c80, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x91c30, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x62030, enum_releaseRegion)
			) &&
			is_MargaretteTold_Ancestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[3] = // Alt 3 => Ending B2 (Talk to Homunculus => return to Hugo)
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Talk to Hugo and Margarette
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xfbd00, enum_releaseRegion) 	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0xfbd00, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x5ff00, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x26f30, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xc4e40, enum_releaseRegion)	&& was_Cutscene_MasterId(0xfbd00, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0xc4e40, enum_releaseRegion)		&& was_Cutscene_MasterId(0xfbd00, enum_releaseRegion) &&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x62650, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x6be0, enum_releaseRegion)
			) &&
			is_MargaretteTold_Ancestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[4] = // Alt 4 => Ending C (Visit destroyed lab => return to Hugo)
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Talk to Homunculus at square after seeing young Hugo erase old Hugo
				is_LargeCutscene_active(enum_releaseRegion) 				&& 
				is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) &&
				is_Cutscene_MasterId(0x1cbc0, enum_releaseRegion)			&&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) && is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) &&
				// is_Cutscene_MasterId(0x1cbc0, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0xc8e0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x98f0, enum_releaseRegion)
			) &&
			is_MargaretteTold_Ancestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[5] = // Alt 5 => Ending D (Did not save Dana => Destroyed Lab)
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Flashback to Hugo trying to read burnt documents
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x77a40, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x29700, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)			&&
				// is_Cutscene_MasterId(0x77a40, enum_releaseRegion)		&& was_Cutscene_MasterId(0x29700, enum_releaseRegion) &&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x31fd0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x45a10, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Eike confronts Hugo at square
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x4b140, enum_releaseRegion)	&& was_Cutscene_MasterId(0x77a40, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)			&&
				// is_Cutscene_MasterId(0x4b140, enum_releaseRegion)		&& was_Cutscene_MasterId(0x77a40, enum_releaseRegion) &&
				// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x122b0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x189f0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Margarette dissapears after Hugo dissappeared
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xc9440, enum_releaseRegion)	&& was_Cutscene_MasterId(0xa00c0, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion)			&&
				// is_Cutscene_MasterId(0xc9440, enum_releaseRegion)		&& was_Cutscene_MasterId(0xa00c0, enum_releaseRegion) &&
				// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x46b50, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x828a0, enum_releaseRegion)
			) &&
			is_Dana_Left_InPast(enum_releaseRegion) && is_MargaretteTold_NoAncestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[6] = // Alt 6 => Ending E (Save Dana => Destroyed Lab)
			unless(
				!is_ReleaseRegion(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) && 
			once(	// Identifies Cutscene => Brought Margarette to present
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x101bc0, enum_releaseRegion)	&& 
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0x101bc0, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x77920, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x725d0, enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Margarette confronts Hugo in square
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x137500, enum_releaseRegion)	&& was_Cutscene_MasterId(0x101bc0, enum_releaseRegion) &&
				on_Cutscene_SectionId_start(enum_releaseRegion)	

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0x137500, enum_releaseRegion)		&& was_Cutscene_MasterId(0x101bc0, enum_releaseRegion) &&
				// is_Cutscene_SectionId_1(0xc, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0xd, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x7bdf0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x55290, enum_releaseRegion)
			) &&
			is_Dana_Saved_FromPast(enum_releaseRegion) && is_MargaretteTold_NoAncestor(enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		alts[7+8] = // Alt 7+8 => Failsafe; triggers on chapter change
			is_ReleaseRegion(enum_releaseRegion) &&			
			repeated(500, // <-- delay necessary, on_chapter_finish() triggers when loading a savefile from chapter start whilst the previously played chapter was the previous chapter.	(eg. load chapter-2 then load chapter-3-start => would unlock this achievement)
				never(!is_InGame(enum_releaseRegion)) &&
				is_InGame(enum_releaseRegion)
			) && 
			!is_ExtraMenu_active(enum_releaseRegion) &&
			(
				on_Chapter_finish(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) ||
				on_Chapter_finish(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
			)
		return any_of(alts, (key) => alts[key])}),
	"a_MaxAchievementPrologue": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Prologue, enum_releaseRegion)),
	"a_MaxAchievementChapter1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter1, enum_releaseRegion)),
	"a_MaxAchievementChapter2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter2, enum_releaseRegion)),
	"a_MaxAchievementChapter3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter3, enum_releaseRegion)),
	"a_MaxAchievementChapter4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter4, enum_releaseRegion)),
	"a_MaxAchievementChapter5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter5, enum_releaseRegion)),
	"a_MaxAchievementChapter6": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter6, enum_releaseRegion)),
	"a_MaxAchievementChapter7": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter7, enum_releaseRegion)),
	"a_MaxAchievementChapter8": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Chapter8, enum_releaseRegion)),
	"a_MaxAchievementEpilogue": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterMaxAchievementRate(CHAPTER_Epilogue, enum_releaseRegion)),
	"a_MaxAchievementTotal": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_TotalMaxAchievementRate(enum_releaseRegion)),
	"a_EndingA": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Chosen to have Margarette stay in present + Z-pad breaks
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xdb780, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	

			// is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// is_Cutscene_MasterId(0xdb780, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1bb0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x32ce0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Finding red jewel in tree at square
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x77f80, enum_releaseRegion)	&& was_Cutscene_MasterId(0xdb780, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)	

			// is_LargeCutscene_active(enum_releaseRegion) && 
			// is_Cutscene_MasterId(0x77f80, enum_releaseRegion)		&& was_Cutscene_MasterId(0xdb780, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x25c50, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x1ac90, enum_releaseRegion)
		) &&		
		is_MargaretteTold_Ancestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_A, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingB1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike returns from sending Margarette back to past
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x613c0, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	

			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x613c0, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x43db0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x1d5d0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x56240, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	

			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x56240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x400d0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x16130, enum_releaseRegion)
		) &&
		is_MargaretteTold_Ancestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_B, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingB2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike talks with Homunculus
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x91240, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	

			// is_LargeCutscene_active(enum_releaseRegion)  			&&
			// is_Cutscene_MasterId(0x91240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x44340, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x41cd0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike gives z-pad back to Homunculus
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x5d2c0, enum_releaseRegion)	&& was_Cutscene_MasterId(0x91240, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x5d2c0, enum_releaseRegion)		&& was_Cutscene_MasterId(0x91240, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1efd0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x2f6d0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x56240, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x56240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x400d0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x16130, enum_releaseRegion)
		) &&
		is_MargaretteTold_Ancestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_B, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingC": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Epilogue_Ancestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Giving z-pad back to Homunculus
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x8cf00, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 	  		&&
			// is_Cutscene_MasterId(0x8cf00, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x44340, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x41cd0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Homunculus has bad feeling
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x7b140, enum_releaseRegion)	&& was_Cutscene_MasterId(0x8cf00, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x7b140, enum_releaseRegion)		&& was_Cutscene_MasterId(0x8cf00, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1d530, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x2f6d0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike getting roadkilled
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xcb700, enum_releaseRegion)	&& was_Cutscene_MasterId(0x7b140, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0xcb700, enum_releaseRegion)		&& was_Cutscene_MasterId(0x7b140, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x6, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1980, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x1e8d0, enum_releaseRegion)
		) &&
		is_MargaretteTold_Ancestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_C, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingD": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Talk to Homunculus at square
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x709c0, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 	  		&&
			// is_Cutscene_MasterId(0x709c0, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x24770, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x11790, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and becomes youthfull
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xc5b40, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0xc5b40, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x4, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x69b40, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x21b40, enum_releaseRegion)
		) &&
		is_Dana_Left_InPast(enum_releaseRegion) && is_MargaretteTold_NoAncestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_D, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingE": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Epilogue_NoAncestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x88dc0, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0x88dc0, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x2c3a0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x5ca00, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and Dr. Wagner is killed
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xbef80, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0xbef80, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x9, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x8, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x59f60, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x155e0, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus some more
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xcdcc0, enum_releaseRegion)	&& was_Cutscene_MasterId(0xbef80, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) 			&&
			// is_Cutscene_MasterId(0xcdcc0, enum_releaseRegion)		&& was_Cutscene_MasterId(0xbef80, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x33230, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x21780, enum_releaseRegion)
		) &&
		is_Dana_Saved_FromPast(enum_releaseRegion) && is_MargaretteTold_NoAncestor(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_E, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingEXKillHomunculus": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Prologue, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => waking up in limbo with Philosopher Stone and destroy Homunculus
			is_LargeCutscene_active(enum_releaseRegion) 							&& 
			is_ItemPresentInInventory(ITEM_PhilosopherStone, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0xa7a80, enum_releaseRegion)						&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_PhilosopherStone, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0xa7a80, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x394f0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x41b0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x1413a0,0x8, enum_releaseRegion)	&&			
			// is_Cutscene_MinorId(0x41b0,0x28, enum_releaseRegion)
		) && 
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x67940, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_Cutscene_MasterId(0x67940, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xd220, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x5a6f0, enum_releaseRegion)
		) &&
		is_PrologueExMode_active(enum_releaseRegion) && is_ExChapter_unlocked(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_EX, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EndingEXCureHelena": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Prologue, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Helena Wagner is cured
			is_LargeCutscene_active(enum_releaseRegion) 							&& 
			is_ItemPresentInInventory(ITEM_PhilosopherStone, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x58c00, enum_releaseRegion)						&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_PhilosopherStone, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x58c00, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x268f0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x11bc0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x721f0,0x8, enum_releaseRegion)	&&			
			// is_Cutscene_MinorId(0x11bc0,0x28, enum_releaseRegion)
		) &&
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x67940, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)	
			
			// is_Cutscene_MasterId(0x67940, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xd220, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x5a6f0, enum_releaseRegion)
		) &&
		is_PrologueExMode_active(enum_releaseRegion) && is_ExChapter_unlocked(enum_releaseRegion) &&
		once(is_Video_active(enum_releaseRegion)) && // Credits video
		trigger_when(
			is_Ending_achieved(ENDING_EX, enum_releaseRegion) &&
			on_Video_end(enum_releaseRegion) // Trigger when Credits video is over/skipped
		)),
	"a_EnergyOrbLocatorPresentDay": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Present, enum_releaseRegion)),
	"a_EnergyOrbLocator70s80s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Late20thCentury, enum_releaseRegion)),
	"a_EnergyOrbLocatorMiddleAges": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_MiddleAges, enum_releaseRegion)),
	"a_EnergyOrbLocator1900Days": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_EnergyCollector(TIMEPERIOD_Early20thCentury, enum_releaseRegion)),
	"a_ShowPocketWatchToPhotographer": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		never(
			!is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 				&& 
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion) 				&&
			!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) 	&&
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Showing Franssen in 1902 the pocket watch
			// ID via old method/with delta check, because is_Cutscene_SectionId_1() stays at 0xffff
			is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_EggPocketWatch, enum_releaseRegion) &&
			is_Cutscene_MasterId(0x114c0, enum_releaseRegion)		&& 
			is_Cutscene_SectionId_1(0xffff, enum_releaseRegion)		&&
			is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			is_Cutscene_MasterDataId(0x114a0, enum_releaseRegion)	&&
			is_Cutscene_SectionDataId(0x114a0, enum_releaseRegion)	&&
			is_Cutscene_MinorId(0xad50, 0x8, enum_releaseRegion)	&&
			is_Cutscene_MinorId(0x114a0, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_DoctorateTimeTraveling": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Info/lore dump about timetravel after defending yourself
			is_LargeCutscene_active(enum_releaseRegion) 					&& 
			(is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion)) && 
			is_Cutscene_MasterId(0xb0100, enum_releaseRegion)				&&
			on_Cutscene_SectionId_start(enum_releaseRegion)
		
			// is_LargeCutscene_active(enum_releaseRegion) && 
			// (is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Sign, enum_releaseRegion)) && 
			// is_Cutscene_MasterId(0xb0100, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0xd, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0xe, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1efb0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xae70, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_MeetOldMiriam": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Holding onto rope 
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x43040, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// is_Cutscene_MasterId(0x43040, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x7ce0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xd940, enum_releaseRegion)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_MargaretteTold_Ancestor(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0xc7940, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)),

				// is_LargeCutscene_active(enum_releaseRegion) && is_MargaretteTold_Ancestor(enum_releaseRegion) && 
				// is_Cutscene_MasterId(0xc7940, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x95c0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x7410, enum_releaseRegion)),
			once(	// Identifies Cutscene => No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_MargaretteTold_NoAncestor(enum_releaseRegion) 	&& 
				is_Cutscene_MasterId(0xb2540, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion))

				// is_LargeCutscene_active(enum_releaseRegion) && is_MargaretteTold_NoAncestor(enum_releaseRegion) && 
				// is_Cutscene_MasterId(0xb2540, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x95c0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x6cf0, enum_releaseRegion))
		]) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_GetOrnamentalEgg": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// DEV_NOTE: Pause Lock with alt reset
		// -------------------------------
		//	- Pause lock = Pause if with hit count
		//	- To reset pause lock: 
		//		- Option 1 => use resetNextIf on the pause with hit count
		//		- Option 2 => place reset in another (alt) group (not recommended when offering multi-region support as there are already alt groups for each region)

		// Example: infinite pause lock when not in correct releaseRegion; Below code will pause this alt group infinitely as there's no resets in any other group and no resetNextIf hooked on to the pause lock
			// unless(repeated(50, !is_ReleaseRegion(enum_releaseRegion))) && // <-- repeated for 50 frames, just in case this value initializes later then on game boot; instead of once
			// unless(	
			// 	!is_InGame(enum_releaseRegion) ||
			// 	is_ExtraMenu_active(enum_releaseRegion) ||
			// 	!is_Chapter(CHAPTER_Chapter1, enum_releaseRegion)
			// ) &&
			// once(	// Identifies Cutscene => Acquiring ornamental egg from performer	
			// 	is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// 	is_Cutscene_MasterId(0x19380, enum_releaseRegion)		&& 
			// 	is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// 	is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// 	is_Cutscene_MasterDataId(0xd5f0, enum_releaseRegion)	&&
			// 	is_Cutscene_SectionDataId(0xe10, enum_releaseRegion)
			// ) &&
			// trigger_when(
			// 	is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) && 
			// 	on_Cutscene_end(enum_releaseRegion)
			// )
		
		// Option 1 (example: pause lock when not in correct chapter, with resetNextIf)
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(once(	// <-- Pause lock
				never(on_Chapter_changeTo(CHAPTER_Chapter1, enum_releaseRegion)) &&	// <-- ResetNextIf for the pause lock
				!is_Chapter(CHAPTER_Chapter1, enum_releaseRegion)
			)) &&
			unless(
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion)
			) &&
			once(	// Identifies Cutscene => Acquiring ornamental egg from performer
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Cutscene_MasterId(0x19380, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)

				// is_LargeCutscene_active(enum_releaseRegion) 			&& 
				// is_Cutscene_MasterId(0x19380, enum_releaseRegion)	&& 
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0xd5f0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0xe10, enum_releaseRegion)
			) &&
			trigger_when(
				is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) && 
				on_Cutscene_end(enum_releaseRegion)
			)

		// Original code (without pause lock)
			// unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			// never(
			// 	!is_InGame(enum_releaseRegion) ||
			// 	is_ExtraMenu_active(enum_releaseRegion) ||
			// 	!is_Chapter(CHAPTER_Chapter1, enum_releaseRegion)
			// ) &&
			// once(	// Identifies Cutscene => Acquiring ornamental egg from performer
			// 	is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// 	is_Cutscene_MasterId(0x19380, enum_releaseRegion)		&& 
			// 	is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// 	is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// 	is_Cutscene_MasterDataId(0xd5f0, enum_releaseRegion)	&&
			// 	is_Cutscene_SectionDataId(0xe10, enum_releaseRegion)
			// ) &&
			// trigger_when(
			// 	is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) && 
			// 	on_Cutscene_end(enum_releaseRegion)
			// )
		),
	"a_GetExChapterOrnamentalEgg": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Prologue, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => EX Chapter, performer throws egg
			is_LargeCutscene_active(enum_releaseRegion) && 			
			is_PrologueExMode_active(enum_releaseRegion) &&	is_ExChapter_unlocked(enum_releaseRegion) &&			
			is_Cutscene_MasterId(0x30780, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) &&
			// is_PrologueExMode_active(enum_releaseRegion) &&	is_ExChapter_unlocked(enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x30780, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xd5f0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xe10, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x7fd10,0x8, enum_releaseRegion)	&&			
			// is_Cutscene_MinorId(0xe10,0x28, enum_releaseRegion)
		) &&
		trigger_when(
			is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) && 
			is_NoCutscene_active(enum_releaseRegion)
		)),
	"a_EggCollection": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		never(
			!is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) && 
			!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion) && 
			!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) 
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 1 OR 4	
				(is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) || is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)) &&			
				is_LargeCutscene_active(enum_releaseRegion) 						&&
				is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) 	&&
				is_Cutscene_MasterId(0x2f9c0, enum_releaseRegion)					&&
				on_Cutscene_SectionId_start(enum_releaseRegion)),

				// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) &&
				// (
				// 	is_Chapter(CHAPTER_Chapter1, enum_releaseRegion) || is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)
				// ) &&
				// is_Cutscene_MasterId(0x2f9c0, enum_releaseRegion)		&& 
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x59c0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x5c20, enum_releaseRegion)),
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 3
				is_LargeCutscene_active(enum_releaseRegion) 						&&
				is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)  					&&
				is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) 	&&
				is_Cutscene_MasterId(0x32200, enum_releaseRegion)					&&
				on_Cutscene_SectionId_start(enum_releaseRegion))

				// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_OrnamentalEgg, enum_releaseRegion) &&
				// is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)		&&
				// is_Cutscene_MasterId(0x32200, enum_releaseRegion)		&& 
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x59c0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x5c20, enum_releaseRegion))
		]) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_RunningAcrossThe90s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) { return
			tally(2, [
				once( // Talk to JoggingMan_Present
					is_SmallCutscene_active(enum_releaseRegion) &&
					(
						is_Area(AREA_Present_City_Day, enum_releaseRegion) 		|| 
						is_Area(AREA_Present_City_NightPM, enum_releaseRegion)	||
						is_Area(AREA_Present_City_NightAM, enum_releaseRegion)
					) &&
					on_TalkingToNPC_bis(NPC_Present_JoggingMan, enum_releaseRegion)), // <-- use on_TalkingToNPC_bis() version, because we are not checking is_InteractionId(); Fix for talking to NPC => quitting game without getting another cutscene => re-entering same chapter => measure will add another hit count
				once( // Talk to JoggingMan_80s
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_Area(AREA_70s_City_Night, enum_releaseRegion) &&
					on_TalkingToNPC_bis(NPC_80s_JoggingMan, enum_releaseRegion)), // <-- use on_TalkingToNPC_bis() version, because we are not checking is_InteractionId(); Fix for talking to NPC => quitting game without getting another cutscene => re-entering same chapter => measure will add another hit count
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion) && 
				!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) && 
				!is_Chapter(CHAPTER_Chapter5, enum_releaseRegion)
			) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_ShowEggTownPlanter": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Show off egg to town planter
			is_LargeCutscene_active(enum_releaseRegion) 						&& 
			is_SelectedItemInScrollBar(ITEM_OrnamentalEgg, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0xde00, enum_releaseRegion)					&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_OrnamentalEgg, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0xde00, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x3, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x29d0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xb400, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_EggPocketWatchForCoffee": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_ItemPresentInInventory(ITEM_EggPocketWatch, enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 				&& 
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion) 				&& 
			!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) 	&& 
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Instantly pay for the coffee with egg shaped pocket watch
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Area(AREA_1900s_City, enum_releaseRegion)	 	&& 
				is_Cutscene_MasterId(0x8b440, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion)),

				// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_1900s_City, enum_releaseRegion) && 
				// is_Cutscene_MasterId(0x8b440, enum_releaseRegion) 		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x3b3a0, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x50080, enum_releaseRegion)	&&
				// is_Cutscene_MinorId(0xdefe0, 0x8, enum_releaseRegion)	&&
				// is_Cutscene_MinorId(0x50080, 0x28, enum_releaseRegion)),
			once(	// Identifies Cutscene => Drank coffee before acquiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
				is_LargeCutscene_active(enum_releaseRegion) 		&& 
				is_Area(AREA_1900s_City, enum_releaseRegion)	 	&& 
				is_Cutscene_MasterId(0xac4c0, enum_releaseRegion)	&&
				on_Cutscene_SectionId_start(enum_releaseRegion))

				// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_1900s_City, enum_releaseRegion) && 
				// is_Cutscene_MasterId(0xac4c0, enum_releaseRegion) 		&&
				// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
				// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
				// is_Cutscene_MasterDataId(0x5ac20, enum_releaseRegion)	&&
				// is_Cutscene_SectionDataId(0x51870, enum_releaseRegion)	&&
				// is_Cutscene_MinorId(0x7ec30, 0x8, enum_releaseRegion)	&&
				// is_Cutscene_MinorId(0x2f730, 0x2c, enum_releaseRegion))
		]) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_PocketWatchCollection": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Show off egg pocket watch to barman in present
			is_LargeCutscene_active(enum_releaseRegion) 						&& 
			is_ItemPresentInInventory(ITEM_EggPocketWatch, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x8ce80, enum_releaseRegion)					&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_EggPocketWatch, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x8ce80, enum_releaseRegion) 		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x4c600, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x236a0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x70640, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x236a0, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_PocketWatchReminiscing": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Chapter8_Ancestress, enum_releaseRegion) && 
			!is_Chapter(CHAPTER_Chapter8_NoAncestress, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike and Eckart talk about film director and his pocket watches
			is_LargeCutscene_active(enum_releaseRegion) 						&& 
			is_ItemPresentInInventory(ITEM_EggPocketWatch, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x8dcc0, enum_releaseRegion)					&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_ItemPresentInInventory(ITEM_EggPocketWatch, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x8dcc0, enum_releaseRegion) 		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x31a90, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xa420, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0xdfbc0, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0xa420, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_EikeThePyromancer": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into pyromancer statue
			is_LargeCutscene_active(enum_releaseRegion) && 
			is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			is_TreeReplacedBy_Statue(enum_releaseRegion) && is_CrowdScaredWith_Lighter(enum_releaseRegion) &&
			is_Cutscene_MasterId(0x3b240, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_TreeReplacedBy_Statue(enum_releaseRegion) && is_CrowdScaredWith_Lighter(enum_releaseRegion) &&			
			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x3b240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x340e0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x7130, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_EikeTheMagician": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into magician statue
			is_LargeCutscene_active(enum_releaseRegion) && 
			is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			is_TreeReplacedBy_Statue(enum_releaseRegion) && is_CrowdScaredWith_Cellphone(enum_releaseRegion) &&	
			is_Cutscene_MasterId(0x3b240, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_TreeReplacedBy_Statue(enum_releaseRegion) && is_CrowdScaredWith_Cellphone(enum_releaseRegion) &&			
			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x3b240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x340e0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x7130, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_EikeTheFlorist": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into flowers
			is_LargeCutscene_active(enum_releaseRegion) && 
			is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			is_TreeReplacedBy_Flowers(enum_releaseRegion) &&
			is_Cutscene_MasterId(0x3b240, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_TreeReplacedBy_Flowers(enum_releaseRegion) &&
			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_Dpad, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x3b240, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x340e0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x7130, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_BarmansChildren": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter5, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Talk to barman about grandchildren
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xd0200, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && 
			// is_Cutscene_MasterId(0xd0200, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x3d290, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x92f30, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_LostYoungCouple1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// OG code => player has to restart chapter when loading a save in which player has talked to one NPC already/already progresses the side quest
			// '''''''''''''''''''''''''''''''
			//	function measuredComparison(enum_releaseRegion) { return
			//		tally(6, [
			//			once(	// 1st talk with woman
			//				is_SmallCutscene_active(enum_releaseRegion) && // Below line --> When having talked to other half of couple already, this isLostYoungCoupleProgressChap2 would become 0x1 at same time on_NPC_TalkCount_hitsMax() counts
			//				(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) && 
			//				on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth", enum_releaseRegion) &&	
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x420, enum_releaseRegion)),
			//			once(	// 1st talk with man
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x40d, enum_releaseRegion)),
			//			once( 	// 2nd talk with woman; is only available when having talked to both at least once
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x421, enum_releaseRegion)),
			//			once(	// 2nd talk with man; is only available when having talked to both at least once
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x40e, enum_releaseRegion)),
			//			once(	// 3rd talk with woman
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x422, enum_releaseRegion)),
			//			once(	// 3rd talk with man
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x40f, enum_releaseRegion))
			//		])}
			//	return 
			//		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			//		never(
			//			!is_InGame(enum_releaseRegion) || 
			//			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
			//		) &&
			//		measured(
			//			measuredComparison(enum_releaseRegion), 
			//			when = is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)
			//		) &&
			//		trigger_when(on_Cutscene_end(enum_releaseRegion))
			//	}),	
		// Active code => player can still unlock achievement when loading a save in which he has progressed in this side quest + shorter logic
		let_sumOf_currentNPCtalkCounts = 
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch", enum_releaseRegion)

		let_sumOf_prevNPCtalkCounts =
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch", enum_releaseRegion)

		let_totalTalkCount = 
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_WestGate_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap2_EastNearHay_AfterLocationSwitch") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_EastNearHay_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap2_WestGate_AfterLocationSwitch")
		
		return 
			// Core alt group
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)) &&
			once( // <-- Hit once, so we can use trigger popup
				let_sumOf_prevNPCtalkCounts == let_totalTalkCount-1 && // <-- 2 lines save protection => when loading a savefile that has already talked to these NPCs must not unlock achievement
				let_sumOf_currentNPCtalkCounts == let_totalTalkCount		// Inside once so we can use trigger_when()
			) &&
			measured(let_sumOf_currentNPCtalkCounts == let_totalTalkCount) &&
			is_LostYoungCoupleState_Chapter2(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion)) 
			|| // Reset alt group => otherwise hit once, might not reset when going to title screen from an area not mentioned in unless(!is_Area()) below
			never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) &&
				(
					!is_InGame(enum_releaseRegion) ||
					!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
				)
			)}),
	"a_LostYoungCouple2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// OG code => player has to restart chapter when loading a save in which player has talked to one NPC already/already progresses the side quest
			// '''''''''''''''''''''''''''''''
			//	function measuredComparison(enum_releaseRegion) { return
			//		tally(6, [
			//			once(	// 1st talk with woman
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x423, enum_releaseRegion)),
			//			once(	// 1st talk with man
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x410, enum_releaseRegion)),
			//			once(	// 2nd talk with woman; only available when talking to both at least once
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x424, enum_releaseRegion)),
			//			once(	// 2nd talk with man; only available when talking to both at least once
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x411, enum_releaseRegion)),
			//			once(	// 3rd talk with woman
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x425, enum_releaseRegion)),
			//			once(	// 3rd talk with man
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x412, enum_releaseRegion))
			//		])}
			//	return 
			//		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			//		never(
			//			!is_InGame(enum_releaseRegion) || 
			//			!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)
			//		) &&
			//		measured(measuredComparison(enum_releaseRegion), when = is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)) &&
			//		trigger_when(on_Cutscene_end(enum_releaseRegion))
			//	}),
		// Active code => player can still unlock achievement when loading a save in which he has progressed in this side quest + shorter logic
		let_sumOf_currentNPCtalkCounts = 
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch", enum_releaseRegion)

		let_sumOf_prevNPCtalkCounts =
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch", enum_releaseRegion)

		let_totalTalkCount = 
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_NearNorthEastGate_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap3_OutsideChurch_AfterLocationSwitch") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_NearWell_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap3_TownSquare_AfterLocationSwitch")
		
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)) &&
			once( // <-- Hit once, so we can use trigger popup
				let_sumOf_prevNPCtalkCounts == let_totalTalkCount-1 && // <-- 2 lines save protection => when loading a savefile that has already talked to these NPCs must not unlock achievement
				let_sumOf_currentNPCtalkCounts == let_totalTalkCount		// Inside once so we can use trigger_when()
			) &&
			measured(let_sumOf_currentNPCtalkCounts == let_totalTalkCount) &&
			is_LostYoungCoupleState_Chapter3(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
			|| // Reset alt group => otherwise hit once, might not reset when going to title screen from an area not mentioned in unless(!is_Area()) below
			never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) &&
				(
					!is_InGame(enum_releaseRegion) ||
					!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)
				)
			)}),
	"a_LostYoungCouple3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// OG code => player has to restart chapter when loading a save in which player has talked to one NPC already/already progresses the side quest
			// '''''''''''''''''''''''''''''''
			//	function measuredComparison(enum_releaseRegion) { return
			//		tally(6, [
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x426, enum_releaseRegion)),
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToNone, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x413, enum_releaseRegion)),
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x427, enum_releaseRegion)),
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothOnce, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x414, enum_releaseRegion)),
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x428, enum_releaseRegion)),
			//			once(
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				(is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_talkedToBothTwice, enum_releaseRegion) || is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion)) &&	
			//				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion) &&
			//				is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x415, enum_releaseRegion))				
			//		])}
			//	return 
			//		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			//		never(	
			//			!is_InGame(enum_releaseRegion) ||
			//			!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)
			//		) &&
			//		measured(measuredComparison(enum_releaseRegion), is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)) &&
			//		trigger_when(on_Cutscene_end(enum_releaseRegion))
			//	}),
		// Active code => player can still unlock achievement when loading a save in which he has progressed in this side quest + shorter logic
		let_sumOf_currentNPCtalkCounts = 
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth", enum_releaseRegion) +
			current_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion)

		let_sumOf_prevNPCtalkCounts =
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch", enum_releaseRegion)

		let_totalTalkCount = 
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_OutsideChurch_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleWoman, "Chap4_NearBakery_AfterLocationSwitch") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_BeforeTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_TownSquare_AfterTalkingToBoth") +
			get_NPC_MaxTalkCount(NPC_MiddleAges_YoungCoupleMan, "Chap4_NearBakery_AfterLocationSwitch")

		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion)) &&
			once( // <-- Hit once, so we can use trigger popup
				let_sumOf_prevNPCtalkCounts == let_totalTalkCount-1 &&
				let_sumOf_currentNPCtalkCounts == let_totalTalkCount
			) &&
			measured(let_sumOf_currentNPCtalkCounts == let_totalTalkCount) &&
			is_LostYoungCoupleState_Chapter4(STATE_YOUNGCOUPLE_bothHaveRespawned, enum_releaseRegion) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
			|| // Reset alt group => otherwise hit once, might not reset when going to title screen from an area not mentioned in unless(!is_Area()) below
			never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) &&
				(
					!is_InGame(enum_releaseRegion) ||
					!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)
				)
			)}),
	"a_LostYoungCouple4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter5, enum_releaseRegion)
			) &&
			once(
				is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Day, enum_releaseRegion) &&
				is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
				on_NPC_TalkCount_increase(NPC_MiddleAges_YoungCoupleMan, "Chap5_NearSouthEastGate", enum_releaseRegion) &&
				is_InteractionChapterId(0x4b, enum_releaseRegion) && is_InteractionId(0x416, enum_releaseRegion)
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_LostYoungCouple5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// When having talked twice to the man in Chapter 5 => 2nd talk to woman in this chapter unlocks dialogue option
		// Too many variations here => just count twice, once for talking with man and once with woman
		alt_core = 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_MiddleAges_City_Day, enum_releaseRegion)) &&
			measured(tally(2, [
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 
					on_TalkingToNPC_bis(NPC_MiddleAges_YoungCoupleWoman, enum_releaseRegion) &&
					is_InteractionChapterId(0x3b, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 
					on_TalkingToNPC_bis(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
					is_InteractionChapterId(0x3b, enum_releaseRegion))			
			])) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion)) 
		
		alt_reset = 
			never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) &&
				(
					!is_InGame(enum_releaseRegion) ||
					!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
				)
			)

		return alt_core || alt_reset}),
	"a_LostYoungCouple6": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) { return
			tally(2, [
				once(	// 1st talk with man, having a dialogue option
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_WomanAdvisedBeTruthful(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_MiddleAges_YoungCoupleMan, "Chap8_OutsideChurch_AfterExperiment_WomanTruthful", enum_releaseRegion) &&
					is_InteractionChapterId(0x13, enum_releaseRegion) && is_InteractionId(0x41c, enum_releaseRegion)),
				repeated(2, // 2nd talk with man after telling him about 'lovers never destines to meet' // Repeated here --> allows player to save/load in between the 2 interactions and still have the achievement unlockable
					// There's no TalkCount for the dialogue that comes after the dialogue choice => count this one differently
					is_SmallCutscene_active(enum_releaseRegion) &&		
					is_WomanAdvisedBeTruthful(enum_releaseRegion) &&
					is_ManToldLoversNeverDestinedMeet(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_MiddleAges_YoungCoupleMan, enum_releaseRegion) &&					
					is_InteractionChapterId(0x13, enum_releaseRegion) && is_InteractionId(0x433, enum_releaseRegion))
			])}
		return 
			// Core alt group
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_MiddleAges_City_Day, enum_releaseRegion)) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
			|| // Reset alt group => allows to reset tally measurement when outside of AREA_MiddleAges_City_Day
			never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) &&
				(
					!is_InGame(enum_releaseRegion) ||
					!is_Chapter(CHAPTER_Chapter8, enum_releaseRegion)
				)
			)
		}),
	"a_EnigmaticCouple1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// OG code => player has to restart chapter when loading a save in which player has talked to one NPC already
			// function measuredComparison(enum_releaseRegion) { return
			// 	tally(4, [
			// 		repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap1Prologue_TownSquare"),
			// 			is_SmallCutscene_active(enum_releaseRegion) &&
			// 			is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
			// 			on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare", enum_releaseRegion) &&
			// 			is_InteractionId(0x2cc, enum_releaseRegion)),
			// 		repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap1Prologue_NearBar"), 
			// 			is_SmallCutscene_active(enum_releaseRegion) &&
			// 			is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
			// 			on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap1Prologue_NearBar", enum_releaseRegion) &&
			// 			is_InteractionId(0x2c1, enum_releaseRegion))
			// 	])}
			// return 
			// 	unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			// 	never(	
			// 		!is_InGame(enum_releaseRegion) ||
			// 		!is_Chapter(CHAPTER_Prologue, enum_releaseRegion) && !is_Chapter(CHAPTER_Chapter1, enum_releaseRegion)
			// 	) &&
			// 	measured(measuredComparison(enum_releaseRegion), is_Area(AREA_Present_City_Day, enum_releaseRegion)) &&
			// 	trigger_when(on_Cutscene_end(enum_releaseRegion))}),

		// Active code => player can still unlock achievement when loading a save in which he has previously talked to one of the NPCs before
		let_sumOf_currentNPCtalkCounts = 
			current_NPCtalkCount(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare", enum_releaseRegion) +
			current_NPCtalkCount(NPC_Present_CoatedMan, "Chap1Prologue_NearBar", enum_releaseRegion)

		let_sumOf_prevNPCtalkCounts =
			prev_NPCtalkCount(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_Present_CoatedMan, "Chap1Prologue_NearBar", enum_releaseRegion)

		let_totalTalkCount = 
			get_NPC_MaxTalkCount(NPC_Present_CoatedWoman, "Chap1Prologue_TownSquare") +
			get_NPC_MaxTalkCount(NPC_Present_CoatedMan, "Chap1Prologue_NearBar")
		
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_Present_City_Day, enum_releaseRegion)) &&
			never(				
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Prologue, enum_releaseRegion) &&
				!is_Chapter(CHAPTER_Chapter1, enum_releaseRegion)
			) &&
			once( // <-- Hit once, so we can use trigger popup
				let_sumOf_prevNPCtalkCounts == let_totalTalkCount-1 &&
				let_sumOf_currentNPCtalkCounts == let_totalTalkCount
			) &&
			measured(let_sumOf_currentNPCtalkCounts == let_totalTalkCount) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))}),
	"a_EnigmaticCouple2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// We cannot use AddSource like a_EnigmaticCouple1 because meAddr_TalkCount for NPC_Present_CoatedWoman->Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar counts for chapters 3+4
		// Thus alternative method is active below
		function measuredComparison_onIncrease(enum_releaseRegion) { return	// Measure comparison => counts up for each seperate dialogue
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"), 
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_releaseRegion) &&
					is_InteractionId(0x2d0, enum_releaseRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop", enum_releaseRegion) &&
					is_InteractionId(0x2c4, enum_releaseRegion))
			])}
		function measuredComparison_atMax(enum_releaseRegion) { return	// Measure comparison => counts up to MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_releaseRegion) &&
					is_InteractionId(0x2d0, enum_releaseRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap3_NearAntiqueShop"), 
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap3_NearAntiqueShop", enum_releaseRegion) &&
					is_InteractionId(0x2c4, enum_releaseRegion))
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_Present_City_Day, enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(
				measured(measuredComparison_onIncrease(enum_releaseRegion)) || 
				measured(measuredComparison_atMax(enum_releaseRegion))
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))}),
	"a_EnigmaticCouple3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// We cannot use AddSource like a_EnigmaticCouple1 because meAddr_TalkCount for NPC_Present_CoatedWoman->Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar counts for chapters 3+4
		// Thus alternative method is active below
		function measuredComparison_onIncrease(enum_releaseRegion) { return // Measure comparison => counts up for each seperate dialogue
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_releaseRegion) &&
					is_InteractionId(0x2d0, enum_releaseRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
					on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch", enum_releaseRegion) &&
					is_InteractionId(0x2c5, enum_releaseRegion))
			])}
		function measuredComparison_atMax(enum_releaseRegion) { return	// Measure comparison => counts up to MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar", enum_releaseRegion) &&
					is_InteractionId(0x2d0, enum_releaseRegion)),
				repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap4_HaupStrUnderArch"), 
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap4_HaupStrUnderArch", enum_releaseRegion) &&
					is_InteractionId(0x2c5, enum_releaseRegion))
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_Present_City_Day, enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion)
			) &&	// 2 Alt groups => measuredComparison_atMax(), achievement is still unlockable when reloading mid-measurement
			(
				measured(measuredComparison_onIncrease(enum_releaseRegion)) || 
				measured(measuredComparison_atMax(enum_releaseRegion))
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))}),
	"a_EnigmaticCouple4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// Too many variations => just count once for interacting with man and once with woman
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_Present_City_NightPM, enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter5, enum_releaseRegion)
			) &&
			measured(tally(2, [
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					on_TalkingToNPC_bis(NPC_Present_CoatedWoman, enum_releaseRegion) &&
					is_InteractionChapterId(0x4b, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					on_TalkingToNPC_bis(NPC_Present_CoatedMan, enum_releaseRegion) &&
					is_InteractionChapterId(0x4b, enum_releaseRegion)),			
			])) && 			
			trigger_when(on_Cutscene_end(enum_releaseRegion))}),
	"a_EnigmaticCouple5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// Commented code => allows loadings mid-measurement
			//	function measuredComparison_onIncrease(enum_releaseRegion) { return
			//		tally(3, [
			//			repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_releaseRegion) &&
			//				is_InteractionChapterId(0xb2, enum_releaseRegion) && is_InteractionId(0x2d3, enum_releaseRegion)),
			//			repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
			//				on_NPC_TalkCount_increase(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_releaseRegion) &&
			//				is_InteractionChapterId(0xb2, enum_releaseRegion) && is_InteractionId(0x2c8, enum_releaseRegion))
			//		])}
			//	function measuredComparison_atMax(enum_releaseRegion) { return
			//		tally(3, [
			//			repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedWoman,"Chap7_SouthGate"),
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_Present_CoatedWoman, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_releaseRegion) &&
			//				is_InteractionChapterId(0xb2, enum_releaseRegion) && is_InteractionId(0x2d3, enum_releaseRegion)),
			//			repeated(get_NPC_MaxTalkCount(NPC_Present_CoatedMan,"Chap7_NorthWestGate"), 
			//				is_SmallCutscene_active(enum_releaseRegion) &&
			//				is_TalkingToNPC(NPC_Present_CoatedMan, enum_releaseRegion) &&
			//				is_NPCtalkCount_atMax(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_releaseRegion) &&
			//				is_InteractionChapterId(0xb2, enum_releaseRegion) && is_InteractionId(0x2c8, enum_releaseRegion))
			//		])}
			//	return 
			//		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			//		unless(!is_Area(AREA_Present_City_NightAM, enum_releaseRegion)) &&
			//		never(	
			//			!is_InGame(enum_releaseRegion) ||
			//			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
			//		) &&
			//		(
			//			measured(measuredComparison_onIncrease(enum_releaseRegion)) || 
			//			measured(measuredComparison_atMax(enum_releaseRegion))
			//		) &&
			//		trigger_when(on_Cutscene_end(enum_releaseRegion))}),
		// Active code => alternative way with AddSource
		let_sumOf_currentNPCtalkCounts = 
			current_NPCtalkCount(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_releaseRegion) +
			current_NPCtalkCount(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_releaseRegion)

		let_sumOf_prevNPCtalkCounts =
			prev_NPCtalkCount(NPC_Present_CoatedWoman, "Chap7_SouthGate", enum_releaseRegion) +
			prev_NPCtalkCount(NPC_Present_CoatedMan, "Chap7_NorthWestGate", enum_releaseRegion)

		let_totalTalkCount = 
			get_NPC_MaxTalkCount(NPC_Present_CoatedWoman, "Chap7_SouthGate") +
			get_NPC_MaxTalkCount(NPC_Present_CoatedMan, "Chap7_NorthWestGate")
		
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless(!is_Area(AREA_Present_City_NightAM, enum_releaseRegion)) &&
			never(				
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
			) &&
			once( // <-- Hit once, so we can use trigger popup
				let_sumOf_prevNPCtalkCounts == let_totalTalkCount-1 &&
				let_sumOf_currentNPCtalkCounts == let_totalTalkCount
			) &&
			measured(let_sumOf_currentNPCtalkCounts == let_totalTalkCount) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))}),			
	"a_BecomeThePerformer": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			on_Cutscene_MasterId_change(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike gives himself a message as performer
			is_LargeCutscene_active(enum_releaseRegion) 		&&
			is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) 	&&
			is_SelectedItemInScrollBar(ITEM_Jugglery, enum_releaseRegion) &&
			is_Cutscene_MasterId(0x1a300, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) &&
			// is_SelectedItemInScrollBar(ITEM_Jugglery, enum_releaseRegion) &&
			// is_WearingPerformerOutfit(enum_releaseRegion)			&&
			// is_Cutscene_MasterId(0x1a300, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xd440, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x3a00, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_GiveMargaretteCake": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 1st time
			is_LargeCutscene_active(enum_releaseRegion) 		&&
			is_SelectedItemInScrollBar(ITEM_Cake, enum_releaseRegion) &&
			is_Cutscene_MasterId(0x10b000, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_Cake, enum_releaseRegion) && 
			// is_Cutscene_MasterId(0x10b000, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xadb40, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x5d4a0, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_PerformerGoingExtraMile": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) { return
			tally(7, [
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeYoungBoy, enum_releaseRegion) &&
					is_Area(AREA_Present_City_Day, enum_releaseRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeYoungBoy, "Chap4_WearingPerformerOutfit", enum_releaseRegion) &&
					is_InteractionChapterId(0x44, enum_releaseRegion) && is_InteractionId(0x39c, enum_releaseRegion)),	// IDs last dialogue sequence on this NPC's appearance
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteMother, enum_releaseRegion) &&
					is_Area(AREA_Present_City_Day, enum_releaseRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteMother, "Chap4_WearingPerformerOutfit", enum_releaseRegion) &&
					is_InteractionChapterId(0x44, enum_releaseRegion) && is_InteractionId(0x336, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteYoungGirl, enum_releaseRegion) &&
					is_Area(AREA_Present_City_Day, enum_releaseRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BrunetteYoungGirl, "Chap4_WearingPerformerOutfit", enum_releaseRegion) &&
					is_InteractionChapterId(0x44, enum_releaseRegion) && is_InteractionId(0x323, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeOldWomanOrangeSweater, enum_releaseRegion) &&
					is_Area(AREA_Present_City_Day, enum_releaseRegion) &&
					// on_NPC_TalkCount_hitsMax(NPC_Present_BlondeOldWomanOrangeSweater, "Chap4_WearingPerformerOutfit", enum_releaseRegion) &&
					is_InteractionChapterId(0x44, enum_releaseRegion) && is_InteractionId(0x32c, enum_releaseRegion)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BrunetteAdultManGlasses, enum_releaseRegion) &&
					is_Area(AREA_Present_TownHall, enum_releaseRegion) &&
					is_InteractionChapterId(0x29, enum_releaseRegion) && is_InteractionId(0x3c6, enum_releaseRegion)),
				once(	// This appearance does not have a memory address for talk count
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_TalkingToNPC(NPC_Present_BlondeElderlyWoman, enum_releaseRegion) &&
					is_Area(AREA_Present_TownHall, enum_releaseRegion) &&
					is_InteractionChapterId(0x29, enum_releaseRegion) && is_InteractionId(0x3cc, enum_releaseRegion)),
				once(	// This counts Eike, giving egg to Eike/yourself
					is_LargeCutscene_active(enum_releaseRegion) &&
					is_SelectedItemInScrollBar(ITEM_Jugglery, enum_releaseRegion) &&
					is_Cutscene_MasterId(0x1a300, enum_releaseRegion)		&&
					is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
					is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					is_Cutscene_MasterDataId(0xd440, enum_releaseRegion)	&&
					is_Cutscene_SectionDataId(0x3a00, enum_releaseRegion))
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) ||
				repeated(300, !is_WearingPerformerOutfit(enum_releaseRegion))	// ---> Repeat is necessary, because bit flag for is_WearingPerformerOutfit() changes to 0 for a few frames when loading from/into townhall/city 
			) &&																// 			=> we don't want the measure count to reset in here 		
			measured(measuredComparison(enum_releaseRegion)) &&			
			trigger_when( // Can only trigger after the cutscene when giving egg to past Eike
				on_Cutscene_end(enum_releaseRegion) || 
				on_CutsceneSection_end(enum_releaseRegion)
			)
		}), 
	"a_ScareEveryone": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) { return
			tally(6, [
				once(	// Identifies cutscene => scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
					is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_Present_CafeSonne, enum_releaseRegion) &&
					is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion) &&
					is_Cutscene_MasterId(0x9000, enum_releaseRegion)	&&
					is_Cutscene_SectionId_1(0xffff, enum_releaseRegion)	&&
					is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					is_Cutscene_MasterDataId(0x9000, enum_releaseRegion)	&&
					is_Cutscene_SectionDataId(0x9000, enum_releaseRegion)	&&
					is_Cutscene_MinorId(0x5f80, 0x8, enum_releaseRegion)	&&
					is_Cutscene_MinorId(0x9000, 0x28, enum_releaseRegion)),
				
				// Don't do a repeated(4) => because player could skip and is_CrowdScaredWith_Cellphone()+is_CrowdScaredWith_Lighter() use the same bit
				once(	// Identifies cutscene => scaring crowd with cellphone; instead of below cutscene
					is_LargeCutscene_active(enum_releaseRegion) 		&&
					is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion) &&
					is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					is_Cutscene_MasterId(0xc6e00, enum_releaseRegion)	&&
					on_Cutscene_SectionId_start(enum_releaseRegion)),

					// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					// is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion) &&
					// is_Cutscene_MasterId(0xc6e00, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x5ad0, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0x55b0, enum_releaseRegion)	&&
					// is_Cutscene_MinorId(0x2451a0, 0x8, enum_releaseRegion)	&&
					// is_Cutscene_MinorId(0x55b0, 0x28, enum_releaseRegion)),				
				once(	// Identifies cutscene => scaring crowd with lighter; instead of above cutscene
					is_LargeCutscene_active(enum_releaseRegion) 		&&
					is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) &&
					is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					is_Cutscene_MasterId(0xa84c0, enum_releaseRegion)	&&
					on_Cutscene_SectionId_start(enum_releaseRegion)),

					// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					// is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) &&
					// is_Cutscene_MasterId(0xa84c0, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
					// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					// is_Cutscene_MasterDataId(0x2e40, enum_releaseRegion)	&&
					// is_Cutscene_SectionDataId(0xb220, enum_releaseRegion)	&&
					// is_Cutscene_MinorId(0x2354f0, 0x8, enum_releaseRegion)	&&
					// is_Cutscene_MinorId(0xb220, 0x28, enum_releaseRegion)),

				once(	// Identifies cutscene => scaring town planter 				
					is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion)) &&
					is_Cutscene_MasterId(0x98c0, enum_releaseRegion)		&&
					is_Cutscene_SectionId_1(0xffff, enum_releaseRegion)		&&
					is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
					is_Cutscene_MasterDataId(0x9890, enum_releaseRegion)	&&
					is_Cutscene_SectionDataId(0x9890, enum_releaseRegion)	&&
					is_Cutscene_MinorId(0xcd30, 0x8, enum_releaseRegion)	&&
					is_Cutscene_MinorId(0x9890, 0x28, enum_releaseRegion)),
				once(	// Identifies cutscene => scaring eccentric girl
					is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_EccentricGirl, "Chap2_TownSquare_Scare", enum_releaseRegion) &&
					is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x314, enum_releaseRegion)),				
				once(	// Identifies cutscene => scaring straw hat man
					is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_StrawHatMan, "Chap2_Streets_Scare", enum_releaseRegion) &&
					is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x2da, enum_releaseRegion)),
				once(	// Identifies cutscene => scaring aspiring apprentice
					is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_MiddleAges_City_Night, enum_releaseRegion) &&
					(is_SelectedItemInScrollBar(ITEM_Lighter, enum_releaseRegion) || is_SelectedItemInScrollBar(ITEM_Cellphone, enum_releaseRegion)) &&
					is_NPCtalkCount_atMax(NPC_MiddleAges_AspiringApprentice, "Chap2_SouthEastGate_Scare", enum_releaseRegion) &&
					is_InteractionChapterId(0x163, enum_releaseRegion) && is_InteractionId(0x2e3, enum_releaseRegion))
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(	
				!is_InGame(enum_releaseRegion) ||
				is_ExtraMenu_active(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion)
			) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_FreeMeal": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter5, enum_releaseRegion) ||
			is_FirePutOutBy_Eike(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Barman gives Eike free meal
			is_LargeCutscene_active(enum_releaseRegion) 			&&
			is_Cutscene_MasterId(0x62840, enum_releaseRegion)		&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// is_Cutscene_MasterId(0x62840, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x261a0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x6cc0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x9bd60, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x6cc0, 0x28, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Reading book whilst barman gets Eike his meal + poison
			is_LargeCutscene_active(enum_releaseRegion) 			&&
			is_Cutscene_MasterId(0xf9cc0, enum_releaseRegion)		&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// is_Cutscene_MasterId(0xf9cc0, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x5eb0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xf3df0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x2aea60, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0xf3df0, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_NewCakeInvented": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 2nd time
			is_LargeCutscene_active(enum_releaseRegion) 				&&
			is_SelectedItemInScrollBar(ITEM_Cake, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x1fd80, enum_releaseRegion)			&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_Cake, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x1fd80, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0xffff, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1fd50, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x1fd50, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x153d0, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x122b0, 0x2c, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_MaxInventory": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_biggestPossibleInventoryCount = 20

		let_sumOf_deltaItemCount = sum_of(const_Items_data, (item) {
				let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][enum_releaseRegion]
				return prev(bit0(let_memAddress))})
		let_sumOf_currentItemCount = sum_of(const_Items_data, (item) {
			let_memAddress = const_Items_data[item]["memAddress_Flag_isInInventory"][enum_releaseRegion]
			return bit0(let_memAddress)})

		return 
			once(
				let_sumOf_deltaItemCount > (let_biggestPossibleInventoryCount/4)*3 	&& // <-- 3 lines: save protection  => loading a savefile which already has 20 items must not unlock achievement
				let_sumOf_deltaItemCount < let_biggestPossibleInventoryCount 		&&		// Two delta comparisons needed in case more than 1 item is acquired in one frame, although this shouldn't be possible
				let_sumOf_currentItemCount == let_biggestPossibleInventoryCount
			) &&
			measured(
				let_sumOf_currentItemCount == let_biggestPossibleInventoryCount,
				when = 	
					is_ReleaseRegion(enum_releaseRegion) &&
					is_InGame(enum_releaseRegion) &&
					!is_ExtraMenu_active(enum_releaseRegion)
			) &&	
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),		
	"a_DrunkenGuys": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison_onMax(enum_releaseRegion) { return
			tally(2, [
				once(	// Identifies Cutscene => talking to slim delinquent
					is_SmallCutscene_active(enum_releaseRegion) && 
					is_TalkingToNPC(NPC_Present_SlimDelinquent, enum_releaseRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_SlimDelinquent, "Chap7_CarPark", enum_releaseRegion) &&
					is_InteractionChapterId(0xb2, enum_releaseRegion) && 
					is_InteractionId(0x2f5, enum_releaseRegion)),
				once(	// Identifies Cutscene => talking to broad delinquent
					is_SmallCutscene_active(enum_releaseRegion) && 
					is_TalkingToNPC(NPC_Present_BroadDelinquent, enum_releaseRegion) &&
					on_NPC_TalkCount_hitsMax(NPC_Present_BroadDelinquent, "Chap7_CarPark", enum_releaseRegion) &&
					is_InteractionChapterId(0xb2, enum_releaseRegion) && 
					is_InteractionId(0x2f0, enum_releaseRegion))
			])}
		function measuredComparison_atMax(enum_releaseRegion) { return // AtMax => failsafe when player has loaded a save where he has already talked to them
			tally(2, [
				once(	// Identifies Cutscene => talking to slim delinquent
					is_SmallCutscene_active(enum_releaseRegion) && 
					is_TalkingToNPC(NPC_Present_SlimDelinquent, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_SlimDelinquent, "Chap7_CarPark", enum_releaseRegion) &&
					is_InteractionChapterId(0xb2, enum_releaseRegion) && 
					is_InteractionId(0x2f5, enum_releaseRegion)),
				once(	// Identifies Cutscene => talking to broad delinquent
					is_SmallCutscene_active(enum_releaseRegion) && 
					is_TalkingToNPC(NPC_Present_BroadDelinquent, enum_releaseRegion) &&
					is_NPCtalkCount_atMax(NPC_Present_BroadDelinquent, "Chap7_CarPark", enum_releaseRegion) &&
					is_InteractionChapterId(0xb2, enum_releaseRegion) && 
					is_InteractionId(0x2f0, enum_releaseRegion))
			])}
		return 
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
			) && (
				measured(measuredComparison_onMax(enum_releaseRegion), when = is_Area(AREA_Present_City_NightAM, enum_releaseRegion)) ||
				measured(measuredComparison_atMax(enum_releaseRegion), when = is_Area(AREA_Present_City_NightAM, enum_releaseRegion))
			) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_ShortestChapter": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter4, enum_releaseRegion) ||
			
			// If preventing 1st death in chapter 4 by using the frying pan 
			//	=> black and white picture is not found inside book during this chapter
			//	=> Thus can be used as a flag for this achievement
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_NoPerformer, enum_releaseRegion) || 
			is_ItemPresentInInventory(ITEM_BlackWhitePhoto_WithPerformer, enum_releaseRegion)			 
		) &&
		once(	// Identifies Cutscene => Using frying pan for defence
			is_LargeCutscene_active(enum_releaseRegion) 					&&
			is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x4f200, enum_releaseRegion)				&&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_SelectedItemInScrollBar(ITEM_FryingPan, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x4f200, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x11cd0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x3d500, enum_releaseRegion)	
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_MeetFamousOleg": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Talking to Oleg near movie poster
			is_LargeCutscene_active(enum_releaseRegion) 		&&
			is_CoffeePayed(enum_releaseRegion) 					&&
			is_Cutscene_MasterId(0xa0f40, enum_releaseRegion)	&&
			on_Cutscene_SectionId_start(enum_releaseRegion)
			
			// is_LargeCutscene_active(enum_releaseRegion) && is_CoffeePayed(enum_releaseRegion) &&
			// is_Cutscene_MasterId(0xa0f40, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x45370, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x5bb90, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x8f8e0, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x5bb90, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_ArtInspiration1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			on_Chapter_change(enum_releaseRegion) ||
			is_BrumEstate_Library(enum_releaseRegion)
		) && 
		tally(1, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
			once(
				is_SmallCutscene_active(enum_releaseRegion) && 
				is_Painting_TowerView_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_TowerView, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, enum_releaseRegion) || 
					is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, enum_releaseRegion)
				) &&
				is_InteractionId(0x124, enum_releaseRegion)),			
			once(
				is_SmallCutscene_active(enum_releaseRegion) && 	
				is_Painting_SquireCrest_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_SquireCrest, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
				) &&
				is_InteractionId(0x125, enum_releaseRegion)),
			once(
				is_SmallCutscene_active(enum_releaseRegion) &&
				is_Painting_Marktplatz_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_TownSquare, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) ||
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
				) &&
				is_InteractionId(0x126, enum_releaseRegion)),
			once(
				is_SmallCutscene_active(enum_releaseRegion) &&
				is_Painting_Antidote_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
				) &&	
				is_InteractionId(0x127, enum_releaseRegion)),
			once(
				is_SmallCutscene_active(enum_releaseRegion) &&
				is_Painting_Performer_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_Performer, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
				) &&	
				is_InteractionId(0x128, enum_releaseRegion)),
			once(
				is_SmallCutscene_active(enum_releaseRegion) &&
				is_Painting_HouseCollapse_inspired(enum_releaseRegion) &&
				is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, enum_releaseRegion) && 
				(
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
					is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
				) &&	
				is_InteractionId(0x129, enum_releaseRegion))
		]) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))), // Trigger when cutscene is over
	"a_ArtInspirationAll": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) {
			tally(6, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 
					is_Painting_TowerView_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TowerView, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x124, enum_releaseRegion)),			
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 	
					is_Painting_SquireCrest_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x125, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_Painting_Marktplatz_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) ||
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x126, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_Painting_Antidote_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x127, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_Painting_Performer_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Performer, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x128, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_Painting_HouseCollapse_inspired(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x129, enum_releaseRegion))
			])}
		return
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				on_Chapter_change(enum_releaseRegion)
			) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_ArtAppreciator": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) {
			tally(8, [
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 	
					is_InteractingWith(INTERACTABLE_Painting_TowerView, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Downstairs_Room_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x124, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) && 	
					is_InteractingWith(INTERACTABLE_Painting_SquireCrest, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x125, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_TownSquare, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room1_Day, enum_releaseRegion)
					) &&
					is_InteractionId(0x126, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_AlchemyLab, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x127, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Performer, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x128, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_CollapsedHouse, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room2_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0x129, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_LandscapeTown, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0xffffffff, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Painting_Alchemist, enum_releaseRegion) && 
					(
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Night, enum_releaseRegion) || 
						is_Area(AREA_Present_BrumMuseum_Upstairs_Room3_Day, enum_releaseRegion)
					) &&	
					is_InteractionId(0xffffffff, enum_releaseRegion))
			])}
		return
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				on_Chapter_change(enum_releaseRegion)
			) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_AntiquesEule": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		function measuredComparison(enum_releaseRegion) {
			tally(4, [
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Antique_FranssenShopSign, enum_releaseRegion) && 
					is_InteractionId(0xffffffff, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Antique_Rope, enum_releaseRegion) &&
					is_InteractionId(0xffffffff, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Antique_Antidote, enum_releaseRegion) &&
					is_InteractionId(0xffffffff, enum_releaseRegion)),
				once(
					is_SmallCutscene_active(enum_releaseRegion) &&
					is_InteractingWith(INTERACTABLE_Antique_Mask, enum_releaseRegion) &&
					is_InteractionId(0xffffffff, enum_releaseRegion))
			])}

		// DEV_NOTE: Multiple PauseIf flags  
		// ----------------------------------
		//	- The top/first pauses are evaluated first; Pauses evaluate from top to bottom (1,2,3...)
		//	- In below example: if the achievement logic gets past unless(!is_ReleaseRegion()) and is paused on the next unless() => then you can say pauseIf(!is_ReleaseRegion() && !is_Area())

		// DEV_NOTE: Measured with: MeasuredIf or PauseIf 
		// ----------------------------------
		//	MeasuredIf  => is purely to control the visual feedback (UI) through the RAoverlay (measured hit count will always evaluate/continue counting, regardless of MeasuredIf-state) 
		//		- MeasuredIf is false => 0 will be displayed in RAoverlay, but the measured hit count will still evaluate/will continue counting behind the scenes, even when MeasuredIf-false) + the measured popup will not been shown
		//		- MeasuredIf is true => the current measured hit count will be shown (the one that kept evaluating/counting behind the scenes) + the popup is able to be displayed whenever the measured hit count changes (the popup will also be briefly displayed once MeasuredIf becomes true, even when the measured hit count didn't change)
		//
		//	PauseIf  => is purely to stop evaluation, the current measured progress is still visible in RAoverlay
		//		- PauseIf is true => the measured hit count will be put on hold (hit count cannot change) + the hit count will still be displayed (won't display 0 in RAoverlay). Take care, pause will also stop 'reset' flags in same group + Pauses are evaluated from top to bottom
		//		- PauseIf is false => continue evaluating other logic (measured hit count will continue evaluating)

		return
			unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			unless( // <-- this 'pause if' needs to be after/lower than is_ReleaseRegion()
				!is_Area(AREA_80s_AntiquesEule, enum_releaseRegion) &&	// This is not placed inside 'measured if', because otherwise it won't show the count outside this area and it may count outside this area as well
				!is_Area(AREA_Present_AntiquesEule, enum_releaseRegion)
			) &&
			never(
				!is_InGame(enum_releaseRegion) ||
				on_Chapter_change(enum_releaseRegion)
			) &&
			measured(measuredComparison(enum_releaseRegion)) &&
			trigger_when(on_Cutscene_end(enum_releaseRegion))
		}),
	"a_SeenOlegAsWell": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 
		) &&
		once(	// Identifies Cutscene => Talking with man inside Cafe Sonne for 1st time, only in chapter 6
			is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_80s_CafeSonne, enum_releaseRegion) &&
			is_TalkingToNPC(NPC_80s_OlderMan, enum_releaseRegion) && 
			is_InteractionChapterId(0xb2, enum_releaseRegion) && is_InteractionId(0x3e7, enum_releaseRegion) && 
			has_startedTalkingToNPC_forFirstTime(NPC_80s_OlderMan, "Chap6_CafeSonne", enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_PocketWatchTo80sBarman": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Using pocket watch or ornamental egg near barman in 1980s
			is_SmallCutscene_active(enum_releaseRegion) && is_Area(AREA_80s_Bar, enum_releaseRegion) &&
			(
				is_SelectedItemInScrollBar(ITEM_EggPocketWatch, enum_releaseRegion) ||
				is_SelectedItemInScrollBar(ITEM_OrnamentalEgg, enum_releaseRegion)
			) &&
			is_TalkingToNPC(NPC_80s_Barman, enum_releaseRegion) && is_InteractionId(0x2ed, enum_releaseRegion) &&
			is_NPCtalkCount_atMax(NPC_80s_Barman, "InsideBar_UsePocketWatchOrEgg", enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_SnowyCrimeScene": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Miriam shot and dying 
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Area(AREA_80s_City_Snow, enum_releaseRegion) 	&&
			is_Chapter(CHAPTER_Chapter6, enum_releaseRegion)	&&
			is_Cutscene_MasterId(0x756c0, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_80s_City_Snow, enum_releaseRegion) &&
			// is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 		&&
			// is_Cutscene_MasterId(0x756c0, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x4660, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x4f210, enum_releaseRegion) 	&&
			// is_Cutscene_MinorId(0xb8b90, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x4f210, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_SaveMiriamBrum": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)			 
		) &&
		once(	// Identifies Cutscene => Eike save Miriam, after running after her
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Area(AREA_80s_City_Snow, enum_releaseRegion) 	&&
			is_Chapter(CHAPTER_Chapter6, enum_releaseRegion)	&&
			is_Cutscene_MasterId(0xebac0, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_80s_City_Snow, enum_releaseRegion) &&
			// is_Chapter(CHAPTER_Chapter6, enum_releaseRegion)	&&
			// is_Cutscene_MasterId(0xebac0, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x546f0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x50b0, enum_releaseRegion)	
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_HugoMotherChild": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Hugo gets bullied
			is_LargeCutscene_active(enum_releaseRegion) 			&& 
			is_Area(AREA_MiddleAges_City_Day, enum_releaseRegion) 	&&
			is_Chapter(CHAPTER_Chapter5, enum_releaseRegion)		&&
			is_Cutscene_MasterId(0x3ed00, enum_releaseRegion)		&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x3ed00, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x3110, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x3bbc0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x282ae0, 0x8, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x3bbc0, 0x28, enum_releaseRegion)
		) &&
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
 	"a_TimeTravellingCat": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Giving kitten to Sibylla
			is_LargeCutscene_active(enum_releaseRegion) 				&& 
			is_Area(AREA_1900s_BrumMansion, enum_releaseRegion) 		&&
			is_ItemPresentInInventory(ITEM_Kitten, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x25200, enum_releaseRegion)			&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) && is_Area(AREA_1900s_BrumMansion, enum_releaseRegion) &&
			// is_ItemPresentInInventory(ITEM_Kitten, enum_releaseRegion) &&
			// is_Cutscene_MasterId(0x25200, enum_releaseRegion)		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x2c00, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x10930, enum_releaseRegion)
		) &&
		trigger_when(			
			is_KittenGivenToSibylla(enum_releaseRegion) &&
			on_Cutscene_end(enum_releaseRegion)
		)),
	"a_ErasingEike": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Prologue, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike wakes himself up
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x9c00, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)				&&
			// is_Cutscene_MasterId(0x9c00, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x9bf0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x9bf0, enum_releaseRegion)	&&
			// is_Cutscene_MinorId(0x9bf0, 0x28, enum_releaseRegion) 	&&
			// is_Cutscene_MinorId(0xea70, 0x8, enum_releaseRegion) 	
		) && 
		once(	// Identifies Cutscene => Talking with Homunculus in Limbo after death
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x237c0, enum_releaseRegion)	&& was_Cutscene_MasterId(0x9c00, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)				&&
			// is_Cutscene_MasterId(0x237c0, enum_releaseRegion)		&& was_Cutscene_MasterId(0x9c00, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x18930, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xae60, enum_releaseRegion)
		) && 
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_ErasingEike2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Eike bumps into himself
			// Some reason this cutscene works differently from rest. This is the only way to ID this cutscene
			is_Cutscene_MinorId(0x23ee0, 0x8, enum_releaseRegion) 	&&
			is_Cutscene_MinorId(0x377e0, 0x28, enum_releaseRegion) 	&&
			is_Cutscene_MinorId(0x23eb0, 0x2c, enum_releaseRegion)
		) && 
		trigger_when(on_Cutscene_end(enum_releaseRegion))),
	"a_RottenRope": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter7, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Holding on to rotten rope
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x15640, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)	&&
			// is_Cutscene_MasterId(0x15640, enum_releaseRegion) 		&&
			// is_Cutscene_SectionId_1(0x5, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x6, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x7830, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x2220, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Waking up in Limbo after death
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x237c0, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x15640, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)	&&
			// is_Cutscene_MasterId(0x237c0, enum_releaseRegion) 		&& was_Cutscene_MasterId(0x15640, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x18930, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xae60, enum_releaseRegion)
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_TimeEgoFlop": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once( // Identifies Cutscene => Roadkilled by Time Ego movie
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_MovieTimeTravel_chosen(enum_releaseRegion)		&&
			is_MovieWorldConquest_chosen(enum_releaseRegion) 	&&	
			is_Chapter(CHAPTER_Chapter6, enum_releaseRegion) 	&&
			is_Cutscene_MasterId(0x77980, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion) 			&& 
			// is_MovieTimeTravel_chosen(enum_releaseRegion)			&&
			// is_MovieWorldConquest_chosen(enum_releaseRegion) 		&&
			// is_Cutscene_MasterId(0x77980, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x59240, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x1e730, enum_releaseRegion)
		) && 
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_MetYouBefore": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion)	||				
			is_ExtraMenu_active(enum_releaseRegion) ||
			!is_Chapter(CHAPTER_Chapter2, enum_releaseRegion) 
		) &&
		once(	// Identifies Cutscene => Talk Dana, seeing through clothing hunch
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x6e480, enum_releaseRegion)	&& 
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)				&&	
			// is_Cutscene_MasterId(0x6e480, enum_releaseRegion) 		&& 
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x45250, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x143f0, enum_releaseRegion)	
		) && 
		once(	// Identifies Cutscene => Getting stabbed from behind
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x1b740, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x6e480, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)				&&	
			// is_Cutscene_MasterId(0x1b740, enum_releaseRegion) 		&& was_Cutscene_MasterId(0x6e480, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x1d00, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x19a20, enum_releaseRegion)	
		) && 
		trigger_when(on_CutsceneSection_end(enum_releaseRegion))),
	"a_ExcuseMeMyMy": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			is_ExtraMenu_active(enum_releaseRegion)	||
			!is_Chapter(CHAPTER_Chapter3, enum_releaseRegion)
		) &&
		once(	// Identifies Cutscene => Picking dialogue option with Homunculus: 'excuse me'
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0xb140, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x5aa80, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)			&&
			// is_Cutscene_MasterId(0xb140, enum_releaseRegion) 	&& was_Cutscene_MasterId(0x5aa80, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x2, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0x5ac0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0x38b0, enum_releaseRegion)	
		) && 
		once(	// Identifies Cutscene => Waking up in limbo after dying to vase
			is_LargeCutscene_active(enum_releaseRegion) 		&& 
			is_Cutscene_MasterId(0x1a440, enum_releaseRegion) 	&& was_Cutscene_MasterId(0xb140, enum_releaseRegion) &&
			on_Cutscene_SectionId_start(enum_releaseRegion)

			// is_LargeCutscene_active(enum_releaseRegion)			&&
			// is_Cutscene_MasterId(0x1a440, enum_releaseRegion) 	&& was_Cutscene_MasterId(0xb140, enum_releaseRegion) &&
			// is_Cutscene_SectionId_1(0x1, enum_releaseRegion)		&&
			// is_Cutscene_SectionId_2(0x0, enum_releaseRegion)		&&
			// is_Cutscene_MasterDataId(0xd9a0, enum_releaseRegion)	&&
			// is_Cutscene_SectionDataId(0xca50, enum_releaseRegion)	
		) &&
		trigger_when(on_CutsceneSection_end(enum_releaseRegion)))
	}

// =====================
// • Achievements TEXT •
// =====================
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_PrologueComplete": 							{"en": "Defied Fate",															
													"nl": "Lot Getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1CompleteByEike": 					{"en": "Defied Fate... Again",
													"nl": "Lot Getrotseerd... Nogmaals",
													"fr": "Défié le Destin... Encore"},
	"a_Chapter1CompleteByBarman": 					{"en": "There's a Fire!"}, 
	"a_Chapter2Complete": 							{"en": "Left in the Past"},
	"a_Chapter3Complete": 							{"en": "An Alchemist, a Jewel and a Homunculus"},
	"a_Chapter4CompletePan": 						{"en": "Pan-tastic Resilience"},
	"a_Chapter4CompleteSign": 						{"en": "Through the Lens of Survival"},	
	"a_Chapter5Complete": 							{"en": "Ancient Elixir"}, 
	"a_Chapter6CompleteThriller":					{"en": "Director's Cut: The Time of Reckoning"},
	"a_Chapter6CompleteLove":						{"en": "Director's Cut: Trip for Two"},
	"a_Chapter7Complete":							{"en": "A Friend's Repentance"},
	"a_Chapter8Complete":							{"en": "The Whole Picture... Or is it?"},
	"a_EndingEXKillHomunculus":						{"en": "The Philosopher's Destiny"},
	"a_EndingEXCureHelena":							{"en": "The Philosopher's Legacy"},
	"a_MaxAchievementPrologue":						{"en": "Homing Instinct"},	
	"a_MaxAchievementChapter1":						{"en": "In the Heat of Time"},	
	"a_MaxAchievementChapter2":						{"en": "Dana Kusch"},		
	"a_MaxAchievementChapter3":						{"en": "The Root of the Problem"},	
	"a_MaxAchievementChapter4":						{"en": "The Monochrome Era"},	
	"a_MaxAchievementChapter5":						{"en": "Meddling with Destiny"},
	"a_MaxAchievementChapter6":						{"en": "The Good Samaritan"},
	"a_MaxAchievementChapter7":						{"en": "Vintage Knots"},
	"a_MaxAchievementChapter8":						{"en": "The Power of Fate"},
	"a_MaxAchievementEpilogue":						{"en": "Eternal Youth"},
	"a_MaxAchievementTotal":						{"en": "The Day of Walpurgis"},
	"a_EndingA":									{"en": "An End to a Strange Experience"},
	"a_EndingB1":									{"en": "No Sense of Finality I"},
	"a_EndingB2":									{"en": "No Sense of Finality II"},
	"a_EndingC": 									{"en": "If Only... I Had One More Attempt"},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "The Future Is What We Make It"},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "The Philosopher's Wisdom"},
	"a_DoctorateTimeTraveling": 					{"en": "Complexities of the Fourth Dimension"}, 
	"a_GetOrnamentalEgg": 							{"en": "A Performer's Clue"}, 
	"a_EggCollection": 								{"en": "A Jovial Exchange"},
	"a_BarmansChildren":							{"en": "The Barman's Mystery Child"},
	"a_ShowEggTownPlanter": 						{"en": "Cracking Open the Past: Middle Ages"},
	"a_EggPocketWatchForCoffee": 					{"en": "Cracking Open the Past: The Old Century"},
	"a_PocketWatchCollection": 						{"en": "A Hatchless Replica"},
	"a_PocketWatchReminiscing": 					{"en": "The Eggcellent Director's Tale"},
	"a_EikeThePyromancer":							{"en": "The Pyromancer's Legacy"},
	"a_EikeTheMagician": 							{"en": "The Magician's Legacy"},
	"a_EikeTheFlorist": 							{"en": "A Blossoming Plan"},
	"a_LostYoungCouple1": 							{"en": "Yesteryears Couple I: Destined to Miss"},
	"a_LostYoungCouple2": 							{"en": "Yesteryears Couple II: The Place Where We Nigh Met"},
	"a_LostYoungCouple3": 							{"en": "Yesteryears Couple III: Destiny's Promise Fulfilled"},
	"a_LostYoungCouple4": 							{"en": "Yesteryears Couple IV: Man-in-waiting"},
	"a_LostYoungCouple5": 							{"en": "Yesteryears Couple V: Parting"},
	"a_LostYoungCouple6": 							{"en": "Yesteryears Couple VI: Never Destined to Meet"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic Couple I: Prelude"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic Couple II: Tailing"},
	"a_EnigmaticCouple3": 							{"en": "Enigmatic Couple III: Wandering Once More"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic Couple IV: Origins"},
	"a_EnigmaticCouple5": 							{"en": "Enigmatic Couple V: Epilogue"},
	"a_ErasingEike": 								{"en": "That's a Big No No"}, 
	"a_ErasingEike2": 								{"en": "Bump... Erased"},
	"a_RottenRope": 								{"en": "Fated to Plunge"},
	"a_MetYouBefore": 								{"en": "Met You Before"},
	"a_DrunkenGuys":								{"en": "A Pair of Delinquents"},
	"a_ShowPocketWatchToPhotographer":				{"en": "Horologic Heritage"},
	"a_TimeTravellingCat":							{"en": "Nine Lives Across Generations"},
	"a_SnowyCrimeScene":							{"en": "Picked Up a Baby the Other Day"},
	"a_SaveMiriamBrum":								{"en": "Illusive Guardian of the Brums"},
	"a_HugoMotherChild":							{"en": "A Mother's Child"}, 
	"a_SeenOlegAsWell": 							{"en": "The Meditating Man"}, 
	"a_PocketWatchTo80sBarman": 					{"en": "That's Nice!"},
	"a_FreeMeal":									{"en": "A Complimentary Dinner"}, 
	"a_TimeEgoFlop":								{"en": "Time Ego Flop"},
	"a_ArtAppreciator": 							{"en": "Strokes of Destiny"}, 
	"a_AntiquesEule": 								{"en": "Timeless Antiques"},
	"a_RunningAcrossThe90s":						{"en": "Running Beyond the 90's... And 80's"},
	"a_ExcuseMeMyMy":								{"en": "My My, So Eager to Die"},
	"a_BecomeThePerformer":							{"en": "Even I Can Do That"}, 
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Energy Locator: Present Day"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Energy Locator: Middle Ages"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Energy Locator: The Late 20th Century"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Locator: The Early 20th Century"},
	"a_GiveMargaretteCake": 						{"en": "Time-Spun Sweets"}, 
	"a_ShortestChapter": 							{"en": "Pan in Advance"}, 
	"a_NewCakeInvented": 							{"en": "Legacy of Sweetness"},
	"a_MaxInventory": 								{"en": "Stockpiling Across Eras"},
	"a_PerformerGoingExtraMile": 					{"en": "A Performance Gone the Extra Mile"}, 
	"a_ArtInspiration1": 							{"en": "Art Muse"}, 
	"a_ArtInspirationAll": 							{"en": "Eike Franssen"},
	"a_MeetFamousOleg":								{"en": "The Next Big Thing"},
	"a_ScareEveryone": 								{"en": "Terror of Destinies"}}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_PrologueComplete": 							{"en": "Complete the Prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1CompleteByEike":						{"en": "Complete Chapter 1 by personally quelling the looming danger"},
	"a_Chapter1CompleteByBarman": 					{"en": "Complete Chapter 1 by notifying the young boy's grandpa of an approaching threat"},
	"a_Chapter2Complete": 							{"en": "Complete Chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete Chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete Chapter 4 using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete Chapter 4 using a sign"},	
	"a_Chapter5Complete": 							{"en": "Complete Chapter 5"}, 
	"a_Chapter6CompleteThriller":					{"en": "Complete Chapter 6 by co-directing a thriller picture"},
	"a_Chapter6CompleteLove":						{"en": "Complete Chapter 6 by co-directing a love picture"},
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
	"a_RunningAcrossThe90s":						{"en": "Encounter an athletic man from a bygone era, as well as his Present self during Chapter 3, 4 or 5"},
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from an entertainer in Chapter 1"},
	"a_ShowEggTownPlanter": 						{"en": "Present the barman's ancestor with your egg collection in Chapter 2"},
	"a_EggPocketWatchForCoffee": 					{"en": "Pay for some coffee with an oval shaped object from Chapter 6 onward"},
	"a_BarmansChildren":							{"en": "Uncover the truth about the barman's grandchildren in Chapter 5"},
	"a_PocketWatchCollection": 						{"en": "Share your egg collection with a younger barman during Chapter 7"},
	"a_PocketWatchReminiscing": 					{"en": "Share stories about your newly acquired pocket watch with Eckart in Chapter 8"},
	"a_EggCollection": 								{"en": "Exchange an egg for a pan during Chapter 1, 3 or 4"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "Obtain one final message during the EX Chapter"},	
	"a_ShowPocketWatchToPhotographer":				{"en": "Kindle the joy of watchmaking to an ancestor of the Franssen's"},
	"a_EikeThePyromancer": 							{"en": "Ascend to reverence as a pyrokinetic in Chapter 2"},
	"a_EikeTheMagician": 							{"en": "Ascend to renown as a magician in Chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Set up a floral display in Chapter 2"},
	"a_MeetOldMiriam":								{"en": "Meet Eckart's wife in Chapter 7, after your valiant act"},
	"a_LostYoungCouple1": 							{"en": "Aid a bewildered young couple in their reunion amidst the Medieval era during Chapter 2"}, 
	"a_LostYoungCouple2": 							{"en": "Weave the threads of fate into another chance at reunion for a lost young couple amidst the Medieval era during Chapter 3"},
	"a_LostYoungCouple3": 							{"en": "Successfully orchestrate the reunion of the lost young couple amidst the Medieval era during Chapter 4"},
	"a_LostYoungCouple4": 							{"en": "Assess the developments surrounding the young man amidst the Medieval era during Chapter 5"},
	"a_LostYoungCouple5": 							{"en": "Review the latest occurrences involving the young couple amidst the Medieval era during Chapter 7"},
	"a_LostYoungCouple6": 							{"en": "Share a piece of wisdom with the young man and assess his interpretation amidst the Medieval era during Chapter 8"},
	"a_EnigmaticCouple1": 							{"en": "Identify the coated man and woman in the Present during the Prologue or Chapter 1"}, 
	"a_EnigmaticCouple2": 							{"en": "Discover the coated man and woman in the Present during Chapter 3"}, 
	"a_EnigmaticCouple3": 							{"en": "Seek out the coated man and woman in the Present during Chapter 4"}, 
	"a_EnigmaticCouple4": 							{"en": "Encounter the coated man and woman in the Present during Chapter 5"},	
	"a_EnigmaticCouple5": 							{"en": "Find the coated man and woman in the Present during Chapter 7"},
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
	"a_MaxInventory": 								{"en": "Accrue the largest arsenal of items within a single playthrough"},
	"a_PerformerGoingExtraMile": 					{"en": "Highlight the significance of going above and beyond, especially for those, including yourself, who would truly value the performer's effort"}, 	
	"a_ArtInspiration1": 							{"en": "Inspire a renowned artist and appraise his work"}, 
	"a_ArtInspirationAll": 							{"en": "Become a beacon of inspiration for a prominent artist and assess all his works"}}


// ===============================
// • Achievements INITIALIZATION •
// ===============================
//	- Creates achievement objects (accepted by RATools) based on the achievement dictionary (achievements_coreData)
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
	
	function achievements_getType(string_achievementCategory) {
		let_type = achievements_typeByCategory[string_achievementCategory]
		if(let_type == sNULL) return "" // <-- will result in type: "standard"
		return let_type}	
	
	for let_categoryName in achievements_coreData { // This loop generates the achievements
		for let_cheevmentName in achievements_coreData[let_categoryName] {
			let_achievementData = achievements_coreData[let_categoryName][let_cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = achievements_generateTitle(let_cheevmentName, let_categoryName, util_language),
				type = achievements_getType(let_categoryName),
				description = achievements_generateDescription(let_cheevmentName, let_achievementData["devInfo"], util_language),
				points = let_achievementData["points"],
				trigger = achievements_getTrigger(let_cheevmentName)
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

// =====================
// • RichPresence TEXT •
// =====================
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	

	"rp_isPaused":										{"en": "Paused ⏸️ time  | The Fated 🕑 {0} | Current 📆 {1} April {2} 🕑 {3} | Completion: {4}%"},
	"rp_InGameEXChapterOnly":							{"en": "Ending the cycle | The Fated 🕑 {0} | Current 🕑 {1}:{2} | Completion: {3}%"},
	"rp_InGameChapterOnly":								{"en": "{0} | The Fated 🕑 {1} | Current 🕑 {2}{3}:{4}{5} | Completion: {6}%"},
	"rp_InGameChapterWithTimePeriod": 					{"en": "{0} {1} | The Fated 🕑 {2} | Current 🕑 {3}{4}:{5}{6} | Completion: {7}%"},
	"rp_AtTitleScreen":									{"en": "Title Screen | Completion {0}%"},

	"rp_DefaultPlus":									{"en": "Wandering Lebensbaum | Completion {0}%"},	
	"rp_Default":										{"en": "Wandering Lebensbaum"}}
richPresence_LookupTablesText = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	
	// "rp_Template_LookupFallback": 					{"en": "xxxxxxxx"},	

	"rpp_FatedHourBis_Prologue": 						{"en": "14h30"},
	"rpp_FatedHourBis_Chapter1": 						{"en": "15h00"},
	"rpp_FatedHourBis_Chapter2": 						{"en": "15h30"},
	"rpp_FatedHourBis_Chapter3": 						{"en": "17h50"},
	"rpp_FatedHourBis_Chapter4": 						{"en": "20h30"},
	"rpp_FatedHourBis_Chapter5": 						{"en": "22h30"},
	"rpp_FatedHourBis_Chapter6": 						{"en": "23h55"},
	"rpp_FatedHourBis_Chapter7": 						{"en": "01h30"},
	"rpp_FatedHourBis_Chapter8": 						{"en": "04h30"},
	"rpp_FatedHourBis_LookupFallback":					{"en": "a mystery"},

	"rpp_FatedHour_Prologue": 							{"en": "14:30"},
	"rpp_FatedHour_Chapter1": 							{"en": "15:00"},
	"rpp_FatedHour_Chapter2": 							{"en": "15:30"},
	"rpp_FatedHour_Chapter3": 							{"en": "17:50"},
	"rpp_FatedHour_Chapter4": 							{"en": "20:30"},
	"rpp_FatedHour_Chapter5": 							{"en": "22:30"},
	"rpp_FatedHour_Chapter6": 							{"en": "23:55"},
	"rpp_FatedHour_Chapter7": 							{"en": "01:30"},
	"rpp_FatedHour_Chapter8": 							{"en": "04:30"},
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
	"rpp_TimePeriod_Present":							{"en": "in the Present"},
	"rpp_TimePeriod_LookupFallback":					{"en": ""}}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_parameterKey, string_lookupValue) {
	let_lookupTableTextKey = format("{0}_{1}", string_parameterKey, string_lookupValue)
	return richPresence_LookupTablesText[let_lookupTableTextKey][util_language]}
// -----------------LookupTables--------------------
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
// ------------------CustomZeroPadding-------------------
function richPresence_addZeroPaddingLookupTable(string_lookupTableName, int_numberOfZerosToPad, int_maxLookupValueKey) {
	// Example output: richPresence_addZeroPaddingLookupTable("rpp_DateTime_ZeroPadding", 1, 24) => adds below table to richPresence_lookupTables
		// '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		//	"rpp_DateTime_ZeroPadding": {
		//		0: "0",
		//		1: "0",
		//		2: "0",
		//		3: "0",
		//		4: "0",
		//		5: "0",
		//		6: "0",
		//		7: "0",
		//		8: "0",
		//		9: "0",
		//		10: "",
		//		11: "",
		//		12: "",
		//		13: "",
		//		14: "",
		//		15: "",
		//		16: "",
		//		17: "",
		//		18: "",
		//		19: "",
		//		20: "",
		//		21: "",
		//		22: "",
		//		23: "",
		//		24: "",
		//		""
		//	},

	let_string_zeros = ""
	if (int_numberOfZerosToPad < 1) util_throwError("Number of zeros to pad must be bigger than 0")
	for let_i in range(0, int_numberOfZerosToPad-1) let_string_zeros = let_string_zeros + "0"

	let_dict_lookupTable = {}
	for let_i in range(0, int_maxLookupValueKey) {
		if (let_i < 10) let_dict_lookupTable[let_i] = let_string_zeros
		else if (let_i < 100) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 1) // <-- substring() will return let_string_zeros minus 1 "0" 	=> eg. "000" -> "00"
		else if (let_i < 1000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 2)
		else if (let_i < 10000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 3)
		else if (let_i < 100000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 4)
		else if (let_i < 1000000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 5)
		else if (let_i < 10000000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 6)
		else util_throwError("Support for higher values is not implemented")
	}

	richPresence_lookupTables[string_lookupTableName] = let_dict_lookupTable}

function richPresence_initializeZeroPaddingLookupTables() { // Function is called in richPresence_initialize()
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeMinutes_ZeroPadding", 1, 59)
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeHours_ZeroPadding", 1, 23)}

// =========================
// • RichPresence DISPLAYS •
// =========================
function rp_isPaused(enum_releaseRegion) {
	function condition(enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) && 
		is_InGamePauseMenu_active(enum_releaseRegion)
	rich_presence_conditional_display(
		condition(enum_releaseRegion),
		richPresence_getText("rp_isPaused"),
		richPresence_callParameterFunction("rpp_FatedHourBis", enum_releaseRegion), // eg. 4h30 instead of 04:30
		richPresence_callParameterFunction("rpp_PresentTimeDays", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeYears", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeHourMinutes", enum_releaseRegion), // eg. 4h30
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}

function rp_InGameEXChapterOnly(enum_releaseRegion) {
	function condition(enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) && 
		// !is_InGamePauseMenu_active(enum_releaseRegion) &&	// <-- commented as long as rp_isPaused is disabled
		is_PrologueExMode_active(enum_releaseRegion) && 
		is_ExChapter_unlocked(enum_releaseRegion) &&
		!is_ExtraMenu_active(enum_releaseRegion) &&
		is_ChapterIdValid(enum_releaseRegion) && 
		is_Chapter(CHAPTER_Prologue, enum_releaseRegion)
	rich_presence_conditional_display(
		condition(enum_releaseRegion),
		richPresence_getText("rp_InGameEXChapterOnly"),
		richPresence_callParameterFunction("rpp_FatedHour", enum_releaseRegion), // eg. 04:30
		richPresence_callParameterFunction("rpp_PresentTimeHours_ZeroPadding", enum_releaseRegion), // Adds "0" when rpp_PresentTimeHours is < 10
		richPresence_callParameterFunction("rpp_PresentTimeHours", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}

function rp_InGameChapterOnly(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>  
		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) &&
		// !is_InGamePauseMenu_active(enum_releaseRegion) &&	// <-- commented as long as rp_isPaused is disabled
		!is_PrologueExMode_active(enum_releaseRegion) && 
		!is_ExtraMenu_active(enum_releaseRegion) &&
		is_ChapterIdValid(enum_releaseRegion) && 
		is_ChapterAnyOf([
				CHAPTER_Prologue, CHAPTER_Chapter1, CHAPTER_Epilogue
			], enum_releaseRegion)			
	rich_presence_conditional_display(	
		condition(enum_releaseRegion),
		richPresence_getText("rp_InGameChapterOnly"),
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_FatedHour", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeHours_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeHours", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}	

function rp_InGameChapterWithTimePeriod(enum_releaseRegion) {
	function condition(enum_releaseRegion) { return
		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) && 
		!is_ExtraMenu_active(enum_releaseRegion) &&
		// !is_InGamePauseMenu_active(enum_releaseRegion) &&	// <-- commented as long as rp_isPaused is disabled
		is_ChapterIdValid(enum_releaseRegion) && 
		is_ChapterAnyOf([
				CHAPTER_Chapter2, CHAPTER_Chapter3, 
				CHAPTER_Chapter4, CHAPTER_Chapter5, 
				CHAPTER_Chapter6, CHAPTER_Chapter7, CHAPTER_Chapter8
			], enum_releaseRegion)}		
	rich_presence_conditional_display(	
		condition(enum_releaseRegion),
		richPresence_getText("rp_InGameChapterWithTimePeriod"),
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_TimePeriod", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_FatedHour", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeHours_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeHours", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_PresentTimeMinutes", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}

function rp_AtTitleScreen(enum_releaseRegion) {
	function condition(enum_releaseRegion) { return
		is_ReleaseRegion(enum_releaseRegion) &&
		(
			!is_InGame(enum_releaseRegion) || 
			is_ExtraMenu_active(enum_releaseRegion)
		)}
	rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_AtTitleScreen"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus"),
		richPresence_callParameterFunction("rpp_TotalCompletionRate", enum_releaseRegion)
	)}

function rp_Default() {
	rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		// rp_isPaused(enum_releaseRegion) // DISABLED // VERIFIED not as elegant inside rich presence; 	--> !! IF !! turning back on => re-check other richPresence conditions, some other conditions need changing
		rp_InGameEXChapterOnly(enum_releaseRegion) // VERIFIED
		rp_InGameChapterOnly(enum_releaseRegion) // VERIFIED
		rp_InGameChapterWithTimePeriod(enum_releaseRegion) // VERIFIED
		rp_AtTitleScreen(enum_releaseRegion) // VERIFIED
		rp_DefaultPlus(enum_releaseRegion) // VERIFIED
	}} 

// ===========================
// • RichPresence PARAMETERS •
// ===========================
richPresence_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_LOOKUP = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_MACRO = 3		// rich_presence_macro(macro, expression)
// -------------------------------------
function rpp_Chapter(enum_releaseRegion) { return
	current_ChapterID(enum_releaseRegion)}

function rpp_TimePeriod(enum_releaseRegion) { return
	current_TimePeriod(enum_releaseRegion)}

function rpp_TotalCompletionRate(enum_releaseRegion) { return
	current_TotalAchievementRate(enum_releaseRegion)}

function rpp_PresentTimeSeconds(enum_releaseRegion) { return
	current_DateTime_Seconds(DATETIME_Present, enum_releaseRegion)}

function rpp_PresentTimeMinutes(enum_releaseRegion) { return
	current_DateTime_Minutes(DATETIME_Present, enum_releaseRegion)}

function rpp_PresentTimeHourMinutes(enum_releaseRegion) { return
	(current_DateTime_Minutes(DATETIME_Present, enum_releaseRegion) + current_DateTime_Hours(DATETIME_Present, enum_releaseRegion) * 60)}

function rpp_PresentTimeHours(enum_releaseRegion) { return
	current_DateTime_Hours(DATETIME_Present, enum_releaseRegion)}

function rpp_PresentTimeYears(enum_releaseRegion) { return
	current_DateTime_Years(DATETIME_Present, enum_releaseRegion)}

function rpp_PresentTimeDays(enum_releaseRegion) { return
	current_DateTime_Days(DATETIME_Present, enum_releaseRegion)}

function rpp_FatedHour(enum_releaseRegion) =>
	current_ChapterID(enum_releaseRegion)

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
		"Expression": {
			RELEASE_REGION_USA: () => rpp_Chapter(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_Chapter(RELEASE_REGION_JPN)},
		"LookupFallback": richPresence_getLookupTableText("rpp_Chapter", "LookupFallback")},
	"rpp_TimePeriod": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_TimePeriod(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_TimePeriod(RELEASE_REGION_JPN)},
		"LookupFallback": richPresence_getLookupTableText("rpp_TimePeriod", "LookupFallback")},
	"rpp_TotalCompletionRate": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_TotalCompletionRate(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_TotalCompletionRate(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_PresentTimeSeconds": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeSeconds(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeSeconds(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_PresentTimeMinutes_ZeroPadding": { // Use in combination with a DateTime. eg. rpp_PresentTimeMinutes => to prepend an extra 0 when the minutes would only evaluate to 1 number 	=> eg. "7" --> "07"
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeMinutes(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeMinutes(RELEASE_REGION_JPN)},
		"LookupFallback": "0"}, // This "0" + "0" from rpp_PresentTimeMinutes => will show "00"
	"rpp_PresentTimeMinutes": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeMinutes(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeMinutes(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},	
	"rpp_PresentTimeHourMinutes": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeHourMinutes(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeHourMinutes(RELEASE_REGION_JPN)},
		"MacroFormat": "Minutes"},	// --> would result in: 4h21, 11h30
	"rpp_PresentTimeHours_ZeroPadding": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeHours(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeHours(RELEASE_REGION_JPN)},
		"LookupFallback": "0"},
	"rpp_PresentTimeHours": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeHours(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeHours(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_PresentTimeYears": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeYears(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeYears(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_PresentTimeDays": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_PresentTimeDays(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_PresentTimeDays(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_FatedHourBis": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_FatedHour(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_FatedHour(RELEASE_REGION_JPN)},
		"LookupFallback": richPresence_getLookupTableText("rpp_FatedHourBis", "LookupFallback")},
	"rpp_FatedHour": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: () => rpp_FatedHour(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: () => rpp_FatedHour(RELEASE_REGION_JPN)},
		"LookupFallback": richPresence_getLookupTableText("rpp_FatedHour", "LookupFallback")}
	}
// -------------------------------------
function richPresence_createParameterName(string_parameterKey) => // Removes rpp_ 
	substring(string_parameterKey, 4)	

function richPresence_callParameterFunction(string_parameterKey, enum_releaseRegion) {	// Checks which rich_presence function to execute/call and gives it the correct parameters with the data stored in richPresence_parameterData
	function richPresence_callValueFunction(string_parameterKey, dict_paramValueData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramValueData["Expression"][enum_releaseRegion]
		let_format = dict_paramValueData["ValueFormat"] 
		return rich_presence_value(let_name, let_expression, let_format)}
	
	function richPresence_callLookupFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramLookupData["Expression"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(string_parameterKey)
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData, enum_releaseRegion) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"][enum_releaseRegion]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP) richPresence_callLookupFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_MACRO) richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}

// ===============================
// • RichPresence INITIALIZATION •
// ===============================
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_parameterKey in richPresence_lookupTables {
		let_lookupTable = richPresence_lookupTables[let_parameterKey]
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_parameterKey][let_lookupKey]
			richPresence_lookupTables[let_parameterKey][let_lookupKey] = richPresence_getLookupTableText(let_parameterKey, let_lookupValue)
		}
	}}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_initializeZeroPaddingLookupTables() // <-- should be called after richPresence_populateLookupTables() as ZeroPaddingLookupTables don't need to be populated AND before richPresence_initializeDisplays()
	richPresence_initializeDisplays()}

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

// ==========================
// • Leaderboards CORE DATA •
// ==========================
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "xxxxxxx"},

	"lb_EnergyOrbSpeedTrial2000s": { // VERIFIED
		"id": 94367, "isLowerBetter": true, 
		"leaderboardFormat": "FRAMES",
		"devInfo": "Speed collect 5 energy orbs throughout the city during the Present"},
	"lb_EnergyOrbSpeedTrial1980s": { // VERIFIED
		"id": 94366, "isLowerBetter": true, 
		"leaderboardFormat": "FRAMES",
		"devInfo": "Speed collect 5 energy orbs throughout the city during the late 20th century"},
	"lb_EnergyOrbSpeedTrial1900s": { // VERIFIED
		"id": 94365, "isLowerBetter": true, 
		"leaderboardFormat": "FRAMES",
		"devInfo": "Speed collect 5 energy orbs throughout the city, which are not inside buildings, during the early 20th century"},
	"lb_EnergyOrbSpeedTrial1500s": { // VERIFIED
		"id": 94364, "isLowerBetter": true, 
		"leaderboardFormat": "FRAMES",
		"devInfo": "Speed collect 5 energy orbs throughout the city, which are not inside buildings, during the Medieval era"},
	"lb_ClearTimeChapter8": { // VERIFIED 
		"id": 92203, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter7": { // VERIFIED 
		"id": 92202, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter6": { // VERIFIED 
		"id": 92201, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter5": { // VERIFIED 
		"id": 92200, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter4": { // VERIFIED 
		"id": 92199, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter3": { // VERIFIED 
		"id": 92198, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter2": { // VERIFIED 
		"id": 92197, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimeChapter1": { // VERIFIED 
		"id": 92196, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in corresponding chapter"},
	"lb_ClearTimePrologue": { // VERIFIED 
		"id": 92195, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "Best Clear Time in prologue, excluding EX chapter"},
	"lb_TotalClearTime": { // VERIFIED 
		"id": 92194, "isLowerBetter": true,
		"leaderboardFormat": "MINUTES",
		"devInfo": "Best Total Clear Time, excluding EX chapter"}}

// ===================================
// • Leaderboards TRIGGER GENERATORS •
// ===================================
//	- For leaderboard logic that's reoccuring across multiple triggers
// ---------------ClearTimeChapter-------------------
function leaderboards_generate_StartTrigger_ClearTimeChapter(enum_chapter, enum_releaseRegion) {
	let_extraComparison_inPrologue = always_true()
	if(enum_chapter == CHAPTER_Prologue)
		let_extraComparison_inPrologue = !is_PrologueExMode_active(enum_releaseRegion)

	return 
		unless(!is_ReleaseRegion(enum_releaseRegion)) && // <-- pause is needed so the other alt group regions won't trigger, count or reset
		never(
			!is_InGame(enum_releaseRegion) || 
			is_ExtraMenu_active(enum_releaseRegion)
		) &&
		once(on_Timer_ChapterClearTime_start(enum_releaseRegion)) && // <-- once() here because of delay
		repeated(100, 							// <-- Delay FIX for: leaderboard cancelling immediately after starting when moving to the next chapter OR when loading a save from chapter completion menu, because timer 'Clear Time' resets later
			is_InGame(enum_releaseRegion) &&	//		+ better visual feedback to indicate minutes timer is for chapter clear time, both Total and chapter clear time pop and same time otherwise
			is_Chapter(enum_chapter, enum_releaseRegion) &&
			!is_Loading(enum_releaseRegion)
		) &&
		let_extraComparison_inPrologue
	}	
function leaderboards_generate_CancelTrigger_ClearTimeChapter(enum_chapter, enum_releaseRegion) {
	let_extraComparison_inPrologue = always_false()
	if (enum_chapter == CHAPTER_Prologue)
		let_extraComparison_inPrologue = is_PrologueExMode_active(enum_releaseRegion)

	return 	
		is_ReleaseRegion(enum_releaseRegion) &&
		(
			!is_InGame(enum_releaseRegion) || 
			let_extraComparison_inPrologue || 
			!is_Chapter(enum_chapter, enum_releaseRegion) ||
			on_Timer_ChapterClearTime_reset(enum_releaseRegion)
		)
	}
function leaderboards_generate_SubmitTrigger_ClearTimeChapter(enum_chapter, enum_releaseRegion) =>
	is_ReleaseRegion(enum_releaseRegion) && 
	is_Chapter(enum_chapter, enum_releaseRegion) &&
	on_ChapterCompletionMenu_render(enum_releaseRegion)

function leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion) =>
	measured(get_Timer_ChapterClearTime_InSeconds(enum_releaseRegion), when = is_ReleaseRegion(enum_releaseRegion))

// ---------------ClearTimeChapter_alt-------------------
function leaderboards_generate_StartTrigger_ClearTimeChapter_alt(enum_chapter, enum_releaseRegion) { // alternative => starts on_ChapterCompletionMenu_render() => submit immediately => to lower RAoverlay clutter 
	// DEV_NOTE: Leaderboards: Start and submit on same frame
	// ------------------------------------
	//	- Reason is to lower the RAoverlay clutter
	//	- refer to https://docs.retroachievements.org/Leaderboards/#design-tips

	let_extraComparison_inPrologue = always_true()
	if(enum_chapter == CHAPTER_Prologue)
		let_extraComparison_inPrologue = !is_PrologueExMode_active(enum_releaseRegion)

	return
		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
		never(
			!is_InGame(enum_releaseRegion) ||
			!is_Chapter(enum_chapter, enum_releaseRegion) 
		) &&
		repeated(100, 	// <-- Delay FIX for: leaderboard starting+submitting when moving from one chapter to the next OR when loading a save from chapter completion menu, depending on load time
			is_InGame(enum_releaseRegion) &&
			is_Chapter(enum_chapter, enum_releaseRegion) &&
			!is_Loading(enum_releaseRegion)
		) &&
		let_extraComparison_inPrologue &&
		on_ChapterCompletionMenu_render(enum_releaseRegion)
	}
function leaderboards_generate_CancelTrigger_ClearTimeChapter_alt() =>
	always_false()
function leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt() =>
	always_true()

// ---------------EnergyOrbSpeedTrial-------------------
function leaderboards_generate_StartTrigger_EnergyOrbSpeedTrial(enum_timePeriod, array_energyOrblocationKeys, int_amountToCollect, enum_releaseRegion) {
	let_sumOf_deltaAmountOfEnergyOrbsCollected = 
		sum_of(array_energyOrblocationKeys, (string_eneryOrbLocationKey) => prev_EnergyOrb_CollectionState(enum_timePeriod, string_eneryOrbLocationKey, enum_releaseRegion))
	let_sumOf_currentAmountOfEnergyOrbsCollected = 
		sum_of(array_energyOrblocationKeys, (string_eneryOrbLocationKey) => current_EnergyOrb_CollectionState(enum_timePeriod, string_eneryOrbLocationKey, enum_releaseRegion))

	return 
		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) &&
		current_EnergyUnits(enum_releaseRegion) <= (10 - int_amountToCollect + 1) && // <-- only start leaderboard if player has enough space to pickup the remaining orbs; add +1 because we start the leaderboard on the 2 second orb pickup, so 1 has already been picked up
		
		let_sumOf_deltaAmountOfEnergyOrbsCollected == 1 && // Code Block <-- start leaderboard once the 2nd orb is collected => reduce RAoverlay clutter
		let_sumOf_currentAmountOfEnergyOrbsCollected == 2
	}

function leaderboards_generate_CancelTrigger_EnergyOrbSpeedTrial(enum_releaseRegion) =>
	is_ReleaseRegion(enum_releaseRegion) &&
	(
		!is_InGame(enum_releaseRegion) ||
		on_Chapter_change(enum_releaseRegion) ||
		on_EnergyUnits_decrement(enum_releaseRegion)
	)

function leaderboards_generate_SubmitTrigger_EnergyOrbSpeedTrial(enum_timePeriod, array_energyOrblocationKeys, array_collectionAreas, int_amountToCollect, enum_releaseRegion) => 
	// Core alt group
	unless(!is_ReleaseRegion(enum_releaseRegion)) && 
	unless(none_of(array_collectionAreas, (enum_area) => is_Area(enum_area, enum_releaseRegion))) && // <-- pause if tally count when not in the city area
	tally_of(array_energyOrblocationKeys, int_amountToCollect, (string_eneryOrbLocationKey) => // <-- Tally does not start counting on leaderboard start, but whenever the comparisons here allows it to count, thus we can count all 5 collections
		on_EnergyOrb_collect(enum_timePeriod, string_eneryOrbLocationKey, enum_releaseRegion)
	) 
	|| // Reset alt group => so tally hit count can reset when second unless is active in core group // <-- reset is necessary because the cancelTrigger does not reset below tally count
	never_toAlt( 
		is_ReleaseRegion(enum_releaseRegion) &&
		(
			!is_InGame(enum_releaseRegion) ||
			on_Chapter_change(enum_releaseRegion) ||
			on_EnergyUnits_decrement(enum_releaseRegion) 
		)
	)	

function leaderboards_generate_ValueMeasure_EnergyOrbSpeedTrial(enum_releaseRegion) => 
	unless(!is_ReleaseRegion(enum_releaseRegion)) &&
	unless(
		is_InGame(enum_releaseRegion) && // <-- is_InGame() is neccesary so reset below can still hit
		(
			!is_PlayerCharacter_moveable(enum_releaseRegion) || 
			is_InGamePauseMenu_active(enum_releaseRegion)
		)
	) &&
	never(	// <-- reset is necessary because the cancelTrigger does not reset below measure count
		!is_InGame(enum_releaseRegion) ||
		on_Chapter_change(enum_releaseRegion) ||
		on_EnergyUnits_decrement(enum_releaseRegion) 
	) &&
	measured(repeated(0, on_FrameCount_change(enum_releaseRegion))) // <-- repeated 0 => will infinitely count

// =========================
// • Leaderboards TRIGGERS •
// =========================
leaderboards_startTriggers = {
	"lb_EnergyOrbSpeedTrial2000s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["OutsideFortuneTeller", "AlleyWay", "SouthGate", "UnderArchRuckagrastr", "CarPark"]
		let_int_amountToCollect = 5
		return leaderboards_generate_StartTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Present, let_array_energyOrblocationKeys, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1980s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["NorthGateNearBar", "WellCafeSonne", "Haupstr", "StairsRudolfstr", "AlleyWayBakery"]
		let_int_amountToCollect = 5
		return leaderboards_generate_StartTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Late20thCentury, let_array_energyOrblocationKeys, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1900s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["TreeNearBar", "StairsOppositeCafeSonne", "NearNewsPost", "ParkRudolfStr", "NorthEastgate", "InsideBrumMansion"]
		let_int_amountToCollect = 6
		return leaderboards_generate_StartTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Early20thCentury, let_array_energyOrblocationKeys, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1500s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["onBench", "EastWell", "AlleyWayCart", "EastNearHay", "ChurchEntrance", "InsideChurch", "AlchemistBasement"]
		let_int_amountToCollect = 6 // 7 locations, but only 6 available to pick up at one given time (depending on chapter)
		return leaderboards_generate_StartTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_MiddleAges, let_array_energyOrblocationKeys, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_ClearTimeChapter8": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter8, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter8, enum_releaseRegion)		
		),		
	"lb_ClearTimeChapter7": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter7, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter7, enum_releaseRegion)
		),
	"lb_ClearTimeChapter6": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter6, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter6, enum_releaseRegion)
		),
	"lb_ClearTimeChapter5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter5, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter5, enum_releaseRegion)
		),
	"lb_ClearTimeChapter4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter4, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter4, enum_releaseRegion)
		),
	"lb_ClearTimeChapter3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter3, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter3, enum_releaseRegion)
		),
	"lb_ClearTimeChapter2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter2, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter2, enum_releaseRegion)
		),
	"lb_ClearTimeChapter1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Chapter1, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Chapter1, enum_releaseRegion)
		),
	"lb_ClearTimePrologue": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_StartTrigger_ClearTimeChapter_alt(CHAPTER_Prologue, enum_releaseRegion)
		// leaderboards_generate_StartTrigger_ClearTimeChapter(CHAPTER_Prologue, enum_releaseRegion)
		),
	"lb_TotalClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// Below code => alt leaderboard with RAoverlay timer - start when entering game/loading a save
		//	'''''''''''''''''''''''''''''
		//	unless(!is_ReleaseRegion(enum_releaseRegion)) && // <-- pause is needed so the other region triggers don't count and don't reset
		//	never(
		//		!is_InGame(enum_releaseRegion) ||
		//		is_ExtraMenu_active(enum_releaseRegion)		
		//	) &&
		//	!is_PrologueExMode_active(enum_releaseRegion) &&
		//	once(on_Timer_TotalClearTime_start(enum_releaseRegion)) && // <-- once() here because of delay
		//	repeated(100, is_InGame(enum_releaseRegion))) // <-- delay popup

		// DEV_NOTE: __ornext()
		// --------------------------
		//	(written with 2 underscores)
		//	- Will try to make RAtools use 'orNext' Flags instead of creating unnecessary alt groups, !! take care there's a reason RAtools creates alt groups !!
		//	- Example usage: __ornext(X || Y || Z) => will generate below logic
		//				orNext: X
		//				orNext: Y
		//			 			Z
		//	- Example in code (just an example, wont work as an alternative for below/active code for this trigger): 
		//			is_ReleaseRegion(enum_releaseRegion) &&
		//			is_InGame(enum_releaseRegion) &&
		//			__ornext(is_Chapter(CHAPTER_Epilogue, enum_releaseRegion)) && // <-- __ornext() to force RAtools to use orNext instead of alt groups 
		//			on_Video_start(enum_releaseRegion))

		is_ReleaseRegion(enum_releaseRegion) &&
		is_InGame(enum_releaseRegion) &&
		is_Chapter(CHAPTER_Epilogue, enum_releaseRegion) &&
		on_Video_start(enum_releaseRegion)) // <-- This is the last thing to trigger, trigger when credits video starts		
	}

leaderboards_cancelTriggers = {
	"lb_EnergyOrbSpeedTrial2000s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_EnergyOrbSpeedTrial(enum_releaseRegion)),
	"lb_EnergyOrbSpeedTrial1980s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_EnergyOrbSpeedTrial(enum_releaseRegion)),
	"lb_EnergyOrbSpeedTrial1900s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_EnergyOrbSpeedTrial(enum_releaseRegion)),
	"lb_EnergyOrbSpeedTrial1500s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_EnergyOrbSpeedTrial(enum_releaseRegion)),
	"lb_ClearTimeChapter8": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter8, enum_releaseRegion)
		),
	"lb_ClearTimeChapter7": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter7, enum_releaseRegion)
		),
	"lb_ClearTimeChapter6": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter6, enum_releaseRegion)
		),
	"lb_ClearTimeChapter5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter5, enum_releaseRegion)
		),
	"lb_ClearTimeChapter4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter4, enum_releaseRegion)
		),
	"lb_ClearTimeChapter3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter3, enum_releaseRegion)
		),
	"lb_ClearTimeChapter2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter2, enum_releaseRegion)
		),
	"lb_ClearTimeChapter1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Chapter1, enum_releaseRegion)
		),
	"lb_ClearTimePrologue": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_CancelTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_CancelTrigger_ClearTimeChapter(CHAPTER_Prologue, enum_releaseRegion)
		),
	"lb_TotalClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// Below code => alt leaderboard with RAoverlay timer - start when entering game/loading a save
			//	'''''''''''''''''''''''''''''
			//	is_ReleaseRegion(enum_releaseRegion) &&
			//	(
			//		!is_InGame(enum_releaseRegion) || 
			//		is_PrologueExMode_active(enum_releaseRegion) || 
			//		on_Timer_TotalClearTime_reset(enum_releaseRegion)
			//	))
		always_false())
	}

leaderboards_submitTriggers = {
	"lb_EnergyOrbSpeedTrial2000s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["OutsideFortuneTeller", "AlleyWay", "SouthGate", "UnderArchRuckagrastr", "CarPark"]
		let_array_collectionAreas = [AREA_Present_City_Day, AREA_Present_City_NightAM, AREA_Present_City_NightPM]
		let_int_amountToCollect = 5
		return leaderboards_generate_SubmitTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Present, let_array_energyOrblocationKeys, let_array_collectionAreas, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1980s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["NorthGateNearBar", "WellCafeSonne", "Haupstr", "StairsRudolfstr", "AlleyWayBakery"]
		let_array_collectionAreas = [AREA_80s_City_Snow, AREA_70s_City_Night]
		let_int_amountToCollect = 5
		return leaderboards_generate_SubmitTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Late20thCentury, let_array_energyOrblocationKeys, let_array_collectionAreas, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1900s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["TreeNearBar", "StairsOppositeCafeSonne", "NearNewsPost", "ParkRudolfStr", "NorthEastgate", "InsideBrumMansion"]
		let_array_collectionAreas = [AREA_1900s_City, AREA_1900s_BrumMansion]
		let_int_amountToCollect = 6
		return leaderboards_generate_SubmitTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_Early20thCentury, let_array_energyOrblocationKeys, let_array_collectionAreas, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_EnergyOrbSpeedTrial1500s": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_array_energyOrblocationKeys = ["onBench", "EastWell", "AlleyWayCart", "EastNearHay", "ChurchEntrance", "InsideChurch", "AlchemistBasement"]
		let_array_collectionAreas = [AREA_MiddleAges_City_Day, AREA_MiddleAges_City_Night, AREA_MiddleAges_AlchemistHouse_Exploded_Basement, AREA_MiddleAges_Church]
		let_int_amountToCollect = 6
		return leaderboards_generate_SubmitTrigger_EnergyOrbSpeedTrial(TIMEPERIOD_MiddleAges, let_array_energyOrblocationKeys, let_array_collectionAreas, let_int_amountToCollect, enum_releaseRegion)}),
	"lb_ClearTimeChapter8": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter8, enum_releaseRegion)
		),
	"lb_ClearTimeChapter7": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter7, enum_releaseRegion)
		),
	"lb_ClearTimeChapter6": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter6, enum_releaseRegion)
		),
	"lb_ClearTimeChapter5": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter5, enum_releaseRegion)
		),
	"lb_ClearTimeChapter4": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter4, enum_releaseRegion)
		),
	"lb_ClearTimeChapter3": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter3, enum_releaseRegion)
		),
	"lb_ClearTimeChapter2": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter2, enum_releaseRegion)
		),
	"lb_ClearTimeChapter1": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Chapter1, enum_releaseRegion)
		),
	"lb_ClearTimePrologue": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		leaderboards_generate_SubmitTrigger_ClearTimeChapter_alt()
		// leaderboards_generate_SubmitTrigger_ClearTimeChapter(CHAPTER_Prologue, enum_releaseRegion)
		),
	"lb_TotalClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// Below code => alt leaderboard with RAoverlay timer - start when entering game/loading a save
			//	'''''''''''''''''''''''''''''
			//	alt1 = // Alt 1 => Trigger when credits video starts
			//		is_ReleaseRegion(enum_releaseRegion) &&
			//		is_InGame(enum_releaseRegion) &&
			//		is_Chapter(CHAPTER_Epilogue, enum_releaseRegion) &&
			//		on_Video_start(enum_releaseRegion) 
			//	alt2 = // Alt 2 => Trigger when timer has stopped for 20 frames during the credits video
			//		unless(!is_ReleaseRegion(enum_releaseRegion)) &&
			//		never(
			//			!is_InGame(enum_releaseRegion) ||
			//			(
			//				!is_Video_active(enum_releaseRegion) &&
			//				!on_Timer_TotalClearTime_valueChange(enum_releaseRegion)
			//			)
			//		) &&
			//		repeated(20, 
			//			is_Video_active(enum_releaseRegion) && 
			//			is_Chapter(CHAPTER_Epilogue, enum_releaseRegion) &&
			//			!on_Timer_TotalClearTime_valueChange(enum_releaseRegion)
			//		)
			//	return alt1 || alt2})
		always_true()})
	}
leaderboards_valueMeasures = {	
	// DEV_NOTE: Leaderboards - ValueTrigger/measure
	// -----------------------------
	//	- 'Value' can be seen as a special trigger. A trigger like submit, cancel and start. But must have a "measured" flag
	//	- Use max_of() --> when there's multiple values to measure (refer to https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions#leaderboardtitle-description-start-cancel-submit-value-formatvalue-lower_is_betterfalse-id0)
	//	- Be wary of timers or values that reset to 0x0 when the bytes overflow => refer to score wrapping to fix https://docs.retroachievements.org/Leaderboards/#score-wrapping
	
	"lb_EnergyOrbSpeedTrial2000s": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_EnergyOrbSpeedTrial(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_EnergyOrbSpeedTrial1980s": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_EnergyOrbSpeedTrial(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_EnergyOrbSpeedTrial1900s": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_EnergyOrbSpeedTrial(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_EnergyOrbSpeedTrial1500s": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_EnergyOrbSpeedTrial(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter8": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter7": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter6": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter5": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter4": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter3": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter2": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimeChapter1": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_ClearTimePrologue": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_ClearTimeChapter(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_TotalClearTime": () {
		function valueMeasure(enum_releaseRegion) => 
			measured(get_Timer_TotalClearTime_InMinutes(enum_releaseRegion), when = is_ReleaseRegion(enum_releaseRegion))
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = valueMeasure(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	}
// =====================
// • Leaderboards TEXT •
// =====================
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_EnergyOrbSpeedTrial2000s":			{"en": "Agile Energy Hunter: Present"},
	"lb_EnergyOrbSpeedTrial1980s":			{"en": "Agile Energy Hunter: Late 20th century"},
	"lb_EnergyOrbSpeedTrial1900s":			{"en": "Agile Energy Hunter: Early 20th century"},
	"lb_EnergyOrbSpeedTrial1500s":			{"en": "Agile Energy Hunter: Middle Ages"},
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
	"lb_EnergyOrbSpeedTrial2000s":			{"en": "Collect all five energy orbs scattered throughout Lebenbaum in the present time, as quickly as possible (leaderboard starts when 2 orbs have been picked up)"},
	"lb_EnergyOrbSpeedTrial1980s":			{"en": "Collect all five energy orbs scattered throughout Lebenbaum in the late 20th century, as quickly as possible (leaderboard starts when 2 orbs have been picked up)"},
	"lb_EnergyOrbSpeedTrial1900s":			{"en": "Collect all six energy orbs scattered throughout Lebenbaum in the early 20th century, as quickly as possible (leaderboard starts when 2 orbs have been picked up)"},
	"lb_EnergyOrbSpeedTrial1500s":			{"en": "Collect six energy orbs scattered throughout Lebenbaum in the Middle Ages, as quickly as possible (leaderboard starts when 2 orbs have been picked up)"},
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

// ===============================
// • Leaderboards INITIALIZATION •
// ===============================
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
			value = leaderboards_valueMeasures[let_leaderboardKey],
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}

// ====================================================================== \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ====================================================================== \\
function initializeRAscript() {
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()