local _Class       = {}

local model       = require("components.store.model")
local cmd         = require("components.store.command").new()
local downloadManager = require("components.store.downloadManager")
local IAP             = require("components.store.IAP")
local composer        = require("composer")

local _instance = nil

function _Class.getInstance()
    if _instance == nil then
    	local o = {}
    	o.fsm   = require("components.store.store_sm"):new{owner = o}
    	_instance = setmetatable( o,{__index = _Class} )
    end

    return _instance
end

function _Class:destroy()
  --cmd:dispose()
  --self.view:destroy()
end
------------------------------
--- INIT state
---
function _Class:initModel()
end
------------------------------
-- Downloading State
--
function _Class:startDownload(id)
    cmd:startDownload()
end

function _Class:unzip(id)
    -- obsolete
end

function _Class:queue(id)
end

------------------------------
-- Downloaded
--
function _Class:updateDialog(id)
    self.view:updateDialog(id)
end

------------------------------
-- ThumnailDisplayed state
--
function _Class:createThumbnail()
    print("== storeFSM createThumbnail ==")
    self.view:createThumbnail()
    self.view:controlThumbnail()
end

function _Class:destroyThumbnail()
    print("== storeFSM destoryThumbnail ==")
  cmd:dispose()
  self.view:destroyThumbnail()
end

function _Class:removeEventListener()
    Runtime:removeEventListener("hideOverlay", self.fsm.onClose)
end
------------------------------
-- DisplayingDialog state
--
function _Class:isBookPurchased(epsode)
    print("storeFSM isBookPurchased")
    self.epsode = epsode
    local isPurchased  = false
    if (IAP.getInventoryValue("unlock_"..epsode.name)==true) then
        if downloadManager.hasDownloaded(epsode.name) then
            print(epsode.name .."(saved)")
            isPurchased = true
        else
            print(epsode.name.."(saving)")
        end
    end
    local event = {target={epsode = epsode, selectedPurchase = epsode.name, isPurchased = isPurchased}}
    if cmd.showOverlay(event) then
    timer.performWithDelay(100, function ()
        self.fsm:createDialog(epsode, isPurchased)
    end)
    else
        print("---------- not overlay -------- ")
        if isPurchased then
            timer.performWithDelay(100, function ()
                self.fsm:onClose()
                self.fsm:gotoBook(epsode)
            end)
        else
            print("not purchased")
            timer.performWithDelay(100, function ()
                self.fsm:onClose()
            end)
        end
    end
    -- Runtime:addEventListener("hideOverlay", self.fsm.onClose)
end

------------------------------
-- BookPurchased/BookNotPurchased
--
function _Class:onCreateDialog(id, isPurchased)
    print("storeFSM onCreateDialog")
    self.view:createDialog(id, isPurchased)
    self.view:controlDialog(id, isPurchased)
    timer.performWithDelay(100, function()
        if isPurchased then
            self.fsm:showDialogPurchased()
        else
            self.fsm:showDialogNotPurchased()
        end
    end)
end

function _Class:destroyDialog()
    print("storeFSM destroyDialog")
    self.view:destroyDialog()
    composer.hideOverlay("fade", 400 )
end

function _Class:gotoScene(epsode)
    print("storeFSM gotoScene", epsode.name)
    local event = {target={epsode = epsode, selectedPurchase = epsode.name}}
     composer.hideOverlay("fade", 100 )
    timer.performWithDelay(100, function()
    cmd.gotoScene(event)
    end)
    -- Runtime:dispachEvent("hideOverlay")
end
------------------------------
-- IAPBadger
--

function _Class:purchase(id, fromDialog)
    print ("storeFSM purchase", id, fromDialog)
    self.fromDialog = fromDialog
    IAP.buyEpsode({target={selectedPurchase=id}})
end

function _Class:refreshDialog(isPurchased)
    print("refreshDialog")
end

function _Class:refreshThumbnail()
        print("storeFSM refreshThumbnail")
        self.view:refreshThumbnail()
end
------------------------------
-- BookDisplayed
--
function _Class:onEntryBookDisplayed()
end

function _Class:onExitBookDisplayed()
    -- addEventListner ("tap", self.fsm:showThumbnail() )
end

function _Class:exit()
    print("-------- exit ------------")
    self.fsm:exit()
end

------------------------------
--
--
function _Class.onDownloadComplete(selectedPurchase)
    local self = _Class.getInstance()
    self.fsm:onSuccess()
    if self.fromDialog then
        self.fsm:fromDialog(selectedPurchase)
        self.fromDialog = false
    else
        self.fsm:backThumbnail()
        self.fromThumbnail = false
    end
end

function _Class.onDownloadError(selectedPurchase, message)
    local self = _Class.getInstance()
    if self.fromDialog then
        self.fsm:fromDialog(selectedPurchase)
        self.fromDialog = false
    else
        self.fsm:backThumbnail()
        self.fromThumbnail = false
    end
    self.view.onDownloadError(selectedPurchase, message)
end
--
function _Class.purchaseListener()
    local self = _Class.getInstance()
    self.fsm:onPurchase()
end

function _Class.failedListener()
    local self = _Class.getInstance()
    print("page02", "failedListener", self.fromDialog)
    if self.fromDialog then
        self.fsm:onPurchaseCancel()
    else
        self.fsm:backThumbnail()
    end
end
--
function _Class:init (overlay, view)
    print("========= storeFSM init ===============")
    self.view = view
    --cmd:init(view)
    IAP:init(model.catalogue, view.restoreAlert,
        function()
            self.purchaseListener()
            view.purchaseAlert()
        end,
        self.failedListener,  model.debug)
    downloadManager:init(self.onDownloadComplete,self.onDownloadError)    --
    self.fsm:enterStartState()
    if ( system.getInfo("environment") == "simulator" )then
    self.fsm:setDebugFlag(true)
    end
    if overlay then
        if downloadManager.isDownloadQueue() then
            self.fromThumbnail = true
            self.fsm:onDownloadQueue()
        else
            self.fsm:showThumbnail()
        end
    else
       -- mydebug.print()
        if model.currentEpsode.isPurchased then
            self.fsm:showDialogPurchased()
        else
            self.fsm:showDialogNotPurchased()
        end
    end
end

function _Class:resume()
    print("storeFSM resume")
  self.view:refresh(true)
end

return _Class