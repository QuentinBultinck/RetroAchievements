// ****************************************** \\
//   █▀▀ ▄▀█ █▀▄▀█ █▀▀    ▀█▀ █ ▀█▀ █░░ █▀▀   \\
//   █▄█ █▀█ █░▀░█ ██▄    ░█░ █ ░█░ █▄▄ ██▄   \\
// ****************************************** \\
// #ID = [game_ID_here]	// TODO Set header info - Two Line Text Generator: https://www.fancytextpro.com/BigTextGenerator
// md5: [hash_here] - [region_here]
// Platform: [platform_here]
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //     DEVELOPER NOTES      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

// Info regarding usage/reading this RAScript
// ---------------------------------------------
//	- Set indent mode => Tabs			
//	- Set indent size => 4

//	- Use RATools to update achievement logic written here to RALibrertro
//	- Use RALibretro/RATools to publish/push the achievement logic to RetroAchievements servers
//	- Documentation for achievement development => https://docs.retroachievements.org/Developer-Docs/
//		-- Rich Presence documentation => https://docs.retroachievements.org/Rich-Presence/ AND https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions
//			--- Rich Presence Macro's => https://docs.retroachievements.org/Rich-Presence/#macros
//			--- To Test RP via RATools, same as updating achievement logic, but afteran  RP update => restart RALibretro OR keep the following file op in an editor: ..\RALibretro\RACache\Data\XXX-Rich.txt 
//	- Documentation for RALibretro => https://docs.retroachievements.org/Developer-Docs/
//	- Documentation for RATools => https://github.com/Jamiras/RATools/wiki

//	Visual Studio Code: specific info
// ---------------------------------------------
//	- Enable: Colored code => select language mode (bottom right of vscode window) => Go (not "plain text")
//	- Enable: Todo Tree tags => install extension: 'Todo Tree' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
// 	- Markdown editing
//		-- Enable: Markdown Enhanced Preview => Install extension: 'Markdown Preview Enhanced' by 'Yiyi Wang'


//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

// TODO Turn off debug mode
const_utility_debugMode = true	// if true => extra information will be displayed on achievement titles & descriptions
const_utility_language = "en"	// ISO 639-1 language codes 

function throwError(string_errMsg) {	// This function will throw an error in RATools because the key doesn't exist
	let_dict = {}
	return let_dict[format("ERROR: {0}", string_errMsg)]}

function addToDictionary(dict, key, value) {
	dict[key] = value}

// ***************************************************************************************************************************************************************** \\
//																																									 \\
//   ███╗   ███╗███████╗███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║██████╔╝ ╚████╔╝     ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗    ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║██╔══██╗  ╚██╔╝      ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝██║  ██║   ██║       ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																									 \\
// ***************************************************************************************************************************************************************** \\

// *****************
// ÷ SUB HEADER 1 ÷
// *****************
// 	- Some explanation...		
// 	- Some explanation...		
enum_TEMPLATE_AREA_A = 0x1
enum_TEMPLATE_AREA_B = 0x2
enum_TEMPLATE_AREA_C = 0x3
enum_TEMPLATE_AREA_D = 0x4
enum_TEMPLATE_AREA_E = 0x5
function current_AreaID() => 	//	$AC0130: [8-bit] Example memory address code note
	byte(AC0130)				//		- Code note...
								//		- Code note...
function prev_AreaID() =>
	prev(current_AreaID())
function prior_AreaID() =>
	prior(current_AreaID())
function is_CurrentArea(enum_TEMPLATE_AREA) =>	// Example usage => is_CurrentArea(enum_TEMPLATE_AREA_A)
	current_AreaID() == enum_TEMPLATE_AREA
function on_AreaFinish(enum_TEMPLATE_AREA) =>	// on_templateFunction() => "on" signifies that this function returns a comparison that's checking delta values
	current_AreaID() != enum_TEMPLATE_AREA && 
	prev_AreaID() == enum_TEMPLATE_AREA
// -------------------------------------
// 	- Some explanation...
// 	- Some explanation...
// 	- Some explanation...

