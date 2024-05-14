// Shadow of Destiny
// #ID = 3945

// $000000: [INFO] Link to RAscript + Achievement Guide (github)
//          '''''''''''''''''''''''''''''''''''''''
//          - https://github.com/QuentinBultinck/RetroAchievements/tree/main/RAscripts/PSP/ShadowOfDestiny
// $8FBEF0: [NTSC-J][25-bit Pointer] Video data (intro and credits)
//          - Regional equivalent of $0x8ffef0 (USA)
// $8FFEF0: [NTSC-U][25-bit Pointer] Video data (intro and credits)
//          +0x18 - [32-bit Flag] 0x101 => video is active
//          +0x2c - [32-bit Flag] 0x41 => video is active
//          +0x40 - [32-bit] Video timer
// $A442EC: [NTSC-U][36-byte Array] List of [(9x) Pointer] ----> EnergyOrbs_Data_Objects
//          
//          [Struct Definition][12-byte] EnergyOrbs_Data_Object
//          |'''''''''''''''''''''''''''''''''''''''''''
//          | +0x0 - [8-bit] Amount of Energy Orbs in the Area
//          | +0x4 - [8-byte Array] List of [Bit Flags {8-bit}] =&gt; Is Energy Orb Collected
//          
//          [NTSC-U][25-bit Pointer] --&gt; [EnergyOrbs_Data_Object] Energy Orbs | Present - City
//          +0x4 - [Bit Flag] bit 0 =&gt; Orb - Outside Fortune Teller
//          +0x5 - [Bit Flag] bit 0 =&gt; Orb - Alley Way Between Haup Street &amp; Neuwand Street
//          +0x6 - [Bit Flag] bit 0 =&gt; Orb - South Gate
//          +0x7 - [Bit Flag] bit 0 =&gt; Orb - Under Arch Ruckagrat Street
//          +0x8 - [Bit Flag] bit 0 =&gt; Orb - Car Park
// $A442F0: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Late 20th Century - City
//          +0x4 - [Bit Flag] bit 0 => Orb - Gate North of Bar
//          +0x5 - [Bit Flag] bit 0 => Orb - Cafe Sonne Well
//          +0x6 - [Bit Flag] bit 0 => Orb - Haupt Street
//          +0x7 - [Bit Flag] bit 0 => Orb - Rudolf Street Stairs
//          +0x8 - [Bit Flag] bit 0 => Orb - Alley Way Behind Bakery
// $A442F4: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Early 20th Century - City
//          +0x4 - [Bit Flag] bit 0 => Orb - Tree Near Bar
//          +0x5 - [Bit Flag] bit 0 => Orb - Stairs Opposite Cafe Sonne
//          +0x6 - [Bit Flag] bit 0 => Orb - Near News Post
//          +0x7 - [Bit Flag] bit 0 => Orb - Rudolf Street Park
//          +0x8 - [Bit Flag] bit 0 => Orb - North East Gate
// $A442F8: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - City
//          +0x4 - [Bit Flag] bit 0 => Orb - North East On Bench
//          +0x5 - [Bit Flag] bit 0 => Orb - West Near Well
//          +0x6 - [Bit Flag] bit 0 => Orb - Alley Way Behind Atelier Franssen
//          +0x7 - [Bit Flag] bit 0 => Orb - East Near Hay
//          +0x8 - [Bit Flag] bit 0 => Orb - Outside Church
// $A44300: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - Lab
//          +0x4 - [Bit Flag] bit 0 => Orb - Exploded Alchemy Lab
// $A44304: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Early 20th Century - Brum Mansion
//          +0x4 - [Bit Flag] bit 0 => Orb - Inside Brum Mansion
// $A4430C: [NTSC-U][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - Church
//          +0x4 - [Bit Flag] bit 0 =&gt; Orb - Inside Church
// $A450BC: [NTSC-J][36-byte Array] List of [(9x) Pointer] --> EnergyOrbs_Data_Objects
//          - Regional equivalent of $0xa442ec (USA)
//          
//          [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Present - City
//          - Regional equivalent of $0xa442ec (USA)
// $A450C0: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Late 20th Century - City
//          - Regional equivalent of $0xa442f0 (USA)
// $A450C4: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Early 20th Century - City
//          - Regional equivalent of $0xa442f4 (USA)
// $A450C8: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - City
//          - Regional equivalent of $0xa442f8 (USA)
// $A450D0: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - Lab
//          - Regional equivalent of $0xa44300 (USA)
// $A450D4: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Early 20th Century - Brum Mansion
//          - Regional equivalent of $0xa44304 (USA)
// $A450DC: [NTSC-J][25-bit Pointer] --> [EnergyOrbs_Data_Object] Energy Orbs | Middle Ages - Church
//          - Regional equivalent of $0xa4430c (USA)
// $A5AB44: [NTSC-U][9-byte ASCII Text] PSP Game ID - USA
//          - ASCII Text = ULUS10459 --> PSP game identification code for region USA
// $A64C74: [NTSC-J][9-byte ASCII Text] PSP Game ID - JPN
//          - ASCII Text = ULJM05512 --> PSP game identification code for region JPN
// $A82E2C: [NTSC-U/C][Bit Flag] bit 0 => Is Chapter Completion Menu Displayed || Is Loading
//          - bit 0 = 1 => when chapter complete screen is displayed, when the ending video credits + ending file are played, when loading (+during time travel)
//          - bit 0 = 0 => when in-game AND nothing is loading
// $A82E48: [NTSC-U][32-bit] Area Identification
//          - This list is not complete; Currently only IDs used in achievement logic are documented
//          
//          0x10 => Present_CafeSonne
//          0x140 => Present_BrumMuseum_Upstairs_Room3_Night
//          0x15 => 80s_CafeSonne
//          0x159 => Present_BrumMuseum_Upstairs_Room1_Night
//          0x16 => Present_TownHall
//          0x1bd => Present_BrumMuseum_Upstairs_Room2_Day
//          0x217 => MiddleAges_AlchemistHouse_Exploded_Basement
//          0x224 => Present_BrumMuseum_Upstairs_Room2_Night
//          0x239 => 1900s_City
//          0x2ed => Present_BrumMuseum_Downstairs_Room_Day
//          0x3 => Present_City_NightPM
//          0x31d => 70s_City_Night
//          0x32 => Present_BrumMuseum_Downstairs_Room_Night
//          0x33c => MiddleAges_City_Night
//          0x375 => Present_City_Day
//          0x38 => Present_BrumMuseum_Upstairs_Room1_Day
//          0x3f3 => MiddleAges_City_Day
//          0x44 => Present_City_NightAM
//          0x465 => 80s_City_Snow
//          0x603 => 1900s_BrumMansion
//          0x6f => Present_AntiquesEule
//          0x7a => 80s_AntiquesEule
//          0x8e => MiddleAges_Church
//          0xcd => Present_BrumMuseum_Upstairs_Room3_Day
//          0xf => 80s_Bar
// $A8A97C: [NTSC-J][Bit Flag] bit 0 => Is Chapter Completion Menu Displayed || Is Loading
//          - Regional equivalent of $0xa82e2c (USA)
// $A8A998: [NTSC-J][32-bit] Area Identification
//          - Regional equivalent of $0xa82e48 (USA)
// $A8AB74: [NTSC-U][32-bit] Misc Player Model Data - Is Idle
//          - Changes each 2 frames, when idle
//          - 0x0 => when moving
// $A8ABD0: [NTSC-U][Float] Player Position - x-Axis
//          - Heading west => value decreases
//          - Heading east => value increases
//          - Prime Meridian (vertical mid-line cutting area in two) => value is 0 on this mid-line
//          - West from mid-line => value is positive
//          - East from mid-line => value is negative
// $A8ABD8: [NTSC-U][Float] Player Position - y-Axis
//          - Heading north => value increases
//          - Heading south => value decreases
//          - Equator (horizontal mid-line cutting area in two) => value is 0 on this mid-line
//          - North from mid-line => value is positive
//          - South from mid-line => value is negative
// $A8ABE4: [NTSC-U][Float] Player Model Rotation
//          - North => 0.0
//          - East => 1.522...
//          - South => 3.119... OR -3.119...
//          - West => -1.522...
// $A92720: [NTSC-J][Float] Player Position - x-Axis
//          - Regional equivalent of $0xa8abd0 (USA)
// $A92728: [NTSC-J][Float] Player Position - y-Axis
//          - Regional equivalent of $0xa8abd8 (USA)
// $A9DAA8: [NTSC-U][8-bit] Energy Units (functional)
//          - This is the internal/functional value, if this is 0x0 => player can't time-travel
//          - Values range [0x0-0xa]
// $A9DC24: [NTSC-U][25-bit pointer] Model Data - Jogging Man 1980s
//          - Pointer is only valid whilst in Chapters 3, 4 and 5
//          
//          +0x40 - [Float] Position - xAxis
//          +0x48 - [Float] Position - yAxis
//          +0xAC - [Bit Flag] bit 5 => Is Running Animation Active
// $A9EB2A: [NTSC-U][8-bit] Energy Units (visual)
//          - This value only corresponds with the UI (refer to 0xa9daa8 for functional value)
//          - Value range [0x0-0xa]
// $A9EB2E: [NTSC-U][8-bit Flag] Is Player Character Moveable
//          - 0x8 => Player can move Eike
//          - [0x0-0x7] => Player can not move Eike (when loading, during cutscenes...)
// $A9ECBC: [NTSC-U][124-byte] Cutscene Data
//          ===========================
//          - To ID a cutscene make usage of one or multiple IDs mentioned in this 124-byte
//          
//          [NTSC-U][32-bit] Cutscene Master ID
//          - Identifies a cutscene sequence
//          - Does not reset to a default value
//          
//          # Cutscene_MasterIDs
//          (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''''''''
//          | - 0x22480 => Prologue: Eike spectating performer (part1)
//          | - 0x90bc0 => Prologue: Eike spectating performer (part2) - Killer/shadow walking behind Eike
//          | - 0x11a40 => Chapter1: Burning bar transform into non-burning bar (last cutscene of chapter 1)
//          | - 0x3b240 => Chapter2: Eike reminiscing about Dana + tree dissappearing (last cutscene of chapter 2)
//          | - 0x19d80 => Chapter3 Eike travels back to Brum Museum with Homunculus talking to him at stairs
//          | - 0xcfb40 => Chapter3: Eike goes back to Eckart upstairs + Eckart breaks vase
//          | - 0x39680 => Chapter3: Eike goes back downstairs to Homunculus
//          | - 0x3f980 => Chapter5: Eike drinks antidote
//          | - 0x9db40 => Chapter6: Saved by altering movie
//          | - 0x43040 => Chapter7: Eike holds onto rope on top of tower
//          | - 0xc6800 => Chapter7: Talking to Eckart in office, Ancestress path
//          | - 0xd1bc0 => Chapter7: Talking to Eckart in office, No Ancestress path
//          | - 0x12040 => Chapter7: Looking at painting of Dana
//          | - 0x8b640 => Chapter8: Leading up to ending A: Talk to Homunculus
//          | - 0x10ef00 => Chapter8: Leading up to ending A: Summon Dr. Wagner with Homunculus
//          | - 0xe4800 => Chapter8: Leading up to ending A: Dr. Wagner confronts Hugo
//          | - 0xd5440 => Chapter8: Leading up to ending B1: Talk to Hugo and Margarette
//          | - 0x716c0 => Chapter8: Leading up to ending B1: Hugo inside old Alchemist house collapsing
//          | - 0xf3c80 => Chapter8: Leading up to ending B1: Eike consoling Margarette
//          | - 0xfbd00 => Chapter8: Leading up to ending B2: Talk to Hugo and Margarette
//          | - 0xc4e40 => Chapter8: Leading up to ending B2: Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
//          | - 0x1cbc0 => Chapter8: Leading up to ending C: Talk to Homunculus at square after seeing young Hugo erase old Hugo
//          | - 0x77a40 => Chapter8: Leading up to ending D: Flashback to Hugo trying to read burnt documents
//          | - 0x4b140 => Chapter8: Leading up to ending D: Eike confronts Hugo at square
//          | - 0xc9440 => Chapter8: Leading up to ending D: Margarette dissapears after Hugo dissappeared
//          | - 0x101bc0 => Chapter8: Leading up to ending E: Brought Margarette to present
//          | - 0x137500 => Chapter8: Leading up to ending E: Margarette confronts Hugo in square
//          | - 0xdb780 => Epilogue: Ending A: Chosen to have Margarette stay in present + Z-pad breaks
//          | - 0x77f80 => Epilogue: Ending A: Finding red jewel in tree at square
//          | - 0x613c0 => Epilogue: Ending B1: Eike returns from sending Margarette back to past
//          | - 0x56240 => Epilogue: Ending B1: Eike goes to the bar
//          | - 0x91240 => Epilogue: Ending B2: Eike talks with Homunculus
//          | - 0x5d2c0 => Epilogue: Ending B2: Eike gives z-pad back to Homunculus
//          | - 0x56240 => Epilogue: Ending B2: Eike goes to the bar
//          | - 0x8cf00 => Epilogue: Ending C: Giving z-pad back to Homunculus
//          | - 0x7b140 => Epilogue: Ending C: Homunculus has bad feeling
//          | - 0xcb700 => Epilogue: Ending C: Eike getting roadkilled
//          | - 0x709c0 => Epilogue: Ending D: Talk to Homunculus at square
//          | - 0xc5b40 => Epilogue: Ending D: Flashback. Dr. Wagner summons Homunculus and becomes youthfull
//          | - 0x88dc0 => Epilogue: Ending E: Eike and Dana talk with Homunculus
//          | - 0xbef80 => Epilogue: Ending E: Flashback. Dr. Wagner summons Homunculus and Dr. Wagner is killed
//          | - 0xcdcc0 => Epilogue: Ending E: Eike and Dana talk with Homunculus some more
//          | - 0xa7a80 => PrologueEX: waking up in limbo with Philosopher Stone and destroy Homunculus
//          | - 0x67940 => PrologueEX: Immortal Dr. Wagner // Eike lookalike in present talking with delinquents
//          | - 0x58c00 => PrologueEX: Helena Wagner is cured
//          | - 0x114c0 => Multi-Chapter: Showing Franssen in 1902 the pocket watch
//          | - 0xb0100 => Chapter4: Info/lore dump about timetravel after defending yourself
//          | - 0xc7940 => Chapter7: Ancestor path => Old Miriam walks into conversation with Eckart and Eike
//          | - 0xb2540 => Chapter7: No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
//          | - 0x19380 => Chapter1: Acquiring ornamental egg from performer
//          | - 0x30780 => PrologueEX: EX Chapter, performer throws egg
//          | - 0x2f9c0 => Multi-Chapter: Exchanging egg for frying pan in chapter 1 OR 4
//          | - 0x32200 => Multi-Chapter: Exchanging egg for frying pan in chapter 3
//          | - 0xde00 => Chapter2: Show off egg to town planter
//          | - 0x8b440 => Multi-Chapter: Instantly pay for the coffee with egg shaped pocket watch
//          | - 0xac4c0 => Multi-Chapter: Drank coffee before acquiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
//          | - 0x8ce80 => Chapter7: Show off egg pocket watch to barman in present
//          | - 0x8dcc0 => Chapter8: Eike and Eckart talk about film director and his pocket watches
//          | - 0xd0200 => Chapter5: Talk to barman about grandchildren
//          | - 0x1a300 => Chapter4: Eike gives himself a message as performer
//          | - 0x10b000 => Multi-Chapter: Eike gives Margarette Cake for 1st time
//          | - 0x1a300 => Chapter4: Giving egg to Eike/yourself as performer
//          | - 0x9000 => Chapter2: scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
//          | - 0xc6e00 => Chapter:2 scaring crowd with cellphone; instead of below cutscene
//          | - 0xa84c0 => Chapter2: scaring crowd with lighter; instead of above cutscene
//          | - 0x98c0 => Chapter2: scaring town planter
//          | - 0x62840 => Chapter5: Barman gives Eike free meal
//          | - 0xf9cc0 => Chapter5: Reading book whilst barman gets Eike his meal + poison
//          | - 0x1fd80 => Multi-Chapter: Eike gives Margarette Cake for 2nd time
//          | - 0x4f200 => Chapter4: Using frying pan for defence
//          | - 0xa0f40 => Chapter7: Talking to Oleg near movie poster
//          | - 0x756c0 => Chapter6: Miriam shot and dying
//          | - 0xebac0 => Chapter6: Eike save Miriam, after running after her
//          | - 0x3ed00 => Chapter5: Hugo gets bullied at square
//          | - 0x25200 => Multi-Chapter: Giving kitten to Sibylla
//          | - 0x9c00 => Prologue: Eike wakes himself up (part1)
//          | - 0x237c0 => Prologue: Eike wakes himself up (part2) - Talking with Homunculus in Limbo after death
//          | - 0x15640 => Chapter7: Holding on to rotten rope (part1)
//          | - 0x237c0 => Chapter7: Holding on to rotten rope (part2) - Waking up in Limbo after death
//          | - 0x77980 => Chapter6: Roadkilled by Time Ego movie
//          | - 0x6e480 => Chapter2: Talk Dana, seeing through clothing hunch
//          | - 0x1b740 => Chapter2: Getting stabbed from behind
//          | - 0xb140 => Chapter3: Picking dialogue option with Homunculus: 'excuse me' (part1)
//          | - 0x1a440 => Chapter3: Picking dialogue option with Homunculus: 'excuse me' (part2) - Waking up in limbo after dying to vase
// $A9ECC0: [NTSC-U][16-bit] Cutscene Section ID_1
//          - Identifies a section from the current cutscene
//          - Resets to 0xffff when no cutscene active OR when switching cutscene sections
//          - First section of a cutscene always start at 0x1; goes up from there depending on camera switches
// $A9ECC2: [NTSC-U][16-bit] Cutscene Section ID_2
//          - First section of a cutscene always start at 0x0; goes up from there depending on camera switches
// $A9ECC8: [NTSC-U][25-bit Pointer] Cutscene Identification - Master Data
//          +0x0 - Refers to start of dynamic cutscene memory data block - Data higher than this hex address changes on new cutscene loaded in
//          +0x8 - [32-bit] Cutscene Master Data ID
//          
//          # Cutscene_MasterData_IDs
//          (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''''''''
//          | - 0x3f980 => Chapter5: Eike drinks antidote
//          | - 0x114a0 => Multi-Chapter: Showing Franssen in 1902 the pocket watch
//          | - 0xd440 => Chapter4: giving egg to Eike/yourself as performer
//          | - 0x9000 => Chapter2: scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
//          | - 0x9890 => Chapter2: scaring town planter
// $A9ECCC: [NTSC-U][25-bit Pointer] Cutscene Identification - Section Data
//          +0x0 - Data lower than this hex address changes when the next section in the cutscene starts
//          +0x8 - [32-bit] Cutscene Section Data ID
//          
//          # Cutscene_SectionData_IDs
//          (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''''''''
//          | - 0x3f980 => Chapter5: Eike drinks antidote
//          | - 0x114a0 => Multi-Chapter: Showing Franssen in 1902 the pocket watch
//          | - 0x3a00 => Chapter4: giving egg to Eike/yourself as performer
//          | - 0x9000 => Chapter2: scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
//          | - 0x9890 => Chapter2: scaring town planter
// $A9ECD0: [NTSC-U][25-bit Pointer] Cutscene Misc Data
//          +0x0 - Refers to end of dynamic cutscene memory data block??
// $A9ECD4: [NTSC-U][25-bit Pointer] Cutscene Identification - Minor IDs
//          - Pointer active when a cutscene is active
//          +0x0 - Data lower than this point can be used as Minor Cutscene IDs
//          +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID
//          
//          # Cutscene_Minor_IDs
//          (list only contains IDs used in achievement logic)
//          [ID (offset), ID (offset)... => Chapter: cutscene description]
//          |''''''''''''''''''''''''''''''''
//          | - 0xad50 (+0x8), 0x114a0 (+0x28) => Multi-Chapter: Showing Franssen in 1902 the pocket watch
//          | - 0x5f80 (+0x8), 0x9000 (+0x28) =>  Chapter2: scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
//          | - 0xcd30 (+0x8), 0x9890 (+0x28) => Chapter2: scaring town planter
//          | - 0x23ee0 (+0x8), 0x377e0 (+0x28), 0x23eb0 (+0x2C) => Chapter7: Eike bumps into himself
// $A9ED26: [NTSC-U][8-bit Flag] Is Cutscene Active (preferred)
//          0x0 => no cutscene active
//          0x1 => Small cutscene active (without fancy camera work) || transitional value between active-inactive state
//          ... => transitional values
//          0x5 => Large cutscene active
// $A9ED38: [NTSC-U][32-bit] Cutscene Timer
// $A9ED3C: [NTSC-U][57-bytes Bitset] Achievement Percentage Flags
//          ===========================================
//          - Each flag corresponds to 1 cutscene and counts toward the achievement percentage
//          - Flags become true on cutscene end
//          - Flags are grouped per chapter
//          - These flags are loaded when loading a save OR when starting a new game whilst having played the game before
//          
//          - Flags further than 57-bytes do not count toward achievement percentage
//          - Some side content/cutscenes do not have any corresponding flags, thus they do not count toward the achievement percentage
//          
//          [NTSC-U][7-bytes - Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          bits 1-7 => 13+%
// $A9ED3D: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
// $A9ED3E: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
// $A9ED3F: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
// $A9ED40: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
// $A9ED41: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
// $A9ED42: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          bits 0-5 => 11+%
// $A9ED43: [NTSC-U][4-bytes - Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 6-7 => 8+%
// $A9ED44: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
// $A9ED45: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
// $A9ED46: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 0-5 => 25+%
// $A9ED47: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 3-7 => 13+%
// $A9ED48: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED49: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED4A: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED4B: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 0-6 => 19+%
// $A9ED4D: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 1-7 => 19+%
// $A9ED4E: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED4F: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED50: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED51: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 0-4 => 13+%
// $A9ED52: [NTSC-U][6-bytes - Bit Flags] Achievement Percentage Flags - Chapter 5
//          bits 1-7 => 15+%
// $A9ED53: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
// $A9ED54: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
// $A9ED55: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
// $A9ED56: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
// $A9ED57: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          bits 0-6 => 15+%
// $A9ED58: [NTSC-U][3-bytes - Bit Flags] Achievement Percentage Flags - Chapter 3
//          bits 2-7 => 27+%
// $A9ED59: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
// $A9ED5A: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
// $A9ED5B: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 2-7 => 17+%
// $A9ED5C: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5D: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5E: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5F: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 0-4 => 14+%
// $A9ED60: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 2-7 => 17+%
// $A9ED61: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED62: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED63: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED64: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 0-3 => 11+%
// $A9ED65: [NTSC-U][10-bytes - Bit Flags] Achievement Percentage Flags - Chapter 8
//          bits 5-7 => 4+%
// $A9ED66: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED67: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED68: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED69: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED6A: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED6B: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED6C: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED6D: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
// $A9ED6E: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          bits 0-3 => 5+%
// $A9ED71: [NTSC-U][4-bytes - Bit Flags] Achievement Percentage Flags - Epilogue
//          bits 2-7 => 26+%
// $A9ED72: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
// $A9ED73: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
// $A9ED74: [Bit Flags] Achievement Percentage Flags - Epilogue
//          bit 0 => 4+%
// $A9ED76: [NTSC-U][102-byte Bitset] Current Playthrough Bit Flags
//          ================================================
//          - Mostly contains bitflags for certain events in the current playthrough
//          - List is not complete. Currently only bitflags which are used in achievement logic are documented
//          
//          [NTSC-U][Bit Flags] Current Playthrough - Multi-chapter
//          bit 0 => talked to Oleg 2nd time in chapter 3
//          bit 7 => gave kitten to Sibylla
// $A9ED98: [NTSC-U][Bit Flags] Current Playthrough - EX Chapter
//          bit 7 => is prologue in EX mode - Actually a bitflag for 2nd dialogue option at start of game when all other endings have been achieved: "Oh, Homunculus", which activates EX chapter
// $A9ED9D: [NTSC-U][Bit Flags] Current Playthrough - Chapter 1
//          bit 5 => put out fire yourself
//          bit 7 => Saved bar from fire by warning barman
// $A9EDA0: [NTSC-U][Bit Flags] Current Playthrough - Chapter 2
//          bit 0 => is ladder acquired
//          bit 1 = 0 => LIGHTER used to scare crowd
//          bit 1 = 1 => TELEPHONE used to scare crowd
//          bit 2 = 0 => Chosen to plant STATUE instead of flowers
//          bit 2 = 1 => Chosen to plant FLOWERS instead of statue
// $A9EDA5: [NTSC-U][Bit Flags] Current Playthrough - Chapter 4
//          bit 2 => is wearing performer outfit
//          bit 3 => died once without using an iron plate
// $A9EDAA: [NTSC-U][Bit Flags] Current Playthrough - Brum Estate Choice
//          bit 5 = 0 => Brum Estate is museum
//          bit 5 = 1 => Brum Estate is library
// $A9EDAD: [NTSC-U][Bit Flags] Current Playthrough - Ancestor Choice - Chapter 5
//          bit 1-3 => walk with margarette
//          bit 4 => 1st ancestor choice
//          bit 5 => cutscene inbetween choices
//          bit 6 => confirm choice: Margarette is NO ancestor, sets on choice (refer to 0xa9edae)
//          bit 7 => confirm choice: Margarette is ancestor, sets on choice, (refer to 0xa9edae)
// $A9EDAE: [NTSC-U][Bit Flags] Current Playthrough - Ancestor Choice - Chapter 5
//          bit 6 => Margarette is ancestor, sets after leaving alchemist house (refer to 0xa9edad)
//          bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house (refer to 0xa9edad)
// $A9EDB0: [NTSC-U][Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen
//          bit 7 => Antidote painting
//          bit 6 => Marktplatz painting (insinuating removing the tree)
//          bit 5 => Squire's crest painting
//          bit 4 => Tower view painting (downstairs)
// $A9EDB1: [NTSC-U][Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          bit 0 => Performer painting (only possible when player became performer in chapter 4)
//          bit 1 => Achemist house collapse painting
// $A9EDB7: [NTSC-U][Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 5 => Movie choice 1: Meditating Man
//          bit 6 => Movie choice 1: Time Travel
//          bit 7 => Movie choice 2: Take over the world
// $A9EDB8: [NTSC-U][Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 0 => Movie Choice 2: Find cause of own death
//          bit 1 => Movie Choice 3: Thriller story
//          bit 2 => Movie Choice 3: Love story
// $A9EDC0: [NTSC-U][Bit Flags] Current Playthrough - Dana's choice
//          bit 2 = 0 => Take Dana back to present
//          bit 2 = 1 => Leave Dana in the past (is set after cutscene ends)
// $A9EDC4: [NTSC-U][Bit Flags] Current Playthrough - Saved Dana from Past
//          bit 1 => Gave letter to Dana
//          bit 3-4 => Took Dana back to present
// $A9EDCA: [NTSC-U][Bit Flags] Current Playthrough - Multi-chapter
//          bit 6 => payed TAB with egg shaped pocket watch
//          bit 7 => payed COFFEE with egg shaped pocket watch
// $A9EDCB: [NTSC-U][Bit Flags] Current Playthrough - Multi-chapter
//          bit 2 => talked with Oleg 1st time in Chapter 3
//          bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
//          bit 6 => gave kitten to Sibylla
// $A9EDCC: [NTSC-U][Bit Flags] Current Playthrough - Multi-chapter
//          bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch
// $A9EDDC: [NTSC-U][Lower4 Flag] Is In-Game
//          Lower4 = 0 => at title screen
//          Lower4 > 0 => in-game
// $A9EE08: [NTSC-U][436-byte Bitfield] NPC Interaction Data
//          ======================================
//          - 8-bit blocks that count how many times player has talked to an NPC
//          - Max count usually 0x2, talking more than this equals same dialogue + is skippable
//          - These counts are saved to the current playthrough
//          - If the interaction is not counted in this data block, it's a cutscene
// $A9EE1D: [8-bit] NPC Talk Count - Coated man - Present - Chapter 1/Prologue - Town Square
// $A9EE20: [8-bit] NPC Talk Count - Coated man- Present - Chapter 3 - Near Antique Shop
// $A9EE21: [8-bit] NPC Talk Count - Coated man - Present - Chapter 4 - Haup str. under arch
// $A9EE22: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Before Eating At Bar
// $A9EE24: [8-bit] NPC Talk Count - Coated man - Present - Chapter 7 - North West Gate
// $A9EE25: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - After Eating At Bar - Brum Library
// $A9EE26: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - After Eating At Bar - Brum Museum
// $A9EE28: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 1/Prologue - Town Square
// $A9EE2C: [8-bit] NPC Talk Count - Coated woman - Present - Chapter3 - Outside antique shop
// $A9EE2F: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 7 - South Gate
// $A9EE30: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne - Before Eating At Bar
// $A9EE31: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne - After Eating At Bar
// $A9EE33: [8-bit] NPC Talk Count - Mother of young boy (0xa9ee34) - 1900s - At the square
// $A9EE34: [8-bit] NPC Talk Count - Young boy - 1900s - At the square
// $A9EE36: [8-bit] NPC Talk Count - Straw Hat Man - Middle Ages - Chapter 2 - Streets
//          - When scaring with lighter or cellphone
// $A9EE38: [8-bit] Times talked to strolling man: Middle Ages 05/24/1582 - 3-4pm
// $A9EE3F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
// $A9EE49: [8-bit] NPC Talk Count - Barman - Cold Days 1980 - any chapter - inside bar
// $A9EE4C: [8-bit] NPC Talk Count -  Broad delinquent - Present - Chapter 7 - Car Park
// $A9EE51: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
// $A9EE6F: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
// $A9EE70: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
//          - When frightening with lighter or cellphone
// $A9EE7F: [8-bit] NPC Talk Count - Brunette young girl - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $A9EE88: [8-bit] NPC Talk Count - Blonde old woman - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $A9EE92: [8-bit] NPC Talk Count - Brunette mother - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $A9EEF8: [8-bit] NPC Talk Count - Young blonde boy - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $A9EF43: [8-bit] NPC Talk Count - Older man - 1980 - Chapter 6 - Cafe Sonne
// $A9EF69: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - West Gate
//          - When 0xa9ef89 == 0
// $A9EF6A: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x1
// $A9EF6B: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x3
// $A9EF6C: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well
//          - When 0xa9ef8a == 0
// $A9EF6D: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well
//          - When 0xa9ef8a == 0x1
// $A9EF6E: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Outside church
//          - When 0xa9ef8a == 0x3
// $A9EF6F: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square
//          - When value @ 0xa9ef8b == 0x0
// $A9EF70: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square
//          - When value @ 0xa9ef8b == 0x1
// $A9EF71: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Near Marie's Bakery
//          - When value @ 0xa9ef8b == 0x3
// $A9EF72: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 5 - Near South East Gate
// $A9EF74: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 7 - Outside church
// $A9EF76: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Before Experiment
//          - Only when 0xa9ef8e == 0x0
// $A9EF77: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8
//          - When value @ 0xa9ef8e == 0
// $A9EF78: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church
//          - After experiment - When value @ 0xa9ef8e >= 0x1
// $A9EF7C: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0
// $A9EF7D: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x1
// $A9EF7E: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x3
// $A9EF7F: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Near North East Gate
//          - When 0xa9ef8a == 0
// $A9EF80: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Near North East Gate
//          - When 0xa9ef8a == 0x1
// $A9EF81: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Town square  - When 0xa9ef8a == 0x3
// $A9EF82: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x0
// $A9EF83: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x1
// $A9EF84: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x3
//          
//          [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square
//          - In Ancestor and NoAncestor path
// $A9EF85: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square
//          - Only in Ancestor path
//          
//          0x1 => talking to her before the dialogue option
//          0x2 => after any dialogue option is chosen
// $A9EF89: [8-bit] State Of Young Couple Side Quest - Chapter 2
//          0x1 => has talked with 0xa9ef69 AND 0xa9ef7c
//          0x2 => has talked with 0xa9ef6a AND 0xa9ef7d
//          0x3 => Young couple - Middle Ages - Chapter 2 - have switched positions/respawned
// $A9EF8A: [8-bit] State Of Young Couple Side Quest - Chapter 3
//          0x1 => has talked with 0xa9ef6c AND 0xa9ef7f
//          0x2 => has talked with 0xa9ef6d AND 0xa9ef80
//          0x3 => Young couple - Middle Ages - Chapter 3 - have changed positions/respawned
// $A9EF8B: [8-bit] State Of Young Couple Side Quest - Chapter 4
//          0x1 => has talked with 0xa9ef82 AND 0xa9ef6f
//          0x2 => has talked with 0xa9ef83 AND 0xa9ef70
//          0x3 => Young couple - Middle Ages - Chapter 4 - have changed positions/respawned
// $A9EF8E: [8-bit] Young Couple Side Quest - Chapter 7
//          8-bit >= 0x1 => advised woman to be truthful
//          - Increases by 0x1 after telling woman to be truthful, to a max of 0x1
//          
//          [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - Before Experiment - Only available when this memory address was already >= 0x1
//          - Talk Counts add on top of above explained count
//          - If count was 0 from start, refer to 0xa9ef77
//          - Increases by 0x1 with each interaction with the man starts at 0x1 and to a max of 0x3
// $A9EF8F: [8-bit] Young Couple Side Quest - Chapter 8
//          bit 0 => told the man about the lovers never destined to meet
//          bit 1 => told the man to get over it
// $A9EFDC: [NTSC-U][25-bit Pointer] --> Interactable ID
//          +0x0 - [32-bit] Interactable ID
//          | - This value changes when interacting with something
//          | - Unique per interactable NPC or interactable item
//          | - This value is copied to $0xa9eff4
//          
//          # Interactable_IDs (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''
//          | - 0x10 => NPC_Present_BroadDelinquent
//          | - 0x13 => NPC_Present_SlimDelinquent
//          | - 0x183 => NPC_Present_BlondeElderlyWoman
//          | - 0x187 => NPC_Present_BlondeYoungBoy
//          | - 0x18D => NPC_80s_OlderMan
//          | - 0x195 => NPC_Present_BrunetteAdultManGlasses
//          | - 0x197 => NPC_MiddleAges_YoungCoupleWoman
//          | - 0x198 => NPC_MiddleAges_YoungCoupleMan
//          | - 0x2E => NPC_MiddleAges_EccentricGirl
//          | - 0x42 => NPC_Present_BrunetteYoungGirl
//          | - 0x44 => NPC_Present_BlondeOldWomanOrangeSweater
//          | - 0x46 => NPC_Present_BrunetteMother
//          | - 0x56 => NPC_Present_CoatedMan
//          | - 0x57 => NPC_Present_CoatedWoman
//          | - 0x58 => NPC_Present_JoggingMan
//          | - 0x59 => NPC_80s_JoggingMan
//          | - 0x5C => NPC_MiddleAges_StrawHatMan
//          | - 0x5D => NPC_MiddleAges_AspiringApprentice
//          | - 0xC => NPC_80s_Barman
//          |
//          | - 0x8E => INTERACTABLE_Antique_FranssenShopSign
//          | - 0x98 => INTERACTABLE_Antique_Rope
//          | - 0x79 => INTERACTABLE_Antique_Antidote
//          | - 0xC6 => INTERACTABLE_Antique_Mask
//          | - 0x164 => INTERACTABLE_Painting_SquireCrest
//          | - 0x165 => INTERACTABLE_Painting_TownSquare
//          | - 0x16A => INTERACTABLE_Painting_AlchemyLab
//          | - 0x166 => INTERACTABLE_Painting_Performer
//          | - 0x168 => INTERACTABLE_Painting_CollapsedHouse
//          | - 0x163 => INTERACTABLE_Painting_TowerView
//          | - 0x169 => INTERACTABLE_Painting_LandscapeTown
//          | - 0x167 => INTERACTABLE_Painting_Alchemist
// $A9EFE0: [NTSC-U][25-bit Pointer] --> Interaction Chapter Area ID
//          +0x0 - [32-bit] Interaction Chapter Area ID
//          | - This seems to be a unique value per chapter and area combined, that correlates to interactions
//          | - This is a value which is active during an interaction
//          | - Interactions in the same chapter, have the same value; Interactions in different chapters have differing values
//          
//          # InteractionChapterArea_IDs (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''''''''''
//          | - 0x4b => Chapter5 - AREA_Present_City_NightPM
//          | - 0x3b => Chapter7 - AREA_MiddleAges_City_Day
//          | - 0x13 => Chapter8 - AREA_MiddleAges_City_Day
//          | - 0x44 => Chapter4 - AREA_Present_City_Day
//          | - 0x29 => Chapter4 - AREA_Present_TownHall
//          | - 0x163 => Chapter2 - AREA_MiddleAges_City_Night
//          | - 0xb2 => Chapter7 - AREA_Present_City_NightAM
// $A9EFE4: [NTSC-U][25-bit Pointer] --&gt; Interaction ID
//          - Pointer is only operational during the interaction
//          
//          +0x0 - [32-bit] Interaction ID
//          | - Each interaction has a unique ID
//          
//          # Interaction_IDs (list only contains IDs used in achievement logic)
//          |''''''''''''''''''''''''''''''''''
//          | - 0x416 => NPC_MiddleAges_YoungCoupleMan - Chap5_NearSouthEastGate
//          | - 0x41c => NPC_MiddleAges_YoungCoupleMan - Chap8_OutsideChurch_AfterExperiment_WomanTruthful
//          | - 0x433 => NPC_MiddleAges_YoungCoupleMan - Chap8_OutsideChurch_AfterExperiment_WomanTruthful (2nd talk with man)
//          | - 0x2d0 => NPC_Present_CoatedWoman - Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar
//          | - 0x2c4 => NPC_Present_CoatedMan - Chap3_NearAntiqueShop
//          | - 0x2c5 => NPC_Present_CoatedMan - Chap4_HaupStrUnderArch
//          | - 0x39c => NPC_Present_BlondeYoungBoy - Chap4_WearingPerformerOutfit
//          | - 0x336 => NPC_Present_BrunetteMother - Chap4_WearingPerformerOutfit
//          | - 0x323 => NPC_Present_BrunetteYoungGirl - Chap4_WearingPerformerOutfit
//          | - 0x32c => NPC_Present_BlondeOldWomanOrangeSweater - Chap4_WearingPerformerOutfit
//          | - 0x3c6 => NPC_Present_BrunetteAdultManGlasses - Chap4_WearingPerformerOutfit
//          | - 0x3cc => NPC_Present_BlondeElderlyWoman - Chap4_WearingPerformerOutfit
//          | - 0x314 => NPC_MiddleAges_EccentricGirl - Chap2_TownSquare_Scare
//          | - 0x2da => NPC_MiddleAges_StrawHatMan - Chap2_Streets_Scare
//          | - 0x2e3 => NPC_MiddleAges_AspiringApprentice - Chap2_SouthEastGate_Scare
//          | - 0x2f5 => NPC_Present_SlimDelinquent - Chap7_CarPark
//          | - 0x2f0 => NPC_Present_BroadDelinquent - Chap7_CarPark
//          | - 0x124 => INTERACTABLE_Painting_TowerView
//          | - 0x125 => INTERACTABLE_Painting_SquireCrest
//          | - 0x126 => INTERACTABLE_Painting_TownSquare
//          | - 0x127 => INTERACTABLE_Painting_AlchemyLab
//          | - 0x128 => INTERACTABLE_Painting_Performer
//          | - 0x129 => INTERACTABLE_Painting_CollapsedHouse
// $A9EFF4: [NTSC-U][32-bit] NPC ID (copy)
//          - Value set here is a copy of NPC ID from $0xa9efdc
//          - This value is only active during the interaction
//          - Resets to 0x0 when interaction is done
//          - List of IDs at $0xa9efdc
// $A9F034: [NTSC-U][29-byte Array] List of [Inventory_Item_Objects]
//          ===================================
//          
//          [Struct Defintion][8-bit] Inventory_Item_Object
//          |''''''''''''''''''''''''''''''''''''''''
//          | - Upper4 => correlates to current chapter or the chapter in which item was acquired??
//          | - Lower4 => bit 0/bit 3 => is item in inventory
//          
//          [Inventory_Item_Object] Z-pad/D-pad
// $A9F035: [Inventory_Item_Object] Cellphone
// $A9F036: [Inventory_Item_Object] Ornamental egg
// $A9F038: [Inventory_Item_Object] Frying Pan
// $A9F039: [Inventory_Item_Object] Photo shop sign
// $A9F03A: [Inventory_Item_Object] Lighter
// $A9F03B: [Inventory_Item_Object] Black and white photo without performer
//          - Switches with next byte, after taking the picture with the performer during chapter 4
// $A9F03C: [Inventory_Item_Object] Black and white photo with performer
// $A9F03D: [Inventory_Item_Object] Philosopher's stone
// $A9F03E: [Inventory_Item_Object] New rope
// $A9F03F: [Inventory_Item_Object] Old rope
//          - Is automatically removed when obtaining new rope
// $A9F040: [Inventory_Item_Object] Jugglery
// $A9F041: [Inventory_Item_Object] Comb
// $A9F042: [Inventory_Item_Object] Old alchemist book
// $A9F043: [Inventory_Item_Object] Squire's crest
// $A9F044: [Inventory_Item_Object] Egg shaped pocket watch
// $A9F045: [Inventory_Item_Object] Antidote
// $A9F046: [Inventory_Item_Object] Scrap of meat
// $A9F047: [Inventory_Item_Object] Cake
// $A9F048: [Inventory_Item_Object] Lab key
// $A9F049: [Inventory_Item_Object] Tower key
// $A9F04A: [Inventory_Item_Object]> Letter to Dana
// $A9F04B: [Inventory_Item_Object] Kitten
// $A9F04C: [Inventory_Item_Object] City map
// $A9F04D: [Inventory_Item_Object] Ladder
// $A9F04E: [Inventory_Item_Object] Old city map
// $A9F04F: [Inventory_Item_Object] Notebook
// $A9F050: [Inventory_Item_Object] Postcard
//          \\========================================//
// $A9F074: [NTSC-U][29-bytes] List of [Inventory_Item_Objects] (copy of $0xa9f034)
//          - Values here might only update on save or chapter change
// $A9F111: [NTSC-U][8-bit] Highlighted Inventory Item
//          - Currently only the IDs which are used in achievement logic are documented in this list
//          - ID corresponds to the index of the Inventory_Item_Object in the list described $0xa9f034
//          
//          # ID list
//          ''''''''''''''
//          0x0 = d-pad/z-pad
//          0x1 = cellphone
//          0x2 = ornamental egg
//          (0x3 --> empty entry)
//          0x4 = frying pan
//          0x5 = sign
//          0x6 = lighter
//          0x7 = black and white photo without performer
//          0x8 = black and white photo with performer
//          0x9 = philosopher's stone
//          0xa = new rope
//          0xb = old rope
//          0xc = jugglery
//          0xd = comb
//          0xe = alchemist book
//          0xf = squire's crest
//          0x10 = egg pocket watch
//          0x11 = antidote
//          0x12 = meat
//          0x13 = cake
//          0x14 = lab key
//          0x15 = tower key
//          0x16 = letter to dana
//          0x17 = kitten
//          0x18 = city map
//          0x19 = ladder
//          0x1a = old map
//          0x1b = notebook
//          0x1c = postcard
// $AA1118: [NTSC-U][44-bytes] Best Clear Time Data
//          ============================
//          - Stored in seconds
//          - These values are set when finishing a chapter OR booting up the game (loading previous best clear times)
//          - Will overwrite when the new clear time is better
//          
//          [32-bit] Best clear time - Prologue
// $AA111C: [32-bit] Best clear time - Chapter 1
// $AA1120: [32-bit] Best clear time - Chapter 2
// $AA1124: [32-bit] Best clear time - Chapter 3
// $AA1128: [32-bit] Best clear time - Chapter 4
// $AA112C: [32-bit] Best clear time - Chapter 5
// $AA1130: [32-bit] Best clear time - Chapter 6
// $AA1134: [32-bit] Best clear time - Chapter 7
// $AA1138: [32-bit] Best clear time - Chapter 8
// $AA113C: [32-bit] Best clear time - Epilogue
//          - This is also used for EX Chapter
// $AA1140: [32-bit] Best clear time - Total
// $AA1148: [NTSC-U][11-bytes] Achievement Percentage Number
//          ======================================
//          - These 8-bit values correspond to the rounded number shown in the results menu (e.g. 42% => 8-bit value: 0x2a)
//          - These bytes change when entering the extra menu or the title screen
//          - These bytes are calculated based on the bitset @ 0xa9ed3c
//          
//          [8-bit] Achievement Percentage Number: Prologue
// $AA1149: [8-bit] Achievement Percentage: Chapter 1
// $AA114A: [8-bit] Achievement Percentage: Chapter 2
// $AA114B: [8-bit] Achievement Percentage: Chapter 3
// $AA114C: [8-bit] Achievement Percentage: Chapter 4
// $AA114D: [8-bit] Achievement Percentage: Chapter 5
// $AA114E: [8-bit] Achievement Percentage: Chapter 6
// $AA114F: [8-bit] Achievement Percentage: Chapter 7
// $AA1150: [8-bit] Achievement Percentage: Chapter 8
// $AA1151: [8-bit] Achievement Percentage: Epilogue
// $AA1152: [8-bit] Achievement Percentage: Total
// $AA1154: [NTSC-U][7-bytes] Ending Data
//          ===========================
//          - Flags will make the corresponding ending file viewable in the extra menu
//          - Once one of these is achieved, it will unlock the extra menu at the title screen
//          
//          [Bit Flag] bit 0 => Ending A unlocked
// $AA1155: [Bit Flag] bit 0 => Ending B unlocked
// $AA1156: [Bit Flag] bit 0 => Ending C unlocked
// $AA1157: [Bit Flag] bit 0 => Ending D unlocked
// $AA1158: [Bit Flag] bit 0 => Ending E unlocked
// $AA1159: [Bit Flag] bit 0 => Ending EX unlocked
// $AA115A: [8-bit] Current ending File being watched via the extra menu
//          - Does not reset to a default value after ending file is over
//          0x0 = A
//          0x1 = B
//          0x...
//          0x4 = E
//          0x5 = EX
// $AA115B: [NTSC-U][57-byte Bitset] Achievement Percentage Flags (disfavored)
//          =====================================
//          - prefer using bitset at $0xa9ed3c => since the bitset at this location only updates when saving or at game startup
//          
//          - Each flag corresponds to at least 1 cutscene and counts toward the achievement percentage
//          - Each flag accounts for a float percentage. These numbers are rounded up or down in the extra menu
//          - This is the bitset which is used to calculate the percentages in the results menu
//          
//          [NTSC-U][7-bytes - Bit Flags] Achievement Percentage Flags - Prologue + EX Chapter
//          bits 1-7 => 13+%
// $AA115C: [Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115D: [Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115E: [Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115F: [Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA1160: [Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA1161: [Bit Flags] Prologue + EX Chapter
//          bits 0-5 => 11+%
// $AA1162: [NTSC-U][4-bytes - Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 6-7 => 8+%
// $AA1163: [Bit Flags] Chapter 1
//          all bits => 33+%
// $AA1164: [Bit Flags] Chapter 1
//          all bits => 33+%
// $AA1165: [Bit Flags] Chapter 1
//          bits 0-5 => 25+%
// $AA1166: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 3-7 => 13+%
// $AA1167: [Bit Flags] Chapter 2
//          all bits => 22+%
// $AA1168: [Bit Flags] Chapter 2
//          all bits => 22+%
// $AA1169: [Bit Flags] Chapter 2
//          all bits => 22+%
// $AA116A: [Bit Flags] Chapter 2
//          bits 0-6 => 19+%
// $AA116C: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 1-7 => 19+%
// $AA116D: [Bit Flags] Chapter 4
//          all bits => 22+%
// $AA116E: [Bit Flags] Chapter 4
//          all bits => 22+%
// $AA116F: [Bit Flags] Chapter 4
//          all bits => 22+%
// $AA1170: [Bit Flags] Chapter 4
//          bits 0-4 => 13+%
// $AA1171: [NTSC-U/C][6-bytes - Bit Flags] Achievement Percentage Flags - Chapter 5
//          bits 1-7 => 15+%
// $AA1172: [Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1173: [Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1174: [Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1175: [Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1176: [Bit Flags] Chapter 5
//          bits 0-6 => 15+%
// $AA1177: [NTSC-U][3-bytes - Bit Flags] Achievement Percentage Flags - Chapter 3
//          bits 2-7 => 27+%
// $AA1178: [Bit Flags] Chapter 3
//          all bits => 36+%
// $AA1179: [Bit Flags] Chapter 3
//          all bits => 36+%
// $AA117A: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 2-7 => 17+%
// $AA117B: [Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117C: [Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117D: [Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117E: [Bit Flags] Chapter 6
//          bits 0-4 => 14+%
// $AA117F: [NTSC-U][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 2-7 => 17+%
// $AA1180: [Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1181: [Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1182: [Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1183: [Bit Flags] Chapter 7
//          bits 0-3 => 11+%
// $AA1184: [NTSC-U][10-bytes - Bit Flags]Achievement Percentage Flags - Chapter 8
//          bits 5-7 => 4+%
// $AA1185: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1186: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1187: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1188: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1189: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118A: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118B: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118C: [Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118D: [Bit Flags] Chapter 8
//          bits 0-3 => 5+%
// $AA1190: [NTSC-U][4-bytes - Bit Flags] Achievement Percentage Flags - Epilogue
//          bits 2-7 => 26+%
// $AA1191: [Bit Flags] Epilogue
//          all bits => 34+%
// $AA1192: [Bit Flags] Epilogue
//          all bits => 34+%
// $AA1193: [Bit Flags] Epilogue
//          bit 0 => 4+%
// $AA1258: [NTSC-U][Bit Flag] bit 0 => is current cutscene skippable
// $AA1268: [NTSC-U][32-bit] Time Period
//          - Certain small areas, might have undocumented values
//          0x80 => Middle ages 1500s
//          0x81 => Late 20th Century 1900s
//          0x82 => Early 20th Century 1980
//          0x88 => Early 20th Century 1979
//          0x83 => Present 2000s
// $AA12A4: [NTSC-U][672-byte Array] List of [DateTime_Objects]
//          =============================
//          - Time in present always ticks
//          - Time in other time periods only ticks/changes when in that time period
//          - Some time periods have multiple entries, they correspond to different dates in that time periods
//          
//          [Struct Definition][24-byte] DateTime_Object
//          |'''''''''''''''''''''''''''''''''''''''''
//          | - +0x0 - [32-bit] Year
//          | - +0x4 - [32-bit] Month
//          | - +0x8 - [32-bit] Day (of month)
//          | - +0xc - [32-bit] Hours
//          | - +0x10 - [32-bit] Minutes
//          | - +0x14 - [32-bit] Seconds
//          
//          [DateTime_Object] Present
// $AA12A8: [32-bit] Present - month
// $AA12AC: [32-bit] Present - day
// $AA12B0: [32-bit] Present - hours
// $AA12B4: [32-bit] Present - minutes
// $AA12B8: [32-bit] Present - seconds
// $AA12EC: [DateTime_Object] Date & Time - Night Before - chapter 7
// $AA1304: [DateTime_Object] Date & Time - 1980s (cold day)
// $AA131C: [DateTime_Object] Date & Time - 1979
// $AA134C: [DateTime_Object]  Date & Time -  1902
// $AA1394: [DateTime_Object]  Date & Time - 1584 (daytime - chapter 5 - after experiment)
// $AA13C4: [DateTime_Object]  Date & Time - 1582 (daytime - before experiment)
// $AA155C: [NTSC-U][32-bit] Current Playthrough Timer - Chapter Clear Time
//          - Time in seconds = [32-bit] decimal value / 60
//          - Time in minutes = [32-bit] decimal value / 3600
//          - Value range [0x0-0x57e3f] = [00-99h:59m:59s]; Halts at max (value does not wrap back around to 0)
//          - Restarts counting from 0 on new chapter start
//          - Timer stops when credits video starts playing
//          - Timer does not pause when the inventory is open OR when a cutscene is active
//          - Timer pauses in pause menu or when loading
// $AA1560: [NTSC-U][32-bit] Current Playthrough Timer - Total Clear Time
//          - Explanation at $0xaa155c
// $AA156C: [NTSC-U][32-bit] Prologue: Countdown timer
//          - When timer hits 0 => plays "Sneaking Feeling" cutscene
// $AA4C10: [NTSC-U][25-bit Pointer] Same pointer @ 0xa9ecd4 (see notes)
// $AA55F8: [NTSC-J][8-bit] Energy Units (functional)
//          - Regional equivalent of $0xa9daa8 (USA)
// $AA667E: [NTSC-J][8-bit Flag] Is Player Character Moveable
//          - Regional equivalent of $0xa9eb2e (USA)
// $AA680C: [NTSC-J][124-byte] Cutscene Data
//          =======================
//          - Regional equivalent of $0xa9ecbc (USA)
//          
//          [NTSC-J][32-bit] Cutscene Master ID
// $AA6810: [NTSC-J][16-bit] Cutscene Section ID_1
// $AA6812: [NTSC-J][16-bit] Cutscene Section ID_2
// $AA6818: [NTSC-J][25-bit Pointer] Cutscene Identification - Master Data
// $AA681C: [NTSC-J][25-bit Pointer] Cutscene Identification - Section Data
// $AA6824: [NTSC-J][25-bit Pointer] Cutscene Identification - Minor IDs
// $AA6876: [NTSC-J][8-bit Flag] Is Cutscene Active (preferred)
// $AA6888: [NTSC-J][32-bit] Cutscene Timer
// $AA688C: [NTSC-J][57-bytes Bitset] Achievement Percentage Flags
//          ==============================
//          - Regional equivalent of $0xa9ed3c (USA)
//          
//          [NTSC-J][7-bytes - Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
// $AA6893: [NTSC-J][4-bytes - Bit Flags] Achievement Percentage Flags - Chapter 1
// $AA6897: [NTSC-J][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 2
// $AA689D: [NTSC-J][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 4
// $AA68A2: [NTSC-J][6-bytes - Bit Flags] Achievement Percentage Flags - Chapter 5
// $AA68A8: [NTSC-J][3-bytes - Bit Flags] Achievement Percentage Flags - Chapter 3
// $AA68AB: [NTSC-J][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 6
// $AA68B0: [NTSC-J][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 7
// $AA68B5: [NTSC-J][10-bytes - Bit Flags] Achievement Percentage Flags - Chapter 8
// $AA68C1: [NTSC-J][3-bytes - Bit Flags] Achievement Percentage Flags - Epilogue
// $AA68C6: [NTSC-J][102-byte Bitset] Current Playthrough Bit Flags
//          ===========================
//          - Regional equivalent of $0xa9ed76 (USA)
//          
//          [Bit Flags] Current Playthrough - Multi-chapter
//          bit 0 => talked to Oleg 2nd time in chapter 3
//          bit 7 => gave kitten to Sibylla
// $AA68E8: [Bit Flags] Current Playthrough - EX Chapter
//          bit 7 => is prologue in EX mode - Actually a bitflag for 2nd dialogue option at start of game when all other endings have been achieved: "Oh, Homunculus", which activates EX chapter
// $AA68ED: [Bit Flags] Current Playthrough - Chapter 1
//          bit 5 => put out fire yourself
//          bit 7 => Saved bar from fire by warning barman
// $AA68F0: [Bit Flags] Current Playthrough - Chapter 2
//          bit 0 => acquired ladder
//          bit 1 = 0 => LIGHTER used to scare crowd
//          bit 1 = 1 => TELEPHONE used
//          bit 2 = 0 => Chosen to plant STATUE instead of flowers
//          bit 2 = 1 => Chosen to plant FLOWERS instead of statue
// $AA68F5: [Bit Flags] Current Playthrough - Chapter 4
//          bit 2 => is wearing performer outfit
//          bit 3 => died once without using an iron plate
// $AA68FA: [Bit Flags] Current Playthrough - Brum Estate Choice
//          bit 5 = 0 => Brum Estate is museum
//          bit 5 = 1 => Brum Estate is library
// $AA68FD: [Bit Flags] Current Playthrough - Ancestor Choice - Chapter 5
//          bit 1-3 => walk with margarette
//          bit 4 => 1st ancestor choice
//          bit 5 => cutscene inbetween choices
//          bit 6 => confirm choice: Margarette is NO ancestor, sets on choice (refer to 0xa9edae)
//          bit 7 => confirm choice: Margarette is ancestor, sets on choice, (refer to 0xa9edae)
// $AA68FE: [Bit Flags] Current Playthrough - Ancestor Choice - Chapter 5
//          bit 6 => Margarette is ancestor, sets after leaving alchemist house (refer to 0xa9edad)
//          bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house (refer to 0xa9edad)
// $AA6900: [Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen
//          bit 7 => Antidote painting
//          bit 6 => Marktplatz painting (insinuating removing the tree)
//          bit 5 => Squire's crest painting
//          bit 4 => Tower view painting (downstairs)
// $AA6901: [Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          bit 0 => Performer painting (only possible when player became performer in chapter 4)
//          bit 1 => Achemist house collapse painting
// $AA6907: [Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 5 => Movie choice 1: Meditating Man
//          bit 6 => Movie choice 1: Time Travel
//          bit 7 => Movie choice 2: Take over the world
// $AA6908: [Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 0 => Movie Choice 2: Find cause of own death
//          bit 1 => Movie Choice 3: Thriller story
//          bit 2 => Movie Choice 3: Love story
// $AA6910: [Bit Flags] Current Playthrough - Dana's choice
//          bit 2 = 0 => Take Dana back to present
//          bit 2 = 1 => Leave Dana in the past (is set after cutscene ends)
// $AA6914: [Bit Flags] Current Playthrough - Saved Dana from Past
//          bit 1 => Gave letter to Dana
//          bit 3-4 => Took Dana back to present
// $AA691A: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 6 => payed TAB with egg shaped pocket watch
//          bit 7 => payed COFFEE with egg shaped pocket watch
// $AA691B: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 2 => talked with Oleg 1st time in Chapter 3
//          bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
//          bit 6 => gave kitten to Sibylla
// $AA691C: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch
// $AA692C: [NTSC-J][Lower4 Flag] Is In-Game
//          - Regional equivalent of $0xa9eddc (USA)
// $AA6958: [NTSC-J][436-byte Bitfield] NPC Interaction Data
//          ===================================
//          - Regional equivalent of $00xa9ee08 (USA)
// $AA696D: [8-bit] NPC Talk Count - Coated man - Present - Chapter 1/Prologue - Town Square
// $AA6970: [8-bit] NPC Talk Count - Coated man- Present - Chapter 3 - Near Antique Shop
// $AA6971: [8-bit] NPC Talk Count - Coated man - Present - Chapter 4 - Haup str. under arch
// $AA6972: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Before Eating At Bar
// $AA6974: [8-bit] NPC Talk Count - Coated man - Present - Chapter 7 - North West Gate
// $AA6975: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - After Eating At Bar - Brum Library
// $AA6976: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - After Eating At Bar - Brum Museum
// $AA6978: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 1/Prologue - Town Square
// $AA697C: [8-bit] NPC Talk Count - Coated woman - Present - Chapter3 - Outside antique shop
// $AA697F: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 7 - South Gate
// $AA6980: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne - Before Eating At Bar
// $AA6981: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne - After Eating At Bar
// $AA6983: [8-bit] NPC Talk Count - Mother of young boy (0xa9ee34) - 1900s - At the square
// $AA6984: [8-bit] NPC Talk Count - Young boy - 1900s - At the square
// $AA6986: [8-bit] NPC Talk Count - Straw Hat Man - Middle Ages - Chapter 2 - Streets
//          - When scaring with lighter or cellphone
// $AA6988: [8-bit] Times talked to strolling man: Middle Ages 05/24/1582 - 3-4pm
// $AA698F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
// $AA6999: [8-bit] NPC Talk Count - Barman - Cold Days 1980 - any chapter - inside bar
// $AA699C: [8-bit] NPC Talk Count - Broad delinquent - Present - Chapter 7 - Car Park
// $AA69A1: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
// $AA69BF: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
// $AA69C0: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
//          - When frightening with lighter or cellphone
// $AA69CF: [8-bit] NPC Talk Count - Brunette young girl - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $AA69D8: [8-bit] NPC Talk Count - Blonde old woman - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $AA69E2: [8-bit] NPC Talk Count - Brunette mother - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $AA6A48: [8-bit] NPC Talk Count - Young blonde boy - Present - Chapter 4
//          - Whilst wearing the performer outfit
// $AA6A93: [8-bit] NPC Talk Count - Older man - 1980 - Chapter 6 - Cafe Sonne
// $AA6AB9: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - West Gate
//          - When 0xa9ef89 == 0
// $AA6ABA: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x1
// $AA6ABB: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x3
// $AA6ABC: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well
//          - When 0xa9ef8a == 0
// $AA6ABD: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well
//          - When 0xa9ef8a == 0x1
// $AA6ABE: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Outside church
//          - When 0xa9ef8a == 0x3
// $AA6ABF: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square
//          - When value @ 0xa9ef8b == 0x0
// $AA6AC0: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square
//          - When value @ 0xa9ef8b == 0x1
// $AA6AC1: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Near Marie's Bakery
//          - When value @ 0xa9ef8b == 0x3
// $AA6AC2: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 5 - Near South East Gate
// $AA6AC4: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 7 - Outside church
// $AA6AC6: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Before Experiment
//          - Only when 0xa9ef8e == 0x0
// $AA6AC7: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8
//          - When value @ 0xa9ef8e == 0
// $AA6AC8: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church
//          - After experiment - When value @ 0xa9ef8e >= 0x1
// $AA6ACC: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0
// $AA6ACD: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x1
// $AA6ACE: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay
//          - When 0xa9ef89 == 0x3
// $AA6ACF: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Near North East Gate
//          - When 0xa9ef8a == 0
// $AA6AD0: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Near North East Gate
//          - When 0xa9ef8a == 0x1
// $AA6AD1: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Town square - When 0xa9ef8a == 0x3
// $AA6AD2: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x0
// $AA6AD3: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x1
// $AA6AD4: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church
//          - When value @ 0xa9ef8b == 0x3
//          
//          [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square
//          - In Ancestor and NoAncestor path
// $AA6AD5: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square
//          - Only in Ancestor path
//          - Regional equivalent of $0xa9ef85 (USA)
// $AA6AD9: [8-bit] State Of Young Couple Side Quest - Chapter 2
//          - Regional equivalent of $0xa9ef89 (USA)
// $AA6ADA: [8-bit] State Of Young Couple Side Quest - Chapter 3
//          - Regional equivalent of $0xa9ef8a (USA)
// $AA6ADB: [8-bit] State Of Young Couple Side Quest - Chapter 4
//          - Regional equivalent of $0xa9ef8b (USA)
// $AA6ADE: [8-bit] State Of Young Couple Side Quest - Chapter 7
//          - Regional equivalent of $0xa9ef8e (USA)
// $AA6ADF: [8-bit] State Of Young Couple Side Quest - Chapter 8
//          - Regional equivalent of $0xa9ef8f (USA)
// $AA6B2C: [NTSC-J][25-bit Pointer] --> Interactable ID
//          - Regional equivalent of $0xa9efdc (USA)
// $AA6B30: [NTSC-J][25-bit Pointer] --> Interaction Chapter Area ID
//          - Regional equivalent of $0xa9efe0 (USA)
// $AA6B34: [NTSC-J][25-bit Pointer] --> Interaction ID
//          - Regional equivalent of $0xa9efe4 (USA)
// $AA6B44: [NTSC-J][32-bit] NPC ID copy
//          - Regional equivalent of $0xa9eff4 (USA)
// $AA6B84: [NTSC-J][29-byte Array] List of [Inventory_Item_Objects]
//          ====================================
//          - Regional equivalent of $0xa9f034 (USA)
//          
//          [Inventory_Item_Object] Z-pad/D-pad
// $AA6B85: [Inventory_Item_Object] Cellphone
// $AA6B86: [Inventory_Item_Object] Ornamental egg
// $AA6B88: [Inventory_Item_Object] Frying Pan
// $AA6B89: [Inventory_Item_Object] Photo shop sign
// $AA6B8A: [Inventory_Item_Object] Lighter
// $AA6B8B: [Inventory_Item_Object] Black and white photo without performer
// $AA6B8C: [Inventory_Item_Object] Black and white photo with performer
// $AA6B8D: [Inventory_Item_Object] Philosopher's stone
// $AA6B8E: [Inventory_Item_Object] New rope
// $AA6B8F: [Inventory_Item_Object] Old rope
// $AA6B90: [Inventory_Item_Object] Jugglery
// $AA6B91: [Inventory_Item_Object] Comb
// $AA6B92: [Inventory_Item_Object] Old alchemist book
// $AA6B93: [Inventory_Item_Object] Squire's crest
// $AA6B94: [Inventory_Item_Object] Egg shaped pocket watch
// $AA6B95: [Inventory_Item_Object] Antidote
// $AA6B96: [Inventory_Item_Object] Scrap of meat
// $AA6B97: [Inventory_Item_Object] Cake
// $AA6B98: [Inventory_Item_Object] Lab key
// $AA6B99: [Inventory_Item_Object] Tower key
// $AA6B9A: [Inventory_Item_Object] Letter to Dana
// $AA6B9B: [Inventory_Item_Object] Kitten
// $AA6B9C: [Inventory_Item_Object] City map
// $AA6B9D: [Inventory_Item_Object] Ladder
// $AA6B9E: [Inventory_Item_Object] Old city map
// $AA6B9F: [Inventory_Item_Object] Notebook
// $AA6BA0: [Inventory_Item_Object] Postcard
// $AA6C61: [NTSC-J][8-bit] Highlighted Inventory Item
//          - Regional equivalent of $0xa9f111 (USA)
// $AA8C68: [NTSC-J][44-bytes] Best Clear Time Data
//          - Regional equivalent of $0xaa1118 (USA)
// $AA8C98: [NTSC-J][11-bytes] Achievement Percentage Number
//          - Regional equivalent of $0xaa1148 (USA)
// $AA8CA2: [NTSC-J][8-bit] Achievement Percentage: Total
// $AA8CA4: [NTSC-J][7-bytes] Ending Data
//          - Regional equivalent of $0xaa1154 (USA)
// $AA8DA8: [NTSC-J][Bit Flag] bit 0 => is current cutscene skippable
// $AA8DB8: [NTSC-J][32-bit] Time Period
//          - Regional equivalent of $0xaa1268 (USA)
// $AA8DF4: [NTSC-J][672-byte Array] List of [DateTime_Objects]
//          - Regional equivalent of $0xaa12a4 (USA)
// $AA90AC: [NTSC-J][32-bit] Current Playthrough Timer - Chapter Clear Time
//          - Regional equivalent of $0xaa155c (USA)
// $AA90B0: [NTSC-J][32-bit] Current Playthrough Timer - Total Clear Time
//          - Regional equivalent of $0xaa1560 (USA)
// $AC3170: [NTSC-U][25-bit Pointer] Extra Menu Navigation
//          - Pointer is active when in the extra menu
//          - Extra menu is only visible once at least one is ending is achieved
//          
//          +0x4 - [32-bit] Extra Menu: Highlighted item
//          | - 0x0 => Event viewer (replay unlocked cutscenes)
//          | - 0x1 => Ending files (replay ending cutscenes)
//          | - 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
//          | - 0x3 => Sound Mode (Play sound effects & music)
//          | - 0x4 => Exit (back to Title Screen)
//          
//          +0x14 - [32-bit] Extra Menu: Highlighted ending file
//          | - 0x0 => ending A
//          | - 0x1 => ending B
//          | - 0x2 => ending C
//          | - 0x3 => ending D
//          | - 0x4 => ending E
//          | - 0x5 => ending EX
//          
//          +0x48 - [32-bit] Results Menu/Event Viewer: Highlighted chapter
//          | - 0x0 => Prologue
//          | - 0x1 => Chapter 1
//          | - ...
//          | - 0x8 => Chapter 8
//          | - 0x9 => Epilogue
//          | - 0xa => Total
//          | - 0xb => Exit
// $AC3178: [NTSC-U][25-bit Pointer] Ending File Data
//          - Pointer is active when an ending file is being viewed via extra menu
//          
//          +0x8 - [32-bit] Ending file timer
//          +0xc - [16-bit] Ending file subtitle ID
//          | - This value changes on subtitle change
//          
//          +0x10 - [8-bit] Ending File ID
//          | - 0x0 => ending file A
//          | - 0x1 => ending file B
//          | - ...
//          | - 0x4 => ending file E
//          | - 0x5 => ending file EX
// $AC31E4: [NTSC-U][32-bit] Bottom screen text ID
//          - Identifies a series of text lines at the bottom of the screen (subtitles or in a menu)
//          - This ID does not change on every text change, only sometimes
// $AC31E8: [INFO] Bottom Screen Text Character Print System
//          ==========================================
//          - The text at the bottom of the screen (subtitles & info in menu's) is printed on the screen via a transparent character set image, which is masked to show only 1 character at a time. Functional with offset and different character sets (ex. latin, chinese) (more info below)
//          
//          [NTSC-U][Variable Length Array] List of [Character_Print_Data_Objects]
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          | - Size is dependent on the amount of characters on the bottom screen (1 character == 1 object)
//          | - A space doesn't count as an object; Special characters (eg .?!') do
//          | - 1st character corresponds to the first letter on the first line; the last char corresponds to the last letter in the last line
//          |
//          | [Struct Definition][16-byte] Character_Print_Data_Object
//          | |'''''''''''''''''''''''''''''''''''''''''''''''''
//          | | +0x0 - [16-bit] Some control data (unknown usage)
//          | | +0x2 - [8-bit] Height of character
//          | | ¨¨¨¨¨¨¨¨ [Lower4] Sub height (in-between lines)
//          | | ¨¨¨¨¨¨¨¨ [Upper4] Main height
//          | | ¨¨¨¨¨¨¨¨¨¨¨¨ 4 => prints to first line
//          | | ¨¨¨¨¨¨¨¨¨¨¨¨ 5 => prints to second line
//          | | +0x6 - [8-bit] Print location x-axis
//          | | +0xa - [8-bit] Image offset x-axis
//          | | +0xb - [8-bit] Image offset y-axis
//          | | +0xc - [8-bit] Unmask width
//          | | ¨¨¨¨¨¨¨¨ Higher value => more of the image is visible
//          | | +0xd - [8-bit] Print location y-axis
//          | | +0xe - [8-bit] Character set ID
//          | | ¨¨¨¨¨¨¨¨ Default for USA version is 0x8 = latin characters
//          | | ¨¨¨¨¨¨¨¨ There seems to be 15 characters sets; starting from 0x0 up to 0x14; higher than this value defaults to latin characters
//          | | ¨¨¨¨¨¨¨¨ All characters sets are presumably on one big character set image, so this value here might just be another offset
// $AC49F4: [NTSC-U][32-bit] Extra Menu State
//          - 0x0 => not inside extra menu; --> thus: value > 0 => extra menu is active
//          - 0x4 => extra menu is displayed
//          - 0xb => viewing ending file
//          - 0x12 => event viewer menu is displayed
//          - 0x16 => results menu is displayed
//          - 0x1a => sound mode menu is displayed
//          
//          +0x4 - [32-bit] Extra Menu State
//          - 0x1 => viewing ending file via extra menu
//          - 0x3 => event viewer menu is displayed
//          - 0x8 => viewing cutscene via event viewer
// $ACACB0: [NTSC-J][25-bit Pointer] Extra Menu Navigation
//          - Regional equivalent of $0xac3170 (USA)
// $ACACB8: [NTSC-J][25-bit Pointer] Ending File Data
//          - Regional equivalent of $0xac3178 (USA)
// $ACAD24: [NTSC-J][32-bit] Bottom screen text ID
//          - Regional equivalent of $0xac31e4 (USA)
// $ACAD28: [NTSC-J][Variable Length Array] List of [Character_Print_Data_Objects]
//          - Regional equivalent of $0xac31e8 (USA)
// $ACC534: [NTSC-J][32-bit] Extra Menu State
//          - Regional equivalent of $0xac49f4 (USA)
// $AD1E48: [NTSC-J][Bit Flag] bit 0 => Is Map Open
// $B1EB08: [NTSC-U/C][Bit Flag] bit 0 => Is Map Open
// $B26648: [NTSC-J][Bit Flag] bit 0 => Is Map Open
//          - Identical to $0xad1e48
// $B88AB0: [NTSC-U/C][32-bit] Frame Timer
// $B905F0: [NTSC-J][32-bit] Frame Timer
// $B91514: [NTSC-U][Bit Flag] bit 0 => Is In-Game Pause Menu Displayed
//          +0x4 - [Bit Flag] bit 0 => Is In-Game Pause Menu Displayed (identical bitflag)
// $B95704: [NTSC-U][8-bit] Chapter ID
//          - 0x1 = Prologue/EX Chapter
//          - 0x2 = Chapter 1
//          - 0x3 = Chapter 2
//          - 0x4 = Chapter 3
//          - 0x5 = Chapter 4
//          - 0x6 = Chapter 5
//          - 0x7 = Chapter 6
//          - 0x8 = Chapter 7
//          - 0x9 = Chapter 8 -> when in Chapter 5, player told Margarette she's an ancestor
//          - 0xa = Epilogue -> when in Chapter 5, player told Margarette she's an ancestor
//          - 0xb = Chapter 8 -> when in Chapter 5, player told Margarette she's NOT an ancestor
//          - 0xc = Epilogue -> when in Chapter 5, player told Margarette she's NOT an ancestor
// $B99094: [NTSC-J][Bit Flag] Is In-Game Pause Menu Displayed
//          +0x4 - [Bit Flag] bit 0 => Is In-Game Pause Menu Displayed (identical bitflag)
// $B99098: [NTSC-J][Bit Flag] Identical at $0xb99094
// $B9D284: [NTSC-J][8-bit] Chapter ID
//          - Explanation @ 0xb95704
// $1FFF0E8: [NTSC-U][NTSC-J][8-bit] Event viewer: Highlighted chapter
//           - 0x0 = Prologue
//           - 0x1 = Chapter 1
//           - 0x2 = Chapter 2
//           - ...
//           - 0x8 = Chapter 8
//           - 0x9 = Epilogue
// $1FFF114: [NTSC-U][NTSC-J][16-bit] Selected cutscene in the event viewer
//           - Event viewer is unlocked after completing one ending
//           - Starts from 0x0
// $1FFF130: [NTSC-U][NTSC-J][32-bit Flag] Is Event Viewer Active (preferred)
//           - 0x21 => event viewer menu is displayed OR a cutscene is being watched via this menu
//           - other values => not in event viewer
//           
//           ⚠ Do not use this as a solo condition to check if event viewer is active. --> Use with $0xac3170
// $1FFF3C0: [NTSC-U][NTSC-J][25-bit Pointer]
//           - Pointer is active when in extra menu
//           - Same pointer at $0xac3170
// $1FFF5F4: [NTSC-U][NTSC-J][32-bit Flag] Is Chapter Complete Screen Active
//           0x21 => chapter completion screen OR in-game pause menu is active
// $1FFF5F8: [NTSC-U][NTSC-J][32-bit] Menu ID
//           - 0x1 => chapter completed screen OR in-game pause menu
//           - 0x3 => extra menu
//           - 0x11 => title screen
//           - 0x114 => options menu
//           - any other value => other menu OR something else on screen
// $1FFF604: [NTSC-U][NTSC-J][8-bit] Highlighted Button At Title Screen
//           - 0x1 => Start
//           - 0x2 => Continue
//           - 0x3 => Option
//           - 0x4 => Extra
// $1FFFFF0: [NTSC-U][NTSC-J][Upper4] Always_Null || Value_Never_Changes
//           - This is used for converting floats to floored integers via RAtools

