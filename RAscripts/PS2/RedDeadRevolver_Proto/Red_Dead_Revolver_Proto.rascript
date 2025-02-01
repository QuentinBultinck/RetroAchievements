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

	TODO list
	- a_HorseTomb Accuracy test
	- update changes to unoffical

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

function util_concatArrays(array_1, array_2) { // This function will concatenate two arrays (add values of array_2 to array_1)
	let_array_concat = array_1
	for let_index in range(0, length(array_2) - 1) {
		array_push(let_array_concat, array_2[let_index])
	}
	return let_array_concat}

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
	"Struct:MenuData": {
		"offsetToMember": {
			"ASCII:MenuID": 0x14},
		"pointerChainToMember": {
			"BitFlag:IsMenuDisplayed": { 
				"pointerChainOffsets": [0x28]},
		}},
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
			"BitFlag:IsPlayerOnHorseback": { 
				"pointerChainOffsets": [0x134]},
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
			"32-bit:ShotsFired": {
				"pointerChainOffsets": [0x170, 0x0]},
			"32-bit:ShotsHit": {
				"pointerChainOffsets": [0x170, 0x2C]},
			"32-bit:Headshots": {
				"pointerChainOffsets": [0x170, 0x30]},
			"32-bit:Kills": {
				"pointerChainOffsets": [0x170, 0x5C]},
		}},
	"Struct:NPCdata": {
		"offsetToMember": {
			"Pointer:NextNode_NPCdata": 0x188
		},
		"pointerChainToMember": {
			"Struct(Coordinates):NPClocation(functional)-X": {
				"pointerChainOffsets": [0x4, 0x8, 0xC, 0x90 + 0xC]},
			"Struct(Coordinates):NPClocation(functional)-Y": {
				"pointerChainOffsets": [0x4, 0x8, 0xC, 0x90 + 0x4]},
			"Struct(Coordinates):NPClocation(functional)-Z": {
				"pointerChainOffsets": [0x4, 0x8, 0xC, 0x90 + 0x8]},
		}},
	"Pointer:NPCdata": {
		"pointerChainToMember": {
			// ----TrainingStage----
			"8-bit:MovementTrainingState": {
				"pointerChainOffsets": [0x188, 0x94, 0x108, 0xC, 0x0]},
			"ASCII:Active_MovementTrainingSectionID": {
				"pointerChainOffsets": [0x188, 0x94, 0x108, 0xC],
				"offsetToPointedToMember": 0x4},
			"8-bit:WeaponTrainingState": {
				"pointerChainOffsets": [0x188, 0x94, 0x14C, 0xC, 0x0]},
			"ASCII:Active_WeaponTrainingSectionID": {
				"pointerChainOffsets": [0x188, 0x94, 0x14C, 0xC],
				"offsetToPointedToMember": 0x4},
			"Lower4:ShootingGalleryState": {
				"pointerChainOffsets": [0x188, 0x94, 0x190, 0xC, 0x0]},
			"ASCII:ShootingGalleryNameState": {
				"pointerChainOffsets": [0x188, 0x94, 0x190, 0xC],
				"offsetToPointedToMember": 0x4},		
			// ----PrologueStage----
			"ASCIIFlag(NPCevent):IsJinnieThanksActive": {
				"pointerChainOffsets": [0x188, 0x188, 0x94, 0x4C0, 0x0]},
			"ASCIIFlag(NPCevent):IsMomThanksActive": {
				"pointerChainOffsets": [0x188, 0x188, 0x188, 0x94, 0x4C0, 0x0]},
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
	//	"memAddrKey": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"ASCII:GameID": {RELEASE_REGION_USA: 0x91204c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"ASCII:LevelID(preferred)": {RELEASE_REGION_USA: 0x9128e8, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},

	"8-bit:AlwaysNULL": {RELEASE_REGION_USA: 0x912040, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	
	"Float:TimeSpentInLevel": {RELEASE_REGION_USA: 0x92785c, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	
	"32-bit:GameState": {RELEASE_REGION_USA: 0x427c80, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},

	"Pointer:PlayerData-Player1": {RELEASE_REGION_USA: 0x421850, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"Pointer:NPCdata": {RELEASE_REGION_USA: 0x421dac, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	"Pointer:MenuData": {RELEASE_REGION_USA: 0x4215a0, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
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

function wasPrev_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prev(c))

function wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))
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
// ----------------MenuData---------------------
MENU_MainMenu = "main"
MENU_LevelSelectionMenu = "1000"
MENU_MultiplayerPlayerSetupMenu ="2010"
MENU_MultiplayerCharacterSelectMenu = "2000"
MENU_SelectionMenu = "menupage"
MENU_PauseMenu = "pause"

function is_MenuID(enum_menuID, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:MenuData", enum_releaseRegion)
	let_offsetTo_MenuID = memory_getStruct_OffsetToMember("Struct:MenuData", "ASCII:MenuID")
	return is_ASCII_EqualTo(dword(let_memAddr_basePointer) + let_offsetTo_MenuID, enum_menuID)}

function on_MenuID_changeTo(enum_menuID, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:MenuData", enum_releaseRegion)
	let_offsetTo_MenuID = memory_getStruct_OffsetToMember("Struct:MenuData", "ASCII:MenuID")
	return 
		is_ASCII_EqualTo(dword(let_memAddr_basePointer) + let_offsetTo_MenuID, enum_menuID)
		&& wasPrev_ASCII_notEqualTo(dword(let_memAddr_basePointer) + let_offsetTo_MenuID, enum_menuID)}

function current_FlagState_IsMenuDisplayed(enum_releaseRegion) => 
	memGenerate_pointerChainAccessor(
		"Struct:MenuData", "BitFlag:IsMenuDisplayed", memory_getAddress("Pointer:MenuData", enum_releaseRegion),
		memAccessorFunction_toPointedToMember = bit0)

function prev_FlagState_IsMenuDisplayed(enum_releaseRegion) => 
	prev(current_FlagState_IsMenuDisplayed(enum_releaseRegion))

function is_Menu_displayed(enum_menuID, enum_releaseRegion) =>
	is_MenuID(enum_menuID, enum_releaseRegion)
	&& current_FlagState_IsMenuDisplayed(enum_releaseRegion) == 1

function on_Menu_render(enum_menuID, enum_releaseRegion) =>
	is_MenuID(enum_menuID, enum_releaseRegion)
	&& current_FlagState_IsMenuDisplayed(enum_releaseRegion) == 1
	&& prev_FlagState_IsMenuDisplayed(enum_releaseRegion) == 0
	
// ----------------TimeSpentInLevel---------------------
function current_TimeSpentInLevel(enum_releaseRegion) => float(memory_getAddress("Float:TimeSpentInLevel", enum_releaseRegion))
function prev_TimeSpentInLevel(enum_releaseRegion) => prev(current_TimeSpentInLevel(enum_releaseRegion))
function on_TimeSpentInLevel_start(enum_releaseRegion) => 
	// NOTE: Don't compare to 0.0 as were working with floats, and the value might not be exactly 0.0
	current_TimeSpentInLevel(enum_releaseRegion) <= 1.0
	&& prev_TimeSpentInLevel(enum_releaseRegion) > 1.0

function on_TimeSpentInLevel_reset(enum_releaseRegion) => 
	current_TimeSpentInLevel(enum_releaseRegion) < prev_TimeSpentInLevel(enum_releaseRegion)

function on_Level_startORreset(enum_releaseRegion) =>
	on_TimeSpentInLevel_start(enum_releaseRegion)
	|| on_TimeSpentInLevel_reset(enum_releaseRegion)

// #endregion General Game Logic

// ..............
// ◦ PlayerData ◦
// ''''''''''''''
// #region PlayerData
// #region ShootingStats
// ----------------SinglePlayer---------------------
function current_SinglePlayer_ShotsFired(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "32-bit:ShotsFired",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = dword)}

function current_SinglePlayer_ShotsHit(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "32-bit:ShotsHit",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = dword)}

function current_calculated_Accuracy(enum_releaseRegion) => 
	current_SinglePlayer_ShotsFired(enum_releaseRegion) / current_SinglePlayer_ShotsHit(enum_releaseRegion)

function current_SinglePlayer_Headshots(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "32-bit:Headshots",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = dword)}

function prev_SinglePlayer_Headshots(enum_releaseRegion) =>
	prev(current_SinglePlayer_Headshots(enum_releaseRegion))

function on_SinglePlayer_Headshot_increment(enum_releaseRegion) =>
	current_SinglePlayer_Headshots(enum_releaseRegion) > prev_SinglePlayer_Headshots(enum_releaseRegion)

function current_SinglePlayer_Kills(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "32-bit:Kills",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = dword)}

