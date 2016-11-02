-- Electric Eggplant's Synchronied Text to Speech framework
-- version 2.2 - includes read right to left, fixes highlight
-- version 2.3 (1/3/12) - do not play synced when in "I will read" mode (requires kwk_readMe = 1 to play)
-- version 2.4 (2/11/12) - added audio channel to avoid multiple plays
-- version 2.5 (3/26/12) - fix issue when user keeps pressing the play button
-- version 3 - for K2 (4/15/12) - fixes several issues, accept channel, volume and delay
-- version 3.1 - for K2 (5/27/12) - plays word clicking and adds animation (zoomOut) to each click
-- version 3.2 - for K2 (7/22/12) - plays with loadStream, receives channel
-- version 3.3 - for Kwik 2 (10/11/12) - new play word process - now requires another parameter: file="name of the file"
-- version 3.4 - for Kwik 2 (12/25/12) - play an option action for each word requires another parameter: trigger="name of the action"
-- version 3.5 - for Kwik 2 (3/25/13) - only play sentence if object still exists
-- version 3.6 - for Kwik 3 (3/24/14) - hides/shows sentence and button with fade duration
-- version 3.7 - for Kwik 3 (4/21/14) - re-calculates positioning in textGroup for right positions when in groups
-- version 3.8 - for Kwik 3 (5/1/14) - re-calculates the fade in duration (transTime) accordingly
-- version 3.9 - for Kwik 3 (5/9/14) - sets the right position of text
-- version 3.10 - for Kwik 3 (9/22/14) - save and set the talkbutton alpha after playing the sentence

module(..., package.seeall)
local _K = require "Application"

local fadeInDur = 100
local fadeOutDur = 100
local channel = 32
local _wait = 0 --(delay)
local _volume = 1


-- Using the sentence table, display the text by creating an object for each word
local function displayText(params)
--print("step 2 - write words ")
	local line, x,y,font,fontSize,fontColor,fontColorHi,group, wordTouch, lang= params.line, params.x, params.y, params.font, params.fontSize, params.fontColor, params.fontColorHi, params.group, params.wordTouch, params.lang
	local xOffset = 0
	local words={}
	local lineHeight = fontSize*1.33
	local space = fontSize/5
	local name = ""
	local dir = params.sentenceDir .. "_words/"
	local readDir = "leftToRight"
	if params.readDir then
		readDir = params.readDir
	end

	local newX

	for i = 1,#line do
	  words[i] = display.newText(line[i].name, 0, 0, font, fontSize)
	  words[i]:setFillColor( fontColor[1],fontColor[2],fontColor[3])
	  words[i].alpha = 1
	  words[i].activeText = display.newText(line[i].name, 0,0, font, fontSize)
	  words[i].activeText:setFillColor( fontColorHi[1],fontColorHi[2],fontColorHi[3])
	  words[i].activeText.alpha = 0
	  group:insert(words[i],true)
	  group:insert(words[i].activeText,true)
	  if readDir == "leftToRight" then
		  --words[i]:setReferencePoint(display.TopLeftReferencePoint)
		  --words[i].activeText:setReferencePoint(display.TopLeftReferencePoint)

		  --compatibility with Graphics 2.0
		  words[i].anchorX = 0; words[i].anchorY = 0
		  words[i].activeText.anchorX = 0; words[i].activeText.anchorY = 0

		  newX = x+xOffset
	  else
		  --words[i]:setReferencePoint(display.TopRightReferencePoint)
		  --words[i].activeText:setReferencePoint(display.TopRightReferencePoint)

		  --compatibility with Graphics 2.0
		  words[i].anchorX = 1; words[i].anchorY = 0
		  words[i].activeText.anchorX = 1; words[i].activeText.anchorY = 0

	  	  newX = x-xOffset
	  end
      words[i].x = newX
	  words[i].y = y
	  words[i].activeText.x = newX
	  words[i].activeText.y = y

	  words[i].trigger = line[i].trigger



--[[ REVIEW THIS WHEN ENABLE THE PLAY AUDIO PER WORD --]]
	  -- convert to lower case and remove punctuation from name so we can use it
	  -- to load correct audio file

	  if wordTouch then
  		name = string.lower(string.gsub(line[i].file, "['., ]", ""))
