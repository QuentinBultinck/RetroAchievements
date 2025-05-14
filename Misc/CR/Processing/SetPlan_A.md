# %%%%%%%%%%%%% SET PLAN REVIEW NOTES %%%%%%%%%%%%% #
 
# ------TODO List------ (for use by CR)

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

# ------TODO Legend------
- 🔲 TODO — Task identified but not yet started
- 🔄 WIP — Task is in progress
- ✅ DONE — Task has been completed successfully
- 🟨 DISMISSED – Task was reviewed and ruled out (by CR)
- ❌ CANCELED — Task was dropped or no longer applicable (by Reviewee)

### 🔲 ❓ Achievement [G](https://retroachievements.org/achievement/482465) Single Letter Title
Only one letter title? Could you elaborate on this choice?

### 🔲 ❗ Achievement [G](https://retroachievements.org/achievement/482465) Broken
Broken because ...

### ✅ ❗ Leaderboards [My Laser Button was Broken](https://retroachievements.org/leaderboardinfo.php?i=123855) Improvement Suggestion
Do this instead of that...

# %%%%%%%%%%%%% SET PLAN REVIEW %%%%%%%%%%%%% #
// Review [RAdocs - Junior Developer Program Rules](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html#junior-developer-program-rules)
// Check [Rules and Restrictions](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html#rules-and-restrictions)

# ------Intro------

Hello @Psychometric

Hey there! Thank you for your interest in joining the RA Developer Cohorts, and welcome! 

You mentioned you previously did some work on this title a few years back, which is great to see, but since it’s been quite a while, we’ll be restarting and reevaluating everything from the ground up to ensure a fresh and solid foundation.

Please take some time to carefully read through all the notes and suggestions outlined below. They’re here to guide you through the process and help set you up for success with your first achievement set.

Once you’ve reviewed everything and made any necessary updates or adjustments, we’ll be ready to move things forward and get you devving in no time!

# ✦═══════✦ 🔍 Set Plan Review ✦═══════✦

## 🎯 Overal Set Design (progression/missables)

### 👉 Titles
I'd like to get a feel for how you approach achievement titling, so if possible, please come up with titles for at least 30% of the achievements in your set. This will help demonstrate your tone, creativity, and how well you're aligning the titles with the gameplay context. Doesn’t have to be final or perfect, just enough to give a clear picture of your style and direction.

### 👉 Descriptions
Descriptions look fine.

### 👉 Achievements Types/Labels (progression/missables)
I think you may have annotated a few `missable` achievements as `(M)`, very good. 
> *"Think of a player that only wants to play through this game once in order to earn the `Beaten` status, and maybe earn some extra achievements along the way... Again you make this choice, since you know the game best."*

### 👉 Difficulty Balancing
Does the game come with some sort of difficulty modes? If so they could perhaps be included somehow into the set, althought that's up to you to determine.

### 👉 Unwelcome Concepts
All looks fine, I don't see any problems here.

### 👉 Point Distribution
N/A in this set plan, fair enough, this will then get reviewed during the Code Review down the line. Refer to [RAdocs - Achievement Scoring](https://docs.retroachievements.org/developer-docs/achievement-scoring.html), when you get to that point.

### 👉 Challenges & Variety
I don't see any challenge achievements in your set plan and I believe this game offers a lot of potential for them. Challenge achievements can really enhance player engagement and show off your creativity as a developer.
Think about all the different gameplay elements you can tap into:
- Health management
- Movement mechanics
- Attack variations
- Weapon limitations
- Scoring goals
- Enemy or boss-specific conditions
- Time-based challenges
- And so on...

Try combining some of these to create unique challenge for each stage, for example: `During stage xx, get teleport location for xx, earning a score of at least xxxx` or
`Defeat Krakos using only xx attack, without taking damage`. Try to inspire yourself by other sets within the same genre and see what they've come up with.

I encourage you to look at other achievement sets in similar genres to draw inspiration and see how challenge achievements are handled elsewhere.

As a baseline, I’d like to see at least 3 distinct types of challenge achievements in the final plan, if feasible. If you feel the game doesn't support this kind of design well, please explain your reasoning to us.

On a positive note, I really appreciate the variety you’ve already built into the collection-based achievement, love to see it!

# ✦═══════✦ ℹ️ Optional Considerations ✦═══════✦

> This section is `optional` at this stage, but it may prove useful for your growth as a junior developer later on.

## 🚦 Feature Usage (Trigger / Measured)
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

## 🏁 Leaderboards & Rich Presence
- Leaderboards are optional but strongly encouraged.
  Refer to [Leaderboards Guide](https://docs.retroachievements.org/developer-docs/leaderboards.html#leaderboards)
  There's a highscore mechanic, so I would love to see some leaderboards around this at least.
- Rich Presence is **required** before requesting the Code Review down the line.
  Reference: [Rich Presence Guide](https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence)

## 📚 Writing RAguide
- Consider preparing a RAguide for the [RAguides/Wiki](https://github.com/RetroAchievements/guides/wiki)

# ✦═══════✦ ✅ Wrap-Up ✦═══════✦
Before we can move you forward into the Junior Developer Program, please take a moment to address the remarks and suggestions outlined above. These are important to ensure your set plan is solid and ready for the next stage.

> **Note**: You may skip the **Considerations** section for now, those are not strict requirements for entry into the program. You'll naturally encounter and work through those once you begin actively developing your set.

Once everything is in order, just give us or me another ping, and we’ll proceed with the next steps!

# 📍 Initial Set Plan (For Reference)
_screenshot of Set Plan before review_

# %%%%%%%%%%%%% POST-INITIAL SET PLAN REVIEW %%%%%%%%%%%%% #

# 📍 Altered Set Plan (For Reference)
_screenshot of Set Plan after alterations_ // If no changes, then remove this section

# 🎉 Final Words // TODO
_Add your final encouragement or notes here when submitting them to the Junior Dev Program._