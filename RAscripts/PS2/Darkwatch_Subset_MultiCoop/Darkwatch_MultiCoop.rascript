// **************************************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 						\\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	MULTIPLAYER COOPERATIVE \\
// **************************************************************** \\
// #ID = 19111
// md5: [hash_here] (region_here)
// RA Hash: [hash_here] (region_here)
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: [link_to_game_page]
// RATools version: [version_here] // TODO set last used RATools version here

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //     DEVELOPER NOTES      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// #region DEVELOPER NOTES

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
//	- is_		=> returns a comparison, which only uses current values								-> eg is_Area(id_area) => id_area == byte(0xAA)
//	- wasPrior_	=> returns a comparison, which only uses prior values								-> eg wasPrior_inArea(id_area) => id_area == prior(byte(0xAA))
//	- has_ 		=> returns a comparison, which uses current AND prior values						-> eg has_movedToArea(id_area) => id_area == prior(byte(0xAA)) && id_area-1 == byte(0xAA)
//	- wasPrev_	=> returns a comparison, which only uses previous/delta values						-> eg wasPrev_Area(id_area) => id_area == prev(byte(0xAA))
//	- on_		=> returns a comparison, which checks for a change between delta and current values	-> eg on_Area_change() => current_Area() != prev_Area()

//	Visual Studio Code: specific info
// ---------------------------------------------
//	- Enable: Colored code => select language mode (bottom right of vscode window) => Go (not "plain text")
//	- Enable: Todo Tree tags => install extension: 'Todo Tree' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
// 	- Markdown editing
//		-- Enable: Markdown Enhanced Preview => Install extension: 'Markdown Preview Enhanced' by 'Yiyi Wang'
//  - VScode extension list: Region Viewer Extension - Todo Tree - Markdown Preview Enhanced
// #endregion DEVELOPER NOTES
 
//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //    GENERAL UTILITY   \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// #region GENERAL UTILITY

util_isDebugModeActive = true	// if true => extra information may be displayed on achievement titles & descriptions
util_language = "en"	// ISO 639-1 language codes 

iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
sNULL = "-1"

RELEASE_REGION_USA = "NTSC-U"
RELEASE_REGION_JPN = "NTSC-J"
RELEASE_REGION_EUR = "PAL"
RELEASE_REGIONS_SUPPORTED = [RELEASE_REGION_EUR, RELEASE_REGION_USA]

function util_throwError(string_errMsg) { // This function will throw an error in RATools because the key doesn't exist
	let_dict = {}
	return let_dict[format("ERROR: {0}", string_errMsg)]}

function util_addToDictionary(dict, key, value) {
	dict[key] = value}
// #endregion UTILITY

// ***************************************************************************************************************************************************************** \\
//																																				 					 \\
//   ███╗   ███╗███████╗███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║██████╔╝ ╚████╔╝     ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗    ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║██╔══██╗  ╚██╔╝      ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝██║  ██║   ██║       ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																									 \\
// ***************************************************************************************************************************************************************** \\
// #region MEMORY

// =============================
// • MEMORY struct definitions •
// =============================
// #region MEM - struct definitions
memory_regionOffsets = {
	}
function memory_getRegionOffset(string_structKey, string_offsetKey) =>
	memory_regionOffsets[string_structKey][string_offsetKey]
// -------------------------------------
memory_StructDefs = {
	}
function memory_getStruct_SizeInBytes(string_structKey) =>
	memory_StructDefs[string_structKey]["sizeInBytes"]

function memory_getStruct_OffsetToMember(string_structKey, string_memberKey) =>
	memory_StructDefs[string_structKey]["offsetToMember"][string_memberKey]

function memory_getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

function memory_getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

function memory_getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
	
function memory_getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

