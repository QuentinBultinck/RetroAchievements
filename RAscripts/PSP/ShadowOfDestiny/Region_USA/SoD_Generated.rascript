// Shadow of Destiny
// #ID = 3945

// $8FFEF0: [25-bit Pointer] - Video data (intro and credits)
//          +0x18 - [32-bit Flag] 0x101 => video is active
//          +0x2c - [32-bit Flag] 0x41 => video is active
//          +0x40 - [32-bit] Video timer
function videoDataIntroAndCredits() => dword(0x8FFEF0)

// $A82E48: [32-bit] Current scene/map/scenario ID
//          0x15c => liar
//          0x5 => bar
//          0x375 => PresentDayCity
//          0x44 => PresentDayNightCity
//          0x3 => NightBefore chapter 7
//          0x465 => 80sColdCity
//          0x31d => 70sNightCity
//          0x239 => 1900sCity
//          0x603 => 1900sBrumMansion
//          0x3f3 => MedievalCity
//          0x33c => MedievalNightCity
//          0x217 => ExplodedAlchemistBasemen
//          0x8 => MedievalChurch
//          ...
//          
//          All used IDs are defined in the corresponding RAscript; Link to the RAscript can be found in the official forum topic of this game
function currentSceneMapScenarioId() => dword(0xA82E48)

// $A9DAA8: [8-bit] Number of Z-Pad energy units owned (preferred)
//          - If this is 0x0, player can't time travel
//          - Min: 0x0	--- Max: 0xa
//          - This value is the effective amount + shown in the Z-Pad menu
function numberOfZPadEnergyUnitsOwnedPreferred() => byte(0xA9DAA8)

// $A9ECBC: [32-bit] Cutscene ID Master
//          - Identifies a cutscene sequence
function cutsceneIdMaster() => dword(0xA9ECBC)

// $A9ECC0: [16-bit] Cutscene Section ID_1
//          - Identifies a section from the current cutscene
function cutsceneSectionId1() => word(0xA9ECC0)

// $A9ECC2: [16-bit] Cutscene Section ID_2
function cutsceneSectionId2() => word(0xA9ECC2)

// $A9ECC8: [25-bit Pointer] Cutscene Identification - Master Data
//          +0x0 - Refers to start of dynamic cutscene memory data block - Data below changes on new cutscene loaded in
//          +0x8 - [32-bit] Cutscene Master Data ID
function cutsceneIdentificationMasterData() => dword(0xA9ECC8)

// $A9ECCC: [25-bit Pointer] Cutscene Identification - Section Data
//          +0x0 - Data lower then this point changes, when a next section in the cutscene starts
//          +0x8 - [32-bit] Cutscene Section Data ID
function cutsceneIdentificationSectionData() => dword(0xA9ECCC)

// $A9ECD4: [25-bit Pointer] Cutscene Identification - Minor IDs
//          - Pointer active when a cutscene is active
//          +0x0 - Data lower than this point can be used as Minor Cutscene IDs
//          +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID
function cutsceneIdentificationMinorIds() => dword(0xA9ECD4)

// $A9ED26: [8-bit Flag] Is cutscene active (preferred)
//          0x00 => no cutscene active
//          0x01 => black bars (small) cutscene active/transitional value between active-inactive
//          0x05 => full cutscene active
function isCutsceneActivePreferred() => byte(0xA9ED26)

// $A9ED98: [Current Playthrough Bit Flags]: EX Chapter
//          bit 7 => EX Chapter is active // 2nd dialogue option "Oh, Homunculus" => activates EX chapter
// $A9ED9D: [Current Playthrough Bit Flags]: Chapter 1
//          bit 5 => put out fire yourself
//          bit 7 => Saved bar from fire by warning barman
// $A9EDA0: [Current Playthrough Bit Flags]: Chapter 2
//          bit 0 => acquired ladder
//          bit 1 = 0 => LIGHTER used to scare crowd
//          bit 1 = 1 => TELEPHONE used
//          bit 2 = 0 => Chosen to plant STATUE instead of flowers
//          bit 2 = 1 => Chosen to plant FLOWERS instead of statue
// $A9EDA5: [Current Playthrough Bit Flags]: Chapter 4
//          bit 2 => is wearing performer outfit
//          bit 3 => died once without using an iron plate
// $A9EDAA: [Current Playthrough Bit Flags]: Brum Estate Choice
//          bit 5 = 0 => Brum Estate is museum
//          bit 5 = 1 => Brum Estate is library
// $A9EDAE: [Current Playthrough Bit Flags]: Chapter 5
//          bit 6 => Margarette is ancestor, sets after leaving alchemist house (refer to 0xa9edad)
//          bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house (refer to 0xa9edad)
// $A9EDB0: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
//          - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen
//          bit 7 => Antidote painting
//          bit 6 => Marktplatz painting (insinuating removing the tree)
//          bit 5 => Squire's crest painting
//          bit 4 => Tower view painting (downstairs)
// $A9EDB1: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
//          bit 0 => Performer painting (only possible when player became performer in chapter 4)
//          bit 1 => Achemist house collapse painting
// $A9EDB7: [Current Playthrough Bit Flags]: Chapter 6
//          bit 5 => Movie choice 1: Meditating Man
//          bit 6 => Movie choice 1: Time Travel
//          bit 7 => Movie choice 2: Take over the world
// $A9EDB8: [Current Playthrough Bit Flags]: Chapter 6
//          bit 0 => Movie Choice 2: Find cause of own death
//          bit 1 => Movie Choice 3: Thriller story
//          bit 2 => Movie Choice 3: Love story
// $A9EDC4: [Current Playthrough Bit Flags]: Saved Dana from Past
//          bit 1 => Gave letter to Dana
//          bit 3-4 => Took Dana back to present
// $A9EDCB: [Current Playthrough Bit Flags]: Multi-chapter
//          bit 2 => talked with Oleg 1st time in Chapter 3
//          bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
//          bit 6 => gave kitten to Sibylla
// $A9EDCC: [Current Playthrough Bit Flags]: Multi-chapter
//          bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch
// $A9EDDC: [Lower4 Flag] Is in-game
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

// $A9EE3F: [8-bit] NPC Talk Count - Aspiring apprentice - Middle Ages - Chapter2 - SouthEastGate
//          - Frighten him with cellphone or lighter
function npcTalkCountAspiringApprenticeMiddleAgesChapter2Southeastgate() => byte(0xA9EE3F)

// $A9EE4C: [8-bit] NPC Talk Count -  Broad delinquent - Present - Chapter 7 - Car Park
function npcTalkCountBroadDelinquentPresentChapter7CarPark() => byte(0xA9EE4C)

// $A9EE51: [8-bit] NPC Talk Count - Slim delinquent - Present - Chapter 7 - Car Park
function npcTalkCountSlimDelinquentPresentChapter7CarPark() => byte(0xA9EE51)

// $A9EE70: [8-bit] NPC Talk Count - Eccentric girl - Middle Ages - Chapter 2 - Town Square - When frightening with lighter or cellphone
function npcTalkCountEccentricGirlMiddleAgesChapter2TownSquareWhenFrighteningWithLighterOrCellphone() => byte(0xA9EE70)

// $A9EE7F: [8-bit] Chapter 4: Times talked to brunette girl near, whilst wearing the performer outfit
function chapter4TimesTalkedToBrunetteGirlNearWhilstWearingThePerformerOutfit() => byte(0xA9EE7F)

// $A9EE88: [8-bit] NPC Talk Count - Blonde old woman - Present - Chapter 4; wearing the performer outfit
function npcTalkCountBlondeOldWomanPresentChapter4WearingThePerformerOutfit() => byte(0xA9EE88)

// $A9EE92: [8-bit] NPC Talk Count - Brunette young girl - Present - Chapter 4; wearing the performer outfit
function npcTalkCountBrunetteYoungGirlPresentChapter4WearingThePerformerOutfit() => byte(0xA9EE92)

// $A9EEF8: [8-bit] NPC Talk Count - Young blonde boy - Present - Chapter 4; wearing the performer outfit:
function npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit() => byte(0xA9EEF8)

// $A9EF43: [8-bit] NPC Talk Count - Young blonde boy - Present - Chapter 4; wearing the performer outfit:
function npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit() => byte(0xA9EF43)

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

// $A9EF89: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 2
//          0x1 => has talked with 0xa9ef69 AND 0xa9ef7c
//          0x2 => has talked with 0xa9ef6a AND 0xa9ef7d
//          0x3 => Young couple - Middle Ages - Chapter 2 - have switched positions/respawned
function progressOfYoungCoupleSidequestChapter2() => byte(0xA9EF89)

// $A9EF8A: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 3
//          0x1 => has talked with 0xa9ef6c AND 0xa9ef7f
//          0x2 => has talked with 0xa9ef6d AND 0xa9ef80
//          0x3 => Young couple - Middle Ages - Chapter 3 - have changed positions/respawned
function progressOfYoungCoupleSidequestChapter3() => byte(0xA9EF8A)

// $A9EF8B: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 4
//          0x1 => has talked with 0xa9ef82 AND 0xa9ef6f
//          0x2 => has talked with 0xa9ef83 AND 0xa9ef70
//          0x3 => Young couple - Middle Ages - Chapter 4 - have changed positions/respawned
function progressOfYoungCoupleSidequestChapter4() => byte(0xA9EF8B)

// $A9EF8E: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 7
//          >= 0x1 => advised woman to be truthful
//          - Increases by 0x1 after telling woman to be truthful, to a max of 0x1
//          
//          [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - Before Experiment - Only available when this memory address was already >= 0x1
//          - Dual purpose memory address
//          - Talk Counts add on top of above explained count
//          - If count was 0 from start, refer to 0xa9ef77
//          - Increases by 0x1 with each interaction with the man starts at 0x1 and to a max of 0x3
function progressOfYoungCoupleSidequestChapter7() => byte(0xA9EF8E)

// $A9EF8F: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 8
//          bit 0 => told the man about the lovers never destined to meet
//          bit 1 => told the man to get over it

// $A9EFDC: [8-bit] NPC Talk Count - older man - 1980 - Chapter 6
function npcTalkCountOlderMan1980Chapter6() => dword(0xA9EFDC)

// $A9EFE0: [25-bit Pointer] Interaction Identification
//          +0x0 - [32-bit] Interaction Chapter ID
//          | - Each chapter has a different value
function interactionIdentification() => dword(0xA9EFE0)

// $A9EFE4: [25-bit Pointer] Interaction Identification
//          - Pointer resets to 0x0 when interaction is done
//          +0x0 - [32-bit] Interaction ID
function interactionIdentification() => dword(0xA9EFE4)

// $A9F034: [bit 0] Z-pad/D-pad
//          - bit 0 => Can be used as a FLAG -> is game running/not in title screen (disfavored, prefer 0xa9eddc)

// $A9F035: [bit 0] Cellphone
function cellphone() => bit0(0xA9F035)

// $A9F036: [Bit 0] Ornamental egg
function ornamentalEgg() => bit0(0xA9F036)

// $A9F038: [Bit 0] Frying Pan
function fryingPan() => bit0(0xA9F038)

// $A9F039: [Bit 0] Photo shop sign
function photoShopSign() => bit0(0xA9F039)

// $A9F03A: [Bit 0] Lighter
function lighter() => bit0(0xA9F03A)

// $A9F03B: [Bit 0] Black and white photo without performer
//          - Switches with next byte, after taking the picture with the performer during chapter 4

// $A9F03C: [Bit 0] Black and white photo with performer
function blackAndWhitePhotoWithPerformer() => bit0(0xA9F03C)

// $A9F03D: [Bit 0] Philosopher's stone
function philosopherSStone() => bit0(0xA9F03D)

// $A9F03E: [Bit 0] New rope
function newRope() => bit0(0xA9F03E)

// $A9F03F: [Bit 0] Old rope
//          - Is automatically removed when obtaining new rope

// $A9F040: [Bit 0] Jugglery
function jugglery() => bit0(0xA9F040)

// $A9F041: [Bit 0] Comb
function comb() => bit0(0xA9F041)

