/*
symb(+Piece, -Representation)
Representation of each piece and empty cell
*/
symb(ducko, '\x278a\').
symb(duckt, '\x278b\').
symb(swano, '\x2780\').
symb(swant, '\x2781\').
symb(e, ' ').

/*
team(+Piece1, +Piece2)
Checks if the two pieces belong to the same player
*/
team(ducko, swano).
team(ducko, ducko).
team(swano, swano).
team(duckt, swant).
team(duckt, duckt).
team(swant, swant).
team(e, e).

/*
winner(+Piece, -Player)
Given a swan (type of piece), it return the corresponding player(winner)
*/
winner(swano, player1).
winner(swant, player2).
winner(e, e).

/*
different_team(+Piece1, -Piece2)
Checks if the two pieces belong to different players
*/
different_team(ducko, swant).
different_team(swant, ducko).

different_team(ducko, duckt).
different_team(duckt, ducko).

different_team(duckt, swano).
different_team(swano, duckt).

different_team(swant, swano).
different_team(swano, swant).

/*
turn(+CurrentPlayer, -NextPlayer)
Returns the player that will play the next turn
*/
turn(player1, player2).
turn(player2, player1). 

/*
playernum(+Player, -Number)
Returns the number associated with the given player
*/
playernum(player1, 1).
playernum(player2, 2).

/*
value(+Piece, -Value)
Given a piece, it returns the corresponding value
*/
value(ducko, 10).
value(swano, 50).
value(duckt, 10).
value(swant, 50).
value(e, 0).

/*
piece(+Player, +Piece)
Checks if the given player and piece match
*/
piece(player1, ducko).
piece(player1, swano).
piece(player2, duckt).
piece(player2, swant).

/*
enemy(+Player, -Opponent)
Return the opponent of the given player
*/
enemy(player1, player2).
enemy(player2, player1).

/*
row(+Num, -Char)
Used to print the columns' and rows' numbers and letters
*/
row(1, 'A').
row(1, '1').
row(2, 'B').
row(2, '2').
row(3, 'C').
row(3, '3').
row(4, 'D').
row(4, '4').
row(5, 'E').
row(5, '5').
row(6, 'F').
row(6, '6').
row(7, 'G').
row(7, '7').
row(8, 'H').
row(8, '8').
row(9, 'I').
row(9, '9').
row(10, 'J').
row(10, '10').
row(11, 'K').
row(11, '11').
row(12, 'L').
row(12, '12').
row(13, 'M').
row(13, '13').
row(14, 'N').
row(14, '14').
row(15, 'O').
row(15, '15').
row(16, 'P').
row(16, '16').
row(17, 'Q').
row(17, '17').
row(18, 'R').
row(18, '18').
row(19, 'S').
row(19, '19').
row(20, 'T').
row(20, '20').
row(21, 'U').
row(21, '21').
row(22, 'V').
row(22, '22').
row(23, 'W').
row(23, '23').
row(24, 'X').
row(24, '24').
row(25, 'Y').
row(25, '25').
row(26, 'Z').
row(26, '26').

/*
get_piece(+GameState, +Col, +Row, -Piece)
Given a gamestate and a position, it returns the piece placed there
*/
get_piece(GameState, Col, Row, Piece) :-
    nth0(Row, GameState, RowList),
    nth0(Col, RowList, Piece).
