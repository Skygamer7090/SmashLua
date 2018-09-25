local c = require("Class")
local Col = require("Collider")
local m = c:derive("Map")

function m:new(Name, drawMap, colMap)
    self.Name = Name
    self.Collider = Col(require(colMap))
    self.image = love.graphics.newImage(drawMap)
end

function m:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image)
    self.Collider:drawDEBUG()
end

function m:update(dt, players)
    for pi, p in pairs(players) do
        for ci, c in pairs(self.Collider.cols) do
            local b1 = p.col
            local b2 = c
            --[[
                tr = top right
                tl = top left
                br = bottom right
                bl = bottom left
                m = middle point
            ]]

            b1.c = {
                tr = {x = b1.x + b1.w, y = b1.y},
                tl = {x = b1.x, y = b1.y},
                br = {x = b1.x + b1.w, y = b1.y + b1.h},
                bl = {x = b1.x, y = b1.y + b1.h},
                m = {x = b1.x + b1.w/2, y = b1.y + b1.h/2}
            }
            b2.c = {
                tr = {x = b2.x + b2.w, y = b2.y},
                tl = {x = b2.x, y = b2.y},
                br = {x = b2.x + b2.w, y = b2.y + b2.h},
                bl = {x = b2.x, y = b2.y + b2.h},
                m = {x = b2.x + b2.w/2, y = b2.y + b2.h/2}
            }

            local pts = Get2ShortestPoints(b2.c, b1.c.m)
            
            print("_________ PTS __________")
            for i, v in pairs(pts) do
                print(v.x, v.y)
            end
            
            for i,v in pairs(pts) do
                if 
            end
        end
    end
end



return m