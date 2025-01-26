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

//	Achievement & Leaderboard logic
// ---------------------------------------------
//	- Include delta wherever possible => one of safest way to make sure achievement doesn't pop randomly
//	- Also include delta's for submit, cancel and start triggers on leaderboard logic

// How to: ResetNextIf
// ---------------------------------------------
//	- Call never() inside a tally(), once() or repeated()
//	- Example
// 			tally(10, 
// 				never(healthDecreases()) && // <-- reset this hit count when taking damage, will generate a 'resetnextif' flag when it is applicable with the rest of the trigger, otherwise it may just be a normal 'reset' flag
// 				succesfullDodges() // <-- +1 hit count when dodging
// 			)

// Git info
// ---------------------------------------------
//	- Remove remote branches which have been deleted remotely, from vscode list, run following command => git fetch --prune

// Syncing Local RAdata with server
// ---------------------------------------------
// 	- RALibretro => Assets list => Revert all assets (will fetch all changes from RAserver) + Refresh RATools as well
//		-- For example change badge on RAweb => revert local so badge ID is changed as well locally to the next ID

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

util_isDebugModeActive = false	// if true => extra information may be displayed on achievement titles & descriptions
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

// =============================
// • Memory STRUCT DEFINITIONS •
// =============================
memory_regionOffsets = {
	"Struct_Template_WeaponDataArray": {
		"offset_USA_to_JPN": 0x000
	}}
function memory_getRegionOffset(string_structKey, string_offsetKey) =>
	memory_regionOffsets[string_structKey][string_offsetKey]
// -------------------------------------
memory_dataStructures = {
	"Struct_Template_WeaponData": {
		"sizeInBytes": 18,
		"offsetsToMembers": {
			"16Bit_WeaponID": 0x0,
			"32Bit_WeaponLevel": 0x4,
			"BitFlag_IsWeaponUnlocked": 0x8,			
			"BitFlag_IsWeaponEquipped": 0x9,
			"Float_WeaponAffinity": 0x10
		}},
	}
function memory_getDataStructSizeInBytes(string_structKey) =>
	memory_dataStructures[string_structKey]["sizeInBytes"]

function memory_getDataStructOffset(string_structKey, string_offsetKey) =>
	memory_dataStructures[string_structKey]["offsetsToMembers"][string_offsetKey]
// ==========================
// • Memory ADDRESS STORAGE •
// ==========================
DATATYPE_BitFlag 				= 700
DATATYPE_Upper4 				= 600
DATATYPE_Lower4 				= 600
DATATYPE_8Bit 					= 500
DATATYPE_16BitBE 				= 401
DATATYPE_16Bit 					= 400
DATATYPE_24Bit 					= 350
DATATYPE_32BitPointer 			= 300
DATATYPE_32Bit 					= 200
DATATYPE_Float					= 201
DATATYPE_ASCII					= 150
DATATYPE_Struct 				= 100
memory_addresses = {
	//	DATATYPE_xxxxx: {
	//		"Template": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	//	},
	DATATYPE_BitFlag: {
	},
	DATATYPE_4Bit: {
	},
	DATATYPE_8Bit: {
		"Template_Area": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL}, 
	},
	DATATYPE_16Bit: {
	},
	DATATYPE_25BitPointer: {
	},
	DATATYPE_Float: {
	},
	DATATYPE_32Bit: {
	},
	DATATYPE_ASCII: {
	},
	DATATYPE_Struct: {
		"Template_WeaponDataArray": {RELEASE_REGION_USA: sNULL, RELEASE_REGION_EUR: sNULL, RELEASE_REGION_JPN: sNULL},
	}}

function memory_getAddress(enum_dateType, string_addrKey, enum_releaseRegion) {
	let_memAddr = memory_addresses[enum_dateType][string_addrKey][enum_releaseRegion]
	if(let_memAddr == sNULL) util_throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
	return let_memAddr}

// ==================
// • Memory UTILITY •
// ==================
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

// ................
// ◦ SUB HEADER 1 ◦
// ''''''''''''''''
// 	- Some explanation...		
// 	- Some explanation...		
AREA_a = 0x1
AREA_b = 0x2
AREA_c = 0x3
AREA_d = 0x4
AREA_e = 0x5
function current_AreaID(enum_releaseRegion) => 
	byte(memory_getAddress(DATATYPE_8Bit, "Template_Area", enum_releaseRegion))	

