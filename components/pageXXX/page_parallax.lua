-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require "Application"
---------------------
function _M:allListeners(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    --
    {{#parallaxArr}}
    layer.{{nm2}}X = {{nm}}.x
    layer.{{nm2}}Y = {{nm}}.y
    {{/parallaxArr}}
    --
    _K.accelerometerHandler = function(event)
    	{{#parallaxArr}}
      {{#dampX}}
           {{nm}}.x = layer.{{nm2}}X + (layer.{{nm2}}X * event.yGravity * {{dpx}});
      {{/dampX}}
      {{#dampY}}
           {{nm}}.y = layer.{{nm2}}Y + (layer.{{nm2}}Y * event.yGravity * {{dpy}});
      {{/dampY}}
        if event.zGravity > 0 then
          {{#triggerBack}}
           UI.scene:dispatchEvent({name="{{triggerBack}}", event={UI=UI} })
          {{/triggerBack}}
        else
          {{#triggerForward}}
           UI.scene:dispatchEvent({name="{{triggerForward}}", event={UI=UI} })
          {{/triggerForward}}
        end
      {{/parallaxArr}}
    end
    Runtime:addEventListener("accelerometer", _K.accelerometerHandler)
    _K.tAccell = _K.accelerometerHandler
end

function _M:toDispose()
end

function _M:localVars()
end

return _M