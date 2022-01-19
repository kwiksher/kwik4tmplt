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
function _M:localVars ()
end
--
function _M:localPos()
end
---------------------------
_M.layerName = "{{gtName}}"
_M.layerWidth = {{elW}}
_M.layerHeight = {{elH}}
_M.randXStart = {{randXStart}}
_M.randXEnd   = {{randXEnd}})
_M.randYStart = {{randYStart}}
_M.randYEnd   = {{randYEnd}})
_M.nX         = {{nX}}
_M.nY         = {{nY}}
_M.layerX     = {{elX}}
_M.layerY     = {{elY}}
--function M:getLayer(UI)
	local layer = = UI.layer
	return {{gtLayer}}
end
--
function _M:getDssolvedLayer(UI)
	local layer = UI.layer
	return layer.{{gtDissolve}}
end
--
_M.restart = {{gtRestart}}
--
_M.actionName = ".action_{{gtAction}}"
--
_M.animationEndX = {{endX}}
_M.animationEndY = {{endY}}
_M.animationEndAlpha = {{gtEndAlpha}}
_M.animationDuration = {{gtDur}}
_M.animationScaleY = {{scalH}}
_M.animationScaleX  = {{scalW}}
_M.animationRotation = {{rotation}}
_M.animationEasing   = {{gtEase}}
_M.animationReverse  = {{gtReverse}}
_M.animationSwipeX   = {{gtSwipeX}}
_M.animationSwipeY   = {{gtSwipeY}}
_M.animationDelay   = {{gtDelay}}
_M.animationLoop   = {{gtLoop}}
_M.animationNewAngle = {{gtNewAngle}}
--
_M.isSceneGroup  = {{isSceneGroup}}
--
_M.audioVolume = {{avol}}
_N.audioChannel = {{achannel}}
_M.audioName    = {{gtAudio}}
_M.audioLoop    = {{aloop}}
_M.audioFadeIn  = {{tofade}}
--
{{#gtBread}}
_M.breadcrumWidth = {{gtbw}}/4
_M.breadcrumHeight = {{gtbh}}/4
{{/gtBread}}
{{/ultimate}}
{{^ultimate}}
{{#gtBread}}
_M.breadcrumWidth = {{gtbw}}
_M.breadcrumHeight = {{gtbh}}
_M.breadShape      = "{{gtbshape}}"
_M.breadcrumColor  = {{gtbcolor}}
_M.breadcrumInterval = {{gtbinter}}
_M.breadcrumTime     = {{gtbsec}}
{{/gtBread}}
{{/ultimate}}
--
{{#gtTypePath}}
_M.pathAnimation = {
	{{pathCurve}} angle = {{gtAngle}}
}
{{/gtTypePath}}
---------------------------
function _M:didShow(UI)
  -- UI.scene:dispatchEvent({name="{{myLName}}_{{layerType}}_{{triggerName}}", phase = "didShow", UI=UI})	}
  self:repoHeader(UI)
  self:buildAnim(UI)
	{{#aplay}}
		{{#gtDissolve}}
			_K.trans[self.layerName]:play()
		{{/gtDissolve}}
		{{^gtDissolve}}
	--	if _K.gt[self.layerName] then
	--		_K.gt[self.layerName]:play()
	--	end
		{{/gtDissolve}}
	{{/aplay}}
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
{{#groupAndPage}}
local function getPosGroupAndPage(layer, _endX, _endY, isSceneGroup)
	local mX, mY
	local endX, endY =  _K.ultimatePosition(_endX, _endY)
	{{#CenterReferencePoint}}
		--CenterReferencePoint
	  if isSceneGroup then
	      mX = endX + layer.x
	      mY = endY + layer.y
	  else
	      mX = endX +layer.width/2)
	      mY = endY +layer.height/2)
	  end
	{{/CenterReferencePoint}}
	{{#TopLeftReferencePoint}}
		--TopLeftReferencePoint
        mX = endX  + ( layer.width / 2)
        mY = endY  + ( layer.height / 2)
	{{/TopLeftReferencePoint}}
	{{#TopCenterReferencePoint}}
	--TopCenterReferencePoint
        mX = endX  + (  layer.width / 2)
        mY = endY  + ( layer.height / 2)
	{{/TopCenterReferencePoint}}
	{{#TopRightReferencePoint}}
	--TopRightReferencePoint
        mX = endX  + (  layer.width )
        mY = endY  + ( layer.height )
	{{/TopRightReferencePoint}}
	{{#CenterLeftReferencePoint}}
	--CenterLeftReferencePoint
        mX = endX  + ( layer.width / 2)
        mY = endY  + (  layer.height / 2)
	{{/CenterLeftReferencePoint}}
	{{#CenterRightReferencePoint}}
	--CenterRightReferencePoint
        mX = endX  + ( layer.width )
        mY = endY  + (  layer.height / 2)
	{{/CenterRightReferencePoint}}
	{{#BottomLeftReferencePoint}}
	--BottomLeftReferencePoint
        mX = endX  + ( layer.width )
        mY = endY  + (  layer.height )
	{{/BottomLeftReferencePoint}}
	{{#BottomRightReferencePoint}}
	--BottomRightReferencePoint
        mX = endX  + (  layer.width )
        mY = endY  + (  layer.height )
	{{/BottomRightReferencePoint}}
	{{#BottomCenterReferencePoint}}
	--BottomCenterReferencePoint
        mX = endX  + (  layer.width / 2)
        mY = endY  + (  layer.height )
	{{/BottomCenterReferencePoint}}
	{{#randX}}
		mX = _M.layerWidth + math.random(_M.randXStart, _M.randXEnd)
	{{/randX}}
	{{#randY}}
		mY =  _M.layerHeigh + math.random(_M.randYStart, _M.randYEnd)
	{{/randY}}
	return mX, mY
end
{{/groupAndPage}}
{{^groupAndPage}}
--
local function getPos(layer, _endX, _endY)
	local endX, endY =  _K.ultimatePosition(_endX, _endY)
	local width, height = layer.width*layer.xScale, layer.height*layer.yScale
	{{#DefaultReference}}
    mX = endX + width/2
    mY = endY + height/2
	{{/DefaultReference}}
	{{#TextReference}}
    mX = endX + _M.nX - _M.layerX
    mY = endY + _M.nY - _M.layerY -height*0.5
	{{/TextReference}}
	{{#TopLeftReferencePoint}}
		--TopLeftReferencePoint
      mX = endX
      mY = endY
	{{/TopLeftReferencePoint}}
	{{#TopCenterReferencePoint}}
	--TopCenterReferencePoint
      mX = endX + width/2
      mY = endY
	{{/TopCenterReferencePoint}}
	{{#TopRightReferencePoint}}
	--TopRightReferencePoint
      mX = endX + width
      mY = endY
	{{/TopRightReferencePoint}}
	{{#CenterLeftReferencePoint}}
	--CenterLeftReferencePoint
      mX = endX
      mY = endY + height/2
	{{/CenterLeftReferencePoint}}
	{{#CenterRightReferencePoint}}
	--CenterRightReferencePoint
      mX = endX + width
      mY = endY + height/2
	{{/CenterRightReferencePoint}}
	{{#BottomLeftReferencePoint}}
	--BottomLeftReferencePoint
      mX = endX
      mY = endY + height
	{{/BottomLeftReferencePoint}}
	{{#BottomRightReferencePoint}}
	--BottomRightReferencePoint
      mX = endX + width
      mY = endY + height
	{{/BottomRightReferencePoint}}
	{{#BottomCenterReferencePoint}}
	--BottomCenterReferencePoint
      mX = endX + width/2
      mY = endY + height
	{{/BottomCenterReferencePoint}}
	{{#randX}}
		mX = _M.layerWidth + math.random(_M.randXStart, _M.randXEnd)
	{{/randX}}
	{{#randY}}
		mY =  _M.layerHeigh + math.random(_M.randYStart, _M.randYEnd)
	{{/randY}}
	return mX, mY
end
{{/groupAndPage}}

--
function _M:repoHeader(UI)
	local layer = self:getLayer(UI)
	{{#TopLeftReferencePoint}}
	layer.anchorX = 0
	layer.anchorY = 0;
	_K.repositionAnchor(layer, 0,0)
	{{/TopLeftReferencePoint}}
	{{#TopCenterReferencePoint}}
	layer.anchorX = 0.5
	layer.anchorY = 0;
	_K.repositionAnchor(layer, 0.5,0)
	{{/TopCenterReferencePoint}}
	{{#TopRightReferencePoint}}
	layer.anchorX = 1
	layer.anchorY = 0;
	_K.repositionAnchor(layer, 1,0)
	{{/TopRightReferencePoint}}
	{{#CenterLeftReferencePoint}}
	layer.anchorX = 0
	layer.anchorY = 0.5;
	_K.repositionAnchor(layer, 0,0.5)
	{{/CenterLeftReferencePoint}}
	{{#CenterRightReferencePoint}}
	layer.anchorX = 1
	layer.anchorY = 0.5;
	_K.repositionAnchor(layer, 1,0.5)
	{{/CenterRightReferencePoint}}
	{{#BottomLeftReferencePoint}}
	layer.anchorX = 0
	layer.anchorY = 1;
	_K.repositionAnchor(layer, 0,1)
	{{/BottomLeftReferencePoint}}
	{{#BottomRightReferencePoint}}
	layer.anchorX = 1
	layer.anchorY = 1;
	_K.repositionAnchor(layer, 1,1)
	{{/BottomRightReferencePoint}}
	{{#BottomCenterReferencePoint}}
	layer.anchorX = 0.5
	layer.anchorY = 1;
	_K.repositionAnchor(layer, 0.5,1)
	{{/BottomCenterReferencePoint}}
end
--
{{#ultimate}}
local function getPath(t)
    local _t = {}
    _t.x, _t.y =  _K.ultimatePosition(t.x, t.y)
    return _t
end
--
function _M:buildAnim(UI)
	local layer = self:getLayer(UI)
	local sceneGroup = UI.scene.view
	-- Wait request for '+gtName+'\r\n';
	if layer == nil then return end
	layer.xScale = layer.oriXs
	layer.yScale = layer.oriYs

	{{#gtDissolve}}
		_K.trans[self.layerName] = {}
		_K.trans[self.layerName].play = function()
			transition.dissolve(layer, self:getDssolvedLayer(UI),	self.animationDuration, self.animationDelay}})
		end
		_K.trans[self.layerName].pause = function() print("pause is not supported in dissove") end
		_K.trans[self.layerName].resume = function()
			transition.dissolve(layer, self:getDssolvedLayer(UI),	self.animationDuration, self.animationDelay)
		end
	{{/gtDissolve}}
	{{^gtDissolve}}
		local restartHandler= function(event)
			if _K.gt[self.layerName] then
				_K.gt[self.layerName]:toBeginning()
			end
		end -- end of function
		{{#gtRestart}}
		local _restart = self.restart
		{{/gtRestart}}
		{{^gtRestart}}
		local _restart = false
		{{/gtRestart}}
			{{#isComic}}
			local deltaX = 0
			local deltaY = 0
			{{/isComic}}
			local onEndHandler = function()
				if _restart then
						{{#getTypeShake}}
						layer.rotation = 0
						{{/getTypeShake}}
						{{^isComic}}
						layer.x				 = layer.oriX
						layer.y				 = layer.oriY
						{{/isComic}}
						layer.alpha		 = layer.oldAlpha
						layer.rotation	= 0
						layer.isVisible = true
						layer.xScale		= layer.oriXs
						layer.yScale		= layer.oriYs
						{{#tabSS}}
						layer:pause()
						layer.currentFrame = 1
						{{/tabSS}}
						{{^tabSS}}
						{{#tabMC}}
						layer::stopAtFrame(1)
						{{/tabMC}}
						{{/tabSS}}
				end
				{{#gtAction}}
			--	{{gtAction}}()
        Runtime:dispatchEvent({name=UI.page..self.actionName, event={}, UI=UI})
				{{/gtAction}}
				{{#gtAudio}}
				audio.setVolume({self.audioVolume, { channel=self.audioChannel })
				{{#alloRepeat}}
				audio.play(self.audioName, { channel=self.audioChannel, loops=self.audioLoop, fadein=self.audioFadeIn}} })
				{{/alloRepeat}}
				{{^alloRepeat}}
				audio.play(UI.allAudios[self.audioName], { channel=self.audioChannel, loops=self.audioLoop, fadein=self.audioFadeIn}} })
				{{/alloRepeat}}
				{{/gtAudio}}
			end --ends reStart for {{gtName}}
			{{#endX}}
				{{^groupAndPage}}
				local mX, mY = getPos(layer, self.animationEndX, self.animationEndY)
				{{#isComic}}
				deltaX = layer.oriX -mX
				deltaY = layer.oriY -mY
				mX, mY = display.contentCenterX - deltaX, display.contentCenterY - deltaY
				{{/isComic}}
				{{/groupAndPage}}
	   		{{#groupAndPage}}
				local mX, mY = getPosGroupAndPage(layer, self.animationEndX, self.animationEndY, self.isSceneGroup)
				{{/groupAndPage}}
			{{/endX}}
			{{^gtTypePath}}
				_K.gt[self.layerName] = _K.gtween.new(
					layer,
					self.animationDuration,
					{{^Linear}}
					{
						{{#Pulse}}
						  xScale = self.animationScaleX, yScale = self.animationScaleY,
						{{/Pulse}}
						{{#Rotation}}
							rotation =  self.animationRotation,
						{{/Rotation}}
						{{#Shake}}
							rotation =  self.animationRotation,
						{{/Shake}}
						{{#Bounce}}
							y=mY,
						{{/Bounce}}
						{{#Blink}}
						 xScale =  self.animationScaleX, yScale = self.animationScaleY,
						{{/Blink}}
					},
					{{/Linear}}
					{{#Linear}}
					{
						{{#endX}}
						x = mX, y = mY,
						{{/endX}}
						{{#gtEndAlpha}}
						alpha=self.animationEndAlpha,
						{{/gtEndAlpha}}
						{{#rotation}}
						rotation= self.animationRotation,
						{{/rotation}}
						{{#scalW}}
						xScale={{scalW}} * layer.xScale,
						{{/scalW}}
						{{#scalH}}
						yScale={{scalH}} * layer.yScale,
						{{/scalH}}
					},
					{{/Linear}}
					{
						ease = _K.gtween.easing[self.animationEasing],
						repeatCount = self.animationLoop,
						reflect =self,animationReverse, xSwipe=self.animationSwipeX, ySwipe=self.animationSwipeY,
						delay=self.animationDelay,
						onComplete=onEndHandler
						{{#gtBread}}
						, breadcrumb = true, breadAnchor = 5,
						breadShape = self.breadShape, breadW =self.breadcrumWidth, breadH = self.breadcrumHeight
						{{#gtbcolor}}
						, breadColor = {self.breadcrumColor }
						{{/gtbcolor}}
						{{^gtbcolor}}
						, breadColor = {"rand"}
						{{/gtbcolor}}
						, breadInterval = self.breadcrumInterval
						{{#gtbdispose}}
						, breadTimer = self.breadcrumTime
						{{/gtbdispose}}
						{{/gtBread}}
						})
			{{/gtTypePath}}
			{{#gtTypePath}}
			_K.gt[self.layerName] = _K.btween.new(
				layer,
				self.animationDuration,
				self.pathAnimation,
				{
					ease			 = _K.gtween.easing[self.animationEasing],
					repeatCount = self.animationLoop,
					reflect =self,animationReverse, xSwipe=self.animationSwipeX, ySwipe=self.animationSwipeY,
					delay			 = self.animationDelay,
					onComplete = onEndHandler
					{{#gtBread}}
					, breadcrumb = true, breadAnchor = 5,
					breadShape = self.breadShape, breadW =self.breadcrumWidth, breadH = self.breadcrumHeight
					{{#gtbcolor}}
					, breadColor = { self.breadcrumColor }
					{{/gtbcolor}}
					{{^gtbcolor}}
					, breadColor = {"rand"}
					{{/gtbcolor}}
					, breadInterval = self.breadcrumInterval
					{{#gtbdispose}}
					, breadTimer = self.breadcrumTime
					{{/gtbdispose}}
					{{/gtBread}}
				},
				{
					{{#endX}}
					x= mX, y= mY,
					{{/endX}}
					{{#gtEndAlpha}}
					alpha=self.animationEndAlpha,
					{{/gtEndAlpha}}
					{{#rotation}}
					rotation= self.animationRotation,
					{{/rotation}}
					{{#scalW}}
					xScale= self.animationScaleX * layer.xScale,
					{{/scalW}}
					{{#scalH}}
					yScale=self.animationScaleY * layer.yScale,
					{{/scalH}}
					{{#gtNewAngle}}
					newAngle = self.animationNewAngle
					{{/gtNewAngle}}
					})
				_K.gt[self.layerName].pathAnim = true
			{{/gtTypePath}}
				{{^aplay}}
				_K.gt[self.layerName]:pause()
				{{/aplay}}
  			-- _K.gt[self.layerName]:toBeginning()
	  		{{#isComic}}
  		layer.anim[self.layerName] = _K.gt[self.layerName]
  		{{/isComic}}
		{{/gtDissolve}}
	--
	-- {{gtName}}()
end
--
function _M:play(UI)
	{{#gtDissolve}}
		_K.trans[self.layerName]:play()
	{{/gtDissolve}}
	{{^gtDissolve}}
		-- _K.gt[self.layerName]:toBeginning()
		_K.gt[self.layerName]:play()
	{{/gtDissolve}}
end
--
function _M:resume(UI)
	{{#gtDissolve}}
		_K.trans[self.layerName]:resume()
	{{/gtDissolve}}
	{{^gtDissolve}}
		_K.gt[self.layerName]:play()
	{{/gtDissolve}}
end
--
return _M