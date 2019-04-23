-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local Context = require "extlib.robotlegs.Context"
local _Class = {}

--
function _Class:new()
	local context = Context:new()
	context.Router = {}
{{each(options.pages)}}
	_Class.page0{{@this.pageNum}}Context = require("{{@this.custom}}contexts.page0{{@this.pageNum}}Context")
{{/each}}
	--
	function context:init()
		------------------------------------------------------------
		------------------------------------------------------------
	{{each(options.pages)}}
	    self.context0{{@this.pageNum}} = _Class.page0{{@this.pageNum}}Context:new(self)
	    self.context0{{@this.pageNum}}:init()
	{{/each}}

		-- app init command
		self:mapCommand("app.Ads",          "commands.app.Ads")
		self:mapCommand("app.bookmark",     "commands.app.bookmark")
		-- self:mapCommand("app.coronaViewer", "commands.app.coronaViewer")
		self:mapCommand("app.droidHWKey",   "commands.app.droidHWKey")
		-- self:mapCommand("app.expDir",       "commands.app.expDir")
		self:mapCommand("app.extCodes",     "commands.app.extCodes")
		self:mapCommand("app.kwkVar",       "commands.app.kwkVar")
		{{if(options.use && options.use.lang)}}
		self:mapCommand("app.lang",         "commands.app.lang")
		{{/if}}
		-- self:mapCommand("app.loadLib",      "commands.app.loadLib")
		-- self:mapCommand("app.memoryCheck",  "commands.app.memoryCheck")
		self:mapCommand("app.statusBar",    "commands.app.statusBar")
		self:mapCommand("app.suspend",      "commands.app.suspend")
		-- self:mapCommand("app.variables",    "commands.app.variables")
		-- self:mapCommand("app.versionCheck", "commands.app.versionCheck")
		--
		self:mapMediator("Application", "mediators.ApplicationMediator")
		--
		Runtime:dispatchEvent({name="startup"})
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
