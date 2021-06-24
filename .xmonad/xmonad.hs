import System.Exit
import Data.Maybe (Maybe, isNothing, fromJust)
import qualified Data.List as L
import qualified Data.Map as M
import GHC.IO.Handle
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.GridVariants
import XMonad.Actions.Navigation2D
import XMonad.Actions.GridSelect
import XMonad.Actions.UpdatePointer
import XMonad.Util.SpawnOnce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run

myTerminal		= "st"
myFocusFollowsMouse	= True
myClickJustFocuses	= False
myBorderWidth		= 1
myNormalBorderColor	= "#b3afc2"
myFocusedBorderColor	= "#b3afc2"
myModMask		= mod4Mask
myEventHook		= mempty

myStartupHook = do
    spawnOnce "picom -b &"
    setWMName "LG3D"
    startupHook desktopConfig

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x    = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
    $ [" 01 ", " 02 ", " 03 ", " 04 ", " 05 ", " 06 ", " 07 ", " 08 ", " 09 "]
    -- $ ["1: dev","2: www","3: code","4: sys","5: doc"] 

  where
  clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
    (i,ws) <- zip [1..9] l,
    let n = i ]
	
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
	[ 
	((modm .|. shiftMask, xK_Return), 
	spawn $ XMonad.terminal conf)					-- launch a terminal
	
	, ((modm,               xK_p		), 
	spawn "dmenu_run")  						-- launch dmenu
	
	, ((modm .|. shiftMask, xK_f		), 
	spawn "spacefm")    						-- launch spacefm
	
	, ((modm .|. shiftMask, xK_b		), 
	spawn "firefox")    						-- launch a web browser
	
	, ((modm .|. controlMask,xK_d		), 
	spawn "~/.local/bin/dm_fm")    					-- launch dmenufm
		
	, ((modm .|. controlMask,xK_e		), 
	spawn "~/.local/bin/dm_ed")    					-- launch dmenu edit
			
	, ((modm .|. controlMask,xK_p		), 
	spawn "~/.local/bin/dm_pass")    				-- launch Passmenu
		
	, ((modm .|. controlMask,xK_y		), 
	spawn "~/.local/bin/dm_ytdl")    				-- launch Youtube-dl menu
	
	, ((modm .|. controlMask,xK_q		), 
	spawn "~/.local/bin/dm_power")    				-- launch Exit menu
	
	, ((modm .|. controlMask,xK_k		), 
	spawn "~/.local/bin/dm_col")    			        -- launch Hex menu
	
	, ((modm .|. controlMask,xK_c		), 
	kill)    							-- close focused window
	
	, ((modm,               xK_space 	), 
	sendMessage NextLayout) 				        -- Rotate through the available layout algorithms
	
	, ((modm .|. shiftMask, xK_space 	), 	
	setLayout $ XMonad.layoutHook conf)  			        -- Reset the layouts on the current workspace to default
	
	, ((modm,               xK_n     	), 
	refresh)   						        -- Resize viewed windows to the correct size
	
	, ((modm,               xK_f		), 
	sendMessage $ Toggle FULL)  					-- Toggle current focus window to fullscreen
	
	, ((modm,               xK_b 		), 
	sendMessage ToggleStruts)					-- Toggle current focus window to fullscreen over xmobar  
	
	, ((modm,               xK_Tab   	), 
	windows W.focusDown)    					-- Move focus to the next window
	
	, ((modm,               xK_j     	), 
	windows W.focusDown)  						-- Move focus to the next window
	
	, ((modm,               xK_k    	), 
	windows W.focusUp  )    					-- Move focus to the previous window
	
	, ((modm,               xK_m    	), 
	windows W.focusMaster  )   					-- Move focus to the master window
	
	, ((modm,               xK_Return	), 
	windows W.swapMaster)  						-- Swap the focused window and the master window
	
	, ((modm .|. shiftMask, xK_j     	), 
	windows W.swapDown  )  						-- Swap the focused window with the next window
	
	, ((modm .|. shiftMask, xK_k     	), 
	windows W.swapUp    )  						-- Swap the focused window with the previous window
	
	, ((modm,               xK_h     	), 
	sendMessage Shrink)   						-- Shrink the master area
	
	, ((modm,               xK_l     	), 
	sendMessage Expand)   						-- Expand the master area
	
	, ((modm,               xK_t     	), 
	withFocused $ windows . W.sink)   				-- Push window back into tiling
	
	, ((modm,		xK_comma 	), 
	sendMessage (IncMasterN 1))   					-- Increment the number of windows in the master area
	
	, ((modm,		xK_period	), 
	sendMessage (IncMasterN (-1)))   				-- Deincrement the number of windows in the master area
	
	, ((modm,		xK_b     	), 
	sendMessage ToggleStruts)    					-- Toggle the status bar gap
	
	, ((modm .|. shiftMask,	xK_q     	), 
	io (exitWith ExitSuccess))    					-- Quit xmonad
	
	, ((modm .|. controlMask,xK_r     	), 
	spawn "xmonad --recompile; xmonad --restart")	                -- Restart xmonad
	
	, ((0			,xK_F10), 	   
	spawn "amixer -q set Master toggle")			        -- Toggle/Untoggle Volume
	
	, ((0			,xK_F11), 	   
	spawn "amixer set Master 1-")					-- Decrease volume
	
	, ((0			,xK_F12), 	   
	spawn "amixer set Master 1+")					-- Increase volume
	
	, ((0			,xK_Print), 	   
	spawn  "~/.local/bin/dm_ss")					-- Screenshot

	]
	
	++
	[((m .|. modm, k), windows $ f i)
	| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
	
	++
	[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
	| (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
	, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    , ((modm .|. shiftMask, button1), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))]

myLayout = ( tiled ||| Mirror tiled ||| grid ||| Full )
 where
	tiled	=	renamed		[Replace "Tall"]		$ spacing 4		$ ResizableTall 1 (3/100) (1/2) []
	grid	=	renamed		[Replace "Grid"]		$ spacing 8		$ Grid (16/10)
	
	nmaster	= 1
	ratio			= 1/2
	delta			= 3/100

myManageHook = composeAll
	[ className =? "firefox"--> doShift "<action=xdotool key super+2>www</action>"
	, className =? "Gimp"	--> doShift "<action=xdotool key super+9>gimp</action>"
	, className =? "mpv"	--> doFloat
	,(className =? "firefox" <&&> resource =? "Dialog") --> doFloat]

myLogHook :: Handle -> X ()
myLogHook
	xmproc			= dynamicLogWithPP xmobarPP
	{ ppOutput		= \x -> hPutStrLn xmproc x  >> hPutStrLn xmproc x
	, ppCurrent		= xmobarColor "#FCFCFC" "" . wrap "[" "]" 			-- Current workspace in xmobar
	, ppVisible		= xmobarColor "#b3afc2" ""                			-- Visible but not current workspace
	, ppHidden		= xmobarColor "#b3afc2" "" . wrap "*" ""   			-- Hidden workspaces in xmobar
	, ppHiddenNoWindows 	= xmobarColor "#b3afc2" ""        				-- Hidden workspaces (no windows)
	, ppTitle 		= xmobarColor "#b3afc2" "" . shorten 85     			-- Title of active window in xmobar
	, ppSep 		=  "<fc=#b3afc2> | </fc>"                     			-- Separators in xmobar
	, ppUrgent 		= xmobarColor "#C45500" "" . wrap "!" "!"  			-- Urgent workspace
	, ppOrder  		= \(ws:l:t:ex) -> [ws,l]++ex++[t]
	}

main = do
    xmproc <- spawnPipe "/$HOME/.local/bin/xmobar"
    xmonad $ myConfig xmproc  

myConfig xmproc			= withNavigation2DConfig def {
	defaultTiledNavigation	= centerNavigation} 
	$ def {
	terminal		= myTerminal,
	focusFollowsMouse	= myFocusFollowsMouse,
	clickJustFocuses	= myClickJustFocuses,
	borderWidth		= myBorderWidth,
	modMask			= myModMask,
	workspaces		= myWorkspaces,
	normalBorderColor	= myNormalBorderColor,
	focusedBorderColor	= myFocusedBorderColor,
	keys			= myKeys,
	mouseBindings		= myMouseBindings,
	layoutHook		= avoidStruts  $ desktopLayoutModifiers $ smartBorders $ mkToggle (NOBORDERS ?? FULL ?? EOT) myLayout,
	manageHook		= myManageHook <+> manageHook desktopConfig,
	handleEventHook		= myEventHook <+> handleEventHook desktopConfig,
	logHook			= (myLogHook xmproc) <+>fadeInactiveLogHook 0.95 <+> logHook desktopConfig,
	startupHook		= myStartupHook}
