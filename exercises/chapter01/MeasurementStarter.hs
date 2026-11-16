-- Preparation and measurement experiments.
-- Run main for one supplied branch calculation. Complete biasedCoin,
-- coinExperiment and conditionalExperiment, reload, then run exercise.
-- This file does not depend on a completed earlier starter.
module MeasurementStarter where

import QPP.Syntax
import QPP.Semantics.Matrix
import QPP.PrettyPrint (printS)
import Data.Complex

epsilon :: Double
epsilon = 1e-9

closeProbability :: Double -> Double -> Bool
closeProbability x y = abs (x-y) < epsilon

-- Supplied versions of the main-text measurement utilities.
-- Inputs are normalised states and orthogonal projectors.
probOf :: OpT -> StateT -> Double
probOf p psi = realPart (inner psi (apply p psi))

collapse :: OpT -> StateT -> StateT
collapse p psi
  | branchNorm == 0 = error "collapse: impossible outcome"
  | otherwise = ((1 / branchNorm) :+ 0) .* branch
  where
    branch = apply p psi
    branchNorm = norm branch

projector :: StateT -> OpT
projector basisState = basisState ∘ adj basisState

plus, minus :: StateT
plus = normalize (ket [0] .+ ket [1])
minus = normalize (ket [0] .- ket [1])

computationalBasis, pmBasis :: [StateT]
computationalBasis = [ket [0],ket [1]]
pmBasis = [plus,minus]

computationalProjectors, pmProjectors :: [OpT]
computationalProjectors = map (measureProjection 1 0) [0,1]
pmProjectors = map projector pmBasis

-- For measuring the first qubit of a two-qubit register in a chosen basis.
firstQubitProjectors :: [StateT] -> [OpT]
firstQubitProjectors basis = [projector v ⊗ evalOp I | v <- basis]

outcomeProbabilities :: [OpT] -> StateT -> [Double]
outcomeProbabilities projectors psi = [probOf p psi | p <- projectors]

showBranch :: String -> OpT -> StateT -> IO ()
showBranch label p psi = do
  putStrLn ("Outcome " ++ label ++ ", probability:")
  print (probOf p psi)
  if norm (apply p psi) == 0
    then putStrLn "Impossible outcome"
    else do
      putStrLn "Normalised conditional register state:"
      printS (collapse p psi)

showBranches :: [String] -> [OpT] -> StateT -> IO ()
showBranches labels projectors psi =
  mapM_ (\(label,p) -> showBranch label p psi) (zip labels projectors)

biasedCoin :: Double -> StateT
biasedCoin p
  | isNaN p || isInfinite p || p < 0 || p > 1 =
      error "biasedCoin: p must be in [0,1]"
  | otherwise = error "TODO: prepare the state with one R Y rotation"
  -- Derive the angle first. R uses Rational multiples of pi;
  -- toRational converts a computed Double, not an exact symbolic angle.

coinExperiment :: [Double] -> IO ()
coinExperiment ps = do
  -- TODO: for each p, prepare a fresh state; report both basis distributions
  -- and check the computational probability of 0 with closeProbability.
  error "TODO: assemble the coin experiment"

entangledInput :: StateT
entangledInput = sqrt (1/3) .* ket [0,0] .+ sqrt (2/3) .* ket [1,1]

conditionalExperiment :: IO ()
conditionalExperiment = do
  -- TODO: measure qubit 0 of entangledInput in each of the two bases.
  -- Use firstQubitProjectors and showBranches to report every branch.
  -- showBranches takes outcome labels in the same order as the projectors.
  error "TODO: assemble the conditional-state experiment"

exercise :: IO ()
exercise = do
  coinExperiment [0,1/4,1/2,3/4,1]
  conditionalExperiment

main :: IO ()
main = do
  putStrLn "Supplied example: outcome 0 on input |0>"
  showBranch "0" (measureProjection 1 0 0) (ket [0])
  putStrLn "Complete the three TODOs, reload, then run exercise."