function prev_SinglePlayer_Kills(enum_releaseRegion) =>
	prev(current_SinglePlayer_Kills(enum_releaseRegion))

function on_SinglePlayer_Kill_increment(enum_releaseRegion) =>
	current_SinglePlayer_Kills(enum_releaseRegion) > prev_SinglePlayer_Kills(enum_releaseRegion)
// ----------------Multiplayer---------------------
// #endregion ShootingStats
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
	let_pointerChainTo_activeCharacterAnimationID = memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "ASCII:Active_CharacterAnimationID", let_memAddr_basePointer)
	return 
		is_ASCII_EqualTo(let_pointerChainTo_activeCharacterAnimationID, string_animationID)
		&& current_CharacterAnimationKeyFrame(enum_releaseRegion) > 0.0
	}

function is_CharacterAnimation_inactive(string_animationID, enum_releaseRegion){
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	let_pointerChainTo_activeCharacterAnimationID = memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "ASCII:Active_CharacterAnimationID", let_memAddr_basePointer)
	return is_ASCII_notEqualTo(let_pointerChainTo_activeCharacterAnimationID, string_animationID)}

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
function is_PlayerOnHorseback(enum_releaseRegion) {
	// NOTE: In SinglePlayer, PlayerData for Player1 is used
	let_memAddr_basePointer = memory_getAddress("Pointer:PlayerData-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerData", "BitFlag:IsPlayerOnHorseback",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = bit0) == 1
	}

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

