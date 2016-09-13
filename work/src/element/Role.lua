local baseClass = require("element/Element")
local tClass = class("Role", baseClass)

--[[
+ skill(target, data)
+ attack(target, data)
+ stand()
+ walk(pos)

+ addEnemys

- onFrameUpdate() -- update
- doAttack()

memeber:
- _animNode

]]--

local StateManager = require("element/StateManager")
local KeyManager = require("element/KeyManager")

local aabb = helper.aabb
local _move = GameConfig.keyMap.move
local _actionName = GameConfig.keyMap.actionName
local _direction = GameConfig.keyMap.direction
local linear = GameConfig.keyMap.easing['linear']
local now = helper.now

local MOVE_OFFSET_X = MOVE_OFFSET_X
local MOVE_OFFSET_Y = MOVE_OFFSET_Y

local defaultData = {
	id = 0,
	name = "jianshi",
	actionName = "stand",
	direction = DIR.right,
	test_boxes = true,
}

function tClass:ctor(animData, property)
	self._animData = setmetatable(animData or {}, {__index = defaultData}) -- 需在父类初始化前赋值
	tClass.super.ctor(self)

	self._property = setmetatable(property or {}, {__index = defaultData}) -- hp mp etc.

	self._enemys = {}

	self.walkFrameCallback = nil
	self.nextActions = {defaultData.actionName}

	self.stateManager = StateManager.new()
	self.keyManager = KeyManager.new()
	self.keyManager:onKeyDown(handler(self, self.onKeyDownHandler))
	self.keyManager:onKeyUp(handler(self, self.onKeyUpHandler))
	
end

function tClass:skill(target, data)
end

-- function tClass:attack(target, data)
-- end

function tClass:isStand()
	return ("stand" == self._animNode.model.actionName)
end

function tClass:stand()
	self.route = nil
	self.walkFrameCallback = nil
	self.nextActions = {defaultData.actionName}
end

-- function tClass:getRoute(destPos)
-- 	local originx, originy = self:getPosition()
-- 	local route = {}
-- 	local x = originx
-- 	while true do
-- 		x = x + MOVE_OFFSET_X
-- 		if x >= destPos.x then
-- 			break
-- 		end
-- 		route[#route + 1] = {x = x, y = originy}
-- 	end

-- 	if x > destPos.x and x < destPos.x + MOVE_OFFSET_X then
-- 		route[#route + 1] = {x = destPos.x, y = originy}
-- 	end
-- 	return route
-- end

-- function tClass:walk(destPos)
-- 	if destPos.x < 0 or destPos.y > 1136 then
-- 		Log.d("walk 超过边界")
-- 		return
-- 	end
-- 	self:changeAction("walk")
-- 	self.nextActions = {"walk"}
-- 	self.route = self:getRoute(destPos)
-- 	Log.t(self.route, "=== route it is ===")
-- 	if #self.route > 0 then
-- 		self.routeIndex = 1
-- 		self.walkFrameCallback = function(self)
-- 			if not self.route then
-- 				return
-- 			end
-- 			if self.route[self.routIndex] then
-- 				self:setPosition(self.route[self.routIndex])
-- 				self.routIndex = self.routIndex + 1
-- 			else
-- 				self.walkFrameCallback = nil
-- 				self:changeAction(defaultData.actionName)
-- 				Log.d("=== not route found, index = ", self.routIndex)
-- 			end
-- 		end
-- 	end
-- end

-- function tClass:walkOffset(offsetPos)
-- 	local originPos = cc.p(self:getPosition())
-- 	Log.t(offsetPos)
-- 	self:walk(cc.p(offsetPos.x + originPos.x, originPos.y))
-- end

function tClass:onFrameUpdate(model) -- 当帧改变时调用
	self:updateDrawNode(model)
	if self.walkFrameCallback then
		self.walkFrameCallback(self)
	end
end

function tClass:onFrameLoop() -- 每帧时间调用一次
	self:checkPosition()
	self:checkCollision()
end

function tClass:addEnemys(list)
	for i, v in ipairs(list) do
		if not tolua.isnull(v) then
			table.insert(self._enemys, v)
		end
	end
end

function tClass:checkCollision()
	if tolua.isnull(self._attBox) or not self._attBox._rect then
		return
	end
	local rect = self._attBox._rect
	local targetElements = nil
	for i, v in ipairs(self._enemys) do
		if v._hitBox and aabb(rect, v._hitBox._rect) then
			Log.d("aabb succcccccc!!!! Role".. self._property.id.. " attacks Role".. v._property.id)
			if not targetElements then
				targetElements = {}
			end
			table.insert(targetElements, v)
		end
	end

	if targetElements then
		for i, v in ipairs(targetElements) do
			v:hurt()
		end
	end
	return targetElements
end


function tClass:hurt()
	self:changeAction("hurt")
	Effect.hurt(self._animNode) -- bug useless, anything to do with black image resource? Yes
end


function tClass:checkPosition(currentKey)
	-- if ( self.animate_type === 'stick' ){
	-- 	if ( self.master.direction === 1 ){
	-- 		self.left = self.master.left + self.easing[0];
	-- 	}else{
	-- 		self.left = self.master.left + self.master.width - self.easing[0] + self.width;
	-- 	}
	-- 	self.top = self.master.top + self.easing[1];
	-- }else{
	-- 	self.animate.move();
	-- }
	currentKey = currentKey or self.keyManager.currentKey
	if not currentKey then
		return
	end

	local action = _move[currentKey]
	if action then
		Log.d("==== currentKey ", currentKey, _actionName[action], _actionName[action], _direction[currentKey])

		local dir = _direction[currentKey]
		self:changeDirection(dir)
		self:changeAction(_actionName[action])

		local x, y = self:getPosition()
		if dir == DIR.right then
			x = x + 5
		elseif dir == DIR.left then
			x = x - 5
		end

		if x < 43 then
			x = 43
		elseif x >1136 - 43 then
			x = 1136 - 43
		end
		self:setPosition(x, y)
	end
		
	
	-- spirit.animate.start( ( attack_light ? -20 : -70 ) * spirit.direction, 0, 200, 'linear' );
	-- start = function( left, top, t, fn ){
	-- if now() - startTime >= time then
	-- 	-- event.fireEvent( 'framesDone' );	
	-- end

	-- var framefn = function(){   //¸ømoveÓÃµÄ
		
	-- 	if ( lock ) return;

	-- 	var op = _move[ getKeyMap() ] || _move[ getKeyMapFirst() ];
	-- 	op ? _keydown( op ) : _keyup();

	-- 	if ( op ){
	-- 		var last = keyQueue.last();
	-- 		if ( !last || op !== last ) keyQueue.add( op );
	-- 	}

	-- 	if ( ++count % key_fps === 0 ){
	-- 		count = 0;
	-- 		keyQueue.clean();
	-- 	}
	-- }
end


function tClass:onKeyDownHandler()
	self:checkPosition()
end

function tClass:onKeyUpHandler()
	local nextKey = self.keyManager:getNextKey()
	if nextKey then
		self:checkPosition(nextKey)
	else
		self:changeAction(defaultData.actionName)
	end
end

return tClass