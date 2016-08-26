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

]]--


local aabb = helper.aabb

local defaultData = {
	id = 0,
	name = "jianshi",
	actionName = "stand",
	direction = 2,
	test_boxes = true,
}

function tClass:ctor(animData, property)
	-- self.elementType = ElementType.Role

	self._animData = setmetatable(animData or {}, {__index = defaultData}) -- 需在父类初始化前赋值
	tClass.super.ctor(self)

	self._property = setmetatable(property or {}, {__index = defaultData}) -- hp mp etc.

	self._enemys = {}
end

function tClass:skill(target, data)
end

-- function tClass:attack(target, data)
-- end

function tClass:stand()
end

function tClass:walk(data)
end

function tClass:onFrameUpdate(model)
	self:updateDrawNode(model)
end

function tClass:onFrameLoop()
	self:doAttack()
end

function tClass:addEnemys(list)
	for i, v in ipairs(list) do
		if not tolua.isnull(v) then
			table.insert(self._enemys, v)
		end
	end
end

function tClass:doAttack()
	if tolua.isnull(self._attBox) or not self._attBox._rect then
		return
	end
	local rect = self._attBox._rect
	local targetElements = {}
	for i, v in ipairs(self._enemys) do
		if v._hitBox and aabb(rect, v._hitBox._rect) then
			Log.d("aabb succcccccc!!!! Role".. self._property.id.. " attacks Role".. v._property.id)
			table.insert(targetElements, v)
		end
	end
	for i, v in ipairs(targetElements) do
		Effect.hurt(v._animNode) -- bug useless, anything to do with black image resource?
		Effect.fadeInOut(v._animNode, -1, 0.2, 0.5, 1)
	end
end



return tClass