// $A9F042: [Bit 0] Old alchemist book
function oldAlchemistBook() => bit0(0xA9F042)

// $A9F043: [Bit 0] Squire's crest
function squireSCrest() => bit0(0xA9F043)

// $A9F044: [Bit 0] Egg shaped pocket watch
function eggShapedPocketWatch() => bit0(0xA9F044)

// $A9F045: [Bit 0] Antidote
function antidote() => bit0(0xA9F045)

// $A9F046: [Bit 0] Scrap of meat
function scrapOfMeat() => bit0(0xA9F046)

// $A9F047: [Bit 0] Cake
function cake() => bit0(0xA9F047)

// $A9F048: [Bit 0] Lab key
function labKey() => bit0(0xA9F048)

// $A9F049: [Bit 0] Tower key
function towerKey() => bit0(0xA9F049)

// $A9F04A: [Bit 0] Letter to Dana
function letterToDana() => bit0(0xA9F04A)

// $A9F04B: [Bit 0] Kitten
function kitten() => bit0(0xA9F04B)

// $A9F04C: [Bit 0] City map
function cityMap() => bit0(0xA9F04C)

// $A9F04D: [Bit 0] Ladder
function ladder() => bit0(0xA9F04D)

// $A9F04E: [Bit 0] Old city map
function oldCityMap() => bit0(0xA9F04E)

// $A9F04F: [Bit 0] Notebook
function notebook() => bit0(0xA9F04F)

// $A9F050: [Bit 0] Postcard
function postcard() => bit0(0xA9F050)

// $A9F111: [8-bit] Currently selected item in inventory
//          - Only used IDs in achievement logic are currently recorded in this code note
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
function currentlySelectedItemInInventory() => byte(0xA9F111)

// $AA1154: START - MEMORY BLOCK: Ending bitflags
//          ========================================
//          [Permanent Bit Flag] bit 0 => Ending A unlocked
//          - To unlock extra menu turn one of these bits to 1 => let intro video play again => extra menu is now available

// $AA1155: [Permanent Bit Flag] bit 0 => Ending B unlocked
function bit0EndingBUnlocked() => bit0(0xAA1155)

// $AA1156: [Permanent Bit Flag] bit 0 => Ending C unlocked
function bit0EndingCUnlocked() => bit0(0xAA1156)

// $AA1157: [Permanent Bit Flag] bit 0 => Ending D unlocked
function bit0EndingDUnlocked() => bit0(0xAA1157)

// $AA1158: [Permanent Bit Flag] bit 0 => Ending E unlocked
function bit0EndingEUnlocked() => bit0(0xAA1158)

// $AA1159: [Permanent Bit Flag] bit 0 => Ending EX unlocked
function bit0EndingExUnlocked() => bit0(0xAA1159)

// $AA115B: START - MEMORY BLOCK: Permanent Cutscene Bit Flags (preferred)
//          ===================================================
//          - Each flag corresponds to at least 1 cutscene and counts toward the achievement percentage
//          - These flags are set when heading into any save menu OR when finishing a chapter OR when booting up the game
//          - Each flag accounts for a float percentage. These numbers are rounded up or down in the extra menu
//          - To test => change memory values => from title screen go back into extra menu
//          
//          [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          bits 1-7 => 13+%
// $AA115C: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115D: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115E: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA115F: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA1160: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          all bits => 15+%
// $AA1161: [Permanent Cutscene Bit Flags] Prologue + EX Chapter
//          bits 0-5 => 11+%
// $AA1162: [Permanent Cutscene Bit Flags] Chapter 1
//          bits 6-7 => 8+%
// $AA1163: [Permanent Cutscene Bit Flags] Chapter 1
//          all bits => 33+%
// $AA1164: [Permanent Cutscene Bit Flags] Chapter 1
//          all bits => 33+%
// $AA1165: [Permanent Cutscene Bit Flags] Chapter 1
//          bits 0-5 => 25+%
// $AA1166: [Permanent Cutscene Bit Flags] Chapter 2
//          bits 3-7 => 13+%
// $AA1167: [Permanent Cutscene Bit Flags] Chapter 2
//          all bits => 22+%
// $AA1168: [Permanent Cutscene Bit Flags] Chapter 2
//          all bits => 22+%
// $AA1169: [Permanent Cutscene Bit Flags] Chapter 2
//          all bits => 22+%
// $AA116A: [Permanent Cutscene Bit Flags] Chapter 2
//          bits 0-6 => 19+%
// $AA116C: [Permanent Cutscene Bit Flags] Chapter 4
//          bits 1-7 => 19+%
// $AA116D: [Permanent Cutscene Bit Flags] Chapter 4
//          all bits => 22+%
// $AA116E: [Permanent Cutscene Bit Flags] Chapter 4
//          all bits => 22+%
// $AA116F: [Permanent Cutscene Bit Flags] Chapter 4
//          all bits => 22+%
// $AA1170: [Permanent Cutscene Bit Flags] Chapter 4
//          bits 0-4 => 13+%
// $AA1171: [Permanent Cutscene Bit Flags] Chapter 5
//          bits 1-7 => 15+%
// $AA1172: [Permanent Cutscene Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1173: [Permanent Cutscene Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1174: [Permanent Cutscene Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1175: [Permanent Cutscene Bit Flags] Chapter 5
//          all bits => 17+%
// $AA1176: [Permanent Cutscene Bit Flags] Chapter 5
//          bits 0-6 => 15+%
// $AA1177: [Permanent Cutscene Bit Flags] Chapter 3
//          bits 2-7 => 27+%
// $AA1178: [Permanent Cutscene Bit Flags] Chapter 3
//          all bits => 36+%
// $AA1179: [Permanent Cutscene Bit Flags] Chapter 3
//          all bits => 36+%
// $AA117A: [Permanent Cutscene Bit Flags] Chapter 6
//          bits 2-7 => 17+%
// $AA117B: [Permanent Cutscene Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117C: [Permanent Cutscene Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117D: [Permanent Cutscene Bit Flags] Chapter 6
//          all bits => 22+%
// $AA117E: [Permanent Cutscene Bit Flags] Chapter 6
//          bits 0-4 => 14+%
// $AA117F: [Permanent Cutscene Bit Flags] Chapter 7
//          bits 2-7 => 17+%
// $AA1180: [Permanent Cutscene Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1181: [Permanent Cutscene Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1182: [Permanent Cutscene Bit Flags] Chapter 7
//          all bits => 23+%
// $AA1183: [Permanent Cutscene Bit Flags] Chapter 7
//          bits 0-3 => 11+%
// $AA1184: [Permanent Cutscene Bit Flags] Chapter 8
//          bits 5-7 => 4+%
// $AA1185: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1186: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1187: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1188: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA1189: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118A: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118B: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118C: [Permanent Cutscene Bit Flags] Chapter 8
//          all bits => 11+%
// $AA118D: [Permanent Cutscene Bit Flags] Chapter 8
//          bits 0-3 => 5+%
// $AA1190: [Permanent Cutscene Bit Flags] Epilogue
//          bits 2-7 => 26+%
// $AA1191: [Permanent Cutscene Bit Flags] Epilogue
//          all bits => 34+%
// $AA1192: [Permanent Cutscene Bit Flags] Epilogue
//          all bits => 34+%
// $AA1193: [Permanent Cutscene Bit Flags] Epilogue
//          bit 0 => 4+%

// $AA1268: [32-bit] Time Period
//          0x80 => Middle ages 1500s
//          0x81 => Late 20th Century 1900s
//          0x82 => Early 20th Century 1980
//          0x88 => Early 20th Century 1979
//          0x83 => Present 2000s
function timePeriod() => dword(0xAA1268)

TimePeriodLookup = {
    128: "in the Middle Ages",
    129: "in the late 20th century",
    130: "in the early 20th century",
    131: "in the present",
    136: "in the late 20th century",
}

// $AC3170: [25-bit] Pointer - When in Extra menu
//          - Extra menu is only visible once at least one is ending is finished
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
function pointerWhenInExtraMenu() => dword(0xAC3170)

// $AC3178: [25-bit] Pointer - Ending File (when in extra menu)
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
//          +0xc - [16-bit] Ending file text ID
function pointerEndingFileWhenInExtraMenu() => dword(0xAC3178)

// $AC31EE: [8-bit] Character printer - Print location x-axis
//          [For this 8-bit column]
function characterPrinterPrintLocationXAxis() => byte(0xAC31EE)

// $AC31F2: [8-bit] Character printer - Offset x-axis
//          [For this 8-bit column]
function characterPrinterOffsetXAxis() => dword_be(0xAC31F2)

// $AC49F4: [32-bit] Menu ID
//          0xe => at title screen
//          0x4 => at extra menu
//          0x12 => at event viewer menu
//          0x16 => at results menu
//          0x1a => In sound mode menu
//          0xb => viewing ending file
//          ...
function menuId() => dword(0xAC49F4)

// $B95704: [8-bit] Chapter ID
//          - 0x1 = Prologue/EX Chapter
//          - 0x2 = Chapter 1
//          - 0x3 = Chapter 2
//          - 0x4 = Chapter 3
//          - 0x5 = Chapter 4
//          - 0x6 = Chapter 5
//          - 0x7 = Chapter 6
//          - 0x8 = Chapter 7
//          - 0x9 = Chapter 8 -> when in Chapter 5, player told Margarette she's your ancestress
//          - 0xa = Epilogue -> when in Chapter 5, player told Margarette she's your ancestress
//          - 0xb = Chapter 8 -> when in Chapter 5, player told Margarette she's NOT your ancestress
//          - 0xc = Epilogue -> when in Chapter 5, player told Margarette she's NOT your ancestress
function chapterId() => byte(0xB95704)

// $1FFF130: [32-bit] Flag -> Event viewer (preferred)
//           0x21 => event viewer menu on screen OR a cutscene is being watched via this menu
//           - other values => not in event viewer
function flagEventViewerPreferred() => dword(0x1FFF130)

// $1FFF5F8: [32-bit] UI/Menu ID
//           - 0x11 => title screen
//           - any other value => other menu OR something else on screen
function uiMenuId() => dword(0x1FFF5F8)

// $1FFF604: [8-bit] Highlighted submenu at title screen
//           - 0x1 => Start
//           - 0x2 => Continue
//           - 0x3 => Option
//           - 0x4 => Extra
function highlightedSubmenuAtTitleScreen() => byte(0x1FFF604)
function highlightedSubmenuAtTitleScreen() => dword(0x1FFF604)

achievement(
    title = "That's a big no no.", points = 2,
    description = "Warn yourself of your impending demise during the prologue",
    id = 306883, badge = "461699", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:45",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 1) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 39936 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 39920 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 60016
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 145344 && prior(cutsceneIdMaster()) == 39936 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44640
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "Defied Fate", points = 5,
    description = "Complete the prologue",
    id = 306884, badge = "461667", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 1 && cutsceneIdMaster() == 140416 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 113872 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 3600
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 1 && cutsceneIdMaster() == 592832 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 110192 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 482576
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 1 && chapterId() == 2))
)

achievement(
    title = "A Performer's Clue", points = 1,
    description = "Receive a gift from a performer during chapter 1",
    id = 306885, badge = "461653", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 2) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 103296 && cutsceneSectionId1() == 7 && cutsceneSectionId2() == 8 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 24160 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 79088
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Defied Fate... Again", points = 5,
    description = "Complete chapter 1",
    id = 306886, badge = "461654", published = "5/04/2023 15:44:05", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 2 && cutsceneIdMaster() == 72256 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 48800 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 23424
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 2 && chapterId() == 3))
)

