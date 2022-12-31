:- consult('board.pl').

/*move(+GameState, +Move, -NewGameState)*/
move(GameState, Move, NewGameState) :-
    nth0(0, Move, Col),
    nth0(1, Move, Row),
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    get_piece(GameState, Col, Row, Piece),
    %check_turn(PlayerTurn, Piece, Match),
    %check_valid_move(GameState, PlayerTurn, Col, Row, Valid),
    change(GameState, Col, Row, e, NewGameStateTemp),
    change(NewGameStateTemp, NewCol, NewRow, Piece, NewGameState).

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
    get_piece_moves(DuckPositions, ducko, Length, [], DuckMoves),

    find_pieces(GameState, swano, SwanPositions),
    get_piece_moves(SwanPositions, swano, Length, [], SwanMoves),

    append(SwanMoves, DuckMoves, ListOfMoves).

valid_moves(GameState, player2, ListOfMoves):-
    length(GameState, Length),

    find_pieces(GameState, duckt, DuckPositions),
    get_piece_moves(DuckPositions, duckt, Length, [], DuckMoves),

    find_pieces(GameState, swant, SwanPositions),
    get_piece_moves(SwanPositions, swant, Length, [], SwanMoves),

    append(SwanMoves, DuckMoves, ListOfMoves).

valid_moves(_, _, []).

get_piece_moves([], _, _, ListOfMoves, ListOfMoves).
get_piece_moves([Position|T], Piece, Length, ListOfMoves, Result) :-
    nth0(0, Position, Col),
    nth0(1, Position, Row),
    get_valid_moves(Piece, Col, Row, Length, Moves),
    append(ListOfMoves, Moves, ValidMoves),
    get_piece_moves(T, Piece, Length, ValidMoves, Result).

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

/*--------------------------PLAYER 1--------------------------*/

/*DUCK*/

get_valid_moves(ducko, Col, Row, Length, Moves):-
append([Col, Row], [], InitialPosition),
%vertical_para_baixo
NewRow is Row + 1, 
(NewRow < Length) -> 
    append(InitialPosition, [Col, NewRow], FirstOption), append([FirstOption], [], AuxMoves),
    NewCol is Col - 1,
    (NewCol >= 0 -> 
        append(InitialPosition, [NewCol, NewRow], SecondOption), append([SecondOption], AuxMoves, AuxMoves2);
        append([], AuxMoves, AuxMoves2)
    ),
    NewCol1 is Col + 1,
    (NewCol1 < Length ->
        append(InitialPosition, [NewCol1, NewRow], ThirdOption), append([ThirdOption], AuxMoves2, Moves);
        append([], AuxMoves2, Moves)
    ); append([], [], Moves).

/*SWAN*/
get_valid_moves(swano, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_cima
    NewRow is Row - 1, 
    (NewRow >= 0) -> 
        append(InitialPosition, [Col, NewRow], FirstOption), append([FirstOption], [], AuxMoves),
        NewCol is Col - 1,
        (NewCol >= 0 -> 
            append(InitialPosition, [NewCol, NewRow], SecondOption), append([SecondOption], AuxMoves, AuxMoves2);
            append([], AuxMoves, AuxMoves2)
        ),
        NewCol1 is Col + 1,
        (NewCol1 < Length ->
            append(InitialPosition, [NewCol1, NewRow], ThirdOption), append([ThirdOption], AuxMoves2, Moves);
            append([], AuxMoves2, Moves)
        ); append([], [], Moves).

/*--------------------------PLAYER 2--------------------------*/

/*DUCK*/
get_valid_moves(duckt, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_cima
    NewRow is Row - 1, 
    (NewRow >= 0) -> 
        append(InitialPosition, [Col, NewRow], FirstOption), append([FirstOption], [], AuxMoves),
        NewCol is Col - 1,
        (NewCol >= 0 -> 
            append(InitialPosition, [NewCol, NewRow], SecondOption), append([SecondOption], AuxMoves, AuxMoves2);
            append([], AuxMoves, AuxMoves2)
        ),
        NewCol1 is Col + 1,
        (NewCol1 < Length ->
            append(InitialPosition, [NewCol1, NewRow], ThirdOption), append([ThirdOption], AuxMoves2, Moves);
            append([], AuxMoves2, Moves)
        ); append([], [], Moves).

/*SWAN*/
get_valid_moves(swant, Col, Row, Length, Moves):-
append([Col, Row], [], InitialPosition),
%vertical_para_baixo
NewRow is Row + 1, 
(NewRow < Length) -> 
    append(InitialPosition, [Col, NewRow], FirstOption), append([FirstOption], [], AuxMoves),
    NewCol is Col - 1,
    (NewCol >= 0 -> 
        append(InitialPosition, [NewCol, NewRow], SecondOption), append([SecondOption], AuxMoves, AuxMoves2);
        append([], AuxMoves, AuxMoves2)
    ),
    NewCol1 is Col + 1,
    (NewCol1 < Length ->
        append(InitialPosition, [NewCol1, NewRow], ThirdOption), append([ThirdOption], AuxMoves2, Moves);
        append([], AuxMoves2, Moves)
    ); append([], [], Moves).

valid_capture(GameState, Move, Piece):-
    nth0(0, Move, Col),
    nth0(2, Move, NewCol),
    nth0(3, Move, NewRow),
    %em_frente
    (NewCol == Col ->
        (get_piece(GameState, NewCol, NewRow, PositionPiece), PositionPiece \= e ->
            false; true);
    %diagonal_mesma_equipa
        (get_piece(GameState, NewCol, NewRow, PositionPiece), team(Piece, PositionPiece) ->
            false; true)
    ).

/*get_winner(+Player1, +Player2, -Winner)*/
get_winner(true, false, 1).
get_winner(false, true, 2).
get_winner(false, false, 0).

/*
game_over(GameState, Winner):-
    length(GameState, Length),
    nth0(0, GameState, TopRow),
    Ind is Length - 1,
    nth0(Ind, GameState, BottomRow),
    get_winner(member(swant, TopRow), member(swano, BottomRow), Winner).
*/

is_still_playing(GameState, 1):-
    is_piece_present(GameState, duckt); is_piece_present(GameState, swant).
is_still_playing(GameState, 2):-
    is_piece_present(GameState, ducko); is_piece_present(GameState, swano).

/*is_piece_present(+Piece, +GameState)*/
is_piece_present(Piece,[Piece|_]).
is_piece_present(Piece,[A|_]):- is_piece_present(Piece,A).
is_piece_present(Piece,[_|R]):- is_piece_present(Piece,R).