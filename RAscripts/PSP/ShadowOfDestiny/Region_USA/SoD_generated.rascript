// Shadow of Destiny
// #ID = 3945

// $000000: [INFO] Link to RAscript + Achievement Guide (github)
//          '''''''''''''''''''''''''''''''''''''''
//          - https://github.com/QuentinBultinck/RetroAchievements/tree/main/RAscripts/PSP/ShadowOfDestiny
// $8FBEF0: [NTSC-J][25-bit Pointer] Video data (intro and credits)
//          - Explanation @ 0x8ffef0
// $8FFEF0: [NTSC-U/C][25-bit Pointer] Video data (intro and credits)
//          +0x18 - [32-bit Flag] 0x101 => video is active
//          +0x2c - [32-bit Flag] 0x41 => video is active
//          +0x40 - [32-bit] Video timer
// $A442EC: [NTSC-U/C][36-byte Array]
//          //=====§ List of 9 Pointers to EnergyOrbs_Data_Objects §=====\\
//          [Struct Definition][12-byte] EnergyOrbs_Data_Object
//          | ''''''''''''''''''''''''''''''''''''''''''
//          | +0x0 - [8-bit] Amount of Energy Orbs in the Area
//          | +0x4 - [8-byte Array] List of 8-bit Flags => Is Energy Orb Collected
//          
//          [25-bit Pointer] Energy Orbs - Present - City
//          +0x4 - [Bit Flag] bit 0 => Orb - Outside Fortune Teller
//          +0x5 - [Bit Flag] bit 0 => Orb - Alley Way Between Haup Street & Neuwand Street
//          +0x6 - [Bit Flag] bit 0 => Orb - South Gate
//          +0x7 - [Bit Flag] bit 0 => Orb - Under Arch Ruckagrat Street
//          +0x8 - [Bit Flag] bit 0 => Orb - Car Park
// $A442F0: [25-bit Pointer] Energy Orbs - Late 20th Century - City
//          +0x4 - [Bit Flag] bit 0 => Orb - Gate North of Bar
//          +0x5 - [Bit Flag] bit 0 => Orb - Cafe Sonne Well
//          +0x6 - [Bit Flag] bit 0 => Orb - Haupt Street
//          +0x7 - [Bit Flag] bit 0 => Orb - Rudolf Street Stairs
//          +0x8 - [Bit Flag] bit 0 => Orb - Alley Way Behind Bakery
// $A442F4: [25-bit Pointer] Energy Orbs - Early 20th Century - City
//          +0x4 - [Bit Flag] bit 0 => Orb - Tree Near Bar
//          +0x5 - [Bit Flag] bit 0 => Orb - Stairs Opposite Cafe Sonne
//          +0x6 - [Bit Flag] bit 0 => Orb - Near News Post
//          +0x7 - [Bit Flag] bit 0 => Orb - Rudolf Street Park
//          +0x8 - [Bit Flag] bit 0 => Orb - North East Gate
// $A442F8: [25-bit Pointer] Energy Orbs - Middle Ages - City
//          +0x4 - [Bit Flag] bit 0 => Orb - North East On Bench
//          +0x5 - [Bit Flag] bit 0 => Orb - West Near Well
//          +0x6 - [Bit Flag] bit 0 => Orb - Alley Way Behind Atelier Franssen
//          +0x7 - [Bit Flag] bit 0 => Orb - East Near Hay
//          +0x8 - [Bit Flag] bit 0 => Orb - Outside Church
// $A44300: [25-bit Pointer] Energy Orbs - Middle Ages
//          +0x4 - [Bit Flag] bit 0 => Orb - Exploded Alchemy Lab
// $A44304: [25-bit Pointer] Energy Orbs - Early 20th Century
//          +0x4 - [Bit Flag] bit 0 => Orb - Inside Brum Mansion
// $A4430C: [25-bit Pointer] Energy Orbs - Middle Ages
//          +0x4 - [Bit Flag] bit 0 => Orb - Inside Church
//          \\=========================================//
// $A450BC: [NTSC-J][36-byte Array] List of 9 Pointers to EnergyOrbs_Data_Objects
//          - Identical to 0xa442ec
//          
//          [NTSC-J][25-bit Pointer] Energy Orbs - Present - City
// $A450C0: [NTSC-J][25-bit Pointer] Energy Orbs - Late 20th Century - City
// $A450C4: [NTSC-J][25-bit Pointer] Energy Orbs - Early 20th Century - City
// $A450C8: [NTSC-J][25-bit Pointer] Energy Orbs - Middle Ages - City
// $A450D0: [NTSC-J][25-bit Pointer] Energy Orbs - Middle Ages
//          +0x4 - [Bit Flag] bit 0 => Orb - Exploded Alchemy Lab
// $A450D4: [NTSC-J][25-bit Pointer] Energy Orbs - Early 20th Century
//          +0x4 - [Bit Flag] bit 0 => Orb - Inside Brum Mansion
// $A450DC: [NTSC-J][25-bit Pointer] Energy Orbs - Middle Ages
//          +0x4 - [Bit Flag] bit 0 => Orb - Inside Church
// $A5AB44: [NTSC-U/C][9-byte ASCII Text] Release Region ID
//          - ASCII Text = ULUS10459 --> PSP game identification code for region NTSC-U
// $A64C74: [NTSC-J][9-byte ASCII Text] Release Region ID
//          - ASCII Text = ULJM05512 --> PSP game identification code for region NTSC-J
// $A82E2C: [NTSC-U/C][Bit Flag] bit 0 => Is Chapter Completion Menu Displayed || Is Loading
//          - bit 0 = 1 => when chapter complete screen is displayed, when the ending video credits + ending file are played, when loading (+during time travel)
//          - bit 0 = 0 => when in-game AND nothing is loading
// $A82E48: [NTSC-U/C][32-bit] Area Identification
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
//          0x3 => Present_City_NightAM
//          0x31d => 70s_City_Night
//          0x32 => Present_BrumMuseum_Downstairs_Room_Night
//          0x33c => MiddleAges_City_Night
//          0x375 => Present_City_Day
//          0x38 => Present_BrumMuseum_Upstairs_Room1_Day
//          0x3f3 => MiddleAges_City_Day
//          0x44 => Present_City_NightPM
//          0x465 => 80s_City_Snow
//          0x603 => 1900s_BrumMansion
//          0x6f => Present_AntiquesEule
//          0x7a => 80s_AntiquesEule
//          0x8e => MiddleAges_Church
//          0xcd => Present_BrumMuseum_Upstairs_Room3_Day
//          0xf => 80s_Bar
// $A8A97C: [NTSC-J][Bit Flag] bit 0 => Is Chapter Completion Menu Displayed || Is Loading
//          - Explanation @ 0xa82e2c
// $A8A998: [NTSC-J][32-bit] Area Identification
//          - Explanation @ 0xa82e48
// $A9DAA8: [NTSC-U/C][8-bit] Energy Units (functional)
//          - This is the internal/functional value, if this is 0x0 => player can't time-travel
//          - Values range [0x0-0xa]
// $A9ECBC: [NTSC-U/C][124-byte]
//          //===========§ Cutscene Data §===========\\
//          
//          [32-bit] Cutscene Master ID
//          - Identifies a cutscene sequence
// $A9ECC0: [16-bit] Cutscene Section ID_1
//          - Identifies a section from the current cutscene
// $A9ECC2: [16-bit] Cutscene Section ID_2
// $A9ECC8: [25-bit Pointer] Cutscene Identification - Master Data
//          +0x0 - Refers to start of dynamic cutscene memory data block - Data higher than this hex address changes on new cutscene loaded in
//          +0x8 - [32-bit] Cutscene Master Data ID
// $A9ECCC: [25-bit Pointer] Cutscene Identification - Section Data
//          +0x0 - Data lower than this hex address changes when the next section in the cutscene starts
//          +0x8 - [32-bit] Cutscene Section Data ID
// $A9ECD4: [25-bit Pointer] Cutscene Identification - Minor IDs
//          - Pointer active when a cutscene is active
//          +0x0 - Data lower than this point can be used as Minor Cutscene IDs
//          +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID
// $A9ED26: [8-bit Flag] Is Cutscene Active (preferred)
//          0x0 => no cutscene active
//          0x1 => Small cutscene active (without fancy camera work) || transitional value between active-inactive state
//          ... => transitional values
//          0x5 => Large cutscene active
// $A9ED3C: [NTSC-U/C][57-bytes Bitset]
//          //=======§ Achievement Percentage Flags §=======\\
//          - Each flag corresponds to 1 cutscene and counts toward the achievement percentage
//          - At end of a cutscene one of these flags will become true
//          - Flags are grouped per chapter
//          - These flags are loaded when loading a save OR when starting a new game whilst having played the game before
//          
//          - Flags further than 57-bytes do not count toward achievement percentage
//          - Some side content/cutscenes do not have any corresponding flags which count toward the achievement percentage
//          
//          [NTSC-U/C][7-bytes - Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
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
// $A9ED43: [NTSC-U/C][4-bytes - Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 6-7 => 8+%
// $A9ED44: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
// $A9ED45: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
// $A9ED46: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 0-5 => 25+%
// $A9ED47: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 3-7 => 13+%
// $A9ED48: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED49: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED4A: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
// $A9ED4B: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 0-6 => 19+%
// $A9ED4D: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 1-7 => 19+%
// $A9ED4E: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED4F: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED50: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
// $A9ED51: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 0-4 => 13+%
// $A9ED52: [NTSC-U/C][6-bytes - Bit Flags] Achievement Percentage Flags - Chapter 5
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
// $A9ED58: [NTSC-U/C][3-bytes - Bit Flags] Achievement Percentage Flags - Chapter 3
//          bits 2-7 => 27+%
// $A9ED59: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
// $A9ED5A: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
// $A9ED5B: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 2-7 => 17+%
// $A9ED5C: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5D: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5E: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
// $A9ED5F: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 0-4 => 14+%
// $A9ED60: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 2-7 => 17+%
// $A9ED61: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED62: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED63: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
// $A9ED64: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 0-3 => 11+%
// $A9ED65: [NTSC-U/C][10-bytes - Bit Flags] Achievement Percentage Flags - Chapter 8
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
// $A9ED71: [NTSC-U/C][4-bytes - Bit Flags] Achievement Percentage Flags - Epilogue
//          bits 2-7 => 26+%
// $A9ED72: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
// $A9ED73: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
// $A9ED74: [Bit Flags] Achievement Percentage Flags - Epilogue
//          bit 0 => 4+%
//          \\========================================//
// $A9ED98: [Bit Flags] Current Playthrough - EX Chapter
//          bit 7 => is prologue in EX mode - Actually a bitflag for 2nd dialogue option at start of game when all other endings have been achieved: "Oh, Homunculus", which activates EX chapter
// $A9ED9D: [Bit Flags] Current Playthrough - Chapter 1
//          bit 5 => put out fire yourself
//          bit 7 => Saved bar from fire by warning barman
// $A9EDA0: [Bit Flags] Current Playthrough - Chapter 2
//          bit 0 => acquired ladder
//          bit 1 = 0 => LIGHTER used to scare crowd
//          bit 1 = 1 => TELEPHONE used
//          bit 2 = 0 => Chosen to plant STATUE instead of flowers
//          bit 2 = 1 => Chosen to plant FLOWERS instead of statue
// $A9EDA5: [Bit Flags] Current Playthrough - Chapter 4
//          bit 2 => is wearing performer outfit
//          bit 3 => died once without using an iron plate
// $A9EDAA: [Bit Flags] Current Playthrough - Brum Estate Choice
//          bit 5 = 0 => Brum Estate is museum
//          bit 5 = 1 => Brum Estate is library
// $A9EDAE: [Bit Flags] Current Playthrough - Ancestor Choice - Chapter 5
//          bit 6 => Margarette is ancestor, sets after leaving alchemist house (refer to 0xa9edad)
//          bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house (refer to 0xa9edad)
// $A9EDB0: [Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen
//          bit 7 => Antidote painting
//          bit 6 => Marktplatz painting (insinuating removing the tree)
//          bit 5 => Squire's crest painting
//          bit 4 => Tower view painting (downstairs)
// $A9EDB1: [Bit Flags] Current Playthrough - Inspired Karl Franssen's Art
//          bit 0 => Performer painting (only possible when player became performer in chapter 4)
//          bit 1 => Achemist house collapse painting
// $A9EDB7: [Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 5 => Movie choice 1: Meditating Man
//          bit 6 => Movie choice 1: Time Travel
//          bit 7 => Movie choice 2: Take over the world
// $A9EDB8: [Bit Flags] Current Playthrough - Movie Choice - Chapter 6
//          bit 0 => Movie Choice 2: Find cause of own death
//          bit 1 => Movie Choice 3: Thriller story
//          bit 2 => Movie Choice 3: Love story
// $A9EDC4: [Bit Flags] Current Playthrough - Saved Dana from Past
//          bit 1 => Gave letter to Dana
//          bit 3-4 => Took Dana back to present
// $A9EDCB: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 2 => talked with Oleg 1st time in Chapter 3
//          bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
//          bit 6 => gave kitten to Sibylla
// $A9EDCC: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch
//          \\========================================//
// $A9EDDC: [NTSC-U/C][Lower4 Flag] Is In-Game
//          Lower4 = 0 => at title screen
//          Lower4 > 0 => in-game
// $A9EE1D: [8-bit] NPC Talk Count - Coated man - Present - Chapter 1/Prologue - Town Square
// $A9EE20: [8-bit] NPC Talk Count - Coated man- Present - Chapter 3 - Near Antique Shop
// $A9EE21: [8-bit] NPC Talk Count - Coated man - Present - Chapter 4 - Haup str. under arch
// $A9EE24: [8-bit] NPC Talk Count - Coated man - Present - Chapter 7 - North West Gate
// $A9EE25: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Library
// $A9EE26: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Museum
// $A9EE28: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 1/Prologue - Town Square
// $A9EE2C: [8-bit] NPC Talk Count - Coated woman - Present - Chapter3 - Outside antique shop
// $A9EE2F: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 7 - South Gate
// $A9EE31: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne
// $A9EE36: [8-bit] NPC Talk Count - Straw Hat Man - Middle Ages - Chapter 2 - Streets
//          - When scaring with lighter or cellphone
// $A9EE3F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
// $A9EE49: [8-bit] NPC Talk Count - Barman - Cold Days 1980 - any chapter - inside bar
// $A9EE4C: [8-bit] NPC Talk Count -  Broad delinquent - Present - Chapter 7 - Car Park
// $A9EE51: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
// $A9EE70: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
//          - When frightening with lighter or cellphone
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
//          \\========================================//
// $A9EFDC: [NTSC-U/C][25-bit Pointer] --> NPC Interaction ID
//          +0x0 - [NTSC-U/C][32-bit] NPC ID
//          | - This value changes when interacting with something
//          | - Unique per interactable NPC or interactable item
//          | - This value is copied to 0xa9eff4 (refer to notes)
// $A9EFE0: [NTSC-U/C][25-bit Pointer] --> Interaction Chapter ID
//          +0x0 - [32-bit] Interaction Chapter ID
//          | - This is a value which is active during an interaction
//          | - Interactions in the same chapter, have the same value; Interactions in different chapters have differing values
// $A9EFE4: [NTSC-U/C][25-bit Pointer] --> Interaction ID
//          - Pointer resets to 0x0 when interaction is done
//          
//          +0x0 - [32-bit] Interaction ID
//          | - Each interaction has a unique ID
// $A9F034: [NTSC-U/C][29-byte Array]
//          //=======§ List of Inventory_Item_Objects §=======\\
//          [Struct Defintion][8-bit] Inventory_Item_Object
//          |''''''''''''''''''''''''''''''''''"""""""
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
// $A9F111: [NTSC-U/C][8-bit] Highlighted Inventory Item
//          - Currently only the IDs which are used in achievement logic are documented in this list
//          - ID corresponds to the index of the Inventory_Item_Object in the list described @ 0xa9f034
//          
//          ID list
//          '''''''
//          0x0 = d-pad/z-pad
//          0x1 = cellphone
//          0x2 = ornamental egg
//          0x3 --> empty entry
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
// $AA1152: [8-bit] Achievement Percentage: Total
//          \\=============================================//
// $AA1154: [NTSC-U/C][7-bytes]
//          //===========§ Ending Data §===========\\
//          - Flags will make the corresponding ending file viewable in the extra menu
//          - Once one of these is achieved, it will unlock the extra menu at the title screen
//          
//          [Bit Flag] bit 0 => Ending A unlocked
// $AA1155: [Bit Flag] bit 0 => Ending B unlocked
// $AA1156: [Bit Flag] bit 0 => Ending C unlocked
// $AA1157: [Bit Flag] bit 0 => Ending D unlocked
// $AA1158: [Bit Flag] bit 0 => Ending E unlocked
// $AA1159: [Bit Flag] bit 0 => Ending EX unlocked
// $AA1268: [NTSC-U/C][32-bit] Time Period
//          - This value can be a little unstable (certain small areas, might have undocumented values)
//          0x80 => Middle ages 1500s
//          0x81 => Late 20th Century 1900s
//          0x82 => Early 20th Century 1980
//          0x88 => Early 20th Century 1979
//          0x83 => Present 2000s
// $AA12A4: [NTSC-U/C][672-byte Array]
//          //==========§ List of DateTime_Objects §==========\\
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
// $AA12AC: [32-bit] Present - day
// $AA12B0: [32-bit] Present - hours
// $AA12B4: [32-bit] Present - minutes
// $AA155C: [NTSC-U/C][32-bit] Current Playthrough Timer - Chapter Clear Time
//          - Time in seconds = [32-bit] decimal value / 60
//          - Time in minutes = [32-bit] decimal value / 3600
//          - Value range [0x0-0x57e3f] = [00-99h:59m:59s]; Halts at max (value does not wrap back around to 0)
//          - Restarts counting from 0 on new chapter start
//          - Timer stops when credits video starts playing
//          - Timer does not pause when the inventory is open OR when a cutscene is active
//          - Timer pauses in pause menu or when loading
// $AA1560: [NTSC-U/C][32-bit] Current Playthrough Timer - Total Clear Time
//          - Explanation @ 0xaa155c
// $AA55F8: [NTSC-J][8-bit] Energy Units (functional)
//          - Explanation @ 0xa9daa8
// $AA680C: [NTSC-J][124-byte]
//          //==========§ Cutscene Data §==========\\
//          - Explanation @ 0xa9ecbc
//          
//          [NTSC-J][32-bit] Cutscene Master ID
// $AA6810: [NTSC-J][16-bit] Cutscene Section ID_1
// $AA6812: [NTSC-J][16-bit] Cutscene Section ID_2
// $AA6818: [NTSC-J][25-bit Pointer] Cutscene Identification - Master Data
//          - Explanation @ 0xa9ecc8
// $AA681C: [NTSC-J][25-bit Pointer] Cutscene Identification - Section Data
//          - Explanation @ 0xa9eccc
// $AA6824: [NTSC-J][25-bit Pointer] Cutscene Identification - Minor IDs
//          - Explanation @ 0xa9ecd4
// $AA6876: [NTSC-J][8-bit Flag] Is Cutscene Active (preferred)
//          - Explanation @ 0xa9ed26
// $AA688C: [NTSC-J][57-bytes Bitset]
//          //========= § Achievement Percentage Flags §=========\\
//          - Explanation @ 0xa9ed3c
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
//          \\==========================================//
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
// $AA6914: [Bit Flags] Current Playthrough - Saved Dana from Past
//          bit 1 => Gave letter to Dana
//          bit 3-4 => Took Dana back to present
// $AA691B: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 2 => talked with Oleg 1st time in Chapter 3
//          bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
//          bit 6 => gave kitten to Sibylla
// $AA691C: [Bit Flags] Current Playthrough - Multi-chapter
//          bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch
//          \\========================================//
// $AA692C: [NTSC-J][Lower4 Flag] Is In-Game
//          - Explanation @ 0xa9eddc
// $AA696D: [8-bit] NPC Talk Count - Coated man - Present - Chapter 1/Prologue - Town Square
// $AA6970: [8-bit] NPC Talk Count - Coated man- Present - Chapter 3 - Near Antique Shop
// $AA6971: [8-bit] NPC Talk Count - Coated man - Present - Chapter 4 - Haup str. under arch
// $AA6974: [8-bit] NPC Talk Count - Coated man - Present - Chapter 7 - North West Gate
// $AA6975: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Library
// $AA6976: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Museum
// $AA6978: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 1/Prologue - Town Square
// $AA697C: [8-bit] NPC Talk Count - Coated woman - Present - Chapter3 - Outside antique shop
// $AA697F: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 7 - South Gate
// $AA6981: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne
// $AA6986: [8-bit] NPC Talk Count - Straw Hat Man - Middle Ages - Chapter 2 - Streets
//          - When scaring with lighter or cellphone
// $AA698F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
// $AA6999: [8-bit] NPC Talk Count - Barman - Cold Days 1980 - any chapter - inside bar
// $AA699C: [8-bit] NPC Talk Count - Broad delinquent - Present - Chapter 7 - Car Park
// $AA69A1: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
// $AA69C0: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square
//          - When frightening with lighter or cellphone
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
//          - Explanation @ 0xa9ef85
// $AA6AD9: [8-bit] State Of Young Couple Side Quest - Chapter 2
//          - Explanation @ 0xa9ef89
// $AA6ADA: [8-bit] State Of Young Couple Side Quest - Chapter 3
//          - Explanation @ 0xa9ef8a
// $AA6ADB: [8-bit] State Of Young Couple Side Quest - Chapter 4
//          - Explanation @ 0xa9ef8b
// $AA6ADE: [8-bit] State Of Young Couple Side Quest - Chapter 7
//          - Explanation @ 0xa9ef8e
// $AA6ADF: [8-bit] State Of Young Couple Side Quest - Chapter 8
//          - Explanation @ 0xa9ef8f
//          \\==============================================//
// $AA6B2C: [NTSC-J][25-bit Pointer] --> NPC Interaction ID
//          - Explanation @ 0xa9efdc
// $AA6B30: [NTSC-J][25-bit Pointer] --> Interaction Chapter ID
//          - Explanation @ 0xa9efe0
// $AA6B34: [NTSC-J][25-bit Pointer] --> Interaction ID
//          - Explanation @ 0xa9efe4
// $AA6B84: [NTSC-J][29-byte Array]
//          //===========§ List of Inventory_Item_Objects §===========\\
//          - Explanation @ 0xa9f034
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
//          \\========================================//
// $AA6C61: [NTSC-J][8-bit] Highlighted Inventory Item
//          - Explanation @ 0xa9f111
// $AA8CA2: [NTSC-J][8-bit] Achievement Percentage: Total
// $AA8CA4: [NTSC-J][7-bytes] Ending Data
//          - Explanation @ 0xaa1154
// $AA8DB8: [NTSC-J][32-bit] Time Period
//          - Explanation @ 0xaa1268
// $AA8DF4: [NTSC-J][672-byte Array] List of DateTime_Objects
//          - Explanation @  0xaa12a4
// $AA90AC: [NTSC-J][32-bit] Current Playthrough Timer - Chapter Clear Time
//          - Explanation @ 0xaa155c
// $AA90B0: [NTSC-J][32-bit] Current Playthrough Timer - Total Clear Time
//          - Explanation @ 0xaa1560
// $AC49F4: [NTSC-U/C][32-bit] Extra Menu State
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
// $ACC534: [NTSC-J][32-bit] Extra Menu State
//          - Explanation @ 0xac49f4
// $B95704: [NTSC-U/C][8-bit] Chapter ID
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
// $B9D284: [NTSC-J][8-bit] Chapter ID
//          - Explanation @ 0xb95704
// $1FFF5F4: [NTSC-U/C][NTSC-J][32-bit Flag] Is Chapter Complete Screen Active
//           0x21 => chapter completion screen OR in-game pause menu is active
// $1FFF5F8: [NTSC-U/C][NTSC-J][32-bit] Menu ID
//           - 0x1 => chapter completed screen OR in-game pause menu
//           - 0x3 => extra menu
//           - 0x11 => title screen
//           - 0x114 => options menu
//           - any other value => other menu OR something else on screen

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
    1: "14h30",
    2: "15h00",
    3: "15h30",
    4: "17h50",
    5: "20h30",
    6: "22h30",
    7: "23h55",
    8: "01h30",
    9: "04h30",
    10: "04h30",
    11: "04h30",
    12: "04h30",
}

