// Shadow of Destiny
// #ID = 3945
// md5: 887bb53eb92a56235aa40a80ce5c8eeb - USA
// *********************************************
 
//#########################################################################################################\\
//  //  //  // //  //  //  //  //  //  //  //  //   UTILITY    \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

function isDebugModeActive() => true				// if active => extra information may be displayed on achievement titles & descriptions
achievementLanguage = "en"							// ISO 639-1 language codes 		// TODO check if multi-language support is needed 
achievementGuideLink = "bit.ly/ShadowOfDestiny" 	// https://bit.ly/ShadowOfDestiny => links to written achievement guide on github (https://github.com/QuentinBultinck/RetroAchievements/blob/main/RAscripts/PSP/ShadowOfDestiny/README.md)

//#########################################################################################################\\
//  //  //  //  //  //  //  //  //    CODE NOTES & MEMORY ADDRESS LOGIC    \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

// PSP pointers usually start with 08 or 09 + 25-bit

// TIMERS/COUNTERS
// *****************
//	- Resets at certain times or between cutscene transitions
//	- Different timers reset at different moments
function twoFrameTimer() 				=> dword(0xA82880) 								// $A82880: [32-bit] Two frame timer
function hasTwoFrameTimerReset() 		=> twoFrameTimer() < prev(twoFrameTimer()) 		//		- Timer increments by 0x400 each 2 frames
function hasTwoFrameTimerIncremented() 	=> twoFrameTimer() > prev(twoFrameTimer())		// 		- Reset less than other timer

function oneFrameTimer() 				=> dword(0xB88AB0)								// $B88AB0: [32-bit] One frame timer
function hasOneFrameTimerReset() 		=> oneFrameTimer() < prev(oneFrameTimer()) 		//		- Timer increments by 1 each frame
function hasOneFrameTimerIncremented() 	=> oneFrameTimer() > prev(oneFrameTimer())		// 		- Resets at certain times or between cutscene transitions


// INTERACTION IDs WITH NPCs & ITEMS 
// ************************************************
_NPCs = {
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
	// "xxxtemplatexxxx": { 
	// 	"ID": 0x00000, "Appearance": {
	// 		"xxxxxtemplatexxxxxxx": {"MemAddrTalkCount": 0x000000, "MaxTalkCount": 0000}}},
}

_Interactables = {
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
	"Painting_Alchemist": 0x167,
	"Painting_Eiked_SquireCrest": 0x000000,
	"Painting_Eiked_TownSquare": 0x000000,
	"Painting_Eiked_Performer": 0x000000,
	"Painting_Eiked_AlchemyLab": 0x000000,
	"Painting_Eiked_CollapsedHouse": 0x000000,
	"Painting_Eiked_TowerView": 0x000000
}

function GetMaxTalkCountFor(string_NPC, string_appearance) => _NPCs[string_NPC]["Appearance"][string_appearance]["MaxTalkCount"]

function isNPCtalkCountIncreasedToMax(string_NPC, string_appearance) {
	let_NPCappearance = _NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	let_maxTalkCount = let_NPCappearance["MaxTalkCount"]
	return 
		let_talkCount == let_maxTalkCount &&
		prev(let_talkCount) == let_maxTalkCount - 1}

function isNPCtalkCountIncreased(string_NPC, string_appearance) {
	let_NPCappearance = _NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	return 
		let_talkCount > prev(let_talkCount)}

function isNPCtalkCountAtMax(string_NPC, string_appearance) {
	let_NPCappearance = _NPCs[string_NPC]["Appearance"][string_appearance]
	let_talkCount = byte(let_NPCappearance["MemAddrTalkCount"])
	return 
		let_talkCount == _NPCs[string_NPC]["Appearance"][string_appearance]["MaxTalkCount"]}

function isTalkingTo_shortHand(string_NPC) => dword(0xA9EFF4) == _NPCs[string_NPC]["ID"]	// $A9EFF4: Copy of [32-bit] NPC ID (refer to notes @ 0xa9efdc)
																							// - Resets to 0x0 when interaction is done

function isTalkingTo(string_NPC) {								// $A9EFDC: [25-bit] Pointer - Interactions
	let_maskedPointer = dword(0xA9EFDC) & 0x1ffffff				// 		+0x0 - [32-bit] NPC ID															
	return _NPCs[string_NPC]["ID"] == dword(let_maskedPointer) 	// 		| - Unique per interactable NPC or environment item
} 																// 		| - This value is copied to 0xa9eff4 (refer to notes)

function isInteractingWith_shortHand(string_interactable) => dword(0xA9EFF4) == _Interactables[string_NPC]

function isInteractingWith(string_interactable) {
	let_maskedPointer = dword(0xA9EFDC) & 0x1ffffff
	return _Interactables[string_interactable] == dword(let_maskedPointer)
}

function isInteractionID_1(int_interactionId) {
	let_maskedPointer = dword(0xA9EFE0) & 0x1ffffff				// $A9EFE0: [25-bit] Pointer - Interactions
	return dword(let_maskedPointer) == int_interactionId}		// 		+0x0 - [32-bit] Interaction ID_1

function isInteractionID_2(int_interactionId) {
	let_maskedPointer = dword(0xA9EFE4) & 0x1ffffff				// $A9EFE4: [25-bit] Pointer - Interactions
	return dword(let_maskedPointer) == int_interactionId}		// 		- Pointer resets to 0x0 when interaction is done
																// 		+0x0 - [32-bit] Interaction ID_2

// Function is used when different appearances of the same character use the same dialogue
//	Pointer value changes on each dialogue/talk/interaction, but InteractionID_2 doesn't
function isPointerInteractionID_2(int_value) => dword(0xA9EFE4) == int_value

function interactionID_1_old() 	=> dword(0xA9EFDC)			// $A9EFDC: [32-bit] Interaction ID 1
														//		- Unique per interactable NPC or environment item
														// 		- Doesn't reset back to a default value after interaction is done
function interactionID_2_old() 	=> dword(0xA9EFE4)			// $A9EFE4: [32-bit] Interaction ID 2
														// 		- Resets to 0x0 when interaction is done
														//		- Unique per interaction 
function interactionID_3_old() 	=> dword(0xA9EFF4)			// $A9EFF4: [32-bit] Interaction ID 3 
														//		- Unique per interactable NPC or environment item
														// 		- Resets to 0x0 when interaction is done

// CUTSCENE IDENTIFICATION
// ************************
function isCutsceneActive_old() => bit0(0xA9Eb2C) == 0								// $A9Eb2C: [bit-0] Flag -> is cutscene active (not preferred)
function isCutsceneDone_old() => prev(bit0(0xA9Eb2C)) == 1 && bit0(0xA9Eb2C) == 0	//		- 0 = a cutscene is active, whenever PC movement is disabled (also 0 when in intro sequence)
																					//		- 1 = no cutscene active
function isCutsceneActive() => byte(0xA9ED26) == 0x5												// $A9ED26: Flag: Is cutscene active (preferred)
																									// 		- 0x00 => no cutscene active
function isFullCutsceneSequenceEnding() => prev(byte(0xA9ED26)) > 0x0 && byte(0xA9ED26) == 0x0	// 		- 0x01 => black bars (small) cutscene active/transitional value between active-inactive
																									// 		- 0x05 => cutscene active
function isCutsceneSectionEnding() => prev(byte(0xA9ED26)) > 0x3 && 0x3 >= byte(0xA9ED26)	&& byte(0xA9ED26) > 0x0	

function isSmallCutsceneActive() => byte(0xA9ED26) == 0x1


function isCurrentCutsceneMasterId(int_Id) => dword(0xA9ECBC) == int_Id			// $A9ECBC: [32-bit] Cutscene MASTER ID (preferred)
																				// 		- Identifies a cutscene sequence
function isPriorCutsceneMasterId(int_Id) => prior(dword(0xA9ECBC)) == int_Id

function isNewCutsceneLoading() => prev(dword(0xA9ECBC)) != dword(0xA9ECBC)

function isCurrentCutsceneSectionId_1(int_Id) => word(0xA9ECC0) == int_Id		// $A9ECC0: [16-bit] Cutscene Section ID_1
																				// 		- Identifies a section from the current cutscene
function isPriorCutsceneSectionId_1(int_Id) => prior(word(0xA9ECC0)) == int_Id		

function isCurrentCutsceneSectionId_2(int_Id) => word(0xA9ECC2) == int_Id		// $A9ECC2: [16-bit] Cutscene Section ID_2

function isPriorCutsceneSectionId_2(int_Id) => prior(word(0xA9ECC2)) == int_Id

function isCurrentCutsceneMasterDataId(int_Id) {
	// & 0x1ffffff => masks 32-bit value to 25-bit; PSP uses 25-bit pointers
	let_maskedPointer = dword(0xA9ECC8) & 0x1ffffff			// $A9ECC8: [25-bit] Pointer
	return dword(let_maskedPointer + 0x8) == int_Id}		// 		+0x0 - Refers to start of dynamic cutscene memory data block - Data below changes on new cutscene loaded in
															// 		+0x8 - [32-bit] Cutscene Master Data ID
function isCurrentCutsceneSectionDataId(int_Id) {
	let_maskedPointer = dword(0xA9ECCC) & 0x1ffffff			// $A9ECCC: [25-bit] Pointer
	return dword(let_maskedPointer + 0x8) == int_Id}		// 		+0x0 - Data lower then this point changes, when a next section in the cutscene starts
															// 		+0x8 - [32-bit] Cutscene Section Data ID
function isCurrentMinorCutsceneId(int_Id, int_offset) {
	let_maskedPointer = dword(0xA9ECD4) & 0x1ffffff			// $A9ECD4: [25-bit] Pointer - when a cutscene is active
	return dword(let_maskedPointer + int_offset) == int_Id}	// +0x0 - Data lower than this point can be used as Minor Cutscene IDs
															// +0x34 - [Bit Flag] bit 0 => is cutscene active, only on (optional/cutscenes started by pressing interaction button) - Otherwise usable as a Cutscene ID


// TODO Refactor => Below 4 function are deprecated
function isCurrentCutsceneMasterId_1(int_cutsceneId) => word(0xA9ECC0) == int_cutsceneId		// $A9ECC0: [16-bit] Cutscene MASTER ID #1
function isPriorCutsceneMasterId_1(int_cutsceneId) => prior(word(0xA9ECC0)) == int_cutsceneId	// 		- Identifies a section from the current cutscene

function isCurrentCutsceneMasterId_2(int_cutsceneId) => word(0xA9ECC2) == int_cutsceneId		// $A9ECC2: [16-bit] Cutscene MASTER ID #2
function isPriorCutsceneMasterId_2(int_cutsceneId) => prior(word(0xA9ECC2)) == int_cutsceneId	// 		- Identifies a section from the current cutscene2

// TODO refactor => _cutsceneIDs AND function currentCutsceneId
// Below memory addresses likely correlate to animation, model... data during a specific cutscene (not preferred for cutscene identification)
//		- Everytime you view a different cutscene, memory values around these IDs/addresses change
//		- Each unique cutscene seems to have different values => might correlate to animation, camera or model data
//		- During cutscenes the values may change
_cutsceneIDs = {
	1: 0x1DF4280, 		// $1DF4280: [32-bit] Cutscene ID 
	2: 0x1DF59B0, 		// $1DF59B0: [32-bit] Cutscene ID
	3: 0x1DF5F71, 		// $1DF5F71: [32-bit] Cutscene ID
	4: 0x1DF6724, 		// $1DF6724: [32-bit] Cutscene ID
	5: 0x1DF6F60, 		// $1DF6F60: [32-bit] Cutscene ID
	6: 0x1DF742A, 		// $1DF742A: [32-bit] Cutscene ID
	7: 0x1DF7FA2, 		// $1DF7FA2: [32-bit] Cutscene ID
	8: 0x1DF81BA, 		// $1DF81BA: [32-bit] Cutscene ID
	9: 0x1DF8229, 		// $1DF8229: [32-bit] Cutscene ID
	10: 0x1DF8442,		// $1DF8442: [32-bit] Cutscene ID
	11: 0x1DF8B14, 		// $1DF8B14: [32-bit] Cutscene ID
	12: 0x1DF9362, 		// $1DF9362: [32-bit] Cutscene ID
	13: 0x1DF9AA4, 		// $1DF9AA4: [32-bit] Cutscene ID
	14: 0x1DFA0E6, 		// $1DFA0E6: [32-bit] Cutscene ID
	15: 0x1DFA4F8,		// $1DFA4F8: [32-bit] Cutscene ID
	16: 0x1DFAC91, 		// $1DFAC91: [32-bit] Cutscene ID
	17: 0x1DFAD9A, 		// $1DFAD9A: [32-bit] Cutscene ID
	18: 0x1DFB0F0, 		// $1DFB0F0: [32-bit] Cutscene ID
	19: 0x1DFB22B, 		// $1DFB22B: [32-bit] Cutscene ID
	20: 0x1DF5A0C, 		// $1DF5A0C: [32-bit] Cutscene ID
	21: 0x1DF5950,		// $1DF5950: [32-bit] Cutscene ID
	22: 0x1DF81E5,		// $1DF81E5: [32-bit] Cutscene ID
	23:	0x1DFB3D0,		// $1DFB3D0: [32-bit] Cutscene ID
	24:	0x1DFCD78,		// $1DFCD78: [32-bit] Cutscene ID
	25:	0x1DFEA54		// $1DFEA54: [32-bit] Cutscene ID
}
function currentCutsceneId(int_cutsceneId) 	=> dword(_cutsceneIDs[int_cutsceneId])

