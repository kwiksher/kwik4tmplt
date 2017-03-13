-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _Class = {}
--
function _Class:setMod(layer, custom)
  if custom then
    self.mod = require("custom.components."..self.page.."."..layer)
  else
    self.mod = require("components."..self.page.."."..layer)
  end
end
--
function _Class:_vars(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.localVars then
    self.mod:localVars(self)
  end
end
--
function _Class:_create(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.localPos then
    self.mod:localPos(self)
  end
end
--
function _Class:_didShow(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.allListeners then
    self.mod:allListeners(self)
  end
end
--
function _Class:_didHide(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.toDispose then
    self.mod:toDispose(self)
  end
end
--
function _Class:_destroy(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.toDestroy then
    self.mod:toDestroy(self)
  end
end
--
function _Class:_resume(type, layer, custom)
  self:setMod(layer, custom)
  if self.mod.resume then
    self.mod:resume(self)
  end
end
--
_Class.new = function()
  local layerUI = {}
	return setmetatable(layerUI, {__index=_Class})
end
--
return _Class