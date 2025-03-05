loveplay = require 'loveplay'

loveplay.load({ debug = true })

local obj = loveplay.object(90, 90, {
    loveplay.components.Drawable
})

obj.scale = loveplay.Vec2(0.2, 0.2)
obj.pos = loveplay.Vec2(90, 32)

loveplay.event.on("__update", function()
    obj.pos.x = obj.pos.x + 1
end)
