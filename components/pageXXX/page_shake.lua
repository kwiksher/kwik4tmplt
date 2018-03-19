-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
    local function shakeMe(e)
     if(e.isShake == true) then
           UI.scene:dispatchEvent({name="action_{{gcomplete}}", shake=e })
     end
     return true
    end
    Runtime:addEventListener("accelerometer", shakeMe)
end
--
return _M