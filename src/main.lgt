:- include('renderer').

:- object(main).
    :- public(greet/0).
    greet :-
        renderer::render,
        halt.
:- end_object.
