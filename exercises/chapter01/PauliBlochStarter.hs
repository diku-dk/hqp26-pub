-- Pauli algebra and Bloch-vector experiments.
-- Run main for supplied examples. Complete the TODOs and assemble
-- investigate from the tools below. No other starter file is required.
module PauliBlochStarter where

import QPP.Syntax
import QPP.Semantics.Matrix
import QPP.PrettyPrint (printS, printM)
import Data.Complex
import qualified Numeric.LinearAlgebra as LA

epsilon :: Double
epsilon = 1e-9

plus, minus, plusI :: StateT
plus = normalize (ket [0] .+ ket [1])
minus = normalize (ket [0] .- ket [1])
plusI = normalize (ket [0] .+ ((0 :+ 1) .* ket [1]))

closeState :: StateT -> StateT -> Bool
closeState a b = LA.size a == LA.size b && norm (a .- b) < epsilon

-- Equal up to a global phase, for normalised states of equal size.
sameState :: StateT -> StateT -> Bool
sameState a b = LA.size a == LA.size b &&
  abs (norm a - 1) < epsilon && abs (norm b - 1) < epsilon &&
  abs (magnitude (inner a b) - 1) < epsilon

-- Complete matrix comparison, retaining phases.
closeMatrix :: OpT -> OpT -> Bool
closeMatrix a b = LA.size a == LA.size b && norm (a .- b) < epsilon

-- The Bloch-coordinate calculation from the main text is supplied.
pauliCoordinate :: QOp -> StateT -> Double
pauliCoordinate op psi =
  let value = inner psi (apply (evalOp op) psi)
  in if abs (imagPart value) < epsilon then realPart value
     else error "pauliCoordinate: unexpectedly non-real coordinate"

blochVector :: StateT -> (Double,Double,Double)
blochVector psi =
  (pauliCoordinate X psi, pauliCoordinate Y psi, pauliCoordinate Z psi)

-- Return one row (gate, exact-amplitude check, check up to phase)
-- for each of X, Y, Z applied twice to psi.
pauliChecks :: StateT -> [(QOp,Bool,Bool)]
pauliChecks psi = error "TODO: combine application and the two state comparisons"

-- Return (angle, resulting Bloch vector) for each angle in ts.
-- axis is X, Y, or Z; angles are Rational multiples of pi.
rotationRows :: QOp -> StateT -> [Rational] -> [(Rational,(Double,Double,Double))]
rotationRows axis psi ts = error "TODO: construct and apply each rotation"

hadamardFromRotation :: QOp
hadamardFromRotation = error "TODO: combine Phase with a rotation about H"

-- Supplied printing and verification tools.
printPauliChecks :: StateT -> IO ()
printPauliChecks psi = mapM_ print (pauliChecks psi)

printRotationRows :: QOp -> StateT -> [Rational] -> IO ()
printRotationRows axis psi ts = mapM_ print (rotationRows axis psi ts)

checkHadamard :: IO ()
checkHadamard = do
  let candidate = evalOp hadamardFromRotation
  putStrLn "Candidate matrix, then the Hadamard matrix:"
  printM candidate
  printM (evalOp H)
  putStrLn "Complete matrices agree within tolerance:"
  print (closeMatrix candidate (evalOp H))

investigate :: IO ()
investigate = do
  -- TODO: assemble the experiments requested in the problem.
  -- Use the printing tools above; choose an extra axis or input yourself.
  -- A sequence of IO commands belongs on separate indented lines here.
  error "TODO: assemble investigate"

main :: IO ()
main = do
  putStrLn "Supplied example: apply X to |0>"
  printS (apply (evalOp X) (ket [0]))
  putStrLn "Supplied example: Bloch coordinates of |+>"
  print (blochVector plus)
  putStrLn "Complete the TODOs, reload, then run investigate."
