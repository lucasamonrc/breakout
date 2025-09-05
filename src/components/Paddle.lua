Paddle = Class {}

function Paddle:init()
    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 32

    self.dx = 0

    self.width = 64
    self.height = 16

    self.skin = 1
    self.size = 2
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    --[[
        Select the correct paddle quad from Frames['paddles'] using a compact index formula. The sprite sheet groups paddles by "skin", and each skin has 4 sizes (1..4). Lua arrays are 1-based, so we compute the linear index as: size + 4 * (skin - 1).

        Breakdown:
        - size: which paddle width/variation within the skin (1..4)
        - skin: which color/style group (1..N)
        - 4 * (skin - 1): skips all sprites from earlier skins (4 sprites each)

        Example: skin=2, size=1 -> 1 + 4*(2-1) = 5 => first sprite of second skin
    ]]
    love.graphics.draw(
        Textures['main'],
        Frames['paddles'][self.size + 4 * (self.skin - 1)],
        self.x, self.y
    )
end
