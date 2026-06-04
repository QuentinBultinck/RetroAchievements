// ******************************************** \\
//		 ▀█ █ █░░ █░░ █ █▀█ █▄░█	 █ █		\\
//		 █▄ █ █▄▄ █▄▄ █ █▄█ █░▀█	 █ █		\\
// ******************************************** \\
// #ID = 10716
// md5: 605b0c360075876b4a0be479679d1075 (World)
// RA Hash: 605b0c360075876b4a0be479679d1075 (World)
// Platform: Sega Master System
// Achievement Guide: [Link_to_guide] // TODO setup guide page here => https://github.com/RetroAchievements/guides/wiki
// RA Game Page: https://retroachievements.org/game/10716
// RATools version: v1.17.0

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

class CLASS_Utility {
    isDebugModeActive = true // if true => extra information may be displayed on achievement titles & descriptions
    language = "en"	// ISO 639-1 language codes

	iNULL = -1		// Two types are necessary because RAtools can't compare integers to strings
	sNULL = "-1"

	function throwError(string_errMsg) { // This function will throw an error in RATools because the key doesn't exist
		let_dict = {}
		return let_dict[format("ERROR: {0}", string_errMsg)]}

	function concatArrays(array_1, array_2) { // This function will concatenate two arrays (add values of array_2 to array_1)
		let_array_concat = array_1
		for let_index in range(0, length(array_2) - 1) {
			array_push(let_array_concat, array_2[let_index])
		}
		return let_array_concat}

	function addToDictionary(dict, key, value) {
		dict[key] = value}

	function getIndexOfLastItemInArray(array_a) =>
		length(array_a) - 1

	function getLastItemInArray(array_a) =>
		array_a[this.getIndexOfLastItemInArray(array_a)]

	function generateArrayOfIntegers_startAtZero(int_lastInteger) {
		let_array_Integers = []
		for let_index in range(0, int_lastInteger) 
			array_push(let_array_Integers, let_index)
		return let_array_Integers}
	}
util = CLASS_Utility()

class CLASS_ENUM_ReleaseRegions {
	World = "World" // Game only has one release version
} ReleaseRegion = CLASS_ENUM_ReleaseRegions()
RELEASE_REGIONS_SUPPORTED = [ReleaseRegion.World]

// #endregion GENERAL UTILITY

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

class CLASS_MemoryData {
	// #region MEM - Struct Definitions
	dict_regionOffsets = {}
	function getRegionOffset(string_structKey, string_offsetKey) =>
		this.dict_regionOffsets[string_structKey][string_offsetKey]
	// -------------------------------------
	dict_structDefinitions = {
		"Struct:Entity": {
			"offsetToMember": {
				"8-bit:Entity_ID": 0x0,
				"8-bit:Entity_xLocation": 0x3,
				"8-bit:Entity_yLocation": 0x5,
				"16-bit:Entity_Sprite": 0x6},
			},
	}
	function getStruct_SizeInBytes(string_structKey) =>
		this.dict_structDefinitions[string_structKey]["sizeInBytes"]

	function getStruct_OffsetToMember(string_structKey, string_memberKey) =>
		this.dict_structDefinitions[string_structKey]["offsetToMember"][string_memberKey]

	function getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

	function getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

	function getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
		
	function getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
		this.dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

