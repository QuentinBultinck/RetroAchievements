LevelStatsPointer = 0x0

function LevelStats(stat) {
    return tbyte(LevelStatsPointer) + 0x3
}

prev_total = prev(byte(LevelStats("secrets"))) + prev(byte(LevelStats("talismans")))