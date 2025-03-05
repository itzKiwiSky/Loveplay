local LPASSETS = (...):match('(.-)[^/]+$')
local vec2 = import 'Math.Vec2'
local Color = import 'Utils.Color'

--- Drawable component
---@type Drawable

local DrawableComponent = {}
DrawableComponent.__index = DrawableComponent

function DrawableComponent.new()
    local self = setmetatable({}, DrawableComponent)

    self.drawable = love.graphics.newImage(LPASSETS .. "/icon.png")
    self.scale = vec2(1, 1)
    self.origin = vec2.ZERO()
    self.shear = vec2.ZERO()
    self.rotation = 0
    self.color = Color.WHITE

    return self
end

function DrawableComponent:__draw()
    local oldColor = { love.graphics.getColor() }
    love.graphics.setColor(self.color)
        love.graphics.draw(
            self.drawable, 
            self.pos.x, self.pos.y, math.rad(self.rotation), 
            self.scale.x, self.scale.y, self.shear.x, self.shear.y
        )
    love.graphics.setColor(oldColor)
end

return setmetatable(DrawableComponent, { __call = function(_, ...) return DrawableComponent.new(...) end})