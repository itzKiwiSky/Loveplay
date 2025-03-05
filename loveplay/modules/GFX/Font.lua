local LPASSETS = (...):match('(.-)[^/]+$')
local LPFont = {}
LPFont.__index = LPFont

function LPFont.new(path)
    local self = setmetatable({}, LPFont)
    self.path = path or LPASSETS .. "/fredoka_regular.ttf"
    return self
end

function LPFont:makeFont(size)
    return love.graphics.newFont(self.path, size or 20)
end

return setmetatable(LPFont, { __call = function(_, ...) return LPFont.new(...) end})