function priorCutsceneId(int_cutsceneId) 	=> prior(dword(_cutsceneIDs[int_cutsceneId]))

// MAP/SCENE/SCENARIO IDENTIFIER
// *******************************
_mapIDs= {	// list not complete, adding as is necessary
	"PresentDayCity": 0x375,
	"PresentDayNightCity": 0x44,
	"NightBefore": 0x3,
	"80sColdCity": 0x465,
	"70sNightCity": 0x31d,
	"1900sCity": 0x239,
	"1900sBrumMansion": 0x603,
	"MedievalCity": 0x3f3,
	"MedievalNightCity": 0x33c,
	"ExplodedAlchemistBasement": 0x217,
	"MedievalChurch": 0x8e,
	"PresentTownHall": 0x16,
	"AntiqueShopEule80s": 0x7a,
	"AntiqueShopEulePresent": 0x6f,
	"BrumMuseumUpstairsRoom1": 0x159,
	"BrumMuseumUpstairsRoom2": 0x224,
	"BrumMuseumUpstairsRoom3": 0x140,
	"BrumMuseumDownstairsRoom": 0x32
}
function isCurrentMapScene(string_mapId) => dword(0xA82E48) == _mapIDs[string_mapId]	// $A82E48: [32-bit] Current loaded scene/map/scenario

// CHAPTER LOGIC
// ***************
_chapterIDs = {
	"Prologue": 0x1,
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
	"Epilogue_NoAncestress": 0xc
	// TODO "Different endings": ???
	// TODO "EX chapter": ??? 
}
function getChapterId() => byte(0xB95704)			// $B95704: [8-bit] Chapter ID

function isCurrentChapter(string_chapter) {	
	if (string_chapter == "Chapter8") {
		return
			(getChapterId() == _chapterIDs["Chapter8_Ancestress"] || getChapterId() == _chapterIDs["Chapter8_NoAncestress"])
	} else {
		return
			getChapterId() == _chapterIDs[string_chapter]
	}} 

function isChapterFinishing(string_chapter) { 
	if (string_chapter == "Chapter7") {
		return 
			prev(getChapterId()) == _chapterIDs[string_chapter] &&
			(
				getChapterId() == _chapterIDs["Chapter8_Ancestress"] 	|| 
				getChapterId() == _chapterIDs["Chapter8_NoAncestress"] 
			)
	} else if (string_chapter == "Chapter8_Ancestress"){
		return
			prev(getChapterId()) == _chapterIDs[string_chapter] &&
			getChapterId() == _chapterIDs["Epilogue_Ancestress"]
	} else if (string_chapter == "Chapter8_NoAncestress"){
		return
			prev(getChapterId()) == _chapterIDs[string_chapter] &&
			getChapterId() == _chapterIDs["Epilogue_NoAncestress"]
	} else {
		return
			prev(getChapterId()) == _chapterIDs[string_chapter] &&
			getChapterId() == _chapterIDs[string_chapter] + 0x1
	}}

function isChapterChanging() => getChapterId() != prev(getChapterId())


// INVENTORY LOGIC 
// *****************
//	- itemScrollBarId => Id of the item in the inventory scrollbar menu
//	- inventoryMemoryAddress => Memory address [bit 0] = 1 => this item is in players inventory
//	- isDefaultItem => true, when player gets this item at start of game
_inventoryItems = { 
	"D-pad": {	// In PSP version this is called Z-Pad
		"memAddress_Flag_isInInventory": 0xA9F034,	// $A9F034: [Bit 0] Z-pad/D-pad
		"itemScrollBarId": 0x0,
		"isDefaultItem": true
	}, 
	"Cellphone": {
		"memAddress_Flag_isInInventory": 0xA9F035,	// $A9F035: [Bit 0] Cellphone
		"itemScrollBarId": 0x1,
		"isDefaultItem": true
	},
	"Map": {
		"memAddress_Flag_isInInventory": 0xA9F04C,	// $A9F04C: [Bit 0] City map
		"itemScrollBarId": 0x18,
		"isDefaultItem": true
	},
	"Notebook": {
		"memAddress_Flag_isInInventory": 0xA9F04F,	// $A9F04F: [Bit 0] Notebook
		"itemScrollBarId": 0x1b,
		"isDefaultItem": true
	},	
	"Postcard": {
		"memAddress_Flag_isInInventory": 0xA9F04A,	// $A9F04A: [Bit 0] Letter to dana
		"isDefaultItem": true
	},
	"OldMap": {
		"memAddress_Flag_isInInventory": 0xA9F04E,	// $A9F04E: [Bit 0] Old City Map
		"isDefaultItem": false
	},
	"OrnamentalEgg": {
		"itemScrollBarId": 0x2,
		"memAddress_Flag_isInInventory": 0xA9F036,	// $A9F036: [Bit 0] Cake
		"isDefaultItem": false
	},
	"FryingPan": {
		"itemScrollBarId": 0x4,
		"memAddress_Flag_isInInventory": 0xA9F038,	// $A9F038: [Bit 0] Frying pan
		"isDefaultItem": false
	},
	"Sign": {
		"itemScrollBarId": 0x5,
		"memAddress_Flag_isInInventory": 0xA9F039,	// $A9F039: [Bit 0] Photo shop sign
		"isDefaultItem": false
	},
	"Lighter": {
		"itemScrollBarId": 0x6,
		"memAddress_Flag_isInInventory": 0xA9F03A,	// $A9F03A: [Bit 0] Lighter
		"isDefaultItem": false
	},
	"SquireCrest": {
		"itemScrollBarId": 0xf,
		"memAddress_Flag_isInInventory": 0xA9F043,	// $A9F043: [Bit 0] Squire's crest
		"isDefaultItem": false
	},
	"Antidote": {
		"itemScrollBarId": 0x11,
		"memAddress_Flag_isInInventory": 0xA9F045,	// $A9F045: [Bit 0] Antidote
		"isDefaultItem": false
	},
	"Jugglery": {
		"itemScrollBarId": 0xc,
		"memAddress_Flag_isInInventory": 0xA9F040,	// $A9F040: [Bit 0] Jugglery
		"isDefaultItem": false
	},
	"Cake": {
		"itemScrollBarId": 0x13,
		"memAddress_Flag_isInInventory": 0xA9F047,	// $A9F047: [Bit 0] Cake
		"isDefaultItem": false
	},
	"PhilosopherStone": {
		"memAddress_Flag_isInInventory": 0xA9F03D,	// $A9F03D: [Bit 0] Philosopher's stone
		"isDefaultItem": false
	},
	"BLackWhitePhoto": {	// This one switches with the other photo once the picture is taken
		"memAddress_Flag_isInInventory": 0xA9F03B,	// $A9F03B: [Bit 0] Black and white photo without performer
		"isDefaultItem": false
	},
	"BLackWhitePhotoWithPerformer": {	
		"memAddress_Flag_isInInventory": 0xA9F03C,	// $A9F03C: [Bit 0] Black and white photo with performer
		"isDefaultItem": false
	},
	"OldRope": {
		"memAddress_Flag_isInInventory": 0xA9F03F,	// $A9F03F: [Bit 0] Old Rope
		"isDefaultItem": false
	},
	"NewRope": {
		"memAddress_Flag_isInInventory": 0xA9F03E,	// $A9F03E: [Bit 0] New Rope
		"isDefaultItem": false
	},
	"Comb": {
		"memAddress_Flag_isInInventory": 0xA9F041,	// $A9F041: [Bit 0] Comb
		"isDefaultItem": false
	},
	"AlchemyBook": {
		"memAddress_Flag_isInInventory": 0xA9F042,	// $A9F042: [Bit 0] Old alchemist book
		"isDefaultItem": false
	},
	"EggPocketWatch": {
		"memAddress_Flag_isInInventory": 0xA9F044,	// $A9F044: [Bit 0] Egg shaped pocket watch
		"isDefaultItem": false
	},
	"Meat": {
		"memAddress_Flag_isInInventory": 0xA9F046,	// $A9F046: [Bit 0] Scrap of meat
		"isDefaultItem": false
	},
	"LabKey": {
		"memAddress_Flag_isInInventory": 0xA9F048,	// $A9F048: [Bit 0] Lab key
		"isDefaultItem": false
	},
	"TowerKey": {
		"memAddress_Flag_isInInventory": 0xA9F049,	// $A9F049: [Bit 0] Tower key
		"isDefaultItem": false
	},
	"Ladder": {
		"memAddress_Flag_isInInventory": 0xA9F04D,	// $A9F04D: [Bit 0] Ladder
		"isDefaultItem": false
	},
	"LetterToDana": {
		"memAddress_Flag_isInInventory": 0xA9F050,	// $A9F050: [Bit 0] Postcard
		"isDefaultItem": false
	},
	"Kitten": {
		"memAddress_Flag_isInInventory": 0xA9F04B,	// $A9F04B: [Bit 0] Kitten
		"isDefaultItem": false
	}
}

function isCurrentSelectedInventoryItem(string_item) => byte(0xA9F111) == _inventoryItems[string_item]["itemScrollBarId"] // $A9F111: [8-bit] Currently selected item ID in inventory

function isItemInInventory(string_item) => bit0(_inventoryItems[string_item]["memAddress_Flag_isInInventory"]) == 1


// ON-SCREEN TEXT 
// ****************
//	- Master ID	=> Identifies a series of subtitles, can stay the same over multiple text changes
//	- Other IDs => Changes on each text/subtitle change 
_onScreenTextID = {
	0: 0xAC31E4,	// $AC31E4: [32-bit] On-screen text ID_master
	1: 0xAC31E8,	// $AC31E8: [32-bit] On-screen text ID
	2: 0xAC326C,	// $AC326C: [32-bit] On-screen text ID
	3: 0xAC32A8,	// $AC32A8: [32-bit] On-screen text ID
	4: 0xAC3314,	// $AC3314: [32-bit] On-screen text ID
	5: 0xAC33E8,	// $AC33E8: [32-bit] On-screen text ID
	6: 0xAC350C,	// $AC350C: [32-bit] On-screen text ID
	7: 0xAC3538,	// $AC3538: [32-bit] On-screen text ID
	8: 0xAC3658		// $AC3658: [32-bit] On-screen text ID
}
function onScreenTextID(int_id) => dword(_onScreenTextID[int_id])


// EXTRA MENU 
// *************
//	=> Event viewer is unlocked after completing one ending
// 	=> Some achievements might be unlockable by playing cutscenes through this menu => not allowed
function isViewingEndingFromExtraMenu() { 		
	// Underlying line lasks [32-bit] value to [25-bit]	as PSP uses 25-bit pointers
	let_maskedPointer = dword(0xAC3170) & 0x1FFFFFF				// $AC3170: [25-bit] Pointer
	return dword(let_maskedPointer + 0x4) == 0x1}				// 	+0x4 - Selected menu item in Extra Menu
																// 		- 0x0 => Event viewer (replay unlocked cutscenes)
																// 		- 0x1 => Ending files (replay ending cutscenes)
																// 		- 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
																// 		- 0x3 => Sound Mode (Play sound effects & music)
																// 		- 0x4 => Exit (back to Title Screen)

