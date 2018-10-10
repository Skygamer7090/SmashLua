local c = require("Class")
local Ray = c:derive("Ray")
local Point = require("Point")

function Ray:new(x, y, x2, y2) -- direction is in degrees
    self.pO = Point(x, y)
    self.pD = Point(x2,y2)
    self.length = size
    self.dir = direction
end 

function Ray:getPoints()
    local p1 = self:GetOriginPoint()
    local p2 = self:GetEndPoint()
    return p1.x, p1.y, p2.x, p2.y
end

function Ray:GetOriginPoint()
    return Point(self.pO.x, self.pO.y)
end

function Ray:GetEndPoint()
    return Point(self.pD.x, self.pD.y)
end

--detects line collision and where
function Ray:CheckCollision(Other) 
    local x1, y1, x2, y2 = self:getPoints()
    local x3, y3, x4, y4 = Other:getPoints()

    local uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    local uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    if (uA > 0 and uA < 1 and uB > 0 and uB < 1) then
        local intersectionX = x1 + (uA * (x2-x1));
        local intersectionY = y1 + (uA * (y2-y1)); 
        return true, intersectionX, intersectionY
    end    
    return false, -1, -1
end

function Ray:print()
    print(self:getPoints())
end

return Ray
