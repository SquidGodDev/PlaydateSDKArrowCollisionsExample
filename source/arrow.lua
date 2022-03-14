local pd <const> = playdate
local gfx <const> = pd.graphics

class('Arrow').extends(gfx.sprite)

function Arrow:init(x, y, speed, accel)
    Arrow.super.init(self)
    local arrowImage = gfx.image.new("images/arrow")
    self:setImage(arrowImage)
    self:moveTo(x, y)
    self:setCollideRect(0, 4, 12, 8)
    self:setGroups(1)
    self.speed = speed
    self.accel = accel
    self.curSpeed = speed
    self.minSpeed = speed / 2
    self.yOffset = math.random(-10, 10) / 10
    self.dir = 1
end

function Arrow:update()
    Arrow.super.update(self)
    -- Used for bouncing the arrow back
    -- local actualX, actualY, collisions, collisionsLen = self:moveWithCollisions(self.x + self.dir * self.curSpeed, self.y + self.yOffset)
    -- if collisionsLen ~= 0 then
    --     self.dir *= -1
    --     self:setRotation(180)
    -- end
    self:moveWithCollisions(self.x + self.dir * self.curSpeed, self.y + self.yOffset)
    self.curSpeed -= self.dir * self.accel
    if math.abs(self.curSpeed) < self.minSpeed then
        self.curSpeed = self.dir * self.minSpeed
    end
end

function Arrow:collisionResponse(other)
    return arrowCollisionResponse
end