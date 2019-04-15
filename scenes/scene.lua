-- Representa una escena del juego
local Scene = {
New = function(id)
    local scene = {__module = "scene"}
    scene.id = id or "scene"

    function scene:OvInit()     end
    function scene:OvTick(dt)   end
    function scene:OvRender()   end
    function scene:OvDestroy()  end


    function scene:Init()
        Game.GameLoop:AddLoop(self)
        Game.Renderer:AddRenderer(self, 2)
        self:OvInit()
    end

    function scene:Tick(dt)
        self:OvTick(dt)
    end

    function scene:Render()
        self:OvRender()
    end

    function scene:Destroy()
        Game.GameLoop:RemoveLoop(self)
        Game.Renderer:RemoveRenderer(self)
        self:OvDestroy()
        --print("ESCENA ELIMINADA!")
    end

    return scene
end,
}
return Scene