function prior_AreaID(enum_releaseRegion) =>
	prior(current_AreaID(enum_releaseRegion))

function prev_AreaID(enum_releaseRegion) =>
	prev(current_AreaID(enum_releaseRegion))

function is_Area(enum_area, enum_releaseRegion) =>		// Example usage => is_Area(enum_TEMPLATE_AREA_A, RELEASE_REGION_EUR)
	current_AreaID(enum_releaseRegion) == enum_area

function was_Area(enum_area, enum_releaseRegion) =>
	prior_AreaID(enum_releaseRegion) == enum_area

function on_AreaFinish(enum_area, enum_releaseRegion) =>	// on_templateFunction() => "on" signifies that this function returns a comparison that's checking delta values
	current_AreaID(enum_releaseRegion) != enum_area && 
	prev_AreaID(enum_releaseRegion) == enum_area
// -------------------------------------
// 	- Some explanation...
// 	- Some explanation...
// 	- Some explanation...

// ................
// ◦ SUB HEADER 2 ◦
// ''''''''''''''''
// 	- Some explanation...
// 	- Some explanation...
WEAPON_a = 100
WEAPON_b = 101
WEAPON_c = 102
const_weapons_data = {
	WEAPON_a: {
		"weaponDataArray_offset": 0x20,
		"maxWeaponAffinity": 99.0}, // <-- float
	WEAPON_b: {
		"weaponDataArray_offset": 0x40,
		"maxWeaponAffinity": 77.0},
	WEAPON_c: {
		"weaponDataArray_offset": 0x60,
		"maxWeaponAffinity": 20.0}
	}

function get_maxWeaponAffinity(enum_weapon) =>
	const_weapons_data[enum_weapon]["maxWeaponAffinity"]

function is_WeaponEquipped(enum_weapon, enum_releaseRegion) {
	let_memAddr_weaponDataArray = memory_getAddress(DATATYPE_Struct, "Template_WeaponDataArray", enum_releaseRegion)
	let_weaponOffset = const_weapons_data[enum_weapon]["weaponDataArray_offset"]
	let_offset_bitFlag_isWeaponEquipped = memory_getDataStructOffset("Struct_Template_WeaponData", "BitFlag_IsWeaponEquipped")
	return bit0(let_memAddr + let_weaponOffset + let_offset_bitFlag_isWeaponEquipped) == 1}

function current_WeaponAffinity(enum_weapon, enum_releaseRegion) {
	let_memAddr_weaponDataArray = memory_getAddress(DATATYPE_Struct, "Template_WeaponDataArray", enum_releaseRegion)
	let_weaponOffset = const_weapons_data[enum_weapon]["weaponDataArray_offset"]
	let_offset_weaponAffinity = memory_getDataStructOffset("Struct_Template_WeaponData", "Float_WeaponAffinity")
	return float(let_memAddr_weaponDataArray + let_weaponOffset + let_offset_weaponAffinity)}

function prev_WeaponAffinity(enum_weapon, enum_releaseRegion) =>
	prev(current_WeaponAffinity(enum_weapon, enum_releaseRegion))

function on_WeaponAffinityMaxed(enum_weapon, enum_releaseRegion) {
	let_maxWeaponAffinity = get_maxWeaponAffinity(enum_weapon)
	return 	
		prev_WeaponAffinity(enum_weapon, enum_releaseRegion) > (let_maxWeaponAffinity*3)/4 	&& // <-- Possible save protection
		prev_WeaponAffinity(enum_weapon, enum_releaseRegion) < let_maxWeaponAffinity		&&
		current_WeaponAffinity(enum_weapon, enum_releaseRegion) == let_maxWeaponAffinity}
	
function memUtil_sumOfAllCurrentWeaponsAffinity(enum_releaseRegion) => 
	sum_of(const_weapons_data, (weaponDataKey){
		let_memAddr_currentWeaponAffinity = const_weapons_data[weaponDataKey]["memAddr_CurrentWeaponAffinity"]		
		return dword(let_memAddr_currentWeaponAffinity)
	})

