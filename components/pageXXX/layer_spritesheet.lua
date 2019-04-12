-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
 local _M = {}
--
local _K = require "Application"
--
{{#ultimate}}
local imageWidth = {{elW}}/4
local imageHeight = {{elH}}/4
local mX, mY = _K.ultimatePosition({{mX}}, {{mY}})
{{#randX}}
local randXStart = _K.ultimatePosition({{randXStart}})
local randXEnd = _K.ultimatePosition({{randXEnd}})
{{/randX}}
{{#randY}}
local dummy, randYStart = _K.ultimatePosition(0, {{randYStart}})
local dummy, randYEnd     = _K.ultimatePosition(0, {{randYEnd}})
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
{{#kwik3Tp}}
{{#newImageSheet}}
    {{#arq}}
        local {{myLName}}_options = {
            {{arq}}
        }
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
    _M.{{myLName}}_sheet = graphics.newImageSheet( _K.spriteDir.. "{{elFi}}", _K.systemDir, {{myLName}}_options )
{{/newImageSheet}}
{{/kwik3Tp}}
{{^kwik3Tp}}
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
    _M.{{myLName}}_sheet = graphics.newImageSheet( _K.spriteDir.. "{{elFi}}", _K.systemDir, {{myLName}}_options )
{{/newImageSheet}}
{{/kwik3Tp}}
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
    if _M.{{myLName}}_sheet == nil then return end

{{^multLayers}}
    layer.{{myLName}} = display.newSprite(_M.{{myLName}}_sheet, {{myLName}}_seq ) -- ff_seq is to be used in future
    if layer.{{myLName}} == nil then return end
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
    layer.{{myLName}}:scale(imageWidth/layer.{{myLName}}.width, imageHeight/layer.{{myLName}}.height)
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
function _M:didShow()
end
--
function _M:toDispose()
end
--
return _M