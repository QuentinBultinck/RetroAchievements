// Shadow of Destiny
// #ID = 3945

achievement(
    title = "Defied Fate", points = 5, type="progression",
    description = "Complete the prologue",
    id = 306884, badge = "461667", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 1 && dword(0xA9ECBC) == 140416 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 113872 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 3600
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 1 && dword(0xA9ECBC) == 592832 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 110192 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 482576
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 1 && byte(0xB95704) == 2))
)

achievement(
    title = "That's a big no no.", points = 2, type="missable",
    description = "Warn yourself of your impending demise during the prologue",
    id = 306883, badge = "461699", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:45",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 1) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 39936 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 39920 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 39920 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 60016
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 39936 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44640
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "Defied Fate... Again", points = 5, type="progression",
    description = "Complete chapter 1",
    id = 306886, badge = "461654", published = "5/04/2023 15:44:05", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 2 && dword(0xA9ECBC) == 72256 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 48800 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 23424
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 2 && byte(0xB95704) == 3))
)

achievement(
    title = "A Performer's Clue", points = 1, type="missable",
    description = "Receive a gift from a performer during chapter 1",
    id = 306885, badge = "461653", published = "5/04/2023 15:44:04", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 2) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 103296 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 8 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 24160 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 79088
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "There's a fire!", points = 4, type="missable",
    description = "Alert the young boy's grandpa of imminent disaster during chapter 1",
    id = 306976, badge = "461648", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((byte(0xB95704) != 4 && byte(0xB95704) != 5)) &&
              tally(1,
                  once(byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 && byte(0xB95704) == 4 && dword(0xA9ECBC) == 205312 &&
                  word(0xA9ECC0) == 7 && word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 149984),
                  once(byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 195008 &&
                  word(0xA9ECC0) == 7 && word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 149984)
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "A Jovial Exchange", points = 4, type="missable",
    description = "Exchange an egg for a pan during chapter 1, 3 or 4",
    id = 306977, badge = "461650", published = "6/04/2023 11:45:22", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 2) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && bit0(0xA9F036) == 1 && dword(0xA9ECBC) == 195008 && word(0xA9ECC0) == 7 &&
                  word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 21504 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 149984
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Enigmatic Couple I: Prelude", points = 3, type="missable",
    description = "Find the coated man and woman in the present during the prologue or chapter 1",
    id = 307495, badge = "461690", published = "9/04/2023 8:08:50", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never((byte(0xB95704) != 1 && byte(0xB95704) != 2)) &&
              measured(tally(4, repeated(2,
                  byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                  byte(0xA9EE28) > prev(byte(0xA9EE28)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 716), repeated(2,
                  byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                  byte(0xA9EE1D) > prev(byte(0xA9EE1D)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 705))
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Enigmatic Couple II: Tailing", points = 3, type="missable",
    description = "Find the coated man and woman in the present during chapter 3",
    id = 310131, badge = "461691", published = "19/04/2023 11:41:41", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 4) && trigger_when(byte(0xA9ED26) != 1) &&
              ((measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE20) > prev(byte(0xA9EE20)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708))
                )) ||
               (measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE20) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 708))
                )))
)

achievement(
    title = "Enigmatic Couple III: Wandering Once More", points = 3, type="missable",
    description = "Find the coated man and woman in the present during chapter 4",
    id = 310134, badge = "461692", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) && trigger_when(byte(0xA9ED26) == 0) &&
              ((measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2C) > prev(byte(0xA9EE2C)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE21) > prev(byte(0xA9EE21)) && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709))
                )) ||
               (measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2C) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 720), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE21) == 2 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 709))
                )))
)

achievement(
    title = "Enigmatic Couple IV: Origins", points = 3, type="missable",
    description = "Find the coated man and woman in the present during chapter 5",
    id = 310135, badge = "461693", published = "19/04/2023 15:36:31", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) && trigger_when(byte(0xA9ED26) == 0) &&
              ((measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE31) > prev(byte(0xA9EE31)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 0 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE26) > prev(byte(0xA9EE26)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE31) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 0 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE26) == 2 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 714))
                )) ||
               (measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE31) > prev(byte(0xA9EE31)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE25) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 713))
                )) ||
               (measured(tally(3,
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE31) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 725), repeated(2,
                    byte(0xA9ED26) == 1 && bit5(0xA9EDAA) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE25) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 713))
                )))
)

achievement(
    title = "Enigmatic Couple V: Epilogue", points = 3, type="missable",
    description = "Find the coated man and woman in the present during chapter 7",
    id = 315564, badge = "461694", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) && trigger_when(byte(0xA9ED26) == 0) &&
              ((measured(tally(3, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 &&
                    byte(0xA9EE2F) > prev(byte(0xA9EE2F)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 723),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 &&
                    byte(0xA9EE24) > prev(byte(0xA9EE24)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 712))
                )) ||
               (measured(tally(3, repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 87 && byte(0xA9EE2F) == 2 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 723),
                    once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 86 && byte(0xA9EE24) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 712))
                )))
)

achievement(
    title = "Left in the Past", points = 5, type="progression",
    description = "Complete chapter 2",
    id = 306922, badge = "461655", published = "5/04/2023 22:42:49", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 3 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 242240 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 3 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 242240 &&
                    word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 70208 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 688
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 3 && byte(0xB95704) == 4))
)

achievement(
    title = "Cracking Open the Past: Middle Ages", points = 3, type="missable",
    description = "Show off your egg collection to the barman's ancestor during chapter 2",
    id = 307023, badge = "461725", published = "6/04/2023 20:16:21", modified = "7/05/2023 18:07:30",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 2 && dword(0xA9ECBC) == 56832 && word(0xA9ECC0) == 3 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 10704 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 46080
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Terror of Destinies", points = 4, type="missable",
    description = "Frighten everyone in the past and a person indulging in spaghetti during chapter 2",
    id = 404046, badge = "461722", published = "2/03/2024 21:18:08", modified = "2/03/2024 21:18:08",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) && trigger_when(byte(0xA9ED26) == 0) &&
              (always_false() || (unless((dword(0xA82E48) != 828 && dword(0xA82E48) != 16)) &&
                measured(tally(7,
                    once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 1 && dword(0xA9ECBC) == 36864 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 36864 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 24448 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 36864), repeated(4,
                    byte(0xA9ED26) == 5 && byte(0xA9F111) == 1 && dword(0xA9ECBC) == 814592 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 23248 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 21936 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2380192 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 21936), repeated(4,
                    byte(0xA9ED26) == 5 && byte(0xA9F111) == 6 && dword(0xA9ECBC) == 689344 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 11840 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 45600 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2315504 &&
                    dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 45600),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 1 && byte(0xA9EE70) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 788),
                    once((byte(0xA9F111) == 6 || byte(0xA9F111) == 1) && byte(0xA9ED26) == 1 && byte(0xA9EE3F) == 1 &&
                    prev(byte(0xA9EE3F)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 739)), when=low4(0xA9EDDC) != 0 && byte(0xB95704) == 3
                )))
)

achievement(
    title = "Met You Before", points = 2, type="missable",
    description = "Keep chatting with Dana at the Marktplatz tree during chapter 2",
    id = 306888, badge = "461701", published = "5/04/2023 18:19:09", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 451712 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 283216 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 82928
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 112448 && prior(dword(0xA9ECBC)) == 451712 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 7424 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 104992
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "A Blossoming Plan", points = 1, type="missable",
    description = "Planted flowers during chapter 2",
    id = 306920, badge = "461683", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:44",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 1 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 242240 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "The Pyromancer's Legacy", points = 1, type="missable",
    description = "Become honored as a pyrokinetic during chapter 2",
    id = 306911, badge = "461685", published = "5/04/2023 19:43:29", modified = "7/05/2023 18:07:28",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 0 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 &&
                  dword(0xA9ECBC) == 242240 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "The Magician's Legacy", points = 1, type="missable",
    description = "Become honored as a magician during chapter 2",
    id = 306906, badge = "461684", published = "5/04/2023 19:28:48", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(bit2(0xA9EDA0) == 0 && bit1(0xA9EDA0) == 1 && byte(0xA9ED26) == 5 && byte(0xA9F111) == 0 &&
                  dword(0xA9ECBC) == 242240 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 213216 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 28976
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "Yesteryears Couple I: Destined to Miss", points = 4, type="missable",
    description = "Help a lost young couple reunite in The Middle Ages during chapter 2",
    id = 306984, badge = "461706", published = "6/04/2023 16:26:09", modified = "7/05/2023 18:07:29",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 3) &&
              measured(tally(6,
                  once((byte(0xA9EF89) == 0 || byte(0xA9EF89) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF7C) == 1 && prev(byte(0xA9EF7C)) == 0 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1056),
                  once((byte(0xA9EF89) == 0 || byte(0xA9EF89) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF69) == 1 && prev(byte(0xA9EF69)) == 0 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1037),
                  once((byte(0xA9EF89) == 1 || byte(0xA9EF89) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF7D) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1057),
                  once((byte(0xA9EF89) == 1 || byte(0xA9EF89) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6A) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1038),
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF89) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 &&
                  byte(0xA9EF7E) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1058),
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF89) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                  byte(0xA9EF6B) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1039)), when=dword(0xA82E48) == 828
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Yesteryears Couple II: The Place Where We Nigh Met", points = 4, type="missable",
    description = "Help a lost young couple reunite again in The Middle Ages during chapter 3",
    id = 310133, badge = "461707", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 4) &&
              measured(tally(6,
                  once(byte(0xA9EF8A) == 0 || byte(0xA9EF8A) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF7E) > prev(byte(0xA9EF7E) &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1059),
                  once(byte(0xA9EF8A) == 0 || byte(0xA9EF8A) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6C) > prev(byte(0xA9EF6C) &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1040),
                  once(byte(0xA9EF8A) == 1 || byte(0xA9EF8A) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF80) > prev(byte(0xA9EF80) &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1060),
                  once(byte(0xA9EF8A) == 1 || byte(0xA9EF8A) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6D) > prev(byte(0xA9EF6D) &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1041),
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF8A) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 &&
                  byte(0xA9EF81) > prev(byte(0xA9EF81)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1061),
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF8A) == 3 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                  byte(0xA9EF6E) > prev(byte(0xA9EF6E)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1042)), when=dword(0xA82E48) == 828
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Yesteryears Couple III: Destiny's Promise Fulfilled", points = 4, type="missable",
    description = "Reunite the lost young couple in The Middle Ages during chapter 4",
    id = 309393, badge = "461708", published = "17/04/2023 19:03:08", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
              measured(tally(6,
                  once((byte(0xA9EF8B) == 0 || byte(0xA9EF8B) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF82) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1062),
                  once((byte(0xA9EF8B) == 0 || byte(0xA9EF8B) == 1) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF6F) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1043),
                  once((byte(0xA9EF8B) == 1 || byte(0xA9EF8B) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF83) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1063),
                  once((byte(0xA9EF8B) == 1 || byte(0xA9EF8B) == 2) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF70) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1044),
                  once((byte(0xA9EF8B) == 2 || byte(0xA9EF8B) == 3) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF84) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1064),
                  once((byte(0xA9EF8B) == 2 || byte(0xA9EF8B) == 3) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && byte(0xA9EF71) == 1 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1045)),
                  when=dword(0xA82E48) == 828
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Yesteryears Couple IV: Man-in-waiting", points = 1, type="missable",
    description = "Consult the young man in The Middle Ages during chapter 5",
    id = 310162, badge = "461709", published = "19/04/2023 19:39:22", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
              measured(repeated(2,
                  byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                  byte(0xA9EF72) > prev(byte(0xA9EF72)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 75 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1046)
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Yesteryears Couple V: Parting", points = 2, type="missable",
    description = "Consult the young couple in The Middle Ages during chapter 7",
    id = 314753, badge = "461710", published = "5/05/2023 8:33:58", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) && trigger_when(byte(0xA9ED26) == 0) &&
              ((measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF84) == 1 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF74) > prev(byte(0xA9EF74)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1
                )) ||
               (measured(tally(4, repeated(2,
                    byte(0xA9ED26) == 1 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    dword(dword(0xA9EFDC) & 0x1FFFFFF) == 407 && byte(0xA9EF85) == 2 &&
                    dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1065), repeated(2,
                    byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                    byte(0xA9EF74) > prev(byte(0xA9EF74)) && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 59 &&
                    dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1048)), when=bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0
                )))
)

