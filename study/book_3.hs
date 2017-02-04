
module Book3Module where
-- 내 모듈의 이름을 지정

{-
module Main where 사용하면 아래 오류 뜸.
    The IO action ‘main’ is not defined in module ‘Main’
Failed, modules loaded: none.
-}

digits :: Int -> Int
digits = length . show

square :: Num a => a -> a
square = (^ 2)

{-
	의문점 ^ 는 파라미터 2개 받는 함수.
	*Book3Module> (^) 2 5
	32
	*Book3Module> (^) 5 2
	25
	이걸 보면 square 는 (^)의 첫번째 파라미터를 받음.
	그리고 (^ 2) 에서 2가 두번째 파라미터라는 얘기

	아래 2개는 같은 결과로 25 리턴함.
	square 5
	(^ 2) 5
	5 ^ 2
	(^) 5 2
	헤깔리네..

-}
square2 :: Num a => a -> a
square2 x = x ^ 2

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just a) = [a]
-- 실행은 아래처럼
-- maybeToList Nothing
-- maybeToList (Just 1234)

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (a : as) = Just a

deepning :: String -> String
deepning (' ' : ' ' : xs) = "    " ++ xs
deepning (' ' : xs) = "  " ++ xs
deepning xs = xs

nonExhaustive :: Int -> Int
nonExhaustive 0 = 0
nonExhaustive 1 = 1
nonExhaustive 2 = 2
-- *** Exception: book_3.hs:(54,1)-(56,19): 
-- Non-exhaustive patterns in function nonExhaustive

{-
	ghci -W book_3.hs
	// 경고 출력
	book_3.hs:54:1: warning: [-Wincomplete-patterns]
	    Pattern match(es) are non-exhaustive
	    In an equation for ‘nonExhaustive’:
	        Patterns not matched: p where p is not one of {2, 1, 0}	
-}

------------------------------
-- as 패턴. 변수@패턴 식으로 사용
-- 중요 중요 중요 중요 중요 중요 중요 
------------------------------
deepning1 :: String -> String
deepning1 s@(' ' : ' ' : xs) = "  " ++ s
deepning1 s@(' ' : xs) = " " ++ s
deepning1 s = s

------------------------------
-- 플레이스홀더. _ 를 말함. 위에서는 xs 를 선언만 하고 사용하지 않았다고 경고 뜨지만,
-- 언더바는 경고 안뜸.
------------------------------
deepning2 :: String -> String
deepning2 s@(' ' : ' ' : _) = "  " ++ s
deepning2 s@(' ' : _) = " " ++ s
deepning2 s = s

------------------------------
-- 가드
safeSqrt :: (Ord a, Floating a) => a -> Maybe a
safeSqrt x
 | x < 0 = Nothing
 | otherwise = Just (sqrt x)

------------------------------
-- 패턴매치, 가드 조합
caseOfFirstLetter :: String -> String
caseOfFirstLetter "" = "empty"
caseOfFirstLetter (x:xs)
 | 'a' <= x && x <= 'z' = "lower"
 | 'A' <= x && x <= 'Z' = "upper"
 | otherwise = "other"

------------------------------
-- case 와 if. 이것들을 식(expression) 이라고 함.
caseOfFirstLetter1 :: String -> String
caseOfFirstLetter1 str =
  case str of
    "" -> ""
    (x:xs) -> if 'a' <= x && x <= 'z'
                then "lower"
                else if 'A' <= x && x <= 'Z'
                  then "upper"
                  else "other"

strLen :: String -> String
strLen str =
  case str of
    (x:x1:x2) -> "length > 1"
    [] -> "length 0"
    x -> "length 1"

caseOfFirstLetter2 :: String -> String
caseOfFirstLetter2 str =
  case str of
    "" -> ""
    (x:xs) | 'a' <= x && x <= 'z' -> "lower"
           | 'A' <= x && x <= 'Z' -> "upper"
           | otherwise            -> "other"

-- where 활용
caseOfFirstLetter3 :: String -> String
caseOfFirstLetter3 "" = "empty"
caseOfFirstLetter3 (x:xs)
  | inRange 'a' 'z' = "lower"
  | inRange 'A' 'Z' = "upper"
  | otherwise = "other"
  where
    inRange lower upper = lower <= x && x <= upper
    
-- where 활용 연습    
tailLength :: [Int] -> Int
tailLength [] = 0
tailLength (_:xs) = myLength xs
  where
    myLength :: [Int] -> Int -- where에 선언 넣을수 있군.
    myLength input = length input

tailLength2 :: [Int] -> Int
tailLength2 [] = 0
tailLength2 (_:xs) = myLength
  where -- 위에서 선언된 xs 사용
    myLength = length xs

tailLength3 :: [Int] -> Int
tailLength3 [] = 0
tailLength3 (_:xs) = myLength xs
  where -- 패턴매치 사용
    myLength [] = 0
    myLength [a] = 1
    myLength (a:as) = 1 + myLength as

-- 여러개의 where 사용. where 의 scope 테스트.
tailLength4 :: [Int] -> Int
tailLength4 [] = 0
tailLength4 [a] = myLength a
  where
    myLength i = 1

tailLength4 (_:xs) = myLength xs
  where -- 패턴매치 사용
    myLength [] = 0
    myLength (a:as) = 1 + myLength as

-- take 구현
take1 :: Int -> [a] -> [a]
take1 n _ | n <= 0  = []
take1 n []          = []
take1 n (x:xs)      = x : take1 (n - 1) xs

-- drop 구현
drop1 :: Int -> [a] -> [a]
drop1 n xs | n <= 0   = xs
drop1 n []            = []
drop1 n (x:xs)        = drop1 (n - 1) xs

-- 원소를 정렬된 리스트에 순서에 맞게 끼워넣기. 
ins :: Ord a => a -> [a] -> [a]
ins n []        = [n]
ins n i@(x:xs) 
  | n < x       = n : i
  | otherwise   = x : ins n xs

-- 리스트 정렬하기
insSort :: Ord a => [a] -> [a]
insSort []      = []
insSort (x:xs)  = ins x (insSort xs) -- 이런 응용에 약함.

------------------------------
-- 고차함수는 이미 했으니 스킵
-- *Book3Module> scanl (\x y -> x+y) 10 [1,2,3,4]
-- [10,11,13,16,20]











