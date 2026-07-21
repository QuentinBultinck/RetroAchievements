// Zillion II: The Tri Formation
// #ID = 10716

// $0002: [8-bit:ContinueUseCount]
//        - refers to "Continuing the game on GameOver (when all lives used)". At GameOverScreen player can press "Dpad-up + A-button" to restart current stage with 3 lives, however with 0 score.
//        - ValueRange[0x0-0x3]. Only able to "Continue" a max of 3 times. After that it's absolutely GameOver

// $0005: [8-bit Flag:IsGodModeActive]
//        0x0 = Default Value
//        0x4 = God Mode (invincible) (can only be enabled via RAM tampering)

// $0006: [8-bit:PlayerInput_Controller1]
//        bit0 = Dpad Up
//        bit1 = Dpad Down
//        bit2 = Dpad Left
//        bit3 = Dpad Right
//        bit4 = Button A
//        bit5 = Button B

// $000D: [24-bit BCD:HighScore]
//        -  highest score of the current session
//        - only updates when current score (refer to $0x0012) is larger than this on GameOver
//        
//        thisAddr+0x0 = [8-bit BCD:Score_xxxxXX0]
//        thisAddr+0x4 = [8-bit BCD:Score_xxXXxx0]
//        thisAddr+0x8 = [8-bit BCD:Score_XXxxxx0]

// $0010: [8-bit:GameState]
//        - toggling between valid values, activates the corresponding GameState
//        
//        0x1 = MainMenu
//        0x2 = Demo
//        0x3 = PlayerDeath (when losing a life, this state is only active for 3~ frames) || GameOver (lost all lives)
//        0x4 = PreStageScreen (info with next stage, current score and lives left)
//        0x5 = OutroSequence
//        0x6 = TheEnd (follow-up of OutroSequence)
//        0x7 = InGame (on-rails OR on-foot)
//        0x8 = BossFight (any boss fight) || RescueRoom (Apple or Champ)

// $0012: [24-bit BCD:Score]
//        - Score UI always prepends an extra 0, not accounted for in logic
//        
//        thisAddr+0x0 = [8-bit BCD:Score_xxxxXX0]
//        thisAddr+0x4 = [8-bit BCD:Score_xxXXxx0]
//        thisAddr+0x8 = [8-bit BCD:Score_XXxxxx0]

// $0015: [8-bit:Stage_ID(functional)]
//        - Game uses term "Round" for stages
//        - Switches IDs just before the PreStageScreen renders
//        - Loading specific stages:
//        ---- Editing this value to any valid stage ID at runtime allows player to skip to that specific stage (eg. want to skip directly to Stage 8: freeze this value at 0x7 and finish current stage)
//        ---- It's advised to skip only to opposing stages from the current one (eg. from any on-foot stage into any on-rails stage OR from any on-rails stage into any on-foot stage). Not doing so bugs out the player character.
//        ---- FYI: All odd numbered stages are on-rails, all even numbered stages are on-foot.
//        
//        0x1 =  Stage 1 || Round 1
//        0x2 = Stage 2 || Round 2
//        ...
//        0x8 = Stage 8

// $0016: [8-bit:Stage_Level_ID]
//        - This value is used to identify which level of an On-Foot stage is loaded. This does not identify BossFightRooms or RescueRooms.
//        
//        # Stage_Level_IDs (hex)
//        |'''''''''''''''
//        |---Stage 2---
//        | 0x2 => Level 1 (Start)
//        | 0x0 => Level 2 (Apple Rescue Room)
//        | 0x1 => Level 3 (Boss Room)
//        |---Stage 4---
//        | 0x3 => Level 1 (Start)
//        | 0x1 => Level 2
//        | 0x0 => Level 3 (Champ Rescue Room)
//        | 0x2 => Level 4
//        | 0x4 => Level 5 (Boss Room)
//        |---Stage 6---
//        | 0x4 => Level 1 (Start)
//        | .. => Level ?
//        | 0x1 => Level ? (Boss Room)
//        |---Stage 8---
//        | 0x5 => Level 1 (Start)
//        | .. => Level ?
//        | 0x0 => Level ? (Boss Room)
//        '

// $0018: [8-bit:Player_Life]
//        - refers to HP
//        - ValueRange[0x0-0x3F] = [dead - maxHP]

