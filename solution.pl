
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

% Check if a cell is valid to move to
% Must be in bounds, not a wall, and not already visited
is_valid(Map, R, C, Visited) :-
    get_cell(Map, R, C, Cell),
    Cell \= w,
    \+ member((R, C), Visited).

% Base case: current cell is the exit, return nothing
find_path(Map, R, C, _, []) :-
    get_cell(Map, R, C, e).

% Recursive case: returns the attempted direction appended with the rest of the path
find_path(Map, R, C, Visited, [Dir|RestPath]) :-
    move(Dir, R, C, NewR, NewC),
    is_valid(Map, NewR, NewC, Visited),
    find_path(Map, NewR, NewC, [(NewR, NewC)|Visited], RestPath).

% Check that there is exactly one start position
one_start(Map) :-
    findall((R, C), (nth0(R, Map, Row), nth0(C, Row, s)), Starts),
    length(Starts, 1).

% Entry point: find path from start to exit
find_exit(Map, Path) :-
    one_start(Map),
    find_start(Map, R, C),
    find_path(Map, R, C, [(R, C)], Path).