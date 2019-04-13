local Component = {
New = function(_id)
    local component = {}

    assert(_id, "Error::Component::New component must have and id!!")
    component.ID = _id

    function component.Load(e,args) end
    function component.Tick(e, dt)  end
    function component.Render(e)    end
    function component.Destroy(e)   end

    return component
end
}
return Component