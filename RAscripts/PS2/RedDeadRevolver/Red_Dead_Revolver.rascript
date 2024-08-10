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

// Nomenclature / Naming Convention // TODO update Nomenclature in template
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
	"Struct_ActorData_0": {
		"sizeInBytes": 8,
		"offsetToMember": {
			"Struct_ActorData_A": 0x0,
			"Struct_ActorData_B": 0x4} 
		},
	"Struct_ActorData_B": {
		"pointerChains": {
			"Float_ActorHP": { 
				"addAddressChain": [0x4, 0x18, 0x10]},
			"Float_ActorMaxHP": { 
				"addAddressChain": [0x4, 0x18, 0x14]},
			"8Bit_UniversalWeaponState": { 
				"addAddressChain": [0x80, 0xA8]},
			"PS2Vector_ActorLocation": { 
				"addAddressChain": [0xC, 0x90]},
			"ASCII_CharacterModelID": { 
				"addAddressChain": [0x24, 0x4], 
				"offsetToPointedToMember": 0x4},
			"BitFlag_IsRidingAnimal": { 
				"addAddressChain": [0xC, 0xC0]},
		}},
	"Struct_PlayerInputReader": {
		"offsetToMember": {
			"BitFlags_PlayerInputA": 0x0,
			"BitFlags_PlayerInputB": 0x1}
		},
	"Struct_PlayerProfileData": {
		"sizeInBytes": 2840,
		"offsetToMember": {
			"32Bit_Cash": 0x8,
			"Bitset_PlayerProfileUnlocks": 0xC,
			"ASCII_FurthestCompletedStoryChapter": 0x23C,
			"32Bit_StoryModeRetries": 0x28C,
			"32Bit_CurrentPlaythroughDifficulty": 0x292,
			"32BitFloat_TimeSpentPlaying": 0x388,
			"Bitset_BountyHunterMissionsCompleted": 0x7B0,
			"ASCII_PlayerProfileName": 0x7BC,
			"Bitset_ActivatedCheats": 0x800}
		},
	"Struct_RewardMenu_StartChpMenu_DisplayData": {
		"pointerChains": {
			"ASCII_StartChpMenuName": {
				"addAddressChain": [0x1EC]},
			"BitFlag_IsStartChpMenuActive": { 
				"addAddressChain": [0x214]},
			"BitFlag_IsRewardMenuOrStartChpMenuDisplayed": { 
				"addAddressChain": [0xAC, 0x38]},
			"BitFlag_IsQuitConfirmationMenuDisplayed": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0xE4]},
			"BitFlag_HighlightedMenuItem": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0x8A4]},
			"32Bit_BountyCollected": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0x9E4]},
			"8Bit_MenuDepth": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0x9D4]},
			"32Bit_Balance": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0xA04]},
			"ASCII_BountyRating_ItemUnlock_UI_Element_ID": { 
				"addAddressChain": [0xAC, 0x34, 0x1C, 0xA94]},			 
			"32BitPointer_2D0": { 
				"addAddressChain": [0x2D0]},
			"Struct_RewardMenuDisplayText": { 
				"addAddressChain": [0x2D0, 0x24, 0x34]},
		}},
	"Struct_RewardMenuDisplayText": {
		"offsetToMember": {
			"ASCII_Accuracy": 0x150}
		},
	"Struct_InGameMenuController": {
		"offsetToMember": {
			"ASCII_InGameMenuID": 0x18,
			"BitFlag_IsInGameMenuDisplayed": 0x38,
			"8Bit_HighlightedMenuItemID": 0x318},
		},
	"Struct_SinglePlayerData": {
		"pointerChains": {
			"Float_PlayerHP": { 
				"addAddressChain": [0x18, 0x10]},
			"Float_PlayerMaxHP": { 
				"addAddressChain": [0x18, 0x14]},
			"ASCII_GameTriggerID": { 
				"addAddressChain": [0x168, 0xEC],
				"offsetToPointedToMember": 0x4}, // <-- This is the offset to the member inside the struct, which the pointer chain points to
			"32Bit_HeadShots": { 
				"addAddressChain": [0x36C, 0x30]},
			"32Bit_DeathToll": { 
				"addAddressChain": [0x36C, 0x5C]},
			"Float_DamageTaken": { 
				"addAddressChain": [0x36C, 0x70]},
			"32Bit_ShotsFired": { 
				"addAddressChain": [0x36C, 0x194]},
			"32Bit_ShotsHit": { 
				"addAddressChain": [0x36C, 0x198]},
			"32Bit_DeadEyeAbilitiesUsed": { 
				"addAddressChain": [0x36C, 0x1BC]},
			"PS2Vector_PlayerLocation": { 
				"addAddressChain": [0xC, 0xC, 0x90]},
			"BitFlag_IsRidingAnimal": { 
				"addAddressChain": [0xC, 0xC, 0xC0]},
			"8Bit_EquippedWeaponID": { 
				"addAddressChain": [0xC, 0x80, 0x48]},
			"8Bit_UniversalWeaponState": { 
				"addAddressChain": [0xC, 0x80, 0xA8]},
			"Array_Weapon_Data": { 
				"addAddressChain": [0xC, 0x80, 0x20, 0x0, 0x4]},
			"Bitset_PlayerProfileUnlocks": { 
				"addAddressChain": [0x5C8]},
		}},
	"Struct_GameController": {
		"pointerChains": {
			"32Bit_EquippedWeapon_ReserveAmmo": { 
				"addAddressChain": [0x2C, 0x14]},
			"BitFlag_IsShowdownPosterMenuDisplayed": { 
				"addAddressChain": [0xC0, 0x48, 0xFD]},
			"BitFlag_IsShowdownPlayerSlot1Filled": { 
				"addAddressChain": [0xC0, 0x7C, 0xFD]},
			"ASCII_ShowdownPlayer1CharacterModelId": { 
				"addAddressChain": [0xC0, 0x7C, 0x13D]},
			"BitFlag_IsShowdownPlayerSlot2Filled": { 
				"addAddressChain": [0xC0, 0x80, 0xFD]},
			"ASCII_ShowdownPlayer2CharacterModelId": { 
				"addAddressChain": [0xC0, 0x80, 0x13D]},
			"BitFlag_IsShowdownPlayerSlot3Filled": { 
				"addAddressChain": [0xC0, 0x84, 0xFD]},
			"ASCII_ShowdownPlayer3CharacterModelId": { 
				"addAddressChain": [0xC0, 0x84, 0x13D]},
			"BitFlag_IsShowdownPlayerSlot4Filled": { 
				"addAddressChain": [0xC0, 0x88, 0xFD]},
			"ASCII_ShowdownPlayer4CharacterModelId": { 
				"addAddressChain": [0xC0, 0x88, 0x13D]},
			"8Bit_TeamIdPlayer1": { 
				"addAddressChain": [0x53C]},
			"8Bit_TeamIdPlayer2": { 
				"addAddressChain": [0x588]},
			"8Bit_TeamIdPlayer3": { 
				"addAddressChain": [0x5D4]},
			"8Bit_TeamIdPlayer4": { 
				"addAddressChain": [0x620]},
			"32Bit_Cash": { 
				"addAddressChain": [0x5874],
				"offsetToPointedToMember": 0x8},
			"32Bit_CashAcquireByOtherMeans": { 
				"addAddressChain": [0x5874],
				"offsetToPointedToMember": 0xC},
			"32Bit_CashCombo": { 
				"addAddressChain": [0x5874],
				"offsetToPointedToMember": 0x10},
			"32Bit_CashComboMultiplier": { 
				"addAddressChain": [0x5874],
				"offsetToPointedToMember": 0x14},
		}},
	"Undefined_Struct_03": {
		"offsetToMember": {
			"32Bit_MissionKillcount": 0xD8}
		},
	"Struct_Extra_Mission_Data.RogueValley": {
		"pointerChains": {
			"BitFlag_IsTreasureAOpened": { 
				"addAddressChain": [0x4, 0x4C]},
			"BitFlag_IsTreasureBOpened": { 
				"addAddressChain": [0x8, 0x4C]},
			"BitFlag_IsTreasureCOpened": { 
				"addAddressChain": [0xC, 0x4C]}}
		},
	"Struct_Extra_Mission_Data.TheTraitor": {
		"pointerChains": {
			"BitFlag_IsAlliedCannonA_Destroyed": { 
				"addAddressChain": [0x4, 0x4C]},
			"BitFlag_IsAlliedCannonB_Destroyed": { 
				"addAddressChain": [0x8, 0x4C]},
			"BitFlag_IsAlliedCannonC_Destroyed": { 
				"addAddressChain": [0xC, 0x4C]},
			"BitFlag_IsAlliedCannonD_Destroyed": { 
				"addAddressChain": [0x10, 0x4C]},
			"BitFlag_IsAlliedCannonE_Destroyed": { 
				"addAddressChain": [0x14, 0x4C]},
			"BitFlag_IsAlliedCannonF_Destroyed": { 
				"addAddressChain": [0x18, 0x4C]},
			"BitFlag_IsAlliedCannonG_Destroyed": { 
				"addAddressChain": [0x1C, 0x4C]},
			"BitFlag_IsAlliedCannonH_Destroyed": { 
				"addAddressChain": [0x20, 0x4C]}}
		},
	"Struct_MajorCharacter_Data": {
		"sizeInBytes": 8,
		"pointerChains": {
			"Float_MajorCharacter0_HP": { 
				"addAddressChain": [0x0, 0x18, 0x10]},
			"Float_MajorCharacter0_MaxHP": { 
				"addAddressChain": [0x0, 0x18, 0x14]},
			"ASCII_MajorCharacter0_CharacterName": { 
				"addAddressChain": [0x0, 0x4],
				"offsetToPointedToMember": 0x0},
			"Float_MajorCharacter1_HP": { 
				"addAddressChain": [0x8, 0x18, 0x10]},
			"Float_MajorCharacter1_MaxHP": { 
				"addAddressChain": [0x8, 0x18, 0x14]},
			"ASCII_MajorCharacter1_CharacterName": { 
				"addAddressChain": [0x8, 0x4],
				"offsetToPointedToMember": 0x0},
			"Float_MajorCharacter2_HP": { 
				"addAddressChain": [0x10, 0x18, 0x10]},
			"Float_MajorCharacter2_MaxHP": { 
				"addAddressChain": [0x10, 0x18, 0x14]},
			"ASCII_MajorCharacter2_CharacterName": { 
				"addAddressChain": [0x10, 0x4],
				"offsetToPointedToMember": 0x0},
			"Float_MajorCharacter3_HP": { 
				"addAddressChain": [0x18, 0x18, 0x10]},
			"Float_MajorCharacter3_MaxHP": { 
				"addAddressChain": [0x18, 0x18, 0x14]},
			"ASCII_MajorCharacter3_CharacterName": { 
				"addAddressChain": [0x18, 0x4],
				"offsetToPointedToMember": 0x0},
			"Float_MajorCharacter4_HP": { 
				"addAddressChain": [0x20, 0x18, 0x10]},
			"Float_MajorCharacter4_MaxHP": { 
				"addAddressChain": [0x20, 0x18, 0x14]},
			"ASCII_MajorCharacter4_CharacterName": { 
				"addAddressChain": [0x20, 0x4],
				"offsetToPointedToMember": 0x0},
			"Float_MajorCharacter5_HP": { 
				"addAddressChain": [0x28, 0x18, 0x10]},
			"Float_MajorCharacter5_MaxHP": { 
				"addAddressChain": [0x28, 0x18, 0x14]},
			"ASCII_MajorCharacter5_CharacterName": { 
				"addAddressChain": [0x28, 0x4],
				"offsetToPointedToMember": 0x0},
		}},
	"Struct_GatlingGunZone_Data": {
		"offsetToMember": {
			"ASCII_InteractableZoneID": 0x1C,
			"BitFlag_IsGatlingGunManned": 0x169}
		},
	"Struct_Puppetshow_Manager": {
		"offsetToMember": {
			"ASCII_PuppetshowID": 0x68}
		},
	"Struct_Weapon_Data": {
		"sizeInBytes": 8,
		"pointerChains": {
			"BitFlag_IsWeaponInInventory": {
				"addAddressChain": [0x4, 0x1D0]},
		}},
	"Struct_Mission_Timers": {
		"offsetToMember": {
			"Float_CountdownTimer": 0x1C,
			"Float_TimeSpentinMission": 0x20}
		},
	"Struct_ShowdownPlayer_Settings_A": {
		"sizeInBytes": 92,
		"offsetToMember": {
			"Lower4_TeamId": 0x0,
			"ASCII_CharacterModelId": 0x5,
			"ASCII_ShowdownAIsetting": 0x36}
		},
	"Struct_ShowdownPlayer_Settings_B": {
		"sizeInBytes": 336,
		"offsetToMember": {
			"ASCII_CharacterModelId": 0x1,
			"Lower4_TeamId": 0xB,
			"BitFlag_IsPlayerSlotFilled": 0x13,
			"ASCII_ShowdownAIsetting": 0x139}
		},		
	"Struct_MultiplayerRewardMenu_Data": {
		"pointerChains": {
			"32BitPointer_28": {
				"addAddressChain": [0x28]},
			"ASCII_Flag_IsPlayer1Winner": {
				"addAddressChain": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": 0x0},
			"ASCII_Flag_IsPlayer2Winner": {
				"addAddressChain": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": 0x10},
			"ASCII_Flag_IsPlayer3Winner": {
				"addAddressChain": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": 0x20},
			"ASCII_Flag_IsPlayer4Winner": {
				"addAddressChain": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": 0x30},
			"ASCII_Flag_IsMultiplayerRewardMenuDisplayed": {
				"addAddressChain": [0x28, 0x0]},
		}},
	"Struct_MultiplayerRewardMenu_UI_Controller": {
		"pointerChains": {
			"32Bit_HighlightedPopupMenuItem": {
				"addAddressChain": [0x1C, 0x1414]},
		}},
	"Struct_ShowdownMode_Settings": {
		"offsetToMember": {
			"Lower4_GameMode": 0x0,
			"Lower4_BountyLimit": 0x4,
			"Lower4_SundownFightTime": 0x8,
			"Lower4_HighNoonRequiredWins": 0xC,
			"Lower4_PowerUpSetting": 0x18} 
		},
	}

function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_memberKey) =>
	memory_dataStructures[string_structKey]["offsetToMember"][string_memberKey]

function memory_getPointerChainOffsetToMember(string_structKey, string_pointerChainKey) => 
	memory_dataStructures[string_structKey]["pointerChains"][string_pointerChainKey]["offsetToPointedToMember"]

function memory_getAddressChain(string_structKey, string_pointerChainKey) =>
	memory_dataStructures[string_structKey]["pointerChains"][string_pointerChainKey]["addAddressChain"]

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
		"IsNotLoading": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fd3ec, RELEASE_REGION_JPN: sNULL}, // Unused
		"IsPlayingBountyHunterMode": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a099c, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_8Bit: {
		"NumberOfPlayers": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73dd6c, RELEASE_REGION_JPN: 0x73f2ec},
		"GameMode": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fbaf0, RELEASE_REGION_JPN: sNULL},
		"UIRenderStackLevel": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a10, RELEASE_REGION_JPN: sNULL}, // Unused
		"SelectedPlayerProfile": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x744898, RELEASE_REGION_JPN: sNULL},
		"AreaState": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x6b0a1c, RELEASE_REGION_JPN: sNULL},
		},	
	DATATYPE_ASCII: {
		"GameID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54c7cc, RELEASE_REGION_JPN: 0x54dd4c},
		"AreaID": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a0620, RELEASE_REGION_JPN: sNULL},
		"EndingCreditsFlag": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x1f7ec20, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_32Bit: {
		"AlwaysNULL": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x40, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_32BitPointer: {
		"SinglePlayerData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x763070, RELEASE_REGION_JPN: sNULL},
		"Selected_PlayerProfileData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7448d8, RELEASE_REGION_JPN: sNULL},
		"GameController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x562a20, RELEASE_REGION_JPN: sNULL},
		"RewardMenu_StartChpMenu_DisplayData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54caf0, RELEASE_REGION_JPN: sNULL},
		"InGameMenuController": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73d684, RELEASE_REGION_JPN: sNULL},
		"Undefined_Struct_03": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fa370, RELEASE_REGION_JPN: sNULL},
		"Extra_Mission_Data": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4f9fac, RELEASE_REGION_JPN: sNULL},
		"GatlingGunZone_Data": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x55de28, RELEASE_REGION_JPN: sNULL},
		"MajorCharacter_Data": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x4fa3a0, RELEASE_REGION_JPN: sNULL},
		"Puppetshow_Manager": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a2a00, RELEASE_REGION_JPN: sNULL},
		"Mission_Timers": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7a0788, RELEASE_REGION_JPN: sNULL},
		"MultiplayerRewardMenu_Data": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x54cac8, RELEASE_REGION_JPN: sNULL},
		"MultiplayerRewardMenu_UI_Controller": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x780b0, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_Struct: {
		"Array_PlayerProfileData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x740608, RELEASE_REGION_JPN: sNULL},
		"Array_ActorData": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7621d0, RELEASE_REGION_JPN: sNULL},
		"Array_ShowdownPlayer_Settings_A": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x740438, RELEASE_REGION_JPN: sNULL}, // Unused
		"Array_ShowdownPlayer_Settings_B": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73d819, RELEASE_REGION_JPN: sNULL},
		"Bitset_ShowdownCharacterUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405e1, RELEASE_REGION_JPN: sNULL},
		"Bitset_ShowdownMapUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405df, RELEASE_REGION_JPN: sNULL},
		"Bitset_JournalPageUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405cd, RELEASE_REGION_JPN: sNULL},
		"Bitset_CheatUnlocks": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405cc, RELEASE_REGION_JPN: sNULL},
		"PlayerInputReader": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x73df42, RELEASE_REGION_JPN: sNULL},
		"ShowdownMode_Settings": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x7405b0, RELEASE_REGION_JPN: sNULL},
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

function memUtil_memAddrTo_AlwaysNull(enum_releaseRegion) =>
	memory_getAddress(DATATYPE_32Bit, "AlwaysNULL", enum_releaseRegion)

function memUtil_bitwiseOR(memAccessor_bitFlagAccessor, memAccessor_B) => // A OR B => A + B - A AND B (workaround as rCheevos doesn't support bitwise-OR out-of-the-box)
	memAccessor_bitFlagAccessor + memAccessor_B - (memAccessor_bitFlagAccessor & memAccessor_B)

function memUtil_createArrayOfBitIndicesToSub(array_bitIndicesToAdd) { // This function should be used when counting flags via a bitcount, where not all bits should be counted (eg. bitcount(0xA) - bit0(0xA) - bit1(0xA))
		let_array_bitIndicesToSub = [0,1,2,3,4,5,6,7]
		for let_bitIndex in array_bitIndicesToAdd 
			let_array_bitIndicesToSub[let_bitIndex] = iNULL
		return let_array_bitIndicesToSub
	}

function memGenerate_SumOf_BitsetFlags(dict_FlagData, function_bitFlagMemAccessorGenerator, enum_releaseRegion) { // function_bitFlagMemAccessorGenerator should require parameters: (int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion)
	// BUG RATools - using memGenerate_SumOf_BitsetFlags() may put RATools into infinite processing (refer to https://github.com/Jamiras/RATools/issues/503)
	// As a workaround use memGenerate_SumOf_BitsetFlags_noSubSource()
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
// Custom ASCII comparitors are necessary to use with pointers, built-in RAtools ascii_string_equals() generates weird logic, when using pointers as the memAddrr

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

function is_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s)

function is_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s)

function wasPrior_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prior(c))

function wasPrev_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prev(c))

function wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))

function on_ASCII_changeTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s) && 
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))

// .......................
// ◦ PLAYER INPUT READER ◦
// '''''''''''''''''''''''
function current_FlagState_PlayerInput_X(enum_releaseRegion) => 
	bit6( 
		memory_getAddress(DATATYPE_Struct, "PlayerInputReader", enum_releaseRegion) 
		+ memory_getDataStructOffset("Struct_PlayerInputReader", "BitFlags_PlayerInputB"))

function current_FlagState_PlayerInput_R1(enum_releaseRegion) => 
	bit3( 
		memory_getAddress(DATATYPE_Struct, "PlayerInputReader", enum_releaseRegion) 
		+ memory_getDataStructOffset("Struct_PlayerInputReader", "BitFlags_PlayerInputB"))

function current_FlagState_PlayerInput_L1(enum_releaseRegion) =>
	bit2( 
		memory_getAddress(DATATYPE_Struct, "PlayerInputReader", enum_releaseRegion) 
		+ memory_getDataStructOffset("Struct_PlayerInputReader", "BitFlags_PlayerInputB"))

function current_FlagState_PlayerInput_R2(enum_releaseRegion) =>
	bit1( 
		memory_getAddress(DATATYPE_Struct, "PlayerInputReader", enum_releaseRegion) 
		+ memory_getDataStructOffset("Struct_PlayerInputReader", "BitFlags_PlayerInputB"))


function is_PlayerInput_ConfirmBtn_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_X(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function on_PlayerInput_ConfirmBtn_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_X(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}

function is_PlayerInput_FireGun_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 1}

function on_PlayerInput_FireGun_release(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState > prev(let_memAccessor_inputState)}

function on_PlayerInput_FireGun_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}	

