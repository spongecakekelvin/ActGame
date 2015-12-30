-- GameView.lua
local tClass =  class("FightView", ui.BaseLayer)

function tClass:ctor()
    tClass.super.ctor(self)
end

function tClass:onEnter()
    tClass.super.onEnter(self)
    self:createMap()
end

function tClass:onExit()
	tClass.super.onExit(self)
end

function tClass:createMap()
	helper.remove(self.background)
	
	self.background = ui.newSpr("res/map/01.jpg")
	ui.addChild(self, self.background)
	ui.align(self, self.background)
end

function tClass:createElements()
	-- body
end



return tClass