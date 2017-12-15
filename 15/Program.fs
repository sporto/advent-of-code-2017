﻿// Learn more about F# at http://fsharp.org

open System

let rec intToBinary i =
    match i with
    | 0UL | 1UL -> string i
    | _ ->
        let bit = string (i % 2UL)
        (intToBinary (i / 2UL)) + bit

let generate factor prev =
    (prev * factor) % 2147483647UL

let lowest16 str =
    let len = String.length str
    let l = len - 1
    let f = l - 16
    str.[f..l]

let compareBinaries a b =
    if lowest16 a = lowest16 b then
        1
    else
        0

type Accumulator =
    {
        factorA : uint64;
        prevA : uint64;
        factorB : uint64;
        prevB : uint64;
        result : int
    }

let initialAcc =
    {
        factorA = 16807UL;
        prevA = 65UL;
        factorB = 48271UL
        prevB = 8921UL;
        result = 0
    }

let accumulate acc _ =
    let newA = generate acc.factorA acc.prevA
    let newB = generate acc.factorB acc.prevB
    let bA = intToBinary newA
    let bB = intToBinary newB
    let score = compareBinaries bA bB
    {
        factorA = acc.factorA;
        prevA = newA;
        factorB = acc.factorB;
        prevB = newB;
        result = acc.result + score
    }

[<EntryPoint>]
let main argv =
    [1..5]
        |> List.fold accumulate initialAcc
        |> (fun acc -> printfn "%s" (string acc.result))

    // generators
    //    |> List.map (fun gen -> generateMany gen.factor gen.start 5)
    //    |> List.zip
    //    |> List.fold compare 0
    //    |> (fun res -> printfn "%s" (string res))

    // generateMany 16807UL 65UL 5
    //    |> List.map (fun n -> printfn "%s" n )

        //|> List.map (fun n -> printfn "%s" (string n) )
    // printfn "%s" (string res)
    0 // return an integer exit code