// Shadow of Destiny
// #ID = 3945

// $000000: Link to RAscript + Achievement Guide (github)
//          ===========================================
//          https://github.com/QuentinBultinck/RetroAchievements/tree/main/RAscripts/PSP/ShadowOfDestiny
function linkToRascriptAchievementGuideGithub() => dword(0x000000)

// $8FFEF0: [NTSC-U/C][25-bit Pointer] Video data (intro and credits)
//          +0x18 - [32-bit Flag] 0x101 => video is active
//          +0x2c - [32-bit Flag] 0x41 => video is active
//          +0x40 - [32-bit] Video timer
function ntscUC25BitPointerVideoDataIntroAndCredits() => dword(0x8FFEF0)

// $A82E48: [NTSC-U/C][32-bit] Area/room identification
//          - This list is not complete; Currently only IDs used in achievement logic are documented
//          
//          PresentDayCity = 0x375
//          PresentNightCityPM = 0x44
//          PresentNightCityAM = 0x3
//          PresentTownHall = 0x16
//          80sColdCity = 0x465
//          70sNightCity = 0x31d
//          1900sCity = 0x239
//          1900sBrumMansion = 0x603
//          ColdCityBar = 0xf
//          CafeSonne80s = 0x15
//          CafeSonnePresent = 0x10
//          MedievalCity = 0x3f3
//          MedievalNightCity = 0x33c
//          ExplodedAlchemistBasement = 0x217
//          MedievalChurch = 0x8e
//          AntiqueShopEule80s = 0x7a
//          AntiqueShopEulePresent = 0x6f
//          BrumEstateIndoors1900 = 0x603
//          BrumMuseumUpstairsRoom1Night = 0x159
//          BrumMuseumUpstairsRoom1Day = 0x38
//          BrumMuseumUpstairsRoom2Night = 0x224
//          BrumMuseumUpstairsRoom2Day = 0x1bd
//          BrumMuseumUpstairsRoom3Night = 0x140
//          BrumMuseumUpstairsRoom3Day = 0xcd
//          BrumMuseumDownstairsRoomNight = 0x32
//          BrumMuseumDownstairsRoomDay = 0x2ed
function ntscUC32BitAreaRoomIdentification() => dword(0xA82E48)

// $A9DAA8: [NTSC-U/C][8-bit] Number of Z-Pad energy units owned
//          - If this is 0x0, player can't time travel
//          - Values range [0x0-0xa]
function ntscUC8BitNumberOfZPadEnergyUnitsOwned() => byte(0xA9DAA8)

// $A9ECBC: [NTSC-U/C][32-bit] Cutscene ID Master
//          - Identifies a cutscene sequence
function ntscUC32BitCutsceneIdMaster() => dword(0xA9ECBC)

// $A9ECC0: [NTSC-U/C][16-bit] Cutscene Section ID_1
//          - Identifies a section from the current cutscene
function ntscUC16BitCutsceneSectionId1() => word(0xA9ECC0)

// $A9ECC2: [NTSC-U/C][16-bit] Cutscene Section ID_2
function ntscUC16BitCutsceneSectionId2() => word(0xA9ECC2)

// $A9ECC8: [NTSC-U/C][25-bit Pointer] Cutscene Identification - Master Data
//          +0x0 - Refers to start of dynamic cutscene memory data block - Data higher than this hex address changes on new cutscene loaded in
//          +0x8 - [32-bit] Cutscene Master Data ID
function ntscUC25BitPointerCutsceneIdentificationMasterData() => dword(0xA9ECC8)

// $A9ECCC: [NTSC-U/C][25-bit Pointer] Cutscene Identification - Section Data
//          +0x0 - Data lower than this hex address changes when the next section in the cutscene starts
//          +0x8 - [32-bit] Cutscene Section Data ID
function ntscUC25BitPointerCutsceneIdentificationSectionData() => dword(0xA9ECCC)

// $A9ECD4: [NTSC-U/C][25-bit Pointer] Cutscene Identification - Minor IDs
//          - Pointer active when a cutscene is active
//          +0x0 - Data lower than this point can be used as Minor Cutscene IDs
//          +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID
function ntscUC25BitPointerCutsceneIdentificationMinorIds() => dword(0xA9ECD4)

// $A9ED26: [NTSC-U/C][8-bit Flag] Is cutscene active (preferred)
//          0x0 => no cutscene active
//          0x1 => black bars (small) cutscene active/transitional value between active-inactive
//          ... => transitional values
//          0x5 => full cutscene active
function ntscUC8BitFlagIsCutsceneActivePreferred() => byte(0xA9ED26)

// $A9ED3C: [NTSC-U/C][57-bytes Bitset] Achievement Percentage Flags
//          ========================================
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
function achievementPercentageFlagsPrologueExChapter() => bitcount(0xA9ED3D)

// $A9ED3E: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
function achievementPercentageFlagsPrologueExChapter() => bitcount(0xA9ED3E)

// $A9ED3F: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
function achievementPercentageFlagsPrologueExChapter() => bitcount(0xA9ED3F)

// $A9ED40: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
function achievementPercentageFlagsPrologueExChapter() => bitcount(0xA9ED40)

// $A9ED41: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          all bits => 15+%
function achievementPercentageFlagsPrologueExChapter() => bitcount(0xA9ED41)

// $A9ED42: [Bit Flags] Achievement Percentage Flags - Prologue & EX Chapter
//          bits 0-5 => 11+%
// $A9ED43: [NTSC-U/C][4-bytes - Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 6-7 => 8+%

// $A9ED44: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
function achievementPercentageFlagsChapter1() => bitcount(0xA9ED44)

// $A9ED45: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          all bits => 33+%
function achievementPercentageFlagsChapter1() => bitcount(0xA9ED45)

// $A9ED46: [Bit Flags] Achievement Percentage Flags - Chapter 1
//          bits 0-5 => 25+%
// $A9ED47: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 3-7 => 13+%

// $A9ED48: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
function achievementPercentageFlagsChapter2() => bitcount(0xA9ED48)

// $A9ED49: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
function achievementPercentageFlagsChapter2() => bitcount(0xA9ED49)

// $A9ED4A: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          all bits => 22+%
function achievementPercentageFlagsChapter2() => bitcount(0xA9ED4A)

// $A9ED4B: [Bit Flags] Achievement Percentage Flags - Chapter 2
//          bits 0-6 => 19+%
// $A9ED4D: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 1-7 => 19+%

// $A9ED4E: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
function achievementPercentageFlagsChapter4() => bitcount(0xA9ED4E)

// $A9ED4F: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
function achievementPercentageFlagsChapter4() => bitcount(0xA9ED4F)

// $A9ED50: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          all bits => 22+%
function achievementPercentageFlagsChapter4() => bitcount(0xA9ED50)

// $A9ED51: [Bit Flags] Achievement Percentage Flags - Chapter 4
//          bits 0-4 => 13+%
// $A9ED52: [NTSC-U/C][6-bytes - Bit Flags] Achievement Percentage Flags - Chapter 5
//          bits 1-7 => 15+%

// $A9ED53: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
function achievementPercentageFlagsChapter5() => bitcount(0xA9ED53)

// $A9ED54: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
function achievementPercentageFlagsChapter5() => bitcount(0xA9ED54)

// $A9ED55: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
function achievementPercentageFlagsChapter5() => bitcount(0xA9ED55)

// $A9ED56: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          all bits => 17+%
function achievementPercentageFlagsChapter5() => bitcount(0xA9ED56)

// $A9ED57: [Bit Flags] Achievement Percentage Flags - Chapter 5
//          bits 0-6 => 15+%
// $A9ED58: [NTSC-U/C][3-bytes - Bit Flags] Achievement Percentage Flags - Chapter 3
//          bits 2-7 => 27+%

// $A9ED59: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
function achievementPercentageFlagsChapter3() => bitcount(0xA9ED59)

// $A9ED5A: [Bit Flags] Achievement Percentage Flags - Chapter 3
//          all bits => 36+%
function achievementPercentageFlagsChapter3() => bitcount(0xA9ED5A)

// $A9ED5B: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 2-7 => 17+%

// $A9ED5C: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
function achievementPercentageFlagsChapter6() => bitcount(0xA9ED5C)

// $A9ED5D: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
function achievementPercentageFlagsChapter6() => bitcount(0xA9ED5D)

// $A9ED5E: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          all bits => 22+%
function achievementPercentageFlagsChapter6() => bitcount(0xA9ED5E)

// $A9ED5F: [Bit Flags] Achievement Percentage Flags - Chapter 6
//          bits 0-4 => 14+%
// $A9ED60: [NTSC-U/C][5-bytes - Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 2-7 => 17+%

// $A9ED61: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
function achievementPercentageFlagsChapter7() => bitcount(0xA9ED61)

// $A9ED62: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
function achievementPercentageFlagsChapter7() => bitcount(0xA9ED62)

// $A9ED63: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          all bits => 23+%
function achievementPercentageFlagsChapter7() => bitcount(0xA9ED63)

// $A9ED64: [Bit Flags] Achievement Percentage Flags - Chapter 7
//          bits 0-3 => 11+%
// $A9ED65: [NTSC-U/C][10-bytes - Bit Flags] Achievement Percentage Flags - Chapter 8
//          bits 5-7 => 4+%

// $A9ED66: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED66)

// $A9ED67: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED67)

// $A9ED68: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED68)

// $A9ED69: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED69)

// $A9ED6A: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED6A)

// $A9ED6B: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED6B)

// $A9ED6C: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED6C)

// $A9ED6D: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          all bits => 11+%
function achievementPercentageFlagsChapter8() => bitcount(0xA9ED6D)

// $A9ED6E: [Bit Flags] Achievement Percentage Flags - Chapter 8
//          bits 0-3 => 5+%
// $A9ED71: [NTSC-U/C][4-bytes - Bit Flags] Achievement Percentage Flags - Epilogue
//          bits 2-7 => 26+%

// $A9ED72: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
function achievementPercentageFlagsEpilogue() => bitcount(0xA9ED72)

// $A9ED73: [Bit Flags] Achievement Percentage Flags - Epilogue
//          all bits => 34+%
function achievementPercentageFlagsEpilogue() => bitcount(0xA9ED73)

// $A9ED74: [Bit Flags] Achievement Percentage Flags - Epilogue
//          bit 0 => 4+%
// $A9ED98: [Bit Flags] Current Playthrough - EX Chapter
//          bit 7 => EX Chapter is active // 2nd dialogue option "Oh, Homunculus" => activates EX chapter
// $A9ED9D: [Bit Flags] Current Playthrough -Chapter 1
//          bit 5 => put out fire yourself
//          bit 7 => Saved bar from fire by warning barman
// $A9EDA0: [Bit Flags] Current Playthrough -Chapter 2
//          bit 0 => acquired ladder
//          bit 1 = 0 => LIGHTER used to scare crowd
//          bit 1 = 1 => TELEPHONE used
//          bit 2 = 0 => Chosen to plant STATUE instead of flowers
//          bit 2 = 1 => Chosen to plant FLOWERS instead of statue
// $A9EDA5: [Bit Flags] Current Playthrough -Chapter 4
//          bit 2 => is wearing performer outfit
//          bit 3 => died once without using an iron plate
// $A9EDAA: [Bit Flags] Current Playthrough - Brum Estate Choice
//          bit 5 = 0 => Brum Estate is museum
//          bit 5 = 1 => Brum Estate is library
// $A9EDAE: [Bit Flags] Current Playthrough - Chapter 5
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
// $A9EDB7: [Bit Flags] Current Playthrough - Chapter 6
//          bit 5 => Movie choice 1: Meditating Man
//          bit 6 => Movie choice 1: Time Travel
//          bit 7 => Movie choice 2: Take over the world
// $A9EDB8: [Bit Flags] Current Playthrough - Chapter 6
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
// $A9EDDC: [Lower4 Flag][NTSC-U/C] Is in-game
//          Lower4 = 0 => at title screen
//          Lower4 > 0 => in-game

// $A9EE1D: [8-bit] NPC Talk Count - Coated man - Present - Chapter 1/Prologue - Town Square
function npcTalkCountCoatedManPresentChapter1PrologueTownSquare() => byte(0xA9EE1D)

// $A9EE20: [8-bit] NPC Talk Count - Coated man- Present - Chapter 3 - Near Antique Shop
function npcTalkCountCoatedManPresentChapter3NearAntiqueShop() => byte(0xA9EE20)

// $A9EE21: [8-bit] NPC Talk Count - Coated man - Present - Chapter 4 - Haup str. under arch
function npcTalkCountCoatedManPresentChapter4HaupStrUnderArch() => byte(0xA9EE21)

// $A9EE24: [8-bit] NPC Talk Count - Coated man - Present - Chapter 7 - North West Gate
function npcTalkCountCoatedManPresentChapter7NorthWestGate() => byte(0xA9EE24)

// $A9EE25: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Library
function npcTalkCountCoatedManPresentChapter5NorthEastGateBrumLibrary() => byte(0xA9EE25)

// $A9EE26: [8-bit] NPC Talk Count - Coated man - Present - Chapter 5 - North East Gate - Brum Museum
function npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum() => byte(0xA9EE26)

// $A9EE28: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 1/Prologue - Town Square
function npcTalkCountCoatedWomanPresentChapter1PrologueTownSquare() => byte(0xA9EE28)

// $A9EE2C: [8-bit] NPC Talk Count - Coated woman - Present - Chapter3 - Outside antique shop
function npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() => byte(0xA9EE2C)

// $A9EE2F: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 7 - South Gate
function npcTalkCountCoatedWomanPresentChapter7SouthGate() => byte(0xA9EE2F)

// $A9EE31: [8-bit] NPC Talk Count - Coated woman - Present - Chapter 5 - East of Cafe Sonne
function npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() => byte(0xA9EE31)

// $A9EE36: [8-bit] NPC Talk Count - Straw Hat Man - Middle Ages - Chapter 2 - Streets - When scaring with lighter or cellphone
function npcTalkCountStrawHatManMiddleAgesChapter2StreetsWhenScaringWithLighterOrCellphone() => byte(0xA9EE36)

// $A9EE3F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
function npcTalkCountAspiringApprenticeMiddleAgesChapter2Southeastgate() => byte(0xA9EE3F)

