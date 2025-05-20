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

# ------Intro_OK------

Hello @_JR_DEV_USERNAME_

Your set look very solid, I have no major remarks to offer. Everything appears well put together based on my brief review.

That said, please keep in mind that I'm not deeply familiar with this game beyond the quick glance I took. So any feedback I provide here should always be weighed against your own understanding of the game’s design. You’re the expert here.

# ------Checklist (for CR)------

### ✅ Overal Set Design
Is all content covered? Seems like it. Even some secret stages and what not.

### ✅ Titles & Descriptions
All text looks good, no complaints. Love the titles.

### ✅ Achievements Types/Labels (progression/missables)
Did you consider the `missable` type for achievements? 
> *"Think of a player that only wants to play through this game once in order to earn the `Beaten` status, and maybe earn some extra achievements along the way... Again you make this choice, since you know the game best."*

### ✅ Badges
High-quality badges, love to see it

### 👉 Difficulty Balancing & Point Distribution
You have a large variety of highly scored achievements (25, 50 and 100-pointers). Are they really that hard to achieve. Consider going through other sets of the same genre and see how they scored similar achievements, but again you're the expert here. I also think we went over this during your Jr Dev Request for this game, refer to https://discord.com/channels/310192285306454017/1370239209343815730/1370315667214962718. If you think they're fine, elaborate on this again, to clarify your choices here.

### ✅ Challenges & Variety
Lots of challenges and variety in them, love to see it.

### 👉 Code Notes
Highly recommended to add the prefix `0x` to all hexadecimal values within your code notes. Take a look at `$0x727e`:
``` 	
[8-bit] Screen ID

00 = Bootup
02 = Score Ranking
04 = Title Screen
05 = Demo/Frame Before 06
06 = In-Game?
08 = Recycle It, Don't Trash It!
0b = Select Your Fighter
0c = Virtual Audio Q Screen
0d = In-Between Stage Story/Credits
0e = Tutorial
10 = Capcom Logo
11 = Intro Movie
12 = Attract Mode
```

Suggested: 
``` 	
[8-bit] Screen ID

0x00 = Bootup
0x02 = Score Ranking
0x04 = Title Screen
0x05 = Demo/Frame Before 06
0x06 = In-Game?
0x08 = Recycle It, Don't Trash It!
0x0B = Select Your Fighter
0x0C = Virtual Audio Q Screen
0x0D = In-Between Stage Story/Credits
0x0E = Tutorial
0x10 = Capcom Logo
0x11 = Intro Movie
0x12 = Attract Mode
```
In this case it's more clear you've documented them as hexadecimal and not just decimal values.
Make this change accross all your code notes please, especially if you're documenting values 9, A-F
You could also consider `0b` prefix for binary notations.


### 👉 Implementation
### Achievement [It’s Time to Take Down That Medallion](https://retroachievements.org/achievement/520713) Undocumented Value
Core:Line[9] 
```
ResetIf Mem 8-bit 0x00727e = Value 0x000007 (0)
```
0x7 isn't a documented value within code note `$0x727e`

### ✅ Rich Presence
Looks great

### ✅ Testing
If you're still unsure about some things, you can always consider [#playtest-requests on RAdiscord](https://discord.com/channels/310192285306454017/1169258130555797524)

# ------Closing Notes------

Please do your best to address all of the 👉 feedback above. Once you've gone through everything and made the necessary changes, ping `code-reviewer` again, So we can re-evaluate and then officially add you to the review backlog.

# %%%%%%%%%%%%% POST-READY FOR REVIEW %%%%%%%%%%%%% # // TODO, once added to the backlog

You've been added to the backlog. Now please be patient until the CR-team gets through the list. You'll be our next Code Review in no time. 
In the meantime, here are a few suggestions to make the most of the wait:
- *(Recommended)* Keep testing and polishing your set. The less problems there are discovered during the Code Review, the faster you'll be out of the junior program and earn full dev status. I highly advise to read any Code Reviews that come up, to see what other juniors often struggle with or have done well.
- *(Recommended)* See where you can incorporate Measured or Trigger flags for better player feedback.
- *(Recommended)* Add or improve leaderboards, if applicable. Implementing leaderboards is another great learning experience.
- *(Optional)* Revisit any achievements you struggled to implement, fresh ideas may help. 
- *(Optional)* Add support for an alternate hash if the game has other versions.
- *(Optional)* Consider writing an [RAguide](https://github.com/RetroAchievements/guides/wiki) to help players understand the set.
- *(Optional)* Get involved with other parts of the RAcommunity, whether that’s helping other Junior Devs, contributing to the Art Team, Writing Team, Playtesters, RANews or even helping with coding.

Your extra efforts will not only help your own set stand out, they’ll also be a great way to grow as a developer in the community.