// ...........
// ◦ NPCdata ◦
// '''''''''''
// #region NPCdata
// -----------------General--------------------
function memGenerate_array_pointerChainOffsetsTo_NPCdata(int_NPCdataIndex) {
	if(int_NPCdataIndex < 0) util_throwError("'int_NPCdataIndex' must be greater than 0")
	if(int_NPCdataIndex == 0) return []

	let_array_pointerChainOffsetsTo_NPCdata = []
	let_index = 0
	let_offsetTo_PointerNextNode_NPCdata = memory_getStruct_OffsetToMember("Struct:NPCdata", "Pointer:NextNode_NPCdata")
	for let_index in range(0, int_NPCdataIndex - 1)
		array_push(let_array_pointerChainOffsetsTo_NPCdata, let_offsetTo_PointerNextNode_NPCdata)
	return let_array_pointerChainOffsetsTo_NPCdata
	}
function current_NPClocation_YCoord(int_NPCdataIndex, enum_releaseRegion) {
	let_array_pointerChainOffsetsTo_NPCdata = memGenerate_array_pointerChainOffsetsTo_NPCdata(int_NPCdataIndex)
	let_array_pointerChainOffsetsTo_NPClocation_from_NPCdata = memory_getStruct_offsetSequenceToMember("Struct:NPCdata", "Struct(Coordinates):NPClocation(functional)-Y")
	let_array_pointerChainOffsetsTo_NPClocation_Coord = util_concatArrays(let_array_pointerChainOffsetsTo_NPCdata, let_array_pointerChainOffsetsTo_NPClocation_from_NPCdata)
	
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)		
	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_basePointer, 
		let_array_pointerChainOffsetsTo_NPClocation_Coord, memAccessorFunction_toPointedToMember = float)
	}
function prev_NPClocation_YCoord(int_NPCdataIndex, enum_releaseRegion) =>
	prev(current_NPClocation_YCoord(int_NPCdataIndex, enum_releaseRegion))
// #region TrainingStage
// -----------------MovementTraining--------------------
MOVEMENT_TRAINING_SECTION_SneakAndCreep = "Sneak_and_Creep"
function is_MovementTrainingSectionID(enum_movementTrainingSection, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_activeMovementTrainingSectionID = 
		memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCII:Active_MovementTrainingSectionID", let_memAddr_basePointer) + 
		memory_getStruct_OffsetToPointedToMember("Pointer:NPCdata", "ASCII:Active_MovementTrainingSectionID")
	return is_ASCII_EqualTo(let_pointerChainTo_activeMovementTrainingSectionID, enum_movementTrainingSection)}

