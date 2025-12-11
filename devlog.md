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

# 12/10/2025 6:14
Successfully implemented mvoe predicate and tested using REPL
```txt
2 ?- move(up, 0, 1, NewR, C).
NewR = -1,
C = 1.

3 ?- move(down, 0, 1, NewR, C).
NewR = C, C = 1.

4 ?- move(left, 0, 1, R, NewC).
R = NewC, NewC = 0.

5 ?- move(right, 0, 1, R, NewC).
R = 0,
NewC = 2
```

# 12/10/2025 6:30 PM
Successfully implemented is_valid
Ensures that a particular cell is valid based on whether it is out of bounds, already visited, or a wall.
Note that it uses get_cell which returns false if  row and column are out of bounds
```text
1 ?- basic_map(M), display_map(M).
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐e██▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [e, w, w]] .

2 ?- basic_map(M), is_valid(M, 0, 1, []).
M = [[w, s, w], [f, f, w], [e, w, w]].

3 ?- basic_map(M), is_valid(M, 0, 0, []).
false.

4 ?- basic_map(M), is_valid(M, 0, -1, []).
false.
```

# 12/10/2025 7:05 PM
Successfully implemented find_path predicate
Reccursively applies DFS to find exit letter based on given starting row and column. Prolog convenenitly tests all direction of moves before backtracking in the case of failure, with a natural application of DFS.

```txt
5 ?- basic_map(M), display_map(M).
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐e██▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [e, w, w]] .

5 ?- basic_map(M), find_path(M, 0, 1, [], P).
M = [[w, s, w], [f, f, w], [e, w, w]],
P = [down, left, down] .
```

## Next Step
Integrate into find_exit predicate

# 12/10/2025 7:30 PM
Successfully integrated find_path into find_exit
However, found an error when using bad_map4
I needed to check the map for if there is more than on start
Created one_start predicate to determine
- returns true if there is only one start; false otherwise

```txt
2 ?- simple_map(M), display_map(M), find_exit(M, P).
    ▐▁▁▁▍
    ▐s e▍
    ▐▔▔▔▍
M = [[s, f, e]],
P = [right, right] .

3 ?- basic_map(M), display_map(M), find_exit(M, P).
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐e██▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [e, w, w]],
P = [down, left, down] .

4 ?- basic_map2(M), display_map(M), find_exit(M, P).
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐ ██▍
    ▐  e▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [f, w, w], [f, f, e]],
P = [down, left, down, down, right, right] .

5 ?- basic_map3(M), display_map(M), find_exit(M, P).
Correct to: "basic_map(M)"? yes
    ▐▁▁▁▍
    ▐█s█▍
    ▐  █▍
    ▐e██▍
    ▐▔▔▔▍
M = [[w, s, w], [f, f, w], [e, w, w]],
P = [down, left, down] .

6 ?- bad_map(M), display_map(M), find_exit(M, P).
    ▐▁▍
    ▐s▍
    ▐█e▍
    ▐▔▍
false.

7 ?- bad_map2(M), display_map(M), find_exit(M, P).
    ▐▁▁▁▍
    ▐s █▍
    ▐▔▔▔▍
false.

8 ?- bad_map3(M), display_map(M), find_exit(M, P).
    ▐▁▁▁▍
    ▐sse▍
    ▐▔▔▔▍
M = [[s, s, e]],
P = [right, right] .
```

## Next step:
continue testing for edge cases

# 12/10/2025 8:20 PM
The program effectively takes advantage of prolog's unification to recursively implement a DFS. Edge cases have been tested using iterations of bad_map along with large mazes generated using gen_map/4. Larger mazes tend to take more time; however, since this is not an algorithms class a DFS solution will suffice. Addtionally, prolog truncates the output of lists when they appear too large. Settings can be adjusted to chagne that. Large mazes may run into overflow errors; however, the instructions do not specify what size we should accommodate, so I assume we are using reasonably sized mazes. More involved testing would be needed to determine the limit of the sizes of the mazes we can accommodate.