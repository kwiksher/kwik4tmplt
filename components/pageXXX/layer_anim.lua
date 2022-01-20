-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local _K = require "Application"
--
function _M:myMain()
end
--
function _M:localVars()
end
--
function _M:localPos()
end
---
parseValue = function(value, newValue)
	if newValue then
		if value then
			return newValue
		else
			return nil
		end
	else
		return value
	end
end
--
_M.ultimate = parseValue({{ultimate}})
---------------------------
_M.layerName = "{{gtName}}"
_M.layerWidth = {{elW}}
_M.layerHeight = {{elH}}
_M.randXStart = {{randXStart}}
_M.randXEnd   = {{randXEnd}}
_M.randYStart = {{randYStart}}
_M.randYEnd   = {{randYEnd}}
_M.nX         = {{nX}}
_M.nY         = {{nY}}
_M.layerX     = {{elX}}
_M.layerY     = {{elY}}
--
function _M:getLayer(UI)
	local layer = = UI.layer
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

local animationFunc = {}
local postionFunc = {}

_M.positionFuncName = parseValue(parseValue({{groupAndPage}}), "grpupAndPage") or "default"

if _M.animationType == "Path" then
	_M.pathAnimation = {
		{{pathCurve}} angle = {{gtAngle}}
	}
end
---------------------------
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
--
--
postionFunc["groupAndPage"] = function (layer, _endX, _endY, isSceneGroup)
	local mX, mY
	local endX, endY =  _K.ultimatePosition(_endX, _endY)
	local width, height = layer.width*layer.xScale, layer.height*layer.yScale

	if _M.referencePoint=="CenterReferencePoint" then
	  if isSceneGroup then
	      mX = endX + layer.x
	      mY = endY + layer.y
	  else
	      mX = endX + width/2
	      mY = endY + height/2
	  end
	end
	if _M.referencePoint=="TopLeftReferencePoint" then
        mX = endX + width/2
        mY = endY + height/2
	end
	if _M.referencePoint=="TopCenterReferencePoint" then
        mX = endX + width/2
        mY = endY + height/2
	end
	if _M.referencePoint=="TopRightReferencePoint" then
        mX = endX + width
        mY = endY + height
	end
	if _M.referencePoint=="CenterLeftReferencePoint" then
        mX = endX + width/2
        mY = endY + height/2
	end
	if _M.referencePoint=="CenterRightReferencePoint" then
        mX = endX + width
        mY = endY + height/2
	end
	if _M.referencePoint=="BottomLeftReferencePoint" then
        mX = endX + width
        mY = endY + height
	end
	if _M.referencePoint=="BottomRightReferencePoint" then
        mX = endX + width
        mY = endY + height
	end
	if _M.referencePoint=="BottomCenterReferencePoint" then
        mX = endX + width/2
        mY = endY + height
	end
	if _M.randXStart ~=nil then
		mX = _M.layerWidth + math.random(_M.randXStart, _M.randXEnd)
	end
	if _M.randYStart ~= nil then
		mY =  _M.layerHeight + math.random(_M.randYStart, _M.randYEnd)
	end
	return mX, mY
end
--
postionFunc["default"] = function (layer, _endX, _endY, isSceneGroup)
	local endX, endY =  _K.ultimatePosition(_endX, _endY)
	local width, height = layer.width*layer.xScale, layer.height*layer.yScale
	if _M.defaultReference then
		mX = endX + width/2
		mY = endY + height/2
	end
	if _M.textReference then
		mX = endX + _M.nX - _M.layerX
		mY = endY + _M.nY - _M.layerY -height*0.5
	end
	if _M.referencePoint == "TopLeftReferencePoint" then
		mX = endX
		mY = endY
	end
	if _M.referencePoint == "TopCenterReferencePoint" then
		mX = endX + width/2
		mY = endY
	end
	if _M.referencePoint == "TopRightReferencePoint" then
      mX = endX + width
      mY = endY
	end
	if _M.referencePoint == "CenterLeftReferencePoint" then
      mX = endX
      mY = endY + height/2
	end
	if _M.referencePoint == "CenterRightReferencePoint" then
      mX = endX + width
      mY = endY + height/2
	end
	if _M.referencePoint == "BottomLeftReferencePoint" then
      mX = endX
      mY = endY + height
	end
	if _M.referencePoint == "BottomRightReferencePoint" then
      mX = endX + width
      mY = endY + height
	end
	if _M.referencePoint == "BottomCenterReferencePoint" then
      mX = endX + width/2
      mY = endY + height
	end
	if _M.randXStart ~=nil then
		mX = _M.layerWidth + math.random(_M.randXStart, _M.randXEnd)
	end
	if _M.randYStart ~= nil then
		mY =  _M.layerHeight + math.random(_M.randYStart, _M.randYEnd)
	end
	return mX, mY
