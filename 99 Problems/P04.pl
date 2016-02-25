# P04 (*): Find the number of elements of a list.

# The first one I solved without using the answer, using what I learned from the previous problems.

# list_length(X,L) :- the list L contains X elements
#    (integer,list) (+,?) 

# Note: length(?List, ?Int) is predefined

# my_length([],0).
# my_length([_|L],N) :- my_length(L,N1), N is N1 + 1.

# my_length([],0).
# my_length([_|L],N) :- my_length(L,N1), N is N1 + 1.