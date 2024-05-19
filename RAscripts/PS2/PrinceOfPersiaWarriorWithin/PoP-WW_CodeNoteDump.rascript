// Prince of Persia: Warrior Within
// #ID = 3319

// $093390: [NTSC-U][PAL][NTSC-J][11-byte ASCII] Game Region Identification - PS2 Product ID
//          - USA => SLUS_210.22
//          - EUR => SLES_528.22
//          - JPN => SLPM_660.02
// $637FC8: [PAL][32-bit] Video End Marker
//          - Last frame of the video
//          - When +0x4 [32-bit] == this value --> video end
//          - Can also be used to ID video's (although not the image video's, refer to list below and $0x637fe8)
//          - A more intuitive method to ID video's is documented at $0x830ac8
//          
//          # VideoEndMark_IDs (list incomplete)
//          | ''''''''''''''''''''''
//          | 0xb0 => Game Over
//          | 0xca2 => Prince talks with old man
//          | 0x...
// $637FCC: [PAL](32-bit] Video Playhead Position Indicator
//          - Directly controls video playback
// $637FE8: [PAL][32-bit] Video/Image ID
//          - All video's are BIK video files which are controlled here. (images, as well as the map screen are also BIK video files)
//          - Can be used to track story progression, as some video's unlock when viewing them for the first time through story.
//          - Extra Features Gallery images are 2 frame video's that play on loop.
//          - Map is also a video, for each unlockable region there's a unique video file, these files don't loop, but stay on hold at end marker
//          - Loading screen consists of various video files
//          - A more intuitive method to ID video's is documented at $0x830ac8
//          
//          # Video_IDs (list incomplete)
//          |'''''''''''''''''
//          | - 0x1ad44 => Character - Crow
//          | - 0x056fc304 => Video 2 - Intro + Ship Battle
//          | - 0x34384c0 => Video 3 - Prince talks with old man
//          | - 0xac87fc => Video 4 - Prince chases after Shahdee through time portal
//          | - 0x4d331b4 => Credits 1 - There might be multiple credits video's depending on ending achieved
//          | - 0x15894c => Game Over (1 continuous video, unlike the loading screen, which comprises multiple chained videos)
//          | - 0x...
// $6388C8: [32 Bit] Movie Lenght ID
//          Jumps a lot when not in cutscene, should be coupled with another flag for consistency
//          0xcc > Loading screen
// $6388CC: [32 Bit] Current Movie Playtime
//          When match with 0x006388c8 then movie end
// $6388E0: [32 Bit] Consistent "Movie is being played" value
//          0x00204000 > Movie is playing
// $6388E8: [32 Bit] Proper MovieID
//          0x00137580 == Game Over
// $7B7CC0: [PAL][32-bit Pointer] Game_Controller_Object (Possibly)
//          +0x18 - [32-bit Pointer{2}]
//          .+0x4 - [32-bit Pointer{3}]
//          ..+0x48 - [32-bit Pointer{4}] --(+0x0)--> [5872-byte Struct] Prince_Data
//          ..| - Struct Definition [Prince_Data] at $0x1365650
// $7B9234: [PAL][32-bit Pointer{1}] --> Time Period State
//          +0x18 - [32-bit Pointer{2}]
//          .+0x4 - [32-bit Pointer{3}]
//          ..+0x48 - [32-bit Pointer{4}] --(+0x0)--> [8-bit {32-bit}] Time Period State
//          ..| - Documentation at $0xcb7480
// $7BAFD4: [PAL][32-bit Pointer{1}] --> Game_Data
//          +0x18 - [32-bit Pointer{2}]
//          .+0x4 - [32-bit Pointer{3}]
//          ..+0x48 - [32-bit Pointer{4}] --(+0x0)--> [4432-byte Struct] Game_Data
//          ..| Struct definition [Game_Data] at $0x1366d40
// $7BB980: Objective ID?
// $7BBA8C: [PAL][8-bit {32-bit}] Objective ID
//          - Changing this value to a valid ID and then opening the map will update the objective on the map
//          - Can be used to track story progression
//          - This value changes close to whenever the text "Objective updated on map" is displayed.
//          
//          # Objective_IDs (list complete)
//          |'''''''''''''''''
//          | 0x1 => Reach the fortress entrance (Present)
//          | 0x3 => Chase the girl in black (Past)
//          | 0x9 => Reach the hourglass chamber (Past)
//          | 0xb => Gain access to the tower (Past)
//          | 0xc => Activate the towers (Past)
//          | 0xe => Activate the second tower (Past)
//          | 0x11 => Return to the hourglass chamber (Past)
//          | 0x13 => Leave the island (Present)
//          | 0x16 => Return to the throne room (Past)
//          | 0x17 => Find the mask (Present)
//          | 0x18 => Return to the access hall (Past)
//          | 0x19 => Find a way to the throne room (Past)
//          | 0x1D => Find empress Kaileena (Present)
// $7BBC88: [PAL][Bit Flag {32-bit}] bit 0 => Is Map Displayed
// $7BBCB0: (unverified) - Might be unstable
//          [PAL][Bit Flag {32-bit}] Is Game Over (alt 1)
//          - Identical to $0xcb7d0c
// $7BBD50: [PAL][32-bit] Display Language
//          0x0 => en
//          0x1 => fr
//          0x2 => es
//          0x3 => de
//          0x4 => it
//          0x5 => nl
// $7BBF40: [PAL][32-bit Pointer{1}] UI/HUD Controller/Renderer (alt)
//          - Similar functionality as $0x7bbf44, BUT this pointer chain is different, this might control different aspects of UI, this pointer chain might also connect to that other pointer chain somehow
// $7BBF44: [PAL][32-bit Pointer{1}] UI/HUD Controller/Renderer (Preferred)
//          - Pointer{2} or Pointer{3} might only be functional after the intro sequence (the ship battle), Pointer chain should be fully functional when Prince wakes up on the beach
//          - This might only manage/render the HUD in the top-left (HP, sand charges, 2nd weapon), and not the subtitles/tutorial messages
//          - The HUD consists of about 44 different images/icons which are manipulated to fit the design.
//          
//          +0x0 - [32-bit Pointer{2}]
//          .+0x14 - [32-bit Pointer{3}]
//          .| +0x34 - [176-byte?? Array] List of Pointers{4} --> [80-byte] HUD_Element_Object
//          .| { [Struct Definition][80-byte] HUD_Element_Object
//          .| |''''''''''''''''''''''''
//          .| | +0x10 - [Float] Image X Coordinate
//          .| | +0x14 - [Float] Image Y Coordinate
//          .| | +0x18 - [Float] Image Width
//          .| | +0x1c - [Float] Image Height
//          .| | +0x44 - [8-bit] Image/Icon ID (ID list see below)
//          .|
//          .| +0xDC - [32-bit Pointer{4}] --> [HUD_Element_Object] Secondary Weapon Icon
//          .| | - This is the second-to-last pointer in the list mentioned above
//          .| | - It's responsible for secondary weapon icon, +0x44 can be used to ID which type of secondary weapon is equipped (refer to struct definition HUD_Element_Object)
//          
//          # Image/Icon IDs
//          |''''''''''''''''
//          | - 0x0 => blue circle half (might be stretched/cropped UI design when being healed/HP going up)
//          | - ...misc UI elements...
//          | - 0x29,0x2a => sword (2nd value => higher contrasted image, is temporarily used when picking up or throwing the weapon)
//          | - 0x2b,0x2c => dagger
//          | - 0x2d,0x2e => mace
//          | - 0x2f,0x30 => axe
//          | - ...misc UI elements...
//          | - 0x36 => half moon (last entry)
// $7BC3D8: [PAL][32-bit] Frame Progression Register || Frame Counter/Timer (Preferred)
//          - Increments by 1, each frame
//          - Overflowable value (wraps around back to 0)
//          - Valid frame counter at all times (in-game, menu's, title screen, video's, artwork gallery, boot-up...)
//          - Freezing this address halts all frame updates
// $7BC3DC: [PAL][32-bit] Frame Counter/Timer (alt)
//          - Identical to $0x7bc3d8, BUT increments by 2, each 2 frames
// $7BC9F8: Pin map objective
// $7BD0C0: [32 Bit] Menu ID
// $7BD140: [32 Bit] Cutscene flag
//          Both Movie and In-engine
//          00 > Not Cutscene
//          01 > Cutscene
// $7DDA40: [PAL][16-byte Bitset] Extra_Feature_Unlocks
//          @Regional equivalent of Bitset $0x7de440 (USA)
//          ▪ Character bit flags - are unordered, unlocked by opening chests
//          ▪ Environment bit flags - are ordered, unlocked by opening chests
//          ▪ Illustrations gallery - only consists of 1 bit flag, it unlocks after collecting all 9 life upgrades and the special item that they unlock in the Hourglass Room, then win the game and save (= secret ending)
//          ▪ Video bit flags - are somewhat ordered, unlocked by progressing the story (Video 8 is unlocked through secret ending??); Video's [1,9,10,11,12] - are unlocked by default (these have no corresponding bit flags)
//          ▪ Weapon bit flags - are somewhat ordered/grouped, unlocked by picking up the corresponding weapon
//          
//          [PAL][Bit Flags] @Byte1 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Characters ----
//          bit 0 => Crow
//          bit 1 => Sand Wraith
//          bit 2 => Raiders
//          bit 3 => Old man
//          bit 4 => Kaileena
//          bit 5 => Bladedancer
//          bit 6 => Shahdee
//          bit 7 => Crow Master
// $7DDA41: [PAL][Bit Flags] @Byte2 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Characters ----
//          bit 0 => Silhouette
//          bit 1 => Shadow
//          bit 2 => Brute
//          bit 3 => Keeper
//          bit 4 => Spike Beast
//          bit 5 => Dahaka
//          bit 6 => Thrall
//          bit 7 => Executioner
// $7DDA42: [PAL][Bit Flags] @Byte3 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Characters ----
//          bit 0 => Assassin
//          bit 1 => Imperial Guard
//          bit 2 => Griffon
//          bit 3 => Scavenger
//          ---- Environments ----
//          bit 4 => Ship
//          bit 5 => Beach Wreckage
//          bit 6 => Cliff Passage
//          bit 7 => Time Travel Area (Present)
// $7DDA43: [PAL][Bit Flags] @Byte4 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Environments ----
//          Documentation at $0x7de443
// $7DDA44: [PAL][Bit Flags] @Byte5 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Environments ----
//          Documentation at $0x7de444
// $7DDA45: [PAL][Bit Flags] @Byte6 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Environments ----
//          Documentation at $0x7de445
// $7DDA46: [PAL][Bit Flags] @Byte7 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Environments + Video's ----
//          Documentation at $0x7de446
// $7DDA47: [PAL][Bit Flags] @Byte8 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          ---- Video's + Illustrations ----
//          bit 0 => Video 3
//          bit 1 => Video 4
//          bit 2 => Video 5
//          bit 3 => Video 6
//          bit 4 => Video 7 + 14 + 15
//          bit 5 => Video 8 + entire Illustrations Gallery (15 illustrations)
// $7DDA48: [PAL][Bit Flags]
//          @Byte9 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte1 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Axes ----
//          bit 1 => Allatum (0x0) <-- Secondary_Weapon_ID (refer to $0x13669a8)
//          bit 2 => Ahura (0x1)
//          bit 3 => Mainyu (0x2)
//          bit 4 => Vidatu (0x3)
//          bit 5 => Bahram (0x4)
//          bit 6 => Airyaman (0x5)
//          bit 7 => Ereta (0x6)
// $7DDA49: [PAL][Bit Flags]
//          @Byte10 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte2 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Axes ----
//          bit 0 => Vahishta (0x7)
//          bit 1 => Ahura (0x8)
//          bit 2 => Spentas (0x9)
//          bit 3 => Apam (0xA)
//          bit 4 => Natat (0xB)
//          bit 5 => Apaosa (0xC)
//          ---- Daggers ----
//          bit 6 => Vahishta (0xD)
//          bit 7 => Armaiti (0xE)
// $7DDA4A: [PAL][Bit Flags]
//          @Byte11 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte3 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Daggers ----
//          bit 0 => Abathur (0xF)
//          bit 1 => Indra (0x10)
//          bit 2 => Khara (0x11)
//          bit 3 => Yazata (0x12)
//          ---- Maces ----
//          bit 4 => Vata (0x13)
//          bit 5 => Izha (0x14)
//          bit 6 => Zenda (0x15)
//          bit 7 => Menog (0x16)
// $7DDA4B: [PAL][Bit Flags]
//          @Byte12 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte4 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Maces ----
//          bit 0 => Sraosa (0x17)
//          bit 1 => Yima (0x18)
//          bit 2 => Peris (0x19)
//          bit 3 => Baga (0x1A)
//          ---- Misc ----
//          bit 4 => Hockey Stick (0x1B)
//          bit 5 => Teddy Bear (0x1C)
//          bit 6 => Flamingo (0x1D)
//          bit 7 => Light Sword (0x1E)
// $7DDA4C: [PAL][Bit Flags]
//          @Byte13 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte5 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Swords ----
//          bit 0 => Mahre (0x1F)
//          bit 1 => Srosh (0x20)
//          bit 2 => Vanant (0x21)
//          bit 3 => Yasht (0x22)
//          bit 4 => Dena (0x23)
//          bit 5 => Kerena (0x24)
//          bit 6 => Asto (0x25)
//          bit 7 => Agas (0x26)
// $7DDA4D: [PAL][Bit Flags]
//          @Byte14 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte6 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Swords ----
//          bit 0 => Tasan (0x27)
//          bit 1 => Haoma (0x28)
//          bit 2 => Rustam (0x29)
//          bit 3 => Spenta (0x2A)
//          bit 4 => Mainyu (0x2B)
//          bit 5 => Zarich (0x2C)
//          bit 6 => Camros (0x2D)
//          bit 7 => Buyasta (0x2E)
// $7DDA4E: [PAL][Bit Flags]
//          @Byte15 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte7 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Mixed ----
//          bit 0 => Swords - Asman (0x2F)
//          bit 1 => Axes - Drvaspa (0x30)
//          bit 2 => Swords - Fravashis (0x31)
//          bit 3 => Misc - White Glove (0x32)
//          bits [4-5] => /
//          ---- Main Weapons ----
//          bit 6 => Eagle Sword
//          bit 7 => Wooden Stick
// $7DDA4F: [PAL][Bit Flags]
//          @Byte16 in Bitset: Extra_Feature_Unlocks $0x7dda40
//          @Byte8 in (sub)Bitset: Weapon_Gallery_Unlocks $0x7dda48
//          ---- Main Weapons ----
//          bit 0 => Spider Sword
//          bit 1 => Serpent Sword
//          bit 2 => Lion Sword
//          bit 3 => /
//          bit 4 => Scorpion Sword
//          bit 5 => Water Sword
// $7DE440: [8 Bit] Artwork Bitflags -- Characters
//          Not in order so doing Line / Column numeration
//          Bit 0 | L1 C1
//          Bit 1 | L4 C4
//          Bit 2 | L1 C2
//          Bit 3 | L4 C1
//          Bit 4 | L4 C3
//          Bit 5 | L1 C4
//          Bit 6 | L4 C2
//          Bit 7 | L1 C5
// $7DE441: [8 Bit] Artwork Bitflags -- Characters
//          Not in order so doing Line / Column numeration
//          Bit 0 | L1 C3
//          Bit 1 | L2 C1
//          Bit 2 | L2 C4
//          Bit 3 | L2 C2
//          Bit 4 | L2 C3
//          Bit 5 | L4 C5
//          Bit 6 | L3 C4
//          Bit 7 | L3 C2
// $7DE442: [8 Bit] Artwork Bitflags -- Mixed
//          Not in order so doing Line / Column numeration
//          Bit 0 | L3 C3 -- Characters
//          Bit 1 | L2 C5 -- Characters
//          Bit 2 | L3 C5 -- Characters
//          Bit 3 | L3 C1 -- Characters
//          Bit 4 | Environments 1
//          Bit 5 | Environments 2
//          Bit 6 | Environments 3
//          Bit 7 | Environments 4
// $7DE443: [8 Bit] Artwork Bitflags -- Environments
//          Bit 0 | Environments 5
//          Bit 1 | Environments 6
//          Bit 2 | Environments 7
//          Bit 3 | Environments 8
//          Bit 4 | Environments 9
//          Bit 5 | Environments 10
//          Bit 6 | Environments 11
//          Bit 7 | Environments 12
// $7DE444: [8 Bit] Artwork Bitflags -- Environments
//          Bit 0 | Environments 13
//          Bit 1 | Environments 14
//          Bit 2 | Environments 15
//          Bit 3 | Environments 16
//          Bit 4 | Environments 17
//          Bit 5 | Environments 18
//          Bit 6 | Environments 19
//          Bit 7 | Environments 20
// $7DE445: [8 Bit] Artwork Bitflags -- Environments
//          Bit 0 | Environments 21
//          Bit 1 | Environments 22
//          Bit 2 | Environments 23
//          Bit 3 | Environments 24
//          Bit 4 | Environments 25
//          Bit 5 | Environments 26
//          Bit 6 | Environments 27
//          Bit 7 | Environments 28
// $7DE446: [8 Bit] Artwork Bitflags -- Environments -- Video Gallery
//          Bit 0 | Environments 30
//          Bit 1 | Environments 29
//          Bit 2 |
//          Bit 3 |
//          Bit 4 |
//          Bit 5 |
//          Bit 6 |
//          Bit 7 | Video 2
// $7DE447: [8 Bit] Video Gallery -- Artwork Bitflags
//          Bit 0 | Video 3
//          Bit 1 | Video 4
//          Bit 2 | Video 5
//          Bit 3 | Video 6
//          Bit 4 | Video 7
//          Bit 5 | All Illustrations Unlocked (all or nothing) AND Video 8
//          Bit 6 |
//          Bit 7 |
// $7DE448: [8 Bit] Weapon Gallery
//          Bit 0 |
//          Bit 1 | Axes - Allatum
//          Bit 2 | Axes - Ahura
//          Bit 3 | Axes - Mainyu
//          Bit 4 | Axes - Vidatu
//          Bit 5 | Axes - Bahram
//          Bit 6 | Axes - Airyaman
//          Bit 7 | Axes - Ereta
// $7DE449: [8 Bit] Weapon Gallery
//          Bit 0 | Axes - Vahishta
//          Bit 1 | Axes - Ahura
//          Bit 2 | Axes - Spentas
//          Bit 3 | Axes - Apam
//          Bit 4 | Axes - Natat
//          Bit 5 | Axes - Apaosa
//          Bit 6 | Daggers - Vahishta
//          Bit 7 | Daggers - Armaiti
// $7DE44A: [8 Bit] Weapon Gallery
//          Bit 0 | Daggers - Abathur
//          Bit 1 | Daggers - Indra
//          Bit 2 | Daggers - Khara
//          Bit 3 | Daggers - Yazata
//          Bit 4 | Maces - Vata
//          Bit 5 | Maces - Izha
//          Bit 6 | Maces - Zend
//          Bit 7 | Maces - Menog
// $7DE44B: [8 Bit] Weapon Gallery
//          Bit 0 | Maces - Sraosa
//          Bit 1 | Maces - Yima
//          Bit 2 | Maces - Peris
//          Bit 3 | Maces - Baga
//          Bit 4 | Misc - Hockey Stick
//          Bit 5 | Misc - Teddy Bear
//          Bit 6 | Misc - Flamingo
//          Bit 7 | Misc - Light Sword
// $7DE44C: [8 Bit] Weapon Gallery
//          Bit 0 | Swords - Mahre
//          Bit 1 | Swords - Srosh
//          Bit 2 | Swords - Vanant
//          Bit 3 | Swords - Yasht
//          Bit 4 | Swords - Dena
//          Bit 5 | Swords - Kerena
//          Bit 6 | Swords - Asto
//          Bit 7 | Swords - Agas
// $7DE44D: [8 Bit] Weapon Gallery
//          Bit 0 | Swords - Tasan
//          Bit 1 | Swords -  Haoma
//          Bit 2 | Swords - Rustam
//          Bit 3 | Swords - Spenta
//          Bit 4 | Swords - Mainyu
//          Bit 5 | Swords - Zarich
//          Bit 6 | Swords - Camros
//          Bit 7 | Swords - Buyasta
// $7DE44E: [8 Bit] Weapon Gallery
//          Bit 0 | Swords - Asman
//          Bit 1 | Axes - Drvaspa
//          Bit 2 | Swords - Fravashis
//          Bit 3 | Misc - White Glove
//          Bit 4 |
//          Bit 5 |
//          Bit 6 | Main Weapons - Eagle Sword
//          Bit 7 | Main Weapons - Wooden Stick
// $7DE44F: [8 Bit] Weapon Gallery
//          Bit 0 | Main Weapons - Spider Sword
//          Bit 1 | Main Weapons - Serpent Sword
//          Bit 2 | Main Weapons - Lion Sword
//          Bit 3 |
//          Bit 4 | Main Weapons - Scorpion Sword
//          Bit 5 | Main Weapons - Water Sword
//          Bit 6 |
//          Bit 7 |
// $7E4954: [PAL][32-bit Pointer{1}]  Misc Frame Counters
//          +0x4954 - [32-bit Pointer{2}]
//          | +0x498 - [32-bit] Misc Frame Counter A
//          | | - Increments by 1, each 2 frames
//          | | - Freezing this value halts enemies and the Prince repeats the action he was doing before freeze
//          |
//          | +0x49c - [32-bit] Misc Frame Counter B
//          | | - Value is identical to frame counter above/before
//          | | - Increments by 1, each 2 frames
//          | | - Freezing this value halts Prince movement, but can still attack and interact with surroundings
//          |
//          | +0x4a0 - [32-bit] Misc Frame Counter C
//          | | - Increments by 3, each 2 frames
//          | | - Freezing this value seems to do nothing
// $7EBD88: [PAL][Variable Size ASCII] Video File Name ID (alt 2)
//          - Identical to $0x830ac8
// $7FF93C: [32 Bit] Health pointer
//          +0x1de Actual Health
// $82B96C: [PAL][32-bit Flag] Is Top-Left HUD hidden
//          0x0 => is displayed (displays when weapons unsheathed OR taking damage)
//          0x1 => is hidden/not displayed (becomes hidden after a 3-5 secs weapons sheathed)
// $830AC8: [PAL][Variable Size ASCII] Video File Name ID (alt 1)
//          - Preceding [8-bytes ASCII] = "\VIDPAL\"
//          - Size of ASCII is dependent on name of Video File
//          - ASCII changes when a new video file starts playing (all video files can be viewed in the iso file of the game)
//          
//          # VideoFileName_IDs (list incomplete)
//          |''''''''''''''''''''''
//          | - "CINE\CINE0100.BIK" => Intro; Prince running from shadow + Ship battle boarding
//          | - "CINE\CINE0101.BIK" => Intro Ship Battle; Enemy ship rams into Prince ship
//          | - ...
// $84A438: [PAL][Bit Flag {32-bit}] Is Any Menu Displayed
//          bit 0 = 0 => during gameplay + when map is displayed
//          bit 0 = 1 => Any menu is displayed (In-game menu's: options, combo list, game over... Title screen menu's: load game, extra features...)
// $A660A0: [PAL][32-bit] Sands of Time (SoT) Power Duration
//          - Value range [0x0-0x6acfc0]
//          - Current Time Power stops once this value hits 0
//          - Recharges back to max when not using Time Powers
// $A660B8: [PAL][8-bit Bit Field {32-bit}] Pause State
//          0x0 => During intro ship battle, during gameplay and also when in menu's
//          0x1 => During gameplay (past intro sequence)
//          0x6 => Pause menu, map or save menu is displayed
// $B258D4: [PAL][8-bit {32-bit}] Menu/Sub-menu Depth (alt)
// $B258DC: [PAL][8-bit {32-bit}] Menu/Sub-menu Depth (Preferred)
//          = 0x0 => no menu displayed
//          = 0x1 => menu_0
//          > 0x0 => depth of the displayed menu
// $B6C410: List of game objects??
// $B702D0: List of pointers to 3d Models
// $B71280: Identical list as 0x00b702d0
// $B74874: list of pointers? to stuff??
// $B9F4D0: [PAL][4-byte Struct:Area_ID] Checkpoint SubArea ID
//          - Struct Definition [Area_ID] at $0xb9f57c
//          - Needs to be combined with $0xb9f598 to ID the effective checkpoint
//          - Checkpoint IDs listed at $0xb9f598
// $B9F4F4: [PAL][32-bit] Farthest Progressed Area ID In Playthrough
// $B9F57C: [PAL][4-byte Struct:Area_ID] Area ID (preferred)
//          - This IDs the current loaded area the player is in
//          
//          { [Struct Definition][4-byte] Area_ID
//          |''''''''''''''''''''''''''''''''
//          | - Changes on specific transition area's
//          | - The first 24-bit of this 32-bit value corresponds to a MainArea
//          | - The last 8-bit of this 32-bit value corresponds to a SubArea
//          |
//          | +0x0 - [8-bit] SubArea ID
//          | +0x1 - [24-bit] MainArea ID
//          
//          # Area_IDs (list incomplete)
//          |'''''''''''''''
//          | 0x2b0828 (MainArea ID) => Present - Beach
//          | + 0x03 (SubArea ID) => Beach wreckage
//          | + 0x04 => Beach cliff, leading up to fortress entrance
//          | + 0x05 => Past first gate and past first fight area
//          | + 0x06 => Past first gate during first fight area
//          | + 0x07 => Past first gate after second fight area, before grated gate, before entering 'fortress entrance' area
//          | 0x...
//          | 0x0812fe + 0xa8 => Present - Fortress Entrance - Corridor to Time Warp Chamber
//          | 0x11004a + 0xbf => Past & Present - Fortress Entrance - Time Warp Chamber
//          | 0x081302 + 0xd0 => Past - Fortress Entrance - Corridor to Time Warp Chamber
//          | 0x...
// $B9F584: [PAL][8-bit Bitfield] Settings - Camera
//          bit pair 1,0 => Slow Motion Cam (Frequency)
//          | = 00 => never
//          | = 01 (bit 1 = 0; bit 0 = 1) => seldom
//          | = 10 => normal
//          | = 11 => often
//          bit 2 = 0 => Free Look normal; bit 2 = 1 => Free Look inverted
//          bit 3 = 0 => Rotation normal; bit 3 = 1 => Rotation inverted
// $B9F594: [PAL][8-bit {32-bit}] Difficulty
//          - Only selectable at start of new game (manually changing difficulty is possible at runtime and will scale enemy stats when they spawn)
//          - Difficulty only scales enemy HP and Prince Max HP (visually feels like enemies do more damage)
//          0x0 => easy (EnemyHP x 1; PrinceMaxHP x 1 (= 150 at new game))
//          0x1 => normal (EnemyHP x 1.5; PrinceMaxHP x 0.66 (= 100 at new game))
//          0x2 => hard (EnemyHP x 2; PrinceMaxHP x 0.44 (= 66 at new game))
// $B9F598: [PAL][4-byte Struct:Area_ID] Checkpoint MainArea ID
//          - Struct Definition [Area_ID] at $0xb9f57c
//          - Needs to be combined with $0xb9f4d0 to ID the effective checkpoint (changing only this value and not the other, results in spawning out-of-bounds)
//          - This IDs the location where the player respawns when selecting retry from the Game Over menu or loading a a savefile
//          - Changing and freezing both MainArea_ID and SubArea_ID to valid IDs, as listed below, before activating a loading screen => will load/spawn the Prince at that location/checkpoint. This can be used to skip to whatever story section/area you want
//          - Checkpoint_IDs are similar to Area_IDs ($0xb9f57c), but have slightly different values
//          
//          # Checkpoint_IDs (list incomplete)
//          |''''''''''''''''''''''
//          | □ 0x4d07964b (Checkpoint_MainArea_ID) + 0x2b08277a (Checkpoint_SubArea_ID) => Present - Ship Battle
//          | □ 0x2b082803 (Checkpoint_MainArea_ID) => Present - Beach
//          | | + 0x2b082848 (Checkpoint_SubArea_ID) => Ship wreckage
//          | | + 0x33010fbb (Checkpoint_SubArea_ID) => 1st water fountain (save station) up the broken down walkway
//          | □ 0x2b082807 + 0x29015c1c => Present - Fortress Entrance: Gate before being ambushed by Shahdee at the fortress entrance
//          | □ 0x0812feb0 => Present - Fortress Entrance: Past gate
//          | | + 0x0813f21f => 1st water fountain past gate
//          | □ 0x0812feae + 0x0813f239 => Present - Fortress Entrance: Past 1st CrowMaster
//          | ...
//          | □ 0x11003189 + 0x3c029653 => Past - Sacrificial Altar: Water fountain before 2nd Shahdee boss fight
//          | ...
// $B9F5AC: [PAL][32-bit] Loaded Area ID (alt)
//          - Identical to $0xb9f57c
// $C5C3A0: [PAL][136-byte Array] List of PrimaryWeapon_Pointers
//          - There's only 7 primary weapons in-game, yet this list contains 17 entries.
//          - Can be used to ID current equipped main weapon (refer to $0x1366a50)
// $C6D7C4: [32 Bit] ASCII MapID Pointer
//          +0x210 [ASCII] MapID
//          Chain pointer looks like
// $C73ED0: [32 Bit] Ascii MapID
//          Pointed data 1
// $CB7480: [PAL][8-bit {32-bit}] Time Period State
//          @Fixed Memory Location. Although pointed to by $0x7b9234
//          0x0 => Present - During intro ship battle
//          0x1 => Present
//          0x7 => Past
// $CB7560: [PAL][Bit Flag {32-bit}] bit 0 => Is Game Over (alt 1)
// $CB765C: [PAL][Bit Flag {32-bit}] bit 0 => Is Game Over (alt 2)
//          - Identical to $0xcb7560, BUT changes a few frames later
// $CB783C: [PAL][Bit Flag {32-bit}] bit 0 => Is Secondary Weapon Equipped
// $CB7A88: [PAL][32-bit Flag] Is Weapons In-hand/Unsheathed
//          0x0 => weapons sheathed
//          0x1 => weapons unsheathed/in-hand
//          0xffffffff => during cutscenes
// $CB7D0C: [PAL][8-bit Bitfield {32-bit}] Game State
//          - Bitfield becomes operational once the title screen is displayed
//          0x0 => Player can control the Prince
//          0x1 => Video is playing (refer to $0x637fe8) _OR_ Title screen menu/in-game menu is displayed _OR_ in-engine cutscene is active (some short panning shots don't change this value to 0x1)
//          0x2 => Loading (loading video is being played)
//          
//          !! WARNING !! switches to 0x0 for a few frames on new game
// $CB7D10: [PAL][32-bit] Prince HP (Visual)
// $CB7D2C: [PAL][32-bit] Prince HP (Visual)
//          - Identical to $0xcb7d10
// $CB7D30: [PAL][32-bit] Prince Max HP (Visual)
//          - Functional value at $0x1366ae0
//          !! WARNING !! - On HP upgrade acquire this value changes to the new max HP value later then the functional value
// $CB7D54: [PAL][32-bit] Sands of Time (SoT) Charges (Visual)
//          - Controls the visual effect that is shown whilst using a charge
//          - Functional value at $0x13660e4
// $CB7D64: [PAL][Bit Flag {32-bit}] Is In-game (alt 1)
//          bit 0 = 0 => at title screen
//          bit 0 = 1 => in-game
// $CB7D6C: [PAL][Bitfield {32-bit}] Is In-game (alt 2)
//          0x0 => at title screen
//          0x3 => in-game
// $CB7D98: [PAL][32-bit Pointer] Secondary Weapon Durability (Functional)
//          - Identical to '[32-bit Pointer{2}] --> Secondary Weapon Durability' at $0x13669a8
// $CB7DD0: [PAL][32-bit] Secondary Weapon Durability (Visual)
//          - Functional value at $0x13669a8
//          - This value does not reset to 0x0, when weapon is thrown
// $CB80AC: Potential power flag
// $CB830C: [32 Bit] Secondary Weapon Equipped Flag
// $CB8334: [32 Bit] Tutorial Message Display
//          (Tentative)
//          0xffffffff when nothing appears
//          0x00 > Single Weapon tutorial, press square
//          0x01 > Single Weapon tutorial, Hold R1 to block
//          0x02 > Single Weapon tutorial, press square * 3
//          0x03 > Single Weapon tutorial, press triangle * 2
//          0x0e > Press circle to throw weapon
//          0x2f > Run Along Wall
//          0x0d > Press Circle to pick up weapon
// $EA9144: (unverified)
//          [PAL][32-bit] Spawned Number of Enemies
//          - Only counts enemies in the current loaded area
// $EA9480: [32 Bit] Current Health (before combo damage taken)
// $EA94A0: [32 Bit] Max Health
// $EA94C4: [32 Bit] Sand Charges (Display)
// $EA9508: [32 Bit] Secondary Weapon Equipped
//          0x00 > None
//          Issue with identifying weapon type, value here seems to be linked to the exact object ID and not a global "this is a mace / dagger / sword"
// $EA950C: [32 Bit] Display Boss Health
// $EA9540: [32 Bit] Secondary Weapon Durability
//          Break when reaching 0x00
// $EA958C: [32 Bit] Weapon Unsheathed flag
//          00 > Sheathed
//          01 > Unsheathed
// $10B11E8: [PAL][32-bit Pointer{1}] --> Enemy Data A2
//           
//           +0x1B4 - [8-bit {32-bit}] Number of Spawned/Alive Enemies
//           
//           +0x5C8 - [56-byte Array] List of EnemyDataA_Pointers
//           | - Similar list pointed to by $0x10b12a8, entries might be rearranged
// $10B12A8: [PAL][32-bit Pointer] Enemy Data A
//           - Each enemy has a unique EnemyDataA_Pointer
//           - Pointer values are different from pointers at Enemy Data B ($0x10b1fa8), BUT some enemy types end up pointing/referencing the same enemyData, more info below
//           
//           +0x118C - [56-byte Array] List of EnemyDataA_Pointer{2} - Spawned
//           | - Lists EnemyDataA_Pointers of enemies which are in the current area AND are spawned
//           | - Some area's indicate to have extra enemies outside of playable area?? Possibly out-of-bounds??
//           
//           +0x11E4 - [56-byte Array] List of EnemyDataA_Pointer{2}
//           | - Identical to above list, but entries might be rearranged
//           
//           { [Struct Definition][32-bit] EnemyDataA_Pointer{2}
//           |'''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x18 - [32-bit Pointer {3}]
//           | .+0x4 - [32-bit Pointer {4}]
//           | .| +0x5C - [32-bit] Enemy Type ID (IDs listed below)
//           | .| +0x48 - [32-bit Pointer {5}]
//           | .| | +0x0 - [Variable Size] EnemyDataA_Object OR EnemyDataB_Object
//           
//           { [Struct Definition][32-bit] EnemyDataA_Object (By Enemy Type)
//           |'''''''''''''''''''''''''''''''''''''''''''''''
//           | - Only documented difference compared to EnemyDataB_Object is the Crows data
//           |
//           | | ---- Crow ----
//           | | - Crow logic is stored via EnemyDataA_Pointer chain NOT EnemyDataB_Pointer chain
//           | | +0x18 - [32-bit {Bit Flag}] bit 0 => Is Attack Animation Active
//           | | +0x1C - [32-bit {Bit Flag}] bit 0 => Is In Aggressive State (Only 1 crow of a flock will attack at one given time, the rest will fly around close-by)
//           | | +0x28 - [32-bit] HP
//           | | ¨¨¨¨¨¨¨ - Full HP: 0xf; Hit once: 0xa; Hit twice: 0x0 (Value always gets replaced on taking damage instead of decrementing)
//           |
//           | | --- Other Enemies ---
//           | | - EnemyDataA_Pointer will eventually point/reference to EnemyDataB_Objects (same data, no copy), for these enemies (Refer to $0x10b1fa8)
// $10B1FA8: [PAL][32-bit Pointer{1}] Enemy Data B
//           - Each enemy has a unique EnemyDataB_Pointer
//           
//           +0x3F4 - [56-byte Array] List of EnemyDataB_Pointer{2} - Aggro
//           | - List only contains EnemyDataB_Pointer of enemies which are alive AND in aggresive state (aggro'd)
//           
//           +0x790 - [56-byte Array] List of EnemyDataB_Pointer{2} - Nearby
//           | - List only contains EnemyDataB_Pointer of enemies which are alive AND in vicinity of camera/prince
//           
//           { [Struct Definition][32-bit] EnemyDataB_Pointer{2}
//           |'''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x18 - [32-bit Pointer {3}]
//           | .+0x4 - [32-bit Pointer {4}]
//           | .| +0x5C - [32-bit] Enemy Type ID (IDs listed below)
//           | .| +0x48 - [32-bit Pointer {5}]
//           | .| | +0x0 - [Variable Size] EnemyDataB_Object
//           
//           { [Struct Definition][Variable Size] EnemyDataB_Object (By Enemy Type)
//           |'''''''''''''''''''''''''''''''''''''''''''''''
//           | - Structure size is dependent on enemy type
//           |
//           | | ---- Crow (ID = 0x551) ----
//           | |  - Data (HP) for Crows is stored via EnemyDataA chain NOT EnemyDataB (refer to $0x10b12a8)
//           |
//           | | ---- Raider (0x10f1) ----
//           | |  +0x208 - [32-bit] HP
//           |
//           | | ---- CrowMaster (0xB51) ----
//           | |  +0x200 - [32-bit] HP, if CrowMaster teleports to a different platform it's still the same enemy
//           |
//           | | ---- Silhouette (0xD91) ----
//           | |  +0x18C - [32-bit] HP
//           | |  +0x140 - [32-bit] AI Behavior (eg. 0x42 => attacking, 0x169 => taunting...)
//           |
//           | | ---- Shahdee(Boss) (0x1091) ----
//           | |  - ID = 0x1091 (1st appearance on ship)
//           | |  +0x198 - [32-bit] HP
// $10B2008: [PAL][32-bit Pointer] --> Interactable Objects
//           - Points to a data structure correlated to interactable object logic (eg. breakable boxes, artwork chests, weapon pickups...)
//           
//           +0x328 - [Dynamic Array] List of Interactable_IDs (listed below)
//           | - List of Interactable_IDs which are currently loaded in the current area
//           | - List gets repopulated on area load/leave
//           | - List resizes when interacting with objects (eg. picking up a weapon or breaking a box removes it from this list and list is resized)
//           | - Some items may despawn after set time, thus get removed from list
//           | - Weapons dropped are added to this list
//           | - Some Interactable_IDs are replaced by another Interactable_ID instead of removed (eg. on breaking artwork chest 0xa => becomes 0x12)
//           |
//           
//           +0x4E4 - [Dynamic Array] List of [32-bit Pointers{2}] --> [352-byte Struct] Interactable_Model_Data
//           | - List works same as list documented above, BUT filled with different data
//           
//           { [Struct Definition][352-byte??] Interactable_Model_Data
//           |'''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x40,+0x44,+0x50,+x054 - [(4x) Float] Model Size and Rotation
//           | +0x60 - [Float] Model X Coordinate
//           | +0x64 - [Float] Model Y Coordinate
//           | +0x68 - [Float] Model Z Coordinate
//           
//           # Interactable_IDs (list may be incomplete)
//           |'''''''''''''''''''
//           | 0x1 => ???
//           | 0xa => breakable container, also counts for artwork box (breaking artwork box => becomes 0x12) (some boxes drop SoT charges, weapon racks drop weapons)
//           | 0xb => ???
//           | 0x4 => ???
//           | 0x10 => secondary weapon pickup
//           | 0x12 => unbreakable box???
// $10BE580: [PAL][Float] Prince Model - Yaw
//           - Rotation along vertical/z-Axis
//           +0x4, +0x10, +0x14 - [(3x) Float] also correspond with yaw
// $10BE5B0: [PAL][12-byte Array] List of [(3x) Float] - X,Y,Z Coordinates - Prince Model
//           - Game consists of 1 "Superworld", not seperated levels. Even intro (ship battle) is in same "world". But you can't teleport anywhere by changing these coordinates directly if that area of the world hasn't loaded in recently.
//           
//           [PAL][Float] Prince Model - X Coordinate
// $10BE5B4: [PAL][Float] Prince Model - Y Coordinate
// $10BE5B8: [PAL][Float] Prince Model - Z Coordinate
// $10BE620: [PAL][Float] Prince Model - Yaw
//           - Identical at $0x10be580
// $10BE650: [PAL][12-byte Array] List of [(3x) Float] - X,Y,Z Coordinates - Prince Model
//           - Identical at $0x10be5b0 (slightly different function)
// $10BF2D4: [8 Bit] Bunch of flags but importantly Colision ON
//           Used for Pause and cutscene detection ?
//           Bit 0 and Bit 5 can be toggled off manually
// $10BF2D7: [8 Bit] Proper Pause flag
//           Bit 2 | Game Paused
// $10BF330: [32 Bit] Float Prince X coordinate (manipulable)
// $10BF334: [32 Bit] Float Prince Y coordinate (manipulable)
// $10BF338: [32 Bit] Float Prince Z coordinate (manipulable)
// $10BF3D8: [32 Bit] Float Prince Z coordinate (manipulable)
//           Clone value
// $135ADB0: [PAL][32-bit Flag] Is Loading (unverified)
//           0x0 => not loading
//           0x1 => loading screen is displayed
// $1364AEC: [32 Bit] Nb of enemies killed
//           tbc for pointer
// $1365650: [PAL][[5872-byte Struct] Prince_Data
//           @Fixed Memory Location. Although pointed to by: Game_Controller_Object $0x7b7cc0
//           
//           { [Struct Definition][[5872-byte] Prince_Data
//           |'''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x1F4 - [32-bit] Prince HP (Functional)
//           | | - Documentation at $0x1365844
//           |
//           | +0x95C- [Bit Flag {32-bit}] bit 0 => Is Secondary Weapon Equipped
//           | | - Documentation at $0x1365fac
//           |
//           | +0xA94- [32-bit] Sands of Time (SoT) Charges (Functional)
//           | | - Documentation at $0x13660e4
//           |
//           | +0x11C4 - [Bit Flags {32-bit}] Sands of Time Powers Unlocked
//           | | - Documentation at $0x1366814
//           |
//           | +0x1328 - [2-byte Bitset] HP Upgrades (9 total)
//           | | - Documentation at $0x1366978
//           |
//           | +0x1358 - [32-bit Pointer{2}] --(+0x0)--> [48-byte Struct] Secondary_Weapon_Data
//           | | - Documentation at $0x13669a8
//           |
//           | +0x1400 - [32-bit Pointer{2}] --(+0x0)--> [30-byte?? Struct] Primary_Weapon_Data
//           | | - Documentation at $0x1366a50
//           |
//           | +0x1490 - [32-bit] Prince Max HP (Functional)
//           | | - Documentation at $0x1366AE0
// $1365844: [PAL][32-bit] Prince HP (Functional)
//           @Member of Struct: Prince_Data $0x1365650
// $1365FAC: [PAL][Bit Flag {32-bit}] bit 0 => Is Secondary Weapon Equipped (alt 1)
//           @Member of Struct: Prince_Data $0x1365650
//           - Identical to $0xcb783c
// $13660E4: [PAL][32-bit] Sands of Time (SoT) Charges (Functional)
//           @Member of Struct: Prince_Data $0x1365650
//           - Value range [0x0-0x6]
// $1366764: [32 Bit] Real Sand Charge
//           Likely pointer
// $1366814: [PAL][Bit Flags {32-bit}] Sands of Time Powers Unlocked
//           @Member of Struct: Prince_Data $0x1365650
//           - Check in-game combo list menu: how to activate each power
//           - Powers are functional after intro section on ship
//           bit 0 => Recall (redo/rewind)
//           bit 1 => Eye of the Storm (slow down time)
//           bit 2 => Breath of Fate (ground slam)
//           bit 3 => Wind of Fate (upgraded/replaces 'Breath of Fate')
//           bit 4 => Cyclone of Fate (upgraded/replaces 'Wind of Fate')
//           bit 5 => Ravages of Time (superspeed/quickness)
// $1366978: [PAL][2-byte Bitset] HP_Upgrades (9 total)
//           - All locations are in the past
//           - 1 HP upgrade: easy => +0x19; normal => +0x11; hard => +0xC
//           
//           [PAL][Bit Flags] @Byte1 in Bitset: HP_Upgrades $0x1366978
//           bit 0 => Fortress Entrance (can also be achieved without EyeOfTheStorm power)
//           bit 1 => TBD
//           bit 2 => TBD
//           bit 3 => Sacrificial Chamber (behind stone, after 2nd Shahdee boss fight)
//           bit 4 => TBD
//           bit 5 => TBD
//           bit 6 => TBD
//           bit 7 => TBD
// $1366979: [PAL][Bit Flags] @Byte2 in Bitset: HP_Upgrades $0x1366978
//           bit 0 OR 7 => TBD
// $13669A8: [PAL][32-bit Pointer{1}] --(+0x0)--> [48-byte Struct] Secondary_Weapon_Data
//           @Member of Struct: Prince_Data $0x1365650
//           - This pointer is only operational when a secondary weapon is equipped (Refer to $0xcb783c)
//           Value = 0x0 => no secondary weapon equipped
//           Value != 0x0 (value is pointer) => secondary weapon is equipped
//           
//           { [Struct Definition][48-byte] Secondary_Weapon_Data
//           |'''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x10 - [32-bit Pointer{2}] --(+0x0)--> [60-byte Struct] Secondary_Weapon_Model_Data_A
//           | { [Struct Definition][60-byte] Secondary_Weapon_Model_Data_A
//           | |''''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | | +0x0 - [48-byte] Model/Texture Data?
//           | | | - This 48-byte block is unique per weapon, thus can be used to ID the currently equipped secondary weapon (prefer using Secondary_Weapon_ID)
//           |
//           | +0x14 - [32-bit Pointer{2}]
//           | .+0x0 - [32-bit Pointer{3}] --(+0x0)--> [12-byte Struct] Secondary_Weapon_Model_Data_B
//           | .{ [Struct Definition][12-byte] Secondary_Weapon_Model_Data_B
//           | .|''''''''''''''''''''''''''''''''''''''''''''
//           | .| +0x0,+0x4 - [(2x) 32-bit Pointer{4}] --> Secondary Weapon Model
//           | .| | - Changing both these pointers to point to other valid model data => will change the secondary weapon to that model (it's another pointer chain)
//           | .|
//           | .| +0x0 - [32-bit Pointer{4}] --> Secondary_Weapon_ID
//           | .| .+0x28 - [32-bit Pointer{5}]
//           | .| ..+0x4 - [32-bit] Secondary_Weapon_ID
//           | .| ..| - ID is equal to the index of the weapon inside the Weapon_Gallery_Unlocks Bitset $0x7dda48
//           |
//           | +0x18 - [32-bit Pointer{2}] --> Secondary Weapon Durability
//           | | +0x4 - [32-bit Pointer{3}]
//           | | .+0x48 - [32-bit Pointer{4}]
//           | | ..+0x18 - [32-bit] Secondary Weapon Durability (Functional)
//           | | ..| - Durability is dependent on Secondary Weapon ID
// $1366A50: [PAL][32-bit Pointer{1}] PrimaryWeapon_Pointer --(+0x0)--> [46-byte Struct] Primary_Weapon_Data
//           @Member of Struct: Prince_Data $0x1365650
//           - Higher tiers of primary weapons, increase the length of attack/combo strings (refer to $0x1367af0)
//           - Each primary weapon has a unique pointerValue, game keeps a list of these PrimaryWeapon_Pointers in RAM at $0xc5c3a0
//           - The pointers to Primary_Weapon_Data can be used to ID the weapon, see list below (different release regions may have different pointerValues)
//           - A list of PrimaryWeapon_Pointers is stored at $0xc5c3a0
//           - Changing the pointer value to a valid PrimaryWeapon_ID will change the main weapon to that weapon model (might be buggy)
//           
//           { [Struct Definition][46-byte] Primary_Weapon_Data
//           |''''''''''''''''''''''''''''''''''''''''''''''''''''''
//           | +0x0 - [64-bit] Might be related to attack logic and which combo strings/attack animations are allowed (refer to $0x1367af0), game breaks on manual value change)
//           |
//           | +0x14 - [32-bit Pointer{2}] --> Primary Weapon Identification
//           | .+0x0 - [32-bit Pointer{3}]
//           | .| +0x0 - [32-bit Pointer{4}] --> Primary Weapon ID A
//           | .| .+0x28 - [32-bit Pointer{5}]
//           | .| ..+0x4 - [32-bit] PrimaryWeapon_ID_A
//           | .| ..| - IDs listed below
//           | .|
//           | .| +0x4 - [32-bit Pointer{4}] --> Primary Weapon ID B
//           | .| .+0x18 - [32-bit Pointer{5}]
//           | .| ..+0x0 - [32-bit] PrimaryWeapon_ID_B
//           | .| ..| - IDs listed below
//           
//           # PrimaryWeapon_Pointers (can also be used to ID primary weapon)
//           |'''''''''''''''''
//           | 0xb39ad0 => Eagle Sword (starter weapon on ship)
//           | 0xb48030 => Wooden Stick
//           | 0xb41db0 => Spider Sword
//           | TBD => Serpent Sword
//           | TBD => Lion Sword
//           | TBD => Scorpion Sword
//           | TBD => Water Sword
//           
//           # PrimaryWeapon_IDs_A (these might be correlated to Bitset Weapon_Gallery_Unlocks $0x7dda48)
//           |'''''''''''''''''
//           | 0x37 => Eagle Sword (starter weapon on ship)
//           | 0x1C => Wooden Stick
//           | 0x36 => Spider Sword
//           | TBD => Serpent Sword
//           | TBD => Lion Sword
//           | TBD => Scorpion Sword
//           | TBD => Water Sword
//           
//           # PrimaryWeapon_IDs_B (these values are unique per main weapon)
//           |'''''''''''''''''
//           | 0x9 => Eagle Sword (starter weapon on ship)
//           | 0x3 => Wooden Stick
//           | 0x7 => Spider Sword
//           | TBD => Serpent Sword
//           | TBD => Lion Sword
//           | TBD => Scorpion Sword
//           | TBD => Water Sword
// $1366AE0: [PAL][32-bit] Prince Max HP (Functional)
//           @Member of Struct: Prince_Data $0x1365650
//           - Dependent on game difficulty (refer to $0xb9f594)
// $1366D40: [PAL][1168-byte] Game_Data
//           @Fixed Memory Location. Although pointed to by $0x7bafd4
//           
//           { [Struct Definition][1168-byte] Cutscene_Camera_Data
//           |''''''''''''''''''''''''''''''''''''''''''''''
// $1366DC8: [PAL][8-bit Bitfield {32-bit}] Game State - Cutscene/Video (alt 1)
//           @Member of Struct: Game_Data $0x1366d40
//           0x0 => Loading (black transition screen is active)
//           0x1 => During loading screen AND during gameplay
//           0x4 => Cutscene or video is active
// $1366E2C: [PAL][Bit Flag {32-bit}] bit 0 =>  Is Cutscene/Video Active
//           @Member of Struct: Game_Data $0x1366d40
// $1367064: [PAL][8-bit Bitfield {32-bit}] Game State - Cutscene/Video (alt 2)
//           @Member of Struct: Game_Data $0x1366d40
//           - Identical to $0x1366dc8
// $13670A0: [PAL][8-bit Bitfield {32-bit}] Camera State
//           @Member of Struct: Game_Data $0x1366d40
//           0x0 => Default state during gameplay
//           0x1 => Camera is in reset state (activated by pressing R3)
//           0x3 => Panning shot cutscene is active (without special character animations, eg a panning shot of a new area, suggesting to the player where to go) + also during loading
//           0x4 => Landscape mode (zoomed out, with cinematic view of environment)
//           0x5 => Cutscene/Video is active
// $13671B8: [PAL][32-bit Pointer{1}] --&gt; In-engine Cutscene ID
//           @Member of Struct: Game_Data $0x1366d40
//           - Pointer{1} is only functional during an in-engine cutscene, otherwise value is 0x0
//           
//           +0x28 - [32-bit Pointer{2}]
//           .+0x1C - [32-bit] In-engine Cutscene ID
//           .| - Some of these IDs are used for multiple cutscenes in a given area
//           .| - IDs listed below
//           
//           # InEngineCutscene_IDs (list incomplete)
//           |'''''''''''''''''''''''''
//           | 0x203 =&gt; Intro - Ship Battle; Ally fighting on mast + Prince falls into lower deck
//           | 0x35 =&gt; Intro - Ship Battle; Enemy ship rams into Prince ship + Prince gets back on the upper deck
//           | 0x169 =&gt; Intro - Ship Battle; (immediately after 0x35) Prince sees Shahdee on upper deck
//           | 0x169,0x16a,0x16b =&gt; Intro - Ship Battle; Cutscenes before and during Shahdee bossfight on upper deck
//           | 0x156 =&gt; After ship battle; Prince wakes up on beach wreckage
//           | ...
// $1367AF0: [PAL][32-bit] Attack Animation ID
//           @Member of Struct: Game_Data $0x1366d40
//           - Longer attack strings are unlocked once you acquire better main weapons
//           
//           # AttackAnimation_IDs (list incomplete, check in-game combo list)
//           |''''''''''''''''''''''
//           | - 0x0 => non-attack animation (jumping, idle, wall-running, hitting wall...)
//           | - 0x1,0x2,0x3 => main weapon combo (square) (= M)
//           | - 0x5,0x6,0x7 => double weapon combo (triangle) (= D)
//           | - 0x1,0x8,0x9 => M,D,D
//           | - 0x5,0x11,0x12 => D,M,M
//           | - 0x1,0x2,0xa,0xb,0xc => M,M,D,D,D
//           | - 0x1,0x2,0xa,0xb,0xd => M,M,D,M,M
//           | - 0x1d => D hold
//           | - 0x2f => D hold into enemy, M (only possible when 2nd weapon equipped)
//           | - 0x29 => D hold into enemy, D (only possible when 2nd weapon equipped)
//           | - 0x3a,0x3b => vault over enemy M,M
//           | - 0x3c,0x56 => vault over enemy D,D
//           | - 0x41 => M into wall (only possible when enemy nearby)
//           | - 0x42 => D into wall (only possible when enemy nearby)
//           | - 0x46,0x47 => M hold from vertical wallrun, M
//           | - 0x48 => D hold from vertical wallrun
//           | - 0x49,0x1 => M into pole (continues into M combo strings)
//           | - 0x49,0x5 => D into pole (continues into D combo strings)
// $1611B98: list of game objects???
// $1932E10: List of pointers??
// $1A3CFF0: [32 Bit] Ascii MapID
//           Pointed data 2
// $1BDCD90: List of pointers??
// $1C59BF4: List of pointers??
// $1FFC660: [32 Bit] Boss Actual Health Pointer
//           +0x198 Boss Actual Health
//           Likely chain pointer