achievement(
    title = "Yesteryears Couple VI: Never Destined to Meet", points = 10, type="missable",
    description = "Advise the young man in The Middle Ages during chapter 8",
    id = 315568, badge = "461711", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
              measured(tally(2,
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 &&
                  byte(0xA9EF78) == 1 && prev(byte(0xA9EF78)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1052),
                  once(byte(0xA9ED26) == 1 && byte(0xA9EF8E) >= 1 && bit0(0xA9EF8F) == 1 && bit1(0xA9EF8F) == 0 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 408 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 19 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 1075)), when=dword(0xA82E48) == 1011
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Energy Locator: Present Day", points = 5, type="missable",
    description = "Collect all 5 energy orbs in present day Lebensbaum",
    id = 399816, badge = "461689", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless(bit2(0xA9EDA5) == 1) &&
              unless((dword(0xA82E48) != 885 && dword(0xA82E48) != 68 && dword(0xA82E48) != 3)) &&
              measured(repeated(5,
                  byte(0xA9DAA8) > prev(byte(0xA9DAA8)) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(byte(0xAC31EE)) == 0 && prior(dword_be(0xAC31F2)) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && byte(0xA9ED26) != 5), when=low4(0xA9EDDC) != 0
              ) &&
              (always_false() || (never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && never(byte(0xB95704) != prev(byte(0xB95704)))))
)

achievement(
    title = "Energy Locator: Middle Ages", points = 5, type="missable",
    description = "Collect all 5 energy orbs in medieval Lebensbaum",
    id = 399819, badge = "461688", published = "19/02/2024 14:12:17", modified = "19/02/2024 14:12:17",
    trigger = never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
              (always_false() || (unless((dword(0xA82E48) != 1011 && dword(0xA82E48) != 828 && dword(0xA82E48) != 535 &&
                    dword(0xA82E48) != 142)
                ) &&
                measured(repeated(6,
                    byte(0xA9DAA8) > prev(byte(0xA9DAA8)) && prior(dword(0xAC32B8)) != 0 &&
                    prior(dword_be(0xAC32C2)) != 0 && prior(byte(0xAC31EE)) == 0 &&
                    prior(dword_be(0xAC31F2)) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                    prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                    prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                    prior(dword_be(0xAC32A2)) == 4588544 && byte(0xA9ED26) != 5), when=low4(0xA9EDDC) != 0
                )))
)

achievement(
    title = "Energy Locator: The Late 20th Century", points = 5, type="missable",
    description = "Collect all 5 energy orbs in Lebensbaum during the 70's or 80's",
    id = 399817, badge = "461687", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = unless((dword(0xA82E48) != 1125 && dword(0xA82E48) != 797)) &&
              measured(repeated(5,
                  byte(0xA9DAA8) > prev(byte(0xA9DAA8)) && prior(dword(0xAC32B8)) != 0 && prior(dword_be(0xAC32C2)) != 0 &&
                  prior(byte(0xAC31EE)) == 0 && prior(dword_be(0xAC31F2)) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                  prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                  prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                  prior(dword_be(0xAC32A2)) == 4588544 && byte(0xA9ED26) != 5), when=low4(0xA9EDDC) != 0
              ) &&
              (always_false() || (never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && never(byte(0xB95704) != prev(byte(0xB95704)))))
)

achievement(
    title = "Energy Locator: The Early 20th Century", points = 5, type="missable",
    description = "Collect all 5 energy orbs in Lebensbaum, a century ago",
    id = 399818, badge = "461686", published = "19/02/2024 14:12:16", modified = "19/02/2024 14:12:16",
    trigger = never(byte(0xA9DAA8) < prev(byte(0xA9DAA8))) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
              never((bit2(0xA9EDA5) == 1 && dword(0xA82E48) == 885)) &&
              (always_false() || (unless((dword(0xA82E48) != 569 && dword(0xA82E48) != 1539)) &&
                measured(repeated(5,
                    byte(0xA9DAA8) > prev(byte(0xA9DAA8)) && prior(dword(0xAC32B8)) != 0 &&
                    prior(dword_be(0xAC32C2)) != 0 && prior(byte(0xAC31EE)) == 0 &&
                    prior(dword_be(0xAC31F2)) == 1207961856 && prior(byte(0xAC321E)) == 31 &&
                    prior(dword_be(0xAC3222)) == 1211631872 && prior(byte(0xAC326E)) == 75 &&
                    prior(dword_be(0xAC3272)) == 1213466881 && prior(byte(0xAC329E)) == 108 &&
                    prior(dword_be(0xAC32A2)) == 4588544 && byte(0xA9ED26) != 5), when=low4(0xA9EDDC) != 0
                )))
)

achievement(
    title = "Stockpiling Across Eras", points = 10, type="missable",
    description = "Acquire the biggest hoard of items in a single playthrough",
    id = 402404, badge = "461712", published = "25/02/2024 19:47:49", modified = "25/02/2024 19:47:49",
    trigger = never((dword(0x1FFF5F8) == 17 && byte(0x1FFF604) > 0 && dword(0x1FFF604) < 5)) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(bit0(0xA9F042) != prev(bit0(0xA9F042))) && never(bit0(0xA9F045) != prev(bit0(0xA9F045))) &&
              never(bit0(0xA9F03B) != prev(bit0(0xA9F03B))) && never(bit0(0xA9F03C) != prev(bit0(0xA9F03C))) &&
              never(bit0(0xA9F047) != prev(bit0(0xA9F047))) && never(bit0(0xA9F035) != prev(bit0(0xA9F035))) &&
              never(bit0(0xA9F041) != prev(bit0(0xA9F041))) && never(bit0(0xA9F034) != prev(bit0(0xA9F034))) &&
              never(bit0(0xA9F044) != prev(bit0(0xA9F044))) && never(bit0(0xA9F038) != prev(bit0(0xA9F038))) &&
              never(bit0(0xA9F040) != prev(bit0(0xA9F040))) && never(bit0(0xA9F04B) != prev(bit0(0xA9F04B))) &&
              never(bit0(0xA9F048) != prev(bit0(0xA9F048))) && never(bit0(0xA9F04D) != prev(bit0(0xA9F04D))) &&
              never(bit0(0xA9F050) != prev(bit0(0xA9F050))) && never(bit0(0xA9F03A) != prev(bit0(0xA9F03A))) &&
              never(bit0(0xA9F04C) != prev(bit0(0xA9F04C))) && never(bit0(0xA9F046) != prev(bit0(0xA9F046))) &&
              never(bit0(0xA9F03E) != prev(bit0(0xA9F03E))) && never(bit0(0xA9F04F) != prev(bit0(0xA9F04F))) &&
              never(bit0(0xA9F04E) != prev(bit0(0xA9F04E))) && never(bit0(0xA9F03F) != prev(bit0(0xA9F03F))) &&
              never(bit0(0xA9F036) != prev(bit0(0xA9F036))) && never(bit0(0xA9F03D) != prev(bit0(0xA9F03D))) &&
              never(bit0(0xA9F04A) != prev(bit0(0xA9F04A))) && never(bit0(0xA9F039) != prev(bit0(0xA9F039))) &&
              never(bit0(0xA9F043) != prev(bit0(0xA9F043))) && never(bit0(0xA9F049) != prev(bit0(0xA9F049))) &&
              measured(tally(20, once(bit0(0xA9F042) == 1), once(bit0(0xA9F045) == 1), once(bit0(0xA9F03B) == 1),
                  once(bit0(0xA9F03C) == 1), once(bit0(0xA9F047) == 1), once(bit0(0xA9F035) == 1),
                  once(bit0(0xA9F041) == 1), once(bit0(0xA9F034) == 1), once(bit0(0xA9F044) == 1),
                  once(bit0(0xA9F038) == 1), once(bit0(0xA9F040) == 1), once(bit0(0xA9F04B) == 1),
                  once(bit0(0xA9F048) == 1), once(bit0(0xA9F04D) == 1), once(bit0(0xA9F050) == 1),
                  once(bit0(0xA9F03A) == 1), once(bit0(0xA9F04C) == 1), once(bit0(0xA9F046) == 1),
                  once(bit0(0xA9F03E) == 1), once(bit0(0xA9F04F) == 1), once(bit0(0xA9F04E) == 1),
                  once(bit0(0xA9F03F) == 1), once(bit0(0xA9F036) == 1), once(bit0(0xA9F03D) == 1),
                  once(bit0(0xA9F04A) == 1), once(bit0(0xA9F039) == 1), once(bit0(0xA9F043) == 1),
                  once(bit0(0xA9F049) == 1))
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "An Alchemist, a Jewel and a Homunculus", points = 5, type="progression",
    description = "Complete chapter 3",
    id = 306921, badge = "461656", published = "5/04/2023 22:23:24", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 4 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 105856 &&
                    word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 33440 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 72384
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 4 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 850752 &&
                    prior(dword(0xA9ECBC)) == 105856 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 14832 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 231328
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 4 && byte(0xA9F111) == 0 && dword(0xA9ECBC) == 235136 &&
                    prior(dword(0xA9ECBC)) == 850752 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 32272 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 31904
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 4 && byte(0xB95704) == 5))
)

