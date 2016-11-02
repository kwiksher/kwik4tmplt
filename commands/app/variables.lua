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
		if event=="init" then
			composer.kwk_readMe = 0
			composer.kBidi     = {{use.bidi}}
			composer.kAutoPlay = 0
			composer.goPage    = {{curPage}}
		end
	end
	return command
end
--
return _Command