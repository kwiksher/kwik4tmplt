-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local StartupCommand = {}

function StartupCommand:new()
	local command = {}

	function command:execute(event)
		-- original example executes database access when starting up the app
	end

	return command
end

return StartupCommand