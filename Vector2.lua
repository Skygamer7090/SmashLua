local c = require("Class")
local v = c:derive("Vector2")

function v:new(x, y)
    self.x = x
    self.y = y
end

return v