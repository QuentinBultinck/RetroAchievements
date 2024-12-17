// Darkwatch
// #ID = 19111

// $69B4F0: [32-bit] current weapon equipped
// $71FF88: [8-bit] in gameplay flag
// $7215CC: [PAL][10-byte ASCII:GameID]
//          "SLES_535.64" => PAL/EU PS2 Game ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - Succeeding [2-byte ASCII] = ";1"
// $727318: [8-bit] gunslinger map id
// $728FA0: [PAL][10-byte ASCII:SelectedPlayerProfileName]
//          - Max size is 10 characters
//          - ASCII value is set when creating a new PlayerProfile or when selecting an existing one
//          - Each PlayerProfileName is required to be unique, can't have 2 PlayerProfiles with the same name
// $72BBD8: Player in Movie Cutscene [8-Bit]
//          0x01= Yes
// $763D4C: [32-bit] turn ability flag
// $8FEAEC: [32-bit] Blood frenzy ability flag
// $8FFAC8: [8-bit] main menu selection
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
// $965CA0: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt1)]
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965CA4: [PAL][bit0 BitFlag:Controls_IsLookInverted |8-bit]
// $965CA5: [PAL][bit0 BitFlag:Controls_IsVibrationEnabled |8-bit]
// $965CA8: [PAL][32-bit Float:Controls_LookSensitivity]
//          [0.0-1.0] => min. up to max. sensitivity
// $965CAC: [PAL][32-bit (base) Pointer:Controls_ControllerConfig]
//          +0x0 - [Variable Size ASCII:ControllerConfig_NameID]
//          | - Available configs: "Default", "Lefty", "Hopalong", "Hoss"
// $965CB0: [PAL][bit0 BitFlag:Display_IsSubtitlesEnabled |32-bit]
// $965CB4: [PAL][32-bit Float:Audio_Music_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CB8: [PAL][32-bit Float:Audio_FX_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CBC: [PAL][32-bit Float:Audio_Speech_Volume]
//          [0.0-1.0] => min. up to max. volume
// $965CC0: [PAL][32-bit:Audio_OutputMode]
//          0x0 => Surround
//          0x1 => Stereo
// $965D04: [PAL][32-bit:SelectedPlayerProfileNumberID]
//          - Max allowed PlayerProfiles is 10
//          0xFFFFFFFF => on game boot, until a PlayerProfile is selected
//          [0x0-0x9] => PlayerProfile-1 up to PlayerProfile-10
// $965D08: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt2)]
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
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
// $15C4A5C: [32-bit] current weapon reserve ammo
// $15C4A60: [32-bit] current weapon magazine ammo
// $15C4A68: [32-bit] dynamites
// $1FFF570: [Pointer chain]
//           
//           -+0xffffffac = pointer to the array of final boss
//           
//           --+98 = [float] final boss health
