// ****************************************** \\
//   █▀▀ ▄▀█ █▀▄▀█ █▀▀    ▀█▀ █ ▀█▀ █░░ █▀▀   \\
//   █▄█ █▀█ █░▀░█ ██▄    ░█░ █ ░█░ █▄▄ ██▄   \\
// ****************************************** \\
// #ID = [game_ID_here]	// TODO Set header info - Two Line Text Generator: https://www.fancytextpro.com/BigTextGenerator
// md5: [hash_here] - [region_here]
// Platform: [platform_here]
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: [link_to_game_page]

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
utility_const_debugMode = true	// if true => extra information will be displayed on achievement titles & descriptions
utility_const_language = "en"	// ISO 639-1 language codes 

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

// ****************
// ◦ SUB HEADER 1 ◦
// ****************
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

// ****************
// ◦ SUB HEADER 2 ◦
// ****************
// 	- Some explanation...
// 	- Some explanation...
enum_TEMPLATE_WEAPON_A = 100
enum_TEMPLATE_WEAPON_B = 101
enum_TEMPLATE_WEAPON_C = 102
const_template_weapons_data = {
	enum_TEMPLATE_WEAPON_A: {
		"equip_ID": 0x21,
		"memAddr_CurrentWeaponAffinity": 0xAB1C,
		"maxWeaponAffinity": 99},
	enum_TEMPLATE_WEAPON_B: {
		"equip_ID": 0x22,
		"memAddr_CurrentWeaponAffinity": 0xAB1D,
		"maxWeaponAffinity": 99},
	enum_TEMPLATE_WEAPON_C: {
		"equip_ID": 0x23,
		"memAddr_CurrentWeaponAffinity": 0xAB1E,
		"maxWeaponAffinity": 99}
	}
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

// **************************
// • Achievements CORE DATA •
// **************************
// - Divided by category => when in debug mode, category tags are added to achievement titles
achievements_coreData = {
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
achievements_typeByCategory = {
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
// • Achievements TRIGGER GENERATORS •
// ***********************************
//	- For achievement logic that's reoccuring across multiple triggers
function achievements_generate_Tally_TemplateA() {
	return always_false()}
function achievements_generate_Tally_TemplateB() {
	return always_false()}

// *************************
// • Achievements TRIGGERS •
// *************************
achievements_triggers = {
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

// ********************
// • Achievement TEXT •
// ********************
achievements_titles = {
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
achievements_descriptions = {
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
// • Achievements INITIALIZER •
// ****************************
//	- Creates achievement objects (accepted by RATools) based on the achievement dictionary (achievements_coreData)
function achievements_initialize() {

	function achievements_generateTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function achievements_createCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (utility_const_debugMode) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}]", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
			}
			return let_string}
		function achievements_getTitle(string_achievementDevName, string_languageCode) => 
			achievements_titles[string_achievementDevName][string_languageCode]
		return format("{0} {1}", 
			achievements_createCategoryName(string_achievementCategory, string_achievementDevName),
			achievements_getTitle(string_achievementDevName, string_languageCode))}
	
	function achievements_generateDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function achievements_getDescription(string_achievementDevName, string_languageCode) {
			return achievements_descriptions[string_achievementDevName][string_languageCode]}
		function achievements_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (utility_const_debugMode && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}
		return format("{0}{1}",
			achievements_getDescription(string_achievementDevName, string_languageCode),
			achievements_formatDevInfo(string_devInfo))}

	function achievements_getTrigger(string_achievementDevName) => 
		achievements_triggers[string_achievementDevName]

	// This loop generates the achievements
	for categoryName in achievements_coreData {
		for cheevmentName in achievements_coreData[categoryName] {
			let_achievementData = achievements_coreData[categoryName][cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = achievements_generateTitle(cheevmentName, categoryName, utility_const_language),
				type = achievements_typeByCategory[categoryName],
				description = achievements_generateDescription(cheevmentName, let_achievementData["devInfo"], utility_const_language),
				points = let_achievementData["points"],
				trigger = achievements_getTrigger(cheevmentName)
			)
		}}
	}


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

// **************************
// • RichPresence FUNCTIONS •
// **************************
//	- Functions handling memory address logic that should only be used by the rich presence script