// $A9EE49: [8-bit] NPC Talk Count - Barman - Cold Days 1980 - any chapter - inside bar
function npcTalkCountBarmanColdDays1980AnyChapterInsideBar() => byte(0xA9EE49)

// $A9EE4C: [8-bit] NPC Talk Count -  Broad delinquent - Present - Chapter 7 - Car Park
function npcTalkCountBroadDelinquentPresentChapter7CarPark() => byte(0xA9EE4C)

// $A9EE51: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
function npcTalkCountSlimDelinquentPresentChapter7CarPark() => byte(0xA9EE51)

// $A9EE70: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square - When frightening with lighter or cellphone
function npcTalkCountEccentricGirlMiddleAgesChapter2TownSquareWhenFrighteningWithLighterOrCellphone() => byte(0xA9EE70)

// $A9EF43: [8-bit] NPC Talk Count - Older man - 1980 - Chapter 6 - Cafe Sonne
function npcTalkCountOlderMan1980Chapter6CafeSonne() => byte(0xA9EF43)

// $A9EF69: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - West Gate - When 0xa9ef89 == 0
function npcTalkCountYoungCoupleManMiddleAgesChapter2WestGateWhen0xa9ef890() => byte(0xA9EF69)

// $A9EF6A: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay - When 0xa9ef89 == 0x1
function npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() => byte(0xA9EF6A)

// $A9EF6B: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 2 - East near hay - When 0xa9ef89 == 0x3
function npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() => byte(0xA9EF6B)

// $A9EF6C: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well - When 0xa9ef8a == 0
function npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0() => byte(0xA9EF6C)

// $A9EF6D: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Near Well - When 0xa9ef8a == 0x1
function npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0x1() => byte(0xA9EF6D)

// $A9EF6E: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 3 - Outside church - When 0xa9ef8a == 0x3
function npcTalkCountYoungCoupleManMiddleAgesChapter3OutsideChurchWhen0xa9ef8a0x3() => byte(0xA9EF6E)

// $A9EF6F: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square - When value @ 0xa9ef8b == 0x0
function npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x0() => byte(0xA9EF6F)

// $A9EF70: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Town square - When value @ 0xa9ef8b == 0x1
function npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x1() => byte(0xA9EF70)

// $A9EF71: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 4 - Near Marie's Bakery - When value @ 0xa9ef8b == 0x3
function npcTalkCountYoungCoupleManMiddleAgesChapter4NearMarieSBakeryWhenValue0xa9ef8b0x3() => byte(0xA9EF71)

// $A9EF72: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 5 - Near South East Gate
function npcTalkCountYoungCoupleManMiddleAgesChapter5NearSouthEastGate() => byte(0xA9EF72)

// $A9EF74: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 7 - Outside church
function npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch() => byte(0xA9EF74)

// $A9EF78: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - After experiment - When value @ 0xa9ef8e >= 0x1
function npcTalkCountYoungCoupleManMiddleAgesChapter8OutsideChurchAfterExperimentWhenValue0xa9ef8e() => byte(0xA9EF78)

// $A9EF7C: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay - When 0xa9ef89 == 0
function npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890() => byte(0xA9EF7C)

// $A9EF7D: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay - When 0xa9ef89 == 0x1
function npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() => byte(0xA9EF7D)

// $A9EF7E: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 2 - East near hay - When 0xa9ef89 == 0x3
function npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() => byte(0xA9EF7E)

// $A9EF80: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Near North East Gate - - When 0xa9ef8a == 0x1
function npcTalkCountYoungCoupleWomanMiddleAgesChapter3NearNorthEastGateWhen0xa9ef8a0x1() => byte(0xA9EF80)

// $A9EF81: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 3 - Town square  - When 0xa9ef8a == 0x3
function npcTalkCountYoungCoupleWomanMiddleAgesChapter3TownSquareWhen0xa9ef8a0x3() => byte(0xA9EF81)

// $A9EF82: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church - When value @ 0xa9ef8b == 0x0
function npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x0() => byte(0xA9EF82)

// $A9EF83: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church - When value @ 0xa9ef8b == 0x1
function npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x1() => byte(0xA9EF83)

// $A9EF84: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 4 - Outside church - When value @ 0xa9ef8b == 0x3
//          
//          [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square - In Ancestor and NoAncestor path
function npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x3() => byte(0xA9EF84)

// $A9EF85: [8-bit] NPC Talk Count - Young couple woman - Middle Ages - Chapter 7 - Town square - Only in Ancestor path
//          0x1 => talked to her before dialogue option
//          0x2 => chosen any dialogue option
function npcTalkCountYoungCoupleWomanMiddleAgesChapter7TownSquareOnlyInAncestorPath() => byte(0xA9EF85)

// $A9EF89: [NTSC-U/C][8-bit] Progress of Young Couple sidequest: Chapter 2
//          0x1 => has talked with 0xa9ef69 AND 0xa9ef7c
//          0x2 => has talked with 0xa9ef6a AND 0xa9ef7d
//          0x3 => Young couple - Middle Ages - Chapter 2 - have switched positions/respawned
function ntscUC8BitProgressOfYoungCoupleSidequestChapter2() => byte(0xA9EF89)

// $A9EF8A: [NTSC-U/C][8-bit] Progress of Young Couple sidequest: Chapter 3
//          0x1 => has talked with 0xa9ef6c AND 0xa9ef7f
//          0x2 => has talked with 0xa9ef6d AND 0xa9ef80
//          0x3 => Young couple - Middle Ages - Chapter 3 - have changed positions/respawned
function ntscUC8BitProgressOfYoungCoupleSidequestChapter3() => byte(0xA9EF8A)

// $A9EF8B: [NTSC-U/C][8-bit] Progress of Young Couple sidequest: Chapter 4
//          0x1 => has talked with 0xa9ef82 AND 0xa9ef6f
//          0x2 => has talked with 0xa9ef83 AND 0xa9ef70
//          0x3 => Young couple - Middle Ages - Chapter 4 - have changed positions/respawned
function ntscUC8BitProgressOfYoungCoupleSidequestChapter4() => byte(0xA9EF8B)

// $A9EF8E: [NTSC-U/C][8-bit] Progress of Young Couple sidequest: Chapter 7
//          8-bit >= 0x1 => advised woman to be truthful
//          - Increases by 0x1 after telling woman to be truthful, to a max of 0x1
//          
//          [NTSC-U/C][8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - Before Experiment - Only available when this memory address was already >= 0x1
//          - Talk Counts add on top of above explained count
//          - If count was 0 from start, refer to 0xa9ef77
//          - Increases by 0x1 with each interaction with the man starts at 0x1 and to a max of 0x3
function ntscUC8BitProgressOfYoungCoupleSidequestChapter7() => byte(0xA9EF8E)

// $A9EF8F: [NTSC-U/C][8-bit] Progress of Young Couple sidequest: Chapter 8
//          bit 0 => told the man about the lovers never destined to meet
//          bit 1 => told the man to get over it

// $A9EFDC: [NTSC-U/C][25-bit Pointer] Interactions
//          +0x0 - [NTSC-U/C][32-bit] NPC ID
//          | - Unique per interactable NPC or environment item
//          | - This value is copied to 0xa9eff4 (refer to notes)
function ntscUC25BitPointerInteractions() => dword(0xA9EFDC)

// $A9EFE0: [NTSC-U/C][25-bit Pointer] Interaction Identification
//          +0x0 - [32-bit] Interaction Chapter ID
//          | - Each chapter has a different value
function ntscUC25BitPointerInteractionIdentification() => dword(0xA9EFE0)

// $A9EFE4: [NTSC-U/C][25-bit Pointer] Interaction Identification
//          - Pointer resets to 0x0 when interaction is done
//          +0x0 - [32-bit] Interaction ID
function ntscUC25BitPointerInteractionIdentification() => dword(0xA9EFE4)

// $A9F034: [NTSC-U/C][224-bytes] Inventory logic data
//          =====================================
//          - Upper4 => correlates to current chapter or the chapter in which item was acquired??
//          - bit 0 = flag => item in inventory
//          
//          [Bit Flag] bit 0 => Z-pad/D-pad

// $A9F035: [Bit Flag] bit 0 => Cellphone
function bit0Cellphone() => bit0(0xA9F035)

// $A9F036: [Bit Flag] bit 0 => Ornamental egg
function bit0OrnamentalEgg() => bit0(0xA9F036)

// $A9F038: [Bit Flag] bit 0 => Frying Pan
function bit0FryingPan() => bit0(0xA9F038)

// $A9F039: [Bit Flag] bit 0 => Photo shop sign
function bit0PhotoShopSign() => bit0(0xA9F039)

// $A9F03A: [Bit Flag] bit 0 => Lighter
function bit0Lighter() => bit0(0xA9F03A)

// $A9F03B: [Bit Flag] bit 0 => Black and white photo without performer
//          - Switches with next byte, after taking the picture with the performer during chapter 4

// $A9F03C: [Bit Flag] bit 0 => Black and white photo with performer
function bit0BlackAndWhitePhotoWithPerformer() => bit0(0xA9F03C)

// $A9F03D: [Bit Flag] bit 0 => Philosopher's stone
function bit0PhilosopherSStone() => bit0(0xA9F03D)

// $A9F03E: [Bit Flag] bit 0 => New rope
function bit0NewRope() => bit0(0xA9F03E)

// $A9F03F: [Bit Flag] bit 0 => Old rope
//          - Is automatically removed when obtaining new rope

// $A9F040: [Bit Flag] bit 0 => Jugglery
function bit0Jugglery() => bit0(0xA9F040)

// $A9F041: [Bit Flag] bit 0 => Comb
function bit0Comb() => bit0(0xA9F041)

// $A9F042: [Bit Flag] bit 0 => Old alchemist book
function bit0OldAlchemistBook() => bit0(0xA9F042)

// $A9F043: [Bit Flag] bit 0 => Squire's crest
function bit0SquireSCrest() => bit0(0xA9F043)

// $A9F044: [Bit Flag] bit 0 => Egg shaped pocket watch
function bit0EggShapedPocketWatch() => bit0(0xA9F044)

// $A9F045: [Bit Flag] bit 0 => Antidote
function bit0Antidote() => bit0(0xA9F045)

// $A9F046: [Bit Flag] bit 0 => Scrap of meat
function bit0ScrapOfMeat() => bit0(0xA9F046)

// $A9F047: [Bit Flag] bit 0 => Cake
function bit0Cake() => bit0(0xA9F047)

// $A9F048: [Bit Flag] bit 0 => Lab key
function bit0LabKey() => bit0(0xA9F048)

// $A9F049: [Bit Flag] bit 0 => Tower key
function bit0TowerKey() => bit0(0xA9F049)

// $A9F04A: [Bit Flag] bit 0 => Letter to Dana
function bit0LetterToDana() => bit0(0xA9F04A)

// $A9F04B: [Bit Flag] bit 0 => Kitten
function bit0Kitten() => bit0(0xA9F04B)

// $A9F04C: [Bit Flag] bit 0 => City map
function bit0CityMap() => bit0(0xA9F04C)

// $A9F04D: [Bit Flag] bit 0 => Ladder
function bit0Ladder() => bit0(0xA9F04D)

// $A9F04E: [Bit Flag] bit 0 => Old city map
function bit0OldCityMap() => bit0(0xA9F04E)

// $A9F04F: [Bit Flag] bit 0 => Notebook
function bit0Notebook() => bit0(0xA9F04F)

// $A9F050: [Bit Flag] bit 0 => Postcard
function bit0Postcard() => bit0(0xA9F050)

// $A9F111: [NTSC-U/C][8-bit] Currently selected item in inventory
//          - Currently only the IDs which are used in achievement logic are documented in this list
//          
//          0x0 = D-Pad
//          0x1 = Cellphone
//          0x10 = Egg Pocket Watch
//          0x13 = Cake
//          0x18 = City Map
//          0x1b = Notebook
//          0x2 = Ornamental Egg
//          0x4 = Frying Pan
//          0x4 = Squire Crest
//          0x5 = Sign
//          0x6 = Lighter
//          ...
function ntscUC8BitCurrentlySelectedItemInInventory() => byte(0xA9F111)

// $AA1152: [8-bit] Achievement Percentage: Total
function achievementPercentageTotal() => byte(0xAA1152)

// $AA1154: [NTSC-U/C][6-bytes] Endings Achieved
//          ==========================
//          - These flags will make the corresponding ending file viewable in the extra menu
//          - Once one of these is achieved, it will unlock the extra menu at the title screen
//          
//          [Bit Flag] bit 0 => Ending A unlocked

// $AA1155: [Bit Flag] bit 0 => Ending B unlocked
function bit0EndingBUnlocked() => bit0(0xAA1155)

// $AA1156: [Bit Flag] bit 0 => Ending C unlocked
function bit0EndingCUnlocked() => bit0(0xAA1156)

// $AA1157: [Bit Flag] bit 0 => Ending D unlocked
function bit0EndingDUnlocked() => bit0(0xAA1157)

// $AA1158: [Bit Flag] bit 0 => Ending E unlocked
function bit0EndingEUnlocked() => bit0(0xAA1158)

// $AA1159: [Bit Flag] bit 0 => Ending EX unlocked
function bit0EndingExUnlocked() => bit0(0xAA1159)

// $AA1268: [NTSC-U/C][32-bit] Time Period
//          0x80 => Middle ages 1500s
//          0x81 => Late 20th Century 1900s
//          0x82 => Early 20th Century 1980
//          0x88 => Early 20th Century 1979
//          0x83 => Present 2000s
function ntscUC32BitTimePeriod() => dword(0xAA1268)

TimePeriodLookup = {
    128: "in the Middle Ages",
    129: "in the late 20th century",
    130: "in the early 20th century",
    131: "in the present",
    136: "in the late 20th century",
}

// $AA12A4: [NTSC-U/C][668-bytes] Time and Date
//          =======================
//          - Time in present always ticks
//          - Time in other time periods only ticks/changes when in that time period
//          - There might be multiple entries for the same time period in these 668-bytes
//          
//          [NTSC-U/C][34-bytes] Date & Time - Present
//          [32-bit] Present - year
function ntscUC668BytesTimeAndDate() => dword(0xAA12A4)

