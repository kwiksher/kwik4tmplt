-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}, published on {{today}}
--
local AnimationCommand = {}
local _K = require("Application")
local anim = require(_K.appName.."components.page0{{page}}.{{myLName}}_{{layerType}}_{{triggerName}}")
-----------------------------
-----------------------------
function AnimationCommand:new()
	local command = {}
	--
	function command:execute(params)
		local UI    = params.event.UI
		local phase = params.event.phase
		if phase == "didShow" then
			anim:repoHeader(UI)
			anim:buildAnim(UI)
		elseif phase=="dispose" then
			anim:dispose()
		elseif phase=="play" then
			anim:play()
		end
	end
	return command
end
--
return AnimationCommand