local c = require("Class")
local Vector2 = require("Vector2")

local Character = c:derive("Character")

local GRAVITY_FORCE = 15

function Character:new(x, y)
    print("Character created correctly")
    self.mass = 1
    self.yv = 0
    self.xv = 0
    self.pos = Vector2(x, y)
end

function Character:draw()

end

function Character:update(dt)
    
    --self.yv = self.mass * dt

end

return Character