function memGenerate_pointerChainAccessor(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

function memGenerate_pointerChainAccessor_byReleaseRegion(string_structKey, string_pointerChainKey, memAdrr_basePointer, enum_releaseRegion, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

function memGenerate_pointerChainAccessor_fromOffsets(memAdrr_basePointer, array_pointerChainOffsets, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
	let_addAddressChain = dword(memAdrr_basePointer)
	for let_index in range(0, length(array_pointerChainOffsets) - 1) {
		if (let_index == length(array_pointerChainOffsets) - 1)
			return memAccessorFunction_toPointedToMember(let_addAddressChain + array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with creating pointer chain for memAddr: {0}", memAdrr_basePointer))}

// #endregion MEM - struct definitions

// ==========================
// • MEMORY ADDRESS STORAGE •
// ==========================
// #region MEM - address storage
memory_addresses = {
	// "memAddrKey": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	}

function memory_getAddress(string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}	
// #endregion MEM - address storage

// ==================
// • MEMORY UTILITY •
// ===================
// #region MEM - utility
// #region Custom ASCII comparitors
// NOTE: Custom ASCII comparitors are necessary to use with pointers, built-in RAtools ascii_string_equals() generates weird logic, when using pointers as the memAddrr

function ASCII_Equals(memAddr_ASCII, string_s, wrapper = c => c) {
	let_array_comparisons = []
	for let_stepBy4Index in range(0, length(string_s) - 1, step = 4) {
		let_substring = substring(string_s, let_stepBy4Index, 4)
		array_push(let_array_comparisons, ascii_string_equals(memAddr_ASCII + let_stepBy4Index, let_substring, transform = wrapper))
	}
	return all_of(let_array_comparisons, c => c)}

function ASCII_NotEquals(memAddr_ASCII, string_s, wrapper = c => c) {
	/* NOTE: Consider following ASCII "ABCDEF" --> if ASCII = "ABCDFF" it is not equal to the ASCII		
		Example logic:
			0xA != "ABCD"
			|| 0xB != "EF"
	*/
	return __ornext( // --> __ornext() as otherwise RATools may generate unnecessary alt groups for these single orNext requirements
		!ASCII_Equals(memAddr_ASCII, string_s, wrapper)
	)}

function is_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s)

function is_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s)

function wasPrev_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prev(c))

function wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))
// #endregion Custom ASCII comparitors
function is_ReleaseRegion(enum_releaseRegion) { // TODO implement is_ReleaseRegion()
	let_string_GameID = sNULL
	if(enum_releaseRegion == RELEASE_REGION_USA) let_string_GameID = sNULL // FullString: "xxxxx"
	else if(enum_releaseRegion == RELEASE_REGION_JPN) let_string_GameID = sNULL // FullString: "xxxxx"
	else if(enum_releaseRegion == RELEASE_REGION_EUR) let_string_GameID = sNULL // FullString: "xxxxx"
	
	if (let_string_GameID == sNULL) util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	return is_ASCII_EqualTo(memory_getAddress("ASCII:GameID", enum_releaseRegion), let_string_GameID)
	}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
	// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
function memUtil_floatToInt(float_value, enum_releaseRegion) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", enum_releaseRegion))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

function memUtil_alwaysFalse(enum_releaseRegion) => // Force always_false() as sometime RATools removes it when it is necessary
	dword(memory_getAddress("8-bit:AlwaysNULL", enum_releaseRegion)) == 0xDEADBEEF
	
function memUtil_ManualConstruction_PlaceHolderRequirement(int_placeHolderIndex) { // int_placeHolderIndex allowedRange [0x1-0xFFF] // This function can be used to quickyly generate a placeHolder Requirement for easily overwriting/copyPasting MANUAL CONSTRUCTION code
	let_dummyAddress = (int_placeHolderIndex * 0x10000) + 0xBEEF
	return dword(let_dummyAddress) == 0xBAADF00D}
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
// #endregion MEM - utility

// ............
// ◦ Level ID ◦
// ''''''''''''
// #region Level ID
CHAPTER_1_WrongTrain = 1
CHAPTER_2_RideDevil = 2
CHAPTER_3_Boneyard = 3
CHAPTER_4_DevilMine = 4
CHAPTER_5_Outpost = 5
CHAPTER_6_WarTrain = 6
CHAPTER_7_TortureMaze = 7
CHAPTER_8_BaptismFire = 8
CHAPTER_Citadel = 9
CHAPTER_9_Rescue = 10
CHAPTER_10_Prism = 11
CHAPTER_11_Invasion = 12
CHAPTER_12_Hangtown = 13
CHAPTER_13_MorningAfter = 14
CHAPTER_14_Showdown = 15
CHAPTER_15_RightTrain = 16
CHAPTER_16_Deadfall = 17
CHAPTER_17_CurseWest = 18

CHAPTER_SECTION_1 = 0
CHAPTER_SECTION_2 = 1
CHAPTER_SECTION_3 = 2
CHAPTER_SECTION_4 = 3
CHAPTER_SECTION_5 = 4
CHAPTER_SECTION_6 = 5

MULTIPLAYER_LEVEL_Asylum = "DM_Asylum"
MULTIPLAYER_LEVEL_DeathDealer = "DM_DeathDealer"
MULTIPLAYER_LEVEL_DeathDealerDay = "DM_DeathDealerDay"
MULTIPLAYER_LEVEL_DevilsBelly = "DM_DevilsBelly"
MULTIPLAYER_LEVEL_DonnerPass = "DM_DonnerPass"
MULTIPLAYER_LEVEL_DonnerPassDay = "DM_DonnerPassDay"
MULTIPLAYER_LEVEL_HangTownEast = "DM_HangTownEast"
MULTIPLAYER_LEVEL_HangTownEastDay = "DM_HangTownEastDay"
MULTIPLAYER_LEVEL_HangTownWest = "DM_HangTownWest"
MULTIPLAYER_LEVEL_HangTownWestDay = "DM_HangTownWestDay"
MULTIPLAYER_LEVEL_HellHole = "DM_HellHole"
MULTIPLAYER_LEVEL_TradeCenter = "DM_TradeCenter"
MULTIPLAYER_LEVEL_TradeCenterDay = "DM_TradeCenterDay"

CONST_LEVEL_DATA = {
	// CHAPTER_X_Template: {
		// "LevelID": "_templateID_",
		// "FullString_ChapterSectionIDs": ["_Section1_", "_Section2_"],
		// "IsGunslingerLevel": true,
		// },
	CHAPTER_1_WrongTrain: {
		"LevelID": "WrongTrain",
		"FullString_ChapterSectionIDs": ["WrongTrain_A", "WrongTrain_B"],
		"OffsetTo_Substring_ChapterSectionID": 8, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("in_A"), memUtil_asciiStringToHexBE("in_B")],
		"Substring_ChapterSectionIDs_asHex": [0x696e5f41, 0x696e5f42], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 0,
		"SavedStatIndex_SinglePlayerMode": 0,
		},
	CHAPTER_2_RideDevil: {
		"LevelID": "M02_CanyonShoot",
		"FullString_ChapterSectionIDs": ["Hub_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 1,
		"SavedStatIndex_SinglePlayerMode": 1,
		},
	CHAPTER_3_Boneyard: {
		"LevelID": "M03_Cemetery",
		"FullString_ChapterSectionIDs": ["M03_C", "M03_B", "M03_A"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("03_C"), memUtil_asciiStringToHexBE("03_B"), memUtil_asciiStringToHexBE("03_A")],
		"Substring_ChapterSectionIDs_asHex": [0x30335F43, 0x30335F42, 0x30335F41], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 2,
		"SavedStatIndex_SinglePlayerMode": 2,
		},
	CHAPTER_4_DevilMine: {
		"LevelID": "M05_DevilsBelly",
		"FullString_ChapterSectionIDs": ["Hub_A", "Hub_B", "Hub_C", "Hub_D"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("ub_A"), memUtil_asciiStringToHexBE("ub_B"), 
			memUtil_asciiStringToHexBE("ub_C"), memUtil_asciiStringToHexBE("ub_D")],
		"Substring_ChapterSectionIDs_asHex": [0x75625F41, 0x75625F42, 0x75625F43, 0x75625F44], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 3,
		"SavedStatIndex_SinglePlayerMode": 3,
		},
	CHAPTER_5_Outpost: {
		"LevelID": "M07_DWOutpost",
		"FullString_ChapterSectionIDs": ["M07_A", "M07_B"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("07_A"), memUtil_asciiStringToHexBE("07_B")],
		"Substring_ChapterSectionIDs_asHex": [0x30375F41, 0x30375F42], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 4,
		"SavedStatIndex_SinglePlayerMode": 4,
		},
	CHAPTER_6_WarTrain: {
		"LevelID": "Wartrain",
		"FullString_ChapterSectionIDs": ["M07_C"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 5,
		"SavedStatIndex_SinglePlayerMode": 5,
		}, 
	CHAPTER_7_TortureMaze: {
		"LevelID": "M09_TortureMaze",
		"FullString_ChapterSectionIDs": ["M09_A", "M09_B", "M09_C", "M09_D", "M09_E", "M09_F"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("09_A"), memUtil_asciiStringToHexBE("09_B"), 
			memUtil_asciiStringToHexBE("09_C"), memUtil_asciiStringToHexBE("09_D"),
			memUtil_asciiStringToHexBE("09_E"), memUtil_asciiStringToHexBE("09_F")],
		"Substring_ChapterSectionIDs_asHex": [0x30395F41, 0x30395F42, 0x30395F43, 0x30395F44, 0x30395F45, 0x30395F46], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 6,
		"SavedStatIndex_SinglePlayerMode": 6,
		},
	CHAPTER_8_BaptismFire: {
		"LevelID": "M10_TradingPost",
		"FullString_ChapterSectionIDs": ["M10_A", "M10_B", "M10_C", "M10_D"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("10_A"), memUtil_asciiStringToHexBE("10_B"), 
			memUtil_asciiStringToHexBE("10_C"), memUtil_asciiStringToHexBE("10_D")],
		"Substring_ChapterSectionIDs_asHex": [0x31305F41, 0x31305F42, 0x31305F43, 0x31305F44], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 7,
		"SavedStatIndex_SinglePlayerMode": 7,
		},
	CHAPTER_Citadel: {
		"LevelID": "Citadel_Launch",
		"FullString_ChapterSectionIDs": ["Citadel_Launch_AA"],
		"IsGunslingerLevel": false,
		"SavedStatIndex_SinglePlayerMode": 8, // For some reason this Level has a [Struct:ChapterStats] only for [Array:SavedStats_Story] and not for [Array:SavedStats_Gunslinger]
		},
	CHAPTER_9_Rescue: {
		"LevelID": "M08_Regulator",
		"FullString_ChapterSectionIDs": ["Hub_A", "Hub_B"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("ub_A"), memUtil_asciiStringToHexBE("ub_B")],
		"Substring_ChapterSectionIDs_asHex": [0x75625F41, 0x75625F42], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 9,
		"SavedStatIndex_SinglePlayerMode": 10,
		},
	CHAPTER_10_Prism: {
		"LevelID": "M15_SplittingPaths",
		"FullString_ChapterSectionIDs": ["M15_D", "M15_E", "M15_F", "M15_A", "M15_C"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("15_D"), memUtil_asciiStringToHexBE("15_E"), 
			memUtil_asciiStringToHexBE("15_F"), memUtil_asciiStringToHexBE("15_A"), memUtil_asciiStringToHexBE("15_C")],
		"Substring_ChapterSectionIDs_asHex": [0x31355F44, 0x31355F45, 0x31355F46, 0x31355F41, 0x31355F43], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 8,
		"SavedStatIndex_SinglePlayerMode": 9,
		},
	CHAPTER_11_Invasion: {
		"LevelID": "M17_Invasion",
		"FullString_ChapterSectionIDs": ["M17_B", "M17_C", "M17_D"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("17_B"), memUtil_asciiStringToHexBE("17_C"), memUtil_asciiStringToHexBE("17_D")],
		"Substring_ChapterSectionIDs_asHex": [0x31375F42, 0x31375F43, 0x31375F44], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 10,
		"SavedStatIndex_SinglePlayerMode": 11,
		},
	CHAPTER_12_Hangtown: {
		"LevelID": "M11_Hangtown",
		"FullString_ChapterSectionIDs": ["M11_F", "M11_G", "M11_H"],
		"OffsetTo_Substring_ChapterSectionID": 1, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("11_F"), memUtil_asciiStringToHexBE("11_G"), memUtil_asciiStringToHexBE("11_H")],
		"Substring_ChapterSectionIDs_asHex": [0x31315F46, 0x31315F47, 0x31315F48], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 11,
		"SavedStatIndex_SinglePlayerMode": 12,
		},
	CHAPTER_13_MorningAfter: {
		"LevelID": "M12_CitadelUnderAttack",
		"FullString_ChapterSectionIDs": ["M12_AA", "M12_B", "M12_C", "M12_D", "M12_A"],
		"OffsetTo_Substring_ChapterSectionID": 2, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("2_AA"), memUtil_asciiStringToHexBE("2_B", 1), 
			memUtil_asciiStringToHexBE("2_C", 1), memUtil_asciiStringToHexBE("2_D", 1), memUtil_asciiStringToHexBE("2_A", 1)],
		"Substring_ChapterSectionIDs_asHex": [0x325F4141, 0x325F4200, 0x325F4300, 0x325F4400, 0x325F4100], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 12,
		"SavedStatIndex_SinglePlayerMode": 13,
		},
	CHAPTER_14_Showdown: {
		"LevelID": "FallOfCitadel",
		"FullString_ChapterSectionIDs": ["FallOfCitadel_A", "FallOfCitadel_B"],
		"OffsetTo_Substring_ChapterSectionID": 11, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("el_A"), memUtil_asciiStringToHexBE("el_B")],
		"Substring_ChapterSectionIDs_asHex": [0x656C5F41, 0x656C5F42], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 13,
		"SavedStatIndex_SinglePlayerMode": 14,
		},
	CHAPTER_15_RightTrain: {
		"LevelID": "M19_RidetoDeadfall",
		"FullString_ChapterSectionIDs": ["M19_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 14,
		"SavedStatIndex_SinglePlayerMode": 15,
		},
	CHAPTER_16_Deadfall: {
		"LevelID": "M20_PenetratingDeadfall",
		"FullString_ChapterSectionIDs": ["Hub_A", "Hub_B", "Hub_B2", "Hub_C", "Hub_C2"],
		"OffsetTo_Substring_ChapterSectionID": 2, // --> Last 4-byte of "ChapterSectionID"
		"Substring_ChapterSectionIDs_asHexBE": [
			memUtil_asciiStringToHexBE("b_A", 1), memUtil_asciiStringToHexBE("b_B", 1), 
			memUtil_asciiStringToHexBE("b_B2"), memUtil_asciiStringToHexBE("b_C", 1), memUtil_asciiStringToHexBE("b_C2")],
		"Substring_ChapterSectionIDs_asHex": [0x625F4100, 0x625F4200, 0x625F4232, 0x625F4300, 0x625F4332], // --> Ordered as "FullString_ChapterSectionIDs"
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 15,
		"SavedStatIndex_SinglePlayerMode": 16,
		},
	CHAPTER_17_CurseWest: {
		"LevelID": "GroundZero",
		"FullString_ChapterSectionIDs": ["GroundZero_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 16,
		"SavedStatIndex_SinglePlayerMode": 17,
		},	
	}

function LEVEL_DATA_getLevelID(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["LevelID"]

function LEVEL_DATA_getLevelID_substring(enum_chapter) =>
	substring(CONST_LEVEL_DATA[enum_chapter]["LevelID"], 0, 4) // Only check first [4-byte ASCII]

function LEVEL_DATA_getFullStringChapterSectionID(enum_chapter, enum_chapterSection) =>
	CONST_LEVEL_DATA[enum_chapter]["FullString_ChapterSectionIDs"][enum_chapterSection]

function LEVEL_DATA_getAllFullStringChapterSectionIDs(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["FullString_ChapterSectionIDs"]

function LEVEL_DATA_getFirstFullStringChapterSectionID(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["FullString_ChapterSectionIDs"][CHAPTER_SECTION_1]

function LEVEL_DATA_getLastFullStringChapterSectionIndex(enum_chapter) {
	let_array_AllChapterSectionIDs = LEVEL_DATA_getAllFullStringChapterSectionIDs(enum_chapter)
	return util_getIndexOfLastItemInArray(let_array_AllChapterSectionIDs)}

function LEVEL_DATA_getOffsetToSubstringChapterSectionID(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["OffsetTo_Substring_ChapterSectionID"]

function LEVEL_DATA_getSubstringChapterSectionID_asHexBE(enum_chapter, enum_chapterSection) =>
	CONST_LEVEL_DATA[enum_chapter]["Substring_ChapterSectionIDs_asHexBE"][enum_chapterSection]

function LEVEL_DATA_IsChapterMultipleSectionsLong(enum_chapter) {
	if (length(LEVEL_DATA_getAllFullStringChapterSectionIDs(enum_chapter)) > 1) return true
	return false}

function LEVEL_DATA_getAllChaptersWithSingleSection() =>
	array_filter(CONST_LEVEL_DATA, enum_chapter => !LEVEL_DATA_IsChapterMultipleSectionsLong(enum_chapter))

function LEVEL_DATA_getAllChaptersWithMultipleSections() => 
	array_filter(CONST_LEVEL_DATA, enum_chapter => LEVEL_DATA_IsChapterMultipleSectionsLong(enum_chapter))

function LEVEL_DATA_getAllChaptersWithMultipleSections_withOffsetToSubstringChapterSectionID(int_offsetToSubstringChapterSectionID) =>
	array_filter(CONST_LEVEL_DATA, (enum_chapter) {
		if (LEVEL_DATA_IsChapterMultipleSectionsLong(enum_chapter) 
			&& LEVEL_DATA_getOffsetToSubstringChapterSectionID(enum_chapter) == int_offsetToSubstringChapterSectionID)
			return true
		else 
			return false
	})

function LEVEL_DATA_getAllUniqueOffsetsToSubstringChapterSectionID() {
	let_array_UniqueOffsetsToSubstringChapterSectionID = []
	for enum_chapter in CONST_LEVEL_DATA {
		if (LEVEL_DATA_IsChapterMultipleSectionsLong(enum_chapter)) {
			let_OffsetToSubstringChapterSectionID = LEVEL_DATA_getOffsetToSubstringChapterSectionID(enum_chapter)
			if (!array_contains(let_array_UniqueOffsetsToSubstringChapterSectionID, let_OffsetToSubstringChapterSectionID))
				array_push(let_array_UniqueOffsetsToSubstringChapterSectionID, let_OffsetToSubstringChapterSectionID)
		}
	}
	return let_array_UniqueOffsetsToSubstringChapterSectionID}

function LEVEL_DATA_IsChapterGunslingerLevel(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["IsGunslingerLevel"]

function LEVEL_DATA_getAllGunslingerLevels() => 
	array_filter(CONST_LEVEL_DATA, enum_chapter => LEVEL_DATA_IsChapterGunslingerLevel(enum_chapter))

function LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter) => // TODO check how stats are saved in Coop
	CONST_LEVEL_DATA[enum_chapter]["SavedStatIndex_GunslingerMode"]

function LEVEL_DATA_getSavedStatIndex_Story(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["SavedStatIndex_SinglePlayerMode"]

CONST_MP_LEVEL_DATA = {
	MULTIPLAYER_LEVEL_Asylum: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("Asyl"), // DM_ 'Asyl' um  
		"OffsetTo_Substring_LevelID": 3,
		},
	MULTIPLAYER_LEVEL_DeathDealer: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("ler", 1), //DM_DeathDea 'ler'
		"OffsetTo_Substring_LevelID": 11,
		},
	MULTIPLAYER_LEVEL_DeathDealerDay: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("lerD"), // DM_DeathDea 'lerD' ay
		"OffsetTo_Substring_LevelID": 11,
		},
	MULTIPLAYER_LEVEL_DevilsBelly: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("Devi"), // DM_ 'Devi' lsBelly  
		"OffsetTo_Substring_LevelID": 3,
		},
	MULTIPLAYER_LEVEL_DonnerPass: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("ass", 1), //DM_DonnerP 'ass'
		"OffsetTo_Substring_LevelID": 10,
		},
	MULTIPLAYER_LEVEL_DonnerPassDay: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("assD"), // DM_DonnerP 'assD' ay
		"OffsetTo_Substring_LevelID": 10,
		},
	MULTIPLAYER_LEVEL_HangTownEast: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("ast", 1), //DM_HangTownE 'ast'
		"OffsetTo_Substring_LevelID": 12,
		},
	MULTIPLAYER_LEVEL_HangTownEastDay: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("astD"), // DM_HangTownE 'astD' ay
		"OffsetTo_Substring_LevelID": 12,
		},
	MULTIPLAYER_LEVEL_HangTownWest: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("est", 1), //DM_HangTownW 'est'
		"OffsetTo_Substring_LevelID": 12,
		},
	MULTIPLAYER_LEVEL_HangTownWestDay: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("estD"), // DM_HangTownW 'estD' ay 
		"OffsetTo_Substring_LevelID": 12,
		},
	MULTIPLAYER_LEVEL_HellHole: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("Hell"), // DM_ 'Hell' Hole    
		"OffsetTo_Substring_LevelID": 3,
		},
	MULTIPLAYER_LEVEL_TradeCenter: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("ter", 1), //DM_TradeCen 'ter'
		"OffsetTo_Substring_LevelID": 11,
		},
	MULTIPLAYER_LEVEL_TradeCenterDay: {
		"32BitSubstring_LevelID_asHexBE": memUtil_asciiStringToHexBE("terD"), // DM_TradeCen 'terD' ay
		"OffsetTo_Substring_LevelID": 11,	
		},
	}

