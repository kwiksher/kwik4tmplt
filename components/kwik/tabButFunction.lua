-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _Class = {}
--
function _Class:createTabButFunction(UI, model)
   function model.obj:tap(event)
    event.UI = UI
    if model.obj.enabled or model.obj.enabled == nil then
      if model.btaps ~=nil and event.numTabs~=nil and 
       model.btaps > 1 and event.numTaps then
        if event.numTaps == model.btaps then
            UI.scene:dispatchEvent({name=model.eventName, tap = event})
        end
      else
            UI.scene:dispatchEvent({name=model.eventName, tap = event})
      end
    end
    return true
  end
  model.obj:addEventListener("tap", model.obj)
end
--
function _Class:removeTabButFunction(UI, model)
  self.UI = UI
  if model.obj then
  model.obj:removeEventListener("tap", model.obj)
  end
end
---------------------
---------------------
_Class.new = function(scene)
  local uiModel =  {}
  uiModel.scene = scene
  return  setmetatable( uiModel, {__index=_Class})
end
--
return _Class