function is_AllWeaponsAffinityMaxed(enum_releaseRegion) =>
	memUtil_sumOfAllCurrentWeaponsAffinity(enum_releaseRegion) == memUtil_totalAffinityOverAllWeapons(enum_releaseRegion)

// -------------------------------------
function doThisA(enum_releaseRegion) => always_false()
function doThisB(enum_releaseRegion) => always_false()
function doThisC(enum_releaseRegion) => always_false()
// =========================
// • Memory INITIALIZATION •
// =========================
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

	"c_ExampleWeaponLeveling": {	// Category - Leveling all weapons
		"a_Example_WeaponAMaxed": { // VERIFIED
			"id": 000000, "points": 3,
			"devInfo": "xxxxxxx"},
		"a_Example_AllWeaponsAffinitiesMaxed": { // VERIFIED
			"id": 000000, "points": 25,
			"devInfo": "xxxxxxx"},
	},
    "c_ExampleCategeroy1": {	// Category - [info about category]
        "a_AchievementA": { // VERIFIED
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"},
        "a_AchievementB": { // BUG something_is_wrong
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"},
        "a_AchievementC": { // VERIFIED
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"}
    },
    "c_ExampleCategeroy2": {	// Category - [info about category]
        "a_AchievementD": { // DISABLED // VERIFIED reason_of_inactivity
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"}
    },
    "c_ExampleCategeroy3": {	// Category - [info about category]
        "a_AchievementE": { // VERIFIED
            "id": 000000, "points": 0000000, 
            "devInfo": "xxxxxxx"},
        "a_AchievementF": { // VERIFIED
            "id": 000000, "points": 0000000,
            "devInfo": "xxxxxxx"}
    }}
// -------------------------------------
achievements_typeByCategory = {	// TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 			"xxxxxx",
	"c_ExampleWeaponLeveling":			sNULL
	"c_ExampleCategeroy1": 				sNULL,
	"c_ExampleCategeroy2": 				sNULL,
	"c_ExampleCategeroy3":				sNULL}

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
    // "a_Template": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>  // WIP_template
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),
	"a_Example_WeaponAMaxed": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion) &&
		on_WeaponAffinityMaxed(WEAPON_a, enum_releaseRegion)),
	"a_Example_AllWeaponsAffinitiesMaxed": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => {
		function calculate_totalAffinityOverAllWeapons() {
			let_total = 0
			for enum_weapon in const_weapons_data
				let_total = let_total + const_weapons_data[enum_weapon]["maxWeaponAffinity"]
			return let_total}
		
		let_totalWeaponAffinity = calculate_totalAffinityOverAllWeapons()
		let_sumOfExpression_prevWeaponAffinities = sum_of(const_weapons_data, (enum_weapon) => prev_WeaponAffinity(enum_weapon, enum_releaseRegion))
		let_sumOfExpression_currentWeaponAffinities = sum_of(const_weapons_data, (enum_weapon) => current_WeaponAffinity(enum_weapon, enum_releaseRegion))

		return
			is_ReleaseRegion(enum_releaseRegion) &&
			let_sumOfExpression_prevWeaponAffinities > (let_totalWeaponAffinity*7)/8	&& // <-- possible save protection
			let_sumOfExpression_prevWeaponAffinities < let_totalWeaponAffinity			&&
			let_sumOfExpression_currentWeaponAffinities == let_totalWeaponAffinity	
		}),	
	"a_AchievementF": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),
	"a_AchievementE": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),	
	"a_AchievementD": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),
	"a_AchievementC": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),
	"a_AchievementB": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()),
	"a_AchievementA": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false())
	}

// ********************
// • Achievement TEXT •
// ********************
achievements_titles = {
    // "a_Template":						{"en": "xxxxx"},
	"a_Example_WeaponAMaxed":				{"en": "xxxxx"},
	"a_Example_AllWeaponsAffinitiesMaxed":	{"en": "xxxxx"}, 
    "a_AchievementF":						{"en": "EnglishTitle"},
    "a_AchievementE":						{"en": "EnglishTitle"},
    "a_AchievementD":						{"en": "EnglishTitle"},
    "a_AchievementC":						{"en": "EnglishTitle"},
    "a_AchievementB":						{"en": "EnglishTitle",
											"fr": "FrenchTitle",
											"nl": "DutchTitle"},
    "a_AchievementA":						{"en": "EnglishTitle",
											"fr": "FrenchTitle",
											"nl": "DutchTitle"}}
