-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}, published on {{today}}
--
local ActionCommand = {}
--
function ActionCommand:new()
	local command = {}
	--
	function command:execute(params)
		local UI         = params.UI
		local sceneGroup = UI.scene.view
		local layer      = UI.layer
		local phase     = params.event.phase
			{{#vvar}}
				{{vvar}}
			{{/vvar}}
			{{#arqCode}}
				{{arqCode}}
			{{/arqCode}}
		end
		return command
end
--
return ActionCommand