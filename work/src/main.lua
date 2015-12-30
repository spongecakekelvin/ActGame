local setting = {
    viewRect = cc.rect(0, 0, 1136 * 0.8, 640 * 0.8),
    resolutionSize = cc.size(1136, 640),
    resolutionPolicy = cc.ResolutionPolicy.FIXED_WIDTH,
    displayStats = true,
}
 -- 打印函数
gprint = print
-- print = function() end

-- 加载函数
oldRequire = require
require = function(path)
    local ret = oldRequire(path)
    if ret and (type(ret) == "userdata" or type(ret) == "table") then
        ret.__cpath = path -- 如果是类/对象，保存它的路径
        -- print("=== ret.__cpath =" .. ret.__cpath)
    end
    return ret
end

package.path = ";./?.lua;src/?.lua;work/src?.lua"

-- CC_USE_DEPRECATED_API = true
require "cocos/init"

-- cc.FileUtils:getInstance():addSearchPath("src")
-- cc.FileUtils:getInstance():addSearchPath("res")

-- require "gameInit"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
    return msg
end

local function printStat()
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()

    local frameSize = glview:getFrameSize()
    local winSize = director:getWinSize()
    local winSizeInPixels = director:getWinSizeInPixels()
    local visibleSize = director:getVisibleSize()
    local origin = director:getVisibleOrigin()

    print("============")
    print("设计分辨率: " .. setting.resolutionSize.width .. " " .. setting.resolutionSize.height)
    print("实际分辨率: " .. frameSize.width .. " " .. frameSize.height)
    print("设计分辨率: " .. winSize.width .. " " .. winSize.height)
    print("winSizeInPixels: " .. winSizeInPixels.width .. " " .. winSizeInPixels.height)
    print("可视区域visibleSize: " .. visibleSize.width .. " " .. visibleSize.height)
    print("起点坐标origin: " .. origin.x .. " " .. origin.y)
    print("绽放因子: " .. (frameSize.height / winSize.height))
    print("============")
end

local function initDirector()
    -- initialize director
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        glview = cc.GLViewImpl:createWithRect("ActGame", setting.viewRect)
        director:setOpenGLView(glview)
    end

    glview:setDesignResolutionSize(setting.resolutionSize.width, 
                                setting.resolutionSize.height,
                                setting.resolutionPolicy)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)

    --turn on display FPS
    director:setDisplayStats(setting.displayStats)
    cc.Texture2D:PVRImagesHavePremultipliedAlpha(true)

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
    end
end


local function initGameScene()
    require ("managers/SceneManager")
    SceneManager.runScene("game")
end


local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    printStat()
    initDirector()
    initGameScene()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