// $001A: [8-bit:Boss_HP]

// $001E: [8-bit:LaserUpgrades]
//        - refers to Z-PowerUps (max 3 charges at a time). At max charges pistol shoots different lasers

// $001F: [8-bit:Player_Lives]
//        - refers to "lives", how many times player can die before GameOver
//        - ValueRange[0x1-0xA] = [0-9]; any value higher than 0xA works, but UI can't display this correctly; Game doesn't allow player to store more than 4 lives
//        - When no lives left (0x1), on death => this value becomes 0x0

// $0027: [8-bit:Stage_Section_Location]
//        - ValureRange[0xFF-0x0]
//        - This value represents the current location within the current [8-bit:Stage_Section_ID] refer to $0x0028
//        - When progressing through a stage, this counts down, when it reaches 0x0 and player progresses further through stage, this value resets back to 0xFF and [8-bit:Stage_Section_ID] is incremented. When backtracking (possible during on foot stages), this is reversed.

// $0028: [8-bit:Stage_Section_ID]
//        - Progressing through a stage, this increments (not always by one) eg. during lineair sections it increments by one, but during on-foot stages, when going through section transitions (doors, lifts) this may skip certain values
//        - This value also determines where in the Stage the player will respawn when losing a life (thus this value can be edited to skip to certain locations within a stage). Be wary for if this isn't a valid value for the current stage, it will bug out the game
//        
//        # Stage_Section_IDs (hex)
//        |'''''''''''''''''''''''''
//        |-----Stage 1 [0x0-0x45]-----
//        | 0x0 = Start of Stage 1
//        | 0x45 = Door to Stage 2
//        |-----Stage 2 [0x0-0x45]-----
//        |...
//        '

// $0077: [bit0 BitFlag:IsPistolFullyCharged |8-bit]
//        - this directly controls which sprite is used to player projectiles
//        0 = false
//        1 = true

// $0081: [8-bit:Stage_ID(non-functional)]
//        - prefer using [8-bit:Stage_ID(functional)] at $0x0015
//        - Switches IDs when the PreStageScreen flips into InGame
//        
//        0x0 = Stage 1 || Round 1
//        0x1 = Stage 2 || Round 2
//        ...
//        0x7 = Stage 8

// $0095: [8-bit:PlayerCharacter_ID]
//        - changing this value at runtime changes character sprite (only during on-rails stages)
//        
//        0x0 = JJ
//        0x1 = Apple
//        0x2 = Champ

// $0099: [bit0 BitFlag:IsSummoningMenuDisplayed |8-bit]
//        - SummoningMenu refers to the Menu which can be called during any on-rails stage . When Apple or Champ are rescued, the player can basically switch characters and refill his life bar to max. Pretty much a free health pickup, but they can both only be used once throughout the whole game.

// $009D: [bit0 BitFlag:IsAppleAvailable |8-bit]
//        - Is also used to determine when they're rescued
//        - this character can then be summoned once with 2nd control pad, to tank some hits during on-rails stages
//        0 = false
//        1 = true

// $009E: [bit0 BitFlag:IsChampAvailable |8-bit]
//        - Is also used to determine when they're rescued
//        - this character can then be summoned once with 2nd control pad, to tank some hits during on-rails stages
//        0 = false
//        1 = true

// $00BD: [bit0 BitFlag:IsArmoraterPowerUpAcquired |8-bit]
//        - acquired by picking up an A Power-Up
//        - enables changing into Armorater during on-rails stages

// $0133: [8-bit:OutroSequence_Section_ID]
//        - advised to use with [8-bit:GameState] at $0x0010
//        
//        0x0 = Section 1 "At last, after a fierce battle..."  (starring JJ)
//        0x1 = Section 2 "In spite of their highly...." (starring Champ)
//        0x2 = Section 3 "Unless the Noza Forces give up..." (starring Apple)
//        0x3 = Section 4 "JJ and his comrades...." (starring all 3 characters)

