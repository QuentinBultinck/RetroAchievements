// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA
// *********************************************
 
//#########################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //  //   UTILITY    \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

devmode = 1											// if active => extra information may be displayed on achievement titles & descriptions
function isDevModeActive() => devmode == 1
achievementLanguage = "en"							// ISO 639-1 language codes 		// TODO check if multi-language support is needed 
achievementGuideLink = "bit.ly/ShadowOfDestiny" 	// https://bit.ly/ShadowOfDestiny => links to written achievement guide on github (https://github.com/QuentinBultinck/RetroAchievements/blob/main/RAscripts/PSP/ShadowOfDestiny/README.md)

//#########################################################################################################\\
//  //  //  //  //  //  //  //  //    CODE NOTES & MEMORY ADDRESS LOGIC    \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

// PSP pointers usually start with 08 or 09 + 25-bit

// TIMERS/COUNTERS
// *****************
//	- Resets at certain times or between cutscene transitions
//	- Different timers reset at different moments
function twoFrameTimer() 				=> dword(0xA82880) 								// $A82880: [32-bit] Two frame timer
function hasTwoFrameTimerReset() 		=> twoFrameTimer() < prev(twoFrameTimer()) 		//		- Timer increments by 0x400 each 2 frames
function hasTwoFrameTimerIncremented() 	=> twoFrameTimer() > prev(twoFrameTimer())		// 		- Reset less than other timer

function oneFrameTimer() 				=> dword(0xB88AB0)								// $B88AB0: [32-bit] One frame timer
function hasOneFrameTimerReset() 		=> oneFrameTimer() < prev(oneFrameTimer()) 		//		- Timer increments by 1 each frame
function hasOneFrameTimerIncremented() 	=> oneFrameTimer() > prev(oneFrameTimer())		// 		- Resets at certain times or between cutscene transitions

// INTERACTION IDs WITH NPCs, ENVIRONMENT & ITEMS 
// ************************************************
function interactionID_1() 	=> dword(0xA9EFDC)			// $A9EFDC: [32-bit] Interaction ID 1
														//		- Unique per interactable NPC or environment item
														// 		- Doesn't reset back to a default value after interaction is done
function interactionID_2() 	=> dword(0xA9EFE4)			// $A9EFE4: [32-bit] Interaction ID 2
														// 		- Resets to 0x0 when interaction is done
														//		- Unique per interaction 
function interactionID_3() 	=> dword(0xA9EFF4)			// $A9EFF4: [32-bit] Interaction ID 3 
														//		- Unique per interactable NPC or environment item
														// 		- Resets to 0x0 when interaction is done

// CUTSCENE IDENTIFICATION
// ************************
function isCutsceneActive_old() => bit0(0xA9Eb2C) == 0								// $A9Eb2C: [bit-0] Flag -> is cutscene active (not preferred)
function isCutsceneDone_old() => prev(bit0(0xA9Eb2C)) == 1 && bit0(0xA9Eb2C) == 0	//		- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
																					//		- 1 = no cutscene active

function isCutsceneActive() => byte(0xA9ED26) == 0x5															// $A9ED26: Flag: Is cutscene active (preferred)
function isCutsceneDone() => prev(byte(0xA9ED26)) > 0x0 && byte(0xA9ED26) == 0x0								// 		- 0x00 => no cutscene active
function isCutsceneSectionDone() => prev(byte(0xA9ED26)) > 0x3 && 0x3 >= byte(0xA9ED26)	&& byte(0xA9ED26) > 0x0	// 		- 0x01 => (un)loading cutscene(s)
																												// 		- 0x05 => cutscene active


function isCurrentCutsceneMasterId_0(int_cutsceneId) => dword(0xA9ECBC) == int_cutsceneId		// $A9ECBC: [32-bit] Cutscene MASTER ID #0 (preferred)
function isPriorCutsceneMasterId_0(int_cutsceneId) => prior(dword(0xA9ECBC)) == int_cutsceneId	// 		- Changes on each new cutscene, has no default value
function isNewCutsceneLoaded() => prev(dword(0xA9ECBC)) != dword(0xA9ECBC)

function isCurrentCutsceneMasterId_1(int_cutsceneId) => word(0xA9ECC0) == int_cutsceneId		// $A9ECC0: [16-bit] Cutscene MASTER ID #1
function isPriorCutsceneMasterId_1(int_cutsceneId) => prior(word(0xA9ECC0)) == int_cutsceneId	// 		- Identifies a section from the current cutscene

function isCurrentCutsceneMasterId_2(int_cutsceneId) => word(0xA9ECC2) == int_cutsceneId		// $A9ECC2: [16-bit] Cutscene MASTER ID #2
function isPriorCutsceneMasterId_2(int_cutsceneId) => prior(word(0xA9ECC2)) == int_cutsceneId	// 		- Identifies a section from the current cutscene2

// Below memory addresses likely correlate to animation, model... data during a specific cutscene (not preferred for cutscene identification)
//		- Everytime you view a different cutscene, memory values around these IDs/addresses change
//		- Each unique cutscene seems to have different values => might correlate to animation, camera or model data
//		- During cutscenes the values may change
_cutsceneIDs = {
	1: 0x1DF4280, 		// $1DF4280: [32-bit] Cutscene ID 
	2: 0x1DF59B0, 		// $1DF59B0: [32-bit] Cutscene ID
	3: 0x1DF5F71, 		// $1DF5F71: [32-bit] Cutscene ID
	4: 0x1DF6724, 		// $1DF6724: [32-bit] Cutscene ID
	5: 0x1DF6F60, 		// $1DF6F60: [32-bit] Cutscene ID
	6: 0x1DF742A, 		// $1DF742A: [32-bit] Cutscene ID
	7: 0x1DF7FA2, 		// $1DF7FA2: [32-bit] Cutscene ID
	8: 0x1DF81BA, 		// $1DF81BA: [32-bit] Cutscene ID
	9: 0x1DF8229, 		// $1DF8229: [32-bit] Cutscene ID
	10: 0x1DF8442,		// $1DF8442: [32-bit] Cutscene ID
	11: 0x1DF8B14, 		// $1DF8B14: [32-bit] Cutscene ID
	12: 0x1DF9362, 		// $1DF9362: [32-bit] Cutscene ID
	13: 0x1DF9AA4, 		// $1DF9AA4: [32-bit] Cutscene ID
	14: 0x1DFA0E6, 		// $1DFA0E6: [32-bit] Cutscene ID
	15: 0x1DFA4F8,		// $1DFA4F8: [32-bit] Cutscene ID
	16: 0x1DFAC91, 		// $1DFAC91: [32-bit] Cutscene ID
	17: 0x1DFAD9A, 		// $1DFAD9A: [32-bit] Cutscene ID
	18: 0x1DFB0F0, 		// $1DFB0F0: [32-bit] Cutscene ID
	19: 0x1DFB22B, 		// $1DFB22B: [32-bit] Cutscene ID
	20: 0x1DF5A0C, 		// $1DF5A0C: [32-bit] Cutscene ID
	21: 0x1DF5950,		// $1DF5950: [32-bit] Cutscene ID
	22: 0x1DF81E5,		// $1DF81E5: [32-bit] Cutscene ID
	23:	0x1DFB3D0,		// $1DFB3D0: [32-bit] Cutscene ID
	24:	0x1DFCD78,		// $1DFCD78: [32-bit] Cutscene ID
	25:	0x1DFEA54		// $1DFEA54: [32-bit] Cutscene ID
}
function currentCutsceneId(int_cutsceneId) 	=> dword(_cutsceneIDs[int_cutsceneId])
function priorCutsceneId(int_cutsceneId) 	=> prior(dword(_cutsceneIDs[int_cutsceneId]))

// MAP/SCENE/SCENARIO IDENTIFIER
// *******************************
_mapIDs= {	// list not complete, adding as is necessary
	"PresentDayCity": 0x375,
	"PresentDayNightCity": 0x44,
	"NightBefore": 0x3,
	"80sColdCity": 0x465,
	"70sNightCity": 0x31d,
	"1900sCity": 0x239,
	"1900sBrumMansion": 0x603,
	"MedievalCity": 0x3f3,
	"MedievalNightCity": 0x33c,
	"ExplodedAlchemistBasement": 0x217,
	"MedievalChurch": 0x8e
}
function currentLoadedScene(string_mapId)	=> dword(0xA82E48)	// $A82E48: [32-bit] Current loaded scene/map/scenario
function isCurrentLoadedScene(string_mapId)	=> currentLoadedScene(string_mapId) == _mapIDs[string_mapId]

// CHAPTER LOGIC
// ***************
_chapterIDs = {
	"Prologue": 0x1,
	"Chapter1": 0x2,
	"Chapter2": 0x3,
	"Chapter3": 0x4,
	"Chapter4": 0x5,
	"Chapter5": 0x6,
	"Chapter6": 0x7,
	"Chapter7": 0x8,
	"Chapter8_Ancestress": 0x9,		// If in chapter 5, player told Margarette she's your ancestress
	"Epilogue_Ancestress": 0xa,
	"Chapter8_NoAncestress": 0xb,	// If in chapter 5, player told Margarette she's NOT your ancestress
	"Epilogue_NoAncestress": 0xc
	// TODO "Different endings": ???
	// TODO "EX chapter": ??? 
}
function chapterId() => byte(0xB95704)						// $B95704: [8-bit] Chapter ID
function isCurrentChapter(string_chapter) {	
	if (string_chapter == "Chapter8") {
		return
			(chapterId() == _chapterIDs["Chapter8_Ancestress"] || chapterId() == _chapterIDs["Chapter8_NoAncestress"])
	} else {
		return 
			chapterId() == _chapterIDs[string_chapter]
	}} 
function isChapterFinished(string_chapter) { 
	if (string_chapter == "Chapter7") {
		return 
			prev(chapterId()) == _chapterIDs[string_chapter] &&
			(
				chapterId() == _chapterIDs["Chapter8_Ancestress"] 	|| 
				chapterId() == _chapterIDs["Chapter8_NoAncestress"] 
			)
	} else if (string_chapter == "Chapter8_Ancestress"){
		return
			prev(chapterId()) == _chapterIDs[string_chapter] &&
			chapterId() == _chapterIDs["Epilogue_Ancestress"]
	} else if (string_chapter == "Chapter8_NoAncestress"){
		return
			prev(chapterId()) == _chapterIDs[string_chapter] &&
			chapterId() == _chapterIDs["Epilogue_NoAncestress"]
	} else {
		return
			prev(chapterId()) == _chapterIDs[string_chapter] &&
			chapterId() == _chapterIDs[string_chapter] + 0x1
	}}
function hasChapterChanged() => chapterId() != prev(chapterId())


// INVENTORY LOGIC 
// *****************
//	- itemScrollBarId => Id of the item in the inventory scrollbar menu
//	- inventoryMemoryAddress => Memory address [bit 0] = 1 => this item is in players inventory
//	- isDefaultItem => true, when player gets this item at start of game
_inventoryItems = { 
	"D-pad": {	// In PSP version this is called Z-Pad
		"inventoryMemoryAddress": 0xA9F034,	// $A9F034: [Bit 0] Z-pad/D-pad
		"itemScrollBarId": 0x0,
		"isDefaultItem": true
	}, 
	"Cellphone": {
		"inventoryMemoryAddress": 0xA9F035,	// $A9F035: [Bit 0] Cellphone
		"itemScrollBarId": 0x1,
		"isDefaultItem": true
	},
	"Map": {
		"inventoryMemoryAddress": 0xA9F04C,	// $A9F04C: [Bit 0] City map
		"itemScrollBarId": 0x18,
		"isDefaultItem": true
	},
	"Notebook": {
		"inventoryMemoryAddress": 0xA9F04F,	// $A9F04F: [Bit 0] Notebook
		"itemScrollBarId": 0x1b,
		"isDefaultItem": true
	},	
	"Postcard": {
		"inventoryMemoryAddress": 0xA9F04A,	// $A9F04A: [Bit 0] Letter to dana
		"isDefaultItem": true
	},
	"OldMap": {
		"inventoryMemoryAddress": 0xA9F04E,	// $A9F04E: [Bit 0] Old City Map
		"isDefaultItem": false
	},
	"OrnamentalEgg": {
		"itemScrollBarId": 0x2,
		"inventoryMemoryAddress": 0xA9F036,	// $A9F036: [Bit 0] Cake
		"isDefaultItem": false
	},
	"FryingPan": {
		"itemScrollBarId": 0x4,
		"inventoryMemoryAddress": 0xA9F038,	// $A9F038: [Bit 0] Frying pan
		"isDefaultItem": false
	},
	"Sign": {
		"itemScrollBarId": 0x5,
		"inventoryMemoryAddress": 0xA9F039,	// $A9F039: [Bit 0] Photo shop sign
		"isDefaultItem": false
	},
	"Lighter": {
		"itemScrollBarId": 0x6,
		"inventoryMemoryAddress": 0xA9F03A,	// $A9F03A: [Bit 0] Lighter
		"isDefaultItem": false
	},
	"SquireCrest": {
		"itemScrollBarId": 0xf,
		"inventoryMemoryAddress": 0xA9F043,	// $A9F043: [Bit 0] Squire's crest
		"isDefaultItem": false
	},
	"Antidote": {
		"itemScrollBarId": 0x11,
		"inventoryMemoryAddress": 0xA9F045,	// $A9F045: [Bit 0] Antidote
		"isDefaultItem": false
	},
	"Jugglery": {
		"itemScrollBarId": 0xc,
		"inventoryMemoryAddress": 0xA9F040,	// $A9F040: [Bit 0] Jugglery
		"isDefaultItem": false
	},
	"Cake": {
		"itemScrollBarId": 0x13,
		"inventoryMemoryAddress": 0xA9F047,	// $A9F047: [Bit 0] Cake
		"isDefaultItem": false
	},
	"PhilosopherStone": {
		"inventoryMemoryAddress": 0xA9F03D,	// $A9F03D: [Bit 0] Philosopher's stone
		"isDefaultItem": false
	},
	"BLackWhitePhoto": {	// This one switches with the other photo once the picture is taken
		"inventoryMemoryAddress": 0xA9F03B,	// $A9F03B: [Bit 0] Black and white photo without performer
		"isDefaultItem": false
	},
	"BLackWhitePhotoWithPerformer": {	
		"inventoryMemoryAddress": 0xA9F03C,	// $A9F03C: [Bit 0] Black and white photo with performer
		"isDefaultItem": false
	},
	"OldRope": {
		"inventoryMemoryAddress": 0xA9F03F,	// $A9F03F: [Bit 0] Old Rope
		"isDefaultItem": false
	},
	"NewRope": {
		"inventoryMemoryAddress": 0xA9F03E,	// $A9F03E: [Bit 0] New Rope
		"isDefaultItem": false
	},
	"Comb": {
		"inventoryMemoryAddress": 0xA9F041,	// $A9F041: [Bit 0] Comb
		"isDefaultItem": false
	},
	"AlchemyBook": {
		"inventoryMemoryAddress": 0xA9F042,	// $A9F042: [Bit 0] Old alchemist book
		"isDefaultItem": false
	},
	"EggPocketWatch": {
		"inventoryMemoryAddress": 0xA9F044,	// $A9F044: [Bit 0] Egg shaped pocket watch
		"isDefaultItem": false
	},
	"Meat": {
		"inventoryMemoryAddress": 0xA9F046,	// $A9F046: [Bit 0] Scrap of meat
		"isDefaultItem": false
	},
	"LabKey": {
		"inventoryMemoryAddress": 0xA9F048,	// $A9F048: [Bit 0] Lab key
		"isDefaultItem": false
	},
	"TowerKey": {
		"inventoryMemoryAddress": 0xA9F049,	// $A9F049: [Bit 0] Tower key
		"isDefaultItem": false
	},
	"Ladder": {
		"inventoryMemoryAddress": 0xA9F04D,	// $A9F04D: [Bit 0] Ladder
		"isDefaultItem": false
	},
	"LetterToDana": {
		"inventoryMemoryAddress": 0xA9F050,	// $A9F050: [Bit 0] Postcard
		"isDefaultItem": false
	},
	"Kitten": {
		"inventoryMemoryAddress": 0xA9F04B,	// $A9F04B: [Bit 0] Kitten
		"isDefaultItem": false
	}
}
function currentSelectedItemID() => byte(0xA9F111)			// $A9F111: [8-bit] Currently selected item ID in inventory
function isCurrentSelectedInventoryItem(string_item) => currentSelectedItemID() == _inventoryItems[string_item]["itemScrollBarId"]
function isItemInInventory(string_item) => bit0(_inventoryItems[string_item][inventoryMemoryAddress]) == 1

