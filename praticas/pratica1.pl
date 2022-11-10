male(frank).
male(phil).
male(luke).
male(dylan).
male(george).
male(mitchell).
male(jay).
male(joe).
male(manny).
male(javier).
male(rexford).
male(cameron).
male(bo).
male(calhoun).
male(merle).

female(dede).
female(grace).
female(haley).
female(poppy).
female(claire).
female(alex).
female(gloria).
female(lily).
female(pameron).
female(barb).

parent(grace, phil).
parent(frank, phil).

parent(phil, haley).
parent(phil, alex).
parent(phil, luke).
parent(claire, haley).
parent(claire, alex).
parent(claire, luke).

parent(haley, george).
parent(haley, poppy).
parent(dylan, george).
parent(dylan, poppy).

parent(dede, claire).
parent(dede, mitchell).
parent(jay, claire).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(gloria, manny).
parent(javier, manny).

parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).

parent(barb, cameron).
parent(barb, pameron).
parent(merle, cameron).
parent(merle, pameron).

parent(pameron, calhoun).
parent(bo, calhoun).

married(grace, frank).
married(frank, grace).

married(dylan, haley).
married(haley, dylan).

married(phil, claire).
married(claire, phil).

married(mitchell, cameron).
married(cameron, mitchell).

married(jay, gloria).
married(gloria, jay).

married(barb, merle).
married(merle, barb).

married(pameron, bo).
married(bo, pameron).

father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- grandparent(X, Y), female(X).
siblings(X, Y) :- parent(Z, X), parent(Z, Y), parent(K, X), parent(K, Y), K \= Z, X \= Y.
halfsiblings(X, Y) :- parent(A, X), parent(B, X), parent(A, Y), parent(C, Y), B \= C, C \= A, B \= A.
cousins(X, Y) :- parent(A, X), parent(B, Y), siblings(A, B), A \= B.
uncle(X, Y) :- parent(A, Y), siblings(X, A), male(X);
               parent(A, Y), siblings(B, A), married(X, B), male(X).
