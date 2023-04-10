// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA

// ********* \\
// VARIABLES \\
// ********* \\


// ************** \\
// UTIL FUNCTIONS \\
// ************** \\


// ********** \\
// CODE NOTES \\
// ********** \\

// TIMERS
// ------

// $A82880: [32-bit] Timer increments each 2 frames
//          - Resets at certain cutscenes or between cutscene transitions
//          - Reset less than other timers
        function Get2FrameTimer() => dword(0xA82880)

// $B88AB0: [32-bit] Timer increments each frame
//          - Resets at certain times or between cutscene transitions
        function Get1FrameTimer() => dword(0xB88AB0)


// INTERACTION & NPC IDENTIFIERS
// -----------------------------

// $A9EFDC: [32-bit] Interaction ID 1
//          - Changes on interaction
//          - Doesn't reset back to a "NULL" value, after interaction is done
        function GetInteractionID_1() => dword(0xA9EFDC)

// $A9EFE4: [32-bit] Interaction ID 2
//          - Resets to 0x0 when interaction is done
        function GetInteractionID_2() => dword(0xA9EFE4)

// $A9EFF4: [32-bit] NPC and item interaction ID 
//          - Resets to 0x0 when interaction is done
//          - This ID stays the same for each NPC and item 
        function GetInteractionID_3() => dword(0xA9EFF4)

// $A9F111: [8-bit] Currently selected item in inventory
function CurrentlySelectedItemInInventory() => byte(0xA9F111)

// $AC31E8: [32-bit] UI- Flowers or statue choice
function UiFlowersOrStatueChoice() => dword(0xAC31E8)

// $AC3538: [32-bit] UI- Flowers or statue choice
function UiFlowersOrStatueChoice() => dword(0xAC3538)

// $AC3658: [32-bit] UI- Flowers or statue choice
function UiFlowersOrStatueChoice() => dword(0xAC3658)

// $B88AB0: [32-bit] Timer increments each frame
//          - Resets at certain times or between cutscene transitions
function TimerIncrementsEachFrame() => dword(0xB88AB0)

// $B95704: [8-bit] Chapter ID
//          - 0x1 = Prologue
//          - 0x2 = Chapter 1
//          - 0x3 = Chapter 2
//          - 0x4 = Chapter 3
//          - 0x5 = Chapter 4
//          - 0x6 = Chapter 5
//          - 0x7 = Chapter 6
//          - 0x8 = Chapter 7
//          - 0x9 = Chapter 8
//          - 0xa = Epilogue??
//          - 0xb = EX???
function ChapterId() => byte(0xB95704)

// $1DF4280: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF4280)

// $1DF59B0: [32-bit] Cutscene ID
//           - Everytime you view a different cutscene, memory values around these IDs/addresses change
//           - Each unique cutscene seems to have different values
//           - Some sequences consist of multiple cutscenes
function CutsceneId() => dword(0x1DF59B0)

// $1DF5F71: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF5F71)

// $1DF6724: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF6724)

// $1DF7140: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF7140)

// $1DF742A: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF742A)

// $1DF7FA2: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF7FA2)

// $1DF81E5: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF81E5)

// $1DF8229: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF8229)

// $1DF8442: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF8442)

// $1DF8B14: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF8B14)

// $1DF9362: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF9362)

// $1DF9AA4: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DF9AA4)

// $1DFA0E6: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFA0E6)

// $1DFA4F8: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFA4F8)

// $1DFAC91: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFAC91)

// $1DFAD9A: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFAD9A)

// $1DFB0F0: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFB0F0)

// $1DFB22B: [32-bit] Cutscene ID
function CutsceneId() => dword(0x1DFB22B)


// ************ \\
// ACHIEVEMENTS \\
// ************ \\


// ************* \\
// RICH PRESENCE \\
// ************* \\