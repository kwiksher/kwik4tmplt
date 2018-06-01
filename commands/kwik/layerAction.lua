-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--		obj:showHide("objB", false)
function _M:showHide(obj, hides, toggles, time, delay)
  local timer
   if delay > 0 or time > 0 then
     if toggles then
          if obj.alpha == 0 then
              timer = transition.to( obj, {alpha=obj.oldAlpha, time=time, delay=delay})
          else
              timer = transition.to( obj, {alpha=0, time=time, delay=delay})
          end
      else
          if hides then
            obj.oldAlpha = 1
                timer = transition.to( obj, {alpha=obj.oldAlpha, time=time, delay=delay})
                print("obj.oldAlpha", obj.oldAlpha)
                print("hides", obj.alpha)
          else
                timer = transition.to( obj, {alpha=0, time=time, delay=delay})
                print("not hides", obj.alpha)
          end
    end
  else
     if toggles then
          if obj.alpha == 0 then
              obj.alpha = obj.oldAlpha
          else
              obj.alpha = 0
          end
      else
          if hides then
            obj.oldAlpha = 1
            obj.alpha = 1
         else
              obj.alpha = 0
         end
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