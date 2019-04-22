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
		"{{layer}}_{{type}}_{{trigger}}",
    {{/if}}
	{{if(options.components)}}
		"{{layer}}_{{type}}_{{trigger}}",
	{{/if}}
}
---------------------
---------------------
VO.new = function(val)
	local vo = {
	page_common = val.page_common,
	    {{if(options.extLibCode)}}
			{{layer}}_{{type}}_{{trigger}} = val.{{layer}}_{{type}}_{{trigger}},
    	{{/if}}
		{{if(options.components)}}
			{{layer}}_{{type}}_{{trigger}} = val.{{layer}}_{{type}}_{{trigger}},
		{{/if}}
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