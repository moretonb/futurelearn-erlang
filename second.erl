-module(second).
-export([hypotenuse/2,perimeter/2,area/2]).

hypotenuse(X,Y) ->
  A = first:square(X) + first:square(Y),
  math:sqrt(A).

perimeter(X,Y) ->
  A = hypotenuse(X,Y),
  A+X+Y.

area(X,Y) ->
  first:mult(X,Y)/2.