// *****************
// ÷ SUB HEADER 2 ÷
// *****************
// 	- Some explanation...
// 	- Some explanation...
enum_TEMPLATE_WEAPON_A = 100
enum_TEMPLATE_WEAPON_B = 101
enum_TEMPLATE_WEAPON_C = 102
const_template_weapons_data = {
	enum_TEMPLATE_WEAPON_A: {
		"equip_ID": 0x21,
		"memAddr_CurrentWeaponAffinity": 0xAB1C,
		"maxWeaponAffinity": 99
	},
	enum_TEMPLATE_WEAPON_B: {
		"equip_ID": 0x22,
		"memAddr_CurrentWeaponAffinity": 0xAB1D,
		"maxWeaponAffinity": 99
	},
	enum_TEMPLATE_WEAPON_C: {
		"equip_ID": 0x23,
		"memAddr_CurrentWeaponAffinity": 0xAB1E,
		"maxWeaponAffinity": 99
	}}
function is_EquippedWeapon(enum_TEMPLATE_WEAPON) =>
	byte(0xAC12) == const_template_weapons_data[enum_TEMPLATE_WEAPON]["equip_ID"]
function on_WeaponAffinityMaxed(enum_TEMPLATE_WEAPON) { return
	always_false()}
// -------------------------------------
function doThisA() => always_false()
function doThisB() => always_false()
function doThisC() => always_false()

// ****************************************************************************************************************************************** \\
//																																			  \\
//    █████╗  ██████╗██╗  ██╗██╗███████╗██╗   ██╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗       ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ██╔══██╗██╔════╝██║  ██║██║██╔════╝██║   ██║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝       ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ███████║██║     ███████║██║█████╗  ██║   ██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║          ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██╔══██║██║     ██╔══██║██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║          ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║  ██║╚██████╗██║  ██║██║███████╗ ╚████╔╝ ███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║          ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝          ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																			  \\
// ****************************************************************************************************************************************** \\

// ***************************
// ÷ Achievement DICTIONARY ÷
// ***************************
// - Divided by category => when in debug mode, category tags are added to achievement titles
const_achievements_coreData = {
	// DEV NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Easily upload badges via the game page on the RA website
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
	//	"id": 000000, "points": 0000000,
	//	"devInfo": "xxxxxxx"},

    "c_ExampleCategeroy1": {	// Category - [info about category]
        "a_AchievementA": { // WORKING
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"},
        "a_AchievementB": { // BUG - something is wrong
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"},
        "a_AchievementC": { // WORKING
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"}
    },
    "c_ExampleCategeroy2": {	// Category - [info about category]
        "a_AchievementD": { // WORKING
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"}
    },
    "c_ExampleCategeroy3": {	// Category - [info about category]
        "a_AchievementE": { // WORKING
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"},
        "a_AchievementF": { // WORKING
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"}
    }}
// -------------------------------------
const_achievement_typeByCategory = {
	//	DEV NOTE: Achievement type property
	//		- Possible type keys: "missable" - "progression" - "win_condition"
	//		- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	//		- 14 march 2024: this doesn't work via RATools (wont set type on RA back-end) => update type per achievement this on the game page on RA website
	// ------------------------------------------------------
	
	// "c_template": 			"xxxxxx",
	"c_ExampleCategeroy1": 				"missable",
	"c_ExampleCategeroy2": 				"missable",
	"c_ExampleCategeroy3":				"missable"}

// ***********************************
// ÷ Achievement TRIGGER GENERATORS ÷
// ***********************************
//	- For achievement logic that's reoccuring across multiple triggers
function generate_Tally_TemplateA() {
	return always_false()}
function generate_Tally_TemplateB() {
	return always_false()}

// *************************
// ÷ Achievement TRIGGERS ÷
// *************************
const_achievement_triggers = {
    // "a_Template": () { return // WIP_template
	//	always_false()},
    "a_AchievementF": () { return 
		always_false()},
	"a_AchievementE": () { return 
		always_false()},
	"a_AchievementD": () { return 
		always_false()},
	"a_AchievementC": () { return 
		always_false()},
	"a_AchievementB": () { return 
		always_false()},
	"a_AchievementA": () { return 
		always_false()}}

// **********************
// ÷ Achievement TEXT ÷
// **********************
const_achievement_titles = {
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
											"nl": "DutchTitle"},}
// -------------------------------------
const_achievement_descriptions = {
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
											"nl": "DutchDescription"}}

// ****************************
// ÷ Achievement INITIALIZER ÷
// ****************************
//	- Creates achievement objects (accepted by RATools) based on the achievement dictionary (const_achievements_coreData)
function initializeAchievements() {
	// Generates the achievement title (with developer tags, if devmode == 1)
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function enterCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (const_utility_debugMode) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
				// let_string + "[" + let_shortenedAchievementCategory + "_" + let_shortenedAchievementDevName + "] " 
			}
			return let_string
		}	
		function lookUpAchievementTitle(string_achievementDevName, string_languageCode) {
			return const_achievement_titles[string_achievementDevName][string_languageCode]
		}
		return enterCategoryName(string_achievementCategory, string_achievementDevName) + lookUpAchievementTitle(string_achievementDevName, string_languageCode)
	}
	// Generates the achievement description (with extra developer information, if devmode == 1)
	function generateAchievementDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementDevName, string_languageCode) {
			return const_achievement_descriptions[string_achievementDevName][string_languageCode]
		}
		function enterDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (const_utility_debugMode && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString
		}
		return lookUpAchievementDescription(string_achievementDevName, string_languageCode) + enterDevInfo(string_devInfo) 
	}
	// Returns the achievement trigger 
	function lookUpAchievementTrigger(string_achievementDevName) {
		return const_achievement_triggers[string_achievementDevName]
	}

	// This loop generates the achievements
	for categoryName in const_achievements_coreData {
		for cheevmentName in const_achievements_coreData[categoryName] {
			let_cheevment = const_achievements_coreData[categoryName][cheevmentName]
			achievement(
				id = let_cheevment["id"],
				title = generateAchievementTitle(cheevmentName, categoryName, const_utility_language),
				type = const_achievement_typeByCategory[categoryName],
				description = generateAchievementDescription(cheevmentName, let_cheevment["devInfo"], const_utility_language),
				points = let_cheevment["points"],
				trigger = lookUpAchievementTrigger(cheevmentName)
			)
		}
	}}


