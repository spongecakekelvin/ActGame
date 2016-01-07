-- GameView.lua
local tClass =  class("FightView", ui.BaseLayer)

local Role = require "element/Role"

function tClass:ctor()
    tClass.super.ctor(self)

    self.elementList = {}
end

function tClass:onEnter()
    tClass.super.onEnter(self)
    
    self:createMap()
    self:createElements()
end

function tClass:onExit()
	tClass.super.onExit(self)
end

function tClass:createMap()
	helper.remove(self.background)
	
	self.background = ui.newSpr("res/map/01.jpg")
	self:addChild(self.background, -1)
	ui.align(self, self.background)
end

function tClass:createElements()
	-- body
	local role = Role.new()
	role:setPosition(340, 100)
	self:addChild(role)

	self.elementList[#self.elementList + 1] = role
end



return tClass