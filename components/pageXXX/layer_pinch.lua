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
    _K.MultiTouch.activate( layer.{{glayer}}, "scale", "multi", {minScale = {{gmin}}, maxScale = {{gmax}} })
    _K.{{glayer}}Pinc = function (event )
        if event.phase == "moved" then
            {{#gtclock}}
           UI.scene:dispatchEvent({name="{{gtclock}}", event={UI=UI} })
            {{/gtclock}}
         elseif event.phase == "ended" then
            {{#gtcounter}}
           UI.scene:dispatchEvent({name="{{gtcounter}}", event={UI=UI} })
            {{/gtcounter}}
        end
        return true
    end
    layer.{{glayer}}:addEventListener( _K.MultiTouch.MULTITOUCH_EVENT, _K.{{glayer}}Pinc )
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
    layer.{{glayer}}:removeEventListener ( _K.MultiTouch.MULTITOUCH_EVENT,  _K.{{glayer}}Pinc )
    --_K.Gesture.deactivate(layer.{{glayer}})
end
--
function _M:destroy()
    _K.{{glayer}}Pinc = nil
end
--
return _M