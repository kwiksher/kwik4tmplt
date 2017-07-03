 -- {{book}}
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

return pages
