// ***************************************************************** \\
// █▀█ █▀▀ █▀▄    █▀▄ █▀▀ ▄▀█ █▀▄    █▀█ █▀▀ █░█ █▀█ █░░ █░█ █▀▀ █▀█ \\
// █▀▄ ██▄ █▄▀    █▄▀ ██▄ █▀█ █▄▀    █▀▄ ██▄ ▀▄▀ █▄█ █▄▄ ▀▄▀ ██▄ █▀▄ \\
// ***************************************************************** \\
// #ID = 11094
// md5: c06c59490d239fb56ace0388ac2b2842 - PAL/EUR
// Platform: PlayStation 2
// Achievement Guide: https://github.com/RetroAchievements/guides/wiki/Red-Dead-Revolver-(PlayStation-2)
// RA Game Page: https://retroachievements.org/game/11094
// #MinimumVersion: 1.15.0 		- Some achievements were coded in RATools 1.14.1

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

/* TODO list (before launch)
	- Reset leaderboard entries
	- (Optional) support for 60 fps patch + NTSCJ ????

	- Hubs to Add
		[Feature - PvP]  							- https://retroachievements.org/game/9377
		[Feature - New Game+] 						- https://retroachievements.org/game/2722		<--- is it truely NG+ ??
		[Feature - Multiple Perspective Story] 		- https://retroachievements.org/game/24261
		[Game Mechanic - Splitscreen Multiplayer] 	- https://retroachievements.org/game/1195		<--- prefer this one, compared to below
		[Game Mechanic - Multiplayer] 				- https://retroachievements.org/game/14727
		[Perspective - 3rd-Person] 					- https://retroachievements.org/game/4725

	*/

util_isDebugModeActive = false	// if true => extra information may be displayed on achievement titles & descriptions
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

function util_throwError_RegionNotSupported(enum_releaseRegion) =>
	util_throwError(format("This functionality is not supported for release region: {0}", enum_releaseRegion))

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
memory_StructDefs = {
	"Struct:PS2Vector": {
		"offsetToMember": {
			"Float:W-Component": 0x0,
			"Float:Y_Coordinate": 0x4,
			"Float:Z_Coordinate": 0x8,
			"Float:X_Coordinate": 0xC	}
		},
	"Struct:ActorData_0": {
		"sizeInBytes": 8,
		"offsetToMember": {
			"Struct_ActorData_A": 0x0,
			"Struct:ActorData_B": 0x4} 
		},
	"Struct:ActorData_B": {
		"pointerChainToMember": {
			"Float:ActorHP": { 
				"pointerChainOffsets": [0x4, 0x18, 0x10]},
			"Float:ActorMaxHP": { 
				"pointerChainOffsets": [0x4, 0x18, 0x14]},
			"Bitfield:UniversalWeaponState": { 
				"pointerChainOffsets": [0x80, 0xA8]},
			"Struct(PS2Vector):ActorLocation": { 
				"pointerChainOffsets": [0xC, 0x90]},
			"ASCII:CharacterModelID": { 
				"pointerChainOffsets": [0x24, 0x4], 
				"offsetToPointedToMember": 0x4},
			"BitFlag:IsRidingAnimal": { 
				"pointerChainOffsets": [0xC, 0xC0]},
		}},
	"Struct:PlayerInputReader": {
		"offsetToMember": {
			"Bitset(byte1):ControllerButtonsPressed": 0x0,
			"Bitset(byte2):ControllerButtonsPressed": 0x1}
		},
	"Struct:PlayerProfileData": {
		"sizeInBytes": 2840,
		"offsetToMember": {
			"32-bit:SavedCash": 0x8,
			"Bitset:PlayerProfileUnlocks": 0xC,
			"ASCII(AreaID):FurthestCompletedStoryChapter(alt1)": 0x23C,
			"32-bit:StoryModeRetryCount": 0x28C,
			"8-bit:CurrentDifficultyID": 0x292,
			"Float:TimeSpentPlaying": 0x388,
			"Bitset:BountyHunterMissionsCompleted": 0x7B0,
			"ASCII:PlayerProfileName": 0x7BC,
			"Bitset:ActivatedCheats": 0x800}
		},
	"Struct:RewardMenuAndStartChpMenuDisplayData": {
		"pointerChainToMember": {
			"BitFlag:IsStartChpMenuActive": { 
				"pointerChainOffsets": [0x214]},
			"BitFlag:IsRewardMenuOrStartChpMenuDisplayed": { 
				"pointerChainOffsets": [0xAC, 0x38]},
			"BitFlag_IsQuitConfirmationMenuDisplayed": { 
				"pointerChainOffsets": [0xAC, 0x34, 0x1C, 0xE4]},
			"BitFlag_HighlightedMenuItem": { 
				"pointerChainOffsets": [0xAC, 0x34, 0x1C, 0x8A4]},
			"32-bit:BountyCollected": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0xAC, 0x34, 0x1C, 0x9E4],
					RELEASE_REGION_USA: [0xAC, 0x34, 0x1C, 0x9C4]}},
			"BitFlag:IsFirstPopupMenuDisplayed": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0xAC, 0x34, 0x1C, 0x964],
					RELEASE_REGION_USA: [0xAC, 0x34, 0x1C, 0x944]}},
			"8Bit:MenuDepth": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0xAC, 0x34, 0x1C, 0x9D4],
					RELEASE_REGION_USA: [0xAC, 0x34, 0x1C, 0x9B4]}},
			"32-bit:Balance": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0xAC, 0x34, 0x1C, 0xA04],
					RELEASE_REGION_USA: [0xAC, 0x34, 0x1C, 0x9E4]}},
			"ASCII:ItemUnlockID-BountyRating": { 
				"pointerChainOffsets": { // TODO check if these offsets works in RATools --> if they effectively go to this pointed address
					RELEASE_REGION_EUR: [0xAC, 0x34, 0x1C, 0xA70 + 0x20 + 0x4],
					RELEASE_REGION_USA: [0xAC, 0x34, 0x1C, 0xA30 + 0x20 + 0x4]}},
			"Pointer:RewardMenuAndStartChpMenuDisplayData_L1-2d0": { 
				"pointerChainOffsets": [0x2D0]},
			"BitFlag:IsRatingObjectiveStarDisplayed-Accuracy": { // TODO check if these offsets works in RATools --> if they effectively go to this pointed address
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x2D0, 0x24, 0x1c, 0x810 + 0x4],
					RELEASE_REGION_USA: [0x2D0, 0x24, 0x1c, 0x7F0 + 0x4]}},
			"BitFlag:IsRatingObjectiveStarDisplayed-DamageTaken": { // TODO check if these offsets works in RATools --> if they effectively go to this pointed address
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x2D0, 0x24, 0x1c, 0x810 + 0x10 + 0x4],
					RELEASE_REGION_USA: [0x2D0, 0x24, 0x1c, 0x7F0 + 0x10 + 0x4]}},
			"BitFlag:IsRatingObjectiveStarDisplayed-Time": { // TODO check if these offsets works in RATools --> if they effectively go to this pointed address
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x2D0, 0x24, 0x1c, 0x810 + 0x20 + 0x4],
					RELEASE_REGION_USA: [0x2D0, 0x24, 0x1c, 0x7F0 + 0x20 + 0x4]}},
			"BitFlag:IsRatingObjectiveStarDisplayed-BestCombo": { // TODO check if these offsets works in RATools --> if they effectively go to this pointed address
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x2D0, 0x24, 0x1c, 0x810 + 0x30 + 0x4],
					RELEASE_REGION_USA: [0x2D0, 0x24, 0x1c, 0x7F0 + 0x30 + 0x4]}},
			"ASCIIField:RewardMenuDisplayText": { 
				"pointerChainOffsets": [0x2D0, 0x24, 0x34]},
			
		}},
	"ASCIIField:RewardMenuDisplayText": {
		"offsetToMember": {
			"ASCII:Accuracy": 0x150}
		},
	"Struct:InGameMenuController": {
		"offsetToMember": {
			"ASCII:InGameMenuID": 0x18,
			"InvertedBitFlag:IsInGameMenuDisplayed": 0x38,
			"8-bit:HighlightedMenuItemID": 0x318},
		},
	"Struct:SinglePlayerData": {
		"pointerChainToMember": {
			"Float:PlayerHP": { 
				"pointerChainOffsets": [0x18, 0x10]},
			"Float:PlayerMaxHP": { 
				"pointerChainOffsets": [0x18, 0x14]},
			"ASCII:GameTriggerID": { 
				"pointerChainOffsets": [0x168, 0xEC],
				"offsetToPointedToMember": 0x4}, // <-- This is the offset to the member inside the struct, which the pointer chain points to

			// Via: +0x36C - [32-bit (layer-1) Pointer:GameplayStats] -> [Struct:SinglePlayerMissionStats]
			"32-bit:HeadShots(kills)": { // TODO verify if this memAddr counts 'Headshot Kills' or 'Headshots' -- otherwise try using [Struct:SinglePlayerData].[32-bit:HeadShots]
				"pointerChainOffsets": [0x36C, 0x30]},
			"32-bit:DeathToll": { 
				"pointerChainOffsets": [0x36C, 0x5C]},
			"Float:RawTotalDamageTaken": { 
				"pointerChainOffsets": [0x36C, 0x70]},
			"32-bit:ShotsFired(functional)": { 
				"pointerChainOffsets": [0x36C, 0x194]},
			"32-bit:ShotsHit(functional)": { 
				"pointerChainOffsets": [0x36C, 0x198]},
			"32-bit:DeadeyeOrSpecialMoveUseCount": { 
				"pointerChainOffsets": [0x36C, 0x1BC]},
			"32-bit:HighestComboMultiplier": { 
				"pointerChainOffsets": [0x36C, 0x1C0]},
			"Float:HighestCombo": { 
				"pointerChainOffsets": [0x36C, 0x1C4]},

			// Via: +0x36C - [32-bit (layer-1) Pointer:GameplayStats] -> [Struct:ShowdownPlayerStats]
			"32-bit:HighestComboMultiplier_Showdown": { 
				"pointerChainOffsets": [0x36C, 0x4C0]},
			"Float:HighestCombo_Showdown": { 
				"pointerChainOffsets": [0x36C, 0x4C4]},

			// Via: +0xC - [32-bit (layer-1) Pointer] -> [Struct:ActorData_B]
			"Struct(PS2Vector):ActorLocation": { 
				"pointerChainOffsets": [0xC, 0xC, 0x90]},
			"BitFlag:IsRidingAnimal": { 
				"pointerChainOffsets": [0xC, 0xC, 0xC0]},

			// Via: +0xC - [32-bit (layer-1) Pointer] -> [Struct:ActorData_B] +0x80 - [32-bit (layer-1) Pointer] -> [Struct:WeaponManager]
			"8-bit:EquippedWeaponID": { 
				"pointerChainOffsets": [0xC, 0x80, 0x48]},
			"Bitfield:UniversalWeaponState": { 
				"pointerChainOffsets": [0xC, 0x80, 0xA8]},
			"Array:WeaponData": { 
				"pointerChainOffsets": [0xC, 0x80, 0x20, 0x0, 0x4]},

			"Bitset:PlayerProfileUnlocks": { 
				"pointerChainOffsets": [0x5C8]},
		}},
	"Struct:GameController": {
		"pointerChainToMember": {
			"32-bit:EquippedWeaponReserveAmmo": { 
				"pointerChainOffsets": [0x2C, 0x14]},
			"Pointer:ShowdownPosterMenuController": {
				"pointerChainOffsets": [0xC0]},
			"BitFlag:IsShowdownPosterMenuDisplayed": { 
				"pointerChainOffsets": [0xC0, 0x48, 0xFD]},

			"8-bit:ShowdownPlayerTeamID-1": { 
				"pointerChainOffsets": [0xC0, 0x53C]},
			"BitFlag:IsShowdownPlayerSlotFilled-1": { 
				"pointerChainOffsets": [0xC0, 0x7C, 0xFE]},
			"ASCII:CharacterModelID-1": { 
				"pointerChainOffsets": [0xC0, 0x7C],
				"offsetToPointedToMember": 0x13D},

			"8-bit:ShowdownPlayerTeamID-2": { 
				"pointerChainOffsets": [0xC0, 0x588]},
			"BitFlag:IsShowdownPlayerSlotFilled-2": { 
				"pointerChainOffsets": [0xC0, 0x80, 0xFE]},
			"ASCII:CharacterModelID-2": { 
				"pointerChainOffsets": [0xC0, 0x80],
				"offsetToPointedToMember": 0x13D},

			"8-bit:ShowdownPlayerTeamID-3": { 
				"pointerChainOffsets": [0xC0, 0x5D4]},
			"BitFlag:IsShowdownPlayerSlotFilled-3": { 
				"pointerChainOffsets": [0xC0, 0x84, 0xFE]},
			"ASCII:CharacterModelID-3": { 
				"pointerChainOffsets": [0xC0, 0x84],
				"offsetToPointedToMember": 0x13D},

			"8-bit:ShowdownPlayerTeamID-4": { 
				"pointerChainOffsets": [0xC0, 0x620]},
			"BitFlag:IsShowdownPlayerSlotFilled-4": { 
				"pointerChainOffsets": [0xC0, 0x88, 0xFE]},
			"ASCII:CharacterModelID-4": { 
				"pointerChainOffsets": [0xC0, 0x88],
				"offsetToPointedToMember": 0x13D},

			"32-bit:Cash(functional)": { 
				"pointerChainOffsets": [0x5874],
				"offsetToPointedToMember": 0x8},
			"32-bit:CashAcquiredByOtherMeans": { 
				"pointerChainOffsets": [0x5874],
				"offsetToPointedToMember": 0xC},
			"32-bit:Combo": { 
				"pointerChainOffsets": [0x5874],
				"offsetToPointedToMember": 0x10},
			"32-bit:ComboMultiplier": { 
				"pointerChainOffsets": [0x5874],
				"offsetToPointedToMember": 0x14},
		}},
	"Struct:Undefined_03": {
		"offsetToMember": {
			"32-bit:MissionKillcount": 0xD8}
		},
	"Struct:ExtraMissionData.RogueValley_Ch8": {
		"pointerChainToMember": {
			"BitFlag:IsTreasureOpened-A": { 
				"pointerChainOffsets": [0x4, 0x4C]},
			"BitFlag:IsTreasureOpened-B": { 
				"pointerChainOffsets": [0x8, 0x4C]},
			"BitFlag:IsTreasureOpened-C": { 
				"pointerChainOffsets": [0xC, 0x4C]}}
		},
	"Struct:ExtraMissionData.TheTraitor_Ch13": {
		"pointerChainToMember": {
			"BitFlag:IsAlliedCannonDestroyed-A": { 
				"pointerChainOffsets": [0x4, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-B": { 
				"pointerChainOffsets": [0x8, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-C": { 
				"pointerChainOffsets": [0xC, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-D": { 
				"pointerChainOffsets": [0x10, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-E": { 
				"pointerChainOffsets": [0x14, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-F": { 
				"pointerChainOffsets": [0x18, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-G": { 
				"pointerChainOffsets": [0x1C, 0x4C]},
			"BitFlag:IsAlliedCannonDestroyed-H": { 
				"pointerChainOffsets": [0x20, 0x4C]}}
		},
	"Array:MajorCharacterData": {
		"pointerChainToMember": {
			"Float:MajorCharacterHP-0": { 
				"pointerChainOffsets": [0x0, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-0": { 
				"pointerChainOffsets": [0x0, 0x18, 0x14]},
			"ASCII:MajorCharacterName-0": { 
				"pointerChainOffsets": [0x0, 0x4],
				"offsetToPointedToMember": 0x0},

			"Float:MajorCharacterHP-1": { 
				"pointerChainOffsets": [0x8, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-1": { 
				"pointerChainOffsets": [0x8, 0x18, 0x14]},
			"ASCII:MajorCharacterName-1": { 
				"pointerChainOffsets": [0x8, 0x4],
				"offsetToPointedToMember": 0x0},

			"Float:MajorCharacterHP-2": { 
				"pointerChainOffsets": [0x10, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-2": { 
				"pointerChainOffsets": [0x10, 0x18, 0x14]},
			"ASCII:MajorCharacterName-2": { 
				"pointerChainOffsets": [0x10, 0x4],
				"offsetToPointedToMember": 0x0},

			"Float:MajorCharacterHP-3": { 
				"pointerChainOffsets": [0x18, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-3": { 
				"pointerChainOffsets": [0x18, 0x18, 0x14]},
			"ASCII:MajorCharacterName-3": { 
				"pointerChainOffsets": [0x18, 0x4],
				"offsetToPointedToMember": 0x0},

			"Float:MajorCharacterHP-4": { 
				"pointerChainOffsets": [0x20, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-4": { 
				"pointerChainOffsets": [0x20, 0x18, 0x14]},
			"ASCII:MajorCharacterName-4": { 
				"pointerChainOffsets": [0x20, 0x4],
				"offsetToPointedToMember": 0x0},

			"Float:MajorCharacterHP-5": { 
				"pointerChainOffsets": [0x28, 0x18, 0x10]},
			"Float:MajorCharacterMaxHP-5": { 
				"pointerChainOffsets": [0x28, 0x18, 0x14]},
			"ASCII:MajorCharacterName-5": { 
				"pointerChainOffsets": [0x28, 0x4],
				"offsetToPointedToMember": 0x0},
		}},
	"Struct:InteractableZone.GatlingGun": {
		"offsetToMember": {
			"ASCII:InteractableZoneID": 0x1C,
			"BitFlag:IsGatlingGunManned": 0x169}
		},
	"Struct:PuppetshowManager": {
		"offsetToMember": {
			"ASCII:PuppetshowID": 0x68}
		},
	"Struct:WeaponData": {
		"sizeInBytes": 8,
		"pointerChainToMember": {
			"BitFlag:IsWeaponInInventory": {
				"pointerChainOffsets": [0x4, 0x1D0]},
		}},
	"Struct:GameplayTimers": {
		"offsetToMember": {
			"Float:CountdownTimer(functional)": 0x1C,
			"Float:TimeSpentInGame(functional)": 0x20}
		},
	"Struct:ShowdownPlayerSettings_A": {
		"sizeInBytes": 92,
		"offsetToMember": {
			"Lower4:TeamID": 0x0,
			"ASCII:CharacterModelID": 0x5,
			"ASCII:ShowdownAISetting": 0x36}
		},
	"Struct:ShowdownPlayerSettings_B": {
		"sizeInBytes": 336,
		"offsetToMember": {
			"ASCII:CharacterModelID": 0x1,
			"Lower4:TeamID": 0xB,
			"BitFlag:IsShowdownPlayerSlotFilled": 0x13,
			"ASCII:ShowdownAISetting": 0x139}
		},		
	"Struct:ShowdownPlayerData_0": {
		"sizeInBytes": 16,
		"offsetToMember": {
			"Struct:ShowdownPlayerData_A": 0x0,
			"Struct:ShowdownPlayerData_B": 0x4,
			"Struct:ShowdownPlayerData_C": 0x8,
			"Struct:ShowdownPlayerData_D": 0xC}
		},
	"Struct:ShowdownPlayerData_B": {
		"pointerChainToMember": {
			"32-bit:CashCollected": { 
				"pointerChainOffsets": [0x2B4, 0xC]},

			// Via: [Struct:ShowdownPlayerStats]
			"32-bit:DeathToll": { 
				"pointerChainOffsets": [0x30, 0x5C]},
			"Float:RawTotalDamageTaken": { 
				"pointerChainOffsets": [0x30, 0x70]},
			"32-bit:HighNoonRoundsWon": { 
				"pointerChainOffsets": [0x30, 0x430]},
			"32-bit:ShotsFired(functional)": { 
				"pointerChainOffsets": [0x30, 0x494]},
			"32-bit:ShotsHit(functional)": { 
				"pointerChainOffsets": [0x30, 0x498]},
			"32-bit:HeadShots": { 
				"pointerChainOffsets": [0x30, 0x4A4]},

			// Via: [Struct:WeaponManager]		
			"8-bit:EquippedWeaponID": { 
				"pointerChainOffsets": [0x18, 0x80, 0x48]}}
		},
	"Struct:ShowdownPlayerData_C": {
		"pointerChainToMember": {
			"Float:PlayerHP": { 
				"pointerChainOffsets": [0x18, 0x10]},
			"Float:PlayerMaxHP": { 
				"pointerChainOffsets": [0x18, 0x14]}
		}},
	"Struct:MultiplayerRewardMenuData": {
		"pointerChainToMember": {
			"ASCIIFlag(IsWinner):Player-1": {
				"pointerChainOffsets": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": {
					RELEASE_REGION_EUR: 0x0,
					RELEASE_REGION_USA: 0x180 + 0x0}},
			"ASCIIFlag(IsWinner):Player-2": {
				"pointerChainOffsets": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": {
					RELEASE_REGION_EUR: 0x10,
					RELEASE_REGION_USA: 0x180 + 0x10}},
			"ASCIIFlag(IsWinner):Player-3": {
				"pointerChainOffsets": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": {
					RELEASE_REGION_EUR: 0x20,
					RELEASE_REGION_USA: 0x180 + 0x20}},
			"ASCIIFlag(IsWinner):Player-4": {
				"pointerChainOffsets": [0x28, 0x24, 0x34],
				"offsetToPointedToMember": {
					RELEASE_REGION_EUR: 0x30,
					RELEASE_REGION_USA: 0x180 + 0x30}},
			"ASCIIFlag:IsMultiplayerRewardMenuDisplayed": {
				"pointerChainOffsets": [0x28],
				"offsetToPointedToMember": 0x0},
			"BitFlag:IsPopupMenuDisplayed": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x28, 0x24, 0x1c, 0xF44],
					RELEASE_REGION_USA: [0x28, 0x24, 0x1c, 0xB74]}},
			"32-bit:HighlightedPopupMenuItem": {
				"pointerChainOffsets": {
					RELEASE_REGION_EUR: [0x28, 0x24, 0x1c, 0x1414],
					RELEASE_REGION_USA: [0x28, 0x24, 0x1c, 0x1044]}},
		}},
	"Struct:ShowdownModeSettings": {
		"offsetToMember": {
			"Lower4:GameMode": 0x0,
			"Lower4:BountyHunterModeBountyLimitSetting": 0x4,
			"Lower4:SundownModeFightTimeSetting": 0x8,
			"Lower4:HighNoonModeNumberOfWinsSetting": 0xC,
			"Lower4:PowersUpsSetting": 0x18} 
		},
	}

function memory_getStruct_SizeInBytes(string_structKey) =>
	memory_StructDefs[string_structKey]["sizeInBytes"]

function memory_getStruct_OffsetToMember(string_structKey, string_memberKey) =>
	memory_StructDefs[string_structKey]["offsetToMember"][string_memberKey]

function memory_getStuct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

function memory_getStuct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

function memory_getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
	
function memory_getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

function memGenerate_pointerChainAccessor(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToPointedToMember = 0, memAccessorType_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStuct_offsetSequenceToMember(string_structKey, string_pointerChainKey)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return accessor(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

function memGenerate_pointerChainAccessor_byReleaseRegion(string_structKey, string_pointerChainKey, memAdrr_basePointer, enum_releaseRegion, int_offsetToPointedToMember = 0, memAccessorType_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStuct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return accessor(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
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
	// 	},

	DATATYPE_BitFlag: {
		"InvertedBitFlag:IsLogoScreenLoading": {RELEASE_REGION_USA: 0x4FAD6C, RELEASE_REGION_EUR: 0x4fd3ec, RELEASE_REGION_JPN: sNULL}, 
		"BitFlag:IsPlayingBountyHunterMode": {RELEASE_REGION_USA: 0x79e21c, RELEASE_REGION_EUR: 0x7a099c, RELEASE_REGION_JPN: sNULL},
		"BitFlag:IsInPauseMenu": {RELEASE_REGION_USA: 0x73AF0C, RELEASE_REGION_EUR: 0x73d68c, RELEASE_REGION_JPN: sNULL}, // unused 
		},
	DATATYPE_8Bit: {
		"Bitfield:GameMode": {RELEASE_REGION_USA: 0x4f9470, RELEASE_REGION_EUR: 0x4fbaf0, RELEASE_REGION_JPN: sNULL},
		"Bitfield:AreaState": {RELEASE_REGION_USA: 0x6aaa9c, RELEASE_REGION_EUR: 0x6b0a1c, RELEASE_REGION_JPN: sNULL},
		"8-bit:NumberOfPlayers": {RELEASE_REGION_USA: 0x73b5ec, RELEASE_REGION_EUR: 0x73dd6c, RELEASE_REGION_JPN: 0x73f2ec},
		"8-bit:ActivePlayerProfileID": {RELEASE_REGION_USA: 0x742118, RELEASE_REGION_EUR: 0x744898, RELEASE_REGION_JPN: sNULL}, // Unused
		},	
	DATATYPE_ASCII: {
		"ASCII:PS2GameID": {RELEASE_REGION_USA: 0x54a04c, RELEASE_REGION_EUR: 0x54c7cc, RELEASE_REGION_JPN: 0x54dd4c},
		"ASCII:AreaID(functional)": {RELEASE_REGION_USA: 0x79dea0, RELEASE_REGION_EUR: 0x7a0620, RELEASE_REGION_JPN: sNULL},		
		"ASCIIFlag:IsEndingCreditsPlaying": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x1f7ec20, RELEASE_REGION_JPN: sNULL}, // Used in discontinued achievements
		},
	DATATYPE_32Bit: {
		"32-bit:AlwaysNULL": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: 0x40, RELEASE_REGION_JPN: sNULL}, // Unused
		"32-bit:SelectedPosterMenuShowdownStageID": {RELEASE_REGION_USA: 0x74f500, RELEASE_REGION_EUR: 0x751c80, RELEASE_REGION_JPN: sNULL},
		"32-bitFlag:IsAnimationLoading": {RELEASE_REGION_USA: 0x745170, RELEASE_REGION_EUR: 0x7478f0, RELEASE_REGION_JPN: sNULL},

		},
	DATATYPE_Float: {
		"FloatFlag:IsInGame(preferred)": {RELEASE_REGION_USA: 0x4F9F2C, RELEASE_REGION_EUR: 0x4fc5ac, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_32BitPointer: {
		"Pointer:UndefinedStruct_03(preferred)": {RELEASE_REGION_USA: 0x4f7cf0, RELEASE_REGION_EUR: 0x4fa370, RELEASE_REGION_JPN: sNULL},
		"Pointer:ExtraMissionData": {RELEASE_REGION_USA: 0x4f792c, RELEASE_REGION_EUR: 0x4f9fac, RELEASE_REGION_JPN: sNULL},
		"Pointer:MajorCharacterData": {RELEASE_REGION_USA: 0x4f7d20, RELEASE_REGION_EUR: 0x4fa3a0, RELEASE_REGION_JPN: sNULL},
		"Pointer:MultiplayerRewardMenuData(preferred)": {RELEASE_REGION_USA: 0x54a348, RELEASE_REGION_EUR: 0x54cac8, RELEASE_REGION_JPN: sNULL},
		"Pointer:GatlingGunZoneData": {RELEASE_REGION_USA: 0x55b6a8, RELEASE_REGION_EUR: 0x55de28, RELEASE_REGION_JPN: sNULL},
		"Pointer:GameController": {RELEASE_REGION_USA: 0x5602a0, RELEASE_REGION_EUR: 0x562a20, RELEASE_REGION_JPN: sNULL},
		"Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)": {RELEASE_REGION_USA: 0x54a370, RELEASE_REGION_EUR: 0x54caf0, RELEASE_REGION_JPN: sNULL},
		"Pointer:InGameMenuController(preferred)": {RELEASE_REGION_USA: 0x73af04, RELEASE_REGION_EUR: 0x73d684, RELEASE_REGION_JPN: sNULL},
		"Pointer:ActivePlayerProfile": {RELEASE_REGION_USA: 0x742158, RELEASE_REGION_EUR: 0x7448d8, RELEASE_REGION_JPN: sNULL},
		"Pointer:SinglePlayerData(preferred)": {RELEASE_REGION_USA: 0x7608f0, RELEASE_REGION_EUR: 0x763070, RELEASE_REGION_JPN: sNULL},

		"Pointer:PuppetshowManager": {RELEASE_REGION_USA: 0x7a0280, RELEASE_REGION_EUR: 0x7a2a00, RELEASE_REGION_JPN: sNULL},
		"Pointer:GameplayTimers": {RELEASE_REGION_USA: 0x79e008, RELEASE_REGION_EUR: 0x7a0788, RELEASE_REGION_JPN: sNULL},
		},
	DATATYPE_Struct: {
		"Array:ShowdownPlayerSettings_A": {RELEASE_REGION_USA: 0x73dcb8, RELEASE_REGION_EUR: 0x740438, RELEASE_REGION_JPN: sNULL}, // Unused
		"Array:ShowdownPlayerSettings_B": {RELEASE_REGION_USA: 0x73b099, RELEASE_REGION_EUR: 0x73d819, RELEASE_REGION_JPN: sNULL},
		"Array:PlayerProfileData": {RELEASE_REGION_USA: 0x73de88, RELEASE_REGION_EUR: 0x740608, RELEASE_REGION_JPN: sNULL}, // Unused
		"Array:ActorData": {RELEASE_REGION_USA: 0x75fa50, RELEASE_REGION_EUR: 0x7621d0, RELEASE_REGION_JPN: sNULL},
		"Struct:PlayerInputReader": {RELEASE_REGION_USA: 0x73b7c2, RELEASE_REGION_EUR: 0x73df42, RELEASE_REGION_JPN: sNULL},
		"Struct:ShowdownModeSettings": {RELEASE_REGION_USA: 0x73de30, RELEASE_REGION_EUR: 0x7405b0, RELEASE_REGION_JPN: sNULL},
		"Bitset:ShowdownCharacterUnlocks": {RELEASE_REGION_USA: 0x73de61, RELEASE_REGION_EUR: 0x7405e1, RELEASE_REGION_JPN: sNULL},
		"Bitset:ShowdownMapUnlocks": {RELEASE_REGION_USA: 0x73de5f, RELEASE_REGION_EUR: 0x7405df, RELEASE_REGION_JPN: sNULL},
		"Bitset:JournalPageUnlocks": {RELEASE_REGION_USA: 0x73de4d, RELEASE_REGION_EUR: 0x7405cd, RELEASE_REGION_JPN: sNULL},
		"Bitset:CheatUnlocks": {RELEASE_REGION_USA: 0x73de4c, RELEASE_REGION_EUR: 0x7405cc, RELEASE_REGION_JPN: sNULL}, // Unused

		"Array:ShowdownPlayerData": {RELEASE_REGION_USA: 0x761138, RELEASE_REGION_EUR: 0x7638b8, RELEASE_REGION_JPN: sNULL},
	}}


function memory_getAddress(enum_dateType, string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[enum_dateType][string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}

// ==================
// • Memory UTILITY •
// ==================
memUtil_bitIndexToMemAccessor = {
	0: bit0, 1: bit1, 2: bit2, 3: bit3,
	4: bit4, 5: bit5, 6: bit6, 7: bit7}	

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

function memUtil_asciiStringToHex(string_s) { // length of string_s maximum 4; Returns a little endian hex, not big endian
	let_stringLength = length(string_s)

	if (let_stringLength > 4)
		util_throwError(format("String length of: {0}, is too large to handle", let_stringLength))

	let_hexValue = 0
	for let_characterIndex in range(0, length(string_s) - 1) {
		let_characterAsHex = memUtil_asciiToHex[substring(string_s, let_characterIndex, 1)]
		if (let_characterIndex == 0) let_hexValue = let_characterAsHex
		else if (let_characterIndex == 1) let_hexValue = let_hexValue + (let_characterAsHex * 0x100)
		else if (let_characterIndex == 2) let_hexValue = let_hexValue + (let_characterAsHex * 0x10000)
		else let_hexValue = let_hexValue + (let_characterAsHex * 0x1000000)}
	return let_hexValue}
 

function is_ReleaseRegion(enum_releaseRegion) {
	let_memAddr_gameID = memory_getAddress(DATATYPE_ASCII, "ASCII:PS2GameID", enum_releaseRegion)
	let_string_gameID = sNULL

	if(enum_releaseRegion == RELEASE_REGION_USA) {
		let_string_gameID = "SLUS_205.00"
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
	memory_getAddress(DATATYPE_32Bit, "32-bit:AlwaysNULL", enum_releaseRegion)

function memUtil_bitwiseOR(memAccessor_A, memAccessor_B) => // A OR B => A + B - A AND B (workaround as rCheevos doesn't support bitwise-OR out-of-the-box)
	memAccessor_A + memAccessor_B - (memAccessor_A & memAccessor_B)

function memUtil_createArrayOfBitIndicesToSub(array_bitIndicesToAdd) { // This function should be used when counting flags via a bitcount, where not all bits should be counted (eg. bitcount(0xA) - bit0(0xA) - bit1(0xA))
		let_array_bitIndicesToSub = [0,1,2,3,4,5,6,7]
		for let_bitIndex in array_bitIndicesToAdd 
			let_array_bitIndicesToSub[let_bitIndex] = iNULL
		return let_array_bitIndicesToSub
	}

function memGenerate_SumOf_BitsetFlags(dict_bitsetFlagData, function_memAccessorGeneratorToBitset, enum_releaseRegion) { // function_memAccessorGeneratorToBitset should require parameters: (int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion)
	// BUG_RATools - using memGenerate_SumOf_BitsetFlags() may put RATools v1.14.1 into infinite processing (refer to https://github.com/Jamiras/RATools/issues/503) - As a workaround use memGenerate_SumOf_BitsetFlags_noSubSource()
	let_array_memAccessorsToSum = []
	let_array_memAccessorsToSub = [] 
	for let_byteIndex in dict_bitsetFlagData {
		let_array_bitIndices = dict_bitsetFlagData[let_byteIndex]
		let_bitCount = length(let_array_bitIndices)

		// --- AddSource bitcount [byte] ---
		if (let_bitCount == 8) { 
			let_memAccessor_bitcount_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount_toBitset)
		} 

		 // --- AddSource bitcount [byte] + SubSource [each bit] (which isn't part of the required flags) ---
		else if (8 > let_bitCount && let_bitCount > 4) {
			let_memAccessor_bitcount_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount_toBitset)
			for let_bitIndexToSub in memUtil_createArrayOfBitIndicesToSub(let_array_bitIndices) {
				if (let_bitIndexToSub != iNULL)	{
					let_memAccessor_bit_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndexToSub], enum_releaseRegion)
					array_push(let_array_memAccessorsToSub, let_memAccessor_bit_toBitset)
				}
			}
		}

		// --- AddSource [each bit] ---
		else if (let_bitCount <= 4) { 
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum, let_memAccessor_bit_toBitset)
			}
		} 
		
		else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
	}
	
	return
		sum_of(let_array_memAccessorsToSum, memAccessor => memAccessor) // Add all flags
		- sum_of(let_array_memAccessorsToSub, memAccessor => memAccessor) // Subtract flags which aren't part of bitset, because of usage of bitcount to lower amount of lines necessary
	}

function memGenerate_SumOf_BitsetFlags_noSubSource(dict_bitsetFlagData, function_memAccessorGeneratorToBitset, enum_releaseRegion) { // function_memAccessorGeneratorToBitset should require parameters: (int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion)
	let_array_memAccessorsToSum = []
	for let_byteIndex in dict_bitsetFlagData {
		let_array_bitIndices = dict_bitsetFlagData[let_byteIndex]
		let_bitCount = length(let_array_bitIndices)

		// --- AddSource bitcount [byte] ---
		if (let_bitCount == 8) {
			let_memAccessor_bitcount_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, bitcount, enum_releaseRegion)
			array_push(let_array_memAccessorsToSum, let_memAccessor_bitcount_toBitset)
		} 

		// --- AddSource [each bit] ---
		else if (let_bitCount < 8) { 
			for let_bitIndex in let_array_bitIndices {
				let_memAccessor_bit_toBitset = function_memAccessorGeneratorToBitset(let_byteIndex - 1, memUtil_bitIndexToMemAccessor[let_bitIndex], enum_releaseRegion)
				array_push(let_array_memAccessorsToSum, let_memAccessor_bit_toBitset)
			}
		} 
		
		else util_throwError(format("Was not able to evaluate byte index: {0}", let_byteIndex))
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

function wasPrior_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prior(c))

function wasPrev_ASCII_EqualTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s, c => prev(c))

function wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
	ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))

function on_ASCII_changeTo(memAddr_ASCII, string_s) =>
	ASCII_Equals(memAddr_ASCII, string_s)  
	&& wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s)
	

// .......................
// ◦ PLAYER INPUT READER ◦
// '''''''''''''''''''''''
function current_FlagState_PlayerInput_X(enum_releaseRegion) => 
	bit6( 
		memory_getAddress(DATATYPE_Struct, "Struct:PlayerInputReader", enum_releaseRegion) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerInputReader", "Bitset(byte2):ControllerButtonsPressed"))

function current_FlagState_PlayerInput_R1(enum_releaseRegion) => 
	bit3( 
		memory_getAddress(DATATYPE_Struct, "Struct:PlayerInputReader", enum_releaseRegion) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerInputReader", "Bitset(byte2):ControllerButtonsPressed"))

function current_FlagState_PlayerInput_L1(enum_releaseRegion) =>
	bit2( 
		memory_getAddress(DATATYPE_Struct, "Struct:PlayerInputReader", enum_releaseRegion) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerInputReader", "Bitset(byte2):ControllerButtonsPressed"))

function current_FlagState_PlayerInput_R2(enum_releaseRegion) =>
	bit1( 
		memory_getAddress(DATATYPE_Struct, "Struct:PlayerInputReader", enum_releaseRegion) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerInputReader", "Bitset(byte2):ControllerButtonsPressed"))


function is_PlayerInput_ConfirmBtn_pressed(enum_releaseRegion) { // Check playerInput based on region, as Confirm button for JPN version is not same button as for the EUR and USA
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_X(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function on_PlayerInput_ConfirmBtn_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_X(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}

function is_PlayerInput_FireGun_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 1}

function on_PlayerInput_FireGun_release(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState > prev(let_memAccessor_inputState)}

function on_PlayerInput_FireGun_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}	

function is_PlayerInput_AimGun_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_L1(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function is_PlayerInput_DeadEyeAbility_pressed(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R2(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState == 0}

function on_PlayerInput_DeadEyeAbility_press(enum_releaseRegion) {
	let_memAccessor_inputState = sNULL
	if (enum_releaseRegion == RELEASE_REGION_EUR || enum_releaseRegion == RELEASE_REGION_USA)
		let_memAccessor_inputState = current_FlagState_PlayerInput_R2(enum_releaseRegion)
	else
		util_throwError(format("Player Input handling for release region: {0} not supported", enum_releaseRegion))
		
	return let_memAccessor_inputState < prev(let_memAccessor_inputState)}

// ...........
// ◦ AREA ID ◦
// '''''''''''
AREA_loading = "default"
AREA_MainMenu = "lvl_front"

// ------------ AREA_Campaign InnerIdlength = 3
AREA_Campaign_Stagecoach = "lvl_msn"
AREA_Campaign_BountyHunter = "lvl_hng"
// ------------ AREA_Campaign InnerIdlength = 4
AREA_Campaign_RogueValley = "lvl_bomb"
AREA_Campaign_Jailbreak = "lvl_core"
AREA_Campaign_FortDiego = "lvl_fort"
AREA_Campaign_Siege = "lvl_mans"
AREA_Campaign_Brimstone = "lvl_tomb"
// ------------ AREA_Campaign InnerIdlength = 5
AREA_Campaign_SunsetCanyon = "lvl_coach"
AREA_Campaign_BearMountain = "lvl_woods"
AREA_Campaign_CarnivalLife = "lvl_ghost"
AREA_Campaign_RangeWar = "lvl_ranch"
AREA_Campaign_EndOfTheLine = "lvl_train"
// ------------ AREA_Campaign InnerIdlength = 6
AREA_Campaign_TheTraitor = "lvl_bridge"
AREA_Campaign_HellPass = "lvl_msncyn"
AREA_Campaign_UglyStreetFight = "lvl_sher70"
// ------------ AREA_Campaign InnerIdlength = 7
AREA_Campaign_BullsEye = "lvl_perfnew"
AREA_Campaign_BattleRoyale = "lvl_roydusk"
AREA_Campaign_TheMine = "lvl_corenew"
// ------------ AREA_Campaign InnerIdlength = 8
AREA_Campaign_Traincar = "lvl_traincar"
AREA_Campaign_FreakShow = "lvl_shernite"
AREA_Campaign_GhostTown = "lvl_gunsmoke"
AREA_Campaign_TheCemetery = "lvl_cemetery"
AREA_Campaign_SaloonFight = "lvl_barfight"
AREA_Campaign_DevilsAndAngels = "lvl_trainend"
AREA_Campaign_BattleFinale = "lvl_royfinal"
AREA_Campaign_HouseOfCards = "lvl_mansintb"
AREA_Campaign_FallFromGrace = "lvl_mansroof"
// ------------ AREA_Campaign InnerIdlength = 9
AREA_Campaign_Railroaded = "lvl_traingood"

// ------------ AREA_Showdown
AREA_Showdown_TheBridge = "lvl_bridge2"
AREA_Showdown_TheMine = "lvl_core2"
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

const_Area_data = { // TODO put these coordinates inside the code notes??
	AREA_Campaign_BullsEye: { // Documentation nested here
		"PlayerLoadCoordinates": { // These are the coordinates of the player_location during loading/restart mission/retrying
			"X_Coordinate": 20.60,
			"Y_Coordinate": 12.65,
			"Z_Coordinate": -4.46},
		"PlayerStartCoordinates": { // These are the coordinates of the player_location on mission start
			"X_Coordinate": 20.64,
			"Y_Coordinate": -8.00,
			"Z_Coordinate": -5.12}},
	AREA_Campaign_BountyHunter: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 3.05,
			"Y_Coordinate": 13.39,
			"Z_Coordinate": -0.08},
		"PlayerStartCoordinates": {
			"X_Coordinate": -2.62,
			"Y_Coordinate": 41.20,
			"Z_Coordinate": 0.01}},
	AREA_Campaign_UglyStreetFight: { 
		"PlayerLoadCoordinates": {
			"X_Coordinate": 34.35,
			"Y_Coordinate": -14.90,
			"Z_Coordinate": 2.27},
		"PlayerStartCoordinates": {
			"X_Coordinate": 41.83,
			"Y_Coordinate": 7.72,
			"Z_Coordinate": 1.90}},
	AREA_Campaign_Traincar: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -0.05,
			"Y_Coordinate": 6.99,
			"Z_Coordinate": 0.00},
		"PlayerStartCoordinates": {
			"X_Coordinate": -0.05,
			"Y_Coordinate": 6.99,
			"Z_Coordinate": 0.00}},
	AREA_Campaign_Railroaded: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 2.03,
			"Y_Coordinate": 104.04,
			"Z_Coordinate": 1.63},
		"PlayerStartCoordinates": {
			"X_Coordinate": 0.06,
			"Y_Coordinate": -1.63,
			"Z_Coordinate": 1.13}},
	AREA_Campaign_CarnivalLife: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 8.45,
			"Y_Coordinate": -5.12,
			"Z_Coordinate": 4.62},
		"PlayerStartCoordinates": {
			"X_Coordinate": -7.46,
			"Y_Coordinate": -4.67,
			"Z_Coordinate": 4.83},
		"Zone_GatlingGunA": {
			"X_Coordinate": -14.96,
			"Y_Coordinate": 0.68,
			"Z_Coordinate": 9.37}},
	AREA_Campaign_FreakShow: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 21.19,
			"Y_Coordinate": -15.16,
			"Z_Coordinate": 2.39},
		"PlayerStartCoordinates": {
			"X_Coordinate": 24.66,
			"Y_Coordinate": -15.32,
			"Z_Coordinate": 2.42}},
	AREA_Campaign_RogueValley: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 138.79,
			"Y_Coordinate": 39.72,
			"Z_Coordinate": -46.58},
		"PlayerStartCoordinates": {
			"X_Coordinate": 138.79,
			"Y_Coordinate": 39.72,
			"Z_Coordinate": -46.58}},
	AREA_Campaign_GhostTown: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 50.32,
			"Y_Coordinate": 6.83,
			"Z_Coordinate": -0.13},
		"PlayerStartCoordinates": {
			"X_Coordinate": 46.48,
			"Y_Coordinate": 5.43,
			"Z_Coordinate": -0.28}},
	AREA_Campaign_TheCemetery: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -58.15,
			"Y_Coordinate": 31.69,
			"Z_Coordinate": 7.48},
		"PlayerStartCoordinates": {
			"X_Coordinate": -58.42,
			"Y_Coordinate": 40.00,
			"Z_Coordinate": 7.48}},
	AREA_Campaign_RangeWar: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 0.90,
			"Y_Coordinate": -15.37,
			"Z_Coordinate": 0.41},
		"PlayerStartCoordinates": {
			"X_Coordinate": 26.45,
			"Y_Coordinate": 0.48,
			"Z_Coordinate": 0.00}},
	AREA_Campaign_SaloonFight: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -6.9,
			"Y_Coordinate": -3.64,
			"Z_Coordinate": -2.5},
		"PlayerStartCoordinates": {
			"X_Coordinate": -3.15,
			"Y_Coordinate": 1.12,
			"Z_Coordinate": -2.46}},
	AREA_Campaign_TheTraitor: { // Both these coordinates are identical
		"PlayerLoadCoordinates": {
			"X_Coordinate": 36.82,
			"Y_Coordinate": 1.30,
			"Z_Coordinate": 4.16},
		"PlayerStartCoordinates": {
			"X_Coordinate": 36.82,
			"Y_Coordinate": 1.30,
			"Z_Coordinate": 4.16}},
	AREA_Campaign_SunsetCanyon: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -2.02,
			"Y_Coordinate": -93.09,
			"Z_Coordinate": -2.40},
		"PlayerStartCoordinates": {
			"X_Coordinate": -3.6,
			"Y_Coordinate": -90.51,
			"Z_Coordinate": -2.90}},
	AREA_Campaign_BearMountain: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 40.93,
			"Y_Coordinate": -24.63,
			"Z_Coordinate": -15.40},
		"PlayerStartCoordinates": {
			"X_Coordinate": 40.93,
			"Y_Coordinate": -24.63,
			"Z_Coordinate": -15.40}},
	AREA_Campaign_Jailbreak: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -65.31,
			"Y_Coordinate": -8.43,
			"Z_Coordinate": -2.00},
		"PlayerStartCoordinates": {
			"X_Coordinate": -65.31,
			"Y_Coordinate": -8.43,
			"Z_Coordinate": -2.00}},
	AREA_Campaign_TheMine: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -25.64,
			"Y_Coordinate": 23.10,
			"Z_Coordinate": 0.64},
		"PlayerStartCoordinates": {
			"X_Coordinate": -9.52,
			"Y_Coordinate": 20.53,
			"Z_Coordinate": 2.03}},
	AREA_Campaign_Stagecoach: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 0.76,
			"Y_Coordinate": -1.17,
			"Z_Coordinate": 2.97},
		"PlayerStartCoordinates": {
			"X_Coordinate": 0.76,
			"Y_Coordinate": -1.17,
			"Z_Coordinate": 2.91}},
	AREA_Campaign_HellPass: { // Both these coordinates are pretty identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -0.02,
			"Y_Coordinate": 0.18,
			"Z_Coordinate": 2.85},
		"PlayerStartCoordinates": {
			"X_Coordinate": -0.02,
			"Y_Coordinate": 0.18,
			"Z_Coordinate": 2.84}},
	AREA_Campaign_FortDiego: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": -11.20,
			"Y_Coordinate": -14.12,
			"Z_Coordinate": 0.85},
		"PlayerStartCoordinates": {
			"X_Coordinate": -19.93,
			"Y_Coordinate": -21.89,
			"Z_Coordinate": 0.70}},
	AREA_Campaign_EndOfTheLine: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 39.79,
			"Y_Coordinate": 29.36,
			"Z_Coordinate": 0.44},
		"PlayerStartCoordinates": { // These are zero'd because player spawns in on horseback
			"X_Coordinate": 0.0,
			"Y_Coordinate": 0.0,
			"Z_Coordinate": 0.0}},
	AREA_Campaign_DevilsAndAngels: { // Both these coordinates are identical
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 32.22,
			"Y_Coordinate": 25.42,
			"Z_Coordinate": 0.33},
		"PlayerStartCoordinates": {
			"X_Coordinate": 32.22,
			"Y_Coordinate": 25.42,
			"Z_Coordinate": 0.33}},
	AREA_Campaign_BattleRoyale: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 29.74,
			"Y_Coordinate": -13.06,
			"Z_Coordinate": 0.00},
		"PlayerStartCoordinates": {
			"X_Coordinate": 26.99,
			"Y_Coordinate": -12.30,
			"Z_Coordinate": 0.00}},
	AREA_Campaign_BattleFinale: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 11.44,
			"Y_Coordinate": -23.70,
			"Z_Coordinate": 0.80},
		"PlayerStartCoordinates": {
			"X_Coordinate": 26.92,
			"Y_Coordinate": -10.52,
			"Z_Coordinate": 0.00}},
	AREA_Campaign_Siege: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 44.11,
			"Y_Coordinate": 0.00,
			"Z_Coordinate": 0.01},
		"PlayerStartCoordinates": {
			"X_Coordinate": 34.84,
			"Y_Coordinate": 0.00,
			"Z_Coordinate": 0.49}},
	AREA_Campaign_HouseOfCards: {
		"PlayerLoadCoordinates": {
			"X_Coordinate": -3.82,
			"Y_Coordinate": 0.15,
			"Z_Coordinate": 0.99},
		"PlayerStartCoordinates": {
			"X_Coordinate": -1.98,
			"Y_Coordinate": 1.23,
			"Z_Coordinate": 0.99}},
	AREA_Campaign_FallFromGrace: { 
		"PlayerLoadCoordinates": { 
			"X_Coordinate": 9.15,
			"Y_Coordinate": 25.34,
			"Z_Coordinate": 11.22},
		"PlayerStartCoordinates": {
			"X_Coordinate": 4.17,
			"Y_Coordinate": 23.11,
			"Z_Coordinate": 10.97}},
	
	AREA_Showdown_TheBridge: {
		"PosterMenuShowdownStageID": 0xA479363B},
	AREA_Showdown_TheMine: {
		"PosterMenuShowdownStageID": 0xB62B6570},
	AREA_Showdown_WidowsPatch: {
		"PosterMenuShowdownStageID": 0x8D4B4164},
	AREA_Showdown_TheRanch: {
		"PosterMenuShowdownStageID": 0x1BBD6301},
	AREA_Showdown_Fairground: {
		"PosterMenuShowdownStageID": 0xBDF1A8C6},
	AREA_Showdown_FallenCreek: {
		"PosterMenuShowdownStageID": 0x2F5BB19C},
	AREA_Showdown_GhostTown: {
		"PosterMenuShowdownStageID": 0x6FA2063E},
	AREA_Showdown_SunsetCanyon: {
		"PosterMenuShowdownStageID": 0x7C52F704},
	AREA_Showdown_BrokenCreek: {
		"PosterMenuShowdownStageID": 0x2014BFB6},
	AREA_Showdown_MansionGrounds: {
		"PosterMenuShowdownStageID": 0xE89F9670},
	AREA_Showdown_TheMansion: {
		"PosterMenuShowdownStageID": 0x4858C414},
	AREA_Showdown_TwinRocks: {
		"PosterMenuShowdownStageID": 0x4E8ED0A3},
	AREA_Showdown_DesertFortress: {
		"PosterMenuShowdownStageID": 0xE92D2DF4},
	}

function get_Area_memAddr_InnerID(enum_releaseRegion) =>
	memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion) + 0x4

function get_AreaCampaign_ShortInnerId(enum_areaId) { 
	if (length(enum_areaId) >= 10) 
		util_throwError(format("Area_ID: {0}, is too long to create a short ID", enum_areaId))
	return memUtil_asciiStringToHex(substring(enum_areaId, 4, 3))}  // "lvl_bomb" --> "bom"

function get_AreaCampaign_LongInnerId(enum_areaId) {
	if (length(enum_areaId) < 10)
		util_throwError(format("Area_ID: {0}, is too short to create a long ID", enum_areaId))
	return memUtil_asciiStringToHex(substring(enum_areaId, 6, 4))} // "lvl_traingood" --> "aing"

function get_AreaShowdown_InnerId(enum_areaId) =>
	memUtil_asciiStringToHex(substring(enum_areaId, 4, 3)) // "lvl_bomb2" --> "bom"

function get_AreaShowdown_PosterMenuStageId(enum_areaId) =>
	const_Area_data[enum_areaId]["PosterMenuShowdownStageID"]

// -------------------------------------
function get_Area_PlayerSpawnXCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["X_Coordinate"]

function get_Area_PlayerSpawnYCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["Y_Coordinate"]

function get_Area_PlayerSpawnZCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerStartCoordinates"]["Z_Coordinate"]

function get_Area_PlayerLoadXCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["X_Coordinate"]

function get_Area_PlayerLoadYCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["Y_Coordinate"]

function get_Area_PlayerLoadZCoordinate(enum_areaId) =>
	const_Area_data[enum_areaId]["PlayerLoadCoordinates"]["Z_Coordinate"]

function get_Area_GatlingGunXCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["X_Coordinate"]

function get_Area_GatlingGunYCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["Y_Coordinate"]

function get_Area_GatlingGunZCoordinate(enum_areaId) => 
	const_Area_data[enum_areaId]["Zone_GatlingGunA"]["Z_Coordinate"]

function is_AreaLoading_active(enum_releaseRegion) => 
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion), AREA_loading)

function is_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion), enum_areaId)

function is_Area_InnerIdLength(int_innerIdLength, enum_releaseRegion) {
	let_memaddr_AreaID = memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion)
	let_memAddr_LastCharacterOfAreaId = let_memaddr_AreaID + 0x4 + (int_innerIdLength - 1)
	return 
		tbyte(let_memAddr_LastCharacterOfAreaId) != 0x00
		&& byte(let_memAddr_LastCharacterOfAreaId) != 0x00
		&& byte(let_memAddr_LastCharacterOfAreaId + 0x1) == 0x00}

function wasPrior_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prior(areaCheckComparison))

function wasPrev_Area(enum_areaId, enum_releaseRegion) =>
	ascii_string_equals(memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion), enum_areaId, transform = areaCheckComparison => prev(areaCheckComparison))

function on_Area_change(enum_releaseRegion) {
	let_memaddr_AREA = memory_getAddress(DATATYPE_ASCII, "ASCII:AreaID(functional)", enum_releaseRegion)
	return
		dword(let_memaddr_AREA) != prev(dword(let_memaddr_AREA))
		|| dword(let_memaddr_AREA + 0x4) != prev(dword(let_memaddr_AREA + 0x4))
		|| dword(let_memaddr_AREA + 0x8) != prev(dword(let_memaddr_AREA + 0x8))
		|| dword(let_memaddr_AREA + 0xC) != prev(dword(let_memaddr_AREA + 0xC))}


// ..............
// ◦ GAME STATE ◦
// ''''''''''''''
// ------------------LoadingDetection-------------------  // NOTE: ShowdownMatchLoading needs to be checked differently than below 2 options
function is_LogoScreenLoading(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "InvertedBitFlag:IsLogoScreenLoading", enum_releaseRegion)) == 0

function is_AnimationLoading(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "32-bitFlag:IsAnimationLoading", enum_releaseRegion)) == 0x00009000

// ------------------AreaState-------------------
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
	byte(memory_getAddress(DATATYPE_8Bit, "Bitfield:AreaState", enum_releaseRegion))

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
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "ASCII:GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getStruct_OffsetToPointedToMember("Struct:SinglePlayerData", "ASCII:GameTriggerID")
	// return is_ASCII_EqualTo(let_pointerChainTo_GameTriggerID, const_GameTrigger_asHex[enum_gameTrigger]["Short"])
	return is_ASCII_EqualTo(let_pointerChainTo_GameTriggerID, enum_gameTrigger)
	
	}

function on_GameTrigger_changeTo(enum_gameTrigger, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_pointerChainTo_GameTriggerID = 
		memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "ASCII:GameTriggerID", let_memAddr_SinglePlayerData) + 
		memory_getStruct_OffsetToPointedToMember("Struct:SinglePlayerData", "ASCII:GameTriggerID")
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
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memGenerate_pointerChainAccessor(
			"Struct:SinglePlayerData", "Struct(PS2Vector):ActorLocation", let_memAddr_SinglePlayerData, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToMember("Struct:PS2Vector", "Float:X_Coordinate"), 
			memAccessorType_toPointedToMember = float)
	return let_memAccessor_PlayerCoordinate}

function current_PlayerYCoordinate(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memGenerate_pointerChainAccessor(
			"Struct:SinglePlayerData", "Struct(PS2Vector):ActorLocation", let_memAddr_SinglePlayerData, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToMember("Struct:PS2Vector", "Float:Y_Coordinate"), 
			memAccessorType_toPointedToMember = float)
	return let_memAccessor_PlayerCoordinate}
	
function current_PlayerZCoordinate(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_memAccessor_PlayerCoordinate = 
		memGenerate_pointerChainAccessor(
			"Struct:SinglePlayerData", "Struct(PS2Vector):ActorLocation", let_memAddr_SinglePlayerData, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToMember("Struct:PS2Vector", "Float:Z_Coordinate"), 
			memAccessorType_toPointedToMember = float)
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
BitsetFlagData_JournalPageUnlocks = { // 137 flags
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
BitsetFlagData_ShowdownCharactersUnlocks = { // 48 flags
	1: [5,6,7],
	2: [0,1,2,3,4,5,6,7],
	3: [0,1,2,3,4,5,6,7],
	4: [0,1,2,3,4,5,6,7],
	5: [0,1,2,3,4,5,6,7],
	6: [0,1,2,3,4,5,6,7],
	7: [0,1,2,3,4]}
// ----------------ShowdownStages--------------------
BitsetFlagData_ShowdownMapUnlocks = { // 13 flags
	1: [5,6,7],
	2: [0,1,2,3,4,5,7],
	3: [0,1,3]}

// ----------------Cheats--------------------
BitsetFlagData_CheatUnlocks = { // 10 flags
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
	let_memAddr_SelectedPlayerProfile = memory_getAddress(DATATYPE_8Bit, "8-bit:ActivePlayerProfileID", enum_releaseRegion)
	return byte(let_memAddr_SelectedPlayerProfile) == int_playerProfileNumber} 

// ----------------PlayerProfile STATISTICS--------------------
function current_PlayerProfile_SavedCash(enum_releaseRegion) {
	let_memAddrPointerTo_ActivePlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_Cash = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "32-bit:SavedCash")
	return dword(dword(let_memAddrPointerTo_ActivePlayerProfileData) + let_offsetTo_Cash)}

function on_PlayerProfileStat_TimeSpentPlaying_change(enum_releaseRegion)	{
	let_memAddrPointerTo_ActivePlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_Statistic = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Float:TimeSpentPlaying")
	let_memAccessor_Statistic = float(dword(let_memAddrPointerTo_ActivePlayerProfileData) + let_offsetTo_Statistic)
	return let_memAccessor_Statistic != prev(let_memAccessor_Statistic)}

function on_PlayerProfileStat_StoryModeRetries_increment(enum_releaseRegion) {
	let_memAddrPointerTo_ActivePlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_Statistic = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "32-bit:StoryModeRetryCount")
	let_memAccessor_Statistic = dword(dword(let_memAddrPointerTo_ActivePlayerProfileData) + let_offsetTo_Statistic)
	return let_memAccessor_Statistic > prev(let_memAccessor_Statistic)}



// ----------------PlayerProfile UNLOCKS--------------------
WEAPON_COUNT = 24
UPGRADEABLE_WEAPON_COUNT = 16
HP_UPGRADE_COUNT = 7
DEADEYE_UPGRADE_COUNT = 5 
BitsetFlagData_PlayerProfileUnlocks = {
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

function MemAccessorGeneratorToBitset_SelectedPlayerProfileUnlocks(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_Bitset_SelectedPlayerProfileUnlocks =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:PlayerProfileUnlocks")
	return memAccessor_toByteInBitset(let_memAddr_Bitset_SelectedPlayerProfileUnlocks + int_offsetToByte)}

function MemAccessorGeneratorToBitset_PlayerProfileUnlocks(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_memAccessor = memGenerate_pointerChainAccessor(
			"Struct:SinglePlayerData", "Bitset:PlayerProfileUnlocks", let_memAddr_SinglePlayerData, 
			int_offsetToPointedToMember = int_offsetToByte, memAccessorType_toPointedToMember = memAccessor_toByteInBitset)
	return let_memAccessor}

// ----------------PlayerProfile BOUNTY HUNTER MODE--------------------
BOUNTY_HUNTER_MISSON_COUNT = 20
BitsetFlagData_BountyHunterMissionsCompleted = {
	1: [0,1,2,4,6,7],
	2: [1,3,6,7],
	3: [0,1,2,4,5,7],
	4: [0,4,5,7]}

function memAccessorGeneratorToBitset_BountyHunterMissionsCompleted(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_Bitset_BountyHunterMissionsCompleted =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:BountyHunterMissionsCompleted")
	return memAccessor_toByteInBitset(let_memAddr_Bitset_BountyHunterMissionsCompleted + int_offsetToByte)}

// -------------------------PlayerProfile CAMPAIGN SETTINGS-----------------------------
DIFFICULTY_Normal = 0x0
DIFFICULTY_Hard = 0x1
DIFFICULTY_VeryHard = 0x2
DIFFICULTY_RedWoodRevolver = 0x3

function current_StoryCampaignDifficulty(enum_releaseRegion) {
	let_memAddrPointerTo_ActivePlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_CampaignSetting = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "8-bit:CurrentDifficultyID") 
	return byte(dword(let_memAddrPointerTo_ActivePlayerProfileData) + let_offsetTo_CampaignSetting)}

function is_StoryCampaignDifficulty(enum_difficulty, enum_releaseRegion) =>
	current_StoryCampaignDifficulty(enum_releaseRegion) == enum_difficulty

function is_FurthestCompletedStoryChapter(enum_areaId, enum_releaseRegion) {
	let_offset = 1 // <-- because the first ASCII letter of this Area_ID may be zeroed out for this value (eg. "lvl_mansroof" => " vl_mansroof")
	let_memAddrPointerTo_ActivePlayerProfileData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_CampaignSetting = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "ASCII(AreaID):FurthestCompletedStoryChapter(alt1)") + let_offset  
	let_areaId_fixed = substring(enum_areaId, let_offset)
	return is_ASCII_EqualTo(dword(let_memAddrPointerTo_ActivePlayerProfileData) + let_offsetTo_CampaignSetting, let_areaId_fixed)}

// ................
// ◦ IN GAME MENU ◦
// ''''''''''''''''
// ------------------StartChpMenu---------------------
function current_FlagState_IsStartChpMenuActive(enum_releaseRegion) {
	let_memAddr_StartChpMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsStartChpMenuActive", 
		let_memAddr_StartChpMenuDisplayData, memAccessorType_toPointedToMember = bit0)}

function prev_FlagState_IsStartChpMenuActive(enum_releaseRegion) => 
	prev(current_FlagState_IsStartChpMenuActive(enum_releaseRegion))

function is_StartChpMenu_active(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return 
		current_FlagState_IsStartChpMenuActive(enum_releaseRegion) == 1}
	

function on_StartChpMenu_initialize(enum_releaseRegion) =>
	current_FlagState_IsStartChpMenuActive(enum_releaseRegion) > prev_FlagState_IsStartChpMenuActive(enum_releaseRegion)
// ------------------RewardMenu---------------------
function current_HighlightedRewardMenuItem(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_HighlightedMenuItem = memGenerate_pointerChainAccessor( // TODO this should not be a bit0 memAccessor but 8bit or perhaps lower4
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag_HighlightedMenuItem", 
		let_memAddr_RewardMenuDisplayData, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_HighlightedMenuItem}

function current_RewardMenu_Balance(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "32-bit:Balance", let_memAddr_RewardMenuDisplayData, 
		enum_releaseRegion, memAccessorType_toPointedToMember = dword)}

function current_RewardMenu_BountyCollected(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "32-bit:BountyCollected", let_memAddr_RewardMenuDisplayData, 
		enum_releaseRegion, memAccessorType_toPointedToMember = dword)}

function current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag_IsQuitConfirmationMenuDisplayed", 
		let_memAddr_RewardMenuDisplayData, memAccessorType_toPointedToMember = bit0)}

function current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsRewardMenuOrStartChpMenuDisplayed",
		let_memAddr_RewardMenuDisplayData, memAccessorType_toPointedToMember = bit0)}

function current_RewardMenu_MenuDepth(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_MenuDepth = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "8Bit:MenuDepth", let_memAddr_RewardMenuDisplayData,
		enum_releaseRegion, memAccessorType_toPointedToMember = byte)
	return let_memAccessor_MenuDepth}

function is_RewardMenu_MenuDepth(int_depth, enum_releaseRegion) =>
	current_RewardMenu_MenuDepth(enum_releaseRegion) == int_depth

function is_RewardMenu_displayed_long(enum_releaseRegion) => // This comparison is bigger than is_RewardMenu_displayed_short()
	current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion) == 1
	&& !is_StartChpMenu_active(enum_releaseRegion)

function is_RewardMenu_displayed_short(enum_releaseRegion) { // This comparison is shorter than is_RewardMenu_displayed_long() (prefer using this){
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_Pointer = memGenerate_pointerChainAccessor("Struct:RewardMenuAndStartChpMenuDisplayData", "Pointer:RewardMenuAndStartChpMenuDisplayData_L1-2d0", let_memAddr_RewardMenuDisplayData)
	return let_memAccessor_Pointer > 0}
	
function on_RewardMenu_render_long(enum_releaseRegion) {
	let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed = current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion)
	return 
		let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed > prev(let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed)
		// && !is_StartChpMenu_active(enum_releaseRegion) // <-- Unnecessary
		}

function on_RewardMenu_render_short(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_Pointer = memGenerate_pointerChainAccessor("Struct:RewardMenuAndStartChpMenuDisplayData", "Pointer:RewardMenuAndStartChpMenuDisplayData_L1-2d0", let_memAddr_RewardMenuDisplayData)
	return 
		let_memAccessor_Pointer > 0
		&& prev(let_memAccessor_Pointer) == 0}

function on_RewardMenu_close(enum_releaseRegion) {
	let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed = current_FlagState_IsRewardMenuOrStartChpMenuDisplayed(enum_releaseRegion)
	return 
		let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed < prev(let_memAccessor_IsRewardMenuOrStartChpMenuDisplayed)
		&& !is_StartChpMenu_active(enum_releaseRegion)}

function is_RatingBounty_achieved(enum_releaseRegion) {
	REWARDMENU_ITEMUNLOCK_UI_ELEMENT_ID_Locked = "locked"

	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_pointerChainTo_BountyRating_ItemUnlock_UI_Element_ID = 
		memGenerate_pointerChainAccessor_byReleaseRegion(
			"Struct:RewardMenuAndStartChpMenuDisplayData", "ASCII:ItemUnlockID-BountyRating", let_memAddr_RewardMenuDisplayData, 
			enum_releaseRegion)
	return is_ASCII_notEqualTo(let_pointerChainTo_BountyRating_ItemUnlock_UI_Element_ID, REWARDMENU_ITEMUNLOCK_UI_ELEMENT_ID_Locked)}

function is_RewardMenu_QuitConfirmMenu_displayed(enum_releaseRegion) => 
	current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) == 1
	&& is_RewardMenu_MenuDepth(0x2, enum_releaseRegion)
	|| is_RewardMenu_MenuDepth(0x3, enum_releaseRegion)

function is_RewardMenu_ReplayConfirmMenu_displayed(enum_releaseRegion) => 
	current_RewardMenu_QuitConfirmationMenuDisplayState(enum_releaseRegion) == 0
	&& 0x2 - 1 < current_RewardMenu_MenuDepth(enum_releaseRegion) 
	&& current_RewardMenu_MenuDepth(enum_releaseRegion) < 0x3 + 1

function on_RewardMenu_Replay_confirm(enum_releaseRegion) {
	const_YES = 0
	return 
		is_RewardMenu_displayed_short(enum_releaseRegion)
		&& is_RewardMenu_ReplayConfirmMenu_displayed(enum_releaseRegion) 
		&& current_HighlightedRewardMenuItem(enum_releaseRegion) == const_YES
		&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)}

function is_RewardMenu_Accuracy(string_accuracy, enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_PointerChainTo_Struct_RewardMenuDisplayText = memGenerate_pointerChainAccessor("Struct:RewardMenuAndStartChpMenuDisplayData", "ASCIIField:RewardMenuDisplayText", let_memAddr_RewardMenuDisplayData)
	let_offsetTo_Accuracy = memory_getStruct_OffsetToMember("ASCIIField:RewardMenuDisplayText", "ASCII:Accuracy")
	return is_ASCII_EqualTo(let_PointerChainTo_Struct_RewardMenuDisplayText + let_offsetTo_Accuracy, string_accuracy)}

function current_FlagState_IsAccuracyStarAchieved(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_IsStarAchieved = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsRatingObjectiveStarDisplayed-Accuracy", 
		let_memAddr_RewardMenuDisplayData, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsStarAchieved}

function current_FlagState_IsDamageTakenStarAchieved(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_IsStarAchieved = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsRatingObjectiveStarDisplayed-DamageTaken", 
		let_memAddr_RewardMenuDisplayData, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsStarAchieved}

function current_FlagState_IsTimeStarAchieved(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_IsStarAchieved = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsRatingObjectiveStarDisplayed-Time", 
		let_memAddr_RewardMenuDisplayData, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsStarAchieved}

function current_FlagState_IsBestComboStarAchieved(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_IsStarAchieved = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsRatingObjectiveStarDisplayed-BestCombo", 
		let_memAddr_RewardMenuDisplayData, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsStarAchieved}

function on_RewardMenu_FirstPopupMenu_render(enum_releaseRegion) {
	let_memAddr_RewardMenuDisplayData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)", enum_releaseRegion)
	let_memAccessor_IsFirstPopupMenuDisplayed = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:RewardMenuAndStartChpMenuDisplayData", "BitFlag:IsFirstPopupMenuDisplayed", 
		let_memAddr_RewardMenuDisplayData, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return 
		let_memAccessor_IsFirstPopupMenuDisplayed > prev(let_memAccessor_IsFirstPopupMenuDisplayed)}

// ------------------InGameMenu---------------------
INGAMEMENU_RetryMenu = "continue"
INGAMEMENU_GameOverScreen = "gameover"
INGAMEMENU_PauseMenu = "pause"
INGAMEMENU_CheatsMenu = "cheats"
INGAMEMENU_WarningMenu = "warning"

function current_FlagState_IsInPauseMenu(enum_releaseRegion) => 
	bit0(memory_getAddress(DATATYPE_BitFlag, "BitFlag:IsInPauseMenu", enum_releaseRegion))

function is_inPauseMenu(enum_releaseRegion) =>
	current_FlagState_IsInPauseMenu(enum_releaseRegion) == 1

function current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) =>
	bit0(
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion))
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "InvertedBitFlag:IsInGameMenuDisplayed"))

function prev_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) => 
	prev(current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion))

function current_HighlightedInGameMenuItem(enum_releaseRegion) =>
	byte(
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion))
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "8-bit:HighlightedMenuItemID"))

function is_InGameMenuID(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)}

function wasPrev_InGameMenuID(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4, transform = c => prev(c))}

function is_InGameMenu_displayed(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return 
		current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 1 
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)
	}

function is_InGameMenu_notDisplayed(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return __ornext(
		current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		|| !ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4))
	}

function on_InGameMenu_render(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return 
		current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 1	// <---Block--- Checks when an InGameMenu is rendered
		&& prev_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4)
		
		|| current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 1 // <---Block--- Checks when switching between InGameMenu's (eg. RetryMenu goes into GameOverScreen)
		&& ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4) // <-- check current ascii string
		&& !ascii_string_equals(let_memAddr_InGameMenuID, enum_inGameMenu, 4, transform = c => prev(c)) // <-- check delta ascii string
	}

function on_InGameMenu_close(enum_inGameMenu, enum_releaseRegion) {
	let_memAddr_InGameMenuID = 
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:InGameMenuController(preferred)", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:InGameMenuController", "ASCII:InGameMenuID")
	return
		current_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 0
		&& prev_FlagState_IsInGameMenuDisplayed(enum_releaseRegion) == 1
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

BitsetFlagData_ActivatedCheats = {
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

function MemAccessorGeneratorToBitset_SelectedPlayerProfile_ActivatedCheats(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
		dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
		+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	return memAccessor_toByteInBitset(let_memAddr_Bitset_ActivatedCheats + int_offsetToByte)}

function is_AnyCheat_active(enum_releaseRegion) {
	let_sumOf_AllCheatFlags = 
		memGenerate_SumOf_BitsetFlags_noSubSource(
			BitsetFlagData_ActivatedCheats["Flags_UnlockableCheats"],
			MemAccessorGeneratorToBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
		+ memGenerate_SumOf_BitsetFlags_noSubSource(
			BitsetFlagData_ActivatedCheats["Flags_DebugCheats"],
			MemAccessorGeneratorToBitset_SelectedPlayerProfile_ActivatedCheats,
			enum_releaseRegion)
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion) // <--line-- checks if cheats are active outside the PauseMenu as switching them on/off still requires a confirmation before leaving the CheatsMenu
		&& let_sumOf_AllCheatFlags > 0
	}

function is_SpecifiedCheat_active(enum_cheat, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
			+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	let_offsetToByte = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
	let_bitIndex = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
	let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte) == 1}

function is_SpecifiedCheat_inactive(enum_cheat, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
			+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	let_offsetToByte = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
	let_bitIndex = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
	let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte) == 0}

function is_AllSpecifiedCheats_active(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
			+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) == length(array_cheatEnums)}

function is_AnySpecifiedCheats_active(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
			+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) > 0}

function is_AnySpecifiedCheats_inactive(array_cheatEnums, enum_releaseRegion) {
	let_memAddr_Bitset_ActivatedCheats =
			dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)) 
			+ memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "Bitset:ActivatedCheats")
	let_array_memAccessors_toActivatedCheats = []
	for enum_cheat in array_cheatEnums {
		let_offsetToByte = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["ByteIndex"] - 1
		let_bitIndex = BitsetFlagData_ActivatedCheats["Flags_ByCheat"][enum_cheat]["BitIndex"]
		let_memAccessor_toBitFlag = memUtil_bitIndexToMemAccessor[let_bitIndex]
		array_push(let_array_memAccessors_toActivatedCheats, let_memAccessor_toBitFlag(let_memAddr_Bitset_ActivatedCheats + let_offsetToByte))
	}
	return 
		is_InGameMenu_notDisplayed(INGAMEMENU_CheatsMenu, enum_releaseRegion)
		&& sum_of(let_array_memAccessors_toActivatedCheats, memAccessor => memAccessor) < length(array_cheatEnums)}

// ------------------------RstarCheat------------------------------ 
function is_RStar_Cheat_active(enum_releaseRegion) {
	let_memAddr_ActivePlayerProfile = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_PlayerProfileName = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "ASCII:PlayerProfileName")
	let_memAddr_PlayerProfileName = dword(let_memAddr_ActivePlayerProfile) + let_offsetTo_PlayerProfileName

	/* is Rstar cheat active 
	----------------------- 
		& 0xDF any alphabetical ASCII character (+ space " ", same as 0x0)
			--> uppercase ASCII & 0xDF --> would result in uppercase value		eg. "R" & 0xDF -> 0x52 (="R")
			--> lowercase ASCII & 0xDF --> would result in uppercase value		eg. "r" & 0xDF -> 0x52 (="R")
	*/

	return 
		byte(let_memAddr_PlayerProfileName) & 0xdf == memUtil_asciiToHex["R"] // 0x52
		&& byte(let_memAddr_PlayerProfileName + 0x1) & 0xdf == memUtil_asciiToHex["S"] // 0x53
		&& byte(let_memAddr_PlayerProfileName + 0x2) & 0xdf == memUtil_asciiToHex["T"] // 0x54
		&& byte(let_memAddr_PlayerProfileName + 0x3) & 0xdf == memUtil_asciiToHex["A"] // 0x41
		&& byte(let_memAddr_PlayerProfileName + 0x4) & 0xdf == memUtil_asciiToHex["R"] // 0x52
		&& byte(let_memAddr_PlayerProfileName + 0x5) & 0xdf == 0x0  // 0x0 or 0x20 (0x20 = space = " ")
		&& byte(let_memAddr_PlayerProfileName + 0x6) & 0xdf == 0x0 // 0x0 or 0x20 (0x20 = space = " ")
	}
		
function is_RStar_Cheat_inActive(enum_releaseRegion) {
	let_memAddr_ActivePlayerProfile = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ActivePlayerProfile", enum_releaseRegion)
	let_offsetTo_PlayerProfileName = memory_getStruct_OffsetToMember("Struct:PlayerProfileData", "ASCII:PlayerProfileName")
	let_memAddr_PlayerProfileName = dword(let_memAddr_ActivePlayerProfile) + let_offsetTo_PlayerProfileName

	/* is Rstar cheat NOT active 
	----------------------- 
		& 0xDF any alphabetical ASCII character (+ space " ", same as 0x0)
			--> uppercase ASCII & 0xDF --> would result in uppercase value		eg. "R" & 0xDF -> 0x52 (="R")
			--> lowercase ASCII & 0xDF --> would result in uppercase value		eg. "r" & 0xDF -> 0x52 (="R")
	*/

	return __ornext( // --> force orNext, this is allowed/this works with other andNext logic, as these are single orNext requirements
		byte(let_memAddr_PlayerProfileName) & 0xdf != memUtil_asciiToHex["R"] // 0x52
		|| byte(let_memAddr_PlayerProfileName + 0x1) & 0xdf != memUtil_asciiToHex["S"] // 0x53
		|| byte(let_memAddr_PlayerProfileName + 0x2) & 0xdf != memUtil_asciiToHex["T"] // 0x54
		|| byte(let_memAddr_PlayerProfileName + 0x3) & 0xdf != memUtil_asciiToHex["A"] // 0x41
		|| byte(let_memAddr_PlayerProfileName + 0x4) & 0xdf != memUtil_asciiToHex["R"] // 0x52
		|| byte(let_memAddr_PlayerProfileName + 0x5) & 0xdf != 0x0  // 0x0 or 0x20 (0x20 = space = " ")
		|| byte(let_memAddr_PlayerProfileName + 0x6) & 0xdf != 0x0) // 0x0 or 0x20 (0x20 = space = " ")
	}

// ............................
// ◦ CHARACTER IDENTIFICATION ◦
// ''''''''''''''''''''''''''''
CHARACTER_GeneralDiego = "dgo"
CHARACTER_MrKelley = "mrk"
CHARACTER_JackSwift = "jck"
CHARACTER_WhiskeyTreadwell = "wsk"
CHARACTER_HedgehogThornton = "hdh" 
CHARACTER_AnnieStoakes = "ani"
CHARACTER_KatieGrady = "kti"
CHARACTER_UglyChris = "ugl"
CHARACTER_SmileyFawler = "aka"
CHARACTER_GigoloHancock = "ggl"
CHARACTER_ProfessorPerry = "pry"
CHARACTER_BladeSlade = "bwi"
CHARACTER_GabrialNavarro = "zzt"
CHARACTER_SheriffGrady = "cls"
CHARACTER_SheriffBartlett = "kng"
CHARACTER_HolsteinHal = "tcb"
CHARACTER_Sam = "tck"
CHARACTER_Cooper = "bkt"
CHARACTER_GovernorGriffon = "wyn"
CHARACTER_JasonCornet = "sev"
CHARACTER_BuffaloSoldier = "bfs"
CHARACTER_Smitty = "ncb"
CHARACTER_FallingStar = "mom" 
CHARACTER_Dan = "bdg"
CHARACTER_DigFowler = "gwk"
CHARACTER_MannyQuinn = "mok"
CHARACTER_Grizzly = "mst"
CHARACTER_StandingSnake = "msk"
CHARACTER_MrBlack = "blk"
CHARACTER_ShadowWolf = "ttk"
CHARACTER_BadBessie = "bty"
CHARACTER_PigJosh = "pgj"
CHARACTER_NateHarlow = "dad"
CHARACTER_ColonelDaren = "ydr"
CHARACTER_Natalie = "ntl"
CHARACTER_RedJr = "mrd"
CHARACTER_Fidgit = "mdg"
CHARACTER_Christina = "ctn"
CHARACTER_KidCougar = "elt"
CHARACTER_Red = "srd"
CHARACTER_CurlyShaw = "shp"
CHARACTER_BloodyTom = "gay"
CHARACTER_Chicken = "chk"
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
		"CharacterName": "StageCoach"}}
function get_CharacterName(enum_character) =>
	const_Character_data[enum_character]["CharacterName"]

function get_CharacterID_asHex(enum_character) =>
	memUtil_asciiStringToHex(enum_character)

// -----------------------MajorCharacterData------------------------------
function current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MajorCharacterData", enum_releaseRegion)
	let_string_pointerChainKey = format("Float:MajorCharacterHP-{0}", int_majorCharacterIndex)
	return memGenerate_pointerChainAccessor("Array:MajorCharacterData", let_string_pointerChainKey, let_memAddr_basePointer, memAccessorType_toPointedToMember = float)}

function prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) =>
	prev(current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion))

function current_MajorCharacterMaxHP(int_majorCharacterIndex, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MajorCharacterData", enum_releaseRegion)
	let_string_pointerChainKey = format("Float:MajorCharacterMaxHP-{0}", int_majorCharacterIndex)
	return memGenerate_pointerChainAccessor("Array:MajorCharacterData", let_string_pointerChainKey, let_memAddr_basePointer, memAccessorType_toPointedToMember = float)}

function on_MajorCharacterHP_decrement(int_majorCharacterIndex, enum_releaseRegion) => 
	current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) < prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion)

function on_MajorCharacterHP_zero(int_majorCharacterIndex, enum_releaseRegion) =>
	current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) == 0
	&& prev_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) > 0

function is_MajorCharacter_CharacterName(int_majorCharacterIndex, enum_character, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MajorCharacterData", enum_releaseRegion)
	let_string_pointerChainKey = format("ASCII:MajorCharacterName-{0}", int_majorCharacterIndex)
	let_offsetTo_CharacterName = memory_getStruct_OffsetToPointedToMember("Array:MajorCharacterData", let_string_pointerChainKey)
	let_memAddr_CharacterName = memGenerate_pointerChainAccessor("Array:MajorCharacterData", let_string_pointerChainKey, let_memAddr_basePointer)
	return is_ASCII_EqualTo(let_memAddr_CharacterName + let_offsetTo_CharacterName, get_CharacterName(enum_character))}

function current_Calculated_MajorCharacterHPPercentage(int_majorCharacterIndex, enum_releaseRegion) => 
	(current_MajorCharacterHP(int_majorCharacterIndex, enum_releaseRegion) / current_MajorCharacterMaxHP(int_majorCharacterIndex, enum_releaseRegion))


// ...................
// ◦ GAME CONTROLLER ◦
// '''''''''''''''''''
// ------------------------Cash_HUDController------------------------------
function current_Cash(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return 
		memGenerate_pointerChainAccessor(
			"Struct:GameController", "32-bit:Cash(functional)", let_memAddr_GameController, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToPointedToMember("Struct:GameController", "32-bit:Cash(functional)"),
			memAccessorType_toPointedToMember = dword)
	}

function current_CashAcquiredByOtherMeans(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return 
		memGenerate_pointerChainAccessor(
			"Struct:GameController", "32-bit:CashAcquiredByOtherMeans", let_memAddr_GameController, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToPointedToMember("Struct:GameController", "32-bit:CashAcquiredByOtherMeans"),
			memAccessorType_toPointedToMember = dword)
	}

function prev_CashAcquiredByOtherMeans(enum_releaseRegion) =>
	prev(current_CashAcquiredByOtherMeans(enum_releaseRegion))

function on_CashAcquiredByOtherMeans_increasesBy(int_i, enum_releaseRegion) =>
	current_CashAcquiredByOtherMeans(enum_releaseRegion) - prev_CashAcquiredByOtherMeans(enum_releaseRegion) == int_i

function current_CashCombo(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return 
		memGenerate_pointerChainAccessor(
			"Struct:GameController", "32-bit:Combo", let_memAddr_GameController, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToPointedToMember("Struct:GameController", "32-bit:Combo"),
			memAccessorType_toPointedToMember = dword)
	}

function current_CashComboMultiplier(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return 
		memGenerate_pointerChainAccessor(
			"Struct:GameController", "32-bit:ComboMultiplier", let_memAddr_GameController, 
			int_offsetToPointedToMember = memory_getStruct_OffsetToPointedToMember("Struct:GameController", "32-bit:ComboMultiplier"),
			memAccessorType_toPointedToMember = dword)
	}

function current_Calculated_CashDuringMission(enum_releaseRegion) => // WARNING - RATools cannot generate this sumOf correctly, thus achievements making use of this logic should be manually edited in
	current_Cash(enum_releaseRegion)
	// + (current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion)) >= const_CASH_TARGET // BUG_RATools - this line is supposed to be added to this AddSource chain, but RATools would replace this sumOf with an always_false()
	
	// Full SumOf would look like this [PAL]:
	// -------------------------------
	// AddAddress	Mem 32-bit 0x562a20
	// AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
	// AddAddress	Mem 32-bit 0x562a20
	// 			 	Mem 32-bit 0x587c	>= Val const_CASH_TARGET

function current_Calculated_CashAcquiredDuringMission(enum_releaseRegion) => // WARNING - RATools cannot generate this sumOf correctly, thus achievements making use of this logic should be manually edited in
	current_Cash(enum_releaseRegion)  // <-- Cash which updates during the mission
	- current_PlayerProfile_SavedCash(enum_releaseRegion) // <-- Cash which is only updated on save (on mission end)
	// + (current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion)) >= const_CASH_TARGET // BUG_RATools - this line is supposed to be added to this AddSource chain, but RATools would replace this sumOf with an always_false()
	/* MANUAL_CONSTRUCTION 
		current_Cash() - current_PlayerProfile_SavedCash()
		+ (current_CashCombo() * current_CashComboMultiplier())

		-> Logic (PAL)
			AddAddress	Mem 32-bit 0x7448d8
			SubSource 	Mem 32-bit 0x8
			AddAddress	Mem 32-bit 0x562a20
			AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
			AddAddress	Mem 32-bit 0x562a20
						Mem 32-bit 0x587c
	*/

function current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion) => /* MANUAL_CONSTRUCTION of sumOf
	-> General Logic
		( current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion)	)
		+ current_CashAcquiredByOtherMeans(enum_releaseRegion)
		+ current_Cash(enum_releaseRegion) 

	-> Logic (PAL)
		I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_A:0xX00005880_I:0xX00562a20_M:0xX0000587c

		AddAddress	Mem 32-bit 0x562a20
		AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
		AddAddress	Mem 32-bit 0x562a20	
		AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
		AddAddress	Mem 32-bit 0x562a20
		Measured	Mem 32-bit 0x587c							|current_Cash|

	-> Logic (NTSCU)
		I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_A:0xX00005880_I:0xX005602a0_M:0xX0000587c

		AddAddress	Mem 32-bit 0x5602a0
		AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888
		AddAddress	Mem 32-bit 0x5602a0
		AddSource 	Mem 32-bit 0x5880 
		AddAddress	Mem 32-bit 0x5602a0
		Measured	Mem 32-bit 0x587c
	*/
	current_CashCombo(enum_releaseRegion) 
	+ current_CashComboMultiplier(enum_releaseRegion)
	+ current_CashAcquiredByOtherMeans(enum_releaseRegion)
	+ current_Cash(enum_releaseRegion) 
		

function on_CashResetToSavedCash(enum_releaseRegion) =>
	current_Cash(enum_releaseRegion) - current_PlayerProfile_SavedCash(enum_releaseRegion) == 0

// ------------------------AmmoCounter_HUDController------------------------------
function is_AmmoHUDControllerReserveAmmo(int_ammoCount, enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	let_pointerChainto_EquippedWeaponReserveAmmo = memGenerate_pointerChainAccessor("Struct:GameController", "32-bit:EquippedWeaponReserveAmmo", let_memAddr_GameController)
	return let_memAccessor_EquippedWeaponReserveAmmo == int_ammoCount}
	
function on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion) {
	let_memAddr_GameController = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	let_memAccessor_EquippedWeaponReserveAmmo = memGenerate_pointerChainAccessor("Struct:GameController", "32-bit:EquippedWeaponReserveAmmo", let_memAddr_GameController)
	return let_memAccessor_EquippedWeaponReserveAmmo < prev(let_memAccessor_EquippedWeaponReserveAmmo)}

// ......................
// ◦ SINGLE PLAYER DATA ◦
// ''''''''''''''''''''''
const_array_MAX_HP_VALUES = [250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0] // 8 max hp values as there's 7 HP upgrades

function current_PlayerHP(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Float:PlayerHP", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = float)} 

function prev_PlayerHP(enum_releaseRegion) =>
	prev(current_PlayerHP(enum_releaseRegion))
	
function current_PlayerMaxHP(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Float:PlayerMaxHP", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = float)} 

function is_PlayerMaxHP(float_value, enum_releaseRegion) =>
	current_PlayerMaxHP(enum_releaseRegion) == float_value

function on_PlayerHP_heal(enum_releaseRegion) =>
	current_PlayerHP(enum_releaseRegion) > prev_PlayerHP(enum_releaseRegion)

function on_PlayerHP_zero(enum_releaseRegion) =>
	current_PlayerHP(enum_releaseRegion) <= 0
	&& prev_PlayerHP(enum_releaseRegion) > 0

function current_FlagState_IsPlayerRidingAnimal(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "BitFlag:IsRidingAnimal", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = bit0)}

function is_PlayerRidingAnimal(enum_releaseRegion) =>
	current_FlagState_IsPlayerRidingAnimal(enum_releaseRegion) == 1
// ------------------------WeaponManager------------------------------
WEAPON_Knife = 0x27
WEAPON_Faith = 0x2F
UNIVERSAL_WEAPON_STATE_Holstered = 0x0
UNIVERSAL_WEAPON_STATE_Aiming = 0x3
UNIVERSAL_WEAPON_STATE_Reloading = 0x4

function current_PlayerUniversalWeaponState(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Bitfield:UniversalWeaponState", let_memAddr_basePointer)}

function prev_PlayerUniversalWeaponState(enum_releaseRegion) => 
	prev(current_PlayerUniversalWeaponState(enum_releaseRegion))

function on_PlayerUniversalWeaponState_changeTo(enum_universalWeaponState, enum_releaseRegion) => 
	current_PlayerUniversalWeaponState(enum_releaseRegion) == enum_universalWeaponState 
	&& prev_PlayerUniversalWeaponState(enum_releaseRegion) != enum_universalWeaponState

function current_PlayerWeaponEquipped(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "8-bit:EquippedWeaponID", let_memAddr_basePointer)}

function is_PlayerWeapon_equipped(enum_weapon, enum_releaseRegion) =>
	current_PlayerWeaponEquipped(enum_releaseRegion) == enum_weapon

function current_FlagState_IsWeaponInInventory(enum_weapon, enum_releaseRegion) {
	let_array_AddAddressChainTo_IsWeaponInInventory = memory_getStuct_offsetSequenceToMember("Struct:WeaponData", "BitFlag:IsWeaponInInventory")
	let_offsetTo_WeaponData = (enum_weapon * memory_getStruct_SizeInBytes("Struct:WeaponData")) + let_array_AddAddressChainTo_IsWeaponInInventory[0]

	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	let_pointerChainTo_ArrayWeaponData = memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Array:WeaponData", let_memAddr_basePointer)
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
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:ShotsFired(functional)", let_memAddr_SinglePlayerData)}

function prev_ShotsFired(enum_releaseRegion) =>
	prev(current_ShotsFired(enum_releaseRegion))

function current_ShotsHit(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:ShotsHit(functional)", let_memAddr_SinglePlayerData)}

function prev_ShotsHit(enum_releaseRegion) =>
	prev(current_ShotsHit(enum_releaseRegion))

function current_Calculated_Accuracy(enum_releaseRegion) => // MANUAL_CONSTRUCTION necessary for RATools 1.14.1
	/* MANUAL_CONSTRUCTION: Remember + Recall
		remember(0.0 + current_ShotsFired(enum_releaseRegion)) // <-- to force float
		current_ShotsHit(enum_releaseRegion) / recall() 

		-> Logic [PAL]
			AddAddress	Mem		32-bit	0x763070
			AddAddress	Mem		32-bit	0x36c
			Remember	Float			0.0			+	Mem		32-bit	0x194
			AddAddress	Mem		32-bit	0x763070
			AddAddress	Mem		32-bit	0x36c
			Remember	Mem		32-bit	0x198		/ 	Recall
	*/
	current_ShotsFired(enum_releaseRegion) + current_ShotsHit(enum_releaseRegion)

function on_ShotsFired_increment(enum_releaseRegion) => 
	current_ShotsFired(enum_releaseRegion) > prev_ShotsFired(enum_releaseRegion)

function on_ShotsHit_increment(enum_releaseRegion) => 
	current_ShotsHit(enum_releaseRegion) > prev_ShotsHit(enum_releaseRegion)

function on_ShotsHit_change(enum_releaseRegion) =>
	current_ShotsHit(enum_releaseRegion) != prev_ShotsHit(enum_releaseRegion)

function current_DeathToll(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:DeathToll", let_memAddr_SinglePlayerData)}

function prev_DeathToll(enum_releaseRegion) =>
	prev(current_DeathToll(enum_releaseRegion))

function on_DeathToll_increment(enum_releaseRegion) => // WARNING This value does not count enemies killed which are riding animals
	current_DeathToll(enum_releaseRegion) > prev_DeathToll(enum_releaseRegion)

function current_DamageTaken(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Float:RawTotalDamageTaken", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = float)}

function current_Calculated_DamageTakenPercentage(enum_releaseRegion) =>  // MANUAL_CONSTRUCTION necessary for RATools 1.14.1
	/* MANUAL_CONSTRUCTION: Remember + Recall
		current_PlayerMaxHP(enum_releaseRegion) / current_DamageTaken(enum_releaseRegion)

		-> Logic (PAL)
			AddAddress	Mem		32-bit	0x00763070
			AddAddress	Mem		32-bit	0x18
			Remember	Mem		Float	0x14
			AddAddress	Mem		32-bit	0x00763070
			AddAddress	Mem		32-bit	0x36c
			Remember	Mem		Float	0x70		/	Recall
	*/
	current_PlayerMaxHP(enum_releaseRegion)
	+ current_DamageTaken(enum_releaseRegion)

function current_HeadShots(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:HeadShots(kills)", let_memAddr_SinglePlayerData)}

function prev_HeadShots(enum_releaseRegion) =>
	prev(current_HeadShots(enum_releaseRegion))

function on_HeadShots_increment(enum_releaseRegion) =>
	current_HeadShots(enum_releaseRegion) > prev_HeadShots(enum_releaseRegion)

function current_DeadEyeAbilitiesUsed(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:DeadeyeOrSpecialMoveUseCount", let_memAddr_SinglePlayerData)}

function prev_DeadEyeAbilitiesUsed(enum_releaseRegion) =>
	prev(current_DeadEyeAbilitiesUsed(enum_releaseRegion))

function on_DeadEyeAbilitiesUsed_increment(enum_releaseRegion) =>
	current_DeadEyeAbilitiesUsed(enum_releaseRegion) > prev_DeadEyeAbilitiesUsed(enum_releaseRegion)

function current_HighestCombo(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Float:HighestCombo", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = float)}

function current_HighestComboMultiplier(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:HighestComboMultiplier", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = dword)}

function current_HighestCombo_Showdown(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "Float:HighestCombo_Showdown", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = float)}

function current_HighestComboMultiplier_Showdown(enum_releaseRegion) {
	let_memAddr_SinglePlayerData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:SinglePlayerData(preferred)", enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:SinglePlayerData", "32-bit:HighestComboMultiplier_Showdown", let_memAddr_SinglePlayerData, memAccessorType_toPointedToMember = dword)}

// ..............
// ◦ ACTOR DATA ◦ // May be unsued code
// ''''''''''''''
function get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion) {
	let_memAddr_ActorDataArray = memory_getAddress(DATATYPE_Struct, "Array:ActorData", enum_releaseRegion)
	let_memAddr_ActorData0 = let_memAddr_ActorDataArray + (memory_getStruct_SizeInBytes("Struct:ActorData_0") * int_actorDataindex)
	return let_memAddr_ActorData0 + memory_getStruct_OffsetToMember("Struct:ActorData_0", "Struct:ActorData_B")}

// ------------------------HealthPoints------------------------------
function is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion) => // This checks if this index in the Array_ActorData is filled
	dword(get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)) > 0

function current_Actor_HP(int_actorDataindex, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	return memGenerate_pointerChainAccessor("Struct:ActorData_B", "Float:ActorHP", let_memAddr_ActorDataB)}

function prev_Actor_HP(int_actorDataindex, enum_releaseRegion) =>
	prev(current_Actor_HP(int_actorDataindex, enum_releaseRegion))

function on_Actor_HP_decrement(int_actorDataindex, enum_releaseRegion) =>
	current_Actor_HP(int_actorDataindex, enum_releaseRegion) < prev_Actor_HP(int_actorDataindex, enum_releaseRegion)

function on_Actor_HP_zero(int_actorDataindex, enum_releaseRegion) => 
	current_Actor_HP(int_actorDataindex, enum_releaseRegion) == 0
	&& prev_Actor_HP(int_actorDataindex, enum_releaseRegion) > 0

function is_Actor_CharacterModelId_equalTo(int_actorDataindex, enum_characterModelId, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	let_offsetTo_CharacterModelID = memory_getStruct_OffsetToPointedToMember("Struct:ActorData_B", "ASCII:CharacterModelID")
	let_memAddr_CharacterModelID = memGenerate_pointerChainAccessor(
		"Struct:ActorData_B", "ASCII:CharacterModelID", let_memAddr_ActorDataB)
	return is_ASCII_EqualTo(let_memAddr_CharacterModelID + let_offsetTo_CharacterModelID, enum_characterModelId)}

function is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, enum_characterModelId, enum_releaseRegion) {
	let_memAddr_ActorDataB = get_PointerAddr_ActorDataB(int_actorDataindex, enum_releaseRegion)
	let_offsetTo_CharacterModelID = memory_getStruct_OffsetToPointedToMember("Struct:ActorData_B", "ASCII:CharacterModelID")
	let_memAddr_CharacterModelID = memGenerate_pointerChainAccessor(
		"Struct:ActorData_B", "ASCII:CharacterModelID", let_memAddr_ActorDataB)
	return is_ASCII_notEqualTo(let_memAddr_CharacterModelID + let_offsetTo_CharacterModelID, enum_characterModelId)}

// .............
// ◦ CUTSCENES ◦
// '''''''''''''
// ------------------------Puppetshow------------------------------
PUPPETSHOW_BearMountain_PreBoss = "lvl_waterfall_pupshow_02"

function is_PuppetshowID(string_puppetshowId, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:PuppetshowManager", enum_releaseRegion)
	let_memAddr_PuppetshowId = dword(let_memAddr_basePointer) + memory_getStruct_OffsetToMember("Struct:PuppetshowManager", "ASCII:PuppetshowID")
	return is_ASCII_EqualTo(let_memAddr_PuppetshowId, string_puppetshowId)}

function wasPrev_PuppetshowID(string_puppetshowId, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:PuppetshowManager", enum_releaseRegion)
	let_memAddr_PuppetshowId = dword(let_memAddr_basePointer) + memory_getStruct_OffsetToMember("Struct:PuppetshowManager", "ASCII:PuppetshowID")
	return wasPrev_ASCII_EqualTo(let_memAddr_PuppetshowId, string_puppetshowId)}

function on_Puppetshow_start(string_puppetshowId, enum_releaseRegion) {
	let_memAccessor_PuppetshowManagerPointer = dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:PuppetshowManager", enum_releaseRegion))
	return 
		is_PuppetshowID(string_puppetshowId, enum_releaseRegion)
		&& let_memAccessor_PuppetshowManagerPointer > 0 // <-- When this pointer is functional, the puppetshow is active
		&& prev(let_memAccessor_PuppetshowManagerPointer) == 0}

function on_Puppetshow_end(string_puppetshowId, enum_releaseRegion) {
	let_memAccessor_PuppetshowManagerPointer = dword(memory_getAddress(DATATYPE_32BitPointer, "Pointer:PuppetshowManager", enum_releaseRegion))
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
	byte(memory_getAddress(DATATYPE_8Bit, "8-bit:NumberOfPlayers", enum_releaseRegion))

function get_GameMode_ID(enum_gameState) =>
	const_GameMode_data[enum_gameState]["ID"]

function current_GameMode(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "Bitfield:GameMode", enum_releaseRegion))

function prev_GameMode(enum_releaseRegion) => 
	prev(current_GameMode(enum_releaseRegion))

function is_GameMode(enum_gameState, enum_releaseRegion) => 
	current_GameMode(enum_releaseRegion) == get_GameMode_ID(enum_gameState)

function on_GameMode_changeTo(enum_gameState, enum_releaseRegion) => 
	current_GameMode(enum_releaseRegion) == get_GameMode_ID(enum_gameState) 
	&& prev_GameMode(enum_releaseRegion) != get_GameMode_ID(enum_gameState)

function on_QuitToMainMenu(enum_releaseRegion) => // Quiting game via pause menu
	on_GameMode_changeTo(GAMEMODE_MainMenu, enum_releaseRegion)

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
	bit0(memory_getAddress(DATATYPE_BitFlag, "BitFlag:IsPlayingBountyHunterMode", enum_releaseRegion)) == 1
	&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)

function is_Playing_BountyHunterMode_short(enum_releaseRegion) =>
	bit0(memory_getAddress(DATATYPE_BitFlag, "BitFlag:IsPlayingBountyHunterMode", enum_releaseRegion)) == 1
// ------------------------------------------------------
function on_EndingCreditsVideo_start(enum_releaseRegion) {
	cons_CREDITS_AUDIO_FILE_NAME = "ENDCREDITS_PS2.stm"
	let_memAddr_EndingCreditsFlag = memory_getAddress(DATATYPE_ASCII, "ASCIIFlag:IsEndingCreditsPlaying", enum_releaseRegion)
	return on_ASCII_changeTo(let_memAddr_EndingCreditsFlag, CREDITS_AUDIO_FILE_NAME)} 

// ------------------------------------------------------
function current_FlagState_IsInGame(enum_releaseRegion) =>
	float(memory_getAddress(DATATYPE_Float, "FloatFlag:IsInGame(preferred)", enum_releaseRegion))

function prev_FlagState_IsInGame(enum_releaseRegion) =>
	prev(current_FlagState_IsInGame(enum_releaseRegion))

function is_InGame(enum_releaseRegion) {
	const_FLOAT_FLAG_InGame = 1.0
	return 
		current_FlagState_IsInGame(enum_releaseRegion) == const_FLOAT_FLAG_InGame}

function on_InGame_start(enum_releaseRegion) {
	const_FLOAT_FLAG_InGame = 1.0
	const_FLOAT_FLAG_NotInGame = 0.0
	return 
		prev_FlagState_IsInGame(enum_releaseRegion) == const_FLOAT_FLAG_NotInGame
		&& current_FlagState_IsInGame(enum_releaseRegion) == const_FLOAT_FLAG_InGame}

// ......................
// ◦ EXTRA MISSION DATA ◦
// ''''''''''''''''''''''
const_ExtraMission_data = {
	AREA_Campaign_TheTraitor: [		
		"BitFlag:IsAlliedCannonDestroyed-A",
		"BitFlag:IsAlliedCannonDestroyed-B",
		"BitFlag:IsAlliedCannonDestroyed-C",
		"BitFlag:IsAlliedCannonDestroyed-D",
		"BitFlag:IsAlliedCannonDestroyed-E",
		"BitFlag:IsAlliedCannonDestroyed-F",
		"BitFlag:IsAlliedCannonDestroyed-G",
		"BitFlag:IsAlliedCannonDestroyed-H"],
	AREA_Campaign_RogueValley: [
		"BitFlag:IsTreasureOpened-A",
		"BitFlag:IsTreasureOpened-B",
		"BitFlag:IsTreasureOpened-C"]
	}

function on_RogueValley_Treasure_find(string_pointerChainKey, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ExtraMissionData", enum_releaseRegion)
	let_memAccessor_IsTreasureFound = memGenerate_pointerChainAccessor(
		"Struct:ExtraMissionData.RogueValley_Ch8", string_pointerChainKey, 
		let_memAddr_basePointer, memAccessorType_toPointedToMember = bit0)		
	return let_memAccessor_IsTreasureFound > prev(let_memAccessor_IsTreasureFound)}

function is_RogueValley_Treasure_opened(string_pointerChainKey, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ExtraMissionData", enum_releaseRegion)
	let_memAccessor_IsTreasureFound = memGenerate_pointerChainAccessor(
		"Struct:ExtraMissionData.RogueValley_Ch8", string_pointerChainKey, 
		let_memAddr_basePointer, memAccessorType_toPointedToMember = bit0)		
	return let_memAccessor_IsTreasureFound}

function current_Calculated_RogueValley_TreasuresOpenedCount(enum_releaseRegion) =>
	sum_of(const_ExtraMission_data[AREA_Campaign_RogueValley], string_pointerChainKey => 
		is_RogueValley_Treasure_opened(string_pointerChainKey, enum_releaseRegion))

function on_TheTraitor_AllyCannon_destroy(string_pointerChainKey, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ExtraMissionData", enum_releaseRegion)
	let_memAccessor_IsCannonDestroyed = memGenerate_pointerChainAccessor(
		"Struct:ExtraMissionData.TheTraitor_Ch13", string_pointerChainKey, 
		let_memAddr_basePointer, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsCannonDestroyed > prev(let_memAccessor_IsCannonDestroyed)}

function is_TheTraitor_AllyCannon_destroyed(string_pointerChainKey, enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:ExtraMissionData", enum_releaseRegion)
	let_memAccessor_IsCannonDestroyed = memGenerate_pointerChainAccessor(
		"Struct:ExtraMissionData.TheTraitor_Ch13", string_pointerChainKey, 
		let_memAddr_basePointer, memAccessorType_toPointedToMember = bit0)		
	return let_memAccessor_IsCannonDestroyed}

function current_Calculated_TheTraitor_AllyCannonsDestroyedCount(enum_releaseRegion) =>
	sum_of(const_ExtraMission_data[AREA_Campaign_TheTraitor], string_pointerChainKey => 
		is_TheTraitor_AllyCannon_destroyed(string_pointerChainKey, enum_releaseRegion))

// ..........
// ◦ TIMERS ◦
// ''''''''''
function current_TimeSpentInMission(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameplayTimers", enum_releaseRegion)
	let_offsetTo_TimeSpentInMission = memory_getStruct_OffsetToMember("Struct:GameplayTimers", "Float:TimeSpentInGame(functional)")
	return float(dword(let_memAddr_basePointer) + let_offsetTo_TimeSpentInMission)}

function prev_TimeSpentInMission(enum_releaseRegion) =>
	prev(current_TimeSpentInMission(enum_releaseRegion))

function current_CountDownTimer_TimeLeft(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameplayTimers", enum_releaseRegion) 
	let_offsetTo_CountDownTimer = memory_getStruct_OffsetToMember("Struct:GameplayTimers", "Float:CountdownTimer(functional)")
	return float(dword(let_memAddr_basePointer) + let_offsetTo_CountDownTimer)}

// ............
// ◦ SHOWDOWN ◦
// ''''''''''''
SHOWDOWN_TEAM_RED = 0
SHOWDOWN_TEAM_WHITE = 1
SHOWDOWN_TEAM_BLUE = 2
SHOWDOWN_TEAM_YELLOW = 3

// --------------------Showdown_PosterMenu_Controller------------------------ 
function is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	let_memAccessor_Pointer = memGenerate_pointerChainAccessor(
		"Struct:GameController", "Pointer:ShowdownPosterMenuController", let_memAddr_basePointer, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_Pointer != 0}

function current_FlagState_IsShowdownPosterMenuDisplayed(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:GameController", "BitFlag:IsShowdownPosterMenuDisplayed", let_memAddr_basePointer, memAccessorType_toPointedToMember = byte)}

function is_ShowdownPosterMenu_displayed(enum_releaseRegion) =>
	current_FlagState_IsShowdownPosterMenuDisplayed(enum_releaseRegion) == 1

function current_FlagState_PosterMenu_IsShowdownPlayerSlotFilled(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	let_string_pointerChainKey = format("BitFlag:IsShowdownPlayerSlotFilled-{0}", int_playerIndex)
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	return memGenerate_pointerChainAccessor(
		"Struct:GameController", let_string_pointerChainKey, let_memAddr_basePointer, memAccessorType_toPointedToMember = bit0)}

function is_PosterMenu_ShowdownPlayerSlot_filled(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_FlagState_PosterMenu_IsShowdownPlayerSlotFilled(int_playerIndex, enum_releaseRegion) == 1

function is_PosterMenu_ShowdownPlayerCharacter(int_playerIndex, enum_character, enum_releaseRegion) { // Player Index [1-4]
	let_string_pointerChainKey = format("ASCII:CharacterModelID-{0}", int_playerIndex)
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	let_PointerChain_ShowdownPlayerCharacterModelId = memGenerate_pointerChainAccessor(
		"Struct:GameController", let_string_pointerChainKey, let_memAddr_basePointer)
	let_offsetTo_ShowdownPlayerCharacterModelId = memory_getStruct_OffsetToPointedToMember("Struct:GameController", let_string_pointerChainKey)
	return is_ASCII_EqualTo(let_PointerChain_ShowdownPlayerCharacterModelId + let_offsetTo_ShowdownPlayerCharacterModelId, enum_character)}

function current_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	let_string_pointerChainKey = format("8-bit:ShowdownPlayerTeamID-{0}", int_playerIndex)
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GameController", enum_releaseRegion)
	let_memAccessor_ShowdownPlayerTeamId = memGenerate_pointerChainAccessor(
		"Struct:GameController", let_string_pointerChainKey, let_memAddr_basePointer, 
		memAccessorType_toPointedToMember = byte)
	return let_memAccessor_ShowdownPlayerTeamId}

function prev_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	prev(current_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion))

function is_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_showdownTeam, enum_releaseRegion) => // Player Index [1-4]
	current_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) == enum_showdownTeam

function on_PosterMenu_ShowdownPlayer_Team_change(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) != prev_PosterMenu_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion)

function is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion) {
	let_Player1_Index = 1
	let_Player2_Index = 2
	let_Player3_Index = 3
	let_Player4_Index = 4

	return // Checks if all players have no teammates
		current_PosterMenu_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion)
		&& current_PosterMenu_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion)
		&& current_PosterMenu_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)

		&& current_PosterMenu_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion)
		&& current_PosterMenu_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)

		&& current_PosterMenu_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)}

function current_PosterMenu_SelectedShowdownStageId(enum_releaseRegion) =>
	dword(memory_getAddress(DATATYPE_32Bit, "32-bit:SelectedPosterMenuShowdownStageID", enum_releaseRegion))

function is_PosterMenu_ShowdownStage(enum_areaId, enum_releaseRegion) =>
	current_PosterMenu_SelectedShowdownStageId(enum_releaseRegion) == get_AreaShowdown_PosterMenuStageId(enum_areaId) 

// --------------------ShowdownPlayer_Settings------------------------
SHOWDOWN_AI_SETTING_HumanPlayer = "MPplayer"
SHOWDOWN_AI_SETTING_PixieBot = "pixiebot"

function ASCIIaddress_ShowdownPlayerCharacterId(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1	
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerSettings_B", enum_releaseRegion)
	let_memAddr_CharacterModelID = 
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerSettings_B"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerSettings_B", "ASCII:CharacterModelID")
	return let_memAddr_CharacterModelID}

function is_ShowdownPlayerCharacter(int_playerIndex, enum_character, enum_releaseRegion) { // Player Index [1-4]
	let_memAddr_CharacterModelID = ASCIIaddress_ShowdownPlayerCharacterId(int_playerIndex, enum_releaseRegion)
	return is_ASCII_EqualTo(let_memAddr_CharacterModelID, enum_character)}

function ASCIIaddress_ShowdownPlayer_AIsetting(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1	
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerSettings_B", enum_releaseRegion)
	let_memAddr_ShowdownAIsetting = 
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerSettings_B"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerSettings_B", "ASCII:ShowdownAISetting")
	return let_memAddr_ShowdownAIsetting}

function is_ShowdownPlayer_Human(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	let_memAddr_ShowdownAIsetting = ASCIIaddress_ShowdownPlayer_AIsetting(int_playerIndex, enum_releaseRegion)
	return is_ASCII_EqualTo(let_memAddr_ShowdownAIsetting, SHOWDOWN_AI_SETTING_HumanPlayer)}

function is_ShowdownPlayer_CPU(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	let_memAddr_ShowdownAIsetting = ASCIIaddress_ShowdownPlayer_AIsetting(int_playerIndex, enum_releaseRegion)
	return is_ASCII_notEqualTo(let_memAddr_ShowdownAIsetting, SHOWDOWN_AI_SETTING_HumanPlayer)}

function current_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_ShowdownPlayerSettingsArray = memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerSettings_B", enum_releaseRegion)
	let_memAddr_TeamId =
		let_memAddr_ShowdownPlayerSettingsArray 
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerSettings_B"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerSettings_B", "Lower4:TeamID")
	return low4(let_memAddr_TeamId)}

function prev_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	prev(current_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion))

function is_ShowdownPlayer_Team(int_playerIndex, enum_showdownTeam, enum_releaseRegion) => // Player Index [1-4]
	 current_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) == enum_showdownTeam

function is_ShowdownTeams_FreeForAll(enum_releaseRegion) {
	let_Player1_Index = 1
	let_Player2_Index = 2
	let_Player3_Index = 3
	let_Player4_Index = 4

	return // Checks if all players have no teammates
		current_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion)
		&& current_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion)
		&& current_ShowdownPlayer_Team(let_Player1_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)

		&& current_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion)
		&& current_ShowdownPlayer_Team(let_Player2_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)

		&& current_ShowdownPlayer_Team(let_Player3_Index, enum_releaseRegion) != current_ShowdownPlayer_Team(let_Player4_Index, enum_releaseRegion)}


function on_ShowdownPlayer_Team_change(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	 current_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) != prev_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion)

// --------------------ShowdownPlayer Logic------------------------
function current_ShowdownPlayer_HP(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataC = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_C")
	
	let_memAccessor_HP = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_C", "Float:PlayerHP", 
		let_memAddr_basePointer_ShowdownPlayerDataC, memAccessorType_toPointedToMember = float)
	return let_memAccessor_HP}

function prev_ShowdownPlayer_HP(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	prev(current_ShowdownPlayer_HP(int_playerIndex, enum_releaseRegion))

function on_ShowdownPlayer_HP_zero(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_HP(int_playerIndex, enum_releaseRegion) <= 0
	&& prev_ShowdownPlayer_HP(int_playerIndex, enum_releaseRegion) > 0

function current_ShowdownPlayer_MaxHP(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataC = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_C")
	
	let_memAccessor_MaxHP = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_C", "Float:PlayerMaxHP", 
		let_memAddr_basePointer_ShowdownPlayerDataC, memAccessorType_toPointedToMember = float)
	return let_memAccessor_MaxHP}


function current_ShowdownPlayer_CashCollected(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_CashCollected = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:CashCollected", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_CashCollected}

function current_ShowdownPlayer_HighNoonRoundsWon(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_HighNoonRoundsWon = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:HighNoonRoundsWon", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_HighNoonRoundsWon}

function current_ShowdownPlayer_DeathToll(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_DeathToll = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:DeathToll", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_DeathToll}

function prev_ShowdownPlayer_DeathToll(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	prev(current_ShowdownPlayer_DeathToll(int_playerIndex, enum_releaseRegion))

function on_ShowdownPlayer_DeathToll_increment(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_DeathToll(int_playerIndex, enum_releaseRegion) > prev_ShowdownPlayer_DeathToll(int_playerIndex, enum_releaseRegion)

function current_ShowdownPlayer_HeadShots(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_HeadShots = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:HeadShots", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_HeadShots}

function current_ShowdownPlayer_DamageTaken(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_DamageTaken = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "Float:RawTotalDamageTaken", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = float)
	return let_memAccessor_DamageTaken}

function prev_ShowdownPlayer_DamageTaken(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	prev(current_ShowdownPlayer_DamageTaken(int_playerIndex, enum_releaseRegion))

function current_Calculated_ShowdownPlayer_DamageTakenPercentage(int_playerIndex, enum_releaseRegion) => /* MANUAL_CONSTRUCTION - usage of R/R
	-> Psuedo Logic
		Remember	current_ShowdownPlayer_MaxHP()
					current_ShowdownPlayer_DamageTaken()	/	Recall
	*/

	current_ShowdownPlayer_MaxHP(int_playerIndex, enum_releaseRegion) 
	+ current_ShowdownPlayer_DamageTaken(int_playerIndex, enum_releaseRegion)

function current_ShowdownPlayer_Weapon_equipped(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataB = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_EquippedWeaponId = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "8-bit:EquippedWeaponID", 
		let_memAddr_basePointer_ShowdownPlayerDataB, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_EquippedWeaponId}

function is_ShowdownPlayer_Weapon_equipped(int_playerIndex, enum_weapon, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_Weapon_equipped(int_playerIndex, enum_releaseRegion) == enum_weapon

function current_ShowdownPlayer_ShotsFired(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataC = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_ShotsFired = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:ShotsFired(functional)", 
		let_memAddr_basePointer_ShowdownPlayerDataC, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_ShotsFired}

function current_ShowdownPlayer_ShotsHit(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))

	let_playerIndex = int_playerIndex - 1
	let_memAddr_basePointer_ShowdownPlayerDataC = 	
		memory_getAddress(DATATYPE_Struct, "Array:ShowdownPlayerData", enum_releaseRegion)
		+ (let_playerIndex * memory_getStruct_SizeInBytes("Struct:ShowdownPlayerData_0"))
		+ memory_getStruct_OffsetToMember("Struct:ShowdownPlayerData_0", "Struct:ShowdownPlayerData_B")
	
	let_memAccessor_ShotsHit = memGenerate_pointerChainAccessor(
		"Struct:ShowdownPlayerData_B", "32-bit:ShotsHit(functional)", 
		let_memAddr_basePointer_ShowdownPlayerDataC, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_ShotsHit}	

function current_Calculated_ShowdownPlayer_Accuracy(int_playerIndex, enum_releaseRegion) => /* Player Index [1-4]  // MANUAL_CONSTRUCTION with R/R
	-> Peusdo Logic
		Remember	Float 0.0 + current_ShowdownPlayer_ShotsFired() 	--> Force float
					current_ShowdownPlayer_ShotsHit() / Recall
		*/
	current_ShowdownPlayer_ShotsFired(int_playerIndex, enum_releaseRegion)
	+ current_ShowdownPlayer_ShotsHit(int_playerIndex, enum_releaseRegion) 



// --------------------ShowdownMode_Settings------------------------
SHOWDOWN_MODE_BountyHunter = 0 
SHOWDOWN_MODE_Sundown = 1 
SHOWDOWN_MODE_HighNoon = 2 

function current_Showdown_Mode(enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "Struct:ShowdownModeSettings", enum_releaseRegion)
	let_offsetTo_Member = memory_getStruct_OffsetToMember("Struct:ShowdownModeSettings", "Lower4:GameMode")
	return low4(let_memAddr_Struct + let_offsetTo_Member)}

function is_Showdown_Mode(enum_showdownMode, enum_releaseRegion) =>
	current_Showdown_Mode(enum_releaseRegion) == enum_showdownMode

SHOWDOWN_BOUNTY_LIMIT_3K = 0 
SHOWDOWN_BOUNTY_LIMIT_5K = 1 
SHOWDOWN_BOUNTY_LIMIT_10K = 2 
SHOWDOWN_BOUNTY_LIMIT_15K = 3
SHOWDOWN_BOUNTY_LIMIT_20K = 4 
function current_Showdown_BountyLimit(enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "Struct:ShowdownModeSettings", enum_releaseRegion)
	let_offsetTo_Member = memory_getStruct_OffsetToMember("Struct:ShowdownModeSettings", "Lower4:BountyHunterModeBountyLimitSetting")
	return low4(let_memAddr_Struct + let_offsetTo_Member)}

function is_Showdown_BountyLimit(enum_showdownBountyLimit, enum_releaseRegion) =>
	current_Showdown_BountyLimit(enum_releaseRegion) == enum_showdownBountyLimit

SHOWDOWN_SUNDOWN_FIGHT_TIME_3min = 0 
SHOWDOWN_SUNDOWN_FIGHT_TIME_5min = 1 
SHOWDOWN_SUNDOWN_FIGHT_TIME_10min = 2 
SHOWDOWN_SUNDOWN_FIGHT_TIME_15min = 3 
SHOWDOWN_SUNDOWN_FIGHT_TIME_1min = 4 
function is_Showdown_SundownFightTime(enum_sundownFightTime, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "Struct:ShowdownModeSettings", enum_releaseRegion)
	let_offsetTo_Member = memory_getStruct_OffsetToMember("Struct:ShowdownModeSettings", "Lower4:SundownModeFightTimeSetting")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_sundownFightTime}

SHOWDOWN_HIGH_NOON_REQUIRED_WINS_3 = 0
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5 = 1
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_7 = 2
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_10 = 3
SHOWDOWN_HIGH_NOON_REQUIRED_WINS_1 = 4
function current_Showdown_HighNoonRequiredWins(enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "Struct:ShowdownModeSettings", enum_releaseRegion)
	let_offsetTo_Member = memory_getStruct_OffsetToMember("Struct:ShowdownModeSettings", "Lower4:HighNoonModeNumberofWinsSetting")
	return low4(let_memAddr_Struct + let_offsetTo_Member)}

function is_Showdown_HighNoonRequiredWins(enum_highNoonRequiredWins, enum_releaseRegion) =>
	current_Showdown_HighNoonRequiredWins(enum_releaseRegion) == enum_highNoonRequiredWins

SHOWDOWN_POWER_UPS_SETTING_Off = 0
SHOWDOWN_POWER_UPS_SETTING_Stud = 1
SHOWDOWN_POWER_UPS_SETTING_HoldEm = 2 
function is_Showdown_PowerUpSetting(enum_powerUpsSetting, enum_releaseRegion) {
	let_memAddr_Struct = memory_getAddress(DATATYPE_Struct, "Struct:ShowdownModeSettings", enum_releaseRegion)
	let_offsetTo_Member = memory_getStruct_OffsetToMember("Struct:ShowdownModeSettings", "Lower4:PowersUpsSetting")
	return low4(let_memAddr_Struct + let_offsetTo_Member) == enum_powerUpsSetting}

// --------------------MultiplayerRewardMenu------------------------
ASCII_FLAG_IsMultiplayerRewardMenuDisplayed = "mpReward" // "mpRewards_new3"
ASCII_FLAG_IsPlayerWinner = "Winn" // "Winner"
ASCII_FLAG_IsPlayerNotWinner = "okLa" // "okLable"

function is_ShowdownPlayer_Winner(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))	
	
	let_string_pointerChainKey = format("ASCIIFlag(IsWinner):Player-{0}", int_playerIndex)
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_pointerChainTo_ASCII = memGenerate_pointerChainAccessor(
		"Struct:MultiplayerRewardMenuData", let_string_pointerChainKey, let_memAddr_basePointer, memAccessorType_toPointedToMember = dword)
	let_offsetTo_ASCII = memory_getStruct_OffsetToPointedToMember_byReleaseRegion("Struct:MultiplayerRewardMenuData", let_string_pointerChainKey, enum_releaseRegion)
	return is_ASCII_EqualTo(let_pointerChainTo_ASCII + let_offsetTo_ASCII, ASCII_FLAG_IsPlayerWinner)}

function is_ShowdownPlayer_NotWinner(int_playerIndex, enum_releaseRegion) { // Player Index [1-4]
	const_OFFSET_TO_FLAG_NotWinner = 0x1

	if(int_playerIndex < 1 || 4 < int_playerIndex)
		util_throwError(format("Player index: {0} is not in valid range"))	
	
	let_string_pointerChainKey = format("ASCIIFlag(IsWinner):Player-{0}", int_playerIndex)
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_pointerChainTo_ASCII = memGenerate_pointerChainAccessor(
		"Struct:MultiplayerRewardMenuData", let_string_pointerChainKey, let_memAddr_basePointer, memAccessorType_toPointedToMember = dword)
	let_offsetTo_ASCII = memory_getStruct_OffsetToPointedToMember_byReleaseRegion("Struct:MultiplayerRewardMenuData", let_string_pointerChainKey, enum_releaseRegion)
	return is_ASCII_EqualTo(
		let_pointerChainTo_ASCII + let_offsetTo_ASCII + const_OFFSET_TO_FLAG_NotWinner, 
		ASCII_FLAG_IsPlayerNotWinner)}

function ASCIIaddress_IsMultiplayerRewardMenuDisplayed(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_pointerChainTo_ASCII = memGenerate_pointerChainAccessor(
		"Struct:MultiplayerRewardMenuData", "ASCIIFlag:IsMultiplayerRewardMenuDisplayed", let_memAddr_basePointer)
	let_offsetTo_ASCII = memory_getStruct_OffsetToPointedToMember("Struct:MultiplayerRewardMenuData", "ASCIIFlag:IsMultiplayerRewardMenuDisplayed")
	return let_pointerChainTo_ASCII + let_offsetTo_ASCII}

function is_MultiplayerRewardMenu_displayed(enum_releaseRegion) {
	let_memAddr_ASCII = ASCIIaddress_IsMultiplayerRewardMenuDisplayed(enum_releaseRegion)
	return is_ASCII_EqualTo(let_memAddr_ASCII, ASCII_FLAG_IsMultiplayerRewardMenuDisplayed)}

function is_MultiplayerRewardMenu_notDisplayed(enum_releaseRegion) {
	let_memAddr_ASCII = ASCIIaddress_IsMultiplayerRewardMenuDisplayed(enum_releaseRegion)
	return is_ASCII_notEqualTo(let_memAddr_ASCII, ASCII_FLAG_IsMultiplayerRewardMenuDisplayed)}

function on_MultiplayerRewardMenu_render(enum_releaseRegion) {
	let_memAddr_ASCII = ASCIIaddress_IsMultiplayerRewardMenuDisplayed(enum_releaseRegion)
	return 
		on_ASCII_changeTo(let_memAddr_ASCII, ASCII_FLAG_IsMultiplayerRewardMenuDisplayed)}

function is_MultiplayerRewardMenu_FirstPopupMenu_displayed(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_memAccessor_IsFirstPopupMenuDisplayed = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:MultiplayerRewardMenuData", "BitFlag:IsPopupMenuDisplayed", let_memAddr_basePointer, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsFirstPopupMenuDisplayed == 1}

function on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion) {
	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_memAccessor_IsFirstPopupMenuDisplayed = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:MultiplayerRewardMenuData", "BitFlag:IsPopupMenuDisplayed", let_memAddr_basePointer, enum_releaseRegion, memAccessorType_toPointedToMember = bit0)
	return let_memAccessor_IsFirstPopupMenuDisplayed > prev(let_memAccessor_IsFirstPopupMenuDisplayed)}

function is_MultiplayerRewardPopupMenu_Replay_Highlighted(enum_releaseRegion) {
	const_MENU_ITEM_Replay = 0

	let_memAddr_basePointer = memory_getAddress(DATATYPE_32BitPointer, "Pointer:MultiplayerRewardMenuData(preferred)", enum_releaseRegion)
	let_memAccessor_HighlightedMenuItem = memGenerate_pointerChainAccessor_byReleaseRegion(
		"Struct:MultiplayerRewardMenuData", "32-bit:HighlightedPopupMenuItem", let_memAddr_basePointer, 
		enum_releaseRegion, memAccessorType_toPointedToMember = dword)
	return let_memAccessor_HighlightedMenuItem == const_MENU_ITEM_Replay}

function on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion) =>
	is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
	&& is_MultiplayerRewardMenu_FirstPopupMenu_displayed(enum_releaseRegion)
	&& is_MultiplayerRewardPopupMenu_Replay_Highlighted(enum_releaseRegion)
	&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)

function on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion) => 
	is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
	&& is_MultiplayerRewardMenu_FirstPopupMenu_displayed(enum_releaseRegion)
	&& on_PlayerInput_ConfirmBtn_press(enum_releaseRegion)


// .........
// ◦ OTHER ◦
// '''''''''
// --------------------GatlingGunZone------------------------
function is_PointerTo_GatlingGunZoneData_valid(enum_releaseRegion) {
	const_INTERACTABLE_ZONE_ID = "zone_gunA_01"
	let_memAddr_GatlingGunZoneData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GatlingGunZoneData", enum_releaseRegion)
	let_pointerChainTo_InteractableZoneID = 
		dword(let_memAddr_GatlingGunZoneData)
		+ memory_getStruct_OffsetToMember("Struct:InteractableZone.GatlingGun", "ASCII:InteractableZoneID")
	return is_ASCII_EqualTo(let_pointerChainTo_InteractableZoneID, const_INTERACTABLE_ZONE_ID)}

function current_FlagState_IsGatlingGunManned(enum_releaseRegion) {
	let_memAddr_GatlingGunZoneData = memory_getAddress(DATATYPE_32BitPointer, "Pointer:GatlingGunZoneData", enum_releaseRegion)
	return bit0(
		dword(let_memAddr_GatlingGunZoneData)
		+ memory_getStruct_OffsetToMember("Struct:InteractableZone.GatlingGun", "BitFlag:IsGatlingGunManned")
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
	let_memAddr_UndefinedStruct = memory_getAddress(DATATYPE_32BitPointer, "Pointer:UndefinedStruct_03(preferred)", enum_releaseRegion)
	let_PointerChainTo_MissionKillcount = 
		dword(let_memAddr_UndefinedStruct)
		+ memory_getStruct_OffsetToMember("Struct:Undefined_03", "32-bit:MissionKillcount")
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
	
	"c_Story": { // Category - Story Progression (20)
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
			"id": 447273, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 15"},
		"a_CompleteChapter17": { // VERIFIED
			"id": 447274, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 17"},
		"a_CompleteChapter19": { // VERIFIED
			"id": 447275, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 19"},
		"a_CompleteChapter20": { // VERIFIED
			"id": 447276, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 20"},
		"a_CompleteChapter22": { // VERIFIED
			"id": 447277, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 22"},
		"a_CompleteChapter24": { // VERIFIED
			"id": 447278, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 24"},
		"a_CompleteChapter25": { // VERIFIED
			"id": 443871, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Progression,
			"devInfo": "Complete Chapter 25"},
		"a_CompleteChapter27": { // VERIFIED
			"id": 443703, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_WinCondition,
			"devInfo": "Complete Chapter 27"},
		},
	"c_Showdown": { // Category - Showdown related achievements (12)
		"a_BountyHunterKatie": { // VERIFIED
			"id": 454648, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "As Katie O'Grady (P1), with Sheriff O'Grady (P2) as your ally win a 10k target Bounty Hunter match against a team of Ugly Chris (P3) and Professor Perry (P4) in Widow's Patch"},
		"a_BountyHunterBlade": { // VERIFIED
			"id": 455158, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "As The Blade Slade (P1), win a free-for-all 10k target Bounty Hunter match against Sissy Fess (P2), Rico Pedrosa (P3) and Udo Kang (P4) in Sunset Canyon, using only knives"},
		"a_BountyHunterAnnie": { // VERIFIED
			"id": 455172, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "As Annie Stoakes (P1), win a 10k target Bounty Hunter match against a team of Governor Griffon (P2), Holstein Hal (P3) and Sam (P4) on The Ranch"},
		// "a_BountyHunterCooper": { // VERIFIED // DISABLED - Manual construction via RAIntegration - usage of Remember/Recall
			// "id": 455173, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "As Cooper (P1), win a 10k target Bounty Hunter match against a team of Jason Cornet (P2), Sheriff Bartlett (P3) and Buffalo Soldier (P4) on Fairground, with damage taken less than 888%"},
		"a_BountyHunterWeapons": { // VERIFIED
			"id": 455443, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "Win a 4 player free-for-all Bounty Hunter match by killing opponents with 7 different weapons"},
		"a_SundownFallingStar": { // VERIFIED
			"id": 455174, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "As Falling Star (P1), with Shadow Wolf (P2) as your ally, win a 5 minute Sundown match against a team of Grizzly (P3) and Standing Snake (P4) in Fallen Creek"},
		"a_SundownBlack": { // VERIFIED
			"id": 455175, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "As Mr. Black (P1), win a 5 minute free-for-all Sundown match against Bad Bessie (P2), Ugly Chris (P3) and Pig Josh (P4) in Ghost Town, with a kill streak of at least 15"},
		// "a_SundownGriffon": { // VERIFIED // DISABLED - Manual construction via RAIntegration - complex sumation/AddSource chain
			// "id": 455176, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			// "devInfo": "As Governor Griffon (P1), win a 5 minute Sundown match against a team of Nate Harlow (P2), Falling Star (P3) and Red (P4) in Broken Creek, AND collect $15,000"},
		// "a_SundownNate": { // VERIFIED // DISABLED - Manual construction via RAIntegration - usage of Remember/Recall
			// "id": 455178, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "As Nate Harlow (P1), win a 5 minute Sundown match against a team of Governor Griffon (P2), Colonel Daren (P3) and General Diego (P4) in The Mansion, with an accuracy rating of 70% or higher, AND collect $12,000"},
		"a_SundownFlawless": { // VERIFIED
			"id": 455444, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "1 min Sundown match vs team of 3 CPUs, without dying and kill every enemy once"},
		"a_HighNoonNatalie": { // VERIFIED
			"id": 455179, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Standard,
			"devInfo": "As Natalie (P1), complete a first to 5, free-for-all High Noon match against Mr. Kelley (P2), Red Jr. (P3) and Nate Harlow (P4) on Mansion Grounds + achieve 3 kills + either Natalie or Mr. Kelley wins the match"},
		"a_HighNoonCurly": { // VERIFIED
			"id": 455180, "points": achievement_POINTS_Intermediate, "type": achievements_TYPE_Standard,
			"devInfo": "As Curly Shaw (P1), win a best of 5, free-for-all High Noon match against Bloody Tom (P2), Big Oaf Whitney (P3) and Twiggy Phelps (P4) in Twin Rocks + score 5 headshots"},		
		},
	"c_Unlocks": { // Category - Unlocking items (9)
		"a_UnlockStagesAll": { // VERIFIED
			"id": 444065, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
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
			"id": 444489, "points": achievement_POINTS_VeryHard, "type": achievements_TYPE_Standard,
			"devInfo": "Complete 100% of the journal"},
		"a_MaxHealth": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 444063, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 7 health upgrades for Red"},
		"a_MaxDeadEye": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 444062, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 5 Deadeye upgrades for Red"},
		// "a_UnlockAllWeapons": { // VERIFIED // DISABLED - Manual edit via RAIntegration - RATools can't generate the sumOf with SubSource 	// Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			// "id": 439051, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			// "devInfo": "Unlock all unique weapons in the Story Campaign"},
		"a_UpgradeAllWeapons": { // VERIFIED // Shortened logic possible with memGenerate_SumOf_BitsetFlags() if RATools fixes that problem
			"id": 439234, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Missable,
			"devInfo": "Unlock all 16 upgradable weapons in the Story Campaign"},
		},
	"c_BountyHunter": { // Category - Bounty Hunter Challenge mode for Story missions (20)
		// "a_BountyCompletionAll": { // DISABLED - Already incorporated in other achievements
			// 	"id": 0000000, "points": achievement_POINTS_Challenging, "type": achievements_TYPE_Standard,
			// 	"devInfo": "Complete all the Bounty Hunter Mode Missions"},
		"a_BountyHuntChapter1": { // VERIFIED
			"id": 444681, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 1"},
		"a_BountyHuntChapter2": { // VERIFIED
			"id": 443870, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 2"},
		"a_BountyHuntChapter3": { // VERIFIED
			"id": 443872, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 3"},
		"a_BountyHuntChapter5": { // VERIFIED
			"id": 449110, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 5"},
		"a_BountyHuntChapter6": { // VERIFIED (RATools v1.15.0)
			"id": 449109, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 6"},
		"a_BountyHuntChapter7": { // VERIFIED (RATools v1.15.0)
			"id": 444682, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 7"},
		"a_BountyHuntChapter8": { // VERIFIED
			"id": 449108, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 8"},
		"a_BountyHuntChapter9": { // VERIFIED
			"id": 449107, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 9"},
		"a_BountyHuntChapter11": { // VERIFIED (RATools v1.15.0)
			"id": 449101, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 11"},
		"a_BountyHuntChapter12": { // VERIFIED
			"id": 449100, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 12"},
		"a_BountyHuntChapter13": { // VERIFIED
			"id": 449099, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 13"},
		"a_BountyHuntChapter14": { // VERIFIED
			"id": 449098, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 14"},
		"a_BountyHuntChapter15": { // VERIFIED
			"id": 449097, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 15"},
		"a_BountyHuntChapter17": { // VERIFIED
			"id": 449096, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 17"},
		"a_BountyHuntChapter18": { // VERIFIED
			"id": 449064, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 18"},
		"a_BountyHuntChapter20": { // VERIFIED (RATools v1.15.0)
			"id": 449106, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 20"},
		"a_BountyHuntChapter21": { // VERIFIED (RATools v1.15.0)
			"id": 449105, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 21"},
		"a_BountyHuntChapter24": { // VERIFIED
			"id": 449104, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 24"},
		// "a_BountyHuntChapter25": { // VERIFIED (RATools v1.15.0) // DISABLED - MANUAL_CONSTRUCTION
			// "id": 449103, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Complete Bounty Hunter mission for Chapter 25"},
		"a_BountyHuntChapter27": { // VERIFIED
			"id": 449102, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Complete Bounty Hunter mission for Chapter 27"},
		},
	"c_StoryChallenge": { // Category -  Story related challenge achievements (26) 
		// "a_BigMoney": { // VERIFIED // DISABLED - Manual edit via RAIntegration - complex sumation/AddSource chain
			// "id": 447721, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Amass an amount of cash on one player profile"},
		// "a_PerfectAccuracy": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall
			// 	"id": 455472, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// 	"devInfo": "Finish a mission an accuracy of 90% or higher, without using deadeye ability"},
		"a_PerfectShootingTutorial": { // VERIFIED
			"id": 438301, "points": achievement_POINTS_Minor, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Bull's Eye' | Finish tutorial without wasting ammo (13 targets to hit)"},
		"a_SaveCurly": { // VERIFIED
			"id": 449378, "points": achievement_POINTS_Easy, "type": achievements_TYPE_Missable,
			"devInfo": "Level 'Rogue Valley' | After saving Curly Shaw, pick up the $1500 pouch he drops near him"},
		// "a_ChallengeChapter1": { // VERIFIED // DISABLED - Manual edit via RAIntegration - complex sumation/AddSource chain
			// "id": 438677, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Bull's Eye' | Complete with a bounty collected of $1000 or greater | Very Hard"},
		// "a_ChallengeChapter2": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall 
			// "id": 450183, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Bounty Hunter' | Complete with 'No HUD' cheat and with damage taken less than 50% | Hard or Very Hard"},
		"a_ChallengeChapter3": { // VERIFIED 
			"id": 450198, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Ugly Streetfight' | Complete without using any healing items | Very Hard"},
		"a_ChallengeChapter5": { // VERIFIED
			"id": 439585, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Railroaded' | Complete the mission without falling of the train | Hard or Very Hard"},
		"a_ChallengeChapter6": { // VERIFIED
			"id": 450325, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Carinval Life' | Get a killstreak of 10 using the gatling gun without letting go of the trigger | Hard or Very Hard"},
		// "a_ChallengeChapter7": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall 
			// "id": 450393, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Freak Show' | Complete with 60% accuracy or higher | Very Hard"},
		"a_ChallengeChapter8": { // VERIFIED
			"id": 451482, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Rogue Valley' | Complete with 'Bite the Bullet' cheat | Very Hard"},
		"a_ChallengeChapter10": { // VERIFIED
			"id": 450554, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'The Cemetery' | Complete with 'No Distortion', 'Sad Stars' and 'No HUD' cheats | Hard or Very Hard"}, 
		"a_ChallengeChapter11": { // VERIFIED
			"id": 450845, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Range War' | Ride a bison and kill 15 enemies | Hard or Very Hard"},
		// "a_ChallengeChapter12": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall
			// "id": 450557, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Saloon Fight' | Complete with at least 70% HP remaining | Very Hard"},
		"a_ChallengeChapter13": { // VERIFIED
			"id": 450844, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'The Traitor' | Win the battle with 5 allied cannons still operational | Hard or Very Hard"},
		// "a_ChallengeChapter14": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall 
			// "id": 450691, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Sunset Canyon' | Complete with less than 90% damage taken | Very Hard"},
		"a_ChallengeChapter15": { // VERIFIED
			"id": 450888, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Bear Mountain' | Kill Grizzly only using gun 'Faith' | Very Hard"},
		"a_ChallengeChapter17": { // VERIFIED
			"id": 450889, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'The Mine' | Complete using only a knife to damage enemies, in under 1 minute | Hard or Very Hard"},
		// "a_ChallengeChapter19": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall
			// "id": 451499, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Hell Pass' | Complete without letting the coach's HP drop below 40%, using only Buffalo Soldier's deadeye ability to shoot, 'infinite Deadeye' cheat required, melee is allowed | Hard or Very Hard"},
		"a_ChallengeChapter20": { // VERIFIED
			"id": 451481, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Fort Diego' | Kill 12 enemies with head shots | Very Hard"},
		"a_ChallengeChapter22": { // VERIFIED
			"id": 450943, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Devils and Angels' | Complete in under 3 minutes and only killing General Diego | Hard or Very Hard"},
		"a_ChallengeChapter24": { // VERIFIED
			"id": 451042, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Battle Finale' | Complete scoring 5 headshots on Mr. Kelley and without letting any bystanders die | Very Hard"},
		// "a_ChallengeChapter25": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall
			// "id": 451044, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'The Siege' | Complete with combined HP of hero trio at 60% or above, with 'Golden Gun' cheat required | Hard or Very Hard"},
		// "a_ChallengeChapter27": { // VERIFIED // DISABLED - Manual edit via RAIntegration - usage of Remember/Recall
			// "id": 450558, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			// "devInfo": "Level 'Fall From Grace' | Complete with an accuracy of 60% or higher AND damage taken less than 75% | Very Hard"},
		"a_WoodChapter8": { // VERIFIED
			"id": 453665, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'Rogue Valley' | Complete with 'Bite the Bullet' cheat enabled | Red Wood Revolver"},
		"a_WoodChapter10": { // VERIFIED
			"id": 453664, "points": achievement_POINTS_Advanced, "type": achievements_TYPE_Standard,
			"devInfo": "Level 'The Cemetery' | Only damage enemies with the 'Infinite Deadeye' cheat, melee attacks allowed, shooting isn't | Red Wood Revolver"},
		},
	}

// ===================================
// • Achievements TRIGGER GENERATORS •
// ===================================
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_3x_AltResetGroup_OnRestartMission(enum_areaId, enum_releaseRegion) =>
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

function achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion) =>
	once(
		never(is_StartChpMenu_active(enum_releaseRegion)) // <-- ResetNextIf necessary otherwise some StartChpMenu's may add hit counts
		&& on_RewardMenu_render_long(enum_releaseRegion))

function achievements_generate_FullTrigger_BountyHuntCompletion(enum_areaId, enum_releaseRegion) =>
	// [1] ==== Core (Alt) Group ====			
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
	
	// [2] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_AtMainMenu(enum_releaseRegion))

	// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
		|| achievements_generate_3x_AltResetGroup_OnRestartMission(enum_areaId, enum_releaseRegion)

function achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(enum_areaId, float_comboTarget, enum_releaseRegion) => 
	// [1] ==== Core (Alt) Group ====					-> This group is  responsible for unlocking the achievement
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Playing_BountyHunterMode(enum_releaseRegion)
			|| !is_Area(enum_areaId, enum_releaseRegion))
		&& unless(once( // <-- Pause Lock: Cheat Protection
			is_AnyCheat_active(enum_releaseRegion)))

		&& once(on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
		
		&& tally(1, [ // ---Tally---> OrNext with Hitcounts
			once(never(current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion) < float_comboTarget) && // Current combo
				current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion) >= float_comboTarget),
			once(never(current_HighestCombo(enum_releaseRegion) * current_HighestComboMultiplier(enum_releaseRegion) < float_comboTarget) && // Highest achieved combo
				current_HighestCombo(enum_releaseRegion) * current_HighestComboMultiplier(enum_releaseRegion) >= float_comboTarget)
			])
		
		&& trigger_when(
			is_RatingBounty_achieved(enum_releaseRegion)
			&& once(never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
				on_RewardMenu_render_short(enum_releaseRegion))
			&& repeated(600, // --> Delay: so the achievement pops when the reward unlocks UI is displayed 
				never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
				is_RewardMenu_displayed_short(enum_releaseRegion)))

	// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group is purely responsible for displaying an RAmeasured popup for CURRENT combo achieved in the mission; It can never unlock the achievement; max_of(this measuredAltGroup or below measuredAltGroup)
		|| unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Playing_BountyHunterMode(enum_releaseRegion)
			|| !is_Area(enum_areaId, enum_releaseRegion))
		&& unless(once( // <-- Pause Lock: Cheat Protection
			is_AnyCheat_active(enum_releaseRegion)))

		&& once(on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
		
		&& measured(
			current_CashCombo(enum_releaseRegion) * current_CashComboMultiplier(enum_releaseRegion) >= float_comboTarget,
			when = 
				once(is_AreaState_InGame(enum_releaseRegion))
				&& !is_LogoScreenLoading(enum_releaseRegion)
				&& !is_AnimationLoading(enum_releaseRegion)) 
		&& trigger_when(always_false())

	// [3] ==== Alt RAmeasured Handler Group ==== 		-> This group is purely responsible for displaying an RAmeasured popup for HIGHEST combo achieved in the mission; It can never unlock the achievement; max_of(this measuredAltGroup or above measuredAltGroup)
		|| unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Playing_BountyHunterMode(enum_releaseRegion)
			|| !is_Area(enum_areaId, enum_releaseRegion))
		&& unless(once( // <-- Pause Lock: Cheat Protection
			is_AnyCheat_active(enum_releaseRegion)))

		&& once(on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
		
		&& measured(current_HighestCombo(enum_releaseRegion) * current_HighestComboMultiplier(enum_releaseRegion) >= float_comboTarget,
			when = 
				once(is_AreaState_InGame(enum_releaseRegion))
				&& !is_LogoScreenLoading(enum_releaseRegion)
				&& !is_AnimationLoading(enum_releaseRegion)) 
		&& trigger_when(always_false())

	// [4] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion)
			&& is_AtMainMenu(enum_releaseRegion))

	// [5+6+7] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
		|| achievements_generate_3x_AltResetGroup_OnRestartMission(enum_areaId, enum_releaseRegion)

// ------------------ChapterCompletion----------------------
function achievements_generate_FullTrigger_ChapterCompletion(enum_areaId, enum_releaseRegion) =>
	// [1] ==== Core (Alt) Group ====
		unless(!is_ReleaseRegion(enum_releaseRegion))
		&& unless(!is_Playing_SinglePlayerCampaign(enum_releaseRegion))
		&& unless(once( // <-- Pause Lock: Cheat Protection
			is_AnyCheat_active(enum_releaseRegion)))

		&& once(on_PlayerReset_atMissionStartPoint(enum_areaId, enum_releaseRegion))		
		&& once(on_RewardMenu_render_short(enum_releaseRegion))
		&& trigger_when(
			repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
				is_RewardMenu_displayed_short(enum_releaseRegion)))

	// [2] ==== Alt Reset Group ====  				-> Reset when not playing Single Player Campaign OR when not in correct AREA
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& (
				!is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| !is_Area(enum_areaId, enum_releaseRegion)
			))

	// [3] ==== Alt Pause Lock Reset Group ==== 	-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
		// NOTE: Don't reset on_RetryMenu_yes(), only on mission restart
		|| never_toAlt(
			is_ReleaseRegion(enum_releaseRegion) 
			&& once(on_WarningMenu_yes(enum_releaseRegion))
			&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))

	// [4] ==== Alt Pause Lock Reset Group ==== 	-> Reset when pressing 'yes' on RewardMenu->Replay
	|| never_toAlt(
		is_ReleaseRegion(enum_releaseRegion) 
		&& once(on_RewardMenu_Replay_confirm(enum_releaseRegion))
		&& is_PlayerPosition_atMissionLoadingPoint(enum_areaId, enum_releaseRegion))

// -------------------UnlockWeapons---------------------
function achievements_generate_SumOf_FlagsAllUniqueWeapons(enum_releaseRegion) {
	function generate_SumOf_NonUniqueWeaponFlags(enum_releaseRegion) {
		let_array_memAccessorsToSub_NonUniqueFlags = [] // SubSource Flag_Normal & Flag_Normal (with bitwise AND)
		for let_weaponKey in BitsetFlagData_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"] {
			let_flagNormal = BitsetFlagData_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Normal"]			
			let_flagUpgraded = BitsetFlagData_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["NonUniqueFlags"][let_weaponKey]["Flag_Upgraded"]
			
			let_memAccessor_flagNormal = MemAccessorGeneratorToBitset_SelectedPlayerProfileUnlocks(
				let_flagNormal["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagNormal["BitIndex"]], 
				enum_releaseRegion)			
			let_memAccessor_flagUpgraded = MemAccessorGeneratorToBitset_SelectedPlayerProfileUnlocks(
				let_flagUpgraded["ByteIndex"], memUtil_bitIndexToMemAccessor[let_flagUpgraded["BitIndex"]], 
				enum_releaseRegion)

			array_push(let_array_memAccessorsToSub_NonUniqueFlags, (let_memAccessor_flagNormal & let_memAccessor_flagUpgraded))
		}
		return sum_of(let_array_memAccessorsToSub_NonUniqueFlags, memAccessor => memAccessor)
	}	

	let_sumOf_AllWeaponFlags = memGenerate_SumOf_BitsetFlags_noSubSource(
		BitsetFlagData_PlayerProfileUnlocks["Flags_AllUniqueWeapons"]["AllFlags"],
		MemAccessorGeneratorToBitset_SelectedPlayerProfileUnlocks, 
		enum_releaseRegion)
	let_sumOf_NonUniqueWeaponFlags = generate_SumOf_NonUniqueWeaponFlags(enum_releaseRegion)

	return 
		let_sumOf_AllWeaponFlags 
		- let_sumOf_NonUniqueWeaponFlags // Subtract non-unique flags
	}

function achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags_noSubSource(BitsetFlagData_PlayerProfileUnlocks["Flags_AllUpgradedWeapons"], MemAccessorGeneratorToBitset_SelectedPlayerProfileUnlocks, enum_releaseRegion)

// -------------------UnlocksOther---------------------
function achievements_generate_SumOf_FlagsAllHealthUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags_noSubSource(BitsetFlagData_PlayerProfileUnlocks["Flags_AllHealthUpgrades"], MemAccessorGeneratorToBitset_PlayerProfileUnlocks, enum_releaseRegion)

function achievements_generate_SumOf_FlagsAllDeadEyeUpgrades(enum_releaseRegion) =>
	memGenerate_SumOf_BitsetFlags_noSubSource(BitsetFlagData_PlayerProfileUnlocks["Flags_AllDeadEyeUpgrades"], MemAccessorGeneratorToBitset_PlayerProfileUnlocks, enum_releaseRegion)

// ------------------ShowdownStages----------------------
function memAccessorGeneratorToBitset_ShowdownMapUnlocks(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset:ShowdownMapUnlocks", enum_releaseRegion)
	return memAccessor_toByteInBitset(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllStages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		BitsetFlagData_ShowdownMapUnlocks, 
		memAccessorGeneratorToBitset_ShowdownMapUnlocks, 
		enum_releaseRegion)
// ------------------ShowdownCharacters----------------------
function memAccessorGeneratorToBitset_ShowdownCharactersUnlocks(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset:ShowdownCharacterUnlocks", enum_releaseRegion)
	return memAccessor_toByteInBitset(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		BitsetFlagData_ShowdownCharactersUnlocks, 
		memAccessorGeneratorToBitset_ShowdownCharactersUnlocks, 
		enum_releaseRegion)
// ------------------JournalPages----------------------
function memAccessorGeneratorToBitset_JournalPageUnlocks(int_offsetToByte, memAccessor_toByteInBitset, enum_releaseRegion) {
	let_memAddr_toBitset = memory_getAddress(DATATYPE_Struct, "Bitset:JournalPageUnlocks", enum_releaseRegion)
	return memAccessor_toByteInBitset(let_memAddr_toBitset + int_offsetToByte)}

function achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion) =>
	 memGenerate_SumOf_BitsetFlags_noSubSource(
		BitsetFlagData_JournalPageUnlocks, 
		memAccessorGeneratorToBitset_JournalPageUnlocks, 
		enum_releaseRegion)

// ------------------BountyHunterMissions----------------------
function achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion) => 
	memGenerate_SumOf_BitsetFlags_noSubSource(BitsetFlagData_BountyHunterMissionsCompleted, memAccessorGeneratorToBitset_BountyHunterMissionsCompleted, enum_releaseRegion) 

/* function achievements_generate_TallyOf_ShowdownTeamsFreeForAll_InGame(enum_releaseRegion) { // DISABLED function - Prefer using is_ShowdownTeams_FreeForAll()
	let_array_ALL_SHOWDOWN_TEAM_IDs = [SHOWDOWN_TEAM_RED, SHOWDOWN_TEAM_WHITE, SHOWDOWN_TEAM_BLUE, SHOWDOWN_TEAM_YELLOW]
	let_PlayerSlot1_Index = 1
	let_PlayerSlot2_Index = 2
	let_PlayerSlot3_Index = 3
	let_PlayerSlot4_Index = 4
	return tally_of(let_array_ALL_SHOWDOWN_TEAM_IDs, length(let_array_ALL_SHOWDOWN_TEAM_IDs), int_showdownTeamId => // <---TallyOf--- Count if all 4 unique team IDs are present 
		once( // No ResetNextIf necessary as teams can't change in-game
			is_ShowdownPlayer_Team(let_PlayerSlot1_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot2_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot3_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_ShowdownPlayer_Team(let_PlayerSlot4_Index, int_showdownTeamId, enum_releaseRegion)))}
	*/

/* function achievements_generate_TallyOf_ShowdownTeamsFreeForAll_PosterMenu(enum_releaseRegion) { // DISABLED function - Prefer using is_PosterMenu_ShowdownTeams_FreeForAll()
	let_array_ALL_SHOWDOWN_TEAM_IDs = [SHOWDOWN_TEAM_RED, SHOWDOWN_TEAM_WHITE, SHOWDOWN_TEAM_BLUE, SHOWDOWN_TEAM_YELLOW]
	let_PlayerSlot1_Index = 1
	let_PlayerSlot2_Index = 2
	let_PlayerSlot3_Index = 3
	let_PlayerSlot4_Index = 4
	return tally_of(let_array_ALL_SHOWDOWN_TEAM_IDs, length(let_array_ALL_SHOWDOWN_TEAM_IDs), int_showdownTeamId => // <---TallyOf--- Count if all 4 unique team IDs are present 
		once(			
			 // ---ResetNextIf---> Any player changes team (Player can change team on the PosterMenu)
				never(on_PosterMenu_ShowdownPlayer_Team_change(let_PlayerSlot1_Index, enum_releaseRegion)) &&
				never(on_PosterMenu_ShowdownPlayer_Team_change(let_PlayerSlot2_Index, enum_releaseRegion)) &&
				never(on_PosterMenu_ShowdownPlayer_Team_change(let_PlayerSlot3_Index, enum_releaseRegion)) &&
				never(on_PosterMenu_ShowdownPlayer_Team_change(let_PlayerSlot4_Index, enum_releaseRegion))
			&& is_PosterMenu_ShowdownPlayer_Team(let_PlayerSlot1_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_PosterMenu_ShowdownPlayer_Team(let_PlayerSlot2_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_PosterMenu_ShowdownPlayer_Team(let_PlayerSlot3_Index, int_showdownTeamId, enum_releaseRegion)
			|| is_PosterMenu_ShowdownPlayer_Team(let_PlayerSlot4_Index, int_showdownTeamId, enum_releaseRegion)
		))}
	*/


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
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"a_CompleteChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"a_CompleteChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"a_CompleteChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"a_CompleteChapter6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"a_CompleteChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"a_CompleteChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"a_CompleteChapter10": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"a_CompleteChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"a_CompleteChapter12": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"a_CompleteChapter13": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"a_CompleteChapter14": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"a_CompleteChapter15": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"a_CompleteChapter17": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_TheMine, enum_releaseRegion)),
	"a_CompleteChapter19": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_HellPass, enum_releaseRegion)),
	"a_CompleteChapter20": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"a_CompleteChapter22": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"a_CompleteChapter24": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"a_CompleteChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_Siege, enum_releaseRegion)),
	"a_CompleteChapter27": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_ChapterCompletion(AREA_Campaign_FallFromGrace, enum_releaseRegion)
	),
	// "a_CompleteStoryNormal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
			// // ==== Core (Alt) Group ====
			// is_ReleaseRegion(enum_releaseRegion)
			// && is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			// && is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
			// && current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Normal // <---2Lines--- unlock this achievement on any difficulty, without using orNext or altGroups
			// && current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
			// && on_EndingCreditsVideo_start(enum_releaseRegion)),
	// "a_CompleteStoryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
			// // ==== Core (Alt) Group ====
			// is_ReleaseRegion(enum_releaseRegion)
			// && is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			// && is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
			// && current_StoryCampaignDifficulty(enum_releaseRegion) >= DIFFICULTY_Hard // <---2Lines--- unlock this achievement on any hard or veryHard, without using orNext or altGroups
			// && current_StoryCampaignDifficulty(enum_releaseRegion) <= DIFFICULTY_VeryHard
			// && on_EndingCreditsVideo_start(enum_releaseRegion)),
	// "a_CompleteStoryVeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
			// // ==== Core (Alt) Group ====
			// is_ReleaseRegion(enum_releaseRegion)
			// && is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			// && is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
			// && is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion)
			// && on_EndingCreditsVideo_start(enum_releaseRegion)),
	// "a_CompleteStoryWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // DISABLED - Not incorporated in set as this has no cheat protection
			// // ==== Core (Alt) Group ====
			// is_ReleaseRegion(enum_releaseRegion)
			// && is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			// && is_FurthestCompletedStoryChapter(AREA_Campaign_FallFromGrace, enum_releaseRegion)
			// && is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion)
			// && on_EndingCreditsVideo_start(enum_releaseRegion)
	// ),
	// "a_BountyCompletionAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // DISABLED - Redundant as this is already incorporated in set with an achievement for each bounty hunter mission
		// let_sumOf_FlagsAllBountyMissionsCompleted = achievements_generate_SumOf_FlagsAllBountyMissionsCompleted(enum_releaseRegion)
		// return
		// // [1] ==== Core (Alt) Logic Group ==== 		-> This group is responsible for unlocking the achievement. The bitset which is checked in this group is only updated on pressing continue on the RewardMenu 
		// 	(
		// 		is_ReleaseRegion(enum_releaseRegion)
		// 		&& prev(let_sumOf_FlagsAllBountyMissionsCompleted) == BOUNTY_HUNTER_MISSON_COUNT - 1
		// 		&& measured(let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT)
		// 	)

		// // [2] ==== Alt RATrigger Handler Group ==== 	-> This group is responsible for displaying an RAtrigger popup on RewardMenu Render when finishing the last Bounty Hunter Mission, thus indicating to the player this achievement will unlock once he presses continue
		// 	|| (
		// 		is_ReleaseRegion(enum_releaseRegion)
		// 		&& once( // <-- once() to show RATrigger popup
		// 			let_sumOf_FlagsAllBountyMissionsCompleted == BOUNTY_HUNTER_MISSON_COUNT - 1
		// 			&& is_Playing_BountyHunterMode(enum_releaseRegion)
		// 			&& is_RatingBounty_achieved(enum_releaseRegion)
		// 			&& is_RewardMenu_displayed_long(enum_releaseRegion))
		// 		&& trigger_when(always_false()) // <-- always_false()
		// 	)

		// // [3] ==== Alt Reset Group ==== 				-> reset the once() in the [Alt RATrigger Group] when replaying the bounty hunter mission (so the RATrigger popup hides again)
		// 	|| never_toAlt(
		// 		is_ReleaseRegion(enum_releaseRegion)
		// 		&& (
		// 			on_InGame_start(enum_releaseRegion)
		// 			|| on_StartChpMenu_initialize(enum_releaseRegion)
		// 			|| !is_Playing_BountyHunterMode(enum_releaseRegion))
		// 	)
		// }),
	"a_BountyHuntChapter1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"a_BountyHuntChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"a_BountyHuntChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"a_BountyHuntChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"a_BountyHuntChapter6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(AREA_Campaign_CarnivalLife, 500.0, enum_releaseRegion)),
	"a_BountyHuntChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(AREA_Campaign_FreakShow, 300.0, enum_releaseRegion)),
	"a_BountyHuntChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Custom version of achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_RogueValley, enum_releaseRegion). This adds an RAmeasured
		
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_array_POINTER_CHAIN_KEYS = const_ExtraMission_data[const_MISSION_AREA]

		return
		// [1] ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_BountyHunterMode(enum_releaseRegion)
				|| !is_Area(const_MISSION_AREA, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			&& measured(tally_of(const_array_POINTER_CHAIN_KEYS, length(const_array_POINTER_CHAIN_KEYS), string_pointerChainKey =>
				once(on_RogueValley_Treasure_find(string_pointerChainKey, enum_releaseRegion))))

			&& achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
			&& is_RatingBounty_achieved(enum_releaseRegion)
			&& trigger_when(repeated(530, // <-- Delay: so the achievement pops when the reward unlocks UI is displayed 
				never(is_StartChpMenu_active(enum_releaseRegion))
				&& is_RewardMenu_displayed_long(enum_releaseRegion)))
		
		// [2] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))

		// [3] ==== Alt Pause Lock Reset Groups ====		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& is_PlayerPosition_atMissionLoadingPoint(const_MISSION_AREA, enum_releaseRegion))
				
		}),
	"a_BountyHuntChapter9": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_GhostTown, enum_releaseRegion)),
	"a_BountyHuntChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(AREA_Campaign_RangeWar, 200.0, enum_releaseRegion)),
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
		// NOTE: Custom version of achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_Stagecoach, enum_releaseRegion). Adds an RAmeasured
		
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
		achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(AREA_Campaign_FortDiego, 300.0, enum_releaseRegion)),
	"a_BountyHuntChapter21": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion_withComboObjective(AREA_Campaign_EndOfTheLine, 200.0, enum_releaseRegion)),
	"a_BountyHuntChapter24": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		achievements_generate_FullTrigger_BountyHuntCompletion(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"a_BountyHuntChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_Siege
		const_JACK_MAJOR_CHARACTER_INDEX = 3

		return 
		// [1] ==== Core (Alt) Group ====					-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_BountyHunterMode(enum_releaseRegion)
				|| !is_Area(const_MISSION_AREA, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			
			&& trigger_when(
				is_RatingBounty_achieved(enum_releaseRegion)
				&& once(never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(600, // --> Delay: so the achievement pops when the reward unlocks UI is displayed 
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group is purely responsible for displaying Jack's HP in percent in an RAmeasured popup; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_BountyHunterMode(enum_releaseRegion)
				|| !is_Area(const_MISSION_AREA, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))			
			
			&& measured(current_Calculated_MajorCharacterHPPercentage(const_JACK_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= 100.0, 				
			 	/* MANUAL_CONSTRUCTION (of above measured) with Remember/Recall
					- PCSX2 nightly build v1.7.5782 (May 5) can't handle the following logic: |current_Calculated_MajorCharacterHPPercentage(const_JACK_MAJOR_CHARACTER_INDEX, enum_releaseRegion) * 100.0 >= 100.0|
					
					-> Logic (PAL)
						I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	|currentHP/maxHP|
						Remember	Recall						*	Float			100.0
						Measured	Recall						>=	Float			100.0

					-> Logic (NTSCU)
						I:0xX004f7d20_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	|currentHP/maxHP|
						Remember	Recall						*	Float			100.0
						Measured	Recall						>=	Float			100.0
					*/
				when = 
					once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
					&& is_MajorCharacter_CharacterName(const_JACK_MAJOR_CHARACTER_INDEX, CHARACTER_JackSwift, enum_releaseRegion),
				format = "percent") 
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}), 
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

			&& once(on_InGame_start(enum_releaseRegion))
			&& once(on_AreaState_ChangeTo(AREASTATE_InGame, enum_releaseRegion))

			&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise it may trigger the achievement when Structs are reconstructed
			&& !is_AnimationLoading(enum_releaseRegion)

			&& current_RewardMenu_Balance(enum_releaseRegion) >= const_CASH_TARGET

			&& once(never(!is_RewardMenu_displayed_short(enum_releaseRegion)) && 
				on_RewardMenu_render_short(enum_releaseRegion))

			&& trigger_when(
				repeated(360, never(!is_RewardMenu_displayed_short(enum_releaseRegion)) && // <-- Delay: so the achievement pops when the cash balance UI is displayed
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt Trigger Popup Handler Group ==== 	-> This alt handles the trigger popup during the mission; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_InGame_start(enum_releaseRegion))
			&& once(on_AreaState_ChangeTo(AREASTATE_InGame, enum_releaseRegion))
			
			&& !is_LogoScreenLoading(enum_releaseRegion) // ---4 Lines---> --> othserwise this Trigger indicator may show when it shouldn't
			&& repeated(300, never(is_AnimationLoading(enum_releaseRegion)) && // --> delay necessary as otherwise this Trigger indicator may show a few frames after AnimationLoading() is over
				!is_AnimationLoading(enum_releaseRegion))
			&& !is_StartChpMenu_active(enum_releaseRegion)
			
			&& current_Calculated_CashDuringMission(enum_releaseRegion) >= const_CASH_TARGET
			/* MANUAL_CONSTRUCTION sumOf
				-> Logic (PAL)
					I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_0xX0000587c>=50000

					AddAddress	Mem 32-bit 0x562a20
					AddSource 	Mem 32-bit 0x5884 		* Mem 32-bit 0x5888
					AddAddress	Mem 32-bit 0x562a20
								Mem 32-bit 0x587c	>= Val const_CASH_TARGET

				-> Logic (NTSCU)
					I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_0xX0000587c>=50000

					AddAddress	Mem 32-bit 0x5602a0
					AddSource 	Mem 32-bit 0x5884 		* Mem 32-bit 0x5888
					AddAddress	Mem 32-bit 0x5602a0
								Mem 32-bit 0x587c	>= Val const_CASH_TARGET
			*/

			&& trigger_when(always_false())
			
		// [3] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))

		// [4] ==== Alt Reset Group ==== 					-> Reset when changing AREA's
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& on_Area_change(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ====			-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			// NOTE: Reset on RetryMenu restart => is not allowed for cheats being used...
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& on_CashResetToSavedCash(enum_releaseRegion))

		// [6] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on RewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RewardMenu_Replay_confirm(enum_releaseRegion))
				&& on_CashResetToSavedCash(enum_releaseRegion))
		}),
	"a_PerfectAccuracy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_DESIRED_ACCURACY = 0.9 // 90%

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Once Deadeye ability has been used
				is_AreaState_InGame(enum_releaseRegion)
				&& on_DeadEyeAbilitiesUsed_increment(enum_releaseRegion)))

			&& once(on_InGame_start(enum_releaseRegion))
					
			&& current_Calculated_Accuracy(enum_releaseRegion) >= const_DESIRED_ACCURACY 
			/* MANUAL_CONSTRUCTION (of above sumOf) with Remember + Recall
				-> Logic (PAL)
					I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.9

					AddAddress	Mem		32-bit	0x763070
					AddAddress	Mem		32-bit	0x36c
					Remember	Float			0.0			+	Mem		32-bit	0x194
					AddAddress	Mem		32-bit	0x763070
					AddAddress	Mem		32-bit	0x36c
					Remember	Mem		32-bit	0x198		/ 	Recall
								Recall						>= 	Float			const_DESIRED_ACCURACY

				-> Logic (NTSCU)
					I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.9

					AddAddress	Mem		32-bit	0x7608f0
					AddAddress	Mem		32-bit	0x36c
					Remember	Float			0.0			+	Mem		32-bit	0x194
					AddAddress	Mem		32-bit	0x7608f0
					AddAddress	Mem		32-bit	0x36c
					Remember	Mem		32-bit	0x198		/ 	Recall
								Recall						>= 	Float			const_DESIRED_ACCURACY
				*/
			
			&& once(never(!is_RewardMenu_displayed_short(enum_releaseRegion)) && 
				on_RewardMenu_render_short(enum_releaseRegion))

			&& trigger_when(
				repeated(190, never(!is_RewardMenu_displayed_short(enum_releaseRegion)) && // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
			
		// [2] ==== Alt Reset Group ==== 					-> Reset everything when at main menu
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& is_AtMainMenu(enum_releaseRegion))
			
		// [3] ==== Alt Reset Group ==== 					-> Reset when changing AREA's
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion)
				&& on_Area_change(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Groups ==== 		-> Reset when pressing 'yes' on retryMenu after mission failure
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RetryMenu_yes(enum_releaseRegion))
				&& on_CashResetToSavedCash(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_WarningMenu_yes(enum_releaseRegion))
				&& on_CashResetToSavedCash(enum_releaseRegion))

		// [6] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on RewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& once(on_RewardMenu_Replay_confirm(enum_releaseRegion))
				&& on_CashResetToSavedCash(enum_releaseRegion))
		}),
	"a_PerfectShootingTutorial": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_ALLOWED_BULLETS = 13

		return
		// [1] ==== Core (Alt) Group ====					-> This group is responsible for unlocking the achievement
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion) 
			&& is_Area(AREA_Campaign_BullsEye, enum_releaseRegion)
			// && !is_AnyCheat_active(enum_releaseRegion) // <-- usage of cheats for this achievement makes no difference

			&& unless( // <-- Pause Lock: when more than 13 bullets were used
				repeated(const_ALLOWED_BULLETS + 1, on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion)) 
				|| once(is_PlayerXCoordinate_notStationaryNearCoordinate(17.4, enum_releaseRegion))
				|| once(is_PlayerYCoordinate_notStationaryNearCoordinate(-10.5, enum_releaseRegion)))

			&& once(is_GameTrigger(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))
			&& trigger_when(on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_GoodCompletion, enum_releaseRegion))

		// [2] ==== Alt RAmeasured Indicator Group ====		-> This group is purely responsible for displaying shots left during the tutorial
			|| unless( // <-- Pause Lock: when more than 13 bullets were used
				repeated(const_ALLOWED_BULLETS + 1, on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion)) 
				|| once(is_PlayerXCoordinate_notStationaryNearCoordinate(17.4, enum_releaseRegion))
				|| once(is_PlayerYCoordinate_notStationaryNearCoordinate(-10.5, enum_releaseRegion)))
			&& measured( // ---Measured--> Display bullets left/allowed for challenge achievement
				tally(const_ALLOWED_BULLETS, [
					repeated(6, always_true()), // ---3 Lines---> Add 13 bullets (3x repeated, to add hits faster)
					repeated(6, always_true()),
					repeated(1, always_true()),
					deduct(repeated(const_ALLOWED_BULLETS, on_AmmoHUDControllerReserveAmmo_decrement(enum_releaseRegion))) // ---> Deduct each bullet fired
				]),
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion) 
					&& is_Area(AREA_Campaign_BullsEye, enum_releaseRegion)
					&& once(is_GameTrigger(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))
				)
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ==== 					-> Reset when the shooting tutorial starts
			|| never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_GameTrigger_changeTo(GAMETRIGGER_ShootingTutorial_Start, enum_releaseRegion))

		// [4] ==== Alt Reset Group ==== 					-> Reset when at MainMenu
			|| never_toAlt( 
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_AtMainMenu(enum_releaseRegion))
		}),
	"a_SaveCurly": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CURLY_CASH_AWARD = 1500
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_CURLY_CASH_PICKUP_AREA_X = -37.0
		const_CURLY_CASH_PICKUP_AREA_Y = 40.0
		const_CURLY_CASH_PICKUP_AREA_Z = -9.5
		const_CURLY_CASH_PICKUP_AREA_THRESHOLD = 8.0

		return 
		// [1] ==== Core (Alt) Group ====			
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)) // <-- this prevents usage of mid-mission checkpoints via RetryMenu in Story Mode (Bounty Hunter mode always respawns back at start of mission)
			
			&& once(
				is_PlayerPosition_withinArea(
					const_CURLY_CASH_PICKUP_AREA_X, const_CURLY_CASH_PICKUP_AREA_Y, const_CURLY_CASH_PICKUP_AREA_Z,
					const_CURLY_CASH_PICKUP_AREA_THRESHOLD, enum_releaseRegion)
				&& on_CashAcquiredByOtherMeans_increasesBy(const_CURLY_CASH_AWARD, enum_releaseRegion))
			
			&& trigger_when(achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion))

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct Area
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_CASH_TARGET = 1000
			
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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

		// [2] ==== Alt RATrigger Popup Handler Group ==== 	-> This alt handles the trigger popup during the mission; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& measured(current_Calculated_CashAcquiredDuringMission(enum_releaseRegion) >= const_CASH_TARGET, 
				/* MANUAL_CONSTRUCTION of Measured(sumOf)
					-> Logic (PAL)
						I:0xX007448d8_B:0xX00000008_I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_M:0xX0000587c>=1000
					
						AddAddress	Mem 32-bit 0x7448d8
						SubSource 	Mem 32-bit 0x8									|- SavedCash (before mission start)|
						AddAddress	Mem 32-bit 0x562a20
						AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888			|+ CurrentCashCombo * CurrentCashComboMulitplier|
						AddAddress	Mem 32-bit 0x562a20
						Measured	Mem 32-bit 0x587c	>= Val const_CASH_TARGET	|+ CurrentCash (during gameplay)|
					
					-> Logic (NTSCU)
						I:0xX00742158_B:0xX00000008_I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_M:0xX0000587c>=1000

						AddAddress	Mem 32-bit 0x742158
						SubSource 	Mem 32-bit 0x8									|- SavedCash (before mission start)|
						AddAddress	Mem 32-bit 0x5602a0
						AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888			|+ CurrentCashCombo * CurrentCashComboMulitplier|
						AddAddress	Mem 32-bit 0x5602a0
						Measured	Mem 32-bit 0x587c	>= Val const_CASH_TARGET	|+ CurrentCash (during gameplay)|
				*/
				when = once(on_PlayerReset_atMissionStartPoint(AREA_Campaign_BullsEye, enum_releaseRegion)))
				
			&& trigger_when(always_false())	

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_BullsEye, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(AREA_Campaign_BullsEye, enum_releaseRegion)
		}),	
	"a_ChallengeChapter2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_BountyHunter
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_BiteTheBullet, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_NoHud
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.5 // = 50%

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion))) 
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed 
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Alt RAmeasured Handler Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.5.1.

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL		(1)

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.5.1.

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL		(1)
				*/

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion) 
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))		
					
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(40, // <-- Delay achievement unlock to coincide with game UI effects
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group is purely responsible for displaying an RAmeasured popup for DamageTaken; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed 
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Core (Alt) Logic Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.5.1.

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL		(1)

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.5.1.

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL		(1)
				*/
			
			&& measured(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= (const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0),
				/* MANUAL_CONSTRUCTION (of Measured) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f50.0

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Measured	Recall						>=	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0)
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f50.0

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Measured	Recall						>=	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0)				
				*/
				when = once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
					is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion) 
					&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)),
				format = "raw")
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [5+6+7] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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

		// [2] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_UglyStreetFight, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(AREA_Campaign_UglyStreetFight, enum_releaseRegion)
		),	
	"a_ChallengeChapter5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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

		// [2] ==== Alt Reset Group ====  Reset when not in correct Area
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(AREA_Campaign_Railroaded, enum_releaseRegion))

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(AREA_Campaign_Railroaded, enum_releaseRegion)
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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

		// [3+4+5] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_FreakShow
		const_DESIRED_ACCURACY = 0.6 // 60%
		const_MAX_ACCURACY = 100.0 // 100%
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& current_Calculated_Accuracy(enum_releaseRegion) >= const_DESIRED_ACCURACY 
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.6

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
									Recall						>= 	Float			const_DESIRED_ACCURACY
									
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.6
					
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
									Recall						>= 	Float			const_DESIRED_ACCURACY
				*/
				
			&& trigger_when(
				once(
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					is_RewardMenu_displayed_short(enum_releaseRegion)))
		
		// [2] ==== Alt RAmeasured Handler Grop ==== 			-> This group is purely responsible for displaying accuracy rating (otherwise not shown during gameplay). This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& measured(current_Calculated_Accuracy(enum_releaseRegion) >= const_MAX_ACCURACY,
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f100.0_G:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			const_MAX_ACCURACY

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f100.0_G:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			const_MAX_ACCURACY
				*/
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)),
				format = "percent")				
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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

		// [2]  ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [3]  ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_AnySpecifiedCheats_inactive(const_array_REQUIRED_CHEAT, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter11": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_RangeWar
		const_KILLS_REQUIRED = 15

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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
	"a_ChallengeChapter12": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_SaloonFight
		const_HP_REQUIRED_DECIMAL = 0.7
		const_HP_REQUIRED_PERCENT = 70.0
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& current_PlayerHP(enum_releaseRegion) / current_PlayerMaxHP(enum_releaseRegion) >= const_HP_REQUIRED_DECIMAL
				/* MANUAL_CONSTRUCTION (of above math) usage of Remember/Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:0xX00000010/fF00000014_{recall}>=f0.7

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10	/	Mem		Float	0x14	|currentHP/maxHP|
									Recall					>=	const_HP_REQUIRED_DECIMAL

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:0xX00000010/fF00000014_{recall}>=f0.7

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10	/	Mem		Float	0x14	|currentHP/maxHP|
									Recall					>=	const_HP_REQUIRED_DECIMAL
					*/

			&& trigger_when(
				once(
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(210,
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Grop ==== 		-> This group is purely responsible for displaying HP as percentage. This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& measured(current_PlayerHP(enum_releaseRegion) / current_PlayerMaxHP(enum_releaseRegion) >= const_HP_REQUIRED_PERCENT,
				/* MANUAL_CONSTRUCTION with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14			|HP / maxHP|
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			100.0

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14			|HP / maxHP|
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			100.0
					*/
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)),
				format = "percent")
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter13": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_TheTraitor
		const_ALLOWED_ALLIED_CANNONS_DESTROYED = 3 // of 8 total allied cannons

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& current_Calculated_TheTraitor_AllyCannonsDestroyedCount(enum_releaseRegion) <= const_ALLOWED_ALLIED_CANNONS_DESTROYED
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
	"a_ChallengeChapter14": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_SunsetCanyon
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.9 // = 90%

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Alt RAmeasured Handler Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.9.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.9.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
				*/

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				once(
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					never(!is_RewardMenu_displayed_short(enum_releaseRegion)) &&
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group is purely responsible for displaying an RAmeasured popup for DamageTaken; It can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed 
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Alt RAmeasured Handler Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.9.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.9.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
				*/
			
			&& measured(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= (const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0),
				/* MANUAL_CONSTRUCTION (of Measured) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f90.0

						AddAddress	Mem		32-bit	0x00763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x00763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Measured	Recall						>=	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0)

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f90.0

						AddAddress	Mem		32-bit	0x00763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x00763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Measured	Recall						>=	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0)	
				*/
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)),
				format = "raw")
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(tally(1, [ // <-- Pause Lock: When damaging one of the bosses with wrong weapon
				once( 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock would trigger when loading the mission for first time
					&& !is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_A_INDEX, enum_releaseRegion)),
				once( 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock would trigger when loading the mission for first time
					&& !is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_B_INDEX, enum_releaseRegion))
				]))			
			&& unless( // <-- Pause Lock: When over time limit
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			// && is_Weapon_inInventory(const_REQUIRED_WEAPON, enum_releaseRegion) // <-- This check is very buggy as the pointerChain for this mission is weird
			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))
			
		// [2] ==== Alt RAmeasured Handler Group ==== 		-> This group handles RAmeasured popup to display time left in challenge; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(tally(1, [ // <-- Pause Lock: When damaging one of the bosses with wrong weapon
				once( 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock would trigger when loading the mission for first time
					&& !is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_A_INDEX, enum_releaseRegion)),
				once( 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock would trigger when loading the mission for first time
					&& !is_PlayerWeapon_equipped(const_REQUIRED_WEAPON, enum_releaseRegion)
					&& on_MajorCharacterHP_decrement(const_BOSS_B_INDEX, enum_releaseRegion))
				]))	
			&& unless( // <-- Pause Lock: When over time limit
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))

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
	"a_ChallengeChapter19": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_HellPass
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_BiteTheBullet, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_InfiniteDeadeye
		const_COACH_MAJOR_CHARACTER_INDEX = 3
		const_COACH_HP_THRESHOLD_DECIMAL = 0.4
		const_COACH_MAX_HP_PERCENTAGE = 100.0

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless( // <-- Pause Lock: When using firearm without the Deadeye ability
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(
					is_PlayerInput_AimGun_pressed(enum_releaseRegion)
					&& on_PlayerInput_FireGun_press(enum_releaseRegion)))

			&& once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
				is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
				&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& is_MajorCharacter_CharacterName(const_COACH_MAJOR_CHARACTER_INDEX, CHARACTER_StageCoach, enum_releaseRegion)

			&& current_Calculated_MajorCharacterHPPercentage(const_COACH_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_COACH_HP_THRESHOLD_DECIMAL 
				/* MANUAL_CONSTRUCTION (of above line/summation) usage of Remember/Recall
					-> Logic (PAL)
						I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_{recall}>=f0.4

						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	
									Recall						>=	Float			const_COACH_HP_THRESHOLD_DECIMAL

					-> Logic (NTSCU)
						I:0xX004f7d20_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_{recall}>=f0.4

						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	
									Recall						>=	Float			const_COACH_HP_THRESHOLD_DECIMAL
					*/

			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 			-> This group handles RAmeasured indicator to the stagecoach's HP in percentage; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless( // <-- Pause Lock: When using firearm without the Deadeye ability
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(
					is_PlayerInput_AimGun_pressed(enum_releaseRegion)
					&& on_PlayerInput_FireGun_press(enum_releaseRegion)))

			&& measured(
				current_Calculated_MajorCharacterHPPercentage(const_COACH_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_COACH_MAX_HP_PERCENTAGE,
				/* MANUAL_CONSTRUCTION (of above measured) usage of Remember/Recall
					-> Logic (PAL)
						I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	
						Remember	Recall						* 	Float			100.0
						Measured	Recall						>=	Float			const_COACH_MAX_HP_PERCENTAGE

					-> Logic (NTSCU)
						I:0xX004f7d20_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x10		/	Mem		Float	0x14	
						Remember	Recall						* 	Float			100.0
						Measured	Recall						>=	Float			const_COACH_MAX_HP_PERCENTAGE
				*/

				when = 
					once( // <---Once--- Specifies that the required cheats must be active prior to (re-)starting the mission
						is_SpecifiedCheat_active(const_REQUIRED_CHEAT, enum_releaseRegion)
						&& on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
					&& is_MajorCharacter_CharacterName(const_COACH_MAJOR_CHARACTER_INDEX, CHARACTER_StageCoach, enum_releaseRegion)

					&& current_Calculated_MajorCharacterHPPercentage(const_COACH_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_COACH_HP_THRESHOLD_DECIMAL,
					/* MANUAL_CONSTRUCTION (of above line/summation) usage of Remember/Recall
						-> Logic (PAL)
							I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_Q:{recall}>=f0.4

							AddAddress	Mem		32-bit	0x4fa3a0
							AddAddress	Mem		32-bit	0x18
							AddAddress	Mem		32-bit	0x18
							Remember	Mem		Float	0x10		/	Mem		Float	0x14	
							MeasuredIf	Recall						>=	Float			const_COACH_HP_THRESHOLD_DECIMAL

						-> Logic (NTSCU)
							I:0xX004f7d20_I:0xX00000018_I:0xX00000018_K:fF00000010/fF00000014_{recall}>=f0.4

							AddAddress	Mem		32-bit	0x4f7d20
							AddAddress	Mem		32-bit	0x18
							AddAddress	Mem		32-bit	0x18
							Remember	Mem		Float	0x10		/	Mem		Float	0x14	
							MeasuredIf	Recall						>=	Float			const_COACH_HP_THRESHOLD_DECIMAL
					*/
				format = "percent")
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4] ==== Alt Reset Group ====  					-> Reset when required cheats are not active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_SpecifiedCheat_inactive(const_REQUIRED_CHEAT, enum_releaseRegion))

		// [5+6+7] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_ChallengeChapter20": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_FortDiego
		const_ENEMY_HEADSHOT_KILL_COUNT = 12
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: When over time limit
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))
			&& unless( // <-- Pause Lock: When an enemy other than General Diego was killed
				tally_of(const_array_ENEMY_ACTOR_DATA_INDICES, 1, int_actorDataindex => 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
					&& is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_GeneralDiego, enum_releaseRegion) // <---2 lines--- check if any ActorHP went to 0 
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: When over time limit
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
				&& once(current_TimeSpentInMission(enum_releaseRegion) >= const_TIME_LIMIT_SECONDS))
			&& unless( // <-- Pause Lock: When an enemy other than General Diego was killed
				tally_of(const_array_ENEMY_ACTOR_DATA_INDICES, 1, int_actorDataindex => 
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
					&& is_Actor_CharacterModelId_notEqualTo(int_actorDataindex, CHARACTER_GeneralDiego, enum_releaseRegion) // <---2 lines--- check if any ActorHP went to 0 
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once a bystander/pedestrian is killed
				tally_of(const_array_PEDESTRIAN_ACTOR_DATA_INDICES, 1, int_actorDataindex =>
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
					&& is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion)
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
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once a bystander/pedestrian is killed
				tally_of(const_array_PEDESTRIAN_ACTOR_DATA_INDICES, 1, int_actorDataindex =>
					is_AreaState_InGame(enum_releaseRegion) // --> is_AreaState_InGame() necessary as otherwise this pauseLock may trigger when loading the mission for first time
					&& is_ActorDataSlot_active(int_actorDataindex, enum_releaseRegion)
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
	"a_ChallengeChapter25": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_MISSION_AREA = AREA_Campaign_Siege
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_BiteTheBullet, CHEAT_NoHud, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_GoldenGun
		const_JACK_MAJOR_CHARACTER_INDEX = 3
		const_ANNIE_MAJOR_CHARACTER_INDEX = 4

		const_TRIO_HP_PERCENT_THRESHOLD_DECIMAL = 0.6
		const_TRIO_HP_THRESHOLD_DECIMAL = const_TRIO_HP_PERCENT_THRESHOLD_DECIMAL * 3 // == 1.8
		const_TRIO_MAX_HP_DECIMAL = 3.0 // == 1.0 * 3
		const_MAX_PERCENT = 100.0

		function current_Calculated_HeroTrioHPpercent(int_jackCharacterIndex, int_annieCharacterIndex, enum_releaseRegion) =>
			current_PlayerHP(enum_releaseRegion) / current_PlayerMaxHP(enum_releaseRegion)
			+ current_Calculated_MajorCharacterHPPercentage(int_jackCharacterIndex, enum_releaseRegion) 
			+ current_Calculated_MajorCharacterHPPercentage(int_annieCharacterIndex, enum_releaseRegion) 

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			
			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))

			&& is_MajorCharacter_CharacterName(const_JACK_MAJOR_CHARACTER_INDEX, CHARACTER_JackSwift, enum_releaseRegion) 
			&& is_MajorCharacter_CharacterName(const_ANNIE_MAJOR_CHARACTER_INDEX, CHARACTER_AnnieStoakes, enum_releaseRegion) 

			&& current_Calculated_HeroTrioHPpercent(const_JACK_MAJOR_CHARACTER_INDEX, const_ANNIE_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_TRIO_HP_THRESHOLD_DECIMAL
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember/Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004fa3a0_I:0xX00000020_I:0xX00000018_A:fF00000010/fF00000014_K:f0.0_{recall}>=f2.1

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Red_HP/Red_maxHP|
						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Jack_HP/Jack_maxHP|
						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x20
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Annie_HP/Annie_maxHP|
						Remember	Float			0.0
									Recall						>= 	Float 			const_TRIO_HP_THRESHOLD_DECIMAL

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004f7d20_I:0xX00000018_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004f7d20_I:0xX00000020_I:0xX00000018_A:fF00000010/fF00000014_K:f0.0_{recall}>=f2.1

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Red_HP/Red_maxHP|
						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Jack_HP/Jack_maxHP|
						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x20
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Annie_HP/Annie_maxHP|
						Remember	Float			0.0
									Recall						>= 	Float 			const_TRIO_HP_THRESHOLD_DECIMAL			
					*/

			&& trigger_when(
				once(on_RewardMenu_render_short(enum_releaseRegion))
				&& repeated(190, // <-- Delay achievement unlock to coincide with game UI effects
					is_RewardMenu_displayed_short(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 			-> This group handles RAmeasured popup to combined HP of hero trio; This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_Hard, enum_releaseRegion)
				&& !is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))

			&& measured(
				// (current_Calculated_HeroTrioHPpercent(const_JACK_MAJOR_CHARACTER_INDEX, const_ANNIE_MAJOR_CHARACTER_INDEX, enum_releaseRegion) / const_TRIO_MAX_HP_THRESHOLD_PERCENTAGE) * 100.0 >= const_MAX_PERCENT,
				current_Calculated_HeroTrioHPpercent(const_JACK_MAJOR_CHARACTER_INDEX, const_ANNIE_MAJOR_CHARACTER_INDEX, enum_releaseRegion) >= const_MAX_PERCENT,
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember/Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004fa3a0_I:0xX00000018_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004fa3a0_I:0xX00000020_I:0xX00000018_A:fF00000010/fF00000014_K:f0.0_K:{recall}/f3.0_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Red_HP/Red_maxHP|
						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Jack_HP/Jack_maxHP|
						AddAddress	Mem		32-bit	0x4fa3a0
						AddAddress	Mem		32-bit	0x20
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Annie_HP/Annie_maxHP|
						Remember	Float			0.0
						Remember	Recall						/ 	Float			const_TRIO_MAX_HP_DECIMAL
						Remember	Recall						* 	Float			const_MAX_PERCENT
						Measured	Recall						>= 	Float 			const_MAX_PERCENT

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004f7d20_I:0xX00000018_I:0xX00000018_A:fF00000010/fF00000014_I:0xX004f7d20_I:0xX00000020_I:0xX00000018_A:fF00000010/fF00000014_K:f0.0_K:{recall}/f3.0_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Red_HP/Red_maxHP|
						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x18
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Jack_HP/Jack_maxHP|
						AddAddress	Mem		32-bit	0x4f7d20
						AddAddress	Mem		32-bit	0x20
						AddAddress	Mem		32-bit	0x18
						AddSource	Mem		Float	0x10		/	Mem		Float	0x14	|+ Annie_HP/Annie_maxHP|
						Remember	Float			0.0
						Remember	Recall						/ 	Float			const_TRIO_MAX_HP_DECIMAL
						Remember	Recall						* 	Float			const_MAX_PERCENT
						Measured	Recall						>= 	Float 			const_MAX_PERCENT
					*/
				when = 
					once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
					&& is_MajorCharacter_CharacterName(const_JACK_MAJOR_CHARACTER_INDEX, CHARACTER_JackSwift, enum_releaseRegion) 
					&& is_MajorCharacter_CharacterName(const_ANNIE_MAJOR_CHARACTER_INDEX, CHARACTER_AnnieStoakes, enum_releaseRegion),
				format = "percent")

			&& trigger_when(always_false())

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
	"a_ChallengeChapter27": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		// NOTE: only 1 measured target can be displayed => prefer showing accuracy rating instead of damage taken, because accuracy isn't shown during gameplay, HP bar is shown

		const_MISSION_AREA = AREA_Campaign_FallFromGrace
		const_MAX_DAMAGE_TAKEN_DECIMAL = 0.75 // = 75%
		const_DESIRED_ACCURACY = 0.6 // 60%
		const_MAX_ACCURACY = 100.0 // 100%
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))		
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed 
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Alt RAmeasured Handler Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.75.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.75.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
				*/

			&& current_Calculated_Accuracy(enum_releaseRegion) >= const_DESIRED_ACCURACY 
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.6

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
									Recall						>= 	Float			const_DESIRED_ACCURACY

					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_{recall}>=f0.6
						
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
									Recall						>= 	Float			const_DESIRED_ACCURACY
				*/

			&& once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion))
			&& trigger_when(
				achievements_generate_Check_Once_OnRewardMenuRender(enum_releaseRegion)
				&& repeated(440, // <-- Delay achievement unlock to coincide with stats window being displayed 
					never(is_StartChpMenu_active(enum_releaseRegion))
					&& is_RewardMenu_displayed_long(enum_releaseRegion)))

		// [2] ==== Alt RAmeasured Handler Group ==== 			-> This group is purely responsible for displaying accuracy rating (otherwise not shown during gameplay). This group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_VeryHard, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))			
			&& unless( // <-- Pause Lock: Once DamageTaken >= allowed 
				once(is_AreaState_InGame(enum_releaseRegion)) // --> is_AreaState_InGame() necessary as otherwise |Once DamageTaken >= allowed| would trigger pause lock when loading a mission for first time
				&& once(current_Calculated_DamageTakenPercentage(enum_releaseRegion) >= const_MAX_DAMAGE_TAKEN_DECIMAL))
				/* MANUAL_CONSTRUCTION (of Pause Lock) with Remember + Recall	(Same PauseIf as in Alt RAmeasured Handler Group)
					-> Logic (PAL)
						I:0xX00763070_I:0xX00000018_K:fF00000014_I:0xX00763070_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.75.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX00000018_K:fF00000014_I:0xX007608f0_I:0xX0000036c_K:fF00000070/{recall}_P:{recall}>=f0.75.1.

						AndNext		...on_PlayerReset_atMissionStartPoint()..	(1)

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						PauseIf		Recall						>=	Float	const_MAX_DAMAGE_TAKEN_DECIMAL	(1)
				*/

			&& measured(current_Calculated_Accuracy(enum_releaseRegion) >= const_MAX_ACCURACY,
				/* MANUAL_CONSTRUCTION (of above sumOf) with Remember + Recall
					-> Logic (PAL)
						I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f100.0_G:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x763070
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			const_MAX_ACCURACY
						
					-> Logic (NTSCU)
						I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f100.0_G:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Float			0.0			+	Mem		32-bit	0x194
						AddAddress	Mem		32-bit	0x7608f0
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		32-bit	0x198		/ 	Recall
						Remember	Recall						*	Float			100.0
						Measured 	Recall						>= 	Float			const_MAX_ACCURACY
				*/
				when = once(on_PlayerReset_atMissionStartPoint(const_MISSION_AREA, enum_releaseRegion)),
				format = "percent")				
			&& trigger_when(always_false())

		// [3] ==== Alt Reset Group ====  					-> Reset when not in correct AREA
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Area(const_MISSION_AREA, enum_releaseRegion))

		// [4+5+6] ==== Alt Pause Lock Reset Groups ==== 	-> Reset when restart mission (3 alts = 3 ways to restart the mission)
			|| achievements_generate_3x_AltResetGroup_OnRestartMission(const_MISSION_AREA, enum_releaseRegion)
		}),
	"a_WoodChapter8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_RogueValley
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_InfiniteDeadeye, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_BiteTheBullet

		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
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
	"a_WoodChapter10": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MISSION_AREA = AREA_Campaign_TheCemetery
		const_array_DISALLOWED_CHEATS = [ 
			CHEAT_NoHud, CHEAT_GoldenGun, CHEAT_BiteTheBullet, CHEAT_Invincibility, 
			CHEAT_NoDistortion, CHEAT_SadStars, CHEAT_Debug_ShowPlayerPosition, CHEAT_Debug_ShowAIInfo]
		const_REQUIRED_CHEAT = CHEAT_InfiniteDeadeye
		
		return
		// [1] ==== Core (Alt) Logic Group ==== 			-> This group handles the core logic; It's responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_SinglePlayerCampaign(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion))
			&& unless(
				!is_StoryCampaignDifficulty(DIFFICULTY_RedWoodRevolver, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnySpecifiedCheats_active(const_array_DISALLOWED_CHEATS, enum_releaseRegion)))
			&& unless( // <-- Pause Lock: Once a firearm is used
				once(
					is_AreaState_InGame(enum_releaseRegion))
				&& once(
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
		const_SHOWDOWN_STAGE = AREA_Showdown_WidowsPatch
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_KatieGrady
		const_ALLIED_CPU_CHARACTER = CHARACTER_SheriffGrady
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_UglyChris
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_GigoloHancock
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <-- Check allied team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  // <-- Check enemy team
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) // <-- Check if allied team =/= enemy team

			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))
		
		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)

			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <-- Check allied team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  // <-- Check enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) // <-- Check if allied team =/= enemy team
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())

		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_BountyHunterBlade": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_SunsetCanyon
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_BladeSlade
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_SissyFess
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_RicoPedrosa
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_UdoKang
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished AND any other player has won
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& (
					is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				)))
			&& unless(once( // <-- Pause Lock: Once killing someone without using knives (Deadeye ability is allowed, as this character's ability also throws knives)
				is_AreaState_InGame(enum_releaseRegion)
				&& !is_ShowdownPlayer_Weapon_equipped(const_HUMAN_PLAYER_INDEX_1, WEAPON_Knife, enum_releaseRegion)
				&& on_ShowdownPlayer_DeathToll_increment(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& is_ShowdownTeams_FreeForAll(enum_releaseRegion)

			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion)
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_BountyHunterAnnie": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_TheRanch
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_AnnieStoakes
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_GovernorGriffon
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_HolsteinHal
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_Sam
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion) 

			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_BountyHunterCooper": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_SHOWDOWN_STAGE = AREA_Showdown_Fairground
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_Cooper
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_JasonCornet
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_SheriffBartlett
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_BuffaloSoldier
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_SHOWDOWN_PLAYER_MAX_HP = 150.0
		const_MAX_DAMAGE_TAKEN_DECIMAL = 8.88 // = 888%		(Lucky 8)

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Once flat damage taken exceeds damage allowed, thus equal or greater than Max damage allowd
				is_AreaState_InGame(enum_releaseRegion)
				&& current_ShowdownPlayer_DamageTaken(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= (const_SHOWDOWN_PLAYER_MAX_HP * const_MAX_DAMAGE_TAKEN_DECIMAL)
				&& prev_ShowdownPlayer_DamageTaken(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) < (const_SHOWDOWN_PLAYER_MAX_HP * const_MAX_DAMAGE_TAKEN_DECIMAL)))	

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion) 
			
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when( 
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))
			
		// [2] ==== Alt RAmeasured DamageTaken Indicator Group ====	-> This alt is purely responsible for displaying the current damage taken (as this is otherwise not shown during gameplay), This alt group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Once flat damage taken exceeds damage allowed, thus equal or greater than Max damage allowd
				is_AreaState_InGame(enum_releaseRegion)
				&& current_ShowdownPlayer_DamageTaken(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= (const_SHOWDOWN_PLAYER_MAX_HP * const_MAX_DAMAGE_TAKEN_DECIMAL)
				&& prev_ShowdownPlayer_DamageTaken(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) < (const_SHOWDOWN_PLAYER_MAX_HP * const_MAX_DAMAGE_TAKEN_DECIMAL)))	

			&& measured(
				current_Calculated_ShowdownPlayer_DamageTakenPercentage(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= (const_MAX_DAMAGE_TAKEN_DECIMAL * 100.0),
				/* MANUAL_CONSTRUCTION: Remember + Recall
					-> Logic (PAL)
						I:0xX007638c0_I:0xX00000018_K:fF00000014_I:0xX007638bc_I:0xX00000030_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f888.0

						AddAddress	Mem		32-bit	0x7638c0
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x7638bc
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Remember	Recall						*	Float 	100.0
						Measured	Recall						>=	Float 	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100)

					-> Logic (NTSCU)
						I:0xX00761140_I:0xX00000018_K:fF00000014_I:0xX0076113c_I:0xX00000030_K:fF00000070/{recall}_K:{recall}*f100.0_M:{recall}>=f888.0

						AddAddress	Mem		32-bit	0x761140
						AddAddress	Mem		32-bit	0x18
						Remember	Mem		Float	0x14
						AddAddress	Mem		32-bit	0x76113c
						AddAddress	Mem		32-bit	0x36c
						Remember	Mem		Float	0x70		/	Recall
						Remember	Recall						*	Float 	100.0
						Measured	Recall						>=	Float 	(const_MAX_DAMAGE_TAKEN_DECIMAL * 100)
				*/
				when = 
					current_NumberOfPlayers(enum_releaseRegion) == 4
					&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

					&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

					&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  
					
					&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
					&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)

					&& once(is_AreaState_InGame(enum_releaseRegion)),
				format = "raw"
				)
			
			&& trigger_when(always_false())

		// [3] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  

			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion) 
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_10K, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_BountyHunterWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: There should be around 55 weapon_IDs, but added up to 100 for the measured as backup for non-documented weapons which can be acquired only during showdown (eg. special weapons acquired through cards or Deadeye abilities)

		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_WEAPON_KILLS_REQUIRED = 7

		function generate_IntegerArray_0To(int_maxValue) {
			let_IntegerArray = []
			for let_i in range(0, int_maxValue) {
				array_push(let_IntegerArray, let_i)
			}
			return let_IntegerArray}

		return
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player 1 did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& (
					is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				)))

			&& measured( // ---Measured---> count each unique weapon kill
				tally_of(generate_IntegerArray_0To(100), const_WEAPON_KILLS_REQUIRED, int_possibleWeaponId => 
					once(
						is_AreaState_InGame(enum_releaseRegion)
						&& is_ShowdownPlayer_Weapon_equipped(const_HUMAN_PLAYER_INDEX_1, int_possibleWeaponId, enum_releaseRegion)
						&& on_ShowdownPlayer_DeathToll_increment(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion))),
				when =  
					current_NumberOfPlayers(enum_releaseRegion) == 4
					&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
					
					&& is_ShowdownTeams_FreeForAll(enum_releaseRegion)
					&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)

					&& once(is_AreaState_InGame(enum_releaseRegion))
				)
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion)
			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_SundownFallingStar": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_FallenCreek
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_FallingStar
		const_ALLIED_CPU_CHARACTER = CHARACTER_ShadowWolf
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_Grizzly
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_StandingSnake
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion)) 
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <-- Check allied team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  // <-- Check enemy team
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) // <-- Check if allied team =/= enemy team
			
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)

			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <-- Check allied team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  // <-- Check enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) // <-- Check if allied team =/= enemy team
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_SundownBlack": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_GhostTown
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_MrBlack
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_BadBessie
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_UglyChris
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_PigJosh
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_KILL_COUNT = 15

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& (
					is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& is_ShowdownTeams_FreeForAll(enum_releaseRegion)
			
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))

			&& measured(repeated(const_KILL_COUNT,
				is_AreaState_InGame(enum_releaseRegion)
				&& on_ShowdownPlayer_DeathToll_increment(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)))
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion)

			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())

		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_SundownGriffon": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {  // WARNING - Manual creation via RAIntegration
		const_SHOWDOWN_STAGE = AREA_Showdown_BrokenCreek
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_GovernorGriffon
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_NateHarlow
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_FallingStar
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_Red
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_REQUIRED_BOUNTY_COLLECTED = 15000

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion)) 
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  
			
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)

			&& once(
				is_AreaState_InGame(enum_releaseRegion)
				&& current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion) == 0)
			&& current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion) >= const_REQUIRED_BOUNTY_COLLECTED // ---> measured() is unnecessary as cash is already shown on screen
			/* MANUAL_CONSTRUCTION (of above 2 lines)
				-> logic (PAL)
					N:0xH006b0a1c=2_I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_A:0xX00005880_I:0xX00562a20_0xX0000587c=0.1._I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_A:0xX00005880_I:0xX00562a20_0xX0000587c>=15000

					AndNext		Mem	8-bit  0x6b0a1c == Val 0x2				|is_AreaState_InGame|
					AddAddress	Mem 32-bit 0x562a20
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x562a20	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x562a20
								Mem 32-bit 0x587c	==	0				(1)	|current_Cash|

					AddAddress	Mem 32-bit 0x562a20
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x562a20	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x562a20
					Measured	Mem 32-bit 0x587c							|current_Cash|

				-> logic (NTSCU) 
					N:0xH006aaa9c=2_I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_A:0xX00005880_I:0xX005602a0_0xX0000587c=0.1._I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_A:0xX00005880_I:0xX005602a0_0xX0000587c>=15000

					AndNext		Mem	8-bit  0x6aaa9c == Val 0x2				|is_AreaState_InGame|
					AddAddress	Mem 32-bit 0x5602a0
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x5602a0	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x5602a0
								Mem 32-bit 0x587c	==	0				(1)	|current_Cash|

					AddAddress	Mem 32-bit 0x5602a0
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x5602a0	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x5602a0
					Measured	Mem 32-bit 0x587c							|current_Cash|			
				*/
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  

			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_SundownNate": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		const_SHOWDOWN_STAGE = AREA_Showdown_TheMansion
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_NateHarlow
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_GovernorGriffon
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_ColonelDaren
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_GeneralDiego
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_DESIRED_ACCURACY = 0.7 // 60%
		const_MAX_ACCURACY = 100.0 // 100%
		const_REQUIRED_BOUNTY_COLLECTED = 12000

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)  
			
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)

			&& once(
				is_AreaState_InGame(enum_releaseRegion)
				&& current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion) == 0)
			&& current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion) >= const_REQUIRED_BOUNTY_COLLECTED // ---> measured() is unnecessary as cash is already shown on screen
			/* MANUAL_CONSTRUCTION (of above 2 lines)
				-> logic (PAL)
					N:0xH006b0a1c=2_I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_A:0xX00005880_I:0xX00562a20_0xX0000587c=0.1._I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_A:0xX00005880_I:0xX00562a20_0xX0000587c>=12000

					AndNext		Mem	8-bit  0x6b0a1c == Val 0x2				|is_AreaState_InGame|
					AddAddress	Mem 32-bit 0x562a20
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x562a20	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x562a20
								Mem 32-bit 0x587c	==	0				(1)	|current_Cash|

					AddAddress	Mem 32-bit 0x562a20
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x562a20	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x562a20
					Measured	Mem 32-bit 0x587c							|current_Cash|

				-> logic (NTSCU) 
					N:0xH006aaa9c=2_I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_A:0xX00005880_I:0xX005602a0_0xX0000587c=0.1._I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_A:0xX00005880_I:0xX005602a0_0xX0000587c>=12000

					AndNext		Mem	8-bit  0x6aaa9c == Val 0x2				|is_AreaState_InGame|
					AddAddress	Mem 32-bit 0x5602a0
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x5602a0	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x5602a0
								Mem 32-bit 0x587c	==	0				(1)	|current_Cash|

					AddAddress	Mem 32-bit 0x5602a0
					AddSource 	Mem 32-bit 0x5884 	* Mem 32-bit 0x5888		|current_CashCombo * current_CashComboMultiplier|
					AddAddress	Mem 32-bit 0x5602a0	
					AddSource 	Mem 32-bit 0x5880							|current_CashAcquiredByOtherMeans|
					AddAddress	Mem 32-bit 0x5602a0
					Measured	Mem 32-bit 0x587c							|current_Cash|			
				*/

			&& current_Calculated_ShowdownPlayer_Accuracy(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= const_DESIRED_ACCURACY
			/* MANUAL_CONSTRUCTION (of above line): Remember + Recall
				-> Logic (PAL)
					I:0xX007638bc_I:0xX00000030_K:f0.0+0xX00000494_I:0xX007638bc_I:0xX00000030_K:0xX00000498/{recall}_{recall}>=f0.7

					AddAddress	Mem		32-bit	0x7638bc
					AddAddress	Mem		32-bit	0x30
					Remember	Float			0.0			+	Mem		32-bit	0x494
					AddAddress	Mem		32-bit	0x7638bc
					AddAddress	Mem		32-bit	0x30
					Remember	Mem		32-bit	0x498		/ 	Recall
								Recall						>= 	Float			const_DESIRED_ACCURACY
								
				-> Logic (NTSCU)
					I:0xX0076113c_I:0xX00000030_K:f0.0+0xX00000494_I:0xX0076113c_I:0xX00000030_K:0xX00000498/{recall}_{recall}>=f0.7

					AddAddress	Mem		32-bit	0x76113c
					AddAddress	Mem		32-bit	0x30
					Remember	Float			0.0			+	Mem		32-bit	0x494
					AddAddress	Mem		32-bit	0x76113c
					AddAddress	Mem		32-bit	0x30
					Remember	Mem		32-bit	0x498		/ 	Recall
								Recall						>= 	Float			const_DESIRED_ACCURACY
				*/
						
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt RAmeasured Accuracy Indicator Group ====	-> This alt is purely responsible for displaying the current accuracy percentage (as this is otherwise not shown in-game), This alt group can never unlock the achievement
			|| unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& measured(
				current_Calculated_ShowdownPlayer_Accuracy(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= const_MAX_ACCURACY,
				/* MANUAL_CONSTRUCTION (of measured): Remember + Recall
					-> Logic (PAL)
						I:0xX007638bc_I:0xX00000030_K:f0.0+0xX00000494_I:0xX007638bc_I:0xX00000030_K:0xX00000498/{recall}_K:{recall}*f100.0_M:{recall}>=f100.0

						AddAddress	Mem		32-bit	0x7638bc
						AddAddress	Mem		32-bit	0x30
						Remember	Float			0.0			+	Mem		32-bit	0x494
						AddAddress	Mem		32-bit	0x7638bc
						AddAddress	Mem		32-bit	0x30
						Remember	Mem		32-bit	0x498		/ 	Recall
						Remember	Recall						* 	Float			100.0
						Measured	Recall						>=	Float			const_MAX_ACCURACY

					-> Logic (NTSCU)
						I:0xX0076113c_I:0xX00000030_K:f0.0+0xX00000494_I:0xX0076113c_I:0xX00000030_K:0xX00000498/{recall}_K:{recall}*f100.0_M:{recall}>=f100.0


						AddAddress	Mem		32-bit	0x76113c
						AddAddress	Mem		32-bit	0x30
						Remember	Float			0.0			+	Mem		32-bit	0x494
						AddAddress	Mem		32-bit	0x76113c
						AddAddress	Mem		32-bit	0x30
						Remember	Mem		32-bit	0x498		/ 	Recall
						Remember	Recall						* 	Float			100.0
						Measured	Recall						>=	Float			const_MAX_ACCURACY
				*/
				when = 
					current_NumberOfPlayers(enum_releaseRegion) == 4
					&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

					&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
					&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)
					
					&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion) 
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
					
					&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
					&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)

					&& once(is_AreaState_InGame(enum_releaseRegion)),
				format = "percent"
				)
			
			&& trigger_when(always_false())

		// [3] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)
					
			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
	
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_5min, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_SundownFlawless": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished and player did not win
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& (
					is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				)))
			&& unless(once( // <-- Pause Lock: When HP drops to 0
				is_AreaState_InGame(enum_releaseRegion)
				&& on_ShowdownPlayer_HP_zero(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)))

			&& measured(tally_of( // ---Measured TallyOf---> Count each unique player kill
				[const_CPU_PLAYER_INDEX_2, const_CPU_PLAYER_INDEX_3, const_CPU_PLAYER_INDEX_4], 3, int_CPUplayerIndex =>
					once(
						is_AreaState_InGame(enum_releaseRegion)
						&& on_ShowdownPlayer_HP_zero(int_CPUplayerIndex, enum_releaseRegion)
						&& on_ShowdownPlayer_DeathToll_increment(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				)),
				when = 
					current_NumberOfPlayers(enum_releaseRegion) == 4
					&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
										
					&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
					&& current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

					&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion)
					&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_1min, enum_releaseRegion)

					&& once(is_AreaState_InGame(enum_releaseRegion))
				)			
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
					
			&& current_PosterMenu_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // <---3 Lines--- Check 3 player enemy team
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) == current_PosterMenu_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
	
			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion) 
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_1min, enum_releaseRegion)

			&& trigger_when(always_false())

		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_HighNoonNatalie": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_MansionGrounds
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_Natalie
		const_ALLIED_CPU_CHARACTER = CHARACTER_MrKelley
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_RedJr
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_NateHarlow
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_KILLS_REQUIRED = 3

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion)) 
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished AND player 3 or 4 won
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)

			// && is_ShowdownTeams_FreeForAll(enum_releaseRegion) // ---> Unnecessary, as High Noon mode defaults to free-for-all regardless of selected teams at ShowdownPosterMenu at MainMenu  

			&& is_Showdown_Mode(SHOWDOWN_MODE_HighNoon, enum_releaseRegion) 
			&& is_Showdown_HighNoonRequiredWins(SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))

			&& once(current_ShowdownPlayer_DeathToll(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == 0)
			&& measured(current_ShowdownPlayer_DeathToll(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= const_KILLS_REQUIRED)
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& tally(1, [ // ---Tally---> Check if either Player 1 OR Player 2 has won (in this free-for-all)
					once(is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) && 
						never(!is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion))),
					once(is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) && 
						never(!is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)))
					])
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ALLIED_CPU_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)

			// && is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion) // ---> Unnecessary, as High Noon mode defaults to free-for-all regardless of selected teams at ShowdownPosterMenu at MainMenu  
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_HighNoon, enum_releaseRegion) 
			&& is_Showdown_HighNoonRequiredWins(SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
		}),
	"a_HighNoonCurly": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_SHOWDOWN_STAGE = AREA_Showdown_TwinRocks
		const_HUMAN_PLAYER_CHARACTER = CHARACTER_CurlyShaw
		const_ENEMY_CPU_CHARACTER_1 = CHARACTER_BloodyTom
		const_ENEMY_CPU_CHARACTER_2 = CHARACTER_BigOaf
		const_ENEMY_CPU_CHARACTER_3 = CHARACTER_TwiggyPhelps
		const_HUMAN_PLAYER_INDEX_1 = 1 // Human player is always at index 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4
		const_HEADSHOTS_REQUIRED = 5

		return
		// [1] ==== Core (Alt) Group ====							-> This group is responsible for unlocking the achievement
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion)
				|| !is_Area(const_SHOWDOWN_STAGE, enum_releaseRegion)) 
			&& unless(once( // <-- Pause Lock: Cheat Protection 
				is_AnyCheat_active(enum_releaseRegion)))
			&& unless(once( // <-- Pause Lock: Hide trigger indicator when the match is finished AND any enemy player has won
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				|| is_ShowdownPlayer_Winner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion) 
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			// && is_ShowdownTeams_FreeForAll(enum_releaseRegion) // ---> Unnecessary, as High Noon mode defaults to free-for-all regardless of selected teams at ShowdownPosterMenu at MainMenu  

			&& is_Showdown_Mode(SHOWDOWN_MODE_HighNoon, enum_releaseRegion) 
			&& is_Showdown_HighNoonRequiredWins(SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))
			
			&& once(current_ShowdownPlayer_HeadShots(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) == 0)
			&& measured(current_ShowdownPlayer_HeadShots(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) >= const_HEADSHOTS_REQUIRED)
			
			&& trigger_when(
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion)
				&& is_ShowdownPlayer_Winner(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
				&& is_ShowdownPlayer_NotWinner(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
				&& on_MultiplayerRewardMenu_FirstPopupMenu_render(enum_releaseRegion))

		// [2] ==== Alt PosterMenu RAtrigger Indicator Group ====	-> This group is purely responsible for showing the RAtrigger indicator when at the PosterMenu when all settings are correct; This group can never unlock the achievement.
			|| is_ReleaseRegion(enum_releaseRegion) 
			&& is_AtMainMenu(enum_releaseRegion)
			&& is_Pointer_ShowdownPosterMenuController_active(enum_releaseRegion)
			&& is_ShowdownPosterMenu_displayed(enum_releaseRegion)

			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerSlot_filled(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)			
			&& is_PosterMenu_ShowdownPlayerCharacter(const_HUMAN_PLAYER_INDEX_1, const_HUMAN_PLAYER_CHARACTER, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_2, const_ENEMY_CPU_CHARACTER_1, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_3, const_ENEMY_CPU_CHARACTER_2, enum_releaseRegion)
			&& is_PosterMenu_ShowdownPlayerCharacter(const_CPU_PLAYER_INDEX_4, const_ENEMY_CPU_CHARACTER_3, enum_releaseRegion)

			// && is_PosterMenu_ShowdownTeams_FreeForAll(enum_releaseRegion) // ---> Unnecessary, as High Noon mode defaults to free-for-all regardless of selected teams at ShowdownPosterMenu at MainMenu  
				
			&& is_Showdown_Mode(SHOWDOWN_MODE_HighNoon, enum_releaseRegion) 
			&& is_Showdown_HighNoonRequiredWins(SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5, enum_releaseRegion)
			&& is_PosterMenu_ShowdownStage(const_SHOWDOWN_STAGE, enum_releaseRegion)

			&& trigger_when(always_false())		
		
		// [3] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 				-> Reset when pressing 'yes' on MultiplayerRewardMenu->AnyButton (Replay, Multiplayer Settings OR Quit)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_ConfirmBtn_press(enum_releaseRegion))
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
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_UnlockCharactersHalf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllCharacters = achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
			&& !is_AnimationLoading(enum_releaseRegion)
			&& is_RStar_Cheat_inActive(enum_releaseRegion)

			&& prev(let_sumOf_FlagsAllCharacters) < CHARACTER_COUNT/2
			&& prev(let_sumOf_FlagsAllCharacters) > CHARACTER_COUNT/2 - 18 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
			&& let_sumOf_FlagsAllCharacters >= CHARACTER_COUNT/2
			&& let_sumOf_FlagsAllCharacters <= (CHARACTER_COUNT/2) + 18 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
		}),
	"a_UnlockCharactersAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllCharacters = achievements_generate_SumOf_FlagsAllCharacters(enum_releaseRegion)
		return 			
			// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllCharacters) < CHARACTER_COUNT
			&& prev(let_sumOf_FlagsAllCharacters) > CHARACTER_COUNT - 18 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
			&& measured(let_sumOf_FlagsAllCharacters == CHARACTER_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_CompleteJournalHalf": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: No Measured Flag required for this as a_CompleteFullJournal already has one
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
		// ==== Core (Alt) Group ====
			is_ReleaseRegion(enum_releaseRegion)
			&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
			&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
			&& !is_AnimationLoading(enum_releaseRegion)
			&& is_RStar_Cheat_inActive(enum_releaseRegion)

			&& prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT/2
			&& prev(let_sumOf_FlagsAllPages) > JOURNALPAGE_COUNT/2 - 40 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
			&& let_sumOf_FlagsAllPages >= JOURNALPAGE_COUNT/2 
			&& let_sumOf_FlagsAllPages <= (JOURNALPAGE_COUNT/2) + 40 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
		}),
	"a_CompleteJournalAll": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		let_sumOf_FlagsAllPages = achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion)
		return 			
		// ==== Core (Alt) Group ====
			prev(let_sumOf_FlagsAllPages) < JOURNALPAGE_COUNT
			&& prev(let_sumOf_FlagsAllPages) > JOURNALPAGE_COUNT - 40 // ---> In case more than 1 is unlocked between the bitset updating (the bitset only updates on save) - When at Brimstone, the player could potentially buy a lot of items
			&& measured(let_sumOf_FlagsAllPages == JOURNALPAGE_COUNT,
				when = 
					is_ReleaseRegion(enum_releaseRegion)
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
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
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
					&& !is_StartChpMenu_active(enum_releaseRegion) // ---1 line: bugfix---> Health upgrades are not unlockable during this menu; this line in necessary as the struct storing DynamicBitset_PlayerProfileUnlocks may be remade during StartChpMenu  
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
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
					&& !is_StartChpMenu_active(enum_releaseRegion) // ---1 line: bugfix---> Deadeye upgrades are not unlockable during this menu, this line in necessary as the struct storing DynamicBitset_PlayerProfileUnlocks may be remade during StartChpMenu  
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),	
	"a_UnlockAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WARNING - Manual creation via RAIntegration
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUniqueWeapons(enum_releaseRegion)
		/* MANUAL_CONSTRUCTION of FullTrigger
			-> Serialized (PAL) - Alt Group 1
				I:0xX007448d8_A:d0xP0000000c_I:0xX007448d8_A:d0xQ0000000c_I:0xX007448d8_A:d0xR0000000c_I:0xX007448d8_A:d0xS0000000c_I:0xX007448d8_A:d0xT0000000c_I:0xX007448d8_A:d0xK0000000d_I:0xX007448d8_A:d0xK0000000e_I:0xX007448d8_A:d0xK0000000f_I:0xX007448d8_A:d0xK00000010_I:0xX007448d8_A:d0xO00000011_I:0xX007448d8_A:d0xP00000011_I:0xX007448d8_B:d0xT00000010&d0xM00000011_I:0xX007448d8_B:d0xQ0000000e&d0xR0000000e_I:0xX007448d8_B:d0xQ00000011&d0xR00000011_I:0xX007448d8_B:d0xR00000010&d0xS00000010_I:0xX007448d8_B:d0xS0000000f&d0xT0000000f_I:0xX007448d8_B:d0xP0000000d&d0xQ0000000d_I:0xX007448d8_B:d0xO0000000f&d0xP0000000f_I:0xX007448d8_B:d0xO00000010&d0xP00000010_I:0xX007448d8_B:d0xQ0000000f&d0xR0000000f_I:0xX007448d8_B:d0xR0000000d&d0xS0000000d_I:0xX007448d8_B:d0xO00000011&d0xP00000011_I:0xX007448d8_B:d0xM00000010&d0xN00000010_I:0xX007448d8_B:d0xS0000000e&d0xT0000000e_I:0xX007448d8_B:d0xM0000000f&d0xN0000000f_I:0xX007448d8_B:d0xT0000000d&d0xM0000000e_I:0xX007448d8_B:d0xN0000000e&d0xO0000000e_I:0xX007448d8_d0xQ00000011<24_I:0xX007448d8_A:d0xP0000000c_I:0xX007448d8_A:d0xQ0000000c_I:0xX007448d8_A:d0xR0000000c_I:0xX007448d8_A:d0xS0000000c_I:0xX007448d8_A:d0xT0000000c_I:0xX007448d8_A:d0xK0000000d_I:0xX007448d8_A:d0xK0000000e_I:0xX007448d8_A:d0xK0000000f_I:0xX007448d8_A:d0xK00000010_I:0xX007448d8_A:d0xO00000011_I:0xX007448d8_A:d0xP00000011_I:0xX007448d8_B:d0xT00000010&d0xM00000011_I:0xX007448d8_B:d0xQ0000000e&d0xR0000000e_I:0xX007448d8_B:d0xQ00000011&d0xR00000011_I:0xX007448d8_B:d0xR00000010&d0xS00000010_I:0xX007448d8_B:d0xS0000000f&d0xT0000000f_I:0xX007448d8_B:d0xP0000000d&d0xQ0000000d_I:0xX007448d8_B:d0xO0000000f&d0xP0000000f_I:0xX007448d8_B:d0xO00000010&d0xP00000010_I:0xX007448d8_B:d0xQ0000000f&d0xR0000000f_I:0xX007448d8_B:d0xR0000000d&d0xS0000000d_I:0xX007448d8_B:d0xO00000011&d0xP00000011_I:0xX007448d8_B:d0xM00000010&d0xN00000010_I:0xX007448d8_B:d0xS0000000e&d0xT0000000e_I:0xX007448d8_B:d0xM0000000f&d0xN0000000f_I:0xX007448d8_B:d0xT0000000d&d0xM0000000e_I:0xX007448d8_B:d0xN0000000e&d0xO0000000e_I:0xX007448d8_d0xQ00000011>10_I:0xX007448d8_A:0xP0000000c_I:0xX007448d8_A:0xQ0000000c_I:0xX007448d8_A:0xR0000000c_I:0xX007448d8_A:0xS0000000c_I:0xX007448d8_A:0xT0000000c_I:0xX007448d8_A:0xK0000000d_I:0xX007448d8_A:0xK0000000e_I:0xX007448d8_A:0xK0000000f_I:0xX007448d8_A:0xK00000010_I:0xX007448d8_A:0xO00000011_I:0xX007448d8_A:0xP00000011_I:0xX007448d8_B:0xT00000010&0xM00000011_I:0xX007448d8_B:0xQ0000000e&0xR0000000e_I:0xX007448d8_B:0xQ00000011&0xR00000011_I:0xX007448d8_B:0xR00000010&0xS00000010_I:0xX007448d8_B:0xS0000000f&0xT0000000f_I:0xX007448d8_B:0xP0000000d&0xQ0000000d_I:0xX007448d8_B:0xO0000000f&0xP0000000f_I:0xX007448d8_B:0xO00000010&0xP00000010_I:0xX007448d8_B:0xQ0000000f&0xR0000000f_I:0xX007448d8_B:0xR0000000d&0xS0000000d_I:0xX007448d8_B:0xO00000011&0xP00000011_I:0xX007448d8_B:0xM00000010&0xN00000010_I:0xX007448d8_B:0xS0000000e&0xT0000000e_I:0xX007448d8_B:0xM0000000f&0xN0000000f_I:0xX007448d8_B:0xT0000000d&0xM0000000e_I:0xX007448d8_B:0xN0000000e&0xO0000000e_I:0xX007448d8_M:0xQ00000011=24_Q:0xX0054c7cc=1397050451_Q:0xH004fbaf0=250_Q:0xH0073dd6c=1_Q:0xM004fd3ec=1_Q:0xX007478f0!=36864_I:0xX007448d8_A:0xH000007bc&223_O:0!=82_I:0xX007448d8_A:0xH000007bd&223_O:0!=83_I:0xX007448d8_A:0xH000007be&223_O:0!=84_I:0xX007448d8_A:0xH000007bf&223_O:0!=65_I:0xX007448d8_A:0xH000007c0&223_O:0!=82_I:0xX007448d8_A:0xH000007c1&223_I:0xX007448d8_A:0xH000007c2&223_Q:0!=0

			-> Serialized (NTSCU) - Alt Group 2
				I:0xX00742158_A:d0xP0000000c_I:0xX00742158_A:d0xQ0000000c_I:0xX00742158_A:d0xR0000000c_I:0xX00742158_A:d0xS0000000c_I:0xX00742158_A:d0xT0000000c_I:0xX00742158_A:d0xK0000000d_I:0xX00742158_A:d0xK0000000e_I:0xX00742158_A:d0xK0000000f_I:0xX00742158_A:d0xK00000010_I:0xX00742158_A:d0xO00000011_I:0xX00742158_A:d0xP00000011_I:0xX00742158_B:d0xT00000010&d0xM00000011_I:0xX00742158_B:d0xQ0000000e&d0xR0000000e_I:0xX00742158_B:d0xQ00000011&d0xR00000011_I:0xX00742158_B:d0xR00000010&d0xS00000010_I:0xX00742158_B:d0xS0000000f&d0xT0000000f_I:0xX00742158_B:d0xP0000000d&d0xQ0000000d_I:0xX00742158_B:d0xO0000000f&d0xP0000000f_I:0xX00742158_B:d0xO00000010&d0xP00000010_I:0xX00742158_B:d0xQ0000000f&d0xR0000000f_I:0xX00742158_B:d0xR0000000d&d0xS0000000d_I:0xX00742158_B:d0xO00000011&d0xP00000011_I:0xX00742158_B:d0xM00000010&d0xN00000010_I:0xX00742158_B:d0xS0000000e&d0xT0000000e_I:0xX00742158_B:d0xM0000000f&d0xN0000000f_I:0xX00742158_B:d0xT0000000d&d0xM0000000e_I:0xX00742158_B:d0xN0000000e&d0xO0000000e_I:0xX00742158_d0xQ00000011<24_I:0xX00742158_A:d0xP0000000c_I:0xX00742158_A:d0xQ0000000c_I:0xX00742158_A:d0xR0000000c_I:0xX00742158_A:d0xS0000000c_I:0xX00742158_A:d0xT0000000c_I:0xX00742158_A:d0xK0000000d_I:0xX00742158_A:d0xK0000000e_I:0xX00742158_A:d0xK0000000f_I:0xX00742158_A:d0xK00000010_I:0xX00742158_A:d0xO00000011_I:0xX00742158_A:d0xP00000011_I:0xX00742158_B:d0xT00000010&d0xM00000011_I:0xX00742158_B:d0xQ0000000e&d0xR0000000e_I:0xX00742158_B:d0xQ00000011&d0xR00000011_I:0xX00742158_B:d0xR00000010&d0xS00000010_I:0xX00742158_B:d0xS0000000f&d0xT0000000f_I:0xX00742158_B:d0xP0000000d&d0xQ0000000d_I:0xX00742158_B:d0xO0000000f&d0xP0000000f_I:0xX00742158_B:d0xO00000010&d0xP00000010_I:0xX00742158_B:d0xQ0000000f&d0xR0000000f_I:0xX00742158_B:d0xR0000000d&d0xS0000000d_I:0xX00742158_B:d0xO00000011&d0xP00000011_I:0xX00742158_B:d0xM00000010&d0xN00000010_I:0xX00742158_B:d0xS0000000e&d0xT0000000e_I:0xX00742158_B:d0xM0000000f&d0xN0000000f_I:0xX00742158_B:d0xT0000000d&d0xM0000000e_I:0xX00742158_B:d0xN0000000e&d0xO0000000e_I:0xX00742158_d0xQ00000011>10_I:0xX00742158_A:0xP0000000c_I:0xX00742158_A:0xQ0000000c_I:0xX00742158_A:0xR0000000c_I:0xX00742158_A:0xS0000000c_I:0xX00742158_A:0xT0000000c_I:0xX00742158_A:0xK0000000d_I:0xX00742158_A:0xK0000000e_I:0xX00742158_A:0xK0000000f_I:0xX00742158_A:0xK00000010_I:0xX00742158_A:0xO00000011_I:0xX00742158_A:0xP00000011_I:0xX00742158_B:0xT00000010&0xM00000011_I:0xX00742158_B:0xQ0000000e&0xR0000000e_I:0xX00742158_B:0xQ00000011&0xR00000011_I:0xX00742158_B:0xR00000010&0xS00000010_I:0xX00742158_B:0xS0000000f&0xT0000000f_I:0xX00742158_B:0xP0000000d&0xQ0000000d_I:0xX00742158_B:0xO0000000f&0xP0000000f_I:0xX00742158_B:0xO00000010&0xP00000010_I:0xX00742158_B:0xQ0000000f&0xR0000000f_I:0xX00742158_B:0xR0000000d&0xS0000000d_I:0xX00742158_B:0xO00000011&0xP00000011_I:0xX00742158_B:0xM00000010&0xN00000010_I:0xX00742158_B:0xS0000000e&0xT0000000e_I:0xX00742158_B:0xM0000000f&0xN0000000f_I:0xX00742158_B:0xT0000000d&0xM0000000e_I:0xX00742158_B:0xN0000000e&0xO0000000e_I:0xX00742158_M:0xQ00000011=24_Q:0xX0054a04c=1398099027_Q:0xH004f9470=250_Q:0xH0073b5ec=1_Q:0xM004fad6c=1_Q:0xX00745170!=36864_I:0xX00742158_A:0xH000007bc&223_O:0!=82_I:0xX00742158_A:0xH000007bd&223_O:0!=83_I:0xX00742158_A:0xH000007be&223_O:0!=84_I:0xX00742158_A:0xH000007bf&223_O:0!=65_I:0xX00742158_A:0xH000007c0&223_O:0!=82_I:0xX00742158_A:0xH000007c1&223_I:0xX00742158_A:0xH000007c2&223_Q:0!=0
			*/
		
		return 
		// ==== Core (Alt) Group ==== 
			// BUG_RATools - infinite processing error --> Manual creation via RAIntegration
			// prev(let_sumOf_AllWeaponFlags) < WEAPON_COUNT // <---2Lines--- Break RATools
			// && prev(let_sumOf_AllWeaponFlags) > WEAPON_COUNT - 14
			measured(let_sumOf_AllWeaponFlags == WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
					&& is_RStar_Cheat_inActive(enum_releaseRegion))
		}),
	"a_UpgradeAllWeapons": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		// NOTE: Trigger with DynamicBitset_PlayerProfileUnlocks not advised as the struct containing that bitset may temporarily be unloaded/reloaded during the StartChpMenu --> Results in not being able to trigger this achievement
		let_sumOf_AllWeaponFlags = achievements_generate_SumOf_FlagsAllUpgradedWeapons(enum_releaseRegion)
		return 
		// ==== Core (Alt) Logic Group ====
			prev(let_sumOf_AllWeaponFlags) < UPGRADEABLE_WEAPON_COUNT
			&& prev(let_sumOf_AllWeaponFlags) > UPGRADEABLE_WEAPON_COUNT - 11
			&& measured(let_sumOf_AllWeaponFlags == UPGRADEABLE_WEAPON_COUNT, 
				when = 
					is_ReleaseRegion(enum_releaseRegion) 
					&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
					&& !is_LogoScreenLoading(enum_releaseRegion) // ---2 Lines---> checks if a mission is being loaded. Necessary as otherwise RAmeasured may show up/or even trigger when Structs are reconstructed
					&& !is_AnimationLoading(enum_releaseRegion)
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
	"a_CompleteChapter22":					{"en": "Pact of Retribution"}, 
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
	"a_BountyHuntChapter18": 				{"en": "Buffalo Country"},
	"a_BountyHuntChapter20": 				{"en": "Plenty Forte"},
	"a_BountyHuntChapter21": 				{"en": "Reining In the Gilded Horse"},
	"a_BountyHuntChapter24": 				{"en": "Mr. Quickdraw"},
	"a_BountyHuntChapter25": 				{"en": "Showstopper"},
	"a_BountyHuntChapter27": 				{"en": "Diligent Fall"},
	"a_BountyCompletionAll": 				{"en": "Out for Blood"},

	"a_BigMoney":							{"en": "It Was Always About the Money"},
	"a_PerfectAccuracy":					{"en": "Deadeye"}, 
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
	"a_ChallengeChapter13":					{"en": "Hammers of the Gods"},
	"a_ChallengeChapter14":					{"en": "Carnage at Sunset"},
	"a_ChallengeChapter15":					{"en": "Roaring Bane"},
	"a_ChallengeChapter17": 				{"en": "Melee Minehem"},
	"a_ChallengeChapter19": 				{"en": "Bacon 'n Beans"},
	"a_ChallengeChapter20": 				{"en": "You Done Kill 'em All!"},
	"a_ChallengeChapter22":					{"en": "Ándale, Ándale!"},
	"a_ChallengeChapter24":					{"en": "High-Fashioned Cleanup"},
	"a_ChallengeChapter25":					{"en": "The Golden Triad"},
	"a_ChallengeChapter27":					{"en": "Bullet With a Name"},
	"a_WoodChapter8":						{"en": "Wood You Believe It?"},
	"a_WoodChapter10":						{"en": "Cremation at Sundawn"},

	"a_BountyHunterKatie":					{"en": "Remember Us?"},
	"a_BountyHunterBlade": 					{"en": "Sharp Shooter"},
	"a_BountyHunterAnnie": 					{"en": "Taking the Ranch Back"},
	"a_BountyHunterCooper": 				{"en": "Rolling Over the Law"},
	"a_BountyHunterWeapons": 				{"en": "Killer Collection"},
	"a_SundownFallingStar": 				{"en": "Tribal Warfare"},
	"a_SundownBlack": 						{"en": "Sound Undertaking"},
	"a_SundownGriffon": 					{"en": "I've Come To Finish the Job"},
	"a_SundownNate": 						{"en": "Harlow's Reckoning"},
	"a_SundownFlawless": 					{"en": "Untouchable at Twilight"},
	"a_HighNoonNatalie": 					{"en": "Professional Familiarity"}, // Reference to movie "Léon: The Professional" (1994)
	"a_HighNoonCurly": 						{"en": "Supplies Depleted, Trigger Repeated"},	

	"a_UnlockStagesAll": 					{"en": "Frontier Sojourn"},
	"a_UnlockCharactersHalf":				{"en": "The Gunslingers' Ensemble"},
	"a_UnlockCharactersAll":				{"en": "The Gunslingers' Enchilada"},
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
	"a_CompleteChapter1": 					{"en": "Valiantly hold the fort at Harlow's Home in Chapter 1, \"Bull's Eye\""},
	"a_CompleteChapter2":					{"en": "Tenderize Bloody Tom's beefy ambitions during the events of Chapter 2, \"Bounty Hunter\""},
	"a_CompleteChapter3":					{"en": "Neatly nix the Ugly Gang by the end of Chapter 3, \"Ugly Streetfight\""},
	"a_CompleteChapter5":					{"en": "Derail the Pedrosa Brothers' train heist during Chapter 5, \"Railroaded\""},
	"a_CompleteChapter6":					{"en": "Wrangle the dynamite-fiend during the events of Chapter 6, \"Carnival Life\""},
	"a_CompleteChapter7":					{"en": "Topple Perry's eccentric circus troupe in Chapter 7, \"Freak Show\""},
	"a_CompleteChapter8":					{"en": "Rein in Bad Bessie's gang of outlaws during Chapter 8, \"Rogue Valley\""},
	"a_CompleteChapter10":					{"en": "Close out all of Sheriff Bartlett's bounties by the end of Chapter 10, \"The Cemetery\""},
	"a_CompleteChapter11":					{"en": "Accomplish the defense of Annie's cattle from the raiders in Chapter 11, \"Range War\""},
	"a_CompleteChapter12":					{"en": "Survive a storm of fists, bottles and bullets during Chapter 12, \"Saloon Fight\""},
	"a_CompleteChapter13":					{"en": "Unearth the deceitful secrets behind Red's parents' fate by the end of Chapter 13, \"The Traitor\""},
	"a_CompleteChapter14":					{"en": "Disrupt an illicit gold operation during the events of Chapter 14, \"Sunset Canyon\""},
	"a_CompleteChapter15":					{"en": "Successfully navigate the twisting creek in Chapter 15, \"Bear Mountain\""},
	"a_CompleteChapter17": 					{"en": "Escape the labyrinth of the mines within Chapter 17, \"The Mine\""},
	"a_CompleteChapter19": 					{"en": "Make it to Brimstone by stagecoach during Chapter 19, \"Hell's Pass\""},
	"a_CompleteChapter20": 					{"en": "Bring down the senior officer donning the shoulder-mounted armcannon in Chapter 20, \"Fort Diego\""},
	"a_CompleteChapter22":					{"en": "Deal the final blow to the Renegade Army during Chapter 22, \"Devils and Angels\""},
	"a_CompleteChapter24":					{"en": "Emerge triumphant after vanquishing all Battle Royale adversaries in Chapter 24, \"Battle Finale\""},
	"a_CompleteChapter25":					{"en": "Breach the opulent manor within Chapter 25, \"The Siege\""},
	"a_CompleteChapter27":					{"en": "Conclude Red's story by completing Chapter 27, \"Fall From Grace\""},

	"a_BountyHuntChapter1": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 1, \"Bull's Eye\""},
	"a_BountyHuntChapter2": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 2, \"Bounty Hunter\""},
	"a_BountyHuntChapter3": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 3, \"Ugly Streetfight\""},
	"a_BountyHuntChapter5": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 5, \"Railroaded\""},
	"a_BountyHuntChapter6": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 6, \"Carnival Life\""},
	"a_BountyHuntChapter7": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 7, \"Freak Show\""},
	"a_BountyHuntChapter8": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 8, \"Rogue Valley\""},
	"a_BountyHuntChapter9": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 9, \"Ghost Town\""},
	"a_BountyHuntChapter11": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 11, \"Range War\""},
	"a_BountyHuntChapter12": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 12, \"Saloon Fight\""},
	"a_BountyHuntChapter13": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 13, \"The Traitor\""},
	"a_BountyHuntChapter14": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 14, \"Sunset Canyon\""},
	"a_BountyHuntChapter15": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 15, \"Bear Mountain\""},
	"a_BountyHuntChapter17": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 17, \"The Mine\""},
	"a_BountyHuntChapter18": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 18, \"Stagecoach\""},
	"a_BountyHuntChapter20": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 20, \"Fort Diego\""},
	"a_BountyHuntChapter21": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 21, \"End of the Line\""},
	"a_BountyHuntChapter24": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 24, \"Battle Finale\""},
	"a_BountyHuntChapter25": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 25, \"The Siege\""},
	"a_BountyHuntChapter27": 				{"en": "Complete the Bounty Hunter Mode challenge for Chapter 27, \"Fall From Grace\""},
	"a_BountyCompletionAll":				{"en": "Complete all Bounty Hunter Mode missions on one player profile"},

	"a_BigMoney":							{"en": "Amass a bank balance of $50,000 or more at the end of a singleplayer story mission"},
	"a_PerfectAccuracy":					{"en": "Achieve an accuracy rating of 90% or higher at the end of a singleplayer story mission without using your Deadeye ability"},
	"a_SaveCurly":							{"en": "Earn Curly Shaw's $1,500 reward for saving him during Chapter 8, \"Rogue Valley\""},
	"a_PerfectShootingTutorial": 			{"en": "Prove your shooting prowess in Chapter 1, \"Bull's Eye\", by finishing the shooting tutorial without wasting a single bullet and remaining stationary"},
	"a_ChallengeChapter1": 					{"en": "Complete Chapter 1, \"Bull's Eye\", on very hard difficulty, with a collected bounty of $1,000 or more"}, // WARNING - Manual creation via RAIntegration
	"a_ChallengeChapter2":					{"en": "Complete Chapter 2, \"Bounty Hunter\", on hard or very hard difficulty, sustaining less than 50% damage and with the \"No HUD\" cheat enabled"},
	"a_ChallengeChapter3":					{"en": "Complete Chapter 3, \"Ugly Streetfight\", on very hard difficulty, without picking up any healing items"},
	"a_ChallengeChapter5":					{"en": "Complete Chapter 5, \"Railroaded\", on hard or very hard difficulty, without stumbling off the train even once"},
	"a_ChallengeChapter6":					{"en": "In Chapter 6, \"Carnival Life\", on hard or very hard difficulty, achieve a 10-kill streak with the gatling gun in a single, uninterrupted burst without releasing the trigger"},
	"a_ChallengeChapter7":					{"en": "Complete Chapter 7, \"Freak Show\", on very hard difficulty, with an accuracy of 60% or better"},
	"a_ChallengeChapter8":					{"en": "Complete Chapter 8, \"Rogue Valley\", on very hard difficulty, with the \"Bite the Bullet\" cheat enabled"},
	"a_ChallengeChapter10":					{"en": "Complete Chapter 10, \"The Cemetery\", on hard or very hard difficulty, with the following cheats enabled: \"No Distortion\", \"Sad Stars\" and \"No HUD\""},
	"a_ChallengeChapter11":					{"en": "Complete Chapter 11, \"Range War\", on hard or very hard difficulty, dispatching 15 enemies while riding a bison"},
	"a_ChallengeChapter12":					{"en": "Complete Chapter 12, \"Saloon Fight\", on very hard difficulty, with at least 70% HP remaining at the end"},
	"a_ChallengeChapter13":					{"en": "Complete Chapter 13, \"The Traitor\", on hard or very hard difficulty, with at least 5 allied cannons remaining"},
	"a_ChallengeChapter14":					{"en": "Complete Chapter 14, \"Sunset Canyon\", on very hard difficulty, with less than 90% damage taken"},
	"a_ChallengeChapter15":					{"en": "Complete Chapter 15, \"Bear Mountain\", on very hard difficulty, using only the firearm \"Faith\" to damage Grizzly"},
	"a_ChallengeChapter17": 				{"en": "Complete Chapter 17, \"The Mine\", on hard or very hard difficulty, in under 1 minute, using only a knife to damage Ted and Tony"},
	"a_ChallengeChapter19": 				{"en": "Complete Chapter 19, \"Hell's Pass\", on hard or very hard difficulty, without letting the stagecoach's HP drop below 40% and using the \"Infinite Deadeye\" cheat as the only means of shooting"},
	"a_ChallengeChapter20": 				{"en": "Complete Chapter 20, \"Fort Diego\", on very hard difficulty, with 12 headshot kills"},
	"a_ChallengeChapter22":					{"en": "Complete Chapter 22, \"Devils and Angels\", on hard or very hard difficulty, in under 3 minutes, killing only General Diego"},
	"a_ChallengeChapter24":					{"en": "Complete Chapter 24, \"Battle Finale\", on very hard difficulty, with 5 headshots on Mr. Kelley and no bystander deaths"},
	"a_ChallengeChapter25":					{"en": "Complete Chapter 25, \"The Siege\", on hard or very hard difficulty, with the combined HP of all three heroes at 60% or above, and whilst using the \"Golden Gun\" cheat"},
	"a_ChallengeChapter27":					{"en": "Complete Chapter 27, \"Fall From Grace\", on very hard difficulty, sustaining less than 75% damage and achieving an accuracy of 60% or higher"},
	"a_WoodChapter8":						{"en": "Complete Chapter 8, \"Rogue Valley\", on Red Wood Revolver difficulty, with the \"Bite the Bullet\" cheat enabled"},
	"a_WoodChapter10":						{"en": "Complete Chapter 10, \"The Cemetery\", on Red Wood Revolver difficulty, using the \"Infinite Deadeye\" cheat as the only means of doing damage"},
	
	"a_BountyHunterKatie":					{"en": "As Katie O'Grady (P1), with Sheriff O'Grady (P2) as your ally win a $10,000 target Bounty Hunter match against a team of Ugly Chris (P3) and Gigolo Hancock (P4) on Widow's Patch"},
	"a_BountyHunterBlade": 					{"en": "As The Blade Slade (P1), win a free-for-all $10,000 target Bounty Hunter match against Sissy Fess (P2), Rico Pedrosa (P3) and Udo Kang (P4) in Sunset Canyon, using only knives"},
	"a_BountyHunterAnnie": 					{"en": "As Annie Stoakes (P1), win a $10,000 target Bounty Hunter match against a team of Governor Griffon (P2), Holstein Hal (P3) and Sam (P4) on The Ranch"},
	"a_BountyHunterCooper": 				{"en": "As Cooper (P1), win a $10,000 target Bounty Hunter match against a team of Jason Cornet (P2), Sheriff Bartlett (P3) and Buffalo Soldier (P4) on Fairground, with damage taken less than 888%"},
	"a_BountyHunterWeapons": 				{"en": "Win a 4 player free-for-all Bounty Hunter match, getting a kill with 7 different weapons"},
	"a_SundownFallingStar": 				{"en": "As Falling Star (P1), with Shadow Wolf (P2) as your ally, win a 5-minute Sundown match against a team of Grizzly (P3) and Standing Snake (P4) in Fallen Creek"},
	"a_SundownBlack": 						{"en": "As Mr. Black (P1), win a 5-minute free-for-all Sundown match against Bad Bessie (P2), Ugly Chris (P3) and Pig Josh (P4) in Ghost Town, with a death toll of at least 15"},
	"a_SundownGriffon": 					{"en": "As Governor Griffon (P1), win a 5-minute Sundown match in Broken Creek against a team of Nate Harlow (P2), Falling Star (P3), and Red (P4), collecting at least $15,000."},
	"a_SundownNate": 						{"en": "As Nate Harlow (P1), win a 5-minute Sundown match in The Mansion against a team of Governor Griffon (P2), Colonel Daren (P3), and General Diego (P4), with 70% accuracy or higher and at least $10,000 collected"},
	"a_SundownFlawless": 					{"en": "Win a 1-minute Sundown match against a team of 3 enemies without dying and killing each enemy at least once"},
	"a_HighNoonNatalie": 					{"en": "As Natalie (P1), complete a first-to-5 free-for-all High Noon match on Mansion Grounds against Mr. Kelley (P2), Red Jr. (P3), and Nate Harlow (P4). Achieve at least 3 kills, with either Natalie or Mr. Kelley winning the match"},
	"a_HighNoonCurly": 						{"en": "As Curly Shaw (P1), win a first-to-5 free-for-all High Noon match on Twin Rocks against Bloody Tom (P2), Big Oaf Whitney (P3), and Twiggy Phelps (P4), scoring at least 5 headshots"},

	"a_UnlockStagesAll": 					{"en": "Unlock all Showdown stages"},
	"a_UnlockCharactersHalf":				{"en": "Unlock half the Showdown characters"},
	"a_UnlockCharactersAll":				{"en": "Unlock all Showdown characters"},
	"a_CompleteJournalHalf":				{"en": "Unlock half of Sheriff Bartlett's journal"},
	"a_CompleteJournalAll":					{"en": "Complete Sheriff Bartlett's journal"},
	"a_MaxHealth":							{"en": "Max out Red's health in the story campaign"},
	"a_MaxDeadEye":							{"en": "Max out Red's Deadeye in the story campaign"},
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
	"rp_Showdown_Multiplayer":							{"en": "Playing a {0} Multiplayer match {1} | {2} {3} 1 as {4} | {5} {6} 2 as {7} | {8} {9} 3 as {10} | {11} {12} 4 as {13}"}, // TODO implement this line with 3-2 players; This line only works with 4 players 
	"rp_Showdown_HighNoon":								{"en": "Playing as {0} in a High Noon Showdown match {1}, vs CPU | Rounds Won: {2}/{3}"},
	"rp_Showdown_Sundown":								{"en": "Playing as {0} in a Sundown Showdown match {1}, vs CPU | ${2} collected | Time left: {3}"},
	"rp_Showdown_BountyHunt":							{"en": "Playing as {0} in a Bounty Hunter Showdown match {1}, vs CPU | ${2}/{3} collected"},
	"rp_Showdown_Default":								{"en": "Playing as {0} in a Showdown match {1}, vs CPU"},
	"rp_BountyHunterMode_AreaShortID":					{"en": "Chapter {0} on Bounty Hunter Mode | Journal: __rpp_JournalCompletionRate__%"},
	"rp_BountyHunterMode_AreaLongID":					{"en": "Chapter {0} on Bounty Hunter Mode | Journal: __rpp_JournalCompletionRate__%"},
	"rp_Story_Brimstone":								{"en": "Time off at Brimstone | Journal: __rpp_JournalCompletionRate__%"},
	"rp_Story_AreaShortID":								{"en": "Chapter {0} on {1} | Journal: __rpp_JournalCompletionRate__%"},
	"rp_Story_AreaLongID":								{"en": "Chapter {0} on {1} | Journal: __rpp_JournalCompletionRate__%"},
	"rp_MainMenu":										{"en": "Red Dead Revolver: Main Menu | Journal: __rpp_JournalCompletionRate__%"},
	"rp_DefaultPlus":									{"en": "Playing Red Dead Revolver | Journal: __rpp_JournalCompletionRate__%"},
	"rp_Default":										{"en": "Playing Red Dead Revolver"}}
richPresence_LookupTablesText = {
	// "lup_Template": {
	// 	"LOOKUP_FALLBACK": 			{"en": "xxxxxxx"},
	//
	// 	"AAA": 						{"en": "xxxxxxx"},
	// 	"BBB":						{"en": "xxxxxxx"},
	// 	"CCC": 						{"en": "xxxxxxx"},
	// },

	"lup_Showdown_HighNoon_RoundsRequiredToWin": {
		"1rounds": 	{"en": "1"},
		"3rounds": 	{"en": "3"},
		"5rounds": 	{"en": "5"},
		"7rounds": 	{"en": "7"},
		"10rounds": {"en": "10"},
		},
	"lup_Showdown_BountyHunt_MoneyToCollect": {
		"3K": 	{"en": "3000"},
		"5K": 	{"en": "5000"},
		"10K": 	{"en": "10000"},
		"15K": 	{"en": "15000"},
		"20K": 	{"en": "20000"},
		},
	"lup_ShowdownTeam": {
		"RED": 		{"en": "🔴"},
		"WHITE": 	{"en": "🔘"},
		"BLUE": 	{"en": "🔵"},
		"YELLOW": 	{"en": "🟡"},
		},
	"lup_ShowdownMode": {
		"LOOKUP_FALLBACK": 	{"en": "Showdown"},

		"BountyHunter":  	{"en": "Bounty Hunter"},
		"Sundown":  		{"en": "Sundown"},
		"HighNoon":  		{"en": "High Noon"}, 
		},
	"lup_IsHumanOrCPUPlayer": {
		"CPU": 					{"en": "CPU"},
		"Human":				{"en": "Player"},
		},
	"lup_CharacterName": {
		"LOOKUP_FALLBACK": 				{"en": "a gunslinger"},
		
		"GeneralDiego": 				{"en": "General Diego"},
		"MrKelley": 					{"en": "Mr. Kelley"},
		"JackSwift": 					{"en": "Jack Swift"},
		"WhiskeyTreadwell":				{"en": "'Whiskey' Treadwell"},
		"HedgehogThornton": 			{"en": "'Hedgehog' Thornton"},
		"AnnieStoakes": 				{"en": "Annie Stoakes"},
		"KatieGrady": 					{"en": "Katie O'Grady"},
		"UglyChris": 					{"en": "'Ugly' Chris"},
		"SmileyFawler": 				{"en": "'Smiley' Fawler"},
		"GigoloHancock": 				{"en": "'Gigolo' Hancock"},
		"ProfessorPerry": 				{"en": "Professor Perry"},
		"BladeSlade": 					{"en": "The 'Blade' Slade"},
		"GabrialNavarro": 				{"en": "Gabrial Navarro"},
		"SheriffGrady": 				{"en": "Sheriff O'Grady"},
		"SheriffBartlett": 				{"en": "Sheriff Bartlett"},
		"HolsteinHal": 					{"en": "Holstein Hal"},
		"Cooper": 						{"en": "Cooper"},
		"GovernorGriffon": 				{"en": "Governor Griffon"},
		"JasonCornet": 					{"en": "Jason Cornet"},
		"BuffaloSoldier": 				{"en": "Buffalo Soldier"},
		"Smitty": 						{"en": "Smitty"},
		"FallingStar": 					{"en": "Falling Star"},
		"Sam": 							{"en": "Sam"},
		"Dan": 							{"en": "Dan"},
		"MannyQuinn": 					{"en": "Manny Quinn"},
		"Grizzly": 						{"en": "Grizzly"},
		"StandingSnake": 				{"en": "Standing Snake"},
		"MrBlack": 						{"en": "Mr. Black"},
		"ShadowWolf": 					{"en": "Shadow Wolf"},
		"BadBessie": 					{"en": "Bad Bessie"},
		"PigJosh": 						{"en": "'Pig' Josh"},
		"DigFowler": 					{"en": "'Dig' Fowler"},
		"NateHarlow": 					{"en": "Nate Harlow"},
		"ColonelDaren": 				{"en": "Colonel Daren"},
		"Natalie": 						{"en": "Natalie"},
		"RedJr": 						{"en": "Red Jr."},
		"Fidgit": 						{"en": "Fidgit"},
		"Christina": 					{"en": "Christina"},
		"KidCougar": 					{"en": "'Kid' Cougar"},
		"Red": 							{"en": "Red"},
		"CurlyShaw": 					{"en": "'Curly' Shaw"},
		"BloodyTom":					{"en": "'Bloody' Tom"},
		"Chicken": 						{"en": "Chicken"},
		"BigOaf": 						{"en": "'Big Oaf' Whitney"},
		"TwiggyPhelps":					{"en": "'Twiggy' Phelps"},
		"SissyFess": 					{"en": "'Sissy' Fess"},
		"RicoPedrosa": 					{"en": "Rico Pedrosa"},
		"UdoKang": 						{"en": "Udo Kang"},
		},
	"lup_StoryChapter_ShortID": {
		"Stagecoach": 				{"en": "18, \"Stagecoach\","},
		"BountyHunter": 			{"en": "2, \"Bounty Hunter\","},
		"RogueValley":				{"en": "8, \"Rogue Valley\","},
		"Jailbreak":				{"en": "16, \"Jailbreak\","},
		"FortDiego":				{"en": "20, \"Fort Diego\","},
		"Siege":					{"en": "25, \"The Siege\","},
		"SunsetCanyon":				{"en": "14, \"Sunset Canyon\","},
		"CarnivalLife":				{"en": "6, \"Carnival Life\","},
		"RangeWar":					{"en": "11, \"Range War\","},
		"EndOfTheLine":				{"en": "21, \"End Of The Line\","},
		"BearMountain":				{"en": "15, \"Bear Mountain\""}
		},
	"lup_StoryChapter_LongID": {
		"TheTraitor":  				{"en": "13, \"The Traitor\","},
		"HellPass":  				{"en": "19, \"Hell Pass\","},
		"UglyStreetFight":  		{"en": "3, \"Ugly StreetFight\","},
		"BullsEye":  				{"en": "1, \"Bull's Eye\","},
		"BattleRoyale":  			{"en": "23, \"Battle Royale\","},
		"TheMine":  				{"en": "17, \"The Mine\","},
		"SaloonFight":  			{"en": "12, \"Saloon Fight\","},
		"TheCemetery":  			{"en": "10, \"The Cemetery\","},
		"FallFromGrace":  			{"en": "27, \"Fall From Grace\","},
		"HouseOfCards":  			{"en": "26, \"House Of Cards\","},
		"BattleFinale":  			{"en": "24, \"Battle Finale\","},
		"Traincar":  				{"en": "4, \"Traincar\","},
		"DevilsAndAngels":  		{"en": "22, \"Devils And Angels\","},
		"FreakShow":  				{"en": "7, \"Freak Show\","},
		"GhostTown":  				{"en": "9, \"Ghost Town\","},
		"Railroaded":  				{"en": "5, \"Railroaded\","},
		},
	
	"lup_StoryDifficulty": {
		"Normal": 						{"en": "Normal"},
		"Hard":							{"en": "Hard"},
		"VeryHard": 					{"en": "Very Hard"},
		"RedWoodRevolver": 				{"en": "Red Wood Revolver"},
		"BountyHunterMode": 			{"en": "Bounty Hunter Mode"},
		},
	"lup_ShowdownStage": {
		"LOOKUP_FALLBACK": 			{"en": "in the \"Wild West\""},

		"TheBridge":				{"en": "at \"The Bridge\""},
		"TheMine":					{"en": "at \"The Mine\""},
		"WidowsPatch":				{"en": "at \"Widow's Patch\""},
		"TheRanch":					{"en": "at \"The Ranch\""},
		"Fairground":				{"en": "at \"Fairground\""},
		"FallenCreek":				{"en": "at \"Fallen Creek\""},
		"GhostTown":				{"en": "at \"Ghost Town\""},
		"SunsetCanyon":				{"en": "at \"Sunset Canyon\""},
		"BrokenCreek":				{"en": "at \"Boyhood Home\""},
		"MansionGrounds":			{"en": "at \"Tended Gardens\""},
		"TheMansion":				{"en": "at \"Opulent Palace\""},
		"TwinRocks":				{"en": "at \"Twin Rocks\""},
		"DesertFortress":			{"en": "at \"Desert Fortress\""},
		},
	
	}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	"lup_Showdown_HighNoon_RoundsRequiredToWin": {
		SHOWDOWN_HIGH_NOON_REQUIRED_WINS_1: "1rounds", 
		SHOWDOWN_HIGH_NOON_REQUIRED_WINS_3: "3rounds",
		SHOWDOWN_HIGH_NOON_REQUIRED_WINS_5: "5rounds",
		SHOWDOWN_HIGH_NOON_REQUIRED_WINS_7: "7rounds",
		SHOWDOWN_HIGH_NOON_REQUIRED_WINS_10: "10rounds",
		},
	"lup_Showdown_BountyHunt_MoneyToCollect": {
		SHOWDOWN_BOUNTY_LIMIT_3K: "3K",
		SHOWDOWN_BOUNTY_LIMIT_5K: "5K",
		SHOWDOWN_BOUNTY_LIMIT_10K: "10K",
		SHOWDOWN_BOUNTY_LIMIT_15K: "15K",
		SHOWDOWN_BOUNTY_LIMIT_20K: "20K",
		},
	"lup_ShowdownTeam": {
		SHOWDOWN_TEAM_RED: 	"RED",
		SHOWDOWN_TEAM_WHITE: "WHITE",
		SHOWDOWN_TEAM_BLUE: "BLUE",
		SHOWDOWN_TEAM_YELLOW: "YELLOW",
		},
	"lup_ShowdownMode": {
		SHOWDOWN_MODE_BountyHunter: "BountyHunter",
		SHOWDOWN_MODE_Sundown: "Sundown",
		SHOWDOWN_MODE_HighNoon: "HighNoon",
		},
	"lup_IsHumanOrCPUPlayer": {
		// Any other string: "CPU",			as LOOKUP_FALLBACK	
		memUtil_asciiStringToHex(substring(SHOWDOWN_AI_SETTING_HumanPlayer, 0, 4)): "Human",
		},
	"lup_StoryDifficulty": {
		DIFFICULTY_Normal: "Normal",
		DIFFICULTY_Hard: "Hard",
		DIFFICULTY_VeryHard: "VeryHard",
		DIFFICULTY_RedWoodRevolver: "RedWoodRevolver"
		},
	"lup_ShowdownStage": {
		/* LookUpKeys
			brid // bridge2
			coac // coach2
			core // core2
			flas // flash2
			fort // fort2
			ghos // ghost2
			gun2 // gun2
			hng2 // hng2
			int2 // int2
			mans // mans2
			perf // perf2
			ranc // ranch2
			sher // shernit2
		*/
		get_AreaShowdown_InnerId(AREA_Showdown_TheBridge): "TheBridge",
		get_AreaShowdown_InnerId(AREA_Showdown_TheMine): "TheMine",
		get_AreaShowdown_InnerId(AREA_Showdown_WidowsPatch): "WidowsPatch",
		get_AreaShowdown_InnerId(AREA_Showdown_TheRanch): "TheRanch",
		get_AreaShowdown_InnerId(AREA_Showdown_Fairground): "Fairground",
		get_AreaShowdown_InnerId(AREA_Showdown_FallenCreek): "FallenCreek",
		get_AreaShowdown_InnerId(AREA_Showdown_GhostTown): "GhostTown",
		get_AreaShowdown_InnerId(AREA_Showdown_SunsetCanyon): "SunsetCanyon",
		get_AreaShowdown_InnerId(AREA_Showdown_BrokenCreek): "BrokenCreek",
		get_AreaShowdown_InnerId(AREA_Showdown_MansionGrounds): "MansionGrounds",
		get_AreaShowdown_InnerId(AREA_Showdown_TheMansion): "TheMansion",
		get_AreaShowdown_InnerId(AREA_Showdown_TwinRocks): "TwinRocks",
		get_AreaShowdown_InnerId(AREA_Showdown_DesertFortress): "DesertFortress",
		},

	"lup_StoryChapter_ShortID": { // InnerIDs < 6 characters long
		/*	5 characters or less
			bom // bomb
			coa // coach
			cor // core
			for // fort
			gho // ghost
			hng // hng
			ran // ranch
			tom // tomb
			tra // train
			woo // woods
			msn // msn
			man // mans		
		*/
		get_AreaCampaign_ShortInnerId(AREA_Campaign_SunsetCanyon): "SunsetCanyon",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_BearMountain): "BearMountain",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_CarnivalLife): "CarnivalLife",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_RangeWar): "RangeWar",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_EndOfTheLine): "EndOfTheLine",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_RogueValley): "RogueValley",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_Jailbreak): "Jailbreak",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_FortDiego): "FortDiego",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_Siege): "Siege",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_Stagecoach): "Stagecoach",  
		get_AreaCampaign_ShortInnerId(AREA_Campaign_BountyHunter): "BountyHunter",  
		},
	"lup_StoryChapter_LongID": { // InnerIDs >= 6 characters long
		/* 6 characters or more
			idg // bridge
			rfn // perfnew
			rfi // barfight
			met // cemetery
			nsm // gunsmoke
			ain // trainend
			ain // traingood
			ain // traincar
			nsi // mansintb
			nsr // mansroof
			er7 // sher70
			ern // shernite
			ydu // roydusk
			yfi // royfinal
			ren // corenew
			ncy // msncyn
		*/
		get_AreaCampaign_LongInnerId(AREA_Campaign_TheTraitor): "TheTraitor",
		get_AreaCampaign_LongInnerId(AREA_Campaign_HellPass): "HellPass",
		get_AreaCampaign_LongInnerId(AREA_Campaign_UglyStreetFight): "UglyStreetFight",
		get_AreaCampaign_LongInnerId(AREA_Campaign_BullsEye): "BullsEye",
		get_AreaCampaign_LongInnerId(AREA_Campaign_BattleRoyale): "BattleRoyale",
		get_AreaCampaign_LongInnerId(AREA_Campaign_TheMine): "TheMine",
		get_AreaCampaign_LongInnerId(AREA_Campaign_Traincar): "Traincar",
		get_AreaCampaign_LongInnerId(AREA_Campaign_FreakShow): "FreakShow",
		get_AreaCampaign_LongInnerId(AREA_Campaign_GhostTown): "GhostTown",
		get_AreaCampaign_LongInnerId(AREA_Campaign_TheCemetery): "TheCemetery",
		get_AreaCampaign_LongInnerId(AREA_Campaign_SaloonFight): "SaloonFight",
		get_AreaCampaign_LongInnerId(AREA_Campaign_DevilsAndAngels): "DevilsAndAngels",
		get_AreaCampaign_LongInnerId(AREA_Campaign_BattleFinale): "BattleFinale",
		get_AreaCampaign_LongInnerId(AREA_Campaign_HouseOfCards): "HouseOfCards",
		get_AreaCampaign_LongInnerId(AREA_Campaign_FallFromGrace): "FallFromGrace",
		get_AreaCampaign_LongInnerId(AREA_Campaign_Railroaded): "Railroaded",
		},	
	"lup_CharacterName": { 
		get_CharacterID_asHex(CHARACTER_AnnieStoakes): "AnnieStoakes", 
		get_CharacterID_asHex(CHARACTER_BadBessie): "BadBessie", 
		get_CharacterID_asHex(CHARACTER_BigOaf): "BigOaf", 
		get_CharacterID_asHex(CHARACTER_BladeSlade): "BladeSlade", 
		get_CharacterID_asHex(CHARACTER_BloodyTom): "BloodyTom", 
		get_CharacterID_asHex(CHARACTER_BuffaloSoldier): "BuffaloSoldier", 
		get_CharacterID_asHex(CHARACTER_Chicken): "Chicken", 
		get_CharacterID_asHex(CHARACTER_Christina): "Christina", 
		get_CharacterID_asHex(CHARACTER_ColonelDaren): "ColonelDaren", 
		get_CharacterID_asHex(CHARACTER_Cooper): "Cooper", 
		get_CharacterID_asHex(CHARACTER_CurlyShaw): "CurlyShaw", 
		get_CharacterID_asHex(CHARACTER_DigFowler): "DigFowler", 
		get_CharacterID_asHex(CHARACTER_FallingStar): "FallingStar", 
		get_CharacterID_asHex(CHARACTER_Fidgit): "Fidgit", 
		get_CharacterID_asHex(CHARACTER_GabrialNavarro): "GabrialNavarro", 
		get_CharacterID_asHex(CHARACTER_GeneralDiego): "GeneralDiego", 
		get_CharacterID_asHex(CHARACTER_GigoloHancock): "GigoloHancock", 
		get_CharacterID_asHex(CHARACTER_GovernorGriffon): "GovernorGriffon", 
		get_CharacterID_asHex(CHARACTER_Grizzly): "Grizzly", 
		get_CharacterID_asHex(CHARACTER_HedgehogThornton): "HedgehogThornton", 
		get_CharacterID_asHex(CHARACTER_HolsteinHal): "HolsteinHal", 
		get_CharacterID_asHex(CHARACTER_JackSwift): "JackSwift", 
		get_CharacterID_asHex(CHARACTER_JasonCornet): "JasonCornet", 
		get_CharacterID_asHex(CHARACTER_KatieGrady): "KatieGrady", 
		get_CharacterID_asHex(CHARACTER_KidCougar): "KidCougar", 
		get_CharacterID_asHex(CHARACTER_MannyQuinn): "MannyQuinn", 
		get_CharacterID_asHex(CHARACTER_MrBlack): "MrBlack", 
		get_CharacterID_asHex(CHARACTER_MrKelley): "MrKelley", 
		get_CharacterID_asHex(CHARACTER_Natalie): "Natalie", 
		get_CharacterID_asHex(CHARACTER_NateHarlow): "NateHarlow", 
		get_CharacterID_asHex(CHARACTER_PigJosh): "PigJosh", 
		get_CharacterID_asHex(CHARACTER_ProfessorPerry): "ProfessorPerry", 
		get_CharacterID_asHex(CHARACTER_Red): "Red", 
		get_CharacterID_asHex(CHARACTER_RedJr): "RedJr", 
		get_CharacterID_asHex(CHARACTER_RicoPedrosa): "RicoPedrosa", 
		get_CharacterID_asHex(CHARACTER_Sam): "Sam", 
		get_CharacterID_asHex(CHARACTER_Dan): "Dan", 
		get_CharacterID_asHex(CHARACTER_ShadowWolf): "ShadowWolf", 
		get_CharacterID_asHex(CHARACTER_SheriffBartlett): "SheriffBartlett", 
		get_CharacterID_asHex(CHARACTER_SheriffGrady): "SheriffGrady", 
		get_CharacterID_asHex(CHARACTER_SissyFess): "SissyFess", 
		get_CharacterID_asHex(CHARACTER_SmileyFawler): "SmileyFawler", 
		get_CharacterID_asHex(CHARACTER_Smitty): "Smitty", 
		get_CharacterID_asHex(CHARACTER_StandingSnake): "StandingSnake", 
		get_CharacterID_asHex(CHARACTER_TwiggyPhelps): "TwiggyPhelps", 
		get_CharacterID_asHex(CHARACTER_UdoKang): "UdoKang", 
		get_CharacterID_asHex(CHARACTER_UglyChris): "UglyChris", 
		get_CharacterID_asHex(CHARACTER_WhiskeyTreadwell): "WhiskeyTreadwell"
		},
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

// =========================
// • RichPresence DISPLAYS •
// =========================
function rp_Showdown_HighNoon(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_long(enum_releaseRegion)	
		&& is_Showdown_Mode(SHOWDOWN_MODE_HighNoon, enum_releaseRegion)
		&& is_ShowdownPlayer_Human(1, enum_releaseRegion) // <--4 Lines--- Checks if playing solo, without other HumanPlayer
		&& is_ShowdownPlayer_CPU(2, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(3, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(4, enum_releaseRegion)
		&& current_ShowdownPlayer_HighNoonRoundsWon(1, enum_releaseRegion) <= SHOWDOWN_HIGH_NOON_REQUIRED_WINS_10 // ---> Bugfix: when playing Showdown for first time after game startup, some pointer are not yet initialized, rpp_ShowdownPlayer1_HighNoonRoundsWon may show weird numbers 

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Showdown_HighNoon"),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ShowdownStage", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_HighNoonRoundsWon", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Showdown_HighNoon_RoundsRequiredToWin", enum_releaseRegion) // 3
	)}

function rp_Showdown_Sundown(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_long(enum_releaseRegion)	
		&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion)
		&& is_ShowdownPlayer_Human(1, enum_releaseRegion) // <--4 Lines--- Checks if playing solo, without other HumanPlayer
		&& is_ShowdownPlayer_CPU(2, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(3, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(4, enum_releaseRegion)
		&& current_ShowdownPlayer_CashCollected(1, enum_releaseRegion) <= 999999 // ---> Bugfix: when playing Showdown for first time after game startup, some pointer are not yet initialized, rpp_ShowdownPlayer1_HighNoonRoundsWon may show weird numbers; 999 999 cash is max displayable value

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Showdown_Sundown"),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ShowdownStage", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Cash", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_CountdownTimer", enum_releaseRegion) // 3
	)}

function rp_Showdown_BountyHunt(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_long(enum_releaseRegion)	
		&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)
		&& is_ShowdownPlayer_Human(1, enum_releaseRegion) // <--4 Lines--- Checks if playing solo, without other HumanPlayer
		&& is_ShowdownPlayer_CPU(2, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(3, enum_releaseRegion)
		&& is_ShowdownPlayer_CPU(4, enum_releaseRegion)		
		&& current_ShowdownPlayer_CashCollected(1, enum_releaseRegion) <= 999999 // ---> Bugfix: when playing Showdown for first time after game startup, some pointer are not yet initialized, rpp_ShowdownPlayer1_HighNoonRoundsWon may show weird numbers; 999 999 cash is max displayable value


	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Showdown_BountyHunt"),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ShowdownStage", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Cash", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_Showdown_BountyHunt_MoneyToCollect", enum_releaseRegion) // 3
	)}

function rp_Showdown_Multiplayer(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_long(enum_releaseRegion)
		&& tally(2, [ // <--Tally-- check if there is more than 1 HumanPlayer
			once(never(!is_ShowdownPlayer_Human(1, enum_releaseRegion)) &&
				is_ShowdownPlayer_Human(1, enum_releaseRegion)),
			once(never(!is_ShowdownPlayer_Human(2, enum_releaseRegion)) &&
				is_ShowdownPlayer_Human(3, enum_releaseRegion)),
			once(never(!is_ShowdownPlayer_Human(3, enum_releaseRegion)) &&
				is_ShowdownPlayer_Human(3, enum_releaseRegion)),
			once(never(!is_ShowdownPlayer_Human(4, enum_releaseRegion)) &&
				is_ShowdownPlayer_Human(4, enum_releaseRegion)),
		])

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Showdown_Multiplayer"),
		richPresence_callParameterFunction("rpp_ShowdownMode", enum_releaseRegion), // 0
		richPresence_callParameterFunction("rpp_ShowdownStage", enum_releaseRegion), // 1
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Team", enum_releaseRegion), // 2
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_IsHumanOrCPUPlayer", enum_releaseRegion), // 3
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion), // 4
		richPresence_callParameterFunction("rpp_ShowdownPlayer2_Team", enum_releaseRegion), // 5
		richPresence_callParameterFunction("rpp_ShowdownPlayer2_IsHumanOrCPUPlayer", enum_releaseRegion), // 6
		richPresence_callParameterFunction("rpp_ShowdownPlayer2_Character", enum_releaseRegion), // 7
		richPresence_callParameterFunction("rpp_ShowdownPlayer3_Team", enum_releaseRegion), // 8
		richPresence_callParameterFunction("rpp_ShowdownPlayer3_IsHumanOrCPUPlayer", enum_releaseRegion), // 9
		richPresence_callParameterFunction("rpp_ShowdownPlayer3_Character", enum_releaseRegion), // 10
		richPresence_callParameterFunction("rpp_ShowdownPlayer4_Team", enum_releaseRegion), // 11
		richPresence_callParameterFunction("rpp_ShowdownPlayer4_IsHumanOrCPUPlayer", enum_releaseRegion), // 12
		richPresence_callParameterFunction("rpp_ShowdownPlayer4_Character", enum_releaseRegion) // 13
	)}

function rp_Showdown_Default(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_long(enum_releaseRegion)

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Showdown_Default"),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_ShowdownStage", enum_releaseRegion)
	)}

function rp_BountyHunterMode_AreaShortID(enum_releaseRegion) { // InnerIDs < 6 characters long
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_BountyHunterMode(enum_releaseRegion)
		&& tally(1, [
			// shorter than 3, doesn't exist
			once(never(!is_Area_InnerIdLength(3, enum_releaseRegion)) && 
				is_Area_InnerIdLength(4, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(4, enum_releaseRegion)) && 
				is_Area_InnerIdLength(4, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(5, enum_releaseRegion)) && 
				is_Area_InnerIdLength(5, enum_releaseRegion)),
			])

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_BountyHunterMode_AreaShortID"),
		richPresence_callParameterFunction("rpp_StoryChapter_ShortInnerID", enum_releaseRegion)
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}
function rp_BountyHunterMode_AreaLongID(enum_releaseRegion) { // InnerIDs >= 6 characters long
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& is_Playing_BountyHunterMode(enum_releaseRegion)
		&& tally(1, [
			once(never(!is_Area_InnerIdLength(6, enum_releaseRegion)) && 
				is_Area_InnerIdLength(6, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(7, enum_releaseRegion)) && 
				is_Area_InnerIdLength(7, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(8, enum_releaseRegion)) && 
				is_Area_InnerIdLength(8, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(9, enum_releaseRegion)) && 
				is_Area_InnerIdLength(9, enum_releaseRegion)),
			// longer than 9, doesn't exist
			])

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_BountyHunterMode_AreaLongID"),
		richPresence_callParameterFunction("rpp_StoryChapter_LongInnerID", enum_releaseRegion)
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_Story_Brimstone(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& !is_Playing_BountyHunterMode_short(enum_releaseRegion)
		&& is_Area(AREA_Campaign_Brimstone, enum_releaseRegion)

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Story_Brimstone")
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_Story_AreaShortID(enum_releaseRegion) { // InnerIDs < 6 characters long
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& !is_Playing_BountyHunterMode_short(enum_releaseRegion)
		&& tally(1, [
			// shorter than 3, doesn't exist
			once(never(!is_Area_InnerIdLength(3, enum_releaseRegion)) && 
				is_Area_InnerIdLength(4, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(4, enum_releaseRegion)) && 
				is_Area_InnerIdLength(4, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(5, enum_releaseRegion)) && 
				is_Area_InnerIdLength(5, enum_releaseRegion)),
			])

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Story_AreaShortID"),
		richPresence_callParameterFunction("rpp_StoryChapter_ShortInnerID", enum_releaseRegion), 
		richPresence_callParameterFunction("rpp_StoryDifficulty", enum_releaseRegion)
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_Story_AreaLongID(enum_releaseRegion) { // InnerIDs >= 6 characters long
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_SinglePlayerCampaign(enum_releaseRegion)
		&& !is_Playing_BountyHunterMode_short(enum_releaseRegion)
		&& tally(1, [
			once(never(!is_Area_InnerIdLength(6, enum_releaseRegion)) && 
				is_Area_InnerIdLength(6, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(7, enum_releaseRegion)) && 
				is_Area_InnerIdLength(7, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(8, enum_releaseRegion)) && 
				is_Area_InnerIdLength(8, enum_releaseRegion)),
			once(never(!is_Area_InnerIdLength(9, enum_releaseRegion)) && 
				is_Area_InnerIdLength(9, enum_releaseRegion)),
			// longer than 9, doesn't exist
			])

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_Story_AreaLongID"),
		richPresence_callParameterFunction("rpp_StoryChapter_LongInnerID", enum_releaseRegion), 
		richPresence_callParameterFunction("rpp_StoryDifficulty", enum_releaseRegion)
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_BountyHuntShowdown_First(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_Playing_ShowdownMode_short(enum_releaseRegion)
		&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_BountyHuntShowdown_First"),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Character", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_ShowdownPlayer1_Cash", enum_releaseRegion)
	)}

function rp_MainMenu(enum_releaseRegion) {
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
		&& is_AtMainMenu(enum_releaseRegion)
		&& is_Area(AREA_MainMenu, enum_releaseRegion)

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_MainMenu") 
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)

	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus") 
		// richPresence_callParameterFunction("rpp_JournalCompletionRate", enum_releaseRegion)) // DISABLED - MANUAL_CONSTRUCTION of rpp_JournalCompletionRate: Copy/Paste serialized logic manually into script
	)}

function rp_Default() {
	return rich_presence_display(	
		richPresence_getText("rp_Default"))
	}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		rp_Showdown_Multiplayer(enum_releaseRegion)  // VERIFIED - Is only displayed when more than 1 human player is present
		rp_Showdown_HighNoon(enum_releaseRegion) // VERIFIED
		rp_Showdown_Sundown(enum_releaseRegion) // VERIFIED
		rp_Showdown_BountyHunt(enum_releaseRegion) // VERIFIED
		rp_Showdown_Default(enum_releaseRegion) // VERIFIED
		rp_BountyHunterMode_AreaShortID(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_BountyHunterMode_AreaLongID(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_Story_Brimstone(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_Story_AreaShortID(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_Story_AreaLongID(enum_releaseRegion) // VERIFIED// MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_MainMenu(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
		rp_DefaultPlus(enum_releaseRegion) // VERIFIED // MANUAL_CONSTRUCTION - rpp_JournalCompletionRate via Remember/Recall
	}} 

// ===========================
// • RichPresence PARAMETERS •
// ===========================
richPresence_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_LOOKUP = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_MACRO = 3		// rich_presence_macro(macro, expression)
// -------------------------------------
function rpp_JournalCompletionRate(enum_releaseRegion) => 
	achievements_generate_SumOf_FlagsAllPages(enum_releaseRegion) 
	/* MANUAL_CONSTRUCTION 
		// DEV_NOTE: Serialized logic Copy/Paste
		//	- With RAIntegration UI, copying any code from the "Achievement Editor" window --> copies the serialized logic
		//		this can be used to quickly copy/paste Serialized Logic for MANUAL_CONSTRUCTION, from the rascript to the "Achievement Editor" window

		-> Defined Logic (generated via a dummy leaderboard --> Copy Def):
			AddSource	Mem		Bit0	0xFirstFlag
			AddSource 	SumOf_FlagsAllPages()
			AddSource	Mem		Bit0	0xLastFlag
			Remember	Float			0.0
			Remember	Recall						/ Float	137.0
			Remember	Recall						* Float	100.0
			Measured	Recall


		===== Copy Serialized Logic here ---overwrite-->  __rpp_JournalCompletionRate__ (in Rich.txt) =====

		-> Serialized Logic (PAL) - wrapped inside Macro.Number
			@Number(A:0xO007405cd_A:0xP007405cd_A:0xQ007405cd_A:0xR007405cd_A:0xS007405cd_A:0xT007405cd_A:0xK007405ce_A:0xM007405cf_A:0xN007405cf_A:0xP007405cf_A:0xQ007405cf_A:0xR007405cf_A:0xS007405cf_A:0xT007405cf_A:0xM007405d0_A:0xN007405d0_A:0xP007405d0_A:0xR007405d0_A:0xS007405d0_A:0xT007405d0_A:0xM007405d1_A:0xN007405d1_A:0xO007405d1_A:0xP007405d1_A:0xQ007405d1_A:0xS007405d1_A:0xT007405d1_A:0xM007405d2_A:0xN007405d2_A:0xO007405d2_A:0xR007405d2_A:0xT007405d2_A:0xK007405d3_A:0xK007405d4_A:0xK007405d5_A:0xK007405d6_A:0xK007405d7_A:0xK007405d8_A:0xN007405d9_A:0xO007405d9_A:0xP007405d9_A:0xQ007405d9_A:0xR007405d9_A:0xS007405d9_A:0xT007405d9_A:0xM007405da_A:0xN007405da_A:0xO007405da_A:0xQ007405da_A:0xR007405da_A:0xS007405da_A:0xT007405da_A:0xM007405db_A:0xN007405db_A:0xP007405db_A:0xQ007405db_A:0xR007405db_A:0xS007405db_A:0xT007405db_A:0xK007405dc_A:0xK007405dd_A:0xK007405de_A:0xM007405df_A:0xN007405df_A:0xO007405df_A:0xP007405df_A:0xQ007405df_K:f0.0_K:{recall}/f137.0_K:{recall}*f100.0_M:{recall})
		
		-> Serialized Logic (NTSCU) - wrapped inside Macro.Number
			@Number(A:0xO0073de4d_A:0xP0073de4d_A:0xQ0073de4d_A:0xR0073de4d_A:0xS0073de4d_A:0xT0073de4d_A:0xK0073de4e_A:0xM0073de4f_A:0xN0073de4f_A:0xP0073de4f_A:0xQ0073de4f_A:0xR0073de4f_A:0xS0073de4f_A:0xT0073de4f_A:0xM0073de50_A:0xN0073de50_A:0xP0073de50_A:0xR0073de50_A:0xS0073de50_A:0xT0073de50_A:0xM0073de51_A:0xN0073de51_A:0xO0073de51_A:0xP0073de51_A:0xQ0073de51_A:0xS0073de51_A:0xT0073de51_A:0xM0073de52_A:0xN0073de52_A:0xO0073de52_A:0xR0073de52_A:0xT0073de52_A:0xK0073de53_A:0xK0073de54_A:0xK0073de55_A:0xK0073de56_A:0xK0073de57_A:0xK0073de58_A:0xN0073de59_A:0xO0073de59_A:0xP0073de59_A:0xQ0073de59_A:0xR0073de59_A:0xS0073de59_A:0xT0073de59_A:0xM0073de5a_A:0xN0073de5a_A:0xO0073de5a_A:0xQ0073de5a_A:0xR0073de5a_A:0xS0073de5a_A:0xT0073de5a_A:0xM0073de5b_A:0xN0073de5b_A:0xP0073de5b_A:0xQ0073de5b_A:0xR0073de5b_A:0xS0073de5b_A:0xT0073de5b_A:0xK0073de5c_A:0xK0073de5d_A:0xK0073de5e_A:0xM0073de5f_A:0xN0073de5f_A:0xO0073de5f_A:0xP0073de5f_A:0xQ0073de5f_K:f0.0_K:{recall}/f137.0_K:{recall}*f100.0_M:{recall})
	*/

function rpp_Story_ShortInnerID(enum_releaseRegion) =>
	tbyte(get_Area_memAddr_InnerID(enum_releaseRegion))

function rpp_Story_LongInnerID(enum_releaseRegion) =>
	dword(get_Area_memAddr_InnerID(enum_releaseRegion) + 0x2)

function rpp_StoryDifficulty(enum_releaseRegion) =>
	current_StoryCampaignDifficulty(enum_releaseRegion)

function rpp_ShowdownStage(enum_releaseRegion) =>
	tbyte(get_Area_memAddr_InnerID(enum_releaseRegion))

function rpp_ShowdownPlayer_Character(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	tbyte(ASCIIaddress_ShowdownPlayerCharacterId(int_playerIndex, enum_releaseRegion))

function rpp_ShowdownPlayer_Cash(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_CashCollected(int_playerIndex, enum_releaseRegion)

function rpp_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_Team(int_playerIndex, enum_releaseRegion)

function rpp_ShowdownPlayer_HumanOrCPUPlayer(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	dword(ASCIIaddress_ShowdownPlayer_AIsetting(int_playerIndex, enum_releaseRegion))

function rpp_ShowdownPlayer_HighNoonRoundsWon(int_playerIndex, enum_releaseRegion) => // Player Index [1-4]
	current_ShowdownPlayer_HighNoonRoundsWon(int_playerIndex, enum_releaseRegion)

function rpp_ShowdownMode(enum_releaseRegion) =>
	current_Showdown_Mode(enum_releaseRegion)

function rpp_Showdown_BountyHunt_MoneyToCollect(enum_releaseRegion) =>
	current_Showdown_BountyLimit(enum_releaseRegion)

function rpp_Showdown_HighNoon_RoundsRequiredToWin(enum_releaseRegion) => 
	current_Showdown_HighNoonRequiredWins(enum_releaseRegion)

function rpp_CountdownTimer(enum_releaseRegion) =>
	current_CountDownTimer_TimeLeft(enum_releaseRegion)

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
	//	 	"ValueFormat": "VALUE"}},

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

	"rpp_StoryChapter_ShortInnerID": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_Story_ShortInnerID(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Story_ShortInnerID(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_StoryChapter_ShortID",
		"LookupFallback": richPresence_getLookupTableText("lup_StoryChapter_LongID", "BullsEye")},
	"rpp_StoryChapter_LongInnerID": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_Story_LongInnerID(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Story_LongInnerID(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_StoryChapter_LongID",
		"LookupFallback": richPresence_getLookupTableText("lup_StoryChapter_LongID", "BullsEye")},
	"rpp_StoryDifficulty": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_StoryDifficulty(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_StoryDifficulty(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_StoryDifficulty",
		"LookupFallback": richPresence_getLookupTableText("lup_StoryDifficulty", "Normal")},
	"rpp_ShowdownStage": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownStage(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownStage(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownStage",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownStage", "LOOKUP_FALLBACK")},
	"rpp_ShowdownMode": { 
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownMode(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownMode(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownMode",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownMode", "LOOKUP_FALLBACK")},
	"rpp_ShowdownPlayer1_Character": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Character(1, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Character(1, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_CharacterName",
		"LookupFallback": richPresence_getLookupTableText("lup_CharacterName", "LOOKUP_FALLBACK")},
	"rpp_ShowdownPlayer2_Character": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Character(2, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Character(2, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_CharacterName",
		"LookupFallback": richPresence_getLookupTableText("lup_CharacterName", "LOOKUP_FALLBACK")},
	"rpp_ShowdownPlayer3_Character": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Character(3, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Character(3, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_CharacterName",
		"LookupFallback": richPresence_getLookupTableText("lup_CharacterName", "LOOKUP_FALLBACK")},
	"rpp_ShowdownPlayer4_Character": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Character(4, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Character(4, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_CharacterName",
		"LookupFallback": richPresence_getLookupTableText("lup_CharacterName", "LOOKUP_FALLBACK")},
	"rpp_ShowdownPlayer1_Team": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Team(1, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Team(1, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownTeam",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownTeam", "RED")},
	"rpp_ShowdownPlayer2_Team": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Team(2, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Team(2, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownTeam",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownTeam", "WHITE")},
	"rpp_ShowdownPlayer3_Team": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Team(3, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Team(3, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownTeam",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownTeam", "BLUE")},
	"rpp_ShowdownPlayer4_Team": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Team(4, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Team(4, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_ShowdownTeam",
		"LookupFallback": richPresence_getLookupTableText("lup_ShowdownTeam", "YELLOW")},
	"rpp_ShowdownPlayer1_IsHumanOrCPUPlayer": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_HumanOrCPUPlayer(1, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_HumanOrCPUPlayer(1, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IsHumanOrCPUPlayer",
		"LookupFallback": richPresence_getLookupTableText("lup_IsHumanOrCPUPlayer", "Human")},
	"rpp_ShowdownPlayer2_IsHumanOrCPUPlayer": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_HumanOrCPUPlayer(2, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_HumanOrCPUPlayer(2, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IsHumanOrCPUPlayer",
		"LookupFallback": richPresence_getLookupTableText("lup_IsHumanOrCPUPlayer", "CPU")},
	"rpp_ShowdownPlayer3_IsHumanOrCPUPlayer": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_HumanOrCPUPlayer(3, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_HumanOrCPUPlayer(3, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IsHumanOrCPUPlayer",
		"LookupFallback": richPresence_getLookupTableText("lup_IsHumanOrCPUPlayer", "CPU")},
	"rpp_ShowdownPlayer4_IsHumanOrCPUPlayer": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_HumanOrCPUPlayer(4, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_HumanOrCPUPlayer(4, RELEASE_REGION_EUR)},
		"LookupTableID": "lup_IsHumanOrCPUPlayer",
		"LookupFallback": richPresence_getLookupTableText("lup_IsHumanOrCPUPlayer", "CPU")},
	"rpp_Showdown_BountyHunt_MoneyToCollect": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_Showdown_BountyHunt_MoneyToCollect(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Showdown_BountyHunt_MoneyToCollect(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_Showdown_BountyHunt_MoneyToCollect",
		"LookupFallback": richPresence_getLookupTableText("lup_Showdown_BountyHunt_MoneyToCollect", "20K")},
	"rpp_Showdown_HighNoon_RoundsRequiredToWin": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_Showdown_HighNoon_RoundsRequiredToWin(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Showdown_HighNoon_RoundsRequiredToWin(RELEASE_REGION_EUR)},
		"LookupTableID": "lup_Showdown_HighNoon_RoundsRequiredToWin",
		"LookupFallback": richPresence_getLookupTableText("lup_Showdown_HighNoon_RoundsRequiredToWin", "10rounds")},

	"rpp_CountdownTimer": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_CountdownTimer(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_CountdownTimer(RELEASE_REGION_EUR)},
		"MacroFormat": "Seconds"},
	"rpp_ShowdownPlayer1_HighNoonRoundsWon": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_HighNoonRoundsWon(1, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_HighNoonRoundsWon(1, RELEASE_REGION_EUR)},
		"MacroFormat": "Number"},
	"rpp_ShowdownPlayer1_Cash": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_ShowdownPlayer_Cash(1, RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_ShowdownPlayer_Cash(1, RELEASE_REGION_EUR)},
		"MacroFormat": "Number"},
	"rpp_JournalCompletionRate": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_JournalCompletionRate(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_JournalCompletionRate(RELEASE_REGION_EUR)},
		"MacroFormat": "Number"},	
	
	}
// -------------------------------------
function richPresence_createParameterName(string_parameterKey) => // Removes rpp_ OR lup_
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

// ===============================
// • RichPresence INITIALIZATION •
// ===============================
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

/* 	// DEV_NOTE: MeasuredValues with FPS differences for time trials
	// 	TimeSpent with HitCounts and accounting for FPS differences - For Leaderboard MeasuredValues
	// -----------------------------

	- Time Format: MILLISECS (this is actually Centisecs, it's misspelled) || 1 second = 100 Centisecs = 100 hits
		---------------------------
		[US] 30 FPS --> 100 hits per second --> 100 centisecs = 1 second
			AddHit		always_true()				(0)		|30 hits each second|
			AddHit		always_true()				(0)		|30 hits each second|
			AddHit		always_true()				(0)		|30 hits each second|
			AddHit		ValueChangesEach3frames()	(0)		|10 hits each second|
			Measured	always_false()				(0)		|30 + 30 + 30 + 10 = 100 hits each second|

		[EU] 25 FPS --> 100 hits per second --> 100 centisecs = 1 second
			AddHit		always_true()	(0)		|25 hits each second|
			AddHit		always_true()	(0)		|25 hits each second|
			AddHit		always_true()	(0)		|25 hits each second|
			AddHit		always_true()	(0)		|25 hits each second|
			Measured	always_false()	(0)		|25 + 25 + 25 + 25 = 100 hits per second|


	- Time Format: FRAMES (60 FPS) || 1 second = 60 Frames = 60 hits
		---------------------------
		[US] 30 FPS --> 60 hits per second --> 60 FPS = 1 second
			AddHit		always_true()	(0)		|30 hits each second|
			AddHit		always_true()	(0)		|30 hits each second|
			Measured	always_false()	(0)		|30 + 30 = 60 hits each second|

		[EU] 25 FPS --> 60 hits per second --> 60 FPS = 1 second
			AddHit		always_true()				(0)		|25 hits each second|
			AddHit		always_true()				(0)		|25 hits each second|
			AddHit		ValueChangesEach5frames()	(0)		|5 hits each second|
			AddHit		ValueChangesEach5frames()	(0)		|5 hits each second|
			Measured	always_false()				(0)		|25 + 25 + 5 + 5 = 60 hits each second|

	- Time Format: SECS (+1 on each second) --> this would be useful for creating time trials, where there's no in-memory timer which starts counting from 0
		REQUIRED: is some sort of way of checking if a seconds has passed. eg. a global timer (time spent in seconds)
		---------------------------
		[US] 30 FPS
			Measured	secondHasPassed()	(0)		|1 hit on each 30th frame|

		[EU] 25 FPS
			Measured	secondHasPassed()	(0)		|1 hit on each 25th frame|
*/

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

	// "lb_Chapter1Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// "id": 115333, "isLowerBetter": false, 
		// "leaderboardFormat": "VALUE",
		// "devInfo": "Best Stats - Normal"},
	// "lb_Chapter2Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118232, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter3Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118242, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter5Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118241, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter6Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118240, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter7Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118239, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter8Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118238, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter10Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118231, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter11Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118230, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter12Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118229, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter13Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118228, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter14Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118227, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter15Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118226, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter17Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118225, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter19Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118237, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter20Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118236, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter22Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118235, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter24Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118234, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter25Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118233, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"}, 
	// "lb_Chapter27Normal": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118221, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Normal"},
	// "lb_Chapter1Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118270, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter2Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118271, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter3Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118272, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter5Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118273, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter6Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118274, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter7Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118275, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter8Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118276, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter10Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118284, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter11Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118283, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter12Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118282, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter13Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118281, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter14Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118280, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter15Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118279, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter17Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118278, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter19Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118277, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter20Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118289, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter22Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118288, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter24Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118287, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter25Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118286, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"}, 
	// "lb_Chapter27Hard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118285, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Hard"},
	// "lb_Chapter1VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// "id": 118290, "isLowerBetter": false, 
		// "leaderboardFormat": "VALUE",
		// "devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter2VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118296, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter3VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118295, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter5VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118294, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter6VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118293, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter7VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118292, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter8VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118291, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter10VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118304, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter11VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118303, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter12VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118302, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter13VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118301, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter14VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118300, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter15VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118299, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter17VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118298, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter19VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118297, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter20VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118309, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter22VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118308, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter24VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118307, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter25VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118306, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"}, 
	// "lb_Chapter27VeryHard": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118305, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Very Hard"},
	// "lb_Chapter1RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118310, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter2RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118311, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter3RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118312, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter5RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118313, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter6RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118314, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter7RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118315, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter8RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118316, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter10RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118317, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter11RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118318, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter12RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118319, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter13RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118320, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter14RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118321, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter15RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118322, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter17RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118323, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter19RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118324, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter20RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118325, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter22RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118326, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter24RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118327, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"},
	// "lb_Chapter25RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// 	"id": 118328, "isLowerBetter": false, 
		// 	"leaderboardFormat": "VALUE",
		// 	"devInfo": "Best Stats - Red Wood revolver"}, 
	// "lb_Chapter27RedWood": { // VERIFIED // DISABLED - Manual edit via RAIntegration - ValueMeasure has usage of Remember/Recall
		// "id": 118329, "isLowerBetter": false, 
		// "leaderboardFormat": "VALUE",
		// "devInfo": "Best Stats - Red Wood revolver"},

	// "lb_StoryNormal": { // CONCEPT lb_StoryNormal
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "Complete Story on normal (session-based)"},
	// },
	
	"lb_ShowdownFastestBounty": { // VERIFIED - Starts at beginning of match with timer RAoverlay
		"id": 112549, "isLowerBetter": true, 
		"leaderboardFormat": "SECS",
		"devInfo": "Bounty Hunter match with 3 CPUs: Fastest to collect 15k"},
	"lb_ShowdownLargestBounty": { // VERIFIED - Instant Start/Submit at end of Showdown match // DISABLED - Manual edit via RAIntegration - complex sumation/AddSource chain
		"id": 112550, "isLowerBetter": false, 
		"leaderboardFormat": "VALUE",
		"devInfo": "Sundown match with 3 CPUs: largest bounty collection in 10 min"},
	"lb_ShowdownBestCombo": { // VERIFIED - Instant Start/Submit at end of Showdown match
		"id": 112548, "isLowerBetter": false, 
		"leaderboardFormat": "VALUE",
		"devInfo": "Any Showdown match with 3 CPUs: highest combo"},
	}

// ===================================
// • Leaderboards TRIGGER GENERATORS •
// ===================================
//	- For leaderboard logic that's reoccuring across multiple triggers

function leaderboards_generate_FullStartTrigger_ChapterBoard(enum_areaId, enum_difficulty, enum_releaseRegion) {
		// NOTE: Only Mission Restart works to reset the leaderboard. RetryMenu should not reset the leaderboard as this uses checkpoints

		return 
		// [1] ==== Core (Alt) Group ====					-> Start when starting the mission from start/restart
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| is_Playing_BountyHunterMode_short(enum_releaseRegion)
				|| !is_Area(enum_areaId, enum_releaseRegion)
				|| !is_StoryCampaignDifficulty(enum_difficulty, enum_releaseRegion))

			&& once( // ---Once--> Check if player has started mission from start/restart
				current_TimeSpentInMission(enum_releaseRegion) >= 7.0
				&& prev_TimeSpentInMission(enum_releaseRegion) < 7.0)
			&& is_AreaState_InGame(enum_releaseRegion)

		// [2] ==== Alt Reset Group ====  					-> Reset when not playing Single Player Campaign (eg. quit to main menu)
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_SinglePlayerCampaign(enum_releaseRegion))

		// [3] ==== Alt Reset Group ====  					-> Reset when any cheat is active
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& is_AnyCheat_active(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [5] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on RewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_RewardMenu_Replay_confirm(enum_releaseRegion))
		}

function leaderboards_generate_FullCancelTrigger_ChapterBoard(enum_areaId, enum_releaseRegion) => 
	// [1] ==== Cancel (Alt) Group ====		-> Cancel when not playing Single Player Campaign (eg. quit to main menu)
		is_ReleaseRegion(enum_releaseRegion)
		&& !is_Playing_SinglePlayerCampaign(enum_releaseRegion)

	// [2] ==== Cancel (Alt) Group ====		-> Cancel when incorrect AREA_ID is loaded
		|| is_ReleaseRegion(enum_releaseRegion)
		&& !is_Area(enum_areaId, enum_releaseRegion)

	// [3] ==== Cancel (Alt) Group ====		-> Cancel when any cheat is active
		|| is_ReleaseRegion(enum_releaseRegion)
		&& is_AnyCheat_active(enum_releaseRegion)

	// [4] ==== Cancel (Alt) Group ====		-> Cancel when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
		|| is_ReleaseRegion(enum_releaseRegion)
		&& on_WarningMenu_yes(enum_releaseRegion)

	// [5] ==== Cancel (Alt) Group ====		-> Cancel when pressing 'yes' on RewardMenu->Replay
		|| is_ReleaseRegion(enum_releaseRegion)
		&& on_RewardMenu_Replay_confirm(enum_releaseRegion)
	
function leaderboards_generate_FullSubmitTrigger_ChapterBoard(enum_areaId, enum_releaseRegion) =>
	// [1] ==== Core (Alt) Group ==== 	-> Submit when the RewardMenu is rendered
		unless(
			!is_ReleaseRegion(enum_releaseRegion)
			|| !is_Area(enum_areaId, enum_releaseRegion))
		&& once(on_RewardMenu_render_short(enum_releaseRegion))
		&& on_RewardMenu_FirstPopupMenu_render(enum_releaseRegion)

	// [2] ==== Alt Reset Group ==== 	-> Reset when RewardMenu is not rendered
		|| never_toAlt( 
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_RewardMenu_displayed_short(enum_releaseRegion))

function leaderboards_generate_FullValueMeasure_ChapterBoard() {
	// DEV_NOTE Easily copy paste ValueMeasure over all leaderboards 
		/* 
		1. Make 1 leaderboard which is fully edited
		2. "Copy Def" this ValueMeasure
		3. Make a small edit to all leaderboards which need to be updated, so they show up into ..\RACache\Data\[gameID]-User.txt 	(--> this is where all local changes are stored)
		4. In VScode ctrl+F and replace the FULL serialized logic of the old ValueMeasure with the new one
		*/

	function valueMeasureDuringGameplay(enum_releaseRegion) => 
		measured(
			current_Cash(enum_releaseRegion)
			+ current_CashCombo(enum_releaseRegion) + current_CashComboMultiplier(enum_releaseRegion)
			+ current_PlayerProfile_SavedCash(enum_releaseRegion)
			+ current_ShotsFired(enum_releaseRegion)
			+ current_ShotsHit(enum_releaseRegion)
			+ current_DamageTaken(enum_releaseRegion)
			+ current_TimeSpentInMission(enum_releaseRegion)
			+ current_HighestCombo(enum_releaseRegion)
			+ current_HighestComboMultiplier(enum_releaseRegion)
			+ current_HeadShots(enum_releaseRegion)
			+ current_DeathToll(enum_releaseRegion),
			when = is_ReleaseRegion(enum_releaseRegion))

		/* MANUAL_CONSTRUCTION Measured with Remember/Recall - Math too complicated to be generated correctly by RATools
			-> Serialized Logic (PAL) - [Value Group]
				I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f5.0_K:{recall}+f12.0_I:0xX007448d8_B:{recall}*0xX00000008_I:0xX00562a20_A:0xX00005884*0xX00005888_I:0xX00562a20_K:{recall}*0xX0000587c_I:0xX00763070_I:0xX0000036c_B:fF00000070*f5.0_I:0xX007a0788_B:fF00000020*f3.0_K:{recall}_I:0xX00763070_I:0xX0000036c_A:fF000001c4*0xX000001c0_I:0xX00763070_I:0xX0000036c_A:fF000001c4*0xX000001c0_K:{recall}_I:0xX00763070_I:0xX0000036c_A:0xX00000030*f500.0_I:0xX00763070_I:0xX0000036c_A:0xX0000005c*f200.0_M:{recall}_Q:0xX0054c7cc=1397050451

			-> Serialized Logic (NTSCU) - [Alt 2 Group]
				I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f5.0_K:{recall}+f12.0_I:0xX00742158_B:{recall}*0xX00000008_I:0xX005602a0_A:0xX00005884*0xX00005888_I:0xX005602a0_K:{recall}*0xX0000587c_I:0xX007608f0_I:0xX0000036c_B:fF00000070*f5.0_I:0xX0079e008_B:fF00000020*f3.0_K:{recall}_I:0xX007608f0_I:0xX0000036c_A:fF000001c4*0xX000001c0_I:0xX007608f0_I:0xX0000036c_A:fF000001c4*0xX000001c0_K:{recall}_I:0xX007608f0_I:0xX0000036c_A:0xX00000030*f500.0_I:0xX007608f0_I:0xX0000036c_A:0xX0000005c*f200.0_M:{recall}_Q:0xX0054a04c=1398099027

			-> Defined Logic (PAL) - [Value Group]
				1	AddAddress	Mem		32bit	0x763070
				2	AddAddress	Mem		32bit	0x36c
				3	Remember	Float			0.0			+	Mem		32bit	0x194		|ShotsFired (force float mode)|
				4	AddAddress	Mem		32bit	0x763070
				5	AddAddress	Mem		32bit	0x36c
				6	Remember	Mem		32bit	0x198		/	Recall						|ShotsHit / ShotsFired (= calculatedAccuracy)|
				7	Remember	Recall						*	Float			5.0			|calculatedAccuracy * 5.0 (= accuracyWeighted)|
				8	Remember	Recall						+	Float			12.0		|accuracyWeighted + 12.0|

				9	AddAddress	Mem 	32-bit 	0x7448d8
				10	SubSource 	Recall						*	Mem 	32-bit 	0x8			|SavedCash (before mission start)|
				11	AddAddress	Mem 	32-bit 	0x562a20
				12	AddSource 	Mem 	32-bit 	0x5884 		* 	Mem 	32-bit 	0x5888		|CurrentCashCombo * CurrentCashComboMulitplier|
				13	AddAddress	Mem 	32-bit 	0x562a20	
				14	Remember	Recall						*	Mem 	32-bit 	0x587c		|CalculatedCash * (accuracyWeighted + 12.0)|  	|CalculatedCash = CurrentCash (during gameplay) + (CurrentCashCombo * CurrentCashComboMulitplier) - SavedCash|

				15	AddAddress	Mem		32bit	0x763070
				16	AddAddress	Mem		32bit	0x36c
				17	SubSource	Mem		Float	0x70		*	Float			5.0			|RawDamageTaken * 5.0 (= damageTakenWeighted)|
				18	AddAddress	Mem		32bit	0x7a0788
				19	SubSource	Mem		Float	0x20		*	Float			3.0			|TimeSeconds * 3.0 (= TimeSecondsWeighted)|
				20	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted|

				21	AddAddress	Mem		32bit	0x763070
				22	AddAddress	Mem		32bit	0x36c
				23	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				24	AddAddress	Mem		32bit	0x763070
				25	AddAddress	Mem		32bit	0x36c
				26	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				27	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted 
																								+ (BestCombo * BestComboMultiplier) + (BestCombo * BestComboMultiplier)|
		
				28	AddAddress	Mem		32bit	0x763070
				29	AddAddress	Mem		32bit	0x36c
				30	AddSource	Mem		32bit	0x30		*	Float			500.0		|Headshots * 500|
				31	AddAddress	Mem		32bit	0x763070
				32	AddAddress	Mem		32bit	0x36c
				33	AddSource	Mem		32bit	0x5c		*	Mem				200.0		|DeathToll * 200|
				34	Measured	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted 
																								+ (BestCombo * BestComboMultiplier) + (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200)|

				35	MeasuredIf	Mem		32bit	0x54c7cc	= 	Val				0x53454c53


			-> Defined Logic (NTSCU) [Alt 2 Group]
				1	AddAddress	Mem		32bit	0x7608f0
				2	AddAddress	Mem		32bit	0x36c
				3	Remember	Float			0.0			+	Mem		32bit	0x194		|ShotsFired (force float mode)|
				4	AddAddress	Mem		32bit	0x7608f0
				5	AddAddress	Mem		32bit	0x36c
				6	Remember	Mem		32bit	0x198		/	Recall						|ShotsHit / ShotsFired (= calculatedAccuracy)|
				7	Remember	Recall						*	Float			5.0			|calculatedAccuracy * 5.0 (= accuracyWeighted)|
				8	Remember	Recall						+	Float			12.0		|accuracyWeighted + 12.0|

				9	AddAddress	Mem 	32-bit 	0x7448d8
				10	SubSource 	Recall						*	Mem 	32-bit 	0x8			|SavedCash (before mission start)|
				11	AddAddress	Mem 	32-bit 	0x562a20
				12	AddSource 	Mem 	32-bit 	0x5884 		* 	Mem 	32-bit 	0x5888		|CurrentCashCombo * CurrentCashComboMulitplier|
				13	AddAddress	Mem 	32-bit 	0x562a20	
				14	Remember	Recall						*	Mem 	32-bit 	0x587c		|CalculatedCash * (accuracyWeighted + 12.0)|  	|CalculatedCash = CurrentCash (during gameplay) + (CurrentCashCombo * CurrentCashComboMulitplier) - SavedCash|

				15	AddAddress	Mem		32bit	0x7608f0
				16	AddAddress	Mem		32bit	0x36c
				17	SubSource	Mem		Float	0x70		*	Float			5.0			|RawDamageTaken * 5.0 (= damageTakenWeighted)|
				18	AddAddress	Mem		32bit	0x79e008
				19	SubSource	Mem		Float	0x20		*	Float			3.0			|TimeSeconds * 3.0 (= TimeSecondsWeighted)|
				20	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted|

				21	AddAddress	Mem		32bit	0x7608f0
				22	AddAddress	Mem		32bit	0x36c
				23	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				24	AddAddress	Mem		32bit	0x7608f0
				25	AddAddress	Mem		32bit	0x36c
				26	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				27	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted 
																								+ (BestCombo * BestComboMultiplier) + (BestCombo * BestComboMultiplier)|
		
				28	AddAddress	Mem		32bit	0x7608f0
				29	AddAddress	Mem		32bit	0x36c
				30	AddSource	Mem		32bit	0x30		*	Float			500.0		|Headshots * 500|
				31	AddAddress	Mem		32bit	0x7608f0
				32	AddAddress	Mem		32bit	0x36c
				33	AddSource	Mem		32bit	0x5c		*	Mem				200.0		|DeathToll * 200|
				34	Measured	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted 
																								+ (BestCombo * BestComboMultiplier) + (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200)|

				35	MeasuredIf	Mem		32bit	0x54a04c	= 	Val				0x53554c53
			
			*/

	function valueMeasureSubmitted(enum_releaseRegion) => 
		measured(
			current_RewardMenu_BountyCollected(enum_releaseRegion)
			+ current_ShotsFired(enum_releaseRegion)
			+ current_ShotsHit(enum_releaseRegion)
			+ current_DamageTaken(enum_releaseRegion)
			+ current_TimeSpentInMission(enum_releaseRegion)
			+ current_HighestCombo(enum_releaseRegion)
			+ current_HighestComboMultiplier(enum_releaseRegion)
			+ current_HeadShots(enum_releaseRegion)
			+ current_DeathToll(enum_releaseRegion)
			+ current_FlagState_IsAccuracyStarAchieved(enum_releaseRegion)
			+ current_FlagState_IsDamageTakenStarAchieved(enum_releaseRegion)
			+ current_FlagState_IsTimeStarAchieved(enum_releaseRegion)
			+ current_FlagState_IsBestComboStarAchieved(enum_releaseRegion),
			when = 
				is_ReleaseRegion(enum_releaseRegion)
				&& is_RewardMenu_displayed_short(enum_releaseRegion))

		/* MANUAL_CONSTRUCTION Measured with Remember/Recall - Math too complicated to be generated correctly by RATools
			-> Serialized Logic (PAL) - [Alt 1 Group]
				I:0xX00763070_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX00763070_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f5.0_K:{recall}+f12.0_I:0xX0054caf0_I:0xX000000ac_I:0xX00000034_I:0xX0000001c_K:{recall}*0xX000009e4_I:0xX00763070_I:0xX0000036c_B:fF00000070*f5.0_I:0xX007a0788_B:fF00000020*f3.0_K:{recall}_I:0xX00763070_I:0xX0000036c_A:fF000001c4*0xX000001c0_I:0xX00763070_I:0xX0000036c_A:fF000001c4*0xX000001c0_K:{recall}_I:0xX00763070_I:0xX0000036c_A:0xX00000030*f500.0_I:0xX00763070_I:0xX0000036c_A:0xX0000005c*f200.0_K:{recall}_I:0xX0054caf0_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000814*f10000.0_I:0xX0054caf0_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000824*f10000.0_I:0xX0054caf0_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000834*f10000.0_I:0xX0054caf0_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000844*f10000.0_M:{recall}_Q:0xX0054c7cc=1397050451_I:0xX0054caf0_Q:0xX000002d0>0
			
			-> Serialized Logic (NTSCU) - [Alt 3 Group]
				I:0xX007608f0_I:0xX0000036c_K:f0.0+0xX00000194_I:0xX007608f0_I:0xX0000036c_K:0xX00000198/{recall}_K:{recall}*f5.0_K:{recall}+f12.0_I:0xX0054a370_I:0xX000000ac_I:0xX00000034_I:0xX0000001c_K:{recall}*0xX000009e4_I:0xX007608f0_I:0xX0000036c_B:fF00000070*f5.0_I:0xX0079e008_B:fF00000020*f3.0_K:{recall}_I:0xX007608f0_I:0xX0000036c_A:fF000001c4*0xX000001c0_I:0xX007608f0_I:0xX0000036c_A:fF000001c4*0xX000001c0_K:{recall}_I:0xX007608f0_I:0xX0000036c_A:0xX00000030*f500.0_I:0xX007608f0_I:0xX0000036c_A:0xX0000005c*f200.0_K:{recall}_I:0xX0054a370_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM000007f4*f10000.0_I:0xX0054a370_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000804*f10000.0_I:0xX0054a370_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000814*f10000.0_I:0xX0054a370_I:0xX000002d0_I:0xX00000024_I:0xX0000001c_A:0xM00000824*f10000.0_M:{recall}_Q:0xX0054a04c=1398099027_I:0xX0054a370_Q:0xX000002d0>0
			
			-> Defined Logic (PAL) - [Alt 1 Group]
				1	AddAddress	Mem		32bit	0x763070
				2	AddAddress	Mem		32bit	0x36c
				3	Remember	Float			0.0			+	Mem		32bit	0x194		|ShotsFired (force float mode)|
				4	AddAddress	Mem		32bit	0x763070
				5	AddAddress	Mem		32bit	0x36c
				6	Remember	Mem		32bit	0x198		/	Recall						|ShotsHit / ShotsFired (= calculatedAccuracy)|
				7	Remember	Recall						*	Float			5.0			|calculatedAccuracy * 5.0 (= accuracyWeighted)|
				8	Remember	Recall						+	Float			12.0		|accuracyWeighted + 12.0|

				9	AddAddress	Mem		32bit	0x54caf0
				10	AddAddress	Mem		32bit	0xac
				11	AddAddress	Mem		32bit	0x34
				12	AddAddress	Mem		32bit	0x1c
				13	Remember	Recall						* 	Mem		32bit	0x9e4		|BountyCollected * (accuracyWeighted + 12.0)|

				14	AddAddress	Mem		32bit	0x763070
				15	AddAddress	Mem		32bit	0x36c
				16	SubSource	Mem		Float	0x70		*	Float			5.0			|RawDamageTaken * 5.0 (= damageTakenWeighted)|
				17	AddAddress	Mem		32bit	0x7a0788
				18	SubSource	Mem		Float	0x20		*	Float			3.0			|TimeSeconds * 3.0 (= TimeSecondsWeighted)|
				19	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted|

				20	AddAddress	Mem		32bit	0x763070
				21	AddAddress	Mem		32bit	0x36c
				22	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				23	AddAddress	Mem		32bit	0x763070
				24	AddAddress	Mem		32bit	0x36c
				25	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				26	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted 
																								+ (BestCombo * BestComboMultiplier) + (BestCombo * BestComboMultiplier)|
		
				27	AddAddress	Mem		32bit	0x763070
				28	AddAddress	Mem		32bit	0x36c
				29	AddSource	Mem		32bit	0x30		*	Float			500.0		|Headshots * 500|
				30	AddAddress	Mem		32bit	0x763070
				31	AddAddress	Mem		32bit	0x36c
				32	AddSource	Mem		32bit	0x5c		*	Mem				200.0		|DeathToll * 200|
				33	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted + (BestCombo * BestComboMultiplier) 
																								+ (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200)|
				
				34	AddAddress	Mem		32bit	0x54caf0
				35	AddAddress	Mem		32bit	0x2d0
				36	AddAddress	Mem		32bit	0x24
				37	AddAddress	Mem		32bit	0x1c
				38	AddSource	Mem		bit0	0x814		*	Float			10000.0		|AccuracyStar = 10,000|
				39	AddAddress	Mem		32bit	0x54caf0
				40	AddAddress	Mem		32bit	0x2d0
				41	AddAddress	Mem		32bit	0x24
				42	AddAddress	Mem		32bit	0x1c
				43	AddSource	Mem		bit0	0x824		*	Float			10000.0		|DamageTakenStar = 10,000|
				44	AddAddress	Mem		32bit	0x54caf0
				45	AddAddress	Mem		32bit	0x2d0
				46	AddAddress	Mem		32bit	0x24
				47	AddAddress	Mem		32bit	0x1c
				48	AddSource	Mem		bit0	0x834		*	Float			10000.0		|TimeStar = 10,000|
				49	AddAddress	Mem		32bit	0x54caf0
				50	AddAddress	Mem		32bit	0x2d0
				51	AddAddress	Mem		32bit	0x24
				52	AddAddress	Mem		32bit	0x1c
				53	AddSource	Mem		bit0	0x844		*	Float			10000.0		|BestComboStar = 10,000|
				54	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted + (BestCombo * BestComboMultiplier) 
																								+ (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200) + (10,000 for each star, max 4)|

				55	MeasuredIf	Mem		32bit	0x54c7cc	= 	Val				0x53454c53
				56	AddAddress	Mem		32bit	0x54caf0
				57	MeasuredIf	Mem		32bit	0x2d0		> 	Val				0x0


			-> Defined Logic (NTSCU) - [Alt 3 Group]
				1	AddAddress	Mem		32bit	0x7608f0
				2	AddAddress	Mem		32bit	0x36c
				3	Remember	Float			0.0			+	Mem		32bit	0x194		|ShotsFired (force float mode)|
				4	AddAddress	Mem		32bit	0x7608f0
				5	AddAddress	Mem		32bit	0x36c
				6	Remember	Mem		32bit	0x198		/	Recall						|ShotsHit / ShotsFired (= calculatedAccuracy)|
				7	Remember	Recall						*	Float			5.0			|calculatedAccuracy * 5.0 (= accuracyWeighted)|
				8	Remember	Recall						+	Float			12.0		|accuracyWeighted + 12.0|	

				9	AddAddress	Mem		32bit	0x54a370
				10	AddAddress	Mem		32bit	0xac
				11	AddAddress	Mem		32bit	0x34
				12	AddAddress	Mem		32bit	0x1c
				13	Remember	Recall						* 	Mem		32bit	0x9e4		|BountyCollected * (accuracyWeighted + 12.0)|

				14	AddAddress	Mem		32bit	0x7608f0
				15	AddAddress	Mem		32bit	0x36c
				16	SubSource	Mem		Float	0x70		*	Float			5.0			|RawDamageTaken * 5.0 (= damageTakenWeighted)|
				17	AddAddress	Mem		32bit	0x79e008
				18	SubSource	Mem		Float	0x20		*	Float			3.0			|TimeSeconds * 3.0 (= TimeSecondsWeighted)|
				19	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted|

				20	AddAddress	Mem		32bit	0x7608f0
				21	AddAddress	Mem		32bit	0x36c
				22	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				23	AddAddress	Mem		32bit	0x7608f0
				24	AddAddress	Mem		32bit	0x36c
				25	AddSource	Mem		Float	0x1c4		*	Mem		32bit	0x1c0		|BestCombo * BestComboMultiplier|
				
		
				27	AddAddress	Mem		32bit	0x7608f0
				28	AddAddress	Mem		32bit	0x36c
				29	AddSource	Mem		32bit	0x30		*	Float			500.0		|Headshots * 500|
				30	AddAddress	Mem		32bit	0x7608f0
				31	AddAddress	Mem		32bit	0x36c
				32	AddSource	Mem		32bit	0x5c		*	Mem				200.0		|DeathToll * 200|
				33	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted + (BestCombo * BestComboMultiplier) 
																								+ (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200)|
				
				34	AddAddress	Mem		32bit	0x54a370
				35	AddAddress	Mem		32bit	0x2d0
				36	AddAddress	Mem		32bit	0x24
				37	AddAddress	Mem		32bit	0x1c
				38	AddSource	Mem		bit0	0x7f4		*	Float			10000.0		|AccuracyStar = 10,000|
				39	AddAddress	Mem		32bit	0x54a370
				40	AddAddress	Mem		32bit	0x2d0
				41	AddAddress	Mem		32bit	0x24
				42	AddAddress	Mem		32bit	0x1c
				43	AddSource	Mem		bit0	0x804		*	Float			10000.0		|DamageTakenStar = 10,000|
				44	AddAddress	Mem		32bit	0x54a370
				45	AddAddress	Mem		32bit	0x2d0
				46	AddAddress	Mem		32bit	0x24
				47	AddAddress	Mem		32bit	0x1c
				48	AddSource	Mem		bit0	0x814		*	Float			10000.0		|TimeStar = 10,000|
				49	AddAddress	Mem		32bit	0x54a370
				50	AddAddress	Mem		32bit	0x2d0
				51	AddAddress	Mem		32bit	0x24
				52	AddAddress	Mem		32bit	0x1c
				53	AddSource	Mem		bit0	0x824		*	Float			10000.0		|BestComboStar = 10,000|
				54	Remember	Recall														|(CalculatedCash * (accuracyWeighted + 12.0)) - damageTakenWeighted - TimeSecondsWeighted + (BestCombo * BestComboMultiplier) 
																								+ (BestCombo * BestComboMultiplier) + (Headshots * 500) + (DeathToll * 200) + (10,000 for each star, max 4)|

				27	MeasuredIf	Mem		32bit	0x54a04c	= 	Val				0x53554c53
				28	AddAddress	Mem		32bit	0x54a370
				29	MeasuredIf	Mem		32bit	0x2d0		> 	Val				0x0

			*/

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED  {
		array_push(let_array_valueMeasures, valueMeasureDuringGameplay(enum_releaseRegion))
		array_push(let_array_valueMeasures, valueMeasureSubmitted(enum_releaseRegion))
	}
	return max_of(let_array_valueMeasures)}


// =========================
// • Leaderboards TRIGGERS •
// =========================
leaderboards_startTriggers = {
	"lb_Chapter1Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BullsEye, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter2Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BountyHunter, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter3Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter5Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Railroaded, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter6Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter7Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FreakShow, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter8Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RogueValley, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter10Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheCemetery, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter11Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RangeWar, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter12Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SaloonFight, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter13Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheTraitor, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter14Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter15Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BearMountain, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter17Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheMine, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter19Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_HellPass, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter20Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FortDiego, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter22Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter24Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BattleFinale, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter25Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Siege, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter27Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, DIFFICULTY_Normal, enum_releaseRegion)),
	"lb_Chapter1Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BullsEye, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter2Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BountyHunter, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter3Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter5Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Railroaded, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter6Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter7Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FreakShow, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter8Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RogueValley, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter10Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheCemetery, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter11Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RangeWar, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter12Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SaloonFight, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter13Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheTraitor, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter14Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter15Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BearMountain, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter17Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheMine, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter19Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_HellPass, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter20Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FortDiego, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter22Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter24Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BattleFinale, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter25Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Siege, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter27Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, DIFFICULTY_Hard, enum_releaseRegion)),
	"lb_Chapter1VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BullsEye, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter2VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BountyHunter, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter3VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter5VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Railroaded, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter6VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter7VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FreakShow, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter8VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RogueValley, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter10VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheCemetery, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter11VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RangeWar, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter12VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SaloonFight, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter13VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheTraitor, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter14VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter15VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BearMountain, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter17VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheMine, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter19VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_HellPass, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter20VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FortDiego, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter22VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter24VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BattleFinale, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter25VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Siege, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter27VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, DIFFICULTY_VeryHard, enum_releaseRegion)),
	"lb_Chapter1RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BullsEye, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter2RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BountyHunter, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter3RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter5RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Railroaded, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter6RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter7RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FreakShow, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter8RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RogueValley, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter10RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheCemetery, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter11RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_RangeWar, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter12RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SaloonFight, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter13RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheTraitor, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter14RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter15RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BearMountain, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter17RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_TheMine, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter19RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_HellPass, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter20RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FortDiego, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter22RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter24RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_BattleFinale, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter25RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_Siege, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)),
	"lb_Chapter27RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullStartTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, DIFFICULTY_RedWoodRevolver, enum_releaseRegion)
	),
	"lb_ShowdownFastestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { 
		const_HUMAN_PLAYER_INDEX_1 = 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return 
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Once a cheat is active
				is_AnyCheat_active(enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) // ---4 lines---> Check if playing solo
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // ---3 lines---> Check if player 1 has no allies
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& repeated(300, // ---BugFix--> Delay necessary because CancelTrigger may be true on_WarningMenu_yes() at same time StartTrigger resets --> so both Cancel and Start true at same time, thus never starts
				is_AreaState_InGame(enum_releaseRegion))

			&& is_Showdown_Mode(SHOWDOWN_MODE_BountyHunter, enum_releaseRegion)
			&& is_Showdown_BountyLimit(SHOWDOWN_BOUNTY_LIMIT_15K, enum_releaseRegion)

		// [2] ==== Alt Reset Group ====  					-> Reset when not playing Showdown Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_ShowdownMode_long(enum_releaseRegion))
		
		// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion))
		}),
	"lb_ShowdownLargestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { 
		const_HUMAN_PLAYER_INDEX_1 = 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return 
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Once a cheat is active
				is_AnyCheat_active(enum_releaseRegion)))			

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) // ---4 lines---> Check if playing solo
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // ---3 lines---> Check if player 1 has no allies
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& is_Showdown_Mode(SHOWDOWN_MODE_Sundown, enum_releaseRegion)
			&& is_Showdown_SundownFightTime(SHOWDOWN_SUNDOWN_FIGHT_TIME_10min, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))		

			&& once(
				never(is_MultiplayerRewardMenu_notDisplayed(enum_releaseRegion))
				&& on_MultiplayerRewardMenu_render(enum_releaseRegion))

		// [2] ==== Alt Reset Group ====  					-> Reset when not playing Showdown Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_ShowdownMode_long(enum_releaseRegion))
		
		// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion))
		}),
	"lb_ShowdownBestCombo": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { 
		const_HUMAN_PLAYER_INDEX_1 = 1
		const_CPU_PLAYER_INDEX_2 = 2
		const_CPU_PLAYER_INDEX_3 = 3
		const_CPU_PLAYER_INDEX_4 = 4

		return 
		// [1] ==== Core (Alt) Group ====
			unless(
				!is_ReleaseRegion(enum_releaseRegion)
				|| !is_Playing_ShowdownMode_short(enum_releaseRegion))
			&& unless(once( // <-- Pause Lock: Once a cheat is active
				is_AnyCheat_active(enum_releaseRegion)))

			&& current_NumberOfPlayers(enum_releaseRegion) == 4
			&& is_ShowdownPlayer_Human(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) // ---4 lines---> Check if playing solo
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_2, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& is_ShowdownPlayer_CPU(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_2, enum_releaseRegion) // ---3 lines---> Check if player 1 has no allies
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_3, enum_releaseRegion)
			&& current_ShowdownPlayer_Team(const_HUMAN_PLAYER_INDEX_1, enum_releaseRegion) != current_ShowdownPlayer_Team(const_CPU_PLAYER_INDEX_4, enum_releaseRegion)

			&& once(is_AreaState_InGame(enum_releaseRegion))

			&& once(
				never(is_MultiplayerRewardMenu_notDisplayed(enum_releaseRegion)) &&
				on_MultiplayerRewardMenu_render(enum_releaseRegion))
			
			&& repeated(100, // <-- Delay as to popup after other Showdown leaderboards
				never(is_MultiplayerRewardMenu_notDisplayed(enum_releaseRegion)) &&
				is_MultiplayerRewardMenu_displayed(enum_releaseRegion))

			&& current_HighestCombo_Showdown(enum_releaseRegion) > 0

		// [2] ==== Alt Reset Group ====  					-> Reset when not playing Showdown Mode
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& !is_Playing_ShowdownMode_long(enum_releaseRegion))
		
		// [3] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_WarningMenu_yes(enum_releaseRegion))

		// [4] ==== Alt Pause Lock Reset Group ==== 		-> Reset when pressing 'yes' on MultiplayerRewardMenu->Replay
			|| never_toAlt(
				is_ReleaseRegion(enum_releaseRegion) 
				&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion))
	}),
	}
leaderboards_cancelTriggers = {
	"lb_Chapter1Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullCancelTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)
	),
	"lb_ShowdownFastestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		// [1] ==== Cancel (Alt) Group ====		-> Cancel when not playing Showdown mode
			is_ReleaseRegion(enum_releaseRegion)
			&& !is_Playing_ShowdownMode_long(enum_releaseRegion) 

		// [2] ==== Cancel (Alt) Group ====		-> Cancel when a cheat is activated
			|| is_ReleaseRegion(enum_releaseRegion)
			&& is_AnyCheat_active(enum_releaseRegion) 

		// [3] ==== Cancel (Alt) Group ====		-> Cancel when pressing 'yes' on warningMenu accessed through PauseMenu->levelRestart or PauseMenu->quit
			|| is_ReleaseRegion(enum_releaseRegion)
			&& on_WarningMenu_yes(enum_releaseRegion)

		// [4] ==== Cancel (Alt) Group ====		-> Cancel when confirming MultiplayerRewardMenu->Replay
			|| is_ReleaseRegion(enum_releaseRegion)
			&& on_MultiplayerRewardPopupMenu_Replay(enum_releaseRegion)
		),
	"lb_ShowdownLargestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()),
	"lb_ShowdownBestCombo": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_false()),
	}
leaderboards_submitTriggers = {
	"lb_Chapter1Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27Normal": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27Hard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27VeryHard": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_Chapter1RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BullsEye, enum_releaseRegion)),
	"lb_Chapter2RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BountyHunter, enum_releaseRegion)),
	"lb_Chapter3RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_UglyStreetFight, enum_releaseRegion)),
	"lb_Chapter5RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Railroaded, enum_releaseRegion)),
	"lb_Chapter6RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_CarnivalLife, enum_releaseRegion)),
	"lb_Chapter7RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FreakShow, enum_releaseRegion)),
	"lb_Chapter8RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RogueValley, enum_releaseRegion)),
	"lb_Chapter10RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheCemetery, enum_releaseRegion)),
	"lb_Chapter11RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_RangeWar, enum_releaseRegion)),
	"lb_Chapter12RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SaloonFight, enum_releaseRegion)),
	"lb_Chapter13RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheTraitor, enum_releaseRegion)),
	"lb_Chapter14RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_SunsetCanyon, enum_releaseRegion)),
	"lb_Chapter15RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BearMountain, enum_releaseRegion)),
	"lb_Chapter17RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_TheMine, enum_releaseRegion)),
	"lb_Chapter19RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_HellPass, enum_releaseRegion)),
	"lb_Chapter20RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FortDiego, enum_releaseRegion)),
	"lb_Chapter22RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_DevilsAndAngels, enum_releaseRegion)),
	"lb_Chapter24RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_BattleFinale, enum_releaseRegion)),
	"lb_Chapter25RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_Siege, enum_releaseRegion)),
	"lb_Chapter27RedWood": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_FullSubmitTrigger_ChapterBoard(AREA_Campaign_FallFromGrace, enum_releaseRegion)),
	"lb_ShowdownFastestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion)
		&& on_MultiplayerRewardMenu_render(enum_releaseRegion)),
	"lb_ShowdownLargestBounty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()),
	"lb_ShowdownBestCombo": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		always_true()),
	}

//-----------------------------valueMeasures----------------------------
function lb_template_ValueMeasure() { // Template
	function valueMeasure(enum_releaseRegion) => measured(		
		repeated(100, always_false()), // <-- Logic goes here
		when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}
//---------------------------------
function lb_ShowdownFastestBounty_ValueMeasure() {
	function valueMeasure(enum_releaseRegion) => measured(
		current_TimeSpentInMission(enum_releaseRegion), 
		when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}

function lb_ShowdownLargestBounty_ValueMeasure() {
	function valueMeasure(enum_releaseRegion) => measured(
		current_Calculated_CashAcquiredDuringShowdown(enum_releaseRegion), // MANUAL_CONSTRUCTION of current_Calculated_CashAcquiredDuringShowdown(), go to function for logic
		when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}

function lb_ShowdownBestCombo_ValueMeasure() {
	function valueMeasure(enum_releaseRegion) => measured(
		current_HighestCombo_Showdown(enum_releaseRegion) * current_HighestComboMultiplier_Showdown(enum_releaseRegion), 
		when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}

leaderboards_valueMeasures = { 
	"lb_Chapter1Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter2Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter3Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter5Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter6Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter7Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter8Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter10Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter11Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter12Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter13Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter14Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter15Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter17Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter19Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter20Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter22Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter24Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter25Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(), 
	"lb_Chapter27Normal": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter1Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter2Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter3Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter5Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter6Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter7Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter8Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter10Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter11Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter12Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter13Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter14Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter15Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter17Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter19Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter20Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter22Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter24Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter25Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(), 
	"lb_Chapter27Hard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter1VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter2VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter3VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter5VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter6VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter7VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter8VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter10VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter11VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter12VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter13VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter14VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter15VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter17VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter19VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter20VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter22VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter24VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter25VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(), 
	"lb_Chapter27VeryHard": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter1RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter2RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter3RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter5RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter6RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter7RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter8RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter10RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter11RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter12RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter13RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter14RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter15RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter17RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter19RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter20RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter22RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter24RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),
	"lb_Chapter25RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(), 
	"lb_Chapter27RedWood": leaderboards_generate_FullValueMeasure_ChapterBoard(),

	"lb_ShowdownFastestBounty": lb_ShowdownFastestBounty_ValueMeasure(),
	"lb_ShowdownLargestBounty": lb_ShowdownLargestBounty_ValueMeasure(),
	"lb_ShowdownBestCombo": lb_ShowdownBestCombo_ValueMeasure(),
	}
// =====================
// • Leaderboards TEXT •
// =====================
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},

	"lb_Chapter1Normal":			{"en": "'Bull's Eye' Normal Bounty Board"},
	"lb_Chapter2Normal": 			{"en": "'Bounty Hunter' Normal Bounty Board"},
	"lb_Chapter3Normal": 			{"en": "'Ugly Streetfight' Normal Bounty Board"},
	"lb_Chapter5Normal": 			{"en": "'Railroaded' Normal Bounty Board"},
	"lb_Chapter6Normal": 			{"en": "'Carnival Life' Normal Bounty Board"},
	"lb_Chapter7Normal": 			{"en": "'Freak Show' Normal Bounty Board"},
	"lb_Chapter8Normal": 			{"en": "'Rogue Valley' Normal Bounty Board"},
	"lb_Chapter10Normal": 			{"en": "'The Cemetery' Normal Bounty Board"},
	"lb_Chapter11Normal": 			{"en": "'Range War' Normal Bounty Board"},
	"lb_Chapter12Normal": 			{"en": "'Saloon Fight' Normal Bounty Board"},
	"lb_Chapter13Normal": 			{"en": "'The Traitor' Normal Bounty Board"},
	"lb_Chapter14Normal": 			{"en": "'Sunset Canyon' Normal Bounty Board"},
	"lb_Chapter15Normal": 			{"en": "'Bear Mountain' Normal Bounty Board"},
	"lb_Chapter17Normal": 			{"en": "'The Mine' Normal Bounty Board"},
	"lb_Chapter19Normal": 			{"en": "'Hell Pass' Normal Bounty Board"},
	"lb_Chapter20Normal": 			{"en": "'Fort Diego' Normal Bounty Board"},
	"lb_Chapter22Normal": 			{"en": "'Devils and Angels' Normal Bounty Board"},
	"lb_Chapter24Normal": 			{"en": "'Battle Finale' Normal Bounty Board"},
	"lb_Chapter25Normal": 			{"en": "'The Siege' Normal Bounty Board"}, 
	"lb_Chapter27Normal":			{"en": "'Fall From Grace' Normal Bounty Board"},

	"lb_Chapter1Hard": 				{"en": "'Bull's Eye' Hard Bounty Board"},
	"lb_Chapter2Hard": 				{"en": "'Bounty Hunter' Hard Bounty Board"},
	"lb_Chapter3Hard": 				{"en": "'Ugly Streetfight' Hard Bounty Board"},
	"lb_Chapter5Hard": 				{"en": "'Railroaded'' Hard Bounty Board"},
	"lb_Chapter6Hard": 				{"en": "'Carnival Life' Hard Bounty Board"},
	"lb_Chapter7Hard": 				{"en": "'Freak Show' Hard Bounty Board"},
	"lb_Chapter8Hard": 				{"en": "'Rogue Valley' Hard Bounty Board"},
	"lb_Chapter10Hard": 			{"en": "'The Cemetery' Hard Bounty Board"},
	"lb_Chapter11Hard": 			{"en": "'Range War' Hard Bounty Board"},
	"lb_Chapter12Hard": 			{"en": "'Saloon Fight' Hard Bounty Board"},
	"lb_Chapter13Hard": 			{"en": "'The Traitor' Hard Bounty Board"},
	"lb_Chapter14Hard": 			{"en": "'Sunset Canyon' Hard Bounty Board"},
	"lb_Chapter15Hard": 			{"en": "'Bear Mountain' Hard Bounty Board"},
	"lb_Chapter17Hard": 			{"en": "'The Mine' Hard Bounty Board"},
	"lb_Chapter19Hard": 			{"en": "'Hell Pass' Hard Bounty Board"},
	"lb_Chapter20Hard": 			{"en": "'Fort Diego' Hard Bounty Board"},
	"lb_Chapter22Hard": 			{"en": "'Devils and Angels' Hard Bounty Board"},
	"lb_Chapter24Hard": 			{"en": "'Battle Finale' Hard Bounty Board"},
	"lb_Chapter25Hard": 			{"en": "'The Siege' Hard Bounty Board"}, 
	"lb_Chapter27Hard": 			{"en": "'Fall From Grace' Hard Bounty Board"},

	"lb_Chapter1VeryHard": 			{"en": "'Bull's Eye' Very Hard Bounty Board"},
	"lb_Chapter2VeryHard": 			{"en": "'Bounty Hunter' Very Hard Bounty Board"},
	"lb_Chapter3VeryHard": 			{"en": "'Ugly Streetfight' Very Hard Bounty Board"},
	"lb_Chapter5VeryHard": 			{"en": "'Railroaded'' Very Hard Bounty Board"},
	"lb_Chapter6VeryHard": 			{"en": "'Carnival Life' Very Hard Bounty Board"},
	"lb_Chapter7VeryHard": 			{"en": "'Freak Show' Very Hard Bounty Board"},
	"lb_Chapter8VeryHard": 			{"en": "'Rogue Valley' Very Hard Bounty Board"},
	"lb_Chapter10VeryHard": 		{"en": "'The Cemetery' Very Hard Bounty Board"},
	"lb_Chapter11VeryHard": 		{"en": "'Range War' Very Hard Bounty Board"},
	"lb_Chapter12VeryHard": 		{"en": "'Saloon Fight' Very Hard Bounty Board"},
	"lb_Chapter13VeryHard": 		{"en": "'The Traitor' Very Hard Bounty Board"},
	"lb_Chapter14VeryHard": 		{"en": "'Sunset Canyon' Very Hard Bounty Board"},
	"lb_Chapter15VeryHard": 		{"en": "'Bear Mountain' Very Hard Bounty Board"},
	"lb_Chapter17VeryHard": 		{"en": "'The Mine' Very Hard Bounty Board"},
	"lb_Chapter19VeryHard": 		{"en": "'Hell Pass' Very Hard Bounty Board"},
	"lb_Chapter20VeryHard": 		{"en": "'Fort Diego' Very Hard Bounty Board"},
	"lb_Chapter22VeryHard": 		{"en": "'Devils and Angels' Very Hard Bounty Board"},
	"lb_Chapter24VeryHard": 		{"en": "'Battle Finale' Very Hard Bounty Board"},
	"lb_Chapter25VeryHard": 		{"en": "'The Siege' Very Hard Bounty Board"}, 
	"lb_Chapter27VeryHard": 		{"en": "'Fall From Grace' Very Hard Bounty Board"},

	"lb_Chapter1RedWood": 			{"en": "'Bull's Eye' Red Wood Revolver Bounty Board"},
	"lb_Chapter2RedWood": 			{"en": "'Bounty Hunter' Red Wood Revolver Bounty Board"},
	"lb_Chapter3RedWood": 			{"en": "'Ugly Streetfight' Red Wood Revolver Bounty Board"},
	"lb_Chapter5RedWood": 			{"en": "'Railroaded'' Red Wood Revolver Bounty Board"},
	"lb_Chapter6RedWood": 			{"en": "'Carnival Life' Red Wood Revolver Bounty Board"},
	"lb_Chapter7RedWood": 			{"en": "'Freak Show' Red Wood Revolver Bounty Board"},
	"lb_Chapter8RedWood": 			{"en": "'Rogue Valley' Red Wood Revolver Bounty Board"},
	"lb_Chapter10RedWood": 			{"en": "'The Cemetery' Red Wood Revolver Bounty Board"},
	"lb_Chapter11RedWood": 			{"en": "'Range War' Red Wood Revolver Bounty Board"},
	"lb_Chapter12RedWood": 			{"en": "'Saloon Fight' Red Wood Revolver Bounty Board"},
	"lb_Chapter13RedWood": 			{"en": "'The Traitor' Red Wood Revolver Bounty Board"},
	"lb_Chapter14RedWood": 			{"en": "'Sunset Canyon' Red Wood Revolver Bounty Board"},
	"lb_Chapter15RedWood": 			{"en": "'Bear Mountain' Red Wood Revolver Bounty Board"},
	"lb_Chapter17RedWood": 			{"en": "'The Mine' Red Wood Revolver Bounty Board"},
	"lb_Chapter19RedWood": 			{"en": "'Hell Pass' Red Wood Revolver Bounty Board"},
	"lb_Chapter20RedWood": 			{"en": "'Fort Diego' Red Wood Revolver Bounty Board"},
	"lb_Chapter22RedWood": 			{"en": "'Devils and Angels' Red Wood Revolver Bounty Board"},
	"lb_Chapter24RedWood": 			{"en": "'Battle Finale' Red Wood Revolver Bounty Board"},
	"lb_Chapter25RedWood": 			{"en": "'The Siege' Red Wood Revolver Bounty Board"}, 
	"lb_Chapter27RedWood": 			{"en": "'Fall From Grace' Red Wood Revolver Bounty Board"},

	"lb_ShowdownFastestBounty": 			{"en": "Bounty Rush"},
	"lb_ShowdownLargestBounty": 			{"en": "Most Wanted"},
	"lb_ShowdownBestCombo": 				{"en": "Unstoppable String"},
	}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},

	"lb_Chapter1Normal":	{"en": "Ace Chapter 1 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter2Normal": 	{"en": "Ace Chapter 2 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter3Normal": 	{"en": "Ace Chapter 3 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter5Normal": 	{"en": "Ace Chapter 5 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter6Normal": 	{"en": "Ace Chapter 6 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter7Normal": 	{"en": "Ace Chapter 7 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter8Normal": 	{"en": "Ace Chapter 8 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter10Normal": 	{"en": "Ace Chapter 10 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter11Normal": 	{"en": "Ace Chapter 11 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter12Normal": 	{"en": "Ace Chapter 12 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter13Normal": 	{"en": "Ace Chapter 13 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter14Normal": 	{"en": "Ace Chapter 14 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter15Normal": 	{"en": "Ace Chapter 15 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter17Normal": 	{"en": "Ace Chapter 17 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter19Normal": 	{"en": "Ace Chapter 19 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter20Normal": 	{"en": "Ace Chapter 20 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter22Normal": 	{"en": "Ace Chapter 22 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter24Normal": 	{"en": "Ace Chapter 24 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},
	"lb_Chapter25Normal": 	{"en": "Ace Chapter 25 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"}, 
	"lb_Chapter27Normal":	{"en": "Ace Chapter 27 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on normal difficulty"},

	"lb_Chapter1Hard": 		{"en": "Ace Chapter 1 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter2Hard": 		{"en": "Ace Chapter 2 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter3Hard": 		{"en": "Ace Chapter 3 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter5Hard": 		{"en": "Ace Chapter 5 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter6Hard": 		{"en": "Ace Chapter 6 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter7Hard": 		{"en": "Ace Chapter 7 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter8Hard": 		{"en": "Ace Chapter 8 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter10Hard": 	{"en": "Ace Chapter 10 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter11Hard": 	{"en": "Ace Chapter 11 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter12Hard": 	{"en": "Ace Chapter 12 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter13Hard": 	{"en": "Ace Chapter 13 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter14Hard": 	{"en": "Ace Chapter 14 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter15Hard": 	{"en": "Ace Chapter 15 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter17Hard": 	{"en": "Ace Chapter 17 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter19Hard": 	{"en": "Ace Chapter 19 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter20Hard": 	{"en": "Ace Chapter 20 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter22Hard": 	{"en": "Ace Chapter 22 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter24Hard": 	{"en": "Ace Chapter 24 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},
	"lb_Chapter25Hard": 	{"en": "Ace Chapter 25 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"}, 
	"lb_Chapter27Hard": 	{"en": "Ace Chapter 27 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on hard difficulty"},

	"lb_Chapter1VeryHard": 	{"en": "Ace Chapter 1 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter2VeryHard": 	{"en": "Ace Chapter 2 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter3VeryHard": 	{"en": "Ace Chapter 3 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter5VeryHard": 	{"en": "Ace Chapter 5 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter6VeryHard": 	{"en": "Ace Chapter 6 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter7VeryHard": 	{"en": "Ace Chapter 7 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter8VeryHard": 	{"en": "Ace Chapter 8 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter10VeryHard": {"en": "Ace Chapter 10 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter11VeryHard": {"en": "Ace Chapter 11 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter12VeryHard": {"en": "Ace Chapter 12 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter13VeryHard": {"en": "Ace Chapter 13 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter14VeryHard": {"en": "Ace Chapter 14 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter15VeryHard": {"en": "Ace Chapter 15 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter17VeryHard": {"en": "Ace Chapter 17 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter19VeryHard": {"en": "Ace Chapter 19 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter20VeryHard": {"en": "Ace Chapter 20 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter22VeryHard": {"en": "Ace Chapter 22 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter24VeryHard": {"en": "Ace Chapter 24 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},
	"lb_Chapter25VeryHard": {"en": "Ace Chapter 25 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"}, 
	"lb_Chapter27VeryHard": {"en": "Ace Chapter 27 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on very hard difficulty"},

	"lb_Chapter1RedWood": 	{"en": "Ace Chapter 1 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter2RedWood": 	{"en": "Ace Chapter 2 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter3RedWood": 	{"en": "Ace Chapter 3 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter5RedWood": 	{"en": "Ace Chapter 5 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter6RedWood": 	{"en": "Ace Chapter 6 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter7RedWood": 	{"en": "Ace Chapter 7 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter8RedWood": 	{"en": "Ace Chapter 8 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter10RedWood": 	{"en": "Ace Chapter 10 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter11RedWood": 	{"en": "Ace Chapter 11 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter12RedWood": 	{"en": "Ace Chapter 12 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter13RedWood": 	{"en": "Ace Chapter 13 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter14RedWood": 	{"en": "Ace Chapter 14 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter15RedWood": 	{"en": "Ace Chapter 15 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter17RedWood": 	{"en": "Ace Chapter 17 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter19RedWood": 	{"en": "Ace Chapter 19 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter20RedWood": 	{"en": "Ace Chapter 20 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter22RedWood": 	{"en": "Ace Chapter 22 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter24RedWood": 	{"en": "Ace Chapter 24 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},
	"lb_Chapter25RedWood": 	{"en": "Ace Chapter 25 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"}, 
	"lb_Chapter27RedWood": 	{"en": "Ace Chapter 27 with lethal accuracy, swift action, unyielding resilience and a bounty haul worthy of a Wild West legend, on red wood revolver difficulty"},

	"lb_ShowdownFastestBounty": 			{"en": "Win a $15,000 target Bounty Hunter match vs 3 CPU's as quickly as possible"},
	"lb_ShowdownLargestBounty": 			{"en": "Collect the largest bounty in a 10 minute Sundown match vs 3 CPU's"},
	"lb_ShowdownBestCombo": 				{"en": "Achieve the highest combo in a Showdown match vs 3 CPU's"},
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