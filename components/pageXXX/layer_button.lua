-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = require("components.kwik.tabButFunction").new(scene)
--
local widget = require("widget")
local _K = require "Application"
{{#buyProductHide}}
local IAP    = require ( "components.store.IAP" )
{{/buyProductHide}}
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
   {{#isTmplt}}
   mX, mY, imageWidth, imageHeight , imagePath = _K.getModel("{{myLName}}", imagePath, UI.dummy)
   {{/isTmplt}}
  self:buttonVars(UI)
end
--
function _M:localPos(UI)
  self:buttonLocal(UI)
end
--
{{#tabButFunction}}
local command = require("commands.page0{{docNum}}.{{myLName}}_{{layerType}}_{{triggerName}}"):new()
{{/tabButFunction}}

{{#bn}}
{{^multLayers}}
{{#Press}}
local command = require("commands.page0{{docNum}}.{{myLName}}_{{layerType}}_{{triggerName}}"):new()
{{/Press}}
{{/multLayers}}
{{/bn}}
--
function _M:allListeners(UI)
  local sceneGroup = UI.scene.view
  local layer      = UI.layer
  local self       = UI.scene
  --
  {{^multLayers}}
  {{#tabButFunction}}
  if {{tabButFunction.obj}} == nil then return end
  {{tabButFunction.obj}}.tap = function(self, event)
    if {{tabButFunction.obj}}.enabled == nil or {{tabButFunction.obj}}.enabled then
      local btaps = {{tabButFunction.btaps}}
      if btaps > 1 and event.numTaps then
        if event.numTaps == btaps then
          command:execute{UI=UI}
        end
      else
        command:execute{UI=UI}
      end
    end
    return true
  end
  {{tabButFunction.obj}}:addEventListener( "tap", {{tabButFunction.obj}})
  {{/tabButFunction}}

  {{#buyProductHide}}
      --Hide button if purchase was already made
    if IAP.getInventoryValue("unlock_".."{{inApp}}") then
         --This page was purchased, do not show the BUY button
       layer.{{layer}}.alpha = 0
      end
    {{/buyProductHide}}
  {{/multLayers}}
end
--
function _M:toDispose(UI)
  local layer      = UI.layer
  local sceneGroup = UI.scene.view

  {{^multLayers}}
  {{#tabButFunction}}
  if {{tabButFunction.obj}} == nil then return end
  {{tabButFunction.obj}}:removeEventListener( "tap", {{tabButFunction.obj}})
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
      layer.{{myLName}} = display.newImageRect( _K.imgDir.. imagePath, _K.systemDir, imageWidth, imageHeight )
    if layer.{{myLName}} == nil then return end
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
            {{#TV}}
             if layer.{{myLName}}.isKey then
			        command:execute{UI=UI}
             end
            {{/TV}}
            {{^TV}}
			        command:execute{UI=UI}
            {{/TV}}
           end
        end
        layer.{{myLName}} = widget.newButton {
           id          = "{{myLName}}",
           defaultFile = _K.imgDir..imagePath,
           overFile    = _K.imgDir.."{{bOver}}.{{rExt}}",
           width       = imageWidth,
           height      = imageHeight,
           onRelease   = on{{myLName}}Event,
           baseDir     = _K.systemDir
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
        layer.{{myLName}}.on     = on{{myLName}}Event
        sceneGroup.{{myLName}}     = layer.{{myLName}}
        sceneGroup:insert(layer.{{myLName}})
    {{/Press}}
  {{/multLayers}}
{{/bn}}
end
--
return _M