// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA

// $A82880: [32-bit] Timer
//          - Resets at certain times cutscenes or between cutscene transitions
//          - Reset less than the other timers
function Timer() => dword(0xA82880)

// $A9EFDC: [32-bit] Correlates to interaction ID
//          - Changes on interaction
//          - Doesn't reset
function CorrelatesToInteractionId() => dword(0xA9EFDC)

// $A9EFE4: [32-bit] Correlates with interaction ID
//          - Resets to 0x0 when interaction is done
function CorrelatesWithInteractionId() => dword(0xA9EFE4)

// $A9EFF4: [32-bit] NPC and environment interaction ID
//          - Resets to 0x0 when interaction is done
function NpcAndEnvironmentInteractionId() => dword(0xA9EFF4)

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

achievement(
    title = "[Extra] Eike the florist", points = 1,
    description = "Planted flowers during chapter 2",
    id = 306920, badge = "00000", published = "5/04/2023 22:23:23", modified = "8/04/2023 14:51:46",
    trigger = never(ChapterId() != 3) && bit3(0xA9EB2E) == 0 && CurrentlySelectedItemInInventory() == 15 && prior(CutsceneId()) ==
               2191938978 && prior(CutsceneId()) == 1386578109 && prior(CutsceneId()) == 2877292548 && 
              CutsceneId() == 82966958 && CutsceneId() == 732 && CutsceneId() == 1812383488 &&
              (always_false() || (prior(UiFlowersOrStatueChoice()) == 4194143 && prior(UiFlowersOrStatueChoice()) == 5243043 && prior(UiFlowersOrStatueChoice()) ==
                 5308394 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0))
)

achievement(
    title = "[Todo - extra] Art enthusiast", points = 0,
    description = "Check if unlockable in other chapters______View all pieces of art at the Brum museum during chapter 3",
    id = 307499, badge = "00000", published = "9/04/2023 11:10:41", modified = "9/04/2023 11:10:41",
    trigger = unless((CorrelatesToInteractionId() != 146380092 && CorrelatesWithInteractionId() != 144908804 && NpcAndEnvironmentInteractionId() != 356 &&
               bit0(0xA9EB2C) == 1)) && unless((CorrelatesWithInteractionId() != 144908864 && CorrelatesToInteractionId() != 146380104 &&
               NpcAndEnvironmentInteractionId() != 357 && bit0(0xA9EB2C) == 1)) && unless((CorrelatesToInteractionId() != 146380140 &&
               CorrelatesWithInteractionId() != 144908924 && NpcAndEnvironmentInteractionId() != 358 && bit0(0xA9EB2C) == 1)) && 
              unless((CorrelatesToInteractionId() != 146380128 && CorrelatesWithInteractionId() != 144908984 && NpcAndEnvironmentInteractionId() != 359 &&
               bit0(0xA9EB2C) == 1)) && unless((CorrelatesToInteractionId() != 146380092 && CorrelatesWithInteractionId() != 144909024 &&
               NpcAndEnvironmentInteractionId() != 360 && bit0(0xA9EB2C) == 1)) && unless((CorrelatesToInteractionId() != 146380152 &&
               CorrelatesWithInteractionId() != 144909084 && NpcAndEnvironmentInteractionId() != 361 && bit0(0xA9EB2C) == 1)) && 
              unless((CorrelatesToInteractionId() != 146380164 && CorrelatesWithInteractionId() != 144909124 && NpcAndEnvironmentInteractionId() != 362 &&
               bit0(0xA9EB2C) == 1)) && measured(tally(7, 
                  once(NpcAndEnvironmentInteractionId() == 356), 
                  once(NpcAndEnvironmentInteractionId() == 357), 
                  once(NpcAndEnvironmentInteractionId() == 359), 
                  once(NpcAndEnvironmentInteractionId() == 358), 
                  once(NpcAndEnvironmentInteractionId() == 360), 
                  once(NpcAndEnvironmentInteractionId() == 361), 
                  deduct(repeated(6, NpcAndEnvironmentInteractionId() == 362)), 
              NpcAndEnvironmentInteractionId() == 362), when=(bit0(0xA9F034) == 1 &&
               ChapterId() == 4))
)

