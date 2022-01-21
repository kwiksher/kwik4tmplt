-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = require("components.kwik.layer_button").new()
--
local widget = require("widget")
local _K = require "Application"

--
-- scene, layer and sceneGroup should be INPUT
-- tab{{um}} should be INPUT
-- tabja["witch"] = {"p2_witch_ja.png", 180, 262, 550, 581, 1}
--
-- UI.tSearch = tabja
--
_M.ultimate = parseValue({{ultimate}})
_M.isTmplt  = parseValue({{isTmplt}})
_M.isSharedAsset = parseValue({{kwk}})
_M.multLayers = parseValue({{multLayers}})
_M.buyProductHide = parseValue({{buyProductHide}})
_M.pageNum = "p{{docNum}}"
_M.isTV = parseValue({{TV}})

_M.layerName     = "{{myLName}}"
_M.oriAlpha = {{oriAlpha}}
_M.imagePath = "{{bn}}.{{fExt}}"
_M.imageName = "/{{bn}}.{{fExt}}"
_M.langGroupName = "{{dois}}"
_M.langTableName = "tab{{um}}"
_M.scaleX     = parseValue({{scaleW}})
_M.scaleY     = parseValue({{scaleH}})
_M.rotation   = parseValue({{rotate}})
if _M.ultimate then
  _M.imageWidth  = {{elW}}/4
  _M.imageHeight = {{elH}}/4
  _M.mX, _M.mY   = _K.ultimatePosition({{mX}}, {{mY}}, "{{align}}")
  _M.randXStart  = _K.ultimatePosition({{randXStart}})
  _M.randXEnd    = _K.ultimatePosition({{randXEnd}})
  _M.dummy, _M.randYStart = _K.ultimatePosition(0, {{randYStart}})
  _M.dummy, _M.randYEnd   = _K.ultimatePosition(0, {{randYEnd}})
  _M.infinityDistance = (parseValue({{idist}}) or 0)/4
else
  _M.imageWidth  = {{elW}}
  _M.imageHeight = {{elH}}
  _M.mX, _M.mY         = _K.ultimatePosition({{mX}}, {{mY}}, "{{align}}")
  _M.randXStart  = parseValue({{randXStart}})
  _M.randXEnd    = parseValue({{randXEnd}})
  _M.randYStart  = parseValue({{randYStart}})
  _M.randYEnd    = parseValue({{randYEnd}})
  _M.infinityDistance = parseValue({{idist}}) or 0
end

_M.eventName = "{{myLName}}_{{layerType}}_{{triggerName}}"
_M.overFileName  = "{{bOver}}.{{rExt}}"

_M.button = {}
{{#tabButFunction}}
-- obj will be layer.XXX or sceneGroup
-- this euals to (not self.isPress). isPress uses widge.tNewButton«
_M.button = {{tabButFunction.obj}}
  _M.button.btaps={{tabButFunction.btaps}}
  _M.button.eventName = _M.eventName
{{/tabButFunction}}

_M.mask = parseValue{{mask}}
if _M.ultimate then
  _M.maskName = "{{bn}}".. "_mask.jpg"
else
  _M.maskName = "{{bn}}".. "_mask" .. (display.imageSuffix or "")..".jpg"
end

_M.inventory = "unlock_".."{{inApp}}"

function _M:localVars (UI)
  if not self.isSharedAsset then
    self.imagePath = "p"..UI.imagePage ..self.imageName
  end
  if self.isTmplt then
   self.mX, self.mY, self.imageWidth, self.imageHeight , self.imagePath= _K.getModel(self.layerName, self.imagePath, UI.dummy)
  end
  if self.#multLayers then
    UI[self.langTableName][self.langGroupName] = {imagePath,imageWidth, imageHeight, mX, mY, imagePath, self.eventName, oriAlpha }
  end
end
--
function _M:localPos(UI)
  local sceneGroup  = UI.scene.view
  -- Page properties
  if self.buyProductHide then
    local model       = require("components.store.model")
    local IAP         = require ( "components.store.IAP" )
    local view        = require("components.store.view").new()
    view:init(sceneGroup, layer)
    IAP:init(model.catalogue, view.restoreAlert, view.purchaseAlert, function(e) print("IAP cancelled") end, model.debug)
  end
  --
  if not self.multLayers then
    if not self.isSharedAsset then
      self.imagePath = "p"..UI.imagePage..self.imageName
    end
    if not self.isPress then
        self:createButton(UI)
      else
        self:createWidgetButton(UI)
      end
    end
end
--
function _M:didShow(UI)
  local sceneGroup = UI.scene.view
  --
  if not self.multLayers then
    if self.button then
      _M:addEventListener(UI)
    end
    if self.buyProductHide then
      local IAP         = require ( "components.store.IAP" )
      --Hide button if purchase was already made
      if IAP.getInventoryValue(self.inventory) then
          --This page was purchased, do not show the BUY button
          sceneGroup[self.layerName].alpha = 0
        end
      end
    end
end
--
function _M:toDispose(UI)
  local sceneGroup = UI.scene.view
  if not self.multLayers then
    if self.button then
      _M:removeEvwentListener(UI)
    end
  end
end
--
function _M:toDestroy(UI)
end
--