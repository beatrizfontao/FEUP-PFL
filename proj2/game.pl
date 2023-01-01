:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').

play :-
    /*menu(Size, GameMode) */
    initial_state(5, GameState),
    start(GameState, player1).


start(GameState, PlayerTurn) :-
    playernum(PlayerTurn, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState), 
    ask_for_move(GameState, Move, Valid, PlayerTurn),
    (Valid == false ->nl, write('Invalid Move!'), nl, start(GameState, PlayerTurn), !;
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