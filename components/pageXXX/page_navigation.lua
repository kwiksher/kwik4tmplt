-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local Navigation = require("extlib.kNavi")
local _K = require("Application")
---------------------
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
{{/ultimate}}
{{^ultimate}}
local xFactor = 1
local yFactor = 1
{{/ultimate}}
---------------------
--
function _M:localVars(UI)
end
--
function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
end
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  local curPage     = UI.curPage
  local numPages    = UI.numPages
  Navigation.new("page", {
  	backColor = { {{bcor}} },
  	{{#man}}
	  	anim=1,
  	{{/man}}
  	{{#mti}}
	  	timer=1,
  	{{/mti}}
  	{{#mm}}
	  	exclude = { {{mm}} },
  	{{/mm}}
			totPages = numPages,
			curPage  = curPage,
			thumbW   = {{tw}}*xFactor,
			thumbH   = {{th}}*yFactor,
			alpha    = {{bal}},
			imageDir = _K.thumbDir,
			dire     = "{{bdir}}",
			audio    ={ {{audioDisposal}} }} )
   Navigation.hide()
end
--
function _M:toDispose()
    Navigation.hide();
end
--
--
return _M