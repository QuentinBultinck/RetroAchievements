// Shadow of Destiny
// #ID = 3945

// $1DFB3D0: [32-bit] Cutscene ID #23
function cutsceneId23() => dword(0x1DFB3D0)

// $1DFCD78: [32-bit] Cutscene ID #24
function cutsceneId24() => dword(0x1DFCD78)

// $1DFEA54: [32-bit] Cutscene ID #25
function cutsceneId25() => dword(0x1DFEA54)

achievement(
    title = "[c_Extra] A Mother's child Forever", points = 5,
    description = "Look for Hugo during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Secret cutscene in chapter 5 => when going to 1580 (not 1584) => head to marktplatz of Hugo getting bullied]",
    id = 311466, badge = "00000", published = "24/04/2023 18:48:54", modified = "24/04/2023 18:48:54",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 6) && tally(290, 
                  repeated(70, dword(0xAC31E4) == 82 && prior(dword(0xAC31E4)) == 121 && dword(0x1DF81BA) == 4369 &&
                   prior(dword(0x1DF81BA)) == 3873374568 && dword(0x1DFAC91) == 2972498714 && prior(dword(0x1DFAC91)) ==
                   552402885 && dword(0x1DF81E5) == 3445216964 && prior(dword(0x1DF81E5)) == 285216796), 
                  repeated(150, dword(0xAC31E4) == 135 && prior(dword(0xAC31E4)) == 50 && dword(0x1DF6F60) ==
                   12648456 && prior(dword(0x1DF6F60)) == 4280155223 && dword(0x1DF9AA4) == 1157 &&
                   prior(dword(0x1DF9AA4)) == 562573726 && dword(0x1DFAD9A) == 102564956 && prior(dword(0x1DFAD9A)) ==
                   3873431747), 
                  repeated(70, dword(0xAC31E4) == 80 && prior(dword(0xAC31E4)) == 89 && dword(0x1DF81BA) ==
                   4145938432 && prior(dword(0x1DF81BA)) == 1566491669 && dword(0x1DF8B14) == 808453752 &&
                   prior(dword(0x1DF8B14)) == 6433 && dword(0x1DF81E5) == 2642512273 && prior(dword(0x1DF81E5)) ==
                   671237376), 
              
               always_false()) && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 38
)

achievement(
    title = "[c_Extra] Memories of Past Love #2", points = 5,
    description = "Find the coated man and woman during chapter 3 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 3]",
    id = 310131, badge = "00000", published = "19/04/2023 11:41:41", modified = "24/04/2023 18:47:43",
    trigger = unless((dword(0xA9EFDC) != 146379984 && dword(0xA9EFE4) != 144903184 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379972 && dword(0xA9EFE4) != 144902844 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379984 && dword(0xA9EFE4)
               != 144903204 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379972 &&
               dword(0xA9EFE4) != 144902864 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902864), 
                  once(dword(0xA9EFE4) == 144902844), 
                  once(dword(0xA9EFE4) == 144903184), 
                  once(dword(0xA9EFE4) == 144903204)
              ), when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) ==
               4))
)

achievement(
    title = "[c_Extra] Timeless Antiques", points = 3,
    description = "Visit Antique Shop Eule and glance at the original relics - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Visit 'Antique shop Eule' and interact with all original relics, Shop is open in chapter 3, 4 and 6 (1980)]",
    id = 310132, badge = "00000", published = "19/04/2023 12:50:26", modified = "24/04/2023 18:48:23",
    trigger = unless((dword(0xA9EFDC) != 146380032 && dword(0xA9EFE4) != 144905744 && dword(0xA9EFF4) != 198 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146380044 && dword(0xA9EFE4) != 144905664 &&
               dword(0xA9EFF4) != 152 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146380020 &&
               dword(0xA9EFE4) != 144905784 && dword(0xA9EFF4) != 121 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 146380008 && dword(0xA9EFE4) != 144905704 && dword(0xA9EFF4) != 142 &&
               bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C)) == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144905744), 
                  once(dword(0xA9EFE4) == 144905664), 
                  once(dword(0xA9EFE4) == 144905784), 
                  once(dword(0xA9EFE4) == 144905704)
              ),
               when=bit0(0xA9F034) == 1 && repeated(100, repeated(100, byte(0xB95704) == 4) || repeated(100,
               byte(0xB95704) == 5) || byte(0xB95704) == 7))
)

achievement(
    title = "[c_Extra] The Place Where We Almost Met", points = 5,
    description = "Help a lost couple reunite again during chapter 3 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 3]",
    id = 310133, badge = "00000", published = "19/04/2023 12:50:26", modified = "24/04/2023 18:48:22",
    trigger = unless((dword(0xA9EFDC) != 144816496 && dword(0xA9EFE4) != 144911464 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816484 && dword(0xA9EFE4) != 144911384 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816496 &&
               dword(0xA9EFE4) != 144911484 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 144816484 && dword(0xA9EFE4) != 144911404 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816496 && dword(0xA9EFE4) != 144911504 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816484 &&
               dword(0xA9EFE4) != 144911424 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144911384), 
                  once(dword(0xA9EFE4) == 144911464), 
                  once(dword(0xA9EFE4) == 144911404), 
                  once(dword(0xA9EFE4) == 144911484), 
                  once(dword(0xA9EFE4) == 144911424), 
                  once(dword(0xA9EFE4) == 144911504)
              ), when=repeated(100, byte(0xB95704) == 4) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Extra] Memories of Past Love #3", points = 5,
    description = "Find the coated man and woman during chapter 4 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 4]",
    id = 310134, badge = "00000", published = "19/04/2023 12:50:26", modified = "24/04/2023 18:47:43",
    trigger = unless((dword(0xA9EFDC) != 146398348 && dword(0xA9EFE4) != 144903184 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398336 && dword(0xA9EFE4) != 144902904 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398348 && dword(0xA9EFE4)
               != 144903204 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398336 &&
               dword(0xA9EFE4) != 144902924 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902924), 
                  once(dword(0xA9EFE4) == 144902904), 
                  once(dword(0xA9EFE4) == 144903184), 
                  once(dword(0xA9EFE4) == 144903204)
              ), when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) ==
               5))
)

achievement(
    title = "[c_Extra] Memories of Past Love #4", points = 5,
    description = "Find the coated man and woman during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 5]",
    id = 310135, badge = "00000", published = "19/04/2023 15:36:31", modified = "24/04/2023 18:47:44",
    trigger = unless((dword(0xA9EFDC) != 146396160 && dword(0xA9EFE4) != 144903324 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396148 && dword(0xA9EFE4) != 144903004 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396148 && dword(0xA9EFE4)
               != 144903024 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144903004), 
                  once(dword(0xA9EFE4) == 144903024), 
                  once(dword(0xA9EFE4) == 144903324)
              ),
               when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) == 6))
)

achievement(
    title = "[c_Completion] Through the Lens of Survival", points = 5,
    description = "Complete Chapter 4, using a sign - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Complete chapter 4, using a sign]",
    id = 310149, badge = "00000", published = "19/04/2023 16:09:53", modified = "24/04/2023 18:47:42",
    trigger = bit0(0xA9F034) == 1 && bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 5 && prev(byte(0xB95704)) == 5 && 
              byte(0xB95704) == 6
)

achievement(
    title = "[c_Extra] The Pain of Parting", points = 3,
    description = "Consult the waiting man during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost man in 1584 during chapter 5]",
    id = 310162, badge = "00000", published = "19/04/2023 19:39:22", modified = "24/04/2023 18:48:22",
    trigger = unless((dword(0xA9EFDC) != 146396652 && dword(0xA9EFE4) != 144912844 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396652 && dword(0xA9EFE4) != 144912864 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C)) == 0 && measured(tally(2, 
                  once(dword(0xA9EFE4) == 144912844), 
                  once(dword(0xA9EFE4) == 144912864), 
              
               always_false()), when=repeated(100, byte(0xB95704) == 6) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra] Complexities of the Fourth Dimension", points = 10,
    description = "Take a picture in a costume during chapter 4 and finish the chapter - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Complete chapter 4, using a sign OR frying pan AND taken the picture as the white dressed man]",
    id = 310163, badge = "00000", published = "19/04/2023 19:40:38", modified = "24/04/2023 18:47:42",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 5) && tally(8, 
                  once(dword(0x1DFB22B) == 32768 && prior(dword(0x1DFB22B)) == 2009355057 && dword(0x1DFA4F8) ==
                   286330880 && prior(dword(0x1DFA4F8)) == 64), 
                  once(dword(0x1DFAD9A) == 4288020338 && prior(dword(0x1DFAD9A)) == 930480128 && dword(0x1DFA0E6) ==
                   4132831219 && prior(dword(0x1DFA0E6)) == 5242960), 
                  once(dword(0xAC31E4) == 30 && prior(dword(0xAC31E4)) == 125), 
                  once(dword(0xAC31E4) == 60 && prior(dword(0xAC31E4)) == 160), 
                  once(dword(0xAC31E4) == 827 && prior(dword(0xAC31E4)) == 975), 
                  once(dword(0xAC31E4) == 525 && prior(dword(0xAC31E4)) == 705), 
                  once(dword(0xAC31E4) == 78 && prior(dword(0xAC31E4)) == 211), 
                  once(dword(0xAC31E4) == 83 && prior(dword(0xAC31E4)) == 130), 
              
               always_false()) && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 45 &&
              ((byte(0xA9F111) == 5) ||
               (byte(0xA9F111) == 4))
)

