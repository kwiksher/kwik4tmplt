-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {timer={}}
local _K = require("Application")
local widget = require( "widget" )
--
--
local _Duration        = 3000
local _SheetWidth      = 1656
local _SheetHeight     = 2200
local _ContentWidth    = 1280
local _ContentHeight   = 1920
local _BackgroundColor = { 0.8, 0.8, 0.8 }
local _Scale           = 1.5
---------------------
---------------------
function _M:localPos(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  --
  UI.layerSet_{{mySet}} = {
  {{#layerSet}}
    {
      myLName = "{{myLName}}",
      x       = {{mX}},
      y       = {{mY}},
      width   = {{elW}},
      height  = {{elH}},
      frameSet = {
      {{#frameSet}}
      {
        myLName = "{{myLName}}",
        x       = {{mX}},
        y       = {{mY}},
        width   = {{elW}},
        height  = {{elH}},
      },
      {{/frameSet}}
      }
    },
  {{/layerSet}}
  }
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local panels  = UI.layerSet_{{mySet}}
  local ballons = UI.layer.ballons
  local layer = UI.layer
  local index = 1
  local scale = 1
  -------------------------------
  -- scrollView
  -------------------------------
  local options = {
   frames ={},
    sheetContentWidth = _SheetWidth/4,
    sheetContentHeight = _SheetHeight/4
  }
  --
  local widthDiff = options.sheetContentWidth - _ContentWidth/4
  local heightDiff = options.sheetContentHeight - _ContentHeight/4
  --
  for i=1, #panels do
    local target = panels[i]
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
  --
  local scrollView = widget.newScrollView(
      {
          top             = 0,
          left            = 0,
          width           = display.contentWidth,
          height          = display.contentHeight,
          scrollWidth     = options.sheetContentWidth,
          scrollHeight    = options.sheetContentHeight,
          backgroundColor = _BackgroundColor,
          listener        = function() end
      }
  )
  ---------------
  -- create panels out of layer.background and layerSet_{{mySet}}
  ---------------
  local sheet = graphics.newImageSheet(_K.imgDir..layer.background.imagePath, options )
  for i=1, #panels do
    local target = panels[i]
    local frame = options.frames[i]
    local frame1 = display.newImageRect( sheet, i, frame.width, frame.height )
    frame1.x, frame1.y = _K.ultimatePosition(target.x, target.y)
    scrollView:insert( frame1 )
    target.panel = frame1
  end
  UI.scrollView = scrollView
  sceneGroup:insert(scrollView)
  layer.background.alpha = 0
  --
  local function frameTransition()
    if index > #panels then
      timer.performWithDelay( 1000, function()
          UI.scrollView.alpha = 0
          UI.layer.pageCurl.alpha = 1
          for i=1, #panels do
            local target = panels[i]
            target.panel.alpha  = 1
            target.panel.xScale = 1
            target.panel.yScale = 1
            target.panel.x, target.panel.y = _K.ultimatePosition(target.x, target.y)
          end
          ballons.x, ballons.y = 0, 0
          for i=1, ballons.numChildren do
            local ballon = ballons[i]
            ballon.alpha = 1
            ballon.xScale = 1
            ballon.yScale = 1
            ballon.x = ballon.oriX
            ballon.y = ballon.oriY
          end
          ballons:toFront()
          ballons.alpha = 1
        end, 1)
        table.insert(_M.timer, t)
      return
    end
    local target = panels[index]
    local frames = target.frameSet
    local panel  = target.panel
    if index > 1 then
      panels[index-1].panel.alpha = 0
    end
    -- panel:scale(scale, scale)
    if target.frameSet and #target.frameSet > 0 then
        local k              = 1
        local frame          = target.frameSet[k]
        local next           = target.frameSet[k+1]
        -- print("frame "..frame.myLName)
        UI.scrollView.width  = frame.width/4*_Scale
        UI.scrollView.height = frame.height/4*_Scale
        local oriX, oriY = target.panel.x, target.panel.y
        target.panel.x       = UI.scrollView.x
        target.panel.y       = UI.scrollView.y
        target.panel:translate( (target.x - frame.x)/4, (target.y - frame.y)/4 )
        target.panel:toFront()
        target.panel.xScale = _Scale
        target.panel.yScale = _Scale
        -- show up the ballon
        local preBallons, nextBallons = {}, {}
        for i=1, ballons.numChildren do
          local ballon = ballons[i]
          ballon.alpha = 0
          ballon:scale(0.1, 0.1)
          if string.find(ballon.name, frame.myLName) then
            local bX, bY = ballon.oriX - oriX, ballon.oriY-oriY
            ballon.x = target.panel.x  + bX*_Scale
            ballon.y = target.panel.y  + bY*_Scale
            transition.to(ballon, {alpha=1, xScale = _Scale, yScale = _Scale})
            table.insert( preBallons, ballon )
          end
          if string.find(ballon.name, next.myLName) then
            ballon.isNext = true
            table.insert(nextBallons, ballon)
          end
        end
        --------------------------------
        -- next frame
        --------------------------------
        local nextDeltaX, nextDeltaY =  (next.x - frame.x)/4, (next.y - frame.y)/4
        local fX, fY = target.panel.x - nextDeltaX, target.panel.y - nextDeltaY
        -- change mask(scrollView)'s width and height
        transition.to(UI.scrollView, {width=next.width/4*_Scale, height=next.height/4*_Scale, delay = _Duration})
          for i=1, #preBallons do
            if not preBallons[i].isNext then
              transition.to(preBallons[i], {alpha = 0, delay = _Duration})
            else
              transition.moveBy(preBallons[i], {x= -nextDeltaX, y=-nextDeltaY, delay = _Duration} )
            end
          end
          -- show up the ballon
          for i=1, #nextBallons do
            local ballon = nextBallons[i]
            local bX, bY = ballon.oriX - oriX, ballon.oriY-oriY
            transition.to(ballon, {
            x = fX  + bX*_Scale,
            y = fY  + bY*_Scale,
              alpha=1, xScale = _Scale, yScale = _Scale, delay = _Duration})
          end
        --show next frame
        transition.to(target.panel, {x=fX, y = fY, delay = _Duration,
          onComplete = function ()
            index = index + 1
            local t = timer.performWithDelay(_Duration, frameTransition,1)
            table.insert(_M.timer, t)
          end})
    else
        UI.scrollView.width  = target.width/4*_Scale
        UI.scrollView.height = target.height/4*_Scale
        local oriX, oriY = target.panel.x, target.panel.y
        target.panel.x       = UI.scrollView.x
        target.panel.y       = UI.scrollView.y
        target.panel:toFront()
        target.panel.xScale = _Scale
        target.panel.yScale = _Scale
        -- ballons:translate( deltaX, deltaY )
        for i=1, ballons.numChildren do
          local ballon = ballons[i]
          local bX, bY = ballon.oriX - oriX, ballon.oriY-oriY
          ballon.x = target.panel.x  + bX*_Scale
          ballon.y = target.panel.y  + bY*_Scale
          ballon.alpha = 0
          ballon:scale(0.1, 0.1)
          if string.find(ballon.name, target.myLName) then
            transition.to(ballon, {alpha=1, xScale = _Scale, yScale = _Scale})
          end
        end
        -- ballons:toFront()
        index = index + 1
        local t = timer.performWithDelay(_Duration, frameTransition, 1)
        table.insert(_M.timer, t)
      end
  end
  --
  UI.scrollView.alpha = 0
  --
  local t =  timer.performWithDelay(5000,
    function()
      UI.layer.pageCurl.alpha = 0
      UI.layer.background.alpha = 0
      UI.scrollView.alpha = 1
      --
      for i=1, #panels do
        panels[i].panel.alpha = 1
      end
      ballons:toFront()
      frameTransition()
    end, 1)
  table.insert(self.timer, t)
end
--
function _M:toDispose(UI)
  UI.scrollView:removeSelf()
  transition.cancel()
  for i=1, #self.timer do
    timer.cancel(self.timer[i])
  end
end
--
function _M:localVars()
end
--
return _M