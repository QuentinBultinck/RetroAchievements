// ***************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 \\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	 \\
// ***************************************** \\
// #ID = 19111
// md5 (base, without RApatches): 8E6C817041ADC5B20F3011CD0F945F9D (PAL) - 9CE6383CB5260E300CACDE569EA5916D (NTSC-U)
// RA Hash: https://retroachievements.org/game/19111/hashes
// Platform: PlayStation 2
// Achievement Guide: https://github.com/RetroAchievements/guides/wiki/Darkwatch-(PlayStation-2)
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
		"offsetToMember": {
			"Pointer:SavedStats_Story": 0x4,
			"Pointer:SavedStats_Gunslinger": 0xC},
		}, 
	"Pointer:SofdecStreamData": {
		"pointerChainToMember": {
			"ASCIIFlag:Sofdec_IsFMVactive": {
				"offsetToPointedToMember": 0x12C},
			"ASCII:Sofdec_FMVID": {
				"offsetToPointedToMember": 0x14C},
			},
		},
	"Pointer:Controls_ControllerConfig": {
		"pointerChainToMember": {
			"ASCII:ControllerConfig_NameID": {
				"offsetToPointedToMember": 0x2},
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
			"ASCII:PowerIconTopLeft": {
				"pointerChainOffsets": [0xC, 0x18, 0x10C],
				"offsetToPointedToMember": 0x2},
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
			"8-bit:DifficultySelectMenu_SelectedDifficultyID": {
				"pointerChainOffsets": [0xC, 0x0, 0x58, 0x68]},
			"8-bit:MainMenu_HighlightedButton": {
				"pointerChainOffsets": [0xC, 0x0, 0x58, 0x68]},
			// ------[Pointer:UIcontrol_ptr-L2_A].[Struct:HUDcontrol_Gear-Player1]------
			"Pointer:EquippedWeaponName": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xFC]},	
			"32-bit:EquippedWeapon_LoadedBullets(display)": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xF0]},	
			"32-bit:ThrowableCountInInventory(display)": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xF8]},	
			"ASCII:Equipped_ThrowableNameID": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0x100],
				"offsetToPointedToMember": 0x2},
				
			},
		}, 	
	"Struct:ChapterStats": {
		"sizeInBytes": 56,
		"offsetToMember": {
			"32-bit:MissionTime": 0x8,
			"32-bit:PlayerDeaths": 0xC,
			"Lower4:Difficulty": 0x14,
			"32-bit:Kills": 0x1C,
			"32-bit:ShotsFired": 0x20,
			"32-bit:ShotsHit": 0x24,
			"32-bit:HeadshotKills": 0x28,
			"32-bit:MeleeKills": 0x2C, 
			"Pointer:WeaponEquipTimes": 0x34},
		"pointerChainToMember": {
			"ASCII:LevelID": {
				"pointerChainOffsets": [0x0],
				"offsetToPointedToMember": 0x2},
			},
		},
	"Struct:WeaponEquipTimes": {
		"offsetToMember": {
			"32-bit:WeaponEquipTime_Pistol": 0x0,
			"32-bit:WeaponEquipTime_Redeemer": 0x4,
			"32-bit:WeaponEquipTime_DualPistols": 0x8,
			"32-bit:WeaponEquipTime_HorseRevolver": 0xC,
			"32-bit:WeaponEquipTime_Carbine": 0x10,
			"32-bit:WeaponEquipTime_Shotgun": 0x14,
			"32-bit:WeaponEquipTime_RailRocket": 0x18,
			"32-bit:WeaponEquipTime_RangeRifle": 0x1C,
			"32-bit:WeaponEquipTime_Crossbow": 0x20,
			"32-bit:WeaponEquipTime_Scepter": 0x24},
		},
	"Struct:ControllerInput": {
		"offsetToMember": {
			"Bitflag:IsControllerConnected": 0x0,
			"Bitflag:IsInputPressed_Select": 0x2,
			"BitFlag:IsInputPressed_Cross": 0xB,
			"BitFlag:IsInputPressed_L3": 0xC,
			"BitFlag:IsInputPressed_R3": 0xD,
			"BitFlag:IsInputPressed_L2": 0x10,
			"BitFlag:IsInputPressed_R2": 0x11},
		},
	"Struct:MainUIdata": {
		"pointerChainToMember": {
			"32-bit:LoadingState": {
				"pointerChainOffsets": {
					RELEASE_REGION_USA: [0x510],
					RELEASE_REGION_EUR: [0x450]}},
			},
		},
	"Struct:PlayerEntityData": {
		"pointerChainToMember": {
			"BitFlag:IsPlayerMounted": {
				"pointerChainOffsets": [0x58, 0x64, 0x28]},
			"Float:PlayerHealth(functional)": {
				"pointerChainOffsets": [0x58, 0x7C, 0x98]},
			"Float:VampireShield(functional)": {
				"pointerChainOffsets": [0x58, 0x7C, 0xA0]},
			"Float:BloodPowerGauge(functional)": {
				"pointerChainOffsets": [0x58, 0x7C, 0xFC]},
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
	
	"BitFlag:IsStoryGoodEndingAchieved": {RELEASE_REGION_USA: 0x953D20, RELEASE_REGION_EUR: 0x965d00, RELEASE_REGION_JPN: sNULL},
	"BitFlag:IsStoryEvilEndingAchieved": {RELEASE_REGION_USA: 0x953D21, RELEASE_REGION_EUR: 0x965d01, RELEASE_REGION_JPN: sNULL},
	"BitFlag:IsCinematicActive": {RELEASE_REGION_USA: 0x72bbe8, RELEASE_REGION_EUR: 0x73dce8, RELEASE_REGION_JPN: sNULL},
	
	"Lower4:PlayerCount(preferred)": {RELEASE_REGION_USA: 0x8ff494, RELEASE_REGION_EUR: 0x911474, RELEASE_REGION_JPN: sNULL},
	"Lower4:GameMode": {RELEASE_REGION_USA: 0x8ff510, RELEASE_REGION_EUR: 0x9114f0, RELEASE_REGION_JPN: sNULL},
	"Lower4:MultiplayerVersusGameModeID(non-functional)": {RELEASE_REGION_USA: 0x8FF534, RELEASE_REGION_EUR: 0x911514, RELEASE_REGION_JPN: sNULL},
	"Lower4:DifficultyID(preferred)": {RELEASE_REGION_USA: 0x953c9c, RELEASE_REGION_EUR: 0x965c7c, RELEASE_REGION_JPN: sNULL},

	"8-bit:MatchDuration(non-functional)": {RELEASE_REGION_USA: 0x8FF524, RELEASE_REGION_EUR: 0x911504, RELEASE_REGION_JPN: sNULL},
	"8-bit:DeathmatchSetting_KillsToWin(non-functional)": {RELEASE_REGION_USA: 0x8FF528, RELEASE_REGION_EUR: 0x911508, RELEASE_REGION_JPN: sNULL},
	"8-bit:InProgress_StoryChapterID": {RELEASE_REGION_USA: 0x953d18, RELEASE_REGION_EUR: 0x965cf8, RELEASE_REGION_JPN: sNULL},
	"8-bit:GameState": {RELEASE_REGION_USA: 0x729330, RELEASE_REGION_EUR: 0x73b430, RELEASE_REGION_JPN: sNULL},
	"8-bit:AlwaysNULL": {RELEASE_REGION_USA: 0x71fcf0, RELEASE_REGION_EUR: 0x7215f0, RELEASE_REGION_JPN: sNULL},
	"8-bit:EquippedWeapon_WeaponID-Player1": {RELEASE_REGION_USA: 0x953C24, RELEASE_REGION_EUR: 0x965c04, RELEASE_REGION_JPN: sNULL},
	"8-bit:EquippedWeapon_WeaponID-Player2": {RELEASE_REGION_USA: 0x953D50, RELEASE_REGION_EUR: 0x965d30, RELEASE_REGION_JPN: sNULL},

	"32-bit:DisplayLanguageID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x65f3b8, RELEASE_REGION_JPN: sNULL}, // RELEASE_REGION_USA has no language select
	"32-bit:Checkpoint_RespawnPointID(preferred)": {RELEASE_REGION_USA: 0x7f585c, RELEASE_REGION_EUR: 0x80783c, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_Temp": {RELEASE_REGION_USA: 0x953C28, RELEASE_REGION_EUR: 0x965c08, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_ChapterSection": {RELEASE_REGION_USA: 0x953C90, RELEASE_REGION_EUR: 0x965c70, RELEASE_REGION_JPN: sNULL},
	"32-bit:MissionTime_ChapterTotal": {RELEASE_REGION_USA: 0x953C5C, RELEASE_REGION_EUR: 0x965c3c, RELEASE_REGION_JPN: sNULL},

	"32-bit:SelectedPlayerProfileID:Player-1": {RELEASE_REGION_USA: 0x953d24, RELEASE_REGION_EUR: 0x965d04, RELEASE_REGION_JPN: sNULL},
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
	"Pointer:Controls_ControllerConfig-Player1": {RELEASE_REGION_USA: 0x953CCC, RELEASE_REGION_EUR: 0x965cac, RELEASE_REGION_JPN: sNULL},
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

memUtil_asciiToHex = {
  "A": 0x41,  "B": 0x42,  "C": 0x43,  "D": 0x44,  "E": 0x45,  "F": 0x46,  "G": 0x47, 
  "H": 0x48,  "I": 0x49,  "J": 0x4A,  "K": 0x4B,  "L": 0x4C,  "M": 0x4D,  "N": 0x4E, 
  "O": 0x4F,  "P": 0x50,  "Q": 0x51,  "R": 0x52,  "S": 0x53,  "T": 0x54,  "U": 0x55, 
  "V": 0x56,  "W": 0x57,  "X": 0x58,  "Y": 0x59,  "Z": 0x5A,  "a": 0x61,  "b": 0x62, 
  "c": 0x63,  "d": 0x64,  "e": 0x65,  "f": 0x66,  "g": 0x67,  "h": 0x68,  "i": 0x69, 
  "j": 0x6A,  "k": 0x6B,  "l": 0x6C,  "m": 0x6D,  "n": 0x6E,  "o": 0x6F,  "p": 0x70, 
  "q": 0x71,  "r": 0x72,  "s": 0x73,  "t": 0x74,  "u": 0x75,  "v": 0x76,  "w": 0x77, 
  "x": 0x78,  "y": 0x79,  "z": 0x7A,  "0": 0x30,  "1": 0x31,  "2": 0x32,  "3": 0x33, 
  "4": 0x34,  "5": 0x35,  "6": 0x36,  "7": 0x37,  "8": 0x38,  "9": 0x39,  " ": 0x20, 
  "!": 0x21,  "#": 0x23,  "$": 0x24,  "%": 0x25,  "&": 0x26,  "\"": 0x27, 
  "(": 0x28,  ")": 0x29,  "*": 0x2A,  "+": 0x2B,  ",": 0x2C,  "-": 0x2D,  ".": 0x2E, 
  "/": 0x2F,  ":": 0x3A,  ";": 0x3B,  "<": 0x3C,  "=": 0x3D,  ">": 0x3E,  "?": 0x3F, 
  "@": 0x40,  "[": 0x5B,  "\\": 0x5C,  "]": 0x5D,  "^": 0x5E,  "_": 0x5F,  "`": 0x60, 
  "{": 0x7B,  "|": 0x7C,  "}": 0x7D,  "~": 0x7E}
 
memUtil_asciiToFloat = {
  "A": 65.0, "B": 66.0, "C": 67.0, "D": 68.0, "E": 69.0, "F": 70.0, "G": 71.0,
  "H": 72.0, "I": 73.0, "J": 74.0, "K": 75.0, "L": 76.0, "M": 77.0, "N": 78.0,
  "O": 79.0, "P": 80.0, "Q": 81.0, "R": 82.0, "S": 83.0, "T": 84.0, "U": 85.0,
  "V": 86.0, "W": 87.0, "X": 88.0, "Y": 89.0, "Z": 90.0, "a": 97.0, "b": 98.0,
  "c": 99.0, "d": 100.0, "e": 101.0, "f": 102.0, "g": 103.0, "h": 104.0, "i": 105.0,
  "j": 106.0, "k": 107.0, "l": 108.0, "m": 109.0, "n": 110.0, "o": 111.0, "p": 112.0,
  "q": 113.0, "r": 114.0, "s": 115.0, "t": 116.0, "u": 117.0, "v": 118.0, "w": 119.0,
  "x": 120.0, "y": 121.0, "z": 122.0, "0": 48.0, "1": 49.0, "2": 50.0, "3": 51.0,
  "4": 52.0, "5": 53.0, "6": 54.0, "7": 55.0, "8": 56.0, "9": 57.0, " ": 32.0,
  "!": 33.0, "#": 35.0, "$": 36.0, "%": 37.0, "&": 38.0, "\"": 39.0,
  "(": 40.0, ")": 41.0, "*": 42.0, "+": 43.0, ",": 44.0, "-": 45.0, ".": 46.0,
  "/": 47.0, ":": 58.0, ";": 59.0, "<": 60.0, "=": 61.0, ">": 62.0, "?": 63.0,
  "@": 64.0, "[": 91.0, "\\": 92.0, "]": 93.0, "^": 94.0, "_": 95.0, "`": 96.0,
  "{": 123.0, "|": 124.0, "}": 125.0, "~": 126.0}

function memUtil_asciiStringToHexLE(string_s, int_numberOfZeroedOutBytesToCheckBeforeString = 0) { // NOTE: Returns a Little Endian hex; int_numberOfZeroedOutBytesToCheckBeforeString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
	/* NOTE Example usages
		- memUtil_asciiStringToHexLE("Wron") --> Returns 0x6E 6F 72 57 ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Little Endian Hex
			dword(memUtil_asciiStringToHexLE("Wr", 2)) == dword(0x6E6F7257) --LittleEndianView--> [6E 6F 72 57] "Wron"
		- memUtil_asciiStringToHexLE("Wr", 2) --> Returns 0x72 57 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Little Endian Hex + with 2 zeroed out bytes appended
			dword(memUtil_asciiStringToHexLE("Wr", 2)) == dword(0x72570000) --LittleEndianView--> [00 00 57 72] "  Wr"
		*/

	let_stringLength = length(string_s)

	if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckBeforeString >= 4)
		util_throwError("One of the parameters given to memUtil_asciiStringToHexLE() is out of range OR invalid")
	if (let_stringLength + int_numberOfZeroedOutBytesToCheckBeforeString > 4)
		util_throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckBeforeString))

	let_hexValue = 0

	if (int_numberOfZeroedOutBytesToCheckBeforeString == 1) let_hexValue = let_hexValue * 0x100
	else if (int_numberOfZeroedOutBytesToCheckBeforeString == 2) let_hexValue = let_hexValue * 0x10000
	else if (int_numberOfZeroedOutBytesToCheckBeforeString == 3) let_hexValue = let_hexValue * 0x1000000

	for let_characterIndex in range(0, let_stringLength - 1) {
		let_characterAsHex = memUtil_asciiToHex[substring(string_s, let_characterIndex, 1)]
		if (let_characterIndex == 0) let_hexValue = let_characterAsHex
		else if (let_characterIndex == 1) let_hexValue = let_hexValue + (let_characterAsHex * 0x100)
		else if (let_characterIndex == 2) let_hexValue = let_hexValue + (let_characterAsHex * 0x10000)
		else let_hexValue = let_hexValue + (let_characterAsHex * 0x1000000)}

	return let_hexValue}

function memUtil_asciiStringToHexBE(string_s, int_numberOfZeroedOutBytesToCheckAfterString = 0) { // NOTE: Returns a Big Endian hex; int_numberOfZeroedOutBytesToCheckAfterString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
	/* NOTE Example usages
		- memUtil_asciiStringToHexLE("Wron") --> Returns 0x57 72 6F 6E  ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Little Endian Hex
			dword_be(memUtil_asciiStringToHexLE("Wr", 2)) == dword_be(0x57726F6E) --BigEndianView--> [57 72 6F 6E] "Wron"
		- memUtil_asciiStringToHexLE("Wr", 2) --> Returns 0x57 72 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Little Endian Hex + with 2 zeroed out bytes appended
			dword_be(memUtil_asciiStringToHexLE("Wr", 2)) == dword_be(0x57720000) --BigEndianView--> [57 72 00 00] "Wr  "
		*/

	let_stringLength = length(string_s)

	if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckAfterString >= 4)
		util_throwError("One of the parameters given to memUtil_asciiStringToHexLE() is out of range OR invalid")
	if (let_stringLength + int_numberOfZeroedOutBytesToCheckAfterString > 4)
		util_throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckAfterString))

	let_hexValue = 0
	for let_characterIndex in range(0, let_stringLength - 1) {
		let_characterAsHex = memUtil_asciiToHex[substring(string_s, let_characterIndex, 1)]
		if (let_characterIndex == 0) let_hexValue = let_characterAsHex
		else if (let_characterIndex == 1) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
		else if (let_characterIndex == 2) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
		else let_hexValue = (let_hexValue * 0x100) + let_characterAsHex}

	if (int_numberOfZeroedOutBytesToCheckAfterString == 1) let_hexValue = let_hexValue * 0x100
	else if (int_numberOfZeroedOutBytesToCheckAfterString == 2) let_hexValue = let_hexValue * 0x10000
	else if (int_numberOfZeroedOutBytesToCheckAfterString == 3) let_hexValue = let_hexValue * 0x1000000

	return let_hexValue}

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

INPUT_Select = "Bitflag:IsInputPressed_Select"
INPUT_Cross = "BitFlag:IsInputPressed_Cross"
INPUT_L2 = "BitFlag:IsInputPressed_L2"
INPUT_R2 = "BitFlag:IsInputPressed_R2"
INPUT_L3 = "BitFlag:IsInputPressed_L3"
INPUT_R3 = "BitFlag:IsInputPressed_R3"

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
	
function is_flagState_IsInputPressed_false(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) == 0
	
function is_flagState_IsInputPressed_true(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) == 1

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

// #region Misc Logic
LANGUAGE_French = 0x46
LANGUAGE_German = 0x47
LANGUAGE_Italian = 0x49
LANGUAGE_English = 0x51
LANGUAGE_Spanish = 0x53

function current_DisplayLanguage(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:DisplayLanguageID", enum_releaseRegion))

function current_flagState_IsCinematicActive(enum_releaseRegion) =>
	bit0(memory_getAddress("BitFlag:IsCinematicActive", enum_releaseRegion))

function prev_flagState_IsCinematicActive(enum_releaseRegion) =>
	prev(current_flagState_IsCinematicActive(enum_releaseRegion))

function is_AnyCinematic_active(enum_releaseRegion) =>
	current_flagState_IsCinematicActive(enum_releaseRegion) == 1

function on_AnyCinematic_end(enum_releaseRegion) =>
	current_flagState_IsCinematicActive(enum_releaseRegion) < prev_flagState_IsCinematicActive(enum_releaseRegion)

// #endregion Misc Logic

// #region MainMenu Control
// -----------------MainMenu Control--------------------
MAINMENU_SUBMENU_MainMenu = "main"
MAINMENU_SUBMENU_StatisticsMenu = "profile_stat" // FullString: "profile_statistics"
MAINMENU_SUBMENU_DifficultySelectMenu = "difficulty_s" // FullString: "difficulty_select"
MAINMENU_SUBMENU_ChapterSelectMenu = "chapter_sele" // FullString: "chapter_select"
MAINMENU_SUBMENU_CoopProfileSelectMenu = "coop_pro" // FullString: "coop_profile"
MAINMENU_SUBMENU_MultiplayerProfileSelectMenu = "multiplayer_prof" // FullString: "multiplayer_profile_select_ps2"
MAINMENU_SUBMENU_CreateMultiplayerMatchMenu = "create_m" // FullString: "create_match"
MAINMENU_SUBMENU_ExtrasMenu = "extras" 
TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger = 0x0F9681AA
TEXTLOOKUPKEY_MainMenuSubMenuTitle_Cooperative = 0x0F9681AA

function current_MainMenu_HighlightedButton(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:UIcontrol", "8-bit:MainMenu_HighlightedButton", 
		let_memAddr_BasePointer, memAccessorFunction_toPointedToMember = byte)}

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

function ASCII_MEM_ADDR_MainMenuSubMenuID(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return   
		memGenerate_pointerChainAccessor("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:UIcontrol", "ASCII:MainMenuSubMenuID")}

function is_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion) => 
	is_ASCII_EqualTo(ASCII_MEM_ADDR_MainMenuSubMenuID(enum_releaseRegion), enum_mainMenuSubMenuID)

function wasPrev_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion) => 
	wasPrev_ASCII_EqualTo(ASCII_MEM_ADDR_MainMenuSubMenuID(enum_releaseRegion), enum_mainMenuSubMenuID)

function on_MainMenu_SubMenu_render(enum_mainMenuSubMenuID, enum_releaseRegion) =>
	is_ASCII_EqualTo(ASCII_MEM_ADDR_MainMenuSubMenuID(enum_releaseRegion), enum_mainMenuSubMenuID)
	&& !wasPrev_ASCII_EqualTo(ASCII_MEM_ADDR_MainMenuSubMenuID(enum_releaseRegion), enum_mainMenuSubMenuID)

function on_MainMenu_SubMenu_render_withSubMenuTitle(enum_mainMenuSubMenuID, enum_titleTextLookupKey, enum_releaseRegion) =>
	is_MainMenu_SubMenuID(enum_mainMenuSubMenuID, enum_releaseRegion)
	&& current_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_titleTextLookupKey
	&& on_MainMenu_newSubMenu(enum_releaseRegion)

function on_MainMenu_SubMenu_close_withSubMenuTitle(enum_mainMenuSubMenuID, enum_titleTextLookupKey, enum_releaseRegion) =>
	wasPrev_MainMenu_SubMenuID(MAINMENU_SUBMENU_StatisticsMenu, enum_releaseRegion)
	&& prev_MainMenu_SubMenuTitle(enum_releaseRegion) == enum_titleTextLookupKey
	&& on_MainMenu_newSubMenu(enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_render(enum_releaseRegion) => 
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_render_withSubMenuTitle(MAINMENU_SUBMENU_StatisticsMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion) => // NOTE: This triggers earlier than on_MainMenu_PostChapterGunslingerStatsMenu_close()
	is_atMainMenu(enum_releaseRegion)
	&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_StatisticsMenu, enum_releaseRegion)
	&& current_MainMenu_SubMenuTitle(enum_releaseRegion) == TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)

function on_MainMenu_PostChapterGunslingerStatsMenu_close(enum_releaseRegion) => // NOTE: This triggers later than on_MainMenu_PostChapterGunslingerStatsMenu_continue()
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_close_withSubMenuTitle(MAINMENU_SUBMENU_StatisticsMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function on_MainMenu_GunslingerChapterSelectMenu_render(enum_releaseRegion) =>
	is_atMainMenu(enum_releaseRegion)
	&& on_MainMenu_SubMenu_render_withSubMenuTitle(MAINMENU_SUBMENU_ChapterSelectMenu, TEXTLOOKUPKEY_MainMenuSubMenuTitle_Gunslinger, enum_releaseRegion)

function current_MainMenu_DifficultySelectMenu_SelectedDifficulty(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Pointer:UIcontrol", "8-bit:DifficultySelectMenu_SelectedDifficultyID", 
		let_memAddr_BasePointer, memAccessorFunction_toPointedToMember = byte)}

function on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion) => // NOTE: This triggers when selecting a difficulty, thus starting the Chapter
	is_atMainMenu(enum_releaseRegion)
	&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_DifficultySelectMenu, enum_releaseRegion)
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)


// #endregion MainMenu Control
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
		current_GameMode(enum_releaseRegion) == const_GAMEMODE_MultiplayerVersus
	}

function is_InMultiplayerCoopMode(enum_releaseRegion) {
	const_GAMEMODE_MultiplayerCoop = 0 // NOTE: same GameModeID as SinglePlayer
	return 
		current_PlayerCount(enum_releaseRegion) == 2
		&& current_GameMode(enum_releaseRegion) == const_GAMEMODE_MultiplayerCoop
	}
// #endregion Game Modes
// #region Game States
// ----------------LoadingState---------------------
CONST_LOADING_STATE_Loading = {RELEASE_REGION_USA: 0x10000048, RELEASE_REGION_EUR: 0x1000003C, RELEASE_REGION_JPN: sNULL}
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
CONST_GAME_STATE_AnyInGameMenu_active = 0x3
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
	/* MANUAL_CONSTRUCTION[1FD-2FD] - R/R usage
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

function on_NewPowerMenu_render(enum_releaseRegion) =>
	/* MANUAL_CONSTRUCTION[1CCD-2CCD]:on_NewPowerMenu_render - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_I:0xX00000000_K:0xX000000b8_I:{recall}_0xX0000006c=2662373993_I:{recall}_d0xX0000006c!=2662373993
		NTSCU: 	xxxx
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			AddAddrss	->[Mem 32-bit] 0x0								| The active [Pointer:UIcontrol_ptr-L2] 
			Remember	-->[Mem 32-bit] 0xB8							

			AddAddrss	Recall
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle == "New Power"			
			
			AddAddrss	Recall
			AddAddress	->[Delta 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 		| CheckIf: DELTA FrameTitle != "New Power"
			*/
	memUtil_ManualConstruction_PlaceHolderRequirement(0x1CCD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2CCD)

function is_NewPowerMenu_displayed(enum_releaseRegion) =>
	/* MANUAL_CONSTRUCTION[1CCD-5CCD]:on_NewPowerMenu_render - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_I:0xX00000000_I:0xX000000b8_0xX0000006c=2662373993
		NTSCU: 	xxxx
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			AddAddress	->[Mem 32-bit] 0x0								| The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	-->[Mem 32-bit] 0xB8
						->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle == "New Power"
			*/	
	memUtil_ManualConstruction_PlaceHolderRequirement(0x1CCD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x5CCD)

function is_NewPowerMenu_Power(enum_textLookupKeyPowerName, enum_releaseRegion) =>
	is_AnyInGameMenu_active(enum_releaseRegion)
	/* MANUAL_CONSTRUCTION[1CCD-4CCD]:CheckNewPowerMenuPowerName - R/R usage
		// WARNING - Edit in enum_textLookupKeyPowerName
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=3965834464
		NTSCU: 	xxxx
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
						->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle == "New Power"	
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xC
			AddAddress	->[Mem 32-bit] 0x4
						->[Mem 32-bit] 0x48 == enum_textLookupKeyPowerName 			| CheckIf: MsgBoxText == enum_textLookupKeyPowerName
			*/
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1CCD)
	// && is_NewPowerMenu_displayed(enum_releaseRegion)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == enum_textLookupKeyPowerName
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x4CCD)

function on_NewPowerMenu_close(enum_releaseRegion) => 
	/* MANUAL_CONSTRUCTION[1CCD-3CCD]:on_NewPowerMenu_close - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_I:0xX00000000_K:0xX000000b8_I:{recall}_0xX0000006c!=2662373993_I:{recall}_d0xX0000006c=2662373993
		NTSCU: 	xxxx
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			AddAddrss	->[Mem 32-bit] 0x0								| The active [Pointer:UIcontrol_ptr-L2] 
			Remember	-->[Mem 32-bit] 0xB8							

			AddAddrss	Recall
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle != "New Power"			
			
			AddAddrss	Recall
			AddAddress	->[Delta 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 		| CheckIf: DELTA FrameTitle == "New Power"
			*/
	memUtil_ManualConstruction_PlaceHolderRequirement(0x1CCD)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0x3CCD)


// #endregion Pause Menu

// #region Multiplayer Match Settings
// ----------------Multiplayer Match Settings---------------------
MP_VS_GAMEMODE_Deathmatch = 0x1
MP_VS_GAMEMODE_SoulHunter = 0x4

MP_VS_MATCHDURATION_NoTimeLimit = 0xFF
MP_VS_MATCHDURATION_5min = 0x5
MP_VS_MATCHDURATION_10mins = 0xA
MP_VS_MATCHDURATION_15mins = 0xF
MP_VS_MATCHDURATION_30mins = 0x1E

MP_VS_KillsToWin_NoKillLimit = 0xFF
MP_VS_KillsToWin_5Kills = 0x5
MP_VS_KillsToWin_10Kills = 0xA
MP_VS_KillsToWin_15Kills = 0xF
MP_VS_KillsToWin_25Kills = 0x19
MP_VS_KillsToWin_50Kills = 0x32

function current_MultiplayerVersusGameMode(enum_releaseRegion) =>
	low4(memory_getAddress("Lower4:MultiplayerVersusGameModeID(non-functional)", enum_releaseRegion))

function is_MultiplayerVersusGameMode(enum_multiplayerVersusGameMode, enum_releaseRegion) =>
	current_MultiplayerVersusGameMode(enum_releaseRegion) == enum_multiplayerVersusGameMode

function current_DeathmatchSetting_KillsToWin(enum_releaseRegion) =>
	low4(memory_getAddress("8-bit:DeathmatchSetting_KillsToWin(non-functional)", enum_releaseRegion))

function is_DeathmatchSetting_KillsToWin(enum_multiplayerVersusKillsToWin, enum_releaseRegion) =>
	current_MultiplayerVersusGameMode(enum_releaseRegion) == enum_multiplayerVersusKillsToWin

function current_MultiplayerSetting_MatchDuration(enum_releaseRegion) =>
	low4(memory_getAddress("8-bit:MatchDuration(non-functional)", enum_releaseRegion))

function is_MultiplayerSetting_MatchDuration(enum_MultiplayerMatchDuration, enum_releaseRegion) =>
	current_MultiplayerVersusGameMode(enum_releaseRegion) == enum_MultiplayerMatchDuration
// #endregion Multiplayer Match Settings

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

function LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter) =>
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

function current_calculated_SinglePlayerStoryProgressionPercentage(enum_releaseRegion) {
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
	let_firstChapterSection = LEVEL_DATA_getFirstFullStringChapterSectionID(enum_chapter)
	return
		is_ChapterSection(enum_chapter, let_firstChapterSection, enum_releaseRegion)
		&& on_NewCheckpoint_reached(enum_releaseRegion)}

function on_StoryChapterSection_start(enum_chapter, enum_chapterSection, enum_releaseRegion) =>
	is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion)
	&& on_Checkpoint_1_initialize(enum_releaseRegion)

function is_LastChapterSection_active(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastFullStringChapterSectionIndex(enum_chapter)
	return is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)}

function on_LastChapterSection_start(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastFullStringChapterSectionIndex(enum_chapter)
	return
		is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)
		&& on_Checkpoint_1_initialize(enum_releaseRegion)}

