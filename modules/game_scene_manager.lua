local GSM = {}

local push, pop = table.insert, table.remove

function GSM:Init()
    self.scenes = {}
end

function GSM:GotoScene(scene)
    
    -- Destruye todas las entidades del gameloop
    for i = 1, #Game.World.entities do
        if(Game.World.entities[i].ID ~= "player") then
            Game.World.entities[i].Remove = true
        end
    end
    
    --Destruye del renderer todas las entidades actuales excepto player
    Game.Renderer:RemoveRendererLayer4()
    --Destruye del renderer la capa del mapa
    Game.Renderer:RemoveRendererLayer(2)


    if(Game.mapActual~=nil) then
        Game.mapActual:Destroy()
    end

    -- Destruye la escena actual
    if #self.scenes > 0 then
        self.scenes[#self.scenes]:Destroy()
        pop(self.scenes, #self.scenes)
    end

    assert(scene.__module, "Error::GSM::GotoScene scene is not a scene...!!!")
    
    -- Cambia de escena
    scene:Init()
    push(self.scenes, scene)
end

return GSM