// -------------------------------------
achievements_descriptions = {
    // "a_Template": 						{"en": "xxxxx"}, 
	"a_Example_WeaponAMaxed":				{"en": "xxxxx"},
	"a_Example_AllWeaponsAffinitiesMaxed":	{"en": "xxxxx"}, 
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

// ===============================
// • Achievements INITIALIZATION •
// ===============================
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

		return format("{0}{1}",
			achievements_getDescription(string_achievementDevName, string_languageCode),
			achievements_formatDevInfo(string_devInfo))}

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

// TODO implement Rich Presence

// =====================
// • RichPresence TEXT •
// =====================
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 									{"en": "xxxxxxxx"},	

	"rp_TemplateB":										{"en": "xxxxxxxx"},
	"rp_TemplateA":										{"en": "Current time {0}{1}:{2}{3}"},

	"rp_Default":										{"en": "Playing the game"}}	// TODO rp_Default + rp_DefaultPlus

richPresence_LookupTablesText = {
	"lup_LookupTemplate": {
		"Lookup_A":						{"en": "xxxxxxxx"},
		"Lookup_B":						{"en": "xxxxxxxx"},
		"Lookup_C":						{"en": "xxxxxxxx"},
		"LOOKUP_FALLBACK":				{"en": "xxxxxxxx"}
		},
	}

function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util_language]

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util_language]
// -----------------LookupTables--------------------
richPresence_lookupTables = {
	"lup_LookupTemplate": {
		0x1: "Lookup_A",
		0x2: "Lookup_B",
		0x3: "Lookup_C"}}
function richPresence_getLookupTable(string_lookupTableKey) =>
	richPresence_lookupTables[string_lookupTableKey]

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
	richPresence_addZeroPaddingLookupTable("rpp_Example_PresentTimeHours_ZeroPadding", 1, 59)
	richPresence_addZeroPaddingLookupTable("rpp_Example_PresentTimeMinutes_ZeroPadding", 1, 23)}