// #endregion Checkpoint ID

// ..............
// ◦ In-Game Statistics ◦
// ''''''''''''''
// #region In-Game Statistics
function current_MissionTime_Temp(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_Temp", enum_releaseRegion))

function prev_MissionTime_Temp(enum_releaseRegion) =>
	prev(current_MissionTime_Temp(enum_releaseRegion))

function on_MissionTime_Temp_start(enum_releaseRegion) =>
	current_MissionTime_Temp(enum_releaseRegion) > 0
	&& prev_MissionTime_Temp(enum_releaseRegion) == 0

function on_MissionTime_Temp_secondPassed(enum_releaseRegion) =>
	// NOTE: MissionTime is counted in milliseconds, thus divide by 1,000 ---> If (currentFrameMilliseconds / 1000) > (prevFrameMilliseconds / 1000) => a second has passed
	// (current_MissionTime_Temp(enum_releaseRegion) / 1000) > (prev_MissionTime_Temp(enum_releaseRegion) / 1000)
	(current_MissionTime_Temp(enum_releaseRegion) / 1000) - (prev_MissionTime_Temp(enum_releaseRegion) / 1000) > 0

function current_MissionTime_ChapterSection(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_ChapterSection", enum_releaseRegion))

function prev_MissionTime_ChapterSection(enum_releaseRegion) =>
	prev(current_MissionTime_ChapterSection(enum_releaseRegion))

function current_MissionTime_ChapterTotal(enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:MissionTime_ChapterTotal", enum_releaseRegion))

function prior_MissionTime_ChapterTotal(enum_releaseRegion) =>
	prior(current_MissionTime_ChapterTotal(enum_releaseRegion))

function prev_MissionTime_ChapterTotal(enum_releaseRegion) =>
	prev(current_MissionTime_ChapterTotal(enum_releaseRegion))

function current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) =>
	// NOTE: only valid when is_flagState_InGame_true() - when is_flagState_InGame_false(): only check current_MissionTime_ChapterTotal()
	current_MissionTime_Temp(enum_releaseRegion) 
	+ current_MissionTime_ChapterSection(enum_releaseRegion) 
	+ current_MissionTime_ChapterTotal(enum_releaseRegion)
	
function prev_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) =>
	prev(current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion))

function on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion) => // NOTE: Triggers when 32-bit overflow occurs; calculated_TotalMissionTime() increments based on FPS (25FPS increments by 40; 60FPS increments by 16.67)
	0xFFFFFFFF - 1000 <= prev_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) // --> 1 second (= 1000ms) under 0xFFFFFFFF
	// && prev_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) <= 0xFFFFFFFF // DISABLED - Line is alwaysTrue (unnecessary)
	// && 0x0 <= current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) // DISABLED - Line is alwaysTrue (unnecessary)
	&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) <= 0x0 + 1000 // --> 1 second (= 1000ms) above 0x0

// -------------------------------------
function on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion) =>
	is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
	&& is_ChapterSection(enum_chapter, CHAPTER_SECTION_1, enum_releaseRegion)
	&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0 
	&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)

function on_ChapterSection_startFromBeginning(enum_chapter, enum_chapterSection, enum_releaseRegion) =>
	is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
	&& is_ChapterSection(enum_chapter, enum_chapterSection, enum_releaseRegion)
	&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)

function on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion) { 
	let_lastChapterSection = LEVEL_DATA_getLastFullStringChapterSectionIndex(enum_chapter)
	return 
		is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
		&& is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)
		&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
		&& on_MissionTime_Temp_start(enum_releaseRegion)
	}

function on_AnyChapterSection_startFromBeginning(enum_releaseRegion) =>
	current_MissionTime_ChapterSection(enum_releaseRegion) == 0
	&& on_MissionTime_Temp_start(enum_releaseRegion)
// #endregion In-Game Statistics

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
function is_WatchingFMV_viaExtrasMenu(enum_releaseRegion) =>
	is_MainMenu_SubMenuID(MAINMENU_SUBMENU_ExtrasMenu, enum_releaseRegion)
	&& is_anyFMV_active(enum_releaseRegion)

function is_atMainMenu(enum_releaseRegion) =>
	is_FMV_active(FMV_MainMenu, enum_releaseRegion)

function on_MainMenu_enter(enum_releaseRegion) =>
	on_FMV_start(FMV_MainMenu, enum_releaseRegion)

// #endregion FMV ID

// ......................
// ◦ HUD Control Health ◦
// ''''''''''''''''''''''
// #region HUD Control Health

// ---------------BossHP--------------------
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
// ---------------PowerIcon(top-left)--------------------
POWER_SilverBrand = "Silv" // FullString: "SilverBrandRune"
POWER_Fear = "Fear" // FullString: "FearRune"
POWER_MysticArmour = "Myst" // FullString: "MysticArmourRune"
POWER_Vindicator = "Vind" // FullString: "VindicatorRune"
POWER_BloodFrenzy = "Bloo" // FullString: "BloodFrenzyRune"
POWER_Turn = "Turn" // FullString: "TurnRune"
POWER_BlackShroud = "Blac" // FullString: "BlackShroudRune"
POWER_SoulStealer = "Soul" // FullString: "SoulStealerRune"

CONST_POWER_DATA = {
	POWER_SilverBrand: {
		"PowerReputation": "Good",
		"PowerTier": 1,
		},
	POWER_Fear: {
		"PowerReputation": "Good",
		"PowerTier": 2,
		},
	POWER_MysticArmour: {
		"PowerReputation": "Good",
		"PowerTier": 3,
		},
	POWER_Vindicator: {
		"PowerReputation": "Good",
		"PowerTier": 4,
		},
	POWER_BloodFrenzy: {
		"PowerReputation": "Evil",
		"PowerTier": 1,
		},
	POWER_Turn: {
		"PowerReputation": "Evil",
		"PowerTier": 2,
		},
	POWER_BlackShroud: {
		"PowerReputation": "Evil",
		"PowerTier": 3,
		},
	POWER_SoulStealer: {
		"PowerReputation": "Evil",
		"PowerTier": 4,
		},
	}

function POWER_DATA_getPowerReputation(enum_power) =>
	CONST_POWER_DATA[enum_power]["PowerReputation"]

function POWER_DATA_getPowerTier(enum_power) =>
	CONST_POWER_DATA[enum_power]["PowerTier"]

function POWER_DATA_getAllEvilPowers() =>
	array_filter(CONST_POWER_DATA, (enum_power) {
		if (POWER_DATA_getPowerReputation(enum_power) == "Evil") return true
		return false
	})

function POWER_DATA_getAllGoodPowers() =>
	array_filter(CONST_POWER_DATA, (enum_power) {
		if (POWER_DATA_getPowerReputation(enum_power) == "Good") return true
		return false
	})

function POWER_DATA_getAllPowersOfTier(int_tier) =>
	array_filter(CONST_POWER_DATA, (enum_power) {
		if (POWER_DATA_getPowerTier(enum_power) == int_tier) return true
		return false 
	})

function POWER_DATA_getAllPowersOfTiers(array_tiers) =>
	array_filter(CONST_POWER_DATA, (enum_power) {
		if (array_contains(array_tiers, POWER_DATA_getPowerTier(enum_power))) return true
		return false 
	})

function ASCII_MEM_ADDR_PowerIconTopLeft(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:HUDcontrol_Health-Player1", enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:HUDcontrol_Health", "ASCII:PowerIconTopLeft", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:HUDcontrol_Health", "ASCII:PowerIconTopLeft")
	return let_memAddr_ASCII}

function is_PowerIconTopLeft(enum_power, enum_releaseRegion) =>
	dword(ASCII_MEM_ADDR_PowerIconTopLeft(enum_releaseRegion)) == memUtil_asciiStringToHexLE(enum_power)

function is_InSunlight(enum_releaseRegion) {
	const_ASCII_FLAG_PowerIconTopLeft_SunlightState = "SunlightState"
	return is_ASCII_EqualTo(ASCII_MEM_ADDR_PowerIconTopLeft(enum_releaseRegion), const_ASCII_FLAG_PowerIconTopLeft_SunlightState)}	


// #endregion HUD Control Health

// ....................
// ◦ HUD Control Gear ◦
// ''''''''''''''''''''
// #region HUD Control Gear
THROWABLE_Dynamite = "Dyna" // FullString: "Dynamite"
THROWABLE_SplitterGrenades = "Spli" // FullString: "SplitterGrenades"

function current_ThrowableType(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_offsetTo_ASCII = memory_getStruct_OffsetToPointedToMember("Pointer:UIcontrol", "ASCII:Equipped_ThrowableNameID")
	return memGenerate_pointerChainAccessor(
		"Pointer:UIcontrol", "ASCII:Equipped_ThrowableNameID", 
		let_memAddr_BasePointer, int_offsetToPointedToMember = let_offsetTo_ASCII,
		memAccessorFunction_toPointedToMember = dword)}

function prev_ThrowableType(enum_releaseRegion) =>
	prev(current_ThrowableType(enum_releaseRegion))

function on_ThrowableType_switch(enum_releaseRegion) =>
	current_ThrowableType(enum_releaseRegion) != prev_ThrowableType(enum_releaseRegion)

function current_ThrowableCountInInventory(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Pointer:UIcontrol", "32-bit:ThrowableCountInInventory(display)", let_memAddr_BasePointer)}

function prev_ThrowableCountInInventory(enum_releaseRegion) =>
	prev(current_ThrowableCountInInventory(enum_releaseRegion))

function on_Throwable_use(enum_releaseRegion) =>
	current_ThrowableCountInInventory(enum_releaseRegion) < prev_ThrowableCountInInventory(enum_releaseRegion)

function on_HUDcontrolGear_weaponSwap(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_memAccessor_SubPointer = memGenerate_pointerChainAccessor("Pointer:UIcontrol", "Pointer:EquippedWeaponName", let_memAddr_BasePointer)
	return let_memAccessor_SubPointer != prev(let_memAccessor_SubPointer)}

function current_HUDcontrolGear_LoadedBullets(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Pointer:UIcontrol", "32-bit:EquippedWeapon_LoadedBullets(display)", let_memAddr_BasePointer)} 

function prev_HUDcontrolGear_LoadedBullets(enum_releaseRegion) =>
	prev(current_HUDcontrolGear_LoadedBullets(enum_releaseRegion))

function on_HUDcontrolGear_LoadedBullets_decrement(enum_releaseRegion) =>
	current_HUDcontrolGear_LoadedBullets(enum_releaseRegion) < prev_HUDcontrolGear_LoadedBullets(enum_releaseRegion)


// #endregion HUD Control Gear

// ...............
// ◦ Player Data ◦
// '''''''''''''''
// #region Player Data
// #region Misc Player Data
PLAYER_1 = "1"
PLAYER_2 = "2"

CONST_FLAG_IsNoPlayerProfileSelected = 0xFFFFFFFF

function current_PlayerProfileID(enum_player, enum_releaseRegion) =>
	dword(memory_getAddress("32-bit:SelectedPlayerProfileID:Player-1", enum_releaseRegion))

function is_PlayerProfile_selected(enum_player, enum_releaseRegion) =>
	current_PlayerProfileID(enum_player, enum_releaseRegion) != CONST_FLAG_IsNoPlayerProfileSelected

function is_PlayerProfile_notSelected(enum_player, enum_releaseRegion) =>
	current_PlayerProfileID(enum_player, enum_releaseRegion) == CONST_FLAG_IsNoPlayerProfileSelected
// ----------------ControllerConfig---------------------
CONTROLLER_CONFIG_Default = "Defa" // FullString: "Default"
CONTROLLER_CONFIG_Lefty = "Left" // FullString: "Lefty"
CONTROLLER_CONFIG_Hopalong = "Hopa" // FullString: "Hopalong"
CONTROLLER_CONFIG_Hoss = "Hoss" // FullString: "Hoss"

CONST_CONTROLLER_CONFIG_DATA = { // Configs changes in-game controls
	CONTROLLER_CONFIG_Default: {
		"Button_SightMode": "BitFlag:IsInputPressed_R3",
		"Button_ActivatePower": "BitFlag:IsInputPressed_R2",
		"Button_Shoot": "BitFlag:IsInputPressed_R1",
		},
	CONTROLLER_CONFIG_Lefty: {
		"Button_SightMode": "BitFlag:IsInputPressed_L3",
		"Button_ActivatePower": "BitFlag:IsInputPressed_L2",
		"Button_Shoot": "BitFlag:IsInputPressed_L1",
		},
	CONTROLLER_CONFIG_Hopalong: {
		"Button_SightMode": "BitFlag:IsInputPressed_R3",
		"Button_ActivatePower": "BitFlag:IsInputPressed_R2",
		"Button_Shoot": "BitFlag:IsInputPressed_R1",
		},
	CONTROLLER_CONFIG_Hoss: {
		"Button_SightMode": "BitFlag:IsInputPressed_R3",
		"Button_ActivatePower": "BitFlag:IsInputPressed_R2",
		"Button_Shoot": "BitFlag:IsInputPressed_R1",
		},
	}

function CONTROLLER_CONFIG_DATA_getButtonSightMode(enum_controllerConfig) =>
	CONST_CONTROLLER_CONFIG_DATA[enum_controllerConfig]["Button_SightMode"]

function CONTROLLER_CONFIG_DATA_getButtonActivatePower(enum_controllerConfig) =>
	CONST_CONTROLLER_CONFIG_DATA[enum_controllerConfig]["Button_ActivatePower"]

function CONTROLLER_CONFIG_DATA_getButtonShoot(enum_controllerConfig) =>
	CONST_CONTROLLER_CONFIG_DATA[enum_controllerConfig]["Button_Shoot"]

function ASCII_MEM_ADDR_ControllerConfig(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:Controls_ControllerConfig-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	let_memAddr_ASCII = 
		dword(let_memAddr_BasePointer) 
		+ memory_getStruct_OffsetToPointedToMember("Pointer:HUDcontrol_Health", "ASCII:PowerIconTopLeft")
	return let_memAddr_ASCII}

function is_ControllerConfig(enum_player, enum_controllerConfig, enum_releaseRegion) =>
	is_ASCII_EqualTo(ASCII_MEM_ADDR_ControllerConfig(enum_player, enum_releaseRegion), enum_controllerConfig)
// -------------------------------------
function current_flagState_IsPlayerMounted(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer(EntityData_B):PlayerActorData-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerEntityData", "BitFlag:IsPlayerMounted", let_memAddr_BasePointer,
		memAccessorFunction_toPointedToMember = bit0)}

function prev_flagState_IsPlayerMounted(enum_player, enum_releaseRegion) =>
	prev(current_flagState_IsPlayerMounted(enum_player, enum_releaseRegion))

function on_flagState_IsPlayerMounted_change(enum_player, enum_releaseRegion) => 
	current_flagState_IsPlayerMounted(enum_player, enum_releaseRegion) != prev_flagState_IsPlayerMounted(enum_player, enum_releaseRegion)

function on_Player_mount(enum_player, enum_releaseRegion) =>
	current_flagState_IsPlayerMounted(enum_player, enum_releaseRegion) > prev_flagState_IsPlayerMounted(enum_player, enum_releaseRegion)

function on_Player_dismount(enum_player, enum_releaseRegion) =>
	current_flagState_IsPlayerMounted(enum_player, enum_releaseRegion) < prev_flagState_IsPlayerMounted(enum_player, enum_releaseRegion)

// #endregion Misc Player Data
// #region Player Gauges
// ----------------Health (HP)---------------------
CONST_PLAYER_MAX_HP = 100.0
CONST_PLAYER_MAX_VAMPIRESHIELD = 100.0
CONST_PLAYER_MAX_BLOODPOWER = 30.0

function current_Player_HP(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer(EntityData_B):PlayerActorData-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerEntityData", "Float:PlayerHealth(functional)", let_memAddr_BasePointer,
		memAccessorFunction_toPointedToMember = float)}

function prev_Player_HP(enum_player, enum_releaseRegion) =>
	prev(current_Player_HP(enum_player, enum_releaseRegion))

function on_Player_death(enum_player, enum_releaseRegion) =>
	current_Player_HP(enum_player, enum_releaseRegion) == 0 
	&& prev_Player_HP(enum_player, enum_releaseRegion) > 0
// ----------------VampireShield---------------------
function current_Player_VampireShield(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer(EntityData_B):PlayerActorData-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerEntityData", "Float:VampireShield(functional)", let_memAddr_BasePointer,
		memAccessorFunction_toPointedToMember = float)}

function prev_Player_VampireShield(enum_player, enum_releaseRegion) =>
	prev(current_Player_VampireShield(enum_player, enum_releaseRegion))
// ----------------BloodPowerGauge---------------------
function current_Player_BloodPowerGauge(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer(EntityData_B):PlayerActorData-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:PlayerEntityData", "Float:BloodPowerGauge(functional)", 
		let_memAddr_BasePointer, memAccessorFunction_toPointedToMember = float)
	}

function prev_Player_BloodPowerGauge(enum_player, enum_releaseRegion) =>
	prev(current_Player_BloodPowerGauge(enum_player, enum_releaseRegion))

function on_Player_Power_use(enum_player, enum_releaseRegion) =>
	current_Player_BloodPowerGauge(enum_player, enum_releaseRegion) == 0.0
	&& prev_Player_BloodPowerGauge(enum_player, enum_releaseRegion) == CONST_PLAYER_MAX_BLOODPOWER
// #endregion Player Gauges
// #region Difficulty
// ----------------Difficulty---------------------
DIFFICULTY_Greenhorn = 0x0	// --> These are the DifficultyIDs
DIFFICULTY_Cowboy = 0x1
DIFFICULTY_Shootist = 0x2
DIFFICULTY_Deadeye = 0x3

function current_Difficulty(enum_releaseRegion) => 
	low4(memory_getAddress("Lower4:DifficultyID(preferred)", enum_releaseRegion))

function is_Difficulty(enum_difficulty, enum_releaseRegion) => 
	current_Difficulty(enum_releaseRegion) == enum_difficulty

function is_DifficultyOrHarder(enum_difficulty, enum_releaseRegion) =>
	current_Difficulty(enum_releaseRegion) >= enum_difficulty

// #endregion Difficulty
// #region Weapon ID
// ----------------WeaponID---------------------
WEAPON_Pistol = 0x0		// --> These are the WeaponIDs
WEAPON_Redeemer = 0x1
WEAPON_DualPistols = 0x2
WEAPON_HorseRevolver = 0x3
WEAPON_Carbine = 0x4
WEAPON_Shotgun = 0x5
WEAPON_RailRocket = 0x6
WEAPON_Crossbow = 0x7
WEAPON_RangeRifle = 0x8
WEAPON_Scepter = 0x9

const_WEAPON_DATA = {
	WEAPON_Pistol: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Pistol",
		"isDarkwatchWeapon": false // --> Starting Pistol
		},
	WEAPON_Redeemer: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Redeemer",
		"isDarkwatchWeapon": true
		},
	WEAPON_DualPistols: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_DualPistols",
		"isDarkwatchWeapon": true
		},
	WEAPON_HorseRevolver: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_HorseRevolver",
		"isDarkwatchWeapon": true
		},
	WEAPON_Carbine: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Carbine",
		"isDarkwatchWeapon": true
		},
	WEAPON_Shotgun: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Shotgun",
		"isDarkwatchWeapon": true
		},
	WEAPON_RailRocket: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_RailRocket",
		"isDarkwatchWeapon": true
		},
	WEAPON_Crossbow: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Crossbow",
		"isDarkwatchWeapon": true
		},
	WEAPON_RangeRifle: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_RangeRifle",
		"isDarkwatchWeapon": true
		},
	WEAPON_Scepter: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Scepter",
		"isDarkwatchWeapon": true
		},
	}

function WEAPON_DATA_getMemberKey_WeaponEquipTime(enum_weapon) =>
	const_WEAPON_DATA[enum_weapon]["memberKey_WeaponEquipTime"]

function WEAPON_DATA_IsDarkwatchWeapon(enum_weapon) =>
	const_WEAPON_DATA[enum_weapon]["isDarkwatchWeapon"]

function WEAPON_DATA_getAllDarkwatchWeaponIDs() =>
	array_filter(const_WEAPON_DATA, enum_weapon => WEAPON_DATA_IsDarkwatchWeapon(enum_weapon))

function WEAPON_DATA_getAllWeaponIDs() =>
	array_map(const_WEAPON_DATA, enum_weapon => enum_weapon)

