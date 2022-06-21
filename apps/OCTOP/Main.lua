--        Programming&designed
--  ___  ____            _____ ______         
--  |  \/  (_)          /  __ \| ___ \        
--  | .  . |_ _ __   ___| /  \/| |_/ /        
--  | |\/| | | '_ \ / _ \ |    |    /         
--  | |  | | | | | |  __/ \__/\| |\ \         
--  \_|  |_/_|__ __|\___|\____/\_| \_|        

-- thx NEO, Totoro

--------------------------------------------------------------------

local fs = require("Filesystem")
local event = require("Event")
local image = require("Image")
local GUI = require("GUI")
local screen = require("Screen")
local system = require("System")
local internet = require("Internet")
local text = require("Text")

--------------------------------------------------------------------



local Version = "1.0"
XScr, YScr = screen.getResolution()
fs.makeDirectory("/OCTOP/")


local logo = [[6E09D7D700▄D7D700▄D7D700▄D7C500▄CABA00▄C08A00▄BB5E00▄C08F00▄F58F00▄D7D700▄D7D700▄D6C500▄C58F00▄F08F00▄C58F00▄C58F00▄F08F00▄D7CA00▄D7FA00▄CAC500▄F08F00▄C58F00▄C58F00▄F08F00▄C58F00▄CABA00▄F5C000▄CABF00▄C58F00▄F5C000▄D7D600▄D7CA00▄CABF00▄F08F00▄D6C500▄D7D700▄D7CA00▄F5C000▄C58F00▄BB5E00▄C08A00▄CABF00▄D7D600▄D7D700▄D7D700▄D7C500▄C5BA00▄BB5E00▄BB5E00▄C08F00▄D7C500▄D7D700▄D7D700▄C58F00▄F08F00▄C58F00▄FAC500▄D7D700▄CAC000▄F08F00▄C58F00▄F59500▄D6C500▄F5BF00▄C58F00▄C58F00▄F08F00▄C58F00▄F59500▄D7D600▄D6C500▄C5BA00▄F59000▄D6CA00▄D7D700▄FAC500▄C58F00▄C58F00▄F5BB00▄C58F00▄C58F00▄F08F00▄C58F00▄C58F00▄C58F00▄F08F00▄CABB00▄F08F00▄C58F00▄C58F00▄F08F00▄C58F00▄C58F00▄F5C000▄CA8F00▄C58F00▄F08F00▄C58F00▄C58F00▄F58F00▄D6C500▄D7F500▄D7D600▄D7C500▄CABF00▄BB5E00▄BB8900▄C08A00▄D7CA00▄D7D700▄D7D700▄D7D600▄D7BB00▄8A0000▄2D2800▄292C00▄295800▄2C2C00▄2D2800▄C55800▄FA9000▄BA8F00▄2C2800▄2C0100▄2C5800▄312C00▄2C2900▄902C00▄C58500▄8F8A00▄2C2800▄2C2C00▄2C5800▄2C3200▄2C5800▄5D5900▄8BB600▄595D00▄2C0000▄5E2900▄C08900▄C5C000▄5E5D00▄582C00▄8F9000▄F5C000▄8F2C00▄5D0000▄2C2C00▄285800▄2C2C00▄2D2800▄C55800▄D7C000▄D68F00▄8A2800▄2D2800▄285800▄295800▄2C2C00▄8A2800▄C55800▄FA9000▄582C00▄2C2800▄582800▄8F5E00▄CAC000▄892D00▄2C2800▄2C0000▄5E5800▄B6B600▄5E5800▄2C2900▄2C2D00▄2C2D00▄2C2900▄580000▄C58A00▄BA8A00▄582D00▄582D00▄C0BF00▄D6D700▄8F8F00▄582C00▄2C2800▄858500▄2D5E00▄2C5800▄2C2C00▄2C2800▄2C2D00▄2C5800▄315800▄595900▄2C2800▄2C2900▄2C5800▄2C5800▄2C5D00▄2C5800▄8A8A00▄582D00▄2C2800▄2C2C00▄2C5800▄2C5800▄2D2800▄5D2800▄C05800▄CA8A00▄8A2800▄582800▄295800▄015D00▄2C2C00▄8A2C00▄CA8A00▄D7D700▄CAC000▄8A5D00▄002800▄2C5E00▄8AC500▄C0D700▄8AC000▄2C5D00▄2C2800▄8A5900▄8A8A00▄282800▄2D2C00▄C0F500▄8AC000▄585800▄2C2C00▄855900▄858500▄282800▄595800▄BBBB00▄C0C500▄C0C500▄C5CA00▄C0C000▄585D00▄282800▄000000▄2D2900▄C0B600▄585D00▄2C2C00▄8F8A00▄B68A00▄000000▄295800▄5EBA00▄C0CF00▄8ABF00▄2C5900▄2D8A00▄B58B00▄8A5800▄002900▄2C5E00▄C0D700▄C0D700▄8AC000▄002800▄2C2800▄8A8A00▄2C2C00▄282800▄282800▄582C00▄BB8A00▄2C2C00▄002800▄282800▄5D5800▄8BB600▄585E00▄2C2C00▄8A8B00▄BAC500▄588A00▄282C00▄585800▄868500▄2C2D00▄585D00▄C09400▄D7FA00▄8F8F00▄2D2C00▄282800▄BBC000▄C0D600▄90BF00▄582D00▄000000▄8A8F00▄C0F500▄C5D700▄585800▄290100▄2C2C00▄BBC000▄C5C500▄C0C000▄C5C500▄C5F500▄2C2C00▄282800▄2C2D00▄C0CA00▄C0CA00▄2C2C00▄002800▄2C2C00▄5E8A00▄282800▄2C2800▄BB8A00▄BB9000▄5E8A00▄298A00▄598F00▄FACF00▄BFC000▄2D5800▄2C2C00▄8F8F00▄F5FA00▄D7D700▄F5CA00▄8F8F00▄000000▄585800▄858600▄280000▄2C0000▄582800▄2C2800▄290000▄2D5D00▄8ABB00▄858A00▄282800▄282800▄280100▄282800▄282C00▄8A8A00▄BBBB00▄585D00▄2C2D00▄2C5800▄282C00▄592D00▄585800▄2C2C00▄858A00▄598500▄282800▄5D5E00▄C5C500▄D7D700▄D7D700▄D7D600▄D6FA00▄BF9000▄2D5700▄2C2D00▄BA8F00▄D7D700▄D7D700▄F5CA00▄2C2C00▄000000▄585800▄2D2C00▄282800▄2C2C00▄2C2800▄595800▄002800▄2C2D00▄2C2C00▄5E5800▄8BB600▄585D00▄290000▄580000▄2D2800▄290000▄002800▄5EB500▄8A9000▄2C5700▄582D00▄C0C000▄D6D700▄8F8F00▄2C2D00▄280000▄C0C500▄D7D600▄C0BF00▄582D00▄002800▄8F8F00▄D6F500▄D7D700▄5D5800▄282900▄280000▄282C00▄282800▄282C00▄2C2D00▄90B500▄2C2D00▄282800▄280000▄2C2800▄2C0000▄282C00▄2C5D00▄5DBB00▄C0D500▄589000▄285800▄002900▄280000▄282800▄8A2C00▄C08A00▄FAD700▄C0C500▄585D00▄292800▄8A5800▄C5BF00▄D7CA00▄C5C000▄892D00▄282900▄585900▄8A8A00▄002800▄2C2D00▄8AC500▄63F500▄8FCA00▄F5D700▄CAF500▄8F8F00▄282800▄585900▄BBC000▄C5D600▄C5F500▄D5F500▄C0C500▄5D5800▄2C2D00▄8B8A00▄85BB00▄280000▄282800▄2C5700▄8AAF00▄84AE00▄2BAD00▄58AE00▄C08F00▄D7F500▄C08F00▄595700▄8A5700▄8A8500▄588900▄2C2800▄8A8300▄D7EE00▄D7EE00▄C5B900▄285600▄282C00▄588A00▄2D5700▄282800▄585900▄282800▄282800▄2C5700▄598400▄572C00▄5E5800▄B6B600▄585800▄2C3100▄588A00▄8FEF00▄8FC500▄C0EF00▄D6E900▄BBB900▄2C8300▄2D5700▄BFBA00▄CFCA00▄8F8A00▄2C2900▄002800▄C0DF00▄F4E300▄BAB300▄575700▄282800▄8F8F00▄F5FA00▄D7D700▄5E5800▄282900▄2C2C00▄C0C500▄C5F500▄C5D500▄F5F500▄CACA00▄2C5700▄282800▄2C2D00▄8ABB00▄2C5D00▄2C2800▄5E2C00▄C5B500▄8A2D00▄582800▄8A2C00▄C0C500▄BBCA00▄5D8F00▄282800▄2D2C00▄D7D700▄CAD700▄8FF500▄005800▄2C2800▄5D2800▄8F2800▄5D0000▄2C2C00▄2C9400▄8AF500▄B68F00▄002800▄2C2D00▄FAD600▄D7D700▄D7D700▄D7D700▄CFF500▄8F8F00▄280000▄580000▄8A0000▄8F2800▄8F0000▄8F2D00▄BB8A00▄585900▄2C2C00▄8F9500▄C0FA00▄2C8900▄00AD00▄82AE00▄D8B900▄D8EF00▄DD8A00▄AE2C00▄840000▄BAAD00▄AED800▄83D800▄82E400▄AEEE00▄AEEF00▄568300▄82AE00▄D88200▄D85600▄D85600▄ADD800▄83DE00▄8AEE00▄83D900▄82D800▄598600▄2C5800▄000000▄57D800▄D9AD00▄825600▄57AD00▄B4D800▄AED800▄828300▄AEB400▄E8F400▄EEF400▄E9DE00▄D8E300▄D8C400▄D8B900▄AED800▄B4D800▄BA5600▄585600▄2BAD00▄56D800▄D8EF00▄D8D500▄D8BF00▄825800▄2B0000▄8F8F00▄F5D600▄D7D700▄5D5800▄012800▄2C0000▄8F2800▄8F0000▄8F2800▄8F2800▄8F5800▄2D2D00▄002800▄2C2C00▄F5FA00▄8FCA00▄282D00▄2C0000▄5E2800▄588B00▄285800▄292C00▄8F0000▄BA2800▄5E0000▄005800▄588F00▄D7D700▄D7D700▄D7D700▄8FFF00▄59D700▄2DFA00▄2CD600▄58D600▄5ED700▄F5D700▄D6D700▄C0D700▄58D600▄58D700▄FAD700▄D7D700▄D7D700▄D7D700▄D6D700▄90D700▄58D600▄2DD700▄58D700▄2DD700▄58D600▄5DFA00▄B6D700▄8AD700▄58D700▄C0D600▄D6D700▄E4EE00▄D8DD00▄AFD800▄BAD800▄D5D800▄C0EE00▄8AD600▄58EE00▄D8D800▄D9DE00▄B4E300▄C9D800▄D7DE00▄D6F400▄B9E300▄D8D800▄57D800▄2CD800▄82DE00▄D8F400▄E8D600▄C9D700▄D9DD00▄D8DE00▄8BD700▄8AF400▄57E300▄D8E400▄AEF900▄84C900▄D8D800▄D9DE00▄AEE300▄84D900▄8FDD00▄D7D600▄EEE900▄DED800▄EEDD00▄F4D800▄BED900▄D8EE00▄AED600▄57F500▄ADBE00▄D8DD00▄DED800▄F9D800▄D6D800▄C0EE00▄59D600▄58D700▄8FD700▄FAD700▄D7D700▄8AD700▄58D700▄2DD600▄58D700▄2DD700▄58D600▄2DFA00▄8AD600▄58D700▄58D700▄59D700▄D6D700▄D7D700▄8AD700▄58D600▄58D600▄BBD700▄BAD700▄5ED700▄2CFA00▄2CF500▄2DD600▄BAD700▄CAD700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D6D700▄E9D700▄E9D600▄E3EE00▄DEDE00▄E3E900▄D5F400▄E9E800▄D8D800▄D8E300▄DDE900▄B9F400▄EED600▄D6D700▄DED800▄D8DD00▄D8E400▄D8DE00▄DDD800▄D6EE00▄D7D600▄D7D700▄DEDD00▄DDDE00▄D6F400▄EEDE00▄DED800▄C3F900▄D7D700▄EEE900▄D8D800▄D8E300▄D8E900▄B8F400▄E9D600▄F4EE00▄E3DE00▄D8D800▄D8E900▄D8DE00▄D8D800▄D6E900▄D7D600▄D7D700▄F4D700▄EED600▄E4D600▄E3EE00▄DEDD00▄E9E900▄D6D600▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄F4F900▄E9DE00▄EEDD00▄E3E300▄DEEE00▄DDD500▄D5D700▄E9EE00▄D8DE00▄E9DE00▄BEE300▄E3E900▄DDD600▄EFD700▄F4F400▄D8E900▄E9CE00▄D7D700▄D6D700▄E9D700▄D8E300▄E9EE00▄D6D700▄DEF400▄D8E300▄DDE400▄DDC900▄EED700▄D7D700▄EFF400▄DEE300▄E8DE00▄E9B800▄E3E900▄D8D600▄EED700▄E3E900▄D8BE00▄E3F400▄D4D700▄D6D700▄EED700▄D8E900▄E8EE00▄E9EF00▄EEDE00▄EEDD00▄EEDE00▄D8C300▄DED600▄D5D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄D7D700▄]]
logo = image.fromString(logo)

