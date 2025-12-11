# 12/10/2025 5:00PM

## Understanding the Problem
example.pl contains sample mazes and display_map/1 to pretty print
test.pl contains gen_map/4 for generating random solvable mazes
sample-run.txt shows me the expected output after a successful implementation of my solution.

## Experimenting with example.pl and test.pl in my REPL:
tested out some commands:
```txt
1 ?- basic_map(M), display_map(M).
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐e██▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [e, w, w]] .

2 ?- simple_map(M), display_map(M).
    ▐▁▁▁▍
    ▐s e▍
    ▐▔▔▔▍
M = [[s, f, e]] .

3 ?- gen_map(4, 5, 5, M), display_map(M).
    ▐▁▁▁▁▁▍
    ▐ █ █ ▍
    ▐ █e  ▍
    ▐   ██▍
    ▐ █ █ ▍
    ▐ █ s ▍
    ▐▔▔▔▔▔▍
M = [[f, w, f, w, f], [f, w, e, f, f], [f, f, f, w, w], [f, w, f, w, f], [f, w, f, s|...]] .

4 ?- bad_map(M), display_map(M).
    ▐▁▍
    ▐s▍
    ▐█e▍
    ▐▔▍
M = [[s], [w, e]] .
```

## My plan
I will implement find_exit/2 in a solution.pl file
I think implementing a depth-first-search is most intuitive.
I will first have to figure out how to parse the map.
I'll start by figuring out how I can identify the start position.

# 12/10/2025 5:50 PM

## Completed 
Successfully implemented find_start to find the starting position s.
Implemented initial find_exit which uses find_start.
Tested both predicates using different maps in example successfully.

## Planning the DFS approach

The big picture is find_exit(Map, Path) returns a list of directions up down left right that go from s to e.

I will use depth first search.
Start at s.
Try moving in a direction.
If valid keep going from new position.
If I reach e I am done and collect the directions taken.
If stuck Prolog's backtracking will try other directions.

What I need to build working backwards:

find_path is the recursive search.
Base case is when current position is e then done.
Recursive case try a direction check if valid continue.

I need a way to check the value of a cell to determine its validity

Movement defines what each direction does.
Up means row decreases by 1.
Down means row increases by 1.
Left means column decreases by 1.
Right means column increases by 1.

Build order:
get_cell to get value at position since its needed by others.
move to calculate new position.
is_valid to check if move is allowed.
find_path for recursive DFS.
Update find_exit to use find_path.

## Next step
Implement get_cell similar to get whatever value is at the position.


# 12/10/2025 6:05 
Successfully implemented and test get_cell using REPL
Will continue by implementing move to return values up, down, left, and right