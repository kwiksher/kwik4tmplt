-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local sceneName = ...
local composer = require( "composer" )
local scene = composer.newScene(sceneName)
scene.classType = "views.loadingScene"
--
local _W = display.contentWidth
local _H = display.contentHeight
------------------------------------------------------------
------------------------------------------------------------
function scene:create( event )
  local sceneGroup = self.view

end
--
function scene:show( event )
  local sceneGroup = self.view
  if event.phase == "did" then
  end
end
--
function scene:hide( event )
   if event.phase == "will" then
   elseif event.phase == "did" then
   end
end
--
function scene:destroy( event )
    local currentscene = "page_"..curPage
end
--
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
