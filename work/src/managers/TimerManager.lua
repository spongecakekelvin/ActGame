--------------------------
-- 定时器管理器
--------------------------
module("TimerManager", package.seeall)

local scheduleId = nil
local update

local loopList = {}
local delayList = {}

function start()
	stop()
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0, false)
end

function stop()
	if timerKey then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scheduleId)
		scheduleId =  nil
	end
end

function loop(callback, dt)
	
end

function delay(callback, delayTime)

end

function update()
end


function removeLoop()
end