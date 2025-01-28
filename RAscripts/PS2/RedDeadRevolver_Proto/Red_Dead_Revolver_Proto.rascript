// ***************************************************************************** \\
// █▀█ █▀▀ █▀▄    █▀▄ █▀▀ ▄▀█ █▀▄    █▀█ █▀▀ █░█ █▀█ █░░ █░█ █▀▀ █▀█ 		     \\
// █▀▄ ██▄ █▄▀    █▄▀ ██▄ █▀█ █▄▀    █▀▄ ██▄ ▀▄▀ █▄█ █▄▄ ▀▄▀ ██▄ █▀▄   PROTOTYPE \\
// ***************************************************************************** \\
// #ID = 32806
// No-Intro: https://datomatic.no-intro.org/index.php?page=show_record&s=169&n=0374 (NTSC-U)
// RA Hash: 286690e373e89d91408387a4a68c6742 (NTSC-U)
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/32806
// RATools version: v1.15.0

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


// Achievement Design Cocept Notes
// ---------------------------------------------
/*	EXCERPT from RAdocs:
	In some cases, there is no single Win Condition, such as a puzzle game when progression can be done in any order. In these cases, earning all Progression achievements will mark the game as beaten.
*/

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
RELEASE_REGIONS_SUPPORTED = [RELEASE_REGION_USA]

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
	"Struct:Coordinates": {
		"offsetToMember": {
			"Float:Y_Coordinate": 0x4,
			"Float:Z_Coordinate": 0x8,
			"Float:X_Coordinate": 0xC
		}},
	"Struct:PlayerData": {
		"pointerChainToMember": {
			"32-bit:Money_MPkills": { 
				"pointerChainOffsets": [0x130]},
			"Struct(Coordinates):PlayerLocation-X": {
				"pointerChainOffsets": [0x13C, 0xC, 0x90 + 0xC]},
			"Struct(Coordinates):PlayerLocation-Y": {
				"pointerChainOffsets": [0x13C, 0xC, 0x90 + 0x4]},
			"Struct(Coordinates):PlayerLocation-Z": {
				"pointerChainOffsets": [0x13C, 0xC, 0x90 + 0x8]},
			"ASCII:Active_CharacterAnimationID": { 
				"pointerChainOffsets": [0x13C, 0x64, 0x134, 0x18, 0x0, 0x0]},
			"Float:AnimationKeyFrame(functional)": {
				"pointerChainOffsets": [0x13C, 0x64, 0x134, 0x10]},
		}},
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



// #endregion MEM - struct definitions

// ==========================
// • MEMORY ADDRESS STORAGE •
// ==========================
// #region MEM - address storage
memory_addresses = {
	//	"memAddrKey": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"ASCII:GameID": {RELEASE_REGION_USA: 0x91204c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"ASCII:LevelID(preferred)": {RELEASE_REGION_USA: 0x9128e8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},

	"32-bit:GameState": {RELEASE_REGION_USA: 0x427c80, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},

	"Pointer:PlayerData-Player1": {RELEASE_REGION_USA: 0x421850, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
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
function is_ReleaseRegion(enum_releaseRegion) { // TODO implement is_ReleaseRegion()
	const_INTERNAL_SERIAL = "SCPS" // FullString: "SCPS_666.66"
	if(enum_releaseRegion == RELEASE_REGION_USA) {
		let_memAddr_GameID = memory_getAddress("ASCII:GameID", enum_releaseRegion)
		return ascii_string_equals(let_memAddr_GameID, const_INTERNAL_SERIAL) 
	} else if(enum_releaseRegion == RELEASE_REGION_JPN) {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	} else if(enum_releaseRegion == RELEASE_REGION_EUR) {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	} else {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	}}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
	// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
function memUtil_floatToInt(float_value, enum_releaseRegion) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", enum_releaseRegion))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

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

// #region Custom ASCII comparitors
// Custom ASCII comparitors are necessary to use with pointers, built-in RAtools ascii_string_equals() generates weird logic, when using pointers as the memAddrr

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
// #endregion Custom ASCII comparitors
// #endregion MEM - utility

// ......................
// ◦ General Game Logic ◦
// ''''''''''''''''''''''
// #region General Game Logic
// ----------------GameState---------------------
GAMESTATE_TitleScreen = 0x0
GAMESTATE_SinglePlayer = 0xFA
GAMESTATE_Multiplayer = 0xC8
function current_gameState(enum_releaseRegion) => dword(memory_getAddress("32-bit:GameState", enum_releaseRegion))
function is_GameState(enum_gameState, enum_releaseRegion) => current_gameState(enum_releaseRegion) == enum_gameState
// ----------------Divider---------------------

// #endregion General Game Logic

// ..............
// ◦ PlayerData ◦
// ''''''''''''''
// #region PlayerData

// ----------------Location---------------------
function current_PlayerLocation_X(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "Struct(Coordinates):PlayerLocation-X",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = float)
	}
function current_PlayerLocation_Y(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "Struct(Coordinates):PlayerLocation-Y",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = float)
	}
