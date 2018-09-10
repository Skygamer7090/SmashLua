function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local file = 'save.txt'
local lines = lines_from(file)


-- flappy bird

font = love.graphics.setNewFont("Futura.ttc",32)

pipes = {}
pipes_controller = {}
pipes_controller.pipe = {}

function checkClickOnBox()
  if game.start == false then
    if Mx >= 20 and Mx <= 76 and My >= 20 and My <= 61 then
      if love.mouse.isDown(1) then
        flappy.image = love.graphics.newImage'flapp_bird.png'
      end
    elseif Mx >= 86 and Mx <= 142 and My >= 20 and My <= 61 then
      if love.mouse.isDown(1) then
        flappy.image = love.graphics.newImage'flapp_bird copie.png'
      end   
    elseif Mx >= 152 and Mx <= 208 and My >= 20 and My <= 61 then
      if love.mouse.isDown(1) then
        flappy.image = love.graphics.newImage'flapp_bird3.png'
      end
    elseif Mx >= 218 and Mx <= 274 and My >= 20 and My <= 61 then
      if love.mouse.isDown(1) then
        flappy.image = love.graphics.newImage'zubat.png'
      end
    end
  end
end


function checkCollision()
  if game.start == true then
   for _,p in pairs(pipes_controller.pipe) do
     if flappy.x + flappy.w >= p.x and flappy.x <= p.x + p.w then
      if flappy.y <= p.y + p.h or flappy.y + flappy.h >= p.y + 500 then
        game.start = false
        flappy.y = screen.h/2
        if Ppoints < points then
          Ppoints = points
        end
      points = 0
      for i = 1, 10 do
        table.remove(pipes_controller.pipe, 1)
      end
      file = assert(io.open("save.txt","wb"))
      file:write(Ppoints)
      file:close()
     end
    end
   end
  end
end 

function ScoreCount()
  if game.start == true then
    for _,p in pairs(pipes_controller.pipe) do
      if flappy.x <= p.x + p.w/2 and flappy.x >= p.x + 10 and pointsCooldown <= 0 then
        if Ppoints <= points then
          psystem:emit(1)
        end
        points = points + 1
        pointsCooldown = 20
      end
    end
  end
end

function love.load()

  img = love.graphics.newImage"particle.png"
  hitbox = false
  for k,v in ipairs(lines) do
    Ppoints = tonumber(v)
  end
  Ppoints = 0
  Mx, My = love.mouse.getPosition()
  points = 0
  pointsCooldown = 20
  love.keyboard.setKeyRepeat(false)
  keycooldown = 0
  game = {}
  game.background = love.graphics.newImage"flappy_background.png"
  game.backgroundX = 0
  game.start = false
  pipes = {}
  pipes.speed = -2
  pipes.x = 0
  pipes.y = 0
  pipes.timer = 50
  pipes.image = love.graphics.newImage"flappy_bird_pipe.png"
  screen = {}
  screen.w = love.graphics.getWidth()
  screen.h = love.graphics.getHeight()
  flappy = {}
  flappy.x = screen.w/4
  flappy.y = screen.h/2
  flappy.h = 36
  flappy.w = 51
  flappy.ySpeed = 0
  flappy.image = love.graphics.newImage'flapp_bird.png'
  flappy.image2 = love.graphics.newImage'flapp_bird copie.png'
  flappy.image3 = love.graphics.newImage'flapp_bird.png'
  flappy.image4 = love.graphics.newImage'flapp_bird3.png'
  flappy.image5 = love.graphics.newImage'zubat.png'
  flappy.image6 = love.graphics.newImage'zubat flap.png'
  psystem = love.graphics.newParticleSystem(img, 1)
  psystem:setParticleLifetime(2, 2)
  psystem:setLinearAcceleration(-200, 200, -200, 200)
  psystem:setColors(255, 255, 255, 255, 255, 255, 255, 255)
end

function pipes_controller:spawnPipe(x, y)
  pipe = {}
  pipe.x = x
  pipe.y = y
  pipe.w = 110.4
  pipe.h = 365
  if pipes.timer <= 0 then
    table.insert(pipes_controller.pipe, pipe)
    pipes.timer = 120
  end
