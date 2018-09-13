local c = require("Class")
local PS = c:derive("Player Select")

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

local COLUMNS = 10
local ROWS = 3


function PS:new()
    self.Selected = {}
    self.Characters = require("Character_List")
end 

function PS:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", 0, 0, ORIGINAL_RES.x, ORIGINAL_RES.y)

    love.graphics.setColor(0,1,1, 0.6)
    love.graphics.rectangle("fill", MENU_X + 5, MENU_Y + 5, MENU_WIDTH + 5, MENU_HEIGHT + 5)

    love.graphics.setColor(0,1,1)
    love.graphics.rectangle("fill", MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT)

    function draw_cells(i, box, atr)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line", box.x, box.y, box.w, box.h)

        if atr.image ~= nil then
            local img_scale_x = box.w / atr.image:getWidth()
            local img_scale_y = box.w / atr.image:getHeight()
            love.graphics.setColor(1,1,1)
            love.graphics.draw(atr.image, box.x, box.y, 0, img_scale_x, img_scale_y)
        end 
        if i == self.Selected then
            love.graphics.setColor(0,1,0,0.5)
            love.graphics.rectangle("fill", box.x, box.y, box.w, box.h )
        end

        love.graphics.setColor(1,0,0)
        love.graphics.print(atr.name, box.x, box.y)
    end


    self:list_traverser(draw_cells)
end



function PS:mousepressed(x, y, b, g)
    function on_button_click(i, box, atr)
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            self.Selected = i
        end
    end

    self:list_traverser(on_button_click)
end



-- goes through the list and executes the function at every itteration
function PS:list_traverser(func)
    local list_margin = 20
    local box_margin = 5
    local row = 0
    local col = 0
    love.graphics.setColor(1,0,0)
    for i, v in pairs(self.Characters) do

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

        func(i, box, v)
    end
end

return PS