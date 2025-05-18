// **************************************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 						\\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	MULTIPLAYER COOPERATIVE \\
// **************************************************************** \\
// #ID = 24401
// md5: 8E6C817041ADC5B20F3011CD0F945F9D (PAL) - 9CE6383CB5260E300CACDE569EA5916D (NTSC-U)
// RA Hash: https://retroachievements.org/game/24401/hashes
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/24401
// RATools version: v1.15.1

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
	"Pointer:PlayerInput": {
		"offsetToMember": {
			"Struct(ControllerInput):Controller-1": 0x4,
			"Struct(ControllerInput):Controller-2": 0x38},
		},
	"Pointer:UIcontrol": {
		"pointerChainToMember": {
			"Lower4:ActiveMenuPointerIndex": {
				"pointerChainOffsets": [0x8]},
			"Array:UIcontrolPointers": {
				"pointerChainOffsets": [0xC]},
			"Pointer:UIcontrol_ptr-L2_A": {
				"pointerChainOffsets": [0xC, 0x0]},
			"Pointer:UIcontrol_ptr-L2_B": {
				"pointerChainOffsets": [0xC, 0x4]},
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
			"Pointer:EquippedWeaponName-Player1": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xFC]},	
			"32-bit:EquippedWeapon_LoadedBullets(display)-Player1": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xF0]},	
			"32-bit:ThrowableCountInInventory(display)-Player1": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0xF8]},	
			"ASCII:Equipped_ThrowableNameID-Player1": {
				"pointerChainOffsets": [0xC, 0x0, 0x70, 0x100],
				"offsetToPointedToMember": 0x2},
			// ------[Pointer:UIcontrol_ptr-L2_B].[Struct:HUDcontrol_Gear-Player2]------
			"Pointer:EquippedWeaponName-Player2": {
				"pointerChainOffsets": [0xC, 0x4, 0x70, 0xFC]},	
			"32-bit:EquippedWeapon_LoadedBullets(display)-Player2": {
				"pointerChainOffsets": [0xC, 0x4, 0x70, 0xF0]},	
			"32-bit:ThrowableCountInInventory(display)-Player2": {
				"pointerChainOffsets": [0xC, 0x4, 0x70, 0xF8]},	
			"ASCII:Equipped_ThrowableNameID-Player2": {
				"pointerChainOffsets": [0xC, 0x4, 0x70, 0x100],
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
	"Pointer:SofdecStreamData": {
		"pointerChainToMember": {
			"ASCIIFlag:Sofdec_IsFMVactive": {
				"offsetToPointedToMember": 0x12C},
			"ASCII:Sofdec_FMVID": {
				"offsetToPointedToMember": 0x14C},
			},
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
	"Struct:MainUIdata": {
		"pointerChainToMember": {
			"32-bit:LoadingState": {
				"pointerChainOffsets": {
					RELEASE_REGION_USA: [0x510],
					RELEASE_REGION_EUR: [0x450]}},
			},
		},
	"Struct:ControllerInput": {
		"offsetToMember": {
			"BitFlag:IsControllerConnected": 0x0,
			"BitFlag:IsInputPressed_Select": 0x2,
			"BitFlag:IsInputPressed_Start": 0x3,
			"BitFlag:IsInputPressed_Dpad_Left": 0x4,
			"BitFlag:IsInputPressed_Dpad_Right": 0x5,
			"BitFlag:IsInputPressed_Dpad_Up": 0x6,
			"BitFlag:IsInputPressed_Dpad_Down": 0x7,
			"BitFlag:IsInputPressed_Square": 0x8,
			"BitFlag:IsInputPressed_Circle": 0x9,
			"BitFlag:IsInputPressed_Triangle": 0xA,
			"BitFlag:IsInputPressed_Cross": 0xB,
			"BitFlag:IsInputPressed_L3": 0xC,
			"BitFlag:IsInputPressed_R3": 0xD,
			"BitFlag:IsInputPressed_L1": 0xE,
			"BitFlag:IsInputPressed_R1": 0xF,
			"BitFlag:IsInputPressed_L2": 0x10,
			"BitFlag:IsInputPressed_R2": 0x11,
			"Float:LeftAnalogStick_Yaw": 0x24,
			"Float:LeftAnalogStick_Pitch": 0x28,
			"Float:RightAnalogStick_Yaw": 0x2C,
			"Float:RightAnalogStick_Pitch": 0x30}
		},
	"Struct:PlayerEntityData": {
		"pointerChainToMember": {
			"Float:PlayerHealth(functional)": {
				"pointerChainOffsets": [0x58, 0x74, 0x98]},
			"Float:VampireShield(functional)": {
				"pointerChainOffsets": [0x58, 0x74, 0xA0]},
			"Float:BloodPowerGauge(functional)": {
				"pointerChainOffsets": [0x58, 0x74, 0xFC]},
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
	
	"BitFlag:IsCinematicActive": {RELEASE_REGION_USA: 0x72bbe8, RELEASE_REGION_EUR: 0x73dce8, RELEASE_REGION_JPN: sNULL},
	
	"BitFlag:IsStoryGoodEndingAchieved-Player1": {RELEASE_REGION_USA: 0x953D20, RELEASE_REGION_EUR: 0x965d00, RELEASE_REGION_JPN: sNULL},
	"BitFlag:IsStoryEvilEndingAchieved-Player1": {RELEASE_REGION_USA: 0x953D21, RELEASE_REGION_EUR: 0x965d01, RELEASE_REGION_JPN: sNULL},

	"BitFlag:IsStoryGoodEndingAchieved-Player2": {RELEASE_REGION_USA: 0x953E28, RELEASE_REGION_EUR: 0x965e08, RELEASE_REGION_JPN: sNULL},
	"BitFlag:IsStoryEvilEndingAchieved-Player2": {RELEASE_REGION_USA: 0x953E29, RELEASE_REGION_EUR: 0x965e09, RELEASE_REGION_JPN: sNULL},

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

	"Pointer:MainUIdata_A": {RELEASE_REGION_USA: 0x71faf0, RELEASE_REGION_EUR: 0x7213f0, RELEASE_REGION_JPN: sNULL},
	"Pointer:SofdecStreamData(preferred)": {RELEASE_REGION_USA: 0x134214, RELEASE_REGION_EUR: 0x134214, RELEASE_REGION_JPN: sNULL},
	"Pointer:LevelID(preferred)": {RELEASE_REGION_USA: 0x71ff20, RELEASE_REGION_EUR: 0x721820, RELEASE_REGION_JPN: sNULL},
	"Pointer:ControllerInput(preferred)": {RELEASE_REGION_USA: 0x720000, RELEASE_REGION_EUR: 0x721900, RELEASE_REGION_JPN: sNULL},
	"Pointer:UIcontrol(preferred)": {RELEASE_REGION_USA: 0x721fb8, RELEASE_REGION_EUR: 0x7238b8, RELEASE_REGION_JPN: sNULL},

	"Pointer:HUDcontrol_Health-Player1": {RELEASE_REGION_USA: 0x953d4c, RELEASE_REGION_EUR: 0x965d2c, RELEASE_REGION_JPN: sNULL},
	"Pointer(EntityData_B):PlayerActorData-Player1": {RELEASE_REGION_USA: 0x953ce4, RELEASE_REGION_EUR: 0x965cc4, RELEASE_REGION_JPN: sNULL},
	"Pointer:Controls_ControllerConfig-Player1": {RELEASE_REGION_USA: 0x953CCC, RELEASE_REGION_EUR: 0x965cac, RELEASE_REGION_JPN: sNULL},
	"Pointer:PlayerSavedStats-Player1": {RELEASE_REGION_USA: 0x953CF8, RELEASE_REGION_EUR: 0x965cd8, RELEASE_REGION_JPN: sNULL},

	"Pointer:HUDcontrol_Health-Player2": {RELEASE_REGION_USA: 0x953E78, RELEASE_REGION_EUR: 0x965e58, RELEASE_REGION_JPN: sNULL},
	"Pointer(EntityData_B):PlayerActorData-Player2": {RELEASE_REGION_USA: 0x953E10, RELEASE_REGION_EUR: 0x965df0, RELEASE_REGION_JPN: sNULL},
	"Pointer:Controls_ControllerConfig-Player2": {RELEASE_REGION_USA: 0x953DF8, RELEASE_REGION_EUR: 0x965dd8, RELEASE_REGION_JPN: sNULL},
	"Pointer:PlayerSavedStats-Player2": {RELEASE_REGION_USA: 0x953E24, RELEASE_REGION_EUR: 0x965E04, RELEASE_REGION_JPN: sNULL},
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

IPNUT_Start = "Start"
INPUT_Select = "Select"
INPUT_Dpad_Left = "Dpad_Left"
INPUT_Dpad_Right = "Dpad_Right"
INPUT_Dpad_Up = "Dpad_Up"
INPUT_Dpad_Down = "Dpad_Down"
INPUT_Square = "Square"
INPUT_Circle = "Circle"
INPUT_Triangle = "Triangle"
INPUT_Cross = "Cross"
INPUT_L1 = "L1"
INPUT_L2 = "L2"
INPUT_L3 = "L3"
INPUT_R1 = "R1"
INPUT_R2 = "R2"
INPUT_R3 = "R3"

CONST_GAMEPLAY_INPUTS = [
	INPUT_Dpad_Left, INPUT_Dpad_Right, INPUT_Dpad_Up, INPUT_Dpad_Down, 
	INPUT_Square, INPUT_Circle, INPUT_Triangle, INPUT_Cross,
	INPUT_L1, INPUT_L2, INPUT_L3, INPUT_R1, INPUT_R2, INPUT_R3]

function current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) {
	let_memberKey_Input = format("BitFlag:IsInputPressed_{0}", enum_input)
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return bit0(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", let_memberKey_Input)
	)}

function prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) =>
	prev(current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion))
	
function is_flagState_IsInputPressed_false(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) == 0
	
function is_flagState_IsInputPressed_true(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) == 1

function on_flagState_IsInputPressed_change(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) != prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion)

function on_PlayerInput_press(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) > prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion)

function on_PlayerInput_release(enum_controller, enum_input, enum_releaseRegion) =>
	current_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion) < prev_flagState_IsInputPressed(enum_controller, enum_input, enum_releaseRegion)

function current_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return float(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", "Float:LeftAnalogStick_Yaw")
	)}

function prev_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion) =>
	prev(current_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion))

function current_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return float(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", "Float:RightAnalogStick_Yaw")
	)}

function prev_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion) =>
	prev(current_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion))

function current_LeftAnalogStick_Pitch(enum_controller, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return float(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", "Float:LeftAnalogStick_Pitch")
	)}

function prev_LeftAnalogStick_Pitch(enum_controller, enum_releaseRegion) =>
	prev(current_LeftAnalogStick_Pitch(enum_controller, enum_releaseRegion))

function current_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:ControllerInput(preferred)", enum_releaseRegion)
	let_string_memberKey_ControllerInput = format("Struct(ControllerInput):Controller-{0}", enum_controller)
	let_offsetTo_Struct_PlayerInput = memory_getStruct_OffsetToMember("Pointer:PlayerInput", let_string_memberKey_ControllerInput)
	return float(
		dword(let_memAddr_BasePointer) 
		+ let_offsetTo_Struct_PlayerInput 
		+ memory_getStruct_OffsetToMember("Struct:ControllerInput", "Float:RightAnalogStick_Pitch")
	)}

function prev_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) =>
	prev(current_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion))

function on_LeftAnalogStick_use(enum_controller, enum_releaseRegion) =>
	current_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion)
	+ current_LeftAnalogStick_Pitch(enum_controller, enum_releaseRegion) 
	- prev_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion)
	- prev_LeftAnalogStick_Pitch(enum_controller, enum_releaseRegion) > 0

function on_RightAnalogStick_use(enum_controller, enum_releaseRegion) =>
	current_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion)
	+ current_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) 
	- prev_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion)
	- prev_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) > 0

function on_PlayerInput_anyGameplayInputUse(enum_controller, enum_releaseRegion) => // NOTE: Movement/Look and Select/Start excluded from check
	any_of(CONST_GAMEPLAY_INPUTS, enum_input => on_flagState_IsInputPressed_change(enum_controller, enum_input, enum_releaseRegion))

function on_PlayerInput_anyInputUse(enum_controller, enum_releaseRegion) => // NOTE: Movement/Look included in check; Select/Start excluded from check
	any_of(CONST_GAMEPLAY_INPUTS, enum_input => on_flagState_IsInputPressed_change(enum_controller, enum_input, enum_releaseRegion))
	|| current_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion) != prev_LeftAnalogStick_Yaw(enum_controller, enum_releaseRegion) // --4 Lines--> Alternative to bug below
	|| current_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) != prev_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion)
	|| current_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion) != prev_RightAnalogStick_Yaw(enum_controller, enum_releaseRegion)
	|| current_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion) != prev_RightAnalogStick_Pitch(enum_controller, enum_releaseRegion)
	// || on_LeftAnalogStick_use(enum_controller, enum_releaseRegion) // BUG_RATools v1.15.1 --> Infinite Processing Error (https://github.com/Jamiras/RATools/issues/561)
	// || on_RightAnalogStick_use(enum_controller, enum_releaseRegion)

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
MAINMENU_SUBMENU_MultiplayerCoopProfileSelectMenu  = "coop_pro" // FullString: "coop_profile"
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

function current_pointerState_PlayerActorData_ByPlayer(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer(EntityData_B):PlayerActorData-Player{0}", enum_player)
	let_memAddr_Pointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	return dword(let_memAddr_Pointer)}

function prior_pointerState_PlayerActorData_ByPlayer(enum_player, enum_releaseRegion) =>
	prior(current_pointerState_PlayerActorData_ByPlayer(enum_player, enum_releaseRegion))

function prev_pointerState_PlayerActorData_ByPlayer(enum_player, enum_releaseRegion) =>
	prev(current_pointerState_PlayerActorData_ByPlayer(enum_player, enum_releaseRegion))

function current_pointerState_PlayerActorData(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion)

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

function is_flagState_1P_InGame_true(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) != 0

function is_flagState_1P_InGame_false(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) == 0

function wasPrior_flagState_1P_InGame_true(enum_releaseRegion) =>
	prior_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) != 0

function on_flagState_1P_InGame_toggleTrue(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) != 0
	&& prev_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) == 0

function on_flagState_1P_InGame_toggleFalse(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) == 0
	&& prev_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) != 0

function is_flagState_2P_InGame_true(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) != 0

function is_flagState_2P_InGame_false(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) == 0

function wasPrior_flagState_2P_InGame_true(enum_releaseRegion) =>
	prior_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) != 0

function on_flagState_2P_InGame_toggleTrue(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) != 0
	&& prev_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) == 0

function on_flagState_2P_InGame_toggleFalse(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) == 0
	&& prev_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) != 0

function is_flagStates_BothPlayers_InGame_false(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) 
	+ current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) == 0

function is_flagStates_BothPlayers_InGame_true(enum_releaseRegion) =>
	current_pointerState_PlayerActorData_ByPlayer(PLAYER_1, enum_releaseRegion) != 0
	&& current_pointerState_PlayerActorData_ByPlayer(PLAYER_2, enum_releaseRegion) != 0

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
	/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


			=============CONTROLLER_1 Quits=============
			---------ResetNextIf_A--------- (-> ResetNextIf when ConfirmationMenu not displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 			| ResetNextIf: FrameTitle != "Restart"
			---------AddHit_A--------- (-> when any player presses X while at RestartConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 			| CheckIf: FrameTitle == "Restart"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A--------- (-> ResetNextIf when ConfirmationMenu not displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 			| ResetNextIf: FrameTitle != "Restart"
			---------AddHit_A--------- (-> when any player presses X while at RestartConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart 			| CheckIf: FrameTitle == "Restart"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()
			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]		| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


			==========================
			---------ResetNextIf_B---------
			ResetNextIf	[Pointer(EntityData_B):PlayerActorData-Player1] != 0x0 			| ResetNextIf: is_flagState_InGame_true(PLAYER_1)
			---------AddHit_B--------
			AndNext		Mem [Pointer(EntityData_B):PlayerActorData-Player1] == 0x0		
			AddHits		Delta [Pointer(EntityData_B):PlayerActorData-Player1] != 0x0	(1)		| CheckIf: on_flagState_InGame_toggleFalse(PLAYER_1)

			---------ResetNextIf_C---------
			ResetNextIf	[Pointer(EntityData_B):PlayerActorData-Player2] != 0x0 			| ResetNextIf: is_flagState_InGame_true(PLAYER_2)
			---------AddHit_C--------
			AndNext		Mem [Pointer(EntityData_B):PlayerActorData-Player2] == 0x0		
			AddHits		Delta [Pointer(EntityData_B):PlayerActorData-Player2] != 0x0	(1)		| CheckIf: on_flagState_InGame_toggleFalse(PLAYER_2)

			ResetIf		Val 0x0 == Val 0x1		(3)
			
						Val 0x0 == Val 0x1				| always_false() */
	memUtil_ManualConstruction_PlaceHolderRequirement(0xFD1)
	&& is_ReleaseRegion(enum_releaseRegion)
	&& is_AnyInGameMenu_active(enum_releaseRegion)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == TEXTLOOKUPKEY_RestartConfirmationMenu_FrameTitle_Restart
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)
	&& on_PlayerInput_press(CONTROLLER_2, INPUT_Cross, enum_releaseRegion)
	&& dword(memory_getAddress("Pointer(EntityData_B):PlayerActorData-Player1", enum_releaseRegion)) != 0
	&& dword(memory_getAddress("Pointer(EntityData_B):PlayerActorData-Player2", enum_releaseRegion)) != 0
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0xFD2)

function on_PauseMenu_Quit(enum_releaseRegion) =>
	/* MANUAL_CONSTRUCTION[FD1-FD3]:ResetOn_PauseMenu_Quit - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._I:0xX007238b8_Z:0xL00000008!=0_I:0xX007238b8_N:0xL00000008=0_I:0xX007238b8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._I:0xX00721fb8_Z:0xL00000008!=0_I:0xX00721fb8_N:0xL00000008=0_I:0xX00721fb8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


			=============CONTROLLER_1 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


			=============Effectively Quit (check)=============
			---------ResetNextIf_B--------- (-> when pressing Quit, [Lower4:ActiveMenuPointerIndex] becomes 0, the next frame)
			ResetNextIf	Mem [Lower4:ActiveMenuPointerIndex] != 0x0 			| ResetNextIf: [Lower4:ActiveMenuPointerIndex] != 0
			---------AddHit_B--------
			AndNext		Mem [Lower4:ActiveMenuPointerIndex] == 0x0		
			AddHits		Delta [Lower4:ActiveMenuPointerIndex] != 0x0	(1)		| CheckIf: [Lower4:ActiveMenuPointerIndex] turns 0

			ResetIf		Val 0x0 == Val 0x1		(2)		| CheckIf: (CONTROLLER_1 Quits OR CONTROLLER_2 Quits) AND CheckIf: Effectively Quit
			
						Val 0x0 == Val 0x1				| always_false() */
	memUtil_ManualConstruction_PlaceHolderRequirement(0xFD1)
	&& is_ReleaseRegion(enum_releaseRegion)
	&& is_AnyInGameMenu_active(enum_releaseRegion)
	&& dword(memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)) == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit
	&& on_PlayerInput_press(CONTROLLER_1, INPUT_Cross, enum_releaseRegion)
	&& on_PlayerInput_press(CONTROLLER_2, INPUT_Cross, enum_releaseRegion)
	&& memGenerate_pointerChainAccessor(
		"Pointer:UIcontrol", "Lower4:ActiveMenuPointerIndex", 
		memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion),
		memAccessorFunction_toPointedToMember = low4) == 0
	&& memUtil_ManualConstruction_PlaceHolderRequirement(0xFD3)

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
		"ChapterLength": "ChapterLength_Short",
		},
	CHAPTER_2_RideDevil: {
		"LevelID": "M02_CanyonShoot",
		"FullString_ChapterSectionIDs": ["Hub_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 1,
		"SavedStatIndex_SinglePlayerMode": 1,
		"ChapterLength": "ChapterLength_Short",
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
		"ChapterLength": "ChapterLength_Medium",
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
		"ChapterLength": "ChapterLength_Long",
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
		"ChapterLength": "ChapterLength_Short",
		},
	CHAPTER_6_WarTrain: {
		"LevelID": "Wartrain",
		"FullString_ChapterSectionIDs": ["M07_C"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 5,
		"SavedStatIndex_SinglePlayerMode": 5,
		"ChapterLength": "ChapterLength_Short",
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
		"ChapterLength": "ChapterLength_Long",
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
		"ChapterLength": "ChapterLength_Medium",
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
		"ChapterLength": "ChapterLength_Short",
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
		"ChapterLength": "ChapterLength_Medium",
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
		"ChapterLength": "ChapterLength_Medium",
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
		"ChapterLength": "ChapterLength_Short",
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
		"ChapterLength": "ChapterLength_Medium",
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
		"ChapterLength": "ChapterLength_Short",
		},
	CHAPTER_15_RightTrain: {
		"LevelID": "M19_RidetoDeadfall",
		"FullString_ChapterSectionIDs": ["M19_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 14,
		"SavedStatIndex_SinglePlayerMode": 15,
		"ChapterLength": "ChapterLength_Short",
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
		"ChapterLength": "ChapterLength_Long",
		},
	CHAPTER_17_CurseWest: {
		"LevelID": "GroundZero",
		"FullString_ChapterSectionIDs": ["GroundZero_A"],
		"IsGunslingerLevel": true,
		"SavedStatIndex_GunslingerMode": 16,
		"SavedStatIndex_SinglePlayerMode": 17,
		"ChapterLength": "ChapterLength_BossFight",
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

function LEVEl_DATA_getChapterLength(enum_chapter) =>
	CONST_LEVEL_DATA[enum_chapter]["ChapterLength"]

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

function is_LastChapterSection_active(enum_chapter, enum_releaseRegion) {
	let_lastChapterSection = LEVEL_DATA_getLastFullStringChapterSectionIndex(enum_chapter)
	return is_ChapterSection(enum_chapter, let_lastChapterSection, enum_releaseRegion)}

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

// ...............
// ◦ Player Data ◦
// '''''''''''''''
// #region Player Data
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

CONST_WEAPON_DATA = {
	WEAPON_Pistol: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Pistol",
		"isSmallArm": true,
		"isDarkwatchWeapon": false // --> Starting Pistol
		},
	WEAPON_Redeemer: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Redeemer",
		"isSmallArm": true,
		"isDarkwatchWeapon": true
		},
	WEAPON_DualPistols: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_DualPistols",
		"isSmallArm": true,
		"isDarkwatchWeapon": true
		},
	WEAPON_HorseRevolver: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_HorseRevolver",
		"isSmallArm": true,
		"isDarkwatchWeapon": true
		},
	WEAPON_Carbine: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Carbine",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	WEAPON_Shotgun: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Shotgun",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	WEAPON_RailRocket: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_RailRocket",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	WEAPON_Crossbow: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Crossbow",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	WEAPON_RangeRifle: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_RangeRifle",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	WEAPON_Scepter: {
		"memberKey_WeaponEquipTime": "32-bit:WeaponEquipTime_Scepter",
		"isSmallArm": false,
		"isDarkwatchWeapon": true
		},
	}

