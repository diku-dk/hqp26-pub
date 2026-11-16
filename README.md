# hqp26-pub
Hybrid Quantum Programming 2026/27 (Student Repository)

Programming exercises use the Quantum Programming Playground (QPP).

Install QPP as described in Appendix A of the lecture notes. From the
directory containing your `QPP/` checkout, obtain the exercises and start
GHCi:

```sh
git clone https://github.com/diku-dk/hqp26-pub.git
cd hqp26-pub
cabal repl
```

Load the starter named in a problem, without its `.hs` extension, and run
its supplied example:

```haskell
:load ClassicalStarter
main
```

Edit the TODOs in `exercises/chapter01/ClassicalStarter.hs`, save, reload
with `:r`, and run the entry point named in the problem.

See [Chapter 1 programming exercises](exercises/chapter01/README.md) for
all six starter files and their entry points.
