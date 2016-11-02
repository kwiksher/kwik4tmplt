-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}, published on {{today}}
--
local ActionCommand = {}
--
local Var = require("components.kwik.vars")
local _K = require "Application"
--
function ActionCommand:new()
	local command = {}
	--
	function command:execute(params)
		local UI         = params.UI
		local sceneGroup = UI.scene.view
		local layer      = UI.layer
		local phase     = params.event.phase
		{{#global}}
			_K.{{vvar}} = {{vval}}
		{{/global}}
		{{^global}}
			UI.{{vvar}} = {{vval}}
		{{/global}}
		{{#save}}
      {{#vtype}}
        Var:saveKwikVars({"{{vvar}}", _K.{{vvar}} })
      {{/vtype}}
      {{^vtype}}
        Var:saveKwikVars({"{{vvar}}", UI.{{vvar}} })
      {{/vtype}}
		{{/save}}
		{{#dynatxtArr}}
			layer.{{vlay}}.text = UI.{{vvar}}
		{{/dynatxtArr}}
		end
		return command
end
--
return ActionCommand