achievement(
    title = "Met You Before", points = 2,
    description = "Keep chatting with Dana at the Marktplatz tree during chapter 2",
    id = 306888, badge = "461701", published = "5/04/2023 18:19:09", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 451712 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 283216 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 82928
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 112448 && prior(cutsceneIdMaster()) == 451712 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 7424 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 104992
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "The Magician's Legacy", points = 1,
    description = "Become honored as a magician during chapter 2",
    id = 306906, badge = "461684", published = "5/04/2023 19:28:48", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 1 && isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 0 &&
                  cutsceneIdMaster() == 242240 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "The Pyromancer's Legacy", points = 1,
    description = "Become honored as a pyrokinetic during chapter 2",
    id = 306911, badge = "461685", published = "5/04/2023 19:43:29", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 0 && isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 0 &&
                  cutsceneIdMaster() == 242240 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "My my, so eager to die.", points = 1,
    description = "Run from the apparition during chapter 3",
    id = 306919, badge = "461700", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 4) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 45376 && prior(cutsceneIdMaster()) == 371328 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 23232 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14512
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 107584 && prior(cutsceneIdMaster()) == 45376 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 55712 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 51792
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "A Blossoming Plan", points = 1,
    description = "Planted flowers during chapter 2",
    id = 306920, badge = "461683", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:44",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 1 && isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 242240 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "An Alchemist, a Jewel and a Homunculus", points = 5,
    description = "Complete chapter 3",
    id = 306921, badge = "461656", published = "5/04/2023 22:23:24", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 4 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 105856 &&
                    cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 33440 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 72384
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 4 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 850752 &&
                    prior(cutsceneIdMaster()) == 105856 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 14832 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 231328
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 4 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 235136 &&
                    prior(cutsceneIdMaster()) == 850752 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 32272 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 31904
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 4 && chapterId() == 5))
)

achievement(
    title = "Left in the Past", points = 5,
    description = "Complete chapter 2",
    id = 306922, badge = "461655", published = "5/04/2023 22:42:49", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 3 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 242240 &&
                    cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 28976
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 3 && currentlySelectedItemInInventory() == 0 && cutsceneIdMaster() == 242240 &&
                    cutsceneSectionId1() == 3 && cutsceneSectionId2() == 2 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 70208 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 688
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 3 && chapterId() == 4))
)

achievement(
    title = "There's a fire!", points = 4,
    description = "Alert the young boy's grandpa of imminent disaster during chapter 1",
    id = 306976, badge = "461648", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((chapterId() != 4 && chapterId() != 5)) &&
              tally(1,
                  once(isCutsceneActivePreferred() == 5 && ornamentalEgg() == 1 && chapterId() == 4 && cutsceneIdMaster() == 205312 &&
                  cutsceneSectionId1() == 7 && cutsceneSectionId2() == 6 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 149984),
                  once(isCutsceneActivePreferred() == 5 && ornamentalEgg() == 1 && chapterId() == 5 && cutsceneIdMaster() == 195008 &&
                  cutsceneSectionId1() == 7 && cutsceneSectionId2() == 6 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 149984)
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "A Jovial Exchange", points = 4,
    description = "Exchange an egg for a pan during chapter 1, 3 or 4",
    id = 306977, badge = "461650", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 2) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && ornamentalEgg() == 1 && cutsceneIdMaster() == 195008 && cutsceneSectionId1() == 7 &&
                  cutsceneSectionId2() == 6 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 149984
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Yesteryears Couple I: Destined to Miss", points = 4,
    description = "Help a lost young couple reunite in The Middle Ages during chapter 2",
    id = 306984, badge = "461706", published = "6/04/2023 16:26:09", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              measured(tally(6,
                  once((progressOfYoungCoupleSidequestChapter2() == 0 || progressOfYoungCoupleSidequestChapter2() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890() == 1 && prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890()) == 0 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1056),
                  once((progressOfYoungCoupleSidequestChapter2() == 0 || progressOfYoungCoupleSidequestChapter2() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter2WestGateWhen0xa9ef890() == 1 && prev(npcTalkCountYoungCoupleManMiddleAgesChapter2WestGateWhen0xa9ef890()) == 0 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1037),
                  once((progressOfYoungCoupleSidequestChapter2() == 1 || progressOfYoungCoupleSidequestChapter2() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1057),
                  once((progressOfYoungCoupleSidequestChapter2() == 1 || progressOfYoungCoupleSidequestChapter2() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x1() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1038),
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter2() == 3 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 &&
                  npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() == 1 && dword(interactionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1058),
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter2() == 3 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() == 1 && dword(interactionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1039)), when=currentSceneMapScenarioId() == 828
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Cracking Open the Past: Middle Ages", points = 3,
    description = "Show off your egg collection to the barman's ancestor during chapter 2",
    id = 307023, badge = "461725", published = "6/04/2023 20:16:21", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 2 && cutsceneIdMaster() == 56832 && cutsceneSectionId1() == 3 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 10704 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 46080
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Enigmatic Couple I: Prelude", points = 3,
    description = "Find the coated man and woman in the present during the prologue or chapter 1",
    id = 307495, badge = "461690", published = "9/04/2023 8:08:50", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never((chapterId() != 1 && chapterId() != 2)) &&
              measured(tally(4, repeated(2,
                  isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                  npcTalkCountCoatedWomanPresentChapter1PrologueTownSquare() > prev(npcTalkCountCoatedWomanPresentChapter1PrologueTownSquare()) && dword(interactionIdentification() & 0x1FFFFFF) == 716), repeated(2,
                  isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                  npcTalkCountCoatedManPresentChapter1PrologueTownSquare() > prev(npcTalkCountCoatedManPresentChapter1PrologueTownSquare()) && dword(interactionIdentification() & 0x1FFFFFF) == 705))
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Strokes of Destiny", points = 1,
    description = "Admire all the paintings in the Brum Museum",
    id = 307499, badge = "461675", published = "9/04/2023 11:10:41", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != prev(chapterId())) &&
              trigger_when(isCutsceneActivePreferred() == 0) &&
              measured(tally(8,
                  once((currentSceneMapScenarioId() == 50 || currentSceneMapScenarioId() == 749) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 292),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 356 && dword(interactionIdentification() & 0x1FFFFFF) == 293),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 357 && dword(interactionIdentification() & 0x1FFFFFF) == 294),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 362 && dword(interactionIdentification() & 0x1FFFFFF) == 295),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 358 && dword(interactionIdentification() & 0x1FFFFFF) == 296),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 360 && dword(interactionIdentification() & 0x1FFFFFF) == 297),
                  once((currentSceneMapScenarioId() == 320 || currentSceneMapScenarioId() == 205) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 361 && dword(interactionIdentification() & 0x1FFFFFF) == 4294967295),
                  once((currentSceneMapScenarioId() == 320 || currentSceneMapScenarioId() == 205) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 359 && dword(interactionIdentification() & 0x1FFFFFF) == 4294967295))
              )
)

achievement(
    title = "Pan-tastic Resilience", points = 3,
    description = "Complete Chapter 4, using a frying pan",
    id = 308964, badge = "461657", published = "16/04/2023 17:01:09", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(cutsceneIdMaster()) != cutsceneIdMaster()) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(currentlySelectedItemInInventory() != 4) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 5 && cutsceneIdMaster() == 324096 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 251136
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 5 && cutsceneIdMaster() == 345472 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 94304 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 5008
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 5 && chapterId() == 6))
)

achievement(
    title = "Yesteryears Couple III: Destiny's Promise Fulfilled", points = 4,
    description = "Reunite the lost young couple in The Middle Ages during chapter 4",
    id = 309393, badge = "461708", published = "17/04/2023 19:03:08", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 5) &&
              measured(tally(6,
                  once((progressOfYoungCoupleSidequestChapter4() == 0 || progressOfYoungCoupleSidequestChapter4() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x0() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1062),
                  once((progressOfYoungCoupleSidequestChapter4() == 0 || progressOfYoungCoupleSidequestChapter4() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x0() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1043),
                  once((progressOfYoungCoupleSidequestChapter4() == 1 || progressOfYoungCoupleSidequestChapter4() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x1() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1063),
                  once((progressOfYoungCoupleSidequestChapter4() == 1 || progressOfYoungCoupleSidequestChapter4() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4TownSquareWhenValue0xa9ef8b0x1() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1044),
                  once((progressOfYoungCoupleSidequestChapter4() == 2 || progressOfYoungCoupleSidequestChapter4() == 3) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x3() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1064),
                  once((progressOfYoungCoupleSidequestChapter4() == 2 || progressOfYoungCoupleSidequestChapter4() == 3) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter4NearMarieSBakeryWhenValue0xa9ef8b0x3() == 1 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1045)),
                  when=currentSceneMapScenarioId() == 828
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Enigmatic Couple II: Tailing", points = 3,
    description = "Find the coated man and woman in the present during chapter 3",
    id = 310131, badge = "461691", published = "19/04/2023 11:41:41", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 4) && trigger_when(isCutsceneActivePreferred() != 1) &&
              ((measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() > prev(npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop()) && dword(interactionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter3NearAntiqueShop() > prev(npcTalkCountCoatedManPresentChapter3NearAntiqueShop()) && dword(interactionIdentification() & 0x1FFFFFF) == 708))
                )) ||
               (measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter3NearAntiqueShop() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 708))
                )))
)

achievement(
    title = "Timeless Antiques", points = 2,
    description = "Take a glance at the timeless relics at Antique Shop Eule",
    id = 310132, badge = "461674", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never(chapterId() != prev(chapterId())) && trigger_when(isCutsceneActivePreferred() != 1) &&
              measured(tally(4,
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 142 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 152 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 121 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 4294967295),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 198 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 4294967295)),
                  when=(currentSceneMapScenarioId() == 122 || currentSceneMapScenarioId() == 111)
              )
)

achievement(
    title = "Yesteryears Couple II: The Place Where We Nigh Met", points = 4,
    description = "Help a lost young couple reunite again in The Middle Ages during chapter 3",
    id = 310133, badge = "461707", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 4) &&
              measured(tally(6,
                  once(progressOfYoungCoupleSidequestChapter3() == 0 || progressOfYoungCoupleSidequestChapter3() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter2EastNearHayWhen0xa9ef890x3() &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1059),
                  once(progressOfYoungCoupleSidequestChapter3() == 0 || progressOfYoungCoupleSidequestChapter3() == 1) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0() &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1040),
                  once(progressOfYoungCoupleSidequestChapter3() == 1 || progressOfYoungCoupleSidequestChapter3() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter3NearNorthEastGateWhen0xa9ef8a0x1() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter3NearNorthEastGateWhen0xa9ef8a0x1() &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1060),
                  once(progressOfYoungCoupleSidequestChapter3() == 1 || progressOfYoungCoupleSidequestChapter3() == 2) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0x1() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3NearWellWhen0xa9ef8a0x1() &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 1041),
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter3() == 3 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 &&
                  npcTalkCountYoungCoupleWomanMiddleAgesChapter3TownSquareWhen0xa9ef8a0x3() > prev(npcTalkCountYoungCoupleWomanMiddleAgesChapter3TownSquareWhen0xa9ef8a0x3()) && dword(interactionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1061),
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter3() == 3 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter3OutsideChurchWhen0xa9ef8a0x3() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter3OutsideChurchWhen0xa9ef8a0x3()) && dword(interactionIdentification() & 0x1FFFFFF) == 355 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1042)), when=currentSceneMapScenarioId() == 828
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Enigmatic Couple III: Wandering Once More", points = 3,
    description = "Find the coated man and woman in the present during chapter 4",
    id = 310134, badge = "461692", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 5) && trigger_when(isCutsceneActivePreferred() == 0) &&
              ((measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() > prev(npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop()) && dword(interactionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter4HaupStrUnderArch() > prev(npcTalkCountCoatedManPresentChapter4HaupStrUnderArch()) && dword(interactionIdentification() & 0x1FFFFFF) == 709))
                )) ||
               (measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter3OutsideAntiqueShop() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 720), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter4HaupStrUnderArch() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 709))
                )))
)

achievement(
    title = "Enigmatic Couple IV: Origins", points = 3,
    description = "Find the coated man and woman in the present during chapter 5",
    id = 310135, badge = "461693", published = "19/04/2023 15:36:31", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 6) && trigger_when(isCutsceneActivePreferred() == 0) &&
              ((measured(tally(3,
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() > prev(npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne()) && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    isCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 0 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum() > prev(npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum()) && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() == 1 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 75 && dword(interactionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    isCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 0 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumMuseum() == 2 && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() > prev(npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne()) && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    isCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumLibrary() == 1 && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 713))
                )) ||
               (measured(tally(3,
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter5EastOfCafeSonne() == 1 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 75 && dword(interactionIdentification() & 0x1FFFFFF) == 725), repeated(2,
                    isCutsceneActivePreferred() == 1 && bit5(0xA9EDAA) == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter5NorthEastGateBrumLibrary() == 1 && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 713))
                )))
)

