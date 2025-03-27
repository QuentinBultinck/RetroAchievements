// Darkwatch
// #ID = 19111

// $134214: [PAL][NTSCU][32-bit (base) Pointer:SofdecStreamData(preferred)] -> [Struct:SofdecStreamData]
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr may be used by other game logic.
//          - "Sofdec" is a video codec which handles Full Motion Video (FMV) playback
//          - This pointer is only valid when an FMV is being played. When no FMV is active, may be used by other logic
//          
//          +0x12C - [12-byte ASCIIFlag:Sofdec_IsFMVactive]
//          | - "SofdecStream" => FMV is being played
//          | - anyOtherValue => FMV is NOT being played
//          
//          +0x14C - [6-byte ASCII:Sofdec_FMVID]
//          | - This is actually the SofdecStreamID (about 17-byte long), but the first 5-byte of this ID can be used to identify which FMV is being played
//          | - Sofdec_FMVIDs listed below
//          '
//          
//          # Sofdec_FMVIDs (string)
//          |(list incomplete)
//          |'''''''''''''''''''
//          | "DWATTR" => Demo video, which plays when idle at the Start/TitleMenu
//          | "PROLOG" => Intro video, which plays on game boot
//          | "PS2MAI" => Main Menu background (looping) video
//          |
//          |---Chapter 1, "The Wrong Train"---
//          | "M01S1_" => Start of Chapter: "The Wrong Train"
//          | "M01S2_" => Mid Chapter: "Lazarus Malkoth"
//          | "M01S4_" => End of Chapter: "Shadow"
//          |---Chapter 2, "Ride Like The Devil"---
//          | "M02S1_" => Start of Chapter: "Lazarus Lives"
//          |---Chapter 3, "Boneyard"---
//          | "M04S1_" => End of Chapter: "Cassidy Dies"
//          |---Chapter 4, "Devil's Belly Mine"---
//          | "M05S1_" => End of Chapter: "The Haunting"
//          |---Chapter 5, "Darkwatch Outpost"---
//          | "M07S1_" => Start of Chapter: "Outpost"
//          |---Chapter 6, "War Train"---
//          | //
//          |---Chapter 7, "Torture Maze"---
//          | "M08S1_" => Start of Chapter: "Darkwatch Citadel"
//          | "M09S2_" => Mid Chapter: "General Clay Cartwright"
//          | "M09S3_" => End of Chapter: "Giddy-up, Cowboy"
//          |---Chapter 8, "Baptism of Fire"---
//          | "M10S1_" => Start of Chapter: "Baptism of Fire"
//          |---Chapter "Citadel"---
//          | //
//          |---Chapter 9, "Rescue"---
//          | //
//          |---Chapter 10, "The Deadlight Prism"---
//          | //
//          |---Chapter 11, "Invasion"---
//          | //
//          |---Chapter 12, "Hangtown"---
//          | "M11S2_" => End of Chapter: "Prom Night"
//          |---Chapter 13, "The Morning After"---
//          | "M012S1" => Mid Chapter: "Lazarus Triumphant"
//          |---Chapter 14, "Showdown"---
//          | "M021S1" => Start of chapter: "Showdown"
//          |---Chapter 15, "The Right Train"---
//          | //
//          |---Chapter 16, "Deadfall"---
//          | //
//          |---Chapter 17, "Curse of The West"---
//          | "M22S1_" => Start of Chapter: "Angel" (Evil allegiance)
//          | "M22S4_" => End of Chapter: "Monster" (Evil Ending)
//          | "M22S2_" => Start of Chapter: "Devil" (Good allegiance)
//          | "M22S3_" => End of Chapter: "Hero" (Good Ending)
//          | "FINALD" => End of Story: End Credits
//          '
// $134218: [PAL][32-bit (base) Pointer:FMVdata] -> [Struct:FMVdata]
//          - This pointer is only functional when an FMV is being played. When no FMV is active, this memAddr may be used by other game logic.
//          - Definition of [Struct:FMVdata] at $0x6aae58
// $134408: [PAL][NTSCU][32-bit (base) Pointer:SofdecStreamData(alt)]
//          - "Sofdec" is a video codec which handles Full Motion Video (FMV) playback
//          - This pointer is only valid when an FMV is being played. When no FMV is active, may be used by other logic
//          - Prefer using [Pointer:SofdecStreamData(preferred)], which has the same offsets depending on PAL or NTSCU
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
//          @FPS Hack (NTSC-U)
//          - This value is a MIPS/ASM instruction which is read from ROMaddress 0x05AA1008. This instruction is part of a function which writes to [Lower4:FPScontrol] at $0x71fa68
//          
//          InitialValue = 0x93A30000
//          HackValue = 0x24030001
// $4F45F8: [PAL][AssemblyInstruction:FPScontrol(indirect) |32-bit]
//          @FPS Hack (PAL)
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
// $661CF5: [NTSCU][1-byte ASCII:Subset_MultiplayerCooperative]
//          InitialValue = 0x45
//          SubsetPatchValue = 0x65
// $6632B5: [PAL][1-byte ASCII:Subset_MultiplayerCooperative]
//          InitialValue = 0x45
//          SubsetPatchValue = 0x65
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
//          @FPS Hack (NTSC-U)
//          - Refer to [AssemblyInstruction:FPScontrol(indirect)] at $0x4F3308
//          
//          InitialValue = 0x2 => 30 fps
//          HackValue = 0x1 => 60 fps
// $71FAF0: [NTSCU][32-bit (base) Pointer:MainUIdata_A] -> [Struct:MainUIdata]
//          +0x510 - [32-bit:LoadingState]
//          | - Some values are different compared to PAL ($0x7213f0)
//          |
//          | 0x10000048 => Loading; Any type of loading (loading/saving memory card data, MainLoadingMenu, MedallionLoadingMenu)
//          | 0x8009 => Not Loading (at MainMenu, during FMVs)
//          | 0x8047 => Not Loading (when in-game)
//          '
// $71FAF4: [NTSCU][32-bit (base) Pointer:MainUIdata_B] -> [Struct:MainUIdata]
//          - This points to a 2nd [Struct:MainUIdata], which updates less frequent than the one pointed to by [Pointer:MainUIdata_A]
// $71FCCC: [NTSCU][10-byte ASCII:GameID]
//          "SLUS_210.42" => NTSC-U/USA PS2 Game ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - Succeeding [2-byte ASCII] = ";1"
// $71FCF0: [NTSCU][8-bit:AlwaysNULL |32-bit]
// $71FF20: [NTSCU][32-bit (base) Pointer:LevelID(preferred)]
//          @Regional equivalent of $0x721820 (PAL)
// $71FF88: [8-bit] in gameplay flag
// $720000: [NTSCU][32-bit (base) Pointer:PlayerInput(preferred)]
//          @Regional equivalent of $0x721900 (PAL)
// $721368: [PAL][Lower4:FPScontrol |32-bit]
//          @FPS Hack (PAL)
//          - Refer to [AssemblyInstruction:FPScontrol(indirect)] at $0x4F45F8
//          - The widescreen patch activates NTSCU mode (60Hz instead of 50 Hz), thus native 30 fps instead of 25 fps.
//          
//          - 30 FPS is achieved when using Widescreen RApatch
//          - 50 FPS is achieved when using only 50 fps RApatch
//          - 60 FPS is achieved when using both Widescreen & 60 fps RApatches
//          
//          InitialValue = 0x2 => 25 fps OR 30 fps (when using Widescreen NTSCU Mode RaPatch)
//          HackValue = 0x1 => 50 fps OR 60 fps (0x0 can also be used)
// $7213F0: [PAL][32-bit (base) Pointer:MainUIdata_A] -> [Struct:MainUIdata]
//          
//          +0x450 - [32-bit:LoadingState]
//          | - Some values are different compared to NTSCU ($0x71faf0)
//          |
//          | 0x1000003C => Loading; Any type of loading (loading/saving memory card data, MainLoadingMenu, MedallionLoadingMenu)
//          | 0x8009 => Not Loading (at MainMenu, during FMVs)
//          | 0x803B => Not Loading (when in-game)
//          '
// $7213F4: [PAL][32-bit (base) Pointer:MainUIdata_B] -> [Struct:MainUIdata]
//          - This points to a 2nd [Struct:MainUIdata], which updates less frequent than the one pointed to by [Pointer:MainUIdata_A]
// $7215CC: [PAL][10-byte ASCII:GameID]
//          "SLES_535.64" => PAL/EU PS2 Game ID
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - Succeeding [2-byte ASCII] = ";1"
// $7215F0: [PAL][8-bit:AlwaysNULL |32-bit]
// $721778: (unverified)
//          [PAL][32-bit (base) Pointer:VampireVision]
//          +0xA8 - [8-bit:VampireVisionState]
//          | - value > 0 => Vampire Vision is active
//          | - value == 0 => Vampire Vision is NOT active
// $721788: [PAL][32-bit (base) Pointer:EntityList]
//          
//          ------Simplified_Documentation------
//          (Example pointer chain to HP of PlayerEntityActor. Where the PlayerCharacterEntityActor [Array:Entities].index = 38 and HealthComponent [Dictionary:EntityComponents].index = 15)
//          
//          +0xC - [32-bit (layer-1) Pointer] -> [Array:Entities]
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
//          .+0x0 - [Variable Size Array:Entities] List of [Pointer:EntityData_A] -> [Pointer:EntityData_B] -> [Struct:EntityData]
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
//          |+0x58 - [32-bit (layer-2) Pointer:EntityComponentsDictionary] -> [Dictionary:EntityComponents]
//          |.| - Each ListItem in this dictionary consists of a [32-bit:DictionaryKey] + [32-bit Pointer:EntitycomponentData] -> [Struct:EntityComponentData]
//          |.| - Depending on the Entity, this dictionary has differing ListItems
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
//          - Each ASCII documented here is followed by [1-byte ASCII] = 0x00, noting the end of the string
//          
//          +0x18 - [32-bit (layer-1) Pointer]
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
//          | - This pointer changes values, when changing Level
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
//          |(list complete)
//          |'''''''''''''
//          |---StoryChapters---
//          | "WrongTrain" => Chapter 1, "Wrong Train" (YES, it's not "M01_WrongTrain")
//          | "M02_CanyonShoot" => Chapter 2, "Ride Like The Devil"
//          | "M03_Cemetery" => Chapter 3, "Boneyard"
//          | "M05_DevilsBelly" => Chapter 4, "Devil's Belly Mine" (YES, it is "M05". Supposedly M04 is cut content)
//          | "M07_DWOutpost" => Chapter 5, "Darkwatch Outpost"
//          | "Wartrain => Chapter 6, "War Train"
//          | "M09_TortureMaze" => Chapter 7, "Torture Maze"
//          | "M10_TradingPost" => Chapter 8, "Baptism of Fire
//          | "Citadel_Launch" => Chapter "Citadel"
//          | "M08_Regulator" => Chapter 9, "Rescue"
//          | "M15_SplittingPaths" => Chapter 10, "The Deadlight Prism"
//          | "M17_Invasion" => Chapter 11, "Invasion"
//          | "M11_Hangtown" => Chapter 12, "Hangtown"
//          | "M12_CitadelUnderAttack" => Chapter 13, "The Morning After"
//          | "FallOfCitadel" => Chapter 14, "Showdown"
//          | "M19_RidetoDeadfall" => Chapter 15, "The Right Train"
//          | "M20_PenetratingDeadfall" => Chapter 16, "Deadfall"
//          | "GroundZero" => Chapter 17, "Curse of The West"
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
//          |(list complete)
//          |'''''''''''''
//          |---Chapter 1, "Wrong Train"---
//          | "WrongTrain_A" => Section 1 - Inside the train
//          | "WrongTrain_B" => Section 2 - Top of the train, after blowing up the vault
//          |---Chapter 2, "Ride Like The Devil"---
//          | "Hub_A" => Section 1 - Fight/escape on horseback
//          |---Chapter 3, "Boneyard"---
//          | "M03_C" => Section 1 - Front of the church
//          | "M03_B" => Section 2 - Inside the church catacombs
//          | "M03_A" => Section 3 - Outside the catacombs
//          |---Chapter 4, "Devil's Belly Mine"---
//          | "Hub_A" => Section 1 - Mine zone 1, mine entrance
//          | "Hub_B" => Section 2 - Mine zone 2, deeper in mine
//          | "Hub_C" => Section 3 - Mine zone 3, blow up reinforced door
//          | "Hub_D" => Section 4 - Mine zone 4, even deeper in mine
//          |---Chapter 5, "Darkwatch Outpost"---
//          | "M07_A" => Section 1 - Outpost
//          | "M07_B" => Section 2 - Frozen Lab
//          |---Chapter 6, "War Train"---
//          | "M07_C" => Section 1 - Travel to Darkwatch Citadel on horseback
//          |---Chapter 7, "Torture Maze"---
//          | "M09_A" => Section 1 - Arena 1, Melee only
//          | "M09_B" => Section 2 - Arena 2
//          | "M09_C" => Section 3 - Arena 3, Steamy
//          | "M09_D" => Section 4 - Sewers
//          | "M09_E" => Section 5 - Arena 4
//          | "M09_F" => Section 6 - Arena 4, with sunlight (FMV Cartwright)
//          |---Chapter 8, "Baptism of Fire"---
//          | "M10_A" => Section 1 - Road to Trading Post, Mine Valley zone 1
//          | "M10_B" => Section 2 - Road to Trading Post, Mine Valley zone 2
//          | "M10_C" => Section 3 - Civilian Trading Post zone 1
//          | "M10_D" => Section 4 - Civilian Trading Post zone 2
//          |---Chapter "Citadel"---
//          | "Citadel_Launch_AA" => Section 1 - Citadel Hub Area
//          |---Chapter 9, "Rescue"---
//          | "Hub_A" => Section 1 - Coyote Drive section
//          | "Hub_B" => Section 2 - Regulator Defence
//          |---Chapter 10, "The Deadlight Prism"---
//          | "M15_D" => Section 1 - Battlefield in sunlight
//          | "M15_E" => Section 2 - Long Range Battlefield in sunlight
//          | "M15_F" => Section 3 - Path through canyons
//          | "M15_A" => Section 4 - Path though canyon valley
//          | "M15_C" => Section 5 - Deadlight Prism Defence
//          |---Chapter 11, "Invasion"---
//          | "M17_B" => Section 1 - Native Caves
//          | "M17_C" => Section 2 - Native Village
//          | "M17_D" => Section 3 - Native Villager Defence
//          |---Chapter 12, "Hangtown"---
//          | "M11_F" => Section 1 - Hangtown Entrance
//          | "M11_G" => Section 2 - Hangtown Saloon Defence
//          | "M11_H" => Section 3 - Hangtown Church
//          |---Chapter 13, "The Morning After"---
//          | "M12_AA" => Section 1 - Citadel Hub Area Under Attack
//          | "M12_B" => Section 2 - Citadel Cave Area
//          | "M12_C" => Section 3 - Citadel Area 2
//          | "M12_D" => Section 4 - Citadal Reactor Area
//          | "M12_A" => Section 5 - Citadel Deadlight Prism Area
//          |---Chapter 14, "Showdown"---
//          | "FallOfCitadel_A" => Section 1 - Boss Fight vs Big Lazarus
//          | "FallOfCitadel_B" => Section 2 - MoralChoice
//          |---Chapter 15, "The Right Train"---
//          | "M19_A" => Section 1 - Train
//          |---Chapter 16, "Deadfall"---
//          | "Hub_A" => Section 1 - Entering Deadfall
//          | "Hub_B" => Sectopn 2 - Deafall Streets part 1
//          | "Hub_B2" => Section 3 - Deadfall Streets part 2
//          | "Hub_C" => section 4 - Deadfall Apartments
//          | "Hub_C2" => Section 5 - Deadfall Lava Filled Streets
//          |---Chapter 17, "Curse of The West"---
//          | "GroundZero_A" => Section 1 - Boss Fight
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
//          [32-bit (base) Pointer:PlayerInput(preferred)]
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
//          [32-bit (base) Pointer:PlayerInput(preferred)]
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
// $721FB8: [NTSCU][32-bit (base) Pointer:UIcontrol(preferred)]
//          @Regional equivalent of $0x7238b8 (PAL)
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
// $7230C8: [32-bit (base) Pointer:ActiveLuaScripts]
//          +0x14 - [16-bit:ActiveLuaScriptCount]
//          | - This is the same amount of "active" ListItems in [Array:LuaScriptPointers], below
//          
//          +0x18 - [32-bit (layer-1) Pointer] -> [Variable Size Array:LuaScriptPointers]
//          | - List of [32-bit (layer-2) Pointer] -> [Struct:LuaScriptData]
//          | - Definition of [Struct:LuaScriptData] below
//          
//          
//          
//          [Definition Struct:LuaScriptData |??-byte]
//          |''''''''''''''''''''
//          |+0x54 - [32-bit (layer-1) Pointer]
//          |.+0x4 - [32-bit (layer-2) Pointer]
//          |..+0x2 - [Variable Size ASCII:LuaScriptNameID]
//          |..| - Practically this can be used to identify Cinematics (in-engine cutscenes), as they're controlled by a LuaScript. But due to this value only being accessible via a dynamic array, this is inadvisable.
//          |..| - LuaScriptNameIDs listed below
//          '
//          
//          # LuaScriptNameIDs (string)
//          |(only lists IDs useful for achievement logic)
//          |''''''''''''''''
//          | "Levels\SinglePlayer\M03_Cemetery\Resources\Cinematics\"
//          | + "M03_C_Gunslinger_Intro" => Cinematic introducing the Gunslinger EnemyType
//          | ...
//          '
// $7238B8: [PAL][32-bit (base) Pointer:UIcontrol(preferred)]
//          
//          +0x8 - [Lower4:ActiveMenuPointerIndex |16-bit]
//          | - This index determines which pointer should be referenced to access the current active InGameMenuData in [Array:UIcontrolPointers].
//          | - This value does not always reset back to a default value when all InGameMenus are closed.
//          | - 'InGameMenu' refers to the PauseMenu and any subsequent menus accessed via the PauseMenu as well as InGamePopupMenus (eg. Lore or hints) not opened via the PauseMenu
//          | - Practically this value should only be used to determine which pointer to use to access the current active InGameMenuData
//          |
//          | - Eg. SinglePlayer Mode: Opening PauseMenu (value = 0x2) -> Opening LoreMenu (value = 0x3)
//          | - Eg. Multiplayer Mode: Any player opens PauseMenu (value = 0x3) -> Opening LoreMenu (value = 0x4)
//          |
//          | 0x1 => Current active InGameMenuData is accessed via [Pointer:HUDcontrol_ptr-L2_A], this pointer always stores HUDcontrol_Gear-Player1
//          | 0x2 => Current active InGameMenuData is accessed via [Pointer:HUDcontrol_ptr-L2_B], this pointer always stores HUDcontrol_Gear-Player2 in Multiplayer Mode, in SinglePlayer Mode this stores InGameMenuData
//          | 0x3 => Current active InGameMenuData is accessed via [Pointer:HUDcontrol_ptr-L2_C], this pointer always stores InGameMenuData
//          | 0x4 => Current active InGameMenuData is accessed via [Pointer:HUDcontrol_ptr-L2_D], this pointer always stores InGameMenuData
//          | ...
//          
//          
//          +0xC - [32-bit (layer-1) Pointer:UIcontrolPointerArray] -> [Variable Size Array:UIcontrolPointers]
//          .
//          ._____HUDcontrol_Gear-Player1_____
//          .+0x0 - [32-bit (layer-2) Pointer:UIcontrol_ptr-L2_A]
//          .| - This pointer always points to [Struct:MainMenuControl] when at MainMenu or any submenus at MainMenu
//          .| - This pointer always points to [Struct:HUDcontrol_Gear-Player1] when in SinglePlayer OR Multiplayer Mode
//          .
//          ._____HUDcontrol_Gear-Player2_____ OR _____InGameMenuData_____
//          .+0x4 - [32-bit (layer-2) Pointer:UIcontrol_ptr-L2_B]
//          .| - This pointer only points to [Struct:HUDcontrol_Gear-Player2] when in Multiplayer Mode with 2nd player active
//          .| - This pointer will point to [Struct:InGameMenu] when in SinglePlayer Mode
//          .
//          ._____InGameMenuData_____
//          .+0x8 - [32-bit (layer-2) Pointer:UIcontrol_ptr-L2_C]
//          .| - This pointer will point to [Struct:InGameMenu] when in any Mode
//          .
//          ._____InGameMenuData_____
//          .+0xC - [32-bit (layer-2) Pointer:UIcontrol_ptr-L2_D]
//          .| - This pointer will point to [Struct:InGameMenu] when in any Mode
//          
//          
//          [Definition Struct:MainMenuControl |??-byte]
//          |''''''''''''''''''''
//          | - This struct handles data and logic for the MainMenu and its submenus
//          |
//          |+0x30 - [32-bit (layer-3) Pointer]
//          |.+0x2 - [Variable Size ASCII:MainMenuSubMenuID]
//          |.| - MainMenuSubMenuIDs listed below
//          |
//          |+0xC - [32-bit (layer-1) Pointer]
//          |.+0x0 - [32-bit (layer-2) Pointer]
//          |..
//          |..+0x30 - [32-bit (layer-3) Pointer]
//          |...+0x2 - [Variable Size ASCII:UItype] = "title"
//          |..
//          |..+0x48 - [32-bit:MainMenuTitle_TextLookupKeyID]
//          |..| - This LookupKeyID is the same ID which is used to access specific text via a LookupTable/HashMap, which is stored somewhere in memory.
//          |..| - The HashMap can easily be found by just searching for this exact [32-bit:TextLookupKeyID] via MemorySearch, there are multiple HashMaps stored in memory storing different packages of text
//          |..| - The HashMaps stores a list of [32-bit:TextLookupKeyID] + [32-bit Pointer:Text]
//          |..| --- [32-bit Pointer:Text] --(+0x2)--> [ASCII:Text]
//          |..| - Changing this [32-bit:TextLookupKeyID] to any other valid TextLookupKeyIDs inside the same HashMap will change the title text
//          |..| - TextLookupKeyIDs are language-independent (The same TextLookupKeyID is used for multiple languages)
//          |..| - TextLookupKeyIDs listed below
//          '
//          
//          
//          [Definition Struct:HUDcontrol_Gear |??-byte]
//          |''''''''''''''''''''
//          | - "HUDcontrol_Gear" refers to the top-right HUD for ammo and throwables
//          |
//          |+0x30 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:UItype] = "HUD"
//          |
//          |+0x70 - [32-bit (layer-1) Pointer]
//          |.+0xEC - [32-bit:EquippedWeapon_ReserveAmmo(display)]
//          |.| - This value displays the reserve ammunition
//          |.| - Functional values via [Pointer(EntityData_B):PlayerActorData] at $0x965cc4
//          |.
//          |.+0xF0 - [32-bit:EquippedWeapon_LoadedBullets(display)]
//          |.| - This value regulates the amount of bullets icons displayed
//          |.
//          |.+0xF4 - [32-bit:EquippedWeapon_MagazineSize(display)]
//          |.| - This value actually regulates the display of the bullet icons
//          |.| - Practically this value can be used to determine the max allowed bullets, which can be loaded inside the gun
//          |.
//          |.+0xF8 - [32-bit:ThrowableCountInInventory(display)]
//          |.| - This value displays how many dynamite bundles the player has in the inventory
//          '
//          
//          [Definition Struct:InGameMenu.PausedFrame |??-byte]
//          |''''''''''''''''''''
//          | - "InGameMenu.PausedFrame" refers to the PauseMenu
//          |
//          |+0x30 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:UItype] = "Pause"
//          |
//          |_____SelectedText_____
//          |+0xC - [32-bit (layer-1) Pointer]
//          |.+0x4 - [32-bit (layer-2) Pointer]
//          |..
//          |..+0xC8 - [8-bit:SelectableTextCount |16-bit]
//          |..| - This count is equal to the amount of entries in the [Array:SelectableTextPointers], below
//          |..
//          |..+0xCC - [20-byte Array:SelectableTextPointers]
//          |..| - This array stores (5x) [32-bit pointers],for PauseFrame, which points to data of the selected text. (Stores a bitFlag for when the textHighlight is active)
//          |..
//          |..+0xD8 - [Lower4:SelectedTextIndex |16-bit]
//          |..| 0x0 => Top most text is selected (Resume Game)
//          |..| 0x4 => bottom most text is selected (Quit Game)
//          |
//          |
//          |+0x118 - [32-bit (layer-1) Pointer]
//          |.+0x30 - [32-bit (layer-2) Pointer]
//          |..+0x2 - [Variable Size ASCII:InGameMenuType] = "Frame"
//          |.
//          |._____TextLookupKeyID_____
//          |.+0x6C - [32-bit:FrameTitle_TextLookupKeyID]
//          |.| - This LookupKeyID is the same ID which is used to access specific text via a LookupTable/HashMap, which is stored somewhere in memory.
//          |.| - The HashMap can easily be found by just searching for this exact [32-bit:TextLookupKeyID] via MemorySearch, there are multiple HashMaps stored in memory storing different packages of text
//          |.| - The HashMaps stores a list of [32-bit:TextLookupKeyID] + [32-bit Pointer:Text]
//          |.| --- [32-bit Pointer:Text] --(+0x2)--> [ASCII:Text]
//          |.| - Changing this [32-bit:Frame_TextLookupKeyID] to any other valid TextLookupKeyIDs inside the same HashMap will change the title text of the InGameMenu.Frame
//          |.|
//          |.| - Practically this can be used to identify which InGameMenu is displayed
//          |.| - TextLookupKeyIDs are language-independent (The same TextLookupKeyID is used for multiple languages)
//          |.| - TextLookupKeyIDs listed below
//          '
//          
//          [Definition Struct:InGameMenu.Frame |??-byte]
//          |''''''''''''''''''''
//          | - "InGameMenu.Frame" refers to any InGameMenu with a title + frame, which is not the PauseMenu (refer to TextLookupKeyIDs below)
//          |
//          |_____SelectedText_____
//          |+0xC - [32-bit (layer-1) Pointer]
//          |.+0x98 - [8-bit:SelectableTextCount |16-bit]
//          |.| - This count is equal to the amount of entries in the [Array:SelectableTextPointers], below
//          |.
//          |.+0x9C - [Variable Size Array:SelectableTextPointers]
//          |.| - Based on which Frame is being displayed (refer to TextLookupKeyIDs), the ListItems are different
//          |.| - This array stores [32-bit pointers], which points to data of the selected text. (Stores a bitFlag for when the textHighlight is active)
//          |.
//          |.+0xA8 - [Lower4:SelectedTextIndex |16-bit]
//          |.| 0x0 => Top most text is selected
//          |.| 0x1,0x2,... => lower text is selected
//          |
//          |
//          |+0x30 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:UItype] = "MessageBox"
//          |
//          |
//          |+0xB8 - [32-bit (layer-1) Pointer] -> FrameData
//          |.+0x30 - [32-bit (layer-2) Pointer]
//          |..+0x2 - [Variable Size ASCII:InGameMenuType] = "Frame"
//          |.
//          |._____TextLookupKeyID_____
//          |.+0x6C - [32-bit:FrameTitle_TextLookupKeyID]
//          |.| - This LookupKeyID is the same ID which is used to access specific text via a LookupTable/HashMap, which is stored somewhere in memory.
//          |.| - The HashMap can easily be found by just searching for this exact [32-bit:TextLookupKeyID] via MemorySearch, there are multiple HashMaps stored in memory storing different packages of text
//          |.| - The HashMaps stores a list of [32-bit:TextLookupKeyID] + [32-bit Pointer:Text]
//          |.| --- [32-bit Pointer:Text] --(+0x2)--> [ASCII:Text]
//          |.| - Changing this [32-bit:Frame_TextLookupKeyID] to any other valid TextLookupKeyIDs inside the same HashMap will change the title text of the InGameMenu.Frame
//          |.|
//          |.| - Practically this can be used to identify which InGameMenu is displayed
//          |.| - TextLookupKeyIDs are language-independent (The same TextLookupKeyID is used for multiple languages)
//          |.| - TextLookupKeyIDs listed below
//          |
//          |
//          |+0x7C - [32-bit (layer-1) Pointer]
//          |.+0x58 - [Lower4:SelectableTextCount |32-bit]
//          |.| - This count is how many entries/text lines can be highlighted/selected (eg. value = 0x2: Yes and No)
//          |.+0x68 - [Lower4:SelectedTextIndex |32-bit]
//          |.| - This value starts counting from 0x0; With 0x0 being the top most item
//          '
//          
//          [Definition Struct:InGameMenu.MessageBox |??-byte]
//          |''''''''''''''''''''
//          | - "InGameMenu.MessageBox" refers to the text inside the InGameMenu
//          |
//          |+0x30 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:UItype] = "MessageBox"
//          |
//          |
//          |+0xC - [32-bit (layer-1) Pointer]
//          |.+0x4 - [32-bit (layer-2) Pointer]
//          |..
//          |..+0x30 - [32-bit (layer-3) Pointer]
//          |...+0x2 - [Variable Size ASCII:DisplayedText]
//          |...| - Changing this ASCII does not re-render the text on screen.
//          |...| - This ASCII is the displayed text all capitalized
//          |...| - This ASCII is language-dependent
//          |..
//          |.._____TextLookupKeyID_____
//          |..+0x48 - [32-bit:MessageBoxText_TextLookupKeyID]
//          |..| - This LookupKeyID is the same ID which is used to access specific text via a LookupTable/HashMap, which is stored somewhere in memory.
//          |..| - The HashMap can easily be found by just searching for this exact [32-bit:TextLookupKeyID] via MemorySearch, there are multiple HashMaps stored in memory storing different packages of text
//          |..| - The HashMaps stores a list of [32-bit:TextLookupKeyID] + [32-bit Pointer:Text]
//          |..| --- [32-bit Pointer:Text] --(+0x2)--> [ASCII:Text]
//          |..| - Changing this [32-bit:Frame_TextLookupKeyID] to any other valid TextLookupKeyIDs inside the same HashMap will change the title text of the InGameMenu.Frame
//          |..|
//          |..| - Practically this can be used to identify what (non-selectable) text is displayed on the InGameMenu
//          |..| - TextLookupKeyIDs are language-independent (The same TextLookupKeyID is used for multiple languages)
//          |..| - TextLookupKeyIDs listed below
//          |
//          |
//          |+0x7C - [32-bit (layer-1) Pointer]
//          |.+0x58 - [Lower4:SelectableTextCount |32-bit]
//          |.| - This count is how many entries/text lines can be highlighted/selected (eg. value = 0x2: Yes and No)
//          |.+0x68 - [Lower4:SelectedTextIndex |32-bit]
//          |.| - This value starts counting from 0x0; With 0x0 being the top most item
//          '
//          
//          [Definition Struct:InGameMenu.Powers |??-byte]
//          |''''''''''''''''''''
//          | - "InGameMenu.Powers" refers to the PowersMenu
//          |
//          |+0x30 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:UItype] = "brands"
//          '
//          
//          
//          # MainMenuSubMenuIDs (string)
//          |(list incomplete)
//          |'''''''''''''''''''
//          | "chapter_select" => ChapterSelectMenu
//          | "coop-profile" => CoopProfileSelectMenu
//          | "profile_statistics" => StatisticsMenu
//          | "difficulty_select" => DifficultySelectMenu (before starting a new Chapter)
//          | "multiplayer_profile_select_ps2" => MultiplayerProfileSelectMenu
//          | "create_match" => CreateMultiplayerMatchMenu
//          | "extras" => ExtrasMenu
//          '
//          
//          # TextLookupKeyIDs (hex)
//          |(only lists IDs useful for achievement logic)
//          |'''''''''''''''''''
//          |---MainMenuSubMenuTitle---
//          | 0x0F9681AA => "Gunslinger" (when in Gunslinger Mode)
//          | 0xDEB00B09 => "Chapter" (when in ChapterSelectMenu)
//          | 0x31B54255 => "Cooperative" (when in Multiplayer Coop Mode)
//          | ...
//          |---FrameTitle--- (InGameMenus with a title)
//          | 0xE5E853D8 => "Paused" - PauseMenu
//          | 0xFB67DAF4 => "Lore" - PauseMenu->LoreMenu
//          | 0xDEA6139B => "Ammo Display" - (lore)
//          | 0x33E14BF8 => "Restart" - PauseMenu->RestartConfirmationMenu
//          | 0x8B239878 => "Quit" - PauseMenu->QuitConfirmationMenu
//          | 0x9EB09A69 => "New Power" - NewPowerMenu
//          | ...
//          |---NewPowerMenu----MessageBoxText---
//          | 0x8BBEEDB1 => "Silver Bullet"
//          | 0x2AD14BD8 => "Fear"
//          | 0x337DD749 => "Mystic Armor"
//          | 0x76E981F2 => "Vindicator"
//          | 0xBE5D5443 => "Blood Frenzy"
//          | 0xC6607CC3 => "Turn"
//          | 0x8657504F => "Black Shroud"
//          | 0xEC61D4E0 => "Soul Stealer"
//          '
// $727318: [8-bit] gunslinger map id
// $728FA0: [PAL][10-byte ASCII:SelectedPlayerProfileName]
//          - Max size is 10 characters
//          - ASCII value is set when creating a new PlayerProfile or when selecting an existing one
//          - Each PlayerProfileName is required to be unique, can't have 2 PlayerProfiles with the same name
// $729330: [NTSCU][8-bit:GameState |32-bit]
//          @Regional equivalent of $0x73b430 (PAL)
//          - Values are different when compared to PAL
//          0x1 => Player is in control of PlayerCharacter || At MainMenu || In-Game
//          0x3 => Any InGameMenu is active. (eg. PauseMenu and submenus, menus for saving to the memory card, LoreMenus not necessarily opened via the PauseMenu) (Manually editing this value to 0x3 freezes the game until changed)
// $72BBD8: Player in Movie Cutscene [8-Bit]
//          0x01= Yes
// $73B3F0: [PAL][32-bit:TurboMode(hack)]
//          - Freezing this value, makes the game run in turbo
// $73B410: [PAL][32-bit:TimerControl(functional)]
//          - Time in milliseconds (1sec = 1,000ms)
//          - This value directly regulates the timer in a Multiplayer Verus Match. Be wary, this value does not start/restart from a default value (0x0) on the start of the Verus Mode timer.
//          - To determine the effective time left in a match, rather use [32-bit:MissionTime_Total] (refer to $0x74d78c), which always starts counting from 0x0.
//          - OR use [32-bit:MatchDuration] (refer to $0x9114e0), with following formula:
//          --| currentTime = [32-bit:TimerControl(functional)]
//          --| timeAtMatchEnd = [32-bit:TimerControl(functional)] + ([32-bit:MatchDuration] * 60 * 1,000)
//          --| timeLeftInMatch =  timeAtMatchEnd - currentTime
// $73B430: [PAL][8-bit:GameState |32-bit]
//          - Values are different when compared to NTSCU
//          0x0 => Player is in control of PlayerCharacter || At MainMenu || In-Game
//          0x1 => MainLoadingMenu is active, stays 0x1 for the duration of the first in-engine cutscene after exiting the MainLoadingMenu, becomes 0x0 once the player can control the PlayerCharacter.
//          0x3 => Any InGameMenu is active. (eg. PauseMenu and submenus, menus for saving to the memory card, LoreMenus not necessarily opened via the PauseMenu) (Manually editing this value to 0x3 freezes the game until changed)
// $73B68C: [NTSCU][32-bit (base) Pointer:PlayerData]
//          @Regional equivalent of $0x74d78c (PAL)
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
//          |+0x0 - [8-bit:EquippedWeapon_WeaponID |32-bit]
//          |
//          |
//          |------[Struct:GameStats(Temp)]------
//          | - These stats are updated dynamically, during gameplay.
//          | - These stats are saved to [Struct:GameStats(ChapterSection)] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this stats reset to 0
//          |
//          |+0x4 - [32-bit:MissionTime_Temp]
//          |+0x18 - [32-bit:Kills_Temp]
//          |+0x1C - [32-bit:ShotsFired_Temp]
//          |+0x20 - [32-bit:ShotsHit_Temp]
//          |+0x24 - [32-bit:HeadshotKills_Temp]
//          |+0x28 - [32-bit:MeleeKills_Temp]
//          |+0x30 - [32-bit Pointer:WeaponEquipTimes_Temp] -> [40-byte Struct:WeaponEquipTimes]
//          || - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
//          |
//          |
//          |
//          |------[Struct:GameStats(ChapterTotal)]------
//          | - Stats from [Struct:GameStats(ChapterSection)] are added to this [Struct:GameStats(ChapterTotal)] WHEN ChapterSection completes OR on Quit
//          | - Stats in [Struct:GameStats(ChapterTotal)] start at 0 WHEN starting new Chapter/Level
//          | - Stats in [Struct:GameStats(ChapterTotal)] determine the statistics which can be viewed in the MainMenu->ExtrasMenu->StatisticsMenu (refer to $0x965cd8)
//          |
//          |+0x38 - [32-bit:MissionTime_ChapterTotal]
//          |+0x3C - [32-bit:PlayerDeaths_ChapterTotal]
//          |+0x44 - [Lower4:DifficultyID(alt) |32-bit]
//          |+0x4C - [32-bit:Kills_ChapterTotal]
//          |+0x50 - [32-bit:ShotsFired_ChapterTotal]
//          |+0x54 - [32-bit:ShotsHit_ChapterTotal]
//          |+0x58 - [32-bit:HeadshotKills_ChapterTotal]
//          |+0x5C - [32-bit:MeleeKills_ChapterTotal]
//          |+0x64 - [32-bit Pointer:WeaponEquipTimes_ChapterTotal] -> [40-byte Struct:WeaponEquipTimes]
//          || - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
//          |
//          |
//          |
//          |------[Struct:GameStats(ChapterSection)]------
//          | - Stats from [Struct:GameStats(Temp)] are added to this [Struct:GameStats(ChapterSection)] WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          | - Stats from this [Struct:GameStats(ChapterSection)] are added to [Struct:GameStats(ChapterTotal)] WHEN ChapterSection completes OR on Quit
//          |
//          |+0x6C - [32-bit:MissionTime_ChapterSection]
//          |+0x70 - [32-bit:PlayerDeaths_ChapterSection]
//          |+0x78 - [Lower4:DifficultyID(preferred) |32-bit]
//          |+0x80 - [32-bit:Kills_ChapterSection]
//          |+0x84 - [32-bit:ShotsFired_ChapterSection]
//          |+0x88 - [32-bit:ShotsHit_ChapterSection]
//          |+0x8c - [32-bit:HeadshotKills_ChapterSection]
//          |+0x90 - [32-bit:MeleeKills_ChapterSection]
//          |+0x98 - [32-bit Pointer:WeaponEquipTimes_ChapterSection] -> [40-byte Struct:WeaponEquipTimes]
//          || - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
//          |
//          |
//          |
//          |------OtherData------
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
// $7F585C: [NTSCU][32-bit:Checkpoint_RespawnPointID(preferred)]
//          @Regional equivalent of $0x80783c (PAL)
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x8ff4d8
// $8075AC: [PAL][32-bit (base) Pointer:UIcontrol(alt)]
//          - Prefer using [Pointer:UIcontrol(preferred)] at $0x7238b8
// $80783C: [PAL][32-bit:Checkpoint_RespawnPointID(preferred)]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          - This Checkpoint_RespawnPointID only changes when a new Checkpoint initializes OR when non is active.
//          - This value becomes 0x0 when pressing PauseMenu->Restart, thus this can be used to check if the player presses Restart.
//          
//          # RespawnPointIDs (hex) - CheckpointIDs (string)
//          |(list incomplete) (StoryChapterSectionIDs listed at $0x721820)
//          |''''''''''''''''''''''''
//          | 0x0 => No checkpoint reached/initialized; When loading; When in-between Levels; When pressing Restart on PauseMenu; Not when using a checkpoint.
//          |
//          |===Chapter 1, "The Wrong Train"===
//          | ---StoryChapterSection "WrongTrain_A"---
//          | 0x4D9 - "Checkpoint_1" => Start of Chapter
//          | 0x50C - "Checkpoint_2" => After acquiring the Redeemer Pistol
//          | ---StoryChapterSection "WrongTrain_B"---
//          | [VariousValues] - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x333 - "Checkpoint_2" => Waking up after vault explosion. Cassidy wakes up the player
//          |
//          |===Chapter 2, "Ride Like The Devil"===
//          | ---StoryChapterSection "Hub_A"---
//          | 0x26C - "Checkpoint_1" => Start of Chapter
//          | 0x565 - "Checkpoint_2" => Start of Boss Battle
//          |
//          |===Chapter 3, "Boneyard"===
//          | ---StoryChapterSection "M03_C"---
//          | 0x328 - "Checkpoint_1" => At start of Chapter
//          | 0x3DF - "Checkpoint_2" => Before Mark of Evil spawns near the church
//          | ---StoryChapterSection "M03_B"---
//          | 0x344 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x342 - "Checkpoint_2" => Entering catacombs arena
//          | 0x362 - "Checkpoint_3" => Catacombs arena, after Banshee intro
//          | 0x362 - "Checkpoint_4" => Catacombs arena, after defeating the Banshees
//          | ---StoryChapterSection "M03_A"---
//          | 0x2B6 - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)
//          | 0x2BC - "Checkpoint_2" => After Good/Evil choice
//          |
//          |===Chapter 4, "Devil's Belly Mine"===
//          | ---StoryChapterSection "Hub_A"---
//          | 0x382 - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)(1x TaintedSoul)
//          | 0x3d3 - "Checkpoint_2" => Near first Mark of Evil fight??
//          | ---StoryChapterSection "Hub_B"---
//          | 0x347 - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          | 0x3B3 - "Checkpoint_2" => After dropping down the hole; Intro of TNTreapers (1x TaintedSoul)
//          | ---StoryChapterSection "Hub_C"---
//          | 0x2F4 - "Checkpoint_1" => Start of StoryChapterSection with reinforced door (2x TaintedSoul)
//          | 0x40A - "Checkpoint_2" => After blowing up reinforced door
//          | ---StoryChapterSection "Hub_D"---
//          | 0x33F - "Checkpoint_1" => Start of StoryChapterSection (2x TaintedSoul)
//          | 0x3DB - "Checkpoint_2" => After dropping down gap, section with Mark of Evil
//          |
//          |===Chapter 5, "Darkwatch Outpost"===
//          | ---StoryChapterSection "M07_A"---
//          | 0x2D8 - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          | 0x396 - "Checkpoint_2" => Inner outpost, clear enemies part 1
//          | 0x3B6 - "Checkpoint_3" => Inner outpost, clear enemies part 2
//          | ---StoryChapterSection "M07_B"---
//          | 0x2DC - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)
//          | 0x387 - "Checkpoint_2" => After moral choice (1x TaintedSoul)
//          |
//          |===Chapter 6, "War Train"===
//          | ---StoryChapterSection "M07_C"---
//          | (Checkpoint_1 is non-existent) => Before War Train spawns
//          | 0x332 - "Checkpoint_2" => Fight vs War Train
//          |
//          |===Chapter 7, "Torture Maze"===
//          | ---StoryChapterSection "M09_A"---
//          | 0x331 - "Checkpoint_1" => Start of StoryChapterSection
//          | ---StoryChapterSection "M09_B"---
//          | 0x3B2 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x45F - "Checkpoint_2" => Before civilians spawn
//          | ---StoryChapterSection "M09_C"---
//          | 0x31C - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x3A4 - "Checkpoint_2" => After turning all the valves
//          | ---StoryChapterSection "M09_D"---
//          | 0x2B1 - "Checkpoint_1" => Start of StoryChapterSection
//          | ---StoryChapterSection "M09_E"---
//          | 0x34F - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x368 - "Checkpoint_2" => Arena fight part 2
//          | 0x389 - "Checkpoint_3" => Arena fight part 3
//          | ---StoryChapterSection "M09_F"---
//          | 0x3BF - "Checkpoint_1" => Start of StoryChapterSection
//          |
//          |===Chapter 8, "Baptism of Fire"===
//          | ---StoryChapterSection "M10_A"---
//          | 0x38A - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          | ... - "Checkpoint_2" => ???
//          | 0x40F - "Checkpoint_3" => After killing all enemies in 1st zone, once
//          | ---StoryChapterSection "M10_B"---
//          | 0x340 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x3A2 - "Checkpoint_2" => Entering House, more Marks of Evil spawn
//          | ---StoryChapterSection "M10_C"---
//          | 0x346 - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)
//          | 0x415 - "Checkpoint_2" => After MoralChoice (2x TaintedSoul)
//          | 0x4BE - "Checkpoint_3" => After Killing all Shotgunners
//          | ---StoryChapterSection "M10_D"---
//          | 0x2BB - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x3C9 - "Checkpoint_2" => Mark of Evil inside big barn
//          |
//          |===Chapter "Citadel"===
//          | ---StoryChapterSection "Citadel_Launch_AA"---
//          | This is some sort of Hub area, to select the next 3 missions/Chapters
//          |
//          |===Chapter 9, "Rescue"===
//          | ---StoryChapterSection "Hub_A"---
//          | [VariousValues] - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x458 - "Checkpoint_2" => After destroying 2nd Mark of Evil
//          | 0x4BA- "Checkpoint_3" => After killing all enemies in town area
//          | ---StoryChapterSection "Hub_B"---
//          | 0x474 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x513 - "Checkpoint_2" => Regulator Defence, 1st wave done
//          |
//          |===Chapter 10, "The Deadlight Prism"===
//          | ---StoryChapterSection "M15_D"---
//          | 0x4AC - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          | 0x528 - "Checkpoint_2" => Before Banshee spawn
//          | ---StoryChapterSection "M15_E"---
//          | 0x439 - "Checkpoint_1" => Start of StoryChapterSection
//          | ---StoryChapterSection "M15_F"---
//          | 0x4C7 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4E4 - "Checkpoint_2" => After dropping down cliff, ambush with fire
//          | 0x4E4 - "Checkpoint_3" => After ambush with fire
//          | ---StoryChapterSection "M15_A"---
//          | 0x4F3 - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)
//          | 0x52C - "Checkpoint_2" => Further into canyon valley (1x TaintedSoul)
//          | 0x55E - "Checkpoint_3" => Even further into canyon valley (1x TaintedSoul)
//          | 0x58A - "Checkpoint_4" => Before Mark of Evil spawn (1x TaintedSoul)
//          | ---StoryChapterSection "M15_C"---
//          | 0x47A - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          |
//          |===Chapter 11, "Invasion"===
//          | ---StoryChapterSection "M17_B"---
//          | 0x472 - "Checkpoint_1" => Start of StoryChapterSection (1x TaintedSoul)
//          | 0x4D8 - "Checkpoint_2" => Entering deeper in caves
//          | 0x4EF - "Checkpoint_3" => Entering deeper in caves
//          | ---StoryChapterSection "M17_C"---
//          | 0x3C0 - "Checkpoint_1" => Start of StoryChapterSection (1x MoralChoice)
//          | 0x46A - "Checkpoint_2" => After MoralChoice (2x TaintedSoul)
//          | 0x59D - "Checkpoint_3" => Before Mark of Evil spawn
//          | ---StoryChapterSection "M17_D"---
//          | 0x45E - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x464 - "Checkpoint_2" => Enemy spawn behind defence
//          |
//          |===Chapter 12, "Hangtown"===
//          | ---StoryChapterSection "M11_F"---
//          | 0x4A0 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x533 - "Checkpoint_2" => Before fight start
//          | 0x55D - "Checkpoint_3" => Before fall back to hotel
//          | 0x55D - "Checkpoint_4" => Before hotel explodes
//          | ---StoryChapterSection "M11_G"---
//          | 0x503 - "Checkpoint_1" => After MoralChoice (1x MoralChoice)
//          | 0x55C - "Checkpoint_2" => After 1st wave
//          | 0x59A - "Checkpoint_3" => After 1st Mark of Evil spawn
//          | 0x59A - "Checkpoint_4" => Before 2nd Mark of Evil spawn
//          | 0x5A0 - "Checkpoint_5" => After 2nd Mark of Evil destroy
//          | ---StoryChapterSection "M11_H"---
//          | 0x4A9 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4CE - "Checkpoint_2" => Near Church (1x TaintedSoul)
//          |
//          |===Chapter 13, "The Morning After"===
//          | ---StoryChapterSection "M12_AA"---
//          | 0x451 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x535 - "Checkpoint_2" => After Tala leaves Citadel
//          | ---StoryChapterSection "M12_B"---
//          | 0x615 - "Checkpoint_1" => Start of StoryChapterSection (2x TaintedSoul)
//          | 0x72C - "Checkpoint_2" => Further inside Citadel
//          | 0x72D - "Checkpoint_3" => Along Train Tracks
//          | ---StoryChapterSection "M12_C"---
//          | 0x62A - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x633 - "Checkpoint_2" => Further inside Citadel
//          | 0x633 - "Checkpoint_3" => Even further inside Citadel
//          | ---StoryChapterSection "M12_D"---
//          | 0x638 - "Checkpoint_1" => Start of StoryChapterSection
//          | ---StoryChapterSection "M12_A"---
//          | 0x36B - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x5A7 - "Checkpoint_2" => After killing shotgunner wave
//          |
//          |===Chapter 14, "Showdown"===
//          | ---StoryChapterSection "FallOfCitadel_A"---
//          | 0x444 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4F8 - "Checkpoint_2" => BossFight part 2
//          | 0x4F8 - "Checkpoint_3" => BossFight part 3, on bridge
//          | ---StoryChapterSection "FallOfCitadel_B"---
//          | // (no gameplay, only 1x MoralChoice)
//          |
//          |===Chapter 15, "The Right Train"===
//          | ---StoryChapterSection "M19_A"---
//          | 0x40C - "Checkpoint_1" => Start of StoryChapterSection, on horseback"
//          | 0x4CC - "Checkpoint_2" => On the train
//          | 0x5B4 - "Checkpoint_3" => On the train, inside wagon filled with reapers
//          | 0x5A1 - "Checkpoint_4" => On the train, cleared wagon with reapers
//          |
//          |===Chapter 16, "Deadfall"===
//          | ---StoryChapterSection "Hub_A"---
//          | // (no checkpoints)
//          | ---StoryChapterSection "Hub_B"---
//          | ??? - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4F9 - "Checkpoint_2" => Before Mark of Evil spawn
//          | ---StoryChapterSection "Hub_B2"---
//          | 0x475 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4DF - "Checkpoint_2" => Before Mark of Evil spawn
//          | ---StoryChapterSection "Hub_C"---
//          | 0x4DE - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x51A - "Checkpoint_2" => After Mark of Evil destroy, inside apartments (1x TaintedSoul)
//          | ---StoryChapterSection "Hub_C2"---
//          | 0x4DB - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x4DF - "Checkpoint_2" => Before Mark of Evil spawn
//          |
//          |===Chapter 17, "Curse of The West"===
//          | ---StoryChapterSection "GroundZero_A"---
//          | 0x534 - "Checkpoint_1" => Start of StoryChapterSection
//          | 0x62B - "Checkpoint_2" => BossFight part 2
//          '
// $807840: [PAL][32-bit (base) Pointer:CheckpointData_1] -> [Struct:CheckpointData]
//          @Fixed Memory Location, although pointed to by [32-bit (base) Pointer:CheckpointData_0] at $0x9114b8
//          
//          +0x2 - [13-byte ASCII:CheckpointID]
//          | - Documentation at $0x96d022
// $8FEAEC: [32-bit] Blood frenzy ability flag
// $8FF494: [NTSCU][Lower4:PlayerCount(preferred) |32-bit]
//          @Regional equivalent of $0x911474 (PAL)
// $8FF4D8: [NTSCU][32-bit (base) Pointer:CheckpointData_0]
//          @Regional equivalent of $0x9114b8 (PAL)
// $8FF510: [NTSCU][Lower4:GameMode |32-bit]
//          @Regional equivalent of $0x9114f0 (PAL)
// $8FF524: [NTSCU][8-bit:MatchDuration(non-functional) |32-bit]
//          @Regional equivalent of $0x911504 (PAL)
// $8FF528: [NTSCU][8-bit:DeathmatchSetting_KillsToWin(non-functional) |32-bit]
//          @Regional equivalent of $0x911508 (PAL)
// $8FF534: [NTSCU][Lower4:MultiplayerVersusGameModeID(non-functional) |32-bit]
//          @Regional equivalent of $0x911514 (PAL)
// $8FFAC8: [8-bit] main menu selection
// $911430: [PAL][32-bit (base) Pointer:LevelID(alt)]
//          +0x2 - [Variable Size ASCII:LevelID(alt)]
//          | - Prefer using [Pointer:LevelID(preferred)] at $0x721820
// $911444: [PAL][Lower4:DifficultyID(alt1) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $91145C: [PAL][Lower4:DifficultyID(alt2) |32-bit]
//          - Identical to [Lower4:DifficultyID] at $0x965c7c
// $911474: [PAL][Lower4:PlayerCount(preferred) |32-bit]
//          0x1 => Singleplayer || Versus Mode with 1 player
//          0x2 => Multiplayer Coop || Versus Mode with 2 players
// $91147C: [PAL][Lower4:PlayerCount(alt1) |32-bit]
// $911480: [PAL][Lower4:PlayerCount(alt2) |16-bit]
// $9114B4: [PAL][32-bit:Checkpoint_RespawnPointID(alt)]
//          - String CheckpointIDs accessed via [Pointer:CheckpointData_1] at $0x807840
//          - This Checkpoint_RespawnPointID changes to other "transition" values when a new checkpoint initializes. Thus prefer using [32-bit:Checkpoint_RespawnPointID(preferred)] at $0x80783c
//          - RespawnPointIDs listed at $0x80783c
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
// $9114F0: [PAL][Lower4:GameMode |32-bit]
//          - This value only changes when loading a level; It does not reset or change when going back to MainMenu
//          
//          0x0 => Singleplayer Mode || Multiplayer Coop Mode
//          0x1 => Gunslinger Mode
//          0x3 => Multiplayer Versus Mode
// $911504: [PAL][8-bit:MatchDuration(non-functional) |32-bit]
//          - Prefer using [32-bit:MatchDuration(functional] at $0x9114e0
//          - Match duration in minutes
//          - This value only changes when starting a MP Versus Match
//          
//          0xFF => No Time Limit
//          0x5 => 5 Minutes
//          0xA => 10 Minutes
//          0xF => 15 Minutes
//          0x1E => 30 Minutes
// $911508: [PAL][8-bit:DeathmatchSetting_KillsToWin(non-functional) |32-bit]
//          - Kills required to win the match
//          - This value only changes when starting a MP Versus Match
//          
//          0xFF => No Kill Limit
//          0x5 => 5 Kills
//          0xA => 10 Kills
//          0xF => 15 Kills
//          0x19 => 25 Kills
//          0x32=> 50 Kills
// $911514: [PAL][Lower4:MultiplayerVersusGameModeID(non-functional) |32-bit]
//          - This value only changes when starting a MP Versus Match
//          
//          0x1 => Deathmatch
//          0x4 => Soul Hunter
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
// $953C24: [NTSCU][300-byte Struct(PlayerData):Player-1]
//          ===========================================
//          @Regional equivalent of $0x965c04 (PAL)
//          
//          [NTSCU][8-bit:EquippedWeapon_WeaponID-Player1 |32-bit]
//          @Regional equivalent of $0x965c04 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C28: [NTSCU][32-bit:MissionTime_Temp]
//          @Regional equivalent of $0x965c08 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C3C: [NTSCU][32-bit:Kills_Temp-Player1]
//          @Regional equivalent of $0x965c1c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C40: [NTSCU][32-bit:ShotsFired_Temp-Player1]
//          @Regional equivalent of $0x965c20 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C44: [NTSCU][32-bit:ShotsHit_Temp-Player1]
//          @Regional equivalent of $0x965c24 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C48: [NTSCU][32-bit:HeadshotKills_Temp-Player1]
//          @Regional equivalent of $0x965c28 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C4C: [NTSCU][32-bit:MeleeKills_Temp-Player1]
//          @Regional equivalent of $0x965c2c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C5C: [NTSCU][32-bit:MissionTime_ChapterTotal]
//          @Regional equivalent of $0x965c3c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C60: [NTSCU][32-bit:PlayerDeaths_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c40 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C70: [NTSCU][32-bit:Kills_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c50 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C74: [NTSCU][32-bit:ShotsFired_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c54 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C78: [NTSCU][32-bit:ShotsHit_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c58 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C7C: [NTSCU][32-bit:HeadshotKills_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c5c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C80: [NTSCU][32-bit:MeleeKills_ChapterTotal-Player1]
//          @Regional equivalent of $0x965c60 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C90: [NTSCU][32-bit:MissionTime_ChapterSection]
//          @Regional equivalent of $0x965c70 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C94: [NTSCU][32-bit:PlayerDeaths_ChapterSection-Player1]
//          @Regional equivalent of $0x965c74 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953C9C: [NTSCU][Lower4:DifficultyID(preferred) |32-bit]
//          @Regional equivalent of $0x965c7c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CA4: [NTSCU][32-bit:Kills_ChapterSection-Player1]
//          @Regional equivalent of $0x965c84 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CA8: [NTSCU][32-bit:ShotsFired_ChapterSection-Player1]
//          @Regional equivalent of $0x965c88 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CAC: [NTSCU][32-bit:ShotsHit_ChapterSection-Player1]
//          @Regional equivalent of $0x965c8c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CB0: [NTSCU][32-bit:HeadshotKills_ChapterSection-Player1]
//          @Regional equivalent of $0x965c90 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CB4: [NTSCU][32-bit:MeleeKills_ChapterSection-Player1]
//          @Regional equivalent of $0x965c94 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CE4: [NTSCU][32-bit (base) Pointer(EntityData_B):PlayerActorData-Player1] -> [Struct:EntityData-Player1]
//          @Regional equivalent of $0x965cc4 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953CF8: [NTSCU][32-bit (base) Pointer:PlayerSavedStats-Player1]
//          @Regional equivalent of $0x965cd8 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D18: [NTSCU][8-bit:InProgress_StoryChapterID |16-bit]
//          @Regional equivalent of $0x965cf8 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D1A: [NTSCU][8-bit:FurthestProgressed_StoryChapterID |16-bit]
//          @Regional equivalent of $0x965cfa (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D20: [NTSCU][bit0 BitFlag:IsStoryGoodEndingAchieved |8-bit]
//          @Regional equivalent of $0x965d00 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D21: [NTSCU][bit0 BitFlag:IsStoryEvilEndingAchieved |8-bit]
//          @Regional equivalent of $0x965d01 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D24: [NTSCU][32-bit:SelectedPlayerProfileID-Player1]
//          @Regional equivalent of $0x965d04 (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D4C: [NTSCU][32-bit (base) Pointer:HUDcontrol_Health-Player1]
//          @Regional equivalent of $0x965d2c (PAL)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x73b68c)
// $953D50: [NTSCU][300-byte Struct(PlayerData):Player-2]
//          ===========================================
//          @Regional equivalent of $0x965d30 (PAL)
//          - PlayerData for player2 is only populated when starting Multiplayer
//          
//          [NTSCU][8-bit:EquippedWeapon_WeaponID-Player2 |32-bit]
//          @Regional equivalent of $0x965d30 (PAL)
//          @Member of [Struct(PlayerData):Player-2] (refer to $0x73b68c)
// $95B042: [NTSCU][13-byte ASCII:CheckpointID]
//          @Regional equivalent of $0x96d022 (PAL)
// $960B3C: [32-bit] High calibar bullets ability flag
// $960D6C: [32-bit] black shroud ability flag
// $960F7C: [32-bit] shield ability flag
// $96438C: [32-bit] Lighting ability flag
// $965C04: [PAL][300-byte Struct(PlayerData):Player-1]
//          ===========================================
//          
//          [PAL][8-bit:EquippedWeapon_WeaponID-Player1 |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          # WeaponIDS (hex)
//          |(list complete)
//          |''''''''''''
//          | 0x0 => Pistol (starter revolver, in Chapter 1)
//          | 0x1 => Redeemer
//          | 0x2 => Dual Pistols
//          | 0x3 => Horse Revolver (cut content??, may be revolver whilst riding on horseback)
//          | 0x4 => Carbine (rifle)
//          | 0x5 => Shotgun
//          | 0x6 => Rail Rocket (rocket launcher)
//          | 0x7 => Crossbow
//          | 0x8 => Range Rifle (sniper rifle)
//          | 0x9 => Scepter (melee)
//          '
// $965C08: [PAL][32-bit:MissionTime_Temp]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:MissionTime_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete). THEN this value restarts counting from 0
//          
//          - Time in milliseconds (1s = 1,000ms || 60,000 ms = 1 minute)
// $965C1C: [PAL][32-bit:Kills_Temp-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:MissionTime_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this value restarts counting from 0
//          
//          - Counts both melee and gun kills
//          - For some reason this adds +1 for when the player dies.
// $965C20: [PAL][32-bit:ShotsFired_Temp-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:ShotsFired_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this value restarts counting from 0
// $965C24: [PAL][32-bit:ShotsHit_Temp-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:ShotsHit_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this value restarts counting from 0
// $965C28: [PAL][32-bit:HeadshotKills_Temp-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:HeadshotKills_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this value restarts counting from 0
// $965C2C: [PAL][32-bit:MeleeKills_Temp-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value is added to [32-bit:MeleeKills_ChapterSection] WHEN at certain occasions (event/cutscene/checkpointReached/Quit). THEN this value restarts counting from 0
// $965C34: [PAL][32-bit (base) Pointer:WeaponEquipTimes_Temp] -> [Struct:WeaponEquipTimes]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
// $965C3C: [PAL][32-bit:MissionTime_ChapterTotal]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:MissionTime_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
//          
//          - Time in milliseconds (1s = 1,000ms || 60,000 ms = 1 minute)
// $965C40: [PAL][32-bit:PlayerDeaths_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:PlayerDeaths_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
// $965C48: [PAL][Lower4:DifficultyID(alt) |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [Lower4:DifficultyID(preferred)] is copied to this memAddr WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
// $965C50: [PAL][32-bit:Kills_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:Kills_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
//          
//          - Counts both melee and gun kills
// $965C54: [PAL][32-bit:ShotsFired_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:ShotsFired_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
// $965C58: [PAL][32-bit:ShotsHit_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:ShotsHit_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
// $965C5C: [PAL][32-bit:HeadshotKills_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:HeadshotKills_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
// $965C60: [PAL][32-bit:MeleeKills_ChapterTotal-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:MeleeKills_ChapterSection] is added to this value WHEN ChapterSection complete OR on Quit
//          - This value starts at 0 WHEN starting new Chapter/Level
//          
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
// $965C68: [PAL][32-bit (base) Pointer:WeaponEquipTimes_ChapterTotal] -> [Struct:WeaponEquipTimes]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
// $965C70: [PAL][32-bit:MissionTime_ChapterSection]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:MissionTime_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:MissionTime_ChapterTotal] WHEN ChapterSection complete OR on Quit
//          
//          - Time in milliseconds (1s = 1,000ms || 60,000 ms = 1 minute)
// $965C74: [PAL][32-bit:PlayerDeaths_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This value only increments by 1 on CheckpointRespawn, after PlayerDeath
//          - This value is added to [32-bit:PlayerDeaths_ChapterTotal] WHEN ChapterSection complete OR on Quit
// $965C7C: [PAL][Lower4:DifficultyID(preferred) |32-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This is the value which determines the statistics on MainMenu->StatsMenu (refer to [Pointer:PlayerSavedStats] at $0x965cd8)
//          
//          # DifficultyIDs (hex)
//          |''''''''''''
//          | 0x0 => Greenhorn
//          | 0x1 => Cowboy
//          | 0x2 => Shootist
//          | 0x3 => Deadeye
// $965C84: [PAL][32-bit:Kills_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:Kills_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:Kills_ChapterTotal] WHEN ChapterSection complete OR on Quit
//          
//          - Counts both melee and gun kills
// $965C88: [PAL][32-bit:ShotsFired_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:ShotsFired_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:ShotsFired_ChapterTotal] WHEN ChapterSection complete OR on Quit
// $965C8C: [PAL][32-bit:ShotsHit_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:ShotsHit_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:ShotsHit_ChapterTotal] WHEN ChapterSection complete OR on Quit
// $965C90: [PAL][32-bit:HeadshotKills_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:HeadshotKills_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:HeadshotKills_ChapterTotal] WHEN ChapterSection complete OR on Quit
// $965C94: [PAL][32-bit:MeleeKills_ChapterSection-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - [32-bit:MeleeKills_Temp] is added to this value WHEN at certain occasions (event/cutscene/checkpointReached/Quit/ChapterSection complete)
//          - This value is added to [32-bit:MeleeKills_ChapterTotal] WHEN ChapterSection complete OR on Quit
// $965C9C: [PAL][32-bit (base) Pointer:WeaponEquipTimes_ChapterSection] -> [Struct:WeaponEquipTimes]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Definition of [Struct:WeaponEquipTimes] at $0x965cd8
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
//          - This pointer temporarily becomes 0x0 on PauseMenu->Restart
//          
//          +0x30 - [12-byte Struct(Coordinates):PlayerLocation(copy)]
//          | - These coordinates are copied from [Struct:EntityComponent.CharacterStateMachineComponent].[Struct(Coordinates):PlayerLocation(functional)]
//          | - Definition of [Struct:Coordinates] below
//          
//          +0x44 - [32-bit (layer-1) Pointer]
//          .+0x2 - [Variable Size ASCII:EntityNameID]
//          .| - ASCII = "Chaz", this is a short name for Jericho Cross (PlayerCharacter)
//          
//          _____EntityComponents_____
//          +0x58 - [32-bit (layer-1) Pointer:EntityComponentsDictionary] -> [Dictionary:EntityComponents]
//          | - Each ListItem in this dictionary consists of a [32-bit:DictionaryKey] + [32-bit Pointer:EntityComponentData]
//          | - This dictionary is always sorted by the [32-bit:DictionaryKey]
//          | - Based on GameMode, different EntityComponents are stored inside the dictionary or in different order
//          | [Struct:EntityComponent.InventoryComponent].[32-bit:DictionaryKey] = 0x49
//          | [Struct:EntityComponent.HealthComponent(player)].[32-bit:DictionaryKey] = 0x4B
//          | [Struct:EntityComponent.AttackerManagerComponent].[32-bit:DictionaryKey] = 0x64
//          | [Struct:EntityComponent.CharacterStateMachineComponent].[32-bit:DictionaryKey] = 0x7B
//          .
//          .+0x4C - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.InventoryComponent]
//          .| - Definition of [Struct:EntityComponent.InventoryComponent] below
//          .
//          .+0x5C - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.CharacterStateMachineComponent]
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
//          .| - This pointer is only valid when playing Multiplayer Cooperative Mode
//          .| - Definition of [Struct:EntityComponent.HealthComponent(player)] below
//          .
//          .+0x7C - [32-bit (layer-2) Pointer:EntityComponentData] -> [Struct:EntityComponent.HealthComponent(player)]
//          .| - This pointer is only valid when playing SinglePlayer Mode OR Multiplayer Versus Mode
//          .| - Definition of [Struct:EntityComponent.HealthComponent(player)] below
//          
//          
//          _____WeaponLogicData_____
//          +0x70 - [32-bit (layer-1) Pointer]
//          .+0x0 - [32-bit (layer-2) Pointer] -> [Struct:EntityData]
//          .| - Definition of [Struct:EntityData] at $0x721788
//          .| - This [Struct:EntityData] changes all memberValues when switching to another weapon
//          ..
//          ..+0x44 - [32-bit (layer-3) Pointer]
//          ...+x2 - [Variable Size ASCII:Equipped_WeaponNameID]
//          ...| - WeaponNameIDs listed below
//          ..
//          .._____EntityWeaponComponents_A_____
//          ..+0x58 - [32-bit (layer-3) Pointer] -> [Dictionary:EntityWeaponComponents_A]
//          ..| - Each ListItem in this dictionary consists of a [32-bit:DictionaryKey] + [32-bit Pointer:EntityWeaponComponentData]
//          ..| - The ListItems get reordered when unlocking certain gameplay mechanics. (eg. when unlocking dynamite, some of the ListItems get reordered)
//          ..| - [Struct:EntityWeaponComponent.WeaponComponent].[32-bit:DictionaryKey] = 0x2F
//          ...
//          ...+0xC - [32-bit (layer-4) Pointer:EntityWeaponComponent_Dynamite] -> [Struct:EntityWeaponComponent.WeaponComponent(throwable)]
//          ...| - Definition of [Struct:EntityWeaponComponent.WeaponComponent(throwable)] below
//          ...
//          ...+0x2C - [32-bit (layer-4) Pointer:EntityWeaponComponent_Crossbow] -> [Struct:EntityWeaponComponent.WeaponComponent(weapon)]
//          ...| - Definition of [Struct:EntityWeaponComponent.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid when wielding the Crossbow
//          ...
//          ...+0x34 - [32-bit (layer-4) Pointer:EntityWeaponComponent_BasicPistol] -> [Struct:EntityWeaponComponent.WeaponComponent(weapon)]
//          ...| - Definition of [Struct:EntityWeaponComponent.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid for Chapter 1, when the player only has the BasicPistol equipped
//          ...| - Once the player has the RedeemerRevolver, refer to [Pointer:EntityWeaponComponent_NormalWeapon(noDynamite)]
//          ...
//          ...+0x3C - [32-bit (layer-4) Pointer:EntityWeaponComponent_NormalWeapon(noDynamite)] -> [Struct:EntityWeaponComponent.WeaponComponent(weapon)]
//          ...| - Definition of [Struct:EntityWeaponComponent.WeaponComponent(weapon)] below
//          ...| - This pointer is only valid when the player has not unlocked dynamite yet, thus should only be used up to Chapter 3, where the player first unlocks dynamite
//          ...| - This pointer is then only valid for the RedeemerRevolver as well as the CarbineRifle
//          ...| - Once the player has unlocked dynamite, refer to [Pointer:EntityWeaponComponent_NormalWeapon(dynamiteUnlocked)]
//          .
//          ._____EntityWeaponComponents_B_____
//          .+0xC - [32-bit (layer-2) Pointer]
//          ..+0x0 - [32-bit (layer-3) Pointer]
//          ...+0x58 - [32-bit (layer-4) Pointer] -> [Dictionary:EntityWeaponComponents_B]
//          ....+0x34 - [32-bit (layer-5) Pointer:EntityWeaponComponent_MultiplayerNormalWeapon] -> [Struct:EntityWeaponComponent.WeaponComponent(weapon)]
//          ....| - This pointer chain is only valid in Multiplayer Versus Mode and only for a few select weapons
//          ....
//          ....+0x3C - [32-bit (layer-5) Pointer:EntityWeaponComponent_NormalWeapon(dynamiteUnlocked)] -> [Struct:EntityWeaponComponent.WeaponComponent(weapon)]
//          ....| - This pointer chain is only valid when the player has unlocked dynamite
//          
//          
//          [Definition Struct:EntityComponent.InventoryComponent |??-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "InventoryComponent"
//          |
//          |+0x88 - [32-bit (layer-1) Pointer]
//          |.
//          |._____Selected/ActiveRune_____
//          |.+0x38 - [32-bit (layer-2) Pointer]
//          |..
//          |..+0x4 - [32-bit (layer-3) Pointer]
//          |...+0x2 - [11-byte ASCII] = "active_rune"
//          |..
//          |..+0xC - [32-bit (layer-3) Pointer]
//          |...+0x2 - [Variable Size ASCII:Selected_PowerRuneNameID]
//          |...| - PowerRuneNameIDs listed below
//          |.
//          |._____RuneUnlocks + RuneLogicData_____
//          |.+0x44 - [32-bit (layer-2) Pointer]
//          |..+0x10 - [32-bit (layer-3) Pointer] -> [192-byte Array:PowerRunes]
//          |..| - This array contains (12x) [Struct:ListItem_PowerRune |16-byte], sometimes it only contains (11x) ListItems, for some reason
//          |..| - Each available PowerRune should have one [Struct:ListItem_PowerRune] inside this array, refer to PowerRuneNameIDs below
//          |..| - Definition of [Struct:ListItem_PowerRune] below
//          '
//          
//          [Definition Struct:ListItem_PowerRune |16-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit (layer-1) Pointer:ListItem_PowerRune_Ptr_A]
//          |.+0x44 - [32-bit (layer-2) Pointer]
//          |..+0x2 - [Variable Size ASCII:PowerRuneNameID]
//          |..| - PowerRuneNameIDs listed below
//          |.
//          |.+0x58 - [32-bit (layer-2) Pointer] -> [Dictionary:PowerRuneComponents]
//          |.| - Each ListItem in this dictionary consists of a [32-bit:DictionaryKey] + [32-bit Pointer:PowerRuneComponentData]
//          |.| [Struct:PowerRuneComponent.RuneComponent].[32-bit:DictionaryKey] = 0x82, (Used by BloodVisionRune and VampireJumpRune)
//          |.| [Struct:PowerRuneComponent.DamageRuneComponent].[32-bit:DictionaryKey] = 0x86, (Used by SilverBrandRune and BloodFrenzyRune)
//          |.| [Struct:PowerRuneComponent.VampireShieldRuneComponent].[32-bit:DictionaryKey] = 0x85
//          |.| [Struct:PowerRuneComponent.SoulStealerRuneComponent].[32-bit:DictionaryKey] = 0x87
//          |.| [Struct:PowerRuneComponent.VindicatorRuneComponent].[32-bit:DictionaryKey] = 0x88
//          |.| [Struct:PowerRuneComponent.NullRuneComponent].[32-bit:DictionaryKey] = 0x89
//          |.| [Struct:PowerRuneComponent.TurnRuneComponent].[32-bit:DictionaryKey] = 0x8B
//          |.| [Struct:PowerRuneComponent.FearRuneComponent].[32-bit:DictionaryKey] = 0x8C
//          |.| [Struct:PowerRuneComponent.BlackShroudRuneComponent].[32-bit:DictionaryKey] = 0x8D
//          |.| [Struct:PowerRuneComponent.MysticArmourRuneComponent].[32-bit:DictionaryKey] = 0x8D
//          |.| - [Struct:PowerRuneComponent] stores logic for that PowerRune (eg. IsPowerActiveFlag, PowerDuration, ReputationType, ReputationPointsTillPowerUnlock...)
//          |.| - Definition of [Struct:PowerRuneComponent] below
//          |
//          |+0x4 - [32-bit (layer-1) Pointer:ListItem_PowerRune_Ptr_B]
//          |+0x8 - [32-bit (layer-1) Pointer:ListItem_PowerRune_Ptr_C]
//          |+0xC - [32-bit (layer-1) Pointer:ListItem_PowerRune_Ptr_D]
//          '
//          
//          [Definition Struct:PowerRuneComponent.RuneComponent |256-byte]
//          |'''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:PowerRuneComponentName] = "RuneComponent"
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:PowerRuneNameID]
//          |.| - PowerRuneNameIDs listed below
//          |
//          |+0x74 - [32-bit:ReputationPoints]
//          || - This value regulates when the Player can unlock this power, when this value == [32-bit:RequiredReputationPoints], then the Player unlocks this Power
//          || - This value also indirectly regulates the PowerSelectionUI
//          |
//          |+0x80 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:ReputationType]
//          |.| - ReputationTypes: "Evil", "Good", "Neutral"
//          |
//          |+0x84 - [32-bit:RequiredReputationPointsToUnlockPower]
//          || - This value regulates when the Player can unlock this power, when [32-bit:ReputationPoints] == this value, then the Player unlocks this Power
//          |
//          |+0xFC - [Float:PowerTimeLeft |32-bit]
//          || - Time in seconds; Countdown timer
//          || FloatValue = 0.0 => Power is inactive
//          || FloatValue > 0.0 => Power is active
//          '
//          
//          [Definition Struct:PowerRuneComponent.MysticArmourRuneComponent |??-byte]
//          |'''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:PowerRuneComponentName] = "MysticArmourRuneComponent"
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:PowerRuneNameID]
//          |.| - PowerRuneNameIDs listed below
//          |
//          |+0x74 - [32-bit:ReputationPoints]
//          || - This value regulates when the Player can unlock this power, when this value == [32-bit:RequiredReputationPoints], then the Player unlocks this Power
//          || - This value also indirectly regulates the PowerSelectionUI
//          |
//          |+0x80 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:ReputationType]
//          |.| - ReputationTypes: "Evil", "Good", "Neutral"
//          |
//          |+0x84 - [32-bit:RequiredReputationPointsToUnlockPower]
//          || - This value regulates when the Player can unlock this power, when [32-bit:ReputationPoints] == this value, then the Player unlocks this Power
//          |
//          |+0xE8 - [Float:PowerTimeLeft |32-bit]
//          || - Time in seconds; Countdown timer
//          || FloatValue = 0.0 => Power is inactive
//          || FloatValue > 0.0 => Power is active
//          |
//          |+0x108 - [bit0 BitFlag:IsPower_MysticArmour_Active |32-bit]
//          '
//          
//          [Definition Struct:EntityComponent.CharacterStateMachineComponent |??-byte]
//          |''''''''''''''''''''''''''''''
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
//          [Definition Struct:EntityComponent.HealthComponent(player) |??-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "HealthComponent"
//          |
//          |+0x98 - [Float:PlayerHealth(functional) |32-bit]
//          || - FloatRange: [0.0 --- 100.0]; 100.0 = maxHP; 0.0 = Death
//          || - Reference [Float:PlayerHealth(display)] at $0x965d2c
//          |
//          |+0xA0 - [Float:VampireShield(functional) |32-bit]
//          || - FloatRange: [0.0 --- 100.0]; 100.0 = maxShield; 0.0 = empty
//          || - Reference [Float:VampireShield(display)] at $0x965d2c
//          |
//          |+0xFC - [Float:BloodPowerGauge(functional) |32-bit]
//          || - FloatRange: [0.0 --- 30.0]; 30.0 = maxBloodPower; 0.0 = empty
//          || - Increments when picking up BloodClouds
//          || - When at 30.0, the player can activate a Power, returning this value back to 0.0
//          || - Reference |[Float:BloodPowerGauge(display)] at $0x965d2c
//          '
//          
//          [Definition Struct:EntityComponent.AttackerManagerComponent |??-byte]
//          |''''''''''''''''''''''''''''''
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "AttackerManagerComponent"
//          |
//          |+0x1C - [32-bit (layer-1) Pointer]
//          |.+0x0 - [32-bit (layer-2) Pointer]
//          |..+0x0 - [32-bit (layer-3) Pointer] -> [Struct:EntityData-AttackingEnemyTypeA]
//          |...+0x44 - [32-bit (layer-4) Pointer]
//          |....+0x2 - [Variable Size ASCII:EntityNameID]
//          |....| - This lists the name of the attacking/aggro'd entity
//          |
//          |+0x24 - [32-bit:EnemyCountAttackingEntity]
//          || - This counts how many enemies are attacking/aggro'd to this entity
//          '
//          
//          [Definition Struct:EntityWeaponComponent.WeaponComponent(weapon) |??-byte]
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
//          [Definition Struct:EntityWeaponComponent.WeaponComponent(throwable) |??-byte]
//          |''''''''''''''''''''''''''''''
//          | - This struct contains data which regulates the throwables (dynamite and splitter grenades)
//          |
//          |+0x8 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:EntityComponentName] = "WeaponComponent"
//          |
//          |+0x20 - [32-bit (layer-1) Pointer]
//          |.+x2 - [Variable Size ASCII:WeaponNameID]
//          |.| - WeaponNameIDs listed below
//          |
//          |+0x74 - [32-bit:ThrowableCountInInventory(functional-1)]
//          || - This value is always at 1 as long as throwables left in inventory > 0
//          || - Manually changing this value, puts that amount of throwables in the player's inventory, but this is not the intended design. (eg. manually placing 0x10 on this value, puts 16 throwables in the inventory)
//          || - Total number of throwables = [32-bit:ThrowableCountInInventory(functional-1)] + [32-bit:ThrowableCountInInventory(functional-2)]
//          |
//          |+0x1D8 - [32-bit:ThrowableCountInInventory(functional-2)]
//          || - This value regulates the amount of throwables  in the player's inventory
//          || - Freezing this value above 0, gives the player unlimited throwables
//          || - This count is always 1 count lower than the count shown on the [32-bit:ThrowableCountInInventory(display)] ($0x7238b8)
//          || - When the display value is at 1, this functional value is at 0. The player can then throw 1 more throwable, afterwards this functional value remains at 0 and the display value becomes 0.
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
//          
//          # PowerRuneNameIDs (string)
//          |(list complete)(grouped by ReputationType)
//          |''''''''''''''''''
//          |---Neutral Powers--- (acquired independent from Good/Evil choices)
//          | "VampireShieldRune => Blood Shield
//          | "BloodVisionRune" => Blood Vision (zoom-in)
//          | "VampireJumpRune" => Double Jump
//          |
//          |---Good Powers---
//          | "NullRune" => Default Rune??? (acquired independent from Good/Evil choices, although this one is marked as ReputationType "Good")
//          | "SilverBrandRune" => Silver Bullet
//          | "FearRune" => Fear
//          | "MysticArmourRune" => Mystic Armour
//          | "VindicatorRune" => Vindicator
//          |
//          |---Evil Powers---
//          | "BloodFrenzyRune" => Blood Frenzy
//          | "TurnRune" => Turn
//          | "BlackShroudRune" => Black Shroud
//          | "SoulStealerRune" => Soul Stealer
//          '
// $965CD4: [PAL][]
// $965CD8: [PAL][32-bit (base) Pointer:PlayerSavedStats-Player1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          
//          +0x4 - [32-bit (layer-1) Pointer:SavedStats_Story] -> [Array:SavedStats_Story]
//          | - This array stores multiple [Struct:ChapterStats], definition below. For SinglePlayer Mode
//          | - Saves stats per Chapter, although this can't be viewed for Story Mode, it always show all stats summed up for Story Mode (Overall Stats)
//          
//          +0xC - [32-bit (layer-1) Pointer:SavedStats_Gunslinger] -> [Array:SavedStats_Gunslinger]
//          | - This array stores multiple [Struct:ChapterStats], definition below. For Gunslinger Mode
//          | - Saves stats per Chapter, can be viewed by Chapter or Overall (all stats summed up)
//          
//          [Defintion Struct:ChapterStats |56-byte]
//          |'''''''''''''''''''''''
//          | - This struct saves gameplay statistics of a specific Chapter
//          | - This struct is only updated on completion of the corresponding Chapter, not when quiting
//          |
//          |+0x0 - [32-bit (layer-1) Pointer]
//          |.+0x2 - [Variable Size ASCII:LevelID]
//          |.| - LevelIDs listed at $0x721820
//          |
//          |+0x8 - [32-bit:MissionTime]
//          || - Time spent in Chapter
//          || - Time in milliseconds; ThisValue / 60.000 = timeInMinutes
//          |
//          |+0xC - [32-bit:PlayerDeaths]
//          |+0x14 - [Lower4:Difficulty |32-bit]
//          || - DifficultyIDs listed at $0x965c7c
//          |+0x1C - [32-bit:Kills]
//          |+0x20 - [32-bit:ShotsFired]
//          |+0x24 - [32-bit:ShotsHit]
//          || - Accuracy = ShotsHit / ShotsFired
//          |+0x28 - [32-bit:Headshots]
//          |+0x2C - [32-bit:MeleeKills]
//          |
//          |+0x34 - [32-bit (layer-1) Pointer:WeaponEquipTimes] -> [40-byte Struct:WeaponEquipTimes]
//          || - Definition of [Struct:WeaponEquipTimes] below
//          '
//          
//          [Definition Struct:WeaponEquipTimes |40-byte]
//          |''''''''''''''''''''''''''''''''
//          | - [Struct:WeaponEquipTimes] decides the "Favorite Weapon", by checking which weapon was equipped for the longest.
//          | -  When multiple weapons have the same EquipTime. The weapon with the lowest WeaponID is picked as the "Favorite Weapon". (WeaponIDs listed at $0x965c04)
//          | - WeaponEquipTimes are saved in milliseconds (1,000 ms = 1 sec); Max value is 0xFFFFFFFF (= around 1,193 hours), then overflows...
//          |
//          |+0x0 - [32-bit:WeaponEquipTime_Pistol]
//          |+0x4 - [32-bit:WeaponEquipTime_Redeemer]
//          |+0x8 - [32-bit:WeaponEquipTime_DualPistols]
//          |+0xC - [32-bit:WeaponEquipTime_HorseRevolver]
//          |+0x10 - [32-bit:WeaponEquipTime_Carbine]
//          |+0x14 - [32-bit:WeaponEquipTime_Shotgun]
//          |+0x18 - [32-bit:WeaponEquipTime_RailRocket]
//          |+0x1C - [32-bit:WeaponEquipTime_RangeRifle]
//          |+0x20 - [32-bit:WeaponEquipTime_Crossbow]
//          |+0x24 - [32-bit:WeaponEquipTime_Scepter]
//          '
// $965CE8: [PAL][3-byte Bitset:LoreUnlocks] (19 flags)
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - This bitset handles which Lore sections are unlocked in the PauseMenu->LoreMenu
//          - These flags unlock once the corresponding LorePopup is shown on screen for the first time for the selected PlayerProfile
//          - This bitset is saved to the PlayerProfileSave. When starting a new game, all previously unlocked flags will still remain unlocked
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
//          - Due to how the Chapters are ordered, especially Chapters 9 to 11, I advise against using this memAddr to ID Chapters/Levels
//          - Prefer identification via [Pointer:LevelID(preferred)] at $0x721820
//          - This also unlocks movies at MainMenu->Extras->Movies, depending on which Chapter is currently ID'd here
//          - This value can be used to identify SinglePlayer Story Mode progression/completion
//          
//          # StoryChapterIDs (hex)
//          |(list complete)
//          |'''''''''''''
//          | 0x1 => Chapter 1, "Wrong Train"
//          | 0x2 => Chapter 2, "Ride Like The Devil"
//          | 0x3 => Chapter 3, "Boneyard"
//          | 0x4 => Chapter 4, "Devil's Belly Mine"
//          | 0x5 => Chapter 5, "Darkwatch Outpost"
//          | 0x6 => Chapter 6, "War Train"
//          | 0x7 => Chapter 7, "Torture Maze"
//          | 0x8 => Chapter 8, "Baptism of Fire"
//          | 0x8 => Hub Area "Citadel" (mission select: Chapters 9,10,11; can be completed in any order)
//          | 0xA => Chapter 9, "Rescue"
//          | 0xB => Hub Area "Citadel" (mission select: Chapters 9,10,11; can be completed in any order)
//          | 0xC => Chapter 10, "The Deadlight Prism"
//          | 0xD => Hub Area "Citadel" (mission select: Chapters 9,10,11; can be completed in any order)
//          | 0xE => Chapter 11, "Invasion"
//          | 0xF => Hub Area "Citadel" (only mission available: Chapter 12)
//          | 0x10 => Chapter 12, "Hangtown"
//          | 0x11 => Chapter 13, "The Morning After"
//          | 0x12 => Chapter 14, "Showdown"
//          | 0x13 => Chapter 15, "The Right Train"
//          | 0x14 => Chapter 16, "Deadfall"
//          | 0x15 => Chapter 17, "Curse of the West" (to check if this Chapter is completed, use [BitFlag:IsStoryGoodEndingAchieved] OR [BitFlag:IsStoryEvilEndingAchieved])
//          '
// $965CFA: [PAL][8-bit:FurthestProgressed_StoryChapterID |16-bit]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - StoryChapterIDs listed at $0x965cf8
// $965D00: [PAL][bit0 BitFlag:IsStoryGoodEndingAchieved |8-bit]
//          - This also unlocks all movies at MainMenu->Extras->Movies (including "Devil" and "Hero", only unlockable with a Good playthrough)
// $965D01: [PAL][bit0 BitFlag:IsStoryEvilEndingAchieved |8-bit]
//          - This also unlocks all movies at MainMenu->Extras->Movies (including "Angel" and "Monster", only unlockable with an Evil playthrough)
// $965D04: [PAL][32-bit:SelectedPlayerProfileID:Player-1]
//          @Member of [Struct(PlayerData):Player-1] (refer to $0x74d78c)
//          - Max allowed PlayerProfiles is 10
//          
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
//          _____PlayerHealth_HUD_____ (top-left)
//          +0xC - [32-bit (layer-1) Pointer]
//          .+0x18 - [32-bit (layer-2) Pointer]
//          ..+0xF0 - [Float:PlayerHealth(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxHP; 0.0 = death
//          ..| - Reference [Float:PlayerHealth(functional)] at $0x965cc4
//          ..+0xF4 - [Float:VampireShield(display) |32-bit]
//          ..| - FloatRange: [1.0 --- 0.0]; 1.0 = maxShield; 0.0 = empty
//          ..| - Reference [Float:VampireShield(functional)] $0x965cc4
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
//          ...+0xE8 - [Float:HealthUI_PowerTimeLeft(display)(alt2) |32-bit]
//          ...| - FloatRange [1.0 --- 0.0]; 1.0 => Power time start; 0.0 => Power over
//          ...
//          ...+0xF0 - [Lower4:PowerDurationBarsLeft(display) |32-bit]
//          ...| - This value regulates how many BloodPowerDurationBars are displayed. It does not directly control the duration of the BloodPower.
//          ...| - HealthUI can display 8 PowerDurationBars in total.
//          ...| - When the BloodPower starts, this value starts a 0x7 (= 8 bars), this decrements by 1 each ... milliseconds. At 0x0 there is still 1 more bar displayed.
//          .
//          .
//          ._____BossHP_HUD_____ (top-middle)
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
//          ....+0x2F- [bit0 BitFlag:IsBossHPbarDisplayed]
//          ....| - This value directly controls if the Boss HP bar is displayed or not
//          ....
//          ....+0xF4 - [32-bit (layer-5) Pointer:BossEntityData] -> [Struct:EntityData]
//          ....| - Defintion of [Struct:EntityData] at $0x721788
//          ....| - When this pointer is zeroed out, there's no BossHP display active
//          .....+0x58 - [32-bit (layer-6) Pointer] -> [Dictionary:BossEntityComponents]
//          .....| - Each ListItem in this dictionary consists of a [32-bit:DictionaryKey] + [32-bit Pointer:PowerRuneComponentData]
//          .....| - Based on the Boss and Chapter more or less BossEntityComponents are stored inside this dictionary
//          .....| - This dictionary is always sorted by the [32-bit:DictionaryKey]
//          .....| [Struct:EntityComponent.HealthComponent(boss)].[32-bit:DictionaryKey] = 0x4B
//          ......
//          ......+0x4C - [32-bit (layer-7) Pointer:BossEntityComponentData_A] -> [Struct:EntityComponent.HealthComponent(boss)]
//          ......| - This pointer is only valid for the Boss in Chapter 1
//          ......| Definition of [Struct:EntityComponent.HealthComponent(boss)] below
//          ......
//          ......+0x5C - [32-bit (layer-7) Pointer:BossEntityComponentData_B] -> [Struct:EntityComponent.HealthComponent(boss)]
//          ......| - This pointer is only valid for the Boss in Chapter 2
//          ......| Definition of [Struct:EntityComponent.HealthComponent(boss)] below
//          .
//          .
//          ._____PowerSelectionUI_HUD_____ (bottom-left)
//          .+0x10 - [32-bit (layer-2) Pointer] -> [Struct:HUDcontrol_PowerSelectionUI |??-byte]
//          ..+0xC4 - [Float:PowerSelectionUI_Opacity |32-bit]
//          ...| - FloatRange [1.0 --- 0.0]; 1.0 => Fully visible; 0.0 => Invisible/hidden
//          ...| - The PowerSelectionUI is dynamically displayed and hidden during gameplay
//          ..
//          ..+0xE8 - [32-bit (layer-3) Pointer]
//          ..| - Changing this pointer so it points to another PowerRuneNameID (string), will update the middle/selected power icon of the bottom-left HUD accordingly
//          ...+0x2 - [Variable Size ASCII:PowerSelectionUI_Selected_PowerRuneNameID(display)]
//          ...| - PowerRuneNameIDs listed at $0x965cc4
//          ..
//          ..+0xF0 - [32-bit (layer-3) Pointer]
//          ..| - Changing this pointer so it points to another PowerRuneNameID (string), will update the right power icon of the bottom-left HUD accordingly
//          ...+0x2 - [Variable Size ASCII:PowerSelectionUI_Right_PowerRuneNameID(display)]
//          ...| - PowerRuneNameIDs listed at $0x965cc4
//          .
//          .
//          .+0x78 - [32-bit (layer-2) Pointer]
//          .| - Changing this pointer so it points to another PowerRuneNameID (string), will update the top-left HUD power icon accordingly
//          ..+0x2 - [Variable Size ASCII:HealthUI_Selected_PowerRuneNameID(display)]
//          ..| - PowerRuneNameIDs listed at $0x965cc4
//          .
//          .
//          .+0x174 - [Float:HealthUI_PowerTimeLeft(display)(alt1) |32-bit]
//          .| - FloatRange [1.0 --- 0.0]; 1.0 => Power time start; 0.0 => Power over
//          
//          
//          [Definition Struct:RGBhex |24-bit]
//          |'''''''''''''''
//          |+0x0 - [8-bit:Red]
//          |+0x1 - [8-bit:Green]
//          |+0x2 - [8-bit:Blue]
//          '
//          
//          [Definition Struct:EntityComponent.HealthComponent(boss) |??-byte]
//          |'''''''''''''''
//          |+0x98 - [Float:BossHP(functional) |32-bit]
//          || - 0.0 => death
//          || - eg. Chapter 1 Boss on Cowboy difficulty: 1000.0
//          '
// $965D30: [PAL][300-byte Struct(PlayerData):Player-2]
//          ===========================================
//          - PlayerData for player2 is only populated when starting Multiplayer
//          
//          [PAL][8-bit:EquippedWeapon_WeaponID-Player2 |32-bit]
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
