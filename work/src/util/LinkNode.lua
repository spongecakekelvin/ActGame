LinkNode = class("LinkNode")

function LinkNode:ctor(data, next, prev)
	self.data = data
	self.prev = prev
	self.next = next
end

function LinkNode:addNext(node)
	if self.next then
		node.prev = self
		node.next = self.next
		self.next = node
	else
		self.next = node
	end
end
	
function LinkNode:removeNext()
	if self.next then
		local nextNode = self.next
		self.next = nextNode.next
		if nextNode.prev then
			nextNode.prev.next = nextNode.next
		end
		if nextNode.next then
			nextNode.next.prev = nextNode.prev
		end
		return nextNode
	end
end

function LinkNode:getNext()
	return self.next
end