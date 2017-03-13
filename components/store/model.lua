local M = {}
--
local IAP             = require("components.store.IAP")
--
M.epsodes = {
    {{#body}}
        {{product}}  ={name = "{{product}}", dir = "assets/images/p{{page}}", numOfPages = {{numOfPages}}, info = "p{{info}}"},
    {{/body}}
}

M.catalogue = {
    products = {
    {{#body}}
        {{product}} = {
            productNames = { apple="{{product}}_apple", google="{{product}}_googgle", amazon="{{product}}_amazon"},
            productType  = "non-consumable",
            onPurchase   = function() IAP.setInventoryValue("unlock_{{product}}") end,
            onRefund     = function() IAP.removeFromInventory("unlock_{{product}}") end,
        },
    {{/body}}
    },
    inventoryItems = {
    {{#body}}
        unlock_{{product}} = { productType="non-consumable" },
    {{/body}}
    }
}

M.purchaseAlertMessage = "Your purchase was successful"
M.restoreAlertMessage  = "Your items are being restored"
M.downloadErrorMessage = "Check network alive to download the content"

M.gotoSceneEffect   = "slideRight"
M.showOverlayEffect = "slideBottom"

M.getPageNum = function(epsode)
    local pNum = M.epsodes[epsode].dir
    pNum = pNum:sub(16)
    return pNum
end

M.getPageName = function (epsode)
    local pNum = M.epsodes[epsode].dir
    pNum = pNum:sub(16)
    return "views.page0"..pNum.."Scene"
end

M.getPageInfo = function (epsode)
    local pNum = M.epsodes[epsode].info
    if string.len(pNum) > 0 then
        pNum = pNum:sub(2)
        return "views.page0"..pNum.."Scene"
    else
        return false
    end
end

return M