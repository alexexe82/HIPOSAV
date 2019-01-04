-- ╭━━━╮╱╱╱╭╮╱╱╭╮╱╱╱╱╭━━┳━━━━╮
-- ┃╭━╮┃╱╱╱┃┃╱╱┃┃╱╱╱╱┃╭╮┃╭╮╭╮┃
-- ┃┃╱╰╋╮╭┳┫┃╭━╯┃╱╱╱╱┃╰╯╰┫┃┃╰╋━┳╮╭╮
-- ┃┃╭━┫┃┃┣┫┃┃╭╮┃╭━━╮┃╭━╮┃┃┃╱┃╭┫┃┃┃
-- ┃╰┻━┃╰╯┃┃╰┫╰╯┃╰━━╯┃╰━╯┃┃┃╭┫┃┃╰╯┃
-- ╰━━━┻━━┻┻━┻━━╯╱╱╱╱╰━━━╯╰╯╰┻╯╰━━╯
-- Создано на проекте ГБТ игроком MineCR
-- если нужен найдите меня на сервере Квантум guild-bt.ru
-- Обязательно вносите изменения и дополняйте код
-- Это можно делать бесплатно и за деньги
-- Развивайте свои знания, приятной игры


-- далее весь закомментированный код это просто отладочный материал
-- система динамическая, добавляя новую программу в таблицы переменных
-- она разместит ее на рабочем столе в  порядке ее добавления
-- три обязательные переменные должны соответствовать файлам в папках
-- соблюдать регистр и пути


-- оболочка для планшета ОК

local event = require("event")
local component = require("component")
local computer = require("computer")
local gpu = component.gpu
local term = require("term")
local shell = require("shell")
local image = require("image")
local ecs = require("ECSAPI")
local buffer = require("doubleBuffering")
local GUI = require("GUI")

-- переменные, таблицы с параметрами иконок и их ссылками на программы

--local oslogoup = image.load("HIPOSAV/IconsPic/oslogoup.pic")
--local imageLogo = image.load("HIPOSAV/IconsPic/Logo.pic")
local xScrM, yScrM = gpu.getResolution()
local xScr, yScr = gpu.getResolution()
local dop = 2
if xScr > 100 then
gpu.setResolution(100,30)
xScr = 100
end
if yScr > 30 then
gpu.setResolution(100,30)
yScr = 30
end
local xCen, yCen = math.ceil(xScr/2), math.ceil(yScr/2)

-- строка для тмп ___  iconEXIT.pic  Выключение ПК  tq.pic /HIPOSAV/tquest.lua
--desk1 = {}
--desk2 = {}
--desk3 = {}
local desk1 = {"iconNC.pic","iconNANO.pic","nano2.pic","tq.pic","battleship.pic","saper.pic","info.pic","chat.pic","ops.pic","pstb.pic","iconEXIT.pic","magnit.pic"}
local desk2 = {"/HIPOSAV/nc.lua","/HIPOSAV/nanobots.lua","/HIPOSAV/nanoplus.lua","/HIPOSAV/tquest.lua","/HIPOSAV/Battleship.lua","/HIPOSAV/saper.lua","/HIPOSAV/info.lua","/HIPOSAV/chat.lua","/HIPOSAV/ops.lua","/HIPOSAV/pstb.lua","/HIPOSAV/exit.lua","/HIPOSAV/magnit.lua"}
local desk3 = {"  Менеджер","Упр.нанитами"," Наноботы-2","   TQueST","Морской бой","   Сапёр","   Инфо ПК","     Чат","Диспетчер HDD","  Pastebin","Выключение ПК","   Магнит"}
local desk4 = {}
local desk5 = {}
exityn = 1
qt = 1


-- logo 2 sec (заставка на экране, не больше 2х секунд)