TimePeriodLookup = {
    128: "in the Middle Ages",
    129: "in the early 20th century",
    130: "in the late 20th century",
    131: "in the present",
    136: "in the late 20th century",
}

achievement(
    title = "Defied Fate", points = 5, type="progression",
    description = "Complete the Prologue",
    id = 306884, badge = "461667", published = "5/04/2023 15:44:04", modified = "5/04/2024 18:13:16",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 1) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 140416 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 113872 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 3600
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 592832 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 110192 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 482576
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 1 && byte(0xB95704) == 2) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 1) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 140416 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 113872 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 3600
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 592832 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 110192 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 482576
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 1 && byte(0xB9D284) == 2))
)

achievement(
    title = "That's A Big No No", points = 2, type="missable",
    description = "Warn yourself of your impending demise during the Prologue",
    id = 306883, badge = "465973", published = "5/04/2023 15:44:04", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 39936 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 39920 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 39920 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 39920 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 60016
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 39936 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 100656 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44640
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 39936 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 39920 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 39920 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 39920 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 60016
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 145344 && prior(dword(0xAA680C)) == 39936 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 100656 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 44640
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Defied Fate... Again", points = 5, type="progression",
    description = "Complete Chapter 1",
    id = 306886, badge = "465974", published = "5/04/2023 15:44:05", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 2 && dword(0xA9ECBC) == 72256 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 48800 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 23424
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 2 && byte(0xB95704) == 3) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 2 && dword(0xAA680C) == 72256 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 2 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 48800 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 23424
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 2 && byte(0xB9D284) == 3))
)

achievement(
    title = "A Performer's Clue", points = 2, type="missable",
    description = "Receive a gift from an entertainer in Chapter 1",
    id = 306885, badge = "465975", published = "5/04/2023 15:44:04", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 2) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 103296 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54768 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 3600
                ) && trigger_when(bit0(0xA9F036) == 1) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 2) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 103296 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 54768 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 3600
                ) && trigger_when(bit0(0xAA6B86) == 1) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "There's A Fire!", points = 3, type="missable",
    description = "Notify the young boy's grandpa of an approaching threat during Chapter 1",
    id = 306976, badge = "465976", published = "6/04/2023 11:45:22", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 2) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 && dword(0xA9ECBC) == 205312 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 28896 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 150704
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 2) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B86) == 1 && dword(0xAA680C) == 205312 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 28896 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 150704
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Jovial Exchange", points = 3, type="missable",
    description = "Exchange an egg for a pan during Chapter 1, 3 or 4",
    id = 306977, badge = "465977", published = "6/04/2023 11:45:22", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never((byte(0xB95704) != 2 && byte(0xB95704) != 4 && byte(0xB95704) != 5)) &&
                tally(1,
                    once((byte(0xB95704) == 2 || byte(0xB95704) == 5) && byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 &&
                    dword(0xA9ECBC) == 195008 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 22976 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 23584),
                    once(byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 && byte(0xB95704) == 4 && dword(0xA9ECBC) == 205312 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 22976 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 23584)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never((byte(0xB9D284) != 2 && byte(0xB9D284) != 4 && byte(0xB9D284) != 5)) &&
                tally(1,
                    once((byte(0xB9D284) == 2 || byte(0xB9D284) == 5) && byte(0xAA6876) == 5 && bit0(0xAA6B86) == 1 &&
                    dword(0xAA680C) == 195008 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 22976 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 23584),
                    once(byte(0xAA6876) == 5 && bit0(0xAA6B86) == 1 && byte(0xB9D284) == 4 && dword(0xAA680C) == 205312 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 22976 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 23584)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Enigmatic Couple I: Prelude", points = 3, type="missable",
    description = "Identify the coated man and woman in the modern-day setting during the Prologue or Chapter 1",
    id = 307495, badge = "465978", published = "9/04/2023 8:08:50", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never((byte(0xB95704) != 1 && byte(0xB95704) != 2)) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE28) > prev(byte(0xA9EE28)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 716), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE1D) > prev(byte(0xA9EE1D)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 705)),
                    when=dword(0xA82E48) == 885
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never((byte(0xB9D284) != 1 && byte(0xB9D284) != 2)) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA6978) > prev(byte(0xAA6978)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 716), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA696D) > prev(byte(0xAA696D)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 705)),
                    when=dword(0xA8A998) == 885
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Enigmatic Couple II: Tailing", points = 3, type="missable",
    description = "Discover the coated man and woman in the contemporary setting within Chapter 3",
    id = 310131, badge = "465979", published = "19/04/2023 11:41:41", modified = "5/04/2024 18:13:17",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE20) > prev(byte(0xA9EE20)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708)),
                    when=dword(0xA82E48) == 885
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE20) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708)), when=dword(0xA82E48) == 885
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA697C) > prev(byte(0xAA697C)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6970) > prev(byte(0xAA6970)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 708)),
                    when=dword(0xA8A998) == 885
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 4) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA697C) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && byte(0xAA6970) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 708)), when=dword(0xA8A998) == 885
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Enigmatic Couple III: Wandering Once More", points = 3, type="missable",
    description = "Seek out the coated man and woman in the present during Chapter 4",
    id = 310134, badge = "465980", published = "19/04/2023 12:50:26", modified = "5/04/2024 18:13:22",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE21) > prev(byte(0xA9EE21)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709)),
                    when=dword(0xA82E48) == 885
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE21) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709)), when=dword(0xA82E48) == 885
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA697C) > prev(byte(0xAA697C)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6971) > prev(byte(0xAA6971)) && dword(dword(0xAA6B34) & 0x1FFFFFF) == 709)),
                    when=dword(0xA8A998) == 885
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 5) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA697C) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && byte(0xAA6971) == 2 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 709)), when=dword(0xA8A998) == 885
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Enigmatic Couple IV: Origins", points = 3, type="missable",
    description = "Encounter the coated man and woman in the current timeline during Chapter 5",
    id = 310135, badge = "465981", published = "19/04/2023 15:36:31", modified = "5/04/2024 18:13:22",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 6) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0) &&
                measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE31) > prev(byte(0xA9EE31)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 0 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE26) > prev(byte(0xA9EE26)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 714)), when=dword(0xA82E48) == 885
                )) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 6) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0) &&
                measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE31) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 0 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE26) == 2 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 714)), when=dword(0xA82E48) == 885
                )) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 6) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0) &&
                measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE31) > prev(byte(0xA9EE31)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE25) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 713)), when=dword(0xA82E48) == 885
                )) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 6) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
                trigger_when(byte(0xA9ED26) == 0) &&
                measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE31) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE25) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 713)), when=dword(0xA82E48) == 885
                )) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 6) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0) &&
                measured(tally(3,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA6981) > prev(byte(0xAA6981)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xAA6876) == 1 && bit5(0xAA68FA) == 0 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6976) > prev(byte(0xAA6976)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 714)), when=dword(0xA8A998) == 885
                )) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 6) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0) &&
                measured(tally(3,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA6981) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xAA6876) == 1 && bit5(0xAA68FA) == 0 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6976) == 2 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 714)), when=dword(0xA8A998) == 885
                )) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 6) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0) &&
                measured(tally(3,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA6981) > prev(byte(0xAA6981)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xAA6876) == 1 && bit5(0xAA68FA) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6975) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 713)), when=dword(0xA8A998) == 885
                )) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 6) && trigger_when(prev(byte(0xAA6876)) != 0) &&
                trigger_when(byte(0xAA6876) == 0) &&
                measured(tally(3,
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA6981) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xAA6876) == 1 && bit5(0xAA68FA) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6975) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 713)), when=dword(0xA8A998) == 885
                )))
)

achievement(
    title = "Enigmatic Couple V: Epilogue", points = 3, type="missable",
    description = "Find the coated man and woman in the present during Chapter 7",
    id = 315564, badge = "465982", published = "7/05/2023 18:08:32", modified = "5/04/2024 18:13:22",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(3, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2F) > prev(byte(0xA9EE2F)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 723),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE24) > prev(byte(0xA9EE24)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 712)), when=dword(0xA82E48) == 3
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(3, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2F) == 2 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 723),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE24) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 712)),
                    when=dword(0xA82E48) == 3
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(3, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 &&
                    byte(0xAA697F) > prev(byte(0xAA697F)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 723),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 &&
                    byte(0xAA6974) > prev(byte(0xAA6974)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 712)), when=dword(0xA8A998) == 3
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(3, repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 87 && byte(0xAA697F) == 2 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 723),
                    once(byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 86 && byte(0xAA6974) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 178 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 712)),
                    when=dword(0xA8A998) == 3
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Left In The Past", points = 5, type="progression",
    description = "Complete Chapter 2",
    id = 306922, badge = "465983", published = "5/04/2023 22:42:49", modified = "5/04/2024 18:13:22",
    trigger = always_true() &&
              ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 3 && byte(0xB95704) == 4) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 3 && byte(0xB9D284) == 4))
)

