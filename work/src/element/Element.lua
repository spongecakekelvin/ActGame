local tClass = class("Element", function()
	return cc.Node:create()
end)


function tClass:ctor()
	self.elementType = ElementType.Element
end

function tClass:createAnim(param)
	self.animNode = AnimManager.create(param)
	return self.animNode
end