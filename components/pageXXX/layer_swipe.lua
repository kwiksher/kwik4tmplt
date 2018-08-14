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
  {{^sceneGroup}}
  local target = layer.{{myLName}}
  {{/sceneGroup}}
  {{#sceneGroup}}
  local target = sceneGroup
  {{/sceneGroup}}

  if target == nil then return end
  _K.Gesture.activate( target, {{dbounds}} )
  _K.{{myLName}}Swipe = function (event )
  {{#all}}
    if event.phase == "ended" and event.direction ~= nil then
  {{/all}}
  {{#horizontal}}
    if event.phase == "ended" and event.direction == "right" or  event.direction == "left" then
  {{/horizontal}}
  {{#vertical}}
    if event.phase == "ended" and event.direction == "up" or  event.direction == "down" then
  {{/vertical}}
  {{#direction}}
    if event.phase == "ended" and event.direction == "{{direction}}"  then
  {{/direction}}
      {{#gcomplete}}
         UI.scene:dispatchEvent({name="{{gcomplete}}", swip=event })
      {{/gcomplete}}
    end
    return true
  end
  target:addEventListener( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{^sceneGroup}}
  local target = layer.{{myLName}}
  {{/sceneGroup}}
  {{#sceneGroup}}
  local target = sceneGroup
  {{/sceneGroup}}
  if target == nil then return end
  target:removeEventListener ( _K.Gesture.SWIPE_EVENT, _K.{{myLName}}Swipe )
  --_K.Gesture.deactivate(layer.{{myLName+') ;
end
--
function _M:toDestroy(UI)
  _K.{{myLName}}Swipe = nil
end
--
return _M