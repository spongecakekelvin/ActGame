------------------------------------------------------
--作者:	yhj
--日期:	2014年10月24日
--描述:	拖动布局的基本类
------------------------------------------------------
local LayoutUtil = class("LayoutUtil")

local write2ConfigFile
local clearNode
local curNode
local onTouchBegan
local onTouchMoved
local onTouchEnded
local adjustNumHandler

--键盘方向
local DIR = {
	LEFT  = 23,
	RIGHT = 24,
	UP    = 25,
	DOWN  = 26,
}

--------------------------------------------------
---	布局界面的初始化
---		@param 	isEdit:	是不是界面编辑模式
--------------------------------------------------
function LayoutUtil:ctor(viewName, filename, isEdit)
	local posInfo = require (filename)
	self.children = {}
	self.currentChild = nil
	self.curFilename = filename
	viewName = viewName or "LayoutUtil"
	if GameGlobal.isWindows then
		self.isEdit = isEdit	
	else
		self.isEdit = false
	end
	self.viewPosInfo = posInfo[viewName]
	if not self.viewPosInfo then
		posInfo[viewName] = {}
		self.viewPosInfo = posInfo[viewName]
	end
	
	if self.isEdit then
		self.node = ui.newNode()
--		ui.addChild(LayerManager.topLayer, self.node, 820, 150)
		ui.addChild(LayerManager.fullLayer, self.node, 820, 150, nil,nil, 1000)
		--创建上下左右键
		local left = ui.newSpr("#common/up2.png")
		ui.addChild(self.node, left, -80, 0)
		left:setRotation(-90)
		left.tag = 1
		local up = ui.newSpr("#common/up2.png")
		ui.addChild(self.node, up, 0, 80)
		up.tag = 2
		local right = ui.newSpr("#common/up2.png")
		ui.addChild(self.node, right, 80, 0)
		right:setRotation(90)
		right.tag = 3
		
		local down = ui.newSpr("#common/up2.png")
		ui.addChild(self.node, down, 0, -80)
		down:setRotation(-180)
		down.tag = 4
		
		local center = ui.newLayer(cc.size(80,80), ui.color4)
		ui.addChild(self.node, center,-40,-40)
		ui.addChild(center, ui.newLabel("按住可以拖动", 18,nil,cc.size(80,80)),0,0,0,0)
		
		self.directions = {left, up, right, down, center}
		local listener = cc.EventListenerTouchOneByOne:create()
	    listener:setSwallowTouches(true)
	    listener:registerScriptHandler(handler(self, onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
	  	listener:registerScriptHandler(handler(self, onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
	    listener:registerScriptHandler(handler(self, onTouchEnded),cc.Handler.EVENT_TOUCH_ENDED )
	  	
	    local eventDispatcher = left:getEventDispatcher()
	    eventDispatcher:addEventListenerWithFixedPriority(listener, -11)
	    self.directionLis = listener
		
		self.node:setLocalZOrder(1000)
		self.label= ui.newLabel("("..tostring(0)..","..tostring(0)..")", 16)
		self.label:setStroke()
		ui.addChild(LayerManager.fullLayer, self.label,nil,nil,nil,nil, 10010)
		self.allAnchorPoint = {}
		local savePosInfoAndClose = ui.newButton(1, "保存退出")
		savePosInfoAndClose:setPosition(-20, -130)
		savePosInfoAndClose:onClick(self, function() 
			local dispatcher = self.node:getEventDispatcher()
	    	dispatcher:removeEventListener(self._touchListener)
	    	self._touchListener = nil
			write2ConfigFile(self, posInfo)
			clearNode(self)
		end)
	   	self.node:addChild(savePosInfoAndClose, 100)

	   	self._isMultiSelect = false
	   	local checkButton = ui.newCheckBoxButton({normal = "#common/checkBtn2.png", off = "#common/checkBtn2.png", on = "#common/checkBtn1.png"},
	   		"框选", nil, self._isMultiSelect, function(btn, isSeleted)
				self._isMultiSelect = btn:isSeleted()
				yzjprint("=== isSelect ", self._isMultiSelect)
			end)
	   	checkButton:setPosition(30, -90)
	   	self.node:addChild(checkButton, 100)

	   	local glNode  = gl.glNodeCreate()
	    glNode:setContentSize(cc.size(256, 256))
	    glNode:setAnchorPoint(cc.p(0.5, 0.5))
	    local function majoriDraw(transform, transformUpdated)
			cc.DrawPrimitives.drawColor4B(255, 0, 255, 255)
	        
	        if self._isMultiSelect and self._multiSelectBox then
		        gl.lineWidth(3)
		        cc.DrawPrimitives.drawRect( cc.p(self._multiSelectBox.x, self._multiSelectBox.y),
		        	cc.p(self._multiSelectBox.width, self._multiSelectBox.height))
	        else
	        	if self._touchPoint then
			        gl.lineWidth(3)
			        cc.DrawPrimitives.drawLine(cc.p(0, self._touchPoint.y), cc.p(960, self._touchPoint.y) )
			        cc.DrawPrimitives.drawLine(cc.p(self._touchPoint.x,0), cc.p(self._touchPoint.x, 640) )
		        end 
		    end
	        gl.lineWidth(1)
			cc.DrawPrimitives.drawColor4B(0x7C, 0xFC, 0, 255)
	        cc.DrawPrimitives.setPointSize(10)
	        if self.viewPosInfo then
	        	for i = 1, #self.children do
	        		local node = self.children[i]
	        		local pos = self.viewPosInfo[node.layoutUtilName]
	        		if ui.isExist(node) then
		        		local parent = node:getParent()
		        		cc.DrawPrimitives.drawPoint(parent:convertToWorldSpace(cc.p(pos[1], pos[2])))
		        	else
		        		clearNode(self)
		        		return
		        	end
	        	end
	        end
	    end
	    glNode:registerScriptDrawHandler(majoriDraw)
	
		ui.addChild(self.node, glNode, 100, 200)
		
		local listener = cc.EventListenerTouchOneByOne:create()
	    listener:setSwallowTouches(true)
	    listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
	  	listener:registerScriptHandler(handler(self, self.onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
	    listener:registerScriptHandler(handler(self, self.onTouchEnded),cc.Handler.EVENT_TOUCH_ENDED )
	  	
	    local eventDispatcher = self.node:getEventDispatcher()
	    eventDispatcher:addEventListenerWithFixedPriority(listener, -10)
	    self._touchListener = listener


	    local function onKeyReleased(keyCode, event)
	    	if ui.isExist(self.currentChild) then 
	    		local posX,posY = self.currentChild:getPosition()
	    		if     keyCode == DIR.LEFT  then 
	    			posX = posX - 1
	    		elseif keyCode == DIR.RIGHT then 
	    			posX = posX + 1 
	    		elseif keyCode == DIR.UP    then 
	    			posY = posY + 1 
	    		elseif keyCode == DIR.DOWN  then 
	    			posY = posY - 1 
	    		end 
	    		self.label:setString("("..posX..","..posY..")")
	    		self.currentChild:setPosition(cc.p(posX,posY))
	    	end 
    	end

    	if self._keyboradListener then
        	eventDispatcher:removeEventListener(self._keyboradListener)
        	self._keyboradListener = nil
    	end
    	local listenerkeyboard = cc.EventListenerKeyboard:create()
    	listenerkeyboard:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)

    	eventDispatcher:addEventListenerWithFixedPriority(listenerkeyboard, -11)
    	self._keyboradListener = listenerkeyboard
   	end
end

local schedule
local isMoveOut
local singleClickTag = 1980
function onTouchBegan(self, touch, event)
	local location = touch:getLocation()
	local isIn = Helper.isClickInTarget(self.directions[1], location)
	local index = 1
	if not isIn then
		index = 2
		local isIn = Helper.isClickInTarget(self.directions[2], location)
		if not isIn then
			index = 3
			local isIn = Helper.isClickInTarget(self.directions[3], location)
			if not isIn then
				index = 4
				local isIn = Helper.isClickInTarget(self.directions[4], location)
				if not isIn then
					index = 5
					local isIn = Helper.isClickInTarget(self.directions[5], location)
					if not isIn then
						return false
					end
				end
			end
		end
	end
	
	self.tag = index
	local function dragDelay()
		schedule  = TimerManager.scheduleGlobal(function()
			if not isMoveOut then
				adjustNumHandler(self.tag)
			else
				TimerManager.unscheduleGlobal(schedule)
				schedule = -1
			end
		end, 0.3)
	end
	schedule = -1
	self.directions[1]:stopActionByTag(singleClickTag)
	local sequence = cocos.performWithDelay(self.directions[1], dragDelay, 0.3)
	sequence:setTag(singleClickTag)
	isMoveOut = false
	return true
end

function onTouchMoved(self, touch, event)
	if self.tag == 5 then
		local location = touch:getLocation()
		if self.lastPos then
			local moveDis = cc.pSub(location,self.lastPos)
			local x, y = self.node:getPosition()
			self.node:setPosition(cc.pAdd(cc.p(x, y), moveDis))
		end
		self.lastPos = location
	end
end

function onTouchEnded(self, touch, event)
	self.directions[1]:stopActionByTag(singleClickTag)
	isMoveOut = true
    TimerManager.unscheduleGlobal(schedule)
	adjustNumHandler(self.tag) 
end

local tags = {
	{-1, 0},
	{0, 1},
	{1, 0},
	{0, -1}
}
local curPosNode
local curLabel
function adjustNumHandler(tag)
	hjprint(tag)
	local addValue = tags[tag]
	if ui.isExist(curNode) then
		local nodeX, nodeY = curNode:getPosition()
		curPosNode[1] = nodeX + addValue[1]
		curPosNode[2] = nodeY + addValue[2]
		curNode:setPosition(curPosNode[1], curPosNode[2])
		curLabel:setString("("..curPosNode[1]..","..curPosNode[2]..")")
	end
end


function clearNode(self)
	self.children = {}
	
	
	local dispatcher = self.directions[1]:getEventDispatcher()
	dispatcher:removeEventListener(self.directionLis)
	self.directionLis = nil
	local dispatcher = self.node:getEventDispatcher()
	dispatcher:removeEventListener(self._touchListener)
	self._touchListener = nil

	if self._keyboradListener then 
		dispatcher:removeEventListener(self._keyboradListener)
		self._keyboradListener = nil 
	end 

	TimerManager.addTimeOut(function() ui.removeSelf(self.node) ui.removeSelf(self.label) end, 0)
end


function LayoutUtil:autoPos(node, name)
	assert(name, "autoPos name参数不为空")
	local pos = self.viewPosInfo[name]
	if not pos then
		pos = {0, 0}
		self.viewPosInfo[name] = pos
	end
	node:setPosition(pos[1], pos[2])
	if self.isEdit then
		node.layoutUtilName = name
		table.insert(self.children, node)
	end
end

local function sortFunc(n1, n2)
   return 	not(n1:getLocalZOrder() < n2:getLocalZOrder() or
           ( n1:getLocalZOrder() == n2:getLocalZOrder() and n1:getOrderOfArrival() < n2:getOrderOfArrival()))
end

local lastPoint
function LayoutUtil:onTouchBegan(touch, event)
	self.currentChild = nil
	local location = touch:getLocation()
	lastPoint = location
	if self._isMultiSelect then
		self._toucheBeganPos = location
		return true
	end

	local clickTargets = {}
	for i = 1, #self.children do
		local child = self.children[i]
		if not tolua.isnull(child) then
			local isInChild = Helper.isClickInTarget(child, location)
			if isInChild then
				table.insert(clickTargets, child)
			end
		end
	end
	table.sort(clickTargets, sortFunc)
	if ui.isExist(clickTargets[1]) then
		self.currentChild = clickTargets[1]
		local x, y = self.currentChild:getPosition()
		local parent = self.currentChild:getParent()
		self._touchPoint = parent:convertToWorldSpace(cc.p(x, y))
		
		self.label:setString(self.currentChild.layoutUtilName .. "\n("..x..","..y..")")
		
		self.label:setPosition(cc.pAdd(cc.p(30, 30), self._touchPoint))
		return true
	end
	return false
end

--触摸移动了
function LayoutUtil:onTouchMoved(touch, event)
	if self._isMultiSelect and self._toucheBeganPos then
		-- 画框框
		local endPos = touch:getLocation()
		self._multiSelectBox = cc.rect(self._toucheBeganPos.x, self._toucheBeganPos.y, 
			self._toucheBeganPos.x, self._toucheBeganPos.y)
			-- math.abs(endPos.x - self._toucheBeganPos.x), math.abs(endPos.y - self._toucheBeganPos.y)
		return
	end

	if ui.isExist(self.currentChild) then
		local location = touch:getLocation()
	    local moveDis = cc.pSub(location,lastPoint)
		local x, y = self.currentChild:getPosition()
		local newPos = cc.pAdd(cc.p(x, y), moveDis)
		newPos = cc.p(math.floor(newPos.x + 0.5), math.floor(newPos.y + 0.5))
		self.currentChild:setPosition(newPos)
		
		local parent = self.currentChild:getParent()
		self._touchPoint = parent:convertToWorldSpace(newPos)
		lastPoint = location
		self.viewPosInfo[self.currentChild.layoutUtilName] = {newPos.x, newPos.y}
		
		self.label:setString(self.currentChild.layoutUtilName .. "\n("..newPos.x..","..newPos.y..")")
		self.label:setPosition(cc.pAdd(cc.p(30, 30), self._touchPoint))
	end
end

--触摸结束了
function LayoutUtil:onTouchEnded(touch, event)
	if not tolua.isnull(self.currentChild) then
		self._touchPoint = nil
		curNode = self.currentChild
		local nodeX, nodeY = self.currentChild:getPosition()
		self.viewPosInfo[self.currentChild.layoutUtilName] = {math.floor(nodeX + 0.5), math.floor(nodeY + 0.5)}
		curPosNode = self.viewPosInfo[self.currentChild.layoutUtilName]
		curLabel = self.label
	end
	self._toucheBeganPos = nil
	self._multiSelectBox = nil
end

local wirtePosInfoHandler
function wirtePosInfoHandler(self, string)
	local path = cc.FileUtils:getInstance():getWritablePath().. "../../src/"..self.curFilename..".lua"
	local file = assert(io.open(path, 'w'))
	file:write(string)
	file:close()
end

local tabIndex = 0
local  function tab2str (tab)
	if type(tab) ~= "table" then
		return tab
	end
	local keytab = {}
	for k,v in pairs(tab) do
		table.insert(keytab,k)
	end
	table.sort(keytab,function(a,b)
		return (a < b)
	end)

	tabIndex = tabIndex + 1
	local tabStr = "\n"
	for i = 1, tabIndex do
		tabStr = tabStr .. "\t"
	end

	local s = ""
	for i,key in ipairs(keytab) do
		local v = tab[key]
		local keystr = key
		if type(key) == "number" then
			keystr = "[".. key .."]"
		end

		if type(v) ~= "table" then
			s = s .. tabStr .. tostring(keystr) .. "=".. tostring(v) ..","
		else
			s = s .. tabStr .. tostring(keystr) .. " = {".. tab2str(v).."},\n"
		end
	end

	tabIndex = tabIndex - 1
	return s
end

function write2ConfigFile(self, tab)
	local s = "return {".. tostring(tab2str(tab)).."}"
	wirtePosInfoHandler(self,s)
end


return LayoutUtil
