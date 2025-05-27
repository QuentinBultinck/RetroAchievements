# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Code Review => https://discord.com/channels/310192285306454017/1368699416575475813
Set Plan Review => _DISCORD_LINK_TO_SET_PLAN_REVIEW_
Ready for Review Thread => _DISCORD_LINK_TO_READY_FOR_REVIEW_
RA Game Page => https://retroachievements.org/game/13588?f=5
 
# ------CR TODO List------ (for use by CR)
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

# ------TODO Legend------
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out
- ❌ CANCELED — Task was dropped or no longer applicable

# ------Usefull unicode characters------
✅ ☑️ ✔️ 🆗
ℹ️   🛈
❌  ✖️
❗  ‼️  ⚠️ 🟨
❓ ⁉️  🚩
💡
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
⏳

### ❓ Achievement [G](https://retroachievements.org/achievement/482465) Single Letter Title
Only one letter title? Could you elaborate on this choice?

### ❗ Achievement [G](https://retroachievements.org/achievement/482465) Broken
Broken because ...

### ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) Improvement Suggestion
Do this instead of that...

# %%%%%%%%%%%%% CODE REVIEW: RayForce %%%%%%%%%%%%% #

Hello @kssfilo

Your Code Review for [RayForce | Gunlock (Arcade)](https://retroachievements.org/game/13588?f=5) is finally locked and loaded!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out and ping me.

# 📑 Table of Contents
### 🧠 Memory Work & Internal Notes _MSG_LINK_ 
`xx TODOs`
- 🛠️ RAM Digging & Code Notes
- 🧷 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🕹️ Achievement Set Design _MSG_LINK_
`xx TODOs`
- 🎯 Overall Set Design
- ✍️ Titles & Descriptions
- 🖼️ Badge Art
- ⚖️ Point Distribution
### ⚙️ Technical Implementation _MSG_LINK_
`xx TODOs`
- 🧩 Achievement Logic
- 🔧 Rich Presence Logic
- 🔢 Leaderboard Logic
### 🔑 Misc Prerequisites _MSG_LINK_
`xx TODOs`
### 📜 Summary & Final Notes _MSG_LINK_

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦



## 🛠️ RAM Digging & Code Notes
Everything seems in order here. You’ve primarily worked with [8-bit] values — one [16-bit] address is code noted and used in RP.
It’s clear you understand how to work with BCD, and you’ve demonstrated some awareness of identifying BitFlags or working within bitfields, which is great.

### 🔲 ❓ Code Notes *"Fingerprint"*
Referring to code notes: `$0x59ba`, `$0x5a32`, `$0x1c628` & `$0x5b9a`
These values appear to track object destruction or similar behavior, but the logic behind them is unclear. They seem to work in a non-obvious way — possibly as indirect indicators of something being destroyed.
Could you explain exactly how these addresses function? If they’ve been tested thoroughly and behave consistently, that’s acceptable — but please clarify both here and directly in the code notes. It’s important that other developers (and maintainers) can follow the logic at a glance.

### 🔲 ❓ Code Notes *"Stage Progression"*
There are multiple RAM addresses labeled as `Stage Progression`. How do these differ, and which one is the actual controlling value? Why are there multiple?
Take achievement [Highway Havoc](https://retroachievements.org/achievement/484614) for example:
```
  1: AndNext     Mem   8-bit 0x00002312 =   Value       5          (0)
  2: AndNext     Mem   8-bit 0x00003ce8 =   Value       0          (0)
  3: AndNext     Mem   8-bit 0x000000bd >=  Value       1          (0)
  4: AndNext     Mem   8-bit 0x000000bd <=  Value       16         (0)
  5: AndNext     Mem   8-bit 0x0000569c <=  Value       34         (0)
  6: Measured    Mem   8-bit 0x000038ce !=  Delta 8-bit 0x000038ce (15)
  7: ResetIf     Mem   8-bit 0x000022e5 =   Value       1          (0)
```
- Line[2] appears to check if Stage Progression is 0.
- Lines[3-5] check if it's within a specific range.
Can you confirm how this all ties together?

### 🔲 ❓ Code Notes `$0x38d0` & `$0x38ce` 
These seem to relate to the enemy kill count — split into two values. Could you elaborate on how they function?

Is one of them tracking lower-layer kills (auto-targeted lasers), and the other upper-layer kills (manual shots from the player ship)?
If so, please make sure this distinction is clearly described in the relevant code notes. Ideally, any reviewer or future developer should be able to understand the mechanic by reading the notes alone — especially when the logic isn’t immediately obvious.



## 🧾 Additional Developer Notes
N/A

## 🧪 Testing & Debugging Results

### 🔲 ❓ Testing Clarification
I’m unsure how extensively the achievements have been tested. Could you share a bit about your testing process?
- Were there any bugs or edge cases you had to deal with?
- Did you have concepts that couldn’t be implemented?
- Were any softcore/hardcore differences considered?
A brief overview here would be helpful (and/or in the forum thread for any achievement concepts you were unable to create).




# ✦═══════✦ 🎮 Achievement Set Design ✦═══════✦


## 🎯 Overall Set Design  

Overall, the set looks solid. It covers the full game, includes complementary achievements that expand the gameplay experience, and features a few creative challenges and custom side-objective achievements.

### 🔲 ❓ Missables
No achievements are currently marked as `missable`. Could you explain why you believe that’s the best approach?
I think the following achievements could reasonably be flagged as `missable`:
- [Bridge Buster](https://retroachievements.org/achievement/484611)
- [Sinking the Armada](https://retroachievements.org/achievement/486249)
- [Island Downfall](https://retroachievements.org/achievement/484612)
- [Tower Toppler](https://retroachievements.org/achievement/484613)
- [Highway Havoc](https://retroachievements.org/achievement/484614)
- [Node Annihilator](https://retroachievements.org/achievement/484824)
- [Hatch Obliterator](https://retroachievements.org/achievement/484825)
These seem like optional or "side-quest"-type achievements. Think about a player going for a one-and-done playthrough to earn the `Beaten` status — they could easily miss these without realizing. Elaborate what you think would be the best approach, as you know more of the game than I do.

### 🔲 ❓ Game Difficulty
All achievements and leaderboards currently work regardless of selected difficulty. Please elaborate on why this was chosen.

How does the game differentiate difficulty levels? Is it just enemy quantity, or do mechanics change as well? Given that the player always dies in one hit, difficulty differences may not be obvious — but that makes it even more important to consider unique challenges for higher difficulty modes.

It feels like a missed opportunity to not incorporate difficulty-based challenges. This issue also impacts the leaderboards — see the relevant note in Code-Review-Section[🏆 Leaderboard Logic].

### 🔲 ❓ Achievement [Ready for Score Attack](https://retroachievements.org/achievement/484580)
This leans toward an [Unwelcome Concept: Zero Effort Without Purpose](https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html#zero-effort-without-purpose)
Instead of keeping it as-is, consider embedding this information (how to change difficulty) into another achievement with an actual difficulty requirement — e.g., *“Complete Area 1 on Very Hard difficulty doing xx challenge.”* The note about using the Test Menu (`Hold Start`) could then be used in the description — either in that one achievement or as a returning piece of text within all difficulty-based challenge achievements.

### 🔲 ❓ Achievement [8 Ball](https://retroachievements.org/achievement/482545)
`Lock on 8 enemies at once and fire at them`
It works fine, but might be more satisfying if it only unlocked after killing all 8 locked-on enemies with a single volley. Not sure if this is technically feasible or trackable with current tools — but if it is, it could elevate the design somewhat.

### 🔲 ❓ Achievement [Pacifist Pilot](https://retroachievements.org/achievement/482547) - Viability & Difficulty + Player Death Reset Not Mentioned
Is this actually viable? How can the player beat Stage 1 without defeating the boss? Can they simply dodge until the stage just moves on to the next one?
Also, you’re not mentioning in the description whether dying resets progress. It does work like that in logic from what I've seen, this is critical information for an achievement like this.




## 📝 Titles & Descriptions  Writing looks generally good and consistent.
However, there's a notable omission: the achievements don’t account for Player 1 vs. Player 2 distinctions. See Code-Review-Section[⚙️ Technical Implementation > Player 2 Issue].
What happens if someone uses Player 2 instead — or joins mid-stage?

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465)
A single-letter title? Could you clarify the intent behind this choice?

### 🔲 ❗ Leaderboard Title Case Issue
- [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855)
- [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856)
`was Broken` ---should be written as---> `Was Broken`. This issue was documented by the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/).

### 🔲 ❓ Leaderboard Series [High Score at Stage 1 End](https://retroachievements.org/leaderboardinfo.php?i=122264)
Why are there only 3 of these leaderboards when the game has 7 stages? Please clarify your design choice—was this an intentional cutoff, or are the others pending?.

### 🔲 ❗ Progression & WinCondition Achievements: Titles Using Level Name
These use the stage names as titles. While that’s technically allowed, it doesn’t make for very engaging design.
Consider renaming them with more creative or thematic titles — see [RAdocs - Creative Titles](https://docs.retroachievements.org/guidelines/content/writing-policy.html#creative-titles).



## 🖼️ Badges 

Badge art is... serviceable, but minimal. Most look like cropped screenshots with simple borders. They technically match the associated achievement, but lack polish.
Some are difficult to visually identify. If you're low on ideas or need help, consider using the [#art-requests](https://discord.com/channels/310192285306454017/1048102604963586048) channel on Discord.

### 🔲 ❓ Badge Art Question - Non-game Art
For the following achievements:
- [8 Ball](https://retroachievements.org/achievement/482545)
- [Pacifist Pilot](https://retroachievements.org/achievement/482547)
Are you sure these use actual game assets and not external or default icons? If they aren't from the game, they need to be replaced.

Please review:
- https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html
- https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html




## 🎖️ Point Values  
From what I understand, there’s no stage select — the game must be started from Stage 1 each time. If true, then the current point distribution is reasonable and balanced.

### 🔲 ❓ Progression & WinCondition Achievements: Points
Consider increasing the point values for later-stage achievements, such as:
- [Toward the Darkness](https://retroachievements.org/achievement/482081)
- [The End of Deep Layer](https://retroachievements.org/achievement/482082)
- [Releasing Infinitely](https://retroachievements.org/achievement/482083)
This could be offset by slightly lowering the points for the earlier achievements to create a more rewarding progression curve — similar to your “no-death stage completion” achievements. 





# ✦═══════✦ ⚙️ Technical Implementation ✦═══════✦

### 🔲 ❗ Player 2 Issue (Achievements, Leaderboards, RP)
From what I can tell, you're not accounting for Player 2 in most of the set. Only the achievement [Body Guard](https://retroachievements.org/achievement/482594) partially considers Player 2, but even that’s incidental because of the challenge itself.

**Achievements**
Take the achievement [Penetration](https://retroachievements.org/achievement/482464) `Complete Stage 1 without dying`
- What happens if Player 2 joins and dies?
- What if I use only Player 2’s slot from the start? Can I play from start to finish as just Player 2 and still earn the achievements?

Another example is [X-LAY Pro](https://retroachievements.org/achievement/482546) `Upgrade the main shot to level 6 and the lock-on laser to level 8`
- What if Player 2 earns these upgrades instead of Player 1?

Are progression achievements designed to account for Player 2?
Are the challenge achievements appropriately balanced for two players?

**Opt-in/Opt-out Behavior**
I've tested it—Player 1 and 2 can join or leave at any time, based on game settings or on death. Since this behavior wasn’t considered in the design, you’ll likely need to either:
- Redesign a large portion of the set to account for both players (you would earn some browny points)
- Update the achievement descriptions to explicitly state that they apply only to Player 1 (this is the simpler option).

Ideally, I’d recommend redesigning everything with Player 2 in mind—it would significantly improve your skill and the quality of the set.

**Leaderboards & RP**
This issue extends to leaderboards and Rich Presence as well. They don’t seem to account for Player 2 joining mid-game.

**Fixing This Problem**
You need to make a clear decision on multiplayer support:
> ❌ If multiplayer is not allowed, update all descriptions and add logic to disallow Player 2 (e.g. memory checks).
> ✅ If multiplayer is allowed, update logic to support achievements being earned by either player.

An additional option is creating a **[Subset - Multiplayer Cooperative]**, where:
- The **BaseSet** supports only solo play (1P active only).
- The **Subset** supports co-op and REQUIRES input from both players.

Another option is partially allowing multiplayer, where any player can unlock achievements—though this may raise balancing issues.

Relevant hubs: 
- [Meta - Set Disallows Multiplayer](https://retroachievements.org/hub/26213)
- [Meta - Set Allows Multiplayer](https://retroachievements.org/hub/22986)
- [Meta - Set Partially Allows Multiplayer](https://retroachievements.org/hub/7115)

## 🧩 Achievement Logic 

### 🔲 ❓ Achievement [Space Ace Pilot](https://retroachievements.org/achievement/482889) 
**Kill Count**
You're using `$0x38d0` & `$0x38ce` to count 140 kills, but it seems like the Stage 1 boulders seem to count for more than 1 enemy.
- Are the boulders actually enemies? They feel more like destructible hazards or obstacles.
- Either reword the achievement or improve the logic to distinguish enemies vs. debris.

**Missing Delta Check**
This logic lacks a delta check The latest version of [AutoCR](https://authorblues.github.io/retroachievements/AutoCR/) flags this.

**Altenative method without using a "PauseLock"**
Your current logic:
```
  1: AndNext     Mem   8-bit 0x00002312 =   Value       1          (0)
  2: AndNext     Prior 8-bit 0x000105ff =   Value       0          (0)
  3: AndNext     Mem   8-bit 0x000105ff =   Value       72         (0)
  4: MeasuredIf  Mem   8-bit 0x00003ce8 <=  Value       15         (0)
  5: AddSource   Mem   8-bit 0x000038d0 *   Value       65         
  6: Measured    Mem   8-bit 0x000038ce >=  Value       140        (0)
  7: ResetNextIf Mem   8-bit 0x000022e5 =   Value       1          (0)
  8: PauseIf     Mem   8-bit 0x00004b94 <   Delta 8-bit 0x00004b94 (1)
  9: PauseIf     Mem   8-bit 0x00002312 >   Value       1          (0)
```

Alternative pseudo logic, without the use of `PauseIfs` and `ResetNextIf`
```
MeasuredIf  [StageStartsFromBeginning]  (1)     --> delta check [8-bit: Game State], check if it changes to 0x48      
Measured    [EnemyKillCount >= 140]
ResetIf     [StageID != stage_1]
ResetIf     [onPlayerDeath]                     --> delta check
ResetIf     [IsInNotGame]
ResetIf     [StageProgression > xx]
```
Line[1] is pretty much the StartCondition. This will reset by any of the ResetIfs.
This design eliminates unnecessary PauseIf/ResetNextIf, using a clean start condition and specific resets.
Do you see why this new alternative logic works? 

### 🔲 ❓ [Penetration](https://retroachievements.org/achievement/482464) - Slight Change
```
  1: AndNext     Delta 8-bit 0x000105ff =   Value       0          (0)
  2:             Mem   8-bit 0x000105ff =   Value       72         (1)
  3:             Mem   8-bit 0x00002312 =   Value       1          (1)
  4: AndNext     Delta 8-bit 0x00002312 =   Value       1          (0)
  5: Trigger     Mem   8-bit 0x00002312 =   Value       2          (0)
  6: ResetIf     Mem   8-bit 0x00004b94 <   Delta 8-bit 0x00004b94 (0)
```
- Suggest adding a check so it only unlocks while [8-bit: Game State] == inGame

### 🔲 ❓ Achievement [Island Downfall](https://retroachievements.org/achievement/484612) - HitCount
You're using a `HitCount` of 2 on `$0x1c628` with delta checks for destruction.
- Is there more than one island?
- If not, remove the `HitCount`, and ensure it only counts the one actual destruction.

### 🔲 ❗ Achievement [Body Guard](https://retroachievements.org/achievement/482594) - Possible Problems
- What if Player 2 joins right before the stage ends? You're only checking conditions at the end of Stage 1.
- Add a delta on your `Trigger` flag, `$0x3ce8` (Stage Progression).
- Make sure Stage 1 starts with both players active.

```
  1: AndNext     Delta 8-bit 0x000105ff =   Value       0          (0)
  2:             Mem   8-bit 0x000105ff =   Value       72         (1)
  3:             Mem   8-bit 0x000022e9 =   Value       255        (0)
  4: Trigger     Mem   8-bit 0x00003ce8 =   Value       16         (0)
  5: ResetIf     Mem   8-bit 0x00004c94 =   Value       0          (0)
  6: ResetIf     Mem   8-bit 0x0000009a !=  Value       255        (30)
```
- Does Line[5] reliably check for Player 2’s life status? 
- Why not just use a delta to detect decrement of [Player 2 Lives]? It may be more accurate.




## 🏆 Leaderboard Logic

### 🔲 ❗ Submit Groups: Missing Delta's
It looks like none of your SUBMIT groups use delta checks. This is a best practice that should always be followed. Both START and SUBMIT should include at least one delta check to avoid false triggers.
A simple fix would be to submit:
- On player death (using a delta on lives or game state)
- OR, when `[8-bit: Game State]` transitions from `0xFF` (eg. via delta check)


### 🔲 ❓ Leaderboards & Difficulty Scaling
Currently, playing on the hardest difficulty yields the same score as playing on the easiest, which may not be ideal design. Consider:
- Creating separate leaderboards per difficulty level
- OR, adding a difficulty modifier to the score (eg. multiplying the score or applying a scaling formula)
The challenge is that modifying the score means the RA-submitted value won't match what’s shown in-game. If you go this route, document it clearly in the leaderboard name or description.
Alternatively, consider polling the community in the [#poll-me](https://discord.com/channels/310192285306454017/511718348178849792) RAdiscord channel for opinions.


### 🔲 ❗ Leaderboard Spam
All your leaderboards appear to activate at the game's start, causing 20+ seconds of constant RA overlay popups. Consider minimizing this “leaderboard spam”:
- Use instant Start/Submit leaderboards wherever possible—especially for highscore-based boards, since the highscore is always shown on screen.
- Only use primed/RA leaderboard overlays for measured data that isn’t immediately visible to the player.
- [8 Ball Madness](https://retroachievements.org/leaderboardinfo.php?i=122542) is arguably the only leaderboard that justifies being primed, as it counts specific lock-on events not shown in-game.

Additionally, implementing a basic filter condition, such as:
- Requiring the player to complete Stage 1
- OR, reach a minimum score threshold before submission.
This would help reduce RA overlay spam when a new player boots up the game, presses any button, or dies quickly.

**Leaderboard [8 Ball Madness](https://retroachievements.org/leaderboardinfo.php?i=122542)**
As mentioned, this is the only leaderboard that should probably remain primed. However, the design itself could be improved.

Consider changing it to something like:
> “Take out as many enemies as possible with a full 8-laser volley.”

This would measure enemies killed per volley, rather than just how many volleys were fired, making the challenge feel more skill-based and rewarding.
Same recommendation applies to the related achievement [8 Ball](https://retroachievements.org/achievement/482545). It’s up to you to test feasibility here. If this can’t be done due to game limitations, document why and consider alternate ideas. If it's not possible, it's not that big of a deal...

### 🔲 ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) & [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856) - Submit vs Cancel
You could improve these by also submitting the leaderboard if the player does use the restricted ability (instead of just canceling). This would allow the leaderboard to reflect when the constraint is broken.
Also, as with other leaderboards, consider requiring:
- Completion of at least Stage 1
- OR, a minimum highscore to prevent early-game spam, overlay noise and low scored submissions.

## 📺 Rich Presence Logic 
Rich Presence is dynamic and well-formatted.
That said, Player 2’s data is not included—you may want to consider adding that information too. Let us know of a player is playing in coop mode or not.

### 🔲 ❗ Frame Counter Issue
`$0x38c8` is used to determine seconds passed while in-game I presume. But this 16-bit value only counts up to 0xFFFF (= 65535 seconds), I've tested this RAM address and it seems to stop at 18:20. Since the fastest speedrun is above 20 mins, I have doubts this could be used to determine time spent in-game. Try to find another way to make this work if possible, otherwise remove this from RP. 

# ✦═══════✦ 🔑 Misc Prerequisites ✦═══════✦

## 🔲 🧭 Hubs & Similar Games
Are there any additional hub tags or similar game links you can add to the game page?
This not only improves discoverability but helps categorize the game within the broader RA ecosystem. Think in terms of:
- Gameplay genre (eg. Shmup, Arcade, 2D Scroller)
- Developer or publisher-based hubs
- Multiplayer/co-op support if applicable
- Regional or clone variants if this game has any

Refer to the [Hub Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html#hubs-and-similar-games) for naming conventions and examples. Adding the right hubs shows attention to detail and helps contextualize your set for players and other developers.

## ✅ 🗂️ Game Page Metadata 
All required metadata appears to be filled out properly.
This includes title, box art, release date, console, developer, and other core identifiers.
No immediate issues here.



# ✦═══════✦ 📜 Summary & Final Notes ✦═══════✦
You've created a solid foundational set, and despite the game’s relatively simple design, you've succeeded in crafting several thoughtful and creative challenges that extend its replayability and test the player's mastery. The achievement logic demonstrates a growing familiarity with RA’s toolset and suggests a desire to engage with both gameplay design and technical nuance.

However, there are still numerous design oversights and inconsistencies, many of which are highlighted in the ❗(critical) and ❓(questionable) notes throughout this review. These include:
- **Lack of multiplayer logic consideration**: Most achievements, leaderboards, and RP elements don’t properly handle or account for player 2, despite the game allowing co-op on-the-fly. This needs a clear stance—either fully support multiplayer or explicitly disallow it with adjusted logic and descriptions.
- **Leaderboard spam and lack of delta protections**: Most leaderboards start too eagerly and without proper conditions, creating an overwhelming experience for new users and triggering unnecessary overlay clutter.
- **Difficulty balance in leaderboards**: Currently, score-based leaderboards don’t distinguish between difficulties. This may diminish the competitive integrity of the set.
- **Some logic may be overly complex or missing key protections**: Achievements like [Space Ace Pilot](https://retroachievements.org/achievement/482889) could benefit from cleaner logic with clearer triggers, resets, and delta checks.
- **Achievements and leaderboards may not always represent player intent**: This includes how actions are tracked (or not tracked) by player slot and how volatility (like using an ability or dying instantly) triggers submissions or cancels them.

Before promotion, **every major concern listed in this review must be addressed**. This includes reworking logic where necessary, updating achievement/leaderboard descriptions to clarify intent, and testing edge cases—especially involving multiplayer interaction.

### Suggestions
- Re-run the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/) against all achievements to catch any further logic errors, delta issues, or bad flags.
- Consider using the [jr-devs](https://discord.com/channels/310192285306454017/533411674162593812) chat, or [poll-me](https://discord.com/channels/310192285306454017/511718348178849792) channel in RA Discord to gather feedback—particularly around the difficulty-scaling question and potential leaderboard redesigns.
- If multiplayer functionality will be partially or fully supported, consider a [Subset - Multiplayer Cooperative] as discussed, or implement proper flag tracking across both player slots for fairness and clarity.

### Final Readiness
You’ve demonstrated creative intent and some technically sound implementation, but the current state of the set still falls short of set promotion readiness. Once the core issues outlined above are resolved—and if you can confidently ensure proper behavior across both single and multiplayer use cases—this set will be much stronger and ready for broader recognition.




# %%%%%%%%%%%%% POST-INITIAL CODE REVIEW %%%%%%%%%%%%% #

# ✦═══════✦ 🔍 CR Reassessment Round #1  ✦═══════✦

## ∘───── 🛠️ Tasks / Issues ─────∘ 

### ❓ Achievement [Ready for Score Attack](https://retroachievements.org/achievement/484580) NullPointer & Game Settings
You may want to consider making this a zero-point achievement if you still want to include it in the set.

If the difficulty setting doesn’t meaningfully affect gameplay mechanics, is it really necessary to require the player to use a specific difficulty level or a specific number of lives?
In cases like this, it’s usually best to let the player choose whichever settings they prefer, especially if it won’t impact the challenge or experience in any significant way.

Then ask yourself again should an achievement like this, be in the set? It feels purely informational in that case to let the player know he has to put chose specific game settings, that actually aren't checked within any of achievements logic. Well that's my take on it, it's up to you to make the choice to keep it or remove it. Do what you feel is best.

### ❗ Achievement [Pacifist Pilot](https://retroachievements.org/achievement/482547) Checkpoint HitCount Misuse 
Current logic:
```
1:  Delta 8-bit 0x000105ff =   Value       0x0          (1)
2:  Mem   8-bit 0x000105ff =   Value       0x48         (0)
...
```
You probably want to check if `[Game State] $0x105ff` changes from 0x0 to 0x48 instead.
By doing the following:
```
AndNext   Delta 8-bit 0x000105ff =   Value       0x0          (0)
          Mem   8-bit 0x000105ff =   Value       0x48         (1)
...
```
This properly checks if the game was started from the beginning or not. Do you see why your code wouldn't have properly checked this?
I think this may have been an oversight because you're doing it correctly for achievement [Space Ace Pilot](https://retroachievements.org/achievement/482889).

### ❗ Achievements Descriptions (solo only, without dying)
You added the requirements `solo only` and `without dying` to certain descriptions, but I think they would be better written if you added in some comma's and moved some parts around.
**Improvement Examples**:
- Complete Stage 1 in solo mode, without shooting or dying
- Complete Stage 1 in solo mode, without dying

### ❗ Achievement [Body Guard](https://retroachievements.org/achievement/482594) Description Improvement
Current description feels a little too convoluted, especially the first half.
**Current**: `Start the game using the 2P start button before the 1P start button, and reach the boss of Stage 1 without controlling 2P and before all of 2P's lives are lost.`
**Suggestion**: `Start the game using the 2P start button, then join as 1P and reach the Stage 1 boss without losing all of 2P's lives, without taking control of 2P`

### ❓ Leaderboard [High Score No Misses](https://retroachievements.org/leaderboardinfo.php?i=122182) Remarks
**Stage 2 Requirements**
This leaderboard only submits when past Stage 1, according to SUBMIT:CoreGroup:Line[2], this is very well. But make sure this requireement is also reflected into the description. Regard this remark for all leaderboard where you implemented/changed this.

**Logic Question**
I don't seem to understand SUBMIT:AltGroup[1]:Line[1]. Are you sure this works, looks kinda weird, but idk exactly how value work, from your documentation in the code notes. It feels like something weird is going on there.
SUBMIT:AltGroup[1] Logic:
```
1:  Delta 8-bit 0x00004b94 >=  Mem   8-bit 0x000022b3 (0)
2:  Mem   8-bit 0x00004b94 <   Delta 8-bit 0x00004b94 (0)
```

**Instant Start/Submit?**
This leaderboard also uses the highscore in VALUE, I would also suggest you find a way to make this leaderboard also work with an instant Start/Submit. 
Possible Solution: ||Try to start/submit when the player dies||
This in contrast to leaderboard [High Score](https://retroachievements.org/leaderboardinfo.php?i=122181), which instant Start/Submits when either:
- Back to mainMenu (from in-game)
- Game Ending achieved
- All lives lost?? (I don't know if this is a thing, what about continues?)

### ❓ Rich Presence 1P - 2P
You edited the RP regarding 2P, which is great, but does RP still work when only 2P is connected?

## ∘───── 📋 TODO Checklist  ─────∘ 
- **Initially Posted on**: `7 May 2025` - `Reassessment Round #1`
- **Last Updated on**: `12 May 2025` - `Checklist Assessment #1-1` // CR_TODO Checklist Assessment #_next_

### ---⇢ 📐 TODO Legend ⇠---
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out
- ❌ CANCELED — Task was dropped or no longer applicable

### ---⇢ 📌 Initial Code Review Tasks ⇠---
### ✅ ❓ Code Notes *"Fingerprint"*
These code notes have been changed, they're much more clear to understand.
### ✅ ❓ Code Notes *"Stage Progression"*
Code notes have been updated, they're understandable now, although yes somewhat still abstract, put use cases are clear.
### ✅ ❓ Code Notes `$0x38d0` & `$0x38ce`
Code notes are much more clear this time. I like that you added the formula, very good.
### ✅ ❓ Testing Clarification
### ✅ ❓ Missables
Added missables where dev deemed necessary
### ✅ ❓ Game Difficulty
Difficulty differences not noticeable, thus disregard this game mechanic
### ✅ ❓ Achievement [Ready for Score Attack](https://retroachievements.org/achievement/484580)
### ✅ ❓ Achievement [8 Ball](https://retroachievements.org/achievement/482545)
### ✅ ❓ Achievement [Pacifist Pilot](https://retroachievements.org/achievement/482547) - Viability & Difficulty + Player Death Reset Not Mentioned
Achievement is viable + Player Death requirements has been added to description
### ✅ ❓ Achievement [G](https://retroachievements.org/achievement/482465)
### ✅ ❗ Leaderboard Title Case
### ✅ ❓ Leaderboard Series [High Score at Stage 1 End](https://retroachievements.org/leaderboardinfo.php?i=122264)
Dev feels like leaderboards for stages 4-7 wouldn't be engaging enough, since they're very hard. (very well)
### ✅ ❗ Progression & WinCondition Achievements - Titles Using Level Name
Made [post in Writing-Forum](https://discord.com/channels/310192285306454017/1315144417375424552), so titles are already fine.
### ✅ ❓ Badge Art Question - Non-game Art
[Post in Art-Forum](https://discord.com/channels/310192285306454017/1369176386538962944) to improve badge art is done.
### ✅ ❓ Progression & WinCondition Achievements - Points
Now there's more gradual increase in points through progression achievements.
### ✅  ❗ Player 2 Issue (Achievements, Leaderboards, RP)
- ✅  Achievement logic updated
- 🟨  Leaderboards issue persists. DISMISSED this task has been moved to an additional task
- ✅  RP updated
### ✅ ❓ Achievement [Space Ace Pilot](https://retroachievements.org/achievement/482889) 
### ✅ ❓ Achievement [Penetration](https://retroachievements.org/achievement/482464) - Slight Change
Was updated with Player 2 Issue, but redundant line still exists
### ✅ ❓ Achievement [Island Downfall](https://retroachievements.org/achievement/484612) - HitCount
### ✅ ❗ Achievement [Body Guard](https://retroachievements.org/achievement/482594) - Possible Problems
### ✅ ❗ Submit Groups: Missing Delta's
### ✅ ❓ Leaderboards & Difficulty Scaling
### ✅ ❗ Leaderboard Spam
Implemented instant Start/Submit leaderboards
### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) & [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856) Submit vs Cancel
Implemented instant Start/Submit fir these leaderboards
### ✅ ❗ Frame Counter Issue
### ✅ 🧭 Hubs & Similar Games
May consider Similar Games[Xevious,After Burner]
### ✅ 🗂️ Game Page Metadata

### ---⇢ 📌 Reassessment Round #1 Tasks ⇠---
### ✅ ❓ Achievement [Ready for Score Attack](https://retroachievements.org/achievement/484580) NullPointer & Game Settings
Achievement marked as [VOID].
### ✅ ❗ Achievement [Pacifist Pilot](https://retroachievements.org/achievement/482547) Checkpoint HitCount Misuse 
Logic has been fixed
### ✅ ❗ Achievements Descriptions (solo only, without dying)
Descriptions updated
### ✅ ❗ Achievement [Body Guard](https://retroachievements.org/achievement/482594) Description Improvement
Description updated
### ✅ ❓ Leaderboard [High Score No Misses](https://retroachievements.org/leaderboardinfo.php?i=122182) Remarks
Dev has revamped logic to only allow entries with a min. score of 100,000 points. Although the description could be updated to reflect this minimum requirement.
### ✅ ❓ Rich Presence 1P - 2P
### ✅ ❗ Leaderboard Descriptions
Writing-request ongoing regarding this.
### 🔄 ❗ Leaderboard 2P Issue
Jr is going to add an additional leaderboard focussing on High Score whilst in multiplayer mode.
Other leaderboards will be limited to the 1P slot only.

### ---⇢ 📌 Wrap-Up Tasks (before set promotion) ⇠---
### 🔄 Testing after logic changes
### ✅ Upload & Credit New Badges by `@Vlt0`
New Art has been uploaded and credited, refer to https://discord.com/channels/310192285306454017/1369176386538962944
### 🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
### 🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

### ---⇢ 📌 Additional Tasks (post-set promotion) ⇠---
🔲 Write/Submit RAnews Set Highlight [Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview)



# ✦═══════✦ 🔍 CR Reassessment Round #2  ✦═══════✦
- **Initially Posted on**: `27 May 2025`

@kssfilo I re-evaluated all your changes you made and it seems there's only two remaining issues, I spotted.  So once you addressed these last remarks. We can probably move to wrap up this code review.  Ping me again once you've taken a look at the issue and made any changes if necessary.

### 🔲 ❗  Achievement [Hatch Obliterator](https://retroachievements.org/achievement/484825) Issues
Seems like you've made smart use of R/R flags here, translating a values Mem/Delta difference into hitcounts, something I haven't thought of this yet myself, will definitely add this to my skills as well.

**2P**
Since the current logic onlys checks for 1P's input, this probably isn't functional for 2P?
The description doesn't mention that this achievement is only available in solo mode. Thus either add additional logic to allow 2P to unlock this as well or update the description accordingly.

**Points**
I think this may be better scored as a 10-pointer instead of 25-pointer, refer to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html). Although in the end it's your choice. Since the player still has to get to Area 7 and then complete this challenge. So it might be OK at that score.

### 🔲 ❗ Leaderboard [8 Ball Madness](https://retroachievements.org/leaderboardinfo.php?i=122542) 2P Issue
It seems this leaderboard may only be functional for 1P? If this is intented, just as mentioned with above issue: 
The description doesn't mention that this achievement is only available in solo mode. Thus either add additional logic to allow 2P to unlock this as well or update the description accordingly.

# %%%%%%%%%%%%% CODE REVIEW WRAP-UP %%%%%%%%%%%%% #

# ------Promotion Steps (useful for CR)------ 
0. First post [Wrap-Up & Next Steps] section in Code Review Thread

## ---------When not promoted to full dev---------
1. Take set/game out of `(In Review)` on RA game page, if necessary. By pressing `Complete Claim Review` in `Dev` drop down menu
2. Promote all achievements to official, disregard achievements marked `[VOID]`
3. Tell Junior to complete claim via `Dev` drop down menu
4. Post `Achievement News Announcement`, reviewed by Junior
5. Post [✒️ RANews Set Highlight] in Code Review to fill out the form 

## ---------When promoted to full dev--------
1. Take set/game out of `(In Review)` on RA game page, if necessary. By pressing `Complete Claim Review` in `Dev` drop down menu
2. Tell Junior/new dev to promote all achievements to official, disregarding achievements marked `[VOID]`
3. Tell Junior to complete claim via `Dev` drop down menu
4. Let Junior post `Achievement News Announcement`
5. Post [✒️ RANews Set Highlight] in Code Review to fill out the form

6. Fill out & update Proficiecy-Checklist 

#  ✦═══════✦ :check: Wrap-Up & Next Steps ✦═══════✦ // TODO
/// Final phase and closing guidance.

### ---⇢ 🎓 Retrospective ⇠--- // TODO
/// Summarize/reflect what went well (positive observations) and what didn’t (key challenges or mistakes). Highlight any significant learning moments or improvements made during development/code review.

### ---⇢ 🤔 Suggestions ⇠--- // TODO
/// Recommend areas for growth using the [Proficiency Checklist]. This may include tools or skills that weren’t demonstrated during the set development.
/// What is evaluated? Refer to [RAdocs - Jr Dev Graduation Consideration](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html)
/// Suggestions may include:
/// - Review other developers’ Code Reviews for common pitfalls and strong practices.
/// - Use Discord help channels frequently — don’t hesitate to ask for feedback.
/// - Keep [AutoCR](https://authorblues.github.io/retroachievements/AutoCR/) handy while working; it’s an essential tool.

## ∘───── 🌟 Achievement Unlocked! ─────∘ // TODO, only include this section when promoted to full dev
/// This section is used for guiding Jr through promotion to full developer (let Jr try to make the Achievement-NewsAnnouncement)
> *"Promoted to full developer!"*
...

## ∘───── 🌟 Set Promotion ─────∘ // TODO, only include this section, when not promoted to full dev
/// Guide junior through set promotion + ask to review "Achievement News Announcement" template
Alright, we'll be promoting the set, once you're ready. Any achievements marked `[VOID]` will remain in Unofficial.

Please review the **"Achievement News Announcement"** template below, which shall be posted in [#achievement-news in RAdiscord](https://discord.com/channels/310192285306454017/310207383542562816)
- Let me know if the video I’ve provided is okay, else share a link to a more suitable one if you prefer.
- Do you have any flavour text you'd like to include with the announcement? Try to write something that will make players excited to try out your set. You could briefly highlight what makes the game fun or unique, or what kind of experience the achievement set offers.

Reply/ping me once you’ve looked it over and are ready to promote it!
> ℹ️ **NOTE** — Both of us need to be online at the same time to promote the set. Let me know when you're available so we can coordinate.
> **Here’s how it’ll go**: I will be promoting all achievements to Official. Afterwards you'll need to click the `Complete Claim` button from the `Dev` drop-down menu on the game page, ideally within a reasonable timeframe after the promotion of the set. That’s all there is to it!

### ---⇢ 💎 Achievement News Announcement ⇠---
/// Post Achievement-NewsAnnouncement_Template.txt here

#  ✦═══════✦ :kirbyjam: Post-Set Promotion ✦═══════✦

## ∘───── ✒️ RANews Set Highlight ─────∘ // TODO
As a final step, please take a moment to fill out the [RAnews Set Highlight Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview). In it, you’ll be asked to write a short pitch promoting your game/set, aimed at readers of the RetroAchievements digital magazine. Your snippet may be featured—fully or with minor edits—in an upcoming issue under the **"Junior Developer Program"** section.

Use this as a chance to spotlight what makes the game and your achievement set stand out. It’s a great way to highlight your work and get players excited to check it out! Consider briefly mentioning:
- What the game is about
- What makes the achievement set fun or unique
- Any specific design focus or standout challenges
This isn’t a devlog, just a brief, engaging introduction meant to catch a reader’s attention.

Here are a few examples of past highlights for inspiration:
- [RANews Issue February 2025](https://news.retroachievements.org/issues/2025-02/jr-developer-program.html) (first appearance of this section)
- [RANews Issue March 2025](https://news.retroachievements.org/issues/2025-03/jr-developer-program.html)
- [RANews Issue April 2025](https://news.retroachievements.org/issues/2025-04/jr-developer-program.html)
- ...

Once you've submitted your entry into the form, feel free to ping me, so we can close this discord thread as :white_check_mark: resolved!