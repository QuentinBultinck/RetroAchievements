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

// CUTSCENES
// ***********
//	- Everytime you view a different cutscene, memory values around these IDs/addresses change
//	- Each unique cutscene seems to have different values => might correlate to animation, camera or model data
//	- During cutscenes the values may change
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
_inventoryItemIds = { 
	"D-pad": 0x0, // In PSP version this is called Z-Pad
	"OrnamentalEgg": 0x2,
	"Cellphone": 0x1,
	"FryingPan": 0x4,
	"Sign": 0x5,
	"Lighter": 0x6,
	"SquireCrest": 0xf,
	"Antidote": 0x11
}
function currentSelectedItemID() => byte(0xA9F111)			// $A9F111: [8-bit] Currently selected item ID in inventory
function isCurrentSelectedInventoryItem(string_item) => currentSelectedItemID() == _inventoryItemIds[string_item]

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
function IsViewingEndingFromExtraMenu() { return				// $AC3170: [32-bit] Pointer
	 dword(dword(0xAC3170) + 0xF8000004) & 0x1FFFFFF == 0x1}	// 	+0xF8000004 = Selected menu item in Extra Menu
																	// 		- 0x0 => Event viewer (replay unlocked cutscenes)
																	// 		- 0x1 => Ending files (replay ending cutscenes)
																	// 		- 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
																	// 		- 0x3 => Sound Mode (Play sound effects & music)
																	// 		- 0x4 => Exit (back to Title Screen)
function IsViewingCutsceneFromExtraMenu() => dword(0x1FFF15C) == 0x1	// $1FFF15C: [32-bit] Flag => is viewing cutscene from event viewer
																		// 	- 0x1 = event viewer is active
																		// 	- other values = event viewer is inactive
																		

// OTHER LOGIC
// *************
function energyUnitsZPad() => byte(0xA9DAA8)	// $A9DAA8: Number of energy units in possession 
												//		- Used for the time travel machine (Z-Pad)
												//		- Min => 0x0 		Max => 0x0a
function isCutsceneActive() => bit0(0xA9Eb2C) == 0	// $A9Eb2C: [bit-0] Flag -> is cutscene active
													//		- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
													//		- 1 = no cutscene active
