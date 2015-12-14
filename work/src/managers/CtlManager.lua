--------------------------
-- controller管理器
--------------------------
-- module("CtlManager", package.seeall)
local M = {}


-- 外部访问controller
-- e.g.  CtlManager.test
local ctlMap = {
    test = "modules/test/TestController",
    mainUI = "modules/mainUI/MainUIController",
}

-- 加载模块controller
-- TODO： 增加LoadingView ，逐帧加载进入游戏后用到的资源和controller等
M.loadModules = function()
    for key, modulePath in pairs(ctlMap) do
        Log.i("loading key = " .. key .. ", path = " .. modulePath)
        M[key] = require(modulePath).new()
    end
end


local modename = "CtlManager"
local proxy = {}
local mt    = {
    __index = M,
    __newindex =  function (t ,k ,v)
        -- print("attemp to update a read-only table")
    end
} 
setmetatable(proxy,mt)
_G[modename] = proxy
package.loaded[modename] = proxy
