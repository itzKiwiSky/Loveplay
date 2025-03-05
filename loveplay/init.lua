Loveplay = {}

local LP_PATH = (...) .. "."

function import(modname)
    if modname == nil or #modname == 0 then
        return require(LP_PATH)
    end
    return require(LP_PATH .. "modules." .. modname)
end

class = require(LP_PATH .. "libraries.classic")
xml = require(LP_PATH .. "libraries.xml")
resolution = require(LP_PATH .. "libraries.resolution")
lume = require(LP_PATH .. "libraries.lume")
enum = require(LP_PATH .. "libraries.enum")
camera = require(LP_PATH .. "libraries.camera")
Loveplay.event = require(LP_PATH .. "libraries.event")


local fsutil = require(LP_PATH .. "FSutil")

local addons = fsutil.scanFolder(LP_PATH .. "/addons")
for a = 1, #addons, 1 do
    local ad = addons[a]:gsub(".lua", "")
    require(ad:gsub("/", "%."))
end

Loveplay.initialized = false
Loveplay.currentScene = "root"
Loveplay.currentActiveScene = "root"
Loveplay.scenes = {}

Loveplay.Vec2 = import 'Math.Vec2'
Loveplay.scene = import 'Core.Scene'
Loveplay.object = import 'Core.Object'
Loveplay.assets = import 'Core.AssetPool'

Loveplay.assets.addImage("logo", LP_PATH .. "/assets/icon.png")
Loveplay.assets.addFont("fredoka", LP_PATH .. "/assets/fredoka_regular.ttf")

---@class Loveplay.Components
Loveplay.components = {}

-- load components --
local components = fsutil.scanFolder(LP_PATH .. "/modules/Components")
for c = 1, #components, 1 do
    local comp = components[c]:gsub(".lua", "")
    Loveplay.components[components[c]:match("[^/]+$"):gsub(".lua", "")] = require(comp:gsub("/", "%."))
end


--------------------- API ---------------------

function Loveplay.newScene(name)
    Loveplay.scenes[name] = Loveplay.scene.new()
end

--------------------- callbacks ---------------------

--- Main callback for initialization, must be called once
---@param config table
function Loveplay.load(config)
    assert(Loveplay.initialized == false, "[LovePlayError] : Loveplay is already initialized")

    -- load configs --
    config = config or {}
    local conf = {
        width = config.width or 640,
        height = config.height or 480,
        vsync = config.vsync or false,
        title = config.title or "Powered with LovePlay",
        scene = config.scene or "root",
        resizable = config.resizable or true,
        packageid = config.packageid or "loveplay.game",
        fpscap = config.fpscap or 60,
        unfocusedfps = config.unfocusedfps or 25,
        errhand = config.errhand or true,
        debug = config.debug or false,
    }

    -- crate default scene --
    loveplay.scenes[conf.scene] = Loveplay.scene.new()
    loveplay.currentActiveScene = conf.scene

    -- hook shit --
    Loveplay.event.hook(loveplay.scenes[loveplay.currentActiveScene], { "onUpdate", "onDraw" })

    love.window.setMode(conf.width, conf.height, { resizable = conf.resizable, vsync = conf.vsync })

    love.window.setTitle(conf.title)
    love.filesystem.setIdentity(conf.packageid)

    resolution.init({
        replace = {},
        centered = true,
        aspectRatio = true,
        clampMouse = true,
        clip = true,
        width = conf.width,
        height = conf.height,
    })

    love.run = function()
        love._FPSCap = conf.fpscap
        love._unfocusedFPSCap = conf.unfocusedfps

        love.math.setRandomSeed(os.time())
        math.randomseed(os.time())
    
        local fpsfont = love.graphics.newFont(16)
    
        local pargs = love.arg.parseGameArguments(arg)  -- parsed arguments
        local rargs = arg   -- raw arguments

        if love.timer then love.timer.step() end

        local elapsed = 0

        return function()
            -- Process events.
            if love.event then
                love.event.pump()
                for name, a,b,c,d,e,f in love.event.poll() do
                    if name == "quit" then
                        if not love.quit or not love.quit() then
                            return a or 0
                        end
                    end
                    love.handlers[name](a,b,c,d,e,f)
                end
            end
    
            local isFocused = love.window.hasFocus()
    
            local fpsCap = isFocused and love._FPSCap or love._unfocusedFPSCap
            if love.timer then 
                elapsed = love.timer.step()
            end

            Loveplay.scenes[Loveplay.currentActiveScene]:onUpdate(elapsed)
    
            if love.graphics and love.graphics.isActive() then
                love.graphics.origin()
    
                love.graphics.clear(love.graphics.getBackgroundColor())
    
                    resolution.start()

                        Loveplay.scenes[Loveplay.currentActiveScene]:onDraw()

                    resolution.stop()
    
                love.graphics.present()
            end
    
            collectgarbage("collect")
    
            if love.timer then love.timer.sleep(1 / fpsCap - elapsed) end
        end
    end

    loveplay.initialized = true
end

return Loveplay