function WEAPON_DATA_getMemberKey_WeaponEquipTime(enum_weapon) =>
	CONST_WEAPON_DATA[enum_weapon]["memberKey_WeaponEquipTime"]

function WEAPON_DATA_IsDarkwatchWeapon(enum_weapon) =>
	CONST_WEAPON_DATA[enum_weapon]["isDarkwatchWeapon"]

function WEAPON_DATA_IsSmallArm(enum_weapon) =>
	CONST_WEAPON_DATA[enum_weapon]["isSmallArm"]

function WEAPON_DATA_getAllDarkwatchWeaponIDs() =>
	array_filter(CONST_WEAPON_DATA, enum_weapon => WEAPON_DATA_IsDarkwatchWeapon(enum_weapon))

function WEAPON_DATA_getAllWeaponIDs() =>
	array_map(CONST_WEAPON_DATA, enum_weapon => enum_weapon)

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
// ----------------SavedStats_Story (MultiplayerCoop)---------------------
function current_SavedStatStory_MissionTime(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStats = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MissionTime") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStats,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_Difficulty(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "Lower4:Difficulty") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_PlayerDeaths(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:PlayerDeaths") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_HeadshotKills(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:HeadshotKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_Kills(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:Kills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_MeleeKills(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:MeleeKills") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_ShotsFired(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

	let_offsetToMember_Pointer_SavedStat = memory_getStruct_OffsetToMember("Pointer:PlayerSavedStats", "Pointer:SavedStats_Story")
	let_savedStatIndex = LEVEL_DATA_getSavedStatIndex_Story(enum_chapter)
	let_offsetToIndexedMember_SavedStat = memory_getStruct_OffsetToMember("Struct:ChapterStats", "32-bit:ShotsFired") + (memory_getStruct_SizeInBytes("Struct:ChapterStats") * let_savedStatIndex)

	let_array_pointerChainOffsets = [
		let_offsetToMember_Pointer_SavedStat,
		let_offsetToIndexedMember_SavedStat
	]

	return memGenerate_pointerChainAccessor_fromOffsets(let_memAddr_BasePointer, let_array_pointerChainOffsets)}

function current_SavedStatStory_ShotsHit(enum_player, enum_chapter, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:PlayerSavedStats-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)

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
		current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion)) 

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

// ......................
// ◦ HUD Control Health ◦
// ''''''''''''''''''''''
// #region HUD Control Health

// ---------------BossHP-------------------- // NOTE: one Boss HP bar is displayed for each player, thus twice the same boss HP bar
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

function ASCII_MEM_ADDR_PowerIconTopLeft(enum_player, enum_releaseRegion) {
	let_memAddrKey = format("Pointer:HUDcontrol_Health-Player{0}", enum_player)
	let_memAddr_BasePointer = memory_getAddress(let_memAddrKey, enum_releaseRegion)
	let_memAddr_ASCII = 
		memGenerate_pointerChainAccessor("Pointer:HUDcontrol_Health", "ASCII:PowerIconTopLeft", let_memAddr_BasePointer)
		+ memory_getStruct_OffsetToPointedToMember("Pointer:HUDcontrol_Health", "ASCII:PowerIconTopLeft")
	return let_memAddr_ASCII}

function is_PowerIconTopLeft(enum_player, enum_power, enum_releaseRegion) =>
	dword(ASCII_MEM_ADDR_PowerIconTopLeft(enum_player, enum_releaseRegion)) == memUtil_asciiStringToHexLE(enum_power)

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

function current_ThrowableType(enum_player, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_pointerChainKey = format("ASCII:Equipped_ThrowableNameID-Player{0}", enum_player)
	let_offsetTo_ASCII = memory_getStruct_OffsetToPointedToMember("Pointer:UIcontrol", let_pointerChainKey)
	return memGenerate_pointerChainAccessor(
		"Pointer:UIcontrol", let_pointerChainKey, 
		let_memAddr_BasePointer, int_offsetToPointedToMember = let_offsetTo_ASCII,
		memAccessorFunction_toPointedToMember = dword)}

function prev_ThrowableType(enum_player, enum_releaseRegion) =>
	prev(current_ThrowableType(enum_player, enum_releaseRegion))

function on_ThrowableType_switch(enum_player, enum_releaseRegion) =>
	current_ThrowableType(enum_player, enum_releaseRegion) != prev_ThrowableType(enum_player, enum_releaseRegion)

function current_ThrowableCountInInventory(enum_player, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_pointerChainKey = format("32-bit:ThrowableCountInInventory(display)-Player{0}", enum_player)
	return memGenerate_pointerChainAccessor("Pointer:UIcontrol", let_pointerChainKey, let_memAddr_BasePointer)}

function prev_ThrowableCountInInventory(enum_player, enum_releaseRegion) =>
	prev(current_ThrowableCountInInventory(enum_player, enum_releaseRegion))

function on_Throwable_use(enum_player, enum_releaseRegion) =>
	current_ThrowableCountInInventory(enum_player, enum_releaseRegion) < prev_ThrowableCountInInventory(enum_player, enum_releaseRegion)

function on_HUDcontrolGear_weaponSwap(enum_player, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_pointerChainKey = format("Pointer:EquippedWeaponName-Player{0}", enum_player)
	let_memAccessor_SubPointer = memGenerate_pointerChainAccessor("Pointer:UIcontrol", let_pointerChainKey, let_memAddr_BasePointer)
	return let_memAccessor_SubPointer != prev(let_memAccessor_SubPointer)}

function current_HUDcontrolGear_LoadedBullets(enum_player, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress("Pointer:UIcontrol(preferred)", enum_releaseRegion)
	let_pointerChainKey = format("32-bit:EquippedWeapon_LoadedBullets(display)-Player{0}", enum_player)
	return memGenerate_pointerChainAccessor("Pointer:UIcontrol", let_pointerChainKey, let_memAddr_BasePointer)} 

function prev_HUDcontrolGear_LoadedBullets(enum_player, enum_releaseRegion) =>
	prev(current_HUDcontrolGear_LoadedBullets(enum_player, enum_releaseRegion))

function on_HUDcontrolGear_LoadedBullets_decrement(enum_player, enum_releaseRegion) =>
	current_HUDcontrolGear_LoadedBullets(enum_player, enum_releaseRegion) < prev_HUDcontrolGear_LoadedBullets(enum_player, enum_releaseRegion)


// #endregion HUD Control Gear

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
	"c_Misc": { // Category - Misc dummy achievements for player info
		// "a_INFOcoop": { // DISABLED - Active participation of both players is implied by it being a multi subset
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Info about Participation Tracking"},	
		},
	"c_Story": { // Category - Story Progression Achievements
		// "a_WrongTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 512750, "points": 0000000, "devInfo": "CHAPTER_1_WrongTrain Completion"}, 
		// "a_RideDevil": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 512749, "points": 0000000, "devInfo": "CHAPTER_2_RideDevil Completion"},
		// "a_Boneyard": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513469, "points": 0000000, "devInfo": "CHAPTER_3_Boneyard Completion"},
		// "a_DevilMine": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513470, "points": 0000000, "devInfo": "CHAPTER_4_DevilMine Completion"},
		// "a_DWOutpost": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513471, "points": 0000000, "devInfo": "CHAPTER_5_Outpost Completion"},
		// "a_WarTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513472, "points": 0000000, "devInfo": "CHAPTER_6_WarTrain Completion"}, 
		// "a_TortureMaze": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513473, "points": 0000000, "devInfo": "CHAPTER_7_TortureMaze Completion"}, 
		// "a_BaptismFire": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513474, "points": 0000000, "devInfo": "CHAPTER_8_BaptismFire Completion"}, 
		// "a_Rescue": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513475, "points": 0000000, "devInfo": "CHAPTER_9_Rescue Completion"},
		// "a_Prism": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513476, "points": 0000000, "devInfo": "CHAPTER_10_Prism Completion"},
		// "a_Invasion": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513477, "points": 0000000, "devInfo": "CHAPTER_11_Invasion Completion"},
		// "a_Hangtown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513478, "points": 0000000, "devInfo": "CHAPTER_12_Hangtown Completion"},
		// "a_MorningAfter": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513479, "points": 0000000, "devInfo": "CHAPTER_13_MorningAfter Completion"},
		// "a_Showdown": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513480, "points": 0000000, "devInfo": "CHAPTER_14_Showdown Completion"},
		// "a_RightTrain": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513481, "points": 0000000, "devInfo": "CHAPTER_15_RightTrain Completion"},
		// "a_Deadfall": { // VERIFIED // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513482, "points": 0000000, "devInfo": "CHAPTER_16_Deadfall Completion"},
		},
	"c_StoryEnd": { // Category - Story Win Condition Achievements
		// "a_CurseWestGood": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513484, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Good ending"},		
		// "a_CurseWestEvil": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513483, "points": 0000000, "devInfo": "CHAPTER_17_CurseWest Completion, Evil ending"},
		},
	"c_Challenge": { // Category - info_here
		// "a_ClgWrongTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513820, "points": 0000000, "devInfo": "Complete CHAPTER_1_WrongTrain on Deadeye difficulty with no deaths and a minimum combined accuracy of xx%"}, 
		// "a_ClgRideDevil": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513876, "points": 0000000, "devInfo": "Complete CHAPTER_2_RideDevil on Deadeye difficulty with no deaths and the combined HP never goes below xx%"},
		// "a_ClgBoneyard": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 513877, "points": 0000000, "devInfo": "Complete CHAPTER_3_Boneyard on Deadeye difficulty with no deaths, no throwables, using only the Crossbow and Carbine to score at least xx kills total (without restart)"},
		// "a_ClgDevilMine": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515977, "points": 0000000, "devInfo": "Complete CHAPTER_4_DevilMine on Deadeye difficulty with no deaths and no powers, where one player only uses pistols and the other only two-handed weapons (no explosives)"},
		// "a_ClgDWOutpost": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515978, "points": 0000000, "devInfo": "Complete CHAPTER_5_Outpost on Deadeye difficulty with no deaths and the combined HP never being below max HP for xx seconds consecutively"},
		// "a_ClgWarTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515981, "points": 0000000, "devInfo": "Complete CHAPTER_6_WarTrain on Deadeye difficulty with no deaths, within xx time and without any player losing any HP"}, 
		// "a_ClgTortureMaze": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515982, "points": 0000000, "devInfo": "Complete CHAPTER_7_TortureMaze on Deadeye difficulty with no deaths, with at least xx% melee kills, where one player only uses the Scepter and the other only shoots (powers allowed)"}, 
		// "a_ClgBaptismFire": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515980, "points": 0000000, "devInfo": "Complete CHAPTER_8_BaptismFire on Deadeye difficulty with no deaths, no throwables, using only the Redeemer and the Rail Rocket to score at least xx kills total (without restart)"}, 
		// "a_ClgRescue": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515985, "points": 0000000, "devInfo": "Complete CHAPTER_9_Rescue on Deadeye difficulty with within xx time and without any player going below xx% HP"},
		// "a_ClgPrism": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515975, "points": 0000000, "devInfo": "Complete CHAPTER_10_Prism on Deadeye difficulty with no deaths, where each player can only use each power once"},
		// "a_ClgInvasion": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515976, "points": 0000000, "devInfo": "Complete CHAPTER_11_Invasion on Deadeye difficulty with no deaths using only the Dual Pistols or Shotgun (no explosives)"},
		// "a_ClgHangtown": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515987, "points": 0000000, "devInfo": "Complete CHAPTER_12_Hangtown on Deadeye difficulty with no deaths using the Range Rifle as the only means of shooting, with a minimum combined accuracy of xx%"},
		// "a_ClgMorningAfter": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515986, "points": 0000000, "devInfo": "Complete CHAPTER_13_MorningAfter on Deadeye difficulty with no deaths using only tier 2 and 3 powers, with at least xx% headshot or melee kills"},
		// "a_ClgShowdown": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515983, "points": 0000000, "devInfo": "Complete CHAPTER_14_Showdown on Deadeye difficulty with no deaths, with a minimum combined accuracy of xx% and where each player can only use 1 distinct power"},
		// "a_ClgRightTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515984, "points": 0000000, "devInfo": "Complete CHAPTER_15_RightTrain on Deadeye difficulty with no deaths within xx time and without any player going below xx% HP"},
		// "a_ClgDeadfall": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515988, "points": 0000000, "devInfo": "Complete CHAPTER_16_Deadfall on Deadeye difficulty with no deaths, killing only with the Range Rifle and Carbine equipped and with at least xx% headshot kills (throwables allowed)"},
		// "a_ClgCurseWest": { // QA // DISABLED - MANUAL_CONSTRUCTION
			// "id": 515979, "points": 0000000, "devInfo": "Complete CHAPTER_17_CurseWest on Deadeye difficulty with no deaths, with less than xx power activations"},
		},
	"c_Bonus": { // Category - Bonus achievements
		// TODO c_Bonus
		// "a_MultiKillers": { // CONCEPT a_MultiKillers
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Complete a Chapter, where each player scored at least one multikill"}
		// "a_SunHi": { // CONCEPT a_SunHi
			// "id": 000000, "points": achievement_POINTS_0, "devInfo": "Both player use powers in sunlight"}
		"a_AllEvil": { // VERIFIED
			"id": 521088, "points": achievement_POINTS_0, "devInfo": "Unlock all Evil powers"},
		"a_AllGood": { // VERIFIED
			"id": 521089, "points": achievement_POINTS_0, "devInfo": "Unlock all Good powers"},
		},
	"c_Versus": { // Category - Versus Mode achievements (purely for showcasing Versus Mode, this is not focus of this Subset)
		// TODO c_Versus
		// "a_VSdeathmatch": { // CONCEPT a_VSdeathmatch
			// "id": 000000, "points": 0000000, "devInfo": "Complete a Versus match in Deathmatch Mode"},
		// "a_VSsoulhunter": { // CONCEPT a_VSsoulhunter
			// "id": 000000, "points": 0000000, "devInfo": "Complete a Versus match in Soulhunter Mode"},
		},
	}
// ----------------ENUM:achievement_TYPE---------------------
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
	
	"c_Misc":		achievement_TYPE_Standard,
	"c_Story": 		achievement_TYPE_Standard, // achievement_TYPE_Progression // NOTE: Subsets only allow achievement_TYPE_Standard
	"c_StoryEnd": 	achievement_TYPE_Standard, // achievement_TYPE_WinCondition
	"c_Challenge": 	achievement_TYPE_Standard,
	"c_Bonus": 		achievement_TYPE_Standard}

// #region Global Achievement Settings
/* NOTE: Participation Tracking:
	Chapter has to be completed from start to finish, where each player:
	- must never be inactive for 30 seconds consecutively					(all inputs, but Select/Start are checked)
	- must have executed at least 30-100 "GameplayInputs" 					(all inputs, but analogSticks and Select/Start are checked)
	- must have at least 5-10% of the kills
	- must have at least fired 10-50 shots
	- must have at least 5-10% accuracy
	(The exact amount of each requirement is based on length of the Chapter)

	*/ 
CONST_PARTICIPATION_TRACKING_DATA = {
	"Max_Inactive_Seconds": 30, // Player must not be inactive for xx seconds consecutively (only counted while no cinematic is active and PauseMenu not also active)
	"Min_Required_Inputs": { // Each player must execute xx "GameplayInputs" while in-game ("GameplayInput": firing gun, using powers...; NOT: select, start, movement) 
		"ChapterLength_Short": 24,
		"ChapterLength_Medium": 36,
		"ChapterLength_Long": 52,
		"ChapterLength_BossFight": 38,
		},
	"Min_Required_ShotsHit": { // Each player must have at least hit xx shots
		"ChapterLength_Short": 12,
		"ChapterLength_Medium": 24,
		"ChapterLength_Long": 36,
		"ChapterLength_BossFight": 18,
		},
	"Min_Required_Accuracy_Percent": { // Each player must have at least xx% accuracy
		"ChapterLength_Short": 0.05,
		"ChapterLength_Medium": 0.07,
		"ChapterLength_Long": 0.08,
		"ChapterLength_BossFight": 0.06,
		},
	"Min_Required_Kills_Percent": { // Each player must contribute at least xx% of the total kills, no one player can account for more than xx% of the kills, unless Boss Fight
		"ChapterLength_Short": 0.05,
		"ChapterLength_Medium": 0.07,
		"ChapterLength_Long": 0.08, 
		"ChapterLength_BossFight": sNULL, // --> CHAPTER_17_CurseWest has only 1 enemy, so don't track this
		},
	}

function PARTICIPATION_TRACKING_DATA_getMaxInactiveSeconds(enum_chapter) =>
	CONST_PARTICIPATION_TRACKING_DATA["Max_Inactive_Seconds"]

function PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(enum_chapter) =>
	CONST_PARTICIPATION_TRACKING_DATA["Min_Required_Inputs"][LEVEl_DATA_getChapterLength(enum_chapter)]

function PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(enum_chapter) =>
	CONST_PARTICIPATION_TRACKING_DATA["Min_Required_Kills_Percent"][LEVEl_DATA_getChapterLength(enum_chapter)]

function PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(enum_chapter) =>
	CONST_PARTICIPATION_TRACKING_DATA["Min_Required_ShotsHit"][LEVEl_DATA_getChapterLength(enum_chapter)]

function PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(enum_chapter) =>
	CONST_PARTICIPATION_TRACKING_DATA["Min_Required_Accuracy_Percent"][LEVEl_DATA_getChapterLength(enum_chapter)]
// #endregion Participation Tracking
// #endregion ACH - core data

// ==================================
// • ACHIEVEMENT trigger generators •
// ==================================
// #region ACH - trigger generators
//	- For achievement logic that's reoccuring across multiple triggers

