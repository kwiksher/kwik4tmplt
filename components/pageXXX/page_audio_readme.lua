-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require("Application")
--
--
local allAudios = {}
---
--
function _M:localPos(UI)
{{#areadme}}
  {{#alang}}
   {{atype}}kwk_readMeFile = audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}" )
  {{/alang}}
  {{^alang}}
   {{atype}}kwk_readMeFile = audio.{{loadType}}( _K.audioDir.."{{fileName}}" )
  {{/alang}}
{{/areadme}}
  -- #audio
    {{#areadme}}
      {{^tempSync}}
        {{#adelay}}
        {{/adelay}}
        local a = audio.getDuration( {{atype}}kwk_readMeFile );
        if (a > tonumber(_K.allAudios.kAutoPlay)*1000 ) then
          _K.allAudios.kAutoPlay = math.ceil((a + 1000)/1000)
        end
        {{#adelay}}
        {{/adelay}}
      {{/tempSync}}
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
      {{^tempSync}}
         if (_K.kwk_readMe == 1 and _K.lang == "{{langID}}") then
        {{#adelay}}
          local kwkDelay = function()
        {{/adelay}}
          audio.setVolume({{avol}}, { channel={{achannel}} });
          audio.play({{atype}}kwk_readMeFile, { channel={{achannel}}, loops={{aloop}}{{tofade}} });
        {{#adelay}}
          end
          _K.timerStash.kwkDelay = timer.performWithDelay({{adelay}}, kwkDelay, 1)
        {{/adelay}}
        end
      {{/tempSync}}
    {{/areadme}}
  --  /audio
end

function toDispose()
end
--
function audioDisposal()
end
--
function _M:getAudio(UI)
{{#areadme}}
   return {{atype_}}
{{/areadme}}
end
--
return _M