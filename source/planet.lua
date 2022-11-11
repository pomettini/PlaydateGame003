import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local spritelib <const> = gfx.sprite
local halfScreenWidth <const> = playdate.display.getWidth() / 2
local halfScreenHeight <const> = playdate.display.getHeight() / 2
local tau <const> =  math.pi * 2

-- Extending from sprite even though we're not really using sprites
class("Planet").extends(spritelib)

function Planet:init()
	Planet.super.init(self)
	self:setRadius(0)
	self:setRevolution(0)
	self:setDays(0)
end

function Planet:setRadius(rad)
	self.radius = rad
end

function Planet:setRevolution(rev)
	self.revolution = rev
end

function Planet:setDays(ds)
	self.days = ds
end

function Planet:draw()
	local x = halfScreenWidth + math.sin(self.days / self.revolution * tau) * self.radius
	local y = halfScreenHeight - math.cos(self.days / self.revolution * tau) * self.radius
	
	-- Drawing the orbit
	gfx.drawCircleAtPoint(halfScreenWidth, halfScreenHeight, self.radius)
	-- Drawing planet (black circle)
	gfx.fillCircleAtPoint(x, y, 6)
end
