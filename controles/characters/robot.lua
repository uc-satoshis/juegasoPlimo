local Robot = require("characters/character").New()

Robot.spriteSheet = love.graphics.newImage("assets/personajes/robot.png")
Robot.orden = {"derecha","mirar","atacar","pisar","agachar"}

Robot.numFrames = 7
Robot.numAnimations = 5

Robot:generateAnimations()

return Robot
