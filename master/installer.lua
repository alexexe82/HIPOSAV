-- Установка новой версии графической оболочки HIPOS (анроид)

local fs = require("filesystem")
local component = require("component")
local computer = require("computer")
local unicode = require("unicode")
local shell = require("shell")
local term = require("term")
local gpu = component.gpu
local screen = component.screen

local args, options = shell.parse(...)

 term.clear()
print ("Version in developed... press enter for continue")
print ("Версия находится в разработке... нажмите enter для продолжения")
scr1X, scr1Y = gpu.getResolution()
term.setCursor (scr1X - 46, scr1Y - 16)
logoandroid = {
"           ▄                     ▄       ",
"            █    ▄▄▄▄▄▄▄▄▄▄▄    █        ",
"             █ ▄█████████████▄ █         ",
"            ▄███████████████████▄        ",
"           ███████████████████████       ",
"          █████• ██████████• ██████      ",
"         ███████████████████████████     ",
"         ███████████████████████████     ",
"   ▄██▄  ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ▄██▄ ",
"  ██████ ▌ ██ ▐▌ ▐█   ▀█▀   ▀█▀   ▀█ ██████",
"  ██████ ▌ ██ ▐█▄██ █▄ ▐ ▄█▄ █ ▐██▄█ ██████",
"  ██████ ▌    ▐   █ ▀ ▄█ ███ █▄   ▀█ ██████",
"  ██████ ▌ ██ ▐▌ ▐█ ▐███ ▀█▀ █▀██▌ ▐ ██████",
"  ██████ ▌ ██ ▐   █ ▐███▄   ▄█▄   ▄█ ██████",
"  ██████ ███████████████████████████ ██████"}

for i = 1, #logoandroid do
gpu.setForeground(0x00B600)
term.setCursor (scr1X - 44, scr1Y - 16 + i)
print (logoandroid[i])
end

gpu.setForeground(0x66B6FF)
if not _G._OSVERSION or tonumber(_G._OSVERSION:sub(8, 10)) < 1.5 then
	print ("Old version of OpenComputers mod detected: MineOS requires OpenComputers 1.5 or newer to work properly !")
end

local function wget(url, path)
	fs.makeDirectory(fs.path(path))
	shell.execute("wget " .. url .. " " .. path .. " -fq")
end

local function unserializeFile(path)
	local file = io.open(path, "r")
	local data = require("serialization").unserialize(file:read("*a"))
	file:close()
	return data
end

-- print("Downloading MineOS file list...")
local path = "/HIPOSAV/System/Files.cfg"
local fcfg = "https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/master/files.cfg"
wget(fcfg, path)
applicationList = unserializeFile(path)
fs.remove(path)

for i = 1, #applicationList.preInstall do
 term.setCursor (1, 4)
	--print("Downloading library \" .. fs.name(applicationList.preInstall[i].path) .. "\          ")
	wget(applicationList.preInstall[i].url, applicationList.preInstall[i].path)
	end

gpu.setForeground(0x66B6FF)
io.read()