achievement(
    title = "[c_Extra] Nine Lives across Generations", points = 10,
    description = "Gift a feline to a girl during chapter 4, 5 or 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart => give kitten before chapter 7]",
    id = 310426, badge = "00000", published = "20/04/2023 18:06:14", modified = "24/04/2023 18:47:44",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never((byte(0xB95704) != 5 && byte(0xB95704)
               != 6 && byte(0xB95704) != 7)) && tally(2, 
                  once(dword(0x1DF6724) == 4282843299 && prior(dword(0x1DF6724)) == 119 && dword(0x1DF5A0C) ==
                   639826616 && prior(dword(0x1DF5A0C)) == 4190241152 && dword(0x1DFA0E6) == 3299332805 &&
                   prior(dword(0x1DFA0E6)) == 1483 && dword(0xAC31E4) == 55 && prior(dword(0xAC31E4)) == 76), 
                  once(dword(0x1DF7FA2) == 2290614289 && prior(dword(0x1DF7FA2)) == 113 && dword(0x1DFAD9A) ==
                   4142006270 && prior(dword(0x1DFAD9A)) == 4668751 && dword(0x1DF8B14) == 4283432940 &&
                   prior(dword(0x1DF8B14)) == 4251189880 && dword(0xAC31E4) == 76 && prior(dword(0xAC31E4)) == 115)
              ) && repeated(160, dword(0xAC31E4) == 0)
)

achievement(
    title = "[c_Extra] Destiny's Promise Fulfilled", points = 5,
    description = "Reunite the lost couple during chapter 4 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 4]",
    id = 309393, badge = "00000", published = "17/04/2023 19:03:08", modified = "24/04/2023 18:47:43",
    trigger = unless((dword(0xA9EFDC) != 144816568 && dword(0xA9EFE4) != 144912464 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816556 && dword(0xA9EFE4) != 144912384 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816568 &&
               dword(0xA9EFE4) != 144912484 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 144816556 && dword(0xA9EFE4) != 144912404 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816568 && dword(0xA9EFE4) != 144912504 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816556 &&
               dword(0xA9EFE4) != 144912424 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144912384), 
                  once(dword(0xA9EFE4) == 144912464), 
                  once(dword(0xA9EFE4) == 144912404), 
                  once(dword(0xA9EFE4) == 144912484), 
                  once(dword(0xA9EFE4) == 144912424), 
                  once(dword(0xA9EFE4) == 144912504)
              ), when=repeated(100, byte(0xB95704) == 5) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Completion] Remedy from the Past", points = 10,
    description = "Complete Chapter 5 - [DEV: Complete chapter 5]",
    id = 311616, badge = "00000", published = "25/04/2023 18:57:11", modified = "25/04/2023 18:57:11",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && byte(0xA9F111) == 17 &&
              ((repeated(1920, dword(0x1DF7FA2) == 442450251 && dword(0x1DF8442) == 286331152 && dword(0x1DF8B14) ==
                 312350429 && dword(0x1DFA4F8) == 3505059341 && dword(0x1DF5950) == 3145816)) ||
               (prev(byte(0xB95704)) == 6 && byte(0xB95704) == 7))
)

achievement(
    title = "[c_Extra] 'Picked up a baby the other day'", points = 5,
    description = "Uncover a snowy crime scene during chapter 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Discover a crime scene during the winter, in chapter 6]",
    id = 313209, badge = "00000", published = "1/05/2023 15:18:03", modified = "1/05/2023 15:18:03",
    trigger = unless(bit0(0xA9EB2C) == 1) && measured(tally(3, 
                  once(dword(0x1DF4280) == 36438193 && prior(dword(0x1DF4280)) == 347602734 && dword(0x1DF5F71) ==
                   15433216 && prior(dword(0x1DF5F71)) == 986653976 && dword(0x1DFAC91) == 637292055 &&
                   prior(dword(0x1DFAC91)) == 285288960 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 30 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4784086 && dword(0xAC326C) == 0 &&
                   prior(dword(0xAC326C)) == 4915200), 
                  once(dword(0x1DF6F60) == 4220911616 && prior(dword(0x1DF6F60)) == 62576 && dword(0x1DF81BA) ==
                   4020961374 && prior(dword(0x1DF81BA)) == 4169198535 && dword(0x1DF5A0C) == 335937536 &&
                   prior(dword(0x1DF5A0C)) == 4114682129 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 30 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4784112), 
                  once(dword(0x1DF5F71) == 1862270976 && dword(0x1DF8229) == 17 && dword(0x1DFAC91) == 171008 &&
                   dword(0x1DFB22B) == 3271797515 && dword(0x1DF5A0C) == 190846794)
              ), when=bit0(0xA9F034) == 1 &&
               byte(0xB95704) == 7)
)

achievement(
    title = "[c_Completion] Director's Cut: Trip for Two", points = 4,
    description = "Complete Chapter 6, by co-directing a love picture - [DEV: Complete chapter 6, by co-directing a love movie]",
    id = 313210, badge = "00000", published = "1/05/2023 15:18:03", modified = "1/05/2023 15:19:57",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 7) && once(dword(0xAC31E4) == 1 &&
               prior(dword(0xAC31E4)) == 130 && dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4194192 &&
               dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4194301 && dword(0xAC33E8) == 0 &&
               prior(dword(0xAC33E8)) == 5308392 && dword(0x1DF4280) == 347602734 && prior(dword(0x1DF4280)) == 8584860
               && dword(0x1DFB0F0) == 4176419421 && prior(dword(0x1DFB0F0)) == 3873780146 && dword(0x1DF5950) ==
               4223074895 && prior(dword(0x1DF5950)) == 3873780144) && trigger_when(tally(171, 
                  repeated(170, dword(0x1DFAC91) == 3607560194 && prior(dword(0x1DFAC91)) == 335557120 &&
                   dword(0x1DFAD9A) == 2952787772 && prior(dword(0x1DFAD9A)) == 3876919586 && dword(0x1DFB0F0) == 129652
                   && prior(dword(0x1DFB0F0)) == 3735635 && dword(0xAC31E4) == 90 && prior(dword(0xAC31E4)) == 98), 
                  once(dword(0x1DF59B0) == 1476674937 && prior(dword(0x1DF59B0)) == 38370048 && dword(0x1DF81BA) ==
                   697764698 && prior(dword(0x1DF81BA)) == 1154920832 && dword(0x1DF8B14) == 63499 &&
                   prior(dword(0x1DF8B14)) == 3873382145 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 136)
              ))
)

achievement(
    title = "[c_Completion] Director's Cut: The Time of Reckoning", points = 4,
    description = "Complete Chapter 6, by co-directing a thriller picture - [DEV: Complete chapter 6, by co-directing a thriller movie]",
    id = 313211, badge = "00000", published = "1/05/2023 15:18:03", modified = "1/05/2023 15:19:56",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 7) && once(dword(0xAC31E4) == 1 &&
               prior(dword(0xAC31E4)) == 130 && dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259729 &&
               dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4259838 && dword(0xAC33E8) == 0 &&
               prior(dword(0xAC33E8)) == 5242855 && dword(0x1DF4280) == 347602734 && prior(dword(0x1DF4280)) == 8584860
               && dword(0x1DFB0F0) == 4176419421 && prior(dword(0x1DFB0F0)) == 3873780146 && dword(0x1DF5950) ==
               4223074895 && prior(dword(0x1DF5950)) == 3873780144) && trigger_when(tally(171, 
                  repeated(170, dword(0x1DFAC91) == 3607560194 && prior(dword(0x1DFAC91)) == 335557120 &&
                   dword(0x1DFAD9A) == 2952787772 && prior(dword(0x1DFAD9A)) == 3876919586 && dword(0x1DFB0F0) == 129652
                   && prior(dword(0x1DFB0F0)) == 3735635 && dword(0xAC31E4) == 90 && prior(dword(0xAC31E4)) == 98), 
                  once(dword(0x1DF59B0) == 1476674937 && prior(dword(0x1DF59B0)) == 38370048 && dword(0x1DF81BA) ==
                   697764698 && prior(dword(0x1DF81BA)) == 1154920832 && dword(0x1DF8B14) == 63499 &&
                   prior(dword(0x1DF8B14)) == 3873382145 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 136)
              ))
)

achievement(
    title = "[c_Extra_GameOver] Time Ego Flop", points = 2,
    description = "View every possible movie poster during chapter 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: During chapter 6, co-direct Time Ego]",
    id = 313212, badge = "00000", published = "1/05/2023 15:18:03", modified = "1/05/2023 15:18:03",
    trigger = repeated(500, dword(0x1DF742A) == 4283630089 && prior(dword(0x1DF742A)) == 4284151374 && dword(0x1DFAC91)
               == 69120 && prior(dword(0x1DFAC91)) == 3271557120 && dword(0x1DFA0E6) == 3006992 &&
               prior(dword(0x1DFA0E6)) == 65441 && dword(0xAC31E4) == 50 && prior(dword(0xAC31E4)) == 128) && 
              repeated(30, dword(0xAC31E4) == 90 && prior(dword(0xAC31E4)) == 225 && dword(0xAC31E8) == 0 &&
               prior(dword(0xAC31E8)) == 4784066 && dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 4259840 &&
               dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4718633)
)

achievement(
    title = "[c_Extra] Cracking Open the Past #2", points = 5,
    description = "Show off your egg collection to the barman's ancestor from chapter 6 onward - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Introduce the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward]",
    id = 313213, badge = "00000", published = "1/05/2023 15:18:04", modified = "1/05/2023 15:18:04",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 7) && 
              once(dword(0x1DF4280) == 828966670 && prior(dword(0x1DF4280)) == 4290904025 && dword(0x1DF6724) ==
               37814272 && prior(dword(0x1DF6724)) == 23599329 && dword(0x1DF81E5) == 2902991104 &&
               prior(dword(0x1DF81E5)) == 422724360 && dword(0xAC31E4) == 81 && prior(dword(0xAC31E4)) == 49 &&
               dword(0xAC3314) == 0 && prior(dword(0xAC3314)) == 524553) && once(dword(0x1DF59B0) == 4292005682 &&
               prior(dword(0x1DF59B0)) == 286335248 && dword(0x1DF81BA) == 3873378692 && prior(dword(0x1DF81BA)) ==
               268563921 && dword(0x1DFA4F8) == 63573 && prior(dword(0x1DFA4F8)) == 295 && dword(0xAC31E4) == 100 &&
               prior(dword(0xAC31E4)) == 145 && dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 4784128) && 
              once(dword(0x1DF742A) == 25 && prior(dword(0x1DF742A)) == 3470852618 && dword(0x1DF8B14) == 11468835 &&
               prior(dword(0x1DF8B14)) == 7602228 && dword(0x1DF5A0C) == 554829270 && prior(dword(0x1DF5A0C)) ==
               4003405333 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 67 && dword(0xAC31E8) == 0 &&
               prior(dword(0xAC31E8)) == 4784005)
)

