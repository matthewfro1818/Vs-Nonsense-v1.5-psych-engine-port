function onEvent(name, value1, value2)
    if name ~= 'Set Cam Zoom' then return end
    local zoom = tonumber(value1) or getProperty('defaultCamZoom')
    local dur = tonumber(value2) or 0
    if dur <= 0 then setProperty('defaultCamZoom', zoom) else doTweenZoom('vsliceZoomEvent', 'camGame', zoom, dur, 'quadOut') end
end
