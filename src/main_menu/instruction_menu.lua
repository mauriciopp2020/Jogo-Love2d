instMenu = {}

function instMenu:load()
    suit.theme.color.normal.fg = {255,255,255}
    suit.theme.color.hovered = {bg = {200,230,255}, fg = {0,0,0}}
    suit.theme.color.active = {bg = {200,230,255}, fg = {0,0,0}}
end

function instMenu:update(dt)
    
     -- Put a button on the screen. If hit, show a message.
     suit.layout:reset(500,450)

     -- put 10 extra pixels between cells in each direction
     suit.layout:padding(30,30)

     if gameState == "instructions" then
        if suit.Button("Back", {id = 4}, suit.layout:row(300,30)).hit then
            soundManager.menuClick:play()
            gameState = "mainMenu"
         end
     end
end

function instMenu:draw()
    love.graphics.draw(sprites.bg, 0, 0)
    love.graphics.printf("WASD - Move Character \nSpacebar - Dash \nLeft Mouse Button - Shoot (Hold or Press)", 400, 320, 500, "center")
    suit.draw()
end