require "Const"

local c = require("Class")
local Menu = c:derive("Menu")
local Vector2 = require("Vector2")


local MENU_FONT = FONTS.MENU_FONT
local MENU_WIDTH = 500
local MENU_HEIGHT = 400
local MENU_PADDING = 50

local BUTTON_HEIGHT = MENU_FONT:getHeight()
local BUTTON_WIDTH = 0

local MENU_ITEM_OFFSET = BUTTON_HEIGHT + 5

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
    self.HighlightedInd = 1
    self.SelectedIndName = ""
    
    -- menu order:
    -- 1 = opening
    -- 2 = in game pause
    self:AddMenu("Menus/game_menu")
    self:AddMenu("Menus/pause_menu")
    
end 

function Menu:buttonPress(buttonName, contentTab, GameC)
    local menu_type = type(contentTab[buttonName])
    
    if buttonName == "back" then
        local t2 = contentTab
        local t1 = self.menus_originals[self.currentMenu]

        local prev = self.queue[#self.queue]
        table.remove(self.queue, #self.queue)
        return prev
    elseif menu_type == "function" then
        contentTab[buttonName](GameC)
        
        
        -- returns the table unchanged
        return contentTab
    elseif menu_type == "table" then 
        -- returns the new table
        table.insert(self.queue, contentTab)
        return contentTab[buttonName]
    end
end

function Menu:update(dt)
    local count = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        local box = {
            x = self.pos.x,
            y = self.pos.y + count * MENU_ITEM_OFFSET,
            w = BUTTON_WIDTH,
            h = BUTTON_HEIGHT
        }
        local x, y = love.mouse.getPosition()
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            self.HighlightedInd = count
            self.SelectedIndName = i
        end
        count = count + 1
    end
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
        r = MENU_PADDING * 0.5,
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

    
        max_width = math.max(width, max_width)
    
        if index == self.HighlightedInd then
            self.SelectedIndName = i
            love.graphics.rectangle("line", self.pos.x, self.pos.y + index * MENU_ITEM_OFFSET - 2, BUTTON_WIDTH, BUTTON_HEIGHT, 5)
        end
        love.graphics.draw(text, self.pos.x, self.pos.y + index * MENU_ITEM_OFFSET)
        index = index + 1
    end
    MENU_HEIGHT = index * BUTTON_HEIGHT + MENU_PADDING
    MENU_WIDTH = max_width + MENU_PADDING
    BUTTON_WIDTH = max_width
end

function Menu:mousepressed(x, y, b, controller)
    local index = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        local box = {
            x = self.pos.x,
            y = self.pos.y + index * MENU_ITEM_OFFSET,
            w = BUTTON_WIDTH,
            h = BUTTON_HEIGHT
        }
        
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            self.menus[self.currentMenu] = self:buttonPress(i, self.menus[self.currentMenu], controller)
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

function Menu:reset()
    GAME_STATE = "OPENING"
    IN_GAME_STATE = "PLAY"
    self.queue = {}
    self.menus = self.menus_originals
end

function Menu:keypressed(key, controller)
    

    local count = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        count = count + 1
    end

    if table.contains({"up", "w"}, key) then
        self.HighlightedInd = (self.HighlightedInd - 1) % count
    elseif table.contains({"down", "s"}, key) then
        self.HighlightedInd = (self.HighlightedInd + 1) % count
    end

    if key == "return" then
        self.menus[self.currentMenu] = self:buttonPress(self.SelectedIndName, self.menus[self.currentMenu], controller)
    end
end


return Menu