# Exercise answers

Use the folder matching the problem's chapter: `chapter01/` through
`chapter06/`. Supplied starters go in the same folder as your other
answers; edit their TODOs in place.

For a Haskell problem without a starter, create a file with a unique
module name. For example, for Chapter 2, Problem 1, create
`chapter02/Exercise02_01.hs` and begin it with:

```haskell
module Exercise02_01 where

import QPP
import QPP.Semantics.Matrix
```

Add your definitions, save, and load them from a `cabal repl` session
started at the repository root:

```haskell
:load Exercise02_01
```

Use `:r` after saving further changes. All six chapter folders are already
on the module search path; you do not need to edit the Cabal configuration.
Use distinct module names for different answers so GHCi can find each one.
Written answers can live beside the code in the corresponding folder.
