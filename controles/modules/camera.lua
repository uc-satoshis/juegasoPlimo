local Camera = {
    Position = {x = 0, y = 0},
    Scale = {x = 1, y = 1},
    Rotation = 0,
    bounds = {x1=0, y1=0, x2=0, y2=0},
    timer = 0,
    delta_x = 0,
    delta_y = 0
}

function Camera:Set()
    love.graphics.push()
    love.graphics.translate(-self.Position.x, -self.Position.y)
    love.graphics.scale(self.Scale.x, self.Scale.y)
    love.graphics.rotate(self.Rotation)
    --Camera:setBounds(0, 0, Game.Canvas:getWidth(), Game.Canvas:getHeight())
end

function Camera:Unset()
    love.graphics.pop()
end

function Camera:SetX(x)
    --if self.bounds then
    --    self.Position.x = math.clamp(x, self.bounds.x1, self.bounds.x2)
    --else
        self.Position.x = x
    --end
end

function Camera:SetY(y)
    --if self.bounds then
    --    self.Position.y = math.clamp(y, self.bounds.y1, self.bounds.y2)
    --else
        self.Position.y = y
    --end
end

function Camera:Zoom(number)
    self.Scale.x = number * self.Scale.x
    self.Scale.y = number * self.Scale.y
end

function Camera:Rotate(rotation)
    self.Rotation = rotation
end

function Camera:setBounds(x1, y1, x2, y2)
    self.bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end

function Camera:Update(dt)
end

function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end

return Camera