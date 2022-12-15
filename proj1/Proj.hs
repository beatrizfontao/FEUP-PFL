module Proj where
import Data.List
import Data.Char

{--
Chosen representation for Monomials.
Tuple where the first element is an Integer, with the value of the coefficient, and the second is a list of Tuples representing the variables in the form (variable, exponent). 
-}
type Mon = (Int, [(Char, Int)])


{--
Chosen representation for Polynomials.
List of Monomials. 
-}
type Pol = [Mon]
 

-- Print

{-- 
Receives a List containing a Monimial's variables and returns a string of variables in the desired format.
-} 
printVars :: [(Char,Int)] -> String
printVars [] = []
printVars ((a,b):xs) |b > 1 = a:[] ++ "^" ++ (show b) ++ printVars xs
                     |b == 1 = a:[] ++ printVars xs
                     |otherwise = printVars xs

{--
Receives a Monomial and returns a string in the desired format (constant variable ^ exponent variable1 ^ exponent1 ...).
-}
printMon :: Mon -> String
printMon (a,l) | a == 1 && (snd (head l)) == 0 = " + " ++ (show a)
               | a == 1 = " + " ++ printVars l
               | a > 0 = " + " ++ (show a) ++ printVars l
               | a == -1 = " - " ++ printVars l
               | a < 0 = " - " ++ (show (abs a)) ++ printVars l
               | otherwise = "" 

{--
Receives a Polynomial and returns a string in the desired format (monomial + monomial1 + ...).
-}
printPol :: Pol -> String
printPol [] = " + 0"
printPol (x:[]) = printMon x
printPol (x:xs) = printMon x ++ printPol xs 

{--
Removes the extra plus sign from the start of the string.
-}
printPolResult :: String -> String
printPolResult [] = []
printPolResult a | a!!1 == '+' = drop 3 a
                 | otherwise = drop 1 a 

{--
Removes the spaces from a given string.
-}
removeSpaces :: String -> String
removeSpaces [] = []
removeSpaces (x:xs) | x == ' ' = removeSpaces xs
                    | otherwise = [x] ++ removeSpaces xs

{--
Returns the first elements of the string until it finds a letter.
-}
getExp :: String -> String
getExp [] = []
getExp (x:xs) | isLetter x == False = [x] ++ getExp xs
              | otherwise = []

{--
Receives a string with a Monomial and returns a list with strings that contain the Monomial's variables.
-}
getMonVars :: String -> [String]
getMonVars [] = []
getMonVars (x:xs) | isLetter x = [[x] ++ getExp xs] ++ getMonVars xs
                  | otherwise = getMonVars xs

{--
Receives a tuple with a coefficient and a string with variables and returns the respective Monomial.
-}
createMon :: (Int, String) -> Mon
createMon (n, []) = (n, [('x', 0)])
createMon (n,l) = (n, createVars (getMonVars l))

{--
Receives a list with strings containing a Monomial variables and returns the in the right format ([(variable, exponent)]).
-}
createVars :: [String] -> [(Char, Int)]
createVars [] = []
createVars (x:xs) = [createVar x] ++ createVars xs

{--
Receives a String with a variable and returns it in the format (variable, exponent).
-}
createVar :: String -> (Char, Int)
createVar (x:[]) = (x,1)
createVar (x:y:xs) = (x, read xs::Int)

{--
Returns the first elements of a string until it finds a plus sign or a minus sign which corresponds to the first Monomial.
-}
getMon :: String -> String
getMon [] = []
getMon (x:xs) | x /= '+' && x /= '-' = [x] ++ getMon xs
              | otherwise = []

{--
Uses the function getMon to separate a string that contains a Polynomial into a list of strings each containg a Monimial.
-}
getMons :: String -> [String]
getMons [] = []
getMons (x:xs) | x == '+' = ["+" ++ getMon xs] ++ getMons xs
               | x == '-' = ["-" ++ getMon xs] ++ getMons xs
               | otherwise = getMons xs

{--
Given a String, returns a List of Integers that contain the coefficient of the Monimial. Has to be a list since the coefficient can have two digits.
-}
getCoefficient :: String -> [Int]
getCoefficient [] = []
getCoefficient (x:xs) | isLetter x = []
                     | otherwise = [read [x] :: Int] ++ getCoefficient xs 

