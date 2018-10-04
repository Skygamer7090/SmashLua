local c = require("Class")
local Vector2 = require("Vector2")

local Character = c:derive("Character")

local GRAVITY_FORCE = -500
local JUMP_TIME = 0.3

function Character:new(name, i)
    local char = require("Characters/" .. name)

    self.number = i
    self.jumpTimer = 0
    
    self.controls = require("Controls/player" .. i)
    self.image = love.graphics.newImage(char.image) 
    self.speed = 200
    self.ground = false
    self.MaxJumps = 2
    self.jumps = self.MaxJumps
    self.yv = 100
    self.xv = 0
    self.airFriction = 0.05
    self.groundFriction = 0.1
    self.col = {x = 100, y = 0, w = self.image:getWidth(), h = self.image:getHeight(), r = 0}
end

function Character:Setcol(x,y) 
    self.col.x = x
    self.col.y = y
end

function Character:draw(MapCols)
    
    local pMid = GetPoints(self.col).m
    pMidDown = {x = pMid.x, y = pMid.y + ORIGINAL_RES.y}
    --love.graphics.line(pMid.x, pMid.y, pMidDown.x, pMidDown.y)

    local ShadowX, ShadowY  = 0,0;
    local hit = false

    for i,v in pairs(MapCols) do
        v.c = GetPoints(v) -- collider collision
        for u,line in pairs(GetVerts({v.c.tl, v.c.tr, v.c.br, v.c.bl})) do
            if not hit then
                --print("--From C:draw()-> " .. i .. " -> " .. u)
                hit, ShadowX, ShadowY = LineToLine(pMid.x, pMid.y, pMidDown.x, pMidDown.y, line[1].x, line[1].y, line[2].x, line[2].y)
            end
        end
    end

    if hit then
        self:DrawShadow(ShadowX, ShadowY)    
    end
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image, self.col.x, self.col.y, self.col.r, 1,1, self.col.w/2, self.col.h/2)
end

function Character:update(dt)  
   -- self.col.r = self.col.r + math.rad(10)
    local Input = love.keyboard.isDown
    self.jumpTimer = self.jumpTimer - dt
    if Input(self.controls.jump) then
        if self.ground then
            self:jump(300)    
        elseif self.jumps > 0 and self.jumpTimer < 0 then
            self:jump(300)
        end 
    end
    
	self.col.y = self.col.y + self.yv * dt             
	self.yv = self.yv - GRAVITY_FORCE * dt 

       
    if Input(self.controls.right) then
        self.xv = self.speed     
    elseif Input(self.controls.left) then
        self.xv = -self.speed
    end

    self.col.x = self.col.x + (self.xv * dt)
    if self.ground then
        self.xv = self.xv - self.xv * self.groundFriction
    else
        self.xv = self.xv - self.xv * self.airFriction
    end
end

function Character:jump(JumpForce)
    self.jumpTimer = JUMP_TIME
    self.jumps = self.jumps - 1
    self.yv = -JumpForce
    self.ground = false
end

function Character:drawDEBUG()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", self.col.x, self.col.y, self.col.w, self.col.h)
end

function Character:DrawShadow(x, y)
    love.graphics.setColor(0,0,0, 0.2)
    love.graphics.ellipse("fill", x, y, self.image:getWidth()/2, 15)
end

return Character