
module Book5Module where

-- 타입클래스의 정의는 class 키워드로 시작..
class BoolLike a where
  fromBoolLike :: a -> Bool

{-
  Eq의 type class
class Eq a where
  (==) :: a -> a -> Bool
  x == y = not (x /= y)
  (/=) :: a -> a -> Bool
  x /= y = not (x == y)
-}

-- BoolLike 는 타입 인수 a를 갖는 타입 클래스 이다.
-- where 뒤에는 이 타입 클래스 BoolLike가 만족되어야 할 성질,
-- 즉 인터페이스의 리스트가 타입 정보와 함께 열거된다.

-- 타입클래스의 인스턴트 만들기..
instance BoolLike Int where
  fromBoolLike = (0 /=)

instance BoolLike (Maybe a) where
  fromBoolLike Nothing = False
  fromBoolLike (Just _) = True

instance BoolLike Bool where
  fromBoolLike x = x

data A = A
data B = B

class ToInt a where
  toInt :: a -> Int

instance ToInt A where
  toInt _ = 1

instance ToInt B where
  toInt _ = 2

add :: ToInt x => x -> x -> Int
add x y = toInt x + toInt y

add' :: (ToInt x, ToInt y) => x -> y -> Int
add' x y = toInt x + toInt y


