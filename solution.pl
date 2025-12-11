
% Starting indices for s
find_start(Map, R, C) :-
    nth0(R, Map, Row),
    nth0(C, Row, s).

% Get the value at position (R, C) in the map
get_cell(Map, R, C, Value) :-
    nth0(R, Map, Row),
    nth0(C, Row, Value).

% Define movement directions
move(up, R, C, NewR, C) :- NewR is R - 1.
move(down, R, C, NewR, C) :- NewR is R + 1.
move(left, R, C, R, NewC) :- NewC is C - 1.
move(right, R, C, R, NewC) :- NewC is C + 1.

% For now, just finds start and returns empty path
find_exit(Map, Path) :-
    find_start(Map, R, C),
    write('Start found at row '), write(R), write(', col '), write(C), nl,
    Path = [].