// **************************
// • RichPresence CORE DATA •
// **************************
//	- Contains logic data for the rich presence script
function richPresence_callDisplayFunctions(){
	rich_presence_conditional_display(	// rp_templateA
		richPresence_getCondition("rp_templateA"),
		richPresence_getText("rp_templateA"),
		richPresence_callParameterFunction("rpp_ValueTemplate"),
		richPresence_callParameterFunction("rpp_LookupTemplate"),
		richPresence_callParameterFunction("rpp_MacroTemplate"))
		
	rich_presence_conditional_display(	// rp_templateB
		richPresence_getCondition("rp_templateB"),
		richPresence_getText("rp_templateB"))

	rich_presence_display(	// rp_Default
		richPresence_getText("rp_Default"))}
richPresence_enum_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_enum_LOOKUP = 2	// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_enum_MACRO = 3		// rich_presence_macro(macro, expression)
// -------------------------------------
richPresence_conditions = {
	"rp_templateA": () =>
		always_false(),
	"rp_templateB": () =>
		always_false(),
	}
function richPresence_getCondition(string_displayKey) =>
	richPresence_conditions[string_displayKey]
// -------------------------------------
richPresence_parameterData = {
	// DEV_NOTE: rich presence
	// 		- Expression examples:
	//			-- Memory Accessor => byte(0x000)
	//			-- Arithmetic Expression => getCurrentLevel() + 1
	// 		- Available macro formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_macromacro-expression
	// 		- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// ------------------------------------------------------

	"rpp_ValueTemplate": {	
		"RPtype": richPresence_enum_VALUE,
		"Expression": always_false(),
		"ValueFormat": "VALUE"},
	"rpp_LookupTemplate": {	
		"RPtype": richPresence_enum_LOOKUP,
		"Expression": always_false(),
		"LookupFallback": richPresence_getLookupTableText("rpp_LookupTemplate", "LookupFallback")},
	"rpp_MacroTemplate": {
		"RPtype": richPresence_enum_MACRO,
		"Expression": always_false(),
		"MacroFormat": "Number"},
	}	
// *********************
// • RichPresence TEXT •
// *********************
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	

	"rp_templateB":										{"en": "xxxxxxxx"},
	"rp_templateA":										{"en": "{0} {1} {2}"},

	"rp_Default":										{"en": "Playing the game"}}	// TODO rp_Default
richPresence_LookupTablesText = {
	"rpp_LookupTemplate_Lookup_A":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_Lookup_B":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_Lookup_C":						{"en": "xxxxxxxx"},
	"rpp_LookupTemplate_LookupFallback":				{"en": "xxxxxxxx"},}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][utility_const_language]
function richPresence_getLookupTableText(string_parameterKey, string_lookupValue) {
	let_lookupTableTextKey = format("{0}_{1}", string_parameterKey, string_lookupValue)
	return richPresence_LookupTablesText[let_lookupTableTextKey][utility_const_language]}
// -------------------------------------
richPresence_lookupTables = {
	"rpp_LookupTemplate": {	// Refer to const_chapterIDs
		0x1: "Lookup_A",
		0x2: "Lookup_B",
		0x3: "Lookup_C"}}
function richPresence_getLookupTable(string_lookupParameterKey) =>
	richPresence_lookupTables[string_lookupParameterKey]
// *****************************
// • Rich_Presence INITIALIZER •
// *****************************
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_parameterKey in richPresence_lookupTables {
		let_lookupTable = richPresence_lookupTables[let_parameterKey]
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_parameterKey][let_lookupKey]
			richPresence_lookupTables[let_parameterKey][let_lookupKey] = richPresence_getLookupTableText(let_parameterKey, let_lookupValue)
		}
	}}
function richPresence_createParameterName(string_parameterKey) => substring(string_parameterKey, 4)	// Removes rpp_ 
function richPresence_callParameterFunction(string_parameterKey) {	// Checks which rich_presence function to execute/call and gives it the correct parameters with the data stored in richPresence_parameterData
	function richPresence_callValueFunction(string_parameterKey, dict_paramValueData) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramValueData["Expression"]
		let_format = dict_paramValueData["ValueFormat"] 
		return rich_presence_value(let_name, let_expression, let_format)}
	
	function richPresence_callLookupFunction(string_parameterKey, dict_paramLookupData) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramLookupData["Expression"]
		let_lookUpTable = richPresence_getLookupTable(string_parameterKey)
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_enum_VALUE) richPresence_callValueFunction(string_parameterKey, let_parameterData)
	else if (let_RPtype == richPresence_enum_LOOKUP) richPresence_callLookupFunction(string_parameterKey, let_parameterData)
	else if (let_RPtype == richPresence_enum_MACRO) richPresence_callMacroFunction(let_parameterData)
	else throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))
	}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_callDisplayFunctions()}

