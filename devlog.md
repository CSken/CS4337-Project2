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