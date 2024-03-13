// ********************************************************************* \\
//    █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█    █▀█ █▀▀    █▀▄ █▀▀ █▀ ▀█▀ █ █▄░█ █▄█   \\
//    ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀    █▄█ █▀░    █▄▀ ██▄ ▄█ ░█░ █ █░▀█ ░█░   \\
// ********************************************************************* \\
// #ID = 3945
// md5: 2991ecdb4d9a22dc40511b241bfb59a4 - USA

//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //     DEVELOPER NOTES      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\

// Info regarding usage/reading of this RAScript
// ---------------------------------------------
//	- Set indent mode => Tabs			Set indent size => 4
//	- For colored text/code (in Visual Studio Code) => select a language mode (bottom right of vscode window) other than 'plain text' => Go, C#, Rust, CUDA C++, C++ 

//	- Usage of Todo Tree tags => install 'Todo Tree extension' by Gruntfuggly; settings.json file has some settings to edit the tags; README of extension => https://github.com/Gruntfuggly/todo-tree#highlighting
//	- Use RATools to update achievement logic written here to RALibrertro
//	- Use RALibretro/RATools to publish/push the achievement logic to RetroAchievements servers
//	- Documentation for achievement development => https://docs.retroachievements.org/Developer-Docs/
//		-- Rich Presence documentation => https://docs.retroachievements.org/Rich-Presence/ AND https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions
//			--- Rich Presence Macro's => https://docs.retroachievements.org/Rich-Presence/#macros
//			--- To Test RP via RATools, same as updating achievement logic, but afteran  RP update => restart RALibretro OR keep the following file op in an editor: ..\RALibretro\RACache\Data\XXX-Rich.txt 
//	- Documentation for RALibretro => https://docs.retroachievements.org/Developer-Docs/
//	- Documentation for RATools => https://github.com/Jamiras/RATools/wiki

// General info regarding PSP structures
// ---------------------------------------------
// 	- PSP pointers usually start with 08 or 09 + 25-bit => mask with 0x1ffffff
 
//#####################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //     UTILITY      \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#####################################################################################################\\
// TODO set debug mode off
const_utilitySettings_debugMode = false	// if true => extra information may be displayed on achievement titles & descriptions
const_utilitySettings_language = "en"	// ISO 639-1 language codes 

const_utilitySettings_guideLink = "bit.ly/ShadowOfDestiny" // https://bit.ly/ShadowOfDestiny => links to written achievement guide on github (https://github.com/QuentinBultinck/RetroAchievements/blob/main/RAscripts/PSP/ShadowOfDestiny/README.md)
const_utilitySettings_isGuideLinkEnabled = false			// if false => above link will not be placed into the achievement description, even when the achievement has tips in the guide 

function throwError(string_errMsg) {	// This function will throw an error in RAscript because the key doesn't exist
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

// ******************
// ÷ TIME AND DATE ÷
// ******************
const_timePeriod = {
	"Present":	0x83,
	"Late20ThCentury": 0x82,	// When in 1980
	"Late20ThCentury": 0x88,	// When in 1979
	"Early20ThCentury": 0x81,
	"MiddleAges": 0x80}

function getCurrentTimePeriod() =>	// $AA1268: [32-bit] Time Period
	dword(0xAA1268)					//		0x80 => Middle ages 1500s
									// 		0x81 => Late 20th Century 1900s
									// 		0x82 => Early 20th Century 1980
									// 		0x88 => Early 20th Century 1979
									// 		0x83 => Present 2000s

function getCurrentPresentTimeHours() =>	// $AA12B0: [32-bit] Time in present: hours
	dword(0xAA12B0)

function getCurrentPresentTimeMinutes() =>	// $AA12B4: [32-bit] Time in present: minutes
	dword(0xAA12B4)

function getCurrentPresentTimeSeconds() =>	// $AA12B8: [32-bit] Time in present: seconds
	dword(0xAA12B8)

function getCurrentPresentTimeDays() =>		// $AA12AC: [32-bit] Time in present: days
	dword(0xAA12AC)
function getCurrentPresentTimeMonths() =>	// $AA12A8: [32-bit] Time in present: months
	dword(0xAA12A8)
function getCurrentPresentTimeYears() =>	// $AA12A4: [32-bit] Time in present: years
	dword(0xAA12A4)

// *********************
// ÷ INTERACTIONS IDs ÷
// *********************
const_NPCs = {
	// "xxxtemplatexxxx": { 
	// 	"ID": 0x00000, "Appearance": {
	// 		"xxxxxtemplatexxxxxxx": {"MemAddrTalkCount": 0x000000, "MaxTalkCount": 0000}}},
	"BlondeYoungBoy_Present": { 
		"ID": 0x187, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"MemAddrTalkCount": 0xA9EEF8, "MaxTalkCount": 2}}},
	"BrunetteMother_Present": { 
		"ID": 0x46,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"MemAddrTalkCount": 0xA9EE92, "MaxTalkCount": 1}}},
	"BrunetteYoungGirl_Present": { 
		"ID": 0x42,	"Appearance": {
			"Chap4_WearingPerformerOutfit": {"MemAddrTalkCount": 0xA9EE7F, "MaxTalkCount": 1}}},
	"BlondeOldWomanOrangeSweater_Present": { 
		"ID": 0x44, "Appearance": {
			"Chap4_WearingPerformerOutfit": {"MemAddrTalkCount": 0xA9EE88, "MaxTalkCount": 1}}},
	"BrunetteAdultManGlasses_Present": { 
		"ID": 0x195, "Appearance": {
			"Chap4_WearingPerformerOutfit": always_false()}},	// Has no memory address for talk count
	"BlondeElderlyWoman_Present": { 
		"ID": 0x183, "Appearance": {
			"Chap4_WearingPerformerOutfit": always_false()}},	// Has no memory address for talk count
	"BroadDelinquent_Present": { 
		"ID": 0x10, "Appearance": {
			"Chap7_CarPark": {"MemAddrTalkCount": 0xA9EE4C, "MaxTalkCount": 1}}},
	"SlimDelinquent_Present": { 
		"ID": 0x13, "Appearance": {
			"Chap7_CarPark": {"MemAddrTalkCount": 0xA9EE51, "MaxTalkCount": 1}}},
	"CoatedWoman_Present": { 
		"ID": 0x57,	"Appearance": {
			"Chap1Prologue_TownSquare": {"MemAddrTalkCount": 0xA9EE28, "MaxTalkCount": 2},
			"Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar": {"MemAddrTalkCount": 0xA9EE2C, "MaxTalkCount": 2},
			"Chap5_NearCafeSonne": {"MemAddrTalkCount": 0xA9EE31, "MaxTalkCount": 1},
			"Chap7_SouthGate": {"MemAddrTalkCount": 0xA9EE2F, "MaxTalkCount": 2}}},
	"CoatedMan_Present": { 
		"ID": 0x56, "Appearance": {
			"Chap1Prologue_NearBar": {"MemAddrTalkCount": 0xA9EE1D, "MaxTalkCount": 2},
			"Chap3_NearAntiqueShop": {"MemAddrTalkCount": 0xA9EE20, "MaxTalkCount": 2},
			"Chap4_HaupStrUnderArch": {"MemAddrTalkCount": 0xA9EE21, "MaxTalkCount": 2},
			"Chap5_NorthEastGate_BrumLibrary": {"MemAddrTalkCount": 0xA9EE25, "MaxTalkCount": 1},
			"Chap5_NorthEastGate_BrumMuseum": {"MemAddrTalkCount": 0xA9EE26, "MaxTalkCount": 2},
			"Chap7_NorthWestGate": {"MemAddrTalkCount": 0xA9EE24, "MaxTalkCount": 1}}},
	"JoggingMan_Present": {
		"ID": 0x58},
	"JoggingMan_80s": {
		"ID": 0x59},
	"Barman_80s": { 
		"ID": 0xc, "Appearance": {
			"InsideBar_UsePocketWatchOrEgg": {"MemAddrTalkCount": 0xA9EE49, "MaxTalkCount": 1}}},	// Counts for chap 6-7-8
	"OlderMan_80s": { 
		"ID": 0x18d, "Appearance": {
			"Chap6_CafeSonne": {"MemAddrTalkCount": 0xA9EF43, "MaxTalkCount": 2}}},
	"YoungCoupleWoman_MiddleAges": { 
		"ID": 0x197, "Appearance": {
			"Chap2_WestGate_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF7C, "MaxTalkCount": 1},
			"Chap2_WestGate_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF7D, "MaxTalkCount": 1},
			"Chap2_EastNearHay_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF7E, "MaxTalkCount": 1},
			"Chap3_NearNorthEastGate_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF7E, "MaxTalkCount": 1},
			"Chap3_NearNorthEastGate_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF80, "MaxTalkCount": 1},
			"Chap3_OutsideChurch_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF81, "MaxTalkCount": 1},
			"Chap4_OutsideChurch_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF82, "MaxTalkCount": 1},
			"Chap4_OutsideChurch_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF83, "MaxTalkCount": 1},	
			"Chap4_NearBakery_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF84, "MaxTalkCount": 1},	//	WARNING => uses same MemAddrTalkCount as Chap7_TownSquare
			"Chap7_TownSquare": {"MemAddrTalkCount": 0xA9EF84, "MaxTalkCount": 1},						//	WARNING => uses same MemAddrTalkCount as Chap4_OutsideChurch_AfterTalkingToBoth
			"Chap7_TownSquare_Choice": {"MemAddrTalkCount": 0xA9EF85, "MaxTalkCount": 2}}},
	"YoungCoupleMan_MiddleAges": { 
		"ID": 0x198, "Appearance": {
			"Chap2_EastNearHay_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF69, "MaxTalkCount": 1},
			"Chap2_EastNearHay_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF6A, "MaxTalkCount": 1},
			"Chap2_WestGate_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF6B, "MaxTalkCount": 1},
			"Chap3_NearWell_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF6C, "MaxTalkCount": 1},
			"Chap3_NearWell_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF6D, "MaxTalkCount": 1},
			"Chap3_TownSquare_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF6E, "MaxTalkCount": 1},
			"Chap4_TownSquare_BeforeTalkingToBoth": {"MemAddrTalkCount": 0xA9EF6F, "MaxTalkCount": 1},
			"Chap4_TownSquare_AfterTalkingToBoth": {"MemAddrTalkCount": 0xA9EF70, "MaxTalkCount": 1},
			"Chap4_NearBakery_AfterLocationSwitch": {"MemAddrTalkCount": 0xA9EF71, "MaxTalkCount": 1},
			"Chap5_NearSouthEastGate": {"MemAddrTalkCount": 0xA9EF72, "MaxTalkCount": 2},
			"Chap7_OutsideChurch": {"MemAddrTalkCount": 0xA9EF74, "MaxTalkCount": 2},
			"Chap8_OutsideChurch_AfterExperiment_WomanTruthful": {"MemAddrTalkCount": 0xA9EF78, "MaxTalkCount": 1}}},
	"EccentricGirl_MiddleAges": { 
		"ID": 0x2e, "Appearance": {
			"Chap2_TownSquare": {"MemAddrTalkCount": 0xA9EE70, "MaxTalkCount": 1}}},
	"AspiringApprentice_MiddleAges": {
		"ID": 0x5d, "Appearance": {
			"Chap2_SouthEastGate": {"MemAddrTalkCount": 0xA9EE3F, "MaxTalkCount": 1}}}}
const_interactables = {
	"Antique_FranssenShopSign": 0x8e,
	"Antique_Rope": 0x98,
	"Antique_Antidote": 0x79,
	"Antique_Mask": 0xc6,
	"Painting_SquireCrest": 0x164,
	"Painting_TownSquare": 0x165,
	"Painting_AlchemyLab": 0x16a,
	"Painting_Performer": 0x166,
	"Painting_CollapsedHouse": 0x168,
	"Painting_TowerView": 0x163,
	"Painting_LandscapeTown": 0x169,
	"Painting_Alchemist": 0x167}

function getMaxTalkCountFor(string_NPC, string_appearance) => const_NPCs[string_NPC]["Appearance"][string_appearance]["MaxTalkCount"]

function isNPCtalkCountIncreasingToMax(string_NPC, string_appearance) {
	let_NPCappearance = const_NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	let_maxTalkCount = let_NPCappearance["MaxTalkCount"]
	return 
		let_talkCount == let_maxTalkCount &&
		prev(let_talkCount) == let_maxTalkCount - 1}

function isNPCtalkCountIncreasing(string_NPC, string_appearance) {
	let_NPCappearance = const_NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	return 
		let_talkCount > prev(let_talkCount)}

function isNPCtalkCountAtMax(string_NPC, string_appearance) {
	let_NPCappearance = const_NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	return 
		let_talkCount == const_NPCs[string_NPC]["Appearance"][string_appearance]["MaxTalkCount"]}

function isTalkingTo_shortHand(string_NPC) => 		// $A9EFF4: Copy of [32-bit] NPC ID (refer to notes @ 0xa9efdc)
	dword(0xA9EFF4) == const_NPCs[string_NPC]["ID"]	// - Resets to 0x0 when interaction is done

function isTalkingTo(string_NPC) {						// $A9EFDC: [25-bit] Pointer - Interactions
	// & 0x1ffffff => masks 32-bit value to 25-bit;		// 		+0x0 - [32-bit] NPC ID	
	//		PSP uses 25-bit pointers					// 		| - Unique per interactable NPC or environment item
	let_maskedPointer = dword(0xA9EFDC) & 0x1ffffff		// 		| - This value is copied to 0xa9eff4 (refer to notes)
	return 
		const_NPCs[string_NPC]["ID"] == dword(let_maskedPointer)}

function isInteractingWith_shortHand(string_interactable) => 
	dword(0xA9EFF4) == const_interactables[string_NPC]

function isInteractingWith(string_interactable) {
	let_maskedPointer = dword(0xA9EFDC) & 0x1ffffff
	return const_interactables[string_interactable] == dword(let_maskedPointer)}

function isInteractionChapterId(int_Id) {			// $A9EFE0: [25-bit] Pointer - Interactions
	let_maskedPointer = dword(0xA9EFE0) & 0x1ffffff	// 		+0x0 - [32-bit] Interaction Chapter ID
	return dword(let_maskedPointer) == int_Id}		//		| - Each chapter has a different value

function isInteractionId(int_Id) {
	let_maskedPointer = dword(0xA9EFE4) & 0x1ffffff	// $A9EFE4: [25-bit] Pointer - Interactions
	return dword(let_maskedPointer) == int_Id}		// 		- Pointer resets to 0x0 when interaction is done
													// 		+0x0 - [32-bit] Interaction ID
// -------------------------------------
function isLostYoungCoupleProgressChap2(int_flagValue) => 	//	$A9EF89: [8-bit Current Playthrough Flag]  Progress of Young Couple sidequest: Chapter 2
	byte(0xA9EF89) == int_flagValue							// 		0x1 => has talked with 0xa9ef69 AND 0xa9ef7c
															// 		0x2 => has talked with 0xa9ef6a AND 0xa9ef7d
															// 		0x3 => Young couple - Middle Ages - Chapter 2 - have switched positions

function isLostYoungCoupleProgressChap3(int_flagValue) => 	//	$A9EF8A: [8-bit Current Playthrough Flag]  Progress of Young Couple sidequest: Chapter 3
	byte(0xA9EF8A) == int_flagValue							// 		0x1 => has talked with 0xa9ef6c AND 0xa9ef7f
															// 		0x2 => has talked with 0xa9ef6d AND 0xa9ef80
															// 		0x3 => Young couple - Middle Ages - Chapter 3 - have changed positions

function isLostYoungCoupleProgressChap4(int_flagValue) => 	//	$A9EF8B: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 4
	byte(0xA9EF8B) == int_flagValue							//		0x1 => has talked with 0xa9ef82 AND 0xa9ef6f
															// 		0x2 => has talked with 0xa9ef83 AND 0xa9ef70
															// 		0x3 => Young couple - Middle Ages - Chapter 4 - have changed positions/respawned

function isManToldLoversNeverDestinedMeet() => 		// $A9EF8F: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 8
	bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) ==0  		// 		bit 0 => told the man about the lovers never destined to meet
													// 		bit 1 => told the man to get over it

function isWomanAdvisedBeTruthful() => 	//	$A9EF8E: [8-bit Current Playthrough Flag] Progress of Young Couple sidequest: Chapter 7
	byte(0xA9EF8E) >= 0x1				// 		>= 0x1 => advised woman to be truthful
										// 		- Increases by 0x1 after telling woman to be truthful, to a max of 0x1
										//	$SAME-MEMORY-ADDRESS-AS-ABOVE: [8-bit] NPC Talk Count - Young couple man - Middle Ages - Chapter 8 - Outside church - Before Experiment - Only available when this memory address was already >= 0x1
										// 		- Dual purpose memory address
										//		- Talk Counts add on top of above explained count
										// 		- If count was 0 from start, refer to 0xa9ef77
										// 		- Increases by 0x1 with each interaction with the man starts at 0x1 and to a max of 0x3


// ****************************
// ÷ CUTSCENE IDENTIFICATION ÷
// ****************************
function isFullCutsceneActive() => 					// $A9ED26: Flag: Is cutscene active (preferred)
	byte(0xA9ED26) == 0x5							// 		- 0x00 => no cutscene active
													// 		- 0x01 => black bars (small) cutscene active/transitional value between active-inactive
function isFullCutsceneSequenceEnding() => 			// 		- 0x05 => cutscene active
	prev(byte(0xA9ED26)) > 0x0 && byte(0xA9ED26) == 0x0		

function isCutsceneSectionEnding() => 
	prev(byte(0xA9ED26)) > 0x3 && 0x3 >= byte(0xA9ED26) && byte(0xA9ED26) > 0x0	

function isSmallCutsceneActive() => 
	byte(0xA9ED26) == 0x1

function isNoCutsceneActive() => 
	byte(0xA9ED26) == 0
// -------------------------------------
function isCurrentCutsceneMasterId(int_Id) => 	// $A9ECBC: [32-bit] Cutscene MASTER ID (preferred)
	dword(0xA9ECBC) == int_Id					// 		- Identifies a cutscene sequence

function isPriorCutsceneMasterId(int_Id) => 
	prior(dword(0xA9ECBC)) == int_Id

function isNewCutsceneLoading() => 
	prev(dword(0xA9ECBC)) != dword(0xA9ECBC)


function isCurrentCutsceneSectionId_1(int_Id) => 	// $A9ECC0: [16-bit] Cutscene Section ID_1
	word(0xA9ECC0) == int_Id						// 		- Identifies a section from the current cutscene
function isPriorCutsceneSectionId_1(int_Id) => 
	prior(word(0xA9ECC0)) == int_Id		


function isCurrentCutsceneSectionId_2(int_Id) => 	// $A9ECC2: [16-bit] Cutscene Section ID_2
	word(0xA9ECC2) == int_Id

function isPriorCutsceneSectionId_2(int_Id) => 
	prior(word(0xA9ECC2)) == int_Id

function isCurrentCutsceneMasterDataId(int_Id) {		// $A9ECC8: [25-bit] Pointer
	// & 0x1ffffff => masks 32-bit value to 25-bit;		// 		+0x0 - Refers to start of dynamic cutscene memory data block - Data below changes on new cutscene loaded in
	//		PSP uses 25-bit pointers			 		// 		+0x8 - [32-bit] Cutscene Master Data ID
	let_maskedPointer = dword(0xA9ECC8) & 0x1ffffff	
	return dword(let_maskedPointer + 0x8) == int_Id}

function isCurrentCutsceneSectionDataId(int_Id) {		// $A9ECCC: [25-bit] Pointer
	let_maskedPointer = dword(0xA9ECCC) & 0x1ffffff		// 		+0x0 - Data lower then this point changes, when a next section in the cutscene starts
	return dword(let_maskedPointer + 0x8) == int_Id}	// 		+0x8 - [32-bit] Cutscene Section Data ID

function isCurrentMinorCutsceneId(int_Id, int_offset) {		// $A9ECD4: [25-bit] Pointer - when a cutscene is active
	let_maskedPointer = dword(0xA9ECD4) & 0x1ffffff			// +0x0 - Data lower than this point can be used as Minor Cutscene IDs
	return dword(let_maskedPointer + int_offset) == int_Id}	// +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID



// ******************************
// ÷ MAP/SCENE/AREA IDENTIFIER ÷
// ******************************
const_mapIDs= {	// list not complete, add as is necessary
	"PresentDayCity": 0x375,
	"PresentNightCityPM": 0x44,
	"PresentNightCityAM": 0x3,
	"CafeSonnePresent": 0x10,
	"80sColdCity": 0x465,
	"70sNightCity": 0x31d,
	"1900sCity": 0x239,
	"1900sBrumMansion": 0x603,
	"ColdCityBar": 0xf,
	"CafeSonne80s": 0x15,
	"MedievalCity": 0x3f3,
	"MedievalNightCity": 0x33c,
	"ExplodedAlchemistBasement": 0x217,
	"MedievalChurch": 0x8e,
	"PresentTownHall": 0x16,
	"BrumEstateIndoors1900": 0x603,
	"AntiqueShopEule80s": 0x7a,
	"AntiqueShopEulePresent": 0x6f,
	"BrumMuseumUpstairsRoom1Night": 0x159,
	"BrumMuseumUpstairsRoom1Day": 0x38,
	"BrumMuseumUpstairsRoom2Night": 0x224,
	"BrumMuseumUpstairsRoom2Day": 0x1bd,
	"BrumMuseumUpstairsRoom3Night": 0x140,
	"BrumMuseumUpstairsRoom3Day": 0xcd,
	"BrumMuseumDownstairsRoomNight": 0x32,
	"BrumMuseumDownstairsRoomDay": 0x2ed}
function isCurrentMapScene(string_mapId) => 	// $A82E48: [32-bit] Current loaded scene/map/scenario
	dword(0xA82E48) == const_mapIDs[string_mapId]	


// ******************
// ÷ CHAPTER LOGIC ÷
// ******************
const_chapterIDs = {
	"Prologue": 0x1,	// Also counts for EX chapter
	"Chapter1": 0x2,
	"Chapter2": 0x3,
	"Chapter3": 0x4,
	"Chapter4": 0x5,
	"Chapter5": 0x6,
	"Chapter6": 0x7,
	"Chapter7": 0x8,
	"Chapter8_Ancestress": 0x9,		// If in chapter 5, player told Margarette she's your ancestress
	"Epilogue_Ancestress": 0xa,
	"Chapter8_NoAncestress": 0xb,	// If in chapter 5, player told Margarette she's NOT your ancestress
	"Epilogue_NoAncestress": 0xc}
function getChapterId() => 	// $B95704: [8-bit] Chapter ID
	byte(0xB95704)
