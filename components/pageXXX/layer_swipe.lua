-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  _K.Gesture.activate( layer.{{myLName}}, {{dbounds}} )
  _K.{{myLName}}Swipe = function (event )
    if event.phase == "ended" and event.direction ~= nil then
      {{#gcomplete}}
         UI.scene:dispatchEvent({name="{{gcomplete}}", event={UI=UI} })
      {{/gcomplete}}
    end
    return true
  end
  layer.{{myLName}}:addEventListener( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
end
--
function _M:dispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  layer.{{myLName}}:removeEventListener ( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
  --_K.Gesture.deactivate(layer.{{myLName+') ;
end
--
function _M:destroy()
  _K.{{myLName}}Swipe = nil
end
--
return _M