function MP_LEVEL_DATA_getOffsetToSubstringLevelID(enum_MPlevel) =>
	CONST_MP_LEVEL_DATA[enum_MPlevel]["OffsetTo_Substring_LevelID"]

function MP_LEVEL_DATA_get32BitSubstringLevelID_asString(enum_MPlevel) {
	let_int_offsetTo_SubstringLevelID = MP_LEVEL_DATA_getOffsetToSubstringLevelID(enum_MPlevel)
	return substring(enum_MPlevel, let_int_offsetTo_SubstringLevelID, 4)} // NOTE: Substring --> Only check [4-byte] of ASCII

function MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(enum_MPlevel) =>
	CONST_MP_LEVEL_DATA[enum_MPlevel]["32BitSubstring_LevelID_asHexBE"]

function MP_LEVEL_DATA_getAllLevelIDsWithOffsetToSubstringLevelID(int_offsetTo_substringLevelID) =>
	array_filter(CONST_MP_LEVEL_DATA, (enum_MPlevel) {
		if (MP_LEVEL_DATA_getOffsetToSubstringLevelID(enum_MPlevel) == int_offsetTo_substringLevelID)
			return true
		else 
			return false
	})

function MP_LEVEL_DATA_getAllUniqueOffsetsToSubstringLevelID() {
	let_array_UniqueOffsetsToSubstringLevelID = []
	for enum_MPlevel in CONST_MP_LEVEL_DATA {
		let_OffsetToSubstringLevelID = MP_LEVEL_DATA_getOffsetToSubstringLevelID(enum_MPlevel)
		if (!array_contains(let_array_UniqueOffsetsToSubstringLevelID, let_OffsetToSubstringLevelID))
			array_push(let_array_UniqueOffsetsToSubstringLevelID, let_OffsetToSubstringLevelID)
	}
	return let_array_UniqueOffsetsToSubstringLevelID}

