local Player = require("characters/character").New()

Player.spriteSheet = love.graphics.newImage("assets/personajes/professor_walk.png")
Player.orden = {"arriba","izquierda","abajo","derecha"}

Player.numFrames = 9
Player.numAnimations = 4

Player:generateAnimations()

return Player


