

-- Representa un nivel o pantalla del juego
local level_0_1 = require "scenes/scene".New("level_0_1")

local Entity  = require "entities/entity"

function level_0_1:OvInit()


    Game.Physics:Reset()
    
    -- cambio mapa


    -- Mapa

    mapActual = require("scenes/tile_map").New("assets/maps/mapa_0_1")
end

function level_0_1:OvRender()

end

return level_0_1