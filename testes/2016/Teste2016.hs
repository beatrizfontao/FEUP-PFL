-- TESTE 2016

-- 1
{-- 
a. [2, 3, 1, 4, 4]
b. [0, 10, 20, 30, 40]
c. [3, 4, 5]
d. 5
e. [] - ??? 6
f. [(1, 4), (2, 3), (3, 2)]
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
ttriangulo a b c | a == b && b == c = "equilátero"
                 | (a == b && b != c) || (a == c && b != c) || (b == c && c != a) = "isósceles"
                 | a != b && b != c && a != c = "escaleno"
                 | otherwise = "idk???"

--b
rectangulo :: Int -> Int -> Int -> Bool
rectangulo a b c | a^2 == (b^2 + c^2) = true
                 | b^2 == (b^2 + a^2) = true
                 | c^2 == (b^2 + a^2) = true
                 | otherwise = false;

--3
