-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _Command = {}
-----------------------------
-----------------------------
function _Command:new()
	local command = {}
	--
	function command:execute(params)
		local event         = params.event
		local expDir        = params.expDir
		if event=="init" then
			if expDir then
			composer.imgDir    = "assets/images/"
			composer.audioDir  = "assets/audio/"
			composer.videoDir  = "assets/videos/"
			composer.spriteDir = "assets/sprites/"
			composer.thumbDir  = "assets/thumbnails/"
			else
				composer.imgDir    = "assets/"
				composer.audioDir  = "assets/"
				composer.videoDir  = "assets/"
				composer.spriteDir = "assets/"
				composer.thumbDir  = "assets/"
			end
		end
	end
	return command
end
--
return _Command