// Learn more about F# at http://fsharp.org

open System

let factors = 
    [16807, 48271]

let startValues =
    [65, 8921]

let generate factor prev _ =
    (prev * factor) % 2147483647I

let generateMany factor start =
    List.scan (generate factor) start [1..5]

let rec intToBinary i =
    match i with
    | 0 | 1 -> string i
    | _ ->
        let bit = string (i % 2)
        (intToBinary (i / 2)) + bit

[<EntryPoint>]
let main argv =
    generateMany 16807I 65I
        |> List.map intToBinary
        |> List.map printfn
    //    |> List.map (fun n -> printfn "%s" (string n) )
    // printfn (string first5)
    0 // return an integer exit code
