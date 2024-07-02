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
			"Bitset_PlayerProfileUnlocks": 0xC,
			"ASCII_FurthestCompletedStoryChapter": 0x23C,
			"32Bit_StoryModeRetries": 0x28C,
			"32Bit_CurrentPlaythroughDifficulty": 0x292,
			"32BitFloat_TimeSpentPlaying": 0x388,			
			"Bitset_BountyHunterMissionsCompleted": 0x7B0,
			"Bitset_ActivatedChears": 0x800}
		},
	"Struct_RewardMenu_StartChpMenu_DisplayData": {
		"pointerChains": {
			"32Bit_Balance": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0xA04]},
			"32Bit_BountyCollected": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0x9E4]},
			"BitFlag_IsRewardMenuDisplayed": { 
				"addAddressChain": [0xAC, 0x38]},
			"BitFlag_IsStartChpMenuActive": { 
				"addAddressChain": [0x214]},
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
		"IsNotLoading": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fd3ec, RELEASE_REGION_JPN: sNULL},
		"IsPlayingBountyHunterMode": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a099c, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_8Bit: {
		"NumberOfPlayers": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73dd6c, RELEASE_REGION_JPN: 0x73f2ec},
		"GameState": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fbaf0, RELEASE_REGION_JPN: sNULL},
		"UIRenderStackLevel": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a10, RELEASE_REGION_JPN: sNULL}, // Unused
		"SelectedPlayerProfile": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x744898, RELEASE_REGION_JPN: sNULL},
		},	
	DATATYPE_ASCII: {
		"GameID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54c7cc, RELEASE_REGION_JPN: 0x54dd4c},
		"AreaID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a0620, RELEASE_REGION_JPN: sNULL},
		"EndingCreditsFlag": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x1f7ec20, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_32BitPointer: {
		"SinglePlayerData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x763070, RELEASE_REGION_JPN: sNULL},
		"Selected_PlayerProfileData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7448d8, RELEASE_REGION_JPN: sNULL},
		"GameController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a20, RELEASE_REGION_JPN: sNULL},
		"RewardMenu_StartChpMenu_DisplayData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54caf0, RELEASE_REGION_JPN: sNULL},
		"InGameMenuController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73d684, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_Struct: {
		"Array_PlayerProfileData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x740608, RELEASE_REGION_JPN: sNULL},
		"Bitset_ShowdownCharacterUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405e1, RELEASE_REGION_JPN: sNULL},
		"Bitset_ShowdownMapUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405df, RELEASE_REGION_JPN: sNULL},
		"Bitset_JournalPageUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405cd, RELEASE_REGION_JPN: sNULL},
		"Bitset_CheatUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405cc, RELEASE_REGION_JPN: sNULL},
	}}

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

function memUtil_bitwiseOR(memAccessor_bitFlagAccessor, memAccessor_B) => // A OR B => A + B - A AND B (workaround as rCheevos doesn't support bitwise-OR out-of-the-box)
	memAccessor_bitFlagAccessor + memAccessor_B - (memAccessor_bitFlagAccessor & memAccessor_B)

function memUtil_createArrayOfBitIndicesToSub(array_bitIndicesToAdd) { // This function should be used when counting flags via a bitcount, where not all bits should be counted (eg. bitcount(0xA) - bit0(0xA) - bit1(0xA))
		let_array_bitIndicesToSub = [0,1,2,3,4,5,6,7]
		for let_bitIndex in array_bitIndicesToAdd 
			let_array_bitIndicesToSub[let_bitIndex] = iNULL
		return let_array_bitIndicesToSub
	}

function memGenerate_SumOf_BitsetFlags(dict_FlagData, function_bitFlagMemAccessorGenerator, enum_releaseRegion) { // function_bitFlagMemAccessorGenerator should require parameters: (int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion)
	let_array_memAccessorsToSum = []
	let_array_memAccessorsToSub = [] 
	for let_byteIndex in dict_FlagData {
		let_array_bitIndices = dict_FlagData[let_byteIndex]
		let_bitCount = length(let_array_bitIndices)
		if (let_bitCount == 8) { // AddSource bitcount [byte]
			let_memAccessor_bitcount = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount)
		} else if (8 > let_bitCount && let_bitCount > 4) { // AddSource bitcount [byte] + SubSource [each bit] (which aren't part of the bitset)
			let_memAccessor_bitcount = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount)
			for let_bitIndexToSub in memUtil_createArrayOfBitIndicesToSub(let_array_bitIndices) {
				if (let_bitIndexToSub != iNULL)	{
					let_memAccessor_bit = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndexToSub], enum_releaseRegion)
					array_push(let_array_memAccessorsToSub, let_memAccessor_bit)
				}
			}
		} else if (let_bitCount <= 4) { // AddSource [each bit]
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum, let_memAccessor_bit)
			}
		} else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
	}
	
	return
		sum_of(let_array_memAccessorsToSum, memAccessor => memAccessor) // Add all flags
		- sum_of(let_array_memAccessorsToSub, memAccessor => memAccessor) // Subtract flags which aren't part of bitset, because of usage of bitcount to lower amount of lines necessary
	}

function memGenerate_SumOf_BitsetFlags_noSubSource(dict_FlagData, function_bitFlagMemAccessorGenerator, enum_releaseRegion) { // function_bitFlagMemAccessorGenerator should require parameters: (int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion)
	let_array_memAccessorsToSum = []
	for let_byteIndex in dict_FlagData {
		let_array_bitIndices = dict_FlagData[let_byteIndex]
		let_bitCount = length(let_array_bitIndices)
		if (let_bitCount == 8) { // AddSource bitcount [byte]
			let_memAccessor_bitcount = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount)
		} else if (let_bitCount < 8) { // AddSource [each bit]
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit = function_bitFlagMemAccessorGenerator(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum, let_memAccessor_bit)
			}
		} else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
	}
	
	return sum_of(let_array_memAccessorsToSum, memAccessor => memAccessor) 
	}

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
// Custom ASCII comparitors are necessary to use with pointers, built-in RAtools asci_string_equals() generates weird logic, when using pointers as the memAddrr
function ASCII_Equals(memAddr_ASCII, string_s, wrapper = c => c) {
	let_array_comparisons = []
	for let_stepBy4Index in range(0, length(string_s) - 1, step = 4) {
		let_substring = substring(string_s, let_stepBy4Index, 4)
		array_push(let_array_comparisons, ascii_string_equals(memAddr_ASCII + let_stepBy4Index, let_substring, transform = wrapper))
	}
	return all_of(let_array_comparisons, c => c)}

