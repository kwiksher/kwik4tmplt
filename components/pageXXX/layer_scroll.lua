-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local widget = require("widget")
local _K            = require "Application"
--
function _M:localVars()
end
--
function _M:localPos()
end
--
{{#ultimate}}
  {{#para}}
  local ggwid  = {{ggwid}}/4
  {{/para}}
  {{#page}}
  local gww, gwh   = {{gww}}/4, {{gwh}}/4
  local gwsw, gwsh = {{gwsw}}/4, {{gwsh}}/4
  {{/page}}
  {{#object}}
  local ggwid  = {{ggwid}}/4
  {{/object}}
  {{#manual}}
  local gmt, gml   = {{gmt}}, {{gml}}
  local gww, gwh   = {{gww}}/4, {{gwh}}/4
  local gwsw, gwsh = {{gwsw}}/4, {{gwsh}}/4
  {{/manual}}
{{/ultimate}}
{{^ultimate}}
  {{#para}}
  local ggwid  = {{ggwid}}
  {{/para}}
  {{#page}}
  local gww, gwh   = {{gww}}, {{gwh}}
  local gwsw, gwsh = {{gwsw}}, {{gwsh}}
  {{/page}}
  {{#object}}
  local ggwid  = {{ggwid}}
  {{/object}}
  {{#manual}}
  local gmt, gml   = {{gmt}}, {{gml}}
  local gww, gwh   = {{gww}}, {{gwh}}
  local gwsw, gwsh = {{gwsw}}, {{gwsh}}
  {{/manual}}
{{/ultimate}}
--
function _M:didShow(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  if layer.{{glayer}} == nil then return end

  {{^layer}}
   {{#para}}
    local _top         = layer.{{glayer}}.contentBounds.yMin
    local _left        = layer.{{glayer}}.contentBounds.xMin
    local _width       = layer.{{glayer}}.width + 10 - ggwid
    local _height      = layer.{{glayer}}.height
    local _scrollWidth = layer.{{glayer}}.width
    local _scrollHeight = layer.{{glayer}}.height
  {{/para}}
  {{#page}}
    local _top          = layer.{{glayer}}.contentBounds.yMin
    local _left         = layer.{{glayer}}.contentBounds.xMin
    local _width        = gww
    local _height       = gwh
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/page}}
  {{#object}}
    local _top          = layer.{{glayer}}.contentBounds.yMin
    local _left         = layer.{{glayer}}.contentBounds.xMin
    local _width        = layer.{{glayer}}.width + 10- ggwid
    local _height       = layer.{{glayer}}.height
    local _scrollWidth  = layer.{{glayer}}.width
    local _scrollHeight = layer.{{glayer}}.height
  {{/object}}
  {{#manual}}
    local _top          = gmt
    local _left         = gml
    local _width        = gww
    local _height       = gwh
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/manual}}

  _width        = (_width        ==0) and layer.{{glayer}}.height or _width
  _height       = (_height       ==0) and layer.{{glayer}}.height or _height
  _scrollWidth  = (_scrollWidth  ==0) and layer.{{glayer}}.height or _scrollWidth
  _scrollHeight = (_scrollHeight ==0) and layer.{{glayer}}.height or _scrollHeight

  layer.{{gname}} = widget.newScrollView( {
    top          = _top,
    left         = _left,
    width        = _width,
    height       = _height,
    scrollWidth  = _scrollWidth,
    scrollHeight = _scrollHeight,
    baseDir      = _K.systemDir,
  {{#gHide}}
     hideScrollBar = true,
  {{/gHide}}
  {{#gHideBack}}
     hideBackground = true,
  {{/gHideBack}}
  {{#gmask}}
     maskFile = _K.imgDir.."{{fileName}}",
  {{/gmask}}
  {{#gdH}}
     horizontalScrollDisabled = true,
  {{/gdH}}
  {{#gdV}}
     verticalScrollDisabled = true
  {{/gdV}}
  })
  sceneGroup:insert( layer.{{gname}})
  layer.{{gname}}:insert(layer.{{glayer}})
  layer.{{glayer}}.x = layer.{{glayer}}.width / 2
  layer.{{glayer}}.y = layer.{{glayer}}.height / 2
{{/layer}}
{{#layer}}
  {{#para}}
    local _top    = layer.{{glayer}}.y
    local _left   = layer.{{glayer}}.x
    local _width  = layer.{{glayer}}.originalW
    local _height = layer.{{glayer}}.originalH
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/para}}
  {{#page}}
    local _top    = layer.{{glayer}}.y
    local _left   = layer.{{glayer}}.x
    local _width  = layer.{{glayer}}.width + 10
    local _height = gwh
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/page}}
  {{#object}}
    local _top    = layer.{{glayer}}.y
    local _left   = layer.{{glayer}}.x
    local _width  = layer.{{glayer}}.width + 10
    local _height = layer.{{glayer}}.height
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/object}}
  {{#manual}}
    local _top          = gmt
    local _left         = gml
    local _width        = gww
    local _height       = gwh
    local _scrollWidth  = gwsw
    local _scrollHeight = gwsh
  {{/manual}}

  _width        = (_width        ==0) and layer.{{glayer}}.height or _width
  _height       = (_height       ==0) and layer.{{glayer}}.height or _height
  _scrollWidth  = (_scrollWidth  ==0) and layer.{{glayer}}.height or _scrollWidth
  _scrollHeight = (_scrollHeight ==0) and layer.{{glayer}}.height or _scrollHeight

  layer.{{gname}} = widget.newScrollView ({
    top          = _top,
    left         = _left,
    width        = _width,
    height       = _height,
    scrollWidth  = _scrollWidth,
    scrollHeight = _scrollHeight,
    baseDir      = _K.systemDir,
  {{#gHide}}
     hideScrollBar = true,
  {{/gHide}}
  {{#gHideBack}}
     hideBackground = true,
  {{/gHideBack}}
  {{#gmask}}
     maskFile = _K.imgDir.."{{fileName}}",
  {{/gmask}}
  {{#gdH}}
     horizontalScrollDisabled = true,
  {{/gdH}}
  {{#gdV}}
     verticalScrollDisabled = true
  {{/gdV}}
  })
  --
  sceneGroup:insert( layer.{{gname}})
  layer.{{gname}}:insert(layer.{{glayer}})
  {{^manual}}
    layer.{{glayer}}.x = layer.{{glayer}}.width / 2;
    layer.{{glayer}}.y = 0;
  {{/manual}}
{{/layer}}
end
--
function _M:toDispose()
end
--
function _M:localVars()
end
--
return _M