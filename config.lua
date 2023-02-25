Config = {}
Config.Instruktor = "csb_englishdave"
Config.NewESX = true -- If you are using ESX LEGACY 1.9.0 or Above leave this on true!
Config.DebugZone = false -- Leave this on false
Config.Distanca = 3.5
Config.Auto = "sultan"
Config.Cekanje = 3000
Config.Item = true
Config.VozackaItem = "vozacka"
Config.KPMP = 3.6 -- KMH FOR MPH 2.236936
Config.MaxSpeed = 50
Config.MaxAllowedMistakes = 2
Config.Money = 'money' -- bank, black_money ....

Config.Tests = {
	{
		title = 'Vozacka B kategorije',
		description = "Price 300 $ ",
		event = 'gg:pokreni_pitanja_b_1',
		icon = 'fas fa-car',
		args = {price = 300, vehicle = 'sultanrs'}
	},
	{
		title = 'Vozacka A kategorije',
		description = "Price 300 $ ",
		event = 'gg:pokreni_pitanja_b_1',
		icon = 'fas fa-car',
		args = {price = 300, vehicle = 'fagio'}
	},
	{
		title = 'Vozacka C Kategorije',
		description = "Price 300 $ ",
		event = 'gg:pokreni_pitanja_b_1',
		icon = 'fas fa-car',
		args = {price = 300, vehicle = 'mule'}
	},
}

Config.Autoskola = {
    ["ped"] = { kordinate = vector3(214.36, -1399.92, 29.6), heading = 326.08, id = 408, velicina = 0.8 },
    ["vozilo"] = { kordinate = vector3(216.96, -1381.48, 29.96), heading = 269.12, },
}

Config.Markeri = {
	["lokacija1"] = {kordinata = vector3(221.76, -1405.76, 29.0),},
	["lokacija2"] = {kordinata = vector3(79.24, -556.44, 31.6),},
	["lokacija3"] = {kordinata = vector3(8.2, -263.84, 46.72),},
	["lokacija4"] = {kordinata = vector3(-439.36, -234.6, 35.56),},
	["lokacija5"] = {kordinata = vector3(-250.68, -639.16, 32.88),},
	["lokacija6"] = {kordinata = vector3(-281.56, -833.0, 31.08),},
	["lokacija7"] = {kordinata = vector3(-62.12, -944.68, 28.8),},
	["lokacija8"] = {kordinata = vector3(75.32, -999.76, 28.72),},
	["lokacija9"] = {kordinata = vector3(43.24, -1111.08, 28.56),},
	["lokacija10"] = {kordinata = vector3(-62.68, -1137.04, 25.28),},
	["lokacija11"] = {kordinata = vector3(-99.28, -1338.12, 28.76),},
	["lokacija12"] = {kordinata = vector3(-24.0, -1373.4, 28.76)},
	["lokacija13"] = {kordinata = vector3(66.6, -1374.48, 28.68),},
	["lokacija14"] = {kordinata = vector3(129.04, -1386.16, 28.72),},
	["lokacija15"] = {kordinata = vector3(224.76, -1412.56, 28.68),},
	["lokacija16"] = {kordinata = vector3(216.12, -1381.52, 29.96),},
}

function Notify(msg) 
	ESX.ShowNotification(msg)
end

function HelpNotify(msg, time)
	ESX.ShowHelpNotification(msg, time)
end