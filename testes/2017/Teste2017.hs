-- TESTE 2017

--1
{--

a. [1,5,4,3]
b. [5,6,9]
c. 2
d. [15,18,21,24,27,30]
e. 4
f. [1,2,3,4,6,9]
g. [1,2,3]
h. [x*((-1)^x!!n) | x <- [0..10]]
i. h [0..7] = 1 + h [1..7] = 1 + 1 + h [2..7] = 1 + 1 + 1 + h [3..7] = 1 + 1 + 1 + 1 + h [4..7]
= 1 + 1 + 1 + 1 + 1 + h [5..7] = 1 + 1 + 1 + 1 + 1 + 1 + h [6..7] = 1 + 1 + 1 + 1 + 1 + 1 + 1 + h [7..7]
= 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + h [] = 8
j. ([Char],[Float])
k. fst :: (a, b) -> a 
l. h :: Ord a => a -> a -> a -> Bool
m. f :: [a] -> a 

--}

--2
numEqual :: Int -> Int -> Int -> Int
numEqual n m p | n == m && n == p = 3
               | (n == m && n /= p) || (n == p && m /= n) || (m == p && n /= m) = 2
               | (n /= m && n /= p && m /= p) = 1
               | otherwise = 0

--3
{--
area :: Int -> Int -> Int -> Int -> Int -> Int -> Int
area a b c d p q = (1/4) * sqrt ((4*(p^2)*(q^2)) - ((b^2)+(d^2)-(a^2)-(c^2))^2)
-}

--4
enquantoPar :: [Int] -> [Int]
enquantoPar [] = []
enquantoPar (x:xs) | x`mod`2 == 0 = x:enquantoPar xs
                   | otherwise = []

--5 
nat_zip :: [a] -> [(a,Int)]
nat_zip [] = []
nat_zip l = zip l [1..length l]

--6
--a
quadradosa :: [Int] -> [Int]
quadradosa [] = []
quadradosa (x:xs) = x^2 : quadradosa xs

--b
quadradosb :: [Int] -> [Int]
quadradosb l = [x^2 | x <- l]

--7
crescente :: [Int] -> Bool
crescente [] = True
crescente x:xs | x <= head xs = True && crescente xs
               | otherwise = False

partes :: Int -> [[Int]]
partes n = 