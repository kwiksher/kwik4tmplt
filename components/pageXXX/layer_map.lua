-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
local imageWidth = {{elW}}/4
local imageHeight = {{elH}}/4
local mX = {{mX}}*xFactor
local mY = {{mY}}*yFactor
{{#randX}}
local randXStart = {{randXStart}}*xFactor
local randXEnd = {{randXEnd}}*yFactor
{{/randX}}
{{#randY}}
local randYStart = {{randYStart}}*xFactor
local randYEnd = {{randYEnd}}*yFactor
{{/randY}}
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
{{/ultimate}}
local oriAlpha = {{oriAlpha}}
--
function _M:localPos(UI)
  {{#multLayers}}
    UI.tab{{um}}["{{dois}}"] = {"", imageWidth, imageHeight, mX, mY, oriAlpha, {{elColor}} }
  {{/multLayers}}
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{^multLayers}}
    layer.{{myLName}} = native.newMapView( mX, mY, imageWidth, imageHeight )
    layer.{{myLName}}.mapType = "{{elRender}}"
    layer.{{myLName}}:setCenter( {{elLat}}, {{elLong}} )
    layer.{{myLName}}.isScrollEnabled = {{elScroll}}
    layer.{{myLName}}.isZoomEnabled = {{elZoom}}

    {{#elMarker}}
        layer.{{myLName}}:addMarker( {{elLat}}, {{elLong}}, {title="{{elMTitle}}", subtitle="{{elMSub}}" } )
    {{/elMarker}}

    {{#randX}}
        layer.{{myLName}}.x = math.random( randXStart, randXEnd);
    {{/randX}}
    {{#randY}}
        layer.{{myLName}}.y = math.random( randYStart, randYEnd);
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

    layer.{{myLName}}.alpha = {{oriAlpha}}
    layer.{{myLName}}.oldAlpha = {{oriAlpha}}

    sceneGroup:insert( layer.{{myLName}})
    sceneGroup.{{myLName}} = layer.{{myLName}}
  {{/multLayers}}
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{^multLayers}}
  if layer.{{myLName}} ~= nil then
     layer.{{myLName}}:removeSelf()
   layer.{{myLName}} = nil
  end
  {{/multLayers}}
end
--
return _M