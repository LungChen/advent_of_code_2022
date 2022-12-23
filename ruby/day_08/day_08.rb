origin = File.readlines('./input').map do |line|
  line.strip.each_char.map(&:to_i)
end

width = origin[0].size
height = origin.size

transpose = origin.transpose

x_index = width -1
y_index = height -1

result = (0..y_index).map do |y|
  (0..x_index).map do |x|
    if x == 0 || y == 0 || x == x_index || y == y_index
      true
    else
      current = origin[y][x] # transpose[x][y]
      next true if origin[y][0..(x-1)].max < current # left max
      next true if origin[y][(x+1)..x_index].max < current # right max
      next true if transpose[x][0..(y-1)].max < current # up max
      next true if transpose[x][(y+1)..y_index].max < current # down max

      false
    end
  end
end

puzzle_1 = result.flatten.count{|x| x}
puts "puzzle_1: #{puzzle_1}"

result = (0..y_index).map do |y|
  (0..x_index).map do |x|
    current = origin[y][x] # transpose[x][y]
    next 0 if x == 0 || y == 0 || x == x_index || y == y_index

    left = origin[y][0..(x-1)].reverse.find_index { |t| t >= current }
    left = left.nil? ? x : left + 1

    right = origin[y][(x+1)..x_index].find_index { |t| t >= current } 
    right = right.nil? ? (x_index - x) : right + 1

    up = transpose[x][0..(y-1)].reverse.find_index { |t| t >= current }
    up = up.nil? ? y : up + 1

    down = transpose[x][(y+1)..y_index].find_index { |t| t >= current }
    down = down.nil? ? (y_index - y) : down + 1

    left * right * up * down
  end
end

puzzle_2 = result.flatten.max
puts "puzzle_2: #{puzzle_2}"