{--
Receives a List of Integers and returns the corresponding number. Example: [1, 2, 3] -> 123
-}
dec2int :: [Int] -> Int
dec2int l = foldl (\x y -> x * 10 + y) 0 l

{--
Receives a string with a Monomial and returns a string with only the variables
-}
getVars :: String -> String
getVars [] = []
getVars (x:xs) | not (isLetter x) = getVars xs
            | otherwise = (x:xs)
                
{--
Receives a String with a Monomial and returns a tuples with the format (Coefficient, Variables), with the variables still in a String.
-}
translateMon :: String -> (Int, String)
translateMon a | a!!0 == '-' && isLetter (a!!1) = (-1, tail a)
               | a!!0 == '-' && (not (isLetter (a!!1))) = (- dec2int(getCoefficient (tail a)), getVars (tail a))
               | a!!0 == '+' && isLetter (a!!1) = (1, tail a)
               | a!!0 == '+' && (not (isLetter (a!!1))) = (dec2int(getCoefficient (tail a)), getVars (tail a)) 

{--
Receives a string with a Polynomial and returns it in the Polynomial type.
-}
createPol :: String -> Pol
createPol [] = [(0, [('x', 0)])]
createPol (x:xs) | x /='+' && x /= '-' = [createMon (translateMon a) | a<-getMons("+" ++ removeSpaces(x:xs))]
                 | otherwise = [createMon (translateMon a) | a<-getMons(removeSpaces(x:xs))]


-- Normalize

{--
Adds a Monomial to a Polymonial
-}
addMontoPol :: Mon -> Pol -> Pol
addMontoPol a [] = [a]
addMontoPol a (x:xs) | (snd a) == (snd x) = [((fst a) + (fst x), snd x)] ++ xs
                     | otherwise = [x] ++ addMontoPol a xs

{--
Removes from a Polynomial the Monomials that have a coefficient equal to 0
-}
removeZeros :: Pol -> Pol
removeZeros [] = []
removeZeros (x:xs) | fst x == 0 = removeZeros xs
                   | otherwise = [x] ++ removeZeros xs

{--
Inserts the the tuple (variable, exponent) before the first element in the list of tuples of the same format which has a greater variable (alphabetically)
-}
myinsert :: (Ord a, Ord b) => (a, b) -> [(a,b)] -> [(a,b)]
myinsert c [] = [c]
myinsert (c,d) ((x1,x2):xs) | c > x1 = [(x1,x2)] ++ myinsert (c,d) xs
                            | otherwise = [(c,d)] ++ ((x1,x2):xs)

{--
Sorts the variables of a Monomial by alphabetical order
-}
sortVars :: Mon -> Mon
sortVars (a, (x:xs)) = (a, foldr (\x -> myinsert x) [] (x:xs))

{--
Sorts the variables of every Monomial in a Polynomial by alphabetical order
-}
sortPolVars :: Pol -> Pol
sortPolVars (x:[]) = [sortVars x]
sortPolVars (x:xs) = [sortVars x] ++ sortPolVars xs

{--
Returns the greater exponent in the Monomial
-}
maxExp :: Mon -> Int
maxExp (a,((c,d):[])) = d
maxExp (a,((c,d):xs)) | d > mymax = d
                      | otherwise = mymax
                      where mymax = maxExp (a,xs)

{--
Counts the number of variables a Monomial has
-}
countVars :: Mon -> Int
countVars (a,b) = length b

{--
Receives a Monomial and a Polynomial and inserts the Monomial before the first Monomial in the Polynomial which has a lower maximum exponent
-}
sortByExp :: Mon -> Pol -> Pol
sortByExp a [] = [a]
sortByExp a (x:xs)  | maxExp a < maxExp x = [x] ++ sortByExp a xs
                    | maxExp a == maxExp x && countVars a < countVars x = [x] ++ sortByExp a xs 
                    | otherwise = [a] ++ (x:xs)

{--
Receives a Polynomial and sorts it according to the function sortByExp
-}
sortPol :: Pol -> Pol
sortPol l = foldr sortByExp [(0,[('x',0)])] l

