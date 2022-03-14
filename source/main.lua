import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "arrow"

local pd <const> = playdate
local gfx <const> = pd.graphics

local wallSprite = nil

local arrowResponses = {'freeze', 'slide', 'bounce', 'overlap'}
local arrowResponseIndex = 1
arrowCollisionResponse = arrowResponses[arrowResponseIndex]

local labelSprite = nil
local labelImage = nil

local function initialize()
    math.randomseed(playdate.getSecondsSinceEpoch())

    local wallImage = gfx.image.new("images/wall")
    wallSprite = gfx.sprite.new(wallImage)
    wallSprite:setCollideRect(0, 0, wallSprite:getSize())
    wallSprite:moveTo(300, 120)
    wallSprite:add()

    labelSprite = gfx.sprite.new()
    labelImage = gfx.image.new(200, 20)
    gfx.pushContext(labelImage)
        gfx.drawText("Collision Type: " .. arrowCollisionResponse, 0, 0)
    gfx.popContext()
    labelSprite:setImage(labelImage)
    labelSprite:add()
    labelSprite:setCenter(0, 0)
    labelSprite:moveTo(10, 10)
end

initialize()

function playdate.update()
    -- Press B to change collision type
    if pd.buttonJustPressed(pd.kButtonB) then
        arrowResponseIndex = arrowResponseIndex + 1 - math.floor(arrowResponseIndex/#arrowResponses) * #arrowResponses
        arrowCollisionResponse = arrowResponses[arrowResponseIndex]
        labelImage:clear(gfx.kColorWhite)
        gfx.pushContext(labelImage)
            gfx.drawText("Collision Type: " .. arrowCollisionResponse, 0, 0)
        gfx.popContext()
    end

    -- Press A to shoot arrows
    if pd.buttonIsPressed(pd.kButtonA) then
        local newArrow = Arrow(20, 120, 10, .1)
        newArrow:add()
    end

    gfx.sprite.update()
    pd.timer.updateTimers()
    pd.drawFPS(380, 10)
end
