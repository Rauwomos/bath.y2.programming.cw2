%% Removes all the quadruples from the list where there is only one quadruple in the list with a quadruple's product
remove_singleton2([],L,L,S,S).
	% X
remove_singleton2([[_,_,S1,_]],Ls,Aq,Ss,As):-remove_singleton2([],Ls,Aq,[S1|Ss],As).
	% X X
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P1]],Ls,Aq,Ss,As):-remove_singleton2([],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y
remove_singleton2([[_,_,S1,P1],[_,_,S2,P2]],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton2([],Ls,Aq,[S2,S1|Ss],As).
	% X X X
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],Ls,Aq,Ss,As):-remove_singleton2([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|L],[[X1,Y1,S1,P1]|Ls],Aq,Ss,As).
	% X X Y
remove_singleton2([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P2]|L],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton2([[X3,Y3,S3,P2]|L],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|Ls],Aq,Ss,As).
	% X Y Y
remove_singleton2([[_,_,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|L],Ls,Aq,Ss,As):-!,P1\=P2, remove_singleton2([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|L],Ls,Aq,[S1|Ss],As).
	% X Y Z
remove_singleton2([[_,_,S1,P1],[_,_,S2,P2],[X3,Y3,S3,P3]|L],Ls,Aq,Ss,As):-!,P1\=P2, !,P1\=P3, !,P2\=P3, remove_singleton2([[X3,Y3,S3,P3]|L],Ls,Aq,[S2,S1|Ss],As).
