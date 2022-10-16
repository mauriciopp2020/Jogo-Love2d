local px = player:getX()
local py = player:getY()

weapons = {}
weapons.holding = {}
weapons.holding.angleX = 1.7
weapons.holding.angleY = 1.7
weapons.holding.posX = px + 20
weapons.holding.posY = py + 10

function weapons:update(dt)
    weaponAngle = weaponMouseAngle()
    mouseXPos = love.mouse.getX()
    
    local px = player:getX()
    local py = player:getY()

    if mouseXPos > px then
        player.direction = 1
        weapons.holding.posX = px + 20
        weapons.holding.posX = weapons.holding.posX + player.speed * dt
        weapons.holding.posY = py + 10
        weapons.holding.posY = weapons.holding.posY + player.speed * dt
        weapons.holding.angleX = 1.7
        weapons.holding.angleY = 1.7
    else
        player.direction = -1
        weapons.holding.posX = px - 20
        weapons.holding.posX = weapons.holding.posX - player.speed * dt
        weapons.holding.posY = py + 10
        weapons.holding.posY = weapons.holding.posY + player.speed * dt
        weapons.holding.angleX = 1.7
        weapons.holding.angleY = -1.7
    end
end
