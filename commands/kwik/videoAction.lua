-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
function _M:playVideo(obj)
	obj:pause()
end
--
function _M:pauseVideo(obj)
	obj:pause()
end
--
function _M:rewindVideo(obj)
	obj:seek(0)
end
--
return _M