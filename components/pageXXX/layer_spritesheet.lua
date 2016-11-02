-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
 local _M = {}
--
local _K = require "Application"
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
{{#newImageSheet}}
    {{#arq}}
        local {{myLName}}_options = {}
        local newSheetInfo = function()
            {{arq}}
        end
        {{myLName}}_options = newSheetInfo().sheet
    {{/arq}}
    {{^arq}}
        local {{myLName}}_options = {
            width              = {{frameWidth}},
            height             = {{frameHeight}},
            numFrames          = {{autoFrames}},
            sheetContentWidth  = {{sheetWidth}},
            sheetContentHeight = {{sheetHeight}}
        }
    {{/arq}}
    _M.{{myLName}}_sheet = graphics.newImageSheet( _K.spriteDir.. "{{elFi}}", {{myLName}}_options )
{{/newImageSheet}}
--
{{#frameCount}}
    -- 2
    local {{myLName}}_seq = {
        {{#sequences}}
            {{^seq.frameCount}}
                { name = "{{seq.name}}",
                  frames = {{{seq.frameStart}}},
            {{/seq.frameCount}}
            {{#seq.frameCount}}
                { name = "{{seq.name}}",
                  start = {{seq.frameStart}},
                  count = {{seq.frameCount}},
            {{/seq.frameCount}}
                  time = {{seq.frameLength}},
                  loopCount = {{seq.loop}},
                  loopDirection = "{{seq.elDirection}}",
                },
        {{/sequences}}
    }
{{/frameCount}}
    --
function _M:localVars(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    {{#multLayers}}
        UI.tab{{um}}["{{dois}}"] = {
            "{{elFi}}",
            imageWidth, -- elW
            imageHeight, -- elH
            mX,  -- mX
            mY,  -- mY
            oriAlpha, -- oriAlpha
            _M.{{myLName}}_sheet, -- imageSheet
             {{myLName}}_seq
        }
    {{/multLayers}}

            -- {{elFraS}}, -- elFraS
            -- {{frameCount}}, -- frameCount
            -- {{elLength}}, -- elLength
            -- {{elLoop}}, -- elLoop
            -- {{frameWidth}}, -- frameWidth
            -- {{frameHeight}}, -- frameHeight
            -- {{sheetWidth}}, -- sheetWidth
            -- {{sheetHeight}}, -- sheetHeight
            -- {{elDirection}}} -- elDirection

end
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer

{{^multLayers}}
    layer.{{myLName}} = display.newSprite(_M.{{myLName}}_sheet, {{myLName}}_seq ) -- ff_seq is to be used in future
    layer.{{myLName}}.x        = mX
    layer.{{myLName}}.y        = mY
    layer.{{myLName}}.alpha    = oriAlpha
    layer.{{myLName}}.oldAlpha = oriAlpha
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
{{/multLayers}}
end
--
function _M:allListeners()
end
--
function _M:toDispose()
end
--
return _M