achievement(
    title = "Cracking Open The Past: Middle Ages", points = 3, type="missable",
    description = "Present the barman's ancestor with your egg collection in Chapter 2",
    id = 307023, badge = "468296", published = "6/04/2023 20:16:21", modified = "5/04/2024 18:13:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 2 && dword(0xA9ECBC) == 56832 && word(0xA9ECC0) == 3 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 10704 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 46080
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 2 && dword(0xAA680C) == 56832 && word(0xAA6810) == 3 &&
                    word(0xAA6812) == 2 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 10704 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 46080
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Terror Of Destinies", points = 3, type="missable",
    description = "Attempt to sow fear among numerous individuals within Chapter 2",
    id = 404046, badge = "465985", published = "2/03/2024 21:18:08", modified = "5/04/2024 18:13:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) && never(byte(0xB95704) != 3) &&
                measured(tally(9,
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 16 && byte(0xA9F111) == 1 && dword(0xA9ECBC) == 36864 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 36864), repeated(4,
                    byte(0xA9ED26) == 5 && dword(0xA82E48) == 828 && byte(0xA9F111) == 1 && dword(0xA9ECBC) == 814592 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 23248 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 21936 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2380192 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 21936), repeated(4,
                    byte(0xA9ED26) == 5 && dword(0xA82E48) == 828 && byte(0xA9F111) == 6 && dword(0xA9ECBC) == 689344 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 11840 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 45600 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2315504 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 45600),
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
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 739)), when=low4(0xA9EDDC) != 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) && never(byte(0xB9D284) != 3) &&
                measured(tally(9,
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 16 && byte(0xAA6C61) == 1 && dword(0xAA680C) == 36864 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 36864), repeated(4,
                    byte(0xAA6876) == 5 && dword(0xA8A998) == 828 && byte(0xAA6C61) == 1 && dword(0xAA680C) == 814592 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 23248 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 21936 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 2380192 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 21936), repeated(4,
                    byte(0xAA6876) == 5 && dword(0xA8A998) == 828 && byte(0xAA6C61) == 6 && dword(0xAA680C) == 689344 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 11840 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 45600 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 2315504 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 45600),
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
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 739)), when=low4(0xAA692C) != 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Met You Before", points = 2, type="missable",
    description = "Keep chatting with Dana under the Marktplatz tree during Chapter 2, even as whispers of fate gently caress the periphery of your dialogue",
    id = 306888, badge = "465986", published = "5/04/2023 18:19:09", modified = "5/04/2024 18:13:23",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 451712 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 283216 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 82928
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 112448 && prior(dword(0xA9ECBC)) == 451712 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 7424 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 104992
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 451712 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 283216 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 82928
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 112448 && prior(dword(0xAA680C)) == 451712 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 7424 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 104992
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Blossoming Plan", points = 1, type="missable",
    description = "Set up a floral display in Chapter 2",
    id = 306920, badge = "465987", published = "5/04/2023 22:23:23", modified = "5/04/2024 18:13:33",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(bit2(0xA9EDA0) == 1 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 242240 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(bit2(0xAA68F0) == 1 && byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 && dword(0xAA680C) == 242240 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Pyromancer's Legacy", points = 1, type="missable",
    description = "Ascend to reverence as a pyrokinetic in Chapter 2",
    id = 306911, badge = "465988", published = "5/04/2023 19:43:29", modified = "5/04/2024 18:13:26",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 0 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 &&
                    dword(0xA9ECBC) == 242240 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(bit2(0xAA68F0) == 0 && bit1(0xAA68F0) == 0 && byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 &&
                    dword(0xAA680C) == 242240 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Magician's Legacy", points = 1, type="missable",
    description = "Ascend to renown as a magician in Chapter 2",
    id = 306906, badge = "465989", published = "5/04/2023 19:28:48", modified = "5/04/2024 18:13:26",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 3) &&
                once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 1 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 &&
                    dword(0xA9ECBC) == 242240 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 3) &&
                once(bit2(0xAA68F0) == 0 && bit1(0xAA68F0) == 1 && byte(0xAA6876) == 5 && byte(0xAA6C61) == 0 &&
                    dword(0xAA680C) == 242240 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 28976
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Yesteryears Couple I: Destined To Miss", points = 3, type="missable",
    description = "Aid a bewildered young couple in their reunion amidst the medieval era within Chapter 2",
    id = 306984, badge = "465990", published = "6/04/2023 16:26:09", modified = "5/04/2024 18:13:26",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 3) &&
                measured(tally(6,
                    once((byte(0xA9EF89) == 0 || byte(0xA9EF89) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && prev(byte(0xA9EF7C)) == 0 && byte(0xA9EF7C) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1056),
                    once((byte(0xA9EF89) == 0 || byte(0xA9EF89) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && prev(byte(0xA9EF69)) == 0 && byte(0xA9EF69) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1037),
                    once((byte(0xA9EF89) == 1 || byte(0xA9EF89) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF7D) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1057),
                    once((byte(0xA9EF89) == 1 || byte(0xA9EF89) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6A) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1038),
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF89) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 &&
                    byte(0xA9EF7E) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1058),
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF89) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF6B) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1039)), when=dword(0xA82E48) == 828
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 3) &&
                measured(tally(6,
                    once((byte(0xAA6AD9) == 0 || byte(0xAA6AD9) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && prev(byte(0xAA6ACC)) == 0 && byte(0xAA6ACC) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1056),
                    once((byte(0xAA6AD9) == 0 || byte(0xAA6AD9) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && prev(byte(0xAA6AB9)) == 0 && byte(0xAA6AB9) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1037),
                    once((byte(0xAA6AD9) == 1 || byte(0xAA6AD9) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6ACD) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1057),
                    once((byte(0xAA6AD9) == 1 || byte(0xAA6AD9) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6ABA) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1038),
                    once(byte(0xAA6876) == 1 && byte(0xAA6AD9) == 3 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 &&
                    byte(0xAA6ACE) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1058),
                    once(byte(0xAA6876) == 1 && byte(0xAA6AD9) == 3 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6ABB) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1039)), when=dword(0xA8A998) == 828
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple II: The Place Where We Nigh Met", points = 3, type="missable",
    description = "Weave the threads of fate into another chance at reunion for a lost young couple in Chapter 3",
    id = 310133, badge = "465991", published = "19/04/2023 12:50:26", modified = "5/04/2024 18:13:26",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 4) &&
                measured(tally(6,
                    once(byte(0xA9EF8A) == 0 || byte(0xA9EF8A) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF7F) > prev(byte(0xA9EF7F) &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1059),
                    once(byte(0xA9EF8A) == 0 || byte(0xA9EF8A) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6C) > prev(byte(0xA9EF6C) &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1040),
                    once(byte(0xA9EF8A) == 1 || byte(0xA9EF8A) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF80) > prev(byte(0xA9EF80) &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1060),
                    once(byte(0xA9EF8A) == 1 || byte(0xA9EF8A) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6D) > prev(byte(0xA9EF6D) &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1041),
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF8A) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 &&
                    byte(0xA9EF81) > prev(byte(0xA9EF81)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1061),
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF8A) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF6E) > prev(byte(0xA9EF6E)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1042)), when=dword(0xA82E48) == 828
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 4) &&
                measured(tally(6,
                    once(byte(0xAA6ADA) == 0 || byte(0xAA6ADA) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6ACF) > prev(byte(0xAA6ACF) &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1059),
                    once(byte(0xAA6ADA) == 0 || byte(0xAA6ADA) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6ABC) > prev(byte(0xAA6ABC) &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1040),
                    once(byte(0xAA6ADA) == 1 || byte(0xAA6ADA) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD0) > prev(byte(0xAA6AD0) &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1060),
                    once(byte(0xAA6ADA) == 1 || byte(0xAA6ADA) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6ABD) > prev(byte(0xAA6ABD) &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1041),
                    once(byte(0xAA6876) == 1 && byte(0xAA6ADA) == 3 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 &&
                    byte(0xAA6AD1) > prev(byte(0xAA6AD1)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1061),
                    once(byte(0xAA6876) == 1 && byte(0xAA6ADA) == 3 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6ABE) > prev(byte(0xAA6ABE)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1042)), when=dword(0xA8A998) == 828
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple III: Destiny's Promise Fulfilled", points = 3, type="missable",
    description = "Successfully orchestrate the reunion of the lost young couple in the Middle Ages during Chapter 4",
    id = 309393, badge = "465992", published = "17/04/2023 19:03:08", modified = "5/04/2024 18:13:26",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 5) &&
                measured(tally(6,
                    once((byte(0xA9EF8B) == 0 || byte(0xA9EF8B) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF82) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1062),
                    once((byte(0xA9EF8B) == 0 || byte(0xA9EF8B) == 1) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6F) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1043),
                    once((byte(0xA9EF8B) == 1 || byte(0xA9EF8B) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF83) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1063),
                    once((byte(0xA9EF8B) == 1 || byte(0xA9EF8B) == 2) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF70) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1044),
                    once((byte(0xA9EF8B) == 2 || byte(0xA9EF8B) == 3) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF84) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1064),
                    once((byte(0xA9EF8B) == 2 || byte(0xA9EF8B) == 3) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF71) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1045)),
                    when=dword(0xA82E48) == 828
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 5) &&
                measured(tally(6,
                    once((byte(0xAA6ADB) == 0 || byte(0xAA6ADB) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD2) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1062),
                    once((byte(0xAA6ADB) == 0 || byte(0xAA6ADB) == 1) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6ABF) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1043),
                    once((byte(0xAA6ADB) == 1 || byte(0xAA6ADB) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD3) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1063),
                    once((byte(0xAA6ADB) == 1 || byte(0xAA6ADB) == 2) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6AC0) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1044),
                    once((byte(0xAA6ADB) == 2 || byte(0xAA6ADB) == 3) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD4) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1064),
                    once((byte(0xAA6ADB) == 2 || byte(0xAA6ADB) == 3) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && byte(0xAA6AC1) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 355 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1045)),
                    when=dword(0xA8A998) == 828
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple IV: Man-in-waiting", points = 1, type="missable",
    description = "Assess the developments surrounding the young man amidst the Medieval period in Chapter 5",
    id = 310162, badge = "465993", published = "19/04/2023 19:39:22", modified = "5/04/2024 18:13:29",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
                measured(repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF72) > prev(byte(0xA9EF72)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1046)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 6) &&
                measured(repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6AC2) > prev(byte(0xAA6AC2)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1046)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple V: Parting", points = 3, type="missable",
    description = "Offer guidance to the young couple in the Middle Ages during Chapter 7",
    id = 314753, badge = "465994", published = "5/05/2023 8:33:58", modified = "5/04/2024 18:13:30",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF84) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF74) > prev(byte(0xA9EF74)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never(byte(0xB95704) != 8) &&
                measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF85) == 2 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF74) > prev(byte(0xA9EF74)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD4) == 1 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 59 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6AC4) > prev(byte(0xAA6AC4)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1048)), when=bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never(byte(0xB9D284) != 8) &&
                measured(tally(4, repeated(2,
                    byte(0xAA6876) == 1 && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 407 && byte(0xAA6AD5) == 2 &&
                    dword(dword(0xAA6B30) & 0x1FFFFFF) == 59 && dword(dword(0xAA6B34) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xAA6876) == 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    byte(0xAA6AC4) > prev(byte(0xAA6AC4)) && dword(dword(0xAA6B30) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1048)), when=bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Yesteryears Couple VI: Never Destined To Meet", points = 5, type="missable",
    description = "Share a piece of wisdom with the young man in the Middle Ages and assess his interpretation within Chapter 8",
    id = 315568, badge = "465995", published = "7/05/2023 18:08:33", modified = "5/04/2024 18:13:30",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) &&
                unless(dword(0xA5AB48) != 892612657) && unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never((byte(0xB95704) != 11 && byte(0xB95704) != 9)) &&
                measured(tally(2,
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    prev(byte(0xA9EF78)) == 0 && byte(0xA9EF78) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1052),
                    once(byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) == 0 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1075)), when=dword(0xA82E48) == 1011
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) &&
                unless(dword(0xA64C78) != 825570608) && unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never((byte(0xB9D284) != 11 && byte(0xB9D284) != 9)) &&
                measured(tally(2,
                    once(byte(0xAA6876) == 1 && byte(0xAA6ADE) >= 1 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 &&
                    prev(byte(0xAA6AC8)) == 0 && byte(0xAA6AC8) == 1 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1052),
                    once(byte(0xAA6876) == 1 && byte(0xAA6ADE) >= 1 && bit0(0xAA6ADF) == 1 && bit1(0xAA6ADF) == 0 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 408 && dword(dword(0xAA6B30) & 0x1FFFFFF) == 19 &&
                    dword(dword(0xAA6B34) & 0x1FFFFFF) == 1075)), when=dword(0xA8A998) == 1011
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Energy Locator: Present Day", points = 5, type="missable",
    description = "Locate five unique energy orbs scattered across present-day Lebensbaum",
    id = 399816, badge = "461689", published = "19/02/2024 14:12:16", modified = "5/04/2024 18:13:30",
    trigger = always_true() &&
              ((unless((dword(0xA82E48) != 885 && dword(0xA82E48) != 3 && dword(0xA82E48) != 68)) &&
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
                    0x000007)))),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && bit0(0xA82E2C) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless((dword(0xA8A998) != 885 && dword(0xA8A998) != 3 && dword(0xA8A998) != 68)) &&
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
                    0x000007)))),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && bit0(0xA8A97C) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: Middle Ages", points = 5, type="missable",
    description = "Locate six unique energy orbs scattered across Medieval Lebensbaum",
    id = 399819, badge = "465996", published = "19/02/2024 14:12:17", modified = "5/04/2024 18:13:30",
    trigger = always_true() &&
              ((measured(tally(6,
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
                    bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F8) & 0x1FFFFFF) + 0x000004)))),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && bit0(0xA82E2C) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (measured(tally(6,
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
                    bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C8) & 0x1FFFFFF) + 0x000004)))),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && bit0(0xA8A97C) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: The Late 20th Century", points = 5, type="missable",
    description = "Locate five unique energy orbs scattered across Lebensbaum during the late 20th century",
    id = 399817, badge = "461687", published = "19/02/2024 14:12:16", modified = "5/04/2024 18:13:33",
    trigger = always_true() &&
              ((unless((dword(0xA82E48) != 1125 && dword(0xA82E48) != 797)) &&
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
                    0x000005)))),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && bit0(0xA82E2C) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (unless((dword(0xA8A998) != 1125 && dword(0xA8A998) != 797)) &&
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
                    0x000005)))),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && bit0(0xA8A97C) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Energy Locator: The Early 20th Century", points = 5, type="missable",
    description = "Locate six unique energy orbs scattered across Lebensbaum during the early 20th century",
    id = 399818, badge = "461686", published = "19/02/2024 14:12:16", modified = "5/04/2024 18:13:33",
    trigger = always_true() &&
              ((measured(tally(6,
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
                    bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA442F4) & 0x1FFFFFF) + 0x000004)))),
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && bit0(0xA82E2C) == 0
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (never((low4(0xA9EDDC) == 0 || byte(0xB95704) != prev(byte(0xB95704)) ||
                    byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && dword(0xA5AB44) == 1398099029 &&
                    dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57
                ) && always_false()) ||
               (measured(tally(6,
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
                    bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004) > prev(bit0((dword(0xA450C4) & 0x1FFFFFF) + 0x000004)))),
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && bit0(0xA8A97C) == 0
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (never((low4(0xAA692C) == 0 || byte(0xB9D284) != prev(byte(0xB9D284)) ||
                    byte(0xAA55F8) < prev(byte(0xAA55F8))) && dword(0xA64C74) == 1296714837 &&
                    dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50
                ) && always_false()))
)

