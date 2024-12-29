// Darkwatch
// #ID = 19111

// $134214: [PAL][32-bit (base) Pointer:SofdecStreamData(alt)] -> [Struct:SofdecStreamData]
//          - Prefer using [Pointer:SofdecStreamData(preferred)] at $0x134408
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr may be used by other game logic.
//          - Definition of [Struct:SofdecStreamData] at $0x134408
//          
//          ------Simplified_Documentation------
//          [32-bit (base) Pointer:SofdecStreamData(alt)]
//          +0x12C - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          +0x14C - [5-byte ASCII:Sofdec_FMVID]
// $134218: [PAL][32-bit (base) Pointer:FMVdata] -> [Struct:FMVdata]
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr may be used by other game logic.
//          - Definition of [Struct:FMVdata] at $0x6aae58
// $134408: [PAL][32-bit (base) Pointer:SofdecStreamData(preferred)] --(+0x8)--> [Struct:SofdecStreamData]
//          - "Sofdec" is a video codec which handles Full Motion Video (FMV) playback
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr is usually zeroed out (0x0).
//          
//          
//          ------Simplified_Documentation------
//          [32-bit (base) Pointer:SofdecStreamData(preferred)]
//          +0x134 - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          +0x154 - [5-byte ASCII:Sofdec_FMVID]
//          
//          
//          ------Advanced_Documentation------
//          [Definition Struct:SofdecStreamData |1000-byte??]
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x12C - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          || - "SofdecStream" => FMV is being played
//          || - anyOtherValue => FMV is NOT being played
//          |
//          |+0x14C - [5-byte ASCII:Sofdec_FMVID]
//          || - This is actually the SofdecStreamID (about 17-byte long), but the first 5-byte of this ID can be used to identify which FMV is being played
//          || - Sofdec_FMVIDs listed below
//          '
//          
//          # Sofdec_FMVIDs (string)
//          |(list incomplete)
//          |'''''''''''''''''''
//          |---Chapter 1, "The Wrong Train"---
//          | - "M01S1" => Jericho enters train
//          | - "M01S2" => Jericho blows up door vault
//          | - "M01S3" => ???
//          | - "M01S4" => Jericho blows up Lazarus + Escape on horse
//          |---Chapter 2, "Ride Like The Devil"---
//          | - "M02S1" => Lazarus escape from train wreck + Pursues Jericho
//          | - ...
//          '
// $65F3B8: [PAL][32-bit:DisplayLanguageID]
//          - This option may be initialized by PS2 BIOS language setting
//          - Otherwise this setting is not attached/saved the settings of a PlayerProfile
//          - Changing display language inside the OptionsMenu of the TitleScreen will change this value
//          0x46 => fr
//          0x47 => de
//          0x49 => it
//          0x51 => en
//          0x53 => es
// $69B4F0: [32-bit] current weapon equipped
// $6AAE58: [PAL][96-byte Struct:FMVdata]
//          @Fixed Memory Location, although pointed to by $0x134218
//          - This 96-byte region is populated only when an FMV is being played; Otherwise this memRegion is usually zeroed out (0x0)
//          
//          [Definition Struct:FMVdata |96-byte]
//          |''''''''''''''''''''''''''''''''''
//          |+0x58 - [32-bit:MoviePlaybackIndicator]
//          || - Documentation at $0x6aaeb0
//          '
// $6AAEB0: [PAL][32-bit:MoviePlaybackIndicator]
//          @Member of [Struct:FMVdata] ($0x6aae58)
//          - This value is only functional when a Movie is being played; Otherwise this value is 0
//          - This value increments each 2-12 frames
// $6BDCBC: [PAL][32-bit:FrameCounter_2]
//          - Increments by 2 each frame, never stops, never resets, only on game reset via PS2
// $6BDD00: [PAL][32-bit:FrameCounter_1]
//          - Increments by 1 each frame
//          - There are other FrameCounters near this memory region
// $71FF88: [8-bit] in gameplay flag
// $7215CC: [PAL][10-byte ASCII:GameID]
//          "SLES_535.64" => PAL/EU PS2 Game ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - Succeeding [2-byte ASCII] = ";1"
// $721778: (unverified)
//          [PAL][32-bit (base) Pointer:VampireVision]
//          +0xA8 - [8-bit:VampireVisionState]
//          | - value > 0 => Vampire Vision is active
//          | - value == 0 => Vampire Vision is NOT active
// $721788: [PAL][32-bit (base) Pointer:EntityData]
//          
//          ------Simplified_Documentation------
//          (Example pointer chain to HP of PlayerEntityActor. Where the PlayerEntityActor [Array:EntityData].index is 38 and HealthComponent [Dictionary:EntityComponents].index is 15)
//          
//          +0xC - [32-bit (layer-1) Pointer] -> [Array:EntityData]
//          .+(index*0x4) - [32-bit (layer-2) Pointer:EntityData_A]
//          ..+0x0 - [32-bit (layer-3) Pointer:EntityData_B] -> [Struct:EntityData]
//          ...
//          ...+0x44 - [32-bit (layer-4) Pointer]
//          ....+0x2 - [Variable Size ASCII:EntityNameID_1]
//          ...
//          ...+0x48 - [32-bit (layer-4) Pointer]
//          ....+0x2 - [Variable Size ASCII:EntityNameID_2]
//          ...
//          ...+0x58 - [32-bit (layer-4) Pointer:EntityComponents] -> [Dictionary:EntityComponents]
//          ....+0x4(+index*0x8) - [32-bit (layer-5) Pointer:EntityComponentData] -> [Struct:EntityComponentData.HealthComponent]
//          .....
//          .....+0x8 - [32-bit (layer-6) Pointer]
//          ......+0x2 - [Variable Size ASCII:EntityComponentName] = "HealthComponent"
//          .....
//          .....+0x98 - [Float:ActorHP(functional) |32-bit]
//          
//          
//          ------Advanced_Documentation------
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x0 - [Variable Size Array:EntityData] List of [Pointer:EntityData_A] -> [Pointer:EntityData_B] -> [Struct:EntityData]
//          .| - Definition of [Struct:EntityData] below
//          .| - Each area within a map, stores various entities
//          .| - "Entity" can be an actor, light, weaponPickup, collisionSection, bossWeaponAttack, spawnPoint...
//          .| - A lot of data related to those entities can be accessed via this [Pointer:EntityData] (location, functionalHealth...)
//          .| - This may be the only way to access the functional health of the boss, but because the EntityData for the boss may be in different indices of this array, this is inadvisable to use for achievement logic.
//          
//          
//          [Definition Struct:EntityData |96-byte??]
//          |''''''''''''''''''''''''''''''
//          |+0x44 - [32-bit (layer-2) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityNameID_1]
//          |.| - This ID may vary between Chapters, when identifying the same entity (eg. Ally Cassidy in Chapter 1 vs Chapter 2)
//          |.| - Eg. for Playercharacter this is "Chaz" (probably short name for protagonist "Jericho Cross"), duing Chapter 1
//          |.| - Eg. for Cassidy this is "AgentCassidy", duing Chapter 1
//          |
//          |+0x48 - [32-bit (layer-2) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityNameID_2]
//          |.| - This ID may vary between Chapters, when identifying the same entity (eg. Ally Cassidy in Chapter 1 vs Chapter 2)
//          |.| - Eg. for Playercharacter this is "__PlayerActor0", duing Chapter 1
//          |.| - Eg. for Cassidy this is "DWAgentCassidy", duing Chapter 1
//          |
//          |+0x58 - [32-bit (layer-2) Pointer:EntityComponents]
//          |.+0x0 - [Variable Size Dictionary:EntityComponents] List of [Struct:ListItem_EntityComponent]
//          |.| - Definition of [Struct:ListItem_EntityComponent] below
//          |.| - A key-value paired list of EntityComponents (= components with game logic linked to the Entity)
//          |.| - Size and EntityComponents in the list is dependent on the Entity
//          '
//          
//          [Definition Struct:ListItem_EntityComponent |8-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit:DictionaryKey]
//          |+0x4 - [32-bit:DinctionaryValue] || [32-bit Pointer:EntityComponentData] -> [Struct:EntityComponentData]
//          || - Definition of [Struct:EntityComponentData] below
//          '
//          
//          [Definition Struct:EntityComponentData |Variable Size]
//          |''''''''''''''''''''''''''''''
//          | - Size and contents of this struct is dependent on which EntityComponent it is (refer to [ASCII:EntityComponentName])
//          |
//          |+0x44 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName]
//          |.| - eg. WeaponComponent, HealthComponent, MaterialComponent, NetworkedActorComponent...
//          '
//          
//          [Definition Struct:EntityComponentData.HealthComponent(actor) |??-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "HealthComponent"
//          |
//          |+0x98 - [Float:ActorHP(functional) |32-bit]
//          '
// $721820: [PAL][32-bit (base) Pointer:LevelID]
//          +0x1C - [Variable Size ASCII:LevelID_long]
//          | - This ASCII pretty much lists the folder structure to the level (eg. "Levels/SinglePlayer/WrongTrain" or "Levels/SinglePlayer/M02_CanyonShoot")
// $721900: [PAL][32-bit (base) Pointer:PlayerInput(preferred)]
//          - This pointer may point to a memRegion which is mostly static
//          
//          ------Simplified_Documentation------
//          [32-bit (base) Pointer:PlayerInput]
//          +0x4 - [52-byte Struct(ControllerInput):Controller-1] ---------------
//          +0x4 - [bit0 Bitflag:IsControllerConnected_Controller-1 |16-bit]
//          
//          +0x6 - [bit0 Bitflag:IsInputPressed_Select_Controller-1 |8-bit]
//          +0x7 - [bit0 Bitflag:IsInputPressed_Start_Controller-1 |8-bit]
//          
//          +0x8 - [bit0 Bitflag:IsInputPressed_Dpad_Left_Controller-1 |8-bit]
//          +0x9 - [bit0 Bitflag:IsInputPressed_Dpad_Right_Controller-1 |8-bit]
//          +0xA - [bit0 Bitflag:IsInputPressed_Dpad_Up_Controller-1 |8-bit]
//          +0xB - [bit0 Bitflag:IsInputPressed_Dpad_Down_Controller-1 |8-bit]
//          
//          +0xC - [bit0 Bitflag:IsInputPressed_Square_Controller-1 |8-bit]
//          +0xD - [bit0 Bitflag:IsInputPressed_Circle_Controller-1 |8-bit]
//          +0xE - [bit0 Bitflag:IsInputPressed_Triangle_Controller-1 |8-bit]
//          +0xF - [bit0 Bitflag:IsInputPressed_Cross_Controller-1 |8-bit]
//          
//          +0x10 - [bit0 Bitflag:IsInputPressed_L3_Controller-1 |8-bit]
//          +0x11 - [bit0 Bitflag:IsInputPressed_R3_Controller-1 |8-bit]
//          +0x12 - [bit0 Bitflag:IsInputPressed_L1_Controller-1 |8-bit]
//          +0x13 - [bit0 Bitflag:IsInputPressed_R1_Controller-1 |8-bit]
//          
//          +0x14 - [bit0 Bitflag:IsInputPressed_L2_Controller-1 |8-bit]
//          +0x15 - [bit0 Bitflag:IsInputPressed_R2_Controller-1 |8-bit]
//          
//          +0x28 - [Float:LeftAnalogStick_Yaw_Controller-1  |32-bit]
//          +0x2C - [Float:LeftAnalogStick_Pitch_Controller-1  |32-bit]
//          
//          +0x30 - [Float:RightAnalogStick_Yaw_Controller-1  |32-bit]
//          +0x34 - [Float:RightAnalogStick_Pitch_Controller-1  |32-bit]
//          
//          
//          
//          +0x38 - [52-byte Struct(ControllerInput):Controller-2] ---------------
//          +0x38 - [bit0 Bitflag:IsControllerConnected_Controller-2 |16-bit]
//          
//          +0x3A - [bit0 Bitflag:IsInputPressed_Select_Controller-2 |8-bit]
//          +0x3B - [bit0 Bitflag:IsInputPressed_Start_Controller-2 |8-bit]
//          
//          +0x3C - [bit0 Bitflag:IsInputPressed_Dpad_Left_Controller-2 |8-bit]
//          +0x3D - [bit0 Bitflag:IsInputPressed_Dpad_Right_Controller-2 |8-bit]
//          +0x3E - [bit0 Bitflag:IsInputPressed_Dpad_Up_Controller-2 |8-bit]
//          +0x3F - [bit0 Bitflag:IsInputPressed_Dpad_Down_Controller-2 |8-bit]
//          
//          +0x40 - [bit0 Bitflag:IsInputPressed_Square_Controller-2 |8-bit]
//          +0x41 - [bit0 Bitflag:IsInputPressed_Circle_Controller-2 |8-bit]
//          +0x42 - [bit0 Bitflag:IsInputPressed_Triangle_Controller-2 |8-bit]
//          +0x43 - [bit0 Bitflag:IsInputPressed_Cross_Controller-2 |8-bit]
//          
//          +0x44 - [bit0 Bitflag:IsInputPressed_L3_Controller-2 |8-bit]
//          +0x45 - [bit0 Bitflag:IsInputPressed_R3_Controller-2 |8-bit]
//          +0x46 - [bit0 Bitflag:IsInputPressed_L1_Controller-2 |8-bit]
//          +0x47 - [bit0 Bitflag:IsInputPressed_R1_Controller-2 |8-bit]
//          
//          +0x48 - [bit0 Bitflag:IsInputPressed_L2_Controller-2 |8-bit]
//          +0x49 - [bit0 Bitflag:IsInputPressed_R2_Controller-2 |8-bit]
//          
//          +0x5C - [Float:LeftAnalogStick_Yaw_Controller-2  |32-bit]
//          +0x60 - [Float:LeftAnalogStick_Pitch_Controller-2  |32-bit]
//          
//          +0x64 - [Float:RightAnalogStick_Yaw_Controller-2  |32-bit]
//          +0x68 - [Float:RightAnalogStick_Pitch_Controller-2  |32-bit]
//          
//          
//          
//          ------Advanced_Documentation------
//          [32-bit (base) Pointer:PlayerInput]
//          +0x4 - [52-byte Struct(ControllerInput):Controller-1]
//          +0x38 - [52-byte Struct(ControllerInput):Controller-2]
//          | - When connecting a 2nd controller to the PS2, the game will restructure this memRegion, so there's space for another [Struct:ControllerInput] for controller 2
//          
//          [Definition Struct:ControllerInput |52-byte]
//          |''''''''''''''''''''''''
//          |+0x0 - [bit0 Bitflag:IsControllerConnected |16-bit]
//          |
//          |+0x2 -[bit0 Bitflag:IsInputPressed_Select |8-bit]
//          |+0x3 -[bit0 Bitflag:IsInputPressed_Start |8-bit]
//          |
//          |+0x4 - [bit0 Bitflag:IsInputPressed_Dpad_Left |8-bit]
//          |+0x5 - [bit0 Bitflag:IsInputPressed_Dpad_Right |8-bit]
//          |+0x6 - [bit0 Bitflag:IsInputPressed_Dpad_Up |8-bit]
//          |+0x7 - [bit0 Bitflag:IsInputPressed_Dpad_Down |8-bit]
//          |
//          |+0x8 - [bit0 Bitflag:IsInputPressed_Square |8-bit]
//          |+0x9 - [bit0 Bitflag:IsInputPressed_Circle |8-bit]
//          |+0xA - [bit0 Bitflag:IsInputPressed_Triangle |8-bit]
//          |+0xB - [bit0 Bitflag:IsInputPressed_Cross |8-bit]
//          |
//          |+0xC - [bit0 Bitflag:IsInputPressed_L3 |8-bit]
//          |+0xD - [bit0 Bitflag:IsInputPressed_R3 |8-bit]
//          |+0xE - [bit0 Bitflag:IsInputPressed_L1 |8-bit]
//          |+0xF - [bit0 Bitflag:IsInputPressed_R1 |8-bit]
//          |
//          |+0x10 - [bit0 Bitflag:IsInputPressed_L2 |8-bit]
//          |+0x11 - [bit0 Bitflag:IsInputPressed_R2 |8-bit]
//          |
//          |+0x24 - [Float:LeftAnalogStick_Yaw |32-bit]
//          || - "Yaw" = Left and right
//          || MaxFloatRange: [-1.0 --- 1.0]
//          || FloatValue: negative => Left
//          || FloatValue: positive => Right
//          |+0x28 - [Float:LeftAnalogStick_Pitch |32-bit]
//          || - "Pitch" = Forward and backward
//          || MaxFloatRange: [-1.0 --- 1.0]
//          || FloatValue: negative => Backward
//          || FloatValue: positive => Forward
//          |
//          |+0x2C - [Float:RightAnalogStick_Yaw |32-bit]
//          |+0x30 - [Float:RightAnalogStick_Pitch |32-bit]
//          '
// $7238B8: [PAL][32-bit (base) Pointer:HUDcontrol_Gear(preferred)]
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x0 - [32-bit (layer-2) Pointer] -> HUDcontrol_Gear-Player1
//          .| - This pointer valid in both SinglePlayer and Multiplayer Mode
//          ..+0x70 - [32-bit (layer-3) Pointer]
//          ...+0xEC - [32-bit:EquippedWeapon_ReserveAmmo(display)]
//          ...| - This value displays the reserve ammunition
//          ...| - Functional values via [Pointer(EntityData_B):PlayerActorData] at $0x965cc4
//          ...
//          ...+0xF0 - [32-bit:EquippedWeapon_LoadedBullets(display)]
//          ...| - This value regulates the amount of bullets icons displayed
//          ...
//          ...+0xF4 - [32-bit:EquippedWeapon_MagazineSize(display)]
//          ...| - This value actually regulates the display of the bullet icons
//          ...| - Practically this value can be used to determine the max allowed bullets, which can be loaded inside the gun
//          ...
//          ...+0xF8 - [32-bit:DynamiteCountInInventory(display)]
//          ...| - This value displays how many dynamite bundles the player has in the inventory
//          .
//          .
//          .+0xC - [32-bit (layer-2) Pointer] -> HUDcontrol_Gear-Player2
//          .| - This pointer valid iMultiplayer Mode
//          ..+0x70 - [32-bit (layer-3) Pointer]
//          ...+0xEC - [32-bit:EquippedWeapon_ReserveAmmo(display)]
//          ...| - This value displays the reserve ammunition
//          ...| - Functional values via [Pointer(EntityData_B):PlayerActorData] at $0x965cc4
//          ...
//          ...+0xF0 - [32-bit:EquippedWeapon_LoadedBullets(display)]
//          ...| - This value regulates the amount of bullets icons displayed
//          ...
//          ...+0xF4 - [32-bit:EquippedWeapon_MagazineSize(display)]
//          ...| - This value actually regulates the display of the bullet icons
//          ...| - Practically this value can be used to determine the max allowed bullets, which can be loaded inside the gun
//          ...
//          ...+0xF8 - [32-bit:DynamiteCountInInventory(display)]
//          ...| - This value displays how many dynamite bundles the player has in the inventory
// $727318: [8-bit] gunslinger map id
// $728FA0: [PAL][10-byte ASCII:SelectedPlayerProfileName]
//          - Max size is 10 characters
//          - ASCII value is set when creating a new PlayerProfile or when selecting an existing one
//          - Each PlayerProfileName is required to be unique, can't have 2 PlayerProfiles with the same name
// $72BBD8: Player in Movie Cutscene [8-Bit]
//          0x01= Yes
// $73B3F0: [PAL][32-bit:TurboMode(hack)]
//          - Freezing this value, makes the game run in turbo
// $73B430: [PAL][8-bit:GameState |32-bit]
//          - 0x0 => Player is in control of PlayerCharacter. Also 0x0 when in MainMenu
//          - 0x1 => MainLoadingMenu is active, stays 0x1 for the duration of the first in-engine cutscene after exiting the MainLoadingMenu, becomes 0x0 once the player can control the PlayerCharacter.
//          - 0x3 => Any InGameMenu is active. (eg. PauseMenu and submenus, menus for saving to the memory card, LoreMenus not necessarily opened via the PauseMenu) (Manually editing this value to 0x3 freezes the game until changed)
// $73DCD0: [PAL][bit0 BitFlag:IsCinematicActiveStateTransitioning |32-bit]
//          - 1 => whenever a cinematic is ending or starting (transition period)
//          - 0 => when any cinematic is fully active and and not active
// $73DCD8: [PAL][bit0 BitFlag;IsFMVactive |32-bit]
//          - Full Motion Video is a pre-rendered cutscene
// $73DCE8: [PAL][bit0 BitFlag:IsCinematicActive |32-bit]
//          - The game sometimes referes to "Minimatic" as an in-engine cutscene
//          - Data near this memRegion, may be used by logic for Minimatics and FMVs
// $73DD40: (unverified)
//          [PAL][32-bit:CinematicID(unverified)]
//          - To ID an in-engine cinematic, but this is not always consistent.
// $74D78C: [PAL][32-bit (base) Pointer:PlayerData]
//          - Points to data at a fixed memory location
//          
//          +0x54 - [300-byte Struct(PlayerData):Player-1]
//          +0x180 - [300-byte Struct(PlayerData):Player-2]
//          | - PlayerData for Player2 is only populated when in Multiplayer
//          | - Some of the data stored inside Player 2's data is copied from Player 1's data (eg. Audio settings, PlayerProfileName...)
//          | - When playing Multiplayer/Co-op Story mode, all progress is saved as a seperate "PlayerProfile" save. Thus there can be up to 10 PlayerProfiles saves (for SinglePlayer) + 1 COOP profile saves
//          
//          [Defintion Struct:PlayerData |300-byte]
//          |''''''''''''''''''
//          | - Documentation on StructMembers refer to their respective code notes, since this struct is static
//          |
//          |+0x0 - [32-bit:EquippedWeapon_WeaponID]
//          |+0x4 - [32-bit:TimeSpentInChapter]
//          |+0x18 - [32-bit:KillsInChapter]
//          |+0x1C - [32-bit:ShotsFiredInChapter]
//          |+0x20 - [32-bit:ShotsHitInChapter]
//          |+0x24 - [32-bit:HeadshotKillsInChapter]
//          |+0x28 - [32-bit:MeleeKillsInChapter]
//          |
//          |+0x70 - [32-bit:PlayerDeathsInChapter]
//          |+0x78 - [Lower4:DifficultyID(preferred) |32-bit]
//          |+0x7D - [8-bit:FavoriteWeapon_WeaponID]
//          |+0x80 - [32-bit:TotalKillsInChapter]
//          |+0x84 - [32-bit:TotalShotsFiredInChapter]
//          |+0x88 - [32-bit:TotalShotsHitInChapter]
//          |+0x8c - [32-bit:TotalHeadshotKillsInChapter]
//          |+0x90 - [32-bit:TotalMeleeKillsInChapter]
//          |
//          |+0x9c - [32-bit Pointer:SelectedPlayerProfileName(alt1)]
//          |+0xA0 - [bit0 BitFlag:Controls_IsLookInverted |8-bit]
//          |+0xA1 - [bit0 BitFlag:Controls_IsVibrationEnabled |8-bit]
//          |+0xA4 - [32-bit Float:Controls_LookSensitivity]
//          |+0xA8 - [32-bit Pointer:Controls_ControllerConfig]
//          |+0xAC - [bit0 BitFlag:Display_IsSubtitlesEnabled |32-bit]
//          |+0xB0 - [32-bit Float:Audio_Music_Volume]
//          |+0xB4 - [32-bit Float:Audio_FX_Volume]
//          |+0xB8 - [32-bit Float:Audio_Speech_Volume]
//          |+0xBC - [bit0:Audio_OutputMode |32-bit]
//          |
//          |+0xC0 - [32-bit Pointer(EntityData_B):PlayerActorData]
//          |+0xD4 - [32-bit Pointer:PlayerSavedStats]
//          |
//          |+0xE4 - [3-byte Bitset:LoreUnlocks]
//          |
//          |+0xF4 - [8-bit:StoryChapterID |16-bit]
//          |+0xF6 - [8-bit:FurthestProgressed_StoryChapterID |16-bit]
//          |
//          |+0x100 - [32-bit:SelectedPlayerProfileID]
//          |+0x104 - [32-bit Pointer:SelectedPlayerProfileName(alt2)]
//          |
//          |+0x128 - [32-bit Pointer:HUDcontrol_Health]
//          '
// $74E4E0: [PAL][32-bit (base) Pointer:CinematicCameraControl]
//          +0x18 - [32-bit (layer-1) Pointer]
//          .+0x70 - [Struct(Coordinates):CameraLocation)]
// $763D4C: [32-bit] turn ability flag
// $8075AC: [PAL][32-bit (base) Pointer:HUDcontrol_Gear(alt)]
//          - Prefer using [Pointer:HUDcontrol_Gear(preferred)] at $0x7238b8
// $80783C: [PAL][32-bit:CheckpointID(alt)]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          - Prefer using [32-bit:CheckpointID(preferred)] at $0x9114b4
// $807840: [PAL][32-bit (base) Pointer:CheckpointData_1] -> [Struct:CheckpointData]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          - [Struct:CheckpointData] contains data about which weapons the player has equipped as well as information about power/abilities
//          
//          +0x0 - [12-byte ASCII:CheckpointID]
//          | - These are unique on a Chapter basis (eg. All Chapters have a checkpoint identified as "Checkpoint_1")
//          | - CheckpointIDs listed at $0x9114b4
// $8FEAEC: [32-bit] Blood frenzy ability flag
// $8FFAC8: [8-bit] main menu selection
// $911430: [PAL][32-bit (base) Pointer:StoryChapterID]
//          +0x2 - [Variable Size ASCII:StoryChapterID]
//          | - Identification is also possible via [8-bit:StoryChapterID] at $0x965cf8
//          
//          # StoryChapterIDs (string)
//          |(list incomplete)
//          |'''''''''''''
//          | "WrongTrain" => Chapter 1, "Wrong Train"
//          | "M02_CanyonShoot => Chapter 2, "Ride Like The Devil"
//          | "M03_Cemetery => Chapter 3, "Boneyard"
//          | ...
// $911444: [PAL][Lower4:DifficultyID(alt1) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $91145C: [PAL][Lower4:DifficultyID(alt2) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $9114B4: (unverified - if the hexadecimal IDs are consistent)
//          [PAL][32-bit:CheckpointID(preferred)]
//          - Checkpoints can also be identified by [Pointer:CheckpointData_1].[Struct:CheckpointData].[ASCII:CheckpointID] at $0x807840
//          
//          # CheckpointIDs (hex) && (string)
//          |(list incomplete)
//          |''''''''''''''''
//          | 0x0 => No checkpoint reached/initialized
//          |
//          |---Chapter 1, "The Wrong Train"---
//          | ...
//          |---Chapter 2, "Ride Like The Devil"---
//          | ...
//          |---Chapter 3, "Boneyard"---
//          | 0x328 == "Checkpoint_1" => At start of Chapter
//          | 0x3DF == "Checkpoint_2" => Before Mark of Evil spawns near the church
//          | ...
//          '
// $9114B8: [PAL][32-bit (base) Pointer:CheckpointData_0]
//          - This pointer points to a memRegion with static data (fixed memory location)
//          
//          +0xC - [32-bit:CheckpointID(alt)]
//          | - Identical to [32-bit:CheckpointID(preferred)] at $0x9114b4
//          
//          +0x10 - [32-bit (layer-1) Pointer:CheckpointData_1]
//          | - Prefer using this pointer as a base pointer, as this is a static memRegion
// $925A84: [PAL][32-bit (base) Pointer:PlayerOnHorsebackLocation]
//          - This pointer is only valid when playing a Chapter on Horseback (eg. Chapter 2)
//          - This points to a memRegion which may also regulate coordinates for other Actors in the scene/map
//          
//          +0x80 - [Struct(Coordinates):PlayerOnHorsebackLocation]
//          | - These values regulate the location of the PlayerCharacterModel, not the horse.
//          | - Definition of [Struct:Coordinates] at $0x965cc4
//          | - (These are the functional coordinates)
// $953C24: [32-bit] current weapon equipped
// $953C28: [32-bit] current map timer
// $953C3C: [32-bit] current map Firearms kills
// $953C40: [32-bit] current map shots fired
// $953C44: [32-bit] current map shots hit enemies
// $953C4C: [32-bit] current map melee kills
// $953C70: [32-bit] last gunslinger map kills
// $953C74: [32-bit] last gunslinger map accuracy
// $953C80: Last Gunslinger Map Melee Kills [16-bit]
// $953C9C: Game Difficulty [16-Bit]
//          0x00 = Greenhorn
//          0x01 = Cowboy
//          0x02 = Shootist
//          0x03 = Deadeye
// $953D18: [8-bit] current single player map in-progress
// $953D1A: [8-bit] number of maps completed
// $953D24: [32-bit] profiles
//          0 = profile 1
//          1 = profile 2
//          2 = profile 3
// $960B3C: [32-bit] High calibar bullets ability flag
// $960D6C: [32-bit] black shroud ability flag
// $960F7C: [32-bit] shield ability flag
// $96438C: [32-bit] Lighting ability flag
// $965C04: [PAL][300-byte Struct(PlayerData):Player-1]
//          ===========================================
//          
//          [PAL][32-bit:EquippedWeapon_WeaponID-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          # WeaponIDS (hex)
//          |(list incomplete)
//          |''''''''''''
//          | 0x0 => BaiscRevolver
//          | 0x1 => RedeemerRevolver
//          | 0x4 => CarbineRifle
//          | 0x7 => ExplosiveCrossbow
//          | ...
//          '
// $965C08: [PAL][32-bit:TimeSpentInChapter]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This resets back to the saved value, [32-bit:TotalTimeSpentInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C1C: [PAL][32-bit:KillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Counts both melee and gun kills
//          - Also counts own PlayerDeaths, +1 for each PlayerDeath.
//          - This resets back to the saved value, [32-bit:TotalKillsInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C20: [PAL][32-bit:ShotsFiredInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This resets back to the saved value, [32-bit:TotalShotsFiredInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C24: [PAL][32-bit:ShotsHitInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This resets back to the saved value, [32-bit:TotalShotsHitInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C28: [PAL][32-bit:HeadshotKillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This resets back to the saved value, [32-bit:TotalHeadshotKillsInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C2C: [PAL][32-bit:MeleeKillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This resets back to the saved value, [32-bit:TotalMeleeKillsInChapter], on CheckpointRespawn. In Multiplayer a CheckpointRespawn only occurs when both Players are dead at the same time. (as Players respawn next to each other, when 1 Player is still alive)
// $965C70: [PAL][32-bit:TotalTimeSpentInChapter]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Time in milliseconds (1s = 1,000ms)
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:TimeSpentInChapter] is added to this value
//          - This is the value which determines the statistics on MainMenu->StatsMenu
// $965C74: [PAL][32-bit:PlayerDeathsInChapter]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Increments by 1 on CheckpointRespawn. In Singleplayer only when the character dies. In Multiplayer this only increments when ALL players are dead at the same time (as players respawn next to each other as long as one player is alive)
// $965C7C: [PAL][Lower4:DifficultyID(preferred) |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          # DifficultyIDs (hex)
//          |''''''''''''
//          | 0x0 => Greenhorn
//          | 0x1 => Cowboy
//          | 0x2 => Shootist
//          | 0x3 => Deadeye
// $965C81: (unverified)
//          [PAL][8-bit:FavoriteWeapon_WeaponID-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - WeaponIDS listed at $0x965c04
// $965C84: [PAL][32-bit:TotalKillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Counts both melee and gun kills
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:KillsInChapter] is added to this value
//          - This is the value which is saved to [Array:SavedStats] (refer to $0x965cd8)
// $965C88: [PAL][32-bit:TotalShotsFiredInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:ShotsFiredInChapter] is added to this value
//          - This is the value which is saved to [Array:SavedStats] (refer to $0x965cd8)
// $965C8C: [PAL][32-bit:TotalShotsHitInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:ShotsHitInChapter] is added to this value
//          - This is the value which is saved to [Array:SavedStats] (refer to $0x965cd8)
// $965C90: [PAL][32-bit:TotalHeadshotKillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:HeadshotKillsInChapter] is added to this value
//          - This is the value which is saved to [Array:SavedStats] (refer to $0x965cd8)
// $965C94: [PAL][32-bit:TotalMeleeKillsInChapter-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Only updates when reaching a checkpoint or finishing a Chapter, does not update on PlayerDeath
//          - On update: [32-bit:MeleeKillsInChapter] is added to this value
//          - This is the value which is saved to [Array:SavedStats] (refer to $0x965cd8)
// $965CA0: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt1)]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965CA4: [PAL][bit0 BitFlag:Controls_IsLookInverted-Player1 |8-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
// $965CA5: [PAL][bit0 BitFlag:Controls_IsVibrationEnabled-Player1 |8-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
// $965CA8: [PAL][32-bit Float:Controls_LookSensitivity-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          [0.0-1.0] => min. up to max. sensitivity
// $965CAC: [PAL][32-bit (base) Pointer:Controls_ControllerConfig-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          +0x2 - [Variable Size ASCII:ControllerConfig_NameID]
//          | - Available configs: "Default", "Lefty", "Hopalong", "Hoss"
// $965CB0: [PAL][bit0 BitFlag:Display_IsSubtitlesEnabled |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
// $965CB4: [PAL][32-bit Float:Audio_Music_Volume]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          [0.0-1.0] => min. up to max. volume
// $965CB8: [PAL][32-bit Float:Audio_FX_Volume]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          [0.0-1.0] => min. up to max. volume
// $965CBC: [PAL][32-bit Float:Audio_Speech_Volume]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          [0.0-1.0] => min. up to max. volume
// $965CC0: [PAL][bit0:Audio_OutputMode |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          0 => Surround
//          1 => Stereo
// $965CC4: [PAL][32-bit (base) Pointer(EntityData_B):PlayerActorData-Player1] -> [Struct:EntityData-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This base pointer is only active during gameplay
//          
//          +0x30 - [12-byte Struct(Coordinates):PlayerLocation(copy)]
//          | - These coordinates are copied from [Struct:EntityComponentData.CharacterStateMachineComponent].[Struct(Coordinates):PlayerLocation(functional)]
//          | - Definition of [Struct:Coordinates] below
//          
//          +0x44 - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:EntityNameID]
//          .| - ASCII = "Chaz", this is a short name for Jericho Cross (PlayerCharacter)
//          
//          +0x58 - [32-bit (layer-1) Pointer:EntityComponents] -> [Dictionary:EntityComponents]
//          .+0x5C - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.CharacterStateMachineComponent]
//          .| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x7B
//          .| - This pointer is only valid when playing Multiplayer Mode
//          ..+0xF0 - [32-bit (layer-3) Pointer]
//          ...+0x0 - [32-bit (layer-4) Pointer]
//          ....+0x90 - [32-bit (layer-5) Pointer]
//          .....+0x30 - [32-bit (layer-6) Pointer]
//          ......+0xB0 - [Struct(Coordinates):PlayerLocation_Multiplayer(functional)]
//          ......| - These are the functional coordinates, changing these moves the player character
//          ......| - Definition of [Struct:Coordinates] below
//          .
//          .+0x64 - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.CharacterStateMachineComponent]
//          .| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x7B
//          .| - This pointer is only valid when playing SinglePlayer Mode
//          ..+0xF0 - [32-bit (layer-3) Pointer]
//          ...+0x0 - [32-bit (layer-4) Pointer]
//          ....+0x90 - [32-bit (layer-5) Pointer]
//          .....+0x30 - [32-bit (layer-6) Pointer]
//          ......+0xB0 - [Struct(Coordinates):PlayerLocation(functional)]
//          ......| - These are the functional coordinates, changing these moves the player character
//          ......| - Definition of [Struct:Coordinates] below
//          .
//          .+0x74 - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.HealthComponent(player)]
//          .| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x4B
//          .| - This pointer is only valid when playing Multiplayer Cooperative Mode
//          .| - Definition of [Struct:EntityComponent.HealthComponent(player)] below
//          .
//          .+0x7C - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.HealthComponent(player)]
//          .| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x4B
//          .| - This pointer is only valid when playing SinglePlayer Mode OR Multiplayer Versus Mode
//          .| - Definition of [Struct:EntityComponent.HealthComponent(player)] below
//          
//          +0x70 - [32-bit (layer-1) Pointer]
//          .+0x0 - [32-bit (layer-2) Pointer] -> [Struct:EntityData]
//          .| - Definition of [Struct:EntityData] at $0x721788
//          .| - This [Struct:EntityData] changes all memberValues when switching to another weapon
//          ..
//          ..+0x44 - [32-bit (layer-3) Pointer]
//          ...+x2 - [Variable Size ASCII:Equipped_WeaponNameID]
//          ...| - WeaponNameIDs listed below
//          ..
//          ..+0x58 - [32-bit (layer-3) Pointer] -> [Dictionary:EntityWeaponComponents] List of [Struct:ListItem_EntityComponent]
//          ..| - Definition of [Struct:ListItem_EntityComponent] at $0x721788
//          ..| - A key-value paired list of EntityComponents (= components with game logic linked to the Entity)
//          ..| - This dictionary contains data for the different weapons of the player
//          ..| - The ListItems get reordered when unlocking certain gameplay mechanics. (eg. when unlocking dynamite, some of the ListItems get reordered)
//          ...
//          ...
//          ...+0xC - [32-bit (layer-4) Pointer:EntityComponentData_Dynamite] -> [Struct:EntityComponentData.WeaponComponent(dynamite)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(dynamite)] below
//          ...
//          ...+0x2C - [32-bit (layer-4) Pointer:EntityComponentData_Crossbow] -> [Struct:EntityComponentData.WeaponComponent(normalWeapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(normalWeapon)] below
//          ...| - This pointer is only valid when wielding the Crossbow
//          ...
//          ...+0x34 - [32-bit (layer-4) Pointer:EntityComponentData_BaiscPistol] -> [Struct:EntityComponentData.WeaponComponent(normalWeapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(normalWeapon)] below
//          ...| - This pointer is only valid for Chapter 1, when the player only has the BasicPistol equipped
//          ...| - Once the player has the RedeemerRevolver, refer to [Pointer:EntityComponentData_NormalWeapon(1)]
//          ...
//          ...+0x3C - [32-bit (layer-4) Pointer:EntityComponentData_NormalWeapon(noDynamite)] -> [Struct:EntityComponentData.WeaponComponent(normalWeapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(normalWeapon)] below
//          ...| - This pointer is only valid when the player has not unlocked dynamite yet, thus should only be used up to Chapter 3, where the player first unlocks dynamite
//          ...| - Once the player has unlocked dynamite, refer to [Pointer:EntityComponentData_NormalWeapon(2)]
//          .
//          .+0xC - [32-bit (layer-2) Pointer]
//          ..+0x0 - [32-bit (layer-3) Pointer]
//          ...+0x58 - [32-bit (layer-4) Pointer]
//          ....+0x34 - [32-bit (layer-5) Pointer:EntityComponentData_MultiplayerNormalWeapon] -> [Struct:EntityComponentData.WeaponComponent(normalWeapon)]
//          ....| - This pointer chain is only valid in Multiplayer Versus Mode and only for a few select weapons
//          ....
//          ....+0x3C - [32-bit (layer-5) Pointer:EntityComponentData_NormalWeapon(dynamiteUnlocked)] -> [Struct:EntityComponentData.WeaponComponent(normalWeapon)]
//          ....| - This pointer chain is only valid when the player has unlocked dynamite
//          
//          [Definition Struct:EntityComponentData.CharacterStateMachineComponent |??-byte]
//          |''''''''''''''''''''''''''''''
//          |
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "CharacterStateMachineComponent"
//          |
//          |+0xF0 - [32-bit (layer-1) Pointer]
//          |.+0x0 - [32-bit (layer-2) Pointer]
//          |..+0x90 - [32-bit (layer-3) Pointer]
//          |...+0x30 - [32-bit (layer-4) Pointer]
//          |....+0xB0 - [Struct(Coordinates):PlayerLocation(functional)]
//          |....| - These are the functional coordinates, changing these moves the player character
//          |....| - Definition of [Struct:Coordinates] below
//          |/
//          '
//          
//          [Definition Struct:EntityComponentData.HealthComponent(player) |??-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "HealthComponent"
//          |
//          |+0x98 - [Float:PlayerHealth(functional) |32-bit]
//          || - FloatRange: [0.0 --- 100.0]; 100.0 = maxHP; 0.0 = Death
//          || - Reference [Float:PlayerHealth(display)] at $0x965d2c
//          |
//          |+0xA0 - [Float:BloodShield(functional) |32-bit]
//          || - FloatRange: [0.0 --- 100.0]; 100.0 = maxShield; 0.0 = empty
//          || - Reference [Float:BloodShield(display)] at $0x965d2c
//          '
//          
//          [Definition Struct:EntityComponentData.WeaponComponent(normalWeapon) |??-byte]
//          |'''''''''''''''''''''''
//          | - This struct contains data on weapon ammuntion
//          |
//          |+0x8 - [32-bit (layer-5) Pointer]
//          |.+x2 - [Variable Size ASCII:EntityComponentName] = "WeaponComponent"
//          |.| - Miscellaneous data
//          |
//          |+0x20 -[32-bit (layer-5) Pointer]
//          |.+x2 - [Variable Size ASCII:WeaponNameID]
//          |.| - WeaponNameIDs listed below
//          |
//          |+0x74 - [32-bit:LoadedBullets(functional)]
//          || - This value regulates the amount of bullets loaded inside the gun
//          |
//          |+0x80 - [32-bit:MaxReserveAmmo(functional)]
//          || - This value regulates the maximum allowed reserve ammunition
//          |
//          |+0x84 - [32-bit:MagazineSize(functional)]
//          || - This value regulates how many bullets can be loaded inside the gun
//          '
//          
//          [Definition Struct:EntityComponentData.WeaponComponent(dynamite) |??-byte]
//          |''''''''''''''''''''''''''''''
//          | - This struct contains data which regulates the throwable dynamite bundles
//          |
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "WeaponComponent"
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |.+x2 - [Variable Size ASCII:WeaponNameID] = "Dynamite"
//          |
//          |+0x74 - [32-bit:DynamiteCountInInventory(functional-1)]
//          || - This value is always at 1 as long as dynamite bundles left in inventory > 0
//          || - Manually changing this value, puts that amount of dynamite bundles in the player's inventory, but this is not the intended design. (eg. manually placing 0x10 on this value, puts 16 dynamite bundles in the inventory)
//          || - Total number of dynamite bundles = [32-bit:DynamiteCountInInventory(functional-1)] + [32-bit:DynamiteCountInInventory(functional-2)]
//          |
//          |+0x1D8 - [32-bit:DynamiteCountInInventory(functional-2)]
//          || - This value regulates the amount of dynamite bundles in the player's inventory
//          || - Freezing this value above 0, gives the player unlimited dynamite bundles
//          || - This count is always 1 count lower than the count shown on the [32-bit:DynamiteCountInInventory(display)] ($0x7238b8)
//          || - When the display value is at 1, this functional value is at 0. The player can then throw 1 more dynamite bundle, afterwards this functional value remains at 0 and the display value becomes 0.
//          '
//          
//          [Definition Struct:Coordinates |12-byte]
//          |'''''''''''''''''''''''
//          |+0x0 - [Float:Coordinate_X |32-bit]
//          |+0x4 - [Float:Coordinate_Z |32-bit]
//          |+0x8 - [Float:Coordinate_Y |32-bit]
//          '
//          
//          # WeaponNameIDs (string)
//          |(list incomplete)
//          |''''''''''''
//          | "BasicPistol" => BasicRevolver
//          | "Revolver" => RedeemerRevolver
//          | "Rifle" => CarbineRifle
//          | "Dynamite" => Dynamite_throwable
//          | ...
//          '
// $965CD8: [PAL][32-bit (base) Pointer:PlayerSavedStats-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          +0x4 - [32-bit (layer-1) Pointer] -> [Array:SavedStats_Story]
//          +0xC - [32-bit (layer-1) Pointer] -> [Array:SavedStats_Gunslinger]
// $965CE8: [PAL][3-byte Bitset:LoreUnlocks] (19 flags)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This bitset handles which Lore sections are unlocked in the PauseMenu->LoreMenu
//          - These flags unlock once the corresponding LorePopup is shown on screen for the first time for the selected PlayerProfile
//          - This bitset is saved to the PlayerProfileSave. When doing new game, all previously unlocked flags will still remain unlocked
//          
//          [Definition Bitset:LoreUnlocks |3-byte]
//          |'''''''''''''''''''''
//          |+0x0 - [BitFlags of Bitset(byte-0):LoreUnlocks]
//          | - bit0 => Ammo Display
//          | - bit1 => Blood Clouds
//          | - bit2 =>
//          | - bit3 =>
//          | - bit4 =>
//          | - bit5 =>
//          | - bit6 =>
//          | - bit7 =>
//          |
//          |+0x1 - [BitFlags of Bitset(byte-1):LoreUnlocks]
//          | - bit0 =>
//          | - bit1 =>
//          | - bit2 =>
//          | - bit3 =>
//          | - bit4 =>
//          | - bit5 =>
//          | - bit6 =>
//          | - bit7 =>
//          |
//          |+0x2 - [BitFlags of Bitset(byte-2):LoreUnlocks]
//          | - bit0 =>
//          | - bit1 =>
//          | - bit2 =>
//          | - bits[3-7] => //
//          '
// $965CF8: [PAL][8-bit:StoryChapterID |16-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Current Chapter marked as "in-progress" OR the currently active Chapter
//          - Identification is also possible via [ASCII:StoryChapterID] at $0x911430
//          - This value also regulates which powers are unlocked (at MainMenu->StatsMenu)
//          
//          # StoryChapterIDs (hex)
//          |'''''''''''''
//          | 0x1 => Chapter 1, "Wrong Train"
//          | 0x2 => Chapter 2, "Ride Like The Devil"
//          | 0x3 => Chapter 3, "Boneyard"
//          | 0x4 => TBD
//          | 0x5 => TBD
//          | 0x6 => TBD
//          | 0x7 => TBD
//          | 0x8 => TBD
//          | 0x9 => TBD
//          | 0xA => TBD
//          | 0xB => TBD
//          | 0xC => TBD
//          | 0xD => TBD
//          | 0xE => TBD
//          | 0xF => TBD
//          | 0x10 => TBD
//          | 0x11 => TBD
//          | 0x12 => TBD
//          '
// $965CFA: [PAL][8-bit:FurthestProgressed_StoryChapterID |16-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - StoryChapterIDs listed at $0x965cf8
// $965D04: [PAL][32-bit:SelectedPlayerProfileID]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Max allowed PlayerProfiles is 10
//          0xFFFFFFFF => on game boot, until a PlayerProfile is selected; Also when playing Multiplayer
//          [0x0-0x9] => PlayerProfile-1 up to PlayerProfile-10; only when playing SinglePlayer
// $965D08: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt2)]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965D2C: [PAL][32-bit (base) Pointer:HUDcontrol_Health-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x18 - [32-bit (layer-2) Pointer]
//          ..+0xF0 - [Float:PlayerHealth(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxHP; 0.0 = death
//          ..| - Reference [Float:PlayerHealth(functional)] at $0x965cc4
//          ..+0xF4 - [Float:BloodShield(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxShield; 0.0 = empty
//          ..| - Reference [Float:BloodShield(functional)] $0x965cc4
//          .
//          .+0x8 - [32-bit (layer-2) Pointer]
//          ..+0xC - [32-bit (layer-3) Pointer]
//          ...+0x2C - [32-bit (layer-4) Pointer]
//          ....+0x80 - [Float:BossHP(display)(alt1) |32-bit]
//          ....+0x90 - [Float:BossHP(display)(alt2) |32-bit]
//          ....| - Above two Floats are somewhat related to the HUD display of the boss HP bar.
//          ....| - Prefer using [Float:BossHP(display)(preferred)], see below
//          ....
//          ....+0xEC - [Float:BossHP(display)(preferred) |32-bit]
//          ....| - This Float directly regulates the HUD display of the boss HP bar.
//          ....| - FloatRange: [1.0 --- 0.0]; 1.0 = maxHP; 0.0 = death
//          ....| - Reference [Pointer:BossEntityComponentData].[Float:BossHP(functional)] in this same pointer chain
//          ....
//          ....+0xF4 - [32-bit (layer-5) Pointer:BossEntityData] -> [Struct:EntityData]
//          ....| - Defintion of [Struct:EntityData] at $0x721788
//          .....+0x58 - [32-bit (layer-6) Pointer:BossEntityComponents] -> [Dictionary:EntityComponents] List of [Struct:ListItem_EntityComponent]
//          .....| - EntityComponents may not be always in the same order in the list, between Chapters
//          ......
//          ......+0x4C - [32-bit (layer-7) Pointer:BossEntityComponentData_A] -> [Struct:EntityComponent.HealthComponent(boss)]
//          ......| - The [32-bit:DictionaryKey] for this [Dictionary:EntityComponents].[Struct:ListItem_EntityComponent] = 0x4B
//          ......| - This pointer is only valid for Chapter 1
//          .......+0x98 - [Float:BossHP(functional) |32-bit]
//          ......
//          ......+0x5C - [32-bit (layer-7) Pointer:BossEntityComponentData_B] -> [Struct:EntityComponent.HealthComponent(boss)]
//          ......| - The [32-bit:DictionaryKey] for this [Dictionary:EntityComponents].[Struct:ListItem_EntityComponent] = 0x4B
//          ......| - This pointer is only valid for Chapter 2
//          .......+0x98 - [Float:BossHP(functional) |32-bit]
// $965D30: [PAL][300-byte Struct(PlayerData):Player-2]
//          ===========================================
//          - PlayerData for player2 is only populated when starting Multiplayer
//          
//          [PAL][32-bit:EquippedWeapon_WeaponID-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965D48: [PAL][32-bit:KillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965D4C: [PAL][32-bit:ShotsFiredInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
// $965D50: [PAL][32-bit:ShotsHitInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965D54: [PAL][32-bit:HeadshotKillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965D58: [PAL][32-bit:MeleeKillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DAD: (unverified) [PAL][8-bit:FavoriteWeapon_WeaponID-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DB0: [PAL][32-bit:TotalKillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DB4: [PAL][32-bit:TotalShotsFiredInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DB8: [PAL][32-bit:TotalShotsHitInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DBC: [PAL][32-bit:TotalHeadshotKillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DC0: [PAL][32-bit:TotalMeleeKillsInChapter-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DD0: [PAL][bit0 BitFlag:Controls_IsLookInverted-Player2 |8-bit]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DD1: [PAL][bit0 BitFlag:Controls_IsVibrationEnabled-Player2 |8-bit]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DD4: [PAL][Float:Controls_LookSensitivity-Player2 |32-bit]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DD8: [PAL][32-bit (base) Pointer:Controls_ControllerConfig-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965DF0: [PAL][32-bit (base) Pointer(EntityData_B):PlayerActorData-Player2] -> [Struct:EntityData-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965E04: [PAL][32-bit (base) Pointer:PlayerSavedStats-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $965E58: [PAL][32-bit (base) Pointer:HUDcontrol_Health-Player2]
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x74d78c)
//          - Documentation refer to [Struct(PlayerData):Player-1]
// $9670B4: [PAL][32-bit (base) Pointer:WeaponGunShotAudioID]
//          +0x3C - [32-bit (layer-1) Pointer]
//          .+0xD0 - [32-bit (layer-2) Pointer]
//          ..+0x58 - [32-bit:EquippedWeapon_GunShotAudioID]
//          ..| - This value kinda regulates the audio sound when firing the equipped weapon
//          ..| - Practically this can be used to identify which weapon is equipped
//          
//          # EquippedWeapon_GunShotAudioIDs (hex)
//          |'''''''''''''''''
//          | 0x79B39 => BasicRevolver
//          | 0x4C623 => RedeemerRevolver
//          | 0x3A92A => CarbineRifle
//          | 0x544F1 => ExplosiveCrossbow
//          '
// $9B69F8: Difficulty Option Highlighted [32-Bit]
//          0x00 = Greenhorn
//          0x01 = Cowboy
//          0x02 = Shootist
//          0x03 = Deadeye
// $9E873C: [pointer chain]
//          -+00 = pointer to first map kills
//          --+1C = First map kills
//          --+54 = second map kills
// $9E8744: [Pointer]
//          00 = Gunslinger data array start
// $9FF2DC: [32-bit] Fear ability flag
// $A6F0B4: [32-bit] final boss
//          3 = casside
//          4 = tala
// $AED58C: [32-bit] using ability flag
// $AED8EC: [32-bit] Soul reaver ability flag
// $AF80DC: [32-bit] evil ability flag
// $FAEE24: [PAL][32-bit (base) Pointer:PlayerInput(alt)]
//          - Prefer using [Pointer:PlayerInput(preferred)] at $0x721900
// $15C4A5C: [32-bit] current weapon reserve ammo
// $15C4A60: [32-bit] current weapon magazine ammo
// $15C4A68: [32-bit] dynamites
// $1FFF570: [Pointer chain]
//           
//           -+0xffffffac = pointer to the array of final boss
//           
//           --+98 = [float] final boss health
