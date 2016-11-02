-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
local widget = require("widget")
--
function _M:localVars()
end
--
function _M:localPos()
end
--
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
{{/ultimate}}
{{^ultimate}}
local xFactor = 1
local yFactor = 1
{{/ultimate}}
--
function _M:allListeners(UI)
  local sceneGroup  = UI.scene.view
  local layer       = UI.layer
  {{^layer}}
   {{#para}}
    local _top         = layer.{{glayer}}.contentBounds.yMin
    local _left        = layer.{{glayer}}.contentBounds.xMin
    local _width       = layer.{{glayer}}.width + 10 - {{ggwid}}*xFactor
    local _height      = layer.{{glayer}}.height
    local _scrollWidth = layer.{{glayer}}.width
    local _scrollHeight = layer.{{glayer}}.height
  {{/para}}
  {{#page}}
    local _top          = layer.{{glayer}}.contentBounds.yMin
    local _left         = layer.{{glayer}}.contentBounds.xMin
    local _width        = {{gww}}*xFactor
    local _height       = {{gwh}}*yFactor
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
  {{/page}}
  {{#object}}
    local _top          = layer.{{glayer}}.contentBounds.yMin
    local _left         = layer.{{glayer}}.contentBounds.xMin
    local _width        = layer.{{glayer}}.width + 10- {{ggwid}}*xFactor
    local _height       = layer.{{glayer}}.height
    local _scrollWidth  = layer.{{glayer}}.width
    local _scrollHeight = layer.{{glayer}}.height
  {{/object}}
  {{#manual}}
    local _top          = {{gmt}}*xFactor
    local _left         = {{gml}}*yFactor
    local _width        = {{gww}}*xFactor
    local _height       = {{gwh}}*yFactor
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
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
  {{#gHide}}
     hideScrollBar = true,
  {{/gHide}}
  {{#gHideBack}}
     hideBackground = true,
  {{/gHideBack}}
  {{#gmask}}
     maskFile = composer.imgDir.."{{fileName}}",
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
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
  {{/para}}
  {{#page}}
    local _top    = layer.{{glayer}}.y
    local _left   = layer.{{glayer}}.x
    local _width  = layer.{{glayer}}.width + 10
    local _height = {{gwh}}*xFactor
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
  {{/page}}
  {{#object}}
    local _top    = layer.{{glayer}}.y
    local _left   = layer.{{glayer}}.x
    local _width  = layer.{{glayer}}.width + 10
    local _height = layer.{{glayer}}.height
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
  {{/object}}
  {{#manual}}
    local _top          = {{gmt}}*xFactor
    local _left         = {{gml}}*yFactor
    local _width        = {{gww}}*xFactor
    local _height       = {{gwh}}*yFactor
    local _scrollWidth  = {{gwsw}}*xFactor
    local _scrollHeight = {{gwsh}}*yFactor
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
  {{#gHide}}
     hideScrollBar = true,
  {{/gHide}}
  {{#gHideBack}}
     hideBackground = true,
  {{/gHideBack}}
  {{#gmask}}
     maskFile = composer.imgDir.."{{fileName}}",
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