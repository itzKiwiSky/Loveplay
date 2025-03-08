local LPASSETS = (...):match('(.-)[^/]+$')
local vec2 = import 'Math.Vec2'
local Color = import 'Utils.Color'

---@class Loveplay.Components.TextRendererComponent
local TextRendererComponent = {}
TextRendererComponent.__index = TextRendererComponent

TextRendererComponent.ALIGNMENT = enum { "LEFT", "CENTER", "RIGHT" }
local alignments = { [0] = "left", "center", "right" }

function TextRendererComponent.new()
    local self = setmetatable({}, TextRendererComponent)
    self.font = Loveplay.assets.get(Loveplay.assets.assetType.FONT, "fredoka", { fontsize = 20 })
    self.text = ""
    self.color = Color.BLACK
    self.align = TextRendererComponent.ALIGNMENT.CENTER
    self.offsetPos = vec2.ZERO
    self.textLimit = 128
    self.shadow = false
    self.shadowColor = Color.fromInt(0x00000080)
    self.shadowOffset = vec2(5, 5)
    return self
end

function TextRendererComponent:__draw()
    local oldColor = { love.graphics.getColor() }
    love.graphics.setColor(self.color)
        love.graphics.printf(self.text, self.font, self.pos.x, self.pos.y, self.textLimit, alignments[self.align])
        if self.shadow then
            love.graphics.setColor(self.shadowColor)
            love.graphics.printf(self.text, self.font, self.pos.x + self.shadowOffset.x, self.pos.y + self.shadowOffset.y, self.textLimit, alignments[self.align])
        end
    love.graphics.setColor(oldColor)
end

return setmetatable(TextRendererComponent, { __call = function(_, ...) return TextRendererComponent.new(...) end})