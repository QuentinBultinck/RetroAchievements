// Red Dead Revolver
// #ID = 11094

// $000040: [PAL][32-bit:AlwaysNULL]
// $1018AC: [NTSCU][8-bit:GameFPSControl]
//          - [0x0-0x1] => 60 fps
//          - 0x2 => 30 fps
//          - 0x3 => 20 fps
//          - 0x4 => 15 fps
//          - 0x5 => 12 fps
//          - ...
// $4F792C: [NTSCU][32-bit (base) Pointer:ExtraMissionData] -> [Struct:ExtraMissionData]
//          @Regional equivalent of $0x4f9fac (PAL)
// $4F7CF0: [NTSCU][32-bit (base) Pointer:UndefinedStruct_03(preferred)] -> [Struct:Undefined_03]
//          @Regional equivalent of $0x4fa370 (PAL)
// $4F7D20: [NTSCU][32-bit (base) Pointer:MajorCharacterData] -> [Array:MajorCharacterData]
//          @Regional equivalent of $0x4fa3a0 (PAL)
// $4F93DC: [PAL][bit0 BitFlag:IsTitleMenuDisplayed(alt) |32-bit]
//          - Identical to $0x562a0c
// $4F9470: [NTSCU][8-bit Bitfield:GameMode |32-bit]
//          @Regional equivalent of $0x4fbaf0 (PAL)
// $4F9F2C: [NTSCU][32-bit FloatFlag:IsInGame(preferred)]
//          @Regional equivalent of $0x4fc5ac (PAL)
// $4F9FAC: [PAL][32-bit (base) Pointer:ExtraMissionData] -> [Struct:ExtraMissionData]
//          - This struct contains extra data pertaining mission logic; Size and contents of struct is dependent on the mission
//          
//          [Definition Struct:ExtraMissionData.RogueValley_Ch8 |16-byte]
//          |'''''''''''''''''''''''''''''''''''''''
//          |+0x4 - [12-byte Array] List of (3x) [32-bit (layer-1) Pointer] -> [Struct:TreasureFoundTrigger]
//          |+| - There's 3 treasure boxes to be discovered in Chapter 8
//          |+|
//          |+|[Definition Struct:TreasureFoundTrigger |80-byte]
//          |+||'''''''''''''''''''''''''''''''''''''''
//          |+||+0x0 - [Variable Size ASCII:TreasureFoundTriggerID]
//          |+||¨| - Miscellaneous data
//          |+||/
//          |+||+0x4C - [bit0 BitFlag:IsTreasureOpened |32-bit]
//          |/
//          '
//          [Definition Struct:ExtraMissionData.TheTraitor_Ch13 |68-byte]
//          |'''''''''''''''''''''''''''''''''
//          |+0x4 - [12-byte Array] List of (16x) [32-bit (layer-1) Pointer] -> [Struct:CannonDestroyedTrigger]
//          |+| - First 8 entries in list correspond to allied (Renegade Army) cannons
//          |+| - Last 8 entries in list correspond to enemy cannons
//          |+|
//          |+|[Definition Struct:CannonDestroyedTrigger |80-byte]
//          |+||'''''''''''''''''''''''''''''''''''''''
//          |+||+0x0 - [Variable Size ASCII:CannonDestroyedTriggerID]
//          |+|| | - Miscellaneous data
//          |+||/
//          |+||+0x4C - [bit0 BitFlag:IsCannonDestroyed |32-bit]
//          |/
//          '
//          [Definition Struct:ExtraMissionData.BearMountain_Ch14 |8-byte]
//          |'''''''''''''''''''''''''''''''''''''''
//          |+0x4 - [32-bit (layer-1) Pointer]
//          |++0x4C - [bit0 BitFlag:IsTreasureBoxFaithOpened |32-bit]
//          '
// $4FA370: [PAL][32-bit (base) Pointer:UndefinedStruct_03(preferred)] -> [Struct:Undefined_03]
//          
//          [Definition Struct:Undefined_03 |??-byte]
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0xD8 - [32-bit:MissionKillcount]
//          |¨| - This is the true killcount in a mission, also counts kills by enemy friendly fire (indirectly caused by other means, other than the player)
//          |¨| - Refer to [32-bit:DeathToll] ($0x763070) as another killcount, which doe not count enemies who are killed whilst riding animals (bison or cavalry)
//          |¨| - Practically this is used to count the kills of enemies who are riding animals (bison or cavalry), primarily useful for Chapter 18 "Stagecoach"
//          |/
//          '
// $4FA3A0: [PAL][32-bit (base) Pointer:MajorCharacterData] -> [Array:MajorCharacterData]
//          - A 'major character' is a character which is usually a boss or allied NPC, with a corresponding HP display bar on screen.
//          - This base pointer/this array is a preferable alternative to using [Array:ActorData] at $0x7621d0, as not all major characters are contained inside that array and the [ActorData] is not always at the same index/location of that array (eg. Grizzly on Chapter 15 'Bear Mountain'). --- In [Array:MajorCharacterData], the [ActorData] is always at the same index.
//          
//          [Definition Array:MajorCharacterData |112-byte]
//          |''''''''''''''''''''''''''''''''
//          | - This array may contain a max of (14x) unique instances of [Struct:MajorCharacterData_0 |8-byte]
//          | - Definition of [Struct:MajorCharacterData_0] below
//          '
//          
//          [Definition Struct:MajorCharacterData_0 |8-byte]
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x0 - [32-bit (layer-1) Pointer] -> [Struct:MajorCharacterData_1]
//          | - This (layer-1) pointer is zeroed out when the major character has not yet spawned, pointer stays active after death
//          |
//          |[Definition Struct:MajorCharacterData_1 |??-byte]
//          ||''''''''''''''''''''''''''''''''''''''''''''
//          || - This struct is very similar or may point to the exact same data as documented/pointed to by [Struct:ActorData_B], refer to $0x7621d0
//          ||
//          ||+0x4 - [32-bit (layer-2) Pointer]
//          ||++0x0 - [Variable Size ASCII:MajorCharacterName]
//          ||
//          ||+0x18 - [32-bit (layer-2) Pointer]
//          ||++0x10 - [32-bit Float:MajorCharacterHP]
//          ||++0x14 - [32-bit Float:MajorCharacterMaxHP]
//          ''
// $4FA50C: [PAL][32-bit (base) Pointer:UndefinedStruct_02] -> [Struct:Undefined_02]
//          - Contains pointers to other documented structures
// $4FA558: [PAL][32-bit Timer:TimeSpentInControlOfCharacter]
//          - Increments by 3, each 2 frames (same for NTSC, PAL mode)
//          - Only increments when player can control a character (campaign and showdown mode)
// $4FAD6C: [NTSCU][bit0 InvertedBitFlag:IsLogoScreenLoading |32-bit]
//          @Regional equivalent of $0x4fd3ec
// $4FBAF0: [PAL][8-bit Bitfield:GameMode |32-bit]
//          - 0x0 => Game is booting (Main Menu has not yet been reached) || Also 0 for a few frames during certain loading screens
//          - 0xA => Main Menu (lvl_front)
//          - 0xC8 => Showdown Mode
//          - 0xFA => Single Player Mode || Bounty Hunter Mode
// $4FC5AC: [PAL][32-bit FloatFlag:IsInGame(preferred)]
//          - This value can be used to check if a mission has been started from the beginning, or when a mission has been restarted via PauseMenu or RetryMenu
//          
//          # Float Values
//          |''''''''''''
//          | - 0.0 => Not in-game
//          | - 1.0 => In-game
//          | - other... => In-game, during cutscenes...
// $4FD3A8: [PAL][8-bit:RefreshRate |32-bit]
//          - Game offers the option to chose refresh rate on game boot
//          
//          # Refresh Rate Values
//          |''''''''''''''''''
//          | - 0x32 (=50) => PAL 50Hz mode
//          | - 0x3C (=60) => NTSC 60Hz mode
// $4FD3EC: [PAL][bit0 InvertedBitFlag:IsLogoScreenLoading |32-bit]
//          - "Logo Screen Loading" === Loading when the Red Dead Revolver Logo is shown and the game is loading
//          - "Logo Screen Loading" =/= Any other loading sequence
//          
//          bit0 = 0 => Loading
//          bit0 = 1 => Not loading
// $501A38: [PAL][bit0 BitFlag:IsInGame(disfavored) |32-bit]
//          - Prefer using $0x4fc5ac
//          - Restarting/Retrying via RetryMenu will keep this value at 1
//          
//          bit0 = 1 => In-Game (Single Player & Showdown Mode), PauseMenu, RetryMenu, GameOver screen
//          bit0 = 0 => During loading screens, MainMenu, RewardMenu, Restarting level via PauseMenu
// $54A04C: [NTSCU][11-byte ASCII:PS2GameID]
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLUS_205.00" => USA PS2 Product ID
// $54A348: [NTSCU][32-bit (base) Pointer:MultiplayerRewardMenuData(preferred)] -> [Struct:MultiplayerRewardMenuData]
//          @Regional equivalent of $0x54cac8 (PAL)
// $54A370: [NTSCU][32-bit (base) Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)]
//          -> [Struct:RewardMenuAndStartChpMenuDisplayData]
//          @Regional equivalent of $0x54caf0 (PAL)
// $54C7CC: [PAL][11-byte ASCII:PS2GameID]
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLES_524.78" => EUR PS2 Product ID
// $54CAC8: [PAL][32-bit (base) Pointer:MultiplayerRewardMenuData(preferred)] -> [Struct:MultiplayerRewardMenuData]
//          [Definition Struct:MultiplayerRewardMenuData |??-byte]
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          | - This struct has a few differences between PAL and NTSCU
//          | - 'MultiplayerRewardMenu' is the post-match overview menu showing who won and a few stats (eg. bounty collected, headshots...)
//          |
//          |+0x28 - [32-bit (layer-1) Pointer:MultiplayerRewardMenuData_L1-01]
//          |+| - This pointer is zeroed out when the MultiplayerRewardMenu is NOT displayed
//          |+|
//          |+|+0x0 - [14-byte ASCIIFlag:IsMultiplayerRewardMenuDisplayed]
//          |+|¨| - ASCIIvalue = "mpRewards_new3" => MultiplayerRewardMenu is displayed
//          |+|¨| - First 8-byte of ASCII is always zeroed out when NOT displayed
//          |+|/
//          |+|
//          |+|+0x24 - [32-bit (layer-2) Pointer]
//          |+|+|
//          |+|+|+0x1C - [32-bit (layer-3) Pointer]
//          |+|+|+|+0xB74 - [NTSCU][bit0 BitFlag:IsPopupMenuDisplayed |32-bit]
//          |+|+|+|¨| - 'PopupMenu' is the menu which is displayed on the MultiplayerRewardMenu when pressing OK after the save confirmation. The PopupMenu displays 3 buttons: 'Replay', 'Multiplayer Settings' & 'Quit'
//          |+|+|+|
//          |+|+|+|+0xF44 - [PAL][bit0 BitFlag:IsPopupMenuDisplayed |32-bit]
//          |+|+|+|¨| - Identical to [NTSCU][bit0 BitFlag:IsPopupMenuDisplayed |32-bit], see above
//          |+|+|+|
//          |+|+|+|+0x1014 - [NTSCU][32-bit:HighlightedPopupMenuItem]
//          |+|+|+|¨| - 0x0 => 'Replay' Highlighted
//          |+|+|+|¨| - 0x1 => 'Multiplayer Settings' Highlighted
//          |+|+|+|¨| - 0x2 => 'Quit' Highlighted
//          |+|+|+|
//          |+|+|+|+0x1414 - [PAL][32-bit:HighlightedPopupMenuItem]
//          |+|+|+|¨| - Identical to [NTSCU][32-bit:HighlightedPopupMenuItem], see above
//          |+|+|/
//          |+|+|
//          |+|+|+0x34 - [32-bit (layer-3) Pointer]
//          |+|+|+|+0x0 - [PAL][64-byte ASCIIField:MultiplayerScoreboardWinnerDisplayText]
//          |+|+|+|¨| - Definition of ASCIIField below
//          |+|+|+|
//          |+|+|+|+0x180 - [NTSCU][64-byte ASCIIField:MultiplayerScoreboardWinnerDisplayText]
//          |+|+|+|¨| - Definition of ASCIIField below
//          |/
//          |
//          |+0x34 - [1024-byte ASCIIField:MultiplayerScoreboardDisplayText]
//          |¨| - Defintion of ASCIIField at $0x6b18b4
//          |/
//          '
//          
//          [Definition ASCIIField:MultiplayerScoreboardWinnerDisplayText |64-byte]
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |+0x0 - [12-byte ASCIIFlag(IsWinner):Player-1]
//          |+0x10 - [12-byte ASCIIFlag(IsWinner):Player-2]
//          |+0x20 - [12-byte ASCIIFlag(IsWinner):Player-3]
//          |+0x30 - [12-byte ASCIIFlag(IsWinner):Player-4]
//          |
//          |[Definition ASCIIFlag:IsWinner |12-byte]
//          ||'''''''''''''''''''''''''''
//          || - ASCIIvalue = "Winner" --> Player is part of the winning team (This ASCII overwrites the default value below, a few frames after the ASCII Field creation)
//          || - ASCIIvalue = " okLable" --> Player is NOT part of winning team (This ASCII is the default value which is set on ASCII Field creation)
//          ''
// $54CAF0: [PAL][32-bit (base) Pointer:RewardMenuAndStartChpMenuDisplayData(preferred)]
//          -> [Struct:RewardMenuAndStartChpMenuDisplayData]
//          
//          [Definition Struct:RewardMenuAndStartChpMenuDisplayData | ??-byte]
//          |===============================================
//          | - 'RewardMenu' is the post-mission overview menu in singleplayer mode showing unlocks, bounty collected, accuracy...
//          | - 'StartChpMenu' is a pre-mission menu in singleplayer mode where the player can pick his starting weapons as well as possibly do some shopping before the mission starts. Not every Chapter has one.
//          |
//          |+0xAC - [32-bit (layer-1) Pointer]
//          |+|+0x34 - [32-bit (layer-2) Pointer]
//          |+|+| - This pointer is only functional when the RewardMenu or StartChpMenu is displayed
//          |+|+|
//          |+|+|+0x1c - [32-bit (layer-3) Pointer] -> [Struct:RewardMenuDisplayData]
//          |+|+|+| - Definition of [Struct:RewardMenuDisplayData] below
//          |+|/
//          |+|+0x38 - [bit0 BitFlag:IsRewardMenuOrStartChpMenuDisplayed |32-bit]
//          |/
//          |
//          |
//          +0x1EC - [12-byte ASCIIFlag:IsStartChpMenuDisplayedOnce]
//          |¨| - ASCIIvalue = "startChpMenu" => StartChpMenu has been displayed at least once
//          |
//          |+0x214 - [bit0 BitFlag:IsStartChpMenuActive |32-bit]
//          |¨| - bit0 = 1 => StartChpMenu Active (also 1 when in any of the sub-menu's: ShopMenu or WeaponSelectionMenu)
//          |¨| - bit0 = 0 => StartChpMenu Inactive
//          |
//          |+0x260 - [bit0 BitFlag:IsStartChpMenuWeaponSelectionMenuAvailable |32-bit]
//          |¨| - bit0 = 1 => The WeaponSelectionMenu is available
//          |¨| - bit0 = 0 => The WeaponSelectionMenu is hidden, cannot be accessed in the StartChpMenu
//          |
//          |+0x284 - [Variable Size ASCII:StartChpMenuShopID]
//          |¨| - This identifies which shop/which items are available for buying. Presumably each mission with a StartChpMenu has its own ID.
//          |¨| - IDs currently not listed (not useful for achievements)
//          |
//          |+0x2AC - [bit0 BitFlag:IsStartChpMenuShopMenuAvailable {32-bit}]
//          |¨| - bit0 = 1 => The ShopMenu is available
//          |¨| - bit0 = 0 => The ShopMenu is hidden, cannot be accessed in the StartChpMenu
//          |
//          |+0x2E4 - [Variable Size ASCIIField:StartChpMenuShopItemNameIDs]
//          |¨| - This ASCIIField contains names of the shop items (misc data)
//          |
//          |
//          |+0x2D0 - [32-bit (layer-1) Pointer:RewardMenuAndStartChpMenuDisplayData_L1-2d0]
//          |+| - This pointer is only functional when the RewardMenu is displayed
//          |+| - This pointer is zeroed out when the RewardMenu is NOT displayed
//          |+|
//          |+|+0x24 - [32-bit (layer-2) Pointer]
//          |+|+|+0x1C - [32-bit (layer-3) Pointer] -> [Struct:RewardMenuDisplayData]
//          |+|+|+| - Definition of [Struct:RewardMenuDisplayData] below
//          |+|+|/
//          |+|+|+0x34 - [32-bit (layer-3) Pointer] -> [ASCIIField:RewardMenuDisplayText]
//          |+|+|+| - Definition of [ASCIIField:RewardMenuDisplayText] below
//          |/
//          '
//          
//          [Definition Struct:RewardMenuDisplayData | ??-byte]
//          |===============================================
//          | - This struct has differences between PAL and NTSCU in terms of offsets
//          | - This struct contains UI data logic for the RewardMenu
//          |
//          |+0xE4 - [PAL][NTSCU][bit0 BitFlag:IsQuitConfirmationMenuDisplayed |32-bit]
//          |¨| - bit0 = 1 => YesNoConfirmationMenu is displayed after pressing 'quit'
//          |¨| - bit0 = 0 => YesNoConfirmationMenu is displayed after pressing 'replay'; also default value
//          |¨| - Practically this is used to check if the player is quiting back to main menu or replaying the mission
//          |/
//          |
//          |+0x5D4 - [PAL][NTSCU][32-bit Pointer] -> [ASCII:AreaID(functional)]
//          |+| - Documentation of [ASCII:AreaID(functional)] at $0x7a0620
//          |/
//          |
//          |+0x7F0 - [NTSCU][64-byte Array:RatingObjectiveStars]
//          |¨| - Defintion of [Array:RatingObjectiveStars] below
//          |/
//          |+0x810 - [PAL][64-byte Array:RatingObjectiveStars]
//          |¨[Definition Array:RatingObjectiveStars |64-byte]
//          |¨|'''''''''''''''''''''''''
//          |¨| - This array contains (4x) instances of [Struct:UserInterfaceElement_RatingObjectiveStar |16-byte]
//          |¨| - Defintion of [Struct:UserInterfaceElement_RatingObjectiveStar] below
//          |¨|
//          |¨|+0x0 - [16-byte Struct(UserInterfaceElement_RatingObjectiveStar):Accuracy]
//          |¨|¨| - [Struct:UserInterfaceElement_RatingObjectiveStar].[ASCII:UserInterfaceElementID] = "pulseOn_accuracy"
//          |¨|/
//          |¨|+0x10 - [16-byte Struct(UserInterfaceElement_RatingObjectiveStar):DamageTaken]
//          |¨|¨| - [Struct:UserInterfaceElement_RatingObjectiveStar].[ASCII:UserInterfaceElementID] = "pulseOn_damage"
//          |¨|/
//          |¨|+0x20 - [16-byte Struct(UserInterfaceElement_RatingObjectiveStar):Time]
//          |¨|¨| - [Struct:UserInterfaceElement_RatingObjectiveStar].[ASCII:UserInterfaceElementID] = "pulseOn_time"
//          |¨|/
//          |¨|+0x30 - [16-byte Struct(UserInterfaceElement_RatingObjectiveStar):BestCombo]
//          |¨|¨| - [Struct:UserInterfaceElement_RatingObjectiveStar].[ASCII:UserInterfaceElementID] = "pulseOn_combo"
//          |/
//          |
//          |+0x8A4 - [PAL][NTSCU][8-bit:HighlightedMenuItem |32-bit]
//          |¨| - 0x0 => 1st item (top most item)
//          |¨| - 0x1 => 2nd item
//          |¨| - 0x2 => 3rd item (bottom most item)
//          |/
//          |
//          |+0x9B4 - [NTSCU][8-bit:MenuDepth |32-bit]
//          |¨| - Identical to PAL, but different offset
//          |/
//          |+0x9D4 - [PAL][8-bit:MenuDepth |32-bit]
//          |¨| - 0x0 => RewardMenu
//          |¨| - 0x1 => Quit or Replay Popup
//          |¨| - 0x2 => YesNoConfirmation Popup
//          |¨| - 0x3 => Logo Loading Screen
//          |/
//          |
//          |+0x964 - [PAL][bit0 BitFlag:IsFirstPopupMenuDisplayed |32-bit]
//          |¨| - 'FirstPopupMenu' is rendered when pressing OK on the RewardMenu
//          |/
//          |
//          |+0x9C4 - [NTSCU][32-bit:BountyCollected]
//          |+0x9D4 - [NTSCU][32-bit:MoneySpent]
//          |+0x9E4 - [PAL][32-bit:BountyCollected] || [NTSCU][32-bit:Balance]
//          |+0x9F4 - [PAL][32-bit:MoneySpent]
//          |+0xA04 - [PAL][32-bit:Balance]
//          |
//          |+0xA30 - [NTSCU][48-byte Array:ItemUnlocks]
//          |¨| - Defintion of [Array:ItemUnlocks] below
//          |/
//          |+0xA70 - [PAL][48-byte Array:ItemUnlocks]
//          |¨[Definition Array:ItemUnlocks |48-byte]
//          |¨|'''''''''''''''''''''''''
//          |¨| - This array contains (3x) instances of [Struct:UserInterfaceElement_ItemUnlock |16-byte]
//          |¨| - Defintion of [Struct:UserInterfaceElement_ItemUnlock] below
//          |¨|
//          |¨|+0x0 - [16-byte Struct(UserInterfaceElement_ItemUnlock):GoodRating]
//          |¨|¨| - [Struct:UserInterfaceElement_ItemUnlock].[ASCII:UserInterfaceElementID] = "rankNormal"
//          |¨|/
//          |¨|+0x10 - [16-byte Struct(UserInterfaceElement_ItemUnlock):ExcellentRating]
//          |¨|¨| - [Struct:UserInterfaceElement_ItemUnlock].[ASCII:UserInterfaceElementID] = "rankGreat"
//          |¨|/
//          |¨|+0x20 - [16-byte Struct(UserInterfaceElement_ItemUnlock):BountyRating]
//          |¨|¨| - [Struct:UserInterfaceElement_ItemUnlock].[ASCII:UserInterfaceElementID] = "rankBounty"
//          |/
//          '
//          
//          [Definition Struct:UserInterfaceElement_RatingObjectiveStar |16-byte]
//          |'''''''''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Pointer] -> [Variable Size ASCII:UserInterfaceElementID]
//          |¨| - Miscellaneous data, used to identify the UI element
//          |¨| - IDs are noted next to the elements in this code note (in English, regardless of Selected Display Language)
//          |/
//          |+0x4 - [bit0 BitFlag:IsRatingObjectiveStarDisplayed |32-bit]
//          |¨| - If a star is displayed, it counts toward acquiring Good or Excellent rating for the mission, thus unlocking the corresponding mission item unlocks
//          |¨| - Usually 2 stars are required for a Good rating and 3 stars are required for an Excellent rating
//          |¨| bit0 = 0 => star is NOT displayed
//          |¨| bit0 = 1 => star IS displayed
//          |/
//          '
//          
//          [Definition Struct:UserInterfaceElement_ItemUnlock |16-byte]
//          |'''''''''''''''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Pointer] -> [Variable Size ASCII:UserInterfaceElementID]
//          |¨| - Miscellaneous data, used to identify the UI element
//          |¨| - IDs are noted next to the elements in this code note (in English, regardless of Selected Display Language)
//          |/
//          |+0x4 - [32-bit Pointer] -> [Variable Size ASCII:ItemUnlockID]
//          |¨| - ItemUnlockIDs are in English in RAM, regardless of Selected Display Language
//          |¨| - ItemUnlockIDs listed below
//          |¨| - Practically this can be used to check if a specific rating has been achieved
//          |/
//          '
//          
//          [Definition ASCIIField:RewardMenuDisplayText |2448-byte]
//          |'''''''''''''''''''''''''''''''''''''''''''
//          | - ASCIIField has no differences between NTSCU and PAL
//          |
//          |+0x130 - [7-byte ASCII:Time]
//          |+0x140 - [6-byte ASCII:DamageTaken]
//          |+0x150 - [6-byte ASCII:Accuracy]
//          |+0x160 - [8-byte ASCII:BestCombo]
//          '
//          
//          # ItemUnlockIDs (string)
//          |(list incomplete) (grouped by mission) (listed with corresponding rating: GOOD-EXCELLENT-BOUNTY)
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
// $54DD4C: [NTSCJ][11-byte ASCII:PS2GameID]
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - "SLUS_205.00" => JPN PS2 Product ID
// $5511F4: [PAL][32-bit (base) Pointer:MultiplayerRewardMenuData(alt1)] -> [Struct:MultiplayerRewardMenuData]
//          - Prefer using [Pointer:MultiplayerRewardMenuData(preferred)] at $0x54cac8
// $55B6A8: [NTSCU][32-bit (base) Pointer:GatlingGunZoneData] -> [Struct:InteractableZone.GatlingGun]
//          @Regional equivalent of $0x55de28 (PAL)
// $55DE28: [PAL][32-bit (base) Pointer:GatlingGunZoneData] -> [Struct:InteractableZone.GatlingGun]
//          - This pointer seems to point to a node, which is part of a possible LinkedList. The list consists of multiple insstances of [Struct:InteractableZone]; Each AREA/level/mission has its own list; Each 'InteractableZone' seems to contain an interactable item (eg. gatling gun OR shootable lever)
//          - This pointer always points to the node with ASCII:InteractableZoneID = "zone_gunA_01", which is the gatling gun, thus this pointer should only be used for that functionality
//          - This pointer flickers with another pointerAddress when another "Actor" other than the player is shooting the gatling gun
//          
//          [Definition Struct:InteractableZone.GatlingGun |480-byte]
//          |''''''''''''''''''''''''''''''''
//          |+0x1C - [Variable Size ASCII:InteractableZoneID]
//          |¨| - ASCII = "zone_gunA_01"
//          |¨| - Practically this can be used to identify this InteractableZone as the zone used by the GatlingGun
//          |/
//          |+0x169 - [bit0 BitFlag:IsGatlingGunManned]
//          |¨| - Can be manned by AI as well as player
//          |/
//          '
// $5602A0: [NTSCU][32-bit (base) Pointer:GameController] -> [Struct:GameController]
//          @Regional equivalent of $0x562a20 (PAL)
// $562A0C: [PAL][bit0 BitFlag:IsTitleMenuDisplayed(preferred) |32-bit]
//          bit0 = 0 => In-game || Game  Is Booting Up
//          bit0 = 1 => Title Menu
// $562A10: [PAL][8-bit:UserInterfaceRenderStackLevel |32-bit]
//          - This seems to count how many things are rendered on top of each other whilst in-game
//          - This value can be used to check if the game is past the MainMenu
//          
//          # Values
//          |'''''''''
//          | - 0x0 => No UI render?? (unconfirmed) (also during some cutscenes)
//          | - 0x1 => Loading?? (unconfirmed)
//          | - 0x2 => Main Menu
//          | - 0x3 => Game Render?? (unconfirmed)
//          | - 0x4 => Default In-Game HUD
//          | - higherValues => are extra UI on top of the game HUD (eg. the dualshock controller which is rendered during chapter 1, puts this value at 0x5 => then opening the pause menu puts it at 0x6...)
// $562A20: [PAL][32-bit (base) Pointer:GameController] -> [Struct:GameController]
//          
//          [Definition Struct:GameController |??-byte]
//          |===============================================
//          |
//          |+0x1C - [32-bit (layer-1) Pointer]
//          |++0x48 - [32-bit (layer-2) Pointer] -> [Struct:HealthBarHUDController]
//          |++||[Definition Struct:HealthBarHUDController |116-byte]
//          |++||''''''''''''''''''''''''''''''''''''''''''''''''''
//          |++|| - This struct only controls the visual elements for the health bar
//          |++||
//          |++||+0x10 - [32-bit:MaxHP(display)]
//          |++||
//          |++||+0x14 - [32-bit:HP(display)]
//          |/
//          |
//          |+0x20 - [32-bit (layer-1) Pointer] -> [Struct:SpecialMeterGuageController]
//          |+||[Definition Struct:SpecialMeterGuageController |??-byte]
//          |+||''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+|| - This struct controls both the visual display as well as the underlying logic for the special meter (bar below HP bar)
//          |+|| - Special meter is used for special actions such as deadeye or a special move depending on the player's character
//          |+||
//          |+||+0x60 - [32-bit Float:SpecialMeterGauge]
//          |+||
//          |+||+0x64 - [32-bit Float:SpecialMeterMaxGauge]
//          |+||¨| - This value, rounded down to the nearest whole number, equals the number of special meter bars displayed (eg. 3.456 --rounded--> 3 bars)
//          |+||¨| - Each special action costs 1 full bar
//          |+||¨| - Base Max Dead Eye Gauge: 3.0
//          |+||¨| - Each Dead Eye Upgrade increases this bar by 1.0
//          |/
//          |
//          |+0x2C - [32-bit (layer-1) Pointer] -> [Struct:AmmoCounterHUDController]
//          |+||[Definition Struct:AmmoCounterHUDController |??-byte]
//          |+||''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+|| - This struct controls only visual ammo HUD in the bottom-left,
//          |+|| - This struct does not control the functional values of ammunition; functional values are stored via [Array:WeaponData] and [Struct:AmmunitionInventory], refer to $0x7638b8
//          |+||
//          |+||+0x8 - [8-bit:EquippedSecondaryPistolLoadedAmmunition |32-bit]
//          |+||¨| - This value is only functional when dual wielding pistols, this controls the ammo counter behind the main ammo counter
//          |+||¨| - This value only counts the loaded ammo in the secondary weapon. This refers to the bullet icons on the HUD.
//          |+||
//          |+||+0x14 - [32-bit:EquippedWeaponReserveAmmo]
//          |+||¨| - This value counts the reserve ammo + the ammo loaded inside the gun
//          |+||¨| - Max properly displayable value on UI is 0x3e7 (=999)
//          |+||
//          |+||+0x1C - [8-bit:EquippedWeaponLoadedAmmunition |32-bit]
//          |+||¨| - This value only counts the loaded ammo in the weapon. This refers to the bullet icons on the HUD.
//          |+||
//          |+||+0x28 - [8-bit:EquippedWeaponLoadedAmmunition(copy) |32-bit]
//          |+||¨| - This value copies [8-bit:EquippedWeaponLoadedAmmunition |32-bit]
//          |/
//          |
//          |+0xC0 - [32-bit (layer-1) Pointer:ShowdownPosterMenuController] -> [Struct:ShowdownPosterMenuController]
//          |+| - This pointer is only functional at the MainMenu, it is zeroed out once the loading screen for the Showdown match starts
//          |+| - Definition of [Struct:ShowdownPosterMenuController] below
//          |/
//          |
//          |+0x2C9 - [1344-byte Array:ShowdownPlayerSettings_B] List of (4x) [Struct:ShowdownPlayerSettings_B]
//          |+| - This array is only functional during a Showdown match
//          |¨| - Definition of [Struct:ShowdownPlayerSettings_B] at $0x73d819
//          |/
//          |
//          |+0x808 - [Variable Size ASCII:AreaID(alt)]
//          |¨| - Prefer using [ASCII:AreaID(functional)] at $0x6b0808
//          |/
//          |
//          |+0x8FC - [32-bit (layer-1) Pointer]
//          |+| - This pointer is only functional during a Showdown match
//          |+|
//          |+|+0x50 - [584-byte Array] List of (4x) [Struct:ShowdownPlayerSettings_A]
//          |+|¨| - Definition of [Struct:ShowdownPlayerSettings_A] at $0x740438
//          |+|
//          |+|+0x1C8 - [28-byte Struct:ShowdownModeSettings]
//          |+|¨| - Definition of [Struct:ShowdownModeSettings] at $0x7405b0
//          |/
//          |
//          |+0x5874 - [140-byte Struct:CashController]
//          |¨|[Definition Struct:CashController |140-byte]
//          |¨||'''''''''''''''''''''''''''''''''''''''''''
//          |¨|| - This struct controls the visual elements as well as functional values of the player's cash
//          |¨||
//          |¨||+0x8 - [32-bit:Cash(functional)]
//          |¨||¨| - Stored as a signed integer, max properly displayable value on the HUD is 0xF423F (=999 999)
//          |¨||
//          |¨||+0xC - [32-bit:CashAcquiredByOtherMeans]
//          |¨||¨| - Cash picked up on ground (story mode)
//          |¨||¨| - Cash acquired by kills (Showdown mode); Each kill is $500
//          |¨||
//          |¨||+0x10 - [32-bit:Combo]
//          |¨||¨| - Cash awarded for hitting targets/enemies
//          |¨||
//          |¨||+0x14 - [32-bit:ComboMultiplier]
//          |¨||¨| - Increases by 1 for each kill, resets to 1 once the combo is over/cash is awarded
//          |¨||
//          |¨||+0x20 - [32-bit Float:ComboCountdownTimer]
//          |¨||¨| - Timer starts at 3.5; Goes down by about 0.04 each 2 frames (might be different depending on PAL/NTSC mode)
//          |¨||
//          |¨||+0x30 - [32-bit:Cash(copy)]
//          |/
//          |
//          |+0x5904 - [20-byte Array:KeysDisplayed] List of (5x) [BitFlag:IsKeyDisplayed]
//          |¨||[Definition Array:KeysDisplayed |20-byte]
//          |¨||°°°°°°°°°°°°°°°°°°°°°°°°°
//          |¨|| - This array contains bit flags correlating to the HUD display icons for the keys.
//          |¨|| - Functional key bit flags are stored in [Array:KeysAcquired], refer to $0x753AB0
//          |¨||
//          |¨||+0x0 - [bit0 BitFlag(IsKeyDisplayed):Key1]
//          |¨||+0x4 - [bit0 BitFlag(IsKeyDisplayed):Key2]
//          |¨||+0x8 - [bit0 BitFlag(IsKeyDisplayed):Key3]
//          |¨||+0xC - [bit0 BitFlag(IsKeyDisplayed):Key4]
//          |¨||+0x10 - [bit0 BitFlag(IsKeyDisplayed):Key5]
//          |¨||
//          |¨||¨|[Definition BitFlag:IsKeyDisplayed |bit0|32-bit]
//          |¨||¨|'''''''''''''''''''''''''''''''''''''''
//          |¨||¨| bit0 = 1 => Key icon IS displayed
//          |¨||¨| bit0 = 0 => Key icon is NOT displayed
//          |/
//          °
//          
//          [Definition Struct:ShowdownPosterMenuController |1916-byte??]
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+0x48 - [32-bit (layer-2) Pointer]
//          |++0xFD - [bit0 BitFlag:IsShowdownPosterMenuDisplayed |8-bit]
//          |
//          |+0x7C - [32-bit (layer-2) Pointer] -> [Struct(ShowdownCharacterSelectData_A):Player1]
//          |+0x80 - [32-bit (layer-2) Pointer] -> [Struct(ShowdownCharacterSelectData_A):Player2]
//          |+0x84 - [32-bit (layer-2) Pointer] -> [Struct(ShowdownCharacterSelectData_A):Player3]
//          |+0x88 - [32-bit (layer-2) Pointer] -> [Struct(ShowdownCharacterSelectData_A):Player4]
//          |
//          |[Definition Struct:ShowdownCharacterSelectData_A |480-byte]
//          ||'''''''''''''''''''''''''''''''''''''''''''''''''''''''
//          ||+0xFE - [bit0 BitFlag:IsShowdownPlayerSlotFilled |8-bit]
//          ||+0x13D - [3-byte ASCII:CharacterModelID]
//          ||¨| - CharacterModelIDs listed below
//          |'
//          |
//          |+0x46C - [32-bit (layer-2) Pointer]
//          |+|+0x164 - [16-byte Array:ShowdownCharacterSelectIndices] List of (4x) [8-bit:ShowdownCharacterSelectIndex]
//          |+|¨|[Definition Array:ShowdownCharacterSelectIndices |16-byte]
//          |+|¨||''''''''''''''''''''''''
//          |+|¨|| - [8-bit:ShowdownCharacterSelectIndex] corresponds to the index of the 'showdown character' in [Array:ShowdownCharacterData]
//          |+|¨|| - Changing these indices to valid IDs will load that character for that player
//          |+|¨|| - If not all characters are unlocked in [Array:ShowdownCharacterData], then the index only starts counting from the ones which are unlocked (eg. Character 'Pig Josh' is index 0 in [Array:ShowdownCharacterData], but if he's not unlocked, the next character in [Array:ShowdownCharacterData] which is unlocked becomes index 0. Index 1 will then be the next character in [Array:ShowdownCharacterData] which is unlocked and so on...). If no characters are unlocked in [Bitset:ShowdownCharacterUnlocks] the game will crash at the MainMenu
//          |+|¨|| - Identification via this method is only viable via R/R usage; Although there's ways to ID the selected showdown character without it.
//          |+|¨||
//          |+|¨||+0x0 - [8-bit(ShowdownCharacterSelectIndex):Player1 |32-bit]
//          |+|¨||+0x4 - [8-bit(ShowdownCharacterSelectIndex):Player2 |32-bit]
//          |+|¨||+0x8 - [8-bit(ShowdownCharacterSelectIndex):Player3 |32-bit]
//          |+|¨||+0xC - [8-bit(ShowdownCharacterSelectIndex):Player4 |32-bit]
//          |+|/
//          |+|
//          |+|+0x190 - [190-byte Array:ShowdownCharacterData] List of (48x) [32-bit (layer-2) Pointer] -> [Struct:ShowdownCharacterSelectData_B]
//          |+|+|[Definition Struct:ShowdownCharacterSelectData_B |48-byte]
//          |+|+||''''''''''''''''''''''''''''''
//          |+|+|| - This is where the functional data is stored for loading the correct character
//          |+|+||
//          |+|+||+0x1 - [3-byte ASCII:ShowdownCharacterSelectID(string)]
//          |+|+||¨| - Preceding [1-bye ASCII] = "y"
//          |+|+||
//          |+|+||+0x29 - [bit0 BitFlag:IsCharacterLocked]
//          |+|+||¨| - bit0 = 1 => character locked, unavailable to choose
//          |+|+||¨| - bit0 = 0 => character unlocked, available to choose
//          |+|+||
//          |+|+||+0x2C - (unverified) [8-bit:ShowdownCharacterSelectID(numerical) |32-bit]
//          |/
//          |
//          |+0x504 - [304-byte Array] List of (4x) [Struct:ShowdownCharacterSelectUserInterfaceData]
//          |¨| - This array contains one [Struct:ShowdownCharacterSelectUserInterfaceData] for each player, even if that player has not picked a character.
//          |¨|
//          |¨|[Definition Struct:ShowdownCharacterSelectUserInterfaceData |76-byte]
//          |¨||''''''''''''''''''''''''''''''
//          |¨||+0x4 - [Lower4:ShowdownPlayerID |32-bit]
//          |¨||¨| - Value range [0-3] => [Player1-Player4]
//          |¨||
//          |¨||+0x10 - [32-bit (layer-2) Pointer]
//          |¨||++0x130 - [32-bit (layer-3) Pointer] -> [Struct:CharacterHeadshotImageData |??-byte]
//          |¨||++|+0x3C - [16-bit:CharacterHeadshotImageID]
//          |¨||++|¨| - This controls which character's image of the head is shown
//          |¨||++|¨| - CharacterHeadshotImageIDs listed below
//          |¨||/
//          |¨||
//          |¨||+0x34 - [32-bit (layer-2) Pointer]
//          |¨||+|+0x13D - [3-byte ASCII:CharacterModelID(string)]
//          |¨||+|¨| - This value controls the which character's name is displayed under the headshot image
//          |¨||+|¨| - CharacterModelIDs listed below
//          |/
//          |
//          |+0x53C - [8-bit(ShowdownPlayerTeamID):Player1]
//          |+0x588 - [8-bit(ShowdownPlayerTeamID):Player2]
//          |+0x5D4 - [8-bit(ShowdownPlayerTeamID):Player3]
//          |+0x620 - [8-bit(ShowdownPlayerTeamID):Player4]
//          |
//          |[Definition 8-bit:ShowdownPlayerTeamID | 32-bit]
//          ||''''''''''''''''''''''''''''''''''''''''''
//          || - 0x0 => Team Red
//          || - 0x1 => Team White
//          || - 0x2 => Team Blue
//          || - 0x3 => Team Yellow
//          ''
//          
//          # CharacterModelIDs (string) - CharacterHeadshotImageIDs (hex)
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
//          | elt - 0x2F6D => "Kid" Cougar
//          |
//          |---- Non-Playable Characters (list incomplete) ----
//          | frj => George (unplayable character of bossfight trio, fight againt "Bloody" Tom, during lvl_hng)
//          | snp => Sniper NPC, which usually spawns on high ground; Wears a Raccoon hat
//          '
// $563FA0: [NTSCJ][32-bit (base) Pointer:ShowdownModeSettings]
//          |+0x6c - [32-bit (layer-1) Pointer]
//          |++0x50 - [32-bit (layer-2) Pointer] -> [Struct:ShowdownModeSettings]
//          |++|[NTSCJ][Definition Struct:ShowdownModeSettings |??-byte]
//          |++||'''''''''''''''''''''''''''''''''''''''''''''
//          |++|| - This definition is only for NTSCJ
//          |++||
//          |++||+0x1290 - [8-bit:SundownModeFightTimeSetting |32-bit]
//          |++||¨| - 0x0 => 3 min.
//          |++||¨| - 0x1 => 5 min.
//          |++||¨| - 0x2 => 10 min.
//          |++||¨| - 0x3 => 15 min.
//          |++||¨| - 0x4 => 1 min.
//          |++||
//          |++||+0x4B60 - [8-bit:PowerUpSetting |32-bit]
//          |++||¨| - 0x0 => Off
//          |++||¨| - 0x1 => Stud
//          |++||¨| - 0x2 => Hold 'Em
//          |/
//          '
// $6AAA9C: [NTSCU][8-bit Bitfield:AreaState |32-bit]
//          @Regional equivalent of $0x6b0a1c (PAL)
// $6AB928: [NTSCU][32-bit (base) Pointer:MultiplayerRewardMenuData(alt3)]
//          @Regional equivalent of $0x6b18a8 (PAL)
// $6B03F4: [PAL][32-bit (base) Pointer:SoundtrackFileData] -> [ASCII:ActiveSoundtrackFileNameID]
//          @Member of [Struct:Undefined_02] at $0x4fa50c
//          |
//          |+0xC - [32-bit (layer-1) Pointer]
//          |+| - This (layer-1) pointer is only functional when a soundtrack is active
//          |+|
//          |+|+0x0 - [Variable Size ASCII:ActiveSoundtrackFileNameID]
//          |+|¨| - Currently playing soundtrack file
//          |/
//          '
// $6B0808: [PAL][Variable Size ASCII:AreaID(alt)]
//          - This value stores the AreaID for the current map/level
//          - Be wary to check only the necessary bytes to identify the AreaID, don't count the succeeding bytes as there's some bogus data
//          - Changing this value to a valid ID does not work to cheat/load the map
//          - IDs listed at $0x7a0620
// $6B0A1C: [PAL][8-bit Bitfield:AreaState |32-bit]
//          - These values also work for the main menu; as the main menu is an AreaID (= lvl_front)
//          
//          # AreaStates
//          |'''''''''
//          | - 0x2 => In-game (playing in the loaded area/map)
//          | - 0x32 => AreaID is on standby
//          | - 0xFF => Loading new AreaID
// $6B0C99: [PAL][bit0 BitFlag:IsInGame(alt)]
// $6B0C9A: [PAL][bit0 BitFlag:IsNoInMissionShopOpen |8-bit]
//          - 'In Mission Shop' is a shop which is (can be) opened once the mission/level has already started. (eg. Chapter 2 'Bounty Hunter', a shop opens just after intro cutscene; or the shops in Brimstone)
//          - Preceding [bit0 BitFlag |8-bit] = 1 => the mission has started
//          
//          - bit0 = 1 => No In-Mission shop is open
//          - bit0 = 0 => In-Mission shop is open
// $6B18A8: [PAL][32-bit (base) Pointer:MultiplayerRewardMenuData(alt3)]
//          - This pointer is equal to [32-bit (layer-1) Pointer:MultiplayerRewardMenuData_L1-01] at $0x54cac8, thus prefer using [32-bit (base) Pointer:MultiplayerRewardMenuData(preferred)] at that address
// $6B18B4: [PAL][1024-byte ASCIIField:MultiplayerScoreboardDisplayText]
//          =========================================
//          @Fixed Memory Location, although pointed to by [Pointer:MultiplayerRewardMenuData(preferred)] ($0x54cac8)
//          - The data stored in this ASCII Field is used in the display of the showdown mode scoreboard
//          - ASCII Field only updates/should be used when the scoreboard is displayed, otherwise these 1024-bytes may in use by other data
//          - Dynamic number values (eg. Bounty, Shots missed) are calculated or copied from data stored at $0x7638b8
//          - Changing these values will update the corresponding text on the scoreboard
// $6B1A30: [PAL][96-byte ASCIIField(ShowdownPlayerStatsText):Player1]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b18b4)
//          
//          [Definition ASCIIField:ShowdownPlayerStatsText |96-byte]
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x5 - [7-byte ASCII:CollectedCash]
//          |¨| - Preceding [1-byte ASCII] = "$"
//          |
//          |+0xC - [7-byte ASCII:DeathToll]
//          |¨| - This is equal to enemy kill count
//          |
//          |+0x14 - [7-byte ASCII:DamageTaken]
//          |¨| - Succeeding [1-byte ASCII] = "%"
//          |¨| - This value is calculated from data stored at [Struct:ShowdownPlayerData], using formula: (dmgTaken/MaxHP)*100; where default MaxHP = 150.0
//          |
//          |+0x1C - [3-byte ASCII:ShotsFired]
//          |
//          |+0x24 - [3-byte ASCII:ShotsMissed]
//          |
//          |+0x2D - [7-byte ASCII:BestCombo]
//          |¨| - Preceding [1-byte ASCII] = "$"
//          |
//          |+0x34 - [3-byte ASCII:HeadShots]
//          |
//          |+0x3C - [3-byte ASCII:BodyShots]
//          |
//          |+0x44 - [3-byte ASCII:ArmShots]
//          |
//          |+0x4C - [3-byte ASCII:LegShots]
//          |
//          |+0x54 - [3-byte ASCII:BackShots]
//          |
//          |+0x5C - [3-byte ASCII:MeleeHits]
// $6B1A90: [PAL][96-byte ASCIIField(ShowdownPlayerStatsText):Player2]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b18b4)
//          - Definition of [ASCIIField:ShowdownPlayerStatsText] at $0x6b1a30
// $6B1AF0: [PAL][96-byte ASCIIField(ShowdownPlayerStatsText):Player3]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b18b4)
//          - Definition of [ASCIIField:ShowdownPlayerStatsText] at $0x6b1a30
// $6B1B50: [PAL][96-byte ASCIIField(ShowdownPlayerStatsText):Player4]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b18b4)
//          - Definition of [ASCIIField:ShowdownPlayerStatsText] at $0x6b1a30
// $6B3588: [NTSCJ][Variable Size ASCII:AreaID(alt) |16-byte]
//          @Regional equivalent of $0x6b0808 (PAL)
// $6B4634: [NTSCJ][1024-byte ASCIIField:MultiplayerScoreboardDisplayText]
//          @Regional Equivalent of $0x6b18b4 (PAL)
// $6B47B0: [NTSCJ][96-byte ASCIIField(ShowdownPlayerStatsText):Player1]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b4634)
//          @Regional Equivalent of $0x6b1a30
// $6B4810: [NTSCJ][96-byte ASCIIField(ShowdownPlayerStatsText):Player2]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b4634)
//          @Regional Equivalent of $0x6b1a90
// $6B4870: [NTSCJ][96-byte ASCIIField(ShowdownPlayerStatsText):Player3]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b4634)
//          @Regional Equivalent of $0x6b1af0
// $6B48D0: [NTSCJ][96-byte ASCIIField(ShowdownPlayerStatsText):Player4]
//          @Member of [ASCIIField:MultiplayerScoreboardDisplayText] ($0x6b4634)
//          @Regional Equivalent of $0x6b1b50
// $73AF04: [NTSCU][32-bit (base) Pointer:InGameMenuController(preferred)] -> [Struct:InGameMenuController]
//          @Regional equivalent of $0x73d684 (PAL)
// $73AF0C: [NTSCU][bit0 BitFlag:IsInPauseMenu |32-bit]
//          @Regional equivalent of $0x73d68c
// $73B099: [NTSCU][1344-byte Array:ShowdownPlayerSettings_B] List of (4x) [Struct:ShowdownPlayerSettings_B]
//          @Regional equivalent of $0x73d819 (PAL)
// $73B5EC: [NTSCU][8-bit:NumberOfPlayers |32-bit]
//          @Regional equivalent of $0x73dd6c (PAL)
// $73B7C2: [NTSCU][30-byte Struct:PlayerInputReader]
//          @Regional equivalent of $0x73df42 (PAL)
// $73D60C: [PAL][32-bit Pointer:InGameMenuController(alt)] -> [Struct:InGameMenuController]
//          @Fixed Memory Location. Although pointed to by one of the pointers at [$0x562a20-$0x562a60]
//          - This pointer is only functional when an InGameMenu has been displayed at least once
//          - This pointer only changes values/points to another/new [Struct:InGameMenuController] whenever the pauseMenu, RetryMenu/continueMenu or GameOverScreen is rendered. Therefor any "SubMenu's" can't be identified via this pointer, prefer using [Pointer:InGameMenuController(preferred)] at $0x73d684
// $73D684: [PAL][32-bit (base) Pointer:InGameMenuController(preferred)] -> [Struct:InGameMenuController]
//          @Fixed Memory Location. Although pointed to by one of the pointers at [$0x562a20-$0x562a60]
//          - This pointer is only functional when an InGameMenu has been displayed at least once
//          - This pointer changes values/points to another/new [Struct:InGameMenuController] whenever another menu is opened
//          
//          [Definition Struct:InGameMenuController |??-byte]
//          |============================================
//          |+0x18 - [Variable size ASCII:InGameMenuID]
//          |¨| - InGameMenuIDs listed below
//          |/
//          |+0x38 - [bit0 BitFlag:IsInGameMenuDisplayed |8-bit]
//          |¨| - bit0 = 1 => InGameMenu IS displayed
//          |¨| - bit0 = 0 => InGameMenu is NOT displayed
//          |/
//          |+0x39 - [bit0 InvertedBitFlag:IsInGameSubMenuDisplayed |8-bit]
//          |¨| - bit0 =  1 => No SubMenu displayed
//          |¨| - bit0 =  0 => Any SubMenu is displayed
//          |/
//          |+0x3C - [28-byte Array] List of (7x) [32-bit (layer-1) Pointer]
//          |¨| - These pointers mostly point to miscellaneous data
//          |¨| - Some of these pointers point to structs storing ASCII text which are used as the displaytext for the InGameMenu
//          |/
//          |+0x318 - [8-bit:HighlightedMenuItemID]
//          |¨| - HighlightedMenuItemIDs are dependent on InGameMenu
//          |¨| - HighlightedMenuItemIDs listed below
//          |/
//          |+0x450 - [32-bit Float:RetryMenuCountdownTimer]
//          |¨| - Value range [9.9-0.0]; When this hits 0 => 'Game Over' screen
//          |¨| - Decrements each frame
//          |¨| - This value in only functional when the RetryMenu is rendered
//          |/
//          '
//          
//          # InGameMenuIDs (string) - HighlightedMenuItemIDs (hex)
//          |(list incomplete)
//          |'''''''''''''''''
//          | pause (InGameMenuID) => PauseMenu
//          | - 0x4 (HighlightedMenuItemID) => Return to Game
//          | - 0x5 => Options
//          | - 0x9 => Restart Level
//          | - 0xA => Quit
//          | continue => RetryMenu
//          | - 0x5 => No
//          | - 0x4 => Yes
//          | gameover => GameOverScreen
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
// $73D68C: [PAL][bit0 BitFlag:IsInPauseMenu |32-bit]
//          - PauseMenu during gameplay
//          - Also counts for sub-menu's
// $73D819: [PAL][1344-byte Array:ShowdownPlayerSettings_B] List of (4x) [Struct:ShowdownPlayerSettings_B]
//          @Fixed Memory Location. Although pointed to by [Pointer:GameController] $0x562a20
//          
//          [Definition Array:ShowdownPlayerSettings_B |1344-byte]
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - This array is populated on the start of a Showdown match; it remains populated after the match ends and also when the game goes back to MainMenu; It is only overwritten when starting a new Showdown match.
//          | - Each showdown player slot has a dedicated [Struct:ShowdownPlayerSettings_B] even if that player slot is empty
//          |
//          |+0x0 - [Struct(ShowdownPlayerSettings_B):Player1]
//          |+0x150 - [Struct(ShowdownPlayerSettings_B):Player2]
//          |+0x2A0 - [Struct(ShowdownPlayerSettings_B):Player3]
//          |+0x3F0 - [Struct(ShowdownPlayerSettings_B):Player4]
//          |
//          |[Definition Struct:ShowdownPlayerSettings_B |336-byte]
//          ||''''''''''''''''''''''''''''''''''''''''''''''''''
//          || - Very similar to [Struct:ShowdownPlayerSettings_A], refer to $0x740438
//          ||
//          ||+0x1 - [3-byte ASCII:CharacterModelID]
//          ||¨| - Preceding [1-byte ASCII] = "m"; This "m" is zeroed when no player fills this player slot
//          ||¨| - CharacterModelIDs listed at $0x562a20
//          ||/
//          |+0xB- [Lower4:TeamID |32-bit]
//          ||¨| - 0 => Team Red
//          ||¨| - 1 => Team White
//          ||¨| - 2 => Team Blue
//          ||¨| - 3 => Team Yellow
//          ||/
//          |+0xF - [Lower4:ShowdownPlayerID |32-bit]
//          ||¨| - Value range [0-3] => [Player1-Player4]
//          ||/
//          ||+0x13 - [bit0 BitFlag:IsShowdownPlayerSlotFilled |32-bit]
//          ||
//          ||+0x139 - [Variable Size ASCII:ShowdownAISetting]
//          ||¨| - This probably identifies which AI script is used for the CPU player
//          ||¨| - Practically this value could be used to check which showdown player are human controlled
//          ||¨| - ShowdownAISettings listed below
//          ||
//          ''
//          
//          # ShowdownAISettings (string)
//          |(list incomplete)
//          |''''''''''''''''''''''''''''''
//          | MPplayer => no AI, Human player controlled
//          | defaultbot
//          | bigbot
//          | pixiebot
//          | sniperbot
//          | sneakybot
//          | ...
//          '
// $73DCB8: [NTSCU][365-byte Array:ShowdownPlayerSettings_A] List of (4x) [Struct:ShowdownPlayerSettings_A]
//          @Regional equivalent of $0x740438 (PAL)
// $73DD6C: [PAL][8-bit:NumberOfPlayers |32-bit]
//          - This value does not reset to a default value on title screen
//          
//          # Values
//          |''''''''
//          | - 0x1 => Single Player Campaign
//          | - [0x2-0x4] => Showdown Mode
// $73DE30: [NTSCU][32-bit (base) Pointer:ShowdownModeSettings]
//          @Regional equivalent of $0x7405b0 (PAL)
// $73DE4C: [NTSCU][28-byte Bitset:SharedUnlocks]
//          @Regional equivalent of $0x7405cc (PAL)
// $73DE88: [NTSCU][17040-byte Array:PlayerProfileData] List of (6x) [Struct:PlayerProfileData]
//          @Regional equivalent of $0x740608 (PAL)
// $73DF42: [PAL][30-byte Struct:PlayerInputReader]
//          [Definition Struct:PlayerInputReader|30-byte]
//          |°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//          |
//          |+0x0 - [2-byte Bitset:ControllerButtonsPressed]
//          |[Definition Bitset:ControllerButtonsPressed |2-byte]
//          ||''''''''''''''''''''''''''''''''''''''''''''
//          || - Bitset consists of Inverted Bit Flags: bitValue = 1 => button is NOT pressed; bitValue = 0 => button IS pressed
//          ||
//          ||+0x0 - [InvertedBitFlags of Bitset(byte1):ControllerButtonsPressed]
//          ||¨| bit0 => Select
//          ||¨| bit1 => L3
//          ||¨| bit2 => R3
//          ||¨| bit2 => Start
//          ||¨| bit4 => D-pad up
//          ||¨| bit5 => D-pad right
//          ||¨| bit6 => D-pad down
//          ||¨| bit7 => D-pad left
//          ||
//          ||+0x1 - [InvertedBitFlags of Bitset(byte2):ControllerButtonsPressed]
//          ||¨| bit0 => L2
//          ||¨| bit1 => R2
//          ||¨| bit2 => L1
//          ||¨| bit3 => R1
//          ||¨| bit4 => 🛆
//          ||¨| bit5 => ◌
//          ||¨| bit6 => X
//          ||¨| bit7 => ⬚
//          |/
//          |
//          |+0x2 - [16-bit:RightJoystickAngleAndTilt]
//          |
//          |+0x4 - [16-bit:LeftJoystickAngleAndTilt]
//          '
// $73ED98: [NTSCJ][1344-byte Array] List of [(4x) 336-byte Struct:ShowdownPlayer_Settings]
//          @Regional Equivalent of $0x73d819
// $73F2EC: [NTSCJ][8-bit:NumberOfPlayers |32-bit]
//          @Regional Equivalent of $0x73dd6c
// $740118: [NTSCJ][17040-byte Array:PlayerProfileData] List of (6x) [Struct:PlayerProfileData]
//          @Regional Equivalent of $0x740608
//          @Fixed Memory Location. Although pointed to by $0x7443e8
// $740438: [PAL][368-byte Array:ShowdownPlayerSettings_A] List of (4x) [Struct:ShowdownPlayerSettings_A]
//          @Fixed Memory Location. Although pointed to by [Pointer:GameController] ($0x562a20)
//          
//          [Definition Array:ShowdownPlayerSettings_A |368-byte]
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - This array is populated on the start of a Showdown match; it remains populated after the match ends and also when the game goes back to MainMenu; It is only overwritten when starting a new Showdown match.
//          | - This array is also populated in Single Player Campaign, with one (first) entry for the protagonist character
//          | - Each showdown player slot has a dedicated [Struct:ShowdownPlayerSettings_A] even if that player slot is empty
//          |
//          |+0x0 - [Struct(ShowdownPlayerSettings_A):Player1]
//          |+0x5C - [Struct(ShowdownPlayerSettings_A):Player2]
//          |+0xB8 - [Struct(ShowdownPlayerSettings_A):Player3]
//          |+0x114 - [Struct(ShowdownPlayerSettings_A):Player4]
//          |
//          |[Definition Struct:ShowdownPlayerSettings_A |92-byte]
//          ||''''''''''''''''''''''''''''''''''''''''''''''''''
//          || - Very similar to [Struct:ShowdownPlayerSettings_B] ($0x73d819)
//          ||
//          ||+0x0 - [Lower4:TeamID |32-bit]
//          ||¨| - 0 => Team Red
//          ||¨| - 1 => Team White
//          ||¨| - 2 => Team Blue
//          ||¨| - 3 => Team Yellow
//          ||¨| - F => Player Slot is Empty (whole 32-bit value is 0xFFFFFFFF)
//          ||/
//          ||+0x5 - [3-byte ASCII:CharacterModelID]
//          ||¨| - Preceding [1-byte ASCII] = "m"; This "m" is zeroed when no player fills this player slot
//          ||¨| - CharacterModelID listed at $0x562a20
//          ||/
//          ||+0x36 - [Variable Size ASCII:ShowdownAISetting]
//          ||¨| - This probably identifies which AI script is used for the CPU player
//          ||¨| - Practically this value could be used to check which showdown player are human controlled
//          ||¨| - This is only populated in a Showdown match
//          ||¨| - ShowdownAISettings listed at $0x73d819
//          |/
//          '
// $7405B0: [PAL][28-byte Struct:ShowdownModeSettings]
//          @Fixed Memory Location. Although pointed to by [Pointer:GameController] ($0x562a20) and [Pointer:UndefinedStruct_01] ($0x7448a0)
//          
//          [PAL][NTSCU][Defintion Struct:ShowdownModeSettings |28-byte]
//          |''''''''''''''''''''''''''''''''''''''
//          | - This definition is only valid for PAL and NTSCU; for NTSCJ refer to $0x563fa0
//          |
//          |+0x0 - [Lower4:GameMode |32-bit]
//          |"| 0 => Bounty Hunter (achieve bounty/cash target)
//          |"| 1 => Sundown (most bounty/cash at end of timer)
//          |"| 2 => High Noon (standoff/face-off)
//          |/
//          |+0x4 - [Lower4:BountyHunterModeBountyLimitSetting |32-bit]
//          |"| - Functional bounty limit amount is stored at $0x7448a8
//          |"| 0 => 3 000
//          |"| 1 => 5 000
//          |"| 2 => 10 000
//          |"| 2 => 15 000
//          |"| 4 => 20 000
//          |/
//          |+0x8 - [Lower4:SundownModeFightTimeSetting |32-bit]
//          |"| - Functional Fight Time Timer through $0x562a30
//          |"| 0 => 3 min.
//          |"| 1 => 5 min.
//          |"| 2 => 10 min.
//          |"| 3 => 15 min.
//          |"| 4 => 1 min.
//          |/
//          |+0xC - [Lower4:HighNoonModeNumberOfWinsSetting |32-bit]
//          |"| 0 => 3 wins
//          |"| 1 => 5 wins
//          |"| 2 => 7 wins
//          |"| 3 => 10 wins
//          |"| 4 => 1 wins
//          |/
//          |+0x18 - [Lower4:PowersUpsSetting |32-bit]
//          |"| 0 => Off
//          |"| 1 => Stud
//          |"| 2 => Hold 'Em
//          |/
//          '
// $7405CC: [PAL][28-byte Bitset:SharedUnlocks]
//          @Fixed Memory Location. Although pointed to by [Pointer:UndefinedStruct_01] ($0x7448a0)
//          - This bitset is saved to the main/global save file. It is shared across multiple PlayerProfiles. Deleting all PlayerProfiles would still keep the unlocks, unless the main save file is deleted.
//          - This bitset handles unlocks for cheats, showdown characters, showdown maps and journal pages
//          - This bitset is updated on save according to [Bitset:Player_Profile_Unlocks] ($0x763070)
//          
//          [PAL][2-byte Bitset:CheatUnlocks]
//          @Sub-bitset of [Bitset:SharedUnlocks] ($0x7405cc)
//          - This Sub-bitset consists of 7 unlockable flags and 3 non-unlockable "debug" flags
//          - Related [Bitset:ActivatedCheats], defined at $0x740608
//          
//          [PAL][BitFlags of Bitset(byte1):CheatUnlocks] ($0x7405cc)
//          bit0 => Cheat (non-unlockable debug feature) - Big Money (gain $10 000)
//          bit1 => Cheat - Golden Gun (significantly increases damage vs AI)
//          bit2 => Cheat - Infinite Deadeye
//          bit3 => Cheat - Invincibility
//          bit4 => Cheat (non-unlockable debug feature) - Show AI Info (doesn't work out-of-the-box)
//          bit5 => Cheat (non-unlockable debug feature) - Show Player Position (doesn't work out-of-the-box)
//          bit6 => Cheat - Bite the Bullet (hardcore mode, significantly increases damage vs player and AI)
//          bit7 => Cheat - Sad Stars (replaces blood splatters with a special effect)
// $7405CD: [PAL][19-byte Bitset:JournalPageUnlocks]
//          @Sub-bitset of [Bitset:SharedUnlocks] ($0x7405cc)
//          - This Sub-bitset consists of 137 flags; although the Journal consists of 138 sections; [bit6 BitFlag of Bitset(byte13):SharedUnlocks] unlocks 2 journal sections.
//          - This Sub-bitset handles the unlocks for journal pages
//          
//          [PAL]
//          [BitFlags of Bitset(byte2):CheatUnlocks] ($0x7405cc)
//          [BitFlags of Bitset(byte1):JournalPageUnlocks] ($0x7405cd)
//          ---- Cheats ----
//          bit0 => Cheat - No HUD
//          bit1 => Cheat - No Distortion
//          ---- JournalPages ----
//          bit2 => Outlaws in Twelve States - Smiley Fawler
//          bit3 => Outlaws in Twelve States - Bandito
//          bit4 => Heroes of the Frontier - Annie
//          bit5 => Ranged Weapons - Bayonet Rifle
//          bit6 => Wanted Dead or Alive - Dan
//          bit7 => Heroes of the Frontier - Buffalo
// $7405CE: [PAL][BitFlags of Bitset(byte2):JournalPageUnlocks] ($0x7405cd)
//          bit 0 => Outlaws in Twelve States - Cooper
//          bit 1 => Citizens of the Wilderness - Black Elk Tribe
//          bit 2 => Wanted Dead or Alive - Mr. Black
//          bit 3 => Good People of Brimstone - Cheryl-Lynn
//          bit 4 => Wanted Dead or Alive - Rico Pedrosa
//          bit 5 => Wanted Dead or Alive - Roberto Pedrosa
//          bit 6 => Prof. Perry's Peculiarities - Asada
//          bit 7 => Ranged Weapons - Breech Loader
// $7405CF: [PAL][BitFlags of Bitset(byte3):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Protectors of Brimstone - Sergeant Marquez
//          bit1 => Citizens of the Wilderness - Fred Kenyon
//          bit2 => /
//          bit3 => Wanted Dead or Alive - Bad Bessie
//          bit4 => Prof. Perry's Peculiarities - Clyde Slade
//          bit5 => Citizens of the Wilderness - Running Moon
//          bit6 => Ugly Chris Gang - Chicken
//          bit7 => Citizens of the Wilderness - Sheriff O'Grady
// $7405D0: [PAL][BitFlags of Bitset(byte4):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Good People of Brimstone - Christina
//          bit1 => Memories of the Past - Falling Star + Young Red Harlow + Nate Harlow (unlocks 3 pages, but this bitflag effectively counts for: Nate Harlow)
//          bit2 => /
//          bit3 => Renegade Army - General Javier Diego
//          bit4 => /
//          bit5 => Thrown Weapons - Dynamite
//          bit6 => Battle Royale Contestants - Kid Cougar
//          bit7 => Ranged Weapons - Escopeta
// $7405D1: [PAL][BitFlags of Bitset(byte5):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Wanted Dead or Alive - Loaf Whitney
//          bit1 => Wanted Dead or Alive - Greg 'Big Oaf' Whitney
//          bit2 => Wanted Dead or Alive - Bloody Tom
//          bit3 => Ugly Chris Gang - Whiskey
//          bit4 => Prof. Perry's Peculiarities - Lightning Larouche
//          bit5 => /
//          bit6 => Outlaws in Twelve States - Gordon "Digs" Fowler
//          bit7 => Ranged Weapons - Halcon Rifle
// $7405D2: [PAL][BitFlags of Bitset(byte6):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Ugly Chris Gang - Hedgehog
//          bit1 => Ranged Weapons - High Caliber
//          bit2 => Wanted Dead or Alive - Harry 'Hatchet' Schultz
//          bit3 => /
//          bit4 => /
//          bit5 => Side Arms - Inquisitor
//          bit6 => /
//          bit7 => Heroes of the Frontier - Jack Swift
// $7405D3: [PAL][BitFlags of Bitset(byte7):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Good People of Brimstone - Jody
//          bit1 => Wanted Dead or Alive - Jesse Lynch
//          bit2 => Protectors of Brimstone - Sherrif Bartlett
//          bit3 => Thrown Weapons - Knife
//          bit4 => Citizens of the Wilderness - Katie O'Grady
//          bit5 => Renegade Army - The Duellist
//          bit6 => Frontier Places - Brimstone Saloon
//          bit7 => Frontier Places - Border Bridge
// $7405D4: [PAL][BitFlags of Bitset(byte8):JournalPageUnlocks] ($0x7405cd)
//          ---- Frontier Places ----
//          bit0 => Sunset Canyon
//          bit1 => The Jail
//          bit2 => Fort Diego
//          bit3 => Fairgrounds
//          bit4 => Tarnation
//          bit5 => Twin Rocks
//          bit6 => Mansion
//          bit7 => Broken Creek
// $7405D5: [PAL][BitFlags of Bitset(byte9):JournalPageUnlocks] ($0x7405cd)
//          ---- Frontier Places ----
//          bit0 => Annie's Ranch
//          bit1 => Widow's Patch
//          bit2 => Widow's Patch, Night
//          bit3 => Brimstone
//          bit4 => Diego's Railroad
//          bit5 => Pan-Atllantic Railroad
//          bit6 => Bear Mountain
//          ---- Other ----
//          bit7 => Prof. Perry's Peculiarities - The Clowns
// $7405D6: [PAL][BitFlags of Bitset(byte10):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Merchants of Brimstone - Manny Quinn
//          bit1 => Thrown Weapons - Fire Bottle
//          bit2 => Memories of the Past - Falling Star + Young Red Harlow (unlocks 2 pages, but this bit flag  effectively counts for: Falling Star)
//          bit3 => Outlaws in Twelve States - Udo Kang
//          bit4 => Memories of the Past - Falling Star + Young Red Harlow (unlocks 2 pages, but this bit flag  effectively counts for: Young Red Harlow)
//          bit5 => Battle Royale Contestants - Mr. Kelley
//          bit6 => Outlaws in Twelve States - Standing Snake
//          bit7 => Citizens of the Wilderness - Grizzly
// $7405D7: [PAL][BitFlags of Bitset(byte11):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Outlaws in Twelve States - Smitty
//          bit1 => Outlaws in Twelve States - Juan "Loco" Sanchez
//          bit2 => Citizens of the Wilderness - Blind Willy Wilson
//          bit3 => Good People of Brimstone - Jebidah Cole
//          bit4 => Good People of Brimstone - Mathias Lampry
//          bit5 => Good People of Brimstone - Sandy Dodge
//          bit6 => Good People of Brimstone - Verne Wiggins
//          bit7 => Good People of Brimstone - Abigail
// $7405D8: [PAL]
//          [BitFlags of Bitset(byte13):SharedUnlocks] ($0x7405cc)
//          [BitFlags of Bitset(byte12):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Good People of Brimstone - Lily Belle
//          bit1 => Renegade Army - Pvt. 'Ripper' Hernandez
//          bit2 => Good People of Brimstone - Natalie
//          bit3 => Side Arms - Old Pistol
//          bit4 => Ranged Weapons - Oppressor
//          bit5 => Ranged Weapons - Owl Rifle
//          bit6 => Merchants of Brimstone - Doc Weatherby + Percy Merriweather (unlocks 2 pages)
//          bit7 => Merchants of Brimstone - Carnaby Peabody
// $7405D9: [PAL][BitFlags of Bitset(byte13):JournalPageUnlocks] ($0x7405cd)
//          bit0 => /
//          bit1 => Merchant of Brimstone - Ralph Clover
//          bit2 => Merchant of Brimstone - Woodrow Klein
//          bit3 => Merchant of Brimstone - Fitch
//          bit4 => Merchant of Brimstone - Hanz Kenyon
//          bit5 => Side Arms - Pacificador
//          bit6 => Renegade Army - Pick Axe Miller
//          bit7 => Outlaws in Twelve States - Father Driscoll
// $7405DA: [PAL][BitFlags of Bitset(byte14):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Prof. Perry's Peculiarities - Pig Josh
//          bit1 => Outlaws in Twelve States - Bad Bob Larson
//          bit2 => Prof. Perry's Peculiarities - Professor Perry
//          bit3 => /
//          bit4 => Citizens of the Wilderness - Red Wolf Tribe
//          bit5 => Ranged Weapons - Repeater Rifle
//          bit6 => Side Arms - Revolver
//          bit7 => Outlaws in Twelve States - Jethro Greensleves
// $7405DB: [PAL][BitFlags of Bitset(byte15):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Prof. Perry's Peculiarities - Atlas Jones
//          bit1 => Renegade Army - Lieutenant Cleu
//          bit2 => /
//          bit3 => Ranged Weapons - Sawn Off
//          bit4 => Citizens of the Wilderness - Gabby Brennan
//          bit5 => Side Arms - Scorpion
//          bit6 => Renegade Army - Private Hanson
//          bit7 => Protectors of Brimstone - Rat Chavez
// $7405DC: [PAL][BitFlags of Bitset(byte16):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Protectors of Brimstone - Mad Dog Jones
//          bit1 => Protectors of Brimstone - The Cornet Brothers
//          bit2 => Protectors of Brimstone - Jason Cornet
//          bit3 => Renegade Army - Captain Bufias
//          bit4 => Citizens of the Wilderness - Curly Shaw
//          bit5 => Side Arms - Six Shooter
//          bit6 => Thrown Weapons - Snake Oil
//          bit7 => Outlaws in Twelve States - Jacques
// $7405DD: [PAL][BitFlags of Bitset(byte17):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Heroes of the Frontier - Red
//          bit1 => Outlaws in Twelve States - Sidney "Sissy" Fess
//          bit2 => Wanted Dead or Alive - Longhorn Luke
//          bit3 => Wanted Dead or Alive - Holstein Hal
//          bit4 => Wanted Dead or Alive - Sam
//          bit5 => Citizens of the Wilderness - Hank Pullman
//          bit6 => Ranged Weapons - The Lion
//          bit7 => Heroes of the Frontier - Shadow Wolf
// $7405DE: [PAL][BitFlags of Bitset(byte18):JournalPageUnlocks] ($0x7405cd)
//          bit0 => Ranged Weapons - Twelve Gauge
//          bit1 => Outlaws in Twelve States - Twiggy Phelps
//          bit2 => Side Arms - Twin Revolvers
//          bit3 => Ugly Chris Gang - Ugly Chris
//          bit4 => Side Arms - Widowmaker
//          bit5 => Ugly Chris Gang - Gigolo
//          bit6 => Protectors of Brimstone - Governor Griffon
//          bit7 => Good People of Brimstone - Tameri
// $7405DF: [PAL][3-byte Bitset:ShowdownMapUnlocks]
//          @Sub-bitset of [Bitset:SharedUnlocks] ($0x7405cc)
//          - This Sub-bitset handles the unlocks for showdown maps
//          - This Sub-bitset consists of 13 flags
//          - The Xbox version may have 1 extra showdown map/stage
//          
//          [PAL]
//          [BitFlags of Bitset(byte19):JournalPageUnlocks] ($0x7405cd)
//          [BitFlags of Bitset(byte1):ShowdownMapUnlocks] ($0x7405df)
//          ---- Journal Pages ----
//          bit0 => Renegade Army - Colonel Daren
//          bit1 => Ranged Weapons - Zwei Fasser
//          bit2 => Outlaws in Twelve States - Oscar Navarro
//          bit3 => Outlaws in Twelve States - Paul "Swig" Bennet
//          bit4 => Battle Royale Contestant - Gabriel Navarro
//          ---- Showdown Maps ----
//          bit5 => The Bridge - Contested Structure
//          bit6 => Sunset Canyon - Desert Badlands
//          bit7 => The Mine - Lost Inheritance
// $7405E0: [BitFlags of Bitset(byte2):ShowdownMapUnlocks] ($0x7405df)
//          bit0 => Fallen Creek - Snow-topped Mountain
//          bit1 => Desert Fortress - Giant Fortress
//          bit2 => Fairground - Ruined Homestead
//          bit3 => Ghost Town - Abandoned Settlement
//          bit4 => Twin Rocks - Ancient Monoliths
//          bit5 => The Mansion - Opulent Palace
//          bit6 => /
//          bit7 => Mansion Grounds - Tended Gardens
// $7405E1: [PAL][7-byte Bitset:ShowdownCharacterUnlocks]
//          @Sub-bitset of [Bitset:SharedUnlocks] ($0x7405cc)
//          - This sub-bitset handles the unlocks for showdown characters
//          - This sub-bitset consists of 48 flags
//          
//          [PAL]
//          [BitFlags of Bitset(byte3):ShowdownMapUnlocks] ($0x7405df)
//          [BitFlags of Bitset(byte1):ShowdownCharacterUnlocks] ($0x7405e1)
//          ---- Showdown Maps ----
//          bit0 => Broken Creek - Boyhood Home
//          bit1 => The Ranch - Fertile Land
//          bit2 => /
//          bit3 => Widows Patch - Terrified Town
//          bit4 => /
//          ---- Showdown Characters ----
//          bit5 => "Smiley" Fawler
//          bit6 => Annie Stoakes
//          bit7 => Dan
// $7405E2: [PAL][BitFlags of Bitset(byte2):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => Buffalo
//          bit1 => Cooper
//          bit2 => Mr. Black
//          bit3 => Rico Pedrosa
//          bit4 => Bad Bessie
//          bit5 => "The Blade" Slade
//          bit6 => Chicken
//          bit7 => Sheriff O'Grady
// $7405E3: [PAL][BitFlags of Bitset(byte3):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => Christina
//          bit1 => Nate Harlow
//          bit2 => General Diego
//          bit3 => "Kid" Cougar
//          bit4 => "Big Oaf" Whitney
//          bit5 => "Bloody" Tom
//          bit6 => "Gigolo" Hancock
//          bit7 => "Dig" Fowler
// $7405E4: [PAL][BitFlags of Bitset(byte4):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => "Hedgehog" Thornton
//          bit1 => Jack Swift
//          bit2 => Sheriff Bartlett
//          bit3 => Katie O'Grady
//          bit4 => Fidgit
//          bit5 => Manny Quinn
//          bit6 => Falling Star
//          bit7 => Udo Kang
// $7405E5: [PAL][BitFlags of Bitset(byte5):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => Red Jr.
//          bit1 => Mr. Kelley
//          bit2 => Standing Snake
//          bit3 => Grizzly
//          bit4 => Smitty
//          bit5 => Natalie
//          bit6 => "Pig" Josh
//          bit7 => Professor Perry
// $7405E6: [PAL][BitFlags of Bitset(byte6):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => Jason Cornet
//          bit1 => "Curly" Shaw
//          bit2 => Red
//          bit3 => "Sissy" Fess
//          bit4 => Holstein Hal
//          bit5 => Sam
//          bit6 => Shadow Wolf
//          bit7 => "Twiggy" Phelps
// $7405E7: [PAL][BitFlags of Bitset(byte7):ShowdownCharacterUnlocks] ($0x7405e1)
//          bit0 => "Ugly" Chris
//          bit1 => "Whiskey" Treadwell
//          bit2 => Governor Griffon
//          bit3 => Colonel Daren
//          bit4 => Gabriel Navarro
//          bits[5-7] => /
// $740608: [PAL][17040-byte Array:PlayerProfileData] List of (6x) [Struct:PlayerProfileData]
//          @Fixed Memory Location. Although pointed to by [Pointer:UndefinedStruct_01] ($0x7448a0)
//          
//          [Definition Array:PlayerProfileData |17040-byte]
//          |''''''''''''''''''''''''''''''''''''''''''
//          | - A max of 6 PlayerProfiles can be made (for the story mode); Each PlayerProfile has its own data storage.
//          | - The active or last used PlayerProfile is pointed to by [Pointer:ActivePlayerProfile] at $0x7448d8
//          | - Defintion of [Struct:PlayerProfileData] below
//          |
//          |+0x0 - [2840-byte Struct(PlayerProfileData):ProfileSlot1]
//          |+0xB18 - [2840-byte Struct(PlayerProfileData):ProfileSlot2]
//          |+0x1630 - [2840-byte Struct(PlayerProfileData):ProfileSlot3]
//          |+0x2148 - [2840-byte Struct(PlayerProfileData):ProfileSlot4]
//          |+0x2C60 - [2840-byte Struct(PlayerProfileData):ProfileSlot5]
//          |+0x3778 - [2840-byte Struct(PlayerProfileData):ProfileSlot6]
//          '
//          
//          [Definition Struct:PlayerProfileData |2840-byte]
//          |''''''''''''''''''''''''''''''''''''''''''
//          | - This struct only updated on certain instances; most values/members of this struct do not update at runtime/during gameplay; mostly on save this struct updates
//          | - Some of members/values of this struct are used to display PlayerProfile stats in the Journal at the MainMenu, in the last section/Chapter called "Frontier Battles"
//          |
//          |+0x0 - [32-bit Float:MaxHP]
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:HealthBarHUDController] ($0x562a20) and the HP at [Struct:SinglePlayerData] ($0x763070)
//          |/
//          |+0x4 - [32-bit Float:SpecialMeterMaxGauge]
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:SpecialMeterGuageController] ($0x562a20)
//          |/
//          |+0x8 - [32-bit:SavedCash]
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:CashController] ($0x562a20)
//          |¨| - This value only updated on save
//          |/
//          |+0xC - [24-byte Bitset:Player_Profile_Unlocks]
//          |¨| - This is a copy of [Bitset:Player_Profile_Unlocks] stored via $0x763070, the bitset here is updated on save, based on that bitset
//          |¨| - Defintion of [Bitset:Player_Profile_Unlocks] at $0x763070
//          |/
//          |+0x23C - [Variable Size ASCII(AreaID):FurthestCompletedStoryChapter(alt1) | 16-byte]
//          |¨| - The first ASCII letter of this AreaID may be zeroed out (eg. "lvl_mansroof" => " vl_mansroof")
//          |¨| - Documentation on [ASCII:AreaID] at $0x7a0620
//          |/
//          |
//          |+0x28C - [32-bit:StoryModeRetryCount]
//          |¨| - This value only counts retries that went through the RetryMenu (refer to [Struct:InGameMenuController].[ASCII:InGameMenuID]); This value does not count 'restarts' or 'replays'
//          |/
//          |
//          |+0x290 - (unverified) [8-bit:CurrentDifficultyStatModifier |16-bit]
//          |¨| - This value may correlate to enemy and player stat scaling
//          |/
//          |+0x292 - [8-bit:CurrentDifficultyID |16-bit]
//          |¨| - This value determines which difficulty is selected for the current playthrough
//          |¨| - Difficulty is only selectable when starting a 'New Game' of Story Mode
//          |¨| - Changing this value manually mid-playthrough, will change the difficulty on the next mission/chapter load
//          |¨|
//          |¨|# DifficultyIDs
//          |¨||'''''''''''''''
//          |¨|| - 0x0 => Normal
//          |¨|| - 0x1 => Hard
//          |¨|| - 0x2 => Very Hard
//          |¨|| - 0x3 => Red Wood Revolver
//          |/
//          |
//          |+0x294 - [32-bit:StoryModeEnemiesKilled_A]
//          |+0x298 - [32-bit:StoryModeEnemiesKilled_B]
//          |¨| - For some reason, in some chapters or for certain instances: [32-bit:StoryModeEnemiesKilled_A] increments for each kill and in other instances [32-bit:StoryModeEnemiesKilled_B] increments
//          |¨| - Formula: TotalNumberOfEnemiesKilled(StoryMode) = [32-bit:StoryModeEnemiesKilled_A] + [32-bit:StoryModeEnemiesKilled_B]
//          |/
//          |+0x384 - [32-bit:DistanceTravelled]
//          |+0x388 - [32-bit Float:TimeSpentPlaying]
//          |¨| - Time in seconds
//          |¨| - Max Float Value = 0x7F7FFFFF, does not overflow/reset back to 0, which is practically millions of billions of years
//          |¨| - This float value initializes the display value in the Journal as a signed int, which is probably why the max displayable value is 596523h 14m 07s
//          |¨| - This value is updated whenever the game saves/a mission is manually restarted via the pause menu/a mission is quit/prior to the retry menu being displayed
//          |/
//          |+0x39C - [32-bit:TotalMoneyCollected]
//          |+0x3A0 - [32-bit:TotalBulletsFired]
//          |+0x3A4 - [32-bit:TotalBulletsHits]
//          |+0x3BC - [32-bit:TotalMoneySpent]
//          |+0x3B0 - [32-bit:TotalHeadShots]
//          |+0x3C8 - [32-bit:DeadeyeOrSpecialMoveUseCount]
//          |+0x3CC - [32-bit:HighestComboMultiplier]
//          |+0x3D0 - [32-bit Float:HighestCombo]
//          |
//          |+0x611 - [Variable Size ASCII(AreaID):FurthestCompletedStoryChapter(alt2) |16-byte]
//          |¨| - The first ASCII letter of this AreaID may be zeroed out (eg. "lvl_mansroof" => " vl_mansroof")
//          |¨| - Documentation on [ASCII:AreaID] at $0x7a0620
//          |/
//          |+0x7AC - [bit0 BitFlag:IsBountyHunterModeUnlocked |32-bit]
//          |¨| - This refers to the Bounty Hunter Mode which unlocks for the PlayerProfile once it has completed the Story Mode at least once
//          |¨| - Manually editing this value in RAM works as a shortcut for unlocking this mode
//          |/
//          |+0x7B8 - [8-bit:UnlockedDifficulties |32-bit]
//          |¨| - This value practically counts how many of the 4 difficulties are selectable when starting a 'New Game' (story campaign)
//          |¨| - These difficulties unlock by completing the story mode on lower difficulties, one by one (Very Hard and Red Wood Revolver are both unlocked by completion of Hard)
//          |¨| - Available difficulties are only unlocked for this PlayerProfile not the others
//          |¨|
//          |¨|# Values
//          |¨||'''''''''
//          |¨|| - 0x0 => Normal (No difficulty select available on 'New Game', defaults to Normal)
//          |¨|| - 0x1 => Normal, Hard
//          |¨|| - 0x2 => Normal, Hard, Very Hard
//          |¨|| - (value >= 0x3) => Normal, Hard, Very Hard, Red Wood Revolver
//          |/
//          |
//          |+0x7B0 - [4-byte Bitset:BountyHunterMissionsCompleted]
//          |¨[Definition Bitset:BountyHunterMissionsCompleted |4-byte]
//          |¨|'''''''''''''''''''''''''''''''''''''
//          |¨| - Each PlayerProfile saves his own [Bitset:BountyHunterMissionsCompleted]
//          |¨| - This bitset only updates on save, after a successful Bounty Hunter Mission
//          |¨| - This bitset consists of 20 flags
//          |¨|
//          |¨|+0x0 - [BitFlags of Bitset(byte1):BountyHunterMissionsCompleted]
//          |¨|¨| bit0 => Chapter 1 'Bull's Eye' Completed
//          |¨|¨| bit1 => Chapter 2 'Bounty Hunter' Completed
//          |¨|¨| bit2 => Chapter 3 'Ugly Streetfight' Completed
//          |¨|¨| bit3 => //
//          |¨|¨| bit4 => Chapter 5 'Railroaded' Completed
//          |¨|¨| bit5 => //
//          |¨|¨| bit6 => Chapter 6 'Carnival Life' Completed
//          |¨|¨| bit7 => Chapter 7 'Freak Show' Completed
//          |¨|/
//          |¨|+0x1 - [BitFlags of Bitset(byte2):BountyHunterMissionsCompleted]
//          |¨|¨| bit0 => //
//          |¨|¨| bit1 => Chapter 8 'Rogue Valley' Completed
//          |¨|¨| bit2 => //
//          |¨|¨| bit3 => Chapter 9 'Ghost Town' Completed
//          |¨|¨| bits[4-5] => //
//          |¨|¨| bit6 => Chapter 11 'Range War' Completed
//          |¨|¨| bit7 => Chapter 12 'Saloon Fight' Completed
//          |¨|/
//          |¨|+0x2 - [BitFlags of Bitset(byte3):BountyHunterMissionsCompleted]
//          |¨|¨| bit0 => Chapter 13 'The Traitor' Completed
//          |¨|¨| bit1 => Chapter 14 'Sunset Canyon' Completed
//          |¨|¨| bit2 => Chapter 15 'Bear Mountain' Completed
//          |¨|¨| bit3 => //
//          |¨|¨| bit4 => Chapter 17 'The Mine' Completed
//          |¨|¨| bit5 => Chapter 18 'Stagecoach' Completed
//          |¨|¨| bit6 => //
//          |¨|¨| bit7 => Chapter 20 'Fort Diego' Completed
//          |¨|/
//          |¨|+0x3 - [BitFlags of Bitset(byte4):BountyHunterMissionsCompleted]
//          |¨|¨| bit0 => Chapter 21 'End of the Line' Completed
//          |¨|¨| bits[1-3] => //
//          |¨|¨| bit4 => Chapter 24 'Battle Finale' Completed
//          |¨|¨| bit5 => Chapter 25 'The Siege' Completed
//          |¨|¨| bit6 => //
//          |¨|¨| bit7 => Chapter 27 'Fall From Grace' Completed
//          |/
//          |
//          |+0x7BC - [7-byte ASCII:PlayerProfileName]
//          |¨| - Max size of name is 7 characters
//          |/
//          |
//          |+0x800 - [2-byte Bitset:ActivatedCheats]
//          |¨[Definition Bitset:ActivatedCheats |2-byte]
//          |¨|'''''''''''''''''''''''''''''''''''''
//          |¨| - Related [Bitset:CheatUnlocks], defined at $0x7405cc
//          |¨|
//          |¨|+0x0 - [BitFlags of Bitset(byte1):ActivatedCheats]
//          |¨|¨| bits[0-5] => //
//          |¨|¨| bit6 => Invincibility
//          |¨|¨| bit7 => Golden Gun
//          |¨|/
//          |¨|+0x1 - [BitFlags of Bitset(byte2):ActivatedCheats]
//          |¨|¨| bit0 => Show Player Position (non-unlockable debug feature)
//          |¨|¨| bit1 => Show AI Info (non-unlockable debug feature)
//          |¨|¨| bit2 => Infinite Deadeye
//          |¨|¨| bit3 => //
//          |¨|¨| bit4 => Bite the Bullet
//          |¨|¨| bit5 => Sad Stars
//          |¨|¨| bit6 => No HUD
//          |¨|¨| bit7 => No Distortion
//          |/
//          '
// $742118: [NTSCU][8-bit:ActivePlayerProfileID |32-bit]
//          @Regional equivalent of $0x744898 (PAL)
// $742158: [NTSCU][32-bit (base) Pointer:ActivePlayerProfile] -> [Struct:PlayerProfileData]
//          @Regional equivalent of $0x7448d8 (PAL)
// $7443B0: [NTSCJ][32-bit (base) Pointer:UndefinedStruct_01] -> [Struct:Undefined_01]
//          @Regional Equivalent of $0x7448a0 (PAL)
// $7443E8: [NTSCJ][32-bit (base) Pointer:ActivePlayerProfile] -> [Struct:PlayerProfileData]
//          @Regional Equivalent of $0x7448d8 (PAL)
// $744898: [PAL][8-bit:ActivePlayerProfileID |32-bit]
//          - Value range [0x0-0x5] => [PlayerProfileSlot1-PlayerProfileSlot6]
//          - Each PlayerProfile saves its own data in [Array:PlayerProfileData] ($0x740608)
// $7448A0: [PAL][32-bit (base) Pointer:UndefinedStruct_01] -> [Struct:Undefined_01]
//          [Definition Struct:Undefined_01 |??-byte]
//          |'''''''''''''''''''''''''''''''''''
//          | - This struct points to other documented structures
//          |
//          |+0x8 - [28-byte Struct:ShowdownModeSettings]
//          |¨| - Definition of [Struct:ShowdownModeSettings] at $0x7405b0
//          |/
//          |+0x24 - [28-byte Bitset:SharedUnlocks]
//          |¨| - Definition of [Bitset:SharedUnlocks] at $0x7405cd
//          |/
//          |+0x60 - [17040-byte Array:PlayerProfileData] List of (6x) [Struct:PlayerProfileData]
//          |¨| - Definition of [Array:PlayerProfileData] at $0x740608
//          |/
//          '
// $7448A8: [PAL][32-bit:ShowdownBountyHunterModeBountyTargetLimit]
//          - Related [Struct:ShowdownModeSettings].[Lower4:BountyHunterModeBountyLimitSetting], which sets the limit before match starts. ($0x7405b0)
//          - This value refers to the exact required cash a player needs to collect to win the game
// $7448D8: [PAL][32-bit (base) Pointer:ActivePlayerProfile] -> [Struct:PlayerProfileData]
//          - This pointer points to the currently active/selected PlayerProfile
//          - All PlayerProfiles are stored at [Array:PlayerProfileData] at $0x740608
//          - Definition of [Struct:PlayerProfileData] at $0x740608
// $744C78: [PAL][24-byte Bitset:Player_Profile_Unlocks(tempCopy)]
//          - In some instances during gameplay, mostly during loading screens. the bitset which is stored at [Pointer:ActivePlayerProfile].[Struct:PlayerProfileData].[Bitset:Player_Profile_Unlocks] is temporarily copied to this location, whilst [Pointer:ActivePlayerProfile] temporarily points to miscellaneous data.
// $745170: [NTSCU][32-bitFlag:IsAnimationLoading]
//          @Regional equivalent of $0x7478f0 (PAL)
//          - 32-bit = 0x9000 => Animation Loading Is Active
// $747408: [PAL][32-bit (base) Pointer:RewardMenuAndStartChpMenuDisplayData(alt2)]
//          -> [Struct:RewardMenuAndStartChpMenuDisplayData]
//          
//          - Prefer using (base) pointer at $0x54caf0
// $7478F0: [PAL][32-bitFlag:IsAnimationLoading]
//          - 32-bit = 0x9000 => Animation Loading Is Active
//          
//          - 'Animation Loading' is the loading screen when loading a story mission, where the protagonist is shown. (eg. when the protagonist is Red: he twirls his pistol with a red background)
//          - Don't use this address as a single BitFlag as that would be unstable
// $747BCD: [NTSCU][6-byte ASCII:VideoFileNameID]
//          @Regional equivalent of $0x74a34d (PAL)
//          - NTSCU doesn't offer PAL mode, only NTSC mode
// $74A34D: [PAL][6-byte ASCII:VideoFileNameID_NTSC]
//          - Preceding [13-byte ASCII] = "cdrom0:\/pss/"
//          - VideoFileNameID is only stored here when in NTSC (60Hz) mode
//          - IDs and further documentation at $0x74a34f
// $74A34F: [PAL][6-byte ASCII:VideoFileNameID_PAL]
//          - Identifies the current/last PRE-RENDERED video played
//          - Preceding [15-byte ASCII] = "cdrom0:\/pss50/" ---> pss files are ps2 video/image files; There's a folder on the ROM "pss50" which stores 50Hz video's for PAL mode and a folder "pss" for NTSC mode
//          - VideoFileNameID is only stored here when in PAL (50Hz) mode
//          
//          # VideoFileNameIDs (list incomplete)
//          |'''''''''''''''''''''''''
//          | rslogo.pss => Rockstar Logo on game boot
//          | titles.pss => Game Title Intro Video (plays after selecting language)
//          | sher7001.pss => Chapter 3 (Ugly Streetfight) - Intro video: Red talks with sheriff about bounty reward + bandit shoots dog
// $74F500: [NTSCU][32-bit:SelectedPosterMenuShowdownStageID]
//          @Regional equivalent of $0x751c80 (PAL)
// $751C80: [PAL][32-bit:SelectedPosterMenuShowdownStageID]
//          - This can be used to identify which Showdown Stage is selected
//          - This value does not directly control which Showdown Stage is loaded
//          - This value may not always update if the player rapidly switches back and forth when selecting a showdown stage at the ShowdownPosterMenu at the MainMenu. (eg. rapidly shifting from stage1 to stage2 to stage1 to stage 2...)
//          - This memory address is the start of a memory region which probably correlates to the image data of the stage
//          
//          # PosterMenuShowdownStageIDs
//          |'''''''''''''''''''''''''''''''''
//          | 0x4E8ED0A3 => Twin Rocks
//          | 0xE92D2DF4 => Desert Fortress
//          | 0x8D4B4164 => Widow's Patch
//          | 0xA479363B => The Bridge
//          | 0xBDF1A8C6 => Fairground
//          | 0x7C52F704 => Sunset Canyon
//          | 0x2014BFB6 => Broken Creek
//          | 0x1BBD6301 => The Ranch
//          | 0xB62B6570 => The Mine
//          | 0x6FA2063E => Ghost Town
//          | 0x2F5BB19C => Fallen Creek
//          | 0xE89F9670 => Mansion Grounds
//          | 0x4858C414 => The Mansion
// $753AB0: [PAL][32-bit (base) Pointer:KeysAcquired]
//          @Fixed Memory Location. Although pointed to by pointer at $0x7A1900
//          |
//          |+0x68 - [20-byte Array:KeysAcquired] List of (5x) [BitFlag:IsKeyAcquired |32-bit]
//          |¨[Definition Array:KeysAcquired |20-byte]
//          |¨|°°°°°°°°°°°°°°°°°°°°°°°°°
//          |¨| - This array contains the functional bit flags for the keys. If these are set to 0, standing near the interactable doors won't show the prompt to open them
//          |¨| - Key icon display is handled in [Array:KeysDisplayed], refer to $0x562A20
//          |¨|
//          |¨|+0x0 - [bit0 BitFlag(IsKeyAcquired):Key1]
//          |¨|+0x4 - [bit0 BitFlag(IsKeyAcquired):Key2]
//          |¨|+0x8 - [bit0 BitFlag(IsKeyAcquired):Key3]
//          |¨|+0xC - [bit0 BitFlag(IsKeyAcquired):Key4]
//          |¨|+0x10 - [bit0 BitFlag(IsKeyAcquired):Key5]
//          |¨|
//          |¨|[Definition BitFlag:IsKeyAcquired |bit0|32-bit]
//          |¨||'''''''''''''''''''''''''
//          |¨|| - bit0 = 1 => key is acquired
//          |¨|| - bit0 = 0 => key not acquired
//          |/
//          '
// $754A90: [PAL][32-bit (base) Pointer:ActorData] -> [Array:ActorData]
//          +0x8 - [32-bit (layer-1) Pointer]
//          ++0x10 - [160-byte Array:ActorData]
//          ++| - Defintion of [Array:ActorData] at $0x7621d0
// $75FA50: [NTSCU][160-byte Array:ActorData]
//          @Regional equivalent of $0x7621d0 (PAL)
// $7608F0: [NTSCU][32-bit Pointer:SinglePlayerData(preferred)] -> [Struct:SinglePlayerData]
//          @Regional equivalent of $0x763070 (PAL)
// $761138: [NTSCU][64-byte Array:ShowdownPlayerData] List of (2-4x) [Struct:ShowdownPlayerData_0]
// $7621D0: [PAL][160-byte Array:ActorData]
//          @Fixed Memory Location, Although pointed to by $0x754a90
//          
//          [Definition Array:ActorData |112-byte]
//          |''''''''''''''''''''''''''''''''
//          | - This array may list a max of (20x) unique instances of [Struct:ActorData_0 |8-byte]
//          | - Definition of [Struct:ActorData_0] below
//          '
//          
//          [Definition Struct:ActorData_0 |8-byte]
//          |=================================
//          |+0x0 - [32-bit (layer-0) Pointer] -> [Struct:ActorData_A]
//          |¨| - [Struct:ActorData_A] contains miscellaneous data which is shared between certain actors
//          |/
//          |
//          |+0x4 - [32-bit (layer-0) Pointer] -> [Struct:ActorData_B]
//          |¨| - This pointer is removed/zeroed out 3-5 seconds after the actor model (corpse) despawns. It is not zeroed out on actor death.
//          |¨| - Definition of [Struct:ActorData_B] below
//          |/
//          '
//          
//          [Definition Struct:ActorData_B |??-byte]
//          |=================================
//          |+0x4 - [32-bit (layer-1) Pointer]
//          |+|+0x4 - [32-bit (layer-2) Pointer]
//          |+|+|+0x0 - [Variable Size ASCII:CharacterName]
//          |+|+|¨| - When this is the player character: the name of the PlayerProfile will be saved here
//          |+|+|¨| - Unique characters will have their names here
//          |+|+|¨| - Other NPCs have miscellaneous names set here (e.g., Mikey, Bobby, Jeremiah...)
//          |+|/
//          |+|+0x18 - [32-bit (layer-2) Pointer]
//          |+|+|+0x10 - [32-bit Float:ActorHP]
//          |+|+|+0x14 - [32-bit Float:ActorMaxHP]
//          |/
//          |
//          |+0xC - [32-bit (layer-1) Pointer]
//          |+|+0x90 - [16-byte Struct(PS2Vector):ActorLocation]
//          |+|¨| - Definition of [Struct:PS2Vector] at $0x763070
//          |+|/
//          |+|+0xC0 - [bit0 BitFlag:IsRidingAnimal |32-bit]
//          |+|¨| - Whilst riding an animal, [Struct(PS2Vector):ActorLocation] is zeroed out
//          |/
//          |
//          |+0x24 - [32-bit (layer-1) Pointer]
//          |++0x4 - [32-bit (layer-2) Pointer]
//          |++|+0x4 - [3-byte ASCII:CharacterModelID]
//          |++|¨| - IDs listed at $0x562a20
//          |/
//          |
//          |+0x80 - [32-bit (layer-1) Pointer] -> [Struct:WeaponManager]
//          |+|¨| - Definition of [Struct:WeaponManager] at $0x7638b8
//          |/
//          '
// $763070: [PAL][32-bit Pointer:SinglePlayerData(preferred)] -> [Struct:SinglePlayerData]
//          - This pointer only points to [Struct:SinglePlayerData] once the first mission is started in Story Mode
//          - This pointer is equal to [Pointer:ShowdownPlayerData_C] ($) for ShowdownPlayer 1 during a Showdown Match;
//          - This pointer is zeroed out when booting up the game; It gets populated by starting either a Story mission or a Showdown Match; It stays populated when quiting back to MainMenu
//          
//          [Definition Struct:SinglePlayerData |3008-byte]
//          |=====================================
//          | - This struct is very similar to [Struct:ShowdownPlayerData_C] ($0x7638b8)
//          |
//          |+0xC - [32-bit (layer-1) Pointer:ActorData_B] -> [Struct:ActorData_B]
//          |+| - Definition of [Struct:ActorData_B] at $0x7621d0
//          |/
//          |
//          |+0x18 - [32-bit (layer-1) Pointer]
//          |++0x10 - [32-bit Float:PlayerHP]
//          |++0x14 - [32-bit Float:PlayerMaxHP]
//          |++|¨| - Base HP: 250.0
//          |++|¨| - Each HP upgrade, increases this value by 50.0
//          |
//          |+0x94 - [32-bit (layer-1) Pointer]
//          |++0x10 - [8-bit:NumberOfGunsInInventory |32-bit]
//          |++|¨| - eg. if this value is 2, the player can switch only between these 2 guns during gameplay. Picking up a new weapon increases this value by 1...
//          |
//          |+0x168 - [32-bit (layer-1) Pointer]
//          |+|+0xF4 - [32-bit (layer-2) Pointer]
//          |+|+|+0x30 - [660-byte Struct:AmmunitionInventory]
//          |+|+|¨| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this struct does not.
//          |+|+|¨| - Functional values for ammunition are also stored in [Array:WeaponData].[Struct:AmmunitionInventory] & [Array:WeaponData] may target the same data for storing ammo.
//          |+|
//          |+|+0xEC - [32-bit (layer-2) Pointer]
//          |+|+|+0x4 - [Variable Size ASCII:GameTriggerID]
//          |+|+|¨| - This can be used to identify certain in-engine cinematics as well as certain triggers/actions
//          |+|+|¨| - WARNING: sometimes the first letter of this ASCII is zeroed out. This probably means this data is not in use anymore
//          |+|+|¨| - GameTriggerIDs listed below
//          |/
//          |
//          |+0x36C - [32-bit (layer-1) Pointer:GameplayStats]
//          |+| - During Story Mode this [Pointer:GameplayStats] --pointsTo--> [Struct:SinglePlayerMissionStats] (Definition of Struct below)
//          |+| - During a Showdown Match this [Pointer:GameplayStats] --pointsTo--> [Struct:ShowdownPlayerStats] (Definition of Struct at $0x7638b8)
//          |+|
//          |+|[Definition Struct:SinglePlayerMissionStats |456-byte]
//          |+||''''''''''''''''''''''''''''''''''''
//          |+|| - This struct is very similar to [Struct:ShowdownPlayerStats] ($0x7638b8)
//          |+|| - This struct stores stats for the current mission/Chapter, it resets when restarting the mission from the start.
//          |+|| - On save/on restart/on RetryMenu render: the stats here will update the stats stored inside the corresponding [Array:PlayerProfileData].[Struct:PlayerProfileData] of the active PlayerProfile ($0x740608)
//          |+||
//          |+||+0x0 - [32-bit:ShotsFired(copy)]
//          |+||¨| - This value copies value [32-bit:ShotsFired(functional)], documented further below
//          |+||
//          |+||+0x2C - [32-bit:ShotsHit(copy)]
//          |+||¨| - This value is not always an exact copy of [32-bit:ShotsHit(functional)], documented further below
//          |+||
//          |+||+0x30 - [32-bit:HeadShots(preferred)]
//          |+||¨| - This value may only count the enemies killed by head shots, NOT enemies hit in the head
//          |+||
//          |+||+0x5C - [32-bit:DeathToll]
//          |+||¨| - This value counts enemies killed
//          |+||¨| - This value does NOT count enemies killed which are riding animals/on horseback, prefer using [Struct:Undefined_03].[32-bit:MissionKillcount] at (0x4fa370) for these instances
//          |+||
//          |+||+0x70 - [32-bit Float:RawTotalDamageTaken]
//          |+||¨| - This value is used to calculate 'Damage Taken' statistic on the post-mission RewardMenu
//          |+||¨| - The formula would be = RawTotalDamageTaken/PlayerMaxHP
//          |+||
//          |+||+0x17C - [32-bit Float:TimeSpentInMission]
//          |+||¨| - Time in seconds
//          |+||¨| - Only counts when in control of character or during small interactive cutscenes (also counts for a few frames in-between loading cutscenes)
//          |+||
//          |+||+0x190 - [32-bit:CashCollected]
//          |+||¨| - This values copies the value stored at [Struct:GameController].[Struct:CashController].[32-bit:Cash(functional)] ($0x562a20)
//          |+||
//          |+||+0x194 - [32-bit:ShotsFired(functional)]
//          |+||¨| - Depending on the type of weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |+||¨| - This value is used to calculate 'Accuracy' statistic on the post-mission RewardMenu
//          |+||
//          |+||+0x198 - [32-bit:ShotsHit(functional)]
//          |+||¨| - This value is used to calculate 'Accuracy' statistic on the post-mission RewardMenu
//          |+||¨| - The formula would be = ShotsHit/ShotsFired
//          |+||
//          |+||+0x19C - [32-bit:ArmShots]
//          |+||
//          |+||+0x1A0 - [32-bit:BodyShots]
//          |+||
//          |+||+0x1A4 - [32-bit:HeadShots(alt)]
//          |+||
//          |+||+0x1A8 - [32-bit:LegShots]
//          |+||
//          |+||+0x1B0 - [32-bit:MoneySpent]
//          |+||
//          |+||+0x1B4 - [32-bit:MeleeHits]
//          |+||
//          |+||+0x1B8 - [32-bit:BackShots]
//          |+||
//          |+||+0x1BC - [32-bit:DeadeyeOrSpecialMoveUseCount]
//          |+||¨| - WARNING: This value may increase inconsistently fast when spamming the deadeye input. In this case: the visual usage of the SpecialMove on screen can't keep up to date with this count. Thus practically this should only be used to check if a SpecialMove is used.
//          |+||
//          |+||+0x1C0 - [32-bit:HighestComboMultiplier]
//          |+||¨| - This value is shown on the the post-mission RewardMenu
//          |+||
//          |+||+0x1C4 - [32-bit Float:HighestCombo]
//          |+||¨| - This value is shown on the the post-mission RewardMenu
//          |/
//          |
//          |+0x5C8 - [32-byte Bitset:PlayerProfileUnlocks]
//          |¨| - Each PlayerProfile has its own bitset storing which items are unlocked
//          |¨| - This bitset determines which items are bought in the shops and which items are unlocked for this PlayerProfile.
//          |¨| - This bitset also handles which weapons are in the weapon inventory, during weapon selection
//          |¨| - This bitset is updated whenever something is picked up, unlocked/bought through shops and on the post-mission RewardMenu. But due to the nature of [Struct:SinglePlayerData] being reconstructed during gameplay (this pointer chain temporarily failing), this Bitset accessed via this [Pointer:SinglePlayerData] should NOT be used for achievements.
//          |¨| - Newly acquired JournalPages, ShowdownCharacters and ShowdownStages are saved to the [Bitset:SharedUnlocks] ($0x7405cc). --- Weapons, Deadeye and Health upgrades are not, these are saved to the corresponding [Array:PlayerProfileData].[Struct:PlayerProfileData].[Bitset:PlayerProfileUnlocks] ($0x740608).
//          |¨| - Definition of [Bitset:PlayerProfileUnlocks] below
//          |/
//          '
//          
//          [Definition Struct:PS2Vector |16-byte]
//          |''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Float:W_Component]
//          |¨| - This is perspective divide component. It has a role in perspective projection, where the final coordinates are obtained by dividing X, Y, Z by W.
//          |/
//          |+0x4 - [32-bit Float:Y_Coordinate]
//          |+0x8 - [32-bit Float:Z_Coordinate]
//          |+0xC - [32-bit Float:X_Coordinate]
//          '
//          
//          [Definition Bitset:PlayerProfileUnlocks |24-byte]
//          | - When upgrading a weapon: both the 'normal/non-upgraded' and the 'upgraded' flags will be 1 (true) until a save occurs. Once the save occurs the bitflag for the 'normal/non-upgraded' weapon will become 0 and the bitflag which corresponds with the upgraded version will be 1;
//          | - Some JournalPages and ShowdownCharacters may be unlocked by 2 seperate bitflags (Presumably: one bitflag could possibly correspond to buying an item to unlock it and one bitflag for unlocking it through mission ratings)
//          |================================
//          |+0x0 - [BitFlags of Bitset(byte1):PlayerProfileUnlocks]
//          |¨| bits[0-2] => //
//          |¨| bit3 => (PAGE+WEAPON) Side Arms - Old Pistol
//          |¨| bit4 => (PAGE+WEAPON) Side Arms - Old Pistol (upgraded)
//          |¨| bit5 => (PAGE+WEAPON) Side Arms - Revolver
//          |¨| bit6 => (PAGE+WEAPON) Side Arms - Revolver (upgraded)
//          |¨| bit7 => (PAGE+WEAPON) Side Arms - Twin Revolvers
//          |/
//          |+0x1 - [BitFlags of Bitset(byte2):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE+WEAPON) Side Arms - Twin Revolvers (upgraded)
//          |¨| bit1 => (PAGE+WEAPON) Side Arms - Widowmaker
//          |¨| bit2 => (PAGE+WEAPON) Side Arms - Widowmaker (upgraded)
//          |¨| bit3 => (PAGE+WEAPON) Side Arms - Scorpion
//          |¨| bit4 => (PAGE+WEAPON) Ranged Weapons - Breech Loader
//          |¨| bit5 => (PAGE+WEAPON) Ranged Weapons - Breech Loader (upgraded)
//          |¨| bit6 => (PAGE+WEAPON) Ranged Weapons - The Lion
//          |¨| bit7 => (PAGE+WEAPON) Ranged Weapons - The Lion (upgraded)
//          |/
//          |+0x2 - [BitFlags of Bitset(byte3):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE+WEAPON) Ranged Weapons - Twelve Gauge
//          |¨| bit1 => (PAGE+WEAPON) Ranged Weapons - Twelve Gauge (upgraded)
//          |¨| bit2 => (PAGE+WEAPON) Ranged Weapons - Owl Rifle
//          |¨| bit3 => (PAGE+WEAPON) Ranged Weapons - Owl Rifle (upgraded)
//          |¨| bit4 => (PAGE+WEAPON) Ranged Weapons - Repeater Rifle
//          |¨| bit5 => (PAGE+WEAPON) Ranged Weapons - Repeater Rifle (upgraded)
//          |¨| bit6 => (PAGE+WEAPON) Ranged Weapons - High Caliber
//          |¨| bit7 => (PAGE+WEAPON) Ranged Weapons - High Caliber (upgraded)
//          |/
//          |+0x3 - [BitFlags of Bitset(byte4):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE+WEAPON) Side Arms - Six Shooter
//          |¨| bit1 => (PAGE+WEAPON) Side Arms - Six Shooter (upgraded)
//          |¨| bit2 => (PAGE+WEAPON) Side Arms - Pacificador
//          |¨| bit3 => (PAGE+WEAPON) Side Arms - Pacificador (upgraded)
//          |¨| bit4 => (PAGE+WEAPON) Side Arms - Inquisitor
//          |¨| bit5 => (PAGE+WEAPON) Ranged Weapons - Halcon Rifle
//          |¨| bit6 => (PAGE+WEAPON) Ranged Weapons - Halcon Rifle (upgraded)
//          |¨| bit7 => (PAGE+WEAPON) Ranged Weapons - Bayonet Rifle
//          |/
//          |+0x4 - [BitFlags of Bitset(byte5):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE+WEAPON) Ranged Weapons - Bayonet Rifle (upgraded)
//          |¨| bit1 => (PAGE+WEAPON) Ranged Weapons - Oppressor
//          |¨| bit2 => (PAGE+WEAPON) Ranged Weapons - Sawn Off
//          |¨| bit3 => (PAGE+WEAPON) Ranged Weapons - Sawn Off (upgraded)
//          |¨| bit4 => (PAGE+WEAPON) Ranged Weapons - Escopeta
//          |¨| bit5 => (PAGE+WEAPON) Ranged Weapons - Escopeta (upgraded)
//          |¨| bit6 => (PAGE+WEAPON) Ranged Weapons - Zwei Fasser
//          |¨| bit7 => (PAGE+WEAPON) Thrown Weapons - Knife
//          |/
//          |+0x5 - [BitFlags of Bitset(byte6):PlayerProfileUnlocks]
//          |¨| bits[0-1] => //
//          |¨| bit2 => (PAGE+WEAPON) Thrown Weapons - Dynamite
//          |¨| bit3 => (PAGE+WEAPON) Thrown Weapons - Fire Bottle
//          |¨| bit4 => (PAGE+WEAPON) Thrown Weapons - Snake Oil
//          |¨| bits[5-7] => //
//          |/
//          |+0x6 - [BitFlags of Bitset(byte7):PlayerProfileUnlocks]
//          |¨| bit7 => HP Upgrade - Buy 'Hot Bath' from girls taking a bath during Chapter 12 'Bar Fight'
//          |/
//          |+0x7 - [BitFlags of Bitset(byte8):PlayerProfileUnlocks]
//          |¨| bit0 => HP Upgrade - Buy 'Snakebit Kit' from Curly Shaw's Shop in Chapter 8 'Rogue Valley'
//          |¨| bit1 => HP Upgrade - Buy 'Lucky Flask' from Jack Swift walking around Brimstone (during 3rd visit)
//          |¨| bit2 => HP Upgrade - Buy 'Kiss' from woman in jail during Chapter 16 'Jailbreak'
//          |¨| bit3 => Dead Eye Upgrade - Buy 'Strong Drink' from Barman at Brimstone Saloon
//          |¨| bit4 => Dead Eye Upgrade - Buy 'Pocket Watch' from boy selling newspapers in Brimstone
//          |¨| bit5 => HP Upgrade - Chapter 7 'Freak Show' (Good rating)
//          |¨| bit6 => HP Upgrade - Chapter 13 'The Traitor' (Excellent rating)
//          |¨| bit7 => HP Upgrade - Chapter 20 'Fort Diego' (Good rating)
//          |/
//          |+0x8 - [BitFlags of Bitset(byte9):PlayerProfileUnlocks]
//          |¨| bit0 => Dead Eye Upgrade - Chapter 6 'Carnival Life' (Good rating)
//          |¨| bit1 => Dead Eye Upgrade - Chapter 14 'Sunset Canyon' (Excellent rating)
//          |¨| bit2 => Dead Eye Upgrade - Chapter 24 'Battle Finale' (Good rating)
//          |¨| bit3 => (PAGE) Good People of Brimstone - Mathias Lampry
//          |¨| bit4 => //
//          |¨| bit5 => (PAGE) Merchants of Brimstone - Carnaby Peabody
//          |¨| bit6 => (PAGE) Merchant of Brimstone - Ralph Clover
//          |¨| bit7 => (PAGE) Citizens of the Wilderness - Fred Kenyon
//          |/
//          |+0x9 - [BitFlags of Bitset(byte10):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Heroes of the Frontier - Buffalo || (CHAR) Buffalo
//          |¨| bit1 => (PAGE) Wanted Dead or Alive - Rico Pedrosa || (CHAR) Rico Pedrosa
//          |¨| bit2 => (PAGE) Citizens of the Wilderness - Black Elk Tribe || (CHAR) Standing Snake
//          |¨| bit3 => (PAGE) Renegade Army - Private Hanson
//          |¨| bit4 => (PAGE) Protectors of Brimstone - Rat Chavez
//          |¨| bit5 => (PAGE) Outlaws in Twelve States - Oscar Navarro || (PAGE) Outlaws in Twelve States - Paul "Swig" Bennet |⚠|--> These are also unlocked by bit1@Byte23
//          |¨| bit6 => (PAGE) Citizens of the Wilderness - Grizzly || (CHAR) Grizzly |⚠|--> These are also unlocked by bit2@Byte23
//          |¨| bit7 => (PAGE) Wanted Dead or Alive - Sam || (CHAR) Sam |⚠|--> These are also unlocked by bit3@Byte23
//          |/
//          |+0xA - [BitFlags of Bitset(byte11):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Outlaws in Twelve States - Jethro Greensleves
//          |¨| bit1 => (PAGE) Wanted Dead or Alive - "Smiley" Fawler || (CHAR) "Smiley" Fawler |⚠|--> These are also unlocked by bit5@Byte23
//          |¨| bit2 => (PAGE) Wanted Dead or Alive - "Bloody" Tom || (CHAR) "Bloody" Tom (Mission Rating Unlock) |⚠|--> Item Buy Unlock by bit6@Byte23
//          |¨| bit3 => (PAGE) Outlaws in Twelve States - Sidney "Sissy" Fess || (CHAR) "Sissy" Fess |⚠|--> These are also unlocked by bit7@Byte23
//          |¨| bit4 => (PAGE) Wanted Dead or Alive - Roberto Pedrosa
//          |¨| bit5 => (PAGE) Citizens of the Wilderness - Hank Pullman
//          |¨| bit6 => (PAGE) Wanted Dead or Alive - Holstein Hal || (CHAR) Holstein Hal
//          |¨| bit7 => (PAGE) Prof. Perry's Peculiarities - Atlas Jones
//          |/
//          |+0xB - [BitFlags of Bitset(byte12):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Citizens of the Wilderness - Blind Willy Wilson
//          |¨| bit1 => (PAGE) Merchant of Brimstone - Woodrow Klein
//          |¨| bit2 => (STAGE) Broken Creek - Boyhood Home
//          |¨| bit3 => (PAGE) Renegade Army - Colonel Daren || (CHAR) Colonel Daren
//          |¨| bit4 => (PAGE) Prof. Perry's Peculiarities - Asada
//          |¨| bit5 => (PAGE) Merchants of Brimstone - Manny Quinn || (CHAR) Manny Quinn |⚠|--> These are also unlocked by bit3@Byte19
//          |¨| bit6 => (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (CHAR) Falling Star
//          |¨| bit7 => (PAGE) Annie's Ranch || (STAGE) The Ranch - Fertile Land
//          |/
//          |+0xC - [BitFlags of Bitset(byte13):PlayerProfileUnlocks]
//          |¨| bit0 => (STAGE) Widows Patch - Terrified Town
//          |¨| bit1 => (PAGE) Heroes of the Frontier - Shadow Wolf || (CHAR) Shadow Wolf
//          |¨| bit2 => (PAGE) Merchants of Brimstone - Doc Weatherby || (PAGE) Merchants of Brimstone - Percy Merriweather
//          |¨| bit3 => (PAGE) Outlaws in Twelve States - Smitty || (CHAR) Smitty
//          |¨| bit4 => (PAGE) Wanted Dead or Alive - Longhorn Luke
//          |¨| bit5 => (PAGE) Citizens of the Wilderness - Running Moon
//          |¨| bit6 => (PAGE) Good People of Brimstone - Cheryl-Lynn
//          |¨| bit7 => (STAGE) The Mansion - Opulent Palace
//          |/
//          |+0xD - [BitFlags of Bitset(byte14):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Wanted Dead or Alive - Jesse Lynch
//          |¨| bit1 => (PAGE) Battle Royale Contestants - Kid Cougar || (CHAR) "Kid" Cougar
//          |¨| bit2 => (PAGE) Renegade Army - General Javier Diego || (CHAR) General Diego
//          |¨| bit3 => (STAGE) Fallen Creek - Snow-topped Mountain
//          |¨| bit4 => (PAGE) Renegade Army - Lieutenant Cleu
//          |¨| bit5 => (PAGE) Wanted Dead or Alive - Harry 'Hatchet' Schultz
//          |¨| bit6 => (PAGE) Outlaws in Twelve States - Father Driscoll
//          |¨| bit7 => (PAGE) Good People of Brimstone - Abigail
//          |/
//          |+0xE - [BitFlags of Bitset(byte15):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Sunset Canyon || (STAGE) Sunset Canyon - Desert Badlands
//          |¨| bit1 => (PAGE) Outlaws in Twelve States - Udo Kang || (CHAR) Udo Kang
//          |¨| bit2 => (PAGE) Frontier Places - Border Bridge || (STAGE) The Bridge - Contested Structure
//          |¨| bit3 => (PAGE) Protectors of Brimstone - Sherrif Bartlett || (CHAR) Sheriff Bartlett
//          |¨| bit4 => (PAGE) Prof. Perry's Peculiarities - Lightning Larouche
//          |¨| bit5 => (PAGE) Outlaws in Twelve States - Cooper || (CHAR) Cooper
//          |¨| bit6 => (PAGE) Outlaws in Twelve States - Gordon "Digs" Fowler || (CHAR) "Dig" Fowler
//          |¨| bit7 => (PAGE) Good People of Brimstone - Tameri
//          |/
//          |+0xF - [BitFlags of Bitset(byte16):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Outlaws in Twelve States - Standing Snake
//          |¨| bit1 => (PAGE) Citizens of the Wilderness - Fred Kenyon
//          |¨| bit2 => (PAGE) Prof. Perry's Peculiarities - The Clowns || (CHAR) Fidgit
//          |¨| bit3 => (PAGE) Prof. Perry's Peculiarities - Professor Perry || (CHAR) Professor Perry
//          |¨| bit4 => (PAGE) Ugly Chris Gang - Ugly Chris || (CHAR) "Ugly" Chris
//          |¨| bit5 => (PAGE) The Jail || (STAGE) The Mine - Lost Inheritance
//          |¨| bit6 => (PAGE) Good People of Brimstone - Natalie || (CHAR) Natalie
//          |¨| bit7 => (PAGE) Battle Royale Contestant - Gabriel Navarro || (CHAR) Gabriel Navarro
//          |/
//          |+0x10 - [BitFlags of Bitset(byte17):PlayerProfileUnlocks]
//          |¨| bit0 => (CHAR) Katie O'Grady || (PAGE) Citizens of the Wilderness - Katie O'Grady
//          |¨| bit1 => (PAGE) Good People of Brimstone - Jody
//          |¨| bit2 => (CHAR) Sheriff O'Grady || (PAGE) Citizens of the Wilderness - Sheriff O'Grady
//          |¨| bit3 => (PAGE) Protectors of Brimstone - The Cornet Brothers
//          |¨| bit4 => (CHAR) Jason Cornet || (PAGE) Protectors of Brimstone - Jason Cornet
//          |¨| bit5 => (PAGE) Renegade Army - Pick Axe Miller
//          |¨| bit6 => (CHAR) "Pig" Josh || (PAGE) Prof. Perry's Peculiarities - Pig Josh
//          |¨| bit7 => (CHAR) Dan || (PAGE) Wanted Dead or Alive - Dan
//          |/
//          |+0x11 - [BitFlags of Bitset(byte18):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Merchant of Brimstone - Hanz Kenyon
//          |¨| bit1 => (PAGE) Good People of Brimstone - Lily Belle
//          |¨| bit2 => (CHAR) Nate Harlow || (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (PAGE) Memories of the Past - Nate Harlow
//          |¨| bit3 => (PAGE) Merchants of Brimstone - Carnaby Peabody
//          |¨| bit4 => (STAGE) Fairground - Ruined Homestead || (PAGE) Fairgrounds
//          |¨| bit5 => (PAGE) Outlaws in Twelve States - Bandito
//          |¨| bit6 => (PAGE) Good People of Brimstone - Verne Wiggins
//          |¨| bit7 => (PAGE) Protectors of Brimstone - Sergeant Marquez
//          |/
//          |+0x12 - [BitFlags of Bitset(byte19):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Memories of the Past - Falling Star || (PAGE) Memories of the Past - Young Red Harlow || (CHAR) Red Jr.
//          |¨| bit1 => (PAGE) Renegade Army - The Duellist
//          |¨| bit2 => (PAGE) Good People of Brimstone - Sandy Dodge
//          |¨| bit3 => (CHAR) Manny Quinn || (PAGE) Merchants of Brimstone - Manny Quinn |⚠|--> These are also unlocked by bit5@Byte12
//          |¨| bit4 => (CHAR) Bad Bessie || (PAGE) Wanted Dead or Alive - Bad Bessie
//          |¨| bit5 => (PAGE) Wanted Dead or Alive - Loaf Whitney
//          |¨| bit6 => (PAGE) Protectors of Brimstone - Mad Dog Jones
//          |¨| bit7 => (PAGE) Good People of Brimstone - Jebidah Cole
//          |/
//          |+0x13 - [BitFlags of Bitset(byte20):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Outlaws in Twelve States - Jacques
//          |¨| bit1 => (PAGE) Renegade Army - Captain Bufias
//          |¨| bit2 => (PAGE) Mansion || (STAGE) Mansion Grounds - Tended Gardens
//          |¨| bit3 => (PAGE) Wanted Dead or Alive - Greg 'Big Oaf' Whitney || (CHAR) "Big Oaf" Whitney
//          |¨| bit4 => (PAGE) Outlaws in Twelve States - Twiggy Phelps || (CHAR) "Twiggy" Phelps
//          |¨| bit5 => (PAGE) Ugly Chris Gang - Gigolo
//          |¨| bit6 => (PAGE) Merchant of Brimstone - Fitch
//          |¨| bit7 => (PAGE) Battle Royale Contestants - Mr. Kelley || (CHAR) Mr. Kelley
//          |/
//          |+0x14 - [BitFlags of Bitset(byte21):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Prof. Perry's Peculiarities - Clyde Slade || (CHAR) "The Blade" Slade
//          |¨| bit1 => (PAGE) Protectors of Brimstone - Governor Griffon || (CHAR) Governor Griffon
//          |¨| bit2 => (STAGE) Ghost Town - Abandoned Settlement
//          |¨| bit3 => // -> flips a unknown bit at [Bitset(byte3):ShowdownMapUnlocks]
//          |¨| bit4 => (PAGE) Wanted Dead or Alive - Mr. Black || (CHAR) Mr. Black
//          |¨| bit5 => (PAGE) Citizens of the Wilderness - Red Wolf Tribe |⚠|--> This page is also unlocked by bit6@Byte24
//          |¨| bit6 => (PAGE) Citizens of the Wilderness || (CHAR) "Curly" Shaw
//          |¨| bit7 => (PAGE) Outlaws in Twelve States - Juan "Loco" Sanchez
//          |/
//          |+0x15 - [BitFlags of Bitset(byte22):PlayerProfileUnlocks]
//          |¨| bit0 => (PAGE) Renegade Army - Pvt. 'Ripper' Hernandez
//          |¨| bit1 => (PAGE) Citizens of the Wilderness - Gabby Brennan
//          |¨| bit2 => // -> flips a unknown bit 1 byte before [Bitset:SharedUnlocks] ($0x7405cb)
//          |¨| bit3 => // -> flips a unknown bit 1 byte before [Bitset:SharedUnlocks] ($0x7405cb)
//          |¨| bit4 => // -> flips a unknown bit 1 byte before [Bitset:SharedUnlocks] ($0x7405cb)
//          |¨| bit5 => // -> flips a unknown bit 1 byte before [Bitset:SharedUnlocks] ($0x7405cb)
//          |¨| bit6 => // -> flips a unknown bit 1 byte before [Bitset:SharedUnlocks] ($0x7405cb)
//          |¨| bit7 => // -> flips an unknown bit at [Bitset(byte1):SharedUnlocks] ($0x7405cc)
//          |/
//          |+0x16 - [BitFlags of Bitset(byte23):PlayerProfileUnlocks]
//          |¨| bit0 => // -> flips an unknown bit at [Bitset(byte1):SharedUnlocks] ($0x7405cc)
//          |¨| bit1 => (PAGE) Outlaws in Twelve States - Oscar Navarro || (PAGE) Outlaws in Twelve States - Paul "Swig" Bennet |⚠|--> These are also unlocked by bit5@Byte10
//          |¨| bit2 => (PAGE) Citizens of the Wilderness - Grizzly || (CHAR) Grizzly |⚠|--> These are also unlocked by bit6@Byte10
//          |¨| bit3 => (PAGE) Wanted Dead or Alive - Sam || (CHAR) Sam |⚠|--> These are also unlocked by bit7@Byte10
//          |¨| bit4 => (PAGE) Outlaws in Twelve States - Jethro Greensleves
//          |¨| bit5 => (PAGE) Wanted Dead or Alive - "Smiley" Fawler || (CHAR) "Smiley" Fawler |⚠|--> These are also unlocked by bit1@Byte11
//          |¨| bit6 => (PAGE) Wanted Dead or Alive - "Bloody" Tom || (CHAR) "Bloody" Tom (Item Buy Unlock) |⚠|--> Mission Rating Unlock by bit2@Byte11
//          |¨| bit7 => (PAGE) Outlaws in Twelve States - Sidney "Sissy" Fess || (CHAR) "Sissy" Fess |⚠|--> These are also unlocked by bit3@Byte11
//          |/
//          |+0x17 - [BitFlags of Bitset(byte24):PlayerProfileUnlocks]
//          |¨| bits[0-5] => //
//          |¨| bit6 => (PAGE) Citizens of the Wilderness - Red Wolf Tribe |⚠|--> this page is also unlocked by bit5@Byte21
//          |¨| bit7 => //
//          |/
//          '
//          
//          # GameTriggerIDs (string)
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
// $7638B8: [PAL][64-byte Array:ShowdownPlayerData] List of (2-4x) [Struct:ShowdownPlayerData_0]
//          - This array is only functional during a showdown match
//          - Minimum required players for a Showdown Match: 2 --- Maximum players: 4
//          - Each player stores its own [Struct:ShowdownPlayerData_0]. Player 1 is always the first [Struct:ShowdownPlayerData_0] in the array
//          
//          [Definition Struct:ShowdownPlayerData_0 |16-byte]
//          |'''''''''''''''''''''''''''''
//          |+0x0 - [32-bit (layer-0) Pointer] -> [Struct:ShowdownPlayerData_A |2512-byte]
//          |
//          |+0x4 - [32-bit (layer-0) Pointer] -> [Struct:ShowdownPlayerData_B |1312-byte]
//          |+[Definition Struct:ShowdownPlayerData_B |1312-byte]
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+|+0x18 - [32-bit (layer-1) Pointer]
//          |+|++0x80 - [32-bit (layer-2) Pointer] -> [Struct:WeaponManager]
//          |+|++| - Definition of [Struct:WeaponManager] below
//          |+|/
//          |+|+0x28C - (unverified) [32-byte Bitset] Might be correlated to weapon pickups or power ups?
//          |+|
//          |+|+0x30 - [32-bit (layer-2) Pointer] -> [Struct:ShowdownPlayerStats]
//          |+|+| - Contains stats used for the post-match scoreboard menu
//          |+|+| - Definition of [Struct:ShowdownPlayerStats] below
//          |+|/
//          |+|+0x2B4 - [32-bit (layer-2) Pointer]
//          |+|++0xC - [32-bit:CashCollected]
//          |/
//          |
//          |+0x8 - [32-bit (layer-0) Pointer:ShowdownPlayerData_C] -> [Struct:ShowdownPlayerData_C |3008-byte]
//          |+[Definition Struct:ShowdownPlayerData_C |3008-byte]
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+| - This struct is very similar to [Struct:SinglePlayerData] ($0x763070)
//          |+|
//          |+|+0xC - [32-bit (layer-1) Pointer:ActorData_B] -> [Struct:ActorData_B]
//          |+|++0xC - [32-bit (layer-2) Pointer]
//          |+|++|+0x90 - [16-byte Struct(PS2Vector):ShowdownPlayerLocation]
//          |+|++|¨| - Defintion of [Struct:PS2Vector] at $0x763070
//          |+|/
//          |+|
//          |+|+0x18 - [32-bit (layer-1) Pointer]
//          |+|++0x10 - [32-bit Float:PlayerHP]
//          |+|++0x14 - [32-bit Float:PlayerMaxHP]
//          |+|
//          |+|+0x94 - [32-bit (layer-1) Pointer]
//          |+|++0x10 - [8-bit:NumberOfGunsInInventory |32-bit]
//          |+|
//          |+|+0x168 - [32-bit (layer-1) Pointer]
//          |+|++0xF4 - [32-bit (layer-2) Pointer]
//          |+|+|+0x30 - [660-byte Struct:AmmunitionInventory]
//          |+|+|¨| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this struct does not.
//          |+|+|¨| - Functional values for ammunition are also stored in [Array:WeaponData], these 2 structs may target the same data.
//          |+|/
//          |+|+0x5C8 - (unverified) [32-byte Bitset:AcquiredWeapons]
//          |+|¨| - This bitset does not have any neccesary function inside Showdown Mode, it's probably something that is inherited from the singlePlayer
//          |+|¨| - This bitset is somewhat similar to [Bitset:PlayerProfileUnlocks]
//          |+|¨| - This bitset handles which weapons are available to pick before mission start
//          |+|¨| - This bitset is updated whenever something is unlocked/bought in-game, in shops and on the Reward Menu
//          |/
//          |
//          |+0xC - [32-bit (layer-0) Pointer] -> [Struct:ShowdownPlayerData_D |??-byte]
//          |+| - This pointer is only functional for Player 1; This pointer is zeroed out for other Players (this may only be the case for CPU players, since player 1 is always a 'human' player)
//          |/
//          '
//          
//          [Definition Struct:WeaponManager |176-byte]
//          |'''''''''''''''''''''''''''''''''''''
//          |+0x44 - [8-bit:DefaultWeaponID |32-bit]
//          |¨| - This value decides which weapon is equipped by default on (re)spawn
//          |¨| - Differing characters spawn with different weapons
//          |¨| - WeaponIDs listed below
//          |/
//          |+0x48 - [8-bit:EquippedWeaponID |32-bit]
//          |¨| - WeaponIDs are equal to the index of the weapon inside the [Array:WeaponData]
//          |/
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |++0x0 - [32-bit (layer-2) Pointer]
//          |+++0x4 - [32-bit (layer-3) Pointer]
//          |++++0x0 - [440-byte Array:WeaponData] List of (55x) [32-bit (layer-4) Pointer] -> [Struct:WeaponData]
//          |++++| - Each weapon has a [Struct:WeaponData] inside this array
//          |++++| - Definition of [Struct:WeaponData] below
//          |/
//          |
//          |+0xA8 - [8-bit Bitfield:UniversalWeaponState |32-bit]
//          |¨| - This state is valid to use for all weapons, this in comparison to [Struct:WeaponData].[Bitfield:WeaponState]
//          |¨| - UniversalWeaponStates listed below
//          |/
//          '
//          
//          [Definition Struct:ShowdownPlayerStats |1224-byte]
//          |''''''''''''''''''''''''''''''''''''''
//          | - This struct stores various stats which are displayed on the post-match scoreboard menu.
//          | - Data stored in this struct is updated during runtime/gameplay
//          | - This struct is very similar to [Struct:SinglePlayerMissionStats] ($0x763070)
//          | - Most 32-bit values stored are signed integers, but the scoreboard only displays a limited amount of characters (refer to $0x6b18b4)
//          |
//          |+0x0 - [32-bit:ShotsFired(copy)]
//          |¨| - This value copies value [32-bit:ShotsFired(functional)], documented further below
//          |
//          |+0x2C - [32-bit:ShotsHit(copy)]
//          |¨| - This value is not always an exact copy of [32-bit:ShotsHit(functional)], documented further below
//          |
//          |+0x5C - [32-bit:DeathToll]
//          |¨| - This value counts enemies killed
//          |
//          |+0x70 - [32-bit Float:RawTotalDamageTaken]
//          |
//          |+0x418 - [32-bit:DeathCount]
//          |¨| - This value counts the player's deaths, NOT enemy deaths/kills
//          |
//          |+0x430 - [32-bit:HighNoonRoundsWon]
//          |
//          |+0x490 - [32-bit:CashCollected]
//          |¨| - For player 1: this values copies the value stored at [Struct:GameController].[Struct:CashController].[32-bit:Cash(functional)] ($0x562a20)
//          |
//          |+0x494 - [32-bit:ShotsFired(functional)]
//          |¨| - Depending on the type of weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |¨| - This value is used to calculate 'Accuracy' statistic on the post-match RewardMenu
//          |
//          |+0x498 - [32-bit:ShotsHit(functional)]
//          |¨| - This value is used to calculate 'Accuracy' statistic on the post-match RewardMenu
//          |¨| - The formula would be = ShotsHit/ShotsFired
//          |
//          |+0x49C - [32-bit:ArmShots]
//          |
//          |+0x4A0 - [32-bit:BodyShots]
//          |
//          |+0x4A4 - [32-bit:HeadShots]
//          |
//          |+0x4A8 - [32-bit:LegShots]
//          |
//          |+0x4B4 - [32-bit:MeleeHits]
//          |
//          |+0x4B8 - [32-bit:BackShots]
//          |
//          |+0x4C0 - [32-bit:HighestComboMultiplier]
//          |
//          |+0x4C4 - [32-bit Float:HighestCombo]
//          '
//          
//          [Definition Struct:WeaponData |8-byte]
//          |'''''''''''''''''''''''''''''''''''''
//          | - There's about 55 weapons in the list
//          | - Changing ammunition stats here work, although UI needs to be handled through $0x562a20
//          |
//          |+0x4 - [32-bit Pointer{1}]
//          |+|+0x18 - [8-bit Bitfield:WeaponState]
//          |+|¨| 0x1 => Idle
//          |+|¨| 0x3 => Firing
//          |+|¨| 0x4 => Reloading
//          |+|/
//          |+|+0x20 - [8-bit:MaximumAmmunitionCapacity(functional) |32-bit]
//          |+|¨| - This value determines how many bullets can be loaded inside a Weapon
//          |+|
//          |+|+0x24 - [8-bit:CurrentLoadedAmmunition(functional) |32-bit]
//          |+|¨| - This value determines how many bullets are loaded inside the equipped Weapon
//          |+|¨| - This is a functional value, the visual display may not work/update correctly when RAM tampering this address.
//          |+|
//          |+|+0x28 - [32-bit Pointer{2}] -> [Struct:WeaponAmmunition]
//          |+|+[Definition Struct:WeaponAmmunition |12-byte??]
//          |+|+|'''''''''''''''''''''''''''''''''''''
//          |+|+| - Some ammunition might be shared between weapons
//          |+|+| - The ammunition values stored in this struct do NOT count the ammo loaded inside the gun, ammunition count on HUD does (refer to $0x562a20)
//          |+|+|
//          |+|+|+0x4 - [8-bit:ReserveAmmunitonOnSpawn |32-bit]
//          |+|+|¨| - This value determines how many bullets the player spawns with for this Weapon
//          |+|+|
//          |+|+|+0x8 - [8-bit:CurrentReserveAmmuniton |32-bit]
//          |+|+|¨| - This value determines how many bullets the player has left for this Weapon
//          |+|+|¨| - This value is updated whenever bullets are used or bullets are picked up (by picking up the same Weapon)
//          |+|/
//          |+|
//          |+|+0x1D0 - [bit0 BitFlag:IsWeaponInInventory |32-bit]
//          |/
//          '
//          
//          # WeaponIDs (list incomplete)
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
//          # UniversalWeaponStates (list complete)
//          |'''''''''''''''''''''''
//          | 0x0 => Holstered
//          | 0x1 => Drawing Weapon (first half of drawing animation)
//          | 0x2 => Drawing Weapon (last half of drawing animation)
//          | 0x3 => Aiming
//          | 0x4 => Reloading (not used when "reloading" throwable items, also not used when using the Deadeye Ability for skipping the reload animation)
//          | 0x5 => Holstering (during most frames of holstering animation)
//          | 0x6 => Holstering (last few frames of holstering animation)
//          '
// $7638F8: [PAL][8-bit:ShowdownPlayerCount |32-bit]
//          - Value range [0x2-0x4]
// $79DEA0: [NTSCU][Variable Size ASCII:AreaID(functional) | 16-byte]
//          @Regional equivalent of $0x7a0620 (PAL)
// $79E008: [NTSCU][32-bit Pointer:GameplayTimers] -> [Struct:GameplayTimers]
//          @Regional equivalent of $0x7a0788 (PAL)
// $79E21C: [NTSCU][bit0 BitFlag:IsPlayingBountyHunterMode |32-bit]
//          @Regional equivalent of $0x7a099c (PAL)
// $7A0280: [NTSCU][32-bit Pointer:PuppetshowManager] -> [Struct:PuppetshowManager]
//          @Regional equivalent of $0x7a2a00 (PAL)
// $7A0620: [PAL][Variable Size ASCII:AreaID(functional) | 16-byte]
//          - The AreaID that needs to be loaded is stored here
//          - Changing this value to a valid ID and freezing this address before entering a loading screen, will load the corresponding mission/area
//          
//          # AreaIDs (list only contains IDs used in achievement creation)
//          |''''''''''''''''''''''''''
//          | default => Intermittent loading screen (= screen before the MAIN Loading screen, where the protagonist twirls his pistols around) -> some sort of value between switching AreaIDs
//          |
//          |--- Story Campaign ---
//          | lvl_perfnew => Chapter 1 - Bull's Eye - Intro with Red Jr.
//          | lvl_hng => Chapter 2 - Bounty Hunter - Bounty for Bloody Tom
//          | lvl_sher70 => Chapter 3 - Ugly Streetfight - Bounty for Ugly Chris
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
//          - Floats: 1.0 (=0x3f800000) => flag/checkpoint is activated || 0.0 (0x0) => flag/checkpoint is inactive || certain inactive flags may be stored as -1.0
//          - Turning these flags on/off during mission can trigger enemy spawns, checkpoint, cutscenes... (some event flags may bug out the mission when manually turning them on)
//          
//          [Struct Definition][??-byte] Main_Mission_Data.BountyHunter (Chapter 2)
//          |''''''''''''''''''''''''''''''''''''''''''''''''''''''''
//          |+0xFC - [Float Flag] Is Boss Trio Spawn Cutscene Finished
//          |¨| - Float = 1.0 => Boss Trio spawn cutscene is finished
//          |¨| - Float = 0.0 => not finished
//          |/
//          '
// $7A0788: [PAL][32-bit Pointer:GameplayTimers] -> [Struct:GameplayTimers]
//          [Definition Struct:GameplayTimers |??-byte]
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x1C - [32-bit Float:TimeSpentInGame(copy)] || [32-bit Float:CountdownTimer(functional)]
//          |¨| - Both timers count in seconds
//          |¨| - This float is [Float:TimeSpentInGame(copy)] when this float doesn't count down; It copies [Float:TimeSpentInGame(functional)]
//          |¨| - This float is [Float:CountdownTimer(functional)] when this float counts down; It is used for certain Story or Bounty Hunter missions as well as the countdown timer for Sundown mode in Showdown/Multiplayer. Functional value means it effectively controls the game (eg. this hits 0.0 => Sundown mode ends)
//          |/
//          |
//          |+0x20 - [32-bit Float:TimeSpentInGame(functional)]
//          |¨| - Time in seconds
//          |¨| - This is the value which is shown on the post-mission RewardMenu (in Story Mode). It is also used to update [Struct:PlayerProfileData].[Float:TimeSpentPlaying] of the corresponding PlayerProfile in [Array:PlayerProfileData]
//          |/
//          '
// $7A099C: [PAL][bit0 BitFlag:IsPlayingBountyHunterMode |32-bit]
//          - This value needs to be combined with [Bitfield:GameMode] ($0x4fbaf0) to determine if player is effectively playing the Singleplayer Bounty Hunter Mode
//          - Values becomes 1, when pressing 'accept' on 'Bounty Hunter' at the MainMenu
//          - Values returns only back to 0, when pressing 'accept' after pressing 'New Game' or after 'Continue' at the MainMenu
// $7A09C0: [PAL][32-bit Pointer:SinglePlayerData(alt)] -> [Struct:SinglePlayerData]
//          - Identical pointer at $0x763070
// $7A1870: [PAL][32-bit (base) Pointer:RewardMenuAndStartChpMenuDisplayData(alt1)]
//          -> [Struct:RewardMenuAndStartChpMenuDisplayData]
//          
//          - Prefer using (base) pointer at $0x54caf0
// $7A18D0: [PAL][32-bit (base) Pointer:MultiplayerRewardMenuData(alt2)] -> [Struct:MultiplayerRewardMenuData]
//          - Prefer using [Pointer:MultiplayerRewardMenuData(preferred)] at $0x54cac8
// $7A1900: [PAL][32-bit (base) Pointer]
//          |+0x60 - [32-bit (layer-1) Pointer:KeysAcquired]
//          |¨| - Documentation of [Pointer:KeysAcquired] at $0x753AB0
// $7A1920: [PAL][32-bit Pointer] --(+0x0)--> [Variable Size Struct] Main_Mission_Data (alt)
// $7A1948: [PAL][32-bit (base) Pointer:UndefinedStruct_03(alt)] -> [Struct:Undefined_03]
//          - Documentation at $0x4fa370
// $7A2A00: [PAL][32-bit Pointer:PuppetshowManager] -> [Struct:PuppetshowManager]
//          - This pointer is zeroed out when there is no Puppetshow active
//          - A 'Puppetshow' is an in-engine cutscene; It is not a pre-rendered video (refer to [ASCII:VideoFileNameID_PAL] at $0x74a34f)
//          
//          [Definition Struct:PuppetshowManager |160-byte]
//          |'''''''''''''''''''''''''''''''''''''''
//          | - This struct controls different aspects of a Puppetshow
//          |
//          |+0x4 - [32-bit:LastCameraActionID]
//          |¨| - A 'CameraAction' refers to a change in the camera's behavior, such as switching angles, transitioning from a static hold to a movement or rotation, or the reverse. Each CameraAction can be identified with an ID.
//          |¨| - This value refers to the previous CameraAction occurs.
//          |
//          |+0x10 - [32-bit:CurrentCameraActionID]
//          |¨| - This value refers to the current CameraAction.
//          |/
//          |+0x14 - [32-bit:AnimationKeyframe]
//          |¨| - An 'AnimationKeyframe' represents a specific point in time within an animation sequence where particular properties (eg. position, rotation, scale) of an object are defined. These keyframes act as markers, and the animation engine interpolates the transitions between them to create smooth motion or transformations over time.
//          |¨| - This value gets glitchy when changing/freezing it
//          |/
//          |+0x18 - [32-bit:CameraActionCount]
//          |¨| - This value increments by 1 each CameraAction (eg. Starts to count at 0, [32-bit:CurrentCameraActionID] changes from 0x14 to 0x24 and then to 0x37. ---> [32-bit:CameraActionCount] = 2)
//          |/
//          |+0x68 - [Variable Size ASCII:PuppetshowID]
//          |¨| - This value is used to identify a Puppetshow
//          |¨| - IDs listed below
//          |/
//          '
//          
//          # PuppetshowIDs (string)
//          |(list only contains IDs used in achievements)
//          |''''''''''''''
//          | - lvl_waterfall_pupshow_02 => Chapter 14 'Bear Mountain', intro cutscene for boss Grizzly. Starts when entering the boss arena.
//          '
// $D17E8D: [8-bit] Main Menu Check
//          0x07e - Main Menu (Verified Always)
// $E36118: could be important
// $18C97D4: [8-bit] Chapter 2 - Shots left
// $19B7FD4: [8-bit] Chapter 1 - Shots left
// $1A88434: [8-bit] Chapter 3 - Shots left
// $1F7EC20: [PAL][18-byte ASCIIFlag:IsEndingCreditsPlaying]
//           - ASCII = "ENDCREDITS_PS2.stm" => Ending Credits Video Is Playing (this is the audio file name, which is played during the Ending Credits Video)
//           
//           - MISC: This region is used as runtime stack space by PS2