// ----------------StoryModeProgression---------------------
function current_InProgressStoryChapterID(enum_releaseRegion) =>
	byte(memory_getAddress("8-bit:InProgress_StoryChapterID", enum_releaseRegion))

function current_calculated_StoryProgressionPercentage(enum_releaseRegion) {
	const_MAX_STORY_PROGRESS = 22 // 0x15 + 1 = 22 (0x15 = Chapter 17, "Curse of the West") BUT to check if this Chapter is completed, use [BitFlag:IsStoryGoodEndingAchieved] OR [BitFlag:IsStoryEvilEndingAchieved]
	return (current_InProgressStoryChapterID(enum_releaseRegion) / const_MAX_STORY_PROGRESS) * 100.0} 

function current_flagState_IsStoryGoodEndingAchieved(enum_releaseRegion) =>
	byte(memory_getAddress("BitFlag:IsStoryGoodEndingAchieved", enum_releaseRegion))

function current_flagState_IsStoryEvilEndingAchieved(enum_releaseRegion) =>
	byte(memory_getAddress("BitFlag:IsStoryEvilEndingAchieved", enum_releaseRegion))

function is_AnyEndingAchieved(enum_releaseRegion) => 
	current_flagState_IsStoryGoodEndingAchieved(enum_releaseRegion)
	+ current_flagState_IsStoryEvilEndingAchieved(enum_releaseRegion) >= 1
