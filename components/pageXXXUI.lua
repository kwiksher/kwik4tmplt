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
_Class.new = function(scene, imagePage)
  local UI = layerUI.new()
    UI.scene     = scene
    UI.page      = "page{{page}}"
    UI.imagePage = imagePage or {{page}}
    UI.curPage   = {{page}}
    -- All components on a table
    UI.layer     = {}
    -- All audio files on a table
    UI.allAudios = {}
    UI.allAudios.kAutoPlay = 0
    UI.tSearch   = nil
    {{#language}}
      {{#lang}}
      UI.tab{{langID}} = {}
      {{/lang}}
      UI.tSearch   = nil
    {{/language}}
    UI.numPages = {{numPages}}   -- number of pages in the project
    {{#lockPage}}
    --K.systemDir = system.ApplicationSupportDirectory
    {{/lockPage}}
    {{^lockPage}}
    --_K.systemDir = system.ResourceDirectory
    {{/lockPage}}
  function UI:setLanguge()
      {{#language}}
      if _K.lang == "" then _K.lang = "en" end
      {{#lang}}
        -- Language switch
        if (_K.lang=="{{langID}}") then
          self.tSearch = self.tab{{langID}}
        end
      {{/lang}}
    {{/language}}
  end
  --
  function UI:setVars()
    {{#Variable}}
      self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/Variable}}
    {{#extLibCode}}
      self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/extLibCode}}
    {{#components}}
    self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
  end
  --
  function UI:create()
   {{#isTmplt}}
    _K.systemDir = system.ResourceDirectory
    _K.imgDir = "assets/images/"
    _K.audioDir = "assets/audios/"
   {{/isTmplt}}
    self:_create("common",  const.page_common, {{custom}})
    self:setVars()
    self:setLanguge()
    {{#components}}
    self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
    {{#Variable}}
      self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/Variable}}
    {{#extLibCode}}
      self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/extLibCode}}
    {{#hide}}
       self.scene:dispatchEvent({name="hide", event = {phase="create"}})
    {{/hide}}
  end
  --
  function UI:didShow(params)
    self:_didShow("common",  const.page_common, {{custom}})
    {{#components}}
    self:_didShow("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
    {{#Variable}}
      self:_didShow("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/Variable}}
    {{#extLibCode}}
      self:_didShow("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/extLibCode}}
    {{#hide}}
       self.scene:dispatchEvent({name="hide", event = {phase="didShow"}})
    {{/hide}}
  end
  --
  function UI:didHide(params)
    self:_didHide("common",  const.page_common, {{custom}})
    {{#components}}
    self:_didHide("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
    {{#Variable}}
      self:_didHide("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/Variable}}
    {{#extLibCode}}
      self:_didHide("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/extLibCode}}
  end
  --
  function UI:destroy(params)
    self:_destroy("common",  const.page_common)
    {{#components}}
    self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
    {{#Variable}}
      self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/Variable}}
    {{#extLibCode}}
      self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/extLibCode}}
  end
  --
  function UI:touch(event)
      print("event.name: "..event.name)
  end
  function UI:resume(params)
    {{#components}}
    self:_resume("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
  end

  --
  return  UI
end
--
return _Class