function current_MovementTrainingState(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:NPCdata", "8-bit:MovementTrainingState",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = byte)}

function prev_MovementTrainingState(enum_releaseRegion) =>
	prev(current_MovementTrainingState(enum_releaseRegion))

function on_TrainingStage_MovementTraining_complete(enum_releaseRegion) {
	const_STATE_COMPLETE_MovementTrainingSection_SneakAndCreep = 0x1F	
	return 
		is_MovementTrainingSectionID(MOVEMENT_TRAINING_SECTION_SneakAndCreep, enum_releaseRegion)
		&& current_MovementTrainingState(enum_releaseRegion) == const_STATE_COMPLETE_MovementTrainingSection_SneakAndCreep
		&& prev_MovementTrainingState(enum_releaseRegion) < const_STATE_COMPLETE_MovementTrainingSection_SneakAndCreep
		&& prev_MovementTrainingState(enum_releaseRegion) > const_STATE_COMPLETE_MovementTrainingSection_SneakAndCreep - 0x3 // --> Allow for some leeway, by minus 3 states
	}
// -----------------WeaponTraining--------------------
WEAPON_TRAINING_SECTION_RapidFire = "Rapid_Fire"
function is_WeaponTrainingSectionID(enum_weaponTrainingSection, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_activeWeaponTrainingSectionID = 
		memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCII:Active_WeaponTrainingSectionID", let_memAddr_basePointer) + 
		memory_getStruct_OffsetToPointedToMember("Pointer:NPCdata", "ASCII:Active_WeaponTrainingSectionID")
	return is_ASCII_EqualTo(let_pointerChainTo_activeWeaponTrainingSectionID, enum_weaponTrainingSection)}

function current_WeaponTrainingState(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:NPCdata", "8-bit:WeaponTrainingState",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = byte)}

function prev_WeaponTrainingState(enum_releaseRegion) =>
	prev(current_WeaponTrainingState(enum_releaseRegion))

function on_TrainingStage_WeaponTraining_complete(enum_releaseRegion) {
	const_STATE_COMPLETE_WeaponTrainingSection_RapidFire = 0x16	
	return 
		is_WeaponTrainingSectionID(WEAPON_TRAINING_SECTION_RapidFire, enum_releaseRegion)
		&& current_WeaponTrainingState(enum_releaseRegion) == const_STATE_COMPLETE_WeaponTrainingSection_RapidFire
		&& prev_WeaponTrainingState(enum_releaseRegion) < const_STATE_COMPLETE_WeaponTrainingSection_RapidFire
		&& prev_WeaponTrainingState(enum_releaseRegion) > const_STATE_COMPLETE_WeaponTrainingSection_RapidFire - 0x3 // --> Allow for some leeway, by minus 3 states
	}
// -----------------ShootingGallery--------------------
SHOOTING_GALLERY_NAME_STATE_Inactive = "0tar" // FullString: "0tart_Whak_A_Mole"
SHOOTING_GALLERY_NAME_STATE_Active = "Star" // FullString: "Start_Whak_A_Mole"
SHOOTING_GALLERY_NAME_STATE_Win = "Whac" // FullString: "Whack_A_Mole_Win"
function is_ShootingGalleryNameState(enum_shootingGalleryNameState, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_shootingGalleryNameState = 
		memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCII:ShootingGalleryNameState", let_memAddr_basePointer) + 
		memory_getStruct_OffsetToPointedToMember("Pointer:NPCdata", "ASCII:ShootingGalleryNameState")
	return is_ASCII_EqualTo(let_pointerChainTo_shootingGalleryNameState, enum_shootingGalleryNameState)}

function on_ShootingGalleryNameState_changeTo(enum_shootingGalleryNameState, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_shootingGalleryNameState = 
		memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCII:ShootingGalleryNameState", let_memAddr_basePointer) + 
		memory_getStruct_OffsetToPointedToMember("Pointer:NPCdata", "ASCII:ShootingGalleryNameState")
	return 
		is_ASCII_EqualTo(let_pointerChainTo_shootingGalleryNameState, enum_shootingGalleryNameState)
		&& wasPrev_ASCII_notEqualTo(let_pointerChainTo_shootingGalleryNameState, enum_shootingGalleryNameState)}

function current_ShootingGalleryState(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:NPCdata", "Lower4:ShootingGalleryState",
		let_memAddr_basePointer, memAccessorFunction_toPointedToMember = low4)}

function prev_ShootingGalleryState(enum_releaseRegion) =>
	prev(current_ShootingGalleryState(enum_releaseRegion))

function on_TrainingStage_ShootingChallenge_Fail(enum_releaseRegion) {
	const_SHOOTING_GALLERY_STATE_TaskShootDummies = 0x5 // --> ShootingGallery State where the player is required to shoot the dummies
	const_SHOOTING_GALLERY_STATE_Fail = 0x6 // 0x6 or 0x7 --> ShootingGallery Fail State - msg. "Stop shooting Time is up!"

	return 
		is_ShootingGalleryNameState(SHOOTING_GALLERY_NAME_STATE_Active, enum_releaseRegion)
		&& current_ShootingGalleryState(enum_releaseRegion) >= const_SHOOTING_GALLERY_STATE_Fail
		&& prev(current_ShootingGalleryState(enum_releaseRegion)) < const_SHOOTING_GALLERY_STATE_Fail
		&& prev(current_ShootingGalleryState(enum_releaseRegion)) > const_SHOOTING_GALLERY_STATE_Fail - 0x3 // --> Allow for some leeway, by minus 3 states
	}

function on_TrainingStage_ShootingChallenge_Win(enum_releaseRegion) =>
	on_ShootingGalleryNameState_changeTo(SHOOTING_GALLERY_NAME_STATE_Win, enum_releaseRegion)

// #endregion TrainingStage

// #region PrologueStage
ASCII_FLAG_STATE_Perf75_IsMomThanksActive_true = "Perf" // FullString: "Perf75_End_Cinematic"
ASCII_FLAG_STATE_Perf75_IsMomThanksActive_false = "0erf" // FullString: "0erf75_End_Cinematic"
ASCII_FLAG_STATE_Perf75_IsJinnieThanksActive_true = "Than" // FullString: "ThankYou2"
ASCII_FLAG_STATE_Perf75_IsJinnieThanksActive_false = "0han" // FullString: "0hankYou2"
function is_ASCIIflagState_PrologueStage_IsMomThanksActive_false(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_ASCIIFlag = memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCIIFlag(NPCevent):IsMomThanksActive", let_memAddr_basePointer)
	return is_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsMomThanksActive_false)}