// ----------------ChapterSectionID---------------------
function ASCII_MEM_ADDR_ChapterSectionID(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:LevelID(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:LevelID", "ASCII:StoryChapterSectionID(preferred)", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:LevelID", "ASCII:StoryChapterSectionID(preferred)")
	return let_memAddr_ASCII}

function is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion) {
	let_memAddr_ASCII = ASCII_MEM_ADDR_ChapterSectionID(enum_releaseRegion)
	let_string_ChapterSectionID = LEVEL_DATA_getFullStringChapterSectionID(enum_chapter, enum_chapterSection)

	if(enum_chapter == CHAPTER_13_MorningAfter || enum_chapter == CHAPTER_16_Deadfall) { // NOTE: These Chapters require an extra check (eg. CHAPTER_13_MorningAfter has ChapterSectionIDs: "M12_AA" and "M12_A")
		return 
			is_ASCII_EqualTo(let_memAddr_ASCII, let_string_ChapterSectionID)
			&& byte(let_memAddr_ASCII + length(let_string_ChapterSectionID)) == 0 // --CheckIf--> The byte after the ASCIIstring is zeroed out (0x0)
	} else {
		return is_ASCII_EqualTo(let_memAddr_ASCII, let_string_ChapterSectionID)
	}}

// ----------------LevelID---------------------
function ASCII_MEM_ADDR_LevelID(enum_releaseRegion, int_offsetTo_substringLevelID = 0) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:LevelID(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:LevelID", "ASCII:LevelID(full)", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:LevelID", "ASCII:LevelID(full)")
		+ int_offsetTo_substringLevelID
	return let_memAddr_ASCII}
	
