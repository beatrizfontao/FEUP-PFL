game_mode(1, pvp).
game_mode(2, pvai).
game_mode(3, aivai).

game_mode(4, pvGoodAI).
game_mode(5, pvBadAI).


game_mode(4, BadAIvBadAI).
game_mode(5, BadAIvGoodAI).
game_mode(6, GoodAIvGoodAI).

menu(Size, GameMode) :-
    display_menu,
    choose_game_mode(TempGameMode),
    ((TempGameMode == pvai; TempGameMode == aivai) -> choose_ai_difficulty(TempGameMode, GameMode);
        GameMode = pvp
    ),
    choose_board_size(Size).

