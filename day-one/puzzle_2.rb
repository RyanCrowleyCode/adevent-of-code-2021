file = File.readlines('day_one.csv')

def get_depth_list(rows)
  depth_list = []

  depth_list = rows.map do | row |
    row.to_i
  end

  depth_list
end

depth_file = get_depth_list(file)

def count_sum_increases(depth_list)
    increases = 0
    previous = nil

    depth_list.each_cons(3) do | row | # This checks every grouping of 3, shifting one at a time
        sum = row.sum
        increases += 1 if !previous.nil? && sum > previous
        previous = sum
    end

    increases
end

puts count_sum_increases(depth_file)
