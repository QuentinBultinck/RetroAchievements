// ****************************************** \\
//  █▀ █▀█ █▀▀ █░░ █░░ █▀▀ ▄▀█ █▀ ▀█▀ █▀▀ █▀█ \\
//  ▄█ █▀▀ ██▄ █▄▄ █▄▄ █▄▄ █▀█ ▄█ ░█░ ██▄ █▀▄ \\
// ****************************************** \\
// #ID = 13233
// md5: 0e1449dd7df4fd0995ccf802bb74cba0 (USA, Europe, Brazil)
// RA Hash: 0e1449dd7df4fd0995ccf802bb74cba0 (USA, Europe, Brazil)
// Platform: Sega Master System
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/13233
// RATools version: 1.17.0

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


// CONCEPT Idea's
// ==================
// Achievements:
// - Complete game taking only xxx strength/HP damage || do a certain stage taking only xxx damage
// - Complete game within xxx minutes (maybe just leaderboard for this) --> complete whole game --> needs password protection//hitCounts
// - complete certain stage without using a basic attack
// - Challenge using only xx Energy
// - Challenge using only Charged Attacks
// - Challenges for each stage???
// --- without dying, taking only xx hits, taking only xx damage, without healing, using only certain spell
// - Boss Challenges??
// - Secret/funny interactions within AdventureMode??
// - Acquire certain items --> https://shrines.rpgclassics.com/sms/spellcaster/items.shtml
//
// Shimono Chapter
// - Taste each type of food and regain strength at Midori House (Shimono chapter)

// Story Script
// ================
// ----Chap0 start---- (trouble at enriku temple)
// Investigate enriku Temple -> discover dead tokak soldiers --> "Izumo" tip from tokak soldier 
// ----Chap1 start---- (Investigation)
// 1.investigate Izumo -> Kuma: something going on at Izumo Shrine --> mysterious man: "Kusanagi" + charm from Iwato family 
// 	- Sword of Kusanagi at attaro shrine --> jukak
// 	- MtMiwa for Iwato fam investigation: MtMiwaGuard --> Wakahiko: "friends are calling Serpent God"
// 2. Go to Kashima Shrine to investigate Serpent God calling there --> Kashima Fire Boss --> Sword of branches acquire
// ----Chap2 start---- (Shimono)
// Daikak: "Iwato looking for real sword of kusanagi in underwater shrine" --> Shimono to acquire it 
// 				--> defeat Iwato at sea + learn Iwato still wanna revive Serpent God, now at Izumo Shrine
// ----Chap3 start---- (FalseEnemy)
// 1. Izumo Temple: Princess asaka/dragon boss fight --> Shimazu + asaka explain everything --> head outside Izumo temple 
// 		--> Shimazu + asaka attacked by centipede --> bossFight --> Shimazu dies: "visit kumano shrine + talk with Utsuho"
// 2. KumanoShrine: show ShimazuBall to Utsuho, becomes friendly: "go to serpent god at Kakogen"
// 3. Kakogen in well cave --> at KakogenTemple find battleship "Ameno" --> return to Utsuho "An ancient god was <transplanted> into the computer! He has watched over 
// 		the people of Iwato since then! Daikok only knows how to restore a god, not a machine but he can control us at will."
// 4. move to Mt Hinokami to face off with Daikok (who's controlled by evil god) --> bossFight Kezeus (alien) --> bossfight Daikok robot --> armorbracers
// 5. move back to KumanoShrine, Utusho: "That armor was Daikok's special armor! It is likely the key to waking up the serpent!"
// 6. move back to Kakogen + startup battleship Ameno/serpent god Ooku: 
// 	"Long ago the Iwato ruled a highly advanced world. In their time 
// 	they trapped an evil lord which threatened their planet. But in trapping the
// 	beast they used up their magic force and were ruined. 
// 	For many years they kept this beast trapped in a pyramid on a distant planet. 
// 	When your people came, the few remaining Iwato decided not to interfere, 
// 	choosing instead to fade away, taking the secret of the evil lord with them. 
// 	This is the truth behind the legends. Kane, evil beings seek to revive the evil lord. 
// 	He is trapped in the pyramid on Mt.Minakami! This ship is heading for the place. 
// 	You must stop the forces of evil from taking over the pyramid!"
// 	--> start spaceship and head to pyramid at Mt Minakami
// ----Chap4 start---- (Pyramid)
// 1. find hidden entrance to pyramid --> find pyramid point --> exit pyramid + place point on top of pyramid --> new entrance opens
// 2. enter pyramid (+ find optional equipment + optional bosses) --> Demon (head of the evil lord's army) + Regina possesses 
// 		--> save Regina --> demon bossfight --> pyramid collapses --> Kane exits with Regina back to spaceship --> back to SummitTemple
// Back at SummitTemple: 
// 	Daikak: "The evil lord's prison was opened?"
// 	Kane: "Yes. The enemy's forces we did defeat, but... "
// 	Daikak:" If the dark lord is revived... We have to rely on the gods to help us. 
// 		Kane, ride the Ameno to the underworld! Find Izanami! Perhaps Izanami will bless you 
// 		with a gift. The dark lord has been freed, but he is still not awake. We must hurry 
// 		before he begins to stir!" 
// 	--> head to Underworld with spaceship
// ----Chap5 start---- (Underworld)
// Underworld guard --> FerryCrossing: ferryman sleepy --> Gaurd: wakeup with nectar --> Chizu Sea: dancing band + Nectar --> Ferryman-Misty crossing -> Yomotsu plains
// 	--> (defeat Amano/magic creature) --> Inazami Shrine: "Find mirror and return to me to defeat Evil lord. Go to Yomotsu Shrine"
// 	--> Yomotsu Shrine is gaurded by cerberus --> Amano tips you now: "find music at Toki Field" --> Toki plains: MoveRock (need Oar from Ferryman) --> find harp of Amano
// 	--> Chizu Sea --> make music --> bad music + learn to make music --> Yomotsu shrine: play music 
// 				--> Yomotsu: "The 8 swords of fury are needed. One is held by the Thunder God!"
// 	--> Ferryman: takes you to thunder god --> bossfight --> take sword of fury 
// 	--> Yomotsu: "You got it! You defeated the god of thunder A very powerful god indeed! 
// 		Now go to the holy bridge to find the sacred mirror! "
// 	--> Amano tells you where Holy Bridge is --> at Holy Bridge: stick sword of fury in pedestal --> door opens --> SnakeDemon bossfight --> drops sacredMirror
// 	--> Show Inazami SacredMirror: 
// 		"only one way to to kill the Dark Lord... You, Kane, must do it yourself. "
// 		"You received a gift of increased power earlier... But you do not yet know your true capacity for strength! 
// 		Now face your destiny as a Spellcaster! Awaken the serpent god and call his power unto yourself!
// 		The serpent hasmuch energy.Concentrate theenergy using thesacred mirror.Use the sword ofKusanagi to drawthe power into yourself! 
// 		That mystic power...along with everythingyou have learned..will give you the strength to defeat the Dark Lord... 
//         If your heart remains pure! Kane,everyone is awaiting your victory!"
// ----Chap6 start---- (FinalBattle prep)
// Summit Temple --> Kashima Shrine --> Strike stone with SwordOfBranches --> unleach serpent god --> serpent god fills mirror with energy 
// 			--> sword of kusanagi as catalyst to invoke power of mirror into Kane 
// ----Chap7 start---- (FinalBattle)
// ending:	
// 	"The evil lord and his armies have been defeated. But as long as suffering exists,
// 	the threat that the Dark Lord will return remains. "
// 	"You must strive to relieve that suffering. The road ahead of you is long, hard and endless. 
// 	You must not pause, but journey ever onward. For that is your destiny, Master of Spells"

// WARNING
// - Using passwords: sends to certain points in the campaign, with all Strength, Energy and Items.

// #endregion DEVELOPER NOTES

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //    GENERAL UTILITY   \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// #region GENERAL UTILITY

class CLASS_Utility {
    isDebugModeActive = true // if true => extra information may be displayed on achievement titles & descriptions
    language = "en"	// ISO 639-1 language codes

	iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
	sNULL = "-1"

	function throwError(string_errMsg) { // This function will throw an error in RATools because the key doesn't exist
		let_dict = {}
		return let_dict[format("ERROR: {0}", string_errMsg)]}

	function concatArrays(array_1, array_2) { // This function will concatenate two arrays (add values of array_2 to array_1)
		let_array_concat = array_1
		for let_index in range(0, length(array_2) - 1) {
			array_push(let_array_concat, array_2[let_index])
		}
		return let_array_concat}

	function addToDictionary(dict, key, value) {
		dict[key] = value}

	function getIndexOfLastItemInArray(array_a) =>
		length(array_a) - 1

	function getLastItemInArray(array_a) =>
		array_a[this.getIndexOfLastItemInArray(array_a)]

	function generateArrayOfIntegers_startAtZero(int_lastInteger) {
		let_array_Integers = []
		for let_index in range(0, int_lastInteger) 
			array_push(let_array_Integers, let_index)
		return let_array_Integers}
	}
util = CLASS_Utility()

class CLASS_ENUM_ReleaseRegions {
	USA_EUR = "EUR_USA_Brazil" // --> SpellCaster (USA, Europe, Brazil) (En).sms
	// JPN = "NTSC-J"
	// EUR = "PAL"
	}
ENUM_ReleaseRegion = CLASS_ENUM_ReleaseRegions()
RELEASE_REGIONS_SUPPORTED = [ENUM_ReleaseRegion.USA_EUR]

// #endregion GENERAL UTILITY

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

class CLASS_MemoryData {
	// #region MEM - Struct Definitions
	dict_regionOffsets = {}
	function getRegionOffset(string_structKey, string_offsetKey) =>
		this.dict_regionOffsets[string_structKey][string_offsetKey]
	// -------------------------------------
	dict_structDefinitions = {
		"Struct:Entity": {
			"offsetToMember": {
				"8-bit:Entity_ID": 0x0,
				"8-bit:Entity_xLocation": 0x2,
				"8-bit:Entity_yLocation": 0x4,
				"8-bit:Entity_HP": 0x15,
				},
			},
		"Struct:Entity(PC_BasicAttack)": {
			"offsetToMember": {
				"8-bit:Entity_ID": 0x0,
				"8-bit:BasicAttack_Charge_State": 0x18,
				},
			},
		}
	function getStruct_SizeInBytes(string_structKey) =>
		this.dict_structDefinitions[string_structKey]["sizeInBytes"]

	function getStruct_OffsetToMember(string_structKey, string_memberKey) =>
		this.dict_structDefinitions[string_structKey]["offsetToMember"][string_memberKey]

	function getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

	function getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

	function getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
		
	function getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

