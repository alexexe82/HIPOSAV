-- Установка новой версии графической оболочки HIPOS (андроид)

local fs = require("filesystem")
local component = require("component")
local computer = require("computer")
local unicode = require("unicode")
local shell = require("shell")
local term = require("term")
local gpu = component.gpu
local screen = component.screen

local args, options = shell.parse(...)

local loadinfo = {
{
		"Если Вы находитесь в консоли  ",
		"и хотите вернуться в оболочку ",
		"наберите cd // чтоб перейти в ",
		"корневой каталог, а затем     ",
		"наберите HIPOSAV.lua          ",
},
	{
		"Для управления наноботами     ",
		"с планешета не забудьте       ",
		"установить в него плату       ",
		"беспроводной связи и зарядить ",
		"планшет и наноботов.          ",
},
	{
		"Если Вы обнаружили опечатку   ",
		"или баг или вам просто не     ",
		"нравится что-то в коде        ",
		"можете смело исправлять и, при",
		"желании, сообщить мне.        ",
},
	{
		"В сборнике программ           ",
		"используется код сторонних    ",
		"программистов, я благодарю    ",
		"всех кто участвовал и помогал,",
		"и тех кто просто играет.      ",
},
	{
		"Графическая оболочка может    ",
		"работать на ПК 2-го уровня и  ",
		"на планшете 2-го уровня.      ",
		"Создана специально под низкие ",
		"параметры.                    ",
},
	{
		"Спасибо за то, что выбрали    ",
		"эту графическую оболочку.     ",
		"Это значит, что мое время     ",
		"было потрачено с пользой.     ",
		"Приятной игры! =)             ",
},
		{
		"Спасибо за то, что выбрали    ",
		"эту графическую оболочку.     ",
		"Это значит, что мое время     ",
		"было потрачено с пользой.     ",
		"Приятной игры! =)             ",
},
	}
 term.clear()

scr1X, scr1Y = gpu.getResolution()
if scr1X > 100 or scr1Y > 30 then
scr1X,scr1Y = 100,30
gpu.setResolution(scr1X,scr1Y)
end

centrX,centrY = math.ceil(scr1X/2), math.ceil(scr1Y/2)

gpu.setForeground(0x66B6FF)
term.setCursor (centrX - 18, 1)
print ("Installation HIPOS android version.")
term.setCursor (centrX - 20, 2)
print ("Устанавливается ОС HIPOS андроид версия.")
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

-- print("Downloading HIPOS file list...")
local path = "/HIPOSAV/System/Files.cfg"
local URLs = {
EFI = "https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/master/bios.lua",
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

for i = 2, scr1X - 48 do
term.setCursor (i, scr1Y - 15)
print ("═")
term.setCursor (i, scr1Y - 1)
print ("═")
end
for i = scr1Y - 14, scr1Y - 2 do
term.setCursor (1, i)
print ("║")
term.setCursor (scr1X - 47, i)
print ("║")
end
term.setCursor (((scr1X - 47)/2)-4, scr1Y - 15)
print ("ИНФОРМАЦИЯ")

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
		infproc = math.ceil(((#loadinfo-1)/100)*du)
	        -- print(infproc.." ")
	for infstr = 1,5 do
		term.setCursor (2, scr1Y - 14 + infstr)
                print (loadinfo[infproc][infstr])
	end
	
	wget(applicationList.preInstall[i].url, applicationList.preInstall[i].path)
	end

gpu.setForeground(0xFFB680)

local web = require("web")
component.eeprom.set(web.request(URLs.EFI))
component.eeprom.setLabel("HipOS-BIOS")
for i = 1,5 do
	sec = 6 - i
 term.setCursor (centrX - 15, 8)
 print ("Перезапуск системы через "..sec.." сек")
	os.sleep(1)
end	


gpu.setForeground(0x66B6FF)
computer.shutdown(true)
--io.read()
