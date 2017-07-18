local M = {}
--
local IAP             = require("components.store.IAP")
--
local YourHost  = "http://localhost:4000/tutorials/Kwik4"
M.URL           = YourHost.."/BookShelf/"
M.backgroundImg = "bg.png"
M.bookShelfType  = 1 --{pages = 0, embedded = 1, tmplt=2}

----------------------------------
-- M.URL = nil means simple IAP store without network download like Kwik3 IAP
-- downloadBtn, savingTxt won'T be used. You don't need to create them.
--
{{#BookPages}}
M.epsodes = {
    {{#body}}
        {{product}}  ={name = "{{product}}", dir = "assets/images/p{{page}}", numOfPages = {{numOfPages}}, info = "p{{info}}"},
    {{/body}}
}
{{/BookPages}}
{{^BookPages}}
M.epsodes = {
    {{#body}}
        {{product}}  ={name = "{{product}}", dir = "{{product}}", numOfPages = {{numOfPages}}, info = "{{info}}"},
    {{/body}}
}
{{/BookPages}}
--
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
--
M.purchaseAlertMessage = "Your purchase was successful"
M.restoreAlertMessage  = "Your items are being restored"
M.downloadErrorMessage = "Check network alive to download the content"
--
M.gotoSceneEffect   = "slideRight"
M.showOverlayEffect = "slideBottom"
--
M.getPageNum = function(epsode)
    local pNum = M.epsodes[epsode].dir
    pNum = pNum:sub(16)
    return pNum
end
--
--
local _K = require("Application")
--
--
M.getPageName = function (epsode)
    local pNum = M.epsodes[epsode].dir
    pNum = pNum:sub(16)
    return "views.page0"..pNum.."Scene"
end
--
--
M.getPageInfo = function (epsode)
    local pNum = M.epsodes[epsode].info
    if string.len(pNum) > 1 then
        pNum = pNum:sub(2)
        return "views.page0"..pNum.."Scene"
    else
        return false
    end
end
--
--
M.isIAP = function(pageNum)
    for k, v in pairs(M.epsodes) do
        local pNum = v.dir
        pNum = tonumber(pNum:sub(16))
        if pageNum >= pNum and pageNum <= pNum + v.numOfPages -1 then
            return v.name
        end
    end
    return false
end

return M