// ***************************************************************************************************** \\
//																										 \\
//   ██████╗ ██╗ ██████╗██╗  ██╗    ██████╗ ██████╗ ███████╗███████╗███████╗███╗   ██╗ ██████╗███████╗   \\
//   ██╔══██╗██║██╔════╝██║  ██║    ██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝   \\
//   ██████╔╝██║██║     ███████║    ██████╔╝██████╔╝█████╗  ███████╗█████╗  ██╔██╗ ██║██║     █████╗     \\
//   ██╔══██╗██║██║     ██╔══██║    ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║██╔══╝  ██║╚██╗██║██║     ██╔══╝     \\
//   ██║  ██║██║╚██████╗██║  ██║    ██║     ██║  ██║███████╗███████║███████╗██║ ╚████║╚██████╗███████╗   \\
//   ╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝   \\
//																										 \\
// ***************************************************************************************************** \\
// TODO_Rich_Presence
// ****************************
// ÷ Rich_Presence FUNCTIONS ÷
// ****************************
//	- Functions handling memory address logic that should only be used by the rich presence script

// ***********************
// ÷ Rich_Presence TEXT ÷
// ***********************
//	- Contains text for the rich presence script
const_richPresence_text = {
	// "rp_Template": 							{"en": "xxxxxxxx"},	

	"rpp_LookupTemplate_Lookup_A":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_Lookup_B":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_Lookup_C":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_LookupFallback":				{"en": "xxxxxxxx"},

	"rp_Default":										{"en": ""}}	// TODO_rp_Default
const_richPresence_lookupTables = {
	"rpp_LookupTemplate": {	// Info_about_lookup_table
		0x0: "rpp_LookupTemplate_Lookup_A",
		0x1: "rpp_LookupTemplate_Lookup_B",
		0x2: "rpp_LookupTemplate_Lookup_C"}}
function getRichPresenceText(string_textKey) =>
	const_richPresence_text[string_textKey][const_utility_language]
function getRichPresenceLookupTable(string_lookupParameterKey) =>
	const_richPresence_lookupTables[string_lookupParameterKey]
