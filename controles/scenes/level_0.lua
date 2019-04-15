
-- Representa un nivel o pantalla del juego
local level_0  = require "scenes/scene".New("level_0")

local Entity  = require "entities/entity"

function level_0:OvInit()



    Game.Physics:Reset()
    -- Objetos solidos
   
    Game.Physics:Add_Static_Body({
        position = {x=0, y=0},
        size = {x=2000, y=60}
    })
    -- cambio mapa

    Game.Physics:Add_Map_Change({
        position = {x=600, y=50},
        size = {x=80, y=100},
        map = "scenes/level_0_1" 
    })
     Game.Physics:Add_Map_Change({
        position = {x=200, y=50},
        size = {x=80, y=100},
        map = "scenes/level_0_2" 
    })
    
    e2 = Game.World:Create_Entity("enemy")
    e2:Add(require "components/c_body".New(), {x = 400, y = 100, width = 64, height = 64})
    e2:Add(require "components/c_sprite".New(), {type = "Skeleton", velAnimacion = 0.3})
    e2:Add(require "components/c_physics".New(), {friction = .85})

    mapActual = require("scenes/tile_map").New("assets/maps/test")
end

function level_0:OvTick()
    e2:Apply_Velocity(5, math.rad(180))
end

function level_0:OvRender()

end

return level_0