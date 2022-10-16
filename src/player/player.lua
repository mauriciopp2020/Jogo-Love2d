-- Player's collider
player = world:newCircleCollider(654, 398, 15)
player:setCollisionClass("Player")
player:setObject(player)

-- Player properties
player.width = 24
player.height = 24
player.speed = 250
player.direction = 1
player.dTimer = 0
player.dashTimer = 0.2
player.dashTimerMax = 0.2
player.dashTimerCooldown = 2
player.dashFadeOut = 1
local rateOfFire = 0.1
local rateOfFireTimer = rateOfFire

player.isDead = false
player.isMoving = false
player.isDashing = false
player.isDashingAnim = false
canMove = false
local canShoot = false

-- Player animations
player.grid = {}
player.grid.walk = anim8.newGrid(24, 24, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())

player.animations = {}
player.animations.idle = anim8.newAnimation(player.grid.walk('1-4', 1), 0.2)
player.animations.run = anim8.newAnimation(player.grid.walk('1-6', 2), 0.070)
player.animations.dead = anim8.newAnimation(player.grid.walk('1-12', 3), 0.1)
player.animations.dash = anim8.newAnimation(player.grid.walk('1-6', 5), 0.1)
player.animation = player.animations.idle

-- Player functions

function player:update(dt)
    player.isMoving = false
    weapons:update(dt)
    player.animation:update(dt)

    local vectorX = 0
    local vectorY = 0
    
   
    player:setLinearVelocity(vectorX * player.speed, vectorY * player.speed)

    if love.keyboard.isDown("space") and not player.isDashing and player.isMoving and not player.isDead and canMove then
        player.dashTimer = player.dashTimer - dt
        player.animation = player.animations.dash
        player.animations.dash:update(dt)
        player:setLinearVelocity(vectorX * 900, vectorY * 900)
        if player.dashTimer <= 0 then
            player.isDashing = true
            player.isDashingAnim = true
            player.dashFadeOut = player.dashFadeOut - dt
            Timer.tween(2, player, {dashTimer = 0.2})
            Timer.after(1, function() player.isDashing = false end)
            Timer.after(0.4, function() player.isDashingAnim = false end)
        end
    end

    if not canShoot and not player.isDead then
        rateOfFireTimer = rateOfFireTimer - (1 * dt)
        if rateOfFireTimer < 0 then
            canShoot = true
        end
    end

    if love.mouse.isDown(1) and canShoot and not player.isDead and canMove then
        spawnBullets()
        playerFired()
        canShoot = false
        rateOfFireTimer = rateOfFire
    end

        if vectorX == 0 and vectorY == 0 then
            player.isMoving = false
        elseif not player.isMoving then
            player.isMoving = true
        end

        if player.isMoving then
            player.animation = player.animations.run
        else
            player.animation = player.animations.idle
        end

        if player.isDashingAnim then
            player.animation = player.animations.dash
        else if player.isMoving then
            player.animation = player.animations.run
        else
            player.animation = player.animations.idle
        end
    end

        local px = player:getX()
        local py = player:getY()
        
        if py < 17 then
            player:setY(17)
        elseif px < 29 then
            player:setX(29)
        elseif px > 1256 then
            player:setX(1256)
        elseif py > 745 then
            player:setY(745)
        end

        if player:enter("Enemy") then
            player.isDead = true
            player.animation = player.animations.dead
            gameState = "gameOver"
        end

        if player.isDead then
            canShoot = false
            player.animations.dead:update(dt)
            player.dTimer = player.dTimer + dt
            if player.dTimer >= 0.7 then
                player.animations.dead:pauseAtEnd()
            end
        end

end

function player:draw()

    local px = player:getX()
    local py = player:getY()

    if not player.isDead then
        screen:apply()
        love.graphics.draw(sprites.rifle, weapons.holding.posX, weapons.holding.posY, weaponAngle, weapons.holding.angleX, weapons.holding.angleY, sprites.rifle:getWidth()/2, sprites.rifle:getHeight()/2)
        player.animation:draw(sprites.playerSheet, px, py, nil, 2 * player.direction, 2, player.width/2, player.height/2)
    else
        love.graphics.setColor(255,255,255,1)
        player.animations.dead:draw(sprites.playerSheet, px, py, nil, 2, 2, player.width/2, player.height/2)
    end
    love.graphics.setFont(fonts.generalFont)
    love.graphics.print("Total de inimigos derrotados: " .. Pontos, 30, 15)

    if player.isDashing then
        love.graphics.setFont(fonts.generalFont)
        love.graphics.setColor(217/255,30/255,24/255, dashFadeOut)
        love.graphics.print("Out of Stamina!", 30, 50)
    end

end


function playerFired()
    screen:setShake(1)
    screen:setRotation(.01)
    screen:zoom(1.01)
end