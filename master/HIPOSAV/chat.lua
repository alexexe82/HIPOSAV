local sides = require("sides")
local component = require("component")
-- local red = component.redstone
local term = require("term")
local br = require("bridge")
local keyboard = require("keyboard")
msgLast  = " "
i2 = 1
keyM = "123"

snd2 = "запуск"
sign1 = "off"
ex = 1

function most()
local msg,pair = br.receive()
 if msg == nil then
term.setCursor(1,18)
print ("Введите ключ сессии (чата):")
term.setCursor(1,19)
 keyM = io.read()
 
  term.setCursor(1,18)
  print ("                                                                        ")
  print ("                                                                        ")
 br.init(keyM)
  term.setCursor(14,2)
print (keyM)
 elseif msg == "" then
-- no mes
 else
  term.setCursor(1,5)
  print ("                                                                        ")
  print ("                                                                        ")
  print ("                                                                        ")
  msgLast = msg.."    "
  term.setCursor(1,5)
  print (msgLast)
  if msg == "test" then
  br.send("комп собеседника работает")
  --elseif msg == "info" then
  --snd = "Включение N "..t.." // сейчас "..snd2.." "..tos.." // доп.сигнал:"..sign1
  --br.send(snd)
  --elseif msg == "onsign" then
  --red.setOutput(2,14)
  --sign1 = "on"
  --br.send("доп.сигнал включен")
  --elseif msg == "offsign" then
  --red.setOutput(2,0)
  --sign1 = "off"
  --br.send("доп.сигнал выключен")
  else
  msgLast = msg.."    "
  term.setCursor(1,5)
  print ("                                                                        ")
  print ("                                                                        ")
  term.setCursor(1,5)
  print(msgLast)
  --br.send("не является командой")
  end
 end
end


term.clear()
print ("+----------------------------------------------------------------------+")
print ("Ключ канала:                                                            ")
print ("+----------------------------------------------------------------------+")
print ("Собеседник:                                                             ")
print ("                                                                        ")
print ("                                                                        ")
print ("                                                                        ")
print ("+----------------------------------------------------------------------+")
print ("Вы:                                                                     ")
print ("                                                                        ")
print ("                                                                        ")
print ("                                                                        ")
print ("+----------------------------------------------------------------------+")
print ("| для соединения указывайте на обоих устройствах одинаковый ключ!      |")
print ("| Соединяемые устройства могут быть в синглах или на разных серверах.  |")
print ("| Нажмите Enter для написания и отправки сообщения! ctrl+alt+c выход ! |")
print ("+======================================================================+")
print ("                                                                        ")
term.setCursor(1,18)
print ("Введите ключ сессии (чата):")
term.setCursor(1,19)
  keyM = io.read()
 
  term.setCursor(1,18)
  print ("                                                                        ")
  print ("                                                                        ")
  br.init(keyM)
  term.setCursor(14,2)
  print (keyM)

while ex < 2 do
msgTo = ""
most()
 if keyboard.isKeyDown(28) then
 term.setCursor(1,18)
print ("Введите сообщение и нажмите Enter для отправки:")
term.setCursor(1,19)
 msgTo = io.read()
 br.send(msgTo)
term.setCursor(1,18)
  print ("                                                                        ")
  print ("                                                                        ")
 term.setCursor(1,10)
  print ("                                                                        ")
  print ("                                                                        ")
 term.setCursor(1,10)
 print(msgTo)
elseif keyboard.isKeyDown(211) then
 ex = 3
 end
os.sleep(0.3)
end