local fs = require("filesystem")
local component = require("component")
local computer = require("computer")
local unicode = require("unicode")
local shell = require("shell")
local gpu = component.gpu
local screen = component.screen

local args, options = shell.parse(...)

