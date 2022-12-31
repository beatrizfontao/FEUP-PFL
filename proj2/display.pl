:- consult('utils.pl').

display_game(GameState) :-
    length(GameState, N),
    N < 27,
    write('  '),
    letters(1, N),
    top(N),
    matrix(GameState, 1),
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
    write('  '),
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
    write('  '),
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

matrix([L], CurrentLine) :-
    CurrentLine > 0,
    write(CurrentLine), write(' '),
    line(L).
matrix([L|R], CurrentLine) :-
    CurrentLine > 0,
    write(CurrentLine), write(' '),
    line(L),
    NextLine is CurrentLine + 1,
    length(L, N),
    write('  '), mid(N),
    matrix(R, NextLine).

line([]) :- write('\x2551\'), nl.
line([C|R]) :-
    symb(C, Symbol),
    write('\x2551\ '), write(Symbol), write(' '),
    line(R).