-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Actions.CycleWorkspaceByScreen
-- Description :  Cycle workspaces in a screen-aware fashion.
-- Copyright   :  (c) 2017 Ivan Malison
-- License     :  BSD3-style (see LICENSE)
--
-- Maintainer  :  IvanMalison@gmail.com
-- Stability   :  unstable
-- Portability :  unportable
--
-- Cycle through previously viewed workspaces in the order they were viewed most
-- recently on the screen where cycling is taking place.
--
-----------------------------------------------------------------------------

module XMonad.Actions.CycleWorkspaceByScreen (
    -- * Usage
    -- $usage
    cycleWorkspaceOnScreen
  , cycleWorkspaceOnCurrentScreen
  , handleKeyEvent
  , repeatableAction
  ) where

import           Data.IORef

import           XMonad
import           XMonad.Prelude
import           XMonad.Hooks.WorkspaceHistory
import           XMonad.Actions.Repeatable (repeatable)
import qualified XMonad.StackSet as W

-- $usage
--
-- To use this module, first import it as well as
-- "XMonad.Hooks.WorkspaceHistory":
--
-- > import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)
-- > import XMonad.Actions.CycleWorkspaceByScreen
--
-- Then add 'workspaceHistoryHook' to your @logHook@ like this:
--
-- > main :: IO ()
-- > main = xmonad $ def
-- >    { ...
-- >    , logHook = workspaceHistoryHook >> ...
-- >    }
--
-- Finally, define a new keybinding for cycling (seen) workspaces per
-- screen:
--
-- > , ((mod4Mask, xK_slash), cycleWorkspaceOnCurrentScreen [xK_Super_L] xK_slash xK_p)

{-# DEPRECATED repeatableAction "Use XMonad.Actions.Repeatable.repeatable" #-}
repeatableAction :: [KeySym] -> KeySym -> (EventType -> KeySym -> X ()) -> X ()
repeatableAction = repeatable

handleKeyEvent :: EventType
               -> KeySym
               -> X ()
               -> EventType
               -> KeySym
               -> Maybe (X ())
handleKeyEvent eventType key action = helper
  where
  helper et k
    | et == eventType && k == key = Just action
    | otherwise = Nothing


runFirst :: [EventType -> KeySym -> Maybe (X ())] -> EventType -> KeySym -> X ()
runFirst matchers eventType key =
  fromMaybe (return ()) $ join $ find isJust $ map (\fn -> fn eventType key) matchers

-- | Like 'XMonad.Actions.CycleRecentWS.cycleRecentWS', but only cycle
-- through the most recent workspaces on the given screen.
cycleWorkspaceOnScreen
  :: ScreenId -- ^ The screen to cycle on.
  -> [KeySym] -- ^ A list of modifier keys used when invoking this
              --   action; as soon as one of them is released, the final
              --   switch is made.
  -> KeySym   -- ^ Key used to switch to next workspace.
  -> KeySym   -- ^ Key used to switch to previous workspace.
  -> X ()
cycleWorkspaceOnScreen screenId mods nextKey prevKey = workspaceHistoryTransaction $ do
  startingHistory <- workspaceHistoryByScreen
  currentWSIndex <- io $ newIORef 1
  let cycleWorkspaces = fromMaybe [] $ lookup screenId startingHistory
      getAndIncrementWS increment = do
        current <- readIORef currentWSIndex
        modifyIORef
          currentWSIndex
          ((`mod` length cycleWorkspaces) . (+ increment))
        return $ cycleWorkspaces !! current
      focusIncrement i = io (getAndIncrementWS i) >>= (windows . W.greedyView)

  repeatable mods nextKey $
    runFirst
      [ handleKeyEvent keyPress nextKey $ focusIncrement 1
      , handleKeyEvent keyPress prevKey $ focusIncrement (-1)
      ]
  return ()

-- | Like 'cycleWorkspaceOnScreen', but supply the currently focused
-- screen as the @screenId@.
cycleWorkspaceOnCurrentScreen
  :: [KeySym] -> KeySym -> KeySym -> X ()
cycleWorkspaceOnCurrentScreen mods n p =
  withWindowSet $ \ws ->
    cycleWorkspaceOnScreen (W.screen $ W.current ws) mods n p
