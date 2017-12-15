open System

let leftpad n c s =
  let l = String.length s
  match l <= n with
    | true -> (String.replicate (n-l) c) + s
    | false -> s

let rec intToBinary i =
    match i with
    | 0UL | 1UL -> string i
    | _ ->
        let bit = string (i % 2UL)
        (intToBinary (i / 2UL)) + bit

let intToBinaryPadded i =
    intToBinary i |> leftpad 32 "0"

let generate factor prev =
    (prev * factor) % 2147483647UL

let lowest16 str =
    str.[16..31]

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
    let bA = intToBinaryPadded newA
    let bB = intToBinaryPadded newB
    let score = compareBinaries bA bB
    {
        factorA = acc.factorA;
        prevA = newA;
        factorB = acc.factorB;
        prevB = newB;
        result = acc.result + score
    }

let lookupSize =
    5
    // 40_000_000

[<EntryPoint>]
let main argv =
    [1..lookupSize]
        |> List.fold accumulate initialAcc
        |> (fun acc -> printfn "%s" (string acc.result))
    0 // return an integer exit code
