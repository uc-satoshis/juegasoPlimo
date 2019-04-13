

-- Representa un nivel o pantalla del juego
local level_0_2 = require "scenes/scene".New("level_0_2")

local Entity  = require "entities/entity"

function level_0_2:OvInit()


    Game.Physics:Reset()
    
    -- cambio mapa
     Game.Physics:Add_Map_Change({
        position = {x=600, y=250},
        size = {x=80, y=100},
        map = "scenes/level_0" 
    })

    Game.Physics:Add_Map_Change({
        position = {x=200, y=250},
        size = {x=80, y=100},
        map = "scenes/level_0_1" 
    })

    -- Mapa

    mapActual = require("scenes/tile_map").New("assets/maps/test3")
end

function level_0_2:OvRender()

end

return level_0_2