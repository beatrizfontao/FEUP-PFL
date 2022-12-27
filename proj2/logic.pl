:- consult('board.pl').

/*move(+GameState, +Move, -NewGameState)*/
move(GameState, Move, NewGameState) :-
    nth0(0, Move, Col),
    nth0(1, Move, Row),
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    get_piece(GameState, Col, Row, Piece),
    %check_turn(),
    %check_valid_move(),
    change(GameState, Col, Row, e, NewGameStateTemp),
    change(NewGameStateTemp, NewCol, NewRow, Piece, NewGameState).