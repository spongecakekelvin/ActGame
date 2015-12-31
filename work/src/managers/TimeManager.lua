--------------------------
-- 时间管理器
-- 定时调用、延时调用
--------------------------
module("TimeManager", package.seeall)

local scheduleId = nil
local timerList = {} -- [id] = {callback = function, loopTime = 0.016, curTime = 0}
local delayList = {}

local KEY_TIMER = 1
local KEY_DELAY = 2

local ID = {}
ID[KEY_TIMER] = 0
ID[KEY_DELAY] = 0 

local MAX = 2 * 32

-- 生成计时器唯一id
local generateId

function init()
	if scheduleId then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scheduleId)
		scheduleId =  nil
	end

	ID[KEY_TIMER] = 0
	ID[KEY_DELAY] = 0

	cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		for k, v in pairs(timerList) do
			if v.curTime >= v.maxTime then
				v.curTime = 0
				v.callback()
			else
				v.curTime = v.curTime + dt
			end
		end

		for k, v in pairs(delayList) do
			if v.curTime >= v.maxTime then
				v.callback()
				removeDelay(k)
			else
				v.curTime = v.curTime + dt
			end
		end
	end, 0, false)
end


-- 添加定时器调用
function addTimer(callback, dt)
	local key = generateId(KEY_TIMER)
	dt = dt or 0
	timerList[key] = {callback = callback, maxTime = dt, curTime = dt}
	return key
end

-- 添加延迟调用
function addDelay(callback, dt)
	local key = generateId(KEY_DELAY)
	dt = dt or 0
	delayList[key] = {callback = callback, maxTime = dt, curTime = 0}
	return key
end



  
function removeTimer(key)
	if key then
		timerList[key] = nil
	end
end

function removeDelay(key)
	if key then
		delayList[key] = nil
	end
end


-- 生成计时器唯一id
function generateId(key)
	local id = ID[key]
	while delayList[id] do
		if id == MAX then
			Log.e("timer id 溢出")
			id = 0
			break
		end
		id = id + 1
	end
	ID[key] = id
	return id
end