achievement(
    title = "Through the Lens of Survival", points = 3,
    description = "Complete Chapter 4, using a sign",
    id = 310149, badge = "461658", published = "19/04/2023 16:09:53", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(cutsceneIdMaster()) != cutsceneIdMaster()) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(currentlySelectedItemInInventory() != 5) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 5 && cutsceneIdMaster() == 345472 && cutsceneSectionId1() == 13 &&
                    cutsceneSectionId2() == 14 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 46816 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44624
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 5 && chapterId() == 6))
)

achievement(
    title = "Yesteryears Couple IV: Man-in-waiting", points = 1,
    description = "Consult the young man in The Middle Ages during chapter 5",
    id = 310162, badge = "461709", published = "19/04/2023 19:39:22", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 6) &&
              measured(repeated(2,
                  isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter5NearSouthEastGate() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter5NearSouthEastGate()) && dword(interactionIdentification() & 0x1FFFFFF) == 75 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1046)
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Complexities of the Fourth Dimension", points = 4,
    description = "Get lectured in time-travelling physics during chapter 4",
    id = 310163, badge = "461679", published = "19/04/2023 19:40:38", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 5) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              tally(1,
                  once(isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 4 && cutsceneIdMaster() == 721152 && cutsceneSectionId1() == 13 &&
                  cutsceneSectionId2() == 14 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 126896 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44656),
                  once(isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 5 && cutsceneIdMaster() == 721152 && cutsceneSectionId1() == 13 &&
                  cutsceneSectionId2() == 14 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 125600 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44656)
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Nine Lives across Generations", points = 4,
    description = "Gift a feline to a girl during or after chapter 4",
    id = 310426, badge = "461728", published = "20/04/2023 18:06:14", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && currentSceneMapScenarioId() == 1539 && kitten() == 1 && cutsceneIdMaster() == 152064 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 11264 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 67888
              ) && bit6(0xA9EDCB) == 1 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "A Mother's Child", points = 2,
    description = "Find Hugo outside his house during chapter 5",
    id = 311466, badge = "461705", published = "24/04/2023 18:48:54", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 6) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 257280 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 12560 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 244672 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2632416 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 244672
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Ancient Elixir", points = 5,
    description = "Complete Chapter 5",
    id = 311616, badge = "461659", published = "25/04/2023 18:57:11", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 6 && currentlySelectedItemInInventory() == 17 && cutsceneIdMaster() == 260480 &&
                    cutsceneSectionId1() == 65535 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 260480
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 6 && chapterId() == 7))
)

achievement(
    title = "Picked up a baby the other day.", points = 2,
    description = "Uncover a snowy crime scene during chapter 6",
    id = 313209, badge = "461727", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 7) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && currentSceneMapScenarioId() == 1125 && cutsceneIdMaster() == 480960 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 18016 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 324112 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 756624 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 324112
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Director's Cut: Trip for Two", points = 3,
    description = "Complete Chapter 6, by co-directing a love picture",
    id = 313210, badge = "461660", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
              ((once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 645952 && cutsceneSectionId1() == 7 && cutsceneSectionId2() == 8 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 7 && chapterId() == 8))
)

achievement(
    title = "Director's Cut: The Time of Reckoning", points = 3,
    description = "Complete Chapter 6, by co-directing a thriller picture",
    id = 313211, badge = "461661", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
              ((once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 645952 && cutsceneSectionId1() == 7 && cutsceneSectionId2() == 8 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 7 && chapterId() == 8))
)

achievement(
    title = "Time Ego Flop", points = 1,
    description = "View every possible movie poster during chapter 6",
    id = 313212, badge = "461703", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 7) &&
              once(isCutsceneActivePreferred() == 5 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit7(0xA9EDB7) == 1 &&
                  bit0(0xA9EDB8) == 1 && cutsceneIdMaster() == 489856 && cutsceneSectionId1() == 10 && cutsceneSectionId2() == 11 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 8336 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 89424
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "Cracking Open the Past: The Old Century", points = 4,
    description = "Show off your egg collection to the barman's ancestor from chapter 6 onward",
    id = 313213, badge = "461682", published = "1/05/2023 15:18:04", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((chapterId() != 7 && chapterId() != 8 && chapterId() != 9 && chapterId() != 11)) &&
              tally(1,
                  once(isCutsceneActivePreferred() == 5 && currentSceneMapScenarioId() == 569 && cutsceneIdMaster() == 570432 && cutsceneSectionId1() == 5 &&
                  cutsceneSectionId2() == 6 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 371744 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 122480 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 913376 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 181200),
                  once(isCutsceneActivePreferred() == 5 && currentSceneMapScenarioId() == 569 && cutsceneIdMaster() == 705728 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 371744 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 122480 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 519216 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 194352)
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Yesteryears Couple V: Parting", points = 2,
    description = "Consult the young couple in The Middle Ages during chapter 7",
    id = 314753, badge = "461710", published = "5/05/2023 8:33:58", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 8) && trigger_when(isCutsceneActivePreferred() == 0) &&
              ((measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter4OutsideChurchWhenValue0xa9ef8b0x3() == 1 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 59 && dword(interactionIdentification() & 0x1FFFFFF) == 1065), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                    npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch()) && dword(interactionIdentification() & 0x1FFFFFF) == 59 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1
                )) ||
               (measured(tally(4, repeated(2,
                    isCutsceneActivePreferred() == 1 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 407 && npcTalkCountYoungCoupleWomanMiddleAgesChapter7TownSquareOnlyInAncestorPath() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 59 && dword(interactionIdentification() & 0x1FFFFFF) == 1065), repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                    npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch() > prev(npcTalkCountYoungCoupleManMiddleAgesChapter7OutsideChurch()) && dword(interactionIdentification() & 0x1FFFFFF) == 59 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0
                )))
)

achievement(
    title = "Bump... Erased", points = 1,
    description = "Run into yourself during chapter 7",
    id = 314763, badge = "461698", published = "5/05/2023 8:58:07", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 8) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once((dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 147168) &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 227296 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 147120
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "A Hatchless Replica", points = 4,
    description = "Show off your egg collection to the barman during chapter 7",
    id = 315561, badge = "461717", published = "7/05/2023 18:08:31", modified = "7/05/2023 18:08:31",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 8) &&
              once(isCutsceneActivePreferred() == 5 && eggShapedPocketWatch() == 1 && cutsceneIdMaster() == 577152 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 312832 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 145056 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 460352 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 145056
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "The Eggcellent Director's Tale", points = 4,
    description = "Reminisce about your egg collection with Eckart during chapter 8",
    id = 315562, badge = "461718", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((chapterId() != 9 && chapterId() != 11)) &&
              once(isCutsceneActivePreferred() == 5 && eggShapedPocketWatch() == 1 && cutsceneIdMaster() == 580800 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 203408 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 42016 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 916416 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 42016
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Fated to Plunge", points = 1,
    description = "Use an aged cable to save yourself in chapter 7",
    id = 315563, badge = "461702", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 8) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 87616 && cutsceneSectionId1() == 5 && cutsceneSectionId2() == 6 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 30768 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 8736
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 145344 && prior(cutsceneIdMaster()) == 87616 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 44640
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "Enigmatic Couple V: Epilogue", points = 3,
    description = "Find the coated man and woman in the present during chapter 7",
    id = 315564, badge = "461694", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 8) && trigger_when(isCutsceneActivePreferred() == 0) &&
              ((measured(tally(3, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 &&
                    npcTalkCountCoatedWomanPresentChapter7SouthGate() > prev(npcTalkCountCoatedWomanPresentChapter7SouthGate()) && dword(interactionIdentification() & 0x1FFFFFF) == 178 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 723),
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 &&
                    npcTalkCountCoatedManPresentChapter7NorthWestGate() > prev(npcTalkCountCoatedManPresentChapter7NorthWestGate()) && dword(interactionIdentification() & 0x1FFFFFF) == 178 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 712))
                )) ||
               (measured(tally(3, repeated(2,
                    isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 87 && npcTalkCountCoatedWomanPresentChapter7SouthGate() == 2 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 178 && dword(interactionIdentification() & 0x1FFFFFF) == 723),
                    once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 86 && npcTalkCountCoatedManPresentChapter7NorthWestGate() == 1 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 178 && dword(interactionIdentification() & 0x1FFFFFF) == 712))
                )))
)

achievement(
    title = "A Friend's Repentance", points = 5,
    description = "Complete Chapter 7",
    id = 315565, badge = "461665", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 8 && cutsceneIdMaster() == 274496 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(isCutsceneActivePreferred() == 5 && chapterId() == 8 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    cutsceneIdMaster() == 813056 && cutsceneSectionId1() == 5 && cutsceneSectionId2() == 4 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 284448 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 445648),
                    once(isCutsceneActivePreferred() == 5 && chapterId() == 8 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    cutsceneIdMaster() == 859072 && cutsceneSectionId1() == 3 && cutsceneSectionId2() == 4 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 294912 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 373136)
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 8 && cutsceneIdMaster() == 73792 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 3296 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 70448
                ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 8 && (chapterId() == 9 || chapterId() == 11)))
)

achievement(
    title = "An End to a Strange Experience", points = 5,
    description = "Achieve Ending A",
    id = 315566, badge = "461668", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 0
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 898944 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 7088 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 208096
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 491392 &&
                  prior(cutsceneIdMaster()) == 898944 && cutsceneSectionId1() == 3 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 154704 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 109712
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1154) == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Barman's Mystery Child", points = 3,
    description = "Discover the truth about the barman's grandchildren during chapter 5",
    id = 315567, badge = "461678", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 6) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 852480 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 250512 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 601904
              ) && prev(isCutsceneActivePreferred()) > 3 && isCutsceneActivePreferred() <= 3 && isCutsceneActivePreferred() != 0
)

