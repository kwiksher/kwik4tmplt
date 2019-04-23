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
		{{each(options.mediators)}}
		self:mapMediator("{{@this.view}}", "{{@this.custom}}{{@this.mediator}}")
		{{/each}}
		--
        _K = require("Application")
		{{each(options.commands)}}
		self:mapCommand("{{@this.event}}", _K.appDir.."{{@this.custom}}{{@key.command}}")
		{{/each}}
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