ChapterLookup = {
    1: "Defying destiny",
    2: "Extinguishing the heat",
    3: "Exploring Lebensbaum",
    4: "Visiting the art museum",
    5: "Searching for an iron plate",
    6: "Amalgamating an antidote",
    7: "Producing a film",
    8: "Examining a tower",
    9: "Seeking the red stone",
    10: "Cheating death",
    11: "Seeking the red stone",
    12: "Cheating death",
}

FatedHourLookup = {
    1: "14:30",
    2: "15:00",
    3: "15:30",
    4: "17:50",
    5: "20:30",
    6: "22:30",
    7: "23:55",
    8: "01:30",
    9: "04:30",
    10: "04:30",
    11: "04:30",
    12: "04:30",
}

PresentTimeHours_ZeroPaddingLookup = {
    10: "",
    11: "",
    12: "",
    13: "",
    14: "",
    15: "",
    16: "",
    17: "",
    18: "",
    19: "",
    20: "",
    21: "",
    22: "",
    23: "",
}

PresentTimeMinutes_ZeroPaddingLookup = {
    10: "",
    11: "",
    12: "",
    13: "",
    14: "",
    15: "",
    16: "",
    17: "",
    18: "",
    19: "",
    20: "",
    21: "",
    22: "",
    23: "",
    24: "",
    25: "",
    26: "",
    27: "",
    28: "",
    29: "",
    30: "",
    31: "",
    32: "",
    33: "",
    34: "",
    35: "",
    36: "",
    37: "",
    38: "",
    39: "",
    40: "",
    41: "",
    42: "",
    43: "",
    44: "",
    45: "",
    46: "",
    47: "",
    48: "",
    49: "",
    50: "",
    51: "",
    52: "",
    53: "",
    54: "",
    55: "",
    56: "",
    57: "",
    58: "",
    59: "",
}

