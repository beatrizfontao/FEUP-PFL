import Data.List

-- LI-39
myPermutations :: String -> [String]
myPermutations [] = [[]]
myPermutations xs = [x:l | x <- xs, l <- myPermutations (delete x xs)]

-- HO-41
myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f x [] = []
myScanl f x (y:ys) = x:myScanl f (f x y) ys

myScanlf :: (a -> b -> a) -> a -> [b] -> [a]
myScanlf f a l = a:foldl ()