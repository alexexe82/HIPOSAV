--        Programming&designed
--  ___  ____            _____ ______         
--  |  \/  (_)          /  __ \| ___ \        
--  | .  . |_ _ __   ___| /  \/| |_/ /        
--  | |\/| | | '_ \ / _ \ |    |    /         
--  | |  | | | | | |  __/ \__/\| |\ \         
--  \_|  |_/_|__ __|\___|\____/\_| \_|        

-- thx NEO, Totoro

local fs = require("Filesystem")
local event = require("Event")
local image = require("Image")
local GUI = require("GUI")
local screen = require("Screen")
local system = require("System")
local internet = require("Internet")
local text = require("Text")

local unicode = require('unicode')
--local term = require('term')
local com = require('component')
--local gpu = com.gpu



--   Константы   --
HOLOH = 32
HOLOW = 48

--     Цвета     --
backcolor = 0x000000
forecolor = 0xFFFFFF
infocolor = 0x0066FF
errorcolor = 0xFF0000
helpcolor = 0x006600
graycolor = 0x080808
goldcolor = 0xFFDF00
--      ***      --

-- размер
-- proxies.hologram.setScale(projectorScaleSlider.value)

filen = ""
local proxies = {}

function updateProxy(name)
	proxies[name] = component.list(name)()
	if proxies[name] then
		proxies[name] = component.proxy(proxies[name])
		return true
	end
end

updateProxy("hologram")

-- загружаем доп. оборудование
function trytofind(name)
  if com.isAvailable(name) then
    return com.getPrimary(name)
  else
    return nil
  end
end

h = proxies.hologram

function setHexColor(n, r, g, b)
  local hexcolor = rgb2hex(r,g,b)
  hexcolortable[n] = hexcolor
  darkhexcolors[n] = bit32.rshift(bit32.band(hexcolor, 0xfefefe), 1)
end
function rgb2hex(r,g,b)
  return r*65536+g*256+b
end

-- ========================================= H O L O G R A P H I C S ========================================= --
holo = {}
function set(x, y, z, value)
  if holo[x] == nil then holo[x] = {} end
  if holo[x][y] == nil then holo[x][y] = {} end
  holo[x][y][z] = value
end
function get(x, y, z)
  if holo[x] ~= nil and holo[x][y] ~= nil and holo[x][y][z] ~= nil then 
    return holo[x][y][z]
  else
    return 0
  end
end

function saveF(filename)
  -- сохраняем палитру
  file = io.open(filename, 'wb')
  for i=1, 3 do
    for c=1, 3 do
      file:write(string.char(colortable[i][c]))
    end
  end
  -- сохраняем массив
  for x=1, HOLOW do
    for y=1, HOLOH do
      for z=1, HOLOW, 4 do
        a = get(x,y,z)
        b = get(x,y,z+1)
        c = get(x,y,z+2)
        d = get(x,y,z+3)
        byte = d*64 + c*16 + b*4 + a
        file:write(string.char(byte))
      end
    end
  end
  file:close()
end

function loadF(filename)
  if true then -- fs.exists(filename) then
    -- file = fs.readTable(filename)
	file = fs.open(filename, 'rb')
    -- загружаем палитру
    for i=1, 3 do
      for c=1, 3 do
        colortable[i][c] = string.byte(file:read(1))
      end
      setHexColor(i,colortable[i][1],
                    colortable[i][2],
                    colortable[i][3])
    end
    -- загружаем массив
    holo = {}
    for x=1, HOLOW do
      for y=1, HOLOH do
        for z=1, HOLOW, 4 do
          byte = string.byte(file:read(1))
          for i=0, 3 do
            a = byte % 4
            byte = math.floor(byte / 4)
            if a ~= 0 then set(x,y,z+i, a) end
          end
        end
      end
    end
    file:close()
    return true
  else
  GUI.alert("Файл "..filen.." еще не скачан")
    --print("[ОШИБКА] Файл "..filename.." не найден.")
    return false
  end
end


function drawHologram()
  -- проверка на наличие проектора
  -- h = trytofind('hologram')
  if true then -- h ~= nil then
    local depth = h.maxDepth()
    -- очищаем
    h.clear()
    -- отправляем палитру
    if depth == 2 then
      for i=1, 3 do
        h.setPaletteColor(i, hexcolortable[i])
      end
    else
      h.setPaletteColor(1, hexcolortable[1])
    end
    -- отправляем массив
    for x=1, HOLOW do
      for y=1, HOLOH do
        for z=1, HOLOW do
          n = get(x,y,z)
          if n ~= 0 then
            if depth == 2 then
              h.set(x,y,z,n)
            else
              h.set(x,y,z,1)
            end
          end
        end
      end      
    end
  end
