/* rw562 Rowan Walshe

THIS WORK IS ENTIRELY MY OWN.

The program does <or does not, choose which is appropriate> produce multiple answers.

I have <or I have not, choose which is appropriate> used built-ins.

1. <Number of elements in the list binding Q after executing s1(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s1.>

2. <Number of elements in the list binding Q after executing s2(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s2.>

3. <Number of elements in the list binding Q after executing s3(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s3.>

4.
<At most 300 characters of clear text on the main idea for the definition of s4.>

5. <Number of elements in the list binding Q after executing s4(Q,500)>
s4(Q,500) uses <number> inferences. */


/* <BODY OF THE PROGRAM> */

%% Step 1
%%   Part 1
%%     Create my own append function
%%       Instead of having a specific append function I'm just going to add each quadruple to the list after I generate each one  Part 2
%%     Create a function that creates a list of [X, Y, X+Y, X*Y] (here on known as a quadruple)
%%      
%%   Part 3
%%     Create a function that sorts a list of quadruples by X*Y
%%   Part 4
%%     Create a function that removes all the quadruples where there is not another quadruple with the same X*Y 

list_count(X,X,0).
list_count(X,L,N) :- M is N - 1, list_count(X,[N|L],M).

%% Count down from 50 to 3
%% For each count add count to 2 to the list
%%  N is first term, decrease after 47 to start then 46 etc.
%%  M is second term, decreases every step from R-N to 
%%  R is the original value (ie 100 or 500)
%% dd_list
dd_list(X, X, 3 , 2).
dd_list(X,L,N,2) :- dd_list(X,[[N,2]|L],N-1,N-2).
dd_list(X,L, N, M) :- dd_list(X,[[N,M]|L],N,M-1).