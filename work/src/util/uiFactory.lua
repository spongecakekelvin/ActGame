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
-- name 按钮文字
-- callback 点击回调(touchEnded才触发)
-- size 不为nil时, imgPath可以为或者根据size拉伸
--  
function ui.newButton(name, callback, imgPath, size)
    imgPath = imgPath or 1
    if type(imgPath) == "number" then
        -- if imgPath == 1 then
            imgPath = "res/common/btn_1.png"
        -- end
    end

    return ui.BaseButton.new(name, callback, imgPath, size)
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



--------------------------------------------------
---创建一个文本输入框
---@param  size 输入框的size 
---@param  image 输入框底图
---@param color 输入文字的颜色
---@param  lister :function(eventName, send)
--                      if eventName == "ended" then
--                      end 
--                  end
---@param  输入回调
--------------------------------------------------
function ui.newEditBox(
    size, listener,  
    images          --[[={normal = "#common/inputBj.png"} ]],
    color           --[[= ui.color.white]], 
    fontSize        --[[= ui.fontSize.def]],
    placeHolder     --当editbox是空的时候，显示的label
)
    images = images or {}
    local imageNormal = images["normal"] or "res/common/editBoxBg.png"
    local imagePressed = images["pressed"] or "res/common/editBoxBg.png"
    local imageDisabled = images["disabled"] or "res/common/editBoxBg.png"

    local imageNormalSpr, imagePressedSpr, imageDisabledSpr
    if imageNormal then
        imageNormalSpr = ui.new9Spr(imageNormal)
    end
    if imagePressed then
        imagePressedSpr = ui.new9Spr(imagePressed)
    end
    if imageDisabled then
        imageDisabledSpr = ui.new9Spr(imageDisabled)
    end
    
    local editbox = cc.EditBox:create(size, imageNormalSpr, imagePressedSpr, imageDisabledSpr)
    editbox:setFontColor(color or ui.c3b.white)
    editbox:setFont(GameConfig.defaultFonts, fontSize or ui.fontSize.def)
    
    if editbox then
        if listener then
            editbox:registerScriptEditBoxHandler(listener)
        end
        
        if placeHolder then
            editbox:setPlaceHolder(placeHolder)
            editbox:setPlaceholderFontColor(color or ui.color.white)
        end
    end

    return editbox
end


function ui.newRect(origin, destination, radius, color)
    radius = radius or 1.0
    color = color or cc.c4f(0,1,0,1)
    local drawNode = cc.DrawNode:create()
    drawNode:drawSegment(cc.p(origin.x, origin.y), cc.p(origin.x, destination.y), radius, color)
    drawNode:drawSegment(cc.p(origin.x, destination.y), cc.p(destination.x, destination.y), radius, color)
    drawNode:drawSegment(cc.p(destination.x, destination.y), cc.p(destination.x, origin.y), radius, color)
    drawNode:drawSegment(cc.p(destination.x, origin.y), cc.p(origin.x, origin.y), radius, color)
    return drawNode
end