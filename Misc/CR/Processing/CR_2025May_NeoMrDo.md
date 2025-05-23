# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Code Review Thread => _DISCORD_LINK_TO_CODE_REVIEW_
Junior Developer => https://retroachievements.org/user/Krylan
Set Plan => N/A
Ready for Review Thread => https://discord.com/channels/310192285306454017/1342590608006582325
Play Test Thread => https://discord.com/channels/310192285306454017/1339642437164863498
RA Game Page => https://retroachievements.org/game/12324
 
# ------CR TODO List------ (for use by CR)
- Discord Code Review Naming Scheme: `Code Review - [GameTitle (Console)] - [DevName]`
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
- Remove all comments ///

# ------TODO Legend------
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out (by CR)
- ❌ CANCELED — Task was dropped or no longer applicable (by Reviewee)

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


# %%%%%%%%%%%%% CODE REVIEW: Neo Mr. Do (Arcade) %%%%%%%%%%%%% #

# ------Intro------

Hello @Krylan

Your Code Review for [Neo Mr. Do! (Arcade)](https://retroachievements.org/game/12324?f=5) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

## ∘───── 📑 Table of Contents ─────∘
### 🧠 Memory Work & Internal Notes https://discord.com/channels/310192285306454017/1375387862664478811/1375388004738273322 
- 🛠️ RAM Digging & Code Notes
- 🧷 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🕹️ Achievement Set Design https://discord.com/channels/310192285306454017/1375387862664478811/1375388216617730088
- 🎯 Overall Set Design
- ✍️ Titles & Descriptions
- 🖼️ Badge Art
- ⚖️ Point Distribution
### ⚙️ Technical Implementation https://discord.com/channels/310192285306454017/1375387862664478811/1375388491466412113
- 🧩 Achievement Logic
- 🔧 Rich Presence Logic
- 🔢 Leaderboard Logic
### 🔑 Misc Prerequisites https://discord.com/channels/310192285306454017/1375387862664478811/1375388698396327977
### 📜 Summary & Final Notes https://discord.com/channels/310192285306454017/1375387862664478811/1375388756424527966

## ∘───── Related Links ─────∘
Junior Developer => https://retroachievements.org/user/Krylan
Set Plan => Not Found
Ready for Review Thread => https://discord.com/channels/310192285306454017/1342590608006582325
Play Test Thread => https://discord.com/channels/310192285306454017/1339642437164863498
RA Game Page => https://retroachievements.org/game/12324

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦

## ∘───── 🛠️ RAM Digging & Code Notes ─────∘
Everything looks good here. Although, I have some minor details I would love you to take a look at.

### ❓ Documentation of Flags
Some code notes you documented as `8-bit` can be accessed via bit-level accessors.
Take for example:
- `$0xfd8b`
```
[8-bit][Dip Switch] Continue
0x00 = OK
0x01 = NO
```
This is actually just a boolean value (false/true), an alternative code notation, which recognizes this value as a boolean:
```
[8-bit Flag][Dip Switch] Continue
bit0 = 0x0 => Continue disabled
bit0 = 0x1 => Continue enabled
```

Or how I would personally code note this:
```
[bit0 BitFlag:DipSwitchSetting_IsContinueEnabled |8-bit] 
```
- Lowest-level accessor = bit0
- It's a Flag "IsContinueEnabled" (boolean, 0 = false; 1 = true)
- Highest-level accessor = byte (8-bit)

Anything that has only two values can be marked as a boolean to make things super easy to understand. Consider these code notes too:
- `$0x2126` to `$0x213e`: Each of these 8-bit values is actually just an 8-bit boolean

### ❓ `$0x09e4` Breaken?
```
[8-bit] Cutscene status
0x01 Cutscene can be breaken
0x00 Cutscene can't be breaken or has been breaken
```
- What do you mean by "breaken"? Did you mean that these cutscenes can or cannot be skipped? 

### ❓ `$0x0e48` & `$0x0e64` Suggestion?
I would document these addresses like this:
``` 	
[8-bit] P1 State
0x00 => Looking Up
0x01 => Looking Down
0x02 => Looking Left
0x03 => Looking Right
LookingDirectionValue +0x4 => Shooting (in that direction)
0x09 => Dying
0x12 => Spawning
0x14 => Continue / Insert Coin
0x0e => Losing Gender Power Up
```
Or maybe even simpler would be:
``` 	
[8-bit] P1 State
0x00 => Looking Up
0x01 => Looking Down
0x02 => Looking Left
0x03 => Looking Right
0x04 => Shooting Up
0x05 => Shooting Down
0x06 => Shooting Left
0x07 => Shooting Right
0x09 => Dying
0x12 => Spawning
0x14 => Continue / Insert Coin
0x0e => Losing Gender Power Up
```
- Especially `0x0X+4 Button A (Shoot)` is easier to understand from this. As initially I didn't understand what was going on there.

## ∘───── 🧷 Additional Developer Notes ─────∘
- You posted updates on the [Forum Topic](https://retroachievements.org/forums/topic/28464), great!
- Your playtest-request came through, and you fixed some bugs it seems, regarding a mistrigger on [Speedy Showman](https://retroachievements.org/achievement/499145) and the progression achievements not triggering.
- In your [Ready for Review Thread](https://discord.com/channels/310192285306454017/1342590608006582325), there seemed to be some problems with missing deltas, bracketed text inside descriptions.

## ∘───── 🧪 Testing & Debugging Results ─────∘

### ❓ Testing Questions
- Can you recall how exactly you fixed the problems found in the [#playtest-request](https://discord.com/channels/310192285306454017/1339642437164863498)?
- Were there any other problems you encountered during development? How did you fix them?
- Were there any achievements you were unable to design?
- How did your own testing process look like?

# ✦═══════✦ 🕹️ Achievement Set Design ✦═══════✦

## ∘───── 🎯 Overall Set Design ─────∘

### 👍 Positive Observations
- Progression achievements marked correctly
- Works on both 1P and 2P
- All content seems to be covered, almost all game mechanics seem to be touched upon, love to see it. Although I do think that some of the challenge achievements requiring the player to do xx thing within only one round may seem a bit too easy imo. Perhaps expanding the scope somewhat could be an interseting twist to introduce some more variety in the challenges, like:
- `Complete a stage from start to finish, by killing all enemies, and without losing any lives.` (player would need to kill all enemies within each round)
- `Complete a stage from start to finish, without killing any enemies, and withouth losing any lives` (player would need to collect all items instead, for each round)

### ---⇢ 🏆 Achievements ⇠---

### ❓ Difficulty Balancing Questions
What exactly does the difficulty level modify, what game mechanics are different? Why chose difficulty 4 in that case?

### ❓ Achievement [We Live in a Society](https://retroachievements.org/achievement/499156) Enemy Combo?
What exactly is a combo? Killing xx enemies with one projectile? Is this clear enough for players to understand what is required here? Is the term "combo" used within the game itself? After playing this game for around 30 min. I'm rather confused at what is required by me here.

### ❓ Achievement [Perfect Juggler](https://retroachievements.org/achievement/499147) Item Combo?
What exactly is an item combo? Is this clear enough for players to understand what is required here? Is the term "combo" used within the game itself? After playing this game for around 30 min. I'm rather confused at what is required by me here.

### ❓ Achievement [Pie in the Face](https://retroachievements.org/achievement/499155) Challenge clarity?
What exactly is the challenge here? Does the player have to start the game from the beginning and then find/wait for a "big enemy" to spawn and then kill it without losing a life? If this is the case, the description doesn't explain this properly in my opinion. Otherwise elaborate on this.

### ---⇢ 📺 Rich Presence ⇠---

### ❗ 2P RP Missing
Your set allows multiplayer, but RP only checks for the data of 1P(player 1), their lives.
Make sure you have corresponding RP for the following situations:
- when only 1P is active.
- when only 2P (player 2) is active.
- when both 1P and 2P is active.

### 💡 RP Expansions 
RP looks solid overall, though I personally think it could be expanded a bit. I’d love to see the following additions:
- **High Score**: Showing the player's current high score in RP would be a great fit for a game like this. It’s a core part of arcade-style replayability and would give more context to a player’s current session.
- **Coins**: Since lives are already displayed, it feels natural to include the player's current coin count as well. It adds more depth to the session snapshot and aligns with traditional game stat displays.
- **Difficulty**: If difficulty affects gameplay mechanics in any meaningful way, I think it would be valuable to show that in RP too. It helps contextualize the player's progress or performance.
- **Extra Stage, time left**: I think displaying time left for the extra stage could be interesting.
That said, if you feel any of these wouldn’t be a good fit for Rich Presence, I’d appreciate your insight on how the current RP setup already meets the game’s needs. You know this title better than anyone, after all.

### ---⇢ 🌐 Leaderboards ⇠---

### ❗ High Score Instant Submission
You have one leaderboard hooking on to the high score as the submitted value. Because of this, since the high score is already shown on-screen, it would be best designed as an instant submission leaderboard, please refer to [RAdocs - Leaderboard Design Tips](https://docs.retroachievements.org/developer-docs/leaderboards.html#design-tips). 

### 💡 Multiplayer Leaderboards
Your set allows multiplayer, I think there should be at least an equivalent of the High Score leaderboard, but for multiplayer in mind.
This leaderboard would then function as an instant submission leaderboard, submitting when both player's were active and one of them lost all their lives. Thus when the total combined high scores drops, the leaderboard submits. Take a look for yourself, how you could make such a leaderboard function correctly, it definitely doable with the RAM values you've already documented. 

## ∘───── ✍️ Titles & Descriptions ─────∘
Everything looks conform to the RAdocs requirements. Although I do have a few remarks.

### ❗ Leaderboard [High Score (WIP)](https://retroachievements.org/leaderboardinfo.php?i=126016) "WIP" in Title + Description 1P
**Title**
When you submit your set for review (Ready for Review), make sure everything is final. Think of it as if you're releaseing your set to the public, be professional in this regard. Either release a full developed set or wait until it's fully done, so having (WIP) in the title is not advised. Although this leaderboard still has some other problems as well, more details futher below.

**Description**
This leaderboard only accounts for 1P slot right? Is this clear enough from the description? I'd rather phrase it as:
`Achieve the highest score on difficulty 4 or higher, with starting lives at 3 or less, using 1-player's slot`
Take a look at how other achievement sets have phrased such requirements, perhaps ask the writing-team.

## ∘───── 🖼️ Badge Art ─────∘
Badges look very good, love to see it.

## ∘───── ⚖️ Point Distribution ─────∘

### ❗ Overscored
Some achievements are way overscored, please refer to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html) and see if you can aim for an average points score of about ~7. This can easily be checked via [AutoCR](https://authorblues.github.io/retroachievements/AutoCR/), under "Set Overview", this also recommends to aim for ~7. If you could at least aim for something below 10 for this stat.

Here are some suggestions:
- [Co(s)mic Clown](https://retroachievements.org/achievement/499139) 50 -> 10; Could be 25, but I think 10 is just fine.
- [Speedy Showman](https://retroachievements.org/achievement/499145) 25 -> 10; Is it really that hard to achieve? After thinking it through a little bit, this achievements may look fair on 25 points perhaps. Since the player first has to acquire all EXTRA letters and then try to complete the extra stage without dying and also within 30 seconds. Retrying this extra stage is not that evident.
- [Scapino Flees from Fight](https://retroachievements.org/achievement/499146) 10 -> 5 (maybe even lower); Isn't this like really easy to achieve by just gathering all items, and just kiting enemies, since you run faster than most of them? Especially in the early stages? And it's also just for doing it within one round. This would be fine at 10 points if the player would be required to complete a whole Stage whilst doing this challenge.
- [Clown's Pocket](https://retroachievements.org/achievement/499141); Seems overly easy, reasoning is same as above achievement.

Consider some of my suggestions and see to it that you can lower the overal score somewhat.

# ✦═══════✦ ⚙️ Technical Implementation ✦═══════✦

### 👍 Positive Observations
- Proper use of deltas
- Good work making use of OrNext and AltGroups in order to make achievements trigger on either 1P or 2P (Since you marked the set as "Multiplayer Allowed")
- ResetIfs + Checkpoint HitCounts to make challenge achievements work properly 

## ∘───── 🧩 Achievement Logic ─────∘

### ❗ `AndNext` Misuse
`AndNext` should only be used for checkpoint HitCounts or HitCounts in general or in combination with other flags such as (ResetIf/PauseIf)
Following achievements use `AndNext`, but they may not be necessary, can probably be left out safely:
- [Scaramouche Is Here](https://retroachievements.org/achievement/499142)
- [An Explosive Spectacle](https://retroachievements.org/achievement/499149)
- [Isn't Bowling Part of the Show?](https://retroachievements.org/achievement/499148)
- [A Fake Clown](https://retroachievements.org/achievement/499150)

Achievement [Scapino Flees from Fight](https://retroachievements.org/achievement/499146) does use them correctly, attached to a ResetIf.

### ❓ Missing Demoe Mode Protection?
Do the following achievements need any demo protection?
- [Time to Change Oversized Shoes](https://retroachievements.org/achievement/499153)
- [Nobody Likes a Clown at Midnight](https://retroachievements.org/achievement/499154)

Most other achievements you have the following logic, which presumably checks against demo mode?
```
Mem	8-bit	0x00000028  =	Value		7
```

Personally based on your code notes, I would've added demo protection by having the following logic within each achievement:
```
Mem	8-bit	0x00000028  !=	Value		3
```

### ❓ Achievement [You Are Not a Clown, You Are the Entire Circus](https://retroachievements.org/achievement/499140) Issues?
```
  1:         Mem   8-bit 0x0000fd8a >=  Value 3     (0)
  2:         Mem   8-bit 0x0000fd89 <=  Value 3     (0)
  3:         Mem   8-bit 0x00000028 =   Value 6     (1)
  4: ResetIf Mem   8-bit 0x00000028 =   Value 10    (0)
  5: ResetIf Mem   8-bit 0x0000fdb7 >   Value 1     (0)
  6: ResetIf Mem   8-bit 0x0000fdba >   Value 1     (0)
  7:         Delta 8-bit 0x0000460a =   Value 6     (0)
  8: Trigger Mem   8-bit 0x0000460a =   Value 7     (0)
```
**Checkpoint HitCount**
Core:Line[3] does this checkpoint HitCount check if the game was started from the beginning, from Stage 1, round 1? If that is the case all is well here.

**Trigger Flag**
Core:Line[8] has a trigger flag, but this trigger indicator will only be displayed when in stage 6 due to Core:Line[7]. When exactly do you want this indicator to be displayed?

**2P Issue**
There's a possible issue with this achievement, what if at one point join in with 2P mid-way through the game? Does this not make the achievement somewhat easier then? Elaborate on how this would or would not affect balancing... Alas, you're the expert here.

### ❓ Achievement [Perfect Juggler](https://retroachievements.org/achievement/499147) Math?
```
CORE
1:   Mem   8-bit 0x0000fd8a >=  Value  3  (0)
2:   Delta 8-bit 0x00000028 =   Value  7  (0)
3:   Mem   8-bit 0x00000028 =   Value  8  (0)

ALT_1
1: SubSource   Mem   8-bit 0x00000d30 /   Value 8 
2:             Mem   8-bit 0x000064a0 =   Value 0 (0)

Alt_2
1: SubSource   Mem   8-bit 0x00000d30 /   Value 8  
2:             Mem   8-bit 0x000064a2 =   Value 0 (0)
```
You're using SubSource here, but I'm not sure what exactly is happening there, from a glance. Perhaps you could extend the correlating code notes somewhat to explain what is happening or what is calculated by doing this math.

### ❓ Achievement [Comedy Genius](https://retroachievements.org/achievement/499160) Challenge?
Is this achievement actually a challenge? Doesn't this logic allow for continues? If this logic doesn't account for that, I would make this achievement a proper challenge. Let's say `Get a score of 500k on difficulty 4 or higher, without losing more than 3 lives or using a continue`. This would also best be implemented for all three of these high-scored based achievements.



## ∘───── 🔧 Rich Presence Logic ─────∘ 
Everything appears to be in order, albeit as a relatively simple RP script.

## ∘───── 🔢 Leaderboard Logic ─────∘

### ❗ Leaderboard [High Score (WIP)](https://retroachievements.org/leaderboardinfo.php?i=126016) Logic Issues + Questions
This leaderboard would be better designed as an instant submission leaderboard. But I will critique it as it is currently. It does seems to function as an instant submission leaderboard, I think from my testing. It never tracks right? It just submits when you lose all lives? or when you enter the "Continue" state? Although an instant submission leaderboard would have an always_false CANCEL condition and an always_true SUBMIT condition. 

**START**
- In order to start the leaderboard I must first lose all my lives, the leaderboard starts when the 'continue' state is reached for `$0x0fdb7`? Why not just start the leaderboard when the game starts? Or when the player comes from the "continue" state back into the "playing" state instead?

**CANCEL**
```
Mem 8-bit 0x00000028 !=  Mem 8-bit 0x00000028 (0)
```
How is this supposed to cancel the leaderboard exactly? This looks like an always_false condition, so never cancel? If that is what you need, we'd rather see something like:
```
val 0  ==  val 1
```
0 can never be equal to 1, this is much easier the ascertain as an always_false condition then what you use.

**SUBMIT**
```
OrNext      Mem   8-bit  0x0000fdb7 =   Value   2   (1)
            Mem   8-bit  0x0000460a =   Value   7   (1)
ResetIf     Mem   16-bit 0x00004654 =   Value   0   (0)
```
HitCounts & ResetIf seems unnecessary. Again just use an instant submission leaderboard instead of this leaderboard logic, it would make it that more easy. 

Make this work for 2P's slot as well.
Since high score is seperate between 1P and 2P, I think it would be feasible to have this leaderboard submit for both players.

**VALUE**
How exactly does `$0x4652` 1P Score multiply work? What does the math calculate exactly, it wasn't clear to me by just reading the code notes?


# ✦═══════✦ 🔑 Misc Prerequisites ✦═══════✦

### ❓ Hubs & Similar Games
You already listed a few hubs to be added within your Ready For Review Post, but could you give these another look. I'd advise you to sift through all hubs via [RAweb - All Hubs](https://retroachievements.org/hubs). After you've gone through them give me a final list so I can add them. (More useful info [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html)). Does the publisher/developer Visco have a corresponding hub? If so, they should also be added as their hub.

Any similar games to add? Think of games that may fit the same genre or games of the same series, perhaps. Give me a full list, if there are any.

### ❓ Game Page Metadata
Is everything correctly filled out on the **manage page** and **game page**? (publishers, genre, game screenshots, box art, release date...)

# ✦═══════✦📜 Summary & Final Thoughts 📜✦═══════❖

## ∘───── 📋 TODO Checklist ─────∘
- **Initially Posted on**: `23 May 2025` - `Initial Code Review`
- **Last Updated on**: `DD Month YYYY` - `Checklist Assessment #0-[ChecklistAssessmentNumber]` // CR_TODO Perform next Checklist Assessment Round

Please use the list below as a working guideline. I recommend copying it or creating your own version, ideally in a format I can also access and follow along with. A good option would be to add a new tab in your existing Set Plan Excel document for this purpose.

I'll be using this list here to track your progress as well. As you work through the items, feel free to update your version, and I’ll mirror any changes here in the thread to keep everything in sync. This way, we can easily monitor what's been completed and what still needs attention.

### --⇢ 📐 TODO Legend ⇠--
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out (by CR)
- ❌ CANCELED — Task was dropped or no longer applicable (by Reviewee)

### ---⇢ 📌 Initial Code Review Tasks ⇠---
### 🔲 🛠️❓ Documentation of Flags
### 🔲 🛠️❓ `$0x09e4` Breaken?
### 🔲 🛠️❓ `$0x0e48` & `$0x0e64` Suggestion?
### 🔲 🧪❓ Testing Questions
### 🔲 🏆❓ Difficulty Balancing Questions
### 🔲 🏆❓ Achievement [We Live in a Society](https://retroachievements.org/achievement/499156) Enemy Combo?
### 🔲 🏆❓ Achievement [Perfect Juggler](https://retroachievements.org/achievement/499147) Item Combo?
### 🔲 🏆❓ Achievement [Pie in the Face](https://retroachievements.org/achievement/499155) Challenge clarity?
### 🔲 📺❗ 2P RP Missing
### 🔲 📺💡 RP Expansions
### 🔲 🌐❗ High Score Instant Submission
### 🔲 🌐💡 Multiplayer Leaderboards
### 🔲 ✍️❗ Leaderboard [High Score (WIP)](https://retroachievements.org/leaderboardinfo.php?i=126016) "WIP" in Title + Description 1P
### 🔲 ⚖️❗ Overscored
### 🔲 🧩❗ `AndNext` Misuse
### 🔲 🧩❓ Missing Demoe Mode Protection?
### 🔲 🧩❓ Achievement [You Are Not a Clown, You Are the Entire Circus](https://retroachievements.org/achievement/499140) Issues?
### 🔲 🧩❓ Achievement [Perfect Juggler](https://retroachievements.org/achievement/499147) Math?
### 🔲 🧩❓ Achievement [Comedy Genius](https://retroachievements.org/achievement/499160) Challenge?
### 🔲 🔢❗ Leaderboard [High Score (WIP)](https://retroachievements.org/leaderboardinfo.php?i=126016) Logic Issues + Questions
### 🔲 🔑❓ Hubs & Similar Games
### 🔲 🔑❓ Game Page Metadata

### ---⇢ 📌 Wrap-Up Tasks (before promotion) ⇠--- // TODO
🔲 Testing after logic changes
🔲 ...
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

### ---⇢ 📌 Additional Tasks (post-set promotion) ⇠--- // TODO
🔲 Write/Submit RAnews Set Highlight [Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview)

When the full checklist is completed and confirmed, we can proceed with finalizing the review and begin discussing the set’s promotion. Until then, feel free to ping me anytime if you’ve completed the task list or have further questions, I’ll be happy to review things again when ready.

## ∘───── 📚 Final Thoughts ─────∘

Overall, your set is shaping up nicely, the core structure is solid, and much of the logic appears well thought out, but there are a few ❗ issues I've discovered that could be touched upon somewhat before we release the set. Tackling these points now will help ensure a smoother launch and a more polished experience for players. 

# %%%%%%%%%%%%% POST-INITIAL CODE REVIEW %%%%%%%%%%%%% #

# ✦═══════✦ 🔍 CR Reassessment Round #1  ✦═══════✦ // TODO

## ∘───── 🛠️ Tasks / Issues ─────∘ // TODO

## ∘───── 📋 TODO Checklist ─────∘ // TODO
- **Initially Posted on**: `DD Month YYYY` - `Reassessment Round #xx`
- **Last Updated on**: `DD Month YYYY` - `Checklist Assessment #[ReassessmentRoundNumber]-[ChecklistAssessmentNumber]` // CR_TODO Perform next Checklist Assessment Round

Please use the list below as a working guideline. I recommend copying it or creating your own version, ideally in a format I can also access and follow along with. A good option would be to add a new tab in your existing Set Plan Excel document for this purpose.

I'll be using this list here to track your progress as well. As you work through the items, feel free to update your version, and I’ll mirror any changes here in the thread to keep everything in sync. This way, we can easily monitor what's been completed and what still needs attention.

### ---⇢ 🗃️ TODO Legend ⇠---
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out (by CR)
- ❌ CANCELED — Task was dropped or no longer applicable (by Reviewee)

### ---⇢ 📌 Initial Code Review Tasks ⇠--- // TODO
### 🔲 🧪❗ ...
### 🔲 🖼️❓ ...
### 🔲 🧩❓ ...
### 🔲 🧩❗ ...
### 🔲 🔧❓ ...
### 🔲 🧭❓ Hubs & Similar Games
### 🔲 🗂️❓ Game Page Metadata

### ---⇢ 📌 Reassessment Round #1 Tasks ⇠--- // TODO
### 🔲 🛠️❗ ...
### 🔲 🧩❓ ...
### 🔲 🧩❗ ...
### 🔲 🔧❓ ...

### ---⇢ 📌 Wrap-Up Tasks (before promotion) ⇠--- // TODO
🔲 Testing after logic changes
🔲 ...
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

### ---⇢ 📌 Additional Tasks (post-set promotion) ⇠--- // TODO
🔲 Write/Submit RAnews Set Highlight [Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview)

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