-- Code created by Kwik - Copyright: kwiksher.com   {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require "Application"
local composer = require("composer")
---------------------
---------------------
{{#inApp}}
local view          = require("components.store.view").new()
local storeFSM = require ( "components.store.storeFSM" ).getInstance()
---------------------
function _M:resume()
  ui:refresh(true)
end
--
local function hideOverlay()
    composer.hideOverlay("fade", 400 )
    return true
end
--
{{/inApp}}
{{#lockPage}}
local cmd          = require("components.store.command").new()
{{/lockPage}}
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
  -- Page properties
{{#inApp}}
    view:init(sceneGroup, layer, storeFSM.fsm)
    storeFSM:init(true, view) -- overlay
{{/inApp}}
{{#lockPage}}
    cmd:init(nil)
{{/lockPage}}
end
--
function _M:localVars(UI)
end
--
function _M:allListeners(UI)
  {{#inApp}}
  storeFSM.view = view
  {{/inApp}}
  {{#lockPage}}
    if not cmd.hasDownloaded( "{{product}}" ) then
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
    storeFSM:destroy()
{{/inApp}}
end
--
return _M