function current_PlayerLocation_Z(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "Struct(Coordinates):PlayerLocation-Z",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = float)
	}

function is_PlayerLocation_Near(coordinates_target, int_nearRadiusThreshold, enum_releaseRegion) => // Defintion DictObject:Coordinates = {"X": 0.0, "Y": 0.0, "Z": 0.0}
	coordinates_target["X"] - int_nearRadiusThreshold <= current_PlayerLocation_X(enum_releaseRegion) && current_PlayerLocation_X(enum_releaseRegion) <= coordinates_target["X"] + int_nearRadiusThreshold
	&& coordinates_target["Y"] - int_nearRadiusThreshold <= current_PlayerLocation_Y(enum_releaseRegion) && current_PlayerLocation_Y(enum_releaseRegion) <= coordinates_target["Y"] + int_nearRadiusThreshold
	&& coordinates_target["Z"] - int_nearRadiusThreshold <= current_PlayerLocation_Z(enum_releaseRegion) && current_PlayerLocation_Z(enum_releaseRegion) <= coordinates_target["Z"] + int_nearRadiusThreshold
// ----------------Character Animation---------------------
CHARACTER_ANIMATION_TipHat = "red_stn_idl_11"
CHARACTER_ANIMATION_Dodge = "red_rgt_dge"

function current_CharacterAnimationKeyFrame(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "Float:AnimationKeyFrame(functional)",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = float)
	}
function prev_CharacterAnimationKeyFrame(enum_releaseRegion) =>
	prev(current_CharacterAnimationKeyFrame(enum_releaseRegion))

function is_CharacterAnimation_active(string_animationID, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	let_PointerChainTo_activeCharacterAnimationID = memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "ASCII:Active_CharacterAnimationID", let_memAddr_basePointer)
	return 
		is_ASCII_EqualTo(let_PointerChainTo_activeCharacterAnimationID, string_animationID)
		&& current_CharacterAnimationKeyFrame(enum_releaseRegion) > 0.0
	}

function is_TippingHat_CharacterAnimation_active(enum_releaseRegion) =>
	is_CharacterAnimation_active(CHARACTER_ANIMATION_TipHat, enum_releaseRegion)

function on_TippingHat_CharacterAnimation_start(enum_releaseRegion) =>
	is_CharacterAnimation_active(CHARACTER_ANIMATION_TipHat, enum_releaseRegion)
	&& prev_CharacterAnimationKeyFrame(enum_releaseRegion) == 0.0

function on_TippingHat_CharacterAnimation_nearlyFinished(enum_releaseRegion) {
	const_ANIMATION_KEY_FRAME_THRESHOLD_nearlyFinished = 0.6
	return 
		is_CharacterAnimation_active(CHARACTER_ANIMATION_TipHat, enum_releaseRegion)
		&& current_CharacterAnimationKeyFrame(enum_releaseRegion) >= const_ANIMATION_KEY_FRAME_THRESHOLD_nearlyFinished
		&& prev_CharacterAnimationKeyFrame(enum_releaseRegion) < const_ANIMATION_KEY_FRAME_THRESHOLD_nearlyFinished
	}