achievement(
    title = "Running Beyond the 90's... and 80's", points = 2, type="missable",
    description = "Encounter an athletic man in the past as well as his present self during chapter 3, 4 or 5",
    id = 405086, badge = "461720", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never(low4(0xA9EDDC) == 0) && never((byte(0xB95704) != 4 && byte(0xB95704) != 5 && byte(0xB95704) != 6)) &&
              measured(tally(2,
                  once((dword(0xA82E48) == 885 || dword(0xA82E48) == 68 || dword(0xA82E48) == 3) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 88),
                  once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 797 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 89))
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Strokes of Destiny", points = 1, type="missable",
    description = "Admire all the paintings in the Brum Museum",
    id = 307499, badge = "461675", published = "9/04/2023 11:10:41", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
              trigger_when(byte(0xA9ED26) == 0) &&
              measured(tally(8,
                  once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297),
                  once((dword(0xA82E48) == 320 || dword(0xA82E48) == 205) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 361 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                  once((dword(0xA82E48) == 320 || dword(0xA82E48) == 205) && byte(0xA9ED26) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 359 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295))
              )
)

achievement(
    title = "That's nice!", points = 1, type="missable",
    description = "Pique someone's interest with an oval shape of your own in the 1980's",
    id = 407681, badge = "461719", published = "13/03/2024 14:05:48", modified = "13/03/2024 14:05:48",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once((byte(0xA9F111) == 16 || byte(0xA9F111) == 2) && byte(0xA9ED26) == 1 && dword(0xA82E48) == 15 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 12 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 749 &&
                  byte(0xA9EE49) == 1
              ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Timeless Antiques", points = 2, type="missable",
    description = "Take a glance at the timeless relics at Antique Shop Eule",
    id = 310132, badge = "461674", published = "19/04/2023 12:50:26", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never(byte(0xB95704) != prev(byte(0xB95704))) && trigger_when(byte(0xA9ED26) != 1) &&
              measured(tally(4,
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 142 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 152 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 121 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 198 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 4294967295)),
                  when=(dword(0xA82E48) == 122 || dword(0xA82E48) == 111)
              )
)

achievement(
    title = "My my, so eager to die.", points = 1, type="missable",
    description = "Run from the apparition during chapter 3",
    id = 306919, badge = "461700", published = "5/04/2023 22:23:23", modified = "7/05/2023 18:07:41",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 4) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 45376 && prior(dword(0xA9ECBC)) == 371328 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 23232 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14512
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 107584 && prior(dword(0xA9ECBC)) == 45376 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 55712 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 51792
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "Time-Spun Sweets", points = 4, type="missable",
    description = "Gift a tasty sweet to a someone dear to you",
    id = 402296, badge = "461704", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xA9F111) != 19) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1093632 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 711488 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 382112
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Legacy of Sweetness", points = 3, type="missable",
    description = "Establish a new line of pastries",
    id = 402297, badge = "461715", published = "25/02/2024 12:43:23", modified = "25/02/2024 12:43:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xA9F111) != 19) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 130432 && word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 130384 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 86992 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 74416
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Pan-tastic Resilience", points = 3, type="progression",
    description = "Complete Chapter 4, using a frying pan",
    id = 308964, badge = "461657", published = "16/04/2023 17:01:09", modified = "7/05/2023 18:07:31",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xA9F111) != 4) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 324096 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 72912 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 251136
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 345472 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 94304 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 5008
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6))
)

achievement(
    title = "Through the Lens of Survival", points = 3, type="progression",
    description = "Complete Chapter 4, using a sign",
    id = 310149, badge = "461658", published = "19/04/2023 16:09:53", modified = "7/05/2023 18:07:25",
    trigger = never(low4(0xA9EDDC) == 0) && never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xA9F111) != 5) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && dword(0xA9ECBC) == 345472 && word(0xA9ECC0) == 13 &&
                    word(0xA9ECC2) == 14 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 46816 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44624
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 5 && byte(0xB95704) == 6))
)

achievement(
    title = "Nine Lives across Generations", points = 4, type="missable",
    description = "Gift a feline to a girl during or after chapter 4",
    id = 310426, badge = "461728", published = "20/04/2023 18:06:14", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1539 && bit0(0xA9F04B) == 1 && dword(0xA9ECBC) == 152064 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 11264 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 67888
              ) && bit6(0xA9EDCB) == 1 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Even I can do that.", points = 4, type="missable",
    description = "Become a performer during chapter 4",
    id = 402284, badge = "461649", published = "25/02/2024 11:33:55", modified = "25/02/2024 11:33:55",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(prev(dword(0xA9ECBC)) != dword(0xA9ECBC)) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && byte(0xA9F111) == 12 && bit2(0xA9EDA5) == 1 &&
                  dword(0xA9ECBC) == 107264 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14848
              ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
              trigger_when(byte(0xA9ED26) != 0)
)

achievement(
    title = "A Performance Gone the Extra Mile", points = 5, type="missable",
    description = "Make sure the performer goes the extra mile for those who would appreciate his gesture, including yourself",
    id = 403575, badge = "461716", published = "29/02/2024 15:31:22", modified = "29/02/2024 15:31:22",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) && never(repeated(300, bit2(0xA9EDA5) == 0)) &&
              measured(tally(7,
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 391 && byte(0xA9EEF8) == 2 &&
                  prev(byte(0xA9EEF8)) == 1 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 924),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 70 && byte(0xA9EE92) == 1 &&
                  prev(byte(0xA9EE92)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 822),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 66 && byte(0xA9EE7F) == 1 &&
                  prev(byte(0xA9EE7F)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 803),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 68 && byte(0xA9EE88) == 1 &&
                  prev(byte(0xA9EE88)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 68 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 812),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 405 && dword(0xA82E48) == 22 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 41 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 966),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 387 && dword(0xA82E48) == 22 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 41 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 972),
                  once(byte(0xA9ED26) == 5 && byte(0xB95704) == 5 && byte(0xA9F111) == 12 && dword(0xA9ECBC) == 107264 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54336 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 14848))
              ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
              trigger_when(byte(0xA9ED26) != 0)
)

achievement(
    title = "Complexities of the Fourth Dimension", points = 4, type="missable",
    description = "Get lectured in time-travelling physics during chapter 4",
    id = 310163, badge = "461679", published = "19/04/2023 19:40:38", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              tally(1,
                  once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 4 && dword(0xA9ECBC) == 721152 && word(0xA9ECC0) == 13 &&
                  word(0xA9ECC2) == 14 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 126896 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44656),
                  once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 5 && dword(0xA9ECBC) == 721152 && word(0xA9ECC0) == 13 &&
                  word(0xA9ECC2) == 14 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 125600 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44656)
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Horologic Heritage", points = 2, type="missable",
    description = "Kindle the joy of watchmaking to an ancestor of the Franssen's",
    id = 405460, badge = "461726", published = "6/03/2024 15:30:06", modified = "6/03/2024 15:30:06",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((byte(0xB95704) != 7 && byte(0xB95704) != 8 && byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
              once(byte(0xA9ED26) == 5 && byte(0xA9F111) == 16 && dword(0xA9ECBC) == 70848 && word(0xA9ECC0) == 65535 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 70816 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 44368 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 70816
              ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Pan in Advance", points = 3, type="missable",
    description = "Acquire an iron plate before finding a good usage for it",
    id = 403823, badge = "461724", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 5) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xA9F111) != 4) && never(bit0(0xA9F03B) == 1) && never(bit0(0xA9F03C) == 1) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 324096 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 72912 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 251136
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Ancient Elixir", points = 5, type="progression",
    description = "Complete Chapter 5",
    id = 311616, badge = "461659", published = "25/04/2023 18:57:11", modified = "7/05/2023 18:07:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 6 && byte(0xA9F111) == 17 && dword(0xA9ECBC) == 260480 &&
                    word(0xA9ECC0) == 65535 && word(0xA9ECC2) == 0 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 260480 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 260480
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 6 && byte(0xB95704) == 7))
)

achievement(
    title = "A Complimentary Dinner", points = 3, type="missable",
    description = "Enjoy a free supper at Bar Zum Ei during chapter 5",
    id = 405461, badge = "461695", published = "6/03/2024 15:30:07", modified = "6/03/2024 15:30:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 6) && never((bit5(0xA9ED9D) == 1 && bit7(0xA9ED9D) == 0)) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 403520 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 156064 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27840 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 638304 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 27840
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 1023168 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 24240 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 998896 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2812512 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 998896
              ) && trigger_when(prev(byte(0xA9ED26)) > 3) && trigger_when(byte(0xA9ED26) <= 3) &&
              trigger_when(byte(0xA9ED26) != 0)
)

achievement(
    title = "A Mother's Child", points = 2, type="missable",
    description = "Find Hugo outside his house during chapter 5",
    id = 311466, badge = "461705", published = "24/04/2023 18:48:54", modified = "7/05/2023 18:07:24",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 257280 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 12560 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 244672 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 2632416 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 244672
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "The Barman's Mystery Child", points = 3, type="missable",
    description = "Discover the truth about the barman's grandchildren during chapter 5",
    id = 315567, badge = "461678", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 6) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 852480 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 250512 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 601904
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "Art Muse", points = 3, type="missable",
    description = "Inspire an acclaimed artist and appraise his work",
    id = 403824, badge = "461676", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) && never(bit5(0xA9EDAA) == 1) &&
              trigger_when(byte(0xA9ED26) == 0) &&
              tally(1,
                  once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297)
              )
)