function current_EquippedWeapon(enum_player, enum_weapon, enum_releaseRegion) {
	let_memAddrKey = format("8-bit:EquippedWeapon_WeaponID-Player{0}", enum_player)
	return byte(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function is_EquippedWeapon(enum_player, enum_weapon, enum_releaseRegion) =>
	current_EquippedWeapon(enum_player, enum_weapon, enum_releaseRegion) == enum_weapon

// #endregion Weapon ID
// #region Accuracy
// ----------------Accuracy---------------------
function current_ShotsFired_Temp(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_Temp-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_Temp(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_Temp-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}
	
function current_ShotsFired_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsFired_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsFired_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_ShotsHit_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:ShotsHit_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}
// -------------------------------------
function current_calculated_Accuracy_FullTotal(enum_player, enum_releaseRegion) => /* MANUAL_CONSTRUCTION:current_calculated_Accuracy_FullTotal - R/R usage
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
	current_ShotsFired_Temp(enum_player, enum_releaseRegion) 
	+ current_ShotsFired_ChapterTotal(enum_player, enum_releaseRegion)
	+ current_ShotsFired_ChapterSection(enum_player, enum_releaseRegion)
	+ current_ShotsHit_Temp(enum_player, enum_releaseRegion) 
	+ current_ShotsHit_ChapterTotal(enum_player, enum_releaseRegion)
	+ current_ShotsHit_ChapterSection(enum_player, enum_releaseRegion)

function current_calculated_Accuracy_ChapterTotal(enum_player, enum_releaseRegion) => /* MANUAL_CONSTRUCTION:current_calculated_Accuracy_ChapterTotal - R/R usage
	PAL:	K:0xX00965c54/f1.0_A:0xX00965c58/{recall}_f0.0=3735928559
	NTSCU:	xxxxx
	-------------
	Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
	AddSource	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by float, creates a float
				Float 0.0 == 0xDEADBEEF
	*/
	current_ShotsFired_ChapterTotal(enum_player, enum_releaseRegion) 
	+ current_ShotsHit_ChapterTotal(enum_player, enum_releaseRegion)
	

// #endregion Accuracy
// #region Other Stats
// ----------------PlayerDeaths---------------------
function current_PlayerDeaths_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:PlayerDeaths_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_PlayerDeaths_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:PlayerDeaths_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function prev_PlayerDeaths_ChapterSection(enum_player, enum_releaseRegion) =>
	prev(current_PlayerDeaths_ChapterSection(enum_player, enum_releaseRegion))

function prev_PlayerDeaths_ChapterTotal(enum_player, enum_releaseRegion) =>
	prev(current_PlayerDeaths_ChapterTotal(enum_player, enum_releaseRegion))

function on_PlayerDeaths_ChapterSection_increment(enum_player, enum_releaseRegion) =>
	current_PlayerDeaths_ChapterSection(enum_player, enum_releaseRegion) > prev_PlayerDeaths_ChapterSection(enum_player, enum_releaseRegion)

function on_PlayerDeaths_ChapterTotal_increment(enum_player, enum_releaseRegion) =>
	current_PlayerDeaths_ChapterTotal(enum_player, enum_releaseRegion) > prev_PlayerDeaths_ChapterTotal(enum_player, enum_releaseRegion)

// ----------------Kills---------------------
function current_Kills_Temp(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_Temp-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function prev_Kills_Temp(enum_player, enum_releaseRegion) =>
	prev(current_Kills_Temp(enum_player, enum_releaseRegion))

function on_Kills_Temp_increment(enum_player, enum_releaseRegion) =>
	current_Kills_Temp(enum_player, enum_releaseRegion) > prev_Kills_Temp(enum_player, enum_releaseRegion)

function on_Kills_Temp_incrementBy(int_incrementNumber, enum_player, enum_releaseRegion) =>
	current_Kills_Temp(enum_player, enum_releaseRegion) == prev_Kills_Temp(enum_player, enum_releaseRegion) + int_incrementNumber

function on_Kills_Temp_minIncrementBy(int_incrementNumber, enum_player, enum_releaseRegion) =>
	current_Kills_Temp(enum_player, enum_releaseRegion) >= prev_Kills_Temp(enum_player, enum_releaseRegion) + int_incrementNumber

function current_Kills_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_Kills_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:Kills_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_Kills_FullTotal(enum_player, enum_releaseRegion) =>
	current_Kills_Temp(enum_player, enum_releaseRegion)
	+ current_Kills_ChapterSection(enum_player, enum_releaseRegion)
	+ current_Kills_ChapterTotal(enum_player, enum_releaseRegion)

// ----------------HeadshotKills---------------------
function current_HeadshotKills_Temp(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_Temp-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function prev_HeadshotKills_Temp(enum_player, enum_releaseRegion) =>
	prev(current_HeadshotKills_Temp(enum_player, enum_releaseRegion))

function on_HeadshotKills_Temp_increment(enum_player, enum_releaseRegion) =>
	current_HeadshotKills_Temp(enum_player, enum_releaseRegion) > prev_HeadshotKills_Temp(enum_player, enum_releaseRegion)

function current_HeadshotKills_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_HeadshotKills_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:HeadshotKills_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_HeadshotKills_FullTotal(enum_player, enum_releaseRegion) =>
	current_HeadshotKills_Temp(enum_player, enum_releaseRegion)
	+ current_HeadshotKills_ChapterSection(enum_player, enum_releaseRegion)
	+ current_HeadshotKills_ChapterTotal(enum_player, enum_releaseRegion)

// ----------------MeleeKills---------------------
function current_MeleeKills_Temp(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_Temp-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function prev_MeleeKills_Temp(enum_player, enum_releaseRegion) =>
	prev(current_MeleeKills_Temp(enum_player, enum_releaseRegion))

function on_MeleeKills_Temp_increment(enum_player, enum_releaseRegion) =>
	current_MeleeKills_Temp(enum_player, enum_releaseRegion) > prev_MeleeKills_Temp(enum_player, enum_releaseRegion)

function current_MeleeKills_ChapterSection(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_ChapterSection-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_MeleeKills_ChapterTotal(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("32-bit:MeleeKills_ChapterTotal-Player{0}", enum_player)
	return dword(memory_getAddress(let_memAddrKey, enum_releaseRegion))}

function current_calculated_MeleeKills_FullTotal(enum_player, enum_releaseRegion) =>
	current_MeleeKills_Temp(enum_player, enum_releaseRegion)
	+ current_MeleeKills_ChapterSection(enum_player, enum_releaseRegion)
	+ current_MeleeKills_ChapterTotal(enum_player, enum_releaseRegion)


// #endregion Other Stats
// #region Saved Stats
// ----------------SavedStats_Gunslinger---------------------
CONST_NUMBER_OF_CHAPTERS = length(LEVEL_DATA_getAllGunslingerLevels()) // = 17

function current_SavedStatGunslinger_MissionTime(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat_MissionTime = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MissionTime") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat_MissionTime]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function prev_SavedStatGunslinger_MissionTime(enum_chapter, enum_releaseRegion) =>
	prev(current_SavedStatGunslinger_MissionTime(enum_chapter, enum_releaseRegion))

function on_SavedStatGunslinger_MissionTime_change(enum_chapter, enum_releaseRegion) =>
	current_SavedStatGunslinger_MissionTime(enum_chapter, enum_releaseRegion) != prev_SavedStatGunslinger_MissionTime(enum_chapter, enum_releaseRegion)

function current_SavedStatGunslinger_Difficulty(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat_Difficulty = memory_getStruct_OffsetToMember("Struct:ChapterStats", "Lower4:Difficulty") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat_Difficulty
	]

	return memGenerate_pointerChainAccessor_fromOffsets(
		let_memAddr_BasePointer, let_array_pointerChainOffsets, 
		memAccessorFunction_toPointedToMember = low4)
	}

function current_SavedStatGunslinger_PlayerDeaths(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:PlayerDeaths") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatGunslinger_HeadshotKills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:HeadshotKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatGunslinger_Kills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:Kills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatGunslinger_MeleeKills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MeleeKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatGunslinger_ShotsFired(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:ShotsFired") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatGunslinger_ShotsHit(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:ShotsHit") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}



function current_SavedStatGunslinger_WeaponEquipTime(enum_chapter, enum_weapon, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStatsGunslinger = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Gunslinger")	
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Gunslinger(enum_chapter)
	let_offsetToIndexedMember_Pointer_WeaponEquipTimes = memory_getStruct_OffsetToMember("Struct:ChapterStats", "Pointer:WeaponEquipTimes") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)
	let_memberKey_WeaponEquipTime = WEAPON_DATA_getMemberKey_WeaponEquipTime(enum_weapon)
	let_offsetToMember_WeaponEquipTime = memory_getStruct_OffsetToMember("Struct:WeaponEquipTimes", let_memberKey_WeaponEquipTime)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStatsGunslinger,
		let_offsetToIndexedMember_Pointer_WeaponEquipTimes,
		let_offsetToMember_WeaponEquipTime
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)
	}

// ----------------SavedStats_Story (SinglePlayer)---------------------
function current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MissionTime") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_Difficulty(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "Lower4:Difficulty") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_PlayerDeaths(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:PlayerDeaths") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_HeadshotKills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:HeadshotKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_Kills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:Kills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_MeleeKills(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MeleeKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_ShotsFired(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:ShotsFired") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_ShotsHit(enum_chapter, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:PlayerSavedStats-Player1", enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:ShotsHit") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) =>
	/* NOTE - OUTPUT:
		[SavedStats_Story_MissionTime_Chapter1] 
		+ [SavedStats_Story_MissionTime_Chapter2] 
		+ ... 
		+ [SavedStats_Story_MissionTime_Chapter8] 
		+ [SavedStats_Story_MissionTime_ChapterHubCitadel] 
		+ [SavedStats_Story_MissionTime_Chapter9] 
		+ .... 
		+ [SavedStats_Story_MissionTime_Chapter17]			*/
	sum_of(CONST_LEVEL_DATA, enum_chapter => 
		current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion)) 

function current_calculated_TotalStoryTime_whileInGame(enum_releaseRegion) => 
	current_MissionTime_Temp(enum_releaseRegion)
	+ current_MissionTime_ChapterSection(enum_releaseRegion)
	// + current_MissionTime_ChapterTotal(enum_releaseRegion) // DISABLED - Whenever [MissionTime_ChapterTotal] updates, it also updates the corresponding ChapterStat in [Array:SavedStats_Story] (thus when a StoryChapterSection ends && when a Chapter ends)
	+ current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion)
	
function prev_calculated_TotalStoryTime_whileInGame(enum_releaseRegion) =>
	prev(current_calculated_TotalStoryTime_whileInGame(enum_releaseRegion))

function on_calculated_TotalStoryTime_whileInGame_overflow(enum_releaseRegion) => // NOTE: Triggers when 32-bit overflow occurs; MissionTime increments based on FPS (25FPS: increments by 40 --- 60FPS: increments by 16.67)
	0xFFFFFFFF - 1000 <= prev_calculated_TotalStoryTime_whileInGame(enum_releaseRegion) // --> 1 second (= 1000ms) under 0xFFFFFFFF
	&& current_calculated_TotalStoryTime_whileInGame(enum_releaseRegion) <= 0x0 + 1000 // --> 1 second (= 1000ms) above 0x0

// #endregion Saved Stats

// #endregion Player Data

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
			// "id": 504289, "points": achievement_POINTS_5, "devInfo": "CHAPTER_1_WrongTrain Completion"}, 
		// "a_RideDevil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504290, "points": achievement_POINTS_5, "devInfo": "CHAPTER_2_RideDevil Completion"},
		// "a_Boneyard": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504291, "points": achievement_POINTS_5, "devInfo": "CHAPTER_3_Boneyard Completion"},
		// "a_DevilMine": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504292, "points": achievement_POINTS_5, "devInfo": "CHAPTER_4_DevilMine Completion"},
		// "a_DWOutpost": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504293, "points": achievement_POINTS_5, "devInfo": "CHAPTER_5_Outpost Completion"},
		// "a_WarTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504294, "points": achievement_POINTS_5, "devInfo": "CHAPTER_6_WarTrain Completion"}, 
		// "a_TortureMaze": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504295, "points": achievement_POINTS_5, "devInfo": "CHAPTER_7_TortureMaze Completion"}, 
		// "a_BaptismFire": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504296, "points": achievement_POINTS_5, "devInfo": "CHAPTER_8_BaptismFire Completion"}, 
		// "a_Rescue": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504297, "points": achievement_POINTS_5, "devInfo": "CHAPTER_9_Rescue Completion"},
		// "a_Prism": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504298, "points": achievement_POINTS_5, "devInfo": "CHAPTER_10_Prism Completion"},
		// "a_Invasion": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504299, "points": achievement_POINTS_5, "devInfo": "CHAPTER_11_Invasion Completion"},
		// "a_Hangtown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504300, "points": achievement_POINTS_5, "devInfo": "CHAPTER_12_Hangtown Completion"},
		// "a_MorningAfter": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504301, "points": achievement_POINTS_5, "devInfo": "CHAPTER_13_MorningAfter Completion"},
		// "a_Showdown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504302, "points": achievement_POINTS_5, "devInfo": "CHAPTER_14_Showdown Completion"},
		// "a_RightTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504303, "points": achievement_POINTS_5, "devInfo": "CHAPTER_15_RightTrain Completion"},
		// "a_Deadfall": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504304, "points": achievement_POINTS_5, "devInfo": "CHAPTER_16_Deadfall Completion"},
		},
	"c_SPend": { // Category - Singleplayer Story Ending
		// "a_CurseWestGood": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION 
			// "id": 504305, "points": achievement_POINTS_25, "devInfo": "CHAPTER_17_CurseWest Completion, Good ending"},		
		// "a_CurseWestEvil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 504306, "points": achievement_POINTS_25, "devInfo": "CHAPTER_17_CurseWest Completion, Evil ending"},
		},
	"c_Unlocks": { // Category - Unlockables in Gunslinger Mode // "Built-in" Gunslinger Challenges
		// "a_Boss": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506183, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Bosses Art'"},
		// "a_Enemy1": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506186, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Enemies 1"},
		// "a_Enemy2": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506261, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Enemies 2'"},
		// "a_Train": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506185, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Wrong Train Animatic'"},
		// "a_Guns": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506187, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Weapons'"},
		// "a_Drivers": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506264, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Vehicles'"},
		// "a_Sights1": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506219, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Environments 1'"},
		// "a_Sights2": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506387, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Environments 2'"},
		// "a_Sights3": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506184, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Environments 3'"},
		// "a_Attract": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506262, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Attract Mode Movie'"},
		// "a_Cowboy": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506260, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Cowboy Animatic'"},
		// "a_Shower": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506388, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Showdown Animatic'"},
		// "a_Intro": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506263, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Rescue Intro Movie'"},
		// "a_Moon": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506188, "points": achievement_POINTS_5, "devInfo": "Unlock Concept Art 'Highmoon Trailer'"},
		// "a_Archive": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 506807, "points": achievement_POINTS_25, "devInfo": "Unlock Concept Art 'Darkwatch Archives'"},
		},
	"c_Gunslinger": { // Category - "Custom" Gunslinger Challenges
		// "a_GunWrongTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 508863, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_1_WrongTrain on Deadeye difficulty, within xx time and without going below xx% HP (vampire shield excluded)"},
		// "a_GunRideDevil": { // VERIFIED  // DISABLED - MANUAL_CONSTRUCTION
			// "id": 509576, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_2_RideDevil on Deadeye difficulty, with a minimum accuracy of xx% and without going below xx% HP (vampire shield excluded)"},
		// "a_GunBoneyard": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 510041, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_3_Boneyard on Deadeye difficulty, no deaths, using only the Carbine or Crossbow, without scoring 5 body-shot kills in a row, mix in headshot or melee kills"},
		// "a_GunDevilMine": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 510690, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_4_DevilMine on Deadeye difficulty, killing only with the Redeemer and Dual Pistols equipped (without using any powers, Neutral powers excluded)"},
		// "a_GunDWOutpost": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511019, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_5_Outpost on Deadeye difficulty, without being below max HP for xx seconds consecutively"},
		// "a_GunWarTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511009, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_6_WarTrain on Deadeye difficulty, within xx time and without losing any HP (vampire shield excluded)"},
		// "a_GunTortureMaze": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511010, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_7_TortureMaze on Deadeye difficulty, only killing with the Scepter and Shotgun equipped, with at least 80% melee kills"},
		// "a_GunBaptismFire": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511021, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_8_BaptismFire on Deadeye difficulty, no deaths, without throwing any explosives, and killing at least 40 enemies with the Rail Rocket"},
		// "a_GunRescue": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511013, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_9_Rescue on Deadeye difficulty, without losing any HP (vampire shield excluded)"},
		// "a_GunPrism": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511014, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_10_Prism on Deadeye difficulty, within xx time and killing only with the Dual Pistols or Shotgun equipped"},
		// "a_GunInvasion": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511016, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_11_Invasion on Deadeye difficulty, using only 1 distinct power (Neutral powers excluded) and using it less than xx times"},
		// "a_GunHangtown": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511017, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_12_Hangtown on Deadeye difficulty, using the Range Rifle as the only means of shooting, with a minimum accuracy of xx%"},
		// "a_GunMorningAfter": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511015, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_13_MorningAfter on Deadeye difficulty, using only tier 2 or tier 3 powers with at least 45% melee kills"},
		// "a_GunShowdown": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511011, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_14_Showdown on Deadeye difficulty, with a minimum accuracy of xx% using only tier 1 powers"},
		// "a_GunRightTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511012, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_15_RightTrain on Deadeye difficulty, within xx time and without going below xx% HP (vampire shield excluded)"},
		// "a_GunDeadfall": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511018, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_16_Deadfall on Deadeye difficulty, only kill with the Range Rifle and Carbine equipped and with at least xx% headshot kills"},
		// "a_GunCurseWest": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 511020, "points": achievement_POINTS_10, "devInfo": "Complete CHAPTER_17_CurseWest on Deadeye difficulty, with less than xx power activations (Neutral powers excluded) and without dropping below xx% HP"}, 
		// "a_WeaponMaster": { // DISCONTINUED - Exceeds achievement logic size; weapon usage is incorporated into other achievements
			// "id": 000000, "points": 0000000, "devInfo": "Have each of the 9 Darkwatch weapons registered as a 'Favorite Weapon' for at least one Chapter in Gunslinger Mode (Pistol is excluded)"},
		},
	"c_Bonus": { // Category - Bonus/Easter Egg Achievements
		// "a_GatlingRightTrain": { // VERIFIED
			// "id": 518404, "points": achievement_POINTS_5, "devInfo": "In CHAPTER_15_RightTrain (only 1 CHAPTER_SECTION), use the gatling gun to kill xx enemies in a row without getting off, and without any HP damage on Shootist difficulty or higher. Enemies killed by exploding barrels are not counted"},
		// "a_GatlingPrism": { // VERIFIED
			// "id": 518403, "points": achievement_POINTS_5, "devInfo": "Last CHAPTER_SECTION of CHAPTER_10_Prism, use the gatling gun to kill xx enemies in a row without getting off, and without any HP damage on Shootist difficulty or higher. Enemies killed by exploding barrels are not counted"},
		// "a_Souler": { // CONCEPT a_Souler, something about finding all those taintedSouls??, although this is may only be trackable per Chapter??
			// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
		// "a_Jacker": { // CONCEPT a_Jacker (jack of all trades), possible to unlock 3 powers of each evil/good??
			// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
		// "a_FanHammer": { // CONCEPT a_FanHammer, can't find a reliable method to check when in "Fan The Hammer" mode
			// "id": 000000, "points": 0000000, "devInfo": "With Redeemer: Land xx shots in single Fan The Hammer volley"},
		// "a_SunPower": { // VERIFIED
			// "id": 510106, "points": achievement_POINTS_1, "devInfo": "Activate Power when in sunlight"},
		// "a_Multikill": { // VERIFIED
			// "id": 510105, "points": achievement_POINTS_5, "devInfo": "Kill xx enemies in one frame (use explosives or powers)"},
		// "a_AllPowersGood": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 510104, "points": achievement_POINTS_10, "devInfo": "Unlock all Good powers"},
		// "a_AllPowersEvil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 510103, "points": achievement_POINTS_10, "devInfo": "Unlock all Evil powers"},
		
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
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
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
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
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

							Val 0x0 == Val 0x1					
				*/
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

function achGenerate_FullTrigger_SingleplayerLevelProgression_NoFMV(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[5])
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
function achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[4])
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
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 		-> Reset when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION (AltGroup[4]) - R/R usage
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
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-3FD]

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
		|| achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

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
			
			/* MANUAL_CONSTRUCTION[0ACC-4ACC]:CheckAccuracy (below 3 lines): R/R usage 
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
		/* MANUAL_CONSTRUCTION[0ACC-5ACC]:MeasuredAccuracy (below Measured): R/R usage
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
		|| achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_GunslingerUnlock_Time(enum_chapter, int_timeLimit, enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION
	// NOTE: int_timeLimit in milliseconds (1 min = 60.000 ms)
	return 
	// [1/9] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			is_flagState_InGame_true(enum_releaseRegion)
			&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
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
	// [2/10] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			is_flagState_InGame_true(enum_releaseRegion)
			&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
		&& unless( // --PauseIf--> MissionTime exceeds time limit
			is_flagState_InGame_true(enum_releaseRegion)
			&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > int_timeLimit)
		/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured): R/R usage
			// WARNING - Edit int_timeLimit
			PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
			NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
			''''''''''''''
			AddSource	[32-bit:MissionTime_Temp]
			AddSource	[32-bit:MissionTime_ChapterSection]
			AddSource	[32-bit:MissionTime_ChapterTotal]
			Remember	Val 0
			Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
			AddSource	(int_timeLimit/1000) - Recall
			Measured	Val 0 == (int_timeLimit/1000) 		*/				
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
		&& measured(
			current_MissionTime_Temp(enum_releaseRegion) 
			+ current_MissionTime_ChapterSection(enum_releaseRegion) 
			+ current_MissionTime_ChapterTotal(enum_releaseRegion) == int_timeLimit / 1000,
			when = 
				memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
			)
		&& trigger_when(always_false())
	// [3/11] ==== Alt Measured Group (Not In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
			is_flagState_InGame_true(enum_releaseRegion)
			&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion))) 
		/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured): R/R usage 
			// WARNING - Edit int_timeLimit
			PAL:	K:0xX00965c3c/f1000.0_A:f600.0-{recall}_M:0=f600.0
			NTSCU:	K:0xX00953c5c/f1000.0_A:f600.0-{recall}_M:0=f600.0
			''''''''''''''
			Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
			AddSource	(int_timeLimit/1000) - Recall
			Measured	Val 0 == (int_timeLimit/1000) 		*/				
		&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
		&& measured(
			current_MissionTime_ChapterTotal(enum_releaseRegion) == int_timeLimit / 1000,
			when = 
				memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
				&& is_flagState_InGame_false(enum_releaseRegion)
				&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
					on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
			)
		&& trigger_when(always_false())
	// [4/12] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_ChapterSection(enum_chapter, CHAPTER_SECTION_1, enum_releaseRegion)
			/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
				PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
				NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
				*/
			&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
	// [5+6+7+8/13+14+15+16] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION:ResetOn_PauseMenu_Quit (AltGroup[8/16]): R/R usage
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		|| achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
	}

function achGenerate_FullTrigger_GunslingerUnlock_MeleeKills(enum_chapter, int_requiredMeleeKills, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* MANUAL_CONSTRUCTION (AltGroup[7])
		PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
		NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
		*/
	// [1] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
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
		|| achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION

function achGenerate_FullTrigger_GunslingerUnlock_HeadshotKills(enum_chapter, int_requiredHeadshotKills, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// [1] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
		unless(!is_ReleaseRegion(enum_releaseRegion))
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
		|| achGenerate_4x_AltResetGroups_GunslingerChallenge(enum_chapter, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
// ----------------Bonus---------------------
function achGenerate_FullTrigger_GatlingGunner(enum_chapter, enum_chapterSectionWithGatlingGun, enum_difficultyMinimum, int_requiredGatlingGunKillStreak, enum_releaseRegion) => 
	// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement			
		measured(
			repeated(int_requiredGatlingGunKillStreak,
				never( // --ResetNextIf--> When player vampire shield below 50%.
					current_flagState_IsPlayerMounted(PLAYER_1, enum_releaseRegion) == 1
					&& current_Player_VampireShield(PLAYER_1, enum_releaseRegion) < CONST_PLAYER_MAX_VAMPIRESHIELD * 0.50)
				&& current_flagState_IsPlayerMounted(PLAYER_1, enum_releaseRegion) == 1
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),
			when =
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& is_DifficultyOrHarder(enum_difficultyMinimum, enum_releaseRegion)
				&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
				&& is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
				&& is_ChapterSection(enum_chapter, enum_chapterSectionWithGatlingGun, enum_releaseRegion)
				&& once(on_Player_mount(PLAYER_1, enum_releaseRegion))
		)
	// [2] ==== Alt Trigger Group ====		--> Group is only responsible for displaying a Trigger Indicator when on the gatling gun.
		|| is_ReleaseRegion(enum_releaseRegion)
		&& is_flagState_InGame_true(enum_releaseRegion)
		&& is_DifficultyOrHarder(enum_difficultyMinimum, enum_releaseRegion)
		&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
		&& is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
		&& is_ChapterSection(enum_chapter, enum_chapterSectionWithGatlingGun, enum_releaseRegion)
		&& current_Player_VampireShield(PLAYER_1, enum_releaseRegion) >= CONST_PLAYER_MAX_VAMPIRESHIELD * 0.50 // --CheckIf--> Vampire Shield >= 50%
		&& once(on_Player_mount(PLAYER_1, enum_releaseRegion))
		&& trigger_when(always_false())
	// [3] ==== Alt Reset Group ====		--> Reset when dismounting the gatling gun
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& on_Player_dismount(PLAYER_1, enum_releaseRegion))
	// [4] ==== Alt Reset Group ====		--> Reset when CHAPTER_SECTION with GatlingGun starts from beginning
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_ChapterSection_startFromBeginning(enum_chapter, enum_chapterSectionWithGatlingGun, enum_releaseRegion))
// -------------------------------------

function achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion) =>
	// [5/] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
		never( // --Lockout--> When PLAYER_1 dies
			is_ReleaseRegion(enum_releaseRegion)
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& on_Player_death(PLAYER_1, enum_releaseRegion))
		&& always_false()
function achGenerate_Measured_GunslingerChaptersCompletedOnDeadeyeDifficulty(enum_releaseRegion) {
	let_array_AllGunslingerLevels = LEVEL_DATA_getAllGunslingerLevels()
	return measured(tally_of(let_array_AllGunslingerLevels, length(let_array_AllGunslingerLevels), enum_chapter => 
			once(
				never(current_SavedStatGunslinger_Difficulty(enum_chapter, enum_releaseRegion) != DIFFICULTY_Deadeye) 
				&& current_SavedStatGunslinger_Difficulty(enum_chapter, enum_releaseRegion) == DIFFICULTY_Deadeye)
			)
		)
	}

