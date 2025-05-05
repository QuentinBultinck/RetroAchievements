/ =================== \
/ CODE REVIEWER NOTES \
/ =================== \
 
# ------TODO List------
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


# ------Usefull unicode characters------
✅ ☑️ ✔️ 🆗
ℹ️   🛈
❌  ✖️
❗  ‼️  ⚠️
❓ ⁉️  🚩
👆  👉  👌  👍
➡   ➡️
↩   ↩️   🔄
·
📝  ✏️  📜  💬  📑  📌  📍  ✍️  ✒️
💎 🏆  💠 🏅 
♦  🔶 ♦️  ⭐️  🔶  🌀  ⚜️  ⏺️ 
⛏️  🔨  🔧  🗝️  🔑  🔒  ⚒️ ⚒ ⛏ ⚖️
🖋️  🖌️  🖍️  🔎
🎓 	🎮


# ------TODO Legend------
🔲 TODO — Not started
🔄 WIP — Work in progress
✅ DONE — Completed
❌ CANCELED — No longer planned

Examples:

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465)
Only one letter title? Could you elaborate on this choice?

### 🔲 ❗ Achievement [G](https://retroachievements.org/achievement/482465)
Only one letter title? Could you elaborate on this choice?

### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) & [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856)
`was Broken` ---should be written as---> `Was Broken`
This issue was documented by the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/).



/ ==================== \
/ CODE REVIEW TEMPLATE \
/ ==================== \

Hello @_JR_DEV_USERNAME_

Your Code Review for [_GAME_TITLE_ (_CONSOLE_)](_UNOFFICIAL_ACHIEVEMENT_LIST_LINK_) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

### 📑 Table of Contents

🧠 Memory Work & Internal Notes _MSG_LINK_ (xx TODOs)
- 🛠️ RAM Digging & Code Notes
- 🧾 Additional Developer Notes
- 🧪 Testing & Debugging Results

🎮 Achievement Set Design _MSG_LINK_ (xx TODOs)
- 🎯 Overall Set Design
- 📝 Titles & Descriptions
- 🖼️ Badges
- 🎖️ Point Values

⚙️ Technical Implementation _MSG_LINK_ (xx TODOs)
- 🧩 Achievement Logic
- 🏆 Leaderboard Logic
- 📺 Rich Presence Logic

🔑 Misc Prerequisites _MSG_LINK_ (xx TODOs)

📜 Summary & Final Notes _MSG_LINK_

# ✦───────✦ 🧠 Memory Work & Internal Notes ✦───────✦ // DONE
// Grouped to represent all the under-the-hood work.

## 🛠️ RAM Digging & Code Notes // DONE
Mostly 8-bit values, and one 24-bit value was documented. Everything looks correctly code noted, I liked that you added some extra information describing some of the values, even if they aren't directly used by achievement logic. This speaks well of your RAM digging & documentation skills. 