	function generate_pointerChainAccessor(string_structKey, string_pointerChainKey, memAdrr_basePointer, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_array_pointerChainOffsets = this.getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey)
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
			if (let_index == length(let_array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

	function generate_pointerChainAccessor_byReleaseRegion(string_structKey, string_pointerChainKey, memAdrr_basePointer, enum_releaseRegion, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_array_pointerChainOffsets = this.getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion)
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(let_array_pointerChainOffsets) - 1) {
			if (let_index == length(let_array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + let_array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + let_array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with dereferencing pointer chain for structure: {0} - Pointer chain to: {1}", string_structKey, string_pointerChainKey))}

	function generate_pointerChainAccessor_fromOffsets(memAdrr_basePointer, array_pointerChainOffsets, int_offsetToPointedToMember = 0, memAccessorFunction_toPointedToMember = dword) {
		let_addAddressChain = dword(memAdrr_basePointer)
		for let_index in range(0, length(array_pointerChainOffsets) - 1) {
			if (let_index == length(array_pointerChainOffsets) - 1)
				return memAccessorFunction_toPointedToMember(let_addAddressChain + array_pointerChainOffsets[let_index] + int_offsetToPointedToMember)
			else let_addAddressChain = dword(let_addAddressChain + array_pointerChainOffsets[let_index])
		}	
		util.throwError(format("Something went wrong with creating pointer chain for memAddr: {0}", memAdrr_basePointer))}
	// #endregion MEM - Struct Definitions
	// #region MEM - Address Storage
	dict_addresses = {
		// "memAddrKey": {ReleaseRegion.World: util.sNULL},
		"BitFlag:IsArmoratorActive(non-functional)": {ReleaseRegion.World: 0x001d},
		"BitFlag:IsArmoraterPowerUpAcquired": {ReleaseRegion.World: 0x00bd},
		"BitFlag:IsPistolFullyCharged": {ReleaseRegion.World: 0x0077},
		"BitFlag:IsAppleAvailable": {ReleaseRegion.World: 0x009d},
		"BitFlag:IsChampAvailable": {ReleaseRegion.World: 0x009e},

		"8-bit:OutroSequence_Section_ID": {ReleaseRegion.World: 0x0133},
		"8-bit:ContinueUseCount": {ReleaseRegion.World: 0x0002},
		"8-bit:GameState": {ReleaseRegion.World: 0x0010},
		"8-bit:Stage_ID(functional)": {ReleaseRegion.World: 0x0015},
		"8-bit:Player_Life": {ReleaseRegion.World: 0x0018},
		"8-bit:Boss_HP": {ReleaseRegion.World: 0x001a},
		"8-bit:LaserUpgrades": {ReleaseRegion.World: 0x001e},
		"8-bit:Player_Lives": {ReleaseRegion.World: 0x001f},
		"8-bit:PlayerCharacter_ID": {ReleaseRegion.World: 0x0095},
		"8-bit:Stage_Section_ID": {ReleaseRegion.World: 0x0028},
		
		"24-bit BCD:HighScore": {ReleaseRegion.World: 0x000d},
		"24-bit BCD:Score": {ReleaseRegion.World: 0x0012},

		"Struct(Entity):Player": {ReleaseRegion.World: 0x0300},
		"Struct(Entity):Entity_1": {ReleaseRegion.World: 0x03a0},

		"Array:PlayerProjecileEntities": {ReleaseRegion.World: 0x0320},
		"Array:RemainingEntities": {ReleaseRegion.World: 0x03a0},
		}

	function getAddress(string_addrKey, enum_releaseRegion) {
		let_memAddr = this.dict_addresses[string_addrKey][enum_releaseRegion]
		if(let_memAddr == util.sNULL) util.throwError(format("Memory address for '{0}' - Region '{1}' is NULL", string_addrKey, enum_releaseRegion))
		return let_memAddr}	

	// #endregion MEM - Address Storage
} memory = CLASS_MemoryData()

class CLASS_MemoryUtility {
	// #region MemUtil - Custom ASCII comparitors
	// NOTE: Custom ASCII comparitors are necessary to use with pointers, built-in RAtools ascii_string_equals() generates weird logic, when using pointers as the memAddrr
	function ASCII_Equals(memAddr_ASCII, string_s, wrapper = c => c) {
		let_array_comparisons = []
		for let_stepBy4Index in range(0, length(string_s) - 1, step = 4) {
			let_substring = substring(string_s, let_stepBy4Index, 4)
			array_push(let_array_comparisons, ascii_string_equals(memAddr_ASCII + let_stepBy4Index, let_substring, transform = wrapper))
		}
		return all_of(let_array_comparisons, c => c)}

	function ASCII_NotEquals(memAddr_ASCII, string_s, wrapper = c => c) {
		/* NOTE: Consider following ASCII "ABCDEF" --> if ASCII = "ABCDFF" it is not equal to the ASCII		
			Example logic:
				0xA != "ABCD"
				|| 0xB != "EF"
		*/
		return __ornext( // --> __ornext() as otherwise RATools may generate unnecessary alt groups for these single orNext requirements
			!ASCII_Equals(memAddr_ASCII, string_s, wrapper)
		)}

	function is_ASCII_EqualTo(memAddr_ASCII, string_s) =>
		ASCII_Equals(memAddr_ASCII, string_s)

	function is_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
		ASCII_NotEquals(memAddr_ASCII, string_s)

	function wasPrev_ASCII_EqualTo(memAddr_ASCII, string_s) =>
		ASCII_Equals(memAddr_ASCII, string_s, c => prev(c))

	function wasPrev_ASCII_notEqualTo(memAddr_ASCII, string_s) =>
		ASCII_NotEquals(memAddr_ASCII, string_s, c => prev(c))

	dict_asciiToHex = {
		"A": 0x41,  "B": 0x42,  "C": 0x43,  "D": 0x44,  "E": 0x45,  "F": 0x46,  "G": 0x47, 
		"H": 0x48,  "I": 0x49,  "J": 0x4A,  "K": 0x4B,  "L": 0x4C,  "M": 0x4D,  "N": 0x4E, 
		"O": 0x4F,  "P": 0x50,  "Q": 0x51,  "R": 0x52,  "S": 0x53,  "T": 0x54,  "U": 0x55, 
		"V": 0x56,  "W": 0x57,  "X": 0x58,  "Y": 0x59,  "Z": 0x5A,  "a": 0x61,  "b": 0x62, 
		"c": 0x63,  "d": 0x64,  "e": 0x65,  "f": 0x66,  "g": 0x67,  "h": 0x68,  "i": 0x69, 
		"j": 0x6A,  "k": 0x6B,  "l": 0x6C,  "m": 0x6D,  "n": 0x6E,  "o": 0x6F,  "p": 0x70, 
		"q": 0x71,  "r": 0x72,  "s": 0x73,  "t": 0x74,  "u": 0x75,  "v": 0x76,  "w": 0x77, 
		"x": 0x78,  "y": 0x79,  "z": 0x7A,  "0": 0x30,  "1": 0x31,  "2": 0x32,  "3": 0x33, 
		"4": 0x34,  "5": 0x35,  "6": 0x36,  "7": 0x37,  "8": 0x38,  "9": 0x39,  " ": 0x20, 
		"!": 0x21,  "#": 0x23,  "$": 0x24,  "%": 0x25,  "&": 0x26,  "\"": 0x27, 
		"(": 0x28,  ")": 0x29,  "*": 0x2A,  "+": 0x2B,  ",": 0x2C,  "-": 0x2D,  ".": 0x2E, 
		"/": 0x2F,  ":": 0x3A,  ";": 0x3B,  "<": 0x3C,  "=": 0x3D,  ">": 0x3E,  "?": 0x3F, 
		"@": 0x40,  "[": 0x5B,  "\\": 0x5C,  "]": 0x5D,  "^": 0x5E,  "_": 0x5F,  "`": 0x60, 
		"{": 0x7B,  "|": 0x7C,  "}": 0x7D,  "~": 0x7E}
	
	dict_asciiToFloat = {
		"A": 65.0, "B": 66.0, "C": 67.0, "D": 68.0, "E": 69.0, "F": 70.0, "G": 71.0,
		"H": 72.0, "I": 73.0, "J": 74.0, "K": 75.0, "L": 76.0, "M": 77.0, "N": 78.0,
		"O": 79.0, "P": 80.0, "Q": 81.0, "R": 82.0, "S": 83.0, "T": 84.0, "U": 85.0,
		"V": 86.0, "W": 87.0, "X": 88.0, "Y": 89.0, "Z": 90.0, "a": 97.0, "b": 98.0,
		"c": 99.0, "d": 100.0, "e": 101.0, "f": 102.0, "g": 103.0, "h": 104.0, "i": 105.0,
		"j": 106.0, "k": 107.0, "l": 108.0, "m": 109.0, "n": 110.0, "o": 111.0, "p": 112.0,
		"q": 113.0, "r": 114.0, "s": 115.0, "t": 116.0, "u": 117.0, "v": 118.0, "w": 119.0,
		"x": 120.0, "y": 121.0, "z": 122.0, "0": 48.0, "1": 49.0, "2": 50.0, "3": 51.0,
		"4": 52.0, "5": 53.0, "6": 54.0, "7": 55.0, "8": 56.0, "9": 57.0, " ": 32.0,
		"!": 33.0, "#": 35.0, "$": 36.0, "%": 37.0, "&": 38.0, "\"": 39.0,
		"(": 40.0, ")": 41.0, "*": 42.0, "+": 43.0, ",": 44.0, "-": 45.0, ".": 46.0,
		"/": 47.0, ":": 58.0, ";": 59.0, "<": 60.0, "=": 61.0, ">": 62.0, "?": 63.0,
		"@": 64.0, "[": 91.0, "\\": 92.0, "]": 93.0, "^": 94.0, "_": 95.0, "`": 96.0,
		"{": 123.0, "|": 124.0, "}": 125.0, "~": 126.0}

	function asciiStringToHexLE(string_s, int_numberOfZeroedOutBytesToCheckBeforeString = 0) { // NOTE: Returns a Little Endian hex; int_numberOfZeroedOutBytesToCheckBeforeString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
		/* NOTE Example usages
			- asciiStringToHexLE("Wron") --> Returns 0x6E 6F 72 57 ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Little Endian Hex
				dword(asciiStringToHexLE("Wr", 2)) == dword(0x6E6F7257) --LittleEndianView--> [6E 6F 72 57] "Wron"
			- asciiStringToHexLE("Wr", 2) --> Returns 0x72 57 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Little Endian Hex + with 2 zeroed out bytes appended
				dword(asciiStringToHexLE("Wr", 2)) == dword(0x72570000) --LittleEndianView--> [00 00 57 72] "  Wr"
			*/

		let_stringLength = length(string_s)

		if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckBeforeString >= 4)
			util.throwError("One of the parameters given to CLASS_MemoryUtility.asciiStringToHexLE() is out of range OR invalid")
		if (let_stringLength + int_numberOfZeroedOutBytesToCheckBeforeString > 4)
			util.throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckBeforeString))

		let_hexValue = 0

		if (int_numberOfZeroedOutBytesToCheckBeforeString == 1) let_hexValue = let_hexValue * 0x100
		else if (int_numberOfZeroedOutBytesToCheckBeforeString == 2) let_hexValue = let_hexValue * 0x10000
		else if (int_numberOfZeroedOutBytesToCheckBeforeString == 3) let_hexValue = let_hexValue * 0x1000000

		for let_characterIndex in range(0, let_stringLength - 1) {
			let_characterAsHex = this.dict_asciiToHex[substring(string_s, let_characterIndex, 1)]
			if (let_characterIndex == 0) let_hexValue = let_characterAsHex
			else if (let_characterIndex == 1) let_hexValue = let_hexValue + (let_characterAsHex * 0x100)
			else if (let_characterIndex == 2) let_hexValue = let_hexValue + (let_characterAsHex * 0x10000)
			else let_hexValue = let_hexValue + (let_characterAsHex * 0x1000000)}

		return let_hexValue}

	function asciiStringToHexBE(string_s, int_numberOfZeroedOutBytesToCheckAfterString = 0) { // NOTE: Returns a Big Endian hex; int_numberOfZeroedOutBytesToCheckAfterString allows for checking zeroud out bytes after the ASCII bytes witin a 32-bit size
		/* NOTE Example usages
			- asciiStringToHexBE("Wron") --> Returns 0x57 72 6F 6E  ("W": 0x57 - "r": 0x72 - "o": 0x6F - "n": 0x6E)  | String as Big Endian Hex
				dword_be(asciiStringToHexBE("Wr", 2)) == dword_be(0x57726F6E) --BigEndianView--> [57 72 6F 6E] "Wron"
			- asciiStringToHexBE("Wr", 2) --> Returns 0x57 72 00 00 ("W": 0x57 - "r": 0x72 - 2x zeroedBytes: 0x0000) | String as Big Endian Hex + with 2 zeroed out bytes appended
				dword_be(asciiStringToHexBE("Wr", 2)) == dword_be(0x57720000) --BigEndianView--> [57 72 00 00] "Wr  "
			*/

		let_stringLength = length(string_s)

		if (let_stringLength == 0 || int_numberOfZeroedOutBytesToCheckAfterString >= 4)
			util.throwError("One of the parameters given to CLASS_MemoryUtility.asciiStringToHexBE() is out of range OR invalid")
		if (let_stringLength + int_numberOfZeroedOutBytesToCheckAfterString > 4)
			util.throwError(format("String length of {0} + {1} zeroed out bytes, is too large to handle", let_stringLength, int_numberOfZeroedOutBytesToCheckAfterString))

		let_hexValue = 0
		for let_characterIndex in range(0, let_stringLength - 1) {
			let_characterAsHex = this.dict_asciiToHex[substring(string_s, let_characterIndex, 1)]
			if (let_characterIndex == 0) let_hexValue = let_characterAsHex
			else if (let_characterIndex == 1) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
			else if (let_characterIndex == 2) let_hexValue = (let_hexValue * 0x100) + let_characterAsHex
			else let_hexValue = (let_hexValue * 0x100) + let_characterAsHex}

		if (int_numberOfZeroedOutBytesToCheckAfterString == 1) let_hexValue = let_hexValue * 0x100
		else if (int_numberOfZeroedOutBytesToCheckAfterString == 2) let_hexValue = let_hexValue * 0x10000
		else if (int_numberOfZeroedOutBytesToCheckAfterString == 3) let_hexValue = let_hexValue * 0x1000000

		return let_hexValue}

	// #endregion MemUtil - Custom ASCII comparitors
	// #region MemUtil - Main
	// floatToInt: will return an integer from the floored float value => refer to https://docs.retroachievements.org/AddSource-Flag/#interaction-with-floats
		// 	- RAtools will clean => 	0 + float(0xaa) + 0	 --to-->	float(0xa)
		// 	- Workaround is the following => 	byte(memAddr_WhereValueNeverChanges) + float(0xa) + byte(memAddr_WhereValueNeverChanges)
	// function floatToInt(float_value, enum_releaseRegion) {
		// let_memAccessor_alwaysNull = high4(memory.getAddress("8-bit:AlwaysNULL_Or_ValueNeverChanges", enum_releaseRegion))
		// return let_memAccessor_alwaysNull + float_value + let_memAccessor_alwaysNull}

	// function alwaysFalse(enum_releaseRegion) => // Force always_false() as sometime RATools removes it when it is necessary
		// dword(memory.getAddress("8-bit:AlwaysNULL_Or_ValueNeverChanges", enum_releaseRegion)) == 0xDEADBEEF
		
	function ManualConstruction_PlaceHolderRequirement(int_placeHolderIndex) { // int_placeHolderIndex allowedRange [0x1-0xFFF] // This function can be used to quickyly generate a placeHolder Requirement for easily overwriting/copyPasting MANUAL CONSTRUCTION code
		let_dummyAddress = (int_placeHolderIndex * 0x10000) + 0xBEEF
		return dword(let_dummyAddress) == 0xBAADF00D}
	
	function bitIndexToBitMemoryAccessor(int_bitIndex) {
		dict_bitIndexToBitMemoryAccessor = {
			0: bit0,
			1: bit1,
			2: bit2,
			3: bit3,
			4: bit4,
			5: bit5,
			6: bit6,
			7: bit7}
		return dict_bitIndexToBitMemoryAccessor[int_bitIndex]
		}
	
	// #endregion MemUtil - Main
} memUtil = CLASS_MemoryUtility()

// class CLASS_MEMLOGIC_ReleaseRegion { // DISABLED: only support for 1 version
	// function is(enum_releaseRegion) {	
	// 	let_string_GameID = util.sNULL
	// 	if(enum_releaseRegion == ReleaseRegion.USA) let_string_GameID = util.sNULL // FullString: "xxxxx"
	// 	else if(enum_releaseRegion == ReleaseRegion.JPN) let_string_GameID = util.sNULL // FullString: "xxxxx"
	// 	else if(enum_releaseRegion == ReleaseRegion.EUR) let_string_GameID = util.sNULL // FullString: "xxxxx"
		
