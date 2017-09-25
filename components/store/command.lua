local M = {}
--
local IAP             = require("components.store.IAP")
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")

function M.new ()
    local CMD = {}
    print("commands.new", CMD)
    --
    CMD.downloadGroup = nil
    CMD.versionGroup  = nil
    CMD.buttons = {}
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
     --)

    function CMD.onDownloadComplete(selectedPurchase)
       local button = CMD.downloadGroup[selectedPurchase]
        print("CMD.onDownloadComplete",  CMD)
        -- button.text.text=selectedPurchase.."(saved)"
        if button then
            if model.URL then
                button.savingTxt.alpha = 0
                button.savedBtn.alpha = 1
                button.downloadBtn.alpha = 0
            end
            if button.downloadFunc then
                button.downloadBtn:removeEventListener("tap", button.downloadFunc)
                button.downloadFunc = nil
            end
            button.savedBtn.selectedPurchase = selectedPurchase
            button.savedBtn:addEventListener("tap",
                CMD.gotoScene)
            table.insert(CMD.buttons, button.savedBtn) -- removeEventListener at destroy
        else
            local versionBtn = CMD.versionGroup[selectedPurchase]
            if versionBtn then
                versionBtn:removeEventListener("tap", CMD.startDownloadVersion)
                versionBtn.selectedPurchase = selectedPurchase -- chaning from book01 to book01v01
                versionBtn:addEventListener("tap", CMD.gotoScene)
                CMD.versionGroup[selectedPurchase] = nil
                table.insert(CMD.buttons, versionBtn) -- - removeEventListener at destroy
            end
        end
    end

    -- it will be called from the purchaseListener and the restoreListener functions
    function CMD.onPurchaseComplete(event)
        local selectedPurchase = event.product
        local button = CMD.downloadGroup[selectedPurchase]
        print(selectedPurchase, button.purchaseBtn)
        --
        if button then
            button.purchaseBtn:removeEventListener("tap", IAP.buyEpsode)
            button.purchaseBtn.alpha = 0
            --
            if (event.actionType == "purchase") then
                -- button.text.text="saving"
                if model.URL then
                    button.downloadBtn.alpha = 1
                    -- downloadManager:startDownload(event.product)
                    button.downloadBtn.selectedPurchase = selectedPurchase
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
                else
                   self.onDownloadComplete(event.product)
                end
            elseif (event.actionType == "restore") then
                -- restore
                --button.text.text="press to download"
                if model.URL then
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
                else
                    self.onDownloadComplete(event.product)
                end
            end
        end
    end
    --
    local function onDownloadError(selectedPurchase, message)
        -- CMD.downloadGroup[selectedPurchase].text.text="download error"
        native.showAlert("Failed", model.downloadErrorMessage, {"Okay"})
    end

    function CMD:init(UI)
        self.downloadGroup = {}
        self.versionGroup  = {}
        print("CMD:init ", UI)
        UI.cmd = self
        self.gotoScene     = UI.gotoScene
    	IAP:init(model.catalogue, restoreAlert, purchaseAlert)
    	downloadManager:init(self.onDownloadComplete, onDownloadError)
        Runtime:addEventListener("command:purchaseCompleted", self.onPurchaseComplete)

    end
    -- Called when the scene's view does not exist:

    function CMD:startDownload()
        downloadManager:startDownload()
    end

    function CMD.startDownloadVersion(e)
            local selectedPurchase = e.target.selectedPurchase
            local selectedVersion  = e.target.selectedVersion
            if (IAP.getInventoryValue("unlock_"..selectedPurchase)==true) then
                print("start download version1")
                CMD.versionGroup[selectedPurchase..selectedVersion] = e.target
                downloadManager:startDownload(selectedPurchase..selectedVersion)
            else
                print("not purchased yet")
            end
            return true
    end

    function CMD:dispose()
        print("------------------CMD:dispose")
        Runtime:removeEventListener("command:purchaseCompleted", self.onPurchaseComplete)
        for i=1, #CMD.buttons do
            CMD.buttons[i]:removeEventListener("tap", CMD.gotoScene)
        end
        CMD.buttons = {}
    end

    return CMD
end
return M