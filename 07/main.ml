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

module StringMap = Map.Make(String);;

type ('a, 'b) result =
  | Ok of 'a
  | Error of 'b

type parsedLine = { name : string; children : string list };;

let initial =
    StringMap.empty;;

let parseChildren children =
    Str.split (Str.regexp ", ") children

let parseLine line =
    match (Str.split (Str.regexp "->") line) with
    | [] -> Error "Invalid"
    | x :: afterArrow ->
        match (Str.split (Str.regexp " ") x) with
        | [] -> Error "Invalid"
        | name::num ->
            match afterArrow with
            | [] ->
                Ok { name = name; children = [] }
            | children::_ ->
                Ok { name = name; children = parseChildren children }

let parsedToString parsed =
    match parsed with
        | Error err ->
            err
        | Ok parsedLine ->
            parsedLine.name

(* Process *)

let lines = read_file "input.txt";;

let result =
    lines
        |> List.map parseLine
        |> List.map parsedToString;;

result
    |> List.map print_string;;