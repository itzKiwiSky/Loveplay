local Layer = import 'Core.Layer'
local Camera = import 'Core.Camera'

local LPScene = {}
LPScene.__index = LPScene

function LPScene.new()
    local self = setmetatable({}, LPScene)

    self.layers = {}
    self.camera = Camera.new()
    self.currentLayer = "root"

    -- add a first layer to be able to place objects
    self:AddLayer(self.currentLayer)

    return self
end

function LPScene:AddToScene(object)
    self.layers[self.currentLayer]:Add(object)
end

function LPScene:AddLayer(name)
    self.layers[name] = Layer.new()
end

function LPScene:RemoveLayer(name)
    self.layers[self.currentLayer] = nil
end

---------------------------------------------------------------

function LPScene:onDraw()
    self.layers[self.currentLayer]:onDraw()
end

function LPScene:onUpdate(elapsed)
    self.layers[self.currentLayer]:onUpdate(elapsed)
end

return LPScene