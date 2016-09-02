local baseClass = require("element/Element")
local tClass = class("Role", baseClass)

--[[
+ skill(target, data)
+ attack(target, data)
+ stand()
+ walk(pos)

+ addEnemys

- onFrameUpdate() -- update
- doAttack()

memeber:
- _animNode

]]--

local MOVE_OFFSET_X = MOVE_OFFSET_X
local MOVE_OFFSET_Y = MOVE_OFFSET_Y
local aabb = helper.aabb

local defaultData = {
	id = 0,
	name = "jianshi",
	actionName = "stand",
	direction = DIR.right,
	test_boxes = true,
}

function tClass:ctor(animData, property)
	self._animData = setmetatable(animData or {}, {__index = defaultData}) -- 需在父类初始化前赋值
	tClass.super.ctor(self)

	self._property = setmetatable(property or {}, {__index = defaultData}) -- hp mp etc.

	self._enemys = {}

	self.walkFrameCallback = nil
	self.nextActions = {"stand"}
end

function tClass:skill(target, data)
end

-- function tClass:attack(target, data)
-- end

function tClass:isStand()
	return ("stand" == self._animNode.model.actionName)
end

function tClass:stand()
	self.route = nil
	self.walkFrameCallback = nil
	self.nextActions = {"stand"}
end

function tClass:getRoute(destPos)
	local originx, originy = self:getPosition()
	local route = {}
	local x = originx
	while true do
		x = x + MOVE_OFFSET_X
		if x >= destPos.x then
			break
		end
		route[#route + 1] = {x = x, y = originy}
	end

	if x > destPos.x and x < destPos.x + MOVE_OFFSET_X then
		route[#route + 1] = {x = destPos.x, y = originy}
	end
	return route
end

function tClass:walk(destPos)
	if destPos.x < 0 or destPos.y > 1136 then
		Log.d("walk 超过边界")
		return
	end
	self:changeAction("walk")
	self.nextActions = {"walk"}
	self.route = self:getRoute(destPos)
	Log.t(self.route, "=== route it is ===")
	if #self.route > 0 then
		self.routeIndex = 1
		self.walkFrameCallback = function(self)
			if not self.route then
				return
			end
			if self.route[self.routIndex] then
				self:setPosition(self.route[self.routIndex])
				self.routIndex = self.routIndex + 1
			else
				self.walkFrameCallback = nil
				self:changeAction("stand")
				Log.d("=== not route found, index = ", self.routIndex)
			end
		end
	end
end

function tClass:walkOffset(offsetPos)
	local originPos = cc.p(self:getPosition())
	Log.t(offsetPos)
	self:walk(cc.p(offsetPos.x + originPos.x, originPos.y))
end

function tClass:onFrameUpdate(model)
	self:updateDrawNode(model)
	if self.walkFrameCallback then
		self.walkFrameCallback(self)
	end
end

function tClass:onFrameLoop()
	local targets = self:checkCollision()
	if targets then
		self:doAttack(targets)
	end
end

function tClass:addEnemys(list)
	for i, v in ipairs(list) do
		if not tolua.isnull(v) then
			table.insert(self._enemys, v)
		end
	end
end

function tClass:checkCollision()
	if tolua.isnull(self._attBox) or not self._attBox._rect then
		return
	end
	local rect = self._attBox._rect
	local targetElements = nil
	for i, v in ipairs(self._enemys) do
		if v._hitBox and aabb(rect, v._hitBox._rect) then
			Log.d("aabb succcccccc!!!! Role".. self._property.id.. " attacks Role".. v._property.id)
			if not targetElements then
				targetElements = {}
			end
			table.insert(targetElements, v)
		end
	end
	return targetElements
end

function tClass:doAttack(targets)
	for i, v in ipairs(targets) do
		v:hurt()
	end
end

function tClass:hurt()
	self:changeAction("hurt")
	Effect.hurt(self._animNode) -- bug useless, anything to do with black image resource? Yes
end


return tClass