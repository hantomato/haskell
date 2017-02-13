-- 연습문제 풀이

{-
	문제는 아래 사이트에서 8문제를 뽑고, 탑코더에서 한문제 뽑았습니다.
	https://wiki.haskell.org/99_questions

	정답이 나와있기때문에, 문제를 다 푸는게 중요한게 아니라, 풀이 과정을 설명할 수 있어야 함.
-}

----------------------------------------
-----// 기초 문제

-- 1번. (99 questions 의 1번 문제를 말함)

-- 2번.

-- 5번.

-- 6번.

-- 10번.


----------------------------------------
-----// 몸풀기 문제

-- 31번. is-prime

-- 32번. gcd


----------------------------------------
-----// 알고리즘 문제

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