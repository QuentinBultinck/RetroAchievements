/ ======== \
/ CR Notes \
/ ======== \

------Usefull unicode characters------
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


------TODO Legend------
🔲 TODO — Not started
🔄 WIP — Work in progress
✅ DONE — Completed
❌ CANCELED — No longer planned

Examples:

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465)
Only one letter title? Could you elaborate on this choice?

### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) & [My Shot Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123856)
`was Broken` ---should be written as---> `Was Broken`
This issue was documented by the latest version of the [AutoCR tool](https://authorblues.github.io/retroachievements/AutoCR/).



/ ==================== \
/ CODE REVIEW TEMPLATE \
/ ==================== \

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


# ✦───────✦ 🧠 Memory Work & Internal Notes ✦───────✦
// Grouped to represent all the under-the-hood work.

## 🛠️ RAM Digging & Code Notes  
/// Conform to https://docs.retroachievements.org/guidelines/content/code-notes.html

## 🧾 Additional Developer Notes  
/// [Optional] Comments left in logic, RAScript, or planning documents.

## 🧪 Testing & Debugging Results  
/// Mentioned bugs, testing methods, hardcore/softcore checks, peer testing, issues encountered during development, and any achievement concepts that could not be implemented.



# ✦───────✦ 🎮 Achievement Set Design ✦───────✦
// Grouped to cover all visible/user-facing parts.
// Conform to https://docs.retroachievements.org/guidelines/content/achievement-set-requirements.html  
//         and https://docs.retroachievements.org/developer-docs/achievement-development-overview.html

## 🎯 Overall Set Design
/// Balance, creativity, progression, and content coverage.  
/// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html  
/// Difficulty balance: https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html
/// Any unwelcome concepts? https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html

## 📝 Titles & Descriptions
/// Conform to https://docs.retroachievements.org/guidelines/content/writing-policy.html

## 🖼️ Badges
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html

## 🎖️ Point Values
/// Conform to https://docs.retroachievements.org/developer-docs/achievement-scoring.html



# ✦───────✦ ⚙️ Technical Implementation ✦───────✦
// Grouped for logic quality and RA feature usage.

## 🧩 Achievement Logic 
/// Refer to the Proficiency-Checklist
/// Triggers, reset conditions, edge cases. 
/// Multi-hash support?
/// Protections: Demo/Cheat/Save/Bios/DipSwitch?  
/// Were flags used correctly? 

## 🏆 Leaderboard Logic
/// Instant Start/Submit implemented?

## 📺 Rich Presence Logic 
/// Is a dynamic RP present? Not overly bloated or using unsupported Unicode.  
/// Macros and lookupTables used appropriately?  
/// Refer to https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence


# ✦───────✦ 🔑 Misc Prerequisites ✦───────✦

## 🔲 🧭 Hubs & Similar Games
/// Any hubs to add? (Refer to https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html)

## 🔲 🗂️ Game Page Metadata 
/// Is everything correctly filled out on the Manage page?


# ✦───────✦ 📜 Summary & Final Thoughts ✦───────✦
// Overview and high-level review conclusion.  
// What still needs to be proven or improved?  
// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?
