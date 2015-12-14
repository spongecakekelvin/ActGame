--------------------------
-- 场景管理器
--------------------------
module("SceneManager", package.seeall)

local SceneList = {
	["init"] = nil,
	["game"] = nil,
}

-- 初始化函数
local initFunc = {}

-- 场景层
sceneLayer = nil
-- ui层
uiLayer = nil
-- 界面层
windowLayer = nil
-- 提示层
alertLayer = nil


function getScene(sceneName)
	local scene = SceneList[sceneName]
	if not scene then
		scene = cc.Scene:create()
		scene:retain()

		if initFunc[sceneName] then
			initFunc[sceneName](scene)
		end
	end
	SceneList[sceneName] = scene
	return scene
end


function runScene(sceneName)
	local scene = getScene(sceneName)
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(scene)
    else
        cc.Director:getInstance():runWithScene(scene)
    end
end
 

initFunc["init"] = function(scene)
    local view = require("SplashView").new()
    scene:addChild(view)
end


initFunc["game"] = function(scene)
	require "GameInit"

	-- local rootLayer = cc.Layer:create()
	local rootLayer = gui.newLayer(cc.c4b(255, 255, 255, 255)) 

	sceneLayer = cc.Layer:create()
	uiLayer = cc.Layer:create()
	windowLayer = cc.Layer:create()
	alertLayer = cc.Layer:create()

    rootLayer:addChild(sceneLayer)
    rootLayer:addChild(uiLayer)
    rootLayer:addChild(windowLayer)
    rootLayer:addChild(alertLayer)

    scene:addChild(rootLayer)

    -- 进入游戏
    EventManager.dispatch(EventType.game_enter)
end

