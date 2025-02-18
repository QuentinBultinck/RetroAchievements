// ****************************************** \\
//   █▀▀ ▄▀█ █▀▄▀█ █▀▀    ▀█▀ █ ▀█▀ █░░ █▀▀   \\
//   █▄█ █▀█ █░▀░█ ██▄    ░█░ █ ░█░ █▄▄ ██▄   \\
// ****************************************** \\
// #ID = [game_ID_here]	// TODO Set header info - Two Line Text Generator: https://www.fancytextpro.com/BigTextGenerator
// md5: [hash_here] (region_here)
// RA Hash: [hash_here] (region_here)
// Platform: [platform_here]
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: [link_to_game_page]
// RATools version: [version_here] // TODO set last used RATools version here

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //     DEVELOPER NOTES      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// #region DEVELOPER NOTES

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

// Nomenclature / Naming Convention
// ---------------------------------------------
//	- current_ 	=> returns a memory accessor to the current value
//	- prior_ 	=> returns a memory accessor to the prior value
//	- prev_ 	=> returns a memory accessor to the previous/delta value
//
//	- is_		=> returns a comparison, which only uses current values								-> eg is_Area(id_area) => id_area == byte(0xAA)
//	- wasPrior_	=> returns a comparison, which only uses prior values								-> eg wasPrior_inArea(id_area) => id_area == prior(byte(0xAA))
//	- has_ 		=> returns a comparison, which uses current AND prior values						-> eg has_movedToArea(id_area) => id_area == prior(byte(0xAA)) && id_area-1 == byte(0xAA)
//	- wasPrev_	=> returns a comparison, which only uses previous/delta values						-> eg wasPrev_Area(id_area) => id_area == prev(byte(0xAA))
//	- on_		=> returns a comparison, which checks for a change between delta and current values	-> eg on_Area_change() => current_Area() != prev_Area()

//	Visual Studio Code: specific info
// ---------------------------------------------
//	- Enable: Colored code => select language mode (bottom right of vscode window) => Go (not "plain text")
//	- Enable: Todo Tree tags => install extension: 'Todo Tree' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
// 	- Markdown editing
//		-- Enable: Markdown Enhanced Preview => Install extension: 'Markdown Preview Enhanced' by 'Yiyi Wang'
//  - VScode extension list: Region Viewer Extension - Todo Tree - Markdown Preview Enhanced
// #endregion DEVELOPER NOTES
 
//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //    GENERAL UTILITY   \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// #region GENERAL UTILITY

util_isDebugModeActive = true	// if true => extra information may be displayed on achievement titles & descriptions
util_language = "en"	// ISO 639-1 language codes 

iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
sNULL = "-1"

RELEASE_REGION_USA = "NTSC-U"
RELEASE_REGION_JPN = "NTSC-J"
RELEASE_REGION_EUR = "PAL"
RELEASE_REGIONS_SUPPORTED = [] // TODO add regions

function util_throwError(string_errMsg) { // This function will throw an error in RATools because the key doesn't exist
	let_dict = {}
	return let_dict[format("ERROR: {0}", string_errMsg)]}

function util_addToDictionary(dict, key, value) {
	dict[key] = value}
// #endregion UTILITY

// ***************************************************************************************************************************************************************** \\
//																																				 					 \\
//   ███╗   ███╗███████╗███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ ██╗ ██████╗   \\
//   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝   \\
//   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║██████╔╝ ╚████╔╝     ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗    ██║     ██║   ██║██║  ███╗██║██║        \\
//   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║██╔══██╗  ╚██╔╝      ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║   ██║██║██║        \\
//   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝██║  ██║   ██║       ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╔╝██║╚██████╗   \\
//   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝   \\
//																																									 \\
// ***************************************************************************************************************************************************************** \\
// #region MEMORY

// =============================
// • MEMORY struct definitions •
// =============================
// #region MEM - struct definitions
memory_regionOffsets = {
	}
