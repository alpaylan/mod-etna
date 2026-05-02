module Etna.Gens.QuickCheck
  ( gen_invert_mod_natural_unit
  , gen_invert_mod_word_unit
  ) where

import qualified Test.QuickCheck as QC

gen_invert_mod_natural_unit :: QC.Gen Int
gen_invert_mod_natural_unit = QC.arbitrary

gen_invert_mod_word_unit :: QC.Gen Int
gen_invert_mod_word_unit = QC.arbitrary
