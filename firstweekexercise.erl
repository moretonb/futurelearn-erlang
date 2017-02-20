-module(firstweekexercise).
-export([perimeter/1,area/1,enclose/1,bits/1]).
-include_lib("eunit/include/eunit.hrl").

%For perimeter/1, area/1 and enclose/1 valid shapes include:
%- triangle
%- square
%- rectangle
%- circle
%Representations of these shapes also cover all use cases.
perimeter({triangle,A,B,C}) when A+B>C,A+C>B,B+C>A -> A+B+C;
perimeter({square,A}) when A>=0 -> 4*A;
perimeter({rectangle,W,H}) when W>=0,H>=0 -> 2*(W+H);
perimeter({circle,R}) when R>=0 -> 2*math:pi()*R.

%Tests written with http://erlang.org/doc/apps/eunit/chapter.html
%I've tried to explore edge and failure cases too to ensure there are
%some guard clauses to prevent unwanted side effects e.g. with negative
%inputs. I considered putting the tests in separate files but I thought
%for the purposes of the assignment this would suffice to make it readable.
%To run tests compile then execute firstweekexercise:test(). For help with
%path issues to eunit there is more documentation on the previous link.

%Perimeter tests
%Triangle
perimeter_triangle_test() -> 9 = perimeter({triangle,4,2,3}).
%As a side effect of wanting valid triangles I am less lenient on zero.
perimeter_triangle_zero_test() -> 
  ?assertError(function_clause, perimeter({triangle,0,0,0})).
perimeter_triangle_minus_first_side_test() -> 
  ?assertError(function_clause, perimeter({triangle,-6,2,4})).
perimeter_triangle_minus_second_side_test() -> 
  ?assertError(function_clause, perimeter({triangle,6,-2,4})).
perimeter_triangle_minus_third_side_test() -> 
  ?assertError(function_clause, perimeter({triangle,6,2,-4})).
%Here I leaned on https://www.varsitytutors.com/hotmath/hotmath_help/topics/triangle-inequality-theorem
%to see if 3 given sides produced a valid triangle and added an 
%appropriate guard. The guard causes a function_clause error for 
%consistency sake.
perimeter_triangle_invalid_triangle_test() -> 
  ?assertError(function_clause, perimeter({triangle,5,8,3})).
%Square
perimeter_square_test() -> 28 = perimeter({square,7}).
perimeter_square_zero_test() -> 0 = perimeter({square,0}).
perimeter_square_minus_number_test() -> 
  ?assertError(function_clause, perimeter({square,-6})).
%Rectangle
perimeter_rectangle_test() -> 24.8 = perimeter({rectangle,4.4,8}).
perimeter_rectangle_zero_test() -> 0 = perimeter({rectangle,0,0}).
perimeter_rectangle_minus_width_test() -> 
  ?assertError(function_clause, perimeter({rectangle,-6,2})).
perimeter_rectangle_minus_height_test() -> 
  ?assertError(function_clause, perimeter({rectangle,6,-2})).
%Circle
perimeter_circle_test() -> 144.51326206513048 = perimeter({circle,23}).
perimeter_circle_zero_test() -> 0.0 = perimeter({circle,0}).
perimeter_circle_minus_number_test() -> 
  ?assertError(function_clause, perimeter({circle,-6})).
%Other
perimeter_invalid_shape_test() -> 
  ?assertError(function_clause, perimeter({badger,0})).

%I've chosen to go with https://en.wikipedia.org/wiki/Heron's_formula
%so I can maintain the same description of a triangle. I could have asked
%for more information as an alternative e.g. the height; but I thought
%this might be neater and provide a more consistent interface.
area({triangle,A,B,C}) when A+B>C,A+C>B,B+C>A ->
  S = (A+B+C)/2,
  math:sqrt(S*(S-A)*(S-B)*(S-C));
area({square,A}) when A>=0 -> A*A;
area({rectangle,W,H}) when W>=0,H>=0 -> W*H;
area({circle,R}) when R>=0 -> math:pi()*R*R.

%Area tests
%Triangle
area_triangle_test() -> 8.181534085976786 = area({triangle,4,8,5}).
area_triangle_zero_test() -> 
  ?assertError(function_clause, area({triangle,0,0,0})).
area_triangle_minus_first_side_test() -> 
  ?assertError(function_clause, area({triangle,-6,2,4})).
area_triangle_minus_second_side_test() -> 
  ?assertError(function_clause, area({triangle,6,-2,4})).
area_triangle_minus_third_side_test() -> 
  ?assertError(function_clause, area({triangle,6,2,-4})).
area_triangle_invalid_triangle_test() -> 
  ?assertError(function_clause, area({triangle,5,8,3})).
