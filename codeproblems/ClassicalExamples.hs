module ClassicalExamples where

import QPP.Syntax

-- In u >: v, u runs first.

-- Exchange two data bits when the leading bit is set.
controlledSwap :: QOp
controlledSwap = C (Permute [1,0])

-- With a clean carry bit, [a,b,0] becomes [a,sum,carry].
-- Toffoli records the carry before CNOT replaces b by the sum.
halfAdder :: QOp
halfAdder = C (C X) >: (C X ⊗ Id 1)

-- Convert three-bit binary to reflected Gray code.
-- Use the original middle bit before changing it.
binaryToGray :: QOp
binaryToGray = (Id 1 ⊗ C X) >: (C X ⊗ Id 1)

-- Rotate a three-bit word left when the selector is 0, right when it is 1.
rotateWord :: QOp
rotateWord = left ⊕ Adjoint left
  where left = Permute [1,2,0]

-- Add one modulo eight to a three-bit word, most significant bit first.
-- Put the low bits first to use them as controls. Apply the carries
-- before changing those control bits, then restore the wire order.
increment3 :: QOp
increment3 = reverseWires >: C (C X) >: (C X ⊗ Id 1)
                         >: (X ⊗ Id 2) >: reverseWires
  where reverseWires = Permute [2,1,0]