	function generate_pointerChainAccessor(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_array_pointerChainOffsets = this.getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey)
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
			if (let_index == length(let_array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

	function generate_pointerChainAccessor_byReleaseRegion(string_structKey, string_pointerChainKey, memAdrr_basePointer, enum_releaseRegion, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_array_pointerChainOffsets = this.getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion)
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
			if (let_index == length(let_array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

	function generate_pointerChainAccessor_fromOffsets(memAdrr_basePointer, array_pointerChainOffsets, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(array_pointerChainOffsets) - 1) {
			if (let_index == length(array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with creating pointer chain for memAddr: {0}", memAdrr_basePointer))}
	// #endregion MEM - Struct Definitions
	// #region MEM - Address Storage
	dict_addresses = {
		// "memAddrKey": {ENUM_ReleaseRegion.USA_EUR: util.sNULL},
		"BitFlag:IsDemoActive": {ENUM_ReleaseRegion.USA_EUR: 0x0003},
		"BitFlag:IsActionModeActive": {ENUM_ReleaseRegion.USA_EUR: 0x0020},
		"BitFlag:IsAdventureModeDialogueTextDisplayed": {ENUM_ReleaseRegion.USA_EUR: 0x020a},

		"Flag:IsItemAcquired_Armor_Bracers": {ENUM_ReleaseRegion.USA_EUR: 0x0032},
		"Flag:IsItemAcquired_Armor_Helmet": {ENUM_ReleaseRegion.USA_EUR: 0x0033},
		"Flag:IsItemAcquired_Armor_Body": {ENUM_ReleaseRegion.USA_EUR: 0x0034},
		"Flag:IsItemAcquired_Armor_Leg": {ENUM_ReleaseRegion.USA_EUR: 0x0035},
		"Flag:IsItemAcquired_Weapon_Dokko": {ENUM_ReleaseRegion.USA_EUR: 0x0036},
		"Flag:IsItemAcquired_Weapon_Trident": {ENUM_ReleaseRegion.USA_EUR: 0x0037},
		"Flag:IsItemAcquired_Weapon_Vajira": {ENUM_ReleaseRegion.USA_EUR: 0x0038},
		"Flag:IsItemAcquired_Weapon_WarHammer": {ENUM_ReleaseRegion.USA_EUR: 0x0039},
		"Flag:IsPlayerDead": {ENUM_ReleaseRegion.USA_EUR: 0x00b5},
		"Flag:IsAdventureModeMainCommandMenuDisplayed": {ENUM_ReleaseRegion.USA_EUR: 0x0360},
		"Flag:IsAdventureModeSubCommandMenuDisplayed": {ENUM_ReleaseRegion.USA_EUR: 0x03a0},
		"BitFlags:PlayerInput": {ENUM_ReleaseRegion.USA_EUR: 0x0004},

		"BCD:Player_Strength": {ENUM_ReleaseRegion.USA_EUR: 0x0025},
		"BCD:Player_Energy": {ENUM_ReleaseRegion.USA_EUR: 0x0027},

		"8-bit:GameState_A": {ENUM_ReleaseRegion.USA_EUR: 0x0021},
		"8-bit:GameState_B": {ENUM_ReleaseRegion.USA_EUR: 0x0647},
		"8-bit:OutroSequenceState": {ENUM_ReleaseRegion.USA_EUR: 0x0649},
		"8-bit:AdventureScene_ID": {ENUM_ReleaseRegion.USA_EUR: 0x0205},
		"8-bit:StoryChapter_ID": {ENUM_ReleaseRegion.USA_EUR: 0x0022},
		"8-bit:SelectedSpell": {ENUM_ReleaseRegion.USA_EUR: 0x0029},
		"8-bit:PC_xLocation": {ENUM_ReleaseRegion.USA_EUR: 0x0302},
		"8-bit:PC_yLocation": {ENUM_ReleaseRegion.USA_EUR: 0x0304},
		"8-bit:SelectedMainCommandMenuItem": {ENUM_ReleaseRegion.USA_EUR: 0x0375},
		"8-bit:SelectedSubMenuItem": {ENUM_ReleaseRegion.USA_EUR: 0x03b5},

		"16-bit:ActionModeLevel_ID": {ENUM_ReleaseRegion.USA_EUR: 0x0023},
		"16-bit:AdventureModeDialogueText_ID": {ENUM_ReleaseRegion.USA_EUR: 0x0208},

		"32-bit:NeverTrue": {ENUM_ReleaseRegion.USA_EUR: 0x0280},

		"FlagArray:MainQuestEventFlags": {ENUM_ReleaseRegion.USA_EUR: 0x0281},
		"FlagArray:ItemInventoryFlags": {ENUM_ReleaseRegion.USA_EUR: 0x02e0},
		"FlagArray:MiscEventFlags_A": {ENUM_ReleaseRegion.USA_EUR: 0x02b0},
		"FlagArray:GearAcquiredFlags": {ENUM_ReleaseRegion.USA_EUR: 0x0032},

		"92-bit:AdventureSceneColor_ID": {ENUM_ReleaseRegion.USA_EUR: 0x00e4},
		"Struct:Entity(Player_Projectile_A)": {ENUM_ReleaseRegion.USA_EUR: 0x0340},
		"Struct:Entity(Player_Projectile_B)": {ENUM_ReleaseRegion.USA_EUR: 0x0360},
		"Struct:Entity(Player_Projectile_C)": {ENUM_ReleaseRegion.USA_EUR: 0x0380},
		"Struct:Entity(Player_Projectile_D)": {ENUM_ReleaseRegion.USA_EUR: 0x03A0},
		"Struct:Entity(Player_Projectile_E)": {ENUM_ReleaseRegion.USA_EUR: 0x03C0},
		"Struct:Entity(boss)_A": {ENUM_ReleaseRegion.USA_EUR: 0x0400},
		"Struct:Entity(boss)_C": {ENUM_ReleaseRegion.USA_EUR: 0x0460},
		"Struct:Entity(boss)_D": {ENUM_ReleaseRegion.USA_EUR: 0x0620},
		"Struct:Entity(Pyramid_Orb)": {ENUM_ReleaseRegion.USA_EUR: 0x0600},
		}

	function getAddress(string_addrKey, enum_releaseRegion) {
		let_memAddr = this.dict_addresses[string_addrKey][enum_releaseRegion]
		if(let_memAddr == util.sNULL) util.throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
		return let_memAddr}	

	// #endregion MEM - Address Storage
} memory = CLASS_MemoryData()

class CLASS_MemoryUtility {
	// #region MemUtil - Custom ASCII comparitors
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

	dict_asciiToHex = {
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
	
	dict_asciiToFloat = {
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

	function asciiStringToHexLE(string_s, int_numberOfZeroedOutBytesToCheckBeforeString = 0) { // NOTE: Returns a Little Endian hex; int_numberOfZeroedOutBytesToCheckBeforeString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
		/* NOTE Example usages
			- asciiStringToHexLE("Wron") --> Returns 0x6E 6F 72 57 ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Little Endian Hex
				dword(asciiStringToHexLE("Wr", 2)) == dword(0x6E6F7257) --LittleEndianView--> [6E 6F 72 57] "Wron"
			- asciiStringToHexLE("Wr", 2) --> Returns 0x72 57 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Little Endian Hex + with 2 zeroed out bytes appended
				dword(asciiStringToHexLE("Wr", 2)) == dword(0x72570000) --LittleEndianView--> [00 00 57 72] "  Wr"
			*/

		let_stringLength = length(string_s)

		if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckBeforeString >= 4)
			util.throwError("One of the parameters given to CLASS_MemoryUtility.asciiStringToHexLE() is out of range OR invalid")
		if (let_stringLength + int_numberOfZeroedOutBytesToCheckBeforeString > 4)
			util.throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckBeforeString))

		let_hexValue = 0

		if (int_numberOfZeroedOutBytesToCheckBeforeString == 1) let_hexValue = let_hexValue * 0x100
		else if (int_numberOfZeroedOutBytesToCheckBeforeString == 2) let_hexValue = let_hexValue * 0x10000
		else if (int_numberOfZeroedOutBytesToCheckBeforeString == 3) let_hexValue = let_hexValue * 0x1000000

		for let_characterIndex in range(0, let_stringLength - 1) {
			let_characterAsHex = this.dict_asciiToHex[substring(string_s, let_characterIndex, 1)]
			if (let_characterIndex == 0) let_hexValue = let_characterAsHex
			else if (let_characterIndex == 1) let_hexValue = let_hexValue + (let_characterAsHex * 0x100)
			else if (let_characterIndex == 2) let_hexValue = let_hexValue + (let_characterAsHex * 0x10000)
			else let_hexValue = let_hexValue + (let_characterAsHex * 0x1000000)}

		return let_hexValue}

	function asciiStringToHexBE(string_s, int_numberOfZeroedOutBytesToCheckAfterString = 0) { // NOTE: Returns a Big Endian hex; int_numberOfZeroedOutBytesToCheckAfterString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
		/* NOTE Example usages
			- asciiStringToHexBE("Wron") --> Returns 0x57 72 6F 6E  ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Big Endian Hex
				dword_be(asciiStringToHexBE("Wr", 2)) == dword_be(0x57726F6E) --BigEndianView--> [57 72 6F 6E] "Wron"
			- asciiStringToHexBE("Wr", 2) --> Returns 0x57 72 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Big Endian Hex + with 2 zeroed out bytes appended
				dword_be(asciiStringToHexBE("Wr", 2)) == dword_be(0x57720000) --BigEndianView--> [57 72 00 00] "Wr  "
			*/

		let_stringLength = length(string_s)

		if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckAfterString >= 4)
			util.throwError("One of the parameters given to CLASS_MemoryUtility.asciiStringToHexBE() is out of range OR invalid")
		if (let_stringLength + int_numberOfZeroedOutBytesToCheckAfterString > 4)
			util.throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckAfterString))

		let_hexValue = 0
		for let_characterIndex in range(0, let_stringLength - 1) {
			let_characterAsHex = this.dict_asciiToHex[substring(string_s, let_characterIndex, 1)]
			if (let_characterIndex == 0) let_hexValue = let_characterAsHex
			else if (let_characterIndex == 1) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
			else if (let_characterIndex == 2) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
			else let_hexValue = (let_hexValue * 0x100) + let_characterAsHex}

		if (int_numberOfZeroedOutBytesToCheckAfterString == 1) let_hexValue = let_hexValue * 0x100
		else if (int_numberOfZeroedOutBytesToCheckAfterString == 2) let_hexValue = let_hexValue * 0x10000
		else if (int_numberOfZeroedOutBytesToCheckAfterString == 3) let_hexValue = let_hexValue * 0x1000000

		return let_hexValue}

	// #endregion MemUtil - Custom ASCII comparitors
	// #region MemUtil - Main
	// floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
		// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
		// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
	// function floatToInt(float_value, enum_releaseRegion) {
		// let_memAccessor_alwaysNull = high4(memory.getAddress("8-bit:AlwaysNULL_Or_ValueNeverChanges", enum_releaseRegion))
		// return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

	function alwaysFalse(enum_releaseRegion) => // Force always_false() as sometime RATools removes it when it is necessary
		dword(memory.getAddress("32-bit:NeverTrue", enum_releaseRegion)) == 0xDEADBEEF
		
	function ManualConstruction_PlaceHolderRequirement(int_placeHolderIndex) { // int_placeHolderIndex allowedRange [0x1-0xFFF] // This function can be used to quickyly generate a placeHolder Requirement for easily overwriting/copyPasting MANUAL CONSTRUCTION code
		let_dummyAddress = (int_placeHolderIndex * 0x10000) + 0xBEEF
		return dword(let_dummyAddress) == 0xBAADF00D}
	
	function bitIndexToBitMemoryAccessor(int_bitIndex) {
		dict_bitIndexToBitMemoryAccessor = {
			0: bit0,
			1: bit1,
			2: bit2,
			3: bit3,
			4: bit4,
			5: bit5,
			6: bit6,
			7: bit7}
		return dict_bitIndexToBitMemoryAccessor[int_bitIndex]
		}

	// #endregion MemUtil - Main
} memUtil = CLASS_MemoryUtility()

class CLASS_MEMLOGIC_ReleaseRegion { // DISABLED - Check unnecessary as only 1 region supported
	// function is(enum_releaseRegion) {	
		// let_string_GameID = util.sNULL
		// if(enum_releaseRegion == ENUM_ReleaseRegion.USA) let_string_GameID = util.sNULL // FullString: "xxxxx"
		// else if(enum_releaseRegion == ENUM_ReleaseRegion.JPN) let_string_GameID = util.sNULL // FullString: "xxxxx"
		// else if(enum_releaseRegion == ENUM_ReleaseRegion.EUR) let_string_GameID = util.sNULL // FullString: "xxxxx"
		
		// if (let_string_GameID == util.sNULL) util.throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
		// return memUtil.is_ASCII_EqualTo(memory.getAddress("ASCII:GameID", enum_releaseRegion), let_string_GameID)
		// }
} // releaseRegion = CLASS_MEMLOGIC_ReleaseRegion()

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

// ..............
// ◦ GameStates ◦
// ''''''''''''''
// #region GameStates
class CLASS_MEMLOGIC_GameStateA {
	// ----Values/Enums----
	StartMenu_MainMenu = 0x81 
	Demo = 0x82 
	PasswordMenu = 0x83 
	ActionModeMenu = 0x84 
	IntroScene = 0x85 
	OutroSequence = 0x86 
	AdventureMode = 0x88 
	ActionMode = 0x89

	// ----Functions----
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:GameState_A", enum_releaseRegion))
	function prior(enum_releaseRegion) =>
		prior(this.current(enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))

	function on_change(enum_releaseRegion) =>
		this.current(enum_releaseRegion) != this.prev(enum_releaseRegion)	

	function is_active(enum_gameStateA, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_gameStateA

	function on_changeTo(enum_gameState, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != enum_gameState
		&& this.current(enum_releaseRegion) == enum_gameState
	
	function is_valid(enum_releaseRegion) => any_of([
		this.StartMenu_MainMenu, this.Demo, this.PasswordMenu, this.ActionModeMenu, this.IntroScene, this.OutroSequence, this.AdventureMode, this.ActionMode], 
		enum_gameState =>
			this.current(enum_releaseRegion) == enum_gameState)

	function is_inGame(enum_releaseRegion) => any_of([
		this.ActionModeMenu, this.OutroSequence, this.AdventureMode, this.ActionMode], 
		enum_gameState =>
			this.current(enum_releaseRegion) == enum_gameState)

	// CheckIf: is in ActionMode or in the ActionModeMenu
	function is_actionMode_active(enum_releaseRegion) =>
		this.current(enum_releaseRegion) == this.ActionMode
		|| this.current(enum_releaseRegion) == this.ActionModeMenu
} gameStateA = CLASS_MEMLOGIC_GameStateA()

class CLASS_MEMLOGIC_GameStateB {
	// ----Values/Enums----
	BootingGame_StartMenu_Demo = 0x0
	Started_MainMenu_InGame = 0x1
	OutroSequence = 0xE
	
	// ----Functions----
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:GameState_B", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))

	function on_change(enum_releaseRegion) =>
		this.current(enum_releaseRegion) != this.prev(enum_releaseRegion)	
	
	function is_active(enum_gameStateB, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_gameStateB

	function is_gameStarted(enum_releaseRegion) =>
		this.current(enum_releaseRegion) != this.BootingGame_StartMenu_Demo
} gameStateB = CLASS_MEMLOGIC_GameStateB()
// -------------------------------------
class CLASS_MEMLOGIC_Demo {
	// ----Values/Enums----
	FLAG_IsDemoActive_true = 1
	FLAG_IsDemoActive_false = 0

	// ----Functions----
	function is_active(enum_releaseRegion) =>
	 	bit2(memory.getAddress("BitFlag:IsDemoActive", enum_releaseRegion)) == this.FLAG_IsDemoActive_true
} demo = CLASS_MEMLOGIC_Demo()
// -------------------------------------
class CLASS_MEMLOGIC_OutroSequenceState {
	// ----Values/Enums----
	FirstTextParagraph = 0x0
	SecondTextParagraph = 0x1
	EndingScene = 0x2

	// ----Functions----
	function current(enum_ReleaseRegion) =>
		byte(memory.getAddress("8-bit:OutroSequenceState", enum_ReleaseRegion))
	function prev(enum_ReleaseRegion) =>
		prev(this.current(enum_ReleaseRegion))

	function is(enum_outroSequenceState, enum_ReleaseRegion) =>
		current(enum_ReleaseRegion) == enum_outroSequenceState
	function on_changeTo(enum_outroSequenceState, enum_ReleaseRegion) =>
		prev(enum_ReleaseRegion) != enum_outroSequenceState
		&& current(enum_ReleaseRegion) == enum_outroSequenceState	
} outroSequenceState = CLASS_MEMLOGIC_OutroSequenceState()

// #endregion GameStates

// ..................................................
// ◦ Story Progress & World Location Identification ◦
// ''''''''''''''''''''''''''''''''''''''''''''''''''
// #region Story Chapter Identification
class CLASS_MEMLOGIC_StoryChapterIdentification {
	Ch_0_TroubleAtEnrikuTemple = 0x1
	Ch_1_Investigation = 0x2
	Ch_2_SwordOfKusanagi = 0x3
	Ch_3_FalseEnemy = 0x4
	Ch_4_Pyramid = 0x5
	Ch_5_Underworld = 0x6
	Ch_6_Preperation = 0x7
	Ch_7_FinalBattle = 0x8

	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:StoryChapter_ID", enum_releaseRegion)) 
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))

	function on_change(enum_releaseRegion) =>
		this.current(enum_releaseRegion) != this.prev(enum_releaseRegion)

	function is(enum_storyChapterID, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_storyChapterID
	function on_changeTo(enum_storyChapterID, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != enum_storyChapterID
		&& this.current(enum_releaseRegion) == enum_storyChapterID

	function on_finish(enum_storyChapterID, enum_releaseRegion) {
		if (enum_storyChapterID == 7) memUtil.throwError("Ch_7_FinalBattle has no follow-up value on finishing the chapter/game")
		return 
			this.prev(enum_releaseRegion) == enum_storyChapterID
			&& this.current(enum_releaseRegion) == enum_storyChapterID +1}

} storyChapter = CLASS_MEMLOGIC_StoryChapterIdentification()
// #endregion Story Chapter Identification

// #region AdventureScene Identification
class CLASS_MEMLOGIC_AdventureSceneIdentification {
	// ----AdventureSceneIDs----
	SummitTemple_OnPlayerDeath = 0x0
	SummitTemple_GameStart = 0x0
	IzumoTown_Ch1 = 0x2
	IzumoShrine_Inside = 0x3
	IzumoShrine_OutsideBeforeBossFight = 0x4
	IzumoShrine_OutsideAfterBossFight = 0x5
	MtMiwa_Gate = 0x9
	AttaroShrine = 0xA
	MtMiwaTemple = 0x0f
	KashimaTemple_FirstVisit = 0x11
	MidoriHouse = 0x15
	MtHinokami = 0x3E  
	Dannoura_A = 0x18
	Dannoura_Y = 0x30
	UnderwaterShrine = 0x33
	Dannoura_IwatoBattle = 0x34
	SummitTemple_PostChapter2 = 0x35
	IzumoTemple_OutsideWithShimazuAsaka = 0x37
	IzumoTemple_InsideWithShimazuAsaka = 0x38
	ShimazuDeath = 0x39
	AmenoSpaceship = 0x3D
	Pyramid_SouthSide = 0x41
	Pyramid_EastSide = 0x43
	Pyramid_DarkRoom = 0x45
	ChizuSea = 0x4A
	IzanamiShrine = 0x4C
	YomotsuShrine = 0x4D
	KashimaTemple_PreFinalBattle = 0x59
	FinalBattle = 0x2F
	
	// ----Functions----
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:AdventureScene_ID", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))

	function is(enum_adventureSceneID, enum_releaseRegion) => 
		this.current(enum_releaseRegion) == enum_adventureSceneID
	function on_changeTo(enum_adventureSceneID, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != enum_adventureSceneID
		&& this.current(enum_releaseRegion) == enum_adventureSceneID

	// CheckIf: player is on Dannoura (Shimonoseki coast/sea) => by checking if current AdventureScene_ID is in valueRange[0x18-0x30], these are all scenes at Dannoura
	function is_atSeaOnDannoura(enum_releaseRegion) =>
		this.Dannoura_A <= this.current(enum_releaseRegion) && this.current(enum_releaseRegion) <= this.Dannoura_Y
} adventureScene = CLASS_MEMLOGIC_AdventureSceneIdentification()
class CLASS_MEMLOGIC_AdventureSceneColorIdentification {
	// ----AdventureSceneColorIDs----
	IzumoTown = [0x050A0106, 0x1a152a2f, 0x039080424] // --> [AdventureSceneColor_ID_A, AdventureSceneColor_ID_B, AdventureSceneColor_ID_C]

	// ----Functions----
	function current_ID_A(enum_releaseRegion) =>
		dword(memory.getAddress("92-bit:AdventureSceneColor_ID", enum_releaseRegion))
	function prev_ID_A(enum_releaseRegion) =>
		prev(this.current_ID_A(enum_releaseRegion))
	function current_ID_B(enum_releaseRegion) =>
		dword(memory.getAddress("92-bit:AdventureSceneColor_ID", enum_releaseRegion) +0x4)
	function prev_ID_B(enum_releaseRegion) =>
		prev(this.current_ID_B(enum_releaseRegion))
	function current_ID_C(enum_releaseRegion) =>
		dword(memory.getAddress("92-bit:AdventureSceneColor_ID", enum_releaseRegion) +0x8)
	function prev_ID_C(enum_releaseRegion) =>
		prev(this.current_ID_C(enum_releaseRegion))

	function is(enum_adventureSceneColor, enum_releaseRegion) =>
		this.current_ID_A(enum_releaseRegion) == enum_adventureSceneColor[0]
		&& this.current_ID_B(enum_releaseRegion) == enum_adventureSceneColor[1]
		&& this.current_ID_C(enum_releaseRegion) == enum_adventureSceneColor[2]
} adventureSceneColor = CLASS_MEMLOGIC_AdventureSceneColorIdentification()
// #endregion AdventureScene Identification

// #region Main Quest Progress
class CLASS_MEMLOGIC_MainQuestProgress {
	// ----Variables----
	FLAG_isEventCompleted_true = 0x1
	FLAG_isEventCompleted_false = 0x0

	// ----MainQuestEvents (enum = flagIndex in "FlagArray:MainQuestEventFlags")----
	Ch1_MysteryManDefeated = 5
	Ch1_MtMiwaGuardDefeated = 11
	Ch2_LuteSpiritVanquished = 11
	Ch2_AcquireSwordOfKusanagi = 18
	Ch3_AcquireBallOfShimazu = 3
	Ch3_ShimazuDeathEnd = 4
	Ch4_PyramidDemonDefeated = 6
	Ch5_LearnedToPlayHarp = 18
	Ch5_CerberusCalmed = 19
	Ch5_AcquiredMirror = 25
	Ch5_ShowIzanamiMirror = 26

	// ----Functions----
	function current_flagState(int_flagIndex, enum_releaseRegion) =>
		byte(memory.getAddress("FlagArray:MainQuestEventFlags", enum_releaseRegion) + int_flagIndex)
	function prev_flagState(int_flagIndex, enum_releaseRegion) => 
		prev(this.current_flagState(int_flagIndex, enum_releaseRegion))

	function is_eventCompleted(int_flagIndex, enum_releaseRegion) =>
		this.current_flagState(int_flagIndex, enum_releaseRegion) == this.FLAG_isEventCompleted_true
	
	// Progress completes sequentially through the FlagArray (event flags toggle true in ordered fashion)
	// Sums up all previous event flags leading up to an event to check if they are all true up to that point
	function is_priorEventsCompleted(enum_event, enum_releaseRegion) {
		if(enum_event < 1) return always_true()
		array_eventFlagIndicesToSum = []
		for let_index in range(0, enum_event -1)
			array_push(array_eventFlagIndicesToSum, let_index)
		return sum_of(array_eventFlagIndicesToSum, int_flagIndx => this.current_flagState(int_flagIndx, enum_releaseRegion)) == enum_event}

	// Identical to is_priorEventsCompleted(), but with "& 0x1" 
	//		--Reason--> very rarely, some main quest flags toggle true by writing a value != 0x1, but still > 0x0. 
	//				(eg. "Flag:MainQuestEventFlag_1" toggles true when picking up PyramidPoint (StorySection_4_Pyramid). WARNING: 0x9 is written to this address instead of 0x1)
	function is_priorEventsCompleted_bis(enum_event, enum_releaseRegion) {
		if(enum_event < 1) return always_true()
		array_eventFlagIndicesToSum = []
		for let_index in range(0, enum_event -1)
			array_push(array_eventFlagIndicesToSum, let_index)
		return sum_of(array_eventFlagIndicesToSum, int_flagIndx => this.current_flagState(int_flagIndx, enum_releaseRegion) & 0x1) == enum_event}

	function on_event_completion(enum_event, enum_releaseRegion) =>
		this.prev_flagState(enum_event, enum_releaseRegion) == this.FLAG_isEventCompleted_false
		&& this.current_flagState(enum_event, enum_releaseRegion) == this.FLAG_isEventCompleted_true
} mainQuest = CLASS_MEMLOGIC_MainQuestProgress()
// #endregion Main Quest Progress

// #region Misc Event Flags
class CLASS_MEMLOGIC_MiscEventFlags {
	// ----Variables----
	FLAG_isEventCompleted_true = 0x1
	FLAG_isEventCompleted_false = 0x0

	// ----MiscEvents (enum = flagIndex in "FlagArray:MiscEventFlags_A")----
	Ch2_SeaSpiritVanquished_atPier = 4
	Ch2_SeaSpiritVanquished_southEastOfHelmet = 5
	Ch2_SeaSpiritVanquished_atVajira = 6
	Ch2_SeaSpiritVanquished_southOfLute = 8
	Ch2_SeaSpiritVanquished_middleOfSea = 9
	Ch2_SeaSpiritVanquished_atHelmet = 10
	Ch2_LookAtFood_MidoriHouse = 0

	function current_flagState(int_flagIndex, enum_releaseRegion) =>
		byte(memory.getAddress("FlagArray:MiscEventFlags_A", enum_releaseRegion) + int_flagIndex)
	function prev_flagState(int_flagIndex, enum_releaseRegion) =>
		prev(this.current_flagState(int_flagIndex, enum_releaseRegion))
	
	function is_eventCompleted(int_flagIndex, enum_releaseRegion) =>
		this.current_flagState(int_flagIndex, enum_releaseRegion) == this.FLAG_isEventCompleted_true

} miscellaneousEvent = CLASS_MEMLOGIC_MiscEventFlags()
// #endregion Misc Event Flags

// #region Dialogue Text Identification
class CLASS_MEMLOGIC_DialogueTextIdentification {
	// ----Variables----
	FLAG_isAdventureModeDialogueTextDisplayed_true = 1
	FLAG_isAdventureModeDialogueTextDisplayed_false = 0

	// ----AdventureModeDialogueText_IDs----
	EnteringEnrikuTemple_A = 0x6 // "Kane: look at all the destruction!"
	FirstBossFight_A = 0x31 // "Mysterious Enemy: Kusanagi!!!" - After defeating 1st boss (mysterious man) at IzumoTemple
	FirstBossFight_B = 0x32 // "with that word, the mysterious enemy disappears!
	XRayGlasses_Use = 0xDA // "Kane puts on the X-Ray Glasses"
	XRayGlasses_Success = 0xEB // "Kane: I can see a chest on the seabed!"
	EatSpaghetti_A = 0x3b // "Kane: Thank You!"
	EatSpaghetti_B = 0x3c // "Kane accepts the item"
	EatSpaghetti_C = 0x3d // "Kane regains his strength"
	EatAtMidori_A = 0xb7 // "Kane picks up some chopsticks"
	EatAtMidori_Seaweed = 0xb8 // "Kane: That was great! You're a good cook!"
	EatAtMidori_Sushi = 0xb9 // "Kane: That fish looks good! Mm!"
	EatAtMidori_FriedEgg = 0xba // "Kane: Midori, I hope I marry as good a cook..."
	EatAtMidori_End = 0xbb // "Kane has recovered his strength"	
	UnderwaterShrine_TakeSwordOfKusanagi = 0x0130  // "Kane takes the real sword of kusanagi"
	IwatoBattleDannoura_SwordOfKusanagi_Use_A = 0x13A // "Kane brandishes the sword of Kusanagi" - Using Sword of Kusanagi against Iwato Family on Dannoura
	IwatoBattleDannoura_SwordOfKusanagi_Use_B = 0x13B // "The sword begins to release its pent-up energy."
	IwatoBattleDannoura_SwordOfKusanagi_Use_E = 0x013E // "The remnants of the men of Iwato begin to run!"
 	IwatoBattleDannoura_SwordOfKusanagi_Use_F = 0x013F // "Kane: The sword of Kusanagi saved me!..."
	ShimazuDeath_AcquireBall = 0x26 // "Shimazu: I meant to give you this before, but..."
	ShimazuDeath_AsakaLeaves = 0x2F // "with those words, Asaka disappears!"
	ArmorBracers_Use_A = [0x1BB, 0x7B] // "The glove on Kane's hand fits the hand imprint" 
	ArmorBracers_Use_B = [0x1BC, 0x7C] // "Computer: ID confirmation complete"
	ArmorBracers_Use_C = [0x1BD, 0x7D] // "Kane's mind merges with that of the serpent-god Ooku!"
	OokuSpeech = [0x1BE, 0x7E] // "Ooku: Long ago the Iwato ruled a highly advanced world..."
	OokuSpeech_Done = [0x1BF, 0x7F] // "Computer: Throttle up to..." - Just before heading of to pyramid
	PyramidDemonFelled_A = [0x1FB, 0xBB] // "Kane fells demon!"
	PyramidDemonFelled_B = [0x1FC, 0xBC] // "Demon: Impossible! I can not be killed..."
	PyramidDemonFelled_C = [0x1FD, 0xBD] // "Kane: The pyramid...!! It's collapsing! Run!"
	PyramidDemonFelled_D = [0x1FE, 0xBE] // "Grabbing Regina, Kane heads for the ship!"
	DrinkNectar_A = [0x217, 0xD7] // "Toyo: Come, come, join us and have some nectar!..." - Drinking nectar at Chizu Sea
	DrinkNectar_B = [0x218, 0xD8] // "Kane drinks some nectar and feels refreshed"
	DanceAtChizuSea_A = [0x21E, 0xDE] // "Kane draws his sword..." - Using Sword of Kusanagi at Chizu Sea
	DanceAtChizuSea_B = [0x21F, 0xDF] // "Others: A sword dance! Great! Come, come, dance!"
	DanceAtChizuSea_C = [0x220, 0xE0] // "Kane feels trapped and begins to dance reluctantly"
	DanceAtChizuSea_D = [0x221, 0xE1] // "Others: Ho, ho, ho! Great! Marvelous!"
	DanceAtChizuSea_E = [0x222, 0xE2] // "The room rings with applause!"
	MusicForCerberus_A = [0x255, 0x15] // "Kane plays the harp"
	MusicForCerberus_B = [0x25B, 0x1B] // "Cerberus sits and listens to the music"
	MusicForCerberus_C = [0x25C, 0x1C] // "The god named Yomotus can be seen in the shrine"
	MusicForCerberus_D = [0x25D, 0x1D] // "Yomotsu: Wonderful playing! What do you ask of me?"
	IzanamiKnowledge_A = [0x273, 0x33] // "Kane: Please tell me how to kill the Dark Lord!"
	IzanamiKnowledge_B = [0x274, 0x34] // "Izanami: There is only one way to kill the Dark Lord..."
	IzanamiKnowledge_C = [0x275, 0x35] // "Kane: Huh, Me?"
	IzanamiKnowledge_D = [0x276, 0x36] // "Izanami: You received a gift of increased power earlier..."
	IzanamiKnowledge_E = [0x277, 0x37] // "Kane: I go to my destiny!"
	IzanamiKnowledge_F = [0x278, 0x38] // "Kane mounts the Ameno and heads for Summit Temple"

	function current(enum_releaseRegion) =>
		word(memory.getAddress("16-bit:AdventureModeDialogueText_ID", enum_releaseRegion))
	function prior(enum_releaseRegion) =>
		prior(this.current(enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))

	function is(enum_dialogueText, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_dialogueText
	function wasPrior(enum_dialogueText, enum_releaseRegion) =>
		this.prior(enum_releaseRegion) == enum_dialogueText
	function wasPrev(enum_dialogueText, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == enum_dialogueText	
	
	function on_changeTo(enum_dialogueText, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != enum_dialogueText	
		&& this.current(enum_releaseRegion) == enum_dialogueText
	
	// ----------------------------
	function current_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) =>
		bit0(memory.getAddress("BitFlag:IsAdventureModeDialogueTextDisplayed", enum_releaseRegion))
	function prev_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) =>
		prev(this.current_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion))

	function is_textBox_displayed(enum_releaseRegion) =>
		this.current_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) == this.FLAG_isAdventureModeDialogueTextDisplayed_true
	function on_textBox_render(enum_releaseRegion) =>
		this.prev_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) == this.FLAG_isAdventureModeDialogueTextDisplayed_false
		&& this.current_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) == this.FLAG_isAdventureModeDialogueTextDisplayed_true

	function on_textBox_hide(enum_releaseRegion) =>
		this.prev_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) == this.FLAG_isAdventureModeDialogueTextDisplayed_true
		&& this.current_flagState_isAdventureModeDialogueTextDisplayed(enum_releaseRegion) == this.FLAG_isAdventureModeDialogueTextDisplayed_false
} dialogueText = CLASS_MEMLOGIC_DialogueTextIdentification()
// #endregion Dialogue Text Identification

// #region Adventure Command Menu 
class CLASS_MEMLOGIC_AdventureCommandMenu {
	// ----Variables----
	FLAG_IsAdventureModeMainCommandMenuDisplayed_true = 0x2
	// FLAG_IsAdventureModeMainCommandMenuDisplayed_false: AnyOtherValue != 0x2
	FLAG_IsAdventureModeSubCommandMenuDisplayed_true = 0x4
	// FLAG_IsAdventureModeSubCommandMenuDisplayed_false: AnyOtherValue != 0x4
	SubMenu_Move = 0x0
	SubMenu_Talk = 0x1
	SubMenu_Look = 0x2
	SubMenu_Take = 0x3
	SubMenu_Use = 0x4
	SubMenu_Spell = 0x5

	// ----Functions----
	function current_flagState_IsAdventureModeMainCommandMenuDisplayed(enum_releaseRegion) =>
		byte(memory.getAddress("Flag:IsAdventureModeMainCommandMenuDisplayed", enum_releaseRegion))
	function current_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) =>
		byte(memory.getAddress("Flag:IsAdventureModeSubCommandMenuDisplayed", enum_releaseRegion))
	function current_SelectedMainCommandMenuItem(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:SelectedMainCommandMenuItem", enum_releaseRegion))
	function current_SelectedSubMenuItem(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:SelectedSubMenuItem", enum_releaseRegion))
	function prev_flagState_IsAdventureModeMainCommandMenuDisplayed(enum_releaseRegion) =>
		prev(this.current_flagState_IsAdventureModeMainCommandMenuDisplayed(enum_releaseRegion))
	function prev_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) =>
		prev(this.current_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion))
	function prev_SelectedMainCommandMenuItem(enum_releaseRegion) =>
		prev(this.current_SelectedMainCommandMenuItem(enum_releaseRegion))
	function prev_SelectedSubMenuItem(enum_releaseRegion) =>
		prev(this.current_SelectedSubMenuItem(enum_releaseRegion))	

	function is_open(enum_releaseRegion) =>
		this.current_flagState_IsAdventureModeMainCommandMenuDisplayed(enum_releaseRegion) == this.FLAG_IsAdventureModeMainCommandMenuDisplayed_true
	
	function is_subMenu_open(enum_subMenu, enum_releaseRegion) =>
		this.current_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) == this.FLAG_IsAdventureModeSubCommandMenuDisplayed_true
		&& this.current_SelectedMainCommandMenuItem(enum_releaseRegion) == enum_subMenu

	function on_subMenu_render(enum_subMenu, enum_releaseRegion) =>
		this.prev_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) != this.FLAG_IsAdventureModeSubCommandMenuDisplayed_true
		&& this.current_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) == this.FLAG_IsAdventureModeSubCommandMenuDisplayed_true
		&& this.current_SelectedMainCommandMenuItem(enum_releaseRegion) == enum_subMenu
} adventureCommandMenu = CLASS_MEMLOGIC_AdventureCommandMenu()
// #endregion Adventure Command Menu 


