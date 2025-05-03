// TODO List (for Code-Reviewer)
- Edit intro
- Review: Memory Work & Internal Notes
    - RAM Digging & Code Notes 
    - Additional Developer Notes AND Testing & Debugging Results 
- Review: Achievement Set Design
    - Overall Set Design AND Point Values
    - Titles & Descriptions AND Badges
- Review Technical Implementation
    - Achievement Logic
    - Leaderboards
    - Rich Presence
- Any Generam Issues & Questions?
- Any Promotion Prerequisites?
- Write Summary & Final Thoughts
- Proof Read (with AI)


- Fill out this TODO list
- Go over all achievements and leaderboard again to check logic
- Check point distribution
- Write Summary & Final Thoughts




Hello @kssfilo

Your Code Review for [RayForce | Gunlock (Arcade)](https://retroachievements.org/game/13588?f=5) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out and ping me.




# ✦───────✦ 🧠 Memory Work & Internal Notes ✦───────✦
// Grouped to represent all the under-the-hood work.

## 🛠️ RAM Digging & Code Notes
Everything looks in order here, seems like you've only worked with [8-bit] values.
One [16-bit] value is code noted, but unused.
You know how to work with BCDs.
You also know how to identify *BitFlags* or a *Bitfield*

### 🔲 ❓ Code Notes *"Stage Progression"*
There seems to be multiple RAM addresses named as `Stage Progression`, how exactly do they work and which one is actually used? How come there are multiple ones? I'd be handy if the reasoning for this, is noted inside the Code Notes somewhere.

Achievement [Highway Havoc](https://retroachievements.org/achievement/484614) for example.
```
  1: AndNext     Mem   8-bit 0x00002312 =   Value       5          (0)
  2: AndNext     Mem   8-bit 0x00003ce8 =   Value       0          (0)
  3: AndNext     Mem   8-bit 0x000000bd >=  Value       1          (0)
  4: AndNext     Mem   8-bit 0x000000bd <=  Value       16         (0)
  5: AndNext     Mem   8-bit 0x0000569c <=  Value       34         (0)
  6: Measured    Mem   8-bit 0x000038ce !=  Delta 8-bit 0x000038ce (15)
  7: ResetIf     Mem   8-bit 0x000022e5 =   Value       1          (0)
```
**How exactly does this work?**
Line[2] CheckIf Stage Progression is 0
Lines[3-5] CheckIf Stage Progression is in a range

### 🔲 ❓ Code Notes `$0x38d0` & `$0x38ce` 
Could you explain how these function exactly? Enemy kill count is split up into two seperate values? Does low perhaps means the lower layer, where the player can only kill enemies with his auto-target lasers? And High mean the upper layer, the same one the player's ship is at, which can hit enemies with your "shot"/ default shoting ability? It would be handy if this explanation was clarified in detail within the relevant code notes. I should be able to understand how the game works just by reading the code notes especially for something which isn't so straightforward to understand.

## 🧾 Additional Developer Notes  
/// [Optional] Comments left in logic, RAScript, or planning documents.
N/A

## 🧪 Testing & Debugging Results  
/// Mentioned bugs, testing methods, hardcore/softcore checks, peer testing, issues encountered during development, and any achievement concepts that could not be implemented.





# ✦───────✦ 🎮 Achievement Set Design ✦───────✦
// Grouped to cover all visible/user-facing parts.
// Conform to https://docs.retroachievements.org/guidelines/content/achievement-set-requirements.html  
//         and https://docs.retroachievements.org/developer-docs/achievement-development-overview.html
// Any unwelcome concepts (refer to https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html#unwelcome-concepts)

## 🎯 Overall Set Design  
/// Balance, creativity, progression, and content coverage.  
/// Achievement types (progression, missables...) https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html  
/// Difficulty balance https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html

Overal the set looks pretty good and it has a few creative challenge achievements, as well as some custom made side-objective achievements.

### 🔲 ❓ Achievement [Ready for Score Attack](https://retroachievements.org/achievement/484580)
Seems like an [unwelcome concept - Zero Effort Without Purpose](https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html#zero-effort-without-purpose)
I would suggest perhaps including this information on how to change difficulty into an new or edited achievement, in which the player is required to to complete a certain Stage on a specific difficulty. `eg. Complete Area 1 on Very Hard difficulty. Press and hold START to enter Test Menu in order to change difficulty settings`. Then this information on how to change difficulty, could only be mentioned once throught the whole set. Or you could keep it in all achievements requiring a specific difficulty.

### 🔲 ❓ Achievement [8 Ball](https://retroachievements.org/achievement/482545)
`Lock on 8 enemies at once and fire at them`
Works fine, but I think it would be better designed if it only unlocked once your killed the 8 locked-on enemies with a single volley instead, although I'm not sure how feasible this would be to create, with current dev tools or if it even would be possible to track reliably.

### 🔲 ❓ Achievement [Space Ace Pilot](https://retroachievements.org/achievement/482889) 
- Uses `$0x38d0` & `$0x38ce` to count 140 enemy kills, but the boulders I destroy in Stage 1 seem to count for more than 1 enemy? Perhaps you could rephrase this achievement, or find a better method of identifying how many "enemies" were effectively killed. Do the boudlers count as enemies? In my eyes they feel more like obstacles which can damage the player on collision.

- This lacks a `delta` check. This issue was documented by the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/).

## 📝 Titles & Descriptions  
/// Conform to https://docs.retroachievements.org/guidelines/content/writing-policy.html
Writing looks pretty good across the board. 

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465)
Only one letter title? Could you elaborate on this choice?

### 🔲 ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) & [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856)
`was Broken` ---should be written as---> `Was Broken`
This issue was documented by the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/).