function memory_getRegionOffset(string_structKey, string_offsetKey) =>
	memory_regionOffsets[string_structKey][string_offsetKey]
// -------------------------------------
memory_StructDefs = {
	}
function memory_getStruct_SizeInBytes(string_structKey) =>
	memory_StructDefs[string_structKey]["sizeInBytes"]

function memory_getStruct_OffsetToMember(string_structKey, string_memberKey) =>
	memory_StructDefs[string_structKey]["offsetToMember"][string_memberKey]

function memory_getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

function memory_getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

function memory_getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
	
function memory_getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
	memory_StructDefs[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

function memGenerate_pointerChainAccessor(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

function memGenerate_pointerChainAccessor_byReleaseRegion(string_structKey, string_pointerChainKey, memAdrr_basePointer, enum_releaseRegion, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
	let_array_pointerChainOffsets = memory_getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion)
	let_addAddressChain = dword(memAdrr_basePointer)
    for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
		if (let_index == length(let_array_pointerChainOffsets) - 1)
			return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
		else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
	}	
	util_throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}



// #endregion MEM - struct definitions

// ==========================
// • MEMORY ADDRESS STORAGE •
// ==========================
// #region MEM - address storage
memory_addresses = {
	//	"memAddrKey": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	}

function memory_getAddress(string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}	
// #endregion MEM - address storage

// ==================
// • MEMORY UTILITY •
// ===================
// #region MEM - utility
function is_ReleaseRegion(enum_releaseRegion) { // TODO implement is_ReleaseRegion()
	if(enum_releaseRegion == RELEASE_REGION_USA) {
		
	} else if(enum_releaseRegion == RELEASE_REGION_JPN) {
		
	} else if(enum_releaseRegion == RELEASE_REGION_EUR) {
		
	} else {
		util_throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	}}

// memUtil_floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
	// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
	// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
function memUtil_floatToInt(float_value, enum_releaseRegion) {
	let_memAccessor_alwaysNull = high4(memory_getAddress(DATATYPE_4Bit, "AlwaysNull_Or_ValueNeverChanges", enum_releaseRegion))
	return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

function never_toAlt(comparison) => // never_toAlt() => creates a single alt group for a 'Reset If' comparison
	(
		(
			never(comparison) &&
			always_false()	// <-- This line needs to be here so the other groups can still evaluate, else without this line, the other groups are infinitely on hold
							//		This signifies that this alt group only functions as a reset group, it can't trigger the achievement
		) || (
			always_false()
		)
	)
// #endregion MEM - utility

// ................
// ◦ Sub_Header_1 ◦
// ''''''''''''''''
// #region Sub_Header_1

// ----------------Divider---------------------

// #endregion Sub_Header_1

// ................
// ◦ Sub_Header_2 ◦
// ''''''''''''''''
// #region Sub_Header_2

// #endregion Sub_Header_2

// =========================
// • MEMORY initialization •
// =========================
// #region MEM - initialization

//	- This code is for initializing memory addresses which have an offset to another regions memory addresses => lowers amount of hardcoding and chances on mistyping addresses
//	- memory_initialize() => should be called before RATools compiles dictionary achievements_triggers, because those triggers access memory_addresses which might need to be initialized before usage.
//		- Function calls/anonymous functions calls in a dictionary are run at compile time => therefor we need to memory_initialize() before they compile
function memory_initialize() { 
	function initialize_OtherRegions() { // initialize_OtherRegions() => use this when ALL memory addresses for a game region are offset by the same value
		let_EUoffset = sNULL
		let_JPoffset = sNULL
		for memAddrKey in memory_addresses {
			let_USAaddr = memory_addresses[memAddrKey][GAMEREGION_USA]
			if(let_USAaddr == iNULL) util_throwError("Memory Address for {0} is NULL", memAddrKey)
			memory_addresses[memAddrKey][GAMEREGION_EUR] = let_USAaddr + let_EUoffset
			memory_addresses[memAddrKey][GAMEREGION_JPN] = let_USAaddr + let_JPoffset
		}
	}
	// initialize_OtherRegions()
	}
memory_initialize()
// #endregion MEM - initialization
// #endregion MEMORY

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
// #region ACHIEVEMENTS

// =========================
// • ACHIEVEMENT core data •
// =========================
// #region ACH - core data
// - Divided by category => when in debug mode, category tags are added to achievement titles
achievement_POINTS_0 = 0		// Free - Freebie/informational achievement
achievement_POINTS_1 = 1 		// Minor - Finding a hidden item, do some arbitrary/easter egg task
achievement_POINTS_2 = 2 		// Basic - Defeating a few enemies
achievement_POINTS_3 = 3 		// Easy - Completing an easy quest or level
achievement_POINTS_4 = 4 		// Intermediate - Completing a harder quest or level
achievement_POINTS_5 = 5 		// Advanced - Collecting rare items or completing a level
achievement_POINTS_10 = 10		// Challenging - Defeating a major boss or collecting a VERY rare one-of-a-kind item
achievement_POINTS_25 = 25 		// Hard - Completing the game 
achievement_POINTS_50 = 50 		// VeryHard - Achieving 100% completion
achievement_POINTS_100 = 100 	// Impossible - Completing the game without taking a hit (extreme challenge achievements, typical for bonus sets)

achievements_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
		// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_Template": { // Category - info_here
		"a_Template": 	{
			"id": 000000, "points": achievement_POINTS_0, "devInfo": "xxxxxxx"}
		}
	"c_Template2": { // Category - info_here
		"a_Template2": 	{
			"id": 000000, "points": achievement_POINTS_0, "devInfo": "xxxxxxx"}
		}
	}
