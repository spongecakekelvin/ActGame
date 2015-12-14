-- MainUIController
local tClass = class("MainUIController")

function tClass:ctor()
	EventManager.addListener(EventType.game_enter, self.openView, self)
end

function tClass:openView()
	if tolua.isnull(self.testView) then
		self.mainUIView = require("modules/mainUI/MainUIView").new()
		SceneManager.windowLayer:addChild(self.mainUIView)
	end
end

return tClass