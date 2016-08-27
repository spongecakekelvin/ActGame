-- GameView.lua
local tClass =  class("MainUIView", ui.BaseLayer)

local ControlView = require("modules/mainUI/ControlView")
function tClass:ctor()
    tClass.super.ctor(self)
end


function tClass:onEnter()
    tClass.super.onEnter(self)

    self.controlView = ControlView.new()
    local size = self.controlView:getContentSize()
    ui.addChild(self, self.controlView, 20, 20)

    local btn = ui.newButton("测试界面", function()
    	CtlManager.test:openView()
	end)
	local btnSize = btn:getContentSize()
	ui.addChild(self, btn, self:getContentSize().width - btnSize.width / 2, btnSize.height / 2)
end

function tClass:onExit()
	tClass.super.onExit(self)
end



return tClass