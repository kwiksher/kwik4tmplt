-- ex: set ro:
-- DO NOT EDIT.
-- generated by smc (http://smc.sourceforge.net/)
-- from file : store.sm

local error = error
local pcall = pcall
local strformat = require 'string'.format

local statemap = require 'extlib.statemap'

local _ENV = nil

local StoreManagerState = statemap.State.class()

local function _empty ()
end
StoreManagerState.Entry = _empty
StoreManagerState.Exit = _empty

local function _default (self, fsm)
    self:Default(fsm)
end
StoreManagerState.backThumbnail = _default
StoreManagerState.clickCloseDialog = _default
StoreManagerState.clickImage = _default
StoreManagerState.clickImage = _default
StoreManagerState.clickImage = _default
StoreManagerState.clickPurchase = _default
StoreManagerState.createDialog = _default
StoreManagerState.exit = _default
StoreManagerState.fromDialog = _default
StoreManagerState.gotoBook = _default
StoreManagerState.onClose = _default
StoreManagerState.onDownloadQueue = _default
StoreManagerState.onFailure = _default
StoreManagerState.onPurchaseCancel = _default
StoreManagerState.onRestore = _default
StoreManagerState.onSuccess = _default
StoreManagerState.showDialogNotPurchased = _default
StoreManagerState.showDialogPurchased = _default
StoreManagerState.showThumbnail = _default
StoreManagerState.startDownload = _default
StoreManagerState.startDownload = _default
StoreManagerState.updateDialog = _default

function StoreManagerState:Default (fsm)
    local msg = strformat("Undefined Transition\nState: %s\nTransition: %s\n",
                          fsm:getState().name,
                          fsm.transition)
    error(msg)
end

local MainMap = {}
local DialogMap = {}
local NetworkMap = {}

MainMap.Default = StoreManagerState:new('MainMap.Default', -1)

MainMap.INIT = MainMap.Default:new('MainMap.INIT', 0)

function MainMap.INIT:Entry (fsm)
    local ctxt = fsm.owner
    ctxt:initModel()
end

function MainMap.INIT:onDownloadQueue (fsm)
    fsm:pushState(NetworkMap.Downloading)
    fsm:getState():Entry(fsm)
end

function MainMap.INIT:showThumbnail (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:createThumbnail()
        end
    )
    fsm:setState(MainMap.ThumbnailDisplayed)
    fsm:getState():Entry(fsm)
end

MainMap.ThumbnailDisplayed = MainMap.Default:new('MainMap.ThumbnailDisplayed', 1)

function MainMap.ThumbnailDisplayed:Entry (fsm)
    local ctxt = fsm.owner
    ctxt:removeEventListener()
end

function MainMap.ThumbnailDisplayed:backThumbnail (fsm)
end

function MainMap.ThumbnailDisplayed:clickImage (fsm, id)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:isBookPurchased(id)
        end
    )
    fsm:setState(MainMap.DisplayingDialog)
    fsm:getState():Entry(fsm)
end

function MainMap.ThumbnailDisplayed:clickPurchase (fsm, id, fromDialog)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:purchase(id, fromDialog)
        end
    )
    fsm:setState(endState)
    fsm:pushState(DialogMap.IAPBadger)
    fsm:getState():Entry(fsm)
end

function MainMap.ThumbnailDisplayed:gotoBook (fsm, id)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:gotoScene(id)
        end
    )
    fsm:setState(MainMap.BookDisplayed)
    fsm:getState():Entry(fsm)
end

function MainMap.ThumbnailDisplayed:showThumbnail (fsm)
end

MainMap.DisplayingDialog = MainMap.Default:new('MainMap.DisplayingDialog', 2)

function MainMap.DisplayingDialog:backThumbnail (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(MainMap.ThumbnailDisplayed)
    fsm:getState():Entry(fsm)
end

function MainMap.DisplayingDialog:createDialog (fsm, id, isPurchase, isDownloaded)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:onCreateDialog(id, isPurchase, isDownloaded)
        end
    )
    fsm:setState(endState)
    fsm:pushState(DialogMap.INIT)
    fsm:getState():Entry(fsm)
end

