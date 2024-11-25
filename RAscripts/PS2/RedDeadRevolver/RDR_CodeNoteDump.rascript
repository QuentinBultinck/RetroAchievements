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
//          |¨| - Refer to 'death toll' ($0x763070) as another killcount
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
//          |+0x0 - [12-byte ASCIIFlag:IsWinner] Player 1
//          |+0x10 - [12-byte ASCIIFlag:IsWinner] Player 2
//          |+0x20 - [12-byte ASCIIFlag:IsWinner] Player 3
//          |+0x30 - [12-byte ASCIIFlag:IsWinner] Player 4
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
//          |¨| - 0x1 => 2nd Item
//          |¨| - 0x2 => 3rd item
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
//          - This pointer seems to point to a node, which is part of a possible LinkedList. The list consists multiplete insstances of [Struct:InteractableZone]; Each AREA/level/mission has its own list; Each 'InteractableZone' seems to contain an interactable item (eg. gatling gun OR shootable lever)
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
//          |+0x2C9 - [1344-byte Array] List of (4x) [Struct:ShowdownPlayer_Settings_B]
//          |+| - This array is only functional during a Showdown match
//          |¨| - Definition of [Struct:ShowdownPlayer_Settings_B] at $0x73d819
//          |/
//          |
//          |+0x808 - [Variable Size ASCII:AreaID(alt)]
//          |¨| - Prefer using [ASCII:AreaID(functional)] at $0x6b0808
//          |/
//          |
//          |+0x8FC - [32-bit (layer-1) Pointer]
//          |+| - This pointer is only functional during a Showdown match
//          |+|
//          |+|+0x50 - [584-byte Array] List of (4x) [Struct:ShowdownPlayer_Settings_A]
//          |+|¨| - Definition of [Struct:ShowdownPlayer_Settings_A] at $0x740438
//          |+|
//          |+|+0x1C8 - [28-byte Struct:ShowdownMode_Settings]
//          |+|¨| - Definition of [Struct:ShowdownMode_Settings] at $0x7405b0
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
//          |+|¨|| - If not all characters are unlocked in [Array:ShowdownCharacterData], then the index only starts counting from the ones which are unlocked (eg. Character 'Pig Josh' is index 0 in [Array:ShowdownCharacterData], but if he's not unlocked, the next character in [Array:ShowdownCharacterData] which is unlocked becomes index 0. Index 1 will then be the next character in [Array:ShowdownCharacterData] which is unlocked and so on...). If no characters are unlocked in [Bitset:ShowdownCharacter_Unlocks] the game will crash at the MainMenu
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
//          |++|[NTSCJ][Defintion Struct:ShowdownModeSettings |??-byte]
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
//          |¨| - This value is calculated from data stored at [Struct:ShowdownPlayer_Data], using formula: (dmgTaken/MaxHP)*100; where default MaxHP = 150.0
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
// $73AF04: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [??-byte Struct] InGame_Menu_Controller
//          @Regional equivalent of $0x73d684 (PAL)
// $73AF0C: [NTSCU][bit0 BitFlag:IsInPauseMenu |32-bit]
//          @Regional equivalent of $0x73d68c
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
//          | pause (InGame_Menu_ID) => PauseMenu
//          | - 0x4 (Highlighted_MenuItem_ID) => Return to Game
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
// $73DE88: [NTSCU][17040-byte Array:PlayerProfileData] List of (6x) [Struct:Player_Profile_Data]
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
// $740118: [NTSCJ][17040-byte Array:PlayerProfileData] List of (6x) [Struct:Player_Profile_Data]
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
//          @Fixed Memory Location. Although pointed to by $0x562a20 and [Pointer:UndefinedStruct_01] ($0x7448a0)
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
//          @Fixed Memory Location. Although pointed to by [Pointer:UndefinedStruct_01] ($0x7448a0)
//          - This bitset is updated on save according to the bitset Player_Profile_Unlocks ($0x763070)
//          - This bitset handles unlocks for cheats, showdown characters, showdown maps and journal pages
//          
//          [PAL][2-byte Bitset] Cheat_Unlocks (7 unlockable flags + 3 non-unlockable flags)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cd
//          
//          [PAL][Bit Flags] @Byte1 in Bitset Cheat_Unlocks 0x7405cc
//          bit 0 => Cheat (non-unlockable debug feature) - Big Money (gain $10 000)
//          bit 1 => Cheat - Golden Gun (significantly increases damage vs AI)
//          bit 2 => Cheat - Infinite Deadeye
//          bit 3 => Cheat - Invincibility
//          bit 4 => Cheat (non-unlockable debug feature) - Show AI Info (doesn't work out-of-the-box)
//          bit 5 => Cheat (non-unlockable debug feature) - Show Player Position (doesn't work out-of-the-box)
//          bit 6 => Cheat - Bite the Bullet (hardcore mode, significantly increases damage vs player and AI)
//          bit 7 => Cheat - Sad Stars (replaces blood splatters with a special effect)
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
// $740608: [PAL][17040-byte Array:PlayerProfileData] List of (6x) [Struct:Player_Profile_Data]
//          @Fixed Memory Location. Although pointed to by [Pointer:UndefinedStruct_01] ($0x7448a0)
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
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:HealthBarHUDController] ($0x562a20) and the HP at [Struct:SinglePlayer_Data] ($0x763070)
//          |/
//          |+0x4 - [32-bit Float] Special Meter Max Gauge
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:SpecialMeterGuageController] ($0x562a20)
//          |/
//          |+0x8 - [32-bit] Saved Cash
//          |¨| - This is the value which is read to initialize [Struct:GameController].[Struct:CashController] ($0x562a20)
//          |¨| - This value only updated on save
//          |/
//          |+0xC - [24-byte Bitset] Player_Profile_Unlocks
//          |¨| - This is a copy of the bitset stored via $0x763070, the bitset here is updated on save, based on that bitset
//          |¨| - Bitset Definition at $0x763070
//          |/
//          |+0x23C - [Variable Size ASCII(AreaID):FurthestCompletedStoryChapter(alt1) | 16-byte]
//          |¨| - The first ASCII letter of this AreaID may be zeroed out (eg. "lvl_mansroof" => " vl_mansroof")
//          |¨| - Documentation on [ASCII:AreaID] at $0x7a0620
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
//          |+0x611 - [Variable Size ASCII(AreaID):FurthestCompletedStoryChapter(alt2) | 16-byte]
//          |¨| - The first ASCII letter of this AreaID may be zeroed out (eg. "lvl_mansroof" => " vl_mansroof")
//          |¨| - Documentation on [ASCII:AreaID] at $0x7a0620
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
//          |+0x7BC - [7-byte ASCII] Player Profile Name
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
// $742118: [NTSCU][8-bit {32-bit}] Selected Player_Profile ID
//          @Regional equivalent of $0x744898 (PAL)
// $742158: [NTSCU][32-bit Pointer] --(+0x0)--> [2840-byte Struct] Selected Player_Profile_Data
//          @Regional equivalent of $0x7448d8 (PAL)
// $7443B0: [NTSCJ][32-bit (base) Pointer:UndefinedStruct_01] -> [Struct:Undefined_01]
//          @Regional Equivalent of $0x7448a0 (PAL)
// $7443E8: [NTSCJ][32-bit Pointer] --(+0x0)--> [2840-byte Struct] Selected Player_Profile_Data
//          @Regional Equivalent of $0x7448d8 (PAL)
// $744898: [PAL][8-bit {32-bit}] Selected Player_Profile ID
//          - Value range [0x0-0x5], there's a total of 6 player profile slots
//          - Each Player_Profile saves its own data (refer to $0x7448d8)
// $7448A0: [PAL][32-bit (base) Pointer:UndefinedStruct_01] -> [Struct:Undefined_01]
//          [Definition Struct:Undefined_01 |??-byte]
//          |'''''''''''''''''''''''''''''''''''
//          | - This struct points to other documented structures
//          |
//          |+0x8 - [28-byte Struct:ShowdownMode_Settings]
//          |¨| - Definition of [Struct:ShowdownMode_Settings] at $0x7405b0
//          |/
//          |+0x24 - [28-byte Bitset:Shared_Unlocks]
//          |¨| - Definition of [Bitset:Shared_Unlocks] at $0x7405cd
//          |/
//          |+0x60 - [PAL][17040-byte Array:PlayerProfileData] List of (6x) [Struct:Player_Profile_Data]
//          |¨| - Definition of [Array:PlayerProfileData] at $0x740608
//          |/
//          '
// $7448A8: [PAL][32-bit] Showdown - Bounty Hunter Mode - Bounty Target Limit
//          - The required Bounty/Cash a player needs to collect to win the game
// $7448D8: [PAL][32-bit Pointer] --(+0x0)--> [2840-byte Struct] Selected Player_Profile_Data
//          - This pointer points to the currently selected Player_Profile_Data
//          - Each Player_Profile has his own data storage
//          - Player_Profile_Data is updated on save/on end of missions
//          - Struct Definition Player_Profile_Data at $0x740608
// $744C78: [PAL][24-byte Bitset] Temporary Selected Player_Profile_Unlocks
// $745170: [NTSCU][32-bit Flag] 0x9000 => Animation Loading Is Active
//          @Regional equivalent of $0x7478f0
// $747408: [PAL][32-bit (base) Pointer:RewardMenuAndStartChpMenuDisplayData(alt2)]
//          -> [Struct:RewardMenuAndStartChpMenuDisplayData]
//          
//          - Prefer using (base) pointer at $0x54caf0
// $7478F0: [PAL][32-bit Flag] 0x9000 => Animation Loading Is Active
//          - Animation Loading = loading screen when loading a story mission, where the protagonist is shown
//          - Don't use this as a single Bit Flag as that would be unstable
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
// $74F500: [NTSCU][32-bit] PosterMenu Selected Showdown Stage ID
//          @Regional equivalent of $0x751c80 (PAL)
// $751C80: [PAL][32-bit] PosterMenu Selected Showdown Stage ID
//          - This can be used to ID the selected Showdown Stage
//          - This memory address is the start of a memory region which probably correlates to the image data of the stage
//          
//          # PosterMenu_Selected_Showdown_Stage_IDs
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
// $75FA50: [NTSCU][160-byte Array] List of [(20x) 8-byte Struct:Actor_Data]
//          @Regional equivalent of $0x7621d0 (PAL)
// $7608F0: [NTSCU][32-bit Pointer{1}] --(+0x0)--> [3008-byte Struct] SinglePlayer_Data
//          @Regional equivalent of $0x763070 (PAL)
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
//          |¨| - This pointer is removed/zero'd out when the actor model has been despawned for a 3-5 seconds, not on actor death
//          |¨| - Definition of [Struct:ActorData_B] below
//          |/
//          '
//          
//          [Definition Struct:ActorData_B |??-byte]
//          |=================================
//          |+0x4 - [32-bit (layer-1) Pointer]
//          |+|+0x4 - [32-bit (layer-2) Pointer]
//          |+|+|+0x0 - [Variable Size ASCII:CharacterName]
//          |+|+|¨| - When this is the player character: the name of the Player_Profile will be saved here
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
//          |+0x80 - [32-bit (layer-1) Pointer] -> [Struct:Weapon_Manager]
//          |+|¨| - Definition of [Struct:Weapon_Manager] below at $0x7638b8
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
//          |+|+|+0x30 - [660-byte Struct:AmmunitionInventory]
//          |+|+|¨| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this struct does not.
//          |+|+|¨| - Functional values for ammunition are also stored in [Array:WeaponData], these 2 structs may target the same data.
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
//          |+0x0 - [32-bit Pointer{1}] --(+0x0)--&gt; [2512-byte Struct] ShowdownPlayer_Data_A
//          |
//          |+0x4 - [32-bit Pointer{1}] --(+0x0)--&gt; [1312-byte Struct] ShowdownPlayer_Data_B
//          |+[Struct Definition][1312-byte] ShowdownPlayer_Data_B
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+|+0x18 - [32-bit Pointer{2}]
//          |+|++0x80 - [32-bit Pointer{3}] --(+0x0)--&gt; [176-byte Struct] Weapon_Manager
//          |+|++| - Struct Definition below
//          |+|/
//          |+|+0x28C - [32-byte Bitset] Might be correlated to weapon pickups or power ups?
//          |+|
//          |+|+0x30 - [32-bit Pointer{2}] --(+0x0)--&gt; [1224-byte Struct] ShowdownPlayer_Stats
//          |+|+| - Contains stats used for the scoreboard as well as some other misc unused stats
//          |+|+| - Struct Definition below
//          |+|/
//          |+|+0x2B4 - [32-bit Pointer{2}]
//          |+|++0xC - [32-bit] Bounty/Cash Collected
//          |/
//          |
//          |+0x8 - [32-bit Pointer{1}] --(+0x0)--&gt; [3008-byte Struct] ShowdownPlayer_Data_C
//          |+[Struct Definition][464-byte] ShowdownPlayer_Data_C
//          |+|'''''''''''''''''''''''''''''''''''''
//          |+| - This struct is very similar to SinglePlayer_Data ($0x763070)
//          |+|
//          |+|+0xC - [32-bit Pointer{1}]
//          |+|++0xC - [32-bit Pointer{2}]
//          |+|++|+0x90 - [16-byte PS2Vector] ShowdownPlayer_Location
//          |+|++|¨| - PS2Vector Definition at $0x763070
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
//          |+|++0xF4 - [32-bit Pointer{3}]
//          |+|+|+0x30 - [660-byte Struct:AmmunitionInventory]
//          |+|+|¨| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, the data in this struct does not.
//          |+|+|¨| - Functional values for ammunition are also stored in [Array:WeaponData], these 2 structs may target the same data.
//          |+|/
//          |+|+0x5C8 - [32-byte Bitset] Acquired_Weapons
//          |+|¨| - This bitset does not have any neccesary function inside Showdown Mode, it's probably something that is inherited from the singlePlayer
//          |+|¨| - This bitset handles which weapons are available to pick before mission start
//          |+|¨| - This bitset is updated whenever something is unlocked/bought in-game, in shops and on the Reward Menu
//          |/
//          |
//          |+0xC - [32-bit Pointer{1}] --&gt; ShowdownPlayer_Data_D
//          |+| - This pointer is only functional for Player 1; This pointer is zeroed out for other Players (may be zeroed out for CPU players)
//          
//          [Struct Definition][176-byte] Weapon_Manager
//          |'''''''''''''''''''''''''''''''''''''
//          |+0x44 - [8-bit {32-bit}] Default Weapon_ID
//          |¨| - This value decides which weapon is equipped by default on (re)spawn
//          |¨| - Weapon_IDs listed below
//          |/
//          |+0x48 - [8-bit {32-bit}] Equipped Weapon_ID
//          |¨| - Weapon_IDs are equal to the index of the weapon inside the [Array:WeaponData]
//          |/
//          |
//          |+0x20 - [32-bit Pointer{1}]
//          |++0x0 - [32-bit Pointer{2}]
//          |+++0x4 - [32-bit Pointer{3}]
//          |++++0x0 - [440-byte Array:WeaponData] List of (55x) [32-bit Pointer{4}] -&gt; [Struct:WeaponData]
//          |++++| - Definition of [Struct:WeaponData] below
//          |/
//          |
//          |+0xA8 - [8-bit Bitfield {32-bit}] Universal_Weapon_State
//          |¨| - This state is valid to use for all weapons, this in comparison to [Struct:WeaponData].[Bitfield:WeaponState]
//          |¨| - Universal_Weapon_States listed below
//          |/
//          '
//          
//          [Struct Definition][1224-byte] ShowdownPlayer_Stats
//          |''''''''''''''''''''''''''''''''''''''
//          | - Data stored here is dynamically updated during gameplay
//          | - Most 32-bit values stored are signed integers, but the scoreboard only displays a limited amount of characters (refer to $0x6b18b4)
//          |
//          |+0x0 - [32-bit] Shots Fired (copy)
//          |¨| - Depending on weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |/
//          |+0x2C - [32-bit] Shots Hit (copy)
//          |
//          |+0x5C - [32-bit] Death Toll (Kill count)
//          |
//          |+0x70 - [32-bit Float] Raw Total Damage Taken
//          |
//          |+0x418 - [32-bit] Death Count (own deaths)
//          |
//          |+0x430 - [32-bit] High Noon Rounds Won
//          |
//          |+0x490 - [32-bit] Bounty/Cash Collected
//          |¨| - This value may only be updated on certain occassions, it doesn't update during gameplay
//          |¨| - Copies value stored via pointer at $0x562a20
//          |/
//          |+0x494 - [32-bit] Shots Fired (functional)
//          |
//          |+0x498 - [32-bit] Shots Hit (functional)
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
//          [Definition Struct:WeaponData |8-byte]
//          |'''''''''''''''''''''''''''''''''''''
//          | - Each weapon has a [Struct:WeaponData] inside the [Array:WeaponData]
//          | - There's about 55 weapons in the list
//          | - Changing ammunition stats here work, although UI needs to be handled through $0x562a20
//          |
//          |+0x4 - [32-bit Pointer{1}]
//          |+|+0x18 - [8-bit Bitfield:WeaponState]
//          |+|¨| 0x1 =&gt; Idle
//          |+|¨| 0x3 =&gt; Firing
//          |+|¨| 0x4 =&gt; Reloading
//          |+|/
//          |+|+0x20 - [8-bit {32-bit}] Maximum Ammunition Capacity (functional)
//          |+|+0x24 - [8-bit {32-bit}] Current Loaded Ammunition (functional)
//          |+|
//          |+|+0x28 - [32-bit Pointer{2}] --(+0x0)--&gt; [12-byte?? Struct] Weapon_Ammunition
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
//          |+|+0x1D0 - [Bit Flag {32-bit}] bit 0 =&gt; Is Weapon In Inventory
//          |/
//          '
//          
//          # Weapon_IDs (list incomplete)
//          |''''''''''''''''
//          | 0x3 =&gt; Old Pistol
//          | 0x9 =&gt; Widowmaker (Pistol)
//          | 0xb =&gt; Scorpion (Pistol)
//          | 0x12 =&gt; Owl Rifle
//          | 0x14 =&gt; Repeating Rifle
//          | 0x18 =&gt; Six Shooter (Pistol)
//          | 0x1d =&gt; Halcon Rifle
//          | 0x1f =&gt; Bayonet Rifle
//          | 0x22 =&gt; Sawn Off Shotgun
//          | 0x24 =&gt; Escopeta (Shotgun)
//          | 0x27 =&gt; Knife (Throwable)
//          | 0x29 =&gt; Hunting Knife (Throwable)
//          | 0x2a =&gt; Dynamite (Throwable)
//          | 0x2b =&gt; Fire Bottle (Throwable)
//          | 0x2d =&gt; Showstoppers (Dual Pistols)
//          | 0x2f =&gt; Faith (Rifle)
//          | 0x30 =&gt; Martillo Del Dios (Rifle)
//          | 0x31 =&gt; Sacred Bow
//          '
//          
//          # Universal_Weapon_States (list complete)
//          |'''''''''''''''''''''''
//          | 0x0 =&gt; Holstered
//          | 0x1 =&gt; Drawing Weapon (first half of animation)
//          | 0x2 =&gt; Drawing Weapon (last half of animation)
//          | 0x3 =&gt; Aiming
//          | 0x4 =&gt; Reloading (not used when "reloading" throwable items, also not used when reloading with DeadEye Ability)
//          | 0x5 =&gt; Holstering (during most frames of animation)
//          | 0x6 =&gt; Holstering (last few frames of animation)
//          '
// $7638F8: [PAL][8-bit {32-bit}] Showdown Mode Playercount
//          - Value range [0x2-0x4], minimum 2 players, max 4 players
// $79DEA0: [NTSCU][Variable Size ASCII:AreaID(functional) | 16-byte]
//          @Regional equivalent of $0x7a0620 (PAL)
// $79E008: [NTSCU][32-bit Pointer] --(+0x0)--> [??-byte Struct] Mission_Timers
//          @Regional equivalent of $0x7a0788 (PAL)
// $79E21C: [NTSCU][Bit Flag {32-bit}] bit 0 => Is Playing Bounty Hunter Mode
//          @Regional equivalent of $0x7a099c (PAL)
// $7A0280: [NTSCU][32-bit Pointer] --(+0x0)--> [160-byte Struct] Puppetshow_Manager
//          @Regional equivalent of $0x7a2a00 (PAL)
// $7A0620: [PAL][Variable Size ASCII:AreaID(functional) | 16-byte]
//          - The AreaID that needs to be loaded is stored here
//          - Changing this value to a valid ID and freezing before entering a loading screen, will load the corresponding mission/area
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
// $7A0788: [PAL][32-bit Pointer] --(+0x0)--> [??-byte Struct] Mission_Timers
//          [Struct Definition][??-byte] Mission_Timers
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x1C - [32-bit Float] Time Spent in Mission/Level (copy) || Countdown timer (functional) (in seconds)
//          |¨| - When there's no countdown active, this value is a copy of Time Spent in Mission/Level. Else this is the functional countdown timer
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
//          - Values returns only back to 0, when pressing 'accept' on 'New Game' or on 'Continue'
// $7A09C0: [PAL][32-bit Pointer] --(+0x0)--> [3008-byte Struct] SinglePlayer_Data (alt)
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
// $7A2A00: [PAL][32-bit Pointer] --(+0x0)--> [160-byte Struct] Puppetshow_Manager
//          - Pointer is zeroed out when there no Puppetshow active
//          
//          [Struct Definition][160-byte] Puppetshow_Manager
//          |'''''''''''''''''''''''''''''''''''''''
//          | - This struct controls different aspects of a Puppetshow, which is a type of cutscene that is not a pre-rendered video file (refer to $0x74a34f), but an in-engine cutscene
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
// $18C97D4: [8-bit] Chapter 2 - Shots left
// $19B7FD4: [8-bit] Chapter 1 - Shots left
// $1A88434: [8-bit] Chapter 3 - Shots left
// $1F7EC20: [PAL][18-byte ASCII] Ending Credits Flag
//           - ASCII = "ENDCREDITS_PS2.stm" => Ending Credits Video Is Playing
//           (this is the audio file name, which is played during the Ending Credits Video)
