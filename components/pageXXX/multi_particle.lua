-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
local particleDesigner = require("extLib.particleDesigner")
--
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
local mX = {{mX}}*xFactor
local mY = {{mY}}*yFactor
{{/ultimate}}
{{^ultimate}}
local mX = {{mX}}
local mY = {{mY}}
{{/ultimate}}
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if UI.tSearch["{{bn}}"] == nil then return end
  {{#multLayers}}
    layer.{{myLName}} = particleDesigner.newEmitter( UI.tSearch["{{bn}}"][6] )
    {{^elPlay}}
        layer.{{myLName}}:pause();
    {{/elPlay}}
    layer.{{myLName}}.x = mX
    layer.{{myLName}}.y = mY
    layer.{{myLName}}.oriX = layer.{{myLName}}.x
    layer.{{myLName}}.oriY = layer.{{myLName}}.y
    layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
    layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
    layer.{{myLName}}.type = "particles"
    sceneGroup:insert(layer.{{myLName}});
  {{/multLayers}}
end
--
function _M:toDispose()
end
--
function _M:localPos (UI)
end
--
function _M:localVars()
end
--
return _M