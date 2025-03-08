local camera = import 'Core.Camera'

local LPScene = {}
LPScene.scenes = {}
LPScene.currentScene = "root"
LPScene.camera = camera.new()

----- interfaces -----------

local LPSceneEvents = {}

function LPSceneEvents.sceneLoad()end

function LPSceneEvents.sceneDraw()end

function LPSceneEvents.sceneUpdate(elapsed)end

---------------------

function LPScene.newScene(name, fun)
    LPScene.scenes[name] = {
        objects = {},
        def = fun
    }
    --fun(LPScene.scenes[name])
    --LPScene.sceneLoad()
end

function LPScene.switchScene(name)
    LPScene.currentScene = name
    LPScene.camera:setCameraPosition(Loveplay.windowWidth / 2, Loveplay.windowHeight / 2)
    LPScene.scenes[LPScene.currentScene].def(LPSceneEvents)
    if LPSceneEvents.sceneLoad then
        LPSceneEvents.sceneLoad()
    end
end

function LPScene.add(gameObject)
    table.insert(LPScene.scenes[LPScene.currentScene].objects, gameObject)
    print(inspect(LPScene.scenes[LPScene.currentScene].objects))
    --Loveplay.event.dispatch("sceneObjectAdded", gameObject)
end

function LPScene.draw()
    LPScene.camera:start()
        for _, obj in ipairs(LPScene.scenes[LPScene.currentScene].objects) do
            if obj.__draw then
                obj.__draw(obj)
            end
        end
    LPScene.camera:stop()
    if LPSceneEvents.sceneDraw then
        LPSceneEvents.sceneDraw()
    end
end

function LPScene.update(elapsed)
    for _, obj in ipairs(LPScene.scenes[LPScene.currentScene].objects) do
        if obj.__update then
            obj.__update(obj, elapsed)
        end
    end
    if LPSceneEvents.sceneUpdate then
        LPSceneEvents.sceneUpdate(LPScene.scenes[LPScene.currentScene].objects, elapsed)
    end
end


return LPScene