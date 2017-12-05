import os, sequtils, strutils, math

proc processLine(line: string): float =
  let nums = line
    .splitWhitespace()
    .map(parseFloat)

  # part 1
  # let min = foldl(nums, min(a, b))
  # let max = foldl(nums, max(a, b))

  # max - min

  # part 2
  for i in nums:
    for j in nums:
      if fmod(j, i) == 0.0 and j != i:
        result = j / i

let input = readFile("input.txt")

let lines = input
  .splitLines()
  .map(processLine)
  .foldl(a + b)

echo lines

