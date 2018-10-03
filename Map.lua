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
    --[[
    for i,v in pairs(self.lines) do
        love.graphics.line(v[1].x, v[1].y, v[2].x, v[2].y)
        love.graphics.print(string.format("(%i, %i) -> (%i, %i)",v[1].x, v[1].y,v[2].x,v[2].y), v[2].x, v[2].y)
    end
    ]]
    love.graphics.setColor(1, 1, 1)    
    

end

function m:update(dt, players)
    self.lines = {}
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

            local fromPlayer = Get2ShortestPoints(b1.c, b2.c.m)
             --Debugging
            if ci == 1 then
                table.insert(self.lines, {{x = b2.c.m.x,y = b2.c.m.y}, {x = fromPlayer[#fromPlayer].x, y = fromPlayer[#fromPlayer].y}})
            end 

            local ptClosestCorner = {x = fromPlayer[#fromPlayer].x, y = fromPlayer[#fromPlayer].y}

            local pts = Get2ShortestPoints(b2.c, b1.c.m, true)
            
            local dx, dy = GetRelPos(ptClosestCorner, b2.c.m)
            
            local nx, ny = 0
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
            
            local closest = GetClosestPoint(b1.x, b1.y, pts)

            if  b1.x < b2.x + b2.w and
                b1.x + b1.w > b2.x and
                b1.y < b2.y + b2.h and
                b1.y + b1.h > b2.y 
            then
                --print(direction, #pts)
                if direction == "up" then
                    if b1.y + b1.h < b2.y + b2.h then
                        p.yv = 0; b1.y = closest.y - b1.h 
                        p.ground = true 
                        p.jumps = p.MaxJumps 
                        --print(direction, b1.y + b1.h, b2.x + b2.h)
                    end
                end
                if direction == "down" then p.yv = 0; b1.y = closest.y; end
                if direction == "left" then p.xv = 0; b1.x = closest.x - b1.w end
                if direction == "right" then p.xv = 0; b1.x = closest.x end
                if direction == "" then 
                    p.xv = p.xv - p.speed * dx * dt
                    p.yv = p.yv - p.speed * dy * dt
                end
            end
        end
    end
end



return m