achievement(
    title = "Eike Franssen", points = 5, type="missable",
    description = "Become a beacon of inspiration for an acclaimed artist and appraise all his works",
    id = 403825, badge = "461677", published = "2/03/2024 0:38:26", modified = "2/03/2024 0:38:26",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != prev(byte(0xB95704))) &&
              trigger_when(byte(0xA9ED26) == 0) &&
              measured(tally(6,
                  once((dword(0xA82E48) == 50 || dword(0xA82E48) == 749) && byte(0xA9ED26) == 1 && bit4(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 355 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 292),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit5(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 356 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 293),
                  once((dword(0xA82E48) == 345 || dword(0xA82E48) == 56) && byte(0xA9ED26) == 1 && bit6(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 357 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 294),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit7(0xA9EDB0) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 362 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 295),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit0(0xA9EDB1) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 358 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 296),
                  once((dword(0xA82E48) == 548 || dword(0xA82E48) == 445) && byte(0xA9ED26) == 1 && bit1(0xA9EDB1) == 1 &&
                  dword(dword(0xA9EFDC) & 0x1FFFFFF) == 360 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 297))
              )
)

achievement(
    title = "Director's Cut: Trip for Two", points = 3, type="progression",
    description = "Complete Chapter 6, by co-directing a love picture",
    id = 313210, badge = "461660", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit2(0xA9EDB8) == 1 && bit1(0xA9EDB8) == 0 &&
              ((once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 645952 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8))
)

achievement(
    title = "Director's Cut: The Time of Reckoning", points = 3, type="progression",
    description = "Complete Chapter 6, by co-directing a thriller picture",
    id = 313211, badge = "461661", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:27",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit1(0xA9EDB8) == 1 && bit2(0xA9EDB8) == 0 &&
              ((once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 645952 && word(0xA9ECC0) == 7 && word(0xA9ECC2) == 8 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 419328 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 134352
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 7 && byte(0xB95704) == 8))
)

achievement(
    title = "Time Ego Flop", points = 1, type="missable",
    description = "View every possible movie poster during chapter 6",
    id = 313212, badge = "461703", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 7) &&
              once(byte(0xA9ED26) == 5 && bit6(0xA9EDB7) == 1 && bit5(0xA9EDB7) == 0 && bit7(0xA9EDB7) == 1 &&
                  bit0(0xA9EDB8) == 1 && dword(0xA9ECBC) == 489856 && word(0xA9ECC0) == 10 && word(0xA9ECC2) == 11 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 8336 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 89424
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "Cracking Open the Past: The Old Century", points = 4, type="missable",
    description = "Show off your egg collection to the barman's ancestor from chapter 6 onward",
    id = 313213, badge = "461682", published = "1/05/2023 15:18:04", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((byte(0xB95704) != 7 && byte(0xB95704) != 8 && byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
              tally(1,
                  once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 570432 && word(0xA9ECC0) == 5 &&
                  word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 371744 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 122480 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 913376 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 181200),
                  once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 569 && dword(0xA9ECBC) == 705728 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 371744 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 122480 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 519216 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 194352)
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "Illusive Guardian of the Brums", points = 4, type="missable",
    description = "Save a member of the Brum family from a predestined death during chapter 6",
    id = 315569, badge = "461721", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 7) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && dword(0xA9ECBC) == 965312 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 345840 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 20656
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "The Meditating Man", points = 1, type="missable",
    description = "Find someone who has also met the meditating man in chapter 6",
    id = 405098, badge = "461723", published = "5/03/2024 14:02:39", modified = "5/03/2024 14:02:39",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 7) &&
              once(byte(0xA9ED26) == 1 && dword(0xA82E48) == 21 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 397 &&
                  dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 && dword(dword(0xA9EFE4) & 0x1FFFFFF) == 999 &&
                  byte(0xA9EF43) > prev(byte(0xA9EF43))
              ) && trigger_when(prev(byte(0xA9ED26)) != 0) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Picked up a baby the other day.", points = 2, type="missable",
    description = "Uncover a snowy crime scene during chapter 6",
    id = 313209, badge = "461727", published = "1/05/2023 15:18:03", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 7) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA82E48) == 1125 && dword(0xA9ECBC) == 480960 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 18016 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 324112 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 756624 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 324112
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "A Friend's Repentance", points = 5, type="progression",
    description = "Complete Chapter 7",
    id = 315565, badge = "461665", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:08:33",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 8 && dword(0xA9ECBC) == 274496 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 31968 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 55616
                ) &&
                tally(1,
                    once(byte(0xA9ED26) == 5 && byte(0xB95704) == 8 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
                    dword(0xA9ECBC) == 813056 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 284448 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 445648),
                    once(byte(0xA9ED26) == 5 && byte(0xB95704) == 8 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 &&
                    dword(0xA9ECBC) == 859072 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 294912 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 373136)
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 8 && dword(0xA9ECBC) == 73792 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 3296 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 70448
                ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 8 && (byte(0xB95704) == 9 || byte(0xB95704) == 11)))
)

achievement(
    title = "Fated to Plunge", points = 1, type="missable",
    description = "Use an aged cable to save yourself in chapter 7",
    id = 315563, badge = "461702", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 87616 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 6 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 30768 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 8736
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 145344 && prior(dword(0xA9ECBC)) == 87616 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 100656 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 44640
              ) && prev(byte(0xA9ED26)) > 3 && byte(0xA9ED26) <= 3 && byte(0xA9ED26) != 0
)

achievement(
    title = "The Next Big Thing", points = 4, type="missable",
    description = "Inspire the movie director for a 2nd time in chapter 7",
    id = 404045, badge = "461713", published = "2/03/2024 21:18:07", modified = "2/03/2024 21:18:07",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 8) &&
              once(byte(0xA9ED26) == 5 && bit3(0xA9EDCC) == 1 && dword(0xA9ECBC) == 659264 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 283504 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 375696 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 588000 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 375696
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "A Pair of Delinquents", points = 2, type="missable",
    description = "Encounter some rascals in chapter 7",
    id = 404048, badge = "461680", published = "2/03/2024 22:13:05", modified = "2/03/2024 22:13:05",
    trigger = never(dword(0xA82E48) != 68) &&
              measured(tally(2,
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 19 && byte(0xA9EE51) == 1 &&
                  prev(byte(0xA9EE51)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 757),
                  once(byte(0xA9ED26) == 1 && dword(dword(0xA9EFDC) & 0x1FFFFFF) == 16 && byte(0xA9EE4C) == 1 &&
                  prev(byte(0xA9EE4C)) == 0 && dword(dword(0xA9EFE0) & 0x1FFFFFF) == 178 &&
                  dword(dword(0xA9EFE4) & 0x1FFFFFF) == 752)), when=low4(0xA9EDDC) != 0
              ) && trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "Bump... Erased", points = 1, type="missable",
    description = "Run into yourself during chapter 7",
    id = 314763, badge = "461698", published = "5/05/2023 8:58:07", modified = "7/05/2023 18:07:40",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once((dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 147168) &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 227296 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x00002C) == 147120
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "A Hatchless Replica", points = 4, type="missable",
    description = "Show off your egg collection to the barman during chapter 7",
    id = 315561, badge = "461717", published = "7/05/2023 18:08:31", modified = "7/05/2023 18:08:31",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never(byte(0xB95704) != 8) &&
              once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 577152 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 312832 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 145056 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 460352 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 145056
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "The Brums Happily Ever After", points = 10, type="missable",
    description = "Meet Eckart's wife in Chapter 7",
    id = 315570, badge = "461714", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) && never(byte(0xB95704) != 8) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && dword(0xA9ECBC) == 274496 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 31968 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 55616
              ) &&
              tally(1,
                  once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && dword(0xA9ECBC) == 817472 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 29712),
                  once(byte(0xA9ED26) == 5 && bit6(0xA9EDAE) == 0 && bit7(0xA9EDAE) == 1 && dword(0xA9ECBC) == 730432 &&
                  word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 38336 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27888)
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "The whole picture... Or is it?", points = 5, type="progression",
    description = "Complete Chapter 8",
    id = 315571, badge = "461666", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:08:34",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              ((once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 570944 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 185408 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 272208
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 1109760 && word(0xA9ECC0) == 9 &&
                    word(0xA9ECC2) == 8 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 46624 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 62672
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 935936 && word(0xA9ECC0) == 9 &&
                    word(0xA9ECC2) == 10 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 420512 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 381024
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 873536 && word(0xA9ECC0) == 7 &&
                    word(0xA9ECC2) == 6 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 267600 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 177184
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 464576 && word(0xA9ECC0) == 9 &&
                    word(0xA9ECC2) == 10 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 145904 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 106224
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 998528 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 597040 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 401456
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 1031424 && word(0xA9ECC0) == 5 &&
                    word(0xA9ECC2) == 4 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 392960 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 159536
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 806464 &&
                    prior(dword(0xA9ECBC)) == 1031424 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 403024 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 27616
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 9 && dword(0xA9ECBC) == 117696 && word(0xA9ECC0) == 5 &&
                    word(0xA9ECC2) == 4 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 51424 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 39152
                ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 11 && dword(0xA9ECBC) == 490048 &&
                    prior(dword(0xA9ECBC)) == 169728 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 204752 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 285200
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 11 && dword(0xA9ECBC) == 307520 &&
                    prior(dword(0xA9ECBC)) == 490048 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 4 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 74416 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 100848
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 11 && dword(0xA9ECBC) == 824384 &&
                    prior(dword(0xA9ECBC)) == 655552 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 289616 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 534688
                ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (once(byte(0xA9ED26) == 5 && byte(0xB95704) == 11 && dword(0xA9ECBC) == 1055680 && word(0xA9ECC0) == 1 &&
                    word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 489760 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 468432
                ) &&
                once(byte(0xA9ED26) == 5 && byte(0xB95704) == 11 && dword(0xA9ECBC) == 1275136 &&
                    prior(dword(0xA9ECBC)) == 1055680 && word(0xA9ECC0) == 12 && word(0xA9ECC2) == 13 &&
                    dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 507376 &&
                    dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 348816
                ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
                bit7(0xA9EDAE) == 1 && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0) ||
               (prev(byte(0xB95704)) == 9 && byte(0xB95704) == 10) ||
               (prev(byte(0xB95704)) == 11 && byte(0xB95704) == 12))
)

