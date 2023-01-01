
game_mode(1, pvp).
game_mode(2, pvai).
game_mode(3, aivai).
game_mode(4, instructions).
game_mode(5, randomaivai).
game_mode(6, greedyaivai).
game_mode(7, pvrandomai).
game_mode(8, pvgreedyai).

difficulty(1, random).
difficulty(2, greedy).

menu(Size, GameMode) :-
    Size is 5,
    display_main_menu(TempGameMode),
    ((TempGameMode == pvai; TempGameMode == aivai) -> 
        (display_bot_difficulty(TempGameMode2) ->
            (TempGameMode == pvai, TempGameMode2 == random) -> GameMode = pvrandomai;
            (TempGameMode == pvai, TempGameMode2 == greedy) -> GameMode = pvgreedyai;
            (TempGameMode == aivai, TempGameMode2 == random) -> GameMode = randomaivai;
            (TempGameMode == aivai, TempGameMode2 == greedy) -> GameMode = greedyaivai;
            !
        );
        GameMode = pvp
    ).

menu_header :-
    write('                                                                         ,-"" "".'),nl,
    write('                                                                       ,\'  ____  `.'),nl,
    write('   _   _      _        ___          _                                ,\'  ,\'    `.  `._'),nl,
    write('  | | | |__ _| |_  _  |   \x5c\ _  _ __| |__     (`.         _..--.._   ,\'  ,\'        \x5c\    \x5c\ '),nl,
    write('  | |_| / _` | | || | | |) | || / _| / /    (`-.\x5c\    .-""        ""\'   /          ( u _u'),nl,
    write('   \x5c\___/\x5c\__, |_|\x5c\_, | |___/ \x5c\_,_\x5c\__|_\x5c\_\x5c\   (`._  `-"" ,._             (            `-(   \x5c\ '),nl,
    write('        |___/   |__/                       <_  `     (  <`<            \x5c\              `-._\x5c\ '),nl,
    write('                                             (__        (_<_<          ;'),nl,
    write('---------------------------------------------`----------------------------------------------'),nl, nl, nl.

%MainMenu
display_main_menu(GameMode) :-
    menu_header,
    main_menu_options,
    choose_game_mode(GameMode).

main_menu_options :-
    write('                                            Menu'),nl,nl,
    write('                                   * 1. Player vs Player *'),nl,
    write('                                    * 2. Player vs Bot *'),nl,
    write('                                      * 3. Bot vs Bot *'),nl,
    write('                                     * 4. Instructions *'),nl,nl.

choose_game_mode(GameMode) :-
    write('                                    Choose the Game Mode:'),
    read_col(Mode),
    nl,
    (Mode \= 1, Mode \= 2, Mode \= 3, Mode \= 4-> 
        write('                             Choose a valid Game Mode(1,2,3 or 4)!'), nl,
        choose_game_mode(GameMode), !;
        game_mode(Mode, GameMode)
    ).

%BotMenu

display_bot_difficulty(GameMode) :-
    menu_header,
    difficulty_menu_options,
    choose_bot_difficulty(GameMode).

difficulty_menu_options :-
    write('                                        Bot Difficulty:'),nl, nl,  
    write('                                      * 1. Level 1 Bot *'),nl,
    write('                                      * 2. Level 2 Bot *'),nl,nl.

choose_bot_difficulty(GameMode) :-
    write('                                    Choose Bot Difficulty:'),
    read_col(Mode),
    (Mode \= 1, Mode \= 2 -> 
        write('                            Choose a valid difficulty(1 or 2)!'), nl,
        choose_bot_difficulty(GameMode), !;
        difficulty(Mode, GameMode)
    ).