// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA
 

// ************** \\
// UTIL FUNCTIONS \\
// ************** \\


// ********************** \\
// CODE NOTES & VARIABLES \\
// ********************** \\

// Timers/counters
//	- Resets at certain times or between cutscene transitions
//	- Different timers sometimes reset at different moments
// --------------------------------------------------
// $A82880: [32-bit] Timer increments by 0x400 each 2 frames
//			- Reset less than other timer
function twoFrameTimer() => dword(0xA82880)
function hasTwoFrameTimerReset() => twoFrameTimer() < prev(twoFrameTimer()) 
function hasTwoFrameTimerIncremented() => twoFrameTimer() > prev(twoFrameTimer())
// $B88AB0: [32-bit] Timer increments by 1 each frame
function oneFrameTimer() => dword(0xB88AB0)
function hasOneFrameTimerReset() => oneFrameTimer() < prev(oneFrameTimer()) 
function hasOneFrameTimerIncremented() => oneFrameTimer() > prev(oneFrameTimer())
// $B88AB8: [32-bit] Timer increments by 2 each 2 frames
// TODO Check if this memory address is used or not 

// Interaction with NPC, environment & item IDs
// --------------------------------------------
// $A9EFDC: [32-bit] Interaction ID 1
//			- Changes on interaction
//          - Doesn't reset back to a default value after interaction is done
function interactionID_1() => dword(0xA9EFDC)
// $A9EFE4: [32-bit] Interaction ID 2
//          - Resets to 0x0 when interaction is done
function interactionID_2() => dword(0xA9EFE4)
// $A9EFF4: [32-bit] NPC and item interaction ID 
// 			- Resets to 0x0 when interaction is done
//          - This ID stays the same for each NPC and item 
function interactionID_3() => dword(0xA9EFF4)

// Cutscene IDs
// 	=> Could be replaced by => Interaction with NPC, environment & item IDs
//	- Everytime you view a different cutscene, memory values around these IDs/addresses change
//	- Each unique cutscene seems to have different values
//	- Some sequences consist of multiple cutscenes
// -----------------------------------------------------------
// TODO remove this line on final version => Using: 17 - 14 - 18
_cutsceneIDs = {
	1: 0x1DF4280, // $1DF4280: [32-bit] Cutscene ID
	2: 0x1DF59B0, // $1DF59B0: [32-bit] Cutscene ID
	3: 0x1DF5F71, // $1DF5F71: [32-bit] Cutscene ID
	4: 0x1DF6724, // $1DF6724: [32-bit] Cutscene ID
	5: 0x1DF7140, // $1DF7140: [32-bit] Cutscene ID
	6: 0x1DF742A, // $1DF742A: [32-bit] Cutscene ID
	7: 0x1DF7FA2, // $1DF7FA2: [32-bit] Cutscene ID
	8: 0x1DF81E5, // $1DF81E5: [32-bit] Cutscene ID
	9: 0x1DF8229, // $1DF8229: [32-bit] Cutscene ID
	10: 0x1DF8442, // $1DF8442: [32-bit] Cutscene ID
	11: 0x1DF8B14, // $1DF8B14: [32-bit] Cutscene ID
	12: 0x1DF9362, // $1DF9362: [32-bit] Cutscene ID
	13: 0x1DF9AA4, // $1DF9AA4: [32-bit] Cutscene ID
	14: 0x1DFA0E6, // $1DFA0E6: [32-bit] Cutscene ID
	15: 0x1DFA4F8, // $1DFA4F8: [32-bit] Cutscene ID
	16: 0x1DFAC91, // $1DFAC91: [32-bit] Cutscene ID
	17: 0x1DFAD9A, // $1DFAD9A: [32-bit] Cutscene ID
	18: 0x1DFB0F0, // $1DFB0F0: [32-bit] Cutscene ID
	19: 0x1DFB22B, // $1DFB22B: [32-bit] Cutscene ID
	20: 0x1DF5A0C, // $1DF5A0C: [32-bit] Cutscene ID
	21: 0x1DF5950 // $1DF5950: [32-bit] Cutscene ID
}
function currentCutsceneId(int_cutsceneId) => dword(_cutsceneIDs[int_cutsceneId])
function priorCutsceneId(int_cutsceneId) => prior(dword(_cutsceneIDs[int_cutsceneId]))

