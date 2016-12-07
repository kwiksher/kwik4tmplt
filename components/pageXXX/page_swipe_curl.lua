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
local bgW, bgH = 1920/4, 1280/4                --  layer.{{backLayer}}.width, layer.{{backLayer}}.height
local pgX, pgY = _K.ultimatePosition(960, 640) --  layer.{{backLayer}}.x, layer.{{backLayer}}.y
local curlWidth = 400/4
{{/ultimate}}
{{^ultimate}}
local bgW, bgH = 2048, 1152
local pgX, pgY = 1024, 768
local curlWidth = 400
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
        next = display.newImageRect( _K.imgDir.. "p"..nextPage.."/background.png", bgW, bgH )
        next.x = pgX
        next.y = pgY
        sceneGroup:insert(next)
        next:toFront()
      end
    else
      if prev == nil and curPage ~= prevPage then
        prev = display.newImageRect( _K.imgDir.."p"..prevPage.."/background.png", bgW, bgH )
        prev.x = pgX
        prev.y = pgY
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
    back = page_curl.NewPageCurlWidget{width =W, height=H, size = curlWidth}
    back:SetImage(_K.imgDir.."p"..curPage.."/background.png")
    back.x = display.contentCenterX - W/2
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