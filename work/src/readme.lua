-- 项目文档 （持续优化...）
--[[
一、管理器
1、ModuleManager 控制器管理器 
包括ctl和data :
CtlManager 访问Controller, 需要配置路径	CtlManager.mainUI:updateView ()
DataMagaer 访问src/data/ 目录下的data文件  DataManager.MainUIData.getXXX()

2、ViewManager 界面管理器  
openView 提供接口负责界面打开统一出题
保存界面的实例

二、mvc




]]--

--[[
-----------  ActGame Brain Storm  -----------

skill是多组动作
普通攻击连招  攻击1-2-3
走-- 攻击1 -- 走 -- 攻击2 -- 走 -- 攻击3
每个攻击都要产生阻塞时间，阻塞时间内 不能切换动作（todo：某些技能可以强制切换）



---------------------------------------------
]]--