// Chapter IDs
// ---------------------
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
	"Epilogue": 0xA
	// "Different endings": ??? // TODO Check different endings & EX chapter
	// "EX chapter": ???
}
// $B95704: [8-bit] Chapter ID
function chapterId() => byte(0xB95704)
function isCurrentChapter(string_chapter) => chapterId() == _chapterIDs[string_chapter]
function isChapterFinished(string_chapter) {
	return 
		chapterId() > prev(chapterId()) &&
		prior(chapterId()) == _chapterIDs[string_chapter] && 
		chapterId() == _chapterIDs[string_chapter]+0x1
}

// $A9F111: [8-bit] Currently selected item ID in inventory
_inventoryItemIds = {
	"OrnamentalEgg": 0x2
}
function currentSelectedItemID() => byte(0xA9F111)
function isCurrentSelectedInventoryItem(string_item) => currentSelectedItemID() == _inventoryItemIds[string_item]

// IDs for flower or statue choice in chapter 2
function flowerStatueChoiceID_1() => dword(0xAC31E8) // $AC31E8: [32-bit] ID for flower or statue choice
function flowerStatueChoiceID_2() => dword(0xAC3538) // $AC3538: [32-bit] ID for flower or statue choice
function flowerStatueChoiceID_3() => dword(0xAC3658) // $AC3658: [32-bit] ID for flower or statue choice

// $0xA9Eb2C: [bit-3] Flag -> is cutscene active
// 			- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
// 			- 1 = no cutscene active
function cutsceneFlag() => bit0(0xA9Eb2C)
function isCutsceneActive() => cutsceneFlag() == 0

// $A9F034: [bit-0] Flag -> is game running
//			- 0 = game is not running, it's in the title screen
//			- 1 = game is running
function isGameRunning() => bit0(0xA9F034) == 1


// ************ \\
// ACHIEVEMENTS \\
// ************ \\

// Variables
// ---------
_achievementLocalIDs = {
	"PrologueComplete": 1,
	{
		"id": 1
		"title": "Prologue complete", 
		"description": "Defied fate...", 
		"achievementSet": "CoreSet_MainStory", 
		"achievementCategory": "Completion"
	},
	"Chapter1Complete": {},
	"Chapter2Complete": {},
	"AcquireOrnamentalEgg": {},
	"TheBarmansEggsChapter1": {},
	"TheBarmansEggsExtra": {},
	"EikeThePyromancer": {},
	"EikeTheMagician": {},	
}
_achievementTitles = {
	1: 
}

