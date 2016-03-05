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

4. <Number of elements in the list binding Q after executing s4(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s4.>

5. <Number of elements in the list binding Q after executing s4(Q,500)>
s4(Q,500) uses <number> inferences. */


/* <BODY OF THE PROGRAM> */

%% Basic Tests
s1_test(L,M) :- s1(Q,M),length(Q,L).
s2_test(L,M) :- s2(Q,M),length(Q,L).
s2_1_test(S,M) :- s2_1(_,S,M).
s3_test(L,M) :- s3(Q,M),length(Q,L).
s4_test(L,M) :- s4(Q,M),length(Q,L).

%% Steps 1 to 5
	%% Step 1 - Creates a list of quadruples and removes those with a unique products
	%% Step 2 - Remove quadruples with sums corresponding to the unique products removed in step 1
	%% Step 3 - Remove quadurples with non-unique products
	%% Step 4 - Remove quadruples with non-unique sums


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step 1 - Creates a list of quadruples and removes those with a unique products
	%% Part 1 - Create a list of all posible quadruples
	%% Part 2 - Sort the list of quadruples by their product
	%% Part 3 - Remove any of the quadruples which has a product that is unique
s1(A,M) :- Y is M-2,dd_list(Q,[[]],2,Y,M),merge_sort(Q,[S]),remove_singleton(S,[],A),!.

%% Creates the initial list of lists quadruples which together satisfies 2<X<Y and X+Y<=100.
	/* It is made as a list of lists as each of the sub lists is already sorted, and so I am able to do a faster merge sort as then
	   I don't have to split the list down to individual quadruples entirely */
dd_list([[[2,3,5,6]|C]|T], [C|T], 2, 3,_):-!.
dd_list(A,L,1,Y,M) :- Z is Y-1,X is Z-1, dd_list(A,[[]|L],X,Z,M).
dd_list(A,L,X,Y,M) :- X+Y>M, Z is M-Y, dd_list(A,L,Z,Y,M).
dd_list(A,[C|T],X,Y,M) :- Z is X-1, S is X+Y, P is X*Y, dd_list(A,[[[X,Y,S,P]|C]|T],Z,Y,M).

%% Splits the list of lists down until it is merging two individual lists
merge_sort([],[]):-!.
merge_sort([X],[X]):-!.
merge_sort(List,Sorted) :- hv(List,List,L1,L2), merge_sort(L1,Sorted1),merge_sort(L2,Sorted2), merge(Sorted1,Sorted2,Sorted).

%% Merges to sorted list of lists of quadruples
merge([[]],L,L):-!.
merge(L,[[]],L):-!.
merge([[[X1,Y1,S1,P1]|T1]],[[[X2,Y2,S2,P2]|T2]],[[[X1,Y1,S1,P1]|T]]) :- P1=<P2, !, merge([T1],[[[X2,Y2,S2,P2]|T2]],[T]).
merge([[[X1,Y1,S1,P1]|T1]],[[[X2,Y2,S2,P2]|T2]],[[[X2,Y2,S2,P2]|T]]) :- !, merge([[[X1,Y1,S1,P1]|T1]],[T2],[T]).

%% Splits a list in half
	/* It works by removing twice as many eliments from the first arugment as it does from the second arugment. When the first arugment is
	   empty or has one element left then it makes L2 equal to what is left of the second argument, which will be half the list. It then
	   adds the first half of the list to L1 as it traces back up from the recursion. There are multiple statesments where it tries to remove
	   32 terms then 16 then 8 etc. This is because as if the list is long enough it will greatly reduce inferences, but if it won't pass it won't
	   count as an inference. This will increase cpu run time on short lists however on my lists it managed to reduce inferences by almost a third! */
hv([],R,[],R).
hv([_],R,[],R).
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31|L],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31|L1],R) :- hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15|L],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15|L1],R) :- hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7|L],[A0,A1,A2,A3,A4,A5,A6,A7|L1],R) :- hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_|T],[A,B,C,D|L],[A,B,C,D|L1],R) :- hv(T,L,L1,R),!.
hv([_,_,_,_|T],[A,B|L],[A,B|L1],R) :- hv(T,L,L1,R),!.
hv([_,_|T],[X|L],[X|L1],R) :- hv(T,L,L1,R),!.

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton([],L,L):-!.
	% X