	// 	if (let_string_GameID == util.sNULL) util.throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
	// 	return memUtil.is_ASCII_EqualTo(memory.getAddress("ASCII:GameID", enum_releaseRegion), let_string_GameID)
	// 	}
	// } releaseRegion = CLASS_MEMLOGIC_ReleaseRegion()

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



// ............................
// ◦ Game State & Information ◦
// ''''''''''''''''''''''''''''
// #region Game State & Information
class CLASS_MEMLOGIC_GameState {
	// --------Variables/Enums--------
	MainMenu = 0x1
	Demo = 0x2
	PlayerDeath = 0x3
	PreStageScreen = 0x4 
	OutroSequence = 0x5
	TheEnd = 0x6
	InGame = 0x7
	BossFight = 0x8
	// --------Functions--------
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:GameState", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	
	function is(enum_gameState, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_gameState
	function on_changeFromTo(enum_gameStatePrev, enum_gameStateCurrent, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == enum_gameStatePrev
		&& this.current(enum_releaseRegion) == enum_gameStateCurrent
} gameState = CLASS_MEMLOGIC_GameState()

class CLASS_MEMLOGIC_OutroSequenceState {
	// --------Variables/Enums--------
	One = 0
	Two = 1
	Three = 2
	Four = 3

	// --------Functions--------
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:OutroSequence_Section_ID", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	
	function is(enum_outroSequenceSection, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_outroSequenceSection
	function on_changeFromTo(enum_outroSequenceSectionPrev, enum_outroSequenceSectionCurrent, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == enum_outroSequenceSectionPrev
		&& this.current(enum_releaseRegion) == enum_outroSequenceSectionCurrent
} OutroSequenceSection = CLASS_MEMLOGIC_OutroSequenceState()
// #endregion Game State & Information

// ........................
// ◦ Stage Identification ◦
// ''''''''''''''''''''''''
// #region Stage Identification
class CLASS_MEMLOGIC_StageData {
	// --------Variables/Enums--------
	One = 1
	Two = 2
	Three = 3
	Four = 4
	Five = 5
	Six = 6
	Seven = 7
	Eight = 8

	dict_StageData = {
		One: {
			"StageType": "OnRails",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x45, // --> Section where player enters door into next Stage
			"PlayerLocation_Start": [24, 120], // --> [x,y] coords where player entity is, when Stage ends
			"PlayerLocation_End": [208, 120],
			},
		Two: {
			"StageType": "OnFoot",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x0,
			"PlayerLocation_Start": [128, 136],
			// "PlayerLocation_End": [xxx, xxx], // --> OnFoot this isn't applicable
			},
		Three: {
			"StageType": "OnRails",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x45,
			"PlayerLocation_Start": [24, 120],
			"PlayerLocation_End": [208, 120],
			},
		Four: {
			"StageType": "OnFoot",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x0,
			"PlayerLocation_Start": [128, 136],
			// "PlayerLocation_End": [xxx, xxx], // --> OnFoot this isn't applicable
			},
		Five: {
			"StageType": "OnRails",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x4F,
			"PlayerLocation_Start": [24, 120],
			"PlayerLocation_End": [208, 120],
			},
		Six: {
			"StageType": "OnFoot",
			"StageSection_Start": 0x7,
			"StageSection_End": 0x0,
			"PlayerLocation_Start": [200, 136],
			// "PlayerLocation_End": [xxx, xxx], // --> OnFoot this isn't applicable
			},
		Seven: {
			"StageType": "OnRails",
			"StageSection_Start": 0x0,
			"StageSection_End": 0x59,
			"PlayerLocation_Start": [24, 120],
			"PlayerLocation_End": [208, 120],
			},
		Eight: {
			"StageType": "OnFoot",
			"StageSection_Start": 0x7,
			"StageSection_End": 0x0,
			"PlayerLocation_Start": [200, 136],
			// "PlayerLocation_End": [xxx, xxx], // --> OnFoot this isn't applicable
			},
	}
	function get_StageType(enum_stageID) => this.dict_StageData[enum_stageID]["StageType"]
	function get_StageSection_Start(enum_stageID) => this.dict_StageData[enum_stageID]["StageSection_Start"]
	function get_StageSection_End(enum_stageID) => this.dict_StageData[enum_stageID]["StageSection_End"]
	function get_PlayerLocation_Start(enum_stageID) => this.dict_StageData[enum_stageID]["PlayerLocation_Start"]
	function get_PlayerLocation_End(enum_stageID) => this.dict_StageData[enum_stageID]["PlayerLocation_End"]
	function is_StageType_OnRails(enum_stageID) => this.dict_StageData[enum_stageID]["StageType"] == "OnRails"

	// --------Functions--------
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:Stage_ID(functional)", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	
	function is(enum_stageID, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_stageID
	function on_changeFromTo(enum_stageIDPrev, enum_stageIDCurrent, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == enum_stageIDPrev
		&& this.current(enum_releaseRegion) == enum_stageIDCurrent

	function on_change(enum_releaseRegion) =>
		this.prev(enum_releaseRegion) != this.current(enum_releaseRegion)
} stage = CLASS_MEMLOGIC_StageData()
class CLASS_MEMLOGIC_StageLocationData {
	// --------Variables/Enums--------
	// --------Functions--------
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:Stage_Section_ID", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	function on_changeFromTo(int_sectionPrev, int_sectionCurrent, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == int_sectionPrev
		&& this.current(enum_releaseRegion) == int_sectionCurrent
	function on_Stage_end(enum_stageCurrent, enum_releaseRegion) {
		let_sectionStart_nextStage = stage.get_StageSection_Start(enum_stageCurrent +1)
		let_sectionEnd_previousStage = stage.get_StageSection_End(enum_stageCurrent)
		return this.on_changeFromTo(let_sectionEnd_previousStage, let_sectionStart_nextStage, enum_releaseRegion)}
} stageSection = CLASS_MEMLOGIC_StageLocationData()
// #endregion Stage Identification

// ......................
// ◦ Player Information ◦
// ''''''''''''''''''''''
// #region Player Information
class CLASS_MEMLOGIC_PlayerLogic {
	// --------Variables/Enums--------
	// --------Functions--------
	function current_xLocation(enum_releaseRegion) {
		let_memAddr_PlayerEntityStruct = memory.getAddress("Struct(Entity):Player", enum_releaseRegion)
		let_offsetToMember_xLocation = memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_xLocation")
		return byte(let_memAddr_PlayerEntityStruct + let_offsetToMember_xLocation)}
	function current_yLocation(enum_releaseRegion) {
		let_memAddr_PlayerEntityStruct = memory.getAddress("Struct(Entity):Player", enum_releaseRegion)
		let_offsetToMember_yLocation = memory.getStruct_OffsetToMember("Struct:Entity", "8-bit:Entity_yLocation")
		return byte(let_memAddr_PlayerEntityStruct + let_offsetToMember_yLocation)}	
	function prev_xLocation(enum_releaseRegion) =>
		prev(this.current_xLocation(enum_releaseRegion))
	function prev_yLocation(enum_releaseRegion) =>
		prev(this.current_yLocation(enum_releaseRegion))

	function is_atStageStartCoords(enum_stageID, enum_releaseRegion) {
		let_coords_stageStartLocation = stage.get_PlayerLocation_Start(enum_stageID)
		return
			this.current_xLocation(enum_releaseRegion) == let_coords_stageStartLocation[0]
			&& this.current_yLocation(enum_releaseRegion) == let_coords_stageStartLocation[1]
		}
	function is_atOnRailsStageEndCoords(enum_stageID, enum_releaseRegion) {
		if(!stage.is_StageType_OnRails(enum_stageID)) util.throwError(format("Stage {0} is not an on-rails stage"))
		let_coords_stageEndLocation = stage.get_PlayerLocation_End(enum_stageID)
		return
			this.current_xLocation(enum_releaseRegion) == let_coords_stageEndLocation[0]
			&& this.current_yLocation(enum_releaseRegion) == let_coords_stageEndLocation[1]
		}
	function on_spawn_atStageStartCoords(enum_stageID, enum_releaseRegion) {
		let_coords_stageStartLocation = stage.get_PlayerLocation_Start(enum_stageID)
		return
			this.prev_xLocation(enum_releaseRegion) == 0
			&& this.current_xLocation(enum_releaseRegion) == let_coords_stageStartLocation[0]
			&& this.prev_yLocation(enum_releaseRegion) == 0
			&& this.current_yLocation(enum_releaseRegion) == let_coords_stageStartLocation[1]
		}
} player = CLASS_MEMLOGIC_PlayerLogic()
// #endregion Player Information

// ............
// ◦ Entities ◦
// ''''''''''''
// #region Entities
class CLASS_MEMLOGIC_EntityData {
	// --------Variables/Enums--------
	// --------Functions-------- 
} entity = CLASS_MEMLOGIC_EntityData()
class CLASS_MEMLOGIC_BossData {
	// --------Variables/Enums--------
	Boss_1 = 100
	Boss_2 = 101
	Boss_3 = 102
	Boss_Final = 103

	dict_BossData = {
		Boss_1: {
			"Entity_ID_BeforeSpawn": 0x0,
			"Entity_ID_OnSpawn": 0x11,
			"MaxHP": 0x27},
		Boss_2: {
			"Entity_ID_BeforeSpawn": 0x18,
			"Entity_ID_OnSpawn": 0x8,
			"Entity_ID_OnDeath": 0x1A,
			"MaxHP": 0x2F},
		Boss_3: {
			"Entity_ID_BeforeSpawn": 0x0,
			"Entity_ID_OnSpawn": 0x2C,
			"MaxHP": 0x37},
		Boss_Final: {
			"Entity_ID_BeforeSpawn": 0x0,
			"Entity_ID_OnSpawn": 0x25,
			"MaxHP": 0x3F},
	}
	function get_Entity_ID_OnSpawn(enum_boss) => this.dict_BossData[enum_boss]["Entity_ID_OnSpawn"]
	function get_Entity_ID_BeforeSpawn(enum_boss) => this.dict_BossData[enum_boss]["Entity_ID_BeforeSpawn"]
	function get_MaxHP(enum_boss) => this.dict_BossData[enum_boss]["MaxHP"]

	// --------Functions--------
	function current_HP(enum_releaseRegion) =>
		byte(memory.getAddress("8-bit:Boss_HP", enum_releaseRegion))
	function prev_HP(enum_releaseRegion) =>
		prev(this.current_HP(enum_releaseRegion))
	function current_ID(enum_releaseRegion) =>
		byte(memory.getAddress("Struct(Entity):Entity_1", enum_releaseRegion))
	function prev_ID(enum_releaseRegion) =>
		prev(this.current_ID(enum_releaseRegion)) 

	function is_atMaxHP(enum_boss, enum_releaseRegion) =>
		this.current_HP(enum_releaseRegion) == this.get_MaxHP(enum_boss)
	
	function on_spawn(enum_boss, enum_releaseRegion) =>
		this.prev_ID(enum_releaseRegion) == this.get_Entity_ID_BeforeSpawn(enum_boss)
		&& this.current_ID(enum_releaseRegion) == this.get_Entity_ID_OnSpawn(enum_boss)
	function on_death(enum_boss, enum_releaseRegion) =>
		this.prev_HP(enum_releaseRegion) > 0
		&& this.current_HP(enum_releaseRegion) == 0
} BossEntity = CLASS_MEMLOGIC_BossData()
// #endregion Entities

// ................
// ◦ Sub_Header_2 ◦
// ''''''''''''''''
// #region Sub_Header_2
class CLASS_MEMLOGIC_xxxx {
	// --------Variables/Enums--------
	// --------Functions--------
	function current(enum_releaseRegion) =>
		byte(memory.getAddress("xxxxxxxxxx", enum_releaseRegion))
	function prev(enum_releaseRegion) =>
		prev(this.current(enum_releaseRegion))
	
	function is(enum_xxxxxx, enum_releaseRegion) =>
		this.current(enum_releaseRegion) == enum_xxxxxx
	function on_changeFromTo(enum_xxxxxPrev, enum_xxxxCurrent, enum_releaseRegion) =>
		this.prev(enum_releaseRegion) == enum_xxxxxPrev
		&& this.current(enum_releaseRegion) == enum_xxxxCurrent
} xxxxxx = CLASS_MEMLOGIC_xxxx()
// #endregion Sub_Header_2

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
// • ACHIEVEMENT sub logic •
// =========================
// #region ACH - sub logic
//	- For achievement logic that's reoccuring across multiple triggers
class CLASS_AchievementSubLogic {
	function CoreGroup_OnRailsStageCompletion(enum_stageTocomplete, enum_releaseRegion) {
		let_StartCondition_A = always_true()
		let_nextStage = enum_stageTocomplete +1
			
		if(enum_stageTocomplete == stage.One) let_StartCondition_A = 
			once( // --CheckIf--[StartCondition_A]--> Game starts from MainMenu
				gameState.on_changeFromTo(gameState.MainMenu, gameState.PreStageScreen, enum_releaseRegion))
		else let_StartCondition_A = 
			once( // --CheckIf--[StartCondition_A]--> Stage starts from previous stage
				gameState.on_changeFromTo(gameState.BossFight, gameState.PreStageScreen, enum_releaseRegion)
				&& stage.on_changeFromTo(enum_stageTocomplete -1, enum_stageTocomplete, enum_releaseRegion))

		return
			never( // --ResetIf--> When back at MainMenu
				gameState.is(gameState.MainMenu, enum_releaseRegion))
			&& never(repeated(2, // --ResetIf--> When not in correct stage for xx frames (this to allow last delta checks to be able to trigger)
				never(stage.on_change(enum_releaseRegion)) // --ResetNextIf--> When stage changes
				&& !stage.is(enum_stageTocomplete, enum_releaseRegion)))

			&& let_StartCondition_A
			&& once( // --CheckIf--[StartCondition_B]--> Stage starts
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.on_changeFromTo(gameState.PreStageScreen, gameState.InGame, enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition_C]--> Stage starts
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.is(gameState.InGame, enum_releaseRegion)
				&& player.on_spawn_atStageStartCoords(enum_stageTocomplete, enum_releaseRegion))

			// --CheckIf--> Stage continues to next stage
			&& player.is_atOnRailsStageEndCoords(enum_stageTocomplete, enum_releaseRegion)
			&& gameState.on_changeFromTo(gameState.InGame, gameState.PreStageScreen, enum_releaseRegion)
			&& stage.on_changeFromTo(enum_stageTocomplete, let_nextStage, enum_releaseRegion)
			&& stageSection.on_Stage_end(enum_stageTocomplete, enum_releaseRegion)
		}

	function CoreGroup_OnFootStageCompletion(enum_stageTocomplete, enum_bossToDefeat, enum_releaseRegion) {
		let_LastRequirements = always_true()			
		if(enum_stageTocomplete == stage.Eight) let_LastRequirements =
			once( // --CheckIf--> Game starts OutroSequence
				gameState.on_changeFromTo(gameState.BossFight, gameState.OutroSequence, enum_releaseRegion))
			&& once( // --CheckIf--> OutroSequence progresses
				gameState.is(gameState.OutroSequence, enum_releaseRegion)
				&& OutroSequenceSection.on_changeFromTo(OutroSequenceSection.One, OutroSequenceSection.Two, enum_releaseRegion))
			// --CheckIf--> OutroSequence progresses
			&& gameState.is(gameState.OutroSequence, enum_releaseRegion)
			&& OutroSequenceSection.on_changeFromTo(OutroSequenceSection.Three, OutroSequenceSection.Four, enum_releaseRegion)
		else let_LastRequirements = 
			// --CheckIf--> Stage continues to next stage
			gameState.on_changeFromTo(gameState.BossFight, gameState.PreStageScreen, enum_releaseRegion)
			&& stage.on_changeFromTo(enum_stageTocomplete, enum_stageTocomplete +1, enum_releaseRegion)
			&& stageSection.on_Stage_end(enum_stageTocomplete, enum_releaseRegion)

		return
			never( // --ResetIf--> When back at MainMenu
				gameState.is(gameState.MainMenu, enum_releaseRegion))
			&& never(repeated(2, // --ResetIf--> When not in correct stage for xx frames (this to allow last delta checks to be able to trigger)
				never(stage.on_change(enum_releaseRegion)) // --ResetNextIf--> When stage changes
				&& !stage.is(enum_stageTocomplete, enum_releaseRegion)))

			&& once( // --CheckIf--[StartCondition_A]--> Stage starts from previous stage
				gameState.on_changeFromTo(gameState.InGame, gameState.PreStageScreen, enum_releaseRegion)
				&& stage.on_changeFromTo(enum_stageTocomplete -1, enum_stageTocomplete, enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition_B]--> Stage starts
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.on_changeFromTo(gameState.PreStageScreen, gameState.InGame, enum_releaseRegion))
			&& once( // --CheckIf--[StartCondition_C]--> Stage starts
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.is(gameState.InGame, enum_releaseRegion)
				&& player.on_spawn_atStageStartCoords(enum_stageTocomplete, enum_releaseRegion))

			&& once( // --CheckIf--> Entering Boss Arena
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.on_changeFromTo(gameState.InGame, gameState.BossFight, enum_releaseRegion))
			&& once( // --CheckIf--> Boss at max HP // --> seperate from below CheckIf, because some bosses initialize in differing delta frames
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.is(gameState.BossFight, enum_releaseRegion)
				&& BossEntity.is_atMaxHP(enum_bossToDefeat, enum_releaseRegion))
			&& once( // --CheckIf--> Boss spawns
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.is(gameState.BossFight, enum_releaseRegion)
				&& BossEntity.on_spawn(enum_bossToDefeat, enum_releaseRegion))
			&& once( // --CheckIf--> Boss dies
				stage.is(enum_stageTocomplete, enum_releaseRegion)
				&& gameState.is(gameState.BossFight, enum_releaseRegion)
				&& BossEntity.on_death(enum_bossToDefeat, enum_releaseRegion))

			&& let_LastRequirements
		}
} achievementSubLogic = CLASS_AchievementSubLogic()
// #endregion ACH - sub logic

// ====================
// • ACHIEVEMENT logic •
// ====================
// - Divided by category => when in debug mode, category tags are added to achievement titles
class CLASS_ENUM_AchievementPointClasses {
	Free_0 			= 0		// Free - Freebie/informational achievement
	Minor_1			= 1 	// Minor - Finding a hidden item, do some arbitrary/easter egg task
	Basic_2			= 2 	// Basic - Defeating a few enemies
	Easy_3			= 3 	// Easy - Completing an easy quest or level
	Intermediate_4	= 4 	// Intermediate - Completing a harder quest or level
	Advanced_5		= 5 	// Advanced - Collecting rare items or completing a level
	Challenging_10	= 10	// Challenging - Defeating a major boss or collecting a VERY rare one-of-a-kind item
	Hard_25			= 25 	// Hard - Completing the game 
	VeryHard_50		= 50 	// VeryHard - Achieving 100% completion
	Impossible_100	= 100 	// Impossible - Completing the game without taking a hit (extreme challenge achievements, typical for bonus sets)
} AchievementPointClass = CLASS_ENUM_AchievementPointClasses()

class CLASS_ENUM_AchievementTypes {
	Progression = "progression"
	WinCondition = "win_condition"
	Missable = "missable"
	Standard = ""
} AchievementType = CLASS_ENUM_AchievementTypes()

class CLASS_AchievementLogic {
// #region ACH - Core Data
dict_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
		// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_Progress": { // Progress - Completion of each Stage
		// "a_Stage1": { // VERIFIED
			// "id": 614053, "points": AchievementPointClass.Easy_3, "devInfo": "Complete Stage 1"},
		// "a_Stage2": { // VERIFIED
			// "id": 614058, "points": AchievementPointClass.Easy_3, "devInfo": "Complete Stage 2"},
		// "a_Stage3": { // VERIFIED
			// "id": 614055, "points": AchievementPointClass.Intermediate_4, "devInfo": "Complete Stage 3"},
		// "a_Stage4": { // VERIFIED
			// "id": 614059, "points": AchievementPointClass.Intermediate_4, "devInfo": "Complete Stage 4"},
		// "a_Stage5": { // VERIFIED
			// "id": 614056, "points": AchievementPointClass.Advanced_5, "devInfo": "Complete Stage 5"},
		// "a_Stage6": { // VERIFIED
			// "id": 614060, "points": AchievementPointClass.Advanced_5, "devInfo": "Complete Stage 6"},
		// "a_Stage7": { // VERIFIED
			// "id": 614057, "points": AchievementPointClass.Challenging_10, "devInfo": "Complete Stage 7"},
		},
	"c_WinCondition": { // Win Condition - Game Completed
		// "a_Stage8": { // VERIFIED
			// "id": 614061, "points": AchievementPointClass.Hard_25, "devInfo": "Complete Stage 8 + Finish Outro"}
		},
	"c_Bonus": { // Bonus - Miscellaneous achievements
		// CONCEPT c_Bonus
			// - Transform into the Armorator || kill xx enemies as Armorater
			// - Acquire max charged pistol || kill xx enemies with fully charged pistol ("Zillion" is name of gun)
			// - Pick up all Z-power ups in a stage (one achievement for each on-rails stage)
			// - Pick up all A-power ups in one session (2 in stage 1 + 1 in stage 3)
			// - Acquire cerain amount of score (maybe for unlocking extra lives at 30 000, 70 000 and 120 000 score)
		// "a_Template2": {
		// 	"id": 000000, "points": AchievementPointClass.Free_0, "devInfo": "xxxxxxx"},
		},
	"c_mBonus": { // Missable Bonus - Missable achievements
		// CONCEPT c_mBonus
			// - Rescue both characters || Finish an on-rails stage from start to finish with a rescued character
			// - https://web.archive.org/web/20200928101143/https://www.engadget.com/2009-03-04-man-holds-woman-hostage-for-10-hours-with-a-sega-light-gun.html
		// "a_Template2": {
		// 	"id": 000000, "points": AchievementPointClass.Free_0, "devInfo": "xxxxxxx"},
		},
	"c_Challenges": { // Challenges
		// CONCEPT c_Challenges
			// - Complete an on-rails stage without dying
			// - Complete an on-rails stage without healing (health pickups + summoning)
			// - Complete an on-foot stage without taking a hit || without dying
			// - Complete a stage earning specific score...
			// - Complete an on-foot stage within time limit
			// - Finish game having rescued both character, but without having summoned them in battle. "Stay back I got this"
			// - Finish game with max lives (extra lives at 30 000, 70 000 and 120 000 score)
			// - Finish game without using continues (OR only using one)
			// - Finish game with certain score || time limit || lives left
		// "a_Template2": {
		// 	"id": 000000, "points": AchievementPointClass.Free_0, "devInfo": "xxxxxxx"},
		},
	}
dict_achievementCategoryToAchievementType = {
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- util.sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 	AchievementType.Standard,
	"c_Progress":		AchievementType.Progression,
	"c_WinCondition":	AchievementType.WinCondition,
	"c_Bonus":			AchievementType.Standard,
	"c_mBonus":			AchievementType.Missable,
	"c_Challenges":		AchievementType.Standard,
	}

// #endregion ACH - Core Data

// #region ACH - Triggers
dict_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP _template
		// // [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
		//	always_true()
		// 	&& always_false()),
	"a_Stage1": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			achievementSubLogic.CoreGroup_OnRailsStageCompletion(stage.One, enum_releaseRegion)),
	"a_Stage2": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			achievementSubLogic.CoreGroup_OnFootStageCompletion(stage.Two, BossEntity.Boss_1, enum_releaseRegion)),
	"a_Stage3": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			achievementSubLogic.CoreGroup_OnRailsStageCompletion(stage.Three, enum_releaseRegion)),
	"a_Stage4": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			achievementSubLogic.CoreGroup_OnFootStageCompletion(stage.Four, BossEntity.Boss_2, enum_releaseRegion)),
	"a_Stage5": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			achievementSubLogic.CoreGroup_OnRailsStageCompletion(stage.Five, enum_releaseRegion)),
	"a_Stage6": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			achievementSubLogic.CoreGroup_OnFootStageCompletion(stage.Six, BossEntity.Boss_3, enum_releaseRegion)),
	"a_Stage7": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement
			achievementSubLogic.CoreGroup_OnRailsStageCompletion(stage.Seven, enum_releaseRegion)),
	"a_Stage8": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
			achievementSubLogic.CoreGroup_OnFootStageCompletion(stage.Eight, BossEntity.Boss_Final, enum_releaseRegion)),
	}