// Divided by core set & subsets => further divided category
_achievementTriggers = {
	"CoreSet_MainStory": { // Achievement triggers related to main story completion & branching paths
		"Completion": { // Achievements related to story, chapter & different ending completion
			"PrologueComplete": function ms_c_1() {
				return 
					// Core group
					never(!isGameRunning()) &&
					never(!isCutsceneActive()) &&
					(
						( // Alt 1 => true when last prologue cutscene finishes (has been running for 2010+ frames)
							unless(!isCurrentChapter("Prologue")) &&
							repeated(2010, priorCutsceneId(16) == 0x43c58c5a) &&
							repeated(2010, priorCutsceneId(18) == 0xc58acc94) && 
							repeated(2010, priorCutsceneId(19) == 0x220000ec) &&
							repeated(2010, currentCutsceneId(16) == 0xd7e805ff) &&
							repeated(2010, currentCutsceneId(18) == 0xcedfff04) &&
							repeated(2010, currentCutsceneId(19) == 0x4a007500)					
						) || ( // Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
							isChapterFinished("Prologue")
						)
					)
			},
			"Chapter1Complete": function ms_c_2() {
				return 
					// Core group 
					never(!isGameRunning()) &&
					never(!isCutsceneActive()) &&
					( 	
						( // Alt 1 => true when last chapter cutscene finishes (has been running for 610+ frames)
							unless(!isCurrentChapter("Chapter1")) &&
							repeated(610, priorCutsceneId(14) == 0x50ff199a) && 
							repeated(610, priorCutsceneId(15) == 0x41354bf6) &&				
							repeated(610, priorCutsceneId(17) == 0x5e0000) &&
							repeated(610, currentCutsceneId(14) == 0xae99999) &&				
							repeated(610, currentCutsceneId(15) == 0x168e7af) &&				
							repeated(610, currentCutsceneId(17) == 0x800108) 
						) || ( // Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
							isChapterFinished("Chapter1")
						)
					)
			},
			"Chapter2Complete": function ms_c_3() {
				return 
					// Core group => always true
					never(!isGameRunning()) &&
					never(!isCutsceneActive()) &&
					(
						( // Alt 1 => true when last chapter cutscene is active AND oneFrameTimerHasReset 3 times
							unless(
								!isCurrentChapter("Chapter2") || 
								(
									currentCutsceneId(2) != 0x479ff42 &&
									currentCutsceneId(20) != 0xf372f766 &&
									currentCutsceneId(21) != 0x2ea0e6e5
								)
							) && 
							repeated(3, hasOneFrameTimerReset()) // Unlock achievement when cutscene is done => oneFrameTimerHasReset 3 times
						) || ( // Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
							isChapterFinished("Chapter2")
						)
					)
				
			}
		},
		"BranchingPaths": { // Achievements related to branching paths in the story
			"AcquireOrnamentalEgg": function ms_bp_1() {
				return 
					never(
						!isGameRunning() || 
						!isCutsceneActive() ||
						!isCurrentChapter("Chapter1")
					) && 
					// last cutsceneIDs run for about 380 frames
					repeated(380, priorCutsceneId(10) == 0xfffe8366) &&
					repeated(380, priorCutsceneId(13) == 0x3cd31cf) &&
					repeated(380, priorCutsceneId(15) == 0x11110597) && 
					repeated(380, currentCutsceneId(10) == 0x1ce0d25d) &&
					repeated(380, currentCutsceneId(13) == 0xc841ccb) &&
					repeated(380, currentCutsceneId(15) == 0x99991119)
			},
			"TheBarmansEggsChapter1": function ms_bp_2() {
				return 
					never(!isGameRunning()) &&
					never(!isCutsceneActive()) &&
					never(!isCurrentChapter("Chapter1")) &&
					// last cutsceneIDs run for about 4202 frames
					repeated(420, priorCutsceneId(11) == 0x4d5fc40) &&
					repeated(420, priorCutsceneId(14) == 0x55005ce) &&
					repeated(420, priorCutsceneId(16) == 0x88065620) && 
					repeated(420, currentCutsceneId(11) == 0x11111112) &&
					repeated(420, currentCutsceneId(14) == 0x30ff26b) &&
					repeated(420, currentCutsceneId(16) == 0x11d8fa)
			},
			"EikeThePyromancer": function ms_bp_3() {
				return
					// Core group => true when specific cutscene has run 270+ frames
					never(
						!isGameRunning() || 
						!isCutsceneActive() ||
						!isCurrentChapter("Chapter2")
					) &&
					repeated(270, prior(currentCutsceneId(2)) == 0x2ff955) &&	
					repeated(270, prior(currentCutsceneId(4)) == 0xe6de04a6) &&	
					repeated(270, prior(currentCutsceneId(6)) == 0x1100040a) &&
					repeated(270, currentCutsceneId(2) == 0x10111112) &&	
					repeated(270, currentCutsceneId(4) == 0xde980748) &&	
					repeated(270, currentCutsceneId(6) == 0x12480620) &&
					(
						( // Alt group 1 => true when twoFrameTimer has reset once AND incremented 1600 times
							
							disable_when(once(hasTwoFrameTimerReset()), until = always_true()) &&
							repeated(1600, hasTwoFrameTimerIncremented())
						) || ( // Alt group 2 => true when twoFrameTimer has reset twice, when whole cutscene sequence is over
							repeated(2, hasTwoFrameTimerReset())
						)
					)
			},
			"EikeTheMagician": function ms_bp_4() {
				return
					never(
						!isGameRunning() || 
						!isCutsceneActive() ||
						!isCurrentChapter("Chapter2")
					) && 
					// Cutscene has run for 1050+ frames
					repeated(1050, prior(currentCutsceneId(14)) == 0xc1f05529) &&
					repeated(1050, prior(currentCutsceneId(17)) == 0x90190290) &&
					repeated(1050, prior(currentCutsceneId(18)) == 0x66d2507) &&
					repeated(1050, currentCutsceneId(14) == 0xfed5fe0b) &&
					repeated(1050, currentCutsceneId(17) == 0x2d7ff567) &&
					repeated(1050, currentCutsceneId(18) == 0xf57d2254) &&
					// Pop achievement when twoframeTimer has incremented 1820 times without resetting 
					// ResetNextIf example
					repeated(1820, hasTwoFrameTimerIncremented() && never(hasOneFrameTimerReset())) // resets only this hitcount when never(isTrue)
			}
		}
	},			
	"Subset_SideStory": { // Achievement triggers related to side story content completion & extra/secret cutscenes
		"ExtraCutscenes": {
			"TheBarmansEggsExtra": function ss_ec_1() {
				return 
					never(!isGameRunning()) &&
					never(!isCutsceneActive()) &&					
					isCurrentSelectedInventoryItem("OrnamentalEgg") && 
					// Last cutscene stays on for about 500+ frames
					repeated(500, prior(currentCutsceneId(14)) == 0xe6df0168) &&	
					repeated(500, prior(currentCutsceneId(15)) == 0x168ec1a) &&	
					repeated(500, prior(currentCutsceneId(17)) == 0x1ca92f3c) &&
					repeated(500, currentCutsceneId(14) == 0xa90841) &&	
					repeated(500, currentCutsceneId(15) == 0x19) &&	
					repeated(500, currentCutsceneId(17) == 0x0) &&
					repeated(3, (hasOneFrameTimerReset())) // Unlock achievement when cutscene is done = oneFrameTimerHasReset 3 times
			}			
		},
		"GameOverCutscenes": {}		
	}
} 