achievement(
    title = "[Extra] Enigmatic couple #1", points = 5,
    description = "Find the coated man and woman during the prologue or chapter 1",
    id = 307495, badge = "00000", published = "9/04/2023 8:08:50", modified = "9/04/2023 8:20:53",
    trigger = unless((CutsceneId() != 375056095 && CutsceneId() != 3218933777 && CutsceneId() != 8388881 &&
               bit0(0xA9EB2C) == 1)) && unless((CutsceneId() != 4177789088 && CutsceneId() != 1638673 &&
               CutsceneId() != 32798694 && bit0(0xA9EB2C) == 1)) && measured(tally(2, 
                  deduct(once(CutsceneId() == 375056095)), 
                  repeated(2, CutsceneId() == 375056095), 
                  deduct(once(CutsceneId() == 32798694)), 
              CutsceneId() ==
               32798694), when=(dword(0xB88EA4) != 0 && ChapterId() == 1))
)

achievement(
    title = "[Extra] An interesting shape", points = 5,
    description = "Introduce the barman's ancestor to egg collecting during chapter 2",
    id = 307023, badge = "00000", published = "6/04/2023 20:16:21", modified = "9/04/2023 8:20:53",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) < prior(bit3(0xA9EB2E))) && repeated(420,
               CutsceneId() == 4291690652) && repeated(420, CutsceneId() == 11077697) && repeated(420,
               CutsceneId() == 843251806) && CurrentlySelectedItemInInventory() == 2 && bit3(0xA9EB2E) > prev(bit3(0xA9EB2E))
)

achievement(
    title = "[EXTRA] Lost young couple #1", points = 3,
    description = "Help a lost couple reunite during chapter 2 (Only completable without reloading)",
    id = 306984, badge = "00000", published = "6/04/2023 16:26:09", modified = "9/04/2023 8:20:53",
    trigger = unless((CutsceneId() != 825085588 && CutsceneId() != 3873374878 && CutsceneId() != 3303464709
               && bit0(0xA9EB2C) == 1)) && unless((CutsceneId() != 286331153 && CutsceneId() != 62062817 &&
               CutsceneId() != 1292999168 && bit0(0xA9EB2C) == 1)) && measured(tally(2, 
                  deduct(once(CutsceneId() == 825085588)), 
                  repeated(2, CutsceneId() == 825085588), 
                  deduct(once(CutsceneId() == 1292999168)), 
              CutsceneId() ==
               1292999168), when=(dword(0xB88EA4) != 0 && ChapterId() == 3))
)

achievement(
    title = "[BranchingPath] Egg collection #1", points = 5,
    description = "Give an egg to a barman during chapter 1",
    id = 306977, badge = "00000", published = "6/04/2023 11:45:22", modified = "8/04/2023 14:48:38",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) && repeated(420, prior(CutsceneId()) ==
               81132608) && repeated(420, prior(CutsceneId()) == 89130446) && repeated(420, prior(CutsceneId())
               == 2282116640) && repeated(420, CutsceneId() == 286331154) && repeated(420, CutsceneId() ==
               51376747) && repeated(420, CutsceneId() == 1169658)
)

achievement(
    title = "[BranchingPath] Egg collection #2", points = 5,
    description = "Give an egg to a barman during chapter 3",
    id = 306976, badge = "00000", published = "6/04/2023 11:45:22", modified = "8/04/2023 14:48:38",
    trigger = never(ChapterId() != 4) && never(bit3(0xA9EB2E) == 1) && repeated(500, prior(CutsceneId()) ==
               1759459584) && repeated(500, prior(CutsceneId()) == 6374) && repeated(500, prior(CutsceneId()) ==
               107157922) && repeated(500, CutsceneId() == 3573197306) && repeated(500, CutsceneId() == 8126348) && 
              repeated(500, CutsceneId() == 4280289740)
)

achievement(
    title = "[Base] Chapter 2 complete", points = 3,
    description = "Third time's the charm...",
    id = 306922, badge = "00000", published = "5/04/2023 22:42:49", modified = "9/04/2023 8:20:53",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) &&
              ((unless((CutsceneId() != 75104066 && dword(0x1DF5950) != 782296805 && dword(0x1DF5A0C) !=
                 4084397926)) && repeated(4, TimerIncrementsEachFrame() < prev(TimerIncrementsEachFrame()))) ||
               (prior(ChapterId()) == 3))
)