achievement(
    title = "[c_Extra] The Pain of Parting #2", points = 5,
    description = "Consult the couple during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1584 during chapter 7]",
    id = 314753, badge = "00000", published = "5/05/2023 8:33:58", modified = "5/05/2023 8:33:58",
    trigger = unless((dword(0xA9EFDC) != 144816964 && dword(0xA9EFE4) != 144913364 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816952 && dword(0xA9EFE4) != 144913304 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816964 &&
               dword(0xA9EFE4) != 144913384 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144913304), 
                  once(dword(0xA9EFE4) == 144913364), 
                  once(dword(0xA9EFE4) == 144913384), 
              
               always_false()), when=repeated(100, byte(0xB95704) == 8) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra_GameOver] Bump... Erased", points = 5,
    description = "Run into yourself during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Meet yourself at the Brum's mansion during chapter 7]",
    id = 314763, badge = "00000", published = "5/05/2023 8:58:07", modified = "5/05/2023 8:58:07",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 8) && never(bit0(0xA9EB2C) == 1) && repeated(550,
               dword(0x1DF4280) == 11927552 && dword(0x1DF6F60) == 45023232 && dword(0x1DF9AA4) == 53226 &&
               dword(0x1DFA4F8) == 4294508544 && dword(0x1DF5950) == 5504967)
)

achievement(
    title = "[c_Completion] A Homonculus, a Red Stone and an Alchemist", points = 5,
    description = "Complete Chapter 3 - [DEV: Complete chapter 3]",
    id = 306921, badge = "00000", published = "5/04/2023 22:23:24", modified = "1/05/2023 15:19:57",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) &&
              ((unless(byte(0xB95704) != 4) && tally(3, 
                    once(dword(0x1DF4280) == 3633053830 && dword(0x1DF742A) == 4266471057 && dword(0x1DFA0E6) ==
                     29163641), 
                    once(dword(0x1DF5F71) == 286265625 && dword(0x1DF8B14) == 402187999 && dword(0x1DFB0F0) ==
                     18611287), 
                    once(dword(0x1DF59B0) == 10026577 && dword(0x1DF8229) == 4075192576 && dword(0x1DFB22B) ==
                     73728)
                ) && tally(2160, 
                    repeated(720, dword(0x1DF9362) == 4291626087 && prior(dword(0x1DF9362)) == 4245209089), 
                    repeated(720, dword(0x1DFA4F8) == 4244575277 && prior(dword(0x1DFA4F8)) == 59077), 
                    repeated(720, dword(0x1DFB0F0) == 421075232 && prior(dword(0x1DFB0F0)) == 1147172153)
                )) ||
               (prev(byte(0xB95704)) == 4 && byte(0xB95704) == 5))
)

achievement(
    title = "[c_Completion] Defied Fate", points = 5,
    description = "Complete the Prologue - [DEV: Complete the prologue]",
    id = 306884, badge = "00000", published = "5/04/2023 15:44:04", modified = "24/04/2023 18:47:40",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) &&
              ((unless(byte(0xB95704) != 1) && repeated(2010, prior(dword(0x1DFAC91)) == 1137019994) && repeated(2010,
                 prior(dword(0x1DFB0F0)) == 3314207892) && repeated(2010, prior(dword(0x1DFB22B)) == 570425580) && 
                repeated(2010, dword(0x1DFAC91) == 3622307327) && repeated(2010, dword(0x1DFB0F0) == 3470786308) && 
                repeated(2010, dword(0x1DFB22B) == 1241543936)) ||
               (prev(byte(0xB95704)) == 1 && byte(0xB95704) == 2))
)

achievement(
    title = "[c_Branch] A Performer's Clue", points = 5,
    description = "Receive a gift from a performer during chapter 1 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Acquire an egg from performer in chapter 1 at marktzplatz. First interact with the kid. Chose not to save his grandpa, then go back to the performer.]",
    id = 306885, badge = "00000", published = "5/04/2023 15:44:04", modified = "24/04/2023 18:47:40",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 2) && repeated(350,
               prior(dword(0x1DF8442)) == 4294869862) && repeated(350, prior(dword(0x1DF9AA4)) == 63779279) && 
              repeated(350, prior(dword(0x1DFA4F8)) == 286328215) && repeated(350, dword(0x1DF8442) == 484495965) && 
              repeated(350, dword(0x1DF9AA4) == 209984715) && repeated(350, dword(0x1DFA4F8) == 2576945433)
)

achievement(
    title = "[c_Completion] Defied Fate... Again", points = 5,
    description = "Complete Chapter 1 - [DEV: Complete chapter 1]",
    id = 306886, badge = "00000", published = "5/04/2023 15:44:05", modified = "24/04/2023 18:47:41",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) &&
              ((unless(byte(0xB95704) != 2) && repeated(610, prior(dword(0x1DFA0E6)) == 1358895514) && repeated(610,
                 prior(dword(0x1DFA4F8)) == 1094011894) && repeated(610, prior(dword(0x1DFAD9A)) == 6160384) && 
                repeated(610, dword(0x1DFA0E6) == 183081369) && repeated(610, dword(0x1DFA4F8) == 23652271) && 
                repeated(610, dword(0x1DFAD9A) == 8388872)) ||
               (prev(byte(0xB95704)) == 2 && byte(0xB95704) == 3))
)

achievement(
    title = "[c_Extra_GameOver] An Uncanny Familiarity", points = 5,
    description = "Keep chatting with Dana at the Marktplats tree during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Die 4 times to the tree killer while speaking to Dana in chapter 2]",
    id = 306888, badge = "00000", published = "5/04/2023 18:19:09", modified = "1/05/2023 15:19:58",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 3) && never(bit0(0xA9EB2C) == 1) && repeated(1400,
               dword(0xAC31E4) == 75) && once(prev(dword(0xAC31E4)) == 75 && dword(0xAC31E4) == 45) && 
              once(prev(dword(0xAC31E4)) == 45 && dword(0xAC31E4) == 30) && once(prev(dword(0xAC31E4)) == 240 &&
               dword(0xAC31E4) == 120) && once(prev(dword(0xAC31E4)) == 120 && dword(0xAC31E4) == 75) && 
              once(prev(dword(0xAC31E4)) == 180 && dword(0xAC31E4) == 75) && once(prev(dword(0xAC31E4)) == 120 &&
               dword(0xAC31E4) == 80) && once(prev(dword(0xAC31E8)) == 0 && dword(0xAC31E8) == 4259718) && 
              once(prev(dword(0xAC33E8)) == 0 && dword(0xAC33E8) == 5308368) && once(prev(dword(0xAC31E8)) == 0 &&
               dword(0xAC31E8) == 4784073) && once(prev(dword(0xAC32A8)) == 0 && dword(0xAC32A8) == 4718633) && 
              once(prev(dword(0xAC31E8)) == 0 && dword(0xAC31E8) == 4259742) && once(prev(dword(0xAC3314)) == 0 &&
               dword(0xAC3314) == 524297) && prior(dword(0xAC31E8)) == 4259771 && prior(dword(0xAC33E8)) == 5242949 && 
              prev(dword(0xAC31E4)) == 80
)

achievement(
    title = "[c_Extra] The Magician's Legacy", points = 3,
    description = "Become honored as a magician during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Select the cellphone to scare the people off in 1580 in chapter 2]",
    id = 306906, badge = "00000", published = "5/04/2023 19:28:48", modified = "24/04/2023 18:48:22",
    trigger = unless(once(byte(0xA9F111) == 15 && dword(0x1DFA0E6) == 75700022 && dword(0x1DFA4F8) == 1125822480 &&
               dword(0x1DFAD9A) == 82966958 && prior(dword(0xAC31E8)) == 4194143 && prior(dword(0xAC3538)) == 5308394 &&
               prior(dword(0xAC3658)) == 5243043 && dword(0xAC31E8) == 0 && dword(0xAC3538) == 0 && dword(0xAC3658) ==
               0)) && never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 3) && tally(470, 
                  repeated(200, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 1 && dword(0x1DF8B14) == 3294702597 &&
                   prior(dword(0x1DF8B14)) == 4288419440 && dword(0x1DFA4F8) == 0 && prior(dword(0x1DFA4F8)) ==
                   3313268930 && dword(0x1DFB0F0) == 4726 && prior(dword(0x1DFB0F0)) == 4230217814), 
                  repeated(270, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 1 && dword(0x1DF5F71) == 1342177280 &&
                   prior(dword(0x1DF5F71)) == 4266763007 && dword(0x1DF81BA) == 75628254 && prior(dword(0x1DF81BA)) ==
                   4224778707 && dword(0x1DF8B14) == 560593685 && prior(dword(0x1DF8B14)) == 3294702597)
              ) && trigger_when(tally(2024, 
                  repeated(1900, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 0 && dword(0x1DF81E5) == 2080374784 &&
                   dword(0x1DF9362) == 4252762112 && dword(0x1DF4280) == 4026466304), 
                  once(dword(0xAC31E4) == 258 && prior(dword(0xAC31E4)) == 405), 
                  once(dword(0xAC31E4) == 122 && prior(dword(0xAC31E4)) == 258), 
                  once(dword(0xAC31E4) == 48 && prior(dword(0xAC31E4)) == 122), 
                  once(dword(0xAC31E4) == 80 && prior(dword(0xAC31E4)) == 48), 
                  repeated(150, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 0 && dword(0xAC31E4) == 80 &&
                   dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 5111808 && dword(0xAC3314) == 0 &&
                   prior(dword(0xAC3314)) == 524293)
              ))
)

