-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require("Application")
local composer = require("composer")
local Navigation = require("extlib.kNavi")
--
function _M:autoPlay(curPage)
  local ui = require("components.store.UI")
  ui.currentPage = curPage
    if nil~= composer.getScene(_K.appName.."views.page0"..(curPage+1).."Scene" ) then
    	composer.removeScene(_K.appName.. "views.page0"..(curPage+1).."Scene"  , true)
    end
   composer.gotoScene(_K.appName.. "views.page0"..(curPage+1).."Scene"  )
end
--
function _M:showHideNavigation()
  if (_K.kNavig.alpha == 0) then
     Navigation.show()
  else
     Navigation.hide()
  end
end
--
function _M:reloadPage(canvas)
	if canvas then
   _K.reloadCanvas = 0
	end
	composer.gotoScene("extlib.page_reload")
end
--
function _M:gotoPage(pnum, ptrans, delay)
  local ui = require("components.store.UI")
  ui.currentPage = pnum-1
  local myClosure_switch= function()
      if nil~= composer.getScene(_K.appName.."views.page0"..pnum.."Scene") then
      	composer.removeScene(_K.appName.."views.page0"..pnum.."Scene", true)
      end
		if ptrans and ptrans ~="" then
       composer.gotoScene(_K.appName.. "views.page0"..pnum.."Scene", { effect = ptrans} )
		else
       composer.gotoScene(_K.appName.. "views.page0"..pnum.."Scene" )
		end
  end
  _K.timerStash.pageAction = timer.performWithDelay(delay, myClosure_switch, 1)
end
--
return _M