-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local ActionCommand = {}
ActionCommand.type = "{{type}}"
ActionCommand.name = "{{name}}"
ActionCommand.page = "{{page}}"
--
----------------------------
-----------------------------
function HideCommand:new()
	local command = {}
	--
	function command:execute(params)
		local UI         = params.UI
		local sceneGroup = UI.scene.view
		local layer      = UI.layer
		local phase     = params.event.phase
		if phase == "create" then
			{{#nativeobj}}
         layer.{{gname}}.alpha = 0
			{{/nativeobj}}
		else if phase == "didShow" then
			{{#dispobj}}
         layer.{{gname}}.alpha = 0
			{{/dispobj}}
		end
	end
	return command
end
--
return HideCommand