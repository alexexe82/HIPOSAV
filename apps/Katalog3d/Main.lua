--        Programming&designed
--  ___  ____            _____ ______         
--  |  \/  (_)          /  __ \| ___ \        
--  | .  . |_ _ __   ___| /  \/| |_/ /        
--  | |\/| | | '_ \ / _ \ |    |    /         
--  | |  | | | | | |  __/ \__/\| |\ \         
--  \_|  |_/_|_____|\___|\____/\_| \_|        
--    ___    |  ___|                          
--   ( _ )   | |_ _ __ ___  _ __  _   _ _ __  
--   / _ \/\ |  _| '__/ _ \| '_ \| | | | '_ \ 
--  | (_>  < | | | | | (_) | | | | |_| | | | |
--   \___/\/ \_| |_|  \___/|_| |_|\__,_|_| |_|

-- the English version can be downloaded at
-- https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/apps/Katalog3d/eng/Main.lua
-- sorry for the inconvenience

-- благодарочка Фронуну от Майна

local fs = require("Filesystem")
local event = require("Event")
local image = require("Image")
local GUI = require("GUI")
local screen = require("Screen")
local system = require("System")
local internet = require("Internet")
local text = require("Text")

local Version = "box N1"
XScr, YScr = screen.getResolution()
fs.makeDirectory("/3dm/")

local logo = [[28140000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF FFD700▄FFCF00▄FFCF00▄FFA400▄FF7800▄FF7300▄FF7300▄D74800▄CF4D00▄A44D00▄A44D00▄A44800▄CF4800▄D74800▄FF7300▄FFA400▄FFCF00▄FFD700▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF FFCF00▄FFA400▄D7A400▄CF9F00▄CF7300▄CF7800▄A47800▄A47800▄737800▄737800▄780000 780000 780000 4D7800▄4D7800▄4D7800▄4D7800▄4D7800▄4D7800▄4D7800▄4D0000 4D0000 4D0000 4D0000 4D0000 4D0000 487800▄737800▄A47800▄A47300▄CF7300▄FFA400▄FFA400▄FFD400▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 6D0000 423D00▄733D00▄784200▄A44200▄A47300▄A40000 A40000 78A400▄78A400▄78A400▄78A400▄78A400▄78A900▄78A900▄78A900▄78A900▄78A900▄78A900▄78A900▄780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 78A400▄78A400▄78A900▄78A900▄A4A900▄D7D400▄0000FF 0000FF 0000FF 6D0000 3D0000 3D0000 3D0000 3D0000 3D0000 423D00▄734200▄A44800▄A97800▄D4A400▄D40000 D40000 D40000 D40000 D40000 D40000 D40000 D40000 D40000 A90000 A90000 A90000 A9A400▄A9A400▄A40000 A40000 A40000 A4A900▄A4A900▄A4A900▄A90000 A90000 A90000 A90000 A90000 D40000 0000FF 0000FF 0000FF 423D00▄3D3800▄3D0000 3D0000 3D0000 3D4200▄420000 420000 424700▄424700▄487300▄787300▄A47800▄D47800▄D4A400▄D7A900▄D4A900▄D4A900▄D4A900▄A9A400▄A90000 A90000 A90000 A4A900▄A40000 A40000 A40000 A9A400▄A9A400▄A9A400▄A90000 A90000 A90000 A90000 A90000 A90000 D40000 0000FF 0000FF 0000FF 3D0000 380000 3D0000 3D0000 3D4200▄420000 420000 424800▄487300▄730000 737800▄780000 780000 780000 780000 A40000 A90000 A90000 A90000 A40000 A90000 A90000 A90000 A90000 A40000 A40000 A40000 A40000 A40000 A40000 A40000 A40000 A9A400▄A90000 A90000 A9A400▄D40000 0000FF 0000FF 0000FF 3D0000 380000 3D0000 3D0000 420000 420000 424700▄487300▄737800▄780000 780000 780000 780000 780000 78A400▄A9A400▄A90000 A90000 A90000 A40000 A90000 A90000 A90000 A90000 A40000 A40000 A40000 A40000 A40000 A40000 A40000 A40000 A40000 A90000 A90000 A40000 D40000 0000FF 0000FF 0000FF 3D0000 3D0000 3D0000 3D4200▄420000 420000 487300▄730000 780000 780000 780000 780000 780000 A47800▄780000 780000 A47800▄A97800▄A9A400▄A40000 A90000 A90000 A90000 A9A400▄A40000 A47800▄780000 780000 780000 A47800▄A47800▄A40000 A40000 A40000 A9A400▄A40000 D40000 0000FF 0000FF 0000FF 3D0000 3D0000 3D0000 420000 420000 420000 730000 730000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 A47800▄A97800▄A90000 A9A400▄A40000 A47800▄780000 780000 780000 780000 780000 780000 A47800▄A40000 A40000 A40000 A40000 D40000 0000FF 0000FF 0000FF 3D6800▄3D0000 3D0000 420000 420000 420000 734800▄730000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 780000 784800▄784800▄784800▄787300▄780000 780000 780000 780000 780000 780000 A47800▄A47800▄A47800▄D40000 0000FF 0000FF 0000FF 680000 3D0000 3D0000 420000 420000 420000 484700▄734800▄730000 730000 730000 780000 780000 780000 780000 780000 780000 787300▄784800▄734800▄480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 CF0000 0000FF 0000FF 0000FF 680000 3D0000 3D0000 3D0000 420000 420000 420000 420000 420000 484200▄484200▄484300▄480000 484D00▄484D00▄484D00▄4D0000 4D0000 4D0000 4D0000 4D0000 4D0000 484D00▄484D00▄480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 CF0000 0000FF 0000FF 0000FF 680000 3D3800▄3D3800▄3D0D00▄3D0D00▄3D1200▄3D1200▄120000 170000 171800▄430000 480000 480000 4D0000 4D0000 4D4800▄4D0000 4D0000 4D0000 4D0000 4D0000 4D4800▄4D4800▄4D0000 4D0000 4D0000 484D00▄480000 480000 184800▄430000 431800▄484300▄484300▄484300▄484300▄CF0000 0000FF 0000FF 0000FF 3DD700▄0D6D00▄120000 120000 120000 120000 120000 170000 170000 180000 430000 480000 480000 4D0000 4D4800▄480000 4D0000 4D0000 4D4800▄480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 184800▄184800▄180000 CF0000 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 3DD700▄129E00▄171200▄171800▄171800▄180000 184300▄430000 430000 480000 480000 480000 480000 4D0000 4D0000 4D0000 484D00▄480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 480000 48A400▄48D700▄73FF00▄A4FF00▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 9EFF00▄17CF00▄434200▄430000 430000 430000 434800▄480000 480000 480000 480000 4D0000 4D0000 4D0000 4D0000 4D0000 4D0000 484D00▄484D00▄484D00▄484D00▄480000 480000 48A400▄48D400▄73FF00▄CFFF00▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 72FF00▄42D700▄436D00▄484300▄480000 480000 480000 430000 4D0000 4D0000 4D0000 4D0000 4D0000 4D0000 4D4800▄4DA400▄48D400▄73FF00▄CFFF00▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 6DFF00▄439F00▄484300▄484300▄430000 4D0000 524D00▄4D7300▄4DA400▄48D700▄78FF00▄CFFF00▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 9FFF00▄42FF00▄78FF00▄CFFF00▄0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF 0000FF ]]
logo = image.fromString(logo)
local kat = {}
ru = 1

function ruen()
kat = {}
if ru == 1 then
kat = {
{"buttonbig", "Рычаг вкл|выкл (выдает сигнал редстоуна)"},
{"danger", "Знак опасности (Черный череп на желтом фоне)"},
{"oknosmall", "Окно маленькое (Можно закрывать жалюзи)"},
{"pushka", "Пушка старинная 17 век (Декор)"},
{"stolbeliy", "Белый стол с одной центральной ножкой (Как в столовой)"},
{"stulbeliy", "Белый стул, удобный, прочный, красивый"},
{"teledomofon", "Настенный телефон или домофон, белый"},
{"tribike", "Детский трехколесный велосипед, синий"},
{"urna", "Черная мусорная урна, внутри немного мусора"},
{"aclock", "Настенные аналоговые часы со стрелками"},
{"passdoor", "Кодовый дверной замок, уличный домофон (Декор)"},
{"kvakva", "Зеленая болотная лягушка"},
{"kolu4ka", "Колючая проволка на забор, спиральная (Декор)"},
{"Oskar", "Статуэтка `Оскар` лучшему игроку (Декор)"},
{"kotelok", "Котелок выживальщика над догорающим костром"},
{"turrel", "Муляж маленькой переносной оружейной туррели"},
{"brick", "Кирпичи через которые можно ходить (для тайников)"},
{"dendy", "Игровая восьмибитная приставка из девяностых"},
{"gus", "Белый гусь с красными лапками, как настоящий"},
{"pacman", "Типа ПакМан из игры, желтый и круглый"},
{"podarok", "Новогодний подарок, ставьте под ёлочку"},
{"yamaha", "Синтезатор Yamaha (звучит как пианина)"},
{"zvetok", "Красивый красный цветочек в горшочке (Декор)"},
{"clockdom", "Настенные часы *Домик* с маятником"},
{"colonna", "Колонна из каменного кирпича, круглая"},
{"microwave", "Микроволновая печь, белая, новая"},
{"minisol", "Миниатюрный настольный планетарий"},
{"tesseract", "Тессеракт, четырехмерный куб"},
{"umbrella", "Логотип корпорации Амбрелла (Umbrella)"},
{"apple", "Логотип компании Эпл (Apple)"},
{"mega", "Вывеска магазин МЕГА (4 блока)",4},
{"droid", "Боевой зеленый дроид (многоблочный)",4},
{"stulvint", "Винтажный стул со спинкой (2 блока)",2},
{"zanaveska", "Занавеска из бордовой ткани (2 блока)",2},
{"stolmassiv", "Массивный стол (Из темного дерева)"},
{"aperture", "Портальная пушка (Из игры PORTAL)"},
{"moto", "Мотоцикл Харлей Девидсон (4 блока)",4},
{"birdhome", "Скворечник для птичек на дерево"},
{"komod", "Комод под вещи из благородного дерева"},
{"ledtv", "Настенный плоский жк телевизор"},
{"microscop", "Микроскоп лабораторный, настольный"},
{"spongebob", "Кто проживает на дне океана? Губка Боб"},
{"tarantul", "Черный страшный паук, тарантул"},
{"veprhead", "Чучело саблезубого вепря на стену"},
{"zabor", "Красивый заборчик для вашего газона"},
{"monik", "Монитор выключенный, LED дисплей"},
{"onoff_m", "Маленький переключатель рычаг"},
{"onoff_r", "Переключатель рычаг в виде регулятора"},
{"wifi", "Значок вайфай, синий на белом фоне"},
{"strelka", "Деревянная стрелка указывающая путь"},
{"ussr", "Серп и Молот, отголоски СССР"},
{"ne4to", "Очень похоже на кота, но этот взгляд..."},
{"tank", "Миниатюрный танк, для поклонников WoT"},
{"kubok", "Кубок. Для чемпионов и победителей"},
{"minihome", "Маленький дом украсить лужайку"},
{"aquarium", "Аквариум с золотой рыбкой"},
{"aerofly", "Миниатюрный самолет. Сверхзвуковой"},
{"cooler", "Вентилятор настольный, если очень жарко"},
{"ecorp", "Логотип корпорации Е-корп из mr.Robot"},
{"flag_by", "Флаг в цвете. Беларусь."},
{"flag_de", "Флаг в цвете. Германия."},
{"flag_kz", "Флаг в цвете. Казахстан."},
{"flag_ru", "Флаг в цвете. Россия."},
{"flag_ua", "Флаг в цвете. Украина."},
{"flag_us", "Флаг в цвете. США."},
{"flag_eu", "Флаг в цвете. Евросоюз."},
{"flag_pi", "Флаг в цвете. Пиратский."},
{"4e", "Череп. Многоблочный",5},
{"rip", "Надгробие. Место под табличку"},
{"panda", "Большая панда, 16 блоков",16},
{"svd", "Снайперская винтовка Дегтярева, на стену",2},
{"2020NY", "Надпись 2К20, с новым 2020 вас (2 блока)",2},
{"elka", "Елочка с игрушками и звездой (2 блока)",2},
{"sanki", "Детские санки, почти новые"},
{"snegovik", "Снеговик с морковкой (2 блока)",2},

}
elseif ru == 0 then
 kat = {
{"buttonbig", "Lever on|off (outputs a Redstone signal)"},
{"danger", "Danger sign (Black skull on yellow background)"},
{"oknosmall", "The window is small (you Can close the blinds)"},
{"pushka", "Cannon vintage 17th century (decor)"},
{"stolbeliy", "White table with one Central leg (As in the dining room)"},
{"stulbeliy", "White chair, comfortable, durable, beautiful"},
{"teledomofon", "Wall phone or intercom, white"},
{"tribike", "Children's tricycle, blue"},
{"urna", "Black dustbin inside a bit rubbish"},
{"aclock", "Wall-mounted analog clock with hands"},
{"passdoor", "Code door locks, outdoor intercom (decor)"},
{"kvakva", "Green marsh frog"},
{"kolu4ka", "Barbed wire on the fence, spiral (decor)"},
{"Oskar", "Statuette `Oscar` for the best player (Deco)"},
{"kotelok", "The survivalist pot over the dying fire"},
{"turrel", "Dummy of a small portable gun turret"},
{"brick", "Bricks through which you can walk (for caches)"},
{"dendy", "Eight-bit game console from the 1990"},
{"gus", "White goose with red legs, like a real one"},
{"pacman", "PacMan from the game, yellow and round"},
{"podarok", "Christmas gift, put under the Christmas tree"},
{"yamaha", "Yamaha synthesizer (sounds like a piano)"},
{"zvetok", "Beautiful red flower in a pot (decor)"},
{"clockdom", "Wall clock *House* with pendulum"},
{"colonna", "A column of stone bricks, round"},
{"microwave", "Microwave, white, new"},
{"minisol", "Miniature table planetarium"},
{"tesseract", "Tesseract, four-dimensional cube"},
{"umbrella", "The logo of the umbrella Corporation"},
{"apple", "The logo of the company Apple"},
{"mega", "Sign shop MEGA (4 units)",4},
{"droid", "Combat green droid (multi-block)",4},
{"stulvint", "Vintage chair with back (2 blocks)",2},
{"zanaveska", "Burgundy fabric curtain (2 blocks)",2},
{"stolmassiv", "Massive table (Dark wood)"},
{"aperture", "Portal gun (From the game PORTAL)"},
{"moto", "Motorcycle Harley Davidson (4 blocks)",4},
{"birdhome", "Birdhouse for the birds in the tree"},
{"komod", "A chest of drawers for the things of wood"},
{"ledtv", "Wall mounted flat LCD TV"},
{"microscop", "Laboratory microscope"},
{"spongebob", "Who lives on the ocean floor? Sponge Bob"},
{"tarantul", "Black scary spider tarantula"},
{"veprhead", "Stuffed saber-toothed boar on the wall"},
{"zabor", "Beautiful fence for your lawn"},
{"monik", "The monitor is turned off, LED display"},
{"onoff_m", "Small switch lever"},
{"onoff_r", "Switch the lever in the regulator"},
{"wifi", "WiFi label"},
{"strelka", "arrow"},
{"ussr", "label USSR"},
{"ne4to", "black cat"},
{"tank", "green tank. WoT"},
{"kubok", "We are the champions..."},
{"minihome", "Mini home"},
{"aquarium", "Golden fish"},
{"aerofly", "top gun"},
{"cooler", "summer. hot"},
{"ecorp", "The logo of the Evil corp. mr.Robot"},
{"flag_by", "Flag. Belarus"},
{"flag_de", "Flag. Germany"},
{"flag_kz", "Flag. Kazahstan."},
{"flag_ru", "Flag. Russia"},
{"flag_ua", "Flag. Ukraina"},
{"flag_us", "Flag. USA"},
{"flag_eu", "Flag. Euro"},
{"flag_pi", "Flag. Pirat"},
{"4e", "Skeleton head. Multiblocks",5},
{"rip", "Tombstone"},
{"panda", "Big panda, 16 blocks",16},
{"svd", "sniper rifle (2 blocks)",2},
{"2020NY", "2020 (2 blocks)",2},
{"elka", "christmas tree (2 blocks)",2},
{"sanki", "children sledges"},
{"snegovik", "snowman (2 blocks)",2},
}
end
end 

ruen()
 
local pusto = "                                                               " 
local workspaceXY = GUI.workspace()
local xwd = workspaceXY.width - 15
local yhg = workspaceXY.height - 5
local linewd = "_"
local strZ = " страница "
for i = 1,xwd - 60 do
 linewd = linewd.."_"
end
 
local workspace, window = system.addWindow(GUI.titledWindow(1, 1, xwd, yhg - 5, "Katalog3d "..Version, true))
window:addChild(GUI.framedButton(1, 2, 9, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "ru/en")).onTouch = function()
 if ru == 1 then
 ru = 0
 elseif ru == 0 then
 ru = 1
 end
 settab()
 kat=nil
 listok=nil
 ruen()
 displist()
end
window:addChild(GUI.text(13,3, 0x004980, text.limit("Для удобства работы",40)))
window:addChild(GUI.text(16,4, 0x004980, text.limit("с приложением",40)))
window:addChild(GUI.text(12, 5, 0x004980, text.limit("используйте разрешение",40)))
window:addChild(GUI.text(15, 6, 0x004980, text.limit("не менее 140х48",40)))
window:addChild(GUI.image(2, 8, logo))
window:addChild(GUI.text(10, 30, 0x004980, text.limit("Сборник готовых 3д моделей",40)))
window:addChild(GUI.text(12,31, 0x004980, text.limit("для печати на принтере",40)))
window:addChild(GUI.text(16, 32, 0x004980, text.limit("в формате 3dm",40)))
window:addChild(GUI.text(16,34, 0x004980, text.limit("Автор: MineCR",40)))
window:addChild(GUI.text(8, 36, 0x004980, text.limit("создано на проекте guild-bt.ru",40)))
window:addChild(GUI.text(46, yhg-7, 0x004980, text.limit(strZ,40)))

local listok = {}
local x, y, width, horizontalSpace, verticalSpace = 45, 3, 10, 2, 0
local mnogitel = 0
local lststr = math.ceil((yhg-5) / 4)
local lstmax = math.ceil(#kat / lststr)
local colred =  0xB62B00

function settab()
    --strZ = lst
    for tmp = 1, lstmax do
    listok[tmp].hidden = true
    end
    listok[#listok].hidden = false
end

function displist()
 listok = {}
 x, y, width, horizontalSpace, verticalSpace = 45, 3, 10, 2, 0
 mnogitel = 0
 lststr = math.ceil((yhg-5) / 4)
 lstmax = math.ceil(#kat / lststr)
 colred =  0xB62B00
for lst = 1, lstmax do --lst
window:addChild(GUI.framedButton(54+(6*lst), yhg - 8, 5, 3, 0x696969, 0x00B600, 0x880000, 0x880000, lst)).onTouch = function()
    --strZ = lst
    for tmp = 1, lstmax do
    listok[tmp].hidden = true
    end
    listok[lst].hidden = false
        --  workspace:draw()
        end --button
listok[lst] = window:addChild(GUI.container(1, 1, xwd, yhg - 6))
listok[lst]:addChild(GUI.text(46, yhg-7, 0x004980, text.limit(tostring(lst).." страница ",40)))
strZ = tostring(lst).." страница "
if lst ~= 1 then listok[lst].hidden = true end
--listok[lst]:setCellAlignment(3, 1, GUI.alignment.horizontal.left, GUI.alignment.vertical.bottom)
--listok[lst].setCellAlignment(left,bottom)
local lmno = lststr+mnogitel
if lmno > #kat then lmno = #kat end
for i = 1+mnogitel, lmno do
-- local j = i
-- if j > #kat then j = #kat end
  listok[lst]:addChild(GUI.text(x, y, 0xB62B00,text.limit(kat[i][1],width)))
  listok[lst]:addChild(GUI.text(x+15, y , 0x696969, text.limit(kat[i][2]..pusto,xwd- x-29)))
  listok[lst]:addChild(GUI.text(x, y + 1, 0xB62B00, text.limit(linewd,xwd- width-5)))
  listok[lst]:addChild(GUI.framedButton(xwd - 11, y-1, width, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "Download")).onTouch = function()
    if kat[i][3] ~= nil and kat[i][3] > 1 then
    for modelnum = 1,kat[i][3] do -- многоблочные модели
    local file = kat[i][1] .. tostring(modelnum) .. ".3dm"
   
      -- workspace:draw()
      internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dm/" .. file, "/3dm/" .. file)
    end -- многоблочные модели энд
    GUI.alert("Загрузка завершена! Файлы находятся по адресу /3dm/")
    else
    local file = kat[i][1] .. ".3dm"
   
      --workspace:draw()
        internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dm/" .. file, "/3dm/" .. file)
    GUI.alert("Загрузка завершена! Файл находится по адресу /3dm/" .. file)
   end
  end
 
  y =  y + verticalSpace + 3
 
end
 y = 3
mnogitel = mnogitel + lststr
end --lst
end -- displist

displist()

workspace:draw()
