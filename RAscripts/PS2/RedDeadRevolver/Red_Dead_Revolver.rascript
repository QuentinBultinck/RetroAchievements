// ***************************************************************** \\
// █▀█ █▀▀ █▀▄    █▀▄ █▀▀ ▄▀█ █▀▄    █▀█ █▀▀ █░█ █▀█ █░░ █░█ █▀▀ █▀█ \\
// █▀▄ ██▄ █▄▀    █▄▀ ██▄ █▀█ █▄▀    █▀▄ ██▄ ▀▄▀ █▄█ █▄▄ ▀▄▀ ██▄ █▀▄ \\
// ***************************************************************** \\
// #ID = 11094
// md5: c06c59490d239fb56ace0388ac2b2842 - PAL/EUR
// Platform: PlayStation 2
// Achievement Guide: https://github.com/RetroAchievements/guides/wiki/Red-Dead-Revolver-(PlayStation-2)
// RA Game Page: https://retroachievements.org/game/11094

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
 
// TODO - Update RAguide

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

util_isDebugModeActive = true	// if true => extra information may be displayed on achievement titles & descriptions
util_language = "en"	// ISO 639-1 language codes 

iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
sNULL = "-1"

RELEASE_REGION_USA = "NTSC-U"
RELEASE_REGION_JPN = "NTSC-J"
RELEASE_REGION_EUR = "PAL"
RELEASE_REGIONS_SUPPORTED = [RELEASE_REGION_EUR] // TODO add regions

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
	}
function memory_getRegionOffset(string_structKey, string_offsetKey) =>
	memory_regionOffsets[string_structKey][string_offsetKey]
// -------------------------------------
memory_dataStructures = {
	"PS2Vector": {
		"offsetToMember": {
			"W-Component": 0x0,
			"Y-Coordinate": 0x4,
			"Z-Coordinate": 0x8,
			"X-Coordinate": 0xC	}
		},
	"Struct_PlayerProfileData": {
		"sizeInBytes": 2840,
		"offsetToMember": {
			"32BitFloat_TimeSpentPlaying": 0x388,
			"32Bit_StoryModeRetries": 0x28C}
		},
	"Struct_RewardMenuDisplayData": {
		"pointerChains": {
			"32Bit_Balance": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0xA04]},
			"32Bit_BountyCollected": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0x9E4]},
			"BitFlag_IsRewardMenuDisplayed": { 
				"addAddressChain": [0xAC, 0x38]},
		}},
	"Struct_InGameMenuController": {
		"offsetToMember": {
			"ASCII_InGameMenuID": 0x18,
			"BitFlag_IsInGameMenuDisplayed": 0x38},
		},
	"Struct_SinglePlayerData": {
		"pointerChains": {
			"ASCIi_GameTriggerID": { 
				"addAddressChain": [0x168, 0xEC],
				"offsetToPointedToMember": 0x4}, // <-- This is the offset to the member inside the struct, which the pointer chain points to
			"32Bit_ShotsFired": { 
				"addAddressChain": [0x36C, 0x0]},
			"32Bit_ShotsHit": { 
				"addAddressChain": [0x36C, 0x2C]},
			"PS2Vector_PlayerLocation": { 
				"addAddressChain": [0xC, 0xC, 0x90]},
			"Bitset_PlayerProfileUnlocks": { 
				"addAddressChain": [0x5C8]},
		}},
	"Struct_GameController": {
		"pointerChains": {
			"EquippedWeapon_ReserveAmmo": { 
				"addAddressChain": [0x2C, 0x14]}
		}}
	}

function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_memberKey) =>
	memory_dataStructures[string_structKey]["offsetToMember"][string_memberKey]

function memory_getPointerChainOffsetToMember(string_structKey, string_pointerChainKey) => 
	memory_dataStructures[string_structKey]["pointerChains"][string_pointerChainKey]["offsetToPointedToMember"]

function memory_generateAddAddressPointerChain(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToMember = 0, accessor = dword) {
	let_array_pointerChainOffsets = memory_dataStructures[string_structKey]["pointerChains"][string_pointerChainKey]["addAddressChain"]
	let_addAddressPointerChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return accessor(let_addAddressPointerChain + let_array_pointerChainOffsets[let_index] + int_offsetToMember)
		else let_addAddressPointerChain = dword(let_addAddressPointerChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}
// ==========================
// • Memory ADDRESS STORAGE •
// ==========================
DATATYPE_BitFlag 				= 700
DATATYPE_Upper4 				= 600
DATATYPE_Lower4 				= 600
DATATYPE_8Bit 					= 500
DATATYPE_16BitBE 				= 401
DATATYPE_16Bit 					= 400
DATATYPE_24Bit 					= 350
DATATYPE_32BitPointer 			= 300
DATATYPE_32Bit 					= 200
DATATYPE_Float					= 201
DATATYPE_ASCII					= 150
DATATYPE_Struct 				= 100
memory_addresses = {
	// DATATYPE_xxxxx: {
	// 	"Template": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	// 	},0x501a38

	DATATYPE_BitFlag: {
		"IsInGame": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x501a38, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_8Bit: {
		"NumberOfPlayers": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73dd6c, RELEASE_REGION_JPN: 0x73f2ec},
		"GameState": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fbaf0, RELEASE_REGION_JPN: sNULL},
		"UIRenderStackLevel": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a10, RELEASE_REGION_JPN: sNULL}, // Unused
		},	
	DATATYPE_ASCII: {
		"GameID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54c7cc, RELEASE_REGION_JPN: 0x54dd4c},
		"AreaID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a0620, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_32BitPointer: {
		"SinglePlayerData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x763070, RELEASE_REGION_JPN: sNULL},
		"Selected_PlayerProfileData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7448d8, RELEASE_REGION_JPN: sNULL},
		"GameController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a20, RELEASE_REGION_JPN: sNULL},
		"RewardMenu_DisplayData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54caf0, RELEASE_REGION_JPN: sNULL},
		"InGameMenuController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73d60c, RELEASE_REGION_JPN: sNULL},
		}
	}

