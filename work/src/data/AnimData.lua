module("AnimData", package.seeall)

local AnimConfig = require "config/AnimConfig"

local initModelData

function getModel(name)
	assert((type(name) == "string"), "in AnimData.getModel(name): param 'name' has wrong type " .. type(name) .. " (string expected) !")

	local model = {}
	-- init 
	model.name = name
	model = initModelData(model)	

	model.config = {}

	local config = AnimConfig[name]
	if config then
		-- setmetatable(config, {__index = config})
		setmetatable(model.config, {__index = config})
	else
		Log.e("没有动画配置 name = " .. tostring(data.name))
	end

	return model
end

function initModelData(model, initActionName)
	model.actionName = initActionName or "stand"
	model.actionIndex = 1
	model.direction = 2
	model.frameIndex = 1
	return model
end


local function getActionName(model)
	-- return "stand_d2"
	return table.concat{model.actionName, "_d", model.direction}
end

function getCurFrameName(model)
	Log.t(model)
	local config = model.config[getActionName(model)]
	local curInfo = config[model.actionIndex]
	if model.frameIndex > curInfo.remainFrame then
		-- 单帧播放完
		if model.actionIndex + 1 <= model.config.pngnum then
			-- 下一帧
			model.actionIndex = model.actionIndex + 1
			return getCurFrameName(model)
		else
			-- 动作全部帧播放完
			initModelData(model, "stand")
		end
	else
		return table.concat{model.name, "/", curInfo.name, ".png"}
	end
end
