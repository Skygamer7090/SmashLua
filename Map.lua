local c = require("Class")
local Col = require("Collider")
local m = c:derive("Map")

function m:new(Name, drawMap, colMap)
    self.Name = Name
    --self.Collider = Col(colMap)
    self.image = love.graphics.newImage(drawMap)
end

function m:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image)
end

function m:update(dt)

end



return m