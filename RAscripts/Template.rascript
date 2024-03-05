//   █▀▀ ▄▀█ █▀▄▀█ █▀▀    ▀█▀ █ ▀█▀ █░░ █▀▀
//   █▄█ █▀█ █░▀░█ ██▄    ░█░ █ ░█░ █▄▄ ██▄
//
// ***********************************************************************
// #ID = [game ID here]
// md5: [hash here] - [region here]


// Info regarding usage of this RAScript
// ---------------------------------------------
//	- For the best reading experience => set indent mode to 'Tabs'; with an indent size '4'
//	- For colored text/code (in Visual Studio Code) => select a language mode (bottom right of vscode window) other than 'plain text', like Go or C#

//	- Usage of Todo Tree tags => install 'Todo Tree extension' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
//	- Use RATools to update achievement logic written here to RALibrertro
//	- Use RALibretro/RATools to publish/push the achievement logic to RetroAchievements servers
//	- Documentation for RALibretro => https://docs.retroachievements.org/Developer-Docs/
//	- Documentation for RATools => https://github.com/Jamiras/RATools/wiki


//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

function isDebugModeActive() => true				// if active => extra information may be displayed on achievement titles & descriptions

achievementLanguage = "en"							// ISO 639-1 language codes 

achievementGuideLink = [link to achievement guide readme] 




//   ███╗   ███╗███████╗███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ ██╗ ██████╗
//   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝
//   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║██████╔╝ ╚████╔╝     ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗    ██║     ██║   ██║██║  ███╗██║██║     
//   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║██╔══██╗  ╚██╔╝      ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║   ██║██║██║     
//   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝██║  ██║   ██║       ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╔╝██║╚██████╗
//   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝
//
// *****************************************************************************************************************************************************************


// ÷ SUB HEADER 1 ÷
// ***************************
// 	- Some explanation...		//	$AC0130: [8-bit] Example memory address code note
// 	- Some explanation...		//		- Code note...
								//		- Code note...



// ÷ SUB HEADER 2 ÷
// ***************************
// 	- Some explanation...
// 	- Some explanation...





//    █████╗  ██████╗██╗  ██╗██╗███████╗██╗   ██╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗       ██╗      ██████╗  ██████╗ ██╗ ██████╗
//   ██╔══██╗██╔════╝██║  ██║██║██╔════╝██║   ██║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝       ██║     ██╔═══██╗██╔════╝ ██║██╔════╝
//   ███████║██║     ███████║██║█████╗  ██║   ██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║          ██║     ██║   ██║██║  ███╗██║██║     
//   ██╔══██║██║     ██╔══██║██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║          ██║     ██║   ██║██║   ██║██║██║     
//   ██║  ██║╚██████╗██║  ██║██║███████╗ ╚████╔╝ ███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║          ███████╗╚██████╔╝╚██████╔╝██║╚██████╗ 
//   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝          ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝ 
//
// *****************************************************************************************************************************************************************




// ÷ ACHIEVEMENT DICTIONARY ÷
// *************************************
// - Divided by category => when in debug mode, category tags are added to achievement titles

_achievements = {
	// "a_Template": { // CONCEPT_template
	//	"id": 000000, "points": 0000000, "hasTips": false,
	//	"devInfo": "xxxxxxx"},
    "c_ExampleCategeroy1": {
        "a_AchievementA": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"},
        "a_AchievementB": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"},
        "a_AchievementC": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"}
    },
    "c_ExampleCategeroy2": {
        "a_AchievementD": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"}
    }?
    "c_ExampleCategeroy3": {
        "a_AchievementE": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"},
        "a_AchievementF": { 
            "id": 000000, "points": 0000000, "hasTips": false,
            "devInfo": "xxxxxxx"}?
    }?
}



// ÷ ACHIEVEMENT TRIGGER GENERATORS ÷
// ***************************************************
//	- For achievement logic that's reoccuring across multiple triggers


// ÷ ACHIEVEMENT TRIGGERS ÷
// ***************************************************************

_achievementTriggers = : {
    // "a_Template": function Template() { return always_false()},
    "a_AchievementF": function AchievementF() { return always_false()},
	"a_AchievementE": function AchievementE() { return always_false()},
	"a_AchievementD": function AchievementD() { return always_false()},
	"a_AchievementC": function AchievementC() { return always_false()},
	"a_AchievementB": function AchievementB() { return always_false()},
	"a_AchievementA": function AchievementA() { return always_false()},
}




// ÷ ACHIEVEMENT TEXT ÷
// **************************

