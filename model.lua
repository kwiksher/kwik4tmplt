 -- {{book}}
{{if(options.BookTmplt)}}
local pages = {
{{if(options.pages)}}
{
    page = {{page}}, alias="{{alias}}", isTmplt={{isTmplt}},
    {{if(options.layers)}}
    {{layer}} ={ x = {{x}}, y = {{y}} , width = {{width}}, height = {{height}},  alpha = {{alpha}} , ext = "{{ext}}" },
    {{/if}}
},
{{/if}}
}
{{/if}}

{{if(options.BookEmbedded)}}
local pages = {isDownloadable = {{isDownloadable}}, pageNum={{pageNum}}, isIAP = {{isIAP}} }
{{/if}}

{{if(options.BookPages)}}
local pages = {}
{{/if}}

return pages
