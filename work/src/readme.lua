-- 项目文档 （持续优化...）
--[[
一、管理器
1、ModuleManager 控制器管理器 
包括ctl和data :
CtlManager 访问Controller, 需要配置路径	CtlManager.mainUI:updateView ()
DataMagaer 访问src/data/ 目录下的data文件  DataManager.MainUIData.getXXX()

2、ViewManager 界面管理器  
openView 提供接口负责界面打开统一逻辑
保存界面的实例

二、mvc




]]--

--[[
-----------  ActGame Brain Storm  -----------

skill是多组动作
普通攻击连招  攻击1-2-3
走-- 攻击1 -- 走 -- 攻击2 -- 走 -- 攻击3
每个攻击都要产生阻塞时间，阻塞时间内 不能切换动作（todo：某些技能可以强制切换）



方向：当前横版格斗类型用到方向2和6
   0
 7\|/1
6-----2
 5/|\3
   4



8.27 todo:
tech point:
组合的方式 角色: 技能-血量-飘字-数值-ai-动作队列Queue
1)continuous attack
2)walking
3) attack box\ hit box\ collision box
4)

受力抛物线 
连招
行走跳跃
控制面板
数值系统  -- 受伤累加破坏值 累加到一定量会被击飞
技能系统
地图xyz
网络局域网对战
AI FSM

并发的表现：
动画表现
物理表现(攻击框受击框)


------
摄像中心
1、两个玩家的中点
2、检测地图边界


--- 
todo: 控制全局变量的访问和赋值
setmetatable(_G , {__index =function()end})

---------------------------------------------
]]--