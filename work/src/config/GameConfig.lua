--GameConfig.lua
GameConfig = GameConfig or {

	isDebug = true,
	isInGuideMode = true, --引导调试
    
--    animationInterval = 1/30,
}

local targetPlatform = cc.Application:getInstance():getTargetPlatform()
if targetPlatform == cc.PLATFORM_OS_WINDOWS then
    GameConfig.defaultFonts = "Microsoft YaHei"
else
    GameConfig.defaultFonts = "Arial"
end