// #region ActionMode Level Identification
class CLASS_MEMLOGIC_ActionModeLevelIdentification {
	PathToEnrikuTemple_Level_1 = 0x0003
	PathToEnrikuTemple_Level_2 = 0x0103
	PathToEnrikuTemple_Entrance = 0x0203
	PathToIzumoShrine_Level_1 = 0x0001
	PathToIzumoShrine_Level_2 = 0x0101
	PathToIzumoShrine_Entrance = 0x0201	
	PathToAttaroShrine_Level_1 = 0x0004
	PathToAttaroShrine_Entrance = 0x0104
	IzumoShrine_BossArena = 0x0202
	AttaroShrine_BossArena = 0x0106
	MtMiwaGate_BossArena = 0x0007 // Identical to below ID
	PathToMtMiwaTemple_Level_1 = 0x0007
	PathToMtMiwaTemple_Level_2 = 0x0107
	PathToMtMiwaTemple_Entrance = 0x0207
	PathToKashimaTemple_Level_1 = 0x0009
	PathToKashimaTemple_Entrance = 0x0109
	MtHinokami_Level_1 = 0x0012 // (only one action level for this section)
	MtHinokami_BossArena_A = 0x0013
	MtHinokami_BossArena_B = 0x0014
	MtMiwaTemple_BossArena = 0x0208
	KashimaTemple_BossArena = 0x010a
	Pyramid_DemonBossArena = 0x0017
	FinalBattle = 0x2F
	Pyramid_EyeMiniBossRoom = 0x0124
	Pyramid_GoatMiniBossRoom = 0x002a 
	Pyramid_Entrance = 0x0016 
	Pyramid_GroundFloor_Room_B = 0x001e
	Pyramid_GroundFloor_Room_C = 0x0026
	Pyramid_Floor_minus1_Room_A = 0x0021
	Pyramid_Floor_1_Room_A = 0x0116 
	Pyramid_Floor_1_Room_C = 0x0029
	Pyramid_Floor_1_Room_E = 0x012c
	Pyramid_Floor_1_Room_F = 0x002e

	dict_ActionLevelPlayerSpawnCoords = {
		PathToIzumoShrine_Level_1: {
			"StartOfActionLevel": [0x36, 0x80]}, // [x,y] --- "StartOfActionLevel" refers to left side of action level
		PathToAttaroShrine_Level_1: {
			"StartOfActionLevel": [0x36, 0x80]},
		MtMiwaGate_BossArena: {
			"StartOfActionLevel": [0x36, 0x80]},
		PathToKashimaTemple_Level_1: {
			"StartOfActionLevel": [0x36, 0x80]},
		MtHinokami_Level_1: {
			"StartOfActionLevel": [0x28, 0x70]},
		Pyramid_Entrance: {
			"StartOfActionLevel": [0x36, 0x80]},
		}
	function get_PlayerSpawnCoords_StartOfActionLevel(enum_actionLevel) => this.dict_ActionLevelPlayerSpawnCoords[enum_actionLevel]["StartOfActionLevel"]

	function current(enum_releaseRegion) =>
		word(memory.getAddress("16-bit:ActionModeLevel_ID", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	
	function is(enum_actionLevel, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_actionLevel

	function on_enter(enum_actionLevel, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != enum_actionLevel
		&& this.current(enum_releaseRegion) == enum_actionLevel
} actionLevel = CLASS_MEMLOGIC_ActionModeLevelIdentification()
// #endregion Main Quest Progress

// ....................
// ◦ Inventory & Gear ◦
// ''''''''''''''''''''
// #region Inventory & Gear
class CLASS_MEMLOGIC_Gear {
	// ----Variables----
	FLAG_IsGearAcquired_true = 1
	FLAG_IsGearAcquired_false = 0

	// ----Gear Enum (=flagIndex in "FlagArray:GearAcquiredFlags")----
	Armor_Bracers = 0
	Armor_Helmet = 1
	Armor_Body = 2
	Armor_Leg = 3
	Weapon_Dokko = 4
	Weapon_Trident = 5
	Weapon_Vajira = 6
	Weapon_WarHammer = 7

	// ----Functions----
	function current_flagState_IsGearAcquired(int_flagIndx, enum_releaseRegion) =>
		bit0(memory.getAddress("FlagArray:GearAcquiredFlags", enum_releaseRegion) + int_flagIndx)
	function prev_flagState_IsGearAcquired(int_flagIndx, enum_releaseRegion) =>
		prev(this.current_flagState_IsGearAcquired(int_flagIndx, enum_releaseRegion))

	function is_acquired(enum_gear, enum_releaseRegion) =>
		this.current_flagState_IsGearAcquired(enum_gear, enum_releaseRegion) == this.FLAG_IsGearAcquired_true

	function on_acquire(enum_gear, enum_releaseRegion) =>
		this.current_flagState_IsGearAcquired(enum_gear, enum_releaseRegion) > this.prev_flagState_IsGearAcquired(enum_gear, enum_releaseRegion) 
	
	function on_allGear_acquired(enum_releaseRegion) {
		let_array_AllGear = [
			this.Armor_Bracers, this.Armor_Helmet, this.Armor_Body, 
			this.Armor_Leg, this.Weapon_Dokko, this.Weapon_Trident, 
			this.Weapon_Vajira, this.Weapon_WarHammer]

		let_sumOf_currentFlagStates_IsGearAcquired =
			sum_of(let_array_AllGear, enum_gear =>
				this.current_flagState_IsGearAcquired(enum_gear, enum_releaseRegion))
		let_sumOf_prevFlagStates_IsGearAcquired =
			sum_of(let_array_AllGear, enum_gear =>
				this.prev_flagState_IsGearAcquired(enum_gear, enum_releaseRegion))
		return
			let_sumOf_prevFlagStates_IsGearAcquired == length(let_array_AllGear) -1
			&& let_sumOf_currentFlagStates_IsGearAcquired == length(let_array_AllGear)
		}
} gear = CLASS_MEMLOGIC_Gear()
//---------------------------
class CLASS_MEMLOGIC_Inventory {
	// ----Items (enum = flagIndex in "FlagArray:ItemInventoryFlags")----
	Ch2_Lute = 5
	Ch2_SwordOfKusanagi = 7
	Ch3_BallOfShimazu = 1
	Ch3_ArmorBracers = 2
	Ch5_SwordOfKusanagi = 0
	Ch5_MysticHarp = 3
	Ch5_SacredMirror = 6
	Ch7_Necklace = 3

	// ----Functions----
	function current_inventoryFlagState(int_flagIndex, enum_releaseRegion) => 
		byte(memory.getAddress("FlagArray:ItemInventoryFlags", enum_releaseRegion) + int_flagIndex)
	function prev_inventoryFlagState(int_flagIndex, enum_releaseRegion) => 
		prev(this.current_inventoryFlagState(int_flagIndex, enum_releaseRegion))

	function is_inInventory(enum_item, enum_releaseRegion) =>
		this.current_inventoryFlagState(enum_item, enum_releaseRegion) > 0 
	function on_acquire(enum_item, enum_releaseRegion) =>
		this.prev_inventoryFlagState(enum_item, enum_releaseRegion) == 0
		&& this.current_inventoryFlagState(enum_item, enum_releaseRegion) > 0
	function on_lose(enum_item, enum_releaseRegion) =>
		this.prev_inventoryFlagState(enum_item, enum_releaseRegion) > 0
		&& this.current_inventoryFlagState(enum_item, enum_releaseRegion) == 0
} item = CLASS_MEMLOGIC_Inventory()
// #endregion Inventory & Gear

// ............
// ◦ Entities ◦
// ''''''''''''
// #region Entities
class CLASS_MEMLOGIC_MiscEntities {
	Orb = 100
	PyramidOrb = 101

	dict_MiscEntitiesData = {
		Orb: {
			"EntityID": 0x5C,
			},
		PyramidOrb:  {
			"EntityID": 0x14,
			"StructAddressKey": "Struct:Entity(Pyramid_Orb)",
			},
		}

	dict_PyramidOrbData = { // Big Blue Orbs documented according to Pyramid Map --> https://gamefaqs.gamespot.com/sms/588147-spellcaster/map/12810-mount-minakami-pyramid-map (J & G on map are boss drops)
		"Orb_C": {
			"ActionModeLevel_ID": actionLevel.Pyramid_GroundFloor_Room_B,
			},
		"Orb_E": {
			"ActionModeLevel_ID": actionLevel.Pyramid_GroundFloor_Room_C,
			},
		"Orb_F": {
			"ActionModeLevel_ID": actionLevel.Pyramid_Floor_minus1_Room_A ,
			},
		"Orb_H": {
			"ActionModeLevel_ID": actionLevel.Pyramid_Floor_1_Room_C,
			},
		"Orb_K": {
			"ActionModeLevel_ID": actionLevel.Pyramid_Floor_1_Room_E,
			},
	}
	function get_EntityID(enum_miscEntity) => this.dict_MiscEntitiesData[enum_miscEntity]["EntityID"]
	function get_StructAddressKey(enum_miscEntity) => this.dict_MiscEntitiesData[enum_miscEntity]["StructAddressKey"]
	
	function current_ID(enum_miscEntity, enum_releaseRegion) {
		let_EntityStructAddr = memory.getAddress(this.get_StructAddressKey(enum_miscEntity), enum_releaseRegion)
		let_memAddr_MiscEntity_ID = let_EntityStructAddr + memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_ID")
		return byte(let_memAddr_MiscEntity_ID)}
	function prev_ID(enum_miscEntity, enum_releaseRegion) =>
		prev(this.current_ID(enum_miscEntity, enum_releaseRegion))

	// CheckIf: entity despawns by confirming if the entity struct is zeroed out
	function on_despawn(enum_miscEntity, enum_releaseRegion) =>
		this.prev_ID(enum_miscEntity, enum_releaseRegion) == this.get_EntityID(enum_miscEntity)
		&& this.current_ID(enum_miscEntity, enum_releaseRegion) == 0

} miscEntity = CLASS_MEMLOGIC_MiscEntities()

class CLASS_MEMLOGIC_PlayerProjectileEntities {		 
	BasicAttack = 100
	Fudo = 110

	BasicAttack_ChargeState_nonCharged = 0x0
	BasicAttack_ChargeState_semiCharged = 0x1
	BasicAttack_ChargeState_fullyCharged = 0x2

	array_PlayerProjectileStructLocationIDs = [
		"A", // Struct:Entity(Player_Projectile_A)]
		"B", // Struct:Entity(Player_Projectile_B)]
		"C", // ...
		"D",
		"E"]
	dict_PlayerProjectileData = {
		BasicAttack: {
			"EntityID": 0x13,
			},
		Fudo: {
			"EntityID": 0x18,
			},
		}
	function get_EntityID(enum_playerProjectile) => this.dict_PlayerProjectileData[enum_playerProjectile]["EntityID"]

	function current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) {
		let_memAddr_playerProjectileStruct = memory.getAddress(format("Struct:Entity(Player_Projectile_{0})", char_playerProjectileStructLocationID), enum_releaseRegion)
		let_offsetToMember_EntityID = memory.getStruct_OffsetToMember("Struct:Entity(PC_BasicAttack)", "8-bit:Entity_ID")
		return byte(let_memAddr_playerProjectileStruct + let_offsetToMember_EntityID)}
	function prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) =>
		prev(this.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion))
	function current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) {
		let_memAddr_playerProjectileStruct = memory.getAddress(format("Struct:Entity(Player_Projectile_{0})", char_playerProjectileStructLocationID), enum_releaseRegion)
		let_offsetToMember_ChargeState = memory.getStruct_OffsetToMember("Struct:Entity(PC_BasicAttack)", "8-bit:BasicAttack_Charge_State")
		return byte(let_memAddr_playerProjectileStruct + let_offsetToMember_ChargeState)}
	function prev_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) =>
		prev(this.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion))

	// WARNING: return a comparison with HitCounts (AnyOf masked within a Tally)
	// CheckIf: Any of the 5 player projectile entity struct locations is active && is a basic attack && is not charged
	function on_basicAttack_nonCharged_cast(enum_releaseRegion) =>
		tally_of(this.array_PlayerProjectileStructLocationIDs, 1, char_playerProjectileStructLocationID =>  
			this.prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == 0
			&& this.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == this.get_EntityID(this.BasicAttack)
			&& this.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) == this.BasicAttack_ChargeState_nonCharged
		)
	
	// WARNING: return a comparison with HitCounts (AnyOf masked within a Tally)
	// CheckIf: Any of the 5 player projectile entity struct locations is active && is a basic attack && is semi charged
	function on_basicAttack_semiCharged_cast(enum_releaseRegion) =>
		tally_of(this.array_PlayerProjectileStructLocationIDs, 1, char_playerProjectileStructLocationID =>  
			this.prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == 0
			&& this.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == this.get_EntityID(this.BasicAttack)
			&& this.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) == this.BasicAttack_ChargeState_semiCharged
		)

	// WARNING: return a comparison with HitCounts (AnyOf masked within a Tally)
	// CheckIf: Any of the 5 player projectile entity struct locations is active && is a basic attack && is fully charged
	function on_basicAttack_fullyCharged_cast(enum_releaseRegion) =>
		tally_of(this.array_PlayerProjectileStructLocationIDs, 1, char_playerProjectileStructLocationID =>  
			this.prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == 0
			&& this.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == this.get_EntityID(this.BasicAttack)
			&& this.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) == this.BasicAttack_ChargeState_fullyCharged
		)

} playerProjectile = CLASS_MEMLOGIC_PlayerProjectileEntities()

class CLASS_MEMLOGIC_BossEntities {
	MysteriousEnemy = 100
	Jukak = 101
	Wakahiko = 102
	KashimaFireBoss = 103
	PyramidDemon = 104
	MtMiwaGuard = 105
	Kezeus = 106
	DaikokRobot = 107
	
	Eye = 301
	Goat = 302

	dict_BossData = { // TODO put dict_BossData info into codenotes
		MysteriousEnemy: {
			"EntityID": 0x5e,
			"EntityStartHP": 0x32,
			"BossArena_ActionModeLevel_ID": actionLevel.IzumoShrine_BossArena,
			"StructLocation": "C"},
		Jukak: {
			"EntityID": 0x65,
			"EntityStartHP": 0x32,
			"BossArena_ActionModeLevel_ID": actionLevel.AttaroShrine_BossArena,
			"StructLocation": "C"},
		MtMiwaGuard: {
			"EntityID": 0x60,
			"EntityStartHP": 0x30,
			"BossArena_ActionModeLevel_ID": actionLevel.MtMiwaGate_BossArena,
			"StructLocation": "C"},
		Wakahiko: {
			"EntityID": 0x62,
			"EntityStartHP": 0x3c,
			"BossArena_ActionModeLevel_ID": actionLevel.MtMiwaTemple_BossArena,
			"StructLocation": "C"},
		KashimaFireBoss: {
			"EntityID": 0x70,
			"EntityStartHP": 0x3c,
			"BossArena_ActionModeLevel_ID": actionLevel.KashimaTemple_BossArena,
			"StructLocation": "C"},
		Kezeus: {
			"EntityID": 0x34, // 0x34 => moving, 0x35 => idle/attacking (spawns with 0x34, can die with 0x35)
			"EntityID_Alt": 0x35,
			"EntityStartHP": 0x50,
			"BossArena_ActionModeLevel_ID": actionLevel.MtHinokami_BossArena_A,
			"StructLocation": "A"},
		DaikokRobot: {
			"EntityID": 0x9B,
			"EntityStartHP": 0x32,
			"BossArena_ActionModeLevel_ID": actionLevel.MtHinokami_BossArena_B,
			"StructLocation": "D"},
		PyramidDemon: {
			"EntityID": 0x41,
			"EntityStartHP": 0x64,
			"BossArena_ActionModeLevel_ID": actionLevel.Pyramid_DemonBossArena,
			"StructLocation": "A"},
		Eye: {
			"EntityID": 0xA3,
			"EntityStartHP": 0x28,
			"BossArena_ActionModeLevel_ID": actionLevel.Pyramid_EyeMiniBossRoom,
			"StructLocation": "C"},
		Goat: {
			"EntityID": 0xA1,
			"EntityStartHP": 0x28,
			"BossArena_ActionModeLevel_ID": actionLevel.Pyramid_GoatMiniBossRoom,
			"StructLocation": "C"},
		}
	function get_EntityID(enum_boss) => this.dict_BossData[enum_boss]["EntityID"]
	function get_EntityID_alt(enum_boss) => this.dict_BossData[enum_boss]["EntityID_Alt"]
	function get_EntityStartHP(enum_boss) => this.dict_BossData[enum_boss]["EntityStartHP"]
	function get_BossArena_ActionModeLevel_ID(enum_boss) => this.dict_BossData[enum_boss]["BossArena_ActionModeLevel_ID"]
	function get_StructLocation(enum_boss) => this.dict_BossData[enum_boss]["StructLocation"]
	
