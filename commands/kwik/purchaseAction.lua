-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local store = require("store")

local _M = {}
--
function _M:restorePurchase()
	store.restore()
end
--
function _M:refoundPurchase()
 --Add code for refund
end
--
function _M:buyProduct(product)
	if store.canMakePurchases then
			local IAP = require("components.store.IAP")
			local event = {target={selectedPurchase=product}}
			IAP.buyEpsode(event)
	  -- store.purchase(product)
	else
	  native.showAlert("Alert", "Store purchases are not available, please try again later",  { "OK" } )
	end
end
--
return _M