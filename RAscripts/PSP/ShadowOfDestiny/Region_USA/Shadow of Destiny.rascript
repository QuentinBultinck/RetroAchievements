// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA
// *********************************************
 
//#########################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //  //   UTILITY    \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

devmode = 1					// if active => extra information may be displayed on achievement titles & descriptions
function isDevModeActive() => devmode == 1

achievementLanguage = "en"		// ISO 639-1 language codes 		// TODO check if multi-language support is needed 


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
														//		- Changes on interaction
														// 		- Doesn't reset back to a default value after interaction is done
														// 		- Unique per interaction 
function interactionID_2() 	=> dword(0xA9EFE4)			// $A9EFE4: [32-bit] Interaction ID 2
														// 		- Resets to 0x0 when interaction is done
														//		- Unique per interaction 
function interactionID_3() 	=> dword(0xA9EFF4)			// $A9EFF4: [32-bit] Interaction ID 3 
														//		- Unique per interactable NPC or environment item
														// 		- Resets to 0x0 when interaction is done

// CUTSCENES
// ***********
// TODO	=> Some cutscenes could be identified by INTERACTION IDs
//	- Everytime you view a different cutscene, memory values around these IDs/addresses change
//	- Each unique cutscene seems to have different values
//	- Some sequences consist of multiple cutscenes
_cutsceneIDs = {		//  
	1: 0x1DF4280, 		// $1DF4280: [32-bit] Cutscene ID // unused
	2: 0x1DF59B0, 		// $1DF59B0: [32-bit] Cutscene ID
	3: 0x1DF5F71, 		// $1DF5F71: [32-bit] Cutscene ID
	4: 0x1DF6724, 		// $1DF6724: [32-bit] Cutscene ID
	5: 0x1DF6F60, 		// $1DF6F60: [32-bit] Cutscene ID
	6: 0x1DF742A, 		// $1DF742A: [32-bit] Cutscene ID
	7: 0x1DF7FA2, 		// $1DF7FA2: [32-bit] Cutscene ID // Unused
	8: 0x1DF81BA, 		// $1DF81BA: [32-bit] Cutscene ID // Unused
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
	22: 0x1DF81E5		// $1DF81E5: [32-bit] Cutscene ID
}
function currentCutsceneId(int_cutsceneId) 	=> dword(_cutsceneIDs[int_cutsceneId])
function priorCutsceneId(int_cutsceneId) 	=> prior(dword(_cutsceneIDs[int_cutsceneId]))

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
	"Chapter8": 0x9,
	"Epilogue": 0xA,
	// TODO "Different endings": ???
	// TODO "EX chapter": ???
}
function chapterId() => byte(0xB95704)						// $B95704: [8-bit] Chapter ID
function isCurrentChapter(string_chapter) {
	return chapterId() == _chapterIDs[string_chapter]
}
function isChapterFinished(string_chapter) {
	return 
		prev(chapterId()) == _chapterIDs[string_chapter] &&
		chapterId() == _chapterIDs[string_chapter] + 0x1
}

