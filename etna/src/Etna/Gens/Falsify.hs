module Etna.Gens.Falsify
  ( gen_invert_mod_natural_unit
  , gen_invert_mod_word_unit
  ) where

import qualified Test.Falsify.Generator as F
import qualified Test.Falsify.Range     as FR

gen_invert_mod_natural_unit :: F.Gen Int
gen_invert_mod_natural_unit =
  fromIntegral <$> F.inRange (FR.between (-10000, 10000 :: Int))

gen_invert_mod_word_unit :: F.Gen Int
gen_invert_mod_word_unit =
  fromIntegral <$> F.inRange (FR.between (-10000, 10000 :: Int))
