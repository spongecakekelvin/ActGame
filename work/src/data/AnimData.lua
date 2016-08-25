module("AnimData", package.seeall)

local AnimConfig = require "config/AnimConfig"

local initModelData

--[[
+ getCurFrameName
+ getCurFramePos

]] --

function getModel(name)
	assert((type(name) == "string"), "in AnimData.getModel(name): param 'name' has wrong type " .. type(name) .. " (string expected) !")

	local model = {}
	-- init 
	model.name = name
	model = initModelData(model)	

	model.config = {}

	local config = AnimConfig[name]
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
	model.direction = model.direction or 2
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
	return table.concat{model.actionName, "_d", model.direction}
	
end

local function getNextActionName()
	local actionName = getActionName(model)
	return actionName
end


function getCurFrameName(model)
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

			if hasNextAction then
				local actionName = getNextActionName()
				changeAction(model, actionName)
			else
				initModelData(model, "stand")
			end
			return nil
		end
	else
		return table.concat{model.name, "/", model.frameConfig.name, ".png"}
	end
end


function getCurFramePos(model)
	local x, y = 0, 0
	if model.frameConfig then
		x, y = model.frameConfig.x, model.frameConfig.y
	end
	return x, y
end


-- 用于切换动作，设置动作信息
function changeAction(model, actionName)
	if model.isPlaying then
		Log.i("== action's playing cannot be changed ")
		-- todo: 某些动作可以强制切换， 如技能
		return model
	end

	model.isPlaying = true
	model.actionName = actionName or "stand"
	model.frameIndex = 1
	model.direction = model.direction or 2
	model.count = 0
	model.delayFrameNum = 0
	------
	-- 以下数据为nil时，需要重新赋值以便切换帧动画
	------
	model.actionConfig = nil -- 动作信息
	model.frameConfig = nil -- 帧信息

	return model
end