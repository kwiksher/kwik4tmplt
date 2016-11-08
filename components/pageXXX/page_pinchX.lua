-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
function _M:pPinchPag(pag)
  sceneGroup.anchorX = 0.5
  sceneGroup.anchorY = 0.5
  MultiTouch.activate( sceneGroup, "move", {"single"} )
  MultiTouch.activate( sceneGroup, "scale", {"multi"}, { minScale=1.0, maxScale=2.0 } )
  _M.pinchHandler = function (event)
     if (sceneGroup.xScale == 1 ) then
        sceneGroup.x = display.contentWidth / 2
        sceneGroup.y = display.contentHeight / 2;
     end
     return true
  end
  sceneGroup:addEventListener(MultiTouch.MULTITOUCH_EVENT, _M.pinchHandler)
end
--
function _M:dsipose()
  sceneGroup:removeEventListener( MultiTouch.MULTITOUCH_EVENT, _M.pinchHandler );
    --Gesture.deactivate(sceneGroup)
end
--
function _M:destroy()
end
--
return _M