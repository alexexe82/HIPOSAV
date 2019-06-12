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

-- eng version
-- for Mr_Creeper543

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


local kat = {
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
}
 
local workspaceXY = GUI.workspace()
local xwd = workspaceXY.width - 15
local yhg = workspaceXY.height - 5
local linewd = "_"
local strZ = 1
for i = 1,xwd - 60 do
 linewd = linewd.."_"
end
 
local workspace, window = system.addWindow(GUI.titledWindow(1, 1, xwd, yhg - 5, "Katalog3d "..Version, true))
window:addChild(GUI.text(13,3, 0x004980, text.limit("For ease of use",40)))
window:addChild(GUI.text(16,4, 0x004980, text.limit("with the application,",40)))
window:addChild(GUI.text(12, 5, 0x004980, text.limit("use the resolution",40)))
window:addChild(GUI.text(15, 6, 0x004980, text.limit("of at least 140х48",40)))
window:addChild(GUI.image(2, 8, logo))
window:addChild(GUI.text(10, 30, 0x004980, text.limit("A pack of ready-made 3D models",40)))
window:addChild(GUI.text(12,31, 0x004980, text.limit("to print to a 3d printer",40)))
window:addChild(GUI.text(16, 32, 0x004980, text.limit("in the format 3dm",40)))
window:addChild(GUI.text(16,34, 0x004980, text.limit("Autor: MineCR",40)))
window:addChild(GUI.text(8, 36, 0x004980, text.limit("created on project guild-bt.ru",40)))
window:addChild(GUI.text(46, yhg-7, 0x004980, text.limit("page ",40)))

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
  listok[lst]:addChild(GUI.framedButton(xwd - 11, y-1, width, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "Download")).onTouch = function()
    if kat[i][3] ~= nil and kat[i][3] > 1 then
    for modelnum = 1,kat[i][3] do -- multiblock models
    local file = kat[i][1] .. tostring(modelnum) .. ".3dm"
   
      -- workspace:draw()
      internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dm/" .. file, "/3dm/" .. file)
    end -- multiblock models
    GUI.alert("Download comlete! Files are located at /3dm/")
    else
    local file = kat[i][1] .. ".3dm"
   
      --workspace:draw()
        internet.download("https://raw.githubusercontent.com/alexexe82/HIPOSAV/master/3dm/" .. file, "/3dm/" .. file)
    GUI.alert("Download comlete! File are located at /3dm/" .. file)
   end
  end
 
  y =  y + verticalSpace + 3
 
end
 y = 3
mnogitel = mnogitel + lststr
end --lst
 
 
workspace:draw()
