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
{{#isTmplt}}
  local ui = require("components.store.UI")
  ui.currentPage = curPage
{{/isTmplt}}
    if nil~= composer.getScene("views.page0"..(curPage+1).."Scene" ) then
    	composer.removeScene( "views.page0"..(curPage+1).."Scene"  , true)
    end
   composer.gotoScene( "views.page0"..(curPage+1).."Scene"  )
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
{{#bookshelf}}
local ui = require("components.store.UI")
local model = require("components.store.model")
--
function _M:gotoPage(pnum, ptrans, delay)
  {{#isTmplt}}
  ui.currentPage = pnum-1
  {{/isTmplt}}
  local myClosure_switch= function()
    if model.bookShelfType ==0 and model.tocPage == pnum then
        ui.gotoTOC(ptrans)
    else
      if nil~= composer.getScene("views.page0"..pnum.."Scene") then
          composer.removeScene("views.page0"..pnum.."Scene", true)
        end
      if ptrans and ptrans ~="" then
         composer.gotoScene( "views.page0"..pnum.."Scene", { effect = ptrans} )
      else
         composer.gotoScene( "views.page0"..pnum.."Scene" )
      end
    end
  end
  if delay > 0 then
    _K.timerStash.pageAction = timer.performWithDelay(delay, myClosure_switch, 1)
  else
    myClosure_switch()
  end
end
{{/bookshelf}}
{{^bookshelf}}
--
function _M:gotoPage(pnum, ptrans, delay)
  local myClosure_switch= function()
      if nil~= composer.getScene("views.page0"..pnum.."Scene") then
          composer.removeScene("views.page0"..pnum.."Scene", true)
        end
      if ptrans and ptrans ~="" then
         composer.gotoScene( "views.page0"..pnum.."Scene", { effect = ptrans} )
      else
         composer.gotoScene( "views.page0"..pnum.."Scene" )
      end
  end
  if delay > 0 then
    _K.timerStash.pageAction = timer.performWithDelay(delay, myClosure_switch, 1)
  else
    myClosure_switch()
  end
end
{{/bookshelf}}
--
return _M