import os, sequtils, strutils, strscans, sets

type
  InstructionKind = enum Spin, Exchange, Partner, Unknown
  Instruction = object
    case kind: InstructionKind
      of Spin: sa: int
      of Exchange: ea, eb: int
      of Partner: pa, pb: string
      of Unknown: source: string

proc reduce[T,U](source: seq[T], f: proc(acc: U, v: T): U, acc: U): U =
  result = acc
  for val in source:
    result = f(result, val)

proc testInput() : seq[string] =
  @["s1", "x3/4", "pe/b"]

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


proc applyIns(acc: string, i: Instruction): string =
  case i.kind
  of Spin:
    let pos = acc.len - i.sa
    acc[pos .. acc.len] & acc[0 .. pos - 1]
  of Exchange:
    let a = acc[i.ea]
    let b = acc[i.eb]
    acc
      .replace(a, '1')
      .replace(b, '2')
      .replace('1', b)
      .replace('2', a)
  of Partner:
    acc
      .replace(i.pa, "1")
      .replace(i.pb, "2")
      .replace("1", i.pb)
      .replace("2", i.pa)
  of Unknown:
    acc

proc dance(instructions: seq[Instruction], programs: string): string =
  instructions
    .reduce(applyIns, programs)


proc main() =
  var programs = "abcdefghijklmnop"
  # var testPrograms = "abcde"

  # let testInstructions = testInput()
  #   .map(parseInput)

  let instructions = readInput()
    .map(parseInput)

  var count = 0
  while count < 1000000000:
    programs = dance(instructions, programs)
    count = count + 1

  echo programs

main()