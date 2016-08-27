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

ElementManager(1)->(n)animSp
]]--

local boxOrder = 1


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

	self:setContentSize(cc.size(40, 40))
	local layer = ui.newLayer(ui.c4b.white, self:getContentSize())
	self:addChild(layer)

	self._animData = self._animData or {}
	self._animNode = self:createAnim(self._animData)
end

function tClass:onEnter()
	if self._animNode then
		ElementManager.addToLoopList(self)
	end
end

function tClass:onExit()
end


function tClass:createAnim(data)
	self._animNode = AnimNode.new(data, self)
	self:addChild(self._animNode)
	self:drawBoxes(self._animData.test_boxes)
	return self._animNode
end


function tClass:onFrameUpdate( ... )
	-- Log.i("需要子类重写该方法 Element:onLoop()")
end

function tClass:onFrameLoop( ... )
	-- Log.i("需要子类重写该方法 Element:onFrameLoop()")
end



function tClass:drawBoxes(state)
	self.test_boxes = state
end

--- 框
function tClass:updateDrawNode(model)
	ui.removeNode(self._hitBox)
	ui.removeNode(self._attBox)
	if self.test_boxes and model.frameConfig then
		local x, y = self:getPosition()
		local bx, by = self._animNode:getPosition()
		local size = self._animNode:getContentSize()
		local sign_dir = self._animNode:isForward() and 1 or -1

		local rect = model.frameConfig.bodyRect
		if rect then
			local origin = cc.p(sign_dir * rect[1], 0)
			local dest = cc.p(origin.x + sign_dir * rect[3], origin.y + rect[4])
			self._hitBox = ui.newRect(origin, dest, 2)
			self._hitBox._rect = {x + origin.x, y + origin.y, x + dest.x, y + dest.y}
			self:addChild(self._hitBox, boxOrder)
		end 

		local rect = model.frameConfig.attRect
		if rect then
			local origin = cc.p(sign_dir * rect[1], 0)
			local dest = cc.p(origin.x + sign_dir * rect[3], origin.y + rect[4])
			self._attBox = ui.newRect(origin, dest, 2, ui.c4f.red)
			self._attBox._rect = {x + origin.x, y + origin.y, x + dest.x, y + dest.y}
			self:addChild(self._attBox, boxOrder)
		end
	end
end


function tClass:changeDirection(dir)
	self._animNode:changeDirection(dir)
end

function tClass:addState(data)
	LinkNode.new(data)
	self.stateLinkNode:addNext()
end

function tClass:removeState()
	return self.stateLinkNode:removeNext()
end

-- 强制切换动作的状态
function tClass:getImmdiateState()
	-- if self.stateBuffer.data 
end


-- + attack(target, data)
function tClass:attack()
	self:changeAction("attack")
end

function tClass:hurt()
	self:changeAction("hurt")
end

function tClass:skill(sid)
	
end


function tClass:changeAction(actName)
	self._animNode:changeAction(actName)
end

-- 顿帧
function tClass:delay(frameNum)
	self._animNode:delay(frameNum)
end

return tClass