// $AA12AC: [32-bit] Present - day
function presentDay() => dword(0xAA12AC)

// $AA12B0: [32-bit] Present - hours
function presentHours() => dword(0xAA12B0)

// $AA12B4: [32-bit] Present - minutes
function presentMinutes() => dword(0xAA12B4)

// $AA155C: [NTSC-U/C][32-bit] Current Playthrough Timer - Chapter Clear Time
//          - Time in seconds = [32-bit] decimal value / 60
//          - Time in minutes = [32-bit] decimal value / 3600
//          - Maximum value => 0x57e3f = 99h:59m:59s
//          - Does not reset to 0 once maximum is hit
//          - Resets to 0 on new chapter start
//          - Timer stops when credits video starts playing
//          - Timer does not pause when the inventory is open OR when a cutscene is active
//          - Timer pauses in pause menu or when loading
function ntscUC32BitCurrentPlaythroughTimerChapterClearTime() => dword(0xAA155C)

// $AA1560: [NTSC-U/C][32-bit] Current Playthrough Timer - Total Clear Time
//          - Explanation => refer to notes @ 0xaa155c
function ntscUC32BitCurrentPlaythroughTimerTotalClearTime() => dword(0xAA1560)

// $AA2998: [NTSC-U/C][25-bit Pointer] is main save file loaded (at first startup of game)
//          +0x4 - [Bit Flag] bit 0 => is main save loaded
function ntscUC25BitPointerIsMainSaveFileLoadedAtFirstStartupOfGame() => dword(0xAA2998)

// $AC3170: [NTSC-U/C][25-bit Pointer] Extra Menu Navigation
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
function ntscUC25BitPointerExtraMenuNavigation() => dword(0xAC3170)

// $AC3178: [NTSC-U/C][25-bit Pointer]Ending File Identification + Data
//          - Pointer is active when in extra menu
//          - Resets to 0x0, when no ending file is on screen (confirm?)
//          
//          +0x10 - [8-bit] Ending File ID
//          | - 0x0 => ending file A
//          | - 0x1 => ending file B
//          | - ...
//          | - 0x4 => ending file E
//          | - 0x5 => ending file EX
//          
//          +0x8 - [32-bit] Ending file timer
//          +0xc - [16-bit] Ending file subtitle ID
//          | - Changes on each next subtitle
function ntscUC25BitPointerEndingFileIdentificationData() => dword(0xAC3178)

// $AC31EE: [NTSC-U/C][8-bit] Character printer - Print location x-axis
function ntscUC8BitCharacterPrinterPrintLocationXAxis() => byte(0xAC31EE)

// $AC31F2: [NTSC-U/C][8-bit] Character printer - Offset x-axis
function ntscUC8BitCharacterPrinterOffsetXAxis() => dword_be(0xAC31F2)

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
function ntscUC8BitChapterId() => byte(0xB95704)

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

// $1FFF130: [NTSC-U/C][32-bit Flag] Is event viewer active (preferred)
//           - 0x21 => event viewer menu is on screen OR a cutscene is being watched via this menu
//           - other values => not in event viewer
//           
//           !! WARNING !!
//           - Do not use this as a solo condition to check if event viewer is active.
//           - Use with 0xac3170
function ntscUC32BitFlagIsEventViewerActivePreferred() => dword(0x1FFF130)

// $1FFF5D4: [NTSC-U/C][32-bit] Highlighted UI element when chapter complete screen is active
//           - Use in combination with 0x01fff5f4 & 0x01fff5f8
//           0x0 = yes
//           0x1 = no
function ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() => dword(0x1FFF5D4)

// $1FFF5F4: [NTSC-U/C][32-bit Flag] Is chapter complete screen active
//           0x21 => chapter completion screen is active (UI asks to save data)
function ntscUC32BitFlagIsChapterCompleteScreenActive() => dword(0x1FFF5F4)

// $1FFF5F8: [NTSC-U/C][32-bit] Menu Identification
//           - 0x11 => title screen
//           - 0x1 => chapter completed screen
//           - any other value => other menu OR something else on screen
function ntscUC32BitMenuIdentification() => dword(0x1FFF5F8)

// $1FFF604: [NTSC-U/C][8-bit] Highlighted button at title screen
//           - 0x1 => Start
//           - 0x2 => Continue
//           - 0x3 => Option
//           - 0x4 => Extra
function ntscUC8BitHighlightedButtonAtTitleScreen() => byte(0x1FFF604)
function ntscUC8BitHighlightedButtonAtTitleScreen() => dword(0x1FFF604)

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

achievement(
    title = "Defied Fate", points = 5,
    description = "Complete the prologue",
    id = 306884, badge = "461667", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 1 && ntscUC32BitCutsceneIdMaster() == 140416 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 113872 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 3600
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 1 && ntscUC32BitCutsceneIdMaster() == 592832 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 110192 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 482576
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 1 && ntscUC8BitChapterId() == 2))
)

achievement(
    title = "That's A Big No No", points = 2,
    description = "Warn yourself of your impending demise during the prologue",
    id = 306883, badge = "465973", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:45",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 1) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 39936 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 39920 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 60016
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 145344 && prior(ntscUC32BitCutsceneIdMaster()) == 39936 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44640
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "Defied Fate... Again", points = 5,
    description = "Complete chapter 1",
    id = 306886, badge = "465974", published = "5/04/2023 15:44:05", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 2 && ntscUC32BitCutsceneIdMaster() == 72256 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 48800 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 23424
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 2 && ntscUC8BitChapterId() == 3))
)

achievement(
    title = "A Performer's Clue", points = 1,
    description = "Receive a gift from a performer during chapter 1",
    id = 306885, badge = "465975", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 2) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 103296 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54768 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 3600
              ) && trigger_when(bit0OrnamentalEgg() == 1) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "There's A Fire!", points = 4,
    description = "Alert the young boy's grandpa of imminent disaster during chapter 1",
    id = 306976, badge = "465976", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 2) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0OrnamentalEgg() == 1 && ntscUC32BitCutsceneIdMaster() == 205312 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 28896 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 150704
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Jovial Exchange", points = 4,
    description = "Exchange an egg for a pan during chapter 1, 3 or 4",
    id = 306977, badge = "465977", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((ntscUC8BitChapterId() != 2 && ntscUC8BitChapterId() != 4 && ntscUC8BitChapterId() != 5)) &&
              tally(1,
                  once((ntscUC8BitChapterId() == 2 || ntscUC8BitChapterId() == 5) && ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0OrnamentalEgg() == 1 &&
                  ntscUC32BitCutsceneIdMaster() == 195008 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 22976 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 23584),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0OrnamentalEgg() == 1 && ntscUC8BitChapterId() == 4 && ntscUC32BitCutsceneIdMaster() == 205312 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 22976 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 23584)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Enigmatic Couple I: Prelude", points = 3,
    description = "Find the coated man and woman in the present during the prologue or chapter 1",
    id = 307495, badge = "465978", published = "9/04/2023 8:08:50", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never((ntscUC8BitChapterId() != 1 && ntscUC8BitChapterId() != 2)) &&
              measured(tally(4, repeated(2,
                  ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                  npcTalkCountCoatedWomanPresentChapter1PrologueTownSquare() > prev(npcTalkCountCoatedWomanPresentChapter1PrologueTownSquare()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 716), repeated(2,
                  ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                  npcTalkCountCoatedManPresentChapter1PrologueTownSquare() > prev(npcTalkCountCoatedManPresentChapter1PrologueTownSquare()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 705))
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Enigmatic Couple II: Tailing", points = 3,
    description = "Find the coated man and woman in the present during chapter 3",
    id = 310131, badge = "465979", published = "19/04/2023 11:41:41", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 4) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              ((measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() > prev(npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter3NearAntiqueShop() > prev(npcTalkCountCoatedManPresentChapter3NearAntiqueShop()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 708))
                )) ||
               (measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter3NearAntiqueShop() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 708))
                )))
)

achievement(
    title = "Enigmatic Couple III: Wandering Once More", points = 3,
    description = "Find the coated man and woman in the present during chapter 4",
    id = 310134, badge = "465980", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 5) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              ((measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() > prev(npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter4HaupStrUnderArch() > prev(npcTalkCountCoatedManPresentChapter4HaupStrUnderArch()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 709))
                )) ||
               (measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter4HaupStrUnderArch() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 709))
                )))
)

achievement(
    title = "Enigmatic Couple IV: Origins", points = 3,
    description = "Find the coated man and woman in the present during chapter 5",
    id = 310135, badge = "465981", published = "19/04/2023 15:36:31", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 6) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              ((measured(tally(3,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() > prev(npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 0 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum() > prev(npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 0 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum() == 2 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() > prev(npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumLibrary() == 1 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 713))
                )) ||
               (measured(tally(3,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumLibrary() == 1 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 713))
                )))
)

achievement(
    title = "Enigmatic Couple V: Epilogue", points = 3,
    description = "Find the coated man and woman in the present during chapter 7",
    id = 315564, badge = "465982", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 8) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              ((measured(tally(3, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter7SouthGate() > prev(npcTalkCountCoatedWomanPresentChapter7SouthGate()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 723),
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter7NorthWestGate() > prev(npcTalkCountCoatedManPresentChapter7NorthWestGate()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 712))
                )) ||
               (measured(tally(3, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter7SouthGate() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 723),
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter7NorthWestGate() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 712))
                )))
)

achievement(
    title = "Left In The Past", points = 5,
    description = "Complete chapter 2",
    id = 306922, badge = "465983", published = "5/04/2023 22:42:49", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 3 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 242240 &&
                    ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 3 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 242240 &&
                    ntscUC16BitCutsceneSectionId1() == 3 && ntscUC16BitCutsceneSectionId2() == 2 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 70208 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 688
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 3 && ntscUC8BitChapterId() == 4))
)

achievement(
    title = "Cracking Open The Past: Middle Ages", points = 3,
    description = "Show off your egg collection to the barman's ancestor during chapter 2",
    id = 307023, badge = "465984", published = "6/04/2023 20:16:21", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 2 && ntscUC32BitCutsceneIdMaster() == 56832 && ntscUC16BitCutsceneSectionId1() == 3 &&
                  ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 10704 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 46080
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Terror Of Destinies", points = 4,
    description = "Try to evoke fear in as many individuals as possible within chapter 2",
    id = 404046, badge = "465985", published = "2/03/2024 21:18:08", modified = "2/03/2024 21:18:08",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              (always_false() || (unless((ntscUC32BitAreaRoomIdentification() != 828 && ntscUC32BitAreaRoomIdentification() != 16)) &&
                measured(tally(9,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 1 && ntscUC32BitCutsceneIdMaster() == 36864 &&
                    ntscUC16BitCutsceneSectionId1() == 65535 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 36864), repeated(4,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 1 && ntscUC32BitCutsceneIdMaster() == 814592 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 23248 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 21936 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2380192 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 21936), repeated(4,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 6 && ntscUC32BitCutsceneIdMaster() == 689344 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 11840 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 45600 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2315504 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 45600),
                    once((ntscUC8BitCurrentlySelectedItemInInventory() == 6 || ntscUC8BitCurrentlySelectedItemInInventory() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 39104 &&
                    ntscUC16BitCutsceneSectionId1() == 65535 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 39056 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 52528 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 39056),
                    once((ntscUC8BitCurrentlySelectedItemInInventory() == 6 || ntscUC8BitCurrentlySelectedItemInInventory() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && npcTalkCountEccentricGirlMiddleAgesChapter2TownSquareWhenFrighteningWithLighterOrCellphone() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 788),
                    once((ntscUC8BitCurrentlySelectedItemInInventory() == 6 || ntscUC8BitCurrentlySelectedItemInInventory() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && npcTalkCountStrawHatManMiddleAgesChapter2StreetsWhenScaringWithLighterOrCellphone() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 730),
                    once((ntscUC8BitCurrentlySelectedItemInInventory() == 6 || ntscUC8BitCurrentlySelectedItemInInventory() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && npcTalkCountAspiringApprenticeMiddleAgesChapter2Southeastgate() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 739)),
                    when=low4(0xA9EDDC) != 0 && ntscUC8BitChapterId() == 3
                )))
)

achievement(
    title = "Met You Before", points = 2,
    description = "Keep chatting with Dana at the Marktplatz tree during chapter 2",
    id = 306888, badge = "465986", published = "5/04/2023 18:19:09", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 451712 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 283216 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 82928
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 112448 && prior(ntscUC32BitCutsceneIdMaster()) == 451712 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 7424 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 104992
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "A Blossoming Plan", points = 1,
    description = "Planted flowers during chapter 2",
    id = 306920, badge = "465987", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:44",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 1 && ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 242240 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "The Pyromancer's Legacy", points = 1,
    description = "Become honored as a pyrokinetic during chapter 2",
    id = 306911, badge = "465988", published = "5/04/2023 19:43:29", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 &&
                  ntscUC32BitCutsceneIdMaster() == 242240 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "The Magician's Legacy", points = 1,
    description = "Become honored as a magician during chapter 2",
    id = 306906, badge = "465989", published = "5/04/2023 19:28:48", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 1 && ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 &&
                  ntscUC32BitCutsceneIdMaster() == 242240 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "Yesteryears Couple I: Destined To Miss", points = 4,
    description = "Help a lost young couple reunite in the Middle Ages during chapter 2",
    id = 306984, badge = "465990", published = "6/04/2023 16:26:09", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 3) &&
              measured(tally(6,
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890() == 1 && prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890()) == 0 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1056),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter2WestGateWhen0xa9ef890() == 1 && prev(npcTalkCountYoungCoupleManMiddleAgesChapter2WestGateWhen0xa9ef890()) == 0 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1037),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1057),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1038),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 3 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 &&
                  npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() == 1 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1058),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter2() == 3 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() == 1 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1039)), when=ntscUC32BitAreaRoomIdentification() == 828
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Yesteryears Couple II: The Place Where We Nigh Met", points = 4,
    description = "Help a lost young couple reunite again in the Middle Ages during chapter 3",
    id = 310133, badge = "465991", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 4) &&
              measured(tally(6,
                  once(ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1059),
                  once(ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0() &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1040),
                  once(ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter3NearNorthEastGateWhen0xa9ef8a0x1() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter3NearNorthEastGateWhen0xa9ef8a0x1() &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1060),
                  once(ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0x1() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0x1() &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1041),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 3 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 &&
                  npcTalkCountYoungCoupleWomanMiddleAgesChapter3TownSquareWhen0xa9ef8a0x3() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter3TownSquareWhen0xa9ef8a0x3()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1061),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter3() == 3 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter3OutsideChurchWhen0xa9ef8a0x3() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3OutsideChurchWhen0xa9ef8a0x3()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1042)), when=ntscUC32BitAreaRoomIdentification() == 828
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Yesteryears Couple III: Destiny's Promise Fulfilled", points = 4,
    description = "Reunite the lost young couple in the Middle Ages during chapter 4",
    id = 309393, badge = "465992", published = "17/04/2023 19:03:08", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 5) &&
              measured(tally(6,
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x0() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1062),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 0 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 1) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x0() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1043),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x1() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1063),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 1 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x1() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1044),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 2 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 3) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x3() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1064),
                  once((ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 2 || ntscUC8BitProgressOfYoungCoupleSidequestChapter4() == 3) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4NearMarieSBakeryWhenValue0xa9ef8b0x3() == 1 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1045)),
                  when=ntscUC32BitAreaRoomIdentification() == 828
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Yesteryears Couple IV: Man-in-waiting", points = 1,
    description = "Consult the young man in the Middle Ages during chapter 5",
    id = 310162, badge = "465993", published = "19/04/2023 19:39:22", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 6) &&
              measured(repeated(2,
                  ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter5NearSouthEastGate() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter5NearSouthEastGate()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 75 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1046)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Yesteryears Couple V: Parting", points = 2,
    description = "Consult the young couple in the Middle Ages during chapter 7",
    id = 314753, badge = "465994", published = "5/05/2023 8:33:58", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 8) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              ((measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x3() == 1 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 59 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1065), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                    npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 59 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1
                )) ||
               (measured(tally(4, repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter7TownSquareOnlyInAncestorPath() == 2 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 59 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1065), repeated(2,
                    ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                    npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch()) && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 59 &&
                    dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0
                )))
)

