function spawnZombie()

    local zombie = {}
    zombie.x = 0
    zombie.y = 0

    zombie.lastPosX = 0
    zombie.lastPosY = 0
    zombie.speed = 185
    zombie.dead = false
    zombie.shot = false
    zombie.dTimer = 0
    zombie.direction = 1
    zombie.fadeOut = 1
    zombie.scoreUp = {text = "+1", x = 0, y = 0}

    zombie.animations = {}
    zombie.animations.grid = anim8.newGrid(24, 24, sprites.zombieSheet:getWidth(), sprites.zombieSheet:getHeight())
    zombie.animations.run = anim8.newAnimation(zombie.animations.grid('1-6', 2), 0.1)
    zombie.animations.dead = anim8.newAnimation(zombie.animations.grid('1-6', 3), 0.2)
    zombie.animations.idle = anim8.newAnimation(zombie.animations.grid('1-4', 1), 0.2)
    zombie.animation = zombie.animations.run
    zombie.spriteSW, zombie.spriteSH = zombie.animations.dead:getDimensions()
    zombie.collider = world:newCircleCollider(zombie.x, zombie.y, 15)
    zombie.collider:setCollisionClass("Enemy")
    

    local spawnSide = math.random(1, 4) -- 1 to 4 represents each corner of the screen. This will randomly select one out of four sides where the zombie will spawn from.
    
    -- 1 is left side of the screen
    -- 2 is right side of the screen
    -- 3 is top of the screen
    -- 4 is the bottom of the screen

    if spawnSide == 1 then
        zombie.x = -30
        zombie.y = math.random(0, love.graphics:getHeight()) -- Get any value of top and bottom by using getHeight()
    elseif spawnSide == 2 then
        zombie.x = love.graphics.getWidth() + 30 -- By adding + 30 to player.x after getWidth() will place the zombie beyond the screen
        zombie.y = math.random(0, love.graphics:getHeight())
    elseif spawnSide == 3 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = -30
    elseif spawnSide == 4 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = love.graphics.getHeight() + 30
    end

    table.insert(zombies, zombie)

end

function spawnBuffZombie()

    local buffZombie = {}
    buffZombie.health = 4
    buffZombie.hit = false
    buffZombie.x = 0
    buffZombie.y = 0
    buffZombie.lastPosX = 0
    buffZombie.lastPosY = 0
    buffZombie.speed = 165
    buffZombie.dead = false
    buffZombie.killed = false
    buffZombie.dTimer = 0
    buffZombie.flashTimer = 0
    buffZombie.direction = 1
    buffZombie.scoreUp = {text = "+2", x = 0, y = 0}

    buffZombie.animations = {}
    buffZombie.animations.grid = anim8.newGrid(24, 24, sprites.buffZombie:getWidth(), sprites.buffZombie:getHeight())
    buffZombie.animations.run = anim8.newAnimation(buffZombie.animations.grid('1-6', 2), 0.1)
    buffZombie.animations.dead = anim8.newAnimation(buffZombie.animations.grid('1-6', 3), 0.2)
    buffZombie.animations.hit = anim8.newAnimation(buffZombie.animations.grid('1-6', 4), 0.1)
    buffZombie.animations.idle = anim8.newAnimation(buffZombie.animations.grid('1-4', 1), 0.2)
    buffZombie.animation = buffZombie.animations.run
    buffZombie.fadeOut = 1
    buffZombie.spriteSW, buffZombie.spriteSH = buffZombie.animations.dead:getDimensions()
    buffZombie.collider = world:newCircleCollider(buffZombie.x, buffZombie.y, 20)
    buffZombie.collider:setCollisionClass("Enemy")
    buffZombie.collider:setObject("Enemy")

    if score >= 100 then
        buffZombie.speed = 170
        buffZombie.health = 5
    end

    if score >= 150 then
        buffZombie.speed = 173
        buffZombie.health = 7
    end

    if score >= 220 then
        buffZombie.speed = 175
        buffZombie.health = 10
    end

    if score >= 300 then
        buffZombie.speed = 180
        buffZombie.health = 14
    end
    

    local spawnSide = math.random(1, 4) -- 1 to 4 represents each corner of the screen. This will randomly select one out of four sides where the zombie will spawn from.
    
    -- 1 is left side of the screen
    -- 2 is right side of the screen
    -- 3 is top of the screen
    -- 4 is the bottom of the screen

    if spawnSide == 1 then
        buffZombie.x = -30
        buffZombie.y = math.random(0, love.graphics:getHeight()) -- Get any value of top and bottom by using getHeight()
    elseif spawnSide == 2 then
        buffZombie.x = love.graphics.getWidth() + 30 -- By adding + 30 to player.x after getWidth() will place the zombie beyond the screen
        buffZombie.y = math.random(0, love.graphics:getHeight())
    elseif spawnSide == 3 then
        buffZombie.x = math.random(0, love.graphics.getWidth())
        buffZombie.y = -30
    elseif spawnSide == 4 then
        buffZombie.x = math.random(0, love.graphics.getWidth())
        buffZombie.y = love.graphics.getHeight() + 30
    end

    table.insert(buffZombies, buffZombie)

