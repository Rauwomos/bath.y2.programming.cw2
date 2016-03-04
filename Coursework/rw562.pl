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

%% Basic Tests
s1_test(L,M):-s1(Q,M),length(Q,L).
s2_test(L,M):-s2(Q,M),length(Q,L).
s2_1_test(S,M):-s2_1(_,S,M).
s3_test(L,M):-s3(Q,M),length(Q,L).
s4_test(L,M):-s4(Q,M),length(Q,L).

%% Steps 1 to 5
	%% Step 1 - Remove unique products
	%% Step 2 - Remove sums corresponding to unique products
	%% Step 3 - Remove non-unique products
	%% Step 4 - Remove non-unique sums

%% Step 1
s1(Q,M):-Y is M-2,dd_list(Quads,[],2,Y,M),merge_sort(Quads,Sorted),remove_singleton(Sorted,[],Q),!.

%%   Part 1 - Create a list of [X, Y, X+Y, X*Y] (here on known as a quadruple)
%%   Part 2 - Create a function that sorts a list of quadruples by X*Y
%%   Part 3 - Create a function that removes all the quadruples where there is not another quadruple with the same X*Y 

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 2 - Remove sums corresponding to unique products
	%% Part 1 - Create list of sums corresponding to unique products
	%% Part 2 - Remove these sums from the result of s1

s2(A,M):-s2_1(Q,S,M),merge_sort1(Q,Qs),remove_sums(A,Qs,S),!.
s2_1(Q,S,M):-Y is M-2,dd_list(Quads,[],2,Y,M),merge_sort(Quads,Sorted),remove_singleton1(Sorted,[],Q,[],Ss),merge_sort_rd(Ss,S),!.

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton1([],L,L,S,S).
	% X
remove_singleton1([[_,_,S1,_]],Ls,Aq,Ss,As):-remove_singleton1([],Ls,Aq,[S1|Ss],As).
	% X X
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1]],Ls,Aq,Ss,As):-remove_singleton1([],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y
remove_singleton1([[_,_,S1,P1],[_,_,S2,P2]],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton1([],Ls,Aq,[S2,S1|Ss],As).
	% X X X
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],Ls,Aq,Ss,As):-remove_singleton1([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],[[X1,Y1,S1,P1]|Ls],Aq,Ss,As).
	% X X Y
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P2]|L],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton1([[X3,Y3,S3,P2]|L],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y Y
remove_singleton1([[_,_,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|L],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton1([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|L],Ls,Aq,[S1|Ss],As).
	% X Y Z
remove_singleton1([[_,_,S1,P1],[_,_,S2,P2],[X3,Y3,S3,P3]|L],Ls,Aq,Ss,As):-!,P1\=P2, !,P1\=P3, !,P2\=P3, remove_singleton1([[X3,Y3,S3,P3]|L],Ls,Aq,[S2,S1|Ss],As).

%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort_rd([],[]).
merge_sort_rd([X],[X]).
merge_sort_rd(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort_rd(L1,Sorted1),merge_sort_rd(L2,Sorted2), merge_rd(Sorted1,Sorted2,Sorted).

merge_rd([],L,L).
merge_rd(L,[],L):-L\=[].
merge_rd([S1|T1],[S2|T2],[S1|T]):- S1<S2,merge_rd(T1,[S2|T2],T).
merge_rd([S1|T1],[S1|T2],[S1|T]):- merge_rd(T1,T2,T).
merge_rd([S1|T1],[S2|T2],[S2|T]):- S1>S2,merge_rd([S1|T1],T2,T).

%% Does a merge sort on the list of quadruples, sorting by the sum
merge_sort1([],[]).
merge_sort1([X],[X]).
merge_sort1(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort1(L1,Sorted1),merge_sort1(L2,Sorted2), merge1(Sorted1,Sorted2,Sorted).

merge1([],L,L).
merge1(L,[],L):-L\=[].
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T]):- S1=<S2,merge1(T1,[[X2,Y2,S2,P2]|T2],T).
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T]):- S1>S2,merge1([[X1,Y1,S1,P1]|T1],T2,T).

%% remove_sums(A,L,Ss).
remove_sums(L,L,[]).
remove_sums([],[],_).
remove_sums([[X,Y,S1,P]|A],[[X,Y,S1,P]|T1],[S2|T2]):-S1<S2,!,remove_sums(A,T1,[S2|T2]).
remove_sums(A,[[_,_,S1,_]|T1],[S2|T2]):-S1=S2,!,remove_sums(A,T1,[S2|T2]).
remove_sums(A,[[X,Y,S1,P]|T1],[S2|T2]):-S1>S2,!,remove_sums(A,[[X,Y,S1,P]|T1],T2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 3 - Remove non-unique products

s3(A,M):-s2(Q,M),merge_sort(Q,Qs),remove_singleton2(Qs,[],A),!.

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton2([],L,L).
	% X
remove_singleton2([[X1,Y1,S1,P1]],L2,A):-remove_singleton2([],[[X1,Y1,S1,P1]|L2],A).
	% X X
remove_singleton2([[_,_,_,P1],[_,_,_,P1]],L2,A):-remove_singleton2([],L2,A).
	% X Y
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],L2,A):-!,P1\=P2, remove_singleton2([],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L2],A).
	% X X X
remove_singleton2([[_,_,_,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A):-remove_singleton2([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A).
	% X X Y
remove_singleton2([[_,_,_,P1],[_,_,_,P1],[X3,Y3,S3,P2]|L],L2,A):-!,P1\=P2, remove_singleton2([[X3,Y3,S3,P2]|L],L2,A).
	% X Y Y
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],L2,A):-!,P1\=P2, remove_singleton2([[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],[[X1,Y1,S1,P1]|L2],A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 4 - Remove non-unique sums

s4(A,M):-s3(Q,M),merge_sort1(Q,Qs),remove_singleton3(Qs,[],A),!.

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton3([],L,L).
	% X
remove_singleton3([[X1,Y1,S1,P1]],L2,A):-remove_singleton3([],[[X1,Y1,S1,P1]|L2],A).
	% X X
remove_singleton3([[_,_,S1,_],[_,_,S1,_]],L2,A):-remove_singleton3([],L2,A).
	% X Y
remove_singleton3([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],L2,A):-!,S1\=S2, remove_singleton3([],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L2],A).
	% X X X
remove_singleton3([[_,_,S1,_],[X2,Y2,S1,P2],[X3,Y3,S1,P3]|L],L2,A):-remove_singleton3([[X2,Y2,S1,P2],[X3,Y3,S1,P3]|L],L2,A).
	% X X Y
remove_singleton3([[_,_,S1,_],[_,_,S1,_],[X3,Y3,S3,P3]|L],L2,A):-!,S1\=S3, remove_singleton3([[X3,Y3,S3,P3]|L],L2,A).
	% X Y Y
remove_singleton3([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],L2,A):-!,S1\=S2, remove_singleton3([[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],[[X1,Y1,S1,P1]|L2],A).