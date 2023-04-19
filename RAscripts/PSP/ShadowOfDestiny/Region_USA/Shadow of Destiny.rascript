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
//	- Each unique cutscene seems to have different values
//	- Some sequences consist of multiple cutscenes
_cutsceneIDs = {		//  
	1: 0x1DF4280, 		// $1DF4280: [32-bit] Cutscene ID 
	2: 0x1DF59B0, 		// $1DF59B0: [32-bit] Cutscene ID
	3: 0x1DF5F71, 		// $1DF5F71: [32-bit] Cutscene ID
	4: 0x1DF6724, 		// $1DF6724: [32-bit] Cutscene ID
	5: 0x1DF6F60, 		// $1DF6F60: [32-bit] Cutscene ID
	6: 0x1DF742A, 		// $1DF742A: [32-bit] Cutscene ID
	7: 0x1DF7FA2, 		// $1DF7FA2: [32-bit] Cutscene ID // Unused
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
function isCurrentChapter(string_chapter) => chapterId() == _chapterIDs[string_chapter]
function isChapterFinished(string_chapter) { return 
	prev(chapterId()) == _chapterIDs[string_chapter] &&
	chapterId() == _chapterIDs[string_chapter] + 0x1}


// INVENTORY LOGIC 
// *****************
_inventoryItemIds = { 
	"D-pad": 0x0, // PSP version this is called Z-Pad
	"OrnamentalEgg": 0x2,
	"Cellphone": 0x1,
	"FryingPan": 0x4,
	"Sign": 0x5,
	"Lighter": 0x6,
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
currentCutsceneId(11)
function onScreenTextID(int_id) => dword(_onScreenTextID[int_id])

// OTHER LOGIC
// *************
function energyUnitsZPad() => byte(0xA9DAA8)	// $A9DAA8: Number of energy units in possession 
												//		- Used for the time travel machine (Z-Pad)
												//		- Min => 0x0 		Max => 0x0a
function isCutsceneActive() => bit0(0xA9Eb2C) == 0	// $A9Eb2C: [bit-0] Flag -> is cutscene active
													//		- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
													//		- 1 = no cutscene active
function isCutsceneFinished() => prior(bit0(0xA9Eb2C)) == 0
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
		// TODO "a_Chapter5Complete": {
		//	"id": 310162, "points": 5, "hasTips": false,
		//	"devInfo": "Complete chapter 5"},
		// TODO "a_Chapter6Complete": {
		//	"id": 000000, "points": 5, "hasTips": false,
		// 	"devInfo": "Complete chapter 6"},
		// TODO "a_Chapter7Complete": {
		//	"id": 000000, "points": 5, "hasTips": false,
		// 	"devInfo": "Complete chapter 7"},
		// TODO "a_Chapter8Complete": { // TODO check if this is double with endings
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Complete chapter 8"},
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
		// TODO "a_BecomeThePerformer": { // CONCEPT also finish chapter 4 when this is done => chapter 4 ending cutscene has extra stuff
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
		// TODO "a_EndingA": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending A: Margarette (Ancestress) => Homunculus => Town Square"},
		// TODO "a_EndingB1": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending B1: Margarette (Ancestress) => Homunculus => Town Square"},
		// TODO "a_EndingB2": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending B2: Margarette (Ancestress) => Fortuneteller => Town Square"},
		// TODO "a_EndingC": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		// TODO "a_EndingD": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		// TODO "a_EndingE": {	
		//	"id": 000000, "points": 10, "hasTips": false,
		// 	"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => Destroyed Lab"},
	},
	"c_Extra": { // Category - Extra side content & cutscenes
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
		"a_ArtAppreciator": { // WORKING 		// TODO check if this cheevo is completable in other chapters
			"id": 307499, "points": 4, "hasTips": true,
			"devInfo": "Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor"}, 
		 "a_AntiquesEule": { // WORKING 		// TODO choices in chapter 4 => change relics in chapter 6
			"id": 310132, "points": 3, "hasTips": true,
			"devInfo": "Visit 'Antique shop Eule' and interact with all original relics, Shop is open in chapter 3, 4 and 6 (1980)"},
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
		"a_LostYoungCouple1": { // WORKING
			"id": 306984, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in 1580 during chapter 2"},
		"a_LostYoungCouple2": { // WORKING
			"id": 310133, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in 1580 during chapter 3"},
		"a_LostYoungCouple3": {
			"id": 309393, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in 1580 during chapter 4"},
		// TODO "a_FindAllEnergyOrbsInaMap": { // CONCEPT Find all memory orbs in a map, EZ is Chapter 3 => this guide contains locations of each energy unit location: https://gamefaqs.gamespot.com/psp/977639-shadow-of-destiny/faqs/14255
		//	"id": 000000, "points": 0000000, "hasTips": false,
		//	"devInfo": "Find all energy orbs "}, 
	},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to PC dying or game over screen
		"a_MetYouBefore": {  // WORKING
			"id": 306888, "points": 5, "hasTips": true,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_ErasingEike": { // WORKING
			"id": 306883, "points": 5, "hasTips": true,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
		"a_ExcuseMeMyMy": { // WORKING 
			"id": 306919, "points": 1, "hasTips": true,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
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
	"a_Chapter3Complete": function Chapter3Complete() { return
		// Core group 
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
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
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		never(!isGameRunning()) 	&&
		never(!isCutsceneActive()) 	&&
		(isCurrentSelectedInventoryItem("Sign") || isCurrentSelectedInventoryItem("FryingPan")) && 
		never(!isCurrentChapter("Chapter4")) &&
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
	"a_EggCollection1": function EggCollection1() { return		 
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
		never(!isGameRunning() || !isCutsceneActive()) &&
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

		isCurrentSelectedInventoryItem("OrnamentalEgg") && 	// Is currently selected item the 'OrnamentalEgg'
		repeated(500, prior(currentCutsceneId(14)) == 0xe6df0168) 	&&	// this block => last cutscene has run for about 380 frames
		repeated(500, prior(currentCutsceneId(15)) == 0x168ec1a) 	&&
		repeated(500, prior(currentCutsceneId(17)) == 0x1ca92f3c) 	&&
		repeated(500, currentCutsceneId(14) == 0xa90841) 			&&
		repeated(500, currentCutsceneId(15) == 0x19) 				&&
		repeated(500, currentCutsceneId(17) == 0x0) 				&&

		repeated(3, (hasOneFrameTimerReset()))}, // Unlock achievement when cutscene is done = oneFrameTimerHasReset 3 times
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
				!isGameRunning() || 
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
				!isGameRunning() || 
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
			!isGameRunning() || 
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
			isGameRunning()}								// frames where both these comparisons are true. So this hit counts fixes that
		// Trigger 
		return 
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
			isCutsceneFinished() &&
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
			isGameRunning()}								// frames where both these comparisons are true. So this hit counts fixes that
		// Trigger 
		return 
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
			isCutsceneFinished() &&
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
			isGameRunning()}								// frames where both these comparisons are true. So this hit counts fixes that
		// Trigger 
		return 
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
			isCutsceneFinished() &&
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
			isCutsceneFinished() &&
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
		function measuredIfComparison() => isGameRunning() && repeated(100, isCurrentChapter("Chapter3"))
		// Trigger
		return  
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
			isCutsceneFinished() &&
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
		function measuredIfComparison() => isGameRunning() && repeated(100, isCurrentChapter("Chapter4"))
		// Trigger
		return  
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
			isCutsceneFinished() &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		// Private functions
		function measuredComparison() { return
			tally(3, [													// 			= 3
				once(interactionID_2() == 0x08a30b5c),					// Add hit: +1	=> for talking to man 1st time
				once(interactionID_2() == 0x08a30b70),					// Add hit: +1 	=> for talking to man 2nd time
				once(interactionID_2() == 0x08a30c9c),					// Add hit: +1	=> for talking to woman 
			])}
		function measuredIfComparison() => isGameRunning() && repeated(100, isCurrentChapter("Chapter5"))
		// Trigger
		return  
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
			repeated(100, isCurrentChapter("Chapter3")) && 		// Hit count 100 => when loading another save to another chapter, there's a few							 
			isGameRunning()}									// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that	
		// Trigger 
		return 
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
			isCutsceneFinished() &&
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
			isGameRunning() && 
			(
				repeated(100, isCurrentChapter("Chapter3")) || 	// Hit count 100 => when loading another save to another chapter, there's a few 
				repeated(100, isCurrentChapter("Chapter4"))	||	// frames where both this comparison && isGameRunning() is true. So this hit counts fixes that
				repeated(100, isCurrentChapter("Chapter6"))	
			)}
		// Trigger 
		return 
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
			isCutsceneFinished() && 
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
		prev(onScreenTextID(0)) == 0x50},		// Last text
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return 
		never(
			!isGameRunning() 	||
			!isCutsceneActive() ||
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
		)},
	// "a_Template": function Template() {},
}