remove_singleton([_],L2,A) :- !, remove_singleton([],L2,A).
	% X X
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1]],L2,A) :- !, remove_singleton([],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L2],A).
	% X Y
remove_singleton([[_,_,_,_],[_,_,_,_]],L2,A) :- !, remove_singleton([],L2,A).
	% X X X
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A) :- !, remove_singleton([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],[[X1,Y1,S1,P1]|L2],A).
	% X X Y
remove_singleton([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P2]|L],L2,A) :- !, remove_singleton([[X3,Y3,S3,P2]|L],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L2],A).
	% X Y Z
remove_singleton([[_,_,_,_],[X1,Y1,S1,P2],[X2,Y2,S2,P3]|L],L2,A) :- !, remove_singleton([[X1,Y1,S1,P2],[X2,Y2,S2,P3]|L],L2,A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 2 - Remove sums corresponding to unique products
	%% Part 1 - Run a modified version of s1 that returns a sorted list of sums that correspond to the unique products
	%% Part 2 - Sort the list of quadruples by their sum
	%% Part 3 - Remove quadruples which have a sum that is in the list of sums from part 1

s2(A,M) :- s2_1(Q,S,M),merge_sort1(Q,Qs),remove_sums(A,Qs,S).

%% Modified version of s1 that returns a sorted list of sums that correspond to the unique products
s2_1(Q,S,M) :- Y is M-2,dd_list(Quads,[[]],2,Y,M),merge_sort(Quads,[Sorted]),remove_singleton1(Sorted,[],Q,[],Ss),merge_sort_rd(Ss,S),!.

%% Does a merge sort on the list of sums to be removed, while at the same time removing any duplicate values
merge_sort_rd([],[]):-!.
merge_sort_rd([X],[X]):-!.
merge_sort_rd(List,Sorted) :- hv(List,List,L1,L2), merge_sort_rd(L1,Sorted1),merge_sort_rd(L2,Sorted2), merge_rd(Sorted1,Sorted2,Sorted).

merge_rd([],L,L):-!.
merge_rd(L,[],L):-!.
merge_rd([S1|T1],[S1|T2],[S1|T]) :- merge_rd(T1,T2,T).
merge_rd([S1|T1],[S2|T2],[S1|T]) :- S1<S2, !, merge_rd(T1,[S2|T2],T).
merge_rd([S1|T1],[S2|T2],[S2|T]) :- !, merge_rd([S1|T1],T2,T).

%% Does a merge sort on the list of quadruples, sorting by the sum
merge_sort1([],[]):-!.
merge_sort1([X],[X]):-!.
merge_sort1(List,Sorted) :- hv(List,List,L1,L2), merge_sort1(L1,Sorted1),merge_sort1(L2,Sorted2), merge1(Sorted1,Sorted2,Sorted).

merge1([],L,L):-!.
merge1(L,[],L):-!.
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T]) :- S1=<S2,! ,merge1(T1,[[X2,Y2,S2,P2]|T2],T).
merge1([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T]) :- !, merge1([[X1,Y1,S1,P1]|T1],T2,T).

%% Removes the quadruples that have a sum that is contained in the list of sums that correspond to the unique products
remove_sums(L,L,[]):-!.
remove_sums([],[],_):-!.
remove_sums(A,[[_,_,S1,_]|T1],[S1|T2]) :- !,remove_sums(A,T1,[S1|T2]).
remove_sums([[X,Y,S1,P]|A],[[X,Y,S1,P]|T1],[S2|T2]) :- S1<S2, !, remove_sums(A,T1,[S2|T2]).
remove_sums(A,[[X,Y,S1,P]|T1],[_|T2]) :- !, remove_sums(A,[[X,Y,S1,P]|T1],T2).

%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's sum
remove_singleton1([],L,L,S,S):-!.
	% X
remove_singleton1([[_,_,S1,_]],Ls,Aq,Ss,As) :- !, remove_singleton1([],Ls,Aq,[S1|Ss],As).
	% X X
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1]],Ls,Aq,Ss,As) :- !, remove_singleton1([],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y
remove_singleton1([[_,_,S1,_],[_,_,S2,_]],Ls,Aq,Ss,As) :- !, remove_singleton1([],Ls,Aq,[S2,S1|Ss],As).
	% X X X
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],Ls,Aq,Ss,As) :- !, remove_singleton1([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],[[X1,Y1,S1,P1]|Ls],Aq,Ss,As).
	% X X Y
