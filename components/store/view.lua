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
    VIEW.versionGroup  = {}
    VIEW.sceneGroup    = nil
    VIEW.epsode        = nil
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
            obj.fsm = VIEW.fsm
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
                button.epsode = epsode
                function button:tap(e)
                    self.fsm:clickImage(self.epsode)
                end
                button:addEventListener("tap", button)
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
        self.epsode = epsode
        local bookXXIcon = self.layer["bookXXIcon"]
        if bookXXIcon then
            self.downloadGroup[epsode] = bookXXIcon
            bookXXIcon.versions = {}
            bookXXIcon.selectedPurchase = epsode
            --If the user has purchased the epsode before, change the bookXXIcon
            bookXXIcon.purchaseBtn = copyDisplayObject(self.layer.purchaseBtn, bookXXIcon, epsode, self.sceneGroup)
            if model.URL then
                if epsode.versions == nil or #epsode.versions == 0 then
                    bookXXIcon.downloadBtn = copyDisplayObject(self.layer.downloadBtn, bookXXIcon, epsode, self.sceneGroup)
                    bookXXIcon.savingTxt   = copyDisplayObject(self.layer.savingTxt, bookXXIcon, epsode, self.sceneGroup)
                end
            end
            -- bookXXIcon.savedBtn = copyDisplayObject(self.layer.savedBtn, bookXXIcon, self.epsode, self.sceneGroup)
            --
            -- bookXXIcon image then
            --
            cmd:setButtonImage(bookXXIcon, epsode.name)
            --
            if epsode.versions then
                for i=1, #epsode.versions do
                    if self.layer["version0"..i] and string.len(epsode.versions[i]) > 1 then
                        local versionBtn = copyDisplayObject(self,layer["version0"..i], bookXXIcon, epsode.name..self.epsode.versions[i], epsode.name..epsode.versions[i])
                        versionBtn.selectedPurchase = epsode.name
                        versionBtn.selectedVersion  = epsode.versions[i]
                        table.insert(bookXXIcon.versions, versionBtn)
                        self.versionGroup[epsode.name..epsode.versions[i]]  =  versionBtn
                    end
                end
            end
        end
    end
    --
    function VIEW:controlDialog(epsode, isPurchased)
        local bookXXIcon = self.layer["bookXXIcon"]
        if bookXXIcon then
            if isPurchased then
                print(epsode.name.."(purchased)")
                if #bookXXIcon.versions == 0 then
                    if cmd.hasDownloaded(epsode.name) then
                        -- bookXXIcon.savedBtn:addEventListener("tap", function(e)
                        --     self.fsm:clickImage(_epsode)
                        --     end)
                        function bookXXIcon:tap(e)
                            self.fsm:clickImage(self.selectedPurchase)
                        end
                        bookXXIcon:addEventListener("tap", bookXXIcon)
                        if model.URL then
                            -- bookXXIcon.savingTxt.alpha = 0
                        end
                        -- bookXXIcon.savedBtn.alpha = 1
                    else
                        print(epsode.name.."(saving)")
                        bookXXIcon.savingTxt.alpha = 1
                        Runtime:dispatchEvent({name = "cmd:purchaseCompleted", target = epsode})
                    end
                else
                -----------------
                -- version
                    for i=1, #bookXXIcon.versions do
                        local versionBtn = bookXXIcon.versions[i]
                        if versionBtn then
                            if cmd.hasDownloaded(versionBtn.selectedPurchase, versionBtn.selectedVersion) then
                                print(versionBtn.selectedVersion .."(saved)")
                                function versionBtn:tap(e)
                                    --self.gotoScene
                                    self.fsm:clickImage(self.selectedPurchase, self.selectedVersion)
                                end
                                versionBtn:addEventListener("tap", versionBtn)
                            else
                                print(versionBtn.selectedVersion.."(not saved)")
                                -- Runtime:dispatchEvent({name = "downloadManager:purchaseCompleted", target = _epsode.versions[i]})
                                function versionBtn:tap(e)
                                    --self.cmd.startDownloadVersion
                                    self.fsm:clickImage(self.selectedPurchase, self.selectedVersion)
                                end
                                versionBtn:addEventListener("tap", versionBtn)
                            end
                        end
                    end
                end
            else
                print(epsode.name.."(not purchased)")
                --Otherwise add a tap listener to the bookXXIcon that unlocks the epsode
                bookXXIcon.purchaseBtn.alpha = 1
                function bookXXIcon.purchaseBtn:tap(e)
                    self.fsm:clickPurchase(self.selectedPurchase)
                end
                bookXXIcon.purchaseBtn:addEventListener("tap", bookXXIcon.purchaseBtn)
                --Otherwise add a tap listener to the button that unlocks the epsode
                -----------
                --
                for i=1, #bookXXIcon.versions do
                    local versionBtn = bookXXIcon.versions[i]
                    if versionBtn then
                        function versionBtn:tap(e)
                            --self.cmd.startDownloadVersion
                            self.fsm:clickPurchase(self.selectedPurchase)
                        end
                        versionBtn:addEventListener("tap", versionBtn)
                    end
                end
            end
        end
        --
        if self.layer.hideOverlayBtn then
            -- composer.hideOverlay("fade", 400 )
            function self.layer.hideOverlayBtn:tap (e)
                    self.fsm:clickCloseDialog()
                end
            self.layer.hideOverlayBtn:addEventListener("tap", self.layer.hideOverlayBtn)
        end
        if self.layer.infoTxt then
            self.layer.infoTxt.text = model.epsodes[epsode.name].info
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
       --self.epsode  = selectedPurchase
        print("VIEW.updateDialog download is completed!")
        -- button.text.text=selectedPurchase.."(saved)"
        if button then
            if model.URL then
                button.savingTxt.alpha = 0
                button.savedBtn.alpha = 1
                button.downloadBtn.alpha = 0
            end
            if button.tap then
                button.downloadBtn:removeEventListener("tap", button)
            end
            function button:tap(e)
                self.fsm:clickImage(self.selectedPurchase)
            end
            button:addEventListener("tap", button)
        else
            -- not found. It means it is a version button
            local versionBtn = self.versionGroup[selectedPurchase]
            if versionBtn then
                if versionBtn.tap then
                    versionBtn:removeEventListener("tap", versionBtn)
                end
                function versionBtn:tap(e)
                    self.fsm:clickImage(self.selectedPurchase, self.selectedVersion)
                end
                versionBtn:addEventListener("tap", versionBtn)
                -- versionBtn.selectedPurchase = selectedPurchase -- chaning from book01 to book01v01
                -- versionBtn:addEventListener("tap", CMD.gotoScene)
                self.versionGroup[selectedPurchase] = nil
            end
        end
    end
    --
    function VIEW.onDownloadError (selectedPurchase, message)
        -- CMD.downloadGroup[selectedPurchase].text.text="download error"
        native.showAlert("Failed", model.downloadErrorMessage, {"Okay"})
    end
    --
    function VIEW:destroyThumbnail()
        for k, epsode in pairs( model.epsodes) do
            local button = self.layer[epsode.name.."Icon"]
            if button then
                button.purchaseBtn:removeEventListener("tap", button.purchaseBtn)
                button:removeEventListener("tap", cmd.showOverlay)
                button.savedBtn:removeEventListener("tap", cmd.gotoScene)
                button:removeEventListener("tap", cmd.gotoScene)
             end
        end
      if self.layer.hideOverlayBtn then
        self.layer.hideOverlayBtn:removeEventListener("tap", cmd.hideOverlay)
      end
      if self.layer.restoreBtn then
            self.layer.restoreBtn:removeEventListener("tap", cmd.restore)
      end
    end
------
    function VIEW:destroyDialog()
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