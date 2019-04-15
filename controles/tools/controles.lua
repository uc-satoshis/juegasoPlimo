

function controles()



    os = love.system.getOS()

    gw = love.graphics.getWidth() -- game width
    gwp = gw/10 -- game widht "part"

    gh=love.graphics.getHeight()
    ghp = gh/10 -- game height "part"
   

    local controles = {} 

    guia = {}
    guia.x = 100
    guia.y = 100
    guia.radio = 20
    guia.velocidad = 10


      controles.b = { -- buttons
      t = {gwp*8, ghp*2, gwp/2, ghp/2, 0}, -- left (left edge, top edge, width, height, timer)
      b = {gwp*8, ghp*4, gwp/2, ghp/2, 0}, -- right
      l = {gwp*7, ghp*3, gwp/2, ghp/2, 0}, -- top
      r = {gwp*9, ghp*3, gwp/2, ghp/2, 0} -- bottom
    }


    --Joystick

    resizeBase= 1.50  -- tamaño del joystic
    factorEscala = resizeBase * (gh/600)
    jsImgSize = 128 * factorEscala
    joystick = love.graphics.newImage("assets/joystickflechas.png")
    
    joystickPosXIni= 50  --- posicion del joystic 
    joystickPosYIni= 50

    joystickPosY=  (gh - (jsImgSize + joystickPosYIni))
    joystickPosX= joystickPosXIni

    js = {}
    js.pmx= (joystickPosX+jsImgSize+joystickPosX)/2     -- Punto medio
    js.pmy= joystickPosY +(jsImgSize/2)
    js.x = 0                  -- Posicion
    js.y= 0


    love.graphics.setBackgroundColor(0,0,255)


    

  function controles:draw()

    -- Info 
    love.graphics.print(tostring(tchX1),400,200)
    love.graphics.print(tostring(tchY1),550,200)

    love.graphics.print(tostring(tchXjs),400,250)
    love.graphics.print(tostring(tchYjs),550,250)

    love.graphics.print(tostring(js.x), 400, 300)
    love.graphics.print(tostring(js.y), 450, 300)

    love.graphics.print(os,400,450)
    love.graphics.print(tostring(gw), 400, 400)
    love.graphics.print(tostring(gh), 450, 400)


  	  -- draw buttons
    for i,v in pairs(controles.b) do 
      opacity = 100 + v[5] * 400 -- change opacity over time to indicate
      love.graphics.setColor(255,255,255,opacity)
      love.graphics.rectangle("fill",v[1],v[2],v[3],v[4])
    end	

   
     --draw joystick
     love.graphics.draw(joystick,joystickPosX,joystickPosY,0,factorEscala,factorEscala)

     love.graphics.setColor(255,255,255)
     love.graphics.circle("fill", guia.x, guia.y, guia.radio)


      -- draw Circulos

    
  end




  function controles.update(dt)
   

    -- Si no ai pulsacion se vuelve a 0
   tchX =0
   tchY =0

   tchXjs =0
   tchYjs =0
   
   tchX1 =0
   tchY1 =0


    touches = love.touch.getTouches() -- lista de los toques en pantalla

    for i, id in ipairs(touches) do   -- recorer la lista de touchs
      tchX ,tchY = love.touch.getPosition(id) -- cordeenadas de cada touch
     
    	 if tchX > (jsImgSize+joystickPosX) or tchX < joystickPosX 
     		or tchY < joystickPosY or tchY > (joystickPosY+jsImgSize)
         then
          --touch fuera del joystick
     		 tchX1= tchX 
     		 tchY1= tchY
       else
          --touch dentro del joystick
     		 tchXjs = tchX 
         tchYjs = tchY

         -- gia del joystic
     		guia.x = tchX
     		guia.y = tchY
       end


    end
   
    
    -- Corrector joystick - Coordenadas touch -> Coordenadas joystick
    js.x = (tchXjs - js.pmx) / (jsImgSize/2)        
    js.y = -(tchYjs - js.pmy)/ (jsImgSize/2)

  --! mantener la direccion(ultimo js.x,.y) si te sales sin levantar el dedo 

    -- Fuera del joystick  
    if js.x > 1 or js.x< -1  or js.y==0 then
      js.x = 0
      js.y = 0
    end 


    if js.y > 1 or js.y< -1  or js.x==0 then
      js.y = 0
      js.x = 0
    end  
    -- guia del  joystick vuelve al centro
    if  js.y==0 and js.x==0 then
     	guia.x= js.pmx
      guia.y= js.pmy
    end

  --leer area pulsada en el segundo toque
  botones(tchX1,tchY1)

  -- mover objeto con joystic
  joystickX(personaje)
  joystickY(personaje)


     

  end




  ---------Funciones---------


  -- joystick --
  function joystickY(obj)
    obj.y = obj.y - (js.y * obj.velocidad)
  end

  function joystickX(obj)
    obj.x = obj.x + (js.x * obj.velocidad)
  end


  -- botones -- 
  function botones(mx,my)
    for i,v in pairs(controles.b) do --para cada boton
      -- check collision and restrict allowed repeat click speed
      if mx >= v[1] and mx <= v[1]+v[3] and my >= v[2] and my <= v[2] + v[4]  -- comprobar si la pulsacion esta dentro del area de algun boton
       then
     

        if i == "t" then
          -- do what uparrow does
          	personaje.y = personaje.y - personaje.velocidad 
            
        elseif i == "l" then
          -- do what leftarrow does
           personaje.x = personaje.x - personaje.velocidad
         
        elseif i == "b" then
          -- do what downarrow does
            personaje.y = personaje.y + personaje.velocidad
   
        elseif i == "r" then
          -- do what rightarrow does
             personaje.x = personaje.x + personaje.velocidad

        end
      end 
    end
  end
         
return controles
end