sorted([]).
sorted([_]).
sorted([X,Y|Z]) :- X =< Y,
                   sorted([Y|Z]).

bs_pass([]     ,[]   ).
bs_pass([X]    ,[X]  ).
bs_pass([X,Y|Z],[X|W]) :- X =< Y,
                          !,
                          bs_pass([Y|Z],W).
bs_pass([X,Y|Z],[Y|W]) :- bs_pass([X|Z],W).

bs(In,In)  :- sorted(In),
              !.
bs(In,Out) :- bs_pass(In,Part),
              bs(Part,Out).