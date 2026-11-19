module Main where

import QPP
import QPP.Semantics.Matrix
import QPP.PrettyPrint
import Data.Complex (realPart)

-- A classical description of a one-qubit state.
-- The caller supplies amplitudes satisfying |a|^2 + |b|^2 = 1.
state1q :: ComplexT -> ComplexT -> StateT
state1q a b = (a .* ket [0]) .+ (b .* ket [1])

-- Desired output, constructed from a known vector of amplitudes.
-- This Haskell function is not a unitary operation on an unknown qubit.
quantum_cloned_state :: StateT -> StateT
quantum_cloned_state psi = psi ⊗ psi

-- A physical candidate: apply CNOT to the input and a blank target.
cx_cloned_state :: StateT -> StateT
cx_cloned_state psi = apply (evalOp (C X)) (psi ⊗ ket [0])

-- Probability of the specified outcome on qubit 1 in a two-qubit state.
-- measureProjection takes the register width, qubit index and outcome.
secondProbability :: Bit -> StateT -> Double
secondProbability outcome s =
  realPart (inner s (apply (measureProjection 2 1 outcome) s))

-- P(qubit 0 = 0 | qubit 1 = 0).
-- Projection gives an unnormalised vector; normalise only if the
-- conditioning outcome has nonzero probability.
conditionalZero :: StateT -> Maybe Double
conditionalZero s
  | secondProbability 0 s <= 0 = Nothing
  | otherwise =
      let projected = apply (measureProjection 2 1 0) s
          remaining = normalize projected
      in Just (realPart (inner remaining
                          (apply (measureProjection 2 0 0) remaining)))

report :: String -> StateT -> IO ()
report label psi = do
  putStrLn ("\nInput: " ++ label)
  let desired = quantum_cloned_state psi
      actual  = cx_cloned_state psi
  putStrLn "Desired output psi tensor psi:"
  printS desired
  putStrLn "CNOT output:"
  printS actual
  putStrLn "P(qubit 1 = 0), P(qubit 1 = 1), desired then CNOT:"
  print (secondProbability 0 desired, secondProbability 1 desired)
  print (secondProbability 0 actual, secondProbability 1 actual)
  putStrLn "P(qubit 0 = 0 | qubit 1 = 0), desired then CNOT:"
  print (conditionalZero desired)
  print (conditionalZero actual)

main :: IO ()
main = do
  report "ket 0" (ket [0])
  report "ket 1" (ket [1])
  report "(ket 0 + ket 1)/sqrt 2"
         (state1q (1 / sqrt 2) (1 / sqrt 2))
  report "(ket 0 + sqrt 3 * ket 1)/2"
         (state1q (1/2) (sqrt 3 / 2))

-- Exercise: predict the outputs before running the file. Then change
-- the amplitudes and explain the difference using linearity.