// =========================
// • RichPresence DISPLAYS •
// =========================
function rp_TemplateA(enum_releaseRegion) {
	function condition(enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()
	return rich_presence_conditional_display(
		condition(enum_releaseRegion),
		richPresence_getText("rp_TemplateA"),
		richPresence_callParameterFunction("rpp_Example_PresentTimeHours_ZeroPadding", enum_releaseRegion), // Adds "0" when rpp_PresentTimeHours is < 10
		richPresence_callParameterFunction("rpp_Example_PresentTimeHours", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_Example_PresentTimeMinutes_ZeroPadding", enum_releaseRegion),
		richPresence_callParameterFunction("rpp_Example_PresentTimeMinutes", enum_releaseRegion),
	)}

function rp_TemplateB(enum_releaseRegion) {
	function condition(enum_releaseRegion) => 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()
	return rich_presence_conditional_display(
		condition(enum_releaseRegion),
		richPresence_getText("rp_TemplateB")
	)}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		is_ReleaseRegion(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText("rp_DefaultPlus"),
		richPresence_callParameterFunction("rpp_TemplateZ", enum_releaseRegion)
	)}

function rp_Default() {
	return rich_presence_display(	
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default()
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		rp_TemplateA(enum_releaseRegion) // VERIFIED
		// rp_TemplateB(enum_releaseRegion) // DISABLED // VERIFIED not as elegant inside rich presence; 	--> !! IF !! turning back on => re-check other richPresence conditions, some other conditions need changing
		rp_DefaultPlus(enum_releaseRegion) // VERIFIED
	}} 

// ===========================
// • RichPresence PARAMETERS •
// ===========================
richPresence_VALUE = 1		// rich_presence_value(name, expression, [format])
richPresence_LOOKUP = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
richPresence_MACRO = 3		// rich_presence_macro(macro, expression)
// -------------------------------------
function rpp_Example_PresentTimeMinutes(enum_releaseRegion) { return
	current_DateTime_Minutes(DATETIME_Present, enum_releaseRegion)}

function rpp_Example_PresentTimeHours(enum_releaseRegion) { return
	current_DateTime_Hours(DATETIME_Present, enum_releaseRegion)}

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
		"RPtype": richPresence_VALUE,
		"Expression": {
			RELEASE_REGION_USA: always_false(), 
			RELEASE_REGION_EUR: always_false(),
			RELEASE_REGION_JPN: always_false()},
		"ValueFormat": "VALUE"},
	"rpp_LookupTemplate": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: always_false(), 
			RELEASE_REGION_EUR: always_false(),
			RELEASE_REGION_JPN: always_false()},
		"LookupTableID": "lup_LookupTemplate",
		"LookupFallback": richPresence_getLookupTableText("lup_LookupTemplate", "LOOKUP_FALLBACK")},
	"rpp_MacroTemplate": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: always_false(), 
			RELEASE_REGION_EUR: always_false(),
			RELEASE_REGION_JPN: always_false()},
		"MacroFormat": "Number"},
	
	"rpp_Example_PresentTimeMinutes_ZeroPadding": { // Use in combination with a DateTime. eg. rpp_PresentTimeMinutes => to prepend an extra 0 when the minutes would only evaluate to 1 number 	=> eg. "7" --> "07"
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_Example_PresentTimeMinutes(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Example_PresentTimeMinutes(RELEASE_REGION_EUR),
			RELEASE_REGION_JPN: rpp_Example_PresentTimeMinutes(RELEASE_REGION_JPN)},
		"LookupFallback": "0"}, // This "0" + "0" from rpp_PresentTimeMinutes => will show "00"
	"rpp_Example_PresentTimeMinutes": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_Example_PresentTimeMinutes(RELEASE_REGION_USA), 
			RELEASE_REGION_EUR: rpp_Example_PresentTimeMinutes(RELEASE_REGION_EUR),
			RELEASE_REGION_JPN: rpp_Example_PresentTimeMinutes(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	"rpp_Example_PresentTimeHours_ZeroPadding": {
		"RPtype": richPresence_LOOKUP,
		"Expression": {
			RELEASE_REGION_USA: rpp_PresentTimeHours(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: rpp_PresentTimeHours(RELEASE_REGION_JPN)},
		"LookupFallback": "0"},
	"rpp_Example_PresentTimeHours": {
		"RPtype": richPresence_MACRO,
		"Expression": {
			RELEASE_REGION_USA: rpp_PresentTimeHours(RELEASE_REGION_USA), 
			RELEASE_REGION_JPN: rpp_PresentTimeHours(RELEASE_REGION_JPN)},
		"MacroFormat": "Number"},
	

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
	
	function richPresence_callLookupFunction(string_parameterKey, dict_paramLookupData, enum_releaseRegion) {
		let_name = richPresence_createParameterName(dict_paramLookupData["LookupTableID"])
		let_expression = dict_paramLookupData["Expression"][enum_releaseRegion]
		let_lookUpTable = richPresence_getLookupTable(dict_paramLookupData["LookupTableID"])
		let_lookupFallback = dict_paramLookupData["LookupFallback"]
		return rich_presence_lookup(let_name, let_expression, let_lookUpTable, let_lookupFallback)}
	
	function richPresence_callMacroFunction(dict_paramMacroData, enum_releaseRegion) {
		let_macro = dict_paramMacroData["MacroFormat"] 
		let_expression = dict_paramMacroData["Expression"][enum_releaseRegion]
		return rich_presence_macro(let_macro, let_expression)}

	let_parameterData = richPresence_parameterData[string_parameterKey]
	let_RPtype = let_parameterData["RPtype"]
	if (let_RPtype == richPresence_VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_LOOKUP) return richPresence_callLookupFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == richPresence_MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util_throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}

// ===============================
// • RichPresence INITIALIZATION •
// ===============================
function richPresence_populateLookupTables() {	// Changes the richPresence_lookupTables IDs to the corresponding text in richPresence_text
	for let_lookupTableKey in richPresence_lookupTables { 
		let_lookupTable = richPresence_lookupTables[let_lookupTableKey]
		for let_lookupKey in let_lookupTable {
			let_lookupValue = richPresence_lookupTables[let_lookupTableKey][let_lookupKey]
			richPresence_lookupTables[let_lookupTableKey][let_lookupKey] = richPresence_getLookupTableText(let_lookupTableKey, let_lookupValue)
		}
	}}

function richPresence_initialize() {
	richPresence_populateLookupTables()
	richPresence_initializeZeroPaddingLookupTables() // <-- should be called after richPresence_populateLookupTables() as ZeroPaddingLookupTables don't need to be populated AND before richPresence_initializeDisplays()
	richPresence_initializeDisplays()}

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

// TODO implement leaderboards

// ==========================
// • Leaderboards CORE DATA •
// ==========================
leaderboards_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
	// 	"id": 000000, "isLowerBetter": false, 
	// 	"leaderboardFormat": "VALUE",
	// 	"devInfo": "xxxxxxx"},

	"lb_StageAClearTime": { // VERIFIED 
		"id": 000000, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "xxxxxxx"},
	"lb_StageBClearTime": { // VERIFIED 
		"id": 000000, "isLowerBetter": true,
		"leaderboardFormat": "SECS",
		"devInfo": "xxxxxxx"},
	}

