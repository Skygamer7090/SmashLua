require "Const"

local c = require("Class")
local Menu = c:derive("Menu")
local Vector2 = require("Vector2")

local MENU_ITEM_OFFSET = 20
local MENU_FONT = FONTS.MENU_FONT
local MENU_WIDTH = 500
local MENU_HEIGHT = 400
local MENU_PADDING = 50

local BUTTON_HEIGHT = MENU_FONT:getHeight()
local BUTTON_WIDTH = 0

function Menu:new()
    -- container for all menus
    self.pos = Vector2(100,100)
    self.w = 300
    self.h = 300
    self.menus = {}
    self.menus_originals = {}
    self.queue = {}
    self.buttons = {}
    self.currentMenu = 1
    self:AddMenu("Menus/game_menu")

end 

function Menu:buttonPress(buttonName, contentTab)
    local menu_type = type(contentTab[buttonName])
    
    if buttonName == "back" then
        local t2 = contentTab
        local t1 = self.menus_originals[self.currentMenu]

        local prev = self.queue[#self.queue]
        table.remove(self.queue, #self.queue)
        return prev
    elseif menu_type == "function" then
        contentTab[buttonName](contentTab)

        -- returns the table unchanged
        return contentTab
    elseif menu_type == "table" then 
        -- returns the new table
        table.insert(self.queue, contentTab)
        return contentTab[buttonName]
    end
end

function searchTable(table, to_find)
    for i,v in pairs(table) do
        if v == to_find then
            return true 
        end
    end 
    return false
end

function GetParentTable(originalTab, currentTab) 
    print(type(originalTab), type(currentTab))
    local search = originalTab
    
    print(unpack(currentList))
    local found = false

    -- stops when the index is found
    while not found do
        -- if its not in current search table goes on
        for i,v in pairs(search) do
            found = searchTable(search, currentTab)
        end

    end

    return search
end

function Menu:draw()
    --- DRAW CONSTANTS ---
    local BORDER_COLOR = {102/255,255/255,102/255}
    local FILLING_COLOR = {0,204/255,0}
    local BORDER_THICKNESS = 5
    ----------------------
    local index = 0
    
    local max_width = 0
    local menu_bkg = {
        x = self.pos.x - MENU_PADDING/2,
        y = self.pos.y - MENU_PADDING/2,
        w = MENU_WIDTH,
        h = MENU_HEIGHT,
        r = MENU_PADDING*0.5,
    }

    --draws border
    love.graphics.setColor(BORDER_COLOR)
    love.graphics.rectangle("fill", menu_bkg.x, menu_bkg.y, menu_bkg.w, menu_bkg.h, menu_bkg.r)
 
    --draws filling
    love.graphics.setColor(FILLING_COLOR)
    love.graphics.rectangle("fill", menu_bkg.x + BORDER_THICKNESS/2, menu_bkg.y + BORDER_THICKNESS/2, menu_bkg.w - BORDER_THICKNESS, menu_bkg.h - BORDER_THICKNESS, menu_bkg.r)
   
    --draw Title
    --love.graphics.newText()

    love.graphics.setColor(1,1,1)
    for i,v in pairs(self.menus[self.currentMenu]) do
        local text = love.graphics.newText(MENU_FONT,"- " .. i)
        local width = text:getWidth()

        if width > max_width then
            max_width = width
        end
        
        love.graphics.draw(text, self.pos.x, self.pos.y + index * MENU_ITEM_OFFSET)
        index = index + 1
    end
    MENU_HEIGHT = index * BUTTON_HEIGHT + MENU_PADDING
    MENU_WIDTH = max_width + MENU_PADDING
    BUTTON_WIDTH = max_width
end

function Menu:mousepressed(x, y, b)
    local index = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        local box = {
            x = self.pos.x,
            y = self.pos.y + index * MENU_ITEM_OFFSET,
            w = BUTTON_WIDTH,
            h = BUTTON_HEIGHT
        }
        
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            self.menus[self.currentMenu] = self:buttonPress(i, self.menus[self.currentMenu])
        end

        index = index + 1
    end
end

function Menu:AddMenu(menuLink)
    --loads the menu table
    local game_menu = require(menuLink)


    --final insert
    table.insert(self.menus, game_menu)
    table.insert(self.menus_originals, game_menu)
    table.insert(self.queue, game_menu)
end

return Menu