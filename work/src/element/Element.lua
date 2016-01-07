local tClass = class("Element", function()
	return cc.Node:create()
end)

local AnimNode = require "util/AnimNode"

--[[
+ skill(target, data)
+ attack(target, data)
+ stand()
+ walk(pos)
- onLoop()

AnimManager(1)->(n)animSp
]]--

function tClass:ctor()
	local function onNodeEvent(event)
        if "enter" == event then
            self:onEnter()
        elseif "exit" == event then
            self:onExit()
        end
    end
    self:registerScriptHandler(onNodeEvent)

	self.elementType = ElementType.Element
end

function tClass:onEnter()
	AnimManager.addToLoopList(self.animSpr)
end

function tClass:onExit()
end


function tClass:createAnim(data)
	self.animSpr = AnimNode.new(data)
	self:addChild(self.animSpr)
	return self.animSpr
end


function tClass:onLoop( ... )
	Log.i("需要子类重写该方法 Element:onLoop()")
end


return tClass