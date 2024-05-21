// Red Dead Revolver
// #ID = 11094

// $093390: [PAL][11-byte ASCII] Game ID - PS2 Product ID
//          - SLES_528.78 --> EUR
// $4F6FD8: [8bit] Player is in a cutscene?
// $4F93DC: [PAL][Bit Flag {32-bit}] bit 0 => Is Title Menu Displayed (alt)
//          - Identical to $0x562a0c
// $4FD3A8: [PAL][8-bit {32-bit}] Refresh Rate
//          - Game offers the option to chose refresh rate on game boot
//          0x32 (=50) => PAL 50Hz mode
//          0x3C (=60) => NTSC 60Hz mode
// $5602A0: [32-bit] Pointer
//          +0x58a4 [32-bit] Money
//          +0x5904  [32-bit] Key 1
//          +0x5908  [32-bit] Key 2
//          +0x590c  [32-bit] Key 3
//          +0x5910  [32-bit] Key 4
//          +0x5914  [32-bit] Key 5
//          +0x5994  [Float] Health
//          +0x5ad4  [32-bit] Ammo
//          +0x5ae8  [32-bit] Shots Left
//          +0x5a90  [32-bit] Hits Taken
// $562A0C: [PAL][Bit Flag {32-bit}] bit 0 => Is Title Menu Displayed (Preferred)
//          bit 0 = 0 => In-game
//          bit 0 = 1 => Title Menu
// $562A20: [PAL][32-bit Pointer{1}] --> [??-byte Struct] Main_HUDController
//          - Identical pointer{1} at $0x7a0778 (Prefer using this one as it is closer to the Global Pointer)
//          
//          +0x2C - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] AmmoCounter_HUDController
//          [Struct Definition]][??-byte] AmmoCounter_HUDController
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - Controls only ammo HUD display in the bottom-left
//          |
//          | +0x14 - [32-bit] Equipped Weapon - Reserve Ammo
//          | | - Max properly displayable value on UI is 0x3e7 (=999)
//          | | - This value counts the ammo inside the gun as well
//          | | - Functional values on ammunition at $0x7638b8
//          |
//          | +0x8 - [8-bit {32-bit}] Equipped Secondary Pistol - Loaded Ammunition
//          | | - This value is only functional when dual wielding pistols, this controls the ammo counter behind the main ammo counter
//          |
//          | +0x1C - [8-bit {32-bit}] Equipped Weapon - Loaded Ammunition
//          | | - Both of these values control the UI display
//          | | - Functional ammunition per gun is stored in an array (refer to $...)
//          |
//          | +0x28 - [8-bit {32-bit}] Equipped Weapon - Loaded Ammunition (copy of abpve)
//          
//          +0x587C - [32-bit] Cash/Bounty
//          | - Stored as a signed integer, max properly displayable value on the HUD is 0xF423F (=999 999)
//          
//          +0x5880 - [32-bit] Cash Awarded for Kills
//          +0x5884 - [32-bit] Combo (= Cash Awarded for Hitting Targets)
//          
//          +0x5E0C - [32-bit Pointer{2}] --(+0x0)--> [??-byte Struct] SpecialMeterGauge_Controller
//          [Struct Definition]][??-byte] SpecialMeterGauge_Controller
//          |''''''''''''''''''''''''''''''''''''''''''''''''''
//          | - Controls both the HUD display and the underlying logic for the special meter
//          |
//          | +0x0 - [32-bit Float] Special Meter Gauge
//          | | - Special actions such as deadeye or a special move depending on selected showdown character
//          |
//          | +0x4 - [32-bit Float] Special Meter Max Gauge
//          | | - This value, rounded down to the nearest whole number, equals the number of special meter bars displayed (e.g., 3.456 --> 3 bars)
//          | | - Each special action costs 1 full bar
// $6B0808: [PAL][7-byte+ ASCII {Variable Size}] Area_ID
//          - This value stores the Area_ID for the current map/level
//          - Be wary to check only the necessary bytes to check the Area_ID, don't count the following bytes as there's some filler data stored (eg. )
//          
//          # Area_IDs (list incomplete)
//          |''''''''''''''''''''''''''
//          | default => Intermittent loading screen (= screen before the MAIN Loading screen, where the protagonist twirls his pistols around) -> some sort of value between switching Area_IDs
//          | lvl_perf => Chapter 1 - Bull's Eye - Intro with Red Jr.
//          | lvl_hng => Chapter 2 - Bounty Hunter - Bounty for Bloody Tom
//          | lvl_sher => Chapter 3 - Ugly Streetfight - Bounty for Ugly Chris
//          | lvl_traincar => Chapter 4 - The Traincar - Red has showdown with train robber inside traincar
//          | lvl_traingood => Chapter 5 - Railroaded - Red fighting bandits on top of moving train
// $6B18B4: [PAL][1024-byte ASCII Field] ShowdownMode_ScoreboardDisplay_Text
//          =========================================
//          @Fixed Memory Location
//          - The data stored in this ASCII Field is used in the display of the showdown mode scoreboard
//          - ASCII Field only updates/should be used when the scoreboard is displayed, otherwise these 1024-bytes may in use by other data
//          - Dynamic number values (eg. Bounty, Shots missed) are calculated or copied from data stored at $0x7638b8
//          - Changing these values will update the corresponding text on the scoreboard
// $6B1A30: [PAL][96-byte ASCII Field] Player_Stats - Player 1
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          
//          [ASCII Field Definition][96-byte] Player_Stats
//          |'''''''''''''''''''''''''''''''''''''''''
//          | +0x5 - [7-byte ASCII] Bounty/Cash
//          | | - Documentation at $0x6b1a35
//          |
//          | +0xC - [7-byte ASCII] Death Toll (Enemy kill count)
//          | | - Documentation at $0x6b1a3c
//          |
//          | +0x14 - [7-byte ASCII] Damage Taken
//          | | - Documentation at $0x6b1a44
//          |
//          | +0x1C - [3-byte ASCII] Shots Fired
//          | | - Documentation at $0x6b1a4c
//          |
//          | +0x24 - [3-byte ASCII] Shots Missed
//          | | - Documentation at $0x6b1a54
//          |
//          | +0x2D - [7-byte ASCII] Best Combo
//          | | - Documentation at $0x6b1a5d
//          |
//          | +0x34 - [3-byte ASCII] Head Shots
//          | | - Documentation at $0x6b1a64
//          |
//          | +0x3C - [3-byte ASCII] Body Shots
//          | | - Documentation at $0x6b1a6c
//          |
//          | +0x44 - [3-byte ASCII] Arm Shots
//          | | - Documentation at $0x6b1a74
//          |
//          | +0x4C - [3-byte ASCII] Leg Shots
//          | | - Documentation at $0x6b1a7c
//          |
//          | +0x54 - [3-byte ASCII] Back Shots
//          | | - Documentation at $0x6b1a87
//          |
//          | +0x5C - [3-byte ASCII] Melee Hits
//          | | - Documentation at $0x6b1a8c
// $6B1A35: [PAL][7-byte ASCII] Player 1 - Bounty/Cash
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
//          - Preceding [1-byte ASCII] = "$"
// $6B1A3C: [PAL][3-byte ASCII] Player 1 - Death Toll (Enemy kill count)
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A44: [PAL][7-byte ASCII] Player 1 - Damage Taken
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
//          - Succeeding [1-byte ASCII] = "%"
// $6B1A4C: [PAL][3-byte ASCII] Player 1 - Shots Fired
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A54: [PAL][3-byte ASCII] Player 1 - Shots Missed
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A5D: [PAL][7-byte ASCII] Player 1 - Best Combo
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
//          - Preceding [1-byte ASCII] = "$"
// $6B1A64: [PAL][3-byte ASCII] Player 1 - Head Shots
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A6C: [PAL][3-byte ASCII] Player 1 - Body Shots
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A74: [PAL][3-byte ASCII] Player 1 - Arm Shots
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A7C: [PAL][3-byte ASCII] Player 1 - Leg Shots
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A87: [PAL][3-byte ASCII] Player 1 - Back Shots
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A8C: [PAL][3-byte ASCII] Player 1 - Melee Hits
//          @Member of Struct: Player_Stats - Player 1 ($0x6b1a30)
// $6B1A90: [PAL][96-byte ASCII Field] Player_Stats - Player 2
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $6B1AF0: [PAL][96-byte ASCII Field] Player_Stats - Player 3
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $6B1B50: [PAL][96-byte ASCII Field] Player_Stats - Player 4
//          @Member of Struct: ShowdownMode_ScoreboardDisplay_Text ($0x6b18b4)
//          - ASCII Field Definition at $0x6b1a30
// $7405CD: [PAL][27-byte Bitset] Shared_Unlocks
//          @Fixed Memory Location. Although pointed to by $0x7448a0
//          - This bitset handles unlocks for showdown characters, showdown maps and journal pages
//          
//          [PAL][19-byte Bitset] JournalPage_Unlocks
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cd
//          - This bitset handles the unlocks for journal pages
//          
//          [PAL][Bit Flags] @Byte1 in Bitset: JournalPage_Unlocks $0x7405cd
//          bits [0-1] => /
//          bit 2 => Outlaws in Twelve States - Smiley Fawler
//          bit 3 => Outlaws in Twelve States - Bandito
//          bit 4 => Heroes of the Frontier - Annie
//          bit 5 => Ranged Weapons - Bayonet Rifle
//          bit 6 => Wanted Dead or Alive - Dan
//          bit 7 => Heroes of the Frontier - Buffalo
// $7405CE: [PAL][Bit Flags] @Byte2 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Outlaws in Twelve States - Cooper
//          bit 1 => Citizens of the Wilderniss - Black Elk Tribe
//          bit 2 => Wanted Dead or Alive - Mr. Black
//          bit 3 => Good People of Brimstone - Cheryl-Lynn
//          bit 4 => Wanted Dead or Alive - Rico Pedrosa
//          bit 5 => Wanted Dead or Alive - Roberto Pedrosa
//          bit 6 => Prof. Perry's Peculiarities - Asada
//          bit 7 => Ranged Weapons - Breech Loader
// $7405CF: [PAL][Bit Flags] @Byte3 in Bitset: JournalPage_ShowdownMap_Unlocks $0x7405cd
//          bit 0 => Protectors of Brimstone - Sergeant Marquez
//          bit 1 => Citizens of the Wilderniss - Fred Kenyon
//          bit 2 => /
//          bit 3 => Wanted Dead or Alive - Bad Bessie
//          bit 4 => Prof. Perry's Peculiarities - Clyde Slade
//          bit 5 => Citizens of the Wilderniss - Running Moon
//          bit 6 => Ugly Chris Gang - Chicken
//          bit 7 => Citizens of the Wilderniss - Sheriff O'Grady
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
//          bit 4 => Citizens of the Wilderniss - Katie O'Grady
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
//          bit 7 => Citizens of the Wilderniss - Grizzly
// $7405D7: [PAL][Bit Flags] @Byte11 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Outlaws in Twelve States - Smitty
//          bit 1 => Outlaws in Twelve States - Juan "Loco" Sanchez
//          bit 2 => Citizens of the Wilderniss - Blind Willy Wilson
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
//          bit 4 => Citizens of the Wilderniss - Red Wolf Tribe
//          bit 5 => Ranged Weapons - Repeater Rifle
//          bit 6 => Side Arms - Revolver
//          bit 7 => Outlaws in Twelve States - Jethro Greensleves
// $7405DB: [PAL][Bit Flags] @Byte15 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Prof. Perry's Peculiarities - Atlas Jones
//          bit 1 => Renegade Army - Lieutenant Cleu
//          bit 2 => /
//          bit 3 => Ranged Weapons - Sawn Off
//          bit 4 => Citizens of the Wilderniss - Gabby Brennan
//          bit 5 => Side Arms - Scorpion
//          bit 6 => Renegade Army - Private Hanson
//          bit 7 => Protectors of Brimstone - Rat Chavez
// $7405DC: [PAL][Bit Flags] @Byte16 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Protectors of Brimstone - Mad Dog Jones
//          bit 1 => Protectors of Brimstone - The Cornet Brothers
//          bit 2 => Protectors of Brimstone - Jason Cornet
//          bit 3 => Renegade Army - Captain Bufias
//          bit 4 => Citizens of the Wilderniss - Curly Shaw
//          bit 5 => Side Arms - Six Shooter
//          bit 6 => Thrown Weapons - Snake Oil
//          bit 7 => Outlaws in Twelve States - Jacques
// $7405DD: [PAL][Bit Flags] @Byte17 in Bitset: JournalPage_Unlocks $0x7405cd
//          bit 0 => Heroes of the Frontier - Red
//          bit 1 => Outlaws in Twelve States - Sidney "Sissy" Fess
//          bit 2 => Wanted Dead or Alive - Longhorn Luke
//          bit 3 => Wanted Dead or Alive - Holstein Hal
//          bit 4 => Wanted Dead or Alive - Sam
//          bit 5 => Citizens of the Wilderniss - Hank Pullman
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
// $7405DF: [PAL][3-byte Bitset] ShowdownMap_Unlocks (13 total)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cd
//          - This bitset handles the unlocks for showdown maps
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
// $7405E1: [PAL][7-byte Bitset] ShowdownCharacter_Unlocks (48 total)
//          @Sub-bitset in Bitset: Shared_Unlocks $0x7405cd
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
// $740844: [PAL][7-byte ASCII {Variable Size}] Previous Area_ID
//          - Area_ID from the previous area/map/zone is stored here
//          - This value changes on new area load
//          - IDs listed at $0x6b0808
// $742118: [8bit] save file id
// $742158: [32bit] pointer to progress stats
//          
//          +0x290 = [32bit] maps completed in save file
//          starts at 5 and increment by 1 with each map completed /*  also this need more investigation at higher up levels to figure out how this address handles numbers over F i have seen that the max it can get is F but it increases a nearby 8bit when full ? */
// $744898: [PAL][8-bit {32-bit}] Selected Player_Profile
//          - Value range [0x0-0x5], there's a total of 6 player profile slots
//          - Each Player_Profile saves its own story progression and Player_Profile_Unlocks (refer to $0x7448d8)
// $7448A0: [PAL][32-bit Pointer]
//          +0x25 - [27-byte Bitset] Shared_Unlocks
//          | - Documentation at $0x7405cd
// $7448D8: [PAL][32-bit Pointer]
//          +0x0 - [2840-byte Struct] Player_Profile_Data
//          - This data correlates to various actions/flags that is saved throughout the story campaign
//          - This data is only updated when the save menu is displayed in-game OR loaded on game startup (specifically: loading screen after selecting language)
//          - This is data stored to a specific Player_Profile
//          
//          [Struct Definition][2840-byte] Player_Profile_Data
//          |''''''''''''''''''''''''''''''''''''''''''''
//          | +0xC - [32-byte Bitset] Player_Profile_Unlocks
//          | | - This bitset is only updated when the save menu is shown in-game, it copies the bitset Player_Profile_Unlocks ($0x763070) on update
//          | | - This bitset handles unlocks of bought items, weapons, unlocked showdown characters, showdown maps and journal pages
//          | | - Unlocks are achieved by buying certain items, achieving certain goals in specific missions (eg. achieve excellent rating) or just completion of a mission
//          | | - Once some of these unlocks have been achieved for the first time, they will update the Shared_Unlocks bitset ($0x7405cd) on save
// $74A34D: [PAL][6-byte ASCII {Variable Size}] Video File Name ID - NTSC Mode
//          - Preceding [15-byte ASCII] = "cdrom0:\/pss/"
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
// $763070: [PAL][32-bit Pointer]
//          +0x5C8 - [32-byte Bitset] Player_Profile_Unlocks (Preferred)
//          | - This bitset handles unlocks for journal pages, showdown characters and showdown stages for the current Player_Profile
//          | - Pointer becomes functional once the first mission is played in story mode. Or when the player has a Player_Profile tha
//          | - This bitset is updated whenever something is unlocked when in-game
// $7638B8: [PAL][64-byte Array] List of [(2x-4x) Showdown_Player_Data]
//          - This array is only functional during a showdown match
//          - Minimum 2 players (Player 1 + another); Maximum 4 players
//          - Player 1 is always the first [Showdown_Player_Data] struct in the array
//          
//          { [Struct Definition][16-byte] Showdown_Player_Data
//          |'''''''''''''''''''''''''''''
//          | +0x0 - [32-bit Pointer{1}] --(+0x0)--> [2512-byte Struct] Showdown_Player_Data_A
//          |
//          | +0x4 - [32-bit Pointer{1}] --(+0x0)--> [1312-byte Struct] Showdown_Player_Data_B
//          | { [Struct Definition][1312-byte] Showdown_Player_Data_B
//          | |'''''''''''''''''''''''''''''''''''''
//          | | +0x18 - [32-bit Pointer{2}]
//          | | .+0x80 - [32-bit Pointer{3}] --(+0x0)--> [176-byte Struct] Weapon_Handler_Object
//          | | .| - Struct Definition below
//          | |
//          | | +0x28C - [32-byte Bitset] Might be correlated to weapon pickups or power ups?
//          | |
//          | | +0x30 - [32-bit Pointer{2}] --(+0x0)--> [3696-byte Struct] Showdown_Player_Stats
//          | | | - Contains stats used for the scoreboard as well as some other misc unused stats
//          | | | - Struct Definition below
//          |
//          | +0x8 - [32-bit Pointer{1}] --(+0x0)--> [464-byte Struct] Showdown_Player_Data_C
//          | { [Struct Definition][464-byte] Showdown_Player_Data_C
//          | |'''''''''''''''''''''''''''''''''''''
//          | | +0x18 - [32-bit Pointer{2}]
//          | | | +0x10 - [32-bit Float] Player HP
//          | | | +0x14 - [32-bit Float] Player Max HP
//          | |
//          | | +0x94 - [32-bit Pointer{2}]
//          | | .+0x10 - [8-bit {32-bit}] Amount of Guns in Inventory
//          | |
//          | | +0x168 - [32-bit Pointer{2}]
//          | | .+0xF4 - [32-bit Pointer{3}] --(+0x0)--> [688-byte Struct] Ammunition_Inventory
//          | | .| - This struct stores the reserve ammunition, be wary the ammunition counter on the HUD ($0x562a20) also counts the ammo loaded inside the gun, this data does not
//          |
//          | +0xC - [32-bit Pointer{1}] Showdown_Player_Data_D
//          | | - This pointer is only functional for Player 1; This pointer is non-existent (= 0x0) for other Players
//          
//          { [Struct Definition][176-byte] Weapon_Handler_Object
//          |'''''''''''''''''''''''''''''''''''''
//          | +0x44 - [8-bit {32-bit}] Spawn Weapon_ID
//          | | - This value decides which weapon is equipped by default on (re)spawn
//          | | - Weapon_IDs listed below
//          |
//          | +0x48 - [8-bit {32-bit}] Equipped Weapon_ID
//          | | - Weapon_IDs are equal to the index of the weapon inside the Weapon_Data array (see pointer chain below)
//          |
//          | +0x20 - [32-bit Pointer{1}]
//          | .+0x0 - [32-bit Pointer{2}]
//          | ..+0x4 - [32-bit Pointer{3}]
//          | ...+0x0 - [440-byte Array] List of [(55x) 32-bit Pointer{4}] --(+0x0)--> [64-byte Struct] Weapon_Data
//          | ...| - Struct Definition Weapon_Data below
//          
//          { [Struct Definition][64-byte] Weapon_Data
//          |'''''''''''''''''''''''''''''''''''''
//          | - Each weapon has [Weapon_Data] structure inside this array
//          | - There's about 55 weapons in the list
//          | - Changing ammunition stats here work, although UI needs to be handled through $0x562a20
//          |
//          | +0x18 - [8-bit Bitfield] Weapon State
//          | | 0x1 => Idle
//          | | 0x3 => Firing
//          | | 0x4 => Reloading
//          |
//          | +0x20 - [8-bit {32-bit}] Maximum Ammunition Capacity (functional)
//          | +0x24 - [8-bit {32-bit}] Current Loaded Ammunition (functional)
//          |
//          | +0x28 - [32-bit Pointer] --(+0x0)--> [12-byte?? Struct] Weapon_Ammunition
//          | { [Struct Definition][12-byte??] Weapon_Ammunition
//          | |'''''''''''''''''''''''''''''''''''''
//          | | - Some ammunition might be shared between weapons
//          | | - Ammunition values here don't count the ammo loaded inside the gun, ammunition count on HUD does (refer to $0x562a20)
//          | |
//          | | +0x4 - [8-bit {32-bit}] Reserve Ammuniton on Spawn
//          | | | - Ammunition shown on the HUD always has counts
//          | | +0x8 - [8-bit {32-bit}] Current Reserve Ammuniton
//          
//          { [Struct Definition][3696-byte] Showdown_Player_Stats
//          |''''''''''''''''''''''''''''''''''''''
//          | - Data stored here is dynamically updated during gameplay
//          | - Most 32-bit values stored are signed integers, but the scoreboard only displays a limited amount of characters (refer to $0x6b18b4)
//          |
//          | +0x0,+0x494 - [(2x) 32-bit] Shots Fired
//          | | - Depending on weapon fired, this count can go up by more than 1 on each shot. (eg. Escopeta shotgun shoots 7 projectiles per shot, thus increases this value by 7)
//          |
//          | +0x418 - [32-bit] Death Count
//          | +0x490 - [32-bit] Bounty/Cash
//          | | - Copies value stored via pointer at $0x562a20
//          |
//          | +0x49C - [32-bit] Arm Shots
//          | +0x4A0 - [32-bit] Body Shots
//          | +0x4A4 - [32-bit] Head Shots
//          | +0x4A8 - [32-bit] Leg Shots
//          | +0x4B4 - [32-bit] Melee Hits
//          | +0x4B8 - [32-bit] Back Shots
//          
//          # Equipped_Weapon_IDs (list incomplete)
//          |''''''''''''''''
//          | 0x3 => Old Pistol
//          | 0x9 => Widowmaker (Pistol)
//          | 0xb => Scorpion (Pistol)
//          | 0x12 => Owl Rifle
//          | 0x14 => Repeating Rifle
//          | 0x18 => Six Shooter (Pistol)
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
// $7638F8: [PAL][8-bit {32-bit}] Showdown Mode Playercount
//          - Value range [0x2-0x4], minimum 2 players, max 4 players
// $7A0620: [PAL][7-byte ASCII {Variable Size}] Area_ID to Load
//          - The Area_ID that needs to be loaded is stored here
//          - IDs listed at $0x6b0808
// $7A0664: [PAL][8-bit {32-bit}] Display Language
//          - Changing this value at runtime, will change the display language on loading
//          0x0 => en
//          0x1 => es
//          0x2 => fr
//          0x3 => de
//          0x4 => it
// $7A0778: [PAL][32-bit Pointer] --> Main HUD Controller
//          - Identical to pointer{1} at $0x562a20
// $7A09C0: [PAL][32-bit Pointer] --> [32-byte Bitset] Player_Profile_Unlocks (alt)
//          - Identical pointer at $0x763070
// $D17E8D: [8-bit] Main Menu Check
//          0x07e - Main Menu (Verified Always)
// $E36118: could be important
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
