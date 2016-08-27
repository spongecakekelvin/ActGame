module("Effect", package.seeall)

HURT_TAG = 10001
-- for api ":setColor(...)", pure black sprite doesn't work
function hurt(sp, time)
    time = time or 0.3
    sp:setColor(ui.c3b.red)
	sp:stopActionByTag(HURT_TAG)
	local action = cc.Sequence:create{
        cc.DelayTime:create(time),
        cc.CallFunc:create(function() 
            sp:setColor(ui.c3b.white) 
            sp:stopActionByTag(HURT_TAG)
        end)
    }
	action:setTag(HURT_TAG)
	sp:runAction(action)
end


-- 淡入淡出的闪烁效果
-- e.g. -- Effect.fadeInOut(v._animNode, -1, 0.2, 0.5, 1)
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