local kat = {
{
name = "SofQ",
site = "guild-bt.ru",
vers = "1.7.10",
opis1 = "opencomputers",
opis2 = "whitelist, pve",
opis3 = "no wipes"
},
{
name = "SofQ2",
site = "guild-bt.ru",
vers = "1.7.10",
opis1 = "opencomputers",
opis2 = "whitelist, pve",
opis3 = "no wipes"
},
{
name = "SofQ3",
site = "guild-bt.ru",
vers = "1.7.10",
opis1 = "opencomputers",
opis2 = "whitelist, pve",
opis3 = "no wipes"
},
}

ru = 1


local function loadKat()
    internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/apps/OCTOP/rating.dat", "/OCTOP/rating.dat")
end


local function readKat()
    kat = nil
	kat = fs.readTable("/OCTOP/rating.dat")
end



local function ruen()

if ru == 1 then

lclz = {
head1 = "Для удобства работы       ",
head2 = "с приложением             ",
head3 = "используйте разрешение    ",
head4 = "не менее 140х48           ",
down1 = "Сервера с модом opencomputers   ",
down2 = "пишите в комментариях           ",
down3 = "к приложению и я добавлю        ",
avtor = "Автор: MineCR                   ",
made = "создано на проекте guild-bt.ru   ",
strZruen = " страница ",
alertFile = "Данные не скачаны",

}

