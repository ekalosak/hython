# hython
Various "hello world" level examples for wrapping python code in haskell.

## setup
0. install python3, ghc (glassgow haskell compiler), and stack (pip for ghc)
1. `stack run`

## entry point
When you run `stack build`, the source in `app/Main.hs` is compiled as declared
in the `package.yaml`; look at `app/Main.hs` first. Then, glance over
`src/Lib.hs` - that's where the de-serialization of python output takes place.

## testing
Run `stack test`, and see `test/Spec.hs` for details.
