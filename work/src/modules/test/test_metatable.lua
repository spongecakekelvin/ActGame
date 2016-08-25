-- test_metatable.lua
function Class(base, _ctor)
    local c = {}    -- a new class instance
    if not _ctor and type(base) == 'function' then
        _ctor = base
        base = nil
    elseif type(base) == 'table' then
    -- our new class is a shallow copy of the base class!
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end
    
    -- the class will be the metatable for all its objects,
    -- and they will look up their methods in it.
    c.__index = c

    -- expose a constructor which can be called by <classname>(<args>)
    local mt = {}
    
    if TrackClassInstances == true then
        if ClassTrackingTable == nil then
            ClassTrackingTable = {}
        end
        ClassTrackingTable[mt] = {}
    local dataroot = "@"..CWD.."\\"
        local tablemt = {}
        setmetatable(ClassTrackingTable[mt], tablemt)
        tablemt.__mode = "k"         -- now the instancetracker has weak keys
    
        local source = "**unknown**"
        if _ctor then
        -- what is the file this ctor was created in?

        local info = debug.getinfo(_ctor, "S")
        -- strip the drive letter
        -- convert / to \\
        source = info.source
        source = string.gsub(source, "/", "\\")
            source = string.gsub(source, dataroot, "")
        local path = source

        local file = io.open(path, "r")
        if file ~= nil then
            local count = 1
            for i in file:lines() do
                if count == info.linedefined then
                        source = i
                -- okay, this line is a class definition
                -- so it's [local] name = Class etc
                -- take everything before the =
                local equalsPos = string.find(source,"=")
                if equalsPos then
                source = string.sub(source,1,equalsPos-1)
                end 
                -- remove trailing and leading whitespace
                        source = source:gsub("^%s*(.-)%s*$", "%1")
                -- do we start with local? if so, strip it
                        if string.find(source,"local ") ~= nil then
                            source = string.sub(source,7)
                        end
                    -- trim again, because there may be multiple spaces
                        source = source:gsub("^%s*(.-)%s*$", "%1")
                        break
                end
                    count = count + 1
            end
            file:close()
        end
        end
                             
        mt.__call = function(class_tbl, ...)
            local obj = {}
            setmetatable(obj,c)
            ClassTrackingTable[mt][obj] = source
            if c._ctor then
                c._ctor(obj,...)
            end
            return obj
        end    
    else
        mt.__call = function(class_tbl, ...)
            local obj = {}
            setmetatable(obj,c)
            if c._ctor then
               c._ctor(obj,...)
            end
            return obj
        end    
    end
        
    c._ctor = _ctor
    c.is_a = function(self, klass)
        local m = getmetatable(self)
        while m do 
            if m == klass then return true end
            m = m._base
        end
        return false
    end
    setmetatable(c, mt)
    return c
end


local function testFunc()
    local Widget = Class(function(self, name)
        self.name = name or "Widget"
    end)
    local Screen = Class(Widget, function(self)
        Widget._ctor(self, "Screen")
    end)
    local screen = Screen()
    Log.d(screen.name, type(Screen), type(Widget), type(screen))
    -- local baseClass = {name= "bc"}
    -- local bc = baseClass()
    -- Log.d(bc.name)
end

-- __add   对应的运算符 '+'.
-- __sub   对应的运算符 '-'.
-- __mul   对应的运算符 '*'.
-- __div   对应的运算符 '/'.
-- __mod   对应的运算符 '%'.
-- __unm   对应的运算符 '-'.
-- __concat    对应的运算符 '..'.
-- __eq    对应的运算符 '=='.
-- __lt    对应的运算符 '<'.
-- __le    对应的运算符 '<='.

return function() 
    Log.i("============== +Test Began+ ==============")
    testFunc() 
    Log.i("============== -Test Ended- ==============")
end