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
is_sum_prime(X):-Y is X - 2, isPrime2(Y),!.

remove_sum(A,A,[],_).
remove_sum([[[X,Y,S,P]|L]|D],D,[[X,Y,S,P]|L],Sum):-S\=Sum,!.
remove_sum(A,D,[[X,Y,S,P]|L],Sum):-S=Sum,remove_sum(A,[[X,Y,S,P]|D],L,Sum).

remove_sum2([[[X,Y,S,P]|L]|C],C,[[X,Y,S,P]|L],Sum):-S\=Sum,!.
remove_sum2(A,C,[[X,Y,S,P]|L],Sum):-S=Sum,remove_sum2(A,[[X,Y,S,P]|C],L,Sum).

run(A):-remove_sum(A,[],[[1,1,11,1]|[]],11).

%% Doesn't Work!!!
%% remove_sum_of_primes(A,A,[]).
%% remove_sum_of_primes(A,C,[[_,_,S,_]|T]):-is_sum_prime(S),!,remove_sum([Removed|_],[],T,S),remove_sum_of_primes(A,C,Removed).
%% remove_sum_of_primes(A,C,[[X,Y,S,P]|T]):-remove_sum([Removed|Kept],[],[[X,Y,S,P]|T],S),remove_sum_of_primes(A,[Removed|C],Kept).

remove_sum_of_primes(A,A,[]).
remove_sum_of_primes(A,C,[[_X,_,S,_]|T]):-is_sum_prime(S),!,remove_sum_of_primes(A,C,T),!.
remove_sum_of_primes(A,C,[[X,Y,S,P]|T]):-remove_sum_of_primes(A,[[X,Y,S,P]|C],T),!.

%% If X or Y is not a sum of two primes, then 
remove_sum_of_primes(A,A,[]).
remove_sum_of_primes(A,C,[[_X,_,S,_]|T]):-is_sum_prime(S),!,remove_sum_of_primes(A,C,T),!.
remove_sum_of_primes(A,C,[[X,Y,S,P]|T]):-remove_sum_of_primes(A,[[X,Y,S,P]|C],T),!.