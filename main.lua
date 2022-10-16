require("src/game/initialisation")

function love.load()

    game:load()
    screen:setDimensions(love.graphics.getDimensions())
    menu:load()
    instMenu:load()
    fadeIn = 0

end

function love.update(dt)

    game:update(dt)
    flux.update(dt)

end

function love.draw()
    game:draw()
end

function love.keypressed(key)

    if key == "escape" then
        love.event.quit()
    end

    if key == "p" and gameState == "playState" then 
        pause = not pause 
    end

    if key == "r" then
        if player.isDead then
            love.event.quit( "restart" )
        end
    end

end

function love.focus(focused)
    if not focused then
        pause = true
    else
        pause = false
    end
end