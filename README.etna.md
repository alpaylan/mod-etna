# mod — ETNA workload

Upstream: <https://github.com/Bodigrim/mod> (fast type-safe modular arithmetic).

This workload mines the upstream git history for correctness fixes and packages each as a `(property, generator-per-framework, witness, patch)` tuple. The base tree is the upstream's `master` HEAD; reverse-applying a patch installs the original bug.

## Build

```sh
ghcup install ghc 9.6.6   # if not already present
cabal build all           # builds upstream lib (with -fvector=false) and the etna runner
```

The `cabal.project` here pins GHC 9.6.6 (Falsify ≥ 0.2 requires `base ≥ 4.18`) and disables the upstream `vector` flag — `mod`'s `Storable`/`Prim`/`Unbox` instances are not exercised by the variants in this workload, so dropping them keeps the dependency closure small. The `semirings` flag is left enabled by default so the upstream `Mod` newtype retains its `Semiring`/`Ring`/`GcdDomain`/`Euclidean` instances.

## Run

From inside `etna/`:

```sh
cabal run etna-runner -- <tool> <Property>
```

`<tool>` is one of `etna` (witness replay), `quickcheck`, `hedgehog`, `falsify`, `smallcheck`. `<Property>` is one of the PascalCase names listed in `etna.toml` (or `All` to run every property under that tool). The runner emits a single JSON line on stdout per invocation and exits 0 except on argv-parse error.

## Witness sanity

```sh
cabal test etna-witnesses
```

On the base tree this passes for every witness. With any `patches/<variant>.patch` reverse-applied, every witness for that variant fails.

## Variants

See `BUGS.md` and `TASKS.md` (both generated from `etna.toml`).

Source-touching commits in upstream that were not turned into variants are summarised below. The history of `mod` is dominated by CI/build/warning fixes; the only behavioural-correctness fix that is expressible in a pure property is the `Mod 1` `invertMod` bug. Other near-misses:

- `Workaround several conditions in invertModWordOdd` (`7d35366a`) — the diff replaces branchful with branchless code; the two formulations are observably equivalent modulo the modulus, so reverse-applying the patch produces no PBT-detectable behavioural difference.
- `Fix loopholes to inhabit Mod 0` (`4f907d36`) — the fix makes `minBound`/`zero` for `Mod 0` throw `DivideByZero`. Distinguishing thrown exceptions from returned values requires `IO`/`unsafePerformIO`, which the property contract forbids.
- `Workaround for GHC 9.0 bug in fromIntegral` (`15f121c2`) — only triggers under GHC 9.0.1; on the pinned GHC 9.6.6 toolchain reverse-applying the patch is a no-op.
- `Remove (^) -> (^%) rewrite rule, it does not fire` (`6c5ce8f5`) — the upstream's own commit message documents that the rewrite never fires; reverse-applying restores a dead rule with no observable behaviour.
- `Define Fractional instances unconditionally` (`b1249ad3`), `Bring instance GcdDomain to match ideals in the ring` (`de9ef6aa`), `Redesign GcdDomain and Euclidean operations` (`301f911d`) — express bugs only when the upstream `semirings` flag is enabled and would require pulling additional structure (Set-based ideal computations) into the property to detect.

## GHC pin

`cabal.project` pins `with-compiler: /Users/akeles/.ghcup/ghc/9.6.6/bin/ghc`. Adjust this line to the local `ghcup whereis ghc 9.6.6` output if running from another machine.
