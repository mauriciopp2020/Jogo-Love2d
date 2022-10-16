-- By calling atan2 we receive the radian rotation angle between the player.x pos and player.y pos and entity.y and entity.x
function entityToPlayerAngle(entity)
    local px = player:getX()
    local py = player:getY()
    return math.atan2(py - entity.y, px - entity.x)
end

-- Distance formula which will be then used to determine the distance between player and the entity
-- We will find if distance is very low, it will be considered a collision.
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end

-- By calling atan2 we receive the radian rotation angle between the weaponPos X, weaponPos Y and mouseY and mouseX
function weaponMouseAngle()
    return math.atan2(love.mouse.getY() - weapons.holding.posY, love.mouse.getX() - weapons.holding.posX)
end

function lerp(a,b,t) return (1-t)*a + t*b end
