import sequtils, strutils

const lookupSize = 40_000_000
const lookupSizeP2 = 5_000_000
const factorA = 16807
const initialA : int64 = 883
const factorB = 48271
const initialB : int64 = 879

proc process(n: int) =
  echo n

proc generate(factor: int64, prev: int64): int64 =
  (factor * prev) mod 2147483647

proc runP1() =
  var prevA = initialA
  var prevB = initialB
  var score = 0

  for i in 0..(lookupSize-1):
    prevA = generate(factorA, prevA) 
    prevB = generate(factorB, prevB)
    let binA = prevA.toBin(16)
    let binB = prevB.toBin(16)

    if binA == binB:
      score = score + 1

  echo score

# proc runP2() =
#   var prevA = initialA
#   var prevB = initialB
#   var score = 0
#   var pairs = 0

#   while pairs < lookupSizeP2:
#     prevA = generate(factorA, prevA) 
#     prevB = generate(factorB, prevB)

runP1()