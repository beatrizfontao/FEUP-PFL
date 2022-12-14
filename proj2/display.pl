symb(ducko, '\x278a\').
symb(duckt, '\x278b\').
symb(swano, '\x2780\').
symb(swant, '\x2781\').
symb(e, ' ').

display_b(Board) :-
    length(Board, N),
    top(N),
    matrix(Board),
    bot(N).

top(Size) :-
    write('\x250c\'),
    top_middle(Size).

top_middle(0) :- nl.
top_middle(Size) :-
    Size > 0,
    write('\x2500\\x2500\\x2500\'),
    top_cross(Size),
    S is Size - 1,
    top_middle(S).

top_cross(1) :-
    write('\x2510\').
top_cross(_) :-
    write('\x252c\').

bot(Size) :-
    write('\x2514\'),
    bot_middle(Size).

bot_middle(0) :- nl.
bot_middle(Size) :-
    Size > 0,
    write('\x2500\\x2500\\x2500\'),
    bot_cross(Size),
    S is Size - 1,
    bot_middle(S).

bot_cross(1) :-
    write('\x2518\').
bot_cross(_) :-
    write('\x2534\').

mid(Size) :-
    write('\x251c\'),
    mid_middle(Size).

mid_middle(0) :- nl.
mid_middle(Size) :-
    Size > 0,
    write('\x2500\\x2500\\x2500\'),
    mid_cross(Size),
    S is Size - 1,
    mid_middle(S).

mid_cross(1) :-
    write('\x2524\').
mid_cross(_) :-
    write('\x253c\').

matrix([L]) :-
    line(L).
matrix([L|R]) :-
    line(L),
    length(L, N),
    mid(N),
    matrix(R).

line([]) :- write('\x2502\'), nl.
line([C|R]) :-
    symb(C, Symbol),
    write('\x2502\ '), write(Symbol), write(' '),
    line(R).