achievement(
    title = "[c_Extra] The Pyromancer's Legacy", points = 3,
    description = "Become honored as a pyrokinetic during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Select the lighter to scare the people off in 1580 in chapter 2]",
    id = 306911, badge = "00000", published = "5/04/2023 19:43:29", modified = "24/04/2023 18:48:22",
    trigger = unless(once(byte(0xA9F111) == 15 && dword(0x1DFA0E6) == 75700022 && dword(0x1DFA4F8) == 1125822480 &&
               dword(0x1DFAD9A) == 82966958 && prior(dword(0xAC31E8)) == 4194143 && prior(dword(0xAC3538)) == 5308394 &&
               prior(dword(0xAC3658)) == 5243043 && dword(0xAC31E8) == 0 && dword(0xAC3538) == 0 && dword(0xAC3658) ==
               0)) && never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 3) && tally(470, 
                  repeated(270, byte(0xA9F111) == 6 && prior(dword(0x1DF59B0)) == 3144021 && dword(0x1DF59B0) ==
                   269553938 && prior(dword(0x1DF6724)) == 3873309862 && dword(0x1DF6724) == 3734505288 &&
                   prior(dword(0x1DF742A)) == 285213706 && dword(0x1DF742A) == 306710048), 
                  repeated(200, byte(0xA9F111) == 6 && dword(0xAC31E4) == 35 && prior(dword(0xAC31E8)) == 4784075 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC32A8)) == 4784167 && dword(0xAC32A8) == 0)
              ) && trigger_when(tally(2024, 
                  repeated(1900, byte(0xA9F111) == 0 && dword(0x1DF81E5) == 2080374784 && dword(0x1DF9362) ==
                   4252762112 && dword(0x1DF4280) == 4026466304), 
                  once(dword(0xAC31E4) == 258 && prior(dword(0xAC31E4)) == 405), 
                  once(dword(0xAC31E4) == 122 && prior(dword(0xAC31E4)) == 258), 
                  once(dword(0xAC31E4) == 48 && prior(dword(0xAC31E4)) == 122), 
                  once(dword(0xAC31E4) == 80 && prior(dword(0xAC31E4)) == 48), 
                  repeated(150, byte(0xA9F111) == 0 && dword(0xAC31E4) == 80 && dword(0xAC326C) == 0 &&
                   prior(dword(0xAC326C)) == 5111808 && dword(0xAC3314) == 0 && prior(dword(0xAC3314)) == 524293)
              ))
)

achievement(
    title = "[c_Extra_GameOver] 'My my, so eager to die'", points = 1,
    description = "Run from the apparition during chapter 3 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: When meeting Homonculus, chose to excuse yourself, during chapter 3]",
    id = 306919, badge = "00000", published = "5/04/2023 22:23:23", modified = "1/05/2023 15:19:58",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 4) && tally(2, 
                  once(dword(0x1DF9AA4) == 4142399488 && prior(dword(0x1DF9AA4)) == 3901888802 && dword(0x1DFAC91)
                   == 1118698 && prior(dword(0x1DFAC91)) == 2231369728 && dword(0x1DFB0F0) == 4047835152 &&
                   prior(dword(0x1DFB0F0)) == 6817811 && dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4194231 &&
                   dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4128791 && dword(0xAC33E8) == 0 &&
                   prior(dword(0xAC33E8)) == 5308453), 
                  once(dword(0x1DF6F60) == 3491107089 && prior(dword(0x1DF6F60)) == 434099999 && dword(0x1DF81BA) ==
                   1048756820 && prior(dword(0x1DF81BA)) == 4250794336 && dword(0x1DF8B14) == 44891459 &&
                   prior(dword(0x1DF8B14)) == 113704869 && dword(0xAC31E4) == 105 && prior(dword(0xAC31E4)) == 175 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259721 && dword(0xAC326C) == 0 &&
                   prior(dword(0xAC326C)) == 4456448 && dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4325366), 
              
               always_false())
)

achievement(
    title = "[c_Extra] A Blossoming Plan", points = 3,
    description = "Planted flowers during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Choose to plant flowers, when talking to the town planter in 1580 in chapter 2]",
    id = 306920, badge = "00000", published = "5/04/2023 22:23:23", modified = "24/04/2023 18:47:42",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 3) && once(bit0(0xA9EB2C) == 0 && byte(0xA9F111) ==
               15 && dword(0x1DFA0E6) == 75700022 && dword(0x1DFA4F8) == 1125822480 && dword(0x1DFAD9A) == 82966958 &&
               prior(dword(0xAC31E8)) == 4194143 && dword(0xAC31E8) == 0 && prior(dword(0xAC3538)) == 5308394 &&
               dword(0xAC3538) == 0 && prior(dword(0xAC3658)) == 5243043 && dword(0xAC3658) == 0) && 
              trigger_when(tally(2024, 
                  repeated(1900, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 0 && dword(0x1DF81E5) == 2080374784 &&
                   dword(0x1DF9362) == 4252762112 && dword(0x1DF4280) == 4026466304), 
                  once(dword(0xAC31E4) == 258 && prior(dword(0xAC31E4)) == 405), 
                  once(dword(0xAC31E4) == 122 && prior(dword(0xAC31E4)) == 258), 
                  once(dword(0xAC31E4) == 48 && prior(dword(0xAC31E4)) == 122), 
                  once(dword(0xAC31E4) == 80 && prior(dword(0xAC31E4)) == 48), 
                  repeated(150, bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 0 && dword(0xAC31E4) == 80 &&
                   dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 5111808 && dword(0xAC3314) == 0 &&
                   prior(dword(0xAC3314)) == 524293)
              ))
)

achievement(
    title = "[c_Extra_GameOver] 'That's a big no no'", points = 5,
    description = "Warn yourself of your impending demise during the prologue - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Talk to yourself at cafe Sonné in the past during prologue]",
    id = 306883, badge = "00000", published = "5/04/2023 15:44:04", modified = "1/05/2023 15:19:58",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 1) && never(bit0(0xA9EB2C) == 1) && repeated(1050,
               prior(dword(0x1DF81E5)) == 1258802389) && repeated(1050, prior(dword(0x1DF5F71)) == 3758142976) && 
              repeated(1050, prior(dword(0x1DF8229)) == 2699486719) && repeated(1050, dword(0x1DF81E5) == 1375953920) && 
              repeated(1050, dword(0x1DF5F71) == 1207193634) && repeated(1050, dword(0x1DF8229) == 1610506217)
)

achievement(
    title = "[c_Completion] Left in the Past: An Unintended Consequence", points = 5,
    description = "Complete Chapter 2 - [DEV: Complete chapter 2]",
    id = 306922, badge = "00000", published = "5/04/2023 22:42:49", modified = "1/05/2023 15:19:57",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) &&
              ((unless(byte(0xB95704) != 3) && unless((dword(0x1DF59B0) != 75104066 && dword(0x1DF5A0C) != 4084397926 &&
                 dword(0x1DF5950) != 782296805)) && repeated(3, dword(0xB88AB0) < prev(dword(0xB88AB0)))) ||
               (prev(byte(0xB95704)) == 3 && byte(0xB95704) == 4))
)

achievement(
    title = "[c_Branch] A Mysterious Exchange #2", points = 5,
    description = "Give an ornamental egg to a barman during chapter 3 or 4 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Give the ornamental egg to the barman at his bar during chapter 3 or chapter 4]",
    id = 306976, badge = "00000", published = "6/04/2023 11:45:22", modified = "24/04/2023 18:47:40",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never((byte(0xB95704) != 4 && byte(0xB95704)
               != 5)) &&
              ((repeated(470, prior(dword(0x1DF81E5)) == 1759459584) && repeated(470, prior(dword(0x1DF9362)) == 6374) && 
                repeated(470, prior(dword(0x1DFAD9A)) == 107157922) && repeated(470, dword(0x1DF81E5) == 3573197306) && 
                repeated(470, dword(0x1DF9362) == 8126348) && repeated(470, dword(0x1DFAD9A) == 4280289740)) ||
               (repeated(470, prior(dword(0x1DFB22B)) == 33554432) && repeated(470, prior(dword(0x1DF9362)) ==
                 4262790840) && repeated(470, prior(dword(0x1DFAD9A)) == 42474741) && repeated(470, dword(0x1DFB22B) ==
                 67136000) && repeated(470, dword(0x1DF9362) == 11665417) && repeated(470, dword(0x1DFAD9A) ==
                 376444146)))
)

achievement(
    title = "[c_Branch] A Mysterious Exchange #1", points = 5,
    description = "Give an ornamental egg to a barman during chapter 1 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with t",
    id = 306977, badge = "00000", published = "6/04/2023 11:45:22", modified = "1/05/2023 15:19:57",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 2) && repeated(420,
               prior(dword(0x1DF8B14)) == 81132608) && repeated(420, prior(dword(0x1DFA0E6)) == 89130446) && 
              repeated(420, prior(dword(0x1DFAC91)) == 2282116640) && repeated(420, dword(0x1DF8B14) == 286331154) && 
              repeated(420, dword(0x1DFA0E6) == 51376747) && repeated(420, dword(0x1DFAC91) == 1169658)
)

