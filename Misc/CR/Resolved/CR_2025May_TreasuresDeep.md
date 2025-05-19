# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Code Review => https://discord.com/channels/310192285306454017/1371969269759213708
Set Plan Review => _DISCORD_LINK_TO_SET_PLAN_REVIEW_
Set Plan Doc => https://docs.google.com/spreadsheets/d/18K_nmvO93XUdnPZ3dMp04nIYvjlHrUnvGn2s0OEMhS4/edit?gid=303587950#gid=303587950
Ready for Review Thread => https://discord.com/channels/310192285306454017/1342358688249151539
RA Game Page => https://retroachievements.org/game/19403
 
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


# %%%%%%%%%%%%% CODE REVIEW: Treasures of the Deep %%%%%%%%%%%%% #

# ------Intro------

Hello @stoneskipper42

Your Code Review for [Treasures of the Deep (PlayStation)](https://retroachievements.org/game/19403?f=5) has finally been dredged from the abyss!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

## ∘───── 📑 Table of Contents ─────∘
### 🧠 Memory Work & Internal Notes https://discord.com/channels/310192285306454017/1371969269759213708/1371969414865621102 
- 🛠️ RAM Digging & Code Notes
- 🧷 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🕹️ Achievement Set Design https://discord.com/channels/310192285306454017/1371969269759213708/1371969638690459769
- 🎯 Overall Set Design
- ✍️ Titles & Descriptions
- 🖼️ Badge Art
- ⚖️ Point Distribution
### ⚙️ Technical Implementation https://discord.com/channels/310192285306454017/1371969269759213708/1371969784169889922
- 🧩 Achievement Logic
- 🔧 Rich Presence Logic
- 🔢 Leaderboard Logic
### 🔑 Misc Prerequisites https://discord.com/channels/310192285306454017/1371969269759213708/1371969971571130469
### 📜 Summary & Final Notes https://discord.com/channels/310192285306454017/1371969269759213708/1371970029377294487

## ∘───── Related Links ─────∘
Junior Developer => https://retroachievements.org/user/stoneskipper42
Jr. Dev Request => https://discord.com/channels/310192285306454017/1326595732400115813/1326595732400115813
Set Plan => https://docs.google.com/spreadsheets/d/18K_nmvO93XUdnPZ3dMp04nIYvjlHrUnvGn2s0OEMhS4/edit?gid=303587950#gid=303587950
Ready for Review Thread => https://discord.com/channels/310192285306454017/1342358688249151539
Play Test Thread => https://discord.com/channels/310192285306454017/1344510362674008104
RA Game Page => https://retroachievements.org/game/19403

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦

## ∘───── 🛠️ RAM Digging & Code Notes ─────∘
A whopping 547 code notes, great work on RAM digging and thoroughly documenting all the relevant addresses. While a few notes were contributed by others, it's clear that the vast majority of the work was done by you, and I really appreciate that you even took the time to credit other devs where appropriate, love to see it.

I do have a few remarks on specific code notes that could benefit from a bit more explanation to better convey what’s happening. If any of these notes aren't used in any current logic, it’s not critical — but ideally, all documented addresses should be clear and informative. If you're unsure about some of them, I would just add a tag `(unverified)` or `(inconsistent)`

Most of the points I raise below are small details I personally would’ve found helpful while reviewing the notes, especially from the perspective of someone approaching the game without prior knowledge. Again you did an outstanding job documenting everything, these are just a few nitpicky things.

### ❓ Code Notes *"Map State"* `$0x10d848 - $0x10e360`
Very well documented, but I'd love to see you explain the a-b frames, inside let's say the first code note of this series. My guess it's because the game flickers between these two states? `Frame 1: A is shown --> Frame 2: B is shown --> Frame 3: A is shown --> etc...`

### ❓ Code Notes *"Oxygen"* & *"Health"*
Would be helpful if you could document the max & min values. If there are HP upgrades for example, I would also love to see how these interact with their corresponding values. Just a few extra details, I love to see. Take for example, a game where HP is counted in reverse. I wouldn't be able to know based on your code notes. 
Try to explain how the code noted RAM value works within the game. 

### ❓ Code Notes Time-Related - Missing Time Unit
`$0x32f94` has time unit *"frames"*, which is well documented, the other time-related RAM values could perhaps be expanded upon by also mentioning the time unit: Seconds, Milliseconds, etc...

### ❓ Code Note `$0x11f618` Additions Possible
Again I'm not 1000% sure if some of these code notes I mention here are used within any logic. But this one could perhaps be expanded upon. Perhaps an achievement could be made to unlock all suits? I don't know if that's a possibility?

### ❓ Flag Documentation
You've done a great job identifying and using key RAM values, but I noticed that a few of them are actually Flags or even BitFlags, though they aren’t currently documented as such. For example: `$0x4068c` `$0x324a8`
Both of these are `8-bit Flags`, and in your logic, could be using a `bit0` memory accessor instead of 8-bit. In cases like these, it’s best to reflect that in your code notes by using the appropriate lowest-level accessor and flag terminology. Here are two formats you might consider:
```
[8-bit Flag bit0] Game Paused
0 => false
1 => true
```
Or, the format I personally prefer:
```
[bit0 BitFlag |8-bit] Is Game Paused
```
Both of these alternatives:
- Indicate it’s a flag
- Specify the smallest memory accessor that could be used (bit0)
- Show the full size of the RAM address (in this case, 8-bit), indicating it's stored as a byte
At minimum, I recommend always including the first two points for clarity and consistency.

Another example: `$0x40836` `[8-bit] Bermuda Triangle level complete`
This too functions as an 8-bit flag, which could be better expressed using bit0.

You do have a well-documented bitflag example at `$0x4400c`, although that one was contributed by another developer. Personally, I would phrase that as:
`[8-bit BitFlags]` or `[8-bit BitSet]`

**Conclusion Regarding Flag Documentation**
It’s clear you understand how these values behave and how to use them properly in logic, which is great! The only gap here is in applying the correct terminology in the code notes. You're treating them as flags, but documenting and using them with too broad of a memory accessor (e.g., full byte instead of bit-level).

This isn’t a major issue, rather a small, nitpicky suggestion for future sets. Accurate and consistent terminology in your code notes helps not just your own development process, but also others who may reference your notes down the line.

### ❓ Code Notes **"Pre-mission"* `$0x40698`
Pre-mission, what does this entail?
This seems to also be used within *"Best Scores"* leaderboards under VALUE. Does "pre-mission wealth" imply gold/wealth that's within the player's bank between missions? In that case code note `$0x0406c0` could also be updated, to include how this is used to calculate the effective wealth gathered during the mission?

## ∘───── 🧷 Additional Developer Notes ─────∘
I was not able to relocate the Set Plan Review/Jr. Dev Request thread regarding this title. 

Your Ready for Review Thread was exceptionally annotated, you proactivly explained a lot of concerns there may be, love to see that.

Seems like you got lucky with your play-test-request and you got a playtester, I also did some basic testing and from what I can gather everything seems to function properly. you've also seemed to have asked for feedback relating the set within this thread, very good. Asking others 

## ∘───── 🧪 Testing & Debugging Results ─────∘
Within your Ready for Review Thread you explained very well, how the testing was accomplished, nice. Testing results of play-test-request are all fine. 

### ❓ Development Questions
Please answer following questions, just to give us an idea of how your process went:
- How did you chose this game/console for your first set?
- Have you had any problems whilst RAM digging?
- What other problems did you run into whilst developping this set? How did you fix these?

# ✦═══════✦ 🕹️ Achievement Set Design ✦═══════✦

## ∘───── 🎯 Overall Set Design ─────∘
Overall, your set design is exquisite, a real treasure beneath the surface. You've done more than just skim the top; you've explored the depths of the game's content with purpose and creativity. Your achievements don’t just reward progress, they guide the player’s attention toward hidden features and overlooked side content, enhancing the experience in meaningful ways.

It’s clear you’ve taken time to understand the current, not just follow it. I like how those hidden/easter egg achievements feel like a discovery, not just a checkbox. This is S+ design across the board. Fantastic work, love to see it!

### ---⇢ 🏆 Achievements ⇠---
Smart usage of `Measured` & `Trigger` flags.

### ❓ Missables Question
You currently have three achievements marked as missable, one example being [Comprehensive Cargo Cleanup](https://retroachievements.org/achievement/498042). I saw that you’ve addressed this in your Ready for Review thread, but I still find the reasoning a bit unclear.

From what I understand, you're requiring the player to complete a mission with a specific score on their first attempt in order to receive a bonus. Is the idea that this score bonus is only awarded on the initial completion, and not on any subsequent replays of the mission?

If that’s the case, I would recommend reconsidering this design approach. Requiring a perfect or high-score performance on a first attempt can feel unfair or overly punishing, especially for completionists. A better solution might be to lower the score threshold so the achievement remains a challenge, but doesn’t depend on a single opportunity, thus making it non-missable, which would be the preferred option to me.

Alternatively, it might be worth opening a poll with the community in [#poll-me](https://discord.com/channels/310192285306454017/511718348178849792) on RAdiscord to get feedback on whether this type of missable is acceptable or should be reworked as mentioned above.

### ---⇢ 📺 Rich Presence ⇠---
Very well designed, looks like all content and every game screen has corresponding Rich Presence strings. Usage of unicode characters is great, not too spammy, indicates the presented values well.

### ---⇢ 🌐 Leaderboards ⇠---
"Best Scores" leaderboards function with instant Start/Submit, this is a very good choice, since the thing they're tracking is already displayed in-game.
"Best Times" leaderboards function normally, to display in-game time, otherwise not displaying within game, very nice.

## ∘───── ✍️ Titles & Descriptions ─────∘
Everything looks in order, very creative titles, descriptions are fine, love to see it.

## ∘───── 🖼️ Badge Art ─────∘
The badges are all unique and are all related to the achievement in question, they will do.

### 💡 Badge Quality Uplift
Although personally, I think the badges and the mastery/game icon could benefit from a slight quality uplift. In several badges, it's a bit difficult to tell what the subject is, either due to low contrast, or dark lighting. In some cases, the central object is hard to identify at a glance, which affects visual readability.

That said, I understand we're working with PS1-era visuals, so limitations in source quality may be a factor. Still, with some careful editing, adjusting brightness, sharpening the subject, including a border, or improving color balance, these could stand out much more cleanly and cohesively.

A visual refresh could really elevate the overall presentation of the set. After all, badges are the first thing players see when browsing a game's achievement list — they’re a visual hook. Strong, well-composed badges can make a set feel instantly more inviting and professional.

I’d highly recommend dropping a post in [#art-request](https://discord.com/channels/310192285306454017/1048102604963586048) on the RAdiscord. You never know what the community might come up with, we’ve got some incredibly talented artists around, and they’re often happy to help.

Please know this is purely a suggestion, coming from someone who enjoys making badges and admittedly holds high standards in this area. The final call is entirely yours, and your artistic direction is always valid. Just wanted to offer some thoughts in case it’s something you’d consider exploring.

## ∘───── ⚖️ Point Distribution ─────∘
Perhaps a bit underscored, according to [AutoCR](https://authorblues.github.io/retroachievements/AutoCR/) it's on average points of 5,9. This tool also suggests going for an average point distribution of about 7 and I'm entirly agreeing. See if you could perhaps add a few more points to certain achievements here and there, please refer to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html).

### 💡 Point Increase
Personally I would increase [It's All Coming Together](https://retroachievements.org/achievement/497647) to 10 points, and also increase some of the lower scored achievements. The achievements with only 1-2 points, could perhaps be increased a little accross the board. I was also thinking that the bonus mission achievement could get an increase, since they require a certain challenging unlock method from what I read?

These are purely suggestions, you make the choice in the end, you know the game best.

# ✦═══════✦ ⚙️ Technical Implementation ✦═══════✦

Overal the logical implementation of all of your assets is up to our coding standards, there are only a small few things I noted down futher below, I'm not entirely understanding correctly.

## ∘───── 🧩 Achievement Logic ─────∘

### 👍 Positive Observations
- You seem to use PauseLocks without actually using PauseLocks. I call them something like ResetLocks/Lockouts. 
In most of your assets, achievements and leaderboards, you use a checkpoint HitCount for checking if a specific mission was started from the beginning, with a delta check within as well, very good. Then you ResetIf/Lockout the achievement, when a cheat is used for example, this would prevent the achievement from unlocking by resetting this checkpoint HitCount, this pretty much is the same thing what a PauseLock would do, so very good job. I would say using this ResetLock method is preferred, since it's cleaner to work with in my opinion, so very good job mastering this combination of tools.
- Only 1 hash supported (USA), very well.
- Smart usage of SubSource within [Fossil Finder](https://retroachievements.org/achievement/497691) for example, love to see it.
- Correct usage of Measured & Trigger flags
- Deltas used correctly
- Checkpoint Hitcounts
- 1 Pointer has been documented and used within achievement logic, love to see this within a first set.

### ❗ Achievement [Ride the Ray](https://retroachievements.org/achievement/497654) - Additional Delta 
The achievement logic works, but I think you could probably add a delta check for `Ray Ridden [8-bit]` within pointer at `$0x10d724`, next to the normal current frame check. So it checks for a change from "not ridden" to "ridden", this would primarily add some extra protection against loading a savestate from within the specific mission, which already has ridden on the ray. 

In general, you wanna use deltas as much as possible, not just once, especially whenever you can check for a change on a certain value, within a single frame. The more you have them within your logic, the more robust the achievement. I'm pretty sure this was just a minor oversight, since you do add deltas everywhere else.

### ❓ Achievement [It's All Coming Together](https://retroachievements.org/achievement/497647) - Logic Question
Core:Lines[14-15], also within the alt groups:
```
14 	SubSource	Mem	8-bit	0x00040bcc
15 	ResetIf	    Mem	8-bit	0x0011c508  !=	Value		0x0000000f
```
I'm not entirely sure what above aims to check. Might this be some sort of cheat protection? If so I would love to see this explained inside one of the correlated code notes. Something along the lines like this to give you an idea: `ThisValue - OtherValue (at $0xBB) = 0x0F ---> cheat xx activated...`

### ❓ Cheat-Protection - Questions
This game has lots of cheats and you were able protect the set against it very well. 
But I would love if you could elaborate on your cheat-protection somewhat: 
- Seems like all cheats need to be input via the PauseMenu? 
- I reckon from your achievement logic, you only protected against certain types of cheats, or did you protect against all? 

## ∘───── 🔧 Rich Presence Logic ─────∘

Lots of conditional display strings, with a few lookups and macros used, splendid job!

### ❓ Macro Usage - @Score vs @Number
You seem to use the `@Score` macro for displaying how many chapters are completed and also for displaying how many tablet pieces are collected on the active saveprofile. But it seems you have formatted `@Score` with `FormatType=VALUE`, by having below code in your RP script:
```
Format:Score
FormatType=VALUE
```
I think the preferred macro to use would be `@Number`, which already uses `FormatType=VALUE`. Please refer to [RADocs - Macros](https://docs.retroachievements.org/developer-docs/rich-presence.html#built-in-macros) & [RAdocs - Format](https://docs.retroachievements.org/developer-docs/rich-presence.html#format). You have exactly the same RP output by just using `@Number`. Above snippet of code, should only be used to make custom named macros, for example:
```
Format:LevelsCompleted
FormatType=VALUE

Format:TabletsCollected
FormatType=VALUE
```
Now you could just use it as `@LevelsCompleted(...)` & `@TabletsCollected(...)`, making the RP perhaps somewhat more easier to read. Personally I never use this formatting feature as I code everything in RAscript.

## ∘───── 🔢 Leaderboard Logic ─────∘
2 types of leaderboards have been implemented, 2 for each mission + 1 extra for the bonus mission. All seems to be in order, splendid!
You've also used instant submission leaderboards, which is always nice to see. No need for unnecessary clutter.

# ✦═══════✦ 🔑 Misc Prerequisites ✦═══════✦

### 🧭❓ Hubs & Similar Games
You already listed a few hubs in your Ready for Review Thread, which have since already been added. Are there anymore hubs to add? (Refer to [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html))
I would advise skimming through all the available hubs via [RAweb - All Hubs](https://retroachievements.org/hubs). I think some of these may be applicable?
- Sony Computer Entertainment may be a publisher for EU region?
- [Theme - Naval Warfare](https://retroachievements.org/hub/20342)
- [Perspective - First-Person](https://retroachievements.org/hub/3332)
- [Perspective - Third-Person](https://retroachievements.org/hub/4599)

And are there anymore similar games to add? Think of games that may fit the same genre or games of the same series, perhaps. Maybe these:
- Aquanaut's Holiday
- Critical Depth

### 🗂️❓ Game Page Metadata
Is everything correctly filled out on the **manage page** and **game page**?
There seems to be some missing metadata, if you try to please fill everything in, so you get a feel how this functions.

# ✦═══════✦📜 Summary & Final Thoughts 📜✦═══════✦

## ∘───── 📋 TODO Checklist ─────∘
- **Initially Posted on**: `13 May 2025` - `Initial Code Review`
- **Last Updated on**: `16 May 2025` - `Checklist Assessment #0-1` // CR_TODO Perform next Checklist Assessment Round

Please use the list below as a working guideline. I recommend copying it or creating your own version, ideally in a format I can also access and follow along with. A good option would be to add a new tab in your existing Set Plan Excel document for this purpose.

I'll be using this list here to track your progress as well. As you work through the items, feel free to update your version, and I’ll mirror any changes here in the thread to keep everything in sync. This way, we can easily monitor what's been completed and what still needs attention.

### --⇢ 📐 TODO Legend ⇠--
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out (by CR)
- ❌ CANCELED — Task was dropped or no longer applicable (by Reviewee)

### ---⇢ 📌 Initial Code Review Tasks ⇠---
### ✅ 🛠️❓ Code Notes *"Map State"* `$0x10d848 - $0x10e360`
### ✅ 🛠️❓ Code Notes *"Oxygen"* & *"Health"*
### ✅ 🛠️❓ Code Notes Time-Related - Missing Time Unit
### ✅ 🛠️❓ Code Note `$0x11f618` Additions Possible
### ✅ 🛠️❓ Flag Documentation
Jr has updated relevant code notes where applicable
### ✅ 🛠️❓ Code Notes **"Pre-mission"* `$0x40698`
Pre-mission is defined at `$0x03f864`. 
`$0x0406c0` is also updated as it's relevant to this.
### ✅ 🧪❓ Development Questions
I absolutly loved reading through the Jr's development/testing process. Jr seems to have learned a lot by hitting different obstacles and trying to overcome/fix them, very nice. This is how you learn!
### ✅ 🏆❓ Missables Question
Jr explained the usage of marking the achievements missable, very well. Jr has also done some updates to clarify that these missables can only be completed within the first playthrough of a level.
### ✅ 🖼️💡 Badge Quality Uplift
This topic is touched upon, art-request may be made. It's not a HARD requirement. Badges can always be updated post-set release.
### ✅ ⚖️💡 Point Increase
Jr has increase the score of a few achievements somewhat, good.
### ✅ 🧩❗ Achievement [Ride the Ray](https://retroachievements.org/achievement/497654) - Additional Delta 
Jr placed delta only on the pointer, but it needs to be on the pointed to value 
### ✅ 🧩❓ Achievement [It's All Coming Together](https://retroachievements.org/achievement/497647) - Logic Question
Code note `$0x040bcc` updated which explains the logic question
### ✅ 🧩❓ Cheat-Protection - Questions
Explanation and the choices surrounding the design of cheat protection are clear and well thought out
### ✅ 🔧❓ Macro Usage - @Score vs @Number
### ✅ 🧭❓ Hubs & Similar Games
### ✅ 🗂️❓ Game Page Metadata

### ---⇢ 📌 Wrap-Up Tasks (before set promotion) ⇠--- // TODO
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

### ---⇢ 📌 Additional Tasks (post-set promotion) ⇠--- // TODO
🔲 Write RAnews Set Highlight Fill out [form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview)

When the full checklist is completed and confirmed, we can proceed with finalizing the review and begin discussing the set’s promotion. Until then, feel free to ping me anytime if you’ve completed the task list or have further questions, I’ll be happy to review things again when ready.

## ∘───── 📚 Final Thoughts ─────∘
This is a very solid achievement set, for a quite unique game, and this being your first set is even more astounding. Most of the things I remarked/noted about above, are rather small nitpicky/minor things/details, which could be improved upon. Most of these are just suggestions or questions as well, so there weren't any major issues. I'm pretty sure you'll be out of the junior program... soon, if you keep up this quality of work. Splendid!

# %%%%%%%%%%%%% POST-INITIAL CODE REVIEW %%%%%%%%%%%%% #

# ✦═══════✦ 🔍 CR Reassessment Round #1  ✦═══════✦ // TODO

## ∘───── 🛠️ Tasks / Issues ─────∘ // TODO

## ∘───── 📋 TODO Checklist ─────∘ // TODO
- **Initially Posted on**: `DD Month YYYY` - `Reassessment Round #xx`
- **Last Updated on**: `DD Month YYYY` - `Checklist Assessment #[ReassessmentRoundNumber]-[ChecklistAssessmentNumber]` // CR_TODO Perform next Checklist Assessment Round
Please update this checklist as you work through items. I would advise copying/updating it here or in a document online, which you and I can view/follow.
If you don't, I may update this list here via this discord thread.

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

### ---⇢ 📌 Wrap-Up Tasks (before set promotion) ⇠--- // TODO
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

#  ✦═══════✦ :check: Wrap-Up & Next Steps ✦═══════✦

### ---⇢ 🎓 Retrospective ⇠---
The achievement set was very solid overall. No major issues were found, only one minor issue involving a misplaced `delta` in a single achievement's logic. For a first set, you’ve clearly demonstrated a strong understanding of the toolkit and good design sense.

### ---⇢ 🤔 Suggestions ⇠---
You already seem to have a great grasp of RA’s toolkit, which is impressive. Going forward, I’d recommend trying  to select a game of this complexity again, something that lends itself to creative or intricate achievements.

You've shown familiarity with advanced features such as checkpoint hitcounts and ResetIf, which is great. However, I encourage you to gain some more hands-on experience with:
- PauseIf & PauseLocks (although you used ResetIf + CheckPoint HitCounts instead, which makes it kinda equal to this)
- AddAddress, AddSource, and SubSource (show us more varied usage of this)
- Bitflags and memory flag handling + documentation practices surrounding these

If your next set maintains this level of quality and avoids major issues, I’m confident you'll be ready for full dev status in no time. Show us you can 

## ∘───── 🌟 Set Promotion ─────∘
Alright, we'll be promoting the set, once you're ready. Any achievements marked `[VOID]` will remain in Unofficial.

Please review the **"Achievement News Announcement"** template below, which shall be posted in **#achievement-news** in RAdiscord
- Let me know if the video I’ve provided is okay, else share a link to a more suitable one if you prefer.
- Do you have any flavour text you'd like to include with the announcement? Try to write something that will make players excited to try out your set. You could briefly highlight what makes the game fun or unique, or what kind of experience the achievement set offers.

Reply/ping me once you’ve looked it over and are ready to promote it!
> ℹ️ **NOTE** — Both of us need to be online at the same time to promote the set. Let me know when you're available so we can coordinate.
> Here’s how it’ll go: I will be promoting all achievements to Official. Afterwards you'll need to click the `Complete Claim` button from the `Dev` drop-down menu on the game page, ideally within a reasonable timeframe after the promotion of the set. That’s all there is to it!

### ---⇢ 💎 Achievement News Announcement ⇠---
```ansi
Title:       [1;31m Treasures of the Deep [0m
Console:     [0;34m PlayStation [0m
Developer:   [0;32m Black Ops Entertainment [0m
Genre:       [0;35m Action, Simulation [0m
Released:    [0;33m September 24, 1997 [0m
```
A new set was published by @stoneskipper42 on <t:1747594704:D>

Too many aliens in Subnautica? Not enough shooting in Endless Ocean? Try Treasures of the Deep, an action submarine simulator that pits you against the evil Seismic Corp as you interact with over 50 species of marine life and search for treasure across 14 missions. Can you uncover the secrets of the treasures of the deep?

[Gameplay](https://www.youtube.com/watch?v=6jDtggvOnHQ&list=PL21nKMUhIdU3rjAsS2us8iRSuemSvpz6k)
[RetroAchievements Game Page](https://retroachievements.org/game/19403)

#  ✦═══════✦ :kirbyjam: Post-Set Promotion ✦═══════✦

## ∘───── ✒️ RANews Set Highlight ─────∘
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

Once you've submitted your entry into the form, feel free to ping me, so we can mark this post-set promotion task as done! 
