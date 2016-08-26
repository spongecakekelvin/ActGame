module("Effect", package.seeall)

HURT_TAG = 10001
function hurt(animNode)
	local sp = animNode
	if animNode:getActionByTag(HURT_TAG) then
		return
	end	
	
	local actions = {
		cc.CallFunc:create(function() sp:setColor(ui.c3b.red) end),
		cc.DelayTime:create(1),
		cc.CallFunc:create(function() 
			sp:setColor(ui.c3b.white) 
			animNode:stopActionByTag(HURT_TAG)
		end)
	}
	local action = cc.Sequence:create(actions)
	action:setTag(HURT_TAG)
	animNode:runAction(action)
end


-- 淡入淡出的闪烁效果
function fadeInOut(node, times, inTime, outTime, delayTime)
    inTime = inTime or 1
    outTime = outTime or inTime
    local array = {
        cc.FadeIn:create(inTime)
    }
    if delayTime then
        table.insert(array, cc.DelayTime:create(delayTime))
    end
    table.insert(array, cc.FadeOut:create(outTime))

    local action = cc.Sequence:create(array)
    if times < 1 then
        action = cc.RepeatForever:create(action)
    elseif times > 1 then
        action = cc.Repeat:create(action, times)
    end
    
    node:runAction(action)
    return action
end