function memory_getAddress(enum_dateType, string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[enum_dateType][string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}

// ==================
// • Memory UTILITY •
// ==================
memUtil_bitIndexToMemAccessor = {
	0: bit0,
	1: bit1,
	2: bit2,
	3: bit3,
	4: bit4,
	5: bit5,
	6: bit6,
	7: bit7}

function is_ReleaseRegion(enum_releaseRegion) {
	let_memAddr_gameID = memory_getAddress(DATATYPE_ASCII, "GameID", enum_releaseRegion)
	let_string_gameID = sNULL

	if(enum_releaseRegion == RELEASE_REGION_USA) {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	} else if(enum_releaseRegion == RELEASE_REGION_JPN) {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
		let_string_gameID = "SLPM_658.54"
	} else if(enum_releaseRegion == RELEASE_REGION_EUR) {
		let_string_gameID = "SLES_528.78"
	} else {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	}

	return ascii_string_equals(let_memAddr_gameID, let_string_gameID, 4)
	}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
	// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
function memUtil_floatToInt(float_value, enum_releaseRegion) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", enum_releaseRegion))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

function memUtil_bitwiseOR(memAccessor_A, memAccessor_B) => // A OR B => A + B - A AND B (workaround as rCheevos doesn't support bitwise-OR out-of-the-box)
	memAccessor_A + memAccessor_B - (memAccessor_A & memAccessor_B)

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

// ----------------CustomASCIIcomparitors---------------------
function ASCII_Equals(memAddr_ASCII, array_ASCIIasHex_ToCheck, wrapper = c => c) {
	let_ASCIIcharacterCount = length(array_ASCIIasHex_ToCheck)
	let_array_comparisons = []
	for let_stepBy4Index in range(0, let_ASCIIcharacterCount - 1, step = 4) {
		let_ASCIIchars = 0
		if (let_stepBy4Index + 4 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 3) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, dword_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 3 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 2) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, tbyte_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 2 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 1) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, word_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 1 <= let_ASCIIcharacterCount) {
			let_ASCIIchar = array_ASCIIasHex_ToCheck[let_stepBy4Index]
			array_push(let_array_comparisons, byte(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchar)
		}
	}
	return all_of(let_array_comparisons, wrapper)}

function ASCII_NotEquals(memAddr_ASCII, array_ASCIIasHex_ToCheck, wrapper = c => c) {
	let_ASCIIcharacterCount = length(array_ASCIIasHex_ToCheck)
	let_array_comparisons = []
	for let_stepBy4Index in range(0, let_ASCIIcharacterCount - 1, step = 4) {
		let_ASCIIchars = 0
		if (let_stepBy4Index + 4 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 3) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, dword_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 3 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 2) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, tbyte_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 2 <= let_ASCIIcharacterCount) {
			for let_stepBy1Index in range(0, 1) let_ASCIIchars = (let_ASCIIchars * 0x100) + array_ASCIIasHex_ToCheck[let_stepBy4Index + let_stepBy1Index]
			array_push(let_array_comparisons, word_be(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchars)
		} else if (let_stepBy4Index + 1 <= let_ASCIIcharacterCount) {
			let_ASCIIchar = array_ASCIIasHex_ToCheck[let_stepBy4Index]
			array_push(let_array_comparisons, byte(memAddr_ASCII + let_stepBy4Index) == let_ASCIIchar)
		}}
	return none_of(let_array_comparisons, wrapper)}

function is_ASCII(memAddr_ASCII, array_ASCIIasHex_ToCheck) =>
	ASCII_Equals(memAddr_ASCII, array_ASCIIasHex_ToCheck)

function was_ASCII(memAddr_ASCII, array_ASCIIasHex_ToCheck) =>
	ASCII_Equals(memAddr_ASCII, array_ASCIIasHex_ToCheck, c => prior(c))

function on_ASCII_changeTo(memAddr_ASCII, array_ASCIIasHex_ToCheck) =>
	ASCII_Equals(memAddr_ASCII, array_ASCIIasHex_ToCheck) && 
	ASCII_NotEquals(memAddr_ASCII, array_ASCIIasHex_ToCheck, c => prev(c))

// ...........
// ◦ AREA ID ◦
// '''''''''''
AREA_loading = "default"
AREA_Campaign_BrokenCreek = "lvl_perfnew"
AREA_Campaign_Railroaded = "lvl_traingood"

function is_AreaLoading_active(enum_releaseRegion) => 
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), AREA_loading)

function is_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId)

function was_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prior(areaCheckComparison))

function on_Area_changeTo(enum_areaId, enum_releaseRegion) =>
	is_Area(enum_areaId, enum_releaseRegion) &&
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prev(areaCheckComparison))

// ...................
// ◦ Game Trigger ID ◦
// '''''''''''''''''''
GAMETRIGGER_ShootingTutorial_Start = "Pre_TargetA_NoCine"
GAMETRIGGER_ShootingTutorial_GoodCompletion = "GoodComp_Phase4_NoCine2" 
const_GameTrigger_asHex = {
	GAMETRIGGER_ShootingTutorial_Start: {
		"Short": [0x50,0x72,0x65,0x5F,0x54,0x61,0x72,0x67,0x65,0x74,0x41], // "Pre_TargetA"
		"Full": [0x50,0x72,0x65,0x5F,0x54,0x61,0x72,0x67,0x65,0x74,0x41,0x5F,0x4E,0x6F,0x43,0x69,0x6E,0x65]
	},
	GAMETRIGGER_ShootingTutorial_GoodCompletion: {
		"Short": [0x47,0x6F,0x6F,0x64,0x43,0x6F,0x6D,0x70], // "Goodcomp"
		"Full": [0x47,0x6F,0x6F,0x64,0x43,0x6F,0x6D,0x70,0x5F,0x50,0x68,0x61,0x73,0x65,0x34,0x5F,0x4E,0x6F,0x43,0x69,0x6E,0x65,0x32]
	}}

function is_GameTrigger(enum_gameTrigger, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "ASCIi_GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getPointerChainOffsetToMember("Struct_SinglePlayerData", "ASCIi_GameTriggerID")
	return is_ASCII(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])}

function on_GameTrigger_changeTo(enum_gameTrigger, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "ASCIi_GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getPointerChainOffsetToMember("Struct_SinglePlayerData", "ASCIi_GameTriggerID")
	return on_ASCII_changeTo(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])}

// ...................
// ◦ Player Location ◦
// '''''''''''''''''''
PLAYER_STATIONARY_THRESHOLD = 0.7
function current_PlayerXCoordinate(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memory_generateAddAddressPointerChain(
			"Struct_SinglePlayerData", "PS2Vector_PlayerLocation", let_memAddr_SinglePlayerData, 
			int_offsetToMember = memory_getDataStructOffset("PS2Vector", "X-Coordinate"), 
			accessor = float)
	return let_memAccessor_PlayerCoordinate}