// $1FFF130: [32-bit] Flag -> Event viewer (preferred)
// 0x21 => event viewer menu on screen OR a cutscene is being watched via this menu
// - other values => not in event viewer
function isEventViewerActive() {						// $AC3170: [25-bit] Pointer - When in Extra menu
	let_maskedPointer = dword(0xAC3170) & 0x1ffffff		// 		- Extra menu is only visible once at least one is ending is finished
	return												// 		+0x4 - [32-bit] Extra Menu: Highlighted item
		dword(0x1FFF130) == 0x21			&&			// 		| - 0x0 => Event viewer (replay unlocked cutscenes)
		dword(let_maskedPointer + 0x4) == 0 &&			// 		| - 0x1 => Ending files (replay ending cutscenes)
 		dword(let_maskedPointer + 0x48) <= 0xb}			// 		| - 0x2 => Results (View best clear time & percentage cutscenes unlocked per chapter)
														// 		| - 0x3 => Sound Mode (Play sound effects & music)
														// 		| - 0x4 => Exit (back to Title Screen)
														// 		+0x14 - [32-bit] Extra Menu: Highlighted ending file
														// 		| - 0x0 => ending A			| - 0x4 => ending E
														// 		| - 0x1 => ending B			| - 0x3 => ending D
														// 		| - 0x2 => ending C
														// 		+0x48 - [32-bit] Results Menu/Event Viewer: Highlighted chapter
														// 		| - 0x0 => Prologue			| - 0x9 => Epilogue
														// 		| - 0x1 => Chapter 1		| - 0xa => Total
														// 		| - ...						| - 0xb => Exit
														// 		| - 0x8 => Chapter 8

function IsViewingCutsceneFromExtraMenu_old() => dword(0x1FFF15C) == 0x1	// $1FFF15C: [32-bit] Flag => is viewing cutscene from event viewer (not preferred)
																			// 	- 0x1 = event viewer is active
																			// 	- other values = event viewer is inactive
																		

// OTHER LOGIC
// *************
function getEnergyUnitsZPad() => byte(0xA9DAA8)	// $A9DAA8: Number of energy units in possession 
												//		- Used for the time travel machine (Z-Pad)
												//		- Min => 0x0 		Max => 0x0a
function isInGame() => low4(0xA9EDDC) != 0	// $A9EDDC: [Bit 1] Flag -> is in-game
												// 		0 => at title screen
												// 		1 => in-game
function isGameRunning_old() => bit0(0xA9F034) == 1	// $A9F034: [bit-0] Flag -> is game running (deprecated)
													//		- 0 = game is not running, it's in the title screen
													//		- 1 = game is running
function isAtTitleScreen() { return						// $1FFF5F8: [32-bit] UI/Menu ID
	dword(0x1FFF5F8) == 0x11 &&							// 	0x11 => title screen			any other value => something else on screen
	0x0 < byte(0x1FFF604) && dword(0x1FFF604) < 0x5}	// $1FFF604: [8-bit] Selected submenu at title screen
														// 	0x1 => Start		0x3 => Option
														// 	0x2 => Continue		0x4 => Extra


// CUTSCENE/CHOICES BIT FLAGS
// ****************************
function isTreeReplacedByStatue() => bit2(0xA9EDA0)	== 0				// $A9EDA0: [Current Playthrough Bit Flags]: Chapter 2
																// 		bit 0 => acquired ladder
function isTreeReplacedByFlowers() => bit2(0xA9EDA0) == 1				// 		bit 1 = 0 => LIGHTER used to scare crowd
																// 		bit 1 = 1 => TELEPHONE used 
function isCrowdScaredWithCellphone() => bit1(0xA9EDA0) == 1	// 		bit 2 = 0 => Chosen to plant STATUE instead of flowers
																// 		bit 2 = 1 => Chosen to plant FLOWERS instead of statue
function isCrowdScaredWithLighter() => bit1(0xA9EDA0) == 0	

																
function isMovieWorldConquestPicked() => bit7(0xA9EDB7) == 1 && bit0(0xA9EDB8) == 1		// $A9EDB7: [Current Playthrough Bit Flags]: Chapter 6
																						// 		bit 5 => Movie choice 1: Meditating Man
function isMovieTimeTravelPicked() => bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0		// 		bit 6 => Movie choice 1: Time Travel
																						// 		bit 7 => Movie choice 2: Take over the world
function isMovieFindCauseDeathPicked() => bit0(0xA9EDB8) == 1 && bit7(0xA9EDB7) == 0	// $A9EDB8: [Current Playthrough Bit Flags]: Chapter 6
																						// 		bit 0 => Movie Choice 2: Find cause of own death
function isMovieThrillerStoryPicked() => bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0		// 		bit 1 => Movie Choice 3: Thriller story
																						// 		bit 2 => Movie Choice 3: Love story
function isMovieLoveStoryPicked() => bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0	


function isPaintingAntidoteInspired() => bit7(0xA9EDB0) == 1	// $A9EDB0: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
																//  - 8 paintings viewable at Brum museum, 6 can altered by inspiring Karl Franssen
function isPaintingMarktplatzInspired() => bit6(0xA9EDB0) == 1	// 		bit 7 => Antidote painting
																// 		bit 6 => Marktplatz painting (insinuating removing the tree)
function isPaintingSquireCrestInspired() => bit5(0xA9EDB0) == 1	// 		bit 5 => Squire's crest painting
																// 		bit 4 => Tower view painting (downstairs)
function isPaintingTowerViewInspired() => bit4(0xA9EDB0) == 1

function isPaintingPerformerInspired() => bit0(0xA9EDB1) == 1		// $A9EDB1: [Current Playthrough Bit Flags]: Inspired Karl Franssen's Art
																	// 		bit 0 => Performer painting (only possible when player became performer in chapter 4)
function isPaintingHouseCollapseInspired() => bit1(0xA9EDB1) == 1	// 		bit 1 => Achemist house collapse painting



function isEndingUnlocked(string_EndingCharacter) {
	let_endingBitFlagsMemoryAddresses = {
		"A": 0xAA1154,	// $AA1154: [Bit Flag] bit 0 => Ending A unlocked
		"B": 0xAA1155,	// $AA1155: [Bit Flag] bit 0 => Ending B unlocked
		"C": 0xAA1156,	// $AA1156: [Bit Flag] bit 0 => Ending C unlocked
		"D": 0xAA1157,	// $AA1157: [Bit Flag] bit 0 => Ending D unlocked
		"E": 0xAA1158}	// $AA1158: [Bit Flag] bit 0 => Ending E unlocked
	return bit0(let_endingBitFlagsMemoryAddresses[string_EndingCharacter]) == 1}


function isBrumEstateMuseum() => bit5(0xA9EDAA) == 0		// [Current Playthrough Bit Flags]: Brum Estate Choice
															//		bit 5 = 0 => Brum Estate is museum
function isBrumEstateLibrary() => bit5(0xA9EDAA) == 1		//		bit 5 = 1 => Brum Estate is library


function isMargaretteAncestor() => bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0		// $A9EDAE: [Current Playthrough Bit Flags]: Margarette Ancestor choice
																				// 		bit 6 => Margarette is ancestor
function isMargaretteNoAncestor() => bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1		// 		bit 7 => Margarette is NOT an ancestor
																				
function isDanaSavedFromPast(){	return	// $a9edc4: [Current Playthrough Bit Flags]: Saved Dana from Past
	bit1(0xA9EDC4) == 1 && 				// 		bit 1 => Gave letter to Dana
	bit3(0xA9EDC4) == 1 && 				// 		bit 3-4 => Took Dana back to present
	bit4(0xA9EDC4) == 1}

function isDanaNotSavedFromPast(){ return
	bit1(0xA9EDC4) == 0 &&
	bit3(0xA9EDC4) == 0 &&
	bit4(0xA9EDC4) == 0}


function isWearingPerformerOutfit() => bit2(0xA9EDA5) == 1	// $A9EDA5: [Current Playthrough Bit Flags]: Chapter 4
															//		 bit 2 => is wearing performer outfit
														

//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //    ACHIEVEMENT LOGIC    \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\

