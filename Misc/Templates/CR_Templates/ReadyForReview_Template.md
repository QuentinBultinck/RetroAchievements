# %%%%%%%%%%%%% CODE REVIEWER NOTES %%%%%%%%%%%%% #

# ------CR TODO List------ (for use by CR)
- Discord Code Review Naming Scheme: `Code Review - [GameTitle (Console)] - [DevName]`
- Check prior work via Proficieny-Checklist
- Remove all comments ///

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

## ∘───── Related Links ─────∘ // TODO, link these
Junior Developer => _LINK_TO-RA_USER_
Set Plan Review/Jr. Dev Request => _LINK_DISCORD_THREAD_
Set Plan => _LINK_TO_SET_PLAN_
Ready for Review Thread => _LINK_DISCORD_THREAD_
Play Test Thread => _LINK_DISCORD_THREAD_
RA Game Page => _LINK_RA_GAME_PAGE_

# %%%%%%%%%%%%% READY FOR REVIEW %%%%%%%%%%%%% #

# ------Intro_A------

Hello @_JR_DEV_USERNAME_

Your set look pretty polished, but I have a few remarks I'd wish for you to address before we get you into the backlog.

That said, please keep in mind that I'm not deeply familiar with this game beyond the quick glance I took. So any feedback I provide here should always be weighed against your own understanding of the game’s design. You’re the expert here.


# ------Intro_OK------

Hello @_JR_DEV_USERNAME_

Your set look very solid, I have no major remarks to offer. Everything appears well put together based on my brief review.

That said, please keep in mind that I'm not deeply familiar with this game beyond the quick glance I took. So any feedback I provide here should always be weighed against your own understanding of the game’s design. You’re the expert here.

# ------Checklist (for CR)------

### 👉 Overal Set Design
/// All content covered and creativity

### 👉 Titles // TODO
/// Conform to [RAdocs - Writing Policy](https://docs.retroachievements.org/guidelines/content/writing-policy.html#achievement-titles)
/// Title Case, Copy pasted level names?

### 👉 Descriptions // TODO
/// Conform to [RAdocs - Writing Policy](https://docs.retroachievements.org/guidelines/content/writing-policy.html#achievement-descriptions)
/// Consider [#writing-requests on RAdiscord](https://discord.com/channels/310192285306454017/1100757231294750730)

### 👉 Achievements Types/Labels (progression/missables) // TODO
/// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html
Any `missable` achievements? 
> *"Think of a player who only wants to play through the game once to earn the Beaten status, perhaps picking up a few achievements along the way..."*
- If missing an achievement would require replaying a significant portion of the game, it might also warrant the `missable` tag. Of course, if the game includes features like chapter or level select, this concern is largely mitigated.
You're the expert on this game, so this is up to you.

### 👉 Difficulty Balancing // TODO
/// Difficulty balance: [RAdocs - Difficulty Guidelines](https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html)  

### 👉 Badges // TODO
/// Unique per achievement, non re-used?
/// Consider [#art-requests on RAdiscord](https://discord.com/channels/310192285306454017/1048102604963586048)

### 👉 Unwelcome Concepts // TODO
/// Unwelcome concepts: [RAdocs - Unwelcome Concepts](https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html)

### 👉 Point Distribution // TODO
/// Conform to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html)

### 👉 Challenges & Variety // TODO
/// Enough variation in challenges, are features/game mechanics touched upon?

### 👉 Code Notes // TODO
/// Notation according to standards? [RAdocs - Code Notes](https://docs.retroachievements.org/guidelines/content/code-notes.html#code-notes)
/// All RAM values used in logic have code notes?

### 👉 Implementation // TODO
/// Review 3 random achievements + a few leaderboards

### 👉 Rich Presence (on site) // TODO
/// Is there Dynamic RP?
/// Does this look good from a glance?

### 👉 Testing // TODO
/// Jr. should elaborate how the set is tested personally 
/// Consider [#playtest-requests on RAdiscord](https://discord.com/channels/310192285306454017/1169258130555797524)

# ------Closing Notes------ // TODO

Please do your best to address all of the 👉 feedback above. Once you've gone through everything and made the necessary changes, ping `code-reviewer` again, So we can re-evaluate and then officially add you to the review backlog.

# %%%%%%%%%%%%% POST-READY FOR REVIEW %%%%%%%%%%%%% # // TODO, once added to the backlog

You've been added to the backlog. Now please be patient until the CR-team gets through the list. You'll be our next Code Review in no time. 
In the meantime, here are a few suggestions to make the most of the wait:
- *(Recommended)* Keep testing and polishing your set. The less problems there are discovered during the Code Review, the faster you'll be out of the junior program and earn full dev status. I highly advise to read any Code Reviews that come up, to see what other juniors often struggle with or have done well.
- *(Recommended)* See where you can incorporate Measured or Trigger flags for better player feedback.
- *(Recommended)* Add or improve leaderboards, if applicable.
- *(Optional)* Revisit any achievements you struggled to implement, fresh ideas may help. 
- *(Optional)* Add support for an alternate hash if the game has other versions.
- *(Optional)* Consider writing an [RAguide](https://github.com/RetroAchievements/guides/wiki) to help players understand the set.
- *(Optional)* Get involved with other parts of the RAcommunity, whether that’s helping other Junior Devs, contributing to the Art Team, Writing Team, Playtesters, RANews or even helping with coding.

Your extra efforts will not only help your own set stand out, they’ll also be a great way to grow as a developer in the community.
