local function deepMerge(target, source, overwrite)
    if type(target) ~= "table" or type(source) ~= "table" then
        return target
    end

    if getmetatable(source) and not getmetatable(target) then
        setmetatable(target, getmetatable(source))
    end

    for key, value in pairs(source) do
        if type(value) == "function" then
            if type(target[key]) == "function" then
                -- Se já existe uma função, cria uma lista e a agrupa
                local oldFunc = target[key]
                target[key] = function(self, ...)
                    oldFunc(self, ...)
                    value(self, ...)
                end
            elseif type(target[key]) == "table" and getmetatable(target[key]) == nil then
                table.insert(target[key], value)
            else
                target[key] = value
            end
        elseif type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = {}
            end
            deepMerge(target[key], value, overwrite)
        else
            if overwrite ~= false or target[key] == nil then
                target[key] = value
            end
        end
    end

    return target
end


--[[
local LPObject = {}
LPObject.__index = LPObject

function LPObject.new(tags, components)
    local self = setmetatable({}, LPObject)
    self.health = 5
    self.alive = true
    self.children = {}
    self.tags = tags or {}

    for c = 1, #components, 1 do
        deepMerge(self, components[c])
    end

    return self
end

return setmetatable(LPObject, { __call = function(_, ...) return LPObject.new(...) end})
]]--

return function(tags, components)
    local obj = {}
    obj.health = 5
    obj.alive = true
    obj.children = {}
    obj.tags = tags or {}

    for c = 1, #components, 1 do
        deepMerge(obj, components[c])
    end

    return obj
end