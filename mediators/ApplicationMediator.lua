-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local ApplicationMediator = {}
local _K = require "Application"
--
--  viewInstance is an instance of Application
--
function ApplicationMediator:new()
	local mediator = {}
	mediator.session = nil
	--
	function mediator:onRegister()
		Runtime:addEventListener("onTrigger", self)
    --
    -- now let's load top page
    --
		-- self.viewInstance:showView("{{showView}}", {})
		self.viewInstance:showView("views.page0".._K.goPage.."Scene", {})
	end
	--
	function mediator:onTrigger(event)
		self.viewInstance:trigger(event.url)
	end
	--
	return mediator
end
--
return ApplicationMediator