// -------------------------------------
achievement_TYPE_Progression = "progression"
achievement_TYPE_WinCondition = "win_condition"
achievement_TYPE_Missable = "missable"
achievement_TYPE_Standard = ""

achievements_typeByCategory = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 	achievement_TYPE_Standard,
	"c_Template": 		achievement_TYPE_Standard}
	
// #endregion ACH - core data

// ==================================
// • ACHIEVEMENT trigger generators •
// ==================================
// #region ACH - trigger generators
//	- For achievement logic that's reoccuring across multiple triggers

// #endregion ACH - trigger generators

// ========================
// • ACHIEVEMENT triggers •
// ========================
// #region ACH - triggers
achievements_triggers = {
	// "a_Template": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>  // WIP _template
	// 	is_ReleaseRegion(enum_releaseRegion) &&
	// 	always_false()),
	}
// #endregion ACH - triggers

// =====================
// • ACHIEVEMENT text •
// =====================
// #region ACH - text
achievements_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	}
// -------------------------------------
achievements_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	}
// #endregion ACH - text

// ==============================
// • ACHIEVEMENT initialization •
// ==============================
// #region ACH - initialization
//	- Creates achievement objects (accepted by RATools) based on the achievement dictionary (achievements_coreData)
function achievements_initialize() {
	function achievements_generateTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function achievements_createCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (util_isDebugModeActive) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
			}
			return let_string}
		function achievements_getTitle(string_achievementDevName, string_languageCode) => 
			achievements_titles[string_achievementDevName][string_languageCode]
		return format("{0}{1}",
			achievements_createCategoryName(string_achievementCategory, string_achievementDevName),
			achievements_getTitle(string_achievementDevName, string_languageCode))}
	
	function achievements_generateDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function achievements_getDescription(string_achievementDevName, string_languageCode) => 
			achievements_descriptions[string_achievementDevName][string_languageCode]	
		function achievements_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util_isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = achievements_getDescription(string_achievementDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util_throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_achievementDevName))

		let_descriptionString_withDevInfo = let_descriptionString + achievements_formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}

	function achievements_getTrigger(string_achievementDevName) => 
		achievements_triggers[string_achievementDevName]
	
	function achievements_getType(string_achievementCategory) {
		let_type = achievements_typeByCategory[string_achievementCategory]
		if(let_type == sNULL) return "" // <-- will result in type: "standard"
		return let_type}	
	
	

	for let_categoryName in achievements_coreData { // This loop generates the achievements
		for let_cheevmentName in achievements_coreData[let_categoryName] {
			let_achievementData = achievements_coreData[let_categoryName][let_cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = achievements_generateTitle(let_cheevmentName, let_categoryName, util_language),
				type = achievements_getType(let_categoryName),
				description = achievements_generateDescription(let_cheevmentName, let_achievementData["devInfo"], util_language),
				points = let_achievementData["points"],
				trigger = achievements_getTrigger(let_cheevmentName)
			)
		}}
	}// #endregion ACH - initialization
