:- consult('utils.pl').

ask_for_move(Move) :-
    write('Initial Col: '),
    read_col(Col),
    write('Initial Row: '),
    read_row(Row),
    write('New Col: '),
    read_col(NewCol),
    write('New Row: '),
    read_row(NewRow),
    C is Col - 1,
    R is Row - 1,
    NewC is NewCol - 1,
    NewR is NewRow - 1,
    append([C, R], [NewC, NewR], Move).

read_col(Column) :-
    read_line(Input),
    length(Input, InputLength),
    InputLength =:= 1,
    atom_codes(String, Input),
    row(Column, String).

read_row(Row) :-
    read_line(Input),
    atom_codes(String, Input),
    row(Row, String),
    Row > 0,
    Row < 27.