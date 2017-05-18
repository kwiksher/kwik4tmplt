local M = {}
--
local iap = require("components.store.iap_badger")
local spinner = require("components.store.spinner").new()
--
--Called when any purchase fails
local function failedListener()
    --If the spinner is on screen, remove it
    spinner:remove()
end
--
-- !!! Please edit salt and deugMode for device build !!!
--
function M:init(catalogue, restoreAlert, purchaseAlert)
    print("iap init")
    self.catalogue       = catalogue
    self.restoreAlert  = restoreAlert
    self.purchaseAlert = purchaseAlert

    local iapOptions = {
        catalogue         = catalogue,
        filename          = "epsodes_inventory.txt",
        --Salt for the hashing algorithm
        salt              = "something tr1cky to gue55!",
        failedListener    = failedListener,
        cancelledListener = failedListener,
        --Once the product has been purchased, it will remain in the inventory.  Uncomment the following line
        --to test the purchase functions again in future.  It's also useful for testing restore purchases.
        --doNotLoadInventory=true,
        debugMode        = true,
    }
    iap.init(iapOptions)
    print("iap init end")
end

---------------------------------
--
-- Making purchases
--
---------------------------------
--Called when the relevant app store has completed the purchase
local function purchaseListener( product )
    spinner:remove()
    Runtime:dispatchEvent({name = "command:purchaseCompleted", product = product, actionType = "purchase"})
    iap.saveInventory()
    M.purchaseAlert()
end
--Purchase function
--Most of the code in this function places a spinner on screen to prevent any further user interaction with
--the screen.  The actual code to initiate the purchase is the single line iap.purchase("removeAds"...)
--
function M.buyEpsode(event)
    local selectedPurchase = event.target.selectedPurchase
    spinner:show(iap.getStoreName())
    --Tell IAP to initiate a purchase
    iap.purchase(selectedPurchase, purchaseListener)
    return true
end
---------------------------------
--
-- Restoring purchases
--
---------------------------------
local function restoreListener(productName, event)
    --If this is the first product to be restored, remove the spinner
    --(Not really necessary in a one-product app, but I'll leave this as template
    --code for those of you writing apps with multi-products).
    if (event.firstRestoreCallback) then
        spinner:remove()
        M.restoreAlert()
    end
    --restore action
    if (productName) then
        Runtime:dispatchEvent({name = "command:purchaseCompleted", product = productName, actionType = "restore"})

    end
    --Save any inventory changes
    iap.saveInventory()
end

--Restore function
--Most of the code in this function places a spinner on screen to prevent any further user interaction with
--the screen.  The actual code to initiate the purchase is the single line iap.restore(false, ...)
function M.restorePurchases()
    spinner:show(iap.getStoreName())
    --Tell IAP to initiate a purchase
    --Use the failedListener from onPurchase, which just clears away the spinner from the screen.
    --You could have a separate function that tells the user "Unable to contact the app store" or
    --similar on a timeout.
    --On the simulator, or in debug mode, this function attempts to restore all of the non-consumable
    --items in the catalogue.
    iap.restore(false, restoreListener, failedListener)
    return true
end

function M.setInventoryValue(inventryItem)
    iap.setInventoryValue(inventryItem, true)
end

function M.removeInventoryValue(inventryItem)
    iap.removeInventoryValue(inventryItem, true)
end

function M.getInventoryValue(inventryItem)
    return iap.getInventoryValue(inventryItem)
end

return M