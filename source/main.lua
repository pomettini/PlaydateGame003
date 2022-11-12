import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "Corelibs/crank"
import "planet"

local gfx <const> = playdate.graphics
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
local autoPlaySpeed = 0

local mercury = Planet()
mercury:setName("Mercury")
mercury:setRevolution(87.97)
table.insert(planets, mercury)

local venus = Planet()
venus:setName("Venus")
venus:setRevolution(224.7)
table.insert(planets, venus)

local earth = Planet()
earth:setName("Earth")
earth:setRevolution(365.26)
table.insert(planets, earth)

local mars = Planet()
mars:setName("Mars")
mars:setRevolution(686.67)
table.insert(planets, mars)

local jupiter = Planet()
jupiter:setName("Jupiter")
jupiter:setRevolution(4331.865)
table.insert(planets, jupiter)

local saturn = Planet()
saturn:setName("Saturn")
saturn:setRevolution(10760.265)
table.insert(planets, saturn)

local uranus = Planet()
uranus:setName("Uranus")
uranus:setRevolution(30684.653)
table.insert(planets, uranus)

local neptune = Planet()
neptune:setName("Neptune")
neptune:setRevolution(60189.5475)
table.insert(planets, neptune)

function drawCurrentDayText()
	local x = screenWidth - margin
	local y = screenHeight - margin - textHeight
	local text = "Day " .. currentDay
	
	-- Drawing text on bottom right
	gfx.drawTextAligned(text, x, y, kTextAlignment.right)
end

function drawSelectedPlanetText()
	local x = margin
	local y = screenHeight - margin - textHeight
	local planet = planets[currentPlanetId]
	local name = planet:getName()
	local rev = planet:getRevolutions()
	-- Rounding the revolutions to the last two decimal places
	local text = name .. " " .. string.format("%.2f", rev) .. " orbits"
	
	-- Drawing text on bottom left
	gfx.drawTextAligned(text, x, y, kTextAlignment.left)
end

function drawAutoPlaySpeedText()
	-- Text is displayed only if autoplay is active
	if autoPlaySpeed == 0 then return end
	
	local x = screenWidth - margin
	local y = margin
	local text = "AutoCrank " .. autoPlaySpeed
	
	-- Drawing text on top right
	gfx.drawTextAligned(text, x, y, kTextAlignment.right)
end

function playdate.update()
	gfx.clear()
	
	-- playdate.drawFPS(0, 0)
	
	-- One crank spin = earth rotation around the sun
	currentDay += playdate.getCrankTicks(365.26)
	currentDay += autoPlaySpeed
	
	for i, planet in ipairs(planets) do
		local isSelected = currentPlanetId == i
		planet:setRadius(i * scaleFactor)
		planet:setScale(scaleFactor)
		planet:setDays(currentDay)
		planet:setSelected(isSelected)
		planet:draw()
	end
	
	drawSelectedPlanetText()
	drawCurrentDayText()
	drawAutoPlaySpeedText()
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
	autoPlaySpeed += 1
end

function playdate.BButtonUp()
	autoPlaySpeed -= 1
end
