local tClass = class("KeyManager")
--[[

]]--

function tClass:ctor()
	self.keyMap = {}
	self.currentKey = nil
	self._onKeyDown = nil
	self._onKeyUp = nil
	self._queue = {}
end

function tClass:onKeyDown(callback)
	self._onKeyDown = callback
end

function tClass:onKeyUp(callback)
	self._onKeyUp = callback
end

function tClass:keyDown(key)
	if self.keyMap[key] then
		return
	end
	
	local index = #self._queue + 1
	self.keyMap[key] = index
	self._queue[index] = key

	self.currentKey = key

	if self._onKeyDown then
		self._onKeyDown(key)
	end
end

function tClass:keyUp(key)
	if not self.keyMap[key] then
		return
	end

	table.remove(self._queue, self.keyMap[key])
	self.keyMap[key] = nil

	self.currentKey = nil
	
	if self._onKeyUp then
		self._onKeyUp(key)
	end
end

function tClass:getNextKey()
	if #self._queue > 0 then
		return self._queue[1]
	end
end


return tClass