achievement(
    title = "[Extra] Eike the pyromancer", points = 1,
    description = "Build a statue of a pyrokinetic during chapter 2",
    id = 306921, badge = "00000", published = "5/04/2023 22:23:24", modified = "5/04/2023 22:42:50",
    trigger = unless(bit3(0xA9EB2E) == 1) && repeated(2200, prior(dword(0x1DFB3D3)) == 2802549769) && repeated(2050,
               prior(dword(0x1DFB3E9)) == 648012) && repeated(2010, prior(dword(0x1DFCD24)) == 165666817) && 
              repeated(2200, dword(0x1DFB3D3) == 3200043017) && repeated(2050, dword(0x1DFB3E9) == 647395) && 
              repeated(2010, dword(0x1DFCD24) == 165665112) &&
              (always_false() || (repeated(1100, Timer() > prev(Timer()) && never(Timer() <
                 prev(Timer())))))
)

achievement(
    title = "[Game over] Erasing, that's a big no no", points = 5,
    description = "Warn yourself of the coming threat during the prologue",
    id = 306883, badge = "00000", published = "5/04/2023 15:44:04", modified = "9/04/2023 8:20:54",
    trigger = never(ChapterId() != 1) && never(bit3(0xA9EB2E) == 1) && repeated(1070, prior(CutsceneId()) ==
               1258802389) && repeated(1070, prior(CutsceneId()) == 3758142976) && repeated(1070,
               prior(CutsceneId()) == 2699486719) && repeated(1070, CutsceneId() == 1375953920) && 
              repeated(1070, CutsceneId() == 1207193634) && repeated(1070, CutsceneId() == 1610506217)
)

achievement(
    title = "[Extra] Eike the sculptor enthusiast", points = 1,
    description = "Built a statue during chapter 2",
    id = 306919, badge = "00000", published = "5/04/2023 22:23:23", modified = "8/04/2023 14:52:04",
    trigger = never(ChapterId() != 3) && bit3(0xA9EB2E) == 0 && CurrentlySelectedItemInInventory() == 15 && prior(CutsceneId()) ==
               2191938978 && prior(CutsceneId()) == 1386578109 && prior(CutsceneId()) == 2877292548 && 
              CutsceneId() == 82966958 && CutsceneId() == 732 && CutsceneId() == 1812383488 &&
              (always_false() || (prior(UiFlowersOrStatueChoice()) == 5242857 && prior(UiFlowersOrStatueChoice()) == 4259680 && prior(UiFlowersOrStatueChoice()) ==
                 5177506 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0))
)

achievement(
    title = "[Extra] Eike the pyromancer", points = 1,
    description = "Scare the crowd away using pyrokinetic projection during chapter 2",
    id = 306911, badge = "00000", published = "5/04/2023 19:43:29", modified = "8/04/2023 14:51:46",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(270, prior(CutsceneId()) ==
               3144021) && repeated(270, prior(CutsceneId()) == 3873309862) && repeated(270, prior(CutsceneId())
               == 285213706) && repeated(270, CutsceneId() == 269553938) && repeated(270, CutsceneId() ==
               3734505288) && repeated(270, CutsceneId() == 306710048) &&
              ((repeated(1600, Timer() > prev(Timer()) && never(Timer() <
                 prev(Timer())))) ||
               (repeated(2, Timer() < prev(Timer()))))
)

achievement(
    title = "[Extra] Eike the magician", points = 1,
    description = "Scare the crowd away with a magic box during chapter 2",
    id = 306906, badge = "00000", published = "5/04/2023 19:28:48", modified = "8/04/2023 14:51:45",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(1050, prior(CutsceneId()) ==
               2417558160) && repeated(1050, prior(CutsceneId()) == 3253753129) && repeated(1050,
               prior(CutsceneId()) == 107816199) && repeated(1050, CutsceneId() == 763360615) && repeated(1050,
               CutsceneId() == 4275437067) && repeated(1050, CutsceneId() == 4118618708) && repeated(1820,
               Timer() > prev(Timer()) && never(Timer() < prev(Timer())))
)

