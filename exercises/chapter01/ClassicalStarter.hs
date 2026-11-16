-- Building the columns of a classical program.
-- Load this file in GHCi and run main for a supplied example.
-- Complete the TODO, reload with :r, then run exercise.
module ClassicalStarter where

import QPP.Bit (Bit)

type BitPair = (Bit, Bit)

bits2 :: [BitPair]
bits2 = [(a,b) | a <- [0,1], b <- [0,1]]

-- A column with a 1 at the position of the given bit pair.
basisColumn :: BitPair -> [Int]
basisColumn output = [if row == output then 1 else 0 | row <- bits2]

xorUpdate, resetUpdate :: BitPair -> BitPair
xorUpdate (a,b) = (if a == b then 0 else 1, b)
resetUpdate (a,_) = (a,0)

-- Each x is an input. Replace the error expression using f, x,
-- and basisColumn. The result is a list of columns, not rows.
columns :: (BitPair -> BitPair) -> [[Int]]
columns f = [error "TODO: construct the column for input x" | x <- bits2]

printColumns :: (BitPair -> BitPair) -> IO ()
printColumns f = mapM_ print (zip bits2 (columns f))

exercise :: IO ()
exercise = do
  putStrLn "XOR update: (input, output column)"
  printColumns xorUpdate
  putStrLn "Reset update: (input, output column)"
  printColumns resetUpdate

main :: IO ()
main = do
  putStrLn "Basis order:"
  print bits2
  putStrLn "Supplied example: the column for output (0,1)"
  print (basisColumn (0,1))
  putStrLn "Complete columns, reload, then run exercise."
