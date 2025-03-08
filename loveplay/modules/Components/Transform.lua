local vec2 = import 'Math.Vec2'

local TransformComponent = {
    pos = vec2.ZERO()
}

function TransformComponent.center(this)
    this.pos.x, this.pos.y  = Loveplay.windowWidth / 2, Loveplay.windowHeight / 2
end

return TransformComponent