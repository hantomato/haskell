
module Book4Module where

import Data.Bits

nats :: [Integer]
nats = 0 : map (+1) nats



queens :: Int -> [[Int]]
queens n = filter test (generate n)
    where generate 0      = [[]]
          generate k      = [q : qs | q <- [1..n], qs <- generate (k-1)]
          test []         = True
          test (q:qs)     = isSafe q qs && test qs
          isSafe   try qs = not (try `elem` qs || sameDiag try qs)
          sameDiag try qs = any (\(colDist,q) -> abs (try - q) == colDist) $ zip [1..] qs


queens2 :: Int -> [[Int]]
queens2 n = map reverse $ queens' n
    where queens' 0       = [[]]
          queens' k       = [q:qs | qs <- queens' (k-1), q <- [1..n], isSafe q qs]
          isSafe   try qs = not (try `elem` qs || sameDiag try qs)
          sameDiag try qs = any (\(colDist,q) -> abs (try - q) == colDist) $ zip [1..] qs          


kmkm :: Int -> Int
kmkm n = (.|.) 18 10