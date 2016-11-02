-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
  {{#randX}}
  local randXStart = {{randXStart}}/4
  local randXEnd = {{randXEnd}}/4
  {{/randX}}
  {{#randY}}
  local randYStart = {{randYStart}}/4
  local randYEnd = {{randYEnd}}/4
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
function _M:localVars()
end
--
function _M:localPos(UI)
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if UI.tSearch["{{bn}}"] == nil then return end
  {{#multLayers}}
    {{#elVectorRect}}
      layer.{{myLName}} = display.newRect( UI.tSearch["{{bn}}"][4], UI.tSearch["{{bn}}"][5], UI.tSearch["{{bn}}"][2], UI.tSearch["{{bn}}"][3] )
    {{/elVectorRect}}
    {{#elVectorCircle}}
      layer.{{myLName}} = display.newCircle( UI.tSearch["{{bn}}"][4], UI.tSearch["{{bn}}"][5], UI.tSearch["{{bn}}"][2]/2)
    {{/elVectorCircle}}
    layer.{{myLName}}:setFillColor ( UI.tSearch["{{bn}}"][7])
    {{#randX}}
      layer.{{myLName}}.x = math.random( randXStart, randXEnd)
    {{/randX}}
    {{#randY}}
      layer.{{myLName}}.y = math.random( randYStart, randYEnd)
    {{/randY}}
    {{#scaleW}}
      layer.{{myLName}}.xScale = {{scaleW}}
    {{/scaleW}}
    {{#scaleH}}
      layer.{{myLName}}.yScale = {{scaleH}}
    {{/scaleH}}
    {{#rotate}}
      layer.{{myLName}}:rotate( {{rotate)}})
    {{/rotate}}
    layer.{{myLName}}.oriX = layer.{{myLName}}.x
    layer.{{myLName}}.oriY = layer.{{myLName}}.y
    layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
    layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
    layer.{{myLName}}.alpha = UI.tSearch["{{bn}}"][6]
    layer.{{myLName}}.oldAlpha = UI.tSearch["{{bn}}"][6]
    layer.{{myLName}}.anchorX = 0
    layer.{{myLName}}.anchorY = 0
    {{#background}}
      sceneGroup:insert( 1, layer.{{myLName}})
      sceneGroup.{{myLName}} = layer.{{myLName}}
    {{/background}}
    {{^background}}
      sceneGroup:insert( layer.{{myLName}})
      sceneGroup.{{myLName}} = layer.{{myLName}}
    {{/background}}
  {{/multLayers}}
end
--
function _M:toDispose()
end
--
function _M:localVars()
  {{#multLayers}}
  {{/multLayers}}
end
--
return _M