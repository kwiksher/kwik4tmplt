-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require("Application")
_K.screenshot = _M
---------------------
function _M:localPos(UI)
	if _K.allAudios.cam_shutter == nil then
	  _K.allAudios.cam_shutter = audio.loadSound(_K.audioDir.."shutter.mp3", _K.systemDir )
	end
end
--
function _M:allListeners(UI)
	_M.layer = UI.layer
end
--
function _M:takeScreenShot(ptit, pmsg, shutter, buttonArr)
	if shutter then
		audio.play(_K.allAudios.cam_shutter, {channel=31})
	end
	if buttonArr then
		for i=1, #buttonArr do
		  _M.layer[buttonArr[i]].alpha = 0
		end
	end
	--
  local screenCap = display.captureScreen( true )
  local alert = native.showAlert(ptit, pmsg, { "OK" } )
  screenCap:removeSelf()
	--
	if buttonArr then
		for i=1, #buttonArr do
		  _M.layer[buttonArr[i]].alpha = 1
		end
	end
end
--
function _M:toDispose(UI)
	if _K.allAudios.cam_shutter then
		audio.stop(31)
		audio.dispose(_K.allAudios.cam_shutter)
		_K.allAudios.cam_shutter = nil
	end
end
--
function _M:willHide(UI)
end
--
function _M:localVars(UI)
end
--
return _M