function current_PlayerYCoordinate(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memory_generateAddAddressPointerChain(
			"Struct_SinglePlayerData", "PS2Vector_PlayerLocation", let_memAddr_SinglePlayerData, 
			int_offsetToMember = memory_getDataStructOffset("PS2Vector", "Y-Coordinate"), 
			accessor = float)
	return let_memAccessor_PlayerCoordinate}

	
function current_PlayerZCoordinate(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memory_generateAddAddressPointerChain(
			"Struct_SinglePlayerData", "PS2Vector_PlayerLocation", let_memAddr_SinglePlayerData, 
			int_offsetToMember = memory_getDataStructOffset("PS2Vector", "Z-Coordinate"), 
			accessor = float)
	return let_memAccessor_PlayerCoordinate}

function is_PlayerXCoordinate_stationaryNearCoordinate(float_Xcoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerXCoordinate = current_PlayerXCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerXCoordinate >= float_Xcoordinate - PLAYER_STATIONARY_THRESHOLD && 
		let_memAccessor_PlayerXCoordinate <= float_Xcoordinate + PLAYER_STATIONARY_THRESHOLD}
		
function is_PlayerXCoordinate_notStationaryNearCoordinate(float_Xcoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerXCoordinate = current_PlayerXCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerXCoordinate <= float_Xcoordinate - PLAYER_STATIONARY_THRESHOLD || 
		let_memAccessor_PlayerXCoordinate >= float_Xcoordinate + PLAYER_STATIONARY_THRESHOLD}

function is_PlayerYCoordinate_stationaryNearCoordinate(float_Ycoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerYCoordinate = current_PlayerYCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerYCoordinate >= float_Ycoordinate - PLAYER_STATIONARY_THRESHOLD && 
		let_memAccessor_PlayerYCoordinate <= float_Ycoordinate + PLAYER_STATIONARY_THRESHOLD}
		
function is_PlayerYCoordinate_notStationaryNearCoordinate(float_Ycoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerYCoordinate = current_PlayerYCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerYCoordinate <= float_Ycoordinate - PLAYER_STATIONARY_THRESHOLD || 
		let_memAccessor_PlayerYCoordinate >= float_Ycoordinate + PLAYER_STATIONARY_THRESHOLD}

// ..................
// ◦ PLAYER PROFILE ◦
// ''''''''''''''''''
// ----------------PlayerProfileSTATISTICS--------------------
function on_PlayerProfileStat_TimeSpentPlaying_change(enum_releaseRegion)	{
	let_memAddrPointerTo_SelectedPlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_Statistic = memory_getDataStructOffset("Struct_PlayerProfileData", "32BitFloat_TimeSpentPlaying")
	let_memAccessor_Statistic = float(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_Statistic)
	return let_memAccessor_Statistic != prev(let_memAccessor_Statistic)}

function on_PlayerProfileStat_StoryModeRetries_increment(enum_releaseRegion) {
	let_memAddrPointerTo_SelectedPlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_Statistic = memory_getDataStructOffset("Struct_PlayerProfileData", "32Bit_StoryModeRetries")
	let_memAccessor_Statistic = dword(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_Statistic)
	return let_memAccessor_Statistic > prev(let_memAccessor_Statistic)}

// ----------------PlayerProfileUNLOCKS--------------------
UNIQUE_WEAPON_COUNT = 24
UPGRADEABLE_WEAPON_COUNT = 16
Bitset_PlayerProfileUnlocks_data = {
	"Flags_AllUpgradedWeapons": {
		1: [4,6],
		2: [0,2,5,7],
		3: [1,3,5,7],
		4: [1,3,6],
		5: [0,3,5]},
	"Flags_AllWeapons": { 
		"AllFlags": { // 40 flags --> AddSource each Flag (or bitcount with subsource non-weapon flags in byte)
			1: [3,4,5,6,7],
			2: [0,1,2,3,4,5,6,7],
			3: [0,1,2,3,4,5,6,7],
			4: [0,1,2,3,4,5,6,7],
			5: [0,1,2,3,4,5,6,7],
			6: [2,3,4],
			},
		"NonUniqueFlags": { // 16 weapons have double flags --> SubSource Flag_Normal OR Flag_Upgraded
			"OldPistol": {
				"Flag_Normal": {"ByteIndex": 1, "BitIndex": 3},
				"Flag_Upgraded": {"ByteIndex": 1, "BitIndex": 4}},
			"Revolver": {
				"Flag_Normal": {"ByteIndex": 1, "BitIndex": 5},
				"Flag_Upgraded": {"ByteIndex": 1, "BitIndex": 6}},
			"TwinRevolver": {
				"Flag_Normal": {"ByteIndex": 1, "BitIndex": 7},
				"Flag_Upgraded": {"ByteIndex": 2, "BitIndex": 0}},
			"Widowmaker": {
				"Flag_Normal": {"ByteIndex": 2, "BitIndex": 1},
				"Flag_Upgraded": {"ByteIndex": 2, "BitIndex": 2}},
			"BreechLoader": {
				"Flag_Normal": {"ByteIndex": 2, "BitIndex": 4},
				"Flag_Upgraded": {"ByteIndex": 2, "BitIndex": 5}},
			"TheLion": {
				"Flag_Normal": {"ByteIndex": 2, "BitIndex": 6},
				"Flag_Upgraded": {"ByteIndex": 2, "BitIndex": 7}},
			"TwelveGauge": {
				"Flag_Normal": {"ByteIndex": 3, "BitIndex": 0},
				"Flag_Upgraded": {"ByteIndex": 3, "BitIndex": 1}},
			"OwlRifle": {
				"Flag_Normal": {"ByteIndex": 3, "BitIndex": 2},
				"Flag_Upgraded": {"ByteIndex": 3, "BitIndex": 3}},
			"RepeaterRifle": {
				"Flag_Normal": {"ByteIndex": 3, "BitIndex": 4},
				"Flag_Upgraded": {"ByteIndex": 3, "BitIndex": 5}},
			"HighCaliber": {
				"Flag_Normal": {"ByteIndex": 3, "BitIndex": 6},
				"Flag_Upgraded": {"ByteIndex": 3, "BitIndex": 7}},
			"SixShooter": {
				"Flag_Normal": {"ByteIndex": 4, "BitIndex": 0},
				"Flag_Upgraded": {"ByteIndex": 4, "BitIndex": 1}},
			"Pacificador": {
				"Flag_Normal": {"ByteIndex": 4, "BitIndex": 2},
				"Flag_Upgraded": {"ByteIndex": 4, "BitIndex": 3}},
			"HalconRifle": {
				"Flag_Normal": {"ByteIndex": 4, "BitIndex": 5},
				"Flag_Upgraded": {"ByteIndex": 4, "BitIndex": 6}},
			"BayonetRifle": {
				"Flag_Normal": {"ByteIndex": 4, "BitIndex": 7},
				"Flag_Upgraded": {"ByteIndex": 5, "BitIndex": 0}},
			"SawnOff": {
				"Flag_Normal": {"ByteIndex": 5, "BitIndex": 2},
				"Flag_Upgraded": {"ByteIndex": 5, "BitIndex": 3}},
			"Escopeta": {
				"Flag_Normal": {"ByteIndex": 5, "BitIndex": 4},
				"Flag_Upgraded": {"ByteIndex": 5, "BitIndex": 5}},
			}}
	}


