:- consult('display.pl').

initial_state(Size, GameState) :- 
    S is Size - 2,
    create_line(Size, duckt, [], Line),
    init(Size, S,[Line], Board),
    create_line(Size, ducko, [], Line2),
    add_final(Line2, Board, GameState).

init(_, 0, FinalBoard, FinalBoard).
init(Size, Col, CurrentBoard, FinalBoard) :-
    Col > 0,
    C is Col - 1,
    create_line(Size, e, [], Line),
    init(Size, C, [Line|CurrentBoard], FinalBoard).

create_line(0, _, FinalLine, FinalLine).
create_line(Size, Player, CurrentLine, FinalLine) :-
    Size > 0,
    S is Size - 1,
    create_line(S, Player, [Player|CurrentLine], FinalLine).

add_final([], FinalBoard, FinalBoard).
add_final(Line, CurrentBoard, FinalBoard) :-
    add_final([], [Line|CurrentBoard], FinalBoard).

% Define a predicate to change an element in the matrix
change(GameState, Col, Row, Piece, NewGameState) :-
    nth0(Row, GameState, RowList),
    replace(Col, Piece, RowList, NewRowList),
    replace(Row, NewRowList, GameState, NewGameState). 

% Define a predicate to replace an element in a list
replace(0, L, [_|T], [L|T]).
replace(I, L, [H|T], [H|R]) :-
    I > 0,
    I1 is I-1,
    replace(I1, L, T, R).

    