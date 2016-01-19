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
	AnimManager.addToLoopList(self.animNode)
end

function tClass:onExit()
end


function tClass:createAnim(data)
	self.animNode = AnimNode.new(data)
	self:addChild(self.animNode)
	return self.animNode
end


function tClass:onLoop( ... )
	Log.i("需要子类重写该方法 Element:onLoop()")
end


-- + attack(target, data)
function tClass:attack()
	self.animNode:changeAction("attack")
end


return tClass