--print("check individual files and languages")
----print("name: "..name)
		if (name=="" or name==nil) then
		else
		  if (lang=="") then
		  	words[i].snd = audio.loadSound(_K.audioDir..name ..".mp3")
		  else
		  	words[i].snd = audio.loadSound(_K.audioDir..lang.."_"..name ..".mp3")
		  end
		  words[i].id = i
		  --  calculate the duration of each word
		  words[i].dur = line[i].dur

		  --new in 2.0.11
		  words[i].fil = line[i].file
----print("file: "..words[i].fil)

		  if params.addListner then
				words[i]:addEventListener( "tap", speakWord )
		  end
		end --if name
	  end --if wordTouch

	  xOffset = xOffset + words[i].width + space
	  if line[i].newline then y = y + lineHeight; xOffset = 0 end
	end
	line.soundLength = line[#line].out

	return words
end

-- Add a button to start the talking
local function displayButton(params)
	local x,y,w,h,color = params.x, params.y, params.w, params.h, params.color
	local rect = display.newRect(x, y, w, h)
	rect:setFillColor(color[1],color[2],color[3])
	return rect
end


local talkButton_oriAlpha

function saySentence( params )
--print("step 3 - plays the audio")
    if (_K.kwk_readMe==0) then
        return
    else
        local button = params.button
        local text = button.text
        local sentence, line, delay1, delay2, trans1, trans2 = params.sentence, params.line, 0,0,fadeInDur,fadeOutDur

        local transOut = button.transOut
        local transIn = button.transIn

 	--print("saySentence channel",channel)
        local isChannelPlaying = audio.isChannelPlaying(channel)
        if isChannelPlaying then
            --nothing
        else
        	if (sentence) then
            	local syncClosure = function()
						audio.rewind(sentence)
						--audio.rewind(channel)
						audio.setVolume(_volume, {channel=channel})
						audio.play(sentence, {channel=channel})
       			-- fade button so it's not touchable
                    transition.to(button, { time=trans2, delay=0, alpha=.01 } )
                    transition.to(button, { time=trans2, delay=line.soundLength+trans1, alpha=talkButton_oriAlpha } )

                    local loops = math.floor(line.soundLength/1000*3.4)
                    if button.animation then
                        button:setSpeed(.2)			-- use .4 if we're running at 30fps
                        button:play{startFrame=2, endFrame=button.numChildren, loop=loops}
                    end
                    for i = 1,#line do
                        -- start transition early so it's full red by the time the word is spoken
                        delay1 = line[i].start - trans1
                        if delay1 <0 then delay1 = 0 end
                        -- add extra time at the end so we never finish before the fade is complete
                        delay2 = line[i].out + trans2

                        -- rather than using dissolve, which looks choppy, let's just fade in the highlight
                        -- text that's sitting on top of the black text.
                        transition.to(text[i].activeText, { delay = delay1, alpha = 1, time=trans1 } )
                        transition.to(text[i].activeText, { delay = delay2, alpha = 0, time=trans2 } )
                --		transOut[i]=transition.dissolve(text[i],text[i].activeText,trans1,delay1)
                --		transIn[i]=transition.dissolve(text[i].activeText,text[i],trans2,delay2)

                 		--run trigger action
                		if text[i].trigger ~= nil then
                			_K.timerStash['syncSoundTrigger'..i] = timer.performWithDelay( line[i].start, text[i].trigger)
                		end

                    end
   	      		end --syncClosure
    	  	    _K.timerStash.syncTimer = timer.performWithDelay(_wait, syncClosure)
        end --sentence

		end  -- isChannelPlaying
    end --if kwkReadme
end --saySentence

-- The button was pressed, so start talking. Highlight each word as it's spoken.
local function touchSentence(event)
--print("step 4 - play on request")
	local button = event.target
	local text = button.text
	-- trans1 = how long of a fade from normal to highlighted text
	-- trans2 = how long of a fade back from highlight to normal
	local sentence, line, delay1, delay2, trans1, trans2 = button.sentence, button.line, 0,0,fadeInDur,fadeOutDur
	if button.alpha < 1 then return true end

	local isChannelPlaying = audio.isChannelPlaying(channel)
	if isChannelPlaying then
		--nothing
	else
 	--print("touchSentence channel",channel)
    --audio.rewind(sentence)
    	audio.rewind(channel)
		audio.setVolume(_volume, {channel=channel})
		audio.play(sentence, {channel=channel})

		-- fade button so it's not touchable
		transition.to(button, { time=trans2, delay=0, alpha=.9 } )
		transition.to(button, { time=trans2, delay=line.soundLength+trans1, alpha=1 } )
		local loops = math.floor(line.soundLength/1000*3.4)
		if button.animation then
			button:setSpeed(.2)			-- use .4 if we're running at 30fps
			button:play{startFrame=2, endFrame=button.numChildren, loop=loops}
		end

		for i = 1,#line do
			-- start transition early so it's full red by the time the word is spoken
			delay1 = line[i].start - trans1
			if delay1 <0 then delay1 = 0 end
			-- add extra time at the end so we never finish before the fade is complete
			delay2 = line[i].out + trans2

			-- rather than using dissolve, which looks choppy, let's just fade in the highlight
			-- text that's sitting on top of the black text.
			transition.to(text[i].activeText, { delay = delay1, alpha = 1, time=trans1 } )
			transition.to(text[i].activeText, { delay = delay2, alpha = 0, time=trans2 } )
	--		transition.dissolve(text[i],text[i].activeText,trans1,delay1)
	--		transition.dissolve(text[i].activeText,text[i],trans2,delay2)

	            --run trigger action
                if text[i].trigger ~= nil then
                	_K.timerStash['syncSoundTrigger'..i] = timer.performWithDelay( line[i].start, text[i].trigger)
                end

		end
	end
end

-- A word was touched, so say it now. Disabled during speech.
function speakWord( event )

	local word = event.target
 	local id, snd, dur, dir, fil = word.id, word.snd, word.dur, word.dir, word.fil

 	local trans = fadeInDur
 	local trans2 = fadeOutDur
 	-- was the sentence button pushed or this word already active? If so, return now.
 	--if button1.alpha == 0 or word.alpha ~= 1 then return end
 	-- make sure the duration is at least longer than 2 transition times

 	dur = dur + 2*trans

 	local isChannelPlaying = audio.isChannelPlaying(channel)
    if isChannelPlaying or snd==nil then
            --nothing
    else
       	audio.play(snd, {  channel=channel } )
       	--Moves main and colored words
       	transition.to(word, { y=word.y-10, time=trans, alpha = 1, xScale = 1.1, yScale = 1.1 } )
       	transition.to(word.activeText, { y=word.activeText.y-10, time=trans, alpha = 1, xScale = 1.1, yScale = 1.1 } )
       	-- Returns to original positions
		transition.to(word.activeText, { y=word.activeText.y,delay = dur, alpha = 0, time=trans2, xScale = 1, yScale = 1 } )
		transition.to(word, { y=word.y,delay = dur, alpha = 1, time=trans2, xScale = 1, yScale = 1  } )
    end

	--audio.play(snd)

	-- rather than using dissolve, which looks choppy, let's just fade in the highlight
	-- text that's sitting on top of the black text.
	--transition.to(word.activeText, { delay = 0, alpha = 1, time=trans } )
	--transition.to(word.activeText, { delay = dur, alpha = 0, time=trans2 } )
--	transition.dissolve(word,word.activeText,trans,0)
--	transition.dissolve(word.activeText,word,trans,dur)
	return true
end

function addSentence(params)
--print("step 1 - prepares to display the text")
	local textGroup = display.newGroup()
	textGroup.anchorX = 0.5; textGroup.anchorY = 0.5; -- version 3.7
    textGroup.anchorChildren = true -- version 3.7

	local transTime = 1 --1000  -- version 3.8
	if params.fadeDuration then
		transTime = params.fadeDuration / 1000 -- version 3.8
	end

	local talkButton = params.button
	local talkButtonAnimation = false
	if params.talkButtonAnimation and talkButton.numChildren then
		talkButton.animation = params.talkButtonAnimation
	end

	--NEW IN VERSION 3
	if params.channel then
		channel = params.channel
	end
	if params.delay then
		_wait = params.delay * 1000
	end
	if params.volume then
		_volume = params.volume / 10
	end

	local buttonX
	if params.buttonX then
		buttonX = params.buttonX
	end
	local buttonY
	if params.buttonY then
		buttonY = params.buttonY
	end
	local buttonInclude = false		-- should the talk button be adjacent to the text?
	if params.buttonInclude then
		buttonInclude = params.buttonInclude
	end

	local font = "Arial"					-- default to Arial
	if params.font then
		font = params.font
	end
	local fontColor = {0,0,0}			-- default to black font
	if params.fontColor then
		fontColor = params.fontColor
	end
	local fontSize = 24						-- default size is 24
	if params.fontSize then
		fontSize = params.fontSize
	end
	local fontColorHi = {255,0,0}	-- default to red highlighting font color
	if params.fontColorHi then
		fontColorHi = params.fontColorHi
	end
	local padding = 20
	if params.padding then
		padding = params.padding
	end

	local leftPadding = 0
	if buttonInclude then
		leftPadding = talkButton.width
	end
	local fontOffset = 0
	if params.fontOffset then
		fontOffset = params.fontOffset
	end
	local backgroundRectAlpha = 0
	if params.backgroundRectAlpha then
		backgroundRectAlpha = params.backgroundRectAlpha
	end
	local backgroundRectColor = {255,255,255}
	if params.backgroundRectColor then
		backgroundRectColor = params.backgroundRectColor
	end
	local readDir = "leftToRight"
	if params.readDir then
		readDir = params.readDir
	end

	----print(readDir)


--[[	if not escapeButton.isHitTestable then transTime = 0 end 		-- bring up sentence immeditately since we've escaped out of the intro
--]]
	talkButton:addEventListener( "tap", touchSentence )

	talkButton.sentence = params.sentence				-- name of audio file to use
	talkButton.line = params.line								-- array holding timings and words

	-- display the text
	talkButton.text = displayText{line=params.line,sentence=params.sentence,sentenceDir=params.sentenceDir,
																x=params.x+padding+leftPadding,y=params.y+padding+fontOffset, font=font, fontColor=fontColor, fontSize=fontSize, addListner=true, fontColorHi=fontColorHi,
																group=textGroup, wordTouch=params.wordTouch, readDir=readDir, lang = params.lang}
	talkButton.transIn = {}
	talkButton.transOut = {}
	if backgroundRectAlpha > 0 then
		local backgroundRect = display.newRoundedRect(params.x, params.y, textGroup.width + padding*2 + leftPadding, textGroup.height + padding*2, 12)
		backgroundRect:setFillColor(backgroundRectColor[1],backgroundRectColor[2],backgroundRectColor[3])
		backgroundRect.alpha = backgroundRectAlpha
		textGroup:insert(1,backgroundRect)
	end

	if buttonInclude then
		textGroup:insert(talkButton,true)
		--talkButton:setReferencePoint(display.CenterLeftReferencePoint)
		talkButton.x, talkButton.y = params.x+10,params.y+backgroundRect.height/2
	end


	textGroup.alpha = 0
	talkButton_oriAlpha = talkButton.alpha --3.10
	-- print ("talkButton_oriAlpha "..talkButton_oriAlpha)
	talkButton.alpha = 0 --3.6 editing

    ----3.6 editing
	--transition.to( textGroup, { time=transTime, alpha=1 } )
	_K.timerStash.timer_ss1 = timer.performWithDelay( transTime * 1000, function()
         transition.to( textGroup, { time=transTime, alpha=1 } )
         transition.to( talkButton, { time=transTime, alpha=talkButton_oriAlpha } ) --3.10
         if buttonInclude then
           transition.to( talkButton, { time=transTime, alpha=1 } )
		 end
    end)

   -- version 3.7 / 3.8
   	if talkButton.name ~= nil then
   		textGroup.x = params.x + textGroup.width / 2; textGroup.y = params.y + textGroup.height / 2;
   	else
  		textGroup.x = params.x + 30 + textGroup.width / 2; textGroup.y = params.y + textGroup.height / 2;
  	end

	return talkButton, textGroup

end