// ===================================
// • Leaderboards TRIGGER GENERATORS •
// ===================================
//	- For leaderboard logic that's reoccuring across multiple triggers
function leaderboards_generate_StartTrigger_StageClearTime(enum_releaseRegion) {
	return 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()}
function leaderboards_generate_CancelTrigger_StageClearTime(enum_releaseRegion) {
	return 
		is_ReleaseRegion(enum_releaseRegion) &&
		always_false()}
function leaderboards_generate_SubmitTrigger_StageClearTime(enum_releaseRegion) =>
	is_ReleaseRegion(enum_releaseRegion) &&
	always_false()
function leaderboards_generate_ValueMeasure_StageClearTime(enum_releaseRegion) =>
	measured(get_Timer_ClearTime_InSeconds(enum_releaseRegion), when = is_ReleaseRegion(enum_releaseRegion))
// =========================
// • Leaderboards TRIGGERS •
// =========================
leaderboards_startTriggers = {
	"lb_StageAClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_StartTrigger_StageClearTime()),
	"lb_StageBClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_StartTrigger_StageClearTime()),
	}
leaderboards_cancelTriggers = {
	"lb_StageAClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_CancelTrigger_StageClearTime()),
	"lb_StageBClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_CancelTrigger_StageClearTime()),
	}
leaderboards_submitTriggers = {
	"lb_StageAClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_SubmitTrigger_StageClearTime()),
	"lb_StageBClearTime": () => any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		leaderboards_generate_SubmitTrigger_StageClearTime()),
	}
leaderboards_valueMeasures = {
	"lb_StageAClearTime": () {
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = leaderboards_generate_ValueMeasure_StageClearTime(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	"lb_StageBClearTime": () {
		function valueMeasure(enum_releaseRegion) => 
			measured(get_Timer_TotalClearTime_InMinutes(enum_releaseRegion), when = is_ReleaseRegion(enum_releaseRegion))
		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
			let_valueMeasure = valueMeasure(enum_releaseRegion)
			array_push(let_array_valueMeasures, let_valueMeasure)
		}
		return max_of(let_array_valueMeasures)},
	}

// =====================
// • Leaderboards TEXT •
// =====================
leaderboards_titles = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_StageAClearTime":					{"en": "xxxxxxxx"},
	"lb_StageBClearTime":					{"en": "xxxxxxxx"}, 
	}
leaderboards_descriptions = {
	// "rp_Template": 						{"en": "xxxxxxxx"},
	"lb_StageAClearTime":					{"en": "xxxxxxxx"},
	"lb_StageBClearTime":					{"en": "xxxxxxxx"}, 
	}

// ===============================
// • Leaderboards INITIALIZATION •
// ===============================
function leaderboards_initialize() {
	function leaderboards_generateTitle(string_leaderboardDevName, string_languageCode) {
		function leaderboards_createDevName(string_leaderboardDevName) => 	// Removes lb_ and puts it between []
			format("[{0}] ", substring(string_leaderboardDevName, 3))
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
		return format("{0}{1}",
			leaderboards_getDescription(string_leaderboardDevName, string_languageCode),
			leaderboards_formatDevInfo(string_devInfo))}

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

// ********************************************************************** \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ********************************************************************** \\
function initializeRAscript() {
	achievements_initialize()
	richPresence_initialize()
	leaderboards_initialize()}
initializeRAscript()