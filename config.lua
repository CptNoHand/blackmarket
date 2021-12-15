Config = {}

--- Sellable Items

Config.SellableItems = {
    ["trojan_usb"] = 1.500000,
    ["security_card_01"] = 1.500000,
    ["security_card_02"] = 1.500000,
}

--- Products

Config.Products = {
    ["trojan_usb"] = {
        sell = 2.500000,
    },
    ["security_card_01"] = {
        sell = 5.000000,
    },
    ["security_card_02"] = {
        sell = 5.000000,
    },
    ["labkey"] = {
        sell = 7.5000000,
    },
    ["decryptionkey3"] = {
        sell = 7.5000000,
    },
    ["heavyarmor"] = {
        sell = 15.000000,
    },
    ["pistol_extendedclip"] = {
        sell = 100.000000,
    },
    ["pistol_ammo"] = {
        sell = 100.000000,
    },
}

--- Location Picker

local setLocPick = math.random(1, 6) -- un-comment me out for location change
--- local setLocPick = 1 -- comment me out for location change

Config.LocationSets = {
    [1] = {
        ["x"] = -320.8,
        ["y"] = 2818.71,
        ["z"] = 59.45,
        ["h"] = 328.8,
    },
    [2] = {
        ["x"] = -1915.66,
        ["y"] = -565.59,
        ["z"] = 20.47,
        ["h"] = 53.09,
    },
    [3] = {
        ["x"] = -1167.87,
        ["y"] = -476.27,
        ["z"] = 49.25,
        ["h"] = 132.81,
    },
    [4] = {
        ["x"] = 2806.19,
        ["y"] = 5978.45,
        ["z"] = 350.7,
        ["h"] = 223.05,
    },
    [5] = {
        ["x"] = -687.46,
        ["y"] = 5759.01,
        ["z"] = 17.51,
        ["h"] = 48.54,
    },
    [6] = {
        ["x"] = 515.37,
        ["y"] = 174.6,
        ["z"] = 100.68,
        ["h"] = 22.814,
    },
} 

Config.Locations = {
    ["market"] = {
        ["label"] = "market",
        ["type"] = "mark",
        ["coords"] = {
            [1] = {
                ["x"] = tonumber(Config.LocationSets[setLocPick]["x"]),
                ["y"] = tonumber(Config.LocationSets[setLocPick]["y"]),
                ["z"] = tonumber(Config.LocationSets[setLocPick]["z"]),
                ["h"] = tonumber(Config.LocationSets[setLocPick]["h"]),
            },
        },
        ["products"] = Config.Products,
    },
}

--- Shop Times

Config.Open = 18

Config.Close = 24
