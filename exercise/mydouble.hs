-- ghci 에서 아래 처럼 사용함
{-
:load MyDoubleMod
doDouble 7
14
-}

-- module Main where <- 이건 뭘까?

doDouble :: Integer -> Integer -- 인수의 자료형과 리턴값의 자료형 정의
doDouble x = x + x
{- ghci 에서 아래처럼 선언할 수도 있다.
	let double x = x + x
-}

myFunc7 :: Integer -> Integer
myFunc7 x = 1024

fact2 :: Integer -> Integer
fact2 0 = 1
fact2 x = x * fact2(x - 1)
{- ghci
	let fact x = if x == 0 then 1 else fact(x - 1) * x
-}

-- 가드 사용
fact3 :: Integer -> Integer
fact3 x
    | x > 1 = x * fact2(x - 1)
    | otherwise = 1

fib2 :: Integer -> Integer
fib2 0 = 0
fib2 1 = 1
fib2 x = fib2(x-1) + fib2(x-2)

fibTuple :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
fibTuple (x, y, 0) = (x, y, 0)
fibTuple (x, y, index) = fibTuple(y, x + y, index - 1)

fibResult :: (Integer, Integer, Integer) -> Integer
fibResult (x, y, z) = x

fib3 :: Integer -> Integer
fib3 x = fibResult (fibTuple (0,1,x))

fibNextPair :: (Integer, Integer) -> (Integer, Integer)
fibNextPair (x, y) = (y, x + y)

fibNthPair :: Integer -> (Integer, Integer)
fibNthPair 1 = (1, 1)
fibNthPair n = fibNextPair(fibNthPair(n - 1))

--fib4 :: Integer -> Integer
--fib4 x = fst . fibNthPair(x)
fib4 :: Integer -> Integer
fib4 = fst . fibNthPair
-- fib4 x = fst(fibNthPair(x)) -- 윗줄과 같은 의미