function is_PlayerInput_AimGun_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_L1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function is_PlayerInput_DeadEyeAbility_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R2(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function on_PlayerInput_DeadEyeAbility_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R2(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}

// ...........
// ◦ AREA ID ◦
// '''''''''''
AREA_loading = "default"
AREA_MainMenu = "lvl_front"
AREA_Campaign_BullsEye = "lvl_perfnew"
AREA_Campaign_BountyHunter = "lvl_hng"
AREA_Campaign_UglyStreetFight = "lvl_sher"
AREA_Campaign_Traincar = "lvl_triancar"
AREA_Campaign_Railroaded = "lvl_traingood"
AREA_Campaign_CarnivalLife = "lvl_ghost"
AREA_Campaign_FreakShow = "lvl_shernite"
AREA_Campaign_RogueValley = "lvl_bomb"
AREA_Campaign_GhostTown = "lvl_gunsmoke"
AREA_Campaign_TheCemetery = "lvl_cemetery"
AREA_Campaign_RangeWar = "lvl_ranch"
AREA_Campaign_SaloonFight = "lvl_barfight"
AREA_Campaign_TheTraitor = "lvl_bridge"
AREA_Campaign_SunsetCanyon = "lvl_coach"
AREA_Campaign_BearMountain = "lvl_woods"
AREA_Campaign_Jailbreak = "lvl_core"
AREA_Campaign_TheMine = "lvl_corenew"
AREA_Campaign_Stagecoach = "lvl_msn"
AREA_Campaign_HellPass = "lvl_msncyn"
AREA_Campaign_FortDiego = "lvl_fort"
AREA_Campaign_EndOfTheLine = "lvl_train"
AREA_Campaign_DevilsAndAngels = "lvl_trainend"
AREA_Campaign_BattleRoyale = "lvl_roydusk"
AREA_Campaign_BattleFinale = "lvl_royfinal"
AREA_Campaign_Siege = "lvl_mans"
AREA_Campaign_HouseOfCards = "lvl_mansintb"
AREA_Campaign_FallFromGrace = "lvl_mansroof"
AREA_Showdown_WidowsPatch = "lvl_shernit2"
AREA_Showdown_TheRanch = "lvl_ranch2"
AREA_Showdown_Fairground = "lvl_ghost2"
AREA_Showdown_FallenCreek = "lvl_flash2"
AREA_Showdown_GhostTown = "lvl_gun2"
AREA_Showdown_SunsetCanyon = "lvl_coach2"
AREA_Showdown_BrokenCreek = "lvl_perf2"
AREA_Showdown_MansionGrounds = "lvl_mans2"
AREA_Showdown_TheMansion = "lvl_int2"
AREA_Showdown_TwinRocks = "lvl_hng2"
AREA_Showdown_DesertFortress = "lvl_fort2"

const_Area_data = { // TODO put these coordinates inside the code notes
	AREA_Campaign_BullsEye: { 
		"PlayerLoadCoordinates": { // These are the coordinates of the player_location during loading/restart mission/retrying
			"X-Coordinate": 20.60,
			"Y-Coordinate": 12.65,
			"Z-Coordinate": -4.46},
		"PlayerStartCoordinates": { // These are the coordinates of the player_location on mission start
			"X-Coordinate": 20.64,
			"Y-Coordinate": -8.00,
			"Z-Coordinate": -5.12}},
	AREA_Campaign_BountyHunter: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 3.05,
			"Y-Coordinate": 13.39,
			"Z-Coordinate": -0.08},
		"PlayerStartCoordinates": {
			"X-Coordinate": -2.62,
			"Y-Coordinate": 41.20,
			"Z-Coordinate": 0.01}},
	AREA_Campaign_UglyStreetFight: { 
		"PlayerLoadCoordinates": {
			"X-Coordinate": 34.35,
			"Y-Coordinate": -14.90,
			"Z-Coordinate": 2.27},
		"PlayerStartCoordinates": {
			"X-Coordinate": 41.83,
			"Y-Coordinate": 7.72,
			"Z-Coordinate": 1.90}},
	AREA_Campaign_Traincar: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -0.05,
			"Y-Coordinate": 6.99,
			"Z-Coordinate": 0.00},
		"PlayerStartCoordinates": {
			"X-Coordinate": -0.05,
			"Y-Coordinate": 6.99,
			"Z-Coordinate": 0.00}},
	AREA_Campaign_Railroaded: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 2.03,
			"Y-Coordinate": 104.04,
			"Z-Coordinate": 1.63},
		"PlayerStartCoordinates": {
			"X-Coordinate": 0.06,
			"Y-Coordinate": -1.63,
			"Z-Coordinate": 1.13}},
	AREA_Campaign_CarnivalLife: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 8.45,
			"Y-Coordinate": -5.12,
			"Z-Coordinate": 4.62},
		"PlayerStartCoordinates": {
			"X-Coordinate": -7.46,
			"Y-Coordinate": -4.67,
			"Z-Coordinate": 4.83},
		"Zone_GatlingGunA": {
			"X-Coordinate": -14.96,
			"Y-Coordinate": 0.68,
			"Z-Coordinate": 9.37}},
	AREA_Campaign_FreakShow: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 21.19,
			"Y-Coordinate": -15.16,
			"Z-Coordinate": 2.39},
		"PlayerStartCoordinates": {
			"X-Coordinate": 24.66,
			"Y-Coordinate": -15.32,
			"Z-Coordinate": 2.42}},
	AREA_Campaign_RogueValley: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 138.79,
			"Y-Coordinate": 39.72,
			"Z-Coordinate": -46.58},
		"PlayerStartCoordinates": {
			"X-Coordinate": 138.79,
			"Y-Coordinate": 39.72,
			"Z-Coordinate": -46.58}},
	AREA_Campaign_GhostTown: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 50.32,
			"Y-Coordinate": 6.83,
			"Z-Coordinate": -0.13},
		"PlayerStartCoordinates": {
			"X-Coordinate": 46.48,
			"Y-Coordinate": 5.43,
			"Z-Coordinate": -0.28}},
	AREA_Campaign_TheCemetery: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -58.15,
			"Y-Coordinate": 31.69,
			"Z-Coordinate": 7.48},
		"PlayerStartCoordinates": {
			"X-Coordinate": -58.42,
			"Y-Coordinate": 40.00,
			"Z-Coordinate": 7.48}},
	AREA_Campaign_RangeWar: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 0.90,
			"Y-Coordinate": -15.37,
			"Z-Coordinate": 0.41},
		"PlayerStartCoordinates": {
			"X-Coordinate": 26.45,
			"Y-Coordinate": 0.48,
			"Z-Coordinate": 0.00}},
	AREA_Campaign_SaloonFight: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -6.9,
			"Y-Coordinate": -3.64,
			"Z-Coordinate": -2.5},
		"PlayerStartCoordinates": {
			"X-Coordinate": -3.15,
			"Y-Coordinate": 1.12,
			"Z-Coordinate": -2.46}},
	AREA_Campaign_TheTraitor: { // Both these coordinates are identical
		"PlayerLoadCoordinates": {
			"X-Coordinate": 36.82,
			"Y-Coordinate": 1.30,
			"Z-Coordinate": 4.16},
		"PlayerStartCoordinates": {
			"X-Coordinate": 36.82,
			"Y-Coordinate": 1.30,
			"Z-Coordinate": 4.16}},
	AREA_Campaign_SunsetCanyon: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -2.02,
			"Y-Coordinate": -93.09,
			"Z-Coordinate": -2.40},
		"PlayerStartCoordinates": {
			"X-Coordinate": -3.6,
			"Y-Coordinate": -90.51,
			"Z-Coordinate": -2.90}},
	AREA_Campaign_BearMountain: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 40.93,
			"Y-Coordinate": -24.63,
			"Z-Coordinate": -15.40},
		"PlayerStartCoordinates": {
			"X-Coordinate": 40.93,
			"Y-Coordinate": -24.63,
			"Z-Coordinate": -15.40}},
	AREA_Campaign_Jailbreak: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -65.31,
			"Y-Coordinate": -8.43,
			"Z-Coordinate": -2.00},
		"PlayerStartCoordinates": {
			"X-Coordinate": -65.31,
			"Y-Coordinate": -8.43,
			"Z-Coordinate": -2.00}},
	AREA_Campaign_TheMine: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -25.64,
			"Y-Coordinate": 23.10,
			"Z-Coordinate": 0.64},
		"PlayerStartCoordinates": {
			"X-Coordinate": -9.52,
			"Y-Coordinate": 20.53,
			"Z-Coordinate": 2.03}},
	AREA_Campaign_Stagecoach: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 0.76,
			"Y-Coordinate": -1.17,
			"Z-Coordinate": 2.97},
		"PlayerStartCoordinates": {
			"X-Coordinate": 0.76,
			"Y-Coordinate": -1.17,
			"Z-Coordinate": 2.91}},
	AREA_Campaign_HellPass: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -0.02,
			"Y-Coordinate": 0.18,
			"Z-Coordinate": 2.85},
		"PlayerStartCoordinates": {
			"X-Coordinate": -0.02,
			"Y-Coordinate": 0.18,
			"Z-Coordinate": 2.84}},
	AREA_Campaign_FortDiego: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": -11.20,
			"Y-Coordinate": -14.12,
			"Z-Coordinate": 0.85},
		"PlayerStartCoordinates": {
			"X-Coordinate": -19.93,
			"Y-Coordinate": -21.89,
			"Z-Coordinate": 0.70}},
	AREA_Campaign_EndOfTheLine: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 39.79,
			"Y-Coordinate": 29.36,
			"Z-Coordinate": 0.44},
		"PlayerStartCoordinates": { // These are zero'd because player spawns in on horseback
			"X-Coordinate": 0.0,
			"Y-Coordinate": 0.0,
			"Z-Coordinate": 0.0}},
	AREA_Campaign_DevilsAndAngels: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 32.22,
			"Y-Coordinate": 25.42,
			"Z-Coordinate": 0.33},
		"PlayerStartCoordinates": {
			"X-Coordinate": 32.22,
			"Y-Coordinate": 25.42,
			"Z-Coordinate": 0.33}},
	AREA_Campaign_BattleRoyale: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 29.74,
			"Y-Coordinate": -13.06,
			"Z-Coordinate": 0.00},
		"PlayerStartCoordinates": {
			"X-Coordinate": 26.99,
			"Y-Coordinate": -12.30,
			"Z-Coordinate": 0.00}},
	AREA_Campaign_BattleFinale: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 11.44,
			"Y-Coordinate": -23.70,
			"Z-Coordinate": 0.80},
		"PlayerStartCoordinates": {
			"X-Coordinate": 26.92,
			"Y-Coordinate": -10.52,
			"Z-Coordinate": 0.00}},
	AREA_Campaign_Siege: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 44.11,
			"Y-Coordinate": 0.00,
			"Z-Coordinate": 0.01},
		"PlayerStartCoordinates": {
			"X-Coordinate": 34.84,
			"Y-Coordinate": 0.00,
			"Z-Coordinate": 0.49}},
	AREA_Campaign_HouseOfCards: {
		"PlayerLoadCoordinates": {
			"X-Coordinate": -3.82,
			"Y-Coordinate": 0.15,
			"Z-Coordinate": 0.99},
		"PlayerStartCoordinates": {
			"X-Coordinate": -1.98,
			"Y-Coordinate": 1.23,
			"Z-Coordinate": 0.99}},
	AREA_Campaign_FallFromGrace: { 
		"PlayerLoadCoordinates": { 
			"X-Coordinate": 9.15,
			"Y-Coordinate": 25.34,
			"Z-Coordinate": 11.22},
		"PlayerStartCoordinates": {
			"X-Coordinate": 4.17,
			"Y-Coordinate": 23.11,
			"Z-Coordinate": 10.97}},
	}

function get_Area_PlayerSpawnXCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["X-Coordinate"]

function get_Area_PlayerSpawnYCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["Y-Coordinate"]

function get_Area_PlayerSpawnZCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["Z-Coordinate"]

function get_Area_PlayerLoadXCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["X-Coordinate"]

function get_Area_PlayerLoadYCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["Y-Coordinate"]

function get_Area_PlayerLoadZCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["Z-Coordinate"]

function get_Area_GatlingGunXCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["X-Coordinate"]

function get_Area_GatlingGunYCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["Y-Coordinate"]

function get_Area_GatlingGunZCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["Z-Coordinate"]

function is_AreaLoading_active(enum_releaseRegion) => 
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), AREA_loading)

function is_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId)

function wasPrior_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prior(areaCheckComparison))

function on_Area_changeTo(enum_areaId, enum_releaseRegion) =>
	is_Area(enum_areaId, enum_releaseRegion) &&
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "AreaID", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prev(areaCheckComparison))

// ..............
// ◦ AREA STATE ◦
// ''''''''''''''
AREASTATE_InGame = 10
AREASTATE_Standby = 20
AREASTATE_Loading = 30
const_GameState_data = {
	AREASTATE_InGame: {"ID": 0x2},
	AREASTATE_Standby: {"ID": 0x32},
	AREASTATE_Loading: {"ID": 0xFF}}

function get_AreaStateId(enum_areaState) =>
	const_GameState_data[enum_areaState]["ID"]

function current_AreaState(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "AreaState", enum_releaseRegion))

function prev_AreaState(enum_releaseRegion) => 
	prev(current_AreaState(enum_releaseRegion))

function is_AreaState_InGame(enum_releaseRegion) => 
	current_AreaState(enum_releaseRegion) == get_AreaStateId(AREASTATE_InGame)

function is_AreaState_Standby(enum_releaseRegion) => 
	current_AreaState(enum_releaseRegion) == get_AreaStateId(AREASTATE_Standby)

function is_AreaState_Loading(enum_releaseRegion) => 
	current_AreaState(enum_releaseRegion) == get_AreaStateId(AREASTATE_Loading)

function on_AreaState_ChangeTo(enum_areaState, enum_releaseRegion) =>
	current_AreaState(enum_releaseRegion) == get_AreaStateId(enum_areaState)
	&& prev_AreaState(enum_releaseRegion) != get_AreaStateId(enum_areaState)

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
		memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "ASCII_GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getPointerChainOffsetToMember("Struct_SinglePlayerData", "ASCII_GameTriggerID")
	// return is_ASCII_EqualTo(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])
	return is_ASCII_EqualTo(let_pointerChainTo_GameTriggerID, enum_gameTrigger)
	
	}

function on_GameTrigger_changeTo(enum_gameTrigger, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "ASCII_GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getPointerChainOffsetToMember("Struct_SinglePlayerData", "ASCII_GameTriggerID")
	// return on_ASCII_changeTo(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])
	return on_ASCII_changeTo(let_pointerChainTo_GameTriggerID, enum_gameTrigger)
	
	}

// ...................
// ◦ PLAYER LOCATION ◦
// '''''''''''''''''''
PLAYER_STATIONARY_THRESHOLD = 0.7
PLAYER_SPAWN_THRESHOLD = 0.5
PLAYER_GATLING_GUN_THRESHOLD = 0.3
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

function prev_PlayerXCoordinate(enum_releaseRegion) =>
	prev(current_PlayerXCoordinate(enum_releaseRegion))

function prev_PlayerYCoordinate(enum_releaseRegion) =>
	prev(current_PlayerYCoordinate(enum_releaseRegion))

function prev_PlayerZCoordinate(enum_releaseRegion) =>
	prev(current_PlayerZCoordinate(enum_releaseRegion))

function is_PlayerXCoordinate_nearCoordinate(float_Xcoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerXCoordinate = current_PlayerXCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerXCoordinate >= float_Xcoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerXCoordinate <= float_Xcoordinate + float_thresholdFromCoordinate}

function is_PlayerYCoordinate_nearCoordinate(float_Ycoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerYCoordinate = current_PlayerYCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerYCoordinate >= float_Ycoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerYCoordinate <= float_Ycoordinate + float_thresholdFromCoordinate}

function is_PlayerZCoordinate_nearCoordinate(float_Zcoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerZCoordinate = current_PlayerZCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerZCoordinate >= float_Zcoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerZCoordinate <= float_Zcoordinate + float_thresholdFromCoordinate}

function wasPrev_PlayerXCoordinate_nearCoordinate(float_Xcoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerXCoordinate = prev_PlayerXCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerXCoordinate >= float_Xcoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerXCoordinate <= float_Xcoordinate + float_thresholdFromCoordinate}

function wasPrev_PlayerYCoordinate_nearCoordinate(float_Ycoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerYCoordinate = prev_PlayerYCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerYCoordinate >= float_Ycoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerYCoordinate <= float_Ycoordinate + float_thresholdFromCoordinate}

function wasPrev_PlayerZCoordinate_nearCoordinate(float_Zcoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerZCoordinate = prev_PlayerZCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerZCoordinate >= float_Zcoordinate - float_thresholdFromCoordinate
		&& let_memAccessor_PlayerZCoordinate <= float_Zcoordinate + float_thresholdFromCoordinate}

function is_PlayerXCoordinate_notNearCoordinate(float_Xcoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerXCoordinate = current_PlayerXCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerXCoordinate <= float_Xcoordinate - float_thresholdFromCoordinate
		|| let_memAccessor_PlayerXCoordinate >= float_Xcoordinate + float_thresholdFromCoordinate}

function is_PlayerYCoordinate_notNearCoordinate(float_Ycoordinate, float_thresholdFromCoordinate, enum_releaseRegion) {
	let_memAccessor_PlayerYCoordinate = current_PlayerYCoordinate(enum_releaseRegion)
	return 
		let_memAccessor_PlayerYCoordinate <= float_Ycoordinate - float_thresholdFromCoordinate
		|| let_memAccessor_PlayerYCoordinate >= float_Ycoordinate + float_thresholdFromCoordinate}

function is_PlayerXCoordinate_stationaryNearCoordinate(float_Xcoordinate, enum_releaseRegion) =>
	is_PlayerXCoordinate_nearCoordinate(float_Xcoordinate, PLAYER_STATIONARY_THRESHOLD, enum_releaseRegion)
		
function is_PlayerXCoordinate_notStationaryNearCoordinate(float_Xcoordinate, enum_releaseRegion) =>
	is_PlayerXCoordinate_notNearCoordinate(float_Xcoordinate, PLAYER_STATIONARY_THRESHOLD, enum_releaseRegion)

function is_PlayerYCoordinate_stationaryNearCoordinate(float_Ycoordinate, enum_releaseRegion) =>
	is_PlayerYCoordinate_nearCoordinate(float_Ycoordinate, PLAYER_STATIONARY_THRESHOLD, enum_releaseRegion)
		
function is_PlayerYCoordinate_notStationaryNearCoordinate(float_Ycoordinate, enum_releaseRegion) =>
	is_PlayerYCoordinate_notNearCoordinate(float_Ycoordinate, PLAYER_STATIONARY_THRESHOLD, enum_releaseRegion)

function is_PlayerPosition_withinArea(float_areaCenterXcoordinate, float_areaCenterYcoordinate, float_areaCenterZcoordinate, float_thresholdFromCenter, enum_releaseRegion) => 
	is_PlayerXCoordinate_nearCoordinate(float_areaCenterXcoordinate, float_thresholdFromCenter, enum_releaseRegion)		
	&& is_PlayerYCoordinate_nearCoordinate(float_areaCenterYcoordinate, float_thresholdFromCenter, enum_releaseRegion)
	&& is_PlayerZCoordinate_nearCoordinate(float_areaCenterZcoordinate, float_thresholdFromCenter, enum_releaseRegion)

function wasPrev_PlayerPosition_withinArea(float_areaCenterXcoordinate, float_areaCenterYcoordinate, float_areaCenterZcoordinate, float_thresholdFromCenter, enum_releaseRegion) => 
	wasPrev_PlayerXCoordinate_nearCoordinate(float_areaCenterXcoordinate, float_thresholdFromCenter, enum_releaseRegion)		
	&& wasPrev_PlayerYCoordinate_nearCoordinate(float_areaCenterYcoordinate, float_thresholdFromCenter, enum_releaseRegion)
	&& wasPrev_PlayerZCoordinate_nearCoordinate(float_areaCenterZcoordinate, float_thresholdFromCenter, enum_releaseRegion)

// ----------------PlayerSpawn--------------------
function is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion) {
	let_missionLoad_Xcoordinate = get_Area_PlayerLoadXCoordinate(enum_areaId)
	let_missionLoad_Ycoordinate = get_Area_PlayerLoadYCoordinate(enum_areaId)
	let_missionLoad_Zcoordinate = get_Area_PlayerLoadZCoordinate(enum_areaId)
	
	return is_PlayerPosition_withinArea(
		let_missionLoad_Xcoordinate, let_missionLoad_Ycoordinate, let_missionLoad_Zcoordinate,
		PLAYER_SPAWN_THRESHOLD, enum_releaseRegion)
	}

function wasPrev_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion) {
	let_missionLoad_Xcoordinate = get_Area_PlayerLoadXCoordinate(enum_areaId)
	let_missionLoad_Ycoordinate = get_Area_PlayerLoadYCoordinate(enum_areaId)
	let_missionLoad_Zcoordinate = get_Area_PlayerLoadZCoordinate(enum_areaId)
	
	return wasPrev_PlayerPosition_withinArea(
		let_missionLoad_Xcoordinate, let_missionLoad_Ycoordinate, let_missionLoad_Zcoordinate,
		PLAYER_SPAWN_THRESHOLD, enum_releaseRegion)
	}

function is_PlayerPosition_atMissionStartPoint(enum_areaId, enum_releaseRegion) {
	let_missionSpawn_Xcoordinate = get_Area_PlayerSpawnXCoordinate(enum_areaId)
	let_missionSpawn_Ycoordinate = get_Area_PlayerSpawnYCoordinate(enum_areaId)
	let_missionSpawn_Zcoordinate = get_Area_PlayerSpawnZCoordinate(enum_areaId)
	
	return is_PlayerPosition_withinArea(
		let_missionSpawn_Xcoordinate, let_missionSpawn_Ycoordinate, let_missionSpawn_Zcoordinate,
		PLAYER_SPAWN_THRESHOLD, enum_releaseRegion)
	}

