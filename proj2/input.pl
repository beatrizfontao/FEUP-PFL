/*
ask_for_move(+GameState, +PlayerTurn, -Move, -Valid)
Reads the move the user wants to make and checks if it is valid
*/
ask_for_move(GameState, PlayerTurn, Move, Valid) :-
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
    (PlayerTurn == player1, (Piece == ducko; Piece == swano) -> 
        append([C, R], [NewC, NewR], Move), 
        is_move_valid(GameState, PlayerTurn, Move, Valid);
        (PlayerTurn == player2, (Piece == duckt; Piece == swant) -> 
            append([C, R], [NewC, NewR], Move), 
            is_move_valid(GameState, PlayerTurn, Move, Valid);
            append([], [], Move), Valid = false
        )
    ).

/*
read_col(-Column)
Reads the input of the user, checks if it is a valid column(A, B, C, D, ...) and transforms it in the corresponding number
*/
read_col(Column) :-
    read_line(Input),
    length(Input, InputLength),
    InputLength =:= 1,
    atom_codes(String, Input),
    row(Column, String).

/*
read_row(-Row)
Reads the input of the user, checks if it is a valid row(1, 2, 3, ...) and transforms it in the corresponding number
*/
read_row(Row) :-
    read_line(Input),
    atom_codes(String, Input),
    row(Row, String),
    Row > 0,
    Row < 13.