// #endregion ACH - Triggers

// #region ACH - Text
dict_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	"a_Stage1": 			{"en": "Mission Begins"},
	"a_Stage2": 			{"en": "Out of Phase"},
	"a_Stage3": 			{"en": "Enemy Stronghold"},
	"a_Stage4": 			{"en": "Grounded"},
	"a_Stage5": 			{"en": "Counterattack"},
	"a_Stage6": 			{"en": "Missile Command"},
	"a_Stage7": 			{"en": "Final Approach"},
	"a_Stage8": 			{"en": "For Maris!"},
	
	}
dict_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
	"a_Stage1": 			{"en": "Complete Stage 1 and begin your mission against the Nohza threat"},
	"a_Stage2": 			{"en": "Defeat the Olivion Platoon Captain, completing Stage 2"},
	"a_Stage3": 			{"en": "Complete Stage 3 and press deeper into the fortress"},
	"a_Stage4": 			{"en": "Defeat the Radajian Defense Leader, completing Stage 4"},
	"a_Stage5": 			{"en": "Complete Stage 5 as the battle for Maris intensifies"},
	"a_Stage6": 			{"en": "Defeat the Alleevian Supreme Commander, completing Stage 6"},
	"a_Stage7": 			{"en": "Complete Stage 7 and access the inner garrison"},
	"a_Stage8": 			{"en": "Defeat Baron Ricks, thwarting the latest Nohza invasion"},
	}