// ..................
// ◦ In Game Menu's ◦
// ''''''''''''''''''
// ------------------RewardMenu---------------------
function is_RewardMenu_displayed(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_IsRewardMenuDisplayed =	memory_generateAddAddressPointerChain(
		"Struct_RewardMenuDisplayData", "BitFlag_IsRewardMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, accessor = bit0)
	return let_memAccessor_IsRewardMenuDisplayed == 1}

function on_RewardMenu_render(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_IsRewardMenuDisplayed =	memory_generateAddAddressPointerChain(
		"Struct_RewardMenuDisplayData", "BitFlag_IsRewardMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, accessor = bit0)
	return let_memAccessor_IsRewardMenuDisplayed > prev(let_memAccessor_IsRewardMenuDisplayed)}

function current_RewardMenu_Balance(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenuDisplayData", "32Bit_Balance", let_memAddr_RewardMenuDisplayData, accessor = dword)}

function current_RewardMenu_BountyCollected(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenuDisplayData", "32Bit_BountyCollected", let_memAddr_RewardMenuDisplayData, accessor = dword)}

// ------------------InGameMenu---------------------
INGAMEMENU_RetryMenu = "continue"
INGAMEMENU_GameOverScreen = "gameover"
INGAMEMENU_PauseMenu = "pause"
function current_IsInGameMenuDisplayed(enum_releaseRegion) =>
	bit0(
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion))
		+ memory_getDataStructOffset("Struct_InGameMenuController", "BitFlag_IsInGameMenuDisplayed")
	)

function prev_IsInGameMenuDisplayed(enum_releaseRegion) => 
	prev(current_IsInGameMenuDisplayed(enum_releaseRegion))

function is_InGameMenu_displayed(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return 
		current_IsInGameMenuDisplayed(enum_releaseRegion) == 1 
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)}

function on_InGameMenu_render(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return 
		current_IsInGameMenuDisplayed(enum_releaseRegion) == 1	// <---Block--- Checks when an InGameMenu is rendered
		&& prev_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)
		
		|| current_IsInGameMenuDisplayed(enum_releaseRegion) == 1 // <---Block--- Checks when switching between InGameMenu's (eg. RetryMenu goes into GameOverScreen)
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4) // <-- check current ascii string
		&& !ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4, transform = c => prev(c)) // <-- check delta ascii string
	}

function on_InGameMenu_close(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return
		current_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		&& prev_IsInGameMenuDisplayed(enum_releaseRegion) == 1
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4, transform = c => prev(c)) // <-- check delta ascii string
	}


function on_RetryMenu_retry(enum_releaseRegion) { // Restarting this way loads the last checkpoint
	// This function can also be substituted by on_PlayerProfileStat_StoryModeRetries_increment()
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return 
		current_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		&& prev_IsInGameMenuDisplayed(enum_releaseRegion) == 1
		&& ascii_string_equals(let_memAddr_InGameMenuID, INGAMEMENU_RetryMenu, 4)}

function on_PauseMenu_missionRestart(enum_releaseRegion) => // Restarting this way restarts the whole level
	on_PlayerProfileStat_TimeSpentPlaying_change(enum_releaseRegion) // <-- Restarting level via Pause Menu, updates this statistic
	&& is_InGameMenu_displayed(INGAMEMENU_PauseMenu, enum_releaseRegion)

// ...............................
// ◦ AMMO COUNTER HUD CONTROLLER ◦
// '''''''''''''''''''''''''''''''
function is_AmmoHUDControllerReserveAmmo(int_ammoCount, enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	let_pointerChain_EquippedWeaponReserveAmmo = memory_generateAddAddressPointerChain("Struct_GameController", "EquippedWeapon_ReserveAmmo", let_memAddr_GameController)
	return let_pointerChain_EquippedWeaponReserveAmmo == int_ammoCount}
	
function on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	let_pointerChain_EquippedWeaponReserveAmmo = memory_generateAddAddressPointerChain("Struct_GameController", "EquippedWeapon_ReserveAmmo", let_memAddr_GameController)
	return let_pointerChain_EquippedWeaponReserveAmmo < prev(let_pointerChain_EquippedWeaponReserveAmmo)}

function on_ShotsFired_increment(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChain_ShotsFired = memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_ShotsFired", let_memAddr_SinglePlayerData)
	return let_pointerChain_ShotsFired > prev(let_pointerChain_ShotsFired)}

function on_ShotsHit_increment(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChain_ShotsHit = memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_ShotsHit", let_memAddr_SinglePlayerData)
	return let_pointerChain_ShotsHit > prev(let_pointerChain_ShotsHit)}

function on_ShotsHit_change(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChain_ShotsHit = memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_ShotsHit", let_memAddr_SinglePlayerData)
	return let_pointerChain_ShotsHit != prev(let_pointerChain_ShotsHit)}

// ................
// ◦ GAME STATE ◦
// ''''''''''''''''
GAMESTATE_MainMenu = 1
GAMESTATE_SinglePlayer = 10
GAMESTATE_ShowdownMode = 20
const_GameState_data = {
	GAMESTATE_SinglePlayer: {"ID": 0xFA},
	GAMESTATE_ShowdownMode: {"ID": 0xC8},
	GAMESTATE_MainMenu: {"ID": 0xA}}
function get_GameState_ID(enum_gameState) =>
	const_GameState_data[enum_gameState]["ID"]

function current_GameState(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "GameState", enum_releaseRegion))

function prev_GameState(enum_releaseRegion) => 
	prev(current_GameState(enum_releaseRegion))

function is_GameState(enum_gameState, enum_releaseRegion) => 
	current_GameState(enum_releaseRegion) == get_GameState_ID(enum_gameState)

