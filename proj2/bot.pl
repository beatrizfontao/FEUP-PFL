:- consult('logic.pl').

/*value(+GameState, +Player, -Value)*/
value(GameState, Player, Value) :-
    get_total_value(GameState, Player, 0, Value).

/*get_total_value(+GameState, +Player, +Value, -Result)*/
get_total_value([], _, Value, Value).
get_total_value([Row|T], Player, Value, Result) :-
    get_row_value(Row, Player, RowValue),
    NewValue is Value + RowValue,
    get_total_value(T, Player, NewValue, Result).

/*get_row_value(+Row, +Player, -Value)*/
get_row_value(Row, Player, Value) :-
    get_row_value(Row, Player, 0, Value).
get_row_value([], _, Value, Value).
get_row_value([Piece|T], Player, Value, Result) :-
    (piece(Player, Piece) ->
        (value(Piece, PieceValue),
        NewValue is Value + PieceValue,
        get_row_value(T, Player, NewValue, Result));
        get_row_value(T, Player, Value, Result)
    ).

/*choose_move(+GameState, +Player, +Level, -Move)*/
choose_move(GameState, Player, 2, Move) :-
    valid_moves(GameState, Player, ListOfMoves),
    get_best_move(GameState, ListOfMoves, Player, 0, [], Move).
    
/*get_best_move(+GameState, +ListOfMoves, +Player, +MaxAdvantage, +CurrentBestMove, -BestMove)*/
get_best_move(_, [], _, _, CurrentBestMove, CurrentBestMove).
get_best_move(GameState, [Move|T], Player, MaxAdvantage, CurrentBestMove, BestMove) :-
    move(GameState, Move, GameStateTemp),
    check_values(GameStateTemp, Player, Advantage),
    nth0(0, Move, Col),
    nth0(1, Move, Row),
    get_piece(GameState, Col, Row, Piece),
    (MaxAdvantage < Advantage -> 
        (valid_capture(GameState, Move, Piece) ->
            get_best_move(GameState, T, Player, Advantage, Move, BestMove);
            get_best_move(GameState, T, Player, MaxAdvantage, CurrentBestMove, BestMove)
            );
        get_best_move(GameState, T, Player, MaxAdvantage, CurrentBestMove, BestMove)
    ).

/*check_values(+GameState, +Player, -Advantage)*/
check_values(GameState, Player, Advantage) :-
    enemy(Player, Enemy),
    value(GameState, Player, PlayerValue),
    value(GameState, Enemy, EnemyValue),
    Advantage is PlayerValue - EnemyValue.

