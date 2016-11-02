-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
local page_curl  = require("extlib.page_curl")
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
  local curPage     = UI.curPage
  local numPages    = UI.numPages
  local back, next, prev
  local prevPage, nextPage
  nextPage = curPage + 1
  if nextPage > numPages then nextPage = curPage end
  prevPage = curPage - 1
  if prevPage < 1 then prevPage = 1 end

  if layer.{{backLayer}} == nil then return end
  local W, H = layer.{{backLayer}}.width, layer.{{backLayer}}.height
  local function Grabbed(event)
    local curl = event.target
    if event.dir == "right" then
      if next == nil and curPage~=nextPage then
        next = display.newImageRect( _K.imgDir.. "p"..nextPage.."_background.png", 2048*xFactor, 1152*yFactor )
        next.x = 1024*xFactor
        next.y = 768*yFactor
        sceneGroup:insert(next)
        next:toFront()
      end
    else
      if prev == nil and curPage ~= prevPage then
        prev = display.newImageRect( _K.imgDir.."p"..prevPage.."_background.png", 2048*xFactor, 1152*yFactor )
        prev.x = 1024*xFactor
        prev.y = 768*yFactor
        sceneGroup:insert(prev)
        prev:toFront()
      end
    end
    back:toFront()
  end
  --
  local function Released(event)
    back:toBack()
    if next then
      next:removeSelf()
      next = nil
    end
    if prev then
      prev:removeSelf()
      prev = nil
    end
  end
  --
  local function Moved (event)
    local curl, passed_threshold = event.target
    if event.dir == "right" then
      passed_threshold = curl.edge_x < .3
    else
      passed_threshold = curl.edge_x > .7
    end
    if passed_threshold then
       if event.dir == "right" and _K.kBidi == false then
          wPage = curPage + 1
          if wPage > numPages then wPage = curPage end
          options = { effect = "fromRight"}
       elseif event.dir == "right" and _K.kBidi == true then
          wPage = curPage - 1
          if wPage < 1 then wPage = 1 end
          options = { effect = "fromLeft"}
       elseif event.dir == "left" and _K.kBidi == true then
          wPage = curPage + 1
          if wPage > numPages then wPage = curPage end
          options = { effect = "fromRight"}
       elseif event.dir == "left" and _K.kBidi == false then
          wPage = curPage - 1
          if wPage < 1 then wPage = 1 end
          options = { effect = "fromLeft"}
       end
       if tonumber(wPage) ~= tonumber(curPage) then
            _K.appInstance:showView("views.page0"..wPage.."Scene", options)
         end
    end
  end
  --
  if back == nil then
    back = page_curl.NewPageCurlWidget{width =W, height=H, size = 400*xFactor}
    back:SetImage(_K.imgDir.."p"..curPage.."_background.png")
    back.y  = display.contentCenterY - H/2
    back:SetTouchSides("left_and_right")
    back:addEventListener("page_grabbed", Grabbed)
    back:addEventListener("page_dragged", Moved)
    back:addEventListener("page_released", Released)
    sceneGroup:insert(back)
    back:toBack()
    -- debug mode
    local regions = back:GetGrabRegions()
    for _, region in pairs(regions) do
      local rect = display.newRoundedRect(back.parent, region.x, region.y, region.width, region.height, 12)
      rect:setFillColor(.3, .3)
      rect:setStrokeColor(.4, .5, .2)
      rect.strokeWidth = 10
      sceneGroup:insert(rect)
    end
  end
  layer.{{backLayer}}.alpha = 0
end
--
function _M:dispose()
end
--
function _M:destroy()
end
--
return _M