achievement(
    title = "Yesteryears Couple VI: Never Destined To Meet", points = 10,
    description = "Advise the young man in the Middle Ages during chapter 8",
    id = 315568, badge = "465995", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC8BitChapterId() != 9 && ntscUC8BitChapterId() != 11)) &&
              measured(tally(2,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter7() >= 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter8OutsideChurchAfterExperimentWhenValue0xa9ef8e() == 1 && prev(npcTalkCountYoungCoupleManMiddleAgesChapter8OutsideChurchAfterExperimentWhenValue0xa9ef8e()) == 0 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 19 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1052),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC8BitProgressOfYoungCoupleSidequestChapter7() >= 1 && bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) == 0 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 408 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 19 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 1075)), when=ntscUC32BitAreaRoomIdentification() == 1011
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Energy Locator: Present Day", points = 5,
    description = "Collect all 5 energy orbs in present day Lebensbaum",
    id = 399816, badge = "461689", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless(bit2(0xA9EDA5) == 1) &&
              unless((ntscUC32BitAreaRoomIdentification() != 885 && ntscUC32BitAreaRoomIdentification() != 68 && ntscUC32BitAreaRoomIdentification() != 3)) &&
              measured(repeated(5,
                  ntscUC8BitNumberOfZPadEnergyUnitsOwned() > prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned()) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(ntscUC8BitCharacterPrinterPrintLocationXAxis()) == 0 && prior(ntscUC8BitCharacterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && ntscUC8BitFlagIsCutsceneActivePreferred() != 5)
              ) &&
              (always_false() || (never(ntscUC8BitNumberOfZPadEnergyUnitsOwned() < prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned())) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
                never(low4(0xA9EDDC) == 0)))
)

achievement(
    title = "Energy Locator: Middle Ages", points = 5,
    description = "Collect all 6 energy orbs in Medieval Lebensbaum",
    id = 399819, badge = "465996", published = "19/02/2024 14:12:17", modified = "19/02/2024 14:12:17",
    trigger = unless((ntscUC32BitAreaRoomIdentification() != 1011 && ntscUC32BitAreaRoomIdentification() != 828 && ntscUC32BitAreaRoomIdentification() != 535 &&
                  ntscUC32BitAreaRoomIdentification() != 142)
              ) &&
              measured(repeated(6,
                  ntscUC8BitNumberOfZPadEnergyUnitsOwned() > prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned()) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(ntscUC8BitCharacterPrinterPrintLocationXAxis()) == 0 && prior(ntscUC8BitCharacterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && ntscUC8BitFlagIsCutsceneActivePreferred() != 5)
              ) &&
              (always_false() || (never(ntscUC8BitNumberOfZPadEnergyUnitsOwned() < prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned())) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
                never(low4(0xA9EDDC) == 0)))
)

achievement(
    title = "Energy Locator: The Late 20th Century", points = 5,
    description = "Collect all 5 energy orbs in Lebensbaum during the late 20th century",
    id = 399817, badge = "461687", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless((ntscUC32BitAreaRoomIdentification() != 1125 && ntscUC32BitAreaRoomIdentification() != 797)) &&
              measured(repeated(5,
                  ntscUC8BitNumberOfZPadEnergyUnitsOwned() > prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned()) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(ntscUC8BitCharacterPrinterPrintLocationXAxis()) == 0 && prior(ntscUC8BitCharacterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && ntscUC8BitFlagIsCutsceneActivePreferred() != 5)
              ) &&
              (always_false() || (never(ntscUC8BitNumberOfZPadEnergyUnitsOwned() < prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned())) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
                never(low4(0xA9EDDC) == 0)))
)

achievement(
    title = "Energy Locator: The Early 20th Century", points = 5,
    description = "Collect all 5 energy orbs in Lebensbaum, a century ago",
    id = 399818, badge = "461686", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = never(ntscUC8BitNumberOfZPadEnergyUnitsOwned() < prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned())) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
              never(low4(0xA9EDDC) == 0) && never((bit2(0xA9EDA5) == 1 && ntscUC32BitAreaRoomIdentification() == 885)) &&
              (always_false() || (unless((ntscUC32BitAreaRoomIdentification() != 569 && ntscUC32BitAreaRoomIdentification() != 1539)) &&
                measured(repeated(5,
                    ntscUC8BitNumberOfZPadEnergyUnitsOwned() > prev(ntscUC8BitNumberOfZPadEnergyUnitsOwned()) && prior(dword(0xAC32B8)) != 0 &&
                    prior(dword_be(0xAC32C2)) != 0 && prior(ntscUC8BitCharacterPrinterPrintLocationXAxis()) == 0 &&
                    prior(ntscUC8BitCharacterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                    prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                    prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                    prior(dword_be(0xAC32A2)) == 4588544 && ntscUC8BitFlagIsCutsceneActivePreferred() != 5)
                )))
)

achievement(
    title = "Stockpiling Across Eras", points = 10,
    description = "Acquire the biggest hoard of items in a single playthrough",
    id = 402404, badge = "466000", published = "25/02/2024 19:47:49", modified = "25/02/2024 19:47:49",
    trigger = never((ntscUC32BitMenuIdentification() == 17 && ntscUC8BitHighlightedButtonAtTitleScreen() > 0 && ntscUC8BitHighlightedButtonAtTitleScreen() < 5)) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(bit0OldAlchemistBook() < prev(bit0OldAlchemistBook())) && never(bit0Antidote() < prev(bit0Antidote())) &&
              never(bit0(0xA9F03B) < prev(bit0(0xA9F03B))) && never(bit0BlackAndWhitePhotoWithPerformer() < prev(bit0BlackAndWhitePhotoWithPerformer())) &&
              never(bit0Cake() < prev(bit0Cake())) && never(bit0Cellphone() < prev(bit0Cellphone())) &&
              never(bit0Comb() < prev(bit0Comb())) && never(bit0(0xA9F034) < prev(bit0(0xA9F034))) &&
              never(bit0EggShapedPocketWatch() < prev(bit0EggShapedPocketWatch())) && never(bit0FryingPan() < prev(bit0FryingPan())) &&
              never(bit0Jugglery() < prev(bit0Jugglery())) && never(bit0Kitten() < prev(bit0Kitten())) &&
              never(bit0LabKey() < prev(bit0LabKey())) && never(bit0Ladder() < prev(bit0Ladder())) &&
              never(bit0Postcard() < prev(bit0Postcard())) && never(bit0Lighter() < prev(bit0Lighter())) &&
              never(bit0CityMap() < prev(bit0CityMap())) && never(bit0ScrapOfMeat() < prev(bit0ScrapOfMeat())) &&
              never(bit0NewRope() < prev(bit0NewRope())) && never(bit0Notebook() < prev(bit0Notebook())) &&
              never(bit0OldCityMap() < prev(bit0OldCityMap())) && never(bit0(0xA9F03F) < prev(bit0(0xA9F03F))) &&
              never(bit0OrnamentalEgg() < prev(bit0OrnamentalEgg())) && never(bit0PhilosopherSStone() < prev(bit0PhilosopherSStone())) &&
              never(bit0LetterToDana() < prev(bit0LetterToDana())) && never(bit0PhotoShopSign() < prev(bit0PhotoShopSign())) &&
              never(bit0SquireSCrest() < prev(bit0SquireSCrest())) && never(bit0TowerKey() < prev(bit0TowerKey())) &&
              measured(tally(20, once(bit0OldAlchemistBook() == 1), once(bit0Antidote() == 1), once(bit0(0xA9F03B) == 1),
                  once(bit0BlackAndWhitePhotoWithPerformer() == 1), once(bit0Cake() == 1), once(bit0Cellphone() == 1),
                  once(bit0Comb() == 1), once(bit0(0xA9F034) == 1), once(bit0EggShapedPocketWatch() == 1),
                  once(bit0FryingPan() == 1), once(bit0Jugglery() == 1), once(bit0Kitten() == 1),
                  once(bit0LabKey() == 1), once(bit0Ladder() == 1), once(bit0Postcard() == 1),
                  once(bit0Lighter() == 1), once(bit0CityMap() == 1), once(bit0ScrapOfMeat() == 1),
                  once(bit0NewRope() == 1), once(bit0Notebook() == 1), once(bit0OldCityMap() == 1),
                  once(bit0(0xA9F03F) == 1), once(bit0OrnamentalEgg() == 1), once(bit0PhilosopherSStone() == 1),
                  once(bit0LetterToDana() == 1), once(bit0PhotoShopSign() == 1), once(bit0SquireSCrest() == 1),
                  once(bit0TowerKey() == 1))
              ) &&
              once(((prev(bit0OldAlchemistBook()) + prev(bit0Antidote()) + prev(bit0(0xA9F03B)) + prev(bit0BlackAndWhitePhotoWithPerformer()) +
                  prev(bit0Cake()) + prev(bit0Cellphone()) + prev(bit0Comb()) + prev(bit0(0xA9F034)) +
                  prev(bit0EggShapedPocketWatch()) + prev(bit0FryingPan()) + prev(bit0Jugglery()) + prev(bit0Kitten()) +
                  prev(bit0LabKey()) + prev(bit0Ladder()) + prev(bit0Postcard()) + prev(bit0Lighter()) +
                  prev(bit0CityMap()) + prev(bit0ScrapOfMeat()) + prev(bit0NewRope()) + prev(bit0Notebook()) +
                  prev(bit0OldCityMap()) + prev(bit0(0xA9F03F)) + prev(bit0OrnamentalEgg()) + prev(bit0PhilosopherSStone()) +
                  prev(bit0LetterToDana()) + prev(bit0PhotoShopSign()) + prev(bit0SquireSCrest()) + prev(bit0TowerKey())) < 20) &&
                  (bit0OldAlchemistBook() + bit0Antidote() + bit0(0xA9F03B) + bit0BlackAndWhitePhotoWithPerformer() + bit0Cake() + bit0Cellphone() +
                  bit0Comb() + bit0(0xA9F034) + bit0EggShapedPocketWatch() + bit0FryingPan() + bit0Jugglery() + bit0Kitten() +
                  bit0LabKey() + bit0Ladder() + bit0Postcard() + bit0Lighter() + bit0CityMap() + bit0ScrapOfMeat() +
                  bit0NewRope() + bit0Notebook() + bit0OldCityMap() + bit0(0xA9F03F) + bit0OrnamentalEgg() + bit0PhilosopherSStone() +
                  bit0LetterToDana() + bit0PhotoShopSign() + bit0SquireSCrest() + bit0TowerKey()) == 20
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "An Alchemist, A Jewel And A Homunculus", points = 5, type="progression",
    description = "Complete chapter 3",
    id = 306921, badge = "465997", published = "5/04/2023 22:23:24", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 4 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 105856 &&
                    ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 33440 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 72384
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 4 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 850752 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 105856 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 14832 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 231328
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 4 && ntscUC8BitCurrentlySelectedItemInInventory() == 0 && ntscUC32BitCutsceneIdMaster() == 235136 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 850752 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 32272 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 31904
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 4 && ntscUC8BitChapterId() == 5))
)

achievement(
    title = "Running Beyond The 90's... And 80's", points = 2, type="missable",
    description = "Encounter an athletic man in the past, as well as his present self during chapter 3, 4 or 5",
    id = 405086, badge = "465998", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never(low4(0xA9EDDC) == 0) && never((ntscUC8BitChapterId() != 4 && ntscUC8BitChapterId() != 5 && ntscUC8BitChapterId() != 6)) &&
              measured(tally(2,
                  once((ntscUC32BitAreaRoomIdentification() == 885 || ntscUC32BitAreaRoomIdentification() == 68 || ntscUC32BitAreaRoomIdentification() == 3) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 88),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC32BitAreaRoomIdentification() == 797 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 89))
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Strokes Of Destiny", points = 1, type="missable",
    description = "Admire all original paintings in the Brum Museum",
    id = 307499, badge = "465999", published = "9/04/2023 11:10:41", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
              trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              measured(tally(8,
                  once((ntscUC32BitAreaRoomIdentification() == 50 || ntscUC32BitAreaRoomIdentification() == 749) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 292),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 356 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 293),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 357 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 294),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 362 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 295),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 358 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 296),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 360 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 297),
                  once((ntscUC32BitAreaRoomIdentification() == 320 || ntscUC32BitAreaRoomIdentification() == 205) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 361 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295),
                  once((ntscUC32BitAreaRoomIdentification() == 320 || ntscUC32BitAreaRoomIdentification() == 205) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 359 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295))
              )
)

