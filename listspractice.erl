-module(listspractice).
-export([product/1,producttail/1,maximum/1,maximumtail/1,double/1,evens/1,mode/1,median/1]).

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

double(X) -> double(X,[]).

double([],A) -> A;
double([X|Xs],A) -> double(Xs,A++[X*2]).

evens(X) -> evens(X,[]).

evens([],A) -> A;
evens([X|Xs],A) when X rem 2 == 0 -> evens(Xs, A++[X]);
evens([_|Xs],A) -> evens(Xs, A).

median(X) ->
  SortedList = lists:sort(X),
  Length = lists:flatlength(SortedList),
  MiddleIndex = Length div 2 + 1,
  case Length rem 2 of
    0 -> (lists:nth(MiddleIndex, SortedList) + lists:nth(MiddleIndex + 1, SortedList)) / 2;
    _ -> lists:nth(MiddleIndex, SortedList)
  end.

mode(X) -> 
  KeysWithFrequency = lists:foldl(fun(Element, Accumulator) -> 
      elementFrequency(Element, Accumulator) 
    end, [], lists:sort(X)),
  {HighestFrequency,_} = lists:max(KeysWithFrequency),
  lists:filtermap(fun({Frequency, Key}) ->
      case Frequency == HighestFrequency of
        true -> {true, Key};
        _ -> false
      end
    end, KeysWithFrequency).

elementFrequency(Element, [{Frequency,Key}|Frequencies]) when Element == Key ->
  [{Frequency+1,Key}|Frequencies];
elementFrequency(Element, X) ->
  [{1,Element}|X].

