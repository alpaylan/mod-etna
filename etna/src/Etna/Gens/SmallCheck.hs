module Etna.Gens.SmallCheck
  ( series_invert_mod_natural_unit
  , series_invert_mod_word_unit
  ) where

import qualified Test.SmallCheck.Series as SC

series_invert_mod_natural_unit :: Monad m => SC.Series m Int
series_invert_mod_natural_unit = SC.series

series_invert_mod_word_unit :: Monad m => SC.Series m Int
series_invert_mod_word_unit = SC.series
