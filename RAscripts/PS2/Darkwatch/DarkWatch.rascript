// ***************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 \\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	 \\
// ***************************************** \\
// #ID = 19111	// TODO Set header info - Two Line Text Generator: https://www.fancytextpro.com/BigTextGenerator
// md5: 
// RA Hash: 0e21d37f63246c5a7bb32e074ce43f8b (PAL) -- 00bead17cad153878fc25b8985187192 (NTSC-U)
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/19111
// RATools version: v1.15.0 // TODO set last used RATools version here

/* TODO Find code note for:
	- Minimatic/Cinematic ID

	- UnlockFlags for Concept Art (Only unlockable through  Gunslinger Mode)

	- Enemy EntityData (HP, Location, Type) --> cheevo's for killing specific enemies
	
	- Hubs to add:
		- [Feature - PvP] 							https://retroachievements.org/game/9377
		- [Perspective - 1st-Person] 				https://retroachievements.org/game/3401
		- [Feature - Co-op] 						https://retroachievements.org/game/24859
		- [Protagonist - Cowboy] 					https://retroachievements.org/game/18941
		- [Protagonist - Vampire Hunter] 			https://retroachievements.org/game/18940
		- [Meta - Has RAGuide]  					https://retroachievements.org/game/4637
		- [Meta - Quality of Life Patch Available]	https://retroachievements.org/game/30636

	*/

/* DEV_NOTE - Game Logic Notes:
	- MainMenu Flag with Sofdec or IsInGame flag

	- Power Unlock Flags (hacky) --> can  kinda ID it because a new power is selected by default on unlock on the display

	- ID minimatics/Cinematics (in-engine) 
		- Very hacky to ID consistently with ASCII ID
		- Rrefer using hit counts of how many times an Cinmatic has been played to Identify if a specific cinematic has been played (eg. Cinematic 3 of Chapter X => 3 hits counts on_Cinematic_start())
		- Could also introduce PlayerLocation as an extra check when the Cinematic Flag is active (this is only applicable for some cinematics where the playerLoc gets moved to some sort of default location, during or after the cinematic is done)

	- COOP mode doesn't have a Stats menu, only seperate stats for each player updated during the chapter

	- ChapterSections (eg. WrongTrain_A & WrongTrain_B) 
		- When WrongTrain_B is reached, and restarting -> game restarts from the beginning of WrongTrain_B
		- When WrongTrain_B is reached, and continueing game via MainMenu, when Chapter is "in progress" -> game continues from the beginning of WrongTrain_B, NOT from start of WrongTrain_A

	- Identify start of chapter SinglePlayer => perhaps with checkpoints?
	- Identify start of chapter COOP => 

	- COOP saveData is saved as a seperate "PlayerProfile"
		- Thus there can be up to 10 PlayerProfiles saves + 1 COOP profile saves

	- Ally HP + Location --> [Array:EntityData] 
	- Enemy HP (functional) + Location --> [Array:EntityData] 	

	- Checkpoints (some Chapters are split into Sections: eg. WrongTrain_A & WrongTrain_B, each with seperate checkpoints)
		- When "restarting" (PauseMenu->Restart) => the game restarts from the beginning of the Chapter Section
		- When dying => the game restarts from the Checkpoint
	- Checkpoints are non-existent in CO-OP mode (some Chapters are split into Sections: eg. WrongTrain_A & WrongTrain_B, each with seperate checkpoints)
		- When "restarting" (PauseMenu->Restart) => the game restarts from the beginning of the Chapter Section
		- When both players die at same time => the game restarts from the beginning of the Chapter Section

	- Chapters with multiple sections
		- Ch1 WrongTrain: Inside train -- On top of train
		- Ch3 Boneyard: Outside church -- Inside church Catacombs

	- UnlockFlags movies -> Correlated to Current StoryChapterID and endingflags

	- Versus Mode
		- 
*/

/* CONCEPT assets
	- Chapter leaderboards: "Wrong Train" Greenhorn Watchlist