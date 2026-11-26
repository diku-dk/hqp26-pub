module RunClassicalProblem where

import QPP.Syntax
import Chapter02 (tensorPower)
import Chapter03
import ClassicalExamples

-- For a well-typed op accepted by isClassical, bits is a basis input of
-- length arity op. Return the output basis bits, with qubit 0 first.
-- Work directly on the bits.
runClassical :: QOp -> [Bit] -> [Bit]
runClassical op bits = case op of
  Id _ -> bits
  X -> case bits of
    [b] -> [1 - b]
    _   -> error "runClassical: invalid NOT input"
  Permute ks -> [bits !! k | k <- ks]
  Adjoint u -> runClassical (invert u) bits
  -- If you skipped the inverse exercise, replace the Adjoint case above with
  -- Adjoint u -> runClassical (dagger u) bits
  -- On accepted operands dagger rebuilds each node or removes an adjoint.
  -- Its result is therefore smaller than the enclosing Adjoint u.

  -- The list pattern c : rest separates the leading bit from the tail.
  C u -> case bits of
    c : rest -> undefined
    []       -> error "runClassical: missing control bit"
  DirectSum u v -> case bits of
    c : rest -> undefined
    []       -> error "runClassical: missing selector bit"
  -- splitAt (arity u) bits returns the two input lists. (++) joins lists.
  Tensor u v    -> undefined
  Compose u v   -> undefined
  _             -> error "runClassical: non-classical constructor"