end

local getPos = positionFunc[_M.positionFuncName]

--
function _M:repoHeader(UI)
	local layer = self:getLayer(UI)
	if self.referencePoint == "TopLeftReferencePoint" then
		layer.anchorX = 0
		layer.anchorY = 0;
		_K.repositionAnchor(layer, 0,0)
	end
	if self.referencePoint == "TopCenterReferencePoint" then
		layer.anchorX = 0.5
		layer.anchorY = 0;
		_K.repositionAnchor(layer, 0.5,0)
	end
	if self.referencePoint == "TopRightReferencePoint" then
		layer.anchorX = 1
		layer.anchorY = 0;
		_K.repositionAnchor(layer, 1,0)
	end
	if self.referencePoint == "CenterLeftReferencePoint" then
		layer.anchorX = 0
		layer.anchorY = 0.5;
		_K.repositionAnchor(layer, 0,0.5)
	end
	if self.referencePoint == "CenterRightReferencePoint" then
		layer.anchorX = 1
		layer.anchorY = 0.5;
		_K.repositionAnchor(layer, 1,0.5)
	end
	if self.referencePoint == "BottomLeftReferencePoint" then
		layer.anchorX = 0
		layer.anchorY = 1;
		_K.repositionAnchor(layer, 0,1)
	end
	if self.referencePoint == "BottomRightReferencePoint" then
		layer.anchorX = 1
		layer.anchorY = 1;
		_K.repositionAnchor(layer, 1,1)
	end
	if self.referencePoint == "BottomCenterReferencePoint" then
		layer.anchorX = 0.5
		layer.anchorY = 1;
		_K.repositionAnchor(layer, 0.5,1)
	end
