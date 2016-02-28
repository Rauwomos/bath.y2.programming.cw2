remove_sum([],_,[],_).
remove_sum([[[X,Y,S,P]|L]|D],D,[[X,Y,S,P]|L],Sum):-S\=Sum,!.
remove_sum(A,D,[[X,Y,S,P]|L],Sum):-S=Sum,remove_sum(A,[[X,Y,S,P]|D],L,Sum).

run([A|R]):-remove_sum([A|R],[],[[1,1,3,1],[1,1,3,1],[2,2,3,2],[1,2,4,1]],3).