function MainMap.DisplayingDialog:exit (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(MainMap.BookDisplayed)
    fsm:getState():Entry(fsm)
end

function MainMap.DisplayingDialog:onClose (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(MainMap.ThumbnailDisplayed)
    fsm:getState():Entry(fsm)
end

MainMap.BookDisplayed = MainMap.Default:new('MainMap.BookDisplayed', 3)

function MainMap.BookDisplayed:Entry (fsm)
    local ctxt = fsm.owner
    ctxt:onEntryBookDisplayed()
end

function MainMap.BookDisplayed:Exit (fsm)
    local ctxt = fsm.owner
    ctxt:onExitBookDisplayed()
end

function MainMap.BookDisplayed:clickImage (fsm)
end

function MainMap.BookDisplayed:exit (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(MainMap.INIT)
    fsm:getState():Entry(fsm)
end

function MainMap.BookDisplayed:showThumbnail (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(MainMap.INIT)
    fsm:getState():Entry(fsm)
end

DialogMap.Default = StoreManagerState:new('DialogMap.Default', -1)

DialogMap.INIT = DialogMap.Default:new('DialogMap.INIT', 4)

function DialogMap.INIT:showDialogNotPurchased (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(DialogMap.BookNotPurchased)
    fsm:getState():Entry(fsm)
end

function DialogMap.INIT:showDialogPurchased (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(DialogMap.BookPurchased)
    fsm:getState():Entry(fsm)
end

DialogMap.BookPurchased = DialogMap.Default:new('DialogMap.BookPurchased', 5)

function DialogMap.BookPurchased:clickCloseDialog (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:destroyDialog()
        end
    )
    fsm:popState()
    fsm:onClose()
end

function DialogMap.BookPurchased:clickImage (fsm, id, version)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:gotoScene(id, version)
        end
    )
    fsm:popState()
    fsm:exit()
end

function DialogMap.BookPurchased:onRestore (fsm, id)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:startDownload(id)
        end
    )
    fsm:setState(endState)
    fsm:pushState(NetworkMap.Downloading)
    fsm:getState():Entry(fsm)
end

function DialogMap.BookPurchased:showDialogPurchased (fsm)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:refreshDialog(true)
        end
    )
    fsm:setState(endState)
end

function DialogMap.BookPurchased:startDownload (fsm, id, version)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:startDownload(id, version)
        end
    )
    fsm:setState(endState)
    fsm:pushState(NetworkMap.Downloading)
    fsm:getState():Entry(fsm)
end

function DialogMap.BookPurchased:updateDialog (fsm, id)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:refreshDialog(true)
        end
    )
    fsm:setState(endState)
end

DialogMap.BookNotPurchased = DialogMap.Default:new('DialogMap.BookNotPurchased', 6)

function DialogMap.BookNotPurchased:clickCloseDialog (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:destroyDialog()
        end
    )
    fsm:popState()
    fsm:onClose()
end

function DialogMap.BookNotPurchased:clickPurchase (fsm, id, fromDialog)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:purchase(id, fromDialog)
        end
    )
    fsm:setState(DialogMap.IAPBadger)
    fsm:getState():Entry(fsm)
end

function DialogMap.BookNotPurchased:showThumbnail (fsm)
end

DialogMap.IAPBadger = DialogMap.Default:new('DialogMap.IAPBadger', 7)

function DialogMap.IAPBadger:backThumbnail (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:refreshThumbnail()
        end
    )
    fsm:popState()
end

function DialogMap.IAPBadger:onPurchaseCancel (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:refreshDialog(false)
        end
    )
    fsm:setState(DialogMap.BookNotPurchased)
    fsm:getState():Entry(fsm)
end

function DialogMap.IAPBadger:showDialogNotPurchased (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(DialogMap.BookNotPurchased)
    fsm:getState():Entry(fsm)
end

function DialogMap.IAPBadger:showDialogPurchased (fsm)
    fsm:getState():Exit(fsm)
    fsm:setState(DialogMap.BookPurchased)
    fsm:getState():Entry(fsm)
end

function DialogMap.IAPBadger:showThumbnail (fsm)
end

function DialogMap.IAPBadger:startDownload (fsm)
    local ctxt = fsm.owner
    local endState = fsm:getState()
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:refreshDialog(true)
        end
    )
    fsm:setState(endState)
    fsm:pushState(NetworkMap.Downloading)
    fsm:getState():Entry(fsm)
end

NetworkMap.Default = StoreManagerState:new('NetworkMap.Default', -1)

NetworkMap.Downloading = NetworkMap.Default:new('NetworkMap.Downloading', 8)

function NetworkMap.Downloading:Entry (fsm)
    local ctxt = fsm.owner
    ctxt:startDownload()
end

function NetworkMap.Downloading:onFailure (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:queue(id)
        end
    )
    fsm:setState(NetworkMap.DownloadedError)
    fsm:getState():Entry(fsm)
end

function NetworkMap.Downloading:onSuccess (fsm)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:unzip()
        end
    )
    fsm:setState(NetworkMap.Downloaded)
    fsm:getState():Entry(fsm)
end

function NetworkMap.Downloading:showThumbnail (fsm)
end

