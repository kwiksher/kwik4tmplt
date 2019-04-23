-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local VO = {}
VO.field = "{{field}}" --
---------------------
---------------------
local Const = require("extlib.const")
VO.const = Const:new{
	"page_common",
    {{if(options.extLibCode)}}
		"{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}",
    {{/if}}
	{{each(options.components)}}
		"{{@this.layer}}_{{@this.type}}_{{@this.trigger}}",
	{{/each}}
}
---------------------
---------------------
VO.new = function(val)
	local vo = {
	page_common = val.page_common,
	    {{if(options.extLibCode)}}
			{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}} = val.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}},
    	{{/if}}
		{{each(options.components)}}
			{{@this.layer}}_{{@this.type}}_{{@this.trigger}} = val.{{@this.layer}}_{{@this.type}}_{{@this.trigger}},
		{{/each}}
	}
	--
	function vo:copyFrom(copyVO)
	end
	--
	function vo:valueOf()
		return baseDir.."/"..self.filename
	end
	--
	return vo
end
--
VO.equal = function(vo1, vo2)
	return vo1.valueOf() == vo2.valueOf()
end
--
return VO