### 🔲 ❓ Leaderboard Series [High Score at Stage 1 End](https://retroachievements.org/leaderboardinfo.php?i=122264)
``

## 🖼️ Badges  
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html

Is it possible the following achievements don't use game art assets? If so, make sure to update them accordingly, refer to [RAdocs - Designing New Game Icons](https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html#designing-new-game-icons)
- [8 Ball](https://retroachievements.org/achievement/482545)
- [Pacifist Pilot](https://retroachievements.org/achievement/482547)
If you encounter any problems creating badges or are out of idea's, try to ask the community for help, specifically via [Art-Requests channel on RAdiscord](https://discord.com/channels/310192285306454017/1048102604963586048)

## 🎖️ Point Values  
/// Conform to https://docs.retroachievements.org/developer-docs/achievement-scoring.html
Point distribution seems reasonable. From what I gathered about this game, there's no level/area select in this game? The player can only complete stage 2, by starting from the beginning of the game each time right? Unless they use savestates... If that is the case, all points seems pretty well distributed.

The set doe






# ✦───────✦ ⚙️ Technical Implementation ✦───────✦
// Grouped for logic quality and RA feature usage.

## 🧩 Achievement Logic  
/// Refer to the Proficiency-Checklist
/// Triggers, reset conditions, edge cases.
/// Multi-hash support?
/// Protections: Demo/Cheat/Save/Bios/DipSwitch?  
/// Were flags used correctly? 

## 🏆 Leaderboards

### 🔲 ❓ Leaderboards & Difficulty
Playing on the hardest difficulty nets a player the same score, as someone playing on the easiest. I don't think it great design. Either have multiple leaderboards per difficulty or incorporate a difficulty modifier to the score. This could be as easy as doing a multiplication of the highscore, or perhaps some more advanced math to limit the integer size of the submited score/value via RA. Hhhmmm... I can't really say what the best option would be here. You'd want the score submit on RA to be the exact same integer as shown in-game, but doing math with the score, would result in the submitted value not being the same as shown in-game... Decide for yourself what would be best here, or you could try to ask the community with a poll in [Poll-Me channel](https://discord.com/channels/310192285306454017/511718348178849792).
 	
### 🔲 ❓ Leaderboard Series [High Score at Stage 1 End](https://retroachievements.org/leaderboardinfo.php?i=122264)
How come there's only 3 leaderboards of this type? While there's actually 7 stages? Please elaborate on this choice.

### Leaderboard Spam
All your Leaderboards activate at the start, leading to constant RAoverlay pop-ups for a about 20+ seconds. I would advise to try to find a way to limit the amount of "primed" leaderboards and try to implement instant Start/Submit leaderboards for most of them. All leaderboards which hook onto the HighScore could probably 
take advantage of such a system, since the high score is already shown on-screen. Only have primed leaderboards for measured data which is not displayed by default by the game. Highscore is. [8 Ball Madness](https://retroachievements.org/leaderboardinfo.php?i=122542) is probably the only one which should be primed/have an RAoverlay on screen to count enemy kills.

### Leaderboard [8 Ball Madness](https://retroachievements.org/leaderboardinfo.php?i=122542)
Is probably the only one which should be primed, ever. Since it's just counts how times the player has locked on to 8 enemies at once. Although player 2's data may be overlooked, more on this in Code-Review-Section[🚧 General Issues & Questions]. I also don't like the design of this leaderboard all that well. I think it would work better if you could make it somewhat like the following: `Take out as many enemies as possible with a full 8-laser volley`, this could then potentinally count enemies killed instead of full volleys fired. Same goes for the corresponding achievement [8 Ball](https://retroachievements.org/achievement/482545). Although changing to my suggestion may not work, it's up to you to find out if it's possible or not. Try to at least give this a try, and report back if something like this would be possible or not.

## 📺 Rich Presence  
/// Is a dynamic RP present? Not overly bloated or using unsupported Unicode.  
/// Macros and lookupTables used appropriately?  
/// Refer to https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence
Rich Presence is dynamic and looks good, not much too say here. 
Although player 2's data is not be included, more on this in Code-Review-Section[🚧 General Issues & Questions].






# ✦───────✦ 🚧 General Issues & Questions ✦───────✦
// Callout section for anything actionable or in doubt.

### 🔲 ❗ Player 2 Issue (Achievments, Leaderboards, RP)
From my understanding you're not accounting for a 2nd player in most of the set, only for achievement [Body Guard](https://retroachievements.org/achievement/482594), which is part of the challenge.

For example achievement [Penetration](https://retroachievements.org/achievement/482464) `Complete Stage 1 without dying`
> What if player 2 joins in and dies?
> Can I play from start to finish as just player 2, without ever using player 1's spot?

2nd example achievement [X-LAY Pro](https://retroachievements.org/achievement/482546) `Upgrade the main shot to level 6 and the lock-on laser to level 8`
> What if player 2 joins in and earns both these upgrades, instead of player 1?

*Progression achievements*, are they accounted for a 2nd player?
Is the difficulty of the *challenge achievements*, accounted for a 2nd player?

You will have to make a decision on wether multiplayer is allowed or not. 
> If not, you should update the descriptions accordingly.
> If yes, you should update the logic accordingly to allow both players possibly earning this.

Another solution would be is to implement a [Subset - Multiplayer Cooperative], where the [BaseSet] only allows only 1 player to be active/controlled for in order to unlock all the achievements, while a subset requires both player's input.
Or could have partially allowed multiplayer, where any player can unlock any achievmeent, although the balancing of each challenge achievement may be up to debate in that case.
Refer to the following hubs: [Meta - Set Disallows Multiplayer](https://retroachievements.org/hub/26213), [Meta - Set Allows Multiplayer](https://retroachievements.org/hub/22986) and [Meta - Set Partially Allows Multiplayer](https://retroachievements.org/hub/7115)

Another problems arises with leadeboards and the RichPresence, I also don't think these are accounting for a player 2 joining in.

I've tested this myself within the game. Player 1 and player 2 can opt-in and -out whenever they want or when they die based on game settings. Because of issue that was overlooked, you'll probably have to redesign a large portion of your set, or just update all descriptions accordingly so they only work for player 1's slot. I'd prefer if you do the latter and try and redesign all assets with a player 2 in-mind. This would drastically increase your experience with achievement development.





# ✦───────✦ 🔑 Promotion Prerequisites ✦───────✦

## 🔲 🧭 Hubs & Similar Games
/// Any hubs to add? (Refer to https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html)

## 🔲 🗂️ Game Page Metadata 
/// Is everything correctly filled out on the Manage page?



# ✦───────✦ 📜 Summary & Final Notes ✦───────✦
// Overview and high-level review conclusion.  
// What still needs to be proven or improved?  
// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?

The game is pretty basic, but dev managed to still create some unique challenges and expand the content the game has to offer by doing so. 

Have you used the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/)? I would highly recommend using this again in your future sets, and even whilst updating this set.