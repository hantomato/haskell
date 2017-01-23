{-
7랭귀지 교재. haskell 8.3(2일차) (357page)
-}

{-
	고계함수 : 고계 함수(higher-order function)란, 함수를 다루는 함수를 뜻한다
	haskell에 정의된 고계함수들
	map (cf. select)
		map :: (a -> b) -> [a] -> [b]
		http://reactivex.io/documentation/operators/map.html
	filter (cf. where)
		filter :: (a -> Bool) -> [a] -> [a]
		http://reactivex.io/documentation/operators/filter.html
	foldl (cf. reduce)
		http://reactivex.io/documentation/operators/reduce.html
	
	// 2일차 연습문제
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

------------------------------------------------------------
-- 본문 내용 설명을 위한 코드들..

myGetAge :: Integer -> Integer
myGetAge n = 41

myGetAge2 :: Integer
myGetAge2 = 41

mapTest1 :: [Int]
mapTest1 = map (\a -> a * 2) [1,2,3,4]
-- map :: (a -> b) -> [a] -> [b]
-- [2,4,6,8]

mapTest2 :: [[Char]]
mapTest2 = map (\a -> "value:" ++ show a ) [1,2,3,4]
-- ["value:1","value:2","value:3","value:4"]

-- 짝수 구하기
filterTest1 :: [Int]
filterTest1 = filter (\a -> a `mod` 2 == 0) [1,2,3,4,5,6]
-- filter :: (a -> Bool) -> [a] -> [a]
-- [2,4,6]

-- 합계 구하기
foldlTest1 :: Int
foldlTest1 = foldl (\x item -> x + item) 1 [1,2,3,4,5]
-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- 16

foldlTest2 :: Int
foldlTest2 = foldl (\x item -> x + item) 10 [1,2,3,4,5]
-- 25

zipTest1 :: [(Int, Char)]
zipTest1 = zip [1,2,3,4,5] ['a', 'b', 'c']
-- http://reactivex.io/documentation/operators/zip.html
-- zip :: [a] -> [b] -> [(a, b)]
-- [(1,'a'),(2,'b'),(3,'c')]

-- zipWith sample
-- Prelude> zipWith (\x y -> x+y) [1,2,3,4] [10,20,30,40]
-- [11,22,33,44]
-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

-- Prelude> zipWith (\x y -> x ++ "'s age is " ++ show y ) ["nmj","ktw","khc"] [41, 27, 39]
-- ["nmj's age is 41","ktw's age is 27","khc's age is 39"]
------------------------------------------------------------





-- 연습문제 2일차
--3. 리스트를 받아들여 정렬된 리스트를 리턴하는 코드를 작성하라.
--sortList :: [a] -> [a]
--sortList [] = []
--sortList [x] = [x]
--sortList (x:xs) = foldl (\newList item -> item : newList) [] xs

-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b


--------------------------------------------------




--------------------------------------------------
--------------------------------------------------


