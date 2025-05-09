# %%%%%%%%%%%%% SET PLAN REVIEW NOTES %%%%%%%%%%%%% #
# ''''''''''''''''''''''''''''''''''''''''''''''''' #
 
# ------TODO List------
- Labels `progression` `win condition` `missable` correctly used
- Text conform to [RAdocs - Writing Policy](https://docs.retroachievements.org/guidelines/content/writing-policy.html)
- Check challenge variety, based on what features/mechanics the game has (HP, shooting, weapons, abilities, enemies, bosses...)
-

# ------Usefull unicode characters------
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

# ------TODO Legend------
🔲 TODO — Not started
🔄 WIP — Work in progress
✅ DONE — Completed
❌ CANCELED — No longer planned

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465) Single Letter Title
Only one letter title? Could you elaborate on this choice?

### 🔲 ❗ Achievement [G](https://retroachievements.org/achievement/482465) Broken
Broken because ...

### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) Improvement Suggestion
Do this instead of that...



# %%%%%%%%%%%%% SET PLAN REVIEW TEMPLATE %%%%%%%%%%%%% #
# '''''''''''''''''''''''''''''''''''''''''''''''''''' #
// Review [RAdocs - Junior Developer Program Rules](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html#junior-developer-program-rules)
// Check [Rules and Restrictions](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html#rules-and-restrictions)

# ------Intro------
// - RA user history (game awards)
// - devved sets before
// - part of any other teams

Hello @_USERNAME_

Hey there! Thank you for your interest in joining the RA Developer Cohorts, and welcome! It’s great to see that you’re already an enthusiastic RA achievement hunter. Now that you're looking to create a set of your own, that’s really exciting to see!

Now, please take some time to carefully read through all the notes and suggestions below. They’re here to help guide you through the process and ensure your first set is off to a strong start.

Once you’ve gone through everything and made any needed adjustments, we’ll get you devving in no time!

# ✦═══════✦ 🔍 Set Plan Review ✦═══════✦ // TODO

## 🎯 Overal Set Design (progression/missables) // TODO
/// Balance, creativity, progression, and content coverage. 

### 👉 Titles // TODO
// Conform to [RAdocs - Writing Policy](https://docs.retroachievements.org/guidelines/content/writing-policy.html#achievement-titles)
// Title Case, Copy pasted level names?

### 👉 Descriptions // TODO
// Conform to [RAdocs - Writing Policy](https://docs.retroachievements.org/guidelines/content/writing-policy.html#achievement-descriptions)

### 👉 Achievements Types/Labels (progression/missables) // TODO
// Achievement types: https://docs.retroachievements.org/guidelines/content/progression-and-win-condition-guidelines.html
Any `missable` achievements? Think of a player that only wants to play through this game once in order to earn the `Beaten` status, and maybe earn some extra achievements along the way... Again you make this choice, since you know the game best. If there's none it's fine.

### 👉 Difficulty Balancing // TODO
// Difficulty balance: [RAdocs - Difficulty Guidelines](https://docs.retroachievements.org/developer-docs/difficulty-scale-and-balance.html)  

### 👉 Unwelcome Concepts // TODO
// Unwelcome concepts: [RAdocs - Unwelcome Concepts](https://docs.retroachievements.org/guidelines/content/unwelcome-concepts.html)

### 👉 Point Distribution // TODO
// Conform to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html)

### 👉 Challenges & Variety // TODO
// Enough variation in challenges, are features/game mechanics touched upon?




# ✦═══════✦ ℹ️ Optional Considerations ✦═══════✦ // TODO

> This section is `optional` at this stage, but it may prove useful for your growth as a junior developer later on.

