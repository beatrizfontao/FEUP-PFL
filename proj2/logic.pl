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

check_turn(1, duckt, true).
check_turn(1, swant, true).
check_turn(2, ducko, true).
check_turn(2, swano, true).
check_turn(_, _, false).

/*
valid_moves(GameState, Piece, ListOfMoves):-
    length(GameState, Length),
    Col is,
    Row is,
    findall(Piece, get_valid_move(Piece, Col, Row, Length, Move), ListOfMoves).
*/

/*
Dimensões do tabuleiro? - verificar se passa dos limites

PLAYER 1:
duckt: pode descer na vertical ou na diagonal:
- Col igual, Row + 1
- Col - 1, Row + 1 
- Col + 1, Row + 1
swant: pode subir na vertical ou na diagonal:
- Col igual, Row - 1
- Col - 1, Row - 1 
- Col + 1, Row - 1

PLAYER 2:
ducko: pode subir na vertical ou na diagonal:
- Col igual, Row - 1
- Col - 1, Row - 1 
- Col + 1, Row - 1
swano: pode descer na vertical ou na diagonal:
- Col igual, Row + 1
- Col - 1, Row + 1 
- Col + 1, Row + 1
*/ 

/*--------------------------PLAYER 1--------------------------*/

/*DUCK*/

get_valid_moves(duckt, _, Length - 1, Length, []).
get_valid_moves(duckt, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_baixo
    NewRow is Row + 1, 
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], FirstOption),
    %diagonal_para_baixo_esquerda
    NewCol is Col - 1, 
    NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], SecondOption),
    %diagonal_para_baixo_direita
    NewCol1 is Col + 1, 
    NewCol1 < Length,
    append(InitialPosition, [NewCol1, NewRow], ThirdOption),
    append([[FirstOption]], [[SecondOption],[ThirdOption]], Moves).

/*SWAN*/
get_valid_moves(swant, _, 0, _, []).
get_valid_moves(swant, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_cima
    NewRow is Row - 1, 
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], FirstOption),
    %diagonal_para_cima_esquerda
    NewCol is Col - 1, 
    NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], SecondOption),
    %diagonal_para_cima_direita
    NewCol1 is Col + 1, 
    NewCol1 < Length,
    append(InitialPosition, [NewCol1, NewRow], ThirdOption),
    append([[FirstOption]], [[SecondOption],[ThirdOption]], Moves).

/*--------------------------PLAYER 2--------------------------*/

/*DUCK*/
get_valid_moves(ducko, _, 0, _, []).
get_valid_moves(ducko, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_baixo
    NewRow is Row - 1, 
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], FirstOption),
    %diagonal_para_cima_esquerda
    NewCol is Col - 1, 
    NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], SecondOption),
    %diagonal_para_cima_direita
    NewCol1 is Col + 1, 
    NewCol1 < Length,
    append(InitialPosition, [NewCol1, NewRow], ThirdOption),
    append([[FirstOption]], [[SecondOption],[ThirdOption]], Moves).

/*SWAN*/
get_valid_moves(swano, _, Length - 1, Length, []).
get_valid_moves(swano, Col, Row, Length, Moves):-
    append([Col, Row], [], InitialPosition),
    %vertical_para_baixo
    NewRow is Row + 1, 
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], FirstOption),
    %diagonal_para_baixo_esquerda
    NewCol is Col - 1, 
    NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], SecondOption),
    %diagonal_para_baixo_direita
    NewCol1 is Col + 1, 
    NewCol1 < Length,
    append(InitialPosition, [NewCol1, NewRow], ThirdOption),
    append([[FirstOption]], [[SecondOption],[ThirdOption]], Moves).

/*get_winner(Player1, Player2, Winner)*/
get_winner(true, false, Player1).
get_winner(false, true, Player2).
get_winner(false, false, None).
/*
game_over(GameState, Winner):-
    length(GameState, Length),
    nth0(0, GameState, TopRow),
    nth0(2, GameState, BottomRow),
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