// ON-SCREEN TEXT 
// ****************
//	- Master ID	=> Identifies a series of subtitles, can stay the same over multiple text changes
//	- Other IDs => Changes on each text/subtitle change 
_onScreenTextID = {
	0: 0xAC31E4,	// $AC31E4: [32-bit] On-screen text ID_master
	1: 0xAC31E8,	// $AC31E8: [32-bit] On-screen text ID
	2: 0xAC326C,	// $AC326C: [32-bit] On-screen text ID
	3: 0xAC32A8,	// $AC32A8: [32-bit] On-screen text ID
	4: 0xAC3314,	// $AC3314: [32-bit] On-screen text ID
	5: 0xAC33E8,	// $AC33E8: [32-bit] On-screen text ID
	6: 0xAC350C,	// $AC350C: [32-bit] On-screen text ID
	7: 0xAC3538,	// $AC3538: [32-bit] On-screen text ID
	8: 0xAC3658		// $AC3658: [32-bit] On-screen text ID
}
function onScreenTextID(int_id) => dword(_onScreenTextID[int_id])

// EXTRA MENU 
// *************
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function IsViewingEndingFromExtraMenu() { return				// $AC3170: [25-bit] Pointer
	 dword(dword(0xAC3170) & 0x1FFFFFF) + 0x4  == 0x1}			// 	+0x4 - Selected menu item in Extra Menu
																// 		- 0x0 => Event viewer (replay unlocked cutscenes)
																// 		- 0x1 => Ending files (replay ending cutscenes)
																// 		- 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
																// 		- 0x3 => Sound Mode (Play sound effects & music)
																// 		- 0x4 => Exit (back to Title Screen)

function IsViewingCutsceneFromExtraMenu() => dword(0x1FFF15C) == 0x21	// $1FFF15C: [32-bit] Flag -> Event viewer (preferred)
																		// 0x21 => event viewer menu on screen OR a cutscene is being watched via this menu
																		// - other values => not in event viewer
function IsViewingCutsceneFromExtraMenu_old() => dword(0x1FFF15C) == 0x1	// $1FFF15C: [32-bit] Flag => is viewing cutscene from event viewer (not preferred)
																			// 	- 0x1 = event viewer is active
																			// 	- other values = event viewer is inactive
																		

// OTHER LOGIC
// *************
function energyUnitsZPad() => byte(0xA9DAA8)	// $A9DAA8: Number of energy units in possession 
												//		- Used for the time travel machine (Z-Pad)
												//		- Min => 0x0 		Max => 0x0a
function isGameRunning() => low4(0xA9EDDC) != 0	// $A9EDDC: [Bit 1] Flag -> is in-game
												// 		0 => at title screen
												// 		1 => in-game
function isGameRunning_old() => bit0(0xA9F034) == 1	// $A9F034: [bit-0] Flag -> is game running (deprecated)
													//		- 0 = game is not running, it's in the title screen
													//		- 1 = game is running
function isAtTitleScreen() { return						// $1FFF5F8: [32-bit] UI/Menu ID
	dword(0x1FFF5F8) == 0x11 &&							// 	0x11 => title screen			any other value => something else on screen
	0x0 < byte(0x1FFF604) && dword(0x1FFF604) < 0x5}	// $1FFF604: [8-bit] Selected submenu at title screen
														// 	0x1 => Start		0x3 => Option
														// 	0x2 => Continue		0x4 => Extra


// CUTSCENE/EVENT FLAGS
// *********************
function isStatueChosen() => bit2(0xA9EDA0)	== 0				// $A9EDA0: [Current Playthrough Event Bit Flags]: Chapter 2
function isTelephoneUsedToScareCrowd() => bit1(0xA9EDA0) == 1	// 		bit 0 => acquired ladder
																// 		bit 1 = 0 => LIGHTER used to scare crowd
																// 		bit 1 = 1 => TELEPHONE used 
																// 		bit 2 = 0 => Chosen to plant STATUE instead of flowers
																// 		bit 2 = 1 => Chosen to plant FLOWERS instead of statue
function isWorldConquestPicked() => bit7(0xA9EDB7) == 1 && prev(bit7(0xA9EDB7)) == 0 	// $A9EDB7: [Current Playthrough Event Bit Flags]: Chapter 6
																						// 		bit 5 => Movie choice 1: Meditating Man
																						// 		bit 6 => Movie choice 1: Time Travel
																						// 		bit 7 => Movie choice 2: Take over the world
function isThrillerStoryPicked() => bit1(0xA9EDB8) == 1 && prev(bit1(0xA9EDB8)) == 0 	// $9EDB8: [Current Playthrough Event Bit Flags]: Chapter 6
function isFindCauseDeathPicked() => bit0(0xA9EDB8)	== 1								// 		bit 0 => Movie Choice 2: Find cause of own death
																						// 		bit 1 => Movie Choice 3: Thriller story
																						// 		bit 2 => Movie Choice 3: Love story





//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //    ACHIEVEMENT LOGIC    \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

