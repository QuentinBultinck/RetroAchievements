# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------Links Related to Code Review------
Junior Developer => _LINK_TO_RA_USER_
Code Review Thread => _DISCORD_LINK_TO_CODE_REVIEW_
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

## ∘───── Related Links ─────∘ // TODO, link these
Junior Developer => _LINK_TO_RA_USER_
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
///     - Ping the promoted dev with a welcome message in `#dev-chat`, once they got the role
/// 2. Walk them through bulk promote, complete claim and Achievement News Announcement (let them do these)
///     - Explain how to use `!gan [gameid]` in `#botspam`
///     - Edit in the set release date + ping `achievement-news` role
///     - Post in `#achievement-news` + click the megaphone 📣 to publish the announcement to other servers hooked on to this channel
/// 3. Highlight new things available as full dev:
///     - Up to 4 claims
///     - Ability to edit achievements to address tickets without demoting
///     - Linking new hashes
///     - Channels (dev-requests, dev-chat, dev-help...)
/// 4. Add hub [Dev Events - Junior Developer Graduate Sets](https://retroachievements.org/hub/7975) to game ( + add it to the list in the forum using the CRTeam account??)
/// 5. Request the jr-dev-badge for the promoted dev in #dev-requests
/// 
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