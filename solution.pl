
% Starting indices for s
find_start(Map, R, C) :-
    nth0(R, Map, Row),
    nth0(C, Row, s).

% For now, just finds start and returns empty path
find_exit(Map, Path) :-
    find_start(Map, R, C),
    write('Start found at row '), write(R), write(', col '), write(C), nl,
    Path = [].