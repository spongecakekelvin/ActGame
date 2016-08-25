local baseClass = require("element/Element")
local tClass = class("Role", baseClass)

--[[
+ skill(target, data)
+ attack(target, data)
+ stand()
+ walk(pos)
- onLoop()
]]--

function tClass:ctor(name, actionName, direction)
	tClass.super.ctor(self)
	-- self.elementType = ElementType.Role



	self.data = {} -- hp mp etc.
	local animData = {}
	animData.name = name or "jianshi"
	animData.actionName = actionName or "stand"
	animData.direction = direction or 2
	
	self.animNode = self:createAnim(animData)
	self.animNode:drawBoxes(true)
end

function tClass:skill(target, data)
end

-- function tClass:attack(target, data)
-- end

function tClass:stand()
end

function tClass:walk(data)
end

function tClass:onLoop()
end



return tClass