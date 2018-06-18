-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
function _M:didShow(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if layer.{{myLName}} == nil then return end
  _K.Gesture.activate( layer.{{myLName}}, {{dbounds}} )
  _K.{{myLName}}Swipe = function (event )
    if event.phase == "ended" and event.direction ~= nil then
      {{#gcomplete}}
         UI.scene:dispatchEvent({name="{{gcomplete}}", swip=event })
      {{/gcomplete}}
    end
    return true
  end
  layer.{{myLName}}:addEventListener( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if layer.{{myLName}} == nil then return end
  layer.{{myLName}}:removeEventListener ( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
  --_K.Gesture.deactivate(layer.{{myLName+') ;
end
--
function _M:toDestroy(UI)
  _K.{{myLName}}Swipe = nil
end
--
return _M