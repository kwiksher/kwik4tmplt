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
      {{each(options.lang)}}
      UI.tab{{@this.langID}} = {}
      {{/each}}
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
      {{each(options.lang)}}
        -- Language switch
        if (_K.lang=="{{@this.langID}}") then
          self.tSearch = self.tab{{@this.langID}}
        end
      {{/each}}
    {{/if}}
  end
  --
  function UI:setVars()
    {{if(options.extLibCode)}}
      self:_vars("{{extLibCode.type}}",  const.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}, {{extLibCode.custom}})
    {{/if}}
    {{each(options.components)}}
    self:_vars("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
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
    {{each(options.components)}}
    self:_create("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
    {{if(options.extLibCode)}}
      self:_create("{{extLibCode.type}}",  const.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}, {{extLibCode.custom}})
    {{/if}}
    {{if(options.hide)}}
       self.scene:dispatchEvent({name="hide", event = {phase="create"}})
    {{/if}}
  end
  --
  function UI:didShow(params)
    self:_didShow("common",  const.page_common, {{custom}})
    {{each(options.components)}}
    self:_didShow("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
    {{if(options.extLibCode)}}
      self:_didShow("{{extLibCode.type}}",  const.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}, {{extLibCode.custom}})
    {{/if}}
    {{if(options.hide)}}
       self.scene:dispatchEvent({name="hide", event = {phase="didShow"}})
    {{/if}}
  end
  --
  function UI:didHide(params)
    self:_didHide("common",  const.page_common, {{custom}})
    {{each(options.components)}}
    self:_didHide("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
    {{if(options.extLibCode)}}
      self:_didHide("{{extLibCode.type}}",  const.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}, {{extLibCode.custom}})
    {{/if}}
  end
  --
  function UI:destroy(params)
    self:_destroy("common",  const.page_common)
    {{each(options.components)}}
    self:_destroy("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
    {{if(options.extLibCode)}}
      self:_destroy("{{extLibCode.type}}",  const.{{extLibCode.layer}}_{{extLibCode.type}}_{{extLibCode.trigger}}, {{extLibCode.custom}})
    {{/if}}
  end
  --
  function UI:touch(event)
      print("event.name: "..event.name)
  end
  function UI:resume(params)
    {{each(options.components)}}
    self:_resume("{{@this.type}}",  const.{{@this.layer}}_{{@this.type}}_{{@this.trigger}}, {{@this.custom}})
    {{/each}}
  end

  --
  return  UI
end
--
return _Class