function NetworkMap.Downloading:startDownload (fsm)
end

NetworkMap.Downloaded = NetworkMap.Default:new('NetworkMap.Downloaded', 9)

function NetworkMap.Downloaded:backThumbnail (fsm)
    fsm:getState():Exit(fsm)
    fsm:popState()
    fsm:backThumbnail()
end

function NetworkMap.Downloaded:fromDialog (fsm, id)
    local ctxt = fsm.owner
    fsm:getState():Exit(fsm)
    fsm:clearState()
    local r, msg = pcall(
        function ()
            ctxt:updateDialog(id)
        end
    )
    fsm:popState()
    fsm:showDialogPurchased()
end

NetworkMap.DownloadedError = NetworkMap.Default:new('NetworkMap.DownloadedError', 10)

function NetworkMap.DownloadedError:backThumbnail (fsm)
    fsm:getState():Exit(fsm)
    fsm:popState()
    fsm:backThumbnail()
end

function NetworkMap.DownloadedError:fromDialog (fsm, id)
    fsm:getState():Exit(fsm)
    fsm:popState()
    fsm:showDialogNotPurchased()
end

local storeContext = statemap.FSMContext.class()

function storeContext:_init ()
    self:setState(MainMap.INIT)
end

function storeContext:backThumbnail ()
    self.transition = 'backThumbnail'
    self:getState():backThumbnail(self)
    self.transition = nil
end

function storeContext:clickCloseDialog ()
    self.transition = 'clickCloseDialog'
    self:getState():clickCloseDialog(self)
    self.transition = nil
end

function storeContext:clickImage ()
    self.transition = 'clickImage'
    self:getState():clickImage(self)
    self.transition = nil
end

function storeContext:clickImage (...)
    self.transition = 'clickImage'
    self:getState():clickImage(self, ...)
    self.transition = nil
end

function storeContext:clickImage (...)
    self.transition = 'clickImage'
    self:getState():clickImage(self, ...)
    self.transition = nil
end

function storeContext:clickPurchase (...)
    self.transition = 'clickPurchase'
    self:getState():clickPurchase(self, ...)
    self.transition = nil
end

function storeContext:createDialog (...)
    self.transition = 'createDialog'
    self:getState():createDialog(self, ...)
    self.transition = nil
end

function storeContext:exit ()
    self.transition = 'exit'
    self:getState():exit(self)
    self.transition = nil
end

function storeContext:fromDialog (...)
    self.transition = 'fromDialog'
    self:getState():fromDialog(self, ...)
    self.transition = nil
end

function storeContext:gotoBook (...)
    self.transition = 'gotoBook'
    self:getState():gotoBook(self, ...)
    self.transition = nil
end

function storeContext:onClose ()
    self.transition = 'onClose'
    self:getState():onClose(self)
    self.transition = nil
end

function storeContext:onDownloadQueue ()
    self.transition = 'onDownloadQueue'
    self:getState():onDownloadQueue(self)
    self.transition = nil
end

function storeContext:onFailure ()
    self.transition = 'onFailure'
    self:getState():onFailure(self)
    self.transition = nil
end

function storeContext:onPurchaseCancel ()
    self.transition = 'onPurchaseCancel'
    self:getState():onPurchaseCancel(self)
    self.transition = nil
end

function storeContext:onRestore (...)
    self.transition = 'onRestore'
    self:getState():onRestore(self, ...)
    self.transition = nil
end

function storeContext:onSuccess ()
    self.transition = 'onSuccess'
    self:getState():onSuccess(self)
    self.transition = nil
end

function storeContext:showDialogNotPurchased ()
    self.transition = 'showDialogNotPurchased'
    self:getState():showDialogNotPurchased(self)
    self.transition = nil
end

function storeContext:showDialogPurchased ()
    self.transition = 'showDialogPurchased'
    self:getState():showDialogPurchased(self)
    self.transition = nil
end

function storeContext:showThumbnail ()
    self.transition = 'showThumbnail'
    self:getState():showThumbnail(self)
    self.transition = nil
end

function storeContext:startDownload ()
    self.transition = 'startDownload'
    self:getState():startDownload(self)
    self.transition = nil
end

function storeContext:startDownload (...)
    self.transition = 'startDownload'
    self:getState():startDownload(self, ...)
    self.transition = nil
end

function storeContext:updateDialog (...)
    self.transition = 'updateDialog'
    self:getState():updateDialog(self, ...)
    self.transition = nil
end

function storeContext:enterStartState ()
    self:getState():Entry(self)
end

return
storeContext
-- Local variables:
--  buffer-read-only: t
-- End:
