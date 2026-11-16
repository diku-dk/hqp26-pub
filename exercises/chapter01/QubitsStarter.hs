-- Normalisation and change of basis.
-- In the QPP GHCi session, load this file and run main.
-- Complete the three TODO expressions, reload, then run exercise.
module QubitsStarter where

import QPP.Syntax
import QPP.Semantics.Matrix
import QPP.PrettyPrint (printS)
import Data.Complex

mkState :: ComplexT -> ComplexT -> StateT
mkState a b = a .* ket [0] .+ b .* ket [1]

-- Constructed directly; no gate or measurement projector is needed here.
plus, minus :: StateT
plus  = mkState (1 / sqrt 2) (1 / sqrt 2)
minus = mkState (1 / sqrt 2) (-1 / sqrt 2)

realInput, complexInput :: StateT
realInput = mkState (sqrt (1/3)) (sqrt (2/3))
complexInput = mkState (sqrt (1/3)) (cis (pi/3) * sqrt (2/3))

normSquared :: StateT -> ComplexT
normSquared psi = error "TODO: use inner to compute the squared norm"

basisChange :: StateT -> (ComplexT, ComplexT)
basisChange psi =
  ( error "TODO: coordinate along plus"
  , error "TODO: coordinate along minus"
  )

squaredMagnitude :: ComplexT -> Double
squaredMagnitude z = magnitude z * magnitude z

showCoordinates :: StateT -> IO ()
showCoordinates psi = do
  let (a,b) = basisChange psi
  printS psi
  putStrLn "Coordinates in the plus/minus basis:"
  print (a,b)
  putStrLn "Their squared magnitudes, and the sum:"
  print (squaredMagnitude a, squaredMagnitude b)
  print (squaredMagnitude a + squaredMagnitude b)

exercise :: IO ()
exercise = do
  putStrLn "Squared norms: |0>, real input, complex input, |0>+|1>"
  print (map normSquared [ket [0], realInput, complexInput, mkState 1 1])
  mapM_ showCoordinates [realInput, complexInput]

main :: IO ()
main = do
  putStrLn "Supplied example: the state with a complex relative phase"
  printS complexInput
  putStrLn "Complete normSquared and basisChange, reload, then run exercise."
