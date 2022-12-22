symb(ducko, '\x278a\').
symb(duckt, '\x278b\').
symb(swano, '\x2780\').
symb(swant, '\x2781\').
symb(e, ' ').

row(1, 'A').
row(2, 'B').
row(3, 'C').
row(4, 'D').
row(5, 'E').
row(6, 'F').
row(7, 'G').
row(8, 'H').
row(9, 'I').
row(10, 'J').
row(11, 'K').
row(12, 'L').
row(13, 'M').
row(14, 'N').
row(15, 'O').
row(16, 'P').
row(17, 'Q').
row(18, 'R').
row(19, 'S').
row(20, 'T').
row(21, 'U').
row(22, 'V').
row(23, 'W').
row(24, 'X').
row(25, 'Y').
row(26, 'Z').


display_game(GameState) :-
    length(GameState, N),
    N < 27,
    letters(1, N),
    top(N),
    matrix(GameState),
    bot(N).

letters(Size, Size) :-
    row(Size, Letter),
    write('  '), write(Letter), write(' '),
    nl.
letters(N, Size) :-
    N < Size,
    row(N, Letter),
    write('  '), write(Letter), write(' '),
    N1 is N + 1,
    letters(N1, Size).

top(Size) :-
    write('\x2554\'),
    top_middle(Size).

top_middle(0) :- nl.
top_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    top_cross(Size),
    S is Size - 1,
    top_middle(S).

top_cross(1) :-
    write('\x2557\').
top_cross(_) :-
    write('\x2566\').

bot(Size) :-
    write('\x255a\'),
    bot_middle(Size).

bot_middle(0) :- nl.
bot_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    bot_cross(Size),
    S is Size - 1,
    bot_middle(S).

bot_cross(1) :-
    write('\x255d\').
bot_cross(_) :-
    write('\x2569\').

mid(Size) :-
    write('\x2560\'),
    mid_middle(Size).

mid_middle(0) :- nl.
mid_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    mid_cross(Size),
    S is Size - 1,
    mid_middle(S).

mid_cross(1) :-
    write('\x2563\').
mid_cross(_) :-
    write('\x256c\').

matrix([L]) :-
    line(L).
matrix([L|R]) :-
    line(L),
    length(L, N),
    mid(N),
    matrix(R).

line([]) :- write('\x2551\'), nl.
line([C|R]) :-
    symb(C, Symbol),
    write('\x2551\ '), write(Symbol), write(' '),
    line(R).