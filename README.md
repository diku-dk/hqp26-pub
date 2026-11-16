# hqp26-pub
Hybrid Quantum Programming 2026/27 (Student Repository)

Write the course examples and exercise answers in this repository. The
Quantum Programming Playground (QPP) lives in a separate sibling folder:

```text
HQP/
  QPP/
  hqp26-pub/
    examples/              Chapter01.hs, Chapter02.hs and Appendix A examples
    exercises/
      chapter01/           Supplied starters and your answers
      chapter02/           Your Chapter 2 exercise answers
      ...
      chapter06/
```

Install Haskell and QPP as described in Appendix A of the lecture notes.
From the directory containing your `QPP/` checkout, obtain this repository:

```sh
git clone https://github.com/diku-dk/hqp26-pub.git
cd hqp26-pub
```

Open `hqp26-pub/` in VS Code. Install the recommended extensions when
prompted. The supplied settings and snippets provide the same Unicode
shortcuts as QPP: in a Haskell file, type `\circ`, `\otimes` or `\oplus`
and press Tab to insert `∘`, `⊗` or `⊕`. On Windows, open the folder in the
WSL window described in Appendix A.

Run this command from `hqp26-pub/` for all Haskell work:

```sh
cabal repl
```

Cabal finds QPP and the source folders above. The first start may take a
while to build dependencies. The session includes `random`, `containers`,
`hmatrix` and `QuickCheck`, as well as QPP.

## Files from the notes

Save chapter modules and Appendix A examples in `examples/`. For example,
create `examples/Chapter01.hs` with the first Chapter 1 listing, then load it:

```haskell
:load Chapter01
flipBit 0
```

The result should be `1`. Add the chapter's later definitions to the same
file. Keep earlier chapter files there so later chapters can import them.
Load Appendix A's modules by name too, for example `:load Increment`.

Load named modules without `.hs`. The course project lets GHCi find them
in the example and exercise folders without a directory path. A standalone program declared
as `module Main where` is loaded by filename instead: for example,
`:load examples/Hello.hs`, then `:main`.

After saving an edit, reload it with `:r`. `:load` switches to the named
module; definitions that you want to keep belong in source files.

## Exercises

Save your answers under the matching `exercises/chapterNN/` folder. Edit
a supplied starter in place. To see the first starter's example:

```haskell
:load ClassicalStarter
main
```

Complete its TODOs, save, reload with `:r`, and run the entry point named
in the problem. See [Chapter 1 starters](exercises/chapter01/README.md)
for all six files and their entry points.

For an exercise without a starter, create a uniquely named module in its
chapter's exercise folder; see [the exercise guide](exercises/README.md).
New modules can be loaded by name without editing the Cabal configuration.