achievement(
    title = "Stockpiling Across Eras", points = 10, type="missable",
    description = "Accrue the largest arsenal of items during a singular playthrough",
    id = 402404, badge = "468297", published = "25/02/2024 19:47:49", modified = "5/04/2024 18:13:33",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(bit0(0xA9F042) < prev(bit0(0xA9F042))) && never(bit0(0xA9F045) < prev(bit0(0xA9F045))) &&
                never(bit0(0xA9F03B) < prev(bit0(0xA9F03B))) && never(bit0(0xA9F03C) < prev(bit0(0xA9F03C))) &&
                never(bit0(0xA9F047) < prev(bit0(0xA9F047))) && never(bit0(0xA9F035) < prev(bit0(0xA9F035))) &&
                never(bit0(0xA9F041) < prev(bit0(0xA9F041))) && never(bit0(0xA9F034) < prev(bit0(0xA9F034))) &&
                never(bit0(0xA9F044) < prev(bit0(0xA9F044))) && never(bit0(0xA9F038) < prev(bit0(0xA9F038))) &&
                never(bit0(0xA9F040) < prev(bit0(0xA9F040))) && never(bit0(0xA9F04B) < prev(bit0(0xA9F04B))) &&
                never(bit0(0xA9F048) < prev(bit0(0xA9F048))) && never(bit0(0xA9F04D) < prev(bit0(0xA9F04D))) &&
                never(bit0(0xA9F050) < prev(bit0(0xA9F050))) && never(bit0(0xA9F03A) < prev(bit0(0xA9F03A))) &&
                never(bit0(0xA9F04C) < prev(bit0(0xA9F04C))) && never(bit0(0xA9F046) < prev(bit0(0xA9F046))) &&
                never(bit0(0xA9F03E) < prev(bit0(0xA9F03E))) && never(bit0(0xA9F04F) < prev(bit0(0xA9F04F))) &&
                never(bit0(0xA9F04E) < prev(bit0(0xA9F04E))) && never(bit0(0xA9F03F) < prev(bit0(0xA9F03F))) &&
                never(bit0(0xA9F036) < prev(bit0(0xA9F036))) && never(bit0(0xA9F03D) < prev(bit0(0xA9F03D))) &&
                never(bit0(0xA9F04A) < prev(bit0(0xA9F04A))) && never(bit0(0xA9F039) < prev(bit0(0xA9F039))) &&
                never(bit0(0xA9F043) < prev(bit0(0xA9F043))) && never(bit0(0xA9F049) < prev(bit0(0xA9F049))) &&
                once(((prev(bit0(0xA9F042)) + prev(bit0(0xA9F045)) + prev(bit0(0xA9F03B)) + prev(bit0(0xA9F03C)) +
                    prev(bit0(0xA9F047)) + prev(bit0(0xA9F035)) + prev(bit0(0xA9F041)) + prev(bit0(0xA9F034)) +
                    prev(bit0(0xA9F044)) + prev(bit0(0xA9F038)) + prev(bit0(0xA9F040)) + prev(bit0(0xA9F04B)) +
                    prev(bit0(0xA9F048)) + prev(bit0(0xA9F04D)) + prev(bit0(0xA9F050)) + prev(bit0(0xA9F03A)) +
                    prev(bit0(0xA9F04C)) + prev(bit0(0xA9F046)) + prev(bit0(0xA9F03E)) + prev(bit0(0xA9F04F)) +
                    prev(bit0(0xA9F04E)) + prev(bit0(0xA9F03F)) + prev(bit0(0xA9F036)) + prev(bit0(0xA9F03D)) +
                    prev(bit0(0xA9F04A)) + prev(bit0(0xA9F039)) + prev(bit0(0xA9F043)) + prev(bit0(0xA9F049))) < 20) &&
                    (bit0(0xA9F042) + bit0(0xA9F045) + bit0(0xA9F03B) + bit0(0xA9F03C) + bit0(0xA9F047) + bit0(0xA9F035) +
                    bit0(0xA9F041) + bit0(0xA9F034) + bit0(0xA9F044) + bit0(0xA9F038) + bit0(0xA9F040) + bit0(0xA9F04B) +
                    bit0(0xA9F048) + bit0(0xA9F04D) + bit0(0xA9F050) + bit0(0xA9F03A) + bit0(0xA9F04C) + bit0(0xA9F046) +
                    bit0(0xA9F03E) + bit0(0xA9F04F) + bit0(0xA9F04E) + bit0(0xA9F03F) + bit0(0xA9F036) + bit0(0xA9F03D) +
                    bit0(0xA9F04A) + bit0(0xA9F039) + bit0(0xA9F043) + bit0(0xA9F049)) == 20
                ) &&
                measured(tally(20, once(bit0(0xA9F042) == 1), once(bit0(0xA9F045) == 1), once(bit0(0xA9F03B) == 1),
                    once(bit0(0xA9F03C) == 1), once(bit0(0xA9F047) == 1), once(bit0(0xA9F035) == 1),
                    once(bit0(0xA9F041) == 1), once(bit0(0xA9F034) == 1), once(bit0(0xA9F044) == 1),
                    once(bit0(0xA9F038) == 1), once(bit0(0xA9F040) == 1), once(bit0(0xA9F04B) == 1),
                    once(bit0(0xA9F048) == 1), once(bit0(0xA9F04D) == 1), once(bit0(0xA9F050) == 1),
                    once(bit0(0xA9F03A) == 1), once(bit0(0xA9F04C) == 1), once(bit0(0xA9F046) == 1),
                    once(bit0(0xA9F03E) == 1), once(bit0(0xA9F04F) == 1), once(bit0(0xA9F04E) == 1),
                    once(bit0(0xA9F03F) == 1), once(bit0(0xA9F036) == 1), once(bit0(0xA9F03D) == 1),
                    once(bit0(0xA9F04A) == 1), once(bit0(0xA9F039) == 1), once(bit0(0xA9F043) == 1),
                    once(bit0(0xA9F049) == 1))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(bit0(0xAA6B92) < prev(bit0(0xAA6B92))) && never(bit0(0xAA6B95) < prev(bit0(0xAA6B95))) &&
                never(bit0(0xAA6B8B) < prev(bit0(0xAA6B8B))) && never(bit0(0xAA6B8C) < prev(bit0(0xAA6B8C))) &&
                never(bit0(0xAA6B97) < prev(bit0(0xAA6B97))) && never(bit0(0xAA6B85) < prev(bit0(0xAA6B85))) &&
                never(bit0(0xAA6B91) < prev(bit0(0xAA6B91))) && never(bit0(0xAA6B84) < prev(bit0(0xAA6B84))) &&
                never(bit0(0xAA6B94) < prev(bit0(0xAA6B94))) && never(bit0(0xAA6B88) < prev(bit0(0xAA6B88))) &&
                never(bit0(0xAA6B90) < prev(bit0(0xAA6B90))) && never(bit0(0xAA6B9B) < prev(bit0(0xAA6B9B))) &&
                never(bit0(0xAA6B98) < prev(bit0(0xAA6B98))) && never(bit0(0xAA6B9D) < prev(bit0(0xAA6B9D))) &&
                never(bit0(0xAA6B9A) < prev(bit0(0xAA6B9A))) && never(bit0(0xAA6B8A) < prev(bit0(0xAA6B8A))) &&
                never(bit0(0xAA6B9C) < prev(bit0(0xAA6B9C))) && never(bit0(0xAA6B96) < prev(bit0(0xAA6B96))) &&
                never(bit0(0xAA6B8E) < prev(bit0(0xAA6B8E))) && never(bit0(0xAA6B9F) < prev(bit0(0xAA6B9F))) &&
                never(bit0(0xAA6B9E) < prev(bit0(0xAA6B9E))) && never(bit0(0xAA6B8F) < prev(bit0(0xAA6B8F))) &&
                never(bit0(0xAA6B86) < prev(bit0(0xAA6B86))) && never(bit0(0xAA6B8D) < prev(bit0(0xAA6B8D))) &&
                never(bit0(0xAA6BA0) < prev(bit0(0xAA6BA0))) && never(bit0(0xAA6B89) < prev(bit0(0xAA6B89))) &&
                never(bit0(0xAA6B93) < prev(bit0(0xAA6B93))) && never(bit0(0xAA6B99) < prev(bit0(0xAA6B99))) &&
                once(((prev(bit0(0xAA6B92)) + prev(bit0(0xAA6B95)) + prev(bit0(0xAA6B8B)) + prev(bit0(0xAA6B8C)) +
                    prev(bit0(0xAA6B97)) + prev(bit0(0xAA6B85)) + prev(bit0(0xAA6B91)) + prev(bit0(0xAA6B84)) +
                    prev(bit0(0xAA6B94)) + prev(bit0(0xAA6B88)) + prev(bit0(0xAA6B90)) + prev(bit0(0xAA6B9B)) +
                    prev(bit0(0xAA6B98)) + prev(bit0(0xAA6B9D)) + prev(bit0(0xAA6B9A)) + prev(bit0(0xAA6B8A)) +
                    prev(bit0(0xAA6B9C)) + prev(bit0(0xAA6B96)) + prev(bit0(0xAA6B8E)) + prev(bit0(0xAA6B9F)) +
                    prev(bit0(0xAA6B9E)) + prev(bit0(0xAA6B8F)) + prev(bit0(0xAA6B86)) + prev(bit0(0xAA6B8D)) +
                    prev(bit0(0xAA6BA0)) + prev(bit0(0xAA6B89)) + prev(bit0(0xAA6B93)) + prev(bit0(0xAA6B99))) < 20) &&
                    (bit0(0xAA6B92) + bit0(0xAA6B95) + bit0(0xAA6B8B) + bit0(0xAA6B8C) + bit0(0xAA6B97) + bit0(0xAA6B85) +
                    bit0(0xAA6B91) + bit0(0xAA6B84) + bit0(0xAA6B94) + bit0(0xAA6B88) + bit0(0xAA6B90) + bit0(0xAA6B9B) +
                    bit0(0xAA6B98) + bit0(0xAA6B9D) + bit0(0xAA6B9A) + bit0(0xAA6B8A) + bit0(0xAA6B9C) + bit0(0xAA6B96) +
                    bit0(0xAA6B8E) + bit0(0xAA6B9F) + bit0(0xAA6B9E) + bit0(0xAA6B8F) + bit0(0xAA6B86) + bit0(0xAA6B8D) +
                    bit0(0xAA6BA0) + bit0(0xAA6B89) + bit0(0xAA6B93) + bit0(0xAA6B99)) == 20
                ) &&
                measured(tally(20, once(bit0(0xAA6B92) == 1), once(bit0(0xAA6B95) == 1), once(bit0(0xAA6B8B) == 1),
                    once(bit0(0xAA6B8C) == 1), once(bit0(0xAA6B97) == 1), once(bit0(0xAA6B85) == 1),
                    once(bit0(0xAA6B91) == 1), once(bit0(0xAA6B84) == 1), once(bit0(0xAA6B94) == 1),
                    once(bit0(0xAA6B88) == 1), once(bit0(0xAA6B90) == 1), once(bit0(0xAA6B9B) == 1),
                    once(bit0(0xAA6B98) == 1), once(bit0(0xAA6B9D) == 1), once(bit0(0xAA6B9A) == 1),
                    once(bit0(0xAA6B8A) == 1), once(bit0(0xAA6B9C) == 1), once(bit0(0xAA6B96) == 1),
                    once(bit0(0xAA6B8E) == 1), once(bit0(0xAA6B9F) == 1), once(bit0(0xAA6B9E) == 1),
                    once(bit0(0xAA6B8F) == 1), once(bit0(0xAA6B86) == 1), once(bit0(0xAA6B8D) == 1),
                    once(bit0(0xAA6BA0) == 1), once(bit0(0xAA6B89) == 1), once(bit0(0xAA6B93) == 1),
                    once(bit0(0xAA6B99) == 1))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "An Alchemist, A Jewel And A Homunculus", points = 5, type="progression",
    description = "Complete Chapter 3",
    id = 306921, badge = "465997", published = "5/04/2023 22:23:24", modified = "5/04/2024 18:13:34",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 4) && unless(byte(0xA9F111) != 0) &&
                never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 105856 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 33440 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 72384
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 850752 && prior(dword(0xA9ECBC)) == 105856 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 14832 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 231328
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 235136 && prior(dword(0xA9ECBC)) == 850752 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 32272 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 31904
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 4 && byte(0xB95704) == 5) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 4) && unless(byte(0xAA6C61) != 0) &&
                never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 105856 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 33440 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 72384
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 850752 && prior(dword(0xAA680C)) == 105856 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 14832 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 231328
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 235136 && prior(dword(0xAA680C)) == 850752 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 32272 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 31904
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 4 && byte(0xB9D284) == 5))
)

achievement(
    title = "Running Beyond The 90's... And 80's", points = 2, type="missable",
    description = "Encounter an athletic man from a bygone era, as well as his present self during Chapter 3, 4 or 5",
    id = 405086, badge = "465998", published = "5/03/2024 14:02:24", modified = "5/04/2024 18:13:34",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) &&
                never((byte(0xB95704) != 4 && byte(0xB95704) != 5 && byte(0xB95704) != 6)) &&
                measured(tally(2,
                    once((dword(0xA82E48) == 885 || dword(0xA82E48) == 68 || dword(0xA82E48) == 3) && byte(0xA9ED26) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 88),
                    once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 797 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 89))
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) &&
                never((byte(0xB9D284) != 4 && byte(0xB9D284) != 5 && byte(0xB9D284) != 6)) &&
                measured(tally(2,
                    once((dword(0xA8A998) == 885 || dword(0xA8A998) == 68 || dword(0xA8A998) == 3) && byte(0xAA6876) == 1 &&
                    dword(dword(0xAA6B2C) & 0x1FFFFFF) == 88),
                    once(byte(0xAA6876) == 1 && dword(0xA8A998) == 797 && dword(dword(0xAA6B2C) & 0x1FFFFFF) == 89))
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Strokes Of Destiny", points = 1, type="missable",
    description = "Marvel at the beauty of each unique painting on display at the Brum Museum",
    id = 307499, badge = "465999", published = "9/04/2023 11:10:41", modified = "5/04/2024 18:13:34",
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
    title = "My My, So Eager To Die", points = 1, type="missable",
    description = "Firmly excuse yourself from the apparition's company in Chapter 3",
    id = 306919, badge = "466003", published = "5/04/2023 22:23:23", modified = "5/04/2024 18:13:36",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 4) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 45376 && prior(dword(0xA9ECBC)) == 371328 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 23232 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14512
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 107584 && prior(dword(0xA9ECBC)) == 45376 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 55712 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 51792
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 4) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 45376 && prior(dword(0xAA680C)) == 371328 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 23232 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 14512
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 107584 && prior(dword(0xAA680C)) == 45376 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 55712 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 51792
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Time-Spun Sweets", points = 3, type="missable",
    description = "Gift a delectable sweet to a cherished individual in your life",
    id = 402296, badge = "466004", published = "25/02/2024 12:43:23", modified = "5/04/2024 18:13:36",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 19 && dword(0xA9ECBC) == 1093632 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 711488 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 382112
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 19 && dword(0xAA680C) == 1093632 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 711488 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 382112
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Legacy Of Sweetness", points = 3, type="missable",
    description = "Establish a new line of pastries",
    id = 402297, badge = "466005", published = "25/02/2024 12:43:23", modified = "5/04/2024 18:13:37",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 19 && dword(0xA9ECBC) == 130432 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 130384 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 130384 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 86992 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 74416
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 19 && dword(0xAA680C) == 130432 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 130384 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 130384 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 86992 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x00002C) == 74416
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Pan-tastic Resilience", points = 3, type="progression",
    description = "Complete Chapter 4, using a frying pan",
    id = 308964, badge = "461657", published = "16/04/2023 17:01:09", modified = "5/04/2024 18:13:37",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
                once(byte(0xA9F111) == 4 && byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 324096 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 251136
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
                once(byte(0xA9F111) == 4 && byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 345472 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 94304 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 5008
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(prev(dword(0xAA680C)) != dword(0xAA680C)) &&
                once(byte(0xAA6C61) == 4 && byte(0xAA6876) == 5 && byte(0xB9D284) == 5 && dword(0xAA680C) == 324096 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 251136
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(prev(dword(0xAA680C)) != dword(0xAA680C)) &&
                once(byte(0xAA6C61) == 4 && byte(0xAA6876) == 5 && byte(0xB9D284) == 5 && dword(0xAA680C) == 345472 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 94304 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 5008
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 5 && byte(0xB9D284) == 6))
)

achievement(
    title = "Through The Lens Of Survival", points = 3, type="progression",
    description = "Complete Chapter 4, using a sign",
    id = 310149, badge = "461658", published = "19/04/2023 16:09:53", modified = "5/04/2024 18:13:37",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
                once(byte(0xA9F111) == 5 && byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 345472 &&
                    word(0xA9ECC0) == 13 && word(0xA9ECC2) == 14 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 46816 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44624
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(prev(dword(0xAA680C)) != dword(0xAA680C)) &&
                once(byte(0xAA6C61) == 5 && byte(0xAA6876) == 5 && byte(0xB9D284) == 5 && dword(0xAA680C) == 345472 &&
                    word(0xAA6810) == 13 && word(0xAA6812) == 14 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 46816 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 44624
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 5 && byte(0xB9D284) == 6))
)

achievement(
    title = "Nine Lives Across Generations", points = 4, type="missable",
    description = "Offer a charming kitty to a lonely girl either during or after Chapter 4",
    id = 310426, badge = "466048", published = "20/04/2023 18:06:14", modified = "5/04/2024 18:13:39",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1539 && bit0(0xA9F04B) == 1 &&
                    dword(0xA9ECBC) == 152064 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 11264 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 67888
                ) && bit6(0xA9EDCB) == 1 && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1539 && bit0(0xAA6B9B) == 1 &&
                    dword(0xAA680C) == 152064 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 11264 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 67888
                ) && bit6(0xAA691B) == 1 && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Even I Can Do That", points = 3, type="missable",
    description = "Step into the shoes of a performer and clandestinely transmit a message to yourself during Chapter 4",
    id = 402284, badge = "466006", published = "25/02/2024 11:33:55", modified = "5/04/2024 18:13:40",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && byte(0xA9F111) == 12 && bit2(0xA9EDA5) == 1 &&
                    dword(0xA9ECBC) == 107264 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54336 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14848
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(prev(dword(0xAA680C)) != dword(0xAA680C)) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 5 && byte(0xAA6C61) == 12 && bit2(0xAA68F5) == 1 &&
                    dword(0xAA680C) == 107264 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 54336 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 14848
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Performance Gone The Extra Mile", points = 3, type="missable",
    description = "Highlight the significance of going above and beyond, especially for those, including yourself, who would truly value the performer's effort",
    id = 403575, badge = "466007", published = "29/02/2024 15:31:22", modified = "5/04/2024 18:13:40",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
                never(repeated(300, bit2(0xA9EDA5) == 0)) &&
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
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
                never(repeated(300, bit2(0xA9EDA5) == 0)) &&
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
                never(repeated(300, bit2(0xAA68F5) == 0)) &&
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
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(byte(0xB9D284) != 5) &&
                never(repeated(300, bit2(0xAA68F5) == 0)) &&
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
    title = "Complexities Of The Fourth Dimension", points = 3, type="missable",
    description = "Receive a lecture on time-travel physics within Chapter 4",
    id = 310163, badge = "464226", published = "19/04/2023 19:40:38", modified = "5/04/2024 18:13:40",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 5) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 4 && dword(0xA9ECBC) == 721152 && word(0xA9ECC0) == 13 &&
                    word(0xA9ECC2) == 14 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 126896 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44656),
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 5 && dword(0xA9ECBC) == 721152 && word(0xA9ECC0) == 13 &&
                    word(0xA9ECC2) == 14 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 125600 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44656)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 5) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 4 && dword(0xAA680C) == 721152 && word(0xAA6810) == 13 &&
                    word(0xAA6812) == 14 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 126896 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 44656),
                    once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 5 && dword(0xAA680C) == 721152 && word(0xAA6810) == 13 &&
                    word(0xAA6812) == 14 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 125600 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 44656)
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
    title = "Pan In Advance", points = 3, type="missable",
    description = "Secure an iron plate prior to Chapter 4, deploying it judiciously when its utility becomes necessary",
    id = 403823, badge = "466009", published = "2/03/2024 0:38:26", modified = "5/04/2024 18:13:40",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 5) && never(bit0(0xA9F03B) == 1) && never(bit0(0xA9F03C) == 1) &&
                once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 4 && dword(0xA9ECBC) == 324096 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 251136
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 5) && never(bit0(0xAA6B8B) == 1) && never(bit0(0xAA6B8C) == 1) &&
                once(byte(0xAA6876) == 5 && byte(0xAA6C61) == 4 && dword(0xAA680C) == 324096 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 251136
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Ancient Elixir", points = 5, type="progression",
    description = "Complete Chapter 5",
    id = 311616, badge = "466010", published = "25/04/2023 18:57:11", modified = "5/04/2024 18:13:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 6 && byte(0xA9F111) == 17 && dword(0xA9ECBC) == 260480 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 260480
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 6 && byte(0xB95704) == 7) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 6 && byte(0xAA6C61) == 17 && dword(0xAA680C) == 260480 &&
                    word(0xAA6810) == 65535 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 260480
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 6 && byte(0xB9D284) == 7))
)

