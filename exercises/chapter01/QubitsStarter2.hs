-- Global phase is unobservable -- numerically.
-- This file is independent of QubitsStarter.hs.
-- Run main, complete the TODO, reload, then run exercise.
module QubitsStarter2 where

import QPP.Syntax
import QPP.Semantics.Matrix
import QPP.PrettyPrint (printS)
import Data.Complex

plus, minus, inputState :: StateT
plus = normalize (ket [0] .+ ket [1])
minus = normalize (ket [0] .- ket [1])
inputState = sqrt (1/3) .* ket [0] .+ sqrt (2/3) .* ket [1]

-- alpha is measured in radians. Data.Complex supplies cis alpha = exp(i*alpha).
applyGlobalPhase :: Double -> StateT -> StateT
applyGlobalPhase alpha psi = error "TODO: multiply psi by the phase using (.*)"

-- Supplied basis-coordinate and probability utilities.
basisCoordinates :: [StateT] -> StateT -> [ComplexT]
basisCoordinates basis psi = [inner b psi | b <- basis]

probabilities :: [StateT] -> StateT -> [Double]
probabilities basis psi =
  [magnitude a * magnitude a | a <- basisCoordinates basis psi]

closeProbabilities :: [Double] -> [Double] -> Bool
closeProbabilities xs ys = length xs == length ys &&
  and (zipWith (\x y -> abs (x-y) < 1e-9) xs ys)

comparePhase :: Double -> IO ()
comparePhase alpha = do
  let changed = applyGlobalPhase alpha inputState
  putStrLn ("Phase in radians: " ++ show alpha)
  putStrLn "States before and after:"
  printS inputState
  printS changed
  mapM_ (compareBasis changed)
    [("Computational basis", [ket [0], ket [1]]),
     ("Plus/minus basis", [plus, minus])]
  where
    compareBasis changed (name,basis) = do
      let before = probabilities basis inputState
          after = probabilities basis changed
      putStrLn name
      print (before,after)
      putStrLn "Probabilities agree within tolerance:"
      print (closeProbabilities before after)

exercise :: IO ()
exercise = mapM_ comparePhase [0, pi/3]

main :: IO ()
main = do
  putStrLn "Supplied example: probabilities of |0> in the plus/minus basis"
  print (probabilities [plus,minus] (ket [0]))
  putStrLn "Complete applyGlobalPhase, reload, then run exercise."
  putStrLn "Use comparePhase with additional phases of your choice."
