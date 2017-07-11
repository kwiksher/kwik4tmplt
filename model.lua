 -- {{book}}
--[[
local pages = {
{{#pages}}
{
    page = {{page}}, alias="{{alias}}", isTmplt={{isTmplt}},
    {{#layers}}
    {{layer}} ={ x = {{x}}, y = {{y}} , width = {{width}}, height = {{height}},  alpha = {{alpha}} , ext = "{{ext}}" },
    {{/layers}}
},
{{/pages}}
}
]]--

local pages = {isDownloadable = false, pageNum={{pageNum}} }

return pages
