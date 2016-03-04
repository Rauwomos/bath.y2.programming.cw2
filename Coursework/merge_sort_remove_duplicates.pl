%% Does a merge sort on the list of quadruples, sorting by the product
merge_sort_rd([],[]).
merge_sort_rd([X],[X]).
merge_sort_rd(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort_rd(L1,Sorted1),merge_sort_rd(L2,Sorted2), merge_rd(Sorted1,Sorted2,Sorted).

merge_rd([],L,L).
merge_rd(L,[],L):-L\=[].
merge_rd([S1|T1],[S2|T2],[S1|T]):- S1<S2,merge_rd(T1,[S2|T2],T).
merge_rd([S1|T1],[S2|T2],[S1|T]):- S1==S2,merge_rd(T1,T2,T).
merge_rd([S1|T1],[S2|T2],[S2|T]):- S1>S2,merge_rd([S1|T1],T2,T).

divide(L,L1,L2):-hv(L,L,L1,L2).  
hv([],R,[],R).   % for lists of even length
hv([_],R,[],R).  % for lists of odd length
hv([_,_|T],[X|L],[X|L1],R):-hv(T,L,L1,R).