TimePeriodLookup = {
    128: "in the Middle Ages",
    129: "in the early 20th century",
    130: "in the late 20th century",
    131: "in the Present",
    136: "in the late 20th century",
}

achievement(
    title = "[VOID]", points = 0,
    description = "VOID",
    id = 420266, badge = "00000", published = "23/04/2024 8:16:40", modified = "23/04/2024 8:17:27",
    trigger = dword(0xA8CC54) != prev(dword(0xA8CC54))
)

achievement(
    title = "Defied Fate", points = 5, type="progression",
    description = "Complete the Prologue",
    id = 306884, badge = "461667", published = "5/04/2023 15:44:04", modified = "17/04/2024 14:53:09",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 1) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 140416 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 592832 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 1 && byte(0xB95704) == 2) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 1) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 140416 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 592832 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 1 && byte(0xB9D284) == 2))
)

achievement(
    title = "That's a Big No No", points = 2, type="missable",
    description = "Warn yourself of your impending demise during the Prologue",
    id = 306883, badge = "465973", published = "5/04/2023 15:44:04", modified = "23/04/2024 8:16:18",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 39936 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 39936 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 39936 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 145344 && prior(dword(0xAA680C)) == 39936 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Defied Fate... Again", points = 3, type="progression",
    description = "Complete Chapter 1 by personally quelling the looming danger",
    id = 306886, badge = "465974", published = "5/04/2023 15:44:05", modified = "17/04/2024 14:53:09",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0 &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 2 && dword(0xA9ECBC) == 72256 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0 && prev(byte(0xB95704)) == 2 && byte(0xB95704) == 3) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit5(0xAA68ED) == 1 && bit7(0xAA68ED) == 0 &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 2 && dword(0xAA680C) == 72256 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                bit5(0xAA68ED) == 1 && bit7(0xAA68ED) == 0 && prev(byte(0xB9D284)) == 2 && byte(0xB9D284) == 3))
)

