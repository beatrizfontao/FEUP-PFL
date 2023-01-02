:- consult('utils.pl').

/*
  display_game(+GameState) 
  Displays the currunt board  (eu nao sei o que escrever mais aqui)
*/
display_game(GameState) :-
    length(GameState, N),
    N < 13,
    write('   '),
    letters(1, N),
    top(N),
    matrix(GameState, 1),
    bot(N).

/*
  letters(+N, +Size)
  Writes the letters at the top of the board that represent the columns of the board
*/
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

/*
  top(+Size)
  Displays on screen the top border of the board, including corners
*/
top(Size) :-
    write('   '),
    write('\x2554\'),
    top_middle(Size).

/*
  top_middle(+Size)
  Displays on screen the top border of the board, specifically middle of the top border and right corner
*/
top_middle(0) :- nl.
top_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    top_cross(Size),
    S is Size - 1,
    top_middle(S).

/*
  top_cross(+Size)
  Displays on screen the top border of the board, specifically the parts of the top border that cross
*/
top_cross(1) :-
    write('\x2557\').
top_cross(_) :-
    write('\x2566\').

/*
  bot(+Size)
  Displays on screen the bottom border of the board, including corners
*/
bot(Size) :-
    write('   '),
    write('\x255a\'),
    bot_middle(Size).

/*
  bot_middle(+Size)
  Displays on screen the bottom border of the board, specifically middle of the bottom border and right corner
*/
bot_middle(0) :- nl.
bot_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    bot_cross(Size),
    S is Size - 1,
    bot_middle(S).

/*
  bot_cross(+Size)
  Displays on screen the bottom border of the board, specifically the parts of the bottom border that cross
*/
bot_cross(1) :-
    write('\x255d\').
bot_cross(_) :-
    write('\x2569\').

/*
  mid(+Size)
  Displays on screen the middle lines of the board, including edges
*/
mid(Size) :-
    write('\x2560\'),
    mid_middle(Size).

/*
  mid_middle(+Size)
  Displays on screen the middle lines of the board, that is, the horizontal lines that make up the board
*/
mid_middle(0) :- nl.
mid_middle(Size) :-
    Size > 0,
    write('\x2550\\x2550\\x2550\'),
    mid_cross(Size),
    S is Size - 1,
    mid_middle(S).

/*
  mid_cross(+Size)
  Displays on screen the middle lines of the board, that is, the intersections of lines vertical and horizontal line of the board
*/
mid_cross(1) :-
    write('\x2563\').
mid_cross(_) :-
    write('\x256c\').

/*
  print_line_num(+Num)
  Displays the numbers that represent the rows of the board
*/
print_line_num(Num) :-
    Num < 10,
    write(' '), write(Num), write(' ').
print_line_num(Num) :-
    Num > 9,
    write(Num), write(' ').

/*
  matrix(+GameState, +CurrentLine)
  Displays on screen the current line being printed and displays that line
*/
matrix([L], CurrentLine) :-
    print_line_num(CurrentLine),
    line(L).
matrix([L|R], CurrentLine) :-
    CurrentLine > 0,
    print_line_num(CurrentLine),
    line(L),
    NextLine is CurrentLine + 1,
    length(L, N),
    write('   '), mid(N),
    matrix(R, NextLine).

/*
  line(+Row)
  Displays a single rowof the board with the correct simbols for the differents pieces and empty spaces
*/
line([]) :- write('\x2551\'), nl.
line([C|R]) :-
    symb(C, Symbol),
    write('\x2551\ '), write(Symbol), write(' '),
    line(R).