// ACHIEVEMENT DICTIONARY
//	- Divided by category => when in debug mode, category tags are added to achievement titles
// 	- check if key (achievementname) => is unique with ctrl+F
// ************************************************************
_achievements = {
	// TODO "a_Template": { 
	//	"id": 000000, "points": 0000000, "hasTips": false,
	//	"devInfo": "xxxxxxx"},
	"c_Completion": { // Category - Completing chapters
		"a_PrologueComplete": { // REWORKED 
			"id": 306884, "points": 5, "hasTips": false,
			"devInfo": "Complete the prologue"},
		"a_Chapter1Complete": { // REWORKED
			"id": 306886, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 1"},
		"a_Chapter2Complete": { // REWORKED
			"id": 306922, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 2"},
		"a_Chapter3Complete": { // REWORKED
			"id": 306921, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 3"},
		"a_Chapter4CompletePan": { // REWORKED
			"id": 308964, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a frying pan"},
		"a_Chapter4CompleteSign": { // REWORKED
			"id": 310149, "points": 5, "hasTips": true,
			"devInfo": "Complete chapter 4, using a sign"},
		"a_Chapter5Complete": { // REWORKED
			"id": 311616, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 5"},
		"a_Chapter6CompleteThriller": { // REWORKED
			"id": 313211, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a thriller movie"},
		"a_Chapter6CompleteLove": { // REWORKED
			"id": 313210, "points": 4, "hasTips": false,
			"devInfo": "Complete chapter 6, by co-directing a love movie"},
		"a_Chapter7Complete": { // REWORKED
			"id": 315565, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 7"},
		"a_Chapter8Complete": { // REWORKED 
			"id": 315571, "points": 5, "hasTips": false,
			"devInfo": "Complete chapter 8"},
		// TODO "a_EXChapterComplete": {
		//	"id": 000000, "points": 50, "hasTips": false,
		// 	"devInfo": "Complete the EX chapter"},
		// TODO "a_MaxAchievementPrologue": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in prologue"},
		// TODO "a_MaxAchievementChapter1": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 1"},
		// TODO "a_MaxAchievementChapter2": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 2"},
		// TODO "a_MaxAchievementChapter3": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 3"},
		// TODO "a_MaxAchievementChapter4": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 4"},
		// TODO "a_MaxAchievementChapter5": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 5"},
		// TODO "a_MaxAchievementChapter6": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 6"},
		// TODO "a_MaxAchievementChapter7": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 7"},
		// TODO "a_MaxAchievementChapter8": {
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in chapter 8"},
		// TODO "a_MaxAchievementEpilogue": {	
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in epilogue"},
		// CONCEPT "a_MaxAchievementEXChapter": {	// EX Chapter might count toward prologue percentage
		//	"id": 000000, "points": 25, "hasTips": false,
		// 	"devInfo": "Seen all the important cutscenes in EX chapter"},
		// TODO "a_MaxAchievementTotal": {
		//	"id": 000000, "points": 100, "hasTips": false,
		// 	"devInfo": "Seen ALL important the cutscenes"},
	},
	"c_Branch": { // Category - Branching path
		"a_GetOrnamentalEgg": { // REWORKED
			"id": 306885, "points": 3, "hasTips": true,
			"devInfo": "Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer."},
		"a_BecomeThePerformer": {	// REWORKED
			"id": 402284, "points": 5, "hasTips": true,
			"devInfo": "In chapter4, use the costume to give yourself a message. Only possible when you haven't acquired the egg in chapter 1??"},
		"a_EggCollection1": { // REWORKED 
			"id": 306977, "points": 5, "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with the stairs and door inside the building on fire, then go back in time, you'll be transported to the past inside the bar this time"},
		"a_EggCollection2": { // REWORKED
			"id": 306976, "points": 5, "hasTips": true,
			"devInfo": "Give the ornamental egg to the barman at his bar during chapter 3 or chapter 4"},
	},
	"c_Endings": { // Category - Achieving different endings
		"a_EndingA": { // REWORKED
			"id": 315566, "points": 10, "hasTips": true,
			"devInfo": "Ending A: Margarette (Ancestress) => Fortuneteller AND Homunculus => Town Square"},
		"a_EndingB1": {	// REWORKED
			"id": 315573, "points": 10, "hasTips": true,
			"devInfo": "Ending B1: Margarette (Ancestress) => Fortuneteller => Town Square"},
		"a_EndingB2": {	// REWORKED
			"id": 315572, "points": 10, "hasTips": true,
			"devInfo": "Ending B2: Margarette (Ancestress) => Homunculus => Town Square"},
		"a_EndingC": {	// REWORKED
			"id": 317118, "points": 10, "hasTips": true,
			"devInfo": "Ending C: Margarette (Ancestress) => Destroyed Lab"},
		"a_EndingD": {	// REWORKED
			"id": 322230, "points": 10, "hasTips": true,
			"devInfo": "Ending D: Margarette (Not an Ancestress) => Do Not Save Dana => Destroyed Lab"},
		"a_EndingE": {	// REWORKED
			"id": 322231, "points": 10, "hasTips": true,
			"devInfo": "Ending E: Margarette (Not an Ancestress) => Save Dana => Destroyed Lab"},
	},
	"c_Extra": { // Category - Extra side content & cutscenes
		"a_TimeTravellingCat": {	// TEST => has been tested in chapter 5 (should work for 4 - 5 - 7 - 8)
			"id": 310426, "points": 10, "hasTips": true,
			"devInfo": "Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart in present => give kitten before chapter 7"},		
		"a_DoctorateTimeTraveling": { // REWORKED
			"id": 310163, "points": 10, "hasTips": true,
			"devInfo": "Complete chapter 4 whilst also taking the a picture yourself in this chapter AND having acquired the ornamental egg from the performer in chapter 1 but did NOT use it to give your past self a message"},
		"a_ShowEggTownPlanter": { // REWORKED
			"id": 307023, "points": 5, "hasTips": true,
			"devInfo": "Show the ornamental egg to townplanter in 1580 in chapter 2"},
		"a_EggPocketWatchForCoffee": { // REWORKED
			"id": 313213, "points": 5, "hasTips": true,
			"devInfo": "Show off the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward"},
		"a_EikeThePyromancer": { // REWORKED
			"id": 306911, "points": 3, "hasTips": true,
			"devInfo": "Select the lighter to scare the people off in 1580 in chapter 2"},
		"a_EikeTheMagician": { // REWORKED	
			"id": 306906, "points": 3, "hasTips": true,
			"devInfo": "Select the cellphone to scare the people off in 1580 in chapter 2"},
		"a_EikeTheFlorist": { // REWORKED 
			"id": 306920, "points": 3, "hasTips": true,
			"devInfo": "Choose to plant flowers, when talking to the town planter in 1580 in chapter 2"},
		"a_ArtAppreciator": { // WORKING
			"id": 307499, "points": 4, "hasTips": true,
			"devInfo": "Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor"}, 
		// CONCEPT "a_ArtInspiration1": { 	// Squire's crest - Statue at marketplatz - view from tower - performer - alchemist house collapse - alchemist antidote
		//	"id": 000000, "points": 0000000, "hasTips": false,
		//	"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him at least once => view art in present, when Brum Estate is in Museum from"},
		// CONCEPT "a_ArtInspirationAll": { 	// Squire's crest - Statue at marketplatz - view from tower - performer - alchemist house collapse - alchemist antidote
		//	"id": 000000, "points": 0000000, "hasTips": false,
		//	"devInfo": "Talk to Karl Franssen in the Middle Ages and inspire him with different idea's => view art in present, when Brum Estate is in Museum from"},
		"a_AntiquesEule": { // REWORKED 
			"id": 310132, "points": 3, "hasTips": true,
			"devInfo": "Take a glance at timeless antiquity at Antique Shop Eule. Shop is open in chapter 3, 4 (present) and 6, 7 (1980)"},
		"a_EnigmaticCouple1": { // REWORKED
			"id": 307495, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during the prologue or chapter 1"},
		"a_EnigmaticCouple2": { // REWORKED
			"id": 310131, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 3"},
		"a_EnigmaticCouple3": { // REWORKED
			"id": 310134, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 4"},	
		"a_EnigmaticCouple4": { // REWORKED
			"id": 310135, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 5"},	
		"a_EnigmaticCouple5": { // REWORKED
			"id": 315564, "points": 5, "hasTips": true,
			"devInfo": "Find the coated couple in the present during chapter 7"},	
		"a_LostYoungCouple1": { // WORKING
			"id": 306984, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in the Middle Ages during chapter 2"},
		"a_LostYoungCouple2": { // WORKING
			"id": 310133, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 3"},
		"a_LostYoungCouple3": { // WORKING
			"id": 309393, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 4"},
		"a_LostYoungCouple4": { // WORKING
			"id": 310162, "points": 3, "hasTips": true,
			"devInfo": "Interact with the lost man in Middle Ages during chapter 5"},
		"a_LostYoungCouple5": { // WORKING
			"id": 314753, "points": 5, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 7"},
		"a_LostYoungCouple6": { // WORKING
			"id": 315568, "points": 10, "hasTips": true,
			"devInfo": "Interact with the lost couple in Middle Ages during chapter 8"},
		"a_HugoMotherChild": {  // REWORKED
			"id": 311466, "points": 5, "hasTips": true,
			"devInfo": "Secret cutscene in chapter 5 => when going to 1580 (not 1584) => head to marktplatz of Hugo getting bullied"}, 
		"a_SnowyCrimeScene": {  // REWORKED
			"id": 313209, "points": 10, "hasTips": true,
			"devInfo": "Discover a crime scene during the winter, in chapter 6"},
		"a_SaveMiriamBrum": {  // REWORKED
			"id": 315569, "points": 10, "hasTips": true,
			"devInfo": "Save Miriam Brum in chapter 6"},
		"a_MeetOldMiriam": { // REWORKED
			"id": 315570, "points": 10, "hasTips": true,
			"devInfo": "Complete chapter 7, whilst having saved Miriam in chapter 6"},
		"a_EnergyOrbLocatorPresentDay": { // REWORKED
			"id": 399816, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in present day"},
		"a_EnergyOrbLocator70s80s": { // REWORKED 
			"id": 399817, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 70s/80s"}, 
		"a_EnergyOrbLocator1900Days": { // REWORKED 
			"id": 399818, "points": 5, "hasTips": true,
			"devInfo": "Find all 5 energy orbs in 1900s"}, 
		"a_EnergyOrbLocatorMiddleAges": { // REWORKED 
			"id": 399819, "points": 5, "hasTips": true,
			"devInfo": "Find all 6 energy orbs in Middle Ages"}, 
		"a_NewCakeInvented": { // REWORKED
			"id": 402297, "points": 5, "hasTips": true,
			"devInfo": "Take the cake => give it to margarete => talk to bakery girl again (name of cake is now margarete)"}, 		
		"a_GiveMargaretteCake": { // REWORKED
			"id": 402296, "points": 3, "hasTips": true,
			"devInfo": "Acquire cake from bakery => give to margarette"}, 		
		"a_MaxInventory": { // REWORKED
			"id": 402404, "points": 10, "hasTips": true,
			"devInfo": "Acquire an old map, the ornamental egg, cake, photo shop sign, kitten, scrap of meat, red stone, letter to Dana + other key items"}, 
		"a_PocketWatchCollection": { // REWORKED
			"id": 315561, "points": 5, "hasTips": true,
			"devInfo": "Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7, not night before"},
		"a_PocketWatchReminiscing": { // REWORKED
			"id": 315562, "points": 5, "hasTips": true,
			"devInfo": "Talk to Eckart with the pocket watch in your inventory during chapter 8"},
		"a_BarmansChildren": { // REWORKED
			"id": 315567, "points": 5, "hasTips": true,
			"devInfo": "Uncover the truth about the barman's children and the mystery child during chapter 5"},
		// CONCEPT "a_ScareApprenticeMiddleAges": { 
		// 	"id": 00000, "points": 1, "hasTips": true,
		// 	"devInfo": "Scare the wannabe apprentice with a lighter or cellphone"},
		// CONCEPT "a_MeetingEveryone": { 
		// 	"id": 00000, "points": 3, "hasTips": true,
		// 	"devInfo": "Talk to all NPCs"},
		"a_ShortestChapter": { // REWORKED
			"id": 000000, "points": 3, "hasTips": true,
			"devInfo": "Have frying pan before chapter 4 and use is to skip chapter 4, by using it at the start"},
		"a_PerformerGoingExtraMile": { // REWORKED
			"id": 403575, "points": 5, "hasTips": true,
			"devInfo": "Make sure the performer goes the extra mile, by surprising as many people as possible"},
	},
	"c_Extra_GameOver": { // Category - Secret cutscenes that lead to player dying or game over screen
		"a_MetYouBefore": {  // REWORKED
			"id": 306888, "points": 5, "hasTips": true,
			"devInfo": "Die 4 times to the tree killer while speaking to Dana in chapter 2"},
		"a_ErasingEike": { // REWORKED
			"id": 306883, "points": 5, "hasTips": true,
			"devInfo": "Talk to yourself at cafe Sonné in the past during prologue"},
		"a_ErasingEike2": { // REWORKED
			"id": 314763, "points": 1, "hasTips": true,
			"devInfo": "Meet yourself at the Brum's mansion during chapter 7"},
		"a_RottenRope": { // REWORKED
			"id": 315563, "points": 1, "hasTips": false,
			"devInfo": "Try to save yourself with an old rope during chapter 7"},
		"a_ExcuseMeMyMy": { // REWORKED 
			"id": 306919, "points": 1, "hasTips": true,
			"devInfo": "When meeting Homonculus, chose to excuse yourself, during chapter 3"},
		"a_TimeEgoFlop": { // REWORKED 
			"id": 313212, "points": 1, "hasTips": true,
			"devInfo": "During chapter 6, co-direct Time Ego"},
	}
}


// ACHIEVEMENT TRIGGERS
// 	- check if key (achievementname) => is unique with ctrl+F
// ***********************************************************************************
_achievementTriggers = {
	"a_PrologueComplete": function PrologueComplete() { return
		never (	// Core group
			!isInGame() ||
			isEventViewerActive()	
		) &&		
		(
			(	// Alt 1 => Normal way of identifying cutscenes				
				once(	// Identifies Cutscene => watching performer
					isCutsceneActive() && isCurrentChapter("Prologue") &&
					isCurrentCutsceneMasterId(0x22480)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x1bcd0)	&&
					isCurrentCutsceneSectionDataId(0xe10)
				) &&
				once(	// Identifies cutscene => shadow/killer walking behind Eike
					isCutsceneActive() && isCurrentChapter("Prologue") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter1") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter2") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x3b240)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x340e0)	&&
					isCurrentCutsceneSectionDataId(0x7130)
				) &&
				once(	// Identifies Cutscene => stopping to smoke + turning around to see flowers/statue
					isCutsceneActive() && isCurrentChapter("Chapter2") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter3") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0x19d80)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x82a0)	&&
					isCurrentCutsceneSectionDataId(0x11ac0)
				) &&
				once(	// Identifies Cutscene => Back to Eckart and breaking vase
					isCutsceneActive() && isCurrentChapter("Chapter3") &&
					isCurrentSelectedInventoryItem("D-pad")	&&
					isCurrentCutsceneMasterId(0xcfb40)		&& isPriorCutsceneMasterId(0x19d80) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x39f0)	&&
					isCurrentCutsceneSectionDataId(0x387a0)
				) &&
				once(	// Identifies Cutscene => Back downstairs and talk to Homunculus
					isCutsceneActive() && isCurrentChapter("Chapter3") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentCutsceneMasterId(0x4f200)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x11cd0)	&&
					isCurrentCutsceneSectionDataId(0x3d500)
				) &&
				isFullCutsceneSequenceEnding()
			) || ( // Alt 2 
				once(	// Identifies cutscene => protecting yourself with pan AND having taken the picture in the performer outfit
					isCutsceneActive() && isCurrentChapter("Chapter4") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter4") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter5") &&
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
					isCutsceneActive() && 
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
					isCutsceneActive() && 				
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
					isCutsceneActive() && isCurrentChapter("Chapter7") &&
					isCurrentCutsceneMasterId(0x43040)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x0)		&&
					isCurrentCutsceneMasterDataId(0x7ce0)	&&
					isCurrentCutsceneSectionDataId(0xd940)
				) &&
				tally(1,[	// One of these is true, depending on ancestress or no ancestress choice
					once(	// Identifies Cutscene => Talking to Eckart, Ancestress path 
						isCutsceneActive() && isCurrentChapter("Chapter7") &&
						isMargaretteAncestor() &&
						isCurrentCutsceneMasterId(0xc6800)		&&
						isCurrentCutsceneSectionId_1(0x5)		&&
						isCurrentCutsceneSectionId_2(0x4)		&&
						isCurrentCutsceneMasterDataId(0x45720)	&&
						isCurrentCutsceneSectionDataId(0x6ccd0)),
					once(	// Identifies Cutscene => Talking to Eckart, No Ancestress path 
						isCutsceneActive() && isCurrentChapter("Chapter7") &&
						isMargaretteNoAncestor() &&
						isCurrentCutsceneMasterId(0xd1bc0)		&&
						isCurrentCutsceneSectionId_1(0x3)		&&
						isCurrentCutsceneSectionId_2(0x4)		&&
						isCurrentCutsceneMasterDataId(0x48000)	&&
						isCurrentCutsceneSectionDataId(0x5b190))]
				) &&
				once(	// Identifies Cutscene => Looking at painting of Dana
					isCutsceneActive() && isCurrentChapter("Chapter7") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x8b640)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x2d440)	&&
					isCurrentCutsceneSectionDataId(0x42750)
				) &&
				once(	// Identifies Cutscene => Summon Dr. Wagner with Homunculus
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x10ef00)		&&
					isCurrentCutsceneSectionId_1(0x9)		&&
					isCurrentCutsceneSectionId_2(0x8)		&&
					isCurrentCutsceneMasterDataId(0xb620)	&&
					isCurrentCutsceneSectionDataId(0xf4d0)
				) &&
				once(	// Identifies Cutscene => Dr. Wagner confronts Hugo
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xd5440)		&&
					isCurrentCutsceneSectionId_1(0x7)		&&
					isCurrentCutsceneSectionId_2(0x6)		&&
					isCurrentCutsceneMasterDataId(0x41550)	&&
					isCurrentCutsceneSectionDataId(0x2b420)
				) &&
				once(	// Identifies Cutscene => Hugo inside old Alchemist house collapsing
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0x716c0)		&&
					isCurrentCutsceneSectionId_1(0x9)		&&
					isCurrentCutsceneSectionId_2(0xa)		&&
					isCurrentCutsceneMasterDataId(0x239f0)	&&
					isCurrentCutsceneSectionDataId(0x19ef0)
				) &&
				once(	// Identifies Cutscene => Eike consoling Margarette
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
					isCurrentCutsceneMasterId(0xfbd00)		&&
					isCurrentCutsceneSectionId_1(0x5)		&&
					isCurrentCutsceneSectionId_2(0x4)		&&
					isCurrentCutsceneMasterDataId(0x5ff00)	&&
					isCurrentCutsceneSectionDataId(0x26f30)
				) &&
				once(	// Identifies Cutscene => Eike and Eckart talk, whilst Hugo and Margarette travel back to their time period
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter8_Ancestress") &&
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
					isCutsceneActive()  && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x77a40)		&& isPriorCutsceneMasterId(0x29700) &&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x31fd0)	&&
					isCurrentCutsceneSectionDataId(0x45a10)
				) &&
				once(	// Identifies Cutscene => Eike confronts Hugo at square
					isCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x4b140)		&& isPriorCutsceneMasterId(0x77a40) &&
					isCurrentCutsceneSectionId_1(0x5)		&&
					isCurrentCutsceneSectionId_2(0x4)		&&
					isCurrentCutsceneMasterDataId(0x122b0)	&&
					isCurrentCutsceneSectionDataId(0x189f0)
				) &&
				once(	// Identifies Cutscene => Margarette dissapears after Hugo dissappeared
					isCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
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
					isCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
					isCurrentCutsceneMasterId(0x101bc0)		&&
					isCurrentCutsceneSectionId_1(0x1)		&&
					isCurrentCutsceneSectionId_2(0x2)		&&
					isCurrentCutsceneMasterDataId(0x77920)	&&
					isCurrentCutsceneSectionDataId(0x725d0)
				) &&
				once(	// Identifies Cutscene => Margarette confronts Hugo in square
					isCutsceneActive() && isCurrentChapter("Chapter8_NoAncestress") &&
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
	"a_EndingA": function EndingA() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&
		once(	// Identifies Cutscene => Chosen to have Margarette stay in present + Z-pad breaks
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0xdb780)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x1bb0)	&&
			isCurrentCutsceneSectionDataId(0x32ce0)
		) &&
		once(	// Identifies Cutscene => Finding red jewel in tree at square
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x77f80)		&& isPriorCutsceneMasterId(0xdb780) &&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x25c50)	&&
			isCurrentCutsceneSectionDataId(0x1ac90)
		) &&
		isMargaretteAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("A")},
	"a_EndingB1": function EndingB1() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&

		// Below 2 cutscenes, are commented => player can quit and reload game between these cutscenes 
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus
		// 	isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
		// 	isCurrentCutsceneMasterId(0x3dd40)		&&
		// 	isCurrentCutsceneSectionId_1(0x3)		&&
		// 	isCurrentCutsceneSectionId_2(0x2)		&&
		// 	isCurrentCutsceneMasterDataId(0x9d20)	&&
		// 	isCurrentCutsceneSectionDataId(0x1ed10)
		// ) &&
		// once(	// Identifies Cutscene => Eike and Margarette talk to Homunculus part2
		// 	isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
		// 	isCurrentCutsceneMasterId(0x81b00)		&& isPriorCutsceneMasterId(0x3dd40) &&
		// 	isCurrentCutsceneSectionId_1(0x1)		&&
		// 	isCurrentCutsceneSectionId_2(0x2)		&&
		// 	isCurrentCutsceneMasterDataId(0x250f0)	&&
		// 	isCurrentCutsceneSectionDataId(0x13ff0)
		// ) &&

		// Below 2 cutscenes run up to ending credits
		once(	// Identifies Cutscene => Eike returns from sending Margarette back to past
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x613c0)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x43db0)	&&
			isCurrentCutsceneSectionDataId(0x1d5d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x56240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x400d0)	&&
			isCurrentCutsceneSectionDataId(0x16130)
		) &&
		isMargaretteAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("B")},
	"a_EndingB2": function EndingB2() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&
		once(	// Identifies Cutscene => Eike talks with Homunculus
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x91240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x44340)	&&
			isCurrentCutsceneSectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Eike gives z-pad back to Homunculus
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x5d2c0)		&& isPriorCutsceneMasterId(0x91240) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x1efd0)	&&
			isCurrentCutsceneSectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike goes to the bar
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x56240)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x400d0)	&&
			isCurrentCutsceneSectionDataId(0x16130)
		) &&
		isMargaretteAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("B")},
	"a_EndingC": function EndingC() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&
		once(	// Identifies Cutscene => Giving z-pad back to Homunculus
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x8cf00)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x44340)	&&
			isCurrentCutsceneSectionDataId(0x41cd0)
		) &&
		once(	// Identifies Cutscene => Homunculus has bad feeling
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0x7b140)		&& isPriorCutsceneMasterId(0x8cf00) &&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x1d530)	&&
			isCurrentCutsceneSectionDataId(0x2f6d0)
		) &&
		once(	// Identifies Cutscene => Eike getting roadkilled
			isCutsceneActive() && isCurrentChapter("Epilogue_Ancestress") &&
			isCurrentCutsceneMasterId(0xcb700)		&& isPriorCutsceneMasterId(0x7b140) &&
			isCurrentCutsceneSectionId_1(0x5)		&&
			isCurrentCutsceneSectionId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x1980)	&&
			isCurrentCutsceneSectionDataId(0x1e8d0)
		) &&
		isMargaretteAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("C")},		
	"a_EndingD": function EndingD() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&
		once(	// Identifies Cutscene => Talk to Homunculus at square
			isCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0x709c0)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x4)		&&
			isCurrentCutsceneMasterDataId(0x24770)	&&
			isCurrentCutsceneSectionDataId(0x11790)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and becomes youthfull
			isCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xc5b40)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x4)		&&
			isCurrentCutsceneMasterDataId(0x69b40)	&&
			isCurrentCutsceneSectionDataId(0x21b40)
		) &&
		isDanaNotSavedFromPast() && isMargaretteNoAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("D")},
	"a_EndingE": function EndingE() { return
		never(
			!isInGame() 					||
			isEventViewerActive()	||
			isViewingEndingFromExtraMenu()
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus
			isCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0x88dc0)		&&
			isCurrentCutsceneSectionId_1(0x3)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x2c3a0)	&&
			isCurrentCutsceneSectionDataId(0x5ca00)
		) &&
		once(	// Identifies Cutscene => Flashback: Dr. Wagner summons Homunculus and Dr. Wagner is killed
			isCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xbef80)		&&
			isCurrentCutsceneSectionId_1(0x9)		&&
			isCurrentCutsceneSectionId_2(0x8)		&&
			isCurrentCutsceneMasterDataId(0x59f60)	&&
			isCurrentCutsceneSectionDataId(0x155e0)
		) &&
		once(	// Identifies Cutscene => Eike and Dana talk with Homunculus some more
			isCutsceneActive() && isCurrentChapter("Epilogue_NoAncestress") &&
			isCurrentCutsceneMasterId(0xcdcc0)		&& isPriorCutsceneMasterId(0xbef80) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x33230)	&&
			isCurrentCutsceneSectionDataId(0x21780)
		) &&
		isDanaSavedFromPast() && isMargaretteNoAncestor() && // Trigger when cutscene is done
		!isCutsceneActive() && isEndingUnlocked("E")},
	"a_EnergyOrbLocatorPresentDay": function EnergyOrbLocatorPresentDay() {
		function measuredComparison() { return 
			tally(5, 
				getEnergyUnitsZPad() > prev(getEnergyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(
				!isWearingPerformerOutfit()	&&
				isCurrentMapScene("PresentDayCity") 		|| 
				isCurrentMapScene("PresentDayNightCity") ||
				isCurrentMapScene("NightBefore") 
			) && 
			isInGame()}
		return 
			never(	// Reset when chapter changes or when using digipad
				getEnergyUnitsZPad() < prev(getEnergyUnitsZPad()) ||
				isChapterChanging()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocator70s80s": function EnergyOrbLocator70s80s() {
		function measuredComparison() { return 
			tally(5, 				
				getEnergyUnitsZPad() > prev(getEnergyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive())}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(isCurrentMapScene("80sColdCity") || isCurrentMapScene("70sNightCity")) 	&& 	
			isInGame()}
		return 
			never( 	// Reset when chapter changes or when using digipad
				getEnergyUnitsZPad() < prev(getEnergyUnitsZPad()) ||
				isChapterChanging()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocatorMiddleAges": function EnergyOrbLocatorMiddleAges() {
		function measuredComparison() { return 
			tally(6, 
				getEnergyUnitsZPad() > prev(getEnergyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(
				isCurrentMapScene("MedievalCity") 				|| 
				isCurrentMapScene("MedievalNightCity")			||
				isCurrentMapScene("ExplodedAlchemistBasement")	||
				isCurrentMapScene("MedievalChurch")
			) && isInGame()}
		return 
			never(	// Reset when chapter changes or when using digipad
				getEnergyUnitsZPad() < prev(getEnergyUnitsZPad()) ||
				isChapterChanging()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnergyOrbLocator1900Days": function EnergyOrbLocator1900Days() {
		function measuredComparison() { return 
			tally(5, 
				getEnergyUnitsZPad() > prev(getEnergyUnitsZPad()) &&
				prior(onScreenTextID(1)) == 0x48ffc2	&&
				prior(onScreenTextID(2)) == 0x4b0000	&&
				prior(onScreenTextID(3)) == 0x480032	&&
				!isCutsceneActive()
			)}
		function measuredIfComparison() { return
			// Only measure when in correct scene AND when in-game
			(isCurrentMapScene("1900sCity") || isCurrentMapScene("1900sBrumMansion")) && 	
			isInGame()}
		return 
			never(	// Reset when chapter changes or when using digipad
				getEnergyUnitsZPad() < prev(getEnergyUnitsZPad()) ||
				isChapterChanging()	||
				isWearingPerformerOutfit() && isCurrentMapScene("PresentDayCity")	// --> Fix for bug, where player could pick up the energy orb in the 
		) &&																			// 		Brum Estate twice (once before being performer to get frying pan and once after)
			measured(measuredComparison(), measuredIfComparison())},					// 		Now it will reset this count, when going back to get frying pan as performer
	"a_DoctorateTimeTraveling": function DoctorateTimeTraveling() { return
		// TEST there's differences in cutscene data depending on choices made, frying pan/shop sign, acquired egg or not??? => rather use cutscene data that is same across these differences
		never(
			!isInGame() 				||
			!isCurrentChapter("Chapter4")	||
			isEventViewerActive()
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using frying pan
				isCutsceneActive() && isCurrentSelectedInventoryItem("FryingPan") &&
				isCurrentCutsceneMasterId(0xb0100)		&&
				isCurrentCutsceneSectionId_1(0xd)		&&
				isCurrentCutsceneSectionId_2(0xe)		&&
				isCurrentCutsceneMasterDataId(0x1efb0)	&&
				isCurrentCutsceneSectionDataId(0xae70)),
			once(	// Identifies Cutscene => Info/lore dump about timetravel and branching paths after using photo shop sign
				isCutsceneActive() && isCurrentSelectedInventoryItem("Sign") &&
				isCurrentCutsceneMasterId(0xb0100)		&& 
				isCurrentCutsceneSectionId_1(0xd)		&&
				isCurrentCutsceneSectionId_2(0xe)		&&
				isCurrentCutsceneMasterDataId(0x1efb0)	&&
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
			isCutsceneActive() && 
			isCurrentCutsceneMasterId(0x43040)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x7ce0)	&&
			isCurrentCutsceneSectionDataId(0xd940)
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				isCutsceneActive() && isMargaretteAncestor() && 
				isCurrentCutsceneMasterId(0xc7940)		&&
				isCurrentCutsceneSectionId_1(0x1)		&&
				isCurrentCutsceneSectionId_2(0x0)		&&
				isCurrentCutsceneMasterDataId(0x95c0)	&&
				isCurrentCutsceneSectionDataId(0x7410)),
			once(	// Identifies Cutscene => No Ancestor path => Old Miriam walks into conversation with Eckart and Eike
				isCutsceneActive() && isMargaretteNoAncestor() && 
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
			isCutsceneActive() && 
			isCurrentCutsceneMasterId(0x19380)		&& 
			isCurrentCutsceneSectionId_1(0x7)		&&
			isCurrentCutsceneSectionId_2(0x8)		&&
			isCurrentCutsceneMasterDataId(0x5e60)	&&
			isCurrentCutsceneSectionDataId(0x134f0)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_EggCollection1": function EggCollection1() { return 
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter1") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Exchanging egg for frying pan
			isCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
			isCurrentCutsceneMasterId(0x2f9c0)		&& 
			isCurrentCutsceneSectionId_1(0x7)		&&
			isCurrentCutsceneSectionId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x5400)	&&
			isCurrentCutsceneSectionDataId(0x249e0)
		) &&
		isFullCutsceneSequenceEnding()},
	"a_EggCollection2": function EggCollection2() { return 
		never (
			!isInGame() ||
			isEventViewerActive()
		) &&
		never (
			!isCurrentChapter("Chapter3") && !isCurrentChapter("Chapter4")
		) &&
		tally(1, [
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 3
				isCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
				isCurrentChapter("Chapter3") 			&&
				isCurrentCutsceneMasterId(0x32200)		&& 
				isCurrentCutsceneSectionId_1(0x7)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5400)	&&
				isCurrentCutsceneSectionDataId(0x249e0)),
			once(	// Identifies Cutscene => Exchanging egg for frying pan in chapter 4
				isCutsceneActive() && isItemInInventory("OrnamentalEgg") &&
				isCurrentChapter("Chapter4") 			&&
				isCurrentCutsceneMasterId(0x2f9c0)		&& 
				isCurrentCutsceneSectionId_1(0x7)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5400)	&&
				isCurrentCutsceneSectionDataId(0x249e0))]
		) &&
		isFullCutsceneSequenceEnding()},
	"a_ShowEggTownPlanter": function ShowEggTownPlanter() { return 
		never (
			!isInGame() 				||
			!isCurrentChapter("Chapter2") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Show off egg to town planter
			isCutsceneActive() && isCurrentSelectedInventoryItem("OrnamentalEgg") &&
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
				isCutsceneActive() && isCurrentMapScene("1900sCity") && 
				isCurrentCutsceneMasterId(0x8b440) 		&&
				isCurrentCutsceneSectionId_1(0x5)		&&
				isCurrentCutsceneSectionId_2(0x6)		&&
				isCurrentCutsceneMasterDataId(0x5ac20)	&&
				isCurrentCutsceneSectionDataId(0x1de70)	&&
				isCurrentMinorCutsceneId(0xdefe0, 0x8)			&&
				isCurrentMinorCutsceneId(0x2c3d0, 0x2c)),
			once(	// Identifies Cutscene => Drank coffee before eqcuiring pocket watch egg, now coming back to pay for coffee with the pocket watch egg
				isCutsceneActive() && isCurrentMapScene("1900sCity") && 
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
			isCutsceneActive() && isItemInInventory("EggPocketWatch") &&
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
			isCutsceneActive() && isItemInInventory("EggPocketWatch") &&
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
			isCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
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
			isCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
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
			isCutsceneActive() && isCurrentSelectedInventoryItem("D-pad") &&
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
			isCutsceneActive() && 
			isCurrentCutsceneMasterId(0xd0200)		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x3d290)	&&
			isCurrentCutsceneSectionDataId(0x92f30)
		) &&
		isCutsceneSectionEnding()},
	"a_LostYoungCouple1": function LostYoungCouple1() { 
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2_old() == 0x08a329ac),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2_old() == 0x08a329fc),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2_old() == 0x08a329c0),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2_old() == 0x08a32a10),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2_old() == 0x08a329d4),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2_old() == 0x08a32a24)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter2")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isInGame()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter2")
			) &&
			unless(
				interactionID_1_old() != 0x08b97810 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2_old() != 0x08a329fc 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b97804 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2_old() != 0x08a329ac 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b97810 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2_old() != 0x08a32a10 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b97804 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2_old() != 0x08a329c0 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b97810 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2_old() != 0x08a32a24 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b97804 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2_old() != 0x08a329d4 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple2": function LostYoungCouple2() {  
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2_old() == 0x08a32c18),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2_old() == 0x08a32c68),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2_old() == 0x08a32c2c),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2_old() == 0x08a32c7c),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2_old() == 0x08a32c40),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2_old() == 0x08a32c90)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter3")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isInGame()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}	
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter3")
			) &&
			unless(
				interactionID_1_old() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2_old() != 0x08a32c68 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b964 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2_old() != 0x08a32c18 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2_old() != 0x08a32c7c 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b964 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2_old() != 0x08a32c2c 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b970 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2_old() != 0x08a32c90 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b964 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2_old() != 0x08a32c40 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple3" : function LostYoungCouple3() {
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		
		// Private functions
		function measuredComparison() { return
			tally(6, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2_old() == 0x08a33000),			// Add hit: +1  	=> for talking to man 1st time
				once(interactionID_2_old() == 0x08a33050),			// Add hit: +1  	=> for talking to woman 1st time
				once(interactionID_2_old() == 0x08a33014),			// Add hit: +1  	=> for talking to man 2nd time
				once(interactionID_2_old() == 0x08a33064),			// Add hit: +1		=> for talking to woman 2nd time
				once(interactionID_2_old() == 0x08a33028),			// Add hit: +1  	=> for talking to man 3rd time
				once(interactionID_2_old() == 0x08a33078)			// Add hit: +1 = 6	=> for talking to woman 3rd time
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter4")) &&	// Hit count 100 => when loading another save to another chapter, there's a few 
			isInGame()	&& 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter4")
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 1st time
				interactionID_2_old() != 0x08a33050 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2_old() != 0x08a33000 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 2nd time
				interactionID_2_old() != 0x08a33064 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2_old() != 0x08a33014 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9b8 	&&		// Block => cutscene when talking to woman 3rd time
				interactionID_2_old() != 0x08a33078 	&&
				interactionID_3_old() != 0x197			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1b9ac 	&&		// Block => cutscene when talking to man 3rd time
				interactionID_2_old() != 0x08a33028 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple4": function LostYoungCouple4() {
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		
		function measuredComparison() { return
			tally(2, [
				once(interactionID_2_old() == 0x08a331cc),		// => cutscene when talking to man 1st time
				once(interactionID_2_old() == 0x08a331e0)		// => cutscene when talking to man 2nd time
			])}
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter5")) && 
			isInGame() && 
			!IsViewingCutsceneFromExtraMenu_old()} 
		return
			never(
				!isCurrentChapter("Chapter5")
			) &&
			unless(
				interactionID_1_old() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 1st time
				interactionID_2_old() != 0x08a331cc 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08b9d5ec 	&&		// Block => cutscene when talking to man 2nd time
				interactionID_2_old() != 0x08a331e0 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple5": function LostYoungCouple5() {
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		
		// Private functions
		function measuredComparison() { return
			tally(2, [	// this hit count becomes the hit count for the final comparison in the array
				once(interactionID_2_old() == 0x08a33398),			// Add hit: +1  	=> for talking to man 
				once(											// Add hit: +1		=> when talking to woman and picking dialogue option: Tell the truth
					interactionID_2_old() == 0x08a333fc && prior(interactionID_2_old()) == 0x8a333e8 &&
					onScreenTextID(1) == 0x0 && prior(onScreenTextID(1)) == 0x40ff92		&&	
					onScreenTextID(4) == 0x0 && prior(onScreenTextID(4)) == 0x80007			&&	
					onScreenTextID(5) == 0x0 && prior(onScreenTextID(5)) == 0x4ffff0	
				)			
			])}	
		function measuredIfComparison() { return
			repeated(100, isCurrentChapter("Chapter7")) &&	// Hit count 100 => when loading a savefile to another chapter, there's a few 
			isInGame() && 								// frames where both these comparisons are true. So this hit counts fixes that
			!IsViewingCutsceneFromExtraMenu_old()}
		// Trigger 
		return 
			never(
				!isCurrentChapter("Chapter7")
			) &&
			unless(
				interactionID_1_old() != 0x08a1bb38 	&&		// Block => cutscene when talking to man 
				interactionID_2_old() != 0x08a33398 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08a1bb44 &&			// Block => cutscene when talking to woman and picking dialogue option: Tell the truth
				interactionID_2_old() != 0x08a333fc && prior(interactionID_2_old()) != 0x8a333e8 &&
				interactionID_3_old() != 0x197		&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_LostYoungCouple6": function LostYoungCouple6() { 
		// function measuredComparison() { return
		// 	tally(4, [
		// 		repeated(GetMaxTalkCountFor("CoatedWoman_Present","xxxxxxxxx"),
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedWoman_Present") &&
		// 			isNPCtalkCountIncreased("CoatedWoman_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx)),
		// 		repeated(GetMaxTalkCountFor("CoatedMan_Present","xxxxxxxxx"), 
		// 			isSmallCutsceneActive() &&
		// 			isTalkingTo("CoatedMan_Present") &&
		// 			isNPCtalkCountIncreased("CoatedMan_Present", "xxxxxxxxx") &&
		// 			isInteractionID_1(xxxxxxxxx) && isInteractionID_2(xxxxxxxxx))
		// 	])}
		// return 
		// 	never(	
		// 		!isInGame() ||
		// 		!isCurrentChapter("Chapter4")
		// 	) &&
		// 	measured(measuredComparison(), always_true()) &&
		// 	trigger_when(!isSmallCutsceneActive())},
		
		
		function measuredComparison() { return
			tally(2, [									//			= 2
				once(interactionID_2_old() == 0x08a335f0),	// Add hit: +1  	=> for talking to man before experiment
				once(interactionID_2_old() == 0x08a3367c)	// Add hit: +1		=> for talking to man after experiment for 2nd time after picking the dialogue option: Lovers never destined to meet 
			])}	
		function measuredIfComparison() { return
			repeated(100, 								// Hit count 100 => when loading a savefile to another chapter, there's a few 
				isCurrentChapter("Chapter8")			// frames where both these comparisons are true. So this hit counts fixes that	
			) &&										// The no-ancestress route might not spawn the man in this chapter. Other route does, when having talked having told the woman and told her to tell the truth in chapter 7
			isInGame() && 	
			!IsViewingCutsceneFromExtraMenu_old()}
		return 
			never(
				!isCurrentChapter("Chapter8")
			) &&
			unless(
				interactionID_1_old() != 0x08ba3264 	&&		// Block => cutscene when talking to man before experiment
				interactionID_2_old() != 0x08a335f0 	&&
				interactionID_3_old() != 0x198			&&
				!isCutsceneActive_old()
			) &&
			unless(
				interactionID_1_old() != 0x08ba349c 	&&		// Block => cutscene when talking to man after experiment for 2nd time after picking the dialogue option: Lovers never destined to meet  
				interactionID_2_old() != 0x08a3367c 	&&
				interactionID_3_old() != 0x198			&&
				onScreenTextID(1) != 0x0048ff81		&&
				onScreenTextID(2) != 0x00480000		&&
				onScreenTextID(3) != 0x0048fffc		&&
				onScreenTextID(4) != 0x00080009		&&
				!isCutsceneActive_old()
			) &&
			measured(measuredComparison(), measuredIfComparison())},
	"a_EnigmaticCouple1": function EnigmaticCouple1() {
		function measuredComparison() { return
			tally(4, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap1Prologue_TownSquare"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap1Prologue_TownSquare") &&
					isInteractionID_1(0x1e) && isInteractionID_2(0x2cc)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap1Prologue_NearBar"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreased("CoatedMan_Present", "Chap1Prologue_NearBar") &&
					isInteractionID_1(0x1e) && isInteractionID_2(0x2c1))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Prologue") && !isCurrentChapter("Chapter1")
			) &&
			measured(measuredComparison(), always_true()) &&
			trigger_when(!isSmallCutsceneActive())},
	"a_EnigmaticCouple2": function EnigmaticCouple2() { 
		function measuredComparison_onIncrease() { return	// Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2d0)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap3_NearAntiqueShop"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreased("CoatedMan_Present", "Chap3_NearAntiqueShop") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2c4))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2d0)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap3_NearAntiqueShop"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap3_NearAntiqueShop") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2c4))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter3")
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true()) &&
			trigger_when(!isSmallCutsceneActive())},
	"a_EnigmaticCouple3": function EnigmaticCouple3() {
		function measuredComparison_onIncrease() { return // Measure comparison => counts up for each seperate dialogues with CoatedWoman_Present
			tally(4, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d0)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap4_HaupStrUnderArch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreased("CoatedMan_Present", "Chap4_HaupStrUnderArch") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2c5))
			])}
		function measuredComparison_onMax() { return	// Measure comparison => counts up MaxTalkCount on the last dialogue, in case of reloading mid measurement 
			tally(4, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap3_OutsideAntiqueShop_Chap4_KirchenStrBar") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d0)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap4_HaupStrUnderArch"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap4_HaupStrUnderArch") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2c5))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter4")
			) &&	// 2 Alt groups => measuredComparison_onMax(), achievement is still unlockable when reloading mid-measurement
			measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true()) &&
			trigger_when(!isSmallCutsceneActive())},
	"a_EnigmaticCouple4": function EnigmaticCouple4() {
		function measuredComparison_BrumLibrary_onIncrease() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d5)),
				repeated(2, // --> overwrite of '''GetMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumLibrary")''', both measures must have same count
					isSmallCutsceneActive() && isBrumEstateLibrary() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumLibrary") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2c9))
			])}
		function measuredComparison_BrumLibrary_onMax() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d5)),
				repeated(2, // --> overwrite of 'GetMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumLibrary")', all measures must have same count
					isSmallCutsceneActive() && isBrumEstateLibrary() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumLibrary") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2c9))
			])}
		function measuredComparison_BrumMuseum_onIncrease() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d5)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumMuseum"), 
					isSmallCutsceneActive() && isBrumEstateMuseum() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreased("CoatedMan_Present", "Chap5_NorthEastGate_BrumMuseum") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2ca))
			])}
		function measuredComparison_BrumMuseum_onMax() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap5_NearCafeSonne"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap5_NearCafeSonne") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2d5)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap5_NorthEastGate_BrumMuseum"), 
					isSmallCutsceneActive() && isBrumEstateMuseum() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap5_NorthEastGate_BrumMuseum") &&
					isInteractionID_1(0x4b) && isInteractionID_2(0x2ca))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter5")
			) &&
			trigger_when(!isSmallCutsceneActive()) &&
			measured(measuredComparison_BrumMuseum_onIncrease()) || measured(measuredComparison_BrumMuseum_onMax()) ||
			measured(measuredComparison_BrumLibrary_onIncrease()) || measured(measuredComparison_BrumLibrary_onMax())},
	"a_EnigmaticCouple5": function EnigmaticCouple5() {
		function measuredComparison_onIncrease() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap7_SouthGate"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountIncreased("CoatedWoman_Present", "Chap7_SouthGate") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2d3)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap7_NorthWestGate"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountIncreased("CoatedMan_Present", "Chap7_NorthWestGate") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2c8))
			])}
		function measuredComparison_onMax() { return
			tally(3, [
				repeated(GetMaxTalkCountFor("CoatedWoman_Present","Chap7_SouthGate"),
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedWoman_Present") &&
					isNPCtalkCountAtMax("CoatedWoman_Present", "Chap7_SouthGate") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2d3)),
				repeated(GetMaxTalkCountFor("CoatedMan_Present","Chap7_NorthWestGate"), 
					isSmallCutsceneActive() &&
					isTalkingTo("CoatedMan_Present") &&
					isNPCtalkCountAtMax("CoatedMan_Present", "Chap7_NorthWestGate") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0x2c8))
			])}
		return 
			never(	
				!isInGame() ||
				!isCurrentChapter("Chapter7")
			) &&
			measured(measuredComparison_onIncrease(), always_true()) || measured(measuredComparison_onMax(), always_true()) &&
			trigger_when(!isSmallCutsceneActive())},
	"a_BecomeThePerformer": function BecomeThePerformer() {	return
		never(
			!isInGame()					||
			isEventViewerActive() 	||
			isNewCutsceneLoading()				||
			!isWearingPerformerOutfit()			||
			!isCurrentSelectedInventoryItem("Jugglery")	
		) &&
		once(	// Identifies Cutscene => Eike gives himself a message as performer
			isCutsceneActive() && isCurrentChapter("Chapter4") &&
			isCurrentCutsceneMasterId(0x1a300)		&&
			isCurrentCutsceneSectionId_1(0xd)		&&
			isCurrentCutsceneSectionId_2(0xc)		&&
			isCurrentCutsceneMasterDataId(0x7d40)	&&
			isCurrentCutsceneSectionDataId(0x460)
		) &&
		isCutsceneSectionEnding()},
	"a_GiveMargaretteCake": function GiveMargaretteCake() { return 
		never(
			!isInGame()					||
			isEventViewerActive() 	||
			!isCurrentSelectedInventoryItem("Cake")	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 1st time
			isCutsceneActive() && 
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
					isNPCtalkCountIncreasedToMax("BlondeYoungBoy_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionID_1(0x44) && isInteractionID_2(0x39c)),	// IDs last dialogue sequence on this NPC's appearance
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteMother_Present") &&
					isNPCtalkCountIncreasedToMax("BrunetteMother_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionID_1(0x44) && isInteractionID_2(0x336)),
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteYoungGirl_Present") &&
					isNPCtalkCountIncreasedToMax("BrunetteYoungGirl_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionID_1(0x44) && isInteractionID_2(0x323)),
				once(
					isSmallCutsceneActive() &&
					isTalkingTo("BlondeOldWomanOrangeSweater_Present") &&
					isNPCtalkCountIncreasedToMax("BlondeOldWomanOrangeSweater_Present", "Chap4_WearingPerformerOutfit") &&
					isInteractionID_1(0x44) && isInteractionID_2(0x32c)),
				once(	// This appearance does not have a memory address for talk count
					isSmallCutsceneActive() &&
					isTalkingTo("BrunetteAdultManGlasses_Present") &&
					isCurrentMapScene("PresentTownHall") &&
					isInteractionID_1(0x29) && isInteractionID_2(0x3c6)),
				once(	// This appearance does not have a memory address for talk count
					isSmallCutsceneActive() &&
					isTalkingTo("BlondeElderlyWoman_Present") &&
					isCurrentMapScene("PresentTownHall") &&
					isInteractionID_1(0x29) && isInteractionID_2(0x3cc)),
				once(	// This counts Eike, giving egg to Eike/yourself
					isCutsceneActive() && isCurrentChapter("Chapter4") &&
					isCurrentCutsceneMasterId(0x1a300)		&&
					isCurrentCutsceneSectionId_1(0xd)		&&
					isCurrentCutsceneSectionId_2(0xc)		&&
					isCurrentCutsceneMasterDataId(0x7d40)	&&
					isCurrentCutsceneSectionDataId(0x460))
			])}
		return 
			never(	
				!isInGame() 				||
				!isCurrentChapter("Chapter4")	||
				repeated(300, !isWearingPerformerOutfit())		// ---> Repeat is necessary, because bit flag for isWearingPerformerOutfit() 
			) &&												// 		changes to 0 for a few frames when loading into townhall/city 
			measured(measuredComparison(), always_true()) &&	// 		=> we don't want to reset that count here 
			trigger_when(!isSmallCutsceneActive() && !isCutsceneActive())},
	"a_NewCakeInvented": function NewCakeInvented() { return
		never(
			!isInGame()					||
			isEventViewerActive() 	||
			!isCurrentSelectedInventoryItem("Cake")	
		) &&
		once(	// Identifies Cutscene => Eike gives Margarette Cake for 2nd time
			isCutsceneActive() && 
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
		// 	// let_comparisonsArray = array_map(_inventoryItems, (item) {	// array_map returns a new array with the comparisons
		// 	// 	let_memAddress = _inventoryItems[item]["memAddress_Flag_isInInventory"]
		// 	// 	return prev(bit0(let_memAddress)) < bit0(let_memAddress)
		// 	// })
		// 	// let_deductComparisonArray = array_map(_inventoryItems, (item) {	// array_map returns a new array with the comparisons
		// 	// 	let_memAddress = _inventoryItems[item]["memAddress_Flag_isInInventory"]
		// 	// 	return deduct(prev(bit0(let_memAddress)) > bit0(let_memAddress))
		// 	// })
		// 	// for deductComparison in let_deductComparisonArray {
		// 	// 	array_push(let_comparisonsArray, deductComparison)
		// 	// }
		// 	// CODE BLOCK B
		// 	let_comparisonsArray = [always_false()]
		// 	for item in _inventoryItems {
		// 		let_memAddress = _inventoryItems[item]["memAddress_Flag_isInInventory"]
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
				tally_of(_inventoryItems, let_biggestPossibleInventory, (item) {
					let_memAddress = _inventoryItems[item]["memAddress_Flag_isInInventory"]
					return once(bit0(let_memAddress) == 1)
				})
		}
		return 
			never(	
				isAtTitleScreen()					||
				isEventViewerActive()	||

				// Reset if any item is gained or removed
				// 	Checks if any item_in_inventory_flags has changed
				any_of(_inventoryItems, (item) {
					let_memAddress = _inventoryItems[item]["memAddress_Flag_isInInventory"]
					return bit0(let_memAddress) != prev(bit0(let_memAddress))
				})
			) &&
			measured(measuredComparison(), always_true()) &&
			!isCutsceneActive()},		
	"a_ShortestChapter": function ShortestChapter(){ return
		never(
			!isInGame()						||
			!isCurrentChapter("Chapter4")			||
			isEventViewerActive()		||
			!isCurrentSelectedInventoryItem("FryingPan") ||
			
			// If preventing 1st death in chapter 4 by using the frying pan 
			//	=> black and white picture is not found inside book after death in this chapter
			//	=> Thus can be used as a flag for this achievement
			isItemInInventory("BLackWhitePhoto") 	|| 
			isItemInInventory("BLackWhitePhotoWithPerformer")			 
		) &&
		once(	// Identifies Cutscene => Using frying pan for defence
			isCutsceneActive() && 
			isCurrentCutsceneMasterId(0x4f200)		&&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0x11cd0)	&&
			isCurrentCutsceneSectionDataId(0x3d500)	
		) &&
		isFullCutsceneSequenceEnding()},
	"a_ArtInspiration1": function ArtInspiration1() { return
		never(
			!isInGame()
		) && (
			isSmallCutsceneActive() && 
			isInteractingWith("Painting_TowerView") && 
			isCurrentMapScene("BrumMuseumDownstairsRoom") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x124)
		) || (
			isSmallCutsceneActive() && 	
			isInteractingWith("Painting_SquireCrest") && 
			isCurrentMapScene("BrumMuseumUpstairsRoom1") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x125)
		) || (
			isSmallCutsceneActive() &&
			isInteractingWith("Painting_TownSquare") && 
			isCurrentMapScene("BrumMuseumUpstairsRoom1") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x126)
		) || (
			isSmallCutsceneActive() &&
			isInteractingWith("Painting_AlchemyLab") && 
			isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x127)
		) || (
			isSmallCutsceneActive() &&
			isInteractingWith("Painting_Performer") && 
			isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x128)
		) || (
			isSmallCutsceneActive() &&
			isInteractingWith("Painting_CollapsedHouse") && 
			isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
			isInteractionID_1(0x13) && isInteractionID_2(0x129)
		)},
	"a_ArtInspirationAll": function ArtInspirationAll() { return
		always_false()
		},
	"a_ArtAppreciator": function ArtAppreciator() {
		function measuredComparison() {
			tally(8, [
				once(
					isSmallCutsceneActive() && 	
					isInteractingWith("Painting_TowerView") && 
					isCurrentMapScene("BrumMuseumDownstairsRoom") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x124)),
				once(
					isSmallCutsceneActive() && 	
					isInteractingWith("Painting_SquireCrest") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom1") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x125)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_TownSquare") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom1") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x126)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_AlchemyLab") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x127)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_Performer") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x128)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_CollapsedHouse") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom2") &&
					isInteractionID_1(0x13) && isInteractionID_2(0x129)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_LandscapeTown") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom3") &&
					isInteractionID_1(0x13) && isInteractionID_2(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Painting_Alchemist") && 
					isCurrentMapScene("BrumMuseumUpstairsRoom3") &&
					isInteractionID_1(0x13) && isInteractionID_2(0xffffffff))
			])}
		return
			never(
				!isInGame() ||
				isChapterChanging()
			) &&
			trigger_when(!isSmallCutsceneActive()) &&
			measured(measuredComparison(), always_true())},
	"a_AntiquesEule": function AntiquesEule() {
		function measuredComparison() {
			tally(4, [
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_FranssenShopSign") && 
					isInteractionID_1(0xb2) && isInteractionID_2(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Rope") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Antidote") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0xffffffff)),
				once(
					isSmallCutsceneActive() &&
					isInteractingWith("Antique_Mask") &&
					isInteractionID_1(0xb2) && isInteractionID_2(0xffffffff))
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
	"a_SnowyCrimeScene": function SnowyCrimeScene() { return
		never(
			!isInGame()				||
			!isCurrentChapter("Chapter6") 	||
			isEventViewerActive()
		) &&
		once(	// Identifies Cutscene => Miriam shot and dying 
				// TEST => IDs here work with NoAncstor_path => work also with Ancestor_path??
				isCutsceneActive() && isCurrentMapScene("80sColdCity") &&
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
			!isCurrentChapter("Chapter6")			||
			isEventViewerActive()			 
		) &&
		once(	// Identifies Cutscene => Eike save Miriam, after running after her
			isCutsceneActive() && isCurrentMapScene("80sColdCity") &&
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
			isCutsceneActive() && 
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
			!isInGame() || !isCutsceneActive_old() || IsViewingCutsceneFromExtraMenu_old() || 
			!isCurrentChapter("Chapter4") && !isCurrentChapter("Chapter5") && 
			!isCurrentChapter("Chapter6") && !isCurrentChapter("Chapter7") &&
			!isCurrentChapter("Chapter8_Ancestress") && !isCurrentChapter("Chapter8_NoAncestress")
		) &&
		tally(2, [
			once(
				currentCutsceneId(4) == 0xff4700a3 	&& priorCutsceneId(4) == 0x77 			&& // Blocks => IDs the cutscenes
				currentCutsceneId(20) == 0x2622fab8 && priorCutsceneId(20) == 0xf9c20180	&&
				currentCutsceneId(14) == 0xc4a7d2c5 && priorCutsceneId(14) == 0x5cb			&&
				onScreenTextID(0) == 0x37			&& prior(onScreenTextID(0)) == 0x4c),
			once(
				currentCutsceneId(7) == 0x88880011 	&& priorCutsceneId(7) == 0x71 			&&
				currentCutsceneId(17) == 0xf6e1fffe && priorCutsceneId(17) == 0x473d4f		&&
				currentCutsceneId(11) == 0xff4fffec && priorCutsceneId(11) == 0xfd640278	&&
				onScreenTextID(0) == 0x4c			&& prior(onScreenTextID(0)) == 0x73),		
		]) && 
		repeated(160, onScreenTextID(0) == 0x0)}, // trigger when last text in cutscene is finished
	"a_ErasingEike": function ErasingEike() { return 
		never(
			!isInGame()				||
			!isCurrentChapter("Prologue")	||
			isEventViewerActive()  
		) &&
		once(	// Identifies Cutscene => Eike wakes himself up
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x9c00)		&&
			isCurrentCutsceneMasterDataId(0x9bf0)	&&
			isCurrentCutsceneSectionDataId(0x9bf0)	&&
			isCurrentMinorCutsceneId(0x9bf0, 0x28) &&
			isCurrentMinorCutsceneId(0xea70, 0x8) 	
		) && 
		once(	// Identifies Cutscene => Eike wakes himself up
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x237c0)		&& isPriorCutsceneMasterId(0x9c00) &&
			isCurrentCutsceneMasterId_1(0x1)		&&
			isCurrentCutsceneMasterId_2(0x0)		&&
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
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x15640) 		&&
			isCurrentCutsceneMasterId_1(0x5)		&&
			isCurrentCutsceneMasterId_2(0x6)		&&
			isCurrentCutsceneMasterDataId(0x7830)	&&
			isCurrentCutsceneSectionDataId(0x2220)
		) &&
		once(	// Identifies Cutscene => Waking up in Limbo after death
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x237c0) 		&& isPriorCutsceneMasterId(0x15640) &&
			isCurrentCutsceneMasterId_1(0x1)		&&
			isCurrentCutsceneMasterId_2(0x0)		&&
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
				isCutsceneActive() && 
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
			isCutsceneActive()	&&	
			isCurrentCutsceneMasterId(0x6e480) 		&& 
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x45250)	&&
			isCurrentCutsceneSectionDataId(0x143f0)	
		) && 
		once(	// Identifies Cutscene => Getting stabbed from behind
			isCutsceneActive()	&&	
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
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0xb140) && isPriorCutsceneMasterId(0x5aa80) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x2)		&&
			isCurrentCutsceneMasterDataId(0x5ac0)	&&
			isCurrentCutsceneSectionDataId(0x38b0)	
		) && 
		once(
			isCutsceneActive()	&&
			isCurrentCutsceneMasterId(0x1a440) && isPriorCutsceneMasterId(0xb140) &&
			isCurrentCutsceneSectionId_1(0x1)		&&
			isCurrentCutsceneSectionId_2(0x0)		&&
			isCurrentCutsceneMasterDataId(0xd9a0)	&&
			isCurrentCutsceneSectionDataId(0xca50)	
		) &&
		isCutsceneSectionEnding()},
	// "a_Template": function Template() {},
}


