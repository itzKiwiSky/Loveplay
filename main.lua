local loveplay = require 'loveplay'

loveplay.load({ debug = true })

loveplay.scene.newScene("main", function(scene)
    scene.sceneLoad = function()
        local obj = loveplay.object({ "test" }, {
            loveplay.components.Transform,
            loveplay.components.Drawable,
        })

        obj.pos.x = -128
        obj.pos.y = -128
        obj.scale = Loveplay.Vec2(5, 5)

        --print(inspect(obj))

        loveplay.scene.add(obj)
    end

    scene.sceneUpdate = function(objs, elapsed)
        obj.pos.x = obj.pos.x - 10 * elapsed
    end
end)

loveplay.scene.switchScene("main")