achievement(
    title = "Yesteryears Couple VI: Never Destined to Meet", points = 10,
    description = "Advise the young man in The Middle Ages during chapter 8",
    id = 315568, badge = "461711", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((chapterId() != 9 && chapterId() != 11)) &&
              measured(tally(2,
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter7() >= 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 &&
                  npcTalkCountYoungCoupleManMiddleAgesChapter8OutsideChurchAfterExperimentWhenValue0xa9ef8e() == 1 && prev(npcTalkCountYoungCoupleManMiddleAgesChapter8OutsideChurchAfterExperimentWhenValue0xa9ef8e()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 19 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1052),
                  once(isCutsceneActivePreferred() == 1 && progressOfYoungCoupleSidequestChapter7() >= 1 && bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) == 0 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 408 && dword(interactionIdentification() & 0x1FFFFFF) == 19 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 1075)), when=currentSceneMapScenarioId() == 1011
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Illusive Guardian of the Brums", points = 4,
    description = "Save a member of the Brum family from a predestined death during chapter 6",
    id = 315569, badge = "461721", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 7) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && currentSceneMapScenarioId() == 1125 && cutsceneIdMaster() == 965312 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 345840 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 20656
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "The Brums Happily Ever After", points = 10,
    description = "Meet Eckart's wife in Chapter 7",
    id = 315570, badge = "461714", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 8) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 274496 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 31968 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 55616
              ) &&
              tally(1,
                  once(isCutsceneActivePreferred() == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && cutsceneIdMaster() == 817472 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 29712),
                  once(isCutsceneActivePreferred() == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && cutsceneIdMaster() == 730432 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27888)
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "The whole picture... Or is it?", points = 5,
    description = "Complete Chapter 8",
    id = 315571, badge = "461666", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:08:34",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 570944 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 185408 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 272208
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 1109760 && cutsceneSectionId1() == 9 &&
                    cutsceneSectionId2() == 8 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 46624 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 62672
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 935936 && cutsceneSectionId1() == 9 &&
                    cutsceneSectionId2() == 10 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 420512 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 381024
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 873536 && cutsceneSectionId1() == 7 &&
                    cutsceneSectionId2() == 6 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 267600 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 177184
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 464576 && cutsceneSectionId1() == 9 &&
                    cutsceneSectionId2() == 10 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 145904 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 106224
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 998528 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 597040 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 401456
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 1031424 && cutsceneSectionId1() == 5 &&
                    cutsceneSectionId2() == 4 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 392960 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 159536
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 806464 &&
                    prior(cutsceneIdMaster()) == 1031424 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 403024 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27616
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 9 && cutsceneIdMaster() == 117696 && cutsceneSectionId1() == 5 &&
                    cutsceneSectionId2() == 4 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 51424 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 39152
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 11 && cutsceneIdMaster() == 490048 &&
                    prior(cutsceneIdMaster()) == 169728 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 204752 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 285200
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 11 && cutsceneIdMaster() == 307520 &&
                    prior(cutsceneIdMaster()) == 490048 && cutsceneSectionId1() == 5 && cutsceneSectionId2() == 4 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 74416 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 100848
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 11 && cutsceneIdMaster() == 824384 &&
                    prior(cutsceneIdMaster()) == 655552 && cutsceneSectionId1() == 3 && cutsceneSectionId2() == 2 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 289616 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 534688
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (once(isCutsceneActivePreferred() == 5 && chapterId() == 11 && cutsceneIdMaster() == 1055680 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 489760 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 468432
                ) &&
                once(isCutsceneActivePreferred() == 5 && chapterId() == 11 && cutsceneIdMaster() == 1275136 &&
                    prior(cutsceneIdMaster()) == 1055680 && cutsceneSectionId1() == 12 && cutsceneSectionId2() == 13 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 507376 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 348816
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0) ||
               (prev(chapterId()) == 9 && chapterId() == 10) ||
               (prev(chapterId()) == 11 && chapterId() == 12))
)

achievement(
    title = "No Sense of Finality II", points = 5,
    description = "Achieve Ending B2",
    id = 315572, badge = "461670", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 594496 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 381632 &&
                  prior(cutsceneIdMaster()) == 594496 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 126928 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 352832 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingBUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "No Sense of Finality I", points = 5,
    description = "Achieve Ending B1",
    id = 315573, badge = "461669", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 398272 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 277936 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 120272
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 352832 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingBUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "If only... I had one more attempt.", points = 5,
    description = "Achieve Ending C",
    id = 317118, badge = "461671", published = "14/05/2023 10:33:35", modified = "14/05/2023 10:33:35",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 2
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 577280 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 504128 &&
                  prior(cutsceneIdMaster()) == 577280 && cutsceneSectionId1() == 3 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 120112 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 10 && cutsceneIdMaster() == 833280 &&
                  prior(cutsceneIdMaster()) == 504128 && cutsceneSectionId1() == 5 && cutsceneSectionId2() == 6 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 6528 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 125136
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingBUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Eike's Origins", points = 5,
    description = "Achieve Ending D",
    id = 322230, badge = "461672", published = "28/05/2023 11:34:23", modified = "28/05/2023 11:34:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 3
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 12 && cutsceneIdMaster() == 461248 && cutsceneSectionId1() == 3 &&
                  cutsceneSectionId2() == 4 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 149360 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 71568
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 12 && cutsceneIdMaster() == 809792 && cutsceneSectionId1() == 3 &&
                  cutsceneSectionId2() == 4 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 432960 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 138048
              ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingDUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The future is what we make it.", points = 5,
    description = "Achieve Ending E",
    id = 322231, badge = "461673", published = "28/05/2023 11:34:26", modified = "28/05/2023 11:34:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 4
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 12 && cutsceneIdMaster() == 560576 && cutsceneSectionId1() == 3 &&
                  cutsceneSectionId2() == 2 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 181152 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 379392
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 12 && cutsceneIdMaster() == 782208 && cutsceneSectionId1() == 9 &&
                  cutsceneSectionId2() == 8 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 368480 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 87520
              ) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 12 && cutsceneIdMaster() == 842944 &&
                  prior(cutsceneIdMaster()) == 782208 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 2 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 209456 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 137088
              ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingEUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Energy Locator: Present Day", points = 5,
    description = "Collect all 5 energy orbs in present day Lebensbaum",
    id = 399816, badge = "461689", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless(bit2(0xA9EDA5) == 1) &&
              unless((currentSceneMapScenarioId() != 885 && currentSceneMapScenarioId() != 68 && currentSceneMapScenarioId() != 3)) &&
              measured(repeated(5,
                  numberOfZPadEnergyUnitsOwnedPreferred() > prev(numberOfZPadEnergyUnitsOwnedPreferred()) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(characterPrinterPrintLocationXAxis()) == 0 && prior(characterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && isCutsceneActivePreferred() != 5), when=low4(0xA9EDDC) != 0
              ) &&
              (always_false() || (never(numberOfZPadEnergyUnitsOwnedPreferred() < prev(numberOfZPadEnergyUnitsOwnedPreferred())) && never(chapterId() != prev(chapterId()))))
)

achievement(
    title = "Energy Locator: The Late 20th Century", points = 5,
    description = "Collect all 5 energy orbs in Lebensbaum during the 70's or 80's",
    id = 399817, badge = "461687", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless((currentSceneMapScenarioId() != 1125 && currentSceneMapScenarioId() != 797)) &&
              measured(repeated(5,
                  numberOfZPadEnergyUnitsOwnedPreferred() > prev(numberOfZPadEnergyUnitsOwnedPreferred()) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(characterPrinterPrintLocationXAxis()) == 0 && prior(characterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && isCutsceneActivePreferred() != 5), when=low4(0xA9EDDC) != 0
              ) &&
              (always_false() || (never(numberOfZPadEnergyUnitsOwnedPreferred() < prev(numberOfZPadEnergyUnitsOwnedPreferred())) && never(chapterId() != prev(chapterId()))))
)

achievement(
    title = "Energy Locator: The Early 20th Century", points = 5,
    description = "Collect all 5 energy orbs in Lebensbaum, a century ago",
    id = 399818, badge = "461686", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = never(numberOfZPadEnergyUnitsOwnedPreferred() < prev(numberOfZPadEnergyUnitsOwnedPreferred())) && never(chapterId() != prev(chapterId())) &&
              never((bit2(0xA9EDA5) == 1 && currentSceneMapScenarioId() == 885)) &&
              (always_false() || (unless((currentSceneMapScenarioId() != 569 && currentSceneMapScenarioId() != 1539)) &&
                measured(repeated(5,
                    numberOfZPadEnergyUnitsOwnedPreferred() > prev(numberOfZPadEnergyUnitsOwnedPreferred()) && prior(dword(0xAC32B8)) != 0 &&
                    prior(dword_be(0xAC32C2)) != 0 && prior(characterPrinterPrintLocationXAxis()) == 0 &&
                    prior(characterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                    prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                    prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                    prior(dword_be(0xAC32A2)) == 4588544 && isCutsceneActivePreferred() != 5), when=low4(0xA9EDDC) != 0
                )))
)

achievement(
    title = "Energy Locator: Middle Ages", points = 5,
    description = "Collect all 5 energy orbs in medieval Lebensbaum",
    id = 399819, badge = "461688", published = "19/02/2024 14:12:17", modified = "19/02/2024 14:12:17",
    trigger = never(numberOfZPadEnergyUnitsOwnedPreferred() < prev(numberOfZPadEnergyUnitsOwnedPreferred())) && never(chapterId() != prev(chapterId())) &&
              (always_false() || (unless((currentSceneMapScenarioId() != 1011 && currentSceneMapScenarioId() != 828 && currentSceneMapScenarioId() != 535 &&
                    currentSceneMapScenarioId() != 142)
                ) &&
                measured(repeated(6,
                    numberOfZPadEnergyUnitsOwnedPreferred() > prev(numberOfZPadEnergyUnitsOwnedPreferred()) && prior(dword(0xAC32B8)) != 0 &&
                    prior(dword_be(0xAC32C2)) != 0 && prior(characterPrinterPrintLocationXAxis()) == 0 &&
                    prior(characterPrinterOffsetXAxis()) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                    prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                    prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                    prior(dword_be(0xAC32A2)) == 4588544 && isCutsceneActivePreferred() != 5), when=low4(0xA9EDDC) != 0
                )))
)

achievement(
    title = "Even I can do that.", points = 4,
    description = "Become a performer during chapter 4",
    id = 402284, badge = "461649", published = "25/02/2024 11:33:55", modified = "25/02/2024 11:33:55",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(prev(cutsceneIdMaster()) != cutsceneIdMaster()) &&
              once(isCutsceneActivePreferred() == 5 && chapterId() == 5 && currentlySelectedItemInInventory() == 12 && bit2(0xA9EDA5) == 1 &&
                  cutsceneIdMaster() == 107264 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14848
              ) && trigger_when(prev(isCutsceneActivePreferred()) > 3) && trigger_when(isCutsceneActivePreferred() <= 3) &&
              trigger_when(isCutsceneActivePreferred() != 0)
)

achievement(
    title = "Time-Spun Sweets", points = 4,
    description = "Gift a tasty sweet to a someone dear to you",
    id = 402296, badge = "461704", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(currentlySelectedItemInInventory() != 19) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 1093632 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 711488 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 382112
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Legacy of Sweetness", points = 3,
    description = "Establish a new line of pastries",
    id = 402297, badge = "461715", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(currentlySelectedItemInInventory() != 19) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 130432 && cutsceneSectionId1() == 65535 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 86992 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x00002C) == 74416
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Stockpiling Across Eras", points = 10,
    description = "Acquire the biggest hoard of items in a single playthrough",
    id = 402404, badge = "461712", published = "25/02/2024 19:47:49", modified = "25/02/2024 19:47:49",
    trigger = never((uiMenuId() == 17 && highlightedSubmenuAtTitleScreen() > 0 && highlightedSubmenuAtTitleScreen() < 5)) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(oldAlchemistBook() != prev(oldAlchemistBook())) && never(antidote() != prev(antidote())) &&
              never(bit0(0xA9F03B) != prev(bit0(0xA9F03B))) && never(blackAndWhitePhotoWithPerformer() != prev(blackAndWhitePhotoWithPerformer())) &&
              never(cake() != prev(cake())) && never(cellphone() != prev(cellphone())) &&
              never(comb() != prev(comb())) && never(bit0(0xA9F034) != prev(bit0(0xA9F034))) &&
              never(eggShapedPocketWatch() != prev(eggShapedPocketWatch())) && never(fryingPan() != prev(fryingPan())) &&
              never(jugglery() != prev(jugglery())) && never(kitten() != prev(kitten())) &&
              never(labKey() != prev(labKey())) && never(ladder() != prev(ladder())) &&
              never(postcard() != prev(postcard())) && never(lighter() != prev(lighter())) &&
              never(cityMap() != prev(cityMap())) && never(scrapOfMeat() != prev(scrapOfMeat())) &&
              never(newRope() != prev(newRope())) && never(notebook() != prev(notebook())) &&
              never(oldCityMap() != prev(oldCityMap())) && never(bit0(0xA9F03F) != prev(bit0(0xA9F03F))) &&
              never(ornamentalEgg() != prev(ornamentalEgg())) && never(philosopherSStone() != prev(philosopherSStone())) &&
              never(letterToDana() != prev(letterToDana())) && never(photoShopSign() != prev(photoShopSign())) &&
              never(squireSCrest() != prev(squireSCrest())) && never(towerKey() != prev(towerKey())) &&
              measured(tally(20, once(oldAlchemistBook() == 1), once(antidote() == 1), once(bit0(0xA9F03B) == 1),
                  once(blackAndWhitePhotoWithPerformer() == 1), once(cake() == 1), once(cellphone() == 1),
                  once(comb() == 1), once(bit0(0xA9F034) == 1), once(eggShapedPocketWatch() == 1),
                  once(fryingPan() == 1), once(jugglery() == 1), once(kitten() == 1),
                  once(labKey() == 1), once(ladder() == 1), once(postcard() == 1),
                  once(lighter() == 1), once(cityMap() == 1), once(scrapOfMeat() == 1),
                  once(newRope() == 1), once(notebook() == 1), once(oldCityMap() == 1),
                  once(bit0(0xA9F03F) == 1), once(ornamentalEgg() == 1), once(philosopherSStone() == 1),
                  once(letterToDana() == 1), once(photoShopSign() == 1), once(squireSCrest() == 1),
                  once(towerKey() == 1))
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Performance Gone the Extra Mile", points = 5,
    description = "Make sure the performer goes the extra mile for those who would appreciate his gesture, including yourself",
    id = 403575, badge = "461716", published = "29/02/2024 15:31:22", modified = "29/02/2024 15:31:22",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 5) && never(repeated(300, bit2(0xA9EDA5) == 0)) &&
              measured(tally(7,
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 391 && npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit() == 2 &&
                  prev(npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit()) == 1 && dword(interactionIdentification() & 0x1FFFFFF) == 68 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 924),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 70 && npcTalkCountBrunetteYoungGirlPresentChapter4WearingThePerformerOutfit() == 1 &&
                  prev(npcTalkCountBrunetteYoungGirlPresentChapter4WearingThePerformerOutfit()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 68 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 822),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 66 && chapter4TimesTalkedToBrunetteGirlNearWhilstWearingThePerformerOutfit() == 1 &&
                  prev(chapter4TimesTalkedToBrunetteGirlNearWhilstWearingThePerformerOutfit()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 68 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 803),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 68 && npcTalkCountBlondeOldWomanPresentChapter4WearingThePerformerOutfit() == 1 &&
                  prev(npcTalkCountBlondeOldWomanPresentChapter4WearingThePerformerOutfit()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 68 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 812),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 405 && currentSceneMapScenarioId() == 22 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 41 && dword(interactionIdentification() & 0x1FFFFFF) == 966),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 387 && currentSceneMapScenarioId() == 22 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 41 && dword(interactionIdentification() & 0x1FFFFFF) == 972),
                  once(isCutsceneActivePreferred() == 5 && chapterId() == 5 && currentlySelectedItemInInventory() == 12 && cutsceneIdMaster() == 107264 &&
                  cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 14848))
              ) && trigger_when(prev(isCutsceneActivePreferred()) > 3) && trigger_when(isCutsceneActivePreferred() <= 3) &&
              trigger_when(isCutsceneActivePreferred() != 0)
)

