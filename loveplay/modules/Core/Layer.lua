local Color = import 'Utils.Color'

local LPLayer = {}
LPLayer.__index = LPLayer

function LPLayer.new()
    local self = setmetatable({}, LPLayer)
    self.objects = {}
    self.backgroundColor = Color.WHITE
    self.scrollFactor = {}
    self.scrollFactor.x = 1
    self.scrollFactor.y = 1
    return self
end

function LPLayer:Add(object)
    table.insert(self.objects, object)
end

function LPLayer:RemoveAll()
    for _, obj in lume.ripairs(self.objects) do
        table.remove(self.objects, _)
    end 
end

function LPLayer:onDraw()
    local _, _, flags = love.window.getMode()

    local desktopWidth, desktopHeight = love.window.getDesktopDimensions(flags.display)
    local oldColor = { love.graphics.getColor() }
    
    love.graphics.setColor(self.backgroundColor)
        love.graphics.rectangle("fill", 0, 0, desktopWidth, desktopHeight)
    love.graphics.setColor(oldColor)

    for _, obj in ipairs(self.objects) do
        if obj.__draw then
            obj:__draw()
        end
    end
end

function LPLayer:onUpdate(elapsed)
    for _, obj in ipairs(self.objects) do
        if obj.onUpdate then
            obj:onUpdate(elapsed)
        end
    end
end

return LPLayer