// #endregion ACH - Text

// #region ACH - Initialization
function initialize() {
	function generateAchievementTitle(string_achievementDevName, string_achievementCategory, string_languageCode) {
		function createAchievementCategoryName(string_achievementCategory, string_achievementDevName) {
			let_string = ""
			if (util.isDebugModeActive) {
				let_shortenedAchievementCategory = substring(string_achievementCategory, 2)	// remove c_
				let_shortenedAchievementDevName = substring(string_achievementDevName, 2)	// remove a_
				let_string = format("[{0}_{1}] ", let_shortenedAchievementCategory, let_shortenedAchievementDevName)
			}
			return let_string}
		function getAchievementTitle(string_achievementDevName, string_languageCode) => 
			this.dict_titles[string_achievementDevName][string_languageCode]
		return format("{0}{1}",
			createAchievementCategoryName(string_achievementCategory, string_achievementDevName),
			getAchievementTitle(string_achievementDevName, string_languageCode))}
	
	function generateAchievementDescription(string_achievementDevName, string_devInfo, string_languageCode) {	
		function getAchievementDescription(string_achievementDevName, string_languageCode) => 
			this.dict_descriptions[string_achievementDevName][string_languageCode]	
		function formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util.isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = getAchievementDescription(string_achievementDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util.throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_achievementDevName))

		let_descriptionString_withDevInfo = let_descriptionString + formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}

	function getAchievementTrigger(string_achievementDevName) => 
		this.dict_triggers[string_achievementDevName]
	
	function getAchievementType(string_achievementCategory) {
		let_type = this.dict_achievementCategoryToAchievementType[string_achievementCategory]
		if(let_type == util.sNULL) return "" // <-- will result in type: "standard"
		return let_type}

	for let_categoryName in this.dict_coreData { // This loop generates the achievements
		for let_cheevmentName in this.dict_coreData[let_categoryName] {
			let_achievementData = this.dict_coreData[let_categoryName][let_cheevmentName]
			achievement(
				id = let_achievementData["id"],
				title = generateAchievementTitle(let_cheevmentName, let_categoryName, util.language),
				type = getAchievementType(let_categoryName),
				description = generateAchievementDescription(let_cheevmentName, let_achievementData["devInfo"], util.language),
				points = let_achievementData["points"],
				trigger = getAchievementTrigger(let_cheevmentName)
			)
		}}
	}
} achievements = CLASS_AchievementLogic()
// #endregion ACH - Initialization

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

