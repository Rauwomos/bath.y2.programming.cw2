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