// ACHIEVEMENT TITLES & DESCRIPTIONS
// ***********************************************************************************
_achievementTitles = {
	"a_PrologueComplete": { 						"en": "Complete the prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Complete chapter 1",
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},
	"a_Chapter2Complete": 							{"en": "Complete chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete chapter 4, using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete chapter 4, using a sign"},	
	"a_DoctorateTimeTraveling": 					{"en": "Doctorate in time shifting"}, 
	"a_GetOrnamentalEgg": 							{"en": "An egg?"}, 
	"a_EggCollection1": 							{"en": "Egg collection #1"},
	"a_EggCollection2": 							{"en": "Egg collection #2"}, 
	"a_IntroduceEggCollecting": 					{"en": "An interesting shape"},
	"a_EikeThePyromancer":							{"en": "Eike the pyromancer"},
	"a_EikeTheMagician": 							{"en": "Eike the magician"},
	"a_EikeTheFlorist": 							{"en": "Eike the florist"},
	"a_LostYoungCouple1": 							{"en": "Reunion, part 1"},
	"a_LostYoungCouple2": 							{"en": "Reunion, part 2"},
	"a_LostYoungCouple3": 							{"en": "Reunion"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic couple #1"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic couple #2"}, 
	"a_EnigmaticCouple3": 							{"en": "Enigmatic couple #3"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic couple #4"},	
	"a_ErasingEike": 								{"en": "That's a big no no"}, 
	"a_MetYouBefore": 								{"en": "Feels like I met you before..."},
	"a_ArtAppreciator": 							{"en": "Art appreciator"}, 
	"a_AntiquesEule": 								{"en": "'Historically' important artifacts"},
	"a_ExcuseMeMyMy":								{"en": "My my, died again..."},
	// "a_Template": 			{"en": "xxxxx"}, 
}
_achievementDescriptions = {
	"a_PrologueComplete": {							"en": "Defied fate",															
													"nl": "Lot getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1Complete": {							"en": "Defied fate... again",															
													"nl": "Lot getrotseerd... nogmaals",
													"fr": "Défié le destin... encore"},
	"a_Chapter2Complete": 							{"en": "Defied fate, but left a loose ends"},
	"a_Chapter3Complete": 							{"en": "The devil, a red stone and an alchemist"},
	"a_Chapter4CompletePan": 						{"en": "Saved by an iron skillet"},
	"a_Chapter4CompleteSign": 						{"en": "Saved by an artist's sign"},
	"a_DoctorateTimeTraveling": 					{"en": "Take a picture in a costume during chapter 4 and finish the chapter"}, 
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from a performer during chapter 1"},
	"a_IntroduceEggCollecting": 					{"en": "Show off your egg collection to the barman's ancestor during chapter 2"},
	"a_EggCollection1": 							{"en": "Give an ornamental egg to a barman during chapter 1"},
	"a_EggCollection2": 							{"en": "Give an ornamental egg to a barman during chapter 3 or 4"},
	"a_EikeThePyromancer": 							{"en": "Become honored as a pyrokinetic during chapter 2"},
	"a_EikeTheMagician": 							{"en": "Become honored as a magician during chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Planted flowers during chapter 2"},
	"a_LostYoungCouple1": 							{"en": "Help a lost couple reunite during chapter 2"}, 
	"a_LostYoungCouple2": 							{"en": "Help a lost couple reunite again during chapter 3"},
	"a_LostYoungCouple3": 							{"en": "Reunite the lost couple during chapter 4"},
	"a_EnigmaticCouple1": 							{"en": "Find the coated man and woman during the prologue or chapter 1"}, 
	"a_EnigmaticCouple2": 							{"en": "Find the coated man and woman during chapter 3"}, 
	"a_EnigmaticCouple3": 							{"en": "Find the coated man and woman during chapter 4"}, 
	"a_EnigmaticCouple4": 							{"en": "Find the coated man and woman during chapter 5"},	
	"a_ErasingEike": 								{"en": "Warn yourself of your impending demise during the prologue"},
	"a_MetYouBefore": 								{"en": "Keep chatting with Dana at the Marktzplats tree during chapter 2"},
	"a_ArtAppreciator": 							{"en": "Admire all the paintings in the Brum Museum"},
	"a_AntiquesEule": 								{"en": "Visit Antique Shop Eule and glance at the original relics"},
	"a_ExcuseMeMyMy":								{"en": "Run from the apparition during chapter 3"}, 
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
			if(boolean_hasTips == true) let_tipsLink = " - [Tips available: " + achievementGuideLink + "]"
			return let_tipsLink 
		}
		return lookUpAchievementDescription(string_achievementName, string_languageCode) + enterTipsLink(boolean_hasTips) + enterDevInfo(string_devInfo) 
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