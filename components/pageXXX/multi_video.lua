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
local _K = require "Application"
--
function _M:localVars()
end
--
function _M:localPos()
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if UI.tSearch["{{bn}}"] == nil then return end
  {{#multLayers}}
    layer.{{myLName}} = native.newVideo( UI.tSearch["{{bn}}"][4], UI.tSearch["{{bn}}"][5], UI.tSearch["{{bn}}"][2], UI.tSearch["{{bn}}"][3] )

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

    layer.{{myLName}}.alpha = UI.tSearch["{{bn}}"][7]
    layer.{{myLName}}.oldAlpha = UI.tSearch["{{bn}}"][7]
    {{#elLocal}}
      layer.{{myLName}}:load( _K.videoDir..UI.tSearch["{{bn}}"][6], system.ResourceDirectory )
    {{/elLocal}}
    {{^elLocal}}
      layer.{{myLName}}:load( UI.tSearch["{{bn}}"][6], media.RemoteSource )
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
  {{/multLayers}}
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{#multLayers}}
  if layer.{{myLName}} ~= nil then
     layer.{{myLName}}:pause()
     layer.{{myLName}}:removeSelf()
     layer.{{myLName}} = nil
  end
  {{/multLayers}}
end
--
function _M:localVars()
end
--
return _M