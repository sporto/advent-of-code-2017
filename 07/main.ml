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

type parsed_line = { name : string; children : string list };;

let parseChildren children =
    Str.split (Str.regexp ", ") children

let parseLine (line: string) : (parsed_line, string) result =
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

let setParent (parentName: string) (acc: string StringMap.t) (childrenName: string) : string StringMap.t =
    StringMap.add childrenName parentName acc

let accummulate (acc: string StringMap.t) (parsedLineResult: (parsed_line, string) result) : string StringMap.t =
    match parsedLineResult with
    | Error _ -> acc
    | Ok parsedLine ->
        List.fold_left (setParent parsedLine.name) acc parsedLine.children

(* Process *)

let lines = read_file "input.txt";;

let initialMap =
    StringMap.empty;;

let result =
    lines
        |> List.map parseLine
        |> List.fold_left accummulate initialMap;;



result
    |> StringMap.bindings
    |> List.map (fun (key, _) -> key)
    |> List.map print_string;;