function achGenerate_TallyOf_GunslingerAllDarkwatchWeaponsFavoritedOnce(enum_releaseRegion) { // DISABLED - Exceeds achievement logic size
	let_array_Weapons_AllhWeaponIDs = WEAPON_DATA_getAllWeaponIDs()
	let_uniqueDarkwatchWeaponsCount = length(WEAPON_DATA_getAllDarkwatchWeaponIDs()) // = 9 (excluding WEAPON_Pistol)

	return tally_of(let_array_Weapons_AllhWeaponIDs, let_uniqueDarkwatchWeaponsCount, (enum_weapon_toCheck) { // Loop through all 9 Darkwatch weapons (WEAPON_Pistol excluded)
		if (enum_weapon_toCheck == WEAPON_Pistol) return always_false() // --> Pistol is the starting weapon, don't check this.

		let_array_AllGunslingerLevelIndices = util_generateArrayOfIntegers_startAtZero(CONST_NUMBER_OF_CHAPTERS - 1)
		let_array_AllComparisons = []
		for let_gunslingerLevelStatIndex in let_array_AllGunslingerLevelIndices { // Loop through all 17 Gunslinger Chapters/Levels' SavedStats

			// Returns a subset array of let_array_Weapons_AllhWeaponIDs without the enum_weapon_toCheck
			let_array_Weapons_ToCheckAgainst = array_filter(let_array_Weapons_AllhWeaponIDs, (enum_w) { 
				if (enum_w == enum_weapon_toCheck) return false
				else return true
			})


			// ---------Generate AddHitClause---------
			let_array_comparisons_AddHitClause = []
			for enum_weapon_ToCheckAgainst in let_array_Weapons_ToCheckAgainst {
				if (enum_weapon_toCheck > enum_weapon_ToCheckAgainst) // CheckIf: WeaponID(enum_weapon_toCheck) is greater than WeaponID(enum_weapon_ToCheckAgainst); when WeaponEquipTime is equal to another WeaponEquipTime, the weapon with the lowest WeaponID is 'Favorite Weapon'
					array_push(let_array_comparisons_AddHitClause, 
						current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
						> current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_ToCheckAgainst, enum_releaseRegion))
				else 
					array_push(let_array_comparisons_AddHitClause,
						current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
						>= current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_ToCheckAgainst, enum_releaseRegion))				
			}
			array_push(let_array_comparisons_AddHitClause, 
				current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
				!= 0x0)


			// ---------Generate SubHitClause---------
			let_array_comparisons_SubHitClause = []
			for enum_weapon_ToCheckAgainst in let_array_Weapons_ToCheckAgainst {
				if (enum_weapon_toCheck > enum_weapon_ToCheckAgainst) // CheckIf: WeaponID(enum_weapon_toCheck) is greater than WeaponID(enum_weapon_ToCheckAgainst); when WeaponEquipTime is equal to another WeaponEquipTime, the weapon with the lowest WeaponID is 'Favorite Weapon'
					array_push(let_array_comparisons_SubHitClause, 
						current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
						<= current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_ToCheckAgainst, enum_releaseRegion))
				else 
					array_push(let_array_comparisons_SubHitClause,
						current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
						< current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_ToCheckAgainst, enum_releaseRegion))
			}
			array_push(let_array_comparisons_SubHitClause, 
				current_SavedStatGunslinger_WeaponEquipTime(let_gunslingerLevelStatIndex, enum_weapon_toCheck, enum_releaseRegion) 
				!= 0x0)
				
				
			array_push(let_array_AllComparisons, once(all_of(let_array_comparisons_AddHitClause, let_comparison => let_comparison)))
			array_push(let_array_AllComparisons, deduct(once(all_of(let_array_comparisons_SubHitClause, let_comparison => let_comparison))))
		}
		// ---------Expression of current let_GunslingerLevelIndex---------
		return tally(1, let_array_AllComparisons)
	})}

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
	"a_Sights1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION
		// TODO: Add AltResetGroup when pressing PauseMenu->Restart in ChapterSection_1, so player doesnn't have to quit and restart whole chapter when in ChapterSection_1 
		const_REQUIRED_CHAPTER = CHAPTER_5_Outpost
		return 
		// [1/8] ==== Alt Logic Group ==== 					-> This group handles the achievement logic; This group is responsible for unlocking the achievement
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
		// [2/9] ==== Alt Trigger Group ==== 					-> This group only responsible for displaying a Trigger Indicator as long as player has not died
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When player has died once
				on_PlayerDeaths_ChapterSection_increment(PLAYER_1, enum_releaseRegion)
				|| on_PlayerDeaths_ChapterTotal_increment(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning
				on_Chapter_startFromBeginning(const_REQUIRED_CHAPTER, enum_releaseRegion))
			&& trigger_when(always_false())
		// [3/10] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_REQUIRED_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [4+5+6+7/11+12+13+14] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			/* MANUAL_CONSTRUCTION (AltGroup[7/14])
				PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
				NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
				*/
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_REQUIRED_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_Sights2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_MIN_REQUIRED_DIFFICULTY = DIFFICULTY_Deadeye
		return achGenerate_FullTrigger_GunslingerUnlock_Difficulty(CHAPTER_11_Invasion, const_MIN_REQUIRED_DIFFICULTY, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Sights3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION
		// TODO: Add AltResetGroup when pressing PauseMenu->Restart in ChapterSection_1, so player doesnn't have to quit and restart whole chapter when in ChapterSection_1 
		const_TIME_LIMIT = 600000.0 // 600.000 ms = 10 mins
		return achGenerate_FullTrigger_GunslingerUnlock_Time(CHAPTER_17_CurseWest, const_TIME_LIMIT, enum_releaseRegion)}),	// --> (4x) MANUAL_CONSTRUCTION
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
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(CHAPTER_10_Prism, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
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
	"a_Intro": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		const_REQUIRED_HEADSHOTKILLS = 20
		/* MANUAL_CONSTRUCTION (AltGroup[7/14])
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/
		return achGenerate_FullTrigger_GunslingerUnlock_HeadshotKills(CHAPTER_12_Hangtown, const_REQUIRED_HEADSHOTKILLS, enum_releaseRegion)}), // --> (1x) MANUAL_CONSTRUCTION
	"a_Moon": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION
		// TODO: Add AltResetGroup when pressing PauseMenu->Restart in ChapterSection_1, so player doesnn't have to quit and restart whole chapter when in ChapterSection_1 
		const_TIME_LIMIT = 900000.0 // 900.000 ms = 15 mins
		return achGenerate_FullTrigger_GunslingerUnlock_Time(CHAPTER_9_Rescue, const_TIME_LIMIT, enum_releaseRegion)}),	// --> (4x) MANUAL_CONSTRUCTION
	"a_Archive": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
		let_array_AllGunslingerLevels = LEVEL_DATA_getAllGunslingerLevels()
		return
		// [1] ==== Alt Logic Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--> Any Gunslinger ChapterSection is started from beginning 
				on_AnyChapterSection_startFromBeginning(enum_releaseRegion))
			&& once( // --CheckIf--> Player leaves InGame + All Gunslinger Chapters completed on Deadeye Difficulty
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& all_of(let_array_AllGunslingerLevels, enum_chapter => 
					current_SavedStatGunslinger_Difficulty(enum_chapter, enum_releaseRegion) == DIFFICULTY_Deadeye) // ---> No delta check included: This allow the achievement to be unlocked even if all Chapters have already been completed on Deadeye difficulty
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
	"a_GunWrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION (AltGroup[2+3+5+9])
		const_CHAPTER = CHAPTER_1_WrongTrain
		const_TIME_LIMIT = 240000 // 240.000 ms = 4 min
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP * 0.4 // % of max HP
		return 
		// [1/10] ==== Alt Logic + Triggered Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying a Trigger Indicator as long as HP hasn't dropped below xx% 
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& unless( // --PauseIf--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + MissionTime is within time limit  + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= const_TIME_LIMIT
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& unless( // --PauseIf--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured): R/R usage
				// WARNING - Edit const_TIME_LIMIT
				PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f240.0-{recall}_M:0=f240.0
				NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f240.0-{recall}_M:0=f240.0
				''''''''''''''
					AddSource	[32-bit:MissionTime_Temp]
					AddSource	[32-bit:MissionTime_ChapterSection]
					AddSource	[32-bit:MissionTime_ChapterTotal]
					Remember	Val 0
					Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/12] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			&& unless(once( // --PauseLock--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& unless( // --PauseIf--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured): R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f240.0-{recall}_M:0=f240.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f240.0-{recall}_M:0=f240.0
				''''''''''''''
					Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					---------
						AndNext		[8-bit:GameState] == 0x3						| CheckIf: is_AnyInGameMenu_active() 

						-----Start of MANUAL_CONSTRUCTION-----

						AddAddress	[Pointer:UIcontrol(preferred)]
						Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
						Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

						AddAddress	[Pointer:UIcontrol(preferred)]
						AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
						Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 
						
						AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
						AddAddress	->[Mem 32-bit] 0xB8
						AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 	| CheckIf: FrameTitle == "Restart"
						
						AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
						AddAddress	->[Mem 32-bit] 0x7C
						AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_RestartConfirmationMenu_Yes_highlighted()

						-----End of MANUAL_CONSTRUCTION-----

						AddAddress	[Pointer:PlayerInput(preferred)]
						AndNext		->[Mem Bit0] 0xF 	> 	->[Delta Bit0] 0xF		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)
						*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunRideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+5+9])
		const_CHAPTER = CHAPTER_2_RideDevil
		const_MIN_REQUIRED_ACCURACY = 0.70
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP * 0.4 // % of max HP
		return 
		// [1/10] ==== Alt Logic + Triggered Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying Trigger Indicator as long as HP hasn't dropped below xx% 
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[2ACC-1ACC]:CheckAccuracyNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}<f0.70
					NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}<f0.70
					-----------
						Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_ACCURACY			*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
				&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_ACCURACY
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1ACC)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy achieved +  Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					
					/* MANUAL_CONSTRUCTION[2ACC-3ACC]:CheckAccuracyAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.70
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.70
						-----------
							Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_ACCURACY			*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
					&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_ACCURACY
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x3ACC)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			/* MANUAL_CONSTRUCTION[0ACC-5ACC]:MeasuredAccuracyWhileInGame (below Measured): R/R usage
				PAL:	A:0xX00965c20_K:0xX00965c54+0xX00965c88_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c40_K:0xX00953ca8+0xX00953c74_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				-----------
					AddSource	[32-bit:ShotsFired_Temp]
					Remember	[32-bit:ShotsFired_ChapterSection] + [32-bit:ShotsFired_ChapterTotal]
					Remember	Recall / 1.0								--> Force 32-bit to Float
					AddSource	[32-bit:ShotsHit_Temp] / Recall				--> Divide by Float, returns a Float
					AddSource	[32-bit:ShotsHit_ChapterSection] / Recall	--> Divide by Float, returns a Float
					Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0				*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& measured(
				current_calculated_Accuracy_FullTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 	
					memUtil_ManualConstruction_PlaceHolderRequirement(0x5ACC)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
					&& is_flagState_InGame_true(enum_releaseRegion),
				format = "percent")
			&& trigger_when(always_false())
		// [3/12] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			/* MANUAL_CONSTRUCTION[0ACC-6ACC]:MeasuredAccuracyWhileNotInGame (below Measured): R/R usage
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
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
					&& is_flagState_InGame_false(enum_releaseRegion),
				format = "percent")
			&& trigger_when(always_false())
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunBoneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[5+9])
		// NOTE: Multi-kills are regarded as 1 standard kill for this challenge
		/* DEV_NOTE: PauseLocks into AltResetGroups OR PauseLocks into ResetNextIfs
			Consider following achievement: "Finish Chapter from start to finish, without being below max HP for 10 seconds consecutively" 
				(each passed second is a hitCount)
			- PauseLocks into AltResetGroups  (this is preferred for this achievement)
				(this is more scalable; eg. multiple challenges: can create more AltResetPauseLockGroups)
				-------------------
				CORE (logic to unlock cheevo)
				- CheckIf: Chapter started from beginning (1)		--[StartCondition]--> Delta check, only hits when start chapter from beginning
				- CheckIf: Chapter finished							--[TriggerCondition]--> Delta check, only hits when chapter is finished

				ALT MEASURED (to display seconds left till challenge failure)
				- ResetNextIf: back at max HP							--[ConsecutiveResetCondition]--> If this triggers, it will reset the measured hitCount
				- Measured: xx seconds left being below max HP (10)		--[ConsecutiveChallengeCondition(Measured)]--> display xx seconds left till challenge fails
				- MeasuredIf: Chapter started from beginning (1)	--[StartCondition]--> Delta check, only hits when start chapter from beginning

				ALT RESET (as PAUSE LOCK) 	--> When triggered once, functions as a PauseLock when below max HP for 10 seconds consecutively:as this will reset the hitcount for StartCondition, which can only trigger on ChapterStart
				- AndNext: Chapter started from beginning (1)		--> Delta check, only hits when start chapter from beginning
				- ResetNextIf: when at max HP						--[ConsecutiveResetCondition]--> If this triggers, it will reset the hitCount for ConsecutiveChallengeCondition, even if ConsecutiveChallengeCondition was already triggered it can't turn StartCondition back to true, since it was already reset by the ConsecutiveChallengeCondition
				- ResetIf: when below max HP for xx seconds (10) 	--[ConsecutiveChallengeCondition]--> If this triggers, it will reset the StartCondition (in CORE and ALT MEASURED). Thus this functions as a PauseLock, until the chapter restarts from the beginning, since the StartCondition only hits once when starting a Chapter

				ALT RESET (Chapter Restart/Quit) --> Reset all HitCounts everywhere
				- ResetIf: Chapter Restart/Quit

			- PauseLocks into ResetNextIfs
				(this is less scalable; eg. multiple challenges: can only attach one ResetNextIf to a hitCount, it becomes ugly with OrNextChains, although could have one StartCondition for each seperate challenge)			
				-------------------
				CORE (logic to unlock cheevo)
				- ResetNextIf: back at max HP										--[ConsecutiveResetCondition]--> If this triggers, it will reset the hitCount for ConsecutiveChallengeCondition, even if ConsecutiveChallengeCondition was already triggered it can't turn StartCondition back to true, since it was already reset by the ConsecutiveChallengeCondition
				- ResetNextIf: 10 seconds spent below max HP consecutively (10) 	--[ConsecutiveChallengeCondition]--> If this triggers, it will reset the StartCondition. Thus this functions as a PauseLock, until the chapter restarts from the beginning, since the StartCondition only hits once when starting a Chapter
				- CheckIf: Chapter started from beginning (1) 	--[StartCondition]--> This is a delta check, only hits when start chapter from beginning
				- CheckIf: Chapter finished			--[TriggerCondition]--> Delta check, only hits when chapter is finished

				ALT MEASURED (to display seconds left till challenge failure)
				- ResetNextIf: back at max HP								--[ConsecutiveResetCondition]--> If this triggers, it will reset the measured hitCount
				- Measured: xx seconds left being below max HP (10)			--[ConsecutiveChallengeCondition(Measured)]--> display xx seconds left till challenge fails
				- ResetNextIf: back at max HP										--[ConsecutiveResetCondition]--> If this triggers, it will reset the hitCount for ConsecutiveChallengeCondition, even if ConsecutiveChallengeCondition was already triggered it can't turn StartCondition back to true, since it was already reset by the ConsecutiveChallengeCondition
				- ResetNextIf: 10 seconds spent below max HP consecutively (10) 	--[ConsecutiveChallengeCondition]--> If this triggers, it will reset the StartCondition. Thus this functions as a PauseLock, until the chapter restarts from the beginning, since the StartCondition only hits once when starting a Chapter
				- MeasuredIf: Chapter started from beginning (1)	--[StartCondition]--> This is a delta check, only hits when start chapter from beginning

				ALT RESET (Chapter Restart/Quit) --> Reset all HitCounts everywhere
				- ResetIf: Chapter Restart/Quit
			*/
		
		const_CHAPTER = CHAPTER_3_Boneyard
		const_WEAPON_A = WEAPON_Carbine
		const_WEAPON_B = WEAPON_Crossbow
		const_MAX_ALLOWED_STANDARD_KILLS_IN_ROW = 4

		return	
		// [1/10] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Trigger Indicator as long as challenge is OK
			unless(!is_ReleaseRegion(enum_releaseRegion))
			/* DEV_NOTE: Example of PauseLock into ResetNextIf	(this is not preferred for this achievement as there's multiple challenges attached, which could "lock" the achievement)
				------------
				&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
					never(repeated(const_MAX_ALLOWED_STANDARD_KILLS_IN_ROW + 1,  // --ResetNextIf--[ConsecutiveChallengeCondition]--> When player scores xx consecutive standard kills, without a melee or headshot kill to break the chain
						never( // --ResetNextIf--[ConsecutiveResetCondition]--> When player scores a melee or headshot kill
							is_flagState_InGame_true(enum_releaseRegion)
							&& current_HeadshotKills_Temp(enum_releaseRegion)
								+ current_MeleeKills_Temp(enum_releaseRegion) 
								- prev_HeadshotKills_Temp(enum_releaseRegion)
								- prev_MeleeKills_Temp(enum_releaseRegion) > 0)						
						&& is_flagState_InGame_true(enum_releaseRegion)
						&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)))
				*/
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended +  Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group ====		-> Group is only responsible for displaying a Measured Indicator counting consecutive standard kills
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured(repeated(const_MAX_ALLOWED_STANDARD_KILLS_IN_ROW +1, // --Measured--> Count consecutive standard kills up to const_MAX_ALLOWED_STANDARD_KILLS_IN_ROW +1
				never( // --ResetNextIf--[ConsecutiveResetCondition]--> When player scores a melee or headshot kill
					is_flagState_InGame_true(enum_releaseRegion)
					&& current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) 
						- prev_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
						- prev_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) > 0)		
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),
				when =
					once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)))
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/12] ==== Alt Lockout Group ===	-> Lockout achievement on challenge failure by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When earning a kill with a non-allowed weapons
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& never(once( // --Lockout--> When shooting a non-allowed weapon
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& !on_HUDcontrolGear_weaponSwap(enum_releaseRegion)
				&& on_HUDcontrolGear_LoadedBullets_decrement(enum_releaseRegion)))
			&& never(repeated(const_MAX_ALLOWED_STANDARD_KILLS_IN_ROW +1, // --Lockout--[ConsecutiveChallengeCondition]--> When player scores xx consecutive standard kills in a row (without mixing in a headshot or melee kill)
				never( // --ResetNextIf--[ConsecutiveResetCondition]--> When player scores a melee or headshot kill
					is_flagState_InGame_true(enum_releaseRegion)
					&& current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) 
						- prev_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
						- prev_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) > 0)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& always_false()
		// [4/13] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunDevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[4+8])
		const_CHAPTER = CHAPTER_4_DevilMine
		const_WEAPON_A = WEAPON_Redeemer
		const_WEAPON_B = WEAPON_DualPistols

		return	
		// [1/9] ==== Alt Logic Group ==== 			-> Group is responsible for unlocking the achievement
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When using a power
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
				on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/10] ==== Alt Triggered Group ====		-> Group is only responsible for displaying a Triggered Indicator, when player has any of the required weapons equipped 
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When using a power
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> The very first cinematic of the Chapter is over (so the trigger indicator pops up after the intro cinematic is done)
				on_AnyCinematic_end(enum_releaseRegion))
			&& tally(1, [ // --Tally--OrNext--> CheckIf any of the required weapons are equipped
				once(is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& never(!is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion))),
				once(is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
					&& never(!is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion))),
				])
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& trigger_when(always_false())
		// [3/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/12] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [5+..+8/13+..+16] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunDWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[5+9])
		const_CHAPTER = CHAPTER_5_Outpost
		const_ALLOWED_SECS_BELOW_MAX_HP = 20 // seconds consecutively below max HP

		return	
		// [1/10] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as player has not been been below max HP for xx secs consecutively
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group ====				-> Group is only responsible for displaying a Measured Indicator for allowed seconds left whilst being below xx% HP
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured( // --Measured--> Allowed Seconds left whilst being below xx% HP 
				tally(const_ALLOWED_SECS_BELOW_MAX_HP, [
					repeated(const_ALLOWED_SECS_BELOW_MAX_HP/2, always_true()), // --AddHit--> as base
					repeated(const_ALLOWED_SECS_BELOW_MAX_HP/2, always_true()), // --AddHit--> as base
					deduct(repeated(const_ALLOWED_SECS_BELOW_MAX_HP, // --SubHit 1--> every passed in-game second
						never( // --ResetNextIf--[ConsecutiveResetCondition]--> When player back at max HP
							is_flagState_InGame_true(enum_releaseRegion)
							&& current_Player_HP(PLAYER_1, enum_releaseRegion) == CONST_PLAYER_MAX_HP)
						&& is_flagState_InGame_true(enum_releaseRegion)
						&& current_Player_HP(PLAYER_1, enum_releaseRegion) < CONST_PLAYER_MAX_HP
						&& !is_AnyCinematic_active(enum_releaseRegion)
						&& on_MissionTime_Temp_secondPassed(enum_releaseRegion)))				
					]),
				when = 
					once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)))
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/12] ==== Alt Lockout Group ===	-> Lockout achievement on challenge failure by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(repeated(const_ALLOWED_SECS_BELOW_MAX_HP, // --Lockout-[ConsecutiveChallengeCondition]--> When player is below max HP for xx in-game seconds consecutively
				never( // --ResetNextIf--[ConsecutiveResetCondition]--> When player back at max HP
					is_flagState_InGame_true(enum_releaseRegion)
					&& current_Player_HP(PLAYER_1, enum_releaseRegion) == CONST_PLAYER_MAX_HP)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < CONST_PLAYER_MAX_HP
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& on_MissionTime_Temp_secondPassed(enum_releaseRegion)))
			&& always_false()
		// [4/13] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunWarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION (AltGroup[2+3+6+10])
		const_CHAPTER = CHAPTER_6_WarTrain
		const_TIME_LIMIT = 300000 // 300.000 ms = 5 min
		return	
		// [1/11] ==== Alt Logic + Triggered Group ==== 			-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as at max HP
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + MissionTime is within time limit  + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= const_TIME_LIMIT
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured): R/R usage
				PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f300.0-{recall}_M:0=f300.0
				NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f300.0-{recall}_M:0=f300.0
				''''''''''''''
					AddSource	[32-bit:MissionTime_Temp]
					AddSource	[32-bit:MissionTime_ChapterSection]
					AddSource	[32-bit:MissionTime_ChapterTotal]
					Remember	Val 0
					Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured): R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f300.0-{recall}_M:0=f300.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f300.0-{recall}_M:0=f300.0
				''''''''''''''
				Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
				AddSource	(const_TIME_LIMIT/1000) - Recall
				Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement on challenge fail by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(once( // --Lockout--> When losing HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < CONST_PLAYER_MAX_HP
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) == CONST_PLAYER_MAX_HP))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunTortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+5+9])
		const_CHAPTER = CHAPTER_7_TortureMaze
		const_MIN_REQUIRED_MELEE_KILLS = 0.6 // Percentage
		const_WEAPON_A = WEAPON_Scepter
		const_WEAPON_B = WEAPON_Shotgun
		return	
		// [1/10] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as hasn't killed an enemy with a disallowed weapon
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required MeleeKills ratio % NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeKillsRatioNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_N:{recall}<f0.6
					NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_N:{recall}<f0.6
					-----------
						Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_MELEE_KILLS
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
					+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_MELEE_KILLS
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye + Required MeleeKills ratio % achieved
					never(is_flagState_InGame_true(enum_releaseRegion))
				
					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeKillsRatioAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_N:{recall}>=f0.6
						NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_N:{recall}>=f0.6
						-----------
							Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_MELEE_KILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_MELEE_KILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group (In-Game) ====		-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			/* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredMeleeKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_K:0xX00965c84+0xX00965c50_K:{recall}/f1.0_A:0xX00965c2c/{recall}_A:0xX00965c94/{recall}_K:0xX00965c60/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_K:0xX00953ca4+0xX00953c70_K:{recall}/f1.0_A:0xX00953c4c/{recall}_A:0xX00953cb4/{recall}_K:0xX00953c80/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					AddSource	[32-bit:Kills_Temp]
					Remember	[32-bit:Kills_ChapterSection] + [32-bit:Kills_ChapterTotal]
					Remember	Recall / 1.0						--> Force 32-bit to Float
					AddSource	[32-bit:MeleeKills_Temp] / Recall				--> Divide by Float, returns a Float
					AddSource	[32-bit:MeleeKills_ChapterSection] / Recall		--> Divide by Float, returns a Float
					Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0	
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC12)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/12] ==== Alt Measured Group (Not In-Game) ==== 	-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			/* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredMeleeKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					Remember	[32-bit:Kills_ChapterTotal] / 1.0			--> Force 32-bit to Float
					Remember	[32-bit:MeleeKills_ChapterTotal] / Recall	--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunBaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[4+8])
		/* NOTE: 
			- Rail Rocket can be picked up from ChapterSection 2
			- There should be about 110+ kills achievable, even more when not destroying Marks of Evil too quickly
			*/
		const_CHAPTER = CHAPTER_8_BaptismFire
		const_REQUIRED_RAIL_ROCKET_KILLS = 40

		return	
		// [1/10] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as challenge is OK
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion))
				&& tally(const_REQUIRED_RAIL_ROCKET_KILLS, [
					// --AddHit 1--> When Kills increment by 1, because of Explosiveness of Crossbow ammo
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),

					// --AddHit 1+1--> When Kills increment by 2, because of Explosiveness of Crossbow ammo
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(2, PLAYER_1, enum_releaseRegion)), 

					// --AddHit 1+2--> When Kills increment by 3, because of Explosiveness of Crossbow ammo
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 

					// --AddHit 1+3--> When Kills increment by 4, because of Explosiveness of Crossbow ammo
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 

					// --AddHit 1+4--> When Kills increment by 5, because of Explosiveness of Crossbow ammo
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
					repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
						is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
						&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
					])
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group ===	-> Group is only responsible for displaying a Measured Indicator tracking kills with required weapon
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured(tally(const_REQUIRED_RAIL_ROCKET_KILLS, [
				// --AddHit 1--> When Kills increment by 1, because of Explosiveness of Crossbow ammo
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),

				// --AddHit 1+1--> When Kills increment by 2, because of Explosiveness of Crossbow ammo
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(2, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 1+2--> When Kills increment by 3, because of Explosiveness of Crossbow ammo
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 1+3--> When Kills increment by 4, because of Explosiveness of Crossbow ammo
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 1+4--> When Kills increment by 5, because of Explosiveness of Crossbow ammo
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_RAIL_ROCKET_KILLS, 
					is_EquippedWeapon(PLAYER_1, WEAPON_RailRocket, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				]),
				when = once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
					is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)))
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/12] ==== Alt Lockout Group ===	-> Lockout achievement on challenge failure by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When using a throwable explosive 
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(enum_releaseRegion)
				&& !on_ThrowableType_switch(enum_releaseRegion)))
			&& always_false()
		// [4/13] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====					-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+19] ==== (4x) Reset Groups ==== 	-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunRescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[3+7])
		const_CHAPTER = CHAPTER_9_Rescue

		return	
		// [1/8] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as at max HP
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When losing HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < CONST_PLAYER_MAX_HP
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) == CONST_PLAYER_MAX_HP))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/9] ==== Alt Lockout Group ==== 	-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [3/10] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [4+..+7/11+..+14] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION (AltGroup[2+3+6+10])
		const_CHAPTER = CHAPTER_10_Prism
		const_TIME_LIMIT = 900000 // 900.000 ms = 15 min
		const_WEAPON_A = WEAPON_DualPistols
		const_WEAPON_B = WEAPON_Shotgun
		return
		// [1/11] ==== Alt Logic + Triggered Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying a Trigger Indicator as long as challenge is OK
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + MissionTime is within time limit  + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= const_TIME_LIMIT
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured): R/R usage
				// WARNING - Edit const_TIME_LIMIT
				PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f900.0-{recall}_M:0=f900.0
				NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f900.0-{recall}_M:0=f900.0
				''''''''''''''
					AddSource	[32-bit:MissionTime_Temp]
					AddSource	[32-bit:MissionTime_ChapterSection]
					AddSource	[32-bit:MissionTime_ChapterTotal]
					Remember	Val 0
					Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured): R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f900.0-{recall}_M:0=f900.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f900.0-{recall}_M:0=f900.0
				''''''''''''''
					Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/14] ==== Alt Lockout Group ====		-> Lockout achievement on challenge failure by Resetting HitCounts on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(once( // --Lockout--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunInvasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[4+8])
		const_CHAPTER = CHAPTER_11_Invasion
		const_ALLOWED_DISTINCT_POWERS = 1 // Only xx of the 8 powers may be used throughout the whole Chapter
		const_ALLOWED_POWER_USAGE_COUNT = 5 // It may only be activated xx times

		return	
		// [1/9] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as with power usage requirements
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --PauseLock--> When powers have been activated too many times
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& unless(tally_of(CONST_POWER_DATA, const_ALLOWED_DISTINCT_POWERS + 1, enum_power =>  // --PauseLock--> When too many different powers have been activated
				once(
					is_flagState_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/10] ==== Alt Measured Group ====				-> Group is only responsible for displaying a Measured Indicator for amount of PowerUsages left
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --PauseLock--> When powers have been activated too many times
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& unless(tally_of(CONST_POWER_DATA, const_ALLOWED_DISTINCT_POWERS + 1, enum_power =>  // --PauseLock--> When too many different powers have been activated
				once(
					is_flagState_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			&& measured( // --Measured--> Power Usage Count left; Starts at max const_ALLOWED_POWER_USAGE_COUNT; decrements with each power activation
				tally(const_ALLOWED_POWER_USAGE_COUNT, [
					repeated(const_ALLOWED_POWER_USAGE_COUNT, always_true()), // --AddHits--> Up to const_ALLOWED_POWER_USAGE_COUNT
					deduct(repeated(const_ALLOWED_POWER_USAGE_COUNT, // --SubHits--> SubHit 1 when activating a power
						is_flagState_InGame_true(enum_releaseRegion)
						&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
					]),
				when = 
					once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))		
				)
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/12] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [5+..+8/13+..+16] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunHangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+6+10])
		const_CHAPTER = CHAPTER_12_Hangtown
		const_MIN_REQUIRED_ACCURACY = 0.75
		const_REQUIRED_SHOOTING_WEAPON_A = WEAPON_RangeRifle
		const_REQUIRED_SHOOTING_WEAPON_B = WEAPON_Redeemer
		return
		// [1/11] ==== Alt Logic + Triggered Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying Trigger Indicator as long as player didn't shoot with a disallowed weapon
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[2ACC-1ACC]:CheckAccuracyNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}<f0.75
					NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}<f0.75
					-----------
						Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_ACCURACY			*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
				&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_ACCURACY
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1ACC)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy achieved +  Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					
					/* MANUAL_CONSTRUCTION[2ACC-3ACC]:CheckAccuracyAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.75
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.75
						-----------
							Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_ACCURACY			*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
					&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_ACCURACY
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x3ACC)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			/* MANUAL_CONSTRUCTION[0ACC-5ACC]:MeasuredAccuracyWhileInGame (below Measured): R/R usage
				PAL:	A:0xX00965c20_K:0xX00965c54+0xX00965c88_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c40_K:0xX00953ca8+0xX00953c74_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& measured(
				current_calculated_Accuracy_FullTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 	
					memUtil_ManualConstruction_PlaceHolderRequirement(0x5ACC)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& trigger_when(always_false())
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			/* MANUAL_CONSTRUCTION[0ACC-6ACC]:MeasuredAccuracyWhileNotInGame (below Measured): R/R usage
				PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& measured(				
				current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0x6ACC)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& trigger_when(always_false())
		// [4/14] ==== Alt Lockout Group ===				-> Lockout achievement on challenge failure by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When the player fires a shot with a non-allowed weapon
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_REQUIRED_SHOOTING_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_REQUIRED_SHOOTING_WEAPON_B, enum_releaseRegion)
				&& !on_HUDcontrolGear_weaponSwap(enum_releaseRegion)
				&& on_HUDcontrolGear_LoadedBullets_decrement(enum_releaseRegion)))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunMorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+5+9])
		const_CHAPTER = CHAPTER_13_MorningAfter
		const_NON_ALLOWED_POWERS = POWER_DATA_getAllPowersOfTiers([1,4])
		const_MIN_REQUIRED_MELEE_KILLS = 0.45 // Percentage

		return	
		// [1/10] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as with power usage requirements
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required MeleeKills ratio % NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeKillsRatioNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_N:{recall}<f0.45
					NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_N:{recall}<f0.45
					-----------
						Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_MELEE_KILLS
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
					+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_MELEE_KILLS
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& unless(tally_of(const_NON_ALLOWED_POWERS, 1, enum_power => // --PauseLock--> When any non-allowed power is used
				once(
					is_flagState_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye + Required MeleeKills ratio % achieved
					never(is_flagState_InGame_true(enum_releaseRegion))
				
					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeKillsRatioAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_N:{recall}>=f0.45
						NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_N:{recall}>=f0.45
						-----------
							Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_MELEE_KILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_MELEE_KILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/11] ==== Alt Measured Group (In-Game) ====		-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(tally_of(const_NON_ALLOWED_POWERS, 1, enum_power => // --PauseLock--> When any non-allowed power is used
				once(
					is_flagState_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			/* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredMeleeKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_K:0xX00965c84+0xX00965c50_K:{recall}/f1.0_A:0xX00965c2c/{recall}_A:0xX00965c94/{recall}_K:0xX00965c60/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_K:0xX00953ca4+0xX00953c70_K:{recall}/f1.0_A:0xX00953c4c/{recall}_A:0xX00953cb4/{recall}_K:0xX00953c80/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					AddSource	[32-bit:Kills_Temp]
					Remember	[32-bit:Kills_ChapterSection] + [32-bit:Kills_ChapterTotal]
					Remember	Recall / 1.0						--> Force 32-bit to Float
					AddSource	[32-bit:MeleeKills_Temp] / Recall				--> Divide by Float, returns a Float
					AddSource	[32-bit:MeleeKills_ChapterSection] / Recall		--> Divide by Float, returns a Float
					Remember	[32-bit:MeleeKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0	
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC12)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/12] ==== Alt Measured Group (Not In-Game) ==== 	-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(tally_of(const_NON_ALLOWED_POWERS, 1, enum_power => // --PauseLock--> When any non-allowed power is used
				once(
					is_flagState_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			/* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredMeleeKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50/f1.0_K:0xX00965c60/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c80/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					Remember	[32-bit:Kills_ChapterTotal] / 1.0			--> Force 32-bit to Float
					Remember	[32-bit:MeleeKills_ChapterTotal] / Recall	--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/14] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [6+..+9/15+..+18] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunShowdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+6+10])
		const_CHAPTER = CHAPTER_14_Showdown
		const_MIN_REQUIRED_ACCURACY = 0.65
		const_ALLOWED_POWER_A = POWER_BloodFrenzy
		const_ALLOWED_POWER_B = POWER_SilverBrand
		return
		// [1/11] ==== Alt Logic + Triggered Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying Trigger Indicator as long as player hasn't used any non-allowed powers
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[2ACC-1ACC]:CheckAccuracyNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}<f0.65
					NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}<f0.65
					-----------
						Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_ACCURACY			*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
				&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_ACCURACY
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0x1ACC)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Required Accuracy achieved +  Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					
					/* MANUAL_CONSTRUCTION[2ACC-3ACC]:CheckAccuracyAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.65
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.65
						-----------
							Remember	[32-bit:ShotsFired_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:ShotsHit_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_ACCURACY			*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x2ACC)
					&& current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_ACCURACY
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0x3ACC)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			/* MANUAL_CONSTRUCTION[0ACC-5ACC]:MeasuredAccuracyWhileInGame (below Measured): R/R usage
				PAL:	A:0xX00965c20_K:0xX00965c54+0xX00965c88_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c58/{recall}_K:0xX00965c8c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c40_K:0xX00953ca8+0xX00953c74_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953c78/{recall}_K:0xX00953cac/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& measured(
				current_calculated_Accuracy_FullTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 	
					memUtil_ManualConstruction_PlaceHolderRequirement(0x5ACC)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
					&& is_flagState_InGame_true(enum_releaseRegion),
				format = "percent")
			&& trigger_when(always_false())
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for Accuracy % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			/* MANUAL_CONSTRUCTION[0ACC-6ACC]:MeasuredAccuracyWhileNotInGame (below Measured): R/R usage
				PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0x0ACC)
			&& measured(				
				current_calculated_Accuracy_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0x6ACC)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
					&& is_flagState_InGame_false(enum_releaseRegion),
				format = "percent")
			&& trigger_when(always_false())
		// [4/14] ==== Alt Lockout Group ====		-> Lockout achievement on challenge fail by Resetting HitCounts on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once(  // --PauseLock--> When any non-allowed power is used
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_PowerIconTopLeft(const_ALLOWED_POWER_A, enum_releaseRegion)
				&& !is_PowerIconTopLeft(const_ALLOWED_POWER_B, enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION (AltGroup[2+3+6+10])
		const_CHAPTER = CHAPTER_15_RightTrain
		const_TIME_LIMIT = 420000 // 420.000 ms = 7 min
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP * 0.7 // % of max HP
		return 
		// [1/11] ==== Alt Logic + Triggered Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying a Trigger Indicator as long as HP hasn't dropped below xx% 
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + MissionTime is within time limit  + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= const_TIME_LIMIT
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured): R/R usage
				// WARNING - Edit const_TIME_LIMIT
				PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f420.0-{recall}_M:0=f420.0
				NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f420.0-{recall}_M:0=f420.0
				''''''''''''''
					AddSource	[32-bit:MissionTime_Temp]
					AddSource	[32-bit:MissionTime_ChapterSection]
					AddSource	[32-bit:MissionTime_ChapterTotal]
					Remember	Val 0
					Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InGunslingerMode(enum_releaseRegion)) // --> Necessary as otherwise this Measured Indicator may be displayed for 1 frame
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured): R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f420.0-{recall}_M:0=f420.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f420.0-{recall}_M:0=f420.0
				''''''''''''''
					Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/14] ==== Alt Lockout Group ====		-> Lockout achievement on challenge failure by Resetting HitCounts on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion)))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(once( // --Lockout--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line) 
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunDeadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroup[1+2+3+7+11])
		// DEV_NOTE: Example of PauseLock into AltResetGroup (=AltLockoutGroup)
		const_CHAPTER = CHAPTER_16_Deadfall
		const_MIN_REQUIRED_HEADSHOT_KILLS = 0.3 // Percentage
		const_WEAPON_A = WEAPON_RangeRifle
		const_WEAPON_B = WEAPON_Carbine

		return	
		// [1/11] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as challenge is OK
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When LastChapterSection from the Gunslinger Level/Chapter has ended + Required HeadshotKills ratio % NOT achieved (to hide Trigger Indicator)
				never(is_flagState_InGame_true(enum_releaseRegion))
				
				/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckHeadshotKillsRatioNotAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c50/f1.0_K:0xX00965c5c/{recall}_N:{recall}<f0.3
					NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c7c/{recall}_N:{recall}<f0.3
					-----------
						Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
						Remember	[32-bit:HeadshotKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
						AndNext		Recall < const_MIN_REQUIRED_HEADSHOT_KILLS
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
					+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) < const_MIN_REQUIRED_HEADSHOT_KILLS
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion)))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye + Required HeadshotKills ratio % achieved
					never(is_flagState_InGame_true(enum_releaseRegion))
				
					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckHeadshotKillsRatioAchieved (below 3 lines) - R/R usage 
					PAL:	K:0xX00965c50/f1.0_K:0xX00965c5c/{recall}_N:{recall}>=f0.3
					NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c7c/{recall}_N:{recall}>=f0.3
						-----------
							Remember	[32-bit:Kills_ChapterTotal] / 1.0		--> Force 32-bit to Float
							Remember	[32-bit:HeadshotKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_HEADSHOT_KILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= const_MIN_REQUIRED_HEADSHOT_KILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/12] ==== Alt Measured Group (In-Game) ====			-> Group is only responsible for displaying a Measured Indicator for kills to Headshot Kills ratio % - When in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(once( // --PauseLock--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			/* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredHeadshotKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_K:0xX00965c84+0xX00965c50_K:{recall}/f1.0_A:0xX00965c28/{recall}_A:0xX00965c90/{recall}_K:0xX00965c5c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_K:0xX00953ca4+0xX00953c70_K:{recall}/f1.0_A:0xX00953c48/{recall}_A:0xX00953cb0/{recall}_K:0xX00953c7c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					AddSource	[32-bit:Kills_Temp]
					Remember	[32-bit:Kills_ChapterSection] + [32-bit:Kills_ChapterTotal]
					Remember	Recall / 1.0						--> Force 32-bit to Float
					AddSource	[32-bit:HeadshotKills_Temp] / Recall				--> Divide by Float, returns a Float
					AddSource	[32-bit:HeadshotKills_ChapterSection] / Recall		--> Divide by Float, returns a Float
					Remember	[32-bit:HeadshotKills_ChapterTotal] / Recall		--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0	
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> HeadshotKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC12)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/13] ==== Alt Measured Group (Not In-Game) ==== 		-> Group is only responsible for displaying a Measured Indicator for kills to Headshot Kills ratio % - When not in-game
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			/* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredHeadshotKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50/f1.0_K:0xX00965c5c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				NTSCU:	K:0xX00953c70/f1.0_K:0xX00953c7c/{recall}_K:{recall}*f100.0_G:{recall}=f100.0
				------------
					Remember	[32-bit:Kills_ChapterTotal] / 1.0			--> Force 32-bit to Float
					Remember	[32-bit:HeadshotKills_ChapterTotal] / Recall	--> Divide by Float, returns a Float
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> HeadshotKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/14] ==== Alt Lockout Group ===		-> Lockout achievement on challenge failure by Resetting HitCount on [StartCondition]
		 	|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(once( // --Lockout--> When earning a kill without any of the required weapons equipped
				is_flagState_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)))
			&& always_false()
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/16] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [7+..+10/17+..+20] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_GunCurseWest": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[4+8])
		const_CHAPTER = CHAPTER_17_CurseWest
		const_ALLOWED_POWER_USAGE_COUNT = 7
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP * 0.4 // % of max HP

		return	
		// [1/9] ==== Alt Logic + Triggered Group ==== 		-> Group is responsible for unlocking the achievement + Displaying a Triggered Indicator as long as with power usage requirements and as long as not below xx% HP
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --PauseLock--> When powers have been activated too many times
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))
			&& once( // --CheckIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& trigger_when(
				once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter is started from beginning 
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended + Difficulty Deadeye
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> LastChapterSection from the Gunslinger Level/Chapter has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))
				&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2/10] ==== Alt Measured Group ====				-> Group is only responsible for displaying a Measured Indicator for amount of PowerUsages left
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& unless(repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --PauseLock--> When powers have been activated too many times
				is_flagState_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
			&& unless(once( // --PauseLock--> When player HP drops below xx% HP
				is_flagState_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD))			
			&& measured( // --Measured--> Power Usage Count left; Starts at max const_ALLOWED_POWER_USAGE_COUNT; decrements with each power activation
				tally(const_ALLOWED_POWER_USAGE_COUNT, [
					repeated(const_ALLOWED_POWER_USAGE_COUNT, always_true()), // --AddHits--> Up to const_ALLOWED_POWER_USAGE_COUNT
					deduct(repeated(const_ALLOWED_POWER_USAGE_COUNT, // --SubHits--> SubHit 1 when activating a power
						is_flagState_InGame_true(enum_releaseRegion)
						&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
					]),
				when = 
					once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))		
				)
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/12] ==== Alt Reset Group ====				-> Reset when PauseMenu->Restart while in ChapterSection_1
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_ChapterSection(const_CHAPTER, CHAPTER_SECTION_1, enum_releaseRegion)
				/* MANUAL_CONSTRUCTION[1FD-2FD]:ResetOn_PauseMenu_Restart (below line)
					PAL:	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					NTSCU:	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1
					*/
				&& on_PauseMenu_Restart(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[1FD-2FD]
		// [5+..+8/13+..+16] ==== (4x) Reset Groups ==== 		-> Reset when not in Gunslinger Mode || when starting new Chapter from MainMenu || when LevelID is incorrect || when pressing PauseMenu->Quit
			|| achGenerate_4x_AltResetGroups_GunslingerChallenge(const_CHAPTER, enum_releaseRegion) // --> (1x) MANUAL_CONSTRUCTION
		}),
	"a_WeaponMaster": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION // DISCONTINUED - Exceeds achievement logic size
		let_array_AllGunslingerLevelIndices = util_generateArrayOfIntegers_startAtZero(CONST_NUMBER_OF_CHAPTERS - 1)
		return
		// [1] ==== Alt Logic Group ==== 		-> This group handles the achievement logic; This group is responsible for unlocking the achievement + Displaying a Measured Indicator of how many Darkwatch Weapons have been favorited at least once 
			unless(!is_ReleaseRegion(enum_releaseRegion))
			&& once( // --CheckIf--> Any Gunslinger ChapterSection is started from beginning 
				on_AnyChapterSection_startFromBeginning(enum_releaseRegion))
			&& once( // --CheckIf--> Player leaves InGame
				never(is_flagState_InGame_true(enum_releaseRegion))				
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> Player leaves InGame for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))
			// && measured(achGenerate_TallyOf_GunslingerAllDarkwatchWeaponsFavoritedOnce(enum_releaseRegion)) // DISABLED - Exceeds achievement logic size
			&& trigger_when(on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion))
		// [2] ==== Alt Reset Group ==== 		-> Reset when not in Gunslinger Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& !is_InGunslingerMode(enum_releaseRegion))
		// [3] ==== Alt Reset Group ==== 		-> Reset when starting a new Chapter from MainMenu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion))
		// [4/8] ==== Alt Reset Group ==== 		-> Reset when pressing PauseMenu->Quit
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
	// --------c_Bonus--------
	"a_GatlingRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achGenerate_FullTrigger_GatlingGunner(CHAPTER_15_RightTrain, CHAPTER_SECTION_1, DIFFICULTY_Shootist, 15, enum_releaseRegion)),
	"a_GatlingPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achGenerate_FullTrigger_GatlingGunner(CHAPTER_10_Prism, CHAPTER_SECTION_5, DIFFICULTY_Shootist, 15, enum_releaseRegion)),
	"a_SunPower": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion))
			&& never(
				is_flagState_InGame_false(enum_releaseRegion)
				|| is_anyFMV_active(enum_releaseRegion)
				|| is_AnyCinematic_active(enum_releaseRegion)
				|| is_AnyInGameMenu_active(enum_releaseRegion))
			&& never(tally_of(CONST_CONTROLLER_CONFIG_DATA, 200, (enum_controllerConfig) { // --ResetIf--> VampireVision HitCounts need to be reset when not activating it repeatedly 
				let_input_VampireVision = CONTROLLER_CONFIG_DATA_getButtonSightMode(enum_controllerConfig)
				return repeated(200,
					never(
						is_ControllerConfig(PLAYER_1, enum_controllerConfig, enum_releaseRegion)
						&& is_InSunlight(enum_releaseRegion)
						&& !is_EquippedWeapon(PLAYER_1, WEAPON_RangeRifle, enum_releaseRegion)
						&& on_PlayerInput_press(PLAYER_1, let_input_VampireVision, enum_releaseRegion))
					&& is_ControllerConfig(PLAYER_1, enum_controllerConfig, enum_releaseRegion)
					&& is_flagState_IsInputPressed_false(PLAYER_1, let_input_VampireVision, enum_releaseRegion))				
				}))
			&& tally_of(CONST_CONTROLLER_CONFIG_DATA, 3, (enum_controllerConfig) { // --Tally--OrNext--> Check if Power is activated whilst in sunlight, check this for each ControllerConfig
				let_input_VampireVision = CONTROLLER_CONFIG_DATA_getButtonSightMode(enum_controllerConfig)
				return repeated(3,
					is_ControllerConfig(PLAYER_1, enum_controllerConfig, enum_releaseRegion)
					&& is_InSunlight(enum_releaseRegion)
					&& !is_EquippedWeapon(PLAYER_1, WEAPON_RangeRifle, enum_releaseRegion)
					&& on_PlayerInput_press(PLAYER_1, let_input_VampireVision, enum_releaseRegion))				
				})
		),
	"a_Multikill": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MULTI_KILL_COUNT = 4
		return
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement			
			is_ReleaseRegion(enum_releaseRegion)
			&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& on_Kills_Temp_minIncrementBy(const_MULTI_KILL_COUNT, PLAYER_1, enum_releaseRegion) // --CheckIf--> Kills increment by xx amount or higher in 1 delta frame
		}),
	"a_AllPowersEvil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[1])
		const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower = TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_SoulStealer
		return
		/* MANUAL_CONSTRUCTION:CheckNewPowerUnlock (AltGroup[1/2])
			// WARNING - Edit in enum_textLookupKeyPowerName
			PAL:	P:0xX007215cc!=1397050451_P:0xL00911474!=1_P:0xL009114f0!=0_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00965cc4!=0_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=3965834464.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
			NTSCU:	P:0xX0071fccc!=1398099027_P:0xL008ff494!=1_P:0xL008ff510!=0_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00953ce4!=0_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=3965834464.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
			------
				PauseIf 	...

				AddAddress	[Pointer:UIcontrol(preferred)]
				Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
				Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

				AddAddress	[Pointer:UIcontrol(preferred)]
				AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
				Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 

				
				// -----------------------ResetNextIf-----------------------
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				ResetNextIf	->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle == "New Power"	
				// -----------------------ResetIf-----------------------
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle != "New Power"	
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				ResetIf		->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower  (2)	| CheckIf: PRIOR FrameTitle == "New Power"	


				// -----------------------once(on_NewPowerMenuRender() && is_NewPowerMenu_Power())-----------------------
				AndNext		[FlagState_InGame] == false			| is_flagState_InGame_true()
				AndNext		[GameState] == 0x3					| is_AnyInGameMenu_active()

				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower  		| CheckIf: Mem FrameTitle == "New Power"	
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Delta 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 	| CheckIf: DELTA FrameTitle != "New Power"	
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xC
				AddAddress	->[Mem 32-bit] 0x4
							->[Mem 32-bit] 0x48 == enum_textLookupKeyPowerName 	(1)		| CheckIf: MsgBoxText == enum_textLookupKeyPowerName


				// -----------------------Trigger-----------------------
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				Trigger		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle != "New Power"	
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				Trigger		->[Delta 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower  		| CheckIf: DELTA FrameTitle == "New Power"				
				*/	
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement					
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InSinglePlayerMode(enum_releaseRegion))
			&& once(
				is_flagState_InGame_true(enum_releaseRegion)
				&& is_NewPowerMenu_Power(const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower, enum_releaseRegion)
				&& dword(0xDEADBEEF) == const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower
				)
			&& trigger_when(on_NewPowerMenu_close(enum_releaseRegion))
		}),
	"a_AllPowersGood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[1])
		const_NEWPOWERMENU_TEXTLOOKUPKEY_LastGoodPower = TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_Vindicator
		return
		/* MANUAL_CONSTRUCTION:CheckNewPowerUnlock (AltGroup[1/2])
			// WARNING - Edit in enum_textLookupKeyPowerName
			PAL:	xxxx
			NTSCU:	P:0xX0071fccc!=1398099027_P:0xL008ff494!=1_P:0xL008ff510!=0_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_R:0xX0000006c!=2662373993.2._N:0xX00953ce4!=0_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=1995014642.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
				*/	
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InSinglePlayerMode(enum_releaseRegion))
			&& once(
				is_flagState_InGame_true(enum_releaseRegion)
				&& is_NewPowerMenu_Power(const_NEWPOWERMENU_TEXTLOOKUPKEY_LastGoodPower, enum_releaseRegion)
				&& dword(0xDEADBEEF) == const_NEWPOWERMENU_TEXTLOOKUPKEY_LastGoodPower
				)
			&& trigger_when(on_NewPowerMenu_close(enum_releaseRegion))
		}),
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
	"a_Rescue": 				{"en": "No Grave for the Living"},
	"a_Prism": 					{"en": "A Treasure Worth Dying For"},
	"a_Invasion": 				{"en": "Warriors of the Shadow"},
	"a_Hangtown": 				{"en": "Noose and Nightmare"},
	"a_MorningAfter": 			{"en": "When the Sun Rose, It Found Ruins"},
	"a_Showdown": 				{"en": "The Devil You Know"},
	"a_RightTrain": 			{"en": "Damnation Express"},
	"a_Deadfall": 				{"en": "Where the Dead Still Fall"},
	// --------c_SPend--------
	"a_CurseWestGood": 			{"en": "Dawn Over Darkness"},
	"a_CurseWestEvil": 			{"en": "The Devil Wears Spurs"},
	// --------c_Unlocks--------
	"a_Boss":					{"en": "Through Blood and Brotherhood"},
	"a_Enemy1":					{"en": "Bone-Shattering Precision"},
	"a_Enemy2":					{"en": "Steel over Lead"},
	"a_Train":					{"en": "Wrong Train, Right Shot"},
	"a_Guns":					{"en": "The Gunslinger's Craft"},
	"a_Drivers":				{"en": "Highway to Hell"},
	"a_Sights1":				{"en": "Coffins Can Wait"},
	"a_Sights2":				{"en": "Where Ancestors Sleep"},
	"a_Sights3":				{"en": "Ain't Got Time to Bleed"},
	"a_Attract":				{"en": "Death's Calling Card"},
	"a_Cowboy":					{"en": "Butcher of the Citadel"},
	"a_Shower":					{"en": "Hell on the Rails"},
	"a_Intro":					{"en": "One Shot, One Salvation"},
	"a_Moon":					{"en": "The Devil's Hour"},
	"a_Archive":				{"en": "The Price of Immortality"},
	// --------c_Gunslinger--------
	"a_GunWrongTrain": 			{"en": "Four Minutes to Midnight"},
	"a_GunRideDevil": 			{"en": "A Devil's Ride with Angel's Precision"},
	"a_GunBoneyard": 			{"en": "Waking the Reckoning"},
	"a_GunDevilMine": 			{"en": "Six Shooters' Tirade"},
	"a_GunDWOutpost": 			{"en": "The Hunger Within"},
	"a_GunWarTrain": 			{"en": "Unburned by the Boiler"},
	"a_GunTortureMaze": 		{"en": "The Butcher's Gospel"},
	"a_GunBaptismFire": 		{"en": "Duty by Blazing Fire"},
	"a_GunRescue": 				{"en": "No Blood of Mine"},
	"a_GunPrism": 				{"en": "Sunburst Rush"},
	"a_GunInvasion": 			{"en": "Disciplined Wrath"},
	"a_GunHangtown": 			{"en": "No Loose Lead"},
	"a_GunMorningAfter": 		{"en": "Brutal Grace"},
	"a_GunShowdown": 			{"en": "Bare-Fanged Brawl"},
	"a_GunRightTrain": 			{"en": "Reins on the Rails"},
	"a_GunDeadfall": 			{"en": "Deadshot Descent"},
	"a_GunCurseWest": 			{"en": "Balance of Blood"},
	"a_WeaponMaster":			{"en": "xxxxxxxxx"},
	// --------c_Bonus--------
	"a_GatlingRightTrain":		{"en": "Rotary of Damnation"},
	"a_GatlingPrism":			{"en": "Circle of Suppression"},
	"a_SunPower":				{"en": "Sun-Kissed Suicide"},
	"a_Multikill":				{"en": "Hell's Choir"},
	"a_AllPowersEvil":			{"en": "Grim Phantom"},
	"a_AllPowersGood":			{"en": "Righteous Revenant"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},

	// --------c_SPstory--------
	"a_WrongTrain": 			{"en": "You planned a heist, not a reckoning. Now the only thing getting robbed is your soul. Complete Chapter 1, \"The Wrong Train\", in Single Player or Gunslinger Mode"},
	"a_RideDevil": 				{"en": "The Reaper's breathing down your neck, and the only way out is forward. Ride hard or get left in the dirt. Complete Chapter 2, \"Ride Like the Devil\", in Single Player or Gunslinger Mode"},
	"a_Boneyard":	 			{"en": "The dead ain't much for conversation, but they'll sure let you know when you're unwelcome. Complete Chapter 3, \"Boneyard\", in Single Player or Gunslinger Mode"},
	"a_DevilMine":	 			{"en": "This mine's seen plenty of bodies, and if you're not careful, yours'll be next. Complete Chapter 4, \"Devil's Belly Mine\", in Single Player or Gunslinger Mode"},
	"a_DWOutpost":	 			{"en": "A safe haven? Not anymore. The only thing left standing here is whatever's strong enough to survive. Complete Chapter 5, \"Darkwatch Outpost\", in Single Player or Gunslinger Mode"},
	"a_WarTrain":	 			{"en": "This train ain't headed for salvation, just blood, fire, and a hell of a fight. Complete Chapter 6, \"War Train\", in Single Player or Gunslinger Mode"},
	"a_TortureMaze":	 		{"en": "General Cartwright don't train survivors, he trains killers. If you're still breathing, you might just be worth something. Complete Chapter 7, \"Torture Maze\", in Single Player or Gunslinger Mode"},
	"a_BaptismFire":	 		{"en": "A warm welcome to Darkwatch? Try fire, lead, and bodies hitting the dirt. Complete Chapter 8, \"Baptism of Fire\", in Single Player or Gunslinger Mode"},
	"a_Rescue": 				{"en": "They were left to rot, but not on your watch. Time to remind the dead who's still kicking. Complete Chapter 9, \"Rescue\", in Single Player or Gunslinger Mode"},
	"a_Prism": 					{"en": "Power like this don't belong in any man's hands, least of all the wicked. Complete Chapter 10, \"The Deadlight Prism\", in Single Player or Gunslinger Mode"},
	"a_Invasion": 				{"en": "This land ain't free for the taking, and it damn sure don't belong to the dead. Complete Chapter 11, \"Invasion\", in Single Player or Gunslinger Mode"},
	"a_Hangtown": 				{"en": "The gallows still swing, but the dead don't stay hanging. Time to lay them down for good. Complete Chapter 12, \"Hangtown\", in Single Player or Gunslinger Mode"},
	"a_MorningAfter": 			{"en": "Darkwatch stood against the darkness for centuries. One night was all it took to bring it crashing down. Complete Chapter 13, \"The Morning After\", in Single Player or Gunslinger Mode"},
	"a_Showdown": 				{"en": "Darkwatch lies in ashes, but the nightmare ain't over, not yet. Time to put an end to the devil that started it all. Complete Chapter 14, \"Showdown\", in Single Player or Gunslinger Mode"},
	"a_RightTrain": 			{"en": "This train ain't heading west, it's heading straight into damnation. Complete Chapter 15, \"The Right Train\", in Single Player or Gunslinger Mode"},
	"a_Deadfall": 				{"en": "The city's burning, the bullets are flying, and you're standing in the middle of hell itself. Complete Chapter 16, \"Deadfall\", in Single Player or Gunslinger Mode"},
	// --------c_SPend--------
	"a_CurseWestGood": 			{"en": "The night breaks, the curse fades, and the West is free, at least for now. Achieve the good ending during Chapter 17, \"Curse of the West\", in Single Player Mode"},
	"a_CurseWestEvil": 			{"en": "Ain't a soul left who can stop you. Ain't a god left who'd dare try. Achieve the evil ending during Chapter 17, \"Curse of the West\", in Single Player Mode"},
	// --------c_Unlocks--------
	"a_Boss":					{"en": "You've fought the worst and stood with the best. Unlock the \"Bosses\" & \"Allies of Darkwatch\" concept art by completing Chapter 17, \"Curse of the West\", on Shootist difficulty in Gunslinger Mode"},
	"a_Enemy1":					{"en": "A graveyard ain't the place for wasted bullets. Make every shot count, or end up six feet under. Unlock the \"Enemies of Darkwatch 1\" concept art by completing Chapter 3, \"Boneyard\", with 65% or more accuracy in Gunslinger Mode"},
	"a_Enemy2":					{"en": "Some folks hide behind guns. You settle things the old-fashioned way. Unlock the \"Enemies of Darkwatch 2\" concept art by completing Chapter 14, \"Showdown\", with 20 or more melee kills in Gunslinger Mode"},
	"a_Train":					{"en": "Ain't much room for shaky hands when the devil himself is ridin' the rails. Unlock \"The Wrong Train Animatic\" concept art by completing Chapter 1, \"The Wrong Train\", with 65% or more accuracy in Gunslinger Mode"},
	"a_Guns":					{"en": "A real gunslinger measures his worth in bullets. Miss too many, and the West will carve your tombstone early. Unlock the \"Weapons\" concept art by completing Chapter 13, \"The Morning After\", with 70% or more accuracy in Gunslinger Mode"},
	"a_Drivers":				{"en": "Ain't no safer way to stop the dead than a bullet between the eyes. Unlock the \"Vehicles\" concept art by completing Chapter 16, \"Deadfall\", with 20 or more headshot kills in Gunslinger Mode"},
	"a_Sights1":				{"en": "The outpost was supposed to be safe, guess nobody told the things crawling inside. Stay standing, or get buried with the rest. Unlock the \"Environments 1\" concept art by completing Chapter 5, \"Darkwatch Outpost\", with no deaths in Gunslinger Mode"},
	"a_Sights2":				{"en": "This was their home, their last stand. Now it's just another battlefield, if you live long enough to see it. Unlock the \"Environments 2\" concept art by completing Chapter 11, \"Invasion\", on Deadeye difficulty in Gunslinger Mode"},
	"a_Sights3":				{"en": "Every second the beast lingers, the curse digs deeper. End it fast, or the West won't remember your name at all. Unlock the \"Environments 3\" concept art by completing Chapter 17, \"Curse of the West\", in 10 minutes or less in Gunslinger Mode"},
	"a_Attract":				{"en": "One man, eighty bodies, death keeps count, and so do you. Hope your saddlebag's big enough for the souls you're dragging. Unlock the \"Attract Mode Movie\" concept art by completing Chapter 10, \"The Deadlight Prism\", with 80+ kills in Gunslinger Mode"},
	"a_Cowboy":					{"en": "Lead kills from a distance, but steel? Steel makes 'em remember. Let your blade do the talking. Unlock the \"Giddy-up, Cowboy Animatic\" concept art by completing Chapter 7, \"Torture Maze\", with 30 or more melee kills in Gunslinger Mode"},
	"a_Shower":					{"en": "You boarded with a plan, but evil was already waiting. The only way off is through the wreckage. Unlock the \"Showdown Animatic\" concept art by completing Chapter 15, \"The Right Train\", on Shootist or Deadeye difficulty in Gunslinger Mode"},
	"a_Intro":					{"en": "When the town teetered on ruin, your aim never wavered, each shot a vow to keep the dead where they belong. Unlock the \"Introduction Movie\" concept art by completing Chapter 12, \"Hangtown\", with 20 or more headshot kills in Gunslinger Mode"},
	"a_Moon":					{"en": "The moon's rising, and you've got minutes to make it count. Run fast, shoot faster, or be swallowed by the night. Unlock the \"High Moon Trailer\" concept art by completing Chapter 9, \"Rescue\", in 15 minutes or less in Gunslinger Mode"},
	"a_Archive":				{"en": "A gunslinger's tale ain't written in ink, it's carved in blood and lead. Survive the worst, and your legend might outlast you. Unlock the \"Darkwatch Archives\" concept art by completing all Chapters on Deadeye difficulty in Gunslinger Mode"},
	// --------c_Gunslinger-------- 
	"a_GunWrongTrain": 			{"en": "No time for second chances, burn through the rails like hell's on your heels. Complete Chapter 1, \"The Wrong Train\", in Gunslinger Mode on Deadeye difficulty, within 4 minutes, no deaths, and without dropping below 40% HP"},
	"a_GunRideDevil": 			{"en": "You ain't just riding, you're making every bullet sing. Complete Chapter 2, \"Ride Like the Devil\", in Gunslinger Mode on Deadeye difficulty, with no deaths, at least 70% accuracy, and without falling below 40% HP"},
	"a_GunBoneyard": 			{"en": "The ground's already full, but you kept digging. Complete Chapter 3, \"Boneyard\", in Gunslinger Mode on Deadeye difficulty, with no deaths, only firing with the Carbine or Crossbow, without scoring 5 body-shot kills in a row, mix in headshot or melee kills"},
	"a_GunDevilMine": 			{"en": "Ain't no darkness hiding what you came to do. Complete Chapter 4, \"Devil's Belly Mine\", in Gunslinger Mode on Deadeye difficulty, with no deaths, using only the Redeemer or Dual Pistols, and without using any powers"},
	"a_GunDWOutpost": 			{"en": "The station is drowning in blood, and none of it is yours. Complete Chapter 5, \"Darkwatch Outpost\", in Gunslinger Mode on Deadeye difficulty, with no deaths, and without being below max HP for more than 20 consecutive seconds"},
	"a_GunWarTrain": 			{"en": "The train kept running. You didn't bleed. Complete Chapter 6, \"War Train\", in Gunslinger Mode on Deadeye difficulty, within 5 minutes, no deaths, and without losing any HP"},
	"a_GunTortureMaze": 		{"en": "This ain't no gunfight, it's a sermon of steel. Complete Chapter 7, \"Torture Maze\", in Gunslinger Mode on Deadeye difficulty, with no deaths, only killing with the Scepter or Shotgun, and with at least 60% melee kills"},
	"a_GunBaptismFire": 		{"en": "This baptism ain't in water. Complete Chapter 8, \"Baptism of Fire\", in Gunslinger Mode on Deadeye difficulty, with no deaths, without throwing any explosives, and killing at least 40 enemies with the Rail Rocket"},
	"a_GunRescue": 				{"en": "Bullets flew, the dead swarmed, and you walked out clean. Complete Chapter 9, \"Rescue\", in Gunslinger Mode on Deadeye difficulty, with no deaths, and without losing any HP"},
	"a_GunPrism": 				{"en": "The canyon lit up like Judgment Day, and you brought the thunder. Complete Chapter 10, \"The Deadlight Prism\", in Gunslinger Mode on Deadeye difficulty within 15 minutes, no deaths, and killing only with the Dual Pistols or Shotgun equipped"},
	"a_GunInvasion": 			{"en": "One power. Five flickers of fury. The rest? Pure skill. Complete Chapter 11, \"Invasion\", in Gunslinger Mode on Deadeye difficulty, with no deaths, using only one distinct power, and with only 5 allowed power activations"},
	"a_GunHangtown": 			{"en": "One shot, one soul. No room for waste when the town's already dead. Complete Chapter 12, \"Hangtown\", in Gunslinger Mode on Deadeye difficulty, with no deaths, and achieving at least 75% accuracy, only shooting with the Range Rifle or Redeemer"},
	"a_GunMorningAfter": 		{"en": "The citadel burns, but your powers cut clean and your hands cut cleaner. Complete Chapter 13, \"The Morning After\", in Gunslinger Mode on Deadeye difficulty, with no deaths, using only tier 2 or 3 powers, and with at least 45% melee kills"},
	"a_GunShowdown": 			{"en": "No tricks, no frills, just clean shots and first-tier fury. Complete Chapter 14, \"Showdown\", in Gunslinger Mode on Deadeye difficulty, with no deaths, using only tier 1 powers, and with at least 65% accuracy"},
	"a_GunRightTrain": 			{"en": "That train didn't slow down and neither did you. Complete Chapter 15, \"The Right Train\", in Gunslinger Mode on Deadeye difficulty within 7 minutes, no deaths, and without dropping below 70% HP"},
	"a_GunDeadfall": 			{"en": "The streets were hell, but your aim never flinched. Complete Chapter 16, \"Deadfall\", in Gunslinger Mode on Deadeye difficulty, with no deaths, achieving at least 30% headshot kills using only the Range Rifle or Carbine"},
	"a_GunCurseWest": 			{"en": "You walked the line between damnation and salvation, and bled for neither. Complete Chapter 17, \"Curse of the West\", in Gunslinger Mode on Deadeye difficulty, never dropping below 40% HP, and with only 7 allowed power activations"},
	"a_WeaponMaster":			{"en": "xxxxxxxxx"},
	// --------c_Bonus--------
	"a_GatlingRightTrain":		{"en": "Spin it up and hold the line. In Chapter 15, \"The Right Train\", kill 15 undead in a row with the gatling gun without dismounting or going below 50% vampire shield, on Shootist difficulty or higher. Enemies killed by exploding barrels are not counted"},
	"a_GatlingPrism":			{"en": "The artefact won't defend itself. In Chapter 10, \"The Deadlight Prism\", rack up 15 kills with the gatling gun without dismounting or going below 50% vampire shield, on Shootist difficulty or higher. Enemies killed by exploding barrels are not counted"},
	"a_SunPower":				{"en": "The sun burns down on you, but you refuse to yield. Activate Vampire Vision repeatedly under its relentless heat and see how long you can endure, in Single Player or Gunslinger Mode"},
	"a_Multikill":				{"en": "Send four souls screaming to the afterlife at the same time in Single Player or Gunslinger Mode"},
	"a_AllPowersEvil":			{"en": "No redemption, no regret—only power. Unlock all Evil powers in Single Player"},
	"a_AllPowersGood":			{"en": "Your power serves justice, not damnation. Unlock all Good powers in Single Player"},
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

