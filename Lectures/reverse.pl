rev([],[]).
rev([E|T],L) :- rev(T,R),
                app(R,[E],L).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

