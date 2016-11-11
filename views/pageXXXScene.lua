-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local sceneName = ...
local composer  = require( "composer" )
local scene     = composer.newScene(sceneName)
scene._composerFileName = nil
scene.classType = "{{classType}}"
scene.pageUI    = require("{{custom}}{{pageUI}}").new(scene)
------------------------------------------------------------
------------------------------------------------------------
function scene:create( event )
  local sceneGroup = self.view
  self.pageUI:create(self, event.params)
  Runtime:dispatchEvent({name="onRobotlegsViewCreated", target=self})
end
--
function scene:show( event )
  local sceneGroup = self.view
  if event.phase == "did" then
     self.pageUI:didShow(self, event.params)
  end
end
--
function scene:hide( event )
   if event.phase == "will" then
     self.pageUI:didHide(self, event.params)
   elseif event.phase == "did" then
   end
end
--
function scene:destroy( event )
     self.pageUI:destroy(self, event.params)
    Runtime:dispatchEvent({name="onRobotlegsViewDestroyed", target=self})
end
--
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene