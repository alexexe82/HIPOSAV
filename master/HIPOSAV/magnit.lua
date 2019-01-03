
-- управление магнитом по просьбе DeathNote

local ecs = require("ECSAPI")
local event = require("event")
local component = require("component")
local term = require("term")
local shell = require("shell")
local computer = require("computer")
local gpu = component.gpu

info = "Управление притягивающим лучом. По заказу DeathNote."
info2 = "Для работы необходимо установленное улучшение на планшете."
xcen, ycen = gpu.getResolution()
xcen, ycen = math.ceil(xcen/2), math.ceil(ycen/2)
ta = 0
xp = xcen - 7

function cp(xp,yp)
term.setCursor(xp,yp)
end

function magnit(t)
if tostring(t) == "1" then
component.tractor_beam.suck(true)
cp(xp,5)
gpu.setBackground(0x33B640)
print ("   РАБОТАЕТ   ")
elseif tostring(t) == "0" then
component.tractor_beam.suck(false)
cp(xp,5)
gpu.setBackground(0xFF2400)
print ("  ВЫКЛЮЧЕНО   ")
else
cp(xp,5)
gpu.setBackground(0xFF2400)
print ("    error     ")
end
end

term.clear()
-- gpu.setCursor(xcen-7,4)
-- xp = xcen - 7
cp(xcen-26,1)
print(info)
cp(xcen-29,2)
print(info2)
gpu.setBackground(0xFF7A00)

cp(xp,4)
print ("              ")
cp(xp,5)
print ("              ")
cp(xp,6)
print ("              ")
cp(xp,8)
-- gpu.setBackground(0xFF2400)
gpu.setBackground(0x33B640)
print ("              ")
cp(xp,9)
print ("   ВКЛЮЧИТЬ   ")
cp(xp,10)
print ("              ")
-- gpu.setBackground(0x33B640)
gpu.setBackground(0xFF2400)
cp(xp,12)
print ("              ")
cp(xp,13)
print ("  ВЫКЛЮЧИТЬ   ")
cp(xp,14)
print ("              ")
gpu.setBackground(0x339200)
cp(xp,16)
print ("              ")
cp(xp,17)
print ("    ВЫХОД     ")
cp(xp,18)
print ("              ")
ex = 1

while ex ~= 2 do
local event, _, xmo, ymo = event.pull(0.3)
  if event == "touch" then
       if xmo < xcen+7 and xmo > xcen-7 then 
          if ymo > 3 and ymo < 7 then      
          -- computer.shutdown(true)
          end
          if ymo > 7 and ymo < 11 then
          -- computer.shutdown()
          ta = 1
          end
          if ymo > 11 and ymo < 15 then
          ta = 0
      -- exityn = 2
-- ecs.prepareToExit()          
-- os.exit()

          end
          if ymo > 15 and ymo < 19 then
          term.clear()
          ex = 2
          end
          
      end 
  end
  if not component.isAvailable("tractor_beam") then 
  cp(xp,5)
  gpu.setBackground(0xFF2400)
  print (" НЕТ УЛУЧШЕНИЯ")
  elseif ex ~= 2 then
  magnit(ta)
  end
end