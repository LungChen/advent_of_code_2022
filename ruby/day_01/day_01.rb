
class Elf
  def initialize(calories)
    @calories = calories
  end

  def sum_calories
    @calories.sum
  end
end

input = File.read('./input')
elfs = 
  input.split("\n\n").map do |calories|
    Elf.new(calories.split("\n").map(&:to_i))
  end

elfs_calories = elfs.map do |elf|
  elf.sum_calories
end

puzzle_1 = elfs_calories.max

puts "puzzle_1 = #{puzzle_1}"

puzzle_2 = elfs_calories.sort.reverse.take(3).sum

puts "puzzle_2 = #{puzzle_2}"