end

function spawnFastZombie()
    math.randomseed(os.time())
    local fastZombie = {}
    fastZombie.x = 0
    fastZombie.y = 0
    fastZombie.lastPosX = 0
    fastZombie.lastPosY = 0
    fastZombie.speed = math.random(370, 400)
    fastZombie.dead = false
    fastZombie.shot = false
    fastZombie.dTimer = 0
    fastZombie.direction = 1
    fastZombie.scoreUp = {text = "+1", x = 0, y = 0}

    fastZombie.animations = {}
    fastZombie.animations.grid = anim8.newGrid(24, 24, sprites.fastZombie:getWidth(), sprites.fastZombie:getHeight())
    fastZombie.animations.run = anim8.newAnimation(fastZombie.animations.grid('1-6', 2), 0.1)
    fastZombie.animations.dead = anim8.newAnimation(fastZombie.animations.grid('1-6', 3), 0.2)
    fastZombie.animations.idle = anim8.newAnimation(fastZombie.animations.grid('1-4', 1), 0.2)
    fastZombie.animation = fastZombie.animations.run
    fastZombie.fadeOut = 1
    fastZombie.spriteSW, fastZombie.spriteSH = fastZombie.animations.dead:getDimensions()
    fastZombie.collider = world:newCircleCollider(fastZombie.x, fastZombie.y, 15)
    fastZombie.collider:setCollisionClass("Enemy")

    local spawnSide = math.random(1, 4) -- 1 to 4 represents each corner of the screen. This will randomly select one out of four sides where the zombie will spawn from.
    -- 1 is left side of the screen
    -- 2 is right side of the screen
    -- 3 is top of the screen
    -- 4 is the bottom of the screen
    if spawnSide == 1 then
        fastZombie.x = -30
        fastZombie.y = math.random(0, love.graphics:getHeight()) -- Get any value of top and bottom by using getHeight()
    elseif spawnSide == 2 then
        fastZombie.x = love.graphics.getWidth() + 30 -- By adding + 30 to player.x after getWidth() will place the zombie beyond the screen
        fastZombie.y = math.random(0, love.graphics:getHeight())
    elseif spawnSide == 3 then
        fastZombie.x = math.random(0, love.graphics.getWidth())
        fastZombie.y = -30
    elseif spawnSide == 4 then
        fastZombie.x = math.random(0, love.graphics.getWidth())
        fastZombie.y = love.graphics.getHeight() + 30
    end

    table.insert(fastZombies, fastZombie)
end

function spawnBullets()

    local mouseX, mouseY = love.mouse.getPosition() --screen coords

    local dirX = mouseX - weapons.holding.posX
    local dirY = mouseY - weapons.holding.posY

    local dir_len = math.sqrt(dirX ^ 2 + dirY ^ 2)
    dirX = dirX / dir_len
    dirY = dirY / dir_len

    local bullet = {}
    bullet.x = weapons.holding.posX + dirX * 24 
    bullet.y = weapons.holding.posY + dirY * 24
    bullet.lastPosX = 0 --why is it 0?
    bullet.lastPosY = 0 --who knows?
    bullet.speed = 600 
    bullet.dead = false --what do you do when it's dead? why not delete it the moment it dies?
    bullet.direction = weaponMouseAngle() --this can be done way better, unless you want to exercise your CPU doing all that trigonometry
    bullet.width, bullet.height = sprites.bullet:getDimensions()
    table.insert(bullets, 1, bullet)

end