// ACHIEVEMENT DICTIONARY
//	- Divided by category => when in dev mode, category tags are added to achievement titles
// 	- check if key (achievementname) => is unique with ctrl+F
// ************************************************************
_achievements = {
	// TODO "a_Template": { 
	//	"id": 000000, "points": 0000000, "hasTips": false,
	//	"devInfo": "xxxxxxx"},
	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // REWORKED 
			"id": 306884, "points": 5, "hasTips": false,
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // REWORKED
			"id": 306886, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // REWORKED
			"id": 306922, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 2"},
		"a_Chapter3Complete": { // REWORKED
			"id": 306921, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 3"},
		"a_Chapter4CompletePan": { // REWORKED
			"id": 308964, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a frying pan"},
		"a_Chapter4CompleteSign": { // REWORKED
			"id": 310149, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign"},
		"a_Chapter5Complete": { // WORKING
			"id": 311616, "points": 10, "hasTips": false,
			"devInfo": "Complete chapter 5"},
		"a_Chapter6CompleteThriller": { // REWORKED
			"id": 313211, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a thriller movie"},
		"a_Chapter6CompleteLove": { // REWORKED
			"id": 313210, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a love movie"},
		"a_Chapter7Complete": { // WORKING
			"id": 315565, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 7"},
		"a_Chapter8Complete": { // WORKING 
			"id": 315571, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 8"},
		// TODO "a_EXChapterComplete": {
		//	"id": 000000, "points": 50, "hasTips": false,
		// 	"devInfo": "Complete the EX chapter"},
		// CONCEPT "a_Achieve100%Achievement": { // TODO check if this is possible to implement as achievement
		//	"id": 000000, "points": 100, "hasTips": false,
		// 	"devInfo": "Seen ALL the cutscenes, should be saved in the MAIN safe file of the game"},
	},
	"c_Branch": { // Category - Branching path
		"a_GetOrnamentalEgg": { // WORKING
			"id": 306885, "points": 3, "hasTips": true,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."},
		"a_BecomeThePerformer": {
			"id": 402284, "points": 5, "hasTips": true,
			"devInfo": "In chapter4, use the costume to give yourself a message"},
		"a_EggCollection1": { // REWORKED CMID
			"id": 306977, "points": 5, "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with the stairs and door inside the building on fire, then go back in time, you'll be transported to the past inside the bar this time"},
		"a_EggCollection2": { // WORKING
			"id": 306976, "points": 5, "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman at his bar during chapter 3 or chapter 4"},
	},
	"c_Endings": { // Category - Achieving different endings
		"a_EndingA": { // WORKING
			"id": 315566, "points": 10, "hasTips": true,
			"devInfo": "Ending A: Margarette (Ancestress) => Fortuneteller AND Homunculus => Town Square"},
		"a_EndingB1": {	// WORKING
			"id": 315573, "points": 10, "hasTips": true,
			"devInfo": "Ending B1: Margarette (Ancestress) => Fortuneteller => Town Square"},
		"a_EndingB2": {	// WORKING
			"id": 315572, "points": 10, "hasTips": true,
			"devInfo": "Ending B2: Margarette (Ancestress) => Homunculus => Town Square"},
		"a_EndingC": {	// WORKING
			"id": 317118, "points": 10, "hasTips": true,
			"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		"a_EndingD": {	// WORKING
			"id": 322230, "points": 10, "hasTips": true,
			"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		"a_EndingE": {	// WORKING
			"id": 322231, "points": 10, "hasTips": true,
			"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => Destroyed Lab"},
	},
	"c_Extra": { // Category - Extra side content & cutscenes
		"a_TimeTravellingCat": {	// TEST => has been tested in chapter 5 (should work for 4 - 5 - 7 - 8)
			"id": 310426, "points": 10, "hasTips": true,
			"devInfo": "Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart in present => give kitten before chapter 7"},		
		"a_DoctorateTimeTraveling": { // WORKING
			"id": 310163, "points": 10, "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign OR frying pan AND taken the picture as the white dressed man"},
		"a_IntroduceEggCollecting": { // WORKING
			"id": 307023, "points": 5, "hasTips": true,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_EikeThePyromancer": { // REWORKED
			"id": 306911, "points": 3, "hasTips": true,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // REWORKED	
			"id": 306906, "points": 3, "hasTips": true,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_EikeTheFlorist": { // REWORKED 
			"id": 306920, "points": 3, "hasTips": true,
			"devInfo": "Choose to plant flowers, when talking to the town planter in 1580 in chapter 2"},
		"a_ArtAppreciator": { // WORKING
			"id": 307499, "points": 4, "hasTips": true,
			"devInfo": "Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor"}, 
		 "a_AntiquesEule": { // WORKING 		// TEST choices in chapter 4 => change relics in chapter 6
			"id": 310132, "points": 3, "hasTips": true,
			"devInfo": "Visit 'Antique shop Eule' and interact with all original relics, Shop is open in chapter 3, 4 (present) and 6, 7 (1980)"},
		"a_EnigmaticCouple1": { // WORKING
			"id": 307495, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during the prologue or chapter 1"},
		"a_EnigmaticCouple2": { // WORKING
			"id": 310131, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 3"},
		"a_EnigmaticCouple3": { // WORKING
			"id": 310134, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 4"},	
		"a_EnigmaticCouple4": { // WORKING
			"id": 310135, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 5"},	
		"a_EnigmaticCouple5": { // WORKING
			"id": 315564, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 7"},	
		"a_LostYoungCouple1": { // WORKING
			"id": 306984, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in the Middle Ages during chapter 2"},
		"a_LostYoungCouple2": { // WORKING
			"id": 310133, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 3"},
		"a_LostYoungCouple3": { // WORKING
			"id": 309393, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 4"},
		"a_LostYoungCouple4": { // WORKING
			"id": 310162, "points": 3, "hasTips": true,
			"devInfo": "Interact with the lost man in Middle Ages during chapter 5"},
		"a_LostYoungCouple5": { // WORKING
			"id": 314753, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 7"},
		"a_LostYoungCouple6": { // WORKING
			"id": 315568, "points": 10, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 8"},
		"a_HugoMotherChild": {  // WORKING
			"id": 311466, "points": 5, "hasTips": true,
			"devInfo": "Secret cutscene in chapter 5 => when going to 1580 (not 1584) => head to marktplatz of Hugo getting bullied"}, 
		"a_SnowyCrimeScene": {  // WORKING
			"id": 313209, "points": 10, "hasTips": true,
			"devInfo": "Discover a crime scene during the winter, in chapter 6"},
		"a_SaveMiriamBrum": {  // WORKING
			"id": 315569, "points": 10, "hasTips": true,
			"devInfo": "Save Miriam Brum in chapter 6"},
		"a_MeetOldMiriam": { // WORKING
			"id": 315570, "points": 10, "hasTips": true,
			"devInfo": "Complete chapter 7, whilst having saved Miriam in chapter 6"},
		"a_EnergyOrbLocatorPresentDay": { // WORKING
			"id": 399816, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in present day"},
		"a_EnergyOrbLocator70s80s": { // WORKING 
			"id": 399817, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 70s/80s"}, 
		"a_EnergyOrbLocator1900Days": { // WORKING 
			"id": 399818, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 1900s"}, 
		"a_EnergyOrbLocatorMiddleAges": { // WORKING 
			"id": 399819, "points": 5, "hasTips": true,
			"devInfo": "Find all 6 energy orbs in Middle Ages"}, 
		"a_NewCakeInvented": { // WORKING
			"id": 402297, "points": 5, "hasTips": true,
			"devInfo": "Take the cake => give it to margarete => talk to bakery girl again (name of cake is now margarete)"}, 		
		"a_GiveMargaretteCake": { // WORKING
			"id": 402296, "points": 3, "hasTips": true,
			"devInfo": "Acquire cake from bakery => give to margarette"}, 		
		// CONCEPT "a_ArtInspiration": { 
		//	"id": 000000, "points": 0000000, "hasTips": false,
		//	"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him with different idea's => view art in present"},
		"a_MaxInventory": { // WORKING // TEST
			"id": 402404, "points": 10, "hasTips": true,
			"devInfo": "Acquire an old map, the ornamental egg, cake, photo shop sign, kitten, scrap of meat, red stone, letter to Dana + other key items"}, 
		"a_IntroduceEggCollecting2": { // WORKING
			"id": 313213, "points": 5, "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward"},
		"a_PocketWatchCollection": { // WORKING
			"id": 315561, "points": 5, "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7"},
		"a_PocketWatchReminiscing": { // BUG
			"id": 315562, "points": 5, "hasTips": true,
			"devInfo": "Talk to Eckart with the pocket watch in your inventory during chapter 8"},
		"a_BarmansChildren": { // WORKING
			"id": 315567, "points": 5, "hasTips": true,
			"devInfo": "Uncover the truth about the barman's children and the mystery child during chapter 5"},
	},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to PC dying or game over screen
		"a_MetYouBefore": {  // REWORKED
			"id": 306888, "points": 5, "hasTips": true,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_ErasingEike": { // WORKING
			"id": 306883, "points": 5, "hasTips": true,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
		"a_ErasingEike2": { // WORKING
			"id": 314763, "points": 2, "hasTips": true,
			"devInfo": "Meet yourself at the Brum's mansion during chapter 7"},
		"a_RottenRope": { // WORKING
			"id": 315563, "points": 2, "hasTips": false,
			"devInfo": "Try to save yourself with an old rope during chapter 7"},
		"a_ExcuseMeMyMy": { // REWORKED 
			"id": 306919, "points": 1, "hasTips": true,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
		"a_TimeEgoFlop": { // REWORKED 
			"id": 313212, "points": 2, "hasTips": true,
			"devInfo": "During chapter 6, co-direct Time Ego"},
	}
}


// ACHIEVEMENT TRIGGERS
// 	- check if key (achievementname) => is unique with ctrl+F
// ***********************************************************************************
_achievementTriggers = {
	"a_PrologueComplete": function PrologueComplete() { return
		// Core group
		never(
			!isGameRunning() 					||
			IsViewingCutsceneFromExtraMenu_old()	||
			isNewCutsceneLoaded()				
		) &&
		(
			(		// Alt 1 => true when last prologue cutscene finishes (has been running for 500 frames)
				repeated(700, 
					isCutsceneActive() && isCurrentChapter("Prologue") &&
					isCurrentCutsceneMasterId_0(0x90bc0) 	&& 
					isCurrentCutsceneMasterId_1(0x1) 		&& 
					isCurrentCutsceneMasterId_2(0x0) 		&&
					priorCutsceneId(16) == 0x43c58c5a	&&	currentCutsceneId(16) == 0xd7e805ff	&&
					priorCutsceneId(18) == 0xc58acc94	&&	currentCutsceneId(18) == 0xcedfff04	&&
					priorCutsceneId(19) == 0x220000ec	&&	currentCutsceneId(19) == 0x4a007500
				) && isCutsceneDone()
			) || (	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Prologue")
			)
		)},
	"a_Chapter1Complete": function Chapter1Complete() { return
		// Core group
		never(
			!isGameRunning() 					||
			IsViewingCutsceneFromExtraMenu_old()	||
			isNewCutsceneLoaded()				
		) &&
		(
			(		// Alt 1 => true when last prologue cutscene finishes (has been running for 300 frames)
				repeated(300, 
					isCutsceneActive() && isCurrentChapter("Chapter1") &&
					isCurrentCutsceneMasterId_0(0x11a40) 	&& 
					isCurrentCutsceneMasterId_1(0x1) 		&& 
					isCurrentCutsceneMasterId_2(0x2) 		&&
					priorCutsceneId(14) == 0x50ff199a	&&	currentCutsceneId(14) == 0xae99999	&&
					priorCutsceneId(15) == 0x41354bf6	&&	currentCutsceneId(15) == 0x168e7af	&&
					priorCutsceneId(17) == 0x5e0000		&&	currentCutsceneId(17) == 0x800108
				) && isCutsceneDone()
			) || (	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter1")
			)
		)},
	"a_Chapter2Complete": function Chapter2Complete() { return
		// Core group
		never(
			!isGameRunning() 					||
			IsViewingCutsceneFromExtraMenu_old()	||
			isNewCutsceneLoaded()				
		) &&
		(
			(		// Alt 1 => true when last prologue cutscene finishes (has been running for 300 frames)
				repeated(200, 
					isCutsceneActive() && isCurrentChapter("Chapter2") &&
					isCurrentCutsceneMasterId_0(0x3b240) 	&& 
					isCurrentCutsceneMasterId_1(0x3) 		&& 
					isCurrentCutsceneMasterId_2(0x2) 		&&
					priorCutsceneId(20) == 0xeb3004d0	&&	currentCutsceneId(20) == 0xf372f766	&&
					priorCutsceneId(14) == 0x4831736	&&	currentCutsceneId(14) == 0x002effa0	&&
					priorCutsceneId(2) == 0xe9dbfa97	&&	currentCutsceneId(2) == 0x0479ff42
				) && isCutsceneDone()
			) || (	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter2")
			)
		)},
	"a_Chapter3Complete": function Chapter3Complete() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(IsViewingCutsceneFromExtraMenu_old())	&&
		( 	
			( 		// Alt 1 => true when last chapter cutscene finishes
				tally(3, [
					once(	// Block A => IDs 1st cutscene sequence 
						isCurrentChapter("Chapter3") && isCutsceneActive() &&
						isCurrentCutsceneMasterId_0(0x19d80)	&&
						isCurrentCutsceneMasterId_1(0x1)		&&
						isCurrentCutsceneMasterId_2(0x0)		&&
						currentCutsceneId(1) == 0xd88c0086 	&& 
						currentCutsceneId(6) == 0xfe4d2e91 	&&
						currentCutsceneId(14) == 0x01bd0079),	
					once(	// Block B => IDs 2nd cutscene sequence 
						isCurrentChapter("Chapter3") && isCutsceneActive() &&
						isCurrentCutsceneMasterId_0(0xcfb40)	&&	isPriorCutsceneMasterId_0(0x19d80)	&&
						isCurrentCutsceneMasterId_1(0x1)		&&
						isCurrentCutsceneMasterId_2(0x0)		&&
						currentCutsceneId(3) == 0x11101119	&& 
						currentCutsceneId(11) == 0x17f8e6df	&&
						currentCutsceneId(18) == 0x011bfc57),
					once(	// Block C => IDs 3rd cutscene sequence 
						isCurrentChapter("Chapter3") && isCutsceneActive() &&
						isCurrentCutsceneMasterId_0(0x39680)	&&	isPriorCutsceneMasterId_0(0xcfb40)	&&
						isCurrentCutsceneMasterId_1(0x1)		&&
						isCurrentCutsceneMasterId_2(0x0)		&&
						currentCutsceneId(2) == 0x0098fe51 	&& 
						currentCutsceneId(9) == 0xf2e68100 	&&
						currentCutsceneId(19) == 0x00012000)]
				) &&
				isCutsceneDone()
			) || ( 	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter3")
			)
		)},
	"a_Chapter4CompletePan": function Chapter4CompletePan() { return
		never(
			!isGameRunning() 					||
			isNewCutsceneLoaded()				||
			IsViewingCutsceneFromExtraMenu_old()	||
			!isCurrentCutsceneMasterId_0(0x54580)
		) &&
		isCurrentSelectedInventoryItem("FryingPan") && isCutsceneDone()},
	"a_Chapter4CompleteSign": function Chapter4CompletePan() { return
		never(
			!isGameRunning() 					||
			isNewCutsceneLoaded()				||
			IsViewingCutsceneFromExtraMenu_old()	||
			!isCurrentCutsceneMasterId_0(0x547c0)
		) &&
		isCurrentSelectedInventoryItem("Sign") && isCutsceneDone()},
	"a_Chapter5Complete": function Chapter5Complete() { return
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive_old()) 				&&
		never(IsViewingCutsceneFromExtraMenu_old())	&&
		isCurrentSelectedInventoryItem("Antidote") && 
		(
			(
				repeated(1920, 
					currentCutsceneId(7) == 0x1a5f414b 	&&
					currentCutsceneId(10) == 0x11111110 &&
					currentCutsceneId(11) == 0x129e16dd &&
					currentCutsceneId(15) == 0xd0eaf60d &&
					currentCutsceneId(21) == 0x00300058)
			) || (
				isChapterFinished("Chapter5")
			)
		)},
	"a_Chapter6CompleteThriller": function Chapter6CompleteThriller() {	return
		never(
			!isGameRunning() 				||
			!isCurrentChapter("Chapter6")	||
			IsViewingCutsceneFromExtraMenu_old()
		) &&
		once(
			isThrillerStoryPicked() && isFindCauseDeathPicked() &&
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x82 && // Block => IDs thriller story choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff91 &&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x40fffe &&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4fffe7 &&
			currentCutsceneId(1) == 0x14b7ff2e && priorCutsceneId(1) == 0x82fe9c && 
			currentCutsceneId(18) == 0xf8ef1a5d && priorCutsceneId(18) == 0xe6e531b2 && 
			currentCutsceneId(21) == 0xfbb7024f && priorCutsceneId(21) == 0xe6e531b0
		) && 
		trigger_when(
			tally(100, 
					currentCutsceneId(16) == 0xd7070002 && priorCutsceneId(16) == 0x14003200 && // Block => IDs cutscene with love or thriller movie poster
					currentCutsceneId(17) == 0xaffff73c && priorCutsceneId(17) == 0xe7151922 && 
					currentCutsceneId(18) == 0x0001fa74 && priorCutsceneId(18) == 0x00390053 &&
					onScreenTextID(0) == 0x5a && prior(onScreenTextID(0)) == 0x62
			) &&
			isCutsceneSectionDone()
		)},
	"a_Chapter6CompleteLove": function Chapter6CompleteLove() {	return
		never(
			!isGameRunning() 				||
			!isCurrentChapter("Chapter6")	||
			IsViewingCutsceneFromExtraMenu_old()
		) &&
		once(
			!isThrillerStoryPicked() && isFindCauseDeathPicked() &&
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x82 &&	// Block => IDs love story choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x3fff90 &&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x3ffffd &&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x50ffe8 &&
			currentCutsceneId(1) == 0x14b7ff2e && priorCutsceneId(1) == 0x82fe9c && 
			currentCutsceneId(18) == 0xf8ef1a5d && priorCutsceneId(18) == 0xe6e531b2 && 
			currentCutsceneId(21) == 0xfbb7024f && priorCutsceneId(21) == 0xe6e531b0
		) && 
		trigger_when(
			tally(100, 
					currentCutsceneId(16) == 0xd7070002 && priorCutsceneId(16) == 0x14003200 && // Block => IDs cutscene with love or thriller movie poster
					currentCutsceneId(17) == 0xaffff73c && priorCutsceneId(17) == 0xe7151922 && 
					currentCutsceneId(18) == 0x0001fa74 && priorCutsceneId(18) == 0x00390053 &&
					onScreenTextID(0) == 0x5a && prior(onScreenTextID(0)) == 0x62
			) &&
			isCutsceneSectionDone()
		)},
	"a_Chapter7Complete": function Chapter7Complete() { return
		never(
			!isGameRunning() 				||
			!isCutsceneActive_old() 			||
			IsViewingCutsceneFromExtraMenu_old()
		) && (
			(
				tally(820, [
					once(
						currentCutsceneId(6) == 0x026d0f2e && priorCutsceneId(6) == 0xe6df2e37	 	&&
						currentCutsceneId(12) == 0xe6df02b3 && priorCutsceneId(12) == 0x111 		&&
						currentCutsceneId(16) == 0x7c00cc00 && priorCutsceneId(16) == 0x91ff6ffd 	&&
						onScreenTextID(0) == 0x3d && prior(onScreenTextID(0)) == 0x5a), 
					once(
						currentCutsceneId(15) == 0x0b22008d && priorCutsceneId(15) == 0x58f0000 	&&
						currentCutsceneId(18) == 0x0000ee23 && priorCutsceneId(18) == 0x1280050 	&&
						currentCutsceneId(19) == 0x19000001 && priorCutsceneId(19) == 0x6f033301 	&&
						onScreenTextID(0) == 0x46 && prior(onScreenTextID(0)) == 0x49), 
					once(
						currentCutsceneId(4) == 0x01671881 && priorCutsceneId(4) == 0xe6df2f0d 	&&
						currentCutsceneId(11) == 0x042cefdf && priorCutsceneId(11) == 0x2a1 	&&
						currentCutsceneId(18) == 0x013b06c5 && priorCutsceneId(18) == 0xee23 	&&
						onScreenTextID(0) == 0x2a && prior(onScreenTextID(0)) == 0x89), 
					repeated(817, 
						currentCutsceneId(15) == 0xff86053f && priorCutsceneId(15) == 0xffe8ff65 	&&
						currentCutsceneId(17) == 0xfd1aff98 && priorCutsceneId(17) == 0xff5afff1 	&&
						currentCutsceneId(19) == 0xeecebe00 && priorCutsceneId(19) == 0x42000001	&&
						onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x2a)
				])				
			) || (
				isChapterFinished("Chapter7")
			)
		)},	
	"a_Chapter8Complete": function Chapter8Complete() { return
		never(
			!isGameRunning()					||
			!isCutsceneActive_old()					||
			IsViewingCutsceneFromExtraMenu_old()
		) && (
			isChapterFinished("Chapter8_Ancestress") ||
			isChapterFinished("Chapter8_NoAncestress")
		)},
	"a_EndingA": function EndingA() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu_old() ||
			IsViewingEndingFromExtraMenu()
		) &&
		tally(4, [
			once(
				currentCutsceneId(1) == 0xff4fffe8 	&& priorCutsceneId(1) == 0x417eeb1 		&&	// Block => IDs if player has chosen to have Margarette stay in present
				currentCutsceneId(6) == 0xfea5feec 	&& priorCutsceneId(6) == 0xd242002c 	&&
				currentCutsceneId(13) == 0x132a0000 && priorCutsceneId(13) == 0xe6e5ff4f 	&&
				onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x8a 		&&
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x3fff95 	&&
				onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80008 	&&
				onScreenTextID(7) == 0x0 && prior(onScreenTextID(7)) == 0x500069),
			once(
				currentCutsceneId(2) == 0x0c750000 	&& priorCutsceneId(2) == 0xa0b7c40e 	&&
				currentCutsceneId(8) == 0xa6a84607 	&& priorCutsceneId(8) == 0xf4d518e4 	&&
				currentCutsceneId(20) == 0x0074040e && priorCutsceneId(20) == 0x11aef3b 	&&
				onScreenTextID(0) == 0x1e 		&& prior(onScreenTextID(0)) == 0x32 	&&
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ffe1 		&&
				onScreenTextID(2) == 0x0 && prior(onScreenTextID(2)) == 0x4f0000),
			once(
				currentCutsceneId(3) == 0x00fe16fd 	&& priorCutsceneId(3) == 0x21cf25e6 	&&
				currentCutsceneId(6) == 0x08e4cf25 	&& priorCutsceneId(6) == 0x1111			&&
				currentCutsceneId(14) == 0x0014fe20 && priorCutsceneId(14) == 0xe6e531b2 	&&
				onScreenTextID(0) == 0x78 		&& prior(onScreenTextID(0)) == 0x0 	&&
				onScreenTextID(1) == 0x40ff85 	&& prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(5) == 0x50ffe3 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(7) == 0x00911109 	&& priorCutsceneId(7) == 0x15e90194 	&&
				currentCutsceneId(15) == 0x008cffa7 && priorCutsceneId(15) == 0xcf2518ed	&&
				currentCutsceneId(21) == 0x274a 	&& priorCutsceneId(21) == 0x122f0c7 	&&
				onScreenTextID(0) == 0x0 		&& prior(onScreenTextID(0)) == 0x1a 	&&
				onScreenTextID(1) == 0x0 	&& prior(onScreenTextID(1)) == 0x48ffea 	&&
				onScreenTextID(3) == 0x0 	&& prior(onScreenTextID(3)) == 0x50ffef)
		])},
	"a_EndingB1": function EndingB1() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu_old() ||
			IsViewingEndingFromExtraMenu()
		) &&
		tally(3, [
			once(
				currentCutsceneId(1) == 0xffe3ff87 	&& priorCutsceneId(1) == 0x111000d3 	&&
				currentCutsceneId(7) == 0x11111111 	&& priorCutsceneId(7) == 0x16f113f3 	&&
				currentCutsceneId(22) == 0x00011111 && priorCutsceneId(22) == 0x94042e18 	&&
				onScreenTextID(0) == 0x94 		&& prior(onScreenTextID(0)) == 0x127 	&&
				onScreenTextID(1) == 0x0040ffb0 && prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x0050002b && prior(onScreenTextID(2)) == 0x0),
			once(
				currentCutsceneId(2) == 0xfb3de903 	&& priorCutsceneId(2) == 0xfe615 		&&
				currentCutsceneId(8) == 0xd0c9fdec 	&& priorCutsceneId(8) == 0xfe7931e4 	&&
				currentCutsceneId(20) == 0xcf25e707 && priorCutsceneId(20) == 0x464da317 	&&
				onScreenTextID(0) == 0x82 		&& prior(onScreenTextID(0)) == 0x0 		&&
				onScreenTextID(1) == 0x0040ffad && prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(4) == 0x00080007 && prior(onScreenTextID(4)) == 0x0),
			once(
				currentCutsceneId(3) == 0x8f00b200 	&& priorCutsceneId(3) == 0x44000 		&&
				currentCutsceneId(9) == 0x50e597ff 	&& priorCutsceneId(9) == 0xcd33d946 	&&
				currentCutsceneId(19) == 0x1 && priorCutsceneId(19) == 0xa173d146 			&&
				onScreenTextID(0) == 0x0 		&& prior(onScreenTextID(0)) == 0x78 	&&
				onScreenTextID(1) == 0x0 		&& prior(onScreenTextID(1)) == 0x40ffa0 &&
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x400005)			
		])},
	"a_EndingB2": function EndingB2() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu_old() ||
			IsViewingEndingFromExtraMenu()
		) &&
		tally(3, [
			once(
				currentCutsceneId(1) == 0x0570cdee 	&& priorCutsceneId(1) == 0xf793 	&&
				currentCutsceneId(6) == 0x01001519 	&& priorCutsceneId(6) == 0xff28d481 &&
				currentCutsceneId(19) == 0x1e00c601 && priorCutsceneId(19) == 0x2c100 	&&
				onScreenTextID(0) == 0x9a 		&& prior(onScreenTextID(0)) == 0x74 &&
				onScreenTextID(1) == 0x0040ff85 && prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(5) == 0x0050ffb3 && prior(onScreenTextID(2)) == 0x0),
			once(
				currentCutsceneId(3) == 0x1afe51e3 	&& priorCutsceneId(3) == 0x48111111 	&&
				currentCutsceneId(5) == 0xffc800da 	&& priorCutsceneId(5) == 0x22a0000 		&&
				currentCutsceneId(17) == 0xcefc0011 && priorCutsceneId(17) == 0xffa5f6c0 	&&
				onScreenTextID(0) == 0x69 		&& prior(onScreenTextID(0)) == 0x9b 	&&
				onScreenTextID(1) == 0x0040ff6f && prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x0050fff3 && prior(onScreenTextID(4)) == 0x0),
			once(
				currentCutsceneId(3) == 0x8f00b200 	&& priorCutsceneId(3) == 0x2cfe0bfd 	&&
				currentCutsceneId(9) == 0x50e597ff 	&& priorCutsceneId(9) == 0xf6999910 	&&
				currentCutsceneId(22) == 0x01010006 && priorCutsceneId(22) == 0x82cf2518 	&&
				onScreenTextID(0) == 0x0 		&& prior(onScreenTextID(0)) == 0x78 	&&
				onScreenTextID(1) == 0x0 		&& prior(onScreenTextID(1)) == 0x40ffa0 &&
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x400005)			
		])},
	"a_EndingC": function EndingC() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu_old() || // --> Some reason this comparison becomes true during this cutscene 
			IsViewingEndingFromExtraMenu()		// 		=> resets count/tally during cutscene 
		) &&									// 		Workaround => this achievement popups sooner than the cutscene actually finishes
		tally(3, [
			once(
				currentCutsceneId(1) == 0x20008f 	&& priorCutsceneId(1) == 0x2ea0e6e5 	&&
				currentCutsceneId(6) == 0xef63031c	&& priorCutsceneId(6) == 0x1400000 		&&
				currentCutsceneId(19) == 0x00009200 && priorCutsceneId(19) == 0x60018f00 	&&
				onScreenTextID(0) == 0x8c 		&& prior(onScreenTextID(0)) == 0x1e 	&&
				onScreenTextID(1) == 0x40ffcd 	&& prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x50004a 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(2) == 0x00450264 	&& priorCutsceneId(2) == 0x1e20000 		&&
				currentCutsceneId(9) == 0x3b000400	&& priorCutsceneId(9) == 0xcefdb601 	&&
				currentCutsceneId(22) == 0x37116c44 && priorCutsceneId(22) == 0x9b44c815 	&&
				onScreenTextID(0) == 0x6a 		&& prior(onScreenTextID(0)) == 0x49 	&&
				onScreenTextID(1) == 0x40ffb1 	&& prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x500019 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(4) == 0xfd9eff50 	&& priorCutsceneId(4) == 0xff761cf8 		&&
				currentCutsceneId(12) == 0xff9e321e 	&& priorCutsceneId(12) == 0x1787d1f2 	&&
				currentCutsceneId(17) == 0x0026e59d && priorCutsceneId(17) == 0x31b08888		&&
				onScreenTextID(0) == 0x66 		&& prior(onScreenTextID(0)) == 0x8e &&
				onScreenTextID(1) == 0x40ff89 	&& prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(6) == 0xe00000 	&& prior(onScreenTextID(6)) == 0x0)			
		])},
	"a_EndingD": function EndingD() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_NoAncestress") ||
			IsViewingCutsceneFromExtraMenu_old() ||
			IsViewingEndingFromExtraMenu()
		) &&
		tally(1403, [
			once(
				currentCutsceneId(1) == 0x10a215e3 	&& priorCutsceneId(1) == 0x71cfcf2 		&&
				currentCutsceneId(7) == 0x9c6b458f	&& priorCutsceneId(7) == 0xe6e531b1 	&&
				currentCutsceneId(17) == 0xfff8f954 && priorCutsceneId(17) == 0x31b18888 	&&
				onScreenTextID(0) == 0x0 	&& prior(onScreenTextID(0)) == 0x38 	&&
				onScreenTextID(1) == 0x0 	&& prior(onScreenTextID(1)) == 0x48ffc1 &&
				onScreenTextID(3) == 0x0 	&& prior(onScreenTextID(3)) == 0x480016),
			once(
				currentCutsceneId(3) == 0x76205a00 	&& priorCutsceneId(3) == 0x3b03ba07 	&&
				currentCutsceneId(8) == 0xfcc401bc	&& priorCutsceneId(8) == 0xfca0fb97 	&&
				currentCutsceneId(15) == 0x7cfa451d && priorCutsceneId(15) == 0x167d0024 	&&
				onScreenTextID(0) == 0xaa 		&& prior(onScreenTextID(0)) == 0x0 	&&
				onScreenTextID(1) == 0x0040ff6f && prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(6) == 0x00a80000 && prior(onScreenTextID(6)) == 0x0),
			once(
				currentCutsceneId(5) == 0x02e3ecc2 	&& priorCutsceneId(5) == 0xe3701500 	&&
				currentCutsceneId(11) == 0x1b131921	&& priorCutsceneId(11) == 0x3f51452d 	&&
				currentCutsceneId(18) == 0x02b02608 && priorCutsceneId(18) == 0xdb 			&&
				onScreenTextID(0) == 0x85 		&& prior(onScreenTextID(0)) == 0x10e 	&&
				onScreenTextID(1) == 0x0040ffbc && prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x00500044 && prior(onScreenTextID(5)) == 0x0),
			repeated(1400,
				currentCutsceneId(7) == 0xffea0000 	&& priorCutsceneId(7) == 0x99110081 	&&
				currentCutsceneId(9) == 0x1fc43dae	&& priorCutsceneId(9) == 0xedff2f03 	&&
				currentCutsceneId(21) == 0x36cb469f && priorCutsceneId(21) == 0xb1e9469e 	&&
				onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x3f 		&&
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ff9c 	&&
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x48000a)
		])},
	"a_EndingE": function EndingE() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive_old()	||
			!isCurrentChapter("Epilogue_NoAncestress") ||
			IsViewingCutsceneFromExtraMenu_old() ||
			IsViewingEndingFromExtraMenu()
		) &&
		tally(3, [
			once(
				currentCutsceneId(3) == 0x8ffc5902 	&& priorCutsceneId(3) == 0x11f364f5 	&&
				currentCutsceneId(7) == 0x00b10013	&& priorCutsceneId(7) == 0xd8771232 	&&
				currentCutsceneId(17) == 0xf11a1921 && priorCutsceneId(17) == 0xe90e0230 	&&
				onScreenTextID(0) == 0xd2 		&& prior(onScreenTextID(0)) == 0x126 	&&
				onScreenTextID(1) == 0x40ffac 	&& prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x500028 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(5) == 0xdb54158e 	&& priorCutsceneId(5) == 0x29f0000 		&&
				currentCutsceneId(12) == 0xdb0ffdfd	&& priorCutsceneId(12) == 0xdb7e8908 	&&
				currentCutsceneId(22) == 0xba11cefe && priorCutsceneId(22) == 0x11ecf3fe 	&&
				onScreenTextID(0) == 0x59 		&& prior(onScreenTextID(0)) == 0xc2 	&&
				onScreenTextID(1) == 0x40ffa3 	&& prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x500025 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(9) == 0x00fc1cff 	&& priorCutsceneId(9) == 0x4d000000 	&&
				currentCutsceneId(17) == 0xe62b0d33	&& priorCutsceneId(17) == 0x00fa02cf 	&&
				currentCutsceneId(19) == 0xfd049e01 && priorCutsceneId(19) == 0x4d033301 	&&
				onScreenTextID(0) == 0x0 	&& prior(onScreenTextID(0)) == 0x2f 	&&
				onScreenTextID(1) == 0x0 	&& prior(onScreenTextID(1)) == 0x49ff7b &&
				onScreenTextID(3) == 0x0 	&& prior(onScreenTextID(3)) == 0x49ffea)
		])},
	"a_EnergyOrbLocatorPresentDay": function EnergyOrbLocatorPresentDay() {
		function measuredComparison() { return 
			tally(5, 
				energyUnitsZPad() > prev(energyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(
				isCurrentLoadedScene("PresentDayCity") 		|| 
				isCurrentLoadedScene("PresentDayNightCity") ||
				isCurrentLoadedScene("NightBefore") 
			) && 
			isGameRunning()}
		return 
			never(	// Reset when chapter changes or when using digipad
				energyUnitsZPad() < prev(energyUnitsZPad()) ||
				hasChapterChanged()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocator70s80s": function EnergyOrbLocator70s80s() {
		function measuredComparison() { return 
			tally(5, 				
				energyUnitsZPad() > prev(energyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive())}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(isCurrentLoadedScene("80sColdCity") || isCurrentLoadedScene("70sNightCity")) 	&& 	
			isGameRunning()}
		return 
			never( 	// Reset when chapter changes or when using digipad
				energyUnitsZPad() < prev(energyUnitsZPad()) ||
				hasChapterChanged()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocatorMiddleAges": function EnergyOrbLocatorMiddleAges() {
		function measuredComparison() { return 
			tally(6, 
				energyUnitsZPad() > prev(energyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(
				isCurrentLoadedScene("MedievalCity") 				|| 
				isCurrentLoadedScene("MedievalNightCity")			||
				isCurrentLoadedScene("ExplodedAlchemistBasement")	||
				isCurrentLoadedScene("MedievalChurch")
			) && isGameRunning()}
		return 
			never(	// Reset when chapter changes or when using digipad
				energyUnitsZPad() < prev(energyUnitsZPad()) ||
				hasChapterChanged()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocator1900Days": function EnergyOrbLocator1900Days() {
		function measuredComparison() { return 
			tally(5, 
				energyUnitsZPad() > prev(energyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(isCurrentLoadedScene("1900sCity") || isCurrentLoadedScene("1900sBrumMansion")) && 	
			isGameRunning()}
		return 
			never(	// Reset when chapter changes or when using digipad
				energyUnitsZPad() < prev(energyUnitsZPad()) ||
				hasChapterChanged()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive_old()) 				&&
		never(IsViewingCutsceneFromExtraMenu_old()) &&
		never(!isCurrentChapter("Chapter4")) 	&&
		(
			isCurrentSelectedInventoryItem("Sign") 	|| 
			isCurrentSelectedInventoryItem("FryingPan")
		) &&		
		tally(8, [
			once(
				currentCutsceneId(19) == 0x00008000 && priorCutsceneId(19) == 0x77c45331 &&
				currentCutsceneId(15) == 0x11111000 && priorCutsceneId(15) == 0x40),
			once(
				currentCutsceneId(17) == 0xff95ff72 && priorCutsceneId(17) == 0x37760000 &&
				currentCutsceneId(14) == 0xf655fff3 && priorCutsceneId(14) == 0x500050),
			once(onScreenTextID(0) == 0x1e && prior(onScreenTextID(0)) == 0x7d),
			once(onScreenTextID(0) == 0x3c && prior(onScreenTextID(0)) == 0xa0),
			once(onScreenTextID(0) == 0x33b && prior(onScreenTextID(0)) == 0x3cf),
			once(onScreenTextID(0) == 0x20d && prior(onScreenTextID(0)) == 0x2c1),
			once(onScreenTextID(0) == 0x4e && prior(onScreenTextID(0)) == 0xd3),
			once(onScreenTextID(0) == 0x53 && prior(onScreenTextID(0)) == 0x82)
		]) &&
		onScreenTextID(0) == 0x00 && prior(onScreenTextID(0)) == 0x2d},
	"a_MeetOldMiriam": function MeetOldMiriam() { return // WIP => test when told Margarette she's not your ancestress
		never(
			!isGameRunning()					||
			!isCutsceneActive_old()					||
			!isCurrentChapter("Chapter7")		||
			IsViewingCutsceneFromExtraMenu_old()
		) &&
		tally(3, [
			once(
				currentCutsceneId(2) == 0xe6de0168 	&& priorCutsceneId(2) == 0xe6e5ff4f 	&&
				currentCutsceneId(6) == 0xe6dff9b8 	&& priorCutsceneId(6) == 0x3e5 			&&
				currentCutsceneId(19) == 0x10600 	&& priorCutsceneId(19) == 0xb9f42303 	&&
				onScreenTextID(0) == 0x4c 		&& prior(onScreenTextID(0)) == 0x1d &&
				onScreenTextID(1) == 0x48ffb4 	&& prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(3) == 0x49002d 	&& prior(onScreenTextID(3)) == 0x0),
			once(
				currentCutsceneId(5) == 0x111 		&& priorCutsceneId(5) == 0xe32b0057	 	&&
				currentCutsceneId(9) == 0x50050716 	&& priorCutsceneId(9) == 0x3e000000 	&&
				currentCutsceneId(16) == 0x300ceae6 && priorCutsceneId(16) == 0xc50044f1 	&&
				onScreenTextID(0) == 0x7e 		&& prior(onScreenTextID(0)) == 0xe4 &&
				onScreenTextID(2) == 0x4c0000 	&& prior(onScreenTextID(2)) == 0x0 	&&
				onScreenTextID(5) == 0x50000d 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(1) == 0x1196ed85 	&& priorCutsceneId(1) == 0x111	 		&&
				currentCutsceneId(18) == 0x00f30000 && priorCutsceneId(18) == 0x780000 		&&
				currentCutsceneId(24) == 0x54504ec1 && priorCutsceneId(24) == 0x7f39fd3e 	&&
				onScreenTextID(0) == 0x1b 		&& prior(onScreenTextID(0)) == 0x81 &&
				onScreenTextID(3) == 0x400027 	&& prior(onScreenTextID(3)) == 0x0 	&&
				onScreenTextID(5) == 0x500025 	&& prior(onScreenTextID(5)) == 0x0)
		]) &&
		currentCutsceneId(4) == 0x01671881 	&& priorCutsceneId(4) == 0x0dc2ffb9	 	&&
		currentCutsceneId(18) == 0x13b06c5 && priorCutsceneId(18) == 0x00f30000 	&&
		currentCutsceneId(25) == 0x458d511a && priorCutsceneId(25) == 0x0a225902 	&&
		onScreenTextID(0) == 0x0 	&& prior(onScreenTextID(0)) == 0x6b 	&&
		onScreenTextID(1) == 0x0 	&& prior(onScreenTextID(1)) == 0x40ffa5 &&
		onScreenTextID(2) == 0x0 	&& prior(onScreenTextID(2)) == 0x3f0000},
	"a_GetOrnamentalEgg": function AcquireOrnamentalEgg() { return
		never(	// Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning() 				|| 
			!isCutsceneActive_old() 			||
			!isCurrentChapter("Chapter1")	||
			IsViewingCutsceneFromExtraMenu_old()) 	&& 
		repeated(350, priorCutsceneId(10) == 0xfffe8366)		&& // this block => last cutscene has run for about 350 frames
		repeated(350, priorCutsceneId(13) == 0x3cd31cf) 		&&
		repeated(350, priorCutsceneId(15) == 0x11110597) 		&& 
		repeated(350, currentCutsceneId(10) == 0x1ce0d25d) 		&&
		repeated(350, currentCutsceneId(13) == 0xc841ccb) 		&&
		repeated(350, currentCutsceneId(15) == 0x99991119)},
	"a_EggCollection1": function EggCollection1() { return 
		isGameRunning() 					&&		
		isCurrentChapter("Chapter1")		&&
		!IsViewingCutsceneFromExtraMenu_old()	&&
		isCurrentCutsceneMasterId_0(0x2f9c0)	&&
		isCurrentCutsceneMasterId_1(0x9) 		&&
		isCurrentCutsceneMasterId_2(0xa)		&&
		never(isNewCutsceneLoaded())	&&	// Reset below count on a new cutscene	
		repeated(320, isCutsceneActive()	&&	// This block => last section of cutscene has run for about 320 frames
			priorCutsceneId(11) == 0x4d5fc40	&&	currentCutsceneId(11) == 0x11111112 && 
			priorCutsceneId(14) == 0x55005ce	&&	currentCutsceneId(14) == 0x30ff26b	&&
			priorCutsceneId(16) == 0x88065620	&&	currentCutsceneId(16) == 0x11d8fa
		) &&
		isCutsceneDone()},
	"a_EggCollection2": function EggCollection2() { return 
		never(!isGameRunning() || isNewCutsceneLoaded() || IsViewingCutsceneFromExtraMenu_old()) &&
		never(!isCurrentChapter("Chapter3") && !isCurrentChapter("Chapter4")) &&
		isCutsceneDone() &&
		(	
			(
				repeated(200,	// Block => IDs cutscene in chapter 3 when giving egg to barman
					isCutsceneActive() &&
					isCurrentCutsceneMasterId_0(0x2f9c0)	&&
					isCurrentCutsceneMasterId_1(0x9) 		&&
					isCurrentCutsceneMasterId_2(0xa)		&&
					priorCutsceneId(22) == 0x68df3900	&&	currentCutsceneId(22) == 0xd4faa9fa	&&
					priorCutsceneId(12) == 0x18e6		&&	currentCutsceneId(12) == 0x7bff8c	&&
					priorCutsceneId(17) == 0x66319a2	&&	currentCutsceneId(17) == 0xff2009cc	
				)
			) || (
				repeated(200,	// Block => IDs cutscene in chapter 4 when giving egg to barman
					isCutsceneActive() &&
					isCurrentCutsceneMasterId_0(0x2f9c0)	&&
					isCurrentCutsceneMasterId_1(0x9) 		&&
					isCurrentCutsceneMasterId_2(0xa)		&&
					priorCutsceneId(19) == 0x2000000	&&	currentCutsceneId(19) == 0x04006a00	&&
					priorCutsceneId(12) == 0xfe1506b8	&&	currentCutsceneId(12) == 0x00b20009	&&
					priorCutsceneId(17) == 0x2881cf5	&&	currentCutsceneId(17) == 0x167014f2	
				)
			)
		)},
	"a_IntroduceEggCollecting": function IntroduceEggCollecting() { return 
		never(!isGameRunning()) 						&& 	// This block => Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
		never(!isCutsceneActive_old()) 						&&
		never(!isCurrentChapter("Chapter2"))			&&
		never(IsViewingCutsceneFromExtraMenu_old())			&&

		isCurrentSelectedInventoryItem("OrnamentalEgg") && 	// Is currently selected item the 'OrnamentalEgg'
		repeated(500, prior(currentCutsceneId(14)) == 0xe6df0168) 	&&	// this block => last cutscene has run for about 380 frames
		repeated(500, prior(currentCutsceneId(15)) == 0x168ec1a) 	&&
		repeated(500, prior(currentCutsceneId(17)) == 0x1ca92f3c) 	&&
		repeated(500, currentCutsceneId(14) == 0xa90841) 			&&
		repeated(500, currentCutsceneId(15) == 0x19) 				&&
		repeated(500, currentCutsceneId(17) == 0x0) 				&&

		repeated(3, (hasOneFrameTimerReset()))}, // Unlock achievement when cutscene is done = oneFrameTimerHasReset 3 times
	"a_IntroduceEggCollecting2": function IntroduceEggCollecting2() { return 
		never(
			!isGameRunning() 					||
			!isCutsceneActive_old() 				||	
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter6") && !isCurrentChapter("Chapter7") && !isCurrentChapter("Chapter8_Ancestress") && !isCurrentChapter("Chapter8_NoAncestress")
		) &&
		once(
			currentCutsceneId(1) == 0x3169070e 	&& priorCutsceneId(1) == 0xffc1ffd9 	&& // All blocks => IDs cutscene where Eike gives the pocket watch to pay for his coffee
			currentCutsceneId(4) == 0x02410000 	&& priorCutsceneId(4) == 0x016818e1 	&&
			currentCutsceneId(22) == 0xad082100 && priorCutsceneId(22) == 0x19324308 	&&
			onScreenTextID(0) == 0x51 && prior(onScreenTextID(0)) == 0x31 &&
			onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80109
		) &&
		once(
			currentCutsceneId(2) == 0xffd2cf32 	&& priorCutsceneId(2) == 0x11112110 &&
			currentCutsceneId(8) == 0xe6df1184 	&& priorCutsceneId(8) == 0x1001f5d1 &&
			currentCutsceneId(15) == 0x0000f855 && priorCutsceneId(15) == 0x127 	&&
			onScreenTextID(0) == 0x64	&& prior(onScreenTextID(0)) == 0x91 		&&
			onScreenTextID(2) == 0x0 	&& prior(onScreenTextID(2)) == 0x490000
		) &&
		once(
			currentCutsceneId(6) == 0x00000019 	&& priorCutsceneId(6) == 0xcee1020a 	&&
			currentCutsceneId(11) == 0x00af0023 && priorCutsceneId(11) == 0x740034 		&&
			currentCutsceneId(20) == 0x211205d6 && priorCutsceneId(20) == 0xee9f1e15 	&&
			onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x43 				&&
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ff85
		)},
	"a_PocketWatchCollection": function PocketWatch() { return 
		never(
			!isGameRunning() 					||
			!isCutsceneActive_old() 				||
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter7")
		) &&
		tally(2, [
			once(
				currentCutsceneId(1) == 0x434cc1c6 	&& priorCutsceneId(1) == 0x158140f3 	&&
				currentCutsceneId(4) == 0xc1502119 	&& priorCutsceneId(4) == 0x1681214 		&&
				currentCutsceneId(16) == 0x8e000000 && priorCutsceneId(16) == 0xdf18e5eb 	&&
				onScreenTextID(0) == 0x3c 		&& prior(onScreenTextID(0)) == 0x0 &&
				onScreenTextID(1) == 0x48ff8b	&& prior(onScreenTextID(1)) == 0x0 &&
				onScreenTextID(4) == 0x8000b 	&& prior(onScreenTextID(4)) == 0x0),
			once(
				currentCutsceneId(3) == 0xaf001e00 	&& priorCutsceneId(3) == 0xa0ff3dfb 	&&
				currentCutsceneId(10) == 0x59e60168 && priorCutsceneId(10) == 0x1db5f2bf 	&&
				currentCutsceneId(20) == 0x0126ff41 && priorCutsceneId(20) == 0xe2db024c 	&&
				onScreenTextID(0) == 0x3c 	&& prior(onScreenTextID(0)) == 0x8c 	&&
				onScreenTextID(1) == 0x0	&& prior(onScreenTextID(1)) == 0x48ff7a &&
				onScreenTextID(4) == 0x0 	&& prior(onScreenTextID(4)) == 0x80004)
		]) &&
		onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x1e},
	"a_PocketWatchReminiscing": function PocketWatchReminiscing() { return
		never(
			!isGameRunning() 					||
			!isCutsceneActive_old()					||
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter8")
		) &&
		tally(3, [
			once(
				currentCutsceneId(6) == 0xe8591922 	&& priorCutsceneId(6) == 0x7e007d 		&&
				currentCutsceneId(12) == 0x0fea0239 && priorCutsceneId(12) == 0x22001dc 		&&
				currentCutsceneId(20) == 0x0be3ff78 && priorCutsceneId(20) == 0xd25 		&&
				onScreenTextID(0) == 0x36 && prior(onScreenTextID(0)) == 0x4a),
			once(
				currentCutsceneId(5) == 0xc399d0f8 	&& priorCutsceneId(5) == 0x65b0000 		&&
				currentCutsceneId(14) == 0x134de6df && priorCutsceneId(14) == 0x1d00000 	&&
				currentCutsceneId(22) == 0xd6009eff && priorCutsceneId(22) == 0xa00208e8 	&&
				onScreenTextID(0) == 0x4b 		&& prior(onScreenTextID(0)) == 0x56 	&&
				onScreenTextID(1) == 0x40ff9c 	&& prior(onScreenTextID(1)) == 0x0 		&&
				onScreenTextID(5) == 0x500023 	&& prior(onScreenTextID(5)) == 0x0),
			once(
				currentCutsceneId(9) == 0x01001400 	&& priorCutsceneId(9) == 0x85000000 	&&
				currentCutsceneId(13) == 0x0726cdf0 && priorCutsceneId(13) == 0xa6ff36 		&&
				currentCutsceneId(21) == 0x02aa06de && priorCutsceneId(21) == 0xfffdf7ca 	&&
				onScreenTextID(0) == 0x65 		&& prior(onScreenTextID(0)) == 0x21 &&
				onScreenTextID(1) == 0x48ffab 	&& prior(onScreenTextID(1)) == 0x0 	&&
				onScreenTextID(4) == 0x80004 	&& prior(onScreenTextID(4)) == 0x0),
		]) &&
		onScreenTextID(0) == 0x0 && prev(onScreenTextID(0)) == 0x96},
	"a_EikeThePyromancer": function EikeThePyromancer() { return // 
		never(
			!isGameRunning() 					|| 
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter2")		||
			!isStatueChosen()					||	// Reset this cheevo when flowers is picked or when telephone is used
			isTelephoneUsedToScareCrowd()
		) &&
		tally(200, 	// Tally block => IDs cutscene where Eike scares crowd with the lighter
			repeated(100,
				isCurrentSelectedInventoryItem("Lighter") 	&&
				prior(currentCutsceneId(2)) == 0x2ff955 	&& 	currentCutsceneId(2) == 0x10111112 	&&
				prior(currentCutsceneId(4)) == 0xe6de04a6 	&&	currentCutsceneId(4) == 0xde980748	&&
				prior(currentCutsceneId(6)) == 0x1100040a 	&&	currentCutsceneId(6) == 0x12480620),
			repeated(100,
				isCurrentSelectedInventoryItem("Lighter") 	&& 
				onScreenTextID(0) == 0x23 					&& 
				prior(onScreenTextID(1)) == 0x48ffcb && onScreenTextID(1) == 0x0 &&
				prior(onScreenTextID(3)) == 0x490027 && onScreenTextID(3) == 0x0)
		) &&
		trigger_when(	// Trigger when the last cutscene in the chapter finishes
			isCurrentCutsceneMasterId_0(0x3b240) 	&&
			isCurrentCutsceneMasterId_1(0x3)		&&
			isCurrentCutsceneMasterId_2(0x2)		&&
			isCutsceneDone()
		)},			
	"a_EikeTheMagician": function EikeTheMagician() { return 
		never(
			!isGameRunning() 					|| 
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter2")		||
			!isStatueChosen()					||	// Reset this cheevo when flowers is picked or when lighter is used
			!isTelephoneUsedToScareCrowd()
		) &&
		tally(200, 	// Tally block => IDs cutscene where Eike scares crowd with the cellphone
			repeated(100,  
				isCutsceneActive_old() &&
				isCurrentSelectedInventoryItem("Cellphone") && 
				currentCutsceneId(11) == 0xc4612c05 && priorCutsceneId(11) == 0xff9c1670 &&
				currentCutsceneId(15) == 0x0 		&& priorCutsceneId(15) == 0xc57c78c2 &&
				currentCutsceneId(18) == 0x1276 	&& priorCutsceneId(18) == 0xfc240056),
			repeated(100, 
				isCutsceneActive_old() &&
				isCurrentSelectedInventoryItem("Cellphone") && 
				currentCutsceneId(3) == 0x50000000 && priorCutsceneId(3) == 0xfe51a2ff &&
				currentCutsceneId(8) == 0x0481fede && priorCutsceneId(8) == 0xfbd101d3 &&
				currentCutsceneId(11) == 0x2169fb15 && priorCutsceneId(11) == 0xc4612c05)
		) &&
		trigger_when(	// Trigger when the last cutscene in the chapter finishes
			isCurrentCutsceneMasterId_0(0x3b240) 	&&
			isCurrentCutsceneMasterId_1(0x3)		&&
			isCurrentCutsceneMasterId_2(0x2)		&&
			isCutsceneDone()
		)},	
	"a_EikeTheFlorist": function EikeTheFlorist() { return 
		never(	// Reset counts if game isn't running, game isn't in the correct chapter 
			!isGameRunning() 					|| 
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter2")
		) &&
		once(	// True => when picked to plant flowers while talking to gardeneer
			isCutsceneActive() && isCurrentSelectedInventoryItem("SquireCrest") &&
			!isStatueChosen() &&
			currentCutsceneId(14) == 0x4831736	&& // This block => check if cutscene after choice has started
			currentCutsceneId(15) == 0x431ab010	&&
			currentCutsceneId(17) == 0x4f1f9ae	&&
			prior(onScreenTextID(1)) == 0x003fff5f	&& onScreenTextID(1) == 0	&&	// This block => check if flowers is chosen
			prior(onScreenTextID(7)) == 0x0050ffea	&& onScreenTextID(7) == 0	&&
			prior(onScreenTextID(8)) == 0x005000a3	&& onScreenTextID(8) == 0
		) &&
		trigger_when(	// Trigger when the last cutscene in the chapter finishes
			isCurrentCutsceneMasterId_0(0x3b240) 	&&
			isCurrentCutsceneMasterId_1(0x3)		&&
			isCurrentCutsceneMasterId_2(0x2)		&&
			!isStatueChosen() && isCutsceneDone()
		)},
	"a_BarmansChildren": function BarmansChildren() { return
		never(
			!isGameRunning() 					||
			!isCutsceneActive_old() 				||
			IsViewingCutsceneFromExtraMenu_old() 	||
			!isCurrentChapter("Chapter5")
		) &&
		tally(2, [
			once(
				currentCutsceneId(2) == 0x15f4fdd0	&& priorCutsceneId(2) == 0x312f0008 &&
				currentCutsceneId(9) == 0x2917a2ff 	&& priorCutsceneId(9) == 0x45fc56fb &&
				currentCutsceneId(14) == 0x01390152 && priorCutsceneId(14) == 0x5bb0000 &&
				onScreenTextID(0) == 0x29		&& prior(onScreenTextID(0)) == 0x3d	&&
				onScreenTextID(1) == 0x48ffae	&& prior(onScreenTextID(1)) == 0x0	&&
				onScreenTextID(4) == 0x80005	&& prior(onScreenTextID(4)) == 0x0),
			once(
				currentCutsceneId(2) == 0x15f4fdd0	&& priorCutsceneId(2) == 0x312f0008 &&
				currentCutsceneId(9) == 0x2917a2ff 	&& priorCutsceneId(9) == 0x45fc56fb &&
				currentCutsceneId(14) == 0x01390152 && priorCutsceneId(14) == 0x5bb0000 &&
				onScreenTextID(0) == 0x74		&& prior(onScreenTextID(0)) == 0x52	&&
				onScreenTextID(1) == 0x40ff87	&& prior(onScreenTextID(1)) == 0x0	&&
				onScreenTextID(5) == 0x50ffec	&& prior(onScreenTextID(5)) == 0x0)			
		]) &&
		onScreenTextID(0) == 0x0 && prev(onScreenTextID(0)) == 0x50},
	"a_LostYoungCouple1": function LostYoungCouple1() { 
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2() == 0x08a329ac),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2() == 0x08a329fc),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a329c0),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a32a10),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2() == 0x08a329d4),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2() == 0x08a32a24)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter2")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isGameRunning()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter2")
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a329fc 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a329ac 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a32a10 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a329c0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a32a24 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a329d4 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple2": function LostYoungCouple2() {  
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2() == 0x08a32c18),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2() == 0x08a32c68),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a32c2c),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a32c7c),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2() == 0x08a32c40),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2() == 0x08a32c90)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter3")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isGameRunning()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}	
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter3")
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a32c68 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a32c18 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a32c7c 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a32c2c 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a32c90 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a32c40 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple3" : function LostYoungCouple3() {
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2() == 0x08a33000),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2() == 0x08a33050),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a33014),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a33064),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2() == 0x08a33028),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2() == 0x08a33078)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter4")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isGameRunning()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter4")
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a33050 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a33000 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a33064 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a33014 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a33078 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a33028 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple4": function LostYoungCouple4() {
		function measuredComparison() { return
			tally(2, [
				once(interactionID_2() == 0x08a331cc),		// => cutscene when talking to man 1st time
				once(interactionID_2() == 0x08a331e0)		// => cutscene when talking to man 2nd time
			])}
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter5")) && 
			isGameRunning() && 
			!IsViewingCutsceneFromExtraMenu_old()} 
		return
			never(
				!isCurrentChapter("Chapter5")
			) &&
			unless(
				interactionID_1() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a331cc 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a331e0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple5": function LostYoungCouple5() {
		// Private functions
		function measuredComparison() { return
			tally(2, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2() == 0x08a33398),			// Add hit: +1  	=> for talking to man 
				once(											// Add hit: +1		=> when talking to woman and picking dialogue option: Tell the truth
					interactionID_2() == 0x08a333fc && prior(interactionID_2()) == 0x8a333e8 &&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff92		&&	
					onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80007			&&	
					onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4ffff0	
				)			
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter7")) &&	// Hit count 100 => when loading a savefile to another chapter, there's a few 
			isGameRunning() && 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter7")
			) &&
			unless(
				interactionID_1() != 0x08a1bb38 	&&		// Block => cutscene when talking to man 
				interactionID_2() != 0x08a33398 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08a1bb44 &&			// Block => cutscene when talking to woman and picking dialogue option: Tell the truth
				interactionID_2() != 0x08a333fc && prior(interactionID_2()) != 0x8a333e8 &&
				interactionID_3() != 0x197		&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple6": function LostYoungCouple6() { 
		function measuredComparison() { return
			tally(2, [									//			= 2
				once(interactionID_2() == 0x08a335f0),	// Add hit: +1  	=> for talking to man before experiment
				once(interactionID_2() == 0x08a3367c)	// Add hit: +1		=> for talking to man after experiment for 2nd time after picking the dialogue option: Lovers never destined to meet 
			])}	
		function measuredIfComparison() { return
			repeated(100, 								// Hit count 100 => when loading a savefile to another chapter, there's a few 
				isCurrentChapter("Chapter8")			// frames where both these comparisons are true. So this hit counts fixes that	
			) &&										// The no-ancestress route might not spawn the man in this chapter. Other route does, when having talked having told the woman and told her to tell the truth in chapter 7
			isGameRunning() && 	
			!IsViewingCutsceneFromExtraMenu_old()}
		return 
			never(
				!isCurrentChapter("Chapter8")
			) &&
			unless(
				interactionID_1() != 0x08ba3264 	&&		// Block => cutscene when talking to man before experiment
				interactionID_2() != 0x08a335f0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08ba349c 	&&		// Block => cutscene when talking to man after experiment for 2nd time after picking the dialogue option: Lovers never destined to meet  
				interactionID_2() != 0x08a3367c 	&&
				interactionID_3() != 0x198			&&
				onScreenTextID(1) != 0x0048ff81		&&
				onScreenTextID(2) != 0x00480000		&&
				onScreenTextID(3) != 0x0048fffc		&&
				onScreenTextID(4) != 0x00080009		&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple1": function EnigmaticCouple1() {
		// Private functions
		function measuredComparison() { return
			tally(4, [													// 			= 4
				once(interactionID_2() == 0x08a30a94),					// Add hit: +1 	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a30a80),					// Add hit: +1	=> for talking to man 1st time
				once(interactionID_2() == 0x08a30bd4),					// Add hit: +1	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a30be8)					// Add hit: +1	=> for talking to woman 2nd time
			])}
		function measuredIfComparison() { return
			isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() &&
			(
				repeated(100, isCurrentChapter("Prologue")) || 	// Hit count 100 => when loading another save to another chapter, there's a few 
				repeated(100, isCurrentChapter("Chapter1"))		// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
			)}
		// Trigger
		return  
			never(
				!(isCurrentChapter("Prologue") || isCurrentChapter("Chapter1"))
			) &&
			unless(
				interactionID_2() != 0x08a30bd4 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_2() != 0x08a30a80 	&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a30be8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_2() != 0x08a30a94 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple2": function EnigmaticCouple2() { 
		// Private functions
		function measuredComparison() { return
			tally(4, [													// 			= 4
				once(interactionID_2() == 0x08a30ad0),					// Add hit: +1 	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a30abc),					// Add hit: +1	=> for talking to man 1st time
				once(interactionID_2() == 0x08a30c10),					// Add hit: +1	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a30c24)					// Add hit: +1	=> for talking to woman 2nd time
			])}
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && repeated(100, isCurrentChapter("Chapter3"))
		// Trigger
		return  
			never(
				!isCurrentChapter("Chapter3")
			) &&
			unless(
				interactionID_1() != 0x08b994d0 	&&
				interactionID_2() != 0x08a30c10 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b994c4		&&
				interactionID_2() != 0x08a30abc		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b994d0 		&&
				interactionID_2() != 0x08a30c24 		&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57				&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b994c4 		&&
				interactionID_2() != 0x08a30ad0 		&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56				&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple3": function EnigmaticCouple3() {
		// Private functions
		function measuredComparison() { return
			tally(4, [													// 			= 4
				once(interactionID_2() == 0x08a30b0c),					// Add hit: +1 	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a30af8),					// Add hit: +1	=> for talking to man 1st time
				once(interactionID_2() == 0x08a30c10),					// Add hit: +1	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a30c24)					// Add hit: +1	=> for talking to woman 2nd time
			])}
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && repeated(100, isCurrentChapter("Chapter4"))
		// Trigger
		return  
			never(
				!isCurrentChapter("Chapter4")
			) &&
			unless(
				interactionID_1() != 0x08b9dc8c 	&&
				interactionID_2() != 0x08a30c10 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b9dc80		&&
				interactionID_2() != 0x08a30af8		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b9dc8c 		&&
				interactionID_2() != 0x08a30c24 		&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57				&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b9dc80 		&&
				interactionID_2() != 0x08a30b0c 		&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56				&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		// Private functions
		function measuredComparison() { return
			tally(3, [													// 			= 3
				once(interactionID_2() == 0x08a30b5c),					// Add hit: +1	=> for talking to man 1st time
				once(interactionID_2() == 0x08a30b70),					// Add hit: +1 	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a30c9c),					// Add hit: +1	=> for talking to woman 
			])}
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && repeated(100, isCurrentChapter("Chapter5"))
		// Trigger
		return  
			never (
				!isCurrentChapter("Chapter5")
			) &&
			unless(
				interactionID_1() != 0x08b9d400 	&&
				interactionID_2() != 0x08a30c9c 	&&		// Block => cutscene when talking to woman
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b9d3f4		&&
				interactionID_2() != 0x08a30b5c		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b9d3f4 	&&
				interactionID_2() != 0x08a30b70 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple5": function EnigmaticCouple5() {
		// Private functions
		function measuredComparison() { return
			tally(3, [											// 			= 3
				once(interactionID_2() == 0x08a30b34),			// Add hit: +1	=> for talking to man
				once(interactionID_2() == 0x08a30c4c),			// Add hit: +1	=> for talking to woman 1st time
				once(interactionID_2() == 0x08a30c60),			// Add hit: +1	=> for talking to woman 2nd time
			])}
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && repeated(100, isCurrentChapter("Chapter7"))
		// Trigger
		return  
			never (
				!isCurrentChapter("Chapter7")
			) &&
			unless(
				interactionID_1() != 0x08b98db4 	&&
				interactionID_2() != 0x08a30c4c 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b98db4 	&&
				interactionID_2() != 0x08a30c60 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b98da8		&&
				interactionID_2() != 0x08a30b34		&&		// Block => cutscene when talking to man
				interactionID_3() != 0x56			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_BecomeThePerformer": function BecomeThePerformer() {	return
		never(
			!isGameRunning()						||
			IsViewingCutsceneFromExtraMenu_old() 		||
			!isCurrentCutsceneMasterId_0(0x1a300)	||
			isNewCutsceneLoaded()
		) &&
		isCurrentSelectedInventoryItem("Jugglery")	&&
		isCurrentCutsceneMasterId_1(0xd) && isCurrentCutsceneMasterId_2(0xc) &&
		isCutsceneSectionDone()},
	"a_GiveMargaretteCake": function GiveMargaretteCake() { return 
		never(
			!isGameRunning()						||
			IsViewingCutsceneFromExtraMenu_old() 		||
			!isCurrentCutsceneMasterId_0(0x10b000)	||
			isNewCutsceneLoaded()
		) &&
		isCurrentSelectedInventoryItem("Cake")	&&
		isCurrentCutsceneMasterId_1(0x1)	&& isCurrentCutsceneMasterId_2(0x0) &&
		currentCutsceneId(6) == 0x1328e6df 		&& priorCutsceneId(6) == 0x190e1921		&&
		currentCutsceneId(11) == 0x1c2f2ea0 	&& priorCutsceneId(11) == 0xe81c0000	&&
		currentCutsceneId(16) == 0x793ea550 	&& priorCutsceneId(16) == 0xf7cd00		&&
		isCutsceneDone()},
	"a_NewCakeInvented": function NewCakeInvented() { return
		never(
			!isGameRunning()						||
			IsViewingCutsceneFromExtraMenu_old() 		||
			!isCurrentCutsceneMasterId_0(0x1fd80)	||
			isNewCutsceneLoaded()
		) &&
		repeated(100, 	// IDs cutscene, where player gives Cake to Margarette 2nd time
			isCutsceneActive()	&&
			isCurrentSelectedInventoryItem("Cake")	&&
			currentCutsceneId(1) == 0xa2ff43d2 	&& 
			currentCutsceneId(6) == 0x013a1999 	&&
			currentCutsceneId(15) == 0xc341e80a &&
			currentCutsceneId(18) == 0xcedf00ed &&
			currentCutsceneId(19) == 0xfdc96400
		) &&
		isCutsceneDone()},
	"a_MaxInventory": function MaxInventory(){
		function measuredComparison() { 

			// CODE BLOCK A
			// let_comparisonsArray = array_map(_inventoryItems, (item) {	// array_map returns a new array with the comparisons
			// 	let_memAddress = _inventoryItems[item]["inventoryMemoryAddress"]
			// 	return prev(bit0(let_memAddress)) < bit0(let_memAddress)
			// })
			// let_deductComparisonArray = array_map(_inventoryItems, (item) {	// array_map returns a new array with the comparisons
			// 	let_memAddress = _inventoryItems[item]["inventoryMemoryAddress"]
			// 	return deduct(prev(bit0(let_memAddress)) > bit0(let_memAddress))
			// })
			// for deductComparison in let_deductComparisonArray {
			// 	array_push(let_comparisonsArray, deductComparison)
			// }

			// CODE BLOCK B
			let_comparisonsArray = [always_false()]
			for item in _inventoryItems {
				let_memAddress = _inventoryItems[item]["inventoryMemoryAddress"]
				array_push(let_comparisonsArray, deduct(prev(bit0(let_memAddress)) > bit0(let_memAddress))) 	// Sub hit comparison
				array_push(let_comparisonsArray, prev(bit0(let_memAddress)) < bit0(let_memAddress)) 			// Add hit comparison
			}
			return tally(21, let_comparisonsArray) // Biggest achievable inventory = 16 (+ 5 starter items)
		}

		return  // Trigger
			never(
				isAtTitleScreen()					||
				// !isGameRunning()					||	// This comparison bugs this achievement => this flag gets turned on at same time delta comparisons become true, FIX = isAtTitleScreen()
				IsViewingCutsceneFromExtraMenu()					
			) &&
			measured(measuredComparison(), always_true())},
	"a_ArtAppreciator": function ArtAppreciator() {
		// Private functions
		function measuredComparison() { return
			tally(8, [										//			= 8
				once(interactionID_2() == 0x08a321c8),		// Add hit: +1 	=> Town Streets painting (downstairs)
				once(interactionID_2() == 0x08a32204),		// Add hit: +1 	=> Squire's crest painting (upstairs)
				once(interactionID_2() == 0x08a32240),		// Add hit: +1	=> Town planter painting (upstairs)
				once(interactionID_2() == 0x08a3227c),		// Add hit: +1	=> Oddly dressed man painting (upstairs)
				once(interactionID_2() == 0x08a322b8),		// Add hit: +1	=> Alchemist portrait (upstairs)
				once(interactionID_2() == 0x08a322e0),		// Add hit: +1	=> Burning house painting (upstairs)
				once(interactionID_2() == 0x08a3231c),		// Add hit: +1	=> Landscape painting (upstairs)
				once(interactionID_2() == 0x08a32344)		// Add hit: +1	=> Alchemy lab painting (upstairs)
			])}
		function measuredIfComparison() { return
			repeated(100, 									// Hit count 100 => when loading another save to another chapter, there's a few
				isCurrentChapter("Chapter3") || 			// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
				isCurrentChapter("Chapter4") || 
				isCurrentChapter("Chapter5") || 
				isCurrentChapter("Chapter6") || 
				isCurrentChapter("Chapter7") || 
				isCurrentChapter("Chapter8_Ancestress") ||
				isCurrentChapter("Chapter8_NoAncestress")
			) && 
			isGameRunning() &&
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(	// Reset count on chapter change
				hasChapterChanged()
			) &&
			unless(
				interactionID_2() != 0x08a321c8 	&&		// Block => Town Streets painting (downstairs)
				interactionID_3() != 0x163			&&	
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a32204 	&&		// Block => Squire's crest painting (upstairs)
				interactionID_3() != 0x164			&&	
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_2() != 0x08a32240 	&&		// Block => Town planter painting (upstairs)
				interactionID_3() != 0x165			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a3227c 	&&		// Block => Oddly dressed man painting (upstairs)
				interactionID_3() != 0x166			&&
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_2() != 0x08a322b8 	&&		// Block => Alchemist portrait (upstairs)
				interactionID_3() != 0x167			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a322e0 	&&		// Block => Burning house painting (upstairs)
				interactionID_3() != 0x168			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a3231c 	&&		// Block => Landscape painting (upstairs)
				interactionID_3() != 0x169			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_2() != 0x08a32344 	&&		// Block => Alchemy lab painting (upstairs)
				interactionID_3() != 0x16a			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_AntiquesEule": function AntiquesEule() {
		// Private functions
		function measuredComparison() { return
			tally(4, [										//			= 4
				once(interactionID_2() == 0x08a31610),		// Add hit: +1 	=> Festival mask
				once(interactionID_2() == 0x08a315c0),		// Add hit: +1 	=> Old rope
				once(interactionID_2() == 0x08a31638),		// Add hit: +1	=> Old antidote bottle
				once(interactionID_2() == 0x08a315e8)		// Add hit: +1	=> Franssen Shop sign

			])}
		function measuredIfComparison() { return
			isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() &&
			(
				repeated(100, isCurrentChapter("Chapter3")) || 	// Hit count 100 => when loading another save to another chapter, there's a few 
				repeated(100, isCurrentChapter("Chapter4"))	||	// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
				repeated(100, isCurrentChapter("Chapter6"))	|| 
				repeated(100, isCurrentChapter("Chapter7"))
			)}
		// Trigger 
		return 
			never( // Reset count on chapter change
				hasChapterChanged()
			) &&
			unless(
				interactionID_1() != 0x08b99500		&&	// Block => Festival mask
				interactionID_2() != 0x08a31610 	&&
				interactionID_3() != 0xc6			&&	
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b9950c		&&	// Block => Old rope
				interactionID_2() != 0x08a315c0 	&&
				interactionID_3() != 0x98			&&	
				!isCutsceneActive_old()
			) &&
			unless(	
				interactionID_1() != 0x08b994f4		&&	// Block => Old antidote bottle
				interactionID_2() != 0x08a31638 	&&
				interactionID_3() != 0x79			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1() != 0x08b994e8		&&	// Block => Franssen Shop sign
				interactionID_2() != 0x08a315e8 	&&
				interactionID_3() != 0x8e			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_SnowyCrimeScene": function SnowyCrimeScene() {
			function measuredComparison() { return 
				tally(3, [
					once(
						currentCutsceneId(1) == 0x022c00b1	&&  // Block => IDs gunshot cutscene
						currentCutsceneId(3) == 0x00eb7e00 	&&
						currentCutsceneId(16) == 0x25fc4e17 &&
						onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x1e &&
						onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ffd6 &&
						onScreenTextID(2) == 0x0 && prior(onScreenTextID(2)) == 0x4b0000),
					once(
						currentCutsceneId(5) == 0xfb960000 && priorCutsceneId(5) == 0xf470 && // Block => IDs Homonculus taking baby cutscene
						currentCutsceneId(8) == 0xefab005e && priorCutsceneId(8) == 0xf880ebc7 && 
						currentCutsceneId(20) == 0x14060000 && priorCutsceneId(20) == 0xf5411111 &&
						onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x1e &&
						onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48fff0),
					once(
						onScreenTextID(0) == 0x2d && prior(onScreenTextID(0)) == 0x1e 		&& // Block => IDs Miriam dying cutscene
						onScreenTextID(1) == 0x48ffbf && prior(onScreenTextID(1)) == 0x0 	&&
						onScreenTextID(3) == 0x480033 && prior(onScreenTextID(3)) == 0x0	&&
						onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80005 	&&
						onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x50003d)
				])}
			function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && isCurrentChapter("Chapter6")
			return 
				unless(!isCutsceneActive_old()) &&
				measured(measuredComparison(), measuredIfComparison())
		},
	"a_SaveMiriamBrum": function SaveMiriamBrum() { 
		function measuredComparison() { return
			tally(4, [
				once(
					currentCutsceneId(23) == 0x46464952 && priorCutsceneId(23) == 0x1a1c5339	&&	// Block => IDs cutscene where Eike is accused by the bystanders for killing Miriam, after trying to save her the 1st time
					currentCutsceneId(24) == 0x9fc50363 && priorCutsceneId(24) == 0x1192c330 	&&	
					currentCutsceneId(25) == 0x6175bab4 && priorCutsceneId(25) == 0x4464c78f	&&
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x5a 		&&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ffd2	&&
					onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x50ffb8),
				once(
					currentCutsceneId(23) == 0x6aee6439 && priorCutsceneId(23) == 0x90c46c39	&&	// Block => IDs cutscene where Eike save Miriam succesfully after chasing her around
					currentCutsceneId(24) == 0x3ea588a9 && priorCutsceneId(24) == 0x5bca2a9c 	&&	
					currentCutsceneId(25) == 0x74bd8160 && priorCutsceneId(25) == 0xf879a12a	&&
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x3c 		&&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ffec	&&
					onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x50ffc5),
				once(
					currentCutsceneId(23) == 0x46464952 &&	// Block => IDs cutscene 1st time talking to Brum couple after saving Miriam 
					currentCutsceneId(24) == 0x6390d3ae && 	
					currentCutsceneId(25) == 0xfc1a045a && 
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x87 	&&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ffc7	&&
					onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x8000a),
				once(
					currentCutsceneId(1) == 0x6b801111 &&	// Block => IDs cutscene 2nd time talking to Brum couple after saving Miriam 
					currentCutsceneId(8) == 0x099bf650 && 	
					currentCutsceneId(16) == 0x523f2331 && 
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0xbe 		&&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff93	&&
					onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x50ffde),
			])}
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu_old() && isCurrentChapter("Chapter6")
		return 
			unless(!isCutsceneActive_old()) &&
			measured(measuredComparison(), measuredIfComparison())
		},
	"a_HugoMotherChild": function HugoMotherChild() { return
		never(
			!isGameRunning() 					|| 
			!isCutsceneActive_old() 				|| 
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCurrentChapter("Chapter5")	
		) && 
		tally (290, [
			repeated(70,
				onScreenTextID(0) == 0x52 && prior(onScreenTextID(0)) == 0x79 				&&
				currentCutsceneId(8) == 0x00001111 && priorCutsceneId(8) == 0xe6df0168 		&&
				currentCutsceneId(16) == 0xb12cbb1a && priorCutsceneId(16) == 0x20ecffc5 	&&
				currentCutsceneId(22) == 0xcd59d6c4 && priorCutsceneId(22) == 0x1100101c),
			repeated(150,
				onScreenTextID(0) == 0x87 && prior(onScreenTextID(0)) == 0x32 				&&
				currentCutsceneId(5) == 0x00c10008 && priorCutsceneId(5) == 0xff1dfc57 		&&
				currentCutsceneId(13) == 0x00000485 && priorCutsceneId(13) == 0x2188319e 	&&
				currentCutsceneId(17) == 0x061d045c && priorCutsceneId(17) == 0xe6dfe0c3),
			repeated(70,
				onScreenTextID(0) == 0x50 && prior(onScreenTextID(0)) == 0x59 				&&
				currentCutsceneId(8) == 0xf71e0000 && priorCutsceneId(8) == 0x5d5ec415 		&&
				currentCutsceneId(11) == 0x30300678 && priorCutsceneId(11) == 0x1921	 	&&
				currentCutsceneId(22) == 0x9d818991 && priorCutsceneId(22) == 0x28024500)]
		) &&
		onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x26},
 	"a_TimeTravellingCat": function TimeTravellingCat() { return
		never(
			!isGameRunning() || !isCutsceneActive_old() || IsViewingCutsceneFromExtraMenu_old() || 
			!isCurrentChapter("Chapter4") && !isCurrentChapter("Chapter5") && 
			!isCurrentChapter("Chapter6") && !isCurrentChapter("Chapter7") &&
			!isCurrentChapter("Chapter8_Ancestress") && !isCurrentChapter("Chapter8_NoAncestress")
		) &&
		tally(2, [
			once(
				currentCutsceneId(4) == 0xff4700a3 	&& priorCutsceneId(4) == 0x77 			&& // Blocks => IDs the cutscenes
				currentCutsceneId(20) == 0x2622fab8 && priorCutsceneId(20) == 0xf9c20180	&&
				currentCutsceneId(14) == 0xc4a7d2c5 && priorCutsceneId(14) == 0x5cb			&&
				onScreenTextID(0) == 0x37			&& prior(onScreenTextID(0)) == 0x4c),
			once(
				currentCutsceneId(7) == 0x88880011 	&& priorCutsceneId(7) == 0x71 			&&
				currentCutsceneId(17) == 0xf6e1fffe && priorCutsceneId(17) == 0x473d4f		&&
				currentCutsceneId(11) == 0xff4fffec && priorCutsceneId(11) == 0xfd640278	&&
				onScreenTextID(0) == 0x4c			&& prior(onScreenTextID(0)) == 0x73),		
		]) && 
		repeated(160, onScreenTextID(0) == 0x0)}, // trigger when last text in cutscene is finished
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!isGameRunning()					||
			!isCurrentChapter("Prologue") 		||
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCutsceneActive_old())				&&
		repeated(1050, prior(currentCutsceneId(22)) == 0x4b07ccd5) 	&&	// This block => last cutscene has run for about 1070 frames
		repeated(1050, prior(currentCutsceneId(3)) == 0xe000b600) 	&&
		repeated(1050, prior(currentCutsceneId(9)) == 0xa0e6e5ff) 	&&
		repeated(1050, currentCutsceneId(22) == 0x52036400) 			&&
		repeated(1050, currentCutsceneId(3) == 0x47f45022) 			&&
		repeated(1050, currentCutsceneId(9) == 0x5ffe5fe9)},	
	"a_ErasingEike2": function ErasingEike2() { return
		never(
			!isGameRunning()					||
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCurrentChapter("Chapter7") 		||
			!isCutsceneActive_old()
		) &&
		repeated(550, 
			currentCutsceneId(1) == 0x00b60000 	&& // Block => IDs cutscene where Eike runs into himself
			currentCutsceneId(5) == 0x02af0000 	&&
			currentCutsceneId(13) == 0x0000cfea &&
			currentCutsceneId(15) == 0xfff90000 &&
			currentCutsceneId(21) == 0x0053ffc7)},
	"a_RottenRope": function RottenRope() { return
		never(
			!isGameRunning() 					|| 
			!isCutsceneActive_old() 				|| 
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCurrentChapter("Chapter7")
		) &&
		tally(4, [
			once(
				currentCutsceneId(8)== 0xff8f301a && priorCutsceneId(8) == 0xd4b3e6df &&
				currentCutsceneId(15)== 0x54f0006d && priorCutsceneId(15) == 0x7d80000 &&
				currentCutsceneId(22)== 0x68ee2219 && priorCutsceneId(22) == 0x241932cd),
			once(
				currentCutsceneId(12)== 0x000b5eda && priorCutsceneId(12) == 0x2e500af &&
				currentCutsceneId(16)== 0x00099806 && priorCutsceneId(16) == 0x88888888 &&
				currentCutsceneId(19)== 0xf3fffa00 && priorCutsceneId(19) == 0x88898888),
			once(
				currentCutsceneId(14)== 0xfff6c7e0 && priorCutsceneId(14) == 0xababc504 &&
				currentCutsceneId(15)== 0x07070019 && priorCutsceneId(15) == 0x6e60655 &&
				currentCutsceneId(18)== 0x00880368 && priorCutsceneId(18) == 0x98889890),
			once(
				currentCutsceneId(14)== 0x023700b0 && priorCutsceneId(14) == 0xff1d1931 &&
				currentCutsceneId(17)== 0x08f91635 && priorCutsceneId(17) == 0x1160fccc &&
				currentCutsceneId(19)== 0x4306d244 && priorCutsceneId(19) == 0x19049404)
		])},
	"a_TimeEgoFlop": function TimeEgoFlop() { return 
		never(
			!isGameRunning() 					||
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCurrentChapter("Chapter6")
		) &&
		once(
			isWorldConquestPicked() &&
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x4b 		&& 		// Block => IDs Time Ego choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x0040ff68 	&&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x40ffe0 	&&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4fffad
		) && 
		trigger_when(
			tally(200, 
					currentCutsceneId(6) == 0xff530209 	&& priorCutsceneId(6) == 0xff5af64e 	&& // Block => IDs cutscene with 'World Conquest' movie poster
					currentCutsceneId(16) == 0x10e00 	&& priorCutsceneId(16) == 0xc3000000 	&& 
					currentCutsceneId(14) == 0x002de210 && priorCutsceneId(14) == 0xffa1 		&&
					onScreenTextID(0) == 0x32 && prior(onScreenTextID(0)) == 0x80
			) &&
			isCutsceneSectionDone()
		)},
	"a_MetYouBefore": function MetYouBefore() { return
		never(
			!isGameRunning() 						||
			!isCurrentChapter("Chapter2")			||
			IsViewingCutsceneFromExtraMenu_old()		||
			!isCurrentCutsceneMasterId_0(0x6e480)	||
			isNewCutsceneLoaded()
		) &&
		isCurrentCutsceneMasterId_1(0x1) 				&&
		isCurrentCutsceneMasterId_2(0x2)				&&
		repeated(500, isCutsceneActive() 		&& onScreenTextID(0) == 0x4b)	&&
		once(prev(onScreenTextID(0)) == 0x4b 	&& onScreenTextID(0) == 0x2d) 	&&	// Text sequence A
		once(prev(onScreenTextID(0)) == 0x2d 	&& onScreenTextID(0) == 0x1e) 	&&	// Text sequence B
		once(prev(onScreenTextID(0)) == 0xf0 	&& onScreenTextID(0) == 0x78) 	&&	// Text sequence C
		once(prev(onScreenTextID(0)) == 0x78 	&& onScreenTextID(0) == 0x4b) 	&&	// Text sequence E
		once(prev(onScreenTextID(0)) == 0xb4 	&& onScreenTextID(0) == 0x4b) 	&&	// Text sequence D
		once(prev(onScreenTextID(0)) == 0x78 	&& onScreenTextID(0) == 0x50) 	&&	// Text sequence F
		once(prev(onScreenTextID(1)) == 0x0 	&& onScreenTextID(1) == 0x0040ff86) &&	// Text A
		once(prev(onScreenTextID(5)) == 0x0 	&& onScreenTextID(5) == 0x0050ffd0) &&	// Text A
		once(prev(onScreenTextID(1)) == 0x0 	&& onScreenTextID(1) == 0x0048ffc9) &&	// Text B
		once(prev(onScreenTextID(3)) == 0x0 	&& onScreenTextID(3) == 0x00480029) &&	// Text B
		once(prev(onScreenTextID(1)) == 0x0 	&& onScreenTextID(1) == 0x0040ff9e) &&	// Text E
		once(prev(onScreenTextID(4)) == 0x0 	&& onScreenTextID(4) == 0x00080009)	&&	// Text E
		isCutsceneSectionDone()},
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return
		never(
			!isGameRunning() 					||
			IsViewingCutsceneFromExtraMenu_old() 	|| 
			!isCurrentChapter("Chapter3")
		) &&
		tally(2,
			once(	// +1 when "excuse me" option is chosen
				isCutsceneActive()	&&
				isCurrentCutsceneMasterId_0(0xb140)	&&	// Block => IDs cutscene after picking "excuse me"
				isCurrentCutsceneMasterId_1(0x5)	&&
				isCurrentCutsceneMasterId_2(0x6)	&&
				currentCutsceneId(14) == 0x1967e97c && priorCutsceneId(14) == 0x1547049b 	&& 
				currentCutsceneId(19) == 0x1a192200 && priorCutsceneId(19) == 0xafd		 	&&
				currentCutsceneId(22) == 0x29111111 && priorCutsceneId(22) == 0xd5007ed3 	&&
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ffe4 && // Block => true when picked "excuse me"
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x3f0017 &&
				onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x510025),
			once(	// +1 when cutscene in limbo finishes
				isCutsceneActive()	&&
				isCurrentCutsceneMasterId_0(0x1a440)	&&	// Block => IDs cutscene in limbo after death
				isCurrentCutsceneMasterId_1(0x1)		&&
				isCurrentCutsceneMasterId_2(0x0)		&&
				currentCutsceneId(5) == 0xd0161111 	&& priorCutsceneId(5) == 0x19dfd71f && 
				currentCutsceneId(8) == 0x3e82c254 	&& priorCutsceneId(8) == 0xfd5df960 &&
				currentCutsceneId(11) == 0x02acfd43 && priorCutsceneId(11) == 0x6c6ffa5 &&
				onScreenTextID(0) == 0x69 && prior(onScreenTextID(0)) == 0xaf 		&&	// Block => true when cutscene dialogue in limbo finishes 
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff89 	&& 
				onScreenTextID(2) == 0x0 && prior(onScreenTextID(2)) == 0x440000 	&&
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x41fff6)
		) &&
		isCutsceneSectionDone()}
	// "a_Template": function Template() {},
}


// ACHIEVEMENT TITLES & DESCRIPTIONS
// ***********************************************************************************
_achievementTitles = {
	"a_PrologueComplete": 							{"en": "Defied Fate",															
													"nl": "Lot getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1Complete": 							{"en": "Defied Fate... Again",															
													"nl": "Lot getrotseerd... nogmaals",
													"fr": "Défié le destin... encore"},
	"a_Chapter2Complete": 							{"en": "Left in the Past"},
	"a_Chapter3Complete": 							{"en": "An Alchemist, a Jewel and a Homunculus"},
	"a_Chapter4CompletePan": 						{"en": "Pan-tastic Resilience"},
	"a_Chapter4CompleteSign": 						{"en": "Through the Lens of Survival"},	
	"a_Chapter5Complete": 							{"en": "Ancient Elixir"}, 
	"a_Chapter6CompleteThriller":					{"en": "Director's Cut: The Time of Reckoning"},
	"a_Chapter6CompleteLove":						{"en": "Director's Cut: Trip for Two"},
	"a_Chapter7Complete":							{"en": "A Friend's Repentance"},
	"a_Chapter8Complete":							{"en": "The Whole Picture... Or is it?"},
	"a_EndingA":									{"en": "An End to a Strange Experience"},
	"a_EndingB1":									{"en": "No Sense of Finality I"},
	"a_EndingB2":									{"en": "No Sense of Finality II"},
	"a_EndingC": 									{"en": "'If only... I had one more attempt'"},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "'The future is what we make it.'"},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_DoctorateTimeTraveling": 					{"en": "Complexities of the Fourth Dimension"}, 
	"a_GetOrnamentalEgg": 							{"en": "A Performer's Clue"}, 
	"a_EggCollection1": 							{"en": "A Jovial Exchange I"},
	"a_EggCollection2": 							{"en": "A Jovial Exchange II"}, 
	"a_BarmansChildren":							{"en": "The Barman's Grandchildren and The Mystery Child"},
	"a_IntroduceEggCollecting": 					{"en": "Cracking Open the Past: Middle Ages"},
	"a_IntroduceEggCollecting2": 					{"en": "Cracking Open the Past: The Old Century"},
	"a_PocketWatchCollection": 						{"en": "A Hatchless Replica"},
	"a_PocketWatchReminiscing": 					{"en": "The Eggcellent Director's Tale"},
	"a_EikeThePyromancer":							{"en": "The Pyromancer's Legacy"},
	"a_EikeTheMagician": 							{"en": "The Magician's Legacy"},
	"a_EikeTheFlorist": 							{"en": "A Blossoming Plan"},
	"a_LostYoungCouple1": 							{"en": "Yesteryears Couple I: Destined to Miss"},
	"a_LostYoungCouple2": 							{"en": "Yesteryears Couple II: The Place Where We Nigh Met"},
	"a_LostYoungCouple3": 							{"en": "Yesteryears Couple III: Destiny's Promise Fulfilled"},
	"a_LostYoungCouple4": 							{"en": "Yesteryears Couple IV: Parting"},
	"a_LostYoungCouple5": 							{"en": "Yesteryears Couple V: Man-in-waiting"},
	"a_LostYoungCouple6": 							{"en": "Yesteryears Couple VI: Never Destined to Meet"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic Couple I: Prelude"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic Couple II: Shadowing or Lost?"}, 
	"a_EnigmaticCouple3": 							{"en": "Enigmatic Couple III: Wandering Once More"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic Couple IV: Origins"},	
	"a_EnigmaticCouple5": 							{"en": "Enigmatic Couple V: Epilogue"},
	"a_ErasingEike": 								{"en": "'That's a big no no'"}, 
	"a_ErasingEike2": 								{"en": "Bump... Erased"},
	"a_RottenRope": 								{"en": "Fated to Plunge"},
	"a_MetYouBefore": 								{"en": "Met me before"},
	"a_TimeTravellingCat":							{"en": "Nine Lives across Generations"},
	"a_SnowyCrimeScene":							{"en": "'Picked up a baby the other day'"},
	"a_SaveMiriamBrum":								{"en": "Illusive Guardian of the Brums"},
	"a_HugoMotherChild":							{"en": "A Mother's Child Forever"}, 
	"a_TimeEgoFlop":								{"en": "Time Ego Flop"},
	"a_ArtAppreciator": 							{"en": "Strokes of Destiny"}, 
	"a_AntiquesEule": 								{"en": "Timeless Antiques"},
	"a_ExcuseMeMyMy":								{"en": "'My my, so eager to die'"},
	"a_BecomeThePerformer":							{"en": "'Even I can do that'"}, 
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Energy Amasser: Present Day"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Energy Amasser: Middle Ages"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Energy Amasser: 70's - 80's"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Amasser: The Old Century"},
	"a_GiveMargaretteCake": 						{"en": "Time-Spun Sweets"}, 
	"a_NewCakeInvented": 							{"en": "Legacy of Sweetness"},
	"a_MaxInventory": 								{"en": "Stockpiling Across Eras"}
	// "a_Template": 			{"en": "xxxxx"}, 
}
_achievementDescriptions = {
	"a_PrologueComplete": {							"en": "Complete the Prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Complete Chapter 1",
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},													
	"a_Chapter2Complete": 							{"en": "Complete Chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete Chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete Chapter 4, using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete Chapter 4, using a sign"},	
	"a_Chapter5Complete": 							{"en": "Complete Chapter 5"}, 
	"a_Chapter6CompleteThriller":					{"en": "Complete Chapter 6, by co-directing a thriller picture"},
	"a_Chapter6CompleteLove":						{"en": "Complete Chapter 6, by co-directing a love picture"},
	"a_Chapter7Complete":							{"en": "Complete Chapter 7"},
	"a_MeetOldMiriam":								{"en": "Complete Chapter 7, whilst having saved a member of the Brum family in Chapter 6"},
	"a_Chapter8Complete":							{"en": "Complete Chapter 8"},
	"a_EndingA":									{"en": "Achieve Ending A"},
	"a_EndingB1":									{"en": "Achieve Ending B1"},
	"a_EndingB2":									{"en": "Achieve Ending B2"},
	"a_EndingC": 									{"en": "Achieve Ending C"},
	"a_EndingD": 									{"en": "Achieve Ending D"},
	"a_EndingE": 									{"en": "Achieve Ending E"},
	"a_DoctorateTimeTraveling": 					{"en": "Take a picture in a costume during chapter 4 and finish the chapter"}, 
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from a performer during chapter 1"},
	"a_IntroduceEggCollecting": 					{"en": "Show off your egg collection to the barman's ancestor during chapter 2"},
	"a_IntroduceEggCollecting2": 					{"en": "Show off your egg collection to the barman's ancestor from chapter 6 onward"},
	"a_BarmansChildren":							{"en": "Discover the truth about the barman's grandchildren during chapter 5"},
	"a_PocketWatchCollection": 						{"en": "Show off your egg collection to the barman during chapter 7"},
	"a_PocketWatchReminiscing": 					{"en": "Reminisce about your egg collection with Eckart during chapter 8"},
	"a_EggCollection1": 							{"en": "Give an ornamental egg to a barman during chapter 1"},
	"a_EggCollection2": 							{"en": "Give an ornamental egg to a barman during chapter 3 or 4"},
	"a_EikeThePyromancer": 							{"en": "Become honored as a pyrokinetic during chapter 2"},
	"a_EikeTheMagician": 							{"en": "Become honored as a magician during chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Planted flowers during chapter 2"},
	"a_LostYoungCouple1": 							{"en": "Help a lost young couple reunite in The Middle Ages during chapter 2"}, 
	"a_LostYoungCouple2": 							{"en": "Help a lost young couple reunite again in The Middle Ages during chapter 3"},
	"a_LostYoungCouple3": 							{"en": "Reunite the lost young couple in The Middle Ages during chapter 4"},
	"a_LostYoungCouple4": 							{"en": "Consult the young man in The Middle Ages during chapter 5"},
	"a_LostYoungCouple5": 							{"en": "Consult the young couple in The Middle Ages during chapter 7"},
	"a_LostYoungCouple6": 							{"en": "Advise the young man in The Middle Ages during chapter 8"},
	"a_EnigmaticCouple1": 							{"en": "Find the coated man and woman in the present during the prologue or chapter 1"}, 
	"a_EnigmaticCouple2": 							{"en": "Find the coated man and woman in the present during chapter 3"}, 
	"a_EnigmaticCouple3": 							{"en": "Find the coated man and woman in the present during chapter 4"}, 
	"a_EnigmaticCouple4": 							{"en": "Find the coated man and woman in the present during chapter 5"},	
	"a_EnigmaticCouple5": 							{"en": "Find the coated man and woman in the present during chapter 7"},
	"a_ErasingEike": 								{"en": "Warn yourself of your impending demise during the prologue"},
	"a_ErasingEike2": 								{"en": "Run into yourself during chapter 7"}, 
	"a_RottenRope": 								{"en": "Use an aged cable to save yourself in chapter 7"},
	"a_MetYouBefore": 								{"en": "Keep chatting with Dana at the Marktplatz tree during chapter 2"},
	"a_TimeTravellingCat":							{"en": "Gift a feline to a girl during or after chapter 4"},
	"a_HugoMotherChild":							{"en": "Find Hugo during chapter 5"}, 
	"a_ArtAppreciator": 							{"en": "Admire all the paintings in the Brum Museum"},
	"a_AntiquesEule": 								{"en": "Visit Antique Shop Eule and glance at the original relics"},
	"a_ExcuseMeMyMy":								{"en": "Run from the apparition during chapter 3"}, 
	"a_BecomeThePerformer":							{"en": "Become a performer during chapter 4"}, 
	"a_SnowyCrimeScene":							{"en": "Uncover a snowy crime scene during chapter 6"},
	"a_SaveMiriamBrum":								{"en": "Save a member of the Brum family from a predestined death during chapter 6"}, 
	"a_TimeEgoFlop":								{"en": "View every possible movie poster during chapter 6"},
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Collect all 5 energy orbs in present day Lebensbaum"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Collect all 5 energy orbs in medieval Lebensbaum"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Collect all 5 energy orbs in Lebensbaum during the 70's or 80's"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Collect all 5 energy orbs in Lebensbaum, a century ago"},
	"a_GiveMargaretteCake": 						{"en": "Gift a tasty sweet to a someone dear to you"}, 
	"a_NewCakeInvented": 							{"en": "Establish a new type of pastry"},
	"a_MaxInventory": 								{"en": "Acquire the biggest hoard of items in a single playthrough"}
	// "a_Template": 			{"en": "xxxxx"},
}

// ACHIEVEMENT INITIALIZER
//	- Creates achievements based on achievement dictionary
// *************************************************************
function initializeAchievements() {
	// Generates the achievement title (with developer tags, if devmode == 1)
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function enterCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if isDevModeActive() {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)
				let_string = format("[{0}_{1}]", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
				// let_string + "[" + let_shortenedAchievementCategory + "_" + let_shortenedAchievementDevName + "] " 
			}
			return let_string
		}	
		function lookUpAchievementTitle(string_achievementDevName, string_languageCode) {
			return _achievementTitles[string_achievementDevName][string_languageCode]
		}
		return enterCategoryName(string_achievementCategory, string_achievementDevName) + lookUpAchievementTitle(string_achievementDevName, string_languageCode)
	}
	// Generates the achievement description (with extra developer information, if devmode == 1)
	function generateAchievementDescription(string_achievementDevName, boolean_hasTips, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementDevName, string_languageCode) {
			return _achievementDescriptions[string_achievementDevName][string_languageCode]
		}
		function enterDevInfo(string_devInfo) {
			let_devInfoString = ""
			if isDevModeActive() && string_devInfo != "" {
				let_devInfoString = let_devInfoString + " - [DEV: " + string_devInfo + "]"
			}
			return let_devInfoString
		}	
		function enterTipsLink(boolean_hasTips) {
			let_tipsLink = ""
			if(boolean_hasTips == true) let_tipsLink = " - [Tips: " + achievementGuideLink + "]"
			return let_tipsLink 
		}
		return lookUpAchievementDescription(string_achievementDevName, string_languageCode) + enterTipsLink(boolean_hasTips) + enterDevInfo(string_devInfo) 
	}
	// Returns the achievement trigger 
	function lookUpAchievementTrigger(string_achievementDevName) {
		return _achievementTriggers[string_achievementDevName]
	}

	// This loop generates the achievements
	for categoryName in _achievements {
		for cheevmentName in _achievements[categoryName] {
			let_cheevment = _achievements[categoryName][cheevmentName]
			achievement(
				id = let_cheevment["id"],
				title = generateAchievementTitle(cheevmentName, categoryName, achievementLanguage), 
				description = generateAchievementDescription(cheevmentName, let_cheevment["hasTips"], let_cheevment["devInfo"], achievementLanguage),
				points = let_cheevment["points"],
				trigger = lookUpAchievementTrigger(cheevmentName)
			)
		}
	}
}


//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //  //  RICH PRESENCE  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\


//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //   INITIALIZATION CODE   \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\
function initializeRAscript() {
	initializeAchievements()
}
initializeRAscript()