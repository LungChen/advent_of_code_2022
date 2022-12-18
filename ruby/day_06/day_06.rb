def start_at(input, check_size)
  arr = input.each_char.to_a
  for i in (0..input.size - check_size)
    if arr[i, check_size].uniq.size == check_size
      return i + check_size
    end
  end
end

input = File.read('./input')

puzzle_1 = start_at(input, 4)

puts "puzzle_1: #{puzzle_1}"

puzzle_2 = start_at(input, 14)

puts "puzzle_2: #{puzzle_2}"