local LPASSETS = (...):match('(.-)[^/]+$')
local vec2 = import 'Math.Vec2'
local Color = import 'Utils.Color'

--- Drawable component
---@type Drawable
return function(object)
    local DrawableComponent = {}
    DrawableComponent.object = object
    DrawableComponent.drawable = love.graphics.newImage(LPASSETS .. "/icon.png")
    DrawableComponent.scale = vec2(1, 1)
    DrawableComponent.origin = vec2.ZERO()
    DrawableComponent.shear = vec2.ZERO()
    DrawableComponent.rotation = 0
    DrawableComponent.color = Color.WHITE

    function DrawableComponent.__draw()
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(DrawableComponent.color)
            love.graphics.draw(DrawableComponent.drawable, 
            DrawableComponent.object.pos.x, DrawableComponent.object.pos.y, math.rad(DrawableComponent.rotation), 
            DrawableComponent.scale.x, DrawableComponent.scale.y, DrawableComponent.shear.x, DrawableComponent.shear.y)
        love.graphics.setColor(oldColor)
    end
    return DrawableComponent
end