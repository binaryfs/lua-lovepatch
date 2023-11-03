# Ninepatch
The Ninepatch library offers a simple way to use 9-patch images in the [LÖVE](https://love2d.org/) framework.

![Ninepatch demo screenshot](demoscreen.png?raw=true)

The primary aim behind creating this library was to provide 9-patch images that can be easily transformed and seamlessly loaded from an image atlas.

Ninepatch achieves this functionality by using meshes to represent 9-patch images. These meshes are structured in the following way:

     1    2    3    4
     ┌────┬────┬────┐
     │  / │  / │  / │
     5 /  6 /  7 /  8
     ├────┼────┼────┤
     │  / │  / │  / │
     9 / 10 / 11 / 12
     ├────┼────┼────┤
     │  / │  / │  / │
    13 / 14 / 15 / 16
     └────┴────┴────┘

The nine patches shown above have the following properties:
* The top-left, top-right, bottom-left and bottom-right patches each have a static width and height
* The top and bottom patches can stretch horizontally
* The left and right patches can stretch vertically
* The patch in the middle can stretch in all directions

## Usage

Basic example:

```lua
local ninepatch = require("libs.ninepatch")

local np

function love.load()
  np = ninepatch.newNinePatch(
    love.graphics.newImage("assets/texture.png"),
    10,  -- X position of 9-patch on texture
    10,  -- Y position of 9-patch on texture
    100, -- Width of 9-patch on texture
    100, -- Height of 9-patch on texture
    20,  -- Height of top row (margin-top)
    20,  -- Width of right column (margin-right)
    20,  -- Height of bottom row (margin-bottom)
    20   -- Width of left column (margin-left)
  )

  np:setSize(200, 300)
end

function love.draw()
  -- The draw method takes the same arguments as love.graphics.draw.
  np:draw(400, 500)
end
```

The `ninepatch.newNinePatch` function (which was used in the code above) is an optional convenience function that aims to provide a LÖVE-like API. If you don't like it, you can use the `NinePatch` class directly:

```lua
local NinePatch = require("libs.ninepatch.NinePatch")

local image = love.graphics.newImage("assets/texture.png")
-- Same parameters as for ninepatch.newNinePatch
local np = NinePatch.new(image, 10, 10, 100, 100, 20, 20, 20, 20)
```

And if you prefer named parameters, have a look at the `NinePatch.fromOptions` constructor:

```lua
local np = NinePatch.fromOptions{
  texture = love.graphics.newImage("assets/texture.png"),
  x = 10,
  y = 10,
  width = 100,
  height = 100,
  marginTop = 20,
  marginRight = 20,
  marginBottom = 20,
  marginLeft = 20,
}
```

Get the underlying mesh with the `NinePatch.getMesh` method to set vertext colors or to draw the mesh directly:

```lua
local np = ninepatch.newNinePatch(...)
local mesh = np:getMesh()

-- Tint it red
for vertex = 1, mesh:getVertextCount() do
  mesh:setVertexAttribute(vertex, 3, 1, 0, 0, 1)
end

love.graphics.draw(mesh, 10, 20)
```

## Demo

Clone this repository and run it with LÖVE to start the demo.

## Credits

The `simple-rpg-gui.png` image that is used in the demo was created by [Stanislav Ermizidis](https://opengameart.org/users/ermizidisstan) and is licensed under [CC0.](https://creativecommons.org/publicdomain/zero/1.0/)

## License

MIT License (see LICENSE file in project root)