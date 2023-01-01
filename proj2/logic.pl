:- consult('board.pl').

/*move(+GameState, +Move, -NewGameState)*/
move(GameState, Move, NewGameState) :-
    nth0(0, Move, Col),
    nth0(1, Move, Row),
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    get_piece(GameState, Col, Row, Piece),
    change(GameState, Col, Row, e, NewGameStateTemp),
    check_upgrade(NewGameStateTemp, NewCol, NewRow, Piece, NewGameState).

/*Vai ser sempre ou 0 para duckt ou Size-1 para ducko?? */
check_upgrade(GameState, Col, Row, Piece, NewGameState) :- 
    length(GameState, S),
    LastRow is S - 1,
    (
        (Piece = duckt, Row =:= 0) -> team(Piece, NewPiece), change(GameState, Col, Row, NewPiece, NewGameState);
        (
            (Piece = ducko, Row =:= LastRow) -> team(Piece, NewPiece), change(GameState, Col, Row, NewPiece, NewGameState);
            change(GameState, Col, Row, Piece, NewGameState)
        )
    ).

game_over(GameState, Winner) :-
    length(GameState, S),
    LastRowNum is S - 1,
    nth0(0, GameState, FirstRow),
    check_game_over(S, LastRowNum, FirstRow, 0, TempWinner),
    (TempWinner == player1 -> Winner = player1, !;
        nth0(LastRowNum, GameState, LastRow),
        check_game_over(S, LastRowNum, LastRow, LastRowNum, TempWinner2),
        (TempWinner2 == player2 -> Winner = player2,!;
            (is_still_playing(GameState, player1) -> 
                (is_still_playing(GameState,player2) -> 
                    Winner = e;
                    Winner = player1 
                );
                Winner = player2
            )
        )
    ).

check_game_over(0,_, _, _, Winner) :- team(e, Winner), !.
check_game_over(Size, BoardSize, [Piece | T], RowNum, Winner) :-
    (Piece = swano, RowNum =:= 0) -> winner(Piece, Winner);
        (
            (Piece = swant, RowNum =:= BoardSize) -> winner(Piece, Winner);
            S is Size - 1,
            check_game_over(S, BoardSize, T, RowNum, Winner)
        )
    .

/*check_turn(+Player, +Piece, -CheckTurn)*/
check_turn(player1, duckt, true).
check_turn(player1, swant, true).
check_turn(player2, ducko, true).
check_turn(player2, swano, true).
check_turn(_, _, false).

/*valid_moves(+GameState, +Player, -ListOfMoves)*/
valid_moves(GameState, player1, ListOfMoves):-
    length(GameState, Length),
    find_pieces(GameState, ducko, DuckPositions),
    get_piece_moves(GameState, DuckPositions, ducko, Length, [], DuckMoves),
    find_pieces(GameState, swano, SwanPositions),
    get_piece_moves(GameState, SwanPositions, swano, Length, [], SwanMoves),
    append(SwanMoves, DuckMoves, ListOfMoves).
valid_moves(GameState, player2, ListOfMoves):-
    length(GameState, Length),
    find_pieces(GameState, duckt, DuckPositions),
    get_piece_moves(GameState, DuckPositions, duckt, Length, [], DuckMoves),
    find_pieces(GameState, swant, SwanPositions),
    get_piece_moves(GameState, SwanPositions, swant, Length, [], SwanMoves),
    append(SwanMoves, DuckMoves, ListOfMoves).
valid_moves(_, _, []).

/*get_piece_mX  oves(+ListOfPositions, +Piece, +Length, +ListOfMoves, -Result) */
get_piece_moves(_, [], _, _, ListOfMoves, ListOfMoves).
get_piece_moves(GameState, [Position|T], Piece, Length, ListOfMoves, Result) :-
    nth0(0, Position, Col),
    nth0(1, Position, Row),
    get_valid_moves(GameState, Piece, Col, Row, Moves),
    append(ListOfMoves, Moves, ValidMoves),
    get_piece_moves(GameState,T, Piece, Length, ValidMoves, Result).

/*find_pieces(+GameState, +Piece, -Positions)*/
find_pieces(GameState, Piece, Positions):-
    get_all_pieces(GameState, 0, Piece, [], Positions).

/*get_all_pieces(+GameState, +CurrentRow, +Piece, +Positions, -Result)*/
get_all_pieces([], _, _, Positions, Positions).
get_all_pieces([Row|T], CurrentRow, Piece, Positions, Result):-
    NextRow is CurrentRow + 1,
    row_pieces(Row, CurrentRow, Piece, NewPositions),
    append(Positions, NewPositions, NewPositions2),
    get_all_pieces(T, NextRow, Piece, NewPositions2, Result).

/*row_pieces(+Row, +RowIndex, +Piece, -Positions)*/
row_pieces(Row, RowIndex, Piece, Result):-
    row_pieces(Row, RowIndex, 0, Piece, [], Result).