function achGenerate_LockoutGroup_ParticipationTrackingInactivity(enum_chapter, enum_releaseRegion) {
	PARTICIPATION_TRACKING_MaxInactiveSeconds = PARTICIPATION_TRACKING_DATA_getMaxInactiveSeconds(enum_chapter)
	return 
	// [1] ==== Alt Lockout Group ==== 			-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& never(repeated(PARTICIPATION_TRACKING_MaxInactiveSeconds, // --LockoutIf--> PLAYER_1 is inactive for xx seconds conesutively
			never( // --ResetNextIf--> when PLAYER_1 uses any input while in-game || when loading another ChapterSection || when PauseMenu->Restart
				is_flagStates_BothPlayers_InGame_false(enum_releaseRegion) // --2 Lines--> When loading another ChapterSection || when PauseMenu->Restart
				|| is_flagState_InGame_true(enum_releaseRegion) // --4 Lines--> when PLAYER_1 uses any input while in-game
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& on_PlayerInput_anyInputUse(PLAYER_1, enum_releaseRegion)) 
			// && !is_AnyInGameMenu_active(enum_releaseRegion) // DISABLED - Unnecessary as [MissionTime_Temp] only increments while the PauseMenu is inactive
			&& !is_AnyCinematic_active(enum_releaseRegion)
			&& current_Player_HP(PLAYER_1, enum_releaseRegion) > 0.0  // --CheckIf--> Not in respawn screen (otherwise keeps counting when dead) 
			&& on_MissionTime_Temp_secondPassed(enum_releaseRegion)))
		&& never(repeated(PARTICIPATION_TRACKING_MaxInactiveSeconds, // --LockoutIf--> PLAYER_2 is inactive for xx seconds conesutively
			never( // --ResetNextIf--> when PLAYER_2 uses any input while in-game || when loading another ChapterSection || when PauseMenu->Restart
				is_flagStates_BothPlayers_InGame_false(enum_releaseRegion) // --2 Lines--> When loading another ChapterSection || when PauseMenu->Restart
				|| is_flagState_InGame_true(enum_releaseRegion) // --4 Lines--> when PLAYER_2 uses any input while in-game
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& on_PlayerInput_anyInputUse(PLAYER_2, enum_releaseRegion)) 
			// && !is_AnyInGameMenu_active(enum_releaseRegion) // DISABLED - Unnecessary as [MissionTime_Temp] only increments while the PauseMenu is inactive
			&& !is_AnyCinematic_active(enum_releaseRegion)
			&& current_Player_HP(PLAYER_2, enum_releaseRegion) > 0.0 // --CheckIf--> Not in respawn screen (otherwise keeps counting when dead) 
			&& on_MissionTime_Temp_secondPassed(enum_releaseRegion)))
		&& always_false()
	}

function achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion) =>
	// [5/] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
		never( // --Lockout--> When PLAYER_1 dies
			is_ReleaseRegion(enum_releaseRegion)
			&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
			&& on_Player_death(PLAYER_1, enum_releaseRegion))
		&& never( // --Lockout--> When PLAYER_2 dies
			is_ReleaseRegion(enum_releaseRegion)
			&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
			&& on_Player_death(PLAYER_2, enum_releaseRegion))
		&& always_false()

function achGenerate_5x_AltResetGroups_ChapterProgression(enum_chapter, enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroups[4+5])
	// [1] ==== Alt Reset Group ==== 			-> Reset when not in Multiplayer Coop Mode
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InMultiplayerCoopMode(enum_releaseRegion))
	// [2] ==== Alt Reset Group ==== 			-> Reset when not in correct Level
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	// [3] ==== Alt Reset Group ==== 			-> Reset when at MainMenu --> Necessary next to AltResetGroup[4], to reset hitCounts on AltLogicGroup
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_atMainMenu(enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 			-> Reset on PauseMenu->Restart when at ChapterSection_1
		/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (PlaceHolder[FD1-FD2]])
			PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
			NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
			*/	
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& is_ChapterSection(enum_chapter, CHAPTER_SECTION_1, enum_releaseRegion)
			&& on_PauseMenu_Restart(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[FD1-FD2]
	// [5] ==== Alt Reset Group ==== 			-> Reset on PauseMenu->Quit 
		/* MANUAL_CONSTRUCTION[FD1-FD3]:ResetOn_PauseMenu_Quit (AltGroup[5]) - R/R usage
			PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._I:0xX007238b8_Z:0xL00000008!=0_I:0xX007238b8_N:0xL00000008=0_I:0xX007238b8_C:d0xL00000008!=0.1._R:0=1.2._0=1
			NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._I:0xX00721fb8_Z:0xL00000008!=0_I:0xX00721fb8_N:0xL00000008=0_I:0xX00721fb8_C:d0xL00000008!=0.1._R:0=1.2._0=1
			-----------
				AddAddress	[Pointer:UIcontrol(preferred)]
				Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
				Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

				AddAddress	[Pointer:UIcontrol(preferred)]
				AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
				Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


				=============CONTROLLER_2 Quits=============
				---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
				---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
				---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
				AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
				AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
				
				AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0x7C
				AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

				AddAddress	[Pointer:PlayerInput(preferred)]
				AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


				=============CONTROLLER_2 Quits=============
				---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
				---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

				AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
				---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
				AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
				AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
				
				AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0xB8
				AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
				
				AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
				AddAddress	->[Mem 32-bit] 0x7C
				AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

				AddAddress	[Pointer:PlayerInput(preferred)]
				AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


				=============Effectively Quit (check)=============
				---------ResetNextIf_B--------- (-> when pressing Quit, [Lower4:ActiveMenuPointerIndex] becomes 0, the next frame)
				ResetNextIf	Mem [Lower4:ActiveMenuPointerIndex] != 0x0 			| ResetNextIf: [Lower4:ActiveMenuPointerIndex] != 0
				---------AddHit_B--------
				AndNext		Mem [Lower4:ActiveMenuPointerIndex] == 0x0		
				AddHits		Delta [Lower4:ActiveMenuPointerIndex] != 0x0	(1)		| CheckIf: [Lower4:ActiveMenuPointerIndex] turns 0

				ResetIf		Val 0x0 == Val 0x1		(2)		| CheckIf: (CONTROLLER_1 Quits OR CONTROLLER_2 Quits) AND CheckIf: Effectively Quit
				
							Val 0x0 == Val 0x1				| always_false() */
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& on_PauseMenu_Quit(enum_releaseRegion)) // --> MANUAL_CONSTRUCTION[FD1-FD3]

function achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(enum_chapter, enum_endingFMV, enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+6+7])
	PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(enum_chapter)
	return
	// [1/8] ==== Alt Logic + Trigger Group ==== 			-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK
		unless(!is_ReleaseRegion(enum_releaseRegion))

		// -------- Core Logic --------
		&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1)
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))

		// -------- Trigger Indicator --------		
		&& trigger_when(
			once( // --CheckIf--> The last StoryChapterSection of the Level has started
				on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
				never(is_flagState_InGame_true(enum_releaseRegion))

				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

				/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
					// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
						---------Participation Tracking (Accuracy)---------
						Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

						Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

						---------Participation Tracking (Kills)---------
						Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
						Remember	Recall / 1.0								--> Force 32-bit to Float
						AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
						AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
						AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
						AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
				&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

				&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))

			// -------- Participation Tracking (Inputs) --------
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

			// -------- (Last) Requirements for Unlock --------
			&& once(
				never(on_FMV_start(enum_endingFMV, enum_releaseRegion))
				&& on_FMV_end(enum_endingFMV, enum_releaseRegion))
			&& on_Loading_start(enum_releaseRegion)
			)
	// [2/9] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(enum_chapter, enum_releaseRegion)
	// [3+..+7/..+13+14] ==== 5x Alt Reset Groups ==== 		-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
		|| achGenerate_5x_AltResetGroups_ChapterProgression(enum_chapter, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
	}

function achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(enum_chapter, enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+6+7])
	PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(enum_chapter)
	return
	// [1/8] ==== Alt Logic + Trigger Group ==== 			-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK
		unless(!is_ReleaseRegion(enum_releaseRegion))

		// -------- Core Logic --------
		&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1)
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))

		// -------- Trigger Indicator --------		
		&& trigger_when(
			once( // --CheckIf--> The last StoryChapterSection of the Level has started
				on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
				never(is_flagState_InGame_true(enum_releaseRegion))

				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

				/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
					// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
						---------Participation Tracking (Accuracy)---------
						Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

						Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

						---------Participation Tracking (Kills)---------
						Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
						Remember	Recall / 1.0								--> Force 32-bit to Float
						AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
						AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
						AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
						AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
				&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

				&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))

			// -------- Participation Tracking (Inputs) --------
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

			// -------- (Last) Requirements for Unlock --------
			&& on_Loading_start(enum_releaseRegion)
			)
	// [2/9] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(enum_chapter, enum_releaseRegion)
	// [3+..+7/..+13+14] ==== 5x Alt Reset Groups ==== 		-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
		|| achGenerate_5x_AltResetGroups_ChapterProgression(enum_chapter, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
	}