achievement(
    title = "The Eggcellent Director's Tale", points = 4, type="missable",
    description = "Reminisce about your egg collection with Eckart during chapter 8",
    id = 315562, badge = "461718", published = "7/05/2023 18:08:32", modified = "7/05/2023 18:08:32",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) && never((byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
              once(byte(0xA9ED26) == 5 && bit0(0xA9F044) == 1 && dword(0xA9ECBC) == 580800 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 203408 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 42016 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 916416 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 42016
              ) && prev(byte(0xA9ED26)) != 0 && byte(0xA9ED26) == 0
)

achievement(
    title = "An End to a Strange Experience", points = 5, type="win_condition",
    description = "Achieve Ending A",
    id = 315566, badge = "461668", published = "7/05/2023 18:08:33", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 0
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 898944 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 7088 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 208096
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 491392 &&
                  prior(dword(0xA9ECBC)) == 898944 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 154704 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 109712
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1154) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "No Sense of Finality I", points = 5, type="win_condition",
    description = "Achieve Ending B1",
    id = 315573, badge = "461669", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 398272 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 277936 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 120272
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 352832 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1155) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "No Sense of Finality II", points = 5, type="win_condition",
    description = "Achieve Ending B2",
    id = 315572, badge = "461670", published = "7/05/2023 18:08:34", modified = "7/05/2023 18:23:18",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 1
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 594496 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 381632 &&
                  prior(dword(0xA9ECBC)) == 594496 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 126928 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 352832 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 262352 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 90416
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1155) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "If only... I had one more attempt.", points = 5, type="win_condition",
    description = "Achieve Ending C",
    id = 317118, badge = "461671", published = "14/05/2023 10:33:35", modified = "14/05/2023 10:33:35",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 2
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 577280 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 279360 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 269520
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 504128 &&
                  prior(dword(0xA9ECBC)) == 577280 && word(0xA9ECC0) == 3 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 120112 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 194256
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 10 && dword(0xA9ECBC) == 833280 &&
                  prior(dword(0xA9ECBC)) == 504128 && word(0xA9ECC0) == 5 && word(0xA9ECC2) == 6 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 6528 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 125136
              ) && bit6(0xA9EDAE) == 1 && bit7(0xA9EDAE) == 0 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1155) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Eike's Origins", points = 5, type="win_condition",
    description = "Achieve Ending D",
    id = 322230, badge = "461672", published = "28/05/2023 11:34:23", modified = "28/05/2023 11:34:23",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 3
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 12 && dword(0xA9ECBC) == 461248 && word(0xA9ECC0) == 3 &&
                  word(0xA9ECC2) == 4 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 149360 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 71568
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 12 && dword(0xA9ECBC) == 809792 && word(0xA9ECC0) == 3 &&
                  word(0xA9ECC2) == 4 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 432960 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 138048
              ) && bit1(0xA9EDC4) == 0 && bit3(0xA9EDC4) == 0 && bit4(0xA9EDC4) == 0 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1157) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The future is what we make it.", points = 5, type="win_condition",
    description = "Achieve Ending E",
    id = 322231, badge = "461673", published = "28/05/2023 11:34:26", modified = "28/05/2023 11:34:26",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 4
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 12 && dword(0xA9ECBC) == 560576 && word(0xA9ECC0) == 3 &&
                  word(0xA9ECC2) == 2 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 181152 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 379392
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 12 && dword(0xA9ECBC) == 782208 && word(0xA9ECC0) == 9 &&
                  word(0xA9ECC2) == 8 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 368480 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 87520
              ) &&
              once(byte(0xA9ED26) == 5 && byte(0xB95704) == 12 && dword(0xA9ECBC) == 842944 &&
                  prior(dword(0xA9ECBC)) == 782208 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 2 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 209456 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 137088
              ) && bit1(0xA9EDC4) == 1 && bit3(0xA9EDC4) == 1 && bit4(0xA9EDC4) == 1 && bit6(0xA9EDAE) == 0 &&
              bit7(0xA9EDAE) == 1 &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1158) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Philosopher's Wisdom", points = 1, type="missable",
    description = "Acquire one last message during the EX chapter",
    id = 405112, badge = "461653", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              once(byte(0xA9ED26) == 5 && bit0(0xAA1154) == 1 && bit0(0xAA1155) == 1 && bit0(0xAA1156) == 1 &&
                  bit0(0xAA1157) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1159) == 1 && bit7(0xA9ED98) == 1 &&
                  byte(0xB95704) == 1 && dword(0xA9ECBC) == 198528 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 54768 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 3600 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 523536 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 3600
              ) && trigger_when(bit0(0xA9F036) == 1) && trigger_when(prev(byte(0xA9ED26)) != 0) &&
              trigger_when(byte(0xA9ED26) == 0)
)

achievement(
    title = "The Philosopher's Destiny", points = 3, type="missable",
    description = "Achieve Ending EX, by destroying the jewel",
    id = 405113, badge = "461652", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && bit0(0xAA1154) == 1 && bit0(0xAA1155) == 1 &&
                  bit0(0xAA1156) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1159) == 1 &&
                  bit7(0xA9ED98) == 1 && byte(0xB95704) == 1 && dword(0xA9ECBC) == 686720 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 234736 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 16816 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 1315744 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 16816
              ) &&
              once(byte(0xB95704) == 1 && dword(0xA9ECBC) == 424256 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1159) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "The Philosopher's Legacy", points = 3, type="missable",
    description = "Achieve Ending EX, by creating a miracle cure",
    id = 405114, badge = "461651", published = "5/03/2024 21:15:30", modified = "5/03/2024 21:15:30",
    trigger = never(low4(0xA9EDDC) == 0) &&
              never((dword(0x1FFF130) == 33 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11)
              ) &&
              never((dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4) &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                  dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) <= 11 &&
                  byte((dword(0xAC3178) & 0x1FFFFFF) + 0x000010) == 5
              ) &&
              once(byte(0xA9ED26) == 5 && bit0(0xA9F03D) == 1 && bit0(0xAA1154) == 1 && bit0(0xAA1155) == 1 &&
                  bit0(0xAA1156) == 1 && bit0(0xAA1157) == 1 && bit0(0xAA1158) == 1 && bit0(0xAA1159) == 1 &&
                  bit7(0xA9ED98) == 1 && byte(0xB95704) == 1 && dword(0xA9ECBC) == 363520 && word(0xA9ECC0) == 1 &&
                  word(0xA9ECC2) == 0 && dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 157936 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 72640 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000008) == 467440 &&
                  dword((dword(0xA9ECD4) & 0x1FFFFFF) + 0x000028) == 72640
              ) &&
              once(byte(0xB95704) == 1 && dword(0xA9ECBC) == 424256 && word(0xA9ECC0) == 1 && word(0xA9ECC2) == 0 &&
                  dword((dword(0xA9ECC8) & 0x1FFFFFF) + 0x000008) == 53792 &&
                  dword((dword(0xA9ECCC) & 0x1FFFFFF) + 0x000008) == 370416
              ) &&
              once((dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) == 257) &&
                  dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) == 65
              ) && trigger_when(bit0(0xAA1159) == 1) &&
              ((trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x000018) != 257)) ||
               (trigger_when(dword((dword(0x8FFEF0) & 0x1FFFFFF) + 0x00002C) != 65)))
)

achievement(
    title = "Homing Instinct", points = 10, type="missable",
    description = "Reach 100% achievement rate for the prologue and EX chapter",
    id = 405087, badge = "461646", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 1) &&
                measured(tally(53, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(53, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 0, format="percent"
                )))
)

achievement(
    title = "In the Heat of Time", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 1",
    id = 405088, badge = "461637", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 2) &&
                measured(tally(24, once(bit6(0xAA1162) == 1), once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1),
                    once(bit1(0xAA1163) == 1), once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1),
                    once(bit4(0xAA1163) == 1), once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1),
                    once(bit7(0xAA1163) == 1), once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1),
                    once(bit2(0xAA1164) == 1), once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1),
                    once(bit5(0xAA1164) == 1), once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1),
                    once(bit0(0xAA1165) == 1), once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1),
                    once(bit3(0xAA1165) == 1), once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(24, once(bit6(0xAA1162) == 1), once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1),
                    once(bit1(0xAA1163) == 1), once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1),
                    once(bit4(0xAA1163) == 1), once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1),
                    once(bit7(0xAA1163) == 1), once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1),
                    once(bit2(0xAA1164) == 1), once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1),
                    once(bit5(0xAA1164) == 1), once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1),
                    once(bit0(0xAA1165) == 1), once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1),
                    once(bit3(0xAA1165) == 1), once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 1, format="percent"
                )))
)

achievement(
    title = "Dana Kusch", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 2",
    id = 405089, badge = "461638", published = "5/03/2024 14:02:24", modified = "5/03/2024 14:02:24",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 3) &&
                measured(tally(36, once(bit3(0xAA1166) == 1), once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1),
                    once(bit6(0xAA1166) == 1), once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1),
                    once(bit1(0xAA1167) == 1), once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1),
                    once(bit4(0xAA1167) == 1), once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1),
                    once(bit7(0xAA1167) == 1), once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1),
                    once(bit2(0xAA1168) == 1), once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1),
                    once(bit5(0xAA1168) == 1), once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1),
                    once(bit0(0xAA1169) == 1), once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1),
                    once(bit3(0xAA1169) == 1), once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1),
                    once(bit6(0xAA1169) == 1), once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1),
                    once(bit1(0xAA116A) == 1), once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1),
                    once(bit4(0xAA116A) == 1), once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(36, once(bit3(0xAA1166) == 1), once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1),
                    once(bit6(0xAA1166) == 1), once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1),
                    once(bit1(0xAA1167) == 1), once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1),
                    once(bit4(0xAA1167) == 1), once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1),
                    once(bit7(0xAA1167) == 1), once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1),
                    once(bit2(0xAA1168) == 1), once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1),
                    once(bit5(0xAA1168) == 1), once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1),
                    once(bit0(0xAA1169) == 1), once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1),
                    once(bit3(0xAA1169) == 1), once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1),
                    once(bit6(0xAA1169) == 1), once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1),
                    once(bit1(0xAA116A) == 1), once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1),
                    once(bit4(0xAA116A) == 1), once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 2, format="percent"
                )))
)

achievement(
    title = "The Root of the Problem", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 3",
    id = 405090, badge = "461639", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 4) &&
                measured(tally(22, once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(22, once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 3, format="percent"
                )))
)

