-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
function _M:allListeners()
  if UI.tSearch["{{bn}}"] == nil then return end
  -- Multipliers for {{myLName}}
  layer.{{myLName}}              = {}
  layer.c_{{myLName}}            = 0
  local {{myLName}}_m_loop       = {{elfora}} --1 plays multiplier forever
  local {{myLName}}_m_counter    = {{elCopies}}
  composer.{{myLName}}_m_restart = {{elCopies}}

  {{#elphys}}
     physics.start(true);
  {{/elphys}}

  composer.mt_{{myLName}} = function(counter)
  {{#multLayers}}
    {{#elwind}}
      physics.setGravity(math.random(tSearch["{{bn}}"][9]*-1, tSearch["{{bn}}"[9])/10, 4);
    {{/elwind}}

    layer.{{myLName}} = display.newImageRect( composer.imgDir.. tSearch["{{bn}}"][1], tSearch["{{bn}}"][2], tSearch["{{bn}}"][3] );

    {{#elDistance}}
         layer.{{myLName}}[counter].x = math.random(tSearch["{{bn}}"][10], tSearch["{{bn}}"][11])
         layer.{{myLName}}[counter].y = math.random(tSearch["{{bn}}"][12], tSearch["{{bn}}"][13])
    {{/elDistance}}
    {{^elDistance}}
     layer.{{myLName}}[counter].x = tSearch["{{bn}}"][6] + ((counter-1) * tSearch["{{bn}}"][14])
     layer.{{myLName}}[counter].y = tSearch["{{bn}}"][7] + ((counter -1) * tSearch["{{bn}}"][15])
    {{/elDistance}}

    layer.{{myLName}}[counter].alpha = math.random(tSearch["{{bn}}"][16], tSearch["{{bn}}"][17]) / 100
    layer.{{myLName}}[counter].oldAlpha = tSearch["{{bn}}"][8]

    layer.{{myLName}}[counter].xScale = math.random(tSearch["{{bn}}"][18], tSearch["{{bn}}"][19]) / 100

    {{#elScaleLock}}
      layer.{{myLName}}[counter].yScale = layer.{{myLName}}[counter].xScale
    {{/elScaleLock}}
    {{^elScaleLock}}
      layer.{{myLName}}[counter].yScale = math.random(tSearch["{{bn}}"][20], tSearch["{{bn}}"][21]) / 100
    {{/elScaleLock}}

    {{#elphys}}
      local pweight = math.random(tSearch["{{bn}}"][22], tSearch["{{bn}}"][23]);
       physics.addBody(layer.{{myLName}}[counter], "dynamic", {density=pweight, friction=0, bounce=0{{myshape}}});
      {{#elsensor}}
        layer.{{myLName}}[counter].isSensor = true;
      {{/elsensor}}

      local a = pweight * layer.{{myLName}}[counter].xScale;
      layer.{{myLName}}[counter].linearDumping = a;
    {{/elphys}}

    layer.{{myLName}}[counter].myName = "{{myLName}}"
    if layer.gp_{{myLName}} ~= nil then
      layer.gp_{{myLName}}:insert(layer.{{myLName}}[counter])
    end
  -- end

    local function ct_{{myLName}}()
       layer.c_{{myLName}} = layer.c_{{myLName}} + 1
       if composer.mt_{{myLName}} ~= nil then
          composer.mt_{{myLName}}( layer.c_{{myLName}})
       end

       if (layer.c_{{myLName}} == composer.{{myLName}}_m_restart and {{myLName}}_m_loop == 1)  then
          composer.timerStash.mt = timer.performWithDelay( {{elInterval}}, ct_{{myLName}}, {{elCopies}} )
          composer.{{myLName}}_m_restart = layer.c_{{myLName}} + {{myLName}}_m_counter
       end
    end
    composer.timerStash.mt = timer.performWithDelay( {{elInterval}}, ct_{{myLName}}, {{elCopies}} )

  {{/multLayers}}

  {{#hasMutliplier}}
    -- Clean up memory for Multiplier set to forever
    -- control variable to dispose kClean via kNavi
    composer.disposeMultiplier = nil
    composer.kClean = function()
       if composer.disposeMultiplier == 1 then
          -- remove all past listeners
        {{#Multiplier}}
          composer.mt_{{layer}} = nil
          Runtime:removeEventListener("enterFrame", composer.kClean)
        {{/Multiplier}}
        composer.disposeMultiplier = nil
       else
          -- runs normal code
          {{codeMultiplier}}
       end
    end
    Runtime:addEventListener("enterFrame", composer.kClean)
  {{/hasMutliplier}}
end
--
function _M:codeMultiplier()
  for i = 1, composer.{{myLName}}_m_restart do
    if layer.{{myLName}}[i] ~= nil then
      if layer.{{myLName}}[i].y ~= nil then
        if  layer.{{myLName}}[i].y {{aa}} then
          display.remove(layer.{{myLName}}[i])
          layer.{{myLName}}[i]:removeSelf()
          layer.{{myLName}}[i] = nil
        end
      end
    end
  end
end
--
function _M:toDispose()
  {{#hasMutliplier}}
    Runtime:removeEventListener("enterFrame", composer.kClean)
  {{/hasMutliplier}}
end
--
function _M:toDistory()
  {{#multLayers}}
    composer.mt_{{myLName}} = nil
    layer.gp_{{myLName}}:removeSelf()
    layer.gp_{{myLName}} = nil
  {{/multLayers}}
  {{#hasMutliplier}}
    composer.kClean = nil
  {{/hasMutliplier}}
end
--
function _M:localPos()
  layer.gp_{{myLName}} = display.newGroup()
  sceneGroup:insert( layer.gp_{{myLName}})
end
--
function _M:localVars()
end
--
return _M