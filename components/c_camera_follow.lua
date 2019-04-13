local component = require "components/component"

local C_Camera_Follow = {
New = function()
    local c_camera_follow = component.New "camera"

    function c_camera_follow.Load(e, args)
        assert(e.Position)
        e.camera_smoothing = args.camera_smoothing or 0.08
        --Game.Camera:Zoom(Game.Dim.w/500)
    end

    function c_camera_follow.Tick(e, dt)

        local camera = Game.Camera

        local w = Game.Dim.w
        local h = Game.Dim.h
        
        camera.delta_x = (camera.Position.x - (e.Size.x / 2 + e.Position.x - w / (2*camera.Scale.x))*camera.Scale.x)
        camera.delta_y = (camera.Position.y - (e.Size.y / 2 + e.Position.y - h / (2*camera.Scale.y))*camera.Scale.x)

        camera.timer = camera.timer + dt

        camera:SetX(math.floor(camera.Position.x - (camera.delta_x * e.camera_smoothing)))
        camera:SetY(math.floor(camera.Position.y - (camera.delta_y * e.camera_smoothing)))
    end

    return c_camera_follow
end
}
return C_Camera_Follow