achievement(
    title = "There's a Fire!", points = 3, type="progression",
    description = "Complete Chapter 1 by notifying the young boy's grandpa of an approaching threat",
    id = 306976, badge = "470256", published = "6/04/2023 11:45:22", modified = "23/04/2024 8:16:18",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit5(0xA9ED9D) == 0 && bit7(0xA9ED9D) == 1 &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 2 && dword(0xA9ECBC) == 72256 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                bit5(0xA9ED9D) == 0 && bit7(0xA9ED9D) == 1 && prev(byte(0xB95704)) == 2 && byte(0xB95704) == 3) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit5(0xAA68ED) == 0 && bit7(0xAA68ED) == 1 &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 2 && dword(0xAA680C) == 72256 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                bit5(0xAA68ED) == 0 && bit7(0xAA68ED) == 1 && prev(byte(0xB9D284)) == 2 && byte(0xB9D284) == 3))
)

achievement(
    title = "A Performer's Clue", points = 2, type="missable",
    description = "Receive a gift from an entertainer in Chapter 1",
    id = 306885, badge = "465975", published = "5/04/2023 15:44:04", modified = "17/04/2024 14:52:31",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                disable_when(byte(0xB95704) != 2, until=(prev(byte(0xB95704)) != 2 && byte(0xB95704) == 2)) &&
                disable_when(low4(0xA9EDDC) == 0, until=) && disable_when(dword(0xAC49F4) != 0, until=) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 103296 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(bit0(0xA9F036) == 1) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                disable_when(byte(0xB9D284) != 2, until=(prev(byte(0xB9D284)) != 2 && byte(0xB9D284) == 2)) &&
                disable_when(low4(0xAA692C) == 0, until=) && disable_when(dword(0xACC534) != 0, until=) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 103296 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(bit0(0xAA6B86) == 1) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Jovial Exchange", points = 3, type="missable",
    description = "Exchange an egg for a pan during Chapter 1, 3 or 4",
    id = 306977, badge = "465977", published = "6/04/2023 11:45:22", modified = "17/04/2024 14:53:15",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never((byte(0xB95704) != 2 && byte(0xB95704) != 4 && byte(0xB95704) != 5)) &&
                tally(1,
                    once((byte(0xB95704) == 2 || byte(0xB95704) == 5) && byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 &&
                    dword(0xA9ECBC) == 195008 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once(byte(0xA9ED26) == 5 && byte(0xB95704) == 4 && bit0(0xA9F036) == 1 && dword(0xA9ECBC) == 205312 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never((byte(0xB9D284) != 2 && byte(0xB9D284) != 4 && byte(0xB9D284) != 5)) &&
                tally(1,
                    once((byte(0xB9D284) == 2 || byte(0xB9D284) == 5) && byte(0xAA6876) == 5 && bit0(0xAA6B86) == 1 &&
                    dword(0xAA680C) == 195008 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once(byte(0xAA6876) == 5 && byte(0xB9D284) == 4 && bit0(0xAA6B86) == 1 && dword(0xAA680C) == 205312 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Enigmatic Couple I: Prelude", points = 3, type="missable",
    description = "Identify the coated man and woman in the Present during the Prologue or Chapter 1",
    id = 307495, badge = "465978", published = "9/04/2023 8:08:50", modified = "4/05/2024 12:40:55",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 885) &&
                unless((byte(0xB95704) != 1 && byte(0xB95704) != 2)) &&
                once(((prev(byte(0xA9EE28)) + prev(byte(0xA9EE1D))) == 3) && (byte(0xA9EE28) + byte(0xA9EE1D)) == 4) &&
                measured((byte(0xA9EE28) + byte(0xA9EE1D)) == 4) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 885) &&
                unless((byte(0xB9D284) != 1 && byte(0xB9D284) != 2)) &&
                once(((prev(byte(0xAA6978)) + prev(byte(0xAA696D))) == 3) && (byte(0xAA6978) + byte(0xAA696D)) == 4) &&
                measured((byte(0xAA6978) + byte(0xAA696D)) == 4) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Enigmatic Couple II: Tailing", points = 3, type="missable",
    description = "Discover the coated man and woman in the Present during Chapter 3",
    id = 310131, badge = "465979", published = "19/04/2023 11:41:41", modified = "4/05/2024 12:40:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 885) && unless(byte(0xB95704) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE20) > prev(byte(0xA9EE20)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 885) && unless(byte(0xB95704) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE20) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 885) && unless(byte(0xB9D284) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA697C) > prev(byte(0xAA697C)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6970) > prev(byte(0xAA6970)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 708))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 885) && unless(byte(0xB9D284) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA697C) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && byte(0xAA6970) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 708))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Enigmatic Couple III: Wandering Once More", points = 3, type="missable",
    description = "Seek out the coated man and woman in the Present during Chapter 4",
    id = 310134, badge = "465980", published = "19/04/2023 12:50:26", modified = "4/05/2024 12:40:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 885) && unless(byte(0xB95704) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE21) > prev(byte(0xA9EE21)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 885) && unless(byte(0xB95704) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE21) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 885) && unless(byte(0xB9D284) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA697C) > prev(byte(0xAA697C)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6971) > prev(byte(0xAA6971)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 709))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 885) && unless(byte(0xB9D284) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA697C) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && byte(0xAA6971) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 709))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Enigmatic Couple IV: Origins", points = 3, type="missable",
    description = "Encounter the coated man and woman in the Present during Chapter 5",
    id = 310135, badge = "465981", published = "19/04/2023 15:36:31", modified = "4/05/2024 12:40:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 3) && unless(byte(0xB95704) != 6) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && prev(dword(0xA9EFF4)) != 87 &&
                    dword(0xA9EFF4) == 87 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && prev(dword(0xA9EFF4)) != 86 &&
                    dword(0xA9EFF4) == 86 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 3) && unless(byte(0xB9D284) != 6) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && prev(dword(0xAA6B44)) != 87 &&
                    dword(0xAA6B44) == 87 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && prev(dword(0xAA6B44)) != 86 &&
                    dword(0xAA6B44) == 86 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Enigmatic Couple V: Epilogue", points = 3, type="missable",
    description = "Find the coated man and woman in the Present during Chapter 7",
    id = 315564, badge = "465982", published = "7/05/2023 18:08:32", modified = "4/05/2024 12:40:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 68) && unless(byte(0xB95704) != 8) &&
                once(((prev(byte(0xA9EE2F)) + prev(byte(0xA9EE24))) == 2) && (byte(0xA9EE2F) + byte(0xA9EE24)) == 3) &&
                measured((byte(0xA9EE2F) + byte(0xA9EE24)) == 3) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 68) && unless(byte(0xB9D284) != 8) &&
                once(((prev(byte(0xAA697F)) + prev(byte(0xAA6974))) == 2) && (byte(0xAA697F) + byte(0xAA6974)) == 3) &&
                measured((byte(0xAA697F) + byte(0xAA6974)) == 3) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Left in the Past", points = 5, type="progression",
    description = "Complete Chapter 2",
    id = 306922, badge = "465983", published = "5/04/2023 22:42:49", modified = "23/04/2024 8:16:19",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 3 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 242240 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 3 && byte(0xB95704) == 4) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 3 && byte(0xAA6C61) == 0 && dword(0xAA680C) == 242240 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 3 && byte(0xB9D284) == 4))
)

achievement(
    title = "Cracking Open the Past: Middle Ages", points = 3, type="missable",
    description = "Present the barman's ancestor with your egg collection in Chapter 2",
    id = 307023, badge = "468296", published = "6/04/2023 20:16:21", modified = "23/04/2024 8:16:19",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 2 && dword(0xA9ECBC) == 56832 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 2 && dword(0xAA680C) == 56832 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Terror of Destinies", points = 3, type="missable",
    description = "Attempt to sow fear among numerous individuals within Chapter 2",
    id = 404046, badge = "465985", published = "2/03/2024 21:18:08", modified = "23/04/2024 8:16:19",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                measured(tally(6,
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 16 && byte(0xA9F111) == 1 && dword(0xA9ECBC) == 36864 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 36864),
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 1 && dword(0xA82E48) == 828 &&
                    dword(0xA9ECBC) == 814592 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 6 && dword(0xA82E48) == 828 &&
                    dword(0xA9ECBC) == 689344 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 5 && dword(0xA82E48) == 828 &&
                    dword(0xA9ECBC) == 39104 && word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 52528 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 39056),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 1 && dword(0xA82E48) == 828 &&
                    byte(0xA9EE70) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 788),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 1 && dword(0xA82E48) == 828 &&
                    byte(0xA9EE36) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 730),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 1 && dword(0xA82E48) == 828 &&
                    byte(0xA9EE3F) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 739))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                measured(tally(6,
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 16 && byte(0xAA6C61) == 1 && dword(0xAA680C) == 36864 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 36864),
                    once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 1 && dword(0xA8A998) == 828 &&
                    dword(0xAA680C) == 814592 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 6 && dword(0xA8A998) == 828 &&
                    dword(0xAA680C) == 689344 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once((byte(0xAA6C61) == 6 || byte(0xAA6C61) == 1) && byte(0xAA6876) == 5 && dword(0xA8A998) == 828 &&
                    dword(0xAA680C) == 39104 && word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 52528 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 39056),
                    once((byte(0xAA6C61) == 6 || byte(0xAA6C61) == 1) && byte(0xAA6876) == 1 && dword(0xA8A998) == 828 &&
                    byte(0xAA69C0) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 788),
                    once((byte(0xAA6C61) == 6 || byte(0xAA6C61) == 1) && byte(0xAA6876) == 1 && dword(0xA8A998) == 828 &&
                    byte(0xAA6986) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 730),
                    once((byte(0xAA6C61) == 6 || byte(0xAA6C61) == 1) && byte(0xAA6876) == 1 && dword(0xA8A998) == 828 &&
                    byte(0xAA698F) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 739))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Met You Before", points = 2, type="missable",
    description = "Keep chatting with Dana under the Marktplatz tree during Chapter 2, even as whispers of fate gently caress the periphery of your dialogue",
    id = 306888, badge = "465986", published = "5/04/2023 18:19:09", modified = "17/04/2024 14:52:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 451712 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 112448 && prior(dword(0xA9ECBC)) == 451712 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 451712 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 112448 && prior(dword(0xAA680C)) == 451712 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Blossoming Plan", points = 1, type="missable",
    description = "Set up a floral display in Chapter 2",
    id = 306920, badge = "465987", published = "5/04/2023 22:23:23", modified = "17/04/2024 14:53:16",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 && bit2(0xA9EDA0) == 1 && dword(0xA9ECBC) == 242240 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 && bit2(0xAA68F0) == 1 && dword(0xAA680C) == 242240 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Pyromancer's Legacy", points = 1, type="missable",
    description = "Ascend to reverence as a pyrokinetic in Chapter 2",
    id = 306911, badge = "465988", published = "5/04/2023 19:43:29", modified = "17/04/2024 14:52:38",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 && bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 0 &&
                    dword(0xA9ECBC) == 242240 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 && bit2(0xAA68F0) == 0 && bit1(0xAA68F0) == 0 &&
                    dword(0xAA680C) == 242240 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Magician's Legacy", points = 1, type="missable",
    description = "Ascend to renown as a magician in Chapter 2",
    id = 306906, badge = "465989", published = "5/04/2023 19:28:48", modified = "17/04/2024 14:52:44",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 && bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 1 &&
                    dword(0xA9ECBC) == 242240 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 && bit2(0xAA68F0) == 0 && bit1(0xAA68F0) == 1 &&
                    dword(0xAA680C) == 242240 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Yesteryears Couple I: Destined to Miss", points = 3, type="missable",
    description = "Aid a bewildered young couple in their reunion amidst the Medieval era during Chapter 2",
    id = 306984, badge = "465990", published = "6/04/2023 16:26:09", modified = "4/05/2024 12:40:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 828) && unless(byte(0xB95704) != 3) &&
                once(((prev(byte(0xA9EF7C)) + prev(byte(0xA9EF7D)) + prev(byte(0xA9EF7E)) + prev(byte(0xA9EF69)) +
                    prev(byte(0xA9EF6A)) + prev(byte(0xA9EF6B))) == 5) &&
                    (byte(0xA9EF7C) + byte(0xA9EF7D) + byte(0xA9EF7E) + byte(0xA9EF69) + byte(0xA9EF6A) + byte(0xA9EF6B)) == 6
                ) &&
                measured((byte(0xA9EF7C) + byte(0xA9EF7D) + byte(0xA9EF7E) + byte(0xA9EF69) + byte(0xA9EF6A) +
                    byte(0xA9EF6B)) == 6
                ) && byte(0xA9EF89) == 3 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 828) && unless(byte(0xB9D284) != 3) &&
                once(((prev(byte(0xAA6ACC)) + prev(byte(0xAA6ACD)) + prev(byte(0xAA6ACE)) + prev(byte(0xAA6AB9)) +
                    prev(byte(0xAA6ABA)) + prev(byte(0xAA6ABB))) == 5) &&
                    (byte(0xAA6ACC) + byte(0xAA6ACD) + byte(0xAA6ACE) + byte(0xAA6AB9) + byte(0xAA6ABA) + byte(0xAA6ABB)) == 6
                ) &&
                measured((byte(0xAA6ACC) + byte(0xAA6ACD) + byte(0xAA6ACE) + byte(0xAA6AB9) + byte(0xAA6ABA) +
                    byte(0xAA6ABB)) == 6
                ) && byte(0xAA6AD9) == 3 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Yesteryears Couple II: The Place Where We Nigh Met", points = 3, type="missable",
    description = "Weave the threads of fate into another chance at reunion for a lost young couple amidst the Medieval era during Chapter 3",
    id = 310133, badge = "465991", published = "19/04/2023 12:50:26", modified = "4/05/2024 12:40:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 828) && unless(byte(0xB95704) != 4) &&
                once(((prev(byte(0xA9EF7F)) + prev(byte(0xA9EF80)) + prev(byte(0xA9EF81)) + prev(byte(0xA9EF6C)) +
                    prev(byte(0xA9EF6D)) + prev(byte(0xA9EF6E))) == 5) &&
                    (byte(0xA9EF7F) + byte(0xA9EF80) + byte(0xA9EF81) + byte(0xA9EF6C) + byte(0xA9EF6D) + byte(0xA9EF6E)) == 6
                ) &&
                measured((byte(0xA9EF7F) + byte(0xA9EF80) + byte(0xA9EF81) + byte(0xA9EF6C) + byte(0xA9EF6D) +
                    byte(0xA9EF6E)) == 6
                ) && byte(0xA9EF8A) == 3 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 828) && unless(byte(0xB9D284) != 4) &&
                once(((prev(byte(0xAA6ACF)) + prev(byte(0xAA6AD0)) + prev(byte(0xAA6AD1)) + prev(byte(0xAA6ABC)) +
                    prev(byte(0xAA6ABD)) + prev(byte(0xAA6ABE))) == 5) &&
                    (byte(0xAA6ACF) + byte(0xAA6AD0) + byte(0xAA6AD1) + byte(0xAA6ABC) + byte(0xAA6ABD) + byte(0xAA6ABE)) == 6
                ) &&
                measured((byte(0xAA6ACF) + byte(0xAA6AD0) + byte(0xAA6AD1) + byte(0xAA6ABC) + byte(0xAA6ABD) +
                    byte(0xAA6ABE)) == 6
                ) && byte(0xAA6ADA) == 3 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Yesteryears Couple III: Destiny's Promise Fulfilled", points = 3, type="missable",
    description = "Successfully orchestrate the reunion of the lost young couple amidst the Medieval era during Chapter 4",
    id = 309393, badge = "465992", published = "17/04/2023 19:03:08", modified = "4/05/2024 12:40:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 828) && unless(byte(0xB95704) != 5) &&
                once(((prev(byte(0xA9EF82)) + prev(byte(0xA9EF83)) + prev(byte(0xA9EF84)) + prev(byte(0xA9EF6F)) +
                    prev(byte(0xA9EF70)) + prev(byte(0xA9EF71))) == 5) &&
                    (byte(0xA9EF82) + byte(0xA9EF83) + byte(0xA9EF84) + byte(0xA9EF6F) + byte(0xA9EF70) + byte(0xA9EF71)) == 6
                ) &&
                measured((byte(0xA9EF82) + byte(0xA9EF83) + byte(0xA9EF84) + byte(0xA9EF6F) + byte(0xA9EF70) +
                    byte(0xA9EF71)) == 6
                ) && byte(0xA9EF8B) == 3 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                    low4(0xA9EDDC) == 0)
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 828) && unless(byte(0xB9D284) != 5) &&
                once(((prev(byte(0xAA6AD2)) + prev(byte(0xAA6AD3)) + prev(byte(0xAA6AD4)) + prev(byte(0xAA6ABF)) +
                    prev(byte(0xAA6AC0)) + prev(byte(0xAA6AC1))) == 5) &&
                    (byte(0xAA6AD2) + byte(0xAA6AD3) + byte(0xAA6AD4) + byte(0xAA6ABF) + byte(0xAA6AC0) + byte(0xAA6AC1)) == 6
                ) &&
                measured((byte(0xAA6AD2) + byte(0xAA6AD3) + byte(0xAA6AD4) + byte(0xAA6ABF) + byte(0xAA6AC0) +
                    byte(0xAA6AC1)) == 6
                ) && byte(0xAA6ADB) == 3 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                    low4(0xAA692C) == 0)
                ) && always_false()))
)

