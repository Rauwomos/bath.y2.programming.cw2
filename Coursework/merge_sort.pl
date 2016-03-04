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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

mergesort2([],[]).    /* covers special case */
mergesort2([A],[A]).
mergesort2([A,B|R],S) :-  
   split2([A,B|R],L1,L2),
   mergesort2(L1,S1),
   mergesort2(L2,S2),
   merge2(S1,S2,S).

split2([],[],[]).
split2([A],[A],[]).
split2([A,B|R],[A|Ra],[B|Rb]) :-  split2(R,Ra,Rb).

merge2(A,[],A).
merge2([],B,B).
merge2([A|Ra],[B|Rb],[A|M]) :-  A =< B, merge2(Ra,[B|Rb],M).
merge2([A|Ra],[B|Rb],[B|M]) :-  A > B,  merge2([A|Ra],Rb,M).