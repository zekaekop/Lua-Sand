
time = 0 -- for debuging also im not using it rn. you can enable it by turning it on with 1 at the for loop
game_speed = 2 -- after 100x speed up it starts to lag
shift = -1

function love.load()

    tileset = love.graphics.newImage("sand.png")
    tileset:setFilter("nearest","nearest")
    tilesize = 8

    map = {}
    map = _generate_map(200,150)

    tiles = {}
    tiles[1] = love.graphics.newQuad(0, 0, 8, 8, tileset:getDimensions())
    tiles[2] = love.graphics.newQuad(0, 0, 8, 8, tileset:getDimensions())
end

function love.draw()
    _zoom()
    for y = 1, #map do
        for x = 1, #map[y] do
            local tileid = map[y][x]
            _tile_transparito(tileid,x,y)
        end
    end
end

function love.update(dt)
    --local start = love.timer.getTime() -- performance debugging

    for i = 1, game_speed do
        local mouse_x,mouse_y = _mouse_to_tile_cords()
        if time >= 0 then
            for y = #map - 1, 1, -1 do
                for x = 1, #map[y] do
                    if map[y][x] == 2 then
                        _move(x, y)
                    end
                end
            end
            time = 0
        else
            time = time + (dt*30)
        end

        if love.mouse.isDown(1) then
            _spawn_sand()
        end
        --print("FPS: " .. love.timer.getFPS())
    end
    --local stop = love.timer.getTime()
    --print("Update time:", (stop - start) * 1000 .. " ms") -- performance debugging
end

function _move(x,y) -- basic sand
    if y + 1 > #map then return end
    
    if map[y+1][x] == 1 then
        map[y][x] = 1
        map[y+1][x] = 2
    elseif map[y+1][(x+shift)] == 1 then
        map[y][x] = 1
        map[y+1][(x+shift)] = 2
    elseif map[y+1][(x-shift)] == 1 then
        map[y][x] = 1
        map[y+1][(x-shift)] = 2
    end

    shift = -shift
end

function _tile_transparito(tileid,x,y)
    if tileid == 2 then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(tileset, tiles[tileid], (x-1)*8,(y-1)*8)
    else
        love.graphics.setColor(0.3, 0.3, 0.3, 0.5)
        love.graphics.draw(tileset, tiles[tileid], (x-1)*8,(y-1)*8)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function _zoom()
    local zoom = 0.5
    love.graphics.scale(zoom,zoom)
end

function _mouse_to_tile_cords()
    local x,y = love.mouse.getPosition()

    x = x / 0.5
    y = y / 0.5

    local tile_x = math.floor(x / tilesize) + 1
    local tile_y = math.floor(y / tilesize) + 1

    return tile_x, tile_y
end

function _spawn_sand()
    x,y = _mouse_to_tile_cords()
    map[y][x] = 2
end

function _generate_map(w,h)
    local map = {}

    for y = 1, h do
        map[y] = {}
        for x = 1, w do
            map[y][x] = 1
        end
    end

    return map
end