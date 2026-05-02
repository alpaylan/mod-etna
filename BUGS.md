# mod — Injected Bugs

Fast type-safe modular arithmetic (Bodigrim/mod). Bug fixes mined from upstream history; modern HEAD is the base, each patch reverse-applies a fix to install the original bug.

Total mutations: 1

## Bug Index

| # | Variant | Name | Location | Injection | Fix Commit |
|---|---------|------|----------|-----------|------------|
| 1 | `invert_mod_unit_86672749_1` | `invertMod_returns_Nothing_for_unit_modulus` | `Data/Mod.hs:354` (`invertModInternal`), `Data/Mod/Word.hs:337` (`invertMod`) | `patch` | `86672749346f8b604972cdc8e69df2e25bcc593f` |

## Property Mapping

| Variant | Property | Witness(es) |
|---------|----------|-------------|
| `invert_mod_unit_86672749_1` | `InvertModNaturalUnit` | `witness_invert_mod_natural_unit_case_zero`, `witness_invert_mod_natural_unit_case_seven` |
| `invert_mod_unit_86672749_1` | `InvertModWordUnit`    | `witness_invert_mod_word_unit_case_zero`, `witness_invert_mod_word_unit_case_seven` |

## Framework Coverage

| Property | quickcheck | hedgehog | falsify | smallcheck |
|----------|---------:|-------:|------:|---------:|
| `InvertModNaturalUnit` | ✓ | ✓ | ✓ | ✓ |
| `InvertModWordUnit`    | ✓ | ✓ | ✓ | ✓ |

## Bug Details

### 1. invertMod_returns_Nothing_for_unit_modulus

- **Variant**: `invert_mod_unit_86672749_1`
- **Location**: `Data/Mod.hs:354` (inside `invertModInternal`), `Data/Mod/Word.hs:337` (inside `invertMod`)
- **Properties**: `InvertModNaturalUnit`, `InvertModWordUnit`
- **Witness(es)**:
  - `witness_invert_mod_natural_unit_case_zero` — Data.Mod.invertMod (0 :: Mod 1) must equal Just 0
  - `witness_invert_mod_natural_unit_case_seven` — Data.Mod.invertMod (7 :: Mod 1) must equal Just 0 (7 reduces to 0 mod 1)
  - `witness_invert_mod_word_unit_case_zero` — Data.Mod.Word.invertMod (0 :: Mod 1) must equal Just 0
  - `witness_invert_mod_word_unit_case_seven` — Data.Mod.Word.invertMod (7 :: Mod 1) must equal Just 0 (7 reduces to 0 mod 1)
- **Source**: internal — Fix invertMod (0 :: Mod 1)
  > invertMod for the unit modulus (Mod 1) used to fall through to integerRecipMod#/invertModWordOdd, both of which return Nothing for x = 0. But Mod 1 has 0 as its only inhabitant and gcd(0, 1) = 1, so invertMod must return Just 0. The fix adds a special case for modulus 1 in both Data.Mod.invertModInternal and Data.Mod.Word.invertMod. See https://gitlab.haskell.org/ghc/ghc/-/issues/26017.
- **Fix commit**: `86672749346f8b604972cdc8e69df2e25bcc593f` — Fix invertMod (0 :: Mod 1)
- **Invariant violated**: For every x :: Mod 1 the call invertMod x must return Just y with x * y == fromInteger 1 (which equals 0 in Mod 1). The same holds for the Word-backed variant Data.Mod.Word.invertMod.
- **How the mutation triggers**: Reverse-applying the patch removes the explicit Mod 1 fallback in both Data.Mod.invertModInternal and Data.Mod.Word.invertMod. Calling invertMod (0 :: Mod 1) or Word.invertMod (0 :: Word.Mod 1) then returns Nothing instead of Just 0, violating the modular-inverse contract for the unit modulus.
