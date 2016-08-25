--------------------------
-- ui 的实用接口
--------------------------
ui = ui or {}

-- 控件
local modules = {
	"BaseLayer",
    "BasePanel",
    "BaseButton",
}
for i, v in ipairs(modules) do
	ui[v] = require("components/" .. v)
end

ui.c3b = ui.c3b or {
    ["red"]         = cc.c3b(0xed, 0x17, 0x19),
    ["orange"]      = cc.c3b(0xf3, 0x98, 0x00),
    ["yellow"]      = cc.c3b(0xff, 0xff, 0x00),
    ["yellowish"]   = cc.c3b(0xbb, 0x95, 0x5a),
    ["green"]       = cc.c3b(0x0c, 0xea, 0x0f),
    ["blue"]        = cc.c3b(0x30, 0x6b, 0xfb),
    ["coffee"]      = cc.c3b(0x6b, 0x30, 0x00),
    ["purple"]      = cc.c3b(0xef, 0x47, 0xfd),
    ["black"]       = cc.c3b(0x00, 0x00, 0x00),
    ["white"]       = cc.c3b(0xe4, 0xcf, 0xae),
    ["gray"]        = cc.c3b(0x6e, 0x6f, 0x6f),
    ["gold"]        = cc.c3b(0xf9, 0xd5, 0x10),
    ["blues"]       = cc.c3b(0x00, 0xfd, 0xed),
    ["redBlack"]    = cc.c3b(0x37, 0x03, 0x01),
    ["redWhite"]    = cc.c3b(0xe4, 0xcf, 0xae),
}

ui.c4b = ui.c4b or {
    ["black"] = cc.c4b(0, 0, 0, 255),
    ["white"] = cc.c4b(255, 255, 255, 255),
}

ui.fontSize = ui.fontSize or {
    def = 20,
}

-- 设置对象偏移
-- return obj
ui.setOffset = function(obj, ox, oy)
    if not ox and not oy then
        return
    end

    if tolua.isnull(obj) then
        return
    end

    ox = ox or 0
    oy = oy or 0

    local originX, originY = obj:getPosition()
    obj:setPosition(originX + ox, originY + oy)

    return obj
end

--- 对齐对象
-- @ widthParam ：宽比例
-- @ heightParam ：高比例
-- @ anchorpoint ：child的锚点
-- @ offsetX : 偏移量x
-- @ offsetY : 偏移量y
-- return parent, child
ui.align = function(parent, child, wRate, hRate, anchorPoint, offsetX, offsetY)
    local parentSize = parent:getContentSize()
    anchorPoint = anchorPoint or {x = 0.5, y = 0.5}
    wRate = wRate or 0.5
    hRate = hRate or 0.5

    if offsetX or offsetY then
        child:setPosition(parentSize.width * wRate + offsetX or 0, parentSize.height * hRate + offsetY or 0)
    else
        child:setPosition(parentSize.width * wRate, parentSize.height * hRate)
    end
    child:ignoreAnchorPointForPosition(false)
    child:setAnchorPoint(anchorPoint)

    return parent, child
end


ui.addChild = function(parent, child, x, y, ap, zOrder)
    if x or y then
        child:setPosition(x or 0, y or 0)
    end
    
    if ap then
        child:ignoreAnchorPointForPosition(false)
        child:setAnchorPoint(ap)
    end
    if zOrder then
        parent:addChild(child, zOrder)
    else
        parent:addChild(child)
    end
end

ui.removeNode = function(node)
    if not tolua.isnull(node) then
        node:removeFromParent()
    end
end