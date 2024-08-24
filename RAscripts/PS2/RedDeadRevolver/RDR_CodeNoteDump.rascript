// Red Dead Revolver
// #ID = 11094

// $000040: [PAL][32-bit] Always_NULL
// $0780B0: [PAL][NTSCU][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_UI_Controller (Preferred)
//          [Struct Definition][??-byte] MultiplayerRewardMenu_UI_Controller
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x1C - [32-bit Pointer{2}]
//          |+|+0x1414 - [PAL][32-bit || Float] Highlighted PopupMenu Item
//          |+|¨| - 0x0 => Replay
//          |+|¨| - 0x1 => Multiplayer Settings || 0x3F800000 (= 1.0) => Multiplayer Settings (becomes a float sometimes)
//          |+|¨| - 0x2 => Quit
//          |+|/
//          |+|+0x1044 - [NTSCU][32-bit || Float] Highlighted PopupMenu Item
//          |+|¨| - Identical as (PAL)
//          |/
//          '
// $4F6FD8: [8bit] Player is in a cutscene?
// $4F792C: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [Variable Size Struct] Extra_Mission_Data
//          @Regional equivalent of $0x4f9fac (PAL)
// $4F7CF0: [NTSCU][32-bit Pointer] --(+0x0)--> [??-byte Struct] Undefined_Struct_03
//          @Regional equivalent of $0x4fa370 (PAL)
// $4F7D20: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [112-byte Array] List of [(14x) 8-byte Struct] Major_Character_Data{1}
//          @Regional equivalent of $0x4fa3a0 (PAL)
// $4F93DC: [PAL][Bit Flag {32-bit}] bit 0 => Is Title Menu Displayed (alt)
//          - Identical to $0x562a0c
// $4F9470: [NTSCU][8-bit Bitfield {32-bit}] Game Mode
//          @Regional equivalent of $0x4fbaf0
// $4F9FAC: [PAL][32-bit Pointer{1}] --(+0x0)--> [Variable Size Struct] Extra_Mission_Data
//          - Extra_Mission_Data contains extra data pertaining mission logic
//          - Extra_Mission_Data size is dependent on the mission
//          
//          [Struct Definition][16-byte] Extra_Mission_Data.RogueValley (Chapter 8)
//          |'''''''''''''''''''''''''''''''''''''''
//          |+0x4 - [12-byte Array] List of [(3x) 32-bit Pointer{2}] --(+0x0)--> [80-byte Struct] Treasure_Found_Trigger
//          |+| - There's 3 treasure boxes to be discovered
//          |+|
//          |+|[Struct Definition][80-byte] Treasure_Found_Trigger
//          |+||'''''''''''''''''''''''''''''''''''''''
//          |+||+0x0 - [Variable Size ASCII] Treasure_Found_Trigger_ID
//          |+||¨| - Miscellaneous data
//          |+||/
//          |+||+0x4C - [Bit Flag {32-bit}] bit 0 => Is Treasure Opened
//          |/
//          '
//          
//          [Struct Definition][68-byte] Extra_Mission_Data.TheTraitor (Chapter 13)
//          |'''''''''''''''''''''''''''''''''''''''
//          |+0x4 - [64-byte Array] List of [(16x) 32-bit Pointer{2}] --(+0x0)--> [80-byte Struct] Cannon_Destroyed_Trigger
//          |+| - First 8 entries in list correspond to allied (Diego's) cannons
//          |+| - Last 8 entries in list correspond to enemy cannons
//          |+|
//          |+|[Struct Definition][80-byte] Cannon_Destroyed_Trigger
//          |+||'''''''''''''''''''''''''''''''''''''''
//          |+||+0x0 - [Variable Size ASCII] Cannon_Destroyed_Trigger_ID
//          |+||¨| - Miscellaneous data
//          |+||/
//          |+||+0x4C - [Bit Flag {32-bit}] bit 0 => Is Cannon Destroyed
//          |/
//          '
//          
//          [Struct Definition][8-byte] Extra_Mission_Data.BearMountain (Chapter 14)
//          |'''''''''''''''''''''''''''''''''''''''
//          |+0x4 - [32-bit Pointer{2}]
//          |++0x4C - [Bit Flag {32-bit}] bit 0 => Is TreasureBox Faith Opened
//          '
// $4FA370: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] Undefined_Struct_03 (Preferred)
//          [Struct Definition][??-byte] Undefined_Struct_03
//          |''''''''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+0xD8 - [32-bit] Mission Killcount
//          |¨| - This is the true killcount in a mission, also counts kills by enemy friendly fire (indirectly caused by other means, other than the player)
//          |¨| - Refer to 'death toll' ($0x763070) as another killcount
//          |/
//          '
// $4FA3A0: [PAL][32-bit Pointer{1}] --(+0x0)--> [112-byte Array] List of [(14x) 8-byte Struct] Major_Character_Data{1}
//          - This array stores pointers to Actor_Data
//          - This pointer chain is a preferable alternative to using the Actor_Data Array at $0x7621d0, as not all Major Characters (eg. Grizzly on Chapter 15 'Bear Mountain') are contained inside that array + the actor data could be in multiple indices of the array
//          
//          [Struct Definition][8-byte] Major_Character_Data{1}
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x0 - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] Major_Character_Data{2}
//          | - This Pointer{2} is zeroed out when the Major Character has not yet spawned, pointer stays active after death
//          |
//          |[Struct Definition][??-byte] Major_Character_Data{2}
//          ||''''''''''''''''''''''''''''''''''''''''''''
//          ||+0x4 - [32-bit Pointer{3}]
//          ||+|+0x0 - [Variable Size ASCII] Character_Name
//          ||+|¨| - This is the same name that would be stored via Actor_Data_B at $0x7621d0
//          ||/
//          ||
//          ||+0x18 - [32-bit Pointer{3}]
//          ||++0x10 - [32-bit Float] Actor HP
//          ||++0x14 - [32-bit Float] Actor Max HP
//          |/
//          '
// $4FA50C: [PAL][32-bit Pointer] --(+0x0)--> Undefined_Struct_02
//          - Contains pointers to other structures
// $4FA558: [PAL][32-bit Timer] Time Spent In Control of Character
//          - Increments by 3, each 2 frames (same for NTSC, PAL mode)
//          - Only increments when player can control a character (campaign and showdown mode)
// $4FBAF0: [PAL][8-bit Bitfield {32-bit}] Game Mode
//          0x0 => Game is booting (Main Menu has not yet been reached) || Also 0 for a few frames during certain loading screens
//          0xA => Main Menu (lvl_front)
//          0xC8 => Showdown Mode
//          0xFA => Single Player Mode || Bounty Hunter Mode
// $4FD3A8: [PAL][8-bit {32-bit}] Refresh Rate
//          - Game offers the option to chose refresh rate on game boot
//          0x32 (=50) => PAL 50Hz mode
//          0x3C (=60) => NTSC 60Hz mode
// $4FD3EC: [PAL][Bit Flag {32-bit}] bit 0 => Is Not Loading
//          bit 0 = 0 => Loading
//          bit 0 = 1 => Not loading
// $501A38: [PAL][Bit Flag {32-bit}] bit 0 => Is In-Game (preferred)
//          - Can be used to check if the level is restarted via PauseMenu
//          - Restarting/Retrying via RetryMenu will keep this value at 1
//          
//          1 => In-Game (Single Player & Showdown Mode), PauseMenu, RetryMenu, GameOver screen
//          0 => During loading screens, MainMenu, RewardMenu, Restarting level via PauseMenu
// $54A04C: [NTSCU][11-byte ASCII] Game ID (USA) - PS2 Product ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLUS_205.00" => USA
// $54A348: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_Data
//          @Regional equivalent of $0x54cac8 (PAL)
// $54A370: [NTSCU][32-bit Pointer{1}] --> RewardMenu and StartChpMenu Display Data
//          @Regional equivalent of $0x54caf0 (PAL)
//          ⚠ -> Struct: RewardMenu_DisplayData (NTSCU) has different offsets but same setup compared to PAL
// $54C7CC: [PAL][11-byte ASCII] Game ID (EUR) - PS2 Product ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLES_524.78" => EUR
// $54CAC8: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_Data (Preferred)
//          [Struct Definition][??-byte] MultiplayerRewardMenu_Data
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x28 - [32-bit Pointer{2}]
//          |+| - This Pointer{2} is zeroed out when the MultiplayerRewardMenu is NOT displayed
//          |+|
//          |+|+0x0 - [14-byte ASCII Flag] Is Multiplayer Reward Menu Displayed
//          |+|¨| - ASCIIvalue = "mpRewards_new3" --> MultiplayerRewardMenu is displayed
//          |+|¨| - First 8-byte of ASCII is zero'd out when NOT displayed
//          |+|/
//          |+|+0x24 - [32-bit Pointer{3}]
//          |+|++0x34 - [32-bit Pointer{4}]
//          |+|++|+0x0 - [PAL][64-byte ASCII Field] ShowdownMode_ScoreboardWinnerDisplay_Text
//          |+|++|¨| - ASCII Field Definition below
//          |+|++|
//          |+|++|+0x180 - [NTSCU][64-byte ASCII Field] ShowdownMode_ScoreboardWinnerDisplay_Text
//          |+|++|¨| - ASCII Field Definition below
//          |/
//          |
//          |+0x34 - [1024-byte ASCII Field] ShowdownMode_ScoreboardDisplay_Text
//          |¨| - ASCII Field Definition at $0x6b18b4
//          |/
//          '
//          
//          [ASCII Field Definition][64-byte] ShowdownMode_ScoreboardWinnerDisplay_Text
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x0 - [12-byte ASCII Flag:IsWinner] Player 1
//          |+0x10 - [12-byte ASCII Flag:IsWinner] Player 2
//          |+0x20 - [12-byte ASCII Flag:IsWinner] Player 3
//          |+0x30 - [12-byte ASCII Flag:IsWinner] Player 4
//          |[ASCII Flag Definition][12-byte] IsWinner
//          ||'''''''''''''''''''''''''''
//          || - ASCIIvalue = "Winner" --> Player is part of the winning team
//          ''
// $54CAF0: [PAL][32-bit Pointer{1}] --> RewardMenu and StartChpMenu Display Data (Preferred)
//          |+0xAC - [32-bit Pointer{2}]
//          |+|+0x34 - [32-bit Pointer{3}]
//          |+|+| - This Pointer{3} is only functional when the Reward Menu is displayed
//          |+|+|
//          |+|+|+0x1c - [32-bit Pointer{4}] --(+0x0)--> [??-byte Struct] RewardMenu_DisplayData
//          |+|+|+| - Struct Definition below
//          |+|/
//          |+|+0x38 - [Bit Flag {32-bit}] bit 0 => Is RewardMenu OR StartChpMenu Displayed
//          |/
//          |
//          +0x1EC - [12-byte ASCII] StartChpMenu name
//          |¨| - ASCII = "startChpMenu", when this menu has been displayed at least once
//          |/
//          |+0x214 - [Bit Flag {32-bit}] bit 0 => Is StartChpMenu Active (preferred)
//          |¨| bit 0 = 1 => StartChpMenu Active (also 1 when in any of the sub-menu's: PreMissionShopMenu or WeaponSelectionMenu)
//          |¨| bit 0 = 0 => StartChpMenu Inactive
//          |/
//          |+0x260 - [Bit Flag {8-bit}] bit 0 => Is StartChpMenu_WeaponSelectionMenu Available
//          |
//          |+0x284 - [Variable Size ASCII] StartChpMenu_Shop_ID
//          |¨| - IDs currently not listed (not useful for achievements)
//          |/
//          |+0x2AC - [Bit Flag {32-bit}] bit 0 => Is StartChpMenu_Shop Available
//          |
//          |+0x2E4 - [Variable Size ASCII Field] StartChpMenu_Shop Item Names
//          |¨| - This ASCII field contains names of the shop items
//          |/
//          |
//          |+0x2D0 - [32-bit Pointer{2}]
//          |+| - This Pointer{2} is only functional when the Reward Menu is displayed
//          |+|
//          |+|+0x24 - [32-bit Pointer{3}]
//          |+|+|+0x1C - [32-bit Pointer{4}] --(+0x0)--> [??-byte Struct] RewardMenu_DisplayData
//          |+|+|+| - Struct Definition below
//          |+|+|/
//          |+|+|+0x34 - [32-bit Pointer{4}] --(+0x0)--> [2448-byte ASCII Field] RewardMenu_DisplayText
//          |+|+|+| - ASCII Field Definition below
//          |/
//          '
//          
//          [Struct Definition][PAL][??-byte] RewardMenu_DisplayData
//          |============================================
//          | - This struct contains UI data logic for the Reward Menu (where the player can see which items he has unlocked from the mission and his mission stats)
//          |
//          |+0xE4 - [Bit Flag {32-bit}] bit 0 => Is Quit Confirmation Menu Displayed
//          |+| - bit 0 = 1 => only when YesNoConfirmation Menu is displayed after pressing 'quit', not when pressing 'replay', thus this can be used to identify which confirmation menu is open. The one after quit (bitValue 1) or the one after replay (bitValue 0)
//          |/
//          |
//          |+0x5D4 - [32-bit Pointer] --(+0x0)--> [Variable Size ASCII] Area_ID (functional)
//          |+| - Documentation at $0x7a0620
//          |/
//          |
//          |+0x810 - [64-byte Array] List of [(4x) 16-byte Struct:RatingObjectiveStar_UI_Element_Data]
//          |¨[Array Definition][64-byte]
//          |¨|'''''''''''''''''''''''''
//          |¨| - Struct Definition RatingObjectiveStar_UI_Element_Data below
//          |¨|
//          |¨|+0x0 - [16-byte Struct:RatingObjectiveStar_UI_Element_Data] Accuracy
//          |¨|¨| - RewardMenu_UI_Element_ID = "pulseOn_accuracy"
//          |¨|/
//          |¨|+0x10 - [16-byte Struct:RatingObjectiveStar_UI_Element_Data] Damage Taken
//          |¨|¨| - RewardMenu_UI_Element_ID = "pulseOn_damage"
//          |¨|/
//          |¨|+0x20 - [16-byte Struct:RatingObjectiveStar_UI_Element_Data] Time
//          |¨|¨| - RewardMenu_UI_Element_ID = "pulseOn_time"
//          |¨|/
//          |¨|+0x30 - [16-byte Struct:RatingObjectiveStar_UI_Element_Data] Best Combo
//          |¨|¨| - RewardMenu_UI_Element_ID = "pulseOn_combo"
//          |/
//          |
//          |+0x8A4 - [Bit Flag {32-bit}] Highlighted Menu Item
//          |¨| - 0x0 => Top menu item
//          |¨| - 0x1 => Bottom menu item
//          |/
//          |
//          |+0x9D4 - [8-bit {32-bit}] Menu Depth
//          |¨| - 0x0 => RewardMenu
//          |¨| - 0x1 => Quit or Replay Popup
//          |¨| - 0x2 => YesNoConfirmation Popup
//          |¨| - 0x3 => Logo Loading Screen
//          |/
//          |
//          |+0x9E4 - [32-bit] Bounty Collected
//          |+0x9F4 - [32-bit] Money Spent
//          |+0xA04 - [32-bit] Balance
//          |
//          |+0xA70 - [48-byte Array] List of [(3x) 16-byte Struct:ItemUnlock_UI_Element_Data]
//          |¨[Array Definition][48-byte]
//          |¨|'''''''''''''''''''''''''
//          |¨| - Struct Definition ItemUnlock_UI_Element_Data below
//          |¨|
//          |¨|+0x0 - [16-byte Struct:ItemUnlock_UI_Element_Data] Item Unlock - Good Rating
//          |¨|¨| - RewardMenu_UI_Element_ID = "rankNormal"
//          |¨|/
//          |¨|+0x10 - [16-byte Struct:ItemUnlock_UI_Element_Data] Item Unlock - Excellent Rating
//          |¨|¨| - RewardMenu_UI_Element_ID = "rankGreat"
//          |¨|/
//          |¨|+0x20 - [16-byte Struct:ItemUnlock_UI_Element_Data] Item Unlock - Bounty Rating
//          |¨|¨| - RewardMenu_UI_Element_ID = "rankBounty"
//          |/
//          '
//          
//          [Struct Definition][16-byte] RatingObjectiveStar_UI_Element_Data
//          |'''''''''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Pointer] --(+0x0)--> [Variable Size ASCII] RewardMenu_UI_Element_ID
//          |¨| - IDs are noted next to the elements in this code note
//          |¨| - IDs are in English in RAM, regardless of Selected Display Language
//          |/
//          |+0x4 - [Bit Flag {32-bit}] bit 0 => Is Rating Objective Star Achieved
//          |¨| - If a star is displayed, it counts toward acquiring Good or Excellent rating for the mission, thus unlocking the corresponding mission item unlocks
//          |¨| - Usually 2 stars are required for a Good rating and 3 stars are required for an Excellent rating
//          |¨| bit 0 = 0 => star is NOT displayed
//          |¨| bit 0 = 1 => star IS displayed
//          |/
//          '
//          
//          [Struct Definition][16-byte] ItemUnlock_UI_Element_Data
//          |'''''''''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Pointer] --(+0x0)--> [Variable Size ASCII] RewardMenu_UI_Element_ID
//          |¨| - IDs are in English in RAM, regardless of Selected Display Language
//          |¨| - IDs are noted next to the elements in this code note
//          |/
//          |+0x4 - [32-bit Pointer] --(+0x0)--> [Variable Size ASCII] ItemUnlock_UI_Element_ID
//          |¨| - IDs are in English in RAM, regardless of Selected Display Language
//          |¨| - IDs listed below
//          |/
//          '
//          
//          [ASCII Field Definition][2448-byte] RewardMenu_DisplayText
//          |'''''''''''''''''''''''''''''''''''''''''''
//          |+0x130 - [7-byte ASCII] Time
//          |+0x140 - [6-byte ASCII] Damage Taken
//          |+0x150 - [6-byte ASCII] Accuracy
//          |+0x160 - [8-byte ASCII] Best Combo
//          '
//          
//          # ItemUnlock_UI_Element_IDs (string)
//          |(list incomplete) (grouped by mission)
//          |'''''''''''''''''''''''''''''''''''''''''''''
//          | locked => image of a lock + text (item is not unlocked)
//          |---- Bull's Eye ----
//          | (GOOD) Old_Pistol_u => +Old Pistol+ (upgraded Old Pistol)
//          | (EXCELLENT) lvl_perfnew => Broken Creek (STAGE)
//          | (BOUNTY) mom => Falling Star (CHAR)
//          |---- Bounty Hunter ----
//          | (GOOD) gay => "Bloody" Tom (CHAR)
//          | (EXCELLENT) frk => "Big Oaf" Whitney (CHAR)
//          | (BOUNTY) shp => "Curly" Shaw (CHAR)
//          | ...
//          '
// $54DD4C: [NTSCJ][11-byte ASCII] Game ID (JPN) - PS2 Product ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLPM_658.54" => JPN
// $5511F4: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_Data (Alt1)
// $55B6A8: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [480-byte Struct] GatlingGun_Zone_Data
//          @Regional equivalent of $0x55de28 (PAL)
// $55DE28: [PAL][32-bit Pointer{1}] --(+0x0)--> [480-byte Struct] GatlingGun_Zone_Data
//          - This Pointer{1} seems to point to a possible LinkedList containing interactable "zones" within an AREA/level/mission, each zone seems to contain an interactable levelitem (eg. gatling gun OR shootable lever)
//          - This Pointer{1} always points to the node "zone_gunA_01", which is the gatling gun, thus this Pointer{1} should only be used for that functionality
//          - This Pointer{1} flickers with another pointerAddress when another gameActor other than the player is shooting the gatling gun
//          
//          [Struct Definition][480-byte] GatlingGun_Zone_Data
//          |''''''''''''''''''''''''''''''''
//          |+0x1C - [Variable Size ASCII] InteractableZone_ID
//          |¨| - ASCII = "zone_gunA_01" (for this struct:GatlingGun_Zone_Data)
//          |/
//          |+0x169 - [Bit Flag] bit 0 => Is Gatling Gun Manned
//          |¨| - Can be manned by AI as well as player
//          |/
//          '
// $562A0C: [PAL][Bit Flag {32-bit}] bit 0 => Is Title Menu Displayed (Preferred)
//          bit 0 = 0 => In-game || Game  Is Booting Up
//          bit 0 = 1 => Title Menu
// $562A10: [PAL][8-bit {32-bit}] UI Render Stack Level
//          - This seems to count how many things are rendered on top of each other whilst in-game
//          - This value can be used to check if the game is past the Main Menu; Check if => In-Game
//          
//          - 0x0 => No UI render?? (unconfirmed) (also during some cutscenes)
//          - 0x1 => Loading?? (unconfirmed)
//          - 0x2 => Main Menu
//          - 0x3 => Game Render?? (unconfirmed)
//          - 0x4 => Default In-Game HUD
//          - higher values => are extra UI on top of the game HUD (eg. the dualshock controller which is rendered during chapter 1, puts this value at 0x5 => then opening the pause menu puts it at 0x6...)
// $562A20: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] Game_Controller
//          
//          [Struct Definition][??-byte] Game_Controller
//          |===============================================
//          |
//          |+0x1C - [32-bit Pointer{2}]
//          |++0x48 - [32-bit Ponter{3}] --(+0x0)--> [116-byte Struct] HealthBar_HUDController
//          |++[Struct Definition][116-byte] HealthBar_HUDController
//          |++|''''''''''''''''''''''''''''''''''''''''''''''''''
//          |++|+0x10 - [32-bit] Max HP (Display)
//          |++|¨| - This determines the size of the HP bar
//          |++|/
//          |++|+0x14 - [32-bit] HP (Display)
//          |/
//          |
//          |+0x20 - [32-bit Pointer{2}]
//          |++0x60 - [32-bit Pointer{3}] --(+0x0)--> [??-byte Struct] SpecialMeterGauge_Controller
//          |++[Struct Definition][??-byte] SpecialMeterGauge_Controller
//          |++|''''''''''''''''''''''''''''''''''''''''''''''''''
//          |++| - Controls both the HUD display and the underlying logic for the special meter (below HP bar)
//          |++|
//          |++|+0x60 - [32-bit Float] Special Meter Gauge
//          |++|¨| - Special actions such as deadeye or a special move depending on selected showdown character
//          |++|/
//          |++|+0x64 - [32-bit Float] Special Meter Max Gauge
//          |++|¨| - This value, rounded down to the nearest whole number, equals the number of special meter bars displayed (e.g., 3.456 --> 3 bars)
//          |++|¨| - Each special action costs 1 full bar
//          |++|¨| - Base Max Dead Eye Gauge: 3.0
//          |++|¨| - Each Dead Eye Upgrade increases this bar by 1.0
//          |/
//          |
//          |+0x2C - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] AmmoCounter_HUDController
//          |+[Struct Definition][??-byte] AmmoCounter_HUDController
//          |+|''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+| - Controls ammo HUD display in the bottom-left
//          |+|
//          |+|+0x8 - [8-bit {32-bit}] Equipped Secondary Pistol - Loaded Ammunition
//          |+|¨| - This value is only functional when dual wielding pistols, this controls the ammo counter behind the main ammo counter
//          |+|/
//          |+|+0x14 - [32-bit] Equipped Weapon - Reserve Ammo
//          |+|¨| - Max properly displayable value on UI is 0x3e7 (=999)
//          |+|¨| - This value counts the ammo loaded inside the gun as well
//          |+|¨| - Functional values on ammunition at $0x7638b8
//          |+|/
//          |+|+0x1C - [8-bit {32-bit}] Equipped Weapon - Loaded Ammunition
//          |+|¨| - Both of these values control the UI display
//          |+|¨| - Functional ammunition per gun is stored via $0x763070 (refer to Struct: Ammunition_Inventory)
//          |+|/
//          |+|+0x28 - [8-bit {32-bit}] Equipped Weapon - Loaded Ammunition (copy of above)
//          |/
//          |
//          |+0xC0 - [32-bit Pointer{2}] --(+0x0)--> [1916-byte Struct] Showdown_PosterMenu_Controller
//          |+| - This Pointer{2} is only functional at the Main Menu
//          |+| - Struct Definition below
//          |/
//          |
//          |+0x2C9 - [1344-byte Array] List of [(4x) 336-byte Struct:ShowdownPlayer_Settings]
//          |+| - This Array is only functional during a Showdown match
//          |¨| - Documentation at $0x73d819
//          |/
//          |
//          |+0x808 - [Variable Size ASCII] Area_ID (alt)
//          |¨| - IDs listed at $0x6b0808
//          |/
//          |
//          |+0x8FC - [32-bit Pointer{2}]
//          |+| - This Pointer{2} is only functional during a Showdown match
//          |+|
//          |+|+0x50 - [584-byte Array] List of [(4x) 92-byte Struct:Player_Settings]
//          |+|¨| - Documentation at $0x740438
//          |+|/
//          |+|+0x1C8 - [28-byte Struct] ShowdownMode_Settings
//          |+|¨| - Documentation at $0x7405b0
//          |/
//          |
//          |+0x5874 - [140-byte Struct] Cash_HUDController
//          |¨[Struct Definition][140-byte] Cash_HUDController
//          |¨|''''''''''''''''''''''''''''''''''''''''''''''''''
//          |¨| - Controls cash HUD display in the bottom-right
//          |¨|
//          |¨|+0x8 - [32-bit] Cash/Bounty (functional)
//          |¨|¨| - Stored as a signed integer, max properly displayable value on the HUD is 0xF423F (=999 999)
//          |¨|/
//          |¨|+0xC - [32-bit] Cash Acquired By Other Means
//          |¨|¨| - Cash picked up on ground or through other ways other than killing/hitting enemies??
//          |¨|/
//          |¨|+0x10 - [32-bit] Combo (= Cash Awarded for Hitting Targets)
//          |¨|
//          |¨|+0x14 - [32-bit] Combo Multiplier
//          |¨|¨| - Increases by 1 for each kill, resets to 1 once the combo is over/cash is awarded
//          |¨|/
//          |¨|+0x20 - [32-bit Float] Combo Countdown Timer
//          |¨|¨| - Timer starts at 3.5; Goes down by about 0.04 each 2 frames (might be different depending on PAL/NTSC mode)
//          |¨|/
//          |¨|+0x30 - [32-bit] Cash/Bounty (copy)
//          |/
//          |
//          |+0x5904 - [20-byte Array] List of [(5x) Bit Flag {32-bit}: Is_Key_Displayed]
//          |¨[Array Definition][20-byte]
//          |¨|°°°°°°°°°°°°°°°°°°°°°°°°°
//          |¨| - This array contains bit flags correlating to the HUD display icons for the keys.
//          |¨| - Functional key bit flags are stored via $0x753AB0
//          |¨|
//          |¨|+0x0 - [Bit Flag: Is_Key_Displayed] Key 1
//          |¨|¨|[Bit Flag Definition][bit 0 {32-bit}] Is_Key_Displayed
//          |¨|¨|'''''''''''''''''''''''''''''''''''''''
//          |¨|¨| bit 0 = 1 => Key IS rendered/displayed on the HUD
//          |¨|¨| bit 0 = 0 => Key NOT rendered/displayed on the HUD
//          |¨|/
//          |¨|+0x4 - [Bit Flag: Is_Key_Displayed] Key 2
//          |¨|+0x8 - [Bit Flag: Is_Key_Displayed] Key 3
//          |¨|+0xC - [Bit Flag: Is_Key_Displayed] Key 4
//          |¨|+0x10 - [Bit Flag: Is_Key_Displayed] Key 5
//          |/
//          °
//          
//          [Struct Definition][1916-byte??] Showdown_PosterMenu_Controller
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+0x48 - [32-bit Pointer{1}]
//          |++0xFD - [Bit Flag {8-bit}] bit 0 => Is ShowdownPosterMenu Displayed
//          |
//          |+0x7C - [32-bit Pointer{1}] --(+0x0)--> [480-byte Struct: Showdown_Character_Select_Data_A] Player 1
//          |+0x80 - [32-bit Pointer{1}] --(+0x0)--> [480-byte Struct: Showdown_Character_Select_Data_A] Player 2
//          |+0x84 - [32-bit Pointer{1}] --(+0x0)--> [480-byte Struct: Showdown_Character_Select_Data_A] Player 3
//          |+0x88 - [32-bit Pointer{1}] --(+0x0)--> [480-byte Struct: Showdown_Character_Select_Data_A] Player 4
//          |[Struct Definition][480-byte] Showdown_Character_Select_Data_A
//          ||'''''''''''''''''''''''''''''''''''''''''''''''''''''''
//          ||+0xFD - [Bit Flag {8-bit}] bit 0 => Is Player Slot Filled
//          ||+0x13D - [3-byte ASCII] Character_Model_ID
//          |'
//          |
//          |+0x46C - [32-bit Pointer{1}]
//          |+|+0x164 - [16-byte Array] List of [(4x) 8-bit {32-bit}] Showdown_Character_Select_Index
//          |+|¨[Array Definition][16-byte]
//          |+|¨|''''''''''''''''''''''''
//          |+|¨| - Showdown_Character_Select_Index for the array directly noted below, to identify the selected character (Showdown_Character_Select_Data_B)
//          |+|¨| - Changing these indices to valid IDs will load that character for that player
//          |+|¨| - If not all characters are unlocked in the array for Showdown_Character_Select_Data_B, this index only starts counting from the ones which are unlocked (eg. Character "Pig" Josh is index 0, but if he's not unlocked index 0 will be the index for the next character in that array which is unlocked. And index 1 will be the next character in the array which is unlocked and so on...)
//          |+|¨| - Identification via this way, is unavailable with current RAlogic (31 may 2024).
//          |+|¨|
//          |+|¨|+0x0 - [8-bit {32-bit}] Showdown_Character_Select_Index - Player 1
//          |+|¨|+0x4 - [8-bit {32-bit}] Showdown_Character_Select_Index - Player 2
//          |+|¨|+0x8 - [8-bit {32-bit}] Showdown_Character_Select_Index - Player 3
//          |+|¨|+0xC - [8-bit {32-bit}] Showdown_Character_Select_Index - Player 4
//          |+|/
//          |+|
//          |+|+0x190 - [190-byte Array] List of [(48x) 32-bit Pointer{2}] --(+0x0)--> [48-byte Struct] Showdown_Character_Select_Data_B_B
//          |+|+[Struct Definition][48-byte] Showdown_Character_Select_Data_B
//          |+|+|''''''''''''''''''''''''''''''
//          |+|+| - This is where the functional data is stored for loading the correct character
//          |+|+|
//          |+|+|+0x1 - [3-byte ASCII] Showdown_Character_Select_ID (string)
//          |+|+|¨| - Preceding [1-bye ASCII] = "y"
//          |+|+|/
//          |+|+|+0x29 - [Bit Flag] bit 0 => Is Character Locked
//          |+|+|¨| bit 0 = 0 => character unlocked, available to choose
//          |+|+|¨| bit 0 = 1 => character locked, unavailable to choose
//          |+|+|/
//          |+|+|+0x2C - [8-bit {32-bit}] Showdown_Character_Select_ID (numerical)
//          |/
//          |
//          |+0x504 - [304-byte Array] List of [(4x) 76-byte Struct:Showdown_Character_Select_UI_Data]
//          |¨| - This array contains one struct for each player
//          |¨|
//          |¨|[Struct Definition][76-byte] Showdown_Character_Select_UI_Data
//          |¨||''''''''''''''''''''''''''''''
//          |¨||+0x4 - [Lower4 {32-bit}] Player Number
//          |¨||¨| - Value range [0-3]
//          |¨||/
//          |¨||+0x10 - [32-bit Pointer{1}]
//          |¨||++0x130 - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] Character_HeadshotImage_Data
//          |¨||++|+0x3C - [16-bit] Character_HeadshotImage_ID
//          |¨||++|¨| - This controls which character's image of the head is shown
//          |¨||++|¨| - Character_HeadshotImage_IDs listed below
//          |¨||/
//          |¨||
//          |¨||+0x34 - [32-bit Pointer{1}]
//          |¨||+|+0x13D - [3-byte ASCII] Character_Model_ID (string)
//          |¨||+|¨| - This value controls the which character's name is displayed under the headshot image
//          |¨||+|¨| - Character_Model_IDs listed below
//          |/
//          |
//          |+0x53C - [8-bit {32-bit}] Showdown_Player_Team_ID - Player 1
//          |¨| 0 => Team Red
//          |¨| 1 => Team White
//          |¨| 2 => Team Blue
//          |¨| 3 => Team Yellow
//          |+0x588 - [8-bit {32-bit}] Showdown_Player_Team_ID - Player 2
//          |+0x5D4 - [8-bit {32-bit}] Showdown_Player_Team_ID - Player 3
//          |+0x620 - [8-bit {32-bit}] Showdown_Player_Team_ID - Player 4
//          '
//          
//          # Character_Model_IDs (string) - Character_HeadshotImage_IDs
//          |(listed in order of appearance in showdown poster menu, from top-left to bottom-right)
//          |=========================================
//          |---- Unlockable Showdown Characters (list complete) ----
//          | pgj - 0x2401 => "Pig" Josh
//          | tcb - 0x24CD => Holstein Hal
//          | pry - 0x2489 => Professor Perry
//          | bwi - 0x2445 => "The Blade" Slade
//          | hdh - 0x2511 => "Hedghehog" Thornton
//          | sto - 0x25DD => "Sissy" Fess
//          | wsk - 0x2555 => "Whiskey" Treadwell
//          | aka - 0x2599 => "Smiley" Fawler
//          | ugl - 0x26A9 => "Ugly" Chris
//          | ggl - 0x2665 => "Gigolo" Hancock
//          | zzt - 0x2621 => Gabriel Navarro
//          | gwk - 0x26ED => "Dig" Fowler
//          | tck - 0x27B9 => Sam
//          | bdg - 0x2775 => Dan
//          | mok - 0x2731 => Manny Quinn
//          | mst - 0x27FD => Grizzly
//          | mrk - 0x2841 => Mr. Kelley
//          | bkt - 0x2885 => Cooper
//          | ydr - 0x28C9 => Colonel Daren
//          | mon - 0x290D => Udo Kang
//          | bfs - 0x2951 => Buffalo
//          | dad - 0x29D9 => Nate Harlow
//          | mom - 0x2A1D => Falling Star
//          | twg - 0x2995 => "Twiggy" Phelps
//          | ttk - 0x2A61 => Shadow Wolf
//          | jck - 0x2AA5 => Jack Swift
//          | mdg - 0x2AE9 => Fidgit
//          | wyn - 0x2B2D => Governor Griffon
//          | bra - 0x2B71 => Rico Pedrosa
//          | shp - 0x2BB5 => "Curly" Shaw
//          | blk - 0x2BF9 => Mr. Black
//          | msk - 0x2C3D => Standing Snake
//          | ntl - 0x2C81 => Natalie
//          | mrd - 0x2D09 => Red Jr.
//          | chk - 0x2CC5 => Chicken
//          | dgo - 0x2D4D => General Diego
//          | cls - 0x2D91 => Sheriff O'Grady
//          | kti - 0x2E19 => Katie O'Grady
//          | ncb - 0x2DD5 => Smitty
//          | bty - 0x2E5D => Bad Bessie
//          | srd - 0x2EA1 => Red
//          | ani - 0x2EE5 => Annie Stoakes
//          | sev - 0x2F29 => Jason Cornet
//          | kng - 0x3039 => Sheriff Bartlett
//          | gay - 0x2FF5 => "Bloody" Tom
//          | frk - 0x2FB1 => "Big Oaf" Whitney
//          | ctn - 0x307D => Christina
//          | ent - 0x2F6D => "Kid" Cougar
//          |
//          |---- Non-Playable Characters (list incomplete) ----
//          | frj => George (unplayable character of bossfight trio, fight againt "Bloody" Tom, during lvl_hng)
//          | snp => Sniper NPC, which usually spawns on high ground; Wears a Raccoon hat
//          '
// $563FA0: [NTSCJ][32-bit Pointer{1}] --> Showdown Mode Settings
//          |+0x6c - [32-bit Pointer{2}]
//          |++0x50 - [32-bit Pointer{3}] --(+0x0)--> [??-byte Struct] ShowdownMode_Settings
//          |++[Struct Defintion][NTSCJ][??-byte Struct] ShowdownMode_Settings
//          |++|'''''''''''''''''''''''''''''''''''''''''''''
//          |++|+0x1290 - [8-bit {32-bit}] Sundown Mode | Fight Time Setting
//          |++|"| 0 => 3 min.
//          |++|"| 1 => 5 min.
//          |++|"| 2 => 10 min.
//          |++|"| 3 => 15 min.
//          |++|"| 4 => 1 min.
//          |++|/
//          |++|+0x4B60 - [8-bit {32-bit}] Powers Ups Setting
//          |++|"| 0 => Off
//          |++|"| 1 => Stud
//          |++|"| 2 => Hold 'Em
//          |/
//          '
// $6AAA9C: [NTSCU][8-bit Bitfield {32-bit}] Area State
//          @Regional equivalent of $0x6b0a1c (PAL)
// $6B03F4: [PAL][32-bit Pointer{1}] --> Soundtrack File Name
//          |@Member of Struct:Undefined_Struct_02 ($0x4fa50c)
//          |
//          |+0xC - [32-bit Pointer{2}]
//          |+| - Pointer{2} is only functional when a soundtrack is active
//          |+|
//          |+|+0x0 - [Variable Size ASCII] Active SoundtrackFileName_ID
//          |+|¨| - Currently playing soundtrack file
//          |/
//          '
// $6B0808: [PAL][Variable Size ASCII] Area_ID (alt)
//          - This value stores the Area_ID for the current map/level
//          - Be wary to check only the necessary bytes to identify the Area_ID, don't count the succeeding bytes as there's some bogus data
//          - Changing this value to a valid ID does not work to cheat/load the map
//          - IDs listed at $0x7a0620
// $6B0A1C: [PAL][8-bit Bitfield {32-bit}] Area State
//          - These value's also work for the main menu; as the main menu is an Area_ID (= lvl_front)
//          0x2 => In-game (playing in the loaded area/map)
//          0x32 => Area_ID is on standby
//          0xFF => Loading new Area_ID
// $6B0C99: [PAL][Bit Flag (8-bit] bit 0 => Is In-Game (alt)
// $6B0C9A: [PAL][Bit Flag {8-bit}] bit 0 => Is No In-Mission Shop Open
//          - In-Mission Shop = shop which is opened once the mission/level has already started. The Preceding Byte Bit Flag is 1 (eg. Chapter 2 'Bounty Hunter', shop opens just after intro cutscene OR shops in Brimstone)
//          0 => In-Mission shop is open
//          1 => No In-Mission shop is open
// $6B18B4: [PAL][1024-byte ASCII Field] ShowdownMode_ScoreboardDisplay_Text
//          =========================================
//          @Fixed Memory Location
//          - The data stored in this ASCII Field is used in the display of the showdown mode scoreboard
//          - ASCII Field only updates/should be used when the scoreboard is displayed, otherwise these 1024-bytes may in use by other data
//          - Dynamic number values (eg. Bounty, Shots missed) are calculated or copied from data stored at $0x7638b8
//          - Changing these values will update the corresponding text on the scoreboard
// $6B1A30: [PAL][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 1
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          
//          [ASCII Field Definition][96-byte] ShowdownPlayer_Stats_Text
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x5 - [7-byte ASCII] Bounty/Cash
//          |"| - Documentation at $0x6b1a35
//          |
//          |+0xC - [7-byte ASCII] Death Toll (Enemy kill count)
//          |"| - Documentation at $0x6b1a3c
//          |
//          |+0x14 - [7-byte ASCII] Damage Taken
//          |"| - Documentation at $0x6b1a44
//          |
//          |+0x1C - [3-byte ASCII] Shots Fired
//          |"| - Documentation at $0x6b1a4c
//          |
//          |+0x24 - [3-byte ASCII] Shots Missed
//          |"| - Documentation at $0x6b1a54
//          |
//          |+0x2D - [7-byte ASCII] Best Combo
//          |"| - Documentation at $0x6b1a5d
//          |
//          |+0x34 - [3-byte ASCII] Head Shots
//          |"| - Documentation at $0x6b1a64
//          |
//          |+0x3C - [3-byte ASCII] Body Shots
//          |"| - Documentation at $0x6b1a6c
//          |
//          |+0x44 - [3-byte ASCII] Arm Shots
//          |"| - Documentation at $0x6b1a74
//          |
//          |+0x4C - [3-byte ASCII] Leg Shots
//          |"| - Documentation at $0x6b1a7c
//          |
//          |+0x54 - [3-byte ASCII] Back Shots
//          |"| - Documentation at $0x6b1a87
//          |
//          |+0x5C - [3-byte ASCII] Melee Hits
//          |"| - Documentation at $0x6b1a8c
// $6B1A35: [PAL][7-byte ASCII] Player 1 - Bounty/Cash
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
//          - Preceding [1-byte ASCII] = "$"
// $6B1A3C: [PAL][3-byte ASCII] Player 1 - Death Toll (Enemy kill count)
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A44: [PAL][7-byte ASCII] Player 1 - Damage Taken
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
//          - Succeeding [1-byte ASCII] = "%"
//          - This value is calculated from 'Player_Stats Total Damage Taken', using formula: (dmgTaken/MaxHP)*100; where default MaxHP = 150.0
// $6B1A4C: [PAL][3-byte ASCII] Player 1 - Shots Fired
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A54: [PAL][3-byte ASCII] Player 1 - Shots Missed
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A5D: [PAL][7-byte ASCII] Player 1 - Best Combo
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
//          - Preceding [1-byte ASCII] = "$"
// $6B1A64: [PAL][3-byte ASCII] Player 1 - Head Shots
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A6C: [PAL][3-byte ASCII] Player 1 - Body Shots
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A74: [PAL][3-byte ASCII] Player 1 - Arm Shots
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A7C: [PAL][3-byte ASCII] Player 1 - Leg Shots
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A87: [PAL][3-byte ASCII] Player 1 - Back Shots
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A8C: [PAL][3-byte ASCII] Player 1 - Melee Hits
//          @Member of Struct: Player_Stats_Text - Player 1 ($0x6b1a30)
// $6B1A90: [PAL][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 2
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $6B1AF0: [PAL][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 3
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $6B1B50: [PAL][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 4
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $6B3588: [NTSCJ][Variable Size ASCII] Area_ID (alt)
//          @Regional equivalent of $0x6b0808
// $6B4634: [NTSCJ][1024-byte ASCII Field] ShowdownMode_ScoreboardDisplay_Text
//          @Regional Equivalent of $0x6b18b4
// $6B47B0: [NTSCJ][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 1
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b4634)
//          @Regional Equivalent of $0x6b1a30
// $6B4810: [NTSCJ][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 2
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b4634)
//          @Regional Equivalent of $0x6b1a90
// $6B4870: [NTSCJ][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 3
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b4634)
//          @Regional Equivalent of $0x6b1af0
// $6B48D0: [NTSCJ][96-byte ASCII Field] ShowdownPlayer_Stats_Text - Player 4
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b4634)
//          @Regional Equivalent of $0x6b1b50
// $73AF04: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] InGame_Menu_Controller
//          @Regional equivalent of $0x73d684 (PAL)
// $73B099: [NTSCU][1344-byte Array] List of [(4x) 336-byte Struct:ShowdownPlayer_Settings_B]
//          @Regional equivalent of $0x73d819 (PAL)
// $73B5EC: [NTSCU][8-bit {32-bit}] Number of Players
//          @Regional equivalent of $0x73dd6c (PAL)
// $73B7C2: [NTSCU][30-byte Struct] Player_Input_Reader
//          @Regional equivalent of $0x73df42 (PAL)
// $73D60C: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] InGame_Menu_Controller (MainMenu)
//          @Fixed Memory Location. Although pointed to by one of the pointers at [$0x562a20-$0x562a60]
//          - Pointer is only functional when an InGame_Menu has been displayed at least once
//          - This pointer only changes value whenever the pauseMenu, RetryMenu/continueMenu or GameOverScreen is rendered (aka the "main menu's")
//          - SubMenu's can't be Identified via this pointer, prefer using pointer at $0x73d684
// $73D684: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] InGame_Menu_Controller (preferred)
//          @Fixed Memory Location. Although pointed to by one of the pointers at [$0x562a20-$0x562a60]
//          - Pointer{1} is only functional when an InGame_Menu has been displayed at least once
//          
//          [Struct Definition][??-byte] InGame_Menu_Controller
//          |============================================
//          |+0x18 - [Variable size ASCII] InGame_Menu_ID
//          |¨| - IDs listed below
//          |/
//          |+0x38 - [Bit Flag {8-bit}] bit 0 => Is InGameMenu Active
//          |¨| 1 => InGameMenu is displayed
//          |¨| 0 => InGameMenu not displayed
//          |/
//          |+0x39 - [Bit Flag {8-bit}] bit 0 => Is SubMenu NOT Displayed
//          |¨| 1 => No SubMenu displayed
//          |¨| 0 => Any SubMenu is displayed
//          |/
//          |+0x3C - [28-byte Array] List of [(7x) 32-bit Pointer{2}]
//          |¨| - Some of these pointers point to structs storing ASCII text which are used as the displaytext for the Retry Menu
//          |/
//          |+0x318 - [8-bit] Highlighted_MenuItem_ID
//          |¨| - MenuItem_IDs are dependent on InGame_Menu_ID
//          |/
//          |+0x450 - [32-bit Float] Retry Countdown Timer
//          |¨| - Value range [9.9-0.0]; When this hits 0 --> 'Game Over' screen
//          |¨| - Decrements each frame
//          |¨| - This value in only functional when the RetryMenu is rendered
//          |/
//          '
//          
//          # InGame_Menu_IDs (string) - Highlighted_MenuItem_IDs
//          |(list incomplete)
//          |'''''''''''''''''
//          | pause (InGame_Menu_ID) = PauseMenu
//          | - 0x4 (Highlighted_MenuItem_ID) => Return to Game
//          | - 0x5 => Options
//          | - 0x9 => Restart Level
//          | - 0xA => Quit
//          | continue = RetryMenu
//          | - 0x5 => No
//          | - 0x4 => Yes
//          | gameover = GameOverScreen
//          | warning => PauseMenu->YesNoConfirmationMenu (opened when quiting or restarting level)
//          | - 0x3 => No
//          | - 0x4 => Yes
//          | gameoptions => PauseMenu->OptionsMenu
//          | lvl_coach_LEVEL_MAP => PauseMenu->MapMenu (for lvl_coach)
//          | gameplayeropt => PauseMenu->OptionsMenu->PlayerOptionsMenu
//          | gamepicture => PauseMenu->OptionsMenu->PictureOptionsMenu
//          | gamesound => PauseMenu->OptionsMenu->SoundOptionsMenu
//          | cheats => PauseMenu->CheatsMenu
//          '
// $73D819: [PAL][1344-byte Array] List of [(4x) 336-byte Struct:ShowdownPlayer_Settings_B]
//          @Fixed Memory Location. Although pointed to by $0x562a20
//          - This array is populated on start of a Showdown match
//          
//          [Struct Definition][336-byte] ShowdownPlayer_Settings_B
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - Very similar to Struct:ShowdownPlayer_Settings_A ($0x740438)
//          |
//          |+0x1 - [3-byte ASCII] Character_Model_ID
//          |¨| - Preceding [1-byte ASCII] = "m"; This "m" is removed when no player fills this player slot
//          |¨| - IDs listed at $0x562a20
//          |/
//          +0xB- [Lower4 {32-bit}] Team_ID
//          |¨| 0 =&gt; Team Red
//          |¨| 1 =&gt; Team White
//          |¨| 2 =&gt; Team Blue
//          |¨| 3 =&gt; Team Yellow
//          |/
//          +0xF - [Lower4 {32-bit}] Player Number
//          |¨| - Value range [0-3]
//          |/
//          |+0x13 - [Bit Flag {32-bit}] bit 0 =&gt; Is Player Slot filled
//          |
//          |+0x139 - [Variable Size ASCII] ShowdownAI_Setting
//          |¨| - ShowdownAI_Settings listed below
//          |/
//          '
//          
//          # ShowdownAI_Settings (string)
//          |(list incomplete)
//          |''''''''''''''''''''''''''''''
//          | MPplayer =&gt; no AI, Human player controlled
//          | defaultbot
//          | bigbot
//          | pixiebot
//          | sniperbot
//          | sneakybot
//          | ...??
//          '
// $73DCB8: [NTSCU][365-byte Array] List of [(4x) 92-byte Struct:ShowdownPlayer_Settings_A]
//          @Regional equivalent of $0x740438 (PAL)
// $73DD6C: [PAL][8-bit {32-bit}] Number of Players
//          - 0x1 => Single player campaign
//          - [0x2-0x4] => Showdown Mode
//          - This value does not reset to a default value on title screen
// $73DE30: [NTSCU[28-byte Struct] ShowdownMode_Settings
//          @Regional equivalent of $0x7405b0 (PAL)
// $73DE4C: [NTSCU][28-byte Bitset] Shared_Unlocks
//          @Regional equivalent of $0x7405cc (PAL)
// $73DE88: [NTSCU][17040-byte Array] List of [(6x) 2840-byte Struct:Player_Profile_Data]
//          @Regional equivalent of $0x740608 (PAL)
// $73DF42: [PAL][30-byte Struct] Player_Input_Reader
//          [Struct Definition][30-byte] Player_Input_Reader
//          |'''''''''''''''''''''''''''''''''''''''
//          | - Flags are inverted: bitValue = 1 -> button not pressed; bitValue = 0 -> button is pressed
//          |
//          |+0x0 - [Inverted Bit Flags] Player Input A - Buttons Pressed
//          |¨| bit 0 => Select
//          |¨| bit 1 => L3
//          |¨| bit 2 => R3
//          |¨| bit 2 => Start
//          |¨| bit 4 => D-pad up
//          |¨| bit 5 => D-pad right
//          |¨| bit 6 => D-pad down
//          |¨| bit 7 => D-pad left
//          |/
//          |+0x1 - [Inverted Bit Flags] Player Input B - Buttons Pressed
//          |¨| bit 0 => L2
//          |¨| bit 1 => R2
//          |¨| bit 2 => L1
//          |¨| bit 3 => R1
//          |¨| bit 4 => 🛆
//          |¨| bit 5 => ◌
//          |¨| bit 6 => X
//          |¨| bit 7 => ⬚
//          |+0x2 - [16-bit] Right-Joystick Angle + Tilt
//          |+0x4 - [16-bit] Left-Joystick Angle + Tilt
// $73ED98: [NTSCJ][1344-byte Array] List of [(4x) 336-byte Struct:ShowdownPlayer_Settings]
//          @Regional Equivalent of $0x73d819
// $73F2EC: [NTSCJ][8-bit {32-bit}] Number of Players
//          @Regional Equivalent of $0x73dd6c
// $740118: [NTSCJ][17040-byte Array] List of [(6x) 2840-byte Struct:Player_Profile_Data]
//          @Regional Equivalent of $0x740608
//          @Fixed Memory Location. Although pointed to by $0x7443e8
// $740438: [PAL][365-byte Array] List of [(4x) 92-byte Struct:ShowdownPlayer_Settings_A]
//          @Fixed Memory Location. Although pointed to by $0x562a20
//          - This array is populated on start of a Showdown match, each player has an entry
//          - This array is also populated in Single Player Campaign, with one (first) entry for the controlled character in the mission
//          
//          [Struct Definition][92-byte] ShowdownPlayer_Settings_A
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - Very similar to Struct:ShowdownPlayer_Settings_B ($0x73d819)
//          |
//          |+0x0 - [Lower4 {32-bit}] Team_ID
//          |¨| 0 => Team Red
//          |¨| 1 => Team White
//          |¨| 2 => Team Blue
//          |¨| 3 => Team Yellow
//          |¨| F => Player Slot is Empty (whole 32-bit value is 0xFFFFFFFF)
//          |/
//          |+0x5 - [3-byte ASCII] Character_Model_ID
//          |¨| - Preceding [1-byte ASCII] = "m" (for multiplayer)
//          |¨| - IDs listed at $0x562a20
//          |/
//          |+0x36 - [Variable Size ASCII] ShowdownAI_Setting
//          |¨| - This is only populated in a Showdown match
//          |¨| - ShowdownAI_Settings listed at $0x73d819
//          |/
//          '
// $7405B0: [PAL][28-byte Struct] ShowdownMode_Settings
//          @Fixed Memory Location. Although pointed to by $0x562a20 AND $0x7448a0
//          
//          [Struct Defintion][28-byte] ShowdownMode_Settings
//          |''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [Lower4 {32-bit}] Game Mode
//          |"| 0 => Bounty Hunter (achieve bounty/cash target)
//          |"| 1 => Sundown (most bounty/cash at end of timer)
//          |"| 2 => High Noon (standoff/face-off)
//          |/
//          |+0x4 - [Lower4 {32-bit}] Bounty Hunter Mode | Bounty Limit Setting
//          |"| - Functional bounty limit amount is stored at $0x7448a8
//          |"| 0 => 3 000
//          |"| 1 => 5 000
//          |"| 2 => 10 000
//          |"| 2 => 15 000
//          |"| 4 => 20 000
//          |/
//          |+0x8 - [Lower4 {32-bit}] Sundown Mode | Fight Time Setting
//          |"| - Functional Fight Time Timer through $0x562a30
//          |"| 0 => 3 min.
//          |"| 1 => 5 min.
//          |"| 2 => 10 min.
//          |"| 3 => 15 min.
//          |"| 4 => 1 min.
//          |/
//          |+0xC - [Lower4 {32-bit}] High Noon Mode | Number of Wins Setting
//          |"| 0 => 3 wins
//          |"| 1 => 5 wins
//          |"| 2 => 7 wins
//          |"| 3 => 10 wins
//          |"| 4 => 1 wins
//          |/
//          |+0x18 - [Lower4 {32-bit}] Powers Ups Setting
//          |"| 0 => Off
//          |"| 1 => Stud
//          |"| 2 => Hold 'Em
//          |/
//          '
// $7405CC: [PAL][28-byte Bitset] Shared_Unlocks
//          @Fixed Memory Location. Although pointed to by $0x7448a0
//          - This bitset is updated on save according to the bitset Player_Profile_Unlocks ($0x763070)
//          - This bitset handles unlocks for cheats, showdown characters, showdown maps and journal pages
//          
//          [PAL][2-byte Bitset] Cheat_Unlocks (7 unlockable flags + 3 non-unlockable flags)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cd
//          
//          [PAL][Bit Flags] @Byte1 in Bitset Cheat_Unlocks 0x7405cc
//          bit 0 =&gt; Cheat (non-unlockable debug feature) - Big Money (gain $10 000)
//          bit 1 =&gt; Cheat - Golden Gun (significantly increases damage vs AI)
//          bit 2 =&gt; Cheat - Infinite Deadeye
//          bit 3 =&gt; Cheat - Invincibility
//          bit 4 =&gt; Cheat (non-unlockable debug feature) - Show AI Info (doesn't work out-of-the-box)
//          bit 5 =&gt; Cheat (non-unlockable debug feature) - Show Player Position (doesn't work out-of-the-box)
//          bit 6 =&gt; Cheat - Bite the Bullet (hardcore mode, significantly increases damage vs player and AI)
//          bit 7 =&gt; Cheat - Sad Stars (replaces blood splatters with a special effect)
// $7405CD: [PAL][19-byte Bitset] JournalPage_Unlocks (137 flags total)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cc
//          - This bitset handles the unlocks for journal pages
//          
//          [PAL][Bit Flags]
//          @Byte2 in Bitset: Cheat_Unlocks $0x7405cc
//          @Byte1 in Bitset: JournalPage_Unlocks $0x7405cc
//          ---- Cheats ----
//          bit 0 => Cheat - No HUD
//          bit 1 => Cheat - No Distortion
//          ---- JournalPages ----
//          bit 2 => Outlaws in Twelve States - Smiley Fawler
//          bit 3 => Outlaws in Twelve States - Bandito
//          bit 4 => Heroes of the Frontier - Annie
//          bit 5 => Ranged Weapons - Bayonet Rifle
//          bit 6 => Wanted Dead or Alive - Dan
//          bit 7 => Heroes of the Frontier - Buffalo
// $7405CE: [PAL][Bit Flags] @Byte2 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Outlaws in Twelve States - Cooper
//          bit 1 => Citizens of the Wilderness - Black Elk Tribe
//          bit 2 => Wanted Dead or Alive - Mr. Black
//          bit 3 => Good People of Brimstone - Cheryl-Lynn
//          bit 4 => Wanted Dead or Alive - Rico Pedrosa
//          bit 5 => Wanted Dead or Alive - Roberto Pedrosa
//          bit 6 => Prof. Perry's Peculiarities - Asada
//          bit 7 => Ranged Weapons - Breech Loader
// $7405CF: [PAL][Bit Flags] @Byte3 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Protectors of Brimstone - Sergeant Marquez
//          bit 1 => Citizens of the Wilderness - Fred Kenyon
//          bit 2 => /
//          bit 3 => Wanted Dead or Alive - Bad Bessie
//          bit 4 => Prof. Perry's Peculiarities - Clyde Slade
//          bit 5 => Citizens of the Wilderness - Running Moon
//          bit 6 => Ugly Chris Gang - Chicken
//          bit 7 => Citizens of the Wilderness - Sheriff O'Grady
// $7405D0: [PAL][Bit Flags] @Byte4 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Good People of Brimstone - Christina
//          bit 1 => Memories of the Past - Falling Star + Young Red Harlow + Nate Harlow (unlocks 3 pages, but this bit flag effectively counts for: Nate Harlow)
//          bit 2 => /
//          bit 3 => Renegade Army - General Javier Diego
//          bit 4 => /
//          bit 5 => Thrown Weapons - Dynamite
//          bit 6 => Battle Royale Contestants - Kid Cougar
//          bit 7 => Ranged Weapons - Escopeta
// $7405D1: [PAL][Bit Flags] @Byte5 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Wanted Dead or Alive - Loaf Whitney
//          bit 1 => Wanted Dead or Alive - Greg 'Big Oaf' Whitney
//          bit 2 => Wanted Dead or Alive - Bloody Tom
//          bit 3 => Ugly Chris Gang - Whiskey
//          bit 4 => Prof. Perry's Peculiarities - Lightning Larouche
//          bit 5 => /
//          bit 6 => Outlaws in Twelve States - Gordon "Digs" Fowler
//          bit 7 => Ranged Weapons - Halcon Rifle
// $7405D2: [PAL][Bit Flags] @Byte6 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Ugly Chris Gang - Hedgehog
//          bit 1 => Ranged Weapons - High Caliber
//          bit 2 => Wanted Dead or Alive - Harry 'Hatchet' Schultz
//          bit 3 => /
//          bit 4 => /
//          bit 5 => Side Arms - Inquisitor
//          bit 6 => /
//          bit 7 => Heroes of the Frontier - Jack Swift
// $7405D3: [PAL][Bit Flags] @Byte7 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Good People of Brimstone - Jody
//          bit 1 => Wanted Dead or Alive - Jesse Lynch
//          bit 2 => Protectors of Brimstone - Sherrif Bartlett
//          bit 3 => Thrown Weapons - Knife
//          bit 4 => Citizens of the Wilderness - Katie O'Grady
//          bit 5 => Renegade Army - The Duellist
//          bit 6 => Frontier Places - Brimstone Saloon
//          bit 7 => Frontier Places - Border Bridge
// $7405D4: [PAL][Bit Flags] @Byte8 in Bitset: JournalPage_Unlocks $0x7405cd
//          ---- Frontier Places ----
//          bit 0 => Sunset Canyon
//          bit 1 => The Jail
//          bit 2 => Fort Diego
//          bit 3 => Fairgrounds
//          bit 4 => Tarnation
//          bit 5 => Twin Rocks
//          bit 6 => Mansion
//          bit 7 => Broken Creek
// $7405D5: [PAL][Bit Flags] @Byte9 in Bitset: JournalPage_Unlocks $0x7405cd
//          ---- Frontier Places ----
//          bit 0 => Annie's Ranch
//          bit 1 => Widow's Patch
//          bit 2 => Widow's Patch, Night
//          bit 3 => Brimstone
//          bit 4 => Diego's Railroad
//          bit 5 => Pan-Atllantic Railroad
//          bit 6 => Bear Mountain
//          ---- Other ----
//          bit 7 => Prof. Perry's Peculiarities - The Clowns
// $7405D6: [PAL][Bit Flags] @Byte10 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Merchants of Brimstone - Manny Quinn
//          bit 1 => Thrown Weapons - Fire Bottle
//          bit 2 => Memories of the Past - Falling Star + Young Red Harlow (unlocks 2 pages, but this bit flag  effectively counts for: Falling Star)
//          bit 3 => Outlaws in Twelve States - Udo Kang
//          bit 4 => Memories of the Past - Falling Star + Young Red Harlow (unlocks 2 pages, but this bit flag  effectively counts for: Young Red Harlow)
//          bit 5 => Battle Royale Contestants - Mr. Kelley
//          bit 6 => Outlaws in Twelve States - Standing Snake
//          bit 7 => Citizens of the Wilderness - Grizzly
// $7405D7: [PAL][Bit Flags] @Byte11 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Outlaws in Twelve States - Smitty
//          bit 1 => Outlaws in Twelve States - Juan "Loco" Sanchez
//          bit 2 => Citizens of the Wilderness - Blind Willy Wilson
//          bit 3 => Good People of Brimstone - Jebidah Cole
//          bit 4 => Good People of Brimstone - Mathias Lampry
//          bit 5 => Good People of Brimstone - Sandy Dodge
//          bit 6 => Good People of Brimstone - Verne Wiggins
//          bit 7 => Good People of Brimstone - Abigail
// $7405D8: [PAL][Bit Flags] @Byte12 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Good People of Brimstone - Lily Belle
//          bit 1 => Renegade Army - Pvt. 'Ripper' Hernandez
//          bit 2 => Good People of Brimstone - Natalie
//          bit 3 => Side Arms - Old Pistol
//          bit 4 => Ranged Weapons - Oppressor
//          bit 5 => Ranged Weapons - Owl Rifle
//          bit 6 => Merchants of Brimstone - Doc Weatherby + Percy Merriweather (unlocks 2 pages)
//          bit 7 => Merchants of Brimstone - Carnaby Peabody
// $7405D9: [PAL][Bit Flags] @Byte13 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => /
//          bit 1 => Merchant of Brimstone - Ralph Clover
//          bit 2 => Merchant of Brimstone - Woodrow Klein
//          bit 3 => Merchant of Brimstone - Fitch
//          bit 4 => Merchant of Brimstone - Hanz Kenyon
//          bit 5 => Side Arms - Pacificador
//          bit 6 => Renegade Army - Pick Axe Miller
//          bit 7 => Outlaws in Twelve States - Father Driscoll
// $7405DA: [PAL][Bit Flags] @Byte14 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Prof. Perry's Peculiarities - Pig Josh
//          bit 1 => Outlaws in Twelve States - Bad Bob Larson
//          bit 2 => Prof. Perry's Peculiarities - Professor Perry
//          bit 3 => /
//          bit 4 => Citizens of the Wilderness - Red Wolf Tribe
//          bit 5 => Ranged Weapons - Repeater Rifle
//          bit 6 => Side Arms - Revolver
//          bit 7 => Outlaws in Twelve States - Jethro Greensleves
// $7405DB: [PAL][Bit Flags] @Byte15 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Prof. Perry's Peculiarities - Atlas Jones
//          bit 1 => Renegade Army - Lieutenant Cleu
//          bit 2 => /
//          bit 3 => Ranged Weapons - Sawn Off
//          bit 4 => Citizens of the Wilderness - Gabby Brennan
//          bit 5 => Side Arms - Scorpion
//          bit 6 => Renegade Army - Private Hanson
//          bit 7 => Protectors of Brimstone - Rat Chavez
// $7405DC: [PAL][Bit Flags] @Byte16 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Protectors of Brimstone - Mad Dog Jones
//          bit 1 => Protectors of Brimstone - The Cornet Brothers
//          bit 2 => Protectors of Brimstone - Jason Cornet
//          bit 3 => Renegade Army - Captain Bufias
//          bit 4 => Citizens of the Wilderness - Curly Shaw
//          bit 5 => Side Arms - Six Shooter
//          bit 6 => Thrown Weapons - Snake Oil
//          bit 7 => Outlaws in Twelve States - Jacques
// $7405DD: [PAL][Bit Flags] @Byte17 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Heroes of the Frontier - Red
//          bit 1 => Outlaws in Twelve States - Sidney "Sissy" Fess
//          bit 2 => Wanted Dead or Alive - Longhorn Luke
//          bit 3 => Wanted Dead or Alive - Holstein Hal
//          bit 4 => Wanted Dead or Alive - Sam
//          bit 5 => Citizens of the Wilderness - Hank Pullman
//          bit 6 => Ranged Weapons - The Lion
//          bit 7 => Heroes of the Frontier - Shadow Wolf
// $7405DE: [PAL][Bit Flags] @Byte18 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Ranged Weapons - Twelve Gauge
//          bit 1 => Outlaws in Twelve States - Twiggy Phelps
//          bit 2 => Side Arms - Twin Revolvers
//          bit 3 => Ugly Chris Gang - Ugly Chris
//          bit 4 => Side Arms - Widowmaker
//          bit 5 => Ugly Chris Gang - Gigolo
//          bit 6 => Protectors of Brimstone - Governor Griffon
//          bit 7 => Good People of Brimstone - Tameri
// $7405DF: [PAL][3-byte Bitset] ShowdownMap_Unlocks (13 flags total)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cc
//          - This bitset handles the unlocks for showdown maps
//          - The Xbox version may have 1 extra showdown map/stage
//          
//          [PAL][Bit Flags]
//          @Byte19 in Bitset: JournalPage_Unlocks $0x7405cd
//          @Byte1 in Bitset: ShowdownMap_Unlocks $0x7405df
//          ---- Journal Pages ----
//          bit 0 => Renegade Army - Colonel Daren
//          bit 1 => Ranged Weapons - Zwei Fasser
//          bit 2 => Outlaws in Twelve States - Oscar Navarro
//          bit 3 => Outlaws in Twelve States - Paul "Swig" Bennet
//          bit 4 => Battle Royale Contestant - Gabriel Navarro
//          ---- Showdown Maps ----
//          bit 5 => The Bridge - Contested Structure
//          bit 6 => Sunset Canyon - Desert Badlands
//          bit 7 => The Mine - Lost Inheritance
// $7405E0: [PAL][Bit Flags] @Byte2 in Bitset: ShowdownMap_Unlocks $0x7405df
//          bit 0 => Fallen Creek - Snow-topped Mountain
//          bit 1 => Desert Fortress - Giant Fortress
//          bit 2 => Fairground - Ruined Homestead
//          bit 3 => Ghost Town - Abandoned Settlement
//          bit 4 => Twin Rocks - Ancient Monoliths
//          bit 5 => The Mansion - Opulent Palace
//          bit 6 => /
//          bit 7 => Mansion Grounds - Tended Gardens
// $7405E1: [PAL][7-byte Bitset] ShowdownCharacter_Unlocks (48 flags total)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cc
//          - This bitset handles only the unlocks for showdown characters
//          
//          [PAL][Bit Flags]
//          @Byte3 in Bitset: ShowdownMap_Unlocks $0x7405df
//          @Byte1 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          ---- Showdown Maps ----
//          bit 0 => Broken Creek - Boyhood Home
//          bit 1 => The Ranch - Fertile Land
//          bit 2 => /
//          bit 3 => Widows Patch - Terrified Town
//          bit 4 => /
//          ---- Showdown Characters ----
//          bit 5 => "Smiley" Fawler
//          bit 6 => Annie Stoakes
//          bit 7 => Dan
// $7405E2: [PAL][Bit Flags] @Byte2 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => Buffalo
//          bit 1 => Cooper
//          bit 2 => Mr. Black
//          bit 3 => Rico Pedrosa
//          bit 4 => Bad Bessie
//          bit 5 => "The Blade" Slade
//          bit 6 => Chicken
//          bit 7 => Sheriff O'Grady
// $7405E3: [PAL][Bit Flags] @Byte3 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => Christina
//          bit 1 => Nate Harlow
//          bit 2 => General Diego
//          bit 3 => "Kid" Cougar
//          bit 4 => "Big Oaf" Whitney
//          bit 5 => "Bloody" Tom
//          bit 6 => "Gigolo" Hancock
//          bit 7 => "Dig" Fowler
// $7405E4: [PAL][Bit Flags] @Byte4 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => "Hedgehog" Thornton
//          bit 1 => Jack Swift
//          bit 2 => Sheriff Bartlett
//          bit 3 => Katie O'Grady
//          bit 4 => Fidgit
//          bit 5 => Manny Quinn
//          bit 6 => Falling Star
//          bit 7 => Udo Kang
// $7405E5: [PAL][Bit Flags] @Byte5 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => Red Jr.
//          bit 1 => Mr. Kelley
//          bit 2 => Standing Snake
//          bit 3 => Grizzly
//          bit 4 => Smitty
//          bit 5 => Natalie
//          bit 6 => "Pig" Josh
//          bit 7 => Professor Perry
// $7405E6: [PAL][Bit Flags] @Byte6 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => Jason Cornet
//          bit 1 => "Curly" Shaw
//          bit 2 => Red
//          bit 3 => "Sissy" Fess
//          bit 4 => Holstein Hal
//          bit 5 => Sam
//          bit 6 => Shadow Wolf
//          bit 7 => "Twiggy" Phelps
// $7405E7: [PAL][Bit Flags] @Byte7 in Bitset: ShowdownCharacter_Unlocks $0x7405e1
//          bit 0 => "Ugly" Chris
//          bit 1 => "Whiskey" Treadwell
//          bit 2 => Governor Griffon
//          bit 3 => Colonel Daren
//          bit 4 => Gabriel Navarro
//          bits [5-7] => /
// $740608: [PAL][17040-byte Array] List of [(6x) 2840-byte Struct:Player_Profile_Data]
//          @Fixed Memory Location. Although pointed to by $0x7448a0
//          - The active (or last used, on Main Menu) Player_Profile is pointed to by $0x7448d8
//          - Each Player_Profile has his own data storage
//          - Player_Profile_Data is updated on save/on end of missions
//          - Struct Definition Player_Profile_Data below
//          
//          [Array Definition][17040-byte] List of Player_Profile_Data
//          |''''''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [2840-byte Struct:Player_Profile_Data] Profile Slot 1
//          |+0xB18 - [2840-byte Struct:Player_Profile_Data] Profile Slot 2
//          |+0x1630 - [2840-byte Struct:Player_Profile_Data] Profile Slot 3
//          |+0x2148 - [2840-byte Struct:Player_Profile_Data] Profile Slot 4
//          |+0x2C60 - [2840-byte Struct:Player_Profile_Data] Profile Slot 5
//          |+0x3778 - [2840-byte Struct:Player_Profile_Data] Profile Slot 6
//          '
//          
//          [Struct Definition][2840-byte] Player_Profile_Data
//          |''''''''''''''''''''''''''''''''''''''''''
//          | - Some of these values are Player_Profile statistics which can be viewed in the Journal - Frontier Battles section
//          |
//          |+0x0 - [32-bit Float] Max HP
//          |¨| - This is the value which is read to initialize the HP at Game_Controller ($0x562a20) and the HP at SinglePlayer_Data ($0x763070)
//          |/
//          |+0x4 - [32-bit Float] Special Meter Max Gauge
//          |¨| - This is the value which is read to initialize the Special Meter Gauge at Game_Controller ($0x562a20)
//          |/
//          |+0x8 - [32-bit] Current Money/Cash
//          |¨| - This is the value which is read to initialize the Cash_HUDController at Game_Controller ($0x562a20)
//          |¨| - This value is updated on save
//          |/
//          |+0xC - [24-byte Bitset] Player_Profile_Unlocks
//          |¨| - This is a copy of the bitset stored via $0x763070, the bitset here is updated on save, based on that bitset
//          |¨| - Bitset Definition at $0x763070
//          |/
//          |+0x23C - [Variable Size ASCII] Furthest Completed Story Chapter (as Area_ID) (preferred)
//          |¨| - The first ASCII letter of the Area_ID may be zeroed out for this value (eg. "lvl_mansroof" => " vl_mansroof")
//          |/
//          |
//          |+0x28C - [32-bit] Story Mode - Retries
//          |
//          |+0x290 - [8-bit {16-bit}] Current Playthrough Difficulty (DifficultyStatModifier??)
//          |¨| - This value scales enemy and player stats to create differing difficulties for the current playthrough
//          |/
//          |+0x292 - [8-bit {16-bit}] Current Playthrough Difficulty (Difficulty_ID)
//          |¨| - This value determines which difficulty is selected for the current playthrough
//          |¨| - Changing this value manually mid playthrough, will change the difficulty on the next mission load
//          |¨| 0x0 => Normal
//          |¨| 0x1 => Hard
//          |¨| 0x2 => Very Hard
//          |¨| 0x3 => Red Wood Revolver
//          |/
//          |
//          |+0x294 - [32-bit] Story Mode - Enemies Killed A
//          |+0x298 - [32-bit] Story Mode - Enemies Killed B
//          |¨| - Formula: Total number of Enemies Killed (Story Mode) = Enemies Killed A + Enemies Killed B
//          |/
//          |+0x384 - [32-bit] Distance Travelled
//          |+0x388 - [32-bit Float] Time Spent Playing (in seconds)
//          |¨| - Max Float Value = 0x7F7FFFFF, does not overflow/reset back to 0, which is practically millions of billions of years
//          |¨| - This float value initializes the display value in the Journal as a signed int, which is probably why the max displayable value is 596523h 14m 07s
//          |¨| - This value is updated whenever the game saves/a mission is manually restarted via the pause menu/a mission is quit/prior to the retry menu being displayed
//          |/
//          |+0x39C - [32-bit] Total Money Collected
//          |+0x3A0 - [32-bit] Total Bullet Fired
//          |+0x3A4 - [32-bit] Total Bullet Hits
//          |+0x3BC - [32-bit] Total Money Spent
//          |+0x3B0 - [32-bit] Total Head Shots
//          |+0x3C8 - [32-bit] Number of DeadEye Abilities/Special Moves Used
//          |+0x3CC - [32-bit] Highest Combo Multiplier
//          |+0x3D0 - [32-bit Float] Highest Combo
//          |
//          |+0x611 - [Variable Size ASCII] Furthest Completed Story Chapter (as Area_ID) (alt)
//          |¨| - The first ASCII letter of the Area_ID may be zeroed out for this value (eg. "lvl_mansroof" => " vl_mansroof")
//          |/
//          |+0x7AC - [8-bit {32-bit}] bit 0 => Is Bounty Hunter Mode Unlocked
//          |¨| - Availability of this mode is only unlocked for this Player_Profile not the others once this Player_Profile has completed the story mode once
//          |/
//          |+0x7B8 - [8-bit {32-bit}] Unlocked Difficulties
//          |¨| - This value practically counts how many of the 4 difficulties are selectable when starting a 'New Game' (story campaign)
//          |¨| - These difficulties unlock by completing the story mode on lower difficulties, one by one (Very Hard and Red Wood Revolver are both unlocked by completion of Hard)
//          |¨| - Available difficulties are only unlocked for this Player_Profile not the others
//          |¨| 0x0 => Normal (No difficulty select available on 'New Game', defaults to Normal)
//          |¨| 0x1 => Normal, Hard
//          |¨| 0x2 => Normal, Hard, Very Hard
//          |¨| >= 0x3 => Normal, Hard, Very Hard, Red Wood Revolver
//          |/
//          |
//          |+0x7B0 - [4-byte Bitset] BountyHunterMissions_Completed
//          |¨[Bitset Definition][4-byte] BountyHunterMissions_Completed
//          |¨|'''''''''''''''''''''''''''''''''''''
//          |¨| - Each player profile saves his own Bounty Hunter Mode Data
//          |¨| - This bitset only updates on save after a successful Bounty Hunter Mission
//          |¨|
//          |¨|+0x0 - [Bit Flags] @Byte1 in Bitset:BountyHunterMissions_Completed
//          |¨|¨| bit 0 => Is Chapter 1 'Bull's Eye' Bounty Mission Completed
//          |¨|¨| bit 1 => Is Chapter 2 'Bounty Hunter' Bounty Mission Completed
//          |¨|¨| bit 2 => Is Chapter 3 'Ugly Streetfight' Bounty Mission Completed
//          |¨|¨| bit 3 => //
//          |¨|¨| bit 4 => Is Chapter 5 'Railroaded' Bounty Mission Completed
//          |¨|¨| bit 5 => //
//          |¨|¨| bit 6 => Is Chapter 6 'Carnival Life' Bounty Mission Completed
//          |¨|¨| bit 7 => Is Chapter 7 'Freak Show' Bounty Mission Completed
//          |¨|/
//          |¨|+0x1 - [Bit Flags] @Byte2 in Bitset:BountyHunterMissions_Completed
//          |¨|¨| bit 0 => //
//          |¨|¨| bit 1 => Is Chapter 8 'Rogue Valley' Bounty Mission Completed
//          |¨|¨| bit 2 => //
//          |¨|¨| bit 3 => Is Chapter 9 'Ghost Town' Bounty Mission Completed
//          |¨|¨| bits [4-5] => //
//          |¨|¨| bit 6 => Is Chapter 11 'Range War' Bounty Mission Completed
//          |¨|¨| bit 7 => Is Chapter 12 'Saloon Fight' Bounty Mission Completed
//          |¨|/
//          |¨|+0x2 - [Bit Flags] @Byte3 in Bitset:BountyHunterMissions_Completed
//          |¨|¨| bit 0 => Is Chapter 13 'The Traitor' Bounty Mission Completed
//          |¨|¨| bit 1 => Is Chapter 14 'Sunset Canyon' Bounty Mission Completed
//          |¨|¨| bit 2 => Is Chapter 15 'Bear Mountain' Bounty Mission Completed
//          |¨|¨| bit 3 => //
//          |¨|¨| bit 4 => Is Chapter 17 'The Mine' Bounty Mission Completed
//          |¨|¨| bit 5 => Is Chapter 18 'Stagecoach' Bounty Mission Completed
//          |¨|¨| bit 6 => //
//          |¨|¨| bit 7 => Is Chapter 20 'Fort Diego' Bounty Mission Completed
//          |¨|/
//          |¨|+0x3 - [Bit Flags] @Byte4 in Bitset:BountyHunterMissions_Completed
//          |¨|¨| bit 0 => Is Chapter 21 'End of the Line' Bounty Mission Completed
//          |¨|¨| bits [1-3] => //
//          |¨|¨| bit 4 => Is Chapter 24 'Battle Finale' Bounty Mission Completed
//          |¨|¨| bit 5 => Is Chapter 25 'The Siege' Bounty Mission Completed
//          |¨|¨| bit 6 => //
//          |¨|¨| bit 7 => Is Chapter 27 'Fall From Grace' Bounty Mission Completed
//          |/
//          |
//          |+0x7BC - [Variable Size ASCII] Player Profile Name
//          |
//          |+0x800 - [2-byte Bitset] Activated_Cheats
//          |¨[Bitset Definition][2-byte] Activated_Cheats
//          |¨|'''''''''''''''''''''''''''''''''''''
//          |¨|+0x0 - [Bit Flags] @Byte1 in Bitset:Activated_Cheats
//          |¨|¨| bits [0-5] => //
//          |¨|¨| bit 6 => Invincibility
//          |¨|¨| bit 7 => Golden Gun
//          |¨|/
//          |¨|+0x1 - [Bit Flags] @Byte2 in Bitset:Activated_Cheats
//          |¨|¨| bit 0 => Show Player Position (non-unlockable debug feature)
//          |¨|¨| bit 1 => Show AI Info (non-unlockable debug feature)
//          |¨|¨| bit 2 => Infinite Deadeye
//          |¨|¨| bit 3 => //
//          |¨|¨| bit 4 => Bite the Bullet
//          |¨|¨| bit 5 => Sad Stars
//          |¨|¨| bit 6 => No HUD
//          |¨|¨| bit 7 => No Distortion
//          |/
//          '
// $7443B0: [NTSCJ][32-bit Pointer] --(+0x0)--> [??-byte Struct] Undefined_Struct_01
//          @Regional Equivalent of $0x7448a0
// $7443E8: [NTSCJ][32-bit Pointer] --(+0x0)--> [2840-byte Struct] Selected Player_Profile_Data
//          @Regional Equivalent of $0x7448d8
// $744898: [PAL][8-bit {32-bit}] Selected Player_Profile ID
//          - Value range [0x0-0x5], there's a total of 6 player profile slots
//          - Each Player_Profile saves its own data (refer to $0x7448d8)
// $7448A0: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] Undefined_Struct_01
//          [Struct Definition][??-byte] Undefined_Struct_01
//          |''''''''''''''''''''''''''''''''''''''''''
//          |+0x8 - [28-byte Struct] ShowdownMode_Settings
//          |¨| - Documentation at $0x7405b0
//          |/
//          |+0x24 - [28-byte Bitset] Shared_Unlocks
//          |¨| - Documentation at $0x7405cd
//          |/
//          |+0x60 - [PAL][17040-byte Array] List of [(6x) 2840-byte Struct:Player_Profile_Data]
//          |¨| - Documentation at $0x740608
//          |/
//          '
// $7448A8: [PAL][32-bit] Showdown - Bounty Hunter Mode - Bounty Target Limit
//          - The required Bounty/Cash a player needs to collect to win the game
// $7448D8: [PAL][32-bit Pointer] --(+0x0)--> [2840-byte Struct] Selected Player_Profile_Data
//          - This pointer points to the currently selected Player_Profile_Data
//          - Each Player_Profile has his own data storage
//          - Player_Profile_Data is updated on save/on end of missions
//          - Struct Definition at $0x740608
// $744C78: [PAL][24-byte Bitset] Temporary Selected Player_Profile_Unlocks
// $747408: [PAL][32-bit Pointer{1}] --> RewardMenu and StartChpMenu Display Data (alt 1)
//          - Identical pointer at $0x54caf0
// $747BCD: [NTSCU][6-byte ASCII {Variable Size}] Video File Name ID
//          @Regional equivalent of $0x74a34d (PAL)
// $74A34D: [PAL][6-byte ASCII {Variable Size}] Video File Name ID - NTSC Mode
//          - Preceding [13-byte ASCII] = "cdrom0:\/pss/"
//          - VideoFileName_IDs and further documentation at $0x74a34f
// $74A34F: [PAL][6-byte ASCII {Variable Size}] Video File Name ID - PAL Mode
//          - Identifies the current/last PRE-RENDERED video played
//          - Preceding [15-byte ASCII] = "cdrom0:\/pss50/" -> pss files are ps2 video/image files; There's a folder on the ROM "pss50" which stores 50Hz video's for PAL mode and a folder "pss" for NTSC mode
//          
//          # VideoFileName_IDs (list incomplete)
//          |'''''''''''''''''''''''''
//          | rslogo.pss => Rockstar Logo on game boot
//          | titles.pss => Game Title Intro Video (plays after selecting language)
//          | sher7001.pss => Chapter 3 (Ugly Streetfight) - Intro video: Red talks with sheriff about bounty reward + bandit shoots dog
// $753AB0: [PAL][32-bit Pointer{1}] --> Keys Acquired (functional)
//          @Fixed Memory Location. Although pointed to by $0x7A1900
//          |
//          |+0x68 - [20-byte Array] List of [(5x) Bit Flag:Is_Key_Acquired {32-bit}] bit 0 => Is Key Acquired
//          |¨[Array Definition][20-byte]
//          |¨|°°°°°°°°°°°°°°°°°°°°°°°°°
//          |¨| - This array contains the functional bit flags for the keys. If these are set to 0, standing near the interactable doors won't show the prompt to open them
//          |¨| - Key icon display is handled at $0x562A20
//          |¨|
//          |¨|+0x0 - [Bit Flag:Is_Key_Acquired] Key 1
//          |¨|+0x4 - [Bit Flag:Is_Key_Acquired] Key 2
//          |¨|+0x8 - [Bit Flag:Is_Key_Acquired] Key 3
//          |¨|+0xC - [Bit Flag:Is_Key_Acquired] Key 4
//          |¨|+0x10 - [Bit Flag:Is_Key_Acquired] Key 5
//          |/
//          '
// $754A90: [PAL][32-bit Pointer{1}] --> Actor_Data Array
//          +0x8 - [32-bit Pointer{2}]
//          ++0x10 - [160-byte Array] List of [(20x) 8-byte Struct:Actor_Data]
//          +| - Further documentation at $0x7621d0
// $75FA50: [NTSCU][160-byte Array] List of [(20x) 8-byte Struct:Actor_Data]
//          @Regional equivalent of $0x7621d0 (PAL)
// $7608F0: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [3008-byte Struct] SinglePlayer_Data
//          @Regional equivalent of $0x763070 (PAL)
// $7621D0: [PAL][160-byte Array] List of [(20x) 8-byte Struct:Actor_Data]
//          @Fixed Memory Location, Although pointed to by $0x754a90
//          
//          [Struct Definition][8-byte] Actor_Data_0
//          |=================================
//          |+0x0 - [32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] Actor_Data_A
//          |¨| - Struct contains miscellaneous data which is shared between certain actors
//          |/
//          |+0x4 - [32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] Actor_Data_B
//          |¨| - Struct:Actor_Data_B Definition below
//          |/
//          '
//          
//          [Struct Definition][??-byte] Actor_Data_B
//          |=================================
//          | - This pointer is removed/zero'd out when the actor model has been despawned for a 3-5 seconds, not on actor death
//          |
//          |+0x4 - [32-bit Pointer{2}]
//          |+|+0x4 - [32-bit Pointer{3}]
//          |+|+|+0x0 - [Variable Size ASCII] Character_Name
//          |+|+|¨| - When this is the player character: the name of the Player_Profile will be saved here
//          |+|+|¨| - Unique characters will have their names here
//          |+|+|¨| - Other NPCs have miscellaneous names set here (e.g., Mikey, Bobby, Jeremiah...)
//          |+|/
//          |+|+0x18 - [32-bit Pointer{3}]
//          |+|+|+0x10 - [32-bit Float] Actor HP
//          |+|+|+0x14 - [32-bit Float] Actor Max HP
//          |/
//          |
//          |+0xC - [32-bit Pointer{2}]
//          |+|+0x90 - [16-byte PS2_Vector] Actor Location
//          |+|¨| - PS2_Vector Definition at $0x763070
//          |+|/
//          |+|+0xC0 - [Bit Flag] bit 0 => Is Riding Animal
//          |+|¨| - Whilst riding an animal, the Actor Location is zeroed out
//          |/
//          |+0x24 - [32-bit Pointer{2}]
//          |++0x4 - [32-bit Pointer{3}]
//          |++|+0x4 - [3-byte ASCII] Character_Model_ID (string)
//          |++|¨| - IDs listed at $0x562a20
//          |/
//          |+0x80 - [32-bit Pointer{2}] --(+0x0)--> [176-byte Struct] Weapon_Manager
//          |+|¨| - Struct:Weapon_Manager Definition at $0x7638b8
//          |/
//          '
// $763070: [PAL][32-bit Pointer{1}] --(+0x0)--> [3008-byte Struct] SinglePlayer_Data
//          - Pointer becomes functional once the first mission is started in story mode
//          
//          [Struct Definition][3008-byte] SinglePlayer_Data
//          |=====================================
//          | - This struct is very similar to ShowdownPlayer_Data_C ($0x7638b8)
//          | - This also points to ShowdownPlayer_Data of Player 1 during a Showdown Match
//          |
//          |+0xC - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] Actor_Data_B
//          |+| - Struct:Actor_Data_B Definition at $0x7621d0
//          |/
//          |
//          |+0x18 - [32-bit Pointer{2}]
//          |++0x10 - [32-bit Float] Player HP
//          |++0x14 - [32-bit Float] Player Max HP
//          |++|¨| - Base HP: 250.0
//          |++|¨| - Each HP upgrade, increases this value by 50.0
//          |
//          |+0x94 - [32-bit Pointer{2}]
//          |++0x10 - [8-bit {32-bit}] Amount of Guns in Inventory
//          |
//          |+0x168 - [32-bit Pointer{2}]
//          |+|+0xF4 - [32-bit Pointer{3}]
//          |+|+|+0x30 - [660-byte Struct] Ammunition_Inventory
//          |+|+|¨| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this Struct does not
//          |+|/
//          |+|+0xEC - [32-bit Pointer{3}]
//          |+|+|+0x4 - [Variable Size ASCII] GameTrigger_ID
//          |+|+|¨| - This can be used to ID certain in-engine cinematics as well as certain triggers/actions
//          |+|+|¨| - WARNING, sometimes the first letter of this ASCII ID is switched with 0 instead of the ASCII character. The 0 probably means this data is not in use anymore
//          |+|+|¨| - IDs listed below
//          |/
//          |
//          |+0x36C - [32-bit Pointer{2}] --(+0x0)--> [456-byte Struct] SinglePlayer_Mission_Stats
//          |+[Struct Definition][456-byte] SinglePlayer_Mission_Stats
//          |+|''''''''''''''''''''''''''''''''''''
//          |+| - This struct is very similar to ShowdownPlayer_Stats ($0x7638b8)
//          |+| - This struct stores stats per mission
//          |+| - On save/on restart/on RetryMenu render, the stats here will update the Player_Profile_Data stats ($0x740608)
//          |+|
//          |+|+0x0 - [32-bit] Shots Fired (copy)
//          |+|¨| - Depending on weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |+|¨| - functional value further below
//          |+|
//          |+|+0x2C - [32-bit] Shots Hit (copy)
//          |+|¨| - This is not always an exact copy of the functional value (further below)
//          |+|
//          |+|+0x30 - [32-bit] Head Shot Kills
//          |+|¨| - Enemies killed by head shots
//          |+|
//          |+|+0x5C - [32-bit] Death Toll (enemy kill count)
//          |+|¨| - This value does not count enemies killed which are riding animals, prefer using MissionKillcount at 0x4fa370 for this instance
//          |+|
//          |+|+0x70 - [32-bit Float] Raw Total Damage Taken
//          |+|¨| - This value is used to calculate Damage Taken statistic on the Reward Menu
//          |+|
//          |+|+0x17C - [32-bit Float] Time Spent In Mission (in seconds)
//          |+|¨| - Only counts when in control of character or during small interactive cutscenes (also counts for a few frames in-between loading cutscenes)
//          |+|
//          |+|+0x190 - [32-bit] Bounty/Cash Collected
//          |+|¨| - Copies value stored via pointer at $0x562a20
//          |+|
//          |+|+0x194 - [32-bit] Shots Fired (functional)
//          |+|¨| - This value is used to calculate accuracy statistic on the Reward Menu
//          |+|
//          |+|+0x198 - [32-bit] Shots Hit (functional)
//          |+|¨| - This value is used to calculate accuracy statistic on the Reward Menu
//          |+|
//          |+|+0x19C - [32-bit] Arm Shots
//          |+|
//          |+|+0x1A0 - [32-bit] Body Shots
//          |+|
//          |+|+0x1A4 - [32-bit] Head Shots
//          |+|
//          |+|+0x1A8 - [32-bit] Leg Shots
//          |+|
//          |+|+0x1B0 - [32-bit] Money Spent
//          |+|
//          |+|+0x1B4 - [32-bit] Melee Hits
//          |+|
//          |+|+0x1B8 - [32-bit] Back Shots
//          |+|
//          |+|+0x1BC - [32-bit] Dead Eye Abilities/Special Moves Used
//          |+|¨| - WARNING: This value increases faster based spamming the dead eye input, although visually not that many abilities were used
//          |+|
//          |+|+0x1C0 - [32-bit] Highest Combo Multiplier
//          |+|¨| - This value which is shown on the the Reward Menu
//          |+|
//          |+|+0x1C4 - [32-bit Float] Highest Combo
//          |+|¨| - This value which is shown on the the Reward Menu
//          |/
//          |
//          |+0x5C8 - [32-byte Bitset] Player_Profile_Unlocks
//          |¨| - Each Player_Profile has its own bitset storing which items are unlocked
//          |¨| - Newly acquired items are saved to the Shared_Unlocks ($0x7405cd)
//          |¨| - This bitset also handles which weapons are in the weapon inventory, during weapon selection
//          |¨| - This bitset is updated whenever something is picked up, unlocked/bought through shops and on the Reward Menu
//          |¨| - Bitset Definition below
//          |/
//          '
//          
//          [PS2_Vector Definition][16-byte]
//          |''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Float] W-Component (Perspective Divide Component)
//          |¨| - Has a role in perspective projection, where the final coordinates are obtained by dividing X, Y, Z by W.
//          |+0x4 - [32-bit Float] Y-Coordinate
//          |+0x8 - [32-bit Float] Z-Coordinate
//          |+0xC - [32-bit Float] X-Coordinate
//          '
//          
//          [Bitset Definition][24-byte] Player_Profile_Unlocks
//          |- When upgrading a weapon both flags will be 1 until a save occurs. Once the save occurs the bitflag for the non-upgraded weapon will become 0 and the bitflag which corresponds with the upgraded version will be 1;
//          |- Some Journal Pages and Showdown Characters may be unlocked by 2 seperate bitflags (one bitflag would possibly correspond to buying an item to unlock it VS one bitflag for unlocking it through mission ratings)
//          |================================
//          |+0x0 - [Bit Flags] @Byte1 in Bitset:Player_Profile_Unlocks
//          |¨| bits [0-2] => //
//          |¨| bit 3 => (PAGE+WEAPON) Side Arms - Old Pistol
//          |¨| bit 4 => (PAGE+WEAPON) Side Arms - Old Pistol (upgraded)
//          |¨| bit 5 => (PAGE+WEAPON) Side Arms - Revolver
//          |¨| bit 6 => (PAGE+WEAPON) Side Arms - Revolver (upgraded)
//          |¨| bit 7 => (PAGE+WEAPON) Side Arms - Twin Revolvers
//          |/
//          |+0x1 - [Bit Flags] @Byte2 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE+WEAPON) Side Arms - Twin Revolvers (upgraded)
//          |¨| bit 1 => (PAGE+WEAPON) Side Arms - Widowmaker
//          |¨| bit 2 => (PAGE+WEAPON) Side Arms - Widowmaker (upgraded)
//          |¨| bit 3 => (PAGE+WEAPON) Side Arms - Scorpion
//          |¨| bit 4 => (PAGE+WEAPON) Ranged Weapons - Breech Loader
//          |¨| bit 5 => (PAGE+WEAPON) Ranged Weapons - Breech Loader (upgraded)
//          |¨| bit 6 => (PAGE+WEAPON) Ranged Weapons - The Lion
//          |¨| bit 7 => (PAGE+WEAPON) Ranged Weapons - The Lion (upgraded)
//          |/
//          |+0x2 - [Bit Flags] @Byte3 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE+WEAPON) Ranged Weapons - Twelve Gauge
//          |¨| bit 1 => (PAGE+WEAPON) Ranged Weapons - Twelve Gauge (upgraded)
//          |¨| bit 2 => (PAGE+WEAPON) Ranged Weapons - Owl Rifle
//          |¨| bit 3 => (PAGE+WEAPON) Ranged Weapons - Owl Rifle (upgraded)
//          |¨| bit 4 => (PAGE+WEAPON) Ranged Weapons - Repeater Rifle
//          |¨| bit 5 => (PAGE+WEAPON) Ranged Weapons - Repeater Rifle (upgraded)
//          |¨| bit 6 => (PAGE+WEAPON) Ranged Weapons - High Caliber
//          |¨| bit 7 => (PAGE+WEAPON) Ranged Weapons - High Caliber (upgraded)
//          |/
//          |+0x3 - [Bit Flags] @Byte4 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE+WEAPON) Side Arms - Six Shooter
//          |¨| bit 1 => (PAGE+WEAPON) Side Arms - Six Shooter (upgraded)
//          |¨| bit 2 => (PAGE+WEAPON) Side Arms - Pacificador
//          |¨| bit 3 => (PAGE+WEAPON) Side Arms - Pacificador (upgraded)
//          |¨| bit 4 => (PAGE+WEAPON) Side Arms - Inquisitor
//          |¨| bit 5 => (PAGE+WEAPON) Ranged Weapons - Halcon Rifle
//          |¨| bit 6 => (PAGE+WEAPON) Ranged Weapons - Halcon Rifle (upgraded)
//          |¨| bit 7 => (PAGE+WEAPON) Ranged Weapons - Bayonet Rifle
//          |/
//          |+0x4 - [Bit Flags] @Byte5 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE+WEAPON) Ranged Weapons - Bayonet Rifle (upgraded)
//          |¨| bit 1 => (PAGE+WEAPON) Ranged Weapons - Oppressor
//          |¨| bit 2 => (PAGE+WEAPON) Ranged Weapons - Sawn Off
//          |¨| bit 3 => (PAGE+WEAPON) Ranged Weapons - Sawn Off (upgraded)
//          |¨| bit 4 => (PAGE+WEAPON) Ranged Weapons - Escopeta
//          |¨| bit 5 => (PAGE+WEAPON) Ranged Weapons - Escopeta (upgraded)
//          |¨| bit 6 => (PAGE+WEAPON) Ranged Weapons - Zwei Fasser
//          |¨| bit 7 => (PAGE+WEAPON) Thrown Weapons - Knife
//          |/
//          |+0x5 - [Bit Flags] @Byte6 in Bitset:Player_Profile_Unlocks
//          |¨| bits [0-1] => //
//          |¨| bit 2 => (PAGE+WEAPON) Thrown Weapons - Dynamite
//          |¨| bit 3 => (PAGE+WEAPON) Thrown Weapons - Fire Bottle
//          |¨| bit 4 => (PAGE+WEAPON) Thrown Weapons - Snake Oil
//          |¨| bits [5-7] => //
//          |/
//          |+0x6 - [Bit Flags] @Byte7 in Bitset:Player_Profile_Unlocks
//          |¨| bit 7 => HP Upgrade - Buy 'Hot Bath' from girls taking a bath during Chapter 12 'Bar Fight'
//          |/
//          |+0x7 - [Bit Flags] @Byte8 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => HP Upgrade - Buy 'Snakebit Kit' from Curly Shaw's Shop in Chapter 8 'Rogue Valley'
//          |¨| bit 1 => HP Upgrade - Buy 'Lucky Flask' from Jack Swift walking around Brimstone (during 3rd visit)
//          |¨| bit 2 => HP Upgrade - Buy 'Kiss' from woman in jail during Chapter 16 'Jailbreak'
//          |¨| bit 3 => Dead Eye Upgrade - Buy 'Strong Drink' from Barman at Brimstone Saloon
//          |¨| bit 4 => Dead Eye Upgrade - Buy 'Pocket Watch' from boy selling newspapers in Brimstone
//          |¨| bit 5 => HP Upgrade - Chapter 7 'Freak Show' (Good rating)
//          |¨| bit 6 => HP Upgrade - Chapter 13 'The Traitor' (Excellent rating)
//          |¨| bit 7 => HP Upgrade - Chapter 20 'Fort Diego' (Good rating)
//          |/
//          |+0x8 - [Bit Flags] @Byte9 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => Dead Eye Upgrade - Chapter 6 'Carnival Life' (Good rating)
//          |¨| bit 1 => Dead Eye Upgrade - Chapter 14 'Sunset Canyon' (Excellent rating)
//          |¨| bit 2 => Dead Eye Upgrade - Chapter 24 'Battle Finale' (Good rating)
//          |¨| bit 3 => (PAGE) Good People of Brimstone - Mathias Lampry
//          |¨| bit 4 => //
//          |¨| bit 5 => (PAGE) Merchants of Brimstone - Carnaby Peabody
//          |¨| bit 6 => (PAGE) Merchant of Brimstone - Ralph Clover
//          |¨| bit 7 => (PAGE) Citizens of the Wilderness - Fred Kenyon
//          |/
//          |+0x9 - [Bit Flags] @Byte10 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Heroes of the Frontier - Buffalo || (CHAR) Buffalo
//          |¨| bit 1 => (PAGE) Wanted Dead or Alive - Rico Pedrosa || (CHAR) Rico Pedrosa
//          |¨| bit 2 => (PAGE) Citizens of the Wilderness - Black Elk Tribe || (CHAR) Standing Snake
//          |¨| bit 3 => (PAGE) Renegade Army - Private Hanson
//          |¨| bit 4 => (PAGE) Protectors of Brimstone - Rat Chavez
//          |¨| bit 5 => (PAGE) Outlaws in Twelve States - Oscar Navarro || (PAGE) Outlaws in Twelve States - Paul "Swig" Bennet |⚠|--> These are also unlocked by bit1@Byte23
//          |¨| bit 6 => (PAGE) Citizens of the Wilderness - Grizzly || (CHAR) Grizzly |⚠|--> These are also unlocked by bit2@Byte23
//          |¨| bit 7 => (PAGE) Wanted Dead or Alive - Sam || (CHAR) Sam |⚠|--> These are also unlocked by bit3@Byte23
//          |/
//          |+0xA - [Bit Flags] @Byte11 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Outlaws in Twelve States - Jethro Greensleves
//          |¨| bit 1 => (PAGE) Wanted Dead or Alive - "Smiley" Fawler || (CHAR) "Smiley" Fawler |⚠|--> These are also unlocked by bit5@Byte23
//          |¨| bit 2 => (PAGE) Wanted Dead or Alive - "Bloody" Tom || (CHAR) "Bloody" Tom (Mission Rating Unlock) |⚠|--> Item Buy Unlock by bit6@Byte23
//          |¨| bit 3 => (PAGE) Outlaws in Twelve States - Sidney "Sissy" Fess || (CHAR) "Sissy" Fess |⚠|--> These are also unlocked by bit7@Byte23
//          |¨| bit 4 => (PAGE) Wanted Dead or Alive - Roberto Pedrosa
//          |¨| bit 5 => (PAGE) Citizens of the Wilderness - Hank Pullman
//          |¨| bit 6 => (PAGE) Wanted Dead or Alive - Holstein Hal || (CHAR) Holstein Hal
//          |¨| bit 7 => (PAGE) Prof. Perry's Peculiarities - Atlas Jones
//          |/
//          |+0xB - [Bit Flags] @Byte12 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Citizens of the Wilderness - Blind Willy Wilson
//          |¨| bit 1 => (PAGE) Merchant of Brimstone - Woodrow Klein
//          |¨| bit 2 => (STAGE) Broken Creek - Boyhood Home
//          |¨| bit 3 => (PAGE) Renegade Army - Colonel Daren || (CHAR) Colonel Daren
//          |¨| bit 4 => (PAGE) Prof. Perry's Peculiarities - Asada
//          |¨| bit 5 => (PAGE) Merchants of Brimstone - Manny Quinn || (CHAR) Manny Quinn |⚠|--> These are also unlocked by bit3@Byte19
//          |¨| bit 6 => (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (CHAR) Falling Star
//          |¨| bit 7 => (PAGE) Annie's Ranch || (STAGE) The Ranch - Fertile Land
//          |/
//          |+0xC - [Bit Flags] @Byte13 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (STAGE) Widows Patch - Terrified Town
//          |¨| bit 1 => (PAGE) Heroes of the Frontier - Shadow Wolf || (CHAR) Shadow Wolf
//          |¨| bit 2 => (PAGE) Merchants of Brimstone - Doc Weatherby || (PAGE) Merchants of Brimstone - Percy Merriweather
//          |¨| bit 3 => (PAGE) Outlaws in Twelve States - Smitty || (CHAR) Smitty
//          |¨| bit 4 => (PAGE) Wanted Dead or Alive - Longhorn Luke
//          |¨| bit 5 => (PAGE) Citizens of the Wilderness - Running Moon
//          |¨| bit 6 => (PAGE) Good People of Brimstone - Cheryl-Lynn
//          |¨| bit 7 => (STAGE) The Mansion - Opulent Palace
//          |/
//          |+0xD - [Bit Flags] @Byte14 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Wanted Dead or Alive - Jesse Lynch
//          |¨| bit 1 => (PAGE) Battle Royale Contestants - Kid Cougar || (CHAR) "Kid" Cougar
//          |¨| bit 2 => (PAGE) Renegade Army - General Javier Diego || (CHAR) General Diego
//          |¨| bit 3 => (STAGE) Fallen Creek - Snow-topped Mountain
//          |¨| bit 4 => (PAGE) Renegade Army - Lieutenant Cleu
//          |¨| bit 5 => (PAGE) Wanted Dead or Alive - Harry 'Hatchet' Schultz
//          |¨| bit 6 => (PAGE) Outlaws in Twelve States - Father Driscoll
//          |¨| bit 7 => (PAGE) Good People of Brimstone - Abigail
//          |/
//          |+0xE - [Bit Flags] @Byte15 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Sunset Canyon || (STAGE) Sunset Canyon - Desert Badlands
//          |¨| bit 1 => (PAGE) Outlaws in Twelve States - Udo Kang || (CHAR) Udo Kang
//          |¨| bit 2 => (PAGE) Frontier Places - Border Bridge || (STAGE) The Bridge - Contested Structure
//          |¨| bit 3 => (PAGE) Protectors of Brimstone - Sherrif Bartlett || (CHAR) Sheriff Bartlett
//          |¨| bit 4 => (PAGE) Prof. Perry's Peculiarities - Lightning Larouche
//          |¨| bit 5 => (PAGE) Outlaws in Twelve States - Cooper || (CHAR) Cooper
//          |¨| bit 6 => (PAGE) Outlaws in Twelve States - Gordon "Digs" Fowler || (CHAR) "Dig" Fowler
//          |¨| bit 7 => (PAGE) Good People of Brimstone - Tameri
//          |/
//          |+0xF - [Bit Flags] @Byte16 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Outlaws in Twelve States - Standing Snake
//          |¨| bit 1 => (PAGE) Citizens of the Wilderness - Fred Kenyon
//          |¨| bit 2 => (PAGE) Prof. Perry's Peculiarities - The Clowns || (CHAR) Fidgit
//          |¨| bit 3 => (PAGE) Prof. Perry's Peculiarities - Professor Perry || (CHAR) Professor Perry
//          |¨| bit 4 => (PAGE) Ugly Chris Gang - Ugly Chris || (CHAR) "Ugly" Chris
//          |¨| bit 5 => (PAGE) The Jail || (STAGE) The Mine - Lost Inheritance
//          |¨| bit 6 => (PAGE) Good People of Brimstone - Natalie || (CHAR) Natalie
//          |¨| bit 7 => (PAGE) Battle Royale Contestant - Gabriel Navarro || (CHAR) Gabriel Navarro
//          |/
//          |+0x10 - [Bit Flags] @Byte17 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (CHAR) Katie O'Grady || (PAGE) Citizens of the Wilderness - Katie O'Grady
//          |¨| bit 1 => (PAGE) Good People of Brimstone - Jody
//          |¨| bit 2 => (CHAR) Sheriff O'Grady || (PAGE) Citizens of the Wilderness - Sheriff O'Grady
//          |¨| bit 3 => (PAGE) Protectors of Brimstone - The Cornet Brothers
//          |¨| bit 4 => (CHAR) Jason Cornet || (PAGE) Protectors of Brimstone - Jason Cornet
//          |¨| bit 5 => (PAGE) Renegade Army - Pick Axe Miller
//          |¨| bit 6 => (CHAR) "Pig" Josh || (PAGE) Prof. Perry's Peculiarities - Pig Josh
//          |¨| bit 7 => (CHAR) Dan || (PAGE) Wanted Dead or Alive - Dan
//          |/
//          |+0x11 - [Bit Flags] @Byte18 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Merchant of Brimstone - Hanz Kenyon
//          |¨| bit 1 => (PAGE) Good People of Brimstone - Lily Belle
//          |¨| bit 2 => (CHAR) Nate Harlow || (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (PAGE) Memories of the Past - Nate Harlow
//          |¨| bit 3 => (PAGE) Merchants of Brimstone - Carnaby Peabody
//          |¨| bit 4 => (STAGE) Fairground - Ruined Homestead || (PAGE) Fairgrounds
//          |¨| bit 5 => (PAGE) Outlaws in Twelve States - Bandito
//          |¨| bit 6 => (PAGE) Good People of Brimstone - Verne Wiggins
//          |¨| bit 7 => (PAGE) Protectors of Brimstone - Sergeant Marquez
//          |/
//          |+0x12 - [Bit Flags] @Byte19 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (CHAR) Red Jr.
//          |¨| bit 1 => (PAGE) Renegade Army - The Duellist
//          |¨| bit 2 => (PAGE) Good People of Brimstone - Sandy Dodge
//          |¨| bit 3 => (CHAR) Manny Quinn || (PAGE) Merchants of Brimstone - Manny Quinn |⚠|--> These are also unlocked by bit5@Byte12
//          |¨| bit 4 => (CHAR) Bad Bessie || (PAGE) Wanted Dead or Alive - Bad Bessie
//          |¨| bit 5 => (PAGE) Wanted Dead or Alive - Loaf Whitney
//          |¨| bit 6 => (PAGE) Protectors of Brimstone - Mad Dog Jones
//          |¨| bit 7 => (PAGE) Good People of Brimstone - Jebidah Cole
//          |/
//          |+0x13 - [Bit Flags] @Byte20 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Outlaws in Twelve States - Jacques
//          |¨| bit 1 => (PAGE) Renegade Army - Captain Bufias
//          |¨| bit 2 => (PAGE) Mansion || (STAGE) Mansion Grounds - Tended Gardens
//          |¨| bit 3 => (PAGE) Wanted Dead or Alive - Greg 'Big Oaf' Whitney || (CHAR) "Big Oaf" Whitney
//          |¨| bit 4 => (PAGE) Outlaws in Twelve States - Twiggy Phelps || (CHAR) "Twiggy" Phelps
//          |¨| bit 5 => (PAGE) Ugly Chris Gang - Gigolo
//          |¨| bit 6 => (PAGE) Merchant of Brimstone - Fitch
//          |¨| bit 7 => (PAGE) Battle Royale Contestants - Mr. Kelley || (CHAR) Mr. Kelley
//          |/
//          |+0x14 - [Bit Flags] @Byte21 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Prof. Perry's Peculiarities - Clyde Slade || (CHAR) "The Blade" Slade
//          |¨| bit 1 => (PAGE) Protectors of Brimstone - Governor Griffon || (CHAR) Governor Griffon
//          |¨| bit 2 => (STAGE) Ghost Town - Abandoned Settlement
//          |¨| bit 3 => // -> flips a unknown bit @Byte3 in Bitset:Player_Profile_Unlocks:ShowdownMap_Unlocks
//          |¨| bit 4 => (PAGE) Wanted Dead or Alive - Mr. Black || (CHAR) Mr. Black
//          |¨| bit 5 => (PAGE) Citizens of the Wilderness - Red Wolf Tribe |⚠|--> This page is also unlocked by bit6@Byte24
//          |¨| bit 6 => (PAGE) Citizens of the Wilderness || (CHAR) "Curly" Shaw
//          |¨| bit 7 => (PAGE) Outlaws in Twelve States - Juan "Loco" Sanchez
//          |/
//          |+0x15 - [Bit Flags] @Byte22 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => (PAGE) Renegade Army - Pvt. 'Ripper' Hernandez
//          |¨| bit 1 => (PAGE) Citizens of the Wilderness - Gabby Brennan
//          |¨| bit 2 => // -> flips a bit 1 byte before Bitset:Shared_Unlocks
//          |¨| bit 3 => // -> flips a bit 1 byte before Bitset:Shared_Unlocks
//          |¨| bit 4 => // -> flips a bit 1 byte before Bitset:Shared_Unlocks
//          |¨| bit 5 => // -> flips a bit 1 byte before Bitset:Shared_Unlocks
//          |¨| bit 6 => // -> flips a bit 1 byte before Bitset:Shared_Unlocks
//          |¨| bit 7 => // -> flips an unknown bit @Byte0 in Bitset:Player_Profile_Unlocks:Shared_Unlocks
//          |/
//          |+0x16 - [Bit Flags] @Byte23 in Bitset:Player_Profile_Unlocks
//          |¨| bit 0 => // -> flips an unknown bit @Byte0 in Bitset:Player_Profile_Unlocks:Shared_Unlocks
//          |¨| bit 1 => (PAGE) Outlaws in Twelve States - Oscar Navarro || (PAGE) Outlaws in Twelve States - Paul "Swig" Bennet |⚠|--> These are also unlocked by bit5@Byte10
//          |¨| bit 2 => (PAGE) Citizens of the Wilderness - Grizzly || (CHAR) Grizzly |⚠|--> These are also unlocked by bit6@Byte10
//          |¨| bit 3 => (PAGE) Wanted Dead or Alive - Sam || (CHAR) Sam |⚠|--> These are also unlocked by bit7@Byte10
//          |¨| bit 4 => (PAGE) Outlaws in Twelve States - Jethro Greensleves
//          |¨| bit 5 => (PAGE) Wanted Dead or Alive - "Smiley" Fawler || (CHAR) "Smiley" Fawler |⚠|--> These are also unlocked by bit1@Byte11
//          |¨| bit 6 => (PAGE) Wanted Dead or Alive - "Bloody" Tom || (CHAR) "Bloody" Tom (Item Buy Unlock) |⚠|--> Mission Rating Unlock by bit2@Byte11
//          |¨| bit 7 => (PAGE) Outlaws in Twelve States - Sidney "Sissy" Fess || (CHAR) "Sissy" Fess |⚠|--> These are also unlocked by bit3@Byte11
//          |/
//          |+0x17 - [Bit Flags] @Byte24 in Bitset:Player_Profile_Unlocks
//          |¨| bits [0-5] => //
//          |¨| bit 6 => (PAGE) Citizens of the Wilderness - Red Wolf Tribe |⚠|--> this page is also unlocked by bit5@Byte21
//          |¨| bit 7 => //
//          |/
//          '
//          
//          # GameTrigger_IDs (string)
//          |(list only contains IDs useful for achievement creation)
//          |''''''''''''''''''''''''''''''''
//          | Perfnew_Cinematic_Opening => Opening cinematic to first stage/level/mission; Red's father comes home
//          | Player_Navigation_Guide => IDs sequence of textHUDMessages for leading the player to the shooting tutorial in lvl_perfnew
//          | Pre_TargetA_NoCine => during shooting tutorial, before shooting the bull's eye (start of shooting tutorial)
//          | BullsEyeHit_NoCine2 => "That's some good shooting." -> during shooting tutorial, hit bull's eye
//          | Dummy2_Success_NoCine2 => "Good, you sure can handle a shooting iron!" -> during shooting tutorial, finished shooting scarecrow dummy
//          | BadComp_Phase4_NoCine2 => "You didn't shoot a single one." -> during shooting tutorial, shooting bottles/pans
//          | OKComp_Phase4_NoCine2 => "Not bad, but you could've done better." -> during shooting tutorial, shooting bottles/pans
//          | GoodComp_Phase4_NoCine2 => "You've got them all! Nice shooting!" -> during shooting tutorial, shooting bottles/pans
//          '
// $7638B8: [PAL][64-byte Array] List of [(2x-4x) ShowdownPlayer_Data]
//          - This array is only functional during a showdown match
//          - Minimum 2 players (Player 1 + another); Maximum 4 players
//          - Player 1 is always the first [ShowdownPlayer_Data] struct in the array
//          
//          [Struct Definition][16-byte] ShowdownPlayer_Data
//          |'''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Pointer{1}] --(+0x0)--> [2512-byte Struct] ShowdownPlayer_Data_A
//          |
//          |+0x4 - [32-bit Pointer{1}] --(+0x0)--> [1312-byte Struct] ShowdownPlayer_Data_B
//          |+[Struct Definition][1312-byte] ShowdownPlayer_Data_B
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+|+0x18 - [32-bit Pointer{2}]
//          |+|++0x80 - [32-bit Pointer{3}] --(+0x0)--> [176-byte Struct] Weapon_Manager
//          |+|++| - Struct Definition below
//          |+|/
//          |+|+0x28C - [32-byte Bitset] Might be correlated to weapon pickups or power ups?
//          |+|
//          |+|+0x30 - [32-bit Pointer{2}] --(+0x0)--> [1224-byte Struct] ShowdownPlayer_Stats
//          |+|+| - Contains stats used for the scoreboard as well as some other misc unused stats
//          |+|+| - Struct Definition below
//          |+|/
//          |+|+0x2B4 - [32-bit Pointer{2}]
//          |+|++0xC - [32-bit] Bounty/Cash Collected
//          |/
//          |
//          |+0x8 - [32-bit Pointer{1}] --(+0x0)--> [3008-byte Struct] ShowdownPlayer_Data_C
//          |+[Struct Definition][464-byte] ShowdownPlayer_Data_C
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+| - This struct is very similar to SinglePlayer_Data ($0x763070)
//          |+|
//          |+|+0xC - [32-bit Pointer{1}]
//          |+|++0xC - [32-bit Pointer{2}]
//          |+|++|+0x90 - [16-byte PS2_Vector] ShowdownPlayer_Location
//          |+|++|¨| - PS2_Vector Definition at $0x763070
//          |+|/
//          |+|
//          |+|+0x18 - [32-bit Pointer{2}]
//          |+|++0x10 - [32-bit Float] Player HP
//          |+|++0x14 - [32-bit Float] Player Max HP
//          |+|
//          |+|+0x94 - [32-bit Pointer{2}]
//          |+|++0x10 - [8-bit {32-bit}] Amount of Guns in Inventory
//          |+|
//          |+|+0x168 - [32-bit Pointer{2}]
//          |+|++0xF4 - [32-bit Pointer{3}] --(+0x0)--> [688-byte Struct] Ammunition_Inventory
//          |+|++| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this Struct does not
//          |+|/
//          |+|+0x5C8 - [32-byte Bitset] Acquired_Weapons
//          |+|¨| - This bitset does not have any neccesary function inside Showdown Mode, it's probably something that is inherited from the singlePlayer
//          |+|¨| - This bitset handles which weapons are available to pick before mission start
//          |+|¨| - This bitset is updated whenever something is unlocked/bought in-game, in shops and on the Reward Menu
//          |/
//          |
//          |+0xC - [32-bit Pointer{1}] --> ShowdownPlayer_Data_D
//          |+| - This pointer is only functional for Player 1; This pointer is non-existent (= 0x0) for other Players
//          
//          [Struct Definition][176-byte] Weapon_Manager
//          |'''''''''''''''''''''''''''''''''''''
//          |+0x44 - [8-bit {32-bit}] Default Weapon_ID
//          |¨| - This value decides which weapon is equipped by default on (re)spawn
//          |¨| - Weapon_IDs listed below
//          |/
//          |+0x48 - [8-bit {32-bit}] Equipped Weapon_ID
//          |¨| - Weapon_IDs are equal to the index of the weapon inside the Array.Weapon_Data
//          |/
//          |
//          |+0x20 - [32-bit Pointer{1}]
//          |++0x0 - [32-bit Pointer{2}]
//          |+++0x4 - [32-bit Pointer{3}]
//          |++++0x0 - [440-byte Array] List of [(55x) 32-bit Pointer{4}] --(+0x0)--> [8-byte Struct] Weapon_Data
//          |++++| - Struct Definition Weapon_Data below
//          |/
//          |
//          |+0xA8 - [8-bit Bitfield {32-bit}] Universal_Weapon_State
//          |¨| - This state is valid to use for all weapons, this in comparison to Struct:Weapon_Data.WeaponState at $0x7638b8
//          |¨| - Universal_Weapon_States listed below
//          |/
//          '
//          
//          [Struct Definition][1224-byte] ShowdownPlayer_Stats
//          |''''''''''''''''''''''''''''''''''''''
//          | - Data stored here is dynamically updated during gameplay
//          | - Most 32-bit values stored are signed integers, but the scoreboard only displays a limited amount of characters (refer to $0x6b18b4)
//          |
//          |+0x0 - [32-bit] Shots Fired
//          |¨| - Depending on weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |/
//          |+0x2C - [32-bit] Shots Hit
//          |
//          |+0x70 - [32-bit Float] Raw Total Damage Taken
//          |
//          |+0x418 - [32-bit] Death Count (own deaths)
//          |
//          |+0x430 - [32-bit] High Noon Rounds Won
//          |
//          |+0x490 - [32-bit] Bounty/Cash Collected
//          |¨| - Copies value stored via pointer at $0x562a20
//          |/
//          |+0x494 - [32-bit] Shots Fired (copy)
//          |
//          |+0x498 - [32-bit] Shots Hit (copy)
//          |
//          |+0x49C - [32-bit] Arm Shots
//          |
//          |+0x4A0 - [32-bit] Body Shots
//          |
//          |+0x4A4 - [32-bit] Head Shots
//          |
//          |+0x4A8 - [32-bit] Leg Shots
//          |
//          |+0x4B4 - [32-bit] Melee Hits
//          |
//          |+0x4B8 - [32-bit] Back Shots
//          |
//          |+0x4C0 - [32-bit] Highest Combo Multiplier
//          |
//          |+0x4C4 - [32-bit Float] Highest Combo
//          '
//          
//          [Struct Definition][8-byte] Weapon_Data
//          |'''''''''''''''''''''''''''''''''''''
//          | - Each weapon has a [Weapon_Data] structure inside this array
//          | - There's about 55 weapons in the list
//          | - Changing ammunition stats here work, although UI needs to be handled through $0x562a20
//          |
//          |+0x4 - [32-bit Pointer{1}]
//          |+|+0x18 - [8-bit Bitfield] WeaponState
//          |+|¨| 0x1 => Idle
//          |+|¨| 0x3 => Firing
//          |+|¨| 0x4 => Reloading
//          |+|/
//          |+|+0x20 - [8-bit {32-bit}] Maximum Ammunition Capacity (functional)
//          |+|+0x24 - [8-bit {32-bit}] Current Loaded Ammunition (functional)
//          |+|
//          |+|+0x28 - [32-bit Pointer{2}] --(+0x0)--> [12-byte?? Struct] Weapon_Ammunition
//          |+|+[Struct Definition][12-byte??] Weapon_Ammunition
//          |+|+|'''''''''''''''''''''''''''''''''''''
//          |+|+| - Some ammunition might be shared between weapons
//          |+|+| - Ammunition values here don't count the ammo loaded inside the gun, ammunition count on HUD does (refer to $0x562a20)
//          |+|+|
//          |+|+|+0x4 - [8-bit {32-bit}] Reserve Ammuniton on Spawn
//          |+|+|¨| - Ammunition shown on the HUD always has counts
//          |+|+|+0x8 - [8-bit {32-bit}] Current Reserve Ammuniton
//          |+|/
//          |+|
//          |+|+0x1D0 - [Bit Flag {32-bit}] bit 0 => Is Weapon In Inventory
//          |/
//          '
//          
//          # Weapon_IDs (list incomplete)
//          |''''''''''''''''
//          | 0x3 => Old Pistol
//          | 0x9 => Widowmaker (Pistol)
//          | 0xb => Scorpion (Pistol)
//          | 0x12 => Owl Rifle
//          | 0x14 => Repeating Rifle
//          | 0x18 => Six Shooter (Pistol)
//          | 0x1d => Halcon Rifle
//          | 0x1f => Bayonet Rifle
//          | 0x22 => Sawn Off Shotgun
//          | 0x24 => Escopeta (Shotgun)
//          | 0x27 => Knife (Throwable)
//          | 0x29 => Hunting Knife (Throwable)
//          | 0x2a => Dynamite (Throwable)
//          | 0x2b => Fire Bottle (Throwable)
//          | 0x2d => Showstoppers (Dual Pistols)
//          | 0x2f => Faith (Rifle)
//          | 0x30 => Martillo Del Dios (Rifle)
//          | 0x31 => Sacred Bow
//          '
//          
//          # Universal_Weapon_States (list complete)
//          |'''''''''''''''''''''''
//          | 0x0 => Holstered
//          | 0x1 => Drawing Weapon (first half of animation)
//          | 0x2 => Drawing Weapon (last half of animation)
//          | 0x3 => Aiming
//          | 0x4 => Reloading (not used when "reloading" throwable items, also not used when reloading with DeadEye Ability)
//          | 0x5 => Holstering (during most frames of animation)
//          | 0x6 => Holstering (last few frames of animation)
//          '
// $7638F8: [PAL][8-bit {32-bit}] Showdown Mode Playercount
//          - Value range [0x2-0x4], minimum 2 players, max 4 players
// $79DEA0: [NTSCU][Variable Size ASCII] Area_ID
//          @Regional equivalent of $0x7a0620 (PAL)
// $79E008: [NTSCU][32-bit Pointer] --(+0x0)--> [??-byte Struct] Mission_Timers
//          @Regional equivalent of $0x7a0788 (PAL)
// $79E21C: [NTSCU][Bit Flag {32-bit}] bit 0 => Is Playing Bounty Hunter Mode (unverified)
//          @Regional equivalent of $0x7a099c (PAL)
// $7A0280: [NTSCU][32-bit Pointer] --(+0x0)--> [160-byte Struct] Puppetshow_Manager
//          @Regional equivalent of $0x7a2a00 (PAL)
// $7A0620: [PAL][Variable Size ASCII] Area_ID (functional)
//          - The Area_ID that needs to be loaded is stored here
//          - Changing this value to a valid ID and freezing before entering a loading screen, will load the corresponding mission/area
//          
//          # Area_IDs (list only contains IDs used in achievement creation)
//          |''''''''''''''''''''''''''
//          | default => Intermittent loading screen (= screen before the MAIN Loading screen, where the protagonist twirls his pistols around) -> some sort of value between switching Area_IDs
//          |
//          |--- Story Campaign ---
//          | lvl_perfnew => Chapter 1 - Bull's Eye - Intro with Red Jr.
//          | lvl_hng => Chapter 2 - Bounty Hunter - Bounty for Bloody Tom
//          | lvl_sher => Chapter 3 - Ugly Streetfight - Bounty for Ugly Chris
//          | lvl_traincar => Chapter 4 - The Traincar - Red has showdown with train robber inside traincar
//          | lvl_traingood => Chapter 5 - Railroaded - Red fighting bandits on top of moving train (follow-up of Chapter 4)
//          | lvl_tomb => Brimstone
//          | lvl_ghost => Chapter 6 - Carnival Life - Red saves Jack Swift + fight against Pig Josh
//          | lvl_shernite => Chapter 7 - Freak Show - Jack Swift fights Perry's gang
//          | lvl_bomb => Chapter 8 - Rogue Valley - Red fights Bad Bessie's gang
//          | lvl_gunsmoke => Chapter 9 - Ghost Town - Red fights Jessy Lynch's gang
//          | lvl_cemetery => Chapter 10 - The Cemetery - Red Fights Mr.Black (follow-up of Chapter 9)
//          | lvl_ranch => Chapter 11 - Range War - Play as Annie Stoakes
//          | lvl_barfight => Chapter 12 - Bar Fight - Red fights in Brimstone Saloon
//          | lvl_bridge => Chapter 13 - The Traitor - Play as General Diego
//          | lvl_coach => Chapter 14 - Sunset Canyon - Red fights stagecoach
//          | lvl_woods => Chapter 15 - Bear Mountain - Play as Shadow Wolf
//          | lvl_core => Chapter 16 - Jailbreak - Red escapes jail
//          | lvl_corenew => Chapter 17 - The Mine - Red escapes through mine (follow-up of Chapter 16)
//          | lvl_msn => Chapter 18 - Stagecoach - Buffalo Soldier rides on stagecoach
//          | lvl_msncyn => Chapter 19 - Hell Pass - Buffalo Soldier rides through Hell Pass (follow-up of Chapter 18)
//          | lvl_fort => Chapter 20 - Fort Diego - Red+Shadow Wolf fight Colonel Daren
//          | lvl_train => Chapter 21 - End of the Line - Red fights Wartrain
//          | lvl_trainend => Chapter 22 - Devils and Angels - Red fights General Diego (follow-up of Chapter 21)
//          | lvl_roydusk => Chapter 23 - Battle Royale (+ also counts for Saloon free time)
//          | lvl_royfinal => Chapter 24 - Battle Finale - Fight vs Mr. Kelley (follow-up of Chapter 23)
//          | lvl_mans => Chapter 25 - Siege - Fight in garden
//          | lvl_mansintb => Chapter 26 - House of Cards  - Fight inside mansion
//          | lvl_mansroof => Chapter 27 - Fall from Grace  - Fight on roof of mansion (follow-up of Chapter 26)
//          |
//          |--- Showdown Stages ---
//          | lvl_shernit2 => WidowPatch
//          | lvl_ranch2 => TheRanch
//          | lvl_ghost2 => Fairground
//          | lvl_flash2 => FallenCreek
//          | lvl_gun2 => GhostTown
//          | lvl_coach2 => SunsetCanyon
//          | lvl_perf2 => BrokenCreek
//          | lvl_mans2 => MansionGrounds
//          | lvl_int2 => TheMansion
//          | lvl_hng2 => TwinRocks
//          | lvl_fort2 => DesertFortress
//          '
// $7A0664: [PAL][8-bit {32-bit}] Display Language
//          - Changing this value at runtime, will change the display language on load
//          0x0 => en
//          0x1 => es
//          0x2 => fr
//          0x3 => de
//          0x4 => it
// $7A0694: [PAL][32-bit Pointer] --(+0x0)--> [Variable Size Struct] Main_Mission_Data (preferred)
//          - Main_Mission_Data is dependent on mission
//          - Main_Mission_Data stores various information about enemy spawn flags, checkpoint flags, event flags, cutscene flags (stored as floats)
//          - Floats: 1.0 (=0x3f800000) => flag/checkpoint is activated || 0.0 (0x0) => flag/checkpoint is inactive, perhaps certain inactive flags are stored as -1.0
//          - Turning these flags on/off during mission can trigger enemy spawns, checkpoint, cutscenes... (some event flags may bug out the mission when manually turning them on)
//          
//          [Struct Definition][??-byte] Main_Mission_Data.BountyHunter (Chapter 2)
//          |''''''''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+0xFC - [Float Flag] Is Boss Trio Spawn Cutscene Finished
//          |¨| - Float = 1.0 => Boss Trio spawn cutscene is finished
//          |¨| - Float = 0.0 => not finished
//          |/
//          '
// $7A0788: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] Mission_Timers
//          [Struct Definition][??-byte] Mission_Timers
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x1C - [32-bit Float] Time Spent in Mission/Level (copy) || Countdown timer (functional) (in seconds)
//          |¨| - When there's no countdown active, this value is a copy of Time Spent in Mission/Level. Else this is the function countdown timer
//          |¨| - This value is responsible for ending sundown mode (When this value hits 0.0 --> triggers end of sundown mode)
//          |¨| - This value is also used as a countdown timer for some Single Player mission objectives
//          |/
//          |
//          |+0x20 - [32-bit Float] Time Spent in Mission/Level (functional) (in seconds)
//          |¨| - This is the value which is shown on the Reward Menu (campaign)
//          |/
//          '
// $7A099C: [PAL][Bit Flag {32-bit}] bit 0 => Is Playing Bounty Hunter Mode
//          - This needs to be combined with $0x4fbaf0 to determine if player is effectively playing Bounty Hunter Mode
//          - Values becomes 1, when pressing 'accept' on 'Bounty Hunter'
//          - Values returns only back to 0, when pressing 'accept' on 'New Game'
// $7A09C0: [PAL][32-bit Pointer] --(+0x0)--> [3008-byte Struct] SinglePlayer_Data (alt)
//          - Identical pointer at $0x763070
// $7A1870: [PAL][32-bit Pointer{1}] --> RewardMenu and StartChpMenu Display Data (alt 2)
//          - Identical pointer at $0x54caf0
// $7A18D0: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_Data (Alt2)
// $7A1900: [PAL][32-bit Pointer{1}] --> Keys Acquired (functional)
//          +0x60 - [32-bit Pointer{2}]
//          | - Fixed Memory Location. Documentation at $0x753AB0
// $7A1920: [PAL][32-bit Pointer] --(+0x0)--> [Variable Size Struct] Main_Mission_Data (alt)
// $7A1948: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] Undefined_Struct_03 (alt)
//          - Documentation at 0x4fa370
// $7A2A00: [PAL][32-bit Pointer] --(+0x0)--> [160-byte Struct] Puppetshow_Manager
//          - Pointer is zeroed out when there no Puppetshow active
//          
//          [Struct Definition][160-byte] Puppetshow_Manager
//          |'''''''''''''''''''''''''''''''''''''''
//          | - This struct controls different aspects of a Puppetshow, which is a cutscene which is not a pre-rendered video file (refer to $0x74a34f), but an in-engine cutscene
//          | - Probably named like this as these types of cutscenes involve more detailed animation work
//          |
//          |+0x4 - [32-bit] Last CameraAction_ID of Puppetshow
//          |
//          |+0x10 - [32-bit] Current CameraAction_ID
//          |¨| - Each time the camera switches angles or goes from a hold to a move/rotation or vice versa, this value changes
//          |/
//          |+0x14 - [32-bit] Animation Keyframe
//          |¨| - Gets glitchy when changing/freezing
//          |/
//          |+0x18 - [32-bit] Count of CameraAction_ID Changes
//          |¨| - Starts to count at 0 (eg. CameraAction_ID: 0x14->0x24->0x37 => count = 2)
//          |/
//          |+0x68 - [Variable Size ASCII] Puppetshow ID
// $D17E8D: [8-bit] Main Menu Check
//          0x07e - Main Menu (Verified Always)
// $E36118: could be important
// $10795E4: [PAL][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] MultiplayerRewardMenu_UI_Controller (Alt)
// $11E54C0: [PAL][64-byte ASCII Field] ShowdownMode_ScoreboardWinnerDisplay_Text
//           - Use this field only when the showdown mode scoreboard is displayed, otherwise these 64 bytes may be in use by other data
//           
//           [ASCII Field Definition][64-byte] ShowdownMode_ScoreboardWinnerDisplay_Text
//           |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//           |+0x0 - [12-byte ASCII Field:Winner_Text] Player 1
//           |¨[ASCII Field Definition][12-byte] Winner_Text
//           |¨|'''''''''''''''''''''''''''
//           |¨| - ASCII = "Winner" => Player is a part of the winning team
//           |¨| - ASCII = " okLable" => Player is NOT part of the winning team
//           |/
//           |+0x10 - [12-byte ASCII Field:Winner_Text] Player 2
//           |
//           |+0x20 - [12-byte ASCII Field:Winner_Text] Player 3
//           |
//           |+0x30 - [12-byte ASCII Field:Winner_Text] Player 4
// $18C97D4: [8-bit] Chapter 2 - Shots left
// $198B014: [8bit] makes a key appear in chapter 2
// $198B018: [8bit] makes a key appear in chapter 2
// $198B01C: [8bit] makes a key appear in chapter 2
// $198B020: [8bit] makes a key appear in chapter 2
// $198B024: [8bit] makes a key appear in chapter 2
// $198B1E4: [8bit] total shots mission 2
//           pointerino positiive 5AD4
// $198B260: [8bit] Mission 2 total shots fired
// $19B7FD4: [8-bit] Chapter 1 - Shots left
// $1A5D1BC: [32Bit] Current Cash chapter 1
// $1A5D414: [8bit] Total ammo
// $1A5D428: [8bit] Shots left before reloading
// $1A5E720: [8bit] Total shots fired mission 1
// $1A5E74C: [8bit] Total shot hits
// $1A5E7A8: [8bit] mission 1 total kills
// $1A88434: [8-bit] Chapter 3 - Shots left
// $1F7EC20: [PAL][18-byte ASCII] Ending Credits Flag
//           - ASCII = "ENDCREDITS_PS2.stm" => Ending Credits Video Is Playing
//           (this is the audio file name, which is played during the Ending Credits Video)
