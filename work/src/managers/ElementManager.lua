--------------------------
-- 动画管理器
--------------------------
module("ElementManager", package.seeall)

local timerId = nil
local loopList = {}
local frameLoopFunc
myRole = nil

function init()
	if timerId then
		TimeManager.removeTimer(timerId)
	end
	timerId = TimeManager.addTimer(frameLoopFunc, GameConfig.fps)
	-- timerId = TimeManager.addTimer(frameLoopFunc, 0.5)
end


function addToLoopList(animNode)
	table.insert(loopList, animNode)
end

function frameLoopFunc()
	-- update frame
	for i, element in ipairs(loopList) do
		if element._animNode then
			element._animNode:loop()
		end
	end
	-- update action
	for i, animNode in ipairs(loopList) do
		animNode:onFrameLoop()
	end
end