function on_ASCIIflagState_PrologueStage_IsMomThanksActive_toggleTrue(enum_releaseRegion) {

	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_ASCIIFlag = memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCIIFlag(NPCevent):IsMomThanksActive", let_memAddr_basePointer)
	return 
		is_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsMomThanksActive_true)
		&& wasPrev_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsMomThanksActive_false)
	}

function is_ASCIIflagState_PrologueStage_IsJinnieThanksActive_false(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_ASCIIFlag = memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCIIFlag(NPCevent):IsJinnieThanksActive", let_memAddr_basePointer)
	return is_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsJinnieThanksActive_false)}

function on_ASCIIflagState_PrologueStage_IsJinnieThanksActive_toggleTrue(enum_releaseRegion) {

	let_memAddr_basePointer = memory_getAddress("Pointer:NPCdata", enum_releaseRegion)
	let_pointerChainTo_ASCIIFlag = memGenerate_pointerChainAccessor("Pointer:NPCdata", "ASCIIFlag(NPCevent):IsJinnieThanksActive", let_memAddr_basePointer)
	return 
		is_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsJinnieThanksActive_true)
		&& wasPrev_ASCII_EqualTo(let_pointerChainTo_ASCIIFlag, ASCII_FLAG_STATE_Perf75_IsJinnieThanksActive_false)
	}
// #endregion PrologueStage

