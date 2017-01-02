-- FightView.lua
local tClass =  class("FightView", ui.BaseLayer)

local AnimData = DataManager.AnimData
local Role = require "element/Role"

function tClass:ctor()
    tClass.super.ctor(self)
    self.elementList = {}
end

function tClass:onEnter()
    tClass.super.onEnter(self)
    self:initListeners()
    -- self:createMap()
    self:createElements()

    -- testing:
    local btn = ui.newButton("攻击", function()
    	for i, v in ipairs(self.elementList) do
    		v:attack()
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

	local btn = ui.newButton("走动", function()
    	for i, v in ipairs(self.elementList) do
    		v:changeAction("walk")
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
	local role = Role.new({}, {id=1})
	role:setPosition(300, 100)
	self:addChild(role)
	table.insert(self.elementList, role)
	self.role1 = role
	ElementManager.myRole = role

	-- local role = Role.new({name=12100, direction = DIR.left}, {id=2})
	-- -- local role = Role.new({direction = 6}, {id=2})
	-- role:setPosition(500, 100)
	-- self:addChild(role)
	-- -- table.insert(self.elementList, role)
	-- self.role2 = role

	-- self.role1:addEnemys{self.role2}
end


function tClass:initListeners()
	local function onKeyReleased(keyCode, event)
        local buf = string.format("Key %d was released!",keyCode)
        Log.d(buf)
        if keyCode == 6 then
            helper.exitConfirm()
        end
    end


    local eventDispatcher = self:getEventDispatcher()
    if self._keyboradListener then
        eventDispatcher:removeEventListener(self._keyboradListener)
    end
    self._keyboradListener = nil
    local listenerkeyboard = cc.EventListenerKeyboard:create()
    listenerkeyboard:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)

    eventDispatcher:addEventListenerWithSceneGraphPriority(listenerkeyboard, self)
    self._keyboradListener = listenerkeyboard
end




return tClass