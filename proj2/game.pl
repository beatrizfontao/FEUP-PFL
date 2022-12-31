:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').

play :-
    /*menu(Size) */
    initial_state(5, GameState),
    start(GameState, player1).


start(GameState, PlayerTurn) :-
    display_game(GameState),
    ask_for_move(GameState, Move, Valid, PlayerTurn),
    (Valid == false -> write('Invalid Move! You have to move one of your pieces, '), write(PlayerTurn), nl, start(GameState, PlayerTurn), !;
        move(GameState, Move, NewGameState),
        turn(PlayerTurn, NewPlayerTurn),
        game_over(NewGameState, Winner),
        (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
            (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
                turn(PlayerTurn, NewPlayerTurn),
                start(NewGameState, NewPlayerTurn)
            )
        )
    ).
