local Entity = {
New = function(_id)
    local entity = {}

    entity.ID           = _id
    entity.Remove       = false
    entity.Components   = {}

    function entity:OvLoad() end
    function entity:OvTick(dt) end
    function entity:OvRender() end
    function entity:OvDestroy() end

    function entity:Load()
        Game.GameLoop:AddLoop(entity)
        Game.Renderer:AddRenderer(entity,4)
        self:OvLoad()
    end

    function entity:Requires(r)
        for k,v in ipairs(r) do
            if (self.Components[v] == nil) then
                assert(false,"Error:Requires component requires the component "..v)
            end
        end
    end

    function entity:Add(comp, args)
        self.Components[comp.ID] = comp
        comp.Load(self, args)
    end

    function entity:Get(_id)
        assert(self.Components[_id], "Error::Entity:: Get cannot find component: ".. _id)
        return self.Components[_id]
    end

    function entity:Tick(dt)
        self:OvTick(dt)
        for i,v in pairs(self.Components) do
            v.Tick(self, dt)
        end
    end

    function entity:Render()
        self:OvRender()
        for i,v in pairs(self.Components) do
            v.Render(self)
        end
    end

    function entity:Destroy()
        Game.GameLoop:RemoveLoop(entity)
        Game.Renderer:RemoveRenderer(entity)
        self:OvDestroy()
    end

    return entity
end,
}

return Entity