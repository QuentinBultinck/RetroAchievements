// Dynasty Warriors: Advance
// #ID = 5763

// $003FD4: [PAL][108-bytes] Challenge Mode | Character Data
// $003FDA: [PAL][16-bit] Challenge Mode | Character ID
//          - Uses same character IDs as documented @ 0xb170
// $003FE0: [PAL][16-bit] Challenge Mode | Character Stat - Health
// $003FE2: [PAL][16-bit] Challenge Mode | Character Stat - Max Health
// $003FE4: [PAL][16-bit] Challenge Mode | Character Stat - Musou Gauge
// $003FE6: [PAL][16-bit] Challenge Mode | Character Stat - Max Musou Gauge
// $003FE8: [PAL][16-bit] Challenge Mode | Character Stat - Attack (damage)
// $003FEA: [PAL][16-bit] Challenge Mode | Character Stat - Defense
// $003FEC: [PAL][16-bit] Challenge Mode | Character Stat - Movement (speed)
// $004020: [PAL][16-bit] Challenge Mode | Character Stat - Total KO Count
// $004024: [PAL][16-bit] Challenge Mode | Character Stat - Battle KO Count
// $004029: [PAL][8-bit] Challenge Mode | Character Stat - Ability Gauge: Highlighted Ability
//          - Refer to 0xb1c9, for explanation
// $00402A: [PAL][8-bit] Challenge Mode | Character Stat - Ability Gauge: Fill Rate
//          - Refer to 0xb1ca, for explanation
// $00402B: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Valor (Orange Sword)
// $00402C: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Speed (Lightblue foot)
// $00402D: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Storm (Pink)
// $00402E: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Chain (Darkblue)
// $00402F: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Stun (Yellow)
// $004030: [PAL][8-bit] Challenge Mode | Character Stat - Ability Level: Reach (Green)
// $006258: [PAL][32-bit] Challenge Mode | In-battle Player Character Location x-Axis
//          - Value decreases when going east
//          - Value increases when going west
// $00625C: [PAL][32-bit] Challenge Mode | In-battle Player Character Location y-Axis
//          - Value decreases when going north
//          - Value increases when going south
// $006A5C: [PAL][16-bit] Selected Weapon In Encyclopedia
//          - Value range [0x0-0xe5]
//          - This value = the index of the weapon's bitflag in the bitset documented @ 0xad50
// $006B6A: [PAL][16-bit] Copy of 0x3fe0, when in Challenge Mode
//          - This is a constant value, not changeable
// $007DC8: [PAL][Bit Flag] bit 0 => is in Free Mode
// $008360: [PAL][24-bit Pointer] --> Musou/Free Mode | In-Battle Timer (alt 1)
//          
//          +0xB0BC - [32-bit] In-Battle Timer (UI control)
//          | - Value range [0x0-0xFFFFFFFF]
//          | - Does not overflow
//          
//          +0xB0C0 - [32-bit] In-Battle Timer (functional timer)
//          | - Value range [0x0-0x57e40] (= 0-360000)
//          | - Does not overflow
// $008560: [PAL][24-bit Pointer] --(+0x8000)--> [Variable Size] Overworld_Stage_Data
//          
//          +0x8012 - [Variable Length Array] List of [44-byte] Overworld_Character_Objects
//          { [Struct Definition][44-byte] Overworld_Character_Object
//          | ''''''''''''''''''''''''''''''''''''''''''''''''
//          | - Size and contents is dependent on the Stage ID (refer to $0xC0DC)
//          | - Contains information about all the characters on the overworld map, as well as stage event bitflags
//          | - First Overworld_Character_Object in the list is always player character/officer
//          | - Some Overworld_Character_Objects contain bitflags, which corresponds to a specific event
//          | - Some characters/officers spawn in later during the stage; corresponding bitflags should be present
//          |
//          | +0x4 - [Bit Flag] bit 0 => is character sprite visible (on overworld map)
//          |
//          | +0xC - [16-bit] Character Sprite Location - x-Axis
//          | | - This value corresponds to the 2d character sprite/artwork
//          | | - This serves only a visual purpose
//          |
//          | +0xE - [16-bit] Character Sprite Location - y-Axis
//          |
//          | +0x16 - [Bit Flag] bit 0 => is character alive (on overworld map)
//          | | - Doesn't work as a player has died flag (unverified)
//          |
//          | +0x1A - [8-bit] Overworld_Character_ID
//          | | - This controls the name above the character sprite
//          | | - IDs documented at $0xb170
//          |
//          | +0x1E- [16-bit] Area ID
//          | | - Each movable area on the map has a unique ID
// $0085A4: [NTSC-J][32-bit] Region Identifier --> JPN
//          - 0x1 => NTSC-J
//          - 0x0 => PAL
//          - Pointer (starting with 0x08...) => NTSC-U
// $0085C8: [NTSC-U][32-bit] Region Identifier --> USA
//          - 0x1 => NTSC-U
//          - 0x0 => NTSC-J and PAL
// $0085DC: [PAL][32-bit] Region Identifier --> EUR
//          - 0x1 => PAL
//          - 0x0 => NTSC-U and NTSC-J
// $00AD1C: [PAL] Game Data: Linked List - Node #0
//          ==================================
//          - Most of the game data, aside from challenge mode data, is connected to this linked list
//          - The list is 40+ nodes long
//          
//          { [Struct Definition][Variable size] Linked_List_Node
//          | ''''''''''''''''''''''''''''''''''''''''
//          | +0x0 - [32-bit] Usually 0x0 <-- This is where the node starts
//          | +0x4 - [32-bit] A value used as an offset <-- Can be used to ID the node
//          | +0x8 - [32-bit] A value used as an offset, is mostly 0x1
//          | +0xC - [24-bit Pointer] +0x8000 --> Previous node
//          | +0x10 - [24-bit Pointer] +0x8000 --> Next node
//          | (+0x14->nextNode) - [Variable size] Data stored at this node
//          
//          
//          Notation explanation
//          '''''''''''''''''''
//          +0x8010 - Points to the next node's pointer which points to the next-next node
//          - So getting to node #5 equals => 4x AddAddress 0x8010 + 1x AddAddress 0x8000
//          | [Node #0: 24-bit pointer -> next node]
//          | +0x8010 - Node #1
//          | .+0x8010 - Node #2
//          | ..+0x8010 - Node #3
//          | ...+0x8010 - Node #4
//          | ....+0x8000 - Node #5
//          
//          
//          Notable Nodes (in order)
//          '''''''''''''''''''
//          > Nodes #0-5
//          | - Have stable memory locations
//          | - The nodes further in the list, are unstable and have been observed switching in the list order (eg node #8 becoming node #6, or a whole list section gone missing)
//          
//          > Node #1 - Unlocked Weapons (refer to notes @ 0xad50)
//          > Node #2 - Musou/Free Mode | Character Data (refer to notes @ 0xb170)
//          
//          > Node (offset_ID 0xfa68)
//          > Node (0x208) - 3rd from 0xfa68
//          > Node (0x388) - Next from 0x208 - 4th from 0xfa68
//          > Node (0x4c0) - 12th from 0x388 - 3rd from 0xbba8
//          
//          > Node #[19-25](unverified) (0xa4) - In-Battle Silver Soldier Data
//          | '''''''''''''''''''''''''''''''''''''''''''
//          | +0x84 -  Contains the stats for 1 Silver Soldier; same data is used even when killing multiple in the same battle
//          |
//          | { [Struct Definition][48-bytes] Silver_Soldier_Object
//          | | ''''''''''''''''''''''''''''''''''''''''''''''
//          | | +0x10 - [16-bit] Enemy HP; takes 5 hits to die [5-0], when respawning this value resets to 5
//          | | +0x12 - [16-bit] Enemy Max HP
//          
//          > Node (0x1c)
//          
//          > Node #[25-35](unverified) - In-battle Enemy Data
//          | °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          | - To ID this node -> [16-bit] nodeStart+0x1a == 0xff02, could also ID with enemy count
//          | - (6th node from 0xa4; 9th node from 0x4c0)
//          |
//          | +0x14 - [16-bit] Amount of enemies to fight -1 (for some reason there's always 1 extra soldier)
//          |
//          | +0x18 - [Variable Length Array] List of Enemy_Soldier_Objects (48-bytes each)
//          | - Size of array depends on amount of enemy soldiers in the unit
//          |
//          | { [Struct Definition][48-bytes] Enemy_Soldier_Object
//          | | '''''''''''''''''''''''''''''''''''''''''
//          | | +0x5 - [8-bit] Enemy Type (uses same IDs at noted @ 0xb175)
//          | | +0x8 - [16-bit] Enemy Equipped Weapon (officers can equip different weapons)
//          | | +0x10 - [16-bit] Enemy HP; death at 0x0
//          | | +0x12 - [16-bit] Enemy Max HP
//          | | +0x14 - [16-bit] Enemy Musou
//          | | +0x16 - [16-bit] Enemy Max Musou
//          | | +0x18 - [16-bit] Enemy Attack
//          | | +0x1a - [16-bit] Enemy Defense
//          | | +0x1b - [16-bit] Enemy Movement
// $00AD50: [PAL][29-byte Bitset] Weapons_Unlocked (+ Weapon IDs)
//          ======================================
//          - This data is contained inside LinkedList_Node #1, but is always at this memory location (refer to notes @ 0xad1c)
//          - Each bit corresponds to a weapon
//          - Bitflags are grouped per weapon type
//          - Weapon IDs are also documented (corresponds to the index of the bit inside the bitset)
//          
//          [PAL][Bit Flags] @Byte1 in Bitset: Weapons_Unlocked
//          ---- Sword ----
//          bit 0 => Board Sword - 0x0 <-- Weapon ID
//          bit 1 => Gen. Sword - 0x1
//          bit 2 => Heaven Sword - 0x2
//          bit 3 => Heaven Wrath - 0x3
//          bit 4 => Blue Steel - 0x4
//          bit 5 => King of Wei - 0x5
//          bit 6 => Tiger Sword - 0x6
//          bit 7 => Tiger Claw - 0x7
// $00AD51: [PAL][Bit Flags] @Byte2 in Bitset: Weapons_Unlocked
//          ---- Sword ----
//          bit 0 => Lone Tiger - 0x8
//          bit 1 => Savage Tiger - 0x9
//          bit 2 => Wolf Blade - 0xa
//          bit 3 => King of Wu - 0xb
//          bit 4 => Long Sword - 0xc
//          bit 5 => Imp. Sword - 0xd
//          bit 6 => Gold Dragon - 0xe
//          bit 7 => Pure Dragon - 0xf
// $00AD52: [PAL][Bit Flags] @Byte3 in Bitset: Weapons_Unlocked
//          ---- Sword ----
//          bit 0 => Dragon Star - 0x10
//          bit 1 => King of Shu - 0x11
//          bit 2 => Wolf Sword - 0x12
//          bit 3 => Wolf Claw - 0x13
//          bit 4 => King Wolf - 0x14
//          bit 5 => Master Wolf - 0x15
//          bit 6 => Legacy - 0x16
//          bit 7 => Wolf Fang - 0x17
// $00AD53: [PAL][Bit Flags] @Byte4 in Bitset: Weapons_Unlocked
//          ---- Sword ----
//          bit 0 => Wolf Fury - 0x18
//          bit 1 => Wolf Strike - 0x19
//          bit 2 => Noble Sword - 0x1a
//          bit 3 => Regal Sword - 0x1b
//          bit 4 => Hero's Sword - 0x1c
//          bit 5 => King's Sword - 0x1d
//          bit 6 => Imp Saber - 0x1e
//          bit 7 => Majesty - 0x1f
// $00AD54: [PAL][Bit Flags] @Byte5 in Bitset: Weapons_Unlocked
//          ---- Sword ----
//          bit 0 => Prism Sword - 0x20
//          
//          ---- Rod ----
//          bit 1 => Iron Rod - 0x21
//          bit 2 => Great Rod - 0x22
//          bit 3 => Shadow Rod - 0x23
//          bit 4 => Dark Shadow - 0x24
//          bit 5 => Spiked Mace - 0x25
//          bit 6 => Shade - 0x26
//          bit 7 => Battle rod - 0x27
// $00AD55: [PAL][Bit Flags] @Byte6 in Bitset: Weapons_Unlocked
//          ---- Rod ----
//          bit 0 => Strike Rod - 0x28
//          bit 1 => Power Rod - 0x29
//          bit 2 => Enforcer Rod - 0x2a
//          bit 3 => Ogre Rod - 0x2b
//          
//          ---- Fan ----
//          bit 4 => Wisdom Fan - 0x2c
//          bit 5 => Command Fan - 0x2d
//          bit 6 => Black Fan - 0x2e
//          bit 7 => Dark Feather - 0x2f
// $00AD56: [PAL][Bit Flags] @Byte7 in Bitset: Weapons_Unlocked
//          ---- Fan ----
//          bit 0 => Abyssal Fan - 0x30
//          bit 1 => War Fan - 0x31
//          bit 2 => Warlord Fan - 0x32
//          bit 3 => White Fan - 0x33
//          bit 4 => Peacock Fan - 0x34
//          bit 5 => Griffin Fan - 0x35
//          bit 6 => Divine Fan - 0x36
//          
//          ---- Staff ----
//          bit 7 => Vision Staff - 0x37
// $00AD57: [PAL][Bit Flags] @Byte8 in Bitset: Weapons_Unlocked
//          ---- Staff ----
//          bit 0 => Mirage Staff - 0x38
//          bit 1 => Wind Staff - 0x39
//          bit 2 => Storm Staff - 0x3a
//          bit 3 => Light Staff - 0x3b
//          bit 4 => Phoenix Rod - 0x3c
//          bit 5 => Magic Staff - 0x3d
//          bit 6 => Mystic Staff - 0x3e
//          bit 7 => Fire Staff - 0x3f
// $00AD58: [PAL][Bit Flags] @Byte9 in Bitset: Weapons_Unlocked
//          ---- Staff ----
//          bit 0 => Flame Staff - 0x40
//          bit 1 => Thunder Rod - 0x41
//          bit 2 => Peace Staff - 0x42
//          
//          ---- Flute ----
//          bit 3 => Flute - 0x43
//          bit 4 => Iron Flute - 0x44
//          bit 5 => Moon Flute - 0x45
//          bit 6 => Dark Flute - 0x46
//          bit 7 => Dawn Flute - 0x47
// $00AD59: [PAL][Bit Flags] @Byte10 in Bitset: Weapons_Unlocked
//          ---- Axe ----
//          bit 0 => Battle Axe - 0x48
//          bit 1 => Great Axe - 0x49
//          bit 2 => Destroyer - 0x4a
//          bit 3 => Marauder - 0x4b
//          bit 4 => Tiger Fang - 0x4c
//          bit 5 => Annihilator - 0x4d
//          bit 6 => Hand Axe - 0x4e
//          bit 7 => Strike Axe - 0x4f
// $00AD5A: [PAL][Bit Flags] @Byte11 in Bitset: Weapons_Unlocked
//          ---- Axe ----
//          bit 0 => Bull - 0x50
//          bit 1 => Mad Bull - 0x51
//          bit 2 => Beast Axe - 0x52
//          bit 3 => Bull Rampage - 0x53
//          
//          ---- Dao ----
//          bit 4 => Scimitar - 0x54
//          bit 5 => Wu Scimitar - 0x55
//          bit 6 => Kirin Blade - 0x56
//          bit 7 => Kirin Fang - 0x57
// $00AD5B: [PAL][Bit Flags] @Byte12 in Bitset: Weapons_Unlocked
//          ---- Dao ----
//          bit 0 => Storm Sword - 0x58
//          bit 1 => Kirin Blaze - 0x59
//          bit 2 => Hound Fang - 0x5a
//          bit 3 => Holy Fang - 0x5b
//          bit 4 => Mystic Fang - 0x5c
//          bit 5 => War Sword - 0x5d
//          bit 6 => Master Sword - 0x5e
//          bit 7 => Sage Sword - 0x5f
// $00AD5C: [PAL][Bit Flags] @Byte13 in Bitset: Weapons_Unlocked
//          ---- Dao ----
//          bit 0 => Oracle Sword - 0x60
//          bit 1 => Master Blade - 0x61
//          bit 3 => Sage's Blade - 0x62
//          bit 4 => Mystic Blade - 0x63
//          bit 5 => Tyrant Sword - 0x64
//          bit 6 => Great Tyrant - 0x65
//          bit 7 => Fear - 0x66
// $00AD5D: [PAL][Bit Flags] @Byte14 in Bitset: Weapons_Unlocked
//          ---- Dao ----
//          bit 0 => Pandemonium - 0x67
//          bit 1 => Star Blade - 0x68
//          bit 2 => Sun Blade - 0x69
//          bit 3 => Black Steel - 0x6a
//          
//          ---- Fencing Sword ----
//          bit 4 => Iron Blade - 0x6b
//          bit 5 => Iron Sword - 0x6c
//          bit 6 => Elder Sword - 0x6d
//          bit 7 => Elder Blade - 0x6e
// $00AD5E: [PAL][Bit Flags] @Byte15 in Bitset: Weapons_Unlocked
//          ---- Fencing Sword ----
//          bit 0 => Elder Moon - 0x70
//          bit 1 => Scion Sword - 0x71
//          bit 2 => Rapier - 0x72
//          bit 3 => Swift Rapier - 0x73
//          bit 4 => Star Rapier - 0x74
//          bit 5 => Nu Wa Rapier - 0x75
//          bit 6 => Wyrm Rapier - 0x76
//          bit 7 => Feng Rapier - 0x77
// $00AD5F: [PAL][Bit Flags] @Byte16 in Bitset: Weapons_Unlocked
//          ---- Fencing Sword ---
//          bit 0 => Short Katana - 0x78
//          bit 1 => Katana - 0x79
//          bit 2 => Dawn - 0x7a
//          bit 3 => Dusk - 0x7b
//          bit 4 => Setsuna - 0x7c
//          
//          ---- Large Sword ----
//          bit 5 => Great Sword - 0x7d
//          bit 6 => Titan Sword - 0x7e
//          bit 7 => Holy Avenger - 0x7f
// $00AD60: [PAL][Bit Flags] @Byte17 in Bitset: Weapons_Unlocked
//          ---- Large Sword ----
//          bit 0 => Fu Xi Sword - 0x80
//          bit 1 => Wyrm Slayer - 0x81
//          bit 2 => Feng Sword - 0x82
//          
//          ---- Pirate Sword ----
//          bit 3 => Pirate Sword - 0x83
//          bit 4 => River Sword - 0x84
//          bit 5 => River Master - 0x85
//          bit 6 => Sea Master - 0x86
//          bit 7 => Leviathan - 0x87
// $00AD61: [PAL][Bit Flags] @Byte18 in Bitset: Weapons_Unlocked
//          ---- Pirate Sword ----
//          bit 0 => Seven Oceans - 0x88
//          
//          ---- Halberd ----
//          bit 1 => Glaive - 0x89
//          bit 2 => Great Glaive - 0x8a
//          bit 3 => Tiger Hook - 0x8b
//          bit 4 => White Tiger - 0x8c
//          bit 5 => Mystic Tiger - 0x8d
//          bit 6 => Halberd - 0x8e
//          bit 7 => War Halberd - 0x8f
// $00AD62: [PAL][Bit Flags] @Byte19 in Bitset: Weapons_Unlocked
//          ---- Halberd ----
//          bit 0 => Sky Piercer - 0x90
//          bit 1 => Sky Scorcher - 0x91
//          bit 2 => Demon Slicer - 0x92
//          bit 3 => Maelstrom - 0x93
//          
//          ---- Crescent Blade ----
//          bit 4 => Crescent - 0x94
//          bit 5 => Moon Blade - 0x95
//          bit 6 => Blue Dragon - 0x96
//          bit 7 => Topaz Dragon - 0x97
// $00AD63: [PAL][Bit Flags] @Byte20 in Bitset: Weapons_Unlocked
//          ---- Crescent Blade ----
//          bit 0 => Holy Dragon - 0x98
//          bit 1 => Pole Blade - 0x99
//          bit 2 => Great Blade - 0x9a
//          bit 3 => Blue Wyvern - 0x9b
//          bit 4 => Gold Wyvern - 0x9c
//          bit 5 => Blaze Wyvern - 0x9d
//          
//          ---- Club ----
//          bit 6 => Club - 0x9e
//          bit 7 => Spiked Club - 0x9f
// $00AD64: [PAL][Bit Flags] @Byte21 in Bitset: Weapons_Unlocked
//          --- Club ----
//          bi-t 0 => Bone Crusher - 0xa0
//          bit 1 => Rock Crusher - 0xa1
//          bit 2 => Earthly Mace - 0xa2
//          bit 3 => Earth Shaker - 0xa3
//          
//          ---- Pike ----
//          bit 4 => Bronze Pike - 0xa4
//          bit 5 => Iron Pike - 0xa5
//          bit 6 => Poison Fang - 0xa6
//          bit 7 => Viper Blade - 0xa7
// $00AD65: [PAL][Bit Flags] @Byte22 in Bitset: Weapons_Unlocked
//          ---- Pike ----
//          bit 0 => Cobra Blade - 0xa8
//          bit 1 => Venom  - 0xa9
//          
//          ---- Spear ----
//          bit 2 => Bronze Spear - 0xaa
//          bit 3 => Great Spear - 0xab
//          bit 4 => Dragon Spear - 0xac
//          bit 5 => Dragon Fury - 0xad
//          bit 6 => Dragon Lash - 0xae
//          bit 7 => Dragon Rage - 0xaf
// $00AD66: [PAL][Bit Flags] @Byte23 in Bitset: Weapons_Unlocked
//          ---- Spear ----
//          bit 0 => Iron Spear - 0xb0
//          bit 1 => Steed Spear - 0xb1
//          bit 2 => Silver Steed - 0xb2
//          bit 3 => Steed Fury - 0xb3
//          bit 4 => Flying Steed - 0xb4
//          bit 5 => Last Steed - 0xb5
//          bit 6 => Trident  - 0xb6
//          bit 7 => War Trident - 0xb7
// $00AD67: [PAL][Bit Flags] @Byte24 in Bitset: Weapons_Unlocked
//          ---- Spear ----
//          bit 0 => Vapor - 0xb8
//          bit 1 => Blink - 0xb9
//          bit 2 => Flash Spike - 0xba
//          bit 3 => Thunder Pike - 0xbb
//          bit 4 => Divine Pike - 0xbc
//          bit 5 => Prodigal - 0xbd
//          
//          ---- War Spear ----
//          bit 6 => War Spear - 0xbe
//          bit 7 => Battle Spear - 0xbf
// $00AD68: [PAL][Bit Flags] @Byte25 in Bitset: Weapons_Unlocked
//          ---- War Spear ----
//          bit 0 => Horizon - 0xc0
//          bit 1 => Oblivion - 0xc1
//          bit 2 => Nether Realm - 0xc2
//          
//          ---- Twin Saber ----
//          bit 3 => Twin Sabers - 0xc3
//          bit 4 => Wing Sabers - 0xc4
//          bit 5 => Eagle - 0xc5
//          bit 6 => Falcon - 0xc6
//          bit 7 => Flash Blade - 0xc7
// $00AD69: [PAL][Bit Flags] @Byte26 in Bitset: Weapons_Unlocked
//          ---- Twin Saber ----
//          bit 0 => Raptor - 0xc8
//          
//          ---- Tonfa ----
//          bit 1 => Tonfa - 0xc9
//          bit 2 => Padded Tonfa - 0xca
//          bit 3 => Conqueror - 0xcb
//          bit 4 => Overlord - 0xcc
//          bit 5 => Hierophant - 0xcd
//          
//          ---- Mace ----
//          bit 6 => Mace - 0xce
//          bit 7 => Great Mace - 0xcf
// $00AD6A: [PAL][Bit Flags] @Byte27 in Bitset: Weapons_Unlocked
//          --- Mace ----
//          b-it 0 => Enchantress - 0xd0
//          bit 1 => Diva - 0xd1
//          bit 2 => Sorceress - 0xd2
//          bit 3 => Muse - 0xd3
//          
//          ---- Chakram ----
//          bit 4 => Chakram - 0xd4
//          bit 5 => Moon Chakram - 0xd5
//          bit 6 => Luna Chakram - 0xd6
//          bit 7 => Sol Chakram - 0xd7
// $00AD6B: [PAL][Bit Flags] @Byte28 in Bitset: Weapons_Unlocked
//          ---- Chakram ----
//          bit 0 => Wyrm Chakram - 0xd8
//          bit 1 => Star Chakram - 0xd9
//          
//          ---- Twin Rod ----
//          bit 2 => Twin Rods - 0xda
//          bit 3 => Spiral Rods - 0xdb
//          bit 4 => Wolf Slayer - 0xdc
//          bit 5 => Tiger Slayer - 0xdd
//          bit 6 => Demon Slayer - 0xde
//          
//          ---- Claw ----
//          bit 7 => Iron Claw - 0xdf
// $00AD6C: [PAL][Bit Flags] @Byte29 in Bitset: Weapons_Unlocked
//          ---- Claw ----
//          bit 0 => Falcon Claw - 0xe0
//          bit 1 => Phoenix Claw - 0xe1
//          bit 2 => Phoenix Tail - 0xe2
//          bit 3 => Phoenix Eye - 0xe3
//          bit 4 => Peacock Tail - 0xe4
//          bit 5 => Goddes Eye - 0xe5
// $00AFB4: [PAL][32-bit Timer] Seconds Spent In Game (main save data)
//          - Starts counting when confirming character pick
//          - This timer is saved to the main save file, loads in on startup
//          - Increases by 1 each 60 frames; each second (60fps)
//          - Max value = 0x57e3f = 99h 59m 59s
// $00AFF8: [PAL][8-bit] Difficulty
//          - Changes when pressing OK in game settings
//          0x0 => easy
//          0x1 => normal
//          0x2 => hard
// $00AFF9: [PAL][8-bit] Background Music (BGM) volume
//          - Value range [0x0-0xa]
// $00AFFA: [PAL][8-bit] Sound Effects (SE) volume
//          - Value range [0x0-0xa]
// $00AFFB: [PAL][8-bit] Language
//          00 = English
//          01 = French
//          02 = German
//          03 = Italian
//          04 = Spanish
// $00B16A: [NTSC-U][16-bit] Musou/Free Mode | Character Stat - Equipped Weapon
// $00B170: [PAL][112-bytes] Musou/Free Mode | Character Data
//          =================================================
//          - This data is contained in LinkedList_Node #2, but is always at this memory location (refer to notes @ 0xad1c)
//          
//          [PAL][16-bit] Musou/Free Mode | Overworld Character ID
//          - This value corresponds to the sprite seen on the overworld map
//          
//          # Overworld_Character_IDs (defers from list at $0xb175)
//          |'''''''''''''''''''''''''''
//          | - 0x0 => Xiahou Dun
//          | - 0x1 => Xu Zhu
//          | - 0x2 => Zhen Ji
//          | - 0x3 => Cao Cao
//          | - 0x4 => Sun Ce
//          | - 0x5 => Sun ShangXiang
//          | - 0x6 => Zhou Yu
//          | - 0x7 => Sun Jian
//          | - 0x8 => Zhao Yun
//          | - 0x9 => Guan Yu
//          | - 0xa => Zhang Fei
//          | - 0xb => Liu Bei
//          | - 0xc => Lu Bu
//          | - 0xe => Sun Quan (Unique NPC)
//          | - 0xf => Zhuge Liang (Unique NPC)
//          | - 0x10 => Dong Zhou (Unique NPC)
//          | - 0x11 => Yuan Shao (Unique NPC)
//          | - 0x12 => Zhang Jiao (Unique NPC)
//          | - [0x13-0x7f] => Generic Officers with name
//          | - [0x80-0x8b] => Soldiers
//          | - higher values => Crash
// $00B174: [PAL][8-bit] Same as 0x00b170
// $00B175: [PAL][16-bit] Musou/Free Mode | Battle Character ID
//          - This effectivly controls the character you are in-battle and also uses that character's attack moveset
//          - Some visual clutter is happening when using a weapon the character shouldn't be using
//          
//          # Battle_Character_IDs (defers from list at $0xb170)
//          |'''''''''''''''''''''''''''
//          | - 0x0 => Xiahou Dun
//          | - 0x1 => Sun Ce
//          | - 0x2 => Zhao Yun
//          | - 0x3 => Xu Zhu
//          | - 0x4 => Zhen Ji
//          | - 0x5 => Sun ShangXiang
//          | - 0x6 => Zhou Yu
//          | - 0x7 => Guan Yu
//          | - 0x8 => Zhang Fei
//          | - 0x9 => Lu Bu
//          | - 0xa => Cao Cao
//          | - 0xb => Sun Jian
//          | - 0xc => Liu Bei
//          | - 0xd => Sima Yi (Unique NPC, are actually playable, but have somewhat limited attack moveset)
//          | - 0xe => Sun Quan (Unique NPC)
//          | - 0xf => Zhuge Liang (Unique NPC)
//          | - 0x10 => Dong Zhuo (Unique NPC)
//          | - 0x11 => Yuan Shao (Unique NPC)
//          | - 0x12 => Zhang Jiao (Unique NPC)
//          | - 0x13 => Generic Officer sword (all of these and the soldiers are fully playable)
//          | - 0x14 => Generic Officer spear
//          | - 0x15 => Swordsman
//          | - 0x16 => Spearman
//          | - 0x17 => Bowman
//          | - 0x18 => Unarmed soldier
//          | - higher values => crash
// $00B17E: [PAL][16-bit] Musou/Free Mode | Character Stat - Equipped Weapon
// $00B180: [PAL][16-bit] Musou/Free Mode | Character Stat - Health
// $00B182: [PAL][16-bit] Musou/Free Mode | Character Stat - Max Health
// $00B184: [PAL][16-bit] Musou/Free Mode | Character Stat - Musou Gauge
// $00B186: [PAL][16-bit] Musou/Free Mode | Character Stat - Max Musou Gauge
// $00B188: [PAL][16-bit] Musou/Free Mode | Character Stat - Attack (damage)
// $00B18A: [PAL][16-bit] Musou/Free Mode | Character Stat - Defense
// $00B18C: [PAL][16-bit] Musou/Free Mode | Character Stat - Movement (speed)
// $00B1A8: [PAL][16-bit] Musou/Free Mode | Character Stat - Weapon Skill 1
//          - Value range for all weapon skills => [0x0-0x64] = [0-100]
// $00B1AA: [PAL][16-bit] Musou/Free Mode | Character Stat - Weapon Skill 2
// $00B1AC: [PAL][16-bit] Musou/Free Mode | Character Stat - Weapon Skill 3
// $00B1C0: [PAL][16-bit] Musou/Free Mode | Character Stat - Total KO Count
// $00B1C4: [PAL][16-bit] Musou/Free Mode | Character Stat - In-Battle KO Count
// $00B1C9: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Gauge: Highlighted Ability
//          - When the ability gauge is filled => this value increases by 1
//          - Value range [0-5] => value wraps back around to 0 when increasing past 5
//          - Value 0xff => No highlighted ability (= inactive)
//          - Player can activate highlighted ability to power it up one level => on activate this will become 0xff
//          
//          # Ability Gauge States
//          |''''''''''''''''''
//          | - 0xff => inactive (nothing highlighted)
//          | - 0x0 => ability 1 highlighted (clockwise, starting from top)
//          | - 0x1 => ability 2
//          | - ...
//          | - 0x5 => ability 6
// $00B1CA: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Gauge: Fill Rate
//          - Each enemy slain increases this value by 1
//          - Each hit on silver soldier increases this value by 1
//          - Value range [0-5], when it hits 5 => value resets to 0 AND the first ability becomes highlighted
//          - When all abilities are maxed, this will remain at 0, until an ability loses a level
// $00B1CB: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Valor (Orange Sword)
//          - Each ability can only level up 2 times
// $00B1CC: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Speed (Lightblue foot)
// $00B1CD: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Storm (Pink)
// $00B1CE: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Chain (Darkblue)
// $00B1CF: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Stun (Yellow)
// $00B1D0: [PAL][8-bit] Musou/Free Mode | Character Stat - Ability Level: Reach (Green)
// $00C0DC: [PAL][32-bit] Musuo/Free Mode | Stage ID
//          - This ID determines which Overworld_Stage_Data is loaded when a new stage is loaded (refer to $0x8560)
//          - The first 24-bit of this 32-bit value => correlates to the stage
//          - The last 8-bit of this 32-bit value => is equal to the Overworld_Character_ID of the selected player character/officer (refer to $0xb170)
//          
//          # Stage_IDs (list incomplete)
//          | [Stage ID] => [Stage Name] | [Allegiance] | [Overworld_Character_ID]
//          |'''''''''''''''''''''''
//          | - 0x31000002 => Yellow Turban Rebellion | Wei Forces | Zhen Ji
//          |
//          | - 0x31070109 => Hu Lao Gate | Shu Forces | Guan Yu
//          | - 0x31070108 => Hu Lao Gate | Shu Forces | Zhao Yun
//          |
//          | - 0x310e0409 => Chang Ban | Shu Forces | Guan Yu
//          | - 0x310e0408 => Chang Ban | Shu Forces | Zhao Yun
//          |
//          | - 0x31230905 => Xia Kou | Sun Forces | Sun ShangXiang
// $00C118: [PAL][16-bit] Musou/Free Mode | Allied Force Morale
//          - Corresponds with UI in top right when in overworld map
//          - Also counts for player character's morale
//          - Formula: allied force morale % =  alliedMorale / (alliedMorale + enemyMorale)
// $00C11A: [PAL][16-bit] Musou/Free Mode | Enemy Force Morale
//          - Formula: enemy force morale % =  enemyMorale / (alliedMorale + enemyMorale)
// $00D3F8: [PAL][32-bit] Musou/Free Mode | In-battle Player Character Location x-Axis
// $00D3FC: [PAL][32-bit] Musou/Free Mode | In-battle Player Character Location y-Axis
// $00D404: [PAL][24-bit Pointer] --> Musou/Free Mode | In-Battle Timer
//          - Identical pointer at $0x8360
//          +0x11278 - [32-bit] In-Battle Timer (UI control)
//          +0x1127C - [32-bit] In-Battle Timer (functional timer)
// $00D938: [PAL][32-bit] Battle Result State
//          - Based on how long the battle takes
//          - When in-battle countdown timer hits 0 once => 0x1 + countdown timer resets
//          - When in-battle countdown timer hits 0 2nd time => 0x2, countdown timer stays at 0
//          - Retreat and Slain (player character dies) is not counted as a Battle Result Type
//          
//          Battle Result States
//          '''''''''''''''''
//          - 0x0 => Triumph - timer is grey => player earns extra move on overworld map + restores some hp
//          - 0x1 => Victory - timer is orange
//          - 0x2 => Close Call - timer is grey + is stopped at 0 => player will skip his next turn on overworld map
//          - 0x3 => Search - timer is green
//          - 0x4 => Whilst on overworld map
// $00D93C: [PAL][32-bit] Battle Results State
//          - Copy of 0xd938
//          - 0x0 => Whilst on overworld map
// $00DCA8: [PAL][24-bit Pointer] --> Midway node into linked list (refer to notes @ 0xad1c)
//          +0x7FF8 - [24-bit Pointer]
//          .+0x8000 - Node containing In-battle Enemy Data
// $00DD0A: [PAL][16-bit]Copy of 0xb180, when in Musou/Free Mode
//          - This is a constant value, not changeable
// $00DD14: [PAL][24-bit Pointer] Musou/Free Mode | In-battle Data
//          
//          +0x8158 - [8-bit] In-battle - KO Count
//          | - Each kill increases this value by 1
//          
//          +0x8159 - [8-bit] In-battle - Required KO Count
//          | - The amount of enemies to kill in the current battle
// $00EA7C: [PAL][Linked List] Node #5
//          - This the last node which has a stable memory location, thus can be used as the start of an 'Add Address' chain in achievement logic
// $0157DC: [PAL][8-bit] Main Menu Navigation - Highlighted Button
//          - This value is only viable during the title screen menu's
//          - Value range [0x0 - amountOfButtons-1]
// $0157F1: [PAL][8-bit] Encyclopedia - Selected officer
//          - Same IDs as noted @ 0xb170
// $01580C: [PAL][8-bit] Selected Challenge Mode
//          0x2 => Endurance
//          0x4 => Time Attack
//          0x5 => Battle Luck
// $01746C: [PAL][8-bit] Challenge Mode - Frame Counter
//          - Value range [0x0-0x3c], increases by 1 each frame
// $01F6D4: [PAL][8-bit] Musou/Free Mode - Frame Counter
//          - Value range [0x0-0x3c], increases by 1 each frame
//          - 0x3c + 1 => resets this value back to 0 AND 0xafb4 increases by 1
//          - Stops during loading AND when a battle is over, keeps running in the start menu
//          - Possible lag at the start of a cutscene dialogue on the overworld map
// $023054: [PAL][24-bit Pointer] Challenge Mode | Battle Luck Data
//          
//          +0x78a0 - [PAL][8-bit] Battle Luck - Stage KO Count
//          | - This value resets to 0 on a new stage
//          
//          +0x78a1 - [PAL][8-bit] Battle Luck - Required Stage KO Count
//          | - Stage 1 => 10
//          | - Stage 2 => 10
//          | - Stage 3 => 15
//          | - Stage 4 => 15
//          | - Stage 5 => 20
//          | - Stage 6 => 25
// $02308C: [PAL][32-bit] Challenge Mode Timer
//          - This is an internal timer, that does not correlate to the UI, refer to notes @ 0x23090
// $023090: [PAL][32-bit] Challenge Mode Timer
//          - Timer copies timer @ 0x2308c
//          - This value controls the UI timer in the top right
//          - This timer is only visible in 'Battle Luck' and in 'Time Attack' modes, timer is functional in 'Endurance' as well
// $023098: [PAL][16-bit] Challenge Mode | Battle Luck - Current Stage
//          - Value Range [0x0-0x6], increase by 1 when moving on to next stage, decreases by 1 when retreating to previous stage
//          - Hitting 0x6 => All stages complete
// $0230AA: [PAL][Bit Flag] Challenge Mode | Battle Luck
//          bit 3 => is last stage complete