achievement(
    title = "[Extra - Game over] Feels like I met you before...", points = 5,
    description = "Keep chatting with Dana at the Marktplatz tree 4 times during chapter 2",
    id = 306888, badge = "00000", published = "5/04/2023 18:19:09", modified = "9/04/2023 0:01:45",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(1500, prior(dword(0x1DFD287)) ==
               627048504) && repeated(1500, prior(dword(0x1DFD424)) == 3097296896) && repeated(1500,
               prior(dword(0x1DFDD14)) == 952197120) && repeated(1500, dword(0x1DFD287) == 771752120) && repeated(1500,
               dword(0x1DFD424) == 3098976256) && repeated(1500, dword(0x1DFDD14) == 957382656) && repeated(2,
               Timer() < prev(Timer()))
)

achievement(
    title = "[Base] Chapter 1 complete", points = 3,
    description = "Defied fate... again?",
    id = 306886, badge = "00000", published = "5/04/2023 15:44:05", modified = "9/04/2023 8:20:53",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) &&
              ((repeated(610, prior(CutsceneId()) == 1094011894) && repeated(610, prior(CutsceneId()) ==
                 1358895514) && repeated(610, prior(CutsceneId()) == 6160384) && repeated(610, CutsceneId() ==
                 23652271) && repeated(610, CutsceneId() == 183081369) && repeated(610, CutsceneId() == 8388872)) ||
               (prior(ChapterId()) == 2))
)

achievement(
    title = "[BranchingPath] An egg?", points = 5,
    description = "Receive a gift from a performer during chapter 1",
    id = 306885, badge = "00000", published = "5/04/2023 15:44:04", modified = "8/04/2023 14:51:45",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) && repeated(400, prior(CutsceneId()) ==
               63779279) && repeated(400, prior(CutsceneId()) == 286328215) && repeated(400, prior(CutsceneId())
               == 4294869862) && repeated(400, CutsceneId() == 209984715) && repeated(400, CutsceneId() ==
               2576945433) && repeated(400, CutsceneId() == 484495965)
)

achievement(
    title = "[Base] Prologue complete", points = 3,
    description = "Defied fate...",
    id = 306884, badge = "00000", published = "5/04/2023 15:44:04", modified = "9/04/2023 8:20:53",
    trigger = never(ChapterId() != 1) && never(bit3(0xA9EB2E) == 1) &&
            (
                (repeated(2010, prior(CutsceneId()) == 3314207892) && repeated(2010, prior(CutsceneId()) ==
                 570425580) && repeated(2010, prior(CutsceneId()) == 1137019994) && repeated(2010, CutsceneId()
                 == 3470786308) && repeated(2010, CutsceneId() == 1241543936) && repeated(2010, CutsceneId() ==
                 3622307327)) ||
               (prior(ChapterId()) == 1)
            )

)

achievement(
    title = "[Game over] Erasing, that's a big no no", points = 5,
    description = "Warn yourself of the coming threat during the prologue",
    trigger = never(ChapterId() != 1) && never(bit3(0xA9EB2E) == 1) && repeated(1070, prior(CutsceneId()) ==
               1258802389) && repeated(1070, prior(CutsceneId()) == 3758142976) && repeated(1070,
               prior(CutsceneId()) == 2699486719) && repeated(1070, CutsceneId() == 1375953920) && 
              repeated(1070, CutsceneId() == 1207193634) && repeated(1070, CutsceneId() == 1610506217)
)

achievement(
    title = "[Base] Prologue complete", points = 3,
    description = "Defied fate...",
    trigger = never(ChapterId() != 1) && never(bit3(0xA9EB2E) == 1) &&
              ((repeated(2010, prior(CutsceneId()) == 3314207892) && repeated(2010, prior(CutsceneId()) ==
                 570425580) && repeated(2010, prior(CutsceneId()) == 1137019994) && repeated(2010, CutsceneId()
                 == 3470786308) && repeated(2010, CutsceneId() == 1241543936) && repeated(2010, CutsceneId() ==
                 3622307327)) ||
               (prior(ChapterId()) == 1))
)

