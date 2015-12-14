-- CollisionView.lua


local tClass =  class("CollisionView", ui.BaseLayer)

local dataLoaded

function tClass:ctor()
    ui.BaseLayer.ctor(self)
    print("game view ctor") 

    self:setContentSize(cc.size(400, 400))

    local layer = gui.newLayer(cc.c4b(255, 255, 0, 80), cc.size(400, 400))
    self:addChild(layer)
    ui.align(self, layer)
end


function tClass:onEnter()
    ui.BaseLayer.onEnter(self)  
    print("game view on enter")

    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("res/armature/robot.png", "res/armature/robot.plist", "res/armature/robot.xml")
    -- dataLoaded(self, percent)   

    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfoAsync("res/armature/HeroAnimation.ExportJson", function()
    --  dataLoaded(self, percent)
    -- end)
end

function tClass:onExit()
    ui.BaseLayer.onExit(self)
    print("game view on exit")
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

    local p1 = cc.ParticleSystemQuad:create("res/Particles/SmallSun.plist")

    local bone  = ccs.Bone:create("p1")
    bone:addDisplay(p1, 0)
    bone:changeDisplayWithIndex(0, true)
    bone:setIgnoreMovementBoneData(true)
    bone:setLocalZOrder(100)
    bone:setScale(1.2)
    self.armature:addBone(bone, "bady-a3")

    local p2 = cc.ParticleSystemQuad:create("res/Particles/SmallSun.plist")
    bone  = ccs.Bone:create("p2")
    bone:addDisplay(p2, 0)
    bone:changeDisplayWithIndex(0, true)
    bone:setIgnoreMovementBoneData(true)
    bone:setLocalZOrder(100)
    bone:setScale(1.2)
    self.armature:addBone(bone, "bady-a30")

    -- handling touch events   
    local function onTouchEnded(touches, event)     
        self.animationID = (self.animationID + 1) % self.armature:getAnimation():getMovementCount()
        self.armature:getAnimation():playWithIndex(self.animationID)
    end

    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCHES_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end




return tClass