// Prince of Persia: Revelations
// #ID = 18323

// $CB5E7C: [PAL][9-byte ASCII] PSP Game ID --> EUR
//          - ASCII = ULES00223
// $CC8E4C: Artwork Unlocked Bit String
//          Bit 0 - Beach (Present) - Crows
// $CC900C: [PAL][16-byte Bitset] Extra Feature Unlocks
//          - Documentation will be written as follows (as to correspond how the artwork gallery menu is designed):
//          - B1 => referring to column B (2nd column) and row 1 (1st line)
//          | . | A | B | C | D | E |
//          |---|---|---|---|---|---|
//          | 1 | _ | _ | _ | _ | _ |
//          | 2 | _ | _ | _ | _ | _ |
//          | 3 | _ | _ | _ | _ | _ |
//          
//          [PAL][Bit Flags] Extra Feature Unlocks | Characters
//          bit 0 => A1
//          bit 1 => D4
//          bit 2 => B1
//          bit 3 => A4
//          bit 4 => C4
//          bit 5 => D1
//          bit 6 => B4
//          bit 7 => E1
// $CC900D: [PAL][Bit Flags] Extra Feature Unlocks | Characters
//          bit 0 => C1
//          bit 1 => A2
//          bit 2 => D2
//          bit 3 => B2
//          bit 4 => C2
//          bit 5 => E4
//          bit 6 => D3
//          bit 7 => B3
// $CC900E: [PAL][Bit Flags] Extra Feature Unlocks | Environments + Characters
//          --- Characters ---
//          bit 0 => C2
//          bit 1 => E2
//          bit 2 => E3
//          bit 3 => A3
//          bit 4 => A5 (unlocks 1 character art + 1 environment art)
//          bit 5 => B5 (unlocks 1 character art + 1 environment art)
//          --- Environments ---
//          bit 4 => A1
//          bit 5 => B1
//          bit 6 => C1
//          bit 7 => D1
// $CC900F: [PAL][Bit Flags] Extra Feature Unlocks | Environments
//          bit 0 => E1
//          bit 1 => A2
//          bit 2 => B2
//          bit 3 => C2
//          bit 4 => D2
//          bit 5 => E2
//          bit 6 => A3
//          bit 7 => B3
// $CC9010: [PAL][Bit Flags] Extra Feature Unlocks | Environments
//          bit 0 => C3
//          bit 1 => D3
//          bit 2 => E3
//          bit 3 => A4
//          bit 4 => B4
//          bit 5 => C4
//          bit 6 => D4
//          bit 7 => E4
// $CC9011: [PAL][Bit Flags] Extra Feature Unlocks | Environments
//          bit 0 => A5
//          bit 1 => B5
//          bit 2 => C5
//          bit 3 => D5
//          bit 4 => E5
//          bit 5 => A6
//          bit 6 => B6
//          bit 7 => C6
// $CC9012: [PAL][Bit Flags] Extra Feature Unlocks | Environments
//          bit 0 => D6
//          bit 1 => E6
//          bit 2 => A7
//          bit 3 => B7
//          bit 4 => C7
//          bit 5 => D7
//          bit 6 => E7
//          bit 7 => A8
// $CC9013: [PAL][Bit Flags] Extra Feature Unlocks | Environments + Illustrations
//          bit 0 => D8
//          bit 1 => E8
//          bit 5 => Unlocks all illustrations (via secret ending)
// $CC9014: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Axes ----
//          bit 1 => Allatum B1
//          bit 2 => Ahura B2
//          bit 3 => Mainyu A3
//          bit 4 => Vidatu A2
//          bit 5 => Bahram C3
//          bit 6 => Ariyaman A1
//          bit 7 => Ereta E2
// $CC9015: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Axes ---
//          bit 0 => Vahishta E1 (There's a dagger with an identical name)
//          bit 1 => Ahura B3
//          bit 2 => Spentas D3
//          bit 3 => Apam D2
//          bit 4 => Natat C1
//          bit 5 => Apaosa D1
//          --- Daggers ----
//          bit 6 => Vahishta A2 (There's an axe with an identical name)
//          bit 7 => Armaiti D1
// $CC9016: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Daggers ---
//          bit 0 => Abathur C1 (opening this one in the weapon gallery, opens the artwork for dagger Indra, small bug in the code)
//          bit 1 => Indra B1
//          bit 2 => Khara A1
//          bit 3 => Yazata E1
//          --- Maces ---
//          bit 4 => Vata C1
//          bit 5 => Izha C2
//          bit 6 => Zend B1
//          bit 7 => Menog E1
// $CC9017: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Maces ---
//          bit 0 => Sraosa D1
//          bit 1 => Yima B2
//          bit 2 => Peris A1
//          --- Axes ---
//          bit 3 => Baga B1
//          --- Miscellaneous ---
//          bit 4 => Hockey Stick D1
//          bit 5 => Teddy Bear A1
//          bit 6 => Flamingo C1
//          bit 7 => Light Sword E1
// $CC9018: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Swords ---
//          bit 0 => Mahre A4
//          bit 1 => Srosh C3
//          bit 2 => Vanant A2
//          bit 3 => Yasht E1
//          bit 4 => Dena B4
//          bit 5 => Kerena B2
//          bit 6 => Asto A3
//          bit 7 => Agas B3
// $CC9019: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Swords ---
//          bit 0 => Tasan E2
//          bit 1 => Haoma C1
//          bit 2 => Rustam D3
//          bit 3 => Spenta D1
//          bit 4 => Mainyu E3
//          bit 5 => Zarich B1
//          bit 6 => Camros C2
//          bit 7 => Buyasta A1
// $CC901A: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Mixed ---
//          bit 0 => Asman C4 (Sword)
//          bit 1 => Drvaspa C2 (Axe)
//          bit 2 => Fravashis D2 (Sword)
//          bit 3 => White Glove B1 (Miscellaneous)
//          bit 6 => Eagle Sword A1 (Main Weapon)
//          bit 7 => Wooden Sticky B2 (Main Weapon)
// $CC901B: [PAL][Bit Flags] Extra Feature Unlocks | Weapons
//          --- Main Weapons ---
//          bit 0 => Spider Sword C1
//          bit 1 => Serpent Sword D1
//          bit 2 => Lion Sword E1
//          bit 4 => Scorpion Sword A2
//          bit 5 => Water Sword B2
// $CCC118: [PAL][25-bit Pointer{1}] --> Boss HP
//          +0x18 - [25-bit Pointer{2}]
//          .+0x4 - [25-bit Pointer{3}]
//          ..+0x48 - [25-bit Pointer{4}]
//          ...+0x11c - [32-bit] Boss HP
//          ...| - Boss HP during a boss battle
//          ...| - Value is 0 when not in a boss battle
// $CD66D0: Story/Objective Progress
// $CDB304: [PAL][Bit Flag {32-bit}] bit 0 => Is Video Playing
// $CDB33C: [PAL][32-bit] Video Playhead Indicator
//          - Value starts at 0x0, on new video start
//          - Value halts at the last video frame on video end)
//          - Manually changing this value cannot be used to move the playhead (skipping video not possible with this)
// $CDB340: [PAL][32-bit] Video Playhead Indicator (copy of $0xcdb33c)
// $CDB344: [PAL][12-byte ASCII] Video File Name ID
//          - ACSII = current/last video file that is/was played
//          - These can be used as checkpoints for story progression
//          
//          # VideoFileNameIDs (list is incomplete)
//          | '''''''''''''''''
//          | - CINE0100.BIK => Plays on New Game - Prince running from Shadow and ship boarding
//          | - CINE0101.BIK => Plays on lower deck of Prince ship - Raider ship crashing into Prince ship (pretty short video)
//          | - CINE0102.BIK => Plays after fighting Shahdee boss on ship - Prince talks with old man in tent
//          | - ...
// $CDFC08: 'You Got' Message (ASCII Text)
// $CE1238: [PAL][8-bit Bitfield {32-bit}] Display Language (alt 1)
//          - PAL version of Warrior Within (PS2 equivalent) has 'nl' as 0x5 (6th option)
//          - Following the sorting of the language select menu, 'it' and 'de' are switched
//          0x0 => en
//          0x1 => fr
//          0x2 => es
//          0x3 => it
//          0x4 => de
// $CE5DAC: [PAL][32-bit] Frame Counter
//          - Increments by 2, each frame (might lag a bit during loading)
//          - Frame counter is always active
//          - Freezing this value during video's, halts the video
// $CFA780: Game ID (ASCII Text) (ULUS10063)
// $CFA7C4: Game Title (ASCII Text)
// $CFA844: Current Location (ASCII Text) (Only Updates on Using Fountain)
// $CFA8C4: Objective Text (ASCII Text) (Only updates on using fountain)
// $CFB7F4: [PAL][8-bit Bitfield {32-bit}] Display Language (alt 2)
//          - Identical to $0xce1238
// $D1E228: [PAL][Bit Flag {32-bit}] bit 0 => Is In-engine Cutscene Active (alt 1)
// $D1E3C8: [PAL][Bit Flag {32-bit}] bit 0 => Is In-engine Cutscene Active (alt 2)
// $DF03C8: [PAL][25-bit Pointer] Game_Controller_Object (Possibly)
//          +0x18 - [25-bit Pointer{2}]
//          .+0x4 - [25-bit Pointer{3}]
//          ..+0x48 - [25-bit Pointer{4}] --(+0x0)--> [5868-byte Struct] Prince_Data
//          ..| - Struct definition at $0x14246b0
// $E5CDF0: Checkpoint Coordinates (32-Bit)
// $E5CE10: Maybe Last Fountain Used?
// $E5CE9C: Map ID (32-Bit)
// $E5CEB8: Checkpoint Area ID (32-Bit)
// $E5CFF0: [PAL][32-bit] SubArea (Checkpoint) ID
//          - Needs to be combined with $0xe5d0b8 to ID the effective checkpoint
//          - IDs listed at $0xe5d0b8
// $E5D0A4: [PAL][8-bit Bitfield] Camera Settings
//          bit pair 1-0 => Slow Motion Cam Frequency
//          | = 00 => Never
//          | = 01 (bit 1 = 0; bit 0 = 1) => Seldom
//          | = 10 => Normal
//          | = 11 => Often
//          bit 2 = 0 => Free Look: Normal; bit 2 = 1 => Free Look: Inverted
//          bit 3 = 0 => Rotation: Normal; bit 3 = 1 => Rotation: Inverted
// $E5D0B4: [PAL][32-bit {8-bit}] Difficulty
//          - Only selectable at start of new game (manually changing difficulty is possible at runtime and will scale stats)
//          - Difficulty only scales enemy HP and Prince Max HP (visually feels like enemies do more damage)
//          0x0 => easy (EnemyHP x 1; PrinceMaxHP x 1 (= 150 at new game))
//          0x1 => normal (EnemyHP x 1.5; PrinceMaxHP x 0.66 (= 100 at new game))
//          0x2 => hard (EnemyHP x 2; PrinceMaxHP x 0.44 (= 66 at new game))
// $E5D0B8: [PAL][32-bit] MainArea (Checkpoint) ID
//          - Needs to be combined with ($0xe5cff0) to ID the effective checkpoint (freezing only this value and not the other, results in respawning out-of-bounds)
//          - This IDs the location where the player respawns when selecting retry from the Game Over menu or loading a game
//          - Changing and freezing both MainArea_ID and SubArea_ID to appropriate IDs, as listed below, before activating a loading screen => will load/spawn the Prince at that location/checkpoint. This can be used to skip to whatever story section/area you want.
//          
//          # Location_ID list
//          | (list incomplete; IDs are identical to the one's used in Warrior Within, although there's some extra area's in this port)
//          | ==================
//          | ▸ 0x4d07964b (MainArea_ID) + 0x2b08277a (SubArea_ID) => Ship Battle
//          | ▸ 0x2b082803 (MainArea_ID) => Beach
//          | ``| + 0x2b082848 (SubArea_ID) => Ship wreckage
//          | ``| + 0x33010fbb (SubArea_ID) => 1st water fountain (save station) up the broken down walkway
//          | ▸ 0x2b082807 + 0x29015c1c => Gate before being ambushed by Shahdee at the fortress entrance
//          | ▸ 0x0812feb0 => Inside Fortress (past gate)
//          | ``| + 0x0813f21f => 1st water fountain past gate
//          | ▸ 0x0812feae + 0x0813f239 => Past CrowMaster
// $11A0578: [PAL][25-bit Pointer{1}] Enemy Data
//           - Each enemy has a unique EnemyData_Pointer
//           
//           +0x11e8 - [56-byte Array] List of [EnemyData_Pointers{2}] - Aggro
//           | - List only contains EnemyData_Pointers of enemies which are alive AND in aggresive state (aggro'd)
//           
//           { [Struct Definition][32-bit] EnemyData_Pointer{2}
//           |'''''''''''''''''''''''''
//           | +0x18 - [25-bit Pointer {3}]
//           | .+0x4 - [25-bit Pointer {4}]
//           | .| +0x5C - [32-bit] Enemy Type ID (IDs listed below)
//           | .| +0x48 - [25-bit Pointer {5}]
//           | .| | +0x0 - [Variable Size] EnemyData_Object
//           
//           { [Struct Definition][Variable Size] EnemyData_Object (By Enemy Type) + Enemy Type ID
//           |'''''''''''''''''''''''''''''''''''''''''
//           | - Structure is dependent on enemy type
//           |
//           | | ---- Crow (ID = 0x551) ----
//           | | TBD
//           |
//           | | ---- Raider (0x10f1) ----
//           | | +0x208 - [32-bit] HP
//           |
//           | | ---- CrowMaster (0xB51) ----
//           | | +0x200 - [32-bit] HP, if CrowMaster teleports to a different platform it's still the same enemy
//           |
//           | | ---- Silhouette (0xD91) ----
//           | | +0x18C - [32-bit] HP
//           | | +0x140 - [32-bit] AI Behavior (eg. 0x42 => attacking, 0x169 => taunting...)
//           |
//           | | ---- Shahdee(Boss) (0x1091) ----
//           | | - ID = 0x1091 (1st appearance on ship)
//           | | +0x198 - [32-bit] HP
// $11D1E6C: [PAL][Bit Flag {32-bit}] bit 0 => Is In-engine Cutscene Active (alt 3)
// $1418614: Sands (Mirror)
// $1418620: Gameplay=00?
//           Cutscene=01?
//           Cutscene Ends=02?
// $14187C0: [PAL][32-bit] Prince HP (Visual)
//           - Controls visuals for HP inside the HUD in top-left
// $14187DC: [PAL][32-bit] Prince HP (Visual)
//           - Copy of $0x14187c0
// $14246A4: Prince HP in first building
// $14246B0: [PAL][5868-byte Struct] Prince_Data
//           @Fixed Memory Location. Although pointed to by: Game_Controller_Object $0xdf03c8
//           - This is practically the same structure as used in Warrior Within (PS2)
//           
//           { [Struct Definition][5868-byte] Prince_Data
//           |==========================================
//           |
//           | +0x1F4 - [32-bit] Prince HP (Functional)
//           | | - Documentation at $0x14248a4
//           |
//           | +0x924 - [Bit Flag {32-bit}] bit 0 => Is No In-engine cutscene Active
//           | | - Documentation at $0x1424fd4
//           |
//           | +0x11C4 - [Bit Flags {32-bit}] Sands of Time Powers Unlocked
//           | | - Documentation at $0x1425874
//           |
//           | +0x1328 - [2-byte Bitset] HP Upgrades Acquired (9 total)
//           | | - Documentation at $0x14259d8
//           |
//           | +0x1358 - [25-bit Pointer] --(+0x0)--> [48-byte Struct] Secondary_Weapon_Data
//           | | - Documentation at $0x1425a08
//           |
//           | +0x1400 - [25-bit Pointer] --(+0x0)--> [30-byte?? Struct] Primary_Weapon_Data
//           | | - Documentation at $0x1425ab0
//           |
//           | +0x1490 - [32-bit] Prince Max HP (Functional)
//           | | - Documentation at $0x1425b40
// $14248A4: [PAL][32-bit] Prince HP (Functional)
//           @Member of Struct: Prince_Data $0x14246b0
// $14248A8: 0x0B=Drinking?
// $1424F44: Sands (Real)
// $1424FD4: [PAL][Bit Flag {32-bit}] bit 0 => Is No In-engine cutscene Active
//           @Member of Struct: Prince_Data $0x14246b0
//           0 => during video's and during in-engine cutscenes
//           1 => no in-engine cutscene is playing OR at the title screen OR during some loading screens
// $1425674: Sand Powers Unlocked
//           0x01=Recall
//           0x02=Eye of the Strom
// $14257D8: Life Upgrades Collected Bit String
//           (Bits 0-7)
// $1425874: [PAL][Bit Flags {32-bit}] Sands of Time Powers Unlocked
//           @Member of Struct: Prince_Data $0x14246b0
//           - Check in-game combo list menu: how to activate each power
//           - Powers are functional after intro section on ship
//           - Unlocking these manually via RAM, might be bug the power
//           bit 0 => Recall (redo/rewind)
//           bit 1 => Eye of the Storm (slow down time)
//           bit 2 => Breath of Fate (ground slam)
//           bit 3 => Wind of Fate (upgraded/replaces 'Breath of Fate')
//           bit 4 => Cyclone of Fate (upgraded/replaces 'Wind of Fate')
//           bit 5 => Ravages of Time (superspeed/quickness)
// $14258B0: Current Sword Pointer?
// $1425940: Max Life
// $14259D8: [PAL][2-byte Bitset] HP_Upgrades (9 total)
//           @Member of Struct: Prince_Data $0x14246b0
//           - All locations are in the past
//           - 1 HP upgrade: easy => +0x19; normal => +0x11; hard => +0xC
//           
//           [PAL][Bit Flags] @Byte 1 in Bitset: HP_Upgrades $0x14259d8
//           bit 0 => Fortress Entrance (can also be achieved without using EyeOfTheStorm (slow-mo) power)
//           bit 1 => TBD
//           bit 2 => TBD
//           bit 3 => Sacrificial Chamber (behind stone, after 2nd Shahdee boss fight)
//           bit 4 => TBD
//           bit 5 => TBD
//           bit 6 => TBD
//           bit 7 => TBD
// $14259D9: [PAL][Bit Flags] @Byte 2 in Bitset: HP_Upgrades $0x14259d8
//           bit 0 OR 7 => TBD
// $1425A08: [PAL][25-bit Pointer{1}] --(+0x0)--> [48-byte Struct] Secondary_Weapon_Data
//           @Member of Struct: Prince_Data $0x14246b0
//           - This pointer is only operational when a secondary weapon is equipped (Refer to $0xcb783c)
//           
//           0x0 => no secondary weapon equipped
//           OtherValue = Pointer => secondary weapon is equipped
//           
//           { [Struct Definition][48-byte] Secondary_Weapon_Data
//           |'''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x10 - [25-bit Pointer{2}] --(+0x0)--> [60-byte Struct] Secondary_Weapon_Model_Data
//           | { [Struct Definition][60-byte] Secondary_Weapon_Model_Data
//           | |''''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | | +0x0 - [48-byte] Model/Texture Data?
//           | | ¨¨¨¨ This 48-byte block is unique per weapon, thus can be used to ID the currently equipped secondary weapon (prefer using Secondary_Weapon_Model_Data_B to ID secondary weapon)
//           |
//           | +0x14 - [25-bit Pointer{2}]
//           | .+0x0 - [25-bit Pointer{3}] --(+0x0)--> [12-byte Struct] Secondary_Weapon_ID
//           | .{ [Struct Definition][60-byte] Secondary_Weapon_ID
//           | .|''''''''''''''''''''''''''''''''''''''''''''
//           | .| +0x0 - [32-bit {64-bit}] ID - Part 1
//           | .| ¨¨¨¨ This 64-bit block IDs the currently equipped secondary weapon (IDs listed below)
//           | .| ¨¨¨¨ These IDs are actually pointers going deeper
//           | .| ¨¨¨¨ Changing these values to valid IDs changes the model to the corresponding weapon (be warned, some invalid values can cause crashes)
//           | .| +0x4 - [32-bit] ID - Part 2
//           |
//           | +0x18 - [25-bit Pointer{2}] --> Secondary Weapon Durability
//           | | +0x4 - [25-bit Pointer{3}]
//           | | .+0x48 - [25-bit Pointer{4}]
//           | | ..+0x18 - [32-bit] Secondary Weapon Durability (Functional)
//           | | ..| - Durability is dependent on weapon ID
//           
//           # SecondaryWeapon_IDs ([ID_part1] + [ID_part2] => weapon name) (list incomplete)
//           |''''''''''''''''''''''
//           |---- Swords ----
//           |---- Axes ----
//           | 0x09584310 + 0x09584bd0 => Airyaman
//           |---- Maces ----
// $1425AB0: [PAL][32-bit Pointer] --(+0x0)--> [30-byte?? Struct] Primary_Weapon_Data
//           @Member of Struct: Prince_Data $0x14246b0
//           - Higher tiers of primary weapons, increase the length of attack/combo strings (refer to $0x1367af0)
//           - Data in this 30-byte block may be used to ID the primary weapon, but not encouraged as data here may be volatile, also contains more pointers
//           - Each primary weapon has a unique pointerValue, game keeps a list of these PrimaryWeapon_Pointers in RAM at $0xc5c3a0
//           - The pointers to Primary_Weapon_Data can be used to ID the weapon, see list below (different release regions may have different pointerValues)
//           
//           { [Struct Definition][30-byte??] Primary_Weapon_Data
//           |''''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x0 - [64-bit] Might be related to attack logic and which combo strings/attack animations are allowed (refer to $0x1367af0), game breaks on manual value changes
//           
//           # PrimaryWeapon_IDs (= values at this memAddr = Pointers --> Primary_Weapon_Data)
//           |'''''''''''''''''
//           | TBD => Eagle Sword (starter weapon on ship)
//           | TBD => Wooden Stick
//           | TBD => Spider Sword
//           | TBD => Serpent Sword
//           | TBD => Lion Sword
//           | TBD => Scorpion Sword
//           | TBD => Water Sword
// $1425B40: [PAL][32-bit] Prince Max HP (Functional)
//           @Member of Struct: Prince_Data $0x14246b0
//           - Dependent on game difficulty (refer to $0xe5d0b4)
// $1AA3C88: Mid Boss HP?