function isCurrentChapter(string_chapter) {	
	if (string_chapter == "Chapter8") {
		return
			(getChapterId() == const_chapterIDs["Chapter8_Ancestress"] || getChapterId() == const_chapterIDs["Chapter8_NoAncestress"])
	} else if (string_chapter == "Epilogue") {
		return
			(getChapterId() == const_chapterIDs["Epilogue_Ancestress"] || getChapterId() == const_chapterIDs["Epilogue_NoAncestress"])
	} else {
		return
			getChapterId() == const_chapterIDs[string_chapter]
	}} 

function isChapterFinishing(string_chapter) { 
	if (string_chapter == "Chapter7") {
		return 
			prev(getChapterId()) == const_chapterIDs[string_chapter] &&
			(
				getChapterId() == const_chapterIDs["Chapter8_Ancestress"] 	|| 
				getChapterId() == const_chapterIDs["Chapter8_NoAncestress"] 
			)
	} else if (string_chapter == "Chapter8_Ancestress"){
		return
			prev(getChapterId()) == const_chapterIDs[string_chapter] &&
			getChapterId() == const_chapterIDs["Epilogue_Ancestress"]
	} else if (string_chapter == "Chapter8_NoAncestress"){
		return
			prev(getChapterId()) == const_chapterIDs[string_chapter] &&
			getChapterId() == const_chapterIDs["Epilogue_NoAncestress"]
	} else {
		return
			prev(getChapterId()) == const_chapterIDs[string_chapter] &&
			getChapterId() == const_chapterIDs[string_chapter] + 0x1
	}}

function isChapterChanging() => 
	getChapterId() != prev(getChapterId())

function isChapterChangingTo(string_chapter) {
	let_chapterId = 0
	if (string_chapter == "Chapter8") {
		let_chapterId = getChapterId()
	} else if (string_chapter == "Epilogue") {
		let_chapterId = getChapterId()
	}
	return 
		prev(getChapterId()) != let_chapterId &&
		getChapterId() == let_chapterId}


// ********************
// ÷ INVENTORY LOGIC ÷
// ********************
//	- itemScrollBarId => Id of the item in the inventory scrollbar menu
//	- inventoryMemoryAddress => Memory address [bit 0] = 1 => this item is in players inventory
//	- isDefaultItem => true, when player gets this item at start of game
const_inventoryItems = { 
	// "___Template___": {
	// 	"memAddress_Flag_isInInventory": 0x000000,	// $AAAAAA: [Bit 0] ___Template___
	// 	"itemScrollBarId": 0x00000,
	// 	"isDefaultItem": false}, 
	"D-pad": {	// In PSP version this is called Z-Pad
		"memAddress_Flag_isInInventory": 0xA9F034,	// $A9F034: [Bit 0] Z-pad/D-pad
		"itemScrollBarId": 0x0,
		"isDefaultItem": true}, 
	"Cellphone": {
		"memAddress_Flag_isInInventory": 0xA9F035,	// $A9F035: [Bit 0] Cellphone
		"itemScrollBarId": 0x1,
		"isDefaultItem": true},
	"Map": {
		"memAddress_Flag_isInInventory": 0xA9F04C,	// $A9F04C: [Bit 0] City map
		"itemScrollBarId": 0x18,
		"isDefaultItem": true},
	"Notebook": {
		"memAddress_Flag_isInInventory": 0xA9F04F,	// $A9F04F: [Bit 0] Notebook
		"itemScrollBarId": 0x1b,
		"isDefaultItem": true},	
	"Postcard": {
		"memAddress_Flag_isInInventory": 0xA9F04A,	// $A9F04A: [Bit 0] Letter to dana
		"isDefaultItem": true},
	"OldMap": {
		"memAddress_Flag_isInInventory": 0xA9F04E,	// $A9F04E: [Bit 0] Old City Map
		"isDefaultItem": false},
	"OrnamentalEgg": {
		"itemScrollBarId": 0x2,
		"memAddress_Flag_isInInventory": 0xA9F036,	// $A9F036: [Bit 0] Cake
		"isDefaultItem": false},
	"FryingPan": {
		"itemScrollBarId": 0x4,
		"memAddress_Flag_isInInventory": 0xA9F038,	// $A9F038: [Bit 0] Frying pan
		"isDefaultItem": false},
	"Sign": {
		"itemScrollBarId": 0x5,
		"memAddress_Flag_isInInventory": 0xA9F039,	// $A9F039: [Bit 0] Photo shop sign
		"isDefaultItem": false},
	"Lighter": {
		"itemScrollBarId": 0x6,
		"memAddress_Flag_isInInventory": 0xA9F03A,	// $A9F03A: [Bit 0] Lighter
		"isDefaultItem": false},
	"SquireCrest": {
		"itemScrollBarId": 0xf,
		"memAddress_Flag_isInInventory": 0xA9F043,	// $A9F043: [Bit 0] Squire's crest
		"isDefaultItem": false},
	"Antidote": {
		"itemScrollBarId": 0x11,
		"memAddress_Flag_isInInventory": 0xA9F045,	// $A9F045: [Bit 0] Antidote
		"isDefaultItem": false},
	"Jugglery": {
		"itemScrollBarId": 0xc,
		"memAddress_Flag_isInInventory": 0xA9F040,	// $A9F040: [Bit 0] Jugglery
		"isDefaultItem": false},
	"Cake": {
		"itemScrollBarId": 0x13,
		"memAddress_Flag_isInInventory": 0xA9F047,	// $A9F047: [Bit 0] Cake
		"isDefaultItem": false},
	"PhilosopherStone": {
		"memAddress_Flag_isInInventory": 0xA9F03D,	// $A9F03D: [Bit 0] Philosopher's stone
		"isDefaultItem": false},
	"BLackWhitePhoto": {	// This one switches with the other photo once the picture is taken
		"memAddress_Flag_isInInventory": 0xA9F03B,	// $A9F03B: [Bit 0] Black and white photo without performer
		"isDefaultItem": false},
	"BLackWhitePhotoWithPerformer": {	
		"memAddress_Flag_isInInventory": 0xA9F03C,	// $A9F03C: [Bit 0] Black and white photo with performer
		"isDefaultItem": false},
	"OldRope": {
		"memAddress_Flag_isInInventory": 0xA9F03F,	// $A9F03F: [Bit 0] Old Rope
		"isDefaultItem": false},
	"NewRope": {
		"memAddress_Flag_isInInventory": 0xA9F03E,	// $A9F03E: [Bit 0] New Rope
		"isDefaultItem": false},
	"Comb": {
		"memAddress_Flag_isInInventory": 0xA9F041,	// $A9F041: [Bit 0] Comb
		"isDefaultItem": false},
	"AlchemyBook": {
		"memAddress_Flag_isInInventory": 0xA9F042,	// $A9F042: [Bit 0] Old alchemist book
		"isDefaultItem": false},
	"EggPocketWatch": {
		"memAddress_Flag_isInInventory": 0xA9F044,	// $A9F044: [Bit 0] Egg shaped pocket watch
		"itemScrollBarId": 0x10,
		"isDefaultItem": false},
	"Meat": {
		"memAddress_Flag_isInInventory": 0xA9F046,	// $A9F046: [Bit 0] Scrap of meat
		"isDefaultItem": false},
	"LabKey": {
		"memAddress_Flag_isInInventory": 0xA9F048,	// $A9F048: [Bit 0] Lab key
		"isDefaultItem": false},
	"TowerKey": {
		"memAddress_Flag_isInInventory": 0xA9F049,	// $A9F049: [Bit 0] Tower key
		"isDefaultItem": false},
	"Ladder": {
		"memAddress_Flag_isInInventory": 0xA9F04D,	// $A9F04D: [Bit 0] Ladder
		"isDefaultItem": false},
	"LetterToDana": {
		"memAddress_Flag_isInInventory": 0xA9F050,	// $A9F050: [Bit 0] Postcard
		"isDefaultItem": false},
	"Kitten": {
		"memAddress_Flag_isInInventory": 0xA9F04B,	// $A9F04B: [Bit 0] Kitten
		"isDefaultItem": false}}

function isCurrentSelectedInventoryItem(string_item) => 					// $A9F111: [8-bit] Currently selected item ID in inventory
	byte(0xA9F111) == const_inventoryItems[string_item]["itemScrollBarId"] 

function isItemInInventory(string_item) => 
	bit0(const_inventoryItems[string_item]["memAddress_Flag_isInInventory"]) == 1


// ***********************
// ÷ BOTTOM SCREEN TEXT ÷
// ***********************
// - Memory higher than this address (visually lower in the memory inspector) correlates to a character print system 
// => It works via a transparant character set image, that is masked to show only 1 character at a time. 
// 		Functional with offset and different character sets (ex. latin, chinese)
function isBottomScreenTextId(int_id) =>	// $AC31E4:  Bottom screen text ID
	dword(0xAC31E4) == int_id				//		- Identifies a series of text lines at the bottom of the screen (during cutscenes or in a menu)
											//		- This ID does not change on each new text change, but it does change often between text changes

function isPriorMinimumAmountOfCharactersOnBottomScreen(int_characterCount) { // Count starts at 1
	let_offsetOfLastCharacterPrint = (int_characterCount - 1) * 0x10 + 0x4
	return 
		prior(dword(0xAC31E4 + let_offsetOfLastCharacterPrint)) != 0x0 &&
		prior(dword_be(0xAC31E4 + let_offsetOfLastCharacterPrint + 0xa)) != 0x0}

function isNoCharactersOnBottomScreen() {
	return 
		dword(0xAC31E4 + 0x4) == 0x0 &&
		dword_be(0xAC31E4 + 0xa) == 0x0 &&	
		dword(0xAC31E4 + 0x10) == 0x0}
// -------------------------------------
// Use below dictionary as an object definition to pass params to function isCharacterPrinted()
// 		objDict_characterPrintData = {
// 			"index": 0000,	// First printed character starts at 0
// 			"printXaxis": 0x0,
// 			"imageOffsetXaxis": 0x0,
// 			"imageOffsetYaxis": 0x0,
// 			"imageUnmaskWidth": 0x0,
// 			"printYaxis": 0x0}
function isCharacterPrinted(objDict_characterPrintData) {	
	function let_charPrintDataToDwordBE(objDict_characterPrintData) {
		let_dwordBE = objDict_characterPrintData["imageOffsetXaxis"] * 0x1000000
		let_dwordBE = let_dwordBE + objDict_characterPrintData["imageOffsetYaxis"] * 0x10000
		let_dwordBE = let_dwordBE + objDict_characterPrintData["imageUnmaskWidth"] * 0x100
		let_dwordBE = let_dwordBE + objDict_characterPrintData["printYaxis"]
		return let_dwordBE}
	let_offsetOfCharacterPrint = objDict_characterPrintData["index"] * 0x10 + 0x4
	return 
		byte(0xAC31E4 + let_offsetOfCharacterPrint + 0x6) == objDict_characterPrintData["printXaxis"] &&
		dword_be(0xAC31E4 + let_offsetOfCharacterPrint + 0xa) == let_charPrintDataToDwordBE(objDict_characterPrintData)}

function isPriorCharacterPrinted(objDict_characterPrintData) {	
	function let_charPrintDataToDwordBE(objDict_characterPrintData) {
		let_dwordBE = objDict_characterPrintData["imageOffsetXaxis"] * 0x1000000
		let_dwordBE = let_dwordBE + objDict_characterPrintData["imageOffsetYaxis"] * 0x10000
		let_dwordBE = let_dwordBE + objDict_characterPrintData["imageUnmaskWidth"] * 0x100
		let_dwordBE = let_dwordBE + objDict_characterPrintData["printYaxis"]
		return let_dwordBE	}
	let_offsetOfCharacterPrint = objDict_characterPrintData["index"] * 0x10 + 0x4
	return 
		prior(byte(0xAC31E4 + let_offsetOfCharacterPrint + 0x6)) == objDict_characterPrintData["printXaxis"] &&
		prior(dword_be(0xAC31E4 + let_offsetOfCharacterPrint + 0xa)) == let_charPrintDataToDwordBE(objDict_characterPrintData)}


// ***************
// ÷ EXTRA MENU ÷
// ***************
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function isInExtraMenu() {							// $AC3170: [25-bit] Pointer - When in Extra menu
	let_maskedPointer = dword(0xAC3170) & 0x1ffffff	// 		- Extra menu is only visible once at least one is ending is finished
	return											// 		+0x4 - [32-bit] Extra Menu: Highlighted item
		dword(let_maskedPointer + 0x4) <= 0x4 &&	// 		| - 0x0 => Event viewer (replay unlocked cutscenes)
		dword(let_maskedPointer + 0x14) <= 0x5 &&	// 		| - 0x1 => Ending files (replay ending cutscenes)
		dword(let_maskedPointer + 0x48) <= 0xb}		// 		| - 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
													// 		| - 0x3 => Sound Mode (Play sound effects & music)
													// 		| - 0x4 => Exit (back to Title Screen)
													// 		+0x14 - [32-bit] Extra Menu: Highlighted ending file
													// 		| - 0x0 => ending A			| - 0x3 => ending D
													// 		| - 0x1 => ending B			| - 0x4 => ending E	
													// 		| - 0x2 => ending C			| - 0x5 => ending EX
													// 		+0x48 - [32-bit] Results Menu/Event Viewer: Highlighted chapter
													// 		| - 0x0 => Prologue			| - 0x9 => Epilogue
													// 		| - 0x1 => Chapter 1		| - 0xa => Total
													// 		| - ...						| - 0xb => Exit
													// 		| - 0x8 => Chapter 8
function isEventViewerActive() =>				// $1FFF130: [32-bit] Flag -> Event viewer (preferred)
	dword(0x1FFF130) == 0x21 && isInExtraMenu()	// 		0x21 => event viewer menu on screen OR a cutscene is being watched via this menu
												// 		- other values => not in event viewer
function isInResultsMenu() => 					// $AC49F4: [32-bit] Menu ID
	dword(0xAC49F4) == 0x16	&& isInExtraMenu()	// 		0xe => at title screen					0x16 => at results menu
												// 		0x4 => at extra menu					0x1a => In sound mode menu
												// 		0x12 => at event viewer menu			...

function isResultsMenuHighlightedChapter(string_chapter) {
	let_maskedPointer = dword(0xAC3170) & 0x1ffffff
	let_resultsMenuHighlightedChapterId = 0 
	if (string_chapter == "Chapter8") {
		let_resultsMenuHighlightedChapterId = 0x8
	} else if (string_chapter == "Epilogue") {
		let_resultsMenuHighlightedChapterId = 0x9
	} else if (string_chapter == "Total") {
		let_resultsMenuHighlightedChapterId = 0xa
	} else {
		let_resultsMenuHighlightedChapterId = const_chapterIDs[string_chapter] - 1
	}
	return			
		isInResultsMenu() &&
		dword(let_maskedPointer + 0x48) == let_resultsMenuHighlightedChapterId}
// -------------------------------------
const_endingFileIDs = {
	"A": 0x0,
	"B": 0x1,
	"C": 0x2,
	"D": 0x3,
	"E": 0x4,
	"EX": 0x5}

function isViewingEndingFileInExtraMenu(string_endingChar) {	// $AC3178: [25-bit] Pointer - Ending File
	let_maskedPointer = dword(0xAC3178) & 0x1ffffff				//		- Resets to 0x0, when no ending file is on screen
	let_endingFileID = const_endingFileIDs[string_endingChar]	// 		+0x10 - [8-bit] Ending File ID
	return														// 		| - 0x0 => ending file A  	| - 0x4 => ending file E
		isInExtraMenu() &&										// 		| - 0x1 => ending file B	| - 0x5 => ending file EX
		byte(let_maskedPointer + 0x10) == let_endingFileID}		// 		| - ...		
																// 		+0x8 - [32-bit] Ending file timer
																// 		+0xc - [16-bit] Ending file text ID


// ****************
// ÷ OTHER LOGIC ÷
// ****************
function getCurrentEnergyUnits() =>		// $A9DAA8: Number of energy units in possession 
	byte(0xA9DAA8)						//		- Used for the time travel machine (Z-Pad)
										//		- Min => 0x0 		Max => 0x0a
function isEnergyUnitsIncreasing() => 		
	getCurrentEnergyUnits() > prev(getCurrentEnergyUnits())	

function isEnergyUnitsIncreased() => 
	getCurrentEnergyUnits() > prior(getCurrentEnergyUnits())

function isEnergyUnitsDecreasing() => 
	getCurrentEnergyUnits() < prev(getCurrentEnergyUnits())

function isEnergyUnitsChanging() => 
	getCurrentEnergyUnits() != prev(getCurrentEnergyUnits())

// -------------------------------------
function isInGame() => low4(0xA9EDDC) != 0	// $A9EDDC: [Lower4] Flag -> is in-game
											// 		= 0 => at title screen
											// 		> 0 => in-game

function isGoingToTitleSCreen() { return
	low4(0xA9EDDC) == 0 && prev(low4(0xA9EDDC)) > 0}

function isAtTitleScreen() { return						// $1FFF5F8: [32-bit] UI/Menu ID
	dword(0x1FFF5F8) == 0x11 &&							// 	0x11 => title screen			any other value => something else on screen
	0x0 < byte(0x1FFF604) && dword(0x1FFF604) < 0x5}	// $1FFF604: [8-bit] Selected submenu at title screen
														// 	0x1 => Start		0x3 => Option
														// 	0x2 => Continue		0x4 => Extra

function isMainSaveLoaded() {						// $AA2998: [25-bit] Pointer - is main save file loaded (at first startup of game)
	let_maskedPointer = dword(0xAA2998)	& 0x1ffffff	//		+0x4 - [Bit 0] => main save is loaded
	return 											//		| - Data around this memory address is set on startup or reset
		bit0(let_maskedPointer + 0x4) == 1}

function isVideoActive() {								// $8FFEF0: [25-bit] Pointer - Video data (intro and credits)
	let_maskedPointer = dword(0x8FFEF0) & 0x1FFFFFF		// 		+0x18 - [32-bit Flag] 0x101 => video is active
	return 												// 		+0x2c - [32-bit Flag] 0x41 => video is active
		dword(let_maskedPointer + 0x18) == 0x101 &&		// 		+0x40 - [32-bit] Video timer
		dword(let_maskedPointer + 0x2c) == 0x41}

function isInGamePauseMenuActive() =>	// $B91514 + $B91518: [Bit Flag] bit 0 => in-game pause menu
	bit0(0xB91514) == 1 && 
	bit0(0xB91518) == 1


// *******************************
// ÷ CUTSCENE/CHOICES BIT FLAGS ÷
// *******************************
const_endingBitFlagsMemoryAddresses = {
	"A": 0xAA1154,	// $AA1154: [Bit Flag] bit 0 => Ending A unlocked
	"B": 0xAA1155,	// $AA1155: [Bit Flag] bit 0 => Ending B unlocked
	"C": 0xAA1156,	// $AA1156: [Bit Flag] bit 0 => Ending C unlocked
	"D": 0xAA1157,	// $AA1157: [Bit Flag] bit 0 => Ending D unlocked
	"E": 0xAA1158,	// $AA1158: [Bit Flag] bit 0 => Ending E unlocked
	"EX": 0xAA1159}	// $AA1159: [Bit Flag] bit 0 => Ending EX unlocked

function isEndingUnlocked(string_EndingCharacter) =>
	bit0(const_endingBitFlagsMemoryAddresses[string_EndingCharacter]) == 1

function isExChapterUnlocked() => 
	all_of(const_endingBitFlagsMemoryAddresses, (endingChar) => bit0(const_endingBitFlagsMemoryAddresses[endingChar]) == 1)

function isPrologueInExMode() => 	// $A9ED98: [Current Playthrough Bit Flags]: EX Chapter
	bit7(0xA9ED98) == 1 			//		bit 7 => EX Chapter is active // 2nd dialogue option "Oh, Homunculus" => activates EX chapter
// -------------------------------------
function isTreeReplacedByStatue() => 		// $A9EDA0: [Current Playthrough Bit Flags]: Chapter 2
	bit2(0xA9EDA0)	== 0					// 		bit 0 => acquired ladder
											// 		bit 1 = 0 => LIGHTER used to scare crowd
function isTreeReplacedByFlowers() => 		// 		bit 1 = 1 => TELEPHONE used 
	bit2(0xA9EDA0) == 1						// 		bit 2 = 0 => Chosen to plant STATUE instead of flowers	
											// 		bit 2 = 1 => Chosen to plant FLOWERS instead of statue
function isCrowdScaredWithCellphone() => 	
	bit1(0xA9EDA0) == 1	
	
function isCrowdScaredWithLighter() => 
	bit1(0xA9EDA0) == 0	
// -------------------------------------
function isMovieWorldConquestPicked() => 
	bit7(0xA9EDB7) == 1 && bit0(0xA9EDB8) == 1		// $A9EDB7: [Current Playthrough Bit Flags]: Chapter 6
													// 		bit 5 => Movie choice 1: Meditating Man
function isMovieTimeTravelPicked() => 				// 		bit 6 => Movie choice 1: Time Travel
	bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0		// 		bit 7 => Movie choice 2: Take over the world
																						
function isMovieFindCauseDeathPicked() => 			// $A9EDB8: [Current Playthrough Bit Flags]: Chapter 6
	bit0(0xA9EDB8) == 1 && bit7(0xA9EDB7) == 0		// 		bit 0 => Movie Choice 2: Find cause of own death
													// 		bit 1 => Movie Choice 3: Thriller story	
function isMovieThrillerStoryPicked() => 			// 		bit 2 => Movie Choice 3: Love story
	bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0		

function isMovieLoveStoryPicked() => 
	bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0	
// -------------------------------------
function isPaintingAntidoteInspired() => 	// $A9EDB0: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
	bit7(0xA9EDB0) == 1						//  - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen	
											// 		bit 7 => Antidote painting
function isPaintingMarktplatzInspired() => 	// 		bit 6 => Marktplatz painting (insinuating removing the tree)
	bit6(0xA9EDB0) == 1						// 		bit 5 => Squire's crest painting
											// 		bit 4 => Tower view painting (downstairs)
function isPaintingSquireCrestInspired() => 
	bit5(0xA9EDB0) == 1	
					
function isPaintingTowerViewInspired() => 
	bit4(0xA9EDB0) == 1

function isPaintingPerformerInspired() => 	// $A9EDB1: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
	bit0(0xA9EDB1) == 1						// 		bit 0 => Performer painting (only possible when player became performer in chapter 4)
											// 		bit 1 => Achemist house collapse painting
function isPaintingHouseCollapseInspired() => 
	bit1(0xA9EDB1) == 1	
// -------------------------------------
function isBrumEstateMuseum() => 	//	$A9EDAA: [Current Playthrough Bit Flags]: Brum Estate Choice
	bit5(0xA9EDAA) == 0				//		bit 5 = 0 => Brum Estate is museum
									//		bit 5 = 1 => Brum Estate is library