{--
Receives a Polynomial and normalizes it
-}
norm :: Pol -> Pol
norm l = removeZeros (sortPol (foldr addMontoPol [(0,[('x',0)])] (sortPolVars l)))

{--
Receives a Polynomial represented by a string and normalizes it
-}
normalize :: String -> String
normalize l = printPolResult(printPol (norm (createPol l)))


-- Add

{--
Adds two Polynomials represented by strings by joining them in a single Polynomial and normalizing it 
-}
add :: String -> String -> String
add [] [] = "0"
add l1 l2 = printPolResult(printPol(norm (createPol (l1) ++ createPol(l2))))


-- Derivate

{--
Receives a char 'a' and a list of tuples in the format (variable, exponent) and differetiates the each tuple of the list with respect to the char 'a'
-}
calcD :: Char -> [(Char, Int)] -> [(Char, Int)]
calcD a [] = [] 
calcD a ((b,c):xs) | a == b && c /= 0 = (b,c-1):xs
                   | otherwise = [(b,c)] ++ calcD a xs

{--
Receives two lists of tuples with the variables and exponents and tries to find the first instance where they are different, 
    returning the exponent of the second tuple.
This is used to check if anything changed when we differentiated the variables, if nothing changed (i.e the variable used to do the differentiation was not in the Monomial),
    this should return 0, or return the initial value of the exponent that was decreased if the variable used to do the differentiation was in the Monomial
-}
findDif :: [(Char, Int)] -> [(Char, Int)] -> Int
findDif [] [] = 0
findDif (x:xs) ((a,b):ys) | x == (a,b) = findDif xs ys
                          | otherwise = b

{--
Finds the derivative of a Monomial with respect to a variable represented by a char 
-}
findDerivativeMon :: Char -> Mon -> Mon
findDerivativeMon a (b,(x:xs)) = (b*(findDif c (x:xs)), c) 
                            where c = calcD a (x:xs)

{--
Finds the derivative of a Polynomial with respect to a variable represented by a char 
-}
derivative :: Char -> Pol -> Pol
derivative a [] = []
derivative a (x:xs) = norm ([findDerivativeMon a x] ++ derivative a xs)

{--
Finds the derivative of a Polynomial represented by a string with respect to a variable represented by a char and presents the normalized result
-}
findDerivative :: Char -> String -> String
findDerivative a l | a == ' ' = printPolResult(printPol (norm (createPol l)))
                   | otherwise = printPolResult(printPol (derivative a (createPol l)))


-- Multiply     

{--
Receives a variable and its exponent in the form (Char, Int) and multiplies it with a group of variables.
-}
multiplyVars_func :: (Char, Int) -> [(Char, Int)] -> [(Char, Int)]
multiplyVars_func (c,d) [] = [(c,d)]
multiplyVars_func (c, d) ((a, b):xs) | a == c = [(a, b+d)] ++ xs
                              | otherwise = [(a,b)] ++ multiplyVars_func (c, d) xs

{--
Receives the variables of two Monomials and multiplies them.
-}
multiplyVars :: [(Char, Int)] -> [(Char, Int)]
multiplyVars (x:xs) = foldr (\x -> multiplyVars_func x) [] (x:xs)

{--
Receives two Monomials and multiplies them.
-}
multiplyMon :: Mon -> Mon -> Mon
multiplyMon (a,b) (c,d) = (a*c, multiplyVars (b ++ d))

{--
Receives a Monomial and a Polynomial and multiplies the Monomial with every Monomial of the Polynomial.
-}
multiplyMonPol :: Mon -> Pol -> Pol
multiplyMonPol a [] = []
multiplyMonPol a (x:xs) = [multiplyMon a x] ++ multiplyMonPol a xs

{--
Receives two Polynomials and multiplies them.
-}
mult :: Pol -> Pol -> Pol
mult [] l = []
mult (x:xs) l = multiplyMonPol x l ++ mult xs l

{--
Receives two strings, transforms them into polynomials, multiplies them and presents the normalized result.
-}
multiply :: String -> String -> String
multiply a b = printPolResult(printPol(norm(mult (createPol a) (createPol b))))
