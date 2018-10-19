




-- спрашивает выключить или перезагрузить , кликать мышкой

local ecs = require("ECSAPI")
local event = require("event")
local component = require("component")
local term = require("term")
local shell = require("shell")
local computer = require("computer")
local gpu = component.gpu


xcen, ycen = gpu.getResolution()
xcen, ycen = math.ceil(xcen/2), math.ceil(ycen/2)

function cp(xp,yp)
term.setCursor(xp,yp)
end

term.clear()
-- gpu.setCursor(xcen-7,4)
xp = xcen - 7
gpu.setBackground(0xFF7A00)
cp(xp,4)
print ("              ")
cp(xp,5)
print (" ПЕРЕЗАГРУЗКА ")
cp(xp,6)
print ("              ")
cp(xp,8)
gpu.setBackground(0xFF2400)
print ("              ")
cp(xp,9)
print ("  ВЫКЛЮЧЕНИЕ  ")
cp(xp,10)
print ("              ")
gpu.setBackground(0x33B640)
cp(xp,12)
print ("              ")
cp(xp,13)
print ("  В КОНСОЛЬ   ")
cp(xp,14)
print ("              ")
gpu.setBackground(0x339200)
cp(xp,16)
print ("              ")
cp(xp,17)
print ("    ОТМЕНА    ")
cp(xp,18)
print ("              ")
ex = 1

while ex ~= 2 do
local event, _, xmo, ymo = event.pull(5)
  if event == "touch" then
       if xmo < xcen+7 and xmo > xcen-7 then 
          if ymo > 3 and ymo < 7 then      
          computer.shutdown(true)
          end
          if ymo > 7 and ymo < 11 then
          computer.shutdown()
          end
          if ymo > 11 and ymo < 15 then
		  exityn = 2
ecs.prepareToExit()          
os.exit()

          end
          if ymo > 15 and ymo < 19 then
          ex = 2
          end
          
      end 
  end
end