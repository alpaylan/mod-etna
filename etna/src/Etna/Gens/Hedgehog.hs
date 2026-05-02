module Etna.Gens.Hedgehog
  ( gen_invert_mod_natural_unit
  , gen_invert_mod_word_unit
  ) where

import           Hedgehog       (Gen)
import qualified Hedgehog.Gen   as Gen
import qualified Hedgehog.Range as Range

gen_invert_mod_natural_unit :: Gen Int
gen_invert_mod_natural_unit = Gen.int (Range.linear (-10000) 10000)

gen_invert_mod_word_unit :: Gen Int
gen_invert_mod_word_unit = Gen.int (Range.linear (-10000) 10000)
