:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').

a :-
    initial_state(5, GameState),
    display_game(GameState),
    ask_for_move(Move),
    move(GameState, Move, NewGameState),
    display_game(NewGameState),
    a.