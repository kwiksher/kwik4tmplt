-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
{{if(options.isComic)}}
  {{if(options.mySet)}}
local layerSet_{{mySet}} = {
  {{if(options.layerSet)}}
    {
      myLName = "{{myLName}}",
      x       = {{mX}},
      y       = {{mY}},
      width   = {{elW}},
      height  = {{elH}},
      frameSet = {
      {{if(options.frameSet)}}
      {
        myLName = "{{myLName}}",
        x       = {{mX}},
        y       = {{mY}},
        width   = {{elW}},
        height  = {{elH}},
      },
      {{/if}}
      }
    },
  {{/if}}
  }
  {{/if}}
{{/if}}
{{if(options.infinity)}}
-- Infinity background animation
local function infinityBack(self, event)
     local xd, yd = self.x,self.y
     if (self.direction == "left" or self.direction == "right") then
         xd = self.width
         if (self.distance ~= nil) then
            xd = self.width + self.distance
        end
     elseif (self.direction == "up" or self.direction == "down") then
         yd = self.height
         if (self.distance ~= nil) then
            yd = self.height + self.distance
        end
     end
     if (self.direction == "left") then  --horizontal loop
        if self.x < (-xd + (self.speed*2)) then
           self.x = xd
        else
           self.x = self.x - self.speed
        end
     elseif (self.direction == "right") then  --horizontal loop
        if self.x > (xd - (self.speed*2)) then
           self.x = -xd
        else
           self.x = self.x + self.speed
        end
     elseif (self.direction == "up") then  --vertical loop
        if self.y < (-yd + (self.speed*2)) then
           self.y = yd
        else
           self.y = self.y - self.speed
        end
     elseif (self.direction == "down") then  --vertical loop
        if self.y > (yd - (self.speed*2)) then
           self.y = -yd
        else
           self.y = self.y + self.speed
        end
     end
end
{{/if}}
--
function _M:myMain()
end
-- not

