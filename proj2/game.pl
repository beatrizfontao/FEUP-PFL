:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').
:- consult('menu.pl').
:- consult('bot.pl').
:- consult('board.pl').
:- consult('utils.pl').
:- consult('display.pl').

/*
Displays the menu, builds the initial board and starts the game
*/
play :-
    menu(Size, GameMode),
    initial_state(Size, GameState),
    start(GameMode, GameState, player1).

/*
display(+PlayerTurn, +GameState)
Displays the turn of the current player and displays the board
*/
display(PlayerTurn, GameState) :-
    playernum(PlayerTurn, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState).

/*
check_winner(+GameState, +Winner, +PlayerTurn, +GameMode)
Checks if any of the players (1 or 2) won the game. If none won (e), the game continues
*/
check_winner(GameState, player1, _, _) :-
    write('\33\[2J'),
    nl, write('Player 1 Wins!'), nl, 
    display_game(GameState), !.
check_winner(GameState, player2, _, _) :-
    write('\33\[2J'),
    nl, write('Player 2 Wins!'), nl, 
    display_game(GameState), !.
check_winner(GameState, e, PlayerTurn, GameMode) :-
    turn(PlayerTurn, NewPlayerTurn),
    start(GameMode, GameState, NewPlayerTurn).

/*
check_valid_move(+Valid, +GameMode, +GameState, +PlayerTurn, +Move):-
Either performs the move the current player choose and checks if the game is over, or informs the user the move they were trying to make is invalid and asks for their input again
*/
check_valid_move(false, GameMode, GameState, PlayerTurn, _):-
    nl, write('Invalid Move!'), nl, 
    sleep(1),
    start(GameMode, GameState, PlayerTurn), !.
check_valid_move(true, GameMode, GameState, PlayerTurn, Move):-
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    check_winner(NewGameState, Winner, PlayerTurn, GameMode).

/*
start(+GameMode, +GameState, +PlayerTurn)
starts a round of the specified Game Mode with the board Game State and correct player turn
*/

/*-----------------------------Player vs Player-----------------------------*/
start(pvp, GameState, PlayerTurn) :-
    display(PlayerTurn, GameState),
    ask_for_move(GameState, PlayerTurn, Move, Valid),
    check_valid_move(Valid, pvp, GameState, PlayerTurn, Move).

/*-----------------------------Player vs Greedy Bot-----------------------------*/
start(pvgreedyai, GameState, player1) :-
    display(player1, GameState), 
    ask_for_move(GameState, player1, Move, Valid),
    check_valid_move(Valid, pvgreedyai, GameState, player1, Move).
start(pvgreedyai, GameState, player2) :-
    sleep(1),
    display_game(player2, GameState), 
    choose_move(GameState, player2, 2, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    check_winner(NewGameState, Winner, player2, pvgreedyai).

/*-----------------------------Greedy Bot vs Greedy Bot-----------------------------*/
start(greedyaivai, GameState, PlayerTurn) :-
    sleep(3),
    display(PlayerTurn, GameState), 
    choose_move(GameState, PlayerTurn, 2, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    check_winner(NewGameState, Winner, PlayerTurn, greedyaivai).

/*-----------------------------Player vs Random Bot-----------------------------*/
start(pvrandomai, GameState, player1) :-
    display_game(player1, GameState), 
    ask_for_move(GameState, player1, Move, Valid),
    check_valid_move(Valid, pvrandomai, GameState, player1, Move).

start(pvrandomai, GameState, player2) :-
    sleep(1),
    playernum(player2, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    choose_move(GameState, player2, 1, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    check_winner(NewGameState, Winner, player2, pvrandomai).

/*-----------------------------Random Bot vs Random Bot-----------------------------*/
start(randomaivai, GameState, PlayerTurn) :-
    sleep(3),
    display_game(PlayerTurn, GameState),
    choose_move(GameState, PlayerTurn, 1, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    check_winner(NewGameState, Winner, PlayerTurn, randomaivai).
