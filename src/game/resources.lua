sprites = {}
sprites.map = love.graphics.newImage("src/assets/images/map/map.png")
sprites.playerSheet = love.graphics.newImage("src/assets/images/sprites/player_sheet.png")
sprites.zombieSheet = love.graphics.newImage("src/assets/images/sprites/zombie_sheet.png")
sprites.fastZombie = love.graphics.newImage("src/assets/images/sprites/fast_zombie_sheet.png")
sprites.buffZombie = love.graphics.newImage("src/assets/images/sprites/buff_zombie_sheet.png")
sprites.bullet = love.graphics.newImage("src/assets/images/sprites/bullet.png")
sprites.rifle = love.graphics.newImage("src/assets/images/sprites/rifle.png")
sprites.bg = love.graphics.newImage("src/assets/images/menu/background.png")

fonts = {}
fonts.generalFont = love.graphics.newFont("src/assets/fonts/FieldGuide.TTF", 24)
fonts.pause = love.graphics.newFont("src/assets/fonts/FieldGuide.TTF", 32)
fonts.gameOver = love.graphics.newFont("src/assets/fonts/FieldGuide.TTF", 42)

soundManager = {}
soundManager.BGM = love.audio.newSource("src/assets/sound/bgm.mp3", "stream")
soundManager.BGM:setLooping(true)
soundManager.BGM:setVolume(0.1)

soundManager.MenuBGM = love.audio.newSource("src/assets/sound/main_menu_bgm.mp3", "stream")
soundManager.MenuBGM:setLooping(true)
soundManager.MenuBGM:setVolume(0.1)

soundManager.menuHover = love.audio.newSource("src/assets/sound/hover.wav", "static")
soundManager.menuHover:setVolume(0.1)

soundManager.menuClick = love.audio.newSource("src/assets/sound/clicked.wav", "static")
soundManager.menuClick:setVolume(0.2)

function sprites:draw()
    if not player.isDead then
        screen:apply()
    end
    love.graphics.draw(sprites.map, 0, 0)
end

if gameState == "playState" then
    love.graphics.setFont(fonts.generalFont)
end

if gameState == "mainMenu" then
    love.graphics.setFont(fonts.generalFont)
end

if pause then
    love.graphics.setFont(fonts.pause)
end