achievement(
    title = "[BranchingPath] An egg?", points = 5,
    description = "Receive a gift from a performer during chapter 1",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) && repeated(400, prior(CutsceneId()) ==
               63779279) && repeated(400, prior(CutsceneId()) == 286328215) && repeated(400, prior(CutsceneId())
               == 4294869862) && repeated(400, CutsceneId() == 209984715) && repeated(400, CutsceneId() ==
               2576945433) && repeated(400, CutsceneId() == 484495965)
)

achievement(
    title = "[Base] Chapter 1 complete", points = 3,
    description = "Defied fate... again?",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) &&
              ((repeated(610, prior(CutsceneId()) == 1094011894) && repeated(610, prior(CutsceneId()) ==
                 1358895514) && repeated(610, prior(CutsceneId()) == 6160384) && repeated(610, CutsceneId() ==
                 23652271) && repeated(610, CutsceneId() == 183081369) && repeated(610, CutsceneId() == 8388872)) ||
               (prior(ChapterId()) == 2))
)

achievement(
    title = "[Extra - Game over] Feels like I met you before...", points = 5,
    description = "Keep chatting with Dana at the Marktplatz tree 4 times during chapter 2",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(1500, prior(dword(0x1DFD287)) ==
               627048504) && repeated(1500, prior(dword(0x1DFD424)) == 3097296896) && repeated(1500,
               prior(dword(0x1DFDD14)) == 952197120) && repeated(1500, dword(0x1DFD287) == 771752120) && repeated(1500,
               dword(0x1DFD424) == 3098976256) && repeated(1500, dword(0x1DFDD14) == 957382656) && repeated(2,
               Timer() < prev(Timer()))
)

achievement(
    title = "[Extra] Eike the magician", points = 1,
    description = "Scare the crowd away with a magic box during chapter 2",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(1050, prior(CutsceneId()) ==
               2417558160) && repeated(1050, prior(CutsceneId()) == 3253753129) && repeated(1050,
               prior(CutsceneId()) == 107816199) && repeated(1050, CutsceneId() == 763360615) && repeated(1050,
               CutsceneId() == 4275437067) && repeated(1050, CutsceneId() == 4118618708) && repeated(1820,
               Timer() > prev(Timer()) && never(Timer() < prev(Timer())))
)

achievement(
    title = "[Extra] Eike the pyromancer", points = 1,
    description = "Scare the crowd away using pyrokinetic projection during chapter 2",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) && repeated(270, prior(CutsceneId()) ==
               3144021) && repeated(270, prior(CutsceneId()) == 3873309862) && repeated(270, prior(CutsceneId())
               == 285213706) && repeated(270, CutsceneId() == 269553938) && repeated(270, CutsceneId() ==
               3734505288) && repeated(270, CutsceneId() == 306710048) &&
              ((repeated(1600, Timer() > prev(Timer()) && never(Timer() <
                 prev(Timer())))) ||
               (repeated(2, Timer() < prev(Timer()))))
)

achievement(
    title = "[Extra] Eike the sculptor enthusiast", points = 1,
    description = "Built a statue during chapter 2",
    trigger = never(ChapterId() != 3) && bit3(0xA9EB2E) == 0 && CurrentlySelectedItemInInventory() == 15 && prior(CutsceneId()) ==
               2191938978 && prior(CutsceneId()) == 1386578109 && prior(CutsceneId()) == 2877292548 && 
              CutsceneId() == 82966958 && CutsceneId() == 732 && CutsceneId() == 1812383488 &&
              (always_false() || (prior(UiFlowersOrStatueChoice()) == 5242857 && prior(UiFlowersOrStatueChoice()) == 4259680 && prior(UiFlowersOrStatueChoice()) ==
                 5177506 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0))
)

achievement(
    title = "[Extra] Eike the florist", points = 1,
    description = "Planted flowers during chapter 2",
    trigger = never(ChapterId() != 3) && bit3(0xA9EB2E) == 0 && CurrentlySelectedItemInInventory() == 15 && prior(CutsceneId()) ==
               2191938978 && prior(CutsceneId()) == 1386578109 && prior(CutsceneId()) == 2877292548 && 
              CutsceneId() == 82966958 && CutsceneId() == 732 && CutsceneId() == 1812383488 &&
              (always_false() || (prior(UiFlowersOrStatueChoice()) == 4194143 && prior(UiFlowersOrStatueChoice()) == 5243043 && prior(UiFlowersOrStatueChoice()) ==
                 5308394 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0 && UiFlowersOrStatueChoice() == 0))
)

