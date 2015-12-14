-- GameView.lua


local tClass =  class("TestView", ui.BasePanel)

local dataLoaded

function tClass:ctor()
    tClass.super.ctor(self)
    Log.d("test view ctor")

	-- self:setContentSize(cc.size(400, 400))

	-- local layer = gui.newLayer(cc.c4b(255, 255, 0, 80))
	-- self:addChild(layer)
 --    ui.align(self, layer)
end


function tClass:onEnter()
    tClass.super.onEnter(self)	
    Log.d("test view on enter")


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
end

function tClass:onExit()
	tClass.super.onExit(self)
	Log.d("test view on exit")
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

    -- 切换动作按钮
    -- local function btnCallback()
    --     self.animationID = (self.animationID + 1) % self.armature:getAnimation():getMovementCount()
    --     self.armature:getAnimation():playWithIndex(self.animationID)
    -- end
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


function tClass:onTouchBegan(touch, event)
    local ret = tClass.super.onTouchBegan(self, touch, event)
    Log.d("============= touch began" .. self.__cname)
    return ret
end

function tClass:onTouchEnded(touch, event)
    local ret = tClass.super.onTouchEnded(self, touch, event)
    Log.d("============= ended" .. self.__cname)
    return ret
end



return tClass