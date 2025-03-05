local object = import 'Core.Object'

return function(loveplay, x, y)
    local o = object.new()
    o:attach(loveplay.components.Vec2)
end