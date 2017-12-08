open Str;;

let read_file filename = 
    let lines =
        ref [] in
    let chan =
        open_in filename in
    try
      while true; do
        lines := input_line chan :: !lines
      done; !lines
    with End_of_file ->
      close_in chan;
      List.rev !lines ;;




(* Discard all singles *)
(* Parse only the -> *)


(* type branch =
    | Branch of string * (branch list);; *)

module StringMap = Map.Make(String);;

let initial =
    StringMap.empty;;

let parseLine line =
    match (Str.split (Str.regexp "->") line) with
    | [] -> ""
    | x :: xs ->
        match (Str.split (Str.regexp " ") x) with
        | [] -> ""
        | name::num -> name

    (* let
        parts =
            Str.split (Str.regexp "->") line in

        nameParts =
            Str.split (Str.regexp " ") parts[0] in

        name =
            nameParts[0] in
    name;;
 *)
(* Process *)

let lines = read_file "input.txt";;

let result =
    List.map  parseLine lines;;

result
    |> List.map print_string;;