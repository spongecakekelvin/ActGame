-- GameView.lua
local tClass =  class("MainUIView", ui.BaseLayer)

function tClass:ctor()
    tClass.super.ctor(self)
end


function tClass:onEnter()
    tClass.super.onEnter(self)

    local btn = ui.newButton("测试界面", function()
    	CtlManager.test:openView()
	end)
	local btnSize = btn:getContentSize()
	ui.addChild(self, btn, btnSize.width / 2, btnSize.height / 2)
end

function tClass:onExit()
	tClass.super.onExit(self)
end



return tClass