-- 以下加载顺序调整需要注意
require("config/GameConfig")
require("util/helper")
require("util/log")
require("util/ui")
require("util/gui")

require("util/EventType")

require("managers/EventManager")
require("managers/SceneManager")
require("managers/ViewManager")
require("managers/CtlManager")
CtlManager.loadModules()