end

colortable = {{255, 0, 0}, {0, 255, 0}, {0, 102, 255}}
colortable[0] = {0, 0, 0}
hexcolortable = {}
darkhexcolors = {}
for i=0,3 do setHexColor(i, colortable[i][1], colortable[i][2], colortable[i][3]) end
brush = {color = 1, x = 8, gx = 8}
ghost_layer = 1
ghost_layer_below = true
layer = 1
view = 0
running = true



local Version = "box N1"
XScr, YScr = screen.getResolution()
fs.makeDirectory("/3dholo/")

local logo = [[180EFFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFD700▄FFAC00▄FFC900▄D5C900▄7EC900▄ABF400▄D7C400▄FFC900▄FFD600▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFAC00▄FFC400▄D5F400▄C9F400▄C9F400▄F4F400▄F4F400▄F4F400▄C9C400▄F4F400▄F4F400▄F4F400▄C9F400▄ABF400▄ACF400▄D7C900▄FFAA00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄C4C900▄F4C900▄F4F400▄F4F400▄F4F400▄F4F400▄F4F400▄C9C400▄F4F400▄F4F400▄F4F400▄F4F400▄F4F400▄F4F400▄C9AA00▄81C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄ABD600▄F4AA00▄F4C900▄F4C900▄F4C900▄F4C900▄C9C400▄F4C900▄F4C900▄F4C900▄F4C900▄F4C400▄C4C900▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄AAAB00▄AAC900▄AAC900▄AAC900▄AAC900▄93C900▄AAC900▄AAC900▄AAC900▄AAC900▄81AA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄ABAB00▄C9C900▄C9C900▄C9C900▄C9C900▄C4C400▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄ABAB00▄C9C900▄C9C900▄C9C900▄C9C900▄C9AA00▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄ABAB00▄C9C900▄C9C900▄C9C900▄C9C900▄C9C400▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄ABAB00▄C9C900▄C9C900▄C9C900▄C9C900▄C4C900▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6D600▄D6D600▄ABAB00▄C9C900▄C9C400▄C9C400▄C9C900▄93C900▄C9C900▄C9C400▄C9C400▄C9C900▄AAAA00▄D6D600▄D6D600▄C9C900▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ACAC00▄D6C900▄D6D500▄81AB00▄C4C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄81AA00▄C9D600▄D6D500▄C9AA00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄D7FF00▄C9AC00▄D6D600▄ABAB00▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄D6D600▄D6AB00▄ACFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ABD600▄AB8100▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄C9C900▄AAAA00▄C9C900▄D6FF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄ABFF00▄81FF00▄D7FF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄FFFF00▄]]
logo = image.fromString(logo)


local kat = {
{"magaz", "Светящаяся вывеска МАГАЗИН увеличит продажи"},
{"sword", "Меч разящий, клинок блестящий"},
{"elka", "Украшенная новогодняя елка"},
{"homehere", "Мой дом тут гласит эта вывеска"},
{"cola", "Надпись Кока-Кола для магазина(не реклама)"},
{"myhome", "Домик с надписью =Мой дом="},
{"earth", "Земля с надписью МАЙНКРафт"},
{"jahta", "Красивая яхта с алыми парусами"},
{"sol", "Схема солнечной системы"},
{"nuclear", "Ядерный взрыв - *гриб*"},
{"robot", "Голова робота"},
{"dobropo", "Надпись *добро пожаловать*"},
{"2020", "Новогодняя надпись *2020*"},
{"happy", "Надпись *С новым годом*"},
{"ballny", "Еловая веточка с шариком"},
{"snowman20", "Снеговик с метлой"},


}
 
local workspaceXY = GUI.workspace()
local xwd = workspaceXY.width - 15
local yhg = workspaceXY.height - 5
local linewd = "_"
local strZ = 1
for i = 1,xwd - 60 do
 linewd = linewd.."_"
end
 
