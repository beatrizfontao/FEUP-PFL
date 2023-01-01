:- consult('utils.pl').

ask_for_move(GameState, Move, Valid, PlayerTurn) :-
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
    get_piece(GameState, C, R, Piece),
    (PlayerTurn == player1, (Piece == ducko; Piece == swano) -> append([C, R], [NewC, NewR], Move), is_move_valid(GameState, PlayerTurn, Piece, Move, Valid);
        (PlayerTurn == player2, (Piece == duckt; Piece == swant) -> append([C, R], [NewC, NewR], Move), is_move_valid(GameState, PlayerTurn, Piece, Move, Valid);
            append([], [], Move), Valid = false
        )
    )
    .

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