function achGenerate_FullTrigger_StoryEnd(bool_IsGoodEnding, enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+6+7])
	const_CHAPTER = CHAPTER_17_CurseWest
	const_FMV_ending = FMV_Monster
	if (bool_IsGoodEnding) const_FMV_ending = FMV_Hero

	PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
	PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
	PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
	PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
	return
	// [1/8] ==== Alt Logic + Trigger Group ==== 			-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK
		unless(!is_ReleaseRegion(enum_releaseRegion))

		// -------- Core Logic --------
		&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1)
			on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

		// -------- Trigger Indicator --------		
		&& trigger_when(
			once( // --CheckIf--> The last StoryChapterSection of the Level has started
				on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
				never(is_flagState_InGame_true(enum_releaseRegion))

				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

				/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracy
					PAL:	K:0xH00965c54/f1.0_K:0xH00965c58/{recall}_N:{recall}>=f0.06_K:0xH00965d80/f1.0_K:0xH00965d84/{recall}_N:{recall}>=f0.06
					NTSCU:	K:0xH00953c74/f1.0_K:0xH00953c78/{recall}_N:{recall}>=f0.06_K:0xH00953da0/f1.0_K:0xH00953da4/{recall}_N:{recall}>=f0.06
					----------
						---------Participation Tracking (Accuracy)---------
						Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

						Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
						Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent
						*/
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
				&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
				&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
			&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
				never(is_flagState_InGame_true(enum_releaseRegion))
				&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
				&& wasPrior_flagState_InGame_true(enum_releaseRegion)
				&& is_flagState_InGame_false(enum_releaseRegion))

			// -------- Participation Tracking (Inputs) --------
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
			&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
				!is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

			// -------- (Last) Requirements for Unlock --------
			&& once(
				never(on_FMV_start(const_FMV_ending, enum_releaseRegion))
				&& on_FMV_end(const_FMV_ending, enum_releaseRegion))
			&& on_FMV_end(FMV_Credits, enum_releaseRegion)
			)
	// [2/9] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
	// [3+..+7/..+13+14] ==== 5x Alt Reset Groups ==== 		-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
		|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
	}
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
	// ----------------c_Misc----------------
	"a_INFOcoop": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) 
		&& is_InMultiplayerCoopMode(enum_releaseRegion) // --> TogglesTrue when confirming 2 players at MultiplayerCoopProfileSelectMenu; TogglesFalse when back at MainMenu(proper)
		&& is_atMainMenu(enum_releaseRegion)
		&& on_MainMenu_SubMenu_render(MAINMENU_SUBMENU_ChapterSelectMenu, enum_releaseRegion)),
	// ----------------c_Story----------------
	"a_WrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(CHAPTER_1_WrongTrain, FMV_Shadow, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_RideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_2_RideDevil, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Boneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(CHAPTER_3_Boneyard, FMV_CassidyDies, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_DevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(CHAPTER_4_DevilMine, FMV_TheHaunting, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_DWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_5_Outpost, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_WarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_6_WarTrain, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_TortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(CHAPTER_7_TortureMaze, FMV_GiddyUp, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_BaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_8_BaptismFire, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Rescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_9_Rescue, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Prism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_10_Prism, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Invasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_11_Invasion, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Hangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_withEndFMV(CHAPTER_12_Hangtown, FMV_PromNight, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_MorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_13_MorningAfter, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Showdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_14_Showdown, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_RightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_15_RightTrain, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_Deadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_ChapterProgressionCompletion_noEndFMV(CHAPTER_16_Deadfall, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	// ----------------c_StoryEnd----------------
	"a_CurseWestGood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_StoryEnd(true, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	"a_CurseWestEvil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WARNING - (2x) MANUAL_CONSTRUCTION
		achGenerate_FullTrigger_StoryEnd(false, enum_releaseRegion)), // --> (2x) MANUAL_CONSTRUCTION
	// ----------------c_Challenge----------------
	"a_ClgWrongTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+9+10])
		const_CHAPTER = CHAPTER_1_WrongTrain
		const_CHAPTER_ENDING_FMV = FMV_Shadow
		const_MIN_REQUIRED_COMBINED_ACCURACY = 0.7

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/11] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

					/* MANUAL_CONSTRUCTION[CAA1-CAA2]:CheckCombinedAccuracy
						// WARNING: Edit in const_MIN_REQUIRED_COMBINED_ACCURACY
						PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_A:0xX00965d84/{recall}_N:f0.0>=f0.7
						NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_A:0xX00953da4/{recall}_N:f0.0>=f0.7
						----------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0		--> Force 32-bit to Float
							AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AddSource	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= const_MIN_REQUIRED_COMBINED_ACCURACY
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
					&& current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& once(
					never(on_FMV_start(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
					&& on_FMV_end(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/12] ==== Alt Measured Group (in-game) ==== 			-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when in-game
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileInGame
				PAL:	A:0xX00965c20+0xX00965c88_A:0xX00965c54_A:0xX00965d4c+0xX00965db4_K:0xX00965d80_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c8c/{recall}_A:0xX00965c58/{recall}_A:0xX00965d50/{recall}_A:0xX00965db8/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	A:0xX00953c40+0xX00953ca8_A:0xX00953c74_A:0xX00953d6c+0xX00953dd4_K:0xX00953da0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953cac/{recall}_A:0xX00953c78/{recall}_A:0xX00953d70/{recall}_A:0xX00953dd8/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				----------
					AddSource	[ShotsFired_Temp(PLAYER_1)] + [ShotsFired_ChapterSection(PLAYER_1)]
					AddSource	[ShotsFired_ChapterTotal(PLAYER_1)] 
					AddSource	[ShotsFired_Temp(PLAYER_2)] + [ShotsFired_ChapterSection(PLAYER_2)]
					Remember	[ShotsFired_ChapterTotal(PLAYER_2)] 
					Remember	Recall / 1.0						--> Force 32-bit to Float
					AddSource	[ShotsHit_Temp(PLAYER_1)] / Recall
					AddSource	[ShotsHit_ChapterSection(PLAYER_1)] / Recall
					AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[ShotsHit_Temp(PLAYER_2)] / Recall
					AddSource	[ShotsHit_ChapterSection(PLAYER_2)] / Recall
					Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")	
			&& memUtil_alwaysFalse(enum_releaseRegion)		
		// [3/13] ==== Alt Measured Group (NOT in-game) ==== 		-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when not in-game (during loading)
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileNotInGame
				PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				----------
					Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0		--> Force 32-bit to Float
					AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
					Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)	
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [6+..+9+10/16+..+19+20] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgRideDevil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+8+9])
		const_CHAPTER = CHAPTER_2_RideDevil
		const_COMBINED_HP_THRESHOLD = (CONST_PLAYER_MAX_HP *2) *0.55 // 55%

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/10] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when combined HP drops below const_COMBINED_HP_THRESHOLD, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> when combined player HP drops below const_COMBINED_HP_THRESHOLD
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) 
					+ current_Player_HP(PLAYER_2, enum_releaseRegion) < const_COMBINED_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) 
					+ prev_Player_HP(PLAYER_2, enum_releaseRegion) >= const_COMBINED_HP_THRESHOLD
				)
			&& always_false()
		// [3/12] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [5+..+8+9/14+..+17+18] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgBoneyard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+9+10])
		// NOTE: For this achievement only: ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)

		const_CHAPTER = CHAPTER_3_Boneyard
		const_WEAPON_A = WEAPON_Crossbow
		const_WEAPON_B = WEAPON_Carbine
		const_REQUIRED_KILLS = 100

		achClgBoneyard_Tally_weaponKills = tally(const_REQUIRED_KILLS, [
			// -------- PLAYER_1 --------
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),
				
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)), // --AddHit 1--> When Kills increment by 1

				// --AddHit 1--> When Kills increment by 2, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(2, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 2--> When Kills increment by 3, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 3--> When Kills increment by 4, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 4--> When Kills increment by 5, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 

			// -------- PLAYER_2 --------
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_B, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion)),
				
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion)), // --AddHit 1--> When Kills increment by 1

				// --AddHit 1--> When Kills increment by 2, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(2, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 2--> When Kills increment by 3, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 3--> When Kills increment by 4, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 4--> When Kills increment by 5, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
			])

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/11] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& achClgBoneyard_Tally_weaponKills // --CheckIf--> all kills achieved with required weapons 
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/12] === Alt Measured Group ====	-> Group is only responsible for displaying a Measured Indicator tracking kills with required weapons
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion)) 
			&& measured(achClgBoneyard_Tally_weaponKills,
				when = once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
					is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player uses a throwable, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When PLAYER_1 uses a throwable explosive 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_1, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 uses a throwable explosive  
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_2, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [6+..+9+10/16+..+19+20] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart || on PauseMenu->Quit
			/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (AltGroup[9/19])
				- NOTE: MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)
				
				PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
				NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
				*/	
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgDevilMine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (4x) MANUAL_CONSTRUCTION (AltGroups[1+2+9+10])
		const_CHAPTER = CHAPTER_4_DevilMine
		const_CHAPTER_ENDING_FMV = FMV_TheHaunting
		const_WEAPONS_SMALL_ARMS = [
			// WEAPON_Pistol, WEAPON_HorseRevolver, // DISABLED - Not available in Chapter
			WEAPON_Redeemer, WEAPON_DualPistols]
		const_WEAPONS_LONG_ARMS = [
			WEAPON_Carbine, WEAPON_Shotgun,  WEAPON_RailRocket, 
			WEAPON_RangeRifle, WEAPON_Crossbow, WEAPON_Scepter]

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/11] ==== Alt Logic + Trigger Group (PLAYER_1:SmallArms - PLAYER_2:LongArms) ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				never(tally_of(CONST_WEAPON_DATA, 1, (enum_weapon) {  // --ResetNextIf--OrNext--> PLAYER_1 shoots a LongArm || PLAYER_2 shoots a SmallArm
					if (WEAPON_DATA_IsSmallArm(enum_weapon) && array_contains(const_WEAPONS_SMALL_ARMS, enum_weapon)) // ResetNextIf: PLAYER_2 shoots a SmallArm
						return once(
							is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
							&& is_EquippedWeapon(PLAYER_2, enum_weapon, enum_releaseRegion)
							&& !on_HUDcontrolGear_weaponSwap(PLAYER_2, enum_releaseRegion)
							&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_2, enum_releaseRegion))							
					else if (!WEAPON_DATA_IsSmallArm(enum_weapon) && array_contains(const_WEAPONS_LONG_ARMS, enum_weapon))  // ResetNextIf: PLAYER_1 shoots a LongArm
						return once(
							is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
							&& is_EquippedWeapon(PLAYER_1, enum_weapon, enum_releaseRegion)
							&& !on_HUDcontrolGear_weaponSwap(PLAYER_1, enum_releaseRegion)
							&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_1, enum_releaseRegion))
					else return always_false()
					}))
				&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& once(
					never(on_FMV_start(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
					&& on_FMV_end(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/12] ==== Alt Logic + Trigger Group (PLAYER_1:LongArms - PLAYER_2:SmallArms) ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			|| unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				never(tally_of(CONST_WEAPON_DATA, 1, (enum_weapon) {  // --ResetNextIf--OrNext--> PLAYER_2 shoots a LongArm || PLAYER_1 shoots a SmallArm
					if (WEAPON_DATA_IsSmallArm(enum_weapon) && array_contains(const_WEAPONS_SMALL_ARMS, enum_weapon)) // ResetNextIf: PLAYER_1 shoots a SmallArm
						return once(
							is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
							&& is_EquippedWeapon(PLAYER_1, enum_weapon, enum_releaseRegion)
							&& !on_HUDcontrolGear_weaponSwap(PLAYER_1, enum_releaseRegion)
							&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_1, enum_releaseRegion))
					else if (!WEAPON_DATA_IsSmallArm(enum_weapon) && array_contains(const_WEAPONS_LONG_ARMS, enum_weapon))  // ResetNextIf: PLAYER_2 shoots a LongArm
						return once(
							is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
							&& is_EquippedWeapon(PLAYER_2, enum_weapon, enum_releaseRegion)
							&& !on_HUDcontrolGear_weaponSwap(PLAYER_2, enum_releaseRegion)
							&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_2, enum_releaseRegion))
					else return always_false()
					}))
				&& is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& once(
					never(on_FMV_start(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
					&& on_FMV_end(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
				&& on_Loading_start(enum_releaseRegion)
				)
		// [3/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player uses a throwable || when any player uses a power, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When PLAYER_1 uses a throwable explosive  
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_1, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 uses a throwable explosive  
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_2, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_2, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_1 uses a power 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 uses a power 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Player_Power_use(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [6+..+9+10/16+..+19+20] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart || on PauseMenu->Quit
			/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (AltGroup[9/19])
				- NOTE: MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)
				
				PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
				NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
				*/	
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgDWOutpost": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+8+9])
		const_CHAPTER = CHAPTER_5_Outpost
		const_ALLOWED_SECS_BELOW_MAX_HP = 30 // seconds consecutively below max combined HP

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/10] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/11] ==== Alt Lockout Group ===		-> Lockout achievement when combined HP is below max for xx in-game seconds consecutively, by Resetting HitCount on [StartCondition]
			|| never(repeated(const_ALLOWED_SECS_BELOW_MAX_HP, // --Lockout--[ConsecutiveChallengeCondition]--> When below max combined HP for xx in-game seconds consecutively
				never( // --ResetNextIf--[ConsecutiveResetCondition]--> When back at max combined HP
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_Player_HP(PLAYER_1, enum_releaseRegion) + current_Player_HP(PLAYER_2, enum_releaseRegion) == CONST_PLAYER_MAX_HP *2)
				&& is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) + current_Player_HP(PLAYER_2, enum_releaseRegion) < CONST_PLAYER_MAX_HP *2
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& on_MissionTime_Temp_secondPassed(enum_releaseRegion)))
			&& always_false()
		// [3/12] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [5+..+8+9/14+..+17+18] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgWarTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_6_WarTrain
		const_TIME_LIMIT = 300000 // 300.000 ms = 5 min

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured) - R/R usage
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
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured) - R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f300.0-{recall}_M:0=f300.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f300.0-{recall}_M:0=f300.0
				''''''''''''''
				Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
				AddSource	(const_TIME_LIMIT/1000) - Recall
				Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement on challenge fail by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(// --Lockout--> When any player loses HP
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) + current_Player_HP(PLAYER_2, enum_releaseRegion) < CONST_PLAYER_MAX_HP
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) + prev_Player_HP(PLAYER_2, enum_releaseRegion) == CONST_PLAYER_MAX_HP)
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgTortureMaze": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_7_TortureMaze
		const_CHAPTER_ENDING_FMV = FMV_GiddyUp
		const_MIN_REQUIRED_MELEE_KILLS = 0.6

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills) + MeleeKillsRatioAchieved
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeKillsRatioAchieved
						PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c60/{recall}_K:0xX00965d8c/{recall}_N:{recall}>=f0.6
						NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c80/{recall}_K:0xX00953dac/{recall}_N:{recall}>=f0.6
						-----------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0					--> Force 32-bit to Float
							AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall	--> Divide by Float, returns a Float
							Remember	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall	--> Divide by Float, returns a Float
							AndNext		Recall >= const_MIN_REQUIRED_MELEE_KILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= const_MIN_REQUIRED_MELEE_KILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& once(
					never(on_FMV_start(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
					&& on_FMV_end(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ====		-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When in-game
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion))
			&& unless(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --PauseLock--Tally(2)--> when both players scored a meleeKill 
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_MeleeKills_Temp(enum_player, enum_releaseRegion) > prev_MeleeKills_Temp(enum_player, enum_releaseRegion))
				))
			&& unless(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --PauseLock--Tally(2)--> when both players scored a standardKill 
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_Kills_Temp(enum_player, enum_releaseRegion) != current_MeleeKills_Temp(enum_player, enum_releaseRegion)) // If (Kills != MeleeKills) then a standarKill was scored
				))
			/* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredMeleeKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_A:0xX00965c84+0xX00965c50_A:0xX00965d48_K:0xX00965db0+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c2c/{recall}_A:0xX00965c94/{recall}_A:0xX00965c60/{recall}_A:0xX00965d58/{recall}_A:0xX00965dc0/{recall}_K:0xX00965d8c/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_A:0xX00953ca4+0xX00953c70_A:0xX00953d68_K:0xX00953dd0+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c4c/{recall}_A:0xX00953cb4/{recall}_A:0xX00953c80/{recall}_A:0xX00953d78/{recall}_A:0xX00953de0/{recall}_K:0xX00953dac/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					AddSource	[Kills_Temp(PLAYER_1)]
					AddSource	[Kills_ChapterSection(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_1)]
					AddSource	[Kills_Temp(PLAYER_2)]
					Remember	[Kills_ChapterSection(PLAYER_2)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0						--> Force 32-bit to Float
					AddSource	[MeleeKills_Temp(PLAYER_1)] / Recall
					AddSource	[MeleeKills_ChapterSection(PLAYER_1)] / Recall
					AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[MeleeKills_Temp(PLAYER_2)] / Recall
					AddSource	[MeleeKills_ChapterSection(PLAYER_2)] / Recall
					Remember	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0	
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_Kills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC12)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> Group is only responsible for displaying a Measured Indicator for kills to melee kills ratio % - When not in-game
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion))
			&& unless(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --PauseLock--Tally(2)--> when both players scored a meleeKill 
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_MeleeKills_Temp(enum_player, enum_releaseRegion) > prev_MeleeKills_Temp(enum_player, enum_releaseRegion))
				))
			&& unless(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --PauseLock--Tally(2)--> when both players scored a standardKill 
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_Kills_Temp(enum_player, enum_releaseRegion) != current_MeleeKills_Temp(enum_player, enum_releaseRegion)) // If (Kills != MeleeKills) then a standarKill was scored
				))
			/* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredMeleeKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c60/{recall}_K:0xX00965d8c/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c80/{recall}_K:0xX00953dac/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0			--> Force 32-bit to Float
					AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall
					Remember	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> MeleeKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when both players scored a meleeKill || when both players scored a standardKill, by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion)) 
			&& never(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --Lockout--Tally(2)-> when both players scored a meleeKill
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_MeleeKills_Temp(enum_player, enum_releaseRegion) > prev_MeleeKills_Temp(enum_player, enum_releaseRegion))
				))
			&& never(tally_of([PLAYER_1, PLAYER_2], 2, enum_player => // --Lockout--Tally(2)-> when both players scored a standardKill		
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& current_Kills_Temp(enum_player, enum_releaseRegion) != current_MeleeKills_Temp(enum_player, enum_releaseRegion)) // If (Kills != MeleeKills) then a standarKill was scored
				))
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgBaptismFire": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+9+10])
		// NOTE: For this achievement only: ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)

		const_CHAPTER = CHAPTER_3_Boneyard
		const_WEAPON_A = WEAPON_RailRocket
		const_WEAPON_B = WEAPON_Redeemer
		const_REQUIRED_KILLS = 80

		achClgBoneyard_Tally_weaponKills = tally(const_REQUIRED_KILLS, [
			// -------- PLAYER_1 --------
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)),
				
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion)), // --AddHit 1--> When Kills increment by 1

				// --AddHit 1--> When Kills increment by 2, because of Explosiveness of RialRocket ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(2, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 2--> When Kills increment by 3, because of Explosiveness of RialRocket ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 3--> When Kills increment by 4, because of Explosiveness of RialRocket ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_1, enum_releaseRegion)), 

				// --AddHit 4--> When Kills increment by 5, because of Explosiveness of RialRocket ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_1, enum_releaseRegion)), 

			// -------- PLAYER_2 --------
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_B, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion)),
				
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion)), // --AddHit 1--> When Kills increment by 1

				// --AddHit 1--> When Kills increment by 2, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(2, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 2--> When Kills increment by 3, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(3, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 3--> When Kills increment by 4, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(4, PLAYER_2, enum_releaseRegion)), 

				// --AddHit 4--> When Kills increment by 5, because of Explosiveness of Crossbow ammo - PLUS AddHit 1 When Kills increment by 1
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
				repeated(const_REQUIRED_KILLS, 
					is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
					&& on_Kills_Temp_incrementBy(5, PLAYER_2, enum_releaseRegion)), 
			])

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/11] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& achClgBoneyard_Tally_weaponKills // --CheckIf--> all kills achieved with required weapons 
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/12] === Alt Measured Group ====	-> Group is only responsible for displaying a Measured Indicator tracking kills with required weapons
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion)) 
			&& measured(achClgBoneyard_Tally_weaponKills,
				when = once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
					is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
					&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player uses a throwable, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When PLAYER_1 uses a throwable explosive 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_1, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 uses a throwable explosive  
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_2, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [6+..+9+10/16+..+19+20] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart || on PauseMenu->Quit
			/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (AltGroup[9/19])
				- NOTE: MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)
				
				PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
				NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
				*/	
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgRescue": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_9_Rescue
		const_TIME_LIMIT = 600000 // 600.000 ms = 10 min
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP *0.25 // 25% of Max HP

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c08_A:0xX00965c70_A:0xX00965c3c_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
				NTSCU:	A:0xX00953c28_A:0xX00953c90_A:0xX00953c5c_K:0_K:{recall}/f1000.0_A:f600.0-{recall}_M:0=f600.0
				''''''''''''''
					AddSource	[32-bit:MissionTime_Temp]
					AddSource	[32-bit:MissionTime_ChapterSection]
					AddSource	[32-bit:MissionTime_ChapterTotal]
					Remember	Val 0
					Remember	Recall / 1000.0							| current_calculated_TotalMissionTime_whileInGame() in seconds
					AddSource	(const_TIME_LIMIT/1000) - Recall
					Measured	Val 0 == (const_TIME_LIMIT/1000) 		
					*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured) - R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f600.0-{recall}_M:0=f600.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f600.0-{recall}_M:0=f600.0
				''''''''''''''
				Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
				AddSource	(const_TIME_LIMIT/1000) - Recall
				Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement on challenge fail by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(// --Lockout--> When PLAYER_1 goes below xx% HP
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD)
			&& never(// --Lockout--> When PLAYER_2 goes below xx% HP
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_2, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_2, enum_releaseRegion) >= const_HP_THRESHOLD)
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgPrism": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+8+9])
		const_CHAPTER = CHAPTER_10_Prism

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/10] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player activates a power for the 2nd time, by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& all_of(CONST_POWER_DATA, enum_power => // --AllOf--> Creates 2 ResetIf(Lockouts) for each power
				never(repeated(2, // --Lockout--> when PLAYER_1 uses a power for 2nd time
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_1, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)))
				&& never(repeated(2, // --Lockout--> when PLAYER_2 uses a power for 2nd time
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_2, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_2, enum_releaseRegion)))
				)
			&& always_false()
		// [3/12] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [5+..+8+9/14+..+17+18] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgInvasion": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+8+9])
		const_CHAPTER = CHAPTER_11_Invasion
		const_WEAPON_A = WEAPON_DualPistols
		const_WEAPON_B = WEAPON_Shotgun

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/10] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/11] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player uses a throwable || when any player scores a kill without a required weapon equipped, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When PLAYER_1 uses a throwable explosive 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_1, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 uses a throwable explosive  
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& on_Throwable_use(PLAYER_2, enum_releaseRegion)
				&& !on_ThrowableType_switch(PLAYER_2, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_1 scores a kill without a required weapon equipped   
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 scores a kill without a required weapon equipped   
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_2, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [3/12] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [4/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [5+..+8+9/14+..+17+18] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart || on PauseMenu->Quit
			/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (AltGroup[9/19])
				- NOTE: MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)
				
				PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
				NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
				*/	
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgHangtown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_12_Hangtown
		const_CHAPTER_ENDING_FMV = FMV_PromNight
		const_MIN_REQUIRED_COMBINED_ACCURACY = 0.75

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

					/* MANUAL_CONSTRUCTION[CAA1-CAA2]:CheckCombinedAccuracy
						// WARNING: Edit in const_MIN_REQUIRED_COMBINED_ACCURACY
						PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_A:0xX00965d84/{recall}_N:f0.0>=f0.75
						NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_A:0xX00953da4/{recall}_N:f0.0>=f0.75
						----------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0		--> Force 32-bit to Float
							AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AddSource	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= const_MIN_REQUIRED_COMBINED_ACCURACY
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
					&& current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& once(
					never(on_FMV_start(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
					&& on_FMV_end(const_CHAPTER_ENDING_FMV, enum_releaseRegion))
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (in-game) ==== 			-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when in-game
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileInGame
					PAL:	A:0xX00965c20+0xX00965c88_A:0xX00965c54_A:0xX00965d4c+0xX00965db4_K:0xX00965d80_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c8c/{recall}_A:0xX00965c58/{recall}_A:0xX00965d50/{recall}_A:0xX00965db8/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					NTSCU:	A:0xX00953c40+0xX00953ca8_A:0xX00953c74_A:0xX00953d6c+0xX00953dd4_K:0xX00953da0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953cac/{recall}_A:0xX00953c78/{recall}_A:0xX00953d70/{recall}_A:0xX00953dd8/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					----------
						AddSource	[ShotsFired_Temp(PLAYER_1)] + [ShotsFired_ChapterSection(PLAYER_1)]
						AddSource	[ShotsFired_ChapterTotal(PLAYER_1)] 
						AddSource	[ShotsFired_Temp(PLAYER_2)] + [ShotsFired_ChapterSection(PLAYER_2)]
						Remember	[ShotsFired_ChapterTotal(PLAYER_2)] 
						Remember	Recall / 1.0						--> Force 32-bit to Float
						AddSource	[ShotsHit_Temp(PLAYER_1)] / Recall
						AddSource	[ShotsHit_ChapterSection(PLAYER_1)] / Recall
						AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AddSource	[ShotsHit_Temp(PLAYER_2)] / Recall
						AddSource	[ShotsHit_ChapterSection(PLAYER_2)] / Recall
						Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
						Remember	Recall * 100.0
						Measured	Recall == 100.0
						*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/14] ==== Alt Measured Group (NOT in-game) ==== 		-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when not in-game (during loading)
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileNotInGame
					PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					----------
						Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
						Remember	Recall / 1.0		--> Force 32-bit to Float
						AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
						Remember	Recall * 100.0
						Measured	Recall == 100.0
						*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)	
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player shoots without WEAPON_RangeRifle equipped, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> when PLAYER_1 shoots a gun without WEAPON_RangeRifle equipped
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, WEAPON_RangeRifle, enum_releaseRegion)
				&& !on_HUDcontrolGear_weaponSwap(PLAYER_1, enum_releaseRegion)
				&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> when PLAYER_2 shoots a gun without WEAPON_RangeRifle equipped
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_2, WEAPON_RangeRifle, enum_releaseRegion)
				&& !on_HUDcontrolGear_weaponSwap(PLAYER_2, enum_releaseRegion)
				&& on_HUDcontrolGear_LoadedBullets_decrement(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgMorningAfter": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_13_MorningAfter
		const_NON_ALLOWED_POWERS = POWER_DATA_getAllPowersOfTiers([1,4])
		const_MIN_REQUIRED_RATIO_MELEE_OR_HEADSHOTKILLS = 0.4 // percent

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)	
				
					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckMeleeAndHeadshotKillsRatioAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c60/{recall}_A:0xX00965d8c/{recall}_A:0xX00965c5c/{recall}_K:0xX00965d88/{recall}_N:{recall}>=f0.4
						NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c80/{recall}_A:0xX00953dac/{recall}_A:0xX00953c7c/{recall}_K:0xX00953da8/{recall}_N:{recall}>=f0.4
						-----------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0			--> Force 32-bit to Float
							AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall
							AddSource	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall
							AddSource	[HeadshotKills_ChapterTotal(PLAYER_1)] / Recall
							Remember	[HeadshotKills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= const_MIN_REQUIRED_RATIO_MELEE_OR_HEADSHOTKILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion)
						+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= const_MIN_REQUIRED_RATIO_MELEE_OR_HEADSHOTKILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ====		-> Group is only responsible for displaying a Measured Indicator for kills to melee-/headshotKills ratio % - When in-game
			|| /* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredMeleeAndHeadshotKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_A:0xX00965c84+0xX00965c50_A:0xX00965d48_K:0xX00965db0+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c2c/{recall}_A:0xX00965c94/{recall}_A:0xX00965c60/{recall}_A:0xX00965d58/{recall}_A:0xX00965dc0/{recall}_A:0xX00965d8c/{recall}_A:0xX00965c28/{recall}_A:0xX00965c90/{recall}_A:0xX00965c5c/{recall}_A:0xX00965d54/{recall}_A:0xX00965dbc/{recall}_K:0xX00965d88/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_A:0xX00953ca4+0xX00953c70_A:0xX00953d68_K:0xX00953dd0+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c4c/{recall}_A:0xX00953cb4/{recall}_A:0xX00953c80/{recall}_A:0xX00953d78/{recall}_A:0xX00953de0/{recall}_A:0xX00953dac/{recall}_A:0xX00953c48/{recall}_A:0xX00953cb0/{recall}_A:0xX00953c7c/{recall}_A:0xX00953d74/{recall}_A:0xX00953ddc/{recall}_K:0xX00953da8/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					AddSource	[Kills_Temp(PLAYER_1)]
					AddSource	[Kills_ChapterSection(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_1)]
					AddSource	[Kills_Temp(PLAYER_2)]
					Remember	[Kills_ChapterSection(PLAYER_2)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0			--> Force 32-bit to Float
					AddSource	[MeleeKills_Temp(PLAYER_1)] / Recall
					AddSource	[MeleeKills_ChapterSection(PLAYER_1)] / Recall
					AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[MeleeKills_Temp(PLAYER_2)] / Recall
					AddSource	[MeleeKills_ChapterSection(PLAYER_2)] / Recall
					AddSource	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall
					AddSource	[HeadShotKills_Temp(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_ChapterSection(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_Temp(PLAYER_2)] / Recall
					AddSource	[HeadShotKills_ChapterSection(PLAYER_2)] / Recall
					Remember	[HeadShotKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> Melee- and HeadshotKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_Kills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) 
				+ current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_HeadshotKills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> Group is only responsible for displaying a Measured Indicator for kills to melee-/headshotKills ratio % - When not in-game
			|| /* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredMeleeAndHeadshotKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c60/{recall}_A:0xX00965d8c/{recall}_A:0xX00965c5c/{recall}_K:0xX00965d88/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c80/{recall}_A:0xX00953dac/{recall}_A:0xX00953c7c/{recall}_K:0xX00953da8/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0			--> Force 32-bit to Float
					AddSource	[MeleeKills_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[MeleeKills_ChapterTotal(PLAYER_2)] / Recall
					AddSource	[HeadshotKills_ChapterTotal(PLAYER_1)] / Recall
					Remember	[HeadshotKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> Melee- and HeadshotKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) 
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player use a Tier 1 or 4 power, by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(tally_of(const_NON_ALLOWED_POWERS, 1, enum_power => // --Lockout--> when PLAYER_1 uses a Tier 1 or 4 power
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_1, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			&& never(tally_of(const_NON_ALLOWED_POWERS, 1, enum_power => // --Lockout--> when PLAYER_2 uses a Tier 1 or 4 power
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_2, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_2, enum_releaseRegion))
				))
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgShowdown": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_14_Showdown
		const_ALLOWED_DISTINCT_POWERS = 1
		const_MIN_REQUIRED_COMBINED_ACCURACY = 0.65

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

					/* MANUAL_CONSTRUCTION[CAA1-CAA2]:CheckCombinedAccuracy
						// WARNING: Edit in const_MIN_REQUIRED_COMBINED_ACCURACY
						PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_A:0xX00965d84/{recall}_N:f0.0>=f0.65
						NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_A:0xX00953da4/{recall}_N:f0.0>=f0.65
						----------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0		--> Force 32-bit to Float
							AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AddSource	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= const_MIN_REQUIRED_COMBINED_ACCURACY
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
					&& current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == const_MIN_REQUIRED_COMBINED_ACCURACY * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA2)					

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (in-game) ==== 			-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when in-game
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileInGame
					PAL:	A:0xX00965c20+0xX00965c88_A:0xX00965c54_A:0xX00965d4c+0xX00965db4_K:0xX00965d80_K:{recall}/f1.0_A:0xX00965c24/{recall}_A:0xX00965c8c/{recall}_A:0xX00965c58/{recall}_A:0xX00965d50/{recall}_A:0xX00965db8/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					NTSCU:	A:0xX00953c40+0xX00953ca8_A:0xX00953c74_A:0xX00953d6c+0xX00953dd4_K:0xX00953da0_K:{recall}/f1.0_A:0xX00953c44/{recall}_A:0xX00953cac/{recall}_A:0xX00953c78/{recall}_A:0xX00953d70/{recall}_A:0xX00953dd8/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
					----------
						AddSource	[ShotsFired_Temp(PLAYER_1)] + [ShotsFired_ChapterSection(PLAYER_1)]
						AddSource	[ShotsFired_ChapterTotal(PLAYER_1)] 
						AddSource	[ShotsFired_Temp(PLAYER_2)] + [ShotsFired_ChapterSection(PLAYER_2)]
						Remember	[ShotsFired_ChapterTotal(PLAYER_2)] 
						Remember	Recall / 1.0						--> Force 32-bit to Float
						AddSource	[ShotsHit_Temp(PLAYER_1)] / Recall
						AddSource	[ShotsHit_ChapterSection(PLAYER_1)] / Recall
						AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
						AddSource	[ShotsHit_Temp(PLAYER_2)] / Recall
						AddSource	[ShotsHit_ChapterSection(PLAYER_2)] / Recall
						Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
						Remember	Recall * 100.0
						Measured	Recall == 100.0
						*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_Temp(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")				
		// [3/14] ==== Alt Measured Group (NOT in-game) ==== 		-> Group is only responsible for displaying a Measured Indicator for combined accuacy % when not in-game (during loading)
			/* MANUAL_CONSTRUCTION[CAA1-CAA0]:MeasuredCombinedAccuracy_WhileNotInGame
				PAL:	K:0xX00965c54+0xX00965d80_K:{recall}/f1.0_A:0xX00965c58/{recall}_K:0xX00965d84/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	K:0xX00953c74+0xX00953da0_K:{recall}/f1.0_A:0xX00953c78/{recall}_K:0xX00953da4/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				----------
					Remember	[ShotsFired_ChapterTotal(PLAYER_1)] + [ShotsFired_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0		--> Force 32-bit to Float
					AddSource	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
					Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA1)
			&& measured(				
				current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xCAA0)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player activates more than 1 distinct power, by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(tally_of(CONST_POWER_DATA, const_ALLOWED_DISTINCT_POWERS + 1, enum_power =>  // --Lockout--> When PLAYER_1 actiavted too many different powers
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_1, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))
				))
			&& never(tally_of(CONST_POWER_DATA, const_ALLOWED_DISTINCT_POWERS + 1, enum_power =>  // --Lockout--> When PLAYER_2 actiavted too many different powers
				once(
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& is_PowerIconTopLeft(PLAYER_2, enum_power, enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_2, enum_releaseRegion))
				))
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgRightTrain": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_15_RightTrain
		const_TIME_LIMIT = 420000 // 420.000 ms = 7 min
		const_HP_THRESHOLD = CONST_PLAYER_MAX_HP * 0.7 // % of max HP

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)				

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ==== 		-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_true()
			/* MANUAL_CONSTRUCTION[AA01-AA02]:MeasuredTimeWhileInGame (below Measured) - R/R usage
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
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_Temp(enum_releaseRegion) 
				+ current_MissionTime_ChapterSection(enum_releaseRegion) 
				+ current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA02)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> This group is only responsible for displaying a Measured Indicator for seconds left within time limit, while is_flagState_InGame_false()
			/* MANUAL_CONSTRUCTION[AA01-AA03]:MeasuredTimeWhileNotInGame (below Measured) - R/R usage 
				// WARNING - Edit const_TIME_LIMIT
				PAL:	K:0xX00965c3c/f1000.0_A:f420.0-{recall}_M:0=f420.0
				NTSCU:	K:0xX00953c5c/f1000.0_A:f420.0-{recall}_M:0=f420.0
				''''''''''''''
				Remember	[32-bit:MissionTime_ChapterTotal] / 1000.0					| current_MissionTime_ChapterTotal() in seconds
				AddSource	(const_TIME_LIMIT/1000) - Recall
				Measured	Val 0 == (const_TIME_LIMIT/1000) 		*/
			|| memUtil_ManualConstruction_PlaceHolderRequirement(0xAA01)
			&& measured(
				current_MissionTime_ChapterTotal(enum_releaseRegion) == const_TIME_LIMIT / 1000,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xAA03)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)
			&& trigger_when(always_false())
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement on challenge fail by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When calculated_TotalMissionTime() overflow occurs; 0xFFFFFFFF (= 1193 hours)
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& on_calculated_TotalMissionTime_whileInGame_overflow(enum_releaseRegion))
			&& never( // --Lockout--> MissionTime exceeds time limit
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagState_InGame_true(enum_releaseRegion)
				&& current_calculated_TotalMissionTime_whileInGame(enum_releaseRegion) > const_TIME_LIMIT)
			&& never(// --Lockout--> When PLAYER_1 goes below xx% HP
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_1, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_1, enum_releaseRegion) >= const_HP_THRESHOLD)
			&& never(// --Lockout--> When PLAYER_2 goes below xx% HP
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_Player_HP(PLAYER_2, enum_releaseRegion) < const_HP_THRESHOLD
				&& prev_Player_HP(PLAYER_2, enum_releaseRegion) >= const_HP_THRESHOLD)
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgDeadfall": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (5x) MANUAL_CONSTRUCTION (AltGroups[1+2+3+10+11])
		const_CHAPTER = CHAPTER_16_Deadfall
		const_WEAPON_A = WEAPON_RangeRifle
		const_WEAPON_B = WEAPON_Carbine
		const_MIN_REQUIRED_HEADSHOT_KILLS = 0.3 // percent

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(const_CHAPTER)
		return
		// [1/12] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.07_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.07_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.07_A:0xX00965d7c/{recall}_N:f0.0>=f0.07
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.07_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.07_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.07_A:0xX00953d9c/{recall}_N:f0.0>=f0.07
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							---------Participation Tracking (Kills)---------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0								--> Force 32-bit to Float
							AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)	
				
					/* MANUAL_CONSTRUCTION[BC10-BC17]:CheckHeadshotKillsRatioAchieved (below 3 lines) - R/R usage 
						PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c5c/{recall}_K:0xX00965d88/{recall}_N:{recall}>=f0.3
						NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c7c/{recall}_K:0xX00953da8/{recall}_N:{recall}>=f0.3
						-----------
							Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
							Remember	Recall / 1.0		--> Force 32-bit to Float
							AddSource	[HeadshotKills_ChapterTotal(PLAYER_1)] / Recall
							Remember	[HeadshotKills_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= const_MIN_REQUIRED_HEADSHOT_KILLS
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC10)
					&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
						+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
						+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= const_MIN_REQUIRED_HEADSHOT_KILLS
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xBC17)			

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/13] ==== Alt Measured Group (In-Game) ====		-> Group is only responsible for displaying a Measured Indicator for kills to headshotKills ratio % - When in-game
			|| /* MANUAL_CONSTRUCTION[BC11-BC12]:MeasuredHeadshotKillsRatioWhileInGame (below Measured) - R/R usage
				PAL:	A:0xX00965c1c_A:0xX00965c84+0xX00965c50_A:0xX00965d48_K:0xX00965db0+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c28/{recall}_A:0xX00965c90/{recall}_A:0xX00965c5c/{recall}_A:0xX00965d54/{recall}_A:0xX00965dbc/{recall}_K:0xX00965d88/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	A:0xX00953c3c_A:0xX00953ca4+0xX00953c70_A:0xX00953d68_K:0xX00953dd0+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c48/{recall}_A:0xX00953cb0/{recall}_A:0xX00953c7c/{recall}_A:0xX00953d74/{recall}_A:0xX00953ddc/{recall}_K:0xX00953da8/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					AddSource	[Kills_Temp(PLAYER_1)]
					AddSource	[Kills_ChapterSection(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_1)]
					AddSource	[Kills_Temp(PLAYER_2)]
					Remember	[Kills_ChapterSection(PLAYER_2)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0			--> Force 32-bit to Float
					AddSource	[HeadShotKills_Temp(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_ChapterSection(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_ChapterTotal(PLAYER_1)] / Recall
					AddSource	[HeadShotKills_Temp(PLAYER_2)] / Recall
					AddSource	[HeadShotKills_ChapterSection(PLAYER_2)] / Recall
					Remember	[HeadShotKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> Melee- and HeadshotKills to Kills Ratio %
				current_Kills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_Kills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_Temp(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterSection(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) 
				+ current_HeadshotKills_Temp(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_ChapterSection(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [3/14] ==== Alt Measured Group (Not In-Game) ==== 	-> Group is only responsible for displaying a Measured Indicator for kills to headshotKills ratio % - When not in-game
			|| /* MANUAL_CONSTRUCTION[BC11-BC13]:MeasuredHeadshotKillsRatioWhileNotInGame (below Measured) - R/R usage
				PAL:	K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c5c/{recall}_K:0xX00965d88/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				NTSCU:	K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c7c/{recall}_K:0xX00953da8/{recall}_K:{recall}*f100.0_M:{recall}=f100.0
				------------
					Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0			--> Force 32-bit to Float
					AddSource	[HeadshotKills_ChapterTotal(PLAYER_1)] / Recall
					Remember	[HeadshotKills_ChapterTotal(PLAYER_2)] / Recall
					Remember	Recall * 100.0
					Measured	Recall == 100.0
					*/
			memUtil_ManualConstruction_PlaceHolderRequirement(0xBC11)
			&& measured( // --Measured--> Melee- and HeadshotKills to Kills Ratio %
				current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion)
				+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) == 100.0,
				when = 
					memUtil_ManualConstruction_PlaceHolderRequirement(0xBC13)
					&& is_ReleaseRegion(enum_releaseRegion)
					&& is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --CheckIf--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion)),
				format = "percent")
			&& memUtil_alwaysFalse(enum_releaseRegion)
		// [4/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player scores a kill without a required weapon equipped, by Resetting HitCount on [StartCondition]
			|| never( // --Lockout--> When PLAYER_1 scores a kill without a required weapon equipped
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_1, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_1, enum_releaseRegion))
			&& never( // --Lockout--> When PLAYER_2 scores a kill without a required weapon equipped
				is_ReleaseRegion(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_2, const_WEAPON_A, enum_releaseRegion)
				&& !is_EquippedWeapon(PLAYER_2, const_WEAPON_B, enum_releaseRegion)
				&& on_Kills_Temp_increment(PLAYER_2, enum_releaseRegion))
			&& always_false()
		// [5/16] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [6/17] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [7+..+10+11/18+..+21+22] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart || on PauseMenu->Quit
			/* MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart (AltGroup[9/19])
				- NOTE: MANUAL_CONSTRUCTION[FD1-FD2]:ResetOn_PauseMenu_Restart must reset not only for ChapterSection_1 but during all ChapterSections (for this Achievement; because of MeasuredKillCount)
				
				PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._Z:0xX00965cc4!=0_N:0xX00965cc4=0_C:d0xX00965cc4!=0.1._Z:0xX00965df0!=0_N:0xX00965df0=0_C:d0xX00965df0!=0.1._R:0=1.3._0=1
				NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c!=870403064_N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=870403064_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._Z:0xX00953ce4!=0_N:0xX00953ce4=0_C:d0xX00953ce4!=0.1._Z:0xX00953e10!=0_N:0xX00953e10=0_C:d0xX00953e10!=0.1._R:0=1.3._0=1
				*/	
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	"a_ClgCurseWest": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (3x) MANUAL_CONSTRUCTION (AltGroups[1+8+9])
		const_CHAPTER = CHAPTER_17_CurseWest
		const_ALLOWED_POWER_USAGE_COUNT = 7

		PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
		PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)
		return
		// [1/11] ==== Alt Logic + Trigger Group ==== 		-> Group is responsible for unlocking the achievement + Display Trigger Indicator whilst Participation Tracking is OK && Challenge OK
			unless(!is_ReleaseRegion(enum_releaseRegion))

			// -------- Core Logic --------
			&& once( // --CheckIf--[StartCondition]--> Chapter has started from the beginning (StoryChapterSection_1) + Difficulty Deadeye
				is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
				&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))

			// -------- Trigger Indicator --------		
			&& trigger_when(
				once( // --CheckIf--> The last StoryChapterSection of the Level has started
					on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
					never(is_flagState_InGame_true(enum_releaseRegion))

					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

					/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracy
						// WARNING: Edit in PARTICIPATION_TRACKING values
						PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.06_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.06
						NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.06_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.06
						----------
							---------Participation Tracking (Accuracy)---------
							Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

							Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
							Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
							AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent
							*/
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
					&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
					&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& on_flagState_InGame_toggleFalse(enum_releaseRegion))
				&& repeated(2, // --CheckIf--> The last StoryChapterSection of the Level has ended for xx frames
					never(is_flagState_InGame_true(enum_releaseRegion))
					&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
					&& wasPrior_flagState_InGame_true(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion))

				// -------- Participation Tracking (Inputs) --------
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_1 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_1, enum_releaseRegion))
				&& repeated(PARTICIPATION_TRACKING_MinRequiredInputs, // --CheckIf--> PLAYER_2 has executed enough inputs while in-game (eg. firing gun, movement, using powers) 
					!is_AnyCinematic_active(enum_releaseRegion)
					&& !is_AnyInGameMenu_active(enum_releaseRegion)
					&& is_flagState_InGame_true(enum_releaseRegion)
					&& on_PlayerInput_anyGameplayInputUse(PLAYER_2, enum_releaseRegion))

				// -------- (Last) Requirements for Unlock --------
				&& on_Loading_start(enum_releaseRegion)
				)
		// [2/12] ==== Alt Measured Group ==== 		-> Group is only responsible for displaying a Measured Indicator, tracking power activations left to use
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& measured(tally(const_ALLOWED_POWER_USAGE_COUNT , [ 
				repeated(const_ALLOWED_POWER_USAGE_COUNT, always_true()), // --AddHits--> Up to const_ALLOWED_POWER_USAGE_COUNT
				deduct(repeated(const_ALLOWED_POWER_USAGE_COUNT, // --SubHit--> when PLAYER_1 uses a power 
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion))),
				deduct(repeated(const_ALLOWED_POWER_USAGE_COUNT, // --SubHit--> when PLAYER_2 uses a power 
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_2, enum_releaseRegion))),
				]),
				when = 
					is_InMultiplayerCoopMode(enum_releaseRegion)
					&& is_flagState_InGame_false(enum_releaseRegion)
					&& once( // --MeasuredIf--[StartCondition]--> Gunslinger Level/Chapter is started from beginning + Difficulty Deadeye
						is_DifficultyOrHarder(DIFFICULTY_Deadeye, enum_releaseRegion)
						&& on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
				)	
			&& trigger_when(always_false())
		// [3/13] ==== Alt Lockout Group ==== 		-> Lockout achievement when too many powers have been activated, by Resetting HitCount on [StartCondition]
			|| unless(!is_ReleaseRegion(enum_releaseRegion))
			&& never(tally(const_ALLOWED_POWER_USAGE_COUNT + 1, [ // --Lockout--> When powers have been activated too many times
				repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --AddHit--> when PLAYER_1 uses a power 
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_1, enum_releaseRegion)),
				repeated(const_ALLOWED_POWER_USAGE_COUNT + 1, // --AddHit--> when PLAYER_2 uses a power 
					is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
					&& on_Player_Power_use(PLAYER_2, enum_releaseRegion)),
				]))	
			&& always_false()
		// [4/14] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player dies, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_PlayerDeath(enum_releaseRegion)
		// [5/15] ==== Alt Lockout Group ==== 		-> Lockout achievement when one player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
			|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
		// [6+..+9+10/16+..+19+20] ==== 5x Alt Reset Groups ==== 	-> Reset when not in Multiplayer Coop || when LevelID is incorrect || when at MainMenu || on PauseMenu->Restart when at ChapterSection_1 || on PauseMenu->Quit
			|| achGenerate_5x_AltResetGroups_ChapterProgression(const_CHAPTER, enum_releaseRegion) // --> (2x) MANUAL_CONSTRUCTION
		}),
	// ----------------c_Bonus----------------
	"a_MultiKillers": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			is_ReleaseRegion(enum_releaseRegion)
			&& always_false()),
	"a_SunHi": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			is_ReleaseRegion(enum_releaseRegion)
			&& always_false()),
	"a_AllEvil": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[1])
		const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower = TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_SoulStealer
		return		
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			/* MANUAL_CONSTRUCTION:CheckNewPowerUnlock (AltGroup[1/2])
				PAL:	P:0xX007215cc!=1397050451_P:0xL00911474!=2_P:0xL009114f0!=0_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00965cc4!=0_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=3965834464.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
				NTSCU:	P:0xX0071fccc!=1398099027_P:0xL008ff494!=2_P:0xL008ff510!=0_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00953ce4!=0_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=3965834464.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
				------
					PauseIf 	!is_ReleaseRegion(enum_releaseRegion)
					PauseIf 	!is_InMultiplayerCoopMode(enum_releaseRegion)

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


					// -----------------------Trigger (on NewPowerMenu close)-----------------------
					AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
					AddAddress	->[Mem 32-bit] 0xB8
					Trigger		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower 			| CheckIf: MEM FrameTitle != "New Power"	
					
					AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
					AddAddress	->[Mem 32-bit] 0xB8
					Trigger		->[Delta 32-bit] 0x6C == TEXTLOOKUPKEY_NewPowerMenu_FrameTitle_NewPower  		| CheckIf: DELTA FrameTitle == "New Power"				
					*/
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion))
			&& once(
				is_flagState_InGame_true(enum_releaseRegion)
				&& is_NewPowerMenu_Power(const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower, enum_releaseRegion)
				&& dword(0xDEADBEEF) == const_NEWPOWERMENU_TEXTLOOKUPKEY_LastEvilPower
				)
			&& trigger_when(on_NewPowerMenu_close(enum_releaseRegion))
		}),
	"a_AllGood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[1])
		const_NEWPOWERMENU_TEXTLOOKUPKEY_LastGoodPower = TEXTLOOKUPKEY_NewPowerMenu_MsgBoxText_Vindicator
		return
		// [1/2] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			/* MANUAL_CONSTRUCTION:CheckNewPowerUnlock (AltGroup[1/2])
				PAL:	P:0xX007215cc!=1397050451_P:0xL00911474!=2_P:0xL009114f0!=0_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00965cc4!=0_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=1995014642.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
				NTSCU:	P:0xX0071fccc!=1398099027_P:0xL008ff494!=2_P:0xL008ff510!=0_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_R:p0xX0000006c=2662373993.2._N:0xX00953ce4!=0_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2662373993_I:{recall}_I:0xX000000b8_N:d0xX0000006c!=2662373993_I:{recall}_I:0xX0000000c_I:0xX00000004_0xX00000048=1995014642.1._I:{recall}_I:0xX000000b8_T:0xX0000006c!=2662373993_I:{recall}_I:0xX000000b8_T:d0xX0000006c=2662373993
				*/	
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_InMultiplayerCoopMode(enum_releaseRegion))
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
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	// ----------------c_Misc----------------
	"a_INFOcoop":		{"en": "Info — Coop Participation Tracking"},
	// ----------------c_Story----------------
	"a_WrongTrain":		{"en": "Partners in Derailment"},
	"a_RideDevil":		{"en": "Dust at the Devil"},
	"a_Boneyard":		{"en": "Among the Graves"},
	"a_DevilMine":		{"en": "Smoke in the Veins"},
	"a_DWOutpost":		{"en": "Backs to the Walls"},
	"a_WarTrain":		{"en": "Demon on Rails"},
	"a_TortureMaze":	{"en": "Brothers in the Blood Maze"},
	"a_BaptismFire":	{"en": "Anointed in Ash"},
	"a_Rescue":			{"en": "Not a Drop Between Us"},
	"a_Prism":			{"en": "Shared Light, Split Shadows"},
	"a_Invasion":		{"en": "No Land for the Dead"},
	"a_Hangtown":		{"en": "Gallows Don't Swing Alone"},
	"a_MorningAfter":	{"en": "Ashes of the Order"},
	"a_Showdown":		{"en": "Devil Be Gunned"},
	"a_RightTrain":		{"en": "Two Tickets to Perdition"},
	"a_Deadfall":		{"en": "Devil's Hollow"},
	// ----------------c_StoryEnd----------------
	"a_CurseWestGood":		{"en": "The Light Between"},
	"a_CurseWestEvil":		{"en": "The Sovereigns Within"},
	// ----------------c_Challenge----------------
	"a_ClgWrongTrain":		{"en": "Bullet Ballet"},
	"a_ClgRideDevil":		{"en": "Rails and Ricochets"},
	"a_ClgBoneyard":		{"en": "Silver and Ash"},
	"a_ClgDevilMine":		{"en": "Twin Barrels Through the Dark"},
	"a_ClgDWOutpost":		{"en": "Rally of Bloodlust"},
	"a_ClgWarTrain":		{"en": "Ghosts on the Rails"},
	"a_ClgTortureMaze":		{"en": "Bullet and Stave"},
	"a_ClgBaptismFire":		{"en": "Anointed in Gunpowder"},
	"a_ClgRescue":			{"en": "Scarlet Scurry"},
	"a_ClgPrism":			{"en": "Vestige of Potency"},
	"a_ClgInvasion":		{"en": "No Breathing Room"},
	"a_ClgHangtown":		{"en": "Hanging in the Crosshairs"},
	"a_ClgMorningAfter":	{"en": "Ashes in Their Wake"},
	"a_ClgShowdown":		{"en": "Contingency in Sanguinity"},
	"a_ClgRightTrain":		{"en": "Steamed Haste"},
	"a_ClgDeadfall":		{"en": "Sizzling Precision"},
	"a_ClgCurseWest":		{"en": "Saviors or Sinners"},
	// ----------------c_Bonus----------------
	"a_MultiKillers":	{"en": "xxxxxxxxx"},
	"a_SunHi":			{"en": "xxxxxxxxx"},
	"a_AllEvil":		{"en": "Grim Alliance"},
	"a_AllGood":		{"en": "Righteous Tandem"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	// ----------------c_Misc----------------
	"a_INFOcoop":		{"en": "No freeloaders in this posse! Achievements require \"active\" participation of both players. If one player slacks or is not engaging with combat, achievements of the current Chapter will be disabled. See RAguide for details on participation tracking"},
	// ----------------c_Story----------------
	"a_WrongTrain":		{"en": "You planned a heist, not a reckoning—now it's two guns against the darkness. Complete Chapter 1, \"The Wrong Train\", from start to finish in one session"},
	"a_RideDevil":		{"en": "The Reaper's breathing down both your necks—and the only way out is forward. Complete Chapter 2, \"Ride Like the Devil\", from start to finish in one session"},
	"a_Boneyard":		{"en": "The dead don't take kindly to visitors, but you came packing iron. Complete Chapter 3, \"Boneyard\", from start to finish in one session"},
	"a_DevilMine":		{"en": "Two guns, one way through the fog and blood. Complete Chapter 4, \"Devil's Belly Mine\", from start to finish in one session"},
	"a_DWOutpost":		{"en": "It was supposed to be a refuge. Now it's just the place where legends are born—or buried. Complete Chapter 5, \"Darkwatch Outpost\", from start to finish in one session"},
	"a_WarTrain":		{"en": "This beast ain't slowing down—and neither are you. Complete Chapter 6, \"War Train\", from start to finish in one session"},
	"a_TortureMaze":	{"en": "You'll need grit, guts, and each other to claw out of Cartwright's killing grounds. Complete Chapter 7, \"Torture Maze\", from start to finish in one session"},
	"a_BaptismFire":	{"en": "Welcome to the Darkwatch baptism—fire, steel, and no room for hesitation. Complete Chapter 8, \"Baptism of Fire\", from start to finish in one session"},
	"a_Rescue":			{"en": "They were left to rot, but not with you two around. Complete Chapter 9, \"Rescue\", from start to finish in one session"},
	"a_Prism":			{"en": "No monster should wield it. But two might just survive it. Complete Chapter 10, \"The Deadlight Prism\", from start to finish in one session"},
	"a_Invasion":		{"en": "This land ain't theirs to take, and together, you'll prove it. Complete Chapter 11, \"Invasion\", from start to finish in one session"},
	"a_Hangtown":		{"en": "The gallows creak, the dead rise—but you're no strangers to final stands. Complete Chapter 12, \"Hangtown\", from start to finish in one session"},
	"a_MorningAfter":	{"en": "The order fell overnight. Now it's up to two blades in the dark to carry the flame. Complete Chapter 13, \"The Morning After\", from start to finish in one session"},
	"a_Showdown":		{"en": "The devil's still breathing. Two guns, one shot to end it. Complete Chapter 14, \"Showdown\", from start to finish in one session"},
	"a_RightTrain":		{"en": "No brakes. No backup. Just two souls strapped to a metal monster bound for hell. Complete Chapter 15, \"The Right Train\", from start to finish in one session"},
	"a_Deadfall":		{"en": "Hell came to the city, but it found the wrong pair to mess with. Complete Chapter 16, \"Deadfall\", from start to finish in one session"},
	// ----------------c_StoryEnd----------------
	"a_CurseWestGood":		{"en": "The curse is broken, the West breathes again. Two guns rode through hell to see the dawn. Complete Chapter 17, \"Curse of the West\", from start to finish in one session and achieve the good ending"},
	"a_CurseWestEvil":		{"en": "No gods. No rules. Just two devils left standing. Complete Chapter 17, \"Curse of the West\", from start to finish in one session and achieve the evil ending"},
	// ----------------c_Challenge----------------
	"a_ClgWrongTrain":		{"en": "What started as a score turned into a sentence. Only grit and lead will get you both out. Complete Chapter 1, \"The Wrong Train\", from start to finish in one session on Deadeye difficulty, with no deaths, and a minimum combined accuracy of 70%"},
	"a_ClgRideDevil":		{"en": "Death rides your tail and mercy ain't waiting. Complete Chapter 2, \"Ride Like the Devil\", from start to finish in one session on Deadeye difficulty, with no deaths, and without the player's combined HP dropping below 50%"},
	"a_ClgBoneyard":		{"en": "Iron and grit against the dead. Complete Chapter 3, \"Boneyard\", from start to finish in one session on Deadeye difficulty, with no deaths, achieving at least 100 kills using the Carbine or Crossbow, and without using any throwable explosives"},
	"a_ClgDevilMine":		{"en": "Fire and grit in the dark. Complete Chapter 4, \"Devil's Belly Mine\", from start to finish in one session on Deadeye difficulty, with no deaths, no powers, no throwable explosives, and with one player only using pistols and the other only 2-handed weapons"},
	"a_ClgDWOutpost":		{"en": "Not even death cracks true steel. Complete Chapter 5, \"Darkwatch Outpost\", from start to finish in one session on Deadeye difficulty, with no deaths, and where the player's combined HP is never below max HP for more than 30 seconds consecutively"},
	"a_ClgWarTrain":		{"en": "Two phantoms ride, no blood left behind. Complete Chapter 6, \"War Train\", from start to finish in one session on Deadeye difficulty, within 5 minutes, no deaths, and without either player taking any HP loss"},
	"a_ClgTortureMaze":		{"en": "One strikes, one shoots, both survive. Complete Chapter 7, \"Torture Maze\", from start to finish in one session on Deadeye difficulty, with no deaths, at least 60% melee kills, and with one player only using melee and the other only shooting"},
	"a_ClgBaptismFire":		{"en": "No cowards in the fire. Complete Chapter 8, \"Baptism of Fire\", from start to finish in one session on Deadeye difficulty, with no deaths, achieving at least 80 kills using the Redeemer or Rail Rocket, without using any throwable explosives"},
	"a_ClgRescue":			{"en": "No one gets left behind. Complete Chapter 9, \"Rescue\", from start to finish in one session on Deadeye difficulty, within 10 minutes, no deaths, and without either player dropping below 25% HP"},
	"a_ClgPrism":			{"en": "Power corrupts, but teamwork endures. Complete Chapter 10, \"The Deadlight Prism\", from start to finish in one session on Deadeye difficulty, with no deaths, where each player can only use each power once"},
	"a_ClgInvasion":		{"en": "Two barrels, close and personal. Complete Chapter 11, \"Invasion\", from start to finish in one session on Deadeye difficulty, with no deaths, killing only with the Dual Pistols or Shotgun, and without using any throwable explosives"},
	"a_ClgHangtown":		{"en": "It's a tightrope walk in a noose. Complete Chapter 12, \"Hangtown\", from start to finish in one session on Deadeye difficulty, with no deaths, shooting only with the Range Rifle to acquire a minimum combined accuracy of 75%"},
	"a_ClgMorningAfter":	{"en": "Darkness rises, but two sparks remain. Complete Chapter 13, \"The Morning After\", from start to finish in one session on Deadeye difficulty, with no deaths, using only tier 2 or 3 powers, and with at least 40% headshot or melee kills"},
	"a_ClgShowdown":		{"en": "No mercy left to give. Complete Chapter 14, \"Showdown\", from start to finish in one session on Deadeye difficulty, with no deaths, where each player can only use one distinct power, and reaching a minimum combined accuracy of 65%"},
	"a_ClgRightTrain":		{"en": "No slowing, no bleeding. Complete Chapter 15, \"The Right Train\", from start to finish in one session on Deadeye difficulty, within 7 minutes, no deaths, and without any player dropping below 70% HP"},
	"a_ClgDeadfall":		{"en": "Fire and ruin can't stop a deadeye's aim. Complete Chapter 16, \"Deadfall\", from start to finish in one session on Deadeye difficulty, with no deaths, killing only with the Range Rifle or Carbine, and with at least 30% headshot kills"},
	"a_ClgCurseWest":		{"en": "Two against the dying light. Complete Chapter 17, \"Curse of the West\", from start to finish in one session on Deadeye difficulty, with no deaths, and with only 7 allowed power activations"},
	// ----------------c_Bonus----------------
	"a_MultiKillers":	{"en": "xxxxxxxxx"},
	"a_SunHi":			{"en": "xxxxxxxxx"},
	"a_AllEvil":		{"en": "You didn't just walk the path of corruption—you became it, together by unlocking all Evil powers"},
	"a_AllGood":		{"en": "From ash and ruin, two rose in unshakable resolve by unlocking all Good powers"},
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
//								(copy of rich presence script from BaseSet)								 \\
// ***************************************************************************************************** \\
// #region RICH PRESENCE
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
	// "lb_WatchersWrongTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130378, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_1_WrongTrain, from start to finish (single session)"},
	// "lb_WatchersRideDevil": { // QA  // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130373, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_2_RideDevil, from start to finish (single session)"},
	// "lb_WatchersBoneyard": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130364, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_3_Boneyard, from start to finish (single session)"},
	// "lb_WatchersDevilMine": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130367, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_4_DevilMine, from start to finish (single session)"},
	// "lb_WatchersDWOutpost": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130365, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_5_Outpost, from start to finish (single session)"},
	// "lb_WatchersWarTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130377, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_6_WarTrain, from start to finish (single session)"},
	// "lb_WatchersTortureMaze": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130376, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_7_TortureMaze, from start to finish (single session)"},
	// "lb_WatchersBaptismFire": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130138, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_8_BaptismFire, from start to finish (single session)"},
	// "lb_WatchersRescue": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130372, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_9_Rescue, from start to finish (single session)"},
	// "lb_WatchersPrism": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130371, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_10_Prism, from start to finish (single session)"},
	// "lb_WatchersInvasion": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130369, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_11_Invasion, from start to finish (single session)"},
	// "lb_WatchersHangtown": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130368, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_12_Hangtown, from start to finish (single session)"},
	// "lb_WatchersMorningAfter": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130370, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_13_MorningAfter, from start to finish (single session)"},
	// "lb_WatchersShowdown": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130375, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_14_Showdown, from start to finish (single session)"},
	// "lb_WatchersRightTrain": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130374, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_15_RightTrain, from start to finish (single session)"},
	// "lb_WatchersDeadfall": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130366, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_16_Deadfall, from start to finish (single session)"},	
	// "lb_WatchersCurseWest": { // QA // DISABLED - MANUAL_CONSTRUCTION (CANCEL,SUBMIT,VALUEMEASURE)
		// "id": 130363, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "Complete CHAPTER_17_CurseWest, from start to finish (single session)"},
	
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
		&& is_InMultiplayerCoopMode(enum_releaseRegion)
		&& is_flagState_InGame_true(enum_releaseRegion)
		&& on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion)

