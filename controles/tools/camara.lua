camara =
{
    pos = require("tools/vector"):new(0,0),
    size = require("tools/vector"):new(0,0),
    scale = require("tools/vector"):new(1,1),
    rotation = 0
}

local lg = love.graphics
local pop = lg.pop
local trans = lg.translate
local rotate = lg.rotate
local scale = lg.scale
local push = lg.push

function camara:set()
    push()
    trans(-self.pos.x,-self.pos.y)
    rotate(-self.rotation)
    scale(self.scale.x, self.scale.y)
end

function camara:goto_point(pos, dt)
    self.pos.x = math.floor((pos.x - Width  / (2*self.scale.x))*self.scale.x )
    self.pos.y = math.floor((pos.y - Height / (2*self.scale.y))*self.scale.y )
end

function camara:unset()
    pop()
end

return camara