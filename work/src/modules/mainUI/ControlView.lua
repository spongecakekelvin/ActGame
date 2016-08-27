-- GameView.lua
local tClass =  class("ControlView", ui.BaseLayer)

function tClass:ctor()
    tClass.super.ctor(self)
    self:addTouch()

    self.bg = ui.newSpr("res/mainUI/mainUI/controllBg.png")
    self.size = self.bg:getContentSize()
    self:setContentSize(self.size)
    self:addChild(self.bg)
    ui.align(self, self.bg)

    self.point = ui.newSpr("res/mainUI/mainUI/controllPoint.png")
    self.bg:addChild(self.point)
    ui.align(self.bg, self.point)
end

function tClass:onEnter()
    tClass.super.onEnter(self)
end

function tClass:onExit()
	tClass.super.onExit(self)
end



function tClass:onTouchBegan(touch, event)
	local isIn = tClass.super.onTouchBegan(self, touch, event)
    if helper.isTouch(self.point, touch) then
    end
    return isIn
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