-module(listspractice).
-export([product/1,producttail/1,maximum/1,maximumtail/1]).

%Product of an empty list is 1 because 1* does not effect the product of
%other lists.
product([]) -> 1;
product([X|Xs]) -> X*product(Xs).

producttail(X) -> producttail(X, 1).

producttail([], A) -> A;
producttail([X|Xs], A) -> producttail(Xs,A*X).

maximum([A]) -> A;
maximum([X|Xs]) -> max(X, maximum(Xs)).

maximumtail(X) -> maximumtail(X,0).

maximumtail([X],C) -> max(X,C);
maximumtail([X|Xs],C) when X>C -> maximumtail(Xs,X);
maximumtail([_|Xs],C) -> maximumtail(Xs,C).