function on_TippingHat_CharacterAnimation_finish(enum_releaseRegion) {
	const_ANIMATION_KEY_FRAME_THRESHOLD_finish = 0.9
	return 
		is_CharacterAnimation_active(CHARACTER_ANIMATION_TipHat, enum_releaseRegion)
		&& current_CharacterAnimationKeyFrame(enum_releaseRegion) >= const_ANIMATION_KEY_FRAME_THRESHOLD_finish
		&& prev_CharacterAnimationKeyFrame(enum_releaseRegion) < const_ANIMATION_KEY_FRAME_THRESHOLD_finish
	}

function on_Dodge_CharacterAnimation_start(enum_releaseRegion) => 
	is_CharacterAnimation_active(CHARACTER_ANIMATION_Dodge, enum_releaseRegion)
	&& prev_CharacterAnimationKeyFrame(enum_releaseRegion) == 0.0

function on_Dodge_CharacterAnimation_finish(enum_releaseRegion) {
	const_ANIMATION_KEY_FRAME_THRESHOLD_finish = 0.9
	return 
		is_CharacterAnimation_active(CHARACTER_ANIMATION_Dodge, enum_releaseRegion)
		&& current_CharacterAnimationKeyFrame(enum_releaseRegion) >= const_ANIMATION_KEY_FRAME_THRESHOLD_finish
		&& prev_CharacterAnimationKeyFrame(enum_releaseRegion) < const_ANIMATION_KEY_FRAME_THRESHOLD_finish
	}
// ----------------SinglePlayer Specific---------------------
function current_Money(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "32-bit:Money_MPkills",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = dword)
	}

function prev_Money(enum_releaseRegion) =>
	prev(current_Money(enum_releaseRegion))
// ----------------Multiplayer Specific---------------------

// #endregion PlayerData

// ...........
// ◦ LevelID ◦
// '''''''''''
// #region LevelID
LEVEL_TrainingStage = "tng" 	// FullString: "lvl_tng"
LEVEL_PrologueStage = "perf75"  // FullString: "lvl_perf75"
LEVEL_TitleStage = "hng" 		// FullString: "lvl_hng"
LEVEL_SheriffNight = "shernite" // FullString: "lvl_shernite"
LEVEL_SheriffDay = "sher70" 	// FullString: "lvl_sher70"
LEVEL_SaloonStage = "saloon" 	// FullString: "lvl_saloon"
LEVEL_Tombstone = "tomb" 		// FullString: "lvl_tomb"
LEVEL_FlashbackStage = "flash" 	// FullString: "lvl_flash"
LEVEL_Train = "train" 			// FullString: "lvl_train"
LEVEL_FortStage = "fort" 		// FullString: "lvl_fort"
LEVEL_Mansion = "mans" 			// FullString: "lvl_mans"
function is_Level(enum_levelID, enum_releaseRegion) {
	const_offsetTo_UniqueLevelIdSubstring = 0x4
	let_memAddr_levelID = memory_getAddress("ASCII:LevelID(preferred)", enum_releaseRegion)
	return ascii_string_equals(let_memAddr_levelID + const_offsetTo_UniqueLevelIdSubstring, enum_levelID)}
// ----------------Point of Interest (POI)---------------------
const_Level_POI_Coordinates = { // Defintion DictObject:Coordinates = {"X": 0.0, "Y": 0.0, "Z": 0.0}
	LEVEL_TrainingStage: { 
		"WhiteChest": {"X": 0.25, "Y": -18.47, "Z": -0.65}, 
		"BrokenCart": {"X": -22.18, "Y": -46.63, "Z": 0.14}
		},
	}
function is_PlayerNearPOI(enum_levelID, string_POI_key, float_radiusThreshold, enum_releaseRegion) => 
	is_PlayerLocation_Near(const_Level_POI_Coordinates[enum_levelID][string_POI_key], float_radiusThreshold, enum_releaseRegion)

// #endregion LevelID