local foreg = {0x000000,0x0F0F0F,0x1E1E1E,0x2D2D2D,0x3C3C3C,0x4B4B4B,0x5A5A5A,0x696969,0x787878,0x878787,0x969696,0xA5A5A5,0xB4B4B4,0xC3C3C3,0xD2D2D2,0xE1E1E1,0xF0F0F0,0xFFFFFF}
local i = xCen-25
os.sleep(0.3)
term.clear()
os.sleep(0.3)
-- image.draw(xCen-25,yCen-5,imageLogo)
local logoandroid = {
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
term.setCursor (xCen - 22, yCen - 10 + i)
print (logoandroid[i])
end



local j = 0
gpu.setBackground(0x66DB00)
while i < xCen+25 do
  term.setCursor(i,yCen+8)
  gpu.setForeground(0x000000)
  gpu.setBackground(0x66DB00)
  print(">") 
  j = j + 1
  if j > 18 then j = 18 end
  gpu.setForeground(foreg[j])
  gpu.setBackground(0x000000)
  term.setCursor(xCen-10, yCen+11)
  print ("Создано на guild-bt.ru")
  i=i+1
  os.sleep(0.0005)
end
--gpu.setBackground(0x1E1E1E)
os.sleep(0.01)
term.clear()

maxX, maxY = 100, 30

-- desktop (функция отрисовки рабочего стола)
function desk()
--xScr, yScr = gpu.getResolution()
if xScrM < maxX then
gpu.setResolution(xScrM, yScrM)
 maxX = xScrM
end
if yScrM < maxY then
gpu.setResolution(xScrM, yScrM)
 maxY = yScrM
end
gpu.setResolution(maxX,maxY)
xScr, yScr = gpu.getResolution()
xCen, yCen = math.ceil(xScr/2), math.ceil(yScr/2)
gpu.setBackground(0x3392BF)
term.clear()
ln = ""
for line = 1,xScr do
ln = ln.." "
end
gpu.setBackground(0x002440)
term.setCursor(1,1)
print (ln)
gpu.setBackground(0x004980)
term.setCursor(1,2)
print (ln)
gpu.setBackground(0x006DBF)
term.setCursor(1,3)
print (ln)
--   ------------------------------- logo ANDRO  -------------
gpu.setBackground(0x002440)
gpu.setForeground(0x00B600)
term.setCursor(2,1)
print (" ▀▄ ▄███▄ ▄▀  ")
gpu.setBackground(0x004980)
term.setCursor(2,2)
print (" ▄██▀███▀██▄  ")
gpu.setBackground(0x006DBF)
term.setCursor(2,3)
print ("▄███████████▄ ")
gpu.setBackground(0x00B600)
gpu.setForeground(0x002440)
term.setCursor(5,3)
print ("HIPOSAV")
--  ----------------------------------  battery ------------------
-- batt = 100
local pwtotal = computer.maxEnergy()
local pwuse = computer.energy()
local batt = math.ceil((100/pwtotal)*pwuse)
gpu.setBackground(0x002440)
gpu.setForeground(0x00B600)
term.setCursor(xScr-8,1)
print ("▄▄▄▄▄▄ ")
gpu.setBackground(0x004980)
term.setCursor(xScr-8,2)
print ("█    ██")
term.setCursor(xScr-7,2)
print (batt.."%")
gpu.setBackground(0x006DBF)
term.setCursor(xScr-8,3)
print ("▀▀▀▀▀▀ ")
-- -----------------  отрисовка текущего Московского времени в трее  ------
gpu.setBackground(0x002440)
gpu.setForeground(0x00B600)
term.setCursor(xScr-19,1)
print ("╒═══════╕")
gpu.setBackground(0x006DBF)
term.setCursor(xScr-19,3)
print ("╘╤╦═══╤╦╛")
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x004980)
tday, tmon, tyear,rltimeh,rltimem,rltimes = ecs.getHostTime(0)
term.setCursor(xScr-19,2)
print ("МСК "..rltimeh..":"..rltimem)
--         ------------------------------------- иконка настроек -----------
gpu.setBackground(0x002440)
gpu.setForeground(0x00B600)
term.setCursor(xScr-27,1)
print ("║║║║║║")
gpu.setBackground(0x006DBF)
term.setCursor(xScr-27,3)
print ("║║║║║║")
term.setCursor(xScr-27,2)
gpu.setForeground(0x002440)
gpu.setBackground(0x00B600)
print ("option")
--  ------------------------------------------  текущее разрешение
gpu.setBackground(0x002440)
gpu.setForeground(0x00B600)
term.setCursor(xScr-40,1)
print ("╒═════════╕")
gpu.setBackground(0x006DBF)
term.setCursor(xScr-40,3)
print ("╘═DISPLAY═╛")
gpu.setForeground(0x00B600)
gpu.setBackground(0x004980)
term.setCursor(xScr-40,2)
print ("│         │")
term.setCursor(xScr-38,2)
gpu.setForeground(0x66FFFF)
local resdisp = ""..tostring(math.ceil(maxX)).." x "..tostring(math.ceil(maxY))
print (resdisp)
--                         ---------------------------        ---

