:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

:- consult('input.pl').
:- consult('logic.pl').
:- consult('menu.pl').
:- consult('bot.pl').

play :-
    menu(Size, GameMode),
    initial_state(Size, GameState),
    start(GameMode, GameState, player1).

start(pvp, GameState, PlayerTurn) :-
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

start(pvgreedyai, GameState, player1) :-
    playernum(player1, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState), 
    ask_for_move(GameState, Move, Valid, player1),
    (Valid == false ->nl, write('Invalid Move!'), nl, start(GameState, player1), !;
        move(GameState, Move, NewGameState),
        turn(player1, NewPlayerTurn),
        game_over(NewGameState, Winner),
        (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
            (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
                turn(player1, NewPlayerTurn),
                start(pvgreedyai, NewGameState, NewPlayerTurn)
            )
        )
    ).

start(pvgreedyai, GameState, player2) :-
    sleep(2),
    playernum(player2, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState), 
    choose_move(GameState, player2, 2, Move),
    move(GameState, Move, NewGameState),
    turn(player2, NewPlayerTurn),
    game_over(NewGameState, Winner),
    (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
        (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
            turn(player2, NewPlayerTurn),
            start(pvgreedyai, NewGameState, NewPlayerTurn)
        )
    ).

start(greedyaivai, GameState, PlayerTurn) :-
    sleep(2),
    playernum(PlayerTurn, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState), 
    choose_move(GameState, PlayerTurn, 2, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
        (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
            turn(PlayerTurn, NewPlayerTurn),
            start(greedyaivai, NewGameState, NewPlayerTurn)
        )
    ).

start(pvrandomai, GameState, player1) :-
    playernum(player1, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState), 
    ask_for_move(GameState, Move, Valid, player1),
    (Valid == false ->nl, write('Invalid Move!'), nl, start(GameState, player1), !;
        move(GameState, Move, NewGameState),
        turn(player1, NewPlayerTurn),
        game_over(NewGameState, Winner),
        (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
            (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
                turn(player1, NewPlayerTurn),
                start(pvrandomai, NewGameState, NewPlayerTurn)
            )
        )
    ).

start(pvrandomai, GameState, player2) :-
    sleep(1),
    playernum(player2, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    choose_move(GameState, player2, 1, Move),
    move(GameState, Move, NewGameState),
    turn(player2, NewPlayerTurn),
    game_over(NewGameState, Winner),
    (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
        (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
            turn(player2, NewPlayerTurn),
            start(pvrandomai, NewGameState, NewPlayerTurn)
        )
    ).

start(randomaivai, GameState, PlayerTurn) :-
    sleep(2),
    playernum(PlayerTurn, N),
    write('\33\[2J'), nl, write('Player '),  write(N), write(' turn'), nl, nl,
    display_game(GameState),
    choose_move(GameState, PlayerTurn, 1, Move),
    move(GameState, Move, NewGameState),
    game_over(NewGameState, Winner),
    (Winner == player1 -> display_game(NewGameState), write('Player 1 Wins!'), !;
        (Winner == player2 -> display_game(NewGameState), write('Player 2 Wins!'), !;
            turn(PlayerTurn, NewPlayerTurn),
            start(randomaivai, NewGameState, NewPlayerTurn)
        )
    ).
