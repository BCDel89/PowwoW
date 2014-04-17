--require "CiderDebugger";
 
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local storyboard = require "storyboard"
local main = storyboard.newScene()
local m = require("myData")

----------------------------------------------
--LOCALS
----------------------------------------------
local layers
----------------------------------------------
--LOCALS END
----------------------------------------------

----------------------------------------------
--FOWARDS
----------------------------------------------
local switchFirst
local switchSecond
local onGroups
local onSettings
----------------------------------------------
--FORWARDS END
----------------------------------------------

storyboard.gotoScene("menu")