function isBrumEstateLibrary() => 
	bit5(0xA9EDAA) == 1
// -------------------------------------
function isMargaretteAncestor() => 				// $A9EDAE: [Current Playthrough Bit Flags]: Margarette Ancestor choice
	bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0	// 		bit 6 => Margarette is ancestor, sets after leaving alchemist house
												// 		bit 7 => Margarette is NOT an ancestor, sets after leaving alchemist house
function isMargaretteNoAncestor() => 
	bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1		
// -------------------------------------
function isFirePutOutByWarningBarman() => 	// $A9ED9D: [Current Playthrough Bit Flags]: Chapter 1
	bit5(0xA9ED9D) == 0 &&					//		bit 5 => put out fire yourself
	bit7(0xA9ED9D) == 1						//		bit 7 => Saved bar from fire by warning barman

function isFirePutOutByEike() => 
	bit5(0xA9ED9D) == 1 &&
	bit7(0xA9ED9D) == 0	
// -------------------------------------
function isDanaSavedFromPast(){	return	// $A9EDC4: [Current Playthrough Bit Flags]: Saved Dana from Past
	bit1(0xA9EDC4) == 1 && 				// 		bit 1 => Gave letter to Dana
	bit3(0xA9EDC4) == 1 && 				// 		bit 3-4 => Took Dana back to present
	bit4(0xA9EDC4) == 1}

function isDanaNotSavedFromPast(){ return
	bit1(0xA9EDC4) == 0 &&
	bit3(0xA9EDC4) == 0 &&
	bit4(0xA9EDC4) == 0}
// -------------------------------------
function isCoffeePayed() => 	// $A9EDCC: [Current Playthrough Bit Flags]: Multi-chapter
	bit3(0xA9EDCC) == 1			// 		bit 3 => Oleg spawns in chapter 7 near movie post, present (not night before) - becomes true when coffee/tab has been payed with egg shaped pocket watch

function isKittenGivenToSibylla() =>	// $A9EDCB: [Current Playthrough Bit Flags]: Multi-chapter
	bit6(0xA9EDCB) == 1					// 		bit 2 => talked with Oleg 1st time in Chapter 3
										// 		bit 3 => talked with Oleg in Chapter 7 - Oleg spawns when bit 0 @ xa9edcc == 1
										// 		bit 6 => gave kitten to Sibylla

function isWearingPerformerOutfit() => 	// $A9EDA5: [Current Playthrough Bit Flags]: Chapter 4
	bit2(0xA9EDA5) == 1					//		 bit 2 => is wearing performer outfit


// *******************************************
// ÷ PERMANENT CUTSCENE PERCENTAGE BITFLAGS ÷
// *******************************************
// 	- Each flag corresponds to at least 1 cutscene and counts toward the achievement percentage 
// 	- These flags are set when heading into any save menu OR when finishing a chapter OR when booting up the game
// 	- Each flag accounts for a float percentage. These numbers are rounded up or down in the extra menu
// 	- To test => change memory values => from title screen go back into extra menu
const_percentageBitsFlags = {
	"Prologue": {
		0xAA115B: [1,7],
		0xAA115C: [0,7],
		0xAA115D: [0,7],
		0xAA115E: [0,7],
		0xAA115F: [0,7],
		0xAA1160: [0,7],
		0xAA1161: [0,5]},
	"Chapter1": {
		0xAA1162: [6,7],
		0xAA1163: [0,7],
		0xAA1164: [0,7],
		0xAA1165: [0,5]},
	"Chapter2": {
		0xAA1166: [3,7],
		0xAA1167: [0,7],
		0xAA1168: [0,7],
		0xAA1169: [0,7],
		0xAA116A: [0,6],},
	"Chapter3": {
		0xAA1177: [2,7],
		0xAA1178: [0,7],
		0xAA1179: [0,7]},
	"Chapter4": {
		0xAA116C: [1,7],
		0xAA116D: [0,7],
		0xAA116E: [0,7],
		0xAA116F: [0,7],
		0xAA1170: [0,4]},
	"Chapter5": {
		0xAA1171: [1,7],
		0xAA1172: [0,7],
		0xAA1173: [0,7],
		0xAA1174: [0,7],
		0xAA1175: [0,7],
		0xAA1176: [0,6]},
	"Chapter6": {
		0xAA117A: [2,7],
		0xAA117B: [0,7],
		0xAA117C: [0,7],
		0xAA117D: [0,7],
		0xAA117E: [0,4]},
	"Chapter7": {
		0xAA117F: [2,7],
		0xAA1180: [0,7],
		0xAA1181: [0,7],
		0xAA1182: [0,7],
		0xAA1183: [0,3]},
	"Chapter8": {
		0xAA1184: [5,7],
		0xAA1185: [0,7],
		0xAA1186: [0,7],
		0xAA1187: [0,7],
		0xAA1188: [0,7],
		0xAA1189: [0,7],
		0xAA118A: [0,7],
		0xAA118B: [0,7],
		0xAA118C: [0,7],
		0xAA118D: [0,3]},
	"Epilogue": {
		0xAA1190: [2,7],
		0xAA1191: [0,7],
		0xAA1192: [0,7],
		0xAA1193: [0]}}

function getTotalAchievementRate() =>	// $AA1152: [8-bit] Achievement Percentage: Total
	byte(0xAA1152)

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
// ÷ Achievement CORE DATA ÷
// **************************
// - Divided by category => when in debug mode, category tags are added to achievement titles