// $0300: [832-byte Array:Entities]
//        - Entities refers to any interactable/moving sprite within the game (projectiles, enemies, power-ups...)
//        - Data within an Entity Struct may contain data such as: AI (attack/move pattern), draw location on screen,..
//        
//        [Definition Struct:Entity |32-byte]
//        |''''''''''''''''''''''''''''''''''
//        |structAddr+0x0 = [8-bit:Entity_ID]
//        || - Also correlates to which (attack/move pattern) an enemy entity should run, thus one entity can have multiple IDs
//        |structAddr+0x3 = [8-bit:Entity_xLocation]
//        || - refers to draw location on-screen (not in-game world)
//        || - ValueRange[0x0-0xFF] = [Left-Right]
//        |structAddr+0x5 = [8-bit:Entity_yLocation]
//        || - refers to draw location on-screen (not in-game world)
//        || - ValueRange[0x0-0xFF] = [Top-Bottom]
//        |structAddr+0x6 = [16-bit:Entity_SpriteID]
//        || - refers to which sprite is drawn (one entity can have multiple sprites. Eg: for walking or shooting)
//        '
//        
//        [32-byte Struct(Entity):Player]
//        - always at this location
//        
//        # Entity_IDs (hex)
//        |''''''''''''''''''''''''''''''''''
//        | [0x1 (player input is read); 0x55 (during OutroSequence)] = Player Character
//        | [0x8 (moving left); 0x9 (moving right); 0xA,0xB (shooting)] = Norsa Soldier
//        | [0x25 (during whole fight)] = Final Boss
//        | 0x2E = Any PowerUp
//        | [0x31 (flying and shooting); ...] = Norsa Jetpack Soldier
//        '
//        
//        # Entity_SpriteIDs (hex)
//        |''''''''''''''''''''
//        | 0xb56f = L-Power-Up
//        | 0xb553 = Z-Power-Up
//        | 0xb545 = A-Power-Up
//        | ...
//        '

// $0301: [8-bit Flag:IsArmoraterActive]
//        @Member of Struct(Entity):PlayerEntity ($0x0300)
//        - freezing this value, prevents changing into/from Armorater
//        
//        0x0 = false (motorcycle is active)
//        anyValue > 0x0 = true (armorator is active) (value can be 0x1,0xC...)

// $0303: [8-bit:PC_xLocation]
//        @Member of Struct(Entity):Player ($0x0300)
//        - Player Character's xLocation (on-screen, not in game world)

// $0305: [8-bit:PC_yLocation]
//        @Member of Struct(Entity):Player ($0x0300)
//        - Player Character's yLocation (on-screen, not in game world)

// $0320: [128-byte Array:PlayerProjecileEntities]
//        @SubSection of [Array:Entities] ($0x0300)
//        
//        [32-byte Struct(Entity):PlayerProjectile_A]
//        - Only 4 possibles location for PlayerProjectile Entities

// $0340: [32-byte Struct(Entity):PlayerProjectile_B]

// $0360: [32-byte Struct(Entity):PlayerProjectile_C]

// $0380: [32-byte Struct(Entity):PlayerProjectile_D]

// $03A0: [672-byte Array:VariedEntities]
//        @SubSection of [Array:Entities] ($0x0300)
//        
//        [32-byte Struct(Entity):Entity_1]
//        - Boss Entities are always at this location (Exception!! Boss_1, as he consists of multiple entities)

// $03C0: [32-byte Struct(Entity):Entity_2]

// $03E0: [32-byte Struct(Entity):Entity_3]

// $0400: [32-byte Struct(Entity):Entity_4]

// $0420: [32-byte Struct(Entity):Entity_5]

// $0440: [32-byte Struct(Entity):Entity_6]

// $0460: [32-byte Struct(Entity):Entity_7]

// $0480: [32-byte Struct(Entity):Entity_8]

// $04A0: [32-byte Struct(Entity):Entity_9]

// $04C0: [32-byte Struct(Entity):Entity_10]

// $04E0: [32-byte Struct(Entity):Entity_11]

// $0500: [32-byte Struct(Entity):Entity_12]

// $0520: [32-byte Struct(Entity):Entity_13]

// $0540: [32-byte Struct(Entity):Entity_14]

// $0560: [32-byte Struct(Entity):Entity_15]

// $0580: [32-byte Struct(Entity):Entity_16]

// $05A0: [32-byte Struct(Entity):Entity_17]

// $05C0: [32-byte Struct(Entity):Entity_18]

// $05E0: [32-byte Struct(Entity):Entity_19]

// $0600: [32-byte Struct(Entity):Entity_20]

// $0620: [32-byte Struct(Entity):Entity_21]