// ======================
// • RICH PRESENCE text •
// ======================
// #region RP - Text
//	- Contains text for the rich presence script
richPresence_text = {
	// "rp_Template": 				{"en": "xxxxxxxx"},
	"rp_DefaultPlus":				{"en": "xxxxxxxx"},
	"rp_Default":					{"en": "xxxxxxxx"}}
richPresence_LookupTablesText = {
	// "lupText_Template": {
		// "LOOKUP_FALLBACK":				{"en": "xxxxxxxx"},
		// "LookupTextKey_A":				{"en": "xxxxxxxx"},
		// "LookupTextKey_B":				{"en": "xxxxxxxx"},
		// "LookupTextKey_C":				{"en": "xxxxxxxx"},
		// },
	}
// richPresence_ReleaseRegion_toSuperScript = { // DISABLED: Only 1 region supported
// 	// NOTE: Text to superscript --> https://lingojam.com/SuperscriptGenerator
// 	ReleaseRegion.USA: "ᵘˢ",
// 	ReleaseRegion.EUR: "ᵉᵘ",
// 	ReleaseRegion.JPN: "ʲᵖ",
// 	}
	
function richPresence_getText(string_textKey) =>
	richPresence_text[string_textKey][util.language]

function richPresence_getText_withRegionSuperScript(string_textKey, enum_releaseRegion) =>
	format("{0} {1}", richPresence_ReleaseRegion_toSuperScript[enum_releaseRegion], richPresence_getText(string_textKey))

