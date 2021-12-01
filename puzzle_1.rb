require 'csv'

file = CSV.read('puzzle_1.csv')

def get_depth_list(filename)
  depth_list = []
  
  for number in filename
    depth_list.push(number.first.to_i)
  end
  
  depth_list
end

depth_file = get_depth_list(file)

def count_increases(depth_list)
  num_increases = 0
  previous = depth_list.first

  for depth in depth_list do
    if depth > previous
      num_increases += 1
    end

    previous = depth
  end

  num_increases
end

puts "Number of increases from previous depth: #{count_increases(depth_file)}"