achievement(
    title = "A Complimentary Dinner", points = 3, type="missable",
    description = "Enjoy a free dinner  at Bar Zum Ei during Chapter 5",
    id = 405461, badge = "466011", published = "6/03/2024 15:30:07", modified = "5/04/2024 18:13:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 6) && never((bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0)) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 403520 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 156064 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27840 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 638304 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 27840
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1023168 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 24240 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 998896 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2812512 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 998896
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 6) && never((bit5(0xAA68ED) == 1 && bit7(0xAA68ED) == 0)) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 403520 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 156064 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 27840 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 638304 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 27840
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1023168 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 24240 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 998896 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 2812512 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 998896
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "A Mother's Child", points = 2, type="missable",
    description = "Chance upon Hugo in the vicinity of his home during the events of Chapter 5",
    id = 311466, badge = "466012", published = "24/04/2023 18:48:54", modified = "5/04/2024 18:13:42",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 6) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 257280 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 12560 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 244672 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2632416 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 244672
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 6) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 257280 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 12560 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 244672 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 2632416 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 244672
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Barman's Mystery Child", points = 3, type="missable",
    description = "Uncover the truth about the barman's grandchildren in Chapter 5",
    id = 315567, badge = "466013", published = "7/05/2023 18:08:33", modified = "5/04/2024 18:13:43",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 6) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 852480 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 250512 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 601904
                ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 6) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 852480 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 250512 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 601904
                ) && prev(byte(0xAA6876)) > 3 && byte(0xAA6876) <= 3 && byte(0xAA6876) != 0))
)

achievement(
    title = "Art Muse", points = 3, type="missable",
    description = "Inspire a renowned artist and appraise his work",
    id = 403824, badge = "466014", published = "2/03/2024 0:38:26", modified = "5/04/2024 18:13:43",
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
    title = "Director's Cut: Trip For Two", points = 3, type="progression",
    description = "Complete Chapter 6, by co-directing a love picture",
    id = 313210, badge = "466017", published = "1/05/2023 15:18:03", modified = "5/04/2024 18:13:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 645952 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 &&
                bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 && prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit2(0xAA6908) == 1 && bit1(0xAA6908) == 0 &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 645952 && word(0xAA6810) == 7 && word(0xAA6812) == 8 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 &&
                bit2(0xAA6908) == 1 && bit1(0xAA6908) == 0 && prev(byte(0xB9D284)) == 7 && byte(0xB9D284) == 8))
)

achievement(
    title = "Director's Cut: The Time Of Reckoning", points = 3, type="progression",
    description = "Complete Chapter 6, by co-directing a thriller picture",
    id = 313211, badge = "466016", published = "1/05/2023 15:18:03", modified = "5/04/2024 18:13:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 645952 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 &&
                bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 && prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit1(0xAA6908) == 1 && bit2(0xAA6908) == 0 &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 645952 && word(0xAA6810) == 7 && word(0xAA6812) == 8 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 &&
                bit1(0xAA6908) == 1 && bit2(0xAA6908) == 0 && prev(byte(0xB9D284)) == 7 && byte(0xB9D284) == 8))
)

achievement(
    title = "Time Ego Flop", points = 1, type="missable",
    description = "Weave the fabric of time and space as co-directors in the creation of 'Time Ego Trip World Conquest' during the narrative of Chapter 6",
    id = 313212, badge = "466018", published = "1/05/2023 15:18:03", modified = "5/04/2024 18:13:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 7) &&
                once(byte(0xA9ED26) == 5 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit7(0xA9EDB7) == 1 &&
                    bit0(0xA9EDB8) == 0 && dword(0xA9ECBC) == 489856 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 365120 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 124720
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 7) &&
                once(byte(0xAA6876) == 5 && bit6(0xAA6907) == 1 && bit5(0xAA6907) == 0 && bit7(0xAA6907) == 1 &&
                    bit0(0xAA6908) == 0 && dword(0xAA680C) == 489856 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 365120 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 124720
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "Cracking Open The Past: The Old Century", points = 3, type="missable",
    description = "Pay for some coffee with an oval shaped object from Chapter 6 onward",
    id = 313213, badge = "466019", published = "1/05/2023 15:18:04", modified = "5/04/2024 18:13:45",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(bit0(0xA9F044) == 0) &&
                never((byte(0xB95704) != 7 && byte(0xB95704) != 8 && byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 570432 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 242592 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 327808 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 913376 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 327808),
                    once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 705728 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 371744 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 333936 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 519216 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 194352)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(bit0(0xAA6B94) == 0) &&
                never((byte(0xB9D284) != 7 && byte(0xB9D284) != 8 && byte(0xB9D284) != 9 && byte(0xB9D284) != 11)) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 569 && dword(0xAA680C) == 570432 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 242592 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 327808 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 913376 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 327808),
                    once(byte(0xAA6876) == 5 && dword(0xA8A998) == 569 && dword(0xAA680C) == 705728 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 371744 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 333936 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 519216 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x00002C) == 194352)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "Illusive Guardian Of The Brums", points = 3, type="missable",
    description = "Navigate the labyrinths of fate to shield a member of the Brum family from their destined demise during the events of Chapter 6",
    id = 315569, badge = "466020", published = "7/05/2023 18:08:33", modified = "5/04/2024 18:13:46",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && byte(0xB95704) == 7 &&
                    dword(0xA9ECBC) == 965312 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 345840 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 20656
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1125 && byte(0xB9D284) == 7 &&
                    dword(0xAA680C) == 965312 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 345840 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 20656
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
    title = "Picked Up A Baby The Other Day", points = 2, type="missable",
    description = "Witness a chilling crime scene revealed amidst the snowy terrain during Chapter 6",
    id = 313209, badge = "466022", published = "1/05/2023 15:18:03", modified = "5/04/2024 18:13:46",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && byte(0xB95704) == 7 &&
                    dword(0xA9ECBC) == 480960 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 18016 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 324112 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 756624 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 324112
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xA8A998) == 1125 && byte(0xB9D284) == 7 &&
                    dword(0xAA680C) == 480960 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 18016 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 324112 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 756624 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 324112
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Friend's Repentance", points = 5, type="progression",
    description = "Complete Chapter 7",
    id = 315565, badge = "466023", published = "7/05/2023 18:08:33", modified = "5/04/2024 18:13:48",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 8) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 274496 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && dword(0xA9ECBC) == 813056 &&
                    word(0xA9ECC0) == 5 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 284448 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 445648),
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && dword(0xA9ECBC) == 859072 &&
                    word(0xA9ECC0) == 3 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 294912 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 373136)
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 73792 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 3296 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 70448
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 8 && byte(0xB95704) == 11) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 8 && byte(0xB95704) == 9) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 8) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 274496 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && dword(0xAA680C) == 813056 &&
                    word(0xAA6810) == 5 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 284448 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 445648),
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1 && dword(0xAA680C) == 859072 &&
                    word(0xAA6810) == 3 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 294912 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 373136)
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 73792 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 3296 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 70448
                ) && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 8 && byte(0xB9D284) == 11) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 8 && byte(0xB9D284) == 9))
)

achievement(
    title = "Fated To Plunge", points = 1, type="missable",
    description = "Employ a worn-out cable to save yourself during Chapter 7",
    id = 315563, badge = "466024", published = "7/05/2023 18:08:32", modified = "5/04/2024 18:13:48",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 87616 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 6 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 30768 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 8736
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 87616 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 100656 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44640
                ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
                trigger_when(byte(0xA9ED26) != 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 87616 && word(0xAA6810) == 5 && word(0xAA6812) == 6 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 30768 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 8736
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 145344 && prior(dword(0xAA680C)) == 87616 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 100656 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 44640
                ) && trigger_when(prev(byte(0xAA6876)) > 3) && trigger_when(byte(0xAA6876) <= 3) &&
                trigger_when(byte(0xAA6876) != 0)))
)

achievement(
    title = "The Next Big Thing", points = 3, type="missable",
    description = "Inspire the movie director for a second time during Chapter 7",
    id = 404045, badge = "468295", published = "2/03/2024 21:18:07", modified = "5/04/2024 18:13:48",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && bit3(0xA9EDCC) == 1 && dword(0xA9ECBC) == 659264 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 283504 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 375696 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 588000 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 375696
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && bit3(0xAA691C) == 1 && dword(0xAA680C) == 659264 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 283504 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 375696 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 588000 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 375696
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "A Pair Of Delinquents", points = 2, type="missable",
    description = "Encounter some mischievous rascals in Chapter 7",
    id = 404048, badge = "466031", published = "2/03/2024 22:13:05", modified = "5/04/2024 18:13:48",
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
    id = 315561, badge = "466027", published = "7/05/2023 18:08:31", modified = "5/04/2024 18:13:49",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 577152 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 312832 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 145056 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 460352 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 145056
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B94) == 1 && dword(0xAA680C) == 577152 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 312832 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 145056 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 460352 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 145056
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Brums Happily Ever After", points = 3, type="missable",
    description = "Meet Eckart's wife in Chapter 7, after your valiant act",
    id = 315570, badge = "466028", published = "7/05/2023 18:08:34", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 8) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 274496 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && dword(0xA9ECBC) == 817472 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 38336 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 29712),
                    once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && dword(0xA9ECBC) == 730432 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 38336 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27888)
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 8) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 274496 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && dword(0xAA680C) == 817472 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 38336 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 29712),
                    once(byte(0xAA6876) == 5 && bit6(0xAA68FE) == 0 && bit7(0xAA68FE) == 1 && dword(0xAA680C) == 730432 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 38336 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 27888)
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Whole Picture... Or Is It?", points = 5, type="progression",
    description = "Complete Chapter 8",
    id = 315571, badge = "466049", published = "7/05/2023 18:08:34", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 570944 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 185408 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 272208
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1109760 && word(0xA9ECC0) == 9 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 46624 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 62672
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 935936 && word(0xA9ECC0) == 9 && word(0xA9ECC2) == 10 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 420512 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 381024
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 873536 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 6 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 267600 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 177184
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 464576 && word(0xA9ECC0) == 9 && word(0xA9ECC2) == 10 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 145904 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 106224
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 998528 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 597040 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 401456
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 9) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1031424 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 392960 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 159536
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 806464 && prior(dword(0xA9ECBC)) == 1031424 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 403024 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27616
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 117696 && word(0xA9ECC0) == 5 &&
                    word(0xA9ECC2) == 4 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 51424 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 39152
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 11) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 490048 && prior(dword(0xA9ECBC)) == 169728 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 204752 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 285200
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 307520 && prior(dword(0xA9ECBC)) == 490048 &&
                    word(0xA9ECC0) == 5 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 74416 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 100848
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 824384 && prior(dword(0xA9ECBC)) == 655552 &&
                    word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 289616 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 534688
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && unless(byte(0xB95704) != 11) && never(low4(0xA9EDDC) == 0) &&
                never(dword(0xAC49F4) != 0) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1055680 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 489760 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 468432
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1275136 && prior(dword(0xA9ECBC)) == 1055680 &&
                    word(0xA9ECC0) == 12 && word(0xA9ECC2) == 13 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 507376 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 348816
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 9 && byte(0xB95704) == 10) ||
               (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
                low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 && prev(byte(0xB95704)) == 11 && byte(0xB95704) == 12) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 570944 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 185408 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 272208
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1109760 && word(0xAA6810) == 9 && word(0xAA6812) == 8 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 46624 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 62672
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 935936 && word(0xAA6810) == 9 && word(0xAA6812) == 10 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 420512 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 381024
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 873536 && word(0xAA6810) == 7 && word(0xAA6812) == 6 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 267600 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 177184
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 464576 && word(0xAA6810) == 9 && word(0xAA6812) == 10 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 145904 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 106224
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 998528 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 597040 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 401456
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 9) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1031424 && word(0xAA6810) == 5 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 392960 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 159536
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 806464 && prior(dword(0xAA680C)) == 1031424 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 403024 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 27616
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && byte(0xB9D284) == 9 && dword(0xAA680C) == 117696 && word(0xAA6810) == 5 &&
                    word(0xAA6812) == 4 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 51424 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 39152
                ) && bit6(0xAA68FE) == 1 && bit7(0xAA68FE) == 0 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 11) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 490048 && prior(dword(0xAA680C)) == 169728 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 204752 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 285200
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 307520 && prior(dword(0xAA680C)) == 490048 &&
                    word(0xAA6810) == 5 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 74416 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 100848
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 824384 && prior(dword(0xAA680C)) == 655552 &&
                    word(0xAA6810) == 3 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 289616 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 534688
                ) && bit1(0xAA6914) == 0 && bit3(0xAA6914) == 0 && bit4(0xAA6914) == 0 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && unless(byte(0xB9D284) != 11) && never(low4(0xAA692C) == 0) &&
                never(dword(0xACC534) != 0) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1055680 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 489760 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 468432
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 1275136 && prior(dword(0xAA680C)) == 1055680 &&
                    word(0xAA6810) == 12 && word(0xAA6812) == 13 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 507376 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 348816
                ) && bit1(0xAA6914) == 1 && bit3(0xAA6914) == 1 && bit4(0xAA6914) == 1 && bit6(0xAA68FE) == 0 &&
                bit7(0xAA68FE) == 1 && prev(byte(0xAA6876)) != 0 && byte(0xAA6876) == 0) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 9 && byte(0xB9D284) == 10) ||
               (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
                low4(0xAA692C) != 0 && dword(0xACC534) == 0 && prev(byte(0xB9D284)) == 11 && byte(0xB9D284) == 12))
)

achievement(
    title = "The Eggcellent Director's Tale", points = 3, type="missable",
    description = "Share stories about your newly acquired pocket watch with Eckart in Chapter 8",
    id = 315562, badge = "466029", published = "7/05/2023 18:08:32", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never((byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 580800 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 203408 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 42016 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 916416 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 42016
                ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never((byte(0xB9D284) != 9 && byte(0xB9D284) != 11)) &&
                once(byte(0xAA6876) == 5 && bit0(0xAA6B94) == 1 && dword(0xAA680C) == 580800 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 203408 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 42016 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 916416 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 42016
                ) && trigger_when(prev(byte(0xAA6876)) != 0) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "An End To A Strange Experience", points = 5, type="win_condition",
    description = "Achieve ending A",
    id = 315566, badge = "466030", published = "7/05/2023 18:08:33", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 898944 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 7088 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 208096
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 491392 && prior(dword(0xA9ECBC)) == 898944 &&
                    word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 154704 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 109712
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 898944 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 7088 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 208096
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 491392 && prior(dword(0xAA680C)) == 898944 &&
                    word(0xAA6810) == 3 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 154704 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 109712
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
    title = "No Sense Of Finality I", points = 5, type="win_condition",
    description = "Achieve ending B1",
    id = 315573, badge = "466033", published = "7/05/2023 18:08:34", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 398272 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 277936 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 120272
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 352832 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 262352 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 90416
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 398272 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 277936 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 120272
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 352832 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 262352 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 90416
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
    title = "No Sense Of Finality II", points = 5, type="win_condition",
    description = "Achieve ending B2",
    id = 315572, badge = "466032", published = "7/05/2023 18:08:34", modified = "5/04/2024 18:13:51",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 594496 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 279360 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 269520
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 381632 && prior(dword(0xA9ECBC)) == 594496 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 126928 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 194256
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 352832 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 262352 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 90416
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 594496 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 279360 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 269520
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 381632 && prior(dword(0xAA680C)) == 594496 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 126928 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 194256
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 352832 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 262352 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 90416
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
    id = 317118, badge = "461671", published = "14/05/2023 10:33:35", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 10) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 577280 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 279360 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 269520
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 504128 && prior(dword(0xA9ECBC)) == 577280 &&
                    word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 120112 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 194256
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 833280 && prior(dword(0xA9ECBC)) == 504128 &&
                    word(0xA9ECC0) == 5 && word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 6528 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 125136
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 577280 && word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 279360 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 269520
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 504128 && prior(dword(0xAA680C)) == 577280 &&
                    word(0xAA6810) == 3 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 120112 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 194256
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 833280 && prior(dword(0xAA680C)) == 504128 &&
                    word(0xAA6810) == 5 && word(0xAA6812) == 6 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 6528 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 125136
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
    id = 322230, badge = "466034", published = "28/05/2023 11:34:23", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 12) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 461248 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 149360 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 71568
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 809792 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 432960 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 138048
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 461248 && word(0xAA6810) == 3 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 149360 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 71568
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 809792 && word(0xAA6810) == 3 && word(0xAA6812) == 4 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 432960 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 138048
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
    id = 322231, badge = "461673", published = "28/05/2023 11:34:26", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 12) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 560576 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 181152 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 379392
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 782208 && word(0xA9ECC0) == 9 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 368480 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 87520
                ) &&
                once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 842944 && prior(dword(0xA9ECBC)) == 782208 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 209456 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 137088
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
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 560576 && word(0xAA6810) == 3 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 181152 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 379392
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 782208 && word(0xAA6810) == 9 && word(0xAA6812) == 8 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 368480 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 87520
                ) &&
                once(byte(0xAA6876) == 5 && dword(0xAA680C) == 842944 && prior(dword(0xAA680C)) == 782208 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 2 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 209456 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 137088
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
    id = 405112, badge = "466035", published = "5/03/2024 21:15:30", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 &&
                    bit0(0xAA1156) == 1 && bit0(0xAA1155) == 1 && bit0(0xAA1154) == 1 && dword(0xA9ECBC) == 198528 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54768 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 3600 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 523536 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 3600
                ) && trigger_when(bit0(0xA9F036) == 1) && trigger_when(byte(0xA9ED26) == 0)) ||
               (unless(dword(0xA64C74) != 1296714837) && unless(dword(0xA64C78) != 825570608) &&
                unless(byte(0xA64C7C) != 50) && never(low4(0xAA692C) == 0) && never(dword(0xACC534) != 0) &&
                never(byte(0xB9D284) != 1) &&
                once(byte(0xAA6876) == 5 && bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 &&
                    bit0(0xAA8CA6) == 1 && bit0(0xAA8CA5) == 1 && bit0(0xAA8CA4) == 1 && dword(0xAA680C) == 198528 &&
                    word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 54768 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 3600 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 523536 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 3600
                ) && trigger_when(bit0(0xAA6B86) == 1) && trigger_when(byte(0xAA6876) == 0)))
)

