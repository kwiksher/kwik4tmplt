-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local widget = require("widget")
local _K = require "Application"
--
function _M:createButton(UI)
  local sceneGroup = UI.scene.view
  local layer = display.newImageRect( _K.imgDir.. imagePath, _K.systemDir, self.imageWidth, self.imageHeight )
  if layer == nil then return end
    layer.x        = self.mX
    layer.y        = self.mY
    layer.alpha    = self.oriAlpha
    layer.oldAlpha = self.oriAlpha

    if self.randXStart > 0 then
      layer.x = math.random( self.randXStart, self.randXEnd)
    end
    if self.randYStart > 0 then
      layer.y = math.random( self.randYStart, self.randYEnd)
    end
    if self.scaleX then
      layer.xScale = self.scaleX
    end
    if self.scaleY thenn
      layer.yScale = self.scaleY
    end
    if self.rotation then
      layer:rotate( self.rotation )
    end

    if self.mask then
       local mask = graphics.newMask(_K.imgDir....self.pageNum.."/"..self.maskName, _K.systemDir )
      layer:setMask( mask )
    end

    layer.oriX  = layer.x
    layer.oriY  = layer.y
    layer.oriXs = layer.xScale
    layer.oriYs = layer.yScale
    layer.name  = self.layerName
    layer.blendMode = self.blendMode
    sceneGroup[self.layerName]  = layer
    sceneGroup:insert(layer)
end
--
function _M:createWidgetButton(UI)
  local function onEventHandler(self)
    if layer.enabled == nil or layer.enabled then
       layer.type = "press"
      -- {{bfun}}(layer)
      if self.isTV then
       if layer.isKey then
          UI.scene:dispatchEvent({name=self.eventName, layer=layer })
        end
      else
          UI.scene:dispatchEvent({name=self.eventName, layer=layer })
      end
  end
  --
  local layer = widget.newButton {
     id          = self.layerName,
     defaultFile = _K.imgDir..imagePath,
     overFile    = _K.imgDir..self.overFileName,
     width       = imageWidth,
     height      = imageHeight,
     onRelease   = onEventHandler,
     baseDir     = _K.systemDir
  }
  --
 if self.mask then
    local mask = graphics.newMask(_K.imgDir..self.pageNum.."/"..maskName, _K.systemDir)
    layer:setMask( mask )
 end
  --
  layer.x        = mX
  layer.y        = mY
  layer.oriX     = mX
  layer.oriY     = mY
  layer.oriXs    = layer.xScale
  layer.oriYs    = layer.yScale
  layer.alpha    = oriAlpha
  layer.oldAlpha = oriAlpha
  layer.name     = self.layerName
  layer.on     = onEventHandler
  sceneGroup[self.layerName]     = layer
  sceneGroup:insert(layer)
end
--
function _M:addEventListener(UI)
  function self.button:tap(event)
   event.UI = UI
   if self.enabled or self.enabled == nil then
     if self.btaps ~=nil and event.numTabs~=nil and
      self.btaps > 1 and event.numTaps then
       if event.numTaps == self.btaps then
           UI.scene:dispatchEvent({name=self.eventName, tap = event})
       end
     else
           UI.scene:dispatchEvent({name=self.eventName, tap = event})
     end
   end
   return true
 end
 self.button:addEventListener("tap", self.button)
 nd
--
function _M:removeEvwentListener(UI)
  self.UI = UI
 if self.button then
    self.button:removeEventListener("tap", self.button)
 end
end
--
_M.new = function(scene)
	local instance = {}
  instance.scene = scene
	setmetatable(instance, {__index=_M})
end
