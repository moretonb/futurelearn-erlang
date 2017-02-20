-module(tailrecursion).
-export([sum/1,fib/1,perfect/1]).

sum(0) ->
  0;
sum(N) when N>0 ->
  sum(N-1, N).

sum(0,A) ->
  A;
sum(N,A) when N>0 ->
  sum(N-1, A+N).

fib(0) ->
  0;
fib(1) ->
  1;
fib(N) when N>1 ->
  fib(N-2, 0, 1).

fib(0,A,B) ->
  A+B;
fib(N,A,B) ->
  fib(N-1,B,B+A).

perfect(N) when N<6 ->
  false;
perfect(N) when N>5 ->
  perfect(N div 2,0,N).

perfect(0,A,N) ->
  N == A;
perfect(C,A,N) when (N rem C) == 0 ->
  perfect(C-1,A+C,N);
perfect(C,A,N) ->
  perfect(C-1,A,N).