local c = require("Class")
local Col = require("Collider")
local m = c:derive("Map")
local Point =  require("Point")

function m:new(Name, drawMap, colMap)

    self.lines = {}
    self.debugPt = {}

    self.Name = Name
    self.Collider = Col(require(colMap))
    self.image = love.graphics.newImage(drawMap)
end

function m:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image)
    
    self.Collider:drawDEBUG()

    for i,v in pairs(self.lines) do
        love.graphics.setColor(1,1,1)
        love.graphics.line(v[1].x, v[1].y, v[2].x, v[2].y)
        love.graphics.print(string.format("(%i, %i) -> (%i, %i)",v[1].x, v[1].y,v[2].x,v[2].y), v[2].x, v[2].y)
    end

    for i, v in pairs(self.debugPt) do
        love.graphics.setPointSize(20)
        love.graphics.points(v.x, v.y)
    end
    love.graphics.setColor(1, 1, 1)
end

function m:update(dt, players)
    self.lines = {}
    for PlayerIndex, Player in pairs(players) do
        for ColliderIndex, Collider in pairs(self.Collider.cols) do
            local PlayerCol = Player.col
            local MapCol = Collider

            PlayerCol.c = GetPoints(PlayerCol)
            MapCol.c = GetPoints(MapCol)
        
            local pts = GetClosestPoints(MapCol.c, PlayerCol.c.m)
            local RelPosX, RelPosY = GetRelPos(MapCol.c.m, PlayerCol.c.m)
            local Corner = Point(PlayerCol.c.m.x + RelPosX * PlayerCol.w/2, PlayerCol.c.m.y + RelPosY * PlayerCol.h/2)
            local closest = GetClosestPoint(Point(PlayerCol.x, PlayerCol.y), pts)

            --tests if there is standard box collision
            if  PlayerCol.x - PlayerCol.w/2 < MapCol.x + MapCol.w/2 and
                PlayerCol.x + PlayerCol.w/2 > MapCol.x - MapCol.w/2 and
                PlayerCol.y - PlayerCol.h/2 < MapCol.y + MapCol.h/2 and
                PlayerCol.y + PlayerCol.h/2 > MapCol.y - MapCol.h/2 
            then    
                local Direction = "-"
                local CollisionDeadzone = 5

                --if the closest corner of the player is inside the shape on the x axis
                if Corner.x > MapCol.c.tl.x + CollisionDeadzone and Corner.x < MapCol.c.tr.x - CollisionDeadzone then
                    --if the shape is on top or not
                    if PlayerCol.y < MapCol.y then
                        Direction = "up"
                    else
                        Direction = "down"
                    end
                else
                    --if player is on the left or the right
                    if PlayerCol.x < MapCol.c.tl.x then
                        Direction = "left"
                    elseif PlayerCol.x > MapCol.c.tr.x then
                        Direction = "right"
                    end
                end

                if Direction == "up" then
                    if PlayerCol.y < MapCol.y then
                        Player.yv = 0; PlayerCol.y = closest.y - PlayerCol.h/2 
                        Player.onGround = true 
                        Player.Jumps = Player.MaxJumps 
                    end
                end
                
                if Direction == "down" then Player.yv = 0; PlayerCol.y = closest.y + PlayerCol.h/2; end
                if Direction == "left" then 
                    if Player.xv > 0 then Player.xv = 0 end
                    PlayerCol.x = closest.x - PlayerCol.w/2 
                end
                if Direction == "right" then 
                    if Player.xv < 0 then Player.xv = 0 end
                    PlayerCol.x = closest.x + PlayerCol.w/2 
                end
            end
        end
    end
end

return m