## 🧾 Additional Developer Notes // DONE
### 🔲 ❓ Set Plan Feedback
In your [Set Plan Review](https://discord.com/channels/310192285306454017/1339961840947560498), dev[suspect15] requested you tried designing some extra challenge achievements, but did not.
It's seems you've also omitted one achievement from your set plan, not returning in the unofficial achievement list. Achievement **R-Bug** `Have all of the power-ups at the same time`.
How come these remarks didn't come to fruition in the current build of your achievement set?

## 🧪 Testing & Debugging Results // DONE
- Were there any problems you ran into while devving? 
- Any achievements you didn't include or weren't able to create, why?
- Describe how you tested your set.

# ✦───────✦ 🎮 Achievement Set Design ✦───────✦ // DONE

## 🎯 Overall Set Design
- No unwelcome concepts
- labels `progression` & `win condition` are used correctly.

### 🔲 ❓ More Challenges Idea's
I think if yoo're able to make 1-5 more extra challenge achievments, that it would add that little more spice/creativity to the set. Below are some suggestions. 
See for yourself what you think is feasible based on the game's design, you're the one who knows most about this game after all. In the end it's your call. Do what think would be most fun and engaging for the player. Try to have as many unique challenge achievements as possible without making the set feel too bloated. It's a simple/short game, so I think it's fine to add some extra challenges.

♦ **Timed Challenges**
I feel like some sort of timed achievement could perhaps be included into this set as well. eg. `Beat a world within xx time`, `Beat xx boss within xx time`.

♦ **Power Up Challenges**
According to this [GameFAQs - Guide](https://gamefaqs.gamespot.com/nes/931299-huge-insect/faqs/55958) there seems to be 4 positive power-ups, 1 consumable (Extra Life) and 1 negative power-up ("Skull", which removes all power ups). I would love to see if you can make a challenge achievement work in which the player has to acquire all 4 power ups at one given time and perhaps have the player complete the remaining stage with them. Or if you can make any challenge achievement revolving around these power-ups at all. This would probably mean some extra RAM digging since you've only code noted for power-ups for the `shield` & `laser`. 
Also referring to achievement **R-Bug** `Have all of the power-ups at the same time`, which was included in your Set Plan for this game.

♦ **Accuracy**
Try to find a method for determining accuracy. It could be as simple as just `Beat xx stage without missing a shot`, `Beat xx stage with less than xx missed shot`. Or harder to design like `Beat xx stage with xx% accuracy`. Perhaps something along the lines of `Kill xx bugs without missing a single shot`.
Perhaps `Beat xx stage without hitting any shield bugs`.

Take care that completing specific stages with a specific challenge in mind, they probably be best marked as ´missable´ in those case. Think of a player who just wants to play through the game once and earn `Beaten` status, whilst also earning a few challenge achievement along the way. Would be interesting they could just take a look at all the missables/challenges for specific stages. So once they get to a stage, they can read what challenge is correlated to it.

### 🔲 ❓ Set Plan Feedback
In your [Set Plan Review](https://discord.com/channels/310192285306454017/1339961840947560498), dev[suspect15] requested you tried designing some extra challenge achievements, but did not.
It's seems you've also omitted one achievement from your set plan, not returning in the unofficial achievement list. .
How come these remarks didn't come to fruition in the current build of your achievement set?

### 🔲 ❓ Leaderboards
I would highly recommend you also develop some achievements surround this title. Below are some suggestions/idea's I would love to see.
- **Timed**: Some sort of speedrun leaderboard for completing the game, or finishing each world the fastest.
- **Highscore**: A leaderboard for the highest score for each world completion 
    - Perhaps this could be made into a custom scoring system, which also incoporates lives/shooters lost/left and the player's accuracy? (this would be pretty hard to do, but would be a good learning experience)

## 📝 Titles & Descriptions
Titles are very creative, love to see it.

### 🔲 ❗ Description Issues
Following achievements have a small problem:
- [Bugeste](https://retroachievements.org/achievement/500190)
- [Bug Flying Squadron](https://retroachievements.org/achievement/500189)

Instead of `Have 100,000 Points` consider these options: `Earn 100,000 Points`, `Achieve a total 100,000 Points`...
Those feels more like giving the player an action to complete something, rather than a simple sentence stating the requirement. This feels better phrased for an achievement.

## 🖼️ Badges
There are unique badges for each achievvement. although they look rather simple. I personally can't tell what I'm looking at in the following badges:
[Fantasy Bug](https://retroachievements.org/achievement/500188)
[194Bug: The Battle of Insects](https://retroachievements.org/achievement/500186)
[Bugpachi](https://retroachievements.org/achievement/500185)
[Twin Bug](https://retroachievements.org/achievement/500184)
Alas the game uses simple art, perhaps this is the best that can be done.

The challenge achievements do have great badges though, althoug some with low quality imagery.
Perhaps a border could added, to add some extra depth? It's up to you, after all? Perhaps try a post in [#Art-Request](https://discord.com/channels/310192285306454017/1048102604963586048) channel on discord.

## 🎖️ Point Values
Challenge achievements feel

### 🔲 ❓ Possible Point Increase 
I feel like the `progession` & `win condition` achievements could be increased in score somewhat. You're practically requiring the player to complete a whole World instead of single stage, so I think increasing them all by a few points is fine. I especially think the `win condition` achievement could be increased to 10. and perhaps also World 4?

It's a rather simple game, we don't want to over increase it, but I think a small increase would be accepted.
That is of course if there's no stage select whatoever. Does the player have to restart from the first stage each time? 

In the end do what you feel is best according to [RAdocs - Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html), you know the game the best.


# ✦───────✦ ⚙️ Technical Implementation ✦───────✦ // TODO
// Grouped for logic quality and RA feature usage.

## 🧩 Achievement Logic // TODO: fill in Proficiency-Checklist - 
/// Triggers, reset conditions, edge cases. Were flags used correctly? Refer to the Proficiency-Checklist


### ℹ️ Achievement [StarBug](https://retroachievements.org/achievement/500182) Alternative Design
This achievement's logic could be written alternatively.

Current logic:
```
1:          Mem   8-bit 0x000003b7 >   Delta 8-bit 0x000003b7 (200) --> Count [StageKillCount] increments
2: ResetIf  Mem   8-bit 0x0000000b >   Value       250        (0)   --> Reset OnPlayerTakingHit (goes into I-frames after hit)
```

Pseudo logic without using hitcounts:
```
Delta   [StageKillCount] < 200
Mem     [StageKillCount] >= 200
(preferably, you should also include an extra check to see if the player is in-game or not, just so you're checking at least 2 different RAM values)
```
Do you understand why above code is preferred to the current logic? ||Usage of HitCounts makes logic more complex, it isn't necessary for this achievement. Thus ResetIf can also be omitted||

### 🔲 ❗ Improper Use of Delta
All achievements, but [StarBug](https://retroachievements.org/achievement/500182), are not using deltas correctly.
Take for example achievement [Twin Bug](https://retroachievements.org/achievement/500184) `Complete World 4`:
```
  1:             Delta 8-bit 0x00000306 =   Value       24         (1)  --> Check if delta [StageID] == Stage5_1
  2:             Mem   8-bit 0x00000306 =   Value       24         (1)  --> Check if [StageID] == Stage5_1
  3:             Mem   8-bit 0x00000011 =   Value       133        (0)
  4: ResetIf     Mem   8-bit 0x00000306 <   Value       24         (0)  --> Reset if delta [StageID] == Stage5_1
```
- Line[1-1]: Are incorrectly using a delta check
- Line[4]: ResetIf when it's also Stage5-1. Why also reset when it's the same stage?
- HitCounts can be omitted

Improved Psuedo Logic, omitting `ResetIf`:
```
Delta   [StageID] == LastStageOfWorld(4)
Mem     [StageID] == FirstStageOfWorld(5)
(preferably, you should also include an extra check to see if the player is in-game or not, just so you're checking at least 2 different RAM values)
```
Do you understand why above code is preferred to the current logic? ||Usage of HitCounts makes logic more complex, it isn't necessary for most of these achievements. Thus ResetIf can also be omitted||

### 🔲 ❓ Achievement [Bughou](https://retroachievements.org/achievement/500187) Improvement
♦ **Issues**
- Improper Use of Delta as described above.

♦ **Enhancements**
- Logic could be improved by adding in another check, to see if the game was started from the beginning. ||(can be checked using Prior or HitCounts)||
- A optional measured indicator could improve this achievement's feedback to the player. By letting the measured indicator start from 5/5, indicating 5 lives left to lose till the achievement disables. Each live lost would decrement it by one. Try and figure out how you can make such a feature work, this would be a great learning experience to becoming a dev.

- PauseIf on line[5] could be omitted.
Current logic
```
  1: Trigger     Delta 8-bit 0x00000306 =   Value       30         (0)
  2: Trigger     Mem   8-bit 0x00000306 =   Value       30         (0)
  3: ResetNextIf Mem   8-bit 0x00000306 <=  Value       0          (0)
  4: PauseIf     Mem   8-bit 0x0000000b =   Value       251        (5)
  5: PauseIf     Mem   8-bit 0x00000011 =   Value       164        (0)  --> Omit this
```
Improved logic
```
  1:             Mem   8-bit 0x00000011 !=  Value       164        (0)  --> Move it here without PauseIf, but make it negative/false
  2: Trigger     Delta 8-bit 0x00000306 =   Value       30         (0)
  3: Trigger     Mem   8-bit 0x00000306 =   Value       30         (0)
  4: ResetNextIf Mem   8-bit 0x00000306 <=  Value       0          (0)
  5: PauseIf     Mem   8-bit 0x0000000b =   Value       251        (5)
```
Do you see why this improved logic is better? ||A pauseIf is omitted, good practice to just check if the player isn't at the titleScreen with a normal check||

## 🏆 Leaderboard Logic // TODO
/// Leaderboards with instant Start/Submit implemented?

## 📺 Rich Presence Logic // TODO
/// Is a dynamic RP present? Not overly bloated or using unsupported Unicode.  
/// Macros and lookupTables used appropriately?  
/// Refer to https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence

# ✦───────✦ 🔑 Misc Prerequisites ✦───────✦ // DONE

## 🔲 🧭 Hubs & Similar Games
You already did a pass on hubs to be added within your [Read for Review thread](https://discord.com/channels/310192285306454017/1342175550017503362). 
Any more hubs or similar game you think could be added? Think of any other (sub-)genres which may be fitting, refer to [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html)

## 🔲 🗂️ Game Page Metadata
Genre is filled out like `Action » Shooter » Shoot-'Em-Up » Top-Down`, try to write this out better and add all these genres as hubs as well.

# ✦───────✦ 📜 Summary & Final Thoughts ✦───────✦ // TODO
// Overview and high-level review conclusion.  
// What still needs to be proven or improved?  
// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?

The set looks very basic, current achievements may work fine for such a simple game, but they are not up to coding standards.
Please address all ❗ and ❓ notes, see where improvements could be made. Only then we'll see how we can move this set to release state.