achievement(
    title = "Yesteryears Couple IV: Man-in-waiting", points = 1, type="missable",
    description = "Assess the developments surrounding the young man amidst the Medieval era during Chapter 5",
    id = 310162, badge = "465993", published = "19/04/2023 19:39:22", modified = "17/04/2024 14:52:31",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
                once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 1011 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF72) > prev(byte(0xA9EF72)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1046
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 6) &&
                once(byte(0xAA6876) == 1 && dword(0xA8A998) == 1011 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6AC2) > prev(byte(0xAA6AC2)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1046
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple V: Parting", points = 3, type="missable",
    description = "Review the latest occurrences involving the young couple amidst the Medieval era during Chapter 7",
    id = 314753, badge = "465994", published = "5/05/2023 8:33:58", modified = "17/04/2024 14:52:31",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 1011) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && prev(dword(0xA9EFF4)) != 407 &&
                    dword(0xA9EFF4) == 407 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && prev(dword(0xA9EFF4)) != 408 &&
                    dword(0xA9EFF4) == 408 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != 8) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 1011) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && prev(dword(0xAA6B44)) != 407 &&
                    dword(0xAA6B44) == 407 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 59),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && prev(dword(0xAA6B44)) != 408 &&
                    dword(0xAA6B44) == 408 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 59))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != 8) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Yesteryears Couple VI: Never Destined to Meet", points = 5, type="missable",
    description = "Share a piece of wisdom with the young man and assess his interpretation amidst the Medieval era during Chapter 8",
    id = 315568, badge = "465995", published = "7/05/2023 18:08:33", modified = "23/04/2024 8:16:19",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(dword(0xA82E48) != 1011) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    prev(byte(0xA9EF78)) == 0 && byte(0xA9EF78) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1052), repeated(2,
                    byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) == 0 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1075))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never(((byte(0xB95704) != 11 && byte(0xB95704) != 9) || low4(0xA9EDDC) == 0) &&
                    dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(dword(0xA8A998) != 1011) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && byte(0xAA6ADE) >= 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    prev(byte(0xAA6AC8)) == 0 && byte(0xAA6AC8) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1052), repeated(2,
                    byte(0xAA6876) == 1 && byte(0xAA6ADE) >= 1 && bit0(0xAA6ADF) == 1 && bit1(0xAA6ADF) == 0 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1075))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never(((byte(0xB9D284) != 11 && byte(0xB9D284) != 9) || low4(0xAA692C) == 0) &&
                    dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: Present Day", points = 5,
    description = "Locate five unique energy orbs scattered across present-day Lebensbaum",
    id = 399816, badge = "461689", published = "19/02/2024 14:12:16", modified = "17/04/2024 14:53:04",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                unless((dword(0xA82E48) != 885 && dword(0xA82E48) != 68 && dword(0xA82E48) != 3)) &&
                once((((prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005))) + (prev(bit0((dword(0xA442EC) & 0x1FFFFFF)
                    + 0x000008))) + (prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442EC) &
                    0x1FFFFFF) + 0x000006))) + prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007))) == 4) &&
                    ((bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005)) + (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008)) +
                    (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006)) +
                    bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007)) == 5
                ) &&
                measured(tally(5,
                    once(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
                    0x000005))),
                    once(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
                    0x000008))),
                    once(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
                    0x000004))),
                    once(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
                    0x000006))),
                    once(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
                    0x000007))))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                unless((dword(0xA8A998) != 885 && dword(0xA8A998) != 68 && dword(0xA8A998) != 3)) &&
                once((((prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005))) + (prev(bit0((dword(0xA450BC) & 0x1FFFFFF)
                    + 0x000008))) + (prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450BC) &
                    0x1FFFFFF) + 0x000006))) + prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007))) == 4) &&
                    ((bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005)) + (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008)) +
                    (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006)) +
                    bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007)) == 5
                ) &&
                measured(tally(5,
                    once(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
                    0x000005))),
                    once(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
                    0x000008))),
                    once(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
                    0x000004))),
                    once(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
                    0x000006))),
                    once(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
                    0x000007))))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: Middle Ages", points = 5,
    description = "Locate six unique energy orbs scattered across Medieval Lebensbaum",
    id = 399819, badge = "465996", published = "19/02/2024 14:12:17", modified = "17/04/2024 14:53:08",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                once((((prev(bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA442F8) &
                    0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005))) +
                    (prev(bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004))) + prev(bit0((dword(0xA442F8) & 0x1FFFFFF) +
                    0x000004))) == 5) &&
                    ((bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007)) +
                    (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005)) + (bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004)) +
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004)) == 6
                ) &&
                measured(tally(6,
                    once(dword(0xA82E48) == 535 &&
                    bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004))),
                    once((dword(0xA82E48) == 1011 || dword(0xA82E48) == 828) &&
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006))),
                    once((dword(0xA82E48) == 1011 || dword(0xA82E48) == 828) &&
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008))),
                    once((dword(0xA82E48) == 1011 || dword(0xA82E48) == 828) &&
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007))),
                    once((dword(0xA82E48) == 1011 || dword(0xA82E48) == 828) &&
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005))),
                    once(dword(0xA82E48) == 142 &&
                    bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004))),
                    once((dword(0xA82E48) == 1011 || dword(0xA82E48) == 828) &&
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004))))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                once((((prev(bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA450C8) &
                    0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005))) +
                    (prev(bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004))) + prev(bit0((dword(0xA450C8) & 0x1FFFFFF) +
                    0x000004))) == 5) &&
                    ((bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007)) +
                    (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005)) + (bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004)) +
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004)) == 6
                ) &&
                measured(tally(6,
                    once(dword(0xA8A998) == 535 &&
                    bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004))),
                    once((dword(0xA8A998) == 1011 || dword(0xA8A998) == 828) &&
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006))),
                    once((dword(0xA8A998) == 1011 || dword(0xA8A998) == 828) &&
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008))),
                    once((dword(0xA8A998) == 1011 || dword(0xA8A998) == 828) &&
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007))),
                    once((dword(0xA8A998) == 1011 || dword(0xA8A998) == 828) &&
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005))),
                    once(dword(0xA8A998) == 142 &&
                    bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004))),
                    once((dword(0xA8A998) == 1011 || dword(0xA8A998) == 828) &&
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004))))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: The Late 20th Century", points = 5,
    description = "Locate five unique energy orbs scattered across Lebensbaum during the late 20th century",
    id = 399817, badge = "461687", published = "19/02/2024 14:12:16", modified = "17/04/2024 14:53:03",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless((dword(0xA82E48) != 1125 && dword(0xA82E48) != 797)) &&
                once((((prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA442F0) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F0) &
                    0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005))) == 4) &&
                    ((bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000007)) +
                    bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005)) == 5
                ) &&
                measured(tally(5,
                    once(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
                    0x000008))),
                    once(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
                    0x000006))),
                    once(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
                    0x000004))),
                    once(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
                    0x000007))),
                    once(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
                    0x000005))))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless((dword(0xA8A998) != 1125 && dword(0xA8A998) != 797)) &&
                once((((prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA450C0) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C0) &
                    0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005))) == 4) &&
                    ((bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000007)) +
                    bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005)) == 5
                ) &&
                measured(tally(5,
                    once(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
                    0x000008))),
                    once(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
                    0x000006))),
                    once(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
                    0x000004))),
                    once(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
                    0x000007))),
                    once(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
                    0x000005))))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: The Early 20th Century", points = 5,
    description = "Locate six unique energy orbs scattered across Lebensbaum during the early 20th century",
    id = 399818, badge = "461686", published = "19/02/2024 14:12:16", modified = "17/04/2024 14:53:04",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                once((((prev(bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA442F4) &
                    0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005))) +
                    prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004))) == 5) &&
                    ((bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007)) +
                    (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005)) + bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004)) == 6
                ) &&
                measured(tally(6,
                    once(dword(0xA82E48) == 1539 &&
                    bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004))),
                    once(dword(0xA82E48) == 569 &&
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006))),
                    once(dword(0xA82E48) == 569 &&
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008))),
                    once(dword(0xA82E48) == 569 &&
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007))),
                    once(dword(0xA82E48) == 569 &&
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005))),
                    once(dword(0xA82E48) == 569 &&
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004))))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                once((((prev(bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF)
                    + 0x000006))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008))) + (prev(bit0((dword(0xA450C4) &
                    0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005))) +
                    prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004))) == 5) &&
                    ((bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006)) +
                    (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007)) +
                    (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005)) + bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004)) == 6
                ) &&
                measured(tally(6,
                    once(dword(0xA8A998) == 1539 &&
                    bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004))),
                    once(dword(0xA8A998) == 569 &&
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006))),
                    once(dword(0xA8A998) == 569 &&
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008))),
                    once(dword(0xA8A998) == 569 &&
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007))),
                    once(dword(0xA8A998) == 569 &&
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005))),
                    once(dword(0xA8A998) == 569 &&
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004))))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Stockpiling Across Eras", points = 10, type="missable",
    description = "Accrue the largest arsenal of items within a single playthrough",
    id = 402404, badge = "468297", published = "25/02/2024 19:47:49", modified = "4/05/2024 11:40:47",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                once(((prev(bit0(0xA9F042)) + prev(bit0(0xA9F045)) + prev(bit0(0xA9F03B)) + prev(bit0(0xA9F03C)) +
                    prev(bit0(0xA9F047)) + prev(bit0(0xA9F035)) + prev(bit0(0xA9F041)) + prev(bit0(0xA9F034)) +
                    prev(bit0(0xA9F044)) + prev(bit0(0xA9F038)) + prev(bit0(0xA9F040)) + prev(bit0(0xA9F04B)) +
                    prev(bit0(0xA9F048)) + prev(bit0(0xA9F04D)) + prev(bit0(0xA9F050)) + prev(bit0(0xA9F03A)) +
                    prev(bit0(0xA9F04C)) + prev(bit0(0xA9F046)) + prev(bit0(0xA9F03E)) + prev(bit0(0xA9F04F)) +
                    prev(bit0(0xA9F04E)) + prev(bit0(0xA9F03F)) + prev(bit0(0xA9F036)) + prev(bit0(0xA9F03D)) +
                    prev(bit0(0xA9F04A)) + prev(bit0(0xA9F039)) + prev(bit0(0xA9F043)) + prev(bit0(0xA9F049))) > 15) &&
                    (prev(bit0(0xA9F042)) + prev(bit0(0xA9F045)) + prev(bit0(0xA9F03B)) + prev(bit0(0xA9F03C)) +
                    prev(bit0(0xA9F047)) + prev(bit0(0xA9F035)) + prev(bit0(0xA9F041)) + prev(bit0(0xA9F034)) +
                    prev(bit0(0xA9F044)) + prev(bit0(0xA9F038)) + prev(bit0(0xA9F040)) + prev(bit0(0xA9F04B)) +
                    prev(bit0(0xA9F048)) + prev(bit0(0xA9F04D)) + prev(bit0(0xA9F050)) + prev(bit0(0xA9F03A)) +
                    prev(bit0(0xA9F04C)) + prev(bit0(0xA9F046)) + prev(bit0(0xA9F03E)) + prev(bit0(0xA9F04F)) +
                    prev(bit0(0xA9F04E)) + prev(bit0(0xA9F03F)) + prev(bit0(0xA9F036)) + prev(bit0(0xA9F03D)) +
                    prev(bit0(0xA9F04A)) + prev(bit0(0xA9F039)) + prev(bit0(0xA9F043)) + prev(bit0(0xA9F049))) < 20 &&
                    (bit0(0xA9F042) + bit0(0xA9F045) + bit0(0xA9F03B) + bit0(0xA9F03C) + bit0(0xA9F047) + bit0(0xA9F035) +
                    bit0(0xA9F041) + bit0(0xA9F034) + bit0(0xA9F044) + bit0(0xA9F038) + bit0(0xA9F040) + bit0(0xA9F04B) +
                    bit0(0xA9F048) + bit0(0xA9F04D) + bit0(0xA9F050) + bit0(0xA9F03A) + bit0(0xA9F04C) + bit0(0xA9F046) +
                    bit0(0xA9F03E) + bit0(0xA9F04F) + bit0(0xA9F04E) + bit0(0xA9F03F) + bit0(0xA9F036) + bit0(0xA9F03D) +
                    bit0(0xA9F04A) + bit0(0xA9F039) + bit0(0xA9F043) + bit0(0xA9F049)) == 20
                ) &&
                measured((bit0(0xA9F042) + bit0(0xA9F045) + bit0(0xA9F03B) + bit0(0xA9F03C) + bit0(0xA9F047) +
                    bit0(0xA9F035) + bit0(0xA9F041) + bit0(0xA9F034) + bit0(0xA9F044) + bit0(0xA9F038) + bit0(0xA9F040) +
                    bit0(0xA9F04B) + bit0(0xA9F048) + bit0(0xA9F04D) + bit0(0xA9F050) + bit0(0xA9F03A) + bit0(0xA9F04C) +
                    bit0(0xA9F046) + bit0(0xA9F03E) + bit0(0xA9F04F) + bit0(0xA9F04E) + bit0(0xA9F03F) + bit0(0xA9F036) +
                    bit0(0xA9F03D) + bit0(0xA9F04A) + bit0(0xA9F039) + bit0(0xA9F043) + bit0(0xA9F049)) == 20
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                once(((prev(bit0(0xAA6B92)) + prev(bit0(0xAA6B95)) + prev(bit0(0xAA6B8B)) + prev(bit0(0xAA6B8C)) +
                    prev(bit0(0xAA6B97)) + prev(bit0(0xAA6B85)) + prev(bit0(0xAA6B91)) + prev(bit0(0xAA6B84)) +
                    prev(bit0(0xAA6B94)) + prev(bit0(0xAA6B88)) + prev(bit0(0xAA6B90)) + prev(bit0(0xAA6B9B)) +
                    prev(bit0(0xAA6B98)) + prev(bit0(0xAA6B9D)) + prev(bit0(0xAA6B9A)) + prev(bit0(0xAA6B8A)) +
                    prev(bit0(0xAA6B9C)) + prev(bit0(0xAA6B96)) + prev(bit0(0xAA6B8E)) + prev(bit0(0xAA6B9F)) +
                    prev(bit0(0xAA6B9E)) + prev(bit0(0xAA6B8F)) + prev(bit0(0xAA6B86)) + prev(bit0(0xAA6B8D)) +
                    prev(bit0(0xAA6BA0)) + prev(bit0(0xAA6B89)) + prev(bit0(0xAA6B93)) + prev(bit0(0xAA6B99))) > 15) &&
                    (prev(bit0(0xAA6B92)) + prev(bit0(0xAA6B95)) + prev(bit0(0xAA6B8B)) + prev(bit0(0xAA6B8C)) +
                    prev(bit0(0xAA6B97)) + prev(bit0(0xAA6B85)) + prev(bit0(0xAA6B91)) + prev(bit0(0xAA6B84)) +
                    prev(bit0(0xAA6B94)) + prev(bit0(0xAA6B88)) + prev(bit0(0xAA6B90)) + prev(bit0(0xAA6B9B)) +
                    prev(bit0(0xAA6B98)) + prev(bit0(0xAA6B9D)) + prev(bit0(0xAA6B9A)) + prev(bit0(0xAA6B8A)) +
                    prev(bit0(0xAA6B9C)) + prev(bit0(0xAA6B96)) + prev(bit0(0xAA6B8E)) + prev(bit0(0xAA6B9F)) +
                    prev(bit0(0xAA6B9E)) + prev(bit0(0xAA6B8F)) + prev(bit0(0xAA6B86)) + prev(bit0(0xAA6B8D)) +
                    prev(bit0(0xAA6BA0)) + prev(bit0(0xAA6B89)) + prev(bit0(0xAA6B93)) + prev(bit0(0xAA6B99))) < 20 &&
                    (bit0(0xAA6B92) + bit0(0xAA6B95) + bit0(0xAA6B8B) + bit0(0xAA6B8C) + bit0(0xAA6B97) + bit0(0xAA6B85) +
                    bit0(0xAA6B91) + bit0(0xAA6B84) + bit0(0xAA6B94) + bit0(0xAA6B88) + bit0(0xAA6B90) + bit0(0xAA6B9B) +
                    bit0(0xAA6B98) + bit0(0xAA6B9D) + bit0(0xAA6B9A) + bit0(0xAA6B8A) + bit0(0xAA6B9C) + bit0(0xAA6B96) +
                    bit0(0xAA6B8E) + bit0(0xAA6B9F) + bit0(0xAA6B9E) + bit0(0xAA6B8F) + bit0(0xAA6B86) + bit0(0xAA6B8D) +
                    bit0(0xAA6BA0) + bit0(0xAA6B89) + bit0(0xAA6B93) + bit0(0xAA6B99)) == 20
                ) &&
                measured((bit0(0xAA6B92) + bit0(0xAA6B95) + bit0(0xAA6B8B) + bit0(0xAA6B8C) + bit0(0xAA6B97) +
                    bit0(0xAA6B85) + bit0(0xAA6B91) + bit0(0xAA6B84) + bit0(0xAA6B94) + bit0(0xAA6B88) + bit0(0xAA6B90) +
                    bit0(0xAA6B9B) + bit0(0xAA6B98) + bit0(0xAA6B9D) + bit0(0xAA6B9A) + bit0(0xAA6B8A) + bit0(0xAA6B9C) +
                    bit0(0xAA6B96) + bit0(0xAA6B8E) + bit0(0xAA6B9F) + bit0(0xAA6B9E) + bit0(0xAA6B8F) + bit0(0xAA6B86) +
                    bit0(0xAA6B8D) + bit0(0xAA6BA0) + bit0(0xAA6B89) + bit0(0xAA6B93) + bit0(0xAA6B99)) == 20
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "An Alchemist, a Jewel and a Homunculus", points = 5, type="progression",
    description = "Complete Chapter 3",
    id = 306921, badge = "465997", published = "5/04/2023 22:23:24", modified = "23/04/2024 8:16:22",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 4) && unless(byte(0xA9F111) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 105856 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 850752 && prior(dword(0xA9ECBC)) == 105856 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 235136 && prior(dword(0xA9ECBC)) == 850752 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 4 && byte(0xB95704) == 5) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 4) && unless(byte(0xAA6C61) != 0) &&
                never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 105856 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 850752 && prior(dword(0xAA680C)) == 105856 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 235136 && prior(dword(0xAA680C)) == 850752 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 4 && byte(0xB9D284) == 5))
)

achievement(
    title = "Running Beyond the 90's... And 80's", points = 2, type="missable",
    description = "Encounter an athletic man from a bygone era, as well as his Present self during Chapter 3, 4 or 5",
    id = 405086, badge = "465998", published = "5/03/2024 14:02:24", modified = "23/04/2024 8:16:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never((byte(0xB95704) != 4 && byte(0xB95704) != 5 && byte(0xB95704) != 6)) &&
                measured(tally(2,
                    once((dword(0xA82E48) == 885 || dword(0xA82E48) == 3 || dword(0xA82E48) == 68) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 88 && prev(dword(0xA9EFF4)) != 88 && dword(0xA9EFF4) == 88),
                    once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 797 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 89 &&
                    prev(dword(0xA9EFF4)) != 89 && dword(0xA9EFF4) == 89))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never((byte(0xB9D284) != 4 && byte(0xB9D284) != 5 && byte(0xB9D284) != 6)) &&
                measured(tally(2,
                    once((dword(0xA8A998) == 885 || dword(0xA8A998) == 3 || dword(0xA8A998) == 68) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 88 && prev(dword(0xAA6B44)) != 88 && dword(0xAA6B44) == 88),
                    once(byte(0xAA6876) == 1 && dword(0xA8A998) == 797 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 89 &&
                    prev(dword(0xAA6B44)) != 89 && dword(0xAA6B44) == 89))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Strokes of Destiny", points = 1, type="missable",
    description = "Marvel at the beauty of each unique painting on display at the Brum Museum",
    id = 307499, badge = "465999", published = "9/04/2023 11:10:41", modified = "23/04/2024 8:16:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != prev(byte(0xB95704))) &&
                measured(tally(8,
                    once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297),
                    once((dword(0xA82E48) == 320 || dword(0xA82E48) == 205) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 361 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                    once((dword(0xA82E48) == 320 || dword(0xA82E48) == 205) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 359 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                measured(tally(8,
                    once((dword(0xA8A998) == 50 || dword(0xA8A998) == 749) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 292),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 356 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 293),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 357 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 294),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 362 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 295),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 358 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 296),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 360 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 297),
                    once((dword(0xA8A998) == 320 || dword(0xA8A998) == 205) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 361 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295),
                    once((dword(0xA8A998) == 320 || dword(0xA8A998) == 205) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 359 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "That's Nice!", points = 2, type="missable",
    description = "Pique someone's interest with an oval shape of your own in the 1980's",
    id = 407681, badge = "466001", published = "13/03/2024 14:05:48", modified = "5/04/2024 18:13:36",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once((byte(0xA9F111) == 16 || byte(0xA9F111) == 2) && byte(0xA9ED26) == 1 && dword(0xA82E48) == 15 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 12 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 749 &&
                    byte(0xA9EE49) == 1
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once((byte(0xAA6C61) == 16 || byte(0xAA6C61) == 2) && byte(0xAA6876) == 1 && dword(0xA8A998) == 15 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 12 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 749 &&
                    byte(0xAA6999) == 1
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Timeless Antiques", points = 2, type="missable",
    description = "Spare a moment to glance at the timeless relics within the esteemed Antique Shop Eule",
    id = 310132, badge = "466002", published = "19/04/2023 12:50:26", modified = "5/04/2024 18:13:36",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless((dword(0xA82E48) != 122 && dword(0xA82E48) != 111)) &&
                never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
                measured(tally(4,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 142 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 152 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 121 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 198 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless((dword(0xA8A998) != 122 && dword(0xA8A998) != 111)) &&
                never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                measured(tally(4,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 142 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 152 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 121 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 198 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 4294967295))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "My My, So Eager to Die", points = 1, type="missable",
    description = "Firmly excuse yourself from the apparition's company in Chapter 3",
    id = 306919, badge = "466003", published = "5/04/2023 22:23:23", modified = "23/04/2024 8:16:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 4) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 45376 && prior(dword(0xA9ECBC)) == 371328 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 107584 && prior(dword(0xA9ECBC)) == 45376 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 4) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 45376 && prior(dword(0xAA680C)) == 371328 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 107584 && prior(dword(0xAA680C)) == 45376 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Time-Spun Sweets", points = 3, type="missable",
    description = "Gift a delectable sweet to a cherished individual in your life",
    id = 402296, badge = "466004", published = "25/02/2024 12:43:23", modified = "17/04/2024 14:52:34",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 19 && dword(0xA9ECBC) == 1093632 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 19 && dword(0xAA680C) == 1093632 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Legacy of Sweetness", points = 3, type="missable",
    description = "Establish a new line of pastries",
    id = 402297, badge = "466005", published = "25/02/2024 12:43:23", modified = "23/04/2024 8:16:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 19 && dword(0xA9ECBC) == 130432 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 19 && dword(0xAA680C) == 130432 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Pan-tastic Resilience", points = 3, type="progression",
    description = "Complete Chapter 4 using a frying pan",
    id = 308964, badge = "461657", published = "16/04/2023 17:01:09", modified = "17/04/2024 14:52:48",
    trigger = always_true() &&
              ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && byte(0xB95704) == 5 && byte(0xA9F111) == 4 &&
                dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
                prev(dword(0x1FFF5F4)) != 33 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                byte(0xA9F111) == 4 && prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && byte(0xB9D284) == 5 && byte(0xAA6C61) == 4 &&
                dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
                prev(dword(0x1FFF5F4)) != 33 && bit0(0xA8A97C) > prior(bit0(0xA8A97C))) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                byte(0xAA6C61) == 4 && prev(byte(0xB9D284)) == 5 && byte(0xB9D284) == 6))
)

achievement(
    title = "Through the Lens of Survival", points = 3, type="progression",
    description = "Complete Chapter 4 using a sign",
    id = 310149, badge = "461658", published = "19/04/2023 16:09:53", modified = "23/04/2024 8:16:23",
    trigger = always_true() &&
              ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && byte(0xB95704) == 5 && byte(0xA9F111) == 5 &&
                dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
                prev(dword(0x1FFF5F4)) != 33 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                byte(0xA9F111) == 5 && prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && byte(0xB9D284) == 5 && byte(0xAA6C61) == 5 &&
                dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
                prev(dword(0x1FFF5F4)) != 33 && bit0(0xA8A97C) > prior(bit0(0xA8A97C))) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                byte(0xAA6C61) == 5 && prev(byte(0xB9D284)) == 5 && byte(0xB9D284) == 6))
)

achievement(
    title = "Nine Lives Across Generations", points = 4, type="missable",
    description = "Offer a charming kitty to a lonely girl either during or after Chapter 4",
    id = 310426, badge = "466048", published = "20/04/2023 18:06:14", modified = "17/04/2024 14:52:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1539 && bit0(0xA9F04B) == 1 &&
                    dword(0xA9ECBC) == 152064 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(bit6(0xA9EDCB) == 1) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1539 && bit0(0xAA6B9B) == 1 &&
                    dword(0xAA680C) == 152064 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(bit6(0xAA691B) == 1) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Even I Can Do That", points = 3, type="missable",
    description = "Step into the shoes of a performer and clandestinely transmit a message to yourself during Chapter 4",
    id = 402284, badge = "466006", published = "25/02/2024 11:33:55", modified = "17/04/2024 14:53:03",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && byte(0xA9F111) == 12 && dword(0xA9ECBC) == 107264 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(prev(dword(0xAA680C)) != dword(0xAA680C)) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 5 && byte(0xAA6C61) == 12 && dword(0xAA680C) == 107264 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Performance Gone the Extra Mile", points = 3, type="missable",
    description = "Highlight the significance of going above and beyond, especially for those, including yourself, who would truly value the performer's effort",
    id = 403575, badge = "466007", published = "29/02/2024 15:31:22", modified = "4/05/2024 12:40:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
                never(repeated(150, bit2(0xA9EDA5) == 0 && never(bit2(0xA9EDA5) == 1))) &&
                measured(tally(7,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 391 && dword(0xA82E48) == 885 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 924),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 70 && dword(0xA82E48) == 885 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 822),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 66 && dword(0xA82E48) == 885 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 803),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 68 && dword(0xA82E48) == 885 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 812),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 405 && dword(0xA82E48) == 22 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 41 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 966),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 387 && dword(0xA82E48) == 22 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 41 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 972),
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 12 && dword(0xA9ECBC) == 107264 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54336 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14848))
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 5) &&
                never(repeated(150, bit2(0xAA68F5) == 0 && never(bit2(0xAA68F5) == 1))) &&
                measured(tally(7,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 391 && dword(0xA8A998) == 885 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 68 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 924),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 70 && dword(0xA8A998) == 885 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 68 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 822),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 66 && dword(0xA8A998) == 885 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 68 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 803),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 68 && dword(0xA8A998) == 885 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 68 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 812),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 405 && dword(0xA8A998) == 22 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 41 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 966),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 387 && dword(0xA8A998) == 22 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 41 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 972),
                    once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 12 && dword(0xAA680C) == 107264 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 54336 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 14848))
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Complexities of the Fourth Dimension", points = 3, type="missable",
    description = "Receive a lecture on time-travel physics within Chapter 4",
    id = 310163, badge = "464226", published = "19/04/2023 19:40:38", modified = "23/04/2024 8:16:27",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 5) &&
                once((byte(0xA9F111) == 4 || byte(0xA9F111) == 5) && byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 721152 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 5) &&
                once((byte(0xAA6C61) == 4 || byte(0xAA6C61) == 5) && byte(0xAA6876) == 5 && dword(0xAA680C) == 721152 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Horologic Heritage", points = 2, type="missable",
    description = "Kindle the joy of watchmaking to an ancestor of the Franssen's",
    id = 405460, badge = "466008", published = "6/03/2024 15:30:06", modified = "5/04/2024 18:13:40",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never((byte(0xB95704) != 7 && byte(0xB95704) != 8 && byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 16 && dword(0xA9ECBC) == 70848 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 70816 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 70816 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 44368 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 70816
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never((byte(0xB9D284) != 7 && byte(0xB9D284) != 8 && byte(0xB9D284) != 9 && byte(0xB9D284) != 11)) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 16 && dword(0xAA680C) == 70848 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 70816 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 70816 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 44368 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 70816
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Pan in Advance", points = 3, type="missable",
    description = "Secure an iron plate prior to Chapter 4, deploying it judiciously when its utility becomes necessary",
    id = 403823, badge = "466009", published = "2/03/2024 0:38:26", modified = "23/04/2024 8:16:27",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 5) && never(bit0(0xA9F03B) == 1) && never(bit0(0xA9F03C) == 1) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 4 && dword(0xA9ECBC) == 324096 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 5) && never(bit0(0xAA6B8B) == 1) && never(bit0(0xAA6B8C) == 1) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 4 && dword(0xAA680C) == 324096 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Ancient Elixir", points = 5, type="progression",
    description = "Complete Chapter 5",
    id = 311616, badge = "470257", published = "25/04/2023 18:57:11", modified = "17/04/2024 14:53:12",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 6 && byte(0xA9F111) == 17 && dword(0xA9ECBC) == 260480 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 260480
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 6 && byte(0xB95704) == 7) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 6 && byte(0xAA6C61) == 17 && dword(0xAA680C) == 260480 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 260480
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 6 && byte(0xB9D284) == 7))
)

