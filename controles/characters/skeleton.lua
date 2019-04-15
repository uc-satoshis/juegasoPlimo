local Skeleton = require("characters/character").New()

Skeleton.spriteSheet = love.graphics.newImage("assets/personajes/skeleton.png")
Skeleton.orden = {"arriba","izquierda","abajo","derecha"}

Skeleton.numFrames = 9
Skeleton.numAnimations = 4

Skeleton:generateAnimations()

return Skeleton


