
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
local MineOSCore = require("MineOSCore")
local computer = require("computer")
local fs = require("filesystem") 

local buttonkal = { 
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "0",
  }

local mainContainer, window = MineOSInterface.addWindow(GUI.filledWindow(3, 3, 32, 27, 0x4B4B4B)) 
window.backgroundPanel.colors.transparency = 0.1 


local dispres = ""
local dispres1 = ""
local dispres2 = ""
local tmpdisp = 0
local op = 0
local zpt = 0
local x, y, width, horizontalSpace, verticalSpace = 3, 7, 8, 2, 1 
local xdisp,ydisp = x,y-2

  window:addChild(GUI.text(xdisp, ydisp, 0xD2D2D2, string.limit(dispres,window.width))) 
for i = 1, #buttonkal do
    window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x969696, 0x000000, 0x696969, 0x969696, buttonkal[i])).onTouch = function() 
   if string.len(dispres) < 28 then
     if op == 0 then
    dispres = dispres..buttonkal[i]
    dispres1 = dispres
   window:addChild(GUI.text(xdisp, ydisp, 0xD2D2D2, string.limit(dispres.."                            ",window.width))) 
    end
    if op > 0 and op ~= 8 then
     dispres = dispres..buttonkal[i]
     dispres2 = dispres
    window:addChild(GUI.text(xdisp, ydisp, 0xD2D2D2, string.limit(dispres.."                            ",window.width))) 
    end
   end
  end

  x = x + width + horizontalSpace
  if x + width > window.width then
    x, y = 3, y + verticalSpace + 2

  end
end
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, ".")).onTouch = function() 
    if zpt == 0 and op ~= 8 then
     dispres = dispres.."."
     zpt = 1
    end
      
  end
   x = x + width + horizontalSpace
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0xCC9280, 0x000000, 0xCC2400, 0x969696, "C")).onTouch = function() 

dispres = ""
dispres1 = ""
dispres2 = ""
tmpdisp = 0
op = 0
zpt = 0
window:addChild(GUI.text(xdisp, ydisp, 0xD2D2D2, string.limit(dispres.."                            ",window.width))) 
  end
   x = x + width + horizontalSpace
    x, y = 3, y + verticalSpace + 2
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, "+")).onTouch = function() 
    if op == 0 or op == 8  then
    zpt = 0
    op = 1
    dispres = ""
    end
      
  end
   x = x + width + horizontalSpace
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, "-")).onTouch = function()
     if op == 0 or op == 8  then
    zpt = 0
    op = 2
    dispres = ""
    end
      
  end
   x = x + width + horizontalSpace
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, "/")).onTouch = function() 
     if op == 0 or op == 8 then
    zpt = 0
    op = 3
    dispres = ""
    end
      
  end
 x = x + width + horizontalSpace
  x, y = 3, y + verticalSpace + 2
 window:addChild(GUI.roundedButton(x, y + 1, width, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, "*")).onTouch = function() 
     if op == 0 or op == 8  then
    zpt = 0
    op = 4
    dispres = ""
    end
      
  end
 x = x + width + horizontalSpace
  window:addChild(GUI.roundedButton(x, y + 1, width + 10, 3, 0x66DB80, 0x000000, 0x696969, 0x969696, "=")).onTouch = function() 
    if op > 0 and tonumber(dispres2) > 0 then
     if op == 1 then
      op = 0
      resres = tonumber(dispres1)+tonumber(dispres2)
     elseif op == 2 then
      op = 0
      resres = tonumber(dispres1)-tonumber(dispres2)
      elseif op == 3 then
      op = 0
      resres = tonumber(dispres1)/tonumber(dispres2)
      elseif op == 4 then
      op = 0
      resres = tonumber(dispres1)*tonumber(dispres2)
     end
    
     window:addChild(GUI.text(xdisp, ydisp, 0xD2D2D2, string.limit(resres.."                            ",window.width)))
dispres = resres
dispres1 = resres
dispres2 = ""
tmpdisp = 0
op = 8
zpt = 0
     
    end
      
    
  end

mainContainer:drawOnScreen()