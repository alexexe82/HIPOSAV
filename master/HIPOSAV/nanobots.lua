local image = require("image")
local ecs = require("ECSAPI")
local event = require("event")
local component = require("component")
local term = require("term")

local gpu = component.gpu
local LogoNano = image.load("/HIPOSAV/IconsPic/LogoNano.pic")
local modem = component.modem
--ecs.clearScreen(0x000040)
--component.gpu.setResolution(100,40)
modem.open(1)
modem.broadcast(1, "nanomachines", "setResponsePort", 1)

local lastResponse = ""
local function printResponse()
  local w, h = component.gpu.getResolution()
  component.gpu.fill(1, h, w, h, " ")
  
  component.gpu.set(1, h, lastResponse)
end

local function handleModemMessage(_, _, _, _, _, header, command, ...)
  if header ~= "nanomachines" then return end
  lastResponse = "Последний ответ: " .. command
  for _, v in ipairs({...}) do
    lastResponse = lastResponse .. ", " .. tostring(v)
  end
  printResponse()
end

event.listen("modem_message", handleModemMessage)

local function send(command, ...)
  component.modem.broadcast(1, "nanomachines", command, ...)
end

local function readNumber(name, validator)
  local index
  while not index do
    io.write(name..": ")
    index = tonumber(io.read())
    if not index or validator and not validator(index) then
      index = nil
      io.write("неверный ввод\n")
    end
  end
  return index
end

local running = true
local commands = {
  { "Узнать статус заряда",
    function()
      send("getPowerState")
    end
  },

  { "Узнать активные эффекты",
    function()
      send("getActiveEffects")
    end
  },
  { "Узнать состояние вывода",
    function()
      local index = readNumber("index")
      send("getInput", index)
    end
  },
  { "Изменить состояние вывода",
    function()
      local index = readNumber("index")
      io.write("1. Включить\n")
      io.write("2. Выключить\n")
      local value = readNumber("state", function(x) return x == 1 or x == 2 end)
      send("setInput", index, value == 1)
    end
  },
  { "Узнать общее кол-во выводов",
    function()
      send("getTotalInputCount")
    end
  },
  { "Узнать активные выводы",
    function()
      send("getSafeActiveInputs")
    end
  },
  { "Узнать макс. кол-во активных выводов",
    function()
      send("getMaxActiveInputs")
    end
  },

  { "Узнать статус жизни",
    function()
      send("getHealth")
    end
  },
  { "Узнать голод",
    function()
      send("getHunger")
    end
  },
  { "Узнать возраст",
    function()
      send("getAge")
    end
  },
  { "Узнать имя",
    function()
      send("getName")
    end
  },
  { "Узнать количество опыта",
    function()
      send("getExperience")
    end
  },

  { "Выход",
    function()
      ecs.info("auto","auto","ВНИМАНИЕ!!!","Наниты могут убить! Проверяйте эффекты.")
     ecs.wait()
     running = false
    end
  }
}

function main()
  while running do
gpu.setForeground(0x1E1E1E) 
gpu.setBackground(0x3392BF)   
term.clear()
    
--ecs.clearScreen(0x000040) 
--term.setCursor(40,1)
--print (" Контакты нанитов ")
-- term.setCursor(40,2)
-- print ("------------------")
--ni = 1
-- while ni < 18 do
--term.setCursor(45,1+ni)
--print (ni ..   component.modem.broadcast(1, "nanomachines", getInput, ni))
--ni = ni + 1
--end
--term.setCursor(1,1)
image.draw(2,17,LogoNano)
gpu.setForeground(0x1E1E1E)
gpu.setBackground(0x3392BF)
      for i = 1, #commands do
      local command = commands[i]
      io.write(i,". ",command[1],"\n")
    end
--nh = 1
--gpu.setForeground(0xFFF400) 
--gpu.setBackground(0xFF0000) 
--while nh < w do
--term.setCursor(nh,h)
--print (" ")
--nh = nh + 1
--end  
--gpu.setForeground(0x1E1E1E) 
--gpu.setBackground(0x3392BF) 

    printResponse()

    local command = readNumber("command", function(x) return x > 0 and x <= #commands end)
    commands[command][2]()
  end
end

local result, reason = pcall(main)
if not result then
  io.stderr:write(reason, "\n")
end

event.ignore("modem_message", handleModemMessage)

term.clear()