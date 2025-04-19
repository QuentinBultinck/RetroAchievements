function lookup() {
    return {
        "US": byte(0x0),
        "JP": byte(0x0)
    }
}

// trigger = lookup()["US"]

obj = lookup()
trigger = obj["US"]