// ======================
// • RICH PRESENCE text •
// ======================
// #region RP - text
//	- Contains text for the rich presence script
richPresence_text = {
	/* IDEA RP unicode characters
		Default: ♰ ☩ ✟ ✞ ✝ ✠ ⛨ 🕂 🕆 🕂 ᛭
		Good-Evil: ⚡ 🔆 ☀️ ✨ - 🩸 🌙 🌕 ☠ - ⚖
		
		*/
	// "rp_Template": 									{"en": "xxxxxxxx"},

	"rp_Versus":							{"en": "{0} Playing Darkwatch ✟ Multiplayer Versus 🕂 {1} Gunslinger{2} {3} {4} {5}"},
	"rp_Versus_Setup":						{"en": "{0} Playing Darkwatch ✟ setting up a Multiplayer Verus Match"},
	"rp_Coop":								{"en": "{0} Playing Darkwatch ✟ Multiplayer Cooperative 🕂 {1} 🕂 {2}, {3} difficulty"},
	"rp_SinglePlayer":						{"en": "{0} Playing Darkwatch ✟ {1} 🕂 {2} 🕂 {3}, {4} difficulty"},
	"rp_TitleScreen_CoopStoryFin":			{"en": "{0} Playing Darkwatch ✟ Main Menu 🕂 Coop Story Complete: {1}{2} Ending"},
	"rp_TitleScreen_CoopStoryProgress":		{"en": "{0} Playing Darkwatch ✟ Main Menu 🕂 Coop Story Completion: {1}%"},
	"rp_TitleScreen_StoryFin":				{"en": "{0} Playing Darkwatch ✟ Main Menu 🕂 Story Complete: {1}{2} Ending"},
	"rp_TitleScreen_StoryProgress":			{"en": "{0} Playing Darkwatch ✟ Main Menu 🕂 Story Completion: {1}%"},
	"rp_TitleScreen_NoProfile":				{"en": "{0} Playing Darkwatch ✟ Main Menu"},
	"rp_DefaultPlus_StoryFin":				{"en": "{0} Playing Darkwatch ✟ Story Complete: {1}{2} Ending"},
	"rp_DefaultPlus_StoryProgress":			{"en": "{0} Playing Darkwatch ✟ Story Completion: {1}%"},
	"rp_DefaultPlus_NoProfile": 			{"en": "{0} Playing Darkwatch ✟"},
	"rp_Default":							{"en": "Playing Darkwatch ✟"}}
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	"lupText_SinglePlayerMode": {
		"SinglePlayer":				{"en": "Single Player"},
		"Gunslinger":				{"en": "Gunslinger Mode"},
		},
	"lupText_Difficulty": {
		"Greenhorn": 		{"en": "Greenhorn"},
		"Cowboy": 			{"en": "Cowboy"},
		"Shootist": 		{"en": "Shootist"},
		"Deadeye": 			{"en": "Deadeye"},
		},
	"lupText_MPplayerSingularOrPlural": {
		"Singular":				{"en": " is"}, 		// 1 Gunslinger is ...
		"Plural":				{"en": "s are"},	// 2 Gunslingers are ...
		},
	"lupText_MPgameModeFlavorText": {
		"LOOKUP_FALLBACK":			{"en": "locked in a deadly standoff"},
		"Deathmatch":				{"en": "battling for dominance"},
		"SoulHunter":				{"en": "claiming souls"},
		},
	"lupText_MPlevel_DayOrNight": {
		"DayTime":		{"en": "☀️"},
		"NightTime":	{"en": "🌙"},
		},
	"lupText_MPlevel": {
		"LOOKUP_FALLBACK":			{"en": "in \"The Wild West\""},
		"Asylum":			 		{"en": "at \"Darkwatch's Asylum\""},
		"DeathDealer":		 		{"en": "at \"The Death Dealer\""},
		"DevilsBelly":		 		{"en": "in \"The Devil's Belly Mine\""},
		"DonnerPass":		 		{"en": "at \"Donner Pass\""},
		"HangTownEast":		 		{"en": "in \"Hangtown East\""},
		"HangTownWest":		 		{"en": "in \"Hangtown West\""},
		"HellHole":		 			{"en": "at \"The Hellhole\""},
		"TradeCenter":		 		{"en": "at \"The Trade Center\""},
		},
	"lupText_Chapter": {
		"LOOKUP_FALLBACK":		{"en": "\"The Wild West\""},
		"WrongTrain": 			{"en": "Chapter 1, \"The Wrong Train\""},
		"RideDevil": 			{"en": "Chapter 2, \"Ride Like the Devil\""},
		"Boneyard": 			{"en": "Chapter 3, \"Boneyard\""},
		"DevilMine": 			{"en": "Chapter 4, \"Devil's Belly Mine\""},
		"Outpost": 				{"en": "Chapter 5, \"Darkwatch Outpost\""},
		"WarTrain": 			{"en": "Chapter 6, \"War Train\""},
		"TortureMaze": 			{"en": "Chapter 7, \"Torture Maze\""},
		"BaptismFire": 			{"en": "Chapter 8, \"Baptism of Fire\""},
		"Citadel": 				{"en": "\"The Darkwatch Citadel\""},
		"Rescue": 				{"en": "Chapter 9, \"Rescue\""},
		"Prism": 				{"en": "Chapter 10, \"The Deadlight Prism\""},
		"Invasion": 			{"en": "Chapter 11, \"Invasion\""},
		"Hangtown": 			{"en": "Chapter 12, \"Hangtown\""},
		"MorningAfter": 		{"en": "Chapter 13, \"The Morning After\""},
		"Showdown": 			{"en": "Chapter 14, \"Showdown\""},
		"RightTrain": 			{"en": "Chapter 15, \"The Right Train\""},
		"Deadfall": 			{"en": "Chapter 16, \"Deadfall\""},
		"CurseWest": 			{"en": "Chapter 17, \"Curse of the West\""},
		},
	"lupText_ChapterFlavorText_Cooperative": {
		"LOOKUP_FALLBACK":		{"en": "Two Regulators, one mission, cleanse the frontier or die trying"},
		"WrongTrain-1":			{"en": "The Outlaws thought they were hitting gold, turns out, they cracked open hell instead"},
		"WrongTrain-2":			{"en": "The Outlaws heist turned into a nightmare, now they fight to escape with their souls"},
		"RideDevil-1":			{"en": "With the Reaper on their heels, the Gunslingers ride hard, one watching the trail, the other watching their back"},
		"Boneyard-1":			{"en": "Side by side, the Gunslingers walk through graves where the dead don't rest easy"},
		"Boneyard-2":			{"en": "Beneath the church, the Gunslingers step into the dark, whatever's down there, they'll face it together"},
		"Boneyard-3":			{"en": "The deeper they go, the louder the whispers, one wrong move, and the Gunslingers will be just another story in the dirt"},
		"DevilMine-1":			{"en": "The Gunslingers step into the mine, one watching ahead, the other covering their six, no one's coming to pull them out"},
		"DevilMine-2":			{"en": "The air grows thinner, the tunnels tighter, and the Gunslingers know something's moving in the dark"},
		"DevilMine-3":			{"en": "One lights the fuse, the other covers their back, the mine won't give up its secrets easy, but dynamite helps"},
		"DevilMine-4":			{"en": "A voice calls from the depths, one Gunslinger wants to run, the other needs to know who's calling"},
		"Outpost-1":			{"en": "The Gunslingers move in together, one clears the way, the other keeps their rifle steady. The outpost ain't empty"},
		"Outpost-2":			{"en": "Whatever Darkwatch was hiding, the Gunslingers are about to uncover it, if they live long enough"},
		"WarTrain-1":			{"en": "Evil hijacked this train, but the Gunslingers aim to derail their plans, permanently"},
		"TortureMaze-1":		{"en": "Cartwright wants to see if they're worth keeping alive, the Regulators plan to prove it in blood"},
		"TortureMaze-2":		{"en": "One holds the line, the other protects the innocent, Cartwright's test just got real"},	
		"TortureMaze-3":		{"en": "The maze twists, the pipes scream, the Gunslingers push forward through the heat and the horror"},	
		"TortureMaze-4":		{"en": "The maze ain't done yet, the Gunslingers drop into the sewers, where worse things wait"},	
		"TortureMaze-5":		{"en": "The Gunslingers came for a trial, but now they're in a shootout with the damned"},	
		"TortureMaze-6":		{"en": "Cartwright stacked the odds, now the Gunslingers fight with steel and grit alone"},	
		"BaptismFire-1":		{"en": "The Gunslingers earned the badge, but they ain't baptised yet, fire and blood will settle that"},	
		"BaptismFire-2":		{"en": "Side by side, the Regulators carve through the valley, evil don't stand a chance"},	
		"BaptismFire-3":		{"en": "Flames rise, bullets fly, the Regulators battle to reclaim the Trading Post"},	
		"BaptismFire-4":		{"en": "The Trading Post's last stand, one holds the barricade, the other makes every shot count"},
		"Citadel-1":			{"en": "The Regulators got a moment to breathe, no whiskey, no rest, just the next mission waiting"},	
		"Rescue-1":				{"en": "Wheels thunder, Gatling guns roar, one steers, the other lets hell loose on the dead"},
		"Rescue-2":				{"en": "The Regulators break through, saving their own is all that matters"},
		"Prism-1":				{"en": "The Regulators charge into the valley, the Prism won't be lost without a fight"},
		"Prism-2":				{"en": "Undead pick them off from afar, but the Regulators got steady hands and sharper aim"},
		"Prism-3":				{"en": "The twisting canyons try to hide the enemy, one watches the cliffs, the other cuts through the shadows"},
		"Prism-4":				{"en": "The canyon walls close in, the path forward is soaked in blood, neither Regulator is turning back"},
		"Prism-5":				{"en": "The Prism's power floods through them, sunlight be damned, the Regulators fight on"},
		"Invasion-1":			{"en": "The Regulators cut through the caves, old bones, fresh enemies, and no time to waste"},
		"Invasion-2":			{"en": "Smoke rises, bodies fall, one clears the village streets, the other picks off the stragglers"},
		"Invasion-3":			{"en": "The last stand begins, if the Regulators fall, so does the village"},
		"Hangtown-1":			{"en": "The streets ain't safe, two Regulators step in to clean up the mess"},
		"Hangtown-2":			{"en": "Bottles break, bullets fly, the Regulators fight to keep the saloon standing"},
		"Hangtown-3":			{"en": "Hangtown's lost, but the Regulators are here to put the dead down for good"},
		"MorningAfter-1":		{"en": "The citadel burns, but the Regulators ain't letting it fall without a fight"},	
		"MorningAfter-2":		{"en": "The enemy's deep in the caves, two Regulators hold the line underground"},	
		"MorningAfter-3":		{"en": "Darkwatch still stands, for now. The Regulators fight to keep it that way"},	
		"MorningAfter-4":		{"en": "The citadel's power source is under attack, two Regulators stand between it and oblivion"},	
		"MorningAfter-5":		{"en": "Lazarus is making his move, the Regulators have to stop him before it's too late"},	
		"Showdown-1":			{"en": "Lazarus is stronger than ever, but the Regulators don't back down from a fight"},
		"Showdown-2":			{"en": "The battle's over, but the Regulators have one last choice, redemption or power?"},
		"RightTrain-1":			{"en": "The train's bound for hell, and the Regulators are here to take it back"},
		"Deadfall-1":			{"en": "Darkwatch's retaliation starts here, the Regulators lead the charge"},
		"Deadfall-2":			{"en": "No cover, no mercy, the Regulators fight through the wreckage of Deadfall"},
		"Deadfall-3":			{"en": "The deeper they go, the worse it gets, the Regulators wade through the chaos"},
		"Deadfall-4":			{"en": "Buildings crumble, streets burn, Deadfall is falling, but the Regulators push on"},
		"Deadfall-5":			{"en": "The city's tearing itself apart, but the Regulators won't stop now"},
		"CurseWest-1":			{"en": "This ain't just their fight, it's for the whole damn West, whether it's ready or not"},
		},
	"lupText_ChapterFlavorText_SinglePlayer": {
		"LOOKUP_FALLBACK":		{"en": "Ain't no rest for the wicked, or for Jericho Cross"},
		"WrongTrain-1":			{"en": "Jericho Cross came for gold, but what he's stealing is his own damnation"},
		"WrongTrain-2":			{"en": "Cassidy warned him, but Jericho opened the vault anyway, now they fight to survive"},
		"RideDevil-1":			{"en": "Cassidy leads, Jericho rides, and the Reaper's breathing down their necks"},
		"Boneyard-1":			{"en": "Jericho and Cassidy walk among the dead, but the dead ain't resting easy"},
		"Boneyard-2":			{"en": "Beneath the Church, Jericho walks through the bones of the forgotten"},
		"Boneyard-3":			{"en": "The dead still call his name, but now, Jericho hears them differently"},
		"DevilMine-1":			{"en": "Jericho lost Cassidy, but the darkness ain't done with him yet"},
		"DevilMine-2":			{"en": "Jericho ventures deeper into the tunnels, the air is thick, and he ain't alone"},
		"DevilMine-3":			{"en": "The mine wants to keep its secrets, but Jericho came packing dynamite"},
		"DevilMine-4":			{"en": "Jericho ain't alone down here, but what he finds ain't what he expected"},
		"Outpost-1":			{"en": "Jericho enters Darkwatch's stronghold, but the fight's already lost"},
		"Outpost-2":			{"en": "Jericho steps into the unknown, whatever Darkwatch was hiding here, it ain't staying buried"},
		"WarTrain-1":			{"en": "Evil's got a new ride, but Jericho's about to derail their plans"},
		"TortureMaze-1":		{"en": "No guns, no mercy, Cartwright's test starts with blood and steel"},	
		"TortureMaze-2":		{"en": "Killing is easy, protecting the weak? That's Jericho's real test"},	
		"TortureMaze-3":		{"en": "Shapes in the fog, death in the air, Jericho's got to cut through both"},	
		"TortureMaze-4":		{"en": "Cartwright's test leads Jericho into the depths, he must survive the sewers or be doomed to rot in them"},
		"TortureMaze-5":		{"en": "Jericho's trial ain't over 'til he outguns a town full of dead gunslingers"},	
		"TortureMaze-6":		{"en": "Cartwright takes away Jericho's edge, if he wants to survive, he'll need more than fangs"},	
		"BaptismFire-1":		{"en": "Jericho's got his badge, now it's time to prove it in fire and blood"},	
		"BaptismFire-2":		{"en": "Jericho and Tala carve a path through the valley, no evil left standing"},	
		"BaptismFire-3":		{"en": "The Trading Post's already burning, Jericho's just here to finish the job"},	
		"BaptismFire-4":		{"en": "The Trading Post's got one shot at survival, Jericho makes sure it ain't wasted"},
		"Citadel-1":			{"en": "Jericho's got a moment to breathe, but there ain't no saloons here, just the next battle waiting to be fought"},	
		"Rescue-1":				{"en": "Gatling guns roar, wheels thunder, Jericho's bringing hell to the dead"},
		"Rescue-2":				{"en": "The Regulators need saving, and Jericho's the only one left to do it"},
		"Prism-1":				{"en": "The valley's crawling with evil, but Jericho and his squad came to take it back"},
		"Prism-2":				{"en": "The undead strike from afar, but Jericho's aim is deadlier"},
		"Prism-3":				{"en": "The winding canyons don't hide evil for long, Jericho's coming through"},
		"Prism-4":				{"en": "No way but forward, Jericho wades through the canyon's depths, carving a bloody trail"},
		"Prism-5":				{"en": "The sun's up, but Jericho's still got his power, now he's got no excuse not to win"},
		"Invasion-1":			{"en": "Dark tunnels, old bones, and fresh enemies, Jericho fights his way through"},
		"Invasion-2":			{"en": "Smoke rises, bodies fall, Jericho fights to take the village back"},
		"Invasion-3":			{"en": "Jericho holds the line, the dead ain't taking this village"},
		"Hangtown-1":			{"en": "The streets ain't safe yet, Jericho's here to clean up"},
		"Hangtown-2":			{"en": "Bottles ain't the only thing getting smashed, Jericho fights to keep the saloon standing"},
		"Hangtown-3":			{"en": "Hangtown's already lost, but Jericho's here to put the last of the dead to rest"},
		"MorningAfter-1":		{"en": "The citadel is burning, and Jericho's got no choice but to fight for what's left"},
		"MorningAfter-2":		{"en": "The enemy ain't just at the gates, now they're in the caves. Jericho stands his ground"},
		"MorningAfter-3":		{"en": "The citadel ain't fallen yet, Jericho fights to keep it standing"},
		"MorningAfter-4":		{"en": "The citadel's power source is under attack, but Jericho's standing between it and the abyss"},
		"MorningAfter-5":		{"en": "Lazarus is making his move, Jericho races to stop him before it's too late"},
		"Showdown-1":			{"en": "The devil's at full strength, but Jericho's here to put him down anyway"},
		"Showdown-2":			{"en": "The battle's won, but Jericho's got a choice to make, redemption or power"},
		"RightTrain-1":			{"en": "The train's bound for hell, and Jericho's gotta take it back"},
		"Deadfall-1":			{"en": "Darkwatch's final push starts here, Jericho leads the charge into the city"},
		"Deadfall-2":			{"en": "Ain't no cover from the shells or the monsters, Jericho fights through the crumbling streets"},
		"Deadfall-3":			{"en": "The deeper Jericho goes, the worse it gets, the city streets are hell itself"},
		"Deadfall-4":			{"en": "The walls are closing in, but Jericho fights his way through the city's crumbling buildings"},
		"Deadfall-5":			{"en": "The city's tearing itself apart, but Jericho ain't stopping now"},
		"CurseWest-1":			{"en": "This fight ain't just for Jericho, it's for the whole damn West, even if they ain't ready for what's coming"},
		},
	"lupText_IconEvil": {
		"RepEvil":				{"en": "🩸"},
		},
	"lupText_IconGood": {
		"RepGood":				{"en": "⚡"},
		},
	"lupText_DisplayLanguage": {
		"English":				{"en": "ᵉⁿ"},
		"Italian":				{"en": "ᶦᵗ"},
		"Spanish":				{"en": "ᵉˢ"},
		"German":				{"en": "ᵈᵉ"},
		"French":				{"en": "ᶠʳ"},
		"Japanese":				{"en": "ʲᵃ"},
		},
	}
