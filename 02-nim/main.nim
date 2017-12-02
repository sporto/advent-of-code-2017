import os, sequtils, strutils

proc processLine(line: string): int =
  let nums = line
    .splitWhitespace()
    .map(parseInt)

  let min = foldl(nums, min(a, b))
  let max = foldl(nums, max(a, b))

  max - min

let input = readFile("input.txt")

let lines = input
  .splitLines()
  .map(processLine)
  .foldl(a + b)

echo lines