function ASCII_NotEquals(memAddr_ASCII, string_s, wrapper = c => c) {
	let_array_comparisons = []
	for let_stepBy4Index in range(0, length(string_s) - 1, step = 4) {
		let_substring = substring(string_s, let_stepBy4Index, 4)
		array_push(let_array_comparisons, ascii_string_equals(memAddr_ASCII + let_stepBy4Index, let_substring, transform = wrapper))
	}
	return none_of(let_array_comparisons, c => c)}

function is_ASCII(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s)

function was_ASCII(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prior(c))

function on_ASCII_changeTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s) && 
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))

// ...........
// ◦ AREA ID ◦
// '''''''''''
AREA_loading = "default"
AREA_Campaign_BrokenCreek = "lvl_perfnew"
AREA_Campaign_Railroaded = "lvl_traingood"

AREA_Campaign_FallFromGrace = "lvl_mansroof"

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
GAMETRIGGER_ShootingTutorial_Start = "Pre_TargetA" // Pre_TargetA_NoCine
GAMETRIGGER_ShootingTutorial_GoodCompletion = "GoodComp" // GoodComp_Phase4_NoCine2
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
	// return is_ASCII(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])
	return is_ASCII(let_pointerChainTo_GameTriggerID, enum_gameTrigger)
	
	}

function on_GameTrigger_changeTo(enum_gameTrigger, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "ASCIi_GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getPointerChainOffsetToMember("Struct_SinglePlayerData", "ASCIi_GameTriggerID")
	// return on_ASCII_changeTo(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])
	return on_ASCII_changeTo(let_pointerChainTo_GameTriggerID, enum_gameTrigger)
	
	}

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
// ◦ SHARED UNLOCKS ◦
// ''''''''''''''''''
STAGE_COUNT = 13
CHARACTER_COUNT = 48
JOURNALPAGE_COUNT = 137
// ----------------JournalPages--------------------
FlagData_Bitset_JournalPageUnlocks = { // 137 flags
	1: [2,3,4,5,6,7],
	2: [0,1,2,3,4,5,6,7],
	3: [0,1,3,4,5,6,7],
	4: [0,1,3,5,6,7],
	5: [0,1,2,3,4,6,7],
	6: [0,1,2,5,7],
	7: [0,1,2,3,4,5,6,7],
	8: [0,1,2,3,4,5,6,7],
	9: [0,1,2,3,4,5,6,7],
	10: [0,1,2,3,4,5,6,7],
	11: [0,1,2,3,4,5,6,7],
	12: [0,1,2,3,4,5,6,7],
	13: [1,2,3,4,5,6,7],
	14: [0,1,2,4,5,6,7],
	15: [0,1,3,4,5,6,7],
	16: [0,1,2,3,4,5,6,7],
	17: [0,1,2,3,4,5,6,7],
	18: [0,1,2,3,4,5,6,7],
	19: [0,1,2,3,4]}
// ----------------ShowdownCharacters--------------------
FlagData_Bitset_ShowdownCharactersUnlocks = { // 48 flags
	1: [5,6,7],
	2: [0,1,2,3,4,5,6,7],
	3: [0,1,2,3,4,5,6,7],
	4: [0,1,2,3,4,5,6,7],
	5: [0,1,2,3,4,5,6,7],
	6: [0,1,2,3,4,5,6,7],
	7: [0,1,2,3,4]}
// ----------------ShowdownStages--------------------
FlagData_Bitset_ShowdownMapUnlocks = { // 13 flags
	1: [5,6,7],
	2: [0,1,2,3,4,5,7],
	3: [0,1,3]}

// ----------------Cheats--------------------
FlagData_Bitset_CheatUnlocks = { // 10 flags
	"Flags_UnlockableCheats": { // 7 flags
		1: [1,2,3,6,7],
		2: [0,1]},
	"Flags_DebugCheats": { // 3 flags
		1: [0,4,5]}
	}

// ..................
// ◦ PLAYER PROFILE ◦
// ''''''''''''''''''
function is_SelectedPlayerProfile(int_playerProfileNumber, enum_releaseRegion) {
	let_memAddr_SelectedPlayerProfile = memory_getAddress(DATATYPE_8Bit, "SelectedPlayerProfile", enum_releaseRegion)
	return byte(let_memAddr_SelectedPlayerProfile) == int_playerProfileNumber} 

// ----------------PlayerProfile STATISTICS--------------------
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