function on_GameState_changeTo(enum_gameState, enum_releaseRegion) => 
	current_GameState(enum_releaseRegion) == get_GameState_ID(enum_gameState) 
	&& prev_GameState(enum_releaseRegion) != get_GameState_ID(enum_gameState)

function is_AtMainMenu(enum_releaseRegion) =>
	is_GameState(GAMESTATE_MainMenu, enum_releaseRegion)



function is_Playing_SinglePlayerCampaign(enum_releaseRegion) =>
	is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion) &&
	byte(memory_getAddress(DATATYPE_8Bit, "NumberOfPlayers", enum_releaseRegion)) == 1

function is_Playing_ShowdownMode(enum_releaseRegion) =>
	is_GameState(GAMESTATE_ShowdownMode, enum_releaseRegion) &&
	byte(memory_getAddress(DATATYPE_8Bit, "NumberOfPlayers", enum_releaseRegion)) > 1


// ------------------------------------------------------
function is_InGame(enum_releaseRegion) => 
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsInGame", enum_releaseRegion)) == 1
function on_Game_quit(enum_releaseRegion) => // Quiting game via pause menu
	on_GameState_changeTo(GAMESTATE_MainMenu, enum_releaseRegion)

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
	}
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
	
	"c_Story": { // Category - Story Progression
		// "a_": { // CONCEPT a_template
		//	"id": 000000, "points": 0000000,
		//	"devInfo": "xxxxxxx"},
		},
	"c_StoryEnd": { // Category - Story Ending
		// "a_CompleteStoryNormal": { // CONCEPT a_CompleteStoryNormal
		// 	"id": 000000, "points": 0000000,
		// 	"devInfo": "Complete single player campaign on normal difficulty"},
		// "a_CompleteStoryHard": { // CONCEPT a_CompleteStoryHard
		//	"id": 000000, "points": 0000000,
		//	"devInfo": "Complete single player campaign on hard difficulty"},
		// "a_CompleteStoryVeryHard": { // CONCEPT a_CompleteStoryVeryHard
		//	"id": 000000, "points": 0000000,
		//	"devInfo": "Complete single player campaign on very hard difficulty"},
		// "a_CompleteStoryWood": { // CONCEPT a_CompleteStoryWood
		//	"id": 000000, "points": 0000000,
		//	"devInfo": "Complete single player campaign on Red Wood Revolver difficulty"},
		},
	"c_Showdown": { // Category - Showdown related achievements
		// "a_": { // CONCEPT a_template
		//	"id": 000000, "points": 0000000,
		//	"devInfo": "xxxxxxx"},
		},
	"c_Unlocks": { // Category - Unlocking journal pages, showdown characters and showdown maps/stages
		// "a_UnlockAllWeapons": { // VERIFIED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
		// 	"id": 439051, "points": 10, 
		// 	"devInfo": "Unlock all unique weapons in the Story Campaign"},
		"a_UpgradeAllWeapons": { // VERIFIED
			"id": 439234, "points": 10,
			"devInfo": "Unlock all upgraded weapons in the Story Campaign"},
		},
	"c_StoryChallenge": { // Category -  Story related challenge achievements
		"a_PerfectShootingTutorial": { // VERIFIED
			"id": 438301, "points": 1,
			"devInfo": "Level 'Bull's Eye' | Finish tutorial without wasting ammo (13 targets to hit)"},
		"a_Chapter1AcquireMoney": { // VERIFIED
			"id": 438677, "points": 5,
			"devInfo": "Level 'Bull's Eye' | Complete with a bounty collected of $1000 or greater at reward menu"},
		"a_Chapter5StayOnTrain": { // VERIFIED
			"id": 000000, "points": 3,
			"devInfo": "Level 'Railroaded' | Complete the mission without falling of the train"},
		},
	}
// -------------------------------------
achievements_typeByCategory = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" || "progression" || "win_condition" || "" (standard)
	//	- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//	 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//	 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": "xxxxxx",
	"c_Story": "progression",
	"c_StoryEnd": "win_condition",
	"c_Showdown": "",
	"c_Unlocks": "",
	"c_StoryChallenge": "missable"}

// ===================================
// • Achievements TRIGGER GENERATORS •
// ===================================
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_AltResetGroups_OnMissionReset_OR_OnMissionQuit(enum_releaseRegion) =>
	// ==== Alt Pause Lock Reset Group ==== Reset on game quit 
	never_toAlt( 
		is_ReleaseRegion(enum_releaseRegion) 
		&& on_Game_quit(enum_releaseRegion))
	// ==== Alt Pause Lock Reset Group ==== Reset on mission restart via pause menu
	|| never_toAlt(
		is_ReleaseRegion(enum_releaseRegion) 
		&& on_PlayerProfileStat_TimeSpentPlaying_change(enum_releaseRegion) // <-- Restarting level via Pause Menu, updates this statistic (on same frame the PauseMenu closes)
		&& on_InGameMenu_close(INGAMEMENU_PauseMenu, enum_releaseRegion))
	// ==== Alt Pause Lock Reset Group ==== Reset on mission restart via retry menu
	|| never_toAlt(
		is_ReleaseRegion(enum_releaseRegion) 
		&& on_PlayerProfileStat_StoryModeRetries_increment(enum_releaseRegion))
		// && on_RetryMenu_retry(enum_releaseRegion) // <-- This can be a substitute for above line, but contains more logic lines

