module Main where

import Etna.Result    (PropertyResult(..))
import Etna.Witnesses
import System.Exit    (exitFailure, exitSuccess)

main :: IO ()
main = do
  let cases =
        [ ("witness_invert_mod_natural_unit_case_zero",  witness_invert_mod_natural_unit_case_zero)
        , ("witness_invert_mod_natural_unit_case_seven", witness_invert_mod_natural_unit_case_seven)
        , ("witness_invert_mod_word_unit_case_zero",     witness_invert_mod_word_unit_case_zero)
        , ("witness_invert_mod_word_unit_case_seven",    witness_invert_mod_word_unit_case_seven)
        ]
  let failures =
        [ (n, msg)        | (n, Fail msg) <- cases ] ++
        [ (n, "discard")  | (n, Discard)  <- cases ]
  if null failures
    then exitSuccess
    else do
      mapM_ (\(n, m) -> putStrLn (n ++ ": " ++ m)) failures
      exitFailure
