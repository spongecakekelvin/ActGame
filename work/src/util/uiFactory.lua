--------------------------
-- 工厂接口
--------------------------

ui = ui or {}

function ui.newLayer(c4b, contentSize)
    local tLayer
    if c4b then
        tLayer = cc.LayerColor:create(c4b)
    else
        tLayer = cc.Layer:create()
    end
    if contentSize then
        layer:setContentSize(contentSize)
    end
    return tLayer
end


function ui.newLabel(name, color, fontSize, dimensions)
    name = name or ""

    local fontSize = fontSize or ui.fontSize.def
    dimensions = dimensions or cc.size(0,0)
    color = color or ui.c3b.white

    local label = cc.Label:createWithSystemFont(name, GameConfig.defaultFonts, fontSize, dimensions)
    -- label.setFontSize = label.setSystemFontSize
    label:setColor(color)
    return label
end


-- style 在内部定义好了 按钮的资源路径
function ui.newButton(name, imgPath, callback, size)
    imgPath = imgPath or 1
    if type(imgPath) == "number" then
        -- if imgPath == 1 then
            imgPath = "res/common/btn_1.png"
        -- end
    end

    return ui.BaseButton.new(name, imgPath, callback, size)
end




function ui.newSpr(filename)

    if not filename or filename == "" then
        return cc.Sprite:create()
    end
    local sprite
    -- local tIsStr, filename = Helper.isTagStr(filename)
    -- if tIsStr then
    --     sprite = cc.Sprite:createWithSpriteFrameName(filename)
    -- else
        sprite = cc.Sprite:create(filename)
        if not sprite then
            sprite = ui.newSpr("res/kimibb.png")
            gprint("找不到图片: " .. filename)
        end
    -- end
    return sprite
end

-- size: 拉伸后的大小
-- capInsets: 中间区域(可以拉伸部分,外边保持不变)
function ui.new9Spr(filename, size, capInsets)
    local sprite
    -- local tIsStr, filename = Helper.isTagStr(filename)
    -- if tIsStr then
    --     if capInsets then
    --         sprite = cc.Scale9Sprite:createWithSpriteFrameName(filename, capInsets)
    --     else
    --         sprite = cc.Scale9Sprite:createWithSpriteFrameName(filename)
    --     end
    -- else
        if capInsets then
            sprite = cc.Scale9Sprite:create(capInsets, filename)
        else
            sprite = cc.Scale9Sprite:create(filename)
        end
    -- end
    if size then
        sprite:setPreferredSize(size)
    end
    return sprite
end



-- start --

--------------------------------
-- 创建并返回一个 PolygonShape （多边形）对象。
-- @function [parent=#display] newPolygon
-- @param table points 包含多边形每一个点坐标的表格对象
-- @param number scale 缩放比例
-- @return DrawNode#DrawNode ret (return value: cc.DrawNode)  DrawNode
-- @see DrawNode


--[[--

创建并返回一个 PolygonShape （多边形）对象。

~~~ lua

local points = {
    {10, 10},  -- point 1
    {50, 50},  -- point 2
    {100, 10}, -- point 3
}
local polygon = display.newPolygon(points)

~~~

]]
-- end --

function ui.newPolygon(points, params, drawNode)
    params = params or {}
    local scale = params.scale or 1.0
    local borderWidth = params.borderWidth or 0.5
    local fillColor = params.fillColor or cc.c4f(1, 1, 1, 0)
    local borderColor = params.borderColor or cc.c4f(0, 0, 0, 1)

    local pts = {}
    for i, p in ipairs(points) do
        pts[i] = {x = p[1] * scale, y = p[2] * scale}
    end

    drawNode = drawNode or cc.DrawNode:create()
    drawNode:drawPolygon(pts, {
        fillColor = fillColor,
        borderWidth = borderWidth,
        borderColor = borderColor
    })

    if drawNode then
        function drawNode:setLineStipple()
        end

        function drawNode:setLineStippleEnabled()
        end

        function drawNode:setLineColor(color)
        end
    end
    return drawNode
end