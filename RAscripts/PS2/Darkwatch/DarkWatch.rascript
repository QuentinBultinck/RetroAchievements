// ***************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 \\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	 \\
// ***************************************** \\
// #ID = 19111
// md5: 
// RA Hash: 0e21d37f63246c5a7bb32e074ce43f8b (PAL) -- 00bead17cad153878fc25b8985187192 (NTSC-U)
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/19111
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

/* TODO list 
	(Optional) Find code note for:
	- Minimatic/Cinematic ID (probably best do check IsCinematic active with checks on PlayerLocation + hitcount how many cinematics were activated)
	- UnlockFlags for Concept Art (Only unlockable through  Gunslinger Mode)
	- Enemy EntityData (HP, Location, Type) --> cheevo's for killing specific enemies
	
	Hubs to add:
	- [Feature - PvP] 							https://retroachievements.org/game/9377
	- [Perspective - 1st-Person] 				https://retroachievements.org/game/3401
	- [Feature - Co-op] 						https://retroachievements.org/game/24859
	- [Protagonist - Cowboy] 					https://retroachievements.org/game/18941
	- [Protagonist - Vampire Hunter] 			https://retroachievements.org/game/18940
	- [Meta - Has RAGuide]  					https://retroachievements.org/game/4637
	- [Meta - Quality of Life Patch Available]	https://retroachievements.org/game/30636

	*/

/* DEV_NOTE - Game Logic Notes:
	- MainMenu Flag with Sofdec or IsInGame flag

	- Power Unlock Flags (hacky) --> can  kinda ID it because a new power is selected by default on unlock on the display

	- ID minimatics/Cinematics (in-engine) 
		- Very hacky to ID consistently with ASCII ID
		- Rrefer using hit counts of how many times an Cinmatic has been played to Identify if a specific cinematic has been played (eg. Cinematic 3 of Chapter X => 3 hits counts on_Cinematic_start())
		- Could also introduce PlayerLocation as an extra check when the Cinematic Flag is active (this is only applicable for some cinematics where the playerLoc gets moved to some sort of default location, during or after the cinematic is done)

	- COOP mode doesn't have a Stats menu, only seperate stats for each player updated during the chapter

	- ChapterSections (eg. WrongTrain_A & WrongTrain_B) 
		- When WrongTrain_B is reached, and restarting -> game restarts from the beginning of WrongTrain_B
		- When WrongTrain_B is reached, and continueing game via MainMenu, when Chapter is "in progress" -> game continues from the beginning of WrongTrain_B, NOT from start of WrongTrain_A

	- Identify start of chapter SinglePlayer => perhaps with checkpoints?
	- Identify start of chapter COOP => 

	- COOP saveData is saved as a seperate "PlayerProfile"
		- Thus there can be up to 10 PlayerProfiles saves + 1 COOP profile saves

	- Ally HP + Location --> [Array:EntityData] 
	- Enemy HP (functional) + Location --> [Array:EntityData] 	

	- Checkpoints (some Chapters are split into Sections: eg. WrongTrain_A & WrongTrain_B, each with seperate checkpoints)
		- When "restarting" (PauseMenu->Restart) => the game restarts from the beginning of the Chapter Section
		- When dying => the game restarts from the Checkpoint
	- Checkpoints are non-existent in CO-OP mode (some Chapters are split into Sections: eg. WrongTrain_A & WrongTrain_B, each with seperate checkpoints)
		- When "restarting" (PauseMenu->Restart) => the game restarts from the beginning of the Chapter Section
		- When both players die at same time => the game restarts from the beginning of the Chapter Section

	- Chapters with multiple sections
		- Ch1 WrongTrain: Inside train -- On top of train
		- Ch3 Boneyard: Outside church -- Inside church Catacombs

	- UnlockFlags movies -> Correlated to Current StoryChapterID and endingflags

	- Versus Mode
		- 
*/

