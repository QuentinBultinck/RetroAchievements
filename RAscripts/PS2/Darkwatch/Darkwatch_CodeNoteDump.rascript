// Darkwatch
// #ID = 19111

// $134214: [PAL][32-bit (base) Pointer:SofdecStreamData(alt)] -> [Struct:SofdecStreamData]
//          - Prefer using [Pointer:SofdecStreamData(preferred)] at $0x134408
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr may be used by other game logic.
//          - Definition of [Struct:SofdecStreamData] at $0x134408
//          
//          ------Simplified_Documentation------
//          [32-bit (base) Pointer:SofdecStreamData(alt)]
//          |+0x12C - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          |+0x14C - [5-byte ASCII:Sofdec_FMVID]
//          '
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
//          |+0x134 - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          |+0x154 - [5-byte ASCII:Sofdec_FMVID]
//          '
//          
//          ------Advanced_Documentation------
//          [Definition Struct:SofdecStreamData |1000-byte??]
//          |'''''''''''''''''''''''''''''''''''''''''
//          |+0x12C - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          || - "SofdecStream" => FMV is being played
//          || - anyOtherASCIIvalue => FMV is NOT being played
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
// $721900: [PAL][32-bit (base) Pointer:PlayerInput(preferred)]
//          - This pointer may point to a memRegion which is mostly static
//          
//          ------Simplified_Documentation------
//          [32-bit (base) Pointer:PlayerInput]
//          +0x4 - [52-byte Struct(ControllerInput):Controller-1] ---------------
//          +0x4 - [bit0 Bitflag:IsControllerConnected_Controller-1 |16-bit]
//          
//          +0x6 -[bit0 Bitflag:IsInputPressed_Select_Controller-1 |8-bit]
//          +0x7 -[bit0 Bitflag:IsInputPressed_Start_Controller-1 |8-bit]
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
//          +0x3A -[bit0 Bitflag:IsInputPressed_Select_Controller-2 |8-bit]
//          +0x3B -[bit0 Bitflag:IsInputPressed_Start_Controller-2 |8-bit]
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
//          .+0x0 - [32-bit (layer-2) Pointer]
//          .+0x70 - [32-bit (layer-3) Pointer]
//          ..+0xEC - [32-bit:EquippedWeapon_ReserveAmmo(display)]
//          ..| - This value displays the reserve ammunition
//          ..| - Functional values via [Pointer:PlayerActorData] at $0x965cc4
//          ..
//          ..+0xF0 - [32-bit:EquippedWeapon_LoadedBullets(display)]
//          ..| - This value displays the amount of bullets icons displayed
//          ..
//          ..+0xF4 - [32-bit:EquippedWeapon_MagazineSize(display)]
//          ..| - This value actually regulates the display of the bullet icons
//          ..| - Practically this value can be used to counts how many bullets can be loaded inside the gun
//          ..
//          ..+0xF8 - [32-bit:DynamiteCountInInventory(display)]
//          ..| - This value display how many dynamite bundles are player has in his inventory
// $727318: [8-bit] gunslinger map id
// $728FA0: [PAL][10-byte ASCII:SelectedPlayerProfileName]
//          - Max size is 10 characters
//          - ASCII value is set when creating a new PlayerProfile or when selecting an existing one
//          - Each PlayerProfileName is required to be unique, can't have 2 PlayerProfiles with the same name
// $72BBD8: Player in Movie Cutscene [8-Bit]
//          0x01= Yes
// $763D4C: [32-bit] turn ability flag
// $8075AC: [PAL][32-bit (base) Pointer:HUDcontrol_Gear(alt)]
//          - Prefer using [Pointer:HUDcontrol_Gear(preferred)] at $0x7238b8
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
// $965C04: [PAL][32-bit:Equipped_WeaponID]
//          
//          # WeaponIDS (hex)
//          |(list incomplete)
//          |''''''''''''
//          | 0x0 => BasicRevolver
//          | 0x1 => Redeemer
//          | 0x4 => Carbine
//          | ...
//          '
// $965C08: [PAL][32-bit:TimeSpentInChapter]
// $965C1C: [PAL][32-bit:Kills]
//          - Counts both melee and gun kills
// $965C20: [PAL][32-bit:ShotsFired]
// $965C24: [PAL][32-bit:ShotsHit]
// $965C28: [PAL][32-bit:HeadshotKills]
// $965C2C: [PAL][32-bit:MeleeKills]
// $965C7C: [PAL][Lower4:DifficultyID(preferred) |32-bit]
//          0x0 => Greenhorn
//          0x1 => Cowboy
//          0x2 => Shootist
//          0x3 => Deadeye
// $965CA0: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt1)]
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965CA4: [PAL][bit0 BitFlag:Controls_IsLookInverted |8-bit]
// $965CA5: [PAL][bit0 BitFlag:Controls_IsVibrationEnabled |8-bit]
// $965CA8: [PAL][32-bit Float:Controls_LookSensitivity]
//          [0.0-1.0] => min. up to max. sensitivity
// $965CAC: [PAL][32-bit (base) Pointer:Controls_ControllerConfig]
//          +0x2 - [Variable Size ASCII:ControllerConfig_NameID]
//          | - Available configs: "Default", "Lefty", "Hopalong", "Hoss"
// $965CB0: [PAL][bit0 BitFlag:Display_IsSubtitlesEnabled |32-bit]
// $965CB4: [PAL][32-bit Float:Audio_Music_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CB8: [PAL][32-bit Float:Audio_FX_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CBC: [PAL][32-bit Float:Audio_Speech_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CC0: [PAL][bit0:Audio_OutputMode |32-bit]
//          0 => Surround
//          1 => Stereo
// $965CC4: [PAL][32-bit (base) Pointer:PlayerActorData]
//          
//          +0x30 - [12-byte Struct(Coordinates):PlayerLocation(copy)]
//          | - These coordinates are copied from [Struct(Coordinates):PlayerLocation(functional)]
//          | - Definition of [Struct:Coordinates] below
//          
//          +0x58 - [32-bit (layer-1) Pointer]
//          .+0x64 - [32-bit (layer-2) Pointer]
//          ..+0xF0 - [32-bit (layer-3) Pointer]
//          ...+0x0 - [32-bit (layer-4) Pointer]
//          ....+0x90 - [32-bit (layer-5) Pointer]
//          .....+0x30 - [32-bit (layer-6) Pointer]
//          ......+0xB0 - [Struct(Coordinates):PlayerLocation(functional)]
//          ......| - These are the functional coordinates, changing these moves the player character
//          ......| - Definition of [Struct:Coordinates] below
//          .
//          .+0x7C - [32-bit (layer-2) Pointer]
//          ..+0x98 - [Float:PlayerHealth(functional) |32-bit]
//          ..| - FloatRange: [0.0 --- 100.0]; 100.0 = maxHP; 0.0 = Death
//          ..| - Reference [Float:PlayerHealth(display)] at $0x965d2c
//          ..+0x98 - [Float:BloodShield(functional) |32-bit]
//          ..| - FloatRange: [0.0 --- 100.0]; 100.0 = maxShield; 0.0 = empty
//          ..| - Reference [Float:BloodShield(display)] at $0x965d2c
//          
//          +0x70 - [32-bit (layer-1) Pointer]
//          .+0x0 - [32-bit (layer-2) Pointer]
//          ..+0x58 - [32-bit (layer-3) Pointer] -> [Dictionary:PlayerComponents]
//          ..| - A key-value paired list of mostly miscellaneous data, although components may shift on certain occassions
//          ...
//          ...+0xC - [32-bit (layer-4) Pointer] -> [Struct:DynamiteManager]
//          ...
//          ...+0x34 - [32-bit (layer-4) Pointer:EquippedWeapon_BaiscPistol] -> [Struct:EquippedWeapon_WeaponData]
//          ...| - This pointer is only valid for the first mission, when the player only has the BasicPistol equipped, thus only in Chapter 1
//          ...
//          ...+0x3C - [32-bit (layer-4) Pointer:EquippedWeapon_WeaponData(1)] -> [Struct:EquippedWeapon_WeaponData]
//          ...| - This pointer is only valid when the player has not unlocked dynamite yet, thus should only be used up to Chapter 3, where the player first unlocks dynamite
//          .
//          .+0xC - [32-bit (layer-2) Pointer:EquippedWeapon_WeaponData(2)]
//          .| - This pointer chain is only valid when the player has unlocked dynamite
//          .
//          ..+0x0 - [32-bit (layer-3) Pointer]
//          ...+0x58 - [32-bit (layer-4) Pointer]
//          ....+0x3C - [32-bit (layer-5) Pointer] -> [Struct:EquippedWeapon_WeaponData]
//          
//          
//          [Definition Struct:DynamiteManager |??-byte]
//          |'''''''''''''''''''''''
//          | - This struct contains data which regulates the throwable dynamite bundles
//          |
//          |+0x8 - [32-bit (layer-5) Pointer]
//          |.+x2 - [15-byte ASCII] = "WeaponComponent"
//          |.| - Miscellaneous data
//          |
//          |+0x10 -[32-bit (layer-5) Pointer]
//          |.+x2 - [8-byte ASCII] = "Dynamite"
//          |.| - Miscellaneous data
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
//          [Definition Struct:EquippedWeapon_WeaponData |??-byte]
//          |'''''''''''''''''''''''
//          | - This struct contains data on ammuntion and perhaps other data as well...
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
//          [Definition Struct:Coordinates |12-byte]
//          |'''''''''''''''''''''''
//          |+0x0 - [Float:Coordinate_X |32-bit]
//          |+0x4 - [Float:Coordinate_Z |32-bit]
//          |+0x8 - [Float:Coordinate_Y |32-bit]
//          '
// $965CF8: [PAL][8-bit:StoryChapterID]
//          - Current Chapter marked as "in-progress" OR the currently active Chapter
//          - Identification is also possible via [ASCII:StoryChapterID] at $0x911430
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
//          - StoryChapterIDs listed at $0x965cf8
// $965D04: [PAL][32-bit:SelectedPlayerProfileID]
//          - Max allowed PlayerProfiles is 10
//          0xFFFFFFFF => on game boot, until a PlayerProfile is selected
//          [0x0-0x9] => PlayerProfile-1 up to PlayerProfile-10
// $965D08: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt2)]
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965D2C: [PAL][32-bit (base) Pointer:HUDcontrol_Health]
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x18 - [32-bit (layer-2) Pointer]
//          ..+0xF0 - [Float:PlayerHealth(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxHP; 0.0 = death
//          ..| - Reference [Float:PlayerHealth(functional)] at $0x965cc4
//          ..+0xF4 - [Float:BloodShield(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxShield; 0.0 = empty
//          ..| - Reference [Float:BloodShield(functional)] $0x965cc4
// $9B69F8: Difficulty Option Highlighted [32-Bit]
//          0x00 = Greenhorn
//          0x01 = Cowboy
//          0x02 = Shootist
//          0x03 = Deadeye
// $9BBE88: [PAL]
// $9E873C: [pointer chain]
//          -+00 = pointer to first map kills
//          --+1C = First map kills
//          --+54 = second map kills
// $9E8744: [Pointer]
//          00 = Gunslinger data array start
// $9FF2DC: [32-bit] Fear ability flag
// $A5C070: playerData
// $A6F0B4: [32-bit] final boss
//          3 = casside
//          4 = tala
// $AED58C: [32-bit] using ability flag
// $AED8EC: [32-bit] Soul reaver ability flag
// $AF80DC: [32-bit] evil ability flag
// $DCE200: playerData
// $F2FBD0: 104-byte
// $F3D684: speech audio
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