achievement(
    title = "The Monochrome Era", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 4",
    id = 405091, badge = "461640", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 5) &&
                measured(tally(36, once(bit1(0xAA116C) == 1), once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1),
                    once(bit4(0xAA116C) == 1), once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1),
                    once(bit7(0xAA116C) == 1), once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1),
                    once(bit2(0xAA116D) == 1), once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1),
                    once(bit5(0xAA116D) == 1), once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1),
                    once(bit0(0xAA116E) == 1), once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1),
                    once(bit3(0xAA116E) == 1), once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1),
                    once(bit6(0xAA116E) == 1), once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1),
                    once(bit1(0xAA116F) == 1), once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1),
                    once(bit4(0xAA116F) == 1), once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1),
                    once(bit7(0xAA116F) == 1), once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1),
                    once(bit2(0xAA1170) == 1), once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1)),
                    when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(36, once(bit1(0xAA116C) == 1), once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1),
                    once(bit4(0xAA116C) == 1), once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1),
                    once(bit7(0xAA116C) == 1), once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1),
                    once(bit2(0xAA116D) == 1), once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1),
                    once(bit5(0xAA116D) == 1), once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1),
                    once(bit0(0xAA116E) == 1), once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1),
                    once(bit3(0xAA116E) == 1), once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1),
                    once(bit6(0xAA116E) == 1), once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1),
                    once(bit1(0xAA116F) == 1), once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1),
                    once(bit4(0xAA116F) == 1), once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1),
                    once(bit7(0xAA116F) == 1), once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1),
                    once(bit2(0xAA1170) == 1), once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 4, format="percent"
                )))
)

achievement(
    title = "Meddling with Destiny", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 5",
    id = 405092, badge = "461641", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 6) &&
                measured(tally(46, once(bit1(0xAA1171) == 1), once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1),
                    once(bit4(0xAA1171) == 1), once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1),
                    once(bit7(0xAA1171) == 1), once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1),
                    once(bit2(0xAA1172) == 1), once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1),
                    once(bit5(0xAA1172) == 1), once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1),
                    once(bit0(0xAA1173) == 1), once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1),
                    once(bit3(0xAA1173) == 1), once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1),
                    once(bit6(0xAA1173) == 1), once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1),
                    once(bit1(0xAA1174) == 1), once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1),
                    once(bit4(0xAA1174) == 1), once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1),
                    once(bit7(0xAA1174) == 1), once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1),
                    once(bit2(0xAA1175) == 1), once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1),
                    once(bit5(0xAA1175) == 1), once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1),
                    once(bit0(0xAA1176) == 1), once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1),
                    once(bit3(0xAA1176) == 1), once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1),
                    once(bit6(0xAA1176) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(46, once(bit1(0xAA1171) == 1), once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1),
                    once(bit4(0xAA1171) == 1), once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1),
                    once(bit7(0xAA1171) == 1), once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1),
                    once(bit2(0xAA1172) == 1), once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1),
                    once(bit5(0xAA1172) == 1), once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1),
                    once(bit0(0xAA1173) == 1), once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1),
                    once(bit3(0xAA1173) == 1), once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1),
                    once(bit6(0xAA1173) == 1), once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1),
                    once(bit1(0xAA1174) == 1), once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1),
                    once(bit4(0xAA1174) == 1), once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1),
                    once(bit7(0xAA1174) == 1), once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1),
                    once(bit2(0xAA1175) == 1), once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1),
                    once(bit5(0xAA1175) == 1), once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1),
                    once(bit0(0xAA1176) == 1), once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1),
                    once(bit3(0xAA1176) == 1), once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1),
                    once(bit6(0xAA1176) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 5, format="percent"
                )))
)

achievement(
    title = "The Good Samaritan", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 6",
    id = 405093, badge = "461642", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 7) &&
                measured(tally(35, once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1), once(bit4(0xAA117A) == 1),
                    once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1), once(bit7(0xAA117A) == 1),
                    once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1), once(bit2(0xAA117B) == 1),
                    once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1), once(bit5(0xAA117B) == 1),
                    once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1), once(bit0(0xAA117C) == 1),
                    once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1), once(bit3(0xAA117C) == 1),
                    once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1), once(bit6(0xAA117C) == 1),
                    once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1), once(bit1(0xAA117D) == 1),
                    once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1), once(bit4(0xAA117D) == 1),
                    once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1), once(bit7(0xAA117D) == 1),
                    once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1), once(bit2(0xAA117E) == 1),
                    once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(35, once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1), once(bit4(0xAA117A) == 1),
                    once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1), once(bit7(0xAA117A) == 1),
                    once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1), once(bit2(0xAA117B) == 1),
                    once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1), once(bit5(0xAA117B) == 1),
                    once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1), once(bit0(0xAA117C) == 1),
                    once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1), once(bit3(0xAA117C) == 1),
                    once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1), once(bit6(0xAA117C) == 1),
                    once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1), once(bit1(0xAA117D) == 1),
                    once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1), once(bit4(0xAA117D) == 1),
                    once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1), once(bit7(0xAA117D) == 1),
                    once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1), once(bit2(0xAA117E) == 1),
                    once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 6, format="percent"
                )))
)

achievement(
    title = "Vintage Knots", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 7",
    id = 405094, badge = "461643", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never((prev(byte(0xB95704)) != 0 && byte(0xB95704) == 0)) &&
              ((unless(byte(0xB95704) != 8) &&
                measured(tally(34, once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(34, once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 7, format="percent"
                )))
)

achievement(
    title = "The Power of Fate", points = 10, type="missable",
    description = "Reach 100% achievement rate for chapter 8",
    id = 405095, badge = "461644", published = "5/03/2024 14:02:25", modified = "5/03/2024 14:02:25",
    trigger = never(prev(byte(0xB95704)) != byte(0xB95704)) &&
              ((unless((byte(0xB95704) != 9 && byte(0xB95704) != 11)) &&
                measured(tally(71, once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1), once(bit7(0xAA1184) == 1),
                    once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1), once(bit2(0xAA1185) == 1),
                    once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1), once(bit5(0xAA1185) == 1),
                    once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1), once(bit0(0xAA1186) == 1),
                    once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1), once(bit3(0xAA1186) == 1),
                    once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1), once(bit6(0xAA1186) == 1),
                    once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1), once(bit1(0xAA1187) == 1),
                    once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1), once(bit4(0xAA1187) == 1),
                    once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1), once(bit7(0xAA1187) == 1),
                    once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1), once(bit2(0xAA1188) == 1),
                    once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1), once(bit5(0xAA1188) == 1),
                    once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1), once(bit0(0xAA1189) == 1),
                    once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1), once(bit3(0xAA1189) == 1),
                    once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1), once(bit6(0xAA1189) == 1),
                    once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1), once(bit1(0xAA118A) == 1),
                    once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1), once(bit4(0xAA118A) == 1),
                    once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1), once(bit7(0xAA118A) == 1),
                    once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1), once(bit2(0xAA118B) == 1),
                    once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1), once(bit5(0xAA118B) == 1),
                    once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1), once(bit0(0xAA118C) == 1),
                    once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1), once(bit3(0xAA118C) == 1),
                    once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1), once(bit6(0xAA118C) == 1),
                    once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1), once(bit1(0xAA118D) == 1),
                    once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(71, once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1), once(bit7(0xAA1184) == 1),
                    once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1), once(bit2(0xAA1185) == 1),
                    once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1), once(bit5(0xAA1185) == 1),
                    once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1), once(bit0(0xAA1186) == 1),
                    once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1), once(bit3(0xAA1186) == 1),
                    once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1), once(bit6(0xAA1186) == 1),
                    once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1), once(bit1(0xAA1187) == 1),
                    once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1), once(bit4(0xAA1187) == 1),
                    once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1), once(bit7(0xAA1187) == 1),
                    once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1), once(bit2(0xAA1188) == 1),
                    once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1), once(bit5(0xAA1188) == 1),
                    once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1), once(bit0(0xAA1189) == 1),
                    once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1), once(bit3(0xAA1189) == 1),
                    once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1), once(bit6(0xAA1189) == 1),
                    once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1), once(bit1(0xAA118A) == 1),
                    once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1), once(bit4(0xAA118A) == 1),
                    once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1), once(bit7(0xAA118A) == 1),
                    once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1), once(bit2(0xAA118B) == 1),
                    once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1), once(bit5(0xAA118B) == 1),
                    once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1), once(bit0(0xAA118C) == 1),
                    once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1), once(bit3(0xAA118C) == 1),
                    once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1), once(bit6(0xAA118C) == 1),
                    once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1), once(bit1(0xAA118D) == 1),
                    once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 8, format="percent"
                )))
)

