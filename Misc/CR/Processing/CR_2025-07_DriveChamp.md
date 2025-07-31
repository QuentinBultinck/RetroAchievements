# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Junior Developer => https://retroachievements.org/user/Ventilo1
Code Review Thread => _DISCORD_LINK_TO_CODE_REVIEW_
Set Plan Review => _DISCORD_LINK_TO_SET_PLAN_REVIEW_
Ready for Review Thread => https://discord.com/channels/310192285306454017/1363182423009132664
Play Test Thread => https://discord.com/channels/310192285306454017/1364940876979245221
RA Game Page => https://retroachievements.org/game/10091
 
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


# %%%%%%%%%%%%% CODE REVIEW: World Driver Championship %%%%%%%%%%%%% #

# ------Intro------

Hello @_JR_DEV_USERNAME_

Your Code Review for [World Driver Championship (Nintendo 64)](https://retroachievements.org/game/10091?f=5) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

## ∘───── 📑 Table of Contents ─────∘ // TODO, link these
### 🧠 Memory Work & Internal Notes
- 🛠️ RAM Digging & Code Notes
- 🧷 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🕹️ Achievement Set Design
- 🎯 Overall Set Design
- ✍️ Titles & Descriptions
- 🖼️ Badge Art
- ⚖️ Point Distribution
### ⚙️ Technical Implementation
- 🧩 Achievement Logic
- 🔧 Rich Presence Logic
- 🔢 Leaderboard Logic
### 🔑 Misc Prerequisites
### 📜 Summary & Final Notes

## ∘───── Related Links ─────∘
Junior Developer => https://retroachievements.org/user/Ventilo1
Set Plan Review/Jr. Dev Request => Not found
Set Plan => https://docs.google.com/spreadsheets/d/1EF7DQ13QQRKXFCK5cYVMpPHaYrjVEMvQnVv8mAnLUBY/edit?gid=1889006780#gid=1889006780
Ready for Review Thread => https://discord.com/channels/310192285306454017/1363182423009132664
Play Test Thread => https://discord.com/channels/310192285306454017/1364940876979245221
RA Game Page => https://retroachievements.org/game/10091

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦

## ∘───── 🛠️ RAM Digging & Code Notes ─────∘
General feedback for your code notes: It seems you're still in the beginning phase on what's the best method to code note things, especially blocks of data which are correlated, structures or as you refer to them as arrays, consider my feedback below. Most of these are just suggestions, but they would've made it easier for my to understand how certain logic/data structures are reused accross the game.

### ❓ `$0x923ec` Code Note Clarity
Original: ```[float] Qualify time [NTSC]```
How exactly does the float translate to time? In what time unit? What time does f1.0 translate to for example?

### 💡 Documenting Arrays or Structures
Take for example the following code notes: `$0x00099ca0`, `$0x0009a568`. Since this appears to be static RAM, it may be more effective to break these notes down into individual components, rather than lumping everything together in a large, vague note.

A good approach is to document the data layout explicitly using structure definitions. For example, here’s how I’ve done it in some of my sets:
```
[Definition Struct:Coordinates |16-byte]
|''''''''''''''''''''''''''''''''
|+0x0 - [32-bit Float:W_Component]
|¨| - This is perspective divide component. It has a role in perspective projection, where the final coordinates are obtained by dividing X, Y, Z by W.
|+0x4 - [32-bit Float:Y_Coordinate]
|+0x8 - [32-bit Float:Z_Coordinate]
|+0xC - [32-bit Float:X_Coordinate]
```
This format does a few important things:
- It clearly outlines the structure layout.
- It uses explicit offsets (+0x0, +0x4, etc.) relative to the base address, making it easier to trace how each field is accessed. For instance, if the base is 0xB00, then X_Coordinate is at 0xB0C.
- It documents the meaning of each field when known, not just the data type.

Personally, I reserve this struct-style format for data blocks that are pointed to (ie. dynamic or reoccuring structures), but you can adapt it to static arrays/structs as well—particularly if the pattern is repeated and consistent. So you could define the struct once, and if it occurs or is referenced in other spots in game RAM, you can refer to the code note which has the Struct defined.

You can also combine approaches when it makes sense. For example, see how I handled:
- [PoP Warrior Within (PS2)](https://retroachievements.org/codenotes.php?g=3319) `$0x1365650` where static values are pointed to by pointers, and I mixed structural and pointer-based documentation.
- [PoP Warrior Within (PS2)](https://retroachievements.org/codenotes.php?g=3319) `$0x7dda40` for a clear example of how to document bitfields/bitsets with flag-level granularity.

Structuring your notes like this not only makes them easier to read and maintain, but also demonstrates that you understand how the data is laid out and interacted with programmatically.
I'd suggest revisiting the notes you have on similar memory blocks and considering whether a structural format or more detailed breakdown would add clarity.

### 💡 Defining Values
For example `$0x97f88` & `$0x99ca8`:
```[32-bit] [PAL] Address of the 1st track of the 1st championship, mainly used as an arbitrary value for the region check````

Think about adding the following:
```ThisValue == 0x8009a828 --> PAL Region```

Preferably whenever you check if something is equal to a specific value, it should always be documented within the code notes. 

### 💡 Documenting Flags Clearly
Take for example `$0x94698`, original code note:
```
[32-bit] [PAL]
0x01 during countdown
0x00 otherwise
```

A more descriptive and developer-friendly way to document this would be:
```
[32-bit Flag] Is Countdown Active [PAL]
0x1 => true
Any other values => false
```

Labeling it explicitly as a **Flag** helps clarify that this value is binary or boolean in nature—used to signal a specific state. It also conveys intent, which is especially useful when revisiting or collaborating on this documentation later.

I've noticed you’ve already done this in places, for example, `$0xadb70` was nicely labeled. Continuing this convention consistently across similar values would make the documentation even stronger. Wherever flags are used (typically with 0/1, on/off or true/false logic), identifying them explicitly helps distinguish them from general-purpose values or IDs.

This small improvement makes it immediately clear how a given memory address is used—beyond just listing values—and reinforces your understanding of how flag-type logic is implemented in the game's memory.


### 💡 Documentation of Integer Identifiers
To improve the clarity and usefulness of code notes, especially when dealing with raw memory addresses, it's helpful to indicate how specific values are used, in this case IDs.

Take for example `$0xabeb4`, `$0x93de4` or `$0x9aa88`. Simply adding a descriptor like *"ID"* (eg. `Track ID`, `Championship ID`...) immediately signals that the value at that address maps to a specific item or entity—such as a race, track, or mode. This small change makes it easier for others to understand how these memory values relate to gameplay elements.

This not only documents the address but also conveys how it’s used—through identifiable IDs.

Another example of how I would code note `$0x93d58`:
```
[32-bit] Car currently used by the player [PAL]
- Identified by following Car IDs
...Car ID list here...
```
Then, when documenting related addresses such as `$0x93d5c`, `$0x93d60`... you can create a meaningful reference back to the shared ID list:
```
[32-bit] Car used by the AI that starts in 7th place [PAL]
- Identified by Car IDs listed at $0x93d58
```
This approach gives immediate context to other developers, making the notes significantly more useful. It also demonstrates an understanding of how identifiers are reused across different systems within the game, which can be pretty useful when working with undocumented memory.

### 💡 `$0x96870` Not Identified as ASCII
This is actually ASCII. So you can shorten the code note here by just noting it as: `[12-bytes ASCII] Active savefile name [PAL]`

### 💡 `$0x7f954` Improve Clarity of Labeling
This code note reads: 
```
[32-bit] Where's the player [PAL]
0x00 - in menus/loads/result screen
0x01 - in race
0x02 - in replay
```

To align with best practices in clarity and intent-focused documentation, I’d recommend rewriting this as:
```
[32-bit] Player Context State [PAL]  
0x00 => Menu / Loading / Results Screen  
0x01 => In-Race  
0x02 => Replay Mode
```
This format clearly identifies that the value is part of an enumerated set (enum), each representing a distinct gameplay state. Naming it Player Context State or something similarly descriptive better communicates what is being tracked, rather than phrasing it as a vague question ("Where's the player").

This small change greatly improves readability, especially for developers who may be scanning the notes for functional behavior or debugging transitions between game states.

Applying this structured naming convention throughout your notes reinforces your understanding of how state values, flags, and IDs are typically stored and used in memory.

I’d also point out that there are a handful of other code notes that could benefit from improved clarity or more concise labeling—for example, $0x802f0 and $0x92994. Some are written too vaguely, while others are overly verbose or ambiguous in meaning.

I strongly recommend revisiting your full set of notes with a fresh perspective. Where plausible, aim to refine the descriptions to be more precise, descriptive, and intent-driven—just like the examples discussed above.

That said, feel free to use your own judgment here. But keep in mind that improving readability and naming clarity isn’t just for aesthetics—it makes your documentation significantly more useful to others and showcases a deeper understanding of how these values are used in practice. Clarity in reverse engineering is often half the battle won.

### 💡 [Step by Step](https://retroachievements.org/achievement/500954) & code note `$0x97d10`
In your RAScript, you’ve identified the score thresholds at which the player gains a new rank. It would be a great improvement if you also included this same rank progression data directly within the code notes for $0x97d10.

Adding that list—just like you have in the script—not only makes the note more complete but also reinforces the context of how this address is used. Here's why this matters:
- Anyone reading the code notes in isolation should be able to understand what the value means and how it changes.
- Hardcoded values used in RAScripts (like thresholds, IDs, or conditionals) should generally also exist in code notes for transparency and future-proofing.
- This also helps with cross-referencing when debugging or expanding logic for achievements, leaderboards, or rich presence.

In this specific case, having a clear breakdown such as:
```
[32-bit] Player Score [PAL]

Rank Thresholds:
- 0     => Rank 0
- 5000  => Rank 1
- 10000 => Rank 2
...
```
...makes the note significantly more informative.

As a general best practice: any value you're checking against in logic (equality checks, thresholds, ranges, etc.) should ideally be documented in the associated code note—especially when they're key to progression, state changes, or unlocking features.

It makes the notes far more useful to others (and your future self), and improves the long-term maintainability of both your logic and documentation.

## ∘───── 🧷 Additional Developer Notes ─────∘
I pretty much reviewed RAScript in correlation with the section on Code Notes.
The set plan looks good.

## ∘───── 🧪 Testing & Debugging Results ─────∘

### ❓ Development Questions
- I did not fully ready through the Ready for Review thread. But were there any hiccups/problems/remarks that others found/gave and how did you resolve them?
- Did you encounter any problems during set development? Elaborate please.
- Any assets/concepts which you were unable to design/develop?
Seems like you tested things yourself and also requested a play test, which went smoothly.

# ✦═══════✦ 🕹️ Achievement Set Design ✦═══════✦ // TODO
/// Grouped to cover all visible/user-facing parts.
/// Conform to https://docs.retroachievements.org/guidelines/content/achievement-set-requirements.html  
///         and https://docs.retroachievements.org/developer-docs/achievement-development-overview.html
/// [#poll-me](https://discord.com/channels/310192285306454017/511718348178849792) on RAdiscord

## ∘───── 🎯 Overall Set Design ─────∘  // TODO
/// Balance, creativity, progression, and content coverage.  
/// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html  
/// Difficulty balance: https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html
/// Any unwelcome concepts? https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html

### 👍 Positive Observations

### ---⇢ 🏆 Achievements ⇠---
/// Smart usage of `Measured` & `Trigger` flags
### ---⇢ 📺 Rich Presence ⇠---
/// Rich Presence design, all content covered?
### ---⇢ 🌐 Leaderboards ⇠---
/// Any leaderboards? No leaderboard spam?

## ∘───── ✍️ Titles & Descriptions ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/writing-policy.html
/// Consider [#writing-requests on RAdiscord](https://discord.com/channels/310192285306454017/1100757231294750730)
/// Rich Presence text

## ∘───── 🖼️ Badge Art ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html
/// Consider [#art-requests on RAdiscord](https://discord.com/channels/310192285306454017/1048102604963586048)
/// Badge Style & Consistency, Visual Badge Quality

## ∘───── ⚖️ Point Distribution ─────∘  // TODO
/// Conform to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html)

# ✦═══════✦ ⚙️ Technical Implementation ✦═══════✦ // TODO
/// Grouped for logic quality and RA feature usage.
/// [AutoCR](https://authorblues.github.io/retroachievements/AutoCR/)

### 👍 Positive Observations

## ∘───── 🧩 Achievement Logic ─────∘  // TODO
/// Triggers, reset conditions, edge cases. Were flags used correctly? Refer to the Proficiency-Checklist
/// Multi-hash support?
/// Protections: Demo/Cheat/Save/Bios/DipSwitch?  

## ∘───── 🔧 Rich Presence Logic ─────∘  // TODO
/// Is a dynamic RP present? Not overly bloated or using unsupported Unicode.  
/// Macros and lookupTables used appropriately?  
/// Refer to https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence

## ∘───── 🔢 Leaderboard Logic ─────∘  // TODO
/// Leaderboards with instant Start/Submit implemented?

# ✦═══════✦ 🔑 Misc Prerequisites ✦═══════✦ // TODO

### ❓ Hubs & Similar Games // TODO
Are there any **hubs** you think should be added?
Be sure to review the [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html#common-hubs) for proper usage.
I recommend browsing the full list of hubs via [RAweb - Hubs Central](https://retroachievements.org/hubs) to find any relevant matches. 

How about **similar games**?
Consider titles from the same series, or games within a similar genre or with shared mechanics. This list should be limited to 5-6 entries, whilst aiming to have to least 1-2.
Be sure to review the section on this matter in [RAdocs - Similar Games](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html#similar-games)

If the game includes **multiplayer**, one of the following meta hubs may apply, depending on how the set handles multiplayer functionality:
- [Meta - Set Disallows Multiplayer](https://retroachievements.org/hub/26213)
- [Meta - Set Allows Multiplayer](https://retroachievements.org/hub/22986)
- [Meta - Set Partially Allows Multiplayer](https://retroachievements.org/hub/7115)

Since Junior Developers don’t have permission to add hubs or similar games directly, please make a list of all that apply, and we’ll handle the additions from there.

### ❓ Game Page Metadata // TODO
/// [RAdocs - Screenshot Dimensions](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html#screenshot-dimensions) 
Is everything correctly filled out on the **manage page** and **game page**? (publishers, genre, game screenshots, box art, release date...)
Juniors devs should be able to edit these fields themselves via the `Dev drop down menu` or via the `Manage page`.

# ✦═══════✦📜 Summary & Final Thoughts 📜✦═══════❖ // TODO
/// Overview and high-level review conclusion.  
/// What still needs to be proven or improved?  
/// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?

## ∘───── 📋 TODO Checklist ─────∘ // TODO
- **Initially Posted on**: `DD Month YYYY` - `Initial Code Review`
- **Last Updated on**: `DD Month YYYY` - `Checklist Assessment #0-[ChecklistAssessmentNumber]` // CR_TODO Perform next Checklist Assessment Round

Please use the list below as a working guideline. I recommend copying it or creating your own version, ideally in a format I can also access and follow along with. A good option would be to add a new tab in your existing Set Plan Excel document for this purpose.

I'll be using this list here to track your progress as well. As you work through the items, feel free to update your version, and I’ll mirror any changes here in the thread to keep everything in sync. This way, we can easily monitor what's been completed and what still needs attention.

### --⇢ 📐 TODO Legend ⇠--
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

## ∘───── 📚 Final Thoughts ─────∘ // TODO

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

6. Fill out & update Proficiency-Checklist 

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
///
/// Steps to Promoting:
/// -------------------
/// 1. Get them discord and site roles, via (discord) Moderator
///     - Ping the promoted dev with a welcome message in `#dev-chat`, once they got the role (ping Developer role with this msg)
@ Developer Please welcome our newest member _DEV_NAME_HERE_

/// 2. Walk them through bulk promote, complete claim and Achievement News Announcement (let them do these)
///     - Explain how to use `!gan [gameid]` (without brackets) in `#botspam`
///     - Edit in the set release date + ping `achievement-news` role
///     - Post in `#achievement-news` + click the megaphone 📣 to publish the announcement to other servers hooked on to this channel
Whenever you're ready you can promote all you achievements (disregarding `[VOID]` assets) to official.
Make sure to follow up your set promotion with an **"Achievement New Announcement"** shortly after, which should be posted in [@achievement-news on RAdiscord](https://discord.com/channels/310192285306454017/310207383542562816). 
A template for this announcement can be generated using the following command `!gan [gameid]` (without brackets) in [#botspam on RAdiscord](https://discord.com/channels/310192285306454017/510694609622532096). This is also the channel where you can test any bot commands. Or you could just edit my custom announcement template:
------------
```ansi
Title:       [1;31m _TITLE_HERE_ [0m
Console:     [0;34m _CONSOLE_HERE_ [0m
Developer:   [0;32m _DEVELOPERS_HERE_ [0m
Genre:       [0;35m _GENRES_HERE_ [0m
Released:    [0;33m MMMM DD, YYYY [0m
```
A new set was published by @ASolidSnack on _TIMESTAMP_HERE_

_FLAVOR_TEXT_HERE_

[Gameplay](_LINK_HERE_)
[RetroAchievements Game Page](_LINK_HERE_)
------------
Don't forget to add the ping `@ achievement-news` and click the megaphone icon :mega: after you post your announcement in the [@achievement-news](https://discord.com/channels/310192285306454017/310207383542562816) channel, so this announcement gets published to any other linked discord servers/channels, for a wider audience.

/// 3. Highlight new things available as full dev:
///     - Up to 4 claims
///     - Ability to edit achievements to address tickets without demoting
///     - Linking new hashes
///     - Channels (dev-requests, dev-chat, dev-help...)
/// 4. Add hub [Dev Events - Junior Developer Graduate Sets](https://retroachievements.org/hub/7975) to game ( + add it to the list in the forum using the CRTeam account??)
/// 5. Request the jr-dev-badge for the promoted dev in [#dev-requests](https://discord.com/channels/310192285306454017/729746925330366555)


/// After things simmer down a bit:
/// -------------------------------
/// - Link the devs docs to incentivize reading them again, since new parts apply. Revisions, subsets and collabs in particular should be read again before engaging with setting up notifications for revisions and rescores
///     - [Dev Tutorial Document](https://docs.google.com/document/d/1Bw5rXp0i1wYe7j1ZgiQje_-oFKxXdJelqKlbdCNXp_E/edit?tab=t.0#heading=h.ksjo1g1oe9n9)
/// - New available events (devquest, devjam...)
/// - Ability to work on inactive devs tickets and the way to access them on-site
/// - Link the many surveys to fill up eventually with no time pressure:
///     - [RAnews Set Highlight Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview)
///     - [Jr-Dev-Program Feedback Form](https://forms.gle/UTKAhdpgx2iaXxxo7)
///     - Revision/gauntlet opt-out
///     - Writing touch-ups permissions
Please take a look at following links to guide you through the new things available as full dev, with no time pressure 
- [Dev Tutorial Document](https://docs.google.com/document/d/1Bw5rXp0i1wYe7j1ZgiQje_-oFKxXdJelqKlbdCNXp_E/edit?tab=t.0#heading=h.ksjo1g1oe9n9)
- [Jr-Dev-Program Feedback Form](https://forms.gle/UTKAhdpgx2iaXxxo7) 
- [RAnews Set Highlight Form](https://docs.google.com/forms/d/e/1FAIpQLSfmbOr99x7vg95t9Fznp6jgdywlAGGHg6AyVzfOwGPentvIaQ/viewform?usp=preview) (Highly request to fill this one out, preferably this should be submitted before the next RAnews issue releases, so we can incorporate this new set within the section of the Junior Developed Sets for the corresponding month)


> *"Promoted to full developer!"*
...

## ∘───── 🌟 Set Promotion ─────∘ // TODO, only include this section, when not promoted to full dev
/// Guide junior through set promotion + ask to review "Achievement News Announcement" template
///
/// Steps to Promoting the Set:
/// --------------------
/// 1. CR: Click `Complete Review Claim` button in `Dev` drop-down menu
/// 2. Jr: Click `Complete Claim` button in `Dev` drop-down menu
/// 3. CR: Post **"Achievement News Announcement"** on their behalf
/// 4. Update status of set in [Jr-Dev-Proficiency Checklist](https://docs.google.com/spreadsheets/d/1xeVscMX1eCllDAHXEHOUcORxyGUgC0jySDc28KHY6o8/edit?gid=1669062073#gid=1669062073)

Alright, we'll be promoting the set, once you're ready. Any achievements marked `[VOID]` will remain in Unofficial.

Please review the **"Achievement News Announcement"** template below, which shall be posted in [#achievement-news in RAdiscord](https://discord.com/channels/310192285306454017/310207383542562816) once the set goes live.
- Let me know if the video I’ve provided is okay, else share a link to a more suitable one if you prefer.
- Do you have any flavour text you'd like to include with the announcement? Try to write something that will make players excited to try out your set. You could briefly highlight what makes the game fun or unique, or what kind of experience the achievement set offers.
- Are there any additional links which should be included? Perhaps an RAguide?

Reply/ping me once you’ve looked it over and are ready to promote it!
> ℹ️ **NOTE** — Both of us need to be online at the same time to promote the set. Let me know when you're available so we can coordinate.
> 
> **Here’s how it’ll go**: I will be promoting all achievements to Official. Afterwards you'll need to click the `Complete Claim` button from the `Dev` drop-down menu on the game page, ideally within a reasonable timeframe after the promotion of the set. That’s all there is to it!
> 
> After that, I’ll post the **"Achievement News Announcement"** on your behalf. Once that’s done, I’ll leave one final comment in the Code Review thread asking for an RAnews Set Highlight snippet. I’ll explain this more when we get to that point.

### ---⇢ 💎 Achievement News Announcement ⇠---
/// Post Achievement-NewsAnnouncement_Template.txt here

#  ✦═══════✦ :kirbyjam: Post-Set Promotion ✦═══════✦ // TODO

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