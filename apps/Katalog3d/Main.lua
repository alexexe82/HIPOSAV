local event = require("event")
local component = require("component")
local computer = require("computer")
local gpu = component.gpu
local term = require("term")
local shell = require("shell")
local image = require("image")
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
local Version = "1.0"
local MineOSCore = require("MineOSCore")
XScr, YScr = gpu.getResolution()
-- gpu.setResolution(130,40)


local pictures = {

{ "stul", "Офисный стул"},
{ "stol", "Офисный стол"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
{"модель", "текст текст текст текст текст"},
}

xwd = 135

local mainContainer, window = MineOSInterface.addWindow(GUI.titledWindow(1, 1, xwd, 46, "Katalog3d "..Version, true))
--local mainContainer, window = MineOSInterface.addWindow(GUI.filledWindow(1, 1, 135, 35))

--local mainContainer, window = MineOSInterface.addWindow(GUI.filledWindow(1, 1, 145, 35, 0))
-- window.backgroundPanel.colors.transparency = 0.2
--local progressIndicator = window:addChild(GUI.progressIndicator(140, 32, 0x1E1E1E, 0x990000, 0xFF0000))

--    local mainContaine = GUI.container(1, 1, 50, 23)
--mainContainer:addChild(GUI.panel(1, 2, 45, 22, 0x2D2D2D))

--local textBox = mainContainer:addChild(GUI.textBox(2, 2, xCen + 25, 22, 0xEEEEEE, 0x2D2D2D, {}, 1, 1, 0))
--mainContainer:addChild(GUI.button(40, 3, 8, 3, 0x336DBF, 0xEEEEEE, 0xEEEEEE, 0x336DBF, "Exit")).onTouch = function()


local x, y, width, horizontalSpace, verticalSpace = 45, 3, 10, 2, 0
for i = 1, #pictures do
  window:addChild(GUI.text(x, y, 0xB62B00, string.limit(pictures[i][1],width)))
  window:addChild(GUI.text(x+15, y, 0x696969, string.limit(pictures[i][2],xwd- width-5)))
  window:addChild(GUI.framedButton(xwd - 11, y-1,
   width, 3, 0x696969, 0x00B600, 0x880000, 0x880000, "Download")).onTouch = function()
    local file = pictures[i] .. ".pic"
    
    GUI.alert("Russian: не вынимайте, интернет карту во время скачиваний, это пройдет 3 секунды. \nEnglish: do not remove the internet map during downloads, it will take 3 seconds.")
    -- progressIndicator.active = true
     
      mainContainer:drawOnScreen()
        loadfile("/bin/wget.lua")("https://github.com/Fronun/Wallpapers/raw/master/wall/" .. file, "/3dm/" .. file, "-FQ")
    GUI.alert("Russian: Загрузка завершена! Чтобы поставить на рабочий стол, Settings -> обои и заставка, выбираете " .. file, "\nEnglish: Loading is successfully! To put on your desktop, Settings -> wallpapers, choose " ..file)
  --  progressIndicator.active = false
  end

 --  x = x + width + horizontalSpace
 -- if x + width > window.width then
  y =  y + verticalSpace + 3

 -- end
end

mainContainer:drawOnScreen()
-- gpu.setResolution(XoldScr, YoldScr)