function on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion) =>
	is_PlayerPosition_atMissionStartPoint(enum_areaId, enum_releaseRegion)
	&& wasPrev_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion)

// ----------------GatlingGun--------------------
function is_PlayerPosition_atGatlingGun(enum_areaId, enum_releaseRegion) {
	let_Xcoordinate = get_Area_GatlingGunXCoordinate(enum_areaId)
	let_Ycoordinate = get_Area_GatlingGunYCoordinate(enum_areaId)
	let_Zcoordinate = get_Area_GatlingGunZCoordinate(enum_areaId)
	
	return is_PlayerPosition_withinArea(
		let_Xcoordinate, let_Ycoordinate, let_Zcoordinate,
		PLAYER_GATLING_GUN_THRESHOLD, enum_releaseRegion)
	}


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
function current_PlayerProfile_SavedCash(enum_releaseRegion) {
	let_memAddrPointerTo_SelectedPlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_Cash = memory_getDataStructOffset("Struct_PlayerProfileData", "32Bit_Cash")
	return dword(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_Cash)}

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
	return is_ASCII_EqualTo(dword(let_memAddrPointerTo_SelectedPlayerProfileData) + let_offsetTo_CampaignSetting, let_areaId_fixed)}

// ................
// ◦ IN GAME MENU ◦
// ''''''''''''''''
// ------------------StartChpMenu---------------------
function current_FlagState_IsStartChpMenuActive(enum_releaseRegion) {
	let_memAddr_StartChpMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsStartChpMenuActive", 
		let_memAddr_StartChpMenuDisplayData, accessor = bit0)}

function prev_FlagState_IsStartChpMenuActive(enum_releaseRegion) => 
	prev(current_FlagState_IsStartChpMenuActive(enum_releaseRegion))

function is_StartChpMenu_active(enum_releaseRegion) {
	// const_STRING_STARTCHPMENU = "startChpMenu"
	// const_STRING_SHORT_STARTCHPMENU = "startChp"
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	// let_pointerChainTo_StartChpMenuName = memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "ASCII_StartChpMenuName", let_memAddr_RewardMenuDisplayData)	
	return 
		// is_ASCII_EqualTo(let_pointerChainTo_StartChpMenuName, const_STRING_SHORT_STARTCHPMENU)
		current_FlagState_IsStartChpMenuActive(enum_releaseRegion) == 1}
	

function on_StartChpMenu_initialize(enum_releaseRegion) =>
	current_FlagState_IsStartChpMenuActive(enum_releaseRegion) > prev_FlagState_IsStartChpMenuActive(enum_releaseRegion)
// ------------------RewardMenu---------------------
REWARDMENU_ITEMUNLOCK_UI_ELEMENT_ID_Locked = "locked"
function current_HighlightedRewardMenuItem(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_HighlightedMenuItem = memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_HighlightedMenuItem", 
		let_memAddr_RewardMenuDisplayData, accessor = bit0)
	return let_memAccessor_HighlightedMenuItem}

function current_RewardMenu_Balance(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32Bit_Balance", let_memAddr_RewardMenuDisplayData, accessor = dword)}

function current_RewardMenu_BountyCollected(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32Bit_BountyCollected", let_memAddr_RewardMenuDisplayData, accessor = dword)}

function current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsQuitConfirmationMenuDisplayed", 
		let_memAddr_RewardMenuDisplayData, accessor = bit0)}

function current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "BitFlag_IsRewardMenuOrStartChpMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, accessor = bit0)}

function is_RewardMenu_MenuDepth(int_depth, enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_MenuDepth = memory_generateAddAddressPointerChain(
		"Struct_RewardMenu_StartChpMenu_DisplayData", "8Bit_MenuDepth", 
		let_memAddr_RewardMenuDisplayData, accessor = byte)
	return let_memAccessor_MenuDepth == int_depth}

function is_RewardMenu_displayed_long(enum_releaseRegion) => // This comparison is bigger than is_RewardMenu_displayed_short()
	current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion) == 1
	&& !is_StartChpMenu_active(enum_releaseRegion)

function is_RewardMenu_displayed_short(enum_releaseRegion) { // This comparison is shorter than is_RewardMenu_displayed_long() (prefer using this){
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_Pointer = memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32BitPointer_2D0", let_memAddr_RewardMenuDisplayData)
	return let_memAccessor_Pointer > 0}
	
function on_RewardMenu_render_long(enum_releaseRegion) {
	let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed = current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion)
	return 
		let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed > prev(let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed)
		// && !is_StartChpMenu_active(enum_releaseRegion) // <-- Unnecessary
		}

function on_RewardMenu_render_short(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_memAccessor_Pointer = memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "32BitPointer_2D0", let_memAddr_RewardMenuDisplayData)
	return 
		let_memAccessor_Pointer > 0
		&& prev(let_memAccessor_Pointer) == 0}

function on_RewardMenu_close(enum_releaseRegion) {
	let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed = current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion)
	return 
		let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed < prev(let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed)
		&& !is_StartChpMenu_active(enum_releaseRegion)}

function is_RatingBounty_achieved(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_pointerChainTo_BountyRating_ItemUnlock_UI_Element_ID = memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "ASCII_BountyRating_ItemUnlock_UI_Element_ID", let_memAddr_RewardMenuDisplayData)
	return is_ASCII_notEqualTo(let_pointerChainTo_BountyRating_ItemUnlock_UI_Element_ID, REWARDMENU_ITEMUNLOCK_UI_ELEMENT_ID_Locked)}

function is_RewardMenu_QuitConfirmMenu_displayed(enum_releaseRegion) => 
	current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) == 1
	&& is_RewardMenu_MenuDepth(0x2, enum_releaseRegion)
	|| is_RewardMenu_MenuDepth(0x3, enum_releaseRegion)

function is_RewardMenu_ReplayConfirmMenu_displayed(enum_releaseRegion) => 
	current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) == 0
	&& is_RewardMenu_MenuDepth(0x2, enum_releaseRegion)
	|| is_RewardMenu_MenuDepth(0x3, enum_releaseRegion)

function on_RewardMenu_Replay_confirm(enum_releaseRegion) {
	const_YES = 0
	return 
		is_RewardMenu_displayed_short(enum_releaseRegion)
		&& is_RewardMenu_ReplayConfirmMenu_displayed(enum_releaseRegion) 
		&& current_HighlightedRewardMenuItem(enum_releaseRegion) == const_YES
		&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)}

function is_RewardMenu_Accuracy(string_accuracy, enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "RewardMenu_StartChpMenu_DisplayData", enum_releaseRegion)
	let_PointerChainTo_Struct_RewardMenuDisplayText = memory_generateAddAddressPointerChain("Struct_RewardMenu_StartChpMenu_DisplayData", "Struct_RewardMenuDisplayText", let_memAddr_RewardMenuDisplayData)
	let_offsetTo_Accuracy = memory_getDataStructOffset("Struct_RewardMenuDisplayText", "ASCII_Accuracy")
	return is_ASCII_EqualTo(let_PointerChainTo_Struct_RewardMenuDisplayText + let_offsetTo_Accuracy, string_accuracy)}

// ------------------InGameMenu---------------------
INGAMEMENU_RetryMenu = "continue"
INGAMEMENU_GameOverScreen = "gameover"
INGAMEMENU_PauseMenu = "pause"
INGAMEMENU_CheatsMenu = "cheats"
INGAMEMENU_WarningMenu = "warning"
function current_IsInGameMenuDisplayed(enum_releaseRegion) =>
	bit0(
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion))
		+ memory_getDataStructOffset("Struct_InGameMenuController", "BitFlag_IsInGameMenuDisplayed"))

function prev_IsInGameMenuDisplayed(enum_releaseRegion) => 
	prev(current_IsInGameMenuDisplayed(enum_releaseRegion))

function current_HighlightedInGameMenuItem(enum_releaseRegion) =>
	byte(
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion))
		+ memory_getDataStructOffset("Struct_InGameMenuController", "8Bit_HighlightedMenuItemID"))

function is_InGameMenuID(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)}

function wasPrev_InGameMenuID(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "InGameMenuController", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_InGameMenuController", "ASCII_InGameMenuID")
	return ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4, transform = c => prev(c))}

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

function on_RetryMenu_yes(enum_releaseRegion) {
	const_YES = 0x4
	return 
		is_InGameMenu_displayed(INGAMEMENU_RetryMenu, enum_releaseRegion)
		&& current_HighlightedInGameMenuItem(enum_releaseRegion) == const_YES
		&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)}

function on_WarningMenu_yes(enum_releaseRegion) {
	const_YES = 0x4
	return 
		is_InGameMenu_displayed(INGAMEMENU_WarningMenu, enum_releaseRegion)
		&& current_HighlightedInGameMenuItem(enum_releaseRegion) == const_YES
		&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)}



// ..........
// ◦ CHEATS ◦
// ''''''''''
// ------------------------Cheats------------------------------
CHEAT_BiteTheBullet = 10
CHEAT_GoldenGun = 20
CHEAT_InfiniteDeadeye = 30
CHEAT_Invincibility = 40
CHEAT_NoDistortion = 50
CHEAT_NoHud =  60
CHEAT_SadStars = 70
CHEAT_Debug_ShowPlayerPosition = 210
CHEAT_Debug_ShowAIInfo = 220

FlagData_Bitset_ActivatedCheats = {
	"Flags_UnlockableCheats": {
		1: [6,7],
		2: [2,4,5,6,7]},
	"Flags_DebugCheats": {
		2: [0,1]},
	"Flags_ByCheat": {
		CHEAT_Invincibility: {"ByteIndex": 1, "BitIndex": 6},
		CHEAT_GoldenGun: {"ByteIndex": 1, "BitIndex": 7},
		CHEAT_Debug_ShowPlayerPosition: {"ByteIndex": 2, "BitIndex": 0},
		CHEAT_Debug_ShowAIInfo: {"ByteIndex": 2, "BitIndex": 1},
		CHEAT_InfiniteDeadeye: {"ByteIndex": 2, "BitIndex": 2},
		CHEAT_BiteTheBullet: {"ByteIndex": 2, "BitIndex": 4},
		CHEAT_SadStars: {"ByteIndex": 2, "BitIndex": 5},
		CHEAT_NoHud: {"ByteIndex": 2, "BitIndex": 6},
		CHEAT_NoDistortion: {"ByteIndex": 2, "BitIndex": 7}}
	}

function bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
		+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	return memAccessor_bitFlagAccessor(let_memAddr_Bitset_ActivatedCheats + int_offsetToByte)}

function is_AnyCheat_active(enum_releaseRegion) {
	let_sumOf_AllCheatFlags = 
		memGenerate_SumOf_BitsetFlags_noSubSource(
			FlagData_Bitset_ActivatedCheats["Flags_UnlockableCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
		+ memGenerate_SumOf_BitsetFlags_noSubSource(
			FlagData_Bitset_ActivatedCheats["Flags_DebugCheats"],
			bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion) // <--line-- checks if cheats are active outside the cheatsMenu as switching them on/off still requires a confirmation before leaving this subMenu
		&& let_sumOf_AllCheatFlags > 0
	}

function is_SpecifiedCheat_active(enum_cheat, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
			+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	let_offsetToByte = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
	let_bitIndex = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
	let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte) == 1}

function is_SpecifiedCheat_inactive(enum_cheat, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
			+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	let_offsetToByte = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
	let_bitIndex = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
	let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte) == 0}

function is_AllSpecifiedCheats_active(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
			+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) == length(array_cheatEnums)}

function is_AnySpecifiedCheats_active(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
			+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) > 0}

function is_AnySpecifiedCheats_inactive(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)) 
			+ memory_getDataStructOffset("Struct_PlayerProfileData", "Bitset_ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = FlagData_Bitset_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		!is_InGameMenu_displayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) < length(array_cheatEnums)}

// ------------------------RstarCheat------------------------------
function is_RStar_Cheat_inActive(enum_releaseRegion) {
	const_RSTAR_NAME = "Rstar"
	let_memAddr_SelectedPlayerProfile = memory_getAddress(DATATYPE_32BitPointer, "Selected_PlayerProfileData", enum_releaseRegion)
	let_offsetTo_PlayerProfileName = memory_getDataStructOffset("Struct_PlayerProfileData", "ASCII_PlayerProfileName")
	let_memAddr_PlayerProfileName = dword(let_memAddr_SelectedPlayerProfile) + let_offsetTo_PlayerProfileName
	return is_ASCII_notEqualTo(let_memAddr_PlayerProfileName, const_RSTAR_NAME)}

// ............................
// ◦ CHARACTER IDENTIFICATION ◦
// ''''''''''''''''''''''''''''
CHARACTER_GeneralDiego = "dgo"
CHARACTER_MrKelley = "mrk"
CHARACTER_JackSwift = "jck"
CHARACTER_AnnieStoakes = "ani"
CHARACTER_KatieGrady = "kti"
CHARACTER_UglyChris = "ugl"
CHARACTER_ProfessorPerry = "pry"
CHARACTER_BladeSlade = "bwi"
CHARACTER_SherrifGrady = "cls"
CHARACTER_SherrifBartlett = "kng"
CHARACTER_HolsteinHal = "tcb"
CHARACTER_Sam = "tck"
CHARACTER_GovernorGriffon = "wyn"
CHARACTER_ShadowWolf = "tck"
CHARACTER_FallingStar = "mom" 
CHARACTER_Grizzly = "mst"
CHARACTER_StandingSnake = "msk"
CHARACTER_MrBlack = "blk"
CHARACTER_BadBessie = "bty"
CHARACTER_PigJosh = "pgj"
CHARACTER_NateHarlow = "dad"
CHARACTER_ColonelDaren = "ydr"
CHARACTER_Natalie = "ntl"
CHARACTER_RedJr = "mrd"
CHARACTER_CurlyShaw = "shp"
CHARACTER_BloodyTom = "gay"
CHARACTER_BigOaf = "frk"
CHARACTER_TwiggyPhelps = "twg"
CHARACTER_SissyFess = "sto"
CHARACTER_RicoPedrosa = "bra"
CHARACTER_UdoKang = "mon"
CHARACTER_StageCoach = 100
const_Character_data = {
	CHARACTER_JackSwift: {
		"CharacterName": "Jack"},
	CHARACTER_AnnieStoakes: {
		"CharacterName": "Annie"},
	CHARACTER_StageCoach: {
		"CharacterName": "StageCoach"},
}
function get_CharacterName(enum_character) =>
	const_Character_data[enum_character]["CharacterName"]

// -----------------------MajorCharacterData------------------------------
function current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MajorCharacter_Data", enum_releaseRegion)
	let_string_pointerChainKey = format("Float_MajorCharacter{0}_HP", int_majorCharacterIndex)
	return memory_generateAddAddressPointerChain("Struct_MajorCharacter_Data", let_string_pointerChainKey, let_memAddr_BasePointer, accessor = float)}

function prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) =>
	prev(current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion))

function current_MajorCharacterMaxHP(int_majorCharacterIndex, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MajorCharacter_Data", enum_releaseRegion)
	let_string_pointerChainKey = format("Float_MajorCharacter{0}_MaxHP", int_majorCharacterIndex)
	return memory_generateAddAddressPointerChain("Struct_MajorCharacter_Data", let_string_pointerChainKey, let_memAddr_BasePointer, accessor = float)}

function on_MajorCharacterHP_decrement(int_majorCharacterIndex, enum_releaseRegion) => 
	current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) < prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion)

function on_MajorCharacterHP_zero(int_majorCharacterIndex, enum_releaseRegion) =>
	current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) == 0
	&& prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) > 0

function is_MajorCharacter_CharacterName(int_majorCharacterIndex, enum_character, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MajorCharacter_Data", enum_releaseRegion)
	let_string_pointerChainKey = format("ASCII_MajorCharacter{0}_CharacterName", int_majorCharacterIndex)
	let_offsetTo_CharacterName = memory_getPointerChainOffsetToMember("Struct_MajorCharacter_Data", let_string_pointerChainKey)
	let_memAddr_CharacterName = memory_generateAddAddressPointerChain("Struct_MajorCharacter_Data", let_string_pointerChainKey, let_memAddr_BasePointer)
	return is_ASCII_EqualTo(let_memAddr_CharacterName + let_offsetTo_CharacterName, get_CharacterName(enum_character))}

function current_Calculated_MajorCharacterHPPercentage(int_majorCharacterIndex, enum_releaseRegion) => 
	current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) / current_MajorCharacterMaxHP(int_majorCharacterIndex, enum_releaseRegion)


// ...................
// ◦ GAME CONTROLLER ◦
// '''''''''''''''''''
// ------------------------Cash_HUDController------------------------------
function current_Cash(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return 
		memory_generateAddAddressPointerChain(
			"Struct_GameController", "32Bit_Cash", let_memAddr_GameController, 
			int_offsetToMember = memory_getPointerChainOffsetToMember("Struct_GameController", "32Bit_Cash"),
			accessor = dword)
	}

function current_CashAcquiredByOtherMeans(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return 
		memory_generateAddAddressPointerChain(
			"Struct_GameController", "32Bit_CashAcquireByOtherMeans", let_memAddr_GameController, 
			int_offsetToMember = memory_getPointerChainOffsetToMember("Struct_GameController", "32Bit_CashAcquireByOtherMeans"),
			accessor = dword)
	}

function prev_CashAcquiredByOtherMeans(enum_releaseRegion) =>
	prev(current_CashAcquiredByOtherMeans(enum_releaseRegion))

function on_CashAcquiredByOtherMeans_increasesBy(int_i, enum_releaseRegion) =>
	current_CashAcquiredByOtherMeans(enum_releaseRegion) - prev_CashAcquiredByOtherMeans(enum_releaseRegion) == int_i

function current_CashCombo(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return 
		memory_generateAddAddressPointerChain(
			"Struct_GameController", "32Bit_Cash", let_memAddr_GameController, 
			int_offsetToMember = memory_getPointerChainOffsetToMember("Struct_GameController", "32Bit_CashCombo"),
			accessor = dword)
	}

function current_CashComboMultiplier(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return 
		memory_generateAddAddressPointerChain(
			"Struct_GameController", "32Bit_Cash", let_memAddr_GameController, 
			int_offsetToMember = memory_getPointerChainOffsetToMember("Struct_GameController", "32Bit_CashComboMultiplier"),
			accessor = dword)
	}

function current_Calculated_CashDuringMission(enum_releaseRegion) => // WARNING - RATools cannot generate this sumOf correctly, thus achievements making use of this logic should be manually edited in
	current_Cash(enum_releaseRegion)
	// + (current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion)) >= const_CASH_TARGET // BUG RATools - this line is supposed to be added to this AddSource chain, but RATools would replace this sumOf with an always_false()
	
	// Full SumOf would look like this [PAL]:
	// -------------------------------
	// AddAddress	Mem 32-bit 0x562a20
	// AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
	// AddAddress	Mem 32-bit 0x562a20
	// 			 	Mem 32-bit 0x587c	>= Val const_CASH_TARGET

function current_Calculated_CashAcquiredDuringMission(enum_releaseRegion) => // WARNING - RATools cannot generate this sumOf correctly, thus achievements making use of this logic should be manually edited in
	current_Cash(enum_releaseRegion)  // <-- Cash which updates during the mission
	- current_PlayerProfile_SavedCash(enum_releaseRegion) // <-- Cash which is only updated on save (on mission end)
	// + (current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion)) >= const_CASH_TARGET // BUG RATools - this line is supposed to be added to this AddSource chain, but RATools would replace this sumOf with an always_false()
	
	// Full SumOf would look like this [PAL]:
	// -------------------------------
	// AddAddress	Mem 32-bit 0x7448d8
	// SubSource 	Mem 32-bit 0x8
	// AddAddress	Mem 32-bit 0x562a20
	// AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
	// AddAddress	Mem 32-bit 0x562a20
	// 			 	Mem 32-bit 0x587c	>= Val const_CASH_TARGET

function on_CashResetToSavedCash(enum_releaseRegion) =>
	current_Cash(enum_releaseRegion) - current_PlayerProfile_SavedCash(enum_releaseRegion) == 0

// ------------------------AmmoCounter_HUDController------------------------------
function is_AmmoHUDControllerReserveAmmo(int_ammoCount, enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	let_pointerChainto_EquippedWeaponReserveAmmo = memory_generateAddAddressPointerChain("Struct_GameController", "32Bit_EquippedWeapon_ReserveAmmo", let_memAddr_GameController)
	return let_memAccessor_EquippedWeaponReserveAmmo == int_ammoCount}
	
function on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	let_memAccessor_EquippedWeaponReserveAmmo = memory_generateAddAddressPointerChain("Struct_GameController", "32Bit_EquippedWeapon_ReserveAmmo", let_memAddr_GameController)
	return let_memAccessor_EquippedWeaponReserveAmmo < prev(let_memAccessor_EquippedWeaponReserveAmmo)}

// ......................
// ◦ SINGLE PLAYER DATA ◦
// ''''''''''''''''''''''
const_array_MAX_HP_VALUES = [250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0] // 8 max hp values as there's 7 HP upgrades

function current_PlayerHP(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "Float_PlayerHP", let_memAddr_SinglePlayerData, accessor = float)} 

