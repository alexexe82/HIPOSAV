





local shell = require("shell")
local ecs = require("ECSAPI")
local component = require("component")
local computer = require("computer")
local term = require("term")
--shell.execute(components)
term.clear()
--print(component.list())
print ("введите адрес исходного диска: ")
print(" ")
for address, componentType in component.list() do
print(componentType.." "..address)
end
sourse = term.read()
sourse = "/mnt/"..sourse
--sourse = computer.getBootAddress()
print("введите диск назначения")
print (" ")
--destination1 = term.read()
print(" ")
destination1 = term.read()
--local proxy = component.proxy(destination1)
--destination = component.get(destination1,"filesystem")
--destination = ecs.findMount(destination1)
destination = "/mnt/"..destination1
print("копировать с "..sourse)
print("на "..destination)
print ("подтвердить: 1 - да, 2 - нет")
yn = term.read()
print (yn)
if yn == 1 or yn == "1" then
  shell.execute("bin/cp -rx "..sourse.."* "..destination)
  print("КОПИРОВАНИЕ ПРОИЗВЕДЕНО")
  print("проверьте диск назначения")
  print("")
  os.sleep(0.5)
else
  print("ОТМЕНА КОПИРОВАНИЯ")
end
print ("- нажмите любую клавишу или кликните мышкой -")
ecs.wait()
os.sleep(0.5)