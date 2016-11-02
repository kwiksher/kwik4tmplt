-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--		obj:showHide("objB", false)
function _M:showHide(obj, hides, toggles, time, delay)
  local timer
   if toggles then
        if obj.alpha == 0 then
            timer = transition.to( obj, {alpha=obj.oldAlpha, time=time, delay=delay})
        else
            timer = transition.to( obj, {alpha=0, time=time, delay=delay})
        end
    else
        if hides then
              timer = transition.to( obj, {alpha=obj.oldAlpha, time=time, delay=delay})
        else
              timer = transition.to( obj, {alpha=0, time=time, delay=delay})
        end
  end
  return timer
end
--
function _M:frontBack(obj, front, target)
  if front then
    obj:toFront()
  else
    obj:toBack()
  end
end
return _M