// #endregion ACHIEVEMENTS

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
// #region RICH PRESENCE
// TODO implement Rich Presence

// =====================
// • RICH PRESENCE text •
// =====================
// #region RP - text
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},
	"rp_Default":										{"en": "xxxxxxxx"}}	// TODO implement rp_Default + rp_DefaultPlus
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	}
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	// "lup_Template": {
		// "LookupTableText_Key": "lupText_Template",
		// "LookUpTable": {
		// 	enum_XXX_A:					"LookupTextKey_A",
		// 	enum_XXX_B:					"LookupTextKey_B",
		// 	enum_XXX_C:					"LookupTextKey_C",
		// 	},
		// },
	}
function richPresence_getLookupTable(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]["LookUpTable"]
function richPresence_getLookupTableTextKey(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]["LookupTableText_Key"]
// ------------------CustomZeroPadding-------------------
function richPresence_addZeroPaddingLookupTable(string_lookupTableName, int_numberOfZerosToPad, int_maxLookupValueKey) {
	// Example output: richPresence_addZeroPaddingLookupTable("rpp_DateTime_ZeroPadding", 1, 24) => adds below table to richPresence_lookupTables
		// '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		//	"rpp_DateTime_ZeroPadding": {
		//		0: "0",
		//		1: "0",
		//		2: "0",
		//		3: "0",
		//		4: "0",
		//		5: "0",
		//		6: "0",
		//		7: "0",
		//		8: "0",
		//		9: "0",
		//		10: "",
		//		11: "",
		//		12: "",
		//		13: "",
		//		14: "",
		//		15: "",
		//		16: "",
		//		17: "",
		//		18: "",
		//		19: "",
		//		20: "",
		//		21: "",
		//		22: "",
		//		23: "",
		//		24: "",
		//		""
		//	},

	let_string_zeros = ""
	if (int_numberOfZerosToPad < 1) util_throwError("Number of zeros to pad must be bigger than 0")
	for let_i in range(0, int_numberOfZerosToPad-1) let_string_zeros = let_string_zeros + "0"

	let_dict_lookupTable = {}
	for let_i in range(0, int_maxLookupValueKey) {
		if (let_i < 10) let_dict_lookupTable[let_i] = let_string_zeros
		else if (let_i < 100) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 1) // <-- substring() will return let_string_zeros minus 1 "0" 	=> eg. "000" -> "00"
		else if (let_i < 1000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 2)
		else if (let_i < 10000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 3)
		else if (let_i < 100000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 4)
		else if (let_i < 1000000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 5)
		else if (let_i < 10000000) let_dict_lookupTable[let_i] = substring(let_string_zeros, 0, length(let_string_zeros) - 6)
		else util_throwError("Support for higher values is not implemented")
	}

	richPresence_lookupTables[string_lookupTableName] = let_dict_lookupTable}