// -------------------UnlockAllWeapons---------------------
function achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion) {	
	function createArrayOfBitIndicesToSub(array_bitIndicesToAdd) {
		let_array_bitIndicesToSub = [0,1,2,3,4,5,6,7]
		for let_bitIndex in array_bitIndicesToAdd 
			let_array_bitIndicesToSub[let_bitIndex] = iNULL
		return let_array_bitIndicesToSub
	}

	function createAccessorToBitset(int_byteIndex, accessorType, enum_releaseRegion) {
		let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
		let_memAccessor = memory_generateAddAddressPointerChain(
				"Struct_SinglePlayerData", "Bitset_PlayerProfileUnlocks", let_memAddr_SinglePlayerData, 
				int_offsetToMember = int_byteIndex - 1, accessor = accessorType)
		return let_memAccessor
	}

	let_array_memAccessorsToSum_AllFlags = []
	let_array_memAccessorsToSub_AllFlags = [] 
	for let_byteIndex in Bitset_PlayerProfileUnlocks_data["Flags_AllWeapons"]["AllFlags"] {
		let_array_bitIndices = Bitset_PlayerProfileUnlocks_data["Flags_AllWeapons"]["AllFlags"][let_byteIndex]
		let_bitCount = length(let_array_bitIndices)
		if (let_bitCount == 8) { // AddSource bitcount [byte]
			let_memAccessor_bitcount = createAccessorToBitset(let_byteIndex, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bitcount)
		} else if (8 > let_bitCount && let_bitCount > 4) { // AddSource bitcount [byte] + SubSource [each bit] (which aren't part of the bitset)
			let_memAccessor_bitcount = createAccessorToBitset(let_byteIndex, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bitcount)
			for let_bitIndexToSub in createArrayOfBitIndicesToSub(let_array_bitIndices) {
				if (let_bitIndexToSub != iNULL)	{
					let_memAccessor_bit = createAccessorToBitset(let_byteIndex, memUtil_bitIndexToMemAccessor[let_bitIndexToSub], enum_releaseRegion)
					array_push(let_array_memAccessorsToSub_AllFlags, let_memAccessor_bit)
				}
			}
		} else if (let_bitCount <= 4) { // AddSource [each bit]
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit = createAccessorToBitset(let_byteIndex, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bit)
			}
		} else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
	}

	let_array_memAccessorsToSub_NonUniqueFlags = [] // SubSource Flag_Normal & Flag_Normal (with bitwise AND)
	for let_weaponKey in Bitset_PlayerProfileUnlocks_data["Flags_AllWeapons"]["NonUniqueFlags"] {
		let_flagNormal = Bitset_PlayerProfileUnlocks_data["Flags_AllWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Normal"]
		let_memAccessor_flagNormal = createAccessorToBitset(let_flagNormal["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagNormal["BitIndex"]], enum_releaseRegion)
		
		let_flagUpgraded = Bitset_PlayerProfileUnlocks_data["Flags_AllWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Upgraded"]
		let_memAccessor_flagUpgraded = createAccessorToBitset(let_flagUpgraded["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagUpgraded["BitIndex"]], enum_releaseRegion)

		array_push(let_array_memAccessorsToSub_NonUniqueFlags, (let_memAccessor_flagNormal & let_memAccessor_flagUpgraded))
	}

	return
		sum_of(let_array_memAccessorsToSum_AllFlags, memAccessor => memAccessor) // Add all flags
		- sum_of(let_array_memAccessorsToSub_AllFlags, memAccessor => memAccessor) // Subtract flags which aren't part of bitset, because of usage of bitcount to lower amount of lines necessary
		- sum_of(let_array_memAccessorsToSub_NonUniqueFlags, memAccessor => memAccessor) // Subtract non-unique flags
	}

function achievements_generate_SumOf_FlagsAllWeaponsDelta_HardCoded() => // Hardcoded because RAtools can't generate: "achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion) < UNIQUE_WEAPON_COUNT"
	(prev(bitcount(dword(0x763070) + 0x0005C8))) +
	(prev(bitcount(dword(0x763070) + 0x0005C9))) +
	(prev(bitcount(dword(0x763070) + 0x0005CA))) + 
	(prev(bitcount(dword(0x763070) + 0x0005CB))) +
	(prev(bitcount(dword(0x763070) + 0x0005CC))) + 
	(prev(bit2(dword(0x763070) + 0x0005CD))) +
	(prev(bit3(dword(0x763070) + 0x0005CD))) + 
	(prev(bit4(dword(0x763070) + 0x0005CD))) - // bug <-- These SubSources bug out RAtools (infinite processing)
	// (prev(bit0(dword(0x763070) + 0x0005C8))) - 
	// (prev(bit1(dword(0x763070) + 0x0005C8))) // -
	// (prev(bit2(dword(0x763070) + 0x0005C8))) // - 
	(prev(bit7(dword(0x763070) + 0x0005CB)) & prev(bit0(dword(0x763070) + 0x0005CC))) - 
	(prev(bit4(dword(0x763070) + 0x0005C9)) & prev(bit5(dword(0x763070) + 0x0005C9))) - 
	(prev(bit4(dword(0x763070) + 0x0005CC)) & prev(bit5(dword(0x763070) + 0x0005CC))) - 
	(prev(bit5(dword(0x763070) + 0x0005CB)) & prev(bit6(dword(0x763070) + 0x0005CB))) -
	(prev(bit6(dword(0x763070) + 0x0005CA)) & prev(bit7(dword(0x763070) + 0x0005CA))) - 
	(prev(bit3(dword(0x763070) + 0x0005C8)) & prev(bit4(dword(0x763070) + 0x0005C8))) - 
	(prev(bit2(dword(0x763070) + 0x0005CA)) & prev(bit3(dword(0x763070) + 0x0005CA))) -
	(prev(bit2(dword(0x763070) + 0x0005CB)) & prev(bit3(dword(0x763070) + 0x0005CB))) - 
	(prev(bit4(dword(0x763070) + 0x0005CA)) & prev(bit5(dword(0x763070) + 0x0005CA))) - 
	(prev(bit5(dword(0x763070) + 0x0005C8)) & prev(bit6(dword(0x763070) + 0x0005C8))) -
	(prev(bit2(dword(0x763070) + 0x0005CC)) & prev(bit3(dword(0x763070) + 0x0005CC))) - 
	(prev(bit0(dword(0x763070) + 0x0005CB)) & prev(bit1(dword(0x763070) + 0x0005CB))) - 
	(prev(bit6(dword(0x763070) + 0x0005C9)) & prev(bit7(dword(0x763070) + 0x0005C9))) -
	(prev(bit0(dword(0x763070) + 0x0005CA)) & prev(bit1(dword(0x763070) + 0x0005CA))) - 
	(prev(bit7(dword(0x763070) + 0x0005C8)) & prev(bit0(dword(0x763070) + 0x0005C9))) - 
	(prev(bit1(dword(0x763070) + 0x0005C9)) & prev(bit2(dword(0x763070) + 0x0005C9)))

function achievements_generate_SumOf_FlagsAllWeapons_HardCoded() => // Hardcoded because RAtools can't generate: "achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion) < UNIQUE_WEAPON_COUNT"
	(bitcount(dword(0x763070) + 0x0005C8)) + 
	(bitcount(dword(0x763070) + 0x0005C9)) + 
	(bitcount(dword(0x763070) + 0x0005CA)) + 
	(bitcount(dword(0x763070) + 0x0005CB)) +
	(bitcount(dword(0x763070) + 0x0005CC)) + 
	(bit2(dword(0x763070) + 0x0005CD)) +
	(bit3(dword(0x763070) + 0x0005CD)) + 
	(bit4(dword(0x763070) + 0x0005CD)) - 
	(bit0(dword(0x763070) + 0x0005C8)) - 
	(bit1(dword(0x763070) + 0x0005C8)) -
	(bit2(dword(0x763070) + 0x0005C8)) - 
	(bit7(dword(0x763070) + 0x0005CB) & bit0(dword(0x763070) + 0x0005CC)) - 
	(bit4(dword(0x763070) + 0x0005C9) & bit5(dword(0x763070) + 0x0005C9)) - 
	(bit4(dword(0x763070) + 0x0005CC) & bit5(dword(0x763070) + 0x0005CC)) - 
	(bit5(dword(0x763070) + 0x0005CB) & bit6(dword(0x763070) + 0x0005CB)) -
	(bit6(dword(0x763070) + 0x0005CA) & bit7(dword(0x763070) + 0x0005CA)) - 
	(bit3(dword(0x763070) + 0x0005C8) & bit4(dword(0x763070) + 0x0005C8)) - 
	(bit2(dword(0x763070) + 0x0005CA) & bit3(dword(0x763070) + 0x0005CA)) -
	(bit2(dword(0x763070) + 0x0005CB) & bit3(dword(0x763070) + 0x0005CB)) - 
	(bit4(dword(0x763070) + 0x0005CA) & bit5(dword(0x763070) + 0x0005CA)) - 
	(bit5(dword(0x763070) + 0x0005C8) & bit6(dword(0x763070) + 0x0005C8)) -
	(bit2(dword(0x763070) + 0x0005CC) & bit3(dword(0x763070) + 0x0005CC)) - 
	(bit0(dword(0x763070) + 0x0005CB) & bit1(dword(0x763070) + 0x0005CB)) - 
	(bit6(dword(0x763070) + 0x0005C9) & bit7(dword(0x763070) + 0x0005C9)) -
	(bit0(dword(0x763070) + 0x0005CA) & bit1(dword(0x763070) + 0x0005CA)) - 
	(bit7(dword(0x763070) + 0x0005C8) & bit0(dword(0x763070) + 0x0005C9)) - 
	(bit1(dword(0x763070) + 0x0005C9) & bit2(dword(0x763070) + 0x0005C9))

// -------------------UnlockAllUpgradedWeapons---------------------
function achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion) {
	function createArrayOfBitIndicesToSub(array_bitIndicesToAdd) {
		let_array_bitIndicesToSub = [0,1,2,3,4,5,6,7]
		for let_bitIndex in array_bitIndicesToAdd 
			let_array_bitIndicesToSub[let_bitIndex] = iNULL
		return let_array_bitIndicesToSub
	}

	function createAccessorToBitset(int_byteIndex, accessorType, enum_releaseRegion) {
		let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
		let_memAccessor = memory_generateAddAddressPointerChain(
				"Struct_SinglePlayerData", "Bitset_PlayerProfileUnlocks", let_memAddr_SinglePlayerData, 
				int_offsetToMember = int_byteIndex - 1, accessor = accessorType)
		return let_memAccessor
	}

	let_array_memAccessorsToSum_AllFlags = []
	let_array_memAccessorsToSub_AllFlags = [] 
	for let_byteIndex in Bitset_PlayerProfileUnlocks_data["Flags_AllUpgradedWeapons"] {
		let_array_bitIndices = Bitset_PlayerProfileUnlocks_data["Flags_AllUpgradedWeapons"][let_byteIndex]
		let_bitCount = length(let_array_bitIndices)
		if (let_bitCount == 8) { // AddSource bitcount [byte]
			let_memAccessor_bitcount = createAccessorToBitset(let_byteIndex, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bitcount)
		} else if (8 > let_bitCount && let_bitCount > 4) { // AddSource bitcount [byte] + SubSource [each bit] (which aren't part of the bitset)
			let_memAccessor_bitcount = createAccessorToBitset(let_byteIndex, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bitcount)
			for let_bitIndexToSub in createArrayOfBitIndicesToSub(let_array_bitIndices) {
				if (let_bitIndexToSub != iNULL)	{
					let_memAccessor_bit = createAccessorToBitset(let_byteIndex, memUtil_bitIndexToMemAccessor[let_bitIndexToSub], enum_releaseRegion)
					array_push(let_array_memAccessorsToSub_AllFlags, let_memAccessor_bit)
				}
			}
		} else if (let_bitCount <= 4) { // AddSource [each bit]
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit = createAccessorToBitset(let_byteIndex, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum_AllFlags, let_memAccessor_bit)
			}
		} else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
	}

	return
		sum_of(let_array_memAccessorsToSum_AllFlags, memAccessor => memAccessor) // Add all flags
		- sum_of(let_array_memAccessorsToSub_AllFlags, memAccessor => memAccessor) // Subtract flags which aren't part of bitset, because of usage of bitcount to lower amount of lines necessary
	}

// =========================
// • Achievements TRIGGERS •
// =========================
achievements_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>  // WIP_template
	// 	// ==== Core (Alt) Group ====
	// 	is_ReleaseRegion(enum_releaseRegion) 
	// 	&& always_false()
	// 	),

	"a_Chapter5StayOnTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		// ==== Core (Alt) Group ====
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			|| !is_Area(AREA_Campaign_Railroaded, enum_releaseRegion))

		&& once(is_InGame(enum_releaseRegion)) // <-- Prevent RATrigger popup being displayed during the shop at the start of the mission + Once is necessary, because this bitflag turns off when loading the RewardMenu
		&& !is_InGameMenu_displayed(INGAMEMENU_RetryMenu, enum_releaseRegion)	// <---2Lines--- Prevent RATrigger popup being displayed during these menu's
		&& !is_InGameMenu_displayed(INGAMEMENU_GameOverScreen, enum_releaseRegion)

		&& unless(once( // <-- Pause Lock
			current_PlayerZCoordinate(enum_releaseRegion) < 0))

		&& trigger_when(on_RewardMenu_render(enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== Reset on game quit 
		|| never_toAlt( 
			is_ReleaseRegion(enum_releaseRegion) 
			&& on_Game_quit(enum_releaseRegion))
		// ==== Alt Pause Lock Reset Group ==== Reset on mission restart via pause menu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& on_PlayerProfileStat_TimeSpentPlaying_change(enum_releaseRegion) // <-- Restarting level via Pause Menu, updates this statistic (on same frame the PauseMenu closes)
			&& on_InGameMenu_close(INGAMEMENU_PauseMenu, enum_releaseRegion))
		// ==== Alt Pause Lock Reset Group ==== Reset on mission restart via retry menu
		|| never_toAlt( 
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_PlayerProfileStat_StoryModeRetries_increment(enum_releaseRegion)) // <---2Lines--- Extra logic necessary, on_PlayerProfileStat_StoryModeRetries_increment() hits before PlayerCharacter is respawned back on top of train, thus PauseLock would immediately reactivate when player had jumped off train
			&& current_PlayerZCoordinate(enum_releaseRegion) >= 0)),  
	"a_PerfectShootingTutorial": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion) 
		&& is_InGame(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion) 
		&& is_Area(AREA_Campaign_BrokenCreek, enum_releaseRegion) 

		&& unless( // <-- Pause Lock achievement when more than 13 bullets were used
			repeated(14, on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion)) 
			|| once(is_PlayerXCoordinate_notStationaryNearCoordinate(17.4, enum_releaseRegion))
			|| once(is_PlayerYCoordinate_notStationaryNearCoordinate(-10.5, enum_releaseRegion)))

		&& once(is_GameTrigger(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))
		&& trigger_when(on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_GoodCompletion, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== Reset when the shooting tutorial starts
		|| never_toAlt( 
			is_ReleaseRegion(enum_releaseRegion) 
			&& on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))),
	"a_Chapter1AcquireMoney": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion) // is_InGame() must not be used because we check data of the RewardMenu
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_Area(AREA_Campaign_BrokenCreek, enum_releaseRegion)

		&& current_RewardMenu_BountyCollected(enum_releaseRegion) >= 1000

		&& once(on_RewardMenu_render(enum_releaseRegion)) 
		&& repeated(197, is_RewardMenu_displayed(enum_releaseRegion)) // <-- Delay: so the achievement pops when the cash balance UI is displayed 
		
		// ==== Alt Reset Group ==== Reset hits correlated to RewardMenu being displayed
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& !is_RewardMenu_displayed(enum_releaseRegion))),
	"a_UnlockAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		// ==== Core (Alt) Group ====
		// Underlying 2 lines break RAtools - but are required for the achievement, thus this trigger is implementated via RAintegration UI
			// prev(achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion)) < UNIQUE_WEAPON_COUNT 
			// && prev(achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion)) > UNIQUE_WEAPON_COUNT - 4

		measured(achievements_generate_SumOf_FlagsAllWeapons(enum_releaseRegion) == UNIQUE_WEAPON_COUNT, 
			when = 
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				&& !is_AreaLoading_active(enum_releaseRegion))),
	"a_UpgradeAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		prev(achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion)) < UPGRADEABLE_WEAPON_COUNT
		&& prev(achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion)) > UPGRADEABLE_WEAPON_COUNT - 4
		&& measured(achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion) == UPGRADEABLE_WEAPON_COUNT,
			when = 
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				&& !is_AreaLoading_active(enum_releaseRegion)))
	}