achievement(
    title = "[Extra] Eike the pyromancer", points = 1,
    description = "Build a statue of a pyrokinetic during chapter 2",
    trigger = unless(bit3(0xA9EB2E) == 1) && repeated(2200, prior(dword(0x1DFB3D3)) == 2802549769) && repeated(2050,
               prior(dword(0x1DFB3E9)) == 648012) && repeated(2010, prior(dword(0x1DFCD24)) == 165666817) && 
              repeated(2200, dword(0x1DFB3D3) == 3200043017) && repeated(2050, dword(0x1DFB3E9) == 647395) && 
              repeated(2010, dword(0x1DFCD24) == 165665112) &&
              (always_false() || (repeated(1100, dword(0xA82880) > prev(dword(0xA82880)) && never(dword(0xA82880) <
                 prev(dword(0xA82880))))))
)

achievement(
    title = "[Base] Chapter 2 complete", points = 3,
    description = "Third time's the charm...",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) == 1) &&
              ((unless((CutsceneId() != 75104066 && dword(0x1DF5950) != 782296805 && dword(0x1DF5A0C) !=
                 4084397926)) && repeated(4, TimerIncrementsEachFrame() < prev(TimerIncrementsEachFrame()))) ||
               (prior(ChapterId()) == 3))
)

achievement(
    title = "[BranchingPath] Egg collection #2", points = 5,
    description = "Give an egg to a barman during chapter 3",
    trigger = never(ChapterId() != 4) && never(bit3(0xA9EB2E) == 1) && repeated(500, prior(CutsceneId()) ==
               1759459584) && repeated(500, prior(CutsceneId()) == 6374) && repeated(500, prior(CutsceneId()) ==
               107157922) && repeated(500, CutsceneId() == 3573197306) && repeated(500, CutsceneId() == 8126348) && 
              repeated(500, CutsceneId() == 4280289740)
)

