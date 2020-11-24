local Event = {

}
local events = {}

--产生一个新的事件
function Event:Create(_name)
    local o = {}
	o._events = {}
    --继承本表
    setmetatable(o, self)
    self.__index = self

    o.Name = _name

    events[_name] = o
    return o
end    

--事件添加一个新的方法
function Event:Add(func, ...)
    local para = table.pack(...)
    self._events[func] = para
end

--将方法从事件的列表中移除
function Event:Remove(func)
    self._events[func] = nil
end

--调用事件，并添加新的参数
function Event:Invoke(...)
    for func, para in pairs(self._events) do
		local paras = {}
		for i, v in ipairs(para) do
			table.insert(paras, v)
		end
		for i, v in ipairs(table.pack(...)) do
			table.insert(paras, v)
		end
		func(table.unpack(paras))
    end
end

--判断事件是否连接了方法
function Event:IsConnecting(func)
    return self._events[func]
end

return Event