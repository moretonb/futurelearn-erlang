-module(recursion).
-export([fac/1,fib/1,pieces/1,piecesinthreedimensions/1, piecesinanydimensions/2]).

fac(0) ->
  1;
fac(N) when N>0 ->
  fac(N-1)*N.

fib(0) ->
  0;
fib(1) ->
  1;
fib(N) when N>1 ->
  fib(N-2) + fib(N-1).

pieces(0) ->
  1;
pieces(N) when N>0 ->
  pieces(N-1) + N.

piecesinthreedimensions(0) ->
  1;
piecesinthreedimensions(N) when N>0 ->
  piecesinthreedimensions(N-1) + pieces(N-1).

piecesinanydimensions(0,_) ->
  1;
piecesinanydimensions(N,2) when N>0 ->
  pieces(N);
piecesinanydimensions(N,M) when N>0, M>2 ->
  piecesinanydimensions(N-1, M) + piecesinanydimensions(N-1,M-1).