const_achievements_coreData = {
	// DEV NOTE: Achievement property 'badgeId'
	// 	=> needs to be a string, not integer
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
	//	"id": 000000, "points": 0000000, "badgeId": "00000000", "hasTips": false,
	//	"devInfo": "xxxxxxx"},

	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // WORKING 
			"id": 306884, "points": 5, "badgeId": "461667", "hasTips": false, 
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // WORKING
			"id": 306886, "points": 5, "badgeId": "461654", "hasTips": false,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // WORKING
			"id": 306922, "points": 5, "badgeId": "461655", "hasTips": false,
			"devInfo": "Complete chapter 2"},
		"a_Chapter3Complete": { // WORKING
			"id": 306921, "points": 5, "badgeId": "461656", "hasTips": false,
			"devInfo": "Complete chapter 3"},
		"a_Chapter4CompletePan": { // WORKING
			"id": 308964, "points": 3, "badgeId": "461657", "hasTips": true,
			"devInfo": "Complete chapter 4, using a frying pan"},
		"a_Chapter4CompleteSign": { // WORKING
			"id": 310149, "points": 3, "badgeId": "461658", "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign"},
		"a_Chapter5Complete": { // WORKING
			"id": 311616, "points": 5, "badgeId": "461659", "hasTips": false,
			"devInfo": "Complete chapter 5"},
		"a_Chapter6CompleteThriller": { // WORKING
			"id": 313211, "points": 3, "badgeId": "461661", "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a thriller movie"},
		"a_Chapter6CompleteLove": { // WORKING
			"id": 313210, "points": 3, "badgeId": "461660", "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a love movie"},
		"a_Chapter7Complete": { // WORKING
			"id": 315565, "points": 5, "badgeId": "461665", "hasTips": false,
			"devInfo": "Complete chapter 7"},
		"a_Chapter8Complete": { // WORKING 
			"id": 315571, "points": 5, "badgeId": "461666", "hasTips": false,
			"devInfo": "Complete chapter 8"}},
	"c_AchievementPercentage": {
		"a_MaxAchievementPrologue": { // WORKING
			"id": 405087, "points": 10, "badgeId": "461646", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in prologue + EX Chapter"},
		"a_MaxAchievementChapter1": { // WORKING
			"id": 405088, "points": 10, "badgeId": "461637", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 1"},
		"a_MaxAchievementChapter2": { // WORKING
			"id": 405089, "points": 10, "badgeId": "461638", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 2"},
		"a_MaxAchievementChapter3": { // WORKING
			"id": 405090, "points": 10, "badgeId": "461639", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 3"},
		"a_MaxAchievementChapter4": { // WORKING
			"id": 405091, "points": 10, "badgeId": "461640", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 4"},
		"a_MaxAchievementChapter5": { // WORKING
			"id": 405092, "points": 10, "badgeId": "461641", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 5"},
		"a_MaxAchievementChapter6": { // WORKING
			"id": 405093, "points": 10, "badgeId": "461642", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 6"},
		"a_MaxAchievementChapter7": { // WORKING
			"id": 405094, "points": 10, "badgeId": "461643", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 7"},
		"a_MaxAchievementChapter8": { // WORKING
			"id": 405095, "points": 10, "badgeId": "461644", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in chapter 8"},
		"a_MaxAchievementEpilogue": { // WORKING	
			"id": 405096, "points": 10, "badgeId": "461645", "hasTips": false,
			"devInfo": "Seen all the important cutscenes in epilogue"},
		"a_MaxAchievementTotal": { // WORKING
			"id": 405097, "points": 50, "badgeId": "461647", "hasTips": false,
			"devInfo": "Seen ALL important the cutscenes"}},
	"c_Branch": { // Category - Branching path
		"a_GetOrnamentalEgg": { // WORKING
			"id": 306885, "points": 1, "badgeId": "461653", "hasTips": true,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."},
		"a_GetExChapterOrnamentalEgg": { // WORKING
			"id": 405112, "points": 1, "badgeId": "461653", "hasTips": true,
			"devInfo": "In the EX Chapter: go to the performer after not saving grandpa in the fire, thus getting the egg"},
		"a_BecomeThePerformer": { // WORKING
			"id": 402284, "points": 4, "badgeId": "461649", "hasTips": true,
			"devInfo": "In chapter4, use the costume to give yourself a message. Only possible when you haven't acquired the egg in chapter 1??"},
		"a_EggCollection": { // WORKING
			"id": 306977, "points": 4, "badgeId": "461650", "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with the stairs and door inside the building on fire, then go back in time, you'll be transported to the past inside the bar this time"},
		"a_AlertBarmanOfFire": { // WORKING
			"id": 306976, "points": 4, "badgeId": "461648", "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman at his bar during chapter 3 or chapter 4"},
		"a_EndingEXKillHomunculus": { // WORKING
			"id": 405113, "points": 3, "badgeId": "461652", "hasTips": true,
			"devInfo": "In EX Chapter: after heading to past, return back to present to die, so you can kill Homunulus in Limbo with the red stone"},
		"a_EndingEXCureHelena": { // WORKING
			"id": 405114, "points": 3, "badgeId": "461651", "hasTips": true,
			"devInfo": "In EX Chapter: give the stone to Dr. Wagner in the past"}},
	"c_Endings": { // Category - Achieving different endings
		"a_EndingA": { // WORKING
			"id": 315566, "points": 5, "badgeId": "461668", "hasTips": true,
			"devInfo": "Ending A: Margarette (Ancestress) => Fortuneteller AND Homunculus => Town Square"},
		"a_EndingB1":{ // WORKING
			"id": 315573, "points": 5, "badgeId": "461669", "hasTips": true,
			"devInfo": "Ending B1: Margarette (Ancestress) => Fortuneteller => Town Square"},
		"a_EndingB2":{ // WORKING
			"id": 315572, "points": 5, "badgeId": "461670", "hasTips": true,
			"devInfo": "Ending B2: Margarette (Ancestress) => Homunculus => Town Square"},
		"a_EndingC": { // WORKING
			"id": 317118, "points": 5, "badgeId": "461671", "hasTips": true,
			"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		"a_EndingD": { // WORKING
			"id": 322230, "points": 5, "badgeId": "461672", "hasTips": true,
			"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		"a_EndingE": { // WORKING
			"id": 322231, "points": 5, "badgeId": "461673", "hasTips": true,
			"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => Destroyed Lab"}},
	"c_Extra": { // Category - Extra side content & cutscenes
		"a_TimeTravellingCat": { // WORKING
			"id": 310426, "points": 4, "badgeId": "461728", "hasTips": true,
			"devInfo": "Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart in present => give kitten before chapter 7"},		
		"a_DoctorateTimeTraveling": { // WORKING
			"id": 310163, "points": 4, "badgeId": "461679", "hasTips": true,
			"devInfo": "Complete chapter 4 whilst also taking the a picture yourself in this chapter AND having acquired the ornamental egg from the performer in chapter 1 but did NOT use it to give your past self a message"},
		"a_ShowEggTownPlanter": { // WORKING
			"id": 307023, "points": 3, "badgeId": "461725", "hasTips": true,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_EikeThePyromancer": { // WORKING
			"id": 306911, "points": 1, "badgeId": "461685", "hasTips": true,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // WORKING
			"id": 306906, "points": 1, "badgeId": "461684", "hasTips": true,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_EikeTheFlorist": { // WORKING
			"id": 306920, "points": 1, "badgeId": "461683", "hasTips": true,
			"devInfo": "Choose to plant flowers, when talking to the town planter in 1580 in chapter 2"},
		"a_ArtAppreciator": { // WORKING
			"id": 307499, "points": 1, "badgeId": "461675", "hasTips": true,
			"devInfo": "Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor"}, 
		"a_ArtInspiration1": { // WORKING
			"id": 403824, "points": 3, "badgeId": "461676", "hasTips": true,
			"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him at least once => view art in present, when Brum Estate is in Museum from"},
		"a_ArtInspirationAll": { // WORKING
			"id": 403825, "points": 5, "badgeId": "461677", "hasTips": true,
			"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him with different idea's => view art in present, when Brum Estate is in Museum from"},
		"a_AntiquesEule": { // WORKING
			"id": 310132, "points": 2, "badgeId": "461674", "hasTips": true,
			"devInfo": "Take a glance at timeless antiquity at Antique Shop Eule. Shop is open in chapter 3, 4 (present) and 6, 7 (1980)"},
		"a_EnigmaticCouple1": { // WORKING
			"id": 307495, "points": 3, "badgeId": "461690", "hasTips": true,
			"devInfo": "Find the coated couple in the present during the prologue or chapter 1"},
		"a_EnigmaticCouple2": { // WORKING
			"id": 310131, "points": 3, "badgeId": "461691", "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 3"},
		"a_EnigmaticCouple3": { // WORKING
			"id": 310134, "points": 3, "badgeId": "461692", "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 4"},	
		"a_EnigmaticCouple4": { // WORKING
			"id": 310135, "points": 3, "badgeId": "461693", "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 5"},	
		"a_EnigmaticCouple5": { // WORKING
			"id": 315564, "points": 3, "badgeId": "461694", "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 7"},	
		"a_LostYoungCouple1": { // WORKING
			"id": 306984, "points": 4, "badgeId": "461706", "hasTips": true,
			"devInfo": "Interact with the lost couple in the Middle Ages during chapter 2"},
		"a_LostYoungCouple2": { // WORKING
			"id": 310133, "points": 4, "badgeId": "461707", "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 3"},
		"a_LostYoungCouple3": { // WORKING
			"id": 309393, "points": 4, "badgeId": "461708", "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 4"},
		"a_LostYoungCouple4": { // WORKING
			"id": 310162, "points": 1, "badgeId": "461709", "hasTips": true,
			"devInfo": "Interact with the lost man in Middle Ages during chapter 5"},
		"a_LostYoungCouple5": { // WORKING
			"id": 314753, "points": 2, "badgeId": "461710", "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 7"},
		"a_LostYoungCouple6": { // WORKING
			"id": 315568, "points": 10, "badgeId": "461711", "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 8"},
		"a_HugoMotherChild": { // WORKING
			"id": 311466, "points": 2, "badgeId": "461705", "hasTips": true,
			"devInfo": "Secret cutscene in chapter 5 => when going to 1580 (not 1584) => head to marktplatz of Hugo getting bullied"}, 
		"a_SnowyCrimeScene": { // WORKING
			"id": 313209, "points": 2, "badgeId": "461727", "hasTips": true,
			"devInfo": "Discover a crime scene during the winter, in chapter 6"},
		"a_SaveMiriamBrum": { // WORKING
			"id": 315569, "points": 4, "badgeId": "461721", "hasTips": true,
			"devInfo": "Save Miriam Brum in chapter 6"},
		"a_MeetOldMiriam": { // WORKING
			"id": 315570, "points": 10, "badgeId": "461714", "hasTips": true,
			"devInfo": "Complete chapter 7, whilst having saved Miriam in chapter 6"},
		"a_EnergyOrbLocatorPresentDay": { // WORKING
			"id": 399816, "points": 5, "badgeId": "461689", "hasTips": true,
			"devInfo": "Find all 5 energy orbs in present day"},
		"a_EnergyOrbLocator70s80s": { // WORKING
			"id": 399817, "points": 5, "badgeId": "461687", "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 70s/80s"}, 
		"a_EnergyOrbLocator1900Days": { // WORKING
			"id": 399818, "points": 5, "badgeId": "461686", "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 1900s"}, 
		"a_EnergyOrbLocatorMiddleAges": { // WORKING
			"id": 399819, "points": 5, "badgeId": "461688", "hasTips": true,
			"devInfo": "Find all 6 energy orbs in Middle Ages"}, 
		"a_NewCakeInvented": { // WORKING
			"id": 402297, "points": 3, "badgeId": "461715", "hasTips": true,
			"devInfo": "Take the cake => give it to margarete => talk to bakery girl again (name of cake is now margarete)"}, 		
		"a_GiveMargaretteCake": { // WORKING
			"id": 402296, "points": 4, "badgeId": "461704", "hasTips": true,
			"devInfo": "Acquire cake from bakery => give to margarette"}, 		
		"a_MaxInventory": { // WORKING 
			"id": 402404, "points": 10, "badgeId": "461712", "hasTips": true,
			"devInfo": "Only achievable when going for Ending E: Z-pad, notebook, present city map, old map, cellphone, lighter, egg ornament OR Frying pan, medallion, old book, monochrome picture, cake, franssen shop sign, kitten, egg pocket watch, scrap meat, tower key, lab key, red jewel, Dana's letter, comb"}, 
		"a_PocketWatchCollection": { // WORKING
			"id": 315561, "points": 4, "badgeId": "461717", "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7, not night before"},
		"a_PocketWatchReminiscing": { // WORKING
			"id": 315562, "points": 4, "badgeId": "461718", "hasTips": true,
			"devInfo": "Talk to Eckart with the pocket watch in your inventory during chapter 8"},
		"a_EggPocketWatchForCoffee": { // WORKING
			"id": 313213, "points": 4, "badgeId": "461682", "hasTips": true,
			"devInfo": "Show off the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward"},
		"a_BarmansChildren": { // WORKING
			"id": 315567, "points": 3, "badgeId": "461678", "hasTips": true,
			"devInfo": "Uncover the truth about the barman's children and the mystery child during chapter 5"},
		"a_ScareEveryone": { // WORKING
			"id": 404046, "points": 4, "badgeId": "461722", "hasTips": true,
			"devInfo": "Startle the spaghetti man in the present + the crowd (counts for 4) + the wannabe apprentice + the eccentric girl with a lighter or cellphone"},
		"a_MeetFamousOleg": { // WORKING
			"id": 404045, "points": 4, "badgeId": "461713", "hasTips": true,
			"devInfo": "After acquiring the egg pocket watch in chapter 6 => Go to bar in 1900s and pay for coffee => Oleg now spawns in chapter 7 near movie post, after you have the tower key (not night before)"},
		"a_DrunkenGuys": { // WORKING
			"id": 404048, "points": 2, "badgeId": "461680", "hasTips": true,
			"devInfo": "In chapter 7, once you have the tower key => find them in the present in the car park (not night before)"},
		"a_SeenOlegAsWell": { // WORKING
			"id": 405098, "points": 1, "badgeId": "461723", "hasTips": true,
			"devInfo": "Talk with the adult inside cafe Sonne during chapter 6, he talks about the movie director staring at the sky"},
		"a_PocketWatchTo80sBarman": { // WORKING
			"id": 407681, "points": 1, "badgeId": "461719", "hasTips": true,
			"devInfo": "Use the pocket watch next to the barman in 1980, the cold days. He's inside the bar."},
		"a_RunningAcrossThe90s": { // WORKING
			"id": 405086, "points": 2, "badgeId": "461720", "hasTips": true,
			"devInfo": "Talk to jogging man in present and past (70s)"},
		"a_ShortestChapter": { // WORKING
			"id": 403823, "points": 3, "badgeId": "461724", "hasTips": true,
			"devInfo": "Have frying pan before chapter 4 and use is to skip chapter 4, by using it at the start"},
		"a_ShowPocketWatchToPhotographer": { // WORKING 
			"id": 405460, "points": 2, "badgeId": "461726", "hasTips": true,
			"devInfo": "In chapter 6 or 7, show the pocket watch to Oleg, movie director's ancestor in 1902"},
		"a_FreeMeal": { // WORKING 
			"id": 405461, "points": 3, "badgeId": "461695", "hasTips": true,
			"devInfo": "Save bar in chap 1 by talking to barman => start chap 5 using free meal"},
		"a_PerformerGoingExtraMile": { // WORKING
			"id": 403575, "points": 5, "badgeId": "461716", "hasTips": true,
			"devInfo": "Make sure the performer goes the extra mile, by surprising as many people as possible"}},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to player dying or game over screen
		"a_MetYouBefore": { // WORKING
			"id": 306888, "points": 2, "badgeId": "461701", "hasTips": true,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_ErasingEike": { // WORKING
			"id": 306883, "points": 2, "badgeId": "461699", "hasTips": true,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
		"a_ErasingEike2": { // WORKING
			"id": 314763, "points": 1, "badgeId": "461698", "hasTips": true,
			"devInfo": "Meet yourself at the Brum's mansion during chapter 7"},
		"a_RottenRope": { // WORKING
			"id": 315563, "points": 1, "badgeId": "461702", "hasTips": true,
			"devInfo": "Try to save yourself with an old rope during chapter 7"},
		"a_ExcuseMeMyMy": { // WORKING
			"id": 306919, "points": 1, "badgeId": "461700", "hasTips": true,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
		"a_TimeEgoFlop": { // WORKING
			"id": 313212, "points": 1, "badgeId": "461703", "hasTips": true,
			"devInfo": "During chapter 6, co-direct Time Ego"}}}

const_achievement_typeByCategory = {
	//	DEV NOTE: Achievement type property
	//	- Possible type keys: "missable" - "progression" - "win_condition"
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_template": "xxxxxx",
	"c_Endings": "win_condition",
	"c_Completion": "progression",
	"c_Extra_GameOver": "missable",
	"c_AchievementPercentage": "missable",
	"c_Branch": "missable",
	"c_Extra": "missable"}

// ***********************************
// ÷ Achievement TRIGGER GENERATORS ÷
// ***********************************
//	- For achievement logic that's reoccuring across multiple triggers
function generate_FullTrigger_MaxAchievementRate(string_chapter, dict_PercentageBitFlags){ 
	function generateTallyComparison_MaxAchievementRate(dict_BitFlags) {
		function totalAmountOfBitFlags(dict_BitFlags) {
			let_bitFlagCount = 0
			for memAddrWithBitFlags in dict_BitFlags {
				let_arrayOfBitBlagsToCheck = dict_BitFlags[memAddrWithBitFlags]
				if (length(let_arrayOfBitBlagsToCheck) == 1) {
					let_bitFlagCount = let_bitFlagCount + 1	
				} else if (let_arrayOfBitBlagsToCheck[0] > let_arrayOfBitBlagsToCheck[1]) {
					let_bitFlagCount = let_bitFlagCount + 1 + (let_arrayOfBitBlagsToCheck[0] - let_arrayOfBitBlagsToCheck[1])
				} else {
					let_bitFlagCount = let_bitFlagCount + 1 + (let_arrayOfBitBlagsToCheck[1] - let_arrayOfBitBlagsToCheck[0])
				}
			}
			return let_bitFlagCount}

		// DEV EXAMPLE: Tally inside a tally
		// ---------------------------------
		// EXAMPLE A == B; different way of getting same result
		//		- tally_of inside predicate of tally_of
		//		tally_of([
		//			[once(getChapterId() == 0x3),once(getChapterId() == 0x3),once(getChapterId() == 0x3)],
		//			[once(getChapterId() == 0x2),once(getChapterId() == 0x2),once(getChapterId() == 0x2)],
		//			[once(getChapterId() == 0x1),once(getChapterId() == 0x1),once(getChapterId() == 0x1)]], 20, (arrayWithComparisons) {
		//				return tally_of(arrayWithComparisons, 1, (comparison) => comparison)		// the count on this tally_of doesn't matter, but must be != 0 => because runtime error
		//			})			
		// EXAMPLE B == A; different way of getting same result
		//		- tally_of inside predicate of tally_of == this tally
		//		tally(20, [
		//			once(getChapterId() == 0x3),once(getChapterId() == 0x3),once(getChapterId() == 0x3),
		//			once(getChapterId() == 0x2),once(getChapterId() == 0x2),once(getChapterId() == 0x2),
		//			once(getChapterId() == 0x1),once(getChapterId() == 0x1),once(getChapterId() == 0x1)])

		return tally_of(dict_BitFlags, totalAmountOfBitFlags(dict_BitFlags), (memAddr) {	// This tally_of chains ALL of the comparisons generated
			let_comparisonsArray = []
			let_arrayOfBitBlagsToCheck = dict_BitFlags[memAddr]
			if (length(let_arrayOfBitBlagsToCheck) == 1) {
				let_bitIndex = let_arrayOfBitBlagsToCheck[0]
				array_push(let_comparisonsArray, once(bit(let_bitIndex, memAddr) == 1))
			} else {
				let_step = 1
				if (let_arrayOfBitBlagsToCheck[0] > let_arrayOfBitBlagsToCheck[1]) let_step = -1
				for let_bitIndex in range(let_arrayOfBitBlagsToCheck[0], let_arrayOfBitBlagsToCheck[1], let_step) {	// Example let_arrayOfBitBlagsToCheck = [5,7]; this line [5,6,7]; let_bitIndex 1st loop = 5; let_bitIndex 2nd loop = 6; let_bitIndex 3rd loop = 7;
					array_push(let_comparisonsArray, once(bit(let_bitIndex, memAddr) == 1))
				}
			}
			return tally_of(let_comparisonsArray, 1, (comparison) => comparison) // count on this tally_of doesn't matter; this line chains all the comparisons together created the bitflags on ONE memory address
		})
	}		
	function generateTrigger_TotalMaxAchievementRate(comparison_tally) { return		
		never(	// Reset/recalculate tally count
			isChapterChanging()
		) && 
		(
			(	// Alt 1 => In game rate measurement
				measured(comparison_tally, isInGame(), "percent")
			) || ( // Alt 2 => show measurement at results screen
				measured(comparison_tally, isResultsMenuHighlightedChapter("Total"), "percent")
			)
		)
	}
	function generateTrigger_ChapterMaxAchievementRate(string_chapter, comparison_tally) { return		
		never(	// Reset/recalculate tally count
			isChapterChangingTo(string_chapter)
		) && 
		(
			(	// Alt 1 => In game rate measurement
				unless(	// Pause if => not in correct chapter, but still show progress on achievement
					!isCurrentChapter(string_chapter)
				) &&
				measured(comparison_tally, isInGame(), "percent")
			) || ( // Alt 2 => show measurement at results screen				
				measured(comparison_tally, isResultsMenuHighlightedChapter(string_chapter), "percent")
			)
		)
	} 
	let_tallyComparison = generateTallyComparison_MaxAchievementRate(dict_PercentageBitFlags)
	if (string_chapter == "Total") {
		return generateTrigger_TotalMaxAchievementRate(let_tallyComparison)
	} else {
		return generateTrigger_ChapterMaxAchievementRate(string_chapter, let_tallyComparison)
	}}

function generate_Tally_PickUpEnergyOrbs(int_tallyCount) {
	let_charactersToCheck = {	// (G)ot (E)nerg(Y) un(I)t.
		"G": {
			"index": 0,	
			"printXaxis": 0x0,
			"imageOffsetXaxis": 0x48,
			"imageOffsetYaxis": 0x0,
			"imageUnmaskWidth": 0x9,
			"printYaxis": 0x0},
		"E": {
			"index": 3,	
			"printXaxis": 0x1f,
			"imageOffsetXaxis": 0x48,
			"imageOffsetYaxis": 0x38,
			"imageUnmaskWidth": 0x9,
			"printYaxis": 0x0},
		"Y": {
			"index": 8,	
			"printXaxis": 0x4b,
			"imageOffsetXaxis": 0x48,
			"imageOffsetYaxis": 0x54,
			"imageUnmaskWidth": 0x9,
			"printYaxis": 0x1},		
		"I": {
			"index": 11,	
			"printXaxis": 0x6c,
			"imageOffsetXaxis": 0x0,
			"imageOffsetYaxis": 0x46,
			"imageUnmaskWidth": 0x4,
			"printYaxis": 0x0}}
	return
		tally(int_tallyCount, 
			isEnergyUnitsIncreasing() &&
			isPriorMinimumAmountOfCharactersOnBottomScreen(14) &&		
			isPriorCharacterPrinted(let_charactersToCheck["G"]) &&
			isPriorCharacterPrinted(let_charactersToCheck["E"]) &&
			isPriorCharacterPrinted(let_charactersToCheck["Y"]) &&
			isPriorCharacterPrinted(let_charactersToCheck["I"]) &&
			!isFullCutsceneActive()	// Don't switch with isNoCutsceneActive() --> FIXfor: picking up energy orb in chapter 3, when energy drained by Homunculus. The cutscene flag here doesn't turn to 0x0 , but turns to a small cutscene
		)}

// *************************
// ÷ Achievement TRIGGERS ÷
// *************************
const_achievement_triggers = {
	// "a_Template": function Template() {	// WIP_template
	// 	return always_false()
	// },
	"a_PrologueComplete": function PrologueComplete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => watching performer
					isFullCutsceneActive() && isCurrentChapter("Prologue") &&
					isCurrentCutsceneMasterId(0x22480)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x1bcd0)	&&
					isCurrentCutsceneSectionDataId(0xe10)
				) &&
				once(	// Identifies cutscene => shadow/killer walking behind Eike
					isFullCutsceneActive() && isCurrentChapter("Prologue") &&
					isCurrentCutsceneMasterId(0x90bc0)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x1ae70)	&&
					isCurrentCutsceneSectionDataId(0x75d10)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Prologue")
			)
		)},
	"a_Chapter1Complete": function Chapter1Complete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => burning bar changes into non-burning
					isFullCutsceneActive() && isCurrentChapter("Chapter1") &&
					isCurrentCutsceneMasterId(0x11a40)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0xbea0)	&&
					isCurrentCutsceneSectionDataId(0x5b80)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Chapter1")
			)
		)},
	"a_Chapter2Complete": function Chapter2Complete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => reminiscing about Dana: left in the past
					isFullCutsceneActive() && isCurrentChapter("Chapter2") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x3b240)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x340e0)	&&
					isCurrentCutsceneSectionDataId(0x7130)
				) &&
				once(	// Identifies Cutscene => stopping to smoke + turning around to see flowers/statue
					isFullCutsceneActive() && isCurrentChapter("Chapter2") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x3b240)		&&
					isCurrentCutsceneSectionId_1(0x3)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x11240)	&&
					isCurrentCutsceneSectionDataId(0x2b0)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Chapter2")
			)
		)},
	"a_Chapter3Complete": function Chapter3Complete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => Time travel back to Brum Museum  
					isFullCutsceneActive() && isCurrentChapter("Chapter3") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x19d80)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x82a0)	&&
					isCurrentCutsceneSectionDataId(0x11ac0)
				) &&
				once(	// Identifies Cutscene => Back to Eckart and breaking vase
					isFullCutsceneActive() && isCurrentChapter("Chapter3") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0xcfb40)		&& isPriorCutsceneMasterId(0x19d80) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x39f0)	&&
					isCurrentCutsceneSectionDataId(0x387a0)
				) &&
				once(	// Identifies Cutscene => Back downstairs and talk to Homunculus
					isFullCutsceneActive() && isCurrentChapter("Chapter3") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x39680)		&& isPriorCutsceneMasterId(0xcfb40) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x7e10)	&&
					isCurrentCutsceneSectionDataId(0x7ca0)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Chapter3")
			)
		)},
	"a_Chapter4CompletePan": function Chapter4CompletePan() { return
		never(	// Core group
			!isInGame() 							||
			isNewCutsceneLoading()						||
			isEventViewerActive()			||
			!isCurrentSelectedInventoryItem("FryingPan")
		) &&
		(
			( // Alt 1 
				once(	// Identifies cutscene => protecting yourself with pan 
					isFullCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentCutsceneMasterId(0x4f200)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x11cd0)	&&
					isCurrentCutsceneSectionDataId(0x3d500)
				) &&
				isFullCutsceneSequenceEnding()
			) || ( // Alt 2 
				once(	// Identifies cutscene => protecting yourself with pan AND having taken the picture in the performer outfit
					isFullCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentCutsceneMasterId(0x54580)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x17060)	&&
					isCurrentCutsceneSectionDataId(0x1390)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 3; Failsafe
				isChapterFinishing("Chapter4")
			)
		)},
	"a_Chapter4CompleteSign": function Chapter4CompletePan() { return
		never(	// Core group
			!isInGame() 						||
			isNewCutsceneLoading()					||
			isEventViewerActive()		||
			!isCurrentSelectedInventoryItem("Sign")
		) &&
		(
			( // Alt 1 
				once(	// Identifies cutscene => protecting yourself with sign + info about photo from Homnunculus
					isFullCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentCutsceneMasterId(0x54580)		&&
					isCurrentCutsceneSectionId_1(0xd)		&&
					isCurrentCutsceneSectionId_2(0xe)		&&
					isCurrentCutsceneMasterDataId(0xb6e0)	&&
					isCurrentCutsceneSectionDataId(0xae50)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2
				isChapterFinishing("Chapter4")
			)
		)},
	"a_Chapter5Complete": function Chapter5Complete() { return
		never(
			!isInGame() ||
			isEventViewerActive()
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	
				once(	// Identifies Cutscene => drinking antidote
					isFullCutsceneActive() && isCurrentChapter("Chapter5") &&
					isCurrentSelectedInventoryItem("Antidote")	&&
					isCurrentCutsceneMasterId(0x3f980)			&&
					isCurrentCutsceneSectionId_1(0xffff)		&&
					isCurrentCutsceneSectionId_2(0x0)			&&
					isCurrentCutsceneMasterDataId(0x3f980)		&&
					isCurrentCutsceneSectionDataId(0x3f980)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Chapter5")
			)
		)},
	"a_Chapter6CompleteThriller": function Chapter6CompleteThriller() {	return
		// Core group
		never(
			!isInGame() 			||
			isEventViewerActive() 
		) &&
		isMovieTimeTravelPicked() 		&&
		isMovieThrillerStoryPicked() 	&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					isFullCutsceneActive() && 
					isCurrentCutsceneMasterId(0x9db40)		&&
					isCurrentCutsceneSectionId_1(0x7)		&&
					isCurrentCutsceneSectionId_2(0x8)		&&
					isCurrentCutsceneMasterDataId(0x66600)	&&
					isCurrentCutsceneSectionDataId(0x20cd0)
				) && 
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe
				isChapterFinishing("Chapter6")
			)
		)},
	"a_Chapter6CompleteLove": function Chapter6CompleteLove() {	return
		// Core group
		never(
			!isInGame() 		||
			isEventViewerActive() 
		) &&
		isMovieTimeTravelPicked() 	&&
		isMovieLoveStoryPicked() 	&&
		(
			(	// Alt 1 
				once( // Identifies Cutscene => Saved by love story movie
					isFullCutsceneActive() && 				
					isCurrentCutsceneMasterId(0x9db40)		&&
					isCurrentCutsceneSectionId_1(0x7)		&&
					isCurrentCutsceneSectionId_2(0x8)		&&
					isCurrentCutsceneMasterDataId(0x66600)	&&
					isCurrentCutsceneSectionDataId(0x20cd0)
				) && 
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe
				isChapterFinishing("Chapter6")
			)
		)},
	"a_Chapter7Complete": function Chapter7Complete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&
		(
			(	// Alt 1 => Normal way of identifying cutscenes	 (Also works when saving Miriam => Miriam is a counts as an extra in-between cutscene)			
				once(	// Identifies Cutscene => Holding onto rope 
					isFullCutsceneActive() && isCurrentChapter("Chapter7") &&
					isCurrentCutsceneMasterId(0x43040)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x7ce0)	&&
					isCurrentCutsceneSectionDataId(0xd940)
				) &&
				tally(1,[	// One of these is true, depending on ancestress or no ancestress choice
					once(	// Identifies Cutscene => Talking to Eckart, Ancestress path 
						isFullCutsceneActive() && isCurrentChapter("Chapter7") &&
						isMargaretteAncestor() &&
						isCurrentCutsceneMasterId(0xc6800)		&&
						isCurrentCutsceneSectionId_1(0x5)		&&
						isCurrentCutsceneSectionId_2(0x4)		&&
						isCurrentCutsceneMasterDataId(0x45720)	&&
						isCurrentCutsceneSectionDataId(0x6ccd0)),
					once(	// Identifies Cutscene => Talking to Eckart, No Ancestress path 
						isFullCutsceneActive() && isCurrentChapter("Chapter7") &&
						isMargaretteNoAncestor() &&
						isCurrentCutsceneMasterId(0xd1bc0)		&&
						isCurrentCutsceneSectionId_1(0x3)		&&
						isCurrentCutsceneSectionId_2(0x4)		&&
						isCurrentCutsceneMasterDataId(0x48000)	&&
						isCurrentCutsceneSectionDataId(0x5b190))]
				) &&
				once(	// Identifies Cutscene => Looking at painting of Dana
					isFullCutsceneActive() && isCurrentChapter("Chapter7") &&
					isCurrentCutsceneMasterId(0x12040)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0xce0)	&&
					isCurrentCutsceneSectionDataId(0x11330)
				) &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 2 => Failsafe; trigger on chapter change
				isChapterFinishing("Chapter7")
			)
		)},
	"a_Chapter8Complete": function Chapter8Complete() { return
		never(
			!isInGame()					||
			isEventViewerActive()
		) && 
		(	
			(	// Alt 1 => Ending A (Talk to Fortune Teller AND Homunculus => return to Hugo)
				once(	// Identifies Cutscene => Talk to Homunculus
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x8b640)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x2d440)	&&
					isCurrentCutsceneSectionDataId(0x42750)
				) &&
				once(	// Identifies Cutscene => Summon Dr. Wagner with Homunculus
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x10ef00)		&&
					isCurrentCutsceneSectionId_1(0x9)		&&
					isCurrentCutsceneSectionId_2(0x8)		&&
					isCurrentCutsceneMasterDataId(0xb620)	&&
					isCurrentCutsceneSectionDataId(0xf4d0)
				) &&
				once(	// Identifies Cutscene => Dr. Wagner confronts Hugo
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xe4800)		&&
					isCurrentCutsceneSectionId_1(0x9)		&&
					isCurrentCutsceneSectionId_2(0xa)		&&
					isCurrentCutsceneMasterDataId(0x66aa0)	&&
					isCurrentCutsceneSectionDataId(0x5d060)
				) &&
				isMargaretteAncestor() &&
				isFullCutsceneSequenceEnding()
			) || 
			(	// Alt 2 => Ending B1 (Talk to Fortune Teller => return to Hugo)
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xd5440)		&&
					isCurrentCutsceneSectionId_1(0x7)		&&
					isCurrentCutsceneSectionId_2(0x6)		&&
					isCurrentCutsceneMasterDataId(0x41550)	&&
					isCurrentCutsceneSectionDataId(0x2b420)
				) &&
				once(	// Identifies Cutscene => Hugo inside old Alchemist house collapsing
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x716c0)		&&
					isCurrentCutsceneSectionId_1(0x9)		&&
					isCurrentCutsceneSectionId_2(0xa)		&&
					isCurrentCutsceneMasterDataId(0x239f0)	&&
					isCurrentCutsceneSectionDataId(0x19ef0)
				) &&
				once(	// Identifies Cutscene => Eike consoling Margarette
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xf3c80)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x91c30)	&&
					isCurrentCutsceneSectionDataId(0x62030)
				) &&
				isMargaretteAncestor() &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 3 => Ending B2 (Talk to Homunculus => return to Hugo)
				once(	// Identifies Cutscene => Talk to Hugo and Margarette
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xfbd00)		&&
					isCurrentCutsceneSectionId_1(0x5)		&&
					isCurrentCutsceneSectionId_2(0x4)		&&
					isCurrentCutsceneMasterDataId(0x5ff00)	&&
					isCurrentCutsceneSectionDataId(0x26f30)
				) &&
				once(	// Identifies Cutscene => Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xc4e40)		&& isPriorCutsceneMasterId(0xfbd00) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x62650)	&&
					isCurrentCutsceneSectionDataId(0x6be0)
				) &&
				isMargaretteAncestor() &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 4 => Ending C (Visit destroyed lab => return to Hugo)
				once(	// Identifies Cutscene => Talk to Homunculus at square after seeing young Hugo erase old Hugo
					isFullCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x1cbc0)		&&
					isCurrentCutsceneSectionId_1(0x5)		&&
					isCurrentCutsceneSectionId_2(0x4)		&&
					isCurrentCutsceneMasterDataId(0xc8e0)	&&
					isCurrentCutsceneSectionDataId(0x98f0)
				) &&
				isMargaretteAncestor() &&
				isFullCutsceneSequenceEnding()
			) || (	// Alt 5 => Ending D (Did not save Dana => Destroyed Lab)
				once(	// Identifies Cutscene => Flashback to Hugo trying to read burnt documents
					isFullCutsceneActive()  && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x77a40)		&& isPriorCutsceneMasterId(0x29700) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x31fd0)	&&
					isCurrentCutsceneSectionDataId(0x45a10)
				) &&
				once(	// Identifies Cutscene => Eike confronts Hugo at square
					isFullCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x4b140)		&& isPriorCutsceneMasterId(0x77a40) &&
					isCurrentCutsceneSectionId_1(0x5)		&&
					isCurrentCutsceneSectionId_2(0x4)		&&
					isCurrentCutsceneMasterDataId(0x122b0)	&&
					isCurrentCutsceneSectionDataId(0x189f0)
				) &&
				once(	// Identifies Cutscene => Margarette dissapears after Hugo dissappeared
					isFullCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0xc9440)		&& isPriorCutsceneMasterId(0xa00c0) &&
					isCurrentCutsceneSectionId_1(0x3)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x46b50)	&&
					isCurrentCutsceneSectionDataId(0x828a0)
				) &&
				isDanaNotSavedFromPast() && isMargaretteNoAncestor() &&
				isFullCutsceneSequenceEnding()				
			) || (	// Alt 6 => Ending E (Save Dana => Destroyed Lab)
				once(	// Identifies Cutscene => Brought Margarette to present
					isFullCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x101bc0)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x77920)	&&
					isCurrentCutsceneSectionDataId(0x725d0)
				) &&
				once(	// Identifies Cutscene => Margarette confronts Hugo in square
					isFullCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x137500)		&& isPriorCutsceneMasterId(0x101bc0) &&
					isCurrentCutsceneSectionId_1(0xc)		&&
					isCurrentCutsceneSectionId_2(0xd)		&&
					isCurrentCutsceneMasterDataId(0x7bdf0)	&&
					isCurrentCutsceneSectionDataId(0x55290)
				) &&
				isDanaSavedFromPast() && isMargaretteNoAncestor() &&
				isFullCutsceneSequenceEnding()
			) || // Alt 7+8 => Failsafe; triggers on chapter change
			isChapterFinishing("Chapter8_Ancestress") ||
			isChapterFinishing("Chapter8_NoAncestress")
		)},
	"a_MaxAchievementPrologue": function MaxAchievementPrologue() { 		
		let_PercentageBitFlags = const_percentageBitsFlags["Prologue"]
		return generate_FullTrigger_MaxAchievementRate("Prologue", let_PercentageBitFlags)},
	"a_MaxAchievementChapter1": function MaxAchievementChapter1() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter1"]
		return generate_FullTrigger_MaxAchievementRate("Chapter1", let_PercentageBitFlags)},
	"a_MaxAchievementChapter2": function MaxAchievementChapter2() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter2"]
		return generate_FullTrigger_MaxAchievementRate("Chapter2", let_PercentageBitFlags)},
	"a_MaxAchievementChapter3": function MaxAchievementChapter3() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter3"]
		return generate_FullTrigger_MaxAchievementRate("Chapter3", let_PercentageBitFlags)},
	"a_MaxAchievementChapter4": function MaxAchievementChapter4() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter4"]
		return generate_FullTrigger_MaxAchievementRate("Chapter4", let_PercentageBitFlags)},
	"a_MaxAchievementChapter5": function MaxAchievementChapter5() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter5"]
		return generate_FullTrigger_MaxAchievementRate("Chapter5", let_PercentageBitFlags)},
	"a_MaxAchievementChapter6": function MaxAchievementChapter6() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter6"]
		return generate_FullTrigger_MaxAchievementRate("Chapter6", let_PercentageBitFlags)},
	"a_MaxAchievementChapter7": function MaxAchievementChapter7() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter7"]
		return generate_FullTrigger_MaxAchievementRate("Chapter7", let_PercentageBitFlags)},
	"a_MaxAchievementChapter8": function MaxAchievementChapter8() {
		let_PercentageBitFlags = const_percentageBitsFlags["Chapter8"]
		return generate_FullTrigger_MaxAchievementRate("Chapter8", let_PercentageBitFlags)},
	"a_MaxAchievementEpilogue": function MaxAchievementEpilogue() {
		let_PercentageBitFlags = const_percentageBitsFlags["Epilogue"]
		return generate_FullTrigger_MaxAchievementRate("Epilogue", let_PercentageBitFlags)},
	"a_MaxAchievementTotal": function MaxAchievementTotal() {
		function mapAllPercentageBitFlagsToOneDict() {
			let_PercentageBitFlags = {}
			for chapter in const_percentageBitsFlags {
				for memAddr in const_percentageBitsFlags[chapter] {
					addToDictionary(let_PercentageBitFlags, memAddr, const_percentageBitsFlags[chapter][memAddr])
				}
			}
			return let_PercentageBitFlags}
		return generate_FullTrigger_MaxAchievementRate("Total", mapAllPercentageBitFlagsToOneDict())},
	"a_EndingA": function EndingA() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("A")
		) &&
		once(	// Identifies Cutscene => Chosen to have Margarette stay in present + Z-pad breaks
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0xdb780)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x1bb0)	&&
			isCurrentCutsceneSectionDataId(0x32ce0)
		) &&
		once(	// Identifies Cutscene => Finding red jewel in tree at square
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x77f80)		&& isPriorCutsceneMasterId(0xdb780) &&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x25c50)	&&
			isCurrentCutsceneSectionDataId(0x1ac90)
		) &&
		isMargaretteAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("A"))},
	"a_EndingB1": function EndingB1() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("B")
		) &&

		// Below 2 cutscenes, are commented => player can quit and reload game between these cutscenes 
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus
		// 	isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
		// 	isCurrentCutsceneMasterId(0x3dd40)		&&
		// 	isCurrentCutsceneSectionId_1(0x3)		&&
		// 	isCurrentCutsceneSectionId_2(0x2)		&&
		// 	isCurrentCutsceneMasterDataId(0x9d20)	&&
		// 	isCurrentCutsceneSectionDataId(0x1ed10)
		// ) &&
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus part2
		// 	isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
		// 	isCurrentCutsceneMasterId(0x81b00)		&& isPriorCutsceneMasterId(0x3dd40) &&
		// 	isCurrentCutsceneSectionId_1(0x1)		&&
		// 	isCurrentCutsceneSectionId_2(0x2)		&&
		// 	isCurrentCutsceneMasterDataId(0x250f0)	&&
		// 	isCurrentCutsceneSectionDataId(0x13ff0)
		// ) &&

		// Below 2 cutscenes run up to ending credits
		once(	// Identifies Cutscene => Eike returns from sending Margarette back to past
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x613c0)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x43db0)	&&
			isCurrentCutsceneSectionDataId(0x1d5d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x56240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x400d0)	&&
			isCurrentCutsceneSectionDataId(0x16130)
		) &&
		isMargaretteAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("B"))},
	"a_EndingB2": function EndingB2() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("B")
		) &&
		once(	// Identifies Cutscene => Eike talks with Homunculus
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x91240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x44340)	&&
			isCurrentCutsceneSectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Eike gives z-pad back to Homunculus
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x5d2c0)		&& isPriorCutsceneMasterId(0x91240) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x1efd0)	&&
			isCurrentCutsceneSectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x56240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x400d0)	&&
			isCurrentCutsceneSectionDataId(0x16130)
		) &&
		isMargaretteAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("B"))},
	"a_EndingC": function EndingC() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("C")
		) &&
		once(	// Identifies Cutscene => Giving z-pad back to Homunculus
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x8cf00)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x44340)	&&
			isCurrentCutsceneSectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Homunculus has bad feeling
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x7b140)		&& isPriorCutsceneMasterId(0x8cf00) &&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x1d530)	&&
			isCurrentCutsceneSectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike getting roadkilled
			isFullCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0xcb700)		&& isPriorCutsceneMasterId(0x7b140) &&
			isCurrentCutsceneSectionId_1(0x5)		&&
			isCurrentCutsceneSectionId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x1980)	&&
			isCurrentCutsceneSectionDataId(0x1e8d0)
		) &&
		isMargaretteAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("B"))},
	"a_EndingD": function EndingD() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("D")
		) &&
		once(	// Identifies Cutscene => Talk to Homunculus at square
			isFullCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0x709c0)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x4)		&&
			isCurrentCutsceneMasterDataId(0x24770)	&&
			isCurrentCutsceneSectionDataId(0x11790)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and becomes youthfull
			isFullCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xc5b40)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x4)		&&
			isCurrentCutsceneMasterDataId(0x69b40)	&&
			isCurrentCutsceneSectionDataId(0x21b40)
		) &&
		isDanaNotSavedFromPast() && isMargaretteNoAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("D"))},
	"a_EndingE": function EndingE() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("E")
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus
			isFullCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0x88dc0)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x2c3a0)	&&
			isCurrentCutsceneSectionDataId(0x5ca00)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and Dr. Wagner is killed
			isFullCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xbef80)		&&
			isCurrentCutsceneSectionId_1(0x9)		&&
			isCurrentCutsceneSectionId_2(0x8)		&&
			isCurrentCutsceneMasterDataId(0x59f60)	&&
			isCurrentCutsceneSectionDataId(0x155e0)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus some more
			isFullCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xcdcc0)		&& isPriorCutsceneMasterId(0xbef80) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x33230)	&&
			isCurrentCutsceneSectionDataId(0x21780)
		) &&
		isDanaSavedFromPast() && isMargaretteNoAncestor() &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("E"))},
	"a_EndingEXKillHomunculus": function KillHomunculus() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("EX")
		) &&
		once(	// Identifies Cutscene => waking up in limbo with Philosopher Stone and destroy Homunculus
			isFullCutsceneActive() && isItemInInventory("PhilosopherStone") &&
			isExChapterUnlocked() && isPrologueInExMode() &&
			isCurrentChapter("Prologue") 			&&
			isCurrentCutsceneMasterId(0xa7a80)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x394f0)	&&
			isCurrentCutsceneSectionDataId(0x41b0)	&&
			isCurrentMinorCutsceneId(0x1413a0,0x8)	&&			
			isCurrentMinorCutsceneId(0x41b0,0x28)
		) && 
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			isCurrentChapter("Prologue") 			&&
			isCurrentCutsceneMasterId(0x67940)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd220)	&&
			isCurrentCutsceneSectionDataId(0x5a6f0)
		) &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("EX"))},
	"a_EndingEXCureHelena": function CureHelena() { return
		never(
			!isInGame() 			||
			isEventViewerActive()	||
			isViewingEndingFileInExtraMenu("EX")
		) &&
		once(	// Identifies Cutscene => Helena Wagner is cured
			isFullCutsceneActive() && isItemInInventory("PhilosopherStone") &&
			isExChapterUnlocked() && isPrologueInExMode() &&
			isCurrentChapter("Prologue") 			&&
			isCurrentCutsceneMasterId(0x58c00)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x268f0)	&&
			isCurrentCutsceneSectionDataId(0x11bc0)	&&
			isCurrentMinorCutsceneId(0x721f0,0x8)	&&			
			isCurrentMinorCutsceneId(0x11bc0,0x28)
		) &&
		once(	// Identifies cutscene => Immortal Dr. Wagner // Eike lookalike in present talking with delinquents			
			isCurrentChapter("Prologue") 			&&
			isCurrentCutsceneMasterId(0x67940)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd220)	&&
			isCurrentCutsceneSectionDataId(0x5a6f0)
		) &&
		once(isVideoActive()) &&	// Credits video
		trigger_when(
			!isVideoActive() &&		// Trigger when Credits video is over/skipped
			isEndingUnlocked("EX"))},
	"a_EnergyOrbLocatorPresentDay": function EnergyOrbLocatorPresentDay() {
		function measuredComparison() => generate_Tally_PickUpEnergyOrbs(5)
		function measuredIfComparison() => isInGame()
		return // Core group		
			unless(
				isWearingPerformerOutfit()	||
				(
					!isCurrentMapScene("PresentDayCity") 	 && 
					!isCurrentMapScene("PresentNightCityPM") &&
					!isCurrentMapScene("PresentNightCityAM")
				) 
			) &&
			measured(measuredComparison(), measuredIfComparison()) &&
			(
				(	// Alt 1: otherwise pause will lock reset
					never(	// Reset when chapter changes or when using digipad
						isEnergyUnitsDecreasing() ||
						isChapterChanging()) 
				) || ( // Alt 2: always_false to create 1 funcional alt group
					always_false()
				)
			)
		},
	"a_EnergyOrbLocator70s80s": function EnergyOrbLocator70s80s() {
		function measuredComparison() => generate_Tally_PickUpEnergyOrbs(5)
		function measuredIfComparison() => isInGame()
		return // Core group
			unless(
				!isCurrentMapScene("80sColdCity") && !isCurrentMapScene("70sNightCity")
			) &&
			measured(measuredComparison(), measuredIfComparison()) &&
			(
				(	// Alt 1: otherwise pause will lock reset
					never( 	// Reset when chapter changes or when using digipad
						isEnergyUnitsDecreasing() ||
						isChapterChanging()) 
				) || ( // Alt 2: always_false to create 1 funcional alt group
					always_false()
				)
			)
		},
	"a_EnergyOrbLocatorMiddleAges": function EnergyOrbLocatorMiddleAges() {
		function measuredComparison() => generate_Tally_PickUpEnergyOrbs(6)
		function measuredIfComparison() => isInGame()
		return // Core group
			never(	// Reset when chapter changes or when using digipad
				isEnergyUnitsDecreasing() ||
				isChapterChanging()
			) && (
				(	// Alt 1: otherwise pause will lock reset
					unless(
						!isCurrentMapScene("MedievalCity") 				&& 
						!isCurrentMapScene("MedievalNightCity")			&&
						!isCurrentMapScene("ExplodedAlchemistBasement")	&&
						!isCurrentMapScene("MedievalChurch")
					) &&
					measured(measuredComparison(), measuredIfComparison())
				) || ( // Alt 2: always_false to create 1 funcional alt group
					always_false()
				)
			)
		},
	"a_EnergyOrbLocator1900Days": function EnergyOrbLocator1900Days() {
		function measuredComparison() => generate_Tally_PickUpEnergyOrbs(5)
		function measuredIfComparison() => isInGame()
		return // Core group
			never(	// Reset when chapter changes or when using digipad
				isEnergyUnitsDecreasing() 	||
				isChapterChanging()			||
				(isWearingPerformerOutfit() && isCurrentMapScene("PresentDayCity"))	// --> Fix for bug, where player could pick up the energy orb in the 
			) && (																	// 		Brum Estate twice (once before being performer to get frying pan and once after)
				(	// Alt 1: otherwise pause will lock reset 						//		Now it will reset this count, when going back to get frying pan as performer
					unless(	
						!isCurrentMapScene("1900sCity") && !isCurrentMapScene("1900sBrumMansion")
					) &&
					measured(measuredComparison(), measuredIfComparison())
				) || ( // Alt 2: always_false to create 1 funcional alt group
					always_false()
				)
			)
		},
	"a_ShowPocketWatchToPhotographer": function ShowPocketWatchFranssenAncestor() { return
		never (
			!isInGame() ||
			isEventViewerActive()
		) &&
		never (
			!isCurrentChapter("Chapter6") && 
			!isCurrentChapter("Chapter7") &&
			!isCurrentChapter("Chapter8_Ancestress") &&
			!isCurrentChapter("Chapter8_NoAncestress")
		) &&
		once(	// Identifies Cutscene => Showing Franssen in 1902 the pocket watch
			isFullCutsceneActive() && isCurrentSelectedInventoryItem("EggPocketWatch") &&
			isCurrentCutsceneMasterId(0x114c0)		&& 
			isCurrentCutsceneSectionId_1(0xffff)	&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x114a0)	&&
			isCurrentCutsceneSectionDataId(0x114a0)	&&
			isCurrentMinorCutsceneId(0xad50, 0x8)	&&
			isCurrentMinorCutsceneId(0x114a0, 0x28)
		) &&
		trigger_when(isFullCutsceneSequenceEnding())},
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		never(
			!isInGame() 				||
			!isCurrentChapter("Chapter4")	||
			isEventViewerActive()
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using frying pan
				isFullCutsceneActive() && isCurrentSelectedInventoryItem("FryingPan") &&
				isCurrentCutsceneMasterId(0xb0100)		&&
				isCurrentCutsceneSectionId_1(0xd)		&&
				isCurrentCutsceneSectionId_2(0xe)		&&
				isCurrentCutsceneMasterDataId(0x1efb0)	&&
				isCurrentCutsceneSectionDataId(0xae70)),
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using photo shop sign
				isFullCutsceneActive() && isCurrentSelectedInventoryItem("Sign") &&
				isCurrentCutsceneMasterId(0xb0100)		&& 
				isCurrentCutsceneSectionId_1(0xd)		&&
				isCurrentCutsceneSectionId_2(0xe)		&&
				isCurrentCutsceneMasterDataId(0x1eaa0)	&&
				isCurrentCutsceneSectionDataId(0xae70))
		]) &&
		isFullCutsceneSequenceEnding()},
	"a_MeetOldMiriam": function MeetOldMiriam() { return 
		never(
			!isInGame() 				||
			!isCurrentChapter("Chapter7")	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Holding onto rope 
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x43040)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x7ce0)	&&
			isCurrentCutsceneSectionDataId(0xd940)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				isFullCutsceneActive() && isMargaretteAncestor() && 
				isCurrentCutsceneMasterId(0xc7940)		&&
				isCurrentCutsceneSectionId_1(0x1)		&&
				isCurrentCutsceneSectionId_2(0x0)		&&
				isCurrentCutsceneMasterDataId(0x95c0)	&&
				isCurrentCutsceneSectionDataId(0x7410)),
			once(	// Identifies Cutscene => No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				isFullCutsceneActive() && isMargaretteNoAncestor() && 
				isCurrentCutsceneMasterId(0xb2540)		&&
				isCurrentCutsceneSectionId_1(0x1)		&&
				isCurrentCutsceneSectionId_2(0x0)		&&
				isCurrentCutsceneMasterDataId(0x95c0)	&&
				isCurrentCutsceneSectionDataId(0x6cf0))
		]) &&
		isFullCutsceneSequenceEnding()},
	"a_GetOrnamentalEgg": function AcquireOrnamentalEgg() { return
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter1") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Acquiring ornamental egg from performer
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x19380)		&& 
			isCurrentCutsceneSectionId_1(0x7)		&&
			isCurrentCutsceneSectionId_2(0x8)		&&
			isCurrentCutsceneMasterDataId(0x5e60)	&&
			isCurrentCutsceneSectionDataId(0x134f0)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_GetExChapterOrnamentalEgg": function GetExChapterOrnamentalEgg() { return
		never(
			!isInGame() ||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => EX Chapter, performer throws egg
			isFullCutsceneActive() &&
			isExChapterUnlocked() && isPrologueInExMode() &&
			isCurrentChapter("Prologue") 			&&
			isCurrentCutsceneMasterId(0x30780)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd5f0)	&&
			isCurrentCutsceneSectionDataId(0xe10)	&&
			isCurrentMinorCutsceneId(0x7fd10,0x8)	&&			
			isCurrentMinorCutsceneId(0xe10,0x28)
		) &&
		trigger_when(
			isItemInInventory("OrnamentalEgg") && 
			isFullCutsceneSequenceEnding())},
	"a_EggCollection": function EggCollection() { return 
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter1") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Exchanging egg for frying pan
			isFullCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
			isCurrentCutsceneMasterId(0x2f9c0)		&& 
			isCurrentCutsceneSectionId_1(0x7)		&&
			isCurrentCutsceneSectionId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x5400)	&&
			isCurrentCutsceneSectionDataId(0x249e0)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_AlertBarmanOfFire": function AlertBarmanOfFire() { return 
		never (
			!isInGame() ||
			isEventViewerActive()
		) &&
		never (
			!isCurrentChapter("Chapter3") && !isCurrentChapter("Chapter4")
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 3
				isFullCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
				isCurrentChapter("Chapter3") 			&&
				isCurrentCutsceneMasterId(0x32200)		&& 
				isCurrentCutsceneSectionId_1(0x7)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5400)	&&
				isCurrentCutsceneSectionDataId(0x249e0)),
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 4
				isFullCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
				isCurrentChapter("Chapter4") 			&&
				isCurrentCutsceneMasterId(0x2f9c0)		&& 
				isCurrentCutsceneSectionId_1(0x7)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5400)	&&
				isCurrentCutsceneSectionDataId(0x249e0))]
		) &&
		isFullCutsceneSequenceEnding()},
	"a_RunningAcrossThe90s": function RunningAcrossThe90s() {
		function measuredComparison() { return
			tally(2, [
				once(
					isSmallCutsceneActive() &&
					(
						isCurrentMapScene("PresentDayCity") 	|| 
						isCurrentMapScene("PresentNightCityPM") ||
						isCurrentMapScene("PresentNightCityAM")
					) &&
					isTalkingTo("JoggingMan_Present")),
				once(
					isSmallCutsceneActive() &&
					isCurrentMapScene("70sNightCity") &&
					isTalkingTo("JoggingMan_80s")),
			])}
		return 
			never(	
				!isInGame() 		||
				!isCurrentChapter("Chapter3") && !isCurrentChapter("Chapter4") && !isCurrentChapter("Chapter5")
			) &&
			measured(measuredComparison()) &&
			trigger_when(isNoCutsceneActive())},
	"a_ShowEggTownPlanter": function ShowEggTownPlanter() { return 
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter2") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Show off egg to town planter
			isFullCutsceneActive() && isCurrentSelectedInventoryItem("OrnamentalEgg") &&
			isCurrentCutsceneMasterId(0xde00)		&& 
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x29d0)	&&
			isCurrentCutsceneSectionDataId(0xb400)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_EggPocketWatchForCoffee": function IntroduceEggCollecting2() { return  
		never (
			!isInGame() 					||
			isEventViewerActive()	||
			!isCurrentChapter("Chapter6") && !isCurrentChapter("Chapter7") && 
			!isCurrentChapter("Chapter8_Ancestress") && !isCurrentChapter("Chapter8_NoAncestress")
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Instantly pay for the coffee with egg shaped pocket watch
				isFullCutsceneActive() && isCurrentMapScene("1900sCity") && 
				isCurrentCutsceneMasterId(0x8b440) 		&&
				isCurrentCutsceneSectionId_1(0x5)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5ac20)	&&
				isCurrentCutsceneSectionDataId(0x1de70)	&&
				isCurrentMinorCutsceneId(0xdefe0, 0x8)			&&
				isCurrentMinorCutsceneId(0x2c3d0, 0x2c)),
			once(	// Identifies Cutscene => Drank coffee before eqcuiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
				isFullCutsceneActive() && isCurrentMapScene("1900sCity") && 
				isCurrentCutsceneMasterId(0xac4c0) 		&&
				isCurrentCutsceneSectionId_1(0x1)		&&
				isCurrentCutsceneSectionId_2(0x2)		&&
				isCurrentCutsceneMasterDataId(0x5ac20)	&&
				isCurrentCutsceneSectionDataId(0x1de70)	&&
				isCurrentMinorCutsceneId(0x7ec30, 0x8)			&&
				isCurrentMinorCutsceneId(0x2f730, 0x2c))
		]) &&
		isFullCutsceneSequenceEnding()},
	"a_PocketWatchCollection": function PocketWatch() { return 
		never (
			!isInGame() 					||
			isEventViewerActive()	||
			!isCurrentChapter("Chapter7")
		) &&
		once(	// Identifies Cutscene => Show off egg pocket watch to barman
			isFullCutsceneActive() && isItemInInventory("EggPocketWatch") &&
			isCurrentCutsceneMasterId(0x8ce80) 		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x4c600)	&&
			isCurrentCutsceneSectionDataId(0x236a0)	&&
			isCurrentMinorCutsceneId(0x70640, 0x8)	&&
			isCurrentMinorCutsceneId(0x236a0, 0x28)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_PocketWatchReminiscing": function PocketWatchReminiscing() { return
		never (
			!isInGame() 					||
			isEventViewerActive()	||
			!isCurrentChapter("Chapter8_Ancestress") && !isCurrentChapter("Chapter8_NoAncestress")
		) &&
		once(	// Identifies Cutscene => Eike and Eckart talk about film director and his pocket watches
			isFullCutsceneActive() && isItemInInventory("EggPocketWatch") &&
			isCurrentCutsceneMasterId(0x8dcc0) 		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x31a90)	&&
			isCurrentCutsceneSectionDataId(0xa420)	&&
			isCurrentMinorCutsceneId(0xdfbc0, 0x8)	&&
			isCurrentMinorCutsceneId(0xa420, 0x28)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_EikeThePyromancer": function EikeThePyromancer() { return
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter2")	||
			isEventViewerActive() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into pyromancer statue
			isTreeReplacedByStatue() && isCrowdScaredWithLighter() &&			
			isFullCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
			isCurrentCutsceneMasterId(0x3b240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x340e0)	&&
			isCurrentCutsceneSectionDataId(0x7130)
		) &&
		isCutsceneSectionEnding()},
	"a_EikeTheMagician": function EikeTheMagician() { return
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter2")	||
			isEventViewerActive() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into magician statue
			isTreeReplacedByStatue() && isCrowdScaredWithCellphone() &&			
			isFullCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
			isCurrentCutsceneMasterId(0x3b240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x340e0)	&&
			isCurrentCutsceneSectionDataId(0x7130)
		) &&
		isCutsceneSectionEnding()},
	"a_EikeTheFlorist": function EikeTheFlorist() { return 
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter2")	||
			isEventViewerActive() 
		) &&
		once(	// Identifies Cutscene => Returning back to present, tree changes into flowers
			isTreeReplacedByFlowers() &&
			isFullCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
			isCurrentCutsceneMasterId(0x3b240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x340e0)	&&
			isCurrentCutsceneSectionDataId(0x7130)
		) &&
		isCutsceneSectionEnding()},
	"a_BarmansChildren": function BarmansChildren() { return
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter5")	||
			isEventViewerActive() 
		) &&
		once(	// Identifies Cutscene => Talk to barman about grandchildren
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0xd0200)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x3d290)	&&
			isCurrentCutsceneSectionDataId(0x92f30)
		) &&
		isCutsceneSectionEnding()},
	"a_LostYoungCouple1": function LostYoungCouple1() {
		function measuredComparison() { return
			tally(6, [
				once(	// 1st talk with woman
					isSmallCutsceneActive() && // Below line --> When having talked to other half of couple already, this isLostYoungCoupleProgressChap2 would become 0x1 at same time isNPCtalkCountIncreasingToMax() counts
					(isLostYoungCoupleProgressChap2(0x0) || isLostYoungCoupleProgressChap2(0x1)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") && 
					isNPCtalkCountIncreasingToMax("YoungCoupleWoman_MiddleAges", "Chap2_WestGate_BeforeTalkingToBoth") &&	
					isInteractionChapterId(0x163) && isInteractionId(0x420)),
				once(	// 1st talk with man
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap2(0x0) || isLostYoungCoupleProgressChap2(0x1)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasingToMax("YoungCoupleMan_MiddleAges", "Chap2_EastNearHay_BeforeTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x40d)),
				once( 	// 2nd talk with woman; is only available when having talked to both at least once
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap2(0x1) || isLostYoungCoupleProgressChap2(0x2)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap2_WestGate_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x421)),
				once(	// 2nd talk with man; is only available when having talked to both at least once
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap2(0x1) || isLostYoungCoupleProgressChap2(0x2)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleMan_MiddleAges", "Chap2_EastNearHay_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x40e)),
				once(	// 3rd talk with woman
					isSmallCutsceneActive() &&
					isLostYoungCoupleProgressChap2(0x3) &&
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap2_EastNearHay_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x422)),
				once(	// 3rd talk with man
					isSmallCutsceneActive() &&
					isLostYoungCoupleProgressChap2(0x3) &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleMan_MiddleAges", "Chap2_WestGate_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x40f))
			])}
		return 
			never(
				!isInGame() || 
				!isCurrentChapter("Chapter2")
			) &&
			measured(measuredComparison(), isCurrentMapScene("MedievalNightCity")) &&
			trigger_when(isNoCutsceneActive())},
	"a_LostYoungCouple2": function LostYoungCouple2() {  
		function measuredComparison() { return
			tally(6, [
				once(	// 1st talk with woman
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap3(0x0) || isLostYoungCoupleProgressChap3(0x1)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleWoman_MiddleAges", "Chap3_NearNorthEastGate_BeforeTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x423)),
				once(	// 1st talk with man
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap3(0x0) || isLostYoungCoupleProgressChap3(0x1)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap3_NearWell_BeforeTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x410)),
				once(	// 2nd talk with woman; only available when talking to both at least once
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap3(0x1) || isLostYoungCoupleProgressChap3(0x2)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleWoman_MiddleAges", "Chap3_NearNorthEastGate_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x424)),
				once(	// 2nd talk with man; only available when talking to both at least once
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap3(0x1) || isLostYoungCoupleProgressChap3(0x2)) &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap3_NearWell_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x411)),
				once(	// 3rd talk with woman
					isSmallCutsceneActive() &&
					isLostYoungCoupleProgressChap3(0x3) &&
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleWoman_MiddleAges", "Chap3_OutsideChurch_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x425)),
				once(	// 3rd talk with man
					isSmallCutsceneActive() &&
					isLostYoungCoupleProgressChap3(0x3) &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap3_TownSquare_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x412))
			])}
		return 
			never(
				!isInGame() || 
				!isCurrentChapter("Chapter3")
			) &&
			measured(measuredComparison(), isCurrentMapScene("MedievalNightCity")) &&
			trigger_when(isNoCutsceneActive())},
	"a_LostYoungCouple3" : function LostYoungCouple3() {
		function measuredComparison() { return
			tally(6, [
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x0) || isLostYoungCoupleProgressChap4(0x1)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap4_OutsideChurch_BeforeTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x426)),
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x0) || isLostYoungCoupleProgressChap4(0x1)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleMan_MiddleAges", "Chap4_TownSquare_BeforeTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x413)),
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x1) || isLostYoungCoupleProgressChap4(0x2)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap4_OutsideChurch_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x427)),
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x1) || isLostYoungCoupleProgressChap4(0x2)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleMan_MiddleAges", "Chap4_TownSquare_AfterTalkingToBoth") &&
					isInteractionChapterId(0x163) && isInteractionId(0x414)),
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x2) || isLostYoungCoupleProgressChap4(0x3)) &&	
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap4_NearBakery_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x428)),
				once(
					isSmallCutsceneActive() &&
					(isLostYoungCoupleProgressChap4(0x2) || isLostYoungCoupleProgressChap4(0x3)) &&	
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleMan_MiddleAges", "Chap4_NearBakery_AfterLocationSwitch") &&
					isInteractionChapterId(0x163) && isInteractionId(0x415))				
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter4")
			) &&
			measured(measuredComparison(), isCurrentMapScene("MedievalNightCity")) &&
			trigger_when(isNoCutsceneActive())},
	"a_LostYoungCouple4": function LostYoungCouple4() {
		function measuredComparison() { return
			tally(getMaxTalkCountFor("YoungCoupleMan_MiddleAges", "Chap5_NearSouthEastGate"), 
				repeated(1,
					isSmallCutsceneActive() &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap5_NearSouthEastGate") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x416))
			)}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter5")
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(isNoCutsceneActive())},
	"a_LostYoungCouple5": function LostYoungCouple5() {
		function measuredComparison_NoAncestor() { return
			tally(4, [
				repeated(2,	// NoAncestor path has less dialogue => count up 2, when at max talkCount => both measures are using same count (4)
					isSmallCutsceneActive() && 
					isMargaretteNoAncestor() &&
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap7_TownSquare") &&
					isInteractionChapterId(0x3b) && isInteractionId(0x429)),
				repeated(getMaxTalkCountFor("YoungCoupleMan_MiddleAges","Chap7_OutsideChurch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap7_OutsideChurch") &&
					isInteractionChapterId(0x3b) && isInteractionId(0x418))
			])}
		function measuredComparison_Ancestor() { return
			tally(4, [
				// once(	// 1st talk with woman		// Commented block FIXfor --> "YoungCoupleWoman_MiddleAges"-"Chap7_TownSquare" and "YoungCoupleWoman_MiddleAges"-"Chap4_OutsideChurch_AfterTalkingToBoth" use same MemAddrTalkCount
				// 	isSmallCutsceneActive() &&
				// 	isMargaretteAncestor() &&
				// 	isTalkingTo("YoungCoupleWoman_MiddleAges") &&
				// 	isNPCtalkCountIncreasing("YoungCoupleWoman_MiddleAges", "Chap7_TownSquare") &&
				// 	isInteractionChapterId(0x3b) && isInteractionId(0x428)),
				repeated(2,	// 2nd talk with woman, with dialogue option		// repeated Fixfor --> mentioned above
					isSmallCutsceneActive() &&
					isMargaretteAncestor() &&
					isTalkingTo("YoungCoupleWoman_MiddleAges") &&
					isNPCtalkCountAtMax("YoungCoupleWoman_MiddleAges", "Chap7_TownSquare_Choice") &&
					isInteractionChapterId(0x3b) && isInteractionId(0x429)),
				repeated(getMaxTalkCountFor("YoungCoupleMan_MiddleAges","Chap7_OutsideChurch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasing("YoungCoupleMan_MiddleAges", "Chap7_OutsideChurch") &&
					isInteractionChapterId(0x3b) && isInteractionId(0x418))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter7")
			) &&
			(
				measured(measuredComparison_NoAncestor(), isMargaretteNoAncestor()) || 
				measured(measuredComparison_Ancestor(), isMargaretteAncestor())
			) &&
			trigger_when(isNoCutsceneActive())},
	"a_LostYoungCouple6": function LostYoungCouple6() { 
		function measuredComparison() { return
			tally(2, [
				once(	// 1st talk with man, having a dialogue option
					isSmallCutsceneActive() &&
					isWomanAdvisedBeTruthful() &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&
					isNPCtalkCountIncreasingToMax("YoungCoupleMan_MiddleAges", "Chap8_OutsideChurch_AfterExperiment_WomanTruthful") &&
					isInteractionChapterId(0x13) && isInteractionId(0x41c)),
				once(	// 2nd talk with man after telling him about 'lovers never destines to meet'
						// There's no TalkCount for the dialogue that comes after the dialogue choice => count this one differently
					isSmallCutsceneActive() &&		
					isWomanAdvisedBeTruthful() &&
					isManToldLoversNeverDestinedMeet() &&
					isTalkingTo("YoungCoupleMan_MiddleAges") &&					
					isInteractionChapterId(0x13) && isInteractionId(0x433))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter8")
			) &&
			measured(measuredComparison(), isCurrentMapScene("MedievalCity")) &&
			trigger_when(isNoCutsceneActive())},
	"a_EnigmaticCouple1": function EnigmaticCouple1() {
		function measuredComparison() { return
			tally(4, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap1Prologue_TownSquare"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap1Prologue_TownSquare") &&
					isInteractionId(0x2cc)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap1Prologue_NearBar"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreasing("CoatedMan_Present", "Chap1Prologue_NearBar") &&
					isInteractionId(0x2c1))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Prologue") && !isCurrentChapter("Chapter1")
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(isNoCutsceneActive())},
	"a_EnigmaticCouple2": function EnigmaticCouple2() { 
		function measuredComparison_onIncrease() { return	// Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionId(0x2d0)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap3_NearAntiqueShop"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreasing("CoatedMan_Present", "Chap3_NearAntiqueShop") &&
					isInteractionId(0x2c4))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionId(0x2d0)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap3_NearAntiqueShop"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap3_NearAntiqueShop") &&
					isInteractionId(0x2c4))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter3")
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(!isSmallCutsceneActive())},
	"a_EnigmaticCouple3": function EnigmaticCouple3() {
		function measuredComparison_onIncrease() { return // Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionId(0x2d0)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap4_HaupStrUnderArch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreasing("CoatedMan_Present", "Chap4_HaupStrUnderArch") &&
					isInteractionId(0x2c5))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionId(0x2d0)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap4_HaupStrUnderArch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap4_HaupStrUnderArch") &&
					isInteractionId(0x2c5))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter4")
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(isNoCutsceneActive())},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		function measuredComparison_BrumLibrary_onIncrease() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2d5)),
				repeated(2, // --> overwrite of '''getMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumLibrary")''', both measures must have same count
					isSmallCutsceneActive() && isBrumEstateLibrary() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumLibrary") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2c9))
			])}
		function measuredComparison_BrumLibrary_onMax() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2d5)),
				repeated(2, // --> overwrite of 'getMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumLibrary")', all measures must have same count
					isSmallCutsceneActive() && isBrumEstateLibrary() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumLibrary") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2c9))
			])}
		function measuredComparison_BrumMuseum_onIncrease() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2d5)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumMuseum"), 
					isSmallCutsceneActive() && isBrumEstateMuseum() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreasing("CoatedMan_Present", "Chap5_NorthEastGate_BrumMuseum") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2ca))
			])}
		function measuredComparison_BrumMuseum_onMax() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2d5)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumMuseum"), 
					isSmallCutsceneActive() && isBrumEstateMuseum() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumMuseum") &&
					isInteractionChapterId(0x4b) && isInteractionId(0x2ca))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter5")
			) &&
			trigger_when(isNoCutsceneActive()) &&
			(measured(measuredComparison_BrumMuseum_onIncrease()) || measured(measuredComparison_BrumMuseum_onMax()) ||
			measured(measuredComparison_BrumLibrary_onIncrease()) || measured(measuredComparison_BrumLibrary_onMax()))},
	"a_EnigmaticCouple5": function EnigmaticCouple5() {
		function measuredComparison_onIncrease() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap7_SouthGate"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreasing("CoatedWoman_Present", "Chap7_SouthGate") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2d3)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap7_NorthWestGate"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreasing("CoatedMan_Present", "Chap7_NorthWestGate") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2c8))
			])}
		function measuredComparison_onMax() { return
			tally(3, [
				repeated(getMaxTalkCountFor("CoatedWoman_Present","Chap7_SouthGate"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap7_SouthGate") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2d3)),
				repeated(getMaxTalkCountFor("CoatedMan_Present","Chap7_NorthWestGate"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap7_NorthWestGate") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2c8))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter7")
			) &&
			(measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true())) &&
			trigger_when(isNoCutsceneActive())},
	"a_BecomeThePerformer": function BecomeThePerformer() {	return
		never(
			!isInGame()				||
			isEventViewerActive() 	||
			isNewCutsceneLoading()
		) &&
		once(	// Identifies Cutscene => Eike gives himself a message as performer
			isFullCutsceneActive() && isCurrentChapter("Chapter4") &&
			isCurrentSelectedInventoryItem("Jugglery") &&
			isWearingPerformerOutfit()				&&
			isCurrentCutsceneMasterId(0x1a300)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd440)	&&
			isCurrentCutsceneSectionDataId(0x3a00)
		) &&
		trigger_when(isCutsceneSectionEnding())},
	"a_GiveMargaretteCake": function GiveMargaretteCake() { return 
		never(
			!isInGame()					||
			isEventViewerActive() 	||
			!isCurrentSelectedInventoryItem("Cake")	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 1st time
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x10b000)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xadb40)	&&
			isCurrentCutsceneSectionDataId(0x5d4a0)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_PerformerGoingExtraMile": function PerformerGoingExtraMile(){
		function measuredComparison() { return
			tally(7, [
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BlondeYoungBoy_Present") &&
					isNPCtalkCountIncreasingToMax("BlondeYoungBoy_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionChapterId(0x44) && isInteractionId(0x39c)),	// IDs last dialogue sequence on this NPC's appearance
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteMother_Present") &&
					isNPCtalkCountIncreasingToMax("BrunetteMother_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionChapterId(0x44) && isInteractionId(0x336)),
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteYoungGirl_Present") &&
					isNPCtalkCountIncreasingToMax("BrunetteYoungGirl_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionChapterId(0x44) && isInteractionId(0x323)),
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BlondeOldWomanOrangeSweater_Present") &&
					isNPCtalkCountIncreasingToMax("BlondeOldWomanOrangeSweater_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionChapterId(0x44) && isInteractionId(0x32c)),
				once(	// This appearance does not have a memory address for talk count
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteAdultManGlasses_Present") &&
					isCurrentMapScene("PresentTownHall") &&
					isInteractionChapterId(0x29) && isInteractionId(0x3c6)),
				once(	// This appearance does not have a memory address for talk count
					isSmallCutsceneActive() &&
					isTalkingTo("BlondeElderlyWoman_Present") &&
					isCurrentMapScene("PresentTownHall") &&
					isInteractionChapterId(0x29) && isInteractionId(0x3cc)),
				once(	// This counts Eike, giving egg to Eike/yourself
					isFullCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentSelectedInventoryItem("Jugglery") &&
					isCurrentCutsceneMasterId(0x1a300)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0xd440)	&&
					isCurrentCutsceneSectionDataId(0x3a00))
			])}
		return 
			never(	
				!isInGame() 					||
				!isCurrentChapter("Chapter4")	||
				repeated(300, !isWearingPerformerOutfit())		// ---> Repeat is necessary, because bit flag for isWearingPerformerOutfit() 
			) &&												// 		changes to 0 for a few frames when loading into townhall/city 
			measured(measuredComparison(), always_true()) &&	// 		=> we don't want to reset that count here 
			trigger_when(isCutsceneSectionEnding())},
	"a_ScareEveryone": function ScareEveryone() {
		function measuredComparison() { return
			tally(7, [	
				once(	// Identifies cutscene => scaring spaghetti man in present with cellphone; lighter can't be used in this case, since Dana hasn't given it yet
					isFullCutsceneActive() && isCurrentSelectedInventoryItem("Cellphone") &&
					isCurrentCutsceneMasterId(0x9000)		&&
					isCurrentCutsceneSectionId_1(0xffff)	&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x9000)	&&
					isCurrentCutsceneSectionDataId(0x9000)	&&
					isCurrentMinorCutsceneId(0x5f80, 0x8)	&&
					isCurrentMinorCutsceneId(0x9000, 0x28)),
				repeated(4,	// Identifies cutscene => scaring crowd with cellphone; Add counts +4, instead of below cutscene
					isFullCutsceneActive() && isCurrentSelectedInventoryItem("Cellphone") &&
					isCurrentCutsceneMasterId(0xc6e00)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x5ad0)	&&
					isCurrentCutsceneSectionDataId(0x55b0)	&&
					isCurrentMinorCutsceneId(0x2451a0, 0x8)	&&
					isCurrentMinorCutsceneId(0x55b0, 0x28)),
				repeated(4,	// Identifies cutscene => scaring crowd with lighter; Add counts +4, instead of above cutscene
					isFullCutsceneActive() && isCurrentSelectedInventoryItem("Lighter") &&
					isCurrentCutsceneMasterId(0xa84c0)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x2e40)	&&
					isCurrentCutsceneSectionDataId(0xb220)	&&
					isCurrentMinorCutsceneId(0x2354f0, 0x8)	&&
					isCurrentMinorCutsceneId(0xb220, 0x28)),
				once(	// Identifies cutscene => scaring eccentric girl
					isSmallCutsceneActive() &&
					(isCurrentSelectedInventoryItem("Lighter") || isCurrentSelectedInventoryItem("Cellphone")) &&
					isNPCtalkCountAtMax("EccentricGirl_MiddleAges", "Chap2_TownSquare") &&
					isInteractionChapterId(0x163) && isInteractionId(0x314)),
				once(	// Identifies cutscene => scaring aspiring apprentice
					isSmallCutsceneActive() &&
					(isCurrentSelectedInventoryItem("Lighter") || isCurrentSelectedInventoryItem("Cellphone")) &&
					isNPCtalkCountIncreasingToMax("AspiringApprentice_MiddleAges", "Chap2_SouthEastGate") &&
					isInteractionChapterId(0x163) && isInteractionId(0x2e3))
			])}
		return 
			never(	
				!isInGame() 	||
				!isCurrentChapter("Chapter2")
			) &&
			(
				(
					unless(
						!isCurrentMapScene("MedievalNightCity") && !isCurrentMapScene("CafeSonnePresent")			
					) &&
					measured(measuredComparison(), isInGame() && isCurrentChapter("Chapter2")) &&
					trigger_when(isNoCutsceneActive())
				) || (
					always_false()
				)
			)},
	"a_FreeMeal": function FreeMeal() { return
		never(
			!isInGame()						||
			isEventViewerActive() 			||
			!isCurrentChapter("Chapter5")	||
			isFirePutOutByEike()
		) &&
		once(	// Identifies Cutscene => Barman gives us free meal
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x62840)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x261a0)	&&
			isCurrentCutsceneSectionDataId(0x6cc0)	&&
			isCurrentMinorCutsceneId(0x9bd60, 0x8)	&&
			isCurrentMinorCutsceneId(0x6cc0, 0x28)
		) &&
		once(	// Identifies Cutscene => Reading book whilst barman get Eike his meal + poison
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0xf9cc0)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x5eb0)	&&
			isCurrentCutsceneSectionDataId(0xf3df0)	&&
			isCurrentMinorCutsceneId(0x2aea60, 0x8)	&&
			isCurrentMinorCutsceneId(0xf3df0, 0x28)
		) &&
		trigger_when(isCutsceneSectionEnding())},
	"a_NewCakeInvented": function NewCakeInvented() { return
		never(
			!isInGame()					||
			isEventViewerActive() 	||
			!isCurrentSelectedInventoryItem("Cake")	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 2nd time
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x1fd80)		&&
			isCurrentCutsceneSectionId_1(0xffff)	&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x1fd50)	&&
			isCurrentCutsceneSectionDataId(0x1fd50)	&&
			isCurrentMinorCutsceneId(0x153d0, 0x8)	&&
			isCurrentMinorCutsceneId(0x122b0, 0x2c)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_MaxInventory": function MaxInventory(){
		// function measuredComparison() { 
		// 	// CODE BLOCK A; only use one CODE BLOCK
		// 	// let_comparisonsArray = array_map(const_inventoryItems, (item) {	// array_map returns a new array with the comparisons
		// 	// 	let_memAddress = const_inventoryItems[item]["memAddress_Flag_isInInventory"]
		// 	// 	return prev(bit0(let_memAddress)) < bit0(let_memAddress)
		// 	// })
		// 	// let_deductComparisonArray = array_map(const_inventoryItems, (item) {	// array_map returns a new array with the comparisons
		// 	// 	let_memAddress = const_inventoryItems[item]["memAddress_Flag_isInInventory"]
		// 	// 	return deduct(prev(bit0(let_memAddress)) > bit0(let_memAddress))
		// 	// })
		// 	// for deductComparison in let_deductComparisonArray {
		// 	// 	array_push(let_comparisonsArray, deductComparison)
		// 	// }
		// 	// CODE BLOCK B
		// 	let_comparisonsArray = [always_false()]
		// 	for item in const_inventoryItems {
		// 		let_memAddress = const_inventoryItems[item]["memAddress_Flag_isInInventory"]
		// 		array_push(let_comparisonsArray, deduct(prev(bit0(let_memAddress)) > bit0(let_memAddress))) 	// Sub hit comparison
		// 		array_push(let_comparisonsArray, prev(bit0(let_memAddress)) < bit0(let_memAddress)) 			// Add hit comparison
		// 	}
		// 	return tally(20, let_comparisonsArray) // Biggest achievable inventory = 15 (+ 5 starter items)
		// }
		// return  // Trigger
		// 	never(
		// 		isAtTitleScreen()					||
		// 		// !isInGame()					||	// This comparison bugs this achievement => this flag gets turned on at same time delta comparisons become true, FIX = isAtTitleScreen()
		// 		isEventViewerActive()					
		// 	) &&
		// 	measured(measuredComparison(), always_true())},	
		
		// FIX for above code => if item is gained or removed => recalculate all 
		
		function measuredComparison(){ 
			let_biggestPossibleInventory = 20
			// Checks all item_in_inventory_flags => if in inventory 	+1 Add hit
			return 
				tally_of(const_inventoryItems, let_biggestPossibleInventory, (item) {
					let_memAddress = const_inventoryItems[item]["memAddress_Flag_isInInventory"]
					return once(bit0(let_memAddress) == 1)
				})
		}
		return 
			never(	
				isAtTitleScreen()		||
				isEventViewerActive()	||

				// Reset tally count if any item is gained or removed => will recalculate the amount of items in inventory
				// 	Checks if any item_in_inventory_flags has changed
				any_of(const_inventoryItems, (item) {
					let_memAddress = const_inventoryItems[item]["memAddress_Flag_isInInventory"]
					return bit0(let_memAddress) != prev(bit0(let_memAddress))
				})
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(isNoCutsceneActive())},		
	"a_DrunkenGuys": function DrunkenGuys(){
		function measuredComparison() { return
			tally(2, [
				once(	// Identifies Cutscene => talking to slim delinquent
					isSmallCutsceneActive() && 
					isTalkingTo("SlimDelinquent_Present") &&
					isNPCtalkCountIncreasingToMax("SlimDelinquent_Present", "Chap7_CarPark") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2f5)),
				once(	// Identifies Cutscene => talking to broad delinquent
					isSmallCutsceneActive() && 
					isTalkingTo("BroadDelinquent_Present") &&
					isNPCtalkCountIncreasingToMax("BroadDelinquent_Present", "Chap7_CarPark") &&
					isInteractionChapterId(0xb2) && isInteractionId(0x2f0))
			])}
		return 
			never(
				!isCurrentMapScene("PresentNightCityPM")
			) &&
			measured(measuredComparison(), isInGame()) &&
			trigger_when(isNoCutsceneActive())},
	"a_ShortestChapter": function ShortestChapter(){ return
		never(
			!isInGame()						||
			!isCurrentChapter("Chapter4")	||
			isEventViewerActive()			||
			!isCurrentSelectedInventoryItem("FryingPan") ||
			
			// If preventing 1st death in chapter 4 by using the frying pan 
			//	=> black and white picture is not found inside book after death in this chapter
			//	=> Thus can be used as a flag for this achievement
			isItemInInventory("BLackWhitePhoto") 	|| 
			isItemInInventory("BLackWhitePhotoWithPerformer")			 
		) &&
		once(	// Identifies Cutscene => Using frying pan for defence
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x4f200)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x11cd0)	&&
			isCurrentCutsceneSectionDataId(0x3d500)	
		) &&
		isFullCutsceneSequenceEnding()},
	"a_MeetFamousOleg": function MeetFamousOleg(){ return
		never(
			!isInGame()				||
			isEventViewerActive() 	||
			!isCurrentChapter("Chapter7")
		) &&
		once(	// Identifies Cutscene => Talking to Oleg near movie poster
			isFullCutsceneActive() && isCoffeePayed() &&
			isCurrentCutsceneMasterId(0xa0f40)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x45370)	&&
			isCurrentCutsceneSectionDataId(0x5bb90)	&&
			isCurrentMinorCutsceneId(0x8f8e0, 0x8)	&&
			isCurrentMinorCutsceneId(0x5bb90, 0x28)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_ArtInspiration1": function ArtInspiration1() { return
		never(
			!isInGame() 		||
			isChapterChanging() ||
			isBrumEstateLibrary()
		) && 
		trigger_when(isNoCutsceneActive()) &&	// Trigger when cutscene is over
		tally(1, [	// Tally is necessary to trigger when the cutscene is done, otherwise achievement pops during cutscene
			once(
				isSmallCutsceneActive() && 
				isPaintingTowerViewInspired() &&
				isInteractingWith("Painting_TowerView") && 
				(isCurrentMapScene("BrumMuseumDownstairsRoomNight") || isCurrentMapScene("BrumMuseumDownstairsRoomDay")) &&
				isInteractionId(0x124)),
			
			once(
				isSmallCutsceneActive() && 	
				isPaintingSquireCrestInspired() &&
				isInteractingWith("Painting_SquireCrest") && 
				(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
				isInteractionId(0x125)),
			once(
				isSmallCutsceneActive() &&
				isPaintingMarktplatzInspired() &&
				isInteractingWith("Painting_TownSquare") && 
				(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
				isInteractionId(0x126)),
			once(
				isSmallCutsceneActive() &&
				isPaintingAntidoteInspired() &&
				isInteractingWith("Painting_AlchemyLab") && 
				(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
				isInteractionId(0x127)),
			once(
				isSmallCutsceneActive() &&
				isPaintingPerformerInspired() &&
				isInteractingWith("Painting_Performer") && 
				(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
				isInteractionId(0x128)),
			once(
				isSmallCutsceneActive() &&
				isPaintingHouseCollapseInspired() &&
				isInteractingWith("Painting_CollapsedHouse") && 
				(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
				isInteractionId(0x129))
			])},
	"a_ArtInspirationAll": function ArtInspirationAll() {
		function measuredComparison() {
			tally(6, [
				once(
					isSmallCutsceneActive() && 
					isPaintingTowerViewInspired() &&
					isInteractingWith("Painting_TowerView") && 
					(isCurrentMapScene("BrumMuseumDownstairsRoomNight") || isCurrentMapScene("BrumMuseumDownstairsRoomDay")) &&
					isInteractionId(0x124)),
				once(
					isSmallCutsceneActive() && 	
					isPaintingSquireCrestInspired() &&
					isInteractingWith("Painting_SquireCrest") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
					isInteractionId(0x125)),
				once(
					isSmallCutsceneActive() &&
					isPaintingMarktplatzInspired() &&
					isInteractingWith("Painting_TownSquare") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
					isInteractionId(0x126)),
				once(
					isSmallCutsceneActive() &&
					isPaintingAntidoteInspired() &&
					isInteractingWith("Painting_AlchemyLab") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x127)),
				once(
					isSmallCutsceneActive() &&
					isPaintingPerformerInspired() &&
					isInteractingWith("Painting_Performer") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x128)),
				once(
					isSmallCutsceneActive() &&
					isPaintingHouseCollapseInspired() &&
					isInteractingWith("Painting_CollapsedHouse") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x129))
			])}
		return
			never(
				!isInGame() ||
				isChapterChanging()
			) &&
			trigger_when(isNoCutsceneActive()) &&
			measured(measuredComparison(), always_true())},
	"a_ArtAppreciator": function ArtAppreciator() {
		function measuredComparison() {
			tally(8, [
				once(
					isSmallCutsceneActive() && 	
					isInteractingWith("Painting_TowerView") && 
					(isCurrentMapScene("BrumMuseumDownstairsRoomNight") || isCurrentMapScene("BrumMuseumDownstairsRoomDay")) &&
					isInteractionId(0x124)),
				once(
					isSmallCutsceneActive() && 	
					isInteractingWith("Painting_SquireCrest") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
					isInteractionId(0x125)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_TownSquare") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom1Night") || isCurrentMapScene("BrumMuseumUpstairsRoom1Day")) &&
					isInteractionId(0x126)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_AlchemyLab") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x127)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_Performer") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x128)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_CollapsedHouse") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom2Night") || isCurrentMapScene("BrumMuseumUpstairsRoom2Day")) &&	
					isInteractionId(0x129)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_LandscapeTown") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom3Night") || isCurrentMapScene("BrumMuseumUpstairsRoom3Day")) &&	
					isInteractionId(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_Alchemist") && 
					(isCurrentMapScene("BrumMuseumUpstairsRoom3Night") || isCurrentMapScene("BrumMuseumUpstairsRoom3Day")) &&	
					isInteractionId(0xffffffff))
			])}
		return
			never(
				!isInGame() ||
				isChapterChanging()
			) &&
			trigger_when(isNoCutsceneActive()) &&
			measured(measuredComparison(), always_true())},
	"a_AntiquesEule": function AntiquesEule() {
		function measuredComparison() {
			tally(4, [
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_FranssenShopSign") && 
					isInteractionId(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Rope") &&
					isInteractionId(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Antidote") &&
					isInteractionId(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Mask") &&
					isInteractionId(0xffffffff))
			])}
		function measuredIfComparison() { return
			isCurrentMapScene("AntiqueShopEule80s") ||
			isCurrentMapScene("AntiqueShopEulePresent")}
		return
			never(
				!isInGame() ||
				isChapterChanging()
			) &&
			trigger_when(!isSmallCutsceneActive()) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_SeenOlegAsWell": function SeenOlegAsWell() { return
		never(
			!isInGame()				||
			isEventViewerActive() 	||
			!isCurrentChapter("Chapter6") 
		) &&
		once(	// Identifies Cutscene => Talking with man inside Cafe Sonne for 1st time, only in chapter 6
			isSmallCutsceneActive() && isCurrentMapScene("CafeSonne80s") &&
			isTalkingTo("OlderMan_80s") && 
			isInteractionChapterId(0xb2) && isInteractionId(0x3e7) && 
			isNPCtalkCountIncreasing("OlderMan_80s", "Chap6_CafeSonne")
		) &&
		trigger_when(isFullCutsceneSequenceEnding())},
	"a_PocketWatchTo80sBarman": function PocketWatchTo80sBarman() { return
		never(
			!isInGame()			||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Using pocket watch or ornamental egg near barman in 1980s
			isSmallCutsceneActive() && isCurrentMapScene("ColdCityBar") &&
			(
				isCurrentSelectedInventoryItem("EggPocketWatch") ||
				isCurrentSelectedInventoryItem("OrnamentalEgg")
			) &&
			isTalkingTo("Barman_80s") && isInteractionId(0x2ed) &&
			isNPCtalkCountAtMax("Barman_80s", "InsideBar_UsePocketWatchOrEgg")
		) &&
		trigger_when(isFullCutsceneSequenceEnding())},
	"a_SnowyCrimeScene": function SnowyCrimeScene() { return
		never(
			!isInGame()				||
			!isCurrentChapter("Chapter6") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Miriam shot and dying 
			isFullCutsceneActive() && isCurrentMapScene("80sColdCity") &&
			isCurrentCutsceneMasterId(0x756c0)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x4660)	&&
			isCurrentCutsceneSectionDataId(0x4f210) &&
			isCurrentMinorCutsceneId(0xb8b90, 0x8)	&&
			isCurrentMinorCutsceneId(0x4f210, 0x28)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_SaveMiriamBrum": function SaveMiriamBrum() { return
		never(
			!isInGame()						||
			!isCurrentChapter("Chapter6")	||
			isEventViewerActive()			 
		) &&
		once(	// Identifies Cutscene => Eike save Miriam, after running after her
			isFullCutsceneActive() && isCurrentMapScene("80sColdCity") &&
			isCurrentCutsceneMasterId(0xebac0)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x546f0)	&&
			isCurrentCutsceneSectionDataId(0x50b0)	
		) &&
		isFullCutsceneSequenceEnding()},
	"a_HugoMotherChild": function HugoMotherChild() { return
		never(
			!isInGame()					||
			!isCurrentChapter("Chapter5")		||
			isEventViewerActive() 
		) &&
		once(	// Identifies Cutscene => Hugo gets bullied
			isFullCutsceneActive() && 
			isCurrentCutsceneMasterId(0x3ed00)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x3110)	&&
			isCurrentCutsceneSectionDataId(0x3bbc0)	&&
			isCurrentMinorCutsceneId(0x282ae0, 0x8)	&&
			isCurrentMinorCutsceneId(0x3bbc0, 0x28)
		) &&
		isFullCutsceneSequenceEnding()},
 	"a_TimeTravellingCat": function TimeTravellingCat() { return
		never(
			!isInGame() ||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Giving kitten to Sibylla
			isFullCutsceneActive() && isCurrentMapScene("BrumEstateIndoors1900") &&
			isItemInInventory("Kitten") &&
			isCurrentCutsceneMasterId(0x25200)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x2c00)	&&
			isCurrentCutsceneSectionDataId(0x10930)
		) &&
		isKittenGivenToSibylla() &&
		isFullCutsceneSequenceEnding()},
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!isInGame()				||
			!isCurrentChapter("Prologue")	||
			isEventViewerActive()  
		) &&
		once(	// Identifies Cutscene => Eike wakes himself up
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x9c00)		&&
			isCurrentCutsceneMasterDataId(0x9bf0)	&&
			isCurrentCutsceneSectionDataId(0x9bf0)	&&
			isCurrentMinorCutsceneId(0x9bf0, 0x28) &&
			isCurrentMinorCutsceneId(0xea70, 0x8) 	
		) && 
		once(	// Identifies Cutscene => Eike wakes himself up
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x237c0)		&& isPriorCutsceneMasterId(0x9c00) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x18930)	&&
			isCurrentCutsceneSectionDataId(0xae60)
		) && 
		isCutsceneSectionEnding()},
	"a_ErasingEike2": function ErasingEike2() { return
		never(
			!isInGame()				||
			!isCurrentChapter("Chapter7")	||
			isEventViewerActive()  
		) &&
		once(	// Identifies Cutscene => Eike bumps into himself
			isCurrentMinorCutsceneId(0x23ee0, 0x8) 	&&
			isCurrentMinorCutsceneId(0x377e0, 0x28) 	&&
			isCurrentMinorCutsceneId(0x23eb0, 0x2c)
		) && 
		isFullCutsceneSequenceEnding()},
	"a_RottenRope": function RottenRope() { return
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter7") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Holding on to rotten rope
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x15640) 		&&
			isCurrentCutsceneSectionId_1(0x5)		&&
			isCurrentCutsceneSectionId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x7830)	&&
			isCurrentCutsceneSectionDataId(0x2220)
		) &&
		once(	// Identifies Cutscene => Waking up in Limbo after death
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x237c0) 		&& isPriorCutsceneMasterId(0x15640) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x18930)	&&
			isCurrentCutsceneSectionDataId(0xae60)
		) &&
		isCutsceneSectionEnding()},
	"a_TimeEgoFlop": function TimeEgoFlop() { return
		never(
			!isInGame() 					||
			isEventViewerActive() 	|| 
			!isCurrentChapter("Chapter6")
		) &&
		once( // Identifies Cutscene => Roadkilled by Time Ego movie
				isFullCutsceneActive() && 
				isMovieTimeTravelPicked()		&&
				isMovieWorldConquestPicked() 	&&				
				isCurrentCutsceneMasterId(0x77980)		&&
				isCurrentCutsceneSectionId_1(0xa)		&&
				isCurrentCutsceneSectionId_2(0xb)		&&
				isCurrentCutsceneMasterDataId(0x2090)	&&
				isCurrentCutsceneSectionDataId(0x15d50)
			) && 
			isCutsceneSectionEnding()},
	"a_MetYouBefore": function MetYouBefore() { return
		never(
			!isInGame()				||
			!isCurrentChapter("Chapter2") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Talk Dana, seeing through clothing hunch
			isFullCutsceneActive()	&&	
			isCurrentCutsceneMasterId(0x6e480) 		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x45250)	&&
			isCurrentCutsceneSectionDataId(0x143f0)	
		) && 
		once(	// Identifies Cutscene => Getting stabbed from behind
			isFullCutsceneActive()	&&	
			isCurrentCutsceneMasterId(0x1b740) 		&& isPriorCutsceneMasterId(0x6e480) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x1d00)	&&
			isCurrentCutsceneSectionDataId(0x19a20)	
		) && 
		isCutsceneSectionEnding()},
	"a_ExcuseMeMyMy": function ExcuseMeMyMy() { return
		never(
			!isInGame()					||
			isEventViewerActive()	||
			!isCurrentChapter("Chapter3")
		) &&
		once(
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0xb140) && isPriorCutsceneMasterId(0x5aa80) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x5ac0)	&&
			isCurrentCutsceneSectionDataId(0x38b0)	
		) && 
		once(
			isFullCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x1a440) && isPriorCutsceneMasterId(0xb140) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd9a0)	&&
			isCurrentCutsceneSectionDataId(0xca50)	
		) &&
		isCutsceneSectionEnding()}}

