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

scr1X, scr1Y = gpu.getResolution()
centrX,centrY = math.ceil(scr1X/2), math.ceil(scr1Y/2)
term.setCursor (centrX - 25, 1)
print ("Version in developed... press enter for continue")
term.setCursor (centrX - 30, 2)
print ("Версия находится в разработке... нажмите enter для продолжения")
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

-- gpu.setForeground(0x66B6FF)
if not _G._OSVERSION or tonumber(_G._OSVERSION:sub(8, 10)) < 1.5 then
	term.setCursor (centrX - 40, 2)
	print ("Old version of OpenComputers mod detected: MineOS requires OpenComputers 1.5 or newer to work properly !")
end

local function wget(url, path)
	fs.makeDirectory(fs.path(path))
	-- shell.execute("wget " .. url .. " " .. path .. " -fq")
	loadfile("/bin/wget.lua")(url, path, "-fQ")
end

local function unserializeFile(path)
	local file = io.open(path, "r")
	local data = require("serialization").unserialize(file:read("*a"))
	file:close()
	return data
end

-- print("Downloading MineOS file list...")
local path = "/HIPOSAV/System/Files.cfg"
local URLs = {
applicationList = "https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/master/files.cfg",
	}
wget(URLs.applicationList, path)
applicationList = unserializeFile(path)
fs.remove(path)

term.setCursor (centrX - 20, 4)
print ("╔═══════════════════════════════════════╗")
term.setCursor (centrX - 20, 5)
print ("║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░║")
term.setCursor (centrX - 20, 6)
print ("╚═══════════════════════════════════════╝")
term.setCursor (centrX - 8, 7)
print ("                            ")
term.setCursor (centrX - 13, 7)
print ("")

        for i = 1, #applicationList.preInstall do
	du = math.ceil((100/#applicationList.preInstall)*i)
        term.setCursor (1, 3)
	-- print("Downloading library \" .. fs.name(applicationList.preInstall[i].path) .. "\          ")
		for d = 0,du do
		procent = math.ceil((38/100)*d)
		term.setCursor ((centrX - 20)+1+procent, 5)
		print ("█")
		end		
	for clstr = 1, scr1X-1 do
		term.setCursor (clstr, 8)
		print (" ")
	end
		term.setCursor (centrX - math.ceil(string.len(applicationList.preInstall[i].path.."      ")/2), 8)
		print (applicationList.preInstall[i].path.." ("..du.."%)")
		
	wget(applicationList.preInstall[i].url, applicationList.preInstall[i].path)
	end

gpu.setForeground(0x66B6FF)
io.read()
