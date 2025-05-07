# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #
 
# ------CR TODO List------
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

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465) Single Letter Title
Only one letter title? Could you elaborate on this choice?

### 🔲 ❗ Achievement [G](https://retroachievements.org/achievement/482465) Broken
Broken because ...

### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) Improvement Suggestion
Do this instead of that...







# %%%%%%%%%%%%% CODE REVIEW TEMPLATE %%%%%%%%%%%%% #

# ------Intro------

Hello @RoughRider

Your Code Review for [Huge Insect (NES/Famicom)](https://retroachievements.org/game/8506?f=5) has finally flew in!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

# 📑 Table of Contents
### 🧠 Memory Work & Internal Notes _MSG_LINK_ 
*(3 TODOs)*
- 🛠️ RAM Digging & Code Notes
- 🧾 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🎮 Achievement Set Design _MSG_LINK_ 
*(4 TODOs)*
- 🎯 Overall Set Design
- 📝 Titles & Descriptions
- 🖼️ Badges
- 🎖️ Point Values
### ⚙️ Technical Implementation _MSG_LINK_ 
*(6 TODOs)*
- 🧩 Achievement Logic
- 🏆 Leaderboard Logic
- 📺 Rich Presence Logic
### 🔑 Misc Prerequisites _MSG_LINK_ 
*(2 TODOs)*
### 📜 Summary & Final Notes _MSG_LINK_

# ✦───────✦ 🧠 Memory Work & Internal Notes ✦───────✦

## 🛠️ RAM Digging & Code Notes
You’ve documented a 24-bit value, which is appreciated, though there’s a slight inaccuracy, refer to CodeReviewSection [📺 Rich Presence Logic - ❓ Score Macro & Code Note] for details. Otherwise, your code notes look solid. I especially liked that you included contextual notes for values not directly used in logic—this shows thorough RAM exploration and strong documentation skills.

### 🔲 ❗ Code Note `0x000B` Inconsistent + Achievement [Bughou](https://retroachievements.org/achievement/500187) Broken
This address is used in the logic for the achievement *Bughou*, specifically:
```
...
3: ResetNextIf Mem   8-bit 0x00000306 <=  Value       0          (0)
4: PauseIf     Mem   8-bit 0x0000000b =   Value       251        (5)
...
```
Upon testing, line [4] never allows the hit count to increment, meaning the achievement is not triggering as expected. This suggests it wasn’t tested thoroughly. You’ve already done the RAM digging needed to make this work, you just need to re-evaluate how the logic pieces fit together to make it work.

## 🧾 Additional Developer Notes

### 🔲 ❓ Set Plan Feedback
In your [Set Plan Review](https://discord.com/channels/310192285306454017/1339961840947560498), dev `suspect15` suggested adding a few more challenge achievements, which doesn’t appear to have been followed through. Additionally, it looks like one achievement from your original plan. **R-Bug** `Have all of the power-ups at the same time` was left out of the final set.

Could you clarify what led to these omissions?

## 🧪 Testing & Debugging Results

### 🔲 ❓ Development Questions
- Did you encounter any notable problems during development?
- Were there achievements you considered but ended up cutting? If so, what was the reasoning?
- Could you briefly describe your testing methodology?

# ✦───────✦ 🎮 Achievement Set Design ✦───────✦

## 🎯 Overall Set Design
- No unwelcome concepts—good work.
- `progression` and `win condition` labels are used correctly.
- Rich Presence could use some small improvements; see CodeReviewSection[📺 Rich Presence Logic].

### 🔲 ❓ More Challenge Ideas
I think adding 1–5 more challenge achievements could really elevate the set, in order give it just a bit more creativity and replay value. Below are some ideas you might consider. Of course, you know this game best, so feel free to disregard what doesn’t make sense or suit the experience you’re aiming to deliver. Just try to maintain variety and avoid making the set feel bloated, it's a short and simple game, so even a few more well crafted challenges can go a long way.

**♦ Timed Challenges**
Incorporating a few speed-based achievements might be fun. For example:
- `Beat a world within XX time`
- `Defeat XX boss within XX seconds`

These help test routing, familiarity, and overall mastery.

**♦ Power-Up Challenges**
According to this [GameFAQs guide](https://gamefaqs.gamespot.com/nes/931299-huge-insect/faqs/55958), there are:
- 4 positive power-ups
- 1 consumable (Extra Life)
- 1 negative power-up (“Skull”, which removes all power-ups)

It would be great to see these integrated more directly into achievements. One standout idea:
- `Collect all four power-ups simultaneously and finish the stage with them intact.`

You’ve already code noted `Shield` and `Laser`, but the others might require additional RAM digging. This also ties back to your originally planned (but currently missing) achievement **R-Bug**: *"Have all of the power-ups at the same time"*.

**♦ Accuracy-Based Challenges**
If possible, try to derive or simulate an accuracy system. Even a simple one could work:
- `Clear XX stage without missing a shot`
- `Finish XX stage with less than XX missed shots`
- `Defeat XX enemies in a row without missing`
- `Beat a stage without hitting any shielded enemies`

You could also experiment with percent-based thresholds if the RAM supports it.

**♦  Missable Tag Considerations**
Take care that completing specific stages with a specific challenge in mind, they probably be best marked as ´missable´ in those case. Think of a player who just wants to play through the game once and earn `Beaten` status, whilst also earning a few challenge achievement along the way. Would be interesting they could just take a look at all the missables/challenges for specific stages. So once they get to a stage, they can read what challenge is correlated to it.

### 🔲 ❓ Leaderboard Design
I strongly encourage you to develop a few leaderboards as well. Here are some ideas worth exploring:

**Timed Leaderboards**  
- Fastest world clear  
- Fastest full game completion

**Score-Based Leaderboards**  
- Highest score per world  
- Full-game high score  

Bonus: You could consider a **custom scoring formula**, incorporating not just the highscore but also:
- Lives remaining  
- Power-ups retained  
- Accuracy stats  

This would be more complex but could serve as an excellent learning project if you're up for the challenge.


## 📝 Titles & Descriptions
Titles are very creative—love to see it.

### 🔲 ❗ Description Issues
The following achievements have small phrasing issues:
- [Bugeste](https://retroachievements.org/achievement/500190)
- [Bug Flying Squadron](https://retroachievements.org/achievement/500189)

Instead of using:  
> `Have 100,000 Points`

Consider alternatives like:
> - `Earn 100,000 Points`
> - `Achieve a total of 100,000 Points`

These phrasing options better frame the task as an active goal, which is typically preferred in achievement wording.

## 🖼️ Badges
Every achievement has a unique badge, which is great to see. That said, many of them appear quite simple or low-quality in terms of resolution and clarity. There are visible compression artifacts on several of them. Some specific examples where the subject matter is hard to distinguish:
- [Fantasy Bug](https://retroachievements.org/achievement/500188)
- [194Bug: The Battle of Insects](https://retroachievements.org/achievement/500186)
- [Bugpachi](https://retroachievements.org/achievement/500185)
- [Twin Bug](https://retroachievements.org/achievement/500184)

On the other hand, [Bughou](https://retroachievements.org/achievement/500187) stands out as sharper and cleaner in comparison.

While the game’s art style may limit what you can work with, you might consider light enhancements, perhaps adding a border to give the badges more visual structure or using some mild image cleanup to remove artifacts. If you’re unsure how to proceed, you could make a request in the [#Art-Request](https://discord.com/channels/310192285306454017/1048102604963586048) channel on Discord.

## 🎖️ Point Values
The current point distribution mostly looks fine. I do have one suggestion:

### 🔲 ❓ Possible Point Increase
The `progression` and `win condition` achievements could be worth a bit more. Since the player is required to finish an entire world (rather than just a stage), it's reasonable to bump the values slightly.

In particular:
- The `Win condition` achievement could be increased to **10 points**
- Possibly do the same for **World 4**, if it’s especially lengthy or difficult

This is assuming there’s **no stage select**, meaning the player has to start over from the first stage each time. If that’s the case, the extra effort justifies the increased value.

In the end, go with what feels fair and aligns with [RAdocs - Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html), you know the game best.


# ✦───────✦ ⚙️ Technical Implementation ✦───────✦

## 🧩 Achievement Logic
While some achievements do trigger at the correct time, the logic used across the board could generally be simplified or improved. Many use unnecessary `HitCounts`, `ResetIfs`, or overly complex logic structures that aren't required. All achievements likely need at least minor fixes or refactoring to meet current best practices. See detailed notes below.

### 🔲 ❗ Achievement [Bug Flying Squadron](https://retroachievements.org/achievement/500189) Improperly Coded
`Have a total of 25 shooters`
As mentioned above, the achievement may trigger properly, but the logic is more complex than necessary.
**Current logic:**
```
  1:             Delta 8-bit 0x00000303 =   Value       25         (1)
  2:             Mem   8-bit 0x00000303 =   Value       25         (1)
  3: ResetIf     Mem   8-bit 0x00000303 <   Value       25         (0)
  4: PauseIf     Mem   8-bit 0x00000011 =   Value       164        (0)
```
**Improved logic, ommiting HitCounts:**
```
  1:             Delta 8-bit 0x00000303 =   Value       24         (0)
  2:             Mem   8-bit 0x00000303 =   Value       25         (0)
  3:             Mem   8-bit 0x00000306 !=  Value       0          (0) 
  4:             Mem   8-bit 0x00000306 <   Value       30         (0)
```
- Lines [1–2] check for the correct increment (24 → 25)
- Lines [3–4] confirm the player is in-game
Do you understand why the improved logic is preferred?

### 🔲 ❗ Achievement [StarBug](https://retroachievements.org/achievement/500182) Improvements Needed
This logic can be better structured, especially by using `Measured` to track progress and improve user feedback.
- `$0x3B7` counts kills per stage, not across the entire game.
- If the goal is to track total kills, it should persist across stages, resetting only on player death.

Current logic:
```
1:          Mem   8-bit 0x000003b7 >   Delta 8-bit 0x000003b7 (200) --> Count [StageKillCount] increments
2: ResetIf  Mem   8-bit 0x0000000b >   Value       250        (0)   --> Reset OnPlayerTakingHit (goes into I-frames after hit)
```

Improved (pseudo) logic:
```
Measured    Mem [StageKillCount] > Delta [StageKillCount]   (200)      --> Track total killcount across multiple stages
MeasuredIf  [IsInGame]          --> Only functional while in-game, not at main menu and not at game end
ResetIf     [onPlayerDeath]     --> Reset HitCount when player loses a live
```
Do you understand why above code is preferred to the current logic? 
||Measured gives useful feedback, resets properly, and encourages dynamic tracking||

### 🔲 ❗ Improper Use of Delta & ResetIf
Aside from [StarBug](https://retroachievements.org/achievement/500182), nearly all achievements misuse `Delta` and `ResetIf`. Let’s examine [Twin Bug](https://retroachievements.org/achievement/500184) `Complete World 4` as an example:
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
Do you understand why above code is preferred to the current logic and why a ResetIf wouldn't be necessary in those cases? 
||Unnecessary `HitCounts` complicate logic and aren't needed for one-time state changes.||


### 🔲 ❓ Achievement [Bughou](https://retroachievements.org/achievement/500187) Improvement Suggestions
♦ **Issues**
- Improper use of `Delta`, as previously described in other achievements.
- Use of RAM address `0xB` to detect life loss is unreliable and should be avoided.

♦ **Enhancements**
- An optional **measured indicator** could be added to provide better feedback to the player. For example, display a countdown from `5/5` to `0/5`, indicating how many lives are left before the challenge fails. This would give the player clear, live progress and serve as a good development exercise.

**Current logic**
```
  1: Trigger     Delta 8-bit 0x00000306 =   Value       30         (0)
  2: Trigger     Mem   8-bit 0x00000306 =   Value       30         (0)
  3: ResetNextIf Mem   8-bit 0x00000306 <=  Value       0          (0)
  4: PauseIf     Mem   8-bit 0x0000000b =   Value       251        (5)
  5: PauseIf     Mem   8-bit 0x00000011 =   Value       164        (0)  --> Omit this
```
- Line [4] uses an unreliable memory address to detect life loss.
- Line [5] is unnecessary and can be omitted.
- Use of `ResetNextIf` may be unnecessary here if logic is restructured properly.

**Improved (pseudo) logic:**
```
CORE (When working with Alts, the achievement will only trigger once both the CoreGroup and at least 1 AltGroup become true)
-----
              [WorldPalette] == World_5
              [IsInGame]          --> extra check, just to cancel out possible false triggers, better safe than sorry with these. The more you have of these the better to prevent false triggers.
Trigger       Delta [StageID] == Stage5_6
Trigger       Mem [StageID] == EndScreen
PauseIf       [onLifeLost]  (5)   --> when 5 lives lost, challenge failed

ALT - MEASURED GROUP (this altGroup should never unlock the achievement, it's purely for displayng a measured indicator of lives still left to lost till challenge fails. starts at 5/5, decrements by 1 each live lost)
-----
SubHits       [onLifeLost]  (5)
AddHits       val 0x1 == val 0x1    (5)     --> Always true clause, to addHit 5x
Measured      val 0x0 == val 0x1    (5)     --> Always false clause, above 2 lines function as the HitCount modifiers
MeasuredIf    [IsInGame]                    --> Only display the measured indicator when in-game
              val 0x0 == val 0x1            --> Always false clause, to make sure this AltGroup can never become true

ALT - RESET GROUP (to reset all HitCounts across all other groups)
-----
ResetIf     [AtMainMenu]
            val 0x0 == val 0x1            --> Always false clause, to make sure this AltGroup can never become true
```
Try out above logic and see if you can understand it and it's purpose? 
||The complexity stems from incorporating a `measured indicator` that counts *down*, not up. Hence, it's placed in an alternate group outside the main COREgroup.||

## 🏆 Leaderboard Logic
N/A, no leaderboards present.

## 📺 Rich Presence Logic

Logically everything looks in order, you have used some lookups/macro's very good, but I do have a few remarks.

### 🔲 ❓ Score Macro & Code Note
For your score macro, you're accessing `$0x0300` as **8-bit**, but documented it as `24-bit`.
What is actually happening is that you're accessing/using it correctly, but your code note documentation is incorrect.
I would note it as the following:
`$0x0300`
```
[8-bit] Score 0000xx
- Yes, the score is not stored as a BCD!
- Range[0x0-0x63] (0-99)
- When thisValue is 99, incrementing thisValue by 1 will reset thisValue back to 0x0 AND $0x0301 increments by 1
```
`$0x0301`
```
[8-bit] Score 00xx00
- Range[0x0-0x63] (0-99)
- When thisValue is 99, incrementing thisValue by 1 will reset thisValue back to 0x0 AND $0x0302 increments by 1
```
`$0x0302`
```
[8-bit] Score xx0000
- Range[0x0-0x63] (0-99)
- When thisValue is 99, incrementing thisValue by 1 resets thisValue back to 0x0.
- Overflow is possible and not accounted for. Thus when score is 999999, earning 1 more scorepoint resets thisValue back to 00, thus making the score 009999
```
The above splits up the 24-bit code note as 3 seperate 8-bit notes. Above is how it actually functions, with added notes on how it works, so future devs can more easily understand it.
Because of this unaccounted overflow issue, if you're using the highscore to make leaderboards, you should try to account for it, refer to [RAdocs - Score Wrapping](https://docs.retroachievements.org/developer-docs/leaderboards.html#score-wrapping).


### 🔲 ❗ Conditional RP Strings Additions
I would advise you to make use of conditional RP strings, refer to [RAdocs - Conditional Display Strings](https://docs.retroachievements.org/developer-docs/rich-presence.html#conditional-display-strings). Take a look at below suggestions and try to make these work, this would be a good learning experience. 

**Main Menu Conditional** 
A conditional display string when the [StageID] `$0x306 == 0x0` (at main menu). Currently if a player is at the main menu, the following example is displayed `Gearing Up... | Shooters: 2 | Score: 570`. Amount of shooters and score isn't used while at the main menu, thus this wouldn't be necessary to be displayed at that time.

**End Game Conditional**
A conditional display string when [StageID] `$0x306 == 0x1E` (game finished). Same as with the "Main Menu Conditional". Currently if a player is at the main menu, the following example is displayed `Defeated the Space Lobster! | Shooters: 3 | Score: 2570`. Amount of shooters and score isn't used when the game has ended, thus this wouldn't be necessary to be displayed at that time.

**In-Game**
Currently the default string should then only be displayed whilst [StageID] `$0x306 != 0x0 && $0x306 != 0x1E`, but since it's your default RP string, this wouldn't be necessary to change into a conditional display string. Alternatively you could chose which display string is the default one, then making sure the others are conditional.

Do you understand why above suggestions would be a better design for RP?
||This approach tailors the RP feedback to the player’s state in the game, keeping information relevant and accurate.||


# ✦───────✦ 🔑 Misc Prerequisites ✦───────✦

## 🔲 🧭 Hubs & Similar Games
You already did a pass on hubs to be added within your [Read for Review thread](https://discord.com/channels/310192285306454017/1342175550017503362). 
Could you try to make one final list of any more hubs/similar games to add? Think of any other (sub-)genres which may be fitting, refer to [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html)

## 🔲 🗂️ Game Page Metadata
- Genre is filled out like `Action » Shooter » Shoot-'Em-Up » Top-Down`, try to write this out better/inform me of all hubs/genres which need to be added.
- Game Title/Tags: Multiple comments on the game page, are saying this should game should be tagged as `unlicensed`, do you think it should be added? Refer to [RAdocs - Tags](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html#tags).


# ✦───────✦ 📜 Summary & Final Thoughts ✦───────✦ 

## 📋 Set Promotion TODO Checklist

Please update below list as you work through items. I would advise copying/updating it here or in a document online, which I can view/follow.
I may update this list here as you progress through the items, as well.

### 📐 Legend - TODO
🔲 TODO — Not started
🔄 WIP — Work in progress
✅ DONE — Completed
❌ CANCELED — No longer planned

### 📌 Active Tasks
🔲 ❗ Code Note `0x000B` Inconsistent + Achievement [Bughou](https://retroachievements.org/achievement/500187) Broken
🔲 ❓ Set Plan Feedback
🔲 ❓ Development Questions
🔲 ❓ More Challenges Idea's
🔲 ❓ Leaderboard Design
🔲 ❗ Description Issues
🔲 ❓ Possible Point Increase
🔲 ❗ Achievement [Bug Flying Squadron](https://retroachievements.org/achievement/500189) Improperly Coded
🔲 ❗ Achievement [StarBug](https://retroachievements.org/achievement/500182) Improvements Needed
🔲 ❗ Improper Use of Delta & ResetIf
🔲 ❓ Achievement [Bughou](https://retroachievements.org/achievement/500187) Improvement Suggestions
🔲 ❓ Score Macro & Code Note 
🔲 ❗ Conditional RP Strings Additions
🔲 🧭 Hubs & Similar Games
🔲 🗂️ Game Page Metadata

### 📌 Additional Tasks
🔲 Testing after logic changes
🔲 Revision of most achievement logic
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

When the full checklist is completed and confirmed, we can proceed with finalizing the review and begin discussing the set’s promotion. Until then, feel free to ping me anytime if you’ve completed the task list or have further questions, I’ll be happy to review things again when ready.

## 📚 Final Thoughts

You’re on the right track. However, there are still several foundational aspects of the toolkit and logic structure that need deeper understanding and consistent application. Quality achievements rely on solid logic, well-structured design, and that's where your focus should be for now.

Once the technical cleanup, logic revisions, and polish are done, I’m confident this will become a fun, compact, and charming set, a great fit for the RA ecosystem. Your initiative and progress so far are appreciated, and every step forward is part of learning the craft. Stay consistent, ask when in doubt, and keep going, you’re getting there.






# %%%%%%%%%%%%% POST-INITIAL CODE REVIEW %%%%%%%%%%%%% #

# ✔️ Wrap-Up & Next Steps
## 🎓 Reflection & Suggestions
/// Reflection on what was learned + Feedforward (suggestions for future Jr. Dev process).