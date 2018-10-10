local c = require("Class")
local Point = c:derive("Point")

function Point:new(x, y)
    self.x = x
    self.y = y
end 

return Point