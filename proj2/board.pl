:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(between)).

:- consult('display.pl').

a :-
    create_board(5, FinalBoard),
    display_b(FinalBoard).

create_board(Size, FinalBoard) :- 
    S is Size - 2,
    create_line(Size, duckt, [], Line),
    init(Size, S,[Line], Board),
    create_line(Size, ducko, [], Line2),
    add_final(Line2, Board, FinalBoard).


init(_, 0, FinalBoard, FinalBoard).
init(Size, Col, CurrentBoard, FinalBoard) :-
    Col > 0,
    C is Col - 1,
    create_line(Size, e, [], Line),
    init(Size, C, [Line|CurrentBoard], FinalBoard).

create_line(0, _, FinalLine, FinalLine).
create_line(Size, Player, CurrentLine, FinalLine) :-
    Size > 0,
    S is Size - 1,
    create_line(S, Player, [Player|CurrentLine], FinalLine).

add_final([], FinalBoard, FinalBoard).
add_final(Line, CurrentBoard, FinalBoard) :-
    add_final([], [Line|CurrentBoard], FinalBoard).