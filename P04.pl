# P04 (*): Find the number of elements of a list.

# The first one I solved without using the answer, using what I learned from the previous problems.

# list_length(X,L) :- the list L contains X elements
#    (integer,list) (+,?) 

# Note: length(?List, ?Int) is predefined

list_length(0,[]).
list_length(X,[_|L]) :-list_length(X1,L), X is X1 + 1.