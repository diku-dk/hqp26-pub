-- Tensor products and gate composition.
-- Run main for the supplied Bell preparation. Complete the TODOs,
-- reload, then run exercise. No other starter file is required.
module TensorProductsStarter where

import QPP.Syntax
import QPP.Semantics.Matrix
import QPP.PrettyPrint (printS)
import qualified Numeric.LinearAlgebra as LA

productState :: StateT -> StateT -> StateT
productState = (⊗)

plus :: StateT
plus = normalize (ket [0] .+ ket [1])

-- The Bell preparation already developed in the main text.
bellOp :: QOp
bellOp = C X ∘ (H ⊗ I)

bellState :: StateT
bellState = apply (evalOp bellOp) (ket [0,0])

-- Qubit 0 is the left-hand qubit.
applyOnQubit0, applyOnQubit1 :: QOp -> StateT -> StateT
applyOnQubit0 u psi = error "TODO: apply u to qubit 0 and I to qubit 1"
applyOnQubit1 u psi = error "TODO: apply I to qubit 0 and u to qubit 1"

ghzOp :: QOp
ghzOp = error "TODO: translate your three-qubit GHZ gate sequence"

-- This comparison retains the global phase.
closeState :: StateT -> StateT -> Bool
closeState a b = LA.size a == LA.size b && norm (a .- b) < 1e-9

showLocalComparison :: StateT -> IO ()
showLocalComparison psi = do
  let left = applyOnQubit0 X psi
      right = applyOnQubit1 X psi
  putStrLn "Input, then X applied to qubit 0, then X applied to qubit 1:"
  mapM_ printS [psi,left,right]
  putStrLn "The two outputs agree within tolerance:"
  print (closeState left right)

exercise :: IO ()
exercise = do
  mapM_ showLocalComparison [bellState,ket [0,0]]
  let prepared = apply (evalOp ghzOp) (ket [0,0,0])
      target = normalize (ket [0,0,0] .+ ket [1,1,1])
  putStrLn "Prepared three-qubit state:"
  printS prepared
  putStrLn "Agreement with the target amplitudes:"
  print (closeState prepared target)

main :: IO ()
main = do
  putStrLn "Supplied examples: |+> tensor |+>, and the Bell state"
  printS (productState plus plus)
  printS bellState
  putStrLn "Complete the local applications and ghzOp, reload, then run exercise."
