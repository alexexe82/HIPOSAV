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

-- программа показывает все устройства пк с адресами --
-- благодарочка игроку Fronun -------------------------




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



local mainContainer2 = GUI.container(1, 1, 55, 23)
mainContainer2:addChild(GUI.panel(1, 2, 50, 22, 0x2D2D2D))

local textBox = mainContainer2:addChild(GUI.textBox(2, 2, 50, 22, 0xEEEEEE, 0x2D2D2D, {}, 1, 1, 0))
mainContainer2:addChild(GUI.button(42, 3, 8, 3, 0x336DBF, 0xEEEEEE, 0xEEEEEE, 0x336DBF, "Exit")).onTouch = function()
mainContainer2:stopEventHandling()
buffer.clear(0x0)
buffer.draw(true)
end
vers = {
" ",
" ",
" ",
}
local tmp = 4
listCom = ""
for indexAddr, listCom in component.list() do 

--listCom = listCom..name.."\n"

listCom = listCom.."               "
listCom = string.sub(listCom,1,11)
vers[tmp] = listCom.." "..indexAddr
tmp=tmp+1
end
for p = 0,3 do
vers[tmp] = " "
tmp=tmp+1
end

table.insert(textBox.lines, {text = "ИНФОРМАЦИЯ о ПК  (работает прокрутка мышью)", color = 0x880000})
 v = 1
 while v < #vers+1 do 
 table.insert(textBox.lines, vers[v])
 v = v+1
 end
mainContainer2:draw()
buffer.draw(true)
mainContainer2:startEventHandling()