// ----------------PlayerProfile UNLOCKS--------------------
WEAPON_COUNT = 24
UPGRADEABLE_WEAPON_COUNT = 16
HP_UPGRADE_COUNT = 7
DEADEYE_UPGRADE_COUNT = 5 
FlagData_Bitset_PlayerProfileUnlocks = {
	// FlagData Dictionary Definition:
		// Dictionary key --> refers to byte index in bitset
		// Dictionary value --> refers to bit indices
	"Flags_AllUpgradedWeapons": { // 16 flags
		1: [4,6],
		2: [0,2,5,7],
		3: [1,3,5,7],
		4: [1,3,6],
		5: [0,3,5]},
	"Flags_AllUniqueWeapons": { // 24 unique flags
		"AllFlags": { // 40 flags --> AddSource each Flag (or bitcount with subsource non-weapon flags in byte)
			1: [3,4,5,6,7],
			2: [0,1,2,3,4,5,6,7],
			3: [0,1,2,3,4,5,6,7],
			4: [0,1,2,3,4,5,6,7],
			5: [0,1,2,3,4,5,6,7],
			6: [2,3,4],
			},
		"NonUniqueFlags": { // 16 weapons have double flags --> SubSource Flag_Normal [bitwise_AND] Flag_Upgraded
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
			}},
	"Flags_AllHealthUpgrades": { // 7 flags
		7: [7],
		8: [0,1,2,5,6,7]},
	"Flags_AllDeadEyeUpgrades": { // 5 flags
		8: [3,4],
		9: [0,1,2]},
	"Flags_AllUniqueCharacters": { // 40 Unique Flags (+ 8 characters unlocked by default)
		"AllFlags": { // 46 Flags
			10: [0,1,2,6,7],
			11: [1,2,3,6],
			12: [3,5,6],
			13: [1,3],
			14: [1,2],
			15: [1,3,5,6],
			16: [2,3,4,6,7],
			17: [0,2,4,6,7],
			18: [2],
			19: [0,3,4],
			20: [3,4,7],
			21: [0,1,4,6],
			23: [2,3,5,6,7]},
		"NonUniqueFlags": { // 6 characters have double flags --> SubSource Flag_A [bitwise_AND] Flag_B
			"MannyQuinn": {
				"Flag_A": {"ByteIndex": 12, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 19, "BitIndex": 3}},
			"SissyFess": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 3},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 7}},
			"BloodyTom": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 2},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 6}},
			"SmileyFawler": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 1},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 5}},
			"Sam": {
				"Flag_A": {"ByteIndex": 10, "BitIndex": 7},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 3}},
			"Grizzly": {
				"Flag_A": {"ByteIndex": 10, "BitIndex": 6},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 2}}}},
	"Flags_AllStages": { // 11 flags ( + 2 stages unlocked by default)
		12: [2,7],
		13: [0,7],
		14: [3],
		15: [0,2],
		16: [5],
		18: [4],
		20: [2],
		21: [2]},
	"Flags_AllUniquePages": { // 120 unique flags (+ 9 pages unlocked by default)
		"AllFlags": { // 144 flags
			// ==== Weapons ==== (40)
			1: [3,4,5,6,7],
			2: [0,1,2,3,4,5,6,7],
			3: [0,1,2,3,4,5,6,7],
			4: [0,1,2,3,4,5,6,7],
			5: [0,1,2,3,4,5,6,7],
			6: [2,3,4],
			// ==== Pages ==== (104)
			9: [3,5,6,7],
			10: [0,1,2,3,4,5,6,7],
			11: [0,1,2,3,4,5,6,7],
			12: [0,1,3,4,5,6,7],
			13: [1,2,3,4,5,6],
			14: [0,1,2,4,5,6,7],
			15: [0,1,2,3,4,5,6,7],
			16: [0,1,2,3,4,5,6,7],
			17: [0,1,2,3,4,5,6,7],
			18: [0,1,2,3,4,5,6,7],
			19: [0,1,2,3,4,5,6,7],
			20: [0,1,2,3,4,5,6,7],
			21: [0,1,4,5,6,7],
			22: [0,1],
			23: [1,2,3,4,5,6,7],
			24: [6]},
		"NonUniqueFlags": { // 24 non-unique flags
			// ==== Pages ==== (2)
			"RedWolfTribe": {
				"Flag_A": {"ByteIndex": 21, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 24, "BitIndex": 6}},
			"OscarNavarro_PaulSwigBennet": {
				"Flag_A": {"ByteIndex": 10, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 1}},
			// ==== Weapons ==== (16)
			"OldPistol": {
				"Flag_A": {"ByteIndex": 1, "BitIndex": 3},
				"Flag_B": {"ByteIndex": 1, "BitIndex": 4}},
			"Revolver": {
				"Flag_A": {"ByteIndex": 1, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 1, "BitIndex": 6}},
			"TwinRevolver": {
				"Flag_A": {"ByteIndex": 1, "BitIndex": 7},
				"Flag_B": {"ByteIndex": 2, "BitIndex": 0}},
			"Widowmaker": {
				"Flag_A": {"ByteIndex": 2, "BitIndex": 1},
				"Flag_B": {"ByteIndex": 2, "BitIndex": 2}},
			"BreechLoader": {
				"Flag_A": {"ByteIndex": 2, "BitIndex": 4},
				"Flag_B": {"ByteIndex": 2, "BitIndex": 5}},
			"TheLion": {
				"Flag_A": {"ByteIndex": 2, "BitIndex": 6},
				"Flag_B": {"ByteIndex": 2, "BitIndex": 7}},
			"TwelveGauge": {
				"Flag_A": {"ByteIndex": 3, "BitIndex": 0},
				"Flag_B": {"ByteIndex": 3, "BitIndex": 1}},
			"OwlRifle": {
				"Flag_A": {"ByteIndex": 3, "BitIndex": 2},
				"Flag_B": {"ByteIndex": 3, "BitIndex": 3}},
			"RepeaterRifle": {
				"Flag_A": {"ByteIndex": 3, "BitIndex": 4},
				"Flag_B": {"ByteIndex": 3, "BitIndex": 5}},
			"HighCaliber": {
				"Flag_A": {"ByteIndex": 3, "BitIndex": 6},
				"Flag_B": {"ByteIndex": 3, "BitIndex": 7}},
			"SixShooter": {
				"Flag_A": {"ByteIndex": 4, "BitIndex": 0},
				"Flag_B": {"ByteIndex": 4, "BitIndex": 1}},
			"Pacificador": {
				"Flag_A": {"ByteIndex": 4, "BitIndex": 2},
				"Flag_B": {"ByteIndex": 4, "BitIndex": 3}},
			"HalconRifle": {
				"Flag_A": {"ByteIndex": 4, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 4, "BitIndex": 6}},
			"BayonetRifle": {
				"Flag_A": {"ByteIndex": 4, "BitIndex": 7},
				"Flag_B": {"ByteIndex": 5, "BitIndex": 0}},
			"SawnOff": {
				"Flag_A": {"ByteIndex": 5, "BitIndex": 2},
				"Flag_B": {"ByteIndex": 5, "BitIndex": 3}},
			"Escopeta": {
				"Flag_A": {"ByteIndex": 5, "BitIndex": 4},
				"Flag_B": {"ByteIndex": 5, "BitIndex": 5}},
			// ==== Characters ==== (6)
			"MannyQuinn": {
				"Flag_A": {"ByteIndex": 12, "BitIndex": 5},
				"Flag_B": {"ByteIndex": 19, "BitIndex": 3}},
			"SissyFess": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 3},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 7}},
			"BloodyTom": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 2},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 6}},
			"SmileyFawler": {
				"Flag_A": {"ByteIndex": 11, "BitIndex": 1},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 5}},
			"Sam": {
				"Flag_A": {"ByteIndex": 10, "BitIndex": 7},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 3}},
			"Grizzly": {
				"Flag_A": {"ByteIndex": 10, "BitIndex": 6},
				"Flag_B": {"ByteIndex": 23, "BitIndex": 2}}}},
	}

function bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_Bitset_SelectedPlayerProfileUnlocks =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_SelectedPlayerProfileUnlocks + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toDynamicBitset_PlayerProfileUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_memAccessor = memory_generateAddAddressPointerChain(
			"Struct_SinglePlayerData", "Bitset_PlayerProfileUnlocks", let_memAddr_SinglePlayerData, 
			int_offsetToMember = int_offsetToByte, accessor = memAccessor_bitFlagAccessor)
	return let_memAccessor}

// ----------------UnusedCodeBelow--------------------
function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile1Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 0
	let_memAddr_Bitset_BountyHunterMissionsCompleted =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_BountyHunterMissionsCompleted")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_BountyHunterMissionsCompleted + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile2Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 1
	let_memAddr_Bitset_PlayerProfileUnlocks =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_PlayerProfileUnlocks + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile3Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 2
	let_memAddr_Bitset_PlayerProfileUnlocks =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_PlayerProfileUnlocks + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile4Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 3
	let_memAddr_Bitset_PlayerProfileUnlocks =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_PlayerProfileUnlocks + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile5Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 4
	let_memAddr_Bitset_PlayerProfileUnlocks =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_PlayerProfileUnlocks + int_offsetToByte)}

function bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile6Unlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_playerProfileNumber = 5
	let_memAddr_Bitset_PlayerProfileUnlocks =
		memory_getAddress(DATATYPE_Struct, "Array_PlayerProfileData", enum_releaseRegion) 
		+ memory_getDataStructSizeInBytes("Struct_PlayerProfileData") * let_playerProfileNumber
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_PlayerProfileUnlocks")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_PlayerProfileUnlocks + int_offsetToByte)}

function lookup_bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfileUnlocks(int_playerProfileNumber) {
	if (int_playerProfileNumber == 0) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile1Unlocks
	else if (int_playerProfileNumber == 1) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile2Unlocks
	else if (int_playerProfileNumber == 2) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile3Unlocks
	else if (int_playerProfileNumber == 3) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile4Unlocks
	else if (int_playerProfileNumber == 4) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile5Unlocks
	else if (int_playerProfileNumber == 5) 
		return bitFlagMemAccessorGenerator_toStaticBitset_PlayerProfile6Unlocks
	else
		util_throwError(format("Player profile number ({0}) is out of range [0-5]", int_playerProfileNumber))
	}
// ----------------UnusedCodeAbove--------------------

// ----------------PlayerProfile BOUNTY HUNTER MODE--------------------
BOUNTY_HUNTER_MISSON_COUNT = 20
FlagData_Bitset_BountyHunterMissionsCompleted = {
	1: [0,1,2,4,6,7],
	2: [1,3,6,7],
	3: [0,1,2,4,5,7],
	4: [0,4,5,7]}

function bitFlagMemAccessorGenerator_toStaticBitset_BountyHunterMissionsCompleted(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_Bitset_BountyHunterMissionsCompleted =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_BountyHunterMissionsCompleted")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_BountyHunterMissionsCompleted + int_offsetToByte)}

// -------------------------PlayerProfile CAMPAIGN SETTINGS-----------------------------
DIFFICULTY_Normal = 0x0
DIFFICULTY_Hard = 0x1
DIFFICULTY_VeryHard = 0x2
DIFFICULTY_RedWoodRevolver = 0x3

function current_StoryCampaignDifficulty(enum_releaseRegion) {
	let_memAddrPointerTo_SelectedPlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_CampaignSetting = memory_getDataStructOffset("Struct_PlayerProfileData", "32Bit_CurrentPlaythroughDifficulty") 
	return byte(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_CampaignSetting)}

function is_StoryCampaignDifficulty(enum_difficulty, enum_releaseRegion) =>
	current_StoryCampaignDifficulty(enum_releaseRegion) == enum_difficulty

function is_FurthestCompletedStoryChapter(enum_areaId, enum_releaseRegion) {
	letConst_offset = 1 // <-- because the first ASCII letter of this Area_ID may be zeroed out for this value (eg. "lvl_mansroof" => " vl_mansroof")
	let_memAddrPointerTo_SelectedPlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_CampaignSetting = memory_getDataStructOffset("Struct_PlayerProfileData", "ASCII_FurthestCompletedStoryChapter") + letConst_offset  
	let_areaId_fixed = substring(enum_areaId, letConst_offset)
	return is_ASCII(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_CampaignSetting, let_areaId_fixed)}

// ..................
// ◦ In Game Menu's ◦
// ''''''''''''''''''
// ------------------RewardMenu---------------------
function is_RewardMenu_displayed(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_IsRewardMenuDisplayed =	memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsRewardMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, accessor = bit0)
	return let_memAccessor_IsRewardMenuDisplayed == 1}

function on_RewardMenu_render(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_IsRewardMenuDisplayed =	memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsRewardMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, accessor = bit0)
	return let_memAccessor_IsRewardMenuDisplayed > prev(let_memAccessor_IsRewardMenuDisplayed)}

