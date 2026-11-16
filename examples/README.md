# Examples from the notes

Save both the chapter modules (`Chapter01.hs`, `Chapter02.hs`, and so on)
and Appendix A's examples in this folder. Create each chapter module from
its opening listing, then append the chapter's later definitions to the
same file. Earlier chapter modules remain available for later ones to
import.

From the repository root, start `cabal repl` and load a module by name,
for example `:load Chapter01` or `:load Increment`. For the appendix's
`Increment` example, `increment 4` should return `5`. Save changes and
reload with `:r`.

The complete program `Hello.hs` declares `module Main where`, so load it
by filename: `:load examples/Hello.hs`, then `:main`. To run it directly
from a terminal in this `examples/` folder, use `runghc Hello.hs`.
