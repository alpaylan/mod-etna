{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE TypeApplications #-}
module Etna.Properties
  ( property_invert_mod_natural_unit
  , property_invert_mod_word_unit
  ) where

import           Etna.Result
import qualified Data.Mod      as M
import qualified Data.Mod.Word as MW

-- | For the type-level modulus 1 there is exactly one inhabitant (0), and
-- @gcd(x, 1) = 1@ for every @x@. Therefore @invertMod x@ must always return
-- @Just y@ such that @x * y@ is congruent to 1 modulo 1 (which is 0). The
-- buggy version returns 'Nothing' for the only inhabitant, violating the
-- modular-inverse contract for the unit modulus.
property_invert_mod_natural_unit :: Int -> PropertyResult
property_invert_mod_natural_unit n =
  let x = fromIntegral n :: M.Mod 1
  in case M.invertMod x of
       Just y
         | x * y == fromInteger 1 -> Pass
         | otherwise              -> Fail
             ("invertMod " ++ show n ++ " :: Mod 1 returned Just "
              ++ show y ++ ", but x * y /= 1")
       Nothing -> Fail
         ("invertMod " ++ show n ++ " :: Mod 1 returned Nothing, expected Just 0")

-- | Same property for 'Data.Mod.Word' (the @Word@-backed unboxed
-- implementation). The bug was duplicated across both modules.
property_invert_mod_word_unit :: Int -> PropertyResult
property_invert_mod_word_unit n =
  let x = fromIntegral n :: MW.Mod 1
  in case MW.invertMod x of
       Just y
         | x * y == fromInteger 1 -> Pass
         | otherwise              -> Fail
             ("Word.invertMod " ++ show n ++ " :: Mod 1 returned Just "
              ++ show y ++ ", but x * y /= 1")
       Nothing -> Fail
         ("Word.invertMod " ++ show n ++ " :: Mod 1 returned Nothing, expected Just 0")
