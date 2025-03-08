local LPASSETS = (...):match('(.-)[^/]+$')
local vec2 = import 'Math.Vec2'
local Color = import 'Utils.Color'
--[[
--- Drawable component
---@type Drawable
local DrawableComponent = {}
DrawableComponent.__index = DrawableComponent

function DrawableComponent.new()
    local self = setmetatable({}, DrawableComponent)

    self.drawable = Loveplay.assets.get(Loveplay.assets.assetType.IMAGE, "logo")
    self.scale = vec2(1, 1)
    self.origin = vec2.ZERO
    self.shear = vec2.ZERO
    self.rotation = 0
    self.color = Color.WHITE

    return self
end

function DrawableComponent:centerOrigin()
    local dw, dh = self.drawable:getDimentions()
    self.origin = vec2(dw / 2, dh / 2)
end

function DrawableComponent:__draw()
    local oldColor = { love.graphics.getColor() }
    love.graphics.setColor(self.color)
        if self.drawable then
            love.graphics.draw(
                self.drawable, 
                self.pos.x, self.pos.y, math.rad(self.rotation), 
                self.scale.x, self.scale.y, self.shear.x, self.shear.y
            )
        end
    love.graphics.setColor(oldColor)
end

return setmetatable(DrawableComponent, { __call = function(_, ...) return DrawableComponent.new(...) end})
]]--

return {
    drawable = Loveplay.assets.get(Loveplay.assets.ASSETTYPE.IMAGE, "logo"),
    scale = vec2.ZERO(),
    origin = vec2.ZERO(),
    shear = vec2.ZERO(),
    rotation = 0,
    color = Color.WHITE,

    __draw = function(this)
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(this.color)
            love.graphics.draw(
                this.drawable,
                this.pos.x, this.pos.y, math.rad(this.rotation),
                this.scale.x, this.scale.y, this.shear.x, this.shear.y
            )
        love.graphics.setColor(oldColor)
    end,

    centerOrigin = function(this)
        local dw, dh = this.drawable:getDimentions()
        this.origin = vec2(dw / 2, dh / 2)
    end
}