// INVENTORY LOGIC 
// *****************
_inventoryItemIds = { 
	"OrnamentalEgg": 0x2,
	"SquireCrest": 0xf,
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
function OnScreenTextID(int_id) => dword(_onScreenTextID[int_id])

// OTHER LOGIC
// *************											
function isCutsceneActive() => bit0(0xA9Eb2C) == 0			// $A9Eb2C: [bit-0] Flag -> is cutscene active
															//		- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
															//		- 1 = no cutscene active
function isGameRunning() => bit0(0xA9F034) == 1				// $A9F034: [bit-0] Flag -> is game running
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
	//	"id": 000000, "points": 0000000,
	//	"devInfo": "xxxxxxx"},
	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // WORKING
			"id": 306884, "points": 1,
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // WORKING
			"id": 306886, "points": 1,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // WORKING
			"id": 306922, "points": 2,
			"devInfo": "Complete chapter 2"},
		// TODO "a_Chapter3Complete": {
		//	"id": 306921, "points": 3,
		// 	"devInfo": "Complete chapter 3",
		// TODO "a_Chapter4Complete": {
		//	"id": 000000, "points": 4,
		//	"devInfo": "Complete chapter 4",
		// TODO "a_Chapter5Complete": {
		//	"id": 000000, "points": 4,
		//	"devInfo": "Complete chapter 5",
		// TODO "a_Chapter6omplete": {
		//	"id": 000000, "points": 5,
		// 	"devInfo": "Complete chapter 6",
		// TODO "a_Chapter7Complete": {
		//	"id": 000000, "points": 5,
		// 	"devInfo": "Complete chapter 7"},
		// TODO "a_Chapter8Complete": { // TODO check if this is double with endings
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Complete chapter 8"},
		// TODO "a_EpilogueComplete": { // TODO check if this is double with endings
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Complete the epilogue "}, 
		// TODO "a_EXChapterComplete": {
		//	"id": 000000, "points": 50,
		// 	"devInfo": "Complete the EX chapter"},
		// TODO "a_Achieve100%Achievement": { // TODO check if this is possible to implement as achievement
		//	"id": 000000,
		// 	"points": 100,
		// 	"devInfo": "Seen ALL the cutscenes, should be saved in the MAIN safe file of the game"},
	},
	"c_Branch": { // Category - Branching path
		"a_GetOrnamentalEgg": { // WORKING
			"id": 306885, "points": 5,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."},
		"a_EggCollection1": { // WORKING
			"id": 306977, "points": 5,
			"devInfo": "Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with the stairs and door inside the building on fire, then go back in time, you'll be transported to the past inside the bar this time"},
		"a_EggCollection2": { // WORKING
			"id": 306976, "points": 5,
			"devInfo": "Give the ornamental egg to the barman at his bar during chapter 3 "},
	},
	"c_Endings": { // Category - Achieving different endings
		// TODO "a_EndingA": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending A: Margarette (Ancestress) => Homunculus => Town Square"},
		// TODO "a_EndingB1": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending B1: Margarette (Ancestress) => Homunculus => Town Square"},
		// TODO "a_EndingB2": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending B2: Margarette (Ancestress) => Fortuneteller => Town Square"},
		// TODO "a_EndingC": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		// TODO "a_EndingD": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		// TODO "a_EndingE": {	
		//	"id": 000000, "points": 10,
		// 	"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => Destroyed Lab"},
	},
	"c_Extra": { // Category - Extra side content & cutscenes
		"a_IntroduceEggCollecting": { // WORKING
			"id": 307023, "points": 5,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_EikeThePyromancer": { // Working // CONCEPT Change back into a_EikeThePyromancer => Trigger/Measure => pop a_ when chapter finishes
			"id": 306911, "points": 2,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // Working // CONCEPT Change back into a_EikeTheMagician => Trigger/Measure => pop a_ when chapter finishes
			"id": 306906, "points": 2,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_SquireOrdersFlowers": { // Working // CONCEPT Change back into a_EikeTheFlorist => pop a_ when chapter finishes
			"id": 306920, "points": 1,
			"devInfo": "Choose to plant flowers, when talking to the town planter in 1580 in chapter 2"},
		"a_SquireOrdersStatue": { // Working // CONCEPT Change back into a_EikeThePyromancer & a_EikeTheMagician => Trigger/Measure => pop a_ when chapter finishes
			"id": 306919, "points": 1,
			"devInfo": "Choose to build a statue, when talking to the town planter in 1580 in chapter 2"},
		"a_ArtAppreciator": { // WORKING 		// TODO check if this is completable in other chapters
			"id": 307499, "points": 2,
			"devInfo": "Interact with all 7 painting in the Brum Museum during chapter 3. They're on the 2nd floor"}, 
		"a_EnigmaticCouple1": { // WORKING
			"id": 307495, "points": 5,
			"devInfo": "Interact with the coated man and woman in the present during the prologue or chapter 1"},
		"a_LostYoungCouple1": { // WORKING
			"id": 306984, "points": 5, 
			"devInfo": "Interact with the lost man and woman in 1580 during chapter 2"},
	},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to PC dying or game over screen
		"a_MetYouBefore": {  // WORKING
			"id": 306888, "points": 5,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_ErasingEike": { // WORKING
			"id": 306883, "points": 5,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
	},
}


