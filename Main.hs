import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Layout.FixedColumn
import XMonad.Layout.BoringWindows
import XMonad.Layout.SubLayouts
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as W
import qualified Data.Map as M

varLayout = fullLayout ||| tallLayout ||| codingLayout
  where
    fullLayout = avoidStruts Full
    tallLayout = avoidStruts $ Tall 1 (3/100) (1/2)
    codingLayout = avoidStruts $ subLayout [1,0] Full (FixedColumn 1 1 84 10)

varKeys XConfig {XMonad.modMask = modm} = M.fromList [
   ((modm .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
 , ((modm .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
 , ((modm, xK_j), onGroup W.focusDown')
 , ((modm, xK_k), onGroup W.focusUp')
 , ((modm, xK_Tab), focusDown) ]

main = xmonad $ desktopConfig
        { manageHook = manageDocks <+> manageHook desktopConfig
        , handleEventHook = docksEventHook <+> handleEventHook desktopConfig
        , layoutHook = boringWindows $ smartBorders $ varLayout
        , focusedBorderColor = "#268AD2"
        , normalBorderColor = "#002B36"
        , keys = varKeys <+> keys desktopConfig
        , terminal = "x-terminal-emulator"
        , modMask = mod4Mask
        }
