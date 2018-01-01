-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
{{#ultimate}}
local imageWidth = {{elW}}/4
local imageHeight = {{elH}}/4
local mX, mY = _K.ultimatePosition({{mX}}, {{mY}})
{{/ultimate}}
{{^ultimate}}
local imageWidth = {{elW}}
local imageHeight = {{elH}}
local mX = {{mX}}
local mY = {{mY}}
{{/ultimate}}
local oriAlpha = {{oriAlpha}}
{{#kwk}}
local imagePath = "{{bn}}"
local ext       = "{{fExt}}"
{{/kwk}}
{{^kwk}}
local imagePath = "p{{docNum}}/{{bn}}"
local ext       = ".{{fExt}}"
{{/kwk}}
--
function _M:localPos(UI)
    local layer       = UI.layer
    local sceneGroup  = UI.scene.view
    local group = display.newGroup()
    group:insert(layer.{{targetLayer}})
    sceneGroup.blanket = layer.{{targetLayer}}
    layer.{{targetLayer}}.group = group
    sceneGroup:insert(group)
    --sceneGroup:remove(layer.{{targetLayer}})
end
--
function _M:allListeners(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
    local imageSuffix = display.imageSuffix or ""
    print( imageSuffix )
    print(_K.imgDir.. imagePath..imageSuffix..ext)
    local mask = graphics.newMask(_K.imgDir.. imagePath..imageSuffix..ext )
    layer.blanket.group:setMask(mask)
    layer.blanket.group.maskScaleX = {{scaleX}}*0.5
    layer.blanket.group.maskScaleY = {{scaleY}}*0.5
    layer.blanket.group.maskX = mX
    layer.blanket.group.maskY = mY
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
end
--
return _M