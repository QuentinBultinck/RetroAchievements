# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Code Review => _DISCORD_LINK_TO_CODE_REVIEW_
Set Plan Review => _DISCORD_LINK_TO_SET_PLAN_REVIEW_
Ready for Review Thread => _DISCORD_LINK_TO_READY_FOR_REVIEW_
Play Test Thread => _DISCORD_LINK_TO_PLAY_TEST_
RA Game Page => _LINK_TO_RA_GAME_PAGE_
 
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
Junior Developer => _LINK_TO-RA_USER_
Set Plan Review/Jr. Dev Request => _LINK_DISCORD_THREAD_
Set Plan => _LINK_TO_SET_PLAN_
Ready for Review Thread => _LINK_DISCORD_THREAD_
Play Test Thread => _LINK_DISCORD_THREAD_
RA Game Page => _LINK_RA_GAME_PAGE_

# ✦═══════✦ 🧠 Memory Work & Internal Notes ✦═══════✦ // TODO
/// Grouped to represent all the under-the-hood work.

## ∘───── 🛠️ RAM Digging & Code Notes ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/code-notes.html

## ∘───── 🧷 Additional Developer Notes ─────∘  // TODO
/// [Optional] Comments left in logic, RAScript, planning documents, other threads on discord.

## ∘───── 🧪 Testing & Debugging Results ─────∘  // TODO
/// Mentioned bugs, testing methods, hardcore/softcore checks, peer testing, issues encountered during development, and any achievement concepts that could not be implemented.

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
/// Rich Presence text

## ∘───── 🖼️ Badge Art ─────∘  // TODO
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html
/// [#art-request](https://discord.com/channels/310192285306454017/1048102604963586048) on RAdiscord
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
Any hubs to add? (Refer to [RAdocs - Hubs Guidelines](https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html) and [RAweb - All Hubs](https://retroachievements.org/hubs))
Any similar games to add? Think of games that may fit the same genre or games of the same series, perhaps.

### ❓ Game Page Metadata // TODO
Is everything correctly filled out on the **manage page** and **game page**?

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

### ---⇢ 📌 Wrap-Up Tasks (before set promotion) ⇠--- // TODO
🔲 Testing after logic changes
🔲 ...
🔲 **[CR Task]** Reflection (on what was learned) & Feedforward (suggestions toward future Jr. Dev process).
🔲 **[CR Task]** Wrap-Up & Next Steps (Set Promotion)

#  ✦═══════✦ ✔️ Wrap-Up & Next Steps ✦═══════✦ // TODO
## 🎓 ∘───── Reflection & Suggestions ─────∘ 
/// Reflection on what was learned + Feedforward (suggestions for future Jr. Dev process).