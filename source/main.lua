import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "Corelibs/crank"
import "planet"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound
local spritelib <const> = gfx.sprite
local screenWidth <const> = playdate.display.getWidth()
local screenHeight <const> = playdate.display.getHeight()

-- Const values for UI
local margin <const> = 15
local textHeight <const> = 15

local planets = {}
local currentPlanetId = 3
local currentDay = 0
local scaleFactor = 12
local autoPlay = false
local showUI = true

local mercury = Planet()
mercury:setName("Mercury")
mercury:setRevolution(87.97)
mercury:setPitch("G5") -- 880
table.insert(planets, mercury)

local venus = Planet()
venus:setName("Venus")
venus:setRevolution(224.7)
venus:setPitch("F5") -- 698.456
table.insert(planets, venus)

local earth = Planet()
earth:setName("Earth")
earth:setRevolution(365.26)
earth:setPitch("D5") -- 587.33
table.insert(planets, earth)

local mars = Planet()
mars:setName("Mars")
mars:setRevolution(686.67)
mars:setPitch("A5") -- 783.991
table.insert(planets, mars)

local jupiter = Planet()
jupiter:setName("Jupiter")
jupiter:setRevolution(4331.865)
jupiter:setPitch("C4") -- 261.626
table.insert(planets, jupiter)

local saturn = Planet()
saturn:setName("Saturn")
saturn:setRevolution(10760.265)
saturn:setPitch("E4") -- 329.628
table.insert(planets, saturn)

local uranus = Planet()
uranus:setName("Uranus")
uranus:setRevolution(30684.653)
uranus:setPitch("G4") -- 391.995
table.insert(planets, uranus)

local neptune = Planet()
neptune:setName("Neptune")
neptune:setRevolution(60189.5475)
neptune:setPitch("B4") -- 493.883
table.insert(planets, neptune)

function drawCurrentDayText()
	local x <const> = screenWidth - margin
	local y <const> = screenHeight - margin - textHeight
	local text <const> = "Day " .. currentDay
	
	-- Drawing text on bottom right
	gfx.drawTextAligned(text, x, y, kTextAlignment.right)
end

function drawSelectedPlanetText()
	local x <const> = margin
	local y <const> = screenHeight - margin - textHeight
	local planet <const> = planets[currentPlanetId]
	local name <const> = planet:getName()
	local rev <const> = planet:getRevolutions()
	-- Rounding the revolutions to the last two decimal places
	local text <const> = name .. " " .. string.format("%.2f", rev) .. " orbits"
	
	-- Drawing text on bottom left
	gfx.drawTextAligned(text, x, y, kTextAlignment.left)
end

function drawAutoPlayText()
	-- Text is displayed only if autoplay is active
	if not autoPlay then return end
	
	local x <const> = screenWidth - margin
	local y <const> = margin
	local text <const> = "AutoCrank"
	
	-- Drawing text on top right
	gfx.drawTextAligned(text, x, y, kTextAlignment.right)
end

function playdate.update()
	gfx.clear()
	
	-- playdate.drawFPS(0, 0)
	
	-- One crank spin = earth rotation around the sun
	currentDay += playdate.getCrankTicks(365.26)
	-- With autoplay active every tick the day advances
	if autoPlay then currentDay += 1 end
	
	for i, planet in ipairs(planets) do
		local isSelected = currentPlanetId == i
		planet:setRadius(i * scaleFactor)
		planet:setScale(scaleFactor)
		planet:setDays(currentDay)
		planet:setSelected(isSelected)
		planet:update()
		planet:draw()
		if autoPlay then planet:updateAudio() end
	end
	
	if showUI then
		drawSelectedPlanetText()
		drawCurrentDayText()
		drawAutoPlayText()
	end
end

function playdate.upButtonUp()
	scaleFactor += 1
end

function playdate.downButtonUp()
	scaleFactor -= 1
end

function playdate.leftButtonUp()
	-- If id is -1 it becomes 8 (last planet id)
	-- Sorry for unnecessary complex code
	currentPlanetId = (currentPlanetId % #planets - 2) % #planets + 1
end

function playdate.rightButtonUp()
	-- If id is 9 it becomes 1 (last planet is 8)
	currentPlanetId = currentPlanetId % #planets + 1
end

function playdate.AButtonUp()
	autoPlay = not autoPlay
end

function playdate.BButtonUp()
	showUI = not showUI
	playPlanetAudio()
end
