local font = import 'GFX.Font'

local LPAssetPool = {}
LPAssetPool.audios = {}
LPAssetPool.fonts = {
    cache = {},
    paths = {}
}
LPAssetPool.images = {}
LPAssetPool.shaders = {}

LPAssetPool.AUDIOLOADTYPE = enum {
    "STATIC",
    "STREAM"
}

LPAssetPool.ASSETTYPE = enum {
    "AUDIO",
    "FONT",
    "IMAGE",
    "SHADER"
}

local audiotypes = { [0] = "static", "stream" }
local assetType = { [0] = "audios", "fonts", "images", "shaders" }

function LPAssetPool.get(type, tag, args)
    args = args or {
        fontsize = 20,
        sourcetype = LPAssetPool.AUDIOLOADTYPE.STATIC
    }
    --print(assetType[type])
    return switch(assetType[type], {
        ["audios"] = function()
            return LPAssetPool.audios[tag .. "_" .. audiotypes[args.sourcetype]]
        end,
        ["fonts"] = function()
            if LPAssetPool.fonts.paths[tag] then
                if not LPAssetPool.fonts.cache[tag .. "-" .. args.fontsize] then
                    LPAssetPool.fonts.cache[tag .. "-" .. args.fontsize] = LPAssetPool.fonts.paths[tag]:makeFont(args.fontsize)
                    return LPAssetPool.fonts.cache[tag .. "-" .. args.fontsize]
                end
            end
        end,
        ["images"] = function()
            if LPAssetPool.images[tag] then
                return LPAssetPool.images[tag]
            else
                print("invalid image")
            end
        end
    })
end

function LPAssetPool.addImage(tag, source)
    LPAssetPool.images[tag] = love.graphics.newImage(source)
end

function LPAssetPool.addAudio(tag, source, type)
    LPAssetPool.audios[tag .. "_" .. audiotypes[type]] = love.audio.newSource(source, audiotypes[type] or "static")
end

function LPAssetPool.addFont(tag, source)
    --LPAssetPool.images[tag] = love.graphics.newImage(source)
    LPAssetPool.fonts.paths[tag] = font.new(source)
end

return LPAssetPool