function richPresence_getLookupTableText(string_lookupTableKey, let_lookupTableTextKey) =>
	richPresence_LookupTablesText[string_lookupTableKey][let_lookupTableTextKey][util.language]
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
	if (int_numberOfZerosToPad < 1) util.throwError("Number of zeros to pad must be bigger than 0")
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
		else util.throwError("Support for higher values is not implemented")
	}

	richPresence_lookupTables[string_lookupTableName] = let_dict_lookupTable}

function richPresence_initializeZeroPaddingLookupTables() { // Function is called in richPresence_initialize()
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeMinutes_ZeroPadding", 1, 59)
	richPresence_addZeroPaddingLookupTable("rpp_PresentTimeHours_ZeroPadding", 1, 23)}
// #endregion RP - Text

// ================================
// • RICH PRESENCE display script •
// ================================
// #region RP - Display Script

// function rp_TemplateDisplayScript(enum_releaseRegion) { 
	// function condition(enum_releaseRegion) =>
	// 	releaseRegion.is(enum_releaseRegion)
	// return rich_presence_conditional_display( 
	// 	condition(enum_releaseRegion),
	// 	richPresence_getText_withRegionSuperScript("rp_Template", enum_releaseRegion),
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 0
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion), // 1
	// 	richPresence_callParameterFunction("rpp_TemplateParameter", enum_releaseRegion) // 2
	// )}

function rp_DefaultPlus(enum_releaseRegion) { // rp_DefaultPlus => is rp_Default, but adds the possibility for value insertion/placeholder text when offering multiregion support
	function condition(enum_releaseRegion) =>
		releaseRegion.is(enum_releaseRegion)
	return rich_presence_conditional_display( 
		condition(enum_releaseRegion),
		richPresence_getText_withRegionSuperScript("rp_DefaultPlus", enum_releaseRegion)
	)}
function rp_Default() {
	return rich_presence_display(
		richPresence_getText("rp_Default")
	)}
// -------------------------------------
function richPresence_initializeDisplays() {
	rp_Default() // TODO rp_Default
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED {
		// rp_DefaultPlus(enum_releaseRegion) // CONCEPT rp_DefaultPlus
	}} 
// #endregion RP - Display Script

