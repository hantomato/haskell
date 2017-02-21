-- 연습문제 풀이

{-
    문제는 아래 사이트에서 8문제를 뽑고, 탑코더에서 한문제 뽑았습니다.
    https://wiki.haskell.org/99_questions

    정답이 나와있기때문에, 문제를 다 푸는게 중요한게 아니라, 풀이 과정을 설명할 수 있어야 함.
-}

----------------------------------------
----- 기초 문제

-- 1번. (99 questions 의 1번 문제를 말함)
{-
(*) Find the last element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

Prelude> myLast [1,2,3,4]
4
Prelude> myLast ['x','y','z']
'z'
-}

ex1 :: [a] -> a
ex1 [] = error "empty list!!"
ex1 [x] = x
ex1 (_:xs) = ex1 xs


-- 2번.
{-
(*) Find the last but one element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

Prelude> myButLast [1,2,3,4]
3
Prelude> myButLast ['a'..'z']
'y'
-}
ex2 :: [a] -> a
ex2 xs = (reverse xs) !! 1

ex2' :: [a] -> a
ex2' (x:xs) = 
            if length xs == 1 
                then x 
            else ex2' xs

ex2'' :: [a] -> a
ex2'' = head . tail . reverse

ex2''' :: [a] -> a
ex2''' = last . init -- init은 리스트의 마지막 원소 뺀 것의 리스트 리턴

ex2'''' :: [a] -> a
ex2'''' (x:_:[]) = x
ex2'''' x = ex2'''' (tail x)

-- 5번.
{-
(*) Reverse a list.

Example in Haskell:

Prelude> myReverse "A man, a plan, a canal, panama!"
"!amanap ,lanac a ,nalp a ,nam A"
Prelude> myReverse [1,2,3,4]
[4,3,2,1]
-}
ex5 :: [a] -> [a]
ex5 []     = []
ex5 (x:xs)  = (ex5 xs) ++ [x]

ex5' :: [a] -> [a]
ex5' []     = []
ex5' x      = ex5' (tail x) ++ [head x]

ex5'' :: [a] -> [a]
ex5'' x = foldl (\empty item -> item : empty) [] x


-- foldl, foldr 자꾸 헤깔림.
-- 헤깔리면.. 아래서 b를 찾아라. 그게 초기값이다.
-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- foldl 은 두번째가, foldr 은 첫번째가 원소임.
------------------------------------------
-- foldr 은 리스트 오른쪽 부터 하나씩 꺼낸다!!!!!
-- ex.
-- *Main> foldr (\a b -> a : b) [] [1,2,3]
-- [1,2,3]
------------------------------------------
------------------------------------------
------------------------------------------


-- 6번.
{-
(*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).

Example in Haskell:

*Main> isPalindrome [1,2,3]
False
*Main> isPalindrome "madamimadam"
True
*Main> isPalindrome [1,2,4,8,16,8,4,2,1]
True
-}
ex6 :: Eq a => [a] -> Bool
ex6 x = foldl (\b a -> b && a) True 
            (zipWith (\x y -> x == y) x (reverse x))

-- 10번.
{-
(*) Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.

Example:

* (encode '(a a a a b c c a a d e e e e))
((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
Example in Haskell:

encode "aaaabccaadeeee"
[(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
-}
ex10 :: String -> [(Int,Char)]

ex10 x = foldl (\b a -> merge b a) [] x
    where
        merge :: [(Int, Char)] -> Char -> [(Int, Char)]
        merge [] char = [(1, char)]
        merge xs char = 
            let lastItem = getLast xs in
                if (snd lastItem == char) then
                    init xs ++ [(fst (lastItem) + 1, char)]
                else
                    xs ++ [(1, char)]

        getLast :: [a] -> a
        getLast xs = (reverse xs) !! 0            

-- 31번. is-prime
{-
(**) Determine whether a given integer number is prime.

Example:

* (is-prime 7)
T
소수 : 2, 3, 5, 7, 11, 13, 17, 19 ...
-}

ex31 :: Int -> Bool
ex31 1 = False
ex31 value = ex31' 2
    where
        ex31' :: Int -> Bool
        ex31' inc 
            | inc == value = True
            | mod value inc == 0 = False
            | otherwise = ex31' (inc + 1)


-- 32번. gcd. 최대공약수 구하기
{-
(**) Determine the greatest common divisor of two positive integer numbers. Use Euclid's algorithm.
최대공약수 정의 : 0이 아닌 두 정수의 공통되는 약수 중에 가장 큰 수
약수 정의 : 어떤 수를 나누었을때 나머지가 0 인 수. (ex. 24 의 약수는 1,2,3,4,6,8,12,24 임)

Example:

* (gcd 36 63)
9
gcd 12 20   -> 4
gcd 16 24   -> 8
gcs 4 24    -> 4
gcd 4 4     -> 4
gcd 72 40   -> 8
gcd 532 462 -> 14
-}

ex32 :: Int -> Int -> Int
ex32 x1 x2 = ex32' 2 x1 x2
    where
        ex32' idx x y
            | x == 1 && y == 1 = 1              -- x y가 같은 값일때의 예외처리
            | mod x idx == 0 && mod y idx == 0 = idx * ex32' 2 (div x idx) (div y idx)
                                                -- 두 숫자 모두 나누어 0 으로 떨어지면, 재귀
            | idx == x || idx == y = 1          -- 두 숫자 모두 나누어 떨어지지 않을때 (종료처리)
            | otherwise = ex32' (idx + 1) x y   -- 두 숫자 모두 나누어 떨어지지 않을때 (재귀)

----------------------------------------
----- 알고리즘 문제

-- 90번. Eight queens problem
{- 
    참고 : https://ko.wikipedia.org/wiki/8_%ED%80%B8_%EB%AC%B8%EC%A0%9C

    문제를 풀되 queens 8 은 답이 매우 기니, queens 6 을 하면 아래처럼 4개의 해답이 나와야 함.
    *exercise> queens 6
    [[2,4,6,1,3,5],[3,6,2,5,1,4],[4,1,5,2,6,3],[5,3,1,6,4,2]]   

-}


-- !!! 위 문제가 어렵다면, 대신 아래 문제를 풀면 됩니다.

-- topcoder 665 문제. LuckyXor
-- https://community.topcoder.com/stat?c=problem_statement&pm=13960
{-
    

    [문제 설명] 아래 타입의 함수를 구현하면 됩니다.
        construct :: Int -> Int 
    문제를 다 풀고나서, 아래 처럼 실행했을때 아래 처럼 답이 나와야 합니다.
    *exercise> construct 4
    Returns: 40
    *exercise> construct 19
    Returns: 20
    *exercise> construct 88
    Returns: 92
    *exercise> construct 36
    Returns: -1

    참고 : 비트 연산은 소스내에서 아래처럼 Data.Bits 를 import 하시면 됩니다.
    import Data.Bits
    참고 : https://hackage.haskell.org/package/base-4.9.1.0/docs/Data-Bits.html#v:xor
-}