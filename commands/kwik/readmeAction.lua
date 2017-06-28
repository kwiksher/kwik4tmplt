-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K            = require "Application"
local composer = require("composer")
--
function _M:playReadMe(readMeFile, vchan)
	audio.play( readMeFile, { channelvchan} )
end
--
function _M:readMe(curPage)
	  if nil~= composer.getScene(_K.appName.."views.page0"..(curPage+1).."Scene" ) then
	  	composer.removeScene(_K.appName.."views.page0"..(curPage+1).."Scene" , true)
	  end
	  composer.gotoScene(_K.appName.."views.page0"..(curPage+1).."Scene" )
end
--
function _M:playSync(audioSent, line, button)
	_K.syncSound.saySentence{sentence=audioSent, line=line, button=button}
end
--
return _M