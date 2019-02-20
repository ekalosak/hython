# hython
[![CircleCI](https://circleci.com/gh/ekalosak/hython/tree/master.svg?style=svg&circle-token=68ad6fb98de4ff6b4b8cadb9398f282049cf5c4d)](https://circleci.com/gh/ekalosak/hython/tree/master)
Various "hello world" level examples for wrapping python code in haskell.

## setup
0. install python3.4, ghc (glassgow haskell compiler), pkg-config,
  and stack (pip for ghc)
1. `stack run`

`find / -name 'python-3.4.pc' -print` and export that as `PKG_CONFIG_PATH` in
your `~/.zshrc` (e.g. `export PKG_CONFIG_PATH=/Library/Frameworks/Python.framework/Versions/3.4/lib/pkgconfig`)
This allows the `cpython` binding in the haskell program to access the
`pkg-config` declaration of the `python-3.4` requirement.
Also `export PYTHONPATH=$(pwd)/src`

## entry point
When you run `stack build`, the source in `app/Main.hs` is compiled as declared
in the `package.yaml`; look at `app/Main.hs` first. Then, glance over
`src/Lib.hs` - that's where the de-serialization of python output takes place.

## testing
Run `stack test`, and see `test/Spec.hs` for details.