function lbGenerate_FullCancelTrigger_ChapterCompletion(enum_chapter, enum_releaseRegion) { // WARNING - (1x) MANUAL_CONSTRUCTION (AltGroup[6])
	PARTICIPATION_TRACKING_MaxInactiveSeconds = PARTICIPATION_TRACKING_DATA_getMaxInactiveSeconds(enum_chapter)
	return 	
	// [1] ==== Alt Cancel Group ====		-> Cancel when LevelID is incorrect
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion)
	// [2] ==== Alt Cancel Group ==== 		-> Cancel when not in Multiplayer Coop Mode
		|| is_ReleaseRegion(enum_releaseRegion)
		&& !is_InMultiplayerCoopMode(enum_releaseRegion)
	// [3] ==== Alt Cancel Group ==== 		-> Cancel MissionTime_ChapterTotal exceeds LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
		|| is_ReleaseRegion(enum_releaseRegion)
		&& current_MissionTime_ChapterTotal(enum_releaseRegion) > LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
		&& prev_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
	// [4] ==== Alt Cancel Group ==== 		-> Cancel when PLAYER_1 is inactive for xx seconds conesutively
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& never(  // --ResetIf--> when Chapter begins from ChapterSection 1 (identical to START)
			is_ReleaseRegion(enum_releaseRegion)
			&& is_InMultiplayerCoopMode(enum_releaseRegion)
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& repeated(PARTICIPATION_TRACKING_MaxInactiveSeconds, // --CheckIf--> PLAYER_1 is inactive for xx seconds conesutively
			never( // --ResetNextIf--> when PLAYER_1 uses any input while in-game || when loading another ChapterSection || when PauseMenu->Restart
				is_flagStates_BothPlayers_InGame_false(enum_releaseRegion) // --2 Lines--> When loading another ChapterSection || when PauseMenu->Restart
				|| is_flagState_InGame_true(enum_releaseRegion) // --4 Lines--> when PLAYER_1 uses any input while in-game
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& on_PlayerInput_anyInputUse(PLAYER_1, enum_releaseRegion)) 
			// && !is_AnyInGameMenu_active(enum_releaseRegion) // DISABLED - Unnecessary as [MissionTime_Temp] only increments while the PauseMenu is inactive
			&& !is_AnyCinematic_active(enum_releaseRegion)
			&& current_Player_HP(PLAYER_1, enum_releaseRegion) > 0.0  // --CheckIf--> Not in respawn screen (otherwise keeps counting when dead) 
			&& on_MissionTime_Temp_secondPassed(enum_releaseRegion))			
	// [5] ==== Alt Cancel Group ==== 		-> Cancel when PLAYER_2 is inactive for xx seconds conesutively
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& never(  // --ResetIf--> when Chapter begins from ChapterSection 1 (identical to START)
			is_ReleaseRegion(enum_releaseRegion)
			&& is_InMultiplayerCoopMode(enum_releaseRegion)
			&& is_flagState_InGame_true(enum_releaseRegion)
			&& on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& repeated(PARTICIPATION_TRACKING_MaxInactiveSeconds, // --CheckIf--> PLAYER_2 is inactive for xx seconds conesutively
			never( // --ResetNextIf--> when PLAYER_2 uses any input while in-game || when loading another ChapterSection || when PauseMenu->Restart
				is_flagStates_BothPlayers_InGame_false(enum_releaseRegion) // --2 Lines--> When loading another ChapterSection || when PauseMenu->Restart
				|| is_flagState_InGame_true(enum_releaseRegion) // --4 Lines--> when PLAYER_2 uses any input while in-game
				&& !is_AnyCinematic_active(enum_releaseRegion)
				&& !is_AnyInGameMenu_active(enum_releaseRegion)
				&& on_PlayerInput_anyInputUse(PLAYER_2, enum_releaseRegion)) 
			// && !is_AnyInGameMenu_active(enum_releaseRegion) // DISABLED - Unnecessary as [MissionTime_Temp] only increments while the PauseMenu is inactive
			&& !is_AnyCinematic_active(enum_releaseRegion)
			&& current_Player_HP(PLAYER_2, enum_releaseRegion) > 0.0 // --CheckIf--> Not in respawn screen (otherwise keeps counting when dead) 
			&& on_MissionTime_Temp_secondPassed(enum_releaseRegion))
	// [6/13] ==== Alt Cancel Group ====		-> Cancel on PauseMenu->Quit
		/* MANUAL_CONSTRUCTION[FD1-FD3]:CancelOn_PauseMenu_Quit (AltGroup[6]) - R/R usage
		PAL: 	P:0xX007215cc!=1397050451_I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._I:0xX007238b8_Z:0xL00000008!=0_I:0xX007238b8_N:0xL00000008=0_I:0xX007238b8_C:d0xL00000008!=0.1._0=1.2.
		NTSCU: 	P:0xX0071fccc!=1398099027_I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._I:0xX00721fb8_Z:0xL00000008!=0_I:0xX00721fb8_N:0xL00000008=0_I:0xX00721fb8_C:d0xL00000008!=0.1._0=1.2.
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


			=============CONTROLLER_1 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


			=============Effectively Quit (check)=============
			---------ResetNextIf_B--------- (-> when pressing Quit, [Lower4:ActiveMenuPointerIndex] becomes 0, the next frame)
			ResetNextIf	Mem [Lower4:ActiveMenuPointerIndex] != 0x0 			| ResetNextIf: [Lower4:ActiveMenuPointerIndex] != 0
			---------AddHit_B--------
			AndNext		Mem [Lower4:ActiveMenuPointerIndex] == 0x0		
			AddHits		Delta [Lower4:ActiveMenuPointerIndex] != 0x0	(1)		| CheckIf: [Lower4:ActiveMenuPointerIndex] turns 0

					Val 0x0 == Val 0x1		(2)		| CheckIf: (CONTROLLER_1 Quits OR CONTROLLER_2 Quits) AND CheckIf: Effectively Quit
					
					*/
		|| unless(!is_ReleaseRegion(enum_releaseRegion))
		&& once(on_PauseMenu_Quit(enum_releaseRegion)) // --> (1x) MANUAL_CONSTRUCTION[FD1-FD3]
	// [7] ==== Alt Reset Group ====		-> Reset when entering MainMenu (to reset HitCount in AltGroup[4], after PauseMenu->Quit)
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_MainMenu_enter(enum_releaseRegion))
	}
		
