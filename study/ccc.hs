-- 세븐랭귀지 책의 하스켈 연습문제
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

	// 2일차
	1. 리스트, 문자열, 튜플 위에서 사용할 수 있는 함수들을 찾아보라
	2. 리스트를 정렬하는 방법을 찾아보라
	3. 리스트를 받아들여 정렬된 리스트를 리턴하는 코드를 작성하라.
	4. 문자열을 수로 변환하는 하스켈 함수를 작성하라. 
		문자열은 $2,345,678,99과 같은 형태를 가지고 있어야 하며, 첫머리가 0일 수도 있다.
	5. x라는 인수를 취한 다음, x에서 시작해서 1씩 증가하면서 3번째에 해당하는 수만 담는 
		게으른 시퀀스를 리턴하는 함수를 작성하라. 
		그 다음에는 y에서 시작해서 5번째에 해당하는 수만 담는 시퀀스를 리턴하는 함수를 작성하라. 
		x + y에서 시작해서 8번째에 해당하는 수만 담는 시퀀스를 리턴하기 위해서 두 시퀀스를 합성하는 함수를 작성하라.
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
myRevert (x:xs) = myRevert' [] (x:xs)

-- 두 개의 리스트를 입력받아서 뒤에 리스트 요소를 앞의 리스트에 담되 순서를 거꾸로 담는다.
myRevert' :: [a] -> [a] -> [a]
myRevert' [] [] = []
myRevert' (x:xs) [] = x : xs
myRevert' [] (x:xs) = myRevert' [x] xs
myRevert' (x1:xs1) (x2:xs2) = myRevert' (x2 : (x1:xs1)) xs2

myRevert2 :: [a] -> [a]
myRevert2 [] = []
myRevert2 (x:xs) = myRevert2 xs ++ [x]
--------------------------------------------------

-- 연습문제 3.
-- *Main> extractColorTuples
-- [("black","white"),("black","blue"),("black","yellow") ...
extractColorTuples :: [([Char],[Char])]
extractColorTuples = extractTuples ["black", "white", "blue", "yellow", "red"]

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




-- 연습문제 2일차
-- 1. 리스트, 문자열, 튜플 위에서 사용할 수 있는 함수들을 찾아보라

--------------------------------------------------

-- 2. 리스트를 정렬하는 방법을 찾아보라
-- Data.List 모듈의 sort 메소드
-- *Main Data.List> sort [1,4,5,2]
-- [1,2,4,5]
-- *Main Data.List> :t sort
-- sort :: Ord a => [a] -> [a]
--------------------------------------------------

--3. 리스트를 받아들여 정렬된 리스트를 리턴하는 코드를 작성하라.
sortList :: [a] -> [a]
sortList [] = []
sortList [x] = [x]
sortList (x:xs) = foldl (\newList item -> item : newList) [] ns

-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b


--------------------------------------------------




--------------------------------------------------
--------------------------------------------------