function prev_PlayerHP(enum_releaseRegion) =>
	prev(current_PlayerHP(enum_releaseRegion))
	
function current_PlayerMaxHP(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "Float_PlayerMaxHP", let_memAddr_SinglePlayerData, accessor = float)} 

function is_PlayerMaxHP(float_value, enum_releaseRegion) =>
	current_PlayerMaxHP(enum_releaseRegion) == float_value

function on_PlayerHP_heal(enum_releaseRegion) =>
	current_PlayerHP(enum_releaseRegion) > prev_PlayerHP(enum_releaseRegion)

function current_FlagState_IsPlayerRidingAnimal(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "BitFlag_IsRidingAnimal", let_memAddr_SinglePlayerData, accessor = bit0)}

function is_PlayerRidingAnimal(enum_releaseRegion) =>
	current_FlagState_IsPlayerRidingAnimal(enum_releaseRegion) == 1
// ------------------------WeaponManager------------------------------
WEAPON_Knife = 0x27
WEAPON_Faith = 0x2F
UNIVERSAL_WEAPON_STATE_Holstered = 0x0
UNIVERSAL_WEAPON_STATE_Aiming = 0x3
UNIVERSAL_WEAPON_STATE_Reloading = 0x4

function current_PlayerUniversalWeaponState(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "8Bit_UniversalWeaponState", let_memAddr_BasePointer)}

function prev_PlayerUniversalWeaponState(enum_releaseRegion) => 
	prev(current_PlayerUniversalWeaponState(enum_releaseRegion))

function on_PlayerUniversalWeaponState_changeTo(enum_universalWeaponState, enum_releaseRegion) => 
	current_PlayerUniversalWeaponState(enum_releaseRegion) == enum_universalWeaponState 
	&& prev_PlayerUniversalWeaponState(enum_releaseRegion) != enum_universalWeaponState

function current_PlayerWeaponEquipped(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "8Bit_EquippedWeaponID", let_memAddr_BasePointer)}

function is_PlayerWeapon_equipped(enum_weapon, enum_releaseRegion) =>
	current_PlayerWeaponEquipped(enum_releaseRegion) == enum_weapon

function current_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion) {
	let_array_AddAddressChainTo_IsWeaponInInventory = memory_getAddressChain("Struct_Weapon_Data", "BitFlag_IsWeaponInInventory")
	let_offsetTo_WeaponData = (enum_weapon * memory_getDataStructSizeInBytes("Struct_Weapon_Data")) + let_array_AddAddressChainTo_IsWeaponInInventory[0]

	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	let_pointerChainTo_ArrayWeaponData = memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "Array_Weapon_Data", let_memAddr_BasePointer)
	let_pointerChainTo_IsWeaponInInventory = dword(let_pointerChainTo_ArrayWeaponData + let_offsetTo_WeaponData)
	return bit0(let_pointerChainTo_IsWeaponInInventory + let_array_AddAddressChainTo_IsWeaponInInventory[1])}

function prev_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion) =>
	prev(current_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion))

function is_Weapon_inInventory(enum_weapon, enum_releaseRegion) => 
	current_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion) == 1

function on_Weapon_pickup(enum_weapon, enum_releaseRegion) =>
	current_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion) > prev_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion)

// ------------------------SinglePlayer_Mission_Stats------------------------------
function current_ShotsFired(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_ShotsFired", let_memAddr_SinglePlayerData)}

function prev_ShotsFired(enum_releaseRegion) =>
	prev(current_ShotsFired(enum_releaseRegion))

function current_ShotsHit(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_ShotsHit", let_memAddr_SinglePlayerData)}

function prev_ShotsHit(enum_releaseRegion) =>
	prev(current_ShotsHit(enum_releaseRegion))

function current_Calculated_Accuracy(enum_releaseRegion) => // This is not functional in RAIntegration 1.3.0 as this doesn't return a float
	current_ShotsHit(enum_releaseRegion) / current_ShotsFired(enum_releaseRegion)

function on_ShotsFired_increment(enum_releaseRegion) => 
	current_ShotsFired(enum_releaseRegion) > prev_ShotsFired(enum_releaseRegion)

function on_ShotsHit_increment(enum_releaseRegion) => 
	current_ShotsHit(enum_releaseRegion) > prev_ShotsHit(enum_releaseRegion)

function on_ShotsHit_change(enum_releaseRegion) =>
	current_ShotsHit(enum_releaseRegion) != prev_ShotsHit(enum_releaseRegion)

function current_DeathToll(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_DeathToll", let_memAddr_SinglePlayerData)}

function prev_DeathToll(enum_releaseRegion) =>
	prev(current_DeathToll(enum_releaseRegion))

function on_DeathToll_increment(enum_releaseRegion) => // WARNING This value does not count enemies killed which are riding animals
	current_DeathToll(enum_releaseRegion) > prev_DeathToll(enum_releaseRegion)

function current_DamageTaken(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "Float_DamageTaken", let_memAddr_SinglePlayerData, accessor = float)}

function current_Calculated_DamageTakenPercentage(enum_releaseRegion) =>
	current_DamageTaken(enum_releaseRegion) / current_PlayerMaxHP(enum_releaseRegion)

function current_HeadShots(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_HeadShots", let_memAddr_SinglePlayerData)}

function prev_HeadShots(enum_releaseRegion) =>
	prev(current_HeadShots(enum_releaseRegion))

function on_HeadShots_increment(enum_releaseRegion) =>
	current_HeadShots(enum_releaseRegion) > prev_HeadShots(enum_releaseRegion)

function current_DeadEyeAbilitiesUsed(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "SinglePlayerData", enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_SinglePlayerData", "32Bit_DeadEyeAbilitiesUsed", let_memAddr_SinglePlayerData)}

function prev_DeadEyeAbilitiesUsed(enum_releaseRegion) =>
	prev(current_DeadEyeAbilitiesUsed(enum_releaseRegion))

function on_DeadEyeAbilitiesUsed_increment(enum_releaseRegion) =>
	current_DeadEyeAbilitiesUsed(enum_releaseRegion) > prev_DeadEyeAbilitiesUsed(enum_releaseRegion)

// ..............
// ◦ ACTOR DATA ◦ // May be unsued code
// ''''''''''''''
function get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion) {
	let_memAddr_ActorDataArray = memory_getAddress(DATATYPE_Struct, "Array_ActorData", enum_releaseRegion)
	let_memAddr_ActorData0 = let_memAddr_ActorDataArray + (memory_getDataStructSizeInBytes("Struct_ActorData_0") * int_actorDataindex)
	return let_memAddr_ActorData0 + memory_getDataStructOffset("Struct_ActorData_0", "Struct_ActorData_B")}

// ------------------------HealthPoints------------------------------
function is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion) => // This checks if this index in the Array_ActorData is filled
	dword(get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)) > 0

function current_Actor_HP(int_actorDataindex, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	return memory_generateAddAddressPointerChain("Struct_ActorData_B", "Float_ActorHP", let_memAddr_ActorDataB)}

function prev_Actor_HP(int_actorDataindex, enum_releaseRegion) =>
	prev(current_Actor_HP(int_actorDataindex, enum_releaseRegion))

function on_Actor_HP_decrement(int_actorDataindex, enum_releaseRegion) =>
	current_Actor_HP(int_actorDataindex, enum_releaseRegion) < prev_Actor_HP(int_actorDataindex, enum_releaseRegion)

function on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion) => 
	current_Actor_HP(int_actorDataindex, enum_releaseRegion) == 0
	&& prev_Actor_HP(int_actorDataindex, enum_releaseRegion) > 0

function is_Actor_CharacterModelId_equalTo(int_actorDataindex, enum_characterModelId, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	let_offsetTo_CharacterModelID = memory_getPointerChainOffsetToMember("Struct_ActorData_B", "ASCII_CharacterModelID")
	let_memAddr_CharacterModelID = memory_generateAddAddressPointerChain(
		"Struct_ActorData_B", "ASCII_CharacterModelID", let_memAddr_ActorDataB)
	return is_ASCII_EqualTo(let_memAddr_CharacterModelID + let_offsetTo_CharacterModelID, enum_characterModelId)}

function is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, enum_characterModelId, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	let_offsetTo_CharacterModelID = memory_getPointerChainOffsetToMember("Struct_ActorData_B", "ASCII_CharacterModelID")
	let_memAddr_CharacterModelID = memory_generateAddAddressPointerChain(
		"Struct_ActorData_B", "ASCII_CharacterModelID", let_memAddr_ActorDataB)
	return is_ASCII_notEqualTo(let_memAddr_CharacterModelID + let_offsetTo_CharacterModelID, enum_characterModelId)}

// .............
// ◦ CUTSCENES ◦
// '''''''''''''
// ------------------------Puppetshow------------------------------
PUPPETSHOW_BearMountain_PreBoss = "lvl_waterfall_pupshow_02"

function is_PuppetshowID(string_puppetshowId, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "Puppetshow_Manager", enum_releaseRegion)
	let_memAddr_PuppetshowId = dword(let_memAddr_BasePointer) + memory_getDataStructOffset("Struct_Puppetshow_Manager", "ASCII_PuppetshowID")
	return is_ASCII_EqualTo(let_memAddr_PuppetshowId, string_puppetshowId)}

function wasPrev_PuppetshowID(string_puppetshowId, enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "Puppetshow_Manager", enum_releaseRegion)
	let_memAddr_PuppetshowId = dword(let_memAddr_BasePointer) + memory_getDataStructOffset("Struct_Puppetshow_Manager", "ASCII_PuppetshowID")
	return wasPrev_ASCII_EqualTo(let_memAddr_PuppetshowId, string_puppetshowId)}

function on_Puppetshow_start(string_puppetshowId, enum_releaseRegion) {
	let_memAccessor_PuppetshowManagerPointer = dword(memory_getAddress(DATATYPE_32BitPointer, "Puppetshow_Manager", enum_releaseRegion))
	return 
		is_PuppetshowID(string_puppetshowId, enum_releaseRegion)
		&& let_memAccessor_PuppetshowManagerPointer > 0 // <-- When this pointer is functional, the puppetshow is active
		&& prev(let_memAccessor_PuppetshowManagerPointer) == 0}

function on_Puppetshow_end(string_puppetshowId, enum_releaseRegion) {
	let_memAccessor_PuppetshowManagerPointer = dword(memory_getAddress(DATATYPE_32BitPointer, "Puppetshow_Manager", enum_releaseRegion))
	return 
		wasPrev_PuppetshowID(string_puppetshowId, enum_releaseRegion)
		&& let_memAccessor_PuppetshowManagerPointer == 0 // <-- When this pointer is functional, the puppetshow is active
		&& prev(let_memAccessor_PuppetshowManagerPointer) > 0}

// .............
// ◦ GAME MODE ◦
// '''''''''''''
GAMEMODE_MainMenu = 1
GAMEMODE_SinglePlayer = 10
GAMEMODE_ShowdownMode = 20
const_GameMode_data = {
	GAMEMODE_SinglePlayer: {"ID": 0xFA},
	GAMEMODE_ShowdownMode: {"ID": 0xC8},
	GAMEMODE_MainMenu: {"ID": 0xA}}

function current_NumberOfPlayers(enum_releaseRegion) =>
	byte(memory_getAddress(DATATYPE_8Bit, "NumberOfPlayers", enum_releaseRegion))

function get_GameMode_ID(enum_gameState) =>
	const_GameMode_data[enum_gameState]["ID"]

function current_GameMode(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "GameMode", enum_releaseRegion))

function prev_GameMode(enum_releaseRegion) => 
	prev(current_GameMode(enum_releaseRegion))

function is_GameMode(enum_gameState, enum_releaseRegion) => 
	current_GameMode(enum_releaseRegion) == get_GameMode_ID(enum_gameState)

function on_GameMode_changeTo(enum_gameState, enum_releaseRegion) => 
	current_GameMode(enum_releaseRegion) == get_GameMode_ID(enum_gameState) 
	&& prev_GameMode(enum_releaseRegion) != get_GameMode_ID(enum_gameState)

function is_AtMainMenu(enum_releaseRegion) =>
	is_GameMode(GAMEMODE_MainMenu, enum_releaseRegion)

function is_Playing_SinglePlayerCampaign(enum_releaseRegion) =>
	is_GameMode(GAMEMODE_SinglePlayer, enum_releaseRegion) 
	&& current_NumberOfPlayers(enum_releaseRegion) == 1

function is_Playing_ShowdownMode_short(enum_releaseRegion) =>
	is_GameMode(GAMEMODE_ShowdownMode, enum_releaseRegion)

function is_Playing_ShowdownMode_long(enum_releaseRegion) =>
	is_GameMode(GAMEMODE_ShowdownMode, enum_releaseRegion)
	&& current_NumberOfPlayers(enum_releaseRegion) > 1

function is_Playing_BountyHunterMode(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsPlayingBountyHunterMode", enum_releaseRegion)) == 1
	&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)

function is_Playing_BountyHunterMode_short(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsPlayingBountyHunterMode", enum_releaseRegion)) == 1
// ------------------------------------------------------
CREDITS_AUDIO_FILE_NAME = "ENDCREDITS_PS2.stm"
function on_EndingCreditsVideo_start(enum_releaseRegion) {
	let_memAddr_EndingCreditsFlag = memory_getAddress(DATATYPE_ASCII, "EndingCreditsFlag", enum_releaseRegion)
	return on_ASCII_changeTo(let_memAddr_EndingCreditsFlag, CREDITS_AUDIO_FILE_NAME)} 

// ------------------------------------------------------
function is_InGame(enum_releaseRegion) => 
	bit0(memory_getAddress(DATATYPE_BitFlag, "IsInGame", enum_releaseRegion)) == 1

function on_InGame_start(enum_releaseRegion) {
	let_memAccessor_IsInGame = bit0(memory_getAddress(DATATYPE_BitFlag, "IsInGame", enum_releaseRegion))
	return 
		let_memAccessor_IsInGame > prev(let_memAccessor_IsInGame)}

function on_QuitToMainMenu(enum_releaseRegion) => // Quiting game via pause menu
	on_GameMode_changeTo(GAMEMODE_MainMenu, enum_releaseRegion)

// ......................
// ◦ EXTRA MISSION DATA ◦
// ''''''''''''''''''''''
const_ExtraMission_data = {
	AREA_Campaign_TheTraitor: [
		"BitFlag_IsAlliedCannonA_Destroyed",
		"BitFlag_IsAlliedCannonB_Destroyed",
		"BitFlag_IsAlliedCannonC_Destroyed",
		"BitFlag_IsAlliedCannonD_Destroyed",
		"BitFlag_IsAlliedCannonE_Destroyed",
		"BitFlag_IsAlliedCannonF_Destroyed",
		"BitFlag_IsAlliedCannonG_Destroyed",
		"BitFlag_IsAlliedCannonH_Destroyed"]}


// TODO refactor this like for AREA_Campaign_TheTraitor
ROGUEVALLEY_TREASURE_A = "BitFlag_IsTreasureAOpened"
ROGUEVALLEY_TREASURE_B = "BitFlag_IsTreasureBOpened"
ROGUEVALLEY_TREASURE_C = "BitFlag_IsTreasureCOpened"

function on_RogueValley_Treasure_find(enum_rogueValleyTreasureId, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Extra_Mission_Data", enum_releaseRegion)
	let_memAccessor_IsTreasureFound = memory_generateAddAddressPointerChain(
		"Struct_Extra_Mission_Data.RogueValley", enum_rogueValleyTreasureId, 
		let_memAddr_basePointer, accessor = bit0)		
	return let_memAccessor_IsTreasureFound > prev(let_memAccessor_IsTreasureFound)}

function is_TheTraitor_AllyCannon_destroyed(string_pointerChainKey_toBitflag, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Extra_Mission_Data", enum_releaseRegion)
	let_memAccessor_IsCannonDestroyed = memory_generateAddAddressPointerChain(
		"Struct_Extra_Mission_Data.TheTraitor", string_pointerChainKey_toBitflag, 
		let_memAddr_basePointer, accessor = bit0)		
	return let_memAccessor_IsCannonDestroyed}

function current_Calculated_AllyCannonsDestroyedCount(enum_releaseRegion) =>
	sum_of([
		"BitFlag_IsAlliedCannonA_Destroyed", "BitFlag_IsAlliedCannonB_Destroyed",
		"BitFlag_IsAlliedCannonC_Destroyed", "BitFlag_IsAlliedCannonD_Destroyed",
		"BitFlag_IsAlliedCannonE_Destroyed", "BitFlag_IsAlliedCannonF_Destroyed",
		"BitFlag_IsAlliedCannonG_Destroyed", "BitFlag_IsAlliedCannonH_Destroyed"],
		string_pointerChainKey_toBitflag => is_TheTraitor_AllyCannon_destroyed(string_pointerChainKey_toBitflag, enum_releaseRegion))

// ..........
// ◦ TIMERS ◦
// ''''''''''
function current_TimeSpentInMission(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "Mission_Timers", enum_releaseRegion)
	let_offsetTo_TimeSpentInMission = memory_getDataStructOffset("Struct_Mission_Timers", "Float_TimeSpentinMission")
	return float(dword(let_memAddr_BasePointer) + let_offsetTo_TimeSpentInMission)}

// ............
// ◦ SHOWDOWN ◦
// ''''''''''''
SHOWDOWN_TEAM_RED = 0
SHOWDOWN_TEAM_WHITE = 1
SHOWDOWN_TEAM_BLUE = 2
SHOWDOWN_TEAM_YELLOW = 3		

// --------------------Showdown_PosterMenu_Controller------------------------ // Unused code
function current_FlagState_IsShowdownPosterMenuDisplayed(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return memory_generateAddAddressPointerChain(
		"Struct_GameController", "BitFlag_IsShowdownPosterMenuDisplayed", let_memAddr_BasePointer)}

function is_ShowdownPosterMenu_displayed(enum_releaseRegion) =>
	current_FlagState_IsShowdownPosterMenuDisplayed(enum_releaseRegion) == 1

function current_FlagState_PosterMenu_IsShowdownPlayerSlotFilled(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	let_string_pointerChainKey = format("BitFlag_IsShowdownPlayerSlot{0}Filled", int_playerIndex)
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	return memory_generateAddAddressPointerChain(
		"Struct_GameController", let_string_pointerChainKey, let_memAddr_BasePointer, accessor = bit0)}

function is_PosterMenu_ShowdownPlayerSlot_filled(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_FlagState_PosterMenu_IsShowdownPlayerSlotFilled(int_playerIndex, enum_releaseRegion) == 1

function current_Calculated_PosterMenu_ActiveShowdownPlayers(enum_releaseRegion) {
	let_array_ShowdownPlayerIndices = [1,2,3,4]
	return sum_of(let_array_ShowdownPlayerIndices, int_playerIndex => 
		current_FlagState_PosterMenu_IsShowdownPlayerSlotFilled(int_playerIndex, enum_releaseRegion))}

function is_PosterMenu_ShowdownPlayerCharacter(int_playerIndex, enum_character, enum_releaseRegion) { // Player Index [1-4]
	let_string_pointerChainKey = format("ASCII_ShowdownPlayer{0}CharacterModelId", int_playerIndex)
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "GameController", enum_releaseRegion)
	let_PointerChainTo_ShowdownPlayerCharacterModelId = memory_generateAddAddressPointerChain(
		"Struct_GameController", let_string_pointerChainKey, let_memAddr_BasePointer)
	return is_ASCII_EqualTo(let_PointerChainTo_ShowdownPlayerCharacterModelId, enum_character)}

// --------------------ShowdownPlayer_Settings------------------------
SHOWDOWN_AI_SETTING_HumanPlayer = "MPplayer"

function is_ShowdownPlayerCharacter(int_playerIndex, enum_character, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1	
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array_ShowdownPlayer_Settings_B", enum_releaseRegion)
	let_memAddr_CharacterModelID = 
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getDataStructSizeInBytes("Struct_ShowdownPlayer_Settings_B"))
		+ memory_getDataStructOffset("Struct_ShowdownPlayer_Settings_B", "ASCII_CharacterModelId")
	return is_ASCII_EqualTo(let_memAddr_CharacterModelID, enum_character)}

function is_ShowdownPlayer_HumanPlayer(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1	
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array_ShowdownPlayer_Settings_B", enum_releaseRegion)
	let_memAddr_ShowdownAIsetting = 
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getDataStructSizeInBytes("Struct_ShowdownPlayer_Settings_B"))
		+ memory_getDataStructOffset("Struct_ShowdownPlayer_Settings_B", "ASCII_ShowdownAIsetting")
	return is_ASCII_EqualTo(let_memAddr_ShowdownAIsetting, SHOWDOWN_AI_SETTING_HumanPlayer)}

function is_ShowdownPlayer_CPUPlayer(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1	
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array_ShowdownPlayer_Settings_B", enum_releaseRegion)
	let_memAddr_ShowdownAIsetting = 
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getDataStructSizeInBytes("Struct_ShowdownPlayer_Settings_B"))
		+ memory_getDataStructOffset("Struct_ShowdownPlayer_Settings_B", "ASCII_ShowdownAIsetting")
	return is_ASCII_notEqualTo(let_memAddr_ShowdownAIsetting, SHOWDOWN_AI_SETTING_HumanPlayer)}

function is_ShowdownPlayer_Team(int_playerIndex, enum_showdownTeam, enum_releaseRegion) { // Player Index [1-4]
	let_playerIndex = int_playerIndex - 1
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array_ShowdownPlayer_Settings_B", enum_releaseRegion)
	let_memAddr_TeamId =
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getDataStructSizeInBytes("Struct_ShowdownPlayer_Settings_B"))
		+ memory_getDataStructOffset("Struct_ShowdownPlayer_Settings_B", "Lower4_TeamId")
	return low4(let_memAddr_TeamId) == enum_showdownTeam
}