// #endregion NPCdata

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
		"a_CompleteTng": { // VERIFIED a_CompleteTng
			"id": 495453, "points": 0000000, "devInfo": "lvl_tng: Complete Movement Training, Weapon Training and Shooting Challenge"},
		// "a_CompletePerf": { // CONCEPT a_CompletePerf
		// 	"id": 000000, "points": 0000000, "devInfo": "lvl_perf75: Kill all enemies + interact with Mom and Jinnie"},
		// "a_CompleteHng": { // CONCEPT a_CompleteHng
		//	"id": 000000, "points": 0000000, "devInfo": "lvl_hng: Kill all enemies + interact woth dog"},
		// "a_CompleteShernite": { // CONCEPT a_CompleteShernite
		//	"id": 000000, "points": 0000000, "devInfo": "lvl_shernite: Kill all enemies + interact with friendly NPC"},
		// "a_CompleteSher70": { // CONCEPT a_CompleteSher70
		//	"id": 000000, "points": 0000000, "devInfo": "lvl_sher70: Kill all enemies"},
		},
	"c_SPChallenge": { // Category - Single Player Challenges
		// "a_ShootingGalleryGreat": { // CONCEPT a_ShootingGalleryGreat
		// 	"id": 000000, "points": 0000000, "devInfo": "Finish shooting challenge in under xx time"},
		"a_ChallengePerf": { // QA // WARNING - Manual Construction
			"id": 000000, "points": 0000000, "devInfo": "lvl_perf: Finish level (talk to mom after killing all enemies) with % accuracy or better"},
		},
	"c_SPbonus": { // Category - Single Player Bonus Secrets + Level Sightseeing
		"a_WinGame": { // VERIFIED a_WinGame
			"id": 494562, "points": 0000000, "devInfo": "Win Game, when cash over $49.09, I think only possible in lvl_tng"},
		"a_TipHat": { // VERIFIED a_TipHat
			"id": 494576, "points": 0000000, "devInfo": "Tutorial Achievement: How to tip your hat. Needed for the Sightseeing achievements"},
		"a_Dodge": { // VERIFIED a_Dodge
			"id": 494577, "points": 0000000, "devInfo": "Secret dodge input/animation"},
		"a_SaloonThrow": { // VERIFIED a_SaloonThrow
			"id": 495633, "points": 0000000, "devInfo": "lvl_saloon: Throw both enemies through the front door of the saloon"},
		"a_HorseTomb": { // CONCEPT a_HorseTomb
			"id": 000000, "points": 0000000, "devInfo": "lvl_tomb: Kill all enemies whilst on horseback, with 100% accuracy"},
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
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP _template
		// // [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement		
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()),

	// "a_TEST_coordinates": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
	// 	// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement		
	// 		is_ReleaseRegion(enum_releaseRegion)
	// 		&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
	// 		&& is_PlayerNearPOI(LEVEL_TrainingStage, "WhiteChest", 1.5, enum_releaseRegion)
	// 		&& trigger_when(dword(0xbeef) == 0xbaadf00d)
	// 	),

	// c_SinglePlayer
	"a_CompleteTng":  any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// NOTE: Two alt logic groups (one of them needs to be true). One counts a ShootingChallenge_Fail, the other counts a ShootingChallenge_Win
		// [1] ==== Alt Logic Group - ShootingChallenge_Fail ==== 			-> Alt Logic Group 1, which counts ShootingChallenge_Fail
			never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(LEVEL_TrainingStage, enum_releaseRegion))
			&& measured(tally(3, [
				once(on_TrainingStage_MovementTraining_complete(enum_releaseRegion)),
				once(on_TrainingStage_WeaponTraining_complete(enum_releaseRegion)),
				once(on_TrainingStage_ShootingChallenge_Fail(enum_releaseRegion))]
				))
			// && trigger_when(on_Menu_render(MENU_SelectionMenu, enum_releaseRegion)) // ---Disabled--> Otherwise doing MovementTraining for last => plaer will have to re-complete whole WeaponTraining as well before this Menu renders again
		// [2] ==== Alt Logic Group - ShootingChallenge_Win ==== 			-> Alt Logic Group 2, which counts ShootingChallenge_Win
			|| never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(LEVEL_TrainingStage, enum_releaseRegion))
			&& measured(tally(3, [
				once(on_TrainingStage_MovementTraining_complete(enum_releaseRegion)),
				once(on_TrainingStage_WeaponTraining_complete(enum_releaseRegion)),
				once(on_TrainingStage_ShootingChallenge_Win(enum_releaseRegion))]
				))
			// && trigger_when(on_Menu_render(MENU_SelectionMenu, enum_releaseRegion)) // ---Disabled--> Otherwise doing MovementTraining for last => plaer will have to re-complete whole WeaponTraining as well before this Menu renders again
		),
	// c_SPChallenge
	"a_ChallengePerf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual Construction
		// NOTE: [ASCIIFlag(NPCevent):IsMomThanksActive] && [ASCIIFlag(NPCevent):IsJinnieThanksActive] is only activatable after killing all enemies in this level.
		const_MIN_REQUIRED_ACCURACY = 0.7
		return 
		// [0] ==== Core Logic Group ==== 				-> This group handles the core logic; It's responsible for unlocking the achievement		
			is_ReleaseRegion(enum_releaseRegion)
			&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
			&& is_Level(LEVEL_PrologueStage, enum_releaseRegion)

			/* MANUAL_CONSTRUCTION below line (usage of R/R) - current_calculated_Accuracy() >= const_MIN_REQUIRED_ACCURACY
				I:0xX00421850_I:0xX00000170_K:f0.0+0xX00000000_I:0xX00421850_I:0xX00000170_K:0xX0000002c/{recall}_{recall}>=f0.7
				
				Remember	0.0 + [32-bit:ShotsFired]
				Remember	[32-bit:ShotsHit] / Recall
							Recall >= const_MIN_REQUIRED_ACCURACY
				*/
			&& current_calculated_Accuracy(enum_releaseRegion) >= const_MIN_REQUIRED_ACCURACY

			&& trigger_when(tally(1, [ // ---Tally--> functions as an orNext
				once(never(is_ASCIIflagState_PrologueStage_IsMomThanksActive_false(enum_releaseRegion))
					&& on_ASCIIflagState_PrologueStage_IsMomThanksActive_toggleTrue(enum_releaseRegion)),
				once(never(is_ASCIIflagState_PrologueStage_IsJinnieThanksActive_false(enum_releaseRegion))
					&& on_ASCIIflagState_PrologueStage_IsJinnieThanksActive_toggleTrue(enum_releaseRegion))
			]))

		// [2] ==== Alt Accuracy Measured Group ==== 	-> This group purely exists to display % accuracy in a Measured Indicator
			/* MANUAL_CONSTRUCTION below measureComparison (usage of R/R) - measured(current_calculated_Accuracy()) as percent
				I:0xX00421850_I:0xX00000170_K:f0.0+0xX00000000_I:0xX00421850_I:0xX00000170_K:0xX0000002c/{recall}_K:{recall}*f100.0_G:{recall}>=f100.0
				
				Remember	0.0 + [32-bit:ShotsFired]
				Remember	[32-bit:ShotsHit] / Recall
				Remember	Recall * 100.0
				Measured	Recall
				*/
			|| measured( 
				// current_calculated_Accuracy(enum_releaseRegion) >= 100,
				current_SinglePlayer_ShotsHit(enum_releaseRegion) / current_SinglePlayer_ShotsFired(enum_releaseRegion) >= 100, 
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
					&& is_Level(LEVEL_PrologueStage, enum_releaseRegion),
				format = "percent")
			&& trigger_when(always_false()) // ---AlwaysFalse---> This alt group should not unlock the achievment
		}),
	// c_SPbonus
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

		&& once(
			never(is_CharacterAnimation_inactive(CHARACTER_ANIMATION_Dodge, enum_releaseRegion)) // ---ResetNextIf--- // TODO test this reset
			&& on_Dodge_CharacterAnimation_start(enum_releaseRegion))
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
	"a_SaloonThrow": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		/* NOTE: Coordinates + Shoving NPCs
			- The frontside wall of the saloon is perpendicular to X-axis, thus Y-axis can be used as check; Going inside the saloon decreases the y coord; Going outside increases it
			- Enemy NPCs can be grabbed and thrown. Press and Hold X or R1 (without in aim mode) to grab, then release to throw.
			- Enemy NPCs can be "melee" kicked. Press X or R1 while in aim mode and whilst standing close to an enemy to shove them. (Player should be standing close enough when PlayerCharacter moves weapon aside)
			- The perfect tactic is to grab an enemy, then aim them at the front door and try a throw. If he bounces back inside, try a "melee" kick 
			*/
		const_Y_COORD_SaloonFrontWall = -1.5 // Wall is perpendicular to X-axis, thus Y-axis can be used
		const_ENEMY_COUNT = 2
		const_NPC_LINKEDLISTED_INDEX_zzt = 0 
		const_NPC_LINKEDLISTED_INDEX_zzt2 = 1
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement		
			never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(LEVEL_SaloonStage, enum_releaseRegion))
			&& never(on_Level_startORreset(enum_releaseRegion))

			&& measured(tally(const_ENEMY_COUNT, [ // ---Measured---> Count the number of enemies thrown through the front door of the saloon, by checking respective Y coordinates 
				once(
					current_NPClocation_YCoord(const_NPC_LINKEDLISTED_INDEX_zzt, enum_releaseRegion) >= const_Y_COORD_SaloonFrontWall
					&& prev_NPClocation_YCoord(const_NPC_LINKEDLISTED_INDEX_zzt, enum_releaseRegion) < const_Y_COORD_SaloonFrontWall),
				once(
					current_NPClocation_YCoord(const_NPC_LINKEDLISTED_INDEX_zzt2, enum_releaseRegion) >= const_Y_COORD_SaloonFrontWall
					&& prev_NPClocation_YCoord(const_NPC_LINKEDLISTED_INDEX_zzt2, enum_releaseRegion) < const_Y_COORD_SaloonFrontWall)]
				))
		}),
	"a_HorseTomb": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_ENEMY_COUNT = 2
		return
		// [1] ==== Alt Logic Group ==== 				-> This group handles the core logic; It's responsible for unlocking the achievement		
			never(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_GameState(GAMESTATE_SinglePlayer, enum_releaseRegion)
				|| !is_Level(LEVEL_Tombstone, enum_releaseRegion))
			&& unless( // Pause: When missed a bullet --- This is a Pause Lock, because the used RAMvalues for this PauseIf only reset on Level Start or Reset
				current_SinglePlayer_ShotsHit(enum_releaseRegion) <= current_SinglePlayer_ShotsFired(enum_releaseRegion))
			&& repeated(const_ENEMY_COUNT, 
				is_PlayerOnHorseback(enum_releaseRegion)
				&& on_SinglePlayer_Kill_increment(enum_releaseRegion))
		}),

	// c_Multiplayer
	}
