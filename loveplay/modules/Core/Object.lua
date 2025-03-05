local vec2 = import 'Math.Vec2'

local LPObject = {}
LPObject.__index = LPObject

function LPObject.new(x, y, components)
    local self = setmetatable({}, LPObject)
    self.health = 5
    self.alive = true
    self.pos = vec2(x or 0, y or 0)
    for c = 1, #components, 1 do
        local cdata = components[c](self)
        
        for k, v in pairs(cdata) do
            if not self[k] then
                self[k] = v
            end
        end
    end

    Loveplay.scenes[Loveplay.currentScene]:AddToScene(self)

    print(inspect(self))

    return self
end

return setmetatable(LPObject, { __call = function(_, ...) return LPObject.new(...) end})