achievement(
    title = "That's Nice!", points = 1, type="missable",
    description = "Pique someone's interest with an oval shape of your own in the 1980's",
    id = 407681, badge = "466001", published = "13/03/2024 14:05:48", modified = "13/03/2024 14:05:48",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once((ntscUC8BitCurrentlySelectedItemInInventory() == 16 || ntscUC8BitCurrentlySelectedItemInInventory() == 2) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC32BitAreaRoomIdentification() == 15 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 12 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 749 &&
                  npcTalkCountBarmanColdDays1980AnyChapterInsideBar() == 1
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Timeless Antiques", points = 2, type="missable",
    description = "Take a glance at the timeless relics in Antique Shop Eule",
    id = 310132, badge = "466002", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              measured(tally(4,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 142 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 152 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 121 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 198 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 4294967295)),
                  when=(ntscUC32BitAreaRoomIdentification() == 122 || ntscUC32BitAreaRoomIdentification() == 111)
              )
)

achievement(
    title = "My My, So Eager To Die", points = 1, type="missable",
    description = "Run from the apparition during chapter 3",
    id = 306919, badge = "466003", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 4) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 45376 && prior(ntscUC32BitCutsceneIdMaster()) == 371328 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 23232 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14512
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 107584 && prior(ntscUC32BitCutsceneIdMaster()) == 45376 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 55712 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 51792
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "Time-Spun Sweets", points = 4, type="missable",
    description = "Gift a tasty sweet to a someone dear to you",
    id = 402296, badge = "466004", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitCurrentlySelectedItemInInventory() != 19) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 1093632 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 711488 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 382112
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Legacy Of Sweetness", points = 3, type="missable",
    description = "Establish a new line of pastries",
    id = 402297, badge = "466005", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitCurrentlySelectedItemInInventory() != 19) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 130432 && ntscUC16BitCutsceneSectionId1() == 65535 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 86992 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 74416
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Pan-tastic Resilience", points = 3, type="progression",
    description = "Complete chapter 4, using a frying pan",
    id = 308964, badge = "461657", published = "16/04/2023 17:01:09", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(ntscUC32BitCutsceneIdMaster()) != ntscUC32BitCutsceneIdMaster()) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitCurrentlySelectedItemInInventory() != 4) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 5 && ntscUC32BitCutsceneIdMaster() == 324096 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 251136
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 5 && ntscUC32BitCutsceneIdMaster() == 345472 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 94304 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 5008
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 5 && ntscUC8BitChapterId() == 6))
)

achievement(
    title = "Through The Lens Of Survival", points = 3, type="progression",
    description = "Complete chapter 4, using a sign",
    id = 310149, badge = "461658", published = "19/04/2023 16:09:53", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(ntscUC32BitCutsceneIdMaster()) != ntscUC32BitCutsceneIdMaster()) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitCurrentlySelectedItemInInventory() != 5) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 5 && ntscUC32BitCutsceneIdMaster() == 345472 && ntscUC16BitCutsceneSectionId1() == 13 &&
                    ntscUC16BitCutsceneSectionId2() == 14 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 46816 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44624
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 5 && ntscUC8BitChapterId() == 6))
)

achievement(
    title = "Nine Lives Across Generations", points = 4, type="missable",
    description = "Gift a feline friend to a girl during or after chapter 4",
    id = 310426, badge = "466048", published = "20/04/2023 18:06:14", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitAreaRoomIdentification() == 1539 && bit0Kitten() == 1 && ntscUC32BitCutsceneIdMaster() == 152064 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 11264 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 67888
              ) && bit6(0xA9EDCB) == 1 && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Even I Can Do That", points = 4, type="missable",
    description = "Become a performer and give yourself a message during chapter 4",
    id = 402284, badge = "466006", published = "25/02/2024 11:33:55", modified = "25/02/2024 11:33:55",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(prev(ntscUC32BitCutsceneIdMaster()) != ntscUC32BitCutsceneIdMaster()) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 12 && bit2(0xA9EDA5) == 1 &&
                  ntscUC32BitCutsceneIdMaster() == 107264 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14848
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "A Performance Gone The Extra Mile", points = 5, type="missable",
    description = "Make sure the performer goes the extra mile for those who would appreciate his gesture, including yourself",
    id = 403575, badge = "466007", published = "29/02/2024 15:31:22", modified = "29/02/2024 15:31:22",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 5) && never(repeated(300, bit2(0xA9EDA5) == 0)) &&
              measured(tally(7,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 391 && ntscUC32BitAreaRoomIdentification() == 885 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 68 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 924),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 70 && ntscUC32BitAreaRoomIdentification() == 885 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 68 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 822),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 66 && ntscUC32BitAreaRoomIdentification() == 885 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 68 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 803),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 68 && ntscUC32BitAreaRoomIdentification() == 885 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 68 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 812),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 405 && ntscUC32BitAreaRoomIdentification() == 22 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 41 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 966),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 387 && ntscUC32BitAreaRoomIdentification() == 22 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 41 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 972),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 12 && ntscUC32BitCutsceneIdMaster() == 107264 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14848))
              ) &&
              ((trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)) ||
               (trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
                trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)))
)

achievement(
    title = "Complexities Of The Fourth Dimension", points = 4, type="missable",
    description = "Get lectured in time-travelling physics during chapter 4",
    id = 310163, badge = "464226", published = "19/04/2023 19:40:38", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 5) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              tally(1,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 4 && ntscUC32BitCutsceneIdMaster() == 721152 && ntscUC16BitCutsceneSectionId1() == 13 &&
                  ntscUC16BitCutsceneSectionId2() == 14 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 126896 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44656),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 5 && ntscUC32BitCutsceneIdMaster() == 721152 && ntscUC16BitCutsceneSectionId1() == 13 &&
                  ntscUC16BitCutsceneSectionId2() == 14 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 125600 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44656)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Horologic Heritage", points = 2, type="missable",
    description = "Kindle the joy of watchmaking to an ancestor of the Franssen's",
    id = 405460, badge = "466008", published = "6/03/2024 15:30:06", modified = "6/03/2024 15:30:06",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((ntscUC8BitChapterId() != 7 && ntscUC8BitChapterId() != 8 && ntscUC8BitChapterId() != 9 && ntscUC8BitChapterId() != 11)) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitCurrentlySelectedItemInInventory() == 16 && ntscUC32BitCutsceneIdMaster() == 70848 && ntscUC16BitCutsceneSectionId1() == 65535 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 44368 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 70816
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Pan In Advance", points = 3, type="missable",
    description = "Acquire an iron plate before chapter 4 and use it once it becomes necessary",
    id = 403823, badge = "466009", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 5) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitCurrentlySelectedItemInInventory() != 4) && never(bit0(0xA9F03B) == 1) && never(bit0BlackAndWhitePhotoWithPerformer() == 1) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 324096 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 72912 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 251136
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Ancient Elixir", points = 5, type="progression",
    description = "Complete chapter 5",
    id = 311616, badge = "466010", published = "25/04/2023 18:57:11", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 6 && ntscUC8BitCurrentlySelectedItemInInventory() == 17 && ntscUC32BitCutsceneIdMaster() == 260480 &&
                    ntscUC16BitCutsceneSectionId1() == 65535 && ntscUC16BitCutsceneSectionId2() == 0 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 260480
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 6 && ntscUC8BitChapterId() == 7))
)

achievement(
    title = "A Complimentary Dinner", points = 3, type="missable",
    description = "Enjoy a free supper at Bar Zum Ei during chapter 5",
    id = 405461, badge = "466011", published = "6/03/2024 15:30:07", modified = "6/03/2024 15:30:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 6) && never((bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0)) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 403520 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 156064 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27840 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 638304 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 27840
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 1023168 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 24240 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 998896 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2812512 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 998896
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "A Mother's Child", points = 2, type="missable",
    description = "Find Hugo outside his house during chapter 5",
    id = 311466, badge = "466012", published = "24/04/2023 18:48:54", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 6) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 257280 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 12560 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 244672 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2632416 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 244672
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Barman's Mystery Child", points = 3, type="missable",
    description = "Discover the truth about the barman's grandchildren during chapter 5",
    id = 315567, badge = "466013", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 6) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 852480 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 250512 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 601904
              ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3 && ntscUC8BitFlagIsCutsceneActivePreferred() <= 3 && ntscUC8BitFlagIsCutsceneActivePreferred() != 0
)

achievement(
    title = "Art Muse", points = 3, type="missable",
    description = "Inspire an acclaimed artist and appraise his work",
    id = 403824, badge = "466014", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) && never(bit5(0xA9EDAA) == 1) &&
              tally(1,
                  once((ntscUC32BitAreaRoomIdentification() == 50 || ntscUC32BitAreaRoomIdentification() == 749) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 292),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 356 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 293),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 357 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 294),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 362 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 295),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 358 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 296),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 360 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 297)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Eike Franssen", points = 5, type="missable",
    description = "Become a beacon of inspiration for an acclaimed artist and appraise all his works",
    id = 403825, badge = "466015", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != prev(ntscUC8BitChapterId())) &&
              trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0) &&
              measured(tally(6,
                  once((ntscUC32BitAreaRoomIdentification() == 50 || ntscUC32BitAreaRoomIdentification() == 749) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 355 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 292),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 356 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 293),
                  once((ntscUC32BitAreaRoomIdentification() == 345 || ntscUC32BitAreaRoomIdentification() == 56) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 357 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 294),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 362 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 295),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 358 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 296),
                  once((ntscUC32BitAreaRoomIdentification() == 548 || ntscUC32BitAreaRoomIdentification() == 445) && ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 360 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 297))
              )
)

achievement(
    title = "Director's Cut: Trip For Two", points = 3, type="progression",
    description = "Complete chapter 6, by co-directing a love picture",
    id = 313210, badge = "466017", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 645952 && ntscUC16BitCutsceneSectionId1() == 7 && ntscUC16BitCutsceneSectionId2() == 8 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 7 && ntscUC8BitChapterId() == 8))
)

achievement(
    title = "Director's Cut: The Time Of Reckoning", points = 3, type="progression",
    description = "Complete chapter 6, by co-directing a thriller picture",
    id = 313211, badge = "466016", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 645952 && ntscUC16BitCutsceneSectionId1() == 7 && ntscUC16BitCutsceneSectionId2() == 8 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 7 && ntscUC8BitChapterId() == 8))
)

achievement(
    title = "Time Ego Flop", points = 1, type="missable",
    description = "Co-direct 'Time Ego Trip World Conquest' during chapter 6",
    id = 313212, badge = "466018", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 7) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit7(0xA9EDB7) == 1 &&
                  bit0(0xA9EDB8) == 1 && ntscUC32BitCutsceneIdMaster() == 489856 && ntscUC16BitCutsceneSectionId1() == 10 && ntscUC16BitCutsceneSectionId2() == 11 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 8336 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 89424
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "Cracking Open The Past: The Old Century", points = 4, type="missable",
    description = "Pay for some coffee with an oval shaped object from chapter 6 onward",
    id = 313213, badge = "466019", published = "1/05/2023 15:18:04", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(bit0EggShapedPocketWatch() == 0) &&
              never((ntscUC8BitChapterId() != 7 && ntscUC8BitChapterId() != 8 && ntscUC8BitChapterId() != 9 && ntscUC8BitChapterId() != 11)) &&
              tally(1,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitAreaRoomIdentification() == 569 && ntscUC32BitCutsceneIdMaster() == 570432 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 242592 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 327808 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 913376 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 327808),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitAreaRoomIdentification() == 569 && ntscUC32BitCutsceneIdMaster() == 705728 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 371744 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 333936 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 519216 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 194352)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Illusive Guardian Of The Brums", points = 4, type="missable",
    description = "Save a member of the Brum family from a predestined death during chapter 6",
    id = 315569, badge = "466020", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 7) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitAreaRoomIdentification() == 1125 && ntscUC32BitCutsceneIdMaster() == 965312 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 345840 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 20656
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Meditating Man", points = 1, type="missable",
    description = "Find someone who has also met the meditating man in chapter 6",
    id = 405098, badge = "466021", published = "5/03/2024 14:02:39", modified = "5/03/2024 14:02:39",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 7) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && ntscUC32BitAreaRoomIdentification() == 21 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 397 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 999 &&
                  npcTalkCountOlderMan1980Chapter6CafeSonne() == 1
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Picked Up A Baby The Other Day", points = 2, type="missable",
    description = "Uncover a snowy crime scene during chapter 6",
    id = 313209, badge = "466022", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 7) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitAreaRoomIdentification() == 1125 && ntscUC32BitCutsceneIdMaster() == 480960 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 18016 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 324112 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 756624 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 324112
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Friend's Repentance", points = 5, type="progression",
    description = "Complete chapter 7",
    id = 315565, badge = "466023", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 8 && ntscUC32BitCutsceneIdMaster() == 274496 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 8 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    ntscUC32BitCutsceneIdMaster() == 813056 && ntscUC16BitCutsceneSectionId1() == 5 && ntscUC16BitCutsceneSectionId2() == 4 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 284448 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 445648),
                    once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 8 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    ntscUC32BitCutsceneIdMaster() == 859072 && ntscUC16BitCutsceneSectionId1() == 3 && ntscUC16BitCutsceneSectionId2() == 4 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 294912 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 373136)
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 8 && ntscUC32BitCutsceneIdMaster() == 73792 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 3296 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 70448
                ) && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 8 && (ntscUC8BitChapterId() == 9 || ntscUC8BitChapterId() == 11)))
)

achievement(
    title = "Fated To Plunge", points = 1, type="missable",
    description = "Use an aged cable to save yourself in chapter 7",
    id = 315563, badge = "466024", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 8) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 87616 && ntscUC16BitCutsceneSectionId1() == 5 && ntscUC16BitCutsceneSectionId2() == 6 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 30768 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 8736
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 145344 && prior(ntscUC32BitCutsceneIdMaster()) == 87616 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44640
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) > 3) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() <= 3) &&
              trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() != 0)
)

