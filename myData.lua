local myData = {}

-----------------
-- Height/Width
-----------------
    myData.aspectRatio = display.pixelHeight / display.pixelWidth
    myData.regW = 320
    myData.regH = 480
    myData.w = myData.aspectRatio > 1.5 and 320 or math.ceil( 480 / myData.aspectRatio )
    myData.h = myData.aspectRatio < 1.5 and 480 or math.ceil( 320 * myData.aspectRatio )
    myData.height = myData.h - 20
    myData.y = myData.h*.5+(480*.022)
    myData.infoBar = 480*.0415
   
----------------------------------------
-- main page properties
----------------------------------------
    --bkg color
    myData.bg = {r = 64, g = 64, b = 64}
    myData.menuFrameColor = {r = 242, g = 242, b = 242}
    myData.box = {r = 255, g = 255, b = 255}
    myData.text = {r = 0, g = 0, b = 0}
    
---------------------------------------
-- group/settings/home box properties
---------------------------------------
    myData.mainTabY = myData.infoBar + (9.5/480)
    myData.groupTabY =  myData.infoBar + (9.5/480)
    myData.settingsTabY =  myData.infoBar + (9.5/480)
    myData.mainTabX = myData.w *.5
    myData.groupTabX = myData.w *.14
    myData.settingsTabX = myData.w*.86
    
    myData.boxHeight = 20
    myData.boxWidth  = 55
    myData.boxStrokeWidth = 1
    myData.boxCurve = 8
 
---------------------------------------
-- group/settings page properties
---------------------------------------
    --bkg color
    myData.bc = {r = 64, g = 64, b = 64}
    myData.frameColor = {r = 242, g = 242, b = 242}

----------------------
-- topBar properties
----------------------

-------------------------
-- bottomBar properties
-------------------------
    myData.bbh = myData.h*.035
    myData.bbw = myData.w
    myData.bby = myData.h - myData.bbh*.5
    
return myData

