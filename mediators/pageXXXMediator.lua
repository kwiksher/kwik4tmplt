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
    view:addEventListener("{{myLName}}{{_}}{{layerType}}_{{triggerName}}", self)
    {{/if}}
  end
  --
  function mediator:onRemove()
    local view = self.viewInstance
    {{if(options.eventListeners)}}
    view:removeEventListener("{{myLName}}{{_}}{{layerType}}_{{triggerName}}", self)
    {{/if}}
  end
  --
  function mediator:hide(event)
    Runtime:dispatchEvent({name="{{page}}.hide", event=event, UI = self.viewInstance.pageUI})
  end
  {{if(options.eventListeners)}}
  function mediator:{{myLName}}{{_}}{{layerType}}_{{triggerName}}(event)
    Runtime:dispatchEvent({name="{{page}}.{{myLName}}{{_}}{{layerType}}_{{triggerName}}", event=event.parent or event, UI = self.viewInstance.pageUI})
  end
  {{/if}}
  --
  return mediator
end
--
return PageViewMediator