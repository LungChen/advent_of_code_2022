class File
  attr_reader :name, :size
  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Directory
  attr_reader :files, :parent, :name, :files_size, :total_size
  attr_accessor :children

  def initialize(name, parent)
    @name = name
    @parent = parent
    @total_size = 0
    @children = []
  end

  def find_children(name)
    @children.find { |d| d.name == name }
  end

  def add_file(name, size)
    @files ||= []
    @files << File.new(name, size)
    @total_size += size
    return if @parent.nil?

    @parent.add_size(size)
  end

  def add_size(size)
    @total_size += size
    return if @parent.nil?

    @parent.add_size(size)
  end

  def <=>(other)
    @total_size <=> other.total_size
  end
end

lines = File.readlines('./input')

directories = []
directories << Directory.new('/', nil)
current_dir = directories.first

lines.each do |line|
  case line
  when /\$ cd ([\w\/\.]+)/
    match = /\$ cd ([\w\/\.]+)/.match(line)
    dir_name = match[1]
    
    if dir_name == '..'
      current_dir = current_dir.parent
    elsif dir_name == '/'
      current_dir = directories.find { |d| d.name == dir_name }
    else
      current_dir = current_dir.find_children(dir_name)
    end
  when /dir (\w+)/
    match = /dir (\w+)/.match(line)
    dir_name = match[1]
    dir = Directory.new(dir_name, current_dir)
    directories << dir
    current_dir.children << dir
  when /(\d+) (\w+\.*\w*)/
    match = /(\d+) (\w+\.*\w*)/.match(line)
    name = match[2]
    size = match[1].to_i
    current_dir.add_file(name, size)
  end
end

puzzle_1 = directories.select{|d| d.total_size < 100000}.sum(&:total_size)
puts "puzzle_1: #{puzzle_1}"

available = 70000000 - directories.find {|d| d.name == '/'}.total_size
need_free_up = 30000000 - available
puzzle_2 = directories.sort.find {|d| d.total_size >= need_free_up}.total_size

puts "puzzle_2: #{puzzle_2}"