achievement(
    title = "The Philosopher's Destiny", points = 4, type="win_condition",
    description = "Achieve ending EX, by destroying the jewel",
    id = 405113, badge = "461652", published = "5/03/2024 21:15:30", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && dword(0xA9ECBC) == 686720 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 234736 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 16816 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 1315744 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 16816
                ) &&
                once(dword(0xA9ECBC) == 424256 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 53792 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 370416
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
                once(byte(0xAA6876) == 5 && bit0(0xAA6B8D) == 1 && dword(0xAA680C) == 686720 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 234736 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 16816 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 1315744 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 16816
                ) &&
                once(dword(0xAA680C) == 424256 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 53792 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 370416
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
    id = 405114, badge = "466036", published = "5/03/2024 21:15:30", modified = "5/04/2024 18:13:54",
    trigger = always_true() &&
              ((unless(dword(0xA5AB44) != 1398099029) && unless(dword(0xA5AB48) != 892612657) &&
                unless(byte(0xA5AB4C) != 57) && never(low4(0xA9EDDC) == 0) && never(dword(0xAC49F4) != 0) &&
                never(byte(0xB95704) != 1) &&
                once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && dword(0xA9ECBC) == 363520 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 157936 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 72640 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 467440 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 72640
                ) &&
                once(dword(0xA9ECBC) == 424256 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 53792 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 370416
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
                once(byte(0xAA6876) == 5 && bit0(0xAA6B8D) == 1 && dword(0xAA680C) == 363520 && word(0xAA6810) == 1 &&
                    word(0xAA6812) == 0 && dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 157936 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 72640 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000008) == 467440 &&
                    dword((dword(0xAA6824) & 0x1FFFFFF) + 0x000028) == 72640
                ) &&
                once(dword(0xAA680C) == 424256 && word(0xAA6810) == 1 && word(0xAA6812) == 0 &&
                    dword((dword(0xAA6818) & 0x1FFFFFF) + 0x000008) == 53792 &&
                    dword((dword(0xAA681C) & 0x1FFFFFF) + 0x000008) == 370416
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
    title = "Homing Instinct", points = 10, type="missable",
    description = "Reach 100% achievement rate for the Prologue, including the EX Chapter",
    id = 405087, badge = "466037", published = "5/03/2024 14:02:24", modified = "4/04/2024 20:12:32",
    trigger = always_true() &&
              (((prev(bit1(0xA9ED3C)) + prev(bit2(0xA9ED3C)) + prev(bit3(0xA9ED3C)) + prev(bit4(0xA9ED3C)) +
                prev(bit5(0xA9ED3C)) + prev(bit6(0xA9ED3C)) + prev(bit7(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) +
                prev(bitcount(0xA9ED3E)) + prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) +
                prev(bitcount(0xA9ED41)) + prev(bit0(0xA9ED42)) + prev(bit1(0xA9ED42)) + prev(bit2(0xA9ED42)) +
                prev(bit3(0xA9ED42)) + prev(bit4(0xA9ED42)) + prev(bit5(0xA9ED42))) < 53 &&
                measured((bit1(0xA9ED3C) + bit2(0xA9ED3C) + bit3(0xA9ED3C) + bit4(0xA9ED3C) + bit5(0xA9ED3C) +
                    bit6(0xA9ED3C) + bit7(0xA9ED3C) + bitcount(0xA9ED3D) + bitcount(0xA9ED3E) + bitcount(0xA9ED3F) +
                    bitcount(0xA9ED40) + bitcount(0xA9ED41) + bit0(0xA9ED42) + bit1(0xA9ED42) + bit2(0xA9ED42) +
                    bit3(0xA9ED42) + bit4(0xA9ED42) + bit5(0xA9ED42)) == 53,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 1, format="percent"
                )) ||
               ((prev(bit1(0xAA688C)) + prev(bit2(0xAA688C)) + prev(bit3(0xAA688C)) + prev(bit4(0xAA688C)) +
                prev(bit5(0xAA688C)) + prev(bit6(0xAA688C)) + prev(bit7(0xAA688C)) + prev(bitcount(0xAA688D)) +
                prev(bitcount(0xAA688E)) + prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) +
                prev(bitcount(0xAA6891)) + prev(bit0(0xAA6892)) + prev(bit1(0xAA6892)) + prev(bit2(0xAA6892)) +
                prev(bit3(0xAA6892)) + prev(bit4(0xAA6892)) + prev(bit5(0xAA6892))) < 53 &&
                measured((bit1(0xAA688C) + bit2(0xAA688C) + bit3(0xAA688C) + bit4(0xAA688C) + bit5(0xAA688C) +
                    bit6(0xAA688C) + bit7(0xAA688C) + bitcount(0xAA688D) + bitcount(0xAA688E) + bitcount(0xAA688F) +
                    bitcount(0xAA6890) + bitcount(0xAA6891) + bit0(0xAA6892) + bit1(0xAA6892) + bit2(0xAA6892) +
                    bit3(0xAA6892) + bit4(0xAA6892) + bit5(0xAA6892)) == 53,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 1, format="percent"
                )))
)

achievement(
    title = "In The Heat Of Time", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 1",
    id = 405088, badge = "466038", published = "5/03/2024 14:02:24", modified = "4/04/2024 20:12:32",
    trigger = always_true() &&
              (((prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) +
                prev(bit0(0xA9ED46)) + prev(bit1(0xA9ED46)) + prev(bit2(0xA9ED46)) + prev(bit3(0xA9ED46)) +
                prev(bit4(0xA9ED46)) + prev(bit5(0xA9ED46))) < 24 &&
                measured((bit6(0xA9ED43) + bit7(0xA9ED43) + bitcount(0xA9ED44) + bitcount(0xA9ED45) + bit0(0xA9ED46) +
                    bit1(0xA9ED46) + bit2(0xA9ED46) + bit3(0xA9ED46) + bit4(0xA9ED46) + bit5(0xA9ED46)) == 24,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 2, format="percent"
                )) ||
               ((prev(bit6(0xAA6893)) + prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) +
                prev(bit0(0xAA6896)) + prev(bit1(0xAA6896)) + prev(bit2(0xAA6896)) + prev(bit3(0xAA6896)) +
                prev(bit4(0xAA6896)) + prev(bit5(0xAA6896))) < 24 &&
                measured((bit6(0xAA6893) + bit7(0xAA6893) + bitcount(0xAA6894) + bitcount(0xAA6895) + bit0(0xAA6896) +
                    bit1(0xAA6896) + bit2(0xAA6896) + bit3(0xAA6896) + bit4(0xAA6896) + bit5(0xAA6896)) == 24,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 2, format="percent"
                )))
)

achievement(
    title = "Dana Kusch", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 2",
    id = 405089, badge = "466039", published = "5/03/2024 14:02:24", modified = "4/04/2024 20:12:32",
    trigger = always_true() &&
              (((prev(bit3(0xA9ED47)) + prev(bit4(0xA9ED47)) + prev(bit5(0xA9ED47)) + prev(bit6(0xA9ED47)) +
                prev(bit7(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) + prev(bitcount(0xA9ED4A)) +
                prev(bit0(0xA9ED4B)) + prev(bit1(0xA9ED4B)) + prev(bit2(0xA9ED4B)) + prev(bit3(0xA9ED4B)) +
                prev(bit4(0xA9ED4B)) + prev(bit5(0xA9ED4B)) + prev(bit6(0xA9ED4B))) < 36 &&
                measured((bit3(0xA9ED47) + bit4(0xA9ED47) + bit5(0xA9ED47) + bit6(0xA9ED47) + bit7(0xA9ED47) +
                    bitcount(0xA9ED48) + bitcount(0xA9ED49) + bitcount(0xA9ED4A) + bit0(0xA9ED4B) + bit1(0xA9ED4B) +
                    bit2(0xA9ED4B) + bit3(0xA9ED4B) + bit4(0xA9ED4B) + bit5(0xA9ED4B) + bit6(0xA9ED4B)) == 36,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 3, format="percent"
                )) ||
               ((prev(bit3(0xAA6897)) + prev(bit4(0xAA6897)) + prev(bit5(0xAA6897)) + prev(bit6(0xAA6897)) +
                prev(bit7(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) + prev(bitcount(0xAA689A)) +
                prev(bit0(0xAA689B)) + prev(bit1(0xAA689B)) + prev(bit2(0xAA689B)) + prev(bit3(0xAA689B)) +
                prev(bit4(0xAA689B)) + prev(bit5(0xAA689B)) + prev(bit6(0xAA689B))) < 36 &&
                measured((bit3(0xAA6897) + bit4(0xAA6897) + bit5(0xAA6897) + bit6(0xAA6897) + bit7(0xAA6897) +
                    bitcount(0xAA6898) + bitcount(0xAA6899) + bitcount(0xAA689A) + bit0(0xAA689B) + bit1(0xAA689B) +
                    bit2(0xAA689B) + bit3(0xAA689B) + bit4(0xAA689B) + bit5(0xAA689B) + bit6(0xAA689B)) == 36,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 3, format="percent"
                )))
)

achievement(
    title = "The Root Of The Problem", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 3",
    id = 405090, badge = "466040", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:12:32",
    trigger = always_true() &&
              (((prev(bit2(0xA9ED58)) + prev(bit3(0xA9ED58)) + prev(bit4(0xA9ED58)) + prev(bit5(0xA9ED58)) +
                prev(bit6(0xA9ED58)) + prev(bit7(0xA9ED58)) + prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A))) < 22 &&
                measured((bit2(0xA9ED58) + bit3(0xA9ED58) + bit4(0xA9ED58) + bit5(0xA9ED58) + bit6(0xA9ED58) +
                    bit7(0xA9ED58) + bitcount(0xA9ED59) + bitcount(0xA9ED5A)) == 22,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 4, format="percent"
                )) ||
               ((prev(bit2(0xAA68A8)) + prev(bit3(0xAA68A8)) + prev(bit4(0xAA68A8)) + prev(bit5(0xAA68A8)) +
                prev(bit6(0xAA68A8)) + prev(bit7(0xAA68A8)) + prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA))) < 22 &&
                measured((bit2(0xAA68A8) + bit3(0xAA68A8) + bit4(0xAA68A8) + bit5(0xAA68A8) + bit6(0xAA68A8) +
                    bit7(0xAA68A8) + bitcount(0xAA68A9) + bitcount(0xAA68AA)) == 22,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 4, format="percent"
                )))
)

achievement(
    title = "The Monochrome Era", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 4",
    id = 405091, badge = "466041", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:11:54",
    trigger = always_true() &&
              (((prev(bit1(0xA9ED4D)) + prev(bit2(0xA9ED4D)) + prev(bit3(0xA9ED4D)) + prev(bit4(0xA9ED4D)) +
                prev(bit5(0xA9ED4D)) + prev(bit6(0xA9ED4D)) + prev(bit7(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bit0(0xA9ED51)) + prev(bit1(0xA9ED51)) +
                prev(bit2(0xA9ED51)) + prev(bit3(0xA9ED51)) + prev(bit4(0xA9ED51))) < 36 &&
                measured((bit1(0xA9ED4D) + bit2(0xA9ED4D) + bit3(0xA9ED4D) + bit4(0xA9ED4D) + bit5(0xA9ED4D) +
                    bit6(0xA9ED4D) + bit7(0xA9ED4D) + bitcount(0xA9ED4E) + bitcount(0xA9ED4F) + bitcount(0xA9ED50) +
                    bit0(0xA9ED51) + bit1(0xA9ED51) + bit2(0xA9ED51) + bit3(0xA9ED51) + bit4(0xA9ED51)) == 36,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 5, format="percent"
                )) ||
               ((prev(bit1(0xAA689D)) + prev(bit2(0xAA689D)) + prev(bit3(0xAA689D)) + prev(bit4(0xAA689D)) +
                prev(bit5(0xAA689D)) + prev(bit6(0xAA689D)) + prev(bit7(0xAA689D)) + prev(bitcount(0xAA689E)) +
                prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bit0(0xAA68A1)) + prev(bit1(0xAA68A1)) +
                prev(bit2(0xAA68A1)) + prev(bit3(0xAA68A1)) + prev(bit4(0xAA68A1))) < 36 &&
                measured((bit1(0xAA689D) + bit2(0xAA689D) + bit3(0xAA689D) + bit4(0xAA689D) + bit5(0xAA689D) +
                    bit6(0xAA689D) + bit7(0xAA689D) + bitcount(0xAA689E) + bitcount(0xAA689F) + bitcount(0xAA68A0) +
                    bit0(0xAA68A1) + bit1(0xAA68A1) + bit2(0xAA68A1) + bit3(0xAA68A1) + bit4(0xAA68A1)) == 36,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 5, format="percent"
                )))
)

achievement(
    title = "Meddling With Destiny", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 5",
    id = 405092, badge = "466042", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:11:54",
    trigger = always_true() &&
              (((prev(bit1(0xA9ED52)) + prev(bit2(0xA9ED52)) + prev(bit3(0xA9ED52)) + prev(bit4(0xA9ED52)) +
                prev(bit5(0xA9ED52)) + prev(bit6(0xA9ED52)) + prev(bit7(0xA9ED52)) + prev(bitcount(0xA9ED53)) +
                prev(bitcount(0xA9ED54)) + prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bit0(0xA9ED57)) +
                prev(bit1(0xA9ED57)) + prev(bit2(0xA9ED57)) + prev(bit3(0xA9ED57)) + prev(bit4(0xA9ED57)) +
                prev(bit5(0xA9ED57)) + prev(bit6(0xA9ED57))) < 46 &&
                measured((bit1(0xA9ED52) + bit2(0xA9ED52) + bit3(0xA9ED52) + bit4(0xA9ED52) + bit5(0xA9ED52) +
                    bit6(0xA9ED52) + bit7(0xA9ED52) + bitcount(0xA9ED53) + bitcount(0xA9ED54) + bitcount(0xA9ED55) +
                    bitcount(0xA9ED56) + bit0(0xA9ED57) + bit1(0xA9ED57) + bit2(0xA9ED57) + bit3(0xA9ED57) + bit4(0xA9ED57)
                    + bit5(0xA9ED57) + bit6(0xA9ED57)) == 46,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 6, format="percent"
                )) ||
               ((prev(bit1(0xAA68A2)) + prev(bit2(0xAA68A2)) + prev(bit3(0xAA68A2)) + prev(bit4(0xAA68A2)) +
                prev(bit5(0xAA68A2)) + prev(bit6(0xAA68A2)) + prev(bit7(0xAA68A2)) + prev(bitcount(0xAA68A3)) +
                prev(bitcount(0xAA68A4)) + prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bit0(0xAA68A7)) +
                prev(bit1(0xAA68A7)) + prev(bit2(0xAA68A7)) + prev(bit3(0xAA68A7)) + prev(bit4(0xAA68A7)) +
                prev(bit5(0xAA68A7)) + prev(bit6(0xAA68A7))) < 46 &&
                measured((bit1(0xAA68A2) + bit2(0xAA68A2) + bit3(0xAA68A2) + bit4(0xAA68A2) + bit5(0xAA68A2) +
                    bit6(0xAA68A2) + bit7(0xAA68A2) + bitcount(0xAA68A3) + bitcount(0xAA68A4) + bitcount(0xAA68A5) +
                    bitcount(0xAA68A6) + bit0(0xAA68A7) + bit1(0xAA68A7) + bit2(0xAA68A7) + bit3(0xAA68A7) + bit4(0xAA68A7)
                    + bit5(0xAA68A7) + bit6(0xAA68A7)) == 46,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 6, format="percent"
                )))
)

