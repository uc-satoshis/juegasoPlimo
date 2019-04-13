local Keko = require("characters/character").New()

Keko.spriteSheet = love.graphics.newImage("assets/personajes/keko.png")
Keko.orden = {"derecha","izquierda","abajo","arriba"}

Keko.numFrames = 12
Keko.numAnimations = 4

Keko:generateAnimations()

return Keko


