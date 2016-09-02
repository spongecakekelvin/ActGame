-- GameView.lua
local tClass =  class("ControlView", ui.BaseLayer)
local AnimData = DataManager.AnimData

local OPACITY_UNSELECT = 150
local OPACITY_SELECT = 255

function tClass:ctor()
    tClass.super.ctor(self)
    self:addTouch()

    self.bg = ui.newSpr("res/mainUI/mainUI/controllBg.png")
    self.size = self.bg:getContentSize()
    self:setContentSize(self.size)
    self:addChild(self.bg)
    ui.align(self, self.bg)

    self.point = ui.newSpr("res/mainUI/mainUI/controllPoint.png")
    ui.align(self.bg, self.point)
    self.bg:addChild(self.point, 1)
    self.originPos = cc.p(self.point:getPosition())

    self.maxRadius = (self.size.width - self.point:getContentSize().width) / 2

    self:setOpacity(OPACITY_UNSELECT)
end

function tClass:onEnter()
    tClass.super.onEnter(self)
end

function tClass:onExit()
	tClass.super.onExit(self)
end



function tClass:onTouchBegan(touch, event)
	local isIn = tClass.super.onTouchBegan(self, touch, event)
    if isIn then
        local pos = self.bg:convertToNodeSpace(touch:getLocation())
        self.point:setPosition(pos)
        self.isTouchBegan = true
        self:setOpacity(OPACITY_SELECT)
    end
    return isIn
end

function tClass:onTouchMoved(touch, event)
    local isTouch = helper.isTouch(self, touch)
    if self.isTouchBegan then
        local location = touch:getLocation()
        local locationInNode = self.bg:convertToNodeSpace(location)
        local offset = cc.pSub(locationInNode, self.originPos)
        local radius = math.sqrt(math.pow(offset.x, 2) + math.pow(offset.y, 2))
        local angle = math.deg(math.atan(offset.x/offset.y))
        if offset.y < 0 then
            angle = angle + 180
        elseif offset.x < 0 then
            angle = angle + 360
        end
        local pos = cc.p(0,0)
        if radius > self.maxRadius then
            radius = self.maxRadius
            pos.x = self.originPos.x+radius*math.sin(math.rad(angle))
            pos.y = self.originPos.y+radius*math.cos(math.rad(angle))
        else
            pos.x = locationInNode.x
            pos.y = locationInNode.y     
        end
        self.point:setPosition(pos)

        if offset.x ~= 0 and ElementManager.myRole:isStand() then
            ElementManager.myRole:walkOffset(cc.p(offset.x > 0 and 1 or -1, 0))
        end
    end
    return isTouch
end

function tClass:onTouchEnded(touch, event)
    local isTouch = helper.isTouch(self, touch)
    if self.isTouchBegan then
        self.isTouchBegan = false
        self.point:setPosition(self.originPos)
        self:setOpacity(OPACITY_UNSELECT)

        ElementManager.myRole:stand()
    end
    return isTouch
end

function tClass:setOpacity(value)
    self.bg:setOpacity(value)
    self.point:setOpacity(value)
end



return tClass