achievement(
    title = "The Next Big Thing", points = 4, type="missable",
    description = "Inspire the movie director for a 2nd time in chapter 7",
    id = 404045, badge = "466025", published = "2/03/2024 21:18:07", modified = "2/03/2024 21:18:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 8) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit3(0xA9EDCC) == 1 && ntscUC32BitCutsceneIdMaster() == 659264 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 283504 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 375696 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 588000 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 375696
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Pair Of Delinquents", points = 2, type="missable",
    description = "Encounter some rascals in chapter 7",
    id = 404048, badge = "466031", published = "2/03/2024 22:13:05", modified = "2/03/2024 22:13:05",
    trigger = never(ntscUC32BitAreaRoomIdentification() != 68) &&
              measured(tally(2,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 19 && npcTalkCountSlimDelinquentPresentChapter7CarPark() == 1 &&
                  prev(npcTalkCountSlimDelinquentPresentChapter7CarPark()) == 0 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 757),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 1 && dword(ntscUC25BitPointerInteractions() & 0x1FFFFFF) == 16 && npcTalkCountBroadDelinquentPresentChapter7CarPark() == 1 &&
                  prev(npcTalkCountBroadDelinquentPresentChapter7CarPark()) == 0 && dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 178 &&
                  dword(ntscUC25BitPointerInteractionIdentification() & 0x1FFFFFF) == 752)), when=low4(0xA9EDDC) != 0
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "Bump... Erased", points = 1, type="missable",
    description = "Run into yourself during chapter 7",
    id = 314763, badge = "466026", published = "5/05/2023 8:58:07", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 8) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once((dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 147168) &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 227296 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 147120
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Hatchless Replica", points = 4, type="missable",
    description = "Show off your egg collection to a younger barman during chapter 7",
    id = 315561, badge = "466027", published = "7/05/2023 18:08:31", modified = "7/05/2023 18:08:31",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(ntscUC8BitChapterId() != 8) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0EggShapedPocketWatch() == 1 && ntscUC32BitCutsceneIdMaster() == 577152 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 312832 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 145056 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 460352 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 145056
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Brums Happily Ever After", points = 10, type="missable",
    description = "Meet Eckart's wife in Chapter 7, after saving her",
    id = 315570, badge = "466028", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) && never(ntscUC8BitChapterId() != 8) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC32BitCutsceneIdMaster() == 274496 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 31968 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 55616
              ) &&
              tally(1,
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && ntscUC32BitCutsceneIdMaster() == 817472 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 29712),
                  once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && ntscUC32BitCutsceneIdMaster() == 730432 &&
                  ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27888)
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Whole Picture... Or Is It?", points = 5, type="progression",
    description = "Complete chapter 8",
    id = 315571, badge = "466049", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:08:34",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 570944 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 185408 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 272208
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 1109760 && ntscUC16BitCutsceneSectionId1() == 9 &&
                    ntscUC16BitCutsceneSectionId2() == 8 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 46624 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 62672
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 935936 && ntscUC16BitCutsceneSectionId1() == 9 &&
                    ntscUC16BitCutsceneSectionId2() == 10 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 420512 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 381024
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 873536 && ntscUC16BitCutsceneSectionId1() == 7 &&
                    ntscUC16BitCutsceneSectionId2() == 6 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 267600 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 177184
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 464576 && ntscUC16BitCutsceneSectionId1() == 9 &&
                    ntscUC16BitCutsceneSectionId2() == 10 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 145904 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 106224
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 998528 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 597040 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 401456
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 1031424 && ntscUC16BitCutsceneSectionId1() == 5 &&
                    ntscUC16BitCutsceneSectionId2() == 4 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 392960 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 159536
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 806464 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 1031424 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 403024 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27616
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 9 && ntscUC32BitCutsceneIdMaster() == 117696 && ntscUC16BitCutsceneSectionId1() == 5 &&
                    ntscUC16BitCutsceneSectionId2() == 4 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 51424 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 39152
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 11 && ntscUC32BitCutsceneIdMaster() == 490048 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 169728 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 204752 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 285200
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 11 && ntscUC32BitCutsceneIdMaster() == 307520 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 490048 && ntscUC16BitCutsceneSectionId1() == 5 && ntscUC16BitCutsceneSectionId2() == 4 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 74416 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 100848
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 11 && ntscUC32BitCutsceneIdMaster() == 824384 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 655552 && ntscUC16BitCutsceneSectionId1() == 3 && ntscUC16BitCutsceneSectionId2() == 2 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 289616 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 534688
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 11 && ntscUC32BitCutsceneIdMaster() == 1055680 && ntscUC16BitCutsceneSectionId1() == 1 &&
                    ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 489760 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 468432
                ) &&
                once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 11 && ntscUC32BitCutsceneIdMaster() == 1275136 &&
                    prior(ntscUC32BitCutsceneIdMaster()) == 1055680 && ntscUC16BitCutsceneSectionId1() == 12 && ntscUC16BitCutsceneSectionId2() == 13 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 507376 &&
                    dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 348816
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0 && ntscUC8BitFlagIsCutsceneActivePreferred() == 0) ||
               (prev(ntscUC8BitChapterId()) == 9 && ntscUC8BitChapterId() == 10) ||
               (prev(ntscUC8BitChapterId()) == 11 && ntscUC8BitChapterId() == 12))
)

achievement(
    title = "The Eggcellent Director's Tale", points = 4, type="missable",
    description = "Reminisce about your egg collection with Eckart during chapter 8",
    id = 315562, badge = "466029", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((ntscUC8BitChapterId() != 9 && ntscUC8BitChapterId() != 11)) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0EggShapedPocketWatch() == 1 && ntscUC32BitCutsceneIdMaster() == 580800 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 203408 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 42016 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 916416 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 42016
              ) && trigger_when(prev(ntscUC8BitFlagIsCutsceneActivePreferred()) != 0) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "An End To A Strange Experience", points = 5, type="win_condition",
    description = "Achieve ending A",
    id = 315566, badge = "466030", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 0
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 898944 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 7088 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 208096
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 491392 &&
                  prior(ntscUC32BitCutsceneIdMaster()) == 898944 && ntscUC16BitCutsceneSectionId1() == 3 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 154704 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 109712
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0(0xAA1154) == 1)
)

achievement(
    title = "No Sense Of Finality I", points = 5, type="win_condition",
    description = "Achieve ending B1",
    id = 315573, badge = "466033", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 398272 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 277936 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 120272
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 352832 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingBUnlocked() == 1)
)

achievement(
    title = "No Sense Of Finality II", points = 5, type="win_condition",
    description = "Achieve ending B2",
    id = 315572, badge = "466032", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 594496 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 381632 &&
                  prior(ntscUC32BitCutsceneIdMaster()) == 594496 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 126928 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 352832 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 0 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingBUnlocked() == 1)
)

achievement(
    title = "If Only... I Had One More Attempt", points = 5, type="win_condition",
    description = "Achieve ending C",
    id = 317118, badge = "461671", published = "14/05/2023 10:33:35", modified = "14/05/2023 10:33:35",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 2
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 577280 && ntscUC16BitCutsceneSectionId1() == 1 &&
                  ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 504128 &&
                  prior(ntscUC32BitCutsceneIdMaster()) == 577280 && ntscUC16BitCutsceneSectionId1() == 3 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 120112 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 10 && ntscUC32BitCutsceneIdMaster() == 833280 &&
                  prior(ntscUC32BitCutsceneIdMaster()) == 504128 && ntscUC16BitCutsceneSectionId1() == 5 && ntscUC16BitCutsceneSectionId2() == 6 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 6528 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 125136
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingCUnlocked() == 1)
)

achievement(
    title = "Eike's Origins", points = 5, type="win_condition",
    description = "Achieve ending D",
    id = 322230, badge = "466034", published = "28/05/2023 11:34:23", modified = "28/05/2023 11:34:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 3
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 12 && ntscUC32BitCutsceneIdMaster() == 461248 && ntscUC16BitCutsceneSectionId1() == 3 &&
                  ntscUC16BitCutsceneSectionId2() == 4 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 149360 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 71568
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 12 && ntscUC32BitCutsceneIdMaster() == 809792 && ntscUC16BitCutsceneSectionId1() == 3 &&
                  ntscUC16BitCutsceneSectionId2() == 4 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 432960 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 138048
              ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingDUnlocked() == 1)
)

achievement(
    title = "The Future Is What We Make It", points = 5, type="win_condition",
    description = "Achieve ending E",
    id = 322231, badge = "461673", published = "28/05/2023 11:34:26", modified = "28/05/2023 11:34:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 4
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 12 && ntscUC32BitCutsceneIdMaster() == 560576 && ntscUC16BitCutsceneSectionId1() == 3 &&
                  ntscUC16BitCutsceneSectionId2() == 2 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 181152 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 379392
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 12 && ntscUC32BitCutsceneIdMaster() == 782208 && ntscUC16BitCutsceneSectionId1() == 9 &&
                  ntscUC16BitCutsceneSectionId2() == 8 && dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 368480 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 87520
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && ntscUC8BitChapterId() == 12 && ntscUC32BitCutsceneIdMaster() == 842944 &&
                  prior(ntscUC32BitCutsceneIdMaster()) == 782208 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 2 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 209456 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 137088
              ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingEUnlocked() == 1)
)

achievement(
    title = "The Philosopher's Wisdom", points = 1, type="missable",
    description = "Acquire one last message during the EX chapter",
    id = 405112, badge = "466035", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit7(0xA9ED98) == 1 && ntscUC8BitChapterId() == 1 && bit0(0xAA1154) == 1 &&
                  bit0EndingBUnlocked() == 1 && bit0EndingCUnlocked() == 1 && bit0EndingDUnlocked() == 1 && bit0EndingEUnlocked() == 1 &&
                  ntscUC32BitCutsceneIdMaster() == 198528 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54768 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 3600 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 523536 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 3600
              ) && trigger_when(bit0OrnamentalEgg() == 1) && trigger_when(ntscUC8BitFlagIsCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Philosopher's Destiny", points = 3, type="missable",
    description = "Achieve ending EX, by destroying the jewel",
    id = 405113, badge = "461652", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0PhilosopherSStone() == 1 && bit7(0xA9ED98) == 1 && ntscUC8BitChapterId() == 1 &&
                  bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 && bit0EndingCUnlocked() == 1 && bit0EndingDUnlocked() == 1 &&
                  bit0EndingEUnlocked() == 1 && ntscUC32BitCutsceneIdMaster() == 686720 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 234736 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 16816 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 1315744 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 16816
              ) &&
              once(ntscUC8BitChapterId() == 1 && ntscUC32BitCutsceneIdMaster() == 424256 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingExUnlocked() == 1)
)