achievement(
    title = "[c_Extra] Destined to Miss", points = 5,
    description = "Help a lost couple reunite during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 2]",
    id = 306984, badge = "00000", published = "6/04/2023 16:26:09", modified = "24/04/2023 18:47:43",
    trigger = unless((dword(0xA9EFDC) != 146372624 && dword(0xA9EFE4) != 144910844 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372612 && dword(0xA9EFE4) != 144910764 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372624 &&
               dword(0xA9EFE4) != 144910864 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 146372612 && dword(0xA9EFE4) != 144910784 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372624 && dword(0xA9EFE4) != 144910884 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372612 &&
               dword(0xA9EFE4) != 144910804 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144910764), 
                  once(dword(0xA9EFE4) == 144910844), 
                  once(dword(0xA9EFE4) == 144910784), 
                  once(dword(0xA9EFE4) == 144910864), 
                  once(dword(0xA9EFE4) == 144910804), 
                  once(dword(0xA9EFE4) == 144910884)
              ), when=repeated(100, byte(0xB95704) == 3) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Extra] Cracking Open the Past #1", points = 5,
    description = "Show off your egg collection to the barman's ancestor during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Show the ornamental egg to townplanter in 1580 in chapter 2]",
    id = 307023, badge = "00000", published = "6/04/2023 20:16:21", modified = "24/04/2023 18:47:43",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 3) && byte(0xA9F111)
               == 2 && repeated(500, prior(dword(0x1DFA0E6)) == 3873374568) && repeated(500, prior(dword(0x1DFA4F8)) ==
               23653402) && repeated(500, prior(dword(0x1DFAD9A)) == 480849724) && repeated(500, dword(0x1DFA0E6) ==
               11077697) && repeated(500, dword(0x1DFA4F8) == 25) && repeated(500, dword(0x1DFAD9A) == 0) && repeated(3,
               dword(0xB88AB0) < prev(dword(0xB88AB0)))
)

achievement(
    title = "[c_Extra] Memories of Past Love #1", points = 5,
    description = "Find the coated man and woman during the prologue or chapter 1 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during the prologue or chapter 1]",
    id = 307495, badge = "00000", published = "9/04/2023 8:08:50", modified = "24/04/2023 18:47:43",
    trigger = unless((dword(0xA9EFE4) != 144903124 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144902784 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144903144 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144902804 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && 
              prior(bit0(0xA9EB2C)) == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902804), 
                  once(dword(0xA9EFE4) == 144902784), 
                  once(dword(0xA9EFE4) == 144903124), 
                  once(dword(0xA9EFE4) == 144903144)
              ), when=bit0(0xA9F034) == 1 &&
               repeated(100, repeated(100, byte(0xB95704) == 1) || byte(0xB95704) == 2))
)

achievement(
    title = "[c_Extra] Strokes of Destiny", points = 4,
    description = "Admire all the paintings in the Brum Museum - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor]",
    id = 307499, badge = "00000", published = "9/04/2023 11:10:41", modified = "24/04/2023 18:47:44",
    trigger = unless((dword(0xA9EFE4) != 144908744 && dword(0xA9EFF4) != 355 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908804 && dword(0xA9EFF4) != 356 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908864 && dword(0xA9EFF4) != 357 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908924 && dword(0xA9EFF4) != 358 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908984 && dword(0xA9EFF4) != 359 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909024 && dword(0xA9EFF4) != 360 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909084 && dword(0xA9EFF4) != 361 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909124 && dword(0xA9EFF4) != 362 && bit0(0xA9EB2C) == 1)) && 
              prior(bit0(0xA9EB2C)) == 0 && measured(tally(8, 
                  once(dword(0xA9EFE4) == 144908744), 
                  once(dword(0xA9EFE4) == 144908804), 
                  once(dword(0xA9EFE4) == 144908864), 
                  once(dword(0xA9EFE4) == 144908924), 
                  once(dword(0xA9EFE4) == 144908984), 
                  once(dword(0xA9EFE4) == 144909024), 
                  once(dword(0xA9EFE4) == 144909084), 
                  once(dword(0xA9EFE4) == 144909124)
              ), when=repeated(100, byte(0xB95704) ==
               4) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Completion] Pan-tastic Resilience", points = 5,
    description = "Complete Chapter 4, using a frying pan - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Complete chapter 4, using a frying pan]",
    id = 308964, badge = "00000", published = "16/04/2023 17:01:09", modified = "24/04/2023 18:47:41",
    trigger = bit0(0xA9F034) == 1 && bit0(0xA9EB2C) == 0 && byte(0xA9F111) == 4 && prev(byte(0xB95704)) == 5 && 
              byte(0xB95704) == 6
)

achievement(
    title = "[c_Extra] Memories of Past Love #2", points = 5,
    description = "Find the coated man and woman during chapter 3 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 3]",
    trigger = unless((dword(0xA9EFDC) != 146379984 && dword(0xA9EFE4) != 144903184 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379972 && dword(0xA9EFE4) != 144902844 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379984 && dword(0xA9EFE4)
               != 144903204 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146379972 &&
               dword(0xA9EFE4) != 144902864 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902864), 
                  once(dword(0xA9EFE4) == 144902844), 
                  once(dword(0xA9EFE4) == 144903184), 
                  once(dword(0xA9EFE4) == 144903204)
              ), when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) ==
               4))
)

achievement(
    title = "[c_Extra] Timeless Antiques", points = 3,
    description = "Visit Antique Shop Eule and glance at the original relics - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Visit 'Antique shop Eule' and interact with all original relics, Shop is open in chapter 3, 4 and 6 (1980)]",
    trigger = unless((dword(0xA9EFDC) != 146380032 && dword(0xA9EFE4) != 144905744 && dword(0xA9EFF4) != 198 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146380044 && dword(0xA9EFE4) != 144905664 &&
               dword(0xA9EFF4) != 152 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146380020 &&
               dword(0xA9EFE4) != 144905784 && dword(0xA9EFF4) != 121 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 146380008 && dword(0xA9EFE4) != 144905704 && dword(0xA9EFF4) != 142 &&
               bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C)) == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144905744), 
                  once(dword(0xA9EFE4) == 144905664), 
                  once(dword(0xA9EFE4) == 144905784), 
                  once(dword(0xA9EFE4) == 144905704)
              ),
               when=bit0(0xA9F034) == 1 && repeated(100, repeated(100, byte(0xB95704) == 4) || repeated(100,
               byte(0xB95704) == 5) || byte(0xB95704) == 7))
)

achievement(
    title = "[c_Extra] The Place Where We Almost Met", points = 5,
    description = "Help a lost couple reunite again during chapter 3 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 3]",
    trigger = unless((dword(0xA9EFDC) != 144816496 && dword(0xA9EFE4) != 144911464 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816484 && dword(0xA9EFE4) != 144911384 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816496 &&
               dword(0xA9EFE4) != 144911484 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 144816484 && dword(0xA9EFE4) != 144911404 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816496 && dword(0xA9EFE4) != 144911504 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816484 &&
               dword(0xA9EFE4) != 144911424 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144911384), 
                  once(dword(0xA9EFE4) == 144911464), 
                  once(dword(0xA9EFE4) == 144911404), 
                  once(dword(0xA9EFE4) == 144911484), 
                  once(dword(0xA9EFE4) == 144911424), 
                  once(dword(0xA9EFE4) == 144911504)
              ), when=repeated(100, byte(0xB95704) == 4) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Extra] Memories of Past Love #3", points = 5,
    description = "Find the coated man and woman during chapter 4 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 4]",
    trigger = unless((dword(0xA9EFDC) != 146398348 && dword(0xA9EFE4) != 144903184 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398336 && dword(0xA9EFE4) != 144902904 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398348 && dword(0xA9EFE4)
               != 144903204 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146398336 &&
               dword(0xA9EFE4) != 144902924 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902924), 
                  once(dword(0xA9EFE4) == 144902904), 
                  once(dword(0xA9EFE4) == 144903184), 
                  once(dword(0xA9EFE4) == 144903204)
              ), when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) ==
               5))
)

achievement(
    title = "[c_Extra] Memories of Past Love #4", points = 5,
    description = "Find the coated man and woman during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 5]",
    trigger = unless((dword(0xA9EFDC) != 146396160 && dword(0xA9EFE4) != 144903324 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396148 && dword(0xA9EFE4) != 144903004 &&
               dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396148 && dword(0xA9EFE4)
               != 144903024 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144903004), 
                  once(dword(0xA9EFE4) == 144903024), 
                  once(dword(0xA9EFE4) == 144903324)
              ),
               when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) == 6))
)

achievement(
    title = "[c_Extra] The Pain of Parting", points = 3,
    description = "Consult the waiting man during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost man in 1584 during chapter 5]",
    trigger = unless((dword(0xA9EFDC) != 146396652 && dword(0xA9EFE4) != 144912844 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146396652 && dword(0xA9EFE4) != 144912864 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C)) == 0 && measured(tally(2, 
                  once(dword(0xA9EFE4) == 144912844), 
                  once(dword(0xA9EFE4) == 144912864), 
              
               always_false()), when=repeated(100, byte(0xB95704) == 6) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra] Nine Lives across Generations", points = 10,
    description = "Gift a feline to a girl during chapter 4, 5 or 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Take picture in chapter 4 or 5 => talk to Sibylla => talk to Eckart => give kitten before chapter 7]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never((byte(0xB95704) != 5 && byte(0xB95704)
               != 6 && byte(0xB95704) != 7)) && tally(2, 
                  once(dword(0x1DF6724) == 4282843299 && prior(dword(0x1DF6724)) == 119 && dword(0x1DF5A0C) ==
                   639826616 && prior(dword(0x1DF5A0C)) == 4190241152 && dword(0x1DFA0E6) == 3299332805 &&
                   prior(dword(0x1DFA0E6)) == 1483 && dword(0xAC31E4) == 55 && prior(dword(0xAC31E4)) == 76), 
                  once(dword(0x1DF7FA2) == 2290614289 && prior(dword(0x1DF7FA2)) == 113 && dword(0x1DFAD9A) ==
                   4142006270 && prior(dword(0x1DFAD9A)) == 4668751 && dword(0x1DF8B14) == 4283432940 &&
                   prior(dword(0x1DF8B14)) == 4251189880 && dword(0xAC31E4) == 76 && prior(dword(0xAC31E4)) == 115)
              ) && repeated(160, dword(0xAC31E4) == 0)
)

