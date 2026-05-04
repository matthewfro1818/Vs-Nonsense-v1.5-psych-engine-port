function onEvent(name, value1, value2)
    if name ~= 'BlackSquare' then return end
    local alpha = tonumber(value1) or 1
    local dur = tonumber(value2) or 0
    makeLuaSprite('blackSquareEvent', nil, -1000, -1000)
    makeGraphic('blackSquareEvent', 4000, 4000, '000000')
    setObjectCamera('blackSquareEvent', 'other')
    setProperty('blackSquareEvent.alpha', alpha)
    addLuaSprite('blackSquareEvent', true)
    if dur > 0 then doTweenAlpha('blackSquareEventFade', 'blackSquareEvent', 0, dur, 'linear') end
end
function onTweenCompleted(tag) if tag == 'blackSquareEventFade' then removeLuaSprite('blackSquareEvent', true) end end
