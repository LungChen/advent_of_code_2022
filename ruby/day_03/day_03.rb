class Backpack
  attr_reader :items

  def initialize(input)
    half_length = input.size/2
    @first = input[0, half_length].each_char.to_a
    @second = input[half_length, half_length].each_char.to_a
    @items = @first + @second
  end

  def intersecption
    (@first & @second).uniq
  end
end

class Group
  attr_reader :label, :backpacks
  def initialize(backpacks)
    @backpacks = backpacks
    @label = @backpacks[0].items & @backpacks[1].items & @backpacks[2].items
    @label = @label.first
  end
end 

class CharToPriority
  def self.get(char)
    case char
    when /[a-z]/
      char.ord - 96
    when /[A-Z]/
      char.ord - 38
    end
  end
end

input = File.readlines('./input').map(&:strip)

backpacks = 
  input.map do |line|
    Backpack.new(line)
  end

intersecptions = backpacks.map(&:intersecption).flatten

puzzle_1 = intersecptions.sum do |i| CharToPriority.get(i) end

puts "puzzle_1: #{puzzle_1}"

line_index = 0
backpacks = []
groups = [] 

input.each do |line|
  line_index += 1
  backpacks << Backpack.new(line)
  if line_index % 3 == 0
    groups << Group.new(backpacks) 
    backpacks = []
  end
end

puzzle_2 = groups.sum do |group| CharToPriority.get(group.label) end

puts "puzzle_2: #{puzzle_2}"

