-- Story Menu Character Animation Script
-- Plays intro animation when week changes, then loops idle

local curWeek = 0
local lastWeek = -1
local char = nil
local introPlayed = false

function onCreate()
    makeCharacterForWeek(0)
end

function onUpdate(elapsed)
    curWeek = getProperty('storyWeek')

    if curWeek ~= lastWeek then
        lastWeek = curWeek
        introPlayed = false
        makeCharacterForWeek(curWeek)
        playIntroIfExists()
    end
end

---------------------------------------------------------
-- CHARACTER LOADING
---------------------------------------------------------

function makeCharacterForWeek(week)
    if char ~= nil then
        removeLuaSprite('menuChar', true)
    end

    local charName = getCharacterForWeek(week)

    makeAnimatedLuaSprite('menuChar', 'menuChars/'..charName, 900, 150)
    addAnimationByPrefix('menuChar', 'idle', 'idle', 24, true)
    addAnimationByPrefix('menuChar', 'intro', 'intro', 24, false)

    scaleObject('menuChar', 0.9, 0.9)
    setObjectOrder('menuChar', 20)
    addLuaSprite('menuChar', true)

    char = 'menuChar'
end

---------------------------------------------------------
-- WEEK → CHARACTER MAPPING
---------------------------------------------------------

function getCharacterForWeek(week)
    local weekChars = {
        [0] = 'bfMenu',
        [1] = 'gfMenu',
        [2] = 'dadMenu',
        [3] = 'secretMenu'
    }

    return weekChars[week] or 'bfMenu'
end

---------------------------------------------------------
-- INTRO → IDLE ANIMATION LOGIC
---------------------------------------------------------

function playIntroIfExists()
    if not luaSpriteExists(char) then return end

    if hasAnimation(char, 'intro') then
        introPlayed = true
        objectPlayAnimation(char, 'intro', true)

        runTimer('introFinish', getAnimationLength(char, 'intro'))
    else
        objectPlayAnimation(char, 'idle', true)
    end
end

function onTimerCompleted(tag)
    if tag == 'introFinish' and introPlayed then
        objectPlayAnimation(char, 'idle', true)
    end
end

---------------------------------------------------------
-- UTILITY
---------------------------------------------------------

function hasAnimation(sprite, anim)
    return getProperty(sprite..'.animation.exists.'..anim)
end

function getAnimationLength(sprite, anim)
    return getProperty(sprite..'.animation.curAnim.length') or 1
end
