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
// $A82880: [32-bit] Timer increments each 2 frames
//			- Reset less than other timer
function twoFrameTimer() => dword(0xA82880)
// $B88AB0: [32-bit] Timer increments each frame
function oneFrameTimer() => dword(0xB88AB0)

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
// [32-bit] Cutscene IDs
_cutsceneIds = {
	1: 0x1DF4280, // $1DF4280
	2: 0x1DF59B0, // $1DF59B0
	3: 0x1DF5F71, // $1DF5F71
	4: 0x1DF6724, // $1DF6724
	5: 0x1DF7140, // $1DF7140
	6: 0x1DF742A, // $1DF742A
	7: 0x1DF7FA2, // $1DF7FA2
	8: 0x1DF81E5, // $1DF81E5
	9: 0x1DF8229, // $1DF8229
	10: 0x1DF8442, // $1DF8442
	11: 0x1DF8B14, // $1DF8B14
	12: 0x1DF9362, // $1DF9362
	13: 0x1DF9AA4, // $1DF9AA4
	14: 0x1DFA0E6, // $1DFA0E6
	15: 0x1DFA4F8, // $1DFA4F8
	16: 0x1DFAC91, // $1DFAC91
	17: 0x1DFAD9A, // $1DFAD9A
	18: 0x1DFB0F0, // $1DFB0F0
	19: 0x1DFB22B, // $1DFB22B
	20: 0x1DF5A0C, // 1DF5A0C
	21: 0x1DF5950 // $1DF5950
}
function currentCutsceneId(int_cutsceneId) => dword(_cutsceneIds[int_cutsceneId])
function priorCutsceneId(int_cutsceneId) => prior(dword(_cutsceneIds[int_cutsceneId]))


// Chapter IDs
// ---------------------
_chapterIds = {
	"prologue": 0x1,
	"chapter1": 0x2,
	"chapter2": 0x3,
	"chapter3": 0x4,
	"chapter4": 0x5,
	"chapter5": 0x6,
	"chapter6": 0x7,
	"chapter7": 0x8,
	"chapter8": 0x9,
	"epilogue": 0xA
	// "Different endings": ??? // TODO Check different endings & EX chapter
	// "EX chapter": ???
}
// $B95704: [8-bit] Chapter ID
function chapterId() => byte(0xB95704)
function isCurrentChapter(string_chapter) => chapterId() == _chapterIds[string_chapter]
function isChapterFinished(string_chapter) => prior(chapterId()) == _chapterIds[string_chapter] && chapterId() == _chapterIds[string_chapter]+0x1

// $A9F111: [8-bit] Currently selected item ID in inventory
function currentSelectedItemID() => byte(0xA9F111)

// [32-bit] ID for flower or statue choice in chapter 2
function flowerStatueChoiceID_1() => dword(0xAC31E8) // $AC31E8
function flowerStatueChoiceID_2() => dword(0xAC3538) // $AC3538
function flowerStatueChoiceID_3() => dword(0xAC3658) // $AC3658


// $A9EB2E: [bit-3] Flag -> is cutscene active (less accurate)
// 			- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
// 			- 1 = no cutscene active
function isCutsceneActive() => bit3(0xA9EB2E) == 0
// $A9F034: [bit-0] Flag -> is game running
//			- 0 = game is not running, it's in the title screen
//			- 1 = game is running
function isGameRunning() => bit0(0xA9F034) == 1


// ************ \\
// ACHIEVEMENTS \\
// ************ \\