// ................
// ◦ Sub_Header_2 ◦
// ''''''''''''''''
// #region Sub_Header_2

// ----------------Divider---------------------

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
achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// TODO Point distribution

	// "a_Template": { // CONCEPT a_template
	//	"id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_SinglePlayer": { // Category - Single Player Progression 
		// "a_CompleteTng": { // CONCEPT a_CompleteTng
		// 	"id": 000000, "points": 0000000, "devInfo": "lvl_tng: Finish shooting challenge, any outcome"},
		"a_CompletePerf": { // CONCEPT a_CompletePerf
			"id": 000000, "points": 0000000, "devInfo": "lvl_perf75: Kill all enemies + interact with allied NPC"},
		},
	"c_SPChallenge": { // Category - Single Player Challenges
		// "a_ShootingGalleryGreat": { // CONCEPT a_CompleteTng
		// 	"id": 000000, "points": 0000000, "devInfo": "Finish shooting challenge, with 'Good Job'"},
		},
	"c_SPbonus": { // Category - Single Player Bonus Secrets + Level Sightseeing
		"a_WinGame": { // VERIFIED a_WinGame
			"id": 494562, "points": 0000000, "devInfo": "Win Game, when cash over $49.09, I think only possible in lvl_tng"},
		"a_TipHat": { // VERIFIED a_TipHat
			"id": 494576, "points": 0000000, "devInfo": "Tutorial Achievement: How to tip your hat. Needed for the Sightseeing achievements"},
		"a_Dodge": { // VERIFIED a_Dodge
			"id": 494577, "points": 0000000, "devInfo": "Secret dodge input/animation"},
		"a_EyeTng": { // VERIFIED a_EyeTng
			"id": 494578, "points": 0000000, "devInfo": "lvl_tng: TipHat next to Chest and BrokenCart"},
		},
	"c_Multiplayer": { // Category - Multiplayer
		// "a_WinMon": { // CONCEPT a_WinMon
		// 	"id": 000000, "points": 0000000, "devInfo": "Win as (mon)"},
		// "a_WinRed": { // CONCEPT a_WinRed
		// 	"id": 000000, "points": 0000000, "devInfo": "Win as (red)"},
		// "a_ThrowableKill": { // CONCEPT a_ThrowableKill
		// 	"id": 000000, "points": 0000000, "devInfo": "Get a kill with knife or dynamite"},
		}
	}
