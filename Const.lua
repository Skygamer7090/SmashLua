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

function Get2ShortestPoints(Points, targetP)
    local pts = {}
    for i,v in pairs(Points) do
        if v ~= Points.m then   
            table.insert(pts, {p = v, d = GetDistance(v, targetP)})
        end
    end 
    SortBy(pts, "d")
    return pts[1].p, pts[2].p
end

function SortBy(table, key)
    for i, v in pairs(table) do
        if v[key] < base then
            
        end
    end

    -- sort here
end

function swap(v1, v2)
    local temp = v2
    v2 = v1
    v1 = temp
end