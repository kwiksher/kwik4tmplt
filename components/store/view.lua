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
    VIEW.episode        = nil
    --
    --
    local function copyDisplayObject(src, dst, id, group)
        local obj = display.newImageRect( _K.imgDir..src.imagePath, _K.systemDir, src.width, src.height)
            if obj == nil then
                print("copyDisplay object fail", id)
            end
            if dst then
            obj.x = dst.x + src.x - _W/2
            obj.y = dst.y + src.y - _H/2
            else
                obj.x = src.x
                obj.y = src.y
            end
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
        for k, episode in pairs( model.episodes) do
            -- print(episode.name)
            local button = self.layer[episode.name.."Icon"]
            if button then
                button.selectedPurchase = episode.name
                self.downloadGroup[episode.name] = button
                --If the user has purchased the episode before, change the button
                button.purchaseBtn = copyDisplayObject(self.layer.purchaseBtn, button, episode.name, self.sceneGroup)
                if model.URL then
                    button.downloadBtn = copyDisplayObject(self.layer.downloadBtn, button, episode.name, self.sceneGroup)
                    button.savingTxt   = copyDisplayObject(self.layer.savingTxt, button, episode.name, self.sceneGroup)
                end
                button.savedBtn = copyDisplayObject(self.layer.savedBtn, button, episode.name, self.sceneGroup)
                if model.bookShelfType  == 0 then -- pages
                    if cmd.hasDownloaded(episode.name) then
                        button.savedBtn.alpha = 1
                    else
                    button.purchaseBtn.alpha = 1
                end
                end
                --
                -- button image
                --
                cmd:setButtonImage(button, episode.name)
            end
        end
        --
    end
    --
    function VIEW:controlThumbnail()
        for k, episode in pairs( model.episodes) do
            -- print(episode.name)
            local button = self.layer[episode.name.."Icon"]
            if button then
                button.episode = episode
                function button:tap(e)
                    VIEW.fsm:clickImage(self.episode)
                end
                button:addEventListener("tap", button)
                --
                if model.bookShelfType  == 0 then -- pages
                    function button.purchaseBtn:tap(e)
                        VIEW.fsm:clickPurchase(self.selectedPurchase, false)
                        --cmd.onPurchase(self.selectedPurchase)
                    end
                    function button.downloadBtn:tap(e)
                        --cmd.onDownload(self.selectedPurchase)
                    end
                    function button.savedBtn:tap(e)
                        VIEW.fsm:gotoBook(self.episode)
                    end
                    button.purchaseBtn.selectedPurchase = episode.name
                    button.downloadBtn.selectedPurchase = episode.name
                    button.savedBtn.selectedPurchase = episode.name
                    button.purchaseBtn.episode = episode
                    button.downloadBtn.episode = episode
                    button.savedBtn.episode = episode
                    button.purchaseBtn:addEventListener( "tap", button.purchaseBtn)
                    button.downloadBtn:addEventListener( "tap", button.downloadBtn)
                    button.savedBtn:addEventListener( "tap", button.savedBtn)
                end
            end
        end
        if self.layer.restoreBtn then
            self.layer.restoreBtn:addEventListener("tap", cmd.restore)
        end
       if self.layer.hideOverlayBtn then
              self.layer.hideOverlayBtn:addEventListener("tap", cmd.hideOverlay)
        end
    end
    --
    function VIEW:refreshThumbnail()
        print("VIEW refreshThumbnail")
        for k, episode in pairs( model.episodes) do
            local button = self.layer[episode.name.."Icon"]
            if button then
                button.purchaseBtn.alpha = 0
                button.downloadBtn = 0
                button.savedBtn.alpha = 0
                if cmd.hasDownloaded(episode.name) then
                    button.purchaseBtn.alpha = 0
                    button.downloadBtn = 0
                    button.savedBtn.alpha = 1
                else
                    button.purchaseBtn.alpha = 1
                    button.downloadBtn = 0
                    button.savedBtn.alpha = 0
                end
            end
        end
    end
    ---
    function VIEW:createDialog(episode, isPurchased, isDownloaded)
        self.episode = episode
        local bookXXIcon = self.layer["bookXXIcon"]
        if model.bookShelfType == 0 then
            bookXXIcon = self.layer[episode.name.."Icon"]
        end
        if bookXXIcon then
            self.downloadGroup[episode.name] = bookXXIcon
            bookXXIcon.versions = {}
            bookXXIcon.selectedPurchase = episode.name
            print("createDialog with", episode.name)
            --If the user has purchased the episode before, change the bookXXIcon
            bookXXIcon.purchaseBtn = copyDisplayObject(self.layer.purchaseBtn, nil, episode, self.sceneGroup)
            bookXXIcon.purchaseBtn.selectedPurchase = episode.name
            if model.URL then
                if episode.versions == nil or #episode.versions == 0 then
                    bookXXIcon.downloadBtn = copyDisplayObject(self.layer.downloadBtn, nil, episode, self.sceneGroup)
                    bookXXIcon.savingTxt   = copyDisplayObject(self.layer.savingTxt, nil, episode, self.sceneGroup)
                end
            end
            bookXXIcon.savedBtn = copyDisplayObject(self.layer.savedBtn, nil, self.episode, self.sceneGroup)
            --
            -- bookXXIcon image then
            --
            cmd:setButtonImage(bookXXIcon, episode.name)
            --
            if episode.versions then
                for i=1, #episode.versions do
                    if self.layer["version_"..episode.versions[i]] and string.len(episode.versions[i]) > 1 then
                        local versionBtn = copyDisplayObject(self.layer["version_"..episode.versions[i]], nil, episode.name..self.episode.versions[i], self.sceneGroup)
                        print(episode.versions[i])
                        versionBtn.alpha = 1
                        versionBtn.episode = episode
                        versionBtn.selectedPurchase = episode.name
                        versionBtn.selectedVersion  = episode.versions[i]
                        table.insert(bookXXIcon.versions, versionBtn)
                        self.versionGroup[episode.name..episode.versions[i]]  =  versionBtn
                    end
                end
            end
        end
    end
    --
    --
    local function setVersionButtons(bookXXIcon)
        for i=1, #bookXXIcon.versions do
            local versionBtn = bookXXIcon.versions[i]
            if versionBtn then
                if cmd.hasDownloaded(versionBtn.selectedPurchase, versionBtn.selectedVersion) then
                    print(versionBtn.selectedVersion .."(saved)")
                    function versionBtn:tap(e)
                        print("versionBtn tap for gotoScene")
                        --self.gotoScene
                        VIEW.fsm:clickImage(self.episode, self.selectedVersion)
                        return true
                    end
                    versionBtn:addEventListener("tap", versionBtn)
                else
                    print(versionBtn.selectedVersion.."(not saved)")
                    -- Runtime:dispatchEvent({name = "downloadManager:purchaseCompleted", target = _episode.versions[i]})
                    function versionBtn:tap(e)
                        print("versionBtn tap for download")
                        VIEW.fsm:startDownload(self.episode, self.selectedVersion)
                    end
                    versionBtn:addEventListener("tap", versionBtn)
                end
            else
                print("Error to find versionBtn")
            end
        end
     end
    --
    --
    function VIEW:controlDialog(episode, isPurchased, isDownloaded)
        local bookXXIcon = self.layer["bookXXIcon"]
        if model.bookShelfType == 0 then
            bookXXIcon = self.layer[episode.name.."Icon"]
        end
        if bookXXIcon then
            bookXXIcon.episode = episode
            if isPurchased then
                print(episode.name.."(purchased)")
                if bookXXIcon.versions ==nil or #bookXXIcon.versions == 0 then
                    if isDownloaded then
                        -- bookXXIcon.savedBtn:addEventListener("tap", function(e)
                        --     VIEW.fsm:clickImage(_episode)
                        --     end)
                        function bookXXIcon:tap(e)
                            VIEW.fsm:clickImage(self.episode)
                        end
                        bookXXIcon:addEventListener("tap", bookXXIcon)
                        if model.URL then
                            -- bookXXIcon.savingTxt.alpha = 0
                        end
                        -- bookXXIcon.savedBtn.alpha = 1
                    else
                        print(episode.name.."(saving)")
                        bookXXIcon.savingTxt.alpha = 1
                        Runtime:dispatchEvent({name = "cmd:purchaseCompleted", target = episode})
                    end
                else
                -----------------
                -- version
                    setVersionButtons(bookXXIcon)
                end
            else
                print(episode.name.."(not purchased)")
                --Otherwise add a tap listener to the bookXXIcon that unlocks the episode
                bookXXIcon.purchaseBtn.alpha = 1
                function bookXXIcon.purchaseBtn:tap(e)
                    print("tap purchaseBtn", self.selectedPurchase, e.target.selectedPurchase)
                    VIEW.fsm:clickPurchase(self.selectedPurchase, true)
                end
                bookXXIcon.purchaseBtn:addEventListener("tap", bookXXIcon.purchaseBtn)
                --Otherwise add a tap listener to the button that unlocks the episode
                -----------
                --
                if bookXXIcon.versions then
                for i=1, #bookXXIcon.versions do
                    local versionBtn = bookXXIcon.versions[i]
                    if versionBtn then
                        function versionBtn:tap(e)
                            --self.cmd.startDownloadVersion
                            VIEW.fsm:clickPurchase(self.selectedPurchase, true)
                        end
                        versionBtn:addEventListener("tap", versionBtn)
                    end
                end
            end
        end
        end
        --
        if self.layer.hideOverlayBtn then
            -- composer.hideOverlay("fade", 400 )
            function self.layer.hideOverlayBtn:tap (e)
                    VIEW.fsm:clickCloseDialog()
                end
            self.layer.hideOverlayBtn:addEventListener("tap", self.layer.hideOverlayBtn)
        end
        if self.layer.infoTxt then
            self.layer.infoTxt.text = model.episodes[episode.name].info
            self.layer.infoTxt.x = self.layer.infoTxt.oriX
            self.layer.infoTxt.y = self.layer.infoTxt.oriY
            self.layer.infoTxt.anchorX = 0
            self.layer.infoTxt.anchorY = 0.3

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
    function VIEW:updateDialog(selectedPurchase)
       local button = VIEW.downloadGroup[selectedPurchase]
       --self.episode  = selectedPurchase
        print("VIEW.updateDialog", selectedPurchase)
        -- button.text.text=selectedPurchase.."(saved)"
        if button and (#button.versions == 0) then
            if model.URL then
                button.savingTxt.alpha = 0
                button.savedBtn.alpha = 1
                button.downloadBtn.alpha = 0
                button.purchaseBtn.alpha = 0
            end
            if button.tap then
                button.downloadBtn:removeEventListener("tap", button)
            end
            function button:tap(e)
                VIEW.fsm:clickImage(self.episode)
            end
            button:addEventListener("tap", button)
        else
            if model.URL then
                if button.savingTxt then
                    button.savingTxt.alpha = 0
                end
                if button.savedBtn then
                    button.savedBtn.alpha = 1
                end
                if button.downloadBtn then
                    button.downloadBtn.alpha = 0
                end
                if button.purchaseBtn then
                    button.purchaseBtn.alpha = 0
                end
            end
            -- not found. It means it is a version button
            setVersionButtons(button)

            -- local versions = model.episodes[selectedPurchase].versions
            -- for k, v in pairs(versions) do print(k, v) end
            -- for i=1, #versions do
            --     local versionBtn = self.versionGroup[selectedPurchase..versions[i]]
            --     print(selectedPurchase..versions[i],versionBtn)
            --     if versionBtn then
            --         if versionBtn.tap then
            --                 print("removeEventListener")
            --             versionBtn:removeEventListener("tap", versionBtn)
            --         end
            --         function versionBtn:tap(e)
            --                 self.fsm:clickImage(self.episode, self.selectedVersion)
            --         end
            --         versionBtn:addEventListener("tap", versionBtn)
            --         self.versionGroup[selectedPurchase..versions[i]] = nil
            --     end
            -- end

        end
    end
    --
    function VIEW.onDownloadError (selectedPurchase, message)
        -- CMD.downloadGroup[selectedPurchase].text.text="download error"
        native.showAlert("Failed", model.downloadErrorMessage, {"Okay"})
    end
    --
    function VIEW:destroyThumbnail()
        print("VIEW:destroyThumbnail")
        for k, episode in pairs( model.episodes) do
            local button = self.layer[episode.name.."Icon"]
            if button then
                if button.purchaseBtn then
                button.purchaseBtn:removeEventListener("tap", button.purchaseBtn)
                end
                button:removeEventListener("tap", cmd.showOverlay)
                if button.savedBtn then
                button.savedBtn:removeEventListener("tap", cmd.gotoScene)
                end
                button:removeEventListener("tap", cmd.gotoScene)
             end
        end
      if self.layer.hideOverlayBtn then
        self.layer.hideOverlayBtn:removeEventListener("tap", cmd.hideOverlay)
      end
      if self.layer.restoreBtn then
            self.layer.restoreBtn:removeEventListener("tap", cmd.restore)
      end
        print("VIEW:destroyThumbnail", "exit")
    end
------
    function VIEW:destroyDialog()
    end
    --
    function VIEW:refresh()
        cmd:init(self)
        for k, episode in pairs( model.episodes) do
            local button = self.layer[episode.name.."Icon"]
            if button then
                print("-------- refresh ---------", self,  button)
                self.downloadGroup[episode.name] = button
                button.purchaseBtn.alpha      = 0
                if model.URL then
                    if button.savingTxt then
                        button.savingTxt.alpha = 0
                    end
                    if button.savedBtn then
                        button.savedBtn.alpha = 0
                    end
                    if button.downloadBtn then
                        button.downloadBtn.alpha = 0
                    end
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
        if model.URL then
            if layer.savingTxt then
                layer.savingTxt.alpha = 0
            end
            if layer.savedBtn then
                layer.savedBtn.alpha = 0
            end
            if layer.downloadBtn then
                layer.downloadBtn.alpha = 0
            end
        end
    end
    --
    return VIEW
end

return M