:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').

play :-
    /*menu(Size) */
    initial_state(5, GameState),
    start(GameState).


start(GameState) :-
    display_game(GameState),
    ask_for_move(Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    start(NewGameState).
    

/*
start(GameState) :-
    repeat,
        display_game(GameState),
        ask_for_move(Move),
        move(GameState, Move, NewGameState),
        game_over(NewGameState, Winner),
        (Winner = player1, Winner = player2) -> display_game(NewGameState), !;
        fail,
    start(NewGameState).
*/