// ACHIEVEMENT TITLES & DESCRIPTIONS
// ***********************************************************************************
_achievementTitles = {
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
	"a_Chapter8Complete":							{"en": "The Whole Picture... Or is it?"},
	"a_EndingA":									{"en": "An End to a Strange Experience"},
	"a_EndingB1":									{"en": "No Sense of Finality I"},
	"a_EndingB2":									{"en": "No Sense of Finality II"},
	"a_EndingC": 									{"en": "'If only... I had one more attempt'"},
	"a_EndingD": 									{"en": "Eike's Origins"},
	"a_EndingE": 									{"en": "'The future is what we make it.'"},
	"a_MeetOldMiriam":								{"en": "The Brums Happily Ever After"},
	"a_DoctorateTimeTraveling": 					{"en": "Complexities of the Fourth Dimension"}, 
	"a_GetOrnamentalEgg": 							{"en": "A Performer's Clue"}, 
	"a_EggCollection1": 							{"en": "A Jovial Exchange I"},
	"a_EggCollection2": 							{"en": "A Jovial Exchange II"}, 
	"a_BarmansChildren":							{"en": "The Barman's Grandchildren and The Mystery Child"},
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
	"a_LostYoungCouple4": 							{"en": "Yesteryears Couple IV: Parting"},
	"a_LostYoungCouple5": 							{"en": "Yesteryears Couple V: Man-in-waiting"},
	"a_LostYoungCouple6": 							{"en": "Yesteryears Couple VI: Never Destined to Meet"},
	"a_EnigmaticCouple1": 							{"en": "Enigmatic Couple I: Prelude"},
	"a_EnigmaticCouple2": 							{"en": "Enigmatic Couple II: Tailing"}, 
	"a_EnigmaticCouple3": 							{"en": "Enigmatic Couple III: Wandering Once More"}, 
	"a_EnigmaticCouple4": 							{"en": "Enigmatic Couple IV: Origins"},	
	"a_EnigmaticCouple5": 							{"en": "Enigmatic Couple V: Epilogue"},
	"a_ErasingEike": 								{"en": "'That's a big no no'"}, 
	"a_ErasingEike2": 								{"en": "Bump... Erased"},
	"a_RottenRope": 								{"en": "Fated to Plunge"},
	"a_MetYouBefore": 								{"en": "Met You before"},
	"a_TimeTravellingCat":							{"en": "Nine Lives across Generations"},
	"a_SnowyCrimeScene":							{"en": "'Picked up a baby the other day'"},
	"a_SaveMiriamBrum":								{"en": "Illusive Guardian of the Brums"},
	"a_HugoMotherChild":							{"en": "A Mother's Child Forever"}, 
	"a_TimeEgoFlop":								{"en": "Time Ego Flop"},
	"a_ArtAppreciator": 							{"en": "Strokes of Destiny"}, 
	"a_AntiquesEule": 								{"en": "Timeless Antiques"},
	"a_ExcuseMeMyMy":								{"en": "'My my, so eager to die'"},
	"a_BecomeThePerformer":							{"en": "'Even I can do that'"}, 
	"a_EnergyOrbLocatorPresentDay": 				{"en": "Energy Amasser: Present Day"}, 
	"a_EnergyOrbLocatorMiddleAges": 				{"en": "Energy Amasser: Middle Ages"}, 
	"a_EnergyOrbLocator70s80s": 					{"en": "Energy Amasser: 70's - 80's"}, 
	"a_EnergyOrbLocator1900Days": 					{"en": "Energy Amasser: The Old Century"},
	"a_GiveMargaretteCake": 						{"en": "Time-Spun Sweets"}, 
	"a_ShortestChapter": 							{"en": "Pan in Advance"}, 
	"a_NewCakeInvented": 							{"en": "Legacy of Sweetness"},
	"a_MaxInventory": 								{"en": "Stockpiling Across Eras"},
	"a_PerformerGoingExtraMile": 					{"en": "A Performance Going the Extra Mile"}, 
	// "a_Template": 			{"en": "xxxxx"}, 
}
_achievementDescriptions = {
	"a_PrologueComplete": {							"en": "Complete the Prologue",
													"nl": "Proloog voltooid",
													"fr": "Prologue terminé"},
	"a_Chapter1Complete": {							"en": "Complete Chapter 1",
													"nl": "Hoofdstuk 1 voltooid",
													"fr": "Chapitre 1 terminé"},													
	"a_Chapter2Complete": 							{"en": "Complete Chapter 2"},
	"a_Chapter3Complete": 							{"en": "Complete Chapter 3"},
	"a_Chapter4CompletePan": 						{"en": "Complete Chapter 4, using a frying pan"},
	"a_Chapter4CompleteSign": 						{"en": "Complete Chapter 4, using a sign"},	
	"a_Chapter5Complete": 							{"en": "Complete Chapter 5"}, 
	"a_Chapter6CompleteThriller":					{"en": "Complete Chapter 6, by co-directing a thriller picture"},
	"a_Chapter6CompleteLove":						{"en": "Complete Chapter 6, by co-directing a love picture"},
	"a_Chapter7Complete":							{"en": "Complete Chapter 7"},
	"a_MeetOldMiriam":								{"en": "Meet Eckart's wife in Chapter 7"},
	"a_Chapter8Complete":							{"en": "Complete Chapter 8"},
	"a_EndingA":									{"en": "Achieve Ending A"},
	"a_EndingB1":									{"en": "Achieve Ending B1"},
	"a_EndingB2":									{"en": "Achieve Ending B2"},
	"a_EndingC": 									{"en": "Achieve Ending C"},
	"a_EndingD": 									{"en": "Achieve Ending D"},
	"a_EndingE": 									{"en": "Achieve Ending E"},
	"a_DoctorateTimeTraveling": 					{"en": "Take a picture in a costume during chapter 4 and finish the chapter"}, 
	"a_GetOrnamentalEgg": 							{"en": "Receive a gift from a performer during chapter 1"},
	"a_ShowEggTownPlanter": 						{"en": "Show off your egg collection to the barman's ancestor during chapter 2"},
	"a_EggPocketWatchForCoffee": 					{"en": "Show off your egg collection to the barman's ancestor from chapter 6 onward"},
	"a_BarmansChildren":							{"en": "Discover the truth about the barman's grandchildren during chapter 5"},
	"a_PocketWatchCollection": 						{"en": "Show off your egg collection to the barman during chapter 7"},
	"a_PocketWatchReminiscing": 					{"en": "Reminisce about your egg collection with Eckart during chapter 8"},
	"a_EggCollection1": 							{"en": "Give an ornamental egg to a barman during chapter 1"},
	"a_EggCollection2": 							{"en": "Give an ornamental egg to a barman during chapter 3 or 4"},
	"a_EikeThePyromancer": 							{"en": "Become honored as a pyrokinetic during chapter 2"},
	"a_EikeTheMagician": 							{"en": "Become honored as a magician during chapter 2"},
	"a_EikeTheFlorist": 							{"en": "Planted flowers during chapter 2"},
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
	"a_TimeTravellingCat":							{"en": "Gift a feline to a girl during or after chapter 4"},
	"a_HugoMotherChild":							{"en": "Find Hugo outside his house during chapter 5"}, 
	"a_ArtAppreciator": 							{"en": "Admire all the paintings in the Brum Museum"},
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
	"a_NewCakeInvented": 							{"en": "Establish a new type of pastry"},
	"a_ShortestChapter": 							{"en": "Acquire an iron plate before finding a good usage for it"}, 
	"a_MaxInventory": 								{"en": "Acquire the biggest hoard of items in a single playthrough"},
	"a_PerformerGoingExtraMile": 					{"en": "Make sure the performer goes the extra mile for those who would appreciate his gesture, including for yourself"}, 	
	// "a_Template": 			{"en": "xxxxx"},
}

// ACHIEVEMENT INITIALIZER
//	- Creates achievements based on achievement dictionary
// *************************************************************
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
	}
}


//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //  //  RICH PRESENCE  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\


//#########################################################################################################\\
//  //  //  //  //  //  //  //  //  //  //   INITIALIZATION CODE   \\  \\  \\  \\  \\  \\  \\  \\  \\  \\  \\ 
//#########################################################################################################\\
function initializeRAscript() {
	initializeAchievements()
}
initializeRAscript()