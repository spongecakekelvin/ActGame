-- GameView.lua
local tClass =  class("FightView", ui.BaseLayer)

local Role = require "element/Role"

function tClass:ctor()
    tClass.super.ctor(self)

    self.elementList = {}
end

function tClass:onEnter()
    tClass.super.onEnter(self)
    
    -- self:createMap()
    self:createElements()

    -- testing:
    local btn = ui.newButton("攻击", function()
    	for i, v in ipairs(self.elementList) do
    		v:attack()
    		-- v:changeAction("attack")
    	end
	end)
	ui.addChild(self, btn, 200, 500)
	
	local btn = ui.newButton("攻击2", function()
    	for i, v in ipairs(self.elementList) do
    		v:changeAction("attack1")
    	end
	end)
	ui.addChild(self, btn, 340, 500)

	local btn = ui.newButton("攻击3", function()
    	for i, v in ipairs(self.elementList) do
    		v:changeAction("attack2")
    	end
	end)
	ui.addChild(self, btn, 480, 500)

	local btn = ui.newButton("攻击3", function()
    	for i, v in ipairs(self.elementList) do
    		v:changeAction("attack3")
    	end
	end)
	ui.addChild(self, btn, 620, 500)

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
	role:setPosition(500, 100)
	self:addChild(role)

	self.elementList[#self.elementList + 1] = role
end






return tClass