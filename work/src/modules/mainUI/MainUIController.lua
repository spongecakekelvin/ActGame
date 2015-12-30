-- MainUIController
local tClass = class("MainUIController")

function tClass:ctor()
	-- EventManager.addListener(EventType.game_enter, self.openView, self)
	EventManager.addListener(EventType.create_main_ui_view, self.createMainUIVIew, self)
end

function tClass:createMainUIVIew()
	if tolua.isnull(self.mainUIView) then
		self.mainUIView = require("modules/mainUI/MainUIView").new()
		SceneManager.uiLayer:addChild(self.mainUIView)
	end
end

return tClass