achievement(
    title = "The Philosopher's Legacy", points = 3, type="missable",
    description = "Achieve ending EX, by creating a miracle cure",
    id = 405114, badge = "466036", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((ntscUC32BitFlagIsEventViewerActivePreferred() == 33 && dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((ntscUC25BitPointerExtraMenuNavigation() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((ntscUC25BitPointerEndingFileIdentificationData() & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(ntscUC8BitFlagIsCutsceneActivePreferred() == 5 && bit0PhilosopherSStone() == 1 && bit7(0xA9ED98) == 1 && ntscUC8BitChapterId() == 1 &&
                  bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 && bit0EndingCUnlocked() == 1 && bit0EndingDUnlocked() == 1 &&
                  bit0EndingEUnlocked() == 1 && ntscUC32BitCutsceneIdMaster() == 363520 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 157936 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 72640 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 467440 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 72640
              ) &&
              once(ntscUC8BitChapterId() == 1 && ntscUC32BitCutsceneIdMaster() == 424256 && ntscUC16BitCutsceneSectionId1() == 1 && ntscUC16BitCutsceneSectionId2() == 0 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((ntscUC25BitPointerCutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) == 257) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) &&
              trigger_when(prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) == 65) &&
              trigger_when(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && trigger_when(bit0EndingExUnlocked() == 1)
)

achievement(
    title = "Homing Instinct", points = 10, type="missable",
    description = "Reach 100% achievement rate for the prologue, including the EX chapter",
    id = 405087, badge = "466037", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = (prev(bit1(0xA9ED3C)) + prev(bit2(0xA9ED3C)) + prev(bit3(0xA9ED3C)) + prev(bit4(0xA9ED3C)) +
              prev(bit5(0xA9ED3C)) + prev(bit6(0xA9ED3C)) + prev(bit7(0xA9ED3C)) + prev(achievementPercentageFlagsPrologueExChapter()) +
              prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter())
              + prev(bit0(0xA9ED42)) + prev(bit1(0xA9ED42)) + prev(bit2(0xA9ED42)) + prev(bit3(0xA9ED42)) +
              prev(bit4(0xA9ED42)) + prev(bit5(0xA9ED42))) < 53 &&
              measured((bit1(0xA9ED3C) + bit2(0xA9ED3C) + bit3(0xA9ED3C) + bit4(0xA9ED3C) + bit5(0xA9ED3C) +
                  bit6(0xA9ED3C) + bit7(0xA9ED3C) + achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() +
                  achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() + bit0(0xA9ED42) + bit1(0xA9ED42) + bit2(0xA9ED42) +
                  bit3(0xA9ED42) + bit4(0xA9ED42) + bit5(0xA9ED42)) == 53, when=ntscUC8BitChapterId() == 1 && low4(0xA9EDDC) != 0,
                  format="percent"
              )
)

achievement(
    title = "In The Heat Of Time", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 1",
    id = 405088, badge = "466038", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = (prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) + prev(achievementPercentageFlagsChapter1()) + prev(achievementPercentageFlagsChapter1()) +
              prev(bit0(0xA9ED46)) + prev(bit1(0xA9ED46)) + prev(bit2(0xA9ED46)) + prev(bit3(0xA9ED46)) +
              prev(bit4(0xA9ED46)) + prev(bit5(0xA9ED46))) < 24 &&
              measured((bit6(0xA9ED43) + bit7(0xA9ED43) + achievementPercentageFlagsChapter1() + achievementPercentageFlagsChapter1() + bit0(0xA9ED46) +
                  bit1(0xA9ED46) + bit2(0xA9ED46) + bit3(0xA9ED46) + bit4(0xA9ED46) + bit5(0xA9ED46)) == 24,
                  when=ntscUC8BitChapterId() == 2 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "Dana Kusch", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 2",
    id = 405089, badge = "466039", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = (prev(bit3(0xA9ED47)) + prev(bit4(0xA9ED47)) + prev(bit5(0xA9ED47)) + prev(bit6(0xA9ED47)) +
              prev(bit7(0xA9ED47)) + prev(achievementPercentageFlagsChapter2()) + prev(achievementPercentageFlagsChapter2()) + prev(achievementPercentageFlagsChapter2()) +
              prev(bit0(0xA9ED4B)) + prev(bit1(0xA9ED4B)) + prev(bit2(0xA9ED4B)) + prev(bit3(0xA9ED4B)) +
              prev(bit4(0xA9ED4B)) + prev(bit5(0xA9ED4B)) + prev(bit6(0xA9ED4B))) < 36 &&
              measured((bit3(0xA9ED47) + bit4(0xA9ED47) + bit5(0xA9ED47) + bit6(0xA9ED47) + bit7(0xA9ED47) +
                  achievementPercentageFlagsChapter2() + achievementPercentageFlagsChapter2() + achievementPercentageFlagsChapter2() + bit0(0xA9ED4B) + bit1(0xA9ED4B) +
                  bit2(0xA9ED4B) + bit3(0xA9ED4B) + bit4(0xA9ED4B) + bit5(0xA9ED4B) + bit6(0xA9ED4B)) == 36,
                  when=ntscUC8BitChapterId() == 3 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "The Root Of The Problem", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 3",
    id = 405090, badge = "466040", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit2(0xA9ED58)) + prev(bit3(0xA9ED58)) + prev(bit4(0xA9ED58)) + prev(bit5(0xA9ED58)) +
              prev(bit6(0xA9ED58)) + prev(bit7(0xA9ED58)) + prev(achievementPercentageFlagsChapter3()) + prev(achievementPercentageFlagsChapter3())) < 22 &&
              measured((bit2(0xA9ED58) + bit3(0xA9ED58) + bit4(0xA9ED58) + bit5(0xA9ED58) + bit6(0xA9ED58) +
                  bit7(0xA9ED58) + achievementPercentageFlagsChapter3() + achievementPercentageFlagsChapter3()) == 22,
                  when=ntscUC8BitChapterId() == 4 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "The Monochrome Era", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 4",
    id = 405091, badge = "466041", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit1(0xA9ED4D)) + prev(bit2(0xA9ED4D)) + prev(bit3(0xA9ED4D)) + prev(bit4(0xA9ED4D)) +
              prev(bit5(0xA9ED4D)) + prev(bit6(0xA9ED4D)) + prev(bit7(0xA9ED4D)) + prev(achievementPercentageFlagsChapter4()) +
              prev(achievementPercentageFlagsChapter4()) + prev(achievementPercentageFlagsChapter4()) + prev(bit0(0xA9ED51)) + prev(bit1(0xA9ED51)) +
              prev(bit2(0xA9ED51)) + prev(bit3(0xA9ED51)) + prev(bit4(0xA9ED51))) < 36 &&
              measured((bit1(0xA9ED4D) + bit2(0xA9ED4D) + bit3(0xA9ED4D) + bit4(0xA9ED4D) + bit5(0xA9ED4D) +
                  bit6(0xA9ED4D) + bit7(0xA9ED4D) + achievementPercentageFlagsChapter4() + achievementPercentageFlagsChapter4() + achievementPercentageFlagsChapter4() +
                  bit0(0xA9ED51) + bit1(0xA9ED51) + bit2(0xA9ED51) + bit3(0xA9ED51) + bit4(0xA9ED51)) == 36,
                  when=ntscUC8BitChapterId() == 5 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "Meddling With Destiny", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 5",
    id = 405092, badge = "466042", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit1(0xA9ED52)) + prev(bit2(0xA9ED52)) + prev(bit3(0xA9ED52)) + prev(bit4(0xA9ED52)) +
              prev(bit5(0xA9ED52)) + prev(bit6(0xA9ED52)) + prev(bit7(0xA9ED52)) + prev(achievementPercentageFlagsChapter5()) +
              prev(achievementPercentageFlagsChapter5()) + prev(achievementPercentageFlagsChapter5()) + prev(achievementPercentageFlagsChapter5()) + prev(bit0(0xA9ED57)) +
              prev(bit1(0xA9ED57)) + prev(bit2(0xA9ED57)) + prev(bit3(0xA9ED57)) + prev(bit4(0xA9ED57)) +
              prev(bit5(0xA9ED57)) + prev(bit6(0xA9ED57))) < 46 &&
              measured((bit1(0xA9ED52) + bit2(0xA9ED52) + bit3(0xA9ED52) + bit4(0xA9ED52) + bit5(0xA9ED52) +
                  bit6(0xA9ED52) + bit7(0xA9ED52) + achievementPercentageFlagsChapter5() + achievementPercentageFlagsChapter5() + achievementPercentageFlagsChapter5() +
                  achievementPercentageFlagsChapter5() + bit0(0xA9ED57) + bit1(0xA9ED57) + bit2(0xA9ED57) + bit3(0xA9ED57) + bit4(0xA9ED57) +
                  bit5(0xA9ED57) + bit6(0xA9ED57)) == 46, when=ntscUC8BitChapterId() == 6 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "The Good Samaritan", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 6",
    id = 405093, badge = "466043", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit2(0xA9ED5B)) + prev(bit3(0xA9ED5B)) + prev(bit4(0xA9ED5B)) + prev(bit5(0xA9ED5B)) +
              prev(bit6(0xA9ED5B)) + prev(bit7(0xA9ED5B)) + prev(achievementPercentageFlagsChapter6()) + prev(achievementPercentageFlagsChapter6()) +
              prev(achievementPercentageFlagsChapter6()) + prev(bit0(0xA9ED5F)) + prev(bit1(0xA9ED5F)) + prev(bit2(0xA9ED5F)) +
              prev(bit3(0xA9ED5F)) + prev(bit4(0xA9ED5F))) < 35 &&
              measured((bit2(0xA9ED5B) + bit3(0xA9ED5B) + bit4(0xA9ED5B) + bit5(0xA9ED5B) + bit6(0xA9ED5B) +
                  bit7(0xA9ED5B) + achievementPercentageFlagsChapter6() + achievementPercentageFlagsChapter6() + achievementPercentageFlagsChapter6() + bit0(0xA9ED5F) +
                  bit1(0xA9ED5F) + bit2(0xA9ED5F) + bit3(0xA9ED5F) + bit4(0xA9ED5F)) == 35,
                  when=ntscUC8BitChapterId() == 7 && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "Vintage Knots", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 7",
    id = 405094, badge = "466044", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit2(0xA9ED60)) + prev(bit3(0xA9ED60)) + prev(bit4(0xA9ED60)) + prev(bit5(0xA9ED60)) +
              prev(bit6(0xA9ED60)) + prev(bit7(0xA9ED60)) + prev(achievementPercentageFlagsChapter7()) + prev(achievementPercentageFlagsChapter7()) +
              prev(achievementPercentageFlagsChapter7()) + prev(bit0(0xA9ED64)) + prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) +
              prev(bit3(0xA9ED64))) < 34 &&
              measured((bit2(0xA9ED60) + bit3(0xA9ED60) + bit4(0xA9ED60) + bit5(0xA9ED60) + bit6(0xA9ED60) +
                  bit7(0xA9ED60) + achievementPercentageFlagsChapter7() + achievementPercentageFlagsChapter7() + achievementPercentageFlagsChapter7() + bit0(0xA9ED64) +
                  bit1(0xA9ED64) + bit2(0xA9ED64) + bit3(0xA9ED64)) == 34, when=ntscUC8BitChapterId() == 8 && low4(0xA9EDDC) != 0,
                  format="percent"
              )
)

achievement(
    title = "The Power Of Fate", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 8",
    id = 405095, badge = "466045", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = (prev(bit5(0xA9ED65)) + prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(achievementPercentageFlagsChapter8()) +
              prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8())
              + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(bit0(0xA9ED6E)) +
              prev(bit1(0xA9ED6E)) + prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E))) < 71 &&
              measured((bit5(0xA9ED65) + bit6(0xA9ED65) + bit7(0xA9ED65) + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() +
                  achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() +
                  achievementPercentageFlagsChapter8() + bit0(0xA9ED6E) + bit1(0xA9ED6E) + bit2(0xA9ED6E) + bit3(0xA9ED6E)) == 71,
                  when=(ntscUC8BitChapterId() == 9 || ntscUC8BitChapterId() == 11) && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "Eternal Youth", points = 10, type="missable",
    description = "Reach 100% achievement rate for the epilogue",
    id = 405096, badge = "466046", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = (prev(bit2(0xA9ED71)) + prev(bit3(0xA9ED71)) + prev(bit4(0xA9ED71)) + prev(bit5(0xA9ED71)) +
              prev(bit6(0xA9ED71)) + prev(bit7(0xA9ED71)) + prev(achievementPercentageFlagsEpilogue()) + prev(achievementPercentageFlagsEpilogue()) +
              prev(bit0(0xA9ED74))) < 23 &&
              measured((bit2(0xA9ED71) + bit3(0xA9ED71) + bit4(0xA9ED71) + bit5(0xA9ED71) + bit6(0xA9ED71) +
                  bit7(0xA9ED71) + achievementPercentageFlagsEpilogue() + achievementPercentageFlagsEpilogue() + bit0(0xA9ED74)) == 23,
                  when=(ntscUC8BitChapterId() == 10 || ntscUC8BitChapterId() == 12) && low4(0xA9EDDC) != 0, format="percent"
              )
)