function richPresence_initializeZeroPaddingLookupTables() { // Function is called in richPresence_initialize()
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeMinutes_ZeroPadding", 1, 59)
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeHours_ZeroPadding", 1, 23)}
// #endregion RP - text

// ================================
// • RICH PRESENCE display script •
// ================================
// #region RP - display script

// function rp_TemplateDisplayScript(enum_releaseRegion) { 
	// function condition(enum_releaseRegion) =>
	// 	is_ReleaseRegion(enum_releaseRegion)
	// return rich_presence_conditional_display( 
	// 	condition(enum_releaseRegion),
	// 	richPresence_getText("rp_Template"),
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus")
	)}
function rp_Default() {
	return rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {

	}} 
// #endregion RP - display script

// ===========================
// • RICH PRESENCE parameters •
// ===========================
// #region RP - parameters
richPresence_VALUE = 1			// rich_presence_value(name, expression, [format])
richPresence_LOOKUP_HEX = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_LOOKUP_STRING = 3	//  rich_presence_ascii_string_lookup(name, memAddr_ASCII, dictionary, [fallback])
richPresence_MACRO = 4			// rich_presence_macro(macro, expression)
// -------------------------------------

// -------------------------------------
richPresence_parameterData = {
	// DEV_NOTE: rich presence
	// 		- Expression examples:
	//			-- Memory Accessor => byte(0x000)
	//			-- Arithmetic Expression => getCurrentLevel() + 1
	// 		- Available macro formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_macromacro-expression
	// 		- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// ------------------------------------------------------
	
	// "rpp_ValueTemplate": {
		// "RPtype": richPresence_VALUE,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "ValueFormat": "VALUE"},

	// "rpp_LookupHexTemplate": {
		// "RPtype": richPresence_LOOKUP_HEX,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_LookupStringTemplate": {
		// "RPtype": richPresence_LOOKUP_STRING,
		// "MemoryAddressToASCII": {
		// 	RELEASE_REGION_USA: memory_getAddress(), 
		// 	RELEASE_REGION_EUR: memory_getAddress(),
		// 	RELEASE_REGION_JPN: memory_getAddress()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	//	"rpp_MacroTemplate": {
		// "RPtype": richPresence_MACRO,
		// "Expression": {
		// 	RELEASE_REGION_USA: always_false(), 
		// 	RELEASE_REGION_EUR: always_false(),
		// 	RELEASE_REGION_JPN: always_false()},
		// "MacroFormat": "Number"},	
	
	

	}
// -------------------------------------
function richPresence_createParameterName(string_parameterKey) => // Removes rpp_ 
	substring(string_parameterKey, 4)	

function richPresence_callParameterFunction(string_parameterKey, enum_releaseRegion) {	// Checks which rich_presence function to execute/call and gives it the correct parameters with the data stored in richPresence_parameterData
	function richPresence_callValueFunction(string_parameterKey, dict_paramValueData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(string_parameterKey)
		let_expression = dict_paramValueData["Expression"][enum_releaseRegion]
		let_format = dict_paramValueData["ValueFormat"] 
		return rich_presence_value(let_name, let_expression, let_format)}
	
	function richPresence_callLookupHexFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_expression = dict_paramLookupData["Expression"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}

	function richPresence_callLookupStringFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_memAddr_ASCII = dict_paramLookupData["MemoryAddressToASCII"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_ascii_string_lookup(let_name, let_memAddr_ASCII, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData, enum_releaseRegion) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"][enum_releaseRegion]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP_HEX) return richPresence_callLookupHexFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP_STRING) return richPresence_callLookupStringFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}
// #endregion RP - parameters

// ===============================
// • RICH PRESENCE initialization •
// ===============================
// #region RP - initialization
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_lookupTableKey in richPresence_lookupTables { 
		let_lookupTable = richPresence_getLookupTable(let_lookupTableKey)
		let_lookupTableTextKey = richPresence_getLookupTableTextKey(let_lookupTableKey)
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_lookupTableKey]["LookUpTable"][let_lookupKey]
			richPresence_lookupTables[let_lookupTableKey]["LookUpTable"][let_lookupKey] = richPresence_getLookupTableText(let_lookupTableTextKey, let_lookupValue)
		}
	}}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_initializeZeroPaddingLookupTables() // <-- should be called after richPresence_populateLookupTables() as ZeroPaddingLookupTables don't need to be populated AND before richPresence_initializeDisplays()
	richPresence_initializeDisplays()}