function lbGenerate_FullSubmitTrigger_ChapterCompletion(enum_chapter, enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[1+5])
	/* NOTE: 
		- In Single Player OR MultiplayerCoop, the ChapterStats saved during gameplay are zeroed out when game saves them to [Array:SavedStats_Story]
		- HitCounts seperated into PLAYER_1 & PLAYER_2, because [Pointer(EntityData_B):PlayerActorData] don't change at same frame. to detect flagState_InGame
		*/
	PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(enum_chapter)
	PARTICIPATION_TRACKING_MinRequiredKillsPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredKillsPercent(enum_chapter)

	return
	// [1] ==== Alt Submit Group ====	-> Submit when Chapter was started from beginning AND finished, then submits on_Loading_start()
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_InMultiplayerCoopMode(enum_releaseRegion))
		&& once( // --CheckIf--[StartCondition]--> Chapter is started from beginning
			on_Chapter_startFromBeginning(enum_chapter, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(enum_chapter, enum_releaseRegion))
			
		// -----PLAYER_1 + TimeRequirement-----
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended + MissionTime does not exceed 7 hours
			never(is_flagState_1P_InGame_true(enum_releaseRegion))
			&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_1P_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_1P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_1P_InGame_true(enum_releaseRegion)
			&& is_flagState_1P_InGame_false(enum_releaseRegion))

		// -----PLAYER_2-----
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended
			never(is_flagState_2P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_2P_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_2P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& wasPrior_flagState_2P_InGame_true(enum_releaseRegion)
			&& is_flagState_2P_InGame_false(enum_releaseRegion))

		// -----Participation Tracking (Accuracy+Shots+Kills)-----
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
			&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

			/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
				// WARNING: Edit in PARTICIPATION_TRACKING values
				PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.05_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.05_K:0xX00965c50+0xX00965d7c_K:{recall}/f1.0_A:0xX00965c50/{recall}_N:f0.0>=f0.05_A:0xX00965d7c/{recall}_N:f0.0>=f0.05
				NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.05_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.05_K:0xX00953c70+0xX00953d9c_K:{recall}/f1.0_A:0xX00953c70/{recall}_N:f0.0>=f0.05_A:0xX00953d9c/{recall}_N:f0.0>=f0.05
				----------
					---------Participation Tracking (Accuracy)---------
					Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
					Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
					AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

					Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
					Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
					AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

					---------Participation Tracking (Kills)---------
					Remember	[Kills_ChapterTotal(PLAYER_1)] + [Kills_ChapterTotal(PLAYER_2)]
					Remember	Recall / 1.0								--> Force 32-bit to Float
					AddSource	[Kills_ChapterTotal(PLAYER_1)] / Recall
					AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
					AddSource	[Kills_ChapterTotal(PLAYER_2)] / Recall
					AndNext		0.0 >= PARTICIPATION_TRACKING_MinRequiredKillsPercent
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
			&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
			&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
			&& current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
			&& current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredKillsPercent * 100
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)		

			&& is_LastChapterSection_active(enum_chapter, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))

		// -----Last Requirement-----
		&& on_Loading_start(enum_releaseRegion)
	// [2] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(enum_chapter, enum_releaseRegion)
	// [3] ==== Alt Reset Group ====		-> Reset when LevelID is incorrect
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_LevelSubstring_StoryChapter(enum_chapter, enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 		-> Reset when not in Multiplayer Coop Mode
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InMultiplayerCoopMode(enum_releaseRegion))
	// [5] ==== Alt Reset Group ==== 		-> Reset on PauseMenu->Quit
		/* MANUAL_CONSTRUCTION[FD1-FD3]:ResetOn_PauseMenu_Quit (AltGroup[5]) - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._I:0xX007238b8_Z:0xL00000008!=0_I:0xX007238b8_N:0xL00000008=0_I:0xX007238b8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._I:0xX00721fb8_Z:0xL00000008!=0_I:0xX00721fb8_N:0xL00000008=0_I:0xX00721fb8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


			=============Effectively Quit (check)=============
			---------ResetNextIf_B--------- (-> when pressing Quit, [Lower4:ActiveMenuPointerIndex] becomes 0, the next frame)
			ResetNextIf	Mem [Lower4:ActiveMenuPointerIndex] != 0x0 			| ResetNextIf: [Lower4:ActiveMenuPointerIndex] != 0
			---------AddHit_B--------
			AndNext		Mem [Lower4:ActiveMenuPointerIndex] == 0x0		
			AddHits		Delta [Lower4:ActiveMenuPointerIndex] != 0x0	(1)		| CheckIf: [Lower4:ActiveMenuPointerIndex] turns 0

			ResetIf		Val 0x0 == Val 0x1		(2)		| CheckIf: (CONTROLLER_1 Quits OR CONTROLLER_2 Quits) AND CheckIf: Effectively Quit
			
						Val 0x0 == Val 0x1				| always_false() */
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion))
		}

