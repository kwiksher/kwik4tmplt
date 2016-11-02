-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local physics = require("physics")
--
function _M:localVars()
end
--
function _M:localPos()
end
--
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
{{/ultimate}}
{{^ultimate}}
local xFactor = 1
local yFactor = 1
{{/ultimate}}
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
    {{#piston}}
      local {{bgroup}} = physics.newJoint("{{btype}}", layer.{{bconn}}, layer.{{bname}}, {{bX}}*xFactor, {{bY}}*yFactor, {{aXd}}*xFactor, {{aYd}}*yFactor)
    {{/piston}}
    {{#distance}}
      local {{bgroup}} = physics.newJoint("{{btype}}", layer.{{bconn}}, layer.{{bname}}, {{bX}}*xFactor, {{bY}}*yFactor, {{bcX}}*xFactor, {{bcY}}*yFactor)
    {{/distance}}
    {{#pulley}}
      local {{bgroup}} = physics.newJoint("{{btype}}", layer.{{bconn}}, layer.{{bname}}, {{aXd}}*xFactor, {{aYd}}*yFactor, {{bXd}}*xFactor, {{bYd}}*yFactor, {{bX}}*xFactor, {{bY}}*yFactor, {{bcX}}*xFactor, {{bcY}}*yFactor, {{ratio}})
    {{/pulley}}
    {{#default}}
      local {{bgroup}} = physics.newJoint("{{btype}}", layer.{{bconn}}, layer.{{bname}}, {{bX}}*xFactor, {{bY}}*yFactor)
    {{/default}}
    {{#menabled}}
        {{bgroup}}.isMotorEnabled = {{menabled}}
    {{/menabled}}
    {{#mspeed}}
        {{bgroup}}.motorSpeed = {{mspeed}}
    {{/mspeed}}
    {{#mforce}}
        {{bgroup}}.motorForce = {{mforce}}
    {{/mforce}}
    {{#mtorque}}
        {{bgroup}}.maxMotorTorque = {{mtorque}}
    {{/mtorque}}
    {{#rotationx}}
        {{bgroup}}.isLimitEnabled = true
        {{bgroup}}:setRotationLimits({{rotationx}}, {{rotationy}})
    {{/rotationx}}
end
--
function _M:toDispose()
end
--
function _M:localVars()
end
--
return _M