achievement(
    title = "The Day Of Walpurgis", points = 50, type="missable",
    description = "Reach 100% total achievement rate",
    id = 405097, badge = "466047", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = (prev(bit1(0xA9ED3C)) + prev(bit2(0xA9ED3C)) + prev(bit3(0xA9ED3C)) + prev(bit4(0xA9ED3C)) +
              prev(bit5(0xA9ED3C)) + prev(bit6(0xA9ED3C)) + prev(bit7(0xA9ED3C)) + prev(achievementPercentageFlagsPrologueExChapter()) +
              prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter()) + prev(achievementPercentageFlagsPrologueExChapter())
              + prev(bit0(0xA9ED42)) + prev(bit1(0xA9ED42)) + prev(bit2(0xA9ED42)) + prev(bit3(0xA9ED42)) +
              prev(bit4(0xA9ED42)) + prev(bit5(0xA9ED42)) + prev(bit6(0xA9ED43)) + prev(bit7(0xA9ED43)) +
              prev(achievementPercentageFlagsChapter1()) + prev(achievementPercentageFlagsChapter1()) + prev(bit0(0xA9ED46)) + prev(bit1(0xA9ED46)) +
              prev(bit2(0xA9ED46)) + prev(bit3(0xA9ED46)) + prev(bit4(0xA9ED46)) + prev(bit5(0xA9ED46)) +
              prev(bit3(0xA9ED47)) + prev(bit4(0xA9ED47)) + prev(bit5(0xA9ED47)) + prev(bit6(0xA9ED47)) +
              prev(bit7(0xA9ED47)) + prev(achievementPercentageFlagsChapter2()) + prev(achievementPercentageFlagsChapter2()) + prev(achievementPercentageFlagsChapter2()) +
              prev(bit0(0xA9ED4B)) + prev(bit1(0xA9ED4B)) + prev(bit2(0xA9ED4B)) + prev(bit3(0xA9ED4B)) +
              prev(bit4(0xA9ED4B)) + prev(bit5(0xA9ED4B)) + prev(bit6(0xA9ED4B)) + prev(bit1(0xA9ED4D)) +
              prev(bit2(0xA9ED4D)) + prev(bit3(0xA9ED4D)) + prev(bit4(0xA9ED4D)) + prev(bit5(0xA9ED4D)) +
              prev(bit6(0xA9ED4D)) + prev(bit7(0xA9ED4D)) + prev(achievementPercentageFlagsChapter4()) + prev(achievementPercentageFlagsChapter4()) +
              prev(achievementPercentageFlagsChapter4()) + prev(bit0(0xA9ED51)) + prev(bit1(0xA9ED51)) + prev(bit2(0xA9ED51)) +
              prev(bit3(0xA9ED51)) + prev(bit4(0xA9ED51)) + prev(bit1(0xA9ED52)) + prev(bit2(0xA9ED52)) +
              prev(bit3(0xA9ED52)) + prev(bit4(0xA9ED52)) + prev(bit5(0xA9ED52)) + prev(bit6(0xA9ED52)) +
              prev(bit7(0xA9ED52)) + prev(achievementPercentageFlagsChapter5()) + prev(achievementPercentageFlagsChapter5()) + prev(achievementPercentageFlagsChapter5()) +
              prev(achievementPercentageFlagsChapter5()) + prev(bit0(0xA9ED57)) + prev(bit1(0xA9ED57)) + prev(bit2(0xA9ED57)) +
              prev(bit3(0xA9ED57)) + prev(bit4(0xA9ED57)) + prev(bit5(0xA9ED57)) + prev(bit6(0xA9ED57)) +
              prev(bit2(0xA9ED58)) + prev(bit3(0xA9ED58)) + prev(bit4(0xA9ED58)) + prev(bit5(0xA9ED58)) +
              prev(bit6(0xA9ED58)) + prev(bit7(0xA9ED58)) + prev(achievementPercentageFlagsChapter3()) + prev(achievementPercentageFlagsChapter3()) +
              prev(bit2(0xA9ED5B)) + prev(bit3(0xA9ED5B)) + prev(bit4(0xA9ED5B)) + prev(bit5(0xA9ED5B)) +
              prev(bit6(0xA9ED5B)) + prev(bit7(0xA9ED5B)) + prev(achievementPercentageFlagsChapter6()) + prev(achievementPercentageFlagsChapter6()) +
              prev(achievementPercentageFlagsChapter6()) + prev(bit0(0xA9ED5F)) + prev(bit1(0xA9ED5F)) + prev(bit2(0xA9ED5F)) +
              prev(bit3(0xA9ED5F)) + prev(bit4(0xA9ED5F)) + prev(bit2(0xA9ED60)) + prev(bit3(0xA9ED60)) +
              prev(bit4(0xA9ED60)) + prev(bit5(0xA9ED60)) + prev(bit6(0xA9ED60)) + prev(bit7(0xA9ED60)) +
              prev(achievementPercentageFlagsChapter7()) + prev(achievementPercentageFlagsChapter7()) + prev(achievementPercentageFlagsChapter7()) + prev(bit0(0xA9ED64)) +
              prev(bit1(0xA9ED64)) + prev(bit2(0xA9ED64)) + prev(bit3(0xA9ED64)) + prev(bit5(0xA9ED65)) +
              prev(bit6(0xA9ED65)) + prev(bit7(0xA9ED65)) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) +
              prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8())
              + prev(achievementPercentageFlagsChapter8()) + prev(achievementPercentageFlagsChapter8()) + prev(bit0(0xA9ED6E)) + prev(bit1(0xA9ED6E)) +
              prev(bit2(0xA9ED6E)) + prev(bit3(0xA9ED6E)) + prev(bit2(0xA9ED71)) + prev(bit3(0xA9ED71)) +
              prev(bit4(0xA9ED71)) + prev(bit5(0xA9ED71)) + prev(bit6(0xA9ED71)) + prev(bit7(0xA9ED71)) +
              prev(achievementPercentageFlagsEpilogue()) + prev(achievementPercentageFlagsEpilogue()) + prev(bit0(0xA9ED74))) < 380 &&
              measured((bit1(0xA9ED3C) + bit2(0xA9ED3C) + bit3(0xA9ED3C) + bit4(0xA9ED3C) + bit5(0xA9ED3C) +
                  bit6(0xA9ED3C) + bit7(0xA9ED3C) + achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() +
                  achievementPercentageFlagsPrologueExChapter() + achievementPercentageFlagsPrologueExChapter() + bit0(0xA9ED42) + bit1(0xA9ED42) + bit2(0xA9ED42) +
                  bit3(0xA9ED42) + bit4(0xA9ED42) + bit5(0xA9ED42) + bit6(0xA9ED43) + bit7(0xA9ED43) + achievementPercentageFlagsChapter1() +
                  achievementPercentageFlagsChapter1() + bit0(0xA9ED46) + bit1(0xA9ED46) + bit2(0xA9ED46) + bit3(0xA9ED46) + bit4(0xA9ED46) +
                  bit5(0xA9ED46) + bit3(0xA9ED47) + bit4(0xA9ED47) + bit5(0xA9ED47) + bit6(0xA9ED47) + bit7(0xA9ED47) +
                  achievementPercentageFlagsChapter2() + achievementPercentageFlagsChapter2() + achievementPercentageFlagsChapter2() + bit0(0xA9ED4B) + bit1(0xA9ED4B) +
                  bit2(0xA9ED4B) + bit3(0xA9ED4B) + bit4(0xA9ED4B) + bit5(0xA9ED4B) + bit6(0xA9ED4B) + bit1(0xA9ED4D) +
                  bit2(0xA9ED4D) + bit3(0xA9ED4D) + bit4(0xA9ED4D) + bit5(0xA9ED4D) + bit6(0xA9ED4D) + bit7(0xA9ED4D) +
                  achievementPercentageFlagsChapter4() + achievementPercentageFlagsChapter4() + achievementPercentageFlagsChapter4() + bit0(0xA9ED51) + bit1(0xA9ED51) +
                  bit2(0xA9ED51) + bit3(0xA9ED51) + bit4(0xA9ED51) + bit1(0xA9ED52) + bit2(0xA9ED52) + bit3(0xA9ED52) +
                  bit4(0xA9ED52) + bit5(0xA9ED52) + bit6(0xA9ED52) + bit7(0xA9ED52) + achievementPercentageFlagsChapter5() +
                  achievementPercentageFlagsChapter5() + achievementPercentageFlagsChapter5() + achievementPercentageFlagsChapter5() + bit0(0xA9ED57) + bit1(0xA9ED57) +
                  bit2(0xA9ED57) + bit3(0xA9ED57) + bit4(0xA9ED57) + bit5(0xA9ED57) + bit6(0xA9ED57) + bit2(0xA9ED58) +
                  bit3(0xA9ED58) + bit4(0xA9ED58) + bit5(0xA9ED58) + bit6(0xA9ED58) + bit7(0xA9ED58) + achievementPercentageFlagsChapter3() +
                  achievementPercentageFlagsChapter3() + bit2(0xA9ED5B) + bit3(0xA9ED5B) + bit4(0xA9ED5B) + bit5(0xA9ED5B) + bit6(0xA9ED5B) +
                  bit7(0xA9ED5B) + achievementPercentageFlagsChapter6() + achievementPercentageFlagsChapter6() + achievementPercentageFlagsChapter6() + bit0(0xA9ED5F) +
                  bit1(0xA9ED5F) + bit2(0xA9ED5F) + bit3(0xA9ED5F) + bit4(0xA9ED5F) + bit2(0xA9ED60) + bit3(0xA9ED60) +
                  bit4(0xA9ED60) + bit5(0xA9ED60) + bit6(0xA9ED60) + bit7(0xA9ED60) + achievementPercentageFlagsChapter7() +
                  achievementPercentageFlagsChapter7() + achievementPercentageFlagsChapter7() + bit0(0xA9ED64) + bit1(0xA9ED64) + bit2(0xA9ED64) +
                  bit3(0xA9ED64) + bit5(0xA9ED65) + bit6(0xA9ED65) + bit7(0xA9ED65) + achievementPercentageFlagsChapter8() +
                  achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() +
                  achievementPercentageFlagsChapter8() + achievementPercentageFlagsChapter8() + bit0(0xA9ED6E) + bit1(0xA9ED6E) + bit2(0xA9ED6E) +
                  bit3(0xA9ED6E) + bit2(0xA9ED71) + bit3(0xA9ED71) + bit4(0xA9ED71) + bit5(0xA9ED71) + bit6(0xA9ED71) +
                  bit7(0xA9ED71) + achievementPercentageFlagsEpilogue() + achievementPercentageFlagsEpilogue() + bit0(0xA9ED74)) == 380,
                  when=low4(0xA9EDDC) != 0, format="percent"
              )
)

leaderboard(
    id = 92194, title = "Total Clear Time",
    description = "Race through time to achieve the fastest total clear time (EX chapter excluded)",
    start  = never(low4(0xA9EDDC) == 0) && repeated(300, low4(0xA9EDDC) != 0) &&
             once(prev(ntscUC32BitCurrentPlaythroughTimerTotalClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerTotalClearTime() > 0) && bit7(0xA9ED98) == 0,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (bit7(0xA9ED98) == 1) ||
              (ntscUC32BitCurrentPlaythroughTimerTotalClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerTotalClearTime()))),
    submit = low4(0xA9EDDC) != 0 &&
             ((prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65 && ntscUC8BitChapterId() == 10) ||
              (prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018)) != 257 &&
               dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257 &&
               prev(dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C)) != 65 &&
               dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65 && ntscUC8BitChapterId() == 12) ||
              (never(((dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257) ||
                   dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65) && ntscUC32BitCurrentPlaythroughTimerTotalClearTime() == prev(ntscUC32BitCurrentPlaythroughTimerTotalClearTime())
               ) &&
               repeated(20,
                   (ntscUC8BitChapterId() == 10 || ntscUC8BitChapterId() == 12) &&
                   dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257 &&
                   dword((ntscUC25BitPointerVideoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65 && ntscUC32BitCurrentPlaythroughTimerTotalClearTime() == prev(ntscUC32BitCurrentPlaythroughTimerTotalClearTime())
               ))),
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerTotalClearTime() / 3600)),
    format = "MINUTES"
)

leaderboard(
    id = 92195, title = "Prologue Clear Time",
    description = "Race through time to achieve the fastest clear time for the prologue (EX chapter excluded)",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 1 && bit7(0xA9ED98) == 0,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (bit7(0xA9ED98) == 1) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 1)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 1 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92196, title = "Chapter 1 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 1",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 2,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 2)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 2 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92197, title = "Chapter 2 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 2",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 3,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 3)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 3 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92198, title = "Chapter 3 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 3",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 4,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 4)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 4 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92199, title = "Chapter 4 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 4",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 5,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 5)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 5 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92200, title = "Chapter 5 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 5",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 6,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 6)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 6 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92201, title = "Chapter 6 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 6",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 7,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 7)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 7 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92202, title = "Chapter 7 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 7",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) && ntscUC8BitChapterId() == 8,
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 8)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 && ntscUC8BitChapterId() == 8 &&
             prev(ntscUC32BitMenuIdentification()) != 1 && prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33,
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

leaderboard(
    id = 92203, title = "Chapter 8 Clear Time",
    description = "Race through time to achieve the fastest clear time for chapter 8",
    start  = never(low4(0xA9EDDC) == 0) && once(prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime()) == 0 && ntscUC32BitCurrentPlaythroughTimerChapterClearTime() > 0) &&
             repeated(700, low4(0xA9EDDC) != 0) &&
             ((ntscUC8BitChapterId() == 9) ||
              (ntscUC8BitChapterId() == 11)),
    cancel = always_true() &&
             ((low4(0xA9EDDC) == 0) ||
              (ntscUC32BitCurrentPlaythroughTimerChapterClearTime() < prev(ntscUC32BitCurrentPlaythroughTimerChapterClearTime())) ||
              (ntscUC8BitChapterId() != 9 && ntscUC8BitChapterId() != 11)),
    submit = ntscUC32BitMenuIdentification() == 1 && ntscUC32BitFlagIsChapterCompleteScreenActive() == 33 && ntscUC32BitHighlightedUiElementWhenChapterCompleteScreenIsActive() <= 1 &&
             (ntscUC8BitChapterId() == 9 || ntscUC8BitChapterId() == 11) && prev(ntscUC32BitMenuIdentification()) != 1 &&
             prev(ntscUC32BitFlagIsChapterCompleteScreenActive()) != 33 &&
             ((ntscUC8BitChapterId() == 9) ||
              (ntscUC8BitChapterId() == 11)),
    value = measured(tally(0, ntscUC32BitCurrentPlaythroughTimerChapterClearTime() / 60)),
    format = "SECS"
)

rich_presence_conditional_display(low4(0xA9EDDC) != 0 && bit7(0xA9ED98) == 1 && bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 && bit0EndingCUnlocked() == 1 &&
    bit0EndingDUnlocked() == 1 && bit0EndingEUnlocked() == 1 && ntscUC8BitChapterId() == 1, "Ending the cycle | The Fated 🕑 {0} | Current 📆 {1} April {2} | Current 🕑 {3} | Completion: {4}%",
    rich_presence_lookup("FatedHour", ntscUC8BitChapterId(), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", presentDay()),
    rich_presence_value("Number", ntscUC668BytesTimeAndDate()),
    rich_presence_value("Minutes", presentMinutes() + presentHours() * 60, format="MINUTES"),
    rich_presence_value("Number", achievementPercentageTotal())
)

rich_presence_conditional_display(low4(0xA9EDDC) != 0 && ntscUC8BitChapterId() != 0 && ntscUC8BitChapterId() <= 11 && bit7(0xA9ED98) == 0 &&
    ((ntscUC8BitChapterId() == 1) ||
     (ntscUC8BitChapterId() == 2) ||
     (ntscUC8BitChapterId() == 10) ||
     (ntscUC8BitChapterId() == 12)), "{0} | The Fated 🕑 {1} | Current 📆 {2} April {3} | Current 🕑 {4} | Completion: {5}%",
    rich_presence_lookup("Chapter", ntscUC8BitChapterId(), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("FatedHour", ntscUC8BitChapterId(), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", presentDay()),
    rich_presence_value("Number", ntscUC668BytesTimeAndDate()),
    rich_presence_value("Minutes", presentMinutes() + presentHours() * 60, format="MINUTES"),
    rich_presence_value("Number", achievementPercentageTotal())
)

rich_presence_conditional_display(low4(0xA9EDDC) != 0 && ntscUC8BitChapterId() != 0 && ntscUC8BitChapterId() <= 11 &&
    ((ntscUC8BitChapterId() == 3) ||
     (ntscUC8BitChapterId() == 4) ||
     (ntscUC8BitChapterId() == 5) ||
     (ntscUC8BitChapterId() == 6) ||
     (ntscUC8BitChapterId() == 7) ||
     (ntscUC8BitChapterId() == 8) ||
     (ntscUC8BitChapterId() == 9) ||
     (ntscUC8BitChapterId() == 11)), "{0} {1} | The Fated 🕑 {2} | Current 📆 {3} April {4} | Current 🕑 {5} | Completion: {6}%",
    rich_presence_lookup("Chapter", ntscUC8BitChapterId(), ChapterLookup, fallback="Roaming Lebensbaum"),
    rich_presence_lookup("TimePeriod", ntscUC32BitTimePeriod(), TimePeriodLookup, fallback="in an unlikely timeline"),
    rich_presence_lookup("FatedHour", ntscUC8BitChapterId(), FatedHourLookup, fallback="a mystery"),
    rich_presence_value("Number", presentDay()),
    rich_presence_value("Number", ntscUC668BytesTimeAndDate()),
    rich_presence_value("Minutes", presentMinutes() + presentHours() * 60, format="MINUTES"),
    rich_presence_value("Number", achievementPercentageTotal())
)

rich_presence_conditional_display(bit0((ntscUC25BitPointerIsMainSaveFileLoadedAtFirstStartupOfGame() & 0x1FFFFFF) + 0x000004) == 1 &&
    ((ntscUC32BitMenuIdentification() == 17 && ntscUC8BitHighlightedButtonAtTitleScreen() != 0 && ntscUC8BitHighlightedButtonAtTitleScreen() < 5) ||
     (low4(0xA9EDDC) == 0)), "Title Screen | Completion {0}%",
    rich_presence_value("Number", achievementPercentageTotal())
)

rich_presence_display("Wandering Lebensbaum")
