import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local spritelib <const> = gfx.sprite
local screenWidth <const> = playdate.display.getWidth()
local screenHeight <const> = playdate.display.getHeight()

class("Planet").extends(spritelib)

function Planet:init()
	Planet.super.init(self)
	self.time = 0
end

function Planet:setRadius(rad)
	self.radius = rad
end

function Planet:setRevolution(rev)
	self.revolution = rev
end

function Planet:draw()
	local x = screenWidth / 2 + math.sin(self.time / self.revolution) * self.radius
	local y = screenHeight / 2 - math.cos(self.time / self.revolution) * self.radius
	
	gfx.drawCircleAtPoint(screenWidth / 2, screenHeight / 2, self.radius)
	gfx.fillCircleAtPoint(x, y, 5)
	
	self.time += 10
end
