
-- If the project gets bigger i can implement a automatic tileset detection and addition system

-- function _tileset_load()
--     atlas = 1
--     tileset_size = tileset:getDimensions()
    
--     for tileset_y_pos = 0, (tileset_size/tilesize) do
--         for tileset_x_pos = 0, (tileset_size/tilesize) do
--             tiles[atlas] = love.graphics.newQuad(tileset_x_pos * 8, tileset_y_pos * 8, tilesize, tilesize, tileset:getDimensions())
--             atlas += 1
--         end
--     end

--     return true
-- end