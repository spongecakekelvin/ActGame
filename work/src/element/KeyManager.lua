local tClass = class("KeyManager")
--[[

]]--

function tClass:ctor(role)
	self.keyMap = {}
	self.currentKey = nil
	self._onKeyDown = nil
	self._onKeyUp = nil
	self._index = 0
	self._role = role
	Log.d("====== role = ", tostring(role))
end

function tClass:onKeyDown(callback)
	self._onKeyDown = callback
end

function tClass:onKeyUp(callback)
	self._onKeyUp = callback
end

function tClass:incIndex()
	self._index = self._index + 1
end

function tClass:keyDown(key)
	if self.currentKey == key then
		return
	end
	self.keyMap[key] = os.time()
	self.currentKey = key

	if self._onKeyDown then
		self._onKeyDown(key)
	end
end

function tClass:keyUp(key)
	if not key then
		return
	end

	self.keyMap[key] = nil

	self.currentKey = nil
	local mint = 0
	local lastKey
	for k, v in pairs(self.keyMap) do
		if v > mint then
			mint = v
			lastKey = k
		end
	end
	if lastKey then
		self.currentKey = lastKey
	elseif self._role then
		Log.d(" ========= roel STAND")
		self._role:stand()
	end
	
	if self._onKeyUp then
		self._onKeyUp(key)
	end
end


function tClass:keyDownReplace(key)
	if self.currentKey and self.currentKey == key then
		return
	end
	Log.d("====replcae key = ", key)
	self:keyUp(self.currentKey)
	self:keyDown(key)
end

function tClass:getNextKey()
end


return tClass