richPresence_ReleaseRegion_toSuperScript = {
	// NOTE: Text to superscript --> https://lingojam.com/SuperscriptGenerator
	RELEASE_REGION_USA: "ᵘˢ",
	RELEASE_REGION_EUR: "ᵉᵘ",
	RELEASE_REGION_JPN: "ʲᵖ",
	}

function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getText_withRegionSuperScript(string_textKey, enum_releaseRegion) =>
	format("{0} {1}", richPresence_ReleaseRegion_toSuperScript[enum_releaseRegion], richPresence_getText(string_textKey))
	// richPresence_ReleaseRegion_toSuperScript[enum_releaseRegion] + " " + richPresence_getText(string_textKey)

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
CONST_HASH_SPICE_LookupTableKey_ChapterFlavorText_MultipleChapterSections = 0x7
function rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(enum_chapter, enum_chapterSection) {
	let_substringLevelID = LEVEL_DATA_getLevelID_substring(enum_chapter)
	return 
		(memUtil_asciiStringToHexLE(let_substringLevelID) // --> FIRST 4-bytes of [ASCII:LevelID]
			+ LEVEL_DATA_getSubstringChapterSectionID_asHexBE(enum_chapter, enum_chapterSection) // --> ANY 4-bytes of [ASCII:ChapterSectionID]
			) * CONST_HASH_SPICE_LookupTableKey_ChapterFlavorText_MultipleChapterSections}

function rpCalculate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(int_offsetToSubstringChapterSectionID, enum_releaseRegion) => 
	(dword(ASCII_MEM_ADDR_LevelID(enum_releaseRegion))  // --> FIRST 4-bytes of [ASCII:LevelID]
		+ dword_be(ASCII_MEM_ADDR_ChapterSectionID(enum_releaseRegion) + int_offsetToSubstringChapterSectionID) // --> ANY 4-bytes of [ASCII:ChapterSectionID]
		) * CONST_HASH_SPICE_LookupTableKey_ChapterFlavorText_MultipleChapterSections

richPresence_lookupTables = {
	// "lup_Template": {
		// "LookupTableText_Key": "lupText_Template",
		// "LookUpTable": {
		// 	enum_XXX_A:					"LookupTextKey_A",
		// 	enum_XXX_B:					"LookupTextKey_B",
		// 	enum_XXX_C:					"LookupTextKey_C",
		// 	},
		// },
	"lup_SinglePlayerMode": {
		"LookupTableText_Key": "lupText_SinglePlayerMode",
		"LookUpTable": {
				0:	"SinglePlayer",
				1:	"Gunslinger",
			},
		},
	"lup_Difficulty": {
		"LookupTableText_Key": "lupText_Difficulty",
		"LookUpTable": {
			DIFFICULTY_Greenhorn:		"Greenhorn",
			DIFFICULTY_Cowboy:			"Cowboy",
			DIFFICULTY_Shootist:		"Shootist",
			DIFFICULTY_Deadeye:			"Deadeye",
			},
		},
	"lup_MPplayerSingularOrPlural": {
		"LookupTableText_Key": "lupText_MPplayerSingularOrPlural",
		"LookUpTable": {
			1: 	"Singular",
			2: 	"Plural",
			},
		},
	"lup_MPgameModeFlavorText": {
		"LookupTableText_Key": "lupText_MPgameModeFlavorText",
		"LookUpTable": {
			MP_VS_GAMEMODE_Deathmatch: 	"Deathmatch",
			MP_VS_GAMEMODE_SoulHunter: 	"SoulHunter",
			},
		},
	"lup_MPlevel_DayOrNight": {
		"LookupTableText_Key": "lupText_MPlevel_DayOrNight",
		"LookUpTable": {
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_Asylum):			"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DeathDealer): 		"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DeathDealerDay): 	"DayTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DevilsBelly): 		"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DonnerPass): 		"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DonnerPassDay): 	"DayTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownEast): 	"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownEastDay): 	"DayTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownWest): 	"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownWestDay): 	"DayTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HellHole): 		"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_TradeCenter): 		"NightTime",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_TradeCenterDay): 	"DayTime",
			},
		},
	"lup_MPlevel": {
		"LookupTableText_Key": "lupText_MPlevel",
		"LookUpTable": {
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_Asylum):			"Asylum",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DeathDealer): 		"DeathDealer",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DeathDealerDay): 	"DeathDealer",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DevilsBelly): 		"DevilsBelly",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DonnerPass): 		"DonnerPass",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_DonnerPassDay): 	"DonnerPass",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownEast): 	"HangTownEast",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownEastDay): 	"HangTownEast",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownWest): 	"HangTownWest",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HangTownWestDay): 	"HangTownWest",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_HellHole): 		"HellHole",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_TradeCenter): 		"TradeCenter",
			MP_LEVEL_DATA_get32BitSubstringLevelID_asHexBE(MULTIPLAYER_LEVEL_TradeCenterDay): 	"TradeCenter",
			},
		},
	"lup_Chapter": {
		"LookupTableText_Key": "lupText_Chapter",
		"LookUpTable": {
			LEVEL_DATA_getLevelID_substring(CHAPTER_1_WrongTrain): 		"WrongTrain", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_2_RideDevil): 		"RideDevil", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_3_Boneyard): 		"Boneyard", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_4_DevilMine): 		"DevilMine",
			LEVEL_DATA_getLevelID_substring(CHAPTER_5_Outpost): 		"Outpost", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_6_WarTrain): 		"WarTrain", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_7_TortureMaze): 	"TortureMaze", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_8_BaptismFire): 	"BaptismFire",
			LEVEL_DATA_getLevelID_substring(CHAPTER_Citadel):			"Citadel", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_9_Rescue): 			"Rescue",
			LEVEL_DATA_getLevelID_substring(CHAPTER_10_Prism):			"Prism", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_11_Invasion):		"Invasion", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_12_Hangtown):		"Hangtown", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_13_MorningAfter):	"MorningAfter", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_14_Showdown):		"Showdown", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_15_RightTrain):		"RightTrain", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_16_Deadfall):		"Deadfall", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_17_CurseWest):		"CurseWest", 
			},
		},
	"lup_ChapterFlavorText_Cooperative_SingleChapterSection": {
		"LookupTableText_Key": "lupText_ChapterFlavorText_Cooperative",
		"LookUpTable": {
			LEVEL_DATA_getLevelID_substring(CHAPTER_2_RideDevil): 		"RideDevil-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_6_WarTrain): 		"WarTrain-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_Citadel): 			"Citadel-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_15_RightTrain): 	"RightTrain-1", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_17_CurseWest): 		"CurseWest-1", 
			},
		},
	"lup_ChapterFlavorText_Cooperative_MultipleChapterSections": {
		"LookupTableText_Key": "lupText_ChapterFlavorText_Cooperative",
		"LookUpTable": {
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_1_WrongTrain, CHAPTER_SECTION_1): 		"WrongTrain-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_1_WrongTrain, CHAPTER_SECTION_2): 		"WrongTrain-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_1): 		"Boneyard-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_2): 		"Boneyard-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_3): 		"Boneyard-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_1): 		"DevilMine-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_2): 		"DevilMine-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_3): 		"DevilMine-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_4): 		"DevilMine-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_5_Outpost, CHAPTER_SECTION_1): 			"Outpost-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_5_Outpost, CHAPTER_SECTION_2): 			"Outpost-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_1): 		"TortureMaze-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_2): 		"TortureMaze-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_3): 		"TortureMaze-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_4): 		"TortureMaze-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_5): 		"TortureMaze-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_6): 		"TortureMaze-6",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_1): 		"BaptismFire-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_2): 		"BaptismFire-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_3): 		"BaptismFire-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_4): 		"BaptismFire-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_9_Rescue, CHAPTER_SECTION_1): 			"Rescue-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_9_Rescue, CHAPTER_SECTION_2): 			"Rescue-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_1): 			"Prism-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_2): 			"Prism-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_3): 			"Prism-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_4): 			"Prism-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_5): 			"Prism-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_1): 		"Invasion-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_2): 		"Invasion-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_3): 		"Invasion-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_1): 		"Hangtown-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_2): 		"Hangtown-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_3): 		"Hangtown-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_1):	"MorningAfter-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_2):	"MorningAfter-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_3):	"MorningAfter-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_4):	"MorningAfter-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_5):	"MorningAfter-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_14_Showdown, CHAPTER_SECTION_1): 		"Showdown-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_14_Showdown, CHAPTER_SECTION_2): 		"Showdown-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_1): 		"Deadfall-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_2): 		"Deadfall-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_3): 		"Deadfall-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_4): 		"Deadfall-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_5): 		"Deadfall-5",
			},
		},
	"lup_ChapterFlavorText_SinglePlayer_SingleChapterSection": {
		"LookupTableText_Key": "lupText_ChapterFlavorText_SinglePlayer",
		"LookUpTable": {
			LEVEL_DATA_getLevelID_substring(CHAPTER_2_RideDevil): 		"RideDevil-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_6_WarTrain): 		"WarTrain-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_Citadel): 			"Citadel-1",
			LEVEL_DATA_getLevelID_substring(CHAPTER_15_RightTrain): 	"RightTrain-1", 
			LEVEL_DATA_getLevelID_substring(CHAPTER_17_CurseWest): 		"CurseWest-1", 
			},
		},
	"lup_ChapterFlavorText_SinglePlayer_MultipleChapterSections": {
		"LookupTableText_Key": "lupText_ChapterFlavorText_SinglePlayer",
		"LookUpTable": {
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_1_WrongTrain, CHAPTER_SECTION_1): 		"WrongTrain-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_1_WrongTrain, CHAPTER_SECTION_2): 		"WrongTrain-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_1): 		"Boneyard-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_2): 		"Boneyard-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_3_Boneyard, CHAPTER_SECTION_3): 		"Boneyard-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_1): 		"DevilMine-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_2): 		"DevilMine-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_3): 		"DevilMine-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_4_DevilMine, CHAPTER_SECTION_4): 		"DevilMine-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_5_Outpost, CHAPTER_SECTION_1): 			"Outpost-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_5_Outpost, CHAPTER_SECTION_2): 			"Outpost-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_1): 		"TortureMaze-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_2): 		"TortureMaze-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_3): 		"TortureMaze-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_4): 		"TortureMaze-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_5): 		"TortureMaze-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_7_TortureMaze, CHAPTER_SECTION_6): 		"TortureMaze-6",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_1): 		"BaptismFire-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_2): 		"BaptismFire-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_3): 		"BaptismFire-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_8_BaptismFire, CHAPTER_SECTION_4): 		"BaptismFire-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_9_Rescue, CHAPTER_SECTION_1): 			"Rescue-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_9_Rescue, CHAPTER_SECTION_2): 			"Rescue-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_1): 			"Prism-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_2): 			"Prism-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_3): 			"Prism-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_4): 			"Prism-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_10_Prism, CHAPTER_SECTION_5): 			"Prism-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_1): 		"Invasion-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_2): 		"Invasion-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_11_Invasion, CHAPTER_SECTION_3): 		"Invasion-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_1): 		"Hangtown-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_2): 		"Hangtown-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_12_Hangtown, CHAPTER_SECTION_3): 		"Hangtown-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_1):	"MorningAfter-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_2):	"MorningAfter-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_3):	"MorningAfter-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_4):	"MorningAfter-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_13_MorningAfter, CHAPTER_SECTION_5):	"MorningAfter-5",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_14_Showdown, CHAPTER_SECTION_1): 		"Showdown-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_14_Showdown, CHAPTER_SECTION_2): 		"Showdown-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_1): 		"Deadfall-1",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_2): 		"Deadfall-2",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_3): 		"Deadfall-3",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_4): 		"Deadfall-4",
			rpGenerate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(CHAPTER_16_Deadfall, CHAPTER_SECTION_5): 		"Deadfall-5",
			},
		},
	"lup_IconEvil": {
		"LookupTableText_Key": "lupText_IconEvil",
		"LookUpTable": {
			0x1:					"RepEvil", // [BitFlag:IsStoryEvilEndingAchieved]
			},
		},	
	"lup_IconGood": {
		"LookupTableText_Key": "lupText_IconGood",
		"LookUpTable": {
			0x1:					"RepGood", // [BitFlag:IsStoryGoodEndingAchieved]
			},
		},	
	"lup_DisplayLanguage": {
		"LookupTableText_Key": "lupText_DisplayLanguage",
		"LookUpTable": {
			LANGUAGE_French:	"French",
			LANGUAGE_German:	"German",
			LANGUAGE_Italian:	"Italian",
			LANGUAGE_English:	"English",
			LANGUAGE_Spanish:	"Spanish",
			},
		},
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
	// 	richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

function rp_Versus_InGame(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_InMultiplayerVersusMode(enum_releaseRegion)
		&& is_flagState_InGame_true(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_Versus", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_PlayerCount", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_MPplayerSingularOrPlural", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_MPgameModeFlavorText", enum_releaseRegion), // 3
		richPresence_callParameterFunction("rpp_MPlevel", enum_releaseRegion), // 4
		richPresence_callParameterFunction("rpp_MPlevel_DayOrNight", enum_releaseRegion) // 5
	)}
function rp_Versus_Setup(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) >= 2
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& tally(1, [ // --Tally--> OrNext chain
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_MultiplayerProfileSelectMenu, enum_releaseRegion)),
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_CreateMultiplayerMatchMenu, enum_releaseRegion)),
			])
		&& never( // --ResetIf--> for above HitCount
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_newSubMenu(enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_Versus_Setup", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion) // 0
	)}

function rp_Coop_SingleChapterSection(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_InMultiplayerCoopMode(enum_releaseRegion)
		&& any_of(LEVEL_DATA_getAllChaptersWithSingleSection(), enum_chapter => 
			is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_Coop", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ChapterFlavorText_Cooperative_SingleChapterSection", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Difficulty", enum_releaseRegion) // 3
	)}
function rp_Coop_MultipleChapterSections(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_InMultiplayerCoopMode(enum_releaseRegion)
		&& any_of(LEVEL_DATA_getAllChaptersWithMultipleSections(), enum_chapter =>
			is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_Coop", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ChapterFlavorText_Cooperative_MultipleChapterSections", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Difficulty", enum_releaseRegion) // 3
	)}
function rp_SinglePlayer_SingleChapterSection(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& !is_WatchingFMV_viaExtrasMenu(enum_releaseRegion)
		&& any_of(LEVEL_DATA_getAllChaptersWithSingleSection(), enum_chapter => 
			is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_SinglePlayer", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_SinglePlayerMode", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ChapterFlavorText_SinglePlayer_SingleChapterSection", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion), // 3
		richPresence_callParameterFunction("rpp_Difficulty", enum_releaseRegion) // 4
	)}
function rp_SinglePlayer_MultipleChapterSections(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& !is_WatchingFMV_viaExtrasMenu(enum_releaseRegion)
		&& any_of(LEVEL_DATA_getAllChaptersWithMultipleSections(), enum_chapter =>
			is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_SinglePlayer", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_SinglePlayerMode", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ChapterFlavorText_SinglePlayer_MultipleChapterSections", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Chapter", enum_releaseRegion), // 3
		richPresence_callParameterFunction("rpp_Difficulty", enum_releaseRegion) // 4
	)}
function rp_TitleScreen_CoopStoryFin(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 2
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& is_AnyEndingAchieved(enum_releaseRegion)
		&& tally(1, [ // --Tally--> OrNext chain
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_ChapterSelectMenu, enum_releaseRegion)),
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_DifficultySelectMenu, enum_releaseRegion)),
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_CoopProfileSelectMenu, enum_releaseRegion))
			])
		&& never( // --ResetIf--> for above HitCount
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_newSubMenu(enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_TitleScreen_CoopStoryFin", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_IconGood", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_IconEvil", enum_releaseRegion) // 2
	)}	
function rp_TitleScreen_CoopStoryProgress(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 2
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& !is_AnyEndingAchieved(enum_releaseRegion)
		&& tally(1, [ // --Tally--> OrNext chain
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_ChapterSelectMenu, enum_releaseRegion)),
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_DifficultySelectMenu, enum_releaseRegion)),
			once(is_MainMenu_SubMenuID(MAINMENU_SUBMENU_CoopProfileSelectMenu, enum_releaseRegion))
			])
		&& never( // --ResetIf--> for above HitCount
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_newSubMenu(enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_TitleScreen_CoopStoryProgress", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_StoryCompletion", enum_releaseRegion) // 1
	)}	
function rp_TitleScreen_StoryFin(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_selected(PLAYER_1, enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 1
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_TitleScreen_StoryFin", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_IconGood", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_IconEvil", enum_releaseRegion) // 2
	)}	
function rp_TitleScreen_StoryProgress(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_selected(PLAYER_1, enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 1
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& !is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_TitleScreen_StoryProgress", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_StoryCompletion", enum_releaseRegion) // 1
	)}
function rp_TitleScreen_NoProfile(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_notSelected(PLAYER_1, enum_releaseRegion)
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& !is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_TitleScreen_NoProfile", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion) // 0
	)}
function rp_DefaultPlus_StoryFin(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_selected(PLAYER_1, enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 1
		&& is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_DefaultPlus_StoryFin", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_IconGood", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_IconEvil", enum_releaseRegion) // 2
	)}	
function rp_DefaultPlus_StoryProgress(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_selected(PLAYER_1, enum_releaseRegion)
		&& current_PlayerCount(enum_releaseRegion) == 1
		&& !is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_DefaultPlus_StoryProgress", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_StoryCompletion", enum_releaseRegion) // 1
	)}
function rp_DefaultPlus_NoProfile(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_atMainMenu(enum_releaseRegion)
		&& is_PlayerProfile_notSelected(PLAYER_1, enum_releaseRegion)
		&& !is_AnyEndingAchieved(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_DefaultPlus_NoProfile", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_DisplayLanguage", enum_releaseRegion) // 0
	)}	