	function current_ID(enum_boss, enum_releaseRegion) {
		let_memAddr_Struct_BossEntity = memory.getAddress(format("Struct:Entity(boss)_{0}", this.get_StructLocation(enum_boss)), enum_releaseRegion) 
		let_memAddr_BossEntity_ID = let_memAddr_Struct_BossEntity + memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_ID")
		return byte(let_memAddr_BossEntity_ID)}
	function prev_ID(enum_boss, enum_releaseRegion) =>
		prev(this.current_ID(enum_boss, enum_releaseRegion))
	function current_HP(enum_boss, enum_releaseRegion) {
		let_offsetToMember_EntityHP = memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_HP")
		let_memAddr_Struct_BossEntity = memory.getAddress(format("Struct:Entity(boss)_{0}", this.get_StructLocation(enum_boss)), enum_releaseRegion) 
		return byte(let_memAddr_Struct_BossEntity + let_offsetToMember_EntityHP)}
	function prev_HP(enum_boss, enum_releaseRegion) =>
		prev(this.current_HP(enum_boss, enum_releaseRegion))

	function is_atMaxHP(enum_boss, enum_releaseRegion) =>
		this.current_HP(enum_boss, enum_releaseRegion) == this.get_EntityStartHP(enum_boss)
	function is_belowMaxHP(enum_boss, enum_releaseRegion) =>
		this.current_HP(enum_boss, enum_releaseRegion) < this.get_EntityStartHP(enum_boss)
	
	// CheckIf: boss spawns by confirming if EntityID and MaxHP is set (in one frame)
	function on_spawn(enum_boss, enum_releaseRegion) {
		let_memAddr_Struct_BossEntity = memory.getAddress(format("Struct:Entity(boss)_{0}", this.get_StructLocation(enum_boss)), enum_releaseRegion) 
		let_memAddr_BossEntity_ID = let_memAddr_Struct_BossEntity + memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_ID")
		return
			this.prev_ID(enum_boss, enum_releaseRegion) != this.get_EntityID(enum_boss)
			&& this.current_ID(enum_boss, enum_releaseRegion) == this.get_EntityID(enum_boss)
			&& this.prev_HP(enum_boss, enum_releaseRegion) != this.get_EntityStartHP(enum_boss)
			&& this.current_HP(enum_boss, enum_releaseRegion) == this.get_EntityStartHP(enum_boss)
			}
	
	// Entity dies when: HP hits 0x0 OR when HP overflows negatively (eg. HP at 15, takes 20 damage ===> 0xF(15)-15 = 0x0 ===> 0x0(0)-1 = 0xFF ===> 0xFF(255) - 4 = 251)
	function on_HP_hitsZero(enum_boss, enum_releaseRegion) =>
		1 <= this.prev_HP(enum_boss, enum_releaseRegion) && this.prev_HP(enum_boss, enum_releaseRegion) <= 50
		&& this.current_HP(enum_boss, enum_releaseRegion) == 0	
	function on_HP_negativelyOverflows(enum_boss, enum_releaseRegion) =>
		0 <= this.prev_HP(enum_boss, enum_releaseRegion) && this.prev_HP(enum_boss, enum_releaseRegion) <= 50
		&& 200 <= this.current_HP(enum_boss, enum_releaseRegion) && this.current_HP(enum_boss, enum_releaseRegion) <= 255

	// CheckIf: boss dies by confirming if the boss entity struct changes into an orb entity struct
	function on_death(enum_boss, enum_releaseRegion) =>
		this.prev_ID(enum_boss, enum_releaseRegion) == this.get_EntityID(enum_boss)
		&& this.current_ID(enum_boss, enum_releaseRegion) == miscEntity.get_EntityID(miscEntity.Orb)
	function on_death_alt(enum_boss, enum_releaseRegion) =>
		this.prev_ID(enum_boss, enum_releaseRegion) == this.get_EntityID_alt(enum_boss)
		&& this.current_ID(enum_boss, enum_releaseRegion) == miscEntity.get_EntityID(miscEntity.Orb)
				
	// CheckIf: boss despawns by confirming if boss entity struct is zeroed out
	function on_despawn(enum_boss, enum_releaseRegion) =>
		this.prev_ID(enum_boss, enum_releaseRegion) == this.get_EntityID(enum_boss)
		&& this.current_ID(enum_boss, enum_releaseRegion) == 0

	function is_bossArena_active(enum_boss, enum_releaseRegion) =>
		actionLevel.is(this.get_BossArena_ActionModeLevel_ID(enum_boss), enum_releaseRegion)
	function on_bossArena_enter(enum_boss, enum_releaseRegion) =>
		actionLevel.on_enter(this.get_BossArena_ActionModeLevel_ID(enum_boss), enum_releaseRegion) 


} bossEnemy = CLASS_MEMLOGIC_BossEntities()
// #endregion Entities

// ..........................
// ◦ Player Character Logic ◦
// ''''''''''''''''''''''''''
// #region Player Character Logic
class CLASS_MEMENUM_Spells {
	Hakuji = 0x1
	Indra = 0x2
	Fudo = 0x3
	Kannon = 0x4
	Hatten = 0x5
	Mars = 0x6
	Makiri = 0x7
	Nobota = 0x8

	dict_spellData = {
		Hakuji: {
			"ENGY_Cost": 3
			},
		Indra: {
			"ENGY_Cost": 10
			},
		Fudo: {
			"ENGY_Cost": 20
			},
		Kannon: {
			"ENGY_Cost": 5
			},
		Hatten: {
			"ENGY_Cost": 10
			},
		Mars: {
			"ENGY_Cost": 25
			},
		Makiri: {
			"ENGY_Cost": 20
			},
		Nobota: {
			"ENGY_Cost": 30
			},
		}

	function get_ENGY_Cost(enum_spell) => 
		this.dict_spellData[enum_spell]["ENGY_Cost"]
} spell = CLASS_MEMENUM_Spells()
class CLASS_MEMLOGIC_PlayerCharacterLogic {
	// ----Variables----
	// FLAG_IsPlayerDead_false: anyOtherValue => false
	FLAG_IsPlayerDead_true = 0x8F

	
	function current_STGH(enum_releaseRegion) =>
		bcd(word(memory.getAddress("BCD:Player_Strength", enum_releaseRegion)))
	function prev_STGH(enum_releaseRegion) =>
		prev(this.current_STGH(enum_releaseRegion))
	function current_ENGY(enum_releaseRegion) =>
		bcd(word(memory.getAddress("BCD:Player_Energy", enum_releaseRegion)))
	function prev_ENGY(enum_releaseRegion) =>
		prev(this.current_ENGY(enum_releaseRegion))		
	
	function on_ENGY_refill(enum_releaseRegion) =>
		this.prev_ENGY(enum_releaseRegion) < this.current_ENGY(enum_releaseRegion)
	
	function on_STGH_refill(enum_releaseRegion) =>
		this.prev_STGH(enum_releaseRegion) < this.current_STGH(enum_releaseRegion)
	
	function on_STGH_decrement(enum_releaseRegion) =>
		this.current_STGH(enum_releaseRegion) < this.prev_STGH(enum_releaseRegion)
	
	function on_STGH_decrementBy(int_decrementAmount, enum_releaseRegion) {
		// DEV_NOTE: [delta BCD] & [current BCD] value math: 
			// PROBLEM --> can only easily read [current BCD] via RAIntegration. [delta BCD] cannot work in below code correctly
			//		 this.prev_STGH(enum_releaseRegion) - this.current_STGH(enum_releaseRegion)  == int_decrementAmount
			//
			// SOLUTION --> read each hex number seperately (only necessary for the delta value), refer to solution below

		let_memAddr_16BitBCD = memory.getAddress("BCD:Player_Strength", enum_releaseRegion)
		return 
			this.prev_STGH(enum_releaseRegion) > this.current_STGH(enum_releaseRegion)
			&& prev(high4(let_memAddr_16BitBCD + 0x1))		*1000 	// --> DEV_NOTE - SOLUTION <-- 	Be wary of endianness 
				+ prev(low4(let_memAddr_16BitBCD + 0x1)) 	*100
				+ prev(high4(let_memAddr_16BitBCD))			*10
				+ prev(low4(let_memAddr_16BitBCD))			*1
				- this.current_STGH(enum_releaseRegion) == int_decrementAmount
		}
	
	function on_ENGY_decrement(enum_releaseRegion) =>
		this.current_ENGY(enum_releaseRegion) < this.prev_ENGY(enum_releaseRegion)
	