%Square
area_square_test() -> 49 = area({square,7}).
area_square_zero_test() -> 0 = area({square,0}).
area_square_minus_number_test() -> 
  ?assertError(function_clause, area({square,-6})).
%Rectangle
area_rectangle_test() -> 35.2 = area({rectangle,4.4,8}).
area_rectangle_zero_test() -> 0 = area({rectangle,0,0}).
area_rectangle_minus_width_test() -> 
  ?assertError(function_clause, area({rectangle,-6,2})).
area_rectangle_minus_height_test() -> 
  ?assertError(function_clause, area({rectangle,6,-2})).
%Circle
area_circle_test() -> 1661.9025137490005 = area({circle,23}).
area_circle_zero_test() -> 0.0 = area({circle,0}).
area_circle_minus_number_test() -> 
  ?assertError(function_clause, area({circle,-6})).
%Other
area_invalid_shape_test() -> 
  ?assertError(function_clause, area({badger,0})).

%Triangles present the biggest challenge again here. For simplicity I first 
%find the longest side and treat it as the base using the handy lists:max 
%function. Then calculate the height by working backwards from the area.
enclose({triangle,A,B,C}) when A+B>C,A+C>B,B+C>A ->
  X = lists:max([A,B,C]),
  Y = area({triangle,A,B,C}),
  H = Y/(0.5*X),
  {rectangle,X,H};
enclose({square,A}) when A>=0 -> {rectangle,A,A};
enclose({rectangle,W,H}) when W>=0,H>=0 -> {rectangle,W,H};
enclose({circle,R}) when R>=0 ->
  D=2*R,
  {rectangle,D,D}.

%Enclose tests
%Triangle
enclose_triangle_test() -> {rectangle,8,2.0453835214941964} = enclose({triangle,4,8,5}).
%In this case the zero case would break the function, I've chosen to have
%a guard rather than letting a badarith error propagate to keep it
%consistent with other undesired behaviour. After writing this I also
%looked into validating triangles which further pushed for this approach.
enclose_triangle_zero_test() -> 
  ?assertError(function_clause, enclose({triangle,0,0,0})).
enclose_triangle_minus_first_side_test() -> 
  ?assertError(function_clause, enclose({triangle,-6,2,4})).
enclose_triangle_minus_second_side_test() -> 
  ?assertError(function_clause, enclose({triangle,6,-2,4})).
enclose_triangle_minus_third_side_test() -> 
  ?assertError(function_clause, enclose({triangle,6,2,-4})).
enclose_triangle_invalid_triangle_test() -> 
  ?assertError(function_clause, enclose({triangle,5,8,3})).
%Square
enclose_square_test() -> {rectangle,7,7} = enclose({square,7}).
enclose_square_zero_test() -> {rectangle,0,0} = enclose({square,0}).
enclose_square_minus_number_test() -> 
  ?assertError(function_clause, enclose({square,-6})).
%Rectangle
enclose_rectangle_test() -> {rectangle,4.4,8} = enclose({rectangle,4.4,8}).
enclose_rectangle_zero_test() -> {rectangle,0,0} = enclose({rectangle,0,0}).
enclose_rectangle_minus_width_test() -> 
  ?assertError(function_clause, enclose({rectangle,-6,2})).
enclose_rectangle_minus_height_test() -> 
  ?assertError(function_clause, enclose({rectangle,6,-2})).
%Circle
enclose_circle_test() -> {rectangle,46,46} = enclose({circle,23}).
enclose_circle_zero_test() -> {rectangle,0,0} = enclose({circle,0}).
enclose_circle_minus_number_test() -> 
  ?assertError(function_clause, enclose({circle,-6})).
%Other
enclose_invalid_shape_test() -> 
  ?assertError(function_clause, enclose({badger,0})).

%%Direct recursion
%bits(0) -> 0;
%bits(N) when N>=0 -> bits(N div 2) + N rem 2.

%Tail recursion
bits(N) when N>=0 -> bits(N,0).

bits(0,A) -> A;
bits(N,A) -> bits(N div 2, A+(N rem 2)).

%In terms of readability I quite like the direct recursive form. In terms
%of performance tail be slightly better. However in this case I can't see
%bits/1 gaining a large stack in its direct form, so I would probably
%use the direct form for production. Mostly because readability and
%maintainability frequently trump (and should) minor performance increases.
%That said the team or company may have a style guide that prefers tail
%recursion too so in that case I would stick to the local convention.

%Bits tests
bits_test() -> 3 = bits(7).
bits_less_bits_higher_number_test() -> 1 = bits(8).
bits_zero_test() -> 0 = bits(0).
bits_minus_number_test() ->
 ?assertError(function_clause, bits(-786125371263)).

%In all tests I have excluded finding an upper edge case (a really big 
%number) because of how the bignum arithmetic works in erlang. For more
%information see http://erlang.org/doc/efficiency_guide/advanced.html