{{if(options.ultimate)}}
local imageWidth             = {{elW}}/4
local imageHeight            = {{elH}}/4
local mX, mY                 = _K.ultimatePosition({{mX}}, {{mY}})
  {{if(options.randX)}}
  local randXStart = _K.ultimatePosition({{randXStart}})
  local randXEnd = _K.ultimatePosition({{randXEnd}})
  {{/if}}
  {{if(options.randY)}}
  local dummy, randYStart = _K.ultimatePosition(0, {{randYStart}})
  local dummy, randYEnd     = _K.ultimatePosition(0, {{randYEnd}})
  {{/if}}
  {{if(options.idist)}}
  local idist     = {{idist}}/4
  {{/if}}
{{#else}}
local imageWidth = {{elW}}
local imageHeight = {{elH}}
local mX = {{mX}}
local mY = {{mY}}
  {{if(options.randX)}}
  local randXStart = {{randXStart}}
  local randXEnd = {{randXEnd}}
  {{/if}}
  {{if(options.randY)}}
  local randYStart = {{randYStart}}
  local randYEnd = {{randYEnd}}
  {{/if}}
  {{if(options.idist)}}
  local idist     = {{idist}}
  {{/if}}
{{/if}}
local oriAlpha = {{oriAlpha}}
--
{{if(options.kwk)}}
local imagePath = "{{bn}}.{{fExt}}"
{{#else}}
local imagePath = "p{{docNum}}/{{bn}}.{{fExt}}"
{{/if}}
--
function _M:localVars(UI)
  {{if(options.isTmplt)}}
   mX, mY, imageWidth, imageHeight , imagePath= _K.getModel("{{myLName}}", imagePath, UI.dummy)
  {{/if}}
  {{if(options.multLayers)}}
    UI.tab{{um}}["{{dois}}"] = {imagePath, imageWidth, imageHeight, mX, mY, oriAlpha}
  {{#else}}
  {{/if}}
end
--
--[[
local info     = require ("assets.sprites.".."page{{docNum}}")
local sheet    = graphics.newImageSheet ( _K.spriteDir.."page{{docNum}}.png", _K.systemDir, info:getSheet() )
local sequence = {start=1, count= #info:getSheet().frames }
function newImageRect(name, width, height)
  local image
  if string.find(name, "background") == nil then
      image = display.newSprite(sheet, sequence)
      image.name = name
      image:setFrame (info:getFrameIndex (name))
      image.width, image.height = width, height
      else
       image = display.newImageRect(_K.imgDir..name.."."..{{fExt}}, _K.systemDir, width, height)
      end
   return image
end
--]]
--
function _M:localPos(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{if(options.multLayers)}}
  local function myNewImage()
    layer.{{myLName}} = display.newImageRect( _K.imgDir..imagePath, _K.systemDir, imageWidth, imageHeight)
    -- layer.{{myLName}} = newImageRect({{bn}}, imageWidth, imageHeight )
    if layer.{{myLName}} == nil then return end
    layer.{{myLName}}.imagePath = imagePath
    layer.{{myLName}}.x = mX
    layer.{{myLName}}.y = mY
    layer.{{myLName}}.alpha = oriAlpha
    layer.{{myLName}}.oldAlpha = oriAlpha
    layer.{{myLName}}.blendMode = "{{bmode}}"
    {{if(options.randX)}}
      layer.{{myLName}}.x = math.random( randXStart, randXEnd)
    {{/if}}
    {{if(options.randY)}}
      layer.{{myLName}}.y = math.random( randYStart, randYEnd)
    {{/if}}
    {{if(options.scaleW)}}
      layer.{{myLName}}.xScale = {{scaleW}}
    {{/if}}
    {{if(options.scaleH)}}
      layer.{{myLName}}.yScale = {{scaleH}}
    {{/if}}
    {{if(options.rotate)}}
      layer.{{myLName}}:rotate( {{rotate}} )
    {{/if}}
    layer.{{myLName}}.oriX = layer.{{myLName}}.x
    layer.{{myLName}}.oriY = layer.{{myLName}}.y
    layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
    layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
    layer.{{myLName}}.name = "{{myLName}}"
    sceneGroup.{{myLName}} = layer.{{myLName}}
    {{if(options.layerAsBg)}}
      sceneGroup:insert( 1, layer.{{myLName}})
    {{#else}}
      sceneGroup:insert( layer.{{myLName}})
    {{/if}}
    --
    {{if(options.infinity)}}
      layer.{{myLName}}_2 = display.newImageRect( _K.imgDir..imagePath, _K.systemDir, imageWidth, imageHeight)
        -- layer.{{myLName}}_2 = newImageRect({{bn}}, imageWidth, imageHeight )
      if layer.{{myLName}}_2 == nil then return end
      layer.{{myLName}}_2.blendMode = "{{bmode}}"
      sceneGroup:insert( layer.{{myLName}}_2)
      sceneGroup.{{myLName}}_2 = layer.{{myLName}}_2
      layer.{{myLName}}.anchorX = 0
      layer.{{myLName}}.anchorY = 0;
      _K.repositionAnchor(layer.{{myLName}}, 0,0)
      layer.{{myLName}}_2.anchorX = 0
      layer.{{myLName}}_2.anchorY = 0;
      _K.repositionAnchor(layer.{{myLName}}_2, 0,0)
      {{if(options.up)}}
        layer.{{myLName}}.x = layer.{{myLName}}.oriX
        layer.{{myLName}}.y = 0;
        {{if(options.idist)}}
          layer.{{myLName}}_2.y = layer.{{myLName}}.height + {{idist}}
          layer.{{myLName}}_2.x = layer.{{myLName}}.oriX;
          layer.{{myLName}}.distance = {{idist}}
          layer.{{myLName}}_2.distance = {{idist}}
        {{#else}}
          layer.{{myLName}}_2.y = layer.{{myLName}}.height
          layer.{{myLName}}_2.x = layer.{{myLName}}.oriX;
        {{/if}}
          layer.{{myLName}}.enterFrame = infinityBack
          layer.{{myLName}}.speed = {{infinitySpeed}}
          layer.{{myLName}}.direction = "{{idir}}"
          layer.{{myLName}}_2.enterFrame = infinityBack
          layer.{{myLName}}_2.speed = {{infinitySpeed}}
          layer.{{myLName}}_2.direction = "{{idir}}"
      {{/if}}
      {{if(options.down)}}
        layer.{{myLName}}.x = layer.{{myLName}}.oriX
        layer.{{myLName}}.y = 0;
        {{if(options.idist)}}
          layer.{{myLName}}_2.y = -layer.{{myLName}}.height - {{idist}}
          layer.{{myLName}}_2.x = layer.{{myLName}}.oriX;
          layer.{{myLName}}.distance = idist
          layer.{{myLName}}_2.distance = idist
        {{#else}}
          layer.{{myLName}}_2.y = -layer.{{myLName}}.height
          layer.{{myLName}}_2.x = layer.{{myLName}}.oriX;
        {{/if}}
          layer.{{myLName}}.enterFrame = infinityBack
          layer.{{myLName}}.speed = {{infinitySpeed}}
          layer.{{myLName}}.direction = "{{idir}}"
          layer.{{myLName}}_2.enterFrame = infinityBack
          layer.{{myLName}}_2.speed = {{infinitySpeed}}
          layer.{{myLName}}_2.direction = "{{idir}}"
      {{/if}}
      {{if(options.right)}}
        layer.{{myLName}}.x = 0
        layer.{{myLName}}.y = layer.{{myLName}}.oriY;
        {{if(options.idist)}}
          layer.{{myLName}}_2.x = -layer.{{myLName}}.width + {{idist}}
          layer.{{myLName}}_2.y = layer.{{myLName}}.oriY;
          layer.{{myLName}}.distance = idist
          layer.{{myLName}}_2.distance = idist
        {{#else}}
          layer.{{myLName}}_2.x = -layer.{{myLName}}.width
          layer.{{myLName}}_2.y = layer.{{myLName}}.oriY;
        {{/if}}
        layer.{{myLName}}.enterFrame = infinityBack
        layer.{{myLName}}.speed = {{infinitySpeed}}
        layer.{{myLName}}.direction = "{{idir}}"
        layer.{{myLName}}_2.enterFrame = infinityBack
        layer.{{myLName}}_2.speed = {{infinitySpeed}}
        layer.{{myLName}}_2.direction = "{{idir}}"
      {{/if}}
      {{if(options.left)}}
        layer.{{myLName}}.x = 0
        layer.{{myLName}}.y = layer.{{myLName}}.oriY;
        {{if(options.idist)}}
          layer.{{myLName}}_2.x = layer.{{myLName}}.width + {{idist}}
          layer.{{myLName}}_2.y = layer.{{myLName}}.oriY;
                layer.{{myLName}}.distance = idist
                layer.{{myLName}}_2.distance = idist
        {{#else}}
          layer.{{myLName}}_2.x = layer.{{myLName}}.width
          layer.{{myLName}}_2.y = layer.{{myLName}}.oriY;
        {{/if}}
          layer.{{myLName}}.enterFrame = infinityBack
          layer.{{myLName}}.speed = {{infinitySpeed}}
          layer.{{myLName}}.direction = "{{idir}}"
          layer.{{myLName}}_2.enterFrame = infinityBack
          layer.{{myLName}}_2.speed = {{infinitySpeed}}
          layer.{{myLName}}_2.direction = "{{idir}}"
      {{/if}}
    {{/if}}
   end
  {{/if}}

{{if(options.isComic)}}
  {{if(options.mySet)}}
  local options = {
   frames ={},
    sheetContentWidth = imageWidth,
    sheetContentHeight = imageHeight
  }
  local widthDiff = options.sheetContentWidth - {{mX}}/2
  local heightDiff = options.sheetContentHeight - {{mY}}/2
  --
  for i=1, #layerSet_{{mySet}} do
    local target = layerSet_{{mySet}}[i]
    local _x = (target.x - target.width/2)/4 + widthDiff/2
    local _y = (target.y - target.height/2)/4 + heightDiff/2
    -- print(_x, _y)
    options.frames[i] = {
      x = _x,
      y = _y,
      width = target.width/4,
      height = target.height/4
    }
    -- print(target.width/4, target.height/4)
  end
  layer.{{mySet}} = display.newGroup()
  local sheet = graphics.newImageSheet(_K.imgDir..imagePath, _K.systemDir, options )
  for i=1, #layerSet_{{mySet}} do
    local target = layerSet_{{mySet}}[i]
    local frame = options.frames[i]
    local frame1 = display.newImageRect( sheet, i, frame.width, frame.height )
    frame1.x, frame1.y = _K.ultimatePosition(target.x, target.y)
    frame1.name = target.myLName
    frame1.oriX              = frame1.x
    frame1.oriY              = frame1.y
    frame1.oriXs             = 1
    frame1.oriYs             = 1
    frame1.oldAlpha          = 1
    frame1.anim              = {}
    target.panel = frame1
    UI.layer[target.myLName] = frame1
    layer.{{mySet}}:insert(frame1)
  end
  --
  layer.{{myLName}}.imagePath = imagePath
  -- layer.{{myLName}}.x = mX
  -- layer.{{myLName}}.y = mY
  layer.{{myLName}}.alpha = oriAlpha
  layer.{{myLName}}.oldAlpha = oriAlpha
  layer.{{myLName}}.blendMode = "{{bmode}}"
  {{if(options.scaleW)}}
    layer.{{myLName}}.xScale = {{scaleW}}
  {{/if}}
  {{if(options.scaleH)}}
    layer.{{myLName}}.yScale = {{scaleH}}
  {{/if}}
  {{if(options.rotate)}}
    layer.{{myLName}}:rotate( {{rotate}} )
  {{/if}}
  layer.{{myLName}}.oriX = layer.{{myLName}}.x
  layer.{{myLName}}.oriY = layer.{{myLName}}.y
  layer.{{myLName}}.oriXs = layer.{{myLName}}.xScale
  layer.{{myLName}}.oriYs = layer.{{myLName}}.yScale
  layer.{{myLName}}.name = "{{myLName}}"
  sceneGroup.{{myLName}} = layer.{{myLName}}
  sceneGroup:insert( layer.{{myLName}})
  {{#else}}
    myNewImage()
  {{/if}}
{{#else}}
  {{if(! options.hasOwnProperty('multLayers'))}}
  myNewImage()
  {{/if}}
{{/if}}
end
--
function _M:didShow(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{if(! options.hasOwnProperty('multLayers'))}}
    {{if(options.infinity)}}
       -- Infinity background
       if layer.{{myLName}} == nil  or layer.{{myLName}}_2 == nil then return end
       Runtime:addEventListener("enterFrame", layer.{{myLName}})
       Runtime:addEventListener("enterFrame", layer.{{myLName}}_2)
    {{/if}}
  {{/if}}
end
--
function _M:toDispose(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{if(! options.hasOwnProperty('multLayers'))}}
    {{if(options.infinity)}}
      if layer.{{myLName}} == nil  or layer.{{myLName}}_2 == nil then return end
      Runtime:removeEventListener("enterFrame", layer.{{myLName}})
      Runtime:removeEventListener("enterFrame", layer.{{myLName}}_2)
    {{/if}}
    --test
  {{/if}}
end
--
function  _M:toDestory()
end
--
return _M