tr1 = 1
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x334980)
--  -----  устаревшие элементы управления
--while tr1 < xScr-11 do
--term.setCursor(tr1,yScr-1)
--print (" ")
--tr1 = tr1 + 1
--end
-- gpu.setBackground(0x009240)
-- term.setCursor(1, yScr-1)
-- print ("Выход в консоль")
-- image.draw(xCen-10,2,oslogoup)
-- кнопка в углу
-- gpu.setForeground(0x000000)
-- gpu.setBackground(0x66DB00)
-- term.setCursor(1,1)
-- print ("ОПЦИИ")
-- ---------------------------        цикл отрисовки иконок и подписей к ним
local i=1
local mn = 1
  while i < #desk1+1 do
-- -----     перенос каждого следующего столбца на 15 символов вправо
if i == 1 then xtmp = 4 + dop end
if i == 4 then xtmp,mn = 18 + dop + dop,1 end
if i == 7 then xtmp,mn = 32 + dop + dop + dop,1 end
if i == 10 then xtmp,mn = 46 + dop + dop + dop + dop,1 end
ytmp = mn * 6
desk4[i] = ytmp+0
desk5[i] = xtmp+0
--print(desk4[i],desk5[i])
imgtmp = "/HIPOSAV/IconsPic/"..desk1[i]
local desktmp = image.load(imgtmp)
image.draw(xtmp,ytmp,desktmp)
term.setCursor(xtmp-2,ytmp+4)
gpu.setBackground(0x3392BF)
gpu.setForeground(0x1E1E1E)
print(desk3[i])
  mn = mn + 1
  i=i+1
  end
  
--gpu.setBackground(0x5A5A5A)
end

-- функция проверки клика по менюшке с настройками (разрешение и прочее)
function optionsm()
os.sleep(1)
local event, _, xmou2, ymou2 = event.pull(15)
   if event == "touch" then
    if ymou2 == 2 and xmou2 < 40 then
     maxX, maxY = 70, 24
	 dop = 0
    elseif ymou2 == 3 and xmou2 < 40 then
     maxX, maxY = 100, 30
	 if xScrM > 81 then
	 dop = 3
	 else
	 dop = 2
	 end
    elseif ymou2 == 4 and xmou2 < 40 then
     maxX, maxY = xScrM, yScrM
	 if maxX > 115 then
	 dop = 5
	 else
	 dop = 3
	 end
	elseif ymou2 == 6 and xmou2 < 40 then
	 shell.execute("cd //")
     shell.execute("/HIPOSAV/ops.lua")
	elseif ymou2 == 8 and xmou2 < 40 then
	 shell.execute("cd //")
     shell.execute("/HIPOSAV/exit.lua")
	elseif ymou2 == 10 and xmou2 < 40 then
     gpu.setBackground(0x000000)
     gpu.setForeground(0xFFFFFF)
     term.clear()
     exityn = 2
    elseif ymou2 == 12 and xmou2 < 40 then

    local mainContainer2 = GUI.container(1, 1, 50, 23)
mainContainer2:addChild(GUI.panel(1, 2, 45, 22, 0x2D2D2D))

