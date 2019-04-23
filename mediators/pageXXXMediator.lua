-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local PageViewMediator = {}
--
function PageViewMediator:new()
  local mediator = {}
  --
  function mediator:onRegister()
    local view = self.viewInstance
    -- Scene
    view:addEventListener("hide", self)
    {{if(options.eventListeners)}}
    {{each(options.eventListeners)}}
    view:addEventListener("{{@this.myLName}}{{_}}{{@this.layerType}}_{{@this.triggerName}}", self)
    {{/each}}
    {{/if}}
  end
  --
  function mediator:onRemove()
    local view = self.viewInstance
    {{if(options.eventListeners)}}
    {{each(options.eventListeners)}}
    view:removeEventListener("{{@this.myLName}}{{_}}{{@this.layerType}}_{{@this.triggerName}}", self)
    {{/each}}
    {{/if}}
  end
  --
  function mediator:hide(event)
    Runtime:dispatchEvent({name="{{page}}.hide", event=event, UI = self.viewInstance.pageUI})
  end
--
  {{if(options.eventListeners)}}
  {{each(options.eventListeners)}}
  function mediator:{{@this.myLName}}{{_}}{{@this.layerType}}_{{@this.triggerName}}(event)
    Runtime:dispatchEvent({name="{{@this.page}}.{{@this.myLName}}{{_}}{{@this.layerType}}_{{@this.triggerName}}", event=event.parent or event, UI = self.viewInstance.pageUI})
  end
  {{/each}}
  {{/if}}
  --
  return mediator
end
--
return PageViewMediator