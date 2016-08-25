local tClass = class("Element", function()
	return cc.Node:create()
end)
-- 提供一个状态机，状态缓存, 可以使链表

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
	self.stateLinkNode = LinkNode.new()
end

function tClass:onEnter()
	AnimManager.addToLoopList(self.animNode)
end

function tClass:onExit()
end


function tClass:createAnim(data)
	self.animNode = AnimNode.new(data, self)
	self:addChild(self.animNode)
	return self.animNode
end


function tClass:onLoop( ... )
	Log.i("需要子类重写该方法 Element:onLoop()")
end

function tClass:addState(data)
	LinkNode.new(data)
	self.stateLinkNode:addNext()
end

function tClass:removeState()
	return self.stateLinkNode:removeNext()
end

-- 强制切换动作的 作态
function tClass:getImmdiateState()
	-- if self.stateBuffer.data 
end


-- + attack(target, data)
function tClass:attack()
	self.animNode:changeAction("attack")
end


function tClass:skill(sid)
	
end


function tClass:changeAction(actName)
	self.animNode:changeAction(actName)
end

-- 顿帧
function tClass:delay(frameNum)
	self.animNode:delay(frameNum)
end

return tClass