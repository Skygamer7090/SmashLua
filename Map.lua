local c = require("Class")
local Col = require("Collider")
local m = c:derive("Map")

function m:new(Name, drawMap, colMap)
    self.Name = Name
    self.Collider = Col(require(colMap))
    print(type(self.Collider.cols))
    self.image = love.graphics.newImage(drawMap)
end

function m:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image)
    --self.Collider:drawDEBUG()
end

function m:update(dt, players)
    for pi, p in pairs(players) do
        for ci, c in pairs(self.Collider.cols) do
            if  p.x + p.w > c.x and 
                p.x < c.x + c.w and 
                p.y + p.h > c.y and
                p.y < c.y + c.h then    
                    error("player collided with map")
            end
        end
    end
end



return m