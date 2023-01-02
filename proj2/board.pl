/*
initial_state(+Size, -GameState)
Given a size, it crates and returns the corresponding gamestate
*/
initial_state(Size, GameState) :- 
    S is Size - 2,
    create_line(Size, duckt, [], Line),
    init(Size, S,[Line], Board),
    create_line(Size, ducko, [], Line2),
    add_final(Line2, Board, GameState).

/*
init(+Size, +Col, +CurrentBoard, -FinalBoard)
Constructs the initial board
*/
init(_, 0, FinalBoard, FinalBoard).
init(Size, Col, CurrentBoard, FinalBoard) :-
    Col > 0,
    C is Col - 1,
    create_line(Size, e, [], Line),
    init(Size, C, [Line|CurrentBoard], FinalBoard).

/*
create_line(+Size, +Player, +CurrentLine, +FinalLine)
*/
create_line(0, _, FinalLine, FinalLine).
create_line(Size, Player, CurrentLine, FinalLine) :-
    Size > 0,
    S is Size - 1,
    create_line(S, Player, [Player|CurrentLine], FinalLine).

/*
add_final(+Line, +CurrentBoard, -FinalBoard)
Adds the final line to the current board
*/
add_final([], FinalBoard, FinalBoard).
add_final(Line, CurrentBoard, FinalBoard) :-
    add_final([], [Line|CurrentBoard], FinalBoard).

/*
change(+GameState, +Col, +Row, +Piece, -NewGameState)
Replaces the given cell (col and row) with the piece
*/
change(GameState, Col, Row, Piece, NewGameState) :-
    nth0(Row, GameState, RowList),
    replace(Col, Piece, RowList, NewRowList),
    replace(Row, NewRowList, GameState, NewGameState). 

/*
replace(+I, +L, +List1, -List2)
Replaces the element of index I of List1
*/
replace(0, L, [_|T], [L|T]).
replace(I, L, [H|T], [H|R]) :-
    I > 0,
    I1 is I-1,
    replace(I1, L, T, R).

    