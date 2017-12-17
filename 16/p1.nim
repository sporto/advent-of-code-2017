import os, sequtils, strutils, strscans

type
  InstructionKind = enum Spin, Exchange, Partner, Unknown
  Instruction = object
    case kind: InstructionKind
      of Spin: sa: int
      of Exchange: ea, eb: int
      of Partner: pa, pb: string
      of Unknown: source: string

proc readInput(): seq[string] =
  let input = readFile("input.txt")
  input.split(",")

proc parseInput(source: string): Instruction =
  var sa: int
  var ea, eb : int
  var pa, pb: string

  if scanf(source, "s$i", sa):
    return Instruction(kind: Spin, sa: sa)

  if scanf(source, "x$i/$i", ea, eb):
    return Instruction(kind: Exchange, ea: ea, eb: eb)

  if scanf(source, "p$w/$w", pa, pb):
    return Instruction(kind: Partner, pa: pa, pb: pb)

  Instruction(kind: Unknown, source: source)


proc main() =
  let instructions = readInput()
    .map(parseInput)

  echo instructions

main()