function current_RewardMenu_Balance(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32Bit_Balance", let_memAddr_RewardMenuDisplayData, accessor = dword)}

function current_RewardMenu_BountyCollected(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32Bit_BountyCollected", let_memAddr_RewardMenuDisplayData, accessor = dword)}

// ------------------StartChpMenu---------------------
function is_StartChpMenu_active(enum_releaseRegion) {
	let_memAddr_StartChpMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_IsStartChpMenuActive =	memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsStartChpMenuActive", 
		let_memAddr_StartChpMenuDisplayData, accessor = bit0)
	return let_memAccessor_IsStartChpMenuActive == 1}

// ------------------InGameMenu---------------------
INGAMEMENU_RetryMenu = "continue"
INGAMEMENU_GameOverScreen = "gameover"
INGAMEMENU_PauseMenu = "pause"
INGAMEMENU_CheatsMenu = "cheats"
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

// ..........
// ◦ CHEATS ◦
// ''''''''''
FlagData_Bitset_ActivatedCheats = {
	"Flags_UnlockableCheats": {
		1: [6,7],
		2: [2,4,5,6,7]},
	"Flags_DebugCheats": {
		2: [0,1]}
	}

function bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedChears =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedChears")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_ActivatedChears + int_offsetToByte)}

function is_AnyCheat_active_withAccumulator(enum_releaseRegion) {
	let_sumOf_AllCheatFlags = 
		memGenerate_SumOf_BitsetFlags(
			FlagData_Bitset_ActivatedCheats["Flags_UnlockableCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
		+ memGenerate_SumOf_BitsetFlags(
			FlagData_Bitset_ActivatedCheats["Flags_DebugCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion) // <--line-- checks if cheats are active outside the cheatsMenu as switching them on/off still requires a confirmation before leaving this subMenu
		&& let_sumOf_AllCheatFlags > 0
	}

function is_AnyCheat_active_withOR(enum_releaseRegion) { // TODO find solution for this problem <-- RATools can't generate it
	let_sumOf_AllCheatFlags = 
		memGenerate_SumOf_BitsetFlags(
			FlagData_Bitset_ActivatedCheats["Flags_UnlockableCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
		+ memGenerate_SumOf_BitsetFlags(
			FlagData_Bitset_ActivatedCheats["Flags_DebugCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion) // <--line-- checks if cheats are active outside the cheatsMenu as switching them on/off still requires a confirmation before leaving this subMenu
		&& let_sumOf_AllCheatFlags > 0
	}

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

function is_Playing_BountyHunterMode(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsPlayingBountyHunterMode", enum_releaseRegion)) == 1
	&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)

function is_Loading(enum_releaseRegion) => 
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsNotLoading", enum_releaseRegion)) == 0

// ------------------------------------------------------
CREDITS_AUDIO_FILE_NAME = "ENDCREDITS_PS2.stm"
function on_EndingCreditsVideo_start(enum_releaseRegion) {
	let_memAddr_EndingCreditsFlag = memory_getAddress(DATATYPE_ASCII, "EndingCreditsFlag", enum_releaseRegion)
	return on_ASCII_changeTo(let_memAddr_EndingCreditsFlag, CREDITS_AUDIO_FILE_NAME)} 

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

// TODO Cheat Protection againt RStar for c_Unlocks achievements
// TODO Cheat Protection in challege achievements

// ==========================
// • Achievements CORE DATA •
// ==========================
// - Divided by category => when in debug mode, category tags are added to achievement titles
achievements_TYPE_Progression = "progression"
achievements_TYPE_WinCondition = "win_condition"
achievements_TYPE_Missable = "missable"
achievements_TYPE_Standard = ""

achievement_POINTS_Minor = 1 		// Finding a hidden item, do some arbitrary/easter egg task
achievement_POINTS_Basic = 2 		// Defeating a few enemies
achievement_POINTS_Easy = 3 		// Completing an easy quest or level
achievement_POINTS_Intermediate = 4 // Completing a harder quest or level
achievement_POINTS_Advanced = 5 	// Collecting rare items
achievement_POINTS_Challenging = 10 // Defeating a major boss
achievement_POINTS_Hard = 25 		// Completing the game 
achievement_POINTS_VeryHard = 50 	// Achieving 100% completion
achievement_POINTS_Impossible = 100 // Completing the game without taking a hit (extreme challenge achievements, typical for bonus sets) 
// -----------------------------------------------------------
achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
		// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
		// ------------------------------------------------
	
	// DEV_NOTE: Achievement property 'type'
		//	- Possible type keys: "missable" || "progression" || "win_condition" || "" (standard)
		//	- Missable is when you would have to play a significant portion of game again to obtain the achievement.
		//	 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
		//	 	But the person making the achievement for that quest didn't tell you that you could miss it.
		//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
		// ------------------------------------------------------

	// "a_Template": { // CONCEPT a_template
	//	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_xxxxxxx,
	//	"devInfo": "xxxxxxx"},
	
	"c_Story": { // Category - Story Progression
		// "a_ReachBrimStone": { // CONCEPT a_ReachBrimStone
		//	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Progression,
		//	"devInfo": "Reach Brimstone for the 1st time"},
		},
	"c_StoryEnd": { // Category - Story Ending // TODO implement unlocking lower diff achievements as well for players "replaying"
		"a_CompleteStoryNormal": { // VERIFIED
			"id": 443703, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete single player campaign on normal difficulty"},
		"a_CompleteStoryHard": { // VERIFIED
			"id": 443870, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete single player campaign on hard difficulty"},
		"a_CompleteStoryVeryHard": { // VERIFIED
			"id": 443871, "points": achievement_POINTS_Hard, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete single player campaign on very hard difficulty"},
		"a_CompleteStoryWood": { // VERIFIED
			"id": 443872, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete single player campaign on Red Wood Revolver difficulty"},
		// "a_CompleteStoryHardcoreCheat": { // CONCEPT a_CompleteStoryHardcoreCheat
		//	"id": 0000000, "points": achievement_POINTS_Hard, "type": achievements_TYPE_WinCondition,
		//	"devInfo": "Complete single player campaign on very hard difficulty with cheat 'Bite The Bullet' activated"},
		},
	"c_Showdown": { // Category - Showdown related achievements
		// "a_WinBladeSlade": { // CONCEPT a_WinBladeSlade
		//	"id": 000000, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
		//	"devInfo": "As The 'Blade' Slade win bouny hunter match on stage 'xxxx', using only knives"},
		// "a_WinSundownFortDiego": { // CONCEPT a_WinSundownFortDiego
		//	"id": 000000, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 4 player Free-for-all Sundown match on stage 'Fort Diego'"},
		// "a_WinSundown1vsTeam": { // CONCEPT a_WinSundown1vsTeam
		//	"id": 000000, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 1 vs 3 player CPU team Sundown match on stage 'xxxxxx'"},
		// "a_WinHighNoonxxxx": { // CONCEPT a_WinHighNoon
		//	"id": 000000, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 4 player Free-for-all High Noon match on stage 'xxxxx'"},
		// "a_WinBountyHunterSunsetCanyon": { // CONCEPT a_WinBountyHunterSunsetCanyon
		//	"id": 000000, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 4 player Free-for-all Bounty Hunter match on stage 'Sunset Canyon'"},
		},
	"c_Unlocks": { // Category - Unlocking items
		"a_UnlockAllStages": { // VERIFIED
			"id": 444065, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Unlock all 13 Showdown stages"},
		"a_UnlockAllCharacters": { // VERIFIED
			"id": 444067, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
			"devInfo": "Unlock all 48 Showdown characters"},
		"a_CompleteHalfJournal": { // VERIFIED
			"id": 444490, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete 50% of the journal"},
		"a_CompleteFullJournal": { // VERIFIED
			"id": 444489, "points": achievement_POINTS_Hard, "type": achievements_TYPE_Standard,
			"devInfo": "Complete 100% of the journal"},
		// "a_MaxHealth": { // VERIFIED // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// 	"id": 444063, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_missable,
			// 	"devInfo": "Unlock all 7 health upgrades for Red"},
		// "a_MaxDeadEye": { // VERIFIED // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// 	"id": 444062, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			// 	"devInfo": "Unlock all 5 Dead Eye upgrades for Red"},
		// "a_UnlockAllWeapons": { // VERIFIED // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// "id": 439051, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			// "devInfo": "Unlock all unique weapons in the Story Campaign"},
		// "a_UpgradeAllWeapons": { // VERIFIED // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// 	"id": 439234, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			// 	"devInfo": "Unlock all 16 upgradable weapons in the Story Campaign"},
		},
	"c_StoryChallenge": { // Category -  Story related challenge achievements
		// "a_BountyCompletionHalf": { // QA // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// 	"id": 444681, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// 	"devInfo": "Complete half the Bounty Hunter Mode Missions"},
		// "a_BountyCompletionAll": { // QA  // DISABLED --> Implementation via RAIntegration UI (because the required logic can't be generated by RAtools, RAtools gets into infinite processing, thus this is commented)
			// 	"id": 444682, "points": achievement_POINTS_Hard, "type": achievements_TYPE_Standard,
			// 	"devInfo": "Complete all the Bounty Hunter Mode Missions"},
		// "a_Chapter13LoseNoCannons": { // CONCEPT a_Chapter13LoseNoCannons
		//	"id": 000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
		//	"devInfo": "Lose no allied cannons"},
		// "a_Chapter10RideBison": { // CONCEPT a_Chapter10RideBison
		//	"id": 000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
		//	"devInfo": "Ride a bison and kill enemies"},
		// "a_Chapter15FindWeaponFaith": { // CONCEPT a_Chapter15FindWeaponFaith
		//	"id": 000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
		//	"devInfo": "Faith is located inside a box up in a side corridor"},
		// "a_Chapter8SaveCurlyShaw": { // CONCEPT a_Chapter8SaveCurlyShaw
		//	"id": 000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
		//	"devInfo": "Level 'Rogue Valley' | Save Curly Shaw from the bandits"},
		"a_PerfectShootingTutorial": { // VERIFIED
			"id": 438301, "points": achievement_POINTS_Minor, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Bull's Eye' | Finish tutorial without wasting ammo (13 targets to hit)"},
		"a_Chapter1AcquireMoney": { // VERIFIED
			"id": 438677, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Bull's Eye' | Complete with a bounty collected of $1000 or greater at reward menu"},
		"a_Chapter5StayOnTrain": { // VERIFIED
			"id": 439585, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Railroaded' | Complete the mission without falling of the train"},
		},
	}

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

// -------------------UnlockWeapons---------------------
function achievements_generate_SumOf_FlagsAllUniqueWeapons(enum_releaseRegion) {
	function generate_SumOf_NonUniqueWeaponFlags(enum_releaseRegion) {
		let_array_memAccessorsToSub_NonUniqueFlags = [] // SubSource Flag_Normal & Flag_Normal (with bitwise AND)
		for let_weaponKey in FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"] {
			let_flagNormal = FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Normal"]			
			let_flagUpgraded = FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Upgraded"]
			
			let_memAccessor_flagNormal = bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks(
				let_flagNormal["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagNormal["BitIndex"]], 
				enum_releaseRegion)			
			let_memAccessor_flagUpgraded = bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks(
				let_flagUpgraded["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagUpgraded["BitIndex"]], 
				enum_releaseRegion)

			array_push(let_array_memAccessorsToSub_NonUniqueFlags, (let_memAccessor_flagNormal & let_memAccessor_flagUpgraded))
		}
		return sum_of(let_array_memAccessorsToSub_NonUniqueFlags, memAccessor => memAccessor)
	}	

	let_sumOf_AllWeaponFlags = memGenerate_SumOf_BitsetFlags(
		FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["AllFlags"],
		bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks, 
		enum_releaseRegion)
	let_sumOf_NonUniqueWeaponFlags = generate_SumOf_NonUniqueWeaponFlags(enum_releaseRegion)

	return 
		let_sumOf_AllWeaponFlags 
		- let_sumOf_NonUniqueWeaponFlags // Subtract non-unique flags
	}

function achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUpgradedWeapons"], bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks, enum_releaseRegion)

// -------------------UnlocksOther---------------------
function achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllHealthUpgrades"], bitFlagMemAccessorGenerator_toDynamicBitset_PlayerProfileUnlocks, enum_releaseRegion)

function achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllDeadEyeUpgrades"], bitFlagMemAccessorGenerator_toDynamicBitset_PlayerProfileUnlocks, enum_releaseRegion)

// ------------------ShowdownStages----------------------
function memAccessorGeneratorToBitset_ShowdownMapUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_ShowdownMapUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllStages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags(
		FlagData_Bitset_ShowdownMapUnlocks, 
		memAccessorGeneratorToBitset_ShowdownMapUnlocks, 
		enum_releaseRegion)
// ------------------ShowdownCharacters----------------------
function memAccessorGeneratorToBitset_ShowdownCharactersUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_ShowdownCharacterUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags(
		FlagData_Bitset_ShowdownCharactersUnlocks, 
		memAccessorGeneratorToBitset_ShowdownCharactersUnlocks, 
		enum_releaseRegion)
// ------------------JournalPages----------------------
function memAccessorGeneratorToBitset_JournalPageUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_JournalPageUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags(
		FlagData_Bitset_JournalPageUnlocks, 
		memAccessorGeneratorToBitset_JournalPageUnlocks, 
		enum_releaseRegion)

// ------------------BountyHunterMissions----------------------
function achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags(FlagData_Bitset_BountyHunterMissionsCompleted, bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks, enum_releaseRegion)


// =========================
// • Achievements TRIGGERS •
// =========================
achievements_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>  // WIP_template
	// 	// ==== Core (Alt) Group ====
	// 	is_ReleaseRegion(enum_releaseRegion) 
	// 	&& always_false()
	// 	),

	"a_CompleteStoryNormal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Normal // <---2Lines--- unlock this achievement on any difficulty, without using orNext or altGroups
		&& current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Hard // <---2Lines--- unlock this achievement on any hard or veryHard, without using orNext or altGroups
		&& current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryVeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion)
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion)
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
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
			&& once(on_PlayerProfileStat_StoryModeRetries_increment(enum_releaseRegion)) // <---2Lines--- Difference in logic compared to achievements_generate_AltResetGroups_OnMissionReset_OR_OnMissionQuit(), once() is necessary because on_PlayerProfileStat_StoryModeRetries_increment() hits before PlayerCharacter is respawned back on top of train, in that case PauseLock would immediately reactivate when player had jumped off train
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
		&& !is_AnyCheat_active(enum_releaseRegion)

		&& current_RewardMenu_BountyCollected(enum_releaseRegion) >= 1000

		&& once(on_RewardMenu_render(enum_releaseRegion)) 
		&& repeated(197, is_RewardMenu_displayed(enum_releaseRegion)) // <-- Delay: so the achievement pops when the cash balance UI is displayed 
		
		// ==== Alt Reset Group ==== Reset hits correlated to RewardMenu being displayed
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& !is_RewardMenu_displayed(enum_releaseRegion))),
	"a_UnlockAllStages": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllStages = achievements_generate_SumOf_FlagsAllStages(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllStages) < STAGE_COUNT
			&& prev(let_sumOf_FlagsAllStages) > STAGE_COUNT/2
			&& measured(let_sumOf_FlagsAllStages == STAGE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	"a_UnlockAllCharacters": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllCharacters = achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllCharacters) < CHARACTER_COUNT
			&& prev(let_sumOf_FlagsAllCharacters) > CHARACTER_COUNT*3/4
			&& measured(let_sumOf_FlagsAllCharacters == CHARACTER_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	"a_CompleteHalfJournal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: No Measured Flag required for this as a_CompleteFullJournal already has one
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)

			&& prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT
			&& prev(let_sumOf_FlagsAllPages) > (JOURNALPAGE_COUNT/4)
			&& let_sumOf_FlagsAllPages >= JOURNALPAGE_COUNT/2 
		}),
	"a_CompleteFullJournal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT
			&& prev(let_sumOf_FlagsAllPages) > JOURNALPAGE_COUNT*3/4
			&& measured(let_sumOf_FlagsAllPages == JOURNALPAGE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion),
				format = "percent")
		}),
	"a_MaxHealth": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // <-- Implementation via RAIntegration UI
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks allowed as there are no HP upgrades unlockable during the StartChpMenu

		// ==== Core (Alt) Group ====
		// Below commented line breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
			// prev(achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion)) == HP_UPGRADE_COUNT - 1 
		measured(achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion) == HP_UPGRADE_COUNT,
			when = 
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))),
	"a_MaxDeadEye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // <-- Implementation via RAIntegration UI
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks allowed as there are no HP upgrades unlockable during the StartChpMenu

		// ==== Core (Alt) Group ====
		// Below commented line breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
			// prev(achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion)) == DEADEYE_UPGRADE_COUNT - 1
		measured(achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion) == DEADEYE_UPGRADE_COUNT,
			when = 
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))),
	
	"a_UnlockAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // <-- Implementation via RAIntegration UI
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUniqueWeapons(enum_releaseRegion)
		return 
		// Below 2 commented lines breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
			// prev(let_sumOf_AllWeaponFlags) < WEAPON_COUNT
			// && prev(let_sumOf_AllWeaponFlags) > WEAPON_COUNT*5/8
			measured(let_sumOf_AllWeaponFlags == WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	"a_UpgradeAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // <-- Implementation via RAIntegration UI
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion)
		return 
			// Below 2 commented lines breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
				// prev(let_sumOf_AllWeaponFlags) < UPGRADEABLE_WEAPON_COUNT
				// && prev(let_sumOf_AllWeaponFlags) > UPGRADEABLE_WEAPON_COUNT/2
			measured(let_sumOf_AllWeaponFlags == UPGRADEABLE_WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	"a_BountyCompletionHalf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // <-- Implementation via RAIntegration UI
		let_sumOf_FlagsAllBountyMissionsCompleted = achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion)
		return
			// ==== Core (Alt) Group ====
			// Below commented line breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
				// prev(let_sumOf_FlagsAllBountyMissionsCompleted) == (BOUNTY_HUNTER_MISSON_COUNT/2) - 1
			measured(let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT/2,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	"a_BountyCompletionAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // <-- Implementation via RAIntegration UI
		let_sumOf_FlagsAllBountyMissionsCompleted = achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion)
		return
			// ==== Core (Alt) Group ====
			// Below commented line breaks RAtools --> thus this AddSource chain is manually created via RAIntegration UI
				// prev(let_sumOf_FlagsAllBountyMissionsCompleted) == BOUNTY_HUNTER_MISSON_COUNT - 1
			measured(let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		}),
	}

// =====================
// • Achievements TEXT •
// =====================
achievements_titles = {
	// "a_Template": 						{"en": "xxxxxxxxx"},
	"a_CompleteStoryNormal": 				{"en": "Red's Redemption"},
	"a_CompleteStoryHard": 					{"en": "The Scorpion's Retribution"},
	"a_CompleteStoryVeryHard": 				{"en": "A Revolver's Story"},
	"a_CompleteStoryWood": 					{"en": "The Wood, the Red and the Inferno"},
	"a_BountyCompletionHalf": 				{"en": "Out for Blood"},
	"a_BountyCompletionAll":				{"en": "Notorious Bounty Hunter"},
	"a_BigMoney":							{"en": "It Was Always About the Money"},
	"a_WinHighNoon":						{"en": "Last Man Standing"},
	"a_WinSundownFortDiego":				{"en": "The Final Showdown"},
	"a_WinBountyHunterSunsetCanyon":		{"en": "Gunfight at Sunset"},
	"a_Chapter5StayOnTrain":				{"en": "Railway Maverick"},
	"a_PerfectShootingTutorial": 			{"en": "Rookie Sharpshooter"},
	"a_Chapter1AcquireMoney": 				{"en": "Budding Prize Hunter"},
	"a_UnlockAllStages": 					{"en": "Showdown Trailblazer"},
	"a_UnlockAllCharacters":				{"en": "Gunslinger's Ensemble"},
	"a_CompleteHalfJournal":				{"en": "Historical Account"},
	"a_CompleteFullJournal":				{"en": "Chronicles of the Frontier"},

	// text to manual edit (due to RATools bug)
	"a_MaxHealth":							{"en": "Peak Condition"},
	"a_MaxDeadEye":							{"en": "Red Eye"},
	"a_UnlockAllWeapons":					{"en": "It Never Was About the Money"},
	"a_UpgradeAllWeapons":					{"en": "Finest in the West"},
	}

// Showdown Challenge Title Idea's
	// Red's Redemption
	// Vendetta Complete
	// Last Man Standing
	// Justice Served Cold
	// The Final Showdown
	// Revenge of Red
	// Nemesis No More
	// Blood for Blood
	// End of the Trail
	// Gunfight at Sunset
	// Foe Vanquished
	// Reckoning Day
	// Wrath Unleashed
	// Rivalry Ended
	// Deadly Vengeance
	// Bullet with a Name
	// Silent Justice
	// Legend of Red
	// Bitter Victory
	// Westward Justice


// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_CompleteStoryNormal": 				{"en": "Wrangle Red's story on normal or higher difficulty"},
	"a_CompleteStoryHard": 					{"en": "Wrangle Red's story on hard or higher difficulty"},
	"a_CompleteStoryVeryHard": 				{"en": "Wrangle Red's story on very hard difficulty"},
	"a_CompleteStoryWood": 					{"en": "Wrangle the story on Red Wood Revolver difficulty"},
	"a_BountyCompletionHalf": 				{"en": "Complet half of the Bounty Hunter Mode missions on a single player profile"},
	"a_BountyCompletionAll":				{"en": "Complete all Bounty Hunter Mode missions on a single player profile"},
	"a_BigMoney":							{"en": "Amass a bank balance of $50 000 in the story campaign"},
	"a_WinHighNoon":						{"en": "xxxxxxxxx"},
	"a_WinSundownFortDiego":				{"en": "xxxxxxxxx"},
	"a_WinBountyHunterSunsetCanyon":		{"en": "xxxxxxxxx"},
	"a_Chapter5StayOnTrain":				{"en": "Navigate Chapter 5 'Railroaded' without stumbling off the train even once"},
	"a_PerfectShootingTutorial": 			{"en": "Prove your shooting prowess in Chapter 1 'Bull's Eye' by finishing the shooting tutorial without wasting a single bullet and remaining stationary"},
	"a_Chapter1AcquireMoney": 				{"en": "Collect a bounty of $1000 or more by the end of Chapter 1 'Bull's Eye'"},
	"a_UnlockAllStages": 					{"en": "Unlock all Showdown stages"},
	"a_UnlockAllCharacters":				{"en": "Unlock all Showdown characters"},
	"a_CompleteHalfJournal":				{"en": "Unlock half of Sheriff Bartlett's journal"},
	"a_CompleteFullJournal":				{"en": "Complete Sheriff Bartlett's journal"},

	// text to manual edit (due to RATools bug)
	"a_MaxHealth":							{"en": "Max out Red's health in the story campaign"},
	"a_MaxDeadEye":							{"en": "Max out Red's Dead Eye in the story campaign"},
	"a_UnlockAllWeapons":					{"en": "Acquire the full weapon arsenal during Red's story"},
	"a_UpgradeAllWeapons":					{"en": "Bring every weapon capable of enhancement to its maximum potential in a single story playthrough"},
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
	
	function achievements_getType(string_achievementDevName, string_achievementCategory) =>
		achievements_coreData[string_achievementCategory][string_achievementDevName]["type"]
	
	for let_categoryName in achievements_coreData { // This loop generates the achievements
		for let_cheevmentName in achievements_coreData[let_categoryName] {
			let_achievementData = achievements_coreData[let_categoryName][let_cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = achievements_generateTitle(let_cheevmentName, let_categoryName, util_language),
				type = achievements_getType(let_cheevmentName, let_categoryName),
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