// =====================
// • Achievements TEXT •
// =====================
achievements_titles = {
	// "a_Template": 						{"en": "xxxxxxxxx"},
	"a_Chapter5StayOnTrain":				{"en": "Railway Maverick"},
	"a_PerfectShootingTutorial": 			{"en": "Rookie Sharpshooter"},
	"a_Chapter1AcquireMoney": 				{"en": "Budding Bounty Hunter"},
	"a_UnlockAllWeapons":					{"en": "Total Armament"},
	"a_UpgradeAllWeapons":					{"en": "The Finest in the West"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_Chapter5StayOnTrain":				{"en": "Navigate Chapter 5 'Railroaded' without stumbling off the train even once"},
	"a_PerfectShootingTutorial": 			{"en": "Prove your shooting prowess in Chapter 1 'Bull's Eye' by finishing the shooting tutorial without wasting a single bullet and remaining stationary"},
	"a_Chapter1AcquireMoney": 				{"en": "Collect a bounty of $1000 or more by the end of Chapter 1 'Bull's Eye'"},
	"a_UnlockAllWeapons":					{"en": "Unlock the full weapon arsenal"},
	"a_UpgradeAllWeapons":					{"en": "Bring every weapon capable of enhancement to its maximum potential"},
	}

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

// TODO implement Rich Presence

// =====================
// • RichPresence TEXT •
// =====================
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},
	"rp_Default":										{"en": "xxxxxxxx"}}	// TODO implement rp_Default + rp_DefaultPlus