// *********************
// ÷ Achievement TEXT ÷
// *********************
const_achievement_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_PrologueComplete": 							{"en": "Defied Fate",															
													"nl": "Lot getrotseerd",
													"fr": "Défié le destine"},
	"a_Chapter1Complete": 							{"en": "Defied Fate... Again",
													"nl": "Lot getrotseerd... nogmaals",
													"fr": "Défié le destin... encore"},
	"a_Chapter2Complete": 							{"en": "Left in the Past"},
	"a_Chapter3Complete": 							{"en": "An Alchemist, a Jewel and a Homunculus"},
	"a_Chapter4CompletePan": 						{"en": "Pan-tastic Resilience"},
	"a_Chapter4CompleteSign": 						{"en": "Through the Lens of Survival"},	
	"a_Chapter5Complete": 							{"en": "Ancient Elixir"}, 
	"a_Chapter6CompleteThriller":					{"en": "Director's Cut: The Time of Reckoning"},
	"a_Chapter6CompleteLove":						{"en": "Director's Cut: Trip for Two"},
	"a_Chapter7Complete":							{"en": "A Friend's Repentance"},
	"a_Chapter8Complete":							{"en": "The whole picture... Or is it?"},
	"a_EndingEXKillHomunculus":						{"en": "The Philosopher's Destiny"},
	"a_EndingEXCureHelena":							{"en": "The Philosopher's Legacy"},
	"a_MaxAchievementPrologue":						{"en": "Homing Instinct"},	
	"a_MaxAchievementChapter1":						{"en": "In the Heat of Time"},	
	"a_MaxAchievementChapter2":						{"en": "Dana Kusch"},		
	"a_MaxAchievementChapter3":						{"en": "The Root of the Problem"},	
	"a_MaxAchievementChapter4":						{"en": "The Monochrome Era"},	
	"a_MaxAchievementChapter5":						{"en": "Meddling with Destiny"},
	"a_MaxAchievementChapter6":						{"en": "The Good Samaritan"},
	"a_MaxAchievementChapter7":						{"en": "Vintage Knots"},
	"a_MaxAchievementChapter8":						{"en": "The Power of Fate"},
	"a_MaxAchievementEpilogue":						{"en": "Eternal Youth"},
	"a_MaxAchievementTotal":						{"en": "The Day of Walpurgis"},
	"a_EndingA":									{"en": "An End to a Strange Experience"},
	"a_EndingB1":									{"en": "No Sense of Finality I"},
	"a_EndingB2":									{"en": "No Sense of Finality II"},
	"a_EndingC": 									{"en": "If only... I had one more attempt."},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "The future is what we make it."},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "The Philosopher's Wisdom"},
	"a_DoctorateTimeTraveling": 					{"en": "Complexities of the Fourth Dimension"}, 
	"a_GetOrnamentalEgg": 							{"en": "A Performer's Clue"}, 
	"a_EggCollection": 								{"en": "A Jovial Exchange"},
	"a_AlertBarmanOfFire": 							{"en": "There's a fire!"}, 
	"a_BarmansChildren":							{"en": "The Barman's Mystery Child"},
	"a_ShowEggTownPlanter": 						{"en": "Cracking Open the Past: Middle Ages"},
	"a_EggPocketWatchForCoffee": 					{"en": "Cracking Open the Past: The Old Century"},
	"a_PocketWatchCollection": 						{"en": "A Hatchless Replica"},
	"a_PocketWatchReminiscing": 					{"en": "The Eggcellent Director's Tale"},
	"a_EikeThePyromancer":							{"en": "The Pyromancer's Legacy"},
	"a_EikeTheMagician": 							{"en": "The Magician's Legacy"},
	"a_EikeTheFlorist": 							{"en": "A Blossoming Plan"},
	"a_LostYoungCouple1": 							{"en": "Yesteryears Couple I: Destined to Miss"},
	"a_LostYoungCouple2": 							{"en": "Yesteryears Couple II: The Place Where We Nigh Met"},
	"a_LostYoungCouple3": 							{"en": "Yesteryears Couple III: Destiny's Promise Fulfilled"},
	"a_LostYoungCouple4": 							{"en": "Yesteryears Couple IV: Man-in-waiting"},
	"a_LostYoungCouple5": 							{"en": "Yesteryears Couple V: Parting"},
	"a_LostYoungCouple6": 							{"en": "Yesteryears Couple VI: Never Destined to Meet"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic Couple I: Prelude"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic Couple II: Tailing"},
	"a_EnigmaticCouple3": 							{"en": "Enigmatic Couple III: Wandering Once More"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic Couple IV: Origins"},
	"a_EnigmaticCouple5": 							{"en": "Enigmatic Couple V: Epilogue"},
	"a_ErasingEike": 								{"en": "That's a big no no."}, 
	"a_ErasingEike2": 								{"en": "Bump... Erased"},
	"a_RottenRope": 								{"en": "Fated to Plunge"},
	"a_MetYouBefore": 								{"en": "Met You Before"},
	"a_DrunkenGuys":								{"en": "A Pair of Delinquents"},
	"a_ShowPocketWatchToPhotographer":				{"en": "Horologic Heritage"},
	"a_TimeTravellingCat":							{"en": "Nine Lives across Generations"},
	"a_SnowyCrimeScene":							{"en": "Picked up a baby the other day."},
	"a_SaveMiriamBrum":								{"en": "Illusive Guardian of the Brums"},
	"a_HugoMotherChild":							{"en": "A Mother's Child"}, 
	"a_SeenOlegAsWell": 							{"en": "The Meditating Man"}, 
	"a_PocketWatchTo80sBarman": 					{"en": "That's nice!"},
	"a_FreeMeal":									{"en": "A Complimentary Dinner"}, 
	"a_TimeEgoFlop":								{"en": "Time Ego Flop"},
	"a_ArtAppreciator": 							{"en": "Strokes of Destiny"}, 
	"a_AntiquesEule": 								{"en": "Timeless Antiques"},
	"a_RunningAcrossThe90s":						{"en": "Running Beyond the 90's... and 80's"},
	"a_ExcuseMeMyMy":								{"en": "My my, so eager to die."},
	"a_BecomeThePerformer":							{"en": "Even I can do that."}, 
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Energy Locator: Present Day"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Energy Locator: Middle Ages"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Energy Locator: The Late 20th Century"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Locator: The Early 20th Century"},
	"a_GiveMargaretteCake": 						{"en": "Time-Spun Sweets"}, 
	"a_ShortestChapter": 							{"en": "Pan in Advance"}, 
	"a_NewCakeInvented": 							{"en": "Legacy of Sweetness"},
	"a_MaxInventory": 								{"en": "Stockpiling Across Eras"},
	"a_PerformerGoingExtraMile": 					{"en": "A Performance Gone the Extra Mile"}, 
	"a_ArtInspiration1": 							{"en": "Art Muse"}, 
	"a_ArtInspirationAll": 							{"en": "Eike Franssen"},
	"a_MeetFamousOleg":								{"en": "The Next Big Thing"},
	"a_ScareEveryone": 								{"en": "Terror of Destinies"}}
