module("AnimData", package.seeall)

local AnimConfig = require "config/AnimConfig"

local initModelData

--[[
+ getCurFrameName
+ getCurFramePos

]] --

function getModel(data)
	assert((type(data) == "table"), "in AnimData.getModel(data): param 'data' has wrong type " .. type(name) .. " (string expected) !")

	local model = {}
	-- init 
	model.name = data.name
	model.direction = data.direction
	model = initModelData(model)	

	model.config = {}

	local config = AnimConfig[data.name]
	if config then
		setmetatable(model.config, {__index = config})
	else
		Log.e("没有动画配置 name = " .. tostring(data.name))
	end

	return model
end

function initModelData(model, initActionName)
	model.isPlaying = false -- 正在播放一套帧动作
	model.actionName = initActionName or "stand"
	model.frameIndex = 1
	model.direction = model.direction or DIR.right
	model.count = 0
	model.delayFrameNum = 0
	------
	-- 以下数据为nil时，需要重新赋值以便切换帧动画
	------
	model.actionConfig = nil -- 动作信息
	model.frameConfig = nil -- 帧信息
	return model
end


local function getActionName(model)
	-- return "stand_d2"
	-- Log.d("=== ", model.actionName, "_d2")
	return model.actionName .. "_d2"
	-- return table.concat{model.actionName, "_d", model.direction}
	
end

function getCurFrameName(model, nextActionName)
	-- Log.t(model)
	-- Log.i(model.actionName, model.frameIndex, model.count)

	if not model.actionConfig then
		model.actionConfig = model.config[getActionName(model)]
	end

	if not model.frameConfig then
		model.frameConfig = model.actionConfig[model.frameIndex]
	end


	if model.count > model.frameConfig.remainFrame then

		model.count = 0
		
		-- 单帧播放完
		if model.frameIndex + 1 <= model.actionConfig.pngnum then
			-- 下一帧
			model.frameIndex = model.frameIndex + 1
			model.frameConfig = nil
			return getCurFrameName(model)
		else
			-- 动作全部帧播放完
			initModelData(model, nextActionName or "stand")
			return nil
		end
	else
		return table.concat{model.name, "/", model.frameConfig.name, ".png"}
	end
end


function getCurFramePos(model)
	local x, y = 0, 0
	if model.frameConfig then
		x = model.direction == DIR.right and model.frameConfig.x or -model.frameConfig.x
		y = model.frameConfig.y
	end
	return x, y
end


-- 用于切换动作，设置动作信息
function changeAction(model, actionName)
	if model.isPlaying then
		-- Log.i("== action's playing cannot be changed ")
		-- todo: 某些动作可以强制切换， 如技能
		return model
	end
	
	model.frameIndex = 1
	model.count = 0
	model.delayFrameNum = 0
	
	if model.actionName == actionName then
		Log.i("==== same actionName return")
		return model
	end

	model.isPlaying = true
	model.actionName = actionName or "stand"
	model.direction = model.direction or DIR.right
	------
	-- 以下数据为nil时，需要重新赋值以便切换帧动画
	------
	model.actionConfig = nil -- 动作信息
	model.frameConfig = nil -- 帧信息

	return model
end


function getDirection(originPos, destPos)
	return destPos.x - originPos.x > 0 and DIR.right or DIR.left
end