	function current_xLocation(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:PC_xLocation", enum_releaseRegion))
	function prev_xLocation(enum_releaseRegion) =>
		prev(this.current_xLocation(enum_releaseRegion))
	function current_yLocation(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:PC_yLocation", enum_releaseRegion))
	function prev_yLocation(enum_releaseRegion) =>
		prev(this.current_yLocation(enum_releaseRegion))
	
	// CheckIf: Player spawns at the start of an action level, by confirming if delta location == 0 && current location == valid
	function on_spawn_atStartOfActionLevel(enum_actionLevel, enum_releaseRegion) {
		let_coords_PlayerSpawn_StartOfActionLevel = actionLevel.get_PlayerSpawnCoords_StartOfActionLevel(enum_actionLevel)
		return
			this.prev_xLocation(enum_releaseRegion) == 0
			&& this.current_xLocation(enum_releaseRegion) == let_coords_PlayerSpawn_StartOfActionLevel[0]
			&& this.prev_yLocation(enum_releaseRegion) == 0
			&& this.current_yLocation(enum_releaseRegion) == let_coords_PlayerSpawn_StartOfActionLevel[1]
		}
	
	function current_spellSelected(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:SelectedSpell", enum_releaseRegion))

	function current_flagState_IsPlayerDead(enum_releaseRegion) =>
		byte(memory.getAddress("Flag:IsPlayerDead", enum_releaseRegion))
	function prev_flagState_IsPlayerDead(enum_releaseRegion) =>
		prev(this.current_flagState_IsPlayerDead(enum_releaseRegion))

	function is_alive(enum_releaseRegion) =>
		this.current_flagState_IsPlayerDead(enum_releaseRegion) != this.FLAG_IsPlayerDead_true

	function on_death(enum_releaseRegion) =>
		this.prev_flagState_IsPlayerDead(enum_releaseRegion) != this.FLAG_IsPlayerDead_true
		&& this.current_flagState_IsPlayerDead(enum_releaseRegion) == this.FLAG_IsPlayerDead_true

	function on_spellCast(enum_spell, enum_releaseRegion) =>
		this.current_spellSelected(enum_releaseRegion) == enum_spell
		&& this.on_ENGY_decrement(enum_releaseRegion)
} player = CLASS_MEMLOGIC_PlayerCharacterLogic()

class CLASS_MEMLOGIC_PlayerControllerInput {
	// ---Variables/Enums---
	Dpad_Up = 0 // (= bitIndex)
	Dpad_Down = 1
	Dpad_Left = 2
	Dpad_Right = 3
	Button_Left = 4
	Button_Right = 5
	// ---Functions---
	function current_flagState_playerInput(int_bitIndex, enum_releaseRegion) {
		let_function_bitMemAccessor = memUtil.bitIndexToBitMemoryAccessor(int_bitIndex)
		return let_function_bitMemAccessor(memory.getAddress("BitFlags:PlayerInput", enum_releaseRegion))}
	function prev_flagState_playerInput(int_bitIndex, enum_releaseRegion) =>
		prev(this.current_flagState_playerInput(int_bitIndex, enum_releaseRegion))

	function on_press(enum_input, enum_releaseRegion) =>
		this.current_flagState_playerInput(enum_input, enum_releaseRegion) > this.prev_flagState_playerInput(enum_input, enum_releaseRegion)
} playerInput = CLASS_MEMLOGIC_PlayerControllerInput()
// #endregion Player Character Logic

// ................
// ◦ Sub_Header_2 ◦
// ''''''''''''''''
// #region Sub_Header_2

// #endregion Sub_Header_2

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
// • ACHIEVEMENT sub logic •
// =========================
// #region ACH - sub logic
//	- For achievement logic that's reoccuring across multiple triggers
class CLASS_AchievementSubLogic {
	// NOTE: Returns a PauseLock, which locks when the player exceeds an energy allowance. Concretely it locks when ENGY use > int_energyAllowance
	// Function Output (snippet): 
		// ...
		// for let_i in range(0, 25 -1) // --> spell.Mars costs 25 ENGY --> addHit 25 times on same frame
		// 	array_push(let_array_HitCounts, repeated(const_ALLOWED_ENGY_TO_USE, player.on_spellCast(spell.Mars, enum_releaseRegion))) 
		// for let_i in range(0, 20 -1) // --> spell.Makiri costs 20 ENGY --> addHit 20 times on same frame
		// 	array_push(let_array_HitCounts, repeated(const_ALLOWED_ENGY_TO_USE, player.on_spellCast(spell.Makiri, enum_releaseRegion)))
		// ...
	function PauseLock_playerExceedsEnergyAllowance(int_energyAllowance, enum_releaseRegion) {
		let_array_HitsToCount = []
		for enum_spell in spell.dict_spellData {
			for let_i in range(0, spell.get_ENGY_Cost(enum_spell) -1)
				array_push(let_array_HitsToCount, repeated(int_energyAllowance, player.on_spellCast(enum_spell, enum_releaseRegion)))
			}
		return unless(tally(int_energyAllowance +1, let_array_HitsToCount))}
	
	
	// NOTE: Creates a PauseLock that triggers when the player exceeds a defined energy allowance.
		// Mechanic:
		// - Each spell cast adds "hits" equal to its ENGY cost.
		// - These hits accumulate toward the energy allowance limit.
		// - When the total exceeds the allowance, the PauseLock activates.
		//
		// Recovery:
		// - Taking STGH damage reduces accumulated hits.
		// - The amount of STGH lost in a single frame determines how many hits are removed.
		// - This effectively restores available energy capacity.
		//
		// Summary:
		// Spell casting consumes allowance → STGH damage restores allowance.
		// The PauseLock remains active unless total hits stay within the allowed threshold.
	function PauseLock_playerExceedsEnergyAllowance_withAllowanceRegainOnHPloss(int_energyAllowance, enum_releaseRegion) {
		let_int_HighestSingleHitPlayerCanReceive = 15 // within one frame
		let_array_HitsToCount = []
		for enum_spell in spell.dict_spellData { // --AddHits--> When player casts a spell --> Spell ENGY cost == Hits Added 
			for let_i in range(0, spell.get_ENGY_Cost(enum_spell) -1)
				array_push(let_array_HitsToCount, repeated(999999999, player.on_spellCast(enum_spell, enum_releaseRegion)))
			}
		
		for let_index_1 in range(1, let_int_HighestSingleHitPlayerCanReceive) { // --DeductHits--> When player takes STGH damage --> amount of STGH dmg in single frame == Hits Deducted
			for let_index_2 in range(1, let_index_1)
				array_push(let_array_HitsToCount, deduct(repeated(999999999, player.on_STGH_decrementBy(let_index_1, enum_releaseRegion))))
		}
		return unless(tally(int_energyAllowance +1, let_array_HitsToCount))}

	// NOTE: Returns a Measured, tracking how much ENGY is still allowed to be used, starts at max, deducts when using ENGY
	function Measured_trackEnergyAllowance(int_energyAllowance, enum_releaseRegion, requirement_when) {
		if(int_energyAllowance % 2 == 1) memUtil.throwError("Prefer using an even number for int_energyAllowance")
		let_array_HitsToCount = [
			repeated(int_energyAllowance/2, always_true()), // --AddHits--> base value for measured
			repeated(int_energyAllowance/2, always_true())]

		for enum_spell in spell.dict_spellData { // --DeductHits--> When player casts a spell --> Spell ENGY cost == Hits Deducted 
			for let_i in range(0, spell.get_ENGY_Cost(enum_spell) -1)
				array_push(let_array_HitsToCount, deduct(repeated(int_energyAllowance, player.on_spellCast(enum_spell, enum_releaseRegion))))
			}
		return measured(tally(int_energyAllowance, let_array_HitsToCount), when = requirement_when)}
		
	// NOTE: // Creates a Measured value that tracks how much energy allowance remains.
		// Mechanic:
		// - Starts with a full allowance (int_energyAllowance), split into two equal base contributions.
		// - This ensures the measured value begins at maximum capacity.
		//
		// Consumption:
		// - Casting spells deducts "hits" equal to their ENGY cost.
		// - These hits reduce the remaining allowance.
		//
		// Recovery:
		// - Taking STGH damage adds hits back.
		// - The amount of STGH lost in a single frame determines how many hits are restored.
		// - This effectively replenishes available energy capacity.
		//
		// Constraints:
		// - int_energyAllowance must be even (used to evenly initialize the base value).
		//
		// Summary:
		// Spell casting reduces remaining allowance → STGH damage restores it.
		// The Measured output reflects current usable energy under the given condition.
	function Measured_trackEnergyAllowance_withAllowanceRegainOnHPloss(int_energyAllowance, enum_releaseRegion, requirement_when) {
		if(int_energyAllowance % 2 == 1) memUtil.throwError("Prefer using an even number for int_energyAllowance")
		let_int_HighestSingleHitPlayerCanReceive = 15 // within one frame

		let_array_HitsToCount = [
			repeated(int_energyAllowance/2, always_true()), // --AddHits--> base value for measured
			repeated(int_energyAllowance/2, always_true())]

		for enum_spell in spell.dict_spellData { // --DeductHits--> When player casts a spell --> Spell ENGY cost == Hits Deducted 
			for let_i in range(0, spell.get_ENGY_Cost(enum_spell) -1)
				array_push(let_array_HitsToCount, deduct(repeated(999999999, player.on_spellCast(enum_spell, enum_releaseRegion))))
			}
		
		for let_index_1 in range(1, let_int_HighestSingleHitPlayerCanReceive) { // --AddHits--> When player takes STGH damage --> amount of STGH dmg in single frame == Hits Added
			for let_index_2 in range(1, let_index_1)
				array_push(let_array_HitsToCount, repeated(999999999, player.on_STGH_decrementBy(let_index_1, enum_releaseRegion)))
		}
		return measured(tally(int_energyAllowance, let_array_HitsToCount), when = requirement_when)}
} achievementSubLogic = CLASS_AchievementSubLogic()
// #endregion ACH - trigger generators

// ====================
// • ACHIEVEMENT logic •
// ====================
// - Divided by category => when in debug mode, category tags are added to achievement titles
class CLASS_ENUM_AchievementPointClasses {
	Free_0 			= 0		// Free - Freebie/informational achievement
	Minor_1			= 1 	// Minor - Finding a hidden item, do some arbitrary/easter egg task
	Basic_2			= 2 	// Basic - Defeating a few enemies
	Easy_3			= 3 	// Easy - Completing an easy quest or level
	Intermediate_4	= 4 	// Intermediate - Completing a harder quest or level
	Advanced_5		= 5 	// Advanced - Collecting rare items or completing a level
	Challenging_10	= 10	// Challenging - Defeating a major boss or collecting a VERY rare one-of-a-kind item
	Hard_25			= 25 	// Hard - Completing the game 
	VeryHard_50		= 50 	// VeryHard - Achieving 100% completion
	Impossible_100	= 100 	// Impossible - Completing the game without taking a hit (extreme challenge achievements, typical for bonus sets)
} ENUM_AchievementPointClass = CLASS_ENUM_AchievementPointClasses()

class CLASS_ENUM_AchievementTypes {
	Progression = "progression"
	WinCondition = "win_condition"
	Missable = "missable"
	Standard = ""
} ENUM_AchievementType = CLASS_ENUM_AchievementTypes()

class CLASS_AchievementLogic {
// #region ACH - Core Data
dict_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
		// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_StoryProgress": { // Story Progression
		// "a_Ch1MysteryMan": { // VERIFIED
			// "id": 606009, "points": ENUM_AchievementPointClass.Basic_2, "devInfo": "Defeating Mysterious Man at IzumoTemple (StoryChapter_1)"},
		// "a_Ch1KashimaBoss": { // VERIFIED
			// "id": 608244, "points": ENUM_AchievementPointClass.Intermediate_4, "devInfo": "Stop the Serpent God calling at Kashima (after defeating Kashima Fire Boss) (StoryChapter_1)"},
		// "a_Ch2SwordKusanagi": { // VERIFIED
			// "id": 608452, "points": ENUM_AchievementPointClass.Basic_2, "devInfo": "Acquire Sword of Kusanagi at Underwater shrine + then use it to vanquish Iwato family at sea (showcasing it's power)"},
		// "a_Ch3Shimazu": { // VERIFIED
			// "id": 608453, "points": ENUM_AchievementPointClass.Advanced_5, "devInfo": "Unearthing some of the true intentions of the Iwato, after Shimazu's death"},
		// "a_Ch3Ameno": { // VERIFIED
			// "id": 608595, "points": ENUM_AchievementPointClass.Basic_2, "devInfo": "Start up spaceship Ameno and be enlightened by Serpent God Ooku"},
		// "a_Ch4Demon": { // VERIFIED
			// "id": 608674, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Defeat the pyramid demon"},
		// "a_Ch5Yomotsu": { // VERIFIED
			// "id": 608684, "points": ENUM_AchievementPointClass.Easy_3, "devInfo": "Reach an audience with the God Yomotsu"},
		// "a_Ch5Izanami": { // VERIFIED
			// "id": 608685, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Acquire all knowledge & power to defeat the evil lord"},
		},
	"c_WinCondition": { // Win Condition - Finishing the game
		// "a_SlayEvilLord": { // VERIFIED
			// "id": 608733, "points": ENUM_AchievementPointClass.Hard_25, "devInfo": "Defeat the evil lord"},		
		},
	"c_Challenge": { // Challenges
		// "a_ClgEnrikuTemple": { // VERIFIED
			// "id": 609158, "points": ENUM_AchievementPointClass.Intermediate_4, "devInfo": "(one session) Reach Enriku Temple without taking any HP damage"},
		// "a_ClgIzumoShrine": { // VERIFIED
			// "id": 609448, "points": ENUM_AchievementPointClass.Intermediate_4, "devInfo": "(one session) Reach Izumo Temple and kill the Mysterious Enemy within xx seconds"},
		// "a_ClgAttaroShrine": { // VERIFIED
			// "id": 609504, "points": ENUM_AchievementPointClass.Advanced_5, "devInfo": "Reach Attaro Shrine using only fully charged ki attacks and with only 3 allowed usages of the Makiri spell"},
		// "a_ClgMtMiwa": { // VERIFIED
			// "id": 609859, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Reach Miwa Temple and defeat both bosses, using only xx amount of ENGY, FUDO spell is disallowed"},
		// "a_ClgKashimaTemple": { // VERIFIED
			// "id": 610381, "points": 0000000, "devInfo": "Reach Kashima Temple and defeat boss, using only one defensive spell of choice, with only 2 allowed activations"},
		// "a_ClgMtHinokami": { // VERIFIED
			// "id": 610416, "points": 0000000, "devInfo": "Reach Mt Hinokami and defeat bosses, don't use more than the allowed ENGY allowance, ENGY allowance is regained when taking damage"},
		"a_ClgPyramid": { // TEST a_ClgPyramid
			"id": 000000, "points": 0000000, "devInfo": "Reach Demon and defeat him, within xx time, using only xx amount of ENGY"},
		// "a_ClgFinalBattle": { // CONCEPT a_ClgFinalBattle
			// "id": 000000, "points": 0000000, "devInfo": "Defeat the final boss, within xx time, using only xx amount of ENGY, taking only xx HP damage"},
		// CONCEPT Area/bosses with no challenges: UnderwaterShrine KakogenTemple PrincessAsaka GiantCentipede YomotsuPlain ThunderGod SnakeDemon
		},
	"c_Bonus": { // Bonus - Misc bonus achievements
		// "a_OneHitHumanBoss": { // VERIFIED
			// "id": 607151, "points": ENUM_AchievementPointClass.Easy_3, "devInfo": "Defeat a boss with one hit from full HP (earlier bosses using Fudo spell)"},
		// "a_SeaSpirits": { // VERIFIED
			// "id": 607698, "points": ENUM_AchievementPointClass.Basic_2, "devInfo": "Defeat all 5 sea spirits at Dannoura (Shimonoseki coast/sea)"},
		// "a_xRaying": { // VERIFIED
			// "id": 607701, "points": ENUM_AchievementPointClass.Basic_2, "devInfo": "spot a chest with the x-ray glasses at Dannoura (Shimonoseki coast/sea)"},		
		// "a_FullyGeared": { // VERIFIED
			// "id": 609106, "points": ENUM_AchievementPointClass.Hard_25, "devInfo": "Acquire all 8 gear items"},
		// "a_Energised": { // VERIFIED
			// "id": 609105, "points": 0000000, "devInfo": "Acquire a certain amount of energy, prior to Final Battle"},
		// "a_Strengthened": { // DISCONTINUED - Max Strength is determined based on MainQuest progress, there's no optional "max HP/STGH increase pick-ups"
			// "id": 000000, "points": 0000000, "devInfo": "Acquire a certain amount of strength, prior to Final Battle"},
		// "a_Indy": { // VERIFIED
			// "id": 609114, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Regen HP with each unique Big Blue Orb inside the pyramid (picking up the orb without restoring any STGH, doesn't count)"},
		// "a_MiniGoat": { // VERIFIED
			// "id": 609116, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Kill the Goat Mini Boss in the Pyramid"},
		// "a_MiniEye": { // VERIFIED
			// "id": 609115, "points": ENUM_AchievementPointClass.Challenging_10, "devInfo": "Kill the Eye Mini Boss in the Pyramid"},
	
		// "a_Ressurectlace": { // VERIFIED
			// "id": 609121, "points": ENUM_AchievementPointClass.Minor_1, "devInfo": "Restore STGH after it reaches 0, during the final battle, by having Kuma's necklace"},
		//  "a_EatSpaghetti": { // VERIFIED
			// "id": 609831, "points": ENUM_AchievementPointClass.Minor_1, "devInfo": "Eat some spaghetti made by Kuma at Izumo Town"},
		//  "a_EatMidori": { // VERIFIED
			// "id": 609832, "points": ENUM_AchievementPointClass.Minor_1, "devInfo": "Eat some food at Midori's House"},
		//  "a_ChizuParty": { // VERIFIED
			// "id": 609833, "points": ENUM_AchievementPointClass.Minor_1, "devInfo": "Have a taste of some Chizu Sea Nectar & perform a sword dance with them"},
		},
	}

dict_achievementCategoryToAchievementType = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- util.sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 		ENUM_AchievementType.Standard,
	"c_StoryProgress": 		ENUM_AchievementType.Progression,
	"c_WinCondition":		ENUM_AchievementType.WinCondition,
	"c_Challenge":			ENUM_AchievementType.Standard,
	"c_Bonus":				ENUM_AchievementType.Standard,
	}

// #endregion ACH - Core Data

// #region ACH - Triggers
dict_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP
		// // [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			// __ornext(gameStateA.is_inGame(enum_releaseRegion))
			// && gameStateB.is_gameStarted(enum_releaseRegion) // WARNING --> going into ActionModeMenu => gameStateB toggles to gameStateB.BootingGame_StartMenu_Demo 
			// && !demo.is_active(enum_releaseRegion)
			// always_false()
		// ),
	"a_Ch1MysteryMan": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_BOSS = bossEnemy.MysteriousEnemy
		const_CHAPTER = storyChapter.Ch_1_Investigation

		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never( // --ResetIf--> When players dies in ActionMode
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion))
			&& never( // --ResetIf--> Boss spawns in BossArena
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.on_spawn(const_BOSS, enum_releaseRegion))

			&& player.is_alive(enum_releaseRegion)
			&& storyChapter.is(const_CHAPTER, enum_releaseRegion)			

			&& once( // --CheckIf--[StartCondition]--> Boss starts at max HP
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.is_atMaxHP(const_BOSS, enum_releaseRegion))

			&& tally(1, [ // --Tally--OrNext--> CheckIf: Boss dies, there's two death scenarios (see below)
				once( // --CheckIf--> Boss dies on_HP_hitsZero()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_hitsZero(const_BOSS, enum_releaseRegion)),
				once( // --CheckIf--> Boss dies on_HP_negativelyOverflows()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_negativelyOverflows(const_BOSS, enum_releaseRegion))
				])

			&& trigger_when(
				adventureScene.is(adventureScene.IzumoShrine_OutsideAfterBossFight, enum_releaseRegion)
				&& dialogueText.wasPrior(dialogueText.FirstBossFight_A, enum_releaseRegion)
				&& dialogueText.is(dialogueText.FirstBossFight_B, enum_releaseRegion)
				&& mainQuest.on_event_completion(mainQuest.Ch1_MysteryManDefeated, enum_releaseRegion))
		}),	
	"a_Ch1KashimaBoss": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_BOSS = bossEnemy.KashimaFireBoss
		const_CHAPTER = storyChapter.Ch_1_Investigation

		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never( // --ResetIf--> When players dies in ActionMode
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion))
			&& never( // --ResetIf--> Boss spawns in BossArena
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.on_spawn(const_BOSS, enum_releaseRegion))
			
			&& storyChapter.is(const_CHAPTER, enum_releaseRegion)
			&& player.is_alive(enum_releaseRegion)
			&& adventureScene.is(adventureScene.KashimaTemple_FirstVisit, enum_releaseRegion)

			&& once( // --CheckIf--[StartCondition]--> Boss starts at max HP
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.is_atMaxHP(const_BOSS, enum_releaseRegion))

			&& tally(1, [ // --Tally--OrNext--> CheckIf: KashimaFireBoss dies, there's two death scenarios (see below)
				once( // --CheckIf--> Boss dies on_HP_hitsZero()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_hitsZero(const_BOSS, enum_releaseRegion)),
				once( // --CheckIf--> Boss dies on_HP_negativelyOverflows()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_negativelyOverflows(const_BOSS, enum_releaseRegion))
				])

			&& trigger_when(gameStateA.on_changeTo(gameStateA.AdventureMode, enum_releaseRegion))
			}),
	"a_Ch2SwordKusanagi": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_2_SwordOfKusanagi, enum_releaseRegion))

			&& once( // --CheckIf--[Startcondition_A]--> Player acquires SwordOfKusanagi at UnderwaterShrine (toggles at same time as [Startcondition_B], but not same frame)
				adventureScene.is(adventureScene.UnderwaterShrine,enum_releaseRegion) 
				&& dialogueText.is(dialogueText.UnderwaterShrine_TakeSwordOfKusanagi, enum_releaseRegion)
				&& item.on_acquire(item.Ch2_SwordOfKusanagi, enum_releaseRegion))
			&& once( // --CheckIf--[Startcondition_B]--> Player acquires SwordOfKusanagi at UnderwaterShrine (toggles at same time as [Startcondition_A], but not same frame)
				adventureScene.is(adventureScene.UnderwaterShrine,enum_releaseRegion) 
				&& mainQuest.is_priorEventsCompleted(mainQuest.Ch2_AcquireSwordOfKusanagi, enum_releaseRegion)
				&& mainQuest.on_event_completion(mainQuest.Ch2_AcquireSwordOfKusanagi, enum_releaseRegion))

			&& trigger_when( // --Trigger--> When power of SwordOfKusanagi is showcased
				once( // --CheckIf--> AdventureScene changes to adventureScene.Dannoura_IwatoBattle from adventureScene.UnderwaterShrine
					adventureScene.prev(enum_releaseRegion) == adventureScene.UnderwaterShrine
					&& adventureScene.current(enum_releaseRegion) == adventureScene.Dannoura_IwatoBattle)
				&& once( // --CheckIf--> player uses SwordOfKusanagi at Dannoura against Iwato Family (part 1)
					adventureScene.is(adventureScene.Dannoura_IwatoBattle,enum_releaseRegion) 
					&& item.is_inInventory(item.Ch2_SwordOfKusanagi, enum_releaseRegion)
					&& dialogueText.wasPrev(dialogueText.IwatoBattleDannoura_SwordOfKusanagi_Use_A, enum_releaseRegion)
					&& dialogueText.is(dialogueText.IwatoBattleDannoura_SwordOfKusanagi_Use_B, enum_releaseRegion))
				&& once( // --CheckIf--> player uses SwordOfKusanagi at Dannoura against Iwato Family (part 2)
					adventureScene.is(adventureScene.Dannoura_IwatoBattle,enum_releaseRegion) 
					&& item.is_inInventory(item.Ch2_SwordOfKusanagi, enum_releaseRegion)
					&& dialogueText.wasPrev(dialogueText.IwatoBattleDannoura_SwordOfKusanagi_Use_E, enum_releaseRegion)
					&& dialogueText.is(dialogueText.IwatoBattleDannoura_SwordOfKusanagi_Use_F, enum_releaseRegion))
				&& dialogueText.on_textBox_hide(enum_releaseRegion))
		),
	"a_Ch3Shimazu": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_3_FalseEnemy, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.ShimazuDeath, enum_releaseRegion))

			&& once( // --CheckIf--[StartCondition_A]-> Player acquires BallOfShimazu (toggles at same time as [Startcondition_B], but not same frame)				
				dialogueText.is(dialogueText.ShimazuDeath_AcquireBall, enum_releaseRegion)
				&& item.on_acquire(item.Ch3_BallOfShimazu, enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition_B]-> Player acquires BallOfShimazu (toggles at same time as [StartCondition_A], but not same frame)
				dialogueText.is(dialogueText.ShimazuDeath_AcquireBall, enum_releaseRegion)
				&& mainQuest.on_event_completion(mainQuest.Ch3_AcquireBallOfShimazu, enum_releaseRegion))

			&& trigger_when( // --Trigger--> When Asaka leaves
				dialogueText.is(dialogueText.ShimazuDeath_AsakaLeaves, enum_releaseRegion)
				&& mainQuest.on_event_completion(mainQuest.Ch3_ShimazuDeathEnd, enum_releaseRegion))
			),
	"a_Ch3Ameno": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_3_FalseEnemy, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.AmenoSpaceship, enum_releaseRegion))
			&& never(!item.is_inInventory(item.Ch3_ArmorBracers, enum_releaseRegion))

			&& once( // --CheckIf--[StartCondition]-> Using armorBracers inside spaceship
				dialogueText.wasPrev(dialogueText.ArmorBracers_Use_A[0], enum_releaseRegion)
				&& dialogueText.is(dialogueText.ArmorBracers_Use_A[1], enum_releaseRegion))

			&& trigger_when( // --Trigger--> Ooku speech is over				
				once(
					dialogueText.wasPrev(dialogueText.ArmorBracers_Use_A[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.ArmorBracers_Use_B[0], enum_releaseRegion))
				&& once(
					dialogueText.wasPrev(dialogueText.ArmorBracers_Use_C[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.OokuSpeech[0], enum_releaseRegion))

				&& dialogueText.wasPrev(dialogueText.OokuSpeech[1], enum_releaseRegion)
				&& dialogueText.is(dialogueText.OokuSpeech_Done[0], enum_releaseRegion))
			),
	"a_Ch4Demon": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_BOSS = bossEnemy.PyramidDemon
		const_CHAPTER = storyChapter.Ch_4_Pyramid

		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never( // --ResetIf--> When players dies in ActionMode
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion))
			&& never( // --ResetIf--> Boss spawns in BossArena
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.on_spawn(const_BOSS, enum_releaseRegion))
			&& never(!storyChapter.is(const_CHAPTER, enum_releaseRegion))

			&& player.is_alive(enum_releaseRegion)

			&& once( // --CheckIf--[StartCondition]--> Boss starts at max HP
				bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.is_atMaxHP(const_BOSS, enum_releaseRegion))

			&& tally(1, [ // --Tally--OrNext--> CheckIf: Boss dies, there's two death scenarios (see below)
				once( // --CheckIf--> Boss dies on_HP_hitsZero()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_hitsZero(const_BOSS, enum_releaseRegion)),
				once( // --CheckIf--> Boss dies on_HP_negativelyOverflows()
					bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion) 
					&& bossEnemy.on_HP_negativelyOverflows(const_BOSS, enum_releaseRegion))
				])

			&& trigger_when(
				once( 
					mainQuest.is_priorEventsCompleted_bis(mainQuest.Ch4_PyramidDemonDefeated, enum_releaseRegion)
					&& mainQuest.on_event_completion(mainQuest.Ch4_PyramidDemonDefeated, enum_releaseRegion))
				&& once( // --CheckIf--> Correct Dialogue Text is printed (part 1)
					gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion)
					&& adventureScene.is(adventureScene.Pyramid_DarkRoom, enum_releaseRegion)
					&& dialogueText.wasPrev(dialogueText.PyramidDemonFelled_A[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.PyramidDemonFelled_B[0], enum_releaseRegion))				
				
				&& gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion) // --CheckIf--4_lines--> Correct Dialogue Text is printed (part 2)
				&& adventureScene.is(adventureScene.Pyramid_DarkRoom, enum_releaseRegion)
				&& dialogueText.wasPrev(dialogueText.PyramidDemonFelled_B[1], enum_releaseRegion)
				&& dialogueText.is(dialogueText.PyramidDemonFelled_C[0], enum_releaseRegion))
		}),	
	"a_Ch5Yomotsu": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_5_Underworld, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.YomotsuShrine, enum_releaseRegion))
			&& never(!item.is_inInventory(item.Ch5_MysticHarp, enum_releaseRegion))

			&& once( // --CheckIf--> Correct dialogue text is printed (start)
				mainQuest.is_eventCompleted(mainQuest.Ch5_LearnedToPlayHarp, enum_releaseRegion)
				&& dialogueText.wasPrev(dialogueText.MusicForCerberus_A[0], enum_releaseRegion)
				&& dialogueText.is(dialogueText.MusicForCerberus_A[1], enum_releaseRegion))

			&& trigger_when(
				once( // --CheckIf--> Correct dialogue text is printed (part 1)
					dialogueText.wasPrev(dialogueText.MusicForCerberus_A[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.MusicForCerberus_B[0], enum_releaseRegion))
				&& once( // --CheckIf--> Correct dialogue text is printed (part 2)
					dialogueText.wasPrev(dialogueText.MusicForCerberus_C[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.MusicForCerberus_D[0], enum_releaseRegion))
				&& once( // --CheckIf--> Dialogue finishes
					dialogueText.is(dialogueText.MusicForCerberus_D[1], enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion))
				&& once( // --CheckIf--> Main Quest Flag toggles
					mainQuest.is_priorEventsCompleted(mainQuest.Ch5_CerberusCalmed, enum_releaseRegion)
					&& mainQuest.on_event_completion(mainQuest.Ch5_CerberusCalmed, enum_releaseRegion))
				)
		),
	"a_Ch5Izanami": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_5_Underworld, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.IzanamiShrine, enum_releaseRegion))
			&& never(!item.is_inInventory(item.Ch5_SacredMirror, enum_releaseRegion))

			&& once( // --CheckIf--> Correct dialogue text is printed (start)
				mainQuest.is_priorEventsCompleted(mainQuest.Ch5_ShowIzanamiMirror, enum_releaseRegion)
				&& mainQuest.is_eventCompleted(mainQuest.Ch5_ShowIzanamiMirror, enum_releaseRegion)
				&& dialogueText.wasPrev(dialogueText.IzanamiKnowledge_A[0], enum_releaseRegion)
				&& dialogueText.is(dialogueText.IzanamiKnowledge_A[1], enum_releaseRegion))

			&& trigger_when(
				once( // --CheckIf--> Correct dialogue text is printed (part 1)
					dialogueText.wasPrev(dialogueText.IzanamiKnowledge_A[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.IzanamiKnowledge_B[0], enum_releaseRegion))
				&& once( // --CheckIf--> Correct dialogue text is printed (part 2)
					dialogueText.wasPrev(dialogueText.IzanamiKnowledge_D[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.IzanamiKnowledge_E[0], enum_releaseRegion))
				&& once( // --CheckIf--> Dialogue finishes
					dialogueText.wasPrev(dialogueText.IzanamiKnowledge_E[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.IzanamiKnowledge_F[0], enum_releaseRegion))
				)
		),	
	"a_ClgEnrikuTemple": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_PLAYER_START_STGH = 20
		const_PLAYER_START_ENGY = 20
		
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_0_TroubleAtEnrikuTemple, enum_releaseRegion))
			&& never(player.on_death(enum_releaseRegion))
			&& never(player.on_STGH_decrement(enum_releaseRegion))

			&& once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
				player.current_STGH(enum_releaseRegion) == const_PLAYER_START_STGH // --ExtraChecks--2_lines--> game starts off with 20 STGH and 40 ENGY
				&& player.current_ENGY(enum_releaseRegion) == const_PLAYER_START_ENGY

				// && adventureScene.is(adventureScene.SummitTemple_GameStart, enum_releaseRegion) // DISABLED --> [8-bit:AdventureScene_ID] doesn't change during "StoryChapter.Ch_0_TroubleAtEnrikuTemple"
				&& actionLevel.is(actionLevel.PathToEnrikuTemple_Level_1, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

			&& trigger_when( // --Trigger--> When reaching Enriku Temple
				once( // --CheckIf--> ActionLevels have progressed correctly 
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToEnrikuTemple_Level_1
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToEnrikuTemple_Level_2)
				&& once( // --CheckIf--> ActionLevels have progressed correctly 
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToEnrikuTemple_Level_2
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToEnrikuTemple_Entrance)

				&& once( // --CheckIf--> Reached Enriku Temple with Challenge Complete
					player.current_STGH(enum_releaseRegion) >= const_PLAYER_START_STGH

					&& actionLevel.is(actionLevel.PathToEnrikuTemple_Entrance, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)

				&& gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion) // --CheckIf--2_Lines--> Entering Enriku Temple
				&& dialogueText.on_changeTo(dialogueText.EnteringEnrikuTemple_A, enum_releaseRegion)
			)
		}),	
	"a_ClgIzumoShrine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CHAPTER = storyChapter.Ch_1_Investigation
		const_END_BOSS = bossEnemy.MysteriousEnemy
		const_PLAYER_MAX_START_STGH = 30
		const_TIME_LIMIT_SECONDS = 105 // = 1m45s (only counts when in ActionMode; Dev_PB: 1m30s~)
		const_TIME_LIMIT_FRAMES = const_TIME_LIMIT_SECONDS *60 // at 60 FPS
		// NOTE: Can't implement a MeasuredIndicator which functions as a countdown, because there's no in-game timer --> // TODO implement a_ClgIzumoShrine with a complementary timed leaderboard
		
		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss	
				__ornext(
					actionLevel.is(actionLevel.PathToIzumoShrine_Level_1, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToIzumoShrine_Level_2, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToIzumoShrine_Entrance, enum_releaseRegion))
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(repeated(const_TIME_LIMIT_FRAMES, // --PauseLock--> When time exceeds const_TIME_LIMIT_SECONDS; timer only counts while in "gameStateA.ActionMode"
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)))

			&& once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
				player.current_STGH(enum_releaseRegion) <= const_PLAYER_MAX_START_STGH // --ExtraCheck--> at this point in story, player can't have more than xx STGH

				&& actionLevel.is(actionLevel.PathToIzumoShrine_Level_1, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[3] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(actionLevel.PathToIzumoShrine_Level_1, enum_releaseRegion)

				&& __ornext(
					adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
					|| adventureScene.is(adventureScene.IzumoTown_Ch1, enum_releaseRegion))
				)

			&& trigger_when( // --Trigger--> When Boss dies
				once( // --CheckIf--> ActionLevels have progressed correctly 
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToIzumoShrine_Level_1
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToIzumoShrine_Level_2)
				&& once( // --CheckIf--> ActionLevels have progressed correctly 
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToIzumoShrine_Level_2
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToIzumoShrine_Entrance)

				&& once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.PathToIzumoShrine_Entrance, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)
					
				&& once( // --CheckIf--> Entering Boss Arena
					adventureScene.is(adventureScene.IzumoShrine_OutsideBeforeBossFight, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				&& bossEnemy.is_bossArena_active(const_END_BOSS, enum_releaseRegion) // --CheckIf--[TriggerCondition]--> Boss dies
				&& bossEnemy.on_death(const_END_BOSS, enum_releaseRegion)
				)
		// [2] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [3] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				__ornext(
					adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
					|| adventureScene.is(adventureScene.IzumoTown_Ch1, enum_releaseRegion))
				&& actionLevel.is(actionLevel.PathToIzumoShrine_Level_1, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),	
	"a_ClgAttaroShrine": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CHAPTER = storyChapter.Ch_1_Investigation
		const_ALLOWED_SPELL_USAGES = 3
		const_ALLOWED_SPELL = spell.Makiri
		const_END_BOSS = bossEnemy.Jukak
		const_TIME_LIMIT_SECONDS = 105 // = 1m45s (only counts when in ActionMode; Dev_PB: 1m30s~)
		const_TIME_LIMIT_FRAMES = const_TIME_LIMIT_SECONDS *60 // at 60 FPS
		
		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss	
				__ornext(
					actionLevel.is(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToAttaroShrine_Entrance, enum_releaseRegion))
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of( // --PauseLock--> When player uses/when game spawns a non fully charged basic attack
				playerProjectile.array_PlayerProjectileStructLocationIDs, 1, char_playerProjectileStructLocationID =>  
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& playerProjectile.prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == 0 // --CheckIf--2_Lines--> spawned a basic attack 
					&& playerProjectile.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == playerProjectile.get_EntityID(playerProjectile.BasicAttack)
					&& playerProjectile.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) != playerProjectile.BasicAttack_ChargeState_fullyCharged // --CheckIf--> basic attack is fully charged
				))
			&& unless(once( // --PauseLock--> When player uses any spell other than Makiri
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.current_spellSelected(enum_releaseRegion) != const_ALLOWED_SPELL
				&& player.on_ENGY_decrement(enum_releaseRegion))) 
			&& unless(repeated(const_ALLOWED_SPELL_USAGES +1, // --PauseLock--> When player used up all his allowed spell usages
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(const_ALLOWED_SPELL, enum_releaseRegion))) 

			&& once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
				actionLevel.is(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion))

			&& trigger_when( // --Trigger--> When Boss dies
				once( // --CheckIf--> ActionLevels have progressed correctly 
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToAttaroShrine_Level_1
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToAttaroShrine_Entrance)

				&& once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.PathToAttaroShrine_Entrance, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)
					
				&& once( // --CheckIf--> Entering Boss Arena
					adventureScene.is(adventureScene.AttaroShrine, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				&& tally(1, [ // --Tally--OrNext--[TriggerCondition]--> CheckIf: Boss dies, there's two death scenarios (see below) 
					once( // --CheckIf--> Boss dies on_HP_hitsZero()
						player.is_alive(enum_releaseRegion) // --> without this: when player dies, this block would trigger
						&& bossEnemy.is_bossArena_active(const_END_BOSS, enum_releaseRegion) 
						&& bossEnemy.on_HP_hitsZero(const_END_BOSS, enum_releaseRegion)), // WARNING: don't use "bossEnemy.on_death()" for Jukak, as he doesn't "die"
					once( // --CheckIf--> Boss dies on_HP_negativelyOverflows()
						player.is_alive(enum_releaseRegion) // --> without this: when player dies, this block would trigger
						&& bossEnemy.is_bossArena_active(const_END_BOSS, enum_releaseRegion) 
						&& bossEnemy.on_HP_negativelyOverflows(const_END_BOSS, enum_releaseRegion))
					])
				)
		// [2] ==== Alt Measured Group ==== 		-> Group is responsible for displaying a MeasuredIndicator, tracking how much Makiri spell usages left
			|| unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss	
				__ornext(
					actionLevel.is(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToAttaroShrine_Entrance, enum_releaseRegion))
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of( // --PauseLock--> When player uses/when game spawns a non fully charged basic attack
				playerProjectile.array_PlayerProjectileStructLocationIDs, 1, char_playerProjectileStructLocationID =>  
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& playerProjectile.prev_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == 0 // --CheckIf--2_Lines--> spawned a basic attack 
					&& playerProjectile.current_ID(char_playerProjectileStructLocationID, enum_releaseRegion) == playerProjectile.get_EntityID(playerProjectile.BasicAttack)
					&& playerProjectile.current_ChargeState(char_playerProjectileStructLocationID, enum_releaseRegion) != playerProjectile.BasicAttack_ChargeState_fullyCharged // --CheckIf--> basic attack is fully charged
				))
			&& unless(once( // --PauseLock--> When player uses any spell other than Makiri
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.current_spellSelected(enum_releaseRegion) != const_ALLOWED_SPELL
				&& player.on_ENGY_decrement(enum_releaseRegion))) 
			
			&& measured(
				tally(const_ALLOWED_SPELL_USAGES,  [
					repeated(const_ALLOWED_SPELL_USAGES, always_true()),  // --Add(...)--> to fill up count at start
					deduct(repeated(const_ALLOWED_SPELL_USAGES, player.on_spellCast(const_ALLOWED_SPELL, enum_releaseRegion)))]), // --Deduct(-1)--> when using the spell 
				when = once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
					actionLevel.is(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion)
					&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
					&& player.on_spawn_atStartOfActionLevel(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion))
				)
			&& memUtil.alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [4] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				actionLevel.is(actionLevel.PathToAttaroShrine_Level_1, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),	
	"a_ClgMtMiwa": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CHAPTER = storyChapter.Ch_1_Investigation
		const_ALLOWED_ENGY_TO_USE = 50
		const_DISALLOWED_SPELLS = [spell.Fudo, spell.Kannon]
		const_START_BOSS = bossEnemy.MtMiwaGuard
		const_END_BOSS = bossEnemy.Wakahiko

		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during the start boss	
				bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of(const_DISALLOWED_SPELLS, 1, enum_spell => // --PauseLock--> When player casts any disallowed spell
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(enum_spell, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion) // --PauseLock--> When player used too much ENGY

			&& once( // --CheckIf--[StartCondition]--> Entered the first boss arena
				__ornext(
					adventureScene.is(adventureScene.MtMiwa_Gate, enum_releaseRegion)
					|| adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion))
				&& !mainQuest.is_eventCompleted(mainQuest.Ch1_MtMiwaGuardDefeated, enum_releaseRegion)
				&& bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(bossEnemy.get_BossArena_ActionModeLevel_ID(const_START_BOSS), enum_releaseRegion))

			&& trigger_when( // --Trigger--> When end boss dies
				once( // --CheckIf--> Start boss dies
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
					&& bossEnemy.on_death(const_START_BOSS, enum_releaseRegion))
				&& once( // --CheckIf--> Entered the first actionLevel of the section
					actionLevel.is(actionLevel.PathToMtMiwaTemple_Level_1, enum_releaseRegion)
					&& mainQuest.is_eventCompleted(mainQuest.Ch1_MtMiwaGuardDefeated, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)
				&& once( // --CheckIf--> Progressing through the section
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToMtMiwaTemple_Level_1
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToMtMiwaTemple_Level_2)
				&& once( // --CheckIf--> Progressing through the section
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToMtMiwaTemple_Level_2
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToMtMiwaTemple_Entrance)
				&& once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.PathToMtMiwaTemple_Entrance, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)					
				&& once( // --CheckIf--> Entering Boss Arena
					adventureScene.is(adventureScene.MtMiwaTemple, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				 // --CheckIf--[TriggerCondition]--> End boss dies
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& bossEnemy.is_bossArena_active(const_END_BOSS, enum_releaseRegion)
				&& bossEnemy.on_death(const_END_BOSS, enum_releaseRegion)
				)
		// [2] ==== Alt Measured Group ==== 		-> Group is responsible for displaying a MeasuredIndicator, tracking how much Makiri spell usages left
			|| unless(once( // --PauseLock--> When player dies during the start boss	
				bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of(const_DISALLOWED_SPELLS, 1, enum_spell => // --PauseLock--> When player casts any disallowed spell
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(enum_spell, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion) // --PauseLock--> When player used too much ENGY
			
			&& achievementSubLogic.Measured_trackEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion,
				requirement_when = once( // --CheckIf--[StartCondition]--> Entered the first boss arena
					__ornext(
						adventureScene.is(adventureScene.MtMiwa_Gate, enum_releaseRegion)
						|| adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion))
					&& !mainQuest.is_eventCompleted(mainQuest.Ch1_MtMiwaGuardDefeated, enum_releaseRegion)
					&& bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
					&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
					&& player.on_spawn_atStartOfActionLevel(bossEnemy.get_BossArena_ActionModeLevel_ID(const_START_BOSS), enum_releaseRegion)))
			&& memUtil.alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [4] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				bossEnemy.is_bossArena_active(const_START_BOSS, enum_releaseRegion)
				&& !mainQuest.is_eventCompleted(mainQuest.Ch1_MtMiwaGuardDefeated, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),
	"a_ClgKashimaTemple": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CHAPTER = storyChapter.Ch_1_Investigation
		const_DISALLOWED_SPELLS = [spell.Hakuji, spell.Indra, spell.Fudo, spell.Kannon, spell.Hatten]
		const_ALLOWED_SPELLS = [spell.Mars, spell.Makiri, spell.Nobota]
		const_ALLOWED_SPELL_USAGES = 2
		const_ALLOWED_DISTINCT_SPELLS = 1
		const_BOSS = bossEnemy.KashimaFireBoss

		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss
				__ornext(
					actionLevel.is(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToKashimaTemple_Entrance, enum_releaseRegion))
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of(const_DISALLOWED_SPELLS, 1, enum_spell => // --PauseLock--> When player casts any disallowed spell
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(enum_spell, enum_releaseRegion)))
			&& unless(repeated(const_ALLOWED_SPELL_USAGES +1, // --PauseLock--> When player exceeds allowed spell casts
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_ENGY_decrement(enum_releaseRegion)))
			&& unless(tally_of(const_ALLOWED_SPELLS, const_ALLOWED_DISTINCT_SPELLS +1, enum_spell => // --PauseLock--> When player uses more than one distinct spell
				once(
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& player.on_spellCast(enum_spell, enum_releaseRegion))
				))

			&& once( // --CheckIf--[StartCondition]--> Entered the first action level of the section
				actionLevel.is(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion))

			&& trigger_when( // --Trigger--> When end boss dies
				once( // --CheckIf--> Progressing through the section
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.prev(enum_releaseRegion) == actionLevel.PathToKashimaTemple_Level_1
					&& actionLevel.current(enum_releaseRegion) == actionLevel.PathToKashimaTemple_Entrance)
				&& once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.PathToKashimaTemple_Entrance, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)
				&& once( // --CheckIf--> Entering Boss Arena
					adventureScene.is(adventureScene.KashimaTemple_FirstVisit, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				 // --CheckIf--[TriggerCondition]--> End boss dies
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.on_death(const_BOSS, enum_releaseRegion)
				)
		// [2] ==== Alt Measured Group ==== 		-> Group is responsible for displaying a MeasuredIndicator, tracking how much spell usages left
			|| unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss
				__ornext(
					actionLevel.is(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion)
					|| actionLevel.is(actionLevel.PathToKashimaTemple_Entrance, enum_releaseRegion))
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(tally_of(const_DISALLOWED_SPELLS, 1, enum_spell => // --PauseLock--> When player casts any disallowed spell
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(enum_spell, enum_releaseRegion)))
			&& unless(repeated(const_ALLOWED_SPELL_USAGES +1, // --PauseLock--> When player exceeds allowed spell casts
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_ENGY_decrement(enum_releaseRegion)))
			&& unless(tally_of(const_ALLOWED_SPELLS, const_ALLOWED_DISTINCT_SPELLS +1, enum_spell => // --PauseLock--> When player uses more than one distinct spell
				once(
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& player.on_spellCast(enum_spell, enum_releaseRegion))
				))
			
			&& measured(tally(const_ALLOWED_SPELL_USAGES, [
				repeated(const_ALLOWED_SPELL_USAGES, always_true()), // --AddHits--> Base hits
				deduct(repeated(const_ALLOWED_SPELL_USAGES, // --DeductHits--> when using a spell
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& player.on_ENGY_decrement(enum_releaseRegion)))
				]), 
				when = once( // --CheckIf--[StartCondition]--> Entered the first action level of the section
					actionLevel.is(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion)
					&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
					&& player.on_spawn_atStartOfActionLevel(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion))
				)
			&& memUtil.alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [4] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				actionLevel.is(actionLevel.PathToKashimaTemple_Level_1, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),
	"a_ClgMtHinokami": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_CHAPTER = storyChapter.Ch_3_FalseEnemy
		const_BOSS_A = bossEnemy.Kezeus
		const_BOSS_B = bossEnemy.DaikokRobot
		const_ALLOWED_MARS_SPELL_USES = 1
		const_MAX_ALLOWED_ENGY_TO_USE = 70

		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss
				actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(repeated(const_ALLOWED_MARS_SPELL_USES +1, // --PauseLock--> When player casts spell Mars too many times
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(spell.Mars, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance_withAllowanceRegainOnHPloss(const_MAX_ALLOWED_ENGY_TO_USE, enum_releaseRegion)

			&& once( // --CheckIf--[StartCondition]--> Entered the first action level of the section
				actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(actionLevel.MtHinokami_Level_1, enum_releaseRegion))

			&& trigger_when( // --Trigger--> When 2nd boss dies
				once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)
				&& once( // --CheckIf--> Entering 1st Boss Arena
					adventureScene.is(adventureScene.MtHinokami, enum_releaseRegion)
					&& bossEnemy.is_bossArena_active(const_BOSS_A, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)
				&& tally(1, [ // --Tally--OrNext--> ChekcIf: First boss dies (this boss can have multiple EntityIDs during the fight)
					once( // --CheckIf--> EntityID with which boss spawns with
						gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
						&& bossEnemy.is_bossArena_active(const_BOSS_A, enum_releaseRegion)
						&& bossEnemy.on_death(const_BOSS_A, enum_releaseRegion)),
					once( // --CheckIf--> EntityID_alt, can toggle between two EntityIDs throughout fight
						gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
						&& bossEnemy.is_bossArena_active(const_BOSS_A, enum_releaseRegion)
						&& bossEnemy.on_death_alt(const_BOSS_A, enum_releaseRegion))
					])
				&& once( // --CheckIf--> Entering 2nd Boss Arena
					adventureScene.is(adventureScene.MtHinokami, enum_releaseRegion)
					&& bossEnemy.is_bossArena_active(const_BOSS_B, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				 // --CheckIf--[TriggerCondition]--> 2nd boss dies
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& bossEnemy.is_bossArena_active(const_BOSS_B, enum_releaseRegion)
				&& bossEnemy.on_death(const_BOSS_B, enum_releaseRegion)
				)
		// [2] ==== Alt Measured Group ==== 		-> Group is responsible for displaying a MeasuredIndicator, tracking how much spell usages left
			|| unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss
				actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(repeated(const_ALLOWED_MARS_SPELL_USES +1, // --PauseLock--> When player casts spell Mars too many times
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_spellCast(spell.Mars, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance_withAllowanceRegainOnHPloss(const_MAX_ALLOWED_ENGY_TO_USE, enum_releaseRegion)
			
			&& achievementSubLogic.Measured_trackEnergyAllowance_withAllowanceRegainOnHPloss(const_MAX_ALLOWED_ENGY_TO_USE, enum_releaseRegion, 
				requirement_when = once( // --CheckIf--[StartCondition]--> Entered the first action level of the section
					actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
					&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
					&& player.on_spawn_atStartOfActionLevel(actionLevel.MtHinokami_Level_1, enum_releaseRegion)))
			&& memUtil.alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [4] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				actionLevel.is(actionLevel.MtHinokami_Level_1, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),
	"a_ClgPyramid": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) { // WIP
		const_CHAPTER = storyChapter.Ch_4_Pyramid
		const_BOSS = bossEnemy.PyramidDemon
		const_ALLOWED_ENGY_TO_USE = 50
		const_TIME_LIMIT_SECONDS = 300 // = xxxx (only counts when in ActionMode; Dev_PB: xxxx~)
		const_TIME_LIMIT_FRAMES = const_TIME_LIMIT_SECONDS *60 // at 60 FPS
		// NOTE: Can't implement a MeasuredIndicator which functions as a countdown, because there's no in-game timer --> // TODO implement a_ClgIzumoShrine with a complementary timed leaderboard

		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss	
				!bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(repeated(const_TIME_LIMIT_FRAMES, // --PauseLock--> When time exceeds const_TIME_LIMIT_SECONDS; timer only counts while in "gameStateA.ActionMode"
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion) // --PauseLock--> When player used too much ENGY

			&& once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
				actionLevel.is(actionLevel.Pyramid_Entrance, enum_releaseRegion)
				&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				&& player.on_spawn_atStartOfActionLevel(actionLevel.Pyramid_Entrance, enum_releaseRegion)
				&& __ornext(
					adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
					|| adventureScene.is(adventureScene.Pyramid_SouthSide, enum_releaseRegion))
				)

			&& trigger_when( // --Trigger--> When Boss dies
				// DISABLED below code - Don't check for acquiring the WarHammer, as this item is retained when dying.
					// once( // --CheckIf--> ActionLevels have progressed correctly (moved to FlyingDemon MiniBoss room to acquire WarHammer)
						// gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
						// && actionLevel.prev(enum_releaseRegion) == actionLevel.Pyramid_Entrance
						// && actionLevel.current(enum_releaseRegion) == actionLevel.Pyramid_Floor_1_Room_A)
					// && once( // --CheckIf--> Acquired WarHammer
						// gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
						// && actionLevel.is_active(actionLevel.Pyramid_Floor_1_Room_A, enum_releaseRegion)
						// && gear.on_acquire(gear.Weapon_WarHammer, enum_releaseRegion))
				once( // --CheckIf--> Making progress through Pyramid
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.on_enter(actionLevel.Pyramid_EyeMiniBossRoom, enum_releaseRegion))
				&& once( // --CheckIf--> Making progress through Pyramid
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.on_enter(actionLevel.Pyramid_GoatMiniBossRoom, enum_releaseRegion))
				&& once( // --CheckIf--> Making progress through Pyramid
					gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
					&& actionLevel.on_enter(actionLevel.Pyramid_Floor_1_Room_F, enum_releaseRegion))
				&& once( // --CheckIf--> Reached destination
					actionLevel.is(actionLevel.Pyramid_Floor_1_Room_F, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.AdventureMode)					
				&& once( // --CheckIf--> Entering Boss Arena
					adventureScene.is(adventureScene.Pyramid_DarkRoom, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)

				&& gear.is_acquired(gear.Weapon_WarHammer, enum_releaseRegion)  // --CheckIf--[TriggerCondition]--> Boss dies
				&& bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& bossEnemy.on_death(const_BOSS, enum_releaseRegion)
				)
		// [2] ==== Alt Measured Group ==== 		-> Group is responsible for displaying a MeasuredIndicator, tracking how much Makiri spell usages left
			|| unless(once( // --PauseLock--> When player dies during any of the actionLevels prior to the boss	
				!bossEnemy.is_bossArena_active(const_BOSS, enum_releaseRegion)
				&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				&& player.on_death(enum_releaseRegion)))
			&& unless(repeated(const_TIME_LIMIT_FRAMES, // --PauseLock--> When time exceeds const_TIME_LIMIT_SECONDS; timer only counts while in "gameStateA.ActionMode"
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)))
			&& achievementSubLogic.PauseLock_playerExceedsEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion) // --PauseLock--> When player used too much ENGY
			
			&& achievementSubLogic.Measured_trackEnergyAllowance(const_ALLOWED_ENGY_TO_USE, enum_releaseRegion,
				requirement_when =  once( // --CheckIf--[StartCondition]--> Entered the first actionLevel of the section
					actionLevel.is(actionLevel.Pyramid_Entrance, enum_releaseRegion)
					&& gameStateA.prior(enum_releaseRegion) == gameStateA.AdventureMode // --> prior so this [StartCondition] can track together with AltResetGroup[4] 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
					&& player.on_spawn_atStartOfActionLevel(actionLevel.Pyramid_Entrance, enum_releaseRegion)
					&& __ornext(
						adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
						|| adventureScene.is(adventureScene.Pyramid_SouthSide, enum_releaseRegion)))
				)
			&& memUtil.alwaysFalse(enum_releaseRegion)
		// [3] ==== Alt Reset Group ==== 		-> Reset when not InGame || demo is active || incorrect StoryChapter
			|| never_toAlt(
				!gameStateA.is_inGame(enum_releaseRegion)
				|| demo.is_active(enum_releaseRegion)
				|| !storyChapter.is(const_CHAPTER, enum_releaseRegion)
				)
		// [4] ==== Alt Reset Group ==== 		-> Reset when restarting the challenge from the beginning
			|| never_toAlt(
				__ornext(
					adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
					|| adventureScene.is(adventureScene.Pyramid_SouthSide, enum_releaseRegion))
				&& actionLevel.is(actionLevel.Pyramid_Entrance, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode
				)
		}),	
	"a_ClgFinalBattle": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			__ornext(gameStateA.is_inGame(enum_releaseRegion))
			&& gameStateB.is_gameStarted(enum_releaseRegion) // WARNING --> going into ActionModeMenu => gameStateB toggles to gameStateB.BootingGame_StartMenu_Demo 
			&& !demo.is_active(enum_releaseRegion)
			&& always_false()
		),	
	"a_SlayEvilLord": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(repeated(10, // --Repeated--10_frames--> On OutroSequence start, when outrosequence toggles from "SecondTextParagraph" to "EndingScene", gameStateA is temporarily 0x6 as a transitional value (0x86 -> 0x6 -> 0x86). This is also the case when switching from "EndingScene" to "Credits"
				never(gameStateA.on_change(enum_releaseRegion))
				&& !gameStateA.is_inGame(enum_releaseRegion)))
			&& never(repeated(40, // --Repeated--40_frames--> On OutroSequence start, when gameStateB toggles from "gameStateB.Started_MainMenu_InGame"(0x1) ro "gameStateB.OutroSequence"(0xE), gameStateB is "BootingGame_StartMenu_Demo"(0x0) for 20-ish frames as a transitional value (0x1 -> 0x0 -> 0xE)
				never(gameStateB.on_change(enum_releaseRegion))
				&& !gameStateB.is_gameStarted(enum_releaseRegion)))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_7_FinalBattle, enum_releaseRegion))
			&& never(player.on_death(enum_releaseRegion))

			&& once( // --CheckIf--[StartCondition]--> Final Battle starts from beginning
				__ornext(
					adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
					|| adventureScene.is(adventureScene.KashimaTemple_PreFinalBattle, enum_releaseRegion))
				&& actionLevel.is(actionLevel.FinalBattle, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)
			
			&& once( // --CheckIf--> Outro starts
				actionLevel.is(actionLevel.FinalBattle, enum_releaseRegion)
				&& gameStateA.prev(enum_releaseRegion) == gameStateA.ActionMode
				&& gameStateA.current(enum_releaseRegion) == gameStateA.OutroSequence)
			
			&& trigger_when( // --Trigger--> When outrosequence reaches ending scene
				once(
					gameStateA.is_active(gameStateA.OutroSequence, enum_releaseRegion)
					&& gameStateB.is_active(gameStateB.OutroSequence, enum_releaseRegion)
					&& outroSequenceState.prev(enum_releaseRegion) == outroSequenceState.FirstTextParagraph
					&& outroSequenceState.current(enum_releaseRegion) == outroSequenceState.SecondTextParagraph)
					
				&& gameStateA.is_active(gameStateA.OutroSequence, enum_releaseRegion)
				&& gameStateB.is_active(gameStateB.OutroSequence, enum_releaseRegion)
				&& outroSequenceState.prev(enum_releaseRegion) == outroSequenceState.SecondTextParagraph
				&& outroSequenceState.current(enum_releaseRegion) == outroSequenceState.EndingScene
				)
		),	
	"a_OneHitHumanBoss": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_ALLOWED_BOSSES = [bossEnemy.MysteriousEnemy, bossEnemy.Jukak, bossEnemy.Wakahiko]
		const_FRAMES_ALLOWED_FOR_ONEHIT = 40 // --> "OneHit" = boss needs to die within xx frames from first taking damage

		let_array_requirements_BossBelowMaxHPChecks = []
		let_array_requirements_BossDeathChecks = []
		for enum_boss in const_ALLOWED_BOSSES {
			let_requirement_BossHPBelowMaxHP = 
				repeated(const_FRAMES_ALLOWED_FOR_ONEHIT, // --CheckIf--> Boss is below max HP for xx frames
					bossEnemy.is_bossArena_active(enum_boss, enum_releaseRegion)
					&& bossEnemy.is_belowMaxHP(enum_boss, enum_releaseRegion))
			array_push(let_array_requirements_BossBelowMaxHPChecks, let_requirement_BossHPBelowMaxHP)

			let_requirement_BossHPHitsZero = 
				once( // --CheckIf--> Boss dies via "bossEnemy.on_HP_hitsZero()"
					never(!bossEnemy.is_bossArena_active(enum_boss, enum_releaseRegion))
					&& bossEnemy.on_HP_hitsZero(enum_boss, enum_releaseRegion)) // WARNING: cannot use "bossEnemy.on_death()" for Jukak, as he doesn't "die"
			let_requirement_BossHPNegativelyOverflows =
				once( // --CheckIf--> Boss dies via "bossEnemy.on_HP_negativelyOverflows()"
					never(!bossEnemy.is_bossArena_active(enum_boss, enum_releaseRegion))
					&& bossEnemy.on_HP_negativelyOverflows(enum_boss, enum_releaseRegion))			
			array_push(let_array_requirements_BossDeathChecks, let_requirement_BossHPHitsZero)
			array_push(let_array_requirements_BossDeathChecks, let_requirement_BossHPNegativelyOverflows)
		}

		return
		// [1] ==== Alt Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			unless(demo.is_active(enum_releaseRegion))
			&& unless(tally(const_FRAMES_ALLOWED_FOR_ONEHIT, let_array_requirements_BossBelowMaxHPChecks)) // --PauseIf--> one of the bosses is below max HP for xx frames
			&& gameStateB.is_gameStarted(enum_releaseRegion)
			&& player.is_alive(enum_releaseRegion)
			&& once(player.on_spellCast(spell.Fudo, enum_releaseRegion)) // --> Boss can only be "one hit" by Fudo spell
			&& tally(1, let_array_requirements_BossDeathChecks) // --TallyOf--OrNext--> CheckIf: one of the bosses has died ==> boss either dies via "bossEnemy.on_HP_hitsZero()" OR "bossEnemy.on_HP_negativelyOverflows()"
		// [2] ==== Alt Reset Group ====			-> Reset when one of the bosses has spawned
			|| never_toAlt(any_of(const_ALLOWED_BOSSES, enum_boss =>
				gameStateB.is_gameStarted(enum_releaseRegion)
				&& bossEnemy.is_bossArena_active(enum_boss, enum_releaseRegion)
				&& bossEnemy.on_spawn(enum_boss, enum_releaseRegion)))
		// [3] ==== Alt Reset Group ====			-> Reset when not in ActionMode || not in ActionModeMenu
			|| never_toAlt(
				!gameStateA.is_actionMode_active(enum_releaseRegion))
		}),
	"a_SeaSpirits": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_array_SEASPIRIT_VANQUISHED_EVENTS = [
			miscellaneousEvent.Ch2_SeaSpiritVanquished_atPier, 
			miscellaneousEvent.Ch2_SeaSpiritVanquished_southEastOfHelmet,
			miscellaneousEvent.Ch2_SeaSpiritVanquished_atVajira,
			miscellaneousEvent.Ch2_SeaSpiritVanquished_southOfLute,
			miscellaneousEvent.Ch2_SeaSpiritVanquished_middleOfSea,
			miscellaneousEvent.Ch2_SeaSpiritVanquished_atHelmet]

		let_sumOf_deltaFlagStates_SeaSpiritVanquishedEvents = 
			sum_of(const_array_SEASPIRIT_VANQUISHED_EVENTS, enum_event =>
				miscellaneousEvent.prev_flagState(enum_event, enum_releaseRegion))
		let_sumOf_currentFlagStates_SeaSpiritVanquishedEvents = 
			sum_of(const_array_SEASPIRIT_VANQUISHED_EVENTS, enum_event =>
				miscellaneousEvent.current_flagState(enum_event, enum_releaseRegion))
		
		return 
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			__ornext(gameStateA.is_inGame(enum_releaseRegion))			
			&& gameStateB.is_gameStarted(enum_releaseRegion)
			&& !demo.is_active(enum_releaseRegion)
			&& storyChapter.is(storyChapter.Ch_2_SwordOfKusanagi, enum_releaseRegion)
			&& mainQuest.is_priorEventsCompleted(mainQuest.Ch2_LuteSpiritVanquished, enum_releaseRegion)
			&& mainQuest.is_eventCompleted(mainQuest.Ch2_LuteSpiritVanquished, enum_releaseRegion)
			&& item.is_inInventory(item.Ch2_Lute, enum_releaseRegion)

			&& let_sumOf_deltaFlagStates_SeaSpiritVanquishedEvents == length(const_array_SEASPIRIT_VANQUISHED_EVENTS) -1  // --SumOf--> all delta event flags ----> (delta: 5 defeated spirits)
			&& measured(let_sumOf_currentFlagStates_SeaSpiritVanquishedEvents == length(const_array_SEASPIRIT_VANQUISHED_EVENTS))  // --Measured--SumOf--> all current event flags ----> (current: 6 defeated spirits)
		}),
	
	"a_xRaying": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic + Trigger Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement + displaying TriggerIndactor
			gameStateB.is_gameStarted(enum_releaseRegion)
			&& gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion)
			&& storyChapter.is(storyChapter.Ch_2_SwordOfKusanagi, enum_releaseRegion)

			&& once( // --CheckIf--> XRayGlasses is used whilst out at sea on Dannoura
				never( // --ResetNextIf--> No chest is spotted with XRayGlasses
					dialogueText.is_textBox_displayed(enum_releaseRegion)
					&& !dialogueText.is(dialogueText.XRayGlasses_Use, enum_releaseRegion)
					&& !dialogueText.is(dialogueText.XRayGlasses_Success, enum_releaseRegion))
				&& dialogueText.is_textBox_displayed(enum_releaseRegion)
				&& dialogueText.is(dialogueText.XRayGlasses_Use, enum_releaseRegion)
				&& adventureScene.is_atSeaOnDannoura(enum_releaseRegion))
			&& trigger_when( // --Trigger--> Only to give players a hint for this achievement;  When nothing is seen with xRayGlasses, there's a seperate dialogue line to hide TriggerIndicator
				dialogueText.is(dialogueText.XRayGlasses_Success, enum_releaseRegion)
				&& dialogueText.on_textBox_hide(enum_releaseRegion)) 
			),
	"a_FullyGeared": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			__ornext(gameStateA.is_inGame(enum_releaseRegion))
			&& gameStateB.is_gameStarted(enum_releaseRegion)
			&& !demo.is_active(enum_releaseRegion)
			&& storyChapter.is(storyChapter.Ch_4_Pyramid, enum_releaseRegion) // --> last pieces of gear are acquired during this Chapter
			&& gear.on_allGear_acquired(enum_releaseRegion)
		),
	"a_Energised": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_ENERGY_REQUIREMENT = 250 

		return 
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			__ornext(
				gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
				|| gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion)
				|| gameStateA.is_active(gameStateA.ActionModeMenu, enum_releaseRegion))
			&& gameStateB.is_gameStarted(enum_releaseRegion)
			&& !demo.is_active(enum_releaseRegion)
			&& !storyChapter.is(storyChapter.Ch_7_FinalBattle, enum_releaseRegion) // --> acquire energy before final battle

			&& player.prev_ENGY(enum_releaseRegion) < const_ENERGY_REQUIREMENT
			&& player.current_ENGY(enum_releaseRegion) >= const_ENERGY_REQUIREMENT
		}),
	"a_Indy": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_dict_PYRAMID_ORBS = { // Big Blue Orbs documented according to Pyramid Map --> https://gamefaqs.gamespot.com/sms/588147-spellcaster/map/12810-mount-minakami-pyramid-map (J & G on map are boss drops)
			"Orb_C": {
				"Location": actionLevel.Pyramid_GroundFloor_Room_B,
				},
			"Orb_E": {
				"Location": actionLevel.Pyramid_GroundFloor_Room_C,
				},
			"Orb_F": {
				"Location": actionLevel.Pyramid_Floor_minus1_Room_A,
				},
			"Orb_H": {
				"Location": actionLevel.Pyramid_Floor_1_Room_C,
				},
			"Orb_K": {
				"Location": actionLevel.Pyramid_Floor_1_Room_E,
				},
			}
		
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_4_Pyramid, enum_releaseRegion))
			
			&& tally_of( // --Tally--(extraCheck)--> Count if all rooms with Big Blue Orbs have been entered once
				const_dict_PYRAMID_ORBS, length(const_dict_PYRAMID_ORBS), enum_pyramidOrb => 
					once(actionLevel.on_enter(const_dict_PYRAMID_ORBS[enum_pyramidOrb]["Location"], enum_releaseRegion))
				)

			&& measured( // --Measured--Tally--> Count all unique Big Blue Orb pickups 
				tally_of(const_dict_PYRAMID_ORBS, length(const_dict_PYRAMID_ORBS), enum_pyramidOrb =>
					once(
						actionLevel.is(const_dict_PYRAMID_ORBS[enum_pyramidOrb]["Location"], enum_releaseRegion)
						&& miscEntity.on_despawn(miscEntity.PyramidOrb, enum_releaseRegion)
						&& player.on_STGH_refill(enum_releaseRegion))
				), 
				when = once( // --CheckIf--[StartCondition]--> Entering Pyramid (via Main Entrance)
					adventureScene.is(adventureScene.Pyramid_SouthSide, enum_releaseRegion)
					&& gameStateA.prev(enum_releaseRegion) == gameStateA.AdventureMode 
					&& gameStateA.current(enum_releaseRegion) == gameStateA.ActionMode)
				)
		}),
	"a_MiniEye": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MINI_BOSS = bossEnemy.Eye
		
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_4_Pyramid, enum_releaseRegion))
			&& never(!bossEnemy.is_bossArena_active(const_MINI_BOSS, enum_releaseRegion))
			&& never(bossEnemy.on_despawn(const_MINI_BOSS, enum_releaseRegion))

			&& once(bossEnemy.on_spawn(const_MINI_BOSS, enum_releaseRegion))
			&& trigger_when(bossEnemy.on_death(const_MINI_BOSS, enum_releaseRegion))
		}),
	"a_MiniGoat": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MINI_BOSS = bossEnemy.Goat
		
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_inGame(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_4_Pyramid, enum_releaseRegion))
			&& never(!bossEnemy.is_bossArena_active(const_MINI_BOSS, enum_releaseRegion))
			&& never(bossEnemy.on_despawn(const_MINI_BOSS, enum_releaseRegion))

			&& once(bossEnemy.on_spawn(const_MINI_BOSS, enum_releaseRegion))
			&& trigger_when(bossEnemy.on_death(const_MINI_BOSS, enum_releaseRegion))
		}),
	"a_Ressurectlace": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) {
		const_MAX_STGH_FINAL_BATTLE = 200
		
		return
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			__ornext(
				adventureScene.is(adventureScene.SummitTemple_OnPlayerDeath, enum_releaseRegion)
				|| adventureScene.is(adventureScene.KashimaTemple_PreFinalBattle, enum_releaseRegion))
			&& gameStateA.is_active(gameStateA.ActionMode, enum_releaseRegion)
			&& !demo.is_active(enum_releaseRegion)
			&& storyChapter.is(storyChapter.Ch_7_FinalBattle, enum_releaseRegion)			
			&& actionLevel.is(actionLevel.FinalBattle, enum_releaseRegion)

			&& item.on_lose(item.Ch7_Necklace, enum_releaseRegion)
			&& 0 <= player.prev_STGH(enum_releaseRegion) && player.prev_STGH(enum_releaseRegion) <= (const_MAX_STGH_FINAL_BATTLE/5)
			&& player.current_STGH(enum_releaseRegion) == const_MAX_STGH_FINAL_BATTLE			
		}),	
	"a_EatSpaghetti": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))			
			&& never(!adventureSceneColor.is(adventureSceneColor.IzumoTown, enum_releaseRegion)) // --> ID this scene via [92-bit:AdventureSceneColor_ID] as there's too many variations of this scene for [8-bit:AdventureScene_ID]
			&& never( // --ResetIf--> "Take" sub menu renders
				adventureCommandMenu.on_subMenu_render(adventureCommandMenu.SubMenu_Take, enum_releaseRegion))

			&& once( // --CheckIf--(option2)--> The frame the player presses the right button, the command menu also closes in that same frame
				adventureCommandMenu.prev_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) == adventureCommandMenu.FLAG_IsAdventureModeSubCommandMenuDisplayed_true
				&& adventureCommandMenu.prev_SelectedMainCommandMenuItem(enum_releaseRegion) == adventureCommandMenu.SubMenu_Take
				&& playerInput.on_press(playerInput.Button_Right, enum_releaseRegion))

			// NOTE: Above code block replaces below commented code block 
			// && tally(1, [ // --Tally--OrNext--> CheckIf: player pressed RightButton on the "Take" Sub Menu of the adventure command menu
				// 	once( // --CheckIf--(option1)--> Command Menu closes after the player presses the right button
				// 		adventureCommandMenu.is_subMenu_open(adventureCommandMenu.SubMenu_Take, enum_releaseRegion)
				// 		&& playerInput.on_press(playerInput.Button_Right, enum_releaseRegion)),
				// 	once( // --CheckIf--(option2)--> The frame the player presses the right button, the command menu also closes in that same frame
				// 		adventureCommandMenu.prev_flagState_IsAdventureModeSubCommandMenuDisplayed(enum_releaseRegion) == adventureCommandMenu.FLAG_IsAdventureModeSubCommandMenuDisplayed_true
				// 		&& adventureCommandMenu.prev_SelectedMainCommandMenuItem(enum_releaseRegion) == adventureCommandMenu.SubMenu_Take
				// 		&& playerInput.on_press(playerInput.Button_Right, enum_releaseRegion))
				// 	])

			&& trigger_when( // --Trigger--> When taken/eaten item
				once( // --CheckIf--> First dialogue line is printed
					dialogueText.is(dialogueText.EatSpaghetti_A, enum_releaseRegion)
					&& dialogueText.on_textBox_render(enum_releaseRegion)) 
				&& once( // --CheckIf--> Dialogue continues
					dialogueText.wasPrev(dialogueText.EatSpaghetti_A, enum_releaseRegion)
					&& dialogueText.is(dialogueText.EatSpaghetti_B, enum_releaseRegion)) 
				&& once( // --CheckIf--> Dialogue continues
					dialogueText.wasPrev(dialogueText.EatSpaghetti_B, enum_releaseRegion)
					&& dialogueText.is(dialogueText.EatSpaghetti_C, enum_releaseRegion)) 
				&& once( // --CheckIf--> Dialogue finishes
					dialogueText.is(dialogueText.EatSpaghetti_C, enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion)) 
				)
		),	
	"a_EatMidori": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_2_SwordOfKusanagi, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.MidoriHouse, enum_releaseRegion))

			&& miscellaneousEvent.is_eventCompleted(miscellaneousEvent.Ch2_LookAtFood_MidoriHouse, enum_releaseRegion)
			&& measured(tally(3, [ // --Measure--> Track each unique food item eaten
				once( // --CheckIf--> Eaten food item A
					dialogueText.wasPrev(dialogueText.EatAtMidori_Seaweed, enum_releaseRegion)
					&& dialogueText.is(dialogueText.EatAtMidori_End, enum_releaseRegion)),
				once( // --CheckIf--> Eaten food item B
					dialogueText.wasPrev(dialogueText.EatAtMidori_Sushi, enum_releaseRegion)
					&& dialogueText.is(dialogueText.EatAtMidori_End, enum_releaseRegion)),
				once( // --CheckIf--> Eaten food item C
					dialogueText.wasPrev(dialogueText.EatAtMidori_FriedEgg, enum_releaseRegion)
					&& dialogueText.is(dialogueText.EatAtMidori_End, enum_releaseRegion)),
			]))
			&& trigger_when( // --Trigger--> When dialogue finishes
				dialogueText.is(dialogueText.EatAtMidori_End, enum_releaseRegion)
				&& dialogueText.on_textBox_hide(enum_releaseRegion))			
		),	
	"a_ChizuParty": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			never(!gameStateA.is_active(gameStateA.AdventureMode, enum_releaseRegion))
			&& never(!gameStateB.is_gameStarted(enum_releaseRegion))
			&& never(demo.is_active(enum_releaseRegion))
			&& never(!storyChapter.is(storyChapter.Ch_5_Underworld, enum_releaseRegion))
			&& never(!adventureScene.is(adventureScene.ChizuSea, enum_releaseRegion))

			&& measured(tally(2, [
				once( // --CheckIf--> Drunk nectar
					dialogueText.is(dialogueText.DrinkNectar_B[1], enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion)),
				once( // --CheckIf--> Danced 
					item.is_inInventory(item.Ch5_SwordOfKusanagi, enum_releaseRegion)
					&& dialogueText.is(dialogueText.DanceAtChizuSea_E[1], enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion)) 
				]))
			&& trigger_when(tally(5, [ // --Trigger--> When dialogue finishes
				once( // --CheckIf--> Dialogue start (drinking nectar)
					dialogueText.wasPrev(dialogueText.DrinkNectar_A[0], enum_releaseRegion)
					&& dialogueText.is(dialogueText.DrinkNectar_A[1], enum_releaseRegion)),
				once( // --CheckIf--> Dialogue finishes (drinking nectar)
					dialogueText.is(dialogueText.DrinkNectar_B[1], enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion)),

				once( // --CheckIf--> Dialogue start (dancing)
					dialogueText.wasPrev(dialogueText.DanceAtChizuSea_A[0], enum_releaseRegion)
					&& dialogueText.is(dialogueText.DanceAtChizuSea_A[1], enum_releaseRegion)),
				once( // --CheckIf--> Dialogue continues (dancing)
					dialogueText.wasPrev(dialogueText.DanceAtChizuSea_D[1], enum_releaseRegion)
					&& dialogueText.is(dialogueText.DanceAtChizuSea_E[0], enum_releaseRegion)),
				once( // --CheckIf--> Dialogue finishes (dancing)
					dialogueText.is(dialogueText.DanceAtChizuSea_E[1], enum_releaseRegion)
					&& dialogueText.on_textBox_hide(enum_releaseRegion)) 
				]))
		),	
	}