_achievementTitles = {
    // "a_Template":						{"en": "xxxxx"}, 
    "a_AchievementF":						{"en": "EnglishTitle"},
    "a_AchievementE":						{"en": "EnglishTitle"},
    "a_AchievementD":						{"en": "EnglishTitle"},
    "a_AchievementC":						{"en": "EnglishTitle"},
    "a_AchievementB":						{"en": "EnglishTitle",
											"fr": "FrenchTitle",
											"nl": "DutchTitle"},
    "a_AchievementA":						{"en": "EnglishTitle",
											"fr": "FrenchTitle",
											"nl": "DutchTitle"},
}

_achievementDescriptions = {
    // "a_Template": 						{"en": "xxxxx"}, 
    "a_AchievementF":						{"en": "EnglishDescription"},
    "a_AchievementE":						{"en": "EnglishDescription"},
    "a_AchievementD":						{"en": "EnglishDescription"},
    "a_AchievementC":						{"en": "EnglishDescription"},
    "a_AchievementB":						{"en": "EnglishDescription",
											"fr": "FrenchDescription",
											"nl": "DutchDescription"},
    "a_AchievementA":						{"en": "EnglishDescription",
											"fr": "FrenchDescription",
											"nl": "DutchDescription"},
}



// ÷ ACHIEVEMENT INITIALIZER ÷
// **********************************************************
//	- Creates achievement objects (accepted by RAscript) based on the achievement dictionary

function initializeAchievements() {
	// Generates the achievement title (with developer tags, if devmode == 1)
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function enterCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if isDebugModeActive() {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
				// let_string + "[" + let_shortenedAchievementCategory + "_" + let_shortenedAchievementDevName + "] " 
			}
			return let_string
		}	
		function lookUpAchievementTitle(string_achievementDevName, string_languageCode) {
			return _achievementTitles[string_achievementDevName][string_languageCode]
		}
		return enterCategoryName(string_achievementCategory, string_achievementDevName) + lookUpAchievementTitle(string_achievementDevName, string_languageCode)
	}
	// Generates the achievement description (with extra developer information, if devmode == 1)
	function generateAchievementDescription(string_achievementDevName, boolean_hasTips, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementDevName, string_languageCode) {
			return _achievementDescriptions[string_achievementDevName][string_languageCode]
		}
		function enterDevInfo(string_devInfo) {
			let_devInfoString = ""
			if isDebugModeActive() && string_devInfo != "" {
				let_devInfoString = let_devInfoString + " - [DEV: " + string_devInfo + "]"
			}
			return let_devInfoString
		}	
		function enterTipsLink(boolean_hasTips) {
			let_tipsLink = ""
			if(boolean_hasTips == true) let_tipsLink = " - [Tips: " + achievementGuideLink + "]"
			return let_tipsLink 
		}
		return lookUpAchievementDescription(string_achievementDevName, string_languageCode) + enterTipsLink(boolean_hasTips) + enterDevInfo(string_devInfo) 
	}
	// Returns the achievement trigger 
	function lookUpAchievementTrigger(string_achievementDevName) {
		return _achievementTriggers[string_achievementDevName]
	}

	// This loop generates the achievements
	for categoryName in _achievements {
		for cheevmentName in _achievements[categoryName] {
			let_cheevment = _achievements[categoryName][cheevmentName]
			achievement(
				id = let_cheevment["id"],
				title = generateAchievementTitle(cheevmentName, categoryName, achievementLanguage), 
				description = generateAchievementDescription(cheevmentName, let_cheevment["hasTips"], let_cheevment["devInfo"], achievementLanguage),
				points = let_cheevment["points"],
				trigger = lookUpAchievementTrigger(cheevmentName)
			)
		}
	}}



//   ██████╗ ██╗ ██████╗██╗  ██╗    ██████╗ ██████╗ ███████╗███████╗███████╗███╗   ██╗ ██████╗███████╗
//   ██╔══██╗██║██╔════╝██║  ██║    ██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝
//   ██████╔╝██║██║     ███████║    ██████╔╝██████╔╝█████╗  ███████╗█████╗  ██╔██╗ ██║██║     █████╗  
//   ██╔══██╗██║██║     ██╔══██║    ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║██╔══╝  ██║╚██╗██║██║     ██╔══╝  
//   ██║  ██║██║╚██████╗██║  ██║    ██║     ██║  ██║███████╗███████║███████╗██║ ╚████║╚██████╗███████╗
//   ╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
//
// ************************************************************************************************************************



                                                               
 //   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀
 //   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄
 //
 // ***********************************************************************

function initializeRAscript() {
	initializeAchievements()}
initializeRAscript()