--the state of the global game
GAME_STATE = "OPENING"

--the state of the match
IN_GAME_STATE = "PLAY"

PLAYER_LIST = {}
NB_OF_PLAYERS = 1

FONTS = {
    MENU_FONT = love.graphics.newFont("BEBAS.ttf", 30)
}

local Point = require("Point")
local Ray = require("Ray")

ORIGINAL_RES = {x = 800, y = 600}
SCALE = {x = love.graphics.getWidth()/ ORIGINAL_RES.x, y = love.graphics.getHeight() / ORIGINAL_RES.y}
print(SCALE.x, SCALE.y)

--gets distance between 2 pts
--point#1, point#2
function GetDistance(p1, p2)
    return math.sqrt(math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2))
end 

--Gets the closest points from a table of points
--the original point, the table of points
function GetClosestPoints(Points, p)
    local pts = {}
    for i,v in pairs(Points) do
        if v ~= Points.m then
            local R = Ray(p.x, p.y, v.x, v.y)
            if not GetRayRectCollision(R, {Points.tl, Points.tr, Points.br, Points.bl}) then
                v.d = GetDistance(v, R:GetOriginPoint())
                table.insert(pts, v)
            end
        end
    end
    
    table.sort(pts, function(o1, o2) return o1.d > o2.d end)
    return pts
end 

--tests if line hits box
--Ray, rect (table with 4 points)
function GetRayRectCollision(Ray, rect) 
    for i,v in pairs(GetRays(rect)) do
        if Ray:CheckCollision(v) then
            return true;
        end
    end
    return false
end

--returns the closest point in a list of points
--origin point, table of points to check
function GetClosestPoint(p, pts)
    local closest = pts[1]
    local cd = GetDistance(p, pts[1])
    for i,v in pairs(pts) do
        local dist = GetDistance(p, pts[i])
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
--table to check in, value to check for
function table.contains(t, val)
    for i,v in pairs(t) do
        if v == val then return true end
    end
    return false
end 

--gets the corner points and the midle points
--the box to get corners from
function GetPoints(b1)
     --[[
            tr = top right
            tl = top left
            br = bottom right
            bl = bottom left
            m = middle point
        ]]


    return {
        tr = Point(b1.x + b1.w/2, b1.y - b1.h/2),
        tl = Point(b1.x - b1.w/2, b1.y - b1.h/2),
        br = Point(b1.x + b1.w/2, b1.y + b1.h/2),
        bl = Point(b1.x - b1.w/2, b1.y + b1.h/2),
        m = Point(b1.x, b1.y)
    }
end

--gets the Rays from a rect
--the rectangle to get Rays from
function GetRays(rect)
    local verts = {}
    for i,_ in pairs(rect) do
        local i2 = (i % #rect) +1
        local r = Ray(rect[i].x, rect[i].y, rect[i2].x, rect[i2].y)
        table.insert(verts, r)
    end
    return verts
end

function GetDirection(p)
    return math.atan2(p.y, p.x)
end