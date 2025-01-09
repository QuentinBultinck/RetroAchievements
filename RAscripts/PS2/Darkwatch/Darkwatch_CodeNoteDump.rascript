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
//          |+0x14C - [6-byte ASCII:Sofdec_FMVID]
//          || - This is actually the SofdecStreamID (about 17-byte long), but the first 5-byte of this ID can be used to identify which FMV is being played
//          || - Sofdec_FMVIDs listed below
//          '
//          
//          # Sofdec_FMVIDs (string)
//          |(list incomplete)
//          |'''''''''''''''''''
//          | "DWATTR" => Demo video, which plays when idle at the Start-/TitleMenu
//          | "PROLOG" => Intro video, which plays on game boot
//          | "PS2MAI" => Main Menu background (looping) video
//          |
//          |---Chapter 1, "The Wrong Train"---
//          | "M01S1_" => Jericho enters train
//          | "M01S2_" => Jericho blows up door vault
//          | "M01S3_" => ???
//          | "M01S4_" => Jericho blows up Lazarus + Escape on horse
//          |---Chapter 2, "Ride Like The Devil"---
//          | "M02S1_" => Lazarus escape from train wreck + Pursues Jericho
//          |---Chapter 3, "Boneyard"---
//          | "M04S1_" => End of Chapter, Cassidy dies
//          |---Chapter 4, "Devil's Belly Mine"---
//          | ...
//          |---Chapter 5, "Darkwatch Outpost"---
//          | ...
//          |---Chapter 6, "War Train"---
//          | ...
//          |---Chapter 7, "Torture Maze"---
//          | ...
//          |---Chapter 8, "Baptism of Fire"---
//          | ...
//          |---Chapter 9, "Citadel"---
//          | ...
//          |---Chapter 10, "Rescue"---
//          | ...
//          |---Chapter 11, "The Deadlight Prism"---
//          | ...
//          |---Chapter 12, "Invasion"---
//          | ...
//          |---Chapter 13, "Hangtown"---
//          | ...
//          |---Chapter 14, "The Morning After"---
//          | ...
//          |---Chapter 15, "The Price of Passion"---
//          | ...
//          |---Chapter 16, "Showdown"---
//          | ...
//          |---Chapter 17, "The Right Train"---
//          | ...
//          |---Chapter 18, "Deadfall"---
//          | ...
//          |---Chapter 19, "Curse of The West"---
//          | ...
//          '
// $2CD9C4: [NTSCU][AssemblyInstruction:SplitScreenImageRender |32-bit]
//          @Widescreen Hack (NTSC-U) - Image Render SplitScreen Multiplayer
//          - This value is a MIPS/ASM instruction, which is part of a function responsible of rendering split screen Multiplayer
//          
//          InitialValue = 0x882D
//          HackValue = 0x24110001
// $2CD9F4: [PAL][AssemblyInstruction:SplitScreenImageRender |32-bit]
//          @Widescreen Hack (PAL) - Image Render SplitScreen Multiplayer
//          - This value is a MIPS/ASM instruction, which is part of a function responsible of rendering split screen Multiplayer
//          
//          InitialValue = 0x882D
//          HackValue = 0x24110001
// $36BB74: [NTSCU][AssemblyInstruction:SubtitleRendering |32-bit]
//          @Widescreen Hack (NTSC-U) - Subtitles
//          - This value is a MIPS/ASM instruction, it's part of a function which helps with rendering subtitles
//          
//          InitialValue = 0x240300B4
//          HackValue = 0x24030000
// $36C024: [PAL][AssemblyInstruction:SubtitleRendering |32-bit]
//          @Widescreen Hack (PAL) - Subtitles
//          - This value is a MIPS/ASM instruction, it's part of a function which helps with rendering subtitles
//          
//          InitialValue = 0x240300B4
//          HackValue = 0x24030000
// $3C5218: [NTSCU][AssemblyInstruction:FMVrendering_A |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4410004
//          HackValue = 0x3C0143FE
// $3C522C: [NTSCU][AssemblyInstruction:FMVrendering_B |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xAFA00044
//          HackValue = 0x0
// $3C5230: [NTSCU][AssemblyInstruction:FMVrendering_C |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0x46800860
//          HackValue = 0x44810800
// $3C5234: [NTSCU][AssemblyInstruction:FMVrendering_D |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xAFA000C4
//          HackValue = 0xE7A10104
// $3C5248: [NTSCU][AssemblyInstruction:FMVrendering_E |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A10104
//          HackValue = 0xC4600000
// $3C524C: [NTSCU][AssemblyInstruction:FMVrendering_F |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A00088
// $3C5254: [NTSCU][AssemblyInstruction:FMVrendering_G |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A000C8
// $3C5258: [NTSCU][AssemblyInstruction:FMVrendering_H |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A00088
//          HackValue = 0x3C01C270
// $3C525C: [NTSCU][AssemblyInstruction:FMVrendering_I |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0x44810800
// $3C5260: [NTSCU][AssemblyInstruction:FMVrendering_J |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A000C8
//          HackValue = 0xE7A10044
// $3C5264: [NTSCU][AssemblyInstruction:FMVrendering_K |32-bit]
//          @Widescreen Hack (NTSC-U) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A100C4
// $3C5908: [PAL][AssemblyInstruction:FMVrendering_A |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4410004
//          HackValue = 0x3C0143FE
// $3C591C: [PAL][AssemblyInstruction:FMVrendering_B |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xAFA00044
//          HackValue = 0x0
// $3C5920: [PAL][AssemblyInstruction:FMVrendering_C |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0x46800860
//          HackValue = 0x44810800
// $3C5924: [PAL][AssemblyInstruction:FMVrendering_D |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xAFA000C4
//          HackValue = 0xE7A10104
// $3C5938: [PAL][AssemblyInstruction:FMVrendering_E |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A10104
//          HackValue = 0xC4600000
// $3C593C: [PAL][AssemblyInstruction:FMVrendering_F |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A00088
// $3C5944: [PAL][AssemblyInstruction:FMVrendering_G |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A000C8
// $3C5948: [PAL][AssemblyInstruction:FMVrendering_H |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A00088
//          HackValue = 0x3C01C270
// $3C594C: [PAL][AssemblyInstruction:FMVrendering_I |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0x44810800
// $3C5950: [PAL][AssemblyInstruction:FMVrendering_J |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xE7A000C8
//          HackValue = 0xE7A10044
// $3C5954: [PAL][AssemblyInstruction:FMVrendering_K |32-bit]
//          @Widescreen Hack (PAL) - FMV
//          - This value is a MIPS/ASM instruction, it's part of a function which is responsible for rendering Full Motion Video's (FMV)
//          
//          InitialValue = 0xC4600000
//          HackValue = 0xE7A100C4
// $3DE3DC: [NTSCU][AssemblyInstruction:Cinematic_BlackBorders_A |32-bit]
//          @Widescreen Hack (NTSC-U) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $3DE4EC: [NTSCU][AssemblyInstruction:Cinematic_BlackBorders_B |32-bit]
//          @Widescreen Hack (NTSC-U) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $3DE508: [NTSCU][AssemblyInstruction:Cinematic_BlackBorders_C |32-bit]
//          @Widescreen Hack (NTSC-U) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $3DEACC: [PAL][AssemblyInstruction:Cinematic_BlackBorders_A |32-bit]
//          @Widescreen Hack (PAL) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $3DEBDC: [PAL][AssemblyInstruction:Cinematic_BlackBorders_B |32-bit]
//          @Widescreen Hack (PAL) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $3DEBF8: [PAL][AssemblyInstruction:Cinematic_BlackBorders_C |32-bit]
//          @Widescreen Hack (PAL) - Cutscenes BlackBorders (removed)
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the ScreenMaskEffect/BlackBorder size during cutscenes
//          
//          InitialValue = 0x3C023F80
//          HackValue = 0x3c020000
// $40DA28: [NTSCU][AssemblyInstruction:TextRenderWidth |32-bit]
//          @16:9 Widescreen Hack - Text Width
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the text render width
//          
//          InitialValue = 0x3C034420
//          HackValue = 0x3c034455
// $40E3C8: [PAL][AssemblyInstruction:TextRenderWidth |32-bit]
//          @16:9 Widescreen Hack - Text Width
//          - This value is a MIPS/ASM instruction, it's part of a function which determines the text render width
//          
//          InitialValue = 0x3C034420
//          HackValue = 0x3c034455
// $45AAA4: [NTSCU][AssemblyInstruction:MultiplayerResolution_A |32-bit]
//          @Widescreen Hack (NTSC-U) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x52C00
//          HackValue = 0x3C050000
// $45AAAC: [NTSCU][AssemblyInstruction:MultiplayerResolution_B |32-bit]
//          @Widescreen Hack (NTSC-U) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x63400
//          HackValue = 0x3C060050
// $45AAB4: [NTSCU][AssemblyInstruction:MultiplayerResolution_C |32-bit]
//          @Widescreen Hack (NTSC-U) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x73C00
//          HackValue = 0x3C070001
// $45AD74: [NTSCU][AssemblyInstruction:MultiplayerResolution_D |32-bit]
//          @Widescreen Hack (NTSC-U) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x94C00
//          HackValue = 0x3C090010
// $45B6A4: [PAL][AssemblyInstruction:MultiplayerResolution_A |32-bit]
//          @Widescreen Hack (PAL) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x52C00
//          HackValue = 0x3C050000
// $45B6AC: [PAL][AssemblyInstruction:MultiplayerResolution_B |32-bit]
//          @Widescreen Hack (PAL) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x63400
//          HackValue = 0x3C060050
// $45B6B4: [PAL][AssemblyInstruction:MultiplayerResolution_C |32-bit]
//          @Widescreen Hack (PAL) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x73C00
//          HackValue = 0x3C070001
// $45B974: [PAL][AssemblyInstruction:MultiplayerResolution_D |32-bit]
//          @Widescreen Hack (PAL) - 480p Resolution Multiplayer
//          - This value is an MIPS/ASM instruction of a function which determines the screen render resolution for Multiplayer
//          - The Multiplayer render resolution is 480p, which is a lower render resolution than SinglePlayer
//          
//          InitialValue = 0x94C00
//          HackValue = 0x3C090010
// $4F3308: [NTSCU][AssemblyInstruction:FPScontrol(indirect) |32-bit]
//          @60 FPS Hack (NTSC-U)
//          - This value is a MIPS/ASM instruction which is read from ROMaddress 0x05AA1008. This instruction is part of a function which writes to [Lower4:FPScontrol] at $0x71fa68
//          
//          InitialValue = 0x93A30000
//          HackValue = 0x24030001
// $4F45F8: [PAL][AssemblyInstruction:FPScontrol(indirect) |32-bit]
//          @60 FPS Hack (PAL)
//          - This value is a MIPS/ASM instruction which is read from ROMaddress 0x00E2E2F8. This instruction is part of a function which writes to [Lower4:FPScontrol] at $0x721368
//          
//          InitialValue = 0x93A30000
//          HackValue = 0x24030001
// $641770: [NTSCU][Float:SinglePlayerScreenRenderSize_A |32-bit]
//          @Widescreen Hack - Image Render SinglePlayer
//          - This value regulates the screen render size during SinglePlayer
//          
//          InitialValue = 1.0 (0x3f800000)
//          HackValue = 1.333333 (0x3faaaaaa)
// $641774: [NTSCU][Float:SinglePlayerScreenRenderSize_B |32-bit]
//          @Widescreen Hack - Image Render SinglePlayer
//          - This value regulates the screen render size during SinglePlayer
//          
//          InitialValue = 1.333333 (0x3FAAAAA8)
//          HackValue = 1.777778 (0x3FE38E38)
// $641930: [NTSCU][Float:SplitScreen_PlayerA_ScreenRenderSize_A |32-bit]
//          @Widescreen Hack (NTSC-U) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player A
//          
//          InitialValue = 1.4 (0x3FB33333)
//          HackValue = 2.666666 (0x402AAAAA)
// $641934: [NTSCU][Float:SplitScreen_PlayerA_ScreenRenderSize_B |32-bit]
//          @Widescreen Hack (NTSC-U) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player A
//          
//          InitialValue = 2.666667 (0x402AAAAB)
//          HackValue = 3.555555 (0x40638E38)
// $64194C: [NTSCU][Float:SplitScreen_PlayerB_ScreenRenderSize_A |32-bit]
//          @Widescreen Hack (NTSC-U) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player B
//          
//          InitialValue = 1.4 (0x3FB33333)
//          HackValue = 2.666666 (0x402AAAAA)
// $641950: [NTSCU][Float:SplitScreen_PlayerB_ScreenRenderSize_B |32-bit]
//          @Widescreen Hack (NTSC-U) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player B
//          
//          InitialValue = 2.666667 (0x402AAAAB)
//          HackValue = 3.555555 (0x40638E38)
// $6429F0: [PAL][Float:SinglePlayerScreenRenderSize_A |32-bit]
//          @Widescreen Hack - Image Render SinglePlayer
//          - This value regulates the screen render size during SinglePlayer
//          
//          InitialValue = 1.0 (0x3f800000)
//          HackValue = 1.333333 (0x3faaaaaa)
// $6429F4: [PAL][Float:SinglePlayerScreenRenderSize_B |32-bit]
//          @Widescreen Hack - Image Render SinglePlayer
//          - This value regulates the screen render size during SinglePlayer
//          
//          InitialValue = 1.333333 (0x3FAAAAA8)
//          HackValue = 1.777778 (0x3FE38E38)
// $642BB0: [PAL][Float:SplitScreen_PlayerA_ScreenRenderSize_A |32-bit]
//          @Widescreen Hack (PAL) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player A
//          
//          InitialValue = 1.4 (0x3FB33333)
//          HackValue = 2.666666 (0x402AAAAB)
// $642BB4: [PAL][Float:SplitScreen_PlayerA_ScreenRenderSize_B |32-bit]
//          @Widescreen Hack (PAL) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player A
//          
//          InitialValue = 2.666667 (0x402AAAAB)
//          HackValue = 3.555555 (0x40638E38)
// $642BCC: [PAL][Float:SplitScreen_PlayerB_ScreenRenderSize_A |32-bit]
//          @Widescreen Hack (PAL) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player B
//          
//          InitialValue = 1.4 (0x3FB33333)
//          HackValue = 2.666666 (0x402AAAAB)
// $642BD0: [PAL][Float:SplitScreen_PlayerB_ScreenRenderSize_B |32-bit]
//          @Widescreen Hack (PAL) - Image Render SplitScreen Multiplayer
//          - This value regulates the screen render size during 2 Player Multiplayer for Player B
//          
//          InitialValue = 2.666667 (0x402AAAAB)
//          HackValue = 3.555555 (0x40638E38)
// $65CA78: [NTSCU][Float:Cinematic_BlackBorderSize |32-bit]
//          @Widescreen Hack (NTSC-U) - Cutscenes BlackBorders (removed)
//          - This float determines the size of the black border during a Cinematic (in-engine cutscene)
//          
//          InitialValue = 1.0 (0x3f800000)
//          HackValue = 0.0 (0x0)
// $65DFC8: [PAL][Float:Cinematic_BlackBorderSize |32-bit]
//          @Widescreen Hack (PAL) - Cutscenes BlackBorders (removed)
//          - This float determines the size of the black border during a Cinematic (in-engine cutscene)
//          
//          InitialValue = 1.0 (0x3f800000)
//          HackValue = 0.0 (0x0)
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
// $6C2C68: [NTSCU][Float:CinematicScreenRenderSize |32-bit]
//          @Widescreen Hack - Cinematics
//          - This value regulates the screen render size during Cinematics (in-engine cutscenes)
//          
//          InitialValue = 1.333333 (0x3FAAAAAB)
//          HackValue = 1.777778 (0x3FE38E38)
// $6C4388: [PAL][Float:CinematicScreenRenderSize |32-bit]
//          @Widescreen Hack - Cinematics
//          - This value regulates the screen render size during Cinematics (in-engine cutscenes)
//          
//          InitialValue = 1.333333 (0x3FAAAAAB)
//          HackValue = 1.777778 (0x3FE38E38)
// $71FA68: [NTSCU][Lower4:FPScontrol |32-bit]
//          @60 FPS Hack (NTSC-U)
//          - Refer to [AssemblyInstruction:FPScontrol(indirect)] at $0x4F3308
//          
//          InitialValue = 0x0 => 30 fps
//          HackValue = 0x1 => 60 fps
// $71FF88: [8-bit] in gameplay flag
// $721368: [PAL][Lower4:FPScontrol |32-bit]
//          @60 FPS Hack (PAL)
//          - Refer to [AssemblyInstruction:FPScontrol(indirect)] at $0x4F45F8
//          
//          InitialValue = 0x2 => 25 fps
//          HackValue = 0x1 => 50 fps (0x0 can also be used)
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
// $721820: [PAL][32-bit (base) Pointer:LevelID(preferred)]
//          - This pointer points to ASCII data of the current loaded level. Each ASCII value listed here, substrings/returns different parts of the full LevelID
//          
//          +0x18 - [32-bit (layer-1) Pointer:]
//          .+0x0 - [32-bit (layer-2) Pointer]
//          ..+0x2 - [Variable Size ASCII:StoryChapterSectionID(false)]
//          ..| - Prefer using [ASCII:StoryChapterSectionID(preferred)] below
//          ..| - This always points to StoryChapterSectionID "A" (eg. "WrongTrain_A" or "M03_A"), regardless of the current StoryChapterSectionID.
//          
//          +0x1C - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:DirectoryTreeToLevel]
//          .| - This ASCII pretty much lists the folder structure to the current Chapter (eg. "Levels/SinglePlayer/WrongTrain" or "Levels/SinglePlayer/M02_CanyonShoot")
//          
//          +0x20 - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:LevelID(full)]
//          .| - LevelIDs listed below
//          .| - This ID stays the same for a whole StoryChapter level, regardless of the current StoryChapterSection
//          .| - Multiplayer Versus maps/levels always start with "DM_"
//          
//          +0x24 - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:StoryChapterSectionID(preferred)]
//          ..| - Some StoryChapters are split up into multiple sections, refer to StoryChapterSectionIDs listed below
//          ..| - Multiplayer Versus map LevelIDs are listed here without "DM_" (eg. "DM_Asylum" --> "Asylum")
//          
//          
//          # LevelIDs (string)
//          |(list incomplete)
//          |'''''''''''''
//          |---StoryChapters---
//          | "WrongTrain" => Chapter 1, "Wrong Train" (YES, it's not "M01_WrongTrain")
//          | "M02_CanyonShoot => Chapter 2, "Ride Like The Devil"
//          | "M03_Cemetery => Chapter 3, "Boneyard"
//          | "M05_DevilsBelly" => Chapter 4, "Devil's Belly Mine" (YES, it is "M05". Supposedly M04 is cut content)
//          | TBD => Chapter 5, "Darkwatch Outpost"
//          | TBD => Chapter 6, "War Train"
//          | TBD => Chapter 7, "Torture Maze"
//          | TBD => Chapter 8, "Baptism of Fire
//          | TBD => Chapter 9, "Citadel"
//          | TBD => Chapter 10, "Rescue"
//          | TBD => Chapter 11, "The Deadlight Prism"
//          | TBD => Chapter 12, "Invasion"
//          | TBD => Chapter 13, "Hangtown"
//          | TBD => Chapter 14, "The Morning After"
//          | TBD => Chapter 15, "The Price of Passion"
//          | TBD => Chapter 16, "Showdown"
//          | TBD => Chapter 17, "The Right Train"
//          | TBD => Chapter 18, "Deadfall"
//          | TBD => Chapter 19, "Curse of The West"
//          |
//          |---VersusMaps---
//          | "DM_Asylum" => Asylum
//          | "DM_DeathDealer" => Death Dealer
//          | "DM_DeathDealerDay" => Death Dealer Day
//          | "DM_DevilsBelly" => Devil's Belly Mine
//          | "DM_DonnerPass" => Donner Pass
//          | "DM_DonnerPassDay" => Donner Pass Day
//          | "DM_HangTownEast" => Hangtown East
//          | "DM_HangTownEastDay" => Hangtown East Day
//          | "DM_HangTownWest" => Hangtown West
//          | "DM_HangTownWestDay" => Hangtown West Day
//          | "DM_HellHole" => Hellhole
//          | "DM_TradeCenter" => Trade Center
//          | "DM_TradeCenterDay" => Trade Center Day
//          '
//          
//          # StoryChapterSectionIDs (string)
//          |(list incomplete)
//          |'''''''''''''
//          |---Chapter 1, "Wrong Train"---
//          | "WrongTrain_A" => Section 1 - inside the train
//          | "WrongTrain_B" => Section 2 - on top of the train, after blowing up the vault
//          |---Chapter 2, "Ride Like The Devil"---
//          | // (only consists of a single section)
//          |---Chapter 3, "Boneyard"---
//          | "M03_C" => Section 1 - outside the church
//          | "M03_B" => Section 2 - inside the church catacombs
//          | "M03_A" => Section 3 - after the catacombs
//          | ...
//          |---Chapter 4, "Devil's Belly Mine"---
//          | ...
//          |---Chapter 5, "Darkwatch Outpost"---
//          | ...
//          |---Chapter 6, "War Train"---
//          | ...
//          |---Chapter 7, "Torture Maze"---
//          | ...
//          |---Chapter 8, "Baptism of Fire"---
//          | ...
//          |---Chapter 9, "Citadel"---
//          | ...
//          |---Chapter 10, "Rescue"---
//          | ...
//          |---Chapter 11, "The Deadlight Prism"---
//          | ...
//          |---Chapter 12, "Invasion"---
//          | ...
//          |---Chapter 13, "Hangtown"---
//          | ...
//          |---Chapter 14, "The Morning After"---
//          | ...
//          |---Chapter 15, "The Price of Passion"---
//          | ...
//          |---Chapter 16, "Showdown"---
//          | ...
//          |---Chapter 17, "The Right Train"---
//          | ...
//          |---Chapter 18, "Deadfall"---
//          | ...
//          |---Chapter 19, "Curse of The West"---
//          | ...
//          '
// $7218D0: [PAL][32-bit Flag:IsInGame(alt)]
//          - Prefer using [32-bit Flag:IsInGame(preferred)] at $0x72252c
//          - This is actually a [32-bit Pointer] which is only functional when in-game, otherwise it's zeroed out (0x0)
//          32bitValue > 0 => In-game (SinglePlayer and Mulltiplayer all modes)
//          32bitValue == 0 => Not in-game (MainMenu and booting game)
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
// $722528: [PAL][32-bit Flag:IsInGame(alt)]
//          - Prefer using [32-bit Flag:IsInGame(preferred)] at $0x72252c
//          - This is actually a [32-bit Pointer] which is only functional when in-game, otherwise it's zeroed out (0x0)
//          32bitValue > 0 => In-game (SinglePlayer and Mulltiplayer all modes)
//          32bitValue == 0 => Not in-game (MainMenu and booting game)
// $72252C: [PAL][32-bit Flag:IsInGame(preferred)]
//          0x14 => In-game (SinglePlayer and Mulltiplayer all modes)
//          0x0 => Not in-game (MainMenu and booting game)
// $722530: [PAL][32-bit Flag:IsInGame(alt)]
//          - Prefer using [32-bit Flag:IsInGame(preferred)] at $0x72252c
//          0x65 => In-game (SinglePlayer and Mulltiplayer all modes)
//          0x0 => Not in-game (MainMenu and booting game)
// $722540: in game?
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
// $73B410: [PAL][32-bit:TimerControl(functional)]
//          - Time in milliseconds (1sec = 1,000ms)
//          - This value directly regulates the timer in a Multiplayer Verus Match. Be wary, this value does not start/restart from a default value (0x0) on the start of the Verus Mode timer.
//          - To determine the effective time left in a match, rather use [32-bit:TimeSpentInChapter] (refer to $0x74d78c), which always starts counting from 0x0.
//          - OR use [32-bit:MatchDuration] (refer to $0x9114e0), with following formula:
//          --| currentTime = [32-bit:TimerControl(functional)]
//          --| timeAtMatchEnd = [32-bit:TimerControl(functional)] + ([32-bit:MatchDuration] * 60 * 1,000)
//          --| timeLeftInMatch =  timeAtMatchEnd - currentTime
// $73B414: timer
// $73B430: [PAL][8-bit:GameState |32-bit]
//          - 0x0 => Player is in control of PlayerCharacter. Also 0x0 when in MainMenu
//          - 0x1 => MainLoadingMenu is active, stays 0x1 for the duration of the first in-engine cutscene after exiting the MainLoadingMenu, becomes 0x0 once the player can control the PlayerCharacter.
//          - 0x3 => Any InGameMenu is active. (eg. PauseMenu and submenus, menus for saving to the memory card, LoreMenus not necessarily opened via the PauseMenu) (Manually editing this value to 0x3 freezes the game until changed)
// $73DCD0: [PAL][bit0 BitFlag:IsCinematicActiveStateTransitioning |32-bit]
//          - 1 => whenever a cinematic is ending or starting (transition period)
//          - 0 => when any cinematic is fully active and and not active
// $73DCD8: [PAL][bit0 BitFlag:IsFMVactive |32-bit]
//          - Full Motion Video is a pre-rendered cutscene
// $73DCE8: [PAL][bit0 BitFlag:IsCinematicActive |32-bit]
//          - The game sometimes refers to "Minimatic" as an in-engine cutscene
//          - Data near this memRegion, may be used by logic for Minimatics and FMVs
// $73DD40: (unverified)
//          [PAL][32-bit:CinematicID(unverified)]
//          - To ID an in-engine cinematic, but this is not always consistent when restarting a chapter or when using checkpoints
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
//          | - Documentation on StructMembers refer torespective code notes, since this struct is static
//          | - StructMembers are used for all modes: SinglePlayer, Multiplayer Coop and Versus
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
//          |+0xF4 - [8-bit:InProgress_StoryChapterID |16-bit]
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
// $77C7D0: something?? active stuff??
//          
//          Index to start of this stuff!!!
// $8075AC: [PAL][32-bit (base) Pointer:HUDcontrol_Gear(alt)]
//          - Prefer using [Pointer:HUDcontrol_Gear(preferred)] at $0x7238b8
// $80783C: [PAL][32-bit:Checkpoint_RespawnPointID(alt)]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          - Prefer using [32-bit:Checkpoint_RespawnPointID(preferred)] at $0x9114b4
// $807840: [PAL][32-bit (base) Pointer:CheckpointData_1] -> [Struct:CheckpointData]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          
//          +0x2 - [13-byte ASCII:CheckpointID]
//          | - Documentation at $0x96d022
// $8FEAEC: [32-bit] Blood frenzy ability flag
// $8FFAC8: [8-bit] main menu selection
// $911430: [PAL][32-bit (base) Pointer:LevelID(alt)]
//          +0x2 - [Variable Size ASCII:LevelID(alt)]
//          | - Prefer using [Pointer:LevelID(preferred)] at $0x721820
// $911444: [PAL][Lower4:DifficultyID(alt1) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $91145C: [PAL][Lower4:DifficultyID(alt2) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $9114B4: (unverified - if the hexadecimal IDs are consistent)
//          [PAL][32-bit:Checkpoint_RespawnPointID(preferred)]
//          - String CheckpointIDs accessed via [Pointer:CheckpointData_1] at $0x807840
//          - RespawnPointIDs listed below
//          
//          # RespawnPointIDs (hex) - CheckpointIDs (string)
//          |(list incomplete) (StoryChapterSectionIDs listed at $0x721820)
//          |''''''''''''''''''''''''
//          | 0x0 => No checkpoint reached/initialized
//          |
//          |===Chapter 1, "The Wrong Train"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 2, "Ride Like The Devil"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 3, "Boneyard"===
//          | ---StoryChapterSection "M03_C"---
//          | 0x328 - "Checkpoint_1" => At start of Chapter
//          | 0x3DF - "Checkpoint_2" => Before Mark of Evil spawns near the church
//          | ---StoryChapterSection "M03_B"---
//          | 0x344 - "Checkpoint_1" => Start of catacombs
//          | 0x342 - "Checkpoint_2" => Entering catacombs arena
//          | 0x362 - "Checkpoint_3" => Catacombs arena, after Banshee intro
//          | 0x362 - "Checkpoint_4" => Catacombs arena, after defeating the Banshees
//          | ---StoryChapterSection "M03_A"---
//          | ??? - "Checkpoint_1" =>
//          | 0x2BC - "Checkpoint_2" => After Good/Evil choice
//          | ...
//          |===Chapter 4, "Devil's Belly Mine"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 5, "Darkwatch Outpost"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 6, "War Train"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 7, "Torture Maze"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 8, "Baptism of Fire"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 9, "Citadel"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 10, "Rescue"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 11, "The Deadlight Prism"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 12, "Invasion"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 13, "Hangtown"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 14, "The Morning After"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 15, "The Price of Passion"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 16, "Showdown"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 17, "The Right Train"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 18, "Deadfall"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          |===Chapter 19, "Curse of The West"===
//          | ---StoryChapterSection "xxxxx"---
//          | ...
//          '
// $9114B8: [PAL][32-bit (base) Pointer:CheckpointData_0]
//          - This pointer points to a memRegion with static data (fixed memory location)
//          
//          +0xC - [32-bit:Checkpoint_RespawnPointID(alt)]
//          | - Identical to [32-bit:Checkpoint_RespawnPointID(preferred)] at $0x9114b4
//          
//          +0x10 - [32-bit (layer-1) Pointer:CheckpointData_1]
//          | - Prefer using this pointer as a base pointer, as this is a static memRegion
// $9114E0: [PAL][32-bit (base) Pointer:VersusMode_TimeSetting]
//          - This pointer is only functional during a Multiplayer Versus Match
//          
//          +0x8 - [32-bit:MatchDuration(functional]
//          | - Time in minutes (eg. 0x5 = 5 minutes, 0x7 => 7 minutes...)
//          | - 0x0 => No Time limit
//          | - This value determines the total amount of minutes the match lasts. Changing this value during a match, will update the timer display accordingly (eg. Time set to 10 (0xA) minutes  --> manual change this value 7 (0x7) --> Timer display updates)
// $911508: [32-bit:MatchDuration(alt)]
//          - Identical to [32-bit:MatchDuration(functional] at $0x9114e0
// $911768: 8-bit which pointer is used for the current HUD
//          This value x 0x4
// $911898: [PAL][32-bit (base) Pointer:MessageBoxData]
//          @Fixed Memory Location, although pointed to by $0x7238b8
//          - MessageBox is an in-game popup/submenu (for Lore/hints or the PowersMenu)
//          - This pointer is only valid for these specific in-game popups
//          
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x4 - [32-bit (layer-2) Pointer]
//          ..+0x30 - [32-bit (layer-3) Pointer]
//          ...+0x2 - [Variable Size ASCII:MainLineText]
//          ...| - This is the literal text which is displayed on the MessageBox
//          ...| - This ASCII is language dependent
//          
//          +0x30 - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:MessageBoxType]
//          .| "MessageBox" => Default MessageBox
//          .| "brands" => PowersMenu
//          .| ...??
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
//          | 0x0 => BasicRevolver
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
//          ...+0xC - [32-bit (layer-4) Pointer:EntityComponentData_Dynamite] -> [Struct:EntityComponentData.WeaponComponent(throwable)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(throwable)] below
//          ...
//          ...+0x2C - [32-bit (layer-4) Pointer:EntityComponentData_Crossbow] -> [Struct:EntityComponentData.WeaponComponent(weapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid when wielding the Crossbow
//          ...
//          ...+0x34 - [32-bit (layer-4) Pointer:EntityComponentData_BaiscPistol] -> [Struct:EntityComponentData.WeaponComponent(weapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid for Chapter 1, when the player only has the BasicPistol equipped
//          ...| - Once the player has the RedeemerRevolver, refer to [Pointer:EntityComponentData_NormalWeapon(1)]
//          ...
//          ...+0x3C - [32-bit (layer-4) Pointer:EntityComponentData_NormalWeapon(noDynamite)] -> [Struct:EntityComponentData.WeaponComponent(weapon)]
//          ...| - The [32-bit:DictionaryKey] for this [Dictionary:EntityWeaponComponents].[Struct:ListItem_EntityComponent] = 0x2F
//          ...| - Definition of [Struct:EntityComponentData.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid when the player has not unlocked dynamite yet, thus should only be used up to Chapter 3, where the player first unlocks dynamite
//          ...| - Once the player has unlocked dynamite, refer to [Pointer:EntityComponentData_NormalWeapon(2)]
//          .
//          .+0xC - [32-bit (layer-2) Pointer]
//          ..+0x0 - [32-bit (layer-3) Pointer]
//          ...+0x58 - [32-bit (layer-4) Pointer]
//          ....+0x34 - [32-bit (layer-5) Pointer:EntityComponentData_MultiplayerNormalWeapon] -> [Struct:EntityComponentData.WeaponComponent(weapon)]
//          ....| - This pointer chain is only valid in Multiplayer Versus Mode and only for a few select weapons
//          ....
//          ....+0x3C - [32-bit (layer-5) Pointer:EntityComponentData_NormalWeapon(dynamiteUnlocked)] -> [Struct:EntityComponentData.WeaponComponent(weapon)]
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
//          |
//          |+0xFC - [Float:BloodPowerGauge(functional) |32-bit]
//          || - FloatRange: [0.0 --- 30.0]; 30.0 = maxBloodPower; 0.0 = empty
//          || - Increments when picking up BloodClouds
//          || - When at 30.0, the player can activate a Power, returning this value back to 0.0
//          || - Reference |[Float:BloodPowerGauge(display)] at $0x965d2c
//          '
//          
//          [Definition Struct:EntityComponentData.WeaponComponent(weapon) |??-byte]
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
//          [Definition Struct:EntityComponentData.WeaponComponent(throwable) |??-byte]
//          |''''''''''''''''''''''''''''''
//          | - This struct contains data which regulates the throwable dynamite bundles
//          |
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "WeaponComponent"
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |.+x2 - [Variable Size ASCII:WeaponNameID]
//          |.| - WeaponNameIDs listed below
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
//          |---Weapons---
//          | "BasicPistol" => BasicRevolver
//          | "Revolver" => RedeemerRevolver
//          | "Rifle" => CarbineRifle
//          | "Shotgun" => Shotgun
//          | "Crossbow" => ExplosiveCrossbow
//          | ...
//          |---Throwables---
//          | "Dynamite"
//          | "SplitterGrenades"
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
// $965CF8: [PAL][8-bit:InProgress_StoryChapterID |16-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Current Chapter marked as "in-progress" OR the currently active Chapter
//          - Identification is also possible via [Pointer:LevelID(preferred)] at $0x721820
//          - This value also regulates which powers are unlocked (at MainMenu->StatsMenu)
//          - This also unlocks movies at MainMenu->Extras->Movies, depending on which Chapter is currently ID'd here
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
// $965D00: [PAL][bit0 BitFlag:IsStoryGoodEndingAchieved |8-bit]
//          - This also unlocks all movies at MainMenu->Extras->Movies (including "Devil" and "Hero", only unlockable with a Good playthrough)
// $965D01: [PAL][bit0 BitFlag:IsStoryEvilEndingAchieved |8-bit]
//          - This also unlocks all movies at MainMenu->Extras->Movies (including "Angel" and "Monster", only unlockable with an Evil playthrough)
// $965D04: [PAL][32-bit:SelectedPlayerProfileID]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Max allowed PlayerProfiles is 10
//          0xFFFFFFFF => on game boot, until a PlayerProfile is selected; Also when playing Multiplayer
//          [0x0-0x9] => PlayerProfile-1 up to PlayerProfile-10; only when playing SinglePlayer
// $965D08: [PAL][32-bit (base) Pointer:SelectedPlayerProfileName(alt2)]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          +0x2 - [Variable Size ASCII:SelectedPlayerProfileName]
//          | - Identical [ASCII:SelectedPlayerProfileName] at $0x728fa0, accessible without a pointer
// $965D0C: [PAL][bit0 BitFlag:ConceptArtUnlocks(hack) |32-bit]
//          - This unlocks Concept Art in MainMenu->Extras->ConceptArt ("Evolution of Jericho" + "Darkwatch Archives")
//          - This is probably not the intended way of unlocking these
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
//          ..
//          ..
//          ..+0xF8 - [32-bit (layer-3) Pointer] -> Blood Power Gauge
//          ...+0xEC - [Float:BloodPowerGauge(display) |32-bit]
//          ...| - FloatRange: [1.0 --- 0.0]; 1.0 = maxBloodPower; 0.0 = empty
//          ...| - Reference [Float:BloodPowerGauge(functional)] $0x965cc4
//          ..
//          ..
//          ..+0x100 - [32-bit (layer-3) Pointer] -> Power Fill Data
//          ...+0x75 - [Struct(RGBhex):PowerUsageFillColor |24-bit]
//          ...| - This value represents to color which is used in the display of the Blood Power duration time left circle color.
//          ...| - Definition of [Struct:RGBhex] below
//          ...| - Practically this can be used to identify if an Evil Power or Good Power was used
//          ...| 0xC4988D => Red color, Evil Power
//          ...| 0x1919D1 => Blue color, Good Power
//          ...
//          ...+0xE8 - [Float:HealthUI_BloodPowerTimeLeft(display)(alt2) |32-bit]
//          ...| - FloatRange [1.0 --- 0.0]; 1.0 => Power time start; 0.0 => Power over
//          ...
//          ...+0xF0 - [Lower4:PowerDurationBarsLeft(display) |32-bit]
//          ...| - This value regulates how many BloodPowerDurationBars are displayed. It does not directly control the duration of the BloodPower.
//          ...| - HealthUI can display 8 PowerDurationBars in total.
//          ...| - When the BloodPower starts, this value starts a 0x7 (= 8 bars), this decrements by 1 each ... milliseconds. At 0x0 there is still 1 more bar displayed.
//          .
//          .
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
//          .
//          .
//          .
//          .+0x10 - [32-bit (layer-2) Pointer] -> [Struct:HUDcontrol_PowerSelectionUI |??-byte]
//          ..+0xC4 - [Float:PowerSelectionUI_Opacity |32-bit]
//          ...| - FloatRange [1.0 --- 0.0]; 1.0 => Fully visible; 0.0 => Invisible/hidden
//          ...| - The PowerSelectionUI is dynamically displayed and hidden during gameplay
//          ..+0xE8 - [32-bit (layer-3) Pointer]
//          ..| - Changing this pointer so it points to another BloodPowerID (string), will update the middle/selected power icon of the bottom-left HUD accordingly
//          ...+0x2 - [Variable Size ASCII:PowerSelectionUI_Selected_BloodPowerID(display)]
//          ...| - BloodPowerIDs listed below
//          ..+0xF0 - [32-bit (layer-3) Pointer]
//          ..| - Changing this pointer so it points to another BloodPowerID (string), will update the right power icon of the bottom-left HUD accordingly
//          ...+0x2 - [Variable Size ASCII:PowerSelectionUI_Right_BloodPowerID(display)]
//          ...| - BloodPowerIDs listed below
//          .
//          .
//          .+0x78 - [32-bit (layer-2) Pointer]
//          .| - Changing this pointer so it points to another BloodPowerID (string), will update the top-left HUD power icon accordingly
//          ..+0x2 - [Variable Size ASCII:HealthUI_Selected_BloodPowerID(display)]
//          ..| - BloodPowerIDs listed below
//          .
//          .
//          .+0x174 - [Float:HealthUI_BloodPowerTimeLeft(display)(alt1) |32-bit]
//          .| - FloatRange [1.0 --- 0.0]; 1.0 => Power time start; 0.0 => Power over
//          
//          [Definition Struct:RGBhex |24-bit]
//          |'''''''''''''''
//          |+0x0 - [8-bit:Red]
//          |+0x1 - [8-bit:Green]
//          |+0x2 - [8-bit:Blue]
//          '
//          
//          # BloodPowerIDs (string)
//          |'''''''''''''''''
//          |---Good Powers---
//          | "SilverBrandRune" => Silver Bullet
//          | "FearRune" => Fear
//          | "MysticArmourRune" => Mystic Armor
//          | "VindicatorRune" => Vindicator
//          |---Evil Powers---
//          | "BloodFrenzyRune" => Blood Frenzy
//          | "TurnRune" => Turn
//          | "BlackShroudRune" => Black Shroud
//          | "SoulStealerRune" => Soul Stealer
//          '
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
// $96D020: [PAL][500-byte?? Struct:CheckpointData]
//          ==============================
//          @Fixed Memory Location, although pointed to by [Pointer:CheckpointData_1] at $0x807840
//          - This struct is populated once a checkpoint has been reached.
//          - This struct contains data about which weapons the player has equipped as well as information about power/abilities
//          
//          [Definition Struct:CheckpointData]
//          |'''''''''''''''''
//          | - Documentation on StructMembers refer to respective code notes, since this struct is static
//          |
//          |+0x2 - [13-byte ASCII:CheckpointID]
//          '
// $96D022: [PAL][13-byte ASCII:CheckpointID]
//          @Member of [Struct:CheckpointData], refer to $0x96d020
//          - These IDs are unique on a StoryChapterSection basis (eg. Multiple StoryChapterSections have a checkpoint identified as "Checkpoint_1")
//          - CheckpointIDs listed at $0x9114b4
//          - Also refer to LevelIDs and StoryChapterSectionIDs
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
// $A66348: controls text to dispaly in msgBox
//          Changing this to a valid key will switch text in msgBox
//          Key of Dictionary entry
// $A6F0B4: [32-bit] final boss
//          3 = casside
//          4 = tala
// $AED58C: [32-bit] using ability flag
// $AED8EC: [32-bit] Soul reaver ability flag
// $AF80DC: [32-bit] evil ability flag
// $DCBBB0: CreateVersusMatchMenu_TimeSetting
// $F30A24: cutscene timer
// $F39608: minute setting vs mode
// $F54FB0: list of lpointers to runes
// $FAEE24: [PAL][32-bit (base) Pointer:PlayerInput(alt)]
//          - Prefer using [Pointer:PlayerInput(preferred)] at $0x721900
// $11D5D60: blocks of time left
// $1203834: F8 - functional FearRune
// $1203D30: F8- functional BlackShroudRune
// $120400C: F8 - functional TurnRune
// $1204284: F8- functional BloodFrenzyRune
// $120430C: F8 - functional timer duration Blood Frenzy
// $15C4A5C: [32-bit] current weapon reserve ammo
// $15C4A60: [32-bit] current weapon magazine ammo
// $15C4A68: [32-bit] dynamites
// $19FD7C0: active rune
// $1CC6F08: vamp jump flag
// $1FFF570: [Pointer chain]
//           
//           -+0xffffffac = pointer to the array of final boss
//           
//           --+98 = [float] final boss health
