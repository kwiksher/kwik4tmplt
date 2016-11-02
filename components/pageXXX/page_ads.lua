-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local ads = require "ads"
---------------------
{{#ultimate}}
local xFactor = display.contentWidth/1920
local yFactor = display.contentHeight/1280
{{/ultimate}}
{{^ultimate}}
local xFactor = 1
local yFactor = 1
{{/ultimate}}

function _M:allListeners()
  {{#addShow}}
    -- Monetization with Ads
    ads.show("banner", { x={{adX}}*xFactor, y={{adY}}*yFactor } )
  {{/addShow}}
  {{^addShow}}
    -- Monetization with Ads
    ads.hide()
  {{/addShow}}
end

return _M