function rp_Default() {
	return rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		rp_Versus_InGame(enum_releaseRegion) // VERIFIED
		rp_Versus_Setup(enum_releaseRegion) // VERIFIED
		rp_Coop_SingleChapterSection(enum_releaseRegion) // VERIFIED
		rp_Coop_MultipleChapterSections(enum_releaseRegion) // VERIFIED
		rp_SinglePlayer_SingleChapterSection(enum_releaseRegion) // VERIFIED
		rp_SinglePlayer_MultipleChapterSections(enum_releaseRegion) // VERIFIED
		rp_TitleScreen_CoopStoryFin(enum_releaseRegion) // VERIFIED
		rp_TitleScreen_CoopStoryProgress(enum_releaseRegion) // VERIFIED
		rp_TitleScreen_StoryFin(enum_releaseRegion) // VERIFIED
		rp_TitleScreen_StoryProgress(enum_releaseRegion) // VERIFIED
		rp_TitleScreen_NoProfile(enum_releaseRegion) // VERIFIED
		rp_DefaultPlus_StoryFin(enum_releaseRegion) // VERIFIED
		rp_DefaultPlus_StoryProgress(enum_releaseRegion) // VERIFIED
		rp_DefaultPlus_NoProfile(enum_releaseRegion) // VERIFIED
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
function rpMeasured_LookupTableKey_ChapterFlavorText_MultipleChapterSections(enum_releaseRegion) {
	let_array_measures = []
	let_array_allUniqueOffsetsToSubstringChapterSectionID = LEVEL_DATA_getAllUniqueOffsetsToSubstringChapterSectionID()
	for let_OffsetToSubstringChapterSectionID in let_array_allUniqueOffsetsToSubstringChapterSectionID {
		let_measured = measured(
			rpCalculate_LookupTableKey_ChapterFlavorText_MultipleChapterSections(let_OffsetToSubstringChapterSectionID, enum_releaseRegion),
			when = any_of(LEVEL_DATA_getAllChaptersWithMultipleSections_withOffsetToSubstringChapterSectionID(let_OffsetToSubstringChapterSectionID), enum_chapter =>
				is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
		)
		array_push(let_array_measures, let_measured)
	}
	return max_of(let_array_measures)}

function rpMeasured_LookupTableKey_MPlevel(enum_releaseRegion) {
	let_array_measures = []
	let_array_allUniqueOffsetsToSubstringLevelID = MP_LEVEL_DATA_getAllUniqueOffsetsToSubstringLevelID()
	for let_offsetToSubstringLevelID in let_array_allUniqueOffsetsToSubstringLevelID {
		let_measured = measured(
			dword_be(ASCII_MEM_ADDR_LevelID(enum_releaseRegion, let_offsetToSubstringLevelID)),
			when = any_of(MP_LEVEL_DATA_getAllLevelIDsWithOffsetToSubstringLevelID(let_offsetToSubstringLevelID), enum_MPlevel =>
				is_LevelSubstring_Multiplayer(enum_MPlevel, enum_releaseRegion))
		)
		array_push(let_array_measures, let_measured)
	}
	return max_of(let_array_measures)}
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
	
	"rpp_IconEvil": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_flagState_IsStoryEvilEndingAchieved(RELEASE_REGION_USA),
			RELEASE_REGION_EUR: current_flagState_IsStoryEvilEndingAchieved(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IconEvil",
		"LookupFallback": ""},
	"rpp_IconGood": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_flagState_IsStoryGoodEndingAchieved(RELEASE_REGION_USA),
			RELEASE_REGION_EUR: current_flagState_IsStoryGoodEndingAchieved(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IconGood",
		"LookupFallback": ""},
	"rpp_SinglePlayerMode": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_GameMode(RELEASE_REGION_USA),
			RELEASE_REGION_EUR: current_GameMode(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_SinglePlayerMode",
		"LookupFallback": richPresence_getLookupTableText("lupText_SinglePlayerMode", "SinglePlayer")},	
	"rpp_DisplayLanguage": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: LANGUAGE_English, // --> RELEASE_REGION_USA has no language select
			RELEASE_REGION_EUR: current_DisplayLanguage(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_DisplayLanguage",
		"LookupFallback": richPresence_getLookupTableText("lupText_DisplayLanguage", "English")},		
	"rpp_Difficulty": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_Difficulty(RELEASE_REGION_USA),
			RELEASE_REGION_EUR: current_Difficulty(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_Difficulty",
		"LookupFallback": richPresence_getLookupTableText("lupText_Difficulty", "Cowboy")},		
	"rpp_ChapterFlavorText_Cooperative_MultipleChapterSections": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: rpMeasured_LookupTableKey_ChapterFlavorText_MultipleChapterSections(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpMeasured_LookupTableKey_ChapterFlavorText_MultipleChapterSections(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ChapterFlavorText_Cooperative_MultipleChapterSections",
		"LookupFallback": richPresence_getLookupTableText("lupText_ChapterFlavorText_Cooperative", "LOOKUP_FALLBACK")},
	
	"rpp_ChapterFlavorText_SinglePlayer_MultipleChapterSections": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: rpMeasured_LookupTableKey_ChapterFlavorText_MultipleChapterSections(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpMeasured_LookupTableKey_ChapterFlavorText_MultipleChapterSections(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ChapterFlavorText_SinglePlayer_MultipleChapterSections",
		"LookupFallback": richPresence_getLookupTableText("lupText_ChapterFlavorText_SinglePlayer", "LOOKUP_FALLBACK")},
	"rpp_MPplayerSingularOrPlural": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_PlayerCount(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: current_PlayerCount(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_MPplayerSingularOrPlural",
		"LookupFallback": richPresence_getLookupTableText("lupText_MPplayerSingularOrPlural", "Plural")},
	"rpp_MPgameModeFlavorText": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: current_MultiplayerVersusGameMode(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: current_MultiplayerVersusGameMode(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_MPgameModeFlavorText",
		"LookupFallback": richPresence_getLookupTableText("lupText_MPgameModeFlavorText", "LOOKUP_FALLBACK")},
	
	"rpp_MPlevel": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: rpMeasured_LookupTableKey_MPlevel(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpMeasured_LookupTableKey_MPlevel(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_MPlevel",
		"LookupFallback": richPresence_getLookupTableText("lupText_MPlevel", "LOOKUP_FALLBACK")},
	"rpp_MPlevel_DayOrNight": {
		"RPtype": richPresence_LOOKUP_HEX,
		"Expression": {
			RELEASE_REGION_USA: rpMeasured_LookupTableKey_MPlevel(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpMeasured_LookupTableKey_MPlevel(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_MPlevel_DayOrNight",
		"LookupFallback": richPresence_getLookupTableText("lupText_MPlevel_DayOrNight", "NightTime")},

	"rpp_ChapterFlavorText_Cooperative_SingleChapterSection": {
		"RPtype": richPresence_LOOKUP_STRING,
		"MemoryAddressToASCII": {
			RELEASE_REGION_USA: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ChapterFlavorText_Cooperative_SingleChapterSection",
		"LookupFallback": richPresence_getLookupTableText("lupText_ChapterFlavorText_Cooperative", "LOOKUP_FALLBACK")}, 
	"rpp_ChapterFlavorText_SinglePlayer_SingleChapterSection": {
		"RPtype": richPresence_LOOKUP_STRING,
		"MemoryAddressToASCII": {
			RELEASE_REGION_USA: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ChapterFlavorText_SinglePlayer_SingleChapterSection",
		"LookupFallback": richPresence_getLookupTableText("lupText_ChapterFlavorText_SinglePlayer", "LOOKUP_FALLBACK")},
	"rpp_Chapter": {
		"RPtype": richPresence_LOOKUP_STRING,
		"MemoryAddressToASCII": {
			RELEASE_REGION_USA: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: ASCII_MEM_ADDR_LevelID(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_Chapter",
		"LookupFallback": richPresence_getLookupTableText("lupText_Chapter", "LOOKUP_FALLBACK")},	
	
	"rpp_StoryCompletion": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: current_calculated_SinglePlayerStoryProgressionPercentage(RELEASE_REGION_USA),
			RELEASE_REGION_EUR: current_calculated_SinglePlayerStoryProgressionPercentage(RELEASE_REGION_EUR)},
		"MacroFormat": "Number"},
	"rpp_PlayerCount": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: current_PlayerCount(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: current_PlayerCount(RELEASE_REGION_EUR)},
		"MacroFormat": "Number"},	
	
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

// =========================
// • LEADERBOARD core data •
// =========================
// #region LB - core data
// -----------------Leaderboard Settings--------------------
LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime = 25200000.0 // 25.200.000 ms = 7 hours || MissionTime is the base value of the custom scoring system for lb_Watchers
LB_WATCHERS_SETIINGS_BaseScore_MissionTime = 25000.0 // 25.000
LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER = { // Because DIFFICULTY_Greenhorn = 0x0
	DIFFICULTY_Greenhorn: 0x1,
	DIFFICULTY_Cowboy: 0x2,
	DIFFICULTY_Shootist: 0x3,
	DIFFICULTY_Deadeye: 0x4}
LB_WATCHERS_SETIINGS_ScoreIncrease_Kills = 70.0
LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills = 30.0
LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills = 10.0
LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit = 12.0 // 1 Hit = BaseScore + (Score_ShotsHit - Score_Shotsfired)
LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired = 5.0 // 1 Miss = BaseScore - Score_Shotsfired
LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths = 5000.0

LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime = 7200000.0 // 7.200.000 ms = 2 hours || MissionTime is the base value of the custom scoring system for lb_Watchers
LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime = 25000.0 // 25.000
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills = 10000.0 // 10.000
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills = 1500.0
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills = 1000.0
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit = 17.0 // 1 Hit = BaseScore + (Score_ShotsHit - Score_Shotsfired)
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired = 10.0 // 1 Miss = BaseScore - Score_Shotsfired
LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths = 5000.0

LB_STORYTIME_Min_Missiontime_PerChapter = 20000 // 20 sec (=20.000 ms) 
LB_STORYTIME_Min_Required_TotalStory_Missiontime = 4627000 // 4.627.000 ms (=1h 17min 7sec) (this is a random time, 30~ min below the fastest speedrun of this game, to counter softcore RAM altered save state or tampered saveFile cheating)
LB_STORYTIME_Max_Allowed_TotalStory_Missiontime_softcore = 180000000 // 180,000,000 ms (=50h)
LB_STORYTIME_Max_Allowed_TotalStory_Missiontime_hardcore = 36000000 // 36.000,000 ms (=10h)
// ------------------------------------- 
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
		// "id": 000000, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "xxxxxxx"},
	// ------lb_Watchers------
	// "lb_WatchersWrongTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127404, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_1_WrongTrain, from start to finish (single session)"},
	// "lb_WatchersRideDevil": { // VERIFIED  // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127405, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_2_RideDevil, from start to finish (single session)"},
	// "lb_WatchersBoneyard": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127406, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_3_Boneyard, from start to finish (single session)"},
	// "lb_WatchersDevilMine": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127407, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_4_DevilMine, from start to finish (single session)"},
	// "lb_WatchersDWOutpost": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127408, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_5_Outpost, from start to finish (single session)"},
	// "lb_WatchersWarTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127409, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_6_WarTrain, from start to finish (single session)"},
	// "lb_WatchersTortureMaze": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127410, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_7_TortureMaze, from start to finish (single session)"},
	// "lb_WatchersBaptismFire": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127411, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_8_BaptismFire, from start to finish (single session)"},
	// "lb_WatchersRescue": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127412, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_9_Rescue, from start to finish (single session)"},
	// "lb_WatchersPrism": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127413, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_10_Prism, from start to finish (single session)"},
	// "lb_WatchersInvasion": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127414, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_11_Invasion, from start to finish (single session)"},
	// "lb_WatchersHangtown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127417, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_12_Hangtown, from start to finish (single session)"},
	// "lb_WatchersMorningAfter": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127416, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_13_MorningAfter, from start to finish (single session)"},
	// "lb_WatchersShowdown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127419, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_14_Showdown, from start to finish (single session)"},
	// "lb_WatchersRightTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127418, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_15_RightTrain, from start to finish (single session)"},
	// "lb_WatchersDeadfall": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127415, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_16_Deadfall, from start to finish (single session)"},	
	// "lb_WatchersCurseWest": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 127420, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_17_CurseWest, from start to finish (single session)"},
	// ------lb_StoryTime------
	// "lb_StoryTimeSoftGreenhorn": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START)
		// "id": 128269, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Story Total Time (non-single session) Greenhorn difficulty"},
	// "lb_StoryTimeSoftCowboy": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START)
		// "id": 128267, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Story Total Time (non-single session) Cowboy difficulty"},
	// "lb_StoryTimeSoftShootist": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START)
		// "id": 128270, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Story Total Time (non-single session) Shootist difficulty"},
	// "lb_StoryTimeSoftDeadeye": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START)
		// "id": 128268, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Story Total Time (non-single session) Deadeye difficulty"},
	// "lb_StoryTimeHardGreenhorn": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START,CANCEL)
		// "id": 128265, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Any% speedrun (single session) Greenhorn difficulty (optional timer overlay)"},
	// "lb_StoryTimeHardCowboy": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START,CANCEL)
		// "id": 128263, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Any% speedrun (single session) Cowboy difficulty (optional timer overlay)"},
	// "lb_StoryTimeHardShootist": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START,CANCEL)
		// "id": 128266, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Any% speedrun (single session) Shootist difficulty (optional timer overlay)"},
	// "lb_StoryTimeHardDeadeye": { // VERIFIED_kinda // DISABLED - MANUAL_CONSTRUCTION (START,CANCEL)
		// "id": 128264, "isLowerBetter": true, "leaderboardFormat": "MILLISECS", "devInfo": "Single Player: Any% speedrun (single session) Deadeye difficulty (optional timer overlay)"},
	}
// #endregion LB - core data

// ==================================
// • LEADERBOARD trigger generators •
// ==================================
// #region LB - trigger generators
//	- For leaderboard logic that's reoccuring across multiple triggers
function lbGenerate_FullStartTrigger_ChapterCompletion(enum_chapter, enum_releaseRegion) =>
	// [1] ==== Alt Start Group ====		-> Start when Chapter begins from ChapterSection 1
		is_ReleaseRegion(enum_releaseRegion)
		&& is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
		&& is_flagState_InGame_true(enum_releaseRegion)
		&& on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion)

function lbGenerate_FullCancelTrigger_ChapterCompletion(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// [1] ==== Alt Cancel Group ====		-> Cancel when LevelID is incorrect
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
	// [2] ==== Alt Cancel Group ==== 		-> Cancel when not in SinglePlayer OR Gunslinger Mode
		|| is_ReleaseRegion(enum_releaseRegion)
		&& !is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion)
	// [3] ==== Alt Cancel Group ==== 		-> Cancel MissionTime_ChapterTotal exceeds LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
		|| is_ReleaseRegion(enum_releaseRegion)
		&& current_MissionTime_ChapterTotal(enum_releaseRegion) > LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
		&& prev_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
	// [4] ==== Alt Cancel Group ====		-> Cancel when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION:CancelOn_PauseMenu_Quit - (AltGroup[4/8]) R/R usage
			--> MANUAL_CONSTRUCTION[1FD-3FD]
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1_I:0xX00721900_0xM0000000f>d0xM0000000f
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1_I:0xX00720000_0xM0000000f>d0xM0000000f
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
							->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Quit	| CheckIf: FrameTitle == "Quit"
				
				AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0x7C
							->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

				AddAddress	[Pointer:PlayerInput(preferred)]
							Mem [BitFlag:IsInputPressed_Cross] > Delta [Bitflag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)		
				*/	
		|| is_ReleaseRegion(enum_releaseRegion)
		&& on_PauseMenu_Quit(enum_releaseRegion) // --> MANUAL_CONSTRUCTION[1FD-3FD]
		
function lbGenerate_FullSubmitTrigger_ChapterCompletion(enum_chapter, enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	/* NOTE: In Single Player, the ChapterStats saved during gameplay are zeroed out when game saves them to [Array:SavedStats_Story]
		In Gunslinger Mode, the ChapterStats are saved to [Array:SavedStats_Gunslinger], but the ChapterStats saved during gameplay are NOT zeroed out
		*/
	// [1] ==== Alt Submit Group - SinglePlayer Mode ====	-> Submit when Chapter was started from beginning AND finished, then submits on_Loading_start() - When in SinglePlayer Mode
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_InSinglePlayerMode(enum_releaseRegion))
		&& once( // --CheckIf--> Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended + MissionTime does not exceed 7 hours
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		// && once( // --CheckIf--> ChapterStats have been saved to [Array:SavedStats_Story] 
		// 	current_MissionTime_Temp(enum_releaseRegion)
		// 		+ current_MissionTime_ChapterSection(enum_releaseRegion)
		// 		+ current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
		// 	&& prev_MissionTime_Temp(enum_releaseRegion)
		// 		+ prev_MissionTime_ChapterSection(enum_releaseRegion)
		// 		+ prev_MissionTime_ChapterTotal(enum_releaseRegion) > 0)
		// && !is_anyFMV_active(enum_releaseRegion)
		&& on_Loading_start(enum_releaseRegion)
	// [2] ==== Alt Submit Group - Gunslinger Mode ====		-> Submit when Chapter was started from beginning AND finished, then submits on_MainMenu_PostChapterGunslingerStatsMenu_continue() - When in Gunslinger Mode
		|| unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_InGunslingerMode(enum_releaseRegion))
		&& once( // --CheckIf--> Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended + MissionTime does not exceed 7 hours
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_InGame_true(enum_releaseRegion)
			&& is_flagState_InGame_false(enum_releaseRegion))
		&& on_MainMenu_PostChapterGunslingerStatsMenu_continue(enum_releaseRegion)
	// [3] ==== Alt Reset Group ====						-> Reset when LevelID is incorrect
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 						-> Reset when not in SinglePlayer OR Gunslinger Mode
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InSinglePlayer_OR_GunslingerMode(enum_releaseRegion))
	// [5] ==== Alt Reset Group ==== 						-> Reset when pressing PauseMenu->Quit
		/* MANUAL_CONSTRUCTION:ResetOn_PauseMenu_Quit - (AltGroup[5/10]) R/R usage
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

							Val 0x0 == Val 0x1
				*/	
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-3FD]

function lbGenerate_FullStartTrigger_SoftStoryCompletion(enum_difficulty, enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
	const_HIGHEST_DIFFICULTY = DIFFICULTY_Deadeye
	return
	// [1] ==== Alt Start/Submit Group ====		-> Start/Submit when last Story Chapter is finished AND check if all of the completed chapters are finished on enum_difficulty or higher
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf--[StartCondition]--> Last Story Level/Chapter is started from beginning
			is_Difficulty(enum_difficulty, enum_releaseRegion)
			&& on_LastChapterSection_startFromBeginning(CHAPTER_17_CurseWest, enum_releaseRegion))
		&& tally(1, [ // --CheckIf--> Any of the Ending FMVs have played
			once(on_FMV_start(FMV_Hero, enum_releaseRegion)),
			once(on_FMV_start(FMV_Monster, enum_releaseRegion))])
		&& once( // --CheckIf--> Credits FMV starts 		
			on_FMV_start(FMV_Credits, enum_releaseRegion)) 
		&& all_of(CONST_LEVEL_DATA, (enum_chapter) { // --CheckIf--> All Chapters have been completed on enum_difficulty or higher (CHAPTER_Citadel excluded)
			if (enum_chapter == CHAPTER_Citadel) return always_true() // --> Exclude CHAPTER_Citadel from this Check
			return 
				current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) >= LB_STORYTIME_Min_Missiontime_PerChapter
				&& current_SavedStatStory_Difficulty(enum_chapter, enum_releaseRegion) >= enum_difficulty
				&& current_SavedStatStory_Difficulty(enum_chapter, enum_releaseRegion) <= const_HIGHEST_DIFFICULTY
			})
		&& current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) >= LB_STORYTIME_Min_Required_TotalStory_Missiontime
		&& current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) <= LB_STORYTIME_Max_Allowed_TotalStory_Missiontime_softcore
		&& on_FMV_end(FMV_Credits, enum_releaseRegion)
	// [2] ==== Alt Reset Group ====		-> Reset when not in Single Player 
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InSinglePlayerMode(enum_releaseRegion))
	// [3] ==== Alt Reset Group ====		-> Reset when not in CHAPTER_17_CurseWest
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_LevelSubstring_StoryChapter(CHAPTER_17_CurseWest, enum_releaseRegion))
	// [4] ==== Alt Reset Group ====		-> Reset when starting a new Chapter from MainMenu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion))
	// [5/10] ==== Alt Reset Group ====		-> Reset on PauseMenu->Quit 
		/* MANUAL_CONSTRUCTION:ResetOn_PauseMenu_Quit (AltGroup[5/10]) - R/R usage
			--> MANUAL_CONSTRUCTION[1FD-3FD] with ResetIf+AndNext
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/	
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-3FD]
	}

function lbGenerate_FullStartTrigger_HardStoryCompletion(enum_difficulty, enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION
	// NOTE: When starting from a previously completed Chapter in Single Player Mode, all ChapterStats in [Array:SavedStats_Story] from succeeding Chapters and the selected Chapter will be zeroed out
	const_IN_PROGRESS_STORYCHAPTER_ID_WrongTrain = 1 // CHAPTER_1_WrongTrain
	const_MAINMENU_HIGHLIGHTED_BUTTON_SinglePlayer = 0
	const_INPUT_FOR_TIMER_OVERLAY = INPUT_Select
	const_ALL_STORY_CHAPTERS = array_filter(CONST_LEVEL_DATA, (enum_chapter) { // All Chapters (CHAPTER_Citadel excluded)
		if (enum_chapter == CHAPTER_Citadel) return false
		else return true
		})
	return
	// [1] ==== Alt Start Group (w/ Time Overlay) ====		-> Start when starting CHAPTER_1_WrongTrain from MainMenu with SELECT pressed - Runs leaderboard with an RAoverlay tracking time 
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once( // --CheckIf[A]--> player selects SinglePlayer at MainMenu (necessary check, as otherwise we can't check for Gunslinger or SinglePlayer within MainMenus)
			never(on_MainMenu_SubMenu_render(MAINMENU_SUBMENU_MainMenu, enum_releaseRegion))
			&& is_atMainMenu(enum_releaseRegion)
			&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_MainMenu, enum_releaseRegion)
			&& current_MainMenu_HighlightedButton(enum_releaseRegion) == const_MAINMENU_HIGHLIGHTED_BUTTON_SinglePlayer
			&& on_PlayerInput_press(PLAYER_1, INPUT_Cross, enum_releaseRegion))
		&& all_of(CONST_LEVEL_DATA, enum_chapter => // --CheckIf--> [Array:SavedStats_Story] is clean
			current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) == 0)
		&& is_flagState_IsInputPressed_true(CONTROLLER_1, const_INPUT_FOR_TIMER_OVERLAY, enum_releaseRegion)
		&& current_InProgressStoryChapterID(enum_releaseRegion) == const_IN_PROGRESS_STORYCHAPTER_ID_WrongTrain // --> [8-bit:InProgress_StoryChapterID] is set when confirming the Chapter in MAINMENU_SUBMENU_ChapterSelectMenu
		&& current_MainMenu_DifficultySelectMenu_SelectedDifficulty(enum_releaseRegion) == enum_difficulty
		&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion)
	// [2] ==== Alt Start/Submit Group (no Time Overlay) ====		-> Start/Submit when completing Single Player Story Mode in one whole session, from start to finish
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		// && is_InSinglePlayerMode(enum_releaseRegion) // --Line--> Could replace below once(), only for this altGroup
		&& once( // --CheckIf[A]--> player selects SinglePlayer at MainMenu (necessary check, as otherwise we can't check for Gunslinger or SinglePlayer within MainMenus)
			never(on_MainMenu_SubMenu_render(MAINMENU_SUBMENU_MainMenu, enum_releaseRegion))
			&& is_atMainMenu(enum_releaseRegion)
			&& is_MainMenu_SubMenuID(MAINMENU_SUBMENU_MainMenu, enum_releaseRegion)
			&& current_MainMenu_HighlightedButton(enum_releaseRegion) == const_MAINMENU_HIGHLIGHTED_BUTTON_SinglePlayer
			&& on_PlayerInput_press(PLAYER_1, INPUT_Cross, enum_releaseRegion))
		&& once( // --CheckIf--> Started CHAPTER_1_WrongTrain
			all_of(CONST_LEVEL_DATA, enum_chapter => // --CheckIf--> [Array:SavedStats_Story] is clean
				current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) == 0)
			&& current_InProgressStoryChapterID(enum_releaseRegion) == const_IN_PROGRESS_STORYCHAPTER_ID_WrongTrain // --> [8-bit:InProgress_StoryChapterID] is set when confirming the Chapter in MAINMENU_SUBMENU_ChapterSelectMenu
			&& current_MainMenu_DifficultySelectMenu_SelectedDifficulty(enum_releaseRegion) == enum_difficulty
			&& on_MainMenu_DifficultySelectMenu_chapterStart(enum_releaseRegion))
		&& tally_of(const_ALL_STORY_CHAPTERS, length(const_ALL_STORY_CHAPTERS), enum_chapter => // --CheckIf--> All Story Chapters have start from beginning once (CHAPTER_Citadel excluded)
			once(on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion)))
		&& tally(1, [ // --CheckIf--> Any of the Ending FMVs have played
			once(on_FMV_start(FMV_Hero, enum_releaseRegion)),
			once(on_FMV_start(FMV_Monster, enum_releaseRegion))])
	// [3] ==== Alt Reset Group ====		-> Reset when entering MainMenu (necessary to reset HitCounts on CheckIf[A], when quiting back to MAINMENU_SUBMENU_MainMenu)
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_enter(enum_releaseRegion))
	// [4] ==== Alt Reset Group ====		-> Reset on PauseMenu->Quit (may be unecessary due to AltGroup[3], but safest to keep this in)
		/* MANUAL_CONSTRUCTION:ResetOn_PauseMenu_Quit (AltGroup[4]) - R/R usage
			--> MANUAL_CONSTRUCTION[1FD-3FD] with ResetIf+AndNext
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_R:0xM0000000f>d0xM0000000f_0=1
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_R:0xM0000000f>d0xM0000000f_0=1
			*/	
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[1FD-3FD]
	}
function lbGenerate_FullCancelTrigger_HardStoryCompletion(enum_releaseRegion) => // WARNING - (1x) MANUAL_CONSTRUCTION
	// NOTE: Cancel can only trigger when playing with Time Overlay enabled
	// [1/4] ==== Alt Cancel Group ====		-> Cancel on PauseMenu->Quit 
		/* MANUAL_CONSTRUCTION:CancelOn_PauseMenu_Quit (AltGroup[1/4]) - R/R usage
			--> MANUAL_CONSTRUCTION[1FD-3FD]
			PAL: 	N:0xX007215cc=1397050451_N:0xH0073b430=3_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1_I:0xX00721900_0xM0000000f>d0xM0000000f
			NTSCU: 	N:0xX0071fccc=1398099027_N:0xH00729330=3_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_0xX00000068=1_I:0xX00720000_0xM0000000f>d0xM0000000f
			*/	
		is_ReleaseRegion(enum_releaseRegion)
		&& on_PauseMenu_Quit(enum_releaseRegion) // --> MANUAL_CONSTRUCTION[1FD-3FD]
	// [2] ==== Alt Cancel Group ====		-> Cancel when TotalStoryTime overflow occurs, while IN-GAME
		|| is_ReleaseRegion(enum_releaseRegion)
		&& is_flagState_InGame_true(enum_releaseRegion)
		&& on_calculated_TotalStoryTime_whileInGame_overflow(enum_releaseRegion) // --CheckIf--> overflow occurs; 0xFFFFFFFF (= 1193 hours)
	// [3] ==== Alt Cancel Group ====		-> Cancel when TotalStoryTime while NOT IN-GAME exceeds LB_STORYTIME_Max_Allowed_TotalStory_Missiontime_hardcore
		|| is_ReleaseRegion(enum_releaseRegion)
		&& is_flagState_InGame_false(enum_releaseRegion)
		&& current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) > LB_STORYTIME_Max_Allowed_TotalStory_Missiontime_hardcore