// ****************************
// ÷ Rich_Presence CORE DATA ÷
// ****************************
//	- Contains logic data for the rich presence script
enum_RPtype_DISPLAY_NORMAL = 10			// rich_presence_display(format_string, parameters...)
enum_RPtype_DISPLAY_CONDITIONAL = 11	// rich_presence_conditional_display(condition, format_string, parameters...)
enum_RPtype_PARAMETER_VALUE = 100		// rich_presence_value(name, expression, [format])
enum_RPtype_PARAMETER_LOOKUP = 101		// rich_presence_lookup(name, expression, dictionary, [fallback])
enum_RPtype_PARAMETER_MACRO = 102		// rich_presence_macro(macro, expression)
// -------------------------------------
const_richPresence_coreData = {
	//	DEV NOTE: rich presence
	// 		- Expression examples => byte(0x000) OR getCurrentLevel() + 1
	// 		- Available macro formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_macromacro-expression
	// 		- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// ------------------------------------------------------

	// "rp_Template": { // CONCEPT rp_template
	// 	"RPtype": enum_RPtype_DISPLAY_CONDITIONAL,
	// 	"Condition": () =>  
	// 		always_false(),
	// 	"PlaceholderParameters": {
	// 		0: "rpp_Param1",
	// 		1: "rpp_Param2",
	// 		2: "rpp_Param3"}},

	"rp_Default": {		// Only 1 DISPLAY_NORMAL is allowed, more will overwrite the previous ones; refer to https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions
		"RPtype": enum_RPtype_DISPLAY_NORMAL,
		"PlaceholderParameters": {}}
	}
const_richPresence_placeholderParameterData = {
	"rpp_ValueTemplate": {
		"RPtype": enum_RPtype_PARAMETER_VALUE,
		"Expression": byte(0x0000),
		"ValueFormat": "VALUE"},
	"rpp_LookupTemplate": {
		"RPtype": enum_RPtype_PARAMETER_LOOKUP,
		"Expression": byte(0x0000),
		"LookupFallback": getRichPresenceText("rpp_LookupTemplate_LookupFallback")},
	"rpp_MacroTemplate": {
		"RPtype": enum_RPtype["MACRO"],
		"Expression": byte(0x0000),
		"MacroFormat": "Number"},
	}
// ******************************
// ÷ Rich_Presence INITIALIZER ÷
// ******************************
function createNameFromPlaceholderParameterkey(string_placeholderParameterKey) => substring(string_placeholderParameterKey, 4)	// Removes rpp_ 
function populateRPlookupTablesWithText() {	// Changes the const_richPresence_lookupTables IDs to the corresponding text in const_richPresence_text
	for let_lookupTable in const_richPresence_lookupTables {
		for let_valueKey in const_richPresence_lookupTables[let_lookupTable] {
			let_lookupID = const_richPresence_lookupTables[let_lookupTable][let_valueKey]
			const_richPresence_lookupTables[let_lookupTable][let_valueKey] = getRichPresenceText(let_lookupID)
		}
	}}
