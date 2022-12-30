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
check_turn(2, ducko, true).
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

get_valid_moves(duckt, Length - 1, Length - 1, Length, []).
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

/*
%vertical_para_baixo
get_valid_move(duckt, Col, Row, Length, Move):-
    append([Col, Row], [], InitialPosition),
    NewRow is Row + 1,
    NewRow < Length,
    append(InitialPosition, [Col, NewRow], Move).

%diagonal_para_baixo_esquerda
get_valid_move(duckt, Col, Row, Length, Move):-
    append([Col, Row], [], InitialPosition),
    NewRow is Row + 1, NewRow < Length,
    NewCol is Col - 1, NewCol >= 0,
    append(InitialPosition, [NewCol, NewRow], Move).

%diagonal_para_baixo_direita
get_valid_move(duckt, Col, Row, Length, Move):-
    append([Col, Row], [], InitialPosition),
    NewRow is Row + 1, NewRow < Length,
    NewCol is Col + 1, NewCol < Length,
    append(InitialPosition, [NewCol, NewRow], Move).
*/
/*SWAN*/

%vertical_para_cima
get_valid_move(swant, Col, Row, _, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    append([Col, NewRow], Move, Move).

%diagonal_para_cima_esquerda
get_valid_move(swant, Col, Row, _, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    NewCol is Col - 1, NewCol >= 0,
    append([NewCol, NewRow], Move, Move).

%diagonal_para_cima_direita
get_valid_move(swant, Col, Row, Length, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    NewCol is Col + 1, NewCol < Length,
    append([Col, NewRow], Move, Move).
    
/*--------------------------PLAYER 2--------------------------*/

/*DUCK*/

%vertical_para_cima
get_valid_move(ducko, Col, Row, _, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    append([Col, NewRow], Move, Move).

%diagonal_para_cima_esquerda
get_valid_move(ducko, Col, Row, _, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    NewCol is Col - 1, NewCol >= 0,
    append([NewCol, NewRow], Move, Move).

%diagonal_para_cima_direita
get_valid_move(ducko, Col, Row, Length, Move):-
    append([Col, Row], [], Move),
    NewRow is Row - 1, NewRow >= 0,
    NewCol is Col + 1, NewCol < Length,
    append([Col, NewRow], Move, Move).

/*SWAN*/

%vertical_para_baixo
get_valid_move(swano, Col, Row, Length, Move):-
    append([Col, Row], [], Move),
    NewRow is Row + 1, NewRow < Length,
    append([Col, NewRow], Move, Move).

%diagonal_para_baixo_esquerda
get_valid_move(swano, Col, Row, Length, Move):-
    append([Col, Row], [], Move),
    NewRow is Row + 1, NewRow < Length,
    NewCol is Col - 1, NewCol >= 0,
    append([NewCol, NewRow], Move, Move).

%diagonal_para_baixo_direita
get_valid_move(swano, Col, Row, Length, Move):-
    append([Col, Row], [], Move),
    NewRow is Row + 1, NewRow < Length,
    NewCol is Col + 1, NewCol < Length,
    append([NewCol, NewRow], Move, Move).   


check_game_over(GameState):-
    length(GameState, Length),
    nth0(0, GameState, TopRow),
    member(swano, TopRow),
    nth0(Length-1, GameState, BottomRow),
    member(swant, BottomRow).