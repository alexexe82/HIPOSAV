local fs = require("filesystem")
local component = require("component")
local computer = require("computer")
local unicode = require("unicode")
local shell = require("shell")
local gpu = component.gpu
local screen = component.screen

local args, options = shell.parse(...)

 term.clear()
 print ("Version in developed... press enter for exit")
print ("Версия находится в разработке... нажмите enter для выхода")
scr1X, scr1Y = gpu.getResolution()
term.setCursor (scr1X - 46, scr1Y - 16)
logoandroid = {
"           ▄                     ▄       ",
"            █    ▄▄▄▄▄▄▄▄▄▄▄    █        ",
"             █ ▄█████████████▄ █         ",
"            ▄███████████████████▄        ",
"           ███████████████████████       ",
"          █████• ██████████• ██████      ",
"         ███████████████████████████     ",
"         ███████████████████████████     ",
"   ▄██▄  ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ▄██▄ ",
"  ██████ ▌ ██ ▐▌ ▐█   ▀█▀   ▀█▀   ▀█ ██████",
"  ██████ ▌ ██ ▐█▄██ █▄ ▐ ▄█▄ █ ▐██▄█ ██████",
"  ██████ ▌    ▐   █ ▀ ▄█ ███ █▄   ▀█ ██████",
"  ██████ ▌ ██ ▐▌ ▐█ ▐███ ▀█▀ █▀██▌ ▐ ██████",
"  ██████ ▌ ██ ▐   █ ▐███▄   ▄█▄   ▄█ ██████",
"  ██████ ███████████████████████████ ██████"}

for i = 1, #logoandroid do
gpur.setForeground(0x00B600)
term.setCursor (scr1X - 44, scr1Y - 16 + i)
print (logoandroid[i])
end