// -------------------------------------
achievements_typeByCategory = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": "xxxxxx",
	"c_SinglePlayer": 		"progression", // NOTE: This prototype has no WinCondition -> Player which achieves all Progression achievements will be marked as beaten
	"c_SPChallenge":		sNULL,
	"c_SPbonus":			sNULL,
	"c_Multiplayer":		sNULL} 
	
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
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP_template
	// 	is_ReleaseRegion(enum_releaseRegion) &&
	// 	always_false()),

	// "a_TEST_coordinates": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
	// 	// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement		
	// 		is_ReleaseRegion(enum_releaseRegion)
	// 		&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
	// 		&& is_PlayerNearPOI(LEVEL_TrainingStage, "WhiteChest", 1.5, enum_releaseRegion)
	// 		&& trigger_when(dword(0xbeef) == 0xbaadf00d)
	// 	),

	// "a_CompleteTng": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
	// 	// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
	// 	is_ReleaseRegion(enum_releaseRegion)
	// 	&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
	// 	&& is_Level(LEVEL_TrainingStage, enum_releaseRegion)
	// 	&& trigger_when(dword(0xbeef) == 0xbaadf00d)
	// 	),

	"a_WinGame": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
 		/* NOTE: When in SinglePlayer and the player's money > $49.09, then the player Wins the game, after a few seconds the Level resets.
			This should only be possible in lvl_tng, as the dummies keep respawning. Each kill is worth $2
			Other levels don't have enough enemies to reach the $49.09 threshold
			*/
		const_MONEY_WIN_THRESHOLD = 500 // (= $49.10)

		return 
		// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement		
			is_ReleaseRegion(enum_releaseRegion) 
			&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)

			&& current_Money(enum_releaseRegion) >= const_MONEY_WIN_THRESHOLD
			&& prev_Money(enum_releaseRegion) < const_MONEY_WIN_THRESHOLD		
		}),	
	"a_TipHat": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
		never(
			!is_ReleaseRegion(enum_releaseRegion)
			|| is_GameState(GAMESTATE_TitleScreen, enum_releaseRegion))		
		&& once(on_TippingHat_CharacterAnimation_start(enum_releaseRegion))
		&& trigger_when(on_TippingHat_CharacterAnimation_finish(enum_releaseRegion))
		), 
	"a_Dodge": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_GameState(GAMESTATE_TitleScreen, enum_releaseRegion) 

		&& once(on_Dodge_CharacterAnimation_start(enum_releaseRegion))
		&& trigger_when(on_Dodge_CharacterAnimation_finish(enum_releaseRegion))
		),
	"a_EyeTng": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_REQUIRED_LEVEL = LEVEL_TrainingStage
		const_POI_COUNT = 2
		const_NEAR_RADIUS_THRESHOLD_BrokenCart = 2.1
		const_NEAR_RADIUS_THRESHOLD_WhiteChest = 1.2

		let_requirement_IsPlayerNearPOI_BrokenCart = 
			is_PlayerNearPOI(const_REQUIRED_LEVEL, "BrokenCart", const_NEAR_RADIUS_THRESHOLD_BrokenCart, enum_releaseRegion)
		let_requirement_IsPlayerNearPOI_WhiteChest = 
			is_PlayerNearPOI(const_REQUIRED_LEVEL, "WhiteChest", const_NEAR_RADIUS_THRESHOLD_WhiteChest, enum_releaseRegion)

		let_requirement_OnTipHatNear_BrokenCart = 
			let_requirement_IsPlayerNearPOI_BrokenCart
			&& on_TippingHat_CharacterAnimation_nearlyFinished(enum_releaseRegion)
		let_requirement_OnTipHatNear_WhiteChest = 
			let_requirement_IsPlayerNearPOI_WhiteChest
			&& on_TippingHat_CharacterAnimation_nearlyFinished(enum_releaseRegion)

		return
		// [1] ==== Alt Logic Group ==== 									-> This group handles achievement unlock logic;  This group is responsible for unlocking the achievement	
			never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(const_REQUIRED_LEVEL, enum_releaseRegion))
			&& measured(tally(const_POI_COUNT, [
				once(let_requirement_OnTipHatNear_BrokenCart),
				once(let_requirement_OnTipHatNear_WhiteChest)
				]))
			&& trigger_when(on_TippingHat_CharacterAnimation_nearlyFinished(enum_releaseRegion))
		// [2] ==== Alt POI Trigger Indicator Group - BrokenCart ==== 		-> This group only exists to display a Trigger Indicator when the player is near the BrokenCart	
			|| never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(const_REQUIRED_LEVEL, enum_releaseRegion))			
			&& unless(once( // <-- PauseLock: Hide Triggir Indicator, when Player has already finished this POI
				let_requirement_OnTipHatNear_BrokenCart))

			&& let_requirement_IsPlayerNearPOI_BrokenCart
			&& trigger_when(dword(0xbeef) == 0xbaadf00d)
		// [3] ==== Alt POI Trigger Indicator Group - WhiteChest ==== 		-> This group only exists to display a Trigger Indicator when the player is near the WhiteChest	
			|| never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(const_REQUIRED_LEVEL, enum_releaseRegion))			
			&& unless(once( // <-- PauseLock: Hide Triggir Indicator, when Player has already finished this POI
				let_requirement_OnTipHatNear_WhiteChest))
			
			&& let_requirement_IsPlayerNearPOI_WhiteChest
			&& trigger_when(dword(0xbeef) == 0xbaadf00d)
		}),
	}
// #endregion ACH - triggers

