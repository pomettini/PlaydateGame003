import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound
local spritelib <const> = gfx.sprite
local halfScreenWidth <const> = playdate.display.getWidth() / 2
local halfScreenHeight <const> = playdate.display.getHeight() / 2
local tau <const> =  math.pi * 2

-- Extending from sprite even though we're not really using sprites
class("Planet").extends(spritelib)

function Planet:init()
	Planet.super.init(self)
	self:setName("")
	self:setRadius(0)
	self:setScale(0)
	self:setRevolution(0)
	self:setDays(0)
	self:setPitch("")
	self:setSelected(false)
	
	self.synth = snd.synth.new(snd.kWaveTriangle)
	self.synth:setDecay(0.5)
	self.synth:setSustain(0.6)
	self.synth:setRelease(1.0)
end

function Planet:setName(name)
	self.name = name
end

function Planet:setRadius(rad)
	self.radius = rad
end

function Planet:setScale(scale)
	self.scale = scale
end

function Planet:setRevolution(rev)
	self.revolution = rev
end

function Planet:setDays(days)
	self.days = days
end

function Planet:setSelected(sel)
	self.selected = sel
end

function Planet:setPitch(pitch)
	self.pitch = pitch
end

function Planet:getName()
	return self.name
end

function Planet:getRevolutions()
	return self.days / self.revolution
end

function Planet:getPitch()
	return self.pitch
end

function Planet:updateAudio()
	if math.floor(self.days % self.revolution) == 0 then
		self.synth:playNote(self.pitch, 0.5, 1)
	end
end

function Planet:update()
	self.scaleHalf = self.scale / 2
	self.scaledDays = self.days / self.revolution
end

function Planet:draw()
	local x <const> = halfScreenWidth + math.sin(self.scaledDays * tau) * self.radius
	local y <const> = halfScreenHeight - math.cos(self.scaledDays * tau) * self.radius
	-- Ternary operator in Lua
	local color <const> = self.selected and gfx.kColorWhite or gfx.kColorBlack
	
	-- Drawing the orbit
	gfx.drawCircleAtPoint(halfScreenWidth, halfScreenHeight, self.radius)
	-- Drawing the inner part of the planet
	gfx.setColor(color)
	gfx.fillCircleAtPoint(x, y, self.scaleHalf)
	-- Drawing the outer part of the planet
	gfx.setColor(gfx.kColorBlack)
	gfx.drawCircleAtPoint(x, y, self.scaleHalf)
end
