symb(ducko, '\x278a\').
symb(duckt, '\x278b\').
symb(swano, '\x2780\').
symb(swant, '\x2781\').
symb(e, ' ').

team(ducko, swano).
team(ducko, ducko).
team(swano, swano).
team(duckt, swant).
team(duckt, duckt).
team(swant, swant).
team(e, e).

winner(swano, player1).
winner(swant, player2).
winner(e, no).

turn(player1, player2).
turn(player2, player1).

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

get_piece(GameState, Col, Row, Piece) :-
    nth0(Row, GameState, RowList),
    nth0(Col, RowList, Piece).
