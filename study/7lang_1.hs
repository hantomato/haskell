{-
7랭귀지 교재. haskell (1일차)
-}
{-
	// 모듈 로드 		:l test.hs
	// 모듈 언로드		:m

	// 기본 메서드들
		head, tail
	// 리스트 합치기
		1 : [2,3] -> [1,2,3]
		[1,2,3] ++ [4,5] => [1,2,3,4,5]


-}
{- 
	// 1일차
	1. allEven을 작성하기 위한 서로 다른 방법을 몇 개나 찾을 수 있는가?
	2. 리스트를 받아들여서 똑같은 리스트가 순서만 거꾸로 된 채 리턴하는 함수를 작성하라
	3. 검정색, 흰색, 파란색, 노란색, 빨간색 중에서 두 개를 뽑아서 만들 수 있는
		모든 가능한 조합을 담는 2차 튜플을 만드는 함수를 작성하라.
		이때 (검정색, 파란색)과 (파란색, 검정색) 중 하나만 포함하도록 만들어야 함에 유의하라
	4. 어릴 때 보았던 구구단 테이블을 만드는 리스트 컴프리헨션을 작성하라.
		테이블은 3차 튜플을 담고 있는 리스트이어야 한다.
		처음 두 개의 수는 1에서 12사이에 있는 정수고 세 번째는 두 수를 곱한 결과다.
-}

-- 기본적인 method 구조
myGetAge :: Integer -> Integer
myGetAge n = 41

myTest :: [a] -> Integer
myTest [] = 0
myTest [_] = 5
myTest (_:__) = 1
--------------------------------------------------

-- 연습문제 1.
-- 리스트에서 짝수만 남아있는 리스트를 반환한다.
myAllEven1 :: [Integer] -> [Integer]
myAllEven1 [] = []
myAllEven1 (x:xs) = 
  if even x 
  then x : myAllEven1 xs 
  else myAllEven1 xs

myAllEven2 :: [Integer] -> [Integer]
myAllEven2 x = myAllEven2' [] x

myAllEven2' :: [Integer] -> [Integer] -> [Integer]
myAllEven2' [] [] = []
myAllEven2' (x:xs) [] = x : xs
myAllEven2' [] (x:xs) = 
  if even x
  then myAllEven2' [x] xs
  else myAllEven2' [] xs
myAllEven2' (x1:xs1) (x2:xs2) = 
  if even x2
  then myAllEven2' ((x1:xs1) ++ [x2]) xs2
  else myAllEven2' (x1:xs1) xs2
--------------------------------------------------

-- 연습문제 2.
-- 리스트를 입력받아 순서를 아이템 순서가 거꾸로된 리스트를 반환한다.
myRevert :: [a] -> [a]
myRevert [] = []
myRevert i@(x:xs) = myRevert' [] i

-- 두 개의 리스트를 입력받아서 뒤에 리스트 요소를 앞의 리스트에 담되 순서를 거꾸로 담는다.
myRevert' :: [a] -> [a] -> [a]
myRevert' [] [] = []
myRevert' i@(x:xs) [] = i
myRevert' [] (x:xs) = myRevert' [x] xs
myRevert' i@(x1:xs1) (x2:xs2) = myRevert' (x2 : i) xs2

-- myRevert를 where 사용하는 방법으로 변경
myRevert1 :: [a] -> [a]
myRevert1 [] = []
myRevert1 i@(x:xs) = myRevert1' [] i
  where
    myRevert1' :: [a] -> [a] -> [a]
    myRevert1' [] [] = []
    myRevert1' i@(x:xs) [] = i
    myRevert1' [] (x:xs) = myRevert' [x] xs
    myRevert1' i@(x1:xs1) (x2:xs2) = myRevert1' (x2 : i) xs2

myRevert2 :: [a] -> [a]
myRevert2 [] = []
myRevert2 (x:xs) = myRevert2 xs ++ [x]
--------------------------------------------------

-- 연습문제 3.
-- *Main> extractColorTuples
-- [("black","white"),("black","blue"),("black","yellow") ...
extractColorTuples :: [([Char],[Char])]
extractColorTuples = extractTuples ["black", "white", "blue", "yellow", "red"]
--extractColorTuples = extractTuples ["a", "b", "c"]

-- *Main> extractTuples [1,2,3,4]
-- [(1,2),(1,3),(1,4),(2,3),(2,4),(3,4)]
extractTuples :: [a] -> [(a,a)]
extractTuples [] = []
extractTuples [x] = []
extractTuples (x:xs) = (makeTuples x xs) ++ (extractTuples xs)
--mmm' [x:xs] = [(x,x)]

-- *Main> makeTuples 1 [2,3,4]
-- [(1,2),(1,3),(1,4)]
makeTuples :: a -> [a] -> [(a,a)]
makeTuples y [] = []
makeTuples y [x] = [(y,x)]
makeTuples y (x:xs) = (y,x) : makeTuples y xs

-- 일단 아래는 오답임.
extractColorTuples2 :: [([Char],[Char])]
extractColorTuples2 = extractTuples2 ["black", "white", "blue", "yellow", "red"]
--extractColorTuples2 = extractTuples2 ["a", "b", "c"]

extractTuples2 :: [[Char]] -> [([Char],[Char])]
extractTuples2 [] = []
extractTuples2 [a] = []
extractTuples2 i@(_:_) = [(x,y) | x <- i, y <- i, x /= y]
-- != 는 없네??
{-
extractColorTuples 을 리스트 표현식 사용하여 구현하기.
일단 기존의 extractColorTuples 은 
입력이 [a,b,c] 이면 출력이 [(a,b), (a,c), (b,c)] 임.

[(x,y) | x <- o, y <- o, x /= y] 를 이용할경우
[(a,b), (a,c), (b,a), (b,c), (c,a), (c,b)] 임.
안되겠는데??
-}


--------------------------------------------------

-- 연습문제 4. 1~12 숫자를 사용한 구구단.
-- list comprehension 사용함. 아래는 예제
-- *Main> [x * 2 | x <- [1,2,3]]
-- [2,4,6]
-- *Main> [(x,y) | x <- [1,2], y <- ['a','b']]
-- [(1,'a'),(1,'b'),(2,'a'),(2,'b')]
timesTable :: [(Integer,Integer,Integer)]
timesTable = [(x,y,x*y) | x <- [1..12], y <- [1..12]]
--------------------------------------------------