achievement(
    title = "[BranchingPath] Egg collection #1", points = 5,
    description = "Give an egg to a barman during chapter 1",
    trigger = never(ChapterId() != 2) && never(bit3(0xA9EB2E) == 1) && repeated(420, prior(CutsceneId()) ==
               81132608) && repeated(420, prior(CutsceneId()) == 89130446) && repeated(420, prior(CutsceneId())
               == 2282116640) && repeated(420, CutsceneId() == 286331154) && repeated(420, CutsceneId() ==
               51376747) && repeated(420, CutsceneId() == 1169658)
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

achievement(
    title = "[Extra] An interesting shape", points = 5,
    description = "Introduce the barman's ancestor to egg collecting during chapter 2",
    trigger = never(ChapterId() != 3) && never(bit3(0xA9EB2E) < prior(bit3(0xA9EB2E))) && repeated(420,
               CutsceneId() == 4291690652) && repeated(420, CutsceneId() == 11077697) && repeated(420,
               CutsceneId() == 843251806) && CurrentlySelectedItemInInventory() == 2 && bit3(0xA9EB2E) > prev(bit3(0xA9EB2E))
)

achievement(
    title = "[Extra] Enigmatic couple #1", points = 5,
    description = "Find the coated man and woman during the prologue or chapter 1",
    trigger = unless((CutsceneId() != 375056095 && CutsceneId() != 3218933777 && CutsceneId() != 8388881 &&
               bit0(0xA9EB2C) == 1)) && unless((CutsceneId() != 4177789088 && CutsceneId() != 1638673 &&
               CutsceneId() != 32798694 && bit0(0xA9EB2C) == 1)) && measured(tally(2, 
                  deduct(once(CutsceneId() == 375056095)), 
                  repeated(2, CutsceneId() == 375056095), 
                  deduct(once(CutsceneId() == 32798694)), 
              CutsceneId() ==
               32798694), when=(dword(0xB88EA4) != 0 && ChapterId() == 1))
)

achievement(
    title = "[Template] Cutscene with timer", points = 0,
    description = "Achievement cutscene - change 32-bit values to values from the last cutscene in the sequence",
    trigger = never(bit3(0xA9EB2E) == 1) && repeated(3000, prior(CutsceneId()) == 1094011894) && repeated(3000,
               prior(CutsceneId()) == 1358895514) && repeated(3000, prior(CutsceneId()) == 6160384) && 
              repeated(3000, CutsceneId() == 23652271) && repeated(3000, CutsceneId() == 183081369) && 
              repeated(3000, CutsceneId() == 8388872) && repeated(5000, Timer() > prev(Timer()) &&
               never(Timer() < prev(Timer()))) &&
              ((repeated(5000, Timer() > prev(Timer()) && never(Timer() <
                 prev(Timer())))) ||
               (repeated(5000, Timer() > prev(Timer()))))
)

achievement(
    title = "[TODO-BranchingPath] The performer", points = 0,
    description = "Become a performer",
    trigger = 0
)

achievement(
    title = "[TODO-EXTRA] Oleg movie producer", points = 0,
    description = "",
    trigger = never(bit3(0xA9EB2E) == 1)
)

achievement(
    title = "[TODO-EXTRA] Museum or library", points = 0,
    description = "",
    trigger = never(bit3(0xA9EB2E) == 1)
)

achievement(
    title = "[Template] Short cutscene cheevo", points = 4,
    description = "Introduce the barman's ancestor to egg collecting during chapter 2",
    trigger = never(bit3(0xA9EB2E) < prior(bit3(0xA9EB2E))) && repeated(420, CutsceneId() == 4291690652) && 
              repeated(420, CutsceneId() == 11077697) && repeated(420, CutsceneId() == 843251806) && 
              CurrentlySelectedItemInInventory() == 2 && bit3(0xA9EB2E) > prev(bit3(0xA9EB2E))
)

achievement(
    title = "[TODO-EXTRA] Enigmatic couple #2 ", points = 5,
    description = "Help a couple reunite during chapter 2",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Enigmatic couple #2", points = 0,
    description = "Find the coated man and woman during the chapter 3",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Enigmatic couple #3", points = 0,
    description = "Find the coated man and woman during the chapter 4",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Enigmatic couple #4", points = 0,
    description = "Find the coated man and woman during the chapter 5",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Enigmatic couple #5", points = 0,
    description = "Find the coated man and woman during the chapter 7",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #2 ", points = 0,
    description = "Help a lost couple reunite during chapter 3",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #3", points = 0,
    description = "Finally reunite the lost couple during chapter 4",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #4", points = 0,
    description = "Talk the young man during chapter 5",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #6", points = 0,
    description = "Talk the young man during chapter 6????",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #7", points = 0,
    description = "Talk to the couple during chapter 7",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Lost young couple #8", points = 0,
    description = "Consult the young man during chapter 8",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Time travelling kitten ", points = 0,
    description = "Gift someone a new friend",
    trigger = 0
)

achievement(
    title = "[TODO - Extra] Cupcake", points = 0,
    description = "",
    trigger = 0
)

achievement(
    title = "[Test] Changed", points = 0,
    description = "",
    trigger = CorrelatesToInteractionId() != prev(CorrelatesToInteractionId())
)

achievement(
    title = "[Template] Measuring mutiple cutscenes", points = 5,
    description = "Help a lost couple reunite during chapter 2 (measured if in-game)",
    trigger = unless((CutsceneId() != 825085588 && CutsceneId() != 3873374878 && CutsceneId() != 3303464709
               && bit0(0xA9EB2C) == 1)) && unless((CutsceneId() != 286331153 && CutsceneId() != 62062817 &&
               CutsceneId() != 1292999168 && bit0(0xA9EB2C) == 1)) && measured(tally(2, 
                  deduct(once(CutsceneId() == 825085588)), 
                  repeated(2, CutsceneId() == 825085588), 
                  deduct(once(CutsceneId() == 1292999168)), 
              CutsceneId() ==
               1292999168), when=(dword(0xB88EA4) != 0 && ChapterId() == 3))
)
