local M = {}
--
local IAP             = require("components.store.IAP")
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")
local master          = require("model") -- case tmplt, it returns the pages table. case embedded, it is overwritten as {isEmbedded = true} at the runtime by Kwikshelf plugin
local composer        = require("composer")
local UI              = require("components.store.UI")


local type={pages = 0, embedded = 1, tmplt=2}
local bookShelfType = model.bookShelfType -- please set one of them

local downloadGroup = nil
local onDownloadComplete = nil

function M.new ()
    local CMD = {}
    print("commands.new", CMD)
    --
    function CMD:init(view)
        self.view = view
        downloadGroup = view.downloadGroup
    	--IAP:init(model.catalogue, restoreAlert, purchaseAlert)
    	--downloadManager:init(self.onDownloadComplete, onDownloadError)
    end
    -- Called when the scene's view does not exist:

    function CMD:startDownload()
        downloadManager:startDownload()
    end

    function CMD:dispose()
        print("------------------CMD:dispose")
        -- Runtime:removeEventListener("command:purchaseCompleted", self.onPurchaseComplete)
        -- for i=1, #CMD.buttons do
        --     CMD.buttons[i]:removeEventListener("tap", CMD.gotoScene)
        -- end
    end

    function CMD.gotoScene(event)
        print("CMD.gotoScene")
        UI.gotoScene(event)
    end
    --
    function CMD.showOverlay(event)
        local epsode =  event.target.epsode
        local options = {
            isModal = true,
            effect = model.showOverlayEffect,
            time = 400,
            params = {}
        }
        local page = model.INFO_PAGE
        if  bookShelfType == type.pages then
             page = model.getPageInfo(epsode.name)
        end
        if page then
            if master.isEmbedded then
                package.loaded[page] = require("plugin.KwikShelf."..page)
            end
            model.currentEpsode = {name=epsode, isPurchased = event.target.isPurchased}
            composer.showOverlay(page, options)
        return true
        else
            return false
        end
    end

    function CMD.hideOverlay()
        composer.hideOverlay("fade", 400 )
        return true
    end

    function CMD.restore(event)
        for k, epsode in pairs (model.epsodes) do
            local button = CMD.view.layer[epsode.name.."Icon"]
            button:removeEventListener("tap", CMD.gotoScene)
            button.savedBtn:removeEventListener("tap", CMD.gotoScene)
        end
        IAP.restorePurchases(event)
    end

    function CMD:setButtonImage(button, id)
        downloadManager.setButtonImage(button, id)
    end

    function CMD.hasDownloaded(name)
        return downloadManager.hasDownloaded(name)
    end

    function CMD.buyBook(e)
        IAP.buyEpsode(e)
    end

    function CMD.onPurchase(name)
        IAP.buyEpsode({target = {selectedPurchase = name}})
    end

    function CMD.onDownload(name)
       downloadManager:startDownload(name)
    end

    function CMD.onSaved(name)
        if downloadManager.hasDownloaded(name) then
            UI.gotoScene({target = {selectedPurchase = name}})
        end
    end
    return CMD
end

-- it will be called from the purchaseListener and the restoreListener functions
function M.onPurchaseComplete(event)
    local selectedPurchase = event.product
    local button = downloadGroup[selectedPurchase]
    print("CMD onPurchaseComplete", selectedPurchase)
    --
    if button then
        button.purchaseBtn:removeEventListener("tap", IAP.buyEpsode)
        --
        if (event.actionType == "purchase") then
            -- button.text.text="saving"
            if model.URL then
                downloadManager:startDownload(event.product)
            else
               -- onDownloadComplete(event.product)
            end
        elseif (event.actionType == "restore") then
            -- restore
            --button.text.text="press to download"
            if model.URL then
                if not button.tap then
                    function button:tap (event)
                        local selectedPurchase = event.target.selectedPurchase
                           downloadManager:startDownload(selectedPurchase)
                            return true
                    end
                    button.downloadBtn:addEventListener("tap", button)
                end
            else
                -- onDownloadComplete(event.product)
            end
        end
    end
end

Runtime:addEventListener("command:purchaseCompleted", M.onPurchaseComplete)

return M