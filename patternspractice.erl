-module(patternspractice).
-export([xOr1/2,xOr2/2,xOr3/2,xOr4/2,xOr5/2,maxThree/3,howManyEqual/3]).

xOr1(true,true) ->
  true;
xOr1(false,false) ->
  true;
xOr1(_,_) ->
  false.

xOr2(X,X) ->
  false;
xOr2(_,_) ->
  true.

xOr3(X,Y) ->
  not (X == Y).

xOr4(X,Y) ->
  X =/= Y.

xOr5(X,Y) ->
  not (X and Y).

maxThree(X,Y,Z) ->
  A = max(X,Y),
  max(A,Z).

howManyEqual(X,X,X) ->
  3;
howManyEqual(X,X,_) ->
  2;
howManyEqual(X,_,X) ->
  2;
howManyEqual(_,X,X) ->
  2;
howManyEqual(_,_,_) ->
  0.