// ***************************************************************************************************** \\
//																										 \\
//   ██╗     ███████╗ █████╗ ██████╗ ███████╗██████╗ ██████╗  ██████╗  █████╗ ██████╗ ██████╗ ███████╗   \\
//   ██║     ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝   \\
//   ██║     █████╗  ███████║██║  ██║█████╗  ██████╔╝██████╔╝██║   ██║███████║██████╔╝██║  ██║███████╗   \\
//   ██║     ██╔══╝  ██╔══██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║╚════██║   \\
//   ███████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝███████║   \\
//   ╚══════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝   \\                                                                                                 
//																										 \\
// ***************************************************************************************************** \\

// **************************
// • Leaderboards FUNCTIONS •
// **************************
//	- Functions that should only be used by the leaderboards logic
function getTimerTotalClearTimeInMinutes() =>
	getTimerTotalClearTime() / 3600

function getTimerChapterClearTimeInSeconds() =>
	getTimerChapterClearTime() / 60
// **************************
// • Leaderboards CORE DATA •
// **************************
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- Be wary of timers or values that reset to 0x0 when the bytes overflow => refer to score wrapping to fix https://docs.retroachievements.org/Leaderboards/#score-wrapping
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leadersboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardValue": always_false(),
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "xxxxxxx"},
	}

// ***********************************
// • Leaderboards TRIGGER GENERATORS •
// ***********************************
//	- For leaderboard logic that's reoccuring across multiple triggers
function leaderboards_generate_ClearTimeChapter_StartTrigger(string_chapter) {
	let_chapterSpecificComparison = always_true()
	if (string_chapter == "Prologue") 
		let_chapterSpecificComparison = !isPrologueInExMode()
	return 
		never(!isInGame()) &&
		once(isTimerChapterClearTimeStarting()) &&
		repeated(700, isInGame()) &&	// <-- Repeated here, FIXfor bug when loading a save, would otherwise start and cancel immediately after
		isCurrentChapter(string_chapter) &&
		let_chapterSpecificComparison}
function leaderboards_generate_ClearTimeChapter_CancelTrigger(string_chapter) {
	let_chapterSpecificComparison = always_false()
	if (string_chapter == "Prologue")
		let_chapterSpecificComparison = isPrologueInExMode()
	return 	
		!isInGame() || 
		let_chapterSpecificComparison || 
		isTimerChapterClearTimeResetting() 	||
		!isCurrentChapter(string_chapter)}
function leaderboards_generate_ClearTimeChapter_SubmitTrigger(string_chapter) =>
	never( // Reset count if...
		!isChapterCompletionScreenActive() || 
		!isCurrentChapter(string_chapter)
	) &&
	tally(10, // Check if chapter completion screen is active for 10 frames
		isChapterCompletionScreenActive() &&
		isCurrentChapter(string_chapter))

// *************************
// • Leaderboards TRIGGERS •
// *************************
leaderboards_startTriggers = {
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter8"),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter7"),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter6"),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter5"),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter4"),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter3"),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter2"),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Chapter1"),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_StartTrigger("Prologue"),
	"lb_TotalClearTime": () =>
		repeated(300, isInGame()) && 
		once(isTimerTotalClearTimeStartingFromZero()) && 
		!isPrologueInExMode()}
leaderboards_cancelTriggers = {
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter8"),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter7"),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter6"),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter5"),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter4"),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter3"),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter2"),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Chapter1"),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_CancelTrigger("Prologue"),
	"lb_TotalClearTime": () =>
		!isInGame() || isPrologueInExMode() || isTimerTotalClearTimeResetting()}
leaderboards_submitTriggers = { 
	"lb_ClearTimeChapter8": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter8"),
	"lb_ClearTimeChapter7": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter7"),
	"lb_ClearTimeChapter6": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter6"),
	"lb_ClearTimeChapter5": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter5"),
	"lb_ClearTimeChapter4": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter4"),
	"lb_ClearTimeChapter3": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter3"),
	"lb_ClearTimeChapter2": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter2"),
	"lb_ClearTimeChapter1": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Chapter1"),
	"lb_ClearTimePrologue": () =>
		leaderboards_generate_ClearTimeChapter_SubmitTrigger("Prologue"),
	"lb_TotalClearTime": () =>
		tally(10, // Trigger when timer has stopped for 10 frames during the credits video
			never(!isTimerTotalClearTimeActive()) &&
			isVideoActive() && isCurrentChapter("Epilogue") &&
			isTimerTotalClearTimeActive())}

