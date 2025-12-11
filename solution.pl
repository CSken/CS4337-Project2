
% Starting indices for s
find_start(Map, R, C) :-
    nth0(R, Map, Row),
    nth0(C, Row, s).

% Get the value at position (R, C) in the map
get_cell(Map, R, C, Value) :-
    nth0(R, Map, Row),
    nth0(C, Row, Value).

% For now, just finds start and returns empty path
find_exit(Map, Path) :-
    find_start(Map, R, C),
    write('Start found at row '), write(R), write(', col '), write(C), nl,
    Path = [].