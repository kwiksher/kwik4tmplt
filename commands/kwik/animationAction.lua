-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K            = require "Application"
--
function _M:pauseAnimation(layer)
  if _K.gt[layer] then
     _K.gt[layer]:pause()
  end
end
--
function _M:resumeAnimation(layer)
    _K.gt[layer]:play()
end
--
function _M:playAnimation(layer)
    -- _K.gt[layer]:toBeginning()
    _K.gt[layer]:play()
end
--
return _M