# hython
Various "hello world" level examples for wrapping python code in haskell.
"Batteries included" python-haskell integration.

## purpose
Haskell needs to do away with its fixation on being difficult. To do so, we need
to dovetail Haskell products into peoples' existing workflows in a "batteries
included" way: by providing python integration.

### So far
1. Supports piping serialized as json using shell-conduit out of the box.
2. Supports python bindings through the common C Foreign Function Interface via
cpython.

### Todo
1. Immediately, needs a comprehensive dockerfile for explicit instructions on
   finessing the python environment - those instructions are currently roughly
   available in the `setup` section below.
2. Support for quickcheck etc. on bound python modules
3. Type inference for python functions (leveraging GHC rather than python 3rd
   party)

## caveat
Setting up the python environment for this project is, as most python
environments admittedly are, a bear. There's some explicit versioning and
pkg-config munging to be done.

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
[![CircleCI](https://circleci.com/gh/ekalosak/hython/tree/master.svg?style=svg&circle-token=68ad6fb98de4ff6b4b8cadb9398f282049cf5c4d)](https://circleci.com/gh/ekalosak/hython/tree/master)

Run `stack test`, and see `test/Spec.hs` for details.
