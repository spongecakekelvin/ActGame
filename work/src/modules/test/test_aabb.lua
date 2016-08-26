-- test_aabb.lua
local function testFunc()
    local aabb = function(rect1, rect2)
        local x1 = rect1[1]
        local y1 = rect1[2]
        local w1 = rect1[3]
        local h1 = rect1[4]
        local x2 = rect2[1]
        local y2 = rect2[2]
        local w2 = rect2[3]
        local h2 = rect2[4]
        if x1 >= x2 and x1 >= w2 then --当矩形1 位于矩形2 的左侧  
            return false
        elseif x1 <= x2 and x1 + w1 <= x2 then --当矩形1 位于矩形2 的右侧
            return false
        elseif y1 >= y2 and y1 >= y2 + h2 then --当矩形1 位于矩形2 的上方
            return false
        elseif y1 <= y2 and y1 + h1 <= y2 then --当矩形1 位于矩形2 的下方
            return false
        end
        return true
    end

    local aabb = function (src, dest)
        local min_x, max_x
        if dest[1] > dest[3] then
            min_x = dest[3]
            max_x = dest[1]
        else
            min_x = dest[1]
            max_x = dest[3]
        end
        return not(
            (src[1] > max_x) or
            (src[3] < min_x) or
            (src[2] > dest[4]) or
            (src[4] < dest[2]))
    end

    local result = aabb({
    [1] = 231.9,
    [2] = 100,
    [3] = 564.1,
    [4] = 320.1,
    },
    {
        [1] = 535.9,
        [2] = 100,
        [3] = 868.1,
        [4] = 320.1,
    })
    Log.d("==== aaabb result == ", result)
end

return function() 
    Log.i("============== +Test Began+ ==============")
    testFunc() 
    Log.i("============== -Test Ended- ==============")
end