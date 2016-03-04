dd_list([[[2,3,5,6]|C]|T], [C|T], 2, 3,_).
dd_list(A,L,1,Y,M) :- Z is Y-1, X is Z-1, dd_list(A,[[]|L],X,Z,M).
dd_list(A,L,X,Y,M) :- X+Y>M, Z is M-Y, dd_list(A,L,Z,Y,M).
dd_list(A,[C|T],X,Y,M) :- Z is X-1, S is X+Y, P is X*Y, dd_list(A,[[[X,Y,S,P]|C]|T],Z,Y,M).

dd_sort([],M,M):-!.
dd_sort([H|T],M,A):-merge(H,M,D),!,dd_sort(T,D,A).

merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(List,Sorted) :- List=[_,_|_],divide(List,L1,L2), merge_sort(L1,Sorted1),merge_sort(L2,Sorted2), merge(Sorted1,Sorted2,Sorted).

merge([[]],L,L).
merge(L,[[]],L):-L\=[].
merge([[[X1,Y1,S1,P1]|T1]],[[[X2,Y2,S2,P2]|T2]],[[[X1,Y1,S1,P1]|T]]):- P1=<P2,merge([T1],[[[X2,Y2,S2,P2]|T2]],[T]).
merge([[[X1,Y1,S1,P1]|T1]],[[[X2,Y2,S2,P2]|T2]],[[[X2,Y2,S2,P2]|T]]):- P1>P2,merge([[[X1,Y1,S1,P1]|T1]],[T2],[T]).

divide(L,L1,L2):-halve(L,L1,L2).
halve(L,A,B):-hv(L,L,A,B).  
hv([],R,[],R).   % for lists of even length
hv([_],R,[],R).  % for lists of odd length
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31|L],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31|L1],R):-hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15|L],[A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15|L1],R):-hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_|T],[A0,A1,A2,A3,A4,A5,A6,A7|L],[A0,A1,A2,A3,A4,A5,A6,A7|L1],R):-hv(T,L,L1,R),!.
hv([_,_,_,_,_,_,_,_|T],[A,B,C,D|L],[A,B,C,D|L1],R):-hv(T,L,L1,R),!.
hv([_,_,_,_|T],[A,B|L],[A,B|L1],R):-hv(T,L,L1,R),!.
hv([_,_|T],[X|L],[X|L1],R):-hv(T,L,L1,R),!.

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

run(A):-dd_list(Q,[[]],2,98,100),merge_sort(Q,[S]),remove_singleton(S,[],A),!.