function lbGenerate_FullSubmitTrigger_LastChapterCompletion(enum_releaseRegion) { // WARNING - (2x) MANUAL_CONSTRUCTION (AltGroup[1+4])
	/* NOTE: 
		- In Single Player OR MultiplayerCoop, the ChapterStats saved during gameplay are zeroed out when game saves them to [Array:SavedStats_Story]
		- HitCounts seperated into PLAYER_1 & PLAYER_2, because [Pointer(EntityData_B):PlayerActorData] don't change at same frame. to detect flagState_InGame
		*/
	const_CHAPTER = CHAPTER_17_CurseWest

	PARTICIPATION_TRACKING_MinRequiredInputs = PARTICIPATION_TRACKING_DATA_getMinRequiredInputs(const_CHAPTER)
	PARTICIPATION_TRACKING_MinRequiredShotsHit = PARTICIPATION_TRACKING_DATA_getMinRequiredShotsHit(const_CHAPTER)
	PARTICIPATION_TRACKING_MinRequiredAccuracyPercent = PARTICIPATION_TRACKING_DATA_getMinRequiredAccuracyPercent(const_CHAPTER)

	return
	// [1] ==== Alt Submit Group ====	-> Submit when Chapter was started from beginning AND finished, then submits on_Loading_start()
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_InMultiplayerCoopMode(enum_releaseRegion))
		&& once( // --CheckIf--> Chapter is started from beginning
			on_Chapter_startFromBeginning(const_CHAPTER, enum_releaseRegion))
		&& once( // --CheckIf--> LastChapterSection from the Chapter is started from beginning 
			on_LastChapterSection_startFromBeginning(const_CHAPTER, enum_releaseRegion))
			
		// -----PLAYER_1 + TimeRequirement-----
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended + MissionTime does not exceed 7 hours
			never(is_flagState_1P_InGame_true(enum_releaseRegion))
			&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime
			&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
			&& on_flagState_1P_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_1P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
			&& wasPrior_flagState_1P_InGame_true(enum_releaseRegion)
			&& is_flagState_1P_InGame_false(enum_releaseRegion))

		// -----PLAYER_2-----
		&& once( // --CheckIf--> LastChapterSection from the Chapter has ended
			never(is_flagState_2P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
			&& on_flagState_2P_InGame_toggleFalse(enum_releaseRegion))
		&& repeated(2, // --CheckIf--> LastChapterSection from the Chapter has ended for xx frames
			never(is_flagState_2P_InGame_true(enum_releaseRegion))
			&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
			&& wasPrior_flagState_2P_InGame_true(enum_releaseRegion)
			&& is_flagState_2P_InGame_false(enum_releaseRegion))

		// -----Participation Tracking (Accuracy+Shots+Kills)-----
		&& once( // --CheckIf--> The last StoryChapterSection of the Level has ended + Participation Tracking (Accuracy+Shots+Kills)
			never(is_flagState_InGame_true(enum_releaseRegion))

			&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit
			&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredShotsHit

			/* MANUAL_CONSTRUCTION[AC1-AC2]:ParticipationTrackingAccuracyAndKills
				// WARNING: Edit in PARTICIPATION_TRACKING values
				PAL:	K:0xX00965c54/f1.0_K:0xX00965c58/{recall}_N:{recall}>=f0.06_K:0xX00965d80/f1.0_K:0xX00965d84/{recall}_N:{recall}>=f0.06
				NTSCU:	K:0xX00953c74/f1.0_K:0xX00953c78/{recall}_N:{recall}>=f0.06_K:0xX00953da0/f1.0_K:0xX00953da4/{recall}_N:{recall}>=f0.06
				----------
					---------Participation Tracking (Accuracy)---------
					Remember	[ShotsFired_ChapterTotal(PLAYER_1)] / 1.0	--> Force 32-bit to Float
					Remember	[ShotsHit_ChapterTotal(PLAYER_1)] / Recall
					AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent

					Remember	[ShotsFired_ChapterTotal(PLAYER_2)] / 1.0	--> Force 32-bit to Float
					Remember	[ShotsHit_ChapterTotal(PLAYER_2)] / Recall
					AndNext		Recall >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent
					*/
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC1)
			&& current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
			&& current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) / current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) >= PARTICIPATION_TRACKING_MinRequiredAccuracyPercent * 100
			&& memUtil_ManualConstruction_PlaceHolderRequirement(0xAC2)

			&& is_LastChapterSection_active(const_CHAPTER, enum_releaseRegion)
			&& on_flagState_InGame_toggleFalse(enum_releaseRegion))

		// -----Last Requirement-----
		&& on_Loading_start(enum_releaseRegion)
	// [2] ==== Alt Lockout Group ==== 		-> Lockout achievement when any player is inactive for xx seconds conesutively, by Resetting HitCount on [StartCondition]
		|| achGenerate_LockoutGroup_ParticipationTrackingInactivity(const_CHAPTER, enum_releaseRegion)
	// [3] ==== Alt Reset Group ====		-> Reset when LevelID is incorrect
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_LevelSubstring_StoryChapter(const_CHAPTER, enum_releaseRegion))
	// [4] ==== Alt Reset Group ==== 		-> Reset when not in Multiplayer Coop Mode
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_InMultiplayerCoopMode(enum_releaseRegion))
	// [5] ==== Alt Reset Group ==== 		-> Reset on PauseMenu->Quit
		/* MANUAL_CONSTRUCTION[FD1-FD3]:ResetOn_PauseMenu_Quit (AltGroup[5]) - R/R usage
		PAL: 	I:0xX007238b8_K:0xL00000008-1_K:{recall}*4_I:0xX007238b8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX007215cc=1397050451_N:0xH0073b430=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00721900_C:0xM00000043>d0xM00000043.1._I:0xX007238b8_Z:0xL00000008!=0_I:0xX007238b8_N:0xL00000008=0_I:0xX007238b8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		NTSCU: 	I:0xX00721fb8_K:0xL00000008-1_K:{recall}*4_I:0xX00721fb8_I:0xX0000000c+{recall}_K:0xX00000000_I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM0000000f>d0xM0000000f.1._I:{recall}_I:0xX000000b8_Z:0xX0000006c=2334365816_I:{recall}_I:0xX000000b8_N:0xX0000006c!=2334365816_I:{recall}_I:0xX000000b8_Z:p0xX0000006c=2334365816.2._N:0xX0071fccc=1398099027_N:0xH00729330=3_I:{recall}_I:0xX000000b8_N:0xX0000006c=2334365816_I:{recall}_I:0xX0000007c_N:0xX00000068=1_I:0xX00720000_C:0xM00000043>d0xM00000043.1._I:0xX00721fb8_Z:0xL00000008!=0_I:0xX00721fb8_N:0xL00000008=0_I:0xX00721fb8_C:d0xL00000008!=0.1._R:0=1.2._0=1
		-----------
			AddAddress	[Pointer:UIcontrol(preferred)]
			Remember	->[Lower4:ActiveMenuPointerIndex] - Val 0x1
			Remember	Recall * Val 0x4								| Remember: Index of the active [Pointer:UIcontrol_ptr-L2]

			AddAddress	[Pointer:UIcontrol(preferred)]
			AddAddress	->[Pointer:UIcontrolPointerArray] + Recall
			Remember	->[Pointer:UIcontrol_ptr-L2]					| Remember: The active [Pointer:UIcontrol_ptr-L2] 


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_1, INPUT_Cross)


			=============CONTROLLER_2 Quits=============
			---------ResetNextIf_A1--------- (-> ResetNextIf is_QuitConfirmationMenu_displayed)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| ResetNextIf: MEM FrameTitle == "Quit"
			---------ResetNextIf_A2--------- (-> ResetNextIf has_QuitConfirmationMenu_closed for 2 frames)
			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C != TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 				| CheckIf: MEM FrameTitle != "Quit"

			AddAddress	Recall								| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			ResetNextIf	->[Prior 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 		(2)	| ResetNextIf: PRIOR FrameTitle == "Quit"
			---------AddHit_A--------- (-> when any player presses X while at QuitConfirmationMenu, whilst YES highlighted)
			AndNext		[ASCII:GameID] == "SLES"			| CheckIf: is_ReleaseRegion()
			AndNext		[8-bit:GameState] == 0x3			| CheckIf: is_AnyInGameMenu_active()
			
			AddAddress	Recall											| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0xB8
			AndNext		->[Mem 32-bit] 0x6C == TEXTLOOKUPKEY_QuitConfirmationMenu_FrameTitle_Quit 			| CheckIf: FrameTitle == "Quit"
			
			AddAddress	Recall									| Recall: The active [Pointer:UIcontrol_ptr-L2] 
			AddAddress	->[Mem 32-bit] 0x7C
			AndNext		->[Mem 32-bit] 0x68 == 0x1 				| CheckIf: is_PauseMenu_QuitConfirmationMenu_Yes_highlighted()

			AddAddress	[Pointer:PlayerInput(preferred)]
			AddHits		Mem [BitFlag:IsInputPressed_Cross] > Delta [BitFlag:IsInputPressed_Cross]	(1)	| CheckIf: on_PlayerInput_press(CONTROLLER_2, INPUT_Cross)


			=============Effectively Quit (check)=============
			---------ResetNextIf_B--------- (-> when pressing Quit, [Lower4:ActiveMenuPointerIndex] becomes 0, the next frame)
			ResetNextIf	Mem [Lower4:ActiveMenuPointerIndex] != 0x0 			| ResetNextIf: [Lower4:ActiveMenuPointerIndex] != 0
			---------AddHit_B--------
			AndNext		Mem [Lower4:ActiveMenuPointerIndex] == 0x0		
			AddHits		Delta [Lower4:ActiveMenuPointerIndex] != 0x0	(1)		| CheckIf: [Lower4:ActiveMenuPointerIndex] turns 0

			ResetIf		Val 0x0 == Val 0x1		(2)		| CheckIf: (CONTROLLER_1 Quits OR CONTROLLER_2 Quits) AND CheckIf: Effectively Quit
			
						Val 0x0 == Val 0x1				| always_false() */
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& on_PauseMenu_Quit(enum_releaseRegion))
		}

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
		lbGenerate_FullSubmitTrigger_LastChapterCompletion(enum_releaseRegion)),
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