// #endregion ACH - Triggers

// #region ACH - Text
dict_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_Ch1MysteryMan": 			{"en": "xxxxxxxxx"},
	"a_Ch1KashimaBoss": 		{"en": "Stopping the Serpent God"},
	"a_Ch2SwordKusanagi": 		{"en": "The Power of Kusanagi"},
	"a_Ch3Shimazu":  			{"en": "Friends or Enemies"},
	"a_Ch3Ameno": 				{"en": "Enlightened by Wisdom"},
	"a_Ch4Demon": 				{"en": "xxxxxxxxx"},
	"a_Ch5Yomotsu": 			{"en": "xxxxxxxxx"},
	"a_Ch5Izanami": 			{"en": "Knowledge & Power"},
	"a_SlayEvilLord": 			{"en": "xxxxxxxxx"},

	"a_ClgEnrikuTemple": 		{"en": "xxxxxxxxx"},
	"a_ClgIzumoShrine": 		{"en": "xxxxxxxxx"},
	"a_ClgAttaroShrine": 		{"en": "xxxxxxxxx"},
	"a_ClgMtMiwa": 				{"en": "xxxxxxxxx"},
	"a_ClgKashimaTemple": 		{"en": "xxxxxxxxx"},
	"a_ClgMtHinokami": 			{"en": "xxxxxxxxx"},
	"a_ClgPyramid": 			{"en": "xxxxxxxxx"},
	"a_ClgFinalBattle": 		{"en": "xxxxxxxxx"},
	
	"a_OneHitHumanBoss": 		{"en": "xxxxxxxxx"},
	"a_SeaSpirits": 			{"en": "xxxxxxxxx"},
	"a_xRaying": 				{"en": "xxxxxxxxx"},
	"a_FullyGeared": 			{"en": "Fully Geared"},
	"a_Energised": 				{"en": "Energised"},
	"a_Indy": 					{"en": "xxxxxxxxx"},
	"a_MiniEye": 				{"en": "xxxxxxxxx"},
	"a_MiniGoat": 				{"en": "xxxxxxxxx"},
	"a_Ressurectlace": 			{"en": "xxxxxxxxx"},
	"a_EatSpaghetti": 			{"en": "xxxxxxxxx"},
	"a_EatMidori": 				{"en": "xxxxxxxxx"},
	"a_ChizuParty": 			{"en": "xxxxxxxxx"},
	}