achievement(
    title = "A Complimentary Dinner", points = 3, type="missable",
    description = "Enjoy a free dinner  at Bar Zum Ei during Chapter 5",
    id = 405461, badge = "466011", published = "6/03/2024 15:30:07", modified = "17/04/2024 14:53:16",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 6) && never((bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0)) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 403520 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1023168 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 6) && never((bit5(0xAA68ED) == 1 && bit7(0xAA68ED) == 0)) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 403520 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1023168 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Mother's Child", points = 2, type="missable",
    description = "Chance upon Hugo in the vicinity of his home during the events of Chapter 5",
    id = 311466, badge = "466012", published = "24/04/2023 18:48:54", modified = "17/04/2024 14:53:15",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1011 && byte(0xB95704) == 6 &&
                    dword(0xA9ECBC) == 257280 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1011 && byte(0xB9D284) == 6 &&
                    dword(0xAA680C) == 257280 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Barman's Mystery Child", points = 3, type="missable",
    description = "Uncover the truth about the barman's grandchildren in Chapter 5",
    id = 315567, badge = "466013", published = "7/05/2023 18:08:33", modified = "17/04/2024 14:52:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 6) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 852480 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 6) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 852480 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Art Muse", points = 3, type="missable",
    description = "Inspire a renowned artist and appraise his work",
    id = 403824, badge = "470255", published = "2/03/2024 0:38:26", modified = "5/04/2024 18:13:43",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != prev(byte(0xB95704))) && never(bit5(0xA9EDAA) == 1) &&
                tally(1,
                    once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 && bit4(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit5(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit6(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit7(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit0(0xA9EDB1) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit1(0xA9EDB1) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != prev(byte(0xB9D284))) && never(bit5(0xAA68FA) == 1) &&
                tally(1,
                    once((dword(0xA8A998) == 50 || dword(0xA8A998) == 749) && byte(0xAA6876) == 1 && bit4(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 292),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 && bit5(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 356 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 293),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 && bit6(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 357 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 294),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit7(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 362 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 295),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit0(0xAA6901) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 358 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 296),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit1(0xAA6901) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 360 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 297)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Eike Franssen", points = 5, type="missable",
    description = "Become a beacon of inspiration for a prominent artist and assess all his works",
    id = 403825, badge = "466015", published = "2/03/2024 0:38:26", modified = "5/04/2024 18:13:43",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != prev(byte(0xB95704))) &&
                measured(tally(6,
                    once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 && bit4(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit5(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                    once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit6(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit7(0xA9EDB0) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit0(0xA9EDB1) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                    once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit1(0xA9EDB1) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                measured(tally(6,
                    once((dword(0xA8A998) == 50 || dword(0xA8A998) == 749) && byte(0xAA6876) == 1 && bit4(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 292),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 && bit5(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 356 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 293),
                    once((dword(0xA8A998) == 345 || dword(0xA8A998) == 56) && byte(0xAA6876) == 1 && bit6(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 357 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 294),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit7(0xAA6900) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 362 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 295),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit0(0xAA6901) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 358 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 296),
                    once((dword(0xA8A998) == 548 || dword(0xA8A998) == 445) && byte(0xAA6876) == 1 && bit1(0xAA6901) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 360 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 297))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Director's Cut: Trip for Two", points = 3, type="progression",
    description = "Complete Chapter 6 by co-directing a love picture",
    id = 313210, badge = "466017", published = "1/05/2023 15:18:03", modified = "23/04/2024 8:16:27",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 7 && dword(0xA9ECBC) == 645952 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
                prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit2(0xAA6908) == 1 && bit1(0xAA6908) == 0 &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 7 && dword(0xAA680C) == 645952 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit2(0xAA6908) == 1 && bit1(0xAA6908) == 0 &&
                prev(byte(0xB9D284)) == 7 && byte(0xB9D284) == 8))
)

achievement(
    title = "Director's Cut: The Time of Reckoning", points = 3, type="progression",
    description = "Complete Chapter 6 by co-directing a thriller picture",
    id = 313211, badge = "466016", published = "1/05/2023 15:18:03", modified = "23/04/2024 8:16:27",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 7 && dword(0xA9ECBC) == 645952 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
                prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit1(0xAA6908) == 1 && bit2(0xAA6908) == 0 &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 7 && dword(0xAA680C) == 645952 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit1(0xAA6908) == 1 && bit2(0xAA6908) == 0 &&
                prev(byte(0xB9D284)) == 7 && byte(0xB9D284) == 8))
)

achievement(
    title = "Time Ego Flop", points = 1, type="missable",
    description = "Weave the fabric of time and space as co-directors in the creation of 'Time Ego Trip World Conquest' during the narrative of Chapter 6",
    id = 313212, badge = "470254", published = "1/05/2023 15:18:03", modified = "17/04/2024 14:52:35",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit7(0xA9EDB7) == 1 &&
                    bit0(0xA9EDB8) == 0 && byte(0xB95704) == 7 && dword(0xA9ECBC) == 489856 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit7(0xAA6907) == 1 &&
                    bit0(0xAA6908) == 0 && byte(0xB9D284) == 7 && dword(0xAA680C) == 489856 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Cracking Open the Past: The Old Century", points = 3, type="missable",
    description = "Pay for some coffee with an oval shaped object from Chapter 6 onward",
    id = 313213, badge = "466019", published = "1/05/2023 15:18:04", modified = "23/04/2024 8:16:27",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(bit0(0xA9F044) == 0) &&
                never((byte(0xB95704) != 7 && byte(0xB95704) != 8 && byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 570432 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 705728 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(bit0(0xAA6B94) == 0) &&
                never((byte(0xB9D284) != 7 && byte(0xB9D284) != 8 && byte(0xB9D284) != 9 && byte(0xB9D284) != 11)) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 569 && dword(0xAA680C) == 570432 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 569 && dword(0xAA680C) == 705728 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Illusive Guardian of the Brums", points = 3, type="missable",
    description = "Navigate the labyrinths of fate to shield a member of the Brum family from their destined demise during the events of Chapter 6",
    id = 315569, badge = "466020", published = "7/05/2023 18:08:33", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && byte(0xB95704) == 7 &&
                    dword(0xA9ECBC) == 965312 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1125 && byte(0xB9D284) == 7 &&
                    dword(0xAA680C) == 965312 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Meditating Man", points = 2, type="missable",
    description = "Find someone who shares a similar experience of meeting the meditating man in Chapter 6",
    id = 405098, badge = "466021", published = "5/03/2024 14:02:39", modified = "5/04/2024 18:13:46",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 7) &&
                once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 21 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 397 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 999 &&
                    prior(byte(0xA9EF43)) < 1 && byte(0xA9EF43) == 1
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 7) &&
                once(byte(0xAA6876) == 1 && dword(0xA8A998) == 21 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 397 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 999 &&
                    prior(byte(0xAA6A93)) < 1 && byte(0xAA6A93) == 1
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Picked Up a Baby the Other Day", points = 2, type="missable",
    description = "Witness a chilling crime scene revealed amidst the snowy terrain during Chapter 6",
    id = 313209, badge = "466022", published = "1/05/2023 15:18:03", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && byte(0xB95704) == 7 &&
                    dword(0xA9ECBC) == 480960 && prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1125 && byte(0xB9D284) == 7 &&
                    dword(0xAA680C) == 480960 && prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Friend's Repentance", points = 5, type="progression",
    description = "Complete Chapter 7",
    id = 315565, badge = "466023", published = "7/05/2023 18:08:33", modified = "17/04/2024 14:53:16",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 8) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 274496 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && dword(0xA9ECBC) == 813056 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && dword(0xA9ECBC) == 859072 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0)
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 73792 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 8 && byte(0xB95704) == 11) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 8 && byte(0xB95704) == 9) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 8) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 274496 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && dword(0xAA680C) == 813056 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1 && dword(0xAA680C) == 859072 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0)
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 73792 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 8 && byte(0xB9D284) == 11) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 8 && byte(0xB9D284) == 9))
)

achievement(
    title = "Fated to Plunge", points = 1, type="missable",
    description = "Employ a worn-out cable to save yourself during Chapter 7",
    id = 315563, badge = "466024", published = "7/05/2023 18:08:32", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 87616 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 87616 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 87616 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 145344 && prior(dword(0xAA680C)) == 87616 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Next Big Thing", points = 3, type="missable",
    description = "Inspire the movie director for a second time during Chapter 7",
    id = 404045, badge = "468295", published = "2/03/2024 21:18:07", modified = "17/04/2024 14:52:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && bit3(0xA9EDCC) == 1 && dword(0xA9ECBC) == 659264 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && bit3(0xAA691C) == 1 && dword(0xAA680C) == 659264 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Pair of Delinquents", points = 2, type="missable",
    description = "Encounter some mischievous rascals in Chapter 7",
    id = 404048, badge = "466031", published = "2/03/2024 22:13:05", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 19 && prev(byte(0xA9EE51)) == 0 &&
                    byte(0xA9EE51) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 757),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 16 && prev(byte(0xA9EE4C)) == 0 &&
                    byte(0xA9EE4C) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 752)), when=dword(0xA82E48) == 68
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 19 && byte(0xA9EE51) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 757),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 16 && byte(0xA9EE4C) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 752)),
                    when=dword(0xA82E48) == 68
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 19 && prev(byte(0xAA69A1)) == 0 &&
                    byte(0xAA69A1) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 757),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 16 && prev(byte(0xAA699C)) == 0 &&
                    byte(0xAA699C) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 752)), when=dword(0xA8A998) == 68
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 19 && byte(0xAA69A1) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 757),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 16 && byte(0xAA699C) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 752)),
                    when=dword(0xA8A998) == 68
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Bump... Erased", points = 1, type="missable",
    description = "Stumble upon yourself in Chapter 7",
    id = 314763, badge = "466026", published = "5/05/2023 8:58:07", modified = "5/04/2024 18:13:49",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once((dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 147168) &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 227296 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 147120
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once((dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 147168) &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 227296 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x00002C) == 147120
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Hatchless Replica", points = 3, type="missable",
    description = "Share your egg collection with a younger barman during Chapter 7",
    id = 315561, badge = "466027", published = "7/05/2023 18:08:31", modified = "17/04/2024 14:53:15",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 577152 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B94) == 1 && dword(0xAA680C) == 577152 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Brums Happily Ever After", points = 3, type="missable",
    description = "Meet Eckart's wife in Chapter 7, after your valiant act",
    id = 315570, badge = "466028", published = "7/05/2023 18:08:34", modified = "17/04/2024 14:52:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 274496 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && dword(0xA9ECBC) == 817472 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0),
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && dword(0xA9ECBC) == 730432 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 274496 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && dword(0xAA680C) == 817472 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0),
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1 && dword(0xAA680C) == 730432 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Whole Picture... Or is it?", points = 5, type="progression",
    description = "Complete Chapter 8",
    id = 315571, badge = "466049", published = "7/05/2023 18:08:34", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 570944 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1109760 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 935936 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 873536 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 464576 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 998528 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1031424 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 806464 && prior(dword(0xA9ECBC)) == 1031424 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 117696 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 11) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 490048 && prior(dword(0xA9ECBC)) == 169728 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 307520 && prior(dword(0xA9ECBC)) == 490048 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 824384 && prior(dword(0xA9ECBC)) == 655552 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 11) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1055680 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1275136 && prior(dword(0xA9ECBC)) == 1055680 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 9 && byte(0xB95704) == 10) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                repeated(500, low4(0xA9EDDC) != 0 && never(low4(0xA9EDDC) == 0)) && dword(0xAC49F4) == 0 &&
                prev(byte(0xB95704)) == 11 && byte(0xB95704) == 12) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 570944 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1109760 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 935936 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 873536 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 464576 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 998528 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1031424 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 806464 && prior(dword(0xAA680C)) == 1031424 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 9 && dword(0xAA680C) == 117696 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 11) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 490048 && prior(dword(0xAA680C)) == 169728 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 307520 && prior(dword(0xAA680C)) == 490048 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 824384 && prior(dword(0xAA680C)) == 655552 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit1(0xAA6914) == 0 && bit3(0xAA6914) == 0 && bit4(0xAA6914) == 0 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 11) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1055680 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1275136 && prior(dword(0xAA680C)) == 1055680 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit1(0xAA6914) == 1 && bit3(0xAA6914) == 1 && bit4(0xAA6914) == 1 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 9 && byte(0xB9D284) == 10) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                repeated(500, low4(0xAA692C) != 0 && never(low4(0xAA692C) == 0)) && dword(0xACC534) == 0 &&
                prev(byte(0xB9D284)) == 11 && byte(0xB9D284) == 12))
)

achievement(
    title = "The Eggcellent Director's Tale", points = 3, type="missable",
    description = "Share stories about your newly acquired pocket watch with Eckart in Chapter 8",
    id = 315562, badge = "466029", published = "7/05/2023 18:08:32", modified = "17/04/2024 14:52:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never((byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 580800 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never((byte(0xB9D284) != 9 && byte(0xB9D284) != 11)) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B94) == 1 && dword(0xAA680C) == 580800 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "An End to a Strange Experience", points = 5, type="win_condition",
    description = "Achieve ending A",
    id = 315566, badge = "466030", published = "7/05/2023 18:08:33", modified = "23/04/2024 8:16:32",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 898944 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 491392 && prior(dword(0xA9ECBC)) == 898944 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1154) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 10) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 898944 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 491392 && prior(dword(0xAA680C)) == 898944 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA4) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "No Sense of Finality I", points = 5, type="win_condition",
    description = "Achieve ending B1",
    id = 315573, badge = "466033", published = "7/05/2023 18:08:34", modified = "23/04/2024 8:16:35",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 398272 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 352832 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1155) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 10) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 398272 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 352832 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA5) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "No Sense of Finality II", points = 5, type="win_condition",
    description = "Achieve ending B2",
    id = 315572, badge = "466032", published = "7/05/2023 18:08:34", modified = "23/04/2024 8:16:35",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 594496 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 381632 && prior(dword(0xA9ECBC)) == 594496 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 352832 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1155) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 10) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 594496 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 381632 && prior(dword(0xAA680C)) == 594496 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 352832 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA5) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "If Only... I Had One More Attempt", points = 5, type="win_condition",
    description = "Achieve ending C",
    id = 317118, badge = "461671", published = "14/05/2023 10:33:35", modified = "17/04/2024 14:52:57",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 577280 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 504128 && prior(dword(0xA9ECBC)) == 577280 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 833280 && prior(dword(0xA9ECBC)) == 504128 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1156) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 10) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 577280 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 504128 && prior(dword(0xAA680C)) == 577280 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 833280 && prior(dword(0xAA680C)) == 504128 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA6) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Eike's Origins", points = 5, type="win_condition",
    description = "Achieve ending D",
    id = 322230, badge = "466034", published = "28/05/2023 11:34:23", modified = "17/04/2024 14:53:08",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 12) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 461248 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 809792 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1157) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 12) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 461248 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 809792 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit1(0xAA6914) == 0 && bit3(0xAA6914) == 0 && bit4(0xAA6914) == 0 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA7) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Future Is What We Make It", points = 5, type="win_condition",
    description = "Achieve ending E",
    id = 322231, badge = "461673", published = "28/05/2023 11:34:26", modified = "17/04/2024 14:52:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 12) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 560576 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 782208 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 842944 && prior(dword(0xA9ECBC)) == 782208 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1158) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 12) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 560576 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 782208 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 842944 && prior(dword(0xAA680C)) == 782208 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit1(0xAA6914) == 1 && bit3(0xAA6914) == 1 && bit4(0xAA6914) == 1 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA8) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Philosopher's Wisdom", points = 1, type="missable",
    description = "Obtain one final message during the EX Chapter",
    id = 405112, badge = "466035", published = "5/03/2024 21:15:30", modified = "17/04/2024 14:52:41",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 &&
                    bit0(0xAA1156) == 1 && bit0(0xAA1155) == 1 && bit0(0xAA1154) == 1 && dword(0xA9ECBC) == 198528 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && trigger_when(bit0(0xA9F036) == 1) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 &&
                    bit0(0xAA8CA6) == 1 && bit0(0xAA8CA5) == 1 && bit0(0xAA8CA4) == 1 && dword(0xAA680C) == 198528 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && trigger_when(bit0(0xAA6B86) == 1) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Philosopher's Destiny", points = 4, type="win_condition",
    description = "Achieve ending EX, by destroying the jewel",
    id = 405113, badge = "461652", published = "5/03/2024 21:15:30", modified = "17/04/2024 14:52:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && dword(0xA9ECBC) == 686720 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 424256 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1156) == 1 &&
                bit0(0xAA1155) == 1 && bit0(0xAA1154) == 1 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1159) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B8D) == 1 && dword(0xAA680C) == 686720 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 424256 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 && bit0(0xAA8CA6) == 1 &&
                bit0(0xAA8CA5) == 1 && bit0(0xAA8CA4) == 1 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA9) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Philosopher's Legacy", points = 4, type="win_condition",
    description = "Achieve ending EX, by creating a miracle cure",
    id = 405114, badge = "466036", published = "5/03/2024 21:15:30", modified = "17/04/2024 14:52:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && dword(0xA9ECBC) == 363520 &&
                    prev(word(0xA9ECC0)) != 1 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 424256 && prev(word(0xA9ECC0)) != 1 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0
                ) && bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1156) == 1 &&
                bit0(0xAA1155) == 1 && bit0(0xAA1154) == 1 &&
                once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA1159) == 1) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B8D) == 1 && dword(0xAA680C) == 363520 &&
                    prev(word(0xAA6810)) != 1 && word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 424256 && prev(word(0xAA6810)) != 1 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0
                ) && bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 && bit0(0xAA8CA6) == 1 &&
                bit0(0xAA8CA5) == 1 && bit0(0xAA8CA4) == 1 &&
                once((dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                    dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65
                ) && trigger_when(bit0(0xAA8CA9) == 1) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) == 257) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) != 257) &&
                trigger_when(prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) == 65) &&
                trigger_when(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Homing Instinct", points = 10,
    description = "Reach 100% achievement rate for the Prologue, including the EX Chapter",
    id = 405087, badge = "466037", published = "5/03/2024 14:02:24", modified = "4/05/2024 22:10:11",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 1) &&
                (3 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) +
                prev(bitcount(0xA9ED42)) - prev(bit0(0xA9ED3C)) - prev(bit6(0xA9ED42)) - prev(bit7(0xA9ED42))) > 42 &&
                (3 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) + 3 +
                prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) +
                prev(bitcount(0xA9ED42)) - prev(bit0(0xA9ED3C)) - prev(bit6(0xA9ED42)) - prev(bit7(0xA9ED42))) < 56 &&
                measured((3 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                    prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) + 3 +
                    prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                    prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) + bitcount(0xA9ED3C) +
                    bitcount(0xA9ED3D) + bitcount(0xA9ED3E) + bitcount(0xA9ED3F) + bitcount(0xA9ED40) + bitcount(0xA9ED41) +
                    bitcount(0xA9ED42) - bit0(0xA9ED3C) - bit6(0xA9ED42) - bit7(0xA9ED42)) == 53, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 1) &&
                (3 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) +
                prev(bitcount(0xAA6892)) - prev(bit0(0xAA688C)) - prev(bit6(0xAA6892)) - prev(bit7(0xAA6892))) > 42 &&
                (3 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) + 3 +
                prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) +
                prev(bitcount(0xAA6892)) - prev(bit0(0xAA688C)) - prev(bit6(0xAA6892)) - prev(bit7(0xAA6892))) < 56 &&
                measured((3 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                    prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) + 3 +
                    prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                    prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) + bitcount(0xAA688C) +
                    bitcount(0xAA688D) + bitcount(0xAA688E) + bitcount(0xAA688F) + bitcount(0xAA6890) + bitcount(0xAA6891) +
                    bitcount(0xAA6892) - bit0(0xAA688C) - bit6(0xAA6892) - bit7(0xAA6892)) == 53, format="percent"
                )))
)

achievement(
    title = "In the Heat of Time", points = 10,
    description = "Reach 100% achievement rate for Chapter 1",
    id = 405088, badge = "466038", published = "5/03/2024 14:02:24", modified = "4/05/2024 22:10:11",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 2) &&
                (2 + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) +
                prev(bitcount(0xA9ED46)) - prev(bit6(0xA9ED46)) - prev(bit7(0xA9ED46))) > 20 &&
                (2 + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) +
                2 + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) +
                prev(bitcount(0xA9ED46)) - prev(bit6(0xA9ED46)) - prev(bit7(0xA9ED46))) < 26 &&
                measured((2 + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) +
                    prev(bitcount(0xA9ED45)) + 2 + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) +
                    prev(bitcount(0xA9ED45)) + bit6(0xA9ED43) + bit7(0xA9ED43) + bitcount(0xA9ED44) + bitcount(0xA9ED45) +
                    bitcount(0xA9ED46) - bit6(0xA9ED46) - bit7(0xA9ED46)) == 24, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 2) &&
                (2 + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) +
                prev(bitcount(0xAA6896)) - prev(bit6(0xAA6896)) - prev(bit7(0xAA6896))) > 20 &&
                (2 + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) +
                2 + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) +
                prev(bitcount(0xAA6896)) - prev(bit6(0xAA6896)) - prev(bit7(0xAA6896))) < 26 &&
                measured((2 + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) +
                    prev(bitcount(0xAA6895)) + 2 + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) +
                    prev(bitcount(0xAA6895)) + bit6(0xAA6893) + bit7(0xAA6893) + bitcount(0xAA6894) + bitcount(0xAA6895) +
                    bitcount(0xAA6896) - bit6(0xAA6896) - bit7(0xAA6896)) == 24, format="percent"
                )))
)

achievement(
    title = "Dana Kusch", points = 10,
    description = "Reach 100% achievement rate for Chapter 2",
    id = 405089, badge = "466039", published = "5/03/2024 14:02:24", modified = "4/05/2024 22:10:10",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 3) &&
                (4 + prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                prev(bitcount(0xA9ED4A)) + prev(bitcount(0xA9ED4B)) - prev(bit0(0xA9ED47)) - prev(bit1(0xA9ED47)) -
                prev(bit2(0xA9ED47)) - prev(bit7(0xA9ED4B))) > 31 &&
                (4 + prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                prev(bitcount(0xA9ED4A)) + 4 + prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) +
                prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) + prev(bitcount(0xA9ED4B)) - prev(bit0(0xA9ED47)) -
                prev(bit1(0xA9ED47)) - prev(bit2(0xA9ED47)) - prev(bit7(0xA9ED4B))) < 40 &&
                measured((4 + prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                    prev(bitcount(0xA9ED4A)) + 4 + prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) +
                    prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) + bitcount(0xA9ED47) + bitcount(0xA9ED48) +
                    bitcount(0xA9ED49) + bitcount(0xA9ED4A) + bitcount(0xA9ED4B) - bit0(0xA9ED47) - bit1(0xA9ED47) -
                    bit2(0xA9ED47) - bit7(0xA9ED4B)) == 36, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 3) &&
                (4 + prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                prev(bitcount(0xAA689A)) + prev(bitcount(0xAA689B)) - prev(bit0(0xAA6897)) - prev(bit1(0xAA6897)) -
                prev(bit2(0xAA6897)) - prev(bit7(0xAA689B))) > 31 &&
                (4 + prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                prev(bitcount(0xAA689A)) + 4 + prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) +
                prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) + prev(bitcount(0xAA689B)) - prev(bit0(0xAA6897)) -
                prev(bit1(0xAA6897)) - prev(bit2(0xAA6897)) - prev(bit7(0xAA689B))) < 40 &&
                measured((4 + prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                    prev(bitcount(0xAA689A)) + 4 + prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) +
                    prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) + bitcount(0xAA6897) + bitcount(0xAA6898) +
                    bitcount(0xAA6899) + bitcount(0xAA689A) + bitcount(0xAA689B) - bit0(0xAA6897) - bit1(0xAA6897) -
                    bit2(0xAA6897) - bit7(0xAA689B)) == 36, format="percent"
                )))
)

achievement(
    title = "The Root of the Problem", points = 10,
    description = "Reach 100% achievement rate for Chapter 3",
    id = 405090, badge = "466040", published = "5/03/2024 14:02:25", modified = "4/05/2024 22:10:10",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 4) &&
                (2 + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A)) -
                prev(bit0(0xA9ED58)) - prev(bit1(0xA9ED58))) > 17 &&
                (2 + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) + 2 + prev(bitcount(0xA9ED58)) +
                prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A)) - prev(bit0(0xA9ED58)) - prev(bit1(0xA9ED58))) < 24 &&
                measured((2 + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) + 2 + prev(bitcount(0xA9ED58)) +
                    prev(bitcount(0xA9ED59)) + bitcount(0xA9ED58) + bitcount(0xA9ED59) + bitcount(0xA9ED5A) - bit0(0xA9ED58)
                    - bit1(0xA9ED58)) == 22, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 4) &&
                (2 + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA)) -
                prev(bit0(0xAA68A8)) - prev(bit1(0xAA68A8))) > 17 &&
                (2 + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) + 2 + prev(bitcount(0xAA68A8)) +
                prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA)) - prev(bit0(0xAA68A8)) - prev(bit1(0xAA68A8))) < 24 &&
                measured((2 + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) + 2 + prev(bitcount(0xAA68A8)) +
                    prev(bitcount(0xAA68A9)) + bitcount(0xAA68A8) + bitcount(0xAA68A9) + bitcount(0xAA68AA) - bit0(0xAA68A8)
                    - bit1(0xAA68A8)) == 22, format="percent"
                )))
)

achievement(
    title = "The Monochrome Era", points = 10,
    description = "Reach 100% achievement rate for Chapter 4",
    id = 405091, badge = "466041", published = "5/03/2024 14:02:25", modified = "4/05/2024 22:10:10",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 5) &&
                (4 + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) + prev(bitcount(0xA9ED4F)) +
                prev(bitcount(0xA9ED50)) + prev(bitcount(0xA9ED51)) - prev(bit0(0xA9ED4D)) - prev(bit5(0xA9ED51)) -
                prev(bit6(0xA9ED51)) - prev(bit7(0xA9ED51))) > 31 &&
                (4 + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) + prev(bitcount(0xA9ED4F)) +
                prev(bitcount(0xA9ED50)) + 4 + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bitcount(0xA9ED51)) - prev(bit0(0xA9ED4D)) -
                prev(bit5(0xA9ED51)) - prev(bit6(0xA9ED51)) - prev(bit7(0xA9ED51))) < 40 &&
                measured((4 + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) + prev(bitcount(0xA9ED4F)) +
                    prev(bitcount(0xA9ED50)) + 4 + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                    prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + bitcount(0xA9ED4D) + bitcount(0xA9ED4E) +
                    bitcount(0xA9ED4F) + bitcount(0xA9ED50) + bitcount(0xA9ED51) - bit0(0xA9ED4D) - bit5(0xA9ED51) -
                    bit6(0xA9ED51) - bit7(0xA9ED51)) == 36, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 5) &&
                (4 + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) + prev(bitcount(0xAA689F)) +
                prev(bitcount(0xAA68A0)) + prev(bitcount(0xAA68A1)) - prev(bit0(0xAA689D)) - prev(bit5(0xAA68A1)) -
                prev(bit6(0xAA68A1)) - prev(bit7(0xAA68A1))) > 31 &&
                (4 + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) + prev(bitcount(0xAA689F)) +
                prev(bitcount(0xAA68A0)) + 4 + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) +
                prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bitcount(0xAA68A1)) - prev(bit0(0xAA689D)) -
                prev(bit5(0xAA68A1)) - prev(bit6(0xAA68A1)) - prev(bit7(0xAA68A1))) < 40 &&
                measured((4 + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) + prev(bitcount(0xAA689F)) +
                    prev(bitcount(0xAA68A0)) + 4 + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) +
                    prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + bitcount(0xAA689D) + bitcount(0xAA689E) +
                    bitcount(0xAA689F) + bitcount(0xAA68A0) + bitcount(0xAA68A1) - bit0(0xAA689D) - bit5(0xAA68A1) -
                    bit6(0xAA68A1) - bit7(0xAA68A1)) == 36, format="percent"
                )))
)

