-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
{{#ultimate}}
local imageWidth             = {{elW}}/4
local imageHeight            = {{elH}}
local mX, mY                 = _K.ultimatePosition({{mX}}, {{mY}})
{{#randX}}
local randXStart = _K.ultimatePosition({{randXStart}})
local randXEnd = _K.ultimatePosition({{randXEnd}})
{{/randX}}
{{#randY}}
local dummy, randYStart = _K.ultimatePosition(0, {{randYStart}})
local dummy, randYEnd     = _K.ultimatePosition(0, {{randYEnd}})
{{/randY}}
local elFontSize = {{elFontSize}}/4
{{/ultimate}}
{{^ultimate}}
local imageWidth = {{elW}}
local imageHeight = {{elH}}
local mX = {{mX}}
local mY = {{mY}}
{{#randX}}
local randXStart = {{randXStart}}
local randXEnd = {{randXEnd}}
{{/randX}}
{{#randY}}
local randYStart = {{randYStart}}
local randYEnd = {{randYEnd}}
{{/randY}}
local elFontSize = {{elFontSize}}
{{/ultimate}}
local oriAlpha = {{oriAlpha}}
--
function _M:localVars(UI)
  {{#isTmplt}}
   mX, mY = _K.getModel("{{myLName}}", imagePath, UI.dummy)
  {{/isTmplt}}
end
--
function _M:localPos(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{#globalVar}}
    local mVar = {{elVar}}
  {{/globalVar}}
  {{^globalVar}}
    local mVar = UI.{{elVar}}
  {{/globalVar}}
  {{#multLayers}}
    UI.tab{{um}}["{{dois}}"] = {mVar, imageWidth, imageHeight, mX, mY, oriAlpha, {{elFont}}, elFontSize, {{elFontColor}} }
  {{/multLayers}}

  {{^multLayers}}
  layer.{{myLName}} = display.newText(mVar,  mX, mY, imageWidth, imageHeight, {{elFont}}, elFontSize )
  if layer.{{myLName}} == nil then return end
  layer.{{myLName}}:setFillColor( {{elR}}, {{elG}}, {{elB}} )
  layer.{{myLName}}.anchorX = 0
  layer.{{myLName}}.anchorY = 0;
  _K.repositionAnchor(layer.{{myLName}},0.5,0);
  {{#randX}}
    layer.{{myLName}}.x = math.random( randXStart, randXEnd)
  {{/randX}}
  {{#randY}}
    layer.{{myLName}}.y = math.random( randYStart, {{randYEnd}})
  {{/randY}}
  {{#scaleW}}
    layer.{{myLName}}.xScale = {{scaleW}}
  {{/scaleW}}
  {{#scaleH}}
    layer.{{myLName}}.yScale = {{scaleH}}
  {{/scaleH}}
  {{#rotate}}
    layer.{{myLName}}:rotate({{rotate}}
  {{/rotate}}
  layer.{{myLName}}.oriX     = layer.{{myLName}}.x
  layer.{{myLName}}.oriY     = layer.{{myLName}}.y
  layer.{{myLName}}.oriXs    = layer.{{myLName}}.xScale
  layer.{{myLName}}.oriYs    = layer.{{myLName}}.yScale
  layer.{{myLName}}.alpha    = oriAlpha
  layer.{{myLName}}.oldAlpha = oriAlpha
  sceneGroup:insert( layer.{{myLName}})
  sceneGroup.{{myLName}} = layer.{{myLName}}
  {{/multLayers}}

end
--
return _M
