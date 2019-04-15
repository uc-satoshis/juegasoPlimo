require("tools/vect2")
local vect2 = math.vect2

local Joystick = {
					offset = 50,
					imgJS = love.graphics.newImage("assets/joystick/joystick.png"),
    				imgBola = love.graphics.newImage("assets/joystick/bola.png"),
    				touchJS = 1,
    				value = vect2.New(),
    				scale = Game.Dim.w/600,
                    dim = {w = Game.Dim.w, h = Game.Dim.h},
                    activo = true
				}


function Joystick:Init()
	self.wJS = self.imgJS:getWidth() -- 115
	self.wBola = self.imgBola:getWidth() -- 76

	self.posJS = vect2.New(self.offset, Game.Dim.h-self.offset-self.wJS)

	self.posJSScale = vect2.New(self:toScale(self.posJS.x), self:toScale(self.posJS.y-(self.wJS*(self.scale-1))))
	
	self.posBaseBolaScale = vect2.New(self.posJSScale.x+self.wJS/2-self.wBola/2, self.posJSScale.y+self.wJS/2-self.wBola/2)
	self.posBolaScale = self.posBaseBolaScale

	self.origen = vect2.New(self:toCoords(self.posBaseBolaScale.x + self.wBola/2), self:toCoords(self.posBaseBolaScale.y + self.wBola/2))
	self.radius = self.wJS*self.scale / 2
end

function Joystick:Update(e)
	if self.activo then
		if(math.abs(self.value.x) > 0.01 and math.abs(self.value.y) > 0.01) then
			e:Apply_Velocity(e.Speed*(math.abs(self.value.x) + math.abs(self.value.y)), math.atan2(self.value.y, self.value.x))
		end
	end
end

function love.touchpressed( id, x, y, dx, dy, pressure )
	if self.activo then
		if( x < 2*Joystick.dim.w/7  and  y > Joystick.dim.h/2 ) then
			Joystick.touchJS = id
			Joystick.posBolaScale = vect2.New(Joystick:toScale(x-(Joystick.wBola/2)*Joystick.scale), Joystick:toScale(y-(Joystick.wBola/2)*Joystick.scale))
			local t = vect2.New(x,y)
			local mod = t:Module(Joystick.origen)
			if(mod <= Joystick.radius) then
				Joystick.value = vect2.New((x - Joystick.origen.x) / (Joystick.wJS/2) / Joystick.scale, (y - Joystick.origen.y) / (Joystick.wJS/2) / Joystick.scale)
			end
		end
	end
end

function love.touchmoved( id, x, y, dx, dy, pressure )
	if self.activo then
		if( id == Joystick.touchJS ) then
			Joystick.touchJS = id
			Joystick.posBolaScale = vect2.New(Joystick:toScale(x-(Joystick.wBola/2)*Joystick.scale), Joystick:toScale(y-(Joystick.wBola/2)*Joystick.scale))
			
			-- calcula value del js si esta en el circulo
			local t = vect2.New(x,y)
			local mod = t:Module(Joystick.origen)
			if(mod <= Joystick.wJS*Joystick.scale/2) then
				Joystick.value = vect2.New((x - Joystick.origen.x) / (Joystick.wJS/2) / Joystick.scale, (y - Joystick.origen.y) / (Joystick.wJS/2) / Joystick.scale)
			else
				--Joystick.posBolaScale = 
			end
		end
	end
end

function love.touchreleased( id, x, y, dx, dy, pressure )
	if self.activo then
		if( id == Joystick.touchJS ) then
			Joystick.posBolaScale = Joystick.posBaseBolaScale
			Joystick.value = vect2.New()
			Joystick.touchJS = 1
		end
	end
end

function Joystick:Render()
	if self.activo then
		love.graphics.push()
		love.graphics.scale(self.scale,self.scale)
		love.graphics.draw(self.imgJS, self.posJSScale.x, self.posJSScale.y)
		love.graphics.draw(self.imgBola, self.posBolaScale.x, self.posBolaScale.y)
		love.graphics.pop() -- so the scale doesn't affect anything else
	end
--[[
	love.graphics.print(self.origen.x, 10, 40)
	love.graphics.print(self.origen.y, 10, 50)

	love.graphics.print(self.value.x, 10, 70)
	love.graphics.print(self.value.y, 10, 80)

	love.graphics.setColor(0, 0, 0)
	love.graphics.circle("fill", self.origen.x, self.origen.y, 10)
	love.graphics.setColor(255, 255, 255)
]]

end

function Joystick:toScale(x)
	local x2 = x/self.scale
	return x2
end

function Joystick:toCoords(x)
	local x2 = x*self.scale
	return x2
end

function Joystick:calculaPos(x,y)
	
end

return Joystick