achievement(
    title = "[c_Extra] Destiny's Promise Fulfilled", points = 5,
    description = "Reunite the lost couple during chapter 4 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 4]",
    trigger = unless((dword(0xA9EFDC) != 144816568 && dword(0xA9EFE4) != 144912464 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816556 && dword(0xA9EFE4) != 144912384 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816568 &&
               dword(0xA9EFE4) != 144912484 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 144816556 && dword(0xA9EFE4) != 144912404 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816568 && dword(0xA9EFE4) != 144912504 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816556 &&
               dword(0xA9EFE4) != 144912424 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144912384), 
                  once(dword(0xA9EFE4) == 144912464), 
                  once(dword(0xA9EFE4) == 144912404), 
                  once(dword(0xA9EFE4) == 144912484), 
                  once(dword(0xA9EFE4) == 144912424), 
                  once(dword(0xA9EFE4) == 144912504)
              ), when=repeated(100, byte(0xB95704) == 5) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Extra] 'Picked up a baby the other day'", points = 5,
    description = "Uncover a snowy crime scene during chapter 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Discover a crime scene during the winter, in chapter 6]",
    trigger = unless(bit0(0xA9EB2C) == 1) && measured(tally(3, 
                  once(dword(0x1DF4280) == 36438193 && prior(dword(0x1DF4280)) == 347602734 && dword(0x1DF5F71) ==
                   15433216 && prior(dword(0x1DF5F71)) == 986653976 && dword(0x1DFAC91) == 637292055 &&
                   prior(dword(0x1DFAC91)) == 285288960 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 30 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4784086 && dword(0xAC326C) == 0 &&
                   prior(dword(0xAC326C)) == 4915200), 
                  once(dword(0x1DF6F60) == 4220911616 && prior(dword(0x1DF6F60)) == 62576 && dword(0x1DF81BA) ==
                   4020961374 && prior(dword(0x1DF81BA)) == 4169198535 && dword(0x1DF5A0C) == 335937536 &&
                   prior(dword(0x1DF5A0C)) == 4114682129 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 30 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4784112), 
                  once(dword(0x1DF5F71) == 1862270976 && dword(0x1DF8229) == 17 && dword(0x1DFAC91) == 171008 &&
                   dword(0x1DFB22B) == 3271797515 && dword(0x1DF5A0C) == 190846794)
              ), when=bit0(0xA9F034) == 1 &&
               byte(0xB95704) == 7)
)

achievement(
    title = "[c_Extra_GameOver] Time Ego Flop", points = 2,
    description = "View every possible movie poster during chapter 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: During chapter 6, co-direct Time Ego]",
    trigger = repeated(500, dword(0x1DF742A) == 4283630089 && prior(dword(0x1DF742A)) == 4284151374 && dword(0x1DFAC91)
               == 69120 && prior(dword(0x1DFAC91)) == 3271557120 && dword(0x1DFA0E6) == 3006992 &&
               prior(dword(0x1DFA0E6)) == 65441 && dword(0xAC31E4) == 50 && prior(dword(0xAC31E4)) == 128) && 
              repeated(30, dword(0xAC31E4) == 90 && prior(dword(0xAC31E4)) == 225 && dword(0xAC31E8) == 0 &&
               prior(dword(0xAC31E8)) == 4784066 && dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 4259840 &&
               dword(0xAC32A8) == 0 && prior(dword(0xAC32A8)) == 4718633)
)

achievement(
    title = "[c_Extra] Cracking Open the Past #2", points = 5,
    description = "Show off your egg collection to the barman's ancestor from chapter 6 onward - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Introduce the egg shaped pocket watch to the barman's ancestor in 1900's from chapter6 onward]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 7) && 
              once(dword(0x1DF4280) == 828966670 && prior(dword(0x1DF4280)) == 4290904025 && dword(0x1DF6724) ==
               37814272 && prior(dword(0x1DF6724)) == 23599329 && dword(0x1DF81E5) == 2902991104 &&
               prior(dword(0x1DF81E5)) == 422724360 && dword(0xAC31E4) == 81 && prior(dword(0xAC31E4)) == 49 &&
               dword(0xAC3314) == 0 && prior(dword(0xAC3314)) == 524553) && once(dword(0x1DF59B0) == 4292005682 &&
               prior(dword(0x1DF59B0)) == 286335248 && dword(0x1DF81BA) == 3873378692 && prior(dword(0x1DF81BA)) ==
               268563921 && dword(0x1DFA4F8) == 63573 && prior(dword(0x1DFA4F8)) == 295 && dword(0xAC31E4) == 100 &&
               prior(dword(0xAC31E4)) == 145 && dword(0xAC326C) == 0 && prior(dword(0xAC326C)) == 4784128) && 
              once(dword(0x1DF742A) == 25 && prior(dword(0x1DF742A)) == 3470852618 && dword(0x1DF8B14) == 11468835 &&
               prior(dword(0x1DF8B14)) == 7602228 && dword(0x1DF5A0C) == 554829270 && prior(dword(0x1DF5A0C)) ==
               4003405333 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 67 && dword(0xAC31E8) == 0 &&
               prior(dword(0xAC31E8)) == 4784005)
)

achievement(
    title = "[c_Extra] The Pain of Parting #2", points = 5,
    description = "Consult the couple during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1584 during chapter 7]",
    trigger = unless((dword(0xA9EFDC) != 144816964 && dword(0xA9EFE4) != 144913364 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816952 && dword(0xA9EFE4) != 144913304 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 144816964 &&
               dword(0xA9EFE4) != 144913384 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144913304), 
                  once(dword(0xA9EFE4) == 144913364), 
                  once(dword(0xA9EFE4) == 144913384), 
              
               always_false()), when=repeated(100, byte(0xB95704) == 8) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra_GameOver] Bump... Erased", points = 5,
    description = "Run into yourself during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Meet yourself at the Brum's mansion during chapter 7]",
    trigger = never(bit0(0xA9F034) == 0) && never(byte(0xB95704) != 8) && never(bit0(0xA9EB2C) == 1) && repeated(550,
               dword(0x1DF4280) == 11927552 && dword(0x1DF6F60) == 45023232 && dword(0x1DF9AA4) == 53226 &&
               dword(0x1DFA4F8) == 4294508544 && dword(0x1DF5950) == 5504967)
)

achievement(
    title = "[c_Branch] A Mysterious Exchange #1", points = 5,
    description = "Give an ornamental egg to a barman during chapter 1 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Give the ornamental egg to the barman before the fire happens during chapter 1. First go inside the bar then go back and forth in time + interact with t",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 2) && repeated(420,
               prior(dword(0x1DF8B14)) == 81132608) && repeated(420, prior(dword(0x1DFA0E6)) == 89130446) && 
              repeated(420, prior(dword(0x1DFAC91)) == 2282116640) && repeated(420, dword(0x1DF8B14) == 286331154) && 
              repeated(420, dword(0x1DFA0E6) == 51376747) && repeated(420, dword(0x1DFAC91) == 1169658)
)