// -------------------------------------
const_achievement_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_PrologueComplete": {							"en": "Complete the prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Complete chapter 1",
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},													
	"a_Chapter2Complete": 							{"en": "Complete chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete chapter 4, using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete chapter 4, using a sign"},	
	"a_Chapter5Complete": 							{"en": "Complete chapter 5"}, 
	"a_Chapter6CompleteThriller":					{"en": "Complete chapter 6, by co-directing a thriller picture"},
	"a_Chapter6CompleteLove":						{"en": "Complete chapter 6, by co-directing a love picture"},
	"a_Chapter7Complete":							{"en": "Complete chapter 7"},
	"a_Chapter8Complete":							{"en": "Complete chapter 8"},
	"a_MaxAchievementPrologue":						{"en": "Reach 100% achievement rate for the prologue and EX chapter"},
	"a_MaxAchievementChapter1":						{"en": "Reach 100% achievement rate for chapter 1"},
	"a_MaxAchievementChapter2":						{"en": "Reach 100% achievement rate for chapter 2"},
	"a_MaxAchievementChapter3":						{"en": "Reach 100% achievement rate for chapter 3"},
	"a_MaxAchievementChapter4":						{"en": "Reach 100% achievement rate for chapter 4"},
	"a_MaxAchievementChapter5":						{"en": "Reach 100% achievement rate for chapter 5"},
	"a_MaxAchievementChapter6":						{"en": "Reach 100% achievement rate for chapter 6"},
	"a_MaxAchievementChapter7":						{"en": "Reach 100% achievement rate for chapter 7"},
	"a_MaxAchievementChapter8":						{"en": "Reach 100% achievement rate for chapter 8"},
	"a_MaxAchievementEpilogue":						{"en": "Reach 100% achievement rate for the epilogue"},
	"a_MaxAchievementTotal":						{"en": "Reach 100% total achievement rate"},
	"a_EndingA":									{"en": "Achieve ending A"},
	"a_EndingB1":									{"en": "Achieve ending B1"},
	"a_EndingB2":									{"en": "Achieve ending B2"},
	"a_EndingC": 									{"en": "Achieve ending C"},
	"a_EndingD": 									{"en": "Achieve ending D"},
	"a_EndingE": 									{"en": "Achieve ending E"},
	"a_EndingEXKillHomunculus":						{"en": "Achieve ending EX, by destroying the jewel"},
	"a_EndingEXCureHelena":							{"en": "Achieve ending EX, by creating a miracle cure"},
	"a_DoctorateTimeTraveling": 					{"en": "Get lectured in time-travelling physics during chapter 4"}, 
	"a_RunningAcrossThe90s":						{"en": "Encounter an athletic man in the past, as well as his present self during chapter 3, 4 or 5"},
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from a performer during chapter 1"},
	"a_ShowEggTownPlanter": 						{"en": "Show off your egg collection to the barman's ancestor during chapter 2"},
	"a_EggPocketWatchForCoffee": 					{"en": "Show off your egg collection to the barman's ancestor from chapter 6 onward"},
	"a_BarmansChildren":							{"en": "Discover the truth about the barman's grandchildren during chapter 5"},
	"a_PocketWatchCollection": 						{"en": "Show off your egg collection to the barman during chapter 7"},
	"a_PocketWatchReminiscing": 					{"en": "Reminisce about your egg collection with Eckart during chapter 8"},
	"a_EggCollection": 								{"en": "Exchange an egg for a pan during chapter 1, 3 or 4"},
	"a_AlertBarmanOfFire": 							{"en": "Alert the young boy's grandpa of imminent disaster during chapter 1"},
	"a_GetExChapterOrnamentalEgg" :					{"en": "Acquire one last message during the EX chapter"},	
	"a_ShowPocketWatchToPhotographer":				{"en": "Kindle the joy of watchmaking to an ancestor of the Franssen's"},
	"a_EikeThePyromancer": 							{"en": "Become honored as a pyrokinetic during chapter 2"},
	"a_EikeTheMagician": 							{"en": "Become honored as a magician during chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Planted flowers during chapter 2"},
	"a_MeetOldMiriam":								{"en": "Meet Eckart's wife in Chapter 7"},
	"a_LostYoungCouple1": 							{"en": "Help a lost young couple reunite in The Middle Ages during chapter 2"}, 
	"a_LostYoungCouple2": 							{"en": "Help a lost young couple reunite again in The Middle Ages during chapter 3"},
	"a_LostYoungCouple3": 							{"en": "Reunite the lost young couple in The Middle Ages during chapter 4"},
	"a_LostYoungCouple4": 							{"en": "Consult the young man in The Middle Ages during chapter 5"},
	"a_LostYoungCouple5": 							{"en": "Consult the young couple in The Middle Ages during chapter 7"},
	"a_LostYoungCouple6": 							{"en": "Advise the young man in The Middle Ages during chapter 8"},
	"a_EnigmaticCouple1": 							{"en": "Find the coated man and woman in the present during the prologue or chapter 1"}, 
	"a_EnigmaticCouple2": 							{"en": "Find the coated man and woman in the present during chapter 3"}, 
	"a_EnigmaticCouple3": 							{"en": "Find the coated man and woman in the present during chapter 4"}, 
	"a_EnigmaticCouple4": 							{"en": "Find the coated man and woman in the present during chapter 5"},	
	"a_EnigmaticCouple5": 							{"en": "Find the coated man and woman in the present during chapter 7"},
	"a_ErasingEike": 								{"en": "Warn yourself of your impending demise during the prologue"},
	"a_ErasingEike2": 								{"en": "Run into yourself during chapter 7"}, 
	"a_RottenRope": 								{"en": "Use an aged cable to save yourself in chapter 7"},
	"a_MetYouBefore": 								{"en": "Keep chatting with Dana at the Marktplatz tree during chapter 2"},
	"a_FreeMeal":									{"en": "Enjoy a free supper at Bar Zum Ei during chapter 5"}, 
	"a_DrunkenGuys":								{"en": "Encounter some rascals in chapter 7"},
	"a_ScareEveryone": 								{"en": "Frighten everyone in the past, as well as a person in the present who is indulging some spaghetti, during chapter 2"}, 
	"a_TimeTravellingCat":							{"en": "Gift a feline friend to a girl during or after chapter 4"},
	"a_MeetFamousOleg":								{"en": "Inspire the movie director for a 2nd time in chapter 7"},
	"a_SeenOlegAsWell": 							{"en": "Find someone who has also met the meditating man in chapter 6"},
	"a_PocketWatchTo80sBarman": 					{"en": "Pique someone's interest with an oval shape of your own in the 1980's"},
	"a_HugoMotherChild":							{"en": "Find Hugo outside his house during chapter 5"}, 
	"a_ArtAppreciator": 							{"en": "Admire all original paintings in the Brum Museum"},
	"a_AntiquesEule": 								{"en": "Take a glance at the timeless relics at Antique Shop Eule"},
	"a_ExcuseMeMyMy":								{"en": "Run from the apparition during chapter 3"}, 
	"a_BecomeThePerformer":							{"en": "Become a performer during chapter 4"}, 
	"a_SnowyCrimeScene":							{"en": "Uncover a snowy crime scene during chapter 6"},
	"a_SaveMiriamBrum":								{"en": "Save a member of the Brum family from a predestined death during chapter 6"}, 
	"a_TimeEgoFlop":								{"en": "View every possible movie poster during chapter 6"},
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Collect all 5 energy orbs in present day Lebensbaum"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Collect all 5 energy orbs in medieval Lebensbaum"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Collect all 5 energy orbs in Lebensbaum during the 70's or 80's"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Collect all 5 energy orbs in Lebensbaum, a century ago"},
	"a_GiveMargaretteCake": 						{"en": "Gift a tasty sweet to a someone dear to you"}, 
	"a_NewCakeInvented": 							{"en": "Establish a new line of pastries"},
	"a_ShortestChapter": 							{"en": "Acquire an iron plate before finding a good usage for it"}, 
	"a_MaxInventory": 								{"en": "Acquire the biggest hoard of items in a single playthrough"},
	"a_PerformerGoingExtraMile": 					{"en": "Make sure the performer goes the extra mile for those who would appreciate his gesture, including yourself"}, 	
	"a_ArtInspiration1": 							{"en": "Inspire an acclaimed artist and appraise his work"}, 
	"a_ArtInspirationAll": 							{"en": "Become a beacon of inspiration for an acclaimed artist and appraise all his works"}}


