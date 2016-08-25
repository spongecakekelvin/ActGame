--BaseLayer.lua
local tClass =  class("BaseLayer",function()
    return cc.Layer:create()
end)


function tClass:ctor()
    local function onNodeEvent(event)
        if "enter" == event then
            self:onEnter()
        elseif "exit" == event then
            self:onExit()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end


function tClass:onEnter()
    -- 用于引导
    if GameConfig.isInGuideMode and self.__cname then
        local len = string.len(self.__cname)
        if string.sub(self.__cname, len - 2, len) == "iew" then -- xxxview or xxxView
            local label = ui.newLabel(self.__cname, ui.c3b.green, 22)
            label:setLocalZOrder(100)
            ui.addChild(self, label)
            ui.align(self, label, math.random(), 1, cc.p(0.5, 1))
            Effect.fadeInOut(label, -1, 0.2, 0.5, 1)

            self._guide_registered = true
        end
    end
end


function tClass:onExit()
    if self._guide_registered then
        self._guide_registered = nil
    end
end


-- 添加吞噬类型的触摸事件
function tClass:addTouch()
    -- if not param then
    --     self.listener = helper.addTouch({node = self, swallow = true})
    -- else
        self.listener = helper.addTouch({node = self, typeName = "OneByOne", swallow = true, prority = 0})
    -- end
end


function tClass:setSwallow(value)
    if self.listener then
        helper.setSwallow(self.listener, value)
    end
end


function tClass:setModal(value)
    self.modal = value
    if self.modal then
        self:setSwallow(value)
    end
end


function tClass:onTouchBegan(touch, event)
    if self.modal then
        return true
    end

    return helper.isTouch(self, touch)
end


function tClass:onTouchMoved(touch, event)
    local isTouch = helper.isTouch(self, touch)
    return isTouch
end


function tClass:onTouchEnded(touch, event)
    local isTouch = helper.isTouch(self, touch)
    return isTouch
end


return tClass