achievement(
    title = "[c_Extra] Destined to Miss", points = 5,
    description = "Help a lost couple reunite during chapter 2 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in 1580 during chapter 2]",
    trigger = unless((dword(0xA9EFDC) != 146372624 && dword(0xA9EFE4) != 144910844 && dword(0xA9EFF4) != 407 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372612 && dword(0xA9EFE4) != 144910764 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372624 &&
               dword(0xA9EFE4) != 144910864 && dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFDC) != 146372612 && dword(0xA9EFE4) != 144910784 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372624 && dword(0xA9EFE4) != 144910884 &&
               dword(0xA9EFF4) != 407 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146372612 &&
               dword(0xA9EFE4) != 144910804 && dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && prior(bit0(0xA9EB2C))
               == 0 && measured(tally(6, 
                  once(dword(0xA9EFE4) == 144910764), 
                  once(dword(0xA9EFE4) == 144910844), 
                  once(dword(0xA9EFE4) == 144910784), 
                  once(dword(0xA9EFE4) == 144910864), 
                  once(dword(0xA9EFE4) == 144910804), 
                  once(dword(0xA9EFE4) == 144910884)
              ), when=repeated(100, byte(0xB95704) == 3) && bit0(0xA9F034)
               == 1)
)

achievement(
    title = "[c_Extra] Memories of Past Love #1", points = 5,
    description = "Find the coated man and woman during the prologue or chapter 1 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during the prologue or chapter 1]",
    trigger = unless((dword(0xA9EFE4) != 144903124 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144902784 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144903144 && dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144902804 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && 
              prior(bit0(0xA9EB2C)) == 0 && measured(tally(4, 
                  once(dword(0xA9EFE4) == 144902804), 
                  once(dword(0xA9EFE4) == 144902784), 
                  once(dword(0xA9EFE4) == 144903124), 
                  once(dword(0xA9EFE4) == 144903144)
              ), when=bit0(0xA9F034) == 1 &&
               repeated(100, repeated(100, byte(0xB95704) == 1) || byte(0xB95704) == 2))
)

achievement(
    title = "[c_Extra] Strokes of Destiny", points = 4,
    description = "Admire all the paintings in the Brum Museum - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with all 8 painting in the Brum Museum during chapter 3. They're on the 2nd floor + 1 on ground floor]",
    trigger = unless((dword(0xA9EFE4) != 144908744 && dword(0xA9EFF4) != 355 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908804 && dword(0xA9EFF4) != 356 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908864 && dword(0xA9EFF4) != 357 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908924 && dword(0xA9EFF4) != 358 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144908984 && dword(0xA9EFF4) != 359 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909024 && dword(0xA9EFF4) != 360 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909084 && dword(0xA9EFF4) != 361 && bit0(0xA9EB2C) == 1)) && 
              unless((dword(0xA9EFE4) != 144909124 && dword(0xA9EFF4) != 362 && bit0(0xA9EB2C) == 1)) && 
              prior(bit0(0xA9EB2C)) == 0 && measured(tally(8, 
                  once(dword(0xA9EFE4) == 144908744), 
                  once(dword(0xA9EFE4) == 144908804), 
                  once(dword(0xA9EFE4) == 144908864), 
                  once(dword(0xA9EFE4) == 144908924), 
                  once(dword(0xA9EFE4) == 144908984), 
                  once(dword(0xA9EFE4) == 144909024), 
                  once(dword(0xA9EFE4) == 144909084), 
                  once(dword(0xA9EFE4) == 144909124)
              ), when=repeated(100, byte(0xB95704) ==
               4) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra] A Hatchless Replica", points = 5,
    description = "Show off your egg collection to the barman during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Introduce the egg shaped pocket watch to the barman in 2001 during chapter 7]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 8) && tally(2, 
                  once(dword(0x1DF4280) == 1129103814 && prior(dword(0x1DF4280)) == 360792307 && dword(0x1DF6724) ==
                   3243254041 && prior(dword(0x1DF6724)) == 23597588 && dword(0x1DFAC91) == 2382364672 &&
                   prior(dword(0x1DFAC91)) == 3742950891 && dword(0xAC31E4) == 60 && prior(dword(0xAC31E4)) == 0 &&
                   dword(0xAC31E8) == 4784011 && prior(dword(0xAC31E8)) == 0 && dword(0xAC3314) == 524299 &&
                   prior(dword(0xAC3314)) == 0), 
                  once(dword(0x1DF5F71) == 2936020480 && prior(dword(0x1DF5F71)) == 2701082107 && dword(0x1DF8442)
                   == 1508245864 && prior(dword(0x1DF8442)) == 498463423 && dword(0x1DF5A0C) == 19332929 &&
                   prior(dword(0x1DF5A0C)) == 3806003788 && dword(0xAC31E4) == 60 && prior(dword(0xAC31E4)) == 140 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4783994 && dword(0xAC3314) == 0 &&
                   prior(dword(0xAC3314)) == 524292), 
              
               always_false()) && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 30
)

achievement(
    title = "[c_Extra] The Eggcellent Director's Tale", points = 5,
    description = "Reminisce about your egg collection with Eckart during chapter 8 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Talk to Eckart with the pocket watch in your inventory during chapter 8]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 9) && tally(3, 
                  once(dword(0x1DF742A) == 3898153250 && prior(dword(0x1DF742A)) == 8257661 && dword(0x1DF9362) ==
                   266994233 && prior(dword(0x1DF9362)) == 35652060 && dword(0x1DF5A0C) == 199491448 &&
                   prior(dword(0x1DF5A0C)) == 3365 && dword(0xAC31E4) == 54 && prior(dword(0xAC31E4)) == 74), 
                  once(dword(0x1DF6F60) == 3281637624 && prior(dword(0x1DF6F60)) == 106627072 && dword(0x1DFA0E6) ==
                   323872479 && prior(dword(0x1DFA0E6)) == 30408704 && dword(0x1DF81E5) == 3590364927 &&
                   prior(dword(0x1DF81E5)) == 2684487912 && dword(0xAC31E4) == 75 && prior(dword(0xAC31E4)) == 86 &&
                   dword(0xAC31E8) == 4259740 && prior(dword(0xAC31E8)) == 0 && dword(0xAC33E8) == 5242915 &&
                   prior(dword(0xAC33E8)) == 0), 
                  once(dword(0x1DF8229) == 16782336 && prior(dword(0x1DF8229)) == 2231369728 && dword(0x1DF9AA4) ==
                   119983600 && prior(dword(0x1DF9AA4)) == 10944310 && dword(0x1DF5950) == 44697310 &&
                   prior(dword(0x1DF5950)) == 4294834122 && dword(0xAC31E4) == 101 && prior(dword(0xAC31E4)) == 33 &&
                   dword(0xAC31E8) == 4784043 && prior(dword(0xAC31E8)) == 0 && dword(0xAC3314) == 524292 &&
                   prior(dword(0xAC3314)) == 0), 
              
               always_false()) && dword(0xAC31E4) == 0 && prev(dword(0xAC31E4)) == 150
)

achievement(
    title = "[c_Extra_GameOver] Fated to Plunge", points = 2,
    description = "Use an aged cable to save yourself in chapter 7 - [DEV: Try to save yourself with an old rope during chapter 7]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 8) && tally(4, 
                  once(dword(0x1DF81BA) == 4287574042 && prior(dword(0x1DF81BA)) == 3568559839 && dword(0x1DFA4F8)
                   == 1425014893 && prior(dword(0x1DFA4F8)) == 131596288 && dword(0x1DF81E5) == 1760436761 &&
                   prior(dword(0x1DF81E5)) == 605631181), 
                  once(dword(0x1DF9362) == 745178 && prior(dword(0x1DF9362)) == 48562351 && dword(0x1DFAC91) ==
                   628742 && prior(dword(0x1DFAC91)) == 2290649224 && dword(0x1DFB22B) == 4093639168 &&
                   prior(dword(0x1DFB22B)) == 2290714760), 
                  once(dword(0x1DFA0E6) == 4294363104 && prior(dword(0x1DFA0E6)) == 2880161028 && dword(0x1DFA4F8)
                   == 117899289 && prior(dword(0x1DFA4F8)) == 115738197 && dword(0x1DFB0F0) == 8913768 &&
                   prior(dword(0x1DFB0F0)) == 2559088784), 
                  once(dword(0x1DFA0E6) == 37159088 && prior(dword(0x1DFA0E6)) == 4280097073 && dword(0x1DFAD9A) ==
                   150541877 && prior(dword(0x1DFAD9A)) == 291568844 && dword(0x1DFB22B) == 1124520516 &&
                   prior(dword(0x1DFB22B)) == 419730436), 
              
               always_false())
)

achievement(
    title = "[c_Extra] Memories of Past Love #5", points = 5,
    description = "Find the coated man and woman in the present during chapter 7 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Find the coated couple in the present during chapter 7]",
    trigger = unless((dword(0xA9EFDC) != 146378164 && dword(0xA9EFE4) != 144903244 && dword(0xA9EFF4) != 87 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146378164 && dword(0xA9EFE4) != 144903264 &&
               dword(0xA9EFF4) != 87 && bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146378152 && dword(0xA9EFE4)
               != 144902964 && dword(0xA9EFF4) != 86 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144902964), 
                  once(dword(0xA9EFE4) == 144903244), 
                  once(dword(0xA9EFE4) == 144903264)
              ),
               when=bit0(0xA9F034) == 1 && repeated(100, byte(0xB95704) == 8))
)

achievement(
    title = "[c_Completion] A Friend's Repentance", points = 5,
    description = "Complete Chapter 7 - [DEV: Complete chapter 7]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) &&
              ((tally(820, 
                    once(dword(0x1DF742A) == 40701742 && prior(dword(0x1DF742A)) == 3873386039 && dword(0x1DF9362)
                     == 3873374899 && prior(dword(0x1DF9362)) == 273 && dword(0x1DFAC91) == 2080427008 &&
                     prior(dword(0x1DFAC91)) == 2449436669 && dword(0xAC31E4) == 61 && prior(dword(0xAC31E4)) == 90), 
                    once(dword(0x1DFA4F8) == 186777741 && prior(dword(0x1DFA4F8)) == 93257728 && dword(0x1DFB0F0) ==
                     60963 && prior(dword(0x1DFB0F0)) == 19398736 && dword(0x1DFB22B) == 419430401 &&
                     prior(dword(0x1DFB22B)) == 1862480641 && dword(0xAC31E4) == 70 && prior(dword(0xAC31E4)) == 73), 
                    once(dword(0x1DF6724) == 23533697 && prior(dword(0x1DF6724)) == 3873386253 && dword(0x1DF8B14)
                     == 70053855 && prior(dword(0x1DF8B14)) == 673 && dword(0x1DFB0F0) == 20645573 &&
                     prior(dword(0x1DFB0F0)) == 60963 && dword(0xAC31E4) == 42 && prior(dword(0xAC31E4)) == 137), 
                    repeated(817, dword(0x1DFA4F8) == 4286973247 && prior(dword(0x1DFA4F8)) == 4293459813 &&
                     dword(0x1DFAD9A) == 4246405016 && prior(dword(0x1DFAD9A)) == 4284153841 && dword(0x1DFB22B) ==
                     4006526464 && prior(dword(0x1DFB22B)) == 1107296257 && dword(0xAC31E4) == 0 &&
                     prior(dword(0xAC31E4)) == 42)
                )) ||
               (prev(byte(0xB95704)) == 8 && byte(0xB95704) == 9))
)

achievement(
    title = "[c_Extra] A Grandchild's Gambit", points = 5,
    description = "Discover the truth about the barman's grandchildren during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Uncover the truth about the barman's children during chapter 5]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 6) && tally(2, 
                  once(dword(0x1DF59B0) == 368377296 && prior(dword(0x1DF59B0)) == 825163784 && dword(0x1DF8229) ==
                   689414911 && prior(dword(0x1DF8229)) == 1174165243 && dword(0x1DFA0E6) == 20513106 &&
                   prior(dword(0x1DFA0E6)) == 96141312 && dword(0xAC31E4) == 41 && prior(dword(0xAC31E4)) == 61 &&
                   dword(0xAC31E8) == 4784046 && prior(dword(0xAC31E8)) == 0 && dword(0xAC3314) == 524293 &&
                   prior(dword(0xAC3314)) == 0), 
                  once(dword(0x1DF59B0) == 368377296 && prior(dword(0x1DF59B0)) == 825163784 && dword(0x1DF8229) ==
                   689414911 && prior(dword(0x1DF8229)) == 1174165243 && dword(0x1DFA0E6) == 20513106 &&
                   prior(dword(0x1DFA0E6)) == 96141312 && dword(0xAC31E4) == 116 && prior(dword(0xAC31E4)) == 82 &&
                   dword(0xAC31E8) == 4259719 && prior(dword(0xAC31E8)) == 0 && dword(0xAC33E8) == 5308396 &&
                   prior(dword(0xAC33E8)) == 0), 
              
               always_false()) && dword(0xAC31E4) == 0 && prev(dword(0xAC31E4)) == 80
)

