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
	USA = "NTSC-U"
	JPN = "NTSC-J"
	EUR = "PAL"
	}
ENUM_ReleaseRegion = CLASS_ENUM_ReleaseRegions()
RELEASE_REGIONS_SUPPORTED = [] // TODO add regions

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
	dict_structDefinitions = {}
	function getStruct_SizeInBytes(string_structKey) =>
		dict_structDefinitions[string_structKey]["sizeInBytes"]

	function getStruct_OffsetToMember(string_structKey, string_memberKey) =>
		dict_structDefinitions[string_structKey]["offsetToMember"][string_memberKey]

	function getStruct_offsetSequenceToMember(string_structKey, string_pointerChainKey) =>
		dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"]

	function getStruct_offsetSequenceToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) =>
		dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["pointerChainOffsets"][enum_releaseRegion]

	function getStruct_OffsetToPointedToMember(string_structKey, string_pointerChainKey) => 
		dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"]
		
	function getStruct_OffsetToPointedToMember_byReleaseRegion(string_structKey, string_pointerChainKey, enum_releaseRegion) => 
		dict_structDefinitions[string_structKey]["pointerChainToMember"][string_pointerChainKey]["offsetToPointedToMember"][enum_releaseRegion]

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
		// "memAddrKey": {ENUM_ReleaseRegion.USA: util.sNULL, ENUM_ReleaseRegion.EUR: util.sNULL, ENUM_ReleaseRegion.JPN: util.sNULL},
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
	// #endregion MemUtil - Main
} memUtil = CLASS_MemoryUtility()

class CLASS_MEMLOGIC_ReleaseRegion { // TODO implement is_ReleaseRegion()
	function is(enum_releaseRegion) {	
		let_string_GameID = util.sNULL
		if(enum_releaseRegion == ENUM_ReleaseRegion.USA) let_string_GameID = util.sNULL // FullString: "xxxxx"
		else if(enum_releaseRegion == ENUM_ReleaseRegion.JPN) let_string_GameID = util.sNULL // FullString: "xxxxx"
		else if(enum_releaseRegion == ENUM_ReleaseRegion.EUR) let_string_GameID = util.sNULL // FullString: "xxxxx"
		
		if (let_string_GameID == util.sNULL) util.throwError(format("Game region '{0}' is not supported", enum_releaseRegion))
		return memUtil.is_ASCII_EqualTo(memory.getAddress("ASCII:GameID", enum_releaseRegion), let_string_GameID)
		}
} releaseRegion = CLASS_MEMLOGIC_ReleaseRegion()

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

// ==================================
// • ACHIEVEMENT trigger generators •
// ==================================
// #region ACH - trigger generators
//	- For achievement logic that's reoccuring across multiple triggers

// #endregion ACH - trigger generators

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
} ENUM_AchievementPointClass = CLASS_ENUM_AchievementPointClasses()

class CLASS_ENUM_AchievementTypes {
	Progression = "progression"
	WinCondition = "win_condition"
	Missable = "missable"
	Standard = ""
	}
ENUM_AchievementType = CLASS_ENUM_AchievementTypes()