// *********************
// • Leaderboards TEXT •
// *********************
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_ClearTimeChapter8":					{"en": "Chapter 8 Clear Time"},
	"lb_ClearTimeChapter7":					{"en": "Chapter 7 Clear Time"},
	"lb_ClearTimeChapter6":					{"en": "Chapter 6 Clear Time"},
	"lb_ClearTimeChapter5":					{"en": "Chapter 5 Clear Time"},
	"lb_ClearTimeChapter4":					{"en": "Chapter 4 Clear Time"},
	"lb_ClearTimeChapter3":					{"en": "Chapter 3 Clear Time"},
	"lb_ClearTimeChapter2":					{"en": "Chapter 2 Clear Time"},
	"lb_ClearTimeChapter1":					{"en": "Chapter 1 Clear Time"},
	"lb_ClearTimePrologue":					{"en": "Prologue Clear Time"},
	"lb_TotalClearTime":					{"en": "Total Clear Time"}}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_ClearTimeChapter8":					{"en": "Race through time to achieve the fastest clear time for the chapter 8"},
	"lb_ClearTimeChapter7":					{"en": "Race through time to achieve the fastest clear time for the chapter 7"},
	"lb_ClearTimeChapter6":					{"en": "Race through time to achieve the fastest clear time for the chapter 6"},
	"lb_ClearTimeChapter5":					{"en": "Race through time to achieve the fastest clear time for the chapter 5"},
	"lb_ClearTimeChapter4":					{"en": "Race through time to achieve the fastest clear time for the chapter 4"},
	"lb_ClearTimeChapter3":					{"en": "Race through time to achieve the fastest clear time for the chapter 3"},
	"lb_ClearTimeChapter2":					{"en": "Race through time to achieve the fastest clear time for the chapter 2"},
	"lb_ClearTimeChapter1":					{"en": "Race through time to achieve the fastest clear time for the chapter 1"},
	"lb_ClearTimePrologue":					{"en": "Race through time to achieve the fastest clear time for the prologue (EX chapter is exluded)"},
	"lb_TotalClearTime": 					{"en": "Race through time to achieve the fastest total clear time (EX chapter is excluded)"}}

// ****************************
// • Leaderboards INITIALIZER •
// ****************************
function leaderboards_initialize() {
	function leaderboards_generateTitle(string_leaderboardDevName, string_languageCode) {
		function leaderboards_createDevName(string_leaderboardDevName) => 	// Removes lb_ and puts it between []
			format("[{0}]", substring(string_leaderboardDevName, 3))
		function leaderboards_getTitle(string_leaderboardDevName, string_languageCode) => 
			leaderboards_titles[string_leaderboardDevName][string_languageCode]
		return format("{0} {1}", 
			leaderboards_createDevName(string_leaderboardDevName),
			leaderboards_getTitle(string_leaderboardDevName, string_languageCode))}
	
	function leaderboards_generateDescription(string_leaderboardDevName, string_devInfo, string_languageCode) {	
		function leaderboards_getDescription(string_leaderboardDevName, string_languageCode) {
			return leaderboards_descriptions[string_leaderboardDevName][string_languageCode]}
		function leaderboards_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (utility_const_debugMode && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}
		return format("{0}{1}",
			leaderboards_getDescription(string_leaderboardDevName, string_languageCode),
			leaderboards_formatDevInfo(string_devInfo))}

	for let_leaderboardKey in leaderboards_coreData {
		let_leaderboardData = leaderboards_coreData[let_leaderboardKey]
		leaderboard(
			id = let_leaderboardData["id"],
			title = leaderboards_generateTitle(let_leaderboardKey, utility_const_language), 
			description = leaderboards_generateDescription(let_leaderboardKey, let_leaderboardData["devInfo"], utility_const_language),
			start = leaderboards_startTriggers[let_leaderboardKey], 
			cancel = leaderboards_cancelTriggers[let_leaderboardKey], 
			submit = leaderboards_submitTriggers[let_leaderboardKey], 
			value = let_leaderboardData["leaderboardValue"], 
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}


// ********************************************************************** \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ********************************************************************** \\
function initializeRAscript() {
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()