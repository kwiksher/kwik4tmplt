
-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require("Application")
--
-- local allAudios = {}
--
function _M:localPos(UI)
{{#areadme}}
  {{#alang}}
   {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}" )
  {{/alang}}
  {{^alang}}
   {{atype}}.kwk_readMeFile = audio.{{loadType}}( _K.audioDir.."{{fileName}}" )
  {{/alang}}
{{/areadme}}
{{^areadme}}
    {{#alang}}
     {{atype}}.{{aname}} =  audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}")
    {{/alang}}
    {{^alang}}
     {{atype}}.{{aname}} =  audio.{{loadType}}( _K.audioDir.."{{fileName}}")
    {{/alang}}
{{/areadme}}

  -- audio
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
    {{^areadme}}
      local a = audio.getDuration( {{atype}}.{{aname}} );
      if a > UI.allAudios.kAutoPlay  then
        UI.allAudios.kAutoPlay = a
      end
      {{#allowRepeat}}
        {{atype}}.{{aname}}x9 = 0
      {{/allowRepeat}}
    {{/areadme}}
  --/audio
end

function _M:allListeners(UI)

  -- audio
    {{#areadme}}
      {{#alang}}
      {{/alang}}
      {{^alang}}
      {{/alang}}
      {{^temSync}}
         if _K.kwk_readMe == 1 then
        {{#adelay}}
          local kwkDelay = function()
        {{/adelay}}
          audio.setVolume({{avol}}, { channel={{achannel}} } );
          --audio.play({{atype}}.kwk_readMeFile, { channel={{achannel}}, loops={{aloop}}{{tofade}} });
        {{#adelay}}
          end
          _K.timerStash.kwkDelay = timer.performWithDelay({{adelay}}, kwkDelay, 1)
        {{/adelay}}
        end
      {{/temSync}}
    {{/areadme}}
    {{^areadme}}
      {{#alang}}
      {{/alang}}
      {{^alang}}
      {{/alang}}
      {{#allowRepeat}}
      {{/allowRepeat}}
      {{#aplay}}
        {{#adelay}}
          local myClosure_{{aname}} = function()
        {{/adelay}}
               audio.setVolume({{avol}}, { channel={{achannel}} });
            {{#allowRepeat}}
                if {{atype}}.{{aname}} == nil then return end
               {{atype}}.{{aname}}x9 = audio.play({{atype}}.{{aname}}, {  channel={{achannel}}, loops={{aloop}}{{tofade}} } )
            {{/allowRepeat}}
            {{^allowRepeat}}
                if {{atype}}.{{aname}} == nil then return end
              audio.play({{atype}}.{{aname}}, {channel={{achannel}}, loops={{aloop}}{{tofade}} } )
            {{/allowRepeat}}
        {{#adelay}}
           end
           _K.timerStash.{{tm}} = timer.performWithDelay({{adelay}}, myClosure_{{aname}}, 1)
        {{/adelay}}
      {{/aplay}}
        {{#allowRepeat}}
        {{/allowRepeat}}
        {{^allowRepeat}}
        {{/allowRepeat}}
    {{/areadme}}
  --/audio
end

function _M:toDispose(UI)
  -- audio
  {{^akeep}}
    if audio.isChannelActive ( {{achannel}} ) then
      audio.stop({{achannel}})
    end
  {{/akeep}}
--/audio
end
--
function _M:toDestroy(UI)
{{^akeep}}
    {{#areadme}}
      if ({{atype}}.kwk_readMeFile ~= 0) then
        audio.dispose({{atype}}.kwk_readMeFile)
        {{atype}}.kwk_readMeFile = nil
      end
    {{/areadme}}
    {{^areadme}}
      {{#allowRepeat}}
        if ({{atype}}.{{aname}}x9 ~= 0) then
          audio.dispose({{atype}}.{{aname}})
          {{atype}}.{{aname}}x9 = 0
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
end

-- function audioDisposal(UI)
  -- audio
    -- {{^areadme}}
  --    { {{achannel}}, "_K.allAudios.{{aname}}"},
    -- {{/areadme}}
  --/audio
-- end
function _M:getAudio(UI)
  --UI.allAudios or _K.allAudios
{{#areadme}}
  if {{atype}}.{{aname}} == nil then
    {{#alang}}
     {{atype}}.{{aname}} = audio.{{loadType}}( _K.audioDir.._K.lang.."{{fileName}}", _K.systemDir )
    {{/alang}}
    {{^alang}}
     {{atype}}.{{aname}} = audio.{{loadType}}( _K.audioDir.."{{fileName}}" , _K.systemDir)
    {{/alang}}
  end
{{/areadme}}
  return {{atype}}
end


return _M