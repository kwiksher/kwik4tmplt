-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
function _M:localVars(UI)
end
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
    UI.tab{{um}}["{{dois}}"] = {"", imageWidth, imageHeight, mX, mY, "{{elURL}}", "{{oriAlpha}}"}
  {{/multLayers}}
  {{^multLayers}}
  {{/multLayers}}
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{^multLayers}}
    layer.{{myLName}} = native.newVideo( mX, mY, imageWidth, imageHeight )

    {{#randX}}
      layer.{{myLName}}.x = math.random( randXStart,randXEnd)
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
      layer.{{myLName}}:rotate( {{rotate)}})
    {{/rotate}}
    layer.{{myLName}}.oriX = layer.{{myLName}}.x
    layer.{{myLName}}.oriY = layer.{{myLName}}.y
    layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
    layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale

    layer.{{myLName}}.alpha = oriAlpha
    layer.{{myLName}}.oldAlpha = oriAlpha
    {{#elLocal}}
      layer.{{myLName}}:load( _K.videoDir.."{{elURL}}", system.ResourceDirectory )
    {{/elLocal}}
    {{^elLocal}}
      layer.{{myLName}}:load( "{{elURL}}", media.RemoteSource )
    {{/elLocal}}
    {{#elPlay}}
      layer.{{myLName}}:play()
    {{/elPlay}}
    {{#elTriggerElLoop}}
      local function videoListener_{{myLName}}(event)
        if event.phase == "ended" then
          {{#elRewind}}
            layer.{{myLName}}:seek(0)  --rewind video after play
          {{/elRewind}}
          {{#elLoop}}
            layer.{{myLName}}:play()
          {{/elLoop}}
          {{#elTrigger}}
            {{elTrigger}}()
          {{/elTrigger}}
         end
      end
      layer.{{myLName}}:addEventListener( "video", videoListener_{{myLName}} )
    {{/elTriggerElLoop}}
    layer.{{myLName}}.name = "{{myLName}}"
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
     layer.{{myLName}}:pause()
     layer.{{myLName}}:removeSelf()
     layer.{{myLName}} = nil
  end
  {{/multLayers}}
end
--
function _M:localVars()
  {{#multLayers}}
  {{/multLayers}}
end
--
return _M