/* CONCEPT assets
	- Chapter leaderboards: "Wrong Train" Greenhorn Watchlist
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
RELEASE_REGIONS_SUPPORTED = [RELEASE_REGION_EUR, RELEASE_REGION_USA]

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

function util_getIndexOfLastItemInArray(array_a) =>
	length(array_a) - 1

function util_getLastItemInArray(array_a) =>
	array_a[util_getIndexOfLastItemInArray(array_a)]

function util_generateArrayOfIntegers_startAtZero(int_lastInteger) {
	let_array_Integers = []
	for let_index in range(0, int_lastInteger) 
		array_push(let_array_Integers, let_index)
	return let_array_Integers}

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
	"Pointer:PlayerSavedStats": {
		"pointerChainToMember": {
			"Array:SavedStats_Story": {
				"pointerChainOffsets": [0x4]},
			"Array:SavedStats_Gunslinger": {
				"pointerChainOffsets": [0xC]},
			},
		}, 
	"Pointer:SofdecStreamData": {
		"pointerChainToMember": {
			"ASCIIFlag:Sofdec_IsFMVactive": {
				"offsetToPointedToMember": 0x12C},
			"ASCII:Sofdec_FMVID": {
				"offsetToPointedToMember": 0x14C},
			},
		},
	"Pointer:LevelID": {
		"pointerChainToMember": {
			"ASCII:LevelID(full)": {
				"pointerChainOffsets": [0x20],
				"offsetToPointedToMember": 0x2},
			"ASCII:StoryChapterSectionID(preferred)": {
				"pointerChainOffsets": [0x24],
				"offsetToPointedToMember": 0x2}
			},
		},
	"Pointer:PlayerInput": {
		"offsetToMember": {
			"Struct(ControllerInput):Controller-1": 0x4,
			"Struct(ControllerInput):Controller-2": 0x38},
		},
	"Pointer:HUDcontrol_Health": {
		"pointerChainToMember": {
			"BitFlag:IsBossHPbarDisplayed": {
				"pointerChainOffsets": [0xC, 0x8, 0xC, 0x2C, 0x2F]},
			"Float:BossHP(display)(preferred)": {
				"pointerChainOffsets": [0xC, 0x8, 0xC, 0x2C, 0xEC]},
			},
		}, 
	"Pointer:UIcontrol": {
		"pointerChainToMember": {
			"Lower4:ActiveMenuPointerIndex": {
				"pointerChainOffsets": [0x8]},
			"Array:UIcontrolPointers": {
				"pointerChainOffsets": [0xC]},
			"Pointer:UIcontrol_ptr-L2_A": {
				"pointerChainOffsets": [0xC, 0x0]},
			// ------[Pointer:UIcontrol_ptr-L2_A].[Struct:MainMenuControl]------
			"ASCII:MainMenuSubMenuID": {
				"pointerChainOffsets": [0xC, 0x0, 0x30],
				"offsetToPointedToMember": 0x2},
			"32-bit:MainMenuTitle_TextLookupKeyID": {
				"pointerChainOffsets": [0xC, 0x0, 0xC, 0x0, 0x48]},				
			},
		}, 	
	"Struct:ChapterStats": {
		"sizeInBytes": 56,
		"offsetToMember": {
			"32-bit:MissionTime": 0x8,
			"Lower4:Difficulty": 0x14},
		"pointerChainToMember": {
			"ASCII:LevelID": {
				"pointerChainOffsets": [0x0],
				"offsetToPointedToMember": 0x2},
			},
		},
	"Struct:ControllerInput": {
		"offsetToMember": {
			"Bitflag:IsControllerConnected": 0x0,
			"BitFlag:IsInputPressed_Cross": 0xB},
		},
	"Struct:MainUIdata": {
		"pointerChainToMember": {
			"32-bit:LoadingState": {
				"pointerChainOffsets": {
					RELEASE_REGION_USA: [0x510],
					RELEASE_REGION_EUR: [0x450]}},
			},
		},
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
	
	"Lower4:PlayerCount(preferred)": {RELEASE_REGION_USA: 0x8ff494, RELEASE_REGION_EUR: 0x911474, RELEASE_REGION_JPN: sNULL},
	"Lower4:GameMode": {RELEASE_REGION_USA: 0x8ff510, RELEASE_REGION_EUR: 0x9114f0, RELEASE_REGION_JPN: sNULL},
	"Lower4:DifficultyID(preferred)": {RELEASE_REGION_USA: 0x953c9c, RELEASE_REGION_EUR: 0x965c7c, RELEASE_REGION_JPN: sNULL},
	
	// "8-bit:InProgress_StoryChapterID": {RELEASE_REGION_USA: 0x953d18, RELEASE_REGION_EUR: 0x965cf8, RELEASE_REGION_JPN: sNULL}, // DISABLED - Unused
	"8-bit:GameState": {RELEASE_REGION_USA: 0x729330, RELEASE_REGION_EUR: 0x73b430, RELEASE_REGION_JPN: sNULL},
	"8-bit:AlwaysNULL": {RELEASE_REGION_USA: 0x71fcf0, RELEASE_REGION_EUR: 0x7215f0, RELEASE_REGION_JPN: sNULL},

	"32-bit:Checkpoint_RespawnPointID(preferred)": {RELEASE_REGION_USA: 0x7f585c, RELEASE_REGION_EUR: 0x80783c, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_Temp": {RELEASE_REGION_USA: 0x953C28, RELEASE_REGION_EUR: 0x965c08, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_ChapterSection": {RELEASE_REGION_USA: 0x953C90, RELEASE_REGION_EUR: 0x965c70, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_ChapterTotal": {RELEASE_REGION_USA: 0x953C5C, RELEASE_REGION_EUR: 0x965c3c, RELEASE_REGION_JPN: sNULL},

	"32-bit:EquippedWeapon_WeaponID-Player1": {RELEASE_REGION_USA: 0x953C24, RELEASE_REGION_EUR: 0x965c04, RELEASE_REGION_JPN: sNULL},
	"32-bit:PlayerDeaths_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953C94, RELEASE_REGION_EUR: 0x965c74, RELEASE_REGION_JPN: sNULL},
	"32-bit:PlayerDeaths_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953C60, RELEASE_REGION_EUR: 0x965c40, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_Temp-Player1": {RELEASE_REGION_USA: 0x953C3C, RELEASE_REGION_EUR: 0x965c1c, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953CA4, RELEASE_REGION_EUR: 0x965c84, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953C70, RELEASE_REGION_EUR: 0x965c50, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_Temp-Player1": {RELEASE_REGION_USA: 0x953C40, RELEASE_REGION_EUR: 0x965c20, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953CA8, RELEASE_REGION_EUR: 0x965c88, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953c74, RELEASE_REGION_EUR: 0x965c54, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_Temp-Player1": {RELEASE_REGION_USA: 0x953C44, RELEASE_REGION_EUR: 0x965c24, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953CAC, RELEASE_REGION_EUR: 0x965c8c, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953c78, RELEASE_REGION_EUR: 0x965C58, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_Temp-Player1": {RELEASE_REGION_USA: 0x953C48, RELEASE_REGION_EUR: 0x965c28, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953CB0, RELEASE_REGION_EUR: 0x965c90, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953C7C, RELEASE_REGION_EUR: 0x965c5c, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_Temp-Player1": {RELEASE_REGION_USA: 0x953C4C, RELEASE_REGION_EUR: 0x965c2c, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_ChapterSection-Player1": {RELEASE_REGION_USA: 0x953CB4, RELEASE_REGION_EUR: 0x965c94, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_ChapterTotal-Player1": {RELEASE_REGION_USA: 0x953C80, RELEASE_REGION_EUR: 0x965c60, RELEASE_REGION_JPN: sNULL},

	"32-bit:EquippedWeapon_WeaponID-Player2": {RELEASE_REGION_USA: 0x953D50, RELEASE_REGION_EUR: 0x965d30, RELEASE_REGION_JPN: sNULL},
	"32-bit:PlayerDeaths_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DC0, RELEASE_REGION_EUR: 0x965DA0, RELEASE_REGION_JPN: sNULL},
	"32-bit:PlayerDeaths_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953D8C, RELEASE_REGION_EUR: 0x965D6C, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_Temp-Player2": {RELEASE_REGION_USA: 0x953D68, RELEASE_REGION_EUR: 0x965D48, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DD0, RELEASE_REGION_EUR: 0x965DB0, RELEASE_REGION_JPN: sNULL},
	"32-bit:Kills_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953D9C, RELEASE_REGION_EUR: 0x965D7C, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_Temp-Player2": {RELEASE_REGION_USA: 0x953D6C, RELEASE_REGION_EUR: 0x965D4C, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DD4, RELEASE_REGION_EUR: 0x965DB4, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsFired_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953DA0, RELEASE_REGION_EUR: 0x965D80, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_Temp-Player2": {RELEASE_REGION_USA: 0x953D70, RELEASE_REGION_EUR: 0x965D50, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DD8, RELEASE_REGION_EUR: 0x965DB8, RELEASE_REGION_JPN: sNULL},
	"32-bit:ShotsHit_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953DA4, RELEASE_REGION_EUR: 0x965D84, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_Temp-Player2": {RELEASE_REGION_USA: 0x953D74, RELEASE_REGION_EUR: 0x965D54, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DDC, RELEASE_REGION_EUR: 0x965DBC, RELEASE_REGION_JPN: sNULL},
	"32-bit:HeadshotKills_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953DA8, RELEASE_REGION_EUR: 0x965D88, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_Temp-Player2": {RELEASE_REGION_USA: 0x953D78, RELEASE_REGION_EUR: 0x965D58, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_ChapterSection-Player2": {RELEASE_REGION_USA: 0x953DE0, RELEASE_REGION_EUR: 0x965DC0, RELEASE_REGION_JPN: sNULL},
	"32-bit:MeleeKills_ChapterTotal-Player2": {RELEASE_REGION_USA: 0x953DAC, RELEASE_REGION_EUR: 0x965D8C, RELEASE_REGION_JPN: sNULL},

	"ASCII:GameID": {RELEASE_REGION_USA: 0x71fccc, RELEASE_REGION_EUR: 0x7215cc, RELEASE_REGION_JPN: sNULL},
	"ASCII:CheckpointID": {RELEASE_REGION_USA: 0x95b042, RELEASE_REGION_EUR: 0x96d022, RELEASE_REGION_JPN: sNULL},

	"Pointer:SofdecStreamData(preferred)": {RELEASE_REGION_USA: 0x134214, RELEASE_REGION_EUR: 0x134214, RELEASE_REGION_JPN: sNULL},
	"Pointer:MainUIdata_A": {RELEASE_REGION_USA: 0x71faf0, RELEASE_REGION_EUR: 0x7213f0, RELEASE_REGION_JPN: sNULL},
	"Pointer:LevelID(preferred)": {RELEASE_REGION_USA: 0x71ff20, RELEASE_REGION_EUR: 0x721820, RELEASE_REGION_JPN: sNULL},
	"Pointer:ControllerInput(preferred)": {RELEASE_REGION_USA: 0x720000, RELEASE_REGION_EUR: 0x721900, RELEASE_REGION_JPN: sNULL},
	"Pointer:UIcontrol(preferred)": {RELEASE_REGION_USA: 0x721fb8, RELEASE_REGION_EUR: 0x7238b8, RELEASE_REGION_JPN: sNULL},

	"Pointer:HUDcontrol_Health-Player1": {RELEASE_REGION_USA: 0x953d4c, RELEASE_REGION_EUR: 0x965d2c, RELEASE_REGION_JPN: sNULL},
	"Pointer(EntityData_B):PlayerActorData-Player1": {RELEASE_REGION_USA: 0x953ce4, RELEASE_REGION_EUR: 0x965cc4, RELEASE_REGION_JPN: sNULL},
	"Pointer:PlayerSavedStats-Player1": {RELEASE_REGION_USA: 0x953CF8, RELEASE_REGION_EUR: 0x965cd8, RELEASE_REGION_JPN: sNULL},
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

function is_ReleaseRegion(enum_releaseRegion) {
	let_string_GameID = sNULL
	if(enum_releaseRegion == RELEASE_REGION_USA) let_string_GameID = "SLUS" // FullString: "SLUS_210.42"
	else if(enum_releaseRegion == RELEASE_REGION_JPN) let_string_GameID = sNULL // FullString: "xxxxx"
	else if(enum_releaseRegion == RELEASE_REGION_EUR) let_string_GameID = "SLES" // FullString: "SLES_535.64"
	
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

// ...............
// ◦ Player Input ◦
// '''''''''''''''
// #region Player Input
CONTROLLER_1 = 1
CONTROLLER_2 = 2

INPUT_Cross = "BitFlag:IsInputPressed_Cross"

function current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return bit0(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", enum_input)
	)}

function prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) =>
	prev(current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion))

function on_PlayerInput_press(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) > prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion)

function on_PlayerInput_release(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) < prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion)

// ----------------Divider---------------------

// #endregion Player Input

// ......................
// ◦ General Game Logic ◦
// ''''''''''''''''''''''
// #region General Game Logic
CONST_LOADING_STATE_Loading = {RELEASE_REGION_USA: 0x10000048, RELEASE_REGION_EUR: 0x1000003C, RELEASE_REGION_JPN: sNULL}
CONST_GAME_STATE_AnyInGameMenu_active = 0x3

// #region MainMenu SubMenu Identification
// -----------------MainMenu SubMenu Identification--------------------
MAINMENU_SUBMENU_StatisticsMenu = "profile_statistics"
MAINMENU_SUBMENU_DifficultySelectMenu = "difficulty_select"
MAINMENU_SUBMENU_ChapterSelectMenu = "chapter_select"
TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger = 0x0F9681AA

function current_MainMenu_SubMenuTitle(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Pointer:UIcontrol", "32-bit:MainMenuTitle_TextLookupKeyID", let_memAddr_BasePointer)}

function prev_MainMenu_SubMenuTitle(enum_releaseRegion) =>
	prev(current_MainMenu_SubMenuTitle(enum_releaseRegion))
	
function on_MainMenu_SubMenuTitle_changeTo(enum_textLookupKey, enum_releaseRegion) =>
	current_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_textLookupKey
	&& prev_MainMenu_SubMenuTitle(enum_releaseRegion) != enum_textLookupKey
	
function on_MainMenu_SubMenuTitle_changeFrom(enum_textLookupKey, enum_releaseRegion) =>
	current_MainMenu_SubMenuTitle(enum_releaseRegion) != enum_textLookupKey
	&& prev_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_textLookupKey

function on_MainMenu_newSubMenu(enum_releaseRegion) {
	// NOTE: When a new MainMenuSubMenu is created AND an old MainMenuSubMenu is cleared, [Pointer:UIcontrol_ptr-L2_A] changes values; 
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_memAccessor_SubPointer = memGenerate_pointerChainAccessor("Pointer:UIcontrol", "Pointer:UIcontrol_ptr-L2_A", let_memAddr_BasePointer)
	return let_memAccessor_SubPointer != prev(let_memAccessor_SubPointer)}

function is_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_memAddr_ASCII_MainMenuSubMenuID =  
		memGenerate_pointerChainAccessor("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID")
	return is_ASCII_EqualTo(let_memAddr_ASCII_MainMenuSubMenuID, enum_mainMenuSubMenuID)}

function wasPrev_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_memAddr_ASCII_MainMenuSubMenuID =  
		memGenerate_pointerChainAccessor("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID")
	return wasPrev_ASCII_EqualTo(let_memAddr_ASCII_MainMenuSubMenuID, enum_mainMenuSubMenuID)}

function on_MainMenu_SubMenu_render(enum_mainMenuSubMenuID, enum_textLookupKey, enum_releaseRegion) =>
	is_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion)
	&& current_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_textLookupKey
	&& on_MainMenu_newSubMenu(enum_releaseRegion)

function on_MainMenu_SubMenu_close(enum_mainMenuSubMenuID, enum_textLookupKey, enum_releaseRegion) =>
	wasPrev_MainMenu_SubMenuID(MAINMENU_SUBMENU_StatisticsMenu, enum_releaseRegion)
	&& prev_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_textLookupKey
	&& on_MainMenu_newSubMenu(enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_render(enum_releaseRegion) => 
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_render(MAINMENU_SUBMENU_StatisticsMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion) => // NOTE: This triggers earlier than on_MainMenu_PostChapterGunslingerStatsMenu_close()
	is_atMainMenu(enum_releaseRegion)
	&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_StatisticsMenu, enum_releaseRegion)
	&& current_MainMenu_SubMenuTitle(enum_releaseRegion) == TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_close(enum_releaseRegion) => // NOTE: This triggers later than on_MainMenu_PostChapterGunslingerStatsMenu_continue()
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_close(MAINMENU_SUBMENU_StatisticsMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function on_MainMenu_GunslingerChapterSelectMenu_render(enum_releaseRegion) =>
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_render(MAINMENU_SUBMENU_ChapterSelectMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion) => // NOTE: This triggers when selecting a difficulty, thus starting the Chapter
	is_atMainMenu(enum_releaseRegion)
	&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_DifficultySelectMenu, enum_releaseRegion)
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)


// #endregion MainMenu SubMenu Identification
// #region Game Modes
// ----------------GameModes---------------------
function current_PlayerCount(enum_releaseRegion) =>
	low4(memory_getAddress("Lower4:PlayerCount(preferred)", enum_releaseRegion))

function current_GameMode(enum_releaseRegion) =>
	low4(memory_getAddress("Lower4:GameMode", enum_releaseRegion))

function is_InSinglePlayerMode(enum_releaseRegion) {
	const_GAMEMODE_SinglePlayer = 0 // NOTE: same GameModeID as MultiplayerCoop
	return 
		current_PlayerCount(enum_releaseRegion) == 1
		&& current_GameMode(enum_releaseRegion) == const_GAMEMODE_SinglePlayer
	}

function is_InGunslingerMode(enum_releaseRegion) {
	const_GAMEMODE_Gunslinger = 1
	return 
		current_PlayerCount(enum_releaseRegion) == 1
		&& current_GameMode(enum_releaseRegion) == const_GAMEMODE_Gunslinger
	}

function is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion) {
	const_GAMEMODE_Gunslinger = 1
	return 
		current_PlayerCount(enum_releaseRegion) == 1
		&& current_GameMode(enum_releaseRegion) <= const_GAMEMODE_Gunslinger // --CheckIf--> GameMode is 0 OR 1 (SinglePlayer OR Gunslinger)
	}

function is_InMultiplayerVersusMode(enum_releaseRegion) {
	const_GAMEMODE_MultiplayerVersus = 3
	return 
		current_PlayerCount(enum_releaseRegion) == 1
		&& current_GameMode(enum_releaseRegion) == const_GAMEMODE_MultiplayerVersus
	}

function is_InMultiplayerCoopMode(enum_releaseRegion) {
	const_GAMEMODE_MultiplayerCoop = 0 // NOTE: same GameModeID as SinglePlayer
	return 
		current_PlayerCount(enum_releaseRegion) == 1
		&& current_GameMode(enum_releaseRegion) == const_GAMEMODE_MultiplayerCoop
	}
// #endregion Game Modes
// #region Game States
// ----------------LoadingState---------------------
function current_LoadingState(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:MainUIdata_A", enum_releaseRegion)
	return memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:MainUIdata", "32-bit:LoadingState", 
		let_memAddr_BasePointer, enum_releaseRegion,
		memAccessorFunction_toPointedToMember = dword)
	}

function prev_LoadingState(enum_releaseRegion) =>
	prev(current_LoadingState(enum_releaseRegion))

function is_Loading(enum_releaseRegion) => 
	current_LoadingState(enum_releaseRegion) == CONST_LOADING_STATE_Loading[enum_releaseRegion]

function on_Loading_start(enum_releaseRegion) =>
	current_LoadingState(enum_releaseRegion) == CONST_LOADING_STATE_Loading[enum_releaseRegion]
	&& prev_LoadingState(enum_releaseRegion) != CONST_LOADING_STATE_Loading[enum_releaseRegion]

function on_Loading_end(enum_releaseRegion) =>
	current_LoadingState(enum_releaseRegion) != CONST_LOADING_STATE_Loading[enum_releaseRegion]
	&& prev_LoadingState(enum_releaseRegion) == CONST_LOADING_STATE_Loading[enum_releaseRegion]
// ----------------Other Game States---------------------
function current_pointerState_PlayerActorData(enum_releaseRegion) {
	let_memAddr_Pointer = memory_getAddress("Pointer(EntityData_B):PlayerActorData-Player1", enum_releaseRegion)
	return dword(let_memAddr_Pointer)}

function prior_pointerState_PlayerActorData(enum_releaseRegion) =>
	prior(current_pointerState_PlayerActorData(enum_releaseRegion))

function wasPrior_flagState_InGame_true(enum_releaseRegion) =>
	prior_pointerState_PlayerActorData(enum_releaseRegion) != 0

function prev_pointerState_PlayerActorData(enum_releaseRegion) =>
	prev(current_pointerState_PlayerActorData(enum_releaseRegion))

function is_flagState_InGame_true(enum_releaseRegion) =>
	current_pointerState_PlayerActorData(enum_releaseRegion) != 0

function is_flagState_InGame_false(enum_releaseRegion) =>
	current_pointerState_PlayerActorData(enum_releaseRegion) == 0	

function on_flagState_InGame_toggleTrue(enum_releaseRegion) =>
	current_pointerState_PlayerActorData(enum_releaseRegion) != 0x0
	&& prev_pointerState_PlayerActorData(enum_releaseRegion) == 0x0

function on_flagState_InGame_toggleFalse(enum_releaseRegion) =>
	current_pointerState_PlayerActorData(enum_releaseRegion) == 0x0
	&& prev_pointerState_PlayerActorData(enum_releaseRegion) != 0x0

function current_GameState(enum_releaseRegion) =>
	byte(memory_getAddress("8-bit:GameState", enum_releaseRegion))

function prior_GameState(enum_releaseRegion) =>
	prior(current_GameState(enum_releaseRegion))

function prev_GameState(enum_releaseRegion) =>
	prev(current_GameState(enum_releaseRegion))

function is_AnyInGameMenu_active(enum_releaseRegion) =>
	current_GameState(enum_releaseRegion) == CONST_GAME_STATE_AnyInGameMenu_active

function on_AnyInGameMenu_deactivate(enum_releaseRegion) =>
	current_GameState(enum_releaseRegion) != CONST_GAME_STATE_AnyInGameMenu_active
	&& prev_GameState(enum_releaseRegion) == CONST_GAME_STATE_AnyInGameMenu_active

// #endregion Game States
// #region Pause Menu
// -----------------PauseMenu--------------------
TEXTLOOKUPKEY_PauseMenu_FrameTitle_Paused = 0xE5E853D8
TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart = 0x33E14BF8
TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit = 0x8B239878
TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower = 0x9EB09A69
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_SilverBullet = 0x8BBEEDB1
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_Fear = 0x2AD14BD8
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_MysticArmor = 0x337DD749
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_Vindicator = 0x76E981F2
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_BloodFrenzy = 0xBE5D5443
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_Turn = 0xC6607CC3
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_BlackShroud = 0x8657504F
TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_SoulStealer = 0xEC61D4E0

function is_PauseMenu_active(enum_releaseRegion) =>
	is_AnyInGameMenu_active(enum_releaseRegion)
	/* MANUAL_CONSTRUCTION[FF] of above 2 lines: R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX00000118_0xX0000006c=3857208280
		NTSCU: 	xxxx

		AddAddress	[Pointer:UIcontrol(preferred)]
		Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
		Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

		AddAddress	[Pointer:UIcontrol(preferred)]
		AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
		Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
		
		AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0x118
					->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_PauseMenu_FrameTitle_Paused 	| CheckIf: FrameTitle == "Paused"
		*/
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0xFF)

