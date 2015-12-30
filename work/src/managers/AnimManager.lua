--------------------------
-- 动画管理器
--------------------------
module("AnimManager", package.seeall)

local scheduleId = nil
local loopList = {}

function start( ... )
	
end


function create(param)
	local baseNode = cc.Sprite:create()
	return baseNode
end

function addToLoopList(node)
	loopList = table.insert(loopList, {node = node})
end