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
    UI.allAudios.kAutoPlay = _K.kAutoPlay
    UI.tSearch   = nil
    {{#language}}
      {{#lang}}
      UI.tab{{langID}} = {}
      {{/lang}}
      UI.tSearch   = nil
    {{/language}}
    UI.numPages = {{numPages}}   -- number of pages in the project

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
    {{#components}}
    self:_vars("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
  end
  --
  function UI:create()
    self:_create("common",  const.page_common, {{custom}})
    self:setVars()
    self:setLanguge()
    {{#components}}
    self:_create("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
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
  end
  --
  function UI:destroy(params)
    self:_destroy("common",  const.page_common)
    {{#components}}
    self:_destroy("{{type}}",  const.{{layer}}_{{type}}_{{trigger}}, {{custom}})
    {{/components}}
  end
  --
  function UI:touch(event)
      print("event.name: "..event.name)
  end
  --
  return  UI
end
--
return _Class