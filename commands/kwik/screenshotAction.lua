-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require("Application")
--
function _M:takeScreenShot(layer, ptit, pmsg, shutter, buttonArr)
	_K.screenshot:takeScreenShot(layer, ptit, pmsg, shutter, buttonArr)
end
--
return _M