local textBox = mainContainer2:addChild(GUI.textBox(2, 2, xCen + 25, 22, 0xEEEEEE, 0x2D2D2D, {}, 1, 1, 0))
mainContainer2:addChild(GUI.button(40, 3, 8, 3, 0x336DBF, 0xEEEEEE, 0xEEEEEE, 0x336DBF, "Exit")).onTouch = function()
mainContainer2:stopEventHandling()
buffer.clear(0x0)
buffer.draw(true)
end
local vers = {
" ",
" ",
"Версия 2.0 (Андроид) ",
"- Поддержка предыдущих версий прекращена ",
"- Изменены элементы интерфейса",
"- Заменен загрузчик и инсталлятор",
"- Заменены логотипы",
"- Переделан основной исполняемый файл",
"- Убраны устаревшие программы",
"- Добавлены функции в настройках",
"- Загрузка перенесена с Pastebin на GitHub",
"- Добавлено отображение заряда батареи",
"Версия 1.2",
"- Добавлена возможность смены разрешения экрана",
"- Исправлен выход в играх Сапер и Морской бой",
"- Переделана стартовая загрузка и установка ОС",
"- Добавлены графические библиотеки из MineOS",
"- Добавлена программа управления HDD и флоппи",
"- Добавлена программа авторизации на Pastebin ",
"Версия 1.1",
"- Исправлен баг с возвращением из программ",
"- Исправлена цветовая палитра при выходе с ОС",
"- Добавлена программа - межсерверный чат",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" ",
" "}
table.insert(textBox.lines, {text = "Журнал версий...(работает прокрутка мышью)", color = 0x880000})
 local v = 1
 while v < #vers+1 do 
 table.insert(textBox.lines, vers[v])
 v = v+1
 end
mainContainer2:draw()
buffer.draw(true)
mainContainer2:startEventHandling()
    elseif ymou2 == 14 and xmou2 < 40 then
	 shell.execute("cd //")
     shell.execute("/HIPOSAV/info.lua")
	end
   end
end

-- первоначальная функция проверки клика по объекту(далее перенесена в основное тело)

-- proverka klika
-- function touchwtf()
-- print(xmou, ymou)
-- i=1
--   while i < #desk1+1 do
--       ytou = desk4[i]+0
--       xtou = desk5[i]+0
--       --if ymou >= ytou and ymou <= ytou+4 and xmou >= xtou and xmou <= xtou+8 then
--       if ymou == 1 and xmou == 1 then
-- exityn = "exit"
--       --shell.execute("/HIPOS/"..desk2[i])
--       end
--   i=i+1
--   end
-- end


-- тело программы, проверка клика по иконкам, запуск 

while exityn ~= 2 do
  desk()
  if qt ~= 1 then exityn = 2 end
  ::menu::
  local event, _, xmou, ymou = event.pull(15)

  if event == "touch" then 

-- контекстное меню для настроек оболочки

   if ymou < 4 then
 gpu.setBackground(0x1E1E1E)
 gpu.setForeground(0xCCDBBF)
term.setCursor(1,1)
print ("╔═════════════════════════════════════════╗")
print ("║Разрешение 70x24  (видеокарта 2 уровня)  ║")
print ("║Разрешение 100x30 (видеокарта 3 уровня)  ║")
print ("║Разрешение maximum(максимально возможное)║")
print ("╠═════════════════════════════════════════╣")
print ("║Управление дисками (форматирование)      ║")
print ("╠═════════════════════════════════════════╣")
print ("║Выключение (перезагрузка)                ║")
print ("╠═════════════════════════════════════════╣")
print ("║Выход в консоль                          ║")
print ("╠═════════════════════════════════════════╣")
print ("║Информация о HIPOS(android ver.2.0)      ║")
print ("╠═════════════════════════════════════════╣")
print ("║Перечень компонентов системы с адресами  ║")
print ("╠═════════════════════════════════════════╣")
print ("║                                         ║")
print ("║                                         ║")
print ("║                                         ║")
print ("╚═════════════════════════════════════════╝")
optionsm()
  end
      i=1
       while i < #desk1+1 do
-- print (xmou,ymou)
yt = desk4[i]-0
xt = desk5[i]-0
         if ymou >= yt and ymou <= yt+4 and xmou >= xt and xmou <= xt+8 then
         shell.execute(desk2[i])
         end
       i=i+1
      end
   else goto menu
   end
end

gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
term.clear()
print ("(Чтобы запустить ОС в командной строке набери HIPOSAV.lua)")