elseif ru == 0 then
 lclz = {
head1 = "for ease of operation,    ",
head2 = "set the resolution        ",
head3 = "to at least               ",
head4 = "140х48                    ",
down1 = "Servers with mod opencomputers ",
down2 = "write in the comments          ",
down3 = "in the store and I will add    ",
avtor = "Author: MineCR                 ",
made = "made on a project guild-bt.ru   ",
strZruen = " page     ",
alertFile = "download is failure",

}

end
end 

ruen()
 
local pusto = "                                                               " 
local workspaceXY = GUI.workspace()
local wrkspcX = workspaceXY.width - 2
local wrkspcY = workspaceXY.height - 1
local strZ = lclz.strZruen
local linewd =  "╠════════════════════╬══════════════════════╬═════════╬"
for i = 1,wrkspcX - 110 do
 linewd = linewd.."═"
end
 linewd = linewd.."╣"
 
local lineser = "║                    ║                      ║         ║"
for i = 1,wrkspcX - 110 do
 lineser = lineser.." "
end
 lineser = lineser.."║"
 
 
local workspace, window = system.addWindow(GUI.titledWindow(1, 1, wrkspcX, wrkspcY - 1, "OpenComputers Servers "..Version, true))


window:addChild(GUI.roundedButton(10, 13, 18, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "ОБНОВИТЬ")).onTouch = function()
loadKat()
readKat()

