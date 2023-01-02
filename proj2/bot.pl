:- consult('logic.pl').

/*
value(+GameState, +Player, -Value)
Returns the value of the given gamestate
*/
value(GameState, Player, Value) :-
    get_total_value(GameState, Player, 0, Value).

/*
get_total_value(+GameState, +Player, +Value, -Result)
Given gamestate, it sums the player's value
*/
get_total_value([], _, Value, Value).
get_total_value([Row|T], Player, Value, Result) :-
    get_row_value(Row, Player, RowValue),
    NewValue is Value + RowValue,
    get_total_value(T, Player, NewValue, Result).

/*
get_row_value(+Row, +Player, -Value)
Given a row, it returns the player's value
*/
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

/*
choose_move(+GameState, +Player, +Level, -Move)
Given a gamestate, a player and a level of difficulty(random or greedy), it returns the move to be performed
*/
choose_move(GameState, Player, 2, Move) :-
    length(GameState, Length),
    valid_moves(GameState, Player, ListOfMoves),
    MaxAdvantage is (-10) * Length,
    get_best_move(GameState, ListOfMoves, Player, MaxAdvantage, [], Move).

choose_move(GameState, Player, 1, Move) :-
    valid_moves(GameState, Player, ListOfMoves),
    length(ListOfMoves, Size),
    random(0, Size, ChosenMove),
    nth0(ChosenMove, ListOfMoves, Move).

/*
get_best_move(+GameState, +ListOfMoves, +Player, +MaxAdvantage, +CurrentBestMove, -BestMove)
Looks for the best move in order to give the player the maximum advantage
*/
get_best_move(_, [], _, _, CurrentBestMove, CurrentBestMove).
get_best_move(GameState, [Move|T], Player, MaxAdvantage, CurrentBestMove, BestMove) :-
    move(GameState, Move, GameStateTemp),
    check_values(GameStateTemp, Player, Advantage),
    (MaxAdvantage =< Advantage -> 
        get_best_move(GameState, T, Player, Advantage, Move, BestMove);
        get_best_move(GameState, T, Player, MaxAdvantage, CurrentBestMove, BestMove)
    ).

/*
check_values(+GameState, +Player, -Advantage)
Calculates the player's advantage to their opponent
*/
check_values(GameState, Player, Advantage) :-
    enemy(Player, Enemy),
    value(GameState, Player, PlayerValue),
    value(GameState, Enemy, EnemyValue),
    Advantage is PlayerValue - EnemyValue.