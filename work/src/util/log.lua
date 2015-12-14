module("Log", package.seeall)

local gprint = gprint

local function simpleFilename(name)
    local index = string.find(name, "/")
    while index do
        name = string.sub(name, index+1, -1)
        if name then
           index = string.find(name, "/")
        else
            return ""
        end
    end
    return name
end

function d(...)
    if GameConfig.isDebug then
        i(...)
    end
end

function i(...)
    local dbgInfo = debug.getinfo(3, "lS")
    if dbgInfo and dbgInfo.source and dbgInfo.currentline then
        gprint(string.format("[\"%s\":%d]", simpleFilename(dbgInfo.source), dbgInfo.currentline), ...)
    else
        gprint(...)
    end
end

-- 函数栈打印出来
function e(...)
    i(debug.traceback() .. "\n", ...)
end

--------------------------------------
-- 打印表
--  tab     要打印的table
-- print    输出函数
--------------------------------------
function t(tab)
    local str = ""
    local function traverseTable(tab, suojin)
        ---忽略指定字段
        -- if tab.itab then tab.itab = nil end--itab        
        
        if type(tab) ~= "table" then
            gprint(debug.traceback())
        end
        for i, v in pairs(tab) do
            --防止布尔型，用户数据，函数产生问题
            if i ~= "itab" and i ~= "__index" then
                if type(v) == "boolean" or type(v) == "userdata" or type(v) == "function" then 
                    v = tostring(v)
                end
                
                if type(v) == "table" then
                    local pStr = type(i) == "string" and i.." = {" or "["..i.."]".." = {"
                    local suojinStr = ""
                    for i = 1, suojin do suojinStr = suojinStr.."|   " end--增加缩进
                    gprint(suojinStr..pStr)
                    -- str = str .. "\n" .. suojinStr..pStr
                    traverseTable(v, suojin + 1)
                    gprint(suojinStr .. "}")
                    -- str = str .. "\n" .. suojinStr .. "}"
                else
--                  local pStr = type(i) == "string" and i.." = "..v.."," or "["..i.."]".." = "..v..","
                    local pStr
                    if type(i) == "string" then
                        pStr = i.." = "..v..","
                    elseif type(i) == "userdata" then
                        pStr = "[userdata]".." = "..v..","
                    else
                        pStr = "["..i.."]".." = "..v..","
                    end
                    
                    local suojinStr = ""
                    for i = 1, suojin do suojinStr = suojinStr.."|   " end
                    gprint(suojinStr..pStr)
                    -- str = str .. "\n" .. suojinStr..pStr
                end
            end
        end
    end

    if not tab then
        gprint("该tab为nil, 函数无法打印")
        return
    end
    Log.i()
    gprint(tostring(tab).." = {")
    traverseTable(tab, 1)
    gprint("}")
end
