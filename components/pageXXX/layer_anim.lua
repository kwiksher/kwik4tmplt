-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
--
local _K = require "Application"
local _M = require("components.kwik.layer_animation").new()
---
--
_M.ultimate = parseValue({{ultimate}})
_M.isComic  = parseValue({{isComic}})
---------------------------
_M.layerName = "{{gtName}}"
_M.layerWidth = {{elW}}
_M.layerHeight = {{elH}}
_M.randXStart = parseValue({{randXStart}})
_M.randXEnd   = parseValue({{randXEnd}})
_M.randYStart = parseValue({{randYStart}})
_M.randYEnd   = parseValue({{randYEnd}})
_M.nX         = {{nX}}
_M.nY         = {{nY}}
_M.layerX     = {{elX}}
_M.layerY     = {{elY}}
--
function _M:getLayer(UI)
	local layer = UI.layer
	return {{gtLayer}}
end
--
function _M:getDssolvedLayer(UI)
	local layer = UI.layer
	return layer.{{gtDissolve}}
end
--
_M.restart = parseValue({{gtRestart}})
--
_M.actionName = "{{gtAction}}"
--
_M.animationEndX     = parseValue({{endX}})
_M.animationEndY     = parseValue({{endY}})
_M.animationEndAlpha = parseValue({{gtEndAlpha}})
_M.animationDuration = parseValue({{gtDur}})
_M.animationScaleY   = parseValue({{scalH}})
_M.animationScaleX   = parseValue({{scalW}})
_M.animationRotation = parseValue({{rotation}})
_M.animationEasing   = parseValue({{gtEase}})
_M.animationReverse  = parseValue({{gtReverse}})
_M.animationSwipeX   = parseValue({{gtSwipeX}})
_M.animationSwipeY   = parseValue({{gtSwipeY}})
_M.animationDelay    = parseValue({{gtDelay}})
_M.animationLoop     = parseValue({{gtLoop}})
_M.animationNewAngle = parseValue({{gtNewAngle}})
--
_M.isSceneGroup = parseValue({{isSceneGroup}})
--
_M.audioVolume  = parseValue({{avol}})
_N.audioChannel = parseValue({{achannel}})
_M.audioName    = "{{gtAudio}}"
_M.audioLoop    = parseValue({{aloop}})
_M.audioFadeIn  = parseValue({{tofade}})
_M.allowRepeat  = parseValue({{allowRepeat}})
--
_M.breadcrumb = parseValue({{gtBread}})
if _M.breadcrumb then
	_M.breadcrumbDispose = parseValue({{gtbdispose}})
	_M.breadShape      = "{{gtbshape}}"
	_M.breadcrumbColor  = parseValue({{gtbcolor}})
	_M.breadcrumbInterval = parseValue({{gtbinter}})
	_M.breadcrumbTime     = parseValue({{gtbsec}})
	if _M.ultimate then
		_M.breadcrumWidth = parseValue({{gtbw}})/4
		_M.breadcrumHeight = parseValue({{gtbh}})/4
	else
		_M.breadcrumWidth = parseValue({{gtbw}})
		_M.breadcrumHeight = parseValue({{gtbh}})
	end
end
--

_M.referencePoint = parseValue(parseValue({{CenterReferencePoint}}), "CenterReferencePoint")
	or parseValue(parseValue({{TopLeftReferencePoint}}), "TopLeftReferencePoint")
	or parseValue(parseValue({{TopCenterReferencePoint}}), "TopCenterReferencePoint")
	or parseValue(parseValue({{TopRightReferencePoint}}), "TopRightReferencePoint")
	or parseValue(parseValue({{CenterLeftReferencePoint}}), "CenterLeftReferencePoint")
	or parseValue(parseValue({{CenterLeftReferencePoint}}), "CenterRightReferencePoint")
	or parseValue(parseValue({{BottomLeftReferencePoint}}), "BottomLeftReferencePoint")
	or parseValue(parseValue({{BottomRightReferencePoint}}), "BottomLeftReferencePoint")
	or parseValue(parseValue({{BottomCenterReferencePoint}}), "BottomRightReferencePoint")

_M.defaultReference = parseValue({{DefaultReference}})
_M.textReference  = parseValue({{TextReference}})

_M.animationType = parseValue(parseValue({{gtDissolve}}), "Dissolve")
	or parseValue(parseValue({{gtTypePath}}), "Path")
    or "Default"

_M.animationSubType = parseValue(parseValue({{Linear}}), "Linear")
	or parseValue(parseValue({{Pulse}}), "Pulse")
	or parseValue(parseValue({{Rotation}}), "Rotation")
	or parseValue(parseValue({{Shake}}), "Shake")
	or parseValue(parseValue({{Bounce}}), "Bounce")
	or parseValue(parseValue({{Blink}}), "Blink")

_M.audioPlay     = parseValue({{aplay}})
_M.isTypeShape   = parseValue({{getTypeShake}})
_M.isSpritesheet = parseValue({{tabSS}})
_M.isMovieClip   = parseValue({{tabMC}})

if _M.animationType == "Path" then
	_M.pathAnimation = {
		{{pathCurve}} angle = {{gtAngle}}
	}
end

_M.positionFuncName = parseValue(parseValue({{groupAndPage}}), "grpupAndPage") or "default"

---------------------------
--
function _M:localVars()
end
--
function _M:localPos()
end
--
function _M:didShow(UI)
	-- UI.scene:dispatchEvent({name="{{myLName}}_{{layerType}}_{{triggerName}}", phase = "didShow", UI=UI})	}
	self:repoHeader(UI)
	self:buildAnim(UI)
	if self.audioPlay then
		if self.animationType == "Dissolve" then
			_K.trans[self.layerName]:play()
		else
			--	if _K.gt[self.layerName] then
			--		_K.gt[self.layerName]:play()
			--	end
		end
	end
end
--
function _M:toDispose()
	_K.cancelAllTweens()
	_K.cancelAllTransitions()
end
--
function _M:toDestory()
end
---
function _M:play(UI)
	if self.animationType =="Dissolve" then
		_K.trans[self.layerName]:play()
	else
		-- _K.gt[self.layerName]:toBeginning()
		_K.gt[self.layerName]:play()
	end
end
--
function _M:resume(UI)
	if self.animationType =="Dissolve" then
		_K.trans[self.layerName]:resume()
	else
		_K.gt[self.layerName]:play()
	end
end
--
return _M