achievement(
    title = "Meddling with Destiny", points = 10,
    description = "Reach 100% achievement rate for Chapter 5",
    id = 405092, badge = "466042", published = "5/03/2024 14:02:25", modified = "4/05/2024 22:10:10",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 6) &&
                (2 + prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bitcount(0xA9ED57)) - prev(bit0(0xA9ED52)) -
                prev(bit7(0xA9ED57))) > 35 &&
                (2 + prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + 2 + prev(bitcount(0xA9ED52)) +
                prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) + prev(bitcount(0xA9ED55)) +
                prev(bitcount(0xA9ED56)) + prev(bitcount(0xA9ED57)) - prev(bit0(0xA9ED52)) - prev(bit7(0xA9ED57))) < 48 &&
                measured((2 + prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                    prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + 2 + prev(bitcount(0xA9ED52)) +
                    prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) + prev(bitcount(0xA9ED55)) +
                    prev(bitcount(0xA9ED56)) + bitcount(0xA9ED52) + bitcount(0xA9ED53) + bitcount(0xA9ED54) +
                    bitcount(0xA9ED55) + bitcount(0xA9ED56) + bitcount(0xA9ED57) - bit0(0xA9ED52) - bit7(0xA9ED57)) == 46,
                    format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 6) &&
                (2 + prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bitcount(0xAA68A7)) - prev(bit0(0xAA68A2)) -
                prev(bit7(0xAA68A7))) > 35 &&
                (2 + prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + 2 + prev(bitcount(0xAA68A2)) +
                prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) + prev(bitcount(0xAA68A5)) +
                prev(bitcount(0xAA68A6)) + prev(bitcount(0xAA68A7)) - prev(bit0(0xAA68A2)) - prev(bit7(0xAA68A7))) < 48 &&
                measured((2 + prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                    prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + 2 + prev(bitcount(0xAA68A2)) +
                    prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) + prev(bitcount(0xAA68A5)) +
                    prev(bitcount(0xAA68A6)) + bitcount(0xAA68A2) + bitcount(0xAA68A3) + bitcount(0xAA68A4) +
                    bitcount(0xAA68A5) + bitcount(0xAA68A6) + bitcount(0xAA68A7) - bit0(0xAA68A2) - bit7(0xAA68A7)) == 46,
                    format="percent"
                )))
)

achievement(
    title = "The Good Samaritan", points = 10,
    description = "Reach 100% achievement rate for Chapter 6",
    id = 405093, badge = "466043", published = "5/03/2024 14:02:25", modified = "4/05/2024 22:10:04",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 7) &&
                (5 + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) - prev(bit0(0xA9ED5B)) - prev(bit1(0xA9ED5B)) -
                prev(bit5(0xA9ED5F)) - prev(bit6(0xA9ED5F)) - prev(bit7(0xA9ED5F))) > 29 &&
                (5 + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                prev(bitcount(0xA9ED5E)) + 5 + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) +
                prev(bitcount(0xA9ED5D)) + prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) - prev(bit0(0xA9ED5B)) -
                prev(bit1(0xA9ED5B)) - prev(bit5(0xA9ED5F)) - prev(bit6(0xA9ED5F)) - prev(bit7(0xA9ED5F))) < 40 &&
                measured((5 + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                    prev(bitcount(0xA9ED5E)) + 5 + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) +
                    prev(bitcount(0xA9ED5D)) + prev(bitcount(0xA9ED5E)) + bitcount(0xA9ED5B) + bitcount(0xA9ED5C) +
                    bitcount(0xA9ED5D) + bitcount(0xA9ED5E) + bitcount(0xA9ED5F) - bit0(0xA9ED5B) - bit1(0xA9ED5B) -
                    bit5(0xA9ED5F) - bit6(0xA9ED5F) - bit7(0xA9ED5F)) == 35, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 7) &&
                (5 + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) - prev(bit0(0xAA68AB)) - prev(bit1(0xAA68AB)) -
                prev(bit5(0xAA68AF)) - prev(bit6(0xAA68AF)) - prev(bit7(0xAA68AF))) > 29 &&
                (5 + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                prev(bitcount(0xAA68AE)) + 5 + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) +
                prev(bitcount(0xAA68AD)) + prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) - prev(bit0(0xAA68AB)) -
                prev(bit1(0xAA68AB)) - prev(bit5(0xAA68AF)) - prev(bit6(0xAA68AF)) - prev(bit7(0xAA68AF))) < 40 &&
                measured((5 + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                    prev(bitcount(0xAA68AE)) + 5 + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) +
                    prev(bitcount(0xAA68AD)) + prev(bitcount(0xAA68AE)) + bitcount(0xAA68AB) + bitcount(0xAA68AC) +
                    bitcount(0xAA68AD) + bitcount(0xAA68AE) + bitcount(0xAA68AF) - bit0(0xAA68AB) - bit1(0xAA68AB) -
                    bit5(0xAA68AF) - bit6(0xAA68AF) - bit7(0xAA68AF)) == 35, format="percent"
                )))
)

achievement(
    title = "Vintage Knots", points = 10,
    description = "Reach 100% achievement rate for Chapter 7",
    id = 405094, badge = "466044", published = "5/03/2024 14:02:25", modified = "4/05/2024 22:10:03",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless(byte(0xB95704) != 8) &&
                (2 + prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                prev(bit3(0xA9ED64)) - prev(bit0(0xA9ED60)) - prev(bit1(0xA9ED60))) > 26 &&
                (2 + prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + 2 +
                prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                prev(bit3(0xA9ED64)) - prev(bit0(0xA9ED60)) - prev(bit1(0xA9ED60))) < 36 &&
                measured((2 + prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                    prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + 2 +
                    prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                    prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                    bitcount(0xA9ED60) + bitcount(0xA9ED61) + bitcount(0xA9ED62) + bitcount(0xA9ED63) + bit0(0xA9ED64) +
                    bit1(0xA9ED64) + bit2(0xA9ED64) + bit3(0xA9ED64) - bit0(0xA9ED60) - bit1(0xA9ED60)) == 34,
                    format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless(byte(0xB9D284) != 8) &&
                (2 + prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                prev(bit3(0xAA68B4)) - prev(bit0(0xAA68B0)) - prev(bit1(0xAA68B0))) > 26 &&
                (2 + prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + 2 +
                prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                prev(bit3(0xAA68B4)) - prev(bit0(0xAA68B0)) - prev(bit1(0xAA68B0))) < 36 &&
                measured((2 + prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                    prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + 2 +
                    prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                    prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                    bitcount(0xAA68B0) + bitcount(0xAA68B1) + bitcount(0xAA68B2) + bitcount(0xAA68B3) + bit0(0xAA68B4) +
                    bit1(0xAA68B4) + bit2(0xAA68B4) + bit3(0xAA68B4) - bit0(0xAA68B0) - bit1(0xAA68B0)) == 34,
                    format="percent"
                )))
)

achievement(
    title = "The Power of Fate", points = 10,
    description = "Reach 100% achievement rate for Chapter 8",
    id = 405095, badge = "466045", published = "5/03/2024 14:02:25", modified = "4/05/2024 12:40:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless((byte(0xB95704) != 11 && byte(0xB95704) != 9)) &&
                (prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) +
                prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) +
                prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) +
                prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) +
                prev(bit3(0xA9ED6E))) > 51 &&
                (prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) +
                prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) +
                prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) +
                prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) +
                prev(bit3(0xA9ED6E))) < 71 &&
                measured((bit5(0xA9ED65) + bit6(0xA9ED65) + bit7(0xA9ED65) + bitcount(0xA9ED66) + bitcount(0xA9ED67) +
                    bitcount(0xA9ED68) + bitcount(0xA9ED69) + bitcount(0xA9ED6A) + bitcount(0xA9ED6B) + bitcount(0xA9ED6C) +
                    bitcount(0xA9ED6D) + bit0(0xA9ED6E) + bit1(0xA9ED6E) + bit2(0xA9ED6E) + bit3(0xA9ED6E)) == 71,
                    format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless((byte(0xB9D284) != 11 && byte(0xB9D284) != 9)) &&
                (prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) +
                prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) +
                prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) +
                prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) +
                prev(bit3(0xAA68BE))) > 51 &&
                (prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) +
                prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) +
                prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) +
                prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) +
                prev(bit3(0xAA68BE))) < 71 &&
                measured((bit5(0xAA68B5) + bit6(0xAA68B5) + bit7(0xAA68B5) + bitcount(0xAA68B6) + bitcount(0xAA68B7) +
                    bitcount(0xAA68B8) + bitcount(0xAA68B9) + bitcount(0xAA68BA) + bitcount(0xAA68BB) + bitcount(0xAA68BC) +
                    bitcount(0xAA68BD) + bit0(0xAA68BE) + bit1(0xAA68BE) + bit2(0xAA68BE) + bit3(0xAA68BE)) == 71,
                    format="percent"
                )))
)

achievement(
    title = "Eternal Youth", points = 10,
    description = "Reach 100% achievement rate for the Epilogue",
    id = 405096, badge = "466046", published = "5/03/2024 14:02:34", modified = "4/05/2024 22:10:03",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                unless((byte(0xB95704) != 12 && byte(0xB95704) != 10)) &&
                (2 + prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) +
                prev(bit0(0xA9ED74)) - prev(bit0(0xA9ED71)) - prev(bit1(0xA9ED71))) > 17 &&
                (2 + prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + 2 +
                prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + prev(bit0(0xA9ED74)) -
                prev(bit0(0xA9ED71)) - prev(bit1(0xA9ED71))) < 25 &&
                measured((2 + prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + 2 +
                    prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + bitcount(0xA9ED71) +
                    bitcount(0xA9ED72) + bitcount(0xA9ED73) + bit0(0xA9ED74) - bit0(0xA9ED71) - bit1(0xA9ED71)) == 23,
                    format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                unless((byte(0xB9D284) != 12 && byte(0xB9D284) != 10)) &&
                (2 + prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) +
                prev(bit0(0xAA68C4)) - prev(bit0(0xAA68C1)) - prev(bit1(0xAA68C1))) > 17 &&
                (2 + prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + 2 +
                prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + prev(bit0(0xAA68C4)) -
                prev(bit0(0xAA68C1)) - prev(bit1(0xAA68C1))) < 25 &&
                measured((2 + prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + 2 +
                    prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + bitcount(0xAA68C1) +
                    bitcount(0xAA68C2) + bitcount(0xAA68C3) + bit0(0xAA68C4) - bit0(0xAA68C1) - bit1(0xAA68C1)) == 23,
                    format="percent"
                )))
)

achievement(
    title = "The Day of Walpurgis", points = 50,
    description = "Reach 100% total achievement rate",
    id = 405097, badge = "466047", published = "5/03/2024 14:02:34", modified = "4/05/2024 22:10:03",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(low4(0xA9EDDC) == 0) && unless(dword(0xAC49F4) != 0) &&
                (26 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) +
                prev(bitcount(0xA9ED42)) + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) +
                prev(bitcount(0xA9ED45)) + prev(bitcount(0xA9ED46)) + prev(bitcount(0xA9ED47)) +
                prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) +
                prev(bitcount(0xA9ED4B)) + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) +
                prev(bitcount(0xA9ED5A)) + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bitcount(0xA9ED51)) +
                prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bitcount(0xA9ED57)) +
                prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) + prev(bitcount(0xA9ED60)) +
                prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) + prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) +
                prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) +
                prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) + prev(bitcount(0xA9ED67)) +
                prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) + prev(bitcount(0xA9ED6A)) +
                prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) + prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) +
                prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bitcount(0xA9ED71)) +
                prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + prev(bit0(0xA9ED74)) - prev(bit0(0xA9ED3C)) -
                prev(bit6(0xA9ED42)) - prev(bit7(0xA9ED42)) - prev(bit6(0xA9ED46)) - prev(bit7(0xA9ED46)) -
                prev(bit0(0xA9ED47)) - prev(bit1(0xA9ED47)) - prev(bit2(0xA9ED47)) - prev(bit7(0xA9ED4B)) -
                prev(bit0(0xA9ED58)) - prev(bit1(0xA9ED58)) - prev(bit0(0xA9ED4D)) - prev(bit5(0xA9ED51)) -
                prev(bit6(0xA9ED51)) - prev(bit7(0xA9ED51)) - prev(bit0(0xA9ED52)) - prev(bit7(0xA9ED57)) -
                prev(bit0(0xA9ED5B)) - prev(bit1(0xA9ED5B)) - prev(bit5(0xA9ED5F)) - prev(bit6(0xA9ED5F)) -
                prev(bit7(0xA9ED5F)) - prev(bit0(0xA9ED60)) - prev(bit1(0xA9ED60)) - prev(bit0(0xA9ED71)) -
                prev(bit1(0xA9ED71))) > 368 &&
                (26 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) +
                prev(bitcount(0xA9ED42)) + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) +
                prev(bitcount(0xA9ED45)) + prev(bitcount(0xA9ED46)) + prev(bitcount(0xA9ED47)) +
                prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) +
                prev(bitcount(0xA9ED4B)) + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) +
                prev(bitcount(0xA9ED5A)) + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bitcount(0xA9ED51)) +
                prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bitcount(0xA9ED57)) +
                prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) + prev(bitcount(0xA9ED60)) +
                prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) + prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) +
                prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) +
                prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) + prev(bitcount(0xA9ED67)) +
                prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) + prev(bitcount(0xA9ED6A)) +
                prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) + prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) +
                prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bitcount(0xA9ED71)) +
                prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + 26 + prev(bitcount(0xA9ED3C)) +
                prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) + prev(bitcount(0xA9ED3F)) +
                prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) + prev(bitcount(0xA9ED42)) + prev(bit6(0xA9ED43)) +
                prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) + prev(bitcount(0xA9ED46)) +
                prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                prev(bitcount(0xA9ED4A)) + prev(bitcount(0xA9ED4B)) + prev(bitcount(0xA9ED58)) +
                prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A)) + prev(bitcount(0xA9ED4D)) +
                prev(bitcount(0xA9ED4E)) + prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) +
                prev(bitcount(0xA9ED51)) + prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) +
                prev(bitcount(0xA9ED54)) + prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) +
                prev(bitcount(0xA9ED57)) + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) +
                prev(bitcount(0xA9ED5D)) + prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) +
                prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) +
                prev(bitcount(0xA9ED66)) + prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) +
                prev(bitcount(0xA9ED69)) + prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) +
                prev(bitcount(0xA9ED6C)) + prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) +
                prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) +
                prev(bitcount(0xA9ED73)) + prev(bit0(0xA9ED74)) - prev(bit0(0xA9ED3C)) - prev(bit6(0xA9ED42)) -
                prev(bit7(0xA9ED42)) - prev(bit6(0xA9ED46)) - prev(bit7(0xA9ED46)) - prev(bit0(0xA9ED47)) -
                prev(bit1(0xA9ED47)) - prev(bit2(0xA9ED47)) - prev(bit7(0xA9ED4B)) - prev(bit0(0xA9ED58)) -
                prev(bit1(0xA9ED58)) - prev(bit0(0xA9ED4D)) - prev(bit5(0xA9ED51)) - prev(bit6(0xA9ED51)) -
                prev(bit7(0xA9ED51)) - prev(bit0(0xA9ED52)) - prev(bit7(0xA9ED57)) - prev(bit0(0xA9ED5B)) -
                prev(bit1(0xA9ED5B)) - prev(bit5(0xA9ED5F)) - prev(bit6(0xA9ED5F)) - prev(bit7(0xA9ED5F)) -
                prev(bit0(0xA9ED60)) - prev(bit1(0xA9ED60)) - prev(bit0(0xA9ED71)) - prev(bit1(0xA9ED71))) < 406 &&
                measured((26 + prev(bitcount(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) +
                    prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) +
                    prev(bitcount(0xA9ED42)) + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) +
                    prev(bitcount(0xA9ED45)) + prev(bitcount(0xA9ED46)) + prev(bitcount(0xA9ED47)) +
                    prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) +
                    prev(bitcount(0xA9ED4B)) + prev(bitcount(0xA9ED58)) + prev(bitcount(0xA9ED59)) +
                    prev(bitcount(0xA9ED5A)) + prev(bitcount(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                    prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bitcount(0xA9ED51)) +
                    prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                    prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bitcount(0xA9ED57)) +
                    prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                    prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) + prev(bitcount(0xA9ED60)) +
                    prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) + prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) +
                    prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) +
                    prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) + prev(bitcount(0xA9ED67)) +
                    prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) + prev(bitcount(0xA9ED6A)) +
                    prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) + prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) +
                    prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bitcount(0xA9ED71)) +
                    prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) + 26 + prev(bitcount(0xA9ED3C)) +
                    prev(bitcount(0xA9ED3D)) + prev(bitcount(0xA9ED3E)) + prev(bitcount(0xA9ED3F)) +
                    prev(bitcount(0xA9ED40)) + prev(bitcount(0xA9ED41)) + prev(bitcount(0xA9ED42)) + prev(bit6(0xA9ED43)) +
                    prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) + prev(bitcount(0xA9ED46)) +
                    prev(bitcount(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                    prev(bitcount(0xA9ED4A)) + prev(bitcount(0xA9ED4B)) + prev(bitcount(0xA9ED58)) +
                    prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A)) + prev(bitcount(0xA9ED4D)) +
                    prev(bitcount(0xA9ED4E)) + prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) +
                    prev(bitcount(0xA9ED51)) + prev(bitcount(0xA9ED52)) + prev(bitcount(0xA9ED53)) +
                    prev(bitcount(0xA9ED54)) + prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) +
                    prev(bitcount(0xA9ED57)) + prev(bitcount(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) +
                    prev(bitcount(0xA9ED5D)) + prev(bitcount(0xA9ED5E)) + prev(bitcount(0xA9ED5F)) +
                    prev(bitcount(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                    prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                    prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) +
                    prev(bitcount(0xA9ED66)) + prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) +
                    prev(bitcount(0xA9ED69)) + prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) +
                    prev(bitcount(0xA9ED6C)) + prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) +
                    prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bitcount(0xA9ED71)) + prev(bitcount(0xA9ED72)) +
                    prev(bitcount(0xA9ED73)) + bitcount(0xA9ED3C) + bitcount(0xA9ED3D) + bitcount(0xA9ED3E) +
                    bitcount(0xA9ED3F) + bitcount(0xA9ED40) + bitcount(0xA9ED41) + bitcount(0xA9ED42) + bit6(0xA9ED43) +
                    bit7(0xA9ED43) + bitcount(0xA9ED44) + bitcount(0xA9ED45) + bitcount(0xA9ED46) + bitcount(0xA9ED47) +
                    bitcount(0xA9ED48) + bitcount(0xA9ED49) + bitcount(0xA9ED4A) + bitcount(0xA9ED4B) + bitcount(0xA9ED58) +
                    bitcount(0xA9ED59) + bitcount(0xA9ED5A) + bitcount(0xA9ED4D) + bitcount(0xA9ED4E) + bitcount(0xA9ED4F) +
                    bitcount(0xA9ED50) + bitcount(0xA9ED51) + bitcount(0xA9ED52) + bitcount(0xA9ED53) + bitcount(0xA9ED54) +
                    bitcount(0xA9ED55) + bitcount(0xA9ED56) + bitcount(0xA9ED57) + bitcount(0xA9ED5B) + bitcount(0xA9ED5C) +
                    bitcount(0xA9ED5D) + bitcount(0xA9ED5E) + bitcount(0xA9ED5F) + bitcount(0xA9ED60) + bitcount(0xA9ED61) +
                    bitcount(0xA9ED62) + bitcount(0xA9ED63) + bit0(0xA9ED64) + bit1(0xA9ED64) + bit2(0xA9ED64) +
                    bit3(0xA9ED64) + bit5(0xA9ED65) + bit6(0xA9ED65) + bit7(0xA9ED65) + bitcount(0xA9ED66) +
                    bitcount(0xA9ED67) + bitcount(0xA9ED68) + bitcount(0xA9ED69) + bitcount(0xA9ED6A) + bitcount(0xA9ED6B) +
                    bitcount(0xA9ED6C) + bitcount(0xA9ED6D) + bit0(0xA9ED6E) + bit1(0xA9ED6E) + bit2(0xA9ED6E) +
                    bit3(0xA9ED6E) + bitcount(0xA9ED71) + bitcount(0xA9ED72) + bitcount(0xA9ED73) + bit0(0xA9ED74) -
                    bit0(0xA9ED3C) - bit6(0xA9ED42) - bit7(0xA9ED42) - bit6(0xA9ED46) - bit7(0xA9ED46) - bit0(0xA9ED47) -
                    bit1(0xA9ED47) - bit2(0xA9ED47) - bit7(0xA9ED4B) - bit0(0xA9ED58) - bit1(0xA9ED58) - bit0(0xA9ED4D) -
                    bit5(0xA9ED51) - bit6(0xA9ED51) - bit7(0xA9ED51) - bit0(0xA9ED52) - bit7(0xA9ED57) - bit0(0xA9ED5B) -
                    bit1(0xA9ED5B) - bit5(0xA9ED5F) - bit6(0xA9ED5F) - bit7(0xA9ED5F) - bit0(0xA9ED60) - bit1(0xA9ED60) -
                    bit0(0xA9ED71) - bit1(0xA9ED71)) == 380, format="percent"
                )) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(low4(0xAA692C) == 0) && unless(dword(0xACC534) != 0) &&
                (26 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) +
                prev(bitcount(0xAA6892)) + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) +
                prev(bitcount(0xAA6895)) + prev(bitcount(0xAA6896)) + prev(bitcount(0xAA6897)) +
                prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) +
                prev(bitcount(0xAA689B)) + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) +
                prev(bitcount(0xAA68AA)) + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) +
                prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bitcount(0xAA68A1)) +
                prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bitcount(0xAA68A7)) +
                prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) + prev(bitcount(0xAA68B0)) +
                prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) + prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) +
                prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + prev(bit3(0xAA68B4)) + prev(bit5(0xAA68B5)) +
                prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) + prev(bitcount(0xAA68B7)) +
                prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) + prev(bitcount(0xAA68BA)) +
                prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) + prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) +
                prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) + prev(bit3(0xAA68BE)) + prev(bitcount(0xAA68C1)) +
                prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + prev(bit0(0xAA68C4)) - prev(bit0(0xAA688C)) -
                prev(bit6(0xAA6892)) - prev(bit7(0xAA6892)) - prev(bit6(0xAA6896)) - prev(bit7(0xAA6896)) -
                prev(bit0(0xAA6897)) - prev(bit1(0xAA6897)) - prev(bit2(0xAA6897)) - prev(bit7(0xAA689B)) -
                prev(bit0(0xAA68A8)) - prev(bit1(0xAA68A8)) - prev(bit0(0xAA689D)) - prev(bit5(0xAA68A1)) -
                prev(bit6(0xAA68A1)) - prev(bit7(0xAA68A1)) - prev(bit0(0xAA68A2)) - prev(bit7(0xAA68A7)) -
                prev(bit0(0xAA68AB)) - prev(bit1(0xAA68AB)) - prev(bit5(0xAA68AF)) - prev(bit6(0xAA68AF)) -
                prev(bit7(0xAA68AF)) - prev(bit0(0xAA68B0)) - prev(bit1(0xAA68B0)) - prev(bit0(0xAA68C1)) -
                prev(bit1(0xAA68C1))) > 368 &&
                (26 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) +
                prev(bitcount(0xAA6892)) + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) +
                prev(bitcount(0xAA6895)) + prev(bitcount(0xAA6896)) + prev(bitcount(0xAA6897)) +
                prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) +
                prev(bitcount(0xAA689B)) + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) +
                prev(bitcount(0xAA68AA)) + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) +
                prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bitcount(0xAA68A1)) +
                prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bitcount(0xAA68A7)) +
                prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) + prev(bitcount(0xAA68B0)) +
                prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) + prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) +
                prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + prev(bit3(0xAA68B4)) + prev(bit5(0xAA68B5)) +
                prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) + prev(bitcount(0xAA68B7)) +
                prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) + prev(bitcount(0xAA68BA)) +
                prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) + prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) +
                prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) + prev(bit3(0xAA68BE)) + prev(bitcount(0xAA68C1)) +
                prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + 26 + prev(bitcount(0xAA688C)) +
                prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) + prev(bitcount(0xAA688F)) +
                prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) + prev(bitcount(0xAA6892)) + prev(bit6(0xAA6893)) +
                prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) + prev(bitcount(0xAA6896)) +
                prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                prev(bitcount(0xAA689A)) + prev(bitcount(0xAA689B)) + prev(bitcount(0xAA68A8)) +
                prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA)) + prev(bitcount(0xAA689D)) +
                prev(bitcount(0xAA689E)) + prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) +
                prev(bitcount(0xAA68A1)) + prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) +
                prev(bitcount(0xAA68A4)) + prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) +
                prev(bitcount(0xAA68A7)) + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) +
                prev(bitcount(0xAA68AD)) + prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) +
                prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                prev(bit3(0xAA68B4)) + prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) +
                prev(bitcount(0xAA68B6)) + prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) +
                prev(bitcount(0xAA68B9)) + prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) +
                prev(bitcount(0xAA68BC)) + prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) +
                prev(bit2(0xAA68BE)) + prev(bit3(0xAA68BE)) + prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) +
                prev(bitcount(0xAA68C3)) + prev(bit0(0xAA68C4)) - prev(bit0(0xAA688C)) - prev(bit6(0xAA6892)) -
                prev(bit7(0xAA6892)) - prev(bit6(0xAA6896)) - prev(bit7(0xAA6896)) - prev(bit0(0xAA6897)) -
                prev(bit1(0xAA6897)) - prev(bit2(0xAA6897)) - prev(bit7(0xAA689B)) - prev(bit0(0xAA68A8)) -
                prev(bit1(0xAA68A8)) - prev(bit0(0xAA689D)) - prev(bit5(0xAA68A1)) - prev(bit6(0xAA68A1)) -
                prev(bit7(0xAA68A1)) - prev(bit0(0xAA68A2)) - prev(bit7(0xAA68A7)) - prev(bit0(0xAA68AB)) -
                prev(bit1(0xAA68AB)) - prev(bit5(0xAA68AF)) - prev(bit6(0xAA68AF)) - prev(bit7(0xAA68AF)) -
                prev(bit0(0xAA68B0)) - prev(bit1(0xAA68B0)) - prev(bit0(0xAA68C1)) - prev(bit1(0xAA68C1))) < 406 &&
                measured((26 + prev(bitcount(0xAA688C)) + prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) +
                    prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) +
                    prev(bitcount(0xAA6892)) + prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) +
                    prev(bitcount(0xAA6895)) + prev(bitcount(0xAA6896)) + prev(bitcount(0xAA6897)) +
                    prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) +
                    prev(bitcount(0xAA689B)) + prev(bitcount(0xAA68A8)) + prev(bitcount(0xAA68A9)) +
                    prev(bitcount(0xAA68AA)) + prev(bitcount(0xAA689D)) + prev(bitcount(0xAA689E)) +
                    prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bitcount(0xAA68A1)) +
                    prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                    prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bitcount(0xAA68A7)) +
                    prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                    prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) + prev(bitcount(0xAA68B0)) +
                    prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) + prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) +
                    prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + prev(bit3(0xAA68B4)) + prev(bit5(0xAA68B5)) +
                    prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) + prev(bitcount(0xAA68B7)) +
                    prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) + prev(bitcount(0xAA68BA)) +
                    prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) + prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) +
                    prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) + prev(bit3(0xAA68BE)) + prev(bitcount(0xAA68C1)) +
                    prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) + 26 + prev(bitcount(0xAA688C)) +
                    prev(bitcount(0xAA688D)) + prev(bitcount(0xAA688E)) + prev(bitcount(0xAA688F)) +
                    prev(bitcount(0xAA6890)) + prev(bitcount(0xAA6891)) + prev(bitcount(0xAA6892)) + prev(bit6(0xAA6893)) +
                    prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) + prev(bitcount(0xAA6896)) +
                    prev(bitcount(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                    prev(bitcount(0xAA689A)) + prev(bitcount(0xAA689B)) + prev(bitcount(0xAA68A8)) +
                    prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA)) + prev(bitcount(0xAA689D)) +
                    prev(bitcount(0xAA689E)) + prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) +
                    prev(bitcount(0xAA68A1)) + prev(bitcount(0xAA68A2)) + prev(bitcount(0xAA68A3)) +
                    prev(bitcount(0xAA68A4)) + prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) +
                    prev(bitcount(0xAA68A7)) + prev(bitcount(0xAA68AB)) + prev(bitcount(0xAA68AC)) +
                    prev(bitcount(0xAA68AD)) + prev(bitcount(0xAA68AE)) + prev(bitcount(0xAA68AF)) +
                    prev(bitcount(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                    prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                    prev(bit3(0xAA68B4)) + prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) +
                    prev(bitcount(0xAA68B6)) + prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) +
                    prev(bitcount(0xAA68B9)) + prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) +
                    prev(bitcount(0xAA68BC)) + prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) +
                    prev(bit2(0xAA68BE)) + prev(bit3(0xAA68BE)) + prev(bitcount(0xAA68C1)) + prev(bitcount(0xAA68C2)) +
                    prev(bitcount(0xAA68C3)) + bitcount(0xAA688C) + bitcount(0xAA688D) + bitcount(0xAA688E) +
                    bitcount(0xAA688F) + bitcount(0xAA6890) + bitcount(0xAA6891) + bitcount(0xAA6892) + bit6(0xAA6893) +
                    bit7(0xAA6893) + bitcount(0xAA6894) + bitcount(0xAA6895) + bitcount(0xAA6896) + bitcount(0xAA6897) +
                    bitcount(0xAA6898) + bitcount(0xAA6899) + bitcount(0xAA689A) + bitcount(0xAA689B) + bitcount(0xAA68A8) +
                    bitcount(0xAA68A9) + bitcount(0xAA68AA) + bitcount(0xAA689D) + bitcount(0xAA689E) + bitcount(0xAA689F) +
                    bitcount(0xAA68A0) + bitcount(0xAA68A1) + bitcount(0xAA68A2) + bitcount(0xAA68A3) + bitcount(0xAA68A4) +
                    bitcount(0xAA68A5) + bitcount(0xAA68A6) + bitcount(0xAA68A7) + bitcount(0xAA68AB) + bitcount(0xAA68AC) +
                    bitcount(0xAA68AD) + bitcount(0xAA68AE) + bitcount(0xAA68AF) + bitcount(0xAA68B0) + bitcount(0xAA68B1) +
                    bitcount(0xAA68B2) + bitcount(0xAA68B3) + bit0(0xAA68B4) + bit1(0xAA68B4) + bit2(0xAA68B4) +
                    bit3(0xAA68B4) + bit5(0xAA68B5) + bit6(0xAA68B5) + bit7(0xAA68B5) + bitcount(0xAA68B6) +
                    bitcount(0xAA68B7) + bitcount(0xAA68B8) + bitcount(0xAA68B9) + bitcount(0xAA68BA) + bitcount(0xAA68BB) +
                    bitcount(0xAA68BC) + bitcount(0xAA68BD) + bit0(0xAA68BE) + bit1(0xAA68BE) + bit2(0xAA68BE) +
                    bit3(0xAA68BE) + bitcount(0xAA68C1) + bitcount(0xAA68C2) + bitcount(0xAA68C3) + bit0(0xAA68C4) -
                    bit0(0xAA688C) - bit6(0xAA6892) - bit7(0xAA6892) - bit6(0xAA6896) - bit7(0xAA6896) - bit0(0xAA6897) -
                    bit1(0xAA6897) - bit2(0xAA6897) - bit7(0xAA689B) - bit0(0xAA68A8) - bit1(0xAA68A8) - bit0(0xAA689D) -
                    bit5(0xAA68A1) - bit6(0xAA68A1) - bit7(0xAA68A1) - bit0(0xAA68A2) - bit7(0xAA68A7) - bit0(0xAA68AB) -
                    bit1(0xAA68AB) - bit5(0xAA68AF) - bit6(0xAA68AF) - bit7(0xAA68AF) - bit0(0xAA68B0) - bit1(0xAA68B0) -
                    bit0(0xAA68C1) - bit1(0xAA68C1)) == 380, format="percent"
                )))
)