// #endregion ACH - triggers

// =====================
// • ACHIEVEMENT text •
// =====================
// #region ACH - text
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_TEST_coordinates":		{"en": "Coordinate Test with Trigger Indicator"},

	"a_CompleteTng": 			{"en": "Westbound and Ready"},

	"a_ChallengePerf":			{"en": "xxxxxxxxx"},

	"a_WinGame": 				{"en": "Overflowing Coffers"},
	"a_TipHat": 				{"en": "The Cowboy's Courtesy"},
	"a_Dodge": 					{"en": "The Slick Shuffle"},
	"a_EyeTng": 				{"en": "Trailblazer"},
	"a_SaloonThrow": 			{"en": "Boots First, Questions Later"},
	"a_HorseTomb":				{"en": "Lead and Leather"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_TEST_coordinates":		{"en": "xxxxxxxxx"},

	"a_CompleteTng": 			{"en": "In the \"Training Stage\", complete the Movement Training, Weapon Training and the Shooting Challenge"},

	"a_ChallengePerf":			{"en": "xxxxxxxxx"},

	"a_WinGame": 				{"en": "Fortune favors the bold. Rack up over $49.09 in cash within a Singleplayer level to win it all"},
	"a_TipHat": 				{"en": "A cowboy's salute speaks louder than words. Tip your hat, no matter the dust in your face, by standing idle and pressing and holding X or R1"},
	"a_Dodge": 					{"en": "A true cowboy knows when to step aside. Perform a dodge, even if it ain't a bullet with your name on it, by walking and pressing X or R1"},
	"a_EyeTng": 				{"en": "The \"Training Stage\" holds secrets for the watchful. Tip your hat near a white chest and broken cart to reflect on what you've learned"},
	"a_SaloonThrow": 			{"en": "In the \"Saloon Stage\", send every patron flying through the front doors with a throw or a good ol' boot. Press and hold X or R1 (while not aiming) to grab an enemy. Press X or R1 (while aiming and in melee range) to kick"},
	"a_HorseTomb":				{"en": "In the \"Tombstone Stage\", prove your gunslinger prowess by eliminating every enemy from horseback without missing a single shot"},
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