dict_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_Ch1MysteryMan": 			{"en": "xxxxxxxx"},
	"a_Ch1KashimaBoss": 		{"en": "xxxxxxxx"},
	"a_Ch2SwordKusanagi": 		{"en": "xxxxxxxx"},
	"a_Ch3Shimazu":  			{"en": "xxxxxxxx"},
	"a_Ch3Ameno": 				{"en": "xxxxxxxx"},
	"a_Ch4Demon": 				{"en": "xxxxxxxxx"},
	"a_Ch5Yomotsu": 			{"en": "xxxxxxxxx"},
	"a_Ch5Izanami": 			{"en": "xxxxxxxx"},
	"a_SlayEvilLord": 			{"en": "xxxxxxxxx"},

	"a_ClgEnrikuTemple": 		{"en": "xxxxxxxxx"},
	"a_ClgIzumoShrine": 		{"en": "xxxxxxxxx"},
	"a_ClgAttaroShrine": 		{"en": "xxxxxxxxx"},
	"a_ClgMtMiwa": 				{"en": "xxxxxxxxx"},
	"a_ClgKashimaTemple": 		{"en": "xxxxxxxxx"},
	"a_ClgMtHinokami": 			{"en": "xxxxxxxxx"},
	"a_ClgPyramid": 			{"en": "xxxxxxxxx"},
	"a_ClgFinalBattle": 		{"en": "xxxxxxxxx"},
	
	"a_OneHitHumanBoss": 		{"en": "xxxxxxxx"},
	"a_SeaSpirits": 			{"en": "xxxxxxxx"},
	"a_xRaying": 				{"en": "xxxxxxxx"},
	"a_FullyGeared": 			{"en": "xxxxxxxxx"},
	"a_Energised": 				{"en": "xxxxxxxxx"},
	"a_Indy": 					{"en": "xxxxxxxxx"},
	"a_MiniEye": 				{"en": "xxxxxxxxx"},
	"a_MiniGoat": 				{"en": "xxxxxxxxx"},
	"a_Ressurectlace": 			{"en": "xxxxxxxxx"},
	"a_EatSpaghetti": 			{"en": "xxxxxxxxx"},
	"a_EatMidori": 				{"en": "xxxxxxxxx"},
	"a_ChizuParty": 			{"en": "xxxxxxxxx"},
	}
