-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
-- Drag objects
function _M:allListeners(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
  local scene       = UI.scene
  {{#gPage}}
  local dragLayer = sceneGroup
  {{/gPage}}
  {{^gPage}}
  local dragLayer = layer.{{glayer}}
  {{/gPage}}
    _K.MultiTouch.activate( dragLayer, "move", "single", {{dbounds}} )
    {{#gdrop}}
        local {{glayer}}_lock = 0
        local {{glayer}}_posX = 0
        local {{glayer}}_posY = 0
    {{/gdrop}}
    {{#gFlip}}
        local wO_{{glayer}} = "{{gFlipDir}}"; local cr_{{glayer}} = dragLayer.{{xyx}}
    {{/gFlip}}
    _K.{{glayer}}Drag = function (event )
      local t = event.target
      if event.phase == "began" then
        {{#gfocus}}
            local parent = t.parent; parent:insert(t); display.getCurrentStage():setFocus(t); t.isFocus = true
        {{/gfocus}}
      elseif event.phase == "moved" then
        {{#gFlip}}
          if (dragLayer.{{xyx}} < cr_{{glayer}}) then
            if (wO_{{glayer}} == "{{xd1}}") then
              dragLayer.{{xyx}}Scale = {{xs1}}
              wO_{{glayer}} = "{{xd2}}"
            end
          elseif (dragLayer.{{xyx}} > cr_{{glayer}}) then
            if (wO_{{glayer}} == "{{xd2}}") then
              dragLayer.{{xyx}}Scale = {{xs2}}
              wO_{{glayer}} = "{{xd1}}"
            end
          end
          cr_{{glayer}} = dragLayer.{{xyx}}
        {{/gFlip}}
        {{#gdrop}}
            {{glayer}}_posX = dragLayer.x - layer.{{gdrop}}.x
            {{glayer}}_posY = dragLayer.y - layer.{{gdrop}}.y
            if ({{glayer}}_posX < 0) then
              {{glayer}}_posX = {{glayer}}_posX * -1
            end
            if ({{glayer}}_posY < 0) then
              {{glayer}}_posY = {{glayer}}_posY * -1
            end
            if ({{glayer}}_posX <= {{gdropb}}) and ({{glayer}}_posY <= {{gdropb}}) then  --in position\r\n'
              dragLayer.x = layer.{{gdrop}}.x
              dragLayer.y = layer.{{gdrop}}.y
              {{glayer}}_lock = 1
            else
              {{glayer}}_lock = 0
            end
        {{/gdrop}}
        {{#gdragging}}
           scene:dispatchEvent({name="{{gdragging}}", event={UI=UI, dragLayer=dragLayer} })
        {{/gdragging}}
        elseif event.phase == "ended" or event.phase == "cancelled" then
          {{#gdrop}}
            if ({{glayer}}_lock == 1 and {{glayer}}_posX <= {{gdropb}}) and ({{glayer}}_posY <= {{gdropb}}) then
               dragLayer.x = layer.{{gdrop}}.x
               dragLayer.y = layer.{{gdrop}}.y
              {{#dropl}}
                 _K.MultiTouch.deactivate(dragLayer)
              {{/dropl}}
              {{#gdropt}}
               scene:dispatchEvent({name="{{gdropt}}", event={UI=UI, dragLayer=dragLayer} })
              {{/gdropt}}
            {{#gback}}
            else
              dragLayer.x = dragLayer.oriX
              dragLayer.y = dragLayer.oriY
            {{/gback}}
            end
        {{/gdrop}}
      {{#gdropr}}
          {{#gcomplete}}
           scene:dispatchEvent({name="{{gcomplete}}", event={UI=UI, dragLayer=dragLayer} })
          {{/gcomplete}}
      {{/gdropr}}
      {{^gdropr}}
          {{#gcomplete}}
              if ({{glayer}}_lock == 0) then
               scene:dispatchEvent({name="{{gcomplete}}", event={UI=UI, dragLayer=dragLayer} })
              end
          {{/gcomplete}}
      {{/gdropr}}
      {{#gfocus}}
          display.getCurrentStage():setFocus(nil); t.isFocus = false
      {{/gfocus}}
      end
      return true
    end
    dragLayer:addEventListener( _K.MultiTouch.MULTITOUCH_EVENT, _K.{{glayer}}Drag )
end
--
function _M:dispose(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
  local scene       = UI.scene
  {{#gPage}}
  local dragLayer = sceneGroup
  {{/gPage}}
  {{^gPage}}
  local dragLayer = layer.{{glayer}}
  {{/gPage}}
    if (nil ~= {{glayer}} ) then
       dragLayer:removeEventListener ( _K.MultiTouch.MULTITOUCH_EVENT,  _K.{{glayer}}Drag );
    end
end
--
function _M:destroy()
    _K.{{glayer}}Drag = nil
end
--
return _M