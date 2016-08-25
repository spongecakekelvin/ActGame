module("Effect", package.seeall)

function hurt(animNode)
	local sp = SimpleAnim.getAnimSp(animNode._bodySp)
	if animNode:getActionByTag(tag) then
		-- gprint("=============setColor return ")
		return
	end	
	
	local actions = {
		cc.CallFunc:create(function() sp:setColor(ui.color.red) end),
		cc.DelayTime:create(time or 0.3),
		cc.CallFunc:create(function() 
			sp:setColor(ui.color.pureWhite) 
			animNode:stopActionByTag(tag)
		end)
	}
	local action = cc.Sequence:create(actions)
	action:setTag(tag)
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