// #endregion ACH - Text

// #region ACH - Initialization
function initialize() {
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function createAchievementCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (util.isDebugModeActive) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
			}
			return let_string}
		function getAchievementTitle(string_achievementDevName, string_languageCode) => 
			this.dict_titles[string_achievementDevName][string_languageCode]
		return format("{0}{1}",
			createAchievementCategoryName(string_achievementCategory, string_achievementDevName),
			getAchievementTitle(string_achievementDevName, string_languageCode))}
	
	function generateAchievementDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function getAchievementDescription(string_achievementDevName, string_languageCode) => 
			this.dict_descriptions[string_achievementDevName][string_languageCode]	
		function formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util.isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = getAchievementDescription(string_achievementDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util.throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_achievementDevName))

		let_descriptionString_withDevInfo = let_descriptionString + formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}

	function getAchievementTrigger(string_achievementDevName) => 
		this.dict_triggers[string_achievementDevName]
	
	function getAchievementType(string_achievementCategory) {
		let_type = this.dict_achievementCategoryToAchievementType[string_achievementCategory]
		if(let_type == util.sNULL) return "" // <-- will result in type: "standard"
		return let_type}

	for let_categoryName in this.dict_coreData { // This loop generates the achievements
		for let_cheevmentName in this.dict_coreData[let_categoryName] {
			let_achievementData = this.dict_coreData[let_categoryName][let_cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = generateAchievementTitle(let_cheevmentName, let_categoryName, util.language),
				type = getAchievementType(let_categoryName),
				description = generateAchievementDescription(let_cheevmentName, let_achievementData["devInfo"], util.language),
				points = let_achievementData["points"],
				trigger = getAchievementTrigger(let_cheevmentName)
			)
		}}
	}
// #endregion ACH - Initialization

} achievements = CLASS_AchievementLogic()

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
// #region RP - Text
//	- Contains text for the rich presence script
// CONCEPT rp_InGame expanded: 
	// - include STGH & ENGY
	// - more detailed objective flavor text, based on amount of MainQuestEventFlags true?
	// - include location (based on [8-bit:AdventureScene_ID] & [16-bit:ActionModeLevel_ID])
richPresence_text = {
	// "rp_Template": 				{"en": "xxxxxxxx"},
	"rp_InGame":					{"en": "Playing SpellCaster ✦ {0}"},
	"rp_DefaultPlus":				{"en": "Playing SpellCaster {0}"},
	"rp_Default":					{"en": "Playing SpellCaster"}}
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	"lupText_GameState": {
		"_empty_":				{"en": ""},
		"StartMenu_MainMenu": 	{"en": "✦ At the crossroads of fate"},
		"Demo": 				{"en": "✦ A glimpse of the journey ahead"},
		"PasswordMenu": 		{"en": "✦ Resuming the journey from a sacred password"},
		"IntroScene": 			{"en": "✦ Trouble stirs at Enriku Temple"},
		"OutroSequence": 		{"en": "✦ Kane's journey reaches its end'"},
		},
	"lupText_StoryChapterFlavorText": {
		"LOOKUP_FALLBACK":              {"en":"Kane hones his arcane spells"},
		"Ch_0_TroubleAtEnrikuTemple":   {"en":"Daikok dispatches Kane to uncover the disturbance at Enriku Temple"},
		"Ch_1_Investigation":           {"en":"Kane investigates the mysterious death of the Tokak"},
		"Ch_2_SwordOfKusanagi":         {"en":"Kane sets out to claim the legendary Sword of Kusanagi"},
		"Ch_3_FalseEnemy":              {"en":"Truth blurs as Kane seeks the Serpent God"},
		"Ch_4_Pyramid":                 {"en":"Beneath ancient stone, Kane unearths secrets of the pyramid"},
		"Ch_5_Underworld":              {"en":"Kane descends into the depths of the Underworld"},
		"Ch_6_Preperation":             {"en":"With steel and spirit, Kane prepares for the final trial"},
		"Ch_7_FinalBattle":             {"en":"Empowered at last, Kane confronts the true evil"}
		},
	}
// richPresence_ReleaseRegion_toSuperScript = { // DISABLED - Check unnecessary as only 1 region supported
	// NOTE: Text to superscript --> https://lingojam.com/SuperscriptGenerator
	// ENUM_ReleaseRegion.USA: "ᵘˢ",
	// ENUM_ReleaseRegion.EUR: "ᵉᵘ",
	// ENUM_ReleaseRegion.JPN: "ʲᵖ",
	// }
	
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util.language]

// function richPresence_getText_withRegionSuperScript(string_textKey, enum_releaseRegion) => // DISABLED - Unnecessary as only 1 region supported
	// format("{0} {1}", richPresence_ReleaseRegion_toSuperScript[enum_releaseRegion], richPresence_getText(string_textKey))

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util.language]
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
	"lup_GameState": {
		"LookupTableText_Key": "lupText_GameState",
		"LookUpTable": {
			gameStateA.StartMenu_MainMenu: 	"StartMenu_MainMenu", 
			gameStateA.Demo: 				"Demo", 
			gameStateA.PasswordMenu: 		"PasswordMenu", 
			gameStateA.IntroScene: 			"IntroScene", 
			gameStateA.OutroSequence: 		"OutroSequence", 
			gameStateA.ActionModeMenu: 		"_empty_", 
			gameStateA.AdventureMode: 		"_empty_", 
			gameStateA.ActionMode: 			"_empty_",
			},
		},
	"lup_StoryChapter": {
		"LookupTableText_Key": "lupText_StoryChapterFlavorText",
		"LookUpTable": {
			storyChapter.Ch_0_TroubleAtEnrikuTemple:	"Ch_0_TroubleAtEnrikuTemple",
			storyChapter.Ch_1_Investigation: 			"Ch_1_Investigation",
			storyChapter.Ch_2_SwordOfKusanagi: 			"Ch_2_SwordOfKusanagi",
			storyChapter.Ch_3_FalseEnemy: 				"Ch_3_FalseEnemy",
			storyChapter.Ch_4_Pyramid: 					"Ch_4_Pyramid",
			storyChapter.Ch_5_Underworld: 				"Ch_5_Underworld",
			storyChapter.Ch_6_Preperation: 				"Ch_6_Preperation",
			storyChapter.Ch_7_FinalBattle: 				"Ch_7_FinalBattle",
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
	if (int_numberOfZerosToPad < 1) util.throwError("Number of zeros to pad must be bigger than 0")
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
		else util.throwError("Support for higher values is not implemented")
	}

	richPresence_lookupTables[string_lookupTableName] = let_dict_lookupTable}

function richPresence_initializeZeroPaddingLookupTables() { // Function is called in richPresence_initialize()
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeMinutes_ZeroPadding", 1, 59)
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeHours_ZeroPadding", 1, 23)}
// #endregion RP - Text

// ================================
// • RICH PRESENCE display script •
// ================================
// #region RP - Display Script

// function rp_TemplateDisplayScript(enum_releaseRegion) { 
	// function condition(enum_releaseRegion) =>
	// 	is_ReleaseRegion(enum_releaseRegion)
	// return rich_presence_conditional_display( 
	// 	condition(enum_releaseRegion),
	// richPresence_getText("rp_Template")
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

function rp_InGame(enum_releaseRegion) { 
	function condition(enum_releaseRegion) =>
		gameStateA.is_valid(enum_releaseRegion)
		&& __ornext(gameStateA.is_inGame(enum_releaseRegion))
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_InGame"),
		richPresence_callParameterFunction("rpp_StoryChapter", enum_releaseRegion) // 0
	)}
function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		gameStateA.is_valid(enum_releaseRegion)
		&& !gameStateA.is_inGame(enum_releaseRegion) 
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus"),
		richPresence_callParameterFunction("rpp_GameState", enum_releaseRegion) // 0
	)}
function rp_Default() {
	return rich_presence_display(
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		rp_DefaultPlus(enum_releaseRegion) // CONCEPT rp_DefaultPlus
		rp_InGame(enum_releaseRegion)
	}} 
// #endregion RP - Display Script

// ===========================
// • RICH PRESENCE parameters •
// ===========================
// #region RP - Parameters
class CLASS_ENUM_RichPresenceParameterTypes {
	VALUE = 1			// rich_presence_value(name, expression, [format])
	LOOKUP_HEX = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
	LOOKUP_STRING = 3	// rich_presence_ascii_string_lookup(name, memAddr_ASCII, dictionary, [fallback])
	MACRO = 4			// rich_presence_macro(macro, expression)
} ENUM_RichPresenceParameterType = CLASS_ENUM_RichPresenceParameterTypes()
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
		// "RPtype": ENUM_RichPresenceParameterType.VALUE,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
		// "ValueFormat": "VALUE"},

	// "rpp_LookupHexTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.LOOKUP_HEX,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_LookupStringTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.LOOKUP_STRING,
		// "MemoryAddressToASCII": {
		// 	ENUM_ReleaseRegion.USA: memory.getAddress(), 
		// 	ENUM_ReleaseRegion.EUR: memory.getAddress(),
		// 	ENUM_ReleaseRegion.JPN: memory.getAddress()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_MacroTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.MACRO,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
		// "MacroFormat": "Number"},
	
	
	"rpp_StoryChapter": {
		"RPtype": ENUM_RichPresenceParameterType.LOOKUP_HEX,
		"Expression": {
			ENUM_ReleaseRegion.USA_EUR: storyChapter.current(ENUM_ReleaseRegion.USA_EUR)},
		"LookupTableID": "lup_StoryChapter",
		"LookupFallback": richPresence_getLookupTableText("lupText_StoryChapterFlavorText", "LOOKUP_FALLBACK")},
	"rpp_GameState": {
		"RPtype": ENUM_RichPresenceParameterType.LOOKUP_HEX,
		"Expression": {
			ENUM_ReleaseRegion.USA_EUR: gameStateA.current(ENUM_ReleaseRegion.USA_EUR)},
		"LookupTableID": "lup_GameState",
		"LookupFallback": richPresence_getLookupTableText("lupText_GameState", "_empty_")},

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
	if (let_RPtype == ENUM_RichPresenceParameterType.VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.LOOKUP_HEX) return richPresence_callLookupHexFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.LOOKUP_STRING) return richPresence_callLookupStringFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util.throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}
// #endregion RP - Parameters

// ===============================
// • RICH PRESENCE initialization •
// ===============================
// #region RP - Initialization
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
// #endregion RP - Initialization
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

// ==================================
// • LEADERBOARD trigger generators •
// ==================================
// #region LB - Trigger Generators
//	- For leaderboard logic that's reoccuring across multiple triggers

// #region LB - Value Measures
// NOTE: ValueMeasures need to be in seperate function like below, as it requires usage of max_of()
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(
			current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion),
			when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}
// #endregion LB - Value Measures
// #endregion LB - Trigger Generators

// =====================
// • LEADERBOARD logic •
// =====================
class CLASS_LeaderboardLogic {
// #region LB - Core Data
dict_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
		// "id": 000000, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "xxxxxxx"},
	}
// #endregion LB - Core Data

// #region LB - Triggers
dict_startTriggers = {
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
dict_cancelTriggers = {
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
dict_submitTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Submit Group ====			-> Submit when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Reset Group ====			-> Reset when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
dict_valueMeasures = {
	// "lb_template": lb_ValueMeasure_Template(),
	}
// #endregion LB - Triggers

// #region LB - Text
dict_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
dict_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
// #endregion LB - Text

// #region LB - Initialization
function initialize() {
	function generateLeaderboardTitle(string_leaderboardDevName, string_languageCode) {
		function createLeaderboardDevName(string_leaderboardDevName) => 	// Wrap LeaderoboardDevName in [] (brackets)
			format("[{0}] ", string_leaderboardDevName)
		function getLeaderboardTitle(string_leaderboardDevName, string_languageCode) => 
			this.dict_titles[string_leaderboardDevName][string_languageCode]

		if (util.isDebugModeActive) {
			return format("{0}{1}", 
				createLeaderboardDevName(string_leaderboardDevName),
				getLeaderboardTitle(string_leaderboardDevName, string_languageCode))
		} else {
			return getLeaderboardTitle(string_leaderboardDevName, string_languageCode)
		}}
	
	function generateLeaderboardDescription(string_leaderboardDevName, string_devInfo, string_languageCode) {	
		function getLeaderboardDescription(string_leaderboardDevName, string_languageCode) {
			return this.dict_descriptions[string_leaderboardDevName][string_languageCode]}
		function formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util.isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = getLeaderboardDescription(string_leaderboardDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util.throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_leaderboardDevName))

		let_descriptionString_withDevInfo = let_descriptionString + formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}
	

	for let_leaderboardKey in this.dict_coreData {
		let_leaderboardData = this.dict_coreData[let_leaderboardKey]
		leaderboard(
			id = let_leaderboardData["id"],
			title = generateLeaderboardTitle(let_leaderboardKey, util.language), 
			description = generateLeaderboardDescription(let_leaderboardKey, let_leaderboardData["devInfo"], util.language),
			start = this.dict_startTriggers[let_leaderboardKey], 
			cancel = this.dict_cancelTriggers[let_leaderboardKey], 
			submit = this.dict_submitTriggers[let_leaderboardKey], 
			value = this.dict_valueMeasures[let_leaderboardKey],
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}
// #endregion LB - Initialization
}
leaderboards = CLASS_LeaderboardLogic()
// #endregion LEADERBOARDS

// ====================================================================== \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ====================================================================== \\
// #region RAScript Initialization
function initializeRAscript() {
	achievements.initialize() // --> Functional as a CLASS, since everything is hardcoded
	richPresence_initialize() // --> Not functional as CLASS, because some dictionaries may be altered during runtime of this script, therefor RP is fully coded with global functions and variables
	leaderboards.initialize()} // --> Functional as a CLASS, since everything is hardcoded
initializeRAscript()
// #endregion RAScript Initialization