achievement(
    title = "The Good Samaritan", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 6",
    id = 405093, badge = "466043", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:11:53",
    trigger = always_true() &&
              (((prev(bit2(0xA9ED5B)) + prev(bit3(0xA9ED5B)) + prev(bit4(0xA9ED5B)) + prev(bit5(0xA9ED5B)) +
                prev(bit6(0xA9ED5B)) + prev(bit7(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) + prev(bitcount(0xA9ED5D)) +
                prev(bitcount(0xA9ED5E)) + prev(bit0(0xA9ED5F)) + prev(bit1(0xA9ED5F)) + prev(bit2(0xA9ED5F)) +
                prev(bit3(0xA9ED5F)) + prev(bit4(0xA9ED5F))) < 35 &&
                measured((bit2(0xA9ED5B) + bit3(0xA9ED5B) + bit4(0xA9ED5B) + bit5(0xA9ED5B) + bit6(0xA9ED5B) +
                    bit7(0xA9ED5B) + bitcount(0xA9ED5C) + bitcount(0xA9ED5D) + bitcount(0xA9ED5E) + bit0(0xA9ED5F) +
                    bit1(0xA9ED5F) + bit2(0xA9ED5F) + bit3(0xA9ED5F) + bit4(0xA9ED5F)) == 35,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 7, format="percent"
                )) ||
               ((prev(bit2(0xAA68AB)) + prev(bit3(0xAA68AB)) + prev(bit4(0xAA68AB)) + prev(bit5(0xAA68AB)) +
                prev(bit6(0xAA68AB)) + prev(bit7(0xAA68AB)) + prev(bitcount(0xAA68AC)) + prev(bitcount(0xAA68AD)) +
                prev(bitcount(0xAA68AE)) + prev(bit0(0xAA68AF)) + prev(bit1(0xAA68AF)) + prev(bit2(0xAA68AF)) +
                prev(bit3(0xAA68AF)) + prev(bit4(0xAA68AF))) < 35 &&
                measured((bit2(0xAA68AB) + bit3(0xAA68AB) + bit4(0xAA68AB) + bit5(0xAA68AB) + bit6(0xAA68AB) +
                    bit7(0xAA68AB) + bitcount(0xAA68AC) + bitcount(0xAA68AD) + bitcount(0xAA68AE) + bit0(0xAA68AF) +
                    bit1(0xAA68AF) + bit2(0xAA68AF) + bit3(0xAA68AF) + bit4(0xAA68AF)) == 35,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 7, format="percent"
                )))
)

achievement(
    title = "Vintage Knots", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 7",
    id = 405094, badge = "466044", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:11:53",
    trigger = always_true() &&
              (((prev(bit2(0xA9ED60)) + prev(bit3(0xA9ED60)) + prev(bit4(0xA9ED60)) + prev(bit5(0xA9ED60)) +
                prev(bit6(0xA9ED60)) + prev(bit7(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) +
                prev(bitcount(0xA9ED63)) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
                prev(bit3(0xA9ED64))) < 34 &&
                measured((bit2(0xA9ED60) + bit3(0xA9ED60) + bit4(0xA9ED60) + bit5(0xA9ED60) + bit6(0xA9ED60) +
                    bit7(0xA9ED60) + bitcount(0xA9ED61) + bitcount(0xA9ED62) + bitcount(0xA9ED63) + bit0(0xA9ED64) +
                    bit1(0xA9ED64) + bit2(0xA9ED64) + bit3(0xA9ED64)) == 34,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if(byte(0xB95704) == 8, format="percent"
                )) ||
               ((prev(bit2(0xAA68B0)) + prev(bit3(0xAA68B0)) + prev(bit4(0xAA68B0)) + prev(bit5(0xAA68B0)) +
                prev(bit6(0xAA68B0)) + prev(bit7(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) +
                prev(bitcount(0xAA68B3)) + prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) +
                prev(bit3(0xAA68B4))) < 34 &&
                measured((bit2(0xAA68B0) + bit3(0xAA68B0) + bit4(0xAA68B0) + bit5(0xAA68B0) + bit6(0xAA68B0) +
                    bit7(0xAA68B0) + bitcount(0xAA68B1) + bitcount(0xAA68B2) + bitcount(0xAA68B3) + bit0(0xAA68B4) +
                    bit1(0xAA68B4) + bit2(0xAA68B4) + bit3(0xAA68B4)) == 34,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if(byte(0xB9D284) == 8, format="percent"
                )))
)

achievement(
    title = "The Power Of Fate", points = 10, type="missable",
    description = "Reach 100% achievement rate for Chapter 8",
    id = 405095, badge = "466045", published = "5/03/2024 14:02:25", modified = "4/04/2024 20:11:53",
    trigger = always_true() &&
              (((prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) +
                prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) +
                prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) +
                prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) +
                prev(bit3(0xA9ED6E))) < 71 &&
                measured((bit5(0xA9ED65) + bit6(0xA9ED65) + bit7(0xA9ED65) + bitcount(0xA9ED66) + bitcount(0xA9ED67) +
                    bitcount(0xA9ED68) + bitcount(0xA9ED69) + bitcount(0xA9ED6A) + bitcount(0xA9ED6B) + bitcount(0xA9ED6C) +
                    bitcount(0xA9ED6D) + bit0(0xA9ED6E) + bit1(0xA9ED6E) + bit2(0xA9ED6E) + bit3(0xA9ED6E)) == 71,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if((byte(0xB95704) == 11 || byte(0xB95704) == 9), format="percent"
                )) ||
               ((prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) +
                prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) +
                prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) +
                prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) +
                prev(bit3(0xAA68BE))) < 71 &&
                measured((bit5(0xAA68B5) + bit6(0xAA68B5) + bit7(0xAA68B5) + bitcount(0xAA68B6) + bitcount(0xAA68B7) +
                    bitcount(0xAA68B8) + bitcount(0xAA68B9) + bitcount(0xAA68BA) + bitcount(0xAA68BB) + bitcount(0xAA68BC) +
                    bitcount(0xAA68BD) + bit0(0xAA68BE) + bit1(0xAA68BE) + bit2(0xAA68BE) + bit3(0xAA68BE)) == 71,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if((byte(0xB9D284) == 11 || byte(0xB9D284) == 9), format="percent"
                )))
)

