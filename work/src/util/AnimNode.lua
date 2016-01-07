local tClass = class("AnimNode", function()
	return cc.Sprite:create()
end)


local FrameCache = cc.SpriteFrameCache:getInstance()
local AnimData = DataManager.AnimData

--[[
self.mc = cc.Sprite:create()
self.mc:setSpriteFrame(fc:getSpriteFrame("res/kimibb.png"))
local frame = fc:getSpriteFrame(frameinfo.name)
if frame then
    self.mc:setSpriteFrame(frame)
end
self.mc:setFlippedX(self.isFlipped)
]]-- 

function tClass:ctor(data)
	self:ignoreAnchorPointForPosition(false)
	-- self:setAnchorPoint(cc.p(0.5, 0.5))

	self.model = AnimData.getModel(data.name)
	-- self.model = AnimData.getModel(data.name, data.actionName, data.direction)
	local frameName = AnimData.getCurFrameName(self.model)
	local frame = FrameCache:getSpriteFrame(frameName)
	if farme then
		Log.i("================= set spritgfame ...", frameName)
		self:setSpriteFrame(frame)
	else
		Log.i(" not ================= set spritgfame ...", frameName)
	end
end

-- name :frame name
-- remainFrame : 下一帧间隔
-- bodyRect :受击框
-- attRect :攻击框
function tClass:setFrameData()
	-- curIndex
	-- curFrameName
	-- maxIndex
	-- direction
end


return tClass
