-- 以下加载顺序调整需要注意
require("config/GameConfig")
require("util/helper")
require("config/Global")
require("util/log")
require("util/uiUtil")
require("util/uiFactory")

require("util/EventType")
require("util/LinkNode")

require("managers/TimeManager")
TimeManager.init()
require("managers/DataManager")
require("managers/EventManager")
require("managers/SceneManager")
require("managers/ViewManager")
require("managers/AnimManager")
AnimManager.init()
require("managers/ResManager")
ResManager.loadAll()
require("managers/CtlManager")
CtlManager.loadAll()

-- 测试 TimeManager
-- local totalTime = 0
-- local timerId = TimeManager.addTimer(function(dt) totalTime = totalTime + dt Log.i("你好呀！~" .. totalTime) end, 1)
-- TimeManager.addDelay(function() Log.i("===========  I AM NOT GOOD/!1") end, 3)
-- TimeManager.addDelay(function() TimeManager.removeTimer(timerId) end, 6)

require("util/Effect")
