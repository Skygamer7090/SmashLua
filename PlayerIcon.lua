local c = require("Class")
local PIcon = c:derive("PlayerIcon")
require("Const")

local COLOR = {0,1,0}
local ICON_W = 100
local ICON_H = 100

function PIcon:new() 
    self.name = "P" .. NB_OF_PLAYERS
    self.image = nil
end

function PIcon:SetImage(img)
    self.image = love.graphics.newImage(img)
end

function PIcon:draw(OriginPoint)
    love.graphics.setColor(COLOR)
    love.graphics.rectangle("fill", OriginPoint.x, OriginPoint.y, ICON_W, ICON_H)

    if self.image ~= nil then   
        love.graphics.setColor(1,1,1)
        love.graphics.draw(self.image, OriginPoint.x, OriginPoint.y, 0, ICON_W / self.image:getWidth(), ICON_H / self.image:getHeight())
    end

    love.graphics.setColor(0,0,0)
    local Text = love.graphics.newText(FONTS.MENU_FONT, self.name)
    love.graphics.draw(Text, OriginPoint.x, OriginPoint.y)
end

return PIcon