local gen = 100000000
local detc = peripheral.find("energyDetector")
local us = detc.getTransferRate()


local mon = peripheral.find("monitor")
mon.clear()

local conv = require("powerconvert")

local scale = 1.5
mon.setCursorPos(1, 8)
mon.setTextScale(scale)
local mx, my = mon.getSize()
local dent = mx - 17


sleep(1)

local gentx = "Generating:"
local ustx  = "Currentlly using:"
local pctx  = "Percentage used:"

local function drawLine(x, y, length, color, Monitor, width)
    local oldBgColor = Monitor.getBackgroundColor()
    local oldScale = Monitor.getTextScale()
    if width ~= oldScale then
        w = width * (oldScale / width)
    end
    Monitor.setTextScale(w)                   --Gets the current background color
    for i = x, (length + x) do                --Starts a for loop starting at x and ending when x gets to x + length
        Monitor.setCursorPos(i, y)            --Set the cursor position to i,y
        Monitor.setBackgroundColor(color)     --Set the background color to the color
        Monitor.write("-")                    --Write that color to the screen
    end
    Monitor.setBackgroundColor(oldBgColor)    --Reset the background color
    Monitor.setTextScale(oldScale)
end                                           ---function to draw a Line on the Monitor

local function DrawBar(x, y, color1, color2, BarMax)
    getPercentages(Stored_items)
    barProgress = math.floor(percentRaw / 100 * BarMax)
    if percentRaw > 80 then
        color2 = colors.red
    end
    Monitor.clear()
    drawLine(x, y, BarMax, color1)      --Draws the bar
    drawLine(x, y, barProgress, color2) --Draws the colored part over the bar
end                                     ---Handles all Operations needed to display a Progess Bar

local function write(x, y, text, Monitor, color)
    ---Error handling
    if color == nil then
        color = colors.white
    end
    ---main function part
    Monitor.setCursorPos(x, y)
    Monitor.setTextColour(color)
    Monitor.write(text)
    Monitor.setTextColour(colors.white)
end ---writes stuff on the monitor with the given position and color

function w_all(m1, m2, m3, dent, Monitor)
    if perc > 80 then 
        col = colors.red
    else
        col = colors.green
    end        
    write(dent, 2, m1, Monitor, colors.yellow)
    write(dent, 4, m2, Monitor, colors.orange)
    write(dent, 6, m3, Monitor, col)
end

local mesgfe = gen .. "fe/t"
local geu = conv.teu(gen)
local mesgeu = geu .. "eu/t"

local mesufe = us .. "fe/t"
local ueu = conv.teu(us)
local mesueu = ueu .. "eu/t"

perc = us / gen * 100
local mesperc = perc .. "%"
while true do
    mon.clear()
    w_all(mesgfe, mesufe, mesperc, dent, mon)
    drawLine(1, 1, mx, colors.black, mon, 0.5)
    drawLine(1, 8, mx, colors.black, mon, 0.5)

    write(2, 2, gentx, mon)
    write(2, 4, ustx, mon)
    write(2, 6, pctx, mon)

    sleep(15)


    mon.clear()
    write(2, 2, gentx, mon)
    write(2, 4, ustx, mon)
    write(2, 6, pctx, mon)

    drawLine(1, 1, mx, colors.black, mon, 0.5)
    drawLine(1, 8, mx, colors.black, mon, 0.5)
    w_all(mesgeu, mesueu, mesperc, dent, mon)
    sleep(15)
end
