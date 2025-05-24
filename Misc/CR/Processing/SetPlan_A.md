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

# ------Intro_A------
// - RA user history (game awards)
// - devved sets before
// - part of any other teams

Hello @_USERNAME_

Hey there! Thank you for your interest in joining the RA Developer Cohorts, and welcome! It’s great to see that you’re already an enthusiastic RA achievement hunter. Now that you're looking to create a set of your own, that’s really exciting to see!

Now, please take some time to carefully read through all the notes and suggestions below. They’re here to help guide you through the process and ensure your first set is off to a strong start.

Once you’ve gone through everything and made any needed adjustments, we’ll get you devving in no time!

# ------Intro_B------

Hello @_USERNAME_

Hey there! Thank you for your interest in joining the RA Developer Cohorts, and welcome! 

Please take some time to carefully read through all the notes and suggestions outlined below. They’re here to guide you through the process and help set you up for success with your first achievement set.

Once you’ve reviewed everything and made any necessary updates or adjustments, we’ll be ready to move things forward and get you devving in no time!

# ✦═══════✦ 🔍 Set Plan Review ✦═══════✦

## 🎓 Development Intentions
- What are your main motivations for joining the RA Developer Program?
- Do you see yourself becoming a full developer, or are you mainly interested in trying it out temporarily?
- Are there specific games or genres you’re especially interested in working on?

## 🎯 Overal Set Design
The set looks solid overall. Your prior experience as an active RA achievement hunter may have helped a lot in designing thoughtful achievements. It’s also great to see you’ve had input or insights from the developer of the hack itself. Although as a small note: Juniors may only make a maximum of 1 set for a hack during the Junior Developer Program, refer to [RAdocs - Junior Dev Program - Rules and Restrictions](https://docs.retroachievements.org/developer-docs/jr-dev-rules.html#rules-and-restrictions).

### 👉 Titles
Some titles are incorrectly capitalized. Refer to [RAdocs - Writing Policy - Capitalization](https://docs.retroachievements.org/guidelines/content/writing-policy.html#capitalization)
Examples:  
- `Contender For Fastest Thing Alive` --> `Contender for Fastest Thing Alive`
- `One Way Or Another, I'm Gonna Get Ya!` --> `One Way or Another, I’m Gonna Get Ya!`

### ✅ Descriptions
All the descriptions look good to me. They fit well with the adventure tone of the hack, offering hints rather than spelling out the exact objectives, which suits the genre nicely.

### ✅ Achievements Types/Labels (progression/missables)
You've marked some achievements as `missable`, very good.
> *"Think of a player who only wants to play through the game once to earn the Beaten status, perhaps picking up a few achievements along the way..."*
- If missing an achievement would require replaying a significant portion of the game, it might also warrant the `missable` tag. Of course, if the game includes features like chapter or level select, this concern is largely mitigated.
You're the expert on this game, so this is up to you.

### ✅ Point Distribution
At a glance, the 83-point total feels slightly low, but it's hard to judge without knowing how long mastering the set actually takes. If full mastery takes more than 2–4 hours, I’d consider raising the total score to slightly above 100.

That said, since you’re already an experienced player, I trust your instincts on this. Personally, I tend to give the main win condition of a game at least 10 points, but that's just my perspective.

### ✅ Challenges & Variety
Looks like you've manage to design a variety of interesting challenges for what seems to make this 2D Platformer into more of an adventure type title, if I'm not mistaken? Very nice to see!
You mainly focus on side quest/Easter egg type achievements, which does mostly fit with this genre after all.

### ✅ Rich Presence
For better clarity and flavor, I’d suggest including both the level name and an emoji in your RP string. For example:
> *"Mario is searching for clues in 🏙 Cointreau City"*

This can improve readability, especially since standalone emojis often don’t communicate much to players unfamiliar with the context of the game. That said, it’s ultimately your call.

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
- You already designed a few leaderboards, very nice to see!
  Refer to [Leaderboards Guide](https://docs.retroachievements.org/developer-docs/leaderboards.html#leaderboards) if you need any more details.
- Rich Presence is **required** before requesting the Code Review down the line, but it seems you've already brainstormed about this as well, very good!
  Reference: [Rich Presence Guide](https://docs.retroachievements.org/developer-docs/rich-presence.html#rich-presence)

## 📚 Writing RAguide
- Consider preparing a RAguide for the [RAguides/Wiki](https://github.com/RetroAchievements/guides/wiki)

# ✦═══════✦ ✅ Wrap-Up ✦═══════✦
Before we can move you forward into the Junior Developer Program, please take a moment to address the 👉 remarks and suggestions outlined above. These are important to ensure your set plan is solid and ready for the next stage.

Just to clarify, this is the design phase. You don't need to worry yet about whether you can code the achievements; the focus of this short review right now is simply on brainstorming and outlining ideas.

> **Note**: You may skip the **Considerations** section for now, those are not strict requirements for entry into the program. You'll naturally encounter and work through those once you begin actively developing your set.

Once everything is in order, just give us or me another ping, and we’ll proceed with the next steps!

# 📍 Initial Set Plan (For Reference)
_screenshot of Set Plan before review_

# %%%%%%%%%%%%% POST-INITIAL SET PLAN REVIEW %%%%%%%%%%%%% #

# 📍 Altered Set Plan (For Reference)
_screenshot of Set Plan after alterations_ // If no changes, then remove this section

# 🎉 Final Words // TODO
_Add your final encouragement or notes here when submitting them to the Junior Dev Program._