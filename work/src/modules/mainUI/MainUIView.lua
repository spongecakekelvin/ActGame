-- GameView.lua
local tClass =  class("MainUIView", ui.BaseLayer)

local dataLoaded

function tClass:ctor()
    tClass.super.ctor(self)
end

function tClass:onEnter()
    tClass.super.onEnter(self)

    Log.i("mainui view on enter111")
    local btn = gui.newButton("测试界面", 1, function()
    	Log.i("点击测试按钮")
    	CtlManager.test:openView()
	end)
	ui.addChild(self, btn, 400, 320)
	Log.i("mainui view on enter66666")
end

function tClass:onExit()
	tClass.super.onExit(self)
end


return tClass