function createCorrespondingRPparameterFunction(string_placeholderParameterKey) {
	function createRPparameterFunction_Value(string_parameterKey, dict_paramValueData) {
		let_name = createNameFromPlaceholderParameterkey(string_parameterKey)
		let_expression = dict_paramValueData["Expression"]
		let_format = dict_paramValueData["Format"] 	
		return rich_presence_value(let_name, let_expression, let_format)}
	
	function createRPparameterFunction_Lookup(string_parameterKey, dict_paramLookupData) {
		let_name = createNameFromPlaceholderParameterkey(string_parameterKey)
		let_expression = dict_paramLookupData["Expression"]
		let_lookUpTable = getRichPresenceLookupTable(string_parameterKey)
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function createRPparameterFunction_Macro(dict_paramMacroData) {
		let_macro = dict_paramMacroData["Macro"] 
		let_expression = dict_paramMacroData["Expression"]
		return rich_presence_macro(let_macro, let_expression)}
	
	let_placeholderParameterData = const_richPresence_placeholderParameterData[string_placeholderParameterKey]
	let_RPtype = let_placeholderParameterData["RPtype"]
	if (let_RPtype == enum_RPtype_PARAMETER_VALUE) {
		createRPparameterFunction_Value(string_placeholderParameterKey, let_placeholderParameterData)
	} else if (let_RPtype == enum_RPtype_PARAMETER_LOOKUP) {
		createRPparameterFunction_Lookup(string_placeholderParameterKey, let_placeholderParameterData)
	} else if (let_RPtype == enum_RPtype_PARAMETER_MACRO) {
		createRPparameterFunction_Macro(let_placeholderParameterData)
	} else {
		throwError(format("The rich presence parameter script: {0} did not evaluate correctly", int_placeholderParameterIndex))
	}}
function createRPparameters(dict_placeholderParameterData){ // Place RPplaceholderParameters in correct order for the format function placeholders
	let_unOrderedRPparameters = {}
	for placeholderParameterIndex in dict_placeholderParameterData {
		let_RPparam = createCorrespondingRPparameterFunction(dict_placeholderParameterData[placeholderParameterIndex])
		let_unOrderedRPparameters[placeholderParameterIndex] = let_RPparam
	}
	let_orderedRPparameters = []
	for let_placeholderIndex in range(0, length(let_unOrderedRPparameters) - 1) { 
		array_push(let_orderedRPparameters, let_unOrderedRPparameters[let_placeholderIndex])
	}
	return let_orderedRPparameters}
function initilalizeRPdisplay(string_displayScriptKey, dict_rpDisplayData) {	// generates rich presence display functions
	function initializeRPdisplay_Normal(string_displayScriptKey, dict_displayNormalData) {
		let_formatString = getRichPresenceText(string_displayScriptKey)		
		if (length(dict_displayNormalData["PlaceholderParameters"]) > 0) {			
			rich_presence_display(let_formatString, createRPparameters(dict_displayNormalData["PlaceholderParameters"]))
		} else {
			rich_presence_display(let_formatString)
		}}
	function initializeRPdisplay_Conditional(string_displayScriptKey, dict_displayConditionalData) {
		let_formatString = getRichPresenceText(string_displayScriptKey)
		let_condition = dict_displayConditionalData["Condition"]
		if (length(dict_displayConditionalData["PlaceholderParameters"]) > 0) {
			rich_presence_conditional_display(let_condition, let_formatString, createRPparameters(dict_displayConditionalData["PlaceholderParameters"]))
		} else {
			rich_presence_conditional_display(let_condition, let_formatString)
		}}
	let_countDisplayNormalScripts = 0
	let_RPtype = dict_rpDisplayData["RPtype"]
	if (let_RPtype == enum_RPtype_DISPLAY_NORMAL) {
		initializeRPdisplay_Normal(string_displayScriptKey, dict_rpDisplayData)
		let_countDisplayNormalScripts = let_countDisplayNormalScripts + 1
		if (let_countDisplayNormalScripts > 1) throwError("More than one DISPLAY_NORMAL script was defined; The last one will overwrite all the previous ones")
	} else if (let_RPtype == enum_RPtype_DISPLAY_CONDITIONAL) {
		initializeRPdisplay_Conditional(string_displayScriptKey, dict_rpDisplayData)
	} else {
		throwError(format("The rich presence display script: {0} did not evaluate correctly", string_displayScriptKey))
	}}
function initializeRichPresence() {
	// DEV NOTE: rich_presence_macro(macro, expression)
	//		- rich_presence_macro() are placed within a display script; like rich_presence_lookup() and rich_presence_value()
	// ------------------------------------------------------	
	// EXAMPLE:
	// 		rich_presence_conditional_display(is_title_screen(), "Title Screen")
	// 		rich_presence_display("Playing Battle {0} in {1} | Score: {2}", 
	// 			rich_presence_value("Battle", getCurrentLevel()),
	// 			rich_presence_lookup("Area", getCurrentArea(), areaDictionary),
	// 			rich_presence_macro("Score", getCurrentScore())
	// 		)
	populateRPlookupTablesWithText()
	for rpDisplayScriptKey in const_richPresence_coreData {
		initilalizeRPdisplay(rpDisplayScriptKey, const_richPresence_coreData[rpDisplayScriptKey])}
	}
// ********************************************************************** \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ********************************************************************** \\
function initializeRAscript() {
	initializeAchievements()
	initializeRichPresence()}
initializeRAscript()