// --------------------ShowdownMode_Settings------------------------
SHOWDOWN_MODE_BountyHunter = 0 
SHOWDOWN_MODE_Sundown = 1 
SHOWDOWN_MODE_HighNoon = 2 

function is_Showdown_Mode(enum_showdownMode, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "ShowdownMode_Settings", enum_releaseRegion)
	let_offsetTo_Member = memory_getDataStructOffset("Struct_ShowdownMode_Settings", "Lower4_GameMode")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_showdownMode}

SHOWDOWN_BOUNTY_LIMIT_3K = 0 
SHOWDOWN_BOUNTY_LIMIT_5K = 1 
SHOWDOWN_BOUNTY_LIMIT_10K = 2 
SHOWDOWN_BOUNTY_LIMIT_15K = 2 
SHOWDOWN_BOUNTY_LIMIT_20K = 4 

function is_Showdown_BountyLimit(enum_showdownBountyLimit, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "ShowdownMode_Settings", enum_releaseRegion)
	let_offsetTo_Member = memory_getDataStructOffset("Struct_ShowdownMode_Settings", "Lower4_BountyLimit")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_showdownBountyLimit}

SHOWDOWN_SUNDOWN_FIGHT_TIME_3min = 0 
SHOWDOWN_SUNDOWN_FIGHT_TIME_5min = 1 
SHOWDOWN_SUNDOWN_FIGHT_TIME_10min = 2 
SHOWDOWN_SUNDOWN_FIGHT_TIME_15min = 3 
SHOWDOWN_SUNDOWN_FIGHT_TIME_1min = 4 

function is_Showdown_SundownFightTime(enum_sundownFightTime, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "ShowdownMode_Settings", enum_releaseRegion)
	let_offsetTo_Member = memory_getDataStructOffset("Struct_ShowdownMode_Settings", "Lower4_SundownFightTime")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_sundownFightTime}

SHOWDOWN_HIGH_NOON_REQUIRED_WINS_3 = 0
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5 = 1
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_7 = 2
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_10 = 3
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_1 = 4

function is_Showdown_HighNoonRequiredWins(enum_highNoonRequiredWins, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "ShowdownMode_Settings", enum_releaseRegion)
	let_offsetTo_Member = memory_getDataStructOffset("Struct_ShowdownMode_Settings", "Lower4_HighNoonRequiredWins")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_highNoonRequiredWins}

SHOWDOWN_POWER_UPS_SETTING_Off = 0
SHOWDOWN_POWER_UPS_SETTING_Stud = 1
SHOWDOWN_POWER_UPS_SETTING_HoldEm = 2 

function is_Showdown_PowerUpSetting(enum_powerUpsSetting, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "ShowdownMode_Settings", enum_releaseRegion)
	let_offsetTo_Member = memory_getDataStructOffset("Struct_ShowdownMode_Settings", "Lower4_PowerUpSetting")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_powerUpsSetting}

// --------------------MultiplayerRewardMenu------------------------
function is_ShowdownPlayer_Winner(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))
		
	ASCII_FLAG_IsPlayerWinner = "Winner"
	
	let_string_pointerChainKey = format("ASCII_Flag_IsPlayer{0}Winner", int_playerIndex)
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MultiplayerRewardMenu_Data", enum_releaseRegion)
	let_pointerChainTo_ASCII = memory_generateAddAddressPointerChain(
		"Struct_MultiplayerRewardMenu_Data", let_string_pointerChainKey, let_memAddr_BasePointer, accessor = dword)
	let_offsetTo_ASCII = memory_getPointerChainOffsetToMember("Struct_MultiplayerRewardMenu_Data", let_string_pointerChainKey)
	return is_ASCII_EqualTo(let_pointerChainTo_ASCII + let_offsetTo_ASCII, ASCII_FLAG_IsPlayerWinner)}

function is_MultiplayerRewardMenu_displayed(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MultiplayerRewardMenu_Data", enum_releaseRegion)
	let_memAccessor_InnerPointer = memory_generateAddAddressPointerChain(
		"Struct_MultiplayerRewardMenu_Data", "32BitPointer_28", let_memAddr_BasePointer, accessor = dword)
	return let_memAccessor_InnerPointer > 0}

function on_MultiplayerRewardMenu_render_short(enum_releaseRegion) {
	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MultiplayerRewardMenu_Data", enum_releaseRegion)
	let_memAccessor_InnerPointer = memory_generateAddAddressPointerChain(
		"Struct_MultiplayerRewardMenu_Data", "32BitPointer_28", let_memAddr_BasePointer, accessor = dword)
	return 
		let_memAccessor_InnerPointer > 0 
		&& prev(let_memAccessor_InnerPointer) == 0}

function on_MultiplayerRewardMenu_render_long(enum_releaseRegion) {
	ASCII_FLAG_IsMultiplayerRewardMenuDisplayed = "mpRewards_new3"

	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MultiplayerRewardMenu_Data", enum_releaseRegion)
	let_memAddr_ASCII = memory_generateAddAddressPointerChain(
		"Struct_MultiplayerRewardMenu_Data", "ASCII_Flag_IsMultiplayerRewardMenuDisplayed", let_memAddr_BasePointer)
	return 
		is_ASCII_EqualTo(let_memAddr_ASCII, ASCII_FLAG_IsMultiplayerRewardMenuDisplayed)
		&& wasPrev_ASCII_notEqualTo(let_memAddr_ASCII, ASCII_FLAG_IsMultiplayerRewardMenuDisplayed)}

function is_MultiplayerRewardPopupMenu_Replay_Highlighted(enum_releaseRegion) {
	const_REPLAY = 0

	let_memAddr_BasePointer = memory_getAddress(DATATYPE_32BitPointer, "MultiplayerRewardMenu_UI_Controller", enum_releaseRegion)
	let_memAccessor_HighlightedMenuItem = memory_generateAddAddressPointerChain(
		"Struct_MultiplayerRewardMenu_UI_Controller", "32Bit_HighlightedPopupMenuItem", let_memAddr_BasePointer, accessor = dword)
	return let_memAccessor_HighlightedMenuItem == const_REPLAY}

function on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion) => 
	is_MultiplayerRewardPopupMenu_Replay_Highlighted(enum_releaseRegion)
	&& is_PlayerInput_ConfirmBtn_pressed(enum_releaseRegion)


// .........
// ◦ OTHER ◦
// '''''''''
// --------------------GatlingGunZone------------------------
function is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion) {
	const_INTERACTABLE_ZONE_ID = "zone_gunA_01"
	let_memAddr_GatlingGunZoneData = memory_getAddress(DATATYPE_32BitPointer, "GatlingGunZone_Data", enum_releaseRegion)
	let_pointerChainTo_InteractableZoneID = 
		dword(let_memAddr_GatlingGunZoneData)
		+ memory_getDataStructOffset("Struct_GatlingGunZone_Data", "ASCII_InteractableZoneID")
	return is_ASCII_EqualTo(let_pointerChainTo_InteractableZoneID, const_INTERACTABLE_ZONE_ID)}

function current_FlagState_IsGatlingGunManned(enum_releaseRegion) {
	let_memAddr_GatlingGunZoneData = memory_getAddress(DATATYPE_32BitPointer, "GatlingGunZone_Data", enum_releaseRegion)
	return bit0(
		dword(let_memAddr_GatlingGunZoneData)
		+ memory_getDataStructOffset("Struct_GatlingGunZone_Data", "BitFlag_IsGatlingGunManned")
	)}

function prev_FlagState_IsGatlingGunManned(enum_releaseRegion) =>
	prev(current_FlagState_IsGatlingGunManned(enum_releaseRegion))

function is_GatlingGun_manned(enum_releaseRegion) =>
	is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion)
	&& current_FlagState_IsGatlingGunManned(enum_releaseRegion) == 1

function is_GatlingGun_unmanned(enum_releaseRegion) =>
	is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion)
	&& current_FlagState_IsGatlingGunManned(enum_releaseRegion) == 0

function on_GatlingGun_man(enum_releaseRegion) =>
	is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion)
	&& current_FlagState_IsGatlingGunManned(enum_releaseRegion) > prev_FlagState_IsGatlingGunManned(enum_releaseRegion)

function on_GatlingGun_unman(enum_releaseRegion) =>
	is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion)
	&& current_FlagState_IsGatlingGunManned(enum_releaseRegion) < prev_FlagState_IsGatlingGunManned(enum_releaseRegion)

function is_PlayerUsing_GatlingGun(enum_areaId, enum_releaseRegion) => 
	is_PlayerPosition_atGatlingGun(enum_areaId, enum_releaseRegion)
	&& is_GatlingGun_manned(enum_releaseRegion)

function is_PlayerNotUsing_GatlingGun(enum_areaId, enum_releaseRegion) => 
	!is_PlayerPosition_atGatlingGun(enum_areaId, enum_releaseRegion)
	&& is_GatlingGun_unmanned(enum_releaseRegion)

function on_PlayerGatlingGun_mount(enum_areaId, enum_releaseRegion) =>
	is_PlayerPosition_atGatlingGun(enum_areaId, enum_releaseRegion)
	&& on_GatlingGun_man(enum_releaseRegion)

function on_PlayerGatlingGun_dismount(enum_areaId, enum_releaseRegion) =>
	is_PlayerPosition_atGatlingGun(enum_areaId, enum_releaseRegion)
	&& on_GatlingGun_unman(enum_releaseRegion)

// --------------------MissionKillcount------------------------
function current_MissionKillcount(enum_releaseRegion) {
	let_memAddr_UndefinedStruct = memory_getAddress(DATATYPE_32BitPointer, "Undefined_Struct_03", enum_releaseRegion)
	let_PointerChainTo_MissionKillcount = 
		dword(let_memAddr_UndefinedStruct)
		+ memory_getDataStructOffset("Undefined_Struct_03", "32Bit_MissionKillcount")
	return dword(let_PointerChainTo_MissionKillcount)}

function prev_MissionKillcount(enum_releaseRegion) =>
	prev(current_MissionKillcount(enum_releaseRegion))