achievement(
    title = "Eternal Youth", points = 10, type="missable",
    description = "Reach 100% achievement rate for the Epilogue",
    id = 405096, badge = "466046", published = "5/03/2024 14:02:34", modified = "4/04/2024 20:11:53",
    trigger = always_true() &&
              (((prev(bit2(0xA9ED71)) + prev(bit3(0xA9ED71)) + prev(bit4(0xA9ED71)) + prev(bit5(0xA9ED71)) +
                prev(bit6(0xA9ED71)) + prev(bit7(0xA9ED71)) + prev(bitcount(0xA9ED72)) + prev(bitcount(0xA9ED73)) +
                prev(bit0(0xA9ED74))) < 23 &&
                measured((bit2(0xA9ED71) + bit3(0xA9ED71) + bit4(0xA9ED71) + bit5(0xA9ED71) + bit6(0xA9ED71) +
                    bit7(0xA9ED71) + bitcount(0xA9ED72) + bitcount(0xA9ED73) + bit0(0xA9ED74)) == 23,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0 &&
                         measured_if((byte(0xB95704) == 12 || byte(0xB95704) == 10), format="percent"
                )) ||
               ((prev(bit2(0xAA68C1)) + prev(bit3(0xAA68C1)) + prev(bit4(0xAA68C1)) + prev(bit5(0xAA68C1)) +
                prev(bit6(0xAA68C1)) + prev(bit7(0xAA68C1)) + prev(bitcount(0xAA68C2)) + prev(bitcount(0xAA68C3)) +
                prev(bit0(0xAA68C4))) < 23 &&
                measured((bit2(0xAA68C1) + bit3(0xAA68C1) + bit4(0xAA68C1) + bit5(0xAA68C1) + bit6(0xAA68C1) +
                    bit7(0xAA68C1) + bitcount(0xAA68C2) + bitcount(0xAA68C3) + bit0(0xAA68C4)) == 23,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0 &&
                         measured_if((byte(0xB9D284) == 12 || byte(0xB9D284) == 10), format="percent"
                )))
)

achievement(
    title = "The Day Of Walpurgis", points = 50, type="missable",
    description = "Reach 100% total achievement rate",
    id = 405097, badge = "466047", published = "5/03/2024 14:02:34", modified = "4/04/2024 20:11:53",
    trigger = always_true() &&
              (((prev(bit1(0xA9ED3C)) + prev(bit2(0xA9ED3C)) + prev(bit3(0xA9ED3C)) + prev(bit4(0xA9ED3C)) +
                prev(bit5(0xA9ED3C)) + prev(bit6(0xA9ED3C)) + prev(bit7(0xA9ED3C)) + prev(bitcount(0xA9ED3D)) +
                prev(bitcount(0xA9ED3E)) + prev(bitcount(0xA9ED3F)) + prev(bitcount(0xA9ED40)) +
                prev(bitcount(0xA9ED41)) + prev(bit0(0xA9ED42)) + prev(bit1(0xA9ED42)) + prev(bit2(0xA9ED42)) +
                prev(bit3(0xA9ED42)) + prev(bit4(0xA9ED42)) + prev(bit5(0xA9ED42)) + prev(bit6(0xA9ED43)) +
                prev(bit7(0xA9ED43)) + prev(bitcount(0xA9ED44)) + prev(bitcount(0xA9ED45)) + prev(bit0(0xA9ED46)) +
                prev(bit1(0xA9ED46)) + prev(bit2(0xA9ED46)) + prev(bit3(0xA9ED46)) + prev(bit4(0xA9ED46)) +
                prev(bit5(0xA9ED46)) + prev(bit3(0xA9ED47)) + prev(bit4(0xA9ED47)) + prev(bit5(0xA9ED47)) +
                prev(bit6(0xA9ED47)) + prev(bit7(0xA9ED47)) + prev(bitcount(0xA9ED48)) + prev(bitcount(0xA9ED49)) +
                prev(bitcount(0xA9ED4A)) + prev(bit0(0xA9ED4B)) + prev(bit1(0xA9ED4B)) + prev(bit2(0xA9ED4B)) +
                prev(bit3(0xA9ED4B)) + prev(bit4(0xA9ED4B)) + prev(bit5(0xA9ED4B)) + prev(bit6(0xA9ED4B)) +
                prev(bit2(0xA9ED58)) + prev(bit3(0xA9ED58)) + prev(bit4(0xA9ED58)) + prev(bit5(0xA9ED58)) +
                prev(bit6(0xA9ED58)) + prev(bit7(0xA9ED58)) + prev(bitcount(0xA9ED59)) + prev(bitcount(0xA9ED5A)) +
                prev(bit1(0xA9ED4D)) + prev(bit2(0xA9ED4D)) + prev(bit3(0xA9ED4D)) + prev(bit4(0xA9ED4D)) +
                prev(bit5(0xA9ED4D)) + prev(bit6(0xA9ED4D)) + prev(bit7(0xA9ED4D)) + prev(bitcount(0xA9ED4E)) +
                prev(bitcount(0xA9ED4F)) + prev(bitcount(0xA9ED50)) + prev(bit0(0xA9ED51)) + prev(bit1(0xA9ED51)) +
                prev(bit2(0xA9ED51)) + prev(bit3(0xA9ED51)) + prev(bit4(0xA9ED51)) + prev(bit1(0xA9ED52)) +
                prev(bit2(0xA9ED52)) + prev(bit3(0xA9ED52)) + prev(bit4(0xA9ED52)) + prev(bit5(0xA9ED52)) +
                prev(bit6(0xA9ED52)) + prev(bit7(0xA9ED52)) + prev(bitcount(0xA9ED53)) + prev(bitcount(0xA9ED54)) +
                prev(bitcount(0xA9ED55)) + prev(bitcount(0xA9ED56)) + prev(bit0(0xA9ED57)) + prev(bit1(0xA9ED57)) +
                prev(bit2(0xA9ED57)) + prev(bit3(0xA9ED57)) + prev(bit4(0xA9ED57)) + prev(bit5(0xA9ED57)) +
                prev(bit6(0xA9ED57)) + prev(bit2(0xA9ED5B)) + prev(bit3(0xA9ED5B)) + prev(bit4(0xA9ED5B)) +
                prev(bit5(0xA9ED5B)) + prev(bit6(0xA9ED5B)) + prev(bit7(0xA9ED5B)) + prev(bitcount(0xA9ED5C)) +
                prev(bitcount(0xA9ED5D)) + prev(bitcount(0xA9ED5E)) + prev(bit0(0xA9ED5F)) + prev(bit1(0xA9ED5F)) +
                prev(bit2(0xA9ED5F)) + prev(bit3(0xA9ED5F)) + prev(bit4(0xA9ED5F)) + prev(bit2(0xA9ED60)) +
                prev(bit3(0xA9ED60)) + prev(bit4(0xA9ED60)) + prev(bit5(0xA9ED60)) + prev(bit6(0xA9ED60)) +
                prev(bit7(0xA9ED60)) + prev(bitcount(0xA9ED61)) + prev(bitcount(0xA9ED62)) + prev(bitcount(0xA9ED63)) +
                prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + prev(bit3(0xA9ED64)) +
                prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(bitcount(0xA9ED66)) +
                prev(bitcount(0xA9ED67)) + prev(bitcount(0xA9ED68)) + prev(bitcount(0xA9ED69)) +
                prev(bitcount(0xA9ED6A)) + prev(bitcount(0xA9ED6B)) + prev(bitcount(0xA9ED6C)) +
                prev(bitcount(0xA9ED6D)) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) +
                prev(bit3(0xA9ED6E)) + prev(bit2(0xA9ED71)) + prev(bit3(0xA9ED71)) + prev(bit4(0xA9ED71)) +
                prev(bit5(0xA9ED71)) + prev(bit6(0xA9ED71)) + prev(bit7(0xA9ED71)) + prev(bitcount(0xA9ED72)) +
                prev(bitcount(0xA9ED73)) + prev(bit0(0xA9ED74))) < 380 &&
                measured((bit1(0xA9ED3C) + bit2(0xA9ED3C) + bit3(0xA9ED3C) + bit4(0xA9ED3C) + bit5(0xA9ED3C) +
                    bit6(0xA9ED3C) + bit7(0xA9ED3C) + bitcount(0xA9ED3D) + bitcount(0xA9ED3E) + bitcount(0xA9ED3F) +
                    bitcount(0xA9ED40) + bitcount(0xA9ED41) + bit0(0xA9ED42) + bit1(0xA9ED42) + bit2(0xA9ED42) +
                    bit3(0xA9ED42) + bit4(0xA9ED42) + bit5(0xA9ED42) + bit6(0xA9ED43) + bit7(0xA9ED43) + bitcount(0xA9ED44)
                    + bitcount(0xA9ED45) + bit0(0xA9ED46) + bit1(0xA9ED46) + bit2(0xA9ED46) + bit3(0xA9ED46) +
                    bit4(0xA9ED46) + bit5(0xA9ED46) + bit3(0xA9ED47) + bit4(0xA9ED47) + bit5(0xA9ED47) + bit6(0xA9ED47) +
                    bit7(0xA9ED47) + bitcount(0xA9ED48) + bitcount(0xA9ED49) + bitcount(0xA9ED4A) + bit0(0xA9ED4B) +
                    bit1(0xA9ED4B) + bit2(0xA9ED4B) + bit3(0xA9ED4B) + bit4(0xA9ED4B) + bit5(0xA9ED4B) + bit6(0xA9ED4B) +
                    bit2(0xA9ED58) + bit3(0xA9ED58) + bit4(0xA9ED58) + bit5(0xA9ED58) + bit6(0xA9ED58) + bit7(0xA9ED58) +
                    bitcount(0xA9ED59) + bitcount(0xA9ED5A) + bit1(0xA9ED4D) + bit2(0xA9ED4D) + bit3(0xA9ED4D) +
                    bit4(0xA9ED4D) + bit5(0xA9ED4D) + bit6(0xA9ED4D) + bit7(0xA9ED4D) + bitcount(0xA9ED4E) +
                    bitcount(0xA9ED4F) + bitcount(0xA9ED50) + bit0(0xA9ED51) + bit1(0xA9ED51) + bit2(0xA9ED51) +
                    bit3(0xA9ED51) + bit4(0xA9ED51) + bit1(0xA9ED52) + bit2(0xA9ED52) + bit3(0xA9ED52) + bit4(0xA9ED52) +
                    bit5(0xA9ED52) + bit6(0xA9ED52) + bit7(0xA9ED52) + bitcount(0xA9ED53) + bitcount(0xA9ED54) +
                    bitcount(0xA9ED55) + bitcount(0xA9ED56) + bit0(0xA9ED57) + bit1(0xA9ED57) + bit2(0xA9ED57) +
                    bit3(0xA9ED57) + bit4(0xA9ED57) + bit5(0xA9ED57) + bit6(0xA9ED57) + bit2(0xA9ED5B) + bit3(0xA9ED5B) +
                    bit4(0xA9ED5B) + bit5(0xA9ED5B) + bit6(0xA9ED5B) + bit7(0xA9ED5B) + bitcount(0xA9ED5C) +
                    bitcount(0xA9ED5D) + bitcount(0xA9ED5E) + bit0(0xA9ED5F) + bit1(0xA9ED5F) + bit2(0xA9ED5F) +
                    bit3(0xA9ED5F) + bit4(0xA9ED5F) + bit2(0xA9ED60) + bit3(0xA9ED60) + bit4(0xA9ED60) + bit5(0xA9ED60) +
                    bit6(0xA9ED60) + bit7(0xA9ED60) + bitcount(0xA9ED61) + bitcount(0xA9ED62) + bitcount(0xA9ED63) +
                    bit0(0xA9ED64) + bit1(0xA9ED64) + bit2(0xA9ED64) + bit3(0xA9ED64) + bit5(0xA9ED65) + bit6(0xA9ED65) +
                    bit7(0xA9ED65) + bitcount(0xA9ED66) + bitcount(0xA9ED67) + bitcount(0xA9ED68) + bitcount(0xA9ED69) +
                    bitcount(0xA9ED6A) + bitcount(0xA9ED6B) + bitcount(0xA9ED6C) + bitcount(0xA9ED6D) + bit0(0xA9ED6E) +
                    bit1(0xA9ED6E) + bit2(0xA9ED6E) + bit3(0xA9ED6E) + bit2(0xA9ED71) + bit3(0xA9ED71) + bit4(0xA9ED71) +
                    bit5(0xA9ED71) + bit6(0xA9ED71) + bit7(0xA9ED71) + bitcount(0xA9ED72) + bitcount(0xA9ED73) +
                    bit0(0xA9ED74)) == 380,
                    when=dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 &&
                         measured_if(byte(0xA5AB4C) == 57 && low4(0xA9EDDC) != 0 && dword(0xAC49F4) == 0, format="percent"
                )) ||
               ((prev(bit1(0xAA688C)) + prev(bit2(0xAA688C)) + prev(bit3(0xAA688C)) + prev(bit4(0xAA688C)) +
                prev(bit5(0xAA688C)) + prev(bit6(0xAA688C)) + prev(bit7(0xAA688C)) + prev(bitcount(0xAA688D)) +
                prev(bitcount(0xAA688E)) + prev(bitcount(0xAA688F)) + prev(bitcount(0xAA6890)) +
                prev(bitcount(0xAA6891)) + prev(bit0(0xAA6892)) + prev(bit1(0xAA6892)) + prev(bit2(0xAA6892)) +
                prev(bit3(0xAA6892)) + prev(bit4(0xAA6892)) + prev(bit5(0xAA6892)) + prev(bit6(0xAA6893)) +
                prev(bit7(0xAA6893)) + prev(bitcount(0xAA6894)) + prev(bitcount(0xAA6895)) + prev(bit0(0xAA6896)) +
                prev(bit1(0xAA6896)) + prev(bit2(0xAA6896)) + prev(bit3(0xAA6896)) + prev(bit4(0xAA6896)) +
                prev(bit5(0xAA6896)) + prev(bit3(0xAA6897)) + prev(bit4(0xAA6897)) + prev(bit5(0xAA6897)) +
                prev(bit6(0xAA6897)) + prev(bit7(0xAA6897)) + prev(bitcount(0xAA6898)) + prev(bitcount(0xAA6899)) +
                prev(bitcount(0xAA689A)) + prev(bit0(0xAA689B)) + prev(bit1(0xAA689B)) + prev(bit2(0xAA689B)) +
                prev(bit3(0xAA689B)) + prev(bit4(0xAA689B)) + prev(bit5(0xAA689B)) + prev(bit6(0xAA689B)) +
                prev(bit2(0xAA68A8)) + prev(bit3(0xAA68A8)) + prev(bit4(0xAA68A8)) + prev(bit5(0xAA68A8)) +
                prev(bit6(0xAA68A8)) + prev(bit7(0xAA68A8)) + prev(bitcount(0xAA68A9)) + prev(bitcount(0xAA68AA)) +
                prev(bit1(0xAA689D)) + prev(bit2(0xAA689D)) + prev(bit3(0xAA689D)) + prev(bit4(0xAA689D)) +
                prev(bit5(0xAA689D)) + prev(bit6(0xAA689D)) + prev(bit7(0xAA689D)) + prev(bitcount(0xAA689E)) +
                prev(bitcount(0xAA689F)) + prev(bitcount(0xAA68A0)) + prev(bit0(0xAA68A1)) + prev(bit1(0xAA68A1)) +
                prev(bit2(0xAA68A1)) + prev(bit3(0xAA68A1)) + prev(bit4(0xAA68A1)) + prev(bit1(0xAA68A2)) +
                prev(bit2(0xAA68A2)) + prev(bit3(0xAA68A2)) + prev(bit4(0xAA68A2)) + prev(bit5(0xAA68A2)) +
                prev(bit6(0xAA68A2)) + prev(bit7(0xAA68A2)) + prev(bitcount(0xAA68A3)) + prev(bitcount(0xAA68A4)) +
                prev(bitcount(0xAA68A5)) + prev(bitcount(0xAA68A6)) + prev(bit0(0xAA68A7)) + prev(bit1(0xAA68A7)) +
                prev(bit2(0xAA68A7)) + prev(bit3(0xAA68A7)) + prev(bit4(0xAA68A7)) + prev(bit5(0xAA68A7)) +
                prev(bit6(0xAA68A7)) + prev(bit2(0xAA68AB)) + prev(bit3(0xAA68AB)) + prev(bit4(0xAA68AB)) +
                prev(bit5(0xAA68AB)) + prev(bit6(0xAA68AB)) + prev(bit7(0xAA68AB)) + prev(bitcount(0xAA68AC)) +
                prev(bitcount(0xAA68AD)) + prev(bitcount(0xAA68AE)) + prev(bit0(0xAA68AF)) + prev(bit1(0xAA68AF)) +
                prev(bit2(0xAA68AF)) + prev(bit3(0xAA68AF)) + prev(bit4(0xAA68AF)) + prev(bit2(0xAA68B0)) +
                prev(bit3(0xAA68B0)) + prev(bit4(0xAA68B0)) + prev(bit5(0xAA68B0)) + prev(bit6(0xAA68B0)) +
                prev(bit7(0xAA68B0)) + prev(bitcount(0xAA68B1)) + prev(bitcount(0xAA68B2)) + prev(bitcount(0xAA68B3)) +
                prev(bit0(0xAA68B4)) + prev(bit1(0xAA68B4)) + prev(bit2(0xAA68B4)) + prev(bit3(0xAA68B4)) +
                prev(bit5(0xAA68B5)) + prev(bit6(0xAA68B5)) + prev(bit7(0xAA68B5)) + prev(bitcount(0xAA68B6)) +
                prev(bitcount(0xAA68B7)) + prev(bitcount(0xAA68B8)) + prev(bitcount(0xAA68B9)) +
                prev(bitcount(0xAA68BA)) + prev(bitcount(0xAA68BB)) + prev(bitcount(0xAA68BC)) +
                prev(bitcount(0xAA68BD)) + prev(bit0(0xAA68BE)) + prev(bit1(0xAA68BE)) + prev(bit2(0xAA68BE)) +
                prev(bit3(0xAA68BE)) + prev(bit2(0xAA68C1)) + prev(bit3(0xAA68C1)) + prev(bit4(0xAA68C1)) +
                prev(bit5(0xAA68C1)) + prev(bit6(0xAA68C1)) + prev(bit7(0xAA68C1)) + prev(bitcount(0xAA68C2)) +
                prev(bitcount(0xAA68C3)) + prev(bit0(0xAA68C4))) < 380 &&
                measured((bit1(0xAA688C) + bit2(0xAA688C) + bit3(0xAA688C) + bit4(0xAA688C) + bit5(0xAA688C) +
                    bit6(0xAA688C) + bit7(0xAA688C) + bitcount(0xAA688D) + bitcount(0xAA688E) + bitcount(0xAA688F) +
                    bitcount(0xAA6890) + bitcount(0xAA6891) + bit0(0xAA6892) + bit1(0xAA6892) + bit2(0xAA6892) +
                    bit3(0xAA6892) + bit4(0xAA6892) + bit5(0xAA6892) + bit6(0xAA6893) + bit7(0xAA6893) + bitcount(0xAA6894)
                    + bitcount(0xAA6895) + bit0(0xAA6896) + bit1(0xAA6896) + bit2(0xAA6896) + bit3(0xAA6896) +
                    bit4(0xAA6896) + bit5(0xAA6896) + bit3(0xAA6897) + bit4(0xAA6897) + bit5(0xAA6897) + bit6(0xAA6897) +
                    bit7(0xAA6897) + bitcount(0xAA6898) + bitcount(0xAA6899) + bitcount(0xAA689A) + bit0(0xAA689B) +
                    bit1(0xAA689B) + bit2(0xAA689B) + bit3(0xAA689B) + bit4(0xAA689B) + bit5(0xAA689B) + bit6(0xAA689B) +
                    bit2(0xAA68A8) + bit3(0xAA68A8) + bit4(0xAA68A8) + bit5(0xAA68A8) + bit6(0xAA68A8) + bit7(0xAA68A8) +
                    bitcount(0xAA68A9) + bitcount(0xAA68AA) + bit1(0xAA689D) + bit2(0xAA689D) + bit3(0xAA689D) +
                    bit4(0xAA689D) + bit5(0xAA689D) + bit6(0xAA689D) + bit7(0xAA689D) + bitcount(0xAA689E) +
                    bitcount(0xAA689F) + bitcount(0xAA68A0) + bit0(0xAA68A1) + bit1(0xAA68A1) + bit2(0xAA68A1) +
                    bit3(0xAA68A1) + bit4(0xAA68A1) + bit1(0xAA68A2) + bit2(0xAA68A2) + bit3(0xAA68A2) + bit4(0xAA68A2) +
                    bit5(0xAA68A2) + bit6(0xAA68A2) + bit7(0xAA68A2) + bitcount(0xAA68A3) + bitcount(0xAA68A4) +
                    bitcount(0xAA68A5) + bitcount(0xAA68A6) + bit0(0xAA68A7) + bit1(0xAA68A7) + bit2(0xAA68A7) +
                    bit3(0xAA68A7) + bit4(0xAA68A7) + bit5(0xAA68A7) + bit6(0xAA68A7) + bit2(0xAA68AB) + bit3(0xAA68AB) +
                    bit4(0xAA68AB) + bit5(0xAA68AB) + bit6(0xAA68AB) + bit7(0xAA68AB) + bitcount(0xAA68AC) +
                    bitcount(0xAA68AD) + bitcount(0xAA68AE) + bit0(0xAA68AF) + bit1(0xAA68AF) + bit2(0xAA68AF) +
                    bit3(0xAA68AF) + bit4(0xAA68AF) + bit2(0xAA68B0) + bit3(0xAA68B0) + bit4(0xAA68B0) + bit5(0xAA68B0) +
                    bit6(0xAA68B0) + bit7(0xAA68B0) + bitcount(0xAA68B1) + bitcount(0xAA68B2) + bitcount(0xAA68B3) +
                    bit0(0xAA68B4) + bit1(0xAA68B4) + bit2(0xAA68B4) + bit3(0xAA68B4) + bit5(0xAA68B5) + bit6(0xAA68B5) +
                    bit7(0xAA68B5) + bitcount(0xAA68B6) + bitcount(0xAA68B7) + bitcount(0xAA68B8) + bitcount(0xAA68B9) +
                    bitcount(0xAA68BA) + bitcount(0xAA68BB) + bitcount(0xAA68BC) + bitcount(0xAA68BD) + bit0(0xAA68BE) +
                    bit1(0xAA68BE) + bit2(0xAA68BE) + bit3(0xAA68BE) + bit2(0xAA68C1) + bit3(0xAA68C1) + bit4(0xAA68C1) +
                    bit5(0xAA68C1) + bit6(0xAA68C1) + bit7(0xAA68C1) + bitcount(0xAA68C2) + bitcount(0xAA68C3) +
                    bit0(0xAA68C4)) == 380,
                    when=dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 &&
                         measured_if(byte(0xA64C7C) == 50 && low4(0xAA692C) != 0 && dword(0xACC534) == 0, format="percent"
                )))
)

leaderboard(
    id = 92194, title = "Total Clear Time",
    description = "Race through time to achieve the fastest total clear time (EX chapter excluded)",
    start  = always_true() &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               low4(0xA9EDDC) != 0 && (byte(0xB95704) == 12 || byte(0xB95704) == 10) &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               low4(0xAA692C) != 0 && (byte(0xB9D284) == 12 || byte(0xB9D284) == 10) &&
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
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 1 && bit7(0xA9ED98) == 0 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 1 && bit7(0xAA68E8) == 0 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 1 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 2 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 2 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 2 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 3 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 3 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 3 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 4 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 4 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 4 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 5 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 5 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 5 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 6 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 6 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 6 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 7 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 7 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 7 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 8 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 8 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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
    description = "Prove your mastery over time by conquering Chapter 8 in record time",
    start  = dword(0x1FFF5F8) == 1 && prev(dword(0x1FFF5F8)) != 1 && dword(0x1FFF5F4) == 33 &&
             prev(dword(0x1FFF5F4)) != 33 &&
             ((dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 11 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA5AB44) == 1398099029 && dword(0xA5AB48) == 892612657 && byte(0xA5AB4C) == 57 &&
               byte(0xB95704) == 9 && bit0(0xA82E2C) > prior(bit0(0xA82E2C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 11 && bit0(0xA8A97C) > prior(bit0(0xA8A97C))) ||
              (dword(0xA64C74) == 1296714837 && dword(0xA64C78) == 825570608 && byte(0xA64C7C) == 50 &&
               byte(0xB9D284) == 9 && bit0(0xA8A97C) > prior(bit0(0xA8A97C)))),
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

rich_presence_conditional_display(low4(0xA9EDDC) != 0 && bit7(0xA9ED98) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1156) == 1 &&
    bit0(0xAA1155) == 1 && bit0(0xAA1154) == 1 && dword(0xAC49F4) == 0 && byte(0xB95704) == 1, "Ending the cycle | The Fated 🕑 {0} | Current 📆 {1} April {2} 🕑 {3} | Completion: {4}%",
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA12AC)),
    rich_presence_value("Number", dword(0xAA12A4)),
    rich_presence_value("Minutes", dword(0xAA12B4) + dword(0xAA12B0) * 60, format="MINUTES"),
    rich_presence_value("Number", byte(0xAA1152))
)

rich_presence_conditional_display(low4(0xA9EDDC) != 0 && bit7(0xA9ED98) == 0 && dword(0xAC49F4) == 0 && byte(0xB95704) != 0 && byte(0xB95704) <= 11 &&
    ((byte(0xB95704) == 1) ||
     (byte(0xB95704) == 2) ||
     (byte(0xB95704) == 12) ||
     (byte(0xB95704) == 10)), "{0} | The Fated 🕑 {1} | Current 📆 {2} April {3} 🕑 {4} | Completion: {5}%",
    rich_presence_lookup("Chapter", byte(0xB95704), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA12AC)),
    rich_presence_value("Number", dword(0xAA12A4)),
    rich_presence_value("Minutes", dword(0xAA12B4) + dword(0xAA12B0) * 60, format="MINUTES"),
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
     (byte(0xB95704) == 9)), "{0} {1} | The Fated 🕑 {2} | Current 📆 {3} April {4} 🕑 {5} | Completion: {6}%",
    rich_presence_lookup("Chapter", byte(0xB95704), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("TimePeriod", dword(0xAA1268), TimePeriodLookup),
    rich_presence_lookup("FatedHour", byte(0xB95704), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA12AC)),
    rich_presence_value("Number", dword(0xAA12A4)),
    rich_presence_value("Minutes", dword(0xAA12B4) + dword(0xAA12B0) * 60, format="MINUTES"),
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

rich_presence_conditional_display(low4(0xAA692C) != 0 && bit7(0xAA68E8) == 1 && bit0(0xAA8CA8) == 1 && bit0(0xAA8CA7) == 1 && bit0(0xAA8CA6) == 1 &&
    bit0(0xAA8CA5) == 1 && bit0(0xAA8CA4) == 1 && dword(0xACC534) == 0 && byte(0xB9D284) == 1, "Ending the cycle | The Fated 🕑 {0} | Current 📆 {1} April {2} 🕑 {3} | Completion: {4}%",
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA8DFC)),
    rich_presence_value("Number", dword(0xAA8DF4)),
    rich_presence_value("Minutes", dword(0xAA8E04) + dword(0xAA8E00) * 60, format="MINUTES"),
    rich_presence_value("Number", byte(0xAA8CA2))
)

rich_presence_conditional_display(low4(0xAA692C) != 0 && bit7(0xAA68E8) == 0 && dword(0xACC534) == 0 && byte(0xB9D284) != 0 && byte(0xB9D284) <= 11 &&
    ((byte(0xB9D284) == 1) ||
     (byte(0xB9D284) == 2) ||
     (byte(0xB9D284) == 12) ||
     (byte(0xB9D284) == 10)), "{0} | The Fated 🕑 {1} | Current 📆 {2} April {3} 🕑 {4} | Completion: {5}%",
    rich_presence_lookup("Chapter", byte(0xB9D284), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA8DFC)),
    rich_presence_value("Number", dword(0xAA8DF4)),
    rich_presence_value("Minutes", dword(0xAA8E04) + dword(0xAA8E00) * 60, format="MINUTES"),
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
     (byte(0xB9D284) == 9)), "{0} {1} | The Fated 🕑 {2} | Current 📆 {3} April {4} 🕑 {5} | Completion: {6}%",
    rich_presence_lookup("Chapter", byte(0xB9D284), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("TimePeriod", dword(0xAA8DB8), TimePeriodLookup),
    rich_presence_lookup("FatedHour", byte(0xB9D284), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", dword(0xAA8DFC)),
    rich_presence_value("Number", dword(0xAA8DF4)),
    rich_presence_value("Minutes", dword(0xAA8E04) + dword(0xAA8E00) * 60, format="MINUTES"),
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
