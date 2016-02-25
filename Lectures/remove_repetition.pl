rr([],[]).
rr([E,E|T],L)   :- !, rr([E|T],L).
rr([E|T],[E|L]) :- rr(T,L).