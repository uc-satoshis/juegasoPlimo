-- Representa el mundo del juego
local Entity_World = {}

local Entity = require "entities/entity"

local push, pop = table.insert, table.remove

-- Inicializa el mundo vacio de entidades
function Entity_World:Init()
    self.entities = {}
end

-- Crea una entidad para este mundo y la anade a los bucles 'gameloop' y 'renderer'. Luego la retorna.
function Entity_World:Create_Entity(_id)
    local e = Entity.New(_id)
    e:Load()
    push(self.entities, e)
    return e
end

function Entity_World:Get_Entity(_id)
    local e = self.entities(_id)
    return e
end


-- Update todas las entidades del mundo
function Entity_World:Tick(dt)
    for i = #self.entities, 1, -1 do
        if self.entities[i].Remove then
            Game.GameLoop:RemoveLoop(self.entities[i])
            Game.Renderer:RemoveRenderer(self.entities[i])
            pop(self.entities, i)
        end
    end
end

return Entity_World