menu = {}
local isOnButton = {startButton = false, instrButton = false, quitButton = false, backButton = false}

function menu:load()
    suit.theme.color.normal.fg = {255,255,255}
    suit.theme.color.hovered = {bg = {200,230,255}, fg = {0,0,0}}
    suit.theme.color.active = {bg = {200,230,255}, fg = {0,0,0}}
end

function menu:update(dt)
     -- Put a button on the screen. If hit, show a message.
     suit.layout:reset(500,350)

     -- put 10 extra pixels between cells in each direction
     suit.layout:padding(30,30)
 
     -- construct a cell of size 300x30 px and put the button into it
     if suit.Button("Começar", {id = 1}, suit.layout:row(300,30)).hit then
      soundManager.menuClick:play()
      gameState = "playState" 
      soundManager.BGM:play()
      love.audio.stop(soundManager.MenuBGM)
     end

     if suit.Button("Sobre", {id = 2 }, suit.layout:row(300,30)).hit then
      soundManager.menuClick:play()
      gameState = "instructions"
     end

     if gameState == "instructions" then
        if suit.Button("Back", {id = 4 }, suit.layout:row(300,30)).hit then
         soundManager.menuClick:play()
         gameState = "mainMenu"
         end
     end

     if suit.Button("Sair", {id = 3 }, suit.layout:row(300,30)).hit then
        love.event.quit()
     end

     if suit.isHovered(1) and not isOnButton.startButton then
      soundManager.menuHover:play()
      isOnButton.startButton = true
     elseif not suit.wasHovered(1) then
      isOnButton.startButton = false
     end

     if suit.isHovered(2) and not isOnButton.instrButton then
      soundManager.menuHover:play()
      isOnButton.instrButton = true
     elseif not suit.wasHovered(2) then
      isOnButton.instrButton = false
     end

     if suit.isHovered(3) and not isOnButton.quitButton then
      soundManager.menuHover:play()
      isOnButton.quitButton = true
     elseif not suit.wasHovered(3) then
      isOnButton.quitButton = false
     end

     if suit.isHovered(4) and not isOnButton.backButton then
      soundManager.menuHover:play()
      isOnButton.backButton = true
     elseif not suit.wasHovered(4) then
      isOnButton.backButton = false
     end
end

function menu:draw()
    love.graphics.draw(sprites.bg, 0, 0)
    suit.draw()
end