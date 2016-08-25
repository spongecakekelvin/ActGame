local tClass = class("AnimNode", function()
	return cc.Sprite:create()
end)

local SpriteFrameCache = cc.SpriteFrameCache:getInstance()
local AnimData = DataManager.AnimData
local SkillData = DataManager.SkillData

local boxOrder = 1


function tClass:ctor(data, element)
	-- self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(cc.p(0.5, 0))
	self.model = AnimData.getModel(data.name)
	self.element = element
	self.drawboxes = false
end


function tClass:drawBoxes(state)
	self.drawboxes = state
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

	local frameName = AnimData.getCurFrameName(self.model)
	if frameName then
		local frame = SpriteFrameCache:getSpriteFrame(frameName)
		if frame then
			-- Log.i("\t", frameName)
			self:setSpriteFrame(frame)
			self:setPosition(AnimData.getCurFramePos(self.model))
			
			self:updateDrawNode()
			
		else
			Log.i("Using unloaded spritgframe: ", frameName)
		end
	end
end


function tClass:updateDrawNode()
	ui.removeNode(self.drawNode)
	if self.drawboxes and self.model.frameConfig then
		local rect = self.model.frameConfig.bodyRect
		-- Log.t(rect)
		if rect then
			-- Log.d("===============  drawnode")
			-- self.drawNode = ui.newLabel(table.concat(rect,"|"))
			-- self.element:addChild(self.drawNode, boxOrder)
			self.drawNode = ui.newRect(cc.p(0, 0), cc.p(rect[3] - rect[1], rect[4] - rect[2]), 2)
			self.element:addChild(self.drawNode, boxOrder)
		end               
	end
end

function tClass:updateEffect()
	-- if true or stateTag == "hurt" then
	-- 	Effect.hurt(self)
	-- end
end


return tClass