function on_MissionKillcount_increment(enum_releaseRegion) =>
	current_MissionKillcount(enum_releaseRegion) > prev_MissionKillcount(enum_releaseRegion)

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
// TODO check if c_StoryChallenge is actually achievements_TYPE_Missable => perhaps achievements_TYPE_Standard fits better
achievements_coreData = { // TODO recheck scoring on c_BountyHunter & c_StoryChallenge based on challenge difficulty
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
		"a_CompleteChapter1": { // VERIFIED
			"id": 448757, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 1"},
		"a_CompleteChapter2": { // VERIFIED
			"id": 448758, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 2"},
		"a_CompleteChapter3": { // VERIFIED
			"id": 447279, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 3"},
		"a_CompleteChapter5": { // VERIFIED
			"id": 447280, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 5"},
		"a_CompleteChapter6": { // VERIFIED
			"id": 448763, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 6"},
		"a_CompleteChapter7": { // VERIFIED
			"id": 447281, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 7"},
		"a_CompleteChapter8": { // VERIFIED
			"id": 448761, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 8"},
		"a_CompleteChapter10": { // VERIFIED
			"id": 447270, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 10"},
		"a_CompleteChapter11": { // VERIFIED
			"id": 447271, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 11"},
		"a_CompleteChapter12": { // VERIFIED
			"id": 448765, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 12"},
		"a_CompleteChapter13": { // VERIFIED
			"id": 447272, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 13"},
		"a_CompleteChapter14": { // VERIFIED
			"id": 448764, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 14"},
		"a_CompleteChapter15": { // VERIFIED
			"id": 447273, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 15"},
		"a_CompleteChapter17": { // VERIFIED
			"id": 447274, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 17"},
		"a_CompleteChapter19": { // VERIFIED
			"id": 447275, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 19"},
		"a_CompleteChapter20": { // VERIFIED
			"id": 447276, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 20"},
		"a_CompleteChapter22": { // VERIFIED
			"id": 447277, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 22"},
		"a_CompleteChapter24": { // VERIFIED
			"id": 447278, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 24"},
		"a_CompleteChapter25": { // VERIFIED
			"id": 443871, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 25"},
		"a_CompleteChapter27": { // VERIFIED
			"id": 443703, "points": achievement_POINTS_Basic, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete Chapter 27"},
		},
	"c_Showdown": { // Category - Showdown related achievements
		"a_BountyHunterKatie": { // TODO rewrite according to desciption
			"id": 454648, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Standard,
			"devInfo": "As Katie O'Grady, with Sherrif O'Grady as your ally win a 10k target Bounty Hunter match against a team of Ugly Chris and Gigolo Hancock in Widow's Patch"},
		// "a_BountyHunterBlade": { // CONCEPT a_BountyHunterBlade
		// 	"id": 000000, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As The Blade Slade, win a free-for-all 10k target Bouny Hunter match against Sissy Fess, Rico Pedrosa and Udo Kang in Sunset Canyon, using only knives"},
		// "a_BountyHunterAnnie": { // CONCEPT a_BountyHunterAnnie
		// 	"id": 0000000, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Annie Stoakes, win a 10k target Bounty Hunter match against a team of Governor Griffon, Holstein Hal, and Sam on The Ranch"},
		// "a_BountyHunterCooper": { // CONCEPT a_BountyHunterCooper
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Cooper, win a 10k target Bounty Hunter match against a team of Jason Cornet, Sheriff Bartlett and Sheriff O'Grady on Fairground"},
		// "a_BountyHunterWeapons": { // CONCEPT a_BountyHunterWeapons
		//	"id": 000000, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 4 player free-for-all Bounty Hunter match by killing opponents with 7 different weapons"},
		// "a_SundownFallenStar": { // CONCEPT a_SundownFallenStar
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Falling Star, with Shadow Wolf as your ally, win a 5 minute Sundown match against a team of Grizzly and Standing Snake in Fallen Creek"},
		// "a_SundownBlack": { // CONCEPT a_SundownBlack
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Mr. Black, win a 5 minute free-for-all Sundown match against Bad Bessie, Ugly Chris and Pig Josh in Ghost Town"},
		// "a_SundownGriffon": { // CONCEPT a_SundownGriffon
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Governor Griffon, win a 5 minute Sundown match against a team of Nate Harlow, Falling Star, and Red in Broken Creek"},
		// "a_SundownNate": { // CONCEPT a_SundownNate
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Nate Harlow, win a 5 minute Sundown match against a team of Governor Griffon, Colonel Daren, and General Diego in The Mansion"},
		// "a_SundownFlawless": { // CONCEPT a_SundownFlawless
		//	"id": 000000, "points": achievement_POINTS_Basic, "type": achievements_TYPE_Standard,
		//	"devInfo": "Win a 4 player free-for-all sundown match without dying once"},
		// "a_HighNoonNatalie": { // CONCEPT a_HighNoonNatalie
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Natalie, with Mr. Kelley as your ally, win a best of 5 High Noon match against a team of Red Jr. and Nate Harlow on Mansion Grounds"},
		// "a_HighNoonCurly": { // CONCEPT a_HighNoonCurly
		// 	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Standard,
		// 	"devInfo": "As Curly Shaw, win a best of 5, free-for-all High Noon match against Bloody Tom, Big Oaf Whitney, and Twiggy Phelps in Twin Rocks"},		
		},
	"c_Unlocks": { // Category - Unlocking items
		"a_UnlockStagesAll": { // VERIFIED
			"id": 444065, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Unlock all 13 Showdown stages"},
		"a_UnlockCharactersHalf": { // VERIFIED
			"id": 447034, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Unlock 24 Showdown characters"},
		"a_UnlockCharactersAll": { // VERIFIED
			"id": 444067, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
			"devInfo": "Unlock all 48 Showdown characters"},
		"a_CompleteJournalHalf": { // VERIFIED
			"id": 444490, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete 50% of the journal"},
		"a_CompleteJournalAll": { // VERIFIED
			"id": 444489, "points": achievement_POINTS_Hard, "type": achievements_TYPE_Standard,
			"devInfo": "Complete 100% of the journal"},
		"a_MaxHealth": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 444063, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 7 health upgrades for Red"},
		"a_MaxDeadEye": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 444062, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 5 Dead Eye upgrades for Red"},
		// "a_UnlockAllWeapons": { // VERIFIED // DISABLED - Manual edit via RAIntegration - as this still uses SubSources // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			// 	"id": 439051, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			// 	"devInfo": "Unlock all unique weapons in the Story Campaign"},
		"a_UpgradeAllWeapons": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 439234, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 16 upgradable weapons in the Story Campaign"},
		},
	"c_BountyHunter": { // QA category c_BountyHunter
		// "a_BountyCompletionAll": { // DISABLED not cheat protected // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
		// 	"id": 0000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
		// 	"devInfo": "Complete all the Bounty Hunter Mode Missions"},
		"a_BountyHuntChapter1": { // VERIFIED
			"id": 444681, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 1"},
		"a_BountyHuntChapter2": { // VERIFIED
			"id": 443870, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 2"},
		"a_BountyHuntChapter3": { // VERIFIED
			"id": 443872, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 3"},
		"a_BountyHuntChapter5": { // VERIFIED
			"id": 449110, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 5"},
		"a_BountyHuntChapter6": { // VERIFIED
			"id": 449109, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 6"},
		"a_BountyHuntChapter7": { // VERIFIED
			"id": 444682, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 7"},
		"a_BountyHuntChapter8": { // VERIFIED
			"id": 449108, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 8"},
		"a_BountyHuntChapter9": { // VERIFIED
			"id": 449107, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 9"},
		"a_BountyHuntChapter11": { // VERIFIED
			"id": 449101, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 11"},
		"a_BountyHuntChapter12": { // VERIFIED
			"id": 449100, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 12"},
		"a_BountyHuntChapter13": { // VERIFIED
			"id": 449099, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 13"},
		"a_BountyHuntChapter14": { // VERIFIED
			"id": 449098, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 14"},
		"a_BountyHuntChapter15": { // VERIFIED
			"id": 449097, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 15"},
		"a_BountyHuntChapter17": { // VERIFIED
			"id": 449096, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 17"},
		"a_BountyHuntChapter18": { // VERIFIED
			"id": 449064, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 18"},
		"a_BountyHuntChapter20": { // VERIFIED
			"id": 449106, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 20"},
		"a_BountyHuntChapter21": { // VERIFIED
			"id": 449105, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 21"},
		"a_BountyHuntChapter24": { // VERIFIED
			"id": 449104, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 24"},
		"a_BountyHuntChapter25": { // VERIFIED
			"id": 449103, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 25"},
		"a_BountyHuntChapter27": { // VERIFIED
			"id": 449102, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 27"},
		},
	"c_StoryChallenge": { // Category -  Story related challenge achievements // TODO Allow certain Very Hard achievements on Red Wood Revolver difficulty as well??
		// "a_BigMoney": { // VERIFIED // DISABLED - Manual edit via RAIntegration - as an AddSource chain is unable to generated by RATools 
			// "id": 447721, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			// "devInfo": "Amass an amount of cash on a one player profile"},
		// "a_FlawlessDuel3": { // CONCEPT a_FlawlessDuel3
		//	"id": 0000000, "points": achievement_POINTS_xxxxxxx, "type": achievements_TYPE_Missable,
		//	"devInfo": "Win a duel vs 3 opponents without taking damage"},
		"a_PerfectShootingTutorial": { // VERIFIED
			"id": 438301, "points": achievement_POINTS_Minor, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Bull's Eye' | Finish tutorial without wasting ammo (13 targets to hit)"},
		"a_SaveCurly": { // VERIFIED
			"id": 449378, "points": achievement_POINTS_Minor, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Rogue Valley' | After saving Curly Shaw, pick up the $1500 pouch he drops near him"},
		// "a_ChallengeChapter1": { // VERIFIED // DISABLED - Manual edit via RAIntegration - as an AddSource chain is unable to generated by RATools  
			// "id": 438677, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			// "devInfo": "Level 'Bull's Eye' | Complete with a bounty collected of $1000 or greater | Very Hard"},
		"a_ChallengeChapter2": { // VERIFIED
			"id": 450183, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Bounty Hunter' | Complete with 'No HUD' cheat and with damage taken less than 50% | Hard or Very Hard"},
		"a_ChallengeChapter3": { // VERIFIED
			"id": 450198, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Ugly Streetfight' | Complete without using any healing items | Very Hard"},
		"a_ChallengeChapter5": { // VERIFIED
			"id": 439585, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Railroaded' | Complete the mission without falling of the train | Hard or Very Hard"},
		"a_ChallengeChapter6": { // VERIFIED
			"id": 450325, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Carinval Life' | Get a killstreak of 10 using the gatling gun without letting go off the trigger | Hard or Very Hard"},
		"a_ChallengeChapter7": { // VERIFIED
			"id": 450393, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Freak Show' | Complete with 65% accuracy or higher | Very Hard"},
		"a_ChallengeChapter8": { // VERIFIED
			"id": 451482, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Rogue Valley' | Complete with 'Bite the Bullet' cheat | Very Hard"},
		"a_ChallengeChapter10": { // VERIFIED
			"id": 450554, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'The Cemetery' | Complete with 'No Distortion', 'Sad Stars' and 'No HUD' cheats | Hard or Very Hard"}, 
		"a_ChallengeChapter11": { // VERIFIED
			"id": 450845, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Range War' | Ride a bison and kill 15 enemies | Hard or Very Hard"},
		"a_ChallengeChapter12": { // VERIFIED
			"id": 450557, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Bar Fight' | Complete will full hp at end | Very Hard"},
		"a_ChallengeChapter13": { // VERIFIED
			"id": 450844, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'The Traitor' | Win the battle with 5 allied cannons still operational | Hard or Very Hard"},
		"a_ChallengeChapter14": { // VERIFIED
			"id": 450691, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Sunset Canyon' | Complete with less than 90% damage taken | Very Hard"},
		"a_ChallengeChapter15": { // VERIFIED
			"id": 450888, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Bear Mountain' | Kill Grizzly only using gun 'Faith' | Very Hard"},
		"a_ChallengeChapter17": { // VERIFIED
			"id": 450889, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'The Mine' | Complete using only a knife to damage enemies, in under 1 minute | Hard or Very Hard"},
		"a_ChallengeChapter19": { // VERIFIED
			"id": 451499, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Hell Pass' | Complete with the coach's HP above 40%, using only Buffalo Soldier's dead eye ability to shoot, 'infinite DeadEye' cheat required, melee is allowed | Hard or Very Hard"},
		"a_ChallengeChapter20": { // VERIFIED 
			"id": 451481, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Fort Diego' | Kill 12 enemies with head shots | Very Hard"},
		"a_ChallengeChapter22": { // VERIFIED
			"id": 450943, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Devils and Angels' | Complete in under xxx time and only killing General Diego | Hard or Very Hard"},
		"a_ChallengeChapter24": { // VERIFIED
			"id": 451042, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Battle Finale' | Complete scoring 5 headshots on Mr. Kelley and without letting any bystanders die | Very Hard"},
		"a_ChallengeChapter25": { // VERIFIED
			"id": 451044, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Siege' | Complete with both Jack's and Annie's HP above 75% , 'Golden Gun' cheat required | Hard or Very Hard"},
		"a_ChallengeChapter27": { // VERIFIED
			"id": 450558, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Fall From Grace' | Complete with an accuracy of 70% or higher AND damage taken less than 50% | Very Hard"},
		"a_WoodChapter8": { // QA a_WoodChapter8
			"id": 453665, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Rogue Valley' | Complete with 'Bite the Bullet' cheat enabled | Red Wood Revolver"},
		"a_WoodChapter10": { // QA a_WoodChapter10
			"id": 453664, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'The Cemetery' | Only damage enemies with the 'Infinite Deadeye' cheat, melee attacks allowed, shooting isn't | Red Wood Revolver"},
		},
	}

// ===================================
// • Achievements TRIGGER GENERATORS •
// ===================================
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_3x_AltResetGroup_OnRestartMission(enum_areaId, enum_releaseRegion) => // TODO implement achievements_generate_3x_AltResetGroup_OnRestartMission() in most mission achievements 
	// [1] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
		never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_RetryMenu_yes(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))

	// [2] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_WarningMenu_yes(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))

	// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on RewardMenu->Replay
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_RewardMenu_Replay_confirm(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))	

function achievements_generate_Check_HasPlayerStartedMissionFromStart(enum_areaId, enum_releaseRegion) =>
	once(
		is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))
	&& once(
		is_PlayerPosition_atMissionStartPoint(enum_areaId, enum_releaseRegion)
		&& is_AreaState_InGame(enum_releaseRegion))

function achievements_generate_PauseLock_CheatProtection(enum_releaseRegion) => 
	unless(once( // <-- Pause Lock: Cheat Protection
		is_AnyCheat_active(enum_releaseRegion)))

function achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion) =>
	once(
		never(is_StartChpMenu_active(enum_releaseRegion)) // <-- ResetNextIf necessary otherwise some StartChpMenu's may add hit counts
		&& on_RewardMenu_render_long(enum_releaseRegion))

function achievements_generate_FullTrigger_BountyHuntCompletion(enum_areaId, enum_releaseRegion) => // TODO implement everything wher applicabled achievements_generate_3x_AltResetGroup_OnRestartMission() - WRNING for checkpoints
	// ==== Core (Alt) Group ====			
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Playing_BountyHunterMode(enum_releaseRegion)
			|| !is_Area(enum_areaId, enum_releaseRegion))

		&& unless(once( // <-- Pause Lock: Cheat Protection
			is_AnyCheat_active(enum_releaseRegion)))

		&& once(on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
		&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
		&& is_RatingBounty_achieved(enum_releaseRegion)
		&& trigger_when(repeated(530, // <-- Delay: so the achievement pops when the reward unlocks UI is displayed 
			never(is_StartChpMenu_active(enum_releaseRegion))
			&& is_RewardMenu_displayed_long(enum_releaseRegion)))

	
	// ==== Alt Reset Group ==== 					-> Reset everything when at main menu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_AtMainMenu(enum_releaseRegion))

	// ==== Alt Pause Lock Reset Groups ====		-> Reset when pressing 'yes' on retryMenu after mission failure
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_RetryMenu_yes(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))

	// ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_WarningMenu_yes(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))


// ------------------ChapterCompletion----------------------
function achievements_generate_FullTrigger_ChapterCompletion_anyRating(enum_areaId, enum_releaseRegion) => // TODO refactor this so it looks like the other code logic
	// ==== Core (Alt) Group ====
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(!is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		&& achievements_generate_PauseLock_CheatProtection(enum_releaseRegion)

		&& achievements_generate_Check_HasPlayerStartedMissionFromStart(enum_areaId, enum_releaseRegion) // TODO change & test this line to on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion)
		&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
		&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects			
			never(is_StartChpMenu_active(enum_releaseRegion)) // <-- ResetNextIf necessary otherwise some StartChpMenu's may add hit counts
			&& is_RewardMenu_displayed_long(enum_releaseRegion)) 

	// ==== Alt Reset Group ====  Reset when not playing Single Player Campaign OR when not in correct AREA
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& (
				!is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| !is_Area(enum_areaId, enum_releaseRegion)
			))

	// ==== Alt Pause Lock Reset Group ==== Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
		// Don't reset on RetryMenu retry, only on mission restart
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& on_WarningMenu_yes(enum_releaseRegion))

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

	let_sumOf_AllWeaponFlags = memGenerate_SumOf_BitsetFlags_noSubSource(
		FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["AllFlags"],
		bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks, 
		enum_releaseRegion)
	let_sumOf_NonUniqueWeaponFlags = generate_SumOf_NonUniqueWeaponFlags(enum_releaseRegion)

	return 
		let_sumOf_AllWeaponFlags 
		- let_sumOf_NonUniqueWeaponFlags // Subtract non-unique flags
	}

function achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags_noSubSource(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllUpgradedWeapons"], bitFlagMemAccessorGenerator_toStaticBitset_SelectedPlayerProfileUnlocks, enum_releaseRegion)

// -------------------UnlocksOther---------------------
function achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags_noSubSource(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllHealthUpgrades"], bitFlagMemAccessorGenerator_toDynamicBitset_PlayerProfileUnlocks, enum_releaseRegion)

function achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags_noSubSource(FlagData_Bitset_PlayerProfileUnlocks["Flags_AllDeadEyeUpgrades"], bitFlagMemAccessorGenerator_toDynamicBitset_PlayerProfileUnlocks, enum_releaseRegion)

// ------------------ShowdownStages----------------------
function memAccessorGeneratorToBitset_ShowdownMapUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_ShowdownMapUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllStages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		FlagData_Bitset_ShowdownMapUnlocks, 
		memAccessorGeneratorToBitset_ShowdownMapUnlocks, 
		enum_releaseRegion)
// ------------------ShowdownCharacters----------------------
function memAccessorGeneratorToBitset_ShowdownCharactersUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_ShowdownCharacterUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		FlagData_Bitset_ShowdownCharactersUnlocks, 
		memAccessorGeneratorToBitset_ShowdownCharactersUnlocks, 
		enum_releaseRegion)
// ------------------JournalPages----------------------
function memAccessorGeneratorToBitset_JournalPageUnlocks(int_offsetToByte, memAccessor_bitFlagAccessor, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset_JournalPageUnlocks", enum_releaseRegion)
	return memAccessor_bitFlagAccessor(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		FlagData_Bitset_JournalPageUnlocks, 
		memAccessorGeneratorToBitset_JournalPageUnlocks, 
		enum_releaseRegion)

// ------------------BountyHunterMissions----------------------
function achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags_noSubSource(FlagData_Bitset_BountyHunterMissionsCompleted, bitFlagMemAccessorGenerator_toStaticBitset_BountyHunterMissionsCompleted, enum_releaseRegion) 

function achievements_generate_TallyOf_ShowdownTeamsFreeForAll(enum_releaseRegion) {
	let_array_ALL_SHOWDOWN_TEAM_IDs = [SHOWDOWN_TEAM_RED, SHOWDOWN_TEAM_WHITE, SHOWDOWN_TEAM_BLUE, SHOWDOWN_TEAM_YELLOW]
	let_PlayerSlot1_Index = 1
	let_PlayerSlot2_Index = 2
	let_PlayerSlot3_Index = 3
	let_PlayerSlot4_Index = 4
	return tally_of(let_array_ALL_SHOWDOWN_TEAM_IDs, length(let_array_ALL_SHOWDOWN_TEAM_IDs), int_showdownTeamId => // <---TallyOf--- Count if all 4 unique teams are present 
		once(
			is_ShowdownPlayer_Team(let_PlayerSlot1_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot2_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot3_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot4_Index, int_showdownTeamId, enum_releaseRegion)))}


// =========================
// • Achievements TRIGGERS •
// =========================
achievements_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>  // WIP_template
	// 	// ==== Core (Alt) Group ====
	// 		is_ReleaseRegion(enum_releaseRegion) 
	// 		&& always_false()
	// 	),

	"a_CompleteChapter1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"a_CompleteChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"a_CompleteChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"a_CompleteChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"a_CompleteChapter6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"a_CompleteChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"a_CompleteChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"a_CompleteChapter10": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"a_CompleteChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"a_CompleteChapter12": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"a_CompleteChapter13": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"a_CompleteChapter14": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"a_CompleteChapter15": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"a_CompleteChapter17": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_TheMine, enum_releaseRegion)),
	"a_CompleteChapter19": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_HellPass, enum_releaseRegion)),
	"a_CompleteChapter20": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"a_CompleteChapter22": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"a_CompleteChapter24": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"a_CompleteChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_Siege, enum_releaseRegion)),
	"a_CompleteChapter27": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion_anyRating(AREA_Campaign_FallFromGrace, enum_releaseRegion)
	),
	"a_CompleteStoryNormal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Normal // <---2Lines--- unlock this achievement on any difficulty, without using orNext or altGroups
		&& current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Hard // <---2Lines--- unlock this achievement on any hard or veryHard, without using orNext or altGroups
		&& current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryVeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion)
		&& on_EndingCreditsVideo_start(enum_releaseRegion)),
	"a_CompleteStoryWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
		// ==== Core (Alt) Group ====
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
		&& is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion)
		&& on_EndingCreditsVideo_start(enum_releaseRegion)
	),
	"a_BountyCompletionAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllBountyMissionsCompleted = achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion)
		return
		// ==== Core (Alt) Logic Group ==== this is the only group which can unlock this achievement
			(
				is_ReleaseRegion(enum_releaseRegion)
				&& prev(let_sumOf_FlagsAllBountyMissionsCompleted) == BOUNTY_HUNTER_MISSON_COUNT - 1
				&& measured(let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT)
			)

		// ==== Alt RATrigger Popup Handler Group ==== this alt purely exists to combine the Measured flag in [Core (Alt) Logic Group] with a Trigger flag by using always_false() in this group
			|| (
				is_ReleaseRegion(enum_releaseRegion)
				&& once( // <-- once() to show RATrigger popup
					let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT - 1
					&& is_Playing_BountyHunterMode(enum_releaseRegion)
					&& is_RatingBounty_achieved(enum_releaseRegion)
					&& is_RewardMenu_displayed_long(enum_releaseRegion))
				&& trigger_when(always_false()) // <-- always_false()
			)

		// ==== Alt Reset Group ==== reset once() in [Alt RATrigger Popup Group] when replaying the bounty hunter mission (so the RATrigger popup hides again)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& (
					on_InGame_start(enum_releaseRegion)
					|| on_StartChpMenu_initialize(enum_releaseRegion)
					|| !is_Playing_BountyHunterMode(enum_releaseRegion))
			)
		}),
	"a_BountyHuntChapter1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"a_BountyHuntChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"a_BountyHuntChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"a_BountyHuntChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"a_BountyHuntChapter6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"a_BountyHuntChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"a_BountyHuntChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// NOTE: Custom version of achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_RogueValley, enum_releaseRegion) with measured on 3 treasures found
		
		// ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_BountyHunterMode(enum_releaseRegion)
				|| !is_Area(AREA_Campaign_RogueValley, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_RogueValley, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			&& measured(tally(3, [
				once(on_RogueValley_Treasure_find(ROGUEVALLEY_TREASURE_A, enum_releaseRegion)),
				once(on_RogueValley_Treasure_find(ROGUEVALLEY_TREASURE_B, enum_releaseRegion)),
				once(on_RogueValley_Treasure_find(ROGUEVALLEY_TREASURE_C, enum_releaseRegion))
				]))
			&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
			&& is_RatingBounty_achieved(enum_releaseRegion)
			&& trigger_when(repeated(530, // <-- Delay: so the achievement pops when the reward unlocks UI is displayed 
				never(is_StartChpMenu_active(enum_releaseRegion))
				&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		
		// ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ====		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_RogueValley, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_RogueValley, enum_releaseRegion))
		),
	"a_BountyHuntChapter9": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_GhostTown, enum_releaseRegion)),
	"a_BountyHuntChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"a_BountyHuntChapter12": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"a_BountyHuntChapter13": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"a_BountyHuntChapter14": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"a_BountyHuntChapter15": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"a_BountyHuntChapter17": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_TheMine, enum_releaseRegion)),
	"a_BountyHuntChapter18": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// NOTE: Custom version of achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_Stagecoach, enum_releaseRegion) with measured on 40 enemies killed
		
		// ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_BountyHunterMode(enum_releaseRegion)
				|| !is_Area(AREA_Campaign_Stagecoach, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_Stagecoach, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			&& measured(repeated(40, on_MissionKillcount_increment(enum_releaseRegion))) 
			&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
			&& is_RatingBounty_achieved(enum_releaseRegion)
			&& trigger_when(repeated(530, // <-- Delay: so the achievement pops when the reward unlocks UI is displayed 
				never(is_StartChpMenu_active(enum_releaseRegion))
				&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		
		// ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ====		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_Stagecoach, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_Stagecoach, enum_releaseRegion))
		),
	"a_BountyHuntChapter20": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"a_BountyHuntChapter21": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_EndOfTheLine, enum_releaseRegion)),
	"a_BountyHuntChapter24": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"a_BountyHuntChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_Siege, enum_releaseRegion)),
	"a_BountyHuntChapter27": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_FallFromGrace, enum_releaseRegion)
	),
	"a_BigMoney": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_CASH_TARGET = 50000

		return
			// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
				unless(
					!is_ReleaseRegion(enum_releaseRegion)
					|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
				
				&& unless(once( // <-- Pause Lock: Cheat Protection 
					is_AnyCheat_active(enum_releaseRegion)))

				&& once(is_AreaState_InGame(enum_releaseRegion))
				&& current_RewardMenu_Balance(enum_releaseRegion) >= const_CASH_TARGET
				&& trigger_when(
					achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
					&& repeated(197, // <-- Delay: so the achievement pops when the cash balance UI is displayed 
						never(is_StartChpMenu_active(enum_releaseRegion)) // <-- ResetNextIf necessary otherwise some StartChpMenu's may add hit counts
						&& is_RewardMenu_displayed_long(enum_releaseRegion)))

			// [2] ==== Alt Trigger Popup Handler Group ==== 	-> This alt handles the trigger popup during the mission; It can never unlock the achievement
				|| unless(
					!is_ReleaseRegion(enum_releaseRegion)
					|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

				&& once(is_AreaState_InGame(enum_releaseRegion))
				&& current_Calculated_CashDuringMission(enum_releaseRegion) >= const_CASH_TARGET // WARNING - RATools cannot generate this sumOf correctly, thus this check is manually edited in via RAIntegration
					// Full SumOf would look like this [PAL]:
					// -------------------------------
					// AddAddress	Mem 32-bit 0x562a20
					// AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
					// AddAddress	Mem 32-bit 0x562a20
					// 			 	Mem 32-bit 0x587c	>= Val const_CASH_TARGET
				&& trigger_when(always_false())
				
			// [3] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
				|| never_toAlt(
					is_ReleaseRegion(enum_releaseRegion)
					&& is_AtMainMenu(enum_releaseRegion))

			// [4] ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
				|| never_toAlt(
					is_ReleaseRegion(enum_releaseRegion) 
					&& once(on_WarningMenu_yes(enum_releaseRegion))
					&& on_CashResetToSavedCash(enum_releaseRegion))
		}),
	"a_PerfectShootingTutorial": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion) 
			&& is_InGame(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion) 
			&& is_Area(AREA_Campaign_BullsEye, enum_releaseRegion)
			// && !is_AnyCheat_active(enum_releaseRegion) // <-- usage of cheats for this achievement makes no difference

			&& unless( // <-- Pause Lock achievement when more than 13 bullets were used
				repeated(14, on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion)) 
				|| once(is_PlayerXCoordinate_notStationaryNearCoordinate(17.4, enum_releaseRegion))
				|| once(is_PlayerYCoordinate_notStationaryNearCoordinate(-10.5, enum_releaseRegion)))

			&& once(is_GameTrigger(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))
			&& trigger_when(on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_GoodCompletion, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== 	-> Reset when the shooting tutorial starts
			|| never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))),
	"a_SaveCurly": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CURLY_CASH_AWARD = 1500
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_CURLY_CASH_PICKUP_AREA_X = -37.0
		const_CURLY_CASH_PICKUP_AREA_Y = 40.0
		const_CURLY_CASH_PICKUP_AREA_Z = -9.5
		const_CURLY_CASH_PICKUP_AREA_THRESHOLD = 8.0

		return 
		// ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& unless(once( // <-- Pause Lock: when RetryMenu is rendered, to hide RATrigger popup
				on_InGameMenu_render(INGAMEMENU_RetryMenu, enum_releaseRegion)))
			
			&& unless(once( // <-- Pause Lock: when stumbled off the train
				current_PlayerZCoordinate(enum_releaseRegion) < 0
				&& is_AreaState_InGame(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			
			&& once(
				is_PlayerPosition_withinArea(
					const_CURLY_CASH_PICKUP_AREA_X, const_CURLY_CASH_PICKUP_AREA_Y, const_CURLY_CASH_PICKUP_AREA_Z,
					const_CURLY_CASH_PICKUP_AREA_THRESHOLD, enum_releaseRegion)
				&& on_CashAcquiredByOtherMeans_increasesBy(const_CURLY_CASH_AWARD, enum_releaseRegion))
			
			&& trigger_when(achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion))

		// ==== Alt Reset Group ====  Reset when not in correct Area
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ==== Reset when pressing 'yes' on retryMenu on mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion)) 
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== Reset when pressing 'yes' on warningMenu accessed through PauseMenu>levelRestart or PauseMenu>quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_CASH_TARGET = 1000
			
		return
		// ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_BullsEye, enum_releaseRegion))
			&& current_RewardMenu_BountyCollected(enum_releaseRegion) >= const_CASH_TARGET
			&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
			&& repeated(197, // <-- Delay: so the achievement pops when the cash balance UI is displayed 
				never(is_StartChpMenu_active(enum_releaseRegion))
				&& is_RewardMenu_displayed_long(enum_releaseRegion)) 

		// ==== Alt RATrigger Popup Handler Group ==== 	-> This alt handles the trigger popup during the mission; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_BullsEye, enum_releaseRegion))
			&& measured(current_Calculated_CashAcquiredDuringMission(enum_releaseRegion) >= const_CASH_TARGET) // WARNING - RATools cannot generate this sumOf correctly, thus this check is manually edited in via RAIntegration
				// Full SumOf would look like this [PAL]:
				// -------------------------------
				// AddAddress	Mem 32-bit 0x7448d8
				// SubSource 	Mem 32-bit 0x8
				// AddAddress	Mem 32-bit 0x562a20
				// AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
				// AddAddress	Mem 32-bit 0x562a20
				// 			 	Mem 32-bit 0x587c	>= Val const_CASH_TARGET
			&& trigger_when(always_false())	

		// ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_BullsEye, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_BullsEye, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_BullsEye, enum_releaseRegion))
		}),	
	"a_ChallengeChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_BountyHunter
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_BiteTheBullet, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_NoHud
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.5 // = 50%

		return
		// ==== Core (Alt) Logic Group ==== 				-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion))) 
			&& unless( // <-- Pause Lock: when DamageTaken > allowed
				tally_of(const_array_MAX_HP_VALUES, 1, float_maxHPvalue => // <---TallyOf--- Necessary as current_Calculated_DamageTakenPercentage() doesn't work in RAIntegration v1.3.0. ---> For each Max HP value: calculate percentage damage taken
					is_PlayerMaxHP(float_maxHPvalue, enum_releaseRegion)
					&& current_DamageTaken(enum_releaseRegion) >= float_maxHPvalue * const_MAX_DAMAGE_TAKEN_DECIMAL))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion) 
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))				
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [6] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& unless(once( // <-- Pause Lock: When a health item is used
				is_AreaState_InGame(enum_releaseRegion)
				&& on_PlayerHP_heal(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_UglyStreetFight, enum_releaseRegion))
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_UglyStreetFight, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_UglyStreetFight, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_UglyStreetFight, enum_releaseRegion))
		),	
	"a_ChallengeChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& unless(once( // <-- Pause Lock: when RetryMenu is rendered, to hide RATrigger popup
				on_InGameMenu_render(INGAMEMENU_RetryMenu, enum_releaseRegion)))
			
			&& unless(once( // <-- Pause Lock: when stumbled off the train
				current_PlayerZCoordinate(enum_releaseRegion) < 0
				&& is_AreaState_InGame(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_Railroaded, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects			
					never(is_StartChpMenu_active(enum_releaseRegion)) // <-- ResetNextIf necessary otherwise some StartChpMenu's may add hit counts
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))			

		// ==== Alt Reset Group ====  Reset when not in correct Area
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_Railroaded, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ==== Reset when pressing 'yes' on retryMenu on mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion)) 
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_Railroaded, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== Reset when pressing 'yes' on warningMenu accessed through PauseMenu>levelRestart or PauseMenu>quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(AREA_Campaign_Railroaded, enum_releaseRegion))
		),
	"a_ChallengeChapter6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { 
		// DEV_NOTE: Alt Group Evaluation Priority
		// --------------------------
		//	Core group => this must always be able to become true
		//	Alt groups => one of these must be able to become true
		//		- alt groups are evaluated from top to bottom. (so if using multiple Alt Reset Groups => the top ones will be evaluated first, then the ones below)
		
		const_GATLINGGUN_KILLSTREAK_COUNT = 10
		const_MISSION_AREA = AREA_Campaign_CarnivalLife
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& measured( // <-- Measured: Get killcount whilst holding down fireBtn
				repeated(const_GATLINGGUN_KILLSTREAK_COUNT, 
					never( // <-- ResetNextIf: Releasing fireBtn resets repeated count
						on_PlayerInput_FireGun_release(enum_releaseRegion))
					&& on_DeathToll_increment(enum_releaseRegion)),
				when = 
					once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
					&& once(
						never( // <-- ResetNextIf: Releasing fireBtn resets repeated count
							on_PlayerGatlingGun_dismount(const_MISSION_AREA, enum_releaseRegion))
						&& on_PlayerGatlingGun_mount(const_MISSION_AREA, enum_releaseRegion))
				)

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Creating a RAMeasured popup which displays accuracy during gameplay is impossible with RAIntegration v1.3.0, it would require logic below
			// ''''''''''''''''''''''''''''''''''
			// let_calculation_accuracy = 
			// 		byte(memUtil_memAddrTo_AlwaysNull(enum_releaseRegion)) // <-- To force RATools to generate float at start and end of the accumulator, this is to force the accumulator to work with floats (refer to https://docs.retroachievements.org/developer-docs/flags/addsource.html#interaction-with-floats)
			// 		+ current_ShotsHit(enum_releaseRegion) / current_ShotsFired(enum_releaseRegion)
			// 		+ byte(memUtil_memAddrTo_AlwaysNull(enum_releaseRegion)) * 100
			//
			// measured(let_calculation_accuracy == 100, format = "percent")

		const_MISSION_AREA = AREA_Campaign_FreakShow
		// const_DESIRED_ACCURACY = 0.65
		let_array_AllowedAccuracyStrings = [
			"65%", "66%", "67%", "68%", "69%",
			"70%", "71%", "72%", "73%", "74%", "75%", "76%", "77%", "78%", "79%",
			"80%", "81%", "82%", "83%", "84%", "85%", "86%", "87%", "88%", "89%",
			"90%", "91%", "92%", "93%", "94%", "95%", "96%", "97%", "98%", "99%", 
			"100%"]
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)

			&& tally_of(let_array_AllowedAccuracyStrings, 1, // <---TallyOf--- checks accuracy string at RewardMenu
				accuracyString => once(
					is_RewardMenu_displayed_short(enum_releaseRegion)
					&& is_RewardMenu_Accuracy(accuracyString, enum_releaseRegion)))
			// && current_Calculated_Accuracy(enum_releaseRegion) >= const_DESIRED_ACCURACY // <---line--- could replace above tally, but doesn't work with RAIntegration v1.3.0

			&& repeated(440, // <-- Delay achievement unlock to coincide with stats window being displayed 
				never(is_StartChpMenu_active(enum_releaseRegion))
				&& is_RewardMenu_displayed_long(enum_releaseRegion))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_BiteTheBullet

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter10": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_TheCemetery
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_BiteTheBullet, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_array_REQUIRED_CHEAT = [CHEAT_NoHud, CHEAT_NoDistortion, CHEAT_SadStars]

		return
		// ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_AllSpecifiedCheats_active(const_array_REQUIRED_CHEAT, enum_releaseRegion) 
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_AnySpecifiedCheats_inactive(const_array_REQUIRED_CHEAT, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_RangeWar
		const_KILLS_REQUIRED = 15

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& measured(repeated(const_KILLS_REQUIRED, 
				is_PlayerRidingAnimal(enum_releaseRegion)
				&& on_DeathToll_increment(enum_releaseRegion)))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter12": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_SaloonFight
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& current_PlayerHP(enum_releaseRegion) >= current_PlayerMaxHP(enum_releaseRegion)
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
		}),
	"a_ChallengeChapter13": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_TheTraitor
		const_ALLOWED_ALLIED_CANNONS_DESTROYED = 3 // of 8 total allied cannons

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& current_Calculated_AllyCannonsDestroyedCount(enum_releaseRegion) <= const_ALLOWED_ALLIED_CANNONS_DESTROYED
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter14": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_SunsetCanyon
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.9 // = 90%

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: when DamageTaken > allowed
				tally_of(const_array_MAX_HP_VALUES, 1, float_maxHPvalue => // <---TallyOf--- Necessary as current_Calculated_DamageTakenPercentage() doesn't work in RAIntegration v1.3.0. ---> For each Max HP value: calculate percentage damage taken
					is_PlayerMaxHP(float_maxHPvalue, enum_releaseRegion)
					&& current_DamageTaken(enum_releaseRegion) >= float_maxHPvalue * const_MAX_DAMAGE_TAKEN_DECIMAL))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
			// Below trigger_when() is alternative to above trigger_when()
				//'''''''''''''''''''''''''''''
				// && trigger_when(
				// 	achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				// 	&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
				// 		never(is_StartChpMenu_active(enum_releaseRegion))
				// 		&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter15": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Reseting through RetryMenu is managed with ResetNextIf on certain once hit counts
		const_MISSION_AREA = AREA_Campaign_BearMountain
		const_REQUIRED_WEAPON = WEAPON_Faith
		const_GRIZZLY_BOSS_INDEX = 0

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once(  // <-- Pause Lock: When damaging boss with wrong weapon				
				never( // <-- ResetNextIf this once: when retrying boss battle (after playerDeath)
					on_Puppetshow_start(PUPPETSHOW_BearMountain_PreBoss, enum_releaseRegion))
				&& !is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
				&& on_MajorCharacterHP_decrement(const_GRIZZLY_BOSS_INDEX, enum_releaseRegion)))

			&& is_Weapon_inInventory(const_REQUIRED_WEAPON, enum_releaseRegion)
			&& once(
					never( // <-- ResetNextIf this once: when retrying boss battle (after playerDeath)
						on_RetryMenu_yes(enum_releaseRegion))
				&& on_Puppetshow_start(PUPPETSHOW_BearMountain_PreBoss, enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit			
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on RewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RewardMenu_Replay_confirm(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))	
		}),
	"a_ChallengeChapter17": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Reseting through RetryMenu is managed with ResetNextIf on certain once hit counts
		const_MISSION_AREA = AREA_Campaign_TheMine
		const_REQUIRED_WEAPON = WEAPON_Knife
		const_TIME_LIMIT_SECONDS = 60.0
		const_BOSS_A_INDEX = 0
		const_BOSS_B_INDEX = 1

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(tally(1, [ // <-- Pause Lock: When damaging one of the bosses with wrong weapon
				once( 
					!is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_A_INDEX, enum_releaseRegion)),
				once( 
					!is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_B_INDEX, enum_releaseRegion))
				]))			
			&& unless(once( // <-- Pause Lock: When over time limit
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			// && is_Weapon_inInventory(const_REQUIRED_WEAPON, enum_releaseRegion) // <-- This check is very buggy as the pointerChain for this mission is weird
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
			
		// [2] ==== Alt RAmeasured Handler Group ==== 			-> This group handles RAmeasured popup to display time left in challenge; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(tally(1, [ // <-- Pause Lock: When damaging one of the bosses with wrong weapon
				once( 
					!is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_A_INDEX, enum_releaseRegion)),
				once( 
					!is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_B_INDEX, enum_releaseRegion))
				]))
			&& unless(once( // <-- Pause Lock: When over time limit
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))

			&& measured(
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS, 
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)))
			&& trigger_when(always_false())					

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter19": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_HellPass
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_BiteTheBullet, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_InfiniteDeadeye
		const_COACH_MAJOR_CHARACTER_INDEX = 3
		const_COACH_HP_THRESHOLD_PERCENTAGE = 0.40

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: When using firearm without the deadeye ability
				is_PlayerInput_AimGun_pressed(enum_releaseRegion)
				&& on_PlayerInput_FireGun_press(enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& is_MajorCharacter_CharacterName(const_COACH_MAJOR_CHARACTER_INDEX, CHARACTER_StageCoach, enum_releaseRegion)
			&& current_Calculated_MajorCharacterHPPercentage(const_COACH_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_COACH_HP_THRESHOLD_PERCENTAGE

			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter20": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_FortDiego
		const_ENEMY_HEADSHOT_KILL_COUNT = 12
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& measured(repeated(const_ENEMY_HEADSHOT_KILL_COUNT, 
				on_HeadShots_increment(enum_releaseRegion)
				&& on_DeathToll_increment(enum_releaseRegion)))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),	
	"a_ChallengeChapter22": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Reseting through RetryMenu is managed with ResetNextIf on certain once hit counts
		const_MISSION_AREA = AREA_Campaign_DevilsAndAngels
		const_TIME_LIMIT_SECONDS = 180.0
		const_DIEGO_BOSS_INDEX = 0
		const_array_ENEMY_ACTOR_DATA_INDICES = [1,2,3,4,5,6,7]

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: When over time limit
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))
			&& unless( // <-- Pause Lock: When an enemy other than General Diego was killed
				tally_of(const_array_ENEMY_ACTOR_DATA_INDICES, 1, int_actorDataindex => 
					is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_GeneralDiego, enum_releaseRegion) // <---2 lines--- check if any ActorHP went to 0 
					&& on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion)))		

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& once(is_AreaState_InGame(enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
			
		// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group handles RAmeasured popup to display time left in challenge; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: When over time limit
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))
			&& unless( // <-- Pause Lock: When an enemy other than General Diego was killed
				tally_of(const_array_ENEMY_ACTOR_DATA_INDICES, 1, int_actorDataindex => 
					is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_GeneralDiego, enum_releaseRegion) // <---2 lines--- check if any ActorHP went to 0 
					&& on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion)))
			
			&& measured(
				current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS, 
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)))
			&& trigger_when(always_false())					

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter24": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_BattleFinale
		const_array_PEDESTRIAN_ACTOR_DATA_INDICES = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17] // Index 0 = Red; Index 1 = MrKelley; Other indices are pedestrians
		const_MRKELLEY_BOSS_INDEX = 0 
		const_HEADSHOTS_MRKELLEY_REQUIRED = 5

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once a bystander/pedestrian is killed
				tally_of(const_array_PEDESTRIAN_ACTOR_DATA_INDICES, 1, int_actorDataindex =>
					is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion)
					&& is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_MrKelley, enum_releaseRegion)
					&& on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion)))
			
			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				repeated(const_HEADSHOTS_MRKELLEY_REQUIRED, // <---repeated--- checks headshots on MrKelley 
					on_MajorCharacterHP_decrement(const_MRKELLEY_BOSS_INDEX, enum_releaseRegion)
					&& on_HeadShots_increment(enum_releaseRegion))
				&& once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
		
		// [2] ==== Alt RAmeasured Handler Group ==== 			-> This group handles RAmeasured popup to display headshot count on Mr Kelley; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once a bystander/pedestrian is killed
				tally_of(const_array_PEDESTRIAN_ACTOR_DATA_INDICES, 1, int_actorDataindex =>
					is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion)
					&& is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_MrKelley, enum_releaseRegion)
					&& on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion)))
			
			&& measured(
				repeated(const_HEADSHOTS_MRKELLEY_REQUIRED, 
					on_MajorCharacterHP_decrement(const_MRKELLEY_BOSS_INDEX, enum_releaseRegion)
					&& on_HeadShots_increment(enum_releaseRegion)), 
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)))
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_Siege
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_BiteTheBullet, CHEAT_NoHud, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_GoldenGun
		const_JACK_MAJOR_CHARACTER_INDEX = 3
		const_ANNIE_MAJOR_CHARACTER_INDEX = 4
		const_ALLIED_HP_THRESHOLD_PERCENTAGE = 0.75

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			
			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& is_MajorCharacter_CharacterName(const_JACK_MAJOR_CHARACTER_INDEX, CHARACTER_JackSwift, enum_releaseRegion) 
			&& current_Calculated_MajorCharacterHPPercentage(const_JACK_MAJOR_CHARACTER_INDEX, enum_releaseRegion) 
				>= const_ALLIED_HP_THRESHOLD_PERCENTAGE

			&& is_MajorCharacter_CharacterName(const_ANNIE_MAJOR_CHARACTER_INDEX, CHARACTER_AnnieStoakes, enum_releaseRegion) 
			&& current_Calculated_MajorCharacterHPPercentage(const_ANNIE_MAJOR_CHARACTER_INDEX, enum_releaseRegion) 
				>= const_ALLIED_HP_THRESHOLD_PERCENTAGE

			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter27": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion)  {
		const_MISSION_AREA = AREA_Campaign_FallFromGrace
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.5 // = 50%
		// const_DESIRED_ACCURACY = 0.70
		let_array_AllowedAccuracyStrings = [
			"70%", "71%", "72%", "73%", "74%", "75%", "76%", "77%", "78%", "79%",
			"80%", "81%", "82%", "83%", "84%", "85%", "86%", "87%", "88%", "89%",
			"90%", "91%", "92%", "93%", "94%", "95%", "96%", "97%", "98%", "99%", 
			"100%"]
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: when DamageTaken > allowed
				tally_of(const_array_MAX_HP_VALUES, 1, float_maxHPvalue => // <---TallyOf--- Necessary as current_Calculated_DamageTakenPercentage() doesn't work in RAIntegration v1.3.0. ---> For each Max HP value: calculate percentage damage taken
					is_PlayerMaxHP(float_maxHPvalue, enum_releaseRegion)
					&& current_DamageTaken(enum_releaseRegion) >= float_maxHPvalue * const_MAX_DAMAGE_TAKEN_DECIMAL))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)

				&& tally_of(let_array_AllowedAccuracyStrings, 1, // <---TallyOf--- checks accuracy string at RewardMenu
					accuracyString => once(
						is_RewardMenu_displayed_short(enum_releaseRegion)
						&& is_RewardMenu_Accuracy(accuracyString, enum_releaseRegion)))
				// && current_Calculated_Accuracy(enum_releaseRegion) >= const_DESIRED_ACCURACY // <---line--- could replace above tally, but doesn't work with RAIntegration v1.3.0

				&& repeated(440, // <-- Delay achievement unlock to coincide with stats window being displayed 
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_WoodChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion)  {
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_BiteTheBullet

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_WoodChapter10": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion)  {
		const_MISSION_AREA = AREA_Campaign_HellPass
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_BiteTheBullet, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_InfiniteDeadeye
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: When using a firearm without the deadeye ability
				is_PlayerInput_AimGun_pressed(enum_releaseRegion)
				&& on_PlayerInput_FireGun_press(enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
	}),
	"a_BountyHunterKatie": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_array_REQUIRED_CPU_CHARACTERS = [CHARACTER_ProfessorPerry, CHARACTER_UglyChris, CHARACTER_GeneralDiego]
		const_SHOWDOWN_STAGE = AREA_Showdown_WidowsPatch
		const_HUMANPLAYER_INDEX = 1 // Always 1 human player at index 1s
		const_CPUPLAYER_1_INDEX = 2
		const_CPUPLAYER_2_INDEX = 3
		const_CPUPLAYER_3_INDEX = 4

		return
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayerCharacter(const_HUMANPLAYER_INDEX, CHARACTER_KatieGrady, enum_releaseRegion)
			&& is_ShowdownPlayer_HumanPlayer(const_HUMANPLAYER_INDEX, enum_releaseRegion)
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_1_INDEX, enum_releaseRegion) // <---3 Lines--- Check if other players are bots/CPUsp
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_2_INDEX, enum_releaseRegion)
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_3_INDEX, enum_releaseRegion)

			&& tally_of(const_array_REQUIRED_CPU_CHARACTERS, length(const_array_REQUIRED_CPU_CHARACTERS), enum_character => // <---TallyOf--- Count 1 for each required CPU character; should be 3 if each character is in one of the player slots
				once(
					is_ShowdownPlayerCharacter(const_CPUPLAYER_1_INDEX, enum_character, enum_releaseRegion)
					|| is_ShowdownPlayerCharacter(const_CPUPLAYER_2_INDEX, enum_character, enum_releaseRegion)
					|| is_ShowdownPlayerCharacter(const_CPUPLAYER_3_INDEX, enum_character, enum_releaseRegion)))

			&& achievements_generate_TallyOf_ShowdownTeamsFreeForAll(enum_releaseRegion)
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_5K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				once(
					never(!is_MultiplayerRewardMenu_displayed(enum_releaseRegion))
					&& on_MultiplayerRewardMenu_render_short(enum_releaseRegion))
				&& is_ShowdownPlayer_Winner(1, enum_releaseRegion))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when not playing Showdown Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_ShowdownMode_long(enum_releaseRegion))
		
		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion))
		}),
	"a_BountyHunterBlade": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_array_REQUIRED_CPU_CHARACTERS = [CHARACTER_ProfessorPerry, CHARACTER_UglyChris, CHARACTER_GeneralDiego]
		const_SHOWDOWN_STAGE = AREA_Showdown_WidowsPatch
		const_HUMANPLAYER_INDEX = 1 // Always 1 human player at index 1s
		const_CPUPLAYER_1_INDEX = 2
		const_CPUPLAYER_2_INDEX = 3
		const_CPUPLAYER_3_INDEX = 4

		return
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))

			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayerCharacter(const_HUMANPLAYER_INDEX, CHARACTER_KatieGrady, enum_releaseRegion)
			&& is_ShowdownPlayer_HumanPlayer(const_HUMANPLAYER_INDEX, enum_releaseRegion)
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_1_INDEX, enum_releaseRegion) // <---3 Lines--- Check if other players are bots/CPUsp
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_2_INDEX, enum_releaseRegion)
			&& is_ShowdownPlayer_CPUPlayer(const_CPUPLAYER_3_INDEX, enum_releaseRegion)

			&& tally_of(const_array_REQUIRED_CPU_CHARACTERS, length(const_array_REQUIRED_CPU_CHARACTERS), enum_character => // <---TallyOf--- Count 1 for each required CPU character; should be 3 if each character is in one of the player slots
				once(
					is_ShowdownPlayerCharacter(const_CPUPLAYER_1_INDEX, enum_character, enum_releaseRegion)
					|| is_ShowdownPlayerCharacter(const_CPUPLAYER_2_INDEX, enum_character, enum_releaseRegion)
					|| is_ShowdownPlayerCharacter(const_CPUPLAYER_3_INDEX, enum_character, enum_releaseRegion)))

			&& achievements_generate_TallyOf_ShowdownTeamsFreeForAll(enum_releaseRegion)
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_5K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				once(
					never(!is_MultiplayerRewardMenu_displayed(enum_releaseRegion))
					&& on_MultiplayerRewardMenu_render_short(enum_releaseRegion))
				&& is_ShowdownPlayer_Winner(1, enum_releaseRegion))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when not playing Showdown Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_ShowdownMode_long(enum_releaseRegion))
		
		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion))
	}),
	"a_UnlockStagesAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllStages = achievements_generate_SumOf_FlagsAllStages(enum_releaseRegion)
		return 			
		// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllStages) < STAGE_COUNT
			&& prev(let_sumOf_FlagsAllStages) > STAGE_COUNT/2
			&& measured(let_sumOf_FlagsAllStages == STAGE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_UnlockCharactersHalf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllCharacters = achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			&& is_RStar_Cheat_inActive(enum_releaseRegion)

			&& prev(let_sumOf_FlagsAllCharacters) < CHARACTER_COUNT/2
			&& prev(let_sumOf_FlagsAllCharacters) > (CHARACTER_COUNT/4)
			&& let_sumOf_FlagsAllCharacters == CHARACTER_COUNT/2
		}),
	"a_UnlockCharactersAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllCharacters = achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllCharacters) < CHARACTER_COUNT
			&& prev(let_sumOf_FlagsAllCharacters) > CHARACTER_COUNT*3/4
			&& measured(let_sumOf_FlagsAllCharacters == CHARACTER_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_CompleteJournalHalf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: No Measured Flag required for this as a_CompleteFullJournal already has one
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
		// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			&& is_RStar_Cheat_inActive(enum_releaseRegion)

			&& prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT
			&& prev(let_sumOf_FlagsAllPages) > JOURNALPAGE_COUNT/4
			&& let_sumOf_FlagsAllPages >= JOURNALPAGE_COUNT/2 
		}),
	"a_CompleteJournalAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
		// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT
			&& prev(let_sumOf_FlagsAllPages) > JOURNALPAGE_COUNT*3/4
			&& measured(let_sumOf_FlagsAllPages == JOURNALPAGE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion),
				format = "percent")
		}),
	"a_MaxHealth": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks allowed as there are no HP upgrades unlockable during the StartChpMenu
		let_sumOf_FlagsAllHealthUpgrades = achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion)
		return 
		// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllHealthUpgrades) == HP_UPGRADE_COUNT - 1 
			&& measured(let_sumOf_FlagsAllHealthUpgrades == HP_UPGRADE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_StartChpMenu_active(enum_releaseRegion) // <-- Health upgrades are not unlockable during this menu, this line in necessary as the struct storing DynamicBitset_PlayerProfileUnlocks may be remade during StartChpMenu  
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_MaxDeadEye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks allowed as there are no HP upgrades unlockable during the StartChpMenu
		let_sumOf_FlagsAllDeadEyeUpgrades = achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion)
		return 
		// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllDeadEyeUpgrades) == DEADEYE_UPGRADE_COUNT - 1
			&& measured(let_sumOf_FlagsAllDeadEyeUpgrades == DEADEYE_UPGRADE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_StartChpMenu_active(enum_releaseRegion) // <-- DeadEye upgrades are not unlockable during this menu, this line in necessary as the struct storing DynamicBitset_PlayerProfileUnlocks may be remade during StartChpMenu  
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),	
	"a_UnlockAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUniqueWeapons(enum_releaseRegion)
		return 
		// ==== Core (Alt) Group ==== 
			// BUG RATools - infinite processing error --> Manual creation via RAIntegration
			// prev(let_sumOf_AllWeaponFlags) < WEAPON_COUNT // <---2Lines--- Break RATools
			// && prev(let_sumOf_AllWeaponFlags) > WEAPON_COUNT*5/8
			measured(let_sumOf_AllWeaponFlags == WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_UpgradeAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion)
		return 
		// ==== Core (Alt) Logic Group ====
			prev(let_sumOf_AllWeaponFlags) < UPGRADEABLE_WEAPON_COUNT
			&& prev(let_sumOf_AllWeaponFlags) > UPGRADEABLE_WEAPON_COUNT/2
			&& measured(let_sumOf_AllWeaponFlags == UPGRADEABLE_WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	}

