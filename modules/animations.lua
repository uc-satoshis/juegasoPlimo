local abs = math.abs

local Animations = {}

-- Importa las clases de los personajes
Player      = require("characters/player")
Skeleton    = require("characters/skeleton")
Keko        = require("characters/keko")
Robot       = require("characters/robot")


-- Selecciona la animacion actual de la entidad en funcion de su velocidad
function Animations:selectAnimation(e)
    local animActual
    if(e.Velocity.x < 20 and e.Velocity.x > -20 and e.Velocity.y < 20 and e.Velocity.y > -20) then
        e.parado = true
    elseif(abs(e.Velocity.x) > abs(e.Velocity.y) )then
        if(e.Velocity.x > 0) then
            animActual = "derecha"
        else
            animActual = "izquierda"
        end
        e.parado = false
    else
        if(e.Velocity.y > 0) then
            animActual = "abajo"
        else
            animActual = "arriba"
        end
        e.parado = false
    end
    return animActual or e.animActual
end


function Animations:Anima(e, dt)
    -- Selecciona la animacion actual segun la velocidad de su cuerpo
    e.animActual = self:selectAnimation(e)

    -- Si esta parado, el frame actual sera el primero de cada direccion (posicion base)
    if e.parado == true then
        local primerFrame = _G[e.type]:getAnimation(e.animActual)[1]
        e.spriteActual:setViewport(primerFrame[1],primerFrame[2],primerFrame[3],primerFrame[4])
    else
        -- Si no lo esta, anima el personaje
        e.animTimer = e.animTimer - dt
        -- Si el timer de cada frame llega a 0,
        if(e.animTimer <= 0) then
            
            e.animTimer = 1/e.velAnimacion -- Resetea timer

            -- Comprueba que no se pase de los frames
            e.numFrameActual = e.numFrameActual + 1
            if e.numFrameActual >= _G[e.type].numFrames then e.numFrameActual = 1 end

            -- Cambia frame
            local actualFrame = _G[e.type]:getAnimation(e.animActual)[e.numFrameActual]
            e.spriteActual:setViewport(actualFrame[1],actualFrame[2],actualFrame[3],actualFrame[4])
        end
    end
end

return Animations