// =====================
// • ACHIEVEMENT text •
// =====================
// #region ACH - text
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_TEST_coordinates":		{"en": "Coordinate Test with Trigger Indicator"},

	"a_WinGame": 				{"en": "Overflowing Coffers"},
	"a_TipHat": 				{"en": "The Cowboy's Courtesy"},
	"a_Dodge": 					{"en": "The Slick Shuffle"},
	"a_EyeTng": 				{"en": "Trailblazer"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_TEST_coordinates":		{"en": "xxxxxxxxx"},

	"a_WinGame": 				{"en": "Win the game by acquiring over $49.09 in cash"},
	"a_TipHat": 				{"en": "A cowboy's salute speaks louder than words. Tip your hat, no matter the dust in your face, by standing idle and pressing and holding X or R1"},
	"a_Dodge": 					{"en": "A true cowboy knows when to step aside. Perform a dodge, even if it ain't a bullet with your name on it, by walking and pressing X or R1"},
	"a_EyeTng": 				{"en": "The \"Training Stage\" holds secrets for the watchful. Tip your hat near a white chest and broken cart to reflect on what you've learned"},
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

// =====================
// • RICH PRESENCE text •
// =====================
// #region RP - text
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},
	"rp_Default":										{"en": "Playing Capcom's Red Dead Revolver Prototype"}}	// TODO implement rp_Default + rp_DefaultPlus
richPresence_LookupTablesText = {
	// "rp_Template": {
	// 	"Lookup_A":						{"en": "xxxxxxxx"},
	// 	"Lookup_B":						{"en": "xxxxxxxx"},
	// 	"Lookup_C":						{"en": "xxxxxxxx"},
	// 	"LOOKUP_FALLBACK":				{"en": "xxxxxxxx"}
	// 	},
	}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	}
function richPresence_getLookupTable(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]
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
function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus")
	)}
function rp_Default() {
	return rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {

	}} 
// #endregion RP - display script

// ===========================
// • RICH PRESENCE parameters •
// ===========================
// #region RP - parameters
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

	//	"rpp_ValueTemplate": {
	//	 	"RPtype": richPresence_VALUE,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: always_false(), 
	//	 		RELEASE_REGION_EUR: always_false(),
	//	 		RELEASE_REGION_JPN: always_false()},
	//	 	"ValueFormat": "VALUE"},

	//	 "rpp_LookupTemplate": {
	//	 	"RPtype": richPresence_LOOKUP,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: always_false(), 
	//	 		RELEASE_REGION_EUR: always_false(),
	//	 		RELEASE_REGION_JPN: always_false()},
	//		"LookupTableID": "lup_LookupTableKey",
	//	 	"LookupFallback": richPresence_getLookupTableText("lup_LookupTableKey", "LOOKUP_FALLBACK")},

	//	"rpp_MacroTemplate": {
	//	 	"RPtype": richPresence_MACRO,
	//	 	"Expression": {
	//	 		RELEASE_REGION_USA: always_false(), 
	//	 		RELEASE_REGION_EUR: always_false(),
	//	 		RELEASE_REGION_JPN: always_false()},
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
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_expression = dict_paramLookupData["Expression"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData, enum_releaseRegion) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"][enum_releaseRegion]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP) return richPresence_callLookupFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}
// #endregion RP - parameters

// ===============================
// • RICH PRESENCE initialization •
// ===============================
// #region RP - initialization
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_lookupTableKey in richPresence_lookupTables { 
		let_lookupTable = richPresence_lookupTables[let_lookupTableKey]
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_lookupTableKey][let_lookupKey]
			richPresence_lookupTables[let_lookupTableKey][let_lookupKey] = richPresence_getLookupTableText(let_lookupTableKey, let_lookupValue)
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
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "xxxxxxx"},
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
	}
leaderboards_cancelTriggers = {	
	}
leaderboards_submitTriggers = {
	}
leaderboards_valueMeasures = {		
	}
// #endregion LB - triggers

// ====================
// • LEADERBOARD text •
// ====================
// #region LB - text
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	}
// #endregion LB - text

// ==============================
// • LEADERBOARD initialization •
// ==============================
// #region LB - initialization
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