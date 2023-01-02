/*
Main Menu Game Modes (pvp, pvai and aivsai)
*/
game_mode(1, pvp).
game_mode(2, pvai).
game_mode(3, aivai).

/*
Menu option for difficulty
*/
difficulty(1, random).
difficulty(2, greedy).

/*
Specific game mode for p vs bot and bot vs bot based on difficulty 
*/
game_mode_choice(pvai, random, pvrandomai).
game_mode_choice(pvai, greedy, pvgreedyai).
game_mode_choice(aivai, random, randomaivai).
game_mode_choice(aivai, greedy, greedyaivai).

/*
game_choice(+Mode, -GameMode)
Game mode chosen by the user. If the game involves bots, also chooses difficulty
*/
game_choice(pvp, pvp).
game_choice(pvai, GameMode) :-
    display_bot_difficulty(TempGameMode),
    game_mode_choice(pvai, TempGameMode, GameMode).
game_choice(aivai, GameMode) :-
    display_bot_difficulty(TempGameMode),
    game_mode_choice(aivai, TempGameMode, GameMode).

/*
menu(-Size, -Size)
Displays the Main Menu and makes the user choose the Game Mode and the Size of the board
*/
menu(Size, GameMode) :-
    display_main_menu(TempGameMode),
    game_choice(TempGameMode, GameMode),
    choose_size(Size).

/*
Displays on screen the title of the game
*/
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

/*
Displays on screen the Main Menu options
*/
main_menu_options :-
    write('                                            Menu'),nl,nl,
    write('                                   * 1. Player vs Player *'),nl,
    write('                                    * 2. Player vs Bot *'),nl,
    write('                                      * 3. Bot vs Bot *'),nl,nl.

/*
Displays on screen the Bot Difficulty options
*/
difficulty_menu_options :-
    write('                                        Bot Difficulty:'),nl, nl,  
    write('                                      * 1. Level 1 Bot *'),nl,
    write('                                      * 2. Level 2 Bot *'),nl,nl.

/*
display_main_menu(-GameMode)
Displays the title and Main Menu options and makes the user choose the Game Mode
*/
display_main_menu(GameMode) :-
    menu_header,
    main_menu_options,
    choose_game_mode(GameMode).

/*
choose_game_mode(-GameMode)
Reads the input of the user and chooses the Game Mode based on their choice
*/
choose_game_mode(GameMode) :-
    write('                                    Choose the Game Mode:'),
    read_input(Mode),
    nl,
    mode(Mode, GameMode).

/*
mode(+Input, -GameMode)
Checks if the input is valid and chooses the Game Mode based on their choice
*/
mode(Input, GameMode) :-
    Input > 0,
    Input < 5,
    game_mode(Input, GameMode), !.
mode(_, GameMode) :-
    write('                             Choose a valid Game Mode(1,2,3 or 4)!'), nl,
    choose_game_mode(GameMode).

/*
display_bot_difficulty(-GameMode)
Displays the title and Bot Difficulty options and makes the user choose the difficulty
*/
display_bot_difficulty(GameMode) :-
    menu_header,
    difficulty_menu_options,
    choose_bot_difficulty(GameMode).

/*
choose_bot_difficulty(-GameMode)
Reads the input of the user and chooses the Bot Difficulty based on their choice
*/
choose_bot_difficulty(GameMode) :-
    write('                                    Choose Bot Difficulty:'),
    read_input(Mode),
    bot_mode(Mode, GameMode).

/*
bot_mode(+Input, -GameMode)
Checks if the input is valid and chooses the Game Mode with the correct bot difficulty based on their choice
*/
bot_mode(Input, GameMode) :-
    Input > 0,
    Input < 3,
    difficulty(Input, GameMode), !.
bot_mode(_, GameMode) :-
    write('                            Choose a valid difficulty(1 or 2)!'), nl,
    choose_bot_difficulty(GameMode).

/*
choose_size(-Size)
Reads the input of the user and chooses the Size of the board based on their choice
*/
choose_size(Size) :-
    nl, write('                           Choose Board Size (between 5 and 12):'),
    read_input(TempSize), nl,
    size(TempSize, Size).

/*
size(+Input, -Size)
Checks if the input is valid and chooses the Size of the board based on the input
*/
size(Input, Size) :-
    Input < 13,
    Input > 4,
    Size is Input, !.
size(_, Size) :-
    write('                               Choose a valid size(between 5 and 12)!'), nl,
    choose_size(Size).

/*
read_input(-FinalInput)
Reads the input of the user for the menu options and transforms them in an integer
*/
read_input(FinalInput) :-
    read_line(Input),
    atom_codes(TempInput, Input),
    atom_chars(TempInput, ListChars),
    number_chars(FinalInput, ListChars).