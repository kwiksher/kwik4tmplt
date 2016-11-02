-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
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
	  store.purchase(product)
	else
	  native.showAlert("Store purchases are not available, please try again later",  { "OK" } )
	end
end
--
return _M