leaderboard(
    id = 92194, title = "Total Clear Time",
    description = "Race through time to achieve the fastest total clear time (EX chapter excluded)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xB95704) == 12 &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xB95704) == 10 &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xB9D284) == 12 &&
               prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xB9D284) == 10 &&
               prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((dword(0x8FBEF0) & 0x1FFFFFF) + 0x00002C) == 65)),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA1560) / 3600),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90B0) / 3600),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "MINUTES"
)

leaderboard(
    id = 92195, title = "Prologue Clear Time",
    description = "Race through time to achieve the fastest clear time for the prologue (EX chapter excluded)",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 1) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 1 && bit0(0xA82E2C) == 0) && bit7(0xA9ED98) == 0 &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 1) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 1 && bit0(0xA8A97C) == 0) && bit7(0xAA68E8) == 0 &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92196, title = "Chapter 1 Clear Time",
    description = "Prove your mastery over time by completing Chapter 1 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 2) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 2 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 2) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 2 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92197, title = "Chapter 2 Clear Time",
    description = "Prove your mastery over time by completing Chapter 2 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 3 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 3) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 3 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92198, title = "Chapter 3 Clear Time",
    description = "Prove your mastery over time by completing Chapter 3 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 4) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 4 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 4) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 4 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92199, title = "Chapter 4 Clear Time",
    description = "Prove your mastery over time by completing Chapter 4 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 5 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 5) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 5 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92200, title = "Chapter 5 Clear Time",
    description = "Prove your mastery over time by completing Chapter 5 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 6 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 6) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 6 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92201, title = "Chapter 6 Clear Time",
    description = "Prove your mastery over time by completing Chapter 6 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 7) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 7 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 7) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 7 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92202, title = "Chapter 7 Clear Time",
    description = "Prove your mastery over time by completing Chapter 7 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) &&
               repeated(100, low4(0xA9EDDC) != 0 && byte(0xB95704) == 8 && bit0(0xA82E2C) == 0) &&
               bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 8) &&
               repeated(100, low4(0xAA692C) != 0 && byte(0xB9D284) == 8 && bit0(0xA8A97C) == 0) &&
               bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 92203, title = "Chapter 8 Clear Time",
    description = "Prove your mastery over time by completing Chapter 8 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
               never((byte(0xB95704) != 11 && byte(0xB95704) != 9)) &&
               repeated(100, (byte(0xB95704) == 11 || byte(0xB95704) == 9) && low4(0xA9EDDC) != 0 && bit0(0xA82E2C) == 0
               ) && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
               never((byte(0xB9D284) != 11 && byte(0xB9D284) != 9)) &&
               repeated(100, (byte(0xB9D284) == 11 || byte(0xB9D284) == 9) && low4(0xAA692C) != 0 && bit0(0xA8A97C) == 0
               ) && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
    cancel = always_false(),
    submit = always_true(),
    value = max_of(
                measured(tally(0, dword(0xAA155C) / 60),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57
                ),
                measured(tally(0, dword(0xAA90AC) / 60),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50
                )
            ),
    format = "SECS"
)

leaderboard(
    id = 94367, title = "Agile Energy Hunter: Present",
    description = "Collect all five energy orbs scattered throughout Lebensbaum in the present time, as quickly as possible (leaderboard starts when 2 orbs have been picked up)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xA9DAA8) <= 6 &&
               ((prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442EC) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA442EC) &
               0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008))) == 1 &&
               ((bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007)) +
               bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008)) == 2) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xAA55F8) <= 6 &&
               ((prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450BC) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA450BC) &
               0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008))) == 1 &&
               ((bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007)) +
               bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008)) == 2)),
    cancel = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) == 0) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) != prev(byte(0xB95704))) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xA9DAA8) < prev(byte(0xA9DAA8))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) == 0) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) != prev(byte(0xB9D284))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xAA55F8) < prev(byte(0xAA55F8)))),
    submit = always_true() &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) &&
               unless((dword(0xA82E48) != 885 && dword(0xA82E48) != 68 && dword(0xA82E48) != 3)) &&
               tally(5,
                   bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442EC) & 0x1FFFFFF) + 0x000008))
               )) ||
              (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                   byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                   dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
               ) && always_false()) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) &&
               unless((dword(0xA8A998) != 885 && dword(0xA8A998) != 68 && dword(0xA8A998) != 3)) &&
               tally(5,
                   bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450BC) & 0x1FFFFFF) + 0x000008))
               )) ||
              (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                   byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                   dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
               ) && always_false())),
    value = max_of(
                unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                unless(((bit0(0xB91514) == 1 && bit0(0xB91518) == 1) || byte(0xA9EB2E) != 8) && low4(0xA9EDDC) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
                never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) &&
                measured(tally(0, dword(0xB88AB0) != prev(dword(0xB88AB0)))),
                unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                unless(((bit0(0xB99094) == 1 && bit0(0xB99098) == 1) || byte(0xAA667E) != 8) && low4(0xAA692C) != 0) &&
                never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                never(byte(0xAA55F8) < prev(byte(0xAA55F8))) &&
                measured(tally(0, dword(0xB905F0) != prev(dword(0xB905F0))))
            ),
    format = "FRAMES"
)

leaderboard(
    id = 94364, title = "Agile Energy Hunter: Middle Ages",
    description = "Collect six energy orbs scattered throughout Lebensbaum in the Middle Ages, as quickly as possible (leaderboard starts when 2 orbs have been picked up)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xA9DAA8) <= 5 &&
               ((prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA442F8) &
               0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008))) +
               (prev(bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004))) + prev(bit0((dword(0xA44300) & 0x1FFFFFF) +
               0x000004))) == 1 &&
               ((bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007)) +
               (bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004)) +
               bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004)) == 2) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xAA55F8) <= 5 &&
               ((prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA450C8) &
               0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008))) +
               (prev(bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004))) + prev(bit0((dword(0xA450D0) & 0x1FFFFFF) +
               0x000004))) == 1 &&
               ((bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007)) +
               (bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008)) + (bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004)) +
               bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004)) == 2)),
    cancel = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) == 0) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) != prev(byte(0xB95704))) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xA9DAA8) < prev(byte(0xA9DAA8))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) == 0) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) != prev(byte(0xB9D284))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xAA55F8) < prev(byte(0xAA55F8)))),
    submit = always_true() &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) &&
               unless((dword(0xA82E48) != 1011 && dword(0xA82E48) != 828 && dword(0xA82E48) != 535 &&
                   dword(0xA82E48) != 142)
               ) &&
               tally(6,
                   bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000008)),
                   bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA4430C) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA44300) & 0x1FFFFFF) + 0x000004))
               )) ||
              (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                   byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                   dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
               ) && always_false()) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) &&
               unless((dword(0xA8A998) != 1011 && dword(0xA8A998) != 828 && dword(0xA8A998) != 535 &&
                   dword(0xA8A998) != 142)
               ) &&
               tally(6,
                   bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000008)),
                   bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450DC) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450D0) & 0x1FFFFFF) + 0x000004))
               )) ||
              (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                   byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                   dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
               ) && always_false())),
    value = max_of(
                unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                unless(((bit0(0xB91514) == 1 && bit0(0xB91518) == 1) || byte(0xA9EB2E) != 8) && low4(0xA9EDDC) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
                never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) &&
                measured(tally(0, dword(0xB88AB0) != prev(dword(0xB88AB0)))),
                unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                unless(((bit0(0xB99094) == 1 && bit0(0xB99098) == 1) || byte(0xAA667E) != 8) && low4(0xAA692C) != 0) &&
                never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                never(byte(0xAA55F8) < prev(byte(0xAA55F8))) &&
                measured(tally(0, dword(0xB905F0) != prev(dword(0xB905F0))))
            ),
    format = "FRAMES"
)

leaderboard(
    id = 94366, title = "Agile Energy Hunter: Late 20th century",
    description = "Collect all five energy orbs scattered throughout Lebensbaum in the late 20th century, as quickly as possible (leaderboard starts when 2 orbs have been picked up)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xA9DAA8) <= 6 &&
               ((prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F0) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA442F0) &
               0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008))) == 1 &&
               ((bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000007)) +
               bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008)) == 2) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xAA55F8) <= 6 &&
               ((prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C0) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA450C0) &
               0x1FFFFFF) + 0x000007))) + prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008))) == 1 &&
               ((bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000007)) +
               bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008)) == 2)),
    cancel = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) == 0) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) != prev(byte(0xB95704))) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xA9DAA8) < prev(byte(0xA9DAA8))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) == 0) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) != prev(byte(0xB9D284))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xAA55F8) < prev(byte(0xAA55F8)))),
    submit = always_true() &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && unless((dword(0xA82E48) != 1125 && dword(0xA82E48) != 797)) &&
               tally(5,
                   bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F0) & 0x1FFFFFF) + 0x000008))
               )) ||
              (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                   byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                   dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
               ) && always_false()) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && unless((dword(0xA8A998) != 1125 && dword(0xA8A998) != 797)) &&
               tally(5,
                   bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C0) & 0x1FFFFFF) + 0x000008))
               )) ||
              (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                   byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                   dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
               ) && always_false())),
    value = max_of(
                unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                unless(((bit0(0xB91514) == 1 && bit0(0xB91518) == 1) || byte(0xA9EB2E) != 8) && low4(0xA9EDDC) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
                never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) &&
                measured(tally(0, dword(0xB88AB0) != prev(dword(0xB88AB0)))),
                unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                unless(((bit0(0xB99094) == 1 && bit0(0xB99098) == 1) || byte(0xAA667E) != 8) && low4(0xAA692C) != 0) &&
                never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                never(byte(0xAA55F8) < prev(byte(0xAA55F8))) &&
                measured(tally(0, dword(0xB905F0) != prev(dword(0xB905F0))))
            ),
    format = "FRAMES"
)

leaderboard(
    id = 94365, title = "Agile Energy Hunter: Early 20th century",
    description = "Collect all six energy orbs scattered throughout Lebensbaum in the early 20th century, as quickly as possible (leaderboard starts when 2 orbs have been picked up)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && byte(0xA9DAA8) <= 5 &&
               ((prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA442F4) &
               0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008))) +
               prev(bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004))) == 1 &&
               ((bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007)) +
               (bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008)) + bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004)) == 2) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && byte(0xAA55F8) <= 5 &&
               ((prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF) +
               0x000005))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006))) + (prev(bit0((dword(0xA450C4) &
               0x1FFFFFF) + 0x000007))) + (prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008))) +
               prev(bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004))) == 1 &&
               ((bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004)) + (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005)) +
               (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006)) + (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007)) +
               (bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008)) + bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004)) == 2)),
    cancel = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) == 0) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) != prev(byte(0xB95704))) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xA9DAA8) < prev(byte(0xA9DAA8))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) == 0) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) != prev(byte(0xB9D284))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xAA55F8) < prev(byte(0xAA55F8)))),
    submit = always_true() &&
             ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
               unless(byte(0xA5AB4C) != 57) && unless((dword(0xA82E48) != 569 && dword(0xA82E48) != 1539)) &&
               tally(6,
                   bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000008)),
                   bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA44304) & 0x1FFFFFF) + 0x000004))
               )) ||
              (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                   byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                   dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
               ) && always_false()) ||
              (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
               unless(byte(0xA64C7C) != 50) && unless((dword(0xA8A998) != 569 && dword(0xA8A998) != 1539)) &&
               tally(6,
                   bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004)),
                   bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000005)),
                   bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000006)),
                   bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000007)),
                   bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000008)),
                   bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450D4) & 0x1FFFFFF) + 0x000004))
               )) ||
              (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                   byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                   dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
               ) && always_false())),
    value = max_of(
                unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) &&
                unless(((bit0(0xB91514) == 1 && bit0(0xB91518) == 1) || byte(0xA9EB2E) != 8) && low4(0xA9EDDC) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
                never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) &&
                measured(tally(0, dword(0xB88AB0) != prev(dword(0xB88AB0)))),
                unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) &&
                unless(((bit0(0xB99094) == 1 && bit0(0xB99098) == 1) || byte(0xAA667E) != 8) && low4(0xAA692C) != 0) &&
                never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != prev(byte(0xB9D284))) &&
                never(byte(0xAA55F8) < prev(byte(0xAA55F8))) &&
                measured(tally(0, dword(0xB905F0) != prev(dword(0xB905F0))))
            ),
    format = "FRAMES"
)

rich_presence_conditional_display(dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 &&
    bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1156) == 1 && bit0(0xAA1155) == 1 &&
    bit0(0xAA1154) == 1 && dword(0xAC49F4) == 0 && byte(0xB95704) == 1, "Ending the cycle | The Fated 🕑 {0} | Current 🕑 {1}:{2} | Completion: {3}%",
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA12B0), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA12B0)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA12B4), PresentTimeMinutes_ZeroPaddingLookup, fallback="0")
)

rich_presence_conditional_display(dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 &&
    bit7(0xA9ED98) == 0 && dword(0xAC49F4) == 0 && byte(0xB95704) != 0 && byte(0xB95704) <= 11 &&
    ((byte(0xB95704) == 1) ||
     (byte(0xB95704) == 2) ||
     (byte(0xB95704) == 12) ||
     (byte(0xB95704) == 10)), "{0} | The Fated 🕑 {1} | Current 🕑 {2}{3}:{4}{5} | Completion: {6}%",
    rich_presence_lookup("Chapter", byte(0xB95704), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA12B0), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA12B0)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA12B4), PresentTimeMinutes_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA12B4)),
    rich_presence_value("Number", byte(0xAA1152))
)

rich_presence_conditional_display(dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 &&
    dword(0xAC49F4) == 0 && byte(0xB95704) != 0 && byte(0xB95704) <= 11 &&
    ((byte(0xB95704) == 3) ||
     (byte(0xB95704) == 4) ||
     (byte(0xB95704) == 5) ||
     (byte(0xB95704) == 6) ||
     (byte(0xB95704) == 7) ||
     (byte(0xB95704) == 8) ||
     (byte(0xB95704) == 11) ||
     (byte(0xB95704) == 9)), "{0} {1} | The Fated 🕑 {2} | Current 🕑 {3}{4}:{5}{6} | Completion: {7}%",
    rich_presence_lookup("Chapter", byte(0xB95704), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("TimePeriod", dword(0xAA1268), TimePeriodLookup),
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA12B0), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA12B0)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA12B4), PresentTimeMinutes_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA12B4)),
    rich_presence_value("Number", byte(0xAA1152))
)

rich_presence_conditional_display(dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
    ((low4(0xA9EDDC) == 0) ||
     (dword(0xAC49F4) != 0)), "Title Screen | Completion {0}%",
    rich_presence_value("Number", byte(0xAA1152))
)

rich_presence_conditional_display(dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57, "Wandering Lebensbaum | Completion {0}%",
    rich_presence_value("Number", byte(0xAA1152))
)

rich_presence_conditional_display(dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 &&
    bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 && bit0(0xAA8CA6) == 1 && bit0(0xAA8CA5) == 1 &&
    bit0(0xAA8CA4) == 1 && dword(0xACC534) == 0 && byte(0xB9D284) == 1, "Ending the cycle | The Fated 🕑 {0} | Current 🕑 {1}:{2} | Completion: {3}%",
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA8E00), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA8E00)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA8E04), PresentTimeMinutes_ZeroPaddingLookup, fallback="0")
)

rich_presence_conditional_display(dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 &&
    bit7(0xAA68E8) == 0 && dword(0xACC534) == 0 && byte(0xB9D284) != 0 && byte(0xB9D284) <= 11 &&
    ((byte(0xB9D284) == 1) ||
     (byte(0xB9D284) == 2) ||
     (byte(0xB9D284) == 12) ||
     (byte(0xB9D284) == 10)), "{0} | The Fated 🕑 {1} | Current 🕑 {2}{3}:{4}{5} | Completion: {6}%",
    rich_presence_lookup("Chapter", byte(0xB9D284), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA8E00), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA8E00)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA8E04), PresentTimeMinutes_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA8E04)),
    rich_presence_value("Number", byte(0xAA8CA2))
)

rich_presence_conditional_display(dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 &&
    dword(0xACC534) == 0 && byte(0xB9D284) != 0 && byte(0xB9D284) <= 11 &&
    ((byte(0xB9D284) == 3) ||
     (byte(0xB9D284) == 4) ||
     (byte(0xB9D284) == 5) ||
     (byte(0xB9D284) == 6) ||
     (byte(0xB9D284) == 7) ||
     (byte(0xB9D284) == 8) ||
     (byte(0xB9D284) == 11) ||
     (byte(0xB9D284) == 9)), "{0} {1} | The Fated 🕑 {2} | Current 🕑 {3}{4}:{5}{6} | Completion: {7}%",
    rich_presence_lookup("Chapter", byte(0xB9D284), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("TimePeriod", dword(0xAA8DB8), TimePeriodLookup),
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_lookup("PresentTimeHours_ZeroPadding", dword(0xAA8E00), PresentTimeHours_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA8E00)),
    rich_presence_lookup("PresentTimeMinutes_ZeroPadding", dword(0xAA8E04), PresentTimeMinutes_ZeroPaddingLookup, fallback="0"),
    rich_presence_value("Number", dword(0xAA8E04)),
    rich_presence_value("Number", byte(0xAA8CA2))
)

rich_presence_conditional_display(dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
    ((low4(0xAA692C) == 0) ||
     (dword(0xACC534) != 0)), "Title Screen | Completion {0}%",
    rich_presence_value("Number", byte(0xAA8CA2))
)

rich_presence_conditional_display(dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50, "Wandering Lebensbaum | Completion {0}%",
    rich_presence_value("Number", byte(0xAA8CA2))
)

rich_presence_display("Wandering Lebensbaum")
