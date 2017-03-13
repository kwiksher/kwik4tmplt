-- Code created by Kwik - Copyright: kwiksher.com   {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require "Application"
local composer = require("composer")
local store = require ( "store" ) -- Available in Corona build #261 or later
---------------------
---------------------
{{^inApp}}
local ui          = require("components.store.UI")
{{/inApp}}

{{#inApp}}
    -- see iap(myi).jsx
    -- In-app purchase
    local listOfProducts = {
        {{#prod}}
          "{{pID}}",
        {{/prod}}
    }

local model       = require("components.store.model")
local ui          = require("components.store.UI").new()
local cmd         = require("components.store.command").new()
---------------------
function _M:resume()
  ui:refresh(true)
end
--
local function store_init(sceneGroup, layer)
    ui:init(sceneGroup, layer, true)
    cmd:init(ui)
    ui:create()
    -- UI:createBuyButton(model.epsode02, _W/2, _H/2, 150, 50)
    -- UI:createBuyButton(model.epsode03, _W/2, _H/2 + 50, 150, 50)
    -- UI:createRestoreButton(_W/2, _H/2+100, 150, 50)
    cmd:startDownload()
end
{{/inApp}}
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
  -- Page properties
{{#inApp}}
    store_init(sceneGroup, layer)
{{/inApp}}
end
--
function _M:localVars(UI)
end
--
function _M:allListeners(UI)
  {{#lockPage}}
    if not ui.hasDownloaded( "{{product}}" ) then
        --Page restricted. Send to pageError
        local infoString = "This page needs to be purchased."
        local function onComplete( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    -- dispose()
                    if nil~= composer.getScene("{{pError}}") then
                      composer.removeScene("{{pError}}", true)
                    end
                    composer.gotoScene("{{pError}}", { effects = "fromLeft" } )
    -- protect_2
                end
             end
        end
        local alert = native.showAlert("Restricted Content", infoString,{ "OK" }, onComplete)
    end
  {{/lockPage}}
end
--
function _M:willHide(UI)
end
--
function _M:toDispose(UI)
{{#inApp}}
  UI.layer.bg:removeEventListener("tap", hideOverlay)
  cmd:dispose()
{{/inApp}}
end
--
return _M