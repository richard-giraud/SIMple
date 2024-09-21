:- use_module(library(tty), [tty_clear/0]).

:- object(renderer).
    character(outer_border, top_left_corner, "╔").
    character(outer_border, top_side, "═").
    character(outer_border, top_right_corner, "╗").
    character(outer_border, right_side, "║").
    character(outer_border, bottom_right_corner, "╝").
    character(outer_border, bottom_side, "═").
    character(outer_border, bottom_left_corner, "╚").
    character(outer_border, left_side, "║").

    :-public(render/0).
    render :-
        tty:tty_clear,
        tty_size(Rows, Columns),
        AdjustedColumns is Columns - 5,
        AdjustedRows is Rows - 5,
        loop_grid(AdjustedColumns, AdjustedRows),
        write("\n").

    loop_grid(Columns, Rows) :-
        MaxRow is Rows - 1,
        MaxColumn is Columns - 1,
        loop_grid(0, MaxColumn, 0, MaxRow).

    % Reached bottom-right corner, done.
    loop_grid(MaxColumn, MaxColumn, MaxRow, MaxRow) :-
        write_character(MaxColumn, MaxColumn, MaxRow, MaxRow).

    % Reached right side, advance row and start at left again.
    loop_grid(MaxColumn, MaxColumn, CurrentRow, MaxRow) :-
        write_character(MaxColumn, MaxColumn, CurrentRow, MaxRow),
        write("\n"),
        NewRow is CurrentRow + 1,
        loop_grid(0, MaxColumn, NewRow, MaxRow).

    % Otherwise, advance column
    loop_grid(CurrentColumn, MaxColumn, CurrentRow, MaxRow) :-
       write_character(CurrentColumn, MaxColumn, CurrentRow, MaxRow),
       NewColumn is CurrentColumn + 1,
       loop_grid(NewColumn, MaxColumn, CurrentRow, MaxRow).

    % Top row
    write_character(0, _, 0, _) :-
        character(outer_border, top_left_corner, C),
        write(C).
    write_character(MaxColumn, MaxColumn, 0, _) :-
        character(outer_border, top_right_corner, C),
        write(C).
    write_character(_, _, 0, _) :-
        character(outer_border, top_side, C),
        write(C).

    % Bottom row
    write_character(0, _, MaxRow, MaxRow) :-
        character(outer_border, bottom_left_corner, C),
        write(C).
    write_character(MaxColumn, MaxColumn, MaxRow, MaxRow) :-
        character(outer_border, bottom_right_corner, C),
        write(C).
    write_character(_, _, MaxRow, MaxRow) :-
        character(outer_border, bottom_side, C),
        write(C).

    % Other rows
    write_character(0, _, _, _) :-
        character(outer_border, left_side, C),
        write(C).
    write_character(MaxColumn, MaxColumn, _, _) :-
        character(outer_border, right_side, C),
        write(C).
    write_character(_, _, _, _) :- write(".").

    merge_strings(Strings, String) :-
        merge_strings("", Strings, String).

    merge_strings(Acc, [], Acc).
    merge_strings(Acc, [String | Strings], Output) :-
        string_concat(Acc, String, NewAcc),
        merge_strings(NewAcc, Strings, Output).
:- end_object.