achievement(
    title = "Pan in Advance", points = 3,
    description = "Acquire an iron plate before finding a good usage for it",
    id = 403823, badge = "461724", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 5) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(currentlySelectedItemInInventory() != 4) && never(bit0(0xA9F03B) == 1) && never(blackAndWhitePhotoWithPerformer() == 1) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 324096 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 72912 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 251136
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Art Muse", points = 3,
    description = "Inspire an acclaimed artist and appraise his work",
    id = 403824, badge = "461676", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != prev(chapterId())) && never(bit5(0xA9EDAA) == 1) &&
              trigger_when(isCutsceneActivePreferred() == 0) &&
              tally(1,
                  once((currentSceneMapScenarioId() == 50 || currentSceneMapScenarioId() == 749) && isCutsceneActivePreferred() == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 292),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 356 && dword(interactionIdentification() & 0x1FFFFFF) == 293),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 357 && dword(interactionIdentification() & 0x1FFFFFF) == 294),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 362 && dword(interactionIdentification() & 0x1FFFFFF) == 295),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 358 && dword(interactionIdentification() & 0x1FFFFFF) == 296),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 360 && dword(interactionIdentification() & 0x1FFFFFF) == 297)
              )
)

achievement(
    title = "Eike Franssen", points = 5,
    description = "Become a beacon of inspiration for an acclaimed artist and appraise all his works",
    id = 403825, badge = "461677", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != prev(chapterId())) &&
              trigger_when(isCutsceneActivePreferred() == 0) &&
              measured(tally(6,
                  once((currentSceneMapScenarioId() == 50 || currentSceneMapScenarioId() == 749) && isCutsceneActivePreferred() == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 292),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 356 && dword(interactionIdentification() & 0x1FFFFFF) == 293),
                  once((currentSceneMapScenarioId() == 345 || currentSceneMapScenarioId() == 56) && isCutsceneActivePreferred() == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 357 && dword(interactionIdentification() & 0x1FFFFFF) == 294),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 362 && dword(interactionIdentification() & 0x1FFFFFF) == 295),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 358 && dword(interactionIdentification() & 0x1FFFFFF) == 296),
                  once((currentSceneMapScenarioId() == 548 || currentSceneMapScenarioId() == 445) && isCutsceneActivePreferred() == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 360 && dword(interactionIdentification() & 0x1FFFFFF) == 297))
              )
)

achievement(
    title = "The Next Big Thing", points = 4,
    description = "Inspire the movie director for a 2nd time in chapter 7",
    id = 404045, badge = "461713", published = "2/03/2024 21:18:07", modified = "2/03/2024 21:18:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 8) &&
              once(isCutsceneActivePreferred() == 5 && bit3(0xA9EDCC) == 1 && cutsceneIdMaster() == 659264 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 283504 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 375696 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 588000 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 375696
              ) && prev(isCutsceneActivePreferred()) != 0 && isCutsceneActivePreferred() == 0
)

achievement(
    title = "Terror of Destinies", points = 4,
    description = "Frighten everyone in the past and a person indulging in spaghetti during chapter 2",
    id = 404046, badge = "461722", published = "2/03/2024 21:18:08", modified = "2/03/2024 21:18:08",
    trigger = never(low4(0xA9EDDC) == 0) && never(chapterId() != 3) && trigger_when(isCutsceneActivePreferred() == 0) &&
              (always_false() || (unless((currentSceneMapScenarioId() != 828 && currentSceneMapScenarioId() != 16)) &&
                measured(tally(7,
                    once(isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 1 && cutsceneIdMaster() == 36864 &&
                    cutsceneSectionId1() == 65535 && cutsceneSectionId2() == 0 &&
                    dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 36864), repeated(4,
                    isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 1 && cutsceneIdMaster() == 814592 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 23248 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 21936 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2380192 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 21936), repeated(4,
                    isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 6 && cutsceneIdMaster() == 689344 && cutsceneSectionId1() == 1 &&
                    cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 11840 &&
                    dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 45600 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2315504 &&
                    dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 45600),
                    once((currentlySelectedItemInInventory() == 6 || currentlySelectedItemInInventory() == 1) && isCutsceneActivePreferred() == 1 && npcTalkCountEccentricGirlMiddleAgesChapter2TownSquareWhenFrighteningWithLighterOrCellphone() == 1 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 355 && dword(interactionIdentification() & 0x1FFFFFF) == 788),
                    once((currentlySelectedItemInInventory() == 6 || currentlySelectedItemInInventory() == 1) && isCutsceneActivePreferred() == 1 && npcTalkCountAspiringApprenticeMiddleAgesChapter2Southeastgate() == 1 &&
                    prev(npcTalkCountAspiringApprenticeMiddleAgesChapter2Southeastgate()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 355 &&
                    dword(interactionIdentification() & 0x1FFFFFF) == 739)), when=low4(0xA9EDDC) != 0 && chapterId() == 3
                )))
)

achievement(
    title = "A Pair of Delinquents", points = 2,
    description = "Encounter some rascals in chapter 7",
    id = 404048, badge = "461680", published = "2/03/2024 22:13:05", modified = "2/03/2024 22:13:05",
    trigger = never(currentSceneMapScenarioId() != 68) &&
              measured(tally(2,
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 19 && npcTalkCountSlimDelinquentPresentChapter7CarPark() == 1 &&
                  prev(npcTalkCountSlimDelinquentPresentChapter7CarPark()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 178 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 757),
                  once(isCutsceneActivePreferred() == 1 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 16 && npcTalkCountBroadDelinquentPresentChapter7CarPark() == 1 &&
                  prev(npcTalkCountBroadDelinquentPresentChapter7CarPark()) == 0 && dword(interactionIdentification() & 0x1FFFFFF) == 178 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 752)), when=low4(0xA9EDDC) != 0
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Running Beyond the 90's... and 80's", points = 2,
    description = "Encounter an athletic man in the past as well as his present self during chapter 3, 4 or 5",
    id = 405086, badge = "461720", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never(low4(0xA9EDDC) == 0) && never((chapterId() != 4 && chapterId() != 5 && chapterId() != 6)) &&
              measured(tally(2,
                  once((currentSceneMapScenarioId() == 885 || currentSceneMapScenarioId() == 68 || currentSceneMapScenarioId() == 3) && isCutsceneActivePreferred() == 1 &&
                  dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 88),
                  once(isCutsceneActivePreferred() == 1 && currentSceneMapScenarioId() == 797 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 89))
              ) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "Homing Instinct", points = 10,
    description = "Reach 100% achievement rate for the prologue and EX chapter",
    id = 405087, badge = "461646", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 1) &&
                measured(tally(53, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(53, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 0, format="percent"
                )))
)

achievement(
    title = "In the Heat of Time", points = 10,
    description = "Reach 100% achievement rate for chapter 1",
    id = 405088, badge = "461637", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 2) &&
                measured(tally(24, once(bit6(0xAA1162) == 1), once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1),
                    once(bit1(0xAA1163) == 1), once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1),
                    once(bit4(0xAA1163) == 1), once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1),
                    once(bit7(0xAA1163) == 1), once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1),
                    once(bit2(0xAA1164) == 1), once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1),
                    once(bit5(0xAA1164) == 1), once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1),
                    once(bit0(0xAA1165) == 1), once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1),
                    once(bit3(0xAA1165) == 1), once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(24, once(bit6(0xAA1162) == 1), once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1),
                    once(bit1(0xAA1163) == 1), once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1),
                    once(bit4(0xAA1163) == 1), once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1),
                    once(bit7(0xAA1163) == 1), once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1),
                    once(bit2(0xAA1164) == 1), once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1),
                    once(bit5(0xAA1164) == 1), once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1),
                    once(bit0(0xAA1165) == 1), once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1),
                    once(bit3(0xAA1165) == 1), once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 1, format="percent"
                )))
)

achievement(
    title = "Dana Kusch", points = 10,
    description = "Reach 100% achievement rate for chapter 2",
    id = 405089, badge = "461638", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 3) &&
                measured(tally(36, once(bit3(0xAA1166) == 1), once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1),
                    once(bit6(0xAA1166) == 1), once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1),
                    once(bit1(0xAA1167) == 1), once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1),
                    once(bit4(0xAA1167) == 1), once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1),
                    once(bit7(0xAA1167) == 1), once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1),
                    once(bit2(0xAA1168) == 1), once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1),
                    once(bit5(0xAA1168) == 1), once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1),
                    once(bit0(0xAA1169) == 1), once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1),
                    once(bit3(0xAA1169) == 1), once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1),
                    once(bit6(0xAA1169) == 1), once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1),
                    once(bit1(0xAA116A) == 1), once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1),
                    once(bit4(0xAA116A) == 1), once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(36, once(bit3(0xAA1166) == 1), once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1),
                    once(bit6(0xAA1166) == 1), once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1),
                    once(bit1(0xAA1167) == 1), once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1),
                    once(bit4(0xAA1167) == 1), once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1),
                    once(bit7(0xAA1167) == 1), once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1),
                    once(bit2(0xAA1168) == 1), once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1),
                    once(bit5(0xAA1168) == 1), once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1),
                    once(bit0(0xAA1169) == 1), once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1),
                    once(bit3(0xAA1169) == 1), once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1),
                    once(bit6(0xAA1169) == 1), once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1),
                    once(bit1(0xAA116A) == 1), once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1),
                    once(bit4(0xAA116A) == 1), once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 2, format="percent"
                )))
)

achievement(
    title = "The Root of the Problem", points = 10,
    description = "Reach 100% achievement rate for chapter 3",
    id = 405090, badge = "461639", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 4) &&
                measured(tally(22, once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(22, once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 3, format="percent"
                )))
)

