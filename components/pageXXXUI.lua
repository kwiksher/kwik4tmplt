-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--

local _Class   = {}
local layerUI  = require("components.kwik.layerUI")
local const    = require("{{customVO}}vo.page{{page}}VO").const
local composer = require( "composer" )
local _K       = require("Application")
---------------------
---------------------
_Class.new = function(scene)
  local UI = layerUI.new()
    UI.scene     = scene
    UI.page      = "page{{page}}"
    UI.curPage   = {{page}}
    -- All components on a table
    UI.layer     = {}
    -- All audio files on a table
    UI.allAudios = {}
    UI.allAudios.kAutoPlay = 0
    UI.tSearch   = nil
    {{if(options.language)}}
      {{if(options.lang)}}
      UI.tab{{langID}} = {}
      {{/if}}
      UI.tSearch   = nil
    {{/if}}
    UI.numPages = {{numPages}}   -- number of pages in the project
    {{if(options.lockPage)}}
    --K.systemDir = system.ApplicationSupportDirectory
    {{#else}}
    --_K.systemDir = system.ResourceDirectory
    {{/if}}
  function UI:setLanguge()
      {{if(options.language)}}
      if _K.lang == "" then _K.lang = "en" end
      {{if(options.lang)}}
        -- Language switch
        if (_K.lang=="{{langID}}") then
          self.tSearch = self.tab{{langID}}
        end
      {{/if}}
    {{/if}}
  end
  --
  function UI:setVars()
    {{if(options.extLibCode)}}
      self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.components)}}
    self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
  end
  --
  function UI:create()
   {{if(options.isTmplt)}}
    _K.systemDir = system.ResourceDirectory
    _K.imgDir = "assets/images/"
    _K.audioDir = "assets/audios/"
   {{/if}}
    self:_create("common",  const.page_common, {{custom}})
    self:setVars()
    self:setLanguge()
    {{if(options.components)}}
    self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.extLibCode)}}
      self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.hide)}}
       self.scene:dispatchEvent({name="hide", event = {phase="create"}})
    {{/if}}
  end
  --
  function UI:didShow(params)
    self:_didShow("common",  const.page_common, {{custom}})
    {{if(options.components)}}
    self:_didShow("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.extLibCode)}}
      self:_didShow("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.hide)}}
       self.scene:dispatchEvent({name="hide", event = {phase="didShow"}})
    {{/if}}
  end
  --
  function UI:didHide(params)
    self:_didHide("common",  const.page_common, {{custom}})
    {{if(options.components)}}
    self:_didHide("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.extLibCode)}}
      self:_didHide("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
  end
  --
  function UI:destroy(params)
    self:_destroy("common",  const.page_common)
    {{if(options.components)}}
    self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
    {{if(options.extLibCode)}}
      self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
  end
  --
  function UI:touch(event)
      print("event.name: "..event.name)
  end
  function UI:resume(params)
    {{if(options.components)}}
    self:_resume("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/if}}
  end

  --
  return  UI
end
--
return _Class