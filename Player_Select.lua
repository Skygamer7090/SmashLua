local c = require("Class")
local PS = c:derive("Player Select")
local PIcon = require("PlayerIcon")
local Point = require("Point")

local MENU_MARGIN = {
    UP = 50,
    DOWN = 50,
    LEFT = 50,
    RIGHT = 50,
}
local MENU_WIDTH = ORIGINAL_RES.x - (MENU_MARGIN.LEFT + MENU_MARGIN.RIGHT)
local MENU_HEIGHT = ORIGINAL_RES.y - (MENU_MARGIN.UP + MENU_MARGIN.DOWN)
local MENU_X = MENU_MARGIN.LEFT
local MENU_Y = MENU_MARGIN.UP
local MENU_FONT = FONTS.MENU_FONT

local COLUMNS = 10
local ROWS = 3


function PS:new()
    self.Selected = {}
    self.buttons = require("Menus/Player_Select_Menu")
    self.Characters = require("Character_List")
    self.PlayerIcons = {}
    self:AddPlayer()
end 

function PS:draw()

    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", 0, 0, ORIGINAL_RES.x, ORIGINAL_RES.y)

    love.graphics.setColor(0,1,1, 0.6)
    love.graphics.rectangle("fill", MENU_X + 5, MENU_Y + 5, MENU_WIDTH + 5, MENU_HEIGHT + 5)

    love.graphics.setColor(0,1,1)
    love.graphics.rectangle("fill", MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT)

    function draw_cells(i, v, box)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line", box.x, box.y, box.w, box.h)

        if v.image ~= nil then
            local img_scale_x = box.w / v.image:getWidth()
            local img_scale_y = box.w / v.image:getHeight()
            love.graphics.setColor(1,1,1)
            love.graphics.draw(v.image, box.x, box.y, 0, img_scale_x, img_scale_y)
        end 
        if i == self.Selected then
            love.graphics.setColor(0,1,0,0.5)
            love.graphics.rectangle("fill", box.x, box.y, box.w, box.h )
        end

        local ButtonText = love.graphics.newText(MENU_FONT, v.name)

        love.graphics.setColor(1,0,0)
        love.graphics.draw(ButtonText, box.x, box.y, 0, 0.5, 0.5)
    end

    for i,v in pairs(self.buttons) do
        local BUTTON_ALPHA
        if v.enabled then
            BUTTON_ALPHA = 1
        else
            BUTTON_ALPHA = 0
        end

        local box = v.box
        love.graphics.setColor(0, BUTTON_ALPHA, 0,0.5)
        local ButtonText = love.graphics.newText(MENU_FONT, v.name)
        love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)

        love.graphics.setColor(BUTTON_ALPHA,0,0)
        love.graphics.draw(ButtonText, box.x, box.y, 0, 1, 1, -box.w/2 + ButtonText:getWidth()/2, -box.h/2 + ButtonText:getHeight()/2)
    end

    local Padding = 100
    local Margin = 10
    for i,v in pairs(self.PlayerIcons) do 
        i = i - 1
        v:draw(Point(MENU_X + (i*100 + Margin*i) + Padding, MENU_Y + MENU_HEIGHT - 200 - Margin))
    end

    button_traverser(self.Characters,draw_cells)
end


local INDEX = 0
function PS:mousepressed(x, y, b, g)
    function on_button_click(i, v, box)
        
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            INDEX = (INDEX) % NB_OF_PLAYERS + 1
            self.Selected = i
            PLAYER_LIST[INDEX] = v.name
            self.PlayerIcons[INDEX].image = v.image
            print(INDEX, NB_OF_PLAYERS)
            
            print(INDEX, NB_OF_PLAYERS)
        end
    end

    button_traverser(self.Characters, on_button_click)
     
    for i,v in pairs(self.buttons) do
        if v.enabled then
            local box = v.box
            if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
                v.action(g, self, v)
            end
        end 
    end
end

function PS:AddPlayer()
    table.insert(self.PlayerIcons, PIcon())
end


-- goes through the list and executes the function at every itteration
function button_traverser(list, func)
    local list_margin = 20
    local box_margin = 5
    local row = 0
    local col = 0
    love.graphics.setColor(1,0,0)
    for i, v in pairs(list) do

        local box = {}
        box.w = (MENU_WIDTH - list_margin * 2 - COLUMNS * box_margin) / COLUMNS
        box.h = box.w
        box.x = MENU_X + list_margin + ((col - 1) * (box.w + box_margin))

        if box.x > (MENU_WIDTH - list_margin * 2) then 
            col = 0
            row = row + 1
            if row > ROWS then break end
        end
        
        box.x = MENU_X + list_margin + ((col) * (box.w + box_margin))
        box.y = MENU_Y + list_margin + row * (box.h + box_margin)

        col = col + 1
        func(i, v, box)
    end
end

return PS