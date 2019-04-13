local Joystick = {
    imgJS = love.graphics.newImage("assets/joystick/joystick.png"),
    imgBola = love.graphics.newImage("assets/joystick/bola.png"),
    pos = {x,y}
}

function Joystick:setPos()
    -- Magic numbers
    self.pos.x = ((Game.Camera.Position.x - (Game.Camera.delta_x * e.camera_smoothing))/Game.Camera.Scale.x)
    self.pos.y = ((Game.Camera.Position.y - (Game.Camera.delta_y * e.camera_smoothing))/Game.Camera.Scale.y) + (Game.Dim.h - self.imgJS:getWidth()*Game.Camera.Scale.y)/Game.Camera.Scale.y
end

return Joystick