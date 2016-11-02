-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
_M.x9 = {}
--
local _K = require("Application")
--
local allAudios = {}

function _M:recordAudio(duration, mmFile, malfa, sceneGroup, allAudios)
  allAudios.playback  = nil
  local filePath = system.pathForFile(mmFile, system.DocumentsDirectory )
  local r = media.newRecording(filePath)
  sceneGroup.alpha = malfa
  r:startRecording( )
  local audioClosure = function(event )
    r:stopRecording()
    sceneGroup.alpha = 1
    local file = io.open(filePath, "r")
    if file then
       io.close(file)
       allAudios.playback = audio.loadStream( mmFile, system.DocumentsDirectory )
       audio.play(allAudios.playback, {channel=31})
    end
   end
   _K.timerStash.recTimer = timer.performWithDelay(duration, audioClosure )
   -- audio.stop(31)
   -- audio.dispose(allAudios.playback)
   -- allAudios.playback = nil
end
--
function _M:muteUnmute()
  if (audio.getVolume() == 0.0) then
     audio.setVolume(1.0)
  else
     audio.setVolume(0.0)
  end
end
--
function _M:playAudio(vaudio, vchan, vrepeat, vdelay, vloop, toFade, vvol, tm)
  local myClosure = function()
    if not vrepeat then
      audio.setVolume(vvol, {channel=vchan} )
      audio.play( vaudio, {channel=vchan, loops = vloop, fadein = tofade } )
    else
      _M.x9[vaudio] = audio.play( vaudio, {loops = vloop, fadein = tofade } )
      audio.setVolume(vvol, {channel=_M.x9[vaudio]} )
    end
  end
  if vdelay == 0 then
    myClosure()
  else
    _K.timerStash[tm] = timer.performWithDelay(vdelay,
      myClosure, 1)
  end
end
--
function _M:rewindAudio( vaudio, vchan, vrepeat)
  if not vrepeat then
    audio.rewind( vchan )
  else
    audio.rewind( _M.x9[vaudio] )
  end
end
--
function _M:pauseAudio(vaduio, vchan, vrepeat)
  if not vrepeat then
    audio.pause( vchan )
  else
    audio.pause( _M.x9[vaudio] )
  end
end
--
function _M:stopAudio(vaduio, vchan, vrepeat)
  if not vrepeat then
    audio.rewind( vchan )
    audio.stop( vchan )
  else
    audio.rewind( _M.x9[vaudio])
    audio.stop( _M.x9[vaudio] )
  end
end
--
function _M:resumeAudio(vaduio, vchan, vrepeat)
  if not vrepeat then
    audio.resume( vchan )
  else
    audio.resume( _M.x9[vaudio] )
  end
end
--
function _M:setVolume(vvol, vchan)
  audio.setVolume(vvol, {channel=vchan} )
end
--
return _M