achievement(
    title = "Eternal Youth", points = 10, type="missable",
    description = "Reach 100% achievement rate for the epilogue",
    id = 405096, badge = "461645", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = never(prev(byte(0xB95704)) != byte(0xB95704)) &&
              ((unless((byte(0xB95704) != 10 && byte(0xB95704) != 12)) &&
                measured(tally(23, once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(23, once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 9, format="percent"
                )))
)

achievement(
    title = "The Day of Walpurgis", points = 50, type="missable",
    description = "Reach 100% total achievement rate",
    id = 405097, badge = "461647", published = "5/03/2024 14:02:34", modified = "5/03/2024 14:02:34",
    trigger = never(byte(0xB95704) != prev(byte(0xB95704))) &&
              ((measured(tally(380, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1), once(bit6(0xAA1162) == 1),
                    once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1), once(bit1(0xAA1163) == 1),
                    once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1), once(bit4(0xAA1163) == 1),
                    once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1), once(bit7(0xAA1163) == 1),
                    once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1), once(bit2(0xAA1164) == 1),
                    once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1), once(bit5(0xAA1164) == 1),
                    once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1), once(bit0(0xAA1165) == 1),
                    once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1), once(bit3(0xAA1165) == 1),
                    once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1), once(bit3(0xAA1166) == 1),
                    once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1), once(bit6(0xAA1166) == 1),
                    once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1), once(bit1(0xAA1167) == 1),
                    once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1), once(bit4(0xAA1167) == 1),
                    once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1), once(bit7(0xAA1167) == 1),
                    once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1), once(bit2(0xAA1168) == 1),
                    once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1), once(bit5(0xAA1168) == 1),
                    once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1), once(bit0(0xAA1169) == 1),
                    once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1), once(bit3(0xAA1169) == 1),
                    once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1), once(bit6(0xAA1169) == 1),
                    once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1), once(bit1(0xAA116A) == 1),
                    once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1), once(bit4(0xAA116A) == 1),
                    once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1), once(bit1(0xAA116C) == 1),
                    once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1), once(bit4(0xAA116C) == 1),
                    once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1), once(bit7(0xAA116C) == 1),
                    once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1), once(bit2(0xAA116D) == 1),
                    once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1), once(bit5(0xAA116D) == 1),
                    once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1), once(bit0(0xAA116E) == 1),
                    once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1), once(bit3(0xAA116E) == 1),
                    once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1), once(bit6(0xAA116E) == 1),
                    once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1), once(bit1(0xAA116F) == 1),
                    once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1), once(bit4(0xAA116F) == 1),
                    once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1), once(bit7(0xAA116F) == 1),
                    once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1), once(bit2(0xAA1170) == 1),
                    once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1), once(bit1(0xAA1171) == 1),
                    once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1), once(bit4(0xAA1171) == 1),
                    once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1), once(bit7(0xAA1171) == 1),
                    once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1), once(bit2(0xAA1172) == 1),
                    once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1), once(bit5(0xAA1172) == 1),
                    once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1), once(bit0(0xAA1173) == 1),
                    once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1), once(bit3(0xAA1173) == 1),
                    once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1), once(bit6(0xAA1173) == 1),
                    once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1), once(bit1(0xAA1174) == 1),
                    once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1), once(bit4(0xAA1174) == 1),
                    once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1), once(bit7(0xAA1174) == 1),
                    once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1), once(bit2(0xAA1175) == 1),
                    once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1), once(bit5(0xAA1175) == 1),
                    once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1), once(bit0(0xAA1176) == 1),
                    once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1), once(bit3(0xAA1176) == 1),
                    once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1), once(bit6(0xAA1176) == 1),
                    once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1), once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1),
                    once(bit4(0xAA117A) == 1), once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1),
                    once(bit7(0xAA117A) == 1), once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1),
                    once(bit2(0xAA117B) == 1), once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1),
                    once(bit5(0xAA117B) == 1), once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1),
                    once(bit0(0xAA117C) == 1), once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1),
                    once(bit3(0xAA117C) == 1), once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1),
                    once(bit6(0xAA117C) == 1), once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1),
                    once(bit1(0xAA117D) == 1), once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1),
                    once(bit4(0xAA117D) == 1), once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1),
                    once(bit7(0xAA117D) == 1), once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1),
                    once(bit2(0xAA117E) == 1), once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1),
                    once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1), once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1),
                    once(bit7(0xAA1184) == 1), once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1),
                    once(bit2(0xAA1185) == 1), once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1),
                    once(bit5(0xAA1185) == 1), once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1),
                    once(bit0(0xAA1186) == 1), once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1),
                    once(bit3(0xAA1186) == 1), once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1),
                    once(bit6(0xAA1186) == 1), once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1),
                    once(bit1(0xAA1187) == 1), once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1),
                    once(bit4(0xAA1187) == 1), once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1),
                    once(bit7(0xAA1187) == 1), once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1),
                    once(bit2(0xAA1188) == 1), once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1),
                    once(bit5(0xAA1188) == 1), once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1),
                    once(bit0(0xAA1189) == 1), once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1),
                    once(bit3(0xAA1189) == 1), once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1),
                    once(bit6(0xAA1189) == 1), once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1),
                    once(bit1(0xAA118A) == 1), once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1),
                    once(bit4(0xAA118A) == 1), once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1),
                    once(bit7(0xAA118A) == 1), once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1),
                    once(bit2(0xAA118B) == 1), once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1),
                    once(bit5(0xAA118B) == 1), once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1),
                    once(bit0(0xAA118C) == 1), once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1),
                    once(bit3(0xAA118C) == 1), once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1),
                    once(bit6(0xAA118C) == 1), once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1),
                    once(bit1(0xAA118D) == 1), once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1),
                    once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)), when=low4(0xA9EDDC) != 0, format="percent"
                )) ||
               (measured(tally(380, once(bit1(0xAA115B) == 1), once(bit2(0xAA115B) == 1), once(bit3(0xAA115B) == 1),
                    once(bit4(0xAA115B) == 1), once(bit5(0xAA115B) == 1), once(bit6(0xAA115B) == 1),
                    once(bit7(0xAA115B) == 1), once(bit0(0xAA115C) == 1), once(bit1(0xAA115C) == 1),
                    once(bit2(0xAA115C) == 1), once(bit3(0xAA115C) == 1), once(bit4(0xAA115C) == 1),
                    once(bit5(0xAA115C) == 1), once(bit6(0xAA115C) == 1), once(bit7(0xAA115C) == 1),
                    once(bit0(0xAA115D) == 1), once(bit1(0xAA115D) == 1), once(bit2(0xAA115D) == 1),
                    once(bit3(0xAA115D) == 1), once(bit4(0xAA115D) == 1), once(bit5(0xAA115D) == 1),
                    once(bit6(0xAA115D) == 1), once(bit7(0xAA115D) == 1), once(bit0(0xAA115E) == 1),
                    once(bit1(0xAA115E) == 1), once(bit2(0xAA115E) == 1), once(bit3(0xAA115E) == 1),
                    once(bit4(0xAA115E) == 1), once(bit5(0xAA115E) == 1), once(bit6(0xAA115E) == 1),
                    once(bit7(0xAA115E) == 1), once(bit0(0xAA115F) == 1), once(bit1(0xAA115F) == 1),
                    once(bit2(0xAA115F) == 1), once(bit3(0xAA115F) == 1), once(bit4(0xAA115F) == 1),
                    once(bit5(0xAA115F) == 1), once(bit6(0xAA115F) == 1), once(bit7(0xAA115F) == 1),
                    once(bit0(0xAA1160) == 1), once(bit1(0xAA1160) == 1), once(bit2(0xAA1160) == 1),
                    once(bit3(0xAA1160) == 1), once(bit4(0xAA1160) == 1), once(bit5(0xAA1160) == 1),
                    once(bit6(0xAA1160) == 1), once(bit7(0xAA1160) == 1), once(bit0(0xAA1161) == 1),
                    once(bit1(0xAA1161) == 1), once(bit2(0xAA1161) == 1), once(bit3(0xAA1161) == 1),
                    once(bit4(0xAA1161) == 1), once(bit5(0xAA1161) == 1), once(bit6(0xAA1162) == 1),
                    once(bit7(0xAA1162) == 1), once(bit0(0xAA1163) == 1), once(bit1(0xAA1163) == 1),
                    once(bit2(0xAA1163) == 1), once(bit3(0xAA1163) == 1), once(bit4(0xAA1163) == 1),
                    once(bit5(0xAA1163) == 1), once(bit6(0xAA1163) == 1), once(bit7(0xAA1163) == 1),
                    once(bit0(0xAA1164) == 1), once(bit1(0xAA1164) == 1), once(bit2(0xAA1164) == 1),
                    once(bit3(0xAA1164) == 1), once(bit4(0xAA1164) == 1), once(bit5(0xAA1164) == 1),
                    once(bit6(0xAA1164) == 1), once(bit7(0xAA1164) == 1), once(bit0(0xAA1165) == 1),
                    once(bit1(0xAA1165) == 1), once(bit2(0xAA1165) == 1), once(bit3(0xAA1165) == 1),
                    once(bit4(0xAA1165) == 1), once(bit5(0xAA1165) == 1), once(bit3(0xAA1166) == 1),
                    once(bit4(0xAA1166) == 1), once(bit5(0xAA1166) == 1), once(bit6(0xAA1166) == 1),
                    once(bit7(0xAA1166) == 1), once(bit0(0xAA1167) == 1), once(bit1(0xAA1167) == 1),
                    once(bit2(0xAA1167) == 1), once(bit3(0xAA1167) == 1), once(bit4(0xAA1167) == 1),
                    once(bit5(0xAA1167) == 1), once(bit6(0xAA1167) == 1), once(bit7(0xAA1167) == 1),
                    once(bit0(0xAA1168) == 1), once(bit1(0xAA1168) == 1), once(bit2(0xAA1168) == 1),
                    once(bit3(0xAA1168) == 1), once(bit4(0xAA1168) == 1), once(bit5(0xAA1168) == 1),
                    once(bit6(0xAA1168) == 1), once(bit7(0xAA1168) == 1), once(bit0(0xAA1169) == 1),
                    once(bit1(0xAA1169) == 1), once(bit2(0xAA1169) == 1), once(bit3(0xAA1169) == 1),
                    once(bit4(0xAA1169) == 1), once(bit5(0xAA1169) == 1), once(bit6(0xAA1169) == 1),
                    once(bit7(0xAA1169) == 1), once(bit0(0xAA116A) == 1), once(bit1(0xAA116A) == 1),
                    once(bit2(0xAA116A) == 1), once(bit3(0xAA116A) == 1), once(bit4(0xAA116A) == 1),
                    once(bit5(0xAA116A) == 1), once(bit6(0xAA116A) == 1), once(bit1(0xAA116C) == 1),
                    once(bit2(0xAA116C) == 1), once(bit3(0xAA116C) == 1), once(bit4(0xAA116C) == 1),
                    once(bit5(0xAA116C) == 1), once(bit6(0xAA116C) == 1), once(bit7(0xAA116C) == 1),
                    once(bit0(0xAA116D) == 1), once(bit1(0xAA116D) == 1), once(bit2(0xAA116D) == 1),
                    once(bit3(0xAA116D) == 1), once(bit4(0xAA116D) == 1), once(bit5(0xAA116D) == 1),
                    once(bit6(0xAA116D) == 1), once(bit7(0xAA116D) == 1), once(bit0(0xAA116E) == 1),
                    once(bit1(0xAA116E) == 1), once(bit2(0xAA116E) == 1), once(bit3(0xAA116E) == 1),
                    once(bit4(0xAA116E) == 1), once(bit5(0xAA116E) == 1), once(bit6(0xAA116E) == 1),
                    once(bit7(0xAA116E) == 1), once(bit0(0xAA116F) == 1), once(bit1(0xAA116F) == 1),
                    once(bit2(0xAA116F) == 1), once(bit3(0xAA116F) == 1), once(bit4(0xAA116F) == 1),
                    once(bit5(0xAA116F) == 1), once(bit6(0xAA116F) == 1), once(bit7(0xAA116F) == 1),
                    once(bit0(0xAA1170) == 1), once(bit1(0xAA1170) == 1), once(bit2(0xAA1170) == 1),
                    once(bit3(0xAA1170) == 1), once(bit4(0xAA1170) == 1), once(bit1(0xAA1171) == 1),
                    once(bit2(0xAA1171) == 1), once(bit3(0xAA1171) == 1), once(bit4(0xAA1171) == 1),
                    once(bit5(0xAA1171) == 1), once(bit6(0xAA1171) == 1), once(bit7(0xAA1171) == 1),
                    once(bit0(0xAA1172) == 1), once(bit1(0xAA1172) == 1), once(bit2(0xAA1172) == 1),
                    once(bit3(0xAA1172) == 1), once(bit4(0xAA1172) == 1), once(bit5(0xAA1172) == 1),
                    once(bit6(0xAA1172) == 1), once(bit7(0xAA1172) == 1), once(bit0(0xAA1173) == 1),
                    once(bit1(0xAA1173) == 1), once(bit2(0xAA1173) == 1), once(bit3(0xAA1173) == 1),
                    once(bit4(0xAA1173) == 1), once(bit5(0xAA1173) == 1), once(bit6(0xAA1173) == 1),
                    once(bit7(0xAA1173) == 1), once(bit0(0xAA1174) == 1), once(bit1(0xAA1174) == 1),
                    once(bit2(0xAA1174) == 1), once(bit3(0xAA1174) == 1), once(bit4(0xAA1174) == 1),
                    once(bit5(0xAA1174) == 1), once(bit6(0xAA1174) == 1), once(bit7(0xAA1174) == 1),
                    once(bit0(0xAA1175) == 1), once(bit1(0xAA1175) == 1), once(bit2(0xAA1175) == 1),
                    once(bit3(0xAA1175) == 1), once(bit4(0xAA1175) == 1), once(bit5(0xAA1175) == 1),
                    once(bit6(0xAA1175) == 1), once(bit7(0xAA1175) == 1), once(bit0(0xAA1176) == 1),
                    once(bit1(0xAA1176) == 1), once(bit2(0xAA1176) == 1), once(bit3(0xAA1176) == 1),
                    once(bit4(0xAA1176) == 1), once(bit5(0xAA1176) == 1), once(bit6(0xAA1176) == 1),
                    once(bit2(0xAA1177) == 1), once(bit3(0xAA1177) == 1), once(bit4(0xAA1177) == 1),
                    once(bit5(0xAA1177) == 1), once(bit6(0xAA1177) == 1), once(bit7(0xAA1177) == 1),
                    once(bit0(0xAA1178) == 1), once(bit1(0xAA1178) == 1), once(bit2(0xAA1178) == 1),
                    once(bit3(0xAA1178) == 1), once(bit4(0xAA1178) == 1), once(bit5(0xAA1178) == 1),
                    once(bit6(0xAA1178) == 1), once(bit7(0xAA1178) == 1), once(bit0(0xAA1179) == 1),
                    once(bit1(0xAA1179) == 1), once(bit2(0xAA1179) == 1), once(bit3(0xAA1179) == 1),
                    once(bit4(0xAA1179) == 1), once(bit5(0xAA1179) == 1), once(bit6(0xAA1179) == 1),
                    once(bit7(0xAA1179) == 1), once(bit2(0xAA117A) == 1), once(bit3(0xAA117A) == 1),
                    once(bit4(0xAA117A) == 1), once(bit5(0xAA117A) == 1), once(bit6(0xAA117A) == 1),
                    once(bit7(0xAA117A) == 1), once(bit0(0xAA117B) == 1), once(bit1(0xAA117B) == 1),
                    once(bit2(0xAA117B) == 1), once(bit3(0xAA117B) == 1), once(bit4(0xAA117B) == 1),
                    once(bit5(0xAA117B) == 1), once(bit6(0xAA117B) == 1), once(bit7(0xAA117B) == 1),
                    once(bit0(0xAA117C) == 1), once(bit1(0xAA117C) == 1), once(bit2(0xAA117C) == 1),
                    once(bit3(0xAA117C) == 1), once(bit4(0xAA117C) == 1), once(bit5(0xAA117C) == 1),
                    once(bit6(0xAA117C) == 1), once(bit7(0xAA117C) == 1), once(bit0(0xAA117D) == 1),
                    once(bit1(0xAA117D) == 1), once(bit2(0xAA117D) == 1), once(bit3(0xAA117D) == 1),
                    once(bit4(0xAA117D) == 1), once(bit5(0xAA117D) == 1), once(bit6(0xAA117D) == 1),
                    once(bit7(0xAA117D) == 1), once(bit0(0xAA117E) == 1), once(bit1(0xAA117E) == 1),
                    once(bit2(0xAA117E) == 1), once(bit3(0xAA117E) == 1), once(bit4(0xAA117E) == 1),
                    once(bit2(0xAA117F) == 1), once(bit3(0xAA117F) == 1), once(bit4(0xAA117F) == 1),
                    once(bit5(0xAA117F) == 1), once(bit6(0xAA117F) == 1), once(bit7(0xAA117F) == 1),
                    once(bit0(0xAA1180) == 1), once(bit1(0xAA1180) == 1), once(bit2(0xAA1180) == 1),
                    once(bit3(0xAA1180) == 1), once(bit4(0xAA1180) == 1), once(bit5(0xAA1180) == 1),
                    once(bit6(0xAA1180) == 1), once(bit7(0xAA1180) == 1), once(bit0(0xAA1181) == 1),
                    once(bit1(0xAA1181) == 1), once(bit2(0xAA1181) == 1), once(bit3(0xAA1181) == 1),
                    once(bit4(0xAA1181) == 1), once(bit5(0xAA1181) == 1), once(bit6(0xAA1181) == 1),
                    once(bit7(0xAA1181) == 1), once(bit0(0xAA1182) == 1), once(bit1(0xAA1182) == 1),
                    once(bit2(0xAA1182) == 1), once(bit3(0xAA1182) == 1), once(bit4(0xAA1182) == 1),
                    once(bit5(0xAA1182) == 1), once(bit6(0xAA1182) == 1), once(bit7(0xAA1182) == 1),
                    once(bit0(0xAA1183) == 1), once(bit1(0xAA1183) == 1), once(bit2(0xAA1183) == 1),
                    once(bit3(0xAA1183) == 1), once(bit5(0xAA1184) == 1), once(bit6(0xAA1184) == 1),
                    once(bit7(0xAA1184) == 1), once(bit0(0xAA1185) == 1), once(bit1(0xAA1185) == 1),
                    once(bit2(0xAA1185) == 1), once(bit3(0xAA1185) == 1), once(bit4(0xAA1185) == 1),
                    once(bit5(0xAA1185) == 1), once(bit6(0xAA1185) == 1), once(bit7(0xAA1185) == 1),
                    once(bit0(0xAA1186) == 1), once(bit1(0xAA1186) == 1), once(bit2(0xAA1186) == 1),
                    once(bit3(0xAA1186) == 1), once(bit4(0xAA1186) == 1), once(bit5(0xAA1186) == 1),
                    once(bit6(0xAA1186) == 1), once(bit7(0xAA1186) == 1), once(bit0(0xAA1187) == 1),
                    once(bit1(0xAA1187) == 1), once(bit2(0xAA1187) == 1), once(bit3(0xAA1187) == 1),
                    once(bit4(0xAA1187) == 1), once(bit5(0xAA1187) == 1), once(bit6(0xAA1187) == 1),
                    once(bit7(0xAA1187) == 1), once(bit0(0xAA1188) == 1), once(bit1(0xAA1188) == 1),
                    once(bit2(0xAA1188) == 1), once(bit3(0xAA1188) == 1), once(bit4(0xAA1188) == 1),
                    once(bit5(0xAA1188) == 1), once(bit6(0xAA1188) == 1), once(bit7(0xAA1188) == 1),
                    once(bit0(0xAA1189) == 1), once(bit1(0xAA1189) == 1), once(bit2(0xAA1189) == 1),
                    once(bit3(0xAA1189) == 1), once(bit4(0xAA1189) == 1), once(bit5(0xAA1189) == 1),
                    once(bit6(0xAA1189) == 1), once(bit7(0xAA1189) == 1), once(bit0(0xAA118A) == 1),
                    once(bit1(0xAA118A) == 1), once(bit2(0xAA118A) == 1), once(bit3(0xAA118A) == 1),
                    once(bit4(0xAA118A) == 1), once(bit5(0xAA118A) == 1), once(bit6(0xAA118A) == 1),
                    once(bit7(0xAA118A) == 1), once(bit0(0xAA118B) == 1), once(bit1(0xAA118B) == 1),
                    once(bit2(0xAA118B) == 1), once(bit3(0xAA118B) == 1), once(bit4(0xAA118B) == 1),
                    once(bit5(0xAA118B) == 1), once(bit6(0xAA118B) == 1), once(bit7(0xAA118B) == 1),
                    once(bit0(0xAA118C) == 1), once(bit1(0xAA118C) == 1), once(bit2(0xAA118C) == 1),
                    once(bit3(0xAA118C) == 1), once(bit4(0xAA118C) == 1), once(bit5(0xAA118C) == 1),
                    once(bit6(0xAA118C) == 1), once(bit7(0xAA118C) == 1), once(bit0(0xAA118D) == 1),
                    once(bit1(0xAA118D) == 1), once(bit2(0xAA118D) == 1), once(bit3(0xAA118D) == 1),
                    once(bit2(0xAA1190) == 1), once(bit3(0xAA1190) == 1), once(bit4(0xAA1190) == 1),
                    once(bit5(0xAA1190) == 1), once(bit6(0xAA1190) == 1), once(bit7(0xAA1190) == 1),
                    once(bit0(0xAA1191) == 1), once(bit1(0xAA1191) == 1), once(bit2(0xAA1191) == 1),
                    once(bit3(0xAA1191) == 1), once(bit4(0xAA1191) == 1), once(bit5(0xAA1191) == 1),
                    once(bit6(0xAA1191) == 1), once(bit7(0xAA1191) == 1), once(bit0(0xAA1192) == 1),
                    once(bit1(0xAA1192) == 1), once(bit2(0xAA1192) == 1), once(bit3(0xAA1192) == 1),
                    once(bit4(0xAA1192) == 1), once(bit5(0xAA1192) == 1), once(bit6(0xAA1192) == 1),
                    once(bit7(0xAA1192) == 1), once(bit0(0xAA1193) == 1)),
                    when=dword(0xAC49F4) == 22 && dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000004) <= 4 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000014) <= 5 &&
                         measured_if(dword((dword(0xAC3170) & 0x1FFFFFF) + 0x000048) == 10, format="percent"
                )))
)
