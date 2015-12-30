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

    local label = cc.Label:createWithSystemFont(name, GameConfig.defaultFonts, fontSize, dimensions)
    -- label.setFontSize = label.setSystemFontSize
    label:setColor(color or ui.c3b.white)
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