// Achievement triggers related to main story completion & branching paths
_mainStoryTriggers = {
	"PrologueComplete": function CoreTrigger_1() {
		return 
			// Core group
			never(!isGameRunning()) &&
			never(!isCutsceneActive()) &&
			(
				// Alt 1 => true when last prologue cutscene finishes (has been running for 2010 frames)
				(
					unless(!isCurrentChapter("prologue")) &&
					repeated(2010, priorCutsceneId(16) == 0x43c58c5a) &&
					repeated(2010, priorCutsceneId(18) == 0xc58acc94) && 
					repeated(2010, priorCutsceneId(19) == 0x220000ec) &&
					repeated(2010, currentCutsceneId(16) == 0xd7e805ff) &&
					repeated(2010, currentCutsceneId(18) == 0xcedfff04) &&
					repeated(2010, currentCutsceneId(19) == 0x4a007500)					
				) ||
				// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				(isChapterFinished("prologue"))
			)},
	"Chapter1Complete": function CoreTrigger_2() {
		return 
			// Core group 
			never(!isGameRunning()) &&
			never(!isCutsceneActive()) &&
			( 	
				// Alt 1 => true when last chapter cutscene finishes (has been running for 610 frames)
				(
					unless(!isCurrentChapter("chapter1")) &&
					repeated(610, priorCutsceneId(14) == 0x50ff199a) && 
					repeated(610, priorCutsceneId(15) == 0x41354bf6) &&				
					repeated(610, priorCutsceneId(17) == 0x5e0000) &&
					repeated(610, currentCutsceneId(14) == 0xae99999) &&				
					repeated(610, currentCutsceneId(15) == 0x168e7af) &&				
					repeated(610, currentCutsceneId(17) == 0x800108) 
				) ||
				// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				(isChapterFinished("chapter1"))
			)},
	"Chapter2Complete": function CoreTrigger_3() {
		return 
			// Core group => always true
			never(!isGameRunning()) &&
			never(!isCutsceneActive()) &&
			(
				// Alt 1 => true when last chapter cutscene finishes (has been running for 610 frames)
				(
					unless(!isCurrentChapter("chapter2")) &&
					unless(
						currentCutsceneId(2) == 0x479ff42 &&
						currentCutsceneId(20) == 0xf372f766 &&
						currentCutsceneId(21) == 0x2ea0e6e5
						) && 
					repeated(3, oneFrameTimer() < prev(oneFrameTimer()))
				) ||
				// Alt 2 => true when chapter changes to the next. Safety for when cutscene would be skipped, but first playthrough is never skippable
				(isChapterFinished("chapter2"))
			)}
}

// Achievement triggers related to side story content completion & extra/secret cutscenes
_sideStoryTriggers = {
	"TheBarmansEggsExtra": function Sub1Trigger_1() {
		return true
			// never(ChapterId() != 3) && never(bit3(0xA9EB2E) < prior(bit3(0xA9EB2E))) && repeated(420,
            //    CutsceneId() == 4291690652) && repeated(420, CutsceneId() == 11077697) && repeated(420,
            //    CutsceneId() == 843251806) && CurrentlySelectedItemInInventory() == 2 && bit3(0xA9EB2E) > prev(bit3(0xA9EB2E))
	}
}

// Divided by subset
_achievementTriggers = {
	"MainStory": _mainStoryTriggers,
	"SideStory": _sideStoryTriggers
}

// Main story achievements
// -----------------------
achievement(title = "[Base] Prologue complete", description = "Defied fate...",	points = 3,
	trigger = _achievementTriggers["MainStory"]["PrologueComplete"]
)
achievement(title = "[Base] Chapter 1 complete", description = "Defied fate... again?", points = 3, 
	trigger = _achievementTriggers["MainStory"]["Chapter1Complete"]
)
achievement(title = "[Base] Chapter 2 complete", description = "Defied fate, but not without loose ends", points = 3,
    trigger = _achievementTriggers["MainStory"]["Chapter2Complete"]
)

// Side story achievements
achievement(title = "[Extra] An interesting shape", description = "Introduce the barman's ancestor to eggs during chapter 2", points = 5, 
    trigger = _achievementTriggers["SideStory"]["TheBarmansEggsExtra"]
)


// ************* \\
// RICH PRESENCE \\
// ************* \\