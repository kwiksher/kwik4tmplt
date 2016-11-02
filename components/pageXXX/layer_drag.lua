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

    _K.MultiTouch.activate( layer.{{glayer}}, "move", "single", {{dbounds}} )
    {{#gdrop}}
        local {{glayer}}_lock = 0
        local {{glayer}}_posX = 0
        local {{glayer}}_posY = 0
    {{/gdrop}}
    {{#gFlip}}
        local wO_{{glayer}} = "{{gFlipDir}}"; local cr_{{glayer}} = layer.{{glayer}}.{{xyx}}
    {{/gFlip}}
    _K.{{glayer}}Drag = function (event )
      local t = event.target
      if event.phase == "began" then
        {{#gfocus}}
            local parent = t.parent; parent:insert(t); display.getCurrentStage():setFocus(t); t.isFocus = true
        {{/gfocus}}
      elseif event.phase == "moved" then
        {{#gFlip}}
          if (layer.{{glayer}}.{{xyx}} < cr_{{glayer}}) then
            if (wO_{{glayer}} == "{{xd1}}") then
              layer.{{glayer}}.{{xyx}}Scale = {{xs1}}
              wO_{{glayer}} = "{{xd2}}"
            end
          elseif (layer.{{glayer}}.{{xyx}} > cr_{{glayer}}) then
            if (wO_{{glayer}} == "{{xd2}}") then
              layer.{{glayer}}.{{xyx}}Scale = {{xs2}}
              wO_{{glayer}} = "{{xd1}}"
            end
          end
          cr_{{glayer}} = layer.{{glayer}}.{{xyx}}
        {{/gFlip}}
        {{#gdrop}}
            {{glayer}}_posX = layer.{{glayer}}.x - layer.{{gdrop}}.x
            {{glayer}}_posY = layer.{{glayer}}.y - layer.{{gdrop}}.y
            if ({{glayer}}_posX < 0) then
              {{glayer}}_posX = {{glayer}}_posX * -1
            end
            if ({{glayer}}_posY < 0) then
              {{glayer}}_posY = {{glayer}}_posY * -1
            end
            if ({{glayer}}_posX <= {{gdropb}}) and ({{glayer}}_posY <= {{gdropb}}) then  --in position\r\n'
              layer.{{glayer}}.x = layer.{{gdrop}}.x
              layer.{{glayer}}.y = layer.{{gdrop}}.y
              {{glayer}}_lock = 1
            else
              {{glayer}}_lock = 0
            end
        {{/gdrop}}
        {{#gdragging}}
           scene:dispatchEvent({name="{{gdragging}}", event={UI=UI} })
        {{/gdragging}}
        elseif event.phase == "ended" or event.phase == "cancelled" then
          {{#gdrop}}
            if ({{glayer}}_lock == 1 and {{glayer}}_posX <= {{gdropb}}) and ({{glayer}}_posY <= {{gdropb}}) then
               layer.{{glayer}}.x = layer.{{gdrop}}.x
               layer.{{glayer}}.y = layer.{{gdrop}}.y
              {{#dropl}}
                 _K.MultiTouch.deactivate(layer.{{glayer}})
              {{/dropl}}
              {{#gdropt}}
               scene:dispatchEvent({name="{{gdropt}}", event={UI=UI} })
              {{/gdropt}}
            {{#gback}}
            else
              layer.{{glayer}}.x = layer.{{glayer}}.oriX
              layer.{{glayer}}.y = layer.{{glayer}}.oriY
            {{/gback}}
            end
        {{/gdrop}}
      {{#gdropr}}
          {{#gcomplete}}
           scene:dispatchEvent({name="{{gcomplete}}", event={UI=UI} })
          {{/gcomplete}}
      {{/gdropr}}
      {{^gdropr}}
          {{#gcomplete}}
              if ({{glayer}}_lock == 0) then
               scene:dispatchEvent({name="{{gcomplete}}", event={UI=UI} })
              end
          {{/gcomplete}}
      {{/gdropr}}
      {{#gfocus}}
          display.getCurrentStage():setFocus(nil); t.isFocus = false
      {{/gfocus}}
      end
      return true
    end
    layer.{{glayer}}:addEventListener( _K.MultiTouch.MULTITOUCH_EVENT, _K.{{glayer}}Drag )
end
--
function _M:dispose()
    if (nil ~= {{glayer}} ) then
       layer.{{glayer}}:removeEventListener ( _K.MultiTouch.MULTITOUCH_EVENT,  _K.{{glayer}}Drag );
    end
end
--
function _M:destroy()
    _K.{{glayer}}Drag = nil
end
--
return _M