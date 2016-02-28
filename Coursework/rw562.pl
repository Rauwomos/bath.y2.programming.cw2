/* rw562 Rowan Walshe

THIS WORK IS ENTIRELY MY OWN.

The program does <or does not, choose which is appropriate> produce multiple answers.

I have <or I have not, choose which is appropriate> used built-ins.

1. <Number of elements in the list binding Q after executing s1(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s1.>

2. <Number of elements in the list binding Q after executing s2(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s2.>

3. <Number of elements in the list binding Q after executing s3(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s3.>

4.
<At most 300 characters of clear text on the main idea for the definition of s4.>

5. <Number of elements in the list binding Q after executing s4(Q,500)>
s4(Q,500) uses <number> inferences. */


/* <BODY OF THE PROGRAM> */

%% Step 1
s1(Q,M):-Y is M-2,dd_list(Quads,[],2,Y,M),!,merge_sort(Quads,Sorted),!,remove_singleton(Sorted,[],Q),!.

%%   Part 1
%%     Create a list of [X, Y, X+Y, X*Y] (here on known as a quadruple)
%%      
%%   Part 3
%%     Create a function that sorts a list of quadruples by X*Y
%%   Part 4
%%     Create a function that removes all the quadruples where there is not another quadruple with the same X*Y 

%% Creates list of quadruples of [X,Y,S,P] where 1<X<Y and X+Y<100
	% A is the answer
	% L is the current list of quadruples which is built up to the answer
	% X is first term, decreases from either 100-Y to 2 or Y-1 to 2 depending on wether X+Y>100 or not
	% Y is second term, decreases by one every time X reaches 2
	% M is the max sum(ie 100 or 500)
dd_list([[2,3,5,6]|L], L, 2, 3,_).
dd_list(A,L,2,Y,M) :- Z is Y-1, X is Z-1, S is Y+2, P is Y*2, dd_list(A,[[2,Y,S,P]|L],X,Z,M).
dd_list(A,L,X,Y,M) :- X+Y>M, Z is M-Y, dd_list(A,L,Z,Y,M).
dd_list(A,L,X,Y,M) :- Z is X-1, S is X+Y, P is X*Y, dd_list(A,[[X,Y,S,P]|L],Z,Y,M).

%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort(L1,Sorted1),merge_sort(L2,Sorted2), merge(Sorted1,Sorted2,Sorted).

merge([],L,L).
merge(L,[],L):-L\=[].
merge([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T]):- P1=<P2,merge(T1,[[X2,Y2,S2,P2]|T2],T).
merge([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T]):- P1>P2,merge([[X1,Y1,S1,P1]|T1],T2,T).

divide(L,L1,L2):-halve(L,L1,L2).
halve(L,A,B):-hv(L,L,A,B).  
hv([],R,[],R).   % for lists of even length
hv([_],R,[],R).  % for lists of odd length
hv([_,_|T],[X|L],[X|L1],R):-hv(T,L,L1,R).

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton([],L,L).
	% X
remove_singleton([_],L2,A):-remove_singleton([],L2,A).
	% X X
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1]],L2,A):-remove_singleton([],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L2],A).
	% X Y
remove_singleton([[_,_,_,P1],[_,_,_,P2]],L2,A):-!,P1\=P2, remove_singleton([],L2,A).
	% X X X
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A):-remove_singleton([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],[[X1,Y1,S1,P1]|L2],A).
	% X X Y
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P2]|L],L2,A):-!,P1\=P2, remove_singleton([[X3,Y3,S3,P2]|L],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L2],A).
	% X Y Y
remove_singleton([[_,_,_,P1],[X1,Y1,S1,P2],[X2,Y2,S2,P2]|L],L2,A):-!,P1\=P2, remove_singleton([[X1,Y1,S1,P2],[X2,Y2,S2,P2]|L],L2,A).
	% X Y Z
remove_singleton([[_,_,_,P1],[_,_,_,P2],[X3,Y3,S3,P3]|L],L2,A):-!,P1\=P2, !,P1\=P3, !,P2\=P3, remove_singleton([[X3,Y3,S3,P3]|L],L2,A).

%%Step 2
	% Remove all quadruples where the sum has at least one case where x and y are both primes for that sum
	% TODO
		% Make a function that generates a list of primes up to a max value
		% Check if x and y are in the list

remove_sum_of_primes(_,[]).
remove_sum_of_primes(A,[[X,Y,S,P]|L]):-(isPrime2(X),isPrime2(Y)->remove_sum(Removed,_,L,S),remove_sum_of_primes(A,Removed); remove_sum(Removed,Kept,[[X,Y,S,P]|L],S),remove_sum_of_primes([Kept|A]),Removed).

remove_sum([],_,[],_).
remove_sum([[[X,Y,S,P]|L]|D],D,[[X,Y,S,P]|L],Sum):-S\=Sum,!.
remove_sum(A,D,[[X,Y,S,P]|L],Sum):-S=Sum,remove_sum(A,[[X,Y,S,P]|D],L,Sum).

%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort1([],[]).
merge_sort1([X],[X]).
merge_sort1(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort1(L1,Sorted1),merge_sort1(L2,Sorted2), merge1(Sorted1,Sorted2,Sorted).

merge1([],L,L).
merge1(L,[],L):-L\=[].
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T]):- S1=<S2,merge1(T1,[[X2,Y2,S2,P2]|T2],T).
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T]):- S1>S2,merge1([[X1,Y1,S1,P1]|T1],T2,T).

is_prime(2) :-
    !.
is_prime(3) :-
    !.
is_prime(X) :-
    X > 3,
    X mod 2 =\= 0,
    N_max is ceiling(sqrt(X)),
    is_prime2(X,3,N_max).

is_prime2(X,N,N_max) :-
    (  N > N_max 
    -> true
    ;  0 =\= X mod N,
       M is N + 2,
       is_prime2(X,M,N_max)
    ).

%% For testing s1 and s2
%% run(Sorted2,M):-Y is M-2,dd_list(Quads,[],2,Y,M),merge_sort(Quads,Sorted),remove_singleton(Sorted,[],Q),merge_sort1(Q,Sorted2).
%% run2(Sorted2,M):-Y is M-2,dd_list(Q,[],2,Y,M),merge_sort(Q,Sorted),remove_singleton(Sorted,[],Q),merge_sort1(Q,Sorted2).
run(L):-dd_list(A,[],2,98,100),merge_sort(A,Sorted),remove_singleton(Sorted,[],Q),length(Q,L).