displist()
end

window:addChild(GUI.roundedButton(10, 17, 18, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "REFRESH")).onTouch = function()
loadKat()
readKat()

displist()
end

window:addChild(GUI.framedButton(3, wrkspcY-18, 9, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "ru/en")).onTouch = function()
 if ru == 1 then
 ru = 0
 elseif ru == 0 then
 ru = 1
 end
 settab()
 --kat=nil
 listok=nil
 ruen()
 displist()
 headerFooter()
end

-- filesystem.exists(string path): boolean exists

local function headerFooter()
window:addChild(GUI.text(3,wrkspcY-14, 0x004980, text.limit(lclz.head1,40)))
window:addChild(GUI.text(3,wrkspcY-13, 0x004980, text.limit(lclz.head2,40)))
window:addChild(GUI.text(3,wrkspcY-12, 0x004980, text.limit(lclz.head3,40)))
window:addChild(GUI.text(3,wrkspcY-11, 0x004980, text.limit(lclz.head4,40)))
window:addChild(GUI.text(3,wrkspcY-9, 0x004980, text.limit(lclz.down1,40)))
window:addChild(GUI.text(3,wrkspcY-8, 0x004980, text.limit(lclz.down2,40)))
window:addChild(GUI.text(3,wrkspcY-7, 0x004980, text.limit(lclz.down3,40)))
window:addChild(GUI.text(3,wrkspcY-5, 0x004980, text.limit(lclz.avtor,40)))
window:addChild(GUI.text(3,wrkspcY-4, 0x004980, text.limit(lclz.made,40)))
end

window:addChild(GUI.text(45, wrkspcY-3, 0x004980, text.limit(strZ,40)))