end

function love.update(dt)

  Mx, My = love.mouse.getPosition()
  
  pointsCooldown = pointsCooldown - .5
  
  keycooldown = keycooldown - .5
  
  ScoreCount()
  
  checkClickOnBox()
  if game.start == true then
    if flappy.ySpeed <= 0 and flappy.ySpeed >= -180 then
      flappy.image = love.graphics.newImage'zubat flap.png'
    else
      flappy.image = love.graphics.newImage'zubat.png'
    end
  end
  
  if love.keyboard.isDown("h") then
    hitbox = true
  else
    hitbox = false
  end
  
    if Ppoints <= points then
      Ppoints = points
    end
  
  if flappy.y >= screen.h - 40 or flappy.y <= 0 then
    game.start = false
  --  psystem:emit(500)
    flappy.y = screen.h/2
    keycooldown = 6
      points = 0
      for i = 1, 10 do
        table.remove(pipes_controller.pipe, 1)
      end
  end

  if game.start == false and love.keyboard.isDown("space") and keycooldown <= 0 then
    game.start = true
  end

pipes.y = math.random(-200, 0)
psystem:update(dt)
  if game.start == true then
    for _,e in pairs(pipes_controller.pipe) do
      e.x = e.x + pipes.speed
    end
    pipes.timer = pipes.timer - 1
    pipes_controller:spawnPipe( screen.w, pipes.y)
    pipes.x = pipes.x - 2
    flappy.y = flappy.y + flappy.ySpeed*dt
    flappy.ySpeed = flappy.ySpeed + 10
    game.backgroundX = game.backgroundX - 2
    checkCollision()
    if love.keyboard.isDown('space') then
      if keycooldown <= 0 then
        flappy.ySpeed = -200
        keycooldown = 3
      else
        keycooldown = 3
      end
    end
    if game.backgroundX < -576 then
      game.backgroundX = - 21
    end
  end

  for i,e in ipairs(pipes_controller.pipe) do
    if e.x <= -100 then
      table.remove(pipes_controller.pipe, i)
    end
  end
end

function love.draw() 
  love.graphics.setFont(font)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(game.background, game.backgroundX, 0, 0, 2, 1.6)
  love.graphics.setColor(255, 255, 255)
  
  for _,e in pairs(pipes_controller.pipe) do
      love.graphics.draw(pipes.image, e.x, e.y, 0, 2.4, 2)
      if hitbox == true then
        love.graphics.rectangle("line", e.x, e.y, e.w, e.h)
        love.graphics.rectangle("line", e.x, e.y + 500, e.w, e.h)
      end
  end
  
  if game.start == false then
    love.graphics.rectangle('fill', 20, 20, 56, 41, 5)
    love.graphics.draw(flappy.image3, 22.5, 22.5)
    love.graphics.rectangle('fill', 86, 20, 56, 41, 5)
    love.graphics.draw(flappy.image2, 88.5, 22.5)
    love.graphics.rectangle('fill', 152, 20, 56, 41, 5)
    love.graphics.draw(flappy.image4, 154.5, 22.5)
    love.graphics.rectangle('fill', 218, 20, 56, 41, 5)
    love.graphics.draw(flappy.image5,220.5, 22.5)
  end

  love.graphics.setColor(255, 255, 255)
  if hitbox == true then
    love.graphics.rectangle('line', flappy.x, flappy.y, flappy.w, flappy.h)
  end
  if game.start == true then
     love.graphics.print(points, screen.w/2, screen.h/4, 0, 2, 2)
  end
  love.graphics.print("High score: " .. Ppoints, 0, screen.h - 40)
  
  if game.start == false then
    love.graphics.print("Press space to start", screen.w/2 - 150, screen.h/3)
  end
  
  love.graphics.draw(psystem, flappy.x + flappy.w/2, flappy.y + flappy.h/2, 0, 2, 2)
  love.graphics.draw(flappy.image, flappy.x, flappy.y)
  
  --love.graphics.print(flappy.ySpeed, 100, 100)
  --love.graphics.print(My, 200, 200)
end
