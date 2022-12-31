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
    (TempWinner == ducko -> Winner = player1, !;
        nth0(LastRowNum, GameState, LastRow),
        check_game_over(S, LastRowNum, LastRow, LastRowNum, TempWinner2),
        (TempWinner2 == duckt -> Winner = player2,!;
            Winner = e
        )
    )
    .

check_game_over(0,_, _, _, Winner) :- team(e, Winner), !.
check_game_over(Size, BoardSize, [Piece | T], RowNum, Winner) :-
    (Piece = swano, RowNum =:= 0) -> team(Winner, Piece);
        (
            (Piece = swant, RowNum =:= BoardSize) -> team(Winner, Piece);
            S is Size - 1,
            check_game_over(S, BoardSize, T, RowNum, Winner)
        )
    .