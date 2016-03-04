remove_sums(L,L,[]).
remove_sums([],[],_).
remove_sums([[X,Y,S1,P]|A],[[X,Y,S1,P]|T1],[S2|T2]):-S1<S2,!,remove_sums(A,T1,[S2|T2]).
remove_sums(A,[[_,_,S1,_]|T1],[S2|T2]):-S1=S2,!,remove_sums(A,T1,[S2|T2]).
remove_sums(A,[[X,Y,S1,P]|T1],[S2|T2]):-S1>S2,!,remove_sums(A,[[X,Y,S1,P]|T1],T2).

run(A):-remove_sums(A,[[1,1,2,1],[1,1,3,1],[2,2,4,2]],[3,4]).