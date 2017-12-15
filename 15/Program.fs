// Learn more about F# at http://fsharp.org

open System

let factors = 
    [16807, 48271]

let startValues =
    [65, 8921]

let rec intToBinary i =
    match i with
    | 0UL | 1UL -> string i
    | _ ->
        let bit = string (i % 2UL)
        (intToBinary (i / 2UL)) + bit

let generate factor prev _ =
    (prev * factor) % 2147483647UL

let generateMany factor start howMany =
    List.scan (generate factor) start [1..howMany]
        |> List.map intToBinary

[<EntryPoint>]
let main argv =
    generateMany 16807UL 65UL 5
        |> List.map (fun n -> printfn "%s" n )

        //|> List.map (fun n -> printfn "%s" (string n) )
    // printfn (string first5)
    0 // return an integer exit code
