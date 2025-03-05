local vec2 = import 'Math.Vec2'

---@class Loveplay.Components.TransformComponent
local TransformComponent = {}
TransformComponent.__index = TransformComponent

function TransformComponent.new()
    local self = setmetatable({}, TransformComponent)
    self.pos = vec2.ZERO
    return self
end

--- Centralize the transformation
function TransformComponent:center()
    self.pos.x, self.pos.y = love.resconf.width / 2, love.resconf.height / 2
end

--- Shortcut for self.pos = loveplay.vec2(x, y)
---@param x number
---@param y number
function TransformComponent:setPosition(x, y)
    self.pos = vec2(x, y)
end

return setmetatable(TransformComponent, { __call = function(_, ...) return TransformComponent.new(...) end})