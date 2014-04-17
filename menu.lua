-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
--require "CiderDebugger";
display.setStatusBar( display.DefaultStatusBar )

----------------------------------------------
--REQUIRES
----------------------------------------------
-- these are kind of like imports in java
local widget = require "widget"
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local m = require("myData")
----------------------------------------------
--REQUIRES END
----------------------------------------------

----------------------------------------------
--LOCALS
----------------------------------------------
-- we're defining locals outside of all main
-- functions so we can use them outside
-- those functions 
local layers
local groupsBox
local settingsBox
local myMap
local centerx = display.contentCenterX
local centery = display.contentCentery
local groups
local settings
local pwFrame
local logo
local mapFrame
local tmpMap
----------------------------------------------
--LOCALS END
----------------------------------------------

----------------------------------------------
--FOWARDS
----------------------------------------------
--We're forward declaring functions to be used inside one of the main functions
-- this is helpful because now we can call them from within any of the main functions 
local switchFirst
local switchSecond
local onGroups
local onSettings
local create
local destroy
----------------------------------------------
--FORWARDS END
----------------------------------------------

 
-- This is the first function that gets called kind of like main
-- but only if the scene's view does not already exist in the case
-- that it does already exist this is skipped 
function scene:createScene( event )
	local group = self.view
        -- this function is mainly used to create the objects/frame for the current scene
        -- and then manipulated in the enter scene function below, but for our purposes it
        -- doesn't make a difference
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

--        local bkg = display.newImageRect("bkg_mainScreen.png", 0, 0 )
--        bkg.x = m.w*.5
--        bkg:setReferencePoint(display.TopLeftReferencePoint)
--        bkg.height = m.height
--        bkg.y = 0 + m.infoBar
--        bkg.width = m.w
            
        -- bg = background container
        local bg = display.newRect(0,m.infoBar,m.w,m.height)
        bg:setFillColor(m.bg.r,m.bg.g,m.bg.b)
        
        -- this is the frame that contains the google map
        mapFrame = display.newRect(0,0,0,0)
        mapFrame:setReferencePoint(display.TopCenterReferencePoint)
        mapFrame.x = centerx
        mapFrame.width = m.w *.95
        mapFrame.height = (m.h-m.infoBar)*.845
        mapFrame.y = m.infoBar + m.h*(61/480)
        mapFrame.strokeWidth = 5
        mapFrame:setStrokeColor(0,0,0)
        
        -- this is a temporary map.  The Corona SDK simulator doesn't support 
        -- the google maps API unfortunately even though the code does, so we 
        -- are using this to make sure we know exactly where the real map is 
        -- gonna be and how big.  The only way we'll be able to test the map will
        -- be to compile on to any device.  Which won't be a problem, but 
        -- definitely a hassle.
        tmpMap = display.newImageRect("Images/tmpMap.png",0,0)
        tmpMap:setReferencePoint(display.TopCenterReferencePoint)
        tmpMap.x = mapFrame.x
        tmpMap.width = mapFrame.width
        tmpMap.height = mapFrame.height
        tmpMap.y = mapFrame.y
        
        -- this is the function we'll use to create the boxes, frames, buttons,
        -- event listeners, etc.
        create = function()
                layers = display.newGroup()
                layers.frame = display.newGroup()
                layers.buttons = display.newGroup()
                layers:insert(layers.frame)
                layers:insert(layers.buttons)
                
                -- This is the logo and button container
                pwFrame = display.newRoundedRect(layers.frame,0,0,m.w*.95,m.h*.09,15)
                pwFrame:setReferencePoint(display.CenterReferencePoint)
                pwFrame.x = centerx
                pwFrame.y = m.h*.098
                pwFrame.strokeWidth = 3
                pwFrame:setStrokeColor(0,0,0)
                pwFrame:setFillColor(m.menuFrameColor.r,m.menuFrameColor.g,m.menuFrameColor.b)

                logo = display.newImageRect("Images/PowWow_tmpLogoBig.png",m.w*.5,pwFrame.height*.6)
                logo.x = pwFrame.x
                logo.y = pwFrame.y

                -- This is the real map.  Like I said in the previous comment
                -- we won't be able to see it in the simulator but given that
                -- it has the same properties as the tmp map we can assume that 
                -- it will end up in the right place upon testing
                myMap = native.newMapView(layers.buttons, 20,20,380,600)
                myMap:setReferencePoint(display.TopCenterReferencePoint)
                myMap.x = mapFrame.x
                myMap.width = mapFrame.width
                myMap.height = mapFrame.height
                myMap.y = mapFrame.y

                -- The group box container
                groupsBox = display.newRoundedRect(layers.buttons, 0,0,m.boxWidth,m.boxHeight,8)
                --groupsBox.anchorX = 0
                --groupsBox.anchorY = 0
                groupsBox.x = m.groupTabX
                groupsBox.y = pwFrame.y
                groupsBox:setFillColor(m.box.r,m.box.g,m.box.b)
                groupsBox.strokeWidth = m.boxStrokeWidth
                groupsBox:setStrokeColor(0,0,0)
                groupsBox.isVisible = true
                
                -- The settings box container
                settingsBox = display.newRoundedRect(layers.buttons,0,0,groupsBox.width,groupsBox.height,8)
                settingsBox.anchorX = groupsBox.x
                settingsBox.anchorY = 0
                settingsBox.x = m.settingsTabX
                settingsBox.y = pwFrame.y
                settingsBox:setFillColor(m.box.r,m.box.g,m.box.b)
                settingsBox.strokeWidth = m.boxStrokeWidth
                settingsBox:setStrokeColor(0,0,0)
                settingsBox.isVisible = true
                
                -- routing the event "touch" to the event handling functions
                groupsBox.touch = switchFirst
                settingsBox.touch = switchSecond
                
                -- creating the event listeners for the event "touch"
                groupsBox:addEventListener("touch", groupsBox)
                settingsBox:addEventListener("touch", settingsBox)

                -- the text for the group box
                groups = display.newText(layers.buttons, "Groups", groupsBox.x, groupsBox.y, native.systemFont, m.boxCurve )
                groups:setFillColor(0,0,0)
                groups.x = groups.x - groups.width*.5
                groups.y = groups.y - groups.height*.5
                groups:setFillColor(m.text.r,m.text.g,m.text.b)

                -- the text for the settings box
                settings = display.newText(layers.buttons, "Settings", settingsBox.x, settingsBox.y, native.systemFont, m.boxCurve )
                settings:setFillColor(0,0,0)
                settings.x = settings.x - settings.width*.5
                settings.y = settings.y - settings.height*.5
                settings:setFillColor(m.text.r,m.text.g,m.text.b)

                -- The search bar between the map and the pwFrame