achievement(
    title = "The Monochrome Era", points = 10,
    description = "Reach 100% achievement rate for chapter 4",
    id = 405091, badge = "461640", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 5) &&
                measured(tally(36, once(bit1(0xAA116C) == 1), once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1),
                    once(bit4(0xAA116C) == 1), once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1),
                    once(bit7(0xAA116C) == 1), once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1),
                    once(bit2(0xAA116D) == 1), once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1),
                    once(bit5(0xAA116D) == 1), once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1),
                    once(bit0(0xAA116E) == 1), once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1),
                    once(bit3(0xAA116E) == 1), once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1),
                    once(bit6(0xAA116E) == 1), once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1),
                    once(bit1(0xAA116F) == 1), once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1),
                    once(bit4(0xAA116F) == 1), once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1),
                    once(bit7(0xAA116F) == 1), once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1),
                    once(bit2(0xAA1170) == 1), once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(36, once(bit1(0xAA116C) == 1), once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1),
                    once(bit4(0xAA116C) == 1), once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1),
                    once(bit7(0xAA116C) == 1), once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1),
                    once(bit2(0xAA116D) == 1), once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1),
                    once(bit5(0xAA116D) == 1), once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1),
                    once(bit0(0xAA116E) == 1), once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1),
                    once(bit3(0xAA116E) == 1), once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1),
                    once(bit6(0xAA116E) == 1), once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1),
                    once(bit1(0xAA116F) == 1), once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1),
                    once(bit4(0xAA116F) == 1), once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1),
                    once(bit7(0xAA116F) == 1), once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1),
                    once(bit2(0xAA1170) == 1), once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 4, format="percent"
                )))
)

achievement(
    title = "Meddling with Destiny", points = 10,
    description = "Reach 100% achievement rate for chapter 5",
    id = 405092, badge = "461641", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 6) &&
                measured(tally(46, once(bit1(0xAA1171) == 1), once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1),
                    once(bit4(0xAA1171) == 1), once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1),
                    once(bit7(0xAA1171) == 1), once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1),
                    once(bit2(0xAA1172) == 1), once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1),
                    once(bit5(0xAA1172) == 1), once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1),
                    once(bit0(0xAA1173) == 1), once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1),
                    once(bit3(0xAA1173) == 1), once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1),
                    once(bit6(0xAA1173) == 1), once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1),
                    once(bit1(0xAA1174) == 1), once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1),
                    once(bit4(0xAA1174) == 1), once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1),
                    once(bit7(0xAA1174) == 1), once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1),
                    once(bit2(0xAA1175) == 1), once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1),
                    once(bit5(0xAA1175) == 1), once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1),
                    once(bit0(0xAA1176) == 1), once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1),
                    once(bit3(0xAA1176) == 1), once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1),
                    once(bit6(0xAA1176) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(46, once(bit1(0xAA1171) == 1), once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1),
                    once(bit4(0xAA1171) == 1), once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1),
                    once(bit7(0xAA1171) == 1), once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1),
                    once(bit2(0xAA1172) == 1), once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1),
                    once(bit5(0xAA1172) == 1), once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1),
                    once(bit0(0xAA1173) == 1), once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1),
                    once(bit3(0xAA1173) == 1), once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1),
                    once(bit6(0xAA1173) == 1), once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1),
                    once(bit1(0xAA1174) == 1), once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1),
                    once(bit4(0xAA1174) == 1), once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1),
                    once(bit7(0xAA1174) == 1), once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1),
                    once(bit2(0xAA1175) == 1), once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1),
                    once(bit5(0xAA1175) == 1), once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1),
                    once(bit0(0xAA1176) == 1), once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1),
                    once(bit3(0xAA1176) == 1), once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1),
                    once(bit6(0xAA1176) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 5, format="percent"
                )))
)

achievement(
    title = "The Good Samaritan", points = 10,
    description = "Reach 100% achievement rate for chapter 6",
    id = 405093, badge = "461642", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 7) &&
                measured(tally(35, once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1), once(bit4(0xAA117A) == 1),
                    once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1), once(bit7(0xAA117A) == 1),
                    once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1), once(bit2(0xAA117B) == 1),
                    once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1), once(bit5(0xAA117B) == 1),
                    once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1), once(bit0(0xAA117C) == 1),
                    once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1), once(bit3(0xAA117C) == 1),
                    once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1), once(bit6(0xAA117C) == 1),
                    once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1), once(bit1(0xAA117D) == 1),
                    once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1), once(bit4(0xAA117D) == 1),
                    once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1), once(bit7(0xAA117D) == 1),
                    once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1), once(bit2(0xAA117E) == 1),
                    once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(35, once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1), once(bit4(0xAA117A) == 1),
                    once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1), once(bit7(0xAA117A) == 1),
                    once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1), once(bit2(0xAA117B) == 1),
                    once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1), once(bit5(0xAA117B) == 1),
                    once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1), once(bit0(0xAA117C) == 1),
                    once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1), once(bit3(0xAA117C) == 1),
                    once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1), once(bit6(0xAA117C) == 1),
                    once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1), once(bit1(0xAA117D) == 1),
                    once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1), once(bit4(0xAA117D) == 1),
                    once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1), once(bit7(0xAA117D) == 1),
                    once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1), once(bit2(0xAA117E) == 1),
                    once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 6, format="percent"
                )))
)

achievement(
    title = "Vintage Knots", points = 10,
    description = "Reach 100% achievement rate for chapter 7",
    id = 405094, badge = "461643", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(chapterId()) != 0 && chapterId() == 0)) &&
              ((unless(chapterId() != 8) &&
                measured(tally(34, once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(34, once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 7, format="percent"
                )))
)

achievement(
    title = "The Power of Fate", points = 10,
    description = "Reach 100% achievement rate for chapter 8",
    id = 405095, badge = "461644", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never(prev(chapterId()) != chapterId()) &&
              ((unless((chapterId() != 9 && chapterId() != 11)) &&
                measured(tally(71, once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1), once(bit7(0xAA1184) == 1),
                    once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1), once(bit2(0xAA1185) == 1),
                    once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1), once(bit5(0xAA1185) == 1),
                    once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1), once(bit0(0xAA1186) == 1),
                    once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1), once(bit3(0xAA1186) == 1),
                    once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1), once(bit6(0xAA1186) == 1),
                    once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1), once(bit1(0xAA1187) == 1),
                    once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1), once(bit4(0xAA1187) == 1),
                    once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1), once(bit7(0xAA1187) == 1),
                    once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1), once(bit2(0xAA1188) == 1),
                    once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1), once(bit5(0xAA1188) == 1),
                    once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1), once(bit0(0xAA1189) == 1),
                    once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1), once(bit3(0xAA1189) == 1),
                    once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1), once(bit6(0xAA1189) == 1),
                    once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1), once(bit1(0xAA118A) == 1),
                    once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1), once(bit4(0xAA118A) == 1),
                    once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1), once(bit7(0xAA118A) == 1),
                    once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1), once(bit2(0xAA118B) == 1),
                    once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1), once(bit5(0xAA118B) == 1),
                    once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1), once(bit0(0xAA118C) == 1),
                    once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1), once(bit3(0xAA118C) == 1),
                    once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1), once(bit6(0xAA118C) == 1),
                    once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1), once(bit1(0xAA118D) == 1),
                    once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(71, once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1), once(bit7(0xAA1184) == 1),
                    once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1), once(bit2(0xAA1185) == 1),
                    once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1), once(bit5(0xAA1185) == 1),
                    once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1), once(bit0(0xAA1186) == 1),
                    once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1), once(bit3(0xAA1186) == 1),
                    once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1), once(bit6(0xAA1186) == 1),
                    once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1), once(bit1(0xAA1187) == 1),
                    once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1), once(bit4(0xAA1187) == 1),
                    once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1), once(bit7(0xAA1187) == 1),
                    once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1), once(bit2(0xAA1188) == 1),
                    once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1), once(bit5(0xAA1188) == 1),
                    once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1), once(bit0(0xAA1189) == 1),
                    once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1), once(bit3(0xAA1189) == 1),
                    once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1), once(bit6(0xAA1189) == 1),
                    once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1), once(bit1(0xAA118A) == 1),
                    once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1), once(bit4(0xAA118A) == 1),
                    once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1), once(bit7(0xAA118A) == 1),
                    once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1), once(bit2(0xAA118B) == 1),
                    once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1), once(bit5(0xAA118B) == 1),
                    once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1), once(bit0(0xAA118C) == 1),
                    once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1), once(bit3(0xAA118C) == 1),
                    once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1), once(bit6(0xAA118C) == 1),
                    once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1), once(bit1(0xAA118D) == 1),
                    once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 8, format="percent"
                )))
)

