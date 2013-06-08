%%% @doc
-module(herl_maybe).

%%%_* Exports ==========================================================
-export([return/1, bind/2, fail/1]).

%%%_* Includes =========================================================
-include_lib("eunit/include/eunit.hrl").

%%%_* Types ============================================================
-type maybe(X) :: {just, X} | none.

%%%_* API ==============================================================

-spec return(X) -> maybe(X).
return(X) -> {just, X}.

-spec bind(maybe(X), fun((X) -> maybe(Y))) -> maybe(Y).
bind({just, X}, Fun) -> Fun(X);
bind(none, _)        -> none.

fail(_) -> none.

%%%_* Private Functions ================================================

maybe_test() ->
    [ ?assertEqual({just, 5}, bind(return(3), fun(X) -> msum(2, X) end))
    , ?assertEqual(
         {just, 2},

         bind(return(2) , fun(X) ->
         bind(msum(X, 3), fun(Y) ->
         bind(mdiv(Y, 2), fun(Z) ->
         return(Z)

         end) end) end))

    , ?assertEqual(
         none,

         bind(return(0) , fun(X) ->
         bind(mdiv(2, X), fun(Y) ->
         bind(msum(2, Y), fun(Z) ->
         return(Z)

         end) end) end))
    ].

mdiv(_, 0) -> none;
mdiv(X, Y) -> return(X div Y).

msum(X, Y) -> return(X + Y).

%%%_* Emacs ============================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 4
%%% End:
