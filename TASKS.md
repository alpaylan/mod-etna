# mod — ETNA Tasks

Total tasks: 8

## Task Index

| Task | Variant | Framework | Property | Witness |
|------|---------|-----------|----------|---------|
| 001 | `invert_mod_unit_86672749_1` | quickcheck | `InvertModNaturalUnit` | `witness_invert_mod_natural_unit_case_zero` |
| 002 | `invert_mod_unit_86672749_1` | hedgehog   | `InvertModNaturalUnit` | `witness_invert_mod_natural_unit_case_zero` |
| 003 | `invert_mod_unit_86672749_1` | falsify    | `InvertModNaturalUnit` | `witness_invert_mod_natural_unit_case_zero` |
| 004 | `invert_mod_unit_86672749_1` | smallcheck | `InvertModNaturalUnit` | `witness_invert_mod_natural_unit_case_zero` |
| 005 | `invert_mod_unit_86672749_1` | quickcheck | `InvertModWordUnit`    | `witness_invert_mod_word_unit_case_zero` |
| 006 | `invert_mod_unit_86672749_1` | hedgehog   | `InvertModWordUnit`    | `witness_invert_mod_word_unit_case_zero` |
| 007 | `invert_mod_unit_86672749_1` | falsify    | `InvertModWordUnit`    | `witness_invert_mod_word_unit_case_zero` |
| 008 | `invert_mod_unit_86672749_1` | smallcheck | `InvertModWordUnit`    | `witness_invert_mod_word_unit_case_zero` |

## Witness Catalog

- `witness_invert_mod_natural_unit_case_zero` — Data.Mod.invertMod (0 :: Mod 1) must equal Just 0
- `witness_invert_mod_natural_unit_case_seven` — Data.Mod.invertMod (7 :: Mod 1) must equal Just 0 (7 reduces to 0 mod 1)
- `witness_invert_mod_word_unit_case_zero` — Data.Mod.Word.invertMod (0 :: Mod 1) must equal Just 0
- `witness_invert_mod_word_unit_case_seven` — Data.Mod.Word.invertMod (7 :: Mod 1) must equal Just 0 (7 reduces to 0 mod 1)
