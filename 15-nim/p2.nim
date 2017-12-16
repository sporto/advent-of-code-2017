import sequtils, strutils

const lookupSize = 5_000_000
const factorA = 16807
const initialA : int64 = 883
const factorB = 48271
const initialB : int64 = 879

proc process(n: int) =
  echo n

proc generateNext(factor: int64, prev: int64): int64 =
  (factor * prev) mod 2147483647

proc generateMany(factor: int64, initial: int64, multipleOf: int): seq[string] =
  var valid = 0
  var prev = initial
  var result = newSeq[string](0)

  while valid < lookupSize:
    let next = generateNext(factor, prev)

    if next mod multipleOf == 0:
      let bin = next.toBin(16)
      result.add(bin)
      valid = valid + 1

    prev = next

  result


proc run() =
  let a = generateMany(factorA, initialA, 4)
  let b = generateMany(factorB, initialB, 8)

  var score = 0

  for pair in zip(a, b):
    if pair.a == pair.b:
      score = score + 1

  echo score

run()