local baseClass = require("gamecore/element/Element")
local tClass = class("Role", baseClass)

function tClass:ctor()
	tClass.super.ctor(self)
	self.elementType = ElementType.Element
	
end