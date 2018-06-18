-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
{{#ultimate}}
{{#randX}}
local randXStart = _K.ultimatePosition({{randXStart}})
local randXEnd = _K.ultimatePosition({{randXEnd}})
{{/randX}}
{{#randY}}
local dummy, randYStart = _K.ultimatePosition(0, {{randYStart}})
local dummy, randYEnd     = _K.ultimatePosition(0, {{randYEnd}})
{{/randY}}
{{/ultimate}}
{{^ultimate}}
  {{#randX}}
  local randXStart = {{randXStart}}
  local randXEnd = {{randXEnd}}
  {{/randX}}
  {{#randY}}
  local randYStart = {{randYStart}}
  local randYEnd = {{randYEnd}}
  {{/randY}}
{{/ultimate}}
--
function _M:localVars(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
end
--
function _M:localPos(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer

    _M.{{myLName}}_sheet  = UI.tSearch["{{dois}}"][7]
    local {{myLName}}_seq = UI.tSearch["{{dois}}"][8]
    --
    layer.{{myLName}} = display.newSprite(_M.{{myLName}}_sheet, {{myLName}}_seq ) -- ff_seq is to be used in future
    {{#multLayers}}
        layer.{{myLName}}.x        = UI.tSearch["{{dois}}"][4]
        layer.{{myLName}}.y        = UI.tSearch["{{dois}}"][5]
        layer.{{myLName}}.alpha    = UI.tSearch["{{dois}}"][6]
        layer.{{myLName}}.oldAlpha = UI.tSearch["{{dois}}"][6]
    {{/multLayers}}
    {{#randX}}
        layer.{{myLName}}.x = math.random(randXStart , randXEnd)
    {{/randX}}
    {{#randY}}
        layer.{{myLName}}.y = math.random( randXStart , randXEnd)
    {{/randY}}
    {{#scaleW}}
        layer.{{myLName}}.xScale = {{scaleW}}
    {{/scaleW}}
    {{#scaleH}}
        layer.{{myLName}}.yScale = {{scaleH}}
    {{/scaleH}}
    {{#rotate}}
        layer.{{myLName}}:rotate( {{rotate}})
    {{/rotate}}
    layer.{{myLName}}.oriX = layer.{{myLName}}.x
    layer.{{myLName}}.oriY = layer.{{myLName}}.y
    layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
    layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
    layer.{{myLName}}.name = "{{myLName}}"
    layer.{{myLName}}.type = "sprite"
    {{#elPaused}}
        layer.{{myLName}}:pause()
    {{/elPaused}}
    {{^elPaused}}
        layer.{{myLName}}:play()
    {{/elPaused}}
    sceneGroup.{{myLName}} = layer.{{myLName}}
    sceneGroup:insert( layer.{{myLName}})

end
--
function _M:didShow()
end
--
function _M:toDispose()
end
--
return _M