--                local searchBar = display.newRoundedRect(layers.buttons,0,0,100,groupsBox.height *.9,m.boxCurve)
--                searchBar.x = centerx
--                searchBar.width = m.w * .35
--                searchBar.height = groupsBox.height *1.2
--                searchBar.y = m.h * .15
--                searchBar.strokeWidth = m.boxStrokeWidth
--                searchBar:setStrokeColor(0,0,0)
--                searchBar:setFillColor(m.box.r,m.box.g,m.box.b)
        end
        
        -- the event listener function for hitting the first box (the group box)
        switchFirst = function( self, event )
                if event.phase == "began" then
                    destroy()
                    storyboard.gotoScene( "groups", "slideRight", "100")
                return true 
                end
        end

        -- the event listener function for settings
        switchSecond = function( self, event )
                if event.phase == "began" then
                    destroy()
                    storyboard.gotoScene( "settings", "slideRight", "100")
                return true 
                end
        end

        -- this is the garbage collection function
        -- garbage collection is a bitch in Lua
        -- mainly bc of all the different main functions, and i'm still learning
        -- how it works, but this is a start
        destroy = function()
            layers.buttons:removeSelf()
            layers.frame:removeSelf()
            layers:removeSelf()
            myMap:removeSelf()
            groupsBox:removeSelf()
            settingsBox:removeSelf()
            layers:removeSelf()
            groups:removeSelf()
            settings:removeSelf()
            logo:removeSelf()
            mapFrame:removeSelf()
            tmpMap:removeSelf()
            
            --storyboard.purgeScene()
        end

        -- first function we are manually calling to create whatever is in our
        -- create function
        create()
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
            --groupsBox:removeSelf()
            --settingsBox:removeSelf()
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene

