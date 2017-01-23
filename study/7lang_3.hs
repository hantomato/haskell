{-
7랭귀지 교재. haskell (3일차)
-}


-- Prelude> data Suit = Spader | Heart deriving (Show)
-- Prelude> Spader
-- Spader
-- Prelude> :t Spader
-- Spader :: Suit

-- 사용자 정의 자료형 사용하기.
data Suit = Spader | Heart deriving (Show)
data Rank = Ten | Jack | Queen | King | Ace deriving (Show)
type Card = (Rank, Suit)
type Hand = [Card]

value :: Rank -> Integer
value Ten = 1
value Jack = 2
value Queen = 3
value King = 4
value Ace = 5

cardValue :: Card -> Integer
cardValue (rank, suit) = value rank

-- *Main> cardValue (Queen, Spader)
-- 3
-- *Main> cardValue (Queen, Heart)
-- 3
-- *Main> cardValue (Ten, Heart)
-- 1

------------------------------
-- 함수와 다형성
backwards [] = []
backwards (h:t) = backwards t ++ [h]

-- *Main> backwards [1,2,3,4]
-- [4,3,2,1]
-- *Main> backwards ['a', 'b']
-- "ba"

data Triplet a = Trio a a a deriving (Show)
data Triplet1 k = Trio1 k k k deriving (Show)
data Triplet2 a b = Trio2 a a b deriving (Show)
-- *Main> :t Trio 'a' 'b' 'c'
-- Trio 'a' 'b' 'c' :: Triplet Char

-- *Main> :t Trio 1 2 3
-- Trio 1 2 3 :: Num a => Triplet a

------------------------------
-- 재귀 자료형
data Tree a = Children [Tree a] | Leaf a deriving (Show)

-- *Main> :t Leaf
-- Leaf :: a -> Tree a















