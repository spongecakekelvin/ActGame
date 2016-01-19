local tClass = class("AnimNode", function()
	return cc.Sprite:create()
end)


local FrameCache = cc.SpriteFrameCache:getInstance()
local AnimData = DataManager.AnimData

function tClass:ctor(data)
	-- self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(cc.p(0.5, 0))
	self.model = AnimData.getModel(data.name)
end



function tClass:changeAction(actionName)
	Log.i("=== changeaction = " .. actionName)
	self.model = AnimData.changeAction(self.model, actionName)
end


-- 每帧调用
-- todo:
-- bodyRect :受击框
-- attRect :攻击框
function tClass:updateFrame()
	self.model.count = self.model.count + 1

	local frameName = AnimData.getCurFrameName(self.model)
	if frameName then
		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(frameName)
		if frame then
			-- Log.i("\t", frameName)
			self:setSpriteFrame(frame)
			self:setPosition(AnimData.getCurFramePos(self.model))
		else
			if frameName then
				Log.i("Using unloaded spritgframe: ", frameName)
			end
		end
	end
end


return tClass