end
--
--
local function createOptions(self, UI)
	local onEndHandler = function()
		if self.restart then
			if self.animationSubType == "Shake" then
				layer.rotation = 0
			end
			if not self.isComic then
				layer.x				 = layer.oriX
				layer.y				 = layer.oriY
			end
			layer.alpha		 = layer.oldAlpha
			layer.rotation	= 0
			layer.isVisible = true
			layer.xScale		= layer.oriXs
			layer.yScale		= layer.oriYs

			if _M.isSpritesheet then
				layer:pause()
				layer.currentFrame = 1
			else if _M.isMovieClip then
				layer::stopAtFrame(1)
			end
		end
		if self.actionName:len() > 0  then
			Runtime:dispatchEvent({name=UI.page..self.actionName, event={}, UI=UI})
		end
		if sef.audioName:len() > 0 then
			audio.setVolume({self.audioVolume, { channel=self.audioChannel })
			if self.allowRepeat then
				audio.play(UI.allAudios[self.audioName], { channel=self.audioChannel, loops=self.audioLoop, fadein=self.audioFadeIn })
			else
				audio.play(UI.allAudios[self.audioName], { channel=self.audioChannel, loops=0, fadein=self.audioFadeIn })
			end
		end
	end

	local options = {
		ease        = _K.gtween.easing[self.animationEasing],
		repeatCount = self.animationLoop,
		reflect     = self.animationReverse,
		xSwipe      = self.animationSwipeX,
		ySwipe      = self.animationSwipeY,
		delay       = self.animationDelay,
		onComplete  = onEndHandler
	}
	if self.breadcrumb then
		options.breadcrumb = true
		options.breadAnchor = 5,
		options.breadShape = self.breadShape
		options.breadW =self.breadcrumWidth
		options.breadH = self.breadcrumHeight
		if self.breadcrumColor then
			options.breadColor = {self.breadcrumColor }
		else
			options.breadColor = {"rand"}
		end
		options.breadInterval = self.breadcrumbInterval
		if self.breadcrumbDispose then
			options.breadTimer = self.breadcrumbTime
		end
	end
	return options
end
--
local function getEndPosition(self, layer)
	if self.animationEndX then
		local mX, mY = getPos(layer, self.animationEndX, self.animationEndY, self.isSceneGroup)
		if self.isComic then
			local deltaX = layer.oriX -mX
			local deltaY = layer.oriY -mY
			mX, mY = display.contentCenterX - deltaX, display.contentCenterY - deltaY
		end
	end
	return mX, mY
end
--
local function createProps(self, layer)
	local props = {}
	if self.animationSubType == "Linear" then
		if self.animationSubType == "Pulse" then
			props.xScale = self.animationScaleX
			props.yScale = self.animationScaleY
		end
		if self.animationSubType == "Rotation" then
			props.rotation =  self.animationRotation
		end
		if self.animationSubType == "Shake" then
			props.rotation =  self.animationRotation
		end
		if self.animationSubType == "Bounce" then
			props.y=mY
		end
		if self.animationSubType == "Blink" then
			props.xScale =  self.animationScaleX
			props.yScale = self.animationScaleY,
		end
	else
		if self,animationEndX then
			props.x = mX
			props.y = mY
		end
		if self.animationEndAlpha then
			props.alpha=self.animationEndAlpha
		end
		if self.animationRotation then
			props.rotation = self.animationRotation
		end
		if self.animationScaleX then
			props.xScale=self.animationScaleX * layer.xScale
		end
		if self.animationScaleY then
			props.yScale=self.animationScaleY * layer.yScale
		end
		if self.animationNewAngle then
			props.newAngle = self.animationNewAngle
		end
	end
	return props
end

local function createAnimationFunc(self, UI)
	return function(self, UI)
		local layer = self:getLayer(UI)
		local sceneGroup = UI.scene.view
		--
		if layer == nil then return end
		--
		layer.xScale = layer.oriXs
		layer.yScale = layer.oriYs

		local restartHandler= function(event)
			if _K.gt[self.layerName] then
				_K.gt[self.layerName]:toBeginning()
			end
		end
		--
		local mX, mY = getEndPosition(self, layer)
		--
		local options = createOptions(self, UI)
		--
		local props = createProps(self, layer)
		---
		if self.animationType == "Default" then
			_K.gt[self.layerName] = _K.gtween.new( layer, self.animationDuration, props, options)
		else if self.animationType == "Path" then
			_K.gt[self.layerName] = _K.btween.new(
				layer,
				self.animationDuration,
				self.pathAnimation,
				options,
				props)

			_K.gt[self.layerName].pathAnim = true
		end
		--
		if not self.audioPlay then
			_K.gt[self.layerName]:pause()
		end
		-- _K.gt[self.layerName]:toBeginning()
		if self.isComic then
			layer.anim[self.layerName] = _K.gt[self.layerName]
		end
	end
end
--
animationFunc["Default"]  = createAnimationFunc(self, UI)
animationFunc["Path"]     = createAnimationFunc(self, UI)
animationFunc["Dissolve"] = function(self, UI)
	local layer = self:getLayer(UI)
	local sceneGroup = UI.scene.view
	--
	if layer == nil then return end
	--
	layer.xScale = layer.oriXs
	layer.yScale = layer.oriYs

	_K.trans[self.layerName] = {}
	_K.trans[self.layerName].play = function()
		transition.dissolve(layer, self:getDssolvedLayer(UI),	self.animationDuration, self.animationDelay}}) end
	_K.trans[self.layerName].pause = function()
		print("pause is not supported in dissove") end
	_K.trans[self.layerName].resume = function()
		transition.dissolve(layer, self:getDssolvedLayer(UI),	self.animationDuration, self.animationDelay) end
end
--
_M.buildAnim = animationFunc[_M.animationType]
--
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