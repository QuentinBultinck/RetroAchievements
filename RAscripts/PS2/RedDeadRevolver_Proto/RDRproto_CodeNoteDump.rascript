// ~Prototype~ Red Dead Revolver
// #ID = 32806

// $4215A0: [NTSCU][32-bit (base) Pointer:MenuData] -> [Struct:MenuData]
//          - This pointer points to the currently active/displayed menu
//          - Depending on which menu is displayed [Struct:MenuData] looks different (refer to MenuIDs)
//          
//          +0x14 - [Variable Size ASCII:MenuID]
//          | - MenuIDs listed below
//          
//          +0x28 - [bit0 BitFlag:IsMenuDisplayed |32-bit]
//          | 0 => Menu is not displayed
//          | 1 => Menu is displayed
//          
//          +0x34 - [32-bit (layer-1) Pointer]
//          .+0x1F0 - [Lower4:HighlightedMenuItem_SelectionMenu |32-bit]
//          .| - This value is only valid when the SelectionMenu is displayed
//          .| - 0x0 is always the top most MenuItem, 0x1 is the one below the top most MenuItem and so on...
//          .
//          .+0x3128 - [Lower4:HighlightedMenuItem_ShopMenu |32-bit]
//          .| - This value is only valid when the ShopMenu is displayed
//          .| - 0x0 is always the top most MenuItem, 0x1 is the one below the top most MenuItem and so on...
//          
//          +0x144 - [Lower4:HighlightedMenuItem_A |32-bit]
//          | - This value is only valid for the following Menus: LevelSelectionMenu, PauseMenu...?
//          | - 0x0 is always the top most MenuItem, 0x1 is the one below the top most MenuItem and so on...
//          
//          +0x5E0 - [Variable Size ASCII:SelectionMenuText_Top]
//          | - This value determines what text is displayed on the top SelectableMenuItem. Where [Lower4:HighlightedMenuItem] = 0x0
//          | "Basic_Menu" => Basic Training
//          | "Move_Menu" => Movement Training
//          
//          +0x620 - [Variable Size ASCII:SelectionMenuText_Bottom]
//          | - This value determines what text is displayed on the bottom SelectableMenuItem. Where [Lower4:HighlightedMenuItem] = 0x1
//          | "Shooting_Gallery" => Shooting Challenge
//          | "Shoot_Menu" => Weapon Training
//          
//          
//          # MenuIDs
//          |''''''''''
//          |----Main Menus----
//          | "main" => MainMenu
//          | "1000" => LevelSelectionMenu
//          | "2010" => MultiplayerPlayerSetupMenu (select how many HumanPlayers and how many CPUplayers)
//          | "2000" => MultiplayerCharacterSelectMenu (select Character + weapons)
//          |
//          |----In-Game Menus----
//          | "pause" => PauseMenu
//          | "menupage" => SelectionMenu (used in Training Stage, lvl_tng)
//          | "shop" => ShopMenu (used in Title Stage, lvl_hng)
//          '
// $4215DC: [NTSCU][3-byte ASCII:CharacterModelID-Player1(alt2)]
//          - Prefer using [ASCII:CharacterModelID-Player1(preferred)] at $0x912954
//          - This is valid for Singleplayer & Multiplayer
// $4215F8: [NTSCU][Variable Size ASCII:AIsetting-Player1 |16-byte??]
//          - Practically this can be used to check if a MultiplayerPlayer is AI controlled or Human controlled
//          - AIsetting examples: "Default_Bot", "Pig_Bot", ...
//          - MultiplayerPlayer 1 is always Human Controlled
//          
//          [4-byte ASCII] Zeroed out (0x0) => Human controlled MultiplayerPlayer
//          [4-byte ASCII] Any other value => AI controlled MultiplayerPlayer
// $421628: [NTSCU][3-byte ASCII:CharacterModelID-Player2(alt2)]
//          - Prefer using [ASCII:CharacterModelID-Player2(preferred)] at $0x9129bc
//          - This is only valid when in Multiplayer
// $421644: [NTSCU][Variable Size ASCII:AIsetting-Player2 |16-byte??]
//          - Documentation at $0x4215f8
// $421674: [NTSCU][3-byte ASCII:CharacterModelID-Player3(alt2)]
//          - Prefer using [ASCII:CharacterModelID-Player3(preferred)] at $0x912a24
//          - This is only valid when in Multiplayer
// $421690: [NTSCU][Variable Size ASCII:AIsetting-Player3 |16-byte??]
//          - Documentation at $0x4215f8
// $4216C0: [NTSCU][3-byte ASCII:CharacterModelID-Player4(alt2)]
//          - Prefer using [ASCII:CharacterModelID-Player4(preferred)] at $0x912a8c
//          - This is only valid when in Multiplayer
// $4216DC: [NTSCU][Variable Size ASCII:AIsetting-Player4 |16-byte??]
//          - Documentation at $0x4215f8
// $421708: [NTSCU][Variable Size ASCII:LevelID(alt1)]
//          - Prefer using [ASCII:LevelID(preferred)] at $0x9128e8
// $421720: [NTSCU][Lower4:HumanPlayerCount |32-bit]
//          Range [0x1 --- 0x4]
// $4217D0: [NTSCU][3-byte ASCII:CharacterModelID-Player1(alt1)]
//          - Prefer using [ASCII:CharacterModelID-Player2(preferred)] at $0x9129bc
//          - This is valid for Singleplayer & Multiplayer
// $421850: [NTSCU][32-bit (base) Pointer:PlayerData-Player1] -> [Struct:PlayerData]
//          - This pointer is always valid (SinglePlayer & Multiplayer)
//          
//          +0x14 - [32-bit (layer-1) Pointer]
//          |+0xC - [Float:PlayerHealth |32-bit]
//          
//          +0x70 - [32-bit (layer-1) Pointer:PlayerData_L1-70]
//          | - This pointer is only valid when the player is on Horseback
//          | - This pointer is zeroed out (0x0) when not on Horseback
//          .+0x8 - [32-bit (layer-2) Pointer]
//          ..+0xC - [32-bit (layer-3) Pointer]
//          ...+0x90 - [16-byte Struct(Coordinates):PlayerOnHorsebackLocation]
//          ...| - Definition of [Struct:Coordinates] below
//          
//          +0x130 - [32-bit:Money_MPkills]
//          | - In SinglePlayer: this value regulates the Player's money as cents (refering to the Cash display)
//          | - In SinglePlayer: when this value > 0x1F3 (499, $49.09), then the message, "You Win!!!", is displayed + player gains insane amount of money for free. After a few seconds the Level resets (just like a Reset via PauseMenu)
//          |
//          | - In Multiplayer: this value regulates the Player's killCount (refering to the sheriff badge count display, when killing a player)
//          | - In Multiplayer: Once this value hits 0x2, the Player/team wins the match. After a few seconds the match resets.
//          
//          +0x134 - [bit0 BitFlag:IsPlayerOnHorseback |32-bit]
//          
//          +0x13C - [32-bit (layer-1) Pointer]
//          .+0xC - [32-bit (layer-2) Pointer]
//          ..+0x90 - [16-byte Struct(Coordinates):PlayerLocation]
//          ..| - Definition of [Struct:Coordinates] below
//          .
//          .+0x64 - [32-bit (layer-2) Pointer]
//          ..+0x134 - [32-bit (layer-3) Pointer] -> [Struct:CharacterAnimationData]
//          ..
//          ..+0x10 - [Float:AnimationKeyFrame(functional)]
//          ..| - This float represents a specific point in the animation timeline
//          ..| - FloatRange [0.0 --- 0.999]: 0.0 is start of animation; 0.999 is end of animation
//          ..+0x14 - [Float:AnimationKeyFrame(copy)]
//          ..| - This float represents a specific point in the animation timeline, but copies float above
//          ..
//          ..+0x18 - [32-bit (layer-4) Pointer]
//          ...+0x0 - [32-bit (layer-5) Pointer]
//          ....+0x0 - [32-bit (layer-6) Pointer]
//          .....+0x0 - [Variable Size ASCII:Active_CharacterAnimationID]
//          .....| - Pointer chain is only valid when non-repeating CharacterAnimation is being played
//          .....| - List of CharacterAnimationIDs below
//          
//          +0x170 - [32-bit (layer-1) Pointer] -> [Struct:ShootingStats]
//          | - Definition of [Struct:ShootingStats] below
//          
//          +0x208 - [bit0 BitFlag:IsAimingModeActive(preferred) |32-bit]
//          +0x220 - [bit0 BitFlag:IsAimingModeActive(alt1) |32-bit]
//          +0x224 - [bit0 BitFlag:IsAimingModeActive(alt1) |32-bit]
//          
//          
//          [Definition Struct:Coordinates |16-byte]
//          |''''''''''''''''''''''''''''''''
//          |+0x0 - [32-bit Float:W_Component]
//          |¨| - This is perspective divide component. It has a role in perspective projection, where the final coordinates are obtained by dividing X, Y, Z by W.
//          |+0x4 - [32-bit Float:Y_Coordinate]
//          |+0x8 - [32-bit Float:Z_Coordinate]
//          |+0xC - [32-bit Float:X_Coordinate]
//          '
//          
//          [Definition Struct:ShootingStats |??-byte]
//          |''''''''''''''''''
//          | - These offsets are only functional when in SinglePlayer
//          | - These stats reset to 0x0 when PauseMenu->Reset OR when dying
//          | - The pointed to data is different depending on SinglePlayer or Multiplayer
//          | - For some reason While in Multiplayer ShootingStats are only saved ShotsFired, any other stats are not saved. Kills are saved somewhere else $0x421868.
//          | - Total Shots Hit: [32-bit:ShotsHitBody] + [32-bit:ShotsHitHead]
//          |
//          |+0x0 - [32-bit:ShotsFired]
//          |+0x2C - [32-bit:ShotsHitBody]
//          || - Only counts hits on the body, NOT headshots
//          |+0x30 - [32-bit:ShotsHitHead]
//          || - Counts headshot-kills & normal headshots
//          |+0x5C - [32-bit:Kills]
//          '
//          
//          # CharacterAnimationID
//          |(only lists IDs useful for achievement logic)
//          |''''''''''''''''''''
//          | "red_stn_idl_11" => Tipping hat (Press and hold X or R1 whilst standing still)
//          | "red_stn_idl_12" => Talk animation (Press X near and facing friendly NPC)
//          | "red_upp_jump" => Jump whilst standing still
//          | "red_for_jump" => Jump whilst moving forward
//          | "red_fnc_pst_vlt => Fence vault
//          | "red_rgt_dge" => Dodge (Press X or R1 whilst walking)
//          '
// $421868: [NTSCU][8-bit:Showdown_Kills-Player1]
//          - This value counts how many kills the player has achieved in the Showdown Match
//          - When this hits 0x2, this Player/Team wins the Showdown Match, after a few seconds the match resets.
// $421884: [NTSCU][3-byte ASCII:CharacterModelID-Player2(alt1)]
//          - Prefer using [ASCII:CharacterModelID-Player2(preferred)] at $0x9129bc
//          - This is only valid when in Multiplayer
// $421904: [NTSCU][32-bit (base) Pointer:PlayerData-Player2] -> [Struct:PlayerData]
//          - This pointer is only valid when in Multiplayer
//          - This pointer points to data for Player 2
//          - Pointer defined at $0x421850
// $42191C: [NTSCU][8-bit:Showdown_Kills-Player2]
//          - Documentation at $0x421868
// $421938: [NTSCU][3-byte ASCII:CharacterModelID-Player3(alt1)]
//          - Prefer using [ASCII:CharacterModelID-Player3(preferred)] at $0x912a24
//          - This is only valid when in Multiplayer
// $4219B8: [NTSCU][32-bit (base) Pointer:PlayerData-Player3] -> [Struct:PlayerData]
//          - This pointer is only valid when in Multiplayer
//          - This pointer points to data for Player 3
//          - Pointer defined at $0x421850
// $4219D0: [NTSCU][8-bit:Showdown_Kills-Player3]
//          - Documentation at $0x421868
// $4219EC: [NTSCU][3-byte ASCII:CharacterModelID-Player4(alt1)]
//          - Prefer using [ASCII:CharacterModelID-Player4(preferred)] at $0x912a8c
//          - This is only valid when in Multiplayer
// $421A6C: [NTSCU][32-bit (base) Pointer:PlayerData-Player4] -> [Struct:PlayerData]
//          - This pointer is only valid when in Multiplayer
//          - This pointer points to data for Player 4
//          - Pointer defined at $0x421850
// $421A84: [NTSCU][8-bit:Showdown_Kills-Player4]
//          - Documentation at $0x421868
// $421DAC: [NTSCU][32-bit (base) Pointer:NPCdata]
//          - This points to some sort of linked list, Each ListItem is [Struct:NPCdata]
//          - Each Singleplayer Level stores its own predetermined list of NPCdata. The list is not dynamic, all NPCs are inside this list at all times during the Level
//          - Practically this can be used to access NPC related data (eg. coords, NPCname...) as well as NPCevents. NPCevents (eg. Cutscenes) are accessible via [Struct:NPCdata]
//          
//          [Definition Struct:NPCdata |??-byte]
//          |'''''''''''''''''
//          |+0x4 - [32-bit (layer-1) Pointer]
//          |.
//          |.+0x8 - [32-bit (layer-2) Pointer]
//          |.| - This pointer is zeroed out when this NPC is inactive (not inside the game world/Level; "dead" or yet to spawn)
//          |..+0xC - [32-bit (layer-3) Pointer]
//          |...+0x90 - [Struct(Coordinates):NPClocation(functional)]
//          |...| - These are the functional coordinates. Changing these, changes the NPC's position in game world.
//          |.
//          |.+0x40 - [Struct(Coordinates):NPClocation(copy)]
//          |.
//          |.+0x198 - [Variable Size ASCII:NPCname]
//          |.| - This is the name which is displayed above the NPC on death
//          |.
//          |.+0x1EC - [3-byte ASCII:CharacterModelID]
//          |.| - This IDs the 3D CharacterModel
//          |.
//          |.+0x22C - [Variable Size ASCII:NPCdataID(alt)]
//          |.| - Exact copy of [ASCII:NPCdataID(preferred)] below
//          |.
//          |.+0x26C - [Variable Size ASCII:NPCtype]
//          |.| - eg. "MidBoss", "NPCs",...
//          |
//          |
//          |+0x60 - [Variable Size ASCII:NPCdataID(preferred)]
//          || - eg. "Perf75_PlayerAI",
//          || - eg. "Perf75_Mom", "Perf75_Jin", "Perf75_Bil",...
//          |
//          |+0x188 - [32-bit (Layer-1) Pointer:NextNode_NPCdata] -> [Struct:NPCdata]
//          '
//          
//          __________TrainingStage__________
//          [32-bit (base) Pointer:NPCdata.lvl_tng] -> [Struct:NPCdata.PlayerAI_tng]
//          +0x188 - [32-bit (layer-1) Pointer] -> [Struct:NPCdata.Indian_Master]
//          .+0x94 - [32-bit (layer-2) Pointer]
//          ..
//          ..________MovementTraining________
//          ..+0x108 - [32-bit (layer-3) Pointer] -> Movement Training NPCevent Data
//          ..| - This points to data correlating to the "Movement Training"; This training consists of 3 TrainingSections.
//          ..| - After completing the last section "Sneak_and_Creep". "Weapon Training" will start right after that.
//          ...+0xC - [32-bit (layer-4) Pointer]
//          ....
//          ....+0x0 - [8-bit:MovementTrainingState |32-bit]
//          ....| - This value determines the state of the active Training
//          ....| - MovementTrainingStates listed below
//          ....| 0x0 => inactive
//          ....
//          ....+0x4 - [Variable Size ASCII:Active_MovementTrainingSectionID]
//          ....| - This value stores which MovementTrainingSectionID is currently active
//          ....| - When the first byte of this ASCII is "0" (= 0x30) => Training inactive
//          ....| - MovementTrainingSectionIDs listed below
//          ....
//          ....+0x24 - [Float:MovementTrainingTimer |32-bit]
//          ....| - Time in seconds
//          ....| - This starts counting from 0.0 whenever [8-bit:MovementTrainingState] changes
//          ....| - This float stays 0.0 whenever [8-bit:MovementTrainingState] == 0x0
//          ..
//          ..________WeaponTraining________
//          ..+14C - [32-bit (layer-3) Pointer] -> Weapon Training NPCevent Data
//          ..| - This points to data correlating to the "Weapon Training"; This training consists of 6 TrainingSections.
//          ...+0xC - [32-bit (layer-4) Pointer]
//          ....
//          ....+0x0 - [8-bit:WeaponTrainingState |32-bit]
//          ....| - This value determines the state of the active Training
//          ....| - WeaponTrainingStates listed below
//          ....| 0x0 => inactive
//          ....
//          ....+0x4 - [Variable Size ASCII:Active_WeaponTrainingSectionID]
//          ....| - This value stores which WeaponTrainingSectionID is currently active
//          ....| - When the first byte of this ASCII is "0" (= 0x30) => Training inactive
//          ....| - WeaponTrainingSectionID listed below
//          ....
//          ....+0x24 - [Float:WeaponTrainingTimer |32-bit]
//          ....| - Time in seconds
//          ....| - This starts counting from 0.0 whenever [8-bit:WeaponTrainingState] changes
//          ....| - This float stays 0.0 whenever [8-bit:WeaponTrainingState] == 0x0
//          ..
//          ..________ShootingGallery________
//          ..+0x190 - [32-bit (layer-3) Pointer] -> Shooting Gallery NPCevent Data
//          ..| - This points to data correlating to the "Shooting Gallery" also known as "Whack a Mole"
//          ...+0xC - [32-bit (layer-4) Pointer]
//          ....
//          ....+0x0 - [Lower4:ShootingGalleryState |32-bit]
//          ....| - ShootingGalleryStates listed below
//          ....
//          ....+0x4 - [17-byte ASCII:ShootingGalleryNameState]
//          ....| - ShootingGalleryNameStates listed below
//          ....
//          ....+0x24 - [Float:ShootingGalleryTimer |32-bit]
//          ....| - Time in seconds
//          ....| - Starts at 0.0 when ShootingGallery starts; ShootingGallery ends at 60.0
//          
//          # MovementTrainingSectionIDs (string) + MovementTrainingStates (hex)
//          |'''''''''''''''''''''''
//          | "Walk_and_Run" => MovementTrainingSection 1
//          | - [0x1-0x3] => msg. "Use the left control stick or d-pad to move around"
//          | - [0x4-0x6] => msg. "Moving the stick just a little bit will make you walk"
//          | - [0x7-0x9] => msg. "Moving the stick all the way will make you run"
//          | - 0xA => // (seems to be skipped in current FPS)
//          | - [0xB-0xC] => msg. "Move to the circle in front of you"
//          | - 0xD => Task: Player needs to move to circle
//          | - 0xE => Task Complete: Player is in circle
//          | - 0xF => msg. "Good job!" (Walk_and_Run CLEARED)
//          |
//          | "Jump_and_Grab" => MovementTrainingSection 2
//          | - [0x1-0x2] => msg. "Pressing O will cause you to jump"
//          | - ...
//          | - 0x11 => Task: Player needs to grab a ledge and vault it
//          | - 0x12 => Task Complete: Player has vaulted on ledge
//          | - 0x13 => Cinematic: PlayerCharacter jumps of rock
//          | - 0x14 => msg. "Good job!" (Jump_and_Grab CLEARED)
//          |
//          | "Sneak_and_Creep" => MovementTrainingSection 3
//          | - 0x1 => ??
//          | - 0x2 => msg. "Press forward while next to a wall or large object to sneak on it"
//          | - ...
//          | - 0x1A => msg. "Good, Now press L1 AND Fire to spin out and shoot!"
//          | - ...
//          | - 0x1F => msg. "Good job!" (Sneak_and_Creep CLEARED)(End of MovementTraining)
//          '
//          # WeaponTrainingSectionIDs (string) + WeaponTrainingStates (hex)
//          |'''''''''''''''''''''''
//          | "Camera_Movement" => WeaponTrainingSection 1
//          | - [0x1-0x3] => msg. "Press left or right on the right analog stick to move the camera"
//          | - ...
//          | - 0x8 => msg. "Great! You can also look around while moving. Try it sometime" (Camera_Movement CLEARED)
//          |
//          | "Draw_And_Holster" => WeaponTrainingSection 2
//          | - 0x0 => msg. "If you go to the circle by the river I'll teach you how to shoot." (yes, starts at 0x0)
//          | - ...
//          | - 0x7 => Task: Player needs to go into battle mode/draw gun
//          | - 0x8 => Task Complete: Player has drawn gun (Draw_And_Holster CLEARED) (This state is skipped when holding the Draw button)
//          |
//          | "Autotarget_Lesson" => WeaponTrainingSection 3
//          | - 0x1 => msg. "If an enemy is onscreen drawing your gun will autotarget it"
//          | - ...
//          | - 0x4 => msg. "Shoot the dummy!"
//          | - 0x5 => camera movement
//          | - 0x6 => Task: Player has to shoot a single dummy
//          | - 0x7 => Task Complete: Player shot the dummy
//          | - 0x8 => msg. "Good job!"
//          | - ...
//          | - 0x10 => Task: Player has to shoot multiple dummies
//          | - [0x11-0x12] => Task Complete: Player has shot multiple dummies (Autotarget_Lesson CLEARED)
//          |
//          | "Manual_Target" => WeaponTrainingSection 4
//          | - 0x1 => msg. "Use manual aiming to fire at different body parts"
//          | - ...
//          | - 0x6 => msg. "Good job! Always remember to aim at the head for the most powerful shots! (Manual_Target CLEARED)
//          |
//          | "Change_Weapon" => WeaponTrainingSection 5
//          | - ...
//          |
//          | "Rapid_Fire" => WeaponTrainingSection 6
//          | - ...
//          | - 0x16 => You are now ready for the shooting challenge! (Rapid_Fire CLEARED)(End of WeaponTraining)
//          '
//          # ShootingGalleryState (hex) + ShootingGalleryNameState (string)
//          |'''''''''''''''''''
//          |----Hex----
//          | 0x0 => ShootingGallery inactive
//          | [0x1-0x2] => ShootingGallery setting up (Transitioning phases)
//          | 0x3 => msg. "Shoot the dummies!"
//          | 0x4 => Camera movement
//          | 0x5 => Task: Player can now shoot the dummies
//          | [0x6-0x7] => msg. "Stop shooting Time is up!" (ShootingGallery Fail State)(End of ShootingGallery)
//          |
//          |----String----
//          | "0tart_Whak_A_Mole" => ShootingGallery inactive. Where [Lower4:ShootingGalleryState] == 0x0
//          | "Start_Whak_A_Mole" => ShootingGallery active. Where [Lower4:ShootingGalleryState] > 0x0
//          | "Whack_A_Mole_Win" => msg. "Good job!" (ShootingGallery Win State)(End of ShootingGallery)
//          '
//          
//          __________PrologueStage__________
//          [32-bit (base) Pointer:NPCdata.lvl_perf75] -> [Struct:NPCdata.Perf75_PlayerAI]
//          +0x188 - [32-bit (layer-1) Pointer] -> [Struct:NPCdata.Perf75_Bil]
//          .+0x188 - [32-bit (layer-2) Pointer] -> [Struct:NPCdata.Perf75_Jin]
//          ..
//          ..+0x94 - [32-bit (layer-3) Pointer]
//          ...+0x4C0 - [32-bit (layer-4) Pointer]
//          ....+0xC - [32-bit (layer-5) Pointer]
//          .....+0x0 - [20-byte ASCIIFlag(NPCevent):IsJinnieThanksActive]
//          .....| ASCII == "ThankYou2" => Active (Red is talking with Jinnie, his Sister + message "Thank You")
//          .....| ASCII == "0HankYou2" => Inactive
//          ..
//          ..+0x188 - [32-bit (layer-3) Pointer] -> [Struct:NPCdata.Perf75_Mom]
//          ...+0x94 - [32-bit (layer-4) Pointer]
//          ....+0x4C0 - [32-bit (layer-5) Pointer]
//          .....+0xC - [32-bit (layer-6) Pointer]
//          ......+0x0 - [20-byte ASCIIFlag(NPCevent):IsMomThanksActive]
//          ......| ASCII == "Perf75_End_Cinematic" => Active (Mom walks up to Red + message "Thank You")
//          ......| ASCII == "0erf75_End_Cinematic" => Inactive
// $4223F4: [NTSCU][32-bit (base) Pointer:LevelData]
//          - This points to game logic data for a specific Level
//          
//          ________TrainingStage________
//          [32-bit (base) Pointer:LevelData.lvl_tng]
//          +0x90 - [32-bit (layer-1) Pointer]
//          .+0x4 - [32-bit (layer-2) Pointer]
//          ..+0x0 - [32-bit (layer-3) Pointer]
//          ...+0xDC - [32-bit (layer-4) Pointer]
//          ....
//          ....+0x0 - [Lower4:ShootingGalleryState |32-bit]
//          ....| - ShootingGalleryStates listed below
//          ....
//          ....+0x4 - [17-byte ASCII:ShootingGalleryNameState]
//          ....| - ShootingGalleryNameStates listed below
//          ....
//          ....+0x24 - [Float:ShootingGalleryTimer |32-bit]
//          ....| - Time in seconds
//          ....| - Starts at 0.0 when ShootingGallery starts; ShootingGallery ends at 60.0
//          
//          # ShootingGalleryState (hex) + ShootingGalleryNameStates (string)
//          |'''''''''''''''''''
//          |----Hex----
//          | 0x0 => ShootingGallery inactive
//          | [0x1-0x2] => ShootingGallery setting up (Transitioning phases)
//          | 0x3 => MessageDisplay "Shoot the dummies!"
//          | 0x4 => Camera movement (Transitioning phase)
//          | 0x5 => ShootingGallery is active (player can now shoot the dummies)
//          | 0x6 => ShootingGallery ending (Transitioning phase)
//          | 0x7 => MessageDisplay "Stop shooting Time is up!"
//          |
//          |----String----
//          | "0tart_Whak_A_Mole" => ShootingGallery inactive. Where [Lower4:ShootingGalleryState] == 0x0
//          | "Start_Whak_A_Mole" => ShootingGallery active. Where [Lower4:ShootingGalleryState] > 0x0
//          | "Whack_A_Mole_Win" => ShootingGallery Win State
//          '
// $427C80: [NTSCU][32-bit:GameState]
//          0x0 => TitleScreen
//          0xFA => SinglePlayer
//          0xC8 => Multiplayer
// $428BD8: [NTSCU][32-bit (base) Pointer:ShootingStats] -> [Struct:ShootingStats]
//          -- WARNING -- This pointer is only valid for some SinglePlayer Levels, prefer using [Pointer:PlayerData], which always points to this, refer to $0x421850
//          - These stats reset to 0x0 when PauseMenu->Reset OR when dying
//          - The pointed to data is different depending on SinglePlayer or Multiplayer
//          
//          [Definition Struct:ShootingStats.SinglePlayer]
//          |''''''''''''''''''
//          |- These offsets are only functional when in SinglePlayer
//          |
//          |+0xE0 - [32-bit:ShotsFired]
//          |+0x10C - [32-bit:ShotsHitBody]
//          || - Only counts hits on the body, NOT headshots
//          |+0x110 - [32-bit:ShotsHitHead]
//          || - Counts headshot-kills & normal headshots
//          |+0x13C - [32-bit:Kills]
//          '
//          
//          [Definition Struct:ShootingStats.Multiplayer]
//          |''''''''''''''''''
//          | - These offsets are only functional when in Multiplayer
//          | - For some reason MultiplayerPlayers only save ShootingStats for ShotsFired, any other stats are not saved. Kills are saved somewhere else $0x421868.
//          |
//          |+0x14 - [32-bit (layer-1) Pointer]
//          |.+0x0 - [32-bit:ShotsFired-Player1]
//          |.+0x90 - [32-bit:ShotsFired-Player2]
//          |.+0x120 - [32-bit:ShotsFired-Player3]
//          |.+0x1B0 - [32-bit:ShotsFired-Player4]
//          '
// $488238: PlayerInput
// $499878: [NTSCU][3-byte ASCII:SinglePlayerLoaded_CharacterModelID]
//          @SinglePlayer CharacterModel Hack
//          - This value determines which CharacterModel is loaded for all SinglePlayer Levels.
//          - CharacterModelIDs listed at $0x912954
//          
//          InitialValue = "trd"
//          HackValue = "nrd"
// $5F7E20: [NTSCU][Variable Size Array:GameData]
//          - Array is only populated when in-game
//          - Size of this array is dependent on amount of HumanPlayers in-game
//          - This array consists of 2 parts. [Array:PlayerDataPointers] + [Array:GameDataPointers]
//          - Definition of [Array:PlayerDataPointers] below
//          - Definition of [Array:GameDataPointers] below
//          
//          [Definition Array:PlayerDataPointers |Variable Size]
//          |''''''''''''''''''''''''''''''''''''''
//          | - Size of this array is dependent on amount of HumanPlayers in-game
//          | - Each ListItem of this Array = [112-byte Struct:PlayerDataPointers]
//          | - Each active HumanPlayer has 1 [Struct:PlayerDataPointers] inside this array
//          | - Definition of [Struct:PlayerDataPointers] below
//          |
//          |+0x0 - [112-byte Struct:PlayerDataPointers-Player1]
//          || - This struct is always populated (SinglePlayer & Multiplayer)
//          |
//          |+0x112 - [112-byte Struct:PlayerDataPointers-Player2]
//          || - This struct is only populated in Multiplayer with 2 HumanPlayers
//          |
//          |+0x224 - [112-byte Struct:PlayerDataPointers-Player3]
//          || - This struct is only populated in Multiplayer with 3 HumanPlayers
//          |
//          |+0x336 - [112-byte Struct:PlayerDataPointers-Player4]
//          || - This struct is only populated in Multiplayer with 4 HumanPlayers
//          '
//          
//          [Definition Struct:PlayerDataPointers |112-byte]
//          |''''''''''''''''''''''''''''''''''''''
//          | - This struct contains (14x) pointers to various data relating to a HumanPlayer
//          |
//          |+0x4 - [32-bit (layer-1) Pointer] -> [Struct:HUD_AmmoHealth]
//          || - Definition of [Struct:HUD_AmmoHealth] at $0x5f7e24
//          '
//          
//          [Definition Array:GameDataPointers |40-byte]
//          |''''''''''''''''''''''''''''''''''''''
//          | - Contains (5x) pointers to various data related to the Level + Game
//          '
// $5F7E24: [NTSCU][32-bit (base) Pointer:HUD_AmmoHealth-Player1] -> [Struct:HUD_AmmoHealth]
//          @Fixed Memory Location, although this pointer is part of [Variable Size Array:GameData] ($0x5f7e20)
//          - Pointer is only valid when in-game
//          
//          [Definition Struct:HUD_AmmoHealth |532-byte]
//          |''''''''''''''''''''''''''''''''''''''
//          | - This struct controls the UI display in the bottom-left
//          |
//          |+0x74 - [Float:PlayerHealth(display) |32-bit]
//          || - This float regulates how much of the HP bar is filled. Pretty much correlates to effective PlayerHealth
//          || - FloatRange [0.0 --- 1.0]; MaxHP = 1.0
//          |
//          |+0xB0 - [32-bit:LoadedAmmoCount_Back(display)]
//          || - When the Player is using dual wielded weapons, this value becomes active. It counts how many bullets are loaded inside the secondary weapon. (the display of bullet icons behind the front display)
//          |
//          |+0xB4 - [32-bit:LoadedAmmoCount_Front(display)]
//          || - This value regulates the display of how many bullets icons are displayed. This pretty much correlates how many bullets are loaded inside the weapon.
//          || - When Player has single shot weapon equipped (eg. throwables like dynamite or knife), when this value becomes 0x0, then the display greys out the weapon icon until weapon is reloaded
//          |
//          |+0xC0 - [32-bit:ReserveAmmoCount(display)]
//          || - This value controls the number display of how many reserve bullets the Player has in inventory
//          |
//          |+0xC8 - [8-bit:Equipped_WeaponID(non-functional) |32-bit]
//          || - This value correlates to the equipped WeaponID
//          || - WeaponIDs listed below
//          '
//          
//          # WeaponIDs (hex)
//          |(list incomplete)
//          |''''''''''''''''''
//          | 0x0 => SingleRevolver
//          | 0x1 => DualRevolvers
//          | 0x2 => Shotgun
//          | 0x3 => Rifle
//          | 0x4 => Knife
//          | 0x5 => Dynamite
//          | ...??
//          '
// $5F7E94: [NTSCU][32-bit (base) Pointer:HUD_AmmoHealth-Player2] -> [Struct:HUD_AmmoHealth]
//          @Fixed Memory Location, although this pointer is part of [Variable Size Array:GameData] ($0x5f7e20)
//          - Pointer is only valid when in a Multiplayer Showdown Match with a 2nd HumanPlayer
// $618BD0: [NTSCU][Float:Volume_Music |32-bit]
//          - FloatRange [0.0 --- 1.0]; MaxVolume = 1.0
// $618BD4: [NTSCU][Float:Volume_SoundFx |32-bit]
//          - FloatRange [0.0 --- 1.0]; MaxVolume = 1.0
// $61F650: [NTSCU][8-bit:Volume_SoundMode |32-bit]
//          0x1 => Mono
//          0x2 => Stereo
// $912040: [NTSCU][8-bit:AlwaysNULL |32-bit]
//          - Useful to do some RAscript voodoo tricks
// $91204C: [NTSCU][12-byte ASCII:GameID] = "SCPS_666.66"
//          - Internal Serial SCPS-66666
//          - Preceding [8-byte ASCII] = "cdrom0:\"
//          - Succeeding [2-byte ASCII] = ";1"
// $9128E8: [NTSCU][Variable Size ASCII:LevelID(preferred) |12-byte??]
//          - This controls which level is loaded.
//          - Freezing a valid LevelID at this memAddress and then starting a game, will load the corresponding Level
//          - Multiplayer only has 1 selectable Level
//          
//          # LevelIDs (string)
//          |(list complete)
//          |'''''''''''''''''''
//          | "lvl_tng" => Training Stage
//          | "lvl_perf75" => Prologue Stage/Level (used by SinglePlayer and Multiplayer)
//          | "lvl_hng" => Title Stage
//          | "lvl_shernite" => Sheriff Night
//          | "lvl_sher70" => Sheriff Day
//          | "lvl_saloon" => Saloon Stage
//          | "lvl_tomb" => Tombstone
//          | "lvl_flash" => Flashback Stage
//          | "lvl_train" => Train
//          | "lvl_fort" => Fort Stage
//          | "lvl_mans" => Mansion
//          '
// $912954: [NTSCU][3-byte ASCII:CharacterModelID-Player1(preferred)]
//          - This controls which CharacterModel is loaded
//          - Placing a valid ID here and then freezing before loading a Level, will load the corresponding CharacterModel
//          - This value only changes/is written to when the game loads a Level (SinglePlayer or Multiplayer)
//          
//          # CharacterModelIDs (string)
//          |(list incomplete)
//          |'''''''''''''''''
//          | "trd" => Training Red (Teenage Red)
//          | "yrd" => Snow Red (Teenage Red, with different coat)
//          | "red" => Red (Senior Red with casual wild west clothing)
//          | "nrd" => New Red (Senior Red with long coat, as seen on TitleScreen and box art)
//          | ...
// $9129BC: [NTSCU][3-byte ASCII:CharacterModelID-Player2(preferred)]
//          - Documentation at $0x912954
// $912A24: [NTSCU][3-byte ASCII:CharacterModelID-Player3(preferred)]
//          - Documentation at $0x912954
// $912A8C: [NTSCU][3-byte ASCII:CharacterModelID-Player4(preferred)]
//          - Documentation at $0x912954
// $92785C: [NTSCU][Float:TimeSpentInLevel |32-bit]
//          - Time in seconds
//          - Resets back to 0.0: On Level Start + On Level Reset; Thus this can be used to check if a Player has started a Level from the beginning
//          - Timer halts at 524288.0 (= 8738m 8s, 145h 38m 8s)
