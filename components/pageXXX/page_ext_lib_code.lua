-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
---------------------
-- External libraries
local _K = require "Application"
  {{each(options.extLib)}}
    local {{@this.name}} = requireKwik("{{@this.libname}}")
  {{/each}}
--
{{if(options.TV)}}
local kInputDevices = require("extlib.tv.kInputDevices")
{{/if}}

function _M:localVars(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    
    {{if(options.extCodeTop)}}
    {{each(options.extCodeTop)}}
    {{ccode}}
    {{arqCode}}
    {{/each}}
    {{/if}}
end
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    
    {{if(options.extCodeMid)}}
    {{each(options.extCodeMid)}}
    {{ccode}}
    {{arqCode}}
    {{/each}}
    {{/if}}
  }
end
--
function _M:didShow(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer

    {{if(options.TV)}}
    kInputDevices:initGroup()
    {{/if}}

    {{if(options.extCodeBtm)}} 
    {{each(options.extCodeBtm)}}
    {{ccode}}
    {{arqCode}}
    {{/each}}
    {{/if}}

    {{if(options.TV)}}
    kInputDevices:willShow()
    kInputDevices:didShow()
    {{/if}}

end
--
function _M:toDispose(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer

    {{if(options.extCodeDsp)}}
    {{each(options.extCodeDsp)}}
    {{ccode}}
    {{arqCode}}
    {{/each}}
    {{/if}}

    {{if(options.TV)}}
    kInputDevices:willHide()
    kInputDevices:didHide()
    {{/if}}

end

return _M