function on_PauseMenu_Restart(enum_releaseRegion) =>
	is_AnyInGameMenu_active(enum_releaseRegion)
	/* MANUAL_CONSTRUCTION[1FD-2FD]: R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=870403064_I:{recall}_I:0xX0000007c_0xX00000068=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=870403064_I:{recall}_I:0xX0000007c_0xX00000068=1
		---------
		AddAddress	[Pointer:UIcontrol(preferred)]
		Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
		Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

		AddAddress	[Pointer:UIcontrol(preferred)]
		AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
		Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
		
		AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0xB8
					->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 	| CheckIf: FrameTitle == "Restart"
		
		AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0x7C
					->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_RestartConfirmationMenu_Yes_highlighted()
		*/
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1FD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == 0xDEADBEEF
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2FD)
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

function on_PauseMenu_Quit(enum_releaseRegion) =>
	is_AnyInGameMenu_active(enum_releaseRegion)
	/* MANUAL_CONSTRUCTION[1FD-3FD]: R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1
		-----------
		AddAddress	[Pointer:UIcontrol(preferred)]
		Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
		Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

		AddAddress	[Pointer:UIcontrol(preferred)]
		AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
		Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
		
		AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0xB8
					->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 	| CheckIf: FrameTitle == "Quit"
		
		AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0x7C
					->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()
		*/
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1FD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == 0xDEADBEEF
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x3FD)

	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

function on_PauseMenu_Restart_OR_Quit(enum_releaseRegion) =>
	is_AnyInGameMenu_active(enum_releaseRegion)
	/* MANUAL_CONSTRUCTION[1FD-4FD]: R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1
		-----------
		AddAddress	[Pointer:UIcontrol(preferred)]
		Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
		Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

		AddAddress	[Pointer:UIcontrol(preferred)]
		AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
		Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
		
		AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0xB8
		OrNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 	| CheckIf: FrameTitle == "Restart"
		
		AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0xB8
					->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
		
		AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
		AddAddress	->[Mem 32-bit] 0x7C
					->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()
		*/
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1FD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == 0xDEADBEEF
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x4FD)
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

