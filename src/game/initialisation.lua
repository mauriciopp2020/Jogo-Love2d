game = {}
CONSTANTS = {WINDOW_WIDTH = 1280, WINDOW_HEIGHT = 768}


function game:initialisation()

    -- Score and Timers
    Pontos = 0
    maxTime = 2
    timer = maxTime
    pause = false
    pauseValues = {flip = 1}
    bgValues = {alpha = 1, speed = 0.05}
    gameOverText = {youDied = "VOCÊ MORREU! - FIM DE JOGO", textAlpha = 0, speed = 0.20}

    -- PlayStates and World
    gameState = "mainMenu"

    -- Load libraries
    wf = require "src/libraries/windfield"
    anim8 = require "src/libraries/anim8/anim8"
    screen = require "src/libraries/shack/shack"
    Timer = require "src/libraries/timer"
    suit = require "src/libraries/suit"
    flux = require "src/libraries/flux"

    -- Load assets & resources
    require("src/game/world")
    require("src/game/resources")
    require("src/game/utilities")
    require("src/player/player")
    require("src/player/playerWeapon")
    require("src/entities/entity")
    require("src/entities/entitySpawner")
    require("src/main_menu/menu")
    require("src/main_menu/instruction_menu")

    if gameState == "mainMenu" then
        soundManager.MenuBGM:play()
    end

end

function game:load()

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("BILL`S JOURNEY")
    gameWindow = love.window.setMode(CONSTANTS.WINDOW_WIDTH, CONSTANTS.WINDOW_HEIGHT, { fullscreen = false, resizable = false, vsync = false})
    game:initialisation()

end

function game:draw()

    if gameState == "playState" then
        love.graphics.setFont(fonts.generalFont)
        love.graphics.setColor(255,255,255,fadeIn)
        sprites:draw()
        entity:draw()
        player:draw()
    end

    if gameState == "gameOver" then
        flux.to(bgValues, bgValues.speed, {alpha = 0.7}):ease("quadout")
        love.graphics.setColor(255,255,255,bgValues.alpha)
        sprites:draw()
        entity:draw()
        player:draw()
        love.graphics.setColor(255,255,255,1)
        love.graphics.setFont(fonts.gameOver)
        flux.to(gameOverText, gameOverText.speed, {textAlpha = 1}):ease("quadout"):delay(0.3)
        
        love.graphics.setColor(255,255,255,gameOverText.textAlpha)
        love.graphics.printf(gameOverText.youDied, 450 ,100, 400, "center")
        love.graphics.printf("SUA PONTUAÇÃO: " .. Pontos, 450 ,150, 400, "center")
        love.graphics.printf("PRESSIONE R PARA REINICIAR", 450 ,550, 400, "center")
        love.graphics.printf("PRESSIONE ESC PARA SAIR", 450 ,600, 400, "center")
    end

    if gameState == "mainMenu" then
        love.graphics.setColor(1,1,1)
        menu:draw()
    end

    if gameState == "instructions" then
        love.graphics.setColor(1,1,1)
        instMenu:draw()
    end

    if pause and gameState == "playState" then
        love.graphics.setColor(255,255,255,pauseValues.flip)
        love.graphics.setFont(fonts.pause)
        love.graphics.print(
        {'GAME PAUSED'},
        love.graphics.getWidth()/2 - 110
        ,
        math.floor(200),
        0,
        1.5,
        1.5
      )
    end

end

function game:update(dt)
    Timer.update(dt)

    if gameState == "playState" and pause then
        Timer.tween(3, pauseValues, {flip = 0}, 'in-linear')
        return
    end

    if gameState == "playState" then
        screen:update(dt)
        world:update(dt)
        entity:update(dt)
        player:update(dt)
        fadeIn = fadeIn + dt
        if fadeIn >= 1 then
            canMove = true
            fadeIn = 1
        end
    end

    if gameState == "gameOver" then
        world:update(dt)
        entity:update(dt)
        player:update(dt)
    end

    if gameState == "mainMenu" then
        menu:update(dt)
    end

    if gameState == "instructions" then
        instMenu:update(dt)
    end
end