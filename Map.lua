local c = require("Class")
local Col = require("Collider")
local m = c:derive("Map")

function m:new(Name, drawMap, colMap)

    self.lines = {}

    self.Name = Name
    self.Collider = Col(require(colMap))
    self.image = love.graphics.newImage(drawMap)
end

function m:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image)
    
    --self.Collider:drawDEBUG()

    for i,v in pairs(self.lines) do
        love.graphics.setColor(1,1,1)
        love.graphics.line(v[1].x, v[1].y, v[2].x, v[2].y)
        love.graphics.print(string.format("(%i, %i) -> (%i, %i)",v[1].x, v[1].y,v[2].x,v[2].y), v[2].x, v[2].y)
    end
    love.graphics.setColor(1, 1, 1)
end

function m:update(dt, players)
    self.lines = {}
    for pi, p in pairs(players) do
        for ci, c in pairs(self.Collider.cols) do
            local b1 = p.col
            local b2 = c

            b1.c = GetPoints(b1)
            b2.c = GetPoints(b2)
            

            local fromPlayer = Get2ShortestPoints(b1.c, b2.c.m)
             --Debugging
            if ci == 1 then
                --table.insert(self.lines, {{x = b2.c.m.x,y = b2.c.m.y}, {x = fromPlayer[#fromPlayer].x, y = fromPlayer[#fromPlayer].y}})
                --table.insert(self.lines, {{x = b2.c.m.x,y = b2.c.m.y}, {x = b1.c.m.x, y = b1.c.m.y}})
            end 

            local ptClosestCorner = {x = fromPlayer[#fromPlayer].x, y = fromPlayer[#fromPlayer].y}

            local pts = Get2ShortestPoints(b2.c, b1.c.m, true)
            if #pts == 3 then
                table.insert(self.lines, {{x = b1.c.m.x,y = b1.c.m.y}, GetClosestPoint(b1.c.m.x,b1.c.m.y, pts)})
            else   
                for i,v in pairs(pts) do
                    --table.insert(self.lines, {{x = b1.c.m.x,y = b1.c.m.y}, {x = v.x, y = v.y}})
                    
                end
            end
            table.insert(self.lines, {{x = b2.c.m.x,y = b2.c.m.y}, {x = ptClosestCorner.x, y = ptClosestCorner.y}})
                
            local dx, dy = GetRelPos(ptClosestCorner, b2.c.m)
        
            local direction = ""
            
            if pts[1].x == pts[2].x then
                if b1.x < b2.c.m.x then
                    direction = "left"
                else
                    direction = "right"
                end
            end
            
            if pts[1].y == pts[2].y then
                if b1.y < b2.c.m.y then
                    direction = "up"
                else
                    direction = "down"
                end
            end
            --print(dx, dy, direction)
            local closest = GetClosestPoint(b1.x, b1.y, pts)
           
            if  b1.x - b1.w/2 < b2.x + b2.w/2 and
                b1.x + b1.w/2 > b2.x - b2.w/2 and
                b1.y - b1.h/2 < b2.y + b2.h/2 and
                b1.y + b1.h/2 > b2.y - b2.h/2 
            then
                --print(direction, #pts)
                if direction == "up" then
                    if b1.y < b2.y then
                        p.yv = 0; b1.y = closest.y - b1.h/2 
                        p.ground = true 
                        p.jumps = p.MaxJumps 
                        --print(direction, b1.y + b1.h, b2.x + b2.h)
                    end
                end
                if direction == "down" then p.yv = 0; b1.y = closest.y + b.h/2; end
                if direction == "left" then p.xv = 0; b1.x = closest.x - b1.w/2 end
                if direction == "right" then p.xv = 0; b1.x = closest.x + b1.w/2 end
                if direction == "" then 
                   
                end
            end
        end
    end
end



return m