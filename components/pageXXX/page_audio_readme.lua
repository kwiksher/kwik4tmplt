-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require("Application")
--
--
-- local allAudios = {}
---
--
function _M:localPos(UI)
  --UI.allAudios or _K.allAudios
{{#areadme}}
  if {{atype}}.kwk_readMeFile == nil then
    {{#alang}}
     {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}" )
    {{/alang}}
    {{^alang}}
     {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.."{{fileName}}" )
    {{/alang}}
  end
{{/areadme}}
  -- #audio
    {{#areadme}}
      {{^temSync}}
        {{#adelay}}
        {{/adelay}}
        local a = audio.getDuration( {{atype}}.kwk_readMeFile );
        if a > UI.allAudios.kAutoPlay  then
          UI.allAudios.kAutoPlay = a
        end
        {{#adelay}}
        {{/adelay}}
      {{/temSync}}
    {{/areadme}}
  --  /audio
end

function _M:allListeners(UI)
  -- #audio
    {{#areadme}}
      {{#alang}}
      {{/alang}}
      {{^alang}}
      {{/alang}}
      {{^temSync}}
         if (_K.kwk_readMe == 1 and _K.lang == "{{langID}}") then
        {{#adelay}}
          local kwkDelay = function()
        {{/adelay}}
          audio.setVolume({{avol}}, { channel={{achannel}} });
          -- audio.play({{atype}}.kwk_readMeFile, { channel={{achannel}}, loops={{aloop}}{{tofade}} });
        {{#adelay}}
          end
          _K.timerStash.kwkDelay = timer.performWithDelay({{adelay}}, kwkDelay, 1)
        {{/adelay}}
        end
      {{/temSync}}
    {{/areadme}}
  --  /audio
end

function _M:toDispose(UI)
  -- audio
  {{^akeep}}
    if audio.isChannelActive ( {{achannel}} ) then
      audio.stop({{achannel}})
    end
    {{#areadme}}
      if ({{atype}}.kwk_readMeFile ~= 0) then
        audio.dispose({{atype}}.kwk_readMeFile)
        {{atype}}.kwk_readMeFile = nil
      end
    {{/areadme}}
    {{^areadme}}
      {{#allowRepeat}}
        if ({{atype}}.{{aname}}x9 ~= 0) then
          audio.dispose({{atype}}.{{aname}}x9)
          {{atype}}.{{aname}}x9 = nil
        end
      {{/allowRepeat}}
      {{^allowRepeat}}
        if ({{atype}}.{{aname}} ~= 0) then
          audio.dispose({{atype}}.{{aname}})
          {{atype}}.{{aname}} = nil
        end
        {{/allowRepeat}}
    {{/areadme}}
  {{/akeep}}
--/audio
end

--
function _M:getAudio(UI)
  --UI.allAudios or _K.allAudios
{{#areadme}}
  if {{atype}}.kwk_readMeFile == nil then
    {{#alang}}
     {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}" )
    {{/alang}}
    {{^alang}}
     {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.."{{fileName}}" )
    {{/alang}}
  end
{{/areadme}}
  return {{atype}}
end
--
return _M