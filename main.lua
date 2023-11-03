-- ninepatch demo script

local ninepatch = require("init")

local elasticFactor = 0
local frames = {}

function love.load()
  local image = love.graphics.newImage("simple-rpg-gui.png")

  frames[1] = {
    x = 30,
    y = 30,
    width = 200,
    height = 300,
    elasticX = 0,
    elasticY = 50,
    patch = ninepatch.newNinePatch(image, 7, 6, 179, 94, 16, 16, 16, 16)
  }

  frames[2] = {
    x = 300,
    y = 30,
    width = 180,
    height = 40,
    elasticX = 20,
    elasticY = 0,
    patch = ninepatch.newNinePatch(image, 337, 9, 66, 21, 6, 6, 6, 6)
  }

  frames[3] = {
    x = 300,
    y = 130,
    width = 100,
    height = 100,
    elasticX = 20,
    elasticY = 30,
    rotation = math.rad(20),
    patch = ninepatch.newNinePatch(image, 416, 9, 66, 21, 6, 6, 6, 6)
  }

  frames[4] = {
    x = 400,
    y = 300,
    width = 300,
    height = 200,
    elasticX = 50,
    elasticY = 0,
    rotation = math.rad(-10),
    patch = ninepatch.newNinePatch(image, 7, 6, 179, 94, 16, 16, 16, 16)
  }

  -- Set vertex colors on the 9-patch to create a vertical gradient.
  local mesh = frames[4].patch:getMesh()
  for _, vertex in ipairs{10, 11} do
    mesh:setVertexAttribute(vertex, 3, 0.3, 0.5, 0.5, 1)
  end
end

--- @param dt number
function love.update(dt)
  elasticFactor = (elasticFactor + dt * 1.5) % (math.pi * 2)

  for _, frame in ipairs(frames) do
    frame.patch:setSize(
      frame.width + frame.elasticX * math.sin(elasticFactor),
      frame.height + frame.elasticY * math.sin(elasticFactor)
    )
  end
end

function love.draw()
  for _, frame in ipairs(frames) do
    frame.patch:draw(frame.x, frame.y, frame.rotation or 0)
  end
end