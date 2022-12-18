class Movement
  attr_reader :move, :from, :to

  def self.match(input)
    /move\ ([0-9]+)\ from\ ([0-9]+)\ to ([0-9]+)/.match(input)
  end

  def initialize(match)
    @move = match[1].to_i
    @from = match[2].to_i
    @to = match[3].to_i
  end
end

def get_stacks(lines)
  stack_size = lines[0].size/4 # one stack = 4 size
  stacks = Hash.new do |h, k| h[k] = [] end
  
  lines.each do |line|
    break if line[1].to_i != 0  
  
    (1..stack_size).each do |i|
      char = line[4*(i-1) + 1]
      stacks[i] if stacks[i].nil? # to correct order
      stacks[i].unshift(char) if char != " "
    end
  end
  stacks
end

def crate_mover_9000(stacks, movements)
  movements.each do |m|
    moved = stacks[m.from].pop(m.move).reverse
    stacks[m.to].push(moved).flatten!
  end
  stacks.values.map(&:last).join('')
end

def crate_mover_9001(stacks, movements)
  movements.each do |m|
    moved = stacks[m.from].pop(m.move)
    stacks[m.to].push(moved).flatten!
  end
  stacks.values.map(&:last).join('')
end

input = File.readlines('./input')
stacks = get_stacks(input)

movements = []
input.each do |line|
  match = Movement.match(line)
  movements << Movement.new(match) if match
end

puzzle_1 = crate_mover_9000(stacks, movements)

puts "puzzle_1: #{puzzle_1}"

stacks = get_stacks(input)
puzzle_2 = crate_mover_9001(stacks, movements)

puts "puzzle_2: #{puzzle_2}"