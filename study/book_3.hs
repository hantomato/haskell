
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

