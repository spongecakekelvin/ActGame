-- MainUIController
local tClass = class("FightController")

function tClass:ctor()
	-- EventManager.addListener(EventType.game_enter, self.openView, self)
	EventManager.addListener(EventType.create_fight_view, self.createFightView, self)
end

function tClass:createFightView()
	if tolua.isnull(self.fightView) then
		self.fightView = require("modules/fight/FightView").new()
		SceneManager.sceneLayer:addChild(self.fightView)
	end
end


return tClass