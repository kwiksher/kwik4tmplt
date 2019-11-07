-- Code created by Kwik - Copyright: kwiksher.com {{year}}
-- Version: {{vers}}
-- Project: {{ProjName}}
--
local _M = {}
--
function _M:playVideo(obj)
    if obj.player then
        if obj.player.playing == nil then
            obj.player:play({loop=obj.loop, onComplete = function()
                    print("completed")
                    if obj.videoListener then
                        obj.videoListener({phase="ended"})
                    end
                    obj.player:stop()
                end
            })
        elseif obj.player.isPaused then
            obj.player:resume()
        end
    else
	obj:play()
end
end
--
function _M:pauseVideo(obj)
    if obj.player then
        obj.player:pause()
    else
	obj:pause()
end
end
--
function _M:rewindVideo(obj)
    if obj.player then
    else
	obj:seek(0)
    end
end
--
function _M:muteVideo(obj)
    obj.isMuted = true
end
--
function _M:unmuteVideo(obj)
    obj.isMuted = false
end
--
return _M