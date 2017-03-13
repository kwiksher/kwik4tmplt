local M = {}
--
local composer        = require("composer")
local IAP             = require("components.store.IAP")
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")
local _K       = require("Application")
--

function M.new()
    local UI = {}
    --
    UI.downloadGroup = {}
    UI.sceneGroup    = nil
    --
    function UI.gotoScene(event)
        local epsode =  event.target.selectedPurchase
        composer.gotoScene(model.getPageName(epsode) , {effect=model.gotoSceneEffect})
        return true
    end
    --
    function UI.showOverlay(event)
        local epsode =  event.target.selectedPurchase
        local options = {
            isModal = true,
            effect = model.showOverlayEffect,
            time = 400,
            params = {}
        }
        local page = model.getPageInfo(epsode)
        if page then
            print(page)
            composer.showOverlay(page, options)
        end
        return true
    end
    --
    local function copyDisplayObject(src, dst)
        local obj = display.newImageRect( _K.imgDir..src.imagePath, src.width, src.height)
            obj.x = dst.x + src.x - _W/2
            obj.y = dst.y + src.y - _H/2
            src.alpha = 0
        return obj
    end
    --
    function UI:addEventListener(button, epsode)
        if (IAP.getInventoryValue("unlock_"..epsode.name)==true) then
            if downloadManager.hasDownloaded(epsode.name) then
                print(epsode.name .."(saved)")
                button.savedBtn:addEventListener("tap", self.gotoScene)
                button:addEventListener("tap", self.gotoScene)
                button.savingTxt.alpha = 0
                button.savedBtn.alpha = 1
            else
                print(epsode.name.."(saving)")
                button.savingTxt.alpha = 1
                Runtime:dispatchEvent({name = "downloadManager:purchaseCompleted", target = epsode.name})
            end
        else
            print(epsode.name.."(not purchased)")
            --Otherwise add a tap listener to the button that unlocks the epsode
            button.purchaseBtn.alpha = 1
            button.purchaseBtn:addEventListener("tap", IAP.buyEpsode)
            if self.overlay then
                button:addEventListener("tap", self.showOverlay)
            end
        end
    end

    --
    function UI:create()
        local layer = self.layer
        local overlay = self.overlay
        print("ui create")
        for k, epsode in pairs( model.epsodes) do
            -- print(epsode.name)
            local button = layer[epsode.name.."Icon"]
            if button then
                button.selectedPurchase = epsode.name
                --If the user has purchased the epsode before, change the button
                local purchaseBtn = copyDisplayObject(layer.purchaseBtn, button)
                purchaseBtn.alpha = 0
                purchaseBtn.selectedPurchase = epsode.name
                self.sceneGroup:insert(purchaseBtn)
                button.purchaseBtn = purchaseBtn
                print(purchaseBtn)

                local downloadBtn = copyDisplayObject(layer.downloadBtn, button)
                downloadBtn.alpha = 0
                downloadBtn.selectedPurchase = epsode.name
                self.sceneGroup:insert(downloadBtn)
                button.downloadBtn = downloadBtn

                local savingTxt = copyDisplayObject(layer.savingTxt, button)
                savingTxt.alpha = 0
                self.sceneGroup:insert(savingTxt)
                button.savingTxt = savingTxt

                local savedBtn = copyDisplayObject(layer.savedBtn, button)
                savedBtn.alpha = 0
                savedBtn.selectedPurchase = epsode.name
                self.sceneGroup:insert(savedBtn)
                button.savedBtn = savedBtn

                self:addEventListener(button, epsode)
                --
                self.downloadGroup[epsode.name] = button
             end
        end
        --
        if layer.restoreBtn then
            layer.restoreBtn:addEventListener("tap",
                function(event)
                    for k, epsode in pairs (model.epsodes) do
                        local button = layer[epsode.name.."Icon"]
                        button:removeEventListener("tap", self.gotoScene)
                        button.savedBtn:removeEventListener("tap", self.gotoScene)
                    end
                    IAP.restorePurchases(event)
                end)
        end

    end
    --
    function UI:refresh()
        print("-------- refresh ---------")
        for k, epsode in pairs( model.epsodes) do
            local button = self.layer[epsode.name.."Icon"]
            if button then
                button.purchaseBtn.alpha      = 0
                button.downloadBtn.alpha      = 0
                button.savingTxt.alpha        = 0
                button.savedBtn.alpha         = 0
                button.purchaseBtn:removeEventListener("tap", IAP.buyEpsode)
                button:removeEventListener("tap", self.showOverlay)
                button.savedBtn:removeEventListener("tap", self.gotoScene)
                button:removeEventListener("tap", self.gotoScene)

                self:addEventListener(button, epsode)
                --
             end
        end
    end
--[[
    --
    function UI:createBuyButton(epsode, x, y, width, height)
        --Create button background
        local buyBackground = display.newRect(0, 0, width, height)
        buyBackground.stroke = { 0.5, 0.5, 0.5 }
        buyBackground.strokeWidth = 2
        --Create "buy IAP" text object
        local buyText = display.newText(epsode, 0, 0, native.systemFont, 18)
        buyText:setFillColor(0,0,0)
        --Place objects into a group
        local button            = display.newGroup()
        button.text             = buyText
        button.selectedPurchase = epsode
        button.x = x
        button.y = y
        button:insert(buyBackground)
        button:insert(buyText)

        --If the user has purchased the epsode before, change the button
        if (IAP.getInventoryValue("unlock_"..epsode)==true) then
            if downloadManager.hasDownloaded(epsode) then
                buyText.text=epsode .."(saved)"
                button:addEventListener("tap", self.gotoScene)
            else
                buyText.text="saving"
                Runtime:dispatchEvent({name = "downloadManager:purchaseCompleted", target = epsode})
    		end
        else
            --Otherwise add a tap listener to the button that unlocks the epsode
            button:addEventListener("tap", IAP.buyEpsode)
        end
        --
         self.downloadGroup[epsode] = button
         self.sceneGroup:insert(button)
    end

    function UI:createRestoreButton()
    		--Draw "restore" button
    	--Create button background
    	local restoreBackground = display.newRect(_W/2, _H/2+100, 180, 50)
    	restoreBackground.stroke = { 0.5, 0.5, 0.5 }
    	restoreBackground.strokeWidth = 2
    	--Create "buy IAP" text object
    	local restoreText = display.newText("Restore purchases", restoreBackground.x, restoreBackground.y, native.systemFont, 18)
    	restoreText:setFillColor(0,0,0)
    	--Add event listener
    	restoreText:addEventListener("tap",
            function(event)
                self.downloadGroup[model.epsode02]:removeEventListener("tap", self.gotoScene)
                self.downloadGroup[model.epsode03]:removeEventListener("tap", self.gotoScene)
                IAP.restorePurchases(event)
            end)
    	local group = display.newGroup()
    	group:insert(restoreBackground)
    	group:insert(restoreText)
    	self.sceneGroup:insert(group)
    end
--]]

    function UI:init(group, layer, overlay)
        self.sceneGroup = group
        self.layer      = layer
        self.overlay    = overlay
    end
    --
    return UI
end

function M.hasDownloaded(epsode)
    IAP:init(model.catalogue, nil, nil)
    if (IAP.getInventoryValue("unlock_"..epsode)==true) then
        if downloadManager.hasDownloaded(epsode) then
            return true
        else
            return false
        end
    else
        return false
    end
end

return M