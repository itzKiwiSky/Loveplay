local ShapeRenderer = {}
ShapeRenderer.__index = ShapeRenderer

function ShapeRenderer.new()
    local self = setmetatable({}, ShapeRenderer)
    
    return self
end

return setmetatable(ShapeRenderer, { __call = function(_, ...) return ShapeRenderer.new(...) end})