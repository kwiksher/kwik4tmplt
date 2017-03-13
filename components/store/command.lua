local M = {}
--
local IAP             = require("components.store.IAP")
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")

function M.new ()
    local CMD = {}
    --
    CMD.downloadGroup = nil
    --
    local purchaseAlert = function()
        native.showAlert("Info", model.purchaseAlertMessage, {"Okay"})
    end
    --
    --Tell the user their items are being restore
    local restoreAlert = function()
        native.showAlert("Restore", model.restoreAlertMessage, {"Okay"})
    end
    --
    local download
    -- it will be called from the purchaseListener and the restoreListener functions
    local function onPurchaseComplete(event)
        local selectedPurchase = event.product
        local button = CMD.downloadGroup[selectedPurchase]
        print("onPurchaseComplete -- "..selectedPurchase)
        print(button.purchaseBtn)
        --
        if button then
            button.purchaseBtn:removeEventListener("tap", IAP.buyEpsode)
            button.purchaseBtn.alpha = 0
            --
            if (event.actionType == "purchase") then
                -- button.text.text="saving"
                button.savingTxt.alpha = 1
                downloadManager:startDownload(event.product)
            elseif (event.actionType == "restore") then
                -- restore
                --button.text.text="press to download"
                button.downloadBtn.alpha = 1
                button.savedBtn.alpha = 0
                if not button.downloadFunc then
                    button.downloadFunc = function(event)
                        local selectedPurchase = event.target.selectedPurchase
                           downloadManager:startDownload(selectedPurchase)
                                -- button.text.text="saving"
                                button.savingTxt.alpha = 1
                            return true
                    end
                    button.downloadBtn:addEventListener("tap", button.downloadFunc)
                end
            end
        end
    end
    --
    local function onDownloadComplete(selectedPurchase)
        local button = CMD.downloadGroup[selectedPurchase]
        -- button.text.text=selectedPurchase.."(saved)"
        if button then
            button.savingTxt.alpha = 0
            button.savedBtn.alpha = 1
            button.downloadBtn.alpha = 0
            if button.downloadFunc then
                button.downloadBtn:removeEventListener("tap", button.downloadFunc)
                button.downloadFunc = nil
            end
            button:addEventListener("tap",
                CMD.gotoScene)
        end
    end
    --
    local function onDownloadError(selectedPurchase, message)
        -- CMD.downloadGroup[selectedPurchase].text.text="download error"
        native.showAlert("Failed", model.downloadErrorMessage, {"Okay"})
    end

    function CMD:init(UI)
        self.downloadGroup = UI.downloadGroup
        self.gotoScene     = UI.gotoScene
    	IAP:init(model.catalogue, restoreAlert, purchaseAlert)
    	downloadManager:init(onDownloadComplete, onDownloadError)
        Runtime:addEventListener("command:purchaseCompleted", onPurchaseComplete)

    end
    -- Called when the scene's view does not exist:

    function CMD:startDownload()
        downloadManager:startDownload()
    end

    function CMD:dispose()
        print("CMD:dispose")
        Runtime:removeEventListener("command:purchaseCompleted", onPurchaseComplete)
    end

    return CMD
end
return M