// =====================
// • Achievements TEXT •
// =====================
achievements_titles = {
	// Title Idea's
	// Cavalry Draw - Jack Swift related achievement
	// Hammer of the God - weapon of the traitor General Diego
	// Quite a show - Chapter 12	
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

	// "a_Template": 						{"en": "xxxxxxxxx"},
	"a_CompleteChapter1": 					{"en": "The Scorpion's Scar"},
	"a_CompleteChapter2":					{"en": "Prime Cut"},
	"a_CompleteChapter3":					{"en": "The Uglier They Come, the Harder They Fall"},
	"a_CompleteChapter5":					{"en": "Tickets Please!"},
	"a_CompleteChapter6":					{"en": "Explosive Pig Out"},
	"a_CompleteChapter7":					{"en": "Perry's Peculiar Predicament"}, 
	"a_CompleteChapter8":					{"en": "Bovine Beatdown"},
	"a_CompleteChapter10":					{"en": "One Hell of a Bounty Hunter"},
	"a_CompleteChapter11":					{"en": "Faithful Buckaroo"},
	"a_CompleteChapter12":					{"en": "The Final Curtain"},
	"a_CompleteChapter13":					{"en": "Pact of Perdition"},
	"a_CompleteChapter14":					{"en": "Bullion's Folly"},
	"a_CompleteChapter15":					{"en": "Grizzly Passage"},
	"a_CompleteChapter17": 					{"en": "Ore-some Parole"},
	"a_CompleteChapter19": 					{"en": "Coach Under Sundown"},
	"a_CompleteChapter20": 					{"en": "The Courage of Red Wolves"},
	"a_CompleteChapter22":					{"en": "Pact of Payback"}, 
	"a_CompleteChapter24":					{"en": "Dust Settler"},
	"a_CompleteChapter25":					{"en": "Straight Into the Griffon's Den"},
	"a_CompleteChapter27":					{"en": "Redemption"},

	"a_BountyHuntChapter1": 				{"en": "Skull's Eye"},
	"a_BountyHuntChapter2": 				{"en": "Flawless Cut"},
	"a_BountyHuntChapter3": 				{"en": "Slick Streetfight"},
	"a_BountyHuntChapter5": 				{"en": "Railrushed"},
	"a_BountyHuntChapter6": 				{"en": "Roaring Carnival"},
	"a_BountyHuntChapter7": 				{"en": "Brawny Show"},
	"a_BountyHuntChapter8": 				{"en": "Treasure Valley"},
	"a_BountyHuntChapter9": 				{"en": "Wraith of the West"},
	"a_BountyHuntChapter11": 				{"en": "Faithful Bronco-buster"},
	"a_BountyHuntChapter12": 				{"en": "Three Gals, Zero Wails"},
	"a_BountyHuntChapter13": 				{"en": "Charge Me Not"}, 
	"a_BountyHuntChapter14": 				{"en": "Grand Theft Horse"},
	"a_BountyHuntChapter15": 				{"en": "Wolf Mountain"},
	"a_BountyHuntChapter17": 				{"en": "Bound Momentum"},
	"a_BountyHuntChapter18": 				{"en": "Buffalo Soldier and the 40 Troopers"},
	"a_BountyHuntChapter20": 				{"en": "Plenty Forte"},
	"a_BountyHuntChapter21": 				{"en": "Cessation of the Golden Horse"},
	"a_BountyHuntChapter24": 				{"en": "Mr. Quickdraw"},
	"a_BountyHuntChapter25": 				{"en": "Showstopper"},
	"a_BountyHuntChapter27": 				{"en": "Diligent Fall"},
	"a_BountyCompletionAll": 				{"en": "Out for Blood"},

	"a_BigMoney":							{"en": "It Was Always About the Money"},
	"a_SaveCurly":							{"en": "A Curly Deal for Carbine Zeal"},
	"a_PerfectShootingTutorial": 			{"en": "Rookie Sharpshooter"},
	"a_ChallengeChapter1": 					{"en": "Budding Prize"}, // WARNING - Manual creation via RAIntegration
	"a_ChallengeChapter2":					{"en": "Keenly Grubbed"},
	"a_ChallengeChapter3":					{"en": "Laudanum Skeptic"},
	"a_ChallengeChapter5":					{"en": "Railway Maverick"},
	"a_ChallengeChapter6":					{"en": "Gale of Gunpowder"},
	"a_ChallengeChapter7":					{"en": "Swift and Sure"},
	"a_ChallengeChapter8":					{"en": "Bovine Bitedown"},
	"a_ChallengeChapter10":					{"en": "Tall-Tale"},
	"a_ChallengeChapter11":					{"en": "Savage Saddle"},
	"a_ChallengeChapter12":					{"en": "Quite the Show"},
	"a_ChallengeChapter13":					{"en": "Hammer of the Gods"},
	"a_ChallengeChapter14":					{"en": "Carnage at Sunset"},
	"a_ChallengeChapter15":					{"en": "Roaring Bane"},
	"a_ChallengeChapter17": 				{"en": "Melee Minehem"},
	"a_ChallengeChapter19": 				{"en": "Bacon 'n Beans"},
	"a_ChallengeChapter20": 				{"en": "You Done Kill 'em All!"},
	"a_ChallengeChapter22":					{"en": "Ándale, Ándale!"},
	"a_ChallengeChapter24":					{"en": "High-Fashioned Cleanup"},
	"a_ChallengeChapter25":					{"en": "Vigilante"},
	"a_ChallengeChapter27":					{"en": "Bullet with a Name"},
	"a_WoodChapter8":						{"en": "Wood You Believe It?"},
	"a_WoodChapter10":						{"en": "Cremation at Sundawn"},

	"a_BountyHunterKatie":					{"en": "Remember Me?"},
	"a_BountyHunterBlade": 					{"en": "Sharp Shooter"},
	"a_BountyHunterAnnie": 					{"en": "Taking the Ranch Back"},
	"a_BountyHunterCooper": 				{"en": "Rolling Over the Law"},
	"a_BountyHunterWeapons": 				{"en": "Killer Collection"},
	"a_SundownFallenStar": 					{"en": "Tribal Warfare"},
	"a_SundownBlack": 						{"en": "Sound Undertaking"},
	"a_SundownGriffon": 					{"en": "I've Come To Finish the Job"},
	"a_SundownNate": 						{"en": "Harlow's Reckoning"},
	"a_SundownFlawless": 					{"en": "Untouchable at Twilight"},
	"a_HighNoonNatalie": 					{"en": "Familiar Standoff"},
	"a_HighNoonCurly": 						{"en": "Supplies Depleted, Trigger Repeated"},	

	"a_UnlockStagesAll": 					{"en": "Frontier Sojourn"},
	"a_UnlockCharactersHalf":				{"en": "Gunslingers' Ensemble"},
	"a_UnlockCharactersAll":				{"en": "Gunslingers' Enchilada"},
	"a_CompleteJournalHalf":				{"en": "Historical Account"},
	"a_CompleteJournalAll":					{"en": "Chronicles of the Frontier"},
	"a_MaxHealth":							{"en": "Peak Condition"},
	"a_MaxDeadEye":							{"en": "Red Eye"},
	"a_UnlockAllWeapons":					{"en": "It Never Was About the Money"}, // WARNING - Manual creation via RAIntegration
	"a_UpgradeAllWeapons":					{"en": "Finest in the West"},
	}

// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_CompleteChapter1": 					{"en": "Valiantly hold the fort at Harlow's Home in Chapter 1, 'Bull's Eye'"},
	"a_CompleteChapter2":					{"en": "Tenderize Bloody Tom's beefy ambitions during the events of Chapter 2, 'Bounty Hunter'"},
	"a_CompleteChapter3":					{"en": "Neatly Nix the Ugly Gang by the end of Chapter 3, 'Ugly Streetfight'"},
	"a_CompleteChapter5":					{"en": "Derail the Pedrosa Brothers' train heist during Chapter 5, 'RailRoaded'"},
	"a_CompleteChapter6":					{"en": "Wrangle the dynamite-fiend during the events of Chapter 6, 'Carnival Life'"},
	"a_CompleteChapter7":					{"en": "Topple Perry's eccentric circus troupe in Chapter 7, 'Freak Show'"},
	"a_CompleteChapter8":					{"en": "Rein in Bad Bessie's gang of outlaws during Chapter 8, 'Rogue Valley'"},
	"a_CompleteChapter10":					{"en": "Close out all of Sheriff Bartlett's bounties by the end of Chapter 10, 'The Cemetery'"},
	"a_CompleteChapter11":					{"en": "Accomplish the defense of Annie's cattle from the raiders in Chapter 11, 'Range War'"},
	"a_CompleteChapter12":					{"en": "Survive a storm of fists, bottles and bullets during Chapter 12, 'Bar Fight'"},
	"a_CompleteChapter13":					{"en": "Unearth the deceitful secrets behind Red's parents' fate by the end of Chapter 13, 'The Traitor'"},
	"a_CompleteChapter14":					{"en": "Disrupt an illicit gold operation during the events of Chapter 14, 'Sunset Canyon'"},
	"a_CompleteChapter15":					{"en": "Successfully navigate the twisting creek in Chapter 15, 'Bear Mountain'"},
	"a_CompleteChapter17": 					{"en": "Escape the labyrinth of the mines within Chapter 17, 'The Mine'"},
	"a_CompleteChapter19": 					{"en": "Make it to Brimstone by stagecoach during Chapter 19, 'Hell's Pass'"},
	"a_CompleteChapter20": 					{"en": "Bring down the senior officer donning the shoulder-mounted armcannon in Chapter 20, 'Fort Diego'"},
	"a_CompleteChapter22":					{"en": "Deal the final blow to the Renegade Army during Chapter 22, 'Devils and Angels'"},
	"a_CompleteChapter24":					{"en": "Emerge triumphant after vanquishing all Battle Royale adversaries in Chapter 24, 'Battle Finale'"},
	"a_CompleteChapter25":					{"en": "Breach the opulent manor within Chapter 25, 'Siege'"},
	"a_CompleteChapter27":					{"en": "Conclude Red's story by completing Chapter 27, 'Fall From Grace'"},

	"a_BountyHuntChapter1": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 1, 'Bull's Eye"},
	"a_BountyHuntChapter2": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 2, 'Bounty Hunter'"},
	"a_BountyHuntChapter3": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 3, 'Ugly Streetfight'"},
	"a_BountyHuntChapter5": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 5, 'Railroaded'"},
	"a_BountyHuntChapter6": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 6, 'Carnival Life'"},
	"a_BountyHuntChapter7": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 7, 'Freak Show'"},
	"a_BountyHuntChapter8": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 8, 'Rogue Valley'"},
	"a_BountyHuntChapter9": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 9, 'Ghost Town'"},
	"a_BountyHuntChapter11": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 11, 'Range War'"},
	"a_BountyHuntChapter12": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 12, 'Bar Fight'"},
	"a_BountyHuntChapter13": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 13, 'The Traitor'"},
	"a_BountyHuntChapter14": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 14, 'Sunset Canyon'"},
	"a_BountyHuntChapter15": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 15, 'Bear Mountain'"},
	"a_BountyHuntChapter17": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 17, 'The Mine'"},
	"a_BountyHuntChapter18": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 18, 'Stagecoach'"},
	"a_BountyHuntChapter20": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 20, 'Fort Diego'"},
	"a_BountyHuntChapter21": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 21, 'End of the Line'"},
	"a_BountyHuntChapter24": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 24, 'Battle Finale'"},
	"a_BountyHuntChapter25": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 25, 'Siege'"},
	"a_BountyHuntChapter27": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 27, 'Fall From Grace'"},
	"a_BountyCompletionAll":				{"en": "Complete all Bounty Hunter Mode missions on one player profile"},

	"a_BigMoney":							{"en": "Amass a bank balance of $50 000 during the story campaign"},
	"a_SaveCurly":							{"en": "Earn Curly Shaw's $1500 reward for saving him during Chapter 8, 'Rogue Valley'"},
	"a_PerfectShootingTutorial": 			{"en": "Prove your shooting prowess in Chapter 1, 'Bull's Eye', by finishing the shooting tutorial without wasting a single bullet and remaining stationary"},
	"a_ChallengeChapter1": 					{"en": "Complete Chapter 1, 'Bull's Eye', on very hard difficulty with a collected bounty of $1000 or more"}, // WARNING - Manual creation via RAIntegration
	"a_ChallengeChapter2":					{"en": "Complete Chapter 2, 'Bounty Hunter', on hard or very hard difficulty, sustaining less than 50% damage and with the 'No HUD' cheat enabled"},
	"a_ChallengeChapter3":					{"en": "Complete Chapter 3, 'Ugly Streetfight', on very hard difficulty without picking up any healing items"},
	"a_ChallengeChapter5":					{"en": "Complete Chapter 5, 'Railroaded', on hard or very hard difficulty without stumbling off the train even once"},
	"a_ChallengeChapter6":					{"en": "In Chapter 6, 'Carnival Life', on hard or very hard difficulty achieve a 10-kill streak with the gatling gun in a single, uninterrupted burst without releasing the trigger"},
	"a_ChallengeChapter7":					{"en": "Complete Chapter 7, 'Freak Show', on very hard difficulty with an accuracy of 65% or better"},
	"a_ChallengeChapter8":					{"en": "Complete Chapter 8, 'Rogue Valley', on very hard difficulty with 'Bite the Bullet' cheat enabled"},
	"a_ChallengeChapter10":					{"en": "Complete Chapter 10, 'The Cemetery', on hard or very hard difficulty with following the cheats enabled: 'No Distortion', 'Sad Stars' and 'No HUD'"},
	"a_ChallengeChapter11":					{"en": "Complete Chapter 11, 'Range War', on hard or very hard difficulty, dispatching 15 enemies while riding a bison"},
	"a_ChallengeChapter12":					{"en": "Complete Chapter 12, 'Bar Fight', on very hard difficulty with a full health bar at the end"},
	"a_ChallengeChapter13":					{"en": "Complete Chapter 13, 'The Traitor', on hard or very hard difficulty with at least 5 allied cannons remaining"},
	"a_ChallengeChapter14":					{"en": "Complete Chapter 14, 'Sunset Canyon', on very hard difficulty with less than 90% damage taken"},
	"a_ChallengeChapter15":					{"en": "Complete Chapter 15, 'Bear Mountain', on very hard difficulty using only the firearm 'Faith' to damage Grizzly"},
	"a_ChallengeChapter17": 				{"en": "Complete Chapter 17, 'The Mine', on hard or very hard difficulty in under 1 minute, using only a knife to damage Ted and Tony"},
	"a_ChallengeChapter19": 				{"en": "Complete Chapter 19, 'Hell's Pass', on hard or very hard difficulty with the stagecoach's HP above 40%, using the 'Infinite DeadEye' cheat as the only means of shooting"},
	"a_ChallengeChapter20": 				{"en": "Complete Chapter 20, 'Fort Diego', on very hard difficulty with 12 headshot kills"},
	"a_ChallengeChapter22":					{"en": "Complete Chapter 22, 'Devils and Angels', on hard or very hard difficulty in under 3 minutes, killing only General Diego"},
	"a_ChallengeChapter24":					{"en": "Complete Chapter 24, 'Battle Finale', on very hard difficulty with 5 headshots on Mr. Kelley and no bystander deaths"},
	"a_ChallengeChapter25":					{"en": "Complete Chapter 25, 'Siege', on hard or very hard difficulty with Jack's and Annie's HP above 75%, using the 'Golden Gun' cheat"},
	"a_ChallengeChapter27":					{"en": "Complete Chapter 27, 'Fall From Grace', on very hard difficulty, sustaining less than 50% damage and achieving an accuracy of 70% or higher"},
	"a_WoodChapter8":						{"en": "Complete Chapter 8, 'Rogue Valley', on Red Wood Revolver difficulty with 'Bite the Bullet' cheat enabled"},
	"a_WoodChapter10":						{"en": "Complete Chapter 10, 'The Cemetery', on Red Wood Revolver difficulty using the 'Infinite Deadeye' cheat as the only means of doing damage"},

	"a_BountyHunterKatie":					{"en": "As Katie O'Grady, with Sherrif O'Grady as your ally win a 10k target Bounty Hunter match against a team of Ugly Chris and Gigolo Hancock in Widow's Patch"},
	"a_BountyHunterBlade": 					{"en": "As The Blade Slade, win a free-for-all 10k target Bouny Hunter match against Sissy Fess, Rico Pedrosa and Udo Kang in Sunset Canyon, using only knives"},
	"a_BountyHunterAnnie": 					{"en": "As Annie Stoakes, win a 10k target Bounty Hunter match against a team of Governor Griffon, Holstein Hal, and Sam on The Ranch"},
	"a_BountyHunterCooper": 				{"en": "As Cooper, win a 10k target Bounty Hunter match against a team of Jason Cornet, Sheriff Bartlett and Sheriff O'Grady on Fairground"},
	"a_BountyHunterWeapons": 				{"en": "Win a 4 player free-for-all Bounty Hunter match by killing opponents with 7 different weapons"},
	"a_SundownFallenStar": 					{"en": "As Falling Star, with Shadow Wolf as your ally, win a 5 minute Sundown match against a team of Grizzly and Standing Snake in Fallen Creek"},
	"a_SundownBlack": 						{"en": "As Mr. Black, win a 5 minute free-for-all Sundown match against Bad Bessie, Ugly Chris and Pig Josh in Ghost Town"},
	"a_SundownGriffon": 					{"en": "As Governor Griffon, win a 5 minute Sundown match against a team of Nate Harlow, Falling Star, and Red in Broken Creek"},
	"a_SundownNate": 						{"en": "As Nate Harlow, win a 5 minute Sundown match against a team of Governor Griffon, Colonel Daren, and General Diego in The Mansion"},
	"a_SundownFlawless": 					{"en": "Win a 4 player free-for-all sundown match without dying once"},
	"a_HighNoonNatalie": 					{"en": "As Natalie, with Mr. Kelley as your ally, win a best of 5 High Noon match against a team of Red Jr. and Nate Harlow on Mansion Grounds"},
	"a_HighNoonCurly": 						{"en": "As Curly Shaw, win a best of 5, free-for-all High Noon match against Bloody Tom, Big Oaf Whitney, and Twiggy Phelps in Twin Rocks"},

	"a_UnlockStagesAll": 					{"en": "Unlock all Showdown stages"},
	"a_UnlockCharactersHalf":				{"en": "Unlock half the Showdown characters"},
	"a_UnlockCharactersAll":				{"en": "Unlock all Showdown characters"},
	"a_CompleteJournalHalf":				{"en": "Unlock half of Sheriff Bartlett's journal"},
	"a_CompleteJournalAll":					{"en": "Complete Sheriff Bartlett's journal"},
	"a_MaxHealth":							{"en": "Max out Red's health in the story campaign"},
	"a_MaxDeadEye":							{"en": "Max out Red's Dead Eye in the story campaign"},
	"a_UnlockAllWeapons":					{"en": "Acquire the full weapon arsenal during Red's story"}, // WARNING - Manual creation via RAIntegration
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