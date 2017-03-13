local M = {}
--
local zip = require( "plugin.zip" )
local spinner = require("components.store.spinner").new("download server")
local queue = require("extlib.queue")
local model = require("components.store.model")
--
local onDownloadComplete
local onDownloadError
-- local selectedPurchase
local downloadQueue
--
local URL       = model.URL
local filename = "/assets.zip"
--
local function zipListener( event, deferred , selectedPurchase)
    if ( event.isError ) then
        print( "Unzip error" )
        onDownloadError(selectedPurchase, "Unzip error")
        deferred:reject()
    else
        print( "event.name:" .. event.name )
        print( "event.type:" .. event.type )
        if ( event.response and type(event.response) == "table" ) then
            for i = 1, #event.response do
                print( event.response[i] )
            end
            -- local selectedPurchase = event.response[1]
            -- selectedPurchase = selectedPurchase:sub(1, selectedPurchase:len()-1)
            print("zipListener:"..selectedPurchase)
            onDownloadComplete(selectedPurchase)
        end
        deferred:resolve()
    end
    spinner:remove()
end
--
local function networkListener(event, deferred, selectedPurchase)
    if ( event.isError ) then
        print( "Network error - download failed" )
        onDownloadError(selectedPurchase, "Network error - download failed")
        deferred:reject()
    elseif ( event.phase == "began" ) then
        print( "Progress Phase: began" )
        spinner:show()
    elseif ( event.phase == "ended" ) then
        spinner:remove()
        if ( math.floor(event.status/100) > 3 ) then
            print( "Network error - download failed", event.status )
            onDownloadError(selectedPurchase, event.status)
            deferred:reject()
            --NOTE: 404 errors (file not found) is actually a successful return,
            --though you did not get a file, so trap for that
        else
            local options = {
                zipFile = event.response.filename,
                zipBaseDir = event.response.baseDirectory,
                -- dstBaseDir = system.DocumentsDirectory,
                dstBaseDir = system.ApplicationSupportDirectory,
                listener = function(event) zipListener(event, deferred, selectedPurchase) end,
            }
            spinner:show()
            zip.uncompress(options)
        end
    end
end
-- 
--
local function _startDownload(selectedPurchase)
    local deferred = Deferred()
    local path = system.pathForFile(selectedPurchase..".zip", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
    if fh then
        io.close( fh )
        local options = {
            zipFile = selectedPurchase..".zip",
            zipBaseDir = system.TemporaryDirectory,
            -- dstBaseDir = system.DocumentsDirectory,
            dstBaseDir = system.ApplicationSupportDirectory,
            listener = function(event) zipListener(event, deferred, selectedPurchase) end,
        }
        spinner:show()
        zip.uncompress(options)
    else
        local url = URL ..selectedPurchase..filename
        print(url)
        local params    = {}
        params.progress = true
        network.download( url, "GET", function(event)
                networkListener(event, deferred, selectedPurchase)
            end,
            params, selectedPurchase..".zip", system.TemporaryDirectory )
    end
    return deferred:promise()
end

function M.hasDownloaded(epsode)
    local path = system.pathForFile( model.epsodes[epsode].dir, system.ApplicationSupportDirectory )
    -- io.open opens a file at path. returns nil if no file found
    local fh, reason = io.open( path.."/version.txt", "r" )
    if fh then
        io.close( fh )
        return true
    else
        return false
    end
end

function M:init(onSuccess, onError)
    onDownloadComplete = onSuccess
    onDownloadError    = onError
    downloadQueue = queue.new()
    Runtime:addEventListener("downloadManager:purchaseCompleted", function(event)
        local selectedPurchase = event.target
        if M.hasDownloaded(selectedPurchase) then
            onDownloadComplete(selectedPurchase)
        else
            downloadQueue:offer(selectedPurchase)
        end
    end)
end

function M:startDownload(epsode)
    local selectedPurchase = epsode or downloadQueue:poll()
    if selectedPurchase then
        print("startDownload:"..selectedPurchase)
        promise = _startDownload(selectedPurchase)
            :done(function()
                    self:startDownload()
                end)
            :fail(function(error)
                end)
            :always(function()
                end)
    end
end

return M
