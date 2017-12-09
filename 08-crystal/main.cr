path = "input.txt"

enum Operation
  Inc
  Dec
  Unknown
end

enum Condition
  Equal
  NotEqual
  MoreThan
  LessThan
  EqualOrMoreThan
  EqualOrLessThan
  Unknown
end

struct Instruction
  property source
  property target
  property operation
  property amount
  property condition_left
  property condition
  property condition_right

  def initialize(@source : String, @target : String, @operation : Operation, @amount : Int16, @condition_left : String, @condition : Condition, @condition_right : Int16)
  end
end

def parse_operation(op : String) : Operation
  case op
  when "inc"
    Operation::Inc
  when "dec"
    Operation::Dec
  else
    Operation::Unknown
  end
end

def parse_condition(cond : String) : Condition
  case cond
  when "=="
    Condition::Equal
  when "!="
    Condition::NotEqual
  when "<"
    Condition::LessThan
  when ">"
    Condition::MoreThan
  when "<="
    Condition::EqualOrLessThan
  when ">="
    Condition::EqualOrMoreThan
  else
    Condition::Unknown
  end
end

def parse_line(source : String) : Instruction
  # sd dec 441 if k != 0
  parts = source.split(" ")
  target = parts[0]
  operation = parse_operation(parts[1])
  amount = parts[2].to_i16
  iff = parts[3]
  condition_left = parts[4]
  condition = parse_condition parts[5]
  condition_right = parts[6].to_i16

  ins = Instruction.new(source, target, operation, amount, condition_left, condition, condition_right)

  ins
end

def condition_passes?(registers, instruction : Instruction) : Bool
  value = registers.fetch(instruction.condition_left) { |_| 0 }
  target = instruction.condition_right

  case instruction.condition
  when Condition::Equal
    value == target
  when Condition::NotEqual
    value != target
  when Condition::LessThan
    value < target
  when Condition::MoreThan
    value > target
  when Condition::EqualOrLessThan
    value <= target
  when Condition::EqualOrMoreThan
    value >= target
  else
    false
  end
end

def apply_instruction(inst : Instruction, registers)
  target_key = inst.target
  current_value = registers.fetch(target_key) { |k| 0 }

  result = case inst.operation
           when Operation::Inc
             current_value + inst.amount
           when Operation::Dec
             current_value - inst.amount
           else
             current_value
           end

  registers[target_key] = result.to_i16
  registers
end

instructions = [] of Instruction

File.each_line path do |line|
  instruction = parse_line line
  instructions << instruction
end

registers = {} of String => Int16

registers = instructions.reduce registers do |acc, inst|
  if condition_passes?(acc, inst)
    apply_instruction(inst, acc)
  else
    acc
  end
end

result = registers.values.max

puts result
