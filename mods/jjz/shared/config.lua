Config = {}
Config.Redemrp_Inventory2 = false
Config.EnableSql = true
Config.PlayerInfStamina = true
Config.PlayerHealthRegen = 2.0
Config.HorseInfStamina = true
Config.PlayerBaseHealth = 200   -- bonus health
Config.UndeadBaseHealth = 310
Config.TownfolkBaseHealth = 110
Config.MaxZombies = 35
Config.MaxTownfolk = 20
Config.MaxAttackRangeTownfolk = 11.0
Config.MaxAttackRangeZombies = 11.0
Config.AiMeleeWeaponDamageModifier = 11.0
Config.AiWeaponDamageModifier = 11.0
Config.PlayerMeleeWeaponDamageModifier = 11.0
Config.PlayerMeleeWeaponDefenseModifier = 0.01
Config.SetTownfolkAccuracy = 35.0
Config.SetZombieAccuracy = 25.0
Config.DespawnDistance = 200
Config.SpawnDistance = 200
Config.InRangeofPlayer = 30
Config.ShowBlips = true
Config.UndeadBlipSprite = -839369609
Config.ZoneBlipSprite = 693035517
Config.TownfolkBlipSprite = 0xC19DA63 --0xB04092F8
Config.DefaultZone = 'valentine'
--Config.ZoneTimeout = 1800


Config.WalkingStyles = {
	{'default', 'very_drunk'},
	{'murfree', 'very_drunk'},
	{'default', 'dehydrated_unarmed'},
}

Config.Language = GetConvar("redemrp_properties_language", "en")

Config.Languages = {
    ['en'] = {
        ["for_sale"] = "~t4~_NAME ~q~(~t6~_PRICE$~q~)",
        ["private_property"] = "~t4~_NAME's~q~ Property"
	}
}
Config.Zones = {
	world = {
		name = 'Worldwide'
	},
	annesburg = {
		name = 'Annesburg',
		x = 2905.50,
		y = 1356.83,
		z = 51.75,
		radius = 400.0
	},
	armadillo = {
		name = 'Armadillo',
		x = -3678.58,
		y = -2613.38,
		z = -14.11,
		radius = 150.0
	},
	benedictpoint = {
		name = 'Benedict Point',
		x = -5224.15,
		y = -3472.15,
		z = -20.55,
		radius = 150.0
	},
	blackwater = {
		name = 'Blackwater',
		x = -924.87,
		y = -1313.61,
		z = 46.26,
		radius = 300.0
	},
	emeraldranch = {
		name = 'Emerald Ranch',
		x = 1421.56,
		y = 323.30,
		z = 88.39,
		radius = 300.0
	},
	flatironlake = {
		name = 'Flatiron Lake Islands',
		x = 429.59,
		y = -1480.59,
		z = 40.24,
		radius = 450.0
	},
	fortmercer = {
		name = 'Fort Mercer',
		x = -4210.57,
		y = -3446.08,
		z = 37.08,
		radius = 150.0
	},
	grizzlieseast = {
		name = 'East Grizzlies',
		x = 1934.70,
		y = 1950.61,
		z = 266.12,
		radius = 400.0
	},
	heartlandoilfields = {
		name = 'Heartland Oil Fields',
		x = 521.93,
		y = 621.11,
		z = 109.92,
		radius = 150.0
	},
	lagras = {
		name = 'Lagras',
		x = 2034.59,
		y = -633.62,
		z = 42.94,
		radius = 300.0
	},
	macfarlanesranch = {
		name = 'Macfarlane\'s Ranch',
		x = -2377.92,
		y = -2406.36,
		z = 61.76,
		radius = 150.0
	},
	rhodes = {
		name = 'Rhodes',
		x = 1311.61,
		y = -1339.71,
		z = 77.21,
		radius = 500.0
	},
	saintdenis = {
		name = 'Saint Denis',
		x = 2615.96,
		y = -1262.17,
		z = 52.56,
		radius = 600.0
	},
	sisika = {
		name = 'Sisika Pennitentiary',
		x = 3272.51,
		y = -624.70,
		z = 42.66,
		radius = 300.0
	},
	strawberry = {
		name = 'Strawberry',
		x = -1791.29,
		y = -403.40,
		z = 154.49,
		radius = 250.0
	},
	thieveslanding = {
		name = 'Thieves Landing',
		x = -1411.47,
		y = -2259.47,
		z = 42.35,
		radius = 200.0
	},
	tumbleweed = {
		name = 'Tumbleweed',
		x = -5519.54,
		y = -2950.01,
		z = -1.68,
		radius = 150.0
	},
	valentine = {
		name = 'Valentine',
		x = -282.55,
		y = 720.44,
		z = 114.89,
		radius = 400.0
	},
	vanhorn = {
		name = 'Van Horn',
		x = 2930.26,
		y = 523.47,
		z = 45.31,
		radius = 200.0
	}
}

