require("tools/vect2")
local vect2 = math.vect2

local Boton = {
New = function(sprite, x, y, id)
	local boton = {
		sprite,
		pos,
		id,
		activo,
	}

	function boton:Init()
		self.sprite = love.graphics.newImage(sprite)
		self.pos = vect2.New(x, y)
		self.id = id
		self.activo = true
	end

	function love.touchpressed( id, x, y, dx, dy, pressure )
		if boton.activo then
			if x < boton.pos.x + boton.sprite:getWidth()*Game.Scale and y < boton.pos.y + boton.sprite:getHeight()*Game.Scale then
				if Debug_Mode then
					Debug_Mode = false
				else
					Debug_Mode = true
				end
			end


		end
	end

	function boton:Render()
		if self.activo then
			love.graphics.push()
			love.graphics.scale(Game.Scale,Game.Scale)
			love.graphics.draw(self.sprite, toScale(self.pos.x), toScale(self.pos.y))
			love.graphics.pop()
		end
	end

	return boton
end,
}
return Boton