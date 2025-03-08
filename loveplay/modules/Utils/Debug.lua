local Color = import 'Utils.Color'

local LPDebug = {}

LPDebug.LOGTYPE = enum { "INFO", "WARN", "ERROR", "DEPRECATION" }

function LPDebug:init(x, y)
    self.x, self.y = x or 0, self.y or math.floor(Loveplay.windowHeight / 2)
    self.maxWidth = math.floor(Loveplay.windowWidth / 2)
    self.maxHeight = math.floor(Loveplay.windowHeight / 2)
    self.messages = {}

    -- Loveplay ingame debug --
    self.ttl = 200 -- time to leave --
    self.opacity = 1
    self.colorBG = Color.fromInt(0x00000080)
    --self.colorFG = Color.WHITE
    self.font = Loveplay.assets.get(Loveplay.assets.assetType.FONT, "fredoka", { fontsize = 14 })

    self.warnColors = {
        [0] = Color.fromInt(0xE3C2CDFF),
        Color.fromInt(0xF5C436FF),
        Color.fromInt(0xF04861FF),
        Color.fromInt(0xE18346FF),
    }
end

function LPDebug:_draw()
    for _, message in ipairs(self.messages) do
        local oc = { love.graphics.getColor() }
        love.graphics.setColor(self.colorBG)
            love.graphics.rectangle("fill", self.x, self.y, self.font:getWidth(message.text), self.font:getHeight() + 5)
        love.graphics.setColor(oc)
    end
end

function LPDebug:_update(elapsed)
    
end

----- exported -----
--- Output to the Loveplay ingame log
---@param type Loveplay.Debug.LOGTYPE
---@param message string
function LPDebug:log(type, message)
    --self.font:getHeight() + 5
end

return LPDebug