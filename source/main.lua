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

local planets = {}
local currentDay = 0
local scaleFactor = 13

local mercury = Planet()
mercury:setRevolution(87.97)
table.insert(planets, mercury)

local venus = Planet()
venus:setRevolution(224.7)
table.insert(planets, venus)

local earth = Planet()
earth:setRevolution(365.26)
table.insert(planets, earth)

local mars = Planet()
mars:setRevolution(686.67)
table.insert(planets, mars)

local jupiter = Planet()
jupiter:setRevolution(4331.865)
table.insert(planets, jupiter)

local saturn = Planet()
saturn:setRevolution(10760.265)
table.insert(planets, saturn)

local uranus = Planet()
uranus:setRevolution(30684.653)
table.insert(planets, uranus)

local neptune = Planet()
neptune:setRevolution(60189.5475)
table.insert(planets, neptune)

function drawCurrentDayText()
	local x = screenWidth - 10
	local y = screenHeight - 25
	local text = "Day " .. tostring(currentDay)
	
	gfx.drawTextAligned(text, x, y, kTextAlignment.right)
end

function playdate.update()
	gfx.clear()
	
	-- playdate.drawFPS(0, 0)
	
	-- One crank spin = earth rotation around the sun
	currentDay += playdate.getCrankTicks(365.26)
	
	for i, planet in ipairs(planets) do
		planet:setRadius(i * scaleFactor)
		planet:setDays(currentDay)
		planet:draw()
	end
	
	drawCurrentDayText()
end

function playdate.upButtonUp()
  scaleFactor += 1
end

function playdate.downButtonUp()
  scaleFactor -= 1
end
