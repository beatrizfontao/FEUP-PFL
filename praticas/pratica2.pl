factorial(0, 1).
factorial(N, R):-
        N > 0,
        N1 is N-1,
        factorial(N1, R1),
        R is N * R1.

somaRec(0, 0).
somaRec(N, R):-
        N > 0,
       N1 is N-1,
       somaRec(N1, R1),
       R is N+R1.

fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, R):-
        N > 0,
        N1 is N-1,
        N2 is N-2,
        fibonacci(N1, R1),
        fibonacci(N2, R2),
        R is R1+R2. 
 
isPrime(X):-
        X1 is X-1,
        isD(X1, X).

isD(1, _).
isD(Y, X):-
        Y > 0,
        Y1 is Y-1,
        P is (X mod Y),
        P \= 0,
        isD(Y1, X).

list_size([], 0).
list_size([_|R], S):-
        list_size(R, S1),
        S is S1+1.

list_sum([],0).
list_sum([X|R], S):-
        list_sum(R, S1),
        S is S1 + X.

list_prod([],1).
list_prod([X|R], S):-
        list_prod(R, S1),
        S is S1 * X.

inner_product([], _, 1).
inner_product(_, [], 1).
inner_product([X|R], [Y|K], S):-
        inner_product(R, K, S1),
        S is (X*Y) + S1.

count(_, [], 0).
count(Y, [X|R], S):-
        count(Y, R, S1),
        S is S1,
        Y = X -> S is S1+1.