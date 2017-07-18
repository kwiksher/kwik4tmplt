 -- {{book}}
{{#BookTmplt}}
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
{{/BookTmplt}}

{{#BookEmbedded}}
local pages = {isDownloadable = {{isDownloadable}}, pageNum={{pageNum}} }
{{/BookEmbedded}}

return pages
