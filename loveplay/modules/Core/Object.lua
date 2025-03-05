local vec2 = import 'Math.Vec2'

local function deepMerge(target, source)
    if type(target) ~= "table" or type(source) ~= "table" then
        return target
    end

    if getmetatable(source) then
        setmetatable(target, getmetatable(source))
    end

    for key, value in pairs(source) do
        if type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = {}
            end
            deepMerge(target[key], value)
        else
            target[key] = value
        end
    end

    return target
end


local LPObject = {}
LPObject.__index = LPObject

function LPObject.new(components)
    local self = setmetatable({}, LPObject)
    self.health = 5
    self.alive = true

    for c = 1, #components, 1 do
        local cdata = components[c]()
        self = deepMerge(self, cdata)
    end

    Loveplay.scenes[Loveplay.currentScene]:AddToScene(self)

    return self
end

return setmetatable(LPObject, { __call = function(_, ...) return LPObject.new(...) end})