function lb_ValueMeasure_AllStatsScore(enum_chapter) { // WARNING - (3x) MANUAL_CONSTRUCTION
	function valueMeasure_InGame(enum_difficulty, enum_releaseRegion) => // ValueMeasure[Value,3,6,9/12,15,18,21] --> ValueMeasure during during gameplay; This ValueMeasure is never submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_InGame - (below Measured, without MeasuredIf) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	A:0xX00965c08_A:0xX00965c70_K:0xX00965c3c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c24*f12.0_B:0xX00965c20*f5.0_A:0xX00965c1c*f70.0_A:0xX00965c28*f30.0_A:0xX00965c2c*f10.0_A:0xX00965c8c*f12.0_B:0xX00965c88*f5.0_B:0xX00965c74*f5000.0_A:0xX00965c84*f70.0_A:0xX00965c90*f30.0_A:0xX00965c94*f10.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_A:0xX00965d50*f12.0_B:0xX00965d4c*f5.0_A:0xX00965d48*f70.0_A:0xX00965d54*f30.0_A:0xX00965d58*f10.0_A:0xX00965db8*f12.0_B:0xX00965db4*f5.0_B:0xX00965da0*f5000.0_A:0xX00965db0*f70.0_A:0xX00965dbc*f30.0_A:0xX00965dc0*f10.0_A:0xX00965d84*f12.0_B:0xX00965d80*f5.0_B:0xX00965d6c*f5000.0_A:0xX00965d7c*f70.0_A:0xX00965d88*f30.0_A:0xX00965d8c*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	A:0xX00953c28_A:0xX00953c90_K:0xX00953c5c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c44*f12.0_B:0xX00953c40*f5.0_A:0xX00953c3c*f70.0_A:0xX00953c48*f30.0_A:0xX00953c4c*f10.0_A:0xX00953cac*f12.0_B:0xX00953ca8*f5.0_B:0xX00953c94*f5000.0_A:0xX00953ca4*f70.0_A:0xX00953cb0*f30.0_A:0xX00953cb4*f10.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f10.0_A:0xX00953d70*f12.0_B:0xX00953d6c*f5.0_A:0xX00953d68*f70.0_A:0xX00953d74*f30.0_A:0xX00953d78*f10.0_A:0xX00953dd8*f12.0_B:0xX00953dd4*f5.0_B:0xX00953dc0*f5000.0_A:0xX00953dd0*f70.0_A:0xX00953ddc*f30.0_A:0xX00953de0*f10.0_A:0xX00953da4*f12.0_B:0xX00953da0*f5.0_B:0xX00953d8c*f5000.0_A:0xX00953d9c*f70.0_A:0xX00953da8*f30.0_A:0xX00953dac*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([MissionTime_Temp + MissionTime_ChapterSection + MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime
				
				// --------PLAYER_1 + PLAYER_2--------
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

				// ----------------
				* [Difficulty] [1-4] 		| in alt groups			*/
		measured(
			current_MissionTime_Temp(enum_releaseRegion)
			+ current_MissionTime_ChapterSection(enum_releaseRegion)
			+ current_MissionTime_ChapterTotal(enum_releaseRegion)

			// --------PLAYER_1--------
			+ current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
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

			// --------PLAYER_2--------
			+ current_ShotsHit_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_ShotsFired_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			+ current_Kills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_HeadshotKills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills
				
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion)
					+ current_MissionTime_ChapterSection(enum_releaseRegion)
					+ current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)
	function valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion) => // ValueMeasure[1,4,7,10/13,16,19,22]--> ValueMeasure during loading screens or FMVs; This ValueMeasure may be submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterIntermission - (below Measured) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	K:0xX00965c3c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c58*f12.0_B:0xX00965c54*f5.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f70.0_A:0xX00965c5c*f30.0_A:0xX00965c60*f10.0_A:0xX00965d84*f12.0_B:0xX00965d80*f5.0_B:0xX00965d6c*f5000.0_A:0xX00965d7c*f70.0_A:0xX00965d88*f30.0_A:0xX00965d8c*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	K:0xX00953c5c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c78*f12.0_B:0xX00953c74*f5.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f70.0_A:0xX00953c7c*f30.0_A:0xX00953c80*f10.0_A:0xX00953da4*f12.0_B:0xX00953da0*f5.0_B:0xX00953d8c*f5000.0_A:0xX00953d9c*f70.0_A:0xX00953da8*f30.0_A:0xX00953dac*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime

				// --------PLAYER_1 + PLAYER_2--------
				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				// -----------

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_MissionTime_ChapterTotal(enum_releaseRegion)

			// --------PLAYER_2--------
			+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

			// --------PLAYER_2--------
			+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) > 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)
	
	function valueMeasure_ChapterCompleted(enum_chapter, enum_difficulty, enum_releaseRegion) => // ValueMeasure[2,5,8,11/14,17,20,23] --> ValueMeasure when the Chapter is finished; This ValueMeasure may be submitted
		//NOTE: In SinglePlayer or MultiplayerCoop, ChapterStats during gameplay are copied/saved to [Array:SavedStats], afterwards ChapterStats during gameplay is zeroed out when the Chapter finishes, thus this ValueMeasure uses [Array:SavedStats]
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterCompleted_SinglePlayer - (below Measured) R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	I:0xX00965cd8_I:0xX00000004_K:0xX00000190/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00965cd8_I:0xX00000004_A:0xX000001ac*f12.0_I:0xX00965cd8_I:0xX00000004_B:0xX000001a8*f5.0_I:0xX00965cd8_I:0xX00000004_B:0xX00000194*f5000.0_I:0xX00965cd8_I:0xX00000004_A:0xX000001a4*f70.0_I:0xX00965cd8_I:0xX00000004_A:0xX000001b0*f30.0_I:0xX00965cd8_I:0xX00000004_A:0xX000001b4*f10.0_I:0xX00965e04_I:0xX00000004_A:0xX000001ac*f12.0_I:0xX00965e04_I:0xX00000004_B:0xX000001a8*f5.0_I:0xX00965e04_I:0xX00000004_B:0xX00000194*f5000.0_I:0xX00965e04_I:0xX00000004_A:0xX000001a4*f70.0_I:0xX00965e04_I:0xX00000004_A:0xX000001b0*f30.0_I:0xX00965e04_I:0xX00000004_A:0xX000001b4*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	I:0xX00953cf8_I:0xX00000004_K:0xX00000190/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00953cf8_I:0xX00000004_A:0xX000001ac*f12.0_I:0xX00953cf8_I:0xX00000004_B:0xX000001a8*f5.0_I:0xX00953cf8_I:0xX00000004_B:0xX00000194*f5000.0_I:0xX00953cf8_I:0xX00000004_A:0xX000001a4*f70.0_I:0xX00953cf8_I:0xX00000004_A:0xX000001b0*f30.0_I:0xX00953cf8_I:0xX00000004_A:0xX000001b4*f10.0_I:0xX00953e24_I:0xX00000004_A:0xX000001ac*f12.0_I:0xX00953e24_I:0xX00000004_B:0xX000001a8*f5.0_I:0xX00953e24_I:0xX00000004_B:0xX00000194*f5000.0_I:0xX00953e24_I:0xX00000004_A:0xX000001a4*f70.0_I:0xX00953e24_I:0xX00000004_A:0xX000001b0*f30.0_I:0xX00953e24_I:0xX00000004_A:0xX000001b4*f10.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([SavedStats_Story_MissionTime] / LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BaseScore_MissionTime

				// --------PLAYER_1 + PLAYER_2-------- (this part/offsets are different based on Chapter)
				+ [SavedStats_Story_ShotsHit] * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
				- [SavedStats_Story_ShotFired] * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
				- [SavedStats_Story_PlayerDeaths] * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
				+ [SavedStats_Story_Kills] * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
				+ [SavedStats_Story_HeadshotKills] * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
				+ [SavedStats_Story_MeleeKills] * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

				// ------------------

				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion)

			// --------PLAYER_1--------
			+ current_SavedStatStory_ShotsHit(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_SavedStatStory_ShotsFired(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_SavedStatStory_PlayerDeaths(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_SavedStatStory_Kills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_SavedStatStory_HeadshotKills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_SavedStatStory_MeleeKills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills

			// --------PLAYER_2--------
			+ current_SavedStatStory_ShotsHit(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_ShotsHit
			- current_SavedStatStory_ShotsFired(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_ShotsFired
			- current_SavedStatStory_PlayerDeaths(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreDecrease_PlayerDeaths
			+ current_SavedStatStory_Kills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_Kills
			+ current_SavedStatStory_HeadshotKills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_HeadshotKills
			+ current_SavedStatStory_MeleeKills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_ScoreIncrease_MeleeKills
				
				// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_SavedStatStory_Difficulty(PLAYER_1, enum_chapter, enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
				&& current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion) > 0
				&& current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		for enum_difficulty in [DIFFICULTY_Greenhorn, DIFFICULTY_Cowboy, DIFFICULTY_Shootist, DIFFICULTY_Deadeye] {
			array_push(let_array_valueMeasures, valueMeasure_InGame(enum_difficulty, enum_releaseRegion)) // ValueMeasure[Value,3,6,9/12,15,18,21]
			array_push(let_array_valueMeasures, valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion)) // ValueMeasure[1,4,7,10/13,16,19,22]
			array_push(let_array_valueMeasures, valueMeasure_ChapterCompleted(enum_chapter, enum_difficulty, enum_releaseRegion)) // ValueMeasure[2,5,8,11/14,17,20,23]
			}
		}
	return max_of(let_array_valueMeasures)}

function lb_ValueMeasure_AllStatsScore_BossFight(enum_chapter) { // WARNING - (3x) MANUAL_CONSTRUCTION
	function valueMeasure_InGame(enum_difficulty, enum_releaseRegion) => // ValueMeasure[Value,3,6,9/12,15,18,21] --> ValueMeasure during during gameplay; This ValueMeasure is never submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_InGame - (below Measured, without MeasuredIf) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	A:0xX00965c08_A:0xX00965c70_K:0xX00965c3c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c24*f17.0_B:0xX00965c20*f10.0_A:0xX00965c1c*f10000.0_A:0xX00965c28*f1500.0_A:0xX00965c2c*f1000.0_A:0xX00965c8c*f17.0_B:0xX00965c88*f10.0_B:0xX00965c74*f5000.0_A:0xX00965c84*f10000.0_A:0xX00965c90*f1500.0_A:0xX00965c94*f1000.0_A:0xX00965c58*f17.0_B:0xX00965c54*f10.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f10000.0_A:0xX00965c5c*f1500.0_A:0xX00965c60*f1000.0_A:0xX00965d50*f17.0_B:0xX00965d4c*f10.0_A:0xX00965d48*f10000.0_A:0xX00965d54*f1500.0_A:0xX00965d58*f1000.0_A:0xX00965db8*f17.0_B:0xX00965db4*f10.0_B:0xX00965da0*f5000.0_A:0xX00965db0*f10000.0_A:0xX00965dbc*f1500.0_A:0xX00965dc0*f1000.0_A:0xX00965d84*f17.0_B:0xX00965d80*f10.0_B:0xX00965d6c*f5000.0_A:0xX00965d7c*f10000.0_A:0xX00965d88*f1500.0_A:0xX00965d8c*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	A:0xX00953c28_A:0xX00953c90_K:0xX00953c5c_K:{recall}/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c44*f17.0_B:0xX00953c40*f10.0_A:0xX00953c3c*f10000.0_A:0xX00953c48*f1500.0_A:0xX00953c4c*f1000.0_A:0xX00953cac*f17.0_B:0xX00953ca8*f10.0_B:0xX00953c94*f5000.0_A:0xX00953ca4*f10000.0_A:0xX00953cb0*f1500.0_A:0xX00953cb4*f1000.0_A:0xX00953c78*f17.0_B:0xX00953c74*f10.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f10000.0_A:0xX00953c7c*f1500.0_A:0xX00953c80*f1000.0_A:0xX00953d70*f17.0_B:0xX00953d6c*f10.0_A:0xX00953d68*f10000.0_A:0xX00953d74*f1500.0_A:0xX00953d78*f1000.0_A:0xX00953dd8*f17.0_B:0xX00953dd4*f10.0_B:0xX00953dc0*f5000.0_A:0xX00953dd0*f10000.0_A:0xX00953ddc*f1500.0_A:0xX00953de0*f1000.0_A:0xX00953da4*f17.0_B:0xX00953da0*f10.0_B:0xX00953d8c*f5000.0_A:0xX00953d9c*f10000.0_A:0xX00953da8*f1500.0_A:0xX00953dac*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([MissionTime_Temp + MissionTime_ChapterSection + MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime


				// --------PLAYER_1 + PLAYER_2--------
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

				// ----------------

				* [Difficulty] [1-4] 		| in alt groups			*/
		measured(
			current_MissionTime_Temp(enum_releaseRegion)
			+ current_MissionTime_ChapterSection(enum_releaseRegion)
			+ current_MissionTime_ChapterTotal(enum_releaseRegion)

			// --------PLAYER_1--------
			+ current_ShotsHit_Temp(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
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

			// --------PLAYER_2--------
			+ current_ShotsHit_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			+ current_Kills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_Temp(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterSection(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
					
			+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills
			
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_true(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion)
					+ current_MissionTime_ChapterSection(enum_releaseRegion)
					+ current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)
	function valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion) => // ValueMeasure[1,4,7,10/13,16,19,22]--> ValueMeasure during loading screens or FMVs; This ValueMeasure may be submitted
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterIntermission - (below Measured) - R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	K:0xX00965c3c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00965c58*f17.0_B:0xX00965c54*f10.0_B:0xX00965c40*f5000.0_A:0xX00965c50*f10000.0_A:0xX00965c5c*f1500.0_A:0xX00965c60*f1000.0_A:0xX00965d84*f17.0_B:0xX00965d80*f10.0_B:0xX00965d6c*f5000.0_A:0xX00965d7c*f10000.0_A:0xX00965d88*f1500.0_A:0xX00965d8c*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	K:0xX00953c5c/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_A:0xX00953c78*f17.0_B:0xX00953c74*f10.0_B:0xX00953c60*f5000.0_A:0xX00953c70*f10000.0_A:0xX00953c7c*f1500.0_A:0xX00953c80*f1000.0_A:0xX00953da4*f17.0_B:0xX00953da0*f10.0_B:0xX00953d8c*f5000.0_A:0xX00953d9c*f10000.0_A:0xX00953da8*f1500.0_A:0xX00953dac*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([MissionTime_ChapterTotal] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime

				// --------PLAYER_1 + PLAYER_2--------
				+ [ShotsHit_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [ShotFired_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [PlayerDeaths_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [Kills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [HeadshotKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [MeleeKills_ChapterTotal] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				// ----------------
				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_MissionTime_ChapterTotal(enum_releaseRegion)

			// --------PLAYER_1--------
			+ current_ShotsHit_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_1, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			// --------PLAYER_2--------
			+ current_ShotsHit_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_ShotsFired_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_PlayerDeaths_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_Kills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_HeadshotKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_MeleeKills_ChapterTotal(PLAYER_2, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills
			
			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_Difficulty(enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) > 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) <= LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)
	
	function valueMeasure_ChapterCompleted(enum_chapter, enum_difficulty, enum_releaseRegion) => // ValueMeasure[2,5,8,11/14,17,20,23] --> ValueMeasure when the Chapter is finished; This ValueMeasure may be submitted
		//NOTE: In SinglePlayer or MultiplayerCoop, ChapterStats during gameplay are copied/saved to [Array:SavedStats], afterwards ChapterStats during gameplay is zeroed out when the Chapter finishes, thus this ValueMeasure uses [Array:SavedStats]
		/* MANUAL_CONSTRUCTION:AllStatsScore_ChapterCompleted_SinglePlayer - (below Measured) R/R usage
			// WARNING - Edit in DifficultyModifier [0x1-0x4]
			PAL:	I:0xX00965cd8_I:0xX00000004_K:0xX000003c0/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00965cd8_I:0xX00000004_A:0xX000003dc*f17.0_I:0xX00965cd8_I:0xX00000004_B:0xX000003d8*f10.0_I:0xX00965cd8_I:0xX00000004_B:0xX000003c4*f5000.0_I:0xX00965cd8_I:0xX00000004_A:0xX000003d4*f10000.0_I:0xX00965cd8_I:0xX00000004_A:0xX000003e0*f1500.0_I:0xX00965cd8_I:0xX00000004_A:0xX000003e4*f1000.0_I:0xX00965e04_I:0xX00000004_A:0xX000003dc*f17.0_I:0xX00965e04_I:0xX00000004_B:0xX000003d8*f10.0_I:0xX00965e04_I:0xX00000004_B:0xX000003c4*f5000.0_I:0xX00965e04_I:0xX00000004_A:0xX000003d4*f10000.0_I:0xX00965e04_I:0xX00000004_A:0xX000003e0*f1500.0_I:0xX00965e04_I:0xX00000004_A:0xX000003e4*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			NTSCU:	I:0xX00953cf8_I:0xX00000004_K:0xX000003c0/f25200000.0_K:f1.0-{recall}_K:{recall}*f25000.0_I:0xX00953cf8_I:0xX00000004_A:0xX000003dc*f17.0_I:0xX00953cf8_I:0xX00000004_B:0xX000003d8*f10.0_I:0xX00953cf8_I:0xX00000004_B:0xX000003c4*f5000.0_I:0xX00953cf8_I:0xX00000004_A:0xX000003d4*f10000.0_I:0xX00953cf8_I:0xX00000004_A:0xX000003e0*f1500.0_I:0xX00953cf8_I:0xX00000004_A:0xX000003e4*f1000.0_I:0xX00953e24_I:0xX00000004_A:0xX000003dc*f17.0_I:0xX00953e24_I:0xX00000004_B:0xX000003d8*f10.0_I:0xX00953e24_I:0xX00000004_B:0xX000003c4*f5000.0_I:0xX00953e24_I:0xX00000004_A:0xX000003d4*f10000.0_I:0xX00953e24_I:0xX00000004_A:0xX000003e0*f1500.0_I:0xX00953e24_I:0xX00000004_A:0xX000003e4*f1000.0_K:{recall}_K:{recall}*1_M:{recall}
			--------
				(1 - ([SavedStats_Story_MissionTime] / LB_WATCHERS_SETIINGS_BOSSFIGHT_MaxAllowed_MissionTime)) * LB_WATCHERS_SETIINGS_BOSSFIGHT_BaseScore_MissionTime

				// --------PLAYER_1 + PLAYER_2--------
				+ [SavedStats_Story_ShotsHit] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
				- [SavedStats_Story_ShotFired] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
				- [SavedStats_Story_PlayerDeaths] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
				+ [SavedStats_Story_Kills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
				+ [SavedStats_Story_HeadshotKills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
				+ [SavedStats_Story_MeleeKills] * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

				// ----------------
				* [Difficulty] [1-4] 		| in alt groups				*/
		measured(
			current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion)

			// --------PLAYER_1--------
			+ current_SavedStatStory_ShotsHit(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_SavedStatStory_ShotsFired(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_SavedStatStory_PlayerDeaths(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_SavedStatStory_Kills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_SavedStatStory_HeadshotKills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_SavedStatStory_MeleeKills(PLAYER_1, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			// --------PLAYER_2--------
			+ current_SavedStatStory_ShotsHit(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_ShotsHit
			- current_SavedStatStory_ShotsFired(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_ShotsFired
			- current_SavedStatStory_PlayerDeaths(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreDecrease_PlayerDeaths
			+ current_SavedStatStory_Kills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_Kills
			+ current_SavedStatStory_HeadshotKills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_HeadshotKills
			+ current_SavedStatStory_MeleeKills(PLAYER_2, enum_chapter, enum_releaseRegion) * LB_WATCHERS_SETIINGS_BOSSFIGHT_ScoreIncrease_MeleeKills

			// * LB_WATCHERS_SETIINGS_DIFFICULTY_TO_MODIFIER[enum_difficulty]
			,
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& current_SavedStatStory_Difficulty(PLAYER_1, enum_chapter, enum_releaseRegion) == enum_difficulty
				&& is_InMultiplayerCoopMode(enum_releaseRegion)
				&& is_flagStates_BothPlayers_InGame_false(enum_releaseRegion)
				&& current_MissionTime_Temp(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterSection(enum_releaseRegion) == 0
				&& current_MissionTime_ChapterTotal(enum_releaseRegion) == 0
				&& current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion) > 0
				&& current_SavedStatStory_MissionTime(PLAYER_1, enum_chapter, enum_releaseRegion) <= LB_WATCHERS_SETIINGS_MaxAllowed_MissionTime)

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		for enum_difficulty in [DIFFICULTY_Greenhorn, DIFFICULTY_Cowboy, DIFFICULTY_Shootist, DIFFICULTY_Deadeye] {
			array_push(let_array_valueMeasures, valueMeasure_InGame(enum_difficulty, enum_releaseRegion)) // ValueMeasure[Value,3,6,9/12,15,18,21]
			array_push(let_array_valueMeasures, valueMeasure_ChapterIntermission(enum_difficulty, enum_releaseRegion)) // ValueMeasure[1,4,7,10/13,16,19,22]
			array_push(let_array_valueMeasures, valueMeasure_ChapterCompleted(enum_chapter, enum_difficulty, enum_releaseRegion)) // ValueMeasure[2,5,8,11/14,17,20,23]
			}
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
	}
// #endregion LB - triggers

// ====================
// • LEADERBOARD text •
// ====================
// #region LB - text
leaderboards_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": 			{"en": "The Wrong Train — Elite Regulator Duos Watchlist"},
	"lb_WatchersRideDevil": 			{"en": "Ride Like the Devil — Elite Regulator Duos Watchlist"},
	"lb_WatchersBoneyard": 				{"en": "Boneyard — Elite Regulator Duos Watchlist"},
	"lb_WatchersDevilMine": 			{"en": "Devil's Belly Mine — Elite Regulator Duos Watchlist"},
	"lb_WatchersDWOutpost": 			{"en": "Darkwatch Outpost — Elite Regulator Duos Watchlist"},
	"lb_WatchersWarTrain": 				{"en": "War Train — Elite Regulator Duos Watchlist"},
	"lb_WatchersTortureMaze": 			{"en": "Torture Maze — Elite Regulator Duos Watchlist"},
	"lb_WatchersBaptismFire": 			{"en": "Baptism of Fire — Elite Regulator Duos Watchlist"},
	"lb_WatchersRescue": 				{"en": "Rescue — Elite Regulator Duos Watchlist"},
	"lb_WatchersPrism": 				{"en": "The Deadlight Prism — Elite Regulator Duos Watchlist"},
	"lb_WatchersInvasion": 				{"en": "Invasion — Elite Regulator Duos Watchlist"},
	"lb_WatchersHangtown": 				{"en": "Hangtown — Elite Regulator Duos Watchlist"},
	"lb_WatchersMorningAfter": 			{"en": "The Morning After — Elite Regulator Duos Watchlist"},
	"lb_WatchersShowdown": 				{"en": "Showdown — Elite Regulator Duos Watchlist"},
	"lb_WatchersRightTrain": 			{"en": "The Right Train — Elite Regulator Duos Watchlist"},
	"lb_WatchersDeadfall": 				{"en": "Deadfall — Elite Regulator Duos Watchlist"},
	"lb_WatchersCurseWest": 			{"en": "Curse of the West — The Undying Duos"},
	}
leaderboards_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	// ------lb_Watchers------
	"lb_WatchersWrongTrain": 			{"en": "Two souls, one cursed ride. Outgun death itself and leave your mark. Finish Chapter 1, \"The Wrong Train\", from start to finish in one session, with precision and speed, side by side"},
	"lb_WatchersRideDevil": 			{"en": "The devil's got the reins, but you've got each other. Beat the odds and seize your spot. Conquer Chapter 2, \"Ride Like the Devil\", from start to finish in one session, with speed and deadly teamwork"},
	"lb_WatchersBoneyard": 				{"en": "The dead rose to drag you under—and failed. Survive Chapter 3, \"Boneyard\", from start to finish in one session, with ruthless precision and teamwork to etch your names among legends"},
	"lb_WatchersDevilMine": 			{"en": "The mine swallows cowards whole. Only a sharp pair survives. Fight through Chapter 4, \"Devil's Belly Mine\", from start to finish in one session, with grit and deadeye shooting to make the list"},
	"lb_WatchersDWOutpost": 			{"en": "No backup. No retreat. Only you two against the dark. Defend the outpost in Chapter 5, \"Darkwatch Outpost\", from start to finish in one session, with speed and precision to earn your place"},
	"lb_WatchersWarTrain": 				{"en": "Hell's riding the rails—and so are you. Survive the onslaught and take control. Rule Chapter 6, \"War Train\", from start to finish in one session, with flawless teamwork and deadly aim"},
	"lb_WatchersTortureMaze": 			{"en": "Steel your nerves and back each other through the blood-soaked halls. Endure and dominate Chapter 7, \"Torture Maze\", from start to finish in one session, if you want your names remembered"},
	"lb_WatchersBaptismFire": 			{"en": "Together you stepped into fire—and came out legends. Carve your legacy in Chapter 8, \"Baptism of Fire\", from start to finish in one session, through pure grit, teamwork, and destruction"},		
	"lb_WatchersRescue": 				{"en": "They left no one behind. You fought, bled, and carved a path through the dead. Stand together and prove you're the toughest by completing Chapter 9, \"Rescue\", from start to finish in one session"},
	"lb_WatchersPrism": 				{"en": "Power twisted the world, but not you two. Through fire and madness, you seized victory. Crush the chaos and earn your place by completing Chapter 10, \"The Deadlight Prism\", from start to finish in one session"},
	"lb_WatchersInvasion": 				{"en": "The land held fast because you stood together. Only the deadliest teams with the sharpest shots earn a name on this list through completion of Chapter 11, \"Invasion\", from start to finish in one session"},
	"lb_WatchersHangtown": 				{"en": "The gallows swung empty by your hands. Steady aim and deadlier teamwork brought you this far. Earn your mark by completing Chapter 12, \"Hangtown\", from start to finish in one session"},
	"lb_WatchersMorningAfter": 			{"en": "When the Order fell, you two stayed standing. Through steady hands and unshakable trust, you fought side by side. Survive the ashes of Chapter 13, \"The Morning After\", from start to finish in one session, to earn a place among legends"},
	"lb_WatchersShowdown": 				{"en": "When the end came, you stood as one. Two guns, one will, perfect aim. It takes more than courage—it takes greatness. Claim it by completing Chapter 14, \"Showdown\", from start to finish in one session"},
	"lb_WatchersRightTrain": 			{"en": "This train rides straight into hell, but you held the line. Tear through the horrors with steady aim and an even tighter bond to earn your place among legends by completing Chapter 15, \"The Right Train\", from start to finish in one session"},
	"lb_WatchersDeadfall": 				{"en": "The city burned, but you didn't fall. Shoulder to shoulder, without wavering, you carved a path through hellfire. Fight for your name by completing Chapter 16, \"Deadfall\", from start to finish in one session"},
	"lb_WatchersCurseWest": 			{"en": "Together you rewrote fate. Precision, grit, and loyalty carved your mark. Only the greatest duos are remembered. Shape your fate by completing Chapter 17, \"Curse of the West\", from start to finish in one session"},
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
	// richPresence_initialize() // DISABLED - Copy RP script from BaseSet
	leaderboards_initialize()}
initializeRAscript()
// #endregion RAScript Initialization