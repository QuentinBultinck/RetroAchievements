Hello @kssfilo

Your Code Review for [RayForce | Gunlock (Arcade)](https://retroachievements.org/game/13588?f=5) has finally arrived!
Please take some time to review everything I've written below. If you have any questions, feel free to reach out.

# ✦───────✦ 🧠 Memory Work & Internal Notes ✦───────✦
// Grouped to represent all the under-the-hood work.

# 🛠️ RAM Digging & Code Notes  
/// Conform to https://docs.retroachievements.org/guidelines/content/code-notes.html

# 🧾 Developer Notes  
/// [Optional] Comments left in logic, RAScript, or planning documents.

# 🧪 Testing & Debugging Results  
/// Mentioned bugs, testing methods, hardcore/softcore checks, peer testing, issues encountered during development, and any achievement concepts that could not be implemented.



# ✦───────✦ 🎮 Achievement Set Design ✦───────✦
// Grouped to cover all visible/user-facing parts.
// Conform to https://docs.retroachievements.org/guidelines/content/achievement-set-requirements.html  
//         and https://docs.retroachievements.org/developer-docs/achievement-development-overview.html
// Any unwelcome concepts (refer to https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html#unwelcome-concepts)

# 🎯 Overall Set Design  
/// Balance, creativity, progression, and content coverage.  
/// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html  
/// Difficulty balance: https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html

# 📝 Titles & Descriptions  
/// Conform to https://docs.retroachievements.org/guidelines/content/writing-policy.html

# 🖼️ Badges  
/// Conform to https://docs.retroachievements.org/guidelines/content/badge-and-icon-guidelines.html  
///          and https://docs.retroachievements.org/developer-docs/badge-and-icon-creation.html

# 🎖️ Point Values  
/// Conform to https://docs.retroachievements.org/developer-docs/achievement-scoring.html



# ✦───────✦ ⚙️ Technical Implementation ✦───────✦
// Grouped for logic quality and RA feature usage.

# 🧩 Achievement Logic  
/// Triggers, reset conditions, edge cases.  
/// Protections: Demo/Cheat/Save/Bios/DipSwitch?  
/// Were flags used correctly? Refer to the Proficiency Checklist.

# 🏆 Leaderboards  
/// Instant Start/Submit implemented?
⚠️ All your Leaderboards activate at the start, leading to constant RAoverlay pop-ups for a about 20+ seconds of each leaderboard starting. I would advise to try to find a way to limit the amount of "primed" leaderboards and try to implement instant Start/Submit leaderboards for most the most of them. All leaderboards which hook onto the HighScore could probably 
be take advantage of such a system, since the high score is already shown on-screen. 

# 📺 Rich Presence  
/// Is a dynamic RP present? Not overly bloated or using unsupported Unicode.  
/// Macros and lookupTables used appropriately?  
/// Refer to https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence



# ✦───────✦ 🚧 Issues / Tasks / Questions ✦───────✦
// Callout section for anything actionable or in doubt.

# ❗ Issues
## Player 2 Issue
♦ From my understanding you're not accounting for a 2nd player in most of your achievements, only for achievement->[Body Guard](https://retroachievements.org/achievement/482594), which is part of the challenge.
> For example: achievement->[Penetration](https://retroachievements.org/achievement/482464) `Complete Stage 1 without dying`
> What if player 2 joins in and dies?
>
> 2nd example: achievement->[X-LAY Pro](https://retroachievements.org/achievement/482546) `Upgrade the main shot to level 6 and the lock-on laser to level 8`
> What if player 2 joins in and earns both these upgrades, instead of player 1?

> You will have to make a decision here to make sure multiplayer is allowed or not. 
> If not, you should update the descriptions accordingly.
> If yes, you should update the logic accordingly to allow both players possibly earning this.

> What could also be done is to implement a [Subset - Multiplayer Cooperative], where this [BaseSet] only allows player 1 to be active/controlled for all achievements, while a subset only requires both players input.
> Refer to following hubs: [Meta - Set Disallows Multiplayer](https://retroachievements.org/hub/26213), [Meta - Set Allows Multiplayer](https://retroachievements.org/hub/22986) or[Meta - Set Partially Allows Multiplayer](https://retroachievements.org/hub/7115)

> Another problems arises with leadeboards and the RichPresence, I also don't think these are accounting for a player 2 joining in.

# 🔧 Tasks  
♦ Decide what to do with player 2 and makes changes to all assets (achievements,leaderboards and RP) where necessary (refer to section "Player 2 Issue" in this Code Review)
♦ Implement leaderboards with an instant Start/Submit feature, wher applicable (refer to section "Leaderboards" in this Code Review)

# ❓ Questions / Clarifications Needed
♦ [Achievement:Ready for Score Attack](https://retroachievements.org/achievement/484580)
> Seems like an [unwelcome concept - Zero Effort Without Purpose](https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html#zero-effort-without-purpose)
> I would suggest perhaps including this information on how to change difficulty into an new or edited achievement, which would require the player to play on a certain difficulty. 

# 🧭 Hubs  
/// Refer to https://docs.retroachievements.org/guidelines/content/game-info-and-hub-guidelines.html

# 🗂️ Game Page Metadata  
/// Is everything correctly filled out on the Manage page?



# ✦───────✦ 📜 Summary & Final Thoughts ✦───────✦
// Overview and high-level review conclusion.  
// What still needs to be proven or improved?  
// Was everything from https://docs.retroachievements.org/developer-docs/am-i-ready-for-review.html covered?