isPrime2(2) :-
    !.
isPrime2(3) :-
    !.
isPrime2(X) :-
    X > 3,
    X mod 2 =\= 0,
    N_max is ceiling(sqrt(X)),
    isPrime2_(X,3,N_max).

isPrime2_(X,N,N_max) :-
    (  N > N_max 
    -> true
    ;  0 =\= X mod N,
       M is N + 2,
       isPrime2_(X,M,N_max)
    ).


is_sum_prime(X):-Y is X mod 2, Y = 0,!.
is_sum_prime(X):-Y is X - 2, is_prime(Y),!.

list(A,A,10):-!.
list(A,C,N):-is_sum_prime(N),!,M is N-1, list(A,C,M).
list(A,C,N):-!,M is N-1, list(A,[N|C],M).

is_member_sorted(M,[M|_]).
is_member_sorted(M,[N|T]):-M>N,is_member_sorted(M,T).

run(T):-list(L,[],53),!,is_member_sorted(T,L),!.