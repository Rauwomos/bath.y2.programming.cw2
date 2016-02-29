%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort1([],[]).
merge_sort1([X],[X]).
merge_sort1(List,Sorted) :- List=[_,_|_],divide1(List,L1,L2), merge_sort1(L1,Sorted1),merge_sort1(L2,Sorted2), merge1(Sorted1,Sorted2,Sorted).

merge1([],L,L).
merge1(L,[],L):-L\=[].
merge1([X|T1],[Y|T2],[X|T]):-X=<Y,merge1(T1,[Y|T2],T).
merge1([X|T1],[Y|T2],[Y|T]):-X>Y,merge1([X|T1],T2,T).

divide1(L,L1,L2):-halve2(L,L1,L2).
   
halve2(L,A,B):-hv2(L,L,A,B).
   
hv2([],R,[],R).   % for lists of even length
hv2([_],R,[],R).  % for lists of odd length
hv2([_,_|T],[X|L],[X|L1],R):-hv2(T,L,L1,R).


list_head(_, 0, []).
list_head([H|T], N, [H|Sub]) :-
	N1 is N-1,
	list_head(T, N1, Sub).

list_tail(T, 0, T).
list_tail([_|T], N, R) :-
	N1 is N-1,
	list_tail(T, N1, R).

merge2(A, [], A).
merge2([], B, B).
merge2([Ha|Ta], [Hb|Tb], [Ha|Sub]) :-
	Ha < Hb,
	merge2(Ta, [Hb|Tb], Sub).

merge2([Ha|Ta], [Hb|Tb], [Hb|Sub]) :-
	Ha >= Hb,
	merge2([Ha|Ta], Tb, Sub).

mergesort2([H], [H]).
mergesort2(List, Sorted) :-
			length(List, Number),
			Half is Number // 2,
			list_head(List, Half, H),
			list_tail(List, Half, T),
			mergesort2(H, A),
			mergesort2(T, B),
			merge2(A, B, Sorted).

mergesort3(Ls, Ms) :-
    length(Ls, L),
    (	L =< 1 -> Ms = Ls
    ;	Half is L // 2,
	length(Front0, Half),
	append(Front0, Back0, Ls),
	mergesort3(Front0, Front),
	mergesort3(Back0, Back),
	merge3(Front, Back, Ms)
    ).

% If your Prolog library provides merge/3, comment out the following.

merge3([], Ys, Ys) :- !.
merge3(Xs, [], Xs) :- !.
merge3([X|Xs], [Y|Ys], Ms) :-
    (	X @< Y ->
	Ms = [X|Rest],
	merge3(Xs, [Y|Ys], Rest)
    ;	Ms = [Y|Rest],
	merge3([X|Xs], Ys, Rest)
    ).

mergesort4([],[]).
mergesort4([OneElement], [OneElement]).
mergesort4([OneElement,SecondElement], SortedList) :-
	mergelists4([OneElement],[SecondElement], SortedList).
mergesort4([FirstLis|RestLis], SortedList) :-
	split4([FirstLis|RestLis],[Firstsplit4Lis,Restsplit4Lis]),
	mergesort4(Firstsplit4Lis, SortedFirstLis),
	mergesort4(Restsplit4Lis, SortedRestLis),
	mergelists4(SortedFirstLis, SortedRestLis, SortedList).

mergelists4([], M, M).
mergelists4(Lis, [], Lis).
 /* assume L and M are sorted lists*/
mergelists4([FirstLis|RestLis], [FirstM|RestM], [FirstLis|RestLisMerged]) :-
	FirstLis < FirstM,
	mergelists4(RestLis, [FirstM|RestM], RestLisMerged).
mergelists4([FirstLis|RestLis], [FirstM|RestM], [FirstM|RestMMerged]) :-
	mergelists4([FirstLis|RestLis], RestM, RestMMerged).

/* extract elements start to stop into a list */
sublist4([],_,_,_,[]).
sublist4([_|RestLis], Start, Stop, Ctr, sublist4) :-   
	Ctr < Start,
	NextCtr is Ctr + 1,
	sublist4(RestLis, Start, Stop, NextCtr, sublist4).
sublist4(_, _, Stop, Ctr, []) :-   
	Ctr > Stop.
sublist4([FirstLis|RestLis], Start, Stop, Ctr, [FirstLis| sublist4]) :-   
	NextCtr is Ctr + 1,
	sublist4(RestLis, Start, Stop, NextCtr, sublist4).
/* split4 the list in half:,   ; returns ((first half)(second half)) */
split4([], [[],[]]).
split4([OneElement],[[OneElement],[]]).
split4(Lis, [SubLis1,SubLis2]) :-
	length(Lis,Len),
	HalfLen is Len//2,
	HalfLenPlus is HalfLen + 1,
	sublist4(Lis,1,HalfLen, 1, SubLis1),
	sublist4(Lis, HalfLenPlus, Len, 1, SubLis2).

merge5sort5(Xs, Rs) :-
    length(Xs, L),
    (   L < 2 ->
        Rs = Xs
    ;   Split is L//2,
        length(Front0, Split),
        append(Front0, Back0, Xs),
        merge5sort5(Front0, Front),
        merge5sort5(Back0, Back),
        merge5(Front, Back, Rs)
    ).

% merge5 of lists: merge5(+List1, +List2, -Result)

merge5([], Xs, Xs) :- !.
merge5(Xs, [], Xs) :- !.
merge5([X|Xs], [Y|Ys], Zs) :-
    (   X @=< Y ->
        Zs = [X|Rest],
        merge5(Xs, [Y|Ys], Rest)
    ;   Zs = [Y|Rest],
        merge5([X|Xs], Ys, Rest)
    ).

quick_sort2(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(_,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X=<H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X>H,pivoting(H,T,L,G).

mergesort6([],[]).    /* covers special case */
mergesort6([A],[A]).
mergesort6([A,B|R],S) :-  
   split6([A,B|R],L1,L2),
   mergesort6(L1,S1),
   mergesort6(L2,S2),
   merge6(S1,S2,S).

split6([],[],[]).
split6([A],[A],[]).
split6([A,B|R],[A|Ra],[B|Rb]) :-  split6(R,Ra,Rb).

merge6(A,[],A).
merge6([],B,B).
merge6([A|Ra],[B|Rb],[A|M]) :-  A =< B, merge6(Ra,[B|Rb],M).
merge6([A|Ra],[B|Rb],[B|M]) :-  A > B,  merge6([A|Ra],Rb,M).