// ****************************
// ÷ Achievement INITIALIZER ÷
// ****************************
//	- Creates achievement objects (accepted by RAscript) based on the achievement dictionary
function initializeAchievements() {
	// Generates the achievement title (with developer tags, if devmode == 1)
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function enterCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (const_utilitySettings_debugMode) {
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
	function generateAchievementDescription(string_achievementDevName, boolean_hasTips, string_devInfo, string_languageCode) {	
		function lookUpAchievementDescription(string_achievementDevName, string_languageCode) {
			return const_achievement_descriptions[string_achievementDevName][string_languageCode]
		}
		function enterDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (const_utilitySettings_debugMode && string_devInfo != "") {
				let_devInfoString = let_devInfoString + " - [DEV: " + string_devInfo + "]"
			}
			return let_devInfoString
		}	
		function enterTipsLink(boolean_hasTips) {
			let_tipsLink = ""
			if (const_utilitySettings_isGuideLinkEnabled && boolean_hasTips == true) let_tipsLink = " - [Tips: " + const_utilitySettings_guideLink + "]"
			return let_tipsLink 
		}
		return lookUpAchievementDescription(string_achievementDevName, string_languageCode) + enterTipsLink(boolean_hasTips) + enterDevInfo(string_devInfo) 
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
				title = generateAchievementTitle(cheevmentName, categoryName, const_utilitySettings_language), 
				badge = let_cheevment["badgeId"],
				type = const_achievement_typeByCategory[categoryName],
				description = generateAchievementDescription(cheevmentName, let_cheevment["hasTips"], let_cheevment["devInfo"], const_utilitySettings_language),
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

// ****************************
// ÷ Rich_Presence FUNCTIONS ÷
// ****************************
//	- Functions handling memory address logic that should only be used by the rich presence script
function isCurrentChapterIdInRangeOfRecordedIds() {
	return
		0 < getChapterId() && 	// Prologue starts at 0x1
		getChapterId() <= 0xb} 	// Epilogue ends at 0xb
function isCurrentChapterOneOf(array_chapterIds) {
	any_of(array_chapterIds, (chapterId) => isCurrentChapter(chapterId))}
// ***********************
// ÷ Rich_Presence TEXT ÷
// ***********************
//	- Contains text for all the rich presence scripts 
const_richPresence_text = {
	// "rp_Template": 										{"en": "xxxxxxxx"},	

	"rpp_FatedHour_Lookup_Prologue": 					{"en": "14h30"},
	"rpp_FatedHour_Lookup_Chapter1": 					{"en": "15h00"},
	"rpp_FatedHour_Lookup_Chapter2": 					{"en": "15h30"},
	"rpp_FatedHour_Lookup_Chapter3": 					{"en": "17h50"},
	"rpp_FatedHour_Lookup_Chapter4": 					{"en": "20h30"},
	"rpp_FatedHour_Lookup_Chapter5": 					{"en": "22h30"},
	"rpp_FatedHour_Lookup_Chapter6": 					{"en": "23h55"},
	"rpp_FatedHour_Lookup_Chapter7": 					{"en": "01h30"},
	"rpp_FatedHour_Lookup_Chapter8": 					{"en": "04h30"},
	"rpp_FatedHour_LookupFallback":						{"en": "a mystery"},

	"rpp_Chapter_Lookup_Prologue":						{"en": "Defying destiny"},
	"rpp_Chapter_Lookup_Chapter1":						{"en": "Extinguishing the heat"},
	"rpp_Chapter_Lookup_Chapter2":						{"en": "Exploring Lebensbaum"},
	"rpp_Chapter_Lookup_Chapter3":						{"en": "Visiting the art museum"},
	"rpp_Chapter_Lookup_Chapter4":						{"en": "Searching for an iron plate"},
	"rpp_Chapter_Lookup_Chapter5":						{"en": "Amalgamating an antidote"},
	"rpp_Chapter_Lookup_Chapter6":						{"en": "Producing a film"},
	"rpp_Chapter_Lookup_Chapter7":						{"en": "Examining a tower"},
	"rpp_Chapter_Lookup_Chapter8":						{"en": "Seeking the red stone"},
	"rpp_Chapter_Lookup_Epilogue":						{"en": "Cheating death"},
	"rpp_Chapter_LookupFallback":						{"en": "Roaming Lebensbaum"},

	"rpp_TimePeriod_Lookup_MiddleAges":					{"en": "in the Middle Ages"},
	"rpp_TimePeriod_Lookup_Late20Century":				{"en": "in the late 20th century"},
	"rpp_TimePeriod_Lookup_Early20Century":				{"en": "in the early 20th century"},
	"rpp_TimePeriod_Lookup_Present":					{"en": "in the present"},
	"rpp_TimePeriod_LookupFallback":					{"en": "in an unlikely timeline"},

	"rp_isPaused":										{"en": "Paused ⏸️ time  | The Fated 🕑 {0} | Current 📆 {1} April {2} | Current 🕑 {3} | Completion: {4}%"},
	"rp_InGameEXChapterOnly":							{"en": "Ending the cycle | The Fated 🕑 {0} | Current 📆 {1} April {2} | Current 🕑 {3} | Completion: {4}%"},
	"rp_InGameChapterOnly":								{"en": "{0} | The Fated 🕑 {1} | Current 📆 {2} April {3} | Current 🕑 {4} | Completion: {5}%"},
	"rp_InGameChapterWithTimePeriod": 					{"en": "{0} {1} | The Fated 🕑 {2} | Current 📆 {3} April {4} | Current 🕑 {5} | Completion: {6}%"},
	"rp_AtTitleScreen":									{"en": "Title Screen"},
	"rp_Default":										{"en": "Wandering Lebensbaum"}}
const_richPresence_lookupTables = {
	"rpp_FatedHour": {	// Corresponds to current chapter
		0x1: "rpp_FatedHour_Lookup_Prologue", 
		0x2: "rpp_FatedHour_Lookup_Chapter1",
		0x3: "rpp_FatedHour_Lookup_Chapter2",
		0x4: "rpp_FatedHour_Lookup_Chapter3",
		0x5: "rpp_FatedHour_Lookup_Chapter4",
		0x6: "rpp_FatedHour_Lookup_Chapter5",
		0x7: "rpp_FatedHour_Lookup_Chapter6",
		0x8: "rpp_FatedHour_Lookup_Chapter7",
		0x9: "rpp_FatedHour_Lookup_Chapter8",
		0xb: "rpp_FatedHour_Lookup_Chapter8",
		0xa: "rpp_FatedHour_Lookup_Chapter8",
		0xc: "rpp_FatedHour_Lookup_Chapter8"},
	"rpp_TimePeriod": {	// Refer to const_timePeriod
		0x80: "rpp_TimePeriod_Lookup_MiddleAges",
		0x82: "rpp_TimePeriod_Lookup_Early20Century",
		0x81: "rpp_TimePeriod_Lookup_Late20Century",
		0x88: "rpp_TimePeriod_Lookup_Late20Century",
		0x83: "rpp_TimePeriod_Lookup_Present"},
	"rpp_Chapter": {	// Refer to const_chapterIDs
		0x1: "rpp_Chapter_Lookup_Prologue",
		0x2: "rpp_Chapter_Lookup_Chapter1",
		0x3: "rpp_Chapter_Lookup_Chapter2",
		0x4: "rpp_Chapter_Lookup_Chapter3",
		0x5: "rpp_Chapter_Lookup_Chapter4",
		0x6: "rpp_Chapter_Lookup_Chapter5",
		0x7: "rpp_Chapter_Lookup_Chapter6",
		0x8: "rpp_Chapter_Lookup_Chapter7",
		0x9: "rpp_Chapter_Lookup_Chapter8",
		0xb: "rpp_Chapter_Lookup_Chapter8",
		0xa: "rpp_Chapter_Lookup_Epilogue",
		0xc: "rpp_Chapter_Lookup_Epilogue"}}
function getRichPresenceText(string_textKey) =>
	const_richPresence_text[string_textKey][const_utilitySettings_language]
function getRichPresenceLookupTable(string_lookupParameterKey) =>
	const_richPresence_lookupTables[string_lookupParameterKey]
// ****************************
// ÷ Rich_Presence CORE DATA ÷
// ****************************
//	- Contains logic data for all the rich presence scripts
enum_RPtype = {
	"DISPLAY_NORMAL": 0,		// rich_presence_display(format_string, parameters...)
	"DISPLAY_CONDITIONAL": 1, 	// rich_presence_conditional_display(condition, format_string, parameters...)
	"VALUE": 100,				// rich_presence_value(name, expression, [format])
	"LOOKUP": 101,				// rich_presence_lookup(name, expression, dictionary, [fallback])
	"MACRO": 103}				// rich_presence_macro(macro, expression)
// -------------------------------------
const_richPresence_coreData = {
	// 	- Expression examples => byte(0x000) OR getCurrentLevel() + 1
	// 	- Available macro's => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format
	// 	- Available value formats => https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions#rich_presence_valuename-expression-format

	// "rp_Template": { // CONCEPT rp_template
	// 	"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
	// 	"Condition": () =>  
	// 		always_false(),
	// 	"PlaceholderParameters": {
	// 		0: "rpp_Param1",
	// 		1: "rpp_Param2"}},
	
	"rp_isPaused": {
		"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
		"Condition": () { return 
			isInGame() && isInGamePauseMenuActive()},
		"PlaceholderParameters": {
			0: "rpp_FatedHour",
			1: "rpp_PresentTimeDays",
			2: "rpp_PresentTimeYears",
			3: "rpp_PresentTimeHourMinutes",
			4: "rpp_TotalCompletionRate"}},
	"rp_InGameEXChapterOnly": {
		"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
		"Condition": () =>
			isInGame() && isCurrentChapterIdInRangeOfRecordedIds() && 
			isPrologueInExMode() && isExChapterUnlocked() && 
			!isInGamePauseMenuActive() &&
			isCurrentChapter("Prologue"),
		"PlaceholderParameters": {
			0: "rpp_FatedHour",
			1: "rpp_PresentTimeDays",
			2: "rpp_PresentTimeYears",
			3: "rpp_PresentTimeHourMinutes",
			4: "rpp_TotalCompletionRate"}},
	"rp_InGameChapterOnly": {
		"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
		"Condition": () { return
			isInGame() && isCurrentChapterIdInRangeOfRecordedIds() && 
			!isInGamePauseMenuActive() &&
			!isPrologueInExMode() && isCurrentChapterOneOf(["Prologue", "Chapter1", "Epilogue"])},
		"PlaceholderParameters": {
			0: "rpp_Chapter",
			1: "rpp_FatedHour",
			2: "rpp_PresentTimeDays",
			3: "rpp_PresentTimeYears",
			4: "rpp_PresentTimeHourMinutes",
			5: "rpp_TotalCompletionRate"}},
	"rp_InGameChapterWithTimePeriod": {
		"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
		"Condition": () => 
			isInGame() && isCurrentChapterIdInRangeOfRecordedIds() && !isInGamePauseMenuActive() &&
			isCurrentChapterOneOf(["Chapter2", "Chapter3", "Chapter4", "Chapter5", "Chapter6", "Chapter7", "Chapter8"]),
		"PlaceholderParameters": {
			0: "rpp_Chapter",		
			1: "rpp_TimePeriod",
			2: "rpp_FatedHour",
			3: "rpp_PresentTimeDays",
			4: "rpp_PresentTimeYears",
			5: "rpp_PresentTimeHourMinutes",
			6: "rpp_TotalCompletionRate"}},
	"rp_AtTitleScreen": {	// "Title Screen"
		"RPtype": enum_RPtype["DISPLAY_CONDITIONAL"],
		"Condition": () { return
			isMainSaveLoaded() && 
			(isAtTitleScreen() || !isInGame())},
		"PlaceholderParameters": {}},
	"rp_Default": {		// Only 1 DISPLAY_NORMAL is allowed, more will overwrite the previous ones; refer to https://github.com/Jamiras/RATools/wiki/Rich-Presence-Functions
		"RPtype": enum_RPtype["DISPLAY_NORMAL"],
		"PlaceholderParameters": {}}}
const_richPresence_placeHolderParameterData = {
	"rpp_Chapter": {
		"RPtype": enum_RPtype["LOOKUP"],
		"Expression": getChapterId(),
		"LookupFallback": getRichPresenceText("rpp_Chapter_LookupFallback")},
	"rpp_TimePeriod": {	
		"RPtype": enum_RPtype["LOOKUP"],
		"Expression": getCurrentTimePeriod(),
		"LookupFallback": getRichPresenceText("rpp_TimePeriod_LookupFallback")},
	"rpp_TotalCompletionRate": {
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getTotalAchievementRate(),
		"Macro": "Number"},
	"rpp_PresentTimeSeconds": {
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getCurrentPresentTimeSeconds(),
		"Macro": "Number"},
	"rpp_PresentTimeMinutes": {	
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getCurrentPresentTimeMinutes(),
		"Macro": "Number"},	
	"rpp_PresentTimeHourMinutes": {	
		"RPtype": enum_RPtype["MACRO"],
		"Expression": (getCurrentPresentTimeMinutes() + getCurrentPresentTimeHours() * 60),
		"Macro": "Minutes"},
	"rpp_PresentTimeHours": {	
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getCurrentPresentTimeHours(),
		"Macro": "Number"},
	"rpp_PresentTimeYears": {	
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getCurrentPresentTimeYears(),
		"Macro": "Number"},
	"rpp_PresentTimeDays": {
		"RPtype": enum_RPtype["MACRO"],
		"Expression": getCurrentPresentTimeDays(),
		"Macro": "Number"},
	"rpp_FatedHour": {
		"RPtype": enum_RPtype["LOOKUP"],
		"Expression": getChapterId(),
		"LookupFallback": getRichPresenceText("rpp_FatedHour_LookupFallback")}}
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
	
	let_placeholderParameterData = const_richPresence_placeHolderParameterData[string_placeholderParameterKey]
	let_RPtype = let_placeholderParameterData["RPtype"]
	if (let_RPtype == enum_RPtype["VALUE"]) {
		createRPparameterFunction_Value(string_placeholderParameterKey, let_placeholderParameterData)
	} else if (let_RPtype == enum_RPtype["LOOKUP"]) {
		createRPparameterFunction_Lookup(string_placeholderParameterKey, let_placeholderParameterData)
	} else if (let_RPtype == enum_RPtype["MACRO"]) {
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
function initilalizeRPdisplay(string_displayScriptKey, dict_rpDisplayData) {	// Initializes rich presence display scripts
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
	if (let_RPtype == enum_RPtype["DISPLAY_NORMAL"]) {
		initializeRPdisplay_Normal(string_displayScriptKey, dict_rpDisplayData)
		let_countDisplayNormalScripts = let_countDisplayNormalScripts + 1
		if (let_countDisplayNormalScripts > 1) throwError("More than one DISPLAY_NORMAL script was defined; The last one will overwrite all the previous ones")
	} else if (let_RPtype == enum_RPtype["DISPLAY_CONDITIONAL"]) {
		initializeRPdisplay_Conditional(string_displayScriptKey, dict_rpDisplayData)
	} else {
		throwError(format("The rich presence display script: {0} did not evaluate correctly", string_displayScriptKey))
	}}
function initializeRichPresence() {
	// DEV NOTE: rich_presence_macro(macro, expression)
	//	- rich_presence_macro() are placed within a display script; like rich_presence_lookup() and rich_presence_value()
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