/*row_pieces(+Row, +RowIndex, +Col, +Piece, +Positions, -Result)*/
row_pieces([], _, _, _, Positions, Positions).
row_pieces([Piece|T], RowIndex, Col, Piece, Positions, Result):-
    append([[Col, RowIndex]], Positions, NewPositions),
    NextCol is Col + 1,
    row_pieces(T, RowIndex, NextCol, Piece, NewPositions, Result).
row_pieces([_|T], RowIndex, Col, Piece, Positions, Result) :-
    NextCol is Col + 1,
    row_pieces(T, RowIndex, NextCol, Piece, Positions, Result).

/*is_move_valid(+GameState, +PlayerTurn, +Piece, +Move, -Valid)*/
is_move_valid(GameState, PlayerTurn, Move, Valid) :-
    valid_moves(GameState, PlayerTurn, ValidMoves),
    (member(Move, ValidMoves)->
        Valid = true; Valid = false
    ).

/*get_valid_moves(+Piece, +Col, +Row, +Length, -Moves)*/



/*-----------------------------FIRST OPTION-----------------------------*/

get_first_option(GameState, ducko, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewRow is Row + 1,
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, ducko).

get_first_option(GameState, duckt, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    NewRow is Row - 1,
    NewRow >= 0,
    append(InitialPosition, [Col, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, duckt).


get_first_option(GameState, swano, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    NewRow is Row - 1,
    NewRow >= 0,
    append(InitialPosition, [Col, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swano).

get_first_option(GameState, swant, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewRow is Row + 1,
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swant).
    
get_first_option(_, _, _, []).

/*-----------------------------SECOND OPTION-----------------------------*/

get_second_option(GameState, ducko, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col - 1,
    NewRow is Row + 1,
    NewRow < Length,
    NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, ducko).
    
get_second_option(GameState, duckt, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col - 1,
    NewRow is Row - 1,
    NewRow >= 0,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, duckt).

get_second_option(GameState, swano, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col - 1,
    NewRow is Row - 1,
    NewRow >= 0,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swano).

get_second_option(GameState, swant, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col + 1,
    NewRow is Row + 1,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swant).

get_second_option(_, _, _, []).

/*-----------------------------THIRD OPTION-----------------------------*/

get_third_option(GameState, ducko, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col + 1,
    NewRow is Row + 1,
    NewRow < Length,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, ducko).

get_third_option(GameState, duckt, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col + 1,
    NewRow is Row - 1,
    NewRow >= 0,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, duckt).

get_third_option(GameState, swano, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col + 1,
    NewRow is Row - 1,
    NewRow >= 0,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swano).

get_third_option(GameState, swant, InitialPosition, ValidMoves) :-
    nth0(0, InitialPosition, Col),
    nth0(1, InitialPosition, Row),
    length(GameState, Length),
    NewCol is Col + 1,
    NewRow is Row + 1,
    NewRow < Length,
    NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], ValidMoves),
    valid_capture(GameState, ValidMoves, swant).

get_third_option(_, _, _, []).

get_valid_moves(GameState, Piece, Col, Row, Moves):-
    append([Col, Row], [], InitialPosition),
    get_first_option(GameState, Piece, InitialPosition, ValidMoves1),
    get_second_option(GameState, Piece, InitialPosition, ValidMoves2),
    get_third_option(GameState, Piece, InitialPosition, ValidMoves3),
    append([ValidMoves1 , ValidMoves2], [ValidMoves3], TempMoves),
    remove_empty_lists(TempMoves, [], Moves).

valid_capture(GameState, Move, _):-
    nth0(0, Move, Col),
    nth0(2, Move, NewCol),
    NewCol == Col,
    is_front_empty(GameState, Move).

 valid_capture(GameState, Move, Piece):-
    nth0(0, Move, Col),
    nth0(2, Move, NewCol),
    NewCol \= Col,   
    is_different_team(GameState, Move, Piece).

is_front_empty(GameState, Move) :-
    nth0(0, Move, Col),
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    NewCol == Col,
    get_piece(GameState, NewCol, NewRow, PositionPiece), 
    PositionPiece == e.

is_different_team(GameState, Move, Piece) :-
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    get_piece(GameState, NewCol, NewRow, PositionPiece),
    (different_team(Piece, PositionPiece); PositionPiece == e).
    

is_still_playing(GameState, player1):-
    is_piece_present(ducko, GameState); is_piece_present(swano, GameState).
is_still_playing(GameState, player2):-
    is_piece_present(duckt, GameState); is_piece_present(swant, GameState).

/*is_piece_present(+Piece, +GameState)*/
is_piece_present(Piece,[Piece|_]).
is_piece_present(Piece,[A|_]):- is_piece_present(Piece,A).
is_piece_present(Piece,[_|R]):- is_piece_present(Piece,R).

remove_empty_lists([], FinalList, FinalList).
remove_empty_lists([[]|T], List, Result) :- remove_empty_lists(T, List, Result).
remove_empty_lists([H|T], List, Result) :- 
    append([H], List, TempList),
    remove_empty_lists(T, TempList, Result).
