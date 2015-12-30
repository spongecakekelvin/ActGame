-- 以下加载顺序调整需要注意
require("config/GameConfig")
require("util/helper")
require("config/Global")
require("util/log")
require("util/uiUtil")
require("util/uiFactory")

require("util/EventType")

require("managers/TimerManager")
TimerManager.start()
require("managers/EventManager")
require("managers/SceneManager")
require("managers/ViewManager")
require("managers/CtlManager")
CtlManager.loadModules()
require("managers/DataManager")
require("managers/AnimManager")




