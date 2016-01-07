--------------------------
-- 动画管理器
--------------------------
module("AnimManager", package.seeall)

local timerId = nil
local loopList = {}
local frameLoopFunc

function init()
	if timerId then
		TimeManager.removeTimer(timerId)
	end
	timerId = TimeManager.addTimer(frameLoopFunc, 1)
end


function addToLoopList(node)
	table.insert(loopList, {node = node})
end

-- 动画帧循环函数, 根据当前状态和下一帧状态执行
function frameLoopFunc()
	for i, v in ipairs(loopList) do
		if v.node then
			
		end
	end
end