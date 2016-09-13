module("GameConfig", package.seeall)

viewRect = cc.rect(0, 0, 1136 * 0.8, 640 * 0.8)
resolutionSize = cc.size(1136, 640)
resolutionPolicy = cc.ResolutionPolicy.FIXED_WIDTH
displayStats = true
fps = 1.0 / 60

isDebug = true
isInGuideMode = true --引导调试
--    animationInterval = 1/30,

defaultFonts = "Microsoft YaHei"
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
if targetPlatform ~= cc.PLATFORM_OS_WINDOWS then
    GameConfig.defaultFonts = "Arial"
end

-- 键位
keyMap = {
	mapping = {
		[121]= 'a',
		[139]= 's',
		[124]= 'd',
		[143]= 'w',
		[141]= 'u',
		[129]= 'i',
		[130]= 'j',
		[131]= 'k',
	},
	move = {
		['w'] = 'jump',
		['a'] = 'back',
		['wa'] = 'jump_back',
		['aw'] = 'jump_back',
		['wd'] = 'jump_forward',
		['dw'] = 'jump_forward',
		['sd'] = 'crouch',
		['ds'] = 'crouch',
		['as'] = 'stand_crouch_defense',
		['sa'] = 'stand_crouch_defense',
		['d'] = 'forward',
		['s'] = 'crouch'
	},
	actionName = {
		['back'] = 'walk',
		['forward'] = 'walk',
	},
	direction = {
		['a'] = 6,
		['d'] = 2,
	},
	easing = {
		linear = function( t, b, c, d )
			return c*t/d + b;
		end,
		easeIn = function( t, b, c, d )
			t = t / d
   			return c * t * t + b;
 		end,
		strongEaseIn = function(t, b, c, d)
			t = t / d
			return c * t * t * t * t * t + b;
		end,
		strongEaseOut = function(t, b, c, d)
			t = t / d
			return c * ((t - 1) * t * t * t * t + 1) + b;
		end,
		sineaseIn = function( t, b, c, d )
			t = t / d
			return c*t*t*t + b;
		end,
    },
	
}