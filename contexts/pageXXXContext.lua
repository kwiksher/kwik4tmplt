-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _Class = {}
--
function _Class:new(super)
	local context = super
	--
	function context:init()
------------------------------------------------------------
------------------------------------------------------------
		{{#mediators}}
		self:mapMediator("{{view}}", "{{custom}}{{mediator}}")
		{{/mediators}}
		--
        _K = require("Application")
		{{#commands}}
		self:mapCommand("{{event}}", _K.appDir.."{{custom}}{{command}}")
		{{/commands}}
		--
	end
  --
  function context:addInitializer(t)
  	local t = require(t)
  	for k,v in pairs(t) do self.Router[k] = v end
  end
  --
	return context
end
--
return _Class