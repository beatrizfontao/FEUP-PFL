-- TESTE 2016

-- 1
{-- 
a. [2, 3, 1, 4, 4]
b. [0, 10, 20, 30, 40]
c. [[],[3,4],[5]]
d. 5
e. [1,1,1,1,1,1]
f. [(3,2)]
g. [2^x | x <- [0..6]]
h. f 5 = 5*(f 4) = 5*4*(f 3) = 5*4*3*(f 2) = 5*4*3*2*(f 1) = 5*4*3*2*1(f 0) = 5*4*3*2*1*0 = 0
i. [(Bool, Int)]
j. troca :: (a, b) -> (b, a)
k. g :: Num a -> a -> a -> a
l. [([a], a)]
--}

--2
--a
ttriangulo :: Int -> Int -> Int -> String
ttriangulo a b c | a == b && b == c = "equilatero"
                 | (a == b && b /= c) || (a == c && b /= c) || (b == c && c /= a) = "isosceles"
                 | a /= b && b /= c && a /= c = "escaleno"
                 | otherwise = "idk???"

--b
rectangulo :: Int -> Int -> Int -> Bool
rectangulo a b c | a^2 == (b^2 + c^2) = True
                 | b^2 == (b^2 + a^2) = True
                 | c^2 == (b^2 + a^2) = True
                 | otherwise = False;

--3
maiores :: [Int] -> [Int]
maiores (x:[]) = []
maiores (x:xs) | x > head xs = [x] ++ maiores xs
               | otherwise = maiores xs

--4
--a
somapares :: [(Int, Int)] -> [Int]
somapares [] = []
somapares (x:xs) = [fst x + snd x] ++ somapares xs

--b
somaparesLC :: [(Int,Int)] -> [Int]
somaparesLC l = [x+y | (x,y) <- l]

--5
itera :: Int -> (Int->Int) -> Int -> Int
itera n f v = foldr f v [1..n]