class CLASS_AchievementLogic {
// #region ACH - Core Data
dict_coreData = {
	// DEV_NOTE: Achievement property 'badgeId'
	// 		- Do not add badge ID to this core data. Just upload badges with RALibretro or via RA game page, otherwise might cause a headache keeping everything in sync
	// ------------------------------------------------

	// "a_Template": { // CONCEPT a_template
		// "id": 000000, "points": 0000000, "devInfo": "xxxxxxx"},
	
	"c_Template": { // Category - info_here
		// "a_Template": {
		// 	"id": 000000, "points": ENUM_AchievementPointClass.Free_0, "devInfo": "xxxxxxx"}
		},
	"c_Template2": { // Category - info_here
		// "a_Template2": {
		// 	"id": 000000, "points": ENUM_AchievementPointClass.Free_0, "devInfo": "xxxxxxx"}
		},
	}

dict_achievementCategoryToAchievementType = { // TODO set achievement types
	// DEV_NOTE: Achievement property 'type'
	//	- Possible type keys: "missable" - "progression" - "win_condition" 
	//	- util.sNULL => when it's not necessarily a missable achievement --> will result in type: "standard"
	//		- Missable is when you would have to play a significant portion of game again to obtain the achievement.
	//		 	Think about that 40 hour RPG, and something happens where the world state changes, and an area is no longer available, and certain quests are locked out.
	//		 	But the person making the achievement for that quest didn't tell you that you could miss it.
	//	- Refer to https://docs.retroachievements.org/Progression-and-Win-Condition-Guidelines/
	// ------------------------------------------------------
	
	// "c_Template": 	ENUM_AchievementType.Standard,
	"c_Template": 		ENUM_AchievementType.Standard
	}

// #endregion ACH - Core Data

// #region ACH - Triggers
dict_triggers = {
	// "a_Template": any_of(RELEASE_REGIONS_SUPPORTED, (enum_releaseRegion) => // WIP _template
		// // [0] ==== Core Logic Group ==== 			-> This group handles the achievement logic; This group is responsible for unlocking the achievement	
		// 	is_ReleaseRegion(enum_releaseRegion)
		// 	&& always_false()),
	}
// #endregion ACH - Triggers

// #region ACH - Text
dict_titles = {
	// "a_Template": 			{"en": "xxxxxxxxx"},
	}
dict_descriptions = {
	// "a_Template": 			{"en": "xxxxxxxx"},
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
richPresence_ReleaseRegion_toSuperScript = {
	// NOTE: Text to superscript --> https://lingojam.com/SuperscriptGenerator
	ENUM_ReleaseRegion.USA: "ᵘˢ",
	ENUM_ReleaseRegion.EUR: "ᵉᵘ",
	ENUM_ReleaseRegion.JPN: "ʲᵖ",
	}
	
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
} ENUM_RichPresenceParameterType = CLASS_ENUM_RichPresenceParameterTypes()
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
		// "RPtype": ENUM_RichPresenceParameterType.VALUE,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
		// "ValueFormat": "VALUE"},

	// "rpp_LookupHexTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.LOOKUP_HEX,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_LookupStringTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.LOOKUP_STRING,
		// "MemoryAddressToASCII": {
		// 	ENUM_ReleaseRegion.USA: memory.getAddress(), 
		// 	ENUM_ReleaseRegion.EUR: memory.getAddress(),
		// 	ENUM_ReleaseRegion.JPN: memory.getAddress()},
		// "LookupTableID": "lup_LookupTableKey",
		// "LookupFallback": richPresence_getLookupTableText("lupText_LookupTableKey", "LOOKUP_FALLBACK")},

	// "rpp_MacroTemplate": {
		// "RPtype": ENUM_RichPresenceParameterType.MACRO,
		// "Expression": {
		// 	ENUM_ReleaseRegion.USA: always_false(), 
		// 	ENUM_ReleaseRegion.EUR: always_false(),
		// 	ENUM_ReleaseRegion.JPN: always_false()},
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
	if (let_RPtype == ENUM_RichPresenceParameterType.VALUE) return richPresence_callValueFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.LOOKUP_HEX) return richPresence_callLookupHexFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.LOOKUP_STRING) return richPresence_callLookupStringFunction(string_parameterKey, let_parameterData, enum_releaseRegion)
	else if (let_RPtype == ENUM_RichPresenceParameterType.MACRO) return richPresence_callMacroFunction(let_parameterData, enum_releaseRegion)
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

// ==================================
// • LEADERBOARD trigger generators •
// ==================================
// #region LB - Trigger Generators
//	- For leaderboard logic that's reoccuring across multiple triggers

// #region LB - Value Measures
// NOTE: ValueMeasures need to be in seperate function like below, as it requires usage of max_of()
function lb_ValueMeasure_TimeSpentInLevel() { // lb_ValueMeasure_Template
	function valueMeasure(enum_releaseRegion) => 
		measured(
			current_TimeSpentInLevel_inCentiSeconds(enum_releaseRegion),
			when = is_ReleaseRegion(enum_releaseRegion))

	let_array_valueMeasures = []
	for enum_releaseRegion in RELEASE_REGIONS_SUPPORTED
		array_push(let_array_valueMeasures, valueMeasure(enum_releaseRegion))
	return max_of(let_array_valueMeasures)}
// #endregion LB - Value Measures
// #endregion LB - Trigger Generators

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
	// "lb_template": lb_ValueMeasure_Template(),
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