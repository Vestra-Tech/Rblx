local UiName = "Vestra"
local Sounds = {
	"Android",
	"Bonk",
	"CsgoHeadshot",
	"Goof",
	"Headshot",
	"HitMarker",
	"Phonk",
	"Punch",
	"Slap",
}
local GameNames = {
    -- Fps Games
    "Arsenal",
    "Big Paintball",
    "Jailbird",
    "Phantom Forces",
    "Universal",
    -- Simulators
    "Bakery Simulator",
    "Bitcoin Miner",
    "Clicker Simulator",
    "Destruction Simulator",
    "Egg Farm Simulator",
    "Legends Of Speed",
    "Mining Simulator 2",
    "Ninja Legends",
    "Pet Simulator X",
    "Pressure Wash Simulator",
    "Scuba Diving At Quil Lake",
    "Tapping Simulator",
    -- Tycoons
    "Blood Moon Tycoon",
    "Millionaire Empire Tycoon"
}
if not isfolder(UiName) then
    makefolder(UiName)
end
if not isfolder(UiName.."\\Config") then
    makefolder(UiName.."\\Config")
end
for i,v in pairs(GameNames) do
    if not isfolder(UiName.."\\Config\\"..v) then
        makefolder(UiName.."\\Config\\"..v)
    end
end
if not isfolder(UiName.."\\Utility") then
    makefolder(UiName.."\\Utility")
end
if not isfile(UiName.."\\Utility\\Client.lua") then
   writefile(UiName.."\\Utility\\Client.lua", game:HttpGet("https://raw.githubusercontent.com/Vestra-Tech/Rblx/main/Utility/PfModules.lua"))
end
if not isfolder(UiName.."\\Utility\\Sounds") then
    makefolder(UiName.."\\Utility\\Sounds")
end
for i,v in pairs(Sounds) do
    if not isfile(UiName.."\\Utility\\Sounds\\"..v..".mp3") then
        writefile(UiName.."\\Utility\\Sounds\\"..v..".mp3", game:HttpGet("https://github.com/VestraTech/Vestra/raw/main/Roblox/Utilities/Sounds/"..v..".mp3"))
    end
end