function is_Level(string_levelID, enum_releaseRegion) => 
	is_ASCII_EqualTo(ASCII_MEM_ADDR_LevelID(enum_releaseRegion), string_levelID)

function is_LevelSubstring(substring_levelID, int_offsetTo_substringLevelID, enum_releaseRegion) => 
	is_ASCII_EqualTo(ASCII_MEM_ADDR_LevelID(enum_releaseRegion, int_offsetTo_substringLevelID), substring_levelID)

function is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion) {
	let_substring_LevelID = LEVEL_DATA_getLevelID_substring(enum_chapter) // NOTE: Substring --> Only check FIRST [4-byte] of ASCII
	return is_Level(let_substring_LevelID, enum_releaseRegion)}

function is_LevelSubstring_Multiplayer(enum_MPlevel, enum_releaseRegion) {
	let_substring_LevelID =  MP_LEVEL_DATA_get32BitSubstringLevelID_asString(enum_MPlevel)
	let_int_offsetTo_SubstringLevelID = MP_LEVEL_DATA_getOffsetToSubstringLevelID(enum_MPlevel)
	return is_LevelSubstring(let_substring_LevelID, let_int_offsetTo_SubstringLevelID, enum_releaseRegion)}

// #endregion Level ID

// ................
// ◦ Sub_Header_1 ◦
// ''''''''''''''''
// #region Sub_Header_1

// ----------------Divider---------------------

// #endregion Sub_Header_1

// ................
// ◦ Sub_Header_2 ◦
// ''''''''''''''''
// #region Sub_Header_2

// #endregion Sub_Header_2

// =========================
// • MEMORY initialization •
// =========================
// #region MEM - initialization

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
	}
memory_initialize()
// #endregion MEM - initialization
// #endregion MEMORY

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
// #region ACHIEVEMENTS

// =========================
// • ACHIEVEMENT core data •
// =========================
// #region ACH - core data
// - Divided by category => when in debug mode, category tags are added to achievement titles
// ----------------ENUM:achievement_POINTS---------------------
	achievement_POINTS_0 = 0		// Free - Freebie/informational achievement
	achievement_POINTS_1 = 1 		// Minor - Finding a hidden item, do some arbitrary/easter egg task
	achievement_POINTS_2 = 2 		// Basic - Defeating a few enemies
	achievement_POINTS_3 = 3 		// Easy - Completing an easy quest or level
	achievement_POINTS_4 = 4 		// Intermediate - Completing a harder quest or level
	achievement_POINTS_5 = 5 		// Advanced - Collecting rare items or completing a level
	achievement_POINTS_10 = 10		// Challenging - Defeating a major boss or collecting a VERY rare one-of-a-kind item
	achievement_POINTS_25 = 25 		// Hard - Completing the game 
	achievement_POINTS_50 = 50 		// VeryHard - Achieving 100% completion
	achievement_POINTS_100 = 100 	// Impossible - Completing the game without taking a hit (extreme challenge achievements, typical for bonus sets)

achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
		// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_Story": { // Category - Story Progression Achievements
		// "a_WrongTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_1_WrongTrain Completion"}, 
		// "a_RideDevil": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_2_RideDevil Completion"},
		// "a_Boneyard": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_3_Boneyard Completion"},
		// "a_DevilMine": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_4_DevilMine Completion"},
		// "a_DWOutpost": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_5_Outpost Completion"},
		// "a_WarTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_6_WarTrain Completion"}, 
		// "a_TortureMaze": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_7_TortureMaze Completion"}, 
		// "a_BaptismFire": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_8_BaptismFire Completion"}, 
		// "a_Rescue": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_9_Rescue Completion"},
		// "a_Prism": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_10_Prism Completion"},
		// "a_Invasion": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_11_Invasion Completion"},
		// "a_Hangtown": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_12_Hangtown Completion"},
		// "a_MorningAfter": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_13_MorningAfter Completion"},
		// "a_Showdown": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_14_Showdown Completion"},
		// "a_RightTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_15_RightTrain Completion"},
		// "a_Deadfall": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_16_Deadfall Completion"},
		},
	"c_StoryEnd": { // Category - Story Win Condition Achievements
		// "a_CurseWestGood": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Good ending"},		
		// "a_CurseWestEvil": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Evil ending"},
		},
	"c_Challenge": { // Category - info_here
		// "a_ClgWrongTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_1_WrongTrain on Deadeye difficulty with no deaths and a minimum combined accuracy of xx%"}, 
		// "a_ClgRideDevil": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_2_RideDevil on Deadeye difficulty with no deaths and the combined HP never goes below 50%"},
		// "a_ClgBoneyard": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_3_Boneyard on Deadeye difficulty with no deaths using only the Crossbow and Carbine to score at least xx kills total"},
		// "a_ClgDevilMine": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_4_DevilMine on Deadeye difficulty with no deaths and no powers, where one player only uses pistols and the other only two-handed weapons"},
		// "a_ClgDWOutpost": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_5_Outpost on Deadeye difficulty with no deaths and the combined HP never being below max HP for xx seconds consecutively"},
		// "a_ClgWarTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_6_WarTrain on Deadeye difficulty with within xx time and without any player losing any HP"}, 
		// "a_ClgTortureMaze": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_7_TortureMaze on Deadeye difficulty with no deaths with at least xx% melee kills total, where one player only uses the Scepter and the other only shoots"}, 
		// "a_ClgBaptismFire": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_8_BaptismFire on Deadeye difficulty with no deaths using only the Redeemer and the Rail Rocket to score at least xx kills total"}, 
		// "a_ClgRescue": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_9_Rescue on Deadeye difficulty with within xx time and without any player going below xx% HP"},
		// "a_ClgPrism": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_10_Prism on Deadeye difficulty with no deaths and with less than xx power activations"},
		// "a_ClgInvasion": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_11_Invasion on Deadeye difficulty with no deaths using only the Dual Pistol"},
		// "a_ClgHangtown": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_12_Hangtown on Deadeye difficulty with no deaths using the Range Rifle as the only option to shoot from afar, with a minimum combined accuracy of xx%"},
		// "a_ClgMorningAfter": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_13_MorningAfter on Deadeye difficulty with no deaths using only tier 2 and 3 powers, with at least xx% headshot or melee kills"},
		// "a_ClgShowdown": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_14_Showdown on Deadeye difficulty with no deaths with a minimum combined accuracy of xx% and using only 1 distinct power"},
		// "a_ClgRightTrain": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_15_RightTrain on Deadeye difficulty with no deaths within xx time and without any player going below xx% HP"},
		// "a_ClgDeadfall": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_16_Deadfall on Deadeye difficulty with no deaths, using only the Range Rifle and Carbine and with at least xx% headshot kills"},
		// "a_ClgCurseWest": { // CONCEPT
			// "id": 000000, "points": 0000000, "devInfo": "Complete CHAPTER_17_CurseWest on Deadeye difficulty with no deaths and where each player can only use each power once"},
		},
	"c_Bonus": { // Category - Bonus achievements
		// "a_MultiKillers": {
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Complete a Chapter, where each player scored at least one multikill"}
		// "a_SunHi": {
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Both player use powers in sunlight"}
		// "a_AllEvil": {
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Unlock all Evil powers"}
		// "a_AllGood": {
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Unlock all Good powers"}
		},
	}
// ----------------ENUM:achievement_TYPE---------------------
	achievement_TYPE_Progression = "progression"
	achievement_TYPE_WinCondition = "win_condition"
	achievement_TYPE_Missable = "missable"
	achievement_TYPE_Standard = ""

achievements_typeByCategory = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	"c_Story": 		achievement_TYPE_Progression,
	"c_StoryEnd": 	achievement_TYPE_WinCondition,
	"c_Challenge": 	achievement_TYPE_Standard,
	"c_Bonus": 		achievement_TYPE_Standard}

	
// #endregion ACH - core data

// ==================================
// • ACHIEVEMENT trigger generators •
// ==================================
// #region ACH - trigger generators
//	- For achievement logic that's reoccuring across multiple triggers

// #endregion ACH - trigger generators

// ========================
// • ACHIEVEMENT triggers •
// ========================
// #region ACH - triggers
achievements_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP _template
		// // [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()),
	}
// #endregion ACH - triggers

// =====================
// • ACHIEVEMENT text •
// =====================
// #region ACH - text
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	}
// #endregion ACH - text

// ==============================
// • ACHIEVEMENT initialization •
// ==============================
// #region ACH - initialization
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

		let_descriptionString = achievements_getDescription(string_achievementDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util_throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_achievementDevName))

		let_descriptionString_withDevInfo = let_descriptionString + achievements_formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}

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
// #endregion ACH - initialization
// #endregion ACHIEVEMENTS

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
// #region RICH PRESENCE
// TODO implement Rich Presence

// ======================
// • RICH PRESENCE text •
// ======================
// #region RP - text
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 				{"en": "xxxxxxxx"},
	"rp_DefaultPlus":				{"en": "xxxxxxxx"},
	"rp_Default":					{"en": "xxxxxxxx"}}
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	}
richPresence_ReleaseRegion_toSuperScript = {
	// NOTE: Text to superscript --> https://lingojam.com/SuperscriptGenerator
	RELEASE_REGION_USA: "ᵘˢ",
	RELEASE_REGION_EUR: "ᵉᵘ",
	RELEASE_REGION_JPN: "ʲᵖ",
	}
	
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

funciotn richPresence_getText_withRegionSuperScript(string_textKey, enum_releaseRegion) =>
	format("{0} {1}", richPresence_ReleaseRegion_toSuperScript[enum_releaseRegion], richPresence_getText(string_textKey))

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	// "lup_Template": {
		// "LookupTableText_Key": "lupText_Template",
		// "LookUpTable": {
		// 	enum_XXX_A:					"LookupTextKey_A",
		// 	enum_XXX_B:					"LookupTextKey_B",
		// 	enum_XXX_C:					"LookupTextKey_C",
		// 	},
		// },
	}