achievement(
    title = "[c_Extra] The Barman's Grandchildren and The Mystery Child", points = 5,
    description = "Discover the truth about the barman's grandchildren during chapter 5 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Uncover the truth about the barman's children and the mystery child during chapter 5]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 6) && tally(2, 
                  once(dword(0x1DF59B0) == 368377296 && prior(dword(0x1DF59B0)) == 825163784 && dword(0x1DF8229) ==
                   689414911 && prior(dword(0x1DF8229)) == 1174165243 && dword(0x1DFA0E6) == 20513106 &&
                   prior(dword(0x1DFA0E6)) == 96141312 && dword(0xAC31E4) == 41 && prior(dword(0xAC31E4)) == 61 &&
                   dword(0xAC31E8) == 4784046 && prior(dword(0xAC31E8)) == 0 && dword(0xAC3314) == 524293 &&
                   prior(dword(0xAC3314)) == 0), 
                  once(dword(0x1DF59B0) == 368377296 && prior(dword(0x1DF59B0)) == 825163784 && dword(0x1DF8229) ==
                   689414911 && prior(dword(0x1DF8229)) == 1174165243 && dword(0x1DFA0E6) == 20513106 &&
                   prior(dword(0x1DFA0E6)) == 96141312 && dword(0xAC31E4) == 116 && prior(dword(0xAC31E4)) == 82 &&
                   dword(0xAC31E8) == 4259719 && prior(dword(0xAC31E8)) == 0 && dword(0xAC33E8) == 5308396 &&
                   prior(dword(0xAC33E8)) == 0), 
              
               always_false()) && dword(0xAC31E4) == 0 && prev(dword(0xAC31E4)) == 80
)

achievement(
    title = "[c_Extra] Never Destined to Meet", points = 5,
    description = "Advise the young man in The Middle Ages during chapter 8 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Interact with the lost couple in Middle Ages during chapter 8]",
    trigger = unless((dword(0xA9EFDC) != 146420892 && dword(0xA9EFE4) != 144913984 && dword(0xA9EFF4) != 408 &&
               bit0(0xA9EB2C) == 1)) && unless((dword(0xA9EFDC) != 146420892 && dword(0xA9EFE4) != 144914004 &&
               dword(0xA9EFF4) != 408 && bit0(0xA9EB2C) == 1)) && measured(tally(3, 
                  once(dword(0xA9EFE4) == 144913984), 
                  once(dword(0xA9EFE4) == 144914004)
              ),
               when=repeated(100, byte(0xB95704) == 9) && bit0(0xA9F034) == 1)
)

achievement(
    title = "[c_Extra] Temporal Guardian of the Brums", points = 10,
    description = "Save a member of the Brum family from a predestined death during chapter 6 - [Tips available: bit.ly/ShadowOfDestiny] - [DEV: Save Miriam Brum in chapter 6]",
    trigger = unless(bit0(0xA9EB2C) == 1) && measured(tally(4, 
                  once(cutsceneId23() == 1179011410 && prior(cutsceneId23()) == 438063929 && cutsceneId24() ==
                   2680488803 && prior(cutsceneId24()) == 294830896 && cutsceneId25() == 1635105460 &&
                   prior(cutsceneId25()) == 1147455375 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 90 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259794 && dword(0xAC32A8) == 0 &&
                   prior(dword(0xAC32A8)) == 5308344), 
                  once(cutsceneId23() == 1794008121 && prior(cutsceneId23()) == 2428791865 && cutsceneId24()
                   == 1051035817 && prior(cutsceneId24()) == 1539975836 && cutsceneId25() == 1958576480 &&
                   prior(cutsceneId25()) == 4168720682 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 60 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259820 && dword(0xAC32A8) == 0 &&
                   prior(dword(0xAC32A8)) == 5308357), 
                  once(cutsceneId23() == 1179011410 && cutsceneId24() == 1670435758 && cutsceneId25() ==
                   4229563482 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 135 && dword(0xAC31E8) == 0 &&
                   prior(dword(0xAC31E8)) == 4259783 && dword(0xAC3314) == 0 && prior(dword(0xAC3314)) == 524298), 
                  once(dword(0x1DF4280) == 1803555089 && dword(0x1DF81BA) == 161216080 && dword(0x1DFAC91) ==
                   1379869489 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 190 && dword(0xAC31E8) == 0 &&
                   prior(dword(0xAC31E8)) == 4259731 && dword(0xAC33E8) == 0 && prior(dword(0xAC33E8)) == 5308382)
              ), when=bit0(0xA9F034) == 1 &&
               byte(0xB95704) == 7)
)

achievement(
    title = "[c_Completion] The Brums Happily Ever After", points = 10,
    description = "Complete Chapter 7, whilst having saved a member of the Brum family in Chapter 6 - [DEV: Complete chapter 7, whilst having saved Miriam in chapter 6]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 8) && tally(3, 
                  once(dword(0x1DF59B0) == 3873309032 && prior(dword(0x1DF59B0)) == 3873832783 && dword(0x1DF742A)
                   == 3873438136 && prior(dword(0x1DF742A)) == 997 && dword(0x1DFB22B) == 67072 &&
                   prior(dword(0x1DFB22B)) == 3119784707 && dword(0xAC31E4) == 76 && prior(dword(0xAC31E4)) == 29 &&
                   dword(0xAC31E8) == 4784052 && prior(dword(0xAC31E8)) == 0 && dword(0xAC32A8) == 4784173 &&
                   prior(dword(0xAC32A8)) == 0), 
                  once(dword(0x1DF6F60) == 273 && prior(dword(0x1DF6F60)) == 3811246167 && dword(0x1DF8229) ==
                   1342506774 && prior(dword(0x1DF8229)) == 1040187392 && dword(0x1DFAC91) == 806152934 &&
                   prior(dword(0x1DFAC91)) == 3305129201 && dword(0xAC31E4) == 126 && prior(dword(0xAC31E4)) == 228 &&
                   dword(0xAC326C) == 4980736 && prior(dword(0xAC326C)) == 0 && dword(0xAC33E8) == 5242893 &&
                   prior(dword(0xAC33E8)) == 0), 
                  once(dword(0x1DF4280) == 295103877 && prior(dword(0x1DF4280)) == 273 && dword(0x1DFB0F0) ==
                   15925248 && prior(dword(0x1DFB0F0)) == 7864320 && cutsceneId24() == 1414549185 &&
                   prior(cutsceneId24()) == 2134506814 && dword(0xAC31E4) == 27 && prior(dword(0xAC31E4)) == 129 &&
                   dword(0xAC32A8) == 4194343 && prior(dword(0xAC32A8)) == 0 && dword(0xAC33E8) == 5242917 &&
                   prior(dword(0xAC33E8)) == 0), 
              
               always_false()) && dword(0x1DF6724) == 23533697 && prior(dword(0x1DF6724)) == 230883257 && 
              dword(0x1DFB0F0) == 20645573 && prior(dword(0x1DFB0F0)) == 15925248 && cutsceneId25() == 1166889242 && 
              prior(cutsceneId25()) == 170023170 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 107 && 
              dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259749 && dword(0xAC326C) == 0 && 
              prior(dword(0xAC326C)) == 4128768
)

achievement(
    title = "[c_Completion] The Whole Picture... Or is it?", points = 5,
    description = "Complete Chapter 8 - [DEV: Complete chapter 8]",
    trigger = bit0(0xA9F034) == 1 && bit0(0xA9EB2C) == 0 && prev(byte(0xB95704)) == 9 && byte(0xB95704) == 10
)

achievement(
    title = "[c_Endings] 'But still without a sense of finality'", points = 10,
    description = "Achieve ending B2 - [DEV: Ending B2: Margarette (Ancestress) => Fortuneteller => Town Square]",
    trigger = never(bit0(0xA9F034) == 0) && never(bit0(0xA9EB2C) == 1) && never(byte(0xB95704) != 10) && 
              never(dword((dword(0xAC3170) & 0x1FFFFFF) + 0xF8000004) != 1) && tally(3, 
                  once(dword(0x1DF4280) == 4293132167 && prior(dword(0x1DF4280)) == 286261459 && dword(0x1DF7FA2) ==
                   286331153 && prior(dword(0x1DF7FA2)) == 384898035 && dword(0x1DF81E5) == 69905 &&
                   prior(dword(0x1DF81E5)) == 2483301912 && dword(0xAC31E4) == 148 && prior(dword(0xAC31E4)) == 295 &&
                   dword(0xAC31E8) == 4259760 && prior(dword(0xAC31E8)) == 0 && dword(0xAC33E8) == 5242923 &&
                   prior(dword(0xAC326C)) == 0), 
                  once(dword(0x1DF59B0) == 4215138563 && prior(dword(0x1DF59B0)) == 1041941 && dword(0x1DF81BA) ==
                   3502898668 && prior(dword(0x1DF81BA)) == 4269355492 && dword(0x1DF5A0C) == 3475367687 &&
                   prior(dword(0x1DF5A0C)) == 1179493143 && dword(0xAC31E4) == 130 && prior(dword(0xAC31E4)) == 0 &&
                   dword(0xAC31E8) == 4259757 && prior(dword(0xAC31E8)) == 0 && dword(0xAC3314) == 524295 &&
                   prior(dword(0xAC3314)) == 0), 
                  once(dword(0x1DF5F71) == 2399187456 && prior(dword(0x1DF5F71)) == 278528 && dword(0x1DF8229) ==
                   1357223935 && prior(dword(0x1DF8229)) == 3442727238 && dword(0x1DFB22B) == 1 &&
                   prior(dword(0x1DF5A0C)) == 2708721990 && dword(0xAC31E4) == 0 && prior(dword(0xAC31E4)) == 120 &&
                   dword(0xAC31E8) == 0 && prior(dword(0xAC31E8)) == 4259744 && dword(0xAC32A8) == 524295 &&
                   prior(dword(0xAC32A8)) == 4194309)
              )
)