// #endregion Pause Menu
// #endregion General Game Logic

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
		// "ChapterSectionIDs": ["_Section1_", "_Section2_"],
		// "IsGunslingerLevel": true,
		// },
	CHAPTER_1_WrongTrain: {
		"LevelID": "WrongTrain",
		"ChapterSectionIDs": ["WrongTrain_A", "WrongTrain_B"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_2_RideDevil: {
		"LevelID": "M02_CanyonShoot",
		"ChapterSectionIDs": ["Hub_A"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_3_Boneyard: {
		"LevelID": "M03_Cemetery",
		"ChapterSectionIDs": ["M03_C", "M03_B", "M03_A"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_4_DevilMine: {
		"LevelID": "M05_DevilsBelly",
		"ChapterSectionIDs": ["Hub_A", "Hub_B", "Hub_C", "Hub_D"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_5_Outpost: {
		"LevelID": "M07_DWOutpost",
		"ChapterSectionIDs": ["M07_A", "M07_B"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_6_WarTrain: {
		"LevelID": "Wartrain",
		"ChapterSectionIDs": ["M07_C"],
		"IsGunslingerLevel": true,
		}, 
	CHAPTER_7_TortureMaze: {
		"LevelID": "M09_TortureMaze",
		"ChapterSectionIDs": ["M09_A", "M09_B", "M09_C", "M09_D", "M09_E", "M09_F"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_8_BaptismFire: {
		"LevelID": "M10_TradingPost",
		"ChapterSectionIDs": ["M10_A", "M10_B", "M10_C", "M10_D"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_Citadel: {
		"LevelID": "Citadel_Launch",
		"ChapterSectionIDs": ["Citadel_Launch_AA"],
		"IsGunslingerLevel": false,
		},
	CHAPTER_9_Rescue: {
		"LevelID": "M08_Regulator",
		"ChapterSectionIDs": ["Hub_A", "Hub_B"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_10_Prism: {
		"LevelID": "M15_SplittingPaths",
		"ChapterSectionIDs": ["M15_D", "M15_E", "M15_F", "M15_A", "M15_C"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_11_Invasion: {
		"LevelID": "M17_Invasion",
		"ChapterSectionIDs": ["M17_B", "M17_C", "M17_D"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_12_Hangtown: {
		"LevelID": "M11_Hangtown",
		"ChapterSectionIDs": ["M11_F", "M11_G", "M11_H"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_13_MorningAfter: {
		"LevelID": "M12_CitadelUnderAttack",
		"ChapterSectionIDs": ["M12_AA", "M12_B", "M12_C", "M12_D", "M12_A"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_14_Showdown: {
		"LevelID": "FallOfCitadel",
		"ChapterSectionIDs": ["FallOfCitadel_A", "FallOfCitadel_B"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_15_RightTrain: {
		"LevelID": "M19_RidetoDeadfall",
		"ChapterSectionIDs": ["M19_A"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_16_Deadfall: {
		"LevelID": "M20_PenetratingDeadfall",
		"ChapterSectionIDs": ["Hub_A", "Hub_B", "Hub_B2", "Hub_C", "Hub_C2"],
		"IsGunslingerLevel": true,
		},
	CHAPTER_17_CurseWest: {
		"LevelID": "GroundZero",
		"ChapterSectionIDs": ["GroundZero_A"],
		"IsGunslingerLevel": true,
		},
	}

function LEVEL_DATA_getLevelID(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["LevelID"]

function LEVEL_DATA_getChapterSectionID(enum_chapter, enum_chapterSection) =>
	CONST_LEVEL_DATA[enum_chapter]["ChapterSectionIDs"][enum_chapterSection]

function LEVEL_DATA_getAllChapterSectionIDs(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["ChapterSectionIDs"]

function LEVEL_DATA_getFirstChapterSectionID(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["ChapterSectionIDs"][CHAPTER_SECTION_1]

function LEVEL_DATA_getLastChapterSectionIndex(enum_chapter) {
	let_array_AllChapterSectionIDs = LEVEL_DATA_getAllChapterSectionIDs(enum_chapter)
	return util_getIndexOfLastItemInArray(let_array_AllChapterSectionIDs)}

function LEVEL_DATA_IsChapterGunslingerLevel(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["IsGunslingerLevel"]

function LEVEL_DATA_getAllGunslingerLevels() => 
	array_filter(CONST_LEVEL_DATA, enum_chapter => LEVEL_DATA_IsChapterGunslingerLevel(enum_chapter))

// ----------------StoryChapterID---------------------
/* DISABLED - Not advised to use this
function current_InProgressStoryChapterID(enum_releaseRegion) =>
	byte(memory_getAddress("8-bit:InProgress_StoryChapterID", enum_releaseRegion))

function prev_InProgressStoryChapterID(enum_releaseRegion) =>
	prev(current_InProgressStoryChapterID(enum_releaseRegion))

function is_StoryChapterID(enum_chapter, enum_releaseRegion) =>
	current_InProgressStoryChapterID(enum_releaseRegion) == enum_chapter

function on_StoryChapter_complete(enum_chapter, enum_releaseRegion) =>
	current_InProgressStoryChapterID(enum_releaseRegion) == enum_chapter + 1
	&& prev_InProgressStoryChapterID(enum_releaseRegion) == enum_chapter

function is_GunslingerChapter_available(enum_chapter, enum_releaseRegion) {
	return current_InProgressStoryChapterID(enum_releaseRegion) >= enum_chapter + 1} // --CheckIf--> next chapter is inProgress in SinglePlayer Mode
*/

// ----------------ChapterSectionID---------------------
function is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:LevelID(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:LevelID", "ASCII:StoryChapterSectionID(preferred)", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:LevelID", "ASCII:StoryChapterSectionID(preferred)")
	let_string_ChapterSectionID = LEVEL_DATA_getChapterSectionID(enum_chapter, enum_chapterSection) // NOTE: Only checks [1-byte] of ASCII

	if(enum_chapter == CHAPTER_13_MorningAfter || enum_chapter == CHAPTER_16_Deadfall) { // NOTE: These Chapters require an extra check (eg. CHAPTER_13_MorningAfter has ChapterSectionIDs: "M12_AA" and "M12_A")
		return 
			is_ASCII_EqualTo(let_memAddr_ASCII, let_string_ChapterSectionID)
			&& byte(let_memAddr_ASCII + length(let_string_ChapterSectionID)) == 0 // --CheckIf--> The byte after the ASCIIstring is zeroed out (0x0)
	} else {
		return is_ASCII_EqualTo(let_memAddr_ASCII, let_string_ChapterSectionID)
	}}

// ----------------LevelID---------------------
function is_Level(string_levelID, enum_releaseRegion) {	
	let_memAddr_BasePointer = memory_getAddress("Pointer:LevelID(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:LevelID", "ASCII:LevelID(full)", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:LevelID", "ASCII:LevelID(full)")
	return is_ASCII_EqualTo(let_memAddr_ASCII, string_levelID)}

function is_Level_StoryChapter(enum_chapter, enum_releaseRegion) {
	let_substring_LevelID = substring(LEVEL_DATA_getLevelID(enum_chapter), 0, 4) // NOTE: Substring --> Only check [4-byte] of ASCII
	return is_Level(let_substring_LevelID, enum_releaseRegion)}

function is_Level_Multiplayer(enum_multiplayerLevel, enum_releaseRegion) {
	let_substring_LevelID = substring(enum_multiplayerLevel, 0, 4) // NOTE: Substring --> Only check [4-byte] of ASCII
	return is_Level(let_substring_LevelID, enum_releaseRegion)}

// #endregion Level ID

// .................
// ◦ Checkpoint ID ◦
// '''''''''''''''''
// #region Checkpoint ID
CHECKPOINT_1 = "1"
CHECKPOINT_2 = "2"
CHECKPOINT_3 = "3"
CHECKPOINT_4 = "4"

function current_RespawnPointID(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:Checkpoint_RespawnPointID(preferred)", enum_releaseRegion))

function prev_RespawnPointID(enum_releaseRegion) =>
	prev(current_RespawnPointID(enum_releaseRegion))

function is_CheckpointID(enum_checkpoint, enum_releaseRegion) {
	const_OFFSET_TO_UNIQUE_SUBSTRING = length("Checkpoint_")
	let_memAddr_ASCII = 
		memory_getAddress("ASCII:CheckpointID", enum_releaseRegion)
		+ const_OFFSET_TO_UNIQUE_SUBSTRING
	return is_ASCII_EqualTo(let_memAddr_ASCII, enum_checkpoint)}

function is_AnyCheckpoint_active(enum_releaseRegion) =>
	current_RespawnPointID(enum_releaseRegion) > 0

function on_Checkpoint_1_initialize(enum_releaseRegion) => // NOTE: This can be used to check if a StoryChapterSection/Level is started/restarted from the beginning 
	is_CheckpointID(CHECKPOINT_1, enum_releaseRegion)
	&& current_RespawnPointID(enum_releaseRegion) > 0 
	&& prev_RespawnPointID(enum_releaseRegion) == 0

function on_NewCheckpoint_initialize(enum_releaseRegion) =>
	current_RespawnPointID(enum_releaseRegion) != prev_RespawnPointID(enum_releaseRegion)

function is_Checkpoint_active(enum_checkpoint, enum_releaseRegion) =>
	is_AnyCheckpoint_active(enum_releaseRegion)
	&& is_CheckpointID(enum_checkpoint, enum_releaseRegion)

function on_Checkpoint_initialize(enum_checkpoint, enum_releaseRegion) =>
	is_CheckpointID(enum_checkpoint, enum_releaseRegion)
	&& on_NewCheckpoint_initialize(enum_releaseRegion)

// -------------------------------------
function on_FirstStoryChapterSection_start(enum_chapter, enum_releaseRegion) {
	let_firstChapterSection = LEVEL_DATA_getFirstChapterSectionID(enum_chapter)
	return
		is_ChapterSection(enum_chapter, let_firstChapterSection, enum_releaseRegion)
		&& on_NewCheckpoint_reached(enum_releaseRegion)}

function on_StoryChapterSection_start(enum_chapter, enum_chapterSection, enum_releaseRegion) =>
	is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion)
	&& on_Checkpoint_1_initialize(enum_releaseRegion)

function is_LastChapterSection_active(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastChapterSectionIndex(enum_chapter)
	return is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)}

function on_LastChapterSection_start(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastChapterSectionIndex(enum_chapter)
	return
		is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)
		&& on_Checkpoint_1_initialize(enum_releaseRegion)}

// #endregion Checkpoint ID

// ..............
// ◦ Statistics ◦
// ''''''''''''''
// #region Statistics
function current_MissionTime_Temp(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_Temp", enum_releaseRegion))

function prev_MissionTime_Temp(enum_releaseRegion) =>
	prev(current_MissionTime_Temp(enum_releaseRegion))

function on_MissionTime_Temp_start(enum_releaseRegion) =>
	current_MissionTime_Temp(enum_releaseRegion) > 0
	&& prev_MissionTime_Temp(enum_releaseRegion) == 0

function current_MissionTime_ChapterSection(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_ChapterSection", enum_releaseRegion))

function prev_MissionTime_ChapterSection(enum_releaseRegion) =>
	prev(current_MissionTime_ChapterSection(enum_releaseRegion))

function current_MissionTime_ChapterTotal(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_ChapterTotal", enum_releaseRegion))

function prev_MissionTime_ChapterTotal(enum_releaseRegion) =>
	prev(current_MissionTime_ChapterTotal(enum_releaseRegion))

function current_calculated_TotalMissionTime(enum_releaseRegion) =>
	current_MissionTime_Temp(enum_releaseRegion) + current_MissionTime_ChapterSection(enum_releaseRegion)
	
function prev_calculated_TotalMissionTime(enum_releaseRegion) =>
	prev(current_calculated_TotalMissionTime(enum_releaseRegion))

function on_calculated_TotalMissionTime_overflow(enum_releaseRegion) => // NOTE: Triggers when 32-bit overflow occurs; calculated_TotalMissionTime() increments based on FPS (25FPS increments by 40; 60FPS increments by 16.67)
	0xFFFFFFFF - 1000 <= prev_calculated_TotalMissionTime(enum_releaseRegion) // --> 1 second (= 1000ms) under 0xFFFFFFFF
	// && prev_calculated_TotalMissionTime(enum_releaseRegion) <= 0xFFFFFFFF // DISABLED - Line is alwaysTrue (unnecessary)
	// && 0x0 <= current_calculated_TotalMissionTime(enum_releaseRegion) // DISABLED - Line is alwaysTrue (unnecessary)
	&& current_calculated_TotalMissionTime(enum_releaseRegion) <= 0x0 + 1000 // --> 1 second (= 1000ms) above 0x0

// -------------------------------------
function on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion) =>
	is_Level_StoryChapter(enum_chapter, enum_releaseRegion)
	&& is_ChapterSection(enum_chapter, CHAPTER_SECTION_1, enum_releaseRegion)
	&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
	&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)

function on_ChapterSection_startFromBeginning(enum_chapter, enum_chapterSection, enum_releaseRegion) =>
	is_Level_StoryChapter(enum_chapter, enum_releaseRegion)
	&& is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion)
	&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)

function on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastChapterSectionIndex(enum_chapter)
	return 
		is_Level_StoryChapter(enum_chapter, enum_releaseRegion)
		&& is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)
		&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
		&& on_MissionTime_Temp_start(enum_releaseRegion)
	}

function on_AnyChapterSection_startFromBeginning(enum_releaseRegion) =>
	current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)

// #endregion Statistics

// ..........
// ◦ FMV ID ◦
// ''''''''''
// #region FMV ID
CONST_ASCII_FLAG_SofdecIsFMVactive_true = "Sofd" // FullString: "SofdecStream"
FMV_MainMenu = "PS2MAI"
FMV_Shadow = "M01S4_"
FMV_LazarusLives = "M02S1_"
FMV_CassidyDies = "M04S1_"
FMV_TheHaunting = "M05S1_"
FMV_GiddyUp = "M09S3_"
FMV_PromNight = "M11S2_"
FMV_Monster = "M22S4_"
FMV_Hero = "M22S3_"
FMV_Credits = "FINALD"

function is_anyFMV_active(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCIIFlag = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCIIFlag:Sofdec_IsFMVactive")
	return is_ASCII_EqualTo(let_memAddr_ASCIIFlag, CONST_ASCII_FLAG_SofdecIsFMVactive_true)}

function on_anyFMV_start(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCIIFlag = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCIIFlag:Sofdec_IsFMVactive")
	return 
		is_ASCII_EqualTo(let_memAddr_ASCIIFlag, CONST_ASCII_FLAG_SofdecIsFMVactive_true)
		&& wasPrev_ASCII_notEqualTo(let_memAddr_ASCIIFlag, CONST_ASCII_FLAG_SofdecIsFMVactive_true)}

function on_anyFMV_end(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCIIFlag = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCIIFlag:Sofdec_IsFMVactive")
	return 
		is_ASCII_notEqualTo(let_memAddr_ASCIIFlag, CONST_ASCII_FLAG_SofdecIsFMVactive_true)
		&& wasPrev_ASCII_EqualTo(let_memAddr_ASCIIFlag, CONST_ASCII_FLAG_SofdecIsFMVactive_true)}

function is_FMV_active(enum_fmv, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCII:Sofdec_FMVID")
	return 
		is_ASCII_EqualTo(let_memAddr_ASCII, enum_fmv)
		&& is_anyFMV_active(enum_releaseRegion)}

function on_FMV_start(enum_fmv, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCII:Sofdec_FMVID")
	return 
		is_ASCII_EqualTo(let_memAddr_ASCII, enum_fmv)
		&& on_anyFMV_start(enum_releaseRegion)}

function on_FMV_end(enum_fmv, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:SofdecStreamData(preferred)", enum_releaseRegion)
	let_memAddr_ASCII = dword(let_memAddr_BasePointer) + memory_getStruct_OffsetToPointedToMember("Pointer:SofdecStreamData", "ASCII:Sofdec_FMVID")
	return 
		wasPrev_ASCII_EqualTo(let_memAddr_ASCII, enum_fmv)
		&& on_anyFMV_end(enum_releaseRegion)}
// -------------------------------------
function is_atMainMenu(enum_releaseRegion) =>
	is_FMV_active(FMV_MainMenu, enum_releaseRegion)

// #endregion FMV ID

// ......................
// ◦ HUD Control Health ◦
// ''''''''''''''''''''''
// #region HUD Control Health
function current_flagState_IsBossHPbarDisplayed(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:HUDcontrol_Health-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:HUDcontrol_Health", "BitFlag:IsBossHPbarDisplayed", 
		let_memAddr_BasePointer, memAccessorFunction_toPointedToMember = bit0)
	}

function prev_flagState_IsBossHPbarDisplayed(enum_releaseRegion) =>
	prev(current_flagState_IsBossHPbarDisplayed(enum_releaseRegion))

function is_BossHealthBar_Display_active(enum_releaseRegion) =>
	current_flagState_IsBossHPbarDisplayed(enum_releaseRegion) == 1

function on_BossHealthBar_Display_render(enum_releaseRegion) =>
	current_flagState_IsBossHPbarDisplayed(enum_releaseRegion) > prev_flagState_IsBossHPbarDisplayed(enum_releaseRegion)

function on_BossHealthBar_Display_remove(enum_releaseRegion) => 
	current_flagState_IsBossHPbarDisplayed(enum_releaseRegion) < prev_flagState_IsBossHPbarDisplayed(enum_releaseRegion)

function current_Boss_Health(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:HUDcontrol_Health-Player1", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:HUDcontrol_Health", "Float:BossHP(display)(preferred)", 
		let_memAddr_BasePointer, memAccessorFunction_toPointedToMember = float)
	}

function prev_Boss_Health(enum_releaseRegion) =>
	prev(current_Boss_Health(enum_releaseRegion))

// ----------------Divider---------------------

// #endregion HUD Control Health

// ...............
// ◦ Player Data ◦
// '''''''''''''''
// #region Player Data
PLAYER_1 = "1"
PLAYER_2 = "2"
// #region Difficulty
// ----------------Difficulty---------------------
DIFFICULTY_Greenhorn = 0x0
DIFFICULTY_Cowboy = 0x1
DIFFICULTY_Shootist = 0x2
DIFFICULTY_Deadeye = 0x3

function is_DifficultyOrHarder(enum_difficulty, enum_releaseRegion) =>
	low4(memory_getAddress("Lower4:DifficultyID(preferred)", enum_releaseRegion)) >= enum_difficulty

// #endregion Difficulty
// #region Accuracy
// ----------------Accuracy---------------------
function current_ShotsFired_Temp(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_Temp-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_Temp(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_Temp-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}
	
function current_ShotsFired_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsFired_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}
// -------------------------------------
function current_calculated_Accuracy_FullTotal(enum_Player, enum_releaseRegion) => /* MANUAL_CONSTRUCTION(Function) - R/R usage
	PAL:	A:0xX00965c20+0xX00965c54_A:0xX00965c88_K:0_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_{recall}=3735928559
	NTSCU:	xxxx
	------------
	AddSource	[32-bit:ShotsFired_Temp] + [32-bit:ShotsFired_ChapterTotal]
	AddSource	[32-bit:ShotsFired_ChapterSection]
	Remember 	Val	0
	Remember	Recall / 1.0								--> Force 32-bit to Float
	AddSource	[32-bit:ShotsHit_Temp] / Recall				--> Divide by float, creates a float
	AddSource	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by float, creates a float
	Remember	[32-bit:ShotsHit_ChapterSection] / Recall	--> Divide by float, creates a float
				Recall == 0xDEADBEEF 							*/
	current_ShotsFired_Temp(enum_Player, enum_releaseRegion) 
	+ current_ShotsFired_ChapterTotal(enum_Player, enum_releaseRegion)
	+ current_ShotsFired_ChapterSection(enum_Player, enum_releaseRegion)
	+ current_ShotsHit_Temp(enum_Player, enum_releaseRegion) 
	+ current_ShotsHit_ChapterTotal(enum_Player, enum_releaseRegion)
	+ current_ShotsHit_ChapterSection(enum_Player, enum_releaseRegion)

function current_calculated_Accuracy_ChapterTotal(enum_Player, enum_releaseRegion) => /* MANUAL_CONSTRUCTION[Function] - R/R usage
	PAL:	K:0xX00965c54/f1.0_A:0xX00965c58/{recall}_f0.0=3735928559
	NTSCU:	xxxxx
	-------------
	Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
	AddSource	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by float, creates a float
				Float 0.0 == 0xDEADBEEF
	*/
	current_ShotsFired_ChapterTotal(enum_Player, enum_releaseRegion) 
	+ current_ShotsHit_ChapterTotal(enum_Player, enum_releaseRegion)
	

// #endregion Accuracy
// #region Other Stats
// ----------------PlayerDeaths---------------------
function current_PlayerDeaths_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:PlayerDeaths_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_PlayerDeaths_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:PlayerDeaths_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function prev_PlayerDeaths_ChapterSection(enum_Player, enum_releaseRegion) =>
	prev(current_PlayerDeaths_ChapterSection(enum_Player, enum_releaseRegion))

function prev_PlayerDeaths_ChapterTotal(enum_Player, enum_releaseRegion) =>
	prev(current_PlayerDeaths_ChapterTotal(enum_Player, enum_releaseRegion))

function on_PlayerDeaths_ChapterSection_increment(enum_Player, enum_releaseRegion) =>
	current_PlayerDeaths_ChapterSection(enum_Player, enum_releaseRegion) > prev_PlayerDeaths_ChapterSection(enum_Player, enum_releaseRegion)

function on_PlayerDeaths_ChapterTotal_increment(enum_Player, enum_releaseRegion) =>
	current_PlayerDeaths_ChapterTotal(enum_Player, enum_releaseRegion) > prev_PlayerDeaths_ChapterTotal(enum_Player, enum_releaseRegion)

// ----------------Kills---------------------
function current_Kills_Temp(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_Temp-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_Kills_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_Kills_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_Kills_FullTotal(enum_Player, enum_releaseRegion) =>
	current_Kills_Temp(enum_Player, enum_releaseRegion)
	+ current_Kills_ChapterSection(enum_Player, enum_releaseRegion)
	+ current_Kills_ChapterTotal(enum_Player, enum_releaseRegion)

// ----------------HeadshotKills---------------------
function current_HeadshotKills_Temp(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_Temp-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_HeadshotKills_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_HeadshotKills_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_HeadshotKills_FullTotal(enum_Player, enum_releaseRegion) =>
	current_HeadshotKills_Temp(enum_Player, enum_releaseRegion)
	+ current_HeadshotKills_ChapterSection(enum_Player, enum_releaseRegion)
	+ current_HeadshotKills_ChapterTotal(enum_Player, enum_releaseRegion)

// ----------------MeleeKills---------------------
function current_MeleeKills_Temp(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_Temp-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_MeleeKills_ChapterSection(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_ChapterSection-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_MeleeKills_ChapterTotal(enum_Player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_ChapterTotal-Player{0}", enum_Player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_MeleeKills_FullTotal(enum_Player, enum_releaseRegion) =>
	current_MeleeKills_Temp(enum_Player, enum_releaseRegion)
	+ current_MeleeKills_ChapterSection(enum_Player, enum_releaseRegion)
	+ current_MeleeKills_ChapterTotal(enum_Player, enum_releaseRegion)


// #endregion Other Stats

// #region Saved Stats
// ----------------SavedStats_Gunslinger---------------------
CONST_NUMBER_OF_CHAPTERS = length(LEVEL_DATA_getAllGunslingerLevels()) // = 17

function current_SavedStatGunslinger_Difficulty(int_savedStatIndex, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_array_pointerChainOffsets = memory_getStruct_offsetSequenceToMember("Pointer:PlayerSavedStats", "Array:SavedStats_Gunslinger")
	let_offsetTo_SaveStat_Difficulty = memory_getStruct_OffsetToMember("Struct:ChapterStats", "Lower4:Difficulty") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * int_savedStatIndex)
	array_push(let_array_pointerChainOffsets, let_offsetTo_SaveStat_Difficulty)

	return memGenerate_pointerChainAccessor_fromOffsets(
		let_memAddr_BasePointer, let_array_pointerChainOffsets, 
		memAccessorFunction_toPointedToMember = low4)
	}

// #region Saved Stats

// #endregion Player Data

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
	
	"c_SPstory": { // Category - Singleplayer Story Progression
		// "a_WrongTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504289, "points": 0000000, "devInfo": "CHAPTER_1_WrongTrain Completion"}, 
		// "a_RideDevil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504290, "points": 0000000, "devInfo": "CHAPTER_2_RideDevil Completion"},
		// "a_Boneyard": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504291, "points": 0000000, "devInfo": "CHAPTER_3_Boneyard Completion"},
		// "a_DevilMine": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504292, "points": 0000000, "devInfo": "CHAPTER_4_DevilMine Completion"},
		// "a_DWOutpost": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504293, "points": 0000000, "devInfo": "CHAPTER_5_Outpost Completion"},
		// "a_WarTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504294, "points": 0000000, "devInfo": "C:HAPTER_6_WarTrain Completion"}, 
		// "a_TortureMaze": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504295, "points": 0000000, "devInfo": "CHAPTER_7_TortureMaze Completion"}, 
		// "a_BaptismFire": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504296, "points": 0000000, "devInfo": "CHAPTER_8_BaptismFire Completion"}, 
		// "a_Rescue": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504297, "points": 0000000, "devInfo": "CHAPTER_9_Rescue Completion"},
		// "a_Prism": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504298, "points": 0000000, "devInfo": "CHAPTER_10_Prism Completion"},
		// "a_Invasion": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504299, "points": 0000000, "devInfo": "CHAPTER_11_Invasion Completion"},
		// "a_Hangtown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504300, "points": 0000000, "devInfo": "CHAPTER_12_Hangtown Completion"},
		// "a_MorningAfter": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504301, "points": 0000000, "devInfo": "CHAPTER_13_MorningAfter Completion"},
		// "a_Showdown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504302, "points": 0000000, "devInfo": "CHAPTER_14_Showdown Completion"},
		// "a_RightTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504303, "points": 0000000, "devInfo": "CHAPTER_15_RightTrain Completion"},
		// "a_Deadfall": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504304, "points": 0000000, "devInfo": "CHAPTER_16_Deadfall Completion"},
		},
	"c_SPend": { // Category - Singleplayer Story Ending
		// "a_CurseWestGood": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION 
			// "id": 504305, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Good ending"},		
		// "a_CurseWestEvil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504306, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Evil ending"},
		},
	"c_Unlocks": { // Category - Unlockables in Gunslinger Mode // "Built-in" Gunslinger Challenges
		// "a_Boss": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506183, "points": 0000000, "devInfo": "Unlock Concept Art 'Bosses Art'"},
		// "a_Enemy1": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506186, "points": 0000000, "devInfo": "Unlock Concept Art 'Enemies 1"},
		// "a_Enemy2": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506261, "points": 0000000, "devInfo": "Unlock Concept Art 'Enemies 2'"},
		// "a_Train": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506185, "points": 0000000, "devInfo": "Unlock Concept Art 'Wrong Train Animatic'"},
		// "a_Guns": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506187, "points": 0000000, "devInfo": "Unlock Concept Art 'Weapons'"},
		// "a_Drivers": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506264, "points": 0000000, "devInfo": "Unlock Concept Art 'Vehicles'"},
		// "a_Sights1": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506219, "points": 0000000, "devInfo": "Unlock Concept Art 'Environments 1'"},
		// "a_Sights2": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506387, "points": 0000000, "devInfo": "Unlock Concept Art 'Environments 2'"},
		// "a_Sights3": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506184, "points": 0000000, "devInfo": "Unlock Concept Art 'Environments 3'"},
		// "a_Attract": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506262, "points": 0000000, "devInfo": "Unlock Concept Art 'Attract Mode Movie'"},
		// "a_Cowboy": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506260, "points": 0000000, "devInfo": "Unlock Concept Art 'Cowboy Animatic'"},
		// "a_Shower": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506388, "points": 0000000, "devInfo": "Unlock Concept Art 'Showdown Animatic'"},
		// "a_Saver": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506263, "points": 0000000, "devInfo": "Unlock Concept Art 'Rescue Intro Movie'"},
		// "a_Moon": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506188, "points": 0000000, "devInfo": "Unlock Concept Art 'Highmoon Trailer'"},
		// "a_Archive": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506807, "points": 0000000, "devInfo": "Unlock Concept Art 'Darkwatch Archives'"},
		},
	"c_Gunslinger": { // Category - "Custom" Gunslinger Challenges
		// "a_Template": { // CONCEPT a_Gunslinger
			// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
		// "a_WeaponMaster": { // CONCEPT a_WeaponMaster
			// "id": 000000, "points": 0000000, "devInfo": "Have each of the 9 weapons registered as a "Favorite Weapon" in the GunslingerStatsMenu for at least one of Chapter"},
		},
	"c_Bonus": { // Category - Bonus/Easter Egg Achievements
		// "a_SunPower": { // CONCEPT a_SunPower
		// 	"id": 000000, "points": 0000000, "devInfo": "Activate Power when in sunlight"},
		// "a_FanHammer": { // CONCEPT a_FanHammer
		// 	"id": 000000, "points": 0000000, "devInfo": "With Redeemer: Land xx shots in single Fan The Hammer volley"},
		// "a_MultiKill": { // CONCEPT a_MultiKill (Title: Bloodlust)
		// 	"id": 000000, "points": 0000000, "devInfo": "With Redeemer: Kill xx enemies in short duration of eachother (explosive or powers??)"},
		},
	}
// -------------------------------------
achievement_TYPE_Progression = "progression"
achievement_TYPE_WinCondition = "win_condition"
achievement_TYPE_Missable = "missable"
achievement_TYPE_Standard = ""

achievements_typeByCategory = {
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 	achievement_TYPE_Standard,
	"c_SPstory": 		achievement_TYPE_Progression,
	"c_SPend": 			achievement_TYPE_WinCondition,
	"c_Unlocks": 		achievement_TYPE_Standard,
	"c_Gunslinger": 	achievement_TYPE_Standard,
	"c_Bonus": 			achievement_TYPE_Standard}
	
// #endregion ACH - core data

// ==================================
// • ACHIEVEMENT trigger generators •
// ==================================
// #region ACH - trigger generators
//	- For achievement logic that's reoccuring across multiple triggers
// ---------------SinglePlayerLevelProgression----------------------
function achGenerate_4x_AltResetGroups_SingleplayerLevelProgression(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// [1] ==== Alt Reset Group ==== 			-> Reset when not in SinglePlayer OR Gunslinger Mode
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion))
	// [2] ==== Alt Reset Group ==== 			-> Reset when not in correct Level
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_Level_StoryChapter(enum_chapter, enum_releaseRegion))
	// [3] ==== Alt Reset Group ==== 			-> Reset when at MainMenu --> Necessary next to AltResetGroup[4], to reset hitCounts on AltLogicGroup
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_atMainMenu(enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 			-> Reset on PauseMenu->Restart OR on PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[4]) --> altered MANUAL_CONSTRUCTION[1FD-4FD], with ResetIf/AndNext/OrNext
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			---------
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			OrNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 	| CheckIf: FrameTitle == "Restart"
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			ResetIf		Mem [BitFlag:IsInputPressed_Cross] > Delta [Bitflag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

						Val 0x0 == Val 0x1					*/
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Restart_OR_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-4FD]

function achGenerate_4x_AltResetGroups_SingleplayerWinCondition(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// [1] ==== Alt Reset Group ==== 			-> Reset when not in SinglePlayer
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InSinglePlayerMode(enum_releaseRegion))
	// [2] ==== Alt Reset Group ==== 			-> Reset when not in correct Level
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_Level_StoryChapter(enum_chapter, enum_releaseRegion))
	// [3] ==== Alt Reset Group ==== 			-> Reset when at MainMenu --> Necessary next to AltResetGroup[4], to reset hitCounts on AltLogicGroup
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_atMainMenu(enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 			-> Reset on PauseMenu->Restart OR on PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[4]) --> altered MANUAL_CONSTRUCTION[1FD-4FD], with ResetIf/AndNext/OrNext
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			---------
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			OrNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 	| CheckIf: FrameTitle == "Restart"
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			ResetIf		Mem [BitFlag:IsInputPressed_Cross] > Delta [Bitflag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

						Val 0x0 == Val 0x1					*/
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Restart_OR_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-4FD]
		
function achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(enum_chapter, enum_endingFMV, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* MANUAL_CONSTRUCTION (AltGroup[5/10])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1] ==== Alt Logic Group ==== 	-> This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has started from the beginning
			is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleTrue(enum_releaseRegion))
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& trigger_when(
			once(
				never(on_FMV_start(enum_endingFMV, enum_releaseRegion))
				&& on_FMV_end(enum_endingFMV, enum_releaseRegion))
			&& on_Loading_start(enum_releaseRegion))
	// [2+3+4+5] ==== 4x Alt Reset Groups ==== 				-> Reset when not in SinglePlayer OR Gunslinger Mode || when not in correct Level || when at MainMenu || on PauseMenu->Restart OR on PauseMenu->Quit
		|| achGenerate_4x_AltResetGroups_SingleplayerLevelProgression(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* MANUAL_CONSTRUCTION (AltGroup[5/10])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_O:0xX0000006c=870403064_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1] ==== Alt Logic Group ==== 	-> This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has started from the beginning
			is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleTrue(enum_releaseRegion))
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& trigger_when(on_Loading_start(enum_releaseRegion))
	// [2+3+4+5] ==== 4x Alt Reset Groups ==== 				-> Reset when not in SinglePlayer OR Gunslinger Mode || when not in correct Level || when at MainMenu || on PauseMenu->Restart OR on PauseMenu->Quit
		|| achGenerate_4x_AltResetGroups_SingleplayerLevelProgression(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

// ---------------GunslingerUnlocks----------------------
function achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION 
	// [1] ==== Reset Groups ==== 			-> Reset when not in Gunslinger Mode
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InGunslingerMode(enum_releaseRegion))
	// [2] ==== Alt Reset Group ==== 		-> Reset when starting a new Chapter from MainMenu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion))
	// [3] ==== Alt Reset Group ==== 		-> Reset when LevelID is incorrect
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_Level_StoryChapter(enum_chapter, enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 		-> Reset when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[4]): R/R usage
			--> MANUAL_CONSTRUCTION[1FD-3FD] with ResetIf+AndNext (refer to on_PauseMenu_Quit())
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			-------------
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()

			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Quit	| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			ResetIf		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			ResetIf		Mem [BitFlag:IsInputPressed_Cross] > Delta [Bitflag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

						Val 0x0 == Val 0x1					*/	
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-3FD]

function achGenerate_FullTrigger_GunslingerUnlock_Difficulty(enum_chapter, enum_minRequiredDifficulty, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* MANUAL_CONSTRUCTION (AltGroup[6])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Required difficulty is selected
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& is_DifficultyOrHarder(enum_minRequiredDifficulty, enum_releaseRegion)

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))			
		&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
	// [2] ==== Alt Trigger Group ==== 			-> This group is only responsible for displaying a Trigger Indicator when the required difficulty is correct
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Required difficulty is selected
			is_DifficultyOrHarder(enum_minRequiredDifficulty, enum_releaseRegion)
			&& on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& trigger_when(always_false())
	// [3+4+5+6] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_GunslingerUnlock_Accuracy(enum_chapter, enum_minRequiredAccuracy, enum_releaseRegion) => // WARNING - (4x) MANUAL_CONSTRUCTION
	// NOTE: enum_minRequiredAccuracy needs to be a Float (eg. min required accuracy is 65% --> Float: 0.65)
	/* MANUAL_CONSTRUCTION (AltGroup[7])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1/8] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy achieved
			never(is_flagState_InGame_true(enum_releaseRegion))
			
			/* MANUAL_CONSTRUCTION[0ACC-4ACC] (below 3 lines): R/R usage 
				// WARNING - Edit enum_minRequiredAccuracy
				PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.65
				NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.65
				-----------
				Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
				Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
				AndNext		Recall >= enum_minRequiredAccuracy			*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) >= enum_minRequiredAccuracy
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x4ACC)

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))			
		&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
	// [2/9] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		/* MANUAL_CONSTRUCTION[0ACC-5ACC] (below Measured): R/R usage
			PAL:	A:0xX00965c20+0xX00965c54_A:0xX00965c88_K:0_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
			NTSCU:	A:0xX00953c40+0xX00953c74_A:0xX00953ca8_K:0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
			-----------
			Remember	[32-bit:ShotsFired_Temp] + [32-bit:ShotsFired_ChapterSection]
			Remember	Recall / 1.0								--> Force 32-bit to Float
			AddSource	[32-bit:ShotsHit_Temp] / Recall				--> Divide by Float, returns a Float
			Remember	[32-bit:ShotsHit_ChapterSection] / Recall	--> Divide by Float, returns a Float
			Remember	Recall * 100.0
			Measured	Recall == 100.0				*/
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
		&& measured(
			current_calculated_Accuracy_FullTotal(PLAYER_1, enum_releaseRegion) == 100.0,
			when = 	
				memUtil_ManualConstruction_PlaceHolderRequirement(0x5ACC)
				&& once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_true(enum_releaseRegion),
			format = "percent")
		&& trigger_when(always_false())
	// [3/10] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When not in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		/* MANUAL_CONSTRUCTION[0ACC-6ACC] (below Measured): R/R usage
			PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
			NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
			-----------
			Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
			Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
			Remember	Recall * 100.0
			Measured	Recall == 100.0			*/
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
		&& measured(				
			current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
			when = 
				memUtil_ManualConstruction_PlaceHolderRequirement(0x6ACC)
				&& once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_false(enum_releaseRegion),
			format = "percent")
		&& trigger_when(always_false())
	// [4+5+6+7] ==== (4x) Reset Groups ==== 				-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_GunslingerUnlock_Time(enum_chapter, int_timeLimit, enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION
	// NOTE: int_timeLimit in milliseconds (1 min = 60.000 ms)
	return 
	// [1/7] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			on_calculated_TotalMissionTime_overflow(enum_releaseRegion)))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + MissionTime is within time limit
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= int_timeLimit

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
	// [2/8] ==== Alt Measured Group ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			on_calculated_TotalMissionTime_overflow(enum_releaseRegion)))
		&& unless( // --PauseIf--> MissionTime exceeds time limit
			current_calculated_TotalMissionTime(enum_releaseRegion) > int_timeLimit)
		/* MANUAL_CONSTRUCTION[AA01-AA02] (below Measured): R/R usage
			// WARNING - Edit int_timeLimit
			PAL:	A:0xX00965c08_A:0xX00965c70_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
			NTSCU:	A:0xX00953c28_A:0xX00953c90_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
			''''''''''''''
			AddSource	[32-bit:MissionTime_Temp]
			AddSource	[32-bit:MissionTime_ChapterSection]
			Remember	Val 0
			Remember	Recall / 1000.0							| current_calculated_TotalMissionTime() in seconds
			AddSource	(int_timeLimit/1000) - Recall
			Measured	Val 0 == (int_timeLimit/1000) 		*/				
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
		&& measured(
			current_MissionTime_Temp(enum_releaseRegion) 
			+ current_MissionTime_ChapterSection(enum_releaseRegion) == int_timeLimit / 1000,
			when = 
				memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
				&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
			)
		&& trigger_when(always_false())
	// [3+4+5+6] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[6/12]): R/R usage
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
	}

function achGenerate_FullTrigger_GunslingerUnlock_MeleeKills(enum_chapter, int_requiredMeleeKills, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* MANUAL_CONSTRUCTION (AltGroup[7])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			on_calculated_TotalMissionTime_overflow(enum_releaseRegion)))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Player has enough MeleeKills
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= int_requiredMeleeKills

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
	// [2] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& measured(
			current_calculated_MeleeKills_FullTotal(PLAYER_1, enum_releaseRegion) >= int_requiredMeleeKills,
			when = 
				once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_true(enum_releaseRegion)
			)
		&& trigger_when(always_false())
	// [3] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When not in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& measured(
			current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= int_requiredMeleeKills,
			when = 
				once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_false(enum_releaseRegion)
			)
		&& trigger_when(always_false())
	// [4+5+6+7] ==== (4x) Reset Groups ==== 			-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_GunslingerUnlock_HeadshotKills(enum_chapter, int_requiredHeadshotKills, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// [1] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			on_calculated_TotalMissionTime_overflow(enum_releaseRegion)))
		&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Player has enough MeleeKills
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= int_requiredHeadshotKills

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
	// [2] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& measured(
			current_calculated_HeadshotKills_FullTotal(PLAYER_1, enum_releaseRegion) >= int_requiredHeadshotKills,
			when = 
				once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_true(enum_releaseRegion)
			)
		&& trigger_when(always_false())
	// [3] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When not in-game
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& measured(
			current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= int_requiredHeadshotKills,
			when = 
				once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
				&& is_flagState_InGame_false(enum_releaseRegion)
			)
		&& trigger_when(always_false())
	// [4+5+6+7] ==== (4x) Reset Groups ==== 			-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[7/14]): R/R usage
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
// -------------------------------------
function achGenerate_Measured_GunslingerChaptersCompletedOnDeadeyeDifficulty(enum_releaseRegion) {
	let_array_comparisons = []
	for let_index in range(0, CONST_NUMBER_OF_CHAPTERS - 1) 
		array_push(let_array_comparisons, current_SavedStatGunslinger_Difficulty(let_index, enum_releaseRegion) == DIFFICULTY_Deadeye)

	return measured(
		tally_of(let_array_comparisons, CONST_NUMBER_OF_CHAPTERS, let_difficultyComparison => 
			once(
				never(!let_difficultyComparison) 
				&& let_difficultyComparison)
			)
		)}

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

	// --------c_SPstory--------
	"a_WrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(CHAPTER_1_WrongTrain, FMV_Shadow, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_RideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_2_RideDevil, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Boneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(CHAPTER_3_Boneyard, FMV_CassidyDies, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_DevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(CHAPTER_4_DevilMine, FMV_TheHaunting, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_DWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_5_Outpost, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_WarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_6_WarTrain, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_TortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(CHAPTER_7_TortureMaze, FMV_GiddyUp, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_BaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_8_BaptismFire, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Rescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_9_Rescue, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Prism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_10_Prism, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Invasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_11_Invasion, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Hangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_EndFMV(CHAPTER_12_Hangtown, FMV_PromNight, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_MorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_13_MorningAfter, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Showdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_14_Showdown, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_RightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_15_RightTrain, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	"a_Deadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(CHAPTER_16_Deadfall, enum_releaseRegion)), // --> (1x) MANUAL_CONSTRUCTION
	// --------c_SPend--------
	"a_CurseWestGood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_CHAPTER = CHAPTER_17_CurseWest
		const_FMV_GoodEnding = FMV_Hero
		return 
		// [1] ==== Alt Logic Group ==== 	-> This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has started from the beginning
				is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleTrue(enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(
				once(
					never(on_FMV_start(const_FMV_GoodEnding, enum_releaseRegion))
					&& on_FMV_end(const_FMV_GoodEnding, enum_releaseRegion))
				&& on_FMV_end(FMV_Credits, enum_releaseRegion))
		// [2+3+4+5] ==== 4x Alt Reset Groups ==== 				-> Reset when not in SinglePlayer || when not in correct Level || when at MainMenu || on PauseMenu->Restart OR on PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_SingleplayerWinCondition(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_CurseWestEvil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_CHAPTER = CHAPTER_17_CurseWest
		const_FMV_EvilEnding = FMV_Monster
		return 
		// [1] ==== Alt Logic Group ==== 	-> This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has started from the beginning
				is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleTrue(enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(
				once(
					never(on_FMV_start(const_FMV_EvilEnding, enum_releaseRegion))
					&& on_FMV_end(const_FMV_EvilEnding, enum_releaseRegion))
				&& on_FMV_end(FMV_Credits, enum_releaseRegion))
		// [2+3+4+5] ==== 4x Alt Reset Groups ==== 				-> Reset when not in SinglePlayer || when not in correct Level || when at MainMenu || on PauseMenu->Restart OR on PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_SingleplayerWinCondition(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	// --------c_Unlocks--------
	"a_Boss": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_MIN_REQUIRED_DIFFICULTY = DIFFICULTY_Shootist
		return achGenerate_FullTrigger_GunslingerUnlock_Difficulty(CHAPTER_17_CurseWest, const_MIN_REQUIRED_DIFFICULTY, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Enemy1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (4x) MANUAL_CONSTRUCTION
		/* MANUAL_CONSTRUCTION (AltGroup[1/8])
			PAL:	P:0xX007215cc!=1397050451_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=67_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._I:0xX00721820_I:0xX00000020_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._Z:0xX00965cc4!=0_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.65_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_N:0xX00965cc4=0_d0xX00965cc4!=0.1._Z:0xX00965cc4!=0_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_N:p0xX00965cc4!=0_0xX00965cc4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00721900_T:0xM0000000f>d0xM0000000f
			NTSCU:	P:0xX0071fccc!=1398099027_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=67_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._Z:0xX00953ce4!=0_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.65_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_N:0xX00953ce4=0_d0xX00953ce4!=0.1._Z:0xX00953ce4!=0_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_N:p0xX00953ce4!=0_0xX00953ce4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00720000_T:0xM0000000f>d0xM0000000f
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[2/9])
			PAL:	P:0xX007215cc!=1397050451_A:0xX00965c20+0xX00965c54_A:0xX00965c88_K:0_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=67_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4!=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_A:0xX00953c40+0xX00953c74_A:0xX00953ca8_K:0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=67_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4!=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[3/10])
			PAL:	P:0xX007215cc!=1397050451_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597190221_I:0xX00721820_I:0xX00000024_N:0xH00000006=67_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597190221_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=67_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		achGenerate_FullTrigger_GunslingerUnlock_Accuracy(CHAPTER_3_Boneyard, 0.65, enum_releaseRegion)), // --> (4x) MANUAL_CONSTRUCTION
	"a_Enemy2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_MELEEKILLS = 20
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_MeleeKills(CHAPTER_14_Showdown, const_REQUIRED_MELEEKILLS, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Train": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (4x) MANUAL_CONSTRUCTION
		/* MANUAL_CONSTRUCTION (AltGroup[1/8])
			PAL:	P:0xX007215cc!=1397050451_I:0xX00721820_I:0xX00000020_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._I:0xX00721820_I:0xX00000020_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1113550441_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._Z:0xX00965cc4!=0_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.65_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1113550441_N:0xX00965cc4=0_d0xX00965cc4!=0.1._Z:0xX00965cc4!=0_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1113550441_N:p0xX00965cc4!=0_0xX00965cc4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00721900_T:0xM0000000f>d0xM0000000f
			NTSCU:	P:0xX0071fccc!=1398099027_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1113550441_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._Z:0xX00953ce4!=0_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.65_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1113550441_N:0xX00953ce4=0_d0xX00953ce4!=0.1._Z:0xX00953ce4!=0_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1113550441_N:p0xX00953ce4!=0_0xX00953ce4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00720000_T:0xM0000000f>d0xM0000000f
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[2/9])
			PAL:	P:0xX007215cc!=1397050451_A:0xX00965c20+0xX00965c54_A:0xX00965c88_K:0_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4!=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_A:0xX00953c40+0xX00953c74_A:0xX00953ca8_K:0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4!=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[3/10])
			PAL:	P:0xX007215cc!=1397050451_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000002=1852797527_I:0xX00721820_I:0xX00000024_N:0xX00000006=1634882663_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1852797527_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1634882663_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1096773225_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		achGenerate_FullTrigger_GunslingerUnlock_Accuracy(CHAPTER_1_WrongTrain, 0.65, enum_releaseRegion)), // --> (4x) MANUAL_CONSTRUCTION
	"a_Guns": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (4x) MANUAL_CONSTRUCTION
		/* MANUAL_CONSTRUCTION (AltGroup[1/8])
			PAL:	P:0xX007215cc!=1397050451_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0x 00000006=16705_I:0xX00721820_I:0xX00000024_N:0xH00000008=0_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._I:0xX00721820_I:0xX00000020_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_I:0xX00721820_I:0xX00000024_N:0xH00000007=0_N:0xX00965c70=0_N:0xX00965c08>0_d0xX00965c08=0.1._Z:0xX00965cc4!=0_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.7_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_I:0xX00721820_I:0xX00000024_N:0xH00000007=0_N:0xX00965cc4=0_d0xX00965cc4!=0.1._Z:0xX00965cc4!=0_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_I:0xX00721820_I:0xX00000024_N:0xH00000007=0_N:p0xX00965cc4!=0_0xX00965cc4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX007238b8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00721900_T:0xM0000000f>d0xM0000000f
			NTSCU:	P:0xX0071fccc!=1398099027_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0x 00000006=16705_I:0xX0071ff20_I:0xX00000024_N:0xH00000008=0_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_I:0xX0071ff20_I:0xX00000024_N:0xH00000007=0_N:0xX00953c90=0_N:0xX00953c28>0_d0xX00953c28=0.1._Z:0xX00953ce4!=0_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.7_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_I:0xX0071ff20_I:0xX00000024_N:0xH00000007=0_N:0xX00953ce4=0_d0xX00953ce4!=0.1._Z:0xX00953ce4!=0_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_I:0xX0071ff20_I:0xX00000024_N:0xH00000007=0_N:p0xX00953ce4!=0_0xX00953ce4=0.2._I:0xX00134214_T:0xX0000014c=1295143760_I:0xX00134214_T:0x 00000150=18753_I:0xX00134214_T:0xX0000012c=1684434771_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000002=1718579824_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX00000006=1600482409_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000a=1952543859_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0xX0000000e=1769239401_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX00000030_T:0x 00000012=29539_I:0xX00721fb8_I:0xX0000000c_I:0xX00000000_I:0xX0000000c_I:0xX00000000_T:0xX00000048=261521834_I:0xX00720000_T:0xM0000000f>d0xM0000000f
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[2/9])
			PAL:	P:0xX007215cc!=1397050451_A:0xX00965c20+0xX00965c54_A:0xX00965c88_K:0_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0x 00000006=16705_I:0xX00721820_I:0xX00000024_N:0xH00000008=0_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4!=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_A:0xX00953c40+0xX00953c74_A:0xX00953ca8_K:0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0x 00000006=16705_I:0xX0071ff20_I:0xX00000024_N:0xH00000008=0_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4!=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[3/10])
			PAL:	P:0xX007215cc!=1397050451_K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0xX00000002=1597124941_I:0xX00721820_I:0xX00000024_N:0x 00000006=16705_I:0xX00721820_I:0xX00000024_N:0xH00000008=0_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._Q:0xX00965cc4=0_T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1597124941_I:0xX0071ff20_I:0xX00000024_N:0x 00000006=16705_I:0xX0071ff20_I:0xX00000024_N:0xH00000008=0_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._Q:0xX00953ce4=0_T:0=1
			*/
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		achGenerate_FullTrigger_GunslingerUnlock_Accuracy(CHAPTER_13_MorningAfter, 0.70, enum_releaseRegion)), // --> (4x) MANUAL_CONSTRUCTION
	"a_Drivers": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_HEADSHOTKILLS = 20
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_HeadshotKills(CHAPTER_16_Deadfall, const_REQUIRED_HEADSHOTKILLS, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Sights1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_CHAPTER = CHAPTER_5_Outpost
		/* MANUAL_CONSTRUCTION (AltGroup[6/12])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return 
		// [1] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When player has died once
				on_PlayerDeaths_ChapterSection_increment(PLAYER_1, enum_releaseRegion)
				|| on_PlayerDeaths_ChapterTotal_increment(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
				on_Chapter_startFromBeginning(const_REQUIRED_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
				on_LastChapterSection_startFromBeginning(const_REQUIRED_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + with 0 playerDeaths
				never(is_flagState_InGame_true(enum_releaseRegion))				
				&& current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) == 0
				&& is_LastChapterSection_active(const_REQUIRED_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_REQUIRED_CHAPTER, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2] ==== Alt Trigger Group ==== 					-> This group only responsible for displaying a Trigger Indicator as long as player has not died
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When player has died once
				on_PlayerDeaths_ChapterSection_increment(PLAYER_1, enum_releaseRegion)
				|| on_PlayerDeaths_ChapterTotal_increment(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
				on_Chapter_startFromBeginning(const_REQUIRED_CHAPTER, enum_releaseRegion))
			&& trigger_when(always_false())
		// [3+4+5+6] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(const_REQUIRED_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_Sights2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_MIN_REQUIRED_DIFFICULTY = DIFFICULTY_Deadeye
		return achGenerate_FullTrigger_GunslingerUnlock_Difficulty(CHAPTER_11_Invasion, const_MIN_REQUIRED_DIFFICULTY, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Sights3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION
		const_TIME_LIMIT = 600000.0 // 600.000 ms = 10 mins
		/* MANUAL_CONSTRUCTION (AltGroup[2/8])
			PAL:	P:0xX007215cc!=1397050451_A:d0xX00965c08_N:d0xX00965c70>=4294966295_A:0xX00965c08_P:0xX00965c70<=1000.1._A:0xX00965c08_P:0xX00965c70>600000_A:0xX00965c08_A:0xX00965c70_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1970238023_I:0xX00721820_I:0xX00000024_N:0xX00000002=1970238023_I:0xX00721820_I:0xX00000024_N:0xX00000006=1700422766_I:0xX00721820_I:0xX00000024_N:0xX0000000a=1096773490_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_A:d0xX00953c28_N:d0xX00953c90>=4294966295_A:0xX00953c28_P:0xX00953c90<=1000.1._A:0xX00953c28_P:0xX00953c90>600000_A:0xX00953c28_A:0xX00953c90_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1970238023_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1970238023_I:0xX0071ff20_I:0xX00000024_N:0xX00000006=1700422766_I:0xX0071ff20_I:0xX00000024_N:0xX0000000a=1096773490_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._T:0=1
			*/ 
		/* MANUAL_CONSTRUCTION (AltGroup[6/12])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_Time(CHAPTER_17_CurseWest, const_TIME_LIMIT, enum_releaseRegion)}),	// --> (2x) MANUAL_CONSTRUCTION
	"a_Attract": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_CHAPTER = CHAPTER_10_Prism
		const_REQUIRED_KILLS = 80
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return
		// [1/8] ==== Alt Logic Group ==== 						-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				on_calculated_TotalMissionTime_overflow(enum_releaseRegion)))
			&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
				on_Chapter_startFromBeginning(CHAPTER_10_Prism, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
				on_LastChapterSection_startFromBeginning(CHAPTER_10_Prism, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Player has enough MeleeKills
				never(is_flagState_InGame_true(enum_releaseRegion))

				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_REQUIRED_KILLS

				&& is_LastChapterSection_active(CHAPTER_10_Prism, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(CHAPTER_10_Prism, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/9] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured(
				current_calculated_Kills_FullTotal(PLAYER_1, enum_releaseRegion) >= const_REQUIRED_KILLS,
				when = 
					once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
						on_Chapter_startFromBeginning(CHAPTER_10_Prism, enum_releaseRegion))
					&& is_flagState_InGame_true(enum_releaseRegion)
				)
			&& trigger_when(always_false())
		// [3/10] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for MeleeKillCount - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured(
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_REQUIRED_KILLS,
				when = 
					once( // --MeasuredIf--> Gunslinger Level/Chapter is started from beginning
						on_Chapter_startFromBeginning(CHAPTER_10_Prism, enum_releaseRegion))
					&& is_flagState_InGame_false(enum_releaseRegion)
				)
			&& trigger_when(always_false())
		// [4+5+6+7] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerUnlocks(CHAPTER_10_Prism, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_Cowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_MELEEKILLS = 30
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_MeleeKills(CHAPTER_7_TortureMaze, const_REQUIRED_MELEEKILLS, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Shower": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_MIN_REQUIRED_DIFFICULTY = DIFFICULTY_Shootist
		return achGenerate_FullTrigger_GunslingerUnlock_Difficulty(CHAPTER_15_RightTrain, const_MIN_REQUIRED_DIFFICULTY, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Saver": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_HEADSHOTKILLS = 20
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_HeadshotKills(CHAPTER_12_Hangtown, const_REQUIRED_HEADSHOTKILLS, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Moon": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION
		const_TIME_LIMIT = 900000.0 // 900.000 ms = 15 mins
		/* MANUAL_CONSTRUCTION (AltGroup[2/8])
			PAL:	P:0xX007215cc!=1397050451_A:d0xX00965c08_N:d0xX00965c70>=4294966295_A:0xX00965c08_P:0xX00965c70<=1000.1._A:0xX00965c08_P:0xX00965c70>f900000.0_A:0xX00965c08_A:0xX00965c70_K:0_K:{recall}/f1000.0_A:f900.0-{recall}_M:0=f900.0_I:0xX00721820_I:0xX00000020_N:0xX00000002=1597517901_I:0xX00721820_I:0xX00000024_N:0xX00000002=1600288072_I:0xX00721820_I:0xX00000024_N:0xH00000006=65_N:0xX00965c3c=0_N:0xX00965c70=0_N:0xX00965c08>0_Q:d0xX00965c08=0.1._T:0=1
			NTSCU:	P:0xX0071fccc!=1398099027_A:d0xX00953c28_N:d0xX00953c90>=4294966295_A:0xX00953c28_P:0xX00953c90<=1000.1._A:0xX00953c28_P:0xX00953c90>f900000.0_A:0xX00953c28_A:0xX00953c90_K:0_K:{recall}/f1000.0_A:f900.0-{recall}_M:0=f900.0_I:0xX0071ff20_I:0xX00000020_N:0xX00000002=1597517901_I:0xX0071ff20_I:0xX00000024_N:0xX00000002=1600288072_I:0xX0071ff20_I:0xX00000024_N:0xH00000006=65_N:0xX00953c5c=0_N:0xX00953c90=0_N:0xX00953c28>0_Q:d0xX00953c28=0.1._T:0=1
			*/ 
		/* MANUAL_CONSTRUCTION (AltGroup[6/12])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_Time(CHAPTER_9_Rescue, const_TIME_LIMIT, enum_releaseRegion)}),	// --> (2x) MANUAL_CONSTRUCTION
	"a_Archive": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		let_array_AllGunslingerLevels_Indexes = util_generateArrayOfIntegers_startAtZero(CONST_NUMBER_OF_CHAPTERS - 1)
		return
		// [1] ==== Alt Logic Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--> Any Gunslinger ChapterSection is started from beginning 
				on_AnyChapterSection_startFromBeginning(enum_releaseRegion))
			&& once( // --CheckIf--> Player leaves InGame + All Gunslinger Chapters completed on Deadeye Difficulty
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& all_of(let_array_AllGunslingerLevels_Indexes, int_index => 
					current_SavedStatGunslinger_Difficulty(int_index, enum_releaseRegion) == DIFFICULTY_Deadeye) // ---> No delta check included: This allow the achievement to be unlocked even if all Chapters have already been completed on Deadeye difficulty
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> Player leaves InGame for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2] ==== Alt Measured Group ==== 	-> This group is responsible for displaying a Measured Indicator of how many Gunslinger Chapters have been completed to Deadeye difficulty 
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& achGenerate_Measured_GunslingerChaptersCompletedOnDeadeyeDifficulty(enum_releaseRegion)
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not in Gunslinger Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& !is_InGunslingerMode(enum_releaseRegion))
		// [4] ==== Alt Reset Group ==== 		-> Reset when starting a new Chapter from MainMenu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion))
		// [5/10] ==== Alt Reset Group ==== 		-> Reset when pressing PauseMenu->Quit
			/* MANUAL_CONSTRUCTION (AltGroup[5/10]): R/R usage
				--> MANUAL_CONSTRUCTION[1FD-3FD] with ResetIf+AndNext (refer to on_PauseMenu_Quit())
				PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
				NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
				-------------
				AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
				AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()

				AddAddress	[Pointer:UIcontrol(preferred)]
				Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
				Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

				AddAddress	[Pointer:UIcontrol(preferred)]
				AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
				Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Quit	| CheckIf: FrameTitle == "Quit"
				
				AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0x7C
				ResetIf		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

				AddAddress	[Pointer:PlayerInput(preferred)]
				ResetIf		Mem [BitFlag:IsInputPressed_Cross] > Delta [Bitflag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

							Val 0x0 == Val 0x1					*/
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-3FD]
		}),
	// --------c_Gunslinger--------
	}
// #endregion ACH - triggers

// =====================
// • ACHIEVEMENT text •
// =====================
// #region ACH - text

/* IDEA's TEXT:
	High Moon (instead of "High Noon")
	Agent 000 (reference to new uniform casket)
	The Crucible (referencing CHAPTER_7_TortureMaze)
	A Reckoning in Blood
	*/
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},

	// --------c_SPstory--------
	"a_WrongTrain": 			{"en": "Hellbound Express"},
	"a_RideDevil": 				{"en": "No Turning Back"},
	"a_Boneyard":	 			{"en": "Whispers From the Grave"},
	"a_DevilMine":	 			{"en": "Veins of the Underworld"},
	"a_DWOutpost":	 			{"en": "No Safe Haven"},
	"a_WarTrain":	 			{"en": "Bullet-Storm Express"},
	"a_TortureMaze":	 		{"en": "Trial by Pain"},
	"a_BaptismFire":	 		{"en": "Blazing Guns, Burning Souls"}, 
	"a_Rescue": 				{"en": "No Grave for a Regulator"},
	"a_Prism": 					{"en": "A Treasure Worth Dying For"},
	"a_Invasion": 				{"en": "Warriors of the Shadow"},
	"a_Hangtown": 				{"en": "Noose and Nightmare"},
	"a_MorningAfter": 			{"en": "When the Sun Rose, It Found Ruins"},
	"a_Showdown": 				{"en": "The Devil You Know"},
	"a_RightTrain": 			{"en": "Damnation Express"},
	"a_Deadfall": 				{"en": "Where the Dead Still Fall"},
	"a_CurseWestGood": 			{"en": "Dawn Over Darkness"},
	"a_CurseWestEvil": 			{"en": "The Devil Wears Spurs"},
	// --------c_Unlocks--------
	"a_Boss":					{"en": "Devil's Trophy Case"},
	"a_Enemy1":					{"en": "Bone-Shattering Precision"},
	"a_Enemy2":					{"en": "Graveyard Brawl"},
	"a_Train":					{"en": "Wrong Train, Right Shot"},
	"a_Guns":					{"en": "The Gunslinger's Craft"},
	"a_Drivers":				{"en": "Highway to Hell"},
	"a_Sights1":				{"en": "Unholy Ground"},
	"a_Sights2":				{"en": "Blood on Sacred Ground"},
	"a_Sights3":				{"en": "Ain't Got Time to Bleed"},
	"a_Attract":				{"en": "Death's Calling Card"},
	"a_Cowboy":					{"en": "Butcher of the Citadel"},
	"a_Shower":					{"en": "Hell on the Rails"},
	xxxx

	xxx
	"a_Saver":					{"en": "One Shot, One Salvation"},
	"a_Moon":					{"en": "The Devil's Hour"},
	"a_Archive":				{"en": "The Price of Immortality"},
	// --------c_Gunslinger--------
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},

	// --------c_SPstory--------
	"a_WrongTrain": 			{"en": "You planned a heist, not a reckoning. Now the only thing getting robbed is your soul. Complete Chapter 1, \"The Wrong Train\""},
	"a_RideDevil": 				{"en": "The Reaper's breathing down your neck, and the only way out is forward. Ride hard or get left in the dirt. Complete Chapter 2, \"Ride Like the Devil\""},
	"a_Boneyard":	 			{"en": "The dead ain't much for conversation, but they'll sure let you know when you're unwelcomes. Complete Chapter 3, \"Boneyard\""},
	"a_DevilMine":	 			{"en": "This mine's seen plenty of bodies, and if you're not careful, yours'll be next. Complete Chapter 4, \"Devil's Belly Mine\""},
	"a_DWOutpost":	 			{"en": "A safe haven? Not anymore. The only thing left standing here is whatever's strong enough to survive. Complete Chapter 5, \"Darkwatch Outpost\""},
	"a_WarTrain":	 			{"en": "This train ain't headed for salvation—just blood, fire, and a hell of a fight. Complete Chapter 6, \"War Train\""},
	"a_TortureMaze":	 		{"en": "General Cartwright don't train survivors—he trains killers. If you're still breathing, you might just be worth something. Complete Chapter 7, \"Torture Maze\""},
	"a_BaptismFire":	 		{"en": "A warm welcome to Darkwatch? Try fire, lead, and bodies hitting the dirt. Complete Chapter 8, \"Baptism of Fire\""},
	"a_Rescue": 				{"en": "They were left to rot, but not on your watch. Time to remind the dead who's still kicking. Complete Chapter 9, \"Rescue\""},
	"a_Prism": 					{"en": "Power like this don't belong in any man's hands—least of all the wicked. Complete Chapter 10, \"The Deadlight Prism\""},
	"a_Invasion": 				{"en": "This land ain't free for the taking, and it damn sure don't belong to the dead. Complete Chapter 11, \"Invasion\""},
	"a_Hangtown": 				{"en": "The gallows still swing, but the dead don't stay hanging. Time to lay them down for good. Complete Chapter 12, \"Hangtown\""},
	"a_MorningAfter": 			{"en": "Darkwatch stood against the darkness for centuries. One night was all it took to bring it crashing down. Complete Chapter 13, \"The Morning After\""},
	"a_Showdown": 				{"en": "Darkwatch lies in ashes, but the nightmare ain't over—not yet. Time to put an end to the devil that started it all. Complete Chapter 14, \"Showdown\""},
	"a_RightTrain": 			{"en": "This train ain't heading west—it's heading straight into damnation. Complete Chapter 15, \"The Right Train\""},
	"a_Deadfall": 				{"en": "The city's burning, the bullets are flying, and you're standing in the middle of hell itself. Complete Chapter 16, \"Deadfall\""},
	"a_CurseWestGood": 			{"en": "The night breaks, the curse fades, and the West is free—at least for now. Achieve the good ending during Chapter 17, \"Curse of the West\""},
	"a_CurseWestEvil": 			{"en": "Ain't a soul left who can stop you. Ain't a god left who'd dare try. Achieve the evil ending during Chapter 17, \"Curse of the West\""},
	// --------c_Unlocks--------
	"a_Boss":					{"en": "Earn the right to witness the horrors you've defeated. Unlock the \"Bosses Art\" concept art by completing Chapter 17, \"Curse of the West\", on Shootist difficulty"},
	"a_Enemy1":					{"en": "A graveyard ain't the place for wasted bullets. Make every shot count, or end up six feet under. Unlock the \"Enemies 1\" concept art by completing Chapter 3, \"Boneyard\", with 65% or more accuracy"},
	"a_Enemy2":					{"en": "Some folks hide behind guns. You settle things the old-fashioned way. Unlock the \"Enemies 2\" concept art by completing Chapter 14, \"Showdown\", with 20 or more melee kills"},
	"a_Train":					{"en": "Ain't much room for shaky hands when the devil himself is ridin' the rails. Unlock the \"Wrong Train Animatic\" concept art by completing Chapter 1, \"The Wrong Train\", with 65% or more accuracy"},
	"a_Guns":					{"en": "A real gunslinger measures his worth in bullets. Miss too many, and the West will carve your tombstone early. Unlock the \"Weapons\" concept art by completing Chapter 13, \"The Morning After\", with 70% or more accuracy"},
	"a_Drivers":				{"en": "Ain't no safer way to stop the dead than a bullet between the eyes. Unlock the \"Vehicles\" concept art by completing Chapter 16, \"Deadfall\", with 20 or more headshots."},
	"a_Sights1":				{"en": "The outpost was supposed to be safe—guess nobody told the things crawling inside. Stay standing, or get buried with the rest. Unlock the \"Environments 1\" concept art by completing Chapter 5, \"Darkwatch Outpost\", with no deaths"},
	"a_Sights2":				{"en": "This was their home, their last stand. Now it's just another battlefield—if you live long enough to see it. Unlock the \"Environments 2\" concept art by completing Chapter 11, \"Invasion\", on Deadeye difficulty"},
	"a_Sights3":				{"en": "Every second the beast lingers, the curse digs deeper. End it fast, or the West won't remember your name at all. Unlock the \"Environments 3\" concept art by completing Chapter 17, \"Curse of the West\", in 10 minutes or less"},
	"a_Attract":				{"en": "One man, eighty bodies—death keeps count, and so do you. Hope your saddlebag's big enough for the souls you're dragging behind. Unlock the \"Attract Mode Movie\" concept art by completing Chapter 10, \"The Deadlight Prism\", with 80 or more kills"},
	"a_Cowboy":					{"en": "Lead kills from a distance, but steel? Steel makes 'em remember. Let your blade do the talking. Unlock the \"Cowboy Animatic\" concept art by completing Chapter 7, \"Torture Maze\", with 30 or more melee kills"},
	"a_Shower":					{"en": "You boarded with a plan, but the devil was already waiting. Now there's only one way off this train—through the wreckage. Unlock the \"Showdown Animatic\" concept art by completing Chapter 15, \"The Right Train\", on Shootist or Deadeye difficulty"},
	"a_Saver":					{"en": "When the town teetered on ruin, your aim never wavered—each shot a vow to keep the dead where they belong. Unlock the \"Rescue Intro Movie\" concept art by completing Chapter 12, \"Hangtown\", with 20 or more headshots"},
	"a_Moon":					{"en": "The moon's rising, and you've got minutes to make it count. Run fast, shoot faster, or be swallowed by the night. Unlock the \"Highmoon Trailer\" concept art by completing Chapter 9, \"Rescue\", in 15 minutes or less"},
	"a_Archive":				{"en": "A gunslinger's tale ain't written in ink—it's carved in blood and spent lead. Live through the worst, and your legend might just outlast you. Unlock the \"Darkwatch Archives\" concept art by completing all Gunslinger levels on Deadeye difficulty"},
	// --------c_Gunslinger--------
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
	}// #endregion ACH - initialization
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
	"rp_Default":										{"en": "xxxxxxxx"}}	// TODO implement rp_Default + rp_DefaultPlus
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

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
	// 	richPresence_getText("rp_Template"),
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

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

	//	"rpp_MacroTemplate": {
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
	// 	// [1] ==== Alt Submit Group ====			-> Submit when ...
	// 		is_ReleaseRegion(enum_releaseRegion)
	// 		&& always_false()
	// 	// [2] ==== Alt Reset Group ====			-> Reset when ...
	// 		|| is_ReleaseRegion(enum_releaseRegion)
	// 		&& always_false()
	// 	),
	}
//-----------------ValueMeasures-------------------
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion))

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