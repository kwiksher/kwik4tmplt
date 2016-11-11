-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = require("components.kwik.tabButFunction").new(scene)
--
local widget = require("widget")
local _K = require "Application"
--
-- scene, layer and sceneGroup should be INPUT
-- tab{{um}} should be INPUT
-- tabja["witch"] = {"p2_witch_ja.png", 180, 262, 550, 581, 1}
--
-- UI.tSearch = tabja
--
{{#bn}}
{{#ultimate}}
local imageWidth             = {{elW}}/4
local imageHeight            = {{elH}}/4
local mX, mY                 = _K.ultimatePosition({{mX}}, {{mY}})
{{#randX}}
local randXStart = _K.ultimatePosition({{randXStart}})
local randXEnd = _K.ultimatePosition({{randXEnd}})
{{/randX}}
{{#randY}}
local dummy, randYStart = _K.ultimatePosition(0, {{randYStart}})
local dummy, randYEnd     = _K.ultimatePosition(0, {{randYEnd}})
{{/randY}}
{{#idist}}
local idist     = {{idist}}/4
{{/idist}}
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
{{#idist}}
local idist     = {{idist}}
{{/idist}}
{{/ultimate}}
local oriAlpha = {{oriAlpha}}
--
{{#kwk}}
local imagePath = "{{bn}}.{{fExt}}"
{{/kwk}}
{{^kwk}}
local imagePath = "p{{docNum}}/{{bn}}.{{fExt}}"
{{/kwk}}
{{/bn}}

function _M:localVars (UI)
  self:buttonVars(UI)
end
--
function _M:localPos(UI)
  self:buttonLocal(UI)
end
--
function _M:allListeners(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
  local self       = UI.scene
  --
  {{^multLayers}}
  {{#tabButFunction}}
    _M:createTabButFunction(UI, {obj={{tabButFunction.obj}}, btaps={{tabButFunction.btaps}}, eventName="{{myLName}}_{{layerType}}_{{triggerName}}"})
  {{/tabButFunction}}
  --
  {{#button}}
    {{#buyProductHide}}
      --Hide button if purchase was already made
      local path = system.pathForFile ("{{inApp}}.txt", system.DocumentsDirectory )
      local file = io.open( path, "r" )
      if file then
         --This page was purchased, do not show the BUY button
         {{layer}}.alpha = 0
      end
    {{/buyProductHide}}
  {{/button}}
  {{/multLayers}}
end
--
function _M:toDispose(UI)
  local layer      = UI.layer
  {{^multLayers}}
  {{#tabButFunction}}
    _M:removeTabButFunction(UI, {obj={{tabButFunction.obj}}, eventName="{{myLName}}_{{layerType}}_{{triggerName}}"})
  {{/tabButFunction}}
  {{/multLayers}}
end
--
function _M:toDestroy(UI)
end
--
function _M:buttonVars(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
  {{#multLayers}}
      UI.tab{{um}}["{{dois}}"] = {imagePath,imageWidth, imageHeight, mX, mY, imagePath, "{{myLName}}_{{layerType}}_{{triggerName}}", oriAlpha }
  {{/multLayers}}
end
--
function _M:buttonLocal(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
{{#bn}}
  {{^multLayers}}
    {{^Press}}
      layer.{{myLName}} = display.newImageRect( _K.imgDir.. imagePath, imageWidth, imageHeight )
      layer.{{myLName}}.x        = mX
      layer.{{myLName}}.y        = mY
      layer.{{myLName}}.alpha    = oriAlpha
      layer.{{myLName}}.oldAlpha = oriAlpha
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
          layer.{{myLName}}:rotate({{rotate}});
      {{/rotate}}
      layer.{{myLName}}.oriX  = layer.{{myLName}}.x
      layer.{{myLName}}.oriY  = layer.{{myLName}}.y
      layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
      layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
      layer.{{myLName}}.name  = "{{myLName}}"
      sceneGroup.{{myLName}}  = layer.{{myLName}}
      sceneGroup:insert(layer.{{myLName}})
    {{/Press}}
    {{#Press}}
        local function on{{myLName}}Event(self)
          if layer.{{myLName}}.enabled == nil or layer.{{myLName}}.enabled then
             layer.{{myLName}}.type = "press"
            -- {{bfun}}(layer.{{myLName}})
             self.scene:dispatchEvent({name="{{myLName}}_{{layerType}}_{{triggerName}}", layer=layer.{{myLName}}})
           end
        end
        layer.{{myLName}} = widget.newButton {
           id          = "{{myLName}}",
           defaultFile = _K.imgDir..imagePath,
           overFile    = _K.imgDir.."{{bOver}}.{{rExt}}",
           width       = imageWidth,
           height      = imageHeight,
           onRelease   = on{{myLName}}Event
        }
        layer.{{myLName}}.x        = mX
        layer.{{myLName}}.y        = mY
        layer.{{myLName}}.oriX     = mX
        layer.{{myLName}}.oriY     = mY
        layer.{{myLName}}.oriXs    = layer.{{myLName}}.xScale
        layer.{{myLName}}.oriYs    = layer.{{myLName}}.yScale
        layer.{{myLName}}.alpha    = oriAlpha
        layer.{{myLName}}.oldAlpha = oriAlpha
        layer.{{myLName}}.name     = "{{myLName}}"
        sceneGroup.{{myLName}}     = layer.{{myLName}}
        sceneGroup:insert(layer.{{myLName}})
    {{/Press}}
  {{/multLayers}}
{{/bn}}
end
--
return _M