## 🚦 Feature Usage (Trigger / Measured) // TODO
Consider RA’s [Trigger](https://docs.retroachievements.org/developer-docs/flags/trigger.html#trigger) and [Measured](https://docs.retroachievements.org/developer-docs/flags/measured.html#measured) features where appropriate to provide players with clearer feedback during gameplay for specific achievements. These features not only improve the achievement experience but also help reduce confusion or frustration during more complex challenges. You could potentially mark these feature on the set plan as well. 

> ### Trigger Indicator
> `"This functionality allows putting indicators on the screen to help players know when a challenge is active, or more importantly, when they fail the challenge."`
>
> A prime example would be for `a damageless boss fight`. A trigger indicator is displayed on screen when the boss fight starts, and is removed from the screen when the player takes damage, giving the player feedback that the challenge has failed, and he has to retry.

> ### Measured Indicator
> `"Measured marks a condition for tracking progress. It adds a progress bar to the achievement overlay to inform the user how close they are to completing an achievement."`
>
> An example would be `collect all coins within a stage`. If there are 9 coins, a measured indicator could keep track of how many are left to collect. This could be done as 0/9 or in %.
> Another example: `Complete stage x, with only 5 allowed ability activations`. This would start at 5/5 and decrement by 1 when an ability is used, giving the player feedback of how many abilities the player is still alowed to use before the achievement fails.

Using these features can significantly enhance the clarity, functionality, and overall user experience of your achievements. These features help players better understand expectations and track their progress or failure of specific achievements in real time.

## 🏁 Leaderboards & Rich Presence // TODO
- Leaderboards are optional but strongly encouraged.
  Refer to [Leaderboards Guide](https://docs.retroachievements.org/developer-docs/leaderboards.html#leaderboards)
- Rich Presence is **required** before requesting the Code Review down the line.
  Reference: [Rich Presence Guide](https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence)

## 🕹️ Multiplayer // TODO, check if multiplayer is a thing for the game
You may want to consider the multiplayer features of this game, within your set.
If the feature is present then make a choice:
> - ❌ **Disallow Multiplayer**
> All achievements must be earned in single-player mode only.
> - ✅ **Allow Multiplayer**
> Achievements must be unlocked during multiplayer sessions. (Achievements aren't allowed to be unlocked with only 1 player doing all the work)
> - ⚠️ **Partially Allow Multiplayer**
> Some achievements may allow multiplayer unlocks, but this can lead to balancing issues or unintended gameplay advantages (e.g., player 2 assisting player 1). Use with caution and document intent clearly.

You may also consider creating a [Subset - Multi], if for example multiplayer content significantly differs from the single-player experience:
- In this case all the [BaseSet] achievements only unlock with only 1 player is interacting with the game.
- The [Subset] achievements only unlock when multiple players are interacting with the game.
This helps maintain balance and clarity while still supporting full multiplayer content.

If the game includes multiplayer features of any kind, you will also have to apply one of the following [Meta] hubs to your set:
- [Meta - Set Disallows Multiplayer](https://retroachievements.org/hub/26213)
- [Meta - Set Allows Multiplayer](https://retroachievements.org/hub/22986)
- [Meta - Set Partially Allows Multiplayer](https://retroachievements.org/hub/7115)
These hubs help players understand the intended play context of your set, without having to describe it in each achievement's description.

## 📚 Writing RAguide
- Consider preparing a RAguide for the [RAguides/Wiki](https://github.com/RetroAchievements/guides/wiki)

# ✦═══════✦ ✅ Wrap-Up ✦═══════✦
Before we can move you forward into the Junior Developer Program, please take a moment to address the remarks and suggestions outlined above. These are important to ensure your set plan is solid and ready for the next stage.

> **Note**: You may skip the **Considerations** section for now, those are not strict requirements for entry into the program. You'll naturally encounter and work through those once you begin actively developing your set.

Once everything is in order, just give us or me another ping, and we’ll proceed with the next steps!

# 📍 Initial Set Plan (For Reference)
_screenshot of Set Plan before review_

# %%%%%%%%%%%%% POST-INITIAL SET PLAN REVIEW %%%%%%%%%%%%% #
# '''''''''''''''''''''''''''''''''''''''''''''''''''''''' #

# 📍 Altered Set Plan (For Reference)
_screenshot of Set Plan after alterations_ // If no changes, then remove this section

# 🎉 Final Words // TODO
_Add your final encouragement or notes here when submitting them to the Junior Dev Program._