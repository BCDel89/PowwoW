-----------------------------------------------------------------------------------------
--
-- settings.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local groupScene = storyboard.newScene()
local m = require("myData")
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
------------------------
--LOCALS
------------------------
local width = 320
local layers
local firstBox
local secondBox
local centerx = display.contentCenterX
local centery = display.contentCentery
------------------------
--LOCALS END
------------------------

------------------------
--FORWARDS
------------------------
local switchHome
local switchFirst
local switchSecond
local destroy
------------------------
--FORWARDS END
------------------------


-- Called when the groupScene's view does not exist:
function groupScene:createScene( event )
	local group = self.view
	
end

-- Called immediately after groupScene has moved onscreen:
function groupScene:enterScene( event )
	local group = self.view
        storyboard.removeAll()

	-- create a white background to fill screen
	local bkg = display.newRect(0,0, display.contentWidth, display.contentHeight )
	bkg.anchorX = 0
	bkg.anchorY = 0
        bkg.y = m.y
        bkg.height = m.height
	bkg:setFillColor(m.bc.r,m.bc.g,m.bc.b)

	local createGroups = function()
		layers = display.newGroup()
                layers.frame = display.newGroup()
		layers.buttons = display.newGroup()
                layers:insert(layers.frame)
		layers:insert(layers.buttons)
                
                local topFrame = display.newRect(layers.frame,0,0,m.w,m.h*.075)
                topFrame.anchorX = 0
                topFrame.anchorY = 0
                topFrame.y = topFrame.height*.5 +20
                topFrame.strokeWidth = 1
                topFrame:setStrokeColor(50,0,0)
                topFrame:setFillColor(m.frameColor.r,m.frameColor.g,m.frameColor.b)
                
                local bottomFrame = display.newRect(layers.frame,0,0,m.bbw,m.bbh)
                bottomFrame.anchorX = 0
                bottomFrame.anchorY = 0
                bottomFrame.y = m.bby
                bottomFrame.strokeWidth = 1
                bottomFrame:setStrokeColor(50,0,0)
                bottomFrame:setFillColor(m.frameColor.r,m.frameColor.g,m.frameColor.b)
                
                local title = display.newText(layers.frame, "Settings",0,0, native.systemFont, 22 )
                title.x = centerx
                title.y = m.groupTabY + topFrame.height*.5
                title:setFillColor(0,0,0)
                    
                firstBox = display.newRoundedRect(layers.buttons, 0,0,m.boxWidth,m.boxHeight,m.boxCurve)
                --firstBox.anchorX = 0
                --firstBox.anchorY = 0
                firstBox:setReferencePoint(display.CenterReferencePoint)
                firstBox.x = m.groupTabX
                firstBox.y = m.groupTabY + topFrame.height*.5
                firstBox:setFillColor(255,255,255)
                firstBox.strokeWidth = m.boxStrokeWidth
                firstBox:setStrokeColor(0,0,0)
                firstBox.isVisible = true

                secondBox = display.newRoundedRect(layers.buttons,0,0,firstBox.width,firstBox.height,m.boxCurve)
                --secondBox.anchorX = firstBox.x
                --secondBox.anchorY = 0
                secondBox:setReferencePoint(display.CenterReferencePoint)
                secondBox.x = m.settingsTabX
                secondBox.y = firstBox.y
                secondBox:setFillColor(255,255,255)
                secondBox.strokeWidth = m.boxStrokeWidth
                secondBox:setStrokeColor(0,0,0)
                secondBox.isVisible = false

                firstBox.touch = switchFirst
--                secondBox.touch = switchSecond

                firstBox:addEventListener("touch", firstBox)
--                secondBox:addEventListener("touch", secondBox)
               
                local leftHome = display.newText(layers.buttons, "Home", firstBox.x, firstBox.y, native.systemFont, 12 )
                leftHome:setFillColor(0,0,0)
                leftHome.x = leftHome.x - leftHome.width*.5
                leftHome.y = leftHome.y - leftHome.height*.5
                leftHome.isVisible = true
                
                local rightHome = display.newText(layers.buttons, "Home", secondBox.x, secondBox.y, native.systemFont, 12 )
                rightHome:setFillColor(0,0,0)
                rightHome.x = rightHome.x - rightHome.width*.5
                rightHome.y = rightHome.y - rightHome.height*.5
                rightHome.isVisible = false
	end

	switchFirst = function()
                --if event.phase == "began" then
                    --destroy()
                    storyboard.gotoScene( "menu", "slideRight", "100")
                --return true 
                --end
	end
	switchSecond = function()
                --destroy()
		--storyboard.gotoScene( "menu" )
	end

	createGroups()  
        
        destroy = function()
            firstBox:removeSelf()
            secondBox:removeSelf()
            bkg:removeSelf()
            firstBox:removeSelf()
            secondBox:removeSelf()
            
            layers:removeSelf()
        end

end

-- Called when groupScene is about to move offscreen:
function groupScene:exitScene( event )
	local group = self.view
end

-- If groupScene's view is removed, groupScene:destroyScene() will be called just prior to:
function groupScene:destroyScene( event )
	local group = self.view
        --destroy()
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if groupScene's view does not exist
groupScene:addEventListener( "createScene", groupScene )

-- "enterScene" event is dispatched whenever groupScene transition has finished
groupScene:addEventListener( "enterScene", groupScene )

-- "exitScene" event is dispatched whenever before next groupScene's transition begins
groupScene:addEventListener( "exitScene", groupScene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
groupScene:addEventListener( "destroyScene", groupScene )

-----------------------------------------------------------------------------------------

return groupScene