// function getAchievementTrigger(string_achievementLocalID) {
// 	_achievementLocalIDs[string_achievementLocalID] 
// 	for key in _achievementTriggers
// }

// Story completion
achievement(title = "[Base] ", description = "Defied fate...",	points = 3,
	trigger = _achievementTriggers["CoreSet_MainStory"]["Completion"]["PrologueComplete"]
)
achievement(title = "[Base] Chapter 1 complete", description = "Defied fate... again?", points = 3, 
	trigger = _achievementTriggers["CoreSet_MainStory"]["Completion"]["Chapter1Complete"]
)
achievement(title = "[Base] Chapter 2 complete", description = "Defied fate, but not without loose ends", points = 3,
    trigger = _achievementTriggers["CoreSet_MainStory"]["Completion"]["Chapter2Complete"]
)
// Branching paths
achievement(title = "[BranchingPath] An egg?", description = "Receive a gift from a performer during chapter 1", points = 3,
	trigger = _achievementTriggers["CoreSet_MainStory"]["BranchingPaths"]["AcquireOrnamentalEgg"]
)
achievement(title = "[BranchingPath] Egg collection #1", description = "Give an egg to a barman during chapter 1", points = 5,    
    trigger = _achievementTriggers["CoreSet_MainStory"]["BranchingPaths"]["TheBarmansEggsChapter1"]
)
achievement(title = "[Extra] Eike the pyromancer", description = "Build a statue of a pyrokinetic during chapter 2", points = 2,  
    trigger = _achievementTriggers["CoreSet_MainStory"]["BranchingPaths"]["EikeThePyromancer"]
)
achievement(title = "[Extra] Eike the magician", description = "Scare the crowd away with a magic box during chapter 2", points = 2,
    trigger = _achievementTriggers["CoreSet_MainStory"]["BranchingPaths"]["EikeTheMagician"]
)
// Side content 
achievement(title = "[Extra] An interesting shape", description = "Introduce eggs to the barman's ancestor during chapter 2", points = 5, 
    trigger = _achievementTriggers["Subset_SideStory"]["ExtraCutscenes"]["TheBarmansEggsExtra"]
)
achievement(
    title = "[EXTRA] Lost young couple #1", points = 3,
    description = "Help a lost couple reunite during chapter 2 (Only completable without reloading)",
    trigger = unless((CutsceneId() != 825085588 && CutsceneId() != 3873374878 && CutsceneId() != 3303464709
               && bit0(0xA9EB2C) == 1)) && unless((CutsceneId() != 286331153 && CutsceneId() != 62062817 &&
               CutsceneId() != 1292999168 && bit0(0xA9EB2C) == 1)) && measured(tally(2, 
                  deduct(once(CutsceneId() == 825085588)), 
                  repeated(2, CutsceneId() == 825085588), 
                  deduct(once(CutsceneId() == 1292999168)), 
              CutsceneId() ==
               1292999168), when=(dword(0xB88EA4) != 0 && ChapterId() == 3))
)

// achievement(
//     title = "[Game over] Erasing, that's a big no no", points = 5,
//     description = "Warn yourself of the coming threat during the prologue",
//     id = 306883, badge = "00000", published = "5/04/2023 15:44:04", modified = "9/04/2023 8:20:54",
//     trigger = never(ChapterId() != 1) && never(bit3(0xA9EB2E) == 1) && repeated(1070, prior(CutsceneId()) ==
//                1258802389) && repeated(1070, prior(CutsceneId()) == 3758142976) && repeated(1070,
//                prior(CutsceneId()) == 2699486719) && repeated(1070, CutsceneId() == 1375953920) && 
//               repeated(1070, CutsceneId() == 1207193634) && repeated(1070, CutsceneId() == 1610506217)
// )


// ************* \\
// RICH PRESENCE \\
// ************* \\