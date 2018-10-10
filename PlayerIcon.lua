local c = require("Class")
local PIcon = c:derive("PlayerIcon")

local COLOR = {0,1,0}
local ICON_W = 100
local ICON_H = 200

function PIcon:new() 
    self.image = nil
end

function PIcon:SetImage(img)
    self.image = love.graphics.newImage(img)
end

function PIcon:draw(OriginPoint)
    love.graphics.setColor(COLOR)
    love.graphics.rectangle("fill", OriginPoint.x, OriginPoint.y, ICON_W, ICON_H)
end

return PIcon