window:addChild(GUI.image((window.width/2)-55, 3, logo))
--window:addChild(GUI.image(, 8, logo))
headerFooter()

local listok = {}
local x, y, width, horizontalSpace, verticalSpace = 40, 3, 10, 2, 0
local mnogitel = 0
local lststr = math.ceil((wrkspcY-11) / 6) -- тут 4 это ширина строки увеличивать вручную плюс 2 строки описания а 5 это отступ от верха прибавляем еще 10-------------------------------------------------------
local lstmax = math.ceil(#kat / lststr)
--local colred =  0xB62B00
local colred =  0xFFFFFF

function settab()
    --strZ = lst
    for tmp = 1, lstmax do
    listok[tmp].hidden = true
    end
    listok[#listok].hidden = false
end

function displist()
 
 listok = {}
 listok = nil
 listok = {}
 x, y, width, horizontalSpace, verticalSpace = 40, 3, 10, 2, 0     
 mnogitel = 0
 lststr = math.ceil((wrkspcY-11) / 6) -- тут 4 это ширина строки увеличивать вручную плюс 2 строки описания---- для просчета листов---------------------------------------------------
 lstmax = math.ceil(#kat / lststr)
 colred =  0xFFFFFF
for lst = 1, lstmax do --lst записываем на каждый лист данные из kat
window:addChild(GUI.framedButton(51+(6*lst), wrkspcY - 4, 5, 3, 0x696969, 0x00B600, 0x880000, 0x880000, lst)).onTouch = function()
    --strZ = lst
    for tmp = 1, lstmax do -- делаем нумерацию внизу
    listok[tmp].hidden = true
    end
    listok[lst].hidden = false
        --  workspace:draw()
        end --button
listok[lst] = window:addChild(GUI.container(1, 12, wrkspcX, wrkspcY - 6))
listok[lst]:addChild(GUI.text(45, wrkspcY-7, 0x004980, text.limit(tostring(lst)..lclz.strZruen,40)))
strZ = tostring(lst)..lclz.strZruen
if lst ~= 1 then listok[lst].hidden = true end
--listok[lst]:setCellAlignment(3, 1, GUI.alignment.horizontal.left, GUI.alignment.vertical.bottom)
--listok[lst].setCellAlignment(left,bottom)
local lmno = lststr+mnogitel
if lmno > #kat then lmno = #kat end
for i = 1+mnogitel, lmno do
-- local j = i
-- if j > #kat then j = #kat end
  listok[lst]:addChild(GUI.text(x, y, 0xB62B00, text.limit(linewd,wrkspcX- width-5)))
  listok[lst]:addChild(GUI.text(x, y + 1, 0xB62B00, text.limit(lineser,wrkspcX- width-5)))
  listok[lst]:addChild(GUI.text(x, y + 2, 0xB62B00, text.limit(lineser,wrkspcX- width-5)))
  listok[lst]:addChild(GUI.text(x, y + 3, 0xB62B00, text.limit(lineser,wrkspcX- width-5)))
  listok[lst]:addChild(GUI.text(x, y + 4, 0xB62B00, text.limit(linewd,wrkspcX- width-5)))
   -- имя кат[n].name
  listok[lst]:addChild(GUI.text(x + 1 + math.ceil((20-string.len(kat[i].name))/2), y + 2, 0x9900BF, text.limit(kat[i].name,20)))
   -- сайт кат[n].site
  listok[lst]:addChild(GUI.text(x + 22 + math.ceil((20-string.len(kat[i].site))/2), y + 2, 0x0024FF, text.limit(kat[i].site,22)))
   -- версия кат[n].vers
  listok[lst]:addChild(GUI.text(x + 46, y + 2, 0xCC9200, text.limit(kat[i].vers,10)))
  -- описание кат[n].opis1 2 3
  listok[lst]:addChild(GUI.text(x + 56, y + 1, 0x696969, text.limit(kat[i].opis1,wrkspcX- 111)))
  listok[lst]:addChild(GUI.text(x + 56, y + 2, 0x696969, text.limit(kat[i].opis2,wrkspcX- 111)))
  listok[lst]:addChild(GUI.text(x + 56, y + 3, 0x696969, text.limit(kat[i].opis3,wrkspcX- 111)))
  
  y =  y + verticalSpace + 4 -- смещение на сколько строк вниз
 
end
 y = 3
mnogitel = mnogitel + lststr
end --lst
end -- displist


loadKat()
readKat()

displist()

--------------------------------------------------------------------



--------------------------------------------------------------------
workspace:draw()


