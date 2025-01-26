FlagData_Bitset_ActivatedCheats = {
	"Flags_UnlockableCheats": {
		1: [6,7],
		2: [2,4,5,6,7]},
	"Flags_DebugCheats": {
		2: [0,1]}
	}

pointerToBitset_ActivatedCheats = 0xBA
offsetToByte1 = 0x0
offsetToByte2 = 0x1

sumOf_UnlockableCheats_Normal_withSubSource = 
    bit6(offsetToByte1) + bit7(offsetToByte1)
    + bitcount(offsetToByte2) - bit0(offsetToByte2) - bit1(offsetToByte2) - bit3(offsetToByte2)
    
SumOf_UnlockableCheats_AddAddress_noSubSource = 
    bit6(dword(pointerToBitset_ActivatedCheats) + offsetToByte1) + bit7(dword(pointerToBitset_ActivatedCheats) + offsetToByte1)
    + bitcount(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) 

SumOf_UnlockableCheats_AddAddress_withMultipleSubSource = 
    bit6(dword(pointerToBitset_ActivatedCheats) + offsetToByte1) + bit7(dword(pointerToBitset_ActivatedCheats) + offsetToByte1)
    + bitcount(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) - bit0(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) - bit1(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) - bit3(dword(pointerToBitset_ActivatedCheats) + offsetToByte2)

SumOf_UnlockableCheats_AddAddress_withOneSubSource_noBitcount = 
    bit6(dword(pointerToBitset_ActivatedCheats) + offsetToByte1) + bit7(dword(pointerToBitset_ActivatedCheats) + offsetToByte1)
    - bit0(dword(pointerToBitset_ActivatedCheats) + offsetToByte2)

SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount = 
    bit6(dword(pointerToBitset_ActivatedCheats) + offsetToByte1) + bit7(dword(pointerToBitset_ActivatedCheats) + offsetToByte1)
    - bit0(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) 
    - bit1(dword(pointerToBitset_ActivatedCheats) + offsetToByte2)

SumOf_UnlockableCheats_AddAddress_withOneSubSource = 
    bit6(dword(pointerToBitset_ActivatedCheats) + offsetToByte1) + bit7(dword(pointerToBitset_ActivatedCheats) + offsetToByte1)
    + bitcount(dword(pointerToBitset_ActivatedCheats) + offsetToByte2) 
    - bit0(dword(pointerToBitset_ActivatedCheats) + offsetToByte2)

function is_AnyCheat_active() => 
    // sumOf_UnlockableCheats_Normal_withSubSource // <-- Working as intended
    // SumOf_UnlockableCheats_AddAddress_noSubSource // <-- Working as intended
    // SumOf_UnlockableCheats_AddAddress_withOneSubSource_noBitcount // <-- Working as intended
    // SumOf_UnlockableCheats_AddAddress_withOneSubSource // <-- Working as intended

    // SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount // <-- RATools stuck in processing infinite loop, hogs CPU resources even when loading another rascript file, until program close
    SumOf_UnlockableCheats_AddAddress_withMultipleSubSource // <-- RATools stuck in processing infinite loop, hogs CPU resources even when loading another rascript file, until program close
    > 0

achievement(
    title = "SumOf",
    description = "testing",
    points = 10,
    trigger = 
        is_AnyCheat_active()
)

achievement(
    title = "Measured_SumOf",
    description = "Count Cheats Unlocked",
    points = 10,
    trigger = 
        // prev(SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount) == 2 // <-- this 1 line puts RATools into infinite processing loop 
        // && measured(SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount == 3)

        SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount == 3 // <-- this 1 line puts RATools into infinite processing loop 

        measured(SumOf_UnlockableCheats_AddAddress_withMultipleSubSource_noBitcount == 3) // <-- wrapping it into measured() works as intended
)

achievement(
    title = "Workaround: Count all Bitflags 1 by 1 or only bitcount when all bits in a byte are flags",
    description = "xxxx",
    points = 10,
    trigger = 

)