richPresence_LookupTablesText = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	
	// "rp_Template_LookupFallback": 					{"en": "xxxxxxxx"},	
	}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_parameterKey, string_lookupValue) {
	let_lookupTableTextKey = format("{0}_{1}", string_parameterKey, string_lookupValue)
	return richPresence_LookupTablesText[let_lookupTableTextKey][util_language]}
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	}
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
function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus")
	)}
function rp_Default() {
	rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {

	}} 

// ===========================
// • RichPresence PARAMETERS •
// ===========================
richPresence_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_LOOKUP = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_MACRO = 3		// rich_presence_macro(macro, expression)
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

	//	 "rpp_ValueTemplate": {
	//	 	"RPtype": richPresence_VALUE,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: () => always_false(), 
	//	 		RELEASE_REGION_EUR: () => always_false(),
	//	 		RELEASE_REGION_JPN: () => always_false()},
	//	 	"ValueFormat": "VALUE"},

	//	 "rpp_LookupTemplate": {
	//	 	"RPtype": richPresence_LOOKUP,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: () => always_false(), 
	//	 		RELEASE_REGION_EUR: () => always_false(),
	//	 		RELEASE_REGION_JPN: () => always_false()},
	//	 	"LookupFallback": richPresence_getLookupTableText("rpp_LookupTemplate", "LookupFallback")},

	//	 "rpp_MacroTemplate": {
	//	 	"RPtype": richPresence_MACRO,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: () => always_false(), 
	//	 		RELEASE_REGION_EUR: () => always_false(),
	//	 		RELEASE_REGION_JPN: () => always_false()},
	//	 	"MacroFormat": "Number"},
	
	

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

// TODO implement leaderboards

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
	}

// ===================================
// • Leaderboards TRIGGER GENERATORS •
// ===================================
//	- For leaderboard logic that's reoccuring across multiple triggers

// =========================
// • Leaderboards TRIGGERS •
// =========================
leaderboards_startTriggers = {	
	}
leaderboards_cancelTriggers = {	
	}
leaderboards_submitTriggers = {
	}
leaderboards_valueMeasures = {		
	}
// =====================
// • Leaderboards TEXT •
// =====================
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	}

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