local workspace, window = system.addWindow(GUI.titledWindow(1, 1, xwd, yhg - 5, "Prizm3d "..Version, true))
window:addChild(GUI.text(13,3, 0x004980, text.limit("Для удобства работы",40)))
window:addChild(GUI.text(16,4, 0x004980, text.limit("с приложением",40)))
window:addChild(GUI.text(12, 5, 0x004980, text.limit("используйте разрешение",40)))
window:addChild(GUI.text(15, 6, 0x004980, text.limit("не менее 140х48",40)))
window:addChild(GUI.text(18, 10, 0x004980, text.limit("вращение",40)))
window:addChild(GUI.text(19, 14, 0x004980, text.limit("размер",40)))
window:addChild(GUI.image(9, 16, logo))
window:addChild(GUI.text(13, 30, 0x004980, text.limit("Сборник голопроекций",40)))
window:addChild(GUI.text(12,31, 0x004980, text.limit("для проектора 2 уровня",40)))
window:addChild(GUI.text(16, 32, 0x004980, text.limit("в формате 3d",40)))
window:addChild(GUI.text(16,34, 0x004980, text.limit("Автор: MineCR",40)))
window:addChild(GUI.text(8, 36, 0x004980, text.limit("создано на проекте guild-bt.ru",40)))
window:addChild(GUI.text(46, yhg-7, 0x004980, text.limit("страница ",40)))
window:addChild(GUI.framedButton(9, 7, 8, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "left")).onTouch = function()
    h.setRotationSpeed(4,0,1,0)
  end
window:addChild(GUI.framedButton(19, 7, 8, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "stop")).onTouch = function()
    h.setRotationSpeed(0,0,1,0)
  end
window:addChild(GUI.framedButton(29, 7, 8, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "right")).onTouch = function()
    h.setRotationSpeed(-4,0,1,0)
  end
  
  window:addChild(GUI.framedButton(9, 11, 6, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "х1")).onTouch = function()
    h.setScale(1)
	h.setTranslation(0,0.3,0)
  end
window:addChild(GUI.framedButton(16, 11, 6, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "х2")).onTouch = function()
    h.setScale(2)
	h.setTranslation(0,0.5,0)
  end
window:addChild(GUI.framedButton(23, 11, 6, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "х3")).onTouch = function()
    h.setScale(3)
	h.setTranslation(0,0.8,0)
  end
  window:addChild(GUI.framedButton(30, 11, 6, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "х4")).onTouch = function()
    h.setScale(4)
	h.setTranslation(0,1,0)
  end
  
  
  
local listok = {}
local x, y, width, horizontalSpace, verticalSpace = 45, 3, 10, 2, 0
local mnogitel = 0
local lststr = math.ceil((yhg-5) / 4)
local lstmax = math.ceil(#kat / lststr)
local colred =  0xB62B00
for lst = 1, lstmax do --lst
window:addChild(GUI.framedButton(54+(6*lst), yhg - 8, 5, 3, 0x696969, 0x00B600, 0x880000, 0x880000, lst)).onTouch = function()
    for tmp = 1, lstmax do
    listok[tmp].hidden = true
    end
    listok[lst].hidden = false
        --  workspace:draw()
        end --button
listok[lst] = window:addChild(GUI.container(1, 1, xwd, yhg - 10))
if lst ~= 1 then listok[lst].hidden = true end
--listok[lst]:setCellAlignment(3, 1, GUI.alignment.horizontal.left, GUI.alignment.vertical.bottom)
--listok[lst].setCellAlignment(left,bottom)
local lmno = lststr+mnogitel
if lmno > #kat then lmno = #kat end
for i = 1+mnogitel, lmno do
-- local j = i
-- if j > #kat then j = #kat end
  listok[lst]:addChild(GUI.text(x, y, 0xB62B00,text.limit(kat[i][1],width)))
  listok[lst]:addChild(GUI.text(x+15, y , 0x696969, text.limit(kat[i][2],xwd- x-29)))
  listok[lst]:addChild(GUI.text(x, y + 1, 0xB62B00, text.limit(linewd,xwd- width-5)))
  --filen = "3dholo/" .. kat[i][1] .. ".3d"
  listok[lst]:addChild(GUI.framedButton(xwd - 22, y-1, width, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "Downld")).onTouch = function()
    filen = kat[i][1] .. ".3d"
    --workspace:draw()
    internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dholo/" .. filen, "/3dholo/" .. filen)
    GUI.alert("Загрузка завершена! Файл находится по адресу /3dholo/" .. filen)
  end
 
 -- кнопка отображения на проектор
 listok[lst]:addChild(GUI.framedButton(xwd - 11, y-1, width, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "Holo")).onTouch = function()
    filen = kat[i][1] .. ".3d"
    --workspace:draw()
    --internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dholo/" .. filen, "/3dholo/" .. filen)
    --GUI.alert("Загрузка завершена! Файл находится по адресу /3dholo/" .. filen)
	loadF("/3dholo/" .. filen)
	drawHologram()
	
  end
 
 
  y =  y + verticalSpace + 3
 
end
 y = 3
mnogitel = mnogitel + lststr
end --lst
 
 
workspace:draw()
