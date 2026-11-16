# Chapter 1 programming exercises

These files accompany the programming problems at the end of Chapter 1.
Each file supplies a runnable `main` and marked `TODO` expressions to
complete. The files are independent. Edit their TODOs here; save other Chapter 1
answers in this folder too.

Clone the course repository into `hqp26-pub/` beside your QPP checkout:

```text
your-working-directory/
  QPP/
  hqp26-pub/
    exercises/chapter01/
```

From `hqp26-pub/`, start GHCi:

```sh
cabal repl
```

Load the module name from the problem without the `.hs` extension. For example:

```haskell
:load ClassicalStarter
main
```

After editing its TODOs, save the file, reload with `:r`, and run the entry
point in the last column:

| File | Topic | After completing the TODOs |
|---|---|---|
| `ClassicalStarter.hs` | Classical matrix columns | `exercise` |
| `QubitsStarter.hs` | Normalization and basis coordinates | `exercise` |
| `QubitsStarter2.hs` | Global phase | `exercise` |
| `TensorProductsStarter.hs` | Local gates and GHZ preparation | `exercise` |
| `PauliBlochStarter.hs` | Pauli gates and rotations | `investigate` |
| `MeasurementStarter.hs` | Probabilities and conditional states | `exercise` |

The measurement exercise uses optional Section 1.6. Appendix A's IO section
explains how to assemble the actions in the final two starters.