achievement(
    title = "Eternal Youth", points = 10,
    description = "Reach 100% achievement rate for the epilogue",
    id = 405096, badge = "461645", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = never(prev(chapterId()) != chapterId()) &&
              ((unless((chapterId() != 10 && chapterId() != 12)) &&
                measured(tally(23, once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(23, once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 9, format="percent"
                )))
)

achievement(
    title = "The Day of Walpurgis", points = 50,
    description = "Reach 100% total achievement rate",
    id = 405097, badge = "461647", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = never(chapterId() != prev(chapterId())) &&
              ((measured(tally(380, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1), once(bit6(0xAA1162) == 1),
                    once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1), once(bit1(0xAA1163) == 1),
                    once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1), once(bit4(0xAA1163) == 1),
                    once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1), once(bit7(0xAA1163) == 1),
                    once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1), once(bit2(0xAA1164) == 1),
                    once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1), once(bit5(0xAA1164) == 1),
                    once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1), once(bit0(0xAA1165) == 1),
                    once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1), once(bit3(0xAA1165) == 1),
                    once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1), once(bit3(0xAA1166) == 1),
                    once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1), once(bit6(0xAA1166) == 1),
                    once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1), once(bit1(0xAA1167) == 1),
                    once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1), once(bit4(0xAA1167) == 1),
                    once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1), once(bit7(0xAA1167) == 1),
                    once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1), once(bit2(0xAA1168) == 1),
                    once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1), once(bit5(0xAA1168) == 1),
                    once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1), once(bit0(0xAA1169) == 1),
                    once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1), once(bit3(0xAA1169) == 1),
                    once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1), once(bit6(0xAA1169) == 1),
                    once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1), once(bit1(0xAA116A) == 1),
                    once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1), once(bit4(0xAA116A) == 1),
                    once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1), once(bit1(0xAA116C) == 1),
                    once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1), once(bit4(0xAA116C) == 1),
                    once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1), once(bit7(0xAA116C) == 1),
                    once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1), once(bit2(0xAA116D) == 1),
                    once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1), once(bit5(0xAA116D) == 1),
                    once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1), once(bit0(0xAA116E) == 1),
                    once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1), once(bit3(0xAA116E) == 1),
                    once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1), once(bit6(0xAA116E) == 1),
                    once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1), once(bit1(0xAA116F) == 1),
                    once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1), once(bit4(0xAA116F) == 1),
                    once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1), once(bit7(0xAA116F) == 1),
                    once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1), once(bit2(0xAA1170) == 1),
                    once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1), once(bit1(0xAA1171) == 1),
                    once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1), once(bit4(0xAA1171) == 1),
                    once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1), once(bit7(0xAA1171) == 1),
                    once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1), once(bit2(0xAA1172) == 1),
                    once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1), once(bit5(0xAA1172) == 1),
                    once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1), once(bit0(0xAA1173) == 1),
                    once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1), once(bit3(0xAA1173) == 1),
                    once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1), once(bit6(0xAA1173) == 1),
                    once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1), once(bit1(0xAA1174) == 1),
                    once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1), once(bit4(0xAA1174) == 1),
                    once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1), once(bit7(0xAA1174) == 1),
                    once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1), once(bit2(0xAA1175) == 1),
                    once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1), once(bit5(0xAA1175) == 1),
                    once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1), once(bit0(0xAA1176) == 1),
                    once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1), once(bit3(0xAA1176) == 1),
                    once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1), once(bit6(0xAA1176) == 1),
                    once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1), once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1),
                    once(bit4(0xAA117A) == 1), once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1),
                    once(bit7(0xAA117A) == 1), once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1),
                    once(bit2(0xAA117B) == 1), once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1),
                    once(bit5(0xAA117B) == 1), once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1),
                    once(bit0(0xAA117C) == 1), once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1),
                    once(bit3(0xAA117C) == 1), once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1),
                    once(bit6(0xAA117C) == 1), once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1),
                    once(bit1(0xAA117D) == 1), once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1),
                    once(bit4(0xAA117D) == 1), once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1),
                    once(bit7(0xAA117D) == 1), once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1),
                    once(bit2(0xAA117E) == 1), once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1),
                    once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1), once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1),
                    once(bit7(0xAA1184) == 1), once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1),
                    once(bit2(0xAA1185) == 1), once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1),
                    once(bit5(0xAA1185) == 1), once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1),
                    once(bit0(0xAA1186) == 1), once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1),
                    once(bit3(0xAA1186) == 1), once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1),
                    once(bit6(0xAA1186) == 1), once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1),
                    once(bit1(0xAA1187) == 1), once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1),
                    once(bit4(0xAA1187) == 1), once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1),
                    once(bit7(0xAA1187) == 1), once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1),
                    once(bit2(0xAA1188) == 1), once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1),
                    once(bit5(0xAA1188) == 1), once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1),
                    once(bit0(0xAA1189) == 1), once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1),
                    once(bit3(0xAA1189) == 1), once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1),
                    once(bit6(0xAA1189) == 1), once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1),
                    once(bit1(0xAA118A) == 1), once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1),
                    once(bit4(0xAA118A) == 1), once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1),
                    once(bit7(0xAA118A) == 1), once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1),
                    once(bit2(0xAA118B) == 1), once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1),
                    once(bit5(0xAA118B) == 1), once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1),
                    once(bit0(0xAA118C) == 1), once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1),
                    once(bit3(0xAA118C) == 1), once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1),
                    once(bit6(0xAA118C) == 1), once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1),
                    once(bit1(0xAA118D) == 1), once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1),
                    once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(380, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1), once(bit6(0xAA1162) == 1),
                    once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1), once(bit1(0xAA1163) == 1),
                    once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1), once(bit4(0xAA1163) == 1),
                    once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1), once(bit7(0xAA1163) == 1),
                    once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1), once(bit2(0xAA1164) == 1),
                    once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1), once(bit5(0xAA1164) == 1),
                    once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1), once(bit0(0xAA1165) == 1),
                    once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1), once(bit3(0xAA1165) == 1),
                    once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1), once(bit3(0xAA1166) == 1),
                    once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1), once(bit6(0xAA1166) == 1),
                    once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1), once(bit1(0xAA1167) == 1),
                    once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1), once(bit4(0xAA1167) == 1),
                    once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1), once(bit7(0xAA1167) == 1),
                    once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1), once(bit2(0xAA1168) == 1),
                    once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1), once(bit5(0xAA1168) == 1),
                    once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1), once(bit0(0xAA1169) == 1),
                    once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1), once(bit3(0xAA1169) == 1),
                    once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1), once(bit6(0xAA1169) == 1),
                    once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1), once(bit1(0xAA116A) == 1),
                    once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1), once(bit4(0xAA116A) == 1),
                    once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1), once(bit1(0xAA116C) == 1),
                    once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1), once(bit4(0xAA116C) == 1),
                    once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1), once(bit7(0xAA116C) == 1),
                    once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1), once(bit2(0xAA116D) == 1),
                    once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1), once(bit5(0xAA116D) == 1),
                    once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1), once(bit0(0xAA116E) == 1),
                    once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1), once(bit3(0xAA116E) == 1),
                    once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1), once(bit6(0xAA116E) == 1),
                    once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1), once(bit1(0xAA116F) == 1),
                    once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1), once(bit4(0xAA116F) == 1),
                    once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1), once(bit7(0xAA116F) == 1),
                    once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1), once(bit2(0xAA1170) == 1),
                    once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1), once(bit1(0xAA1171) == 1),
                    once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1), once(bit4(0xAA1171) == 1),
                    once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1), once(bit7(0xAA1171) == 1),
                    once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1), once(bit2(0xAA1172) == 1),
                    once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1), once(bit5(0xAA1172) == 1),
                    once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1), once(bit0(0xAA1173) == 1),
                    once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1), once(bit3(0xAA1173) == 1),
                    once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1), once(bit6(0xAA1173) == 1),
                    once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1), once(bit1(0xAA1174) == 1),
                    once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1), once(bit4(0xAA1174) == 1),
                    once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1), once(bit7(0xAA1174) == 1),
                    once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1), once(bit2(0xAA1175) == 1),
                    once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1), once(bit5(0xAA1175) == 1),
                    once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1), once(bit0(0xAA1176) == 1),
                    once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1), once(bit3(0xAA1176) == 1),
                    once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1), once(bit6(0xAA1176) == 1),
                    once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1), once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1),
                    once(bit4(0xAA117A) == 1), once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1),
                    once(bit7(0xAA117A) == 1), once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1),
                    once(bit2(0xAA117B) == 1), once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1),
                    once(bit5(0xAA117B) == 1), once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1),
                    once(bit0(0xAA117C) == 1), once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1),
                    once(bit3(0xAA117C) == 1), once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1),
                    once(bit6(0xAA117C) == 1), once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1),
                    once(bit1(0xAA117D) == 1), once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1),
                    once(bit4(0xAA117D) == 1), once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1),
                    once(bit7(0xAA117D) == 1), once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1),
                    once(bit2(0xAA117E) == 1), once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1),
                    once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1), once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1),
                    once(bit7(0xAA1184) == 1), once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1),
                    once(bit2(0xAA1185) == 1), once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1),
                    once(bit5(0xAA1185) == 1), once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1),
                    once(bit0(0xAA1186) == 1), once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1),
                    once(bit3(0xAA1186) == 1), once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1),
                    once(bit6(0xAA1186) == 1), once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1),
                    once(bit1(0xAA1187) == 1), once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1),
                    once(bit4(0xAA1187) == 1), once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1),
                    once(bit7(0xAA1187) == 1), once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1),
                    once(bit2(0xAA1188) == 1), once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1),
                    once(bit5(0xAA1188) == 1), once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1),
                    once(bit0(0xAA1189) == 1), once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1),
                    once(bit3(0xAA1189) == 1), once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1),
                    once(bit6(0xAA1189) == 1), once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1),
                    once(bit1(0xAA118A) == 1), once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1),
                    once(bit4(0xAA118A) == 1), once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1),
                    once(bit7(0xAA118A) == 1), once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1),
                    once(bit2(0xAA118B) == 1), once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1),
                    once(bit5(0xAA118B) == 1), once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1),
                    once(bit0(0xAA118C) == 1), once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1),
                    once(bit3(0xAA118C) == 1), once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1),
                    once(bit6(0xAA118C) == 1), once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1),
                    once(bit1(0xAA118D) == 1), once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1),
                    once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)),
                    when=menuId() == 22 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) == 10, format="percent"
                )))
)

achievement(
    title = "The Meditating Man", points = 1,
    description = "Find someone who has also met the meditating man in chapter 6",
    id = 405098, badge = "461723", published = "5/03/2024 14:02:39", modified = "5/03/2024 14:02:39",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 7) &&
              once(isCutsceneActivePreferred() == 1 && currentSceneMapScenarioId() == 21 && dword(npcTalkCountOlderMan1980Chapter6() & 0x1FFFFFF) == 397 &&
                  dword(interactionIdentification() & 0x1FFFFFF) == 178 && dword(interactionIdentification() & 0x1FFFFFF) == 999 &&
                  npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit() > prev(npcTalkCountYoungBlondeBoyPresentChapter4WearingThePerformerOutfit())
              ) && trigger_when(prev(isCutsceneActivePreferred()) != 0) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Philosopher's Wisdom", points = 1,
    description = "Acquire one last message during the EX chapter",
    id = 405112, badge = "461653", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(isCutsceneActivePreferred() == 5 && bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 && bit0EndingCUnlocked() == 1 &&
                  bit0EndingDUnlocked() == 1 && bit0EndingEUnlocked() == 1 && bit0EndingExUnlocked() == 1 && bit7(0xA9ED98) == 1 &&
                  chapterId() == 1 && cutsceneIdMaster() == 198528 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 54768 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 3600 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 523536 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 3600
              ) && trigger_when(ornamentalEgg() == 1) && trigger_when(prev(isCutsceneActivePreferred()) != 0) &&
              trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "The Philosopher's Destiny", points = 3,
    description = "Achieve Ending EX, by destroying the jewel",
    id = 405113, badge = "461652", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(isCutsceneActivePreferred() == 5 && philosopherSStone() == 1 && bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 &&
                  bit0EndingCUnlocked() == 1 && bit0EndingDUnlocked() == 1 && bit0EndingEUnlocked() == 1 && bit0EndingExUnlocked() == 1 &&
                  bit7(0xA9ED98) == 1 && chapterId() == 1 && cutsceneIdMaster() == 686720 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 234736 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 16816 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 1315744 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 16816
              ) &&
              once(chapterId() == 1 && cutsceneIdMaster() == 424256 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingExUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Philosopher's Legacy", points = 3,
    description = "Achieve Ending EX, by creating a miracle cure",
    id = 405114, badge = "461651", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((pointerEndingFileWhenInExtraMenu() & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(isCutsceneActivePreferred() == 5 && philosopherSStone() == 1 && bit0(0xAA1154) == 1 && bit0EndingBUnlocked() == 1 &&
                  bit0EndingCUnlocked() == 1 && bit0EndingDUnlocked() == 1 && bit0EndingEUnlocked() == 1 && bit0EndingExUnlocked() == 1 &&
                  bit7(0xA9ED98) == 1 && chapterId() == 1 && cutsceneIdMaster() == 363520 && cutsceneSectionId1() == 1 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 157936 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 72640 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 467440 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 72640
              ) &&
              once(chapterId() == 1 && cutsceneIdMaster() == 424256 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0EndingExUnlocked() == 1) &&
              ((trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((videoDataIntroAndCredits() & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Horologic Heritage", points = 2,
    description = "Kindle the joy of watchmaking to an ancestor of the Franssen's",
    id = 405460, badge = "461726", published = "6/03/2024 15:30:06", modified = "6/03/2024 15:30:06",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((chapterId() != 7 && chapterId() != 8 && chapterId() != 9 && chapterId() != 11)) &&
              once(isCutsceneActivePreferred() == 5 && currentlySelectedItemInInventory() == 16 && cutsceneIdMaster() == 70848 && cutsceneSectionId1() == 65535 &&
                  cutsceneSectionId2() == 0 && dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 44368 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 70816
              ) && trigger_when(prev(isCutsceneActivePreferred()) != 0) && trigger_when(isCutsceneActivePreferred() == 0)
)

achievement(
    title = "A Complimentary Dinner", points = 3,
    description = "Enjoy a free supper at Bar Zum Ei during chapter 5",
    id = 405461, badge = "461695", published = "6/03/2024 15:30:07", modified = "6/03/2024 15:30:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((flagEventViewerPreferred() == 33 && dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((pointerWhenInExtraMenu() & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(chapterId() != 6) && never((bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0)) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 403520 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 156064 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 27840 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 638304 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 27840
              ) &&
              once(isCutsceneActivePreferred() == 5 && cutsceneIdMaster() == 1023168 && cutsceneSectionId1() == 1 && cutsceneSectionId2() == 0 &&
                  dword((cutsceneIdentificationMasterData() & 0x1FFFFFF) + 0x000008) == 24240 &&
                  dword((cutsceneIdentificationSectionData() & 0x1FFFFFF) + 0x000008) == 998896 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000008) == 2812512 &&
                  dword((cutsceneIdentificationMinorIds() & 0x1FFFFFF) + 0x000028) == 998896
              ) && trigger_when(prev(isCutsceneActivePreferred()) > 3) && trigger_when(isCutsceneActivePreferred() <= 3) &&
              trigger_when(isCutsceneActivePreferred() != 0)
)