// ===========================
// • RICH PRESENCE parameters •
// ===========================
// #region RP - Parameters
class CLASS_ENUM_RichPresenceParameterTypes {
	VALUE = 1			// rich_presence_value(name, expression, [format])
	LOOKUP_HEX = 2		// rich_presence_lookup(name, expression, dictionary, [fallback])
	LOOKUP_STRING = 3	// rich_presence_ascii_string_lookup(name, memAddr_ASCII, dictionary, [fallback])
	MACRO = 4			// rich_presence_macro(macro, expression)
} RichPresenceParameterType = CLASS_ENUM_RichPresenceParameterTypes()
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
		// "RPtype": RichPresenceParameterType.VALUE,
		// "Expression": {
		// 	ReleaseRegion.USA: always_false(), 
		// 	ReleaseRegion.EUR: always_false(),
		// 	ReleaseRegion.JPN: always_false()},
		// "ValueFormat": "VALUE"},

	// "rpp_LookupHexTemplate": {
		// "RPtype": RichPresenceParameterType.LOOKUP_HEX,
		// "Expression": {
		// 	ReleaseRegion.USA: always_false(), 
		// 	ReleaseRegion.EUR: always_false(),
		// 	ReleaseRegion.JPN: always_false()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_LookupStringTemplate": {
		// "RPtype": RichPresenceParameterType.LOOKUP_STRING,
		// "MemoryAddressToASCII": {
		// 	ReleaseRegion.USA: memory.getAddress(), 
		// 	ReleaseRegion.EUR: memory.getAddress(),
		// 	ReleaseRegion.JPN: memory.getAddress()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_MacroTemplate": {
		// "RPtype": RichPresenceParameterType.MACRO,
		// "Expression": {
		// 	ReleaseRegion.USA: always_false(), 
		// 	ReleaseRegion.EUR: always_false(),
		// 	ReleaseRegion.JPN: always_false()},
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
	if (let_RPtype == RichPresenceParameterType.VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == RichPresenceParameterType.LOOKUP_HEX) return richPresence_callLookupHexFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == RichPresenceParameterType.LOOKUP_STRING) return richPresence_callLookupStringFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == RichPresenceParameterType.MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
	else util.throwError(format("The rich presence parameter: {0} did not evaluate correctly", string_placeholderParameterKey))}
// #endregion RP - Parameters

// ===============================
// • RICH PRESENCE initialization •
// ===============================
// #region RP - Initialization
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
// #endregion RP - Initialization
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

// ==========================================
// • LEADERBOARD sub logic & value measures •
// ==========================================
// #region LB - sub logic
//	- For achievement logic that's reoccuring across multiple triggers
class CLASS_LeaderboardSubLogic {

} leaderboardSubLogic = CLASS_LeaderboardSubLogic()
// #endregion LB - sub logic
// #region LB - Value Measures
// NOTE: ValueMeasures need to be in seperate function like below, as it requires usage of max_of()
class CLASS_LeaderboardValuesMeasures {
	function Template_TimeSpentInLevel() {
		function valueMeasure(enum_releaseRegion) => 
			measured(
				current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion),
				when = is_ReleaseRegion(enum_releaseRegion))

		let_array_valueMeasures = []
		for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
			array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
		return max_of(let_array_valueMeasures)}
} leaderboardValueMeasure = CLASS_LeaderboardValuesMeasures()
// #endregion LB - Value Measures

// =====================
// • LEADERBOARD logic •
// =====================
class CLASS_LeaderboardLogic {
// #region LB - Core Data
dict_coreData = {
	// DEV_NOTE: Leaderboards
	// -----------------------------
	//	- RATools documentation => https://github.com/Jamiras/RATools/wiki/Leaderboard-Functions
	//	- RADocs => https://docs.retroachievements.org/Leaderboards/
	//	- Example leaderboards => https://retroachievements.org/game/3152

	// "lb_Template": { // CONCEPT lb_template
		// "id": 000000, "isLowerBetter": false, "leaderboardFormat": "VALUE", "devInfo": "xxxxxxx"},
	}
// #endregion LB - Core Data

// #region LB - Triggers
dict_startTriggers = {
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
dict_cancelTriggers = {
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
dict_submitTriggers = {
	// "lb_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) =>
		// // [1] ==== Alt Submit Group ====			-> Submit when ...
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// // [2] ==== Alt Reset Group ====			-> Reset when ...
		// 	|| is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()
		// ),
	}
dict_valueMeasures = {
	// "lb_template": leaderboardValueMeasure.Template_TimeSpentInLevel(),
	}
// #endregion LB - Triggers

// #region LB - Text
dict_titles = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
dict_descriptions = {
	// "lb_Template": 						{"en": "xxxxxxxx"},
	}
// #endregion LB - Text

// #region LB - Initialization
function initialize() {
	function generateLeaderboardTitle(string_leaderboardDevName, string_languageCode) {
		function createLeaderboardDevName(string_leaderboardDevName) => 	// Wrap LeaderoboardDevName in [] (brackets)
			format("[{0}] ", string_leaderboardDevName)
		function getLeaderboardTitle(string_leaderboardDevName, string_languageCode) => 
			this.dict_titles[string_leaderboardDevName][string_languageCode]

		if (util.isDebugModeActive) {
			return format("{0}{1}", 
				createLeaderboardDevName(string_leaderboardDevName),
				getLeaderboardTitle(string_leaderboardDevName, string_languageCode))
		} else {
			return getLeaderboardTitle(string_leaderboardDevName, string_languageCode)
		}}
	
	function generateLeaderboardDescription(string_leaderboardDevName, string_devInfo, string_languageCode) {	
		function getLeaderboardDescription(string_leaderboardDevName, string_languageCode) {
			return this.dict_descriptions[string_leaderboardDevName][string_languageCode]}
		function formatDevInfo(string_devInfo) {
			let_devInfoString = ""
			if (util.isDebugModeActive && string_devInfo != "") {
				let_devInfoString = format(" - [DEV: {0}]", string_devInfo)
			}
			return let_devInfoString}

		let_descriptionString = getLeaderboardDescription(string_leaderboardDevName, string_languageCode)
		if (length(let_descriptionString) > 255)
			util.throwError(format("Description for achievement[{0}] exceeds limit of 255 characters", string_leaderboardDevName))

		let_descriptionString_withDevInfo = let_descriptionString + formatDevInfo(string_devInfo)
		if (length(let_descriptionString_withDevInfo) > 255)
			return let_descriptionString
		else 
			return let_descriptionString_withDevInfo}
	

	for let_leaderboardKey in this.dict_coreData {
		let_leaderboardData = this.dict_coreData[let_leaderboardKey]
		leaderboard(
			id = let_leaderboardData["id"],
			title = generateLeaderboardTitle(let_leaderboardKey, util.language), 
			description = generateLeaderboardDescription(let_leaderboardKey, let_leaderboardData["devInfo"], util.language),
			start = this.dict_startTriggers[let_leaderboardKey], 
			cancel = this.dict_cancelTriggers[let_leaderboardKey], 
			submit = this.dict_submitTriggers[let_leaderboardKey], 
			value = this.dict_valueMeasures[let_leaderboardKey],
			format = let_leaderboardData["leaderboardFormat"], 
			lower_is_better = let_leaderboardData["isLowerBetter"])}
	}
// #endregion LB - Initialization
} leaderboards = CLASS_LeaderboardLogic()
// #endregion LEADERBOARDS

// ====================================================================== \\
//   █ █▄░█ █ ▀█▀ █ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█     █▀▀ █▀█ █▀▄ █▀▀   \\
//   █ █░▀█ █ ░█░ █ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█     █▄▄ █▄█ █▄▀ ██▄   \\
// ====================================================================== \\
// #region RAScript Initialization
function initializeRAscript() {
	achievements.initialize() // --> Functional as a CLASS, since everything is hardcoded
	richPresence_initialize() // --> Not functional as CLASS, because some dictionaries may be altered during runtime of this script, therefor RP is fully coded with global functions and variables
	leaderboards.initialize()} // --> Functional as a CLASS, since everything is hardcoded
initializeRAscript()
// #endregion RAScript Initialization