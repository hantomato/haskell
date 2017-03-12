{-
Learn You a Haskell For Great Good!

if문은 표현식임. 항상 먼가를 리턴하는 것을 표현식이라 함???
함수명은 대문자로 시작할 수 없음.  
-}

doubleMe x = x + x

doubleSmallNumber x = if x > 100 then x else x * 2

-- 이런 걸 definition 또는 name 이라고 불름.
conan0'Brien = "It's a-me, Conan 0'Brien!"

{-
  [1,2,3,4] ++ [9,10,11,12]
  ++ 보단 : 가 속도 빠름. 
  [1..500] ++ [501] 은 뒤에 한개를 붙이기 위해 앞에 500개를 흩어보게됨

  [1,2,3]은 실제로는 1:2:3:[]의 간단한 표현(syntactic sugar)임
  [1,2,3] !! 0 -- 리스트의 0번 인덱스 구하기
  리스트의 리스트도 안의 리스트의 타입들이 같아야함. 즉
  [[1,1],['2','2']] 은 오류임

  !!!!!
  리스트의 비교. 원소들이 비교 가능하다면 리스트도 비교 가능함.
  첫번째 원소끼리 비교 후, 둘이 같으면 두번째 원소를 비교..
  ghci> [3,2,1] > [2,1,0]  
  True
  
  리스트 처리 관련 기본 함수들
  head, tail, length, reverse, take, drop
  last (마지막 원소 리턴), 
  init (마지막 원소 제외한 리스트 리턴)
  null (리스트가 빈 리스트인지 확인. bool)
  if xs == [] 대신 if null xs 처럼 쓰자
  maximum, minimum
  sum (합), product (곱)
  elem 가독성때문에 infix로 쓰임. 리스트가 특정 원소를 포함하는지 확인

  [1,5..100] -- 등차수열(arithmetic sequence)

  cycle xs -- 배열 xs를 계속 반복. (리스트)
  repeat x -- 원소 x를 계속 반복. (리스트)
  replicate 3 10 -- 원소 10을 3개 포함한 리스트 리턴

  :: 'has type of' 라고 읽음
-}

{-
  타입클래스 : 어떤 행도을 정의해 놓은 인터페이스의 일종.
  (==) :: (Eq a) => a -> a -> Bool 에서 => 전에 나오는 것들을
  클래스 제약(class constraint)라고 함.

  !!!!! == 의 반대는 /= 임. (!= 아님)

-}

lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number"
lucky x = "sorry"

{-
  패턴매칭
  func (x:[]) 대신 [x] 써도 됨.
  func (x:y:[]) 대신 [x,y] 써도 됨.
  종료 처리를 경계 조건(edge condition) 라고 함.
-}


{-
  8장. 타입, 타입클래스 만들기
-}

-- data 는 새로운 데이터 타입을 정의한다는 걸 의미.
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

{-
  타입 매개변수 (Type parameters)
  값 생성자는 몇 개의 값 매개변수를 받아서 새로운 값을 만들어 냄
  비슷한 방법으로, 타입 생성자는 타입을 매개변수로 받아서 새로운 타입을 만들어 냄.

  data Maybe a = Nothing | Just a
  위에서 a가 타입 매개변수임. 그리고 타입 변수를 포함하기때문에,
  Maybe는 타입 생성자라고 부를 수 있음.

  이 타입 생성자가 Maybe Int 타입, Maybe Car 타입, Maybe String 타입 등등의 타입을 만들어 냄.
  어떤 값도 그냥 Maybe라는 타입을 가질 수는 없음. Maybe는 그 자체로는 타입이 아니라 타입 생성자이기때문임.
-}