function richPresence_getLookupTable(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]["LookUpTable"]
function richPresence_getLookupTableTextKey(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]["LookupTableText_Key"]
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
// #endregion RP - text

// ================================
// • RICH PRESENCE display script •
// ================================
// #region RP - display script

// function rp_TemplateDisplayScript(enum_releaseRegion) { 
	// function condition(enum_releaseRegion) =>
	// 	is_ReleaseRegion(enum_releaseRegion)
	// return rich_presence_conditional_display( 
	// 	condition(enum_releaseRegion),
	// 	richPresence_getText_withRegionSuperScript("rp_Template", enum_releaseRegion),
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_DefaultPlus", enum_releaseRegion)
	)}
function rp_Default() {
	return rich_presence_display(
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default() // TODO rp_Default
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		// rp_DefaultPlus(enum_releaseRegion) // CONCEPT rp_DefaultPlus
	}} 
// #endregion RP - display script

// ===========================
// • RICH PRESENCE parameters •
// ===========================
// #region RP - parameters
richPresence_VALUE = 1			// rich_presence_value(name, expression, [format])
richPresence_LOOKUP_HEX = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_LOOKUP_STRING = 3	//  rich_presence_ascii_string_lookup(name, memAddr_ASCII, dictionary, [fallback])
richPresence_MACRO = 4			// rich_presence_macro(macro, expression)
// -------------------------------------

// -------------------------------------
richPresence_parameterData = {
	// DEV_NOTE: rich presence
	// 		- Expression examples:
	//			-- Memory Accessor => byte(0x000)
	//			-- Arithmetic Expression => getCurrentLevel() + 1
	// 		- Available macro formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_macromacro-expression
	// 		- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// ------------------------------------------------------
	
	// "rpp_ValueTemplate": {
		// "RPtype": richPresence_VALUE,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "ValueFormat": "VALUE"},

	// "rpp_LookupHexTemplate": {
		// "RPtype": richPresence_LOOKUP_HEX,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_LookupStringTemplate": {
		// "RPtype": richPresence_LOOKUP_STRING,
		// "MemoryAddressToASCII": {
		// 	RELEASE_REGION_USA: memory_getAddress(), 
		// 	RELEASE_REGION_EUR: memory_getAddress(),
		// 	RELEASE_REGION_JPN: memory_getAddress()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_MacroTemplate": {
		// "RPtype": richPresence_MACRO,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "MacroFormat": "Number"},
	
	

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
	
	function richPresence_callLookupHexFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_expression = dict_paramLookupData["Expression"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}

	function richPresence_callLookupStringFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_memAddr_ASCII = dict_paramLookupData["MemoryAddressToASCII"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_ascii_string_lookup(let_name, let_memAddr_ASCII, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData, enum_releaseRegion) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"][enum_releaseRegion]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP_HEX) return richPresence_callLookupHexFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP_STRING) return richPresence_callLookupStringFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}
// #endregion RP - parameters

// ===============================
// • RICH PRESENCE initialization •
// ===============================
// #region RP - initialization
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_lookupTableKey in richPresence_lookupTables { 
		let_lookupTable = richPresence_getLookupTable(let_lookupTableKey)
		let_lookupTableTextKey = richPresence_getLookupTableTextKey(let_lookupTableKey)
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_lookupTableKey]["LookUpTable"][let_lookupKey]
			richPresence_lookupTables[let_lookupTableKey]["LookUpTable"][let_lookupKey] = richPresence_getLookupTableText(let_lookupTableTextKey, let_lookupValue)
		}
	}}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_initializeZeroPaddingLookupTables() // <-- should be called after richPresence_populateLookupTables() as ZeroPaddingLookupTables don't need to be populated AND before richPresence_initializeDisplays()
	richPresence_initializeDisplays()}
// #endregion RP - initialization
// #endregion RICH PRESENCE

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
// #region LEADERBOARDS
// TODO implement leaderboards

// =========================
// • LEADERBOARD core data •
// =========================
// #region LB - core data
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
		// "id": 000000, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "xxxxxxx"},
	}
// #endregion LB - core data

// ==================================
// • LEADERBOARD trigger generators •
// ==================================
// #region LB - trigger generators
//	- For leaderboard logic that's reoccuring across multiple triggers
// #endregion LB - trigger generators

// ========================
// • LEADERBOARD triggers •
// ========================
// #region LB - triggers
leaderboards_startTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [0] ==== Alt Start Group ====		-> Start when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [1] ==== Alt Start Group ====		-> Start when ...
		//  || is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Start Group ====		-> Start when ...
		//  || is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
leaderboards_cancelTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [3] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
leaderboards_submitTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Submit Group ====			-> Submit when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Reset Group ====			-> Reset when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
//-----------------ValueMeasures-------------------
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(
			current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion),
			when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}
leaderboards_valueMeasures = {
	// "lb_template": lb_ValueMeasure_Template(),
	}
// #endregion LB - triggers

// ====================
// • LEADERBOARD text •
// ====================
// #region LB - text
leaderboards_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
leaderboards_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
// #endregion LB - text

// ==============================
// • LEADERBOARD initialization •
// ==============================
// #region LB - initialization
function leaderboards_initialize() {
	function leaderboards_generateTitle(string_leaderboardDevName, string_languageCode) {
		function leaderboards_createDevName(string_leaderboardDevName) => 	// Wrap LeaderoboardDevName in [] (brackets)
			format("[{0}] ", string_leaderboardDevName)
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

		let_descriptionString = leaderboards_getDescription(string_leaderboardDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util_throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_leaderboardDevName))

		let_descriptionString_withDevInfo = let_descriptionString + leaderboards_formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}
	

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
// #endregion LB - initialization
// #endregion LEADERBOARDS

// ====================================================================== \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ====================================================================== \\
// #region RAScript Initialization
function initializeRAscript() {
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()
// #endregion RAScript Initialization