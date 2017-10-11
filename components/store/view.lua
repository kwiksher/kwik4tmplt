local M = {}
--
local composer        = require("composer")
local model           = require("components.store.model")
local cmd          = require("components.store.command").new()
local _K              = require("Application")
--
---------------------------------------------------
--
function M.new()
    local VIEW = {}
    --
    VIEW.downloadGroup = {}
    VIEW.sceneGroup    = nil
    --
    --
    local function copyDisplayObject(src, dst, id, group)
        local obj = display.newImageRect( _K.imgDir..src.imagePath, _K.systemDir, src.width, src.height)
            obj.x = dst.x + src.x - _W/2
            obj.y = dst.y + src.y - _H/2
            src.alpha = 0
            obj.alpha = 0
            obj.selectedPurchase = id
            group:insert(obj)
        return obj
    end
    --
    --
    function VIEW:createThumbnail()
        print("--- VIEW create ---")
        for k, epsode in pairs( model.epsodes) do
            -- print(epsode.name)
            local button = self.layer[epsode.name.."Icon"]
            if button then
                button.selectedPurchase = epsode.name
                self.downloadGroup[epsode.name] = button
                --If the user has purchased the epsode before, change the button
                button.purchaseBtn = copyDisplayObject(self.layer.purchaseBtn, button, epsode.name, self.sceneGroup)
                if model.URL then
                    button.downloadBtn = copyDisplayObject(self.layer.downloadBtn, button, epsode.name, self.sceneGroup)
                    button.savingTxt   = copyDisplayObject(self.layer.savingTxt, button, epsode.name, self.sceneGroup)
                end
                button.savedBtn = copyDisplayObject(self.layer.savedBtn, button, epsode.name, self.sceneGroup)
                --
                -- button image
                --
                cmd:setButtonImage(button, epsode.name)
            end
        end
        --
    end
    --
    function VIEW:controlThumbnail()
        for k, epsode in pairs( model.epsodes) do
            -- print(epsode.name)
            local button = self.layer[epsode.name.."Icon"]
            if button then
                button:addEventListener("tap", function(e)
                    self.fsm:clickImage(epsode)
                    end)
            end
        end
        if self.layer.restoreBtn then
            self.layer.restoreBtn:addEventListener("tap", cmd.restore)
        end
       if self.layer.hideOverlayBtn then
              self.layer.hideOverlayBtn:addEventListener("tap", cmd.hideOverlay)
        end
    end
    ---
    function VIEW:createDialog(epsode, isPurchased)
        local _epsode = epsode
        local bookXXIcon = self.layer["bookXXIcon"]
        if bookXXIcon then
            bookXXIcon.selectedPurchase = _epsode
            self.downloadGroup[_epsode] = bookXXIcon
            --If the user has purchased the epsode before, change the bookXXIcon
            bookXXIcon.purchaseBtn = copyDisplayObject(self.layer.purchaseBtn, bookXXIcon, _epsode, self.sceneGroup)
            if model.URL then
                bookXXIcon.downloadBtn = copyDisplayObject(self.layer.downloadBtn, bookXXIcon, _epsode, self.sceneGroup)
                bookXXIcon.savingTxt   = copyDisplayObject(self.layer.savingTxt, bookXXIcon, _epsode, self.sceneGroup)
            end
            -- bookXXIcon.savedBtn = copyDisplayObject(self.layer.savedBtn, bookXXIcon, _epsode, self.sceneGroup)
            --
            -- bookXXIcon image
            --
            cmd:setButtonImage(bookXXIcon, _epsode.name)
            --
        end
    end
    --
    function VIEW:controlDialog(epsode, isPurchased)
        local _epsode = epsode
        local bookXXIcon = self.layer["bookXXIcon"]
        if bookXXIcon then
            if isPurchased then
                if cmd.hasDownloaded(_epsode.name) then
                    -- bookXXIcon.savedBtn:addEventListener("tap", function(e)
                    --     self.fsm:clickImage(_epsode)
                    --     end)
                    bookXXIcon:addEventListener("tap", function(e)
                        self.fsm:clickImage(_epsode)
                        end)
                    if model.URL then
                        -- bookXXIcon.savingTxt.alpha = 0
                    end
                    -- bookXXIcon.savedBtn.alpha = 1
                else
                    print(_epsode.name.."(saving)")
                    bookXXIcon.savingTxt.alpha = 1
                    Runtime:dispatchEvent({name = "cmd:purchaseCompleted", target = _epsode})
                end
            else
                print(_epsode.name.."(not purchased)")
                --Otherwise add a tap listener to the bookXXIcon that unlocks the epsode
                bookXXIcon.purchaseBtn.alpha = 1
                bookXXIcon.purchaseBtn:addEventListener("tap", function() self.fsm:clickPurchase(_epsode) end)
            end
        end
        --
        if self.layer.hideOverlayBtn then
            -- composer.hideOverlay("fade", 400 )
            self.layer.hideOverlayBtn.tap = function(e)
                    self.fsm:clickCloseDialog()
                end
            self.layer.hideOverlayBtn:addEventListener("tap", self.layer.hideOverlayBtn)
        end
        if self.layer.infoTxt then
            self.layer.infoTxt.text = model.epsodes[_epsode.name].info
        end
    end
    --
    --
    function VIEW.purchaseAlert()
        native.showAlert("Info", model.purchaseAlertMessage, {"Okay"})
    end
    --
    --Tell the user their items are being restore
    function VIEW.restoreAlert()
        native.showAlert("Restore", model.restoreAlertMessage, {"Okay"})
    end
    --
    function VIEW.updateDialog(selectedPurchase)
       local button = VIEW.downloadGroup[selectedPurchase]
       local _epsode = selectedPurchase
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
            button:addEventListener("tap", self.fsm:clickImage(_epsode))
        end
    end
    --
    function VIEW.onDownloadError (selectedPurchase, message)
        -- CMD.downloadGroup[selectedPurchase].text.text="download error"
        native.showAlert("Failed", model.downloadErrorMessage, {"Okay"})
    end
    --
    function VIEW:destroy()
        for k, epsode in pairs( model.epsodes) do
            local button = self.layer[epsode.name.."Icon"]
            if button then
                button.purchaseBtn:removeEventListener("tap", cmd.buyBook)
                button:removeEventListener("tap", cmd.showOverlay)
                button.savedBtn:removeEventListener("tap", cmd.gotoScene)
                button:removeEventListener("tap", cmd.gotoScene)
             end
        end
      if self.layer.hideOverlayBtn then
        self.layer.hideOverlayBtn:removeEventListener("tap", cmd.hideOverlay)
      end
    end
    --
    function VIEW:refresh()
        cmd:init(self)
        for k, epsode in pairs( model.epsodes) do
            local button = self.layer[epsode.name.."Icon"]
            if button then
                print("-------- refresh ---------", self,  button)
                self.downloadGroup[epsode.name] = button
                button.purchaseBtn.alpha      = 0
                if model.URL then
                    button.downloadBtn.alpha      = 0
                    button.savingTxt.alpha        = 0
                    button.savedBtn.alpha         = 0
                end
                button.purchaseBtn:removeEventListener("tap", cmd.buyBook)
                button:removeEventListener("tap", cmd.showOverlay)
                button.savedBtn:removeEventListener("tap", cmd.gotoScene)
                button:removeEventListener("tap", cmd.gotoScene)

                self:addEventListener(button, epsode)
                --
             end
        end
    end


    function VIEW:init(group, layer, fsm)
        self.sceneGroup = group
        self.layer      = layer
        self.fsm        = fsm
        cmd:init(self)
    end
    --
    return VIEW
end

return M