entity = {}

-- Entities
zombies = {}
fastZombies = {}
buffZombies = {}
bullets = {}

local fastZombieTimer = 10
local allowedBuffZombies = 4
local allowedZombies = 7
local buffZombieSpawned = false
local allowSpawnZombies = true
local spriteSheetWidth, spriteSheetHeight = player.animations.idle:getDimensions()

function entity:update(dt)

    for i,b in ipairs(bullets) do
            b.x = b.x + ( math.cos( b.direction ) * b.speed*dt)
            b.y = b.y + ( math.sin( b.direction ) * b.speed*dt)
    end

    -- The iterator for this loop is i which is set to the size of the table (returns total elements inside the table)
    -- The following 1 is an ending value where the loop ends once the loop reaches 1. Each time the loop goes through, it will be decreased
    -- by -1.
    for i=#bullets, 1, -1 do
        local b = bullets[i]

        -- The following if statement checks if the bullet goes outside the screen boundary
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
            -- When the bullet is outside the screen boundary, bullet from the Bullets table are removed one by one.
            bullets[i] = bullets[#bullets]
            bullets[#bullets] = nil
        end
    end

    for i, z in ipairs(zombies) do

        -- VectorX and VectorY are storing positions of player and zombie
        local vectorX = player:getX() - z.x
        local vectorY = player:getY() - z.y

        -- normalising vector
        local vectorLength = math.sqrt(vectorX ^ 2 + vectorY ^ 2)

        -- normising both vectors before updating zombies pos.
        vectorX = vectorX / vectorLength
        vectorY = vectorY / vectorLength

        if not player.isDead then
            z.x = z.x + vectorX * z.speed * dt
            z.collider:setX(z.x)
            z.y = z.y + vectorY * z.speed * dt
            z.collider:setY(z.y)
        end

        -- if player.x is higher than zombie's x, change direction accordingly
        if player:getX() > z.x then
            z.direction = 1
        else
            z.direction = -1
        end

        if z.shot then
            z.collider:setX(z.lastPosX)
            z.collider:setY(z.lastPosY)
            z.animations.dead:update(dt * 1.5)
            z.dTimer = z.dTimer + dt
            z.scoreUp.y = z.scoreUp.y - 2 * (dt * 5)
            if z.dTimer >= 0.7 then
                z.animations.dead:pauseAtEnd()
                z.fadeOut = z.fadeOut - dt
            end
            if z.fadeOut < 0 then
                z.collider:destroy()
                z.dead = true
            end
        end

        if player.isDead then
            z.animation = z.animations.idle
        end

        z.animation:update(dt)
    end

    for i, fz in ipairs(fastZombies) do
        -- VectorX and VecorY are storing positions of player and zombie
        local vectorX = player:getX() - fz.x
        local vectorY = player:getY() - fz.y

        -- normalising vector
        local vectorLength = math.sqrt(vectorX ^ 2 + vectorY ^ 2)

        -- normising both vectors before updating zombies pos.
        vectorX = vectorX / vectorLength
        vectorY = vectorY / vectorLength

        if not player.isDead then
            fz.x = fz.x + vectorX * fz.speed * dt
            fz.collider:setX(fz.x)
            fz.y = fz.y + vectorY * fz.speed * dt
            fz.collider:setY(fz.y)
        end

        -- if player.x is higher than zombie's x, change direction accordingly
        if player:getX() > fz.x then
            fz.direction = 1
        else
            fz.direction = -1
        end
        
        if fz.shot then
            fz.collider:setX(fz.lastPosX)
            fz.collider:setY(fz.lastPosY)
            fz.animations.dead:update(dt * 1.5)
            fz.dTimer = fz.dTimer + dt
            fz.scoreUp.y = fz.scoreUp.y - 2 * (dt * 5)
            if fz.dTimer >= 0.7 then
                fz.animations.dead:pauseAtEnd()
                fz.fadeOut = fz.fadeOut - dt
            end
            if fz.fadeOut < 0 then
                fz.collider:destroy()
                fz.dead = true
            end
        end

        if player.isDead then
            fz.animation = fz.animations.idle
        end

        fz.animation:update(dt)
    end

    for i, bz in ipairs(buffZombies) do
        -- VectorX and VecorY are storing positions of player and zombie
        local vectorX = player:getX() - bz.x
        local vectorY = player:getY() - bz.y

        -- normalising vector
        local vectorLength = math.sqrt(vectorX ^ 2 + vectorY ^ 2)

        -- normising both vectors before updating zombies pos.
        vectorX = vectorX / vectorLength
        vectorY = vectorY / vectorLength
        if not player.isDead then
            bz.x = bz.x + vectorX * bz.speed * dt
            bz.collider:setX(bz.x)
            bz.y = bz.y + vectorY * bz.speed * dt
            bz.collider:setY(bz.y)
        end

        -- if player.x is higher than zombie's x, change direction accordingly
        if player:getX() > bz.x then
            bz.direction = 1
        else
            bz.direction = -1
        end

        for j, b in ipairs (bullets) do
            if b.hit then
                b.collider:setX(bz.x)
                b.collider:setY(bz.y)
                b.dead = true
                b.collider:destroy()
            end
        end

        if bz.hit then
            bz.animation = bz.animations.hit
            bz.flashTimer = bz.flashTimer - dt * 4
                if bz.flashTimer < 0 then
                    bz.animation = bz.animations.run
                    bz.flashTimer = 1
                    bz.hit = false
                end
        end
        
        if bz.killed then
            bz.collider:setCollisionClass("Dead")
            bz.collider:setX(bz.lastPosX)
            bz.collider:setY(bz.lastPosY)
            bz.animations.dead:update(dt * 1.5)
            bz.dTimer = bz.dTimer + dt
            bz.scoreUp.y = bz.scoreUp.y - 2 * (dt * 5)
            if bz.dTimer >= 0.7 then
                bz.animations.dead:pauseAtEnd()
                bz.fadeOut = bz.fadeOut - dt
            end
                if bz.fadeOut < 0 then
                bz.collider:destroy()
                bz.dead = true
                end
        end

        if player.isDead then
            bz.animation = bz.animations.idle
        end

        bz.animation:update(dt)
    end

    -- This loop will go through every Zombie in Zombies table and detect if zombie is dead and if true, it will remove the Zombie from the Zombies table due to collision.
    for i=#zombies, 1, -1 do
        local z = zombies[i]
        if z.dead then
            zombies[i] = zombies[#zombies]
            zombies[#zombies] = nil
        end
    end

    for i=#fastZombies, 1, -1 do
        local fz = fastZombies[i]
        if fz.dead then
            fastZombies[i] = fastZombies[#fastZombies]
            fastZombies[#fastZombies] = nil
        end
    end

    for i=#buffZombies, 1, -1 do
        local bz = buffZombies[i]
        if bz.dead then
            buffZombies[i] = buffZombies[#buffZombies]
            buffZombies[#buffZombies] = nil
        end
    end

    -- This loop will go through every Bullet in Bullets table and detect if zombie is dead and if true, it will remove the Bullet from the Bullets table due to collision.
    for i=#bullets, 1, -1 do
        local b = bullets[i]
        if b.dead == true then
           table.remove(bullets, i)
        end
    end

    -- This loop will go through through every Zombie in Zombies table which also will go through all Bullets table within the nested loop.
    -- Every Zombie will be compared to every Bullet.
    for i,z in ipairs(zombies) do
        for j,b in ipairs(bullets) do
            -- if true, collision is detected by switching dead & shot flag to true.
            if distanceBetween(z.x, z.y, b.x, b.y) < 20 and z.shot == false then
                z.collider:setCollisionClass("Dead")
                z.lastPosX = z.x
                z.lastPosY = z.y
                z.shot = true
                b.dead = true
                Pontos = Pontos + 1
                z.scoreUp.x = z.lastPosX + 17
                z.scoreUp.y = z.lastPosY
            end
        end
    end

    for i,fz in ipairs(fastZombies) do
        for j,b in ipairs(bullets) do
            -- if true, collision is detected by switching dead flag to true.
            if distanceBetween(fz.x, fz.y, b.x, b.y) < 20 and fz.shot == false then
                fz.collider:setCollisionClass("Dead")
                fz.lastPosX = fz.x
                fz.lastPosY = fz.y
                fz.shot = true
                score = score + 1
                fz.scoreUp.x = fz.lastPosX + 17
                fz.scoreUp.y = fz.lastPosY
            end
        end
    end

    for i,bz in ipairs(buffZombies) do
        for j,b in ipairs(bullets) do
            -- if true, collision is detected by switching dead flag to true.
            if distanceBetween(bz.x, bz.y, b.x, b.y) < 20 and bz.killed == false then
                bz.health = bz.health - 1
                b.dead = true
                bz.hit = true
                if bz.health == 0 then
                    bz.lastPosX = bz.x
                    bz.lastPosY = bz.y
                    bz.killed = true
                    score = score + 2
                    bz.scoreUp.x = bz.lastPosX + 17
                    bz.scoreUp.y = bz.lastPosY
                end
            end
        end
    end

    -- If gameState is playState, spawn zombies every defined second
    if gameState == "playState" then
        local randomSpawn = math.random(1, 2000)

        -- Start decreasing timer by delta time.
        timer = timer - dt
        fastZombieTimer = fastZombieTimer - dt
        -- if timer is less than or equal to 0 use function spawnZombie() to spawn a zombie

        if timer <= 0 and Pontos >= 85 and #buffZombies < allowedBuffZombies and not player.isDead then
            spawnBuffZombie()
            maxTime = 0.95 * maxTime
            timer = maxTime
            buffZombieSpawned = true
        end

        if timer <= 0 and #zombies <= allowedZombies and allowSpawnZombies and not player.isDead then
            spawnZombie()
            maxTime = 0.95 * maxTime
            timer = maxTime
        end

        if fastZombieTimer <= 0 and Pontos >= 25 and randomSpawn == 7 and #fastZombies < 2 and not player.isDead then
            spawnFastZombie()
            fastZombieTimer = 10
        end    
        if buffZombieSpawned then
            allowedZombies = 2
            if score >= 250 then
                allowedZombies = 3
                allowedBuffZombies = 7
            end
        end
        if Pontos >= 200 then
            allowedZombies = 0
            allowedBuffZombies = 6
            allowSpawnZombies = false
        end
    end
end

function entity:draw()
    for i, z in ipairs(zombies) do
        if z.shot == false then
            z.animation:draw(sprites.zombieSheet, z.x, z.y, nil, 2 * z.direction, 2, spriteSheetWidth/2, spriteSheetHeight/2)
        else
            love.graphics.setColor(255,255,255,z.fadeOut)
            z.animations.dead:draw(sprites.zombieSheet, z.lastPosX, z.lastPosY, nil, 2, 2, z.spriteSW/2, z.spriteSH/2)
            love.graphics.print(z.scoreUp.text, z.scoreUp.x, z.scoreUp.y)
            love.graphics.setColor(255,255,255,255)
        end
    end

    for i, fz in ipairs(fastZombies) do
        if fz.shot == false then
            fz.animation:draw(sprites.fastZombie, fz.x, fz.y, nil, 2 * fz.direction, 2, spriteSheetWidth/2, spriteSheetHeight/2)   
        else
            love.graphics.setColor(255,255,255,fz.fadeOut)
            fz.animations.dead:draw(sprites.fastZombie, fz.lastPosX, fz.lastPosY, nil, 2, 2, fz.spriteSW/2, fz.spriteSH/2)
            love.graphics.print(fz.scoreUp.text, fz.scoreUp.x, fz.scoreUp.y)
            love.graphics.setColor(255,255,255,255)
        end
    end
        
        for i, bz in ipairs(buffZombies) do
            if bz.health > 0 then
                bz.animation:draw(sprites.buffZombie, bz.x, bz.y, nil, 2.5 * bz.direction, 2.5, spriteSheetWidth/2, spriteSheetHeight/2)
            else
                love.graphics.setColor(255,255,255,bz.fadeOut)
                bz.animations.dead:draw(sprites.buffZombie, bz.lastPosX, bz.lastPosY, nil, 2.5, 2.5, bz.spriteSW/2, bz.spriteSH/2)
                love.graphics.print(bz.scoreUp.text, bz.scoreUp.x, bz.scoreUp.y)
                love.graphics.setColor(255,255,255,255)
            end
        end

    for i, b in ipairs(bullets) do
        -- In the 5th param of the draw function, we're resizing the sprite by half, as we want it to be the same on x & y axis, we can simply pass nil on Y axis
        -- and it will inheir sx's param. Meaning it will be resized the same way on X and Y.
        love.graphics.draw(sprites.bullet, b.x, b.y, nil, nil, nil, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)
    end
end
