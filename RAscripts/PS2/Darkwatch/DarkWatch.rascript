// ***************************************** \\
//	 █▀▄ ▄▀█ █▀█ █▄▀ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█	 \\
//	 █▄▀ █▀█ █▀▄ █░█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█	 \\
// ***************************************** \\
// #ID = 19111	// TODO Set header info - Two Line Text Generator: https://www.fancytextpro.com/BigTextGenerator
// md5: 0e21d37f63246c5a7bb32e074ce43f8b (PAL) -- 00bead17cad153878fc25b8985187192 (NTSC-U)
// Platform: PlayStation 2
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/19111
// RATools version: v1.15.0 // TODO set last used RATools version here

/* TODO current task: 
	
	*/

/* TODO Find code note for:
	- 8 Power (ability) Flags - in use

	- Versus Mode 
		- Settings (game mode, map, time limit, Kills)
		- Player Logic (HP, weaponData, location, powers)

	- UnlockFlags Bonus content (Gunslinger Mode??)
	- UnlockFlags all movies
	- More consistent pointer chain to functional bullets counter 	

	----NotFound----
	- ID in-engine cinematics --> Can kinda be ID'd with PlayerLocation + IsCinmetaicActive Flag (PlayerLoc is fixed during a cutscene, thus usage of bounding-box-check)
	*/

/* Game Notes:
	- COOP mode doesn't have a Stats menu

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


*/

/* CONCEPT assets
	- Chapter leaderboards: "Wrong Train" Greenhorn Watchlist