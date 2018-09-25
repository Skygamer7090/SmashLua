--the state of the global game
GAME_STATE = "OPENING"

--the state of the match
IN_GAME_STATE = "PLAY"

PLAYER_LIST = {}

FONTS = {
    MENU_FONT = love.graphics.newFont("BEBAS.ttf", 30)
}

ORIGINAL_RES = {x = 800, y = 600}
SCALE = {x = love.graphics.getWidth()/ ORIGINAL_RES.x, y = love.graphics.getHeight() / ORIGINAL_RES.y}
print(SCALE.x, SCALE.y)

function GetDistance(p1, p2)
    return math.sqrt(math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2))
end 

function Get2ShortestPoints(Points, t)
    local pts = {}
    for i,v in pairs(Points) do
        if v ~= Points.m then
            print("test col")
            if not IsColRect(t.x, t.y, v.x, v.y, {Points.tl, Points.tr, Points.br, Points.bl}) then
                table.insert(pts, v)
            end
        end
    end 

    


    return pts
end 

function LineToLine(x1, y1, x2, y2,   x3, y3, x4, y4) 
    local uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    local uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    if (uA > 0 and uA < 1 and uB > 0 and uB < 1) then
        intersectionX = x1 + (uA * (x2-x1));
        intersectionY = y1 + (uA * (y2-y1));
        
        return true
    end

    return false    
    
end

function IsColRect(x1, y1, x2, y2, rect) 
    
    for i,_ in pairs(rect) do
        local i2 = (i % #rect) +1
        
        --print(string.format("Intersection test: x = %i, y = %i | tx = %i, ty = %i | line = (%i, %i) -> (%i, %i) ", x1, y1, x2, y2,     rect[i].x, rect[i].y, rect[i2].x, rect[i2].y))
        if LineToLine(x1, y1, x2, y2,     rect[i].x, rect[i].y, rect[i2].x, rect[i2].y) then
            return true  
        end
    
    end
    return false
end