function lbGenerate_FullSubmitTrigger_HardStoryCompletion(enum_difficulty, enum_releaseRegion) =>
	// [1] ==== Alt Submit Group ====			-> Submit when all Chapters have been started once AND FMV_Credits ends
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& tally_of(CONST_LEVEL_DATA, length(CONST_LEVEL_DATA), enum_chapter => 
			once(on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))) // Side Note: Technically CHAPTER_Citadel is started 4x times, but HitCount only once 
		&& on_FMV_start(FMV_Credits, enum_releaseRegion)
	// [2] ==== Alt Reset Group ====		-> Reset when entering MainMenu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_enter(enum_releaseRegion))


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
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_1_WrongTrain, enum_releaseRegion)),
	"lb_WatchersRideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_2_RideDevil, enum_releaseRegion)),
	"lb_WatchersBoneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_3_Boneyard, enum_releaseRegion)),
	"lb_WatchersDevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_4_DevilMine, enum_releaseRegion)),
	"lb_WatchersDWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_5_Outpost, enum_releaseRegion)),
	"lb_WatchersWarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_6_WarTrain, enum_releaseRegion)),
	"lb_WatchersTortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_7_TortureMaze, enum_releaseRegion)),
	"lb_WatchersBaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_8_BaptismFire, enum_releaseRegion)),
	"lb_WatchersRescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_9_Rescue, enum_releaseRegion)),
	"lb_WatchersPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_10_Prism, enum_releaseRegion)),
	"lb_WatchersInvasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_11_Invasion, enum_releaseRegion)),
	"lb_WatchersHangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_12_Hangtown, enum_releaseRegion)),
	"lb_WatchersMorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_13_MorningAfter, enum_releaseRegion)),
	"lb_WatchersShowdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_14_Showdown, enum_releaseRegion)),
	"lb_WatchersRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_15_RightTrain, enum_releaseRegion)),
	"lb_WatchersDeadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_16_Deadfall, enum_releaseRegion)),
	"lb_WatchersCurseWest": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullStartTrigger_ChapterCompletion(CHAPTER_17_CurseWest, enum_releaseRegion)),
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_SoftStoryCompletion(DIFFICULTY_Greenhorn, enum_releaseRegion)),
	"lb_StoryTimeSoftCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_SoftStoryCompletion(DIFFICULTY_Cowboy, enum_releaseRegion)),
	"lb_StoryTimeSoftShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_SoftStoryCompletion(DIFFICULTY_Shootist, enum_releaseRegion)),
	"lb_StoryTimeSoftDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_SoftStoryCompletion(DIFFICULTY_Deadeye, enum_releaseRegion)),
	"lb_StoryTimeHardGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_HardStoryCompletion(DIFFICULTY_Greenhorn, enum_releaseRegion)),
	"lb_StoryTimeHardCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_HardStoryCompletion(DIFFICULTY_Cowboy, enum_releaseRegion)),
	"lb_StoryTimeHardShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_HardStoryCompletion(DIFFICULTY_Shootist, enum_releaseRegion)),
	"lb_StoryTimeHardDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullStartTrigger_HardStoryCompletion(DIFFICULTY_Deadeye, enum_releaseRegion)),

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
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_1_WrongTrain, enum_releaseRegion)),
	"lb_WatchersRideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_2_RideDevil, enum_releaseRegion)),
	"lb_WatchersBoneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_3_Boneyard, enum_releaseRegion)),
	"lb_WatchersDevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_4_DevilMine, enum_releaseRegion)),
	"lb_WatchersDWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_5_Outpost, enum_releaseRegion)),
	"lb_WatchersWarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_6_WarTrain, enum_releaseRegion)),
	"lb_WatchersTortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_7_TortureMaze, enum_releaseRegion)),
	"lb_WatchersBaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_8_BaptismFire, enum_releaseRegion)),
	"lb_WatchersRescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_9_Rescue, enum_releaseRegion)),
	"lb_WatchersPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_10_Prism, enum_releaseRegion)),
	"lb_WatchersInvasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_11_Invasion, enum_releaseRegion)),
	"lb_WatchersHangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_12_Hangtown, enum_releaseRegion)),
	"lb_WatchersMorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_13_MorningAfter, enum_releaseRegion)),
	"lb_WatchersShowdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_14_Showdown, enum_releaseRegion)),
	"lb_WatchersRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_15_RightTrain, enum_releaseRegion)),
	"lb_WatchersDeadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_16_Deadfall, enum_releaseRegion)),
	"lb_WatchersCurseWest": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullCancelTrigger_ChapterCompletion(CHAPTER_17_CurseWest, enum_releaseRegion)),
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()), 
	"lb_StoryTimeSoftCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()), 
	"lb_StoryTimeSoftShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()), 
	"lb_StoryTimeSoftDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()), 
	"lb_StoryTimeHardGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullCancelTrigger_HardStoryCompletion(enum_releaseRegion)),
	"lb_StoryTimeHardCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullCancelTrigger_HardStoryCompletion(enum_releaseRegion)),
	"lb_StoryTimeHardShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullCancelTrigger_HardStoryCompletion(enum_releaseRegion)),
	"lb_StoryTimeHardDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullCancelTrigger_HardStoryCompletion(enum_releaseRegion)),
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
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_1_WrongTrain, enum_releaseRegion)),
	"lb_WatchersRideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_2_RideDevil, enum_releaseRegion)),
	"lb_WatchersBoneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_3_Boneyard, enum_releaseRegion)),
	"lb_WatchersDevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_4_DevilMine, enum_releaseRegion)),
	"lb_WatchersDWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_5_Outpost, enum_releaseRegion)),
	"lb_WatchersWarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_6_WarTrain, enum_releaseRegion)),
	"lb_WatchersTortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_7_TortureMaze, enum_releaseRegion)),
	"lb_WatchersBaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_8_BaptismFire, enum_releaseRegion)),
	"lb_WatchersRescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_9_Rescue, enum_releaseRegion)),
	"lb_WatchersPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_10_Prism, enum_releaseRegion)),
	"lb_WatchersInvasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_11_Invasion, enum_releaseRegion)),
	"lb_WatchersHangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_12_Hangtown, enum_releaseRegion)),
	"lb_WatchersMorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_13_MorningAfter, enum_releaseRegion)),
	"lb_WatchersShowdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_14_Showdown, enum_releaseRegion)),
	"lb_WatchersRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_15_RightTrain, enum_releaseRegion)),
	"lb_WatchersDeadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_16_Deadfall, enum_releaseRegion)),
	"lb_WatchersCurseWest": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		lbGenerate_FullSubmitTrigger_ChapterCompletion(CHAPTER_17_CurseWest, enum_releaseRegion)),
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()), 
	"lb_StoryTimeSoftCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()), 
	"lb_StoryTimeSoftShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()), 
	"lb_StoryTimeSoftDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()), 
	"lb_StoryTimeHardGreenhorn": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullSubmitTrigger_HardStoryCompletion(DIFFICULTY_Greenhorn, enum_releaseRegion)),
	"lb_StoryTimeHardCowboy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullSubmitTrigger_HardStoryCompletion(DIFFICULTY_Cowboy, enum_releaseRegion)),
	"lb_StoryTimeHardShootist": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullSubmitTrigger_HardStoryCompletion(DIFFICULTY_Shootist, enum_releaseRegion)),
	"lb_StoryTimeHardDeadeye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		lbGenerate_FullSubmitTrigger_HardStoryCompletion(DIFFICULTY_Deadeye, enum_releaseRegion)),
	}
//-----------------ValueMeasures-------------------
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(
			current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion),
			when = 
				is_ReleaseRegion(enum_releaseRegion)
			)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}

function lb_ValueMeasure_AllStatsScore(enum_chapter) { // WARNING - (3x) MANUAL_CONSTRUCTION
	function valueMeasure_InGame(enum_difficulty, enum_releaseRegion) => // ValueMeasure[Value,3,6,9/12,15,18,21] --> ValueMeasure during during gameplay; This ValueMeasure is never submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_InGame - (below Measured, without MeasuredIf) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	A:0xX00965c08_A:0xX00965c70_K:0xX00965c3c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c24*f12.0_B:0xX00965c20*f5.0_A:0xX00965c1c*f70.0_A:0xX00965c28*f30.0_A:0xX00965c2c*f10.0_A:0xX00965c8c*f12.0_B:0xX00965c88*f5.0_B:0xX00965c74*f5000.0_A:0xX00965c84*f70.0_A:0xX00965c90*f30.0_A:0xX00965c94*f10.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	A:0xX00953c28_A:0xX00953c90_K:0xX00953c5c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c44*f12.0_B:0xX00953c40*f5.0_A:0xX00953c3c*f70.0_A:0xX00953c48*f30.0_A:0xX00953c4c*f10.0_A:0xX00953cac*f12.0_B:0xX00953ca8*f5.0_B:0xX00953c94*f5000.0_A:0xX00953ca4*f70.0_A:0xX00953cb0*f30.0_A:0xX00953cb4*f10.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([MissionTime_Temp + MissionTime_ChapterSection + MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime

				+ [ShotsHit_Temp] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [ShotFired_Temp] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				+ [Kills_Temp] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [HeadshotKills_Temp] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [MeleeKills_Temp] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				+ [ShotsHit_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterSection] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups			*/
		measured(
			current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- current_ShotsFired_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				+ current_Kills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				+ current_ShotsHit_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- current_ShotsFired_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- current_PlayerDeaths_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ current_HeadshotKills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills
				
				// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]

				+ current_MissionTime_Temp(enum_releaseRegion)
				+ current_MissionTime_ChapterSection(enum_releaseRegion)
				+ current_MissionTime_ChapterTotal(enum_releaseRegion),
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion)
					+ current_MissionTime_ChapterSection(enum_releaseRegion)
					+ current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)
	function valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion) => // ValueMeasure[1,4,7,10/13,16,19,22]--> ValueMeasure during loading screens or FMVs; This ValueMeasure is submitted in Gunslinger Mode
		//NOTE: In GunslingerMode, ChapterStats saved during gameplay are NOT zeroed out when the Chapter finishes, thus this ValueMeasure is submitted in GunslingerMode
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterIntermission - (below Measured) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	K:0xX00965c3c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	K:0xX00953c5c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f30.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime

				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_MissionTime_ChapterTotal(enum_releaseRegion)

				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills
				
				// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_false(enum_releaseRegion)
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) > 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)
	
	function valueMeasure_ChapterCompleted_SinglePlayer(enum_chapter, enum_difficulty, enum_releaseRegion) => // ValueMeasure[2,5,8,11/14,17,20,23] --> ValueMeasure when the Chapter is finished in SinglePlayer; This ValueMeasure is submitted in SinglePlayer Mode
		//NOTE: In SinglePlayer or MultiplayerCoop, ChapterStats during gameplay are copied/saved to [Array:SavedStats], afterwards ChapterStats during gameplay is zeroed out when the Chapter finishes, thus this ValueMeasure uses [Array:SavedStats]
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterCompleted_SinglePlayer - (below Measured) R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	I:0xX00965cd8_I:0xX00000004_K:0xX00000008/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00965cd8_I:0xX00000004_A:0xX00000024*f12.0_I:0xX00965cd8_I:0xX00000004_B:0xX00000020*f5.0_I:0xX00965cd8_I:0xX00000004_B:0xX0000000c*f5000.0_I:0xX00965cd8_I:0xX00000004_A:0xX0000001c*f70.0_I:0xX00965cd8_I:0xX00000004_A:0xX00000028*f30.0_I:0xX00965cd8_I:0xX00000004_A:0xX0000002c*f20.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	I:0xX00953cf8_I:0xX00000004_K:0xX00000008/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00953cf8_I:0xX00000004_A:0xX00000024*f12.0_I:0xX00953cf8_I:0xX00000004_B:0xX00000020*f5.0_I:0xX00953cf8_I:0xX00000004_B:0xX0000000c*f5000.0_I:0xX00953cf8_I:0xX00000004_A:0xX0000001c*f70.0_I:0xX00953cf8_I:0xX00000004_A:0xX00000028*f30.0_I:0xX00953cf8_I:0xX00000004_A:0xX0000002c*f40.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([SavedStats_Story_MissionTime] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime

				+ [SavedStats_Story_ShotsHit] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [SavedStats_Story_ShotFired] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [SavedStats_Story_PlayerDeaths] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [SavedStats_Story_Kills] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [SavedStats_Story_HeadshotKills] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [SavedStats_Story_MeleeKills] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion)
				+ current_SavedStatStory_ShotsHit(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- current_SavedStatStory_ShotsFired(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- current_SavedStatStory_PlayerDeaths(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ current_SavedStatStory_Kills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ current_SavedStatStory_HeadshotKills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ current_SavedStatStory_MeleeKills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills
				
				// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_SavedStatStory_Difficulty(enum_chapter, enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_false(enum_releaseRegion)
				&& is_InSinglePlayerMode(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
				&& current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) > 0
				&& current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		for enum_difficulty in [DIFFICULTY_Greenhorn, DIFFICULTY_Cowboy, DIFFICULTY_Shootist, DIFFICULTY_Deadeye] {
			array_push(let_array_valueMeasures, valueMeasure_InGame(enum_difficulty, enum_releaseRegion)) // ValueMeasure[Value,3,6,9/12,15,18,21]
			array_push(let_array_valueMeasures, valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion)) // ValueMeasure[1,4,7,10/13,16,19,22]
			array_push(let_array_valueMeasures, valueMeasure_ChapterCompleted_SinglePlayer(enum_chapter, enum_difficulty, enum_releaseRegion)) // ValueMeasure[2,5,8,11/14,17,20,23]
			}
		}
	return max_of(let_array_valueMeasures)}

function lb_ValueMeasure_AllStatsScore_BossFight(enum_chapter) { // WARNING - (3x) MANUAL_CONSTRUCTION
	function valueMeasure_InGame(enum_difficulty, enum_releaseRegion) => // ValueMeasure[Value,3,6,9/12,15,18,21] --> ValueMeasure during during gameplay; This ValueMeasure is never submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_InGame - (below Measured, without MeasuredIf) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	A:0xX00965c08_A:0xX00965c70_K:0xX00965c3c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c24*f12.0_B:0xX00965c20*f5.0_A:0xX00965c1c*f70.0_A:0xX00965c28*f30.0_A:0xX00965c2c*f10.0_A:0xX00965c8c*f12.0_B:0xX00965c88*f5.0_B:0xX00965c74*f5000.0_A:0xX00965c84*f70.0_A:0xX00965c90*f30.0_A:0xX00965c94*f10.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	A:0xX00953c28_A:0xX00953c90_K:0xX00953c5c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c44*f12.0_B:0xX00953c40*f5.0_A:0xX00953c3c*f70.0_A:0xX00953c48*f30.0_A:0xX00953c4c*f10.0_A:0xX00953cac*f12.0_B:0xX00953ca8*f5.0_B:0xX00953c94*f5000.0_A:0xX00953ca4*f70.0_A:0xX00953cb0*f30.0_A:0xX00953cb4*f10.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([MissionTime_Temp + MissionTime_ChapterSection + MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime

				+ [ShotsHit_Temp] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [ShotFired_Temp] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				+ [Kills_Temp] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [HeadshotKills_Temp] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [MeleeKills_Temp] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				+ [ShotsHit_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterSection] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups			*/
		measured(
			current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			+ current_Kills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
					
			+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills
			
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]

			+ current_MissionTime_Temp(enum_releaseRegion)
			+ current_MissionTime_ChapterSection(enum_releaseRegion)
			+ current_MissionTime_ChapterTotal(enum_releaseRegion),
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion)
					+ current_MissionTime_ChapterSection(enum_releaseRegion)
					+ current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)
	function valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion) => // ValueMeasure[1,4,7,10/13,16,19,22]--> ValueMeasure during loading screens or FMVs; This ValueMeasure is submitted in Gunslinger Mode
		//NOTE: In GunslingerMode, ChapterStats saved during gameplay are NOT zeroed out when the Chapter finishes, thus this ValueMeasure is submitted in GunslingerMode
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterIntermission - (below Measured) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	K:0xX00965c3c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	K:0xX00953c5c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f30.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime

				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_MissionTime_ChapterTotal(enum_releaseRegion)

			+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills
			
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_false(enum_releaseRegion)
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) > 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)
	
	function valueMeasure_ChapterCompleted_SinglePlayer(enum_chapter, enum_difficulty, enum_releaseRegion) => // ValueMeasure[2,5,8,11/14,17,20,23] --> ValueMeasure when the Chapter is finished in SinglePlayer; This ValueMeasure is submitted in SinglePlayer Mode
		//NOTE: In SinglePlayer or MultiplayerCoop, ChapterStats during gameplay are copied/saved to [Array:SavedStats], afterwards ChapterStats during gameplay is zeroed out when the Chapter finishes, thus this ValueMeasure uses [Array:SavedStats]
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterCompleted_SinglePlayer - (below Measured) R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	I:0xX00965cd8_I:0xX00000004_K:0xX00000008/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00965cd8_I:0xX00000004_A:0xX00000024*f12.0_I:0xX00965cd8_I:0xX00000004_B:0xX00000020*f5.0_I:0xX00965cd8_I:0xX00000004_B:0xX0000000c*f5000.0_I:0xX00965cd8_I:0xX00000004_A:0xX0000001c*f70.0_I:0xX00965cd8_I:0xX00000004_A:0xX00000028*f30.0_I:0xX00965cd8_I:0xX00000004_A:0xX0000002c*f20.0_K:{recall}_K:{recall}*4_M:{recall}
			NTSCU:	I:0xX00953cf8_I:0xX00000004_K:0xX00000008/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00953cf8_I:0xX00000004_A:0xX00000024*f12.0_I:0xX00953cf8_I:0xX00000004_B:0xX00000020*f5.0_I:0xX00953cf8_I:0xX00000004_B:0xX0000000c*f5000.0_I:0xX00953cf8_I:0xX00000004_A:0xX0000001c*f70.0_I:0xX00953cf8_I:0xX00000004_A:0xX00000028*f30.0_I:0xX00953cf8_I:0xX00000004_A:0xX0000002c*f40.0_K:{recall}_K:{recall}*4_M:{recall}
			--------
				(1 - ([SavedStats_Story_MissionTime] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime

				+ [SavedStats_Story_ShotsHit] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [SavedStats_Story_ShotFired] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [SavedStats_Story_PlayerDeaths] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [SavedStats_Story_Kills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [SavedStats_Story_HeadshotKills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [SavedStats_Story_MeleeKills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion)

			+ current_SavedStatStory_ShotsHit(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_SavedStatStory_ShotsFired(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_SavedStatStory_PlayerDeaths(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_SavedStatStory_Kills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_SavedStatStory_HeadshotKills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_SavedStatStory_MeleeKills(enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_SavedStatStory_Difficulty(enum_chapter, enum_releaseRegion) == enum_difficulty
				&& is_flagState_InGame_false(enum_releaseRegion)
				&& is_InSinglePlayerMode(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
				&& current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) > 0
				&& current_SavedStatStory_MissionTime(enum_chapter, enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		for enum_difficulty in [DIFFICULTY_Greenhorn, DIFFICULTY_Cowboy, DIFFICULTY_Shootist, DIFFICULTY_Deadeye] {
			array_push(let_array_valueMeasures, valueMeasure_InGame(enum_difficulty, enum_releaseRegion)) // ValueMeasure[Value,3,6,9/12,15,18,21]
			array_push(let_array_valueMeasures, valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion)) // ValueMeasure[1,4,7,10/13,16,19,22]
			array_push(let_array_valueMeasures, valueMeasure_ChapterCompleted_SinglePlayer(enum_chapter, enum_difficulty, enum_releaseRegion)) // ValueMeasure[2,5,8,11/14,17,20,23]
			}
		}
	return max_of(let_array_valueMeasures)}

function lb_ValueMeasure_TotalStoryTime_instantSubmit() {
	function valueMeasure(enum_releaseRegion) =>
		measured(
			current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) /10, // Divide by 10: milliseconds to centiseconds
			when = is_ReleaseRegion(enum_releaseRegion)
			) 

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}

function lb_ValueMeasure_TotalStoryTime_withInGameTimer() {
	function valueMeasure_InGame(enum_releaseRegion) =>
		measured(
			current_calculated_TotalStoryTime_whileInGame(enum_releaseRegion) /10, // Divide by 10: milliseconds to centiseconds
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
			)
	function valueMeasure_NotInGame(enum_releaseRegion) =>
		measured(
			current_calculated_SavedStats_TotalStoryMissionTime(enum_releaseRegion) /10, // Divide by 10: milliseconds to centiseconds
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion)
			)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		array_push(let_array_valueMeasures, valueMeasure_InGame(enum_releaseRegion))
		array_push(let_array_valueMeasures, valueMeasure_NotInGame(enum_releaseRegion))
	}
	return max_of(let_array_valueMeasures)}

leaderboards_valueMeasures = {
	// "lb_template": lb_ValueMeasure_Template(),
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": lb_ValueMeasure_AllStatsScore(CHAPTER_1_WrongTrain),
	"lb_WatchersRideDevil": lb_ValueMeasure_AllStatsScore(CHAPTER_2_RideDevil),
	"lb_WatchersBoneyard": lb_ValueMeasure_AllStatsScore(CHAPTER_3_Boneyard),
	"lb_WatchersDevilMine": lb_ValueMeasure_AllStatsScore(CHAPTER_4_DevilMine),
	"lb_WatchersDWOutpost": lb_ValueMeasure_AllStatsScore(CHAPTER_5_Outpost),
	"lb_WatchersWarTrain": lb_ValueMeasure_AllStatsScore(CHAPTER_6_WarTrain),
	"lb_WatchersTortureMaze": lb_ValueMeasure_AllStatsScore(CHAPTER_7_TortureMaze),
	"lb_WatchersBaptismFire": lb_ValueMeasure_AllStatsScore(CHAPTER_8_BaptismFire),
	"lb_WatchersRescue": lb_ValueMeasure_AllStatsScore(CHAPTER_9_Rescue),
	"lb_WatchersPrism": lb_ValueMeasure_AllStatsScore(CHAPTER_10_Prism),
	"lb_WatchersInvasion": lb_ValueMeasure_AllStatsScore(CHAPTER_11_Invasion),
	"lb_WatchersHangtown": lb_ValueMeasure_AllStatsScore(CHAPTER_12_Hangtown),
	"lb_WatchersMorningAfter": lb_ValueMeasure_AllStatsScore(CHAPTER_13_MorningAfter),
	"lb_WatchersShowdown": lb_ValueMeasure_AllStatsScore(CHAPTER_14_Showdown),
	"lb_WatchersRightTrain": lb_ValueMeasure_AllStatsScore(CHAPTER_15_RightTrain),
	"lb_WatchersDeadfall": lb_ValueMeasure_AllStatsScore(CHAPTER_16_Deadfall),
	"lb_WatchersCurseWest": lb_ValueMeasure_AllStatsScore_BossFight(CHAPTER_17_CurseWest),
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": lb_ValueMeasure_TotalStoryTime_instantSubmit(),
	"lb_StoryTimeSoftCowboy": lb_ValueMeasure_TotalStoryTime_instantSubmit(),
	"lb_StoryTimeSoftShootist": lb_ValueMeasure_TotalStoryTime_instantSubmit(),
	"lb_StoryTimeSoftDeadeye": lb_ValueMeasure_TotalStoryTime_instantSubmit(),
	"lb_StoryTimeHardGreenhorn": lb_ValueMeasure_TotalStoryTime_withInGameTimer(),
	"lb_StoryTimeHardCowboy": lb_ValueMeasure_TotalStoryTime_withInGameTimer(),
	"lb_StoryTimeHardShootist": lb_ValueMeasure_TotalStoryTime_withInGameTimer(),
	"lb_StoryTimeHardDeadeye": lb_ValueMeasure_TotalStoryTime_withInGameTimer(),
	}
// #endregion LB - triggers

// ====================
// • LEADERBOARD text •
// ====================
// #region LB - text
leaderboards_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": 			{"en": "The Wrong Train — Elite Regulators Watchlist"},
	"lb_WatchersRideDevil": 			{"en": "Ride Like the Devil — Elite Regulators Watchlist"},
	"lb_WatchersBoneyard": 				{"en": "Boneyard — Elite Regulators Watchlist"},
	"lb_WatchersDevilMine": 			{"en": "Devil's Belly Mine — Elite Regulators Watchlist"},
	"lb_WatchersDWOutpost": 			{"en": "Darkwatch Outpost — Elite Regulators Watchlist"},
	"lb_WatchersWarTrain": 				{"en": "War Train — Elite Regulators Watchlist"},
	"lb_WatchersTortureMaze": 			{"en": "Torture Maze — Elite Regulators Watchlist"},
	"lb_WatchersBaptismFire": 			{"en": "Baptism of Fire — Elite Regulators Watchlist"},
	"lb_WatchersRescue": 				{"en": "Rescue — Elite Regulators Watchlist"},
	"lb_WatchersPrism": 				{"en": "The Deadlight Prism — Elite Regulators Watchlist"},
	"lb_WatchersInvasion": 				{"en": "Invasion — Elite Regulators Watchlist"},
	"lb_WatchersHangtown": 				{"en": "Hangtown — Elite Regulators Watchlist"},
	"lb_WatchersMorningAfter": 			{"en": "The Morning After — Elite Regulators Watchlist"},
	"lb_WatchersShowdown": 				{"en": "Showdown — Elite Regulators Watchlist"},
	"lb_WatchersRightTrain": 			{"en": "The Right Train — Elite Regulators Watchlist"},
	"lb_WatchersDeadfall": 				{"en": "Deadfall — Elite Regulators Watchlist"},
	"lb_WatchersCurseWest": 			{"en": "Curse of the West — The Undying List"},
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": 	{"en": "Darkwatch Dispatches — Greenhorn Logs"},
	"lb_StoryTimeSoftCowboy": 		{"en": "Darkwatch Dispatches — Cowboy Logs"},
	"lb_StoryTimeSoftShootist": 	{"en": "Darkwatch Dispatches — Shootist Logs"},
	"lb_StoryTimeSoftDeadeye": 		{"en": "Darkwatch Dispatches — Deadeye Logs"},
	"lb_StoryTimeHardGreenhorn": 	{"en": "Hardcore Vanguards — Greenhorn Records"},
	"lb_StoryTimeHardCowboy": 		{"en": "Hardcore Vanguards — Cowboy Records"},
	"lb_StoryTimeHardShootist": 	{"en": "Hardcore Vanguards — Shootist Records"},
	"lb_StoryTimeHardDeadeye": 		{"en": "Hardcore Vanguards — Deadeye Records"},
	// ------lb_Challenges------
	}
leaderboards_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": 			{"en": "The Reaper was on board, but you weren't on his list. Make sure your name lands on this one instead—finish Chapter 1, \"The Wrong Train\", with precision and speed"},
	"lb_WatchersRideDevil": 			{"en": "The Reaper's close, and the devil's got the reins. Only the fastest and deadliest make this list. Dominate Chapter 2, \"Ride Like the Devil\", with sheer speed and precision to earn your spot"},
	"lb_WatchersBoneyard": 				{"en": "The dead don't take kindly to visitors. If you're still standing when the dust settles, you've earned your place among the best. Survive Chapter 3, \"Boneyard\", with ruthless efficiency to make the list"},
	"lb_WatchersDevilMine": 			{"en": "Plenty have gone into these tunnels—few ever come out. Only the sharpest shots and the quickest hands make it out in one piece. Carve your name in stone by dominating Chapter 4, \"Devil's Belly\" Mine"},
	"lb_WatchersDWOutpost": 			{"en": "Sanctuary is a thing of the past—now it's just you, the undead, and your gun. If you can hold the line with speed and precision, you'll earn your name on this list. Prove it in Chapter 5, \"Darkwatch Outpost\""},
	"lb_WatchersWarTrain": 				{"en": "The steel rails run straight through hell, and you're riding shotgun. Survive the slaughter and show them who runs this train. The best gunslingers earn their place by ruling Chapter 6, \"War Train\""},
	"lb_WatchersTortureMaze": 			{"en": "This ain't a test of strength—it's a test of survival. If you made it through and still had the guts to fight, you just might belong on this list. Show 'em how it's done in Chapter 7, \"Torture Maze\""},
	"lb_WatchersBaptismFire": 			{"en": "Blood, fire, and gunpowder—your introduction to the Darkwatch is anything but gentle. If you fought your way through and left nothing but wreckage, this list might just have your name on it. Conquer Chapter 8, \"Baptism of Fire\""},
	"lb_WatchersRescue": 				{"en": "The dead don't rest, but neither do you. If you took down everything in your way and made sure no one was left behind, then you've earned your place. Only the strongest warriors top Chapter 9, \"Rescue\""},
	"lb_WatchersPrism": 				{"en": "Power corrupts, but you? You ain't backing down. If you fought through the chaos and took control of this nightmare, you've got a shot at the Watchlist. Prove your mettle in Chapter 10, \"The Deadlight Prism\""},
	"lb_WatchersInvasion": 				{"en": "This land ain't theirs to take, and you made damn sure they knew it. If you sent the dead back where they belong with ruthless efficiency, your name deserves a place on this list. Dominate Chapter 11, \"Invasion\""},
	"lb_WatchersHangtown": 				{"en": "The gallows still swing, but the dead ain't hanging. You cut them down—again. If your aim was true and your hands steady, you earned your place among the best. Prove it in Chapter 12, \"Hangtown\""},
	"lb_WatchersMorningAfter": 			{"en": "Centuries of vigilance burned in a single night. But you? You didn't burn with it. If you fought through the wreckage and left nothing but bodies in your wake, you've earned your place. Survive Chapter 13, \"The Morning After\""},
	"lb_WatchersShowdown": 				{"en": "Darkwatch is rubble, but the fight ain't over. If you had the guts to stare into the abyss and fire the last shot, this list might just bear your name. End it for good in Chapter 14, \"Showdown\""},
	"lb_WatchersRightTrain": 			{"en": "This train ain't bound for anywhere holy—just straight into the jaws of damnation. If you tore through the horrors on board and sent them screaming into the void, you belong on this list. Dominate Chapter 15, \"The Right Train\""},
	"lb_WatchersDeadfall": 				{"en": "The city's crumbling, the sky's burning, and you're knee-deep in hell. If you walked through the fire and left nothing standing in your way, you've got a spot among the best. Prove your worth in Chapter 16, \"Deadfall\""},
	"lb_WatchersCurseWest": 			{"en": "The night is over, or the nightmare is just beginning. Whether you brought salvation or destruction, the West won't forget your name. Only the most ruthless or righteous make the list. Shape your fate in Chapter 17, \"Curse of the West\""},
	// ------lb_StoryTime------
	"lb_StoryTimeSoftGreenhorn": 	{"en": "You took the oath, drew your gun, and cleared the West—whether for justice or damnation. Only those who finish what they started will have their names engraved into the Dispatches, tracking total Story completion time on Greenhorn difficulty"},
	"lb_StoryTimeSoftCowboy": 		{"en": "You took the oath, drew your gun, and cleared the West—whether for justice or damnation. Only those who finish what they started will have their names engraved into the Dispatches, tracking total Story completion time on Cowboy difficulty"},
	"lb_StoryTimeSoftShootist": 	{"en": "You took the oath, drew your gun, and cleared the West—whether for justice or damnation. Only those who finish what they started will have their names engraved into the Dispatches, tracking total Story completion time on Shootist difficulty"},
	"lb_StoryTimeSoftDeadeye": 		{"en": "You took the oath, drew your gun, and cleared the West—whether for justice or damnation. Only those who finish what they started will have their names engraved into the Dispatches, tracking total Story completion time on Deadeye difficulty"},
	"lb_StoryTimeHardGreenhorn": 	{"en": "Speed is salvation—or damnation. Beat the story on Greenhorn from start to finish in one sitting and they'll stamp your name among the quickest. An optional timer overlay is available by holding \"Select\" whilst choosing the difficulty"},
	"lb_StoryTimeHardCowboy": 		{"en": "Speed is salvation—or damnation. Beat the story on Cowboy from start to finish in one sitting and they'll stamp your name among the quickest. An optional timer overlay is available by holding \"Select\" whilst choosing the difficulty"},
	"lb_StoryTimeHardShootist": 	{"en": "Speed is salvation—or damnation. Beat the story on Shootist from start to finish in one sitting and they'll stamp your name among the quickest. An optional timer overlay is available by holding \"Select\" whilst choosing the difficulty"},
	"lb_StoryTimeHardDeadeye": 		{"en": "Speed is salvation—or damnation. Beat the story on Deadeye from start to finish in one sitting and they'll stamp your name among the quickest. An optional timer overlay is available by holding \"Select\" whilst choosing the difficulty"},
		// ------lb_Challenges------
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