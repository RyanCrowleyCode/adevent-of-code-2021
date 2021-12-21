################ Getting the data ##########################
file = File.read("day_nine.csv").split("\n")

@height_array = []

def set_height_array(file)
    file.each do |row|
        new_row = []
        
        row.split("").each do |number_string|
            new_row.push(number_string.to_i)
        end

        @height_array.push(new_row)
    end
end

set_height_array(file)
@num_rows = @height_array.length

@basin_hash = Hash.new

################ Solving the problem ########################## 

def find_basins
    basin_tally = 1
    
    @height_array.each_with_index do |row, row_index|
        @row_length ||= row.length
        
        row.each_with_index do |height, height_index|
            coordinate_array = []
            coordinate_array = look_right(row, height_index, row_index)
            coordinate_array += look_down(height_index, row_index)

            basin_number_list = find_basin_number(coordinate_array)
            if (basin_number_list.length == 0) && (coordinate_array.length > 0)
                basin_number_list.push(basin_tally)
                basin_tally += 1
            end

            # factoring for more complicated basin patterns, re-assigning basin numbers.
            if (basin_number_list.length > 1)
                @basin_hash.each do |key, value|
                    if basin_number_list.include?(value)
                        @basin_hash[key] = basin_number_list.first
                    end
                end
            end

            coordinate_array.each do |coordinate|
                @basin_hash[coordinate] = basin_number_list.first
            end
        end
    end
end

def look_right(row, height_index, row_index)
    coordinate_array = []
    range = (height_index..(@row_length -1))

    range.each do |horizontal_position|
        if row[horizontal_position] == 9
            break
        end
        coordinate_array.push("#{horizontal_position}, #{row_index}")
    end
    coordinate_array
end

def look_down(height_index, row_index)
    coordinate_array = []
    range = (row_index..(@num_rows -1))

    range.each do |verticle_position|
        if @height_array[verticle_position][height_index] == 9
            break
        end
        coordinate_array.push("#{height_index}, #{verticle_position}")
    end
    coordinate_array
end

def find_basin_number(coordinate_array)
    possible_basin_numbers = []
    coordinate_array.each do |coordinate|
        if @basin_hash.has_key?(coordinate)
            possible_basin_numbers.push(@basin_hash[coordinate])
        end
    end
    
    possible_basin_numbers
end

def find_basin_sizes
    @basin_sizes = Hash.new
    @basin_hash.each do |key, value|
        if @basin_sizes.has_key?(value.to_s)
            @basin_sizes[value.to_s] += 1
        else
            @basin_sizes[value.to_s] = 1
        end
    end
end

def multiply_3_largest_basins
    find_basins
    find_basin_sizes
    sorted_basin_sizes = @basin_sizes.values.sort.reverse
    return (sorted_basin_sizes[0]) * (sorted_basin_sizes[1]) * (sorted_basin_sizes[2])
end


################ Showing the Answer ##########################

puts multiply_3_largest_basins