function isGameRunning() => bit0(0xA9F034) == 1	// $A9F034: [bit-0] Flag -> is game running
												//		- 0 = game is not running, it's in the title screen
												//		- 1 = game is running




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
		"a_PrologueComplete": { // WORKING
			"id": 306884, "points": 5, "hasTips": false,
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // WORKING
			"id": 306886, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // WORKING
			"id": 306922, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 2"},
		"a_Chapter3Complete": { // WORKING
			"id": 306921, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 3"},
		"a_Chapter4CompletePan": { // WORKING
			"id": 308964, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a frying pan"},
		"a_Chapter4CompleteSign": { // WORKING
			"id": 310149, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign"},
		"a_Chapter5Complete": { // WORKING
			"id": 311616, "points": 10, "hasTips": false,
			"devInfo": "Complete chapter 5"},
		"a_Chapter6CompleteThriller": { // WORKING
			"id": 313211, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a thriller movie"},
		"a_Chapter6CompleteLove": { // WORKING
			"id": 313210, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a love movie"},
		"a_Chapter7Complete": { // WORKING
			"id": 315565, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 7"},
		"a_Chapter8Complete": { // WORKING 
			"id": 315571, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 8"},
		// TODO "a_EpilogueComplete": { // TODO check if this is double with endings
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Complete the epilogue"}, 
		// TODO "a_EXChapterComplete": {
		//	"id": 000000, "points": 50, "hasTips": false,
		// 	"devInfo": "Complete the EX chapter"},
		// TODO "a_Achieve100%Achievement": { // TODO check if this is possible to implement as achievement
		//	"id": 000000, "points": 100, "hasTips": false,
		// 	"devInfo": "Seen ALL the cutscenes, should be saved in the MAIN safe file of the game"},
	},
	"c_Branch": { // Category - Branching path
		"a_GetOrnamentalEgg": { // WORKING
			"id": 306885, "points": 5, "hasTips": true,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."},
		// TODO "a_BecomeThePerformer": { // CONCEPT also finish chapter 4 when this is achieved => chapter 4 ending cutscene might have has extra stuff
		// 	"id": 00000, "points": 5, "hasTips": true,
		// 	"devInfo": "In chapter4, use the costume to give yourself a message"},
		"a_EggCollection1": { // WORKING
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
			"devInfo": "Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart => give kitten before chapter 7"},		
		"a_DoctorateTimeTraveling": { // WORKING
			"id": 310163, "points": 10, "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign OR frying pan AND taken the picture as the white dressed man"},
		"a_IntroduceEggCollecting": { // WORKING
			"id": 307023, "points": 5, "hasTips": true,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_EikeThePyromancer": { // WORKING
			"id": 306911, "points": 3, "hasTips": true,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // WORKING	
			"id": 306906, "points": 3, "hasTips": true,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_EikeTheFlorist": { // WORKING 
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
		// TODO "a_NewCakeInvention???": { 
		//	"id": 000000, "points": 0000000, "hasTips": false,
		//	"devInfo": "Take the cake => give it to margarete => name of cake is now margarete"}, 		
		"a_IntroduceEggCollecting2": { // WORKING
			"id": 313213, "points": 5, "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward"},
		"a_PocketWatchCollection": { // WORKING
			"id": 315561, "points": 5, "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7"},
		"a_PocketWatchReminiscing": { // WORKING
			"id": 315562, "points": 5, "hasTips": true,
			"devInfo": "Talk to Eckart with the pocket watch in your inventory during chapter 8"},
		"a_BarmansChildren": { // WORKING
			"id": 315567, "points": 5, "hasTips": true,
			"devInfo": "Uncover the truth about the barman's children and the mystery child during chapter 5"},
	},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to PC dying or game over screen
		"a_MetYouBefore": {  // WORKING
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
		"a_ExcuseMeMyMy": { // WORKING 
			"id": 306919, "points": 1, "hasTips": true,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
		"a_TimeEgoFlop": { // WORKING 
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
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		(
			( 		// Alt 1 => true when last prologue cutscene finishes (has been running for 2010+ frames)
				unless(!isCurrentChapter("Prologue")) 					&&
				repeated(2010, priorCutsceneId(16) == 0x43c58c5a) 		&&
				repeated(2010, priorCutsceneId(18) == 0xc58acc94) 		&& 
				repeated(2010, priorCutsceneId(19) == 0x220000ec) 		&&
				repeated(2010, currentCutsceneId(16) == 0xd7e805ff) 	&&
				repeated(2010, currentCutsceneId(18) == 0xcedfff04) 	&&
				repeated(2010, currentCutsceneId(19) == 0x4a007500)					
			) || ( 	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Prologue")
			)
		)},
	"a_Chapter1Complete": function Chapter1Complete() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		( 	
			( 		// Alt 1 => true when last chapter cutscene finishes (has been running for 610+ frames)
				unless(!isCurrentChapter("Chapter1")) 				&&
				repeated(610, priorCutsceneId(14) == 0x50ff199a) 	&& 
				repeated(610, priorCutsceneId(15) == 0x41354bf6) 	&&				
				repeated(610, priorCutsceneId(17) == 0x5e0000) 		&&
				repeated(610, currentCutsceneId(14) == 0xae99999) 	&&				
				repeated(610, currentCutsceneId(15) == 0x168e7af) 	&&				
				repeated(610, currentCutsceneId(17) == 0x800108) 
			) || ( 	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter1")
			)
		)},
	"a_Chapter2Complete": function Chapter2Complete() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		(
			( 		// Alt 1 => true when last chapter cutscene is active AND oneFrameTimerHasReset 3 times
				unless(
					!isCurrentChapter("Chapter2") || 
					(
						currentCutsceneId(2) != 0x479ff42 		&&
						currentCutsceneId(20) != 0xf372f766 	&&
						currentCutsceneId(21) != 0x2ea0e6e5
					)
				) && 
				repeated(3, hasOneFrameTimerReset()) // Unlock achievement when cutscene is done => oneFrameTimerHasReset 3 times
			) || ( 	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter2")
			)
		)},
	"a_Chapter3Complete": function Chapter3Complete() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		( 	
			( 		// Alt 1 => true when last chapter cutscene finishes
				unless(!isCurrentChapter("Chapter3")) &&
				tally(3, [
					once(	// Block A => IDs 1st cutscene sequence 
						currentCutsceneId(1) == 0xd88c0086 	&& 
						currentCutsceneId(6) == 0xfe4d2e91 	&&
						currentCutsceneId(14) == 0x01bd0079),	
					once(	// Block B => IDs 2nd cutscene sequence 
						currentCutsceneId(3) == 0x11101119	&& 
						currentCutsceneId(11) == 0x17f8e6df	&&
						currentCutsceneId(18) == 0x011bfc57),
					once(	// Block C => IDs 3rd cutscene sequence 
						currentCutsceneId(2) == 0x0098fe51 	&& 
						currentCutsceneId(9) == 0xf2e68100 	&&
						currentCutsceneId(19) == 0x00012000)]) 	&&
				tally(2160, [
					repeated(720, currentCutsceneId(12) == 0xffcd0467 && priorCutsceneId(12) == 0xfd08c001), 
					repeated(720, currentCutsceneId(15) == 0xfcff142d && priorCutsceneId(15) == 0xe6c5), 
					repeated(720, currentCutsceneId(18) == 0x19191920 && priorCutsceneId(18) == 0x44607539), 
				])
			) || ( 	// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				isChapterFinished("Chapter3")
			)
		)},
	"a_Chapter4CompletePan": function Chapter4CompletePan() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		isCurrentSelectedInventoryItem("FryingPan") && isChapterFinished("Chapter4")
		// ( 	
		// 	( 		// Alt 1 => IDs last chapter cutscene while using the frying pan WITHOUT taking the picture 
		// 		unless(!isCurrentChapter("Chapter4")) &&
		// 		tally(3, [
		// 			once(currentCutsceneId(2) == 0xf5e5191f),
		// 			once(currentCutsceneId(6) == 0x08b20921),
		// 			once(currentCutsceneId(11) == 0xec2328a8)
		// 		]) && 
		// 		onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x55 && 
		// 		onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80008 && 
		// 		onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x500003	
		// 	) || (	// Alt 2 => IDs last chapter cutscene while using the frying pan AND taking the picture 
		// 		unless(!isCurrentChapter("Chapter4")) &&
		// 		tally(3, [
		// 			once(currentCutsceneId(7) == 0x0c111863),
		// 			once(currentCutsceneId(9) == 0x21999911),
		// 			once(currentCutsceneId(10) == 0x000014c8)
		// 		]) &&
		// 		repeated(150, onScreenTextID(0) == 0x65) && 
		// 		onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80008 && 
		// 		onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x500003	
		// 	) || ( 	// Alt 3 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
		// 		isChapterFinished("Chapter4")
		// 	)
		// )
		},		
	"a_Chapter4CompleteSign": function Chapter4CompletePan() { return
		// Core group 
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
		isCurrentSelectedInventoryItem("Sign") && isChapterFinished("Chapter4")
		// ( 	
		// 	( 		// Alt 1 => IDs last chapter cutscene while using the sign WITHOUT taking the picture 
		// 		unless(!isCurrentChapter("Chapter4")) &&
		// 		tally(3, [
		// 			once(currentCutsceneId(6) == 0x0bf71852),
		// 			once(currentCutsceneId(21) == 0x3231f791),
		// 			once(currentCutsceneId(18) == 0x01f51110)
		// 		]) && 
		// 		repeated(150, onScreenTextID(0) == 0x65) && 
		// 		onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80008 && 
		// 		onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x500003	
		// 	) || (	// Alt 2 => IDs last chapter cutscene while using the sign AND taking the picture 
		// 		unless(!isCurrentChapter("Chapter4")) &&
		// 		tally(3, [
		// 			once(currentCutsceneId(7) == 0x0c111863),
		// 			once(currentCutsceneId(9) == 0x21999911),
		// 			once(currentCutsceneId(10) == 0x000014c8)
		// 		]) &&
		// 		repeated(150, onScreenTextID(0) == 0x65) && 
		// 		onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80008 && 
		// 		onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x500003	
		// 	) || ( 	// Alt 3 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
		// 		isChapterFinished("Chapter4")
		// 	)
		// )
		},
	"a_Chapter5Complete": function Chapter5Complete() { return
		never(!isGameRunning()) 				&&
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu())	&&
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
			IsViewingCutsceneFromExtraMenu()
		) &&
		once(
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x82 && // Block => IDs thriller story choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff91 &&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x40fffe &&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4fffe7 &&
			currentCutsceneId(1) == 0x14b7ff2e && priorCutsceneId(1) == 0x82fe9c && 
			currentCutsceneId(18) == 0xf8ef1a5d && priorCutsceneId(18) == 0xe6e531b2 && 
			currentCutsceneId(21) == 0xfbb7024f && priorCutsceneId(21) == 0xe6e531b0
		) && 
		trigger_when(
			tally(171, [
				repeated(170, 
					currentCutsceneId(16) == 0xd7070002 && priorCutsceneId(16) == 0x14003200 && // Block => IDs cutscene with love or thriller movie poster
					currentCutsceneId(17) == 0xaffff73c && priorCutsceneId(17) == 0xe7151922 && 
					currentCutsceneId(18) == 0x0001fa74 && priorCutsceneId(18) == 0x00390053 &&
					onScreenTextID(0) == 0x5a && prior(onScreenTextID(0)) == 0x62),
				once(
					currentCutsceneId(2) == 0x58044579 && priorCutsceneId(2) == 0x2497b00 && // Block => IDs last cutscene of chapter 
					currentCutsceneId(8) == 0x29970b5a && priorCutsceneId(8) == 0x44d6b180 && 
					currentCutsceneId(11) == 0x0000f80b && priorCutsceneId(11) == 0xe6df1f01 &&
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x88)]
			)
		)},
	"a_Chapter6CompleteLove": function Chapter6CompleteLove() {	return
		never(
			!isGameRunning() 				||
			!isCurrentChapter("Chapter6")	||
			IsViewingCutsceneFromExtraMenu()
		) &&
		once(
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x82 &&	// Block => IDs love story choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x3fff90 &&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x3ffffd &&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x50ffe8 &&
			currentCutsceneId(1) == 0x14b7ff2e && priorCutsceneId(1) == 0x82fe9c && 
			currentCutsceneId(18) == 0xf8ef1a5d && priorCutsceneId(18) == 0xe6e531b2 && 
			currentCutsceneId(21) == 0xfbb7024f && priorCutsceneId(21) == 0xe6e531b0
		) && 
		trigger_when(
			tally(171, [
				repeated(170, 
					currentCutsceneId(16) == 0xd7070002 && priorCutsceneId(16) == 0x14003200 && // Block => IDs cutscene with love or thriller movie poster
					currentCutsceneId(17) == 0xaffff73c && priorCutsceneId(17) == 0xe7151922 && 
					currentCutsceneId(18) == 0x0001fa74 && priorCutsceneId(18) == 0x00390053 &&
					onScreenTextID(0) == 0x5a && prior(onScreenTextID(0)) == 0x62),
				once(
					currentCutsceneId(2) == 0x58044579 && priorCutsceneId(2) == 0x2497b00 && // Block => IDs last cutscene of chapter 
					currentCutsceneId(8) == 0x29970b5a && priorCutsceneId(8) == 0x44d6b180 && 
					currentCutsceneId(11) == 0x0000f80b && priorCutsceneId(11) == 0xe6df1f01 &&
					onScreenTextID(0) == 0x0 && prior(onScreenTextID(0)) == 0x88)]
			)
		)},
	"a_Chapter7Complete": function Chapter7Complete() { return
		never(
			!isGameRunning() 				||
			!isCutsceneActive() 			||
			IsViewingCutsceneFromExtraMenu()
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
			!isCutsceneActive()					||
			IsViewingCutsceneFromExtraMenu()
		) && (
			isChapterFinished("Chapter8_Ancestress") ||
			isChapterFinished("Chapter8_NoAncestress")
		)},
	"a_EndingA": function EndingA() { return
		never(
			!isGameRunning() 	||
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu() ||
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
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu() ||
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
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu() ||
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
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_Ancestress") ||
			IsViewingCutsceneFromExtraMenu() || // --> Some reason this comparison becomes true during this cutscene 
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
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_NoAncestress") ||
			IsViewingCutsceneFromExtraMenu() ||
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
			!isCutsceneActive()	||
			!isCurrentChapter("Epilogue_NoAncestress") ||
			IsViewingCutsceneFromExtraMenu() ||
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
			tally(5, [
				repeated(5, // Normal way counting energy collection
					energyUnitsZPad() > prev(energyUnitsZPad()) &&
					prior(onScreenTextID(1)) == 0x48ffc2	&&
					prior(onScreenTextID(2)) == 0x4b0000	&&
					prior(onScreenTextID(3)) == 0x480032	&&
					!isCutsceneActive()
				), 
				once(	// One energy collection is different from rest: during chapter 3, after energy has been drained
					energyUnitsZPad() == 0x1 && prior(energyUnitsZPad()) == 0x0 &&
					isCurrentChapter("Chapter3")			&&
					prior(onScreenTextID(1)) == 0x48ffb0	&&
					prior(onScreenTextID(2)) == 0x590000	&&
					prior(onScreenTextID(3)) == 0x480031	&&
					!isCutsceneActive()
				)])}
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
		never(!isCutsceneActive()) 				&&
		never(IsViewingCutsceneFromExtraMenu()) &&
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
			!isCutsceneActive()					||
			!isCurrentChapter("Chapter7")		||
			IsViewingCutsceneFromExtraMenu()
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
			!isCutsceneActive() 			||
			!isCurrentChapter("Chapter1")	||
			IsViewingCutsceneFromExtraMenu()) 	&& 
		repeated(350, priorCutsceneId(10) == 0xfffe8366)		&& // this block => last cutscene has run for about 350 frames
		repeated(350, priorCutsceneId(13) == 0x3cd31cf) 		&&
		repeated(350, priorCutsceneId(15) == 0x11110597) 		&& 
		repeated(350, currentCutsceneId(10) == 0x1ce0d25d) 		&&
		repeated(350, currentCutsceneId(13) == 0xc841ccb) 		&&
		repeated(350, currentCutsceneId(15) == 0x99991119)},
	"a_EggCollection1": function EggCollection1() { return		 
		never(!isGameRunning()) 				&& // This block => Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
		never(!isCutsceneActive()) 				&&
		never(!isCurrentChapter("Chapter1")) 	&&	
		never(IsViewingCutsceneFromExtraMenu())	&&
		repeated(320, priorCutsceneId(11) == 0x4d5fc40) 	&& // This block => last cutscene has run for about 420 frames
		repeated(320, priorCutsceneId(14) == 0x55005ce) 	&&
		repeated(320, priorCutsceneId(16) == 0x88065620) 	&& 
		repeated(320, currentCutsceneId(11) == 0x11111112) 	&&
		repeated(320, currentCutsceneId(14) == 0x30ff26b) 	&&
		repeated(320, currentCutsceneId(16) == 0x11d8fa)},
	"a_EggCollection2": function EggCollection2() { return 
		never(!isGameRunning() || !isCutsceneActive() || IsViewingCutsceneFromExtraMenu()) &&
		never(!isCurrentChapter("Chapter3") && !isCurrentChapter("Chapter4")) &&
		(	
			(
				repeated(470, priorCutsceneId(22) == 0x68df3900) 	&& // Block => IDs cutscene in chapter 3 when giving egg to barman
				repeated(470, priorCutsceneId(12) == 0x18e6) 		&&
				repeated(470, priorCutsceneId(17) == 0x66319a2) 	&& 
				repeated(470, currentCutsceneId(22) == 0xd4faa9fa) 	&&
				repeated(470, currentCutsceneId(12) == 0x7bff8c) 	&&
				repeated(470, currentCutsceneId(17) == 0xff2009cc)
			) || (
				repeated(470, priorCutsceneId(19) == 0x2000000) 	&& // Block => IDs cutscene in chapter 4 when giving egg to barman
				repeated(470, priorCutsceneId(12) == 0xfe1506b8) 	&&
				repeated(470, priorCutsceneId(17) == 0x2881cf5) 	&& 
				repeated(470, currentCutsceneId(19) == 0x04006a00) 	&&
				repeated(470, currentCutsceneId(12) == 0x00b20009) 	&&
				repeated(470, currentCutsceneId(17) == 0x167014f2)
			)
		)},
	"a_IntroduceEggCollecting": function IntroduceEggCollecting() { return 
		never(!isGameRunning()) 						&& 	// This block => Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
		never(!isCutsceneActive()) 						&&
		never(!isCurrentChapter("Chapter2"))			&&
		never(IsViewingCutsceneFromExtraMenu())			&&

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
			!isCutsceneActive() 				||	
			IsViewingCutsceneFromExtraMenu() 	||
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
			!isCutsceneActive() 				||
			IsViewingCutsceneFromExtraMenu() 	||
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
			!isCutsceneActive()					||
			IsViewingCutsceneFromExtraMenu() 	||
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
	"a_EikeThePyromancer": function EikeThePyromancer() {
		return 
			disable_when( // Disable achievement when flowers is picked, instead of statue
				isCurrentSelectedInventoryItem("SquireCrest") && 
				currentCutsceneId(14) == 0x4831736	&& // This block => check if cutscene after choice has started
				currentCutsceneId(15) == 0x431ab010	&&
				currentCutsceneId(17) == 0x4f1f9ae	&&
				prior(onScreenTextID(1)) == 0x003fff5f	&& // This block => check if flowers is chosen
				prior(onScreenTextID(7)) == 0x0050ffea	&&
				prior(onScreenTextID(8)) == 0x005000a3	&&
				onScreenTextID(1) == 0					&&
				onScreenTextID(7) == 0					&&
				onScreenTextID(8) == 0
			) &&
			never(
				!isGameRunning() 					|| 
				IsViewingCutsceneFromExtraMenu() 	||
				!isCurrentChapter("Chapter2")
			) &&
			tally(470, 	// Tally block => IDs cutscene where Eike scares crowd with the lighter
				repeated(270,
					isCurrentSelectedInventoryItem("Lighter") 	&&
					prior(currentCutsceneId(2)) == 0x2ff955 	&& 	currentCutsceneId(2) == 0x10111112 	&&
					prior(currentCutsceneId(4)) == 0xe6de04a6 	&&	currentCutsceneId(4) == 0xde980748	&&
					prior(currentCutsceneId(6)) == 0x1100040a 	&&	currentCutsceneId(6) == 0x12480620),
				repeated(200,
					isCurrentSelectedInventoryItem("Lighter") 	&& 
					onScreenTextID(0) == 0x23 					&& 
					prior(onScreenTextID(1)) == 0x48ffcb && onScreenTextID(1) == 0x0 &&
					prior(onScreenTextID(3)) == 0x490027 && onScreenTextID(3) == 0x0)
			) &&
			trigger_when(
				tally(2024, // Tally block => IDs last cutscene of chapter 2, when tree changes into statue or flowers 
					repeated(1900, 
						isCurrentSelectedInventoryItem("D-pad") &&
						currentCutsceneId(22) == 0x7c000000 	&&
						currentCutsceneId(12) == 0xfd7c0000 	&&
						currentCutsceneId(1) == 0xefff0000),
					once(onScreenTextID(0) == 0x102 && prior(onScreenTextID(0)) == 0x195),
					once(onScreenTextID(0) == 0x7a 	&& prior(onScreenTextID(0)) == 0x102),
					once(onScreenTextID(0) == 0x30 	&& prior(onScreenTextID(0)) == 0x7a),
					once(onScreenTextID(0) == 0x50 	&& prior(onScreenTextID(0)) == 0x30),
					repeated(150,
						isCurrentSelectedInventoryItem("D-pad") &&
						onScreenTextID(0) == 0x50 	&&
						onScreenTextID(2) == 0x0 	&& prior(onScreenTextID(2)) == 0x4e0000 &&
						onScreenTextID(4) == 0x0 	&& prior(onScreenTextID(4)) == 0x80005)
				)
			)}, 
	"a_EikeTheMagician": function EikeTheMagician() {
		return 
			disable_when( // Disable achievement when flowers is picked, instead of statue
				isCurrentSelectedInventoryItem("SquireCrest") && 
				currentCutsceneId(14) == 0x4831736	&& // This block => check if cutscene after choice has started
				currentCutsceneId(15) == 0x431ab010	&&
				currentCutsceneId(17) == 0x4f1f9ae	&&
				prior(onScreenTextID(1)) == 0x003fff5f	&& // This block => check if flowers is chosen
				prior(onScreenTextID(7)) == 0x0050ffea	&&
				prior(onScreenTextID(8)) == 0x005000a3	&&
				onScreenTextID(1) == 0					&&
				onScreenTextID(7) == 0					&&
				onScreenTextID(8) == 0
			) &&
			never(
				!isGameRunning() 					|| 
				IsViewingCutsceneFromExtraMenu() 	||
				!isCurrentChapter("Chapter2")
			) &&
			tally(470, 	// Tally block => IDs cutscene where Eike scares crowd with the cellphone
				repeated(200,  
					isCutsceneActive() &&
					isCurrentSelectedInventoryItem("Cellphone") && 
					currentCutsceneId(11) == 0xc4612c05 && priorCutsceneId(11) == 0xff9c1670 &&
					currentCutsceneId(15) == 0x0 		&& priorCutsceneId(15) == 0xc57c78c2 &&
					currentCutsceneId(18) == 0x1276 	&& priorCutsceneId(18) == 0xfc240056),
				repeated(270, 
					isCutsceneActive() &&
					isCurrentSelectedInventoryItem("Cellphone") && 
					currentCutsceneId(3) == 0x50000000 && priorCutsceneId(3) == 0xfe51a2ff &&
					currentCutsceneId(8) == 0x0481fede && priorCutsceneId(8) == 0xfbd101d3 &&
					currentCutsceneId(11) == 0x2169fb15 && priorCutsceneId(11) == 0xc4612c05)
			) &&
			trigger_when(
				tally(2024, // Tally block => IDs last cutscene of chapter 2, when tree changes into statue or flowers 
					repeated(1900, 
						isCutsceneActive() &&
						isCurrentSelectedInventoryItem("D-pad") &&
						currentCutsceneId(22) == 0x7c000000 	&&
						currentCutsceneId(12) == 0xfd7c0000 	&&
						currentCutsceneId(1) == 0xefff0000),
					once(onScreenTextID(0) == 0x102 && prior(onScreenTextID(0)) == 0x195),
					once(onScreenTextID(0) == 0x7a 	&& prior(onScreenTextID(0)) == 0x102),
					once(onScreenTextID(0) == 0x30 	&& prior(onScreenTextID(0)) == 0x7a),
					once(onScreenTextID(0) == 0x50 	&& prior(onScreenTextID(0)) == 0x30),
					repeated(150,
						isCutsceneActive() &&
						isCurrentSelectedInventoryItem("D-pad") &&
						onScreenTextID(0) == 0x50 	&&
						onScreenTextID(2) == 0x0 	&& prior(onScreenTextID(2)) == 0x4e0000 &&
						onScreenTextID(4) == 0x0 	&& prior(onScreenTextID(4)) == 0x80005)
				)
			)}, 	
	"a_EikeTheFlorist": function EikeTheFlorist() { return
		never(	// Reset counts if game isn't running, game isn't in the correct chapter 
			!isGameRunning() 					|| 
			IsViewingCutsceneFromExtraMenu() 	||
			!isCurrentChapter("Chapter2")
		) && 
		once(
			isCutsceneActive() 								&&
			isCurrentSelectedInventoryItem("SquireCrest") 	&& 
			currentCutsceneId(14) == 0x4831736	&& // This block => check if cutscene after choice has started
			currentCutsceneId(15) == 0x431ab010	&&
			currentCutsceneId(17) == 0x4f1f9ae	&&
			prior(onScreenTextID(1)) == 0x003fff5f	&& onScreenTextID(1) == 0	&&	// This block => check if flowers is chosen
			prior(onScreenTextID(7)) == 0x0050ffea	&& onScreenTextID(7) == 0	&&
			prior(onScreenTextID(8)) == 0x005000a3	&& onScreenTextID(8) == 0
		) &&
		trigger_when(
			tally(2024, // Tally block => IDs last cutscene of chapter 2, when tree changes into statue or flowers 
					repeated(1900, 
						isCutsceneActive() &&
						isCurrentSelectedInventoryItem("D-pad") &&
						currentCutsceneId(22) == 0x7c000000 	&&
						currentCutsceneId(12) == 0xfd7c0000 	&&
						currentCutsceneId(1) == 0xefff0000),
					once(onScreenTextID(0) == 0x102 && prior(onScreenTextID(0)) == 0x195),
					once(onScreenTextID(0) == 0x7a 	&& prior(onScreenTextID(0)) == 0x102),
					once(onScreenTextID(0) == 0x30 	&& prior(onScreenTextID(0)) == 0x7a),
					once(onScreenTextID(0) == 0x50 	&& prior(onScreenTextID(0)) == 0x30),
					repeated(150,
						isCutsceneActive() &&
						isCurrentSelectedInventoryItem("D-pad") &&
						onScreenTextID(0) == 0x50 	&&
						onScreenTextID(2) == 0x0 	&& prior(onScreenTextID(2)) == 0x4e0000 &&
						onScreenTextID(4) == 0x0 	&& prior(onScreenTextID(4)) == 0x80005)
				)
		)},
	"a_BarmansChildren": function BarmansChildren() { return
		never(
			!isGameRunning() 					||
			!isCutsceneActive() 				||
			IsViewingCutsceneFromExtraMenu() 	||
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
			!IsViewingCutsceneFromExtraMenu()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter2")
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a329fc 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a329ac 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a32a10 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a329c0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b97810 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a32a24 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b97804 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a329d4 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
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
			!IsViewingCutsceneFromExtraMenu()}	
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter3")
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a32c68 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a32c18 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a32c7c 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a32c2c 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a32c90 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b964 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a32c40 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
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
			!IsViewingCutsceneFromExtraMenu()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter4")
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2() != 0x08a33050 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a33000 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2() != 0x08a33064 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a33014 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2() != 0x08a33078 	&&
				interactionID_3() != 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2() != 0x08a33028 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
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
			!IsViewingCutsceneFromExtraMenu()} 
		return
			never(
				!isCurrentChapter("Chapter5")
			) &&
			unless(
				interactionID_1() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2() != 0x08a331cc 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2() != 0x08a331e0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
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
			!IsViewingCutsceneFromExtraMenu()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter7")
			) &&
			unless(
				interactionID_1() != 0x08a1bb38 	&&		// Block => cutscene when talking to man 
				interactionID_2() != 0x08a33398 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08a1bb44 &&			// Block => cutscene when talking to woman and picking dialogue option: Tell the truth
				interactionID_2() != 0x08a333fc && prior(interactionID_2()) != 0x8a333e8 &&
				interactionID_3() != 0x197		&&
				!isCutsceneActive()
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
			!IsViewingCutsceneFromExtraMenu()}
		return 
			never(
				!isCurrentChapter("Chapter8")
			) &&
			unless(
				interactionID_1() != 0x08ba3264 	&&		// Block => cutscene when talking to man before experiment
				interactionID_2() != 0x08a335f0 	&&
				interactionID_3() != 0x198			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08ba349c 	&&		// Block => cutscene when talking to man after experiment for 2nd time after picking the dialogue option: Lovers never destined to meet  
				interactionID_2() != 0x08a3367c 	&&
				interactionID_3() != 0x198			&&
				onScreenTextID(1) != 0x0048ff81		&&
				onScreenTextID(2) != 0x00480000		&&
				onScreenTextID(3) != 0x0048fffc		&&
				onScreenTextID(4) != 0x00080009		&&
				!isCutsceneActive()
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
			isGameRunning() && !IsViewingCutsceneFromExtraMenu() &&
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
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() != 0x08a30a80 	&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a30be8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() != 0x08a30a94 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
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
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && repeated(100, isCurrentChapter("Chapter3"))
		// Trigger
		return  
			never(
				!isCurrentChapter("Chapter3")
			) &&
			unless(
				interactionID_1() != 0x08b994d0 	&&
				interactionID_2() != 0x08a30c10 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b994c4		&&
				interactionID_2() != 0x08a30abc		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b994d0 		&&
				interactionID_2() != 0x08a30c24 		&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57				&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b994c4 		&&
				interactionID_2() != 0x08a30ad0 		&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56				&&
				!isCutsceneActive()
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
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && repeated(100, isCurrentChapter("Chapter4"))
		// Trigger
		return  
			never(
				!isCurrentChapter("Chapter4")
			) &&
			unless(
				interactionID_1() != 0x08b9dc8c 	&&
				interactionID_2() != 0x08a30c10 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b9dc80		&&
				interactionID_2() != 0x08a30af8		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b9dc8c 		&&
				interactionID_2() != 0x08a30c24 		&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57				&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b9dc80 		&&
				interactionID_2() != 0x08a30b0c 		&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56				&&
				!isCutsceneActive()
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
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && repeated(100, isCurrentChapter("Chapter5"))
		// Trigger
		return  
			never (
				!isCurrentChapter("Chapter5")
			) &&
			unless(
				interactionID_1() != 0x08b9d400 	&&
				interactionID_2() != 0x08a30c9c 	&&		// Block => cutscene when talking to woman
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b9d3f4		&&
				interactionID_2() != 0x08a30b5c		&&		// Block => cutscene when talking to man 1st time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b9d3f4 	&&
				interactionID_2() != 0x08a30b70 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
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
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && repeated(100, isCurrentChapter("Chapter7"))
		// Trigger
		return  
			never (
				!isCurrentChapter("Chapter7")
			) &&
			unless(
				interactionID_1() != 0x08b98db4 	&&
				interactionID_2() != 0x08a30c4c 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b98db4 	&&
				interactionID_2() != 0x08a30c60 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() != 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b98da8		&&
				interactionID_2() != 0x08a30b34		&&		// Block => cutscene when talking to man
				interactionID_3() != 0x56			&&
				!isCutsceneActive()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
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
			!IsViewingCutsceneFromExtraMenu()}
		// Trigger 
		return 
			never(	// Reset count on chapter change
				hasChapterChanged()
			) &&
			unless(
				interactionID_2() != 0x08a321c8 	&&		// Block => Town Streets painting (downstairs)
				interactionID_3() != 0x163			&&	
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a32204 	&&		// Block => Squire's crest painting (upstairs)
				interactionID_3() != 0x164			&&	
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() != 0x08a32240 	&&		// Block => Town planter painting (upstairs)
				interactionID_3() != 0x165			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a3227c 	&&		// Block => Oddly dressed man painting (upstairs)
				interactionID_3() != 0x166			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() != 0x08a322b8 	&&		// Block => Alchemist portrait (upstairs)
				interactionID_3() != 0x167			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a322e0 	&&		// Block => Burning house painting (upstairs)
				interactionID_3() != 0x168			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a3231c 	&&		// Block => Landscape painting (upstairs)
				interactionID_3() != 0x169			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() != 0x08a32344 	&&		// Block => Alchemy lab painting (upstairs)
				interactionID_3() != 0x16a			&&
				!isCutsceneActive()
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
			isGameRunning() && !IsViewingCutsceneFromExtraMenu() &&
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
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b9950c		&&	// Block => Old rope
				interactionID_2() != 0x08a315c0 	&&
				interactionID_3() != 0x98			&&	
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_1() != 0x08b994f4		&&	// Block => Old antidote bottle
				interactionID_2() != 0x08a31638 	&&
				interactionID_3() != 0x79			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() != 0x08b994e8		&&	// Block => Franssen Shop sign
				interactionID_2() != 0x08a315e8 	&&
				interactionID_3() != 0x8e			&&
				!isCutsceneActive()
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
			function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && isCurrentChapter("Chapter6")
			return 
				unless(!isCutsceneActive()) &&
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
		function measuredIfComparison() => isGameRunning() && !IsViewingCutsceneFromExtraMenu() && isCurrentChapter("Chapter6")
		return 
			unless(!isCutsceneActive()) &&
			measured(measuredComparison(), measuredIfComparison())
		},
	"a_HugoMotherChild": function HugoMotherChild() { return
		never(
			!isGameRunning() 					|| 
			!isCutsceneActive() 				|| 
			IsViewingCutsceneFromExtraMenu() 	|| 
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
			!isGameRunning() || !isCutsceneActive() || IsViewingCutsceneFromExtraMenu() || 
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
			IsViewingCutsceneFromExtraMenu() 	|| 
			!isCutsceneActive())				&&
		repeated(1050, prior(currentCutsceneId(22)) == 0x4b07ccd5) 	&&	// This block => last cutscene has run for about 1070 frames
		repeated(1050, prior(currentCutsceneId(3)) == 0xe000b600) 	&&
		repeated(1050, prior(currentCutsceneId(9)) == 0xa0e6e5ff) 	&&
		repeated(1050, currentCutsceneId(22) == 0x52036400) 			&&
		repeated(1050, currentCutsceneId(3) == 0x47f45022) 			&&
		repeated(1050, currentCutsceneId(9) == 0x5ffe5fe9)},	
	"a_ErasingEike2": function ErasingEike2() { return
		never(
			!isGameRunning()					||
			IsViewingCutsceneFromExtraMenu() 	|| 
			!isCurrentChapter("Chapter7") 		||
			!isCutsceneActive()
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
			!isCutsceneActive() 				|| 
			IsViewingCutsceneFromExtraMenu() 	|| 
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
			IsViewingCutsceneFromExtraMenu() 	|| 
			!isCurrentChapter("Chapter6")
		) &&
		once(
			onScreenTextID(0) == 0x1 && prior(onScreenTextID(0)) == 0x4b && 		// Block => IDs Time Ego choice
			onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x0040ff68 &&
			onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x40ffe0 &&
			onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4fffad &&
			currentCutsceneId(18) == 0xe6e531b2 && priorCutsceneId(18) == 0xc901500 && 
			currentCutsceneId(21) == 0xe6e531b0 && priorCutsceneId(21) == 0x6dc && 
			currentCutsceneId(25) == 0x811229f0 && priorCutsceneId(25) == 0x25cae263
		) && 
		trigger_when(
			tally(171, [
				repeated(500, 
					currentCutsceneId(6) == 0xff530209 	&& priorCutsceneId(6) == 0xff5af64e && // Block => IDs cutscene with 'World Conquest' movie poster
					currentCutsceneId(16) == 0x10e00 && priorCutsceneId(16) == 0xc3000000 	&& 
					currentCutsceneId(14) == 0x002de210 && priorCutsceneId(14) == 0xffa1 	&&
					onScreenTextID(0) == 0x32 && prior(onScreenTextID(0)) == 0x80), 
				repeated(30, 
					onScreenTextID(0) == 0x5a && prior(onScreenTextID(0)) == 0xe1 &&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x48ffc2 &&
					onScreenTextID(2) == 0x0 && prior(onScreenTextID(2)) == 0x410000 &&
					onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x480029)
			])
		)},
	"a_MetYouBefore": function MetYouBefore() { return  
		never(	 // Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning()					||
			!isCurrentChapter("Chapter2") 		||
			IsViewingCutsceneFromExtraMenu() 	|| 
			!isCutsceneActive())				&&
		repeated(1400, onScreenTextID(0) == 0x4b) &&	// Block => identifies the cutscene (code might be too bloated but better safe than sorry)
		once(prev(onScreenTextID(0)) == 0x4b && onScreenTextID(0) == 0x2d) &&	// Text sequence A
		once(prev(onScreenTextID(0)) == 0x2d && onScreenTextID(0) == 0x1e) &&	// Text sequence B
		once(prev(onScreenTextID(0)) == 0xf0 && onScreenTextID(0) == 0x78) &&	// Text sequence C
		once(prev(onScreenTextID(0)) == 0x78 && onScreenTextID(0) == 0x4b) &&	// Text sequence E
		once(prev(onScreenTextID(0)) == 0xb4 && onScreenTextID(0) == 0x4b) &&	// Text sequence D
		once(prev(onScreenTextID(0)) == 0x78 && onScreenTextID(0) == 0x50) &&	// Text sequence F
		once(prev(onScreenTextID(1)) == 0x0 && onScreenTextID(1) == 0x0040ff86) &&	// Text A
		once(prev(onScreenTextID(5)) == 0x0 && onScreenTextID(5) == 0x0050ffd0) &&	// Text A
		once(prev(onScreenTextID(1)) == 0x0 && onScreenTextID(1) == 0x0048ffc9) &&	// Text B
		once(prev(onScreenTextID(3)) == 0x0 && onScreenTextID(3) == 0x00480029) &&	// Text B
		once(prev(onScreenTextID(1)) == 0x0 && onScreenTextID(1) == 0x0040ff9e) &&	// Text E
		once(prev(onScreenTextID(4)) == 0x0 && onScreenTextID(4) == 0x00080009) &&	// Text E
		prior(onScreenTextID(1)) == 0x0040ffbb 							&&	// Last text
		prior(onScreenTextID(5)) == 0x00500045 							&&	// Last text
		prev(onScreenTextID(0)) == 0x50},									// Last text
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return 
		never(
			!isGameRunning() 					||
			!isCutsceneActive() 				||
			IsViewingCutsceneFromExtraMenu() 	|| 
			!isCurrentChapter("Chapter3")
		) &&
		tally(2,
			once(	// +1 when "excuse me" option is chosen
				currentCutsceneId(13) == 0xf6e80000 && priorCutsceneId(13) == 0xe8921922 && // Block => IDs cutscene after picking "excuse me"
				currentCutsceneId(16) == 0x001111ea && priorCutsceneId(16) == 0x85000000 &&
				currentCutsceneId(18) == 0xf1451010 && priorCutsceneId(18) == 0x680813 	&&
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x3fffb7 && // Block => true when picked "excuse me"
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x3f0017 &&
				onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x510025),
			once(	// +1 when cutscene in limbo finishes
				currentCutsceneId(5) == 0xd0161111 && priorCutsceneId(5) == 0x19dfd71f 	&& // Block => IDs cutscene in limbo after death
				currentCutsceneId(8) == 0x3e82c254 && priorCutsceneId(8) == 0xfd5df960 	&&
				currentCutsceneId(11) == 0x02acfd43 && priorCutsceneId(11) == 0x6c6ffa5 &&
				onScreenTextID(0) == 0x69 && prior(onScreenTextID(0)) == 0xaf 		&&	// Block => true when cutscene dialogue in limbo finishes 
				onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff89 	&& 
				onScreenTextID(2) == 0x0 && prior(onScreenTextID(2)) == 0x440000 	&&
				onScreenTextID(3) == 0x0 && prior(onScreenTextID(3)) == 0x41fff6)
		)}
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
	"a_Chapter2Complete": 							{"en": "Left in the Past: An Unintended Consequence"},
	"a_Chapter3Complete": 							{"en": "A Homonculus, a Red Stone and an Alchemist"},
	"a_Chapter4CompletePan": 						{"en": "Pan-tastic Resilience"},
	"a_Chapter4CompleteSign": 						{"en": "Through the Lens of Survival"},	
	"a_Chapter5Complete": 							{"en": "Remedy from the Past"}, 
	"a_Chapter6CompleteThriller":					{"en": "Director's Cut: The Time of Reckoning"},
	"a_Chapter6CompleteLove":						{"en": "Director's Cut: Trip for Two"},
	"a_Chapter7Complete":							{"en": "A Friend's Repentance"},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_Chapter8Complete":							{"en": "The Whole Picture... Or is it?"},
	"a_EndingA":									{"en": "An End to a Strange Experience"},
	"a_EndingB1":									{"en": "No Sense of Finality I"},
	"a_EndingB2":									{"en": "No Sense of Finality II"},
	"a_EndingC": 									{"en": "'If only... I had one more attempt'"},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "'The future is what we make it.'"},
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
	"a_MetYouBefore": 								{"en": "An Uncanny Familiarity"},
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
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Amasser: The Old Century"} 
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
	"a_EnergyOrbLocator1900Days": 					{"en": "Collect all 5 energy orbs in Lebensbaum, a century ago"}
	// "a_Template": 			{"en": "xxxxx"},
}

// ACHIEVEMENT INITIALIZER
//	- Creates achievements based on achievement dictionary
// *************************************************************
function initializeAchievements() {
	// Generates the achievement title (with developer tags, if devmode == 1)
	function generateAchievementTitle(string_achievementName, string_achievementCategory, string_languageCode) {
		function enterCategoryName(string_achievementCategory) {
			let_string = ""
			if isDevModeActive() {
				let_string = let_string + "[" + string_achievementCategory + "] "
			}
			return let_string
		}	
		function lookUpAchievementTitle(string_achievementName, string_languageCode) {
			return _achievementTitles[string_achievementName][string_languageCode]
		}
		return enterCategoryName(string_achievementCategory) + lookUpAchievementTitle(string_achievementName, string_languageCode)
	}
	// Generates the achievement description (with extra developer information, if devmode == 1)
	function generateAchievementDescription(string_achievementName, boolean_hasTips, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementName, string_languageCode) {
			return _achievementDescriptions[string_achievementName][string_languageCode]
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
		return lookUpAchievementDescription(string_achievementName, string_languageCode) + enterTipsLink(boolean_hasTips) + enterDevInfo(string_devInfo) 
	}
	// Returns the achievement trigger 
	function lookUpAchievementTrigger(string_achievementName) {
		return _achievementTriggers[string_achievementName]
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