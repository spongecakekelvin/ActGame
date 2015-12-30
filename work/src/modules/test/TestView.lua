-- GameView.lua


local tClass =  class("TestView", ui.BasePanel)

local dataLoaded
local antProblem

function tClass:ctor()
    tClass.super.ctor(self)


end


function tClass:onEnter()
    tClass.super.onEnter(self)	
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfoAsync("armature/robot.png", "armature/robot.plist", "armature/robot.xml", dataLoaded)

    -- local  proxy = cc.CCBProxy:create()
    -- local  node  = CCBReaderLoad("res/csb/MainScene.csb",proxy,HelloCocosBuilderLayer)
    -- local  layer = node
    -- local layer = ccs.SceneReader:getInstance():createNodeWithSceneFile("res/csb/LoadSceneEdtiorFileTest/FishJoy2.json")


	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("res/armature/robot.png", "res/armature/robot.plist", "res/armature/robot.xml")
	
    dataLoaded(self)	

	-- ccs.ArmatureDataManager:getInstance():addArmatureFileInfoAsync("res/armature/HeroAnimation.ExportJson", function()
	-- 	dataLoaded(self, percent)
	-- end)

    local btn = ui.newButton("蚂蚁爬木", 1, function()
        antProblem(self)
    end)
    self:addChild(btn)
    ui.align(self, btn, 1, 0, nil, -100, 80)

    local hintLabel = ui.newLabel("（点击界面内区域切换动作）", ui.c3b.green, 20)
    ui.align(self, hintLabel, 0.5, 0, nil, 0, 40)
    self:addChild(hintLabel)
end

function tClass:onExit()
	tClass.super.onExit(self)
end

function dataLoaded(self, percent)
    self.animationID = 0

    self.armature = ccs.Armature:create("robot")
    self.armature:setScale(0.48)
    -- armature:getAnimation():play("attack")
    self.armature:getAnimation():setSpeedScale(0.5)
    self.armature:getAnimation():playWithIndex(0)

    self:addChild(self.armature)
    ui.align(self, self.armature)

    -- local p1 = cc.ParticleSystemQuad:create("res/Particles/SmallSun.plist")

    -- local bone  = ccs.Bone:create("p1")
    -- bone:addDisplay(p1, 0)
    -- bone:changeDisplayWithIndex(0, true)
    -- bone:setIgnoreMovementBoneData(true)
    -- bone:setLocalZOrder(100)
    -- bone:setScale(1.2)
    -- self.armature:addBone(bone, "bady-a3")

    -- local p2 = cc.ParticleSystemQuad:create("res/Particles/SmallSun.plist")
    -- bone  = ccs.Bone:create("p2")
    -- bone:addDisplay(p2, 0)
    -- bone:changeDisplayWithIndex(0, true)
    -- bone:setIgnoreMovementBoneData(true)
    -- bone:setLocalZOrder(100)
    -- bone:setScale(1.2)
    -- self.armature:addBone(bone, "bady-a30")
end

-- 切换动作按钮
function tClass:changeAction()
    self.animationID = (self.animationID + 1) % self.armature:getAnimation():getMovementCount()
    self.armature:getAnimation():playWithIndex(self.animationID)
end

function tClass:onTouchBegan(touch, event)
    local isIn = tClass.super.onTouchBegan(self, touch, event)
    return isIn
end

function tClass:onTouchEnded(touch, event)
    local isIn = tClass.super.onTouchEnded(self, touch, event)
    if isIn then
        self:changeAction()
    end
    return isIn
end



function antProblem(self)
    local minPos = 0
    local maxPos = 30
    local isOut = function(antPos)
        return (not (antPos > minPos and antPos < maxPos))
    end
    local antInitPos = {3, 7, 11, 17, 23}
    local antSpeed = {1, 1, 1, 1, 1}
    
    local minTime
    local maxTime
    -- 遍历全部方向
    -- 未离开-碰撞检测-(调头)-移动  until 全部离开 记录时间
    local moveFunc = function(posTab, speedTab)
        local posNum = #posTab
        local state = {false, false, false, false, false}
        local time = 0
        local isAllOut = false
        while true do
            -- Log.t(posTab)
            for i = 1, posNum do
                if not state[i] then
                    state[i] = isOut(posTab[i])
                end
            end

            isAllOut = true
            for i = 1, posNum do
                if not state[i] then
                    isAllOut = false
                    break
                end
            end
            if isAllOut then
                break
            end

            -- 碰撞检测
            for i = 1, posNum do
                if not state[i] and
                        not state[i + 1] and
                        i + 1 <= posNum and
                        posTab[i] == posTab[i + 1] then
                    speedTab[i] = -1 * speedTab[i]
                    speedTab[i + 1] = -1 * speedTab[i + 1]
                end
            end

            -- 移动
            for i = 1, posNum do
                if not state[i] then
                    posTab[i] = posTab[i] + speedTab[i]
                end
            end

            time = time + 1

            -- Log.i("time = " .. time)
        end 
        return time
    end

    local traverseFunc
    traverseFunc = function(startIndex, speedTab)
        if startIndex > 5 then
            return
        end
        -- Log.t(speedTab)
        
        local moveTime = moveFunc(clone(antInitPos), speedTab)
        -- Log.i("====== startIndex = " .. startIndex .. "========= move time  = " .. moveTime)
        minTime = (minTime and (minTime < moveTime)) and minTime or moveTime 
        maxTime = (maxTime and (maxTime > moveTime)) and maxTime or moveTime 

        for i = -1, 1, 2 do
            local newSpeedTab = clone(speedTab)
            newSpeedTab[startIndex] = i * newSpeedTab[startIndex]
            traverseFunc(startIndex + 1, newSpeedTab)
        end
    end
    traverseFunc(1, antSpeed)

    Log.i("maxTime = " .. maxTime)
    Log.i("minTime = " .. minTime)
end



return tClass