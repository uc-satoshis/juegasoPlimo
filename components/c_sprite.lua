local rect = love.graphics.rectangle
local draw = love.graphics.draw

-- Componente que representa el sprite de una entidad
local C_Sprite = {
    New = function()
        local c_sprite = require "components/component".New("sprite")

        function c_sprite.Load(e, args)

            e.type = args.type

            if (e.type ~= "rect") then
                e.numFrameActual = 0
                e.animActual = "derecha"
                e.velAnimacion = args.velAnimacion * 30
                e.animTimer = 1/e.velAnimacion
                e.spriteActual = love.graphics.newQuad(0,0,math.floor(_G[e.type].spriteSheet:getWidth()/_G[e.type].numFrames),
                                                math.floor(_G[e.type].spriteSheet:getHeight()/_G[e.type].numAnimations),
                                                _G[e.type].spriteSheet:getWidth(),
                                                _G[e.type].spriteSheet:getHeight())
                e.parado = true
            end
        end

        function c_sprite.Tick(e, dt)
            if(e.type ~= "rect") then
                Game.Animations:Anima(e, dt)
            end
        end

        function c_sprite.Render(e)
            if(e.type == "rect") then
                rect("fill",e.Position.x, e.Position.y, e.Size.x, e.Size.y)
            end
            
            if(e.type ~= "rect") then
                draw(_G[e.type].spriteSheet, e.spriteActual, e.Position.x, e.Position.y)
            end
            
        end

        return c_sprite
    end,
}
return C_Sprite