// #endregion RP - initialization
// #endregion RICH PRESENCE

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
// #region LEADERBOARDS
// TODO implement leaderboards

// =========================
// • LEADERBOARD core data •
// =========================
// #region LB - core data
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
		// "id": 000000, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "xxxxxxx"},
	}
// #endregion LB - core data

// ==================================
// • LEADERBOARD trigger generators •
// ==================================
// #region LB - trigger generators
//	- For leaderboard logic that's reoccuring across multiple triggers
// #endregion LB - trigger generators

// ========================
// • LEADERBOARD triggers •
// ========================
// #region LB - triggers
leaderboards_startTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [0] ==== Alt Start Group ====		-> Start when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [1] ==== Alt Start Group ====		-> Start when ...
		//  || is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Start Group ====		-> Start when ...
		//  || is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
leaderboards_cancelTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [3] ==== Alt Cancel Group ====		-> Cancel when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
leaderboards_submitTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Submit Group ====		-> Submit when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Reset Group ====			-> Reset when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
//-----------------ValueMeasures-------------------
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}
leaderboards_valueMeasures = {
	// "lb_template": lb_ValueMeasure_Template(),
	}
// #endregion LB - triggers

// ====================
// • LEADERBOARD text •
// ====================
// #region LB - text
leaderboards_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
leaderboards_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
// #endregion LB - text

// ==============================
// • LEADERBOARD initialization •
// ==============================
// #region LB - initialization
function leaderboards_initialize() {
	function leaderboards_generateTitle(string_leaderboardDevName, string_languageCode) {
		function leaderboards_createDevName(string_leaderboardDevName) => 	// Wrap LeaderoboardDevName in [] (brackets)
			format("[{0}] ", string_leaderboardDevName)
		function leaderboards_getTitle(string_leaderboardDevName, string_languageCode) => 
			leaderboards_titles[string_leaderboardDevName][string_languageCode]

		if (util_isDebugModeActive) {
			return format("{0}{1}", 
				leaderboards_createDevName(string_leaderboardDevName),
				leaderboards_getTitle(string_leaderboardDevName, string_languageCode))
		} else {
			return leaderboards_getTitle(string_leaderboardDevName, string_languageCode)
		}}
	
	function leaderboards_generateDescription(string_leaderboardDevName, string_devInfo, string_languageCode) {	
		function leaderboards_getDescription(string_leaderboardDevName, string_languageCode) {
			return leaderboards_descriptions[string_leaderboardDevName][string_languageCode]}
		function leaderboards_formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util_isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = leaderboards_getDescription(string_leaderboardDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util_throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_leaderboardDevName))

		let_descriptionString_withDevInfo = let_descriptionString + leaderboards_formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}
	

	for let_leaderboardKey in leaderboards_coreData {
		let_leaderboardData = leaderboards_coreData[let_leaderboardKey]
		leaderboard(
			id = let_leaderboardData["id"],
			title = leaderboards_generateTitle(let_leaderboardKey, util_language), 
			description = leaderboards_generateDescription(let_leaderboardKey, let_leaderboardData["devInfo"], util_language),
			start = leaderboards_startTriggers[let_leaderboardKey], 
			cancel = leaderboards_cancelTriggers[let_leaderboardKey], 
			submit = leaderboards_submitTriggers[let_leaderboardKey], 
			value = leaderboards_valueMeasures[let_leaderboardKey],
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}
// #endregion LB - initialization
// #endregion LEADERBOARDS

// ====================================================================== \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ====================================================================== \\
// #region RAScript Initialization