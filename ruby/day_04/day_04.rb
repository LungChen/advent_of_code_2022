class SectionPair
  # attr_reader :range1, :range2
  def initialize(input)
    match = /([0-9]+)\-([0-9]+),([0-9]+)\-([0-9]+)/.match(input)
    @range1 = match[1].to_i..match[2].to_i
    @range2 = match[3].to_i..match[4].to_i
  end

  def total_overlap?
    (@range1.begin <= @range2.begin && @range1.end >= @range2.end) || 
      (@range2.begin <= @range1.begin && @range2.end >= @range1.end)
  end

  def any_overlap?
    (@range1.begin <= @range2.begin && @range1.end >= @range2.begin) ||
      (@range2.begin <= @range1.begin && @range2.end >= @range1.begin)
  end
end

input = File.readlines('./input')

section_pairs = input.map do |line|
    SectionPair.new(line)
  end

puzzle_1 = section_pairs.count do |s| s.total_overlap? end

puts "puzzle_1: #{puzzle_1}"

puzzle_2 = section_pairs.count do |s| s.any_overlap? end

puts "puzzle_2: #{puzzle_2}"


    
  