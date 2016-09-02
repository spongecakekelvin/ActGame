local tClass = class("AnimNode", function()
	return cc.Sprite:create()
end)

local SpriteFrameCache = cc.SpriteFrameCache:getInstance()
local AnimData = DataManager.AnimData
local SkillData = DataManager.SkillData


--[[

]]--


function tClass:ctor(data, element)
	-- self:ignoreAnchorPointForPosition(false)
	self._ap = cc.p(0.5, 0)
	self:setAnchorPoint(self._ap)
	self.model = AnimData.getModel(data)
	self.element = element

	self._lastDirection = nil
	self:changeDirection(self.model.direction)
end





function tClass:changeAction(actionName)
	-- todo : add some condition to block "changeAction", for attact/skill delay, 
	--		e.g. walking cannot stop attacking action
	self.model = AnimData.changeAction(self.model, actionName)
end


function tClass:changeGroupAction(actionName)
	self.model = AnimData.changeAction(self.model, actionName)
end


-- 顿帧
function tClass:delay(frameNum)
	if frameNum and frameNum > 0 then
		self.model.delayFrameNum = frameNum
	end
end


function tClass:loop()
	self:updateFrame()
	self:updateEffect()
end

-- 每帧调用
-- todo:
-- bodyRect :受击框
-- attRect :攻击框
function tClass:updateFrame()
	-- todo: 获取动作状态
	local cancelDelay = false
	if self.element then
		local newData = self.element:getImmdiateState()
		if newData then
			-- 马上切换动作， 修改model的数据
			cancelDelay = true
		end
	end

	if cancelDelay then
		self.model.delayFrameNum = 0
	else
		if self.model.delayFrameNum > 0 then
			self.model.delayFrameNum = self.model.delayFrameNum - 1
			Log.i(" 顿帧中... " .. self.model.delayFrameNum)
			return
		end
	end

	if self.element then
		local newData = self.element:removeState()
		if newData then
			-- 马上切换动作， 修改model的数据
		end
	end
	
	self.model.count = self.model.count + 1

	local frameName = AnimData.getCurFrameName(self.model, self.element.nextActions[1])
	if frameName then
		local frame = SpriteFrameCache:getSpriteFrame(frameName)
		if frame then
			-- Log.i("\t", frameName, AnimData.getCurFramePos(self.model))
			self:setSpriteFrame(frame)
			self:setPosition(AnimData.getCurFramePos(self.model))
			-- self:setBlendFunc(gl.SRC_ALPHA, gl.ONE) -- 目标颜色
			-- self:setBlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)-- 默认这样
			

			self.element:onFrameUpdate(self.model)
		else
			Log.i("Using unloaded spritgframe: ", frameName)
		end
	end
end

function tClass:isForward()
	return (self.model.direction == DIR.right)
end

function tClass:changeDirection(dir)
	if (self._lastDirection and self._lastDirection == dir) or (not dir) then
		return
	end
	self._lastDirection = dir
	Log.d("== self:setFlippedX(not self:isForward())|", (not self:isForward()), self.model.direction, DIR.right)
	self:setFlippedX(not self:isForward()) --2为右（正）方向
end


function tClass:updateEffect()
	-- if true or stateTag == "hurt" then
	-- 	Effect.hurt(self)
	-- end
end


return tClass
