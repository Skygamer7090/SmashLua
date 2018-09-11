local c = require("Class")
local Vector2 = require("Vector2")

local Character = c:derive("Character")

function Character:new(x, y)
    self.pos = Vector2(x, y)
end

function Character:draw()

end

function Character:update(dt)

end

return Character