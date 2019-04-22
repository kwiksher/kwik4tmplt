-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _Command = {}
-----------------------------
{{if(options.extlib)}}
local {{name}} = requireKwik("{{libname}}")
{{/if}}
-----------------------------
function _Command:new()
	local command = {}
	--
	function command:execute(params)
		local event         = params.event
		if event=="init" then
			-- Adding external code
			{{if(options.extCode)}}
			    {{ccode}}
			    {{arqCode}}
			{{/if}}
		end
	end
	return command
end
--
return _Command