remove_singleton1([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P2]|L],Ls,Aq,Ss,As) :- !, remove_singleton1([[X3,Y3,S3,P2]|L],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y Z
remove_singleton1([[_,_,S1,_],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],Ls,Aq,Ss,As) :- !, remove_singleton1([[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],Ls,Aq,[S1|Ss],As).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 3 - Remove quadurples with non-unique products
	%% Part 1 - Run s2
	%% Part 2 - Sort the list of quadruples by their product
	%% Part 3 - Remove the quadruples that don't have a unique product

s3(A,M) :- s2(Q,M),merge_sort2(Q,Qs),remove_singleton2(Qs,[],A),!.

%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort2([],[]):-!.
merge_sort2([X],[X]):-!.
merge_sort2(List,Sorted) :- hv(List,List,L1,L2), merge_sort2(L1,Sorted1),merge_sort2(L2,Sorted2), merge2(Sorted1,Sorted2,Sorted).

merge2([],L,L):-!.
merge2(L,[],L):-!.
merge2([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T]) :- P1=<P2, !, merge2(T1,[[X2,Y2,S2,P2]|T2],T).
merge2([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T]) :- !, merge2([[X1,Y1,S1,P1]|T1],T2,T).

%% Removes all the quadruples from the list which don't have a unique product
remove_singleton2([],L,L):-!.
	% X
remove_singleton2([[X1,Y1,S1,P1]],L2,A) :- !, remove_singleton2([],[[X1,Y1,S1,P1]|L2],A).
	% X X
remove_singleton2([[_,_,_,P1],[_,_,_,P1]],L2,A) :- !, remove_singleton2([],L2,A).
	% X Y
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],L2,A) :- !, remove_singleton2([],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L2],A).
	% X X X
remove_singleton2([[_,_,_,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A) :- !, remove_singleton2([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],L2,A).
	% X X Y
remove_singleton2([[_,_,_,P1],[_,_,_,P1],[X3,Y3,S3,P2]|L],L2,A) :- !, remove_singleton2([[X3,Y3,S3,P2]|L],L2,A).
	% X Y Z
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],L2,A) :- !, remove_singleton2([[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],[[X1,Y1,S1,P1]|L2],A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Step 4 - Remove quadruples with non-unique sums
	%% Part 1 - Run s3
	%% Part 2 - Sort the list of quadruples by their sum
	%% Part 3 - Remove all the quadruples with non-unique sums
	%% Part 4 - fin

s4(A,M) :- s3(Q,M),merge_sort1(Q,Qs),remove_singleton3(Qs,[],A),!.

%% Removes all the quadruples from the list which don't have a unique sum
remove_singleton3([],L,L):-!.
	% X
remove_singleton3([[X1,Y1,S1,P1]],L2,A) :- !,remove_singleton3([],[[X1,Y1,S1,P1]|L2],A).
	% X X
remove_singleton3([[_,_,S1,_],[_,_,S1,_]],L2,A) :- !, remove_singleton3([],L2,A).
	% X Y
remove_singleton3([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],L2,A) :- !,remove_singleton3([],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L2],A).
	% X X X
remove_singleton3([[_,_,S1,_],[X2,Y2,S1,P2],[X3,Y3,S1,P3]|L],L2,A) :- !, remove_singleton3([[X2,Y2,S1,P2],[X3,Y3,S1,P3]|L],L2,A).
	% X X Y
remove_singleton3([[_,_,S1,_],[_,_,S1,_],[X3,Y3,S3,P3]|L],L2,A) :- !, remove_singleton3([[X3,Y3,S3,P3]|L],L2,A).
	% X Y Z
remove_singleton3([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],L2,A) :- !, remove_singleton3([[X2,Y2,S2,P2],[X3,Y3,S3,P3]|L],[[X1,Y1,S1,P1]|L2],A).

%% 172,960 -- > 96,316
%% 6,124,206 -- > 3,405,259