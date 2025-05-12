# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Code Review => _DISCORD_LINK_TO_CODE_REVIEW_
Set Plan Review => _DISCORD_LINK_TO_SET_PLAN_REVIEW_
Ready for Review Thread => _DISCORD_LINK_TO_READY_FOR_REVIEW_
RA Game Page => _LINK_TO_RA_GAME_PAGE_
 
# ------CR TODO List------ (for use by CR)
- Discord Code Review Naming Scheme: `Code Review - [GameTitle] - [DevName]`
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


# %%%%%%%%%%%%% CODE REVIEW: _GAME_TITLE_ %%%%%%%%%%%%% #

# ------Intro------

Hello @_JR_DEV_USERNAME_

Your Code Review for [_GAME_TITLE_ (_CONSOLE_)](_UNOFFICIAL_ACHIEVEMENT_LIST_LINK_) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

## ∘───── 📑 Table of Contents ─────∘ // TODO, link these
### 🧠 Memory Work & Internal Notes _MSG_LINK_ 
- 🛠️ RAM Digging & Code Notes
- 🧷 Additional Developer Notes
- 🧪 Testing & Debugging Results
### 🕹️ Achievement Set Design _MSG_LINK_
- 🎯 Overall Set Design
- ✍️ Titles & Descriptions
- 🖼️ Badge Art
- ⚖️ Point Distribution
### ⚙️ Technical Implementation _MSG_LINK_
- 🧩 Achievement Logic
- 🔧 Rich Presence Logic
- 🔢 Leaderboard Logic
### 🔑 Misc Prerequisites _MSG_LINK_
### 📜 Summary & Final Notes _MSG_LINK_

## ∘───── Related Links ─────∘ // TODO, link these
Set Plan Review/Jr. Dev Request
Ready for Review Thread
RA Game Page

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦ // TODO
// Grouped to represent all the under-the-hood work.

## ∘───── 🛠️ RAM Digging & Code Notes ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/code-notes.html

## ∘───── 🧷 Additional Developer Notes ─────∘  // TODO
/// [Optional] Comments left in logic, RAScript, planning documents, other threads on discord.

## ∘───── 🧪 Testing & Debugging Results ─────∘  // TODO
/// Mentioned bugs, testing methods, hardcore/softcore checks, peer testing, issues encountered during development, and any achievement concepts that could not be implemented.

# ✦═══════✦ 🕹️ Achievement Set Design ✦═══════✦ // TODO
// Grouped to cover all visible/user-facing parts.
// Conform to https://docs.retroachievements.org/guidelines/content/achievement-set-requirements.html  
//         and https://docs.retroachievements.org/developer-docs/achievement-development-overview.html

## ∘───── 🎯 Overall Set Design ─────∘  // TODO
/// Balance, creativity, progression, and content coverage.  
/// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html  
/// Difficulty balance: https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html
/// Any unwelcome concepts? https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html
/// Leaderboards present, no leaderboard spam?
/// Rich Presence design, all content covered?

### ---⇢ 🏆 Achievements ⇠---
### ---⇢ 📺 Rich Presence ⇠---
### ---⇢ 🌐 Leaderboards ⇠---


## ∘───── ✍️ Titles & Descriptions ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/writing-policy.html
/// Rich Presence text

## ∘───── 🖼️ Badge Art ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html
/// Badge Style & Consistency, Visual Badge Quality

## ∘───── ⚖️ Point Distribution ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/developer-docs/achievement-scoring.html

# ✦═══════✦ ⚙️ Technical Implementation ✦═══════✦ // TODO
// Grouped for logic quality and RA feature usage.

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

### 🧭❓ Hubs & Similar Games // TODO
Any hubs to add? (Refer to [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html))
Any similar games to add? Think of games that may fit the same genre or games of the same series, perhaps.

### 🗂️❓ Game Page Metadata // TODO
Is everything correctly filled out on the **manage page** and **game page**?

# ✦═══════✦📜 Summary & Final Thoughts 📜✦═══════❖ // TODO
// Overview and high-level review conclusion.  
// What still needs to be proven or improved?  
// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?

## ∘───── 📋 TODO Checklist ─────∘ // TODO
- **Initially Posted on**: `DD Month YYYY` - `Initial Code Review`
- **Last Updated on**: `DD Month YYYY` - `Checklist Assessment #0-[ChecklistAssessmentNumber]` // CR_TODO Perform next Checklist Assessment Round

Please update below list as you work through items. I would advise copying/updating it here or in a document online, which I can view/follow.
I may update this list here as you progress through the items, as well.

### --⇢ 📐 TODO Legend ⇠--
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out
- ❌ CANCELED — Task was dropped or no longer applicable

### ---⇢ 📌 Initial Code Review Tasks ⇠--- // TODO
### 🔲 🧪❗ ...
### 🔲 🖼️❓ ...
### 🔲 🧩❓ ...
### 🔲 🧩❗ ...
### 🔲 🔧❓ ...
### 🔲 🧭❓ Hubs & Similar Games
### 🔲 🗂️❓ Game Page Metadata

### ---⇢ 📌 Wrap-Up Tasks (before set promotion) ⇠--- // TODO
🔲 Testing after logic changes
🔲 ...
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

When the full checklist is completed and confirmed, we can proceed with finalizing the review and begin discussing the set’s promotion. Until then, feel free to ping me anytime if you’ve completed the task list or have further questions, I’ll be happy to review things again when ready.

## ∘───── 📚 Final Thoughts ─────∘ // TODO

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
- 🟨 DISMISSED – Task was reviewed and ruled out
- ❌ CANCELED — Task was dropped or no longer applicable

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
🔲 Testing after logic changes
🔲 ...
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

#  ✦═══════✦ ✔️ Wrap-Up & Next Steps ✦═══════✦ // TODO
## 🎓 ∘───── Reflection & Suggestions ─────∘ 
/// Reflection on what was learned + Feedforward (suggestions for future Jr. Dev process).