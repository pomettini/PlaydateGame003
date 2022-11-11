import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "planet"

local gfx <const> = playdate.graphics
local spritelib <const> = gfx.sprite
local screenWidth <const> = playdate.display.getWidth()
local screenHeight <const> = playdate.display.getHeight()

local mercury = Planet()
mercury:setRadius(10)
mercury:setRevolution(87.97)

local venus = Planet()
venus:setRadius(20)
venus:setRevolution(224.7)

local earth = Planet()
earth:setRadius(30)
earth:setRevolution(365.26)

local mars = Planet()
mars:setRadius(40)
mars:setRevolution(686.67)

local jupiter = Planet()
jupiter:setRadius(50)
jupiter:setRevolution(4331.865)

local saturn = Planet()
saturn:setRadius(60)
saturn:setRevolution(10760.265)

local uranus = Planet()
uranus:setRadius(70)
uranus:setRevolution(30684.653)

local neptune = Planet()
neptune:setRadius(80)
neptune:setRevolution(60189.5475)

function playdate.update()
	gfx.clear()
	
	mercury:draw()
	venus:draw()
	earth:draw()
	mars:draw()
	jupiter:draw()
	saturn:draw()
	uranus:draw()
	neptune:draw()
end
