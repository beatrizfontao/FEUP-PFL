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

game_mode_choice(pvai, random, pvrandomai).
game_mode_choice(pvai, greedy, pvgreedyai).
game_mode_choice(aivai, random, randomaivai).
game_mode_choice(aivai, greedy, greedyaivai).

game_choice(pvp, pvp).
game_choice(pvai, GameMode) :-
    display_bot_difficulty(TempGameMode),
    game_mode_choice(pvai, TempGameMode, GameMode).
game_choice(aivai, GameMode) :-
    display_bot_difficulty(TempGameMode),
    game_mode_choice(aivai, TempGameMode, GameMode).

menu(Size, GameMode) :-
    display_main_menu(TempGameMode),
    game_choice(TempGameMode, GameMode),
    choose_size(Size).

menu_header :-
    write('\33\[2J'),
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
    read_input(Mode),
    nl,
    mode(Mode, GameMode).

mode(Input, GameMode) :-
    Input > 0,
    Input < 5,
    game_mode(Input, GameMode), !.

mode(_, GameMode) :-
    write('                             Choose a valid Game Mode(1,2,3 or 4)!'), nl,
    choose_game_mode(GameMode).

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
    read_input(Mode),
    bot_mode(Mode, GameMode).

bot_mode(Input, GameMode) :-
    Input > 0,
    Input < 3,
    difficulty(Input, GameMode), !.

bot_mode(_, GameMode) :-
    write('                            Choose a valid difficulty(1 or 2)!'), nl,
    choose_bot_difficulty(GameMode).

choose_size(Size) :-
    nl, write('                               Choose Board Size (between 5 and 12):'),
    read_input(TempSize), nl,
    size(TempSize, Size).

size(Input, Size) :-
    Input < 13,
    Input > 4,
    Size is Input, !.

size(_, Size) :-
    write('                               Choose a valid size(between 5 and 12)!'), nl,
    choose_size(Size).

read_input(FinalInput) :-
    read_line(Input),
    atom_codes(TempInput, Input),
    atom_chars(TempInput, ListChars),
    number_chars(FinalInput, ListChars).