// ACHIEVEMENT TRIGGERS
// 	- check if key (achievementname) => is unique with ctrl+F
// ***********************************************************************************
_achievementTriggers = {
	"a_PrologueComplete": function PrologueComplete() { return
		// Core group
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
	"a_GetOrnamentalEgg": function AcquireOrnamentalEgg() { return
		never(	// Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning() 				|| 
			!isCutsceneActive() 			||
			!isCurrentChapter("Chapter1")) 	&& 
		repeated(350, priorCutsceneId(10) == 0xfffe8366)		&& // this block => last cutscene has run for about 350 frames
		repeated(350, priorCutsceneId(13) == 0x3cd31cf) 		&&
		repeated(350, priorCutsceneId(15) == 0x11110597) 		&& 
		repeated(350, currentCutsceneId(10) == 0x1ce0d25d) 		&&
		repeated(350, currentCutsceneId(13) == 0xc841ccb) 		&&
		repeated(350, currentCutsceneId(15) == 0x99991119)},
	"a_EggCollection1": function a_EggCollection1() { return		 
		never(!isGameRunning()) 				&& // This block => Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
		never(!isCutsceneActive()) 				&&
		never(!isCurrentChapter("Chapter1")) 	&&	
		repeated(420, priorCutsceneId(11) == 0x4d5fc40) 	&& // This block => last cutscene has run for about 420 frames
		repeated(420, priorCutsceneId(14) == 0x55005ce) 	&&
		repeated(420, priorCutsceneId(16) == 0x88065620) 	&& 
		repeated(420, currentCutsceneId(11) == 0x11111112) 	&&
		repeated(420, currentCutsceneId(14) == 0x30ff26b) 	&&
		repeated(420, currentCutsceneId(16) == 0x11d8fa)},
	"a_EggCollection2": function EggCollection2() { return 
		never( // Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning() 				||
			!isCurrentChapter("Chapter3") 	||
			!isCutsceneActive())			&&		
		repeated(470, priorCutsceneId(22) == 0x68df3900) 	&& // This block => last cutscene has run for about 470 frames
		repeated(470, priorCutsceneId(12) == 0x18e6) 		&&
		repeated(470, priorCutsceneId(17) == 0x66319a2) 	&& 
		repeated(470, currentCutsceneId(22) == 0xd4faa9fa) 	&&
		repeated(470, currentCutsceneId(12) == 0x7bff8c) 	&&
		repeated(470, currentCutsceneId(17) == 0xff2009cc)},
	"a_IntroduceEggCollecting": function IntroduceEggCollecting() { return 
		never(!isGameRunning()) 						&& 	// This block => Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
		never(!isCutsceneActive()) 						&&
		never(!isCurrentChapter("Chapter2"))			&&

		isCurrentSelectedInventoryItem("OrnamentalEgg") && 	// Is currently selected item the 'OrnamentalEgg'
		repeated(500, prior(currentCutsceneId(14)) == 0xe6df0168) 	&&	// this block => last cutscene has run for about 380 frames
		repeated(500, prior(currentCutsceneId(15)) == 0x168ec1a) 	&&
		repeated(500, prior(currentCutsceneId(17)) == 0x1ca92f3c) 	&&
		repeated(500, currentCutsceneId(14) == 0xa90841) 			&&
		repeated(500, currentCutsceneId(15) == 0x19) 				&&
		repeated(500, currentCutsceneId(17) == 0x0) 				&&

		repeated(3, (hasOneFrameTimerReset()))}, // Unlock achievement when cutscene is done = oneFrameTimerHasReset 3 times
	"a_EikeThePyromancer": function EikeThePyromancer() { return 
		// Core group => true when specific cutscene has run 270+ frames				
		never(	!isGameRunning() 				|| 
				!isCutsceneActive() 			||
				!isCurrentChapter("Chapter2")) 	&&
		repeated(270, prior(currentCutsceneId(2)) == 0x2ff955) 		&&	
		repeated(270, prior(currentCutsceneId(4)) == 0xe6de04a6) 	&&	
		repeated(270, prior(currentCutsceneId(6)) == 0x1100040a) 	&&
		repeated(270, currentCutsceneId(2) == 0x10111112) 			&&	
		repeated(270, currentCutsceneId(4) == 0xde980748) 			&&	
		repeated(270, currentCutsceneId(6) == 0x12480620) 			&&
		(
			( 		// Alt group 1 => true when twoFrameTimer has incremented 1600 times without resetting
				repeated(1600, hasTwoFrameTimerIncremented() && never(hasTwoFrameTimerReset()))
			) || ( 	// Alt group 2 => true when twoFrameTimer has reset twice, when whole cutscene sequence is over
				repeated(2, hasTwoFrameTimerReset())
			)
		)},
	"a_EikeTheMagician": function EikeTheMagician() { return
		never(
			!isGameRunning() 							|| 
			!isCutsceneActive() 						||
			!isCurrentChapter("Chapter2")) 				&& 
		repeated(1050, prior(currentCutsceneId(14)) == 0xc1f05529) 	&& 	// This block => Cutscene has run for 1050+ frames
		repeated(1050, prior(currentCutsceneId(17)) == 0x90190290) 	&&
		repeated(1050, prior(currentCutsceneId(18)) == 0x66d2507) 	&&
		repeated(1050, currentCutsceneId(14) == 0xfed5fe0b) 		&&
		repeated(1050, currentCutsceneId(17) == 0x2d7ff567) 		&&
		repeated(1050, currentCutsceneId(18) == 0xf57d2254) 		&&						// Pop achievement when twoframeTimer has incremented 1820 times without resetting
																							// ResetNextIf example																																
		repeated(1820, hasTwoFrameTimerIncremented() && never(hasOneFrameTimerReset()))}, 	// resets only this hitcount when never(isTrue) 
	"a_SquireOrdersFlowers": function TheSquiresFlowers() { return
		never(	// Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning() 				|| 
			!isCutsceneActive() 			||
			!isCurrentChapter("Chapter2")) 	&& 
		isCurrentSelectedInventoryItem("SquireCrest") 		&& 

		currentCutsceneId(14) == 0x4831736					&& // This block => check if cutscene after choice is has started
		currentCutsceneId(15) == 0x431ab010					&&
		currentCutsceneId(17) == 0x4f1f9ae					&&

		prior(OnScreenTextID(1)) == 0x003fff5f		&& // This block => check if flowers is chosen
		prior(OnScreenTextID(7)) == 0x0050ffea		&&
		prior(OnScreenTextID(8)) == 0x005000a3		&&
		OnScreenTextID(1) == 0						&&
		OnScreenTextID(7) == 0						&&
		OnScreenTextID(8) == 0},
	"a_SquireOrdersStatue": function SquireOrdersStatue() { return
		never(!isGameRunning())					&&
		never(!isCutsceneActive())				&&
		never(!isCurrentChapter("Chapter2"))		&&
		isCurrentSelectedInventoryItem("SquireCrest") 	&& 

		currentCutsceneId(14) == 0x4831736				&& // This block => check if cutscene after choice is has started
		currentCutsceneId(15) == 0x431ab010				&&
		currentCutsceneId(17) == 0x4f1f9ae				&&

		prior(OnScreenTextID(1)) == 0x40ff60 	&& // This block => check if statue is chosen
		prior(OnScreenTextID(7)) == 0x4fffe9 	&&
		prior(OnScreenTextID(8)) == 0x4f00a2	&&
		OnScreenTextID(1) == 0					&&
		OnScreenTextID(7) == 0					&&
		OnScreenTextID(8) == 0},
	"a_LostYoungCouple1": function LostYoungCouple1() {
		// Private functions
		function measuredComparison() { return
			tally(2, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2() == 0x08a329c0),		// Add hit: +1  	=> for talking to man
				once(interactionID_2() == 0x08a32a10)		// Add hit: +1 = 2 	=> for talking to woman 
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter2")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isGameRunning()}								// frames where both these comparisons are true. So this hit counts fixes that
		// Trigger 
		return 
			unless(
				interactionID_1() == 0x08b97810 	&&		// Block => cutscene when talking to woman
				interactionID_2() == 0x08a32a10 	&&
				interactionID_3() == 0x197			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_1() == 0x08b97804 	&&		// Block => cutscene when talking to man
				interactionID_2() == 0x08a329c0 	&&
				interactionID_3() == 0x198			&&
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
			isGameRunning() && 
			(
				repeated(100, isCurrentChapter("Prologue")) || 	// Hit count 100 => when loading another save to another chapter, there's a few 
				repeated(100, isCurrentChapter("Chapter1"))		// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
			)}
		// Trigger
		return  
			unless(
				interactionID_2() == 0x08a30bd4 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_3() == 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() == 0x08a30a80 	&&		// Block => cutscene when talking to man 1st time
				interactionID_3() == 0x56			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() == 0x08a30be8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_3() == 0x57			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() == 0x08a30a94 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_3() == 0x56			&&
				!isCutsceneActive()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_ArtAppreciator": function ArtAppreciator() {
		// Private functions
		function measuredComparison() { return
			tally(7, [										//			= 7
				once(interactionID_2() == 0x08a32204),		// Add hit: +1 	=> Squire's crest painting
				once(interactionID_2() == 0x08a32240),		// Add hit: +1	=> Town planter painting
				once(interactionID_2() == 0x08a3227c),		// Add hit: +1	=> Oddly dressed man painting
				once(interactionID_2() == 0x08a322b8),		// Add hit: +1	=> Alchemist portrait
				once(interactionID_2() == 0x08a322e0),		// Add hit: +1	=> Burning house painting
				once(interactionID_2() == 0x08a3231c),		// Add hit: +1	=> Landscape painting
				once(interactionID_2() == 0x08a32344)		// Add hit: +1	=> Alchemy lab painting
			])}
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter3")) && 		// Hit count 100 => when loading another save to another chapter, there's a few							 
			isGameRunning()}									// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
		// Trigger 
		return 
			unless(
				interactionID_2() == 0x08a32204 	&&		// Block => Squire's crest painting
				interactionID_3() == 0x164			&&	
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() == 0x08a32240 	&&		// Block => Town planter painting
				interactionID_3() == 0x165			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() == 0x08a3227c 	&&		// Block => Oddly dressed man painting
				interactionID_3() == 0x166			&&
				!isCutsceneActive()
			) &&
			unless(	
				interactionID_2() == 0x08a322b8 	&&		// Block => Alchemist portrait
				interactionID_3() == 0x167			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() == 0x08a322e0 	&&		// Block => Burning house painting
				interactionID_3() == 0x168			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() == 0x08a3231c 	&&		// Block => Landscape painting
				interactionID_3() == 0x169			&&
				!isCutsceneActive()
			) &&
			unless(
				interactionID_2() == 0x08a32344 	&&		// Block => Alchemy lab painting
				interactionID_3() == 0x16a			&&
				!isCutsceneActive()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!isGameRunning()				||
			!isCurrentChapter("Prologue") 	||
			!isCutsceneActive())			&&
		repeated(1050, prior(currentCutsceneId(22)) == 0x4b07ccd5) 	&&	// This block => last cutscene has run for about 1070 frames
		repeated(1050, prior(currentCutsceneId(3)) == 0xe000b600) 	&&
		repeated(1050, prior(currentCutsceneId(9)) == 0xa0e6e5ff) 	&&
		repeated(1050, currentCutsceneId(22) == 0x52036400) 			&&
		repeated(1050, currentCutsceneId(3) == 0x47f45022) 			&&
		repeated(1050, currentCutsceneId(9) == 0x5ffe5fe9)},	
	"a_MetYouBefore": function MetYouBefore() { return 
		never(	 // Reset counts if game isn't running, game isn't in the correct chapter or if no cutscene is active
			!isGameRunning()				||
			!isCurrentChapter("Chapter2") 	||
			!isCutsceneActive())			&&
		repeated(1400, OnScreenTextID(0) == 0x4b) &&	// Block => identifies the cutscene (code might be too bloated but better safe than sorry)
		once(prev(OnScreenTextID(0)) == 0x4b && OnScreenTextID(0) == 0x2d) &&	// Text sequence A
		once(prev(OnScreenTextID(0)) == 0x2d && OnScreenTextID(0) == 0x1e) &&	// Text sequence B
		once(prev(OnScreenTextID(0)) == 0xf0 && OnScreenTextID(0) == 0x78) &&	// Text sequence C
		once(prev(OnScreenTextID(0)) == 0x78 && OnScreenTextID(0) == 0x4b) &&	// Text sequence E
		once(prev(OnScreenTextID(0)) == 0xb4 && OnScreenTextID(0) == 0x4b) &&	// Text sequence D
		once(prev(OnScreenTextID(0)) == 0x78 && OnScreenTextID(0) == 0x50) &&	// Text sequence F
		once(prev(OnScreenTextID(1)) == 0x0 && OnScreenTextID(1) == 0x0040ff86) &&	// Text A
		once(prev(OnScreenTextID(5)) == 0x0 && OnScreenTextID(5) == 0x0050ffd0) &&	// Text A
		once(prev(OnScreenTextID(1)) == 0x0 && OnScreenTextID(1) == 0x0048ffc9) &&	// Text B
		once(prev(OnScreenTextID(3)) == 0x0 && OnScreenTextID(3) == 0x00480029) &&	// Text B
		once(prev(OnScreenTextID(1)) == 0x0 && OnScreenTextID(1) == 0x0040ff9e) &&	// Text E
		once(prev(OnScreenTextID(4)) == 0x0 && OnScreenTextID(4) == 0x00080009) &&	// Text E
		prior(OnScreenTextID(1)) == 0x0040ffbb 							&&	// Last text
		prior(OnScreenTextID(5)) == 0x00500045 							&&	// Last text
		prev(OnScreenTextID(0)) == 0x50},		// Last text
	// "a_Template": function Template() {},
}


// ACHIEVEMENT TITLES & DESCRIPTIONS		// IDEA: put tips behind link => somewhere on a github README.md file?
// ***********************************************************************************
_achievementTitles = {
	"a_PrologueComplete": { 						"en": "Prologue completed",															
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Chapter 1 completed",															
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},
	"a_Chapter2Complete": 							{"en": "Chapter 2 completed"},
	"a_GetOrnamentalEgg": 							{"en": "An egg?"}, 
	"a_EggCollection1": 							{"en": "Egg collection #1"},
	"a_EggCollection2": 							{"en": "Egg collection #2"}, 
	"a_IntroduceEggCollecting": 					{"en": "An interesting shape"},
	"a_EikeThePyromancer":							{"en": "Eike the pyromancer"},
	"a_EikeTheMagician": 							{"en": "Eike the magician"},
	"a_SquireOrdersFlowers": 						{"en": "Squire's orders: 'Flowers only'"},
	"a_SquireOrdersStatue":							{"en": "Squire's orders: 'No, a statue'"}, 
	"a_LostYoungCouple1": 							{"en": "Lost young couple #1"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic couple #1"},
	"a_ErasingEike": 								{"en": "That's a big no no"}, 
	"a_MetYouBefore": 								{"en": "Feels like I met you before..."},
	"a_ArtAppreciator": 							{"en": "Art appreciator"}, 
	// "a_Template": 			{"en": "xxxxx"}, 
}
_achievementDescriptions = {
	"a_PrologueComplete": {							"en": "Defied fate",															
													"nl": "Lot getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1Complete": {							"en": "Defied fate... again",															
													"nl": "Lot getrotseerd... nogmaals",
													"fr": "Défié le destin... encore"},
	"a_Chapter2Complete": 							{"en": "Defied fate, but not without loose ends"},
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from a performer during chapter 1"},
	"a_IntroduceEggCollecting": 					{"en": "Show off your egg collection to the barman's ancestor during chapter 2"},
	"a_EggCollection1": 							{"en": "Give an egg to a barman during chapter 1"},
	"a_EggCollection2": 							{"en": "Give an egg to a barman during chapter 3"},
	"a_EikeThePyromancer": 							{"en": "Use pyrokinetics to scare the crowd during chapter 2"},
	"a_EikeTheMagician": 							{"en": "Scare the crowd away with a magic box during chapter 2"},
	"a_SquireOrdersFlowers": 						{"en": "Planted flowers during chapter 2"},
	"a_SquireOrdersStatue":							{"en": "Built a statue during chapter 2"},
	"a_LostYoungCouple1": 							{"en": "Help a lost couple reunite during chapter 2 - [Tip: Talk to them twice] - [Measured: Once started, complete in same session, otherwise restart chapter]"}, 
	"a_EnigmaticCouple1": 							{"en": "Find the coated man and woman during the prologue or chapter 1 - [Tip: Talk to them twice] - [Measured: Once started, complete in same session, otherwise restart chapter]"}, 
	"a_ErasingEike": 								{"en": "Warn yourself of your impending demise during the prologue"},
	"a_MetYouBefore": 								{"en": "Keep chatting with Dana at the Marktzplats tree during chapter 2 - [Tip: Die a total of 4 times to the tree killer]"},
	"a_ArtAppreciator": 							{"en": "Admire the paintings in the Brum Museum - [Tip: Interact with all 7 paintings in the Brum Museum] - [Measured: Once started, complete in same session, otherwise restart chapter]"}, 
	// "a_Template": 			{"en": "xxxxx"},
}

// ACHIEVEMENT INITIALIZER
//	- Creates achievements based on achievement dictionary
// *************************************************************
function initializeAchievements() {
	// Generate achievement title (with developer tags if devmode == 1)
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
	// Generate achievement desciption (with extra develop information if devmode == 1)
	function generateAchievementDescription(string_achievementName, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementName, string_languageCode) {
			return _achievementDescriptions[string_achievementName][string_languageCode]
		}
		function enterDevInfo(string_devInfo) {
			let_devInfoString = ""
			if isDevModeActive() && string_devInfo != "" {
				let_devInfoString = let_devInfoString + " - {(" + string_devInfo + ")}"
			}
			return let_devInfoString
		}	
		return lookUpAchievementDescription(string_achievementName, string_languageCode) + enterDevInfo(string_devInfo)
	}
	// Return the achievement trigger 
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
				description = generateAchievementDescription(cheevmentName, let_cheevment["devInfo"], achievementLanguage),
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