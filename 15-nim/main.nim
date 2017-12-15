import sequtils, strutils

# const lookupSize  = 5
const lookupSize = 40_000_000

proc process(n: int) =
  echo n

proc generate(factor: int64, prev: int64): int64 =
  (factor * prev) mod 2147483647

proc run() =
  var factorA = 16807
  var prevA : int64 = 883
  var factorB = 48271
  var prevB : int64 = 879
  var score = 0

  for i in 0..(lookupSize-1):
    prevA = generate(factorA, prevA) 
    prevB = generate(factorB, prevB)
    let binA = prevA.toBin(16)
    let binB = prevB.toBin(16)

    if binA == binB:
      score = score + 1

  echo score

run()