Config.ZoneRotation = {
	'annesburg',
	'armadillo',
	'benedictpoint',
	'blackwater',
	'emeraldranch',
	'fortmercer',
	'grizzlieseast',
	'heartlandoilfields',
	'lagras',
	'macfarlanesranch',
	'rhodes',
	'saintdenis',
	'sisika',
	'strawberry',
	'thieveslanding',
	'tumbleweed',
	'valentine',
	'vanhorn'
}


Config.Animal = {
    [1] =  {["name"] = "Bear",                     ["model"] = -1124266369,  ["item"] = "biggame",  ["poor"] = 957520252,   ["good"] = 143941906,   ["perfect"] = 1292673537,  ["reward"] = 3, ["xp"] = 3 },
    [2] =  {["name"] = "Big Horn Ram",             ["model"] = -15687816381, ["item"] = "biggame",  ["poor"] = 1796037447,  ["good"] = -476045512,  ["perfect"] = 1795984405,  ["reward"] = 2.5, ["xp"] = 2.5 },
    [3] =  {["name"] = "Boar",                     ["model"] = 2028722809,   ["item"] = "biggame",  ["poor"] = 1248540072,  ["good"] = nil,         ["perfect"] = -1858513856, ["reward"] = 3, ["xp"] = 3 },
    [4] =  {["name"] = "Buck",                     ["model"] = -1963605336,  ["item"] = "venison",  ["poor"] = 1603936352,  ["good"] = -868657362,  ["perfect"] = -702790226,  ["reward"] = 1.25, ["xp"] = 1.25 },
    [5] =  {["name"] = "Bison",                    ["model"] = 1556473961,   ["item"] = "biggame",  ["poor"] = -1730060063, ["good"] = -591117838,  ["perfect"] = -237756948,  ["reward"] = 4, ["xp"] = 4 },
    [6] =  {["name"] = "Bull",                     ["model"] = 195700131,    ["item"] = "biggame",  ["poor"] = 9293261,     ["good"] = -336086818,  ["perfect"] = -53270317,   ["reward"] = 3, ["xp"] = 3 },
    [7] =  {["name"] = "Deer",                     ["model"] = 1110710183,   ["item"] = "venison",  ["poor"] = -662178186,  ["good"] = -1827027577, ["perfect"] = -1035515486, ["reward"] = 2.5, ["xp"] = 2.5 },
    [8] =  {["name"] = "Duck",                     ["model"] = -1003616053,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [9] =  {["name"] = "Eagle",                    ["model"] = 1459778951,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 6, ["xp"] = 6 },
    [10] = {["name"] = "Egret",                    ["model"] = 831859211,    ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [11] = {["name"] = "Elk",                      ["model"] = -2021043433,  ["item"] = "biggame",  ["poor"] = 2053771712,  ["good"] = 1181652728,  ["perfect"] = -1332163079, ["reward"] = 5, ["xp"] = 5 },
    [12] = {["name"] = "American Red Fox",         ["model"] = 252669332,    ["item"] = "game",     ["poor"] = 1647012424,  ["good"] = 238733925,   ["perfect"] = 500722008,   ["reward"] = 5, ["xp"] = 5 },
    [13] = {["name"] = "Big Grey Wolf",            ["model"] = -1143398950,  ["item"] = "biggame",  ["poor"] = 85441452,    ["good"] = 1145777975,  ["perfect"] = 653400939,   ["reward"] = 6, ["xp"] = 6 },
    [14] = {["name"] = "Medium Grey Wolf",         ["model"] = -885451903,   ["item"] = "biggame",  ["poor"] = 85441452,    ["good"] = 1145777975,  ["perfect"] = 653400939,   ["reward"] = 5, ["xp"] = 5 },
    [15] = {["name"] = "Small Grey Wolf",          ["model"] = -829273561,   ["item"] = "biggame",  ["poor"] = 85441452,    ["good"] = 1145777975,  ["perfect"] = 653400939,   ["reward"] = 4, ["xp"] = 4 },
    [16] = {["name"] = "Vulture",                  ["model"] = 1104697660,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [17] = {["name"] = "Snapping Turtle",          ["model"] = -407730502,   ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [18] = {["name"] = "Wild Turkey",              ["model"] = -466054788,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [19] = {["name"] = "Wild Turkey",              ["model"] = -2011226991,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [20] = {["name"] = "Wild Turkey",              ["model"] = -166054593,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [21] = {["name"] = "Water Snake",              ["model"] = -229688157,   ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [22] = {["name"] = "Water Snake",              ["model"] = -229688157,   ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [23] = {["name"] = "Snake Red Boa",            ["model"] = -1790499186,  ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [24] = {["name"] = "Snake Fer-De-Lance",       ["model"] = 1464167925,   ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [25] = {["name"] = "Black-Tailed Rattlesnake", ["model"] = 846659001,    ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [26] = {["name"] = "Western Rattlesnake",      ["model"] = 545068538,    ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [27] = {["name"] = "Striped Skunk",            ["model"] = -1211566332,  ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [28] = {["name"] = "Merino Sheep",             ["model"] = 40345436,     ["item"] = "wool",     ["poor"] = 1729948479,  ["good"] = -1317365569, ["perfect"] = 1466150167,  ["reward"] = 1, ["xp"] = 1 },
    [29] = {["name"] = "Herring Seagull",          ["model"] = -164963696,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [30] = {["name"] = "Roseate Spoonbill",        ["model"] = -1076508705,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 2, ["xp"] = 2 },
    [31] = {["name"] = "Dominique Rooster",        ["model"] = 2023522846,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [32] = {["name"] = "Red-Footed Booby",         ["model"] = -466687768,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [33] = {["name"] = "Wester Raven",             ["model"] = -575340245,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [34] = {["name"] = "North American Racoon",    ["model"] = 1458540991,   ["item"] = "game",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [35] = {["name"] = "Black-Tailed Jackrabbit",  ["model"] = -541762431,   ["item"] = "game",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [36] = {["name"] = "American Pronghorn Doe",   ["model"] = 1755643085,   ["item"] = "venison",  ["poor"] = -983605026,  ["good"] = 554578289,   ["perfect"] = -1544126829, ["reward"] = 1, ["xp"] = 1 },
    [37] = {["name"] = "Greater Prairie Chicken",  ["model"] = 2079703102,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [38] = {["name"] = "Wirginia Possum",          ["model"] = -1414989025,  ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 2, ["xp"] = 3 },
    [39] = {["name"] = "Berkshire Pig",            ["model"] = 1007418994,   ["item"] = "pork",     ["poor"] = -308965548,  ["good"] = -57190831,   ["perfect"] = -1102272634, ["reward"] = 1, ["xp"] = 1 },
    [40] = {["name"] = "Ring-Necked Pheasant",     ["model"] = 1416324601,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [41] = {["name"] = "American White Pelican",   ["model"] = 1265966684,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [42] = {["name"] = "Blue And Yellow Macaw",    ["model"] = -1797450568,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 6, ["xp"] = 6 },
    [43] = {["name"] = "Panther",                  ["model"] = 1654513481,   ["item"] = "biggame",  ["poor"] = 1584468323,  ["good"] = -395646254,  ["perfect"] = 1969175294,  ["reward"] = 6, ["xp"] = 6 },
    [44] = {["name"] = "Californian Condor",       ["model"] = 1205982615,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [45] = {["name"] = "Dominique Chicken",        ["model"] = -2063183075,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [46] = {["name"] = "Double-Crested Cormorant", ["model"] = -2073130256,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [47] = {["name"] = "Cougar",                   ["model"] = 90264823,     ["item"] = "biggame",  ["poor"] = 1914602340,  ["good"] = 459744337,   ["perfect"] = -1791452194, ["reward"] = 4, ["xp"] = 4 },
    [48] = {["name"] = "Florida Cracker Cow",      ["model"] = -50684386,    ["item"] = "bird",     ["poor"] = 334093551,   ["good"] = 1150594075,  ["perfect"] = -845037222,  ["reward"] = 1, ["xp"] = 1 },
    [49] = {["name"] = "Coyote",                   ["model"] = 480688259,    ["item"] = "game",     ["poor"] = -1558096473, ["good"] = 1150939141,  ["perfect"] = -794277189,  ["reward"] = 2, ["xp"] = 2 },
    [50] = {["name"] = "Whooping Crane",           ["model"] = -564099192,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },   
    [51] = {["name"] = "Gila Monster",             ["model"] = 457416415,    ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [52] = {["name"] = "Alpine Goat",              ["model"] = -753902995,   ["item"] = "game",     ["poor"] = 699990316,   ["good"] = 1710714415,  ["perfect"] = -1648383828, ["reward"] = 2, ["xp"] = 2 },
    [53] = {["name"] = "Canada Goose",             ["model"] = 723190474,    ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [54] = {["name"] = "Ferruinous Hawk",          ["model"] = -2145890973,  ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [55] = {["name"] = "Great Blue Heron",         ["model"] = 1095117488,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 4, ["xp"] = 4 },
    [56] = {["name"] = "Green Iguana",             ["model"] = -1854059305,  ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 2, ["xp"] = 2 },
    [57] = {["name"] = "Desert Iguana",            ["model"] = -593056309,   ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 2, ["xp"] = 2 },
    [58] = {["name"] = "Peccary Pig",              ["model"] = 1751700893,   ["item"] = "pork",     ["poor"] = -99092070,   ["good"] = -1379330323, ["perfect"] = 1963510418,  ["reward"] = 1, ["xp"] = 1 },
    [59] = {["name"] = "Common Loon",              ["model"] = 386506078,    ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 1, ["xp"] = 1 },
    [60] = {["name"] = "Moose",                    ["model"] = -1098441944,  ["item"] = "biggame",  ["poor"] = 1868576868,  ["good"] = 1636891382,  ["perfect"] = -217731719,  ["reward"] = 3, ["xp"] = 3 },
    [61] = {["name"] = "American Muskrat",         ["model"] = -1134449699,  ["item"] = "stringy",  ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 2, ["xp"] = 2 },
    [62] = {["name"] = "Great Horned Owl",         ["model"] = -861544272,   ["item"] = "bird",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 3, ["xp"] = 3 },
    [63] = {["name"] = "Angus Ox",                 ["model"] = 556355544,    ["item"] = "biggame",  ["poor"] = 4623248928,  ["good"] = 1208128650,  ["perfect"] = 659601266,   ["reward"] = 1, ["xp"] = 1 },
    [64] = {["name"] = "Alligator",                ["model"] = -1892280447,  ["item"] = "biggame",  ["poor"] = 1806153689,  ["good"] = -802026654,  ["perfect"] = -1625078531, ["reward"] = 4, ["xp"] = 4 },
    [65] = {["name"] = "North American Beaver",    ["model"] = 759906147,    ["item"] = "game",     ["poor"] = -1569450319, ["good"] = -2059726619, ["perfect"] = 854596618,   ["reward"] = 2, ["xp"] = 2 },
    [66] = {["name"] = "American Black Bear",      ["model"] = 730092646,    ["item"] = "biggame",  ["poor"] = 1083865179,  ["good"] = 1490032862,  ["perfect"] = 663376218,   ["reward"] = 4, ["xp"] = 4 },

    [67] = {["name"] = "Longnose Gar",             ["model"] = -711779521,   ["item"] = "fish",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 0.3,  ["xp"] = 4  },
    [68] = {["name"] = "Muskie",                   ["model"] = -1553593715,  ["item"] = "fish",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 0.3,  ["xp"] = 4  },
    [69] = {["name"] = "Lake Sturgeon",            ["model"] = -300867788,   ["item"] = "fish",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 0.3,  ["xp"] = 4  },
    [70] = {["name"] = "Channel Catfish",          ["model"] = 1538187374,   ["item"] = "fish",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 0.3,  ["xp"] = 4  },
    [71] = {["name"] = "Northern Pike",            ["model"] = 697075200,    ["item"] = "fish",     ["poor"] = nil,         ["good"] = nil,         ["perfect"] = nil,         ["reward"] = 0.25, ["xp"] = 4  },
}


Config.shops = {
    {["name"] = "Saint Denis",["coords"] = vector3(2816.37, -1322.24, 46.61), ["gain"] = 1.11,},
    {["name"] = "Valentine", ["coords"] = vector3(-341.07, 767.35, 116.71), ["gain"] = 1.11,},
    {["name"] = "Rhodes", ["coords"] = vector3(1296.36, -1279.26, 75.84), ["gain"] = 1.11,},
    {["name"] = "Tumbleweed", ["coords"] = vector3(-5508.10, -2947.73, -1.87), ["gain"] = 1.11,},
     {["name"] = "Anusburg", ["coords"] = vector3(2932.54, 1302.00, 44.48), ["gain"] = 1.11,},
     {["name"] = "Van Horn", ["coords"] = vector3(2994.23, 571.79, 44.35), ["gain"] = 1.33,},
    {["name"] = "Blackwater", ["coords"] = vector3(-877.19, -1343.62, 43.29), ["gain"] = 1.11,},
    {["name"] = "Strawberry", ["coords"] = vector3(-1752.91, -394.74, 156.19), ["gain"] = 1.11,}
}
