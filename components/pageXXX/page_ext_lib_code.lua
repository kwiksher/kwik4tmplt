-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
---------------------
-- External libraries
  {{#extLib}}
    local {{name}} = require("{{libname}}")
  {{/extLib}}
--
function _M:localVars(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    {{#extCodeTop}}
    {{ccode}}
    {{arqCode}}
    {{/extCodeTop}}
end
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
end
--
function _M:allListeners(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    {{#extCodeMid}}
    {{ccode}}
    {{arqCode}}
    {{/extCodeMid}}

    {{#extCodeBtm}}
    {{ccode}}
    {{arqCode}}
    {{/extCodeBtm}}
end
--
function _M:toDispose(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    {{#extCodeDsp}}
    {{ccode}}
    {{arqCode}}
    {{/extCodeDsp}}
end
--
return _M