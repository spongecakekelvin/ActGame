-- TestController
local tClass = class("TestController")

function tClass:ctor()
	-- EventManager.addListener(EventType.game_enter, self.openView, self)
end

function tClass:openView()
	if tolua.isnull(self.testView) then
		self.testView = require("modules/test/TestView").new()
		ViewManager.openView(self.testView, SceneManager.windowLayer)
	end
end

return tClass