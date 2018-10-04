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

--gets distance between 2 pts
function GetDistance(p1, p2)
    return math.sqrt(math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2))
end 

function Get2ShortestPoints(Points, t, sorted)
    local pts = {}
    for i,v in pairs(Points) do
        if v ~= Points.m then
            if not IsColRect(t.x, t.y, v.x, v.y, {Points.tl, Points.tr, Points.br, Points.bl}) then
                v.d = GetDistance(v, t)
                table.insert(pts, v)
            end
        end
    end
    
    table.sort(pts, function(o1, o2) return o1.d > o2.d end)
    return pts
end 

--detects line collision and where
function LineToLine(x1, y1, x2, y2,   x3, y3, x4, y4) 
    local uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    local uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    if (uA > 0 and uA < 1 and uB > 0 and uB < 1) then
        local intersectionX = x1 + (uA * (x2-x1));
        local intersectionY = y1 + (uA * (y2-y1)); 
        return true, intersectionX, intersectionY
    end    
    return false, 0, 0
end

--tests if line hits box
function IsColRect(x1, y1, x2, y2, rect) 
    for i,v in pairs(GetVerts(rect)) do
        --print(string.format("Intersection test: x = %i, y = %i | tx = %i, ty = %i | line = (%i, %i) -> (%i, %i) ", x1, y1, x2, y2,     rect[i].x, rect[i].y, rect[i2].x, rect[i2].y))
        if LineToLine(x1, y1, x2, y2,     v[1].x, v[1].y, v[2].x, v[2].y) then
            return true;
        end
    end
    return false
end

--returns the closest point in a list of points
function GetClosestPoint(x1,y2, pts)
    local closest = pts[1]
    local cd = GetDistance({x = x1, y = y2}, pts[1])
    for i,v in pairs(pts) do
        local dist = GetDistance({x = x1, y = y2}, pts[i])
        if dist <= cd then
            closest = pts[i]
        end
    end
    return closest
end

--returns relative x and y pos (-1 to 1) left to right
function GetRelPos(p1, p2)
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y

    if dx > 0 then dx = 1 else dx = -1 end
    if dy > 0 then dy = 1 else dy = -1 end

    return dx, dy
end

--checks if table contains value
function table.contains(t, val)
    for i,v in pairs(t) do
        if v == val then return true end
    end
    return false
end 

--gets the corner points and the midle points
function GetPoints(b1)
     --[[
            tr = top right
            tl = top left
            br = bottom right
            bl = bottom left
            m = middle point
        ]]


    return {
        tr = {x = b1.x + b1.w/2, y = b1.y - b1.h/2},
        tl = {x = b1.x - b1.w/2, y = b1.y - b1.h/2},
        br = {x = b1.x + b1.w/2, y = b1.y + b1.h/2},
        bl = {x = b1.x - b1.w/2, y = b1.y + b1.h/2},
        m = {x = b1.x, y = b1.y}
    }
end

--gets the verts from a rect
function GetVerts(rect)
    local verts = {}
    for i,_ in pairs(rect) do
        local i2 = (i % #rect) +1
        table.insert(verts, {{x = rect[i].x, y = rect[i].y}, {x = rect[i2].x,y = rect[i2].y}})
    end
    return verts
end

function GetDirection(p)
    return math.atan2(p.y, p.x)
end