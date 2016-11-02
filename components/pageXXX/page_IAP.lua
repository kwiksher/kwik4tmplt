-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
local _K = require "Application"
local composer = require("composer")
local store = require ( "store" ) -- Available in Corona build #261 or later
---------------------
---------------------
{{#inApp}}
    -- see iap(myi).jsx
    -- In-app purchase
    local listOfProducts = {
        {{#prod}}
          "{{pID}}",
        {{/prod}}
    }
    ----------------------------------
    -- In-App area
    ----------------------------------
    local validProducts, invalidProducts = {}, {}

    function unpackValidProducts()
        print ("Loading product list")
        if not validProducts then
            native.showAlert( "In-App features not available", "initStore() failed", { "OK" } )
        else
            for i=1, #invalidProducts do
                native.showAlert( "Item " .. invalidProducts[i] .. " is invalid.",{ "OK" } )
            end

        end
    end

    function loadProductsCallback( event )
        validProducts = event.products
        invalidProducts = event.invalidProducts
        unpackValidProducts ()

    end

    function savePurchase(product)
        local files = product..".txt"
        local path = system.pathForFile( files, system.DocumentsDirectory )
        local file = io.open( path, "r" )
        if file then
            io.close( file )
        else
            local path = system.pathForFile( files, system.DocumentsDirectory )
            local file = io.open( path, "w+b" )
            file:write( "ok" )
            io.close( file )
        end
    end

    function cancelPurchase(product)
        local files = product..".txt"
        local path = system.pathForFile( files, system.DocumentsDirectory )
        local file = io.open( path, "r" )
        if file then
          --local path = system.pathForFile( files, system.DocumentsDirectory )
          local file = io.open( path, "w+b" )
            file:write( "canceled" )
            io.close( file )
        else
            io.close( file )
        end
    end

    function transactionCallback( event )
        if event.transaction.state == "purchased" then
          {{#body}}
          if event.transaction.productIdentifier == "{{productIdentifier}}" then
            savePurchase("{{product}}")
          end
          {{/body}}
        elseif event.transaction.state == "restored" then
          {{#body}}
          if event.transaction.productIdentifier == "{{productIdentifier}}" then
             savePurchase("{{product}}")
          end
          {{/body}}
        elseif event.transaction.state == "refunded" then  -- NEW FOR GOOGLE PLAY STORE
          {{#body}}
          if event.transaction.productIdentifier == "{{productIdentifier}}" then
            cancelPurchase(transaction.productIdentifier)
           end
          {{/body}}
        elseif event.transaction.state == "cancelled" then
        elseif event.transaction.state == "failed" then
            infoString = "Transaction failed, type: ".." ".. event.transaction.errorType.." ".. event.transaction.errorString
            local alert = native.showAlert("Failed ", infoString,{ "OK" })
        else
            infoString = "Unknown event"
            local alert = native.showAlert("Unknown ", infoString,{ "OK" })
        end
        store.finishTransaction( event.transaction )
    end

    function setupMyStore (event)
        store.loadProducts( listOfProducts, loadProductsCallback )
    end
{{/inApp}}

function _M:localPos(UI)
    local sceneGroup  = UI.scene.view
    local layer       = UI.layer
{{#inApp}}
    if store.availableStores.apple then
        store.init("apple", transactionCallback)
    elseif store.availableStores.google then
        store.init("google", transactionCallback)
    end
    _K.timerStash.timer_IAP1 = timer.performWithDelay (1000, setupMyStore)
{{/inApp}}
end
--
function _M:toDispose()
end

function _M:willHide()
end

--
function _M:localVars()
end
--
function _M:allListeners()
  {{#lockPage}}
    -- Protected IAP page \r\n'
    local path = system.pathForFile ("{{file}}", system.DocumentsDirectory )
    -- protect_1
    local file = io.open( path, "r" )
    local setGo = 0
    if file then
        --This page was purchased
        for line in io.lines( path ) do
            if ( line == "ok" or line=="1" ) then
                setGo = 1
            end
        end
        io.close( file )
    end
    if (setGo == 0) then
        --Page restricted. Send to pageError
        local infoString = "This page needs to be purchased."
        local function onComplete( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    -- dispose()
                    if nil~= composer.getScene("{{pError}}") then
                      composer.removeScene("{{pError}}", true)
                    end
                    composer.gotoScene("